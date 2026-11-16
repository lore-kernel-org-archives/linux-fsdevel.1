Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858273;
	b=P8DWUUB0ihlBidpJpd224xMLF2j/WvvIBUaaGo4BCCl8Y/4kOXwWr1/R7A/c25qQxPEI
	 iz0MI6f2ZI31MRDte00zRoPK1b5AHIKktZ+NPfkpVTt/y3GNwC5fFmRthtvv3k0vRDnJ5
	 3MP1mv9KtiPGcaUDhotBv72hWELIVz0CZy9fV/N54XyILp7XNgSIToOklQ7+a2b0X/lPC
	 Wmp2aJIZxtvUQXU6vru6ZkdCcNPbYWsL6TlgrEiS33VpKXCucgPHBiE43R9Mj2b9laelk
	 IXOWaeqrVwEZCoiQBVkwz/L2jnjxFJa07B4vOAccO0lSHDi9q90/NyAkzQxoGBALzTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=nh4pWMvkRsPEst/kCwIp1wxFa2k7tAfx6b5lfGN0krQ=;
	b=lGRFndjI+bN6yJBhxiYdf03YBxKCxFPZvs/WQ2aOgzX/xpJScWoXSCK9spUPQkHA1Wb1
	 YYDYNpKXg0T05AHIAdwoJC1YlLHgaNPastcvX+n6dU49z9BgVjrL5N9OBCJC/+TGBJDhy
	 7fIJdOquSx5HMumCfHO/cIdh4KIeFMY4Na5AYvwY88osxImgyNYQn3D5xkNAN1blaVueR
	 42Xytu2KJVIyXcc0lYEoFX8dEzzP47TkHA0+tZtO8Q3iYFKFxsvz2gkZBiYpIUa3fuaMF
	 oi9NmRXJm2/dTt51oIx02BK8N/PqFiWuPMGP5nmae3+Z4TeUg+HI+EH0TY1ex1IuryA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Ulk8nx6K;
	arc=none smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C49606A881
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 19:44:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45C49606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=Ulk8nx6K
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b587538a37so5674717a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 11:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794858271; x=1795463071; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nh4pWMvkRsPEst/kCwIp1wxFa2k7tAfx6b5lfGN0krQ=;
        b=Ulk8nx6K3Msg9F0HdjIyNx1ke+ZFzb7CVCaQeOiZviaxOoe+SrWXjTxrIZIRuttKqy
         E5wCHtwl3n1YL0ASjEZKGdg9QFe/qX77kpQU6w9WHbW2KZ/4ytdD+WShFz72SGSx63z+
         k9LJ9R3CjMy/6BK+F4Kvz8ruQN6x+i31ouipc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858271; x=1795463071;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nh4pWMvkRsPEst/kCwIp1wxFa2k7tAfx6b5lfGN0krQ=;
        b=sXOwqY7X+gmhxE5xqp48nvuR8Gqjt4YcElckCG6ZgxET1QNMdWdojmb8fAlANJzUYc
         Ol192X5mNiTyahMSgWtN6Ei9vt/V08q1RYaGkeWGMaUqcZEWQ2WDLkCH4XEU97jUBgQb
         1ZEUBBWCI+4REmyxzxDl7T60OFvJq4/gMZPMk2zJcsIRGmKB5+jZUhpPcAwg6EQ9ns4m
         4Y2D1jkmDVSLA2BUdb0T8yxWSxDx8x3NSSaBcaLIUmizqphrc/C4LLaqPFMYv3itclQ6
         cAPj4WD8f12YAGx8cX68mhC3y78OYUF4N51mYz52o76E/dNaWeAfmClTUYB/DYrUWnEA
         SKCQ==
X-Forwarded-Encrypted: i=1; AL+hErFwNlK2hfaEIl214ghHzq8gquWwSEMMUueWw0Qhmbij0U395Fdl+ZZMrsmWZAGcwySREYXKz995ycvF5E1K@vger.kernel.org
X-Gm-Message-State: APuU4Z+9Ai/CXve4Hv34fr3/21XBwtmecYJTOMKHNx8nfLL+1b82Q/rG
	6icBou0C/Vipd7269JjRs8i2K44bT2IKZVX4SrW2xxmfc7ED5+PKIHxRpqGQ0JOK+v+yJ98WPWP
	CRAJ0ptWLBg==
X-Gm-Gg: AYBFou1LRMNMq7HKvGELxAarf7j2DukNMTDue+XLy6z+JQsLv+Fwc0uBfSyz1ovcg01
	dmVuHOd53WIpmg3YxhjxSozHnMLTG2YJwrms12h1NcCfL9uSUG6ndIJ6rEtoiVJdmvFLXUhr7xe
	ON3U72G9iE/MPIRqpR6LBUp7FMZHL3dYuvdHzlG54vA7Zm3B8jAo9GRhJdRgniF+s7sXgA8THNL
	2s2577AsisddSuNwRAxa2gOY/0+4FURxnams7yXEDRpR6OrUI29nRua0C6nEzWH4NHeBqsxkLGI
	URjSe6QnNTMSuguLyB8vtRbRFjyi8AxGMjisIG0x1ajWOG25xcKBP1KSoUlZ9UFQBV5vI8JQem9
	W2Ost1rTcAu/Y18Y3wIMziQ9iTVSe8SYXWmKECMSVyZG15+uBi5CM4uue1tRzvdea0hSmxjO912
	P1QQduH6O0SCPHAxo4CIMFMkRVPaUPJW6yy96HEZtgfQd3ak6uTh8+j+vrtD5mo2lXBXALu80u7
	iDafJE43RiP9c7LH5iHhnEJv+ANnFAO0tt2NBcFQXIavUQW8EV+UkOO7LpWNpNCsFO3T+hXZaN0
	41xxlJbZbSCcczoRgzqDNu4SFVz/1tAsfPf8NsukUYiH2E5oQRO8j2tK8v4YqTSos5t1qMKD1Jh
	Q5qw=
X-Received: by 2002:a05:6402:5d86:b0:6b6:e905:b045 with SMTP id 4fb4d7f45d1cf-6b7c08c1bc0mr6308484a12.3.1794858270497;
        Mon, 16 Nov 2026 11:44:30 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b7c21b5eaesm4959221a12.1.2026.11.16.11.44.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 11:44:30 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c50604721c8so623517366b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 11:44:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHzhkCkY3TqSC+4bnOIVZhCfmER+2PvEFv770vVYs4cQxpO0FDm1+KXFbaW7EYZiWgfHI1gdAlflHNclnQr@vger.kernel.org
X-Received: by 2002:a17:907:d86:b0:c50:4b6e:329 with SMTP id
 a640c23a62f3a-c5096372173mr926077766b.15.1794857808907; Mon, 16 Nov 2026
 11:36:48 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025164719.1831477-1-sashal@kernel.org> <CA+1xoqcxAsRij1j10TyhNX9JXNXNkdWO3sMaVRXCqYdEXi45fg@mail.gmail.com>
In-Reply-To: <CA+1xoqcxAsRij1j10TyhNX9JXNXNkdWO3sMaVRXCqYdEXi45fg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Nov 2026 11:36:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgCX4=ZSPALxR7VHKKAKipU1nD_Am-Q-0z1SRKxr-VRRQ@mail.gmail.com>
X-Gm-Features: AclHuK9wFvPLbk2hT2Jt-YCf9KvKeXcURMdq1CAih03odFDrPYf2QaCfvYcr5qU
Message-ID: <CAHk-=wgCX4=ZSPALxR7VHKKAKipU1nD_Am-Q-0z1SRKxr-VRRQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel API specification framework for v7.4
To: Sasha Levin <levinsasha928@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Nov 2026 at 10:14, Sasha Levin <levinsasha928@gmail.com> wrote:
>
> Ping?

So honestly, I really don't like it. I don't think *any* of this
should be inside the kernel. I don't think the in-kernel side helps at
all: the comments are too big, nobody will read them, and the whole -
and only - real use of them would be outside validation, not at
run-time.

IOW, I see only downsides to polluting the kernel source code with
comments that aren't useful to humans.

If this was a spec that is maintained in some automated format - not
in C comments in source files that aren't useful as comments anyway
purely inside something like tools/kernel-api/ (or Documentation, or
even an outside repository entirely), together with the scripts to
then validate it, that would be one thing.

But polluting source code with huge comments that aren't for humans is
right out. Particularly when it clearly is a "first step" and the
intent is to make those comments bigger and more extended in the
future.

And I see *no* upside to any /sys/kernel/debug/kapi interface. Nobody
cares, and any excuse to make it dynamic ("We might update the API in
the future") is actually the complete opposite of the whole point of a
stable API and not something I want to make easier or support in any
way what-so-ever.

So all of the in-kernel side to me looks like actively detrimental to
the whole idea.

What I think *can* work is an external spec that is written so that
tools (read: AI) can actually then verify it against kernel sources,
and that can be used to also drive automated testing. But putting any
of it inside the kernel is bad.

                  Linus
