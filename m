Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA28530DD2A;
	Fri, 19 Jun 2026 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781880565; cv=none; b=ZLzKTmHaKPn7kR7zDBVZbMOPXMYnwHGQQlfd35FMZEhAV759tOlqle+MsIAR7f2mLbkyRr3l+MznP6YB+Iv5i6afxIuEDaWAY5kUVPCvufdNat0jottkfL4qY6MqMze3TNASBZhI+Fs+OzaorTvI8i+dJmEyi9hLWg5LZD7nj10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781880565; c=relaxed/simple;
	bh=Nk2Xc0e6R17K+qz1lFZ/xKTD4DSBL8YEI+yJ21wHvHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRzgA1pinvU8RIrvSf2y0M2mrjwBGu98cFcl/mPJs+hHS8A9j1qNGf4u0hqV0oft4+h/Yy6KsJEGJ/ugKy31IqJGFHMdCvuZtHte653tRNKyz5zaL7z49l2gDFJdY/Wm/kgauva18CIFcXZzawVAC3sivRcvuCyHMar3GYdr2gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8j1vJZY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8j1vJZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C60B1F00A3A;
	Fri, 19 Jun 2026 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781880563;
	bh=JZzQor3YTBuoFfOZOMq4FcC3N6lSMdH+407qik7C3ug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=h8j1vJZYLLp2o2sJ2qneko+6a3NTR6mns+g6mZ8TqdGXK/bfgHLvCi+uhmhgH/Plf
	 ZYK9YRyriKZ0sUZgqJiseRMoXBXc4mGlcPv3h/KFg4R7j1iL8siRSvR7uQKhnLRauY
	 qbq6z24CY9A2H0GgclU7+wuy7dynqmmqLRetzSXTj+onlU5xlKMamuOt75lKEDoxjS
	 Mkdy4d90EYgRubuTRMsU7GTDID4lxzq1NFCrjVl5biH+oXzLNWb4g3Yzc99Lr/0otH
	 iYXNRFHdHn43sKMDbID2/j/Ctrdsa4YykBN5usZVmSnpcu6IGi6Vj1k6bogsHsRs/3
	 sBnwdnbD7F9JA==
Message-ID: <92b18f50-b35d-43f7-9e7e-377b498fcd9c@kernel.org>
Date: Fri, 19 Jun 2026 16:49:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] mm/memory-failure: make
 is_raw_hwpoison_page_in_hugepage() general purpose
To: Jane Chu <jane.chu@oracle.com>, akpm@linux-foundation.org
Cc: willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
 brauner@kernel.org, muchun.song@linux.dev, osalvador@suse.de,
 hughd@google.com, baolin.wang@linux.alibaba.com, linmiaohe@huawei.com,
 nao.horiguchi@gmail.com, lorenzo@kernel.org, rppt@kernel.org,
 peterx@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260617172534.1740152-1-jane.chu@oracle.com>
 <20260617172534.1740152-2-jane.chu@oracle.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260617172534.1740152-2-jane.chu@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/26 19:25, Jane Chu wrote:
> Make is_raw_hwpoison_page_in_hugepage() general for checking whether
> a given raw page within any kind of folio is HW poisoned. Thus,
> replace folio_test_hwpoison() with folio_contain_hwpoisoned_page().
> Also rename to is_raw_hwpoison_page_in_folio().
> 
> Signed-off-by: Jane Chu <jane.chu@oracle.com>
> ---
>  fs/hugetlbfs/inode.c    |  4 ++--
>  include/linux/hugetlb.h |  4 ++--
>  mm/memory-failure.c     | 12 ++++++++++--
>  3 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 78d61bf2bd9b..66520f7c53c6 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -198,7 +198,7 @@ static size_t adjust_range_hwpoison(struct folio *folio, size_t offset,
>  	struct page *page = folio_page(folio, offset / PAGE_SIZE);
>  	size_t safe_bytes;
>  
> -	if (is_raw_hwpoison_page_in_hugepage(page))
> +	if (is_raw_hwpoison_page_in_folio(page))
>  		return 0;
>  	/* Safe to read the remaining bytes in this page. */
>  	safe_bytes = PAGE_SIZE - (offset % PAGE_SIZE);
> @@ -206,7 +206,7 @@ static size_t adjust_range_hwpoison(struct folio *folio, size_t offset,
>  
>  	/* Check each remaining page as long as we are not done yet. */
>  	for (; safe_bytes < bytes; safe_bytes += PAGE_SIZE, page++)
> -		if (is_raw_hwpoison_page_in_hugepage(page))
> +		if (is_raw_hwpoison_page_in_folio(page))
>  			break;
>  
>  	return min(safe_bytes, bytes);
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 5957bc25efa8..a9846f043712 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1079,9 +1079,9 @@ void hugetlb_unregister_node(struct node *node);
>  #endif
>  
>  /*
> - * Check if a given raw @page in a hugepage is HWPOISON.
> + * Check if a given raw @page is HWPOISON in a folio of any kind
>   */
> -bool is_raw_hwpoison_page_in_hugepage(struct page *page);
> +bool is_raw_hwpoison_page_in_folio(struct page *page);
>  
>  static inline unsigned long huge_page_mask_align(struct file *file)
>  {
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index ee42d4361309..40129e0b8213 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1834,14 +1834,21 @@ static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
>  	return (struct llist_head *)&folio->_hugetlb_hwpoison;
>  }
>  
> -bool is_raw_hwpoison_page_in_hugepage(struct page *page)
> +/**
> + * is_raw_hwpoison_page_in_folio - answers the question whether a given
> + * page is indeed hwpoisoned.
> + * @page: given page, maybe base page, part of a large folio or hugetlb.
> + *
> + * Return: true if @page is the raw hwpoisoned page; else, false.
> + */

Why do we need the "in_folio" part at all?

> +bool is_raw_hwpoison_page_in_folio(struct page *page)
>  {
>  	struct llist_head *raw_hwp_head;
>  	struct raw_hwp_page *p;
>  	struct folio *folio = page_folio(page);
>  	bool ret = false;
>  
> -	if (!folio_test_hwpoison(folio))
> +	if (!folio_contain_hwpoisoned_page(folio))

I wonder if we should just not call that function for hugetlb, it doesn't make
sense as hugetlb doesn't set _has_hwpoisoned.

But then, I wonder if we really need folio_contain_hwpoisoned_page() at all?

Why not a simple:

if (!folio_test_hugetlb(folio))
	return PageHWPoison(page);

And now I am confused which scenario you are worried about (it's warm here ...)
can you explain which scenario you want to change?

>  		return false;
>  
>  	if (!folio_test_hugetlb(folio))
> @@ -1868,6 +1875,7 @@ bool is_raw_hwpoison_page_in_hugepage(struct page *page)
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(is_raw_hwpoison_page_in_folio);

You should spell out why you export that function in the patch description.

-- 
Cheers,

David
