Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7993C379C49
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480146; cv=none; b=Jd6WxAGjNM7Q0S3H67cMF3kOZkF7HQVpEWDlp7ZffIQzVu+BDwEdtzGw7xbFUXBm7gRB82rtgyzXK4Z3quxFWzHK5iuiat6bmtlTg3m7QpS4P1/RxE7y94C4LV6pRIpQ4aHQhv45Sjr1qHcEinYSqz3Ha7CdserD+G+K4JvUB/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480146; c=relaxed/simple;
	bh=aCuOCjCxCqzADQFU6QT4NdBSuo9F/i2GV46gIcVNsCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFBeh4QtkJ/MJ57dW/j6PB3ScGROqjMkHNiM6bK6QRttWOr7VA64+RgxgYUEw+0njHnypVue5pUdgGICfveVyg4azNY7ZMJBiRGf6heXxY7c2tIR9PTNGJ1/DLGZpHYlxMiqWpuCKQApO8oQtAV8UTSu+7cN+mkqglHcqYVDWkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ChOW3goB; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ChOW3goB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780480142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qRZp5ZMzEDXQc8ahmmB8pD2/ZDJOPT6FNpIKLdttDE4=;
	b=ChOW3goBXkRpVxbecvK/1EBRh+1WMjJKOWXpImaw1QNzQXIPKZi+e5xuEfX2hdMNydwHt8
	iTjJKKsa2yDyk9NybQKSZVaJ9lEkENqNnZzvWcI90hXVPWcg3CbH6hzCg6UE+2Sid3Y1UV
	5YrkF4d1B4bLPh/O3ZR4tOBq37REYAc=
From: Usama Arif <usama.arif@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	Christoph Hellwig <hch@lst.de>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH 1/3] ntfs: Correct use of folios in handle_bounds_compressed_page()
Date: Wed,  3 Jun 2026 02:48:38 -0700
Message-ID: <20260603094839.2599704-1-usama.arif@linux.dev>
In-Reply-To: <20260601192626.150804-2-willy@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Mon,  1 Jun 2026 20:26:20 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> Inline zero_partial_compressed_page() into its one caller, remove accesses
> to page->__folio_index, fix highmem (page_address() does not work with
> kmap_local()), switch to using zero_user_segment() which includes the
> call to flush_dcache_page().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Fixes: 495e90fa3348 (ntfs: update attrib operations)
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hyunchul Lee <hyc.lee@gmail.com>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/ntfs/compress.c | 40 +++++++++++++++-------------------------
>  1 file changed, 15 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> index 76bd806b41ed..143f362a42f5 100644
> --- a/fs/ntfs/compress.c
> +++ b/fs/ntfs/compress.c
> @@ -96,26 +96,6 @@ void free_compression_buffers(void)
>  	mutex_unlock(&ntfs_cb_lock);
>  }
>  
> -/*
> - * zero_partial_compressed_page - zero out of bounds compressed page region
> - * @page: page to zero
> - * @initialized_size: initialized size of the attribute
> - */
> -static void zero_partial_compressed_page(struct page *page,
> -		const s64 initialized_size)
> -{
> -	u8 *kp = page_address(page);
> -	unsigned int kp_ofs;
> -
> -	ntfs_debug("Zeroing page region outside initialized size.");
> -	if (((s64)page->__folio_index << PAGE_SHIFT) >= initialized_size) {
> -		clear_page(kp);
> -		return;
> -	}
> -	kp_ofs = initialized_size & ~PAGE_MASK;
> -	memset(kp + kp_ofs, 0, PAGE_SIZE - kp_ofs);
> -}
> -
>  /*
>   * handle_bounds_compressed_page - test for&handle out of bounds compressed page
>   * @page: page to check and handle
> @@ -125,9 +105,21 @@ static void zero_partial_compressed_page(struct page *page,
>  static inline void handle_bounds_compressed_page(struct page *page,
>  		const loff_t i_size, const s64 initialized_size)
>  {
> -	if ((page->__folio_index >= (initialized_size >> PAGE_SHIFT)) &&
> -			(initialized_size < i_size))
> -		zero_partial_compressed_page(page, initialized_size);
> +	const struct folio *folio = page_folio(page);
> +	pgoff_t page_index = page_pgoff(folio, page);
> +	size_t offset;
> +
> +	if ((page_index < (initialized_size >> PAGE_SHIFT)) ||
> +			(initialized_size >= i_size))
> +		return;
> +
> +	ntfs_debug("Zeroing page region outside initialized size.");
> +	if (((loff_t)page_index << PAGE_SHIFT) >= initialized_size)
> +		offset = 0;
> +	else
> +		offset = initialized_size & ~PAGE_MASK;
> +
> +	zero_user_segment(page, offset, PAGE_SIZE);
>  }
>  
>  /*
> @@ -231,7 +223,6 @@ static int ntfs_decompress(struct page *dest_pages[], int completed_pages[],
>  				 */
>  				handle_bounds_compressed_page(dp, i_size,
>  						initialized_size);
> -				flush_dcache_page(dp);

Hello!

In the old code, handle_bounds_compressed_page() returned without doing
anything when the page was inside the initialized region, and the caller
then issued flush_dcache_page(dp).

In the new code, when the page is in-bounds the helper returns early before
reaching zero_user_segment(), so no dcache flush happens for the common
case where the page actually received decompressed data. Could this leave
userspace seeing stale dcache contents?


>  				kunmap_local(page_address(dp));
>  				SetPageUptodate(dp);
>  				unlock_page(dp);
> @@ -767,7 +758,6 @@ int ntfs_read_compressed_block(struct folio *folio)
>  				 */
>  				handle_bounds_compressed_page(page, i_size,
>  						initialized_size);
> -				flush_dcache_page(page);
>  				kunmap_local(page_address(page));
>  				SetPageUptodate(page);
>  				unlock_page(page);
> -- 
> 2.47.3
> 
> 
