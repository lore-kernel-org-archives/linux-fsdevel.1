Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB0133993
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058195; cv=none; b=V9BukomoFvOZm+5JtdCSMpjf9fSEYgYdObKWVqslen0GFivur5IMgUC3V4ftncTBSzblIv6VJfVjJQEylVWY98j2cq/ViPLtQfhiiS2ysXlDgOAmJV2dA8PmnjRqMWC0acs9qnzIX/krFzx6Mf1yTj6zf6xFj14EtNEawOi+lwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058195; c=relaxed/simple;
	bh=usFyeP2w3LNQDq97dasDYJuHhSxj1i4SXVo88kiujRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1bpIupiYIMb8BkmjPbT2P5/4Pp9gvia3UXkgSyG2o3C1IHIjd6L15v5UhGK60F0Ivx5/akKLNDdyNOALNzYk8clMNX8F2jI3ustZO+QZ0LrsOwdbbeo80nTGazYDOAzFupIrM8tfmScjtqk/CJG+tdHQJXz2wjNG9c4SbIXstA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jjsu6Mlv; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jjsu6Mlv"
Message-ID: <fb47629e-6533-4c87-ac0b-e3a48a890ef4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780058181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lVmfgexspnKoW/3agaiDvDisr/iv75bUoYrdSLOXwE=;
	b=jjsu6MlvrjBVw8EHwN0hZmMlYdVyXnIGj7OspJTJ4D6N+7yBnvman4zcAHpc1Ij97Gm08b
	r/smJSHm1710yMUCteZUE0tkdOltvNb2M1Yl3SZ4d9zzKBzaKOzUGwE6mp49+rBFiVdWRH
	JYU2SGHM12nodC78Fy/TqrlxlFyboI8=
Date: Fri, 29 May 2026 13:36:10 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 2/2] mm: use mapping_max_folio_order() for
 force_thp_readahead order
To: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 willy@infradead.org, ryan.roberts@arm.com, linux-mm@kvack.org
Cc: r@hev.cc, jack@suse.cz, Andrew Donnellan <andrew+kernel@donnellan.id.au>,
 apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 brauner@kernel.org, catalin.marinas@arm.com, dev.jain@arm.com,
 kees@kernel.org, kevin.brodsky@arm.com, lance.yang@linux.dev,
 "Liam R. Howlett" <liam@infradead.org>,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, ljs@kernel.org, mhocko@suse.com,
 npache@redhat.com, pasha.tatashin@soleen.com, rmclure@linux.ibm.com,
 rppt@kernel.org, surenb@google.com, vbabka@kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, ziy@nvidia.com, hannes@cmpxchg.org,
 kas@kernel.org, shakeel.butt@linux.dev, kernel-team@meta.com
References: <20260528165635.2068012-1-usama.arif@linux.dev>
 <20260528165635.2068012-3-usama.arif@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260528165635.2068012-3-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 28/05/2026 17:55, Usama Arif wrote:
> The force_thp_readahead path in do_sync_mmap_readahead() is gated on
> HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER and always requests
> HPAGE_PMD_ORDER / HPAGE_PMD_NR. On configurations where HPAGE_PMD_ORDER
> exceeds MAX_PAGECACHE_ORDER, notably arm64 with a 64K base page size,
> VM_HUGEPAGE mappings cannot use this path and fall back to the non-forced
> mmap readahead path even when the mapping supports useful large folios.
> 
> Keep the existing PMD-sized behavior when HPAGE_PMD_ORDER fits in the
> page cache. When it does not, enable forced readahead for mappings that
> support large folios and request an order capped by both
> mapping_max_folio_order(mapping) and 2MB.
> 
> 2MB is chosen as the cap because it matches the PMD size on x86_64
> and on arm64 with 4K or 16K base pages, so the size/memory-pressure
> tradeoff for folios of that size is already well understood. On arm64
> with a 64K base page size, 2MB is also the contiguous-PTE (contpte)
> block size, so the resulting folios coalesce into a single TLB entry
> and reduce TLB pressure on the readahead path.
> 
> The final allocation order may still be clamped by page_cache_ra_order()
> to the mapping and request geometry, but this gives VM_HUGEPAGE mappings
> on such configurations a large-folio readahead request instead of
> dropping back to base-page readahead.
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  mm/filemap.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index a16b33e0fc71..bfb891d9da1f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3312,14 +3312,23 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	struct file *fpin = NULL;
>  	vm_flags_t vm_flags = vmf->vma->vm_flags;
>  	bool force_thp_readahead = false;
> +	unsigned int thp_order = 0;
>  	unsigned short mmap_miss;
>  
>  	ractl._max_index = vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1;
>  
>  	/* Use the readahead code, even if readahead is disabled */
> -	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> -	    (vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER)
> -		force_thp_readahead = true;
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && (vm_flags & VM_HUGEPAGE)) {
> +		if (HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
> +			force_thp_readahead = true;
> +			thp_order = HPAGE_PMD_ORDER;
> +		} else if (mapping_large_folio_support(mapping)) {
> +			force_thp_readahead = true;
> +			thp_order = min_t(unsigned int,
> +					  mapping_max_folio_order(mapping),
> +					  get_order(SZ_2M));
> +		}
> +	}
>  

I think might be good to include the below comment to explain the decision being made
here:

From 6673c04a434df01d449c1bdb9ac8de74e19d6b7e Mon Sep 17 00:00:00 2001
From: Usama Arif <usama.arif@linux.dev>
Date: Fri, 29 May 2026 05:31:05 -0700
Subject: [PATCH] [fixlet] mm/filemap: add comment explaining design decision

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/filemap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index bfb891d9da1f..0a3facf452b3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3319,6 +3319,14 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 
 	/* Use the readahead code, even if readahead is disabled */
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && (vm_flags & VM_HUGEPAGE)) {
+		/*
+		 * Preserve PMD-sized readahead where it already fits in
+		 * the page cache. Otherwise cap the new fallback path at
+		 * 2MB: this is the common PMD-sized hugepage size, and it
+		 * avoids memory pressure from very large forced readahead
+		 * when mapping_max_folio_order() is high (for example,
+		 * 128MB with 64K base pages on arm64).
+		 */
 		if (HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
 			force_thp_readahead = true;
 			thp_order = HPAGE_PMD_ORDER;
-- 
2.53.0-Meta


