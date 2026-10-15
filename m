Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C992B50AC05
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061657; cv=none; b=SFSJXDLHD+eQvZipiuIKtdvTfErDHFE2+Gs/sE3jnXpQlUEVsx70Zew4nDIq7byBXEbVlf4TWb+uqcln0BVq16/h4/mYakQghml3QpMhWWNX8gK7UhlngFx7864Rh+N7V+RovgngeDypOvxBW0ruJX5zNgBRVQh/2OD8ggdkhO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061657; c=relaxed/simple;
	bh=XF2hsS/QlnZTmxGFa4yiCAWY+VKnATHPGqUwRoR83RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T87oxLLuRvDqiPF7SN7Y6HJ43oNg27rMdOAF4bqHWJLc7xd0XlWKcZERsOxe1JTOh7znMjy/MWQig71aY/fwKAG9A4X96Nlt/Kw+1kkfJMc2BHCMxuH0Sd1ln+H/kdc4EMbH0pro/qpIlke6qZ7kcGqqATtx4ElHZofRKBWnrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TuwXhNzp; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TuwXhNzp"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c4be28b82so273022f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 03:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1792061652; x=1792666452; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7GiFJNEdHCyl9o7lyZvAVM97bzBWzN9FAsadD1M92V8=;
        b=TuwXhNzpqiD4HcR69AkdwToM912vQN0w1KUGG9FXCPnImjyTNDV6LtECJ6hG8kBGAi
         1eEe1opR2kPKbMYvhC9vNKa5IrdeyL+w/UpEAjDF92Y753zzfVhLAjcei393FKp1mLc6
         NhXyYAN3mEGXIzyV9jxUyAhiIiIE8v2yZIiZQDAHCUpJStKooB3c38dEAJ/lEyiwZ1X6
         pzOn9jZJGDyYZFTKh6ZcLLgQW1AAfyYlxkjqyX/dv6DowL+hBaxcLNoomz8nZ2E+XiQU
         kZfO+a7jeVY5NHfqRbii91R5bLin9Vy08gAvmlxnWnYNoFQo0lBY3/HZZEHdz/vjncY/
         5/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792061652; x=1792666452;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7GiFJNEdHCyl9o7lyZvAVM97bzBWzN9FAsadD1M92V8=;
        b=FrqENzI0b2BKgb9ijpXPyJPNc9lCjABwZlxI94E/kcWfWj8gwK9DyyNp3d9qR4DTrT
         Euo4yd0AVLEWBqT1esIPlF0TGBZyLoR+5qixYzzK9sBT/rr2UNVophTBvK6121qKjG7r
         QjeWEayLMPnjiH9zuCorQIXk41inHiiHfRbEs3W0rywgEZMz5McbNLU6qD8qKlpsuZsi
         J0elOnRskFQKzZsjpojlC1qDn7j0UyjMTjBB7OYuGqJBeVS0CEhyuTEPvdQgFZbepOL6
         g90rYTc5XXic6sGtb5Up7XPCjl52jhYShCrAyKWHZcExH4wAapLMKM6JWLXjeq41eMg2
         CvzA==
X-Forwarded-Encrypted: i=1; AKwUvByu+UP8NPcj4mDVwhKmlGKM9s8I47uxMx0Mbu9FPZ8lJS3YQNiPHM2z8IHBZKpEZ1rsIiC6E+/2eNRn+AvM@vger.kernel.org
X-Gm-Message-State: AFq9FYInTnTIkZwUypfXcDkCd84WuFHoYnwb1kYWtN9q3bStGQpKaGtx
	INBLWco1q44aWwP/kGFWykYb9F23kNTYOyLSiF/oAEkElCifEE86xyrezYe+LTXI5h4=
X-Gm-Gg: AYBFou0NWiHbwoJop6OdkmYj4NAgWTxv+wWRUFJqGVBJA//hrJcryzBIDOjj+2avOoM
	XvKVVL335EoBosrkHc7ZDo9Q2m3eqORJ4Z/wb6K4K+ylKMc5tWDM1bCZSkKNgySSAnBMI3HDo5w
	9G0dZZ87pB5rOjftKic2AzE+SvzRPUCFG2y0gi/GeNWL8MUUXCOT2feNDP1mnHju7jFRLS2DYgV
	iKDuvnvSWy2gL9AtHTByhjWmaXQXPMFlFnc6FlgT72Z6BX6K6R4uE4eKZ0J5I3+j5I/jF61fByO
	0oj4IafZUncnlhNoCAWXq7vDPjku98cJV1ssYIAfKLITBJS/7GnFuE52ZEA41bLi0yNbEIxGag7
	I1Xg/35IW0FIvENnm9UJ61IIBk9HM0MyYDVwZpHSbPodAbxgzn4rctxHKoiiPyHvJbl0ljlygBB
	ciMtL8EZJ7uyHiHHy02/HPAhXMR1Sze1cQJ4OKr/HY1Fsp1fzRv6sZ4QTj5TB7niKP/c/6jOuOc
	qXm+6aiAwXo
X-Received: by 2002:a05:6000:388:b0:48d:ed0a:e064 with SMTP id ffacd0b85a97d-48ded0ae0b8mr9811826f8f.24.1792061651748;
        Thu, 15 Oct 2026 03:54:11 -0700 (PDT)
Received: from localhost (109-81-30-108.rct.o2.cz. [109.81.30.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de77606fbsm10461734f8f.53.2026.10.15.03.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:54:11 -0700 (PDT)
Date: Thu, 15 Oct 2026 12:54:10 +0200
From: Michal Hocko <mhocko@suse.com>
To: Ye Liu <ye.liu@linux.dev>
Cc: David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Ye Liu <liuye@kylinos.cn>
Subject: Re: [PATCH] proc: Move OOM-related procfs code to fs/proc/oom.c
Message-ID: <atCw0gk77fF5ISQV@tiehlicka>
References: <20261014-oom_procfs-v1-1-f2d75e73571e@linux.dev>
 <as9MG_BtepLV6DsC@tiehlicka>
 <e51c14e9-5559-4ff7-8a38-de815a8f8230@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e51c14e9-5559-4ff7-8a38-de815a8f8230@linux.dev>

On Thu 15-10-26 09:32:53, Ye Liu wrote:
> 
> 
> 在 2026/10/14 17:32, Michal Hocko 写道:
> > On Wed 14-10-26 16:54:12, Ye Liu wrote:
> >> From: Ye Liu <liuye@kylinos.cn>
> >>
> >> fs/proc/base.c is a large file (~3700 lines) handling all per-process
> >> procfs entries. The OOM score, oom_adj, and oom_score_adj interface
> >> code is self-contained and has no dependencies on other parts of
> >> base.c, so move it into a dedicated fs/proc/oom.c following the same
> >> pattern as fs/proc/fd.c and fs/proc/task_mmu.c.
> >>
> >> This makes both files easier to read and keeps OOM-related procfs
> >> entries together in one place.
> > 
> > Are there plans to separate other functionality or is this one off
> > thing?
> > In general I am not against of moving stuff to more specialized files.
> > An obvious downside is a review as it is quite easy to overlook a subtle
> > change when moving so much code. Something worth undertaking if there
> > is a bigger goal. Not so sure if this is just a one of and fs/proc/base.c
> > still keeps other random stuff in.
> > 
> 
> Hi Michal,
> 
> This is a one-off move specifically for the OOM-related procfs code.
> I don't have a broader plan to split up fs/proc/base.c at this time.
> 
> I understand the concern about subtle changes during code moves.
> To address that, the patch is a pure relocation with no functional
> modifications — all function bodies are moved verbatim. 

But you do understand that I effectivelly need to redo the patch to
confirm this is the case, right?

This is something I am not particularly thrilled to do for a single
isolated patch without a larger plan. taks_mmu.c will remain a huge pile
of code after this change. So what's the point for all that effort?

-- 
Michal Hocko
SUSE Labs
