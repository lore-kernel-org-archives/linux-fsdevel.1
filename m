Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ABC3988FB
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 10:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309351; cv=none; b=Hdd0mLt2yYRcjz2o3I3vc4o9175bZKYqpeYXBl2TmUdzg7jgteFi1gojFA1BOg2HxmVOHHQH7+pd5uMBwynhzpWU4Owv30J00imKvlQczXeiGMnJlJrbN7hWf/0pZ7cvcJtOM/QvK7LNxtsQNwa2pzXIXqyI6EhXtObSVVbBiP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309351; c=relaxed/simple;
	bh=vMBTbZD/lSHEHatgPrv4IJ3lUE+xbmEaPFoEDjImcNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBkngc8S9+pkNHReqI5v7nmuYIR6BWoh0cyvoXRp9ILMzPGMffErrah/OvHNVDomqMP9jJLptQlD0QWAuBvvvZdKsPqNaqw0ZO/KZXMqkyQUPWDlU0IHgjJziPHEeQBNGU4cAfnrHLzrb5lfwPYEaSlBwrT9abaZKg8w+vHDCpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PvRsohE/; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PvRsohE/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780309345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ODVkNxNqhWTJOtKAdxjrGaooJs+N26LEMo3Jm83wAZk=;
	b=PvRsohE/ZO3afbXRx9ClOgEAbzgQczwO49YoCB7UQqiTfEVBmtIxaF8Vwuow2kGr0loz9v
	4wQPHODBVox1noVmxIaEZhk4PUwfCGWuvg+Uu3skr76sAsSqd72Z2jFbLzJ5KIADisNOXt
	uXoCMcINK8Ff2a53qPVmFtSnw/S+72g=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	willy@infradead.org,
	ryan.roberts@arm.com,
	linux-mm@kvack.org
Cc: pfalcato@suse.de,
	r@hev.cc,
	jack@suse.cz,
	Andrew Donnellan <andrew+kernel@donnellan.id.au>,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	dev.jain@arm.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	Liam R. Howlett <liam@infradead.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ljs@kernel.org,
	mhocko@suse.com,
	npache@redhat.com,
	pasha.tatashin@soleen.com,
	rmclure@linux.ibm.com,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	ziy@nvidia.com,
	hannes@cmpxchg.org,
	kas@kernel.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v7 1/2] mm: bypass mmap_miss heuristic for VM_EXEC readahead
Date: Mon,  1 Jun 2026 03:21:17 -0700
Message-ID: <20260601102205.3985788-2-usama.arif@linux.dev>
In-Reply-To: <20260601102205.3985788-1-usama.arif@linux.dev>
References: <20260601102205.3985788-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The mmap_miss heuristic is intended to stop speculative mmap readahead
when a file looks like a random-access workload. That does not fit the
VM_EXEC path very well.

VM_EXEC readahead is already constrained differently from ordinary mmap
read-around: it is bounded by the VMA, uses exec_folio_order() to choose
an order useful for executable mappings, and sets async_size to 0 so it
does not create follow-on readahead. When VM_HUGEPAGE is also present,
the larger readahead is an explicit userspace opt-in.

The mmap_miss counter is decremented from cache-hit paths in
do_async_mmap_readahead() and filemap_map_pages(). Those paths are not
always enough to balance the synchronous miss increments for executable
mappings. In particular, when fault-around is effectively disabled, such
as configurations where fault_around_pages is 1, filemap_map_pages() is
not reached from the fault path. The counter can then become a stale
throttle for VM_EXEC mappings and suppress the readahead behavior that
the executable-specific path is trying to provide.

Skip both mmap_miss increments and decrements for VM_EXEC mappings,
matching the existing VM_SEQ_READ treatment and keeping the counter
accounting symmetric.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/filemap.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index cca20e350c95..a16b33e0fc71 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3339,7 +3339,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		}
 	}
 
-	if (!(vm_flags & VM_SEQ_READ)) {
+	if (!(vm_flags & (VM_SEQ_READ | VM_EXEC))) {
 		/* Avoid banging the cache line if not needed */
 		mmap_miss = READ_ONCE(ra->mmap_miss);
 		if (mmap_miss < MMAP_LOTSAMISS * 10)
@@ -3434,12 +3434,12 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 	 * times for a single folio and break the balance with mmap_miss
 	 * increase in do_sync_mmap_readahead().
 	 *
-	 * VM_SEQ_READ mappings skip the mmap_miss increment in
+	 * VM_SEQ_READ and VM_EXEC mappings skip the mmap_miss increment in
 	 * do_sync_mmap_readahead(), so skip the decrement here as well to
 	 * keep the counter symmetric.
 	 */
 	if (likely(!folio_test_locked(folio)) &&
-	    !(vmf->vma->vm_flags & VM_SEQ_READ)) {
+	    !(vmf->vma->vm_flags & (VM_SEQ_READ | VM_EXEC))) {
 		mmap_miss = READ_ONCE(ra->mmap_miss);
 		if (mmap_miss)
 			WRITE_ONCE(ra->mmap_miss, --mmap_miss);
@@ -3941,14 +3941,14 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		 * Don't decrease mmap_miss in this scenario to make sure
 		 * we can stop read-ahead.
 		 *
-		 * VM_SEQ_READ mappings skip the mmap_miss increment in
-		 * do_sync_mmap_readahead(), so skip the decrement here as
-		 * well to keep the counter symmetric.
+		 * VM_SEQ_READ and VM_EXEC mappings skip the mmap_miss
+		 * increment in do_sync_mmap_readahead(), so skip the
+		 * decrement here as well to keep the counter symmetric.
 		 */
 		if ((map_ret & VM_FAULT_NOPAGE) &&
 		    !(vmf->flags & FAULT_FLAG_TRIED) &&
 		    !folio_test_workingset(folio) &&
-		    !(vma->vm_flags & VM_SEQ_READ)) {
+		    !(vma->vm_flags & (VM_SEQ_READ | VM_EXEC))) {
 			unsigned short mmap_miss;
 
 			mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
-- 
2.52.0

