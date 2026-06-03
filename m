Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFE73CAA3A
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511340; cv=none; b=SuGVXVk3dJrOyrnH5SgW+4o87WjBzBENI+Oryckl5NwA+aqtS+eBpZ8wQJ0E+z3yufzXR34pXNUlFiO2YG+PauWPVa1ZerSmyA21EuXDDq1MkAUs8dZ9LzRLT4YK7eRQCzAD2pVwJ+kkYEON4XwX6K4xpLIG2an1FsJKAjC0kaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511340; c=relaxed/simple;
	bh=GrDoA4gKT8W5olxXPEI9oGi6uCk0mHf0rlEhckvAfu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1+WZ60oi95QhCTSwyZjSgcebFmnqXZauUVGbbzxgQyIOK2x409QLG3lxA2qQtzCuiGjPsbu0Opba+y2fY8hDg8bXKLkVEG/QSPlqyBLLemYcfjN5waH9E/3r3t3sQj4M01WRSm1lCcTK7Z8Bl+ETMPH6lWUBcw1TlVInWHTqVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DyBT1mIA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DyBT1mIA"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36d5fd50d20so3442407a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780511338; x=1781116138; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VYe+dW7ZDjb/fodoLbEwUxVzR4phhS+HhNp00MJ/BA=;
        b=DyBT1mIABBs7t0TFQaANnMQZtxB34VSP7F8rCBUO3Lvv/CWanOsfFbEhWvHcg76bz1
         y2WvYtEZxbQi3g0MzZ7j+mx4JEpKXplYiWMRJLH9KiFKQE2Nx2t4Z9201VRoFMP0rqG9
         9HM4m0l9GQhNxzjhwJC0L3G2wKfgiQEAOlGqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780511338; x=1781116138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8VYe+dW7ZDjb/fodoLbEwUxVzR4phhS+HhNp00MJ/BA=;
        b=dUtQQRnZr22TsSnUXwIVtK048WaezqhghfGLLq5Sl7TeoS/r2DApRpGsCgUD2PpGWC
         hFLGqBlrzqmuwveIc2TarDCNAIXIpdMPXyeo5OuCD37/XJw7zNXRoop29qaDDnpEg79q
         75F7jphnjGJGadQ4I5/5L5HoxcU4QnbvZX3JlZK79QFUB0wJoSbK3EVqXY7DCShvamNR
         0cYjpWEgYIaWeY4TTHmjEd7ZaFhMKBF1+u8U7/L6pzGq4YSqY3p53j/uRRtFjGeP0LRg
         BE36KzmZETff9mKtseY8LdnOVuYo+/CXUtyM2S86B68S1IL7qVi4/Nkdq3uqpqYlKEyD
         s24A==
X-Forwarded-Encrypted: i=1; AFNElJ8elKkIkGbX4pJbHbgMqxFv3lHhYd/Sv0zGXrMRX4PPt+bVp555p3Ol259OQs2df4BPNmT3/0JLW8w6vOP7@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMsj2JQ9POgTMSiJSz7LDEs/tdoLpbY9qIn5km9/kFiTwu9jH
	pHbA+GTBPCBi5iBkFwlZuokWGXyCJc/Lo6Zu/3jrmt3g12kRj1zisPwae3vT1FTRBGM9j+bhQ7B
	XDsJRE4nQpg==
X-Gm-Gg: Acq92OHqYF+enemzGemDntspcgrtL1Xd3oSALgXMYEpxR296alKjMyj1GmsNETxodju
	ZlCvqESGOMOjWu9ML8sR16v7tlgGN+NRmJTpfEa0fru42wnLWPKI1r71bUEgFQSQEvAexrbNykN
	KOZXBhNBk24fjXQ/+CrHQ7xnbnkOx/VqR4uGA1qctsA2rAL92juFR9OVuweYPWXtoJsES337eQQ
	Fvwree8GSArj/WoO4laD4OBX90zKi8KpoByUB9PT051TfMJYIUxvVA7UIZsuN6huO1zokEKLf03
	IRM1Bke/1vZ4CEN8RvplhxNn143S+nMJOf+3Ux7WXA1GPfzlLzSJ5YbT+wBDGK5sUXFj7ba31oB
	eclE/J0FKuaeiOh3MDGQVSStiHqkWtPQcyuiuVfjWtpGd938qi8E+d+zrkJFw7IT8/7brXbdJMX
	rYchWLDSqCqAMbOFMWxzp+yvKmCZC06Gx3dRWRicUw/CzixkD58V85WqLgq0o+C1t9eV88cSwz/
	GONMhbGkzG/6Gc=
X-Received: by 2002:a17:90b:51c2:b0:36b:4d63:4a96 with SMTP id 98e67ed59e1d1-36e3247617amr4640417a91.1.1780511338489;
        Wed, 03 Jun 2026 11:28:58 -0700 (PDT)
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com. [209.85.215.174])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0bd337sm2876278a12.29.2026.06.03.11.28.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 11:28:58 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c858b392697so2297928a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 11:28:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/S+ZpYK/a27miuNNjq33i83heLui1WMCmH9o+7zlsHGj9CVF5k5uUW/3/7N0/shqul8vNY3hdQEpcvmcQF@vger.kernel.org
X-Received: by 2002:a05:6a21:50e:b0:3b4:736b:da61 with SMTP id
 adf61e73a8af0-3b49790c56cmr5052599637.35.1780511337548; Wed, 03 Jun 2026
 11:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com> <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
In-Reply-To: <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 11:28:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
X-Gm-Features: AVHnY4I2wCOVMf6tT9iCpMFfYRmksgwgXPr0UvzSy7WYplz1D2yZ52_F3Jv-p8Q
Message-ID: <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Andy Lutomirski <luto@amacapital.net>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 3 Jun 2026 at 11:10, Andy Lutomirski <luto@amacapital.net> wrote:
>
> So maybe we should make sure that, if we go down the route of
> disabling all the splice magic, that we leave an API, maybe the
> existing sendfile or maybe something else, that does an optimized copy
> from one fd to another and that is at least capable of sending from a
> file to the network with at most one CPU-side copy.

Why?

That is *LITERALLY* the attack surface - and the complexity - that we
should be removing.

sendfile() was a mistake. It is literally the "file->socket" thing
that has been buggy.

I absolutely refuse to get rid of splice code but keep the buggy sh*t
cases that caused all the problems in the first place.

Because *THAT* would just be completely insane and pointless.

> Even if we=E2=80=99re just doing that, I continue to find it strange that=
 we
> require that a pipe be involved. What=E2=80=99s so special about pipes

Again: it was never splice or the pipe that was the problem. Stop
barking up the wrong tree.

It was "file data to socket" that was the truly horrendous issue.

That said, to explain the pipe: The reason for the pipe is to act as
the kernel-side buffer.

Now, these days we have much more capable iov_iter interfaces than we
used to, and in that sense the "pipe as a buffer" is certainly not the
obvious choice now.

But even then you need to have a *handle* to the buffers for the
general case, and that's what the pipe fd ends up then still
effectively being.

It was also done to avoid the M:N translation problem, because people
wanted to do zero-copy between other things than just "file ->
socket".

But again: we're ABNSOLUTELY NOT keeping that "file -> socket" thing
and getting rid of splice.  That's literally keeping the bath-water
and throwing out the baby.

Splice is the *good* part (well, relatively - splice is bad too).

ile->socket needs to DIE IN A FIRE considering the security problems it has=
 had.

I hope Jakub is right that the problems have been all fixed, and this
is all theoretical, but having seen just *how* many there were, I'm a
bit sceptical.

Because if people think splice is complicated, you haven't looked at
the skb rules. They are completely arbitrary and complex and spread
all over the tree.

               Linus
