Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2AF30F938
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785870941; cv=none; b=U4kGMa/U9ldWUo3YUGwIbpH+I6CvsBRyDMWxq3BS0jopvx1u1GQhyYWHnhRVjX6RSxGe8hOqS+Rqd9fPtcOMc4WUD8temxvIGLXBvksXhO5PWAVA52eXsIUAPvPF0SARxWeJrCtSg1HrOtozmJGHmbWaJV9+oC/DJZ13BvxNYUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785870941; c=relaxed/simple;
	bh=BRJRgqVzw8tzW9n3dNOPAJ88xu1B5vDrpU9FzebZmwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bt3wSEEsMRb5IxKzLbMJjHaSK9WwCvQhqc+a7YPpb2sd0P3i1SjQ/syOkEbr3R5l5M0XFy8wRKbYostaRu4OD4B2GxrNE14nbN3xeLXiegznZc3GJoEuIqtDNmmf5CTpGGRsxcpq8/GN+xkj0SJiLYRHeBYkA6TctNSX+u4yl/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AXVzQWU6; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AXVzQWU6"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-52cd38ddcdfso821431cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 12:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785870939; x=1786475739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k1Dta2RSeoe9YdJLecTqGrTMMuZ8ntJIXx9AmBauxos=;
        b=AXVzQWU6y1ENCr31nnkqYtnOU6rnDvSRJaYSIp++wqms+ILFNYT9ffWL9TaiJ1T2NC
         5SnrhCqfLM4oEwG1M7hpPZm6z0vYwB2Xr2WMZJhDzxeGRDjPPLD98r0oM8ltClw/MPum
         ZYPUIE7ib8lWMSbhP5n3sp3jaCwfcxJ++JIcwnUTYCIK5m8LhMMAHWPZQXLzh4pAlxSc
         qQsXeeaKiGp5tPbfV9tdzN7vSN8FrElK4/0YTOI0Bcp4RdGgC/PPbxTXmIt0qU+crCd+
         g4y0r+Rwzh+aFCoTpF9A9VPDxFIKH6Y+bGJ870sOVjDPNsLQe5XYv+VJiAYYrAsHZIwJ
         XTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785870939; x=1786475739;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k1Dta2RSeoe9YdJLecTqGrTMMuZ8ntJIXx9AmBauxos=;
        b=f71ucQqHpJo/ane4cJxZ/CkvYDUCOVFyviwA3LW5tyQLbpBqroMUfyuGzhjgVOvenb
         twk9l1fBgwlO5tx7BGn5x6Xr6Of5w8cZ1wM3jleU4SMsqLK06KA3euhPpwmW7Q6WjIDU
         NUe9NzucMlRJuISfNmMRDeTF5V7JF8P6KDqGURgg/NZNyMUQUkkeb4vxU8fChNGtXVHn
         A1Bjr1f2Im7C2a4eq9uySsuxhT7FHpLR5mpPim1n3thh5Xm1EQyBXzYfDANVKyRb7cBx
         p+vA1S2lK+W2bWTr3J28j8K6dbADSzrFc5bMqUAxhW/DNiqQIVkfFsGzJtzpWhbn5Ppc
         ELHA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1dCslvLSEPg4H3+ffbxPqvT85jC2/b9WoPyYNrezGX8b9j1Bhye5gb8XG1tKDlJGFdpw+Gnk+OKikfxvE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyivhdeh5uR6XSzb/r9pTbvqlKDFIHrs7kuLceSXJncn+ZOI2du
	rK5WzelWGnJz6Zt1D9uUVUR32aJr8K2OyiRlEfkBoS2blE5kGtWNWUKL4ree2B521FA=
X-Gm-Gg: AR+sD10JjTi6zbxr9j9ThmuJhY1ZhoyAAnACAlDa0XNGE9fGkn1v8NI9IbX1DmzvMsh
	2Q5DYRi+0Ttm+ci5UGMUdhWVR1zb5Okwxmi/IZVCya4K6W9CW9+PIe1NohimeER/lolmXznh0JB
	EaJ3mu0IQLr2w0Ccd8XSDsoPDfWLiW/Jx0EPDOAg8EfS6yMzQA4rpG0zxmi94oZVcN/iDDh4Nlf
	CvNXuJuCsmpaTlfQsu5vbLz5wJAwZLSVMhSqv7sbwUJQWhPWnviuZUscS3tlx/kM0mBZSFwXt3e
	8Cq+dpCw4mPIYy2dO44LTWmOvCS9eGJ++qsOxmEEPX3rsGgQxQFJJgowtEkfvnuI2P7sDFHeX03
	Qh+D66eWG+6SwqvsgqZVBNCbGwOvRTtkkSI3XdygS3RuKY15CIEpcW6mzHQVw+SCefMVoUwoqVy
	xvgNvXMK9/3tFGKQsFSxQ6RNAb1G9Js4NBORVulpqBd0NAMldL8DHtrd1/rus/yYBfQxSSCYpkE
	7PAVKrPgVRyvmfG9FAY/UPUPr0Xq4F0kIeA7sWoqlIt4w==
X-Received: by 2002:a05:622a:4c14:b0:51c:2633:9ddd with SMTP id d75a77b69052e-52ce61eabd5mr16510221cf.41.1785870939179;
        Tue, 04 Aug 2026 12:15:39 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9087ff9d814sm8251026d6.10.2026.08.04.12.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 12:15:38 -0700 (PDT)
Date: Tue, 4 Aug 2026 15:15:37 -0400
From: Gregory Price <gourry@gourry.net>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v8 10/15] mm: Check individual hugetlb pages for poison
Message-ID: <anI5bPVScck1WXvh@gourry-fedora-PF4VCD3F>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-11-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731200802.574821-11-willy@infradead.org>

On Fri, Jul 31, 2026 at 09:07:55PM +0100, Matthew Wilcox (Oracle) wrote:
> +/*
> + * We have no reference on the folio containing this page.
> + * The hugetlb_lock keeps hugetlb folios from being freed.
> + */
> +bool hugetlb_unref_page_hwpoison(const struct page *page)
> +{
> +	const struct folio *folio;
> +	unsigned long flags;
> +	bool ret;
> +
> +	spin_lock_irqsave(&hugetlb_lock, flags);
> +	folio = page_folio(page);
> +	if (!folio_test_huge_poison(folio)) {
> +		ret = PageHWPoison(page);
> +		goto unlock;
> +	}
> +
> +	ret = precise_page_poisoned(folio, page);
> +unlock:
> +	spin_unlock_irqrestore(&hugetlb_lock, flags);
> +	return ret;
> +}
> +

I ended up with the same question as sashiko - i think this behavior
implies we must hold a reference on the page, otherwise the folio can
be invalid and all these accesses are unsafe.

But that must be the existing behavior for poison checks like this, so
this is at least no worse. Not sure it's worth addressing.

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

