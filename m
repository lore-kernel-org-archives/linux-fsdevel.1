Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73857362151
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476910; cv=none; b=n1HsvUUTdWdrtYDqbNFxLt8nyOSEojGTRq6+Mf5jdeFmDoDw0lLbMc68gStcf1+R5VOckyJuGZyjc3tiB7cBisHeIgO3a345ifa29idrh/5V64Dk98qPJoS8fphiCFzpT3hOvbLsiPyNEMGo1xt/gwwx3S7eo3oQPZUU+H1a1G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476910; c=relaxed/simple;
	bh=MPtseMcPFil/hMFJneNT69ahx4akFZE9eLGxGiLszb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g3yyxZ4SL/8kKikBk1ii4XrcYCRs/VyCgQXsSQ444L0f6szN3ZYgyFvqL0hj1qHUdOzghPnU5vQyZJ5ZLKYp6HnXmo5ypgIAwdA5BnR2b5qCe6vCVCI/r3IUQWbBSXw8htmadQEzOZX0f9gXh8/BsetKOemT+ZVOyR9xnqIE4oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laFnhgY3; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laFnhgY3"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488d2079582so148822315e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476907; x=1778081707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DGcwHPSiFxHxYPNUUq+KvwIWZ9lWOTC64lUxpO8JLXk=;
        b=laFnhgY3dEyqcmP1T+nqa7CQNxDjtpkOHtFReQtEHfdCon3XTCMJsO4D6Uo2bzPsSq
         l74nClAxSQzx8C++a1PXm2sQYfi9bscmiyvIBkDveiFpFwMWIF5gXVT+XbleYA4i+Pbq
         zhMGMqSTEpw22lYyuIylGZ4n+k8WDVSFOXpnn8TRyvNB9coXShvrQf+GZV+gwh8NG8nG
         4L+GETBsp2ZBW3rEGpY5bOIFj+lqbGpJWdL5d3yOXk0V8ILmql5HnA9F0S5zUiltAFrl
         EN4S8hqvzJLcbNqPigbYezEfCqFQGaBm+IwkSyCp4rgvTzHFmWe3rvzumKFPp9CLDlpO
         fb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476907; x=1778081707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGcwHPSiFxHxYPNUUq+KvwIWZ9lWOTC64lUxpO8JLXk=;
        b=Pi3Ir87RWxCnInbrKKf1cg5CZ48RktrlQWJa3PtJ/hDo4g53Zj6jR/tkDGYpSq5stP
         SDHeFzDC5eLLuEvVlKFOmqvsQKNwlt0uARb5Lr5X84BTL0kGTOrL8maQgzo7jkYdDOb5
         3rpf6RKPF/mSz6N5T+7CZCY94uY4DTZeR7BzPmQ1jzent1tq4poWViprH/P3eBy3Ttqa
         uM56cWNO10PkSWjUJmws8IrfJ0Sw86CfYgh5nBSpwV7XJWNmu7b/6Kk/Koqu0WGl54rz
         tW22isd89jJnOhDGwZiSlomNBhOh275yuz4y5sgIM0ytbtCr9d98RRCxx+D3Imlh0KA8
         n0Vg==
X-Forwarded-Encrypted: i=1; AFNElJ/3bv2Z8eXQo2SDt1VsqiTQ91RLqfSDxLb6fCCNC3brGCQ/V+rNmdzx/WzQnO5iiiDyoQ87cMCGYtLLOB3N@vger.kernel.org
X-Gm-Message-State: AOJu0YwPENG6JsPJ5dU4iqrRalb3Q1QTW7Py1aVKTj1SnDhz2kTRdxSt
	BCw9RPf7pkEWrvslz8q8cn7n2zuesABOeF8ajtLwvR//WxRfNBU5mepF
X-Gm-Gg: AeBDieuM8JFRofcu5nvbvaxzOaE7gEtk8lOfxVECOh7oP09YWGjv4tq46jE7Ws7cH2E
	nYQRP8LeOm/g+7iWvuhmFtWIffCb9MmzDr98Mc+cSJ8/N9Aqgn6aglfBdndyTFU+pZ639CPlX4r
	YcHTRDYr0w6LM4ji0X5b9sG91JEDDg6uVP8yGK9qvpZEdE6C5McGb+5B04UlweOdd3RzSRHbIlZ
	zHsxvtzyIOsJfTfeMaF8Bb/MDeLINNw2bY3eAH4NPwHSqpDFWH0XMKc4ZiA6xxyUxgTB7E3ltRB
	UoRfyeSTC6AlJFTtpR5Lb2G2nvibAAgx+v/qnpclh7w5ydKxEW4jWg5WGXY8tEYi/C78FspvqiQ
	29Noprr2a1TGzn1pDl2y7FxzE5Zf1gk9TqydnBtjjzLTQqH63F2KM+itru9NWc74Ed050ib5A4u
	9yXfOpxck+dMnE1sTYGIIG46DfJwJVklQbluuMfdQf0hVXcubolLAntf1/6s0wz/DAQF6JOoJLH
	AGjjagpgQ==
X-Received: by 2002:a05:600c:a41:b0:488:8840:e5ae with SMTP id 5b1f17b1804b1-48a7b543f0bmr72325055e9.24.1777476906362;
        Wed, 29 Apr 2026 08:35:06 -0700 (PDT)
Received: from f (cst-prg-93-232.cust.vodafone.cz. [46.135.93.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7bc810e1sm62983695e9.14.2026.04.29.08.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:35:05 -0700 (PDT)
Date: Wed, 29 Apr 2026 17:34:40 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Khazhismel Kumykov <khazhy@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
Message-ID: <xbotidrmois5ygxtqtwqzczkt76wcc7uw5cz5lptda53coaavj@pzvxcpe534cu>
References: <cover.1752824628.git.namcao@linutronix.de>
 <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <CACSApvZT5F4F36jLWEc5v_AbqZVQpmH1W7UK21tB9nPu=OtmBA@mail.gmail.com>
 <20250718085948.3xXGcxeQ@linutronix.de>
 <20260429-november-speisen-3084d769d316@brauner>
 <87340exm2o.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87340exm2o.fsf@yellow.woof>

On Wed, Apr 29, 2026 at 09:27:59AM +0200, Nam Cao wrote:
> Christian Brauner <brauner@kernel.org> writes:
> > The selftests rely on this behavior that timeout=0 sees events from a
> > concurrently running producer. They would fail at a very higher rate
> > after this change - believe me I had a similar patch that changed
> > something in this area.
> 
> Huh, that's interesting. Do you still remember which selftest cases rely
> on this behavior? I would like to study them further.
> 
> > I would explore the seqcount that Mateusz suggested tbh.
> 
> I will investigate that.
> 

In the meantime I grew fond of another approach: have the write side
re-calc the conditon the unlocked side checks for.

While the seqc thing solves the scalabilty problem, it still requires
fences which are not free on arm.

the goal would be to make it so that this:
static inline int ep_events_available(struct eventpoll *ep)
{  
        return !list_empty_careful(&ep->rdllist) ||
                READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR;    
}

can be converted into:
static inline int ep_events_available(struct eventpoll *ep)
{  
	return ep->has_events;
}

Which in turn means that any codepath which messes with either rdllist
or ovflist will need to recalc before it ends up unlocking.

Strictly speaking more error prone than the seq approach, but should be
faster on weaker-ordered archs thanks to avoided fences.

I'm definitely not going to protest the seqc route.
