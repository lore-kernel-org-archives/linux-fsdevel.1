Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AF5329395
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015453; cv=none; b=Qrzl5FwnqSz20KsHHlFy7AMDr1avk42Iicd0ESKt9FYQSLX+TYnpyV9OQP4AlmcTOL3BqGMUAt5pLdSPQySRsaQASoMpf+PlvtSo0s2CpchsUpK0/VlfWEYCmoRuNrCSvUL96MvldJj96GLCqS5qj2vK8mtRXp2MzXCZHIfUuKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015453; c=relaxed/simple;
	bh=eXQJxROWtE6pItXH+Mzw7lLxZwbDI2v4z01vKxM/vQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BdJ9iynJ4V/E53+9L2qLJo50Zx0BrmAG7BFk247F42pnnv8e8Rpgfo2mkuwsmN+w/I1P2VFBJc720kRMQVycc5TopROOSYIRt9/j82YH4zHP4OuSDyaYldRN9hVT+ZveH4ne/qiVIqGMUFf18JoAdvq4fAr4JKKUnL1IgR+F8I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NrVkySz8; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NrVkySz8"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774015447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OruWX6Y+VrnzFhcejZb+iVJL+JhqwtkaO5WVBgW6UjQ=;
	b=NrVkySz8XFBNwS4JdeWfeBofM4ytOBdZdZrAkUxNYCNGh3uxuRAPJ5YcoZEoeOwqFWU0CL
	f+YfK4i/Zn1/yHJ1X93vajWc3NlKybjlbIro8UCI06nC4kwGlmM9uk9uEpVJpjEETXdRI4
	Pbjc2GicF57gusHNd3E8jN/ghaAy2VM=
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
	lorenzo.stoakes@oracle.com,
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
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v2 1/4] mm: bypass mmap_miss heuristic for VM_EXEC readahead
Date: Fri, 20 Mar 2026 06:58:51 -0700
Message-ID: <20260320140315.979307-2-usama.arif@linux.dev>
In-Reply-To: <20260320140315.979307-1-usama.arif@linux.dev>
References: <20260320140315.979307-1-usama.arif@linux.dev>
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
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 6cd7974d4adab..7d89c6b384cc4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3331,7 +3331,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		}
 	}
 
-	if (!(vm_flags & VM_SEQ_READ)) {
+	if (!(vm_flags & (VM_SEQ_READ | VM_EXEC))) {
 		/* Avoid banging the cache line if not needed */
 		mmap_miss = READ_ONCE(ra->mmap_miss);
 		if (mmap_miss < MMAP_LOTSAMISS * 10)
-- 
2.52.0

