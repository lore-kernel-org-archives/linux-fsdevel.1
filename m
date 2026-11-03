Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694900;
	b=1YJlzEuF2Tzh3opUEwfBGculIH852v5qeIWllELc5I6QOvSNy0wq/ppqMcdsiBuupbTu
	 gg1/b6A09xuZYqmMWCJQaAbPCjtdR0EMbQ0Do7+nSWeCDRFG7UVbSvu9BP7sSCwpdCbQR
	 6w5oWOH2/G7wjxhA6TweifxsSWTa/N87MB9JNzr5GlUztwh6EOfRmbd1nZRA9sc/5E3Qw
	 L7iDr7ItSuElkFwYVW98/kvO7yoU9qUYgiROkBuxdnczkqqJwDDf5b3yNudet1kHRzuS5
	 DxWSAJkBJQH7mXttefsRUk/16d/OPBQKs0CP1qEFcg/yYh1y9C9dLDwmmksMp3fbWBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694900;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MbkXDHo1xuZzdIbJLfCFRMeI3qreXHQVaX0Y035ar6E=;
	b=Mh6vAQm7fC12h1vEh+7rJNS+l9sT+DEp3O48RPbGr5MboXWwqONLNmo+W4K7H5lT4ycb
	 gi/1pM2+wUQkp4UNWAJ4KanOdXnZs7FXv7FRImHqUptS8kq6YLll5KtyogqPw/YAl3vb2
	 kaP/Z6Y3aDWVylRgTa+rUWVO7Toa2mcewi0/cfGwe2RYETN0/8XVhtMHJcgJr2DHXrd8/
	 mCFLAlkQQfdtwWgGnkrwuK1iry+2vhIfeLpDweaKSYcArbhpYrVJgvWyVEfoG6+nIALwQ
	 HQ+NLwhbi26d+luHxmoTbyRyvE/YYIAJcXzTKXFURiHsd9CqSyjUDac4OqyuOgQldRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P/GKaWaZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C495606A33D;
	Tue,  3 Nov 2026 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P/GKaWaZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E97B01F000C1;
	Tue,  3 Nov 2026 08:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793694899;
	bh=MbkXDHo1xuZzdIbJLfCFRMeI3qreXHQVaX0Y035ar6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P/GKaWaZ2XZPjdPtX0xj3DV82aPecbQdBJ09rmkt8WdtG6oEJWZfgDu4oU0v7TGQR
	 DZ4+KCjo3a58PVlZecgdBRRUdjFxTh9NC3jnzhYKSezGnP4oaR5AT6EBUaVhiq/GHn
	 DywN9Ru1M17Pcsw7VPrEkExKy8MY7Nya3VidCc5XAv4dgJje0bJPIvbAgVfEKPKQZO
	 zKNaKOaUvNpkBGXEWrY4VlCBSpAzYfvCIGsfaPWFblJa1imMI0UWvm/UHPmSZ7ziE0
	 sW4G1aSC6kh7MF9rTlMqwf0zxON36NECN9ONOcBW3Xf4XGLAEngsUVqN5dcP2EDQzN
	 NFCacvWwboiRw==
Date: Tue, 3 Nov 2026 08:34:51 +0000
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
Subject: Re: [PATCH 4/8] mm: remove attach_page_private() and
 detach_page_private()
Message-ID: <aumcoUqORACOXqFP@gremlin>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
 <20261102-page-wrappers-v1-4-e7280bdb31f6@columbia.edu>
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
In-Reply-To: <20261102-page-wrappers-v1-4-e7280bdb31f6@columbia.edu>

On Mon, Nov 02, 2026 at 05:54:09PM -0500, Tal Zussman wrote:
> There are no callers left of either wrapper. Remove them.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

LGTM!

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/pagemap.h | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 9adfeae2153c..37b7786350c5 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -635,16 +635,6 @@ static inline void *folio_detach_private(struct folio *folio)
>  	return data;
>  }
>
> -static inline void attach_page_private(struct page *page, void *data)
> -{
> -	folio_attach_private(page_folio(page), data);
> -}
> -
> -static inline void *detach_page_private(struct page *page)
> -{
> -	return folio_detach_private(page_folio(page));
> -}
> -
>  #ifdef CONFIG_NUMA
>  struct folio *filemap_alloc_folio_noprof(gfp_t gfp, unsigned int order,
>  		struct mempolicy *policy);
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
