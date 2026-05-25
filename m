Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798053C060C;
	Mon, 25 May 2026 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693038; cv=none; b=GdYjOFQfjnLmjum6rduMWq5TPolrBgosp9wx0eWDv+Oi3NV1QsAcJQGfvQ3/dUK3xdiqcAdE8/8gFcsh6/I8Tjl6ERTy6OI3lGHftLvfX5DfxP0E+iCBrPY5D1bo5PPdaCLE9+p5Y5mBh7NLOY+0GaN2deTP9OJLU2BtJWQ1Mw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693038; c=relaxed/simple;
	bh=g8N5+ESzlEtm5aWlUEDrKwz4n+WCzRmKGtK07gvgp+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KMu0j2aWfxUyWvP7gqlA46hfXrkxMhpyZgvnqBxlJhGHDcZRo2aIzFbz9SHzV+qIXhGKoMwj6m7ZEq6gv6YqpEPDXbArQoiYdTgSPLJjuSy7EI26gLsPveHmE59RteNv37oinCmY3/t7cHqSQplEgloXuUZGPMerckbaQ8Rx5Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OR6dMVB3; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OR6dMVB3"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779693030; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=q0TGY7Tvs4qtdmNexGx+wDHmFYHVm6o5kSYPELpBcuk=;
	b=OR6dMVB3T1BTP+S6tpgL1PKwZPRzvtxjuLRoIAHs3N8m91HR+eAgJiUuj+G6s13AfJchNyymAwzOoiRS10cSyQKUgmCkxWnQ3VfWZ9dVKxJiAwSCFoewPGbetyn7Qkd59yPSFkPp7gdlFYz62XW/PjogEMLW0UmfTSPg6Q3vCWQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0X3VfnFW_1779693026;
Received: from 30.74.144.135(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X3VfnFW_1779693026 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 May 2026 15:10:27 +0800
Message-ID: <772f7bcb-eb78-4439-b94b-1a096a01dc51@linux.alibaba.com>
Date: Mon, 25 May 2026 15:10:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] mm/shmem: make SGP_NOALLOC succeed on hole like
 SGP_READ
To: Chi Zhiling <chizhiling@163.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Hugh Dickins <hughd@google.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, "Liam R. Howlett" <liam@infradead.org>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Chi Zhiling <chizhiling@kylinos.cn>
References: <20260520101538.58745-1-chizhiling@163.com>
 <20260520101538.58745-4-chizhiling@163.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260520101538.58745-4-chizhiling@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/20/26 6:15 PM, Chi Zhiling wrote:
> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> Change SGP_NOALLOC to return 0 with NULL folio on hole, matching
> SGP_READ behavior. This simplifies the sgp_type handling by unifying
> hole semantics across these types.
> 
> Previously, SGP_NOALLOC returned -ENOENT on hole, while SGP_READ
> returned 0. This inconsistency required special handling in callers
> like khugepaged and userfaultfd.

This patch doesn't seem to be a performance optimization, and I'm not 
convinced.

> After this change:
> - khugepaged: behavior unchanged (checks both error and NULL folio)

But this adds an extra check to khugepaged, and I'm not sure it's worth it.

> - userfaultfd: behavior unchanged (both -ENOENT and NULL are converted
>    to -EFAULT before returning to userspace)

No, this will break userfaultfd, cause userfaultfd currently returns an 
error code directly in this case (please update to the latest 
codebase.). See:

static struct folio *shmem_get_folio_noalloc(struct inode *inode, 
pgoff_t pgoff)
{
	struct folio *folio;
	int err;

	err = shmem_get_folio(inode, pgoff, 0, &folio, SGP_NOALLOC);
	if (err)
		return ERR_PTR(err);

	return folio;
}

> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> ---
>   include/linux/shmem_fs.h | 2 +-
>   mm/khugepaged.c          | 2 +-
>   mm/shmem.c               | 9 +++------
>   3 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 93a0ba872ebe..d461713c095b 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -165,7 +165,7 @@ extern unsigned long shmem_partial_swap_usage(struct address_space *mapping,
>   /* Flag allocation requirements to shmem_get_folio */
>   enum sgp_type {
>   	SGP_READ,	/* don't exceed i_size, don't allocate page */
> -	SGP_NOALLOC,	/* similar, but fail on hole or use fallocated page */
> +	SGP_NOALLOC,	/* like SGP_READ, but accept fallocated page */
>   	SGP_CACHE,	/* don't exceed i_size, may allocate page */
>   	SGP_WRITE,	/* may exceed i_size, may allocate !Uptodate page */
>   	SGP_FALLOC,	/* like SGP_WRITE, but make existing page Uptodate */
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b8452dbdb043..3309d1c094df 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1950,7 +1950,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
>   				xas_unlock_irq(&xas);
>   				/* swap in or instantiate fallocated page */
>   				if (shmem_get_folio(mapping->host, index, 0,
> -						&folio, SGP_NOALLOC)) {
> +						&folio, SGP_NOALLOC) || !folio) {
>   					result = SCAN_FAIL;
>   					goto xa_unlocked;
>   				}
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 3b5dc21b323c..458853c506ea 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2524,14 +2524,11 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>   	}
>   
>   	/*
> -	 * SGP_READ: succeed on hole, with NULL folio, letting caller zero.
> -	 * SGP_NOALLOC: fail on hole, with NULL folio, letting caller fail.
> +	 * SGP_READ/SGP_NOALLOC: succeed on hole, with NULL folio.
>   	 */
>   	*foliop = NULL;
> -	if (sgp == SGP_READ)
> +	if (sgp <= SGP_NOALLOC)
>   		return 0;
> -	if (sgp == SGP_NOALLOC)
> -		return -ENOENT;
>   
>   	/*
>   	 * Fast cache lookup and swap lookup did not find it: allocate.
> @@ -2657,7 +2654,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
>    *
>    * When no folio is found, the behavior depends on @sgp:
>    *  - for SGP_READ, *@foliop is %NULL and 0 is returned
> - *  - for SGP_NOALLOC, *@foliop is %NULL and -ENOENT is returned
> + *  - for SGP_NOALLOC, *@foliop is %NULL and 0 is returned
>    *  - for all other flags a new folio is allocated, inserted into the
>    *    page cache and returned locked in @foliop.
>    *

