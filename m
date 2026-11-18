Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017701;
	b=faYSSP3pAiolpp82KX1kvEmmmWGVdMyQjb6v3S+uH+LMJON06wkoRl87CtxroJhLq3Zm
	 yTpwaIFSHrtUPT5Z7L9vP1P7a0AhbMQKOozdFOlgR7wn31Ia1iNC2a9GvEoRtVTgr0pdQ
	 ltPwwnHCoyYyMGmONFUUXzd+lScfYGdkNDbW0DdTeOq2+EOBwm40+n/N2oayrKO8FG2wk
	 g0tg1UilP4AI4Vo2ES4s61/kSfHg26LO+jFrdsyUScytImdzFnxtwjDY0fxMNv8fi5z0Z
	 EowzlhC8g2W8qewTOVGx/nPKw/VKmR6dI/Verc0QQ88woL39RyNMZZaYl/mm0Anj5hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+2RLaCA+CTvvhLn9hoYoWmbd8XvuHHvjif/znAEqg5I=;
	b=HDiiPjTBvddinsB+0YfP/CbErQ0ktfkwmRsJHZu7jJaq3+3kk0ZWt+QjHKQ3MXZU1oP8
	 0QtQE4857PfJm8lMGYWVOF0glQLmR2L4eBhhUuIxtETwn5jHriNDiDqhlQlMjWIKaXLpA
	 FptjuDEyOlOfHPC0yLbLcen0DX+Chir2Z9yX9WQ90eOqo71Opo1JnIrkt72fCK3ZFmVg2
	 32VWomvVGcrRzcP174SSHD/7f/7EZBYI3fIvg5t64RyyIYky8QSg7H1eyhUPc21C1+Ht1
	 vZc4/TYu+xcIJ/hhr1F6l5wchI0Nn0XQ1Kgo5Xn6IOx1L2Np3+h4KaVhaNcobQQbDjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=fvOIgVFE;
	arc=none smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88214606A332
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 16:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88214606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=fvOIgVFE
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b8a1f59d5eso847721a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 08:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1795017700; x=1795622500; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+2RLaCA+CTvvhLn9hoYoWmbd8XvuHHvjif/znAEqg5I=;
        b=fvOIgVFEiJoT1iy4aVKrq/QgD/Ad3zlkJ1XxoqDvtmaJXpssWOer72ljoPqkw26XVd
         Z2a8IeywZ/gM5rJWG6KQzQTmZoZPx3NS8aN7ey+Xo5WVZT3jYSPHQR+1DiHf1D2SULhc
         nqsF++MA6gcoelTwBIZrY9PUb0auMMVfvm9jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795017700; x=1795622500;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+2RLaCA+CTvvhLn9hoYoWmbd8XvuHHvjif/znAEqg5I=;
        b=eq1GHRkWr2Utbzv/tm49sPGSHZvDJFmqrbJwqF5FU0O+Z+awCDTUTywhdZsht9nxNi
         I7RmLReBh4Pg/uhNq+wkf9LiWu5PQlOktm/8YM9LIRLoihcPu9DiCpZhtCoyKmRP236M
         W7unIwf4x8l3DMjsrb1MC1GPhEcFz5ra8eDGizFyYcdhciH/0Bk5XzhiOxWEu+hl1NkY
         5lZHFRs5TNA+483Q0PbtguNubURhW/bZoxCFv39n4cr5+fZqe6XXg5jCVsRzwU4M1CvZ
         1UuZG+7/5eOmqz74etWhIPT0e3aInk2dx3omhGUAc+QsswlUxU24FZ6vNE2uZvFz8z3a
         9UPA==
X-Forwarded-Encrypted: i=1; AL+hErHrdHYgREcAw1LGGsggFc6efaSJakIQjktru48DRiwwYHqjo/dNA54AmkA6QILPos8SEfudnu5t5kqLUpg0@vger.kernel.org
X-Gm-Message-State: APuU4Z+GU/QQ2GywRSvZldjx3+PrZr0dFrHox4N2tCHeiOMLVxtdb2vM
	EVQt/JhZjRAiRCnpD9hNntSen1LySNMYcQtdEJcEKNT8XpyCUzRRZM6WDqqJY0kFu8HWlhemE/e
	VFu1yZiI=
X-Gm-Gg: AYBFou2RBATiLEDdmEytdgdlpb7j5HOXTzegM3YVJ2liXnPPmjdCLNW+MnaG4QtasUd
	KejIq380jUxm3GuUYsruF4JkBhL1QuKNbLrqwG+tV8PPx3OJU0djWBwSA8uIexhfqh8sdzZKswJ
	K/cB6hndea8X9dl+a8hOXY34Bp63SDunaWigv8LBvT8CXd+9Q9FC98Mg/LRZUxrAk1ApYiSInz/
	rPhdX7E6ZoW4gzzqK8p040aRLMLyKsSetc39mSXEaQFsSyv9cowkhj+GpK3EW/cv14zDXiNiGit
	SqYziGOHJa2/pUWIrWigBnjk2bgw4SskxJ0lvNVyMBAjrFrvRubZW4xgB5TpV9KBYxvvYG5VP1q
	YJYcLiv5G14Fio02T+SYwSBOyWjrs7z29KR0Uo104HAf6TBLRUcJEKT7Zs+cY0C2NEhy5HMhswv
	7EkYT6CAeIqd0GzlS/MBlbEXPG91SctouGbh2kWvb2IEP7/xSnK+iyAOkTWo3qvs41Yo1AxVb1w
	7+fiiO6yt03Jbr8SJX0EpSQrdXGZyhfgo/vWOQkbV/vjqTies8A51COd9p9/Iknts/dcHR4S0Kg
	2BmiQ6TmGMbwF+i+3+CMtWYGCM6tKbNPYeZHlMZ3imzKEiBjyrftvdsp5LX/pCpQ7550pUN8mU3
	Rj2M=
X-Received: by 2002:a17:907:9811:b0:c29:3c97:c994 with SMTP id a640c23a62f3a-c510e36bf00mr292275866b.35.1795017699857;
        Wed, 18 Nov 2026 08:01:39 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5123464f96sm17055166b.48.2026.11.18.08.01.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 08:01:19 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c50a4a2132cso155590866b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 08:01:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHVNl03bhLKcBxQB0pFKGBThOJkznFY1LdClquqk5aFv6F9wiDoJuvcmSMHlDRz6+Q34lVftcxwaLrzTsX+@vger.kernel.org
X-Received: by 2002:a17:907:cd14:b0:c51:24e9:c474 with SMTP id
 a640c23a62f3a-c5124e9ca9emr12311066b.16.1795017678422; Wed, 18 Nov 2026
 08:01:18 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-pipe-epollexclusive-wakeup-v1-1-0af6283e9fda@columbia.edu>
 <avxWKI795DthE8Sb@redhat.com> <CAHk-=wjOq+G=6gte4vX_YxOD_VfE1uZh7=+KHs8N0wU75xyHEg@mail.gmail.com>
 <avyODoFhZ_M7YDU5@redhat.com> <CAHk-=wgcBSBtHE+3ceKGjq1jyF64OyoEqf5JPpixowAa80GqNQ@mail.gmail.com>
 <avyVwg-5ef-pXZkG@redhat.com> <CAHk-=wjJF8uZLfVbbqei9-fhs9K70i2OnVreCV-rQF9EGKAxJg@mail.gmail.com>
 <CAHk-=wjqParwoB8wb9KfGVpbwUwvKvObpLOo=XPM0GGfkn3ibw@mail.gmail.com> <av2juQijIISJAgyf@redhat.com>
In-Reply-To: <av2juQijIISJAgyf@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Nov 2026 08:01:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg4RgBYZcUU+c16XxdZ4UbAaazJkUS=R6=tpN4xUBdDRw@mail.gmail.com>
X-Gm-Features: AclHuK-jO2btqFqtri5NH0SNA66TSaufpqFn40OH8HLtU3lTATNZK-kccXjyNlw
Message-ID: <CAHk-=wg4RgBYZcUU+c16XxdZ4UbAaazJkUS=R6=tpN4xUBdDRw@mail.gmail.com>
Subject: Re: [PATCH] pipe: keep per-write wakeups for EPOLLEXCLUSIVE consumers
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tz2294@columbia.edu, stable@vger.kernel.org, 
	Mani Tofigh <mt4022@columbia.edu>
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Nov 2026 at 05:10, Oleg Nesterov <oleg@redhat.com> wrote:
>
> What if we add, say, WQ_FLAG_LOCKED and change prepare_to_wait_event()

No, I absolutely detest conditional locking. It *will* cause problems.
Particularly when based on something like this where the locking
depends on not an argument and a call chain, but on a (potentially)
long-lived flag.

> Then we can trivially redefine all users of __wait_event_interruptible_locked()
> on top of ___wait_event/etc.

.. *if* it was passed down as just the argument, I might be open to
it, but honestly, even then it's just nasty. I *much* prefer to have
statically visible locking, and have the pattern of one single helper
that does the core work, and another helper that just does the lock
and then calls the first one.

Some duplication - with explicit naming of the locking status for the
special cases that are called with the lock already held - is much
preferable to dynamically doing the locking (even if the compiler may
be able to then turn it into a static choice at build time, if it's
not obvious from the source code it's still "dynamic")

No locking hacks. Locking - along with memory ordering - is special.
Locking is *not* a flag.

           Linus
