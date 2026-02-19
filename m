Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C62D8376
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 23:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771545067; cv=none; b=RZN5vJ/oOIgtOpB6ALBx/C28dkrZRZG3COx2itnZRF9QahrLWakA3sJ0W/9hVkjvNk0ZLb12GbzMKJKa+UOrrbIWRgL1oK3d7Ega5tZV7sBUYHaqhaPxAUhTxYY3NTD8pgBMSCZ0p9LNlSjAr5OH+fmTqc77j3QgEOdih8zQA0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771545067; c=relaxed/simple;
	bh=PYSKpHro2xUdY29ay4xBbrVy0pSj/M4z1s3sRI+//6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3W0rjxLWEhh6xk9qhtA2aVO5y7K/7L3HvS1KCufdAY/Sw+6+mYh8Te+QbpyEUVN7cbkyyz+UdtBB++DaWlH20k7raeEChprBIbzWgiWwdI0xruIaDNpktb5divbBycENyURR+IOYpZwHq1/XP5sI8RhZnlVfhx88nj4gEgy+FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpDAvh1U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpDAvh1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC0CC4AF0B
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 23:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771545067;
	bh=PYSKpHro2xUdY29ay4xBbrVy0pSj/M4z1s3sRI+//6c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dpDAvh1UY6GOWKxvnxHPY5XIp5n5xz2BYGOXjujvo9cfKp0HOqygFN8K3+/YbIMBU
	 lp8Bbw3nu5sVKOB7A+36NPPm8XxCtBu5O4ikVGJSAVS7lczptTzF1VKfIxECbfMMYg
	 n71ddtn0JpEDBW1fV1ZSj1XcDy8GpJ7f6R8JHc4v+meqhhGfewFT3TAtXRgZ9G8jEN
	 m/U2nQraCtdsmKWVZ5vquCwycN95t5avVvuw/SgYHLRBuX8WWJpu0lODJiRn8wV114
	 1sCX1FvIL4jV6j9Qj90A5KKjnMgswDPvCdJa/8baJMs3ZTEmBm+WqDi651Ub9/L73U
	 bBFAtdNnl+Ajg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6581234d208so2544950a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 15:51:07 -0800 (PST)
X-Gm-Message-State: AOJu0Yz3C5o2YPnr27iO3kqo1y5GCp/hI4juF4Y0dt/85z3nRQ2t/EPF
	iQdGzh1+7jVX5FvIE2QZuzu+ZnL6qJKUBqJS9LZEKtnXwAqq/TARH6LCAcDfITwLD/Hg/PHVqra
	YgD2u2Jnz35SjFq/uiYOP2hLr5MZ3LXc=
X-Received: by 2002:a17:907:9703:b0:b88:e09b:88ac with SMTP id
 a640c23a62f3a-b8fc3b5abe4mr1160510966b.29.1771545065733; Thu, 19 Feb 2026
 15:51:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0e5da23-90ed-4529-b919-11ae551611f3@dev.snart.me>
 <CAKYAXd-oj5Aa4rccp4iESFgoVUyPq2v+u=2m1AM8KQPpaZOOGg@mail.gmail.com>
 <8709a255-0c8e-40d8-ab75-b3ea974f5823@dev.snart.me> <CAKYAXd98fz=evAudpa8-GFhTfGbcLVioXFsO30pCKu_Q_ek8mg@mail.gmail.com>
 <4555f7ec-5c52-497e-89db-e3278ddf0e5a@dev.snart.me>
In-Reply-To: <4555f7ec-5c52-497e-89db-e3278ddf0e5a@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 20 Feb 2026 08:50:53 +0900
X-Gmail-Original-Message-ID: <CAKYAXd84D4UDg+46EVWmb4e_G9OCs6oR1SQkzDJfuXCgoubJkQ@mail.gmail.com>
X-Gm-Features: AaiRm52Q7i0ykU8r2hYzcRm64LMqMTsXFwSN5h6K-lNU9Pf2KfPHuGt5BPDxU8M
Message-ID: <CAKYAXd84D4UDg+46EVWmb4e_G9OCs6oR1SQkzDJfuXCgoubJkQ@mail.gmail.com>
Subject: Re: [PATCH] exfat: add fallocate support
To: David Timber <dxdt@dev.snart.me>
Cc: linux-fsdevel@vger.kernel.org, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 10:41=E2=80=AFPM David Timber <dxdt@dev.snart.me> w=
rote:
>
> I think what you're implying is that FAT's KEEP_SIZE mode behavour was a
> mistake which is a fair point. I can live with that. In fact, we've got
> VDL so I get the point that it's unnecessary at this point. I know it's
> not that simple because VDL is nowhere near a perfect solution for
> implementing sparse files.
>
> On 2/19/26 20:37, Namjae Jeon wrote:
> > It is not that simple. In FAT, mode 0 seems to be hardly practical;
> > the need to zero out preallocated clusters leads to significant
> > latency. So the fallocate operation itself would be unnecessary
> > without the keep size flag. Furthermore, I doubt we can easily remove
> > it since there may already be applications relying on this. Unlike
> > FAT, exFAT provides both data_size and valid_size, so there is no need
> > to zero-out preallocated clusters in mode 0.
> The current exfat implementation aleady exhibit such behaviour by
> allowing up truncation. When truncating up, only the new clusters get
> allocated to the node and the VDL(ValidDataLength) is unchanged. No
> implicit zeroing out occurs until the application decides to lseek() to
> skip over the VDL and do write(). As outlined in the pathed doc, this
> operation cannot be cancelled - which makes it a caveat.
>
> ftruncate(2):
> > ERRORS
> >
> >        EPERM  The underlying filesystem does not support extending a fi=
le
> >               beyond its current size.
> >
> > VERSIONS
> >
> >        The details in DESCRIPTION are for XSI-compliant systems.  For
> >        non-XSI-compliant systems, the POSIX standard allows two behavio=
rs
> >        for ftruncate() when length exceeds the file length (note that
> >        truncate() is not specified at all in such an environment): eith=
er
> >        returning an error, or extending the file.  Like most UNIX
> >        implementations, Linux follows the XSI requirement when dealing
> >        with native filesystems.  However, some nonnative filesystems do
> >        not permit truncate() and ftruncate() to be used to extend a fil=
e
> >        beyond its current length: a notable example on Linux is VFAT.
> exFAT does not give up with an error. If the latency was unacceptable,
> this shouldn't have been allowed in the first place. I believe
> applications that wishes to do explicit zeroing out usually choose to
> use posix_fallocate() but don't quote me on that.
>
> What I'm suggesting is that fallocate() should just mirror the current
> behaviour of ftruncate() so that the applications that only expand the
> contents of files sequentially can benefit from fast fallocate() that
> the current exfat's use of VDL provides and quite possibly less
> fragmentation.
Agreed, I would really appreciate it if you could update the current
patch you sent.
Thanks.
