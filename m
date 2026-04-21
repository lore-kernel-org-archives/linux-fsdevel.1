Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D719E839
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Apr 2026 02:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776736917; cv=none; b=t4bG5CPAdhvz9Q4IVqRTY515/iCRSVDf4zl4N6+qM0OvwhumB9nxUhgF15a+ymMuSWsNIINX9koVyEdSgRrpnkoriKvx7Hgeq9IP2khDg0niOJk34z42R7u0IreH8y5gZm3KLk+2mPHTEm90B0DeBHlxxAFJ6RMfAvY2r+IZ4Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776736917; c=relaxed/simple;
	bh=l9bRz9UeCPAV9DA8Zy5r0ie/prB1/Xr8Z+QnqVjykhA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=YTksbPcsLw6S5nA/qaMckbJFGYgVDw3SFRcGL1YxeEfQBa39tBVojBaxnSuteABEZydwpo2VpbOi4Pj9MarR1uLk6nJoYBunUG+HmVl94Jf+F64Qai6ELZ9jK+uBLIfpIWSiAgjUC1rB71hNm1sYaoh6QFbioCD0ZqHl4uufYTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XskVbg+B; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XskVbg+B"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2503753efso36043965ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 19:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776736915; x=1777341715; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HAfyiA5fxqYXT4gYRX9zfWikwnCgQwE5e6No9OGkL8Y=;
        b=XskVbg+BJsj32X8H+Rf6+BXY8Llvyd4yvTB+mmbWcDkA4v3GBhKwVjRazy9zkOig2F
         AU6Fkl9QCa2PEDPsghPR4e3v64RfZoq7mjp8DkxoGFQv/yfhWgiDQZ4umrmGHfjos8Nj
         7B0KwN9ejXrLewIz+edRFUmOl8F81dtnlpQV6qAkW1NfsS8s3xh1PZgbRHfwA12NxAUy
         fL4Xm3DisCW9om0yRpixnwxFLAjdgLCakxCQDVMatIqYPxBSiRZaNsfDNI5N1aMuiQz9
         38EozjmEDteXe24b68MG4VTErQ64u7m8Hu7zJNcVw3DJb05GLVtll5pTE+PxUUBpkSpz
         cEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776736915; x=1777341715;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HAfyiA5fxqYXT4gYRX9zfWikwnCgQwE5e6No9OGkL8Y=;
        b=CeUEFWD0RodNXW/Cu4wv7YsSdwECXPGoxTA+MMyJzBPfPAC7m2BOInoIN3LaR5sLEj
         FYO2K9rdNYP0kd2TSbXqVeu4Y4/uCt3utdrDKq/OaPwCTfsmKCIey8RqS6hzeMkTzmRr
         3CQaNWK31UpieiRqSicvb1DFG8OG8rfMm8gTrNrXcQtmZRC6l9ZdaJpGutq2ysLJe41u
         sV9dO4p5eW27y0x0nLo7o0ZjN6Lywo1qluR200oxXzfbvGh220idH+ybCIMTLs8uhCG9
         8cysKUx0RPBMkjbTvi4wocKC0qsjeaEsW6b3wVr+lPCpSLllOXttf3Ndvnxsiw0EfThi
         je2g==
X-Forwarded-Encrypted: i=1; AFNElJ9s/UIMZ96uDPJ43+PIoJWbOvL7mu0Tb3XveXve73E4AkwmsJN054l8gPQqWFiX+48xOkN0z6smHvSNyEI7@vger.kernel.org
X-Gm-Message-State: AOJu0YwENlJQzT/XouFG8hY5X8W5vytTnybyAe3ruO+g/7lK3EV+Q4yw
	MSGrdCG5s8tHxOnoSa62+4BN/36T0w/rMqMOOTBqMtIC9EfN+qztrzL9
X-Gm-Gg: AeBDiet3JYdGKU2lOlAHMnol1M3ibv3HYOa5KtRM9Skd0fzt1Jf9wP19hKKVzNZYNoJ
	bJ/qgk8y3J2d0bCS1/Ze7GgEvx9XwjM53MJ30RpuSB6Whkr2ww1hzLk6/WwvngQ+uJHvXn7qEHQ
	tpd2bkBPr9FxURopMGybF13DwvS8KHcUhAzpxRKujOORChr1xblKFlrUutcWL/MxMq18/FdsGxB
	8voH0O34qmlZ2YOK1tFCDiWwNogtkNYFmuyYhhibxTR5hVvrSIVsy/s1NU7RwJUt2CrWLaCOST2
	SxijLXKKNYNaLUEYyTaE3X0zAhHnZvsghUvFN6kmgvgVeSp0YUv2+n2c7zaBs7XEQvJFO6kUDex
	TFEgsN3oAZgBLbDNFPgIj1YZFKtRLAV7TzJQQusQ3SKEoQGiYHM6T9NxfTrT/ZHrSlefzOIs2Hp
	WBusrXaSIYQqNSCv2zdB7hTqnndXDTUkKF
X-Received: by 2002:a17:903:1988:b0:2b4:5cea:f618 with SMTP id d9443c01a7336-2b5f9e7823fmr164463225ad.3.1776736915460;
        Mon, 20 Apr 2026 19:01:55 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff3b4sm149129515ad.2.2026.04.20.19.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 19:01:54 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: Matthew Wilcox <willy@infradead.org>, abuehaze@amazon.de, alisaidi@amazon.com, blakgeof@amazon.com, brauner@kernel.org, dipietro.salvatore@gmail.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order allocation
In-Reply-To: <aeZ0Kp8dBqjsyWki@casper.infradead.org>
Date: Tue, 21 Apr 2026 06:46:19 +0530
Message-ID: <cxztt8nw.ritesh.list@gmail.com>
References: <ldenszsy.ritesh.list@gmail.com> <20260420163328.22104-1-dipiets@amazon.it> <aeZ0Kp8dBqjsyWki@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Matthew Wilcox <willy@infradead.org> writes:

> On Mon, Apr 20, 2026 at 04:33:28PM +0000, Salvatore Dipietro wrote:
>> I have submitted a v2 of the patch based on Ritesh's suggestion.
>> https://lore.kernel.org/linux-mm/20260420161404.642-1-dipiets@amazon.it/T/#u
>
> ... but without linking back to this thread, so nobody who was exposed
> to that thread for the first time knows about this one.  That's poor form.

Yup.
Also, given the Maintainers (willy, Christoph, Dave) shown their
dis-interest in taking the patch in it's current form, the right way is
to get back with performance data with both the approaches (which we
were discussing) and first get the consensus from everyone, before
proposing this as a patch :).

Having said that, we do care if a genuine performance issue gets
reported. In that context, I wanted to understand your setup a bit from
memory fragmentation perspective. Are you trying to simulate memory
fragmentation and then benchmarking? Or was this problem hitting when
you run simply run the reproduction steps mentioned in your cover
letter?


BTW - I was following the other thread too where PREEMPT_LAZY problem
was getting discussed. And from what I understood, you mentioned [1]
enabling THP on the system made that problem go away. Also it looks like
enabling THP is the right thing to do for this kind of workload. Does
that also mean enabling THP fixed this problem too? Do you still hit
memory fragmentation and/or similar throughput drop w/o this fix after
you enable THP? It will be good to know those details too please.

[1]: https://lore.kernel.org/all/20260403191942.21410-1-dipiets@amazon.it/T/#md88ca4258766e897e432df85874d197db476c7d1

-ritesh

