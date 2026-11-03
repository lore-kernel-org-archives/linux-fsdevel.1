Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694995;
	b=EB9Tj+2Uu7N6cV6vmLmAxpv3DgoJEeT0a9Sq88JGyLwWx9rrHcMJg2ne9kVRh7H5ZRjx
	 caafASFAKNZz/VxzcIhSRJfmHXQKVX1lyYY/RyswNwre2oOFFtXZDjJQcBi8cpaIylR2K
	 L4LmNEawTGwIW0C6aoGwZnmL2FuFcISWA4ut1moabsxuKIoJ7/CuSzs08qCnP0PbPXQ1d
	 cc995mFqOnyBS3Ki8/kEqIcE6z26ysePBk2AQCqNIQzuLwJ4m01U8YheSQDp6l1dYVtgE
	 v87Lt8ifaVDCccSsvEjE9Ey3H9jOxCIJxRQwGAvGK3VmHQdiM+jLxSdfmrjcd44yMsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694995;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=of6BOSsOI/Xiz9OzswHQFf111MtWWN9/gW/+S2R1v+c=;
	b=Uq6cEKR+DkHNmtxFB4FRwKNFE3F1JGcc6L9HN1DEyaRw7pRAlIv1T+6wvv+9LlBpk9oV
	 hR45BqwYURdhhkYBZsMP5zcss0U5mut6DXFCsIo2HnCCaPY08vZ6kxbCNn+o4yFDFGczf
	 ruJnSd5lRoaKJ7ks//rPS6FFpDYyVsZ/Yrfs7Y9I+SJYbWKRBz+hRT+L4dJKtcDTwl8H8
	 pnmiqqVOvgKKNGRZeWWaU6xoJEWakFlgi1XVyc62twDd/1K94AZYLFmzppYS3JwxEXABz
	 YvD6SsNy9q3Fk1t7U1ngeyQ71OzMwVqpfqXchtW0A+yJ+NKubCnw2OBQmPC0d91/Miw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Be6YHjgh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB27D606A336;
	Tue,  3 Nov 2026 08:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Be6YHjgh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B0D1F000C1;
	Tue,  3 Nov 2026 08:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793694994;
	bh=of6BOSsOI/Xiz9OzswHQFf111MtWWN9/gW/+S2R1v+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Be6YHjghGzdvhgIjQNRaWKGkvThokD5XwStMhOy/X4/2WeAxQUxmXqeQqTr2q1W0s
	 K3BhntXqko+gaOnnd+3YhoJOAsosGn55owJ3OjiuH8UkcC4Ck/XcCf7FIwTly/U7dR
	 i/NaE/q0HOVeZUYjeDVzOt2NwpXM9EUjoexg5sVlo2MCmEyITv2+HsIcLqLIAAF6XL
	 kUT/uozqyuUM0p8vbGhaFrQ5d1xStDKRGaxIezMfytZuhaYZ5u79yhdmntHtGX6IJg
	 Ic9SjLSnMuIprFl3Qa702HL+f+YZ8+hQVs1LKXp9Gnh6ht9+C7hcsEO87TxBdWGJUu
	 L5NL5J2dN3USw==
Date: Tue, 3 Nov 2026 08:36:26 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] mm: remove find_lock_page()
Message-ID: <aumc3fnNg1PK9wXP@gremlin>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
 <20261102-page-wrappers-v1-6-e7280bdb31f6@columbia.edu>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-page-wrappers-v1-6-e7280bdb31f6@columbia.edu>

On Mon, Nov 02, 2026 at 05:54:11PM -0500, Tal Zussman wrote:
> There are no callers left. Remove it. The name still appears in a
> sample function graph trace in Documentation/trace/ftrace.rst, which
> is recorded output and is left as it is.

Yeah that's fair enough :)

>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

LGTM!

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/pagemap.h | 19 -------------------
>  1 file changed, 19 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 00e32f96b459..a92329805acd 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -846,25 +846,6 @@ static inline struct page *find_get_page(struct address_space *mapping,
>  	return pagecache_get_page(mapping, offset, 0, 0);
>  }
>
> -/**
> - * find_lock_page - locate, pin and lock a pagecache page
> - * @mapping: the address_space to search
> - * @index: the page index
> - *
> - * Looks up the page cache entry at @mapping & @index.  If there is a
> - * page cache page, it is returned locked and with an increased
> - * refcount.
> - *
> - * Context: May sleep.
> - * Return: A struct page or %NULL if there is no page in the cache for this
> - * index.
> - */
> -static inline struct page *find_lock_page(struct address_space *mapping,
> -					pgoff_t index)
> -{
> -	return pagecache_get_page(mapping, index, FGP_LOCK, 0);
> -}
> -
>  /**
>   * find_or_create_page - locate or add a pagecache page
>   * @mapping: the page's address_space
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
