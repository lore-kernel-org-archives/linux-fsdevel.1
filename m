Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AAE2BF002
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783693725; cv=none; b=FCz39+uja/zhemKb7RVouasOSSUdDKOC+5GgvOnjFQRb0CE9DHHu8g6r0UYCYYLNR074OrOZZbpYDyblQRBfD4ZtsTO6/WylJGhQMvkYZY1dKDTy4oSod6B9u5hg4U0mai3a45SREx/bPgYabkvbJ0DMNFfcCWp+TJYqyYZ3lvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783693725; c=relaxed/simple;
	bh=sWQZgyUXfkMDValBIcK30eh2A+oq4JHoZURtGaGTSTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjoaa7+SyqkcaNvTvi1GZtjtZfaBB6uH+qz0dOsXfIQ54TMpiDAy+qkuVTz+97uZOCYekJsxdYmceAfKs02gXpixLbj9CQX+CuN7KKpm7t7TAp7P5qJGQV7dSyFdGgXDZDDMDvS2ArgAKHGLQJIsX2x7+1bfjfRPCfQXIgGJJW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vImTPeQm; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vImTPeQm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783693720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVI0wKwZcMRAkfFls89Q4leIQKN8++xllYOWwnfSJLA=;
	b=vImTPeQmG/UA1/fUjhmz3EGnUrwCMZGdexqcLZwqHljlG611QkyO4ie10k3suo/dmLf2e9
	2fjr7pbnMLtbP2gEz7VUPX/h7tDH3JPzBM/TUojWaL41G2Ur3ViiuTFKK5LPlYnpW6EFCl
	dzxHo2ByetB/5IS446O8vwMywDGdQBo=
From: Usama Arif <usama.arif@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>,
	linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 02/10] hugetlb: Mark some function arguments as const
Date: Fri, 10 Jul 2026 07:28:34 -0700
Message-ID: <20260710142835.1099904-1-usama.arif@linux.dev>
In-Reply-To: <20260709184740.1286561-3-willy@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu,  9 Jul 2026 19:47:30 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> These functions do not modify their folio argument, so we can mark them
> as being const which will allow for some minor optimisations and let us
> mark other function arguments as being const in the future.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/hugetlb.h | 19 +++++++++----------
>  mm/hugetlb.c            |  2 +-
>  2 files changed, 10 insertions(+), 11 deletions(-)
> 

They all only seem to inspect state.

Acked-by: Usama Arif <usama.arif@linux.dev>


> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 2abaf99321e9..18661a7cdb37 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -165,7 +165,7 @@ bool hugetlbfs_pagecache_present(struct hstate *h,
>  				 struct vm_area_struct *vma,
>  				 unsigned long address);
>  
> -struct address_space *hugetlb_folio_mapping_lock_write(struct folio *folio);
> +struct address_space *hugetlb_folio_mapping_lock_write(const struct folio *folio);
>  
>  extern int movable_gigantic_pages __read_mostly;
>  extern int sysctl_hugetlb_shm_group __read_mostly;
> @@ -292,8 +292,7 @@ static inline unsigned long hugetlb_total_pages(void)
>  	return 0;
>  }
>  
> -static inline struct address_space *hugetlb_folio_mapping_lock_write(
> -							struct folio *folio)
> +static inline struct address_space *hugetlb_folio_mapping_lock_write(const struct folio *folio)
>  {
>  	return NULL;
>  }
> @@ -595,8 +594,8 @@ enum hugetlb_page_flags {
>  #ifdef CONFIG_HUGETLB_PAGE
>  #define TESTHPAGEFLAG(uname, flname)				\
>  static __always_inline						\
> -bool folio_test_hugetlb_##flname(struct folio *folio)		\
> -	{	void *private = &folio->private;		\
> +bool folio_test_hugetlb_##flname(const struct folio *folio)	\
> +	{	const void *private = &folio->private;		\
>  		return test_bit(HPG_##flname, private);		\
>  	}
>  
> @@ -616,7 +615,7 @@ void folio_clear_hugetlb_##flname(struct folio *folio)		\
>  #else
>  #define TESTHPAGEFLAG(uname, flname)				\
>  static inline bool						\
> -folio_test_hugetlb_##flname(struct folio *folio)		\
> +folio_test_hugetlb_##flname(const struct folio *folio)		\
>  	{ return 0; }
>  
>  #define SETHPAGEFLAG(uname, flname)				\
> @@ -727,7 +726,7 @@ static inline struct hugepage_subpool *subpool_inode(struct inode *inode)
>  	return HUGETLBFS_SB(inode->i_sb)->spool;
>  }
>  
> -static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio)
> +static inline struct hugepage_subpool *hugetlb_folio_subpool(const struct folio *folio)
>  {
>  	return folio->_hugetlb_subpool;
>  }
> @@ -857,7 +856,7 @@ static inline bool arch_has_huge_bootmem_alloc(void)
>  }
>  #endif
>  
> -static inline struct hstate *folio_hstate(struct folio *folio)
> +static inline struct hstate *folio_hstate(const struct folio *folio)
>  {
>  	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
>  	return size_to_hstate(folio_size(folio));
> @@ -1088,7 +1087,7 @@ static inline unsigned long huge_page_mask_align(struct file *file)
>  	return 0;
>  }
>  
> -static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio)
> +static inline struct hugepage_subpool *hugetlb_folio_subpool(const struct folio *folio)
>  {
>  	return NULL;
>  }
> @@ -1157,7 +1156,7 @@ static inline struct hstate *hstate_vma(struct vm_area_struct *vma)
>  	return NULL;
>  }
>  
> -static inline struct hstate *folio_hstate(struct folio *folio)
> +static inline struct hstate *folio_hstate(const struct folio *folio)
>  {
>  	return NULL;
>  }
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 571212b80835..cc8d98399913 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1775,7 +1775,7 @@ void init_new_hugetlb_folio(struct folio *folio)
>   * stable.  Due to locking order, we can only trylock_write.  If we can
>   * not get the lock, simply return NULL to caller.
>   */
> -struct address_space *hugetlb_folio_mapping_lock_write(struct folio *folio)
> +struct address_space *hugetlb_folio_mapping_lock_write(const struct folio *folio)
>  {
>  	struct address_space *mapping = folio_mapping(folio);
>  
> -- 
> 2.47.3
> 
> 
