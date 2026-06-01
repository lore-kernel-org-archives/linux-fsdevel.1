Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10723D9670
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780326722; cv=none; b=HpwBueZmC9b1P+kC7z8mshkENf85z3UjymcrSUQSL7kZX10kKFfZGk0GmPWHQ2C2HNMvGkySZ6P6mTpY3h74Qcdiuf28nA5KrXfilN48cIczY9kYTlYT9wP1ZUoo+S9X5oeAqfVuEFU4XiCsjZIJ3zMiFBRA7w1r+UjVak/al6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780326722; c=relaxed/simple;
	bh=8AiGAZ9AGhYXHv2C4raQh4+zutV2V1m0Q1sOruQzEj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+0N5+ECIl7udSFcE8TZlmQeEfu7NHgxVYHPsgBacVi/U6fHZLjMuRq8LVfi+yqGanTT9M7wxHGxXnCKSIbbDktLd4SnuzuFoilOjcUXCQ5uSQCWCDAbrPVWjfTSGH++o4bcXRqMRlPhQ/9LMBuwv8QdmYXAEAMJDVOhkGTopoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmjTcQxE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmjTcQxE"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so114707175e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 08:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780326714; x=1780931514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IzS+u3VEJaiahfu1nIf+q6huqq6AwnkcqZDyeqXemp8=;
        b=fmjTcQxEYRzMuPrkUSsXv8efQ/V/1wdm93CQVWn3VdzIpeoYi5N9CYjfM+X2aLFnac
         wEN/ORknjbgG7leLm+f6qgDZdiDjzmqz4VnrKY3jBJL4PfAkD6A6bCHjgI8xxuMQ0hzX
         +sKIQn+x7MSbcD/AhKtszUGpkI3Q1bEm8jmr1SG65iVCGw0iXu7s+BozAItqx+XyHvet
         VZXvt5MRIq9dP1fgf8l3rdN5Y5lbj1xVh/E+fltIoyPy39xUeTPKVwpKctsL6WFbNSly
         O+ZTz82BC+amZAdy9Aqo7wLrdJ9FO0XsJ5jJbQn8XqRyCPw+hQy+fsg+NrrW2osf+GJq
         eSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780326714; x=1780931514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzS+u3VEJaiahfu1nIf+q6huqq6AwnkcqZDyeqXemp8=;
        b=jVW+tUeFtrRDkt9ZYs1ld8HEoFWG09AqF6D+cXiOulO8vkMXA6BMGVM70FxTu/y9Jh
         6H6ga4gUKVuMB40J89J6bJkrVOephvv71EjfkG/Uwjso/zNOcjyKVOvVeysxNb5Bpd2J
         TAF+qseVrV1QAFf9ylpPEnA5Lh4nvIWFc7RA/Ezr0vM7vjwGMYDQRUcD+PubSj6wiaf2
         FXxG5AtQBPFPhxKW4Y8V22a/f4VxESp6QHixJQwtABwKpgpyhGNH6foTB/4AJL2USZrB
         FWow6BExa2wNLmmMsm2HV6pzLcDPCk7K81EBpRKuEALDIo3YF0A8sj/NaxXqB9KQGfq+
         VR9Q==
X-Forwarded-Encrypted: i=1; AFNElJ92TtvYGxOAQlHrgJuyAkGTACEnhWFpWkfTaz+H0qPSYnkbQ4kKsc8GSXM6lxTRMSxj1sIxG/IaGzLdgyBB@vger.kernel.org
X-Gm-Message-State: AOJu0Yws94FtWB2fJQxPDcKVaXkMdQ4P+M2qQvgfjK8K4zJnli/sR08I
	RDsf4R4rzylBbcvNQeL9Y5RIyI6L+5Kx9EwK9/Sy1QCjA/a7/VpsbRB9
X-Gm-Gg: Acq92OGba2F4idEYrJEQAO1JbLeu0OZM461okLlWQyfbcFEqFf5GCjrWKpe6j8pv7M9
	8g+uawnOJah5nhG2SQh5LbuyvCil+y1AkIl9jvw+hJ/uzkuqNIF/Ru45OSYCeHfwwUO52QP1SlX
	VTMyAjjjH/oilHOondK/AY+QjLH+K0L2Zw9dnFu8PLwFathpyehQ5AFPaa4BVWMnY9RmPEa7jKV
	h4fJqrAlsSPM/qLYKk6sl2lAj2A+w0Ps4dMRxs+BHH4F/XZIdggyvWncpe2QLXr/zDJbgZ2rpTt
	EUfcK16UQhryYhdG18nFVjJ5II0nBYhBNjaVup6xf1h3TyMlyQj7v1P1r4vmYtVz+Glk/TUX8XI
	X7hqb3ALQvgpmoJMep5IykXDcr0onbXaU3E6rhwCVsTVibpMzjn6P+XY2G4FRJc8x3eMev+FKJc
	VHP65TrStFpfyT/E30fNyjbJ2Cee9mSqasUdry2hBk8HA2UNJwOiJbeCU+Cqba3cszAkZISDy9Y
	HjTeycsVg==
X-Received: by 2002:a05:600c:c11c:b0:490:4663:691b with SMTP id 5b1f17b1804b1-490a2923a3bmr173930475e9.7.1780326714079;
        Mon, 01 Jun 2026 08:11:54 -0700 (PDT)
Received: from f (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6eb3adsm256613955e9.11.2026.06.01.08.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:11:53 -0700 (PDT)
Date: Mon, 1 Jun 2026 17:11:46 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Chi Zhiling <chizhiling@163.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH v2 3/5] mm/shmem: introduce copy_zero_to_iter() for large
 zeroing
Message-ID: <dvvtrfpacxxuagpexdjni6gpuqbqu6xl2regliuz2zyv6koaok@d6wi2wk64cor>
References: <20260601055704.167436-1-chizhiling@163.com>
 <20260601055704.167436-4-chizhiling@163.com>
 <ah2HfH3jJZDiNAQc@casper.infradead.org>
 <rvvwfa4dp2wovn4vlglajxwpumiudvcgbnrj6fwh4dxtxemawh@rbav4cliyraj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <rvvwfa4dp2wovn4vlglajxwpumiudvcgbnrj6fwh4dxtxemawh@rbav4cliyraj>

On Mon, Jun 01, 2026 at 05:02:01PM +0200, Mateusz Guzik wrote:
> On Mon, Jun 01, 2026 at 02:22:04PM +0100, Matthew Wilcox wrote:
> > On Mon, Jun 01, 2026 at 01:57:02PM +0800, Chi Zhiling wrote:
> > > Currently, holes larger than PAGE_SIZE cannot be handled because
> > > ZERO_PAGE is limited to a single page. Add copy_zero_to_iter() as a
> > > wrapper to support copying larger zero ranges to the iterator.
> > 
> > I think Hugh put this optimisation in the wrong place, and you're
> > perpetuating that ;-)
> > 
> > So perhaps we can start by moving this optimisation to lib/iov_iter.c?
> > And then you can redo your optimisation on top of that.
> > 
> > diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> > index 243662af1af7..06c54d719fcd 100644
> > --- a/lib/iov_iter.c
> > +++ b/lib/iov_iter.c
> > @@ -451,7 +451,23 @@ static __always_inline
> >  size_t zero_to_user_iter(void __user *iter_to, size_t progress,
> >  			 size_t len, void *priv, void *priv2)
> >  {
> > -	return clear_user(iter_to, len);
> > +	/*
> > +	 * it is noticeably faster to copy the zero page instead of
> > +	 * calling clear_user().  Shame.
> > +	 */
> 
> 
> This is a rather suspicious claim. If clear_user is indeed so terrible
> that it is faster to copy, the routine needs to get unfucked instead of
> the problem being worked around.
> 
> I can't speak for arm64 or other non-amd64 archs, maybe these are
> horrendeously broken.
> 
> On amd64 some archeology shows the following:
> 1. 0db7058e8e23e6bb ("x86/clear_user: Make it faster")
> 
> 2022 vintage, replaces thoroughly terrible 8-byte per-iteration write
> with rep stos usage
> 
> 2. 8c9b6a88b7e2f33c ("x86: improve on the non-rep 'clear_user' function")
> 
> inlines rep stosb at the callsite if the CPU has FSRS, otherwise
> fallsback to a new routine which does 64-byte writes per loop iteration.
> 
> FSRS is reasonably popular by now and chances are decent the test jig
> used by Chi has it.
> 
> For a size like 4096 bytes, the 64-byte loop will be slower than rep
> movsb and even rep stosq. This needs to be patched and maybe I'll get
> around to doing the needful(tm) in few days (it's not hard to write, but
> some care with testing is needed).
> 
> I could not be bothered to check how the workaround showed up, but it
> definitely needs to be removed as opposed to being perpetuated.

Maybe I was not clear enough, so here it is stated differently:

The routine was incredibly bad on amd64 prior to 2022, I presume the
claim of bad performance predates the fixup. The current implementation
for FSRS_enabled CPUs is fine and I guarantee it wont be slower than
copying. For CPUs without FSRS the fallback is slower than it needs to
be for sizes like 4096 bytes, that I'm going to fix soon(tm).

No matter what, there is no justification for issuing a copy from zero
page just to avoid zeroing in place.
