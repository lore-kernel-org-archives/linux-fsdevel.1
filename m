Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2DB280331
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 01:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785289003; cv=none; b=eVtnelRBev6vZVYLGCxLkkcUajFpCezYNGq2afj4vhMGzTPWaQ/yTky3a3NE0cxTWFkfl/HiDSEwZGbpFuM2j+WeicnIXacqdrGEhF10LGIqILJlLjXT+RU/Cbt/LXV+WV8bRF78zXAZNPUWiqF5afvD2TdX9QqUUGsy1nP/3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785289003; c=relaxed/simple;
	bh=rxgMtzO1XrjpKEt+U4yhEBCdYrzaTxh+D9Ie0rFDgy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWNERqROn3xGJ+a3SRrdSNAKki73rkvaKeDleYVqQIIMz/aICKxuRAiV6NQRpg811FKQ9NMJ61/0iCKmgAgDuZ4wmzZPQapjZw5LO48QsP3muCEZt/+u7zllBVvY20GaqUclwQHoVEuxMqz8mCgIPkMlRA30jOslB08ZnioFPZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bz8FVtoO; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bz8FVtoO"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c0cea8883so3562741cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 18:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785289001; x=1785893801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SB586ydHGWZbCwKFeIZOob7iAlVPrWpwQZgvCFX8MT8=;
        b=bz8FVtoORZ8tNFOYsdGOY7Av8yIsMIoNWwxwu3A40J31RIGD6ejxpEgGYlWtKOr+rG
         JAJSZ4s+EYBBd8/ys+siRUvnKin5AuYId5ghMtEuzICSHWlyjVCioM/SlA1RFnCtudUt
         zcHy9EvmtTfNzp/kG7TpL0AWO1pqWIXvO/7sYBq/FJKI+58SnsBgIXryGBnsfpo1150Q
         wkgoqBJyzJlETjCBy41E7oOea4GXCYot2iSDcuO4PY//FQ3suE9uERbyLjt9fxysG5m2
         9rm9w0yox5uUVksK7BsKUAgYQB80PYPFkgTMun8/1IL5fXI2w4rpecPUuKQd1RRHstXJ
         Rp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785289001; x=1785893801;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SB586ydHGWZbCwKFeIZOob7iAlVPrWpwQZgvCFX8MT8=;
        b=cpuXjzNTggNHDon2TybiYUay/liAU+71NeXkC9/W4VhNGvUPI3YUBQRjVIskQEEL/V
         9WLiHonT5gRj/M81HzLhzKDfjrfcup32exINdRiqVxm5xg/tWBokb1JUMQQqxqRmuA3R
         taS40EyI5c01zGtdVDZLEf4e3eQ/Kl87J6CPVrj/VZvCHQDk671qJhOnqg1ES6FiNGAV
         CVPJK1mbB7fLwGghTIY9no/YCMZ9dRw8cj87H7aZJ6tiTaxGKDF2QzWdZZdw20L7OzXv
         RCtJmHMoV6gj8aZTodYPgNhhP34rhoyPlIPJNn38zDOXXkz2eNWHGWHKQz3GPmel7K5e
         oo4A==
X-Forwarded-Encrypted: i=1; AHgh+Rpx8m3L5CsjGrVN9oQYOQNpNiPEMipF6dAlMQrJnpa/RWzEjdpDifgurLCLbBDTjhQgcTwIKoHme23IDGFy@vger.kernel.org
X-Gm-Message-State: AOJu0YwalYqk7/OlYDe5K1wcyeJuuzc6mrGYDTx25SpfRQ/UL4fKwebV
	o7bnpE2lkNA1NTWw6DdIzMqvjeaxDpw+J6UTh4ROJNU/gVSHvGmfJUUxZN5w01zMjArNEGhFhiK
	RzGyO
X-Gm-Gg: AR+sD13M2/S1CnY3S/ZFfvCgGGpH4QoiiCPEI/Goc7r+2kF7srykPUJodr5+MWjZD0T
	oCQZpszsfHD93RiERVk7nOxsd/FnU0joSW6HU1bmqN430Yjz4kexU5b37B1z6fRFSXOuIgCplaj
	kSpA1z1e0nANcOLbGfbgbOxkgjCO16t2HtjqZptsi6daypWCTfKhcKL66RTx1QbNqgASmXTiT4W
	kznfA4wjWjmFlfPa8kuBXxAxRW+vkPT2DBVIugHBctqv8+lOriC/PZxqGi//gspLdEp8GoX4fnX
	ojU1yTo03S2H3JVJvEDufdtBcM5Wr8x9XqdfN4lqpzRY0Fl4euYVwzJkniGSzg3xn6K8A0IiNLQ
	kk0PnuTXzVvAjSvV6P4kY1anAJlIHeObREoobz1CC41F1HXA8j7Tz/ow1WltNfu+zKGbh26o7V+
	79OMwy4hlFF6qiKqusrD4CCv/o/f4Voq2w6C5/xYPGt5CkHibSqQkBz7DxBn8i4zNbGoqINht+I
	9xnqNwlrkHO4NEIJYu1Tu6sbbN+AAwV9r8zlLkK6vDB
X-Received: by 2002:ac8:7f42:0:b0:51c:b91a:33f9 with SMTP id d75a77b69052e-52b2ad31474mr2986601cf.13.1785289000917;
        Tue, 28 Jul 2026 18:36:40 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dc496f7sm12776896d6.3.2026.07.28.18.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 18:36:40 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:36:37 -0400
From: Gregory Price <gourry@gourry.net>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v7 06/13] hugetlb: Use the has_hwpoisoned flag
Message-ID: <amlQYkGgLmxmwX9_@gourry-fedora-PF4VCD3F>
References: <20260728204409.3396238-1-willy@infradead.org>
 <20260728204409.3396238-7-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728204409.3396238-7-willy@infradead.org>

On Tue, Jul 28, 2026 at 09:43:58PM +0100, Matthew Wilcox (Oracle) wrote:
> +
> +#ifdef CONFIG_MEMORY_FAILURE
> +static inline bool folio_test_huge_poison(const struct folio *folio)
> +{
> +	return (READ_ONCE(folio->page.page_type) >> 23) ==
> +		((PGTY_hugetlb << 1) | 1);
> +}
> +
> +static inline void folio_set_huge_poison(struct folio *folio)
> +{
> +	folio->page.page_type |= (1 << 23);
> +}
> +
> +static inline void folio_clear_huge_poison(struct folio *folio)
> +{
> +	folio->page.page_type &= ~(1 << 23);
> +}
> +#else

Took me a second to realize why this was open-coded instead of using
the generator macros.  The reasoning is buried in this comment:

/*
 * Check if a page is currently marked HWPoisoned.  This check is best
 * effort only and inherently racy: there is no way to synchronize with
 * failing hardware.  The caller may not have a refcount on the folio
 * containing the page, so we must be careful to not trip any assertions.
 */
 static inline bool is_page_hwpoison(const struct page *page)
 ...

which i presume is referring to VM_BUG_ON_FOLIO() in the set/clear in
the macros.  Might be worth just note here if only so no one comes along
and "fixes" this or writes more of these without the same reasoning.

> @@ -2725,13 +2748,19 @@ int unpoison_memory(unsigned long pfn)
>  
>  	ghp = get_hwpoison_page(p, MF_UNPOISON);
>  	if (!ghp) {
> +		spin_lock_irq(&hugetlb_lock);
>  		if (folio_test_hugetlb(folio)) {
>  			huge = true;
>  			count = folio_free_raw_hwp(folio, false);
> -			if (count == 0)
> +			if (count == 0) {
> +				spin_unlock_irq(&hugetlb_lock);
>  				goto unlock_mutex;
> +			}
> +			ret = hugetlb_clear_poison(folio);
> +		} else {
> +			ret = TestClearPageHWPoison(p) ? 0 : -EBUSY;
>  		}
> -		ret = folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;
> +		spin_unlock_irq(&hugetlb_lock);

Adding new synchronization here without noting why - it's not
immediately clear what this synchronizes.

Is this just fixing an unrelated bug / should it be a separate patch?

~Gregory
