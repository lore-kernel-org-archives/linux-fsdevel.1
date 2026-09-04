Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A818D414DF6
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 06:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788503736; cv=none; b=dJR4K4IVcH9bUl2xDDcHfQMsjcG3Ht4hwfBAvXSFCG5GkXIt02MW+V7DnIybRMSPczYpXkuRIWLPM03qxiy8NDeX0/L/Lyx8zx+qJ2QN+NdnbRlzH6pMOsLWyCDSKbMZMvRr0xDIq+arn6MqWGd/dGtwE3ZNI0Jwkwrgc+HjTfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788503736; c=relaxed/simple;
	bh=EP7De+zB/r6u3EMvKW/Ud3WEhoIrwG3NlguNDuSrN8w=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=si7jTWQkcORNImP3AYIUhVxdKNQcPYuaypMqoEocqAnG5ij6YXDg7OY/yAtU+mcS0RcJ4/m9Z33owrfdtjA9pi7AiHyCVJlqOfsSJLIf1WNwYvmBNNlJuB8HFPn25hmhsWzPpycu4Q8eTluQrswv+UyDDRaBc/IyurmqWtWl9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Eet5II5R; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Eet5II5R"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fF6LNCuoVbBObzYUgKk7cZ8m8ukuMYvaYR8zeXPtK3g=;
	b=Eet5II5R5ZK9PDhg0niWtrPvRSvCO9nKY3Mo8f6HVCSGNLibIIkpqZCt29LF4g9camfjCwW0X
	+GZqacOHuY5YrfaPWRppApaV3WcMNQSxZYWYjyMjqHI5miI2gEW1OL3BYAA9DtdqiC/8/2dqOSK
	KfSktQ6lKdcMEP091+oZ7Mk=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4hbmdw3zNfzmV91;
	Fri,  4 Sep 2026 14:24:36 +0800 (CST)
Received: from whupemk100004.china.huawei.com (unknown [7.152.185.74])
	by mail.maildlp.com (Postfix) with ESMTPS id DB63C4048B;
	Fri,  4 Sep 2026 14:35:27 +0800 (CST)
Received: from [10.173.124.160] (10.173.124.160) by
 whupemk100004.china.huawei.com (7.152.185.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 4 Sep 2026 14:35:26 +0800
Subject: Re: [PATCH v9 09/15] mm: Remove locking mf_mutex in
 is_raw_hwpoison_page_in_hugepage()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>, "Gregory Price (Meta)" <gourry@gourry.net>,
	Andrew Morton <akpm@linux-foundation.org>, Jane Chu <jane.chu@oracle.com>,
	<linux-mm@kvack.org>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-10-willy@infradead.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6c6968e8-b644-86d1-97d1-236170e9dc3c@huawei.com>
Date: Fri, 4 Sep 2026 14:35:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260805210557.1118966-10-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemk100004.china.huawei.com (7.152.185.74)

On 2026/8/6 5:05, Matthew Wilcox (Oracle) wrote:
> Sleeping in this kind of predicate is unexpected.  Add a new spinlock
> to protect access to the list, and turn it into a normal singly linked
> list now that it doesn't need to be a lockless list.
> 
> Rename is_raw_hwpoison_page_in_hugepage() to hugetlb_page_hwpoison()
> and make it take the folio (since the callers naturally have the folio).
> Also remove the handling of non-hugetlb folios and make the arguments
> const.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  fs/hugetlbfs/inode.c     |   4 +-
>  include/linux/hugetlb.h  |   5 +-
>  include/linux/mm_types.h |   4 +-
>  mm/memory-failure.c      | 101 ++++++++++++++++++++++-----------------
>  4 files changed, 61 insertions(+), 53 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index fbac554886c3..dbca3f713bbf 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -198,7 +198,7 @@ static size_t adjust_range_hwpoison(struct folio *folio, size_t offset,
>  	struct page *page = folio_page(folio, offset / PAGE_SIZE);
>  	size_t safe_bytes;
>  
> -	if (is_raw_hwpoison_page_in_hugepage(page))
> +	if (hugetlb_page_hwpoison(folio, page))
>  		return 0;
>  	/* Safe to read the remaining bytes in this page. */
>  	safe_bytes = PAGE_SIZE - (offset % PAGE_SIZE);
> @@ -206,7 +206,7 @@ static size_t adjust_range_hwpoison(struct folio *folio, size_t offset,
>  
>  	/* Check each remaining page as long as we are not done yet. */
>  	for (; safe_bytes < bytes; safe_bytes += PAGE_SIZE, page++)
> -		if (is_raw_hwpoison_page_in_hugepage(page))
> +		if (hugetlb_page_hwpoison(folio, page))
>  			break;
>  
>  	return min(safe_bytes, bytes);
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index e200c93088bc..ec604cee8d22 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1088,10 +1088,7 @@ void hugetlb_register_node(struct node *node);
>  void hugetlb_unregister_node(struct node *node);
>  #endif
>  
> -/*
> - * Check if a given raw @page in a hugepage is HWPOISON.
> - */
> -bool is_raw_hwpoison_page_in_hugepage(struct page *page);
> +bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page);
>  
>  static inline unsigned long huge_page_mask_align(struct file *file)
>  {
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index b18c2b2e7d2c..86a2d0fee557 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -387,7 +387,7 @@ typedef unsigned short mm_id_t;
>   * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
>   * @_hugetlb_cgroup: Do not use directly, use accessor in hugetlb_cgroup.h.
>   * @_hugetlb_cgroup_rsvd: Do not use directly, use accessor in hugetlb_cgroup.h.
> - * @_hugetlb_hwpoison: Do not use directly, call raw_hwp_list_head().
> + * @hugetlb_hwpoison: List of pages with hwpoison.
>   * @_deferred_list: Folios to be split under memory pressure.
>   * @_unused_slab_obj_exts: Placeholder to match obj_exts in struct slab.
>   *
> @@ -499,7 +499,7 @@ struct folio {
>  			void *_hugetlb_subpool;
>  			void *_hugetlb_cgroup;
>  			void *_hugetlb_cgroup_rsvd;
> -			void *_hugetlb_hwpoison;
> +			struct hwp_page *hugetlb_hwpoison;

It might be better to rename it as _hugetlb_hwpoison, i.e. with "_" prefix,
to keep the naming style consistant. Anyway:

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.
