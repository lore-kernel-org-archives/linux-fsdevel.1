Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695354;
	b=woAx4kk4VtptIhpTDq8hIMpy9Ig2M9vaEz88zb4eIUG42TJjhciOXSOCW0NS8bhxkV5Z
	 lcKuqnam7ix1+XSsFvXXsw+qiZQOQh7oHUD4ftHmxe34t8kUHtNehnGnovwAtJCMZJlZI
	 NxCZKBgenaSCmzYI9PxiDROX3AtJ0oRsJkcOppHjP8C1BAHHstqJvH9+TJ0TfBpvDFMLm
	 QmDnOq2YZv6E8+Dy7OEes2rOo9C7n8sNp8hKDDvM1BChrMFH0ZiXgHjSfkOW1KT2D7+Xj
	 Use5MGJq54xLaEHDWrxT3dQq3RS3U4CT2OxxVcU3b7Tf1OU6a0tqHZOXRln85LYFbDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695354;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=N6lF+Cgq07u7hRt8qodG60GURr6XJTFAKElEWQyNaqk=;
	b=CIctUokUcTOa5YnnaMsGScMMyuOiR10TTGTXU4Nzd3BA42HR2wtIoN40MzMj/DFNd0Kw
	 Io2Gyx1PrSp/aw9mL2HyPsah6H8QAPIv7Z2oyB/ds24GVpMBUcDPGAixYwUG9rsSxVd0x
	 UQ4HhI98n8UJuNZNsOjGSRWoP6S3NRpFBqM7JAilNXeKqP34Aqo352Bh3+Br4/zCDLdda
	 ZLwp3bhyjouWvu2u7E+TbF9iWYdXXX9NLAm3xIGyErPO2lOtBQ1EdFcTeDFltwz7NQH8m
	 aolVPaCr31YSobNW6tXlrs9huTL4b27fobAXl453LqrJwXDI3HnN3PdF8BD+s+kCJtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Un/xWjeC";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA93606A32F;
	Tue,  3 Nov 2026 08:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Un/xWjeC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FF51F0093A;
	Tue,  3 Nov 2026 08:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793695354;
	bh=N6lF+Cgq07u7hRt8qodG60GURr6XJTFAKElEWQyNaqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Un/xWjeCpHxG02qi7ifK2pzrR3XHFSDlXq6bk5LxW46SJ3N8TkY6AHCyfecvj8TXC
	 HVgo/Zn2AsykqrS+mIEDgxkxMdXzjKwu4t/zp7Af6BFGnsxxHAmMu94Xwxk69rdhEw
	 ZeYluik3rkad0xgx/07HLsT0RAJsn21T79n7Vnkvzv9UTCM4iDsJHGhmc3JGlYLHii
	 WMNGBT8LAid85gaAHYjmzhmAnjY6ACYNzGloyeBEY3srVGo1QwzGDxdjr52LxWWEqi
	 gL1EhVmLPS6pZHreauTHLFqdwIbxhu39thl0zR86q4Wm59q//5Ta2/nKKFs0ZKR5dA
	 pzcrDGaVKt1Iw==
Date: Tue, 3 Nov 2026 08:42:26 +0000
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
Subject: Re: [PATCH 8/8] mm: remove thp_size() and thp_order()
Message-ID: <aumeA1i8nIAlS1EZ@gremlin>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
 <20261102-page-wrappers-v1-8-e7280bdb31f6@columbia.edu>
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
In-Reply-To: <20261102-page-wrappers-v1-8-e7280bdb31f6@columbia.edu>

On Mon, Nov 02, 2026 at 05:54:13PM -0500, Tal Zussman wrote:
> The last callers of thp_size() have been converted to folio_size(), and
> thp_order()'s only remaining user was thp_size() itself, so remove
> both.
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/mm.h | 21 ---------------------
>  1 file changed, 21 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 8b5883878538..143865580169 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2146,27 +2146,6 @@ static inline unsigned int page_shift(struct page *page)
>  	return PAGE_SHIFT + compound_order(page);
>  }
>
> -/**
> - * thp_order - Order of a transparent huge page.
> - * @page: Head page of a transparent huge page.
> - */
> -static inline unsigned int thp_order(struct page *page)
> -{
> -	VM_BUG_ON_PGFLAGS(PageTail(page), page);
> -	return compound_order(page);
> -}
> -
> -/**
> - * thp_size - Size of a transparent huge page.
> - * @page: Head page of a transparent huge page.
> - *
> - * Return: Number of bytes in this page.
> - */
> -static inline unsigned long thp_size(struct page *page)
> -{
> -	return PAGE_SIZE << thp_order(page);
> -}
> -
>  #ifdef CONFIG_MMU
>  /*
>   * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
