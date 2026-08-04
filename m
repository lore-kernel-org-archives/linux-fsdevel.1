Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAFC3FA5E9
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 16:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860032; cv=none; b=MoWh127mNQizXVnRThNBtZvfUH2bDgCrrkfVIgAMrCqe1+XV8OtN6LzELdLe0LTvd9RQGxyhTyreMHGvC9QIvY6Iy0wiYFERQp2GMJYFFimN6XIh3uATWissbDLWvwk7szqVGpYlGaEU4jCCevCf04K2IonH2CM7m5tw4+Pbwzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860032; c=relaxed/simple;
	bh=3++L9eg3dpuJiipvDgrZt6qaN75NWW5DCVqL5hydEJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdQWYVNsA9BdzAdnt8cEDY3ogbm7fHELNqIZuNzvAo32QeV/a8/gTKKxxaVP30L4dmrvFTYjR90baNVUOkTKHrN0dpg6oJsKH++hAeuJ/tDgixjCAjW3IETwbl7iXO1rysUVa7dsI8C5Oih2H8nYBp6PKbIfJpSLh/KflcRUgVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HREHHi4C; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HREHHi4C"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51e4ba1cfb4so28592201cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785860029; x=1786464829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Il3F1PhWfAFb5O45rjaP3HRomi1hREacW1lP6pn7nyE=;
        b=HREHHi4Cawy2pm0aq7cb/7DK+GlP/GgMs33tonKIe6o4ZSJJVvqr6y6wn3WJkKl/pp
         jOM+rHqlWPbxK14oIEkUV925QlIpRc4rnZ8NAFUm+XQL+59P7hkPbWaSO+pSpnVVN516
         vpeRtJYDyR16VMeNtS5Trn4gXlFun0oV/IXpuM0jrenBy3jvkwOlo8T8WU0wHeCEJHzH
         aTLkheAHQUFR36fNtJxRNVuvYumpBc1XFTW0GXM2smMGv2sGVrqbHcL01lKB0p0Tukbh
         2nEAFcVlONXk3TV2kHTvTLEyTYuI2JH8c+j0LYMopM9BhZSSYhBViG+fYC6D4lf99qw4
         zFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785860029; x=1786464829;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Il3F1PhWfAFb5O45rjaP3HRomi1hREacW1lP6pn7nyE=;
        b=WAqw4WmCvzNG/rR+XoFB2kLyhYTjbttyZ9ENXmR2LH41erkp1XUyAhM8ILPAHLkMUv
         iHdO+VaK5JCrXVl8/zmOA/TC97JzQpkz7pHhkWWRMkfGcMw1zOnQ9IQ+4GTKygYhl0b4
         JS3Usmm6vZyKuQuaFFqw4EKfzg2PVf6/osXSJEl1Yjj7UUEGUnLgO62eC4icXz5FEYrW
         HvolSbTAPaVocEJPcJhLfsVUwf41nHISaNNliUfjAPOGjhBB1eohXAHVebT/Tiq6Tnwn
         dk6wapNrr1entgyZbaWEV04+Nl1qJaxA+rsQMdQAa3IeGbvHpjgi6+yM0QU2c5VTbI4B
         4uHw==
X-Forwarded-Encrypted: i=1; AHgh+RpDOGzNvDOurNHCks3wNGz14ioY80RSW+qtf82YlPEGuVrw0nV4i0e/XXH29uOBc8avD6Gj4g4Y07Ip8cFn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/GKWN9orrS43UC37OfTwYjdFIDrtADC41MHgQ0xxbBhLO5u+S
	2uIdcrWXHqCh7yiqJ1JjruFC8UrL9yqLwxwXcTZ6XnNSdhN28l2SqaWFiLBAsTTfNJc=
X-Gm-Gg: AR+sD133I3Gmsi5r3rqaT5uP9SNgiExyisKaOChb9i5WuwSJW9ogCo1u6hEahM7gD/L
	oafXVkDYratSFxjlgHuGwCyLo5oPZ/SwHGhjTJSOeFJnRcvaPlMu5cFG8l5p2H6hq6o9PTt8EwZ
	hc+I4jRV62k9uYq/LU93kzrVmUsrBazsny8Vk0Dlfn73rNOuIiZbZC9upsSuv2NEfa/pduUu6Sk
	93jmcVh31iitGqXvADnXEbpgdf8fGjZbUfjtBap2VZmPPJUFYNcZzam0BNNz889A6oQfBAR/bue
	2RC0zlgnJWeXburr7pow5CPP5DxGBHbEbA4Jh3EMDAUYOMKCKZuQi3a3UYBtzCqjzlUNC5Hh/Je
	bmhnnbjd8tzK5k7JdV/HDDepjNRODApfErUEg3OyJKzWQfp+ShdmMeoLNP4kX4gdXjwz4WvO5xw
	mxXYXV1PLr+bqOvHxVPf1C2Hobubd+aZINuSFuYo1Y6uo8kvmgSGnnK3u6cZaRnxq36lzZkesJe
	u5d2QLLyadCYKpBPp28mebQlHXIFED8kKtpr8hRNa1D
X-Received: by 2002:a05:622a:480a:b0:528:3d14:c381 with SMTP id d75a77b69052e-52ce5f8f76bmr2339841cf.3.1785860029308;
        Tue, 04 Aug 2026 09:13:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce5172536sm2529861cf.6.2026.08.04.09.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:13:48 -0700 (PDT)
Date: Tue, 4 Aug 2026 12:13:47 -0400
From: Gregory Price <gourry@gourry.net>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v8 06/15] kpageflags: Use is_page_hwpoison() to set
 KPF_HWPOISON
Message-ID: <anIPlxgqKXEKKnLO@gourry-fedora-PF4VCD3F>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-7-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731200802.574821-7-willy@infradead.org>

On Fri, Jul 31, 2026 at 09:07:51PM +0100, Matthew Wilcox (Oracle) wrote:
> Instead of knowing how hugetlb handles hwpoison, just ask
> is_page_hwpoison().  This gives us the flexibility to change how hwpoison
> is handled without updating this function in the future.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Nothing to add, love -ifdef's :]

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

> ---
>  fs/proc/page.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 7d9387143435..28c9a7b724f3 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -233,12 +233,8 @@ u64 stable_page_flags(const struct page *page)
>  	u |= kpf_copy_bit(k, KPF_UNEVICTABLE,	PG_unevictable);
>  	u |= kpf_copy_bit(k, KPF_MLOCKED,	PG_mlocked);
>  
> -#ifdef CONFIG_MEMORY_FAILURE
> -	if (u & (1 << KPF_HUGE))
> -		u |= kpf_copy_bit(k, KPF_HWPOISON,	PG_hwpoison);
> -	else
> -		u |= kpf_copy_bit(ps.page_snapshot.flags.f, KPF_HWPOISON, PG_hwpoison);
> -#endif
> +	if (is_page_hwpoison(page))
> +		u |= KPF_HWPOISON;
>  
>  	u |= kpf_copy_bit(k, KPF_RESERVED,	PG_reserved);
>  	u |= kpf_copy_bit(k, KPF_OWNER_2,	PG_owner_2);
> -- 
> 2.47.3
> 
> 
