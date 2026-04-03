Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37253366074
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 06:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775197161; cv=none; b=VQKKf+JAO06Wc0guYYLXnAZLcI+sZuDj9bs2zbzAlft/XxAfnRZWFH+yG203mBQBO4UhVVmj30VXwLxuQNWmD9kc4DIaQ43jxEzVgWuaJgYzaekJePP3e6utDR6WeS5dN/SWLzWHAdGqEChbo+yzTjbokjWzH8cvtkl0l73bp9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775197161; c=relaxed/simple;
	bh=eLnlj59ojerfwvhzaMwVJgvXsVvsUa9iWxrA71PjGKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qdm84h83xuljAZrzrtM5ENELDzbVUR7B9ubGk788hrbDkrJrFXiyt/avcE/SzTVSCt79R+zsAcSHU7qCZYkXq5Hb5xr/t+QIlfKxR+aJfs4CbNxf87Levraotss9ksq+tl8Z9GYDvS79zquz9XmWcEKOmLJ5TiWQv+kZ1kr6Fbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j96bFSMp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j96bFSMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E150EC2BCB0
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 06:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775197159;
	bh=eLnlj59ojerfwvhzaMwVJgvXsVvsUa9iWxrA71PjGKo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j96bFSMppKBx9B+dNPne/zCj4vpqr3sZQkvKwppa833TC5e9fbIT6CpWIkm/X5eUr
	 /fQKT/isImaf4PkAU9NhxxPdk9BzM7mQ6gL/QhvFOqOianA8ycfwGaaf/X5sbjZMsR
	 Ls7jxhAwyB8mRFwSgqozOSfzY1eSco/b9isorwUGHVXjuXhSYRclWiP5pocvgTCK6k
	 xMaiL6xC/KbBaDnRsCUL0QygElVzuWrvD4ar01J8GUNePnMsgIfik/AiOGQqPBHMqA
	 8HGHSMtYDN2FttFvXgJNvGcePg1mBx2cjAEqZi3nePrQGyfttokPA3sE5MGkvcpMDp
	 VY23jwTmizmCw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66c24b42efbso2601557a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 23:19:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXXc+Vzas0ilRId8qw8kJOUYo2onvGfTl0iRGaTuqQspUZ/SDT/I90GQvPFAtDLF9IXcuxWaNuN29FnRRz@vger.kernel.org
X-Gm-Message-State: AOJu0YylkEgN38TmUuxt1fXrfQDJCwY1m8uTE0o2jPQoHlN5yanHIcoY
	1XeIzZRck7zJmcX5CVWNthwvFfSuxocliX9wMH7zluKpBjZqaZi8ao3uIqWTfzXV/1HlIG3iTxS
	nNBweWPqdXbv3pbY3O/oiLiMq1qt/NsQ=
X-Received: by 2002:a05:6402:13d0:b0:669:c769:cd1c with SMTP id
 4fb4d7f45d1cf-66e3f83d98dmr817460a12.19.1775197158479; Thu, 02 Apr 2026
 23:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322125944.48541-1-dxdt@dev.snart.me> <20260322125944.48541-2-dxdt@dev.snart.me>
 <CAKYAXd_0TeNuruJznXjs+MT8cW2zwOiuNGwztF=A7t8ZgKiKQA@mail.gmail.com> <9e82ba4e-506e-4f00-ad06-67c0d541cace@dev.snart.me>
In-Reply-To: <9e82ba4e-506e-4f00-ad06-67c0d541cace@dev.snart.me>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 3 Apr 2026 15:19:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9fENATzE7abUGMZ1uYARhFW=oG_7yvUSWvoX+25nv_Aw@mail.gmail.com>
X-Gm-Features: AQROBzDCyB2UqEXj-bYLAh2fZNZsIc_SF0ar1--K_ig-kAA5ASXtgG1VlAq47Fg
Message-ID: <CAKYAXd9fENATzE7abUGMZ1uYARhFW=oG_7yvUSWvoX+25nv_Aw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] exfat: add limited FALLOC_FL_ZERO_RANGE support
To: David Timber <dxdt@dev.snart.me>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 11:55=E2=80=AFAM David Timber <dxdt@dev.snart.me> wr=
ote:
>
> On 4/1/26 16:12, Namjae Jeon wrote:
> > Why is this limited FALLOC_FL_ZERO_RANGE support actually needed in
> > applications?
> > What are the practical use cases or benefits for applications?
> Please see the original cover letter at
> https://lore.kernel.org/linux-fsdevel/20260319043553.301185-1-dxdt@dev.sn=
art.me/
>
> To answer the question: zeroing out entire file leaving the cluster
> chain intact to avoid I/O and flash wear
I have some concerns about adding this limited FALLOC_FL_ZERO_RANGE
support to exfat. It is already possible to achieve a very similar
result using ftruncate() and fallocate(FALLOC_FL_ALLOCATE_RANGE).
First, call ftruncate(fd, 0) to adjust the file size and Valid Data
Length (VDL). Then, call ftruncate(fd, new_size) or use
fallocate(FALLOC_FL_ALLOCATE_RANGE, newsize) to preallocate clusters.
Additionally, The proposed implementation is quite restricted. It only
works when the range covers EOF unlike the standard
FALLOC_FL_ZERO_RANGE behavior documented in the man page and
implemented in other filesystems. This may confuse userspace tools.
