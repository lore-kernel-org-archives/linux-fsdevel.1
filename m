Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5532F231836;
	Thu, 18 Jun 2026 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799390; cv=none; b=i8xx09oJWUoIlNHHLYL1lPOcPijSpcVFCek8A8DevzNEbl+TbuK7O3Kb39UJ16cOEu86nhlkP0ZEIxUimVCCSDsHxojpWDHZw6OshUPJi3l+Cb7q/F0brMfkfC/alue2I9l6QlavyhFcItIVuDzr7MRudqpHIemC42h9VMsGXwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799390; c=relaxed/simple;
	bh=86NmraxvOIKFQjLHNQhu7sY0yW6+Q2B/vPG1D87UCc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h4aYK3fNnVxUCH939+XDQSVKffZoh9VBoPDJ/UWYhXNBgXVuHJSQcUiz45zhtG2w7TCb+PcpCVe7Wm7pKyA07TQfRopy2Hfir59LikG+f81zisiRXy2/Pi9mnWiAW/fwPR/rmWTGKkyOcJShfXKVBVuuqbOe38UpYuiDmY3Sij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jqQndy+R; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jqQndy+R"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781799376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1nA8ddpqn3sBSela2vYVrfvI6UDB/unaNSJzIV+XHpI=;
	b=jqQndy+RrKIlq05G3yP9DdrjzchOLnYIfMlf7J4K9RSosslKGLJ4EE7xGg2Dk3juCfY4GK
	S3C3WQx1mjMEsOeqwTCz3X+532Yhg5fIQtHhJwi+A/2ANwFqLlJ8eYmcAOKpGoJrE3ptlM
	Db6KlKw2gNfqqF5Q57AdC7kMM/SJUEg=
From: Usama Arif <usama.arif@linux.dev>
To: Jane Chu <jane.chu@oracle.com>
Cc: Usama Arif <usama.arif@linux.dev>,
	akpm@linux-foundation.org,
	willy@infradead.org,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	hughd@google.com,
	baolin.wang@linux.alibaba.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	lorenzo@kernel.org,
	rppt@kernel.org,
	peterx@redhat.com,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 07/11] hugetlb: replace filemap_lock_hugetlb_folio with filemap_lock_folio
Date: Thu, 18 Jun 2026 09:16:05 -0700
Message-ID: <20260618161606.4182915-1-usama.arif@linux.dev>
In-Reply-To: <20260617172534.1740152-8-jane.chu@oracle.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Wed, 17 Jun 2026 11:25:28 -0600 Jane Chu <jane.chu@oracle.com> wrote:

> The problem with filemap_lock_hugetlb_folio() is redundancy, replace
> it with the generic filemap_lock_folio().
> 
> Suggested-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  fs/hugetlbfs/inode.c    |  3 +--
>  include/linux/hugetlb.h | 12 ------------
>  mm/hugetlb.c            |  4 ++--
>  3 files changed, 3 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 02cb265a580e..6c883478f7e7 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -518,10 +518,9 @@ static void hugetlbfs_zero_partial_page(struct hstate *h,
>  					loff_t start,
>  					loff_t end)
>  {
> -	pgoff_t idx = start >> huge_page_shift(h);
>  	struct folio *folio;
>  
> -	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
> +	folio = filemap_lock_folio(mapping, start);

Do you need to do start >> PAGE_SHIFT over here?

>  	if (IS_ERR(folio))
>  		return;
>  
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index cae5cdd3ea00..e78d0f706681 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -824,12 +824,6 @@ static inline unsigned int blocks_per_huge_page(struct hstate *h)
>  	return huge_page_size(h) / 512;
>  }
>  
> -static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
> -				struct address_space *mapping, pgoff_t idx)
> -{
> -	return filemap_lock_folio(mapping, idx << huge_page_order(h));
> -}
> -
>  #include <asm/hugetlb.h>
>  
>  #ifndef is_hugepage_only_range
> @@ -1096,12 +1090,6 @@ static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio
>  	return NULL;
>  }
>  
> -static inline struct folio *filemap_lock_hugetlb_folio(struct hstate *h,
> -				struct address_space *mapping, pgoff_t idx)
> -{
> -	return NULL;
> -}
> -
>  static inline int isolate_or_dissolve_huge_folio(struct folio *folio,
>  						struct list_head *list)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ecd1d1322fda..5484e78fe72e 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5715,7 +5715,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
>  	 * before we get page_table_lock.
>  	 */
>  	new_folio = false;
> -	folio = filemap_lock_hugetlb_folio(h, mapping, idx);
> +	folio = filemap_lock_folio(mapping, vmf->pgoff);
>  	if (IS_ERR(folio)) {
>  		size = i_size_read(mapping->host) >> PAGE_SHIFT;
>  		if (vmf->pgoff >= size)
> @@ -6201,7 +6201,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>  
>  	if (is_continue) {
>  		ret = -EFAULT;
> -		folio = filemap_lock_hugetlb_folio(h, mapping, idx);
> +		folio = filemap_lock_folio(mapping, idx << huge_page_order(h));
>  		if (IS_ERR(folio))
>  			goto out;
>  		folio_in_pagecache = true;
> -- 
> 2.43.5
> 
> 
