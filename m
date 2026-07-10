Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B338729D260
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694587; cv=none; b=m1woCxxqnk6Pt3rOtG6P7buTylTG5oi9knWNsz4OYIcKC9sqIB3ZY/jPLDisi8KDtyBGWu5J/gsBn8zDKCn6+2x72xr7+AoZeFhT9xwEBU8ZcdKsxEIoHdl9kp8gStmsn+TRvcLQPO3aQNZBTIBRd/hNg6ddewr9cYVL50JXA/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694587; c=relaxed/simple;
	bh=w0S2gV0CC03my19m6tbW1zp/hD14Th9nuYfGx9zvMMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyTkRC60dgVLf0gZP8Kw/0hm5wsMJtyCDCIhcYeepbNMjTd1zI6tel9IVGdILsuRLVsGhaF8gxBGrawr7U0mkuHo0q1VjYaAyWMgGJJe3nTAPylCLv8WwR1wxo5crhwE8KsUIhs4UO/JU7XT6bcE0nIYsgmCsQgM7h1WwFzrBNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W/1v8edw; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W/1v8edw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783694583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TyGpTvPb66f93Uqv/iJz/Z/N+SYM7wUxzDhPSkjZSdQ=;
	b=W/1v8edwSzcHhuzaj0ZNkV/hS+CprnI7Irx3HlzgRrEw69bGvoPCSVRb6KQiSbfP4vAMJO
	p2ql8cDU9gIAV+GeoD5NCV/NdLpyuPkFAbRykcB7b5YltvJtHmRv9rrhtFvMo4GuZWwYLx
	1AKqfr9Kze9uxIibs980a2l0dda1itQ=
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
Subject: Re: [PATCH v2 03/10] filemap: Remove checks in mapping_set_folio_order_range()
Date: Fri, 10 Jul 2026 07:42:48 -0700
Message-ID: <20260710144248.1432278-1-usama.arif@linux.dev>
In-Reply-To: <20260709184740.1286561-4-willy@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Thu,  9 Jul 2026 19:47:31 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> These checks make it impossible to use mapping_set_folio_order_range()
> in hugetlb.  They add very little value and can simply be removed.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/pagemap.h | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 2c3718d592d6..d0c9aecaa4ac 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -405,29 +405,18 @@ static inline size_t mapping_max_folio_size_supported(void)
>   * @min: Minimum folio order (between 0-MAX_PAGECACHE_ORDER inclusive).
>   * @max: Maximum folio order (between @min-MAX_PAGECACHE_ORDER inclusive).
>   *
> - * The filesystem should call this function in its inode constructor to
> - * indicate which base size (min) and maximum size (max) of folio the VFS
> - * can use to cache the contents of the file.  This should only be used
> - * if the filesystem needs special handling of folio sizes (ie there is
> - * something the core cannot know).
> + * The filesystem should call this function in its inode constructor
> + * to indicate which size folios can be used to cache the contents of
> + * the inode.  This should only be used if the filesystem needs special
> + * handling of folio sizes (ie there is something the core cannot know).
>   * Do not tune it based on, eg, i_size.
>   *
>   * Context: This should not be called while the inode is active as it
>   * is non-atomic.
>   */
>  static inline void mapping_set_folio_order_range(struct address_space *mapping,
> -						 unsigned int min,
> -						 unsigned int max)
> +		unsigned int min, unsigned int max)
>  {
> -	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> -		return;
> -
> -	if (min > MAX_PAGECACHE_ORDER)
> -		min = MAX_PAGECACHE_ORDER;
> -
> -	if (max > MAX_PAGECACHE_ORDER)
> -		max = MAX_PAGECACHE_ORDER;
> -

This one is a bit interesting, This has been useful to me in the past when I
was trying to [1] use mapping_max_folio_order() for force_thp_readahead order.
On arm64 with 64K base PAGE_SIZE HPAGE_PMD_ORDER is 13 (512MB), while
existing MAX_PAGECACHE_ORDER was smaller and the cap is what prevents generic
page-cache code from advertising that unsupported 512MB order due to
MAX_XAS_ORDER.

[1] https://lore.kernel.org/all/20260601102205.3985788-3-usama.arif@linux.dev/

>  	if (max < min)
>  		max = min;
>  
> -- 
> 2.47.3
> 
> 
