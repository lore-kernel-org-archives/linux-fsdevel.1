Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED52340260
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401603; cv=none; b=ffNycybJXXmxjGNtk3W7Q7k/R24lOdZIaZdPqAp4n5xTbSA0oRJlJGsS5gQOaEqq9a1ALLmE5fpMgQhbxjA7C3JGCR3YsKgV1l3VjjdNsxUxTaBHXAffsd7YeLTfsT51HnuMx3IyTbr0RcmeVwbf4mg86+S+WNSzsP84Kq7DrMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401603; c=relaxed/simple;
	bh=6VEe4D1OfQ7oR0sVljnB96gI5U5n9u6/21SzX3xCUz4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=paAzeMkCb+6qATn/6ZEinTncQKexKRTWBSlN7tkGSK+d+wv8OZxSQghekAsAp4CdcwJ4FaJZnHMwITBVbMrJnGtyUHIoNnO5usrRT9H3nXbxVKFd/E+O1vgWKr7MZUVl/AVlk/MdI6qDp5dgP/8vPU32GISEnWoZ0x4QimI2S1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EbrwOxqU; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EbrwOxqU"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ERcnZ2qpNpaOjrBgMSH3eFGiTVKcJAovZR3Gp8QedMQ=;
	b=EbrwOxqU1XiEkqlwd/0Bv2pEY2zBh2KEdw10tgNDskWAts8UFwjcCepahypMyfBb5Ia0PtKWv
	QbV99BcUA/XZetrEOZ93st8f6N9NJKyCOZGnW3z8ZZIxLYdpjClyQuXPDOQ4M+zOTrODWBI7Qsq
	VVtX+DTXd9UTqvc2BL/AVaA=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4h9jQv5xBlz1T4Fq;
	Thu, 30 Jul 2026 16:43:35 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id B7D1E40537;
	Thu, 30 Jul 2026 16:53:07 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Jul 2026 16:53:07 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Jul 2026 16:53:06 +0800
Subject: Re: [PATCH v7 02/13] mm: Rename folio_contain_hwpoison_page() to
 folio_has_hwpoison_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>, Usama Arif <usama.arif@linux.dev>, "Gregory
 Price" <gourry@gourry.net>, Andrew Morton <akpm@linux-foundation.org>, "Jane
 Chu" <jane.chu@oracle.com>, <linux-mm@kvack.org>
References: <20260728204409.3396238-1-willy@infradead.org>
 <20260728204409.3396238-3-willy@infradead.org>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <ecd8dace-8bcb-67b8-59a7-809cf81c3b93@huawei.com>
Date: Thu, 30 Jul 2026 16:53:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260728204409.3396238-3-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/7/29 4:43, Matthew Wilcox (Oracle) wrote:
> This is a better name for this predicate.  Also make the argument const
> to allow other callers to be made const.  No functional change.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Reviewed-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks.
.

> ---
>  include/linux/page-flags.h | 4 ++--
>  mm/huge_memory.c           | 2 +-
>  mm/memory_hotplug.c        | 2 +-
>  mm/shmem.c                 | 2 +-
>  mm/vmscan.c                | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 7223f6f4e2b4..4185a03a45cf 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -1083,10 +1083,10 @@ static inline bool is_page_hwpoison(const struct page *page)
>  	return folio_test_hugetlb(folio) && PageHWPoison(&folio->page);
>  }
>  
> -static inline bool folio_contain_hwpoisoned_page(struct folio *folio)
> +static inline bool folio_has_hwpoisoned_page(const struct folio *folio)
>  {
>  	return folio_test_hwpoison(folio) ||
> -	    (folio_test_large(folio) && folio_test_has_hwpoisoned(folio));
> +	       (folio_test_large(folio) && folio_test_has_hwpoisoned(folio));
>  }
>  
>  bool is_free_buddy_page(const struct page *page);
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 2bccb0a53a0a..353340309107 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -4413,7 +4413,7 @@ static bool thp_underused(struct folio *folio)
>  	if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
>  		return false;
>  
> -	if (folio_contain_hwpoisoned_page(folio))
> +	if (folio_has_hwpoisoned_page(folio))
>  		return false;
>  
>  	for (i = 0; i < folio_nr_pages(folio); i++) {
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 7ac19fab2263..33007e8e546a 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1813,7 +1813,7 @@ static void do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  		if (folio_test_large(folio))
>  			pfn = folio_pfn(folio) + folio_nr_pages(folio) - 1;
>  
> -		if (folio_contain_hwpoisoned_page(folio)) {
> +		if (folio_has_hwpoisoned_page(folio)) {
>  			/*
>  			 * unmap_poisoned_folio() cannot handle large folios
>  			 * in all cases yet.
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b51f83c970bb..492c9bef3620 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3240,7 +3240,7 @@ shmem_write_begin(const struct kiocb *iocb, struct address_space *mapping,
>  	if (ret)
>  		return ret;
>  
> -	if (folio_contain_hwpoisoned_page(folio)) {
> +	if (folio_has_hwpoisoned_page(folio)) {
>  		folio_unlock(folio);
>  		folio_put(folio);
>  		return -EIO;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 35c3bb15ae96..70e54ace0e74 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1086,7 +1086,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		if (!folio_trylock(folio))
>  			goto keep;
>  
> -		if (folio_contain_hwpoisoned_page(folio)) {
> +		if (folio_has_hwpoisoned_page(folio)) {
>  			/*
>  			 * unmap_poisoned_folio() can't handle large
>  			 * folio, just skip it. memory_failure() will
> 

