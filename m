Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983537F8C1
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780522316; cv=pass; b=uovRBMNTw8JaUWwau2phgtOBfaTLZa7CRdQORmPXOhcOVA9FEWnIlbWpFMC5z/lYDv0T3l2L5MsBuUOxK6bVlXYK3PuS4D1iYNvD8ESqqhETdL+B7QHmxiHzQJZpHG0ZGKAyChVTVfGYl4dQQyG4MZMDIsRUkXANQiGzxCYF9XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780522316; c=relaxed/simple;
	bh=NAfifc52uhBVXwuP3W/flWSVRj5fkupSNdXoG/ZGuU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdYIX2MTiRieHeJFL1J5XbvP2xLaItHUp3Y6qcV0qOo7qh6maw1nvR3c+ritpje3lDc3nD0CVzZSCwEOqS19CiNH4ywoJ18YU8r7Zp1WbM1lFxi8AfvFky4EkLBxzfcY245ueJT5/HakJIIO/e7XdMZpk2Q7Lsw6pZQy27nsdWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=JXSpeC88; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="JXSpeC88"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aa68d7d757so4201189e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 14:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780522312; cv=none;
        d=google.com; s=arc-20240605;
        b=S2KP5Xtn5rDPTYv1dj4kDzp3O0ph4C+dPrRngJd9UmO1v3v8B6RW3zKAVUcf+mooN9
         Ej3DHbTxN0ssGKIQGN9d3ywm6L4GBPtw+OUsf48gb5JSPeqPCT7BEF1MucXHyeG0bGKg
         hGoDVecB6thw94INvF70q/HVO0Pxtq6M/Yng3WXG+V0NwE1lKMVCUkUek1tHBBbaKLsE
         ZW0AVrubvyjmP7tmRhtUm4yAlb47RqaXBU0FAiaWvR4VKDbO82QsOdt+uD93J/GWWIMi
         h6PgP/+D2Oz7317LQo9lxGba30ufJTGhVJstvzRfC8xfo9BI2+I/6T2EcXGo2YzSB/zE
         TYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q5iqrCHjutj+wP2G1wPc50Z6+aExdn36Rac6q6pqNP8=;
        fh=4qcOnVhwQRwui8JUDyit0RjvDqP9kcA0ryuQM4dufUs=;
        b=UcF68OqHVXy4Y6KHhq/Nw6tCdycdgahOmgTA4aiykdfm8ox4q8sGlcR731gj2iBFmu
         djYtbz8LaJ7YbvulZju6jkFHfHju4Jn1pb4z5i8266KLL+WDVdQZhG3v9IW76AMdEGF/
         j/ODcXnk5svldrMhx0JttyvghxsRHh+lm4wFGX0Gq6za05xn9/YH0LMMjGdTgysI6N03
         nPMzh4yPPpOdXK6NOEpTLhFXJUxBgYfmsGzduP57n5Pf0lLqd9dV6vVoFRuOpndb5yjc
         0KCjqMXOr6fZ6tbhZ7hjvXXbhGT51b6pGjLWWDNMLZTgO4M+P6uSLse225m2TwZu2Kin
         1ZzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1780522312; x=1781127112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5iqrCHjutj+wP2G1wPc50Z6+aExdn36Rac6q6pqNP8=;
        b=JXSpeC88DCzpIYBTZmaB4UGGZsK22FOhzdRXvUA31bsKwgf+fo3cT9lQKMc4Qahj4y
         S5pQekdR6hAnnr9YYrt+8cwIcP3mcAo0ZrF1JCA7H7XfU0lUHipKoj5IZaSFhnSEZnLD
         3921bwBeS0o8MULW7TG7QvwopEPGsT5Lf51WmE9f2dyYmbbBcV8cVlvj9L8hmulBidw3
         ATzvYun0sfcZGjV7EgpaFsjfAi4tVE9DaRCUTxxo7tDbvSMyA7Ru5Mp9nv1XS7kYQcnI
         8OQF4obm8JAueSIqNpkn1MwbQoeaOTHlpiE/0wVssO+PQUN/3uR5WS7527DuesH1JvMk
         6l3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780522312; x=1781127112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q5iqrCHjutj+wP2G1wPc50Z6+aExdn36Rac6q6pqNP8=;
        b=Q9asMGLQ+KMwhsAR9/KuaESs+JIVJkXww3GIpoxFod9HAXyHpXEdW/syS10/klT9xF
         KJth/hYMv5N94MyeM96Sf3BQQKuAaiBZvV0tyZDWtlTluPvANd77T2YVmkm26I30Kzhh
         0pPyC/y+vkUtc3wLVjAE3pFcXAoD9LWTZqQsyuYeWkrR+5igQcZAmHTpGyNzbQOdxhZ6
         OpX+lxEZcvc3ls5458kaQPCQ5a8phnhQJ+CD5wFt0k/JGY84/dUrvUZE9UDjCIoaO2UL
         NEFuUpf4pImSBBIJMqY1yJWYZvaoydxhF3LjOaeAGDC0WgPTI4p/9/HVITErcqElaeTO
         XAzw==
X-Forwarded-Encrypted: i=1; AFNElJ+N86Bb59Xd566fZH5qmwXK0WWkuV6XtX/9oVGkz1ipz1e7HLGI3izDhgIoL0I7ZvhSA4N4Ck+l3izLOboo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/SZ7QtPuCITWWfpkYBcoaakLRp9WSCGpfUTE1vPkJqVLAasji
	id/LTF00AbfT1y3Vafw4FlJYL/TqbD1UxItzbaoT083aqkYdj/IYLuJN9fZ0xkDUxAjjRSsM5U3
	lEFYkM4QOfUspUMCMR2TsWQD3CV52Wvn1kNf37AOb
X-Gm-Gg: Acq92OFerTmj4TyMpSkvlT1dueT28hOmP/IK48AiR70CmJ9S2Pfdm3XvME2vwFh4tdr
	KBxfsLdNlROKLtswK3Nx7pwQ5wvSaxXIKjoXf9uzgUyYTK4g7JKHdH44u6+R401YMtq3Dlw6Hqc
	iL0fDbBqA/OUhlRdmF15aF6XKXPx0nR/p2C7Qhp3abaOhS98hObM9lwo0kjWHt461niE/FzLZeH
	qySx+oqq9OUx6s5YCEmA5gjJz9ySnfgpMjjQxR5w4vc5B7SO6RvxRKvP7NmZquIPeKJCfO//P/x
	RBHy5PILSffS40FL00k=
X-Received: by 2002:a05:6512:66c9:10b0:5aa:6c1f:d300 with SMTP id
 2adb3069b0e04-5aa7c061ed1mr1281308e87.11.1780522312203; Wed, 03 Jun 2026
 14:31:52 -0700 (PDT)
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
 <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com> <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
In-Reply-To: <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 3 Jun 2026 14:31:40 -0700
X-Gm-Features: AVHnY4LsKDQ8qf8M6LcHYa40LO1DYv3gySsCGNMqZCGh4-xivJwaSH-NzjuOFXE
Message-ID: <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 11:29=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 3 Jun 2026 at 11:10, Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > So maybe we should make sure that, if we go down the route of
> > disabling all the splice magic, that we leave an API, maybe the
> > existing sendfile or maybe something else, that does an optimized copy
> > from one fd to another and that is at least capable of sending from a
> > file to the network with at most one CPU-side copy.
>
> Why?
>
> That is *LITERALLY* the attack surface - and the complexity - that we
> should be removing.

I think I buried the lede too much and you're arguing against what I
was trying not to say.

Maybe we should keep an API that does an optimized copy, from one fd
to another, that can send from a file to the network with at most ONE
cpu-side copy.  Not aiming for zero like sendfile / splice.  Aiming
for one.

If sendfile and splice get completely deoptimized (which I think makes
a considerable amount of sense), then I think that, as you said,
there's a risk that the most efficient way to send the contents of a
file to the network is to read it into user memory and then send it,
which is *two* copies to get it from pagecache to the outgoing socket
buffer.  But I think that just one copy can be done with essentially
no funny business.

copy_splice_read is conceptually not terrible at all -- it allocates
memory and copies from page cache.  But splice_to_socket involves
MSG_SPLACE_PAGES, which I think is a part of the mess that you
dislike.  And the path where one does copy_splice_read and then
splice_to_socket has to be a bit complex because of tee and (I think)
because splice_to_socket cannot assume that the incoming data is just
ordinary unshared buffers.

What I'm suggesting is that, at least for network families/protocols
that care to support such a thing, there could be a slightly tedious
but otherwise utterly boring path to *copy* from pagecache to socket
buffers.  So, once the copy is done, the skbs would be ordinary skbs,
exactly as if the user had called plain send(), and nothing downstream
(the network drivers, crazy crypto code, etc) would ever see the
difference.

I don't think I'm suggesting keeping *splice* as the user-visible API,
but maybe plain sendfile could do this, and maybe someone would add
io_uring support, but all the complexity would be confined to the code
that does the actual copy and not spread to anywhere else in the
network stack.

--Andy


>
> sendfile() was a mistake. It is literally the "file->socket" thing
> that has been buggy.
>
> I absolutely refuse to get rid of splice code but keep the buggy sh*t
> cases that caused all the problems in the first place.
>
> Because *THAT* would just be completely insane and pointless.
>
> > Even if we=E2=80=99re just doing that, I continue to find it strange th=
at we
> > require that a pipe be involved. What=E2=80=99s so special about pipes
>
> Again: it was never splice or the pipe that was the problem. Stop
> barking up the wrong tree.
>
> It was "file data to socket" that was the truly horrendous issue.
>
> That said, to explain the pipe: The reason for the pipe is to act as
> the kernel-side buffer.
>
> Now, these days we have much more capable iov_iter interfaces than we
> used to, and in that sense the "pipe as a buffer" is certainly not the
> obvious choice now.
>
> But even then you need to have a *handle* to the buffers for the
> general case, and that's what the pipe fd ends up then still
> effectively being.
>
> It was also done to avoid the M:N translation problem, because people
> wanted to do zero-copy between other things than just "file ->
> socket".
>
> But again: we're ABNSOLUTELY NOT keeping that "file -> socket" thing
> and getting rid of splice.  That's literally keeping the bath-water
> and throwing out the baby.
>
> Splice is the *good* part (well, relatively - splice is bad too).
>
> ile->socket needs to DIE IN A FIRE considering the security problems it h=
as had.
>
> I hope Jakub is right that the problems have been all fixed, and this
> is all theoretical, but having seen just *how* many there were, I'm a
> bit sceptical.
>
> Because if people think splice is complicated, you haven't looked at
> the skb rules. They are completely arbitrary and complex and spread
> all over the tree.
>
>                Linus



--
Andy Lutomirski
AMA Capital Management, LLC
