Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84916253B58
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285577; cv=none; b=WG7+/vG8p5jQnJHXEvMnlcamUOVwQ53zT9lwoZI2e3qj8Q0fP6atv6nwj7U3Z3Z8uZgU3lUqN7j0P34rO2D6V8daumgMkvDJpu6K6Odei2KYD5uDGdvUFytQspu7if0Mds9VKTH2XdaxCIIbbWT8XGcOxZtkk/isioWMIfCEEJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285577; c=relaxed/simple;
	bh=tR9BDwOT4T6ohKA/vo0ygpL2d0SulS2OAQodWSZcz8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmp5gAS4EgeCKyXFMRcVdivNWoWrd+Zl5nI+2MR4v1nWaz6OqstBl9Uy9n55NOihAU+vg5VTqhbCILjV7WABB7k2A9nUQLxuMKLsIzo/am8gKIPwG6fTnJJzRjEQGOJBQGpRf6tTedwIdCQIzMEbCXeoIsPfZhHgkpuGjuBUEr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TECpgmPx; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TECpgmPx"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8f1e274ccb9so2390606d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 17:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785285573; x=1785890373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hlDfDH8fw0HdMBSkD+M9GnJly9TjD4Ns9P6nYByTcGI=;
        b=TECpgmPxdYCNdbAZjMwHVrvu5OHV28nJ9fByi8ZVptlqq+ZCJgfrRUu83786lZsZME
         iSF7OoLe6MI2gSMHfkezpcVSIWdpUrbVgxpxjAXmvHncxCQYiuIoC7Jqzmr17tTToPnc
         jpdfNu6uTL2ps4UnmYGyf+KdLO3CS1pRjVq0RL8pAuyXUv5TdKAQTAIruSyfuQ/EUH0u
         J6czNed9L4hyVxsyq7FW30dzp3WORO+ZfXRjKXHWaYjp0iKyob1Kk/7E/21k2bthOWx6
         j/r915WIEKZNv4oLfhaHeEktu20qVYSS0mfPB9gWsPqPddQaSq3ihtifK08fuOtuM5+W
         T2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785285573; x=1785890373;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hlDfDH8fw0HdMBSkD+M9GnJly9TjD4Ns9P6nYByTcGI=;
        b=M8YoXSf6Vb6hckrI6xfGRRJFbvCLx3UWtwd+7aJvpWuHeyz+EzmzRIWqmuMOVrWtBO
         TwkXMtZMFQCkx+xEwRukEyAnoOpZOEt0nOHfaIwk+kgmTFdkZg6gZLQTlpyNPMSZ+im/
         3td08w4uyq7KtX0Ek+t/5BH0+YjpUfhjw+JuXpMTs9HuX7ghN8aGgl6DfbWkwKpg/1Sa
         7UbuKssafK8LB6NfWU6E+/tleiCR8lyQunNVYc/X5hWK0lzNIB1pXcO9PpPq0e1ZjWeF
         U2uygO7kkYNc+PHGbzUzMX6zll98aTuQ/CiJhBJSpdPYXo/mcQC81uAhoIlt4d3HA3u+
         xGDQ==
X-Forwarded-Encrypted: i=1; AHgh+RpGTXJV+DipLHsSyXjSbbomNRSSfdkd0kYXQ8LtJDBdxD+tuXmiUoU/R8+TVD5y7H0WL2+vOdJbFKdrithQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyqAx381cWzgh5GPOVa9oZMQ2SUxlTv5rK/JbRUbuVOLg3HAG0R
	TaPVmzUmYowmMgr9Fo5eM+2otsBXfsUZkQPSTfyp4qsz8b8RVZL1L0CNoijYN58vEUQ=
X-Gm-Gg: AR+sD13diDoFQ7C+hsKrNKEcY7S//XM1hvuraUEJd3HyxkPfy6zlCkcD0FYsp0kPMST
	KK1v8J+2Rndv3AmzxiB3fb96X0PJ/+KcJ2FEK+Hw5aL7jZLAWe5buJhwTFpGaor+b9/C7iMMQul
	2CftVdcaEaKYIRA8ClnZRMhqZFiX7OnBnvZqeXcdG2W4tKcIWp6dZmBMySZozmISKwQ+DnZtJ/U
	qecXABY2frH4PAMNoaEHKd6PKsYgyDh6D3DZkzgdaud8e1IGXo9vBMvUSXYwXrAsrVIqrPlhK7O
	iumy1zKfTPQw+MdEb/oboUjNh2g5/mUKjy91GvxBhkoCWB/Nc/Sefz2v/VEQsNqdDIkqBi0pFO2
	vUZbiQUd6HH6uTljC5p1YL3ZW9s7JxkMz81LhZF/G/op4A6iu0QsFoi/BKXQ5ykBAnUqEr98Qb7
	AOEPkyz/dsMpGkluToZlw/CIkkZBbeXW86hIerKizzUmQ2zCHy9hG6lWe/4YxyhG66jQ7q2CTUw
	kCfbfxHea7puVZ404FEJTyQNr+FaT5Kn1yN0jpGm5gAixpU++Zrd+sWUXiXbuce1pk=
X-Received: by 2002:a05:6214:4114:b0:8fd:6df3:b379 with SMTP id 6a1803df08f44-9081743d851mr51993906d6.61.1785285573375;
        Tue, 28 Jul 2026 17:39:33 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd91080sm11772486d6.49.2026.07.28.17.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 17:39:32 -0700 (PDT)
Date: Tue, 28 Jul 2026 20:39:29 -0400
From: Gregory Price <gourry@gourry.net>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v7 01/13] memory-failure: Fix hardware poison check in
 unpoison_memory() again
Message-ID: <amlKHkemYQBxFESG@gourry-fedora-PF4VCD3F>
References: <20260728204409.3396238-1-willy@infradead.org>
 <20260728204409.3396238-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728204409.3396238-2-willy@infradead.org>

On Tue, Jul 28, 2026 at 09:43:53PM +0100, Matthew Wilcox (Oracle) wrote:
> The earlier patch (6c54312f9689) that attempted to fix unpoison_memory()
> was incorrect for hugetlb folios.  Before a6fddef49eef, we checked
> the head page for poison (which was correct for hugetlb and incorrect
> for THP).  We are currently incapable of unpoisoning pages (other than
> the first page) in a hugetlb folio.
> 
> Use is_page_hwpoison() which handles hugetlb pages sufficiently well for
> this purpose.  This is racy as we don't have a reference on the folio at
> this point, but fixing that properly requires deeper surgery and this
> is a CAP_SYS_ADMIN path only so this will do for the moment and can be
> easily backported.  It's no worse than the situation before a6fddef49eef.
> 
> The other bug in a6fddef49eef is that we currently clear the HWPoison
> flag on the precise page, which is wrong for hugetlb.  Fix that too.
> 
> Fixes: a6fddef49eef ("mm/memory-failure: convert unpoison_memory() to folios")
> Cc: stable@vger.kernel.org
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Just trying to wrap my head around the state before/after, assuming
the following is correct then LGTM:

prior:
   pfn_to_online_page(pfn) -> p = precise page
   PageHWPoison(page)      -> checks precise page. Poison for hugetlb
                              is only set only on the head, so bug.
after:
   is_page_hwpoison(page)  -> checks precise page AND head (if hugetlb)
   p = folio->page         -> now TestClearPageHWPoison() explicitly
                              clears the head page poison if hugetlb

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

