Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9C6374187
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153633; cv=none; b=BtiVyQ5Mg7wQhsjl/ndYQgdCeBaSN1ok6el4nyB9Pp5vyF0kocMRcUhmbD/piaRGQRu0RfBx3rvt/7jet9a0EAdjahwoHdOlH8qfq+dApYxNz8Dtfg4jau0ugHMV3ecl2fr3/xoz/g+NAVJKZTN/yWapfwIrKJqw5xZzLWK/70o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153633; c=relaxed/simple;
	bh=9bMdSk6PdqEP4azCvFoAGa1R8mF32ukzVuJi0oHBvXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtkaEbiY6F+Wth6xilAiTRGOX4VeMoyBSbdlMl7jmFUTphSAWBWErex+05kgUodBRfUh3zdYgDGAJZNox7CSAPzsG2b+xaDlvfuwzo0pGh42M9O8A0xm6neB90HwdvXDZftPBjE37bA4zahMNW2OCdCwKS1gGP5drA/9U0PA+uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jBVlATxq; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jBVlATxq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775153624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BYo+MsU3NDEL+koHfyTJu1xHHS5mV0CFXLaMn8ZezZo=;
	b=jBVlATxqIYgZfj3KHFj3T3aVBW1J8ZhMacXVtFHk4eHh5FwgyqeygxWtikdiA+B1T7VuFg
	v/zAHoBUYT/h+us80bWmoIGHjJz8uEo/Um3mzOQJ7+5N9tE4RDgdtwmMVvyXBJ/TJ40i0J
	828uNtru0sPYXV9jPylnQLnOE7M8Y8c=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	willy@infradead.org,
	ryan.roberts@arm.com,
	linux-mm@kvack.org
Cc: r@hev.cc,
	jack@suse.cz,
	ajd@linux.ibm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	dev.jain@arm.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	Liam.Howlett@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	mhocko@suse.com,
	npache@redhat.com,
	pasha.tatashin@soleen.com,
	rmclure@linux.ibm.com,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	wilts.infradead.org,
	linux-fsdevel@vger.kernel.l@kernel.org,
	ziy@nvidia.com,
	hannes@cmpxchg.org,
	kas@kernel.org,
	shakeel.butt@linux.dev,
	leitao@debian.org,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v3 1/4] mm: bypass mmap_miss heuristic for VM_EXEC readahead
Date: Thu,  2 Apr 2026 11:08:22 -0700
Message-ID: <20260402181326.3107102-2-usama.arif@linux.dev>
In-Reply-To: <20260402181326.3107102-1-usama.arif@linux.dev>
References: <20260402181326.3107102-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The mmap_miss counter in do_sync_mmap_readahead() tracks whether
readahead is useful for mmap'd file access. It is incremented by 1 on
every page cache miss in do_sync_mmap_readahead(), and decremented in
two places:

  - filemap_map_pages(): decremented by N for each of N pages
    successfully mapped via fault-around (pages found already in cache,
    evidence readahead was useful). Only pages not in the workingset
    count as hits.

  - do_async_mmap_readahead(): decremented by 1 when a page with
    PG_readahead is found in cache.

When the counter exceeds MMAP_LOTSAMISS (100), all readahead is
disabled, including the targeted VM_EXEC readahead [1] that requests
large folio orders for contpte mapping.

On arm64 with 64K base pages, both decrement paths are inactive:

  1. filemap_map_pages() is never called because fault_around_pages
     (65536 >> PAGE_SHIFT = 1) disables should_fault_around(), which
     requires fault_around_pages > 1. With only 1 page in the
     fault-around window, there is nothing "around" to map.

  2. do_async_mmap_readahead() never fires for exec mappings because
     exec readahead sets async_size = 0, so no PG_readahead markers
     are placed.

With no decrements, mmap_miss monotonically increases past
MMAP_LOTSAMISS after 100 page faults, disabling all subsequent
exec readahead.

Fix this by excluding VM_EXEC VMAs from the mmap_miss logic, similar
to how VM_SEQ_READ is already excluded. The exec readahead path is
targeted (one folio at the fault location, async_size=0), not
speculative prefetch, so the mmap_miss heuristic designed to throttle
wasteful speculative readahead should not apply to it.

[1] https://lore.kernel.org/all/20250430145920.3748738-6-ryan.roberts@arm.com/

Signed-off-by: Usama Arif <usama.arif@linux.dev>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 2b933a1da9bd..a4ea869b2ca1 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3337,7 +3337,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		}
 	}
 
-	if (!(vm_flags & VM_SEQ_READ)) {
+	if (!(vm_flags & (VM_SEQ_READ | VM_EXEC))) {
 		/* Avoid banging the cache line if not needed */
 		mmap_miss = READ_ONCE(ra->mmap_miss);
 		if (mmap_miss < MMAP_LOTSAMISS * 10)
-- 
2.52.0

