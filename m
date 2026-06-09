Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBCF402B96
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781010443; cv=none; b=FNEUZjGRyXF/ZjauBbPYMWmXBpcgllbkR7kYhXp4fFr0S6mCQovn0kDcQD7Ri9v7zpzcoRqlSeHzf3CZ5btoGRdd3FmO2Tm8kWxfrQ1yZNTpDwgsrnZGQbFNYkENSlQlWim7wiIsAaDzlCAq6SSItt6lTTVpPQa40x4fbgi6kUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781010443; c=relaxed/simple;
	bh=UIuhkuKw9L3alMLR4KXW71QeNhDnrss12knSADoiG0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjGel3vDBobTIQXhujizf0dmrPLOLBfmX2vas22XgeNvPVp2rbmt08FCssI+HhfYeyxh6P3Ix5J8LCFIqsZ6ZPrBXLbBWmmj3H/6+f1h346ThmogwLVR9hygc/exKHX+r+8itYDhelQ1A5HIqxujVFM41StelQbwAxNgacnnuAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RYxHyMvg; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RYxHyMvg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781010439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BHSHH1TAOou/c2SNAiKK3Gf3+G+ZYZOub2TB+ihqU38=;
	b=RYxHyMvgF7CyQdh/FHyghSJje9BEyk+MDbj8827eoK4dPEpZTVyyJ9yVvpKCQLp6JwSa/g
	9JKU83AhsNXVElOHKaRofb6Ngf1pZXytYskpKdasEDTFGpn+wNt4AoBuO3ax7sWvL2eCGv
	Ws8nLzbLmzh6IzouBZO7tk3n9hHbho4=
From: Usama Arif <usama.arif@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 3/6] ntfs: Use zero_user_segment() in handle_bounds_compressed_page()
Date: Tue,  9 Jun 2026 06:07:11 -0700
Message-ID: <20260609130713.2851385-1-usama.arif@linux.dev>
In-Reply-To: <20260608210618.3437216-4-willy@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Mon,  8 Jun 2026 22:06:13 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:

> This fixes handle_bounds_compressed_page() on highmem memory
> as page_address() does not work on memory which has been kmap_local(),
> only on kmap() memory.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/ntfs/compress.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> index b279f38636d6..89067fecf5a0 100644
> --- a/fs/ntfs/compress.c
> +++ b/fs/ntfs/compress.c
> @@ -108,16 +108,16 @@ static inline void handle_bounds_compressed_page(struct page *page,
>  	loff_t pos = page_offset(page);
>  
>  	if ((pos >= initialized_size) && (initialized_size < i_size)) {
> -		u8 *kp = page_address(page);
> -		unsigned int kp_ofs;
> +		size_t offset;
>  
>  		ntfs_debug("Zeroing page region outside initialized size.");
> -		if (pos >= initialized_size) {
> -			clear_page(kp);
> -			return;
> -		}
> -		kp_ofs = initialized_size & ~PAGE_MASK;
> -		memset(kp + kp_ofs, 0, PAGE_SIZE - kp_ofs);
> +		if (pos >= initialized_size)
> +			offset = 0;
> +		else
> +			offset = offset_in_page(initialized_size);

Is the else branch over here unreacheable as the outer if statement
already had if ((pos >= initialized_size) &&...


> +		zero_user_segment(page, offset, PAGE_SIZE);
> +	} else {
> +		flush_dcache_page(page);
>  	}
>  }
>  
> @@ -222,7 +222,6 @@ static int ntfs_decompress(struct page *dest_pages[], int completed_pages[],
>  				 */
>  				handle_bounds_compressed_page(dp, i_size,
>  						initialized_size);
> -				flush_dcache_page(dp);
>  				kunmap_local(page_address(dp));
>  				SetPageUptodate(dp);
>  				unlock_page(dp);
> @@ -758,7 +757,6 @@ int ntfs_read_compressed_block(struct folio *folio)
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
