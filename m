Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52F03F20E4
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 14:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779721084; cv=none; b=fk8KpLydRL3b0OXRTNaNkTIR/0Iv6DI92atkkZEEZdjxMZte96PiKpV07jmcSeOZ+eZNohHf1an0jHMTSUWWSZaAAfH3OKpDNiJZ3jEVkOpK1SxTWzqWwWjTNqAgmZT+Q+zPm+egnafZWUreAP3webcdOMDqz0rAl3kewLtotFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779721084; c=relaxed/simple;
	bh=MnKo4XIq4kXlUq+SnaCGu9YxR/BDe077y2SVa0ho314=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AxyKNoLlnXQTGiYLZ1OWLaBod0FyZdn7pCcSiq3ILulHHL6HX4JBzpuxGCEvZ3sZ30aGjXEJauX+fFLTqIhVZB9DvrQUt6HvvSOBmKWsnDJsx28HfkAjyoWRUNU4V69HympGnDhzWqTq+p+hYNURbqrq3oOv2BxhS+82QEUbKG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dhw9rzwZ; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dhw9rzwZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779721078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fl57Ady6J/3/I/Lz0zKZ4/vMXEK3F3tyaeoZhQFZ73M=;
	b=Dhw9rzwZEUbDdhxSLI5HfhEQ/j1sgVyG1jehGc9eIYhUwabxAyasFX0LpXESkHtuEmJe65
	NYtTfr+kbM8Lp9muiWBelV0+xWGNcp5kIc9TO3LLIRSo1KD2cKM4zd78k8Ce3QfLSaNtvs
	sDyFye7xTf/wJlMhJ1KHFIWnkEZLdaw=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org,
	david@kernel.org
Cc: hannes@cmpxchg.org,
	kas@kernel.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH] mm: make mmap_miss accounting symmetric for VM_SEQ_READ
Date: Mon, 25 May 2026 07:57:51 -0700
Message-ID: <20260525145751.2671248-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

do_sync_mmap_readahead() skips both the mmap_miss increment and the
MMAP_LOTSAMISS check for VM_SEQ_READ mappings, since sequential access
is non-speculative and should always read ahead. The two decrement
sites in do_async_mmap_readahead() and filemap_map_pages() do not
mirror this skip, so concurrent faults on a VM_SEQ_READ mapping can
still drive ra->mmap_miss down to zero through the decrement paths
even though nothing in the sync path ever increments it. The counter
itself is per-file (file->f_ra.mmap_miss), so it can be moved by any
VMA mapping the file, not just the one currently faulting.

Skip the decrement for VM_SEQ_READ in both decrement sites so the
counter only moves for mappings that also participate in the
increment side. No functional change for VM_SEQ_READ users, since the
increment-side gate already prevents the counter from being consulted
on their behalf, but it stops a VM_SEQ_READ mapping from biasing the
counter for other mappings of the same file.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/filemap.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5aaba0d3e81d..cca20e350c95 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3433,8 +3433,13 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	 * Don't touch the mmap_miss counter to avoid decreasing it multiple
 	 * times for a single folio and break the balance with mmap_miss
 	 * increase in do_sync_mmap_readahead().
+	 *
+	 * VM_SEQ_READ mappings skip the mmap_miss increment in
+	 * do_sync_mmap_readahead(), so skip the decrement here as well to
+	 * keep the counter symmetric.
 	 */
-	if (likely(!folio_test_locked(folio))) {
+	if (likely(!folio_test_locked(folio)) &&
+	    !(vmf->vma->vm_flags & VM_SEQ_READ)) {
 		mmap_miss = READ_ONCE(ra->mmap_miss);
 		if (mmap_miss)
 			WRITE_ONCE(ra->mmap_miss, --mmap_miss);
@@ -3935,10 +3940,15 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		 * In such situation, read-ahead is only a waste of IO.
 		 * Don't decrease mmap_miss in this scenario to make sure
 		 * we can stop read-ahead.
+		 *
+		 * VM_SEQ_READ mappings skip the mmap_miss increment in
+		 * do_sync_mmap_readahead(), so skip the decrement here as
+		 * well to keep the counter symmetric.
 		 */
 		if ((map_ret & VM_FAULT_NOPAGE) &&
 		    !(vmf->flags & FAULT_FLAG_TRIED) &&
-		    !folio_test_workingset(folio)) {
+		    !folio_test_workingset(folio) &&
+		    !(vma->vm_flags & VM_SEQ_READ)) {
 			unsigned short mmap_miss;
 
 			mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
-- 
2.52.0

