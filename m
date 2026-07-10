Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA722ECE86
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695332; cv=none; b=TiFiLU+6OvSAX6QsUuFkleJQ1Tc1HQHRPYXlAZU7Qbm4JnCn3lRCWdI7FaDlUV/6/XHG1zeRpys91JjqwuMF6AbcV0aYr0UmB56QZ1ZdGVqDhgWAKfFSflQnwELS+647pWRHDjkCwPLI1BHq4UYkv3oqWK/82wjD9t0IvJxjyYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695332; c=relaxed/simple;
	bh=jyye1dK01VKTo6tFwj8BtY0uj5dCDd6s0lMDTqJgW9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGC6c+3rVnENn1FoRemZGChhsZf6xnXA49Nxp/hEHwD0yHUAqsyVI/yoESgzeLo86O0IvuCxcmKmEeBkaszLXwS+J9833aAWxI4pF8JhoSG7km/ifpgYMpkdvpPzAvwZXwI9uOJv9+hdhlyfNxK9ZyJfQjrgqefFZh5EZ4s9kEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fGyXMR06; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fGyXMR06"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783695328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fy3HvPYERYOqHKmADP27Z6ZkjciyXUnr8qNN8o2XjUs=;
	b=fGyXMR064tcSGEiL7ZJCkwjrUPXiTV3PC8VGFVxUFYXjtZCczyoRfE9Jk7biyIW2o8UmeS
	jeWD/ZaGCrz5k3IPSntW3fAFXoFnOwVVYkVHMwVYHRC/BU319ZjGcM1subEkpzhXcdQlem
	AI04lSdQzYt0VufhKtL9NiRsgZdBios=
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
Subject: Re: [PATCH v2 05/10] memory-failure: Remove raw_hwp_list_head()
Date: Fri, 10 Jul 2026 07:55:21 -0700
Message-ID: <20260710145522.1718437-1-usama.arif@linux.dev>
In-Reply-To: <20260709184740.1286561-6-willy@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu,  9 Jul 2026 19:47:33 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> There's no need to hide the llist_head; we can just declare it
> directly in struct folio and do away with raw_hwp_list_head().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm_types.h |  4 ++--
>  mm/memory-failure.c      | 19 +++++--------------
>  2 files changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index b18c2b2e7d2c..d46f81f94848 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -387,7 +387,7 @@ typedef unsigned short mm_id_t;
>   * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
>   * @_hugetlb_cgroup: Do not use directly, use accessor in hugetlb_cgroup.h.
>   * @_hugetlb_cgroup_rsvd: Do not use directly, use accessor in hugetlb_cgroup.h.
> - * @_hugetlb_hwpoison: Do not use directly, call raw_hwp_list_head().
> + * @_hugetlb_hwpoison: Raw error pages, see struct raw_hwp_page.

s/_hugetlb_hwpoison/hugetlb_hwpoison/ in the doc above, apart
from that, LGTM.

Also good to add No functional change intended in the commit message.

Acked-by: Usama Arif <usama.arif@linux.dev>

>   * @_deferred_list: Folios to be split under memory pressure.
>   * @_unused_slab_obj_exts: Placeholder to match obj_exts in struct slab.
>   *
> @@ -499,7 +499,7 @@ struct folio {
>  			void *_hugetlb_subpool;
>  			void *_hugetlb_cgroup;
>  			void *_hugetlb_cgroup_rsvd;
> -			void *_hugetlb_hwpoison;
> +			struct llist_head hugetlb_hwpoison;
>  	/* private: the union with struct page is transitional */
>  		};
>  		struct page __page_3;
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 51508a55c405..53063e2a1f97 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1810,21 +1810,15 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
>  
>  /*
>   * Struct raw_hwp_page represents information about "raw error page",
> - * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
> + * constructing singly linked list from folio->hugetlb_hwpoison field.
>   */
>  struct raw_hwp_page {
>  	struct llist_node node;
>  	struct page *page;
>  };
>  
> -static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
> -{
> -	return (struct llist_head *)&folio->_hugetlb_hwpoison;
> -}
> -
>  bool is_raw_hwpoison_page_in_hugepage(struct page *page)
>  {
> -	struct llist_head *raw_hwp_head;
>  	struct raw_hwp_page *p;
>  	struct folio *folio = page_folio(page);
>  	bool ret = false;
> @@ -1844,8 +1838,7 @@ bool is_raw_hwpoison_page_in_hugepage(struct page *page)
>  
>  	mutex_lock(&mf_mutex);
>  
> -	raw_hwp_head = raw_hwp_list_head(folio);
> -	llist_for_each_entry(p, raw_hwp_head->first, node) {
> +	llist_for_each_entry(p, folio->hugetlb_hwpoison.first, node) {
>  		if (page == p->page) {
>  			ret = true;
>  			break;
> @@ -1863,7 +1856,7 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
>  	struct raw_hwp_page *p, *next;
>  	unsigned long count = 0;
>  
> -	head = llist_del_all(raw_hwp_list_head(folio));
> +	head = llist_del_all(&folio->hugetlb_hwpoison);
>  	llist_for_each_entry_safe(p, next, head, node) {
>  		if (move_flag)
>  			SetPageHWPoison(p->page);
> @@ -1887,7 +1880,6 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
>   */
>  static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
>  {
> -	struct llist_head *head;
>  	struct raw_hwp_page *raw_hwp;
>  	struct raw_hwp_page *p;
>  	int ret = folio_test_set_hwpoison(folio) ? MF_HUGETLB_FOLIO_PRE_POISONED : 0;
> @@ -1899,8 +1891,7 @@ static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
>  	 */
>  	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
>  		return MF_HUGETLB_FOLIO_PRE_POISONED;
> -	head = raw_hwp_list_head(folio);
> -	llist_for_each_entry(p, head->first, node) {
> +	llist_for_each_entry(p, folio->hugetlb_hwpoison.first, node) {
>  		if (p->page == page)
>  			return MF_HUGETLB_PAGE_PRE_POISONED;
>  	}
> @@ -1908,7 +1899,7 @@ static int hugetlb_update_hwpoison(struct folio *folio, struct page *page)
>  	raw_hwp = kmalloc_obj(struct raw_hwp_page, GFP_ATOMIC);
>  	if (raw_hwp) {
>  		raw_hwp->page = page;
> -		llist_add(&raw_hwp->node, head);
> +		llist_add(&raw_hwp->node, &folio->hugetlb_hwpoison);
>  	} else {
>  		/*
>  		 * Failed to save raw error info.  We no longer trace all
> -- 
> 2.47.3
> 
> 
