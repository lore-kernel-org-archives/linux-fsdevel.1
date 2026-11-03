Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694932;
	b=fQrZPfULn2j1ovImBrciH9LtmkqsY1ZsUjQVzJxMvgIe7g8i+XInBxioeExP8XnUgu0C
	 yt5z+CY05m7E9WyvcYkoBgh9VJeelFpmevK9337RxhstsKleWR+MNcBWYSCcpV6j+OiKX
	 5GTm2O1uXn1m72mRE+fTPVkYSrEhmw/Cj+AME1KxVgsMlg8cDSxSjrfOsRvBYHTlPWU+c
	 J1mi0XTQWi3Sg7UrEUWf9dzgd5fBV46li/yrfzEXZbdJfEFlMMSulwbR1Eu7pwruZaAV5
	 Rr7TgFZB4I1V+lsIc5xKeBIITYugPSdmi69xMTh/j+VM0fnonYyi8KiMHwoqlstr5VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694932;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WtLDQNeDogoEZy8VqwmMu80kkbHazW0uml5D/A0dqsE=;
	b=tfHLwoPMUuMThPh1V5eC2jD/P5jK/r+qEuORz9+fRf8TbLo6ITqFzu/mlMjjsOgSrfhV
	 jlC3KU25KeZiz7fnYqoc1z2j1tiCA5nuZ+FEorLObn5nQpvT/FNbgJZKP3w7PLDI211bt
	 isZ2sMHo5sdMcRWfxlOeVwPwBLPuq5xwn3J74SOR5YMIS+Wmlf1Wf4BH3NgMgRQG4Vvsp
	 NkqBZ6td6C7S/moFIP+gWGPuWEOaPxHR9QMxF97UxqiKMWTvmAf4wRayiHAKesrmIqt2Q
	 g5TFdKUZtGFqBNWbh7oF1eUBz/QKLahdCUA5iVysbE2UBoPSPaqZsQFeJnX3WUCYc6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGc2rdW9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEB0606D82C;
	Tue,  3 Nov 2026 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gGc2rdW9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F961F00A1A;
	Tue,  3 Nov 2026 08:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793694931;
	bh=WtLDQNeDogoEZy8VqwmMu80kkbHazW0uml5D/A0dqsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gGc2rdW94xM36KoC6xgtpfh7Js0emN9AvZwCb5wnUR5DoAaUNlYav9YOq4gvBJ6rp
	 prcXRznN3YQWdr305TuXYsR1+dOZ82olvCCYuPkiWwfwDsHHVpaU0pUAq7PT8gIlFx
	 l/Whi1/4h/KxZAJXta8YJ25jCzLAEnzMj3lQ8cPQPS+xeRr+SRI8d3n5uc8k9Ry+Hx
	 B3iz//U/i7JAnR5NlBhB8qNYXo6MwwUNcz4YfveejPVCf0fbbPFnKAKyowHux0mCt+
	 gRzm5Gwj042rC3vXZbZ5xNNd094BtZOccNWhykB2bEQ0H28MjQPGgU2MkbaG0oyjpN
	 zTiwesgLuYEfA==
Date: Tue, 3 Nov 2026 08:35:23 +0000
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
Subject: Re: [PATCH 5/8] mm: remove find_get_page_flags()
Message-ID: <aumcutKJoj2EoE-J@gremlin>
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
 <20261102-page-wrappers-v1-5-e7280bdb31f6@columbia.edu>
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
In-Reply-To: <20261102-page-wrappers-v1-5-e7280bdb31f6@columbia.edu>

On Mon, Nov 02, 2026 at 05:54:10PM -0500, Tal Zussman wrote:
> There are no callers left. Remove it.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

LGTM

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/pagemap.h | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 37b7786350c5..00e32f96b459 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -846,12 +846,6 @@ static inline struct page *find_get_page(struct address_space *mapping,
>  	return pagecache_get_page(mapping, offset, 0, 0);
>  }
>
> -static inline struct page *find_get_page_flags(struct address_space *mapping,
> -					pgoff_t offset, fgf_t fgp_flags)
> -{
> -	return pagecache_get_page(mapping, offset, fgp_flags, 0);
> -}
> -
>  /**
>   * find_lock_page - locate, pin and lock a pagecache page
>   * @mapping: the address_space to search
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
