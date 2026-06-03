Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08943A873D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500424; cv=none; b=NXLqxmP0pi1RbaZnlP/jXfdnbSuisg1ZU+kakPoKQEDmVS3PV6Et4TkreR9JHiSWlS96sCMtqYNWQ+307HSE7W5ITD2GPJ4JCjHPmVw7f1BcakNU4KtmQclTG4Uy5DpTES9Y2Y2jIxxvB2UERgBJctGy9S+qtHFYcqQn4/gulTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500424; c=relaxed/simple;
	bh=5wR6ldRtC07oE2OfAwKn+DBv+oDO9pj5vEPnyj7TnCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pFJVHwKvSoTiYTlLl5w/weEf0BIxR0fOGzsWrkEKH+e5QUxMTx6lj41A7Ygs9dVkHR5Ozx3HMIOjLKv54275G5zpAQbqFRxqmK00mbPldTFUK8CBINxW2WwPNBBjescl7UnJ5DIXHbDYLcsvdGNkIvZ8WNij6w+pN2MBkIHDriE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GR5Ainrb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GR5Ainrb"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bed2195323cso556744166b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780500421; x=1781105221; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EdBrjWRKLAumno5vFkve2ATlSCQiBIWYVQeSXYhWLKg=;
        b=GR5AinrbEA1LdrzGwQjhSZHbnZjyn5PJPKLcC/i01LK16bSWM+GLNlHgxBkxSa6ILY
         KTkjft0Rk/vVp03hAP1oDhpiGkrIa8Xfv5lPQnQ+sTlLEK+AXY37iVDezKKTx57rqi4g
         n2Yya4Ck76D9l3cgW4fKBEdbDCtLSXt3ytzlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780500421; x=1781105221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdBrjWRKLAumno5vFkve2ATlSCQiBIWYVQeSXYhWLKg=;
        b=qu7/xTjP7mtlXhjC5B86sjDWaQUr1u3K7FNdjQbiqyaTJGAuE70227k+qxE5QQ2TsY
         XQI+ONuMbfizlQq9ow4n1kPC+UX5gIru1zo97G5h0zafzfWEKGkpqpV2kuDqnBdQI2OS
         xtMHlHHGnuJEsEsynSyaLKra9q7z91/NK04yJaWc7KAxZjaeiz114Y0JdPWluslcHsmS
         PgKJPl7jJQOumlGaRshDStw/SmyXZQ4NykdmpX38uT4kODf5NYVcdt5qfJHhCzI1v0qE
         0YWac2/OFlNYefprFb2dl6r86YTHt6FqqI3IjRjkBsjbvhdLsnU841sJI9yERozz2aYl
         NLjA==
X-Forwarded-Encrypted: i=1; AFNElJ9ykunWUPDO0Sr9GI1jbKd6HTjqqKdN5kyxyHi3MBrmo7oNeermXchHkqiTZRFUZ5ktVnUjriqDuE3/un31@vger.kernel.org
X-Gm-Message-State: AOJu0YzYU1GmIZAr64PLtJ36jukj1ZmgCjW3CjrAPiSMLz64LKyvWzEB
	T8akRijdMH5IWT6mDotgHWoSzXJ3oXhKQzMU1xKB/+hs6x5N8vYX7Bkq8bybfj6xoTUvI1W7ZPZ
	lhGR/mQ8aLQ==
X-Gm-Gg: Acq92OH2rPo8z1W//xBLkdgqHxl7E23+c01AUmVV3Fj4zYsJIqbIZs/YJDc3sOeEGOt
	6FzGghClVvZTFJHl02/njIMe3MleZ93aToEmoH7jbPJ1YCBgpNu8oWyTDdhqbddN8R90Q3RyXMa
	tkJcR5VH0yxp8TtBC9TdRWV/FWvqu6UvNU6eTjlEJxMzqE7Dw2n2dTRqMICqRYoRSM4kFSbaa6K
	JUW1qF3mjVZidsTXTAPO7k6YUKB+PUNY1h2oJAhD9fiyvr0JLKMjmX2rrZU02YPTupk5I8we/HB
	F6e0+x9MZyYgkgwhVGK2fJssPkDl0CYHzsy5ElAY9kX00HRj5QYI6Q25FVCJ4kFYSIzRn/ynffD
	oXGh6zJuI7xEfFFu9J272bFUgvM6Jyqu/C/3L/PdJ5tqYtX5wy67jwhm49+3661YxzURFNmkvUl
	4zi1g6Xc1TPmRn1vBLfoTVLf1MWkaqoUH+yuNXJvCfXi5As6wYU+Di8OIrioTB5VL0yxX4jU617
	5H1mDTT3Bo=
X-Received: by 2002:a17:907:1c03:b0:bf0:701e:b148 with SMTP id a640c23a62f3a-bf0ae905954mr214845366b.27.1780500421159;
        Wed, 03 Jun 2026 08:27:01 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e04a89sm176349266b.41.2026.06.03.08.26.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 08:26:59 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bed2195323cso556734566b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 08:26:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/u3rMQNErx0wjA+a9R72AwDPzKxtNPljZQBeq56KvdgQhfY6msUPacGmYkLENXB9hnz21rbdjbVHp3AbOo@vger.kernel.org
X-Received: by 2002:a17:907:3f0e:b0:bed:19af:f8aa with SMTP id
 a640c23a62f3a-bf0acf0f958mr176902766b.13.1780500418629; Wed, 03 Jun 2026
 08:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
 <20260603-navigieren-pleite-stilvoll-60e6da66b1d4@brauner> <20260603-raumfahrt-unmerklich-ertrugen-c4ecae70d5f9@brauner>
In-Reply-To: <20260603-raumfahrt-unmerklich-ertrugen-c4ecae70d5f9@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 08:26:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgV-j-G3d+899Zm1pQ=NaJrddPz=GKcL5Yw5DTUM=GaUw@mail.gmail.com>
X-Gm-Features: AVHnY4Kj73Z8AasW6cIfq1Oi-uE8PGC_0Rj2_P-0GPM116OFy2hMKOC9XAw-q3o
Message-ID: <CAHk-=wgV-j-G3d+899Zm1pQ=NaJrddPz=GKcL5Yw5DTUM=GaUw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, 
	axboe@kernel.dk, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 06:40, Christian Brauner <brauner@kernel.org> wrote:
>
> Prior to the change add_to_pipe() returns -EAGAIN the moment the pipe is
> full. So iter_to_pipe stops and returns a partial count capped at pipe
> capacity. For a 128K buffer over a 64K pipe the first call returns 64K,
> the test drains it, call 2 returns the remaining 64K. Done.
>
> After this change do_writev(... flags & SPLICE_F_NONBLOCK ? RWF_NOWAIT :
> 0) then calls pipe_write which does not stop when the pipe fills. It
> blocks until the entire iovec is consumed.
>
> I kinda think we need to preserve similar semantics.

Ack. We definitely do need to keep the old semantics.

Looking at the patch again, I think it's that

    (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0

thing that is broken. I think splice_to_pipe is *always* nowait - but
has the special conditional _initial_ wait.

So I think the RWF_NOWAIT should be unconditional to the do_writev(),
and instead the code should do something like

        ret = wait_for_space(pipe, flags);
        if (!ret) do_writev(...RWF_NOWAIT);

but admittedly I did not think very much about the details, so I might
miss something.

Which also then probably measn that we should just keep the legacy
wrapper in fs/splice.c and we'd just need to make do_writev() and
do_readv() non-static.

Because I'd rather keep wait_for_space() internal to splice (or
alternatively we'd move it to pipe.c, rename it to
"pipe_wait_for_space()", and change the 'flags' argument to be a
boolean to not make it use that splice-specific flags etc).

            Linus
