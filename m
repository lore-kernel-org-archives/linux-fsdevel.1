Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862BC47255F
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785860891; cv=none; b=at6cFpbP7eWFP1frs+V4B7rctJEI3MzXtPK+N7w6P6ef+/5acEfuRnfRdGSxu/z4KLpjdo7iUa6X8kss1nJNY8fFoYAn85EYnEVypOsTNepxYYMMCeMGNoDZnZTjLI75UVCUtnO02JAf0HAVyL9mjLCQvi3OgRvF6GdDIkQCszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785860891; c=relaxed/simple;
	bh=RBb47G5i4UC4ejkmiqxi7WGEMgIBJHROOBsoeZnaQCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osGOh0P2VKQSzLvwkUUScoCNJbkxmXFe1Hti1ibsknMPD5lzmxS6LMnNjh9+bnI+J2MpKuJ0fRGaJTyXAEU/OvZNm8JzQfitPJ12EZ6uDaFtApANRlwrls15PvYRaVX6FmzgH7OlldSzrwPBKMhSgHNDbWt1weVgmrwmokOWQkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XbkRrqD7; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XbkRrqD7"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e7632b193so2631585a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 09:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785860888; x=1786465688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ROqP8QdlD7ssu2ObwicRyZpkbdMgd9rnKarPu/SKkHc=;
        b=XbkRrqD7Lh8yvQirJ4xOPC6/Qg82psuZ1D3opLU92J+zTW4UpzyxrQBKw6qnvlJwa5
         zo7vExcUXp8G6Jals0DFtm4On1R6RJNy1iZA8oy1MEUXwmakpuMNXDnPfiVcqqoQMaHq
         kcqzCbVJg0G0Te00Urc//aCgBRtTKbl0nDN2g+x0DyPj7Dp9Xgut4WFniCnVtvczUBf/
         u/HkvLOzN2vxiM7nntNUg4XkWQg50bYLUnkGJHzkBg5A06G6oMucBNMasnlzAb8dw6B8
         rGApvDJZauLsRWQ+22XhXyUBMCF7B7CwF22lMscR6J3+Q5By1GsskR7sWbsPUgsUL0bo
         EIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785860888; x=1786465688;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ROqP8QdlD7ssu2ObwicRyZpkbdMgd9rnKarPu/SKkHc=;
        b=pWzQdnLhsF4E3PlPVTBtXCsXkNIry3xApUynkE9f9K81rrQf2WuoQRGfFVKmOwjuJn
         Dk44qD0wSkjCHf7USzAZKfbZ0VIdZW6HmH6BWdSoI6guBCiZcYbqmofH5lnUZNV8FbEz
         D1HBHkSUwDNUO4YBFkpZZxlA/mYies5/sbMQX+iOKnYtLLu1NNEr05LtPECljK8ob6jr
         xntO7H0ZC9Kw6I7fgtA2DgjZBuvsDiZRomKWqex1vkr52nkvpu46+B/ghAbBwtI+sBlv
         0/jNUTlSJFH/80AfPYvusiPSXHqANVLajuCQMCqgCwrwNbUcW3eqwmw3Q/NrwwCODMbT
         ARmg==
X-Forwarded-Encrypted: i=1; AHgh+RqdJwRY3B2am8iYO7wjL4F93T+MTc5F+HlihLbp8vd4L/tlgxn/DSGtjDfuGtvsaoYsZHAbwC230qT5eSPX@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxx2Rr4eo/DnyigYFnrT66S3bVhTLLR5H3uXIY1B+N6zmNGvac
	qceFK1+YIaBXiIYsHTv5RKmZFfODqs5cl5dBrg/w7sFuks0i/TXwTqsQ7GguBfPCZGw=
X-Gm-Gg: AR+sD13sHQP14ckFrTVIMe94DJji3UXkV3FgJDzuTIy70UKp7rV8cxEmWAMirKEdFUR
	sfJAnorHNwAjol5ptqfAPgAEGJXlaLSGLRhXGlW1eQMg671HnEUGS1ouPuLUF+L0M+8wNjm6hAS
	Jbc/qUL0DVK60Gkm45jwZS4atYsoH861183+vOSL32KGfxdrEV/c1iNmEeuCv6kbylbiMQzbjfH
	s/K2GokELB/hGXFmGPgplf9Pm3C5mEvNHcMlS+JT0gFvOeMKzod31CeWB9aSZfp57c34LWrQk+u
	nBPNuwd28iDSOUJ/95RdppY5Sx77qifT1fDDOlzEhblGLmQvYwYrPXMH25I9xjdHQ6LYT1xBLsi
	mxtVF90Zqf0xpL3q/6oRRpTASmVUAzY96Ir/kRynml2LTKBvmY/NcKwOsrBjnXWU//tqJAFoqXe
	6h+y72Ev1ymcIa270codAJX8U2Kc+MMoQyRod6xPFbuANyQtZPnmLTw+NhTzCL/SWh59asFiERt
	klF6DZEBlSxFlySFFxIqyP8XbR0mfwpzQN6VWc7aND+
X-Received: by 2002:a05:620a:41d:b0:930:fbdd:c242 with SMTP id af79cd13be357-934a08ff3fbmr1778349085a.29.1785860888300;
        Tue, 04 Aug 2026 09:28:08 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93641753857sm119739385a.17.2026.08.04.09.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 09:28:07 -0700 (PDT)
Date: Tue, 4 Aug 2026 12:28:06 -0400
From: Gregory Price <gourry@gourry.net>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v8 08/15] hugetlb: Use the has_hwpoisoned flag
Message-ID: <anISVv340bo1l9as@gourry-fedora-PF4VCD3F>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-9-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731200802.574821-9-willy@infradead.org>

On Fri, Jul 31, 2026 at 09:07:53PM +0100, Matthew Wilcox (Oracle) wrote:
> Other large folios use the has_hwpoisoned flag.  Convert hugetlb to match.
> This will help us use the per-page hwpoison flag in the future.
> 
> Also introduce a folio_test_huge_poison().  This has exactly the same
> meaning as folio_test_has_hwpoisoned() but can be used when we don't have
> a reference to the folio containing the page.  folio_test_has_hwpoisoned()
> can race with folio splitting / reallocation and trip the assertions
> in const_folio_flags().
> 
> This closes a gap where a page in a previously-poisoned hugetlb folio
> could be observed to not have the hwpoison bit set.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

one question inline, but this seems straightforward.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 4185a03a45cf..4fab3fbfd430 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -893,14 +893,19 @@ static inline int PageTransCompound(const struct page *page)
>  TESTPAGEFLAG_FALSE(TransCompound, transcompound)
>  #endif
>  
> -#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> +#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_LARGE_FOLIO)
>  /*
> - * PageHasHWPoisoned indicates that at least one subpage is hwpoisoned in the
> - * compound page.
> + * folio_has_hwpoisoned indicates that at least one page is hwpoisoned in the
> + * folio.  That page will usually also have the HWPoison flag set, but this
> + * is not possible for folios which have HVO (see memory-failure for the
> + * scheme used in that case).  You probably don't want to call this directly;
> + * use folio_has_hwpoisoned_page() instead.
>   *
>   * This flag is set by hwpoison handler.  Cleared by THP split or free page.
>   */

Had to google HVO, and didn't see HVO directly mentioned in
memory-failure.  Maybe worth expanding HVO to its actual definition and
a sentence on the quirk.

Does "Hugepage Vmapmem Optimization" just report poison for the head and
we lose the sub-page poison information in general?

~Gregory
