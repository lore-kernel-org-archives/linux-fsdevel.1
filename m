Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA823D7D7F
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 21:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927264; cv=none; b=fVYmtFhbq/Pky9AepT+TXeEQ9NsQRfU4hShPiV1z3uwFOF2q1QZ+qm3L12FmETfivONcDuPaqELogp+zZeSpLytTJLjB2P6hfVWBpcwDoBoHwM+5it27hCn5R7IcNRq4Qe35sLvm/W7OYITPi/WKelbpr/H1nhONASHqNKoPck4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927264; c=relaxed/simple;
	bh=Pw2tqvos94mI7QGPy3m2a/zY5Z2tGHFm3BFgYMdBLOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltMf8yZSLqY7gxvKvC4igvouy/uEbUbjVFEmHI4T/P8HTJeU0DvPOjkMa+cmgwGQmAMasWO8uZ8Y5goa1glqDlMADijSgzulWYX7EKZ8SJuOJ4qXqylYWg4iqgItQ8NaCJDp68GpnvExt0f0ru2pKhPq7vPC2K4OWewD86c2mmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WUD4YKA3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pDgxh27u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WUD4YKA3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pDgxh27u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784927259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3+l6zQ2UyUka+UgzsNomoD+GF98S9wcKfqgbKY9mofg=;
	b=WUD4YKA3tqvx3h0i09l3su1uCwUFkKw+Bsx2vIE6dq3HavuEhI+jWbGCnDr0Sl+ND0jzdU
	PeF4FonlRymk/6XtQW47Wlse35Vyy/tB6SZ3IsQuUle2m6BlYEOlXqOuPGxShC/1oKkgEJ
	hzPujvcG0Uw8G2fkMtF3Bw/x5nzeULs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-RIceij_GO9KyLVBmoax7eA-1; Fri, 24 Jul 2026 17:07:36 -0400
X-MC-Unique: RIceij_GO9KyLVBmoax7eA-1
X-Mimecast-MFC-AGG-ID: RIceij_GO9KyLVBmoax7eA_1784927255
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4955fd77c18so5434485e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 14:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784927255; x=1785532055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3+l6zQ2UyUka+UgzsNomoD+GF98S9wcKfqgbKY9mofg=;
        b=pDgxh27uec8OcWm0AW4Prb77q+U+jZqzCIQoBBWBZQEu6ux18XlBTWt9kPHyEinlNX
         UDi6KXJRXcdHm+YqNpQRqelmZBKYIJrrC2PW3lRTdCXzXsnFsulzNthwMslNIcNpbgqf
         HbhjWiPacYs/DithsriKXqUSKRyftgqnLPWO35GrSJH8dlNFHIbvqmoTNpZE+mE1aVOm
         B1Z0lWbWTexmxeGH3qPLCEIdCND3XP//eH42NJQDxVGpEGqbFdw0/U0Ni7vy4ERZKkPL
         Q90L3VXVxte+0pFxNM8K8aMlIh3BXPCf6WtbR1VlK8zHuKM8UwNFszpI5zaOkzi0Havz
         iJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784927255; x=1785532055;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+l6zQ2UyUka+UgzsNomoD+GF98S9wcKfqgbKY9mofg=;
        b=CkkBVjL3U9d742mbxSGnQzMOIRRxqEGKYSQnFWRRypdj7uxuxeFIpiczRXd36GeW4L
         YXv6EmRtLQkaIFLN0a6Xd6MmxAZY1iXHDfUcaSrQnuXHzyrCwBMxA8530pl/sVOBoPLX
         WqQse2iCyzqO+Z6hwC6scAksNH9ggIkx4ZoLDk0ZL+b0DHgF0qwL67u8owzKkVQywXno
         Wza9OJvZCX90fFpgJ6NZNXx3GFudIURrCDOExQ/Pl0Q6zWkeaMj+4JcBa3zVvRqqX5fY
         RH9CN5Fsoz8b8X/jDPuUBhAGb7l2aGEaMoDAdjgRPGUZkTZCNR4VXbitpkf0687SaE9S
         W2ZA==
X-Forwarded-Encrypted: i=1; AHgh+RonZXsfE4HgkZxp5rU7a4GVh1j4cENHx4ZGuU1CptIEJPTG8o7VovLQvf86QPtTsBy4SC8vY8X3N+icCS03@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm61Mx2cuta9JKeVRrktHu6O9X039wSW7Ou9W0mXI6PSD24QUT
	vKXJdMMypSMQJsu+DJ45OI9s+yIx0c7EjHmLzAXFhBdX0AkIOuCSTN++8MbHf6FAeeQyI/Gd5OB
	sfNTl/Zh+9n0sUGnKaagWPJb6RhtDA4h5yUdlCYjFwONeiKEmd8ly7TwLBGkCUydATsQ=
X-Gm-Gg: AR+sD128DFWhrhQc3Sk+MvWBM2c1VFmV7XzVfStSAB5+EbJxdjMsbBXY1DUyzpxsE/Y
	GBbyHSD/I+owenOeWmRajC2O5hCgFDmAcGhLys1J3iN12cFvbySSCGuR4dlcfhLBb0WJBXQidJV
	xfJwFWlAQCxK57ZKykgPItLl3XSLkifmr5wJ8Z8cjikZZnSlLKAYlECD11ziu/jaLpZTMASTWbU
	9H6VqCnvyg+hUS7h9juA3dn3kcQmx7T/Fqkmz/lrG3LdB9Xx2BB1YyanPu4y6N5/0tOK2B9yoAU
	5mAhsguWVyRN5uVy7qRa70jLQAC9YUcL/He6DGYv/meWrfB2lADed2p19FGdBbO9mCEwIKJuLXN
	iE3+7ze6ivoRr+rl9GGeXnEpZjrvYPBI=
X-Received: by 2002:a05:600c:4d06:b0:495:7a23:1eee with SMTP id 5b1f17b1804b1-496b56f39d0mr19015e9.12.1784927254860;
        Fri, 24 Jul 2026 14:07:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4d06:b0:495:7a23:1eee with SMTP id 5b1f17b1804b1-496b56f39d0mr18715e9.12.1784927254347;
        Fri, 24 Jul 2026 14:07:34 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net. [79.177.145.168])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ee4504sm11539515e9.6.2026.07.24.14.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:07:33 -0700 (PDT)
Date: Fri, 24 Jul 2026 17:07:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Sean Christopherson <seanjc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Michael Roth <michael.roth@amd.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v4 05/14] guest_memfd: Use folio_has_hwpoisoned_page()
Message-ID: <20260724170606-mutt-send-email-mst@kernel.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-6-willy@infradead.org>
 <amNeKcDZ66VrQ5PL@casper.infradead.org>
 <amOByZH4oWzmO3Zj@google.com>
 <amOpRMpkyFGm0j9c@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amOpRMpkyFGm0j9c@casper.infradead.org>

On Fri, Jul 24, 2026 at 07:04:52PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 24, 2026 at 08:16:25AM -0700, Sean Christopherson wrote:
> > Heh, you don't want to sign up for a week or two of onion peeling?
> 
> Oh, you have no idea!
> 
> Here's my onion so far ...
> 
> 1. I want to simplify filemap_fault()
> 2. That requires changing all the architecture fault handlers
> 3. So let's push some of that down to the MM with a new wrapper around
>    handle_mm_fault()
> 4. This would be easier if we could hoist the creation of struct
>    vm_fault from __handle_mm_fault() to handle_mm_fault()
> 5. Which would be possible if Jane's series to fix hugetlb use of pgoff
>    had landed
> 6. Oh, hang on, handling hwpoison on hugetlb is actually broken in a
>    few different ways (some pointed out by Sashiko, some I noticed
>    myself)
> 
> I honestly thought I was just going to rearrange Jane's patch series
> a bit and resubmit it, but fixing the hugetlb hwpoison handling has
> consumed me for the past couple of weeks.


Last time I tried to fix hwpoison, i wasted untold hours on it, only
to decide that it was always racy and does not seem to be worth fixing.
At least yours isn't a race.

-- 
MST

