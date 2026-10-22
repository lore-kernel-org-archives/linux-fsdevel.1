Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792668419;
	b=yw05KLP/zDWZ/SgudqA1KqNxgbBGkQc64GTXW7koem8QxWUltGcUuR0FfSATQ1W6q1Yd
	 Uu+j5nm9muKg9Wefw11xf9WUcuhzaRLkHC+0sPRDbWlFrZK89F/zzV79wbhyhIovg25XN
	 Ve2r7e5+Y3g3lYCYQxWVp53ob5js4qp2+d4zX6gQZuOcNHOpKUJGWEhs5oHqus0peXIdQ
	 4JKO7KO9FGkJ1LVxA4UNnaRIP0V7xhOTDV2QCqQoSk/jg0wgjeuFKuvPpv9ky0tNTdMMp
	 Xet8L6MO/ZapzWmpXalbQN4KwPt7KYGZyl1d+f52xbXnkvCq6oJm/YdEID0dOSwAbGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792668419;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=m2XW18vNW4o1eqMkNJZgcsexX3BdEqPbWYsFQmtVUt8=;
	b=Zjui2okCLBDWMF+5MoAOmDi8VgYXVeMBi+GfpfRUt/eAH9wNmp1vWnfoqYkaT7bP2pTl
	 HbmQwcYavzO+VXL/xDVuJb8SVGyzA2lHGY40bc7OWob9hOch6kAgVRLaY0S/NlarITung
	 YDYPU8YVcg4Uzr7az4q3KOi7KXVKPoGJJb7QsKXzgER5CIkbsDvsT2zWoMOt5zL+w8ABU
	 bdI/xrWvpq5nLV8XHaqetLEel9QszHZkDrqvjkKksipVRVBltnX6IXSj8TAeAgXRhEU77
	 +9If2ecIPrlRctDMGH/W4SW1q8fN9hUrhWcoFBVwJasUiWz0Mc8auVm8jfumu6+ACRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PN3uGCdJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF10E606A320
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PN3uGCdJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586DB1F000CA
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 11:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792668418;
	bh=m2XW18vNW4o1eqMkNJZgcsexX3BdEqPbWYsFQmtVUt8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PN3uGCdJxdI7P19DHlNpW+xffMvvBjssKle0WuOyYYL/cJJdoJ9TbEmwSRlCMyOB0
	 J7VnHtiGw29voyaEhFmjar/xxfwqgbQXDKFZjWr7QQsCosBB2syyTyM4teDufVZS1Q
	 TxjJj2mnSylQWvIoC9n03gWbyu/E3WBQJf5uhI+zy5InWLcSnfy0U/OIPPtXCgTmC1
	 BL4DipFoeD0YW4tyIXAGWGxN5iSDJVvD2gJjChBfVD+1Kh0eGSsUO73B3UT9ru52pf
	 KMdBFcvRtSb552vdLFGXD1tqtqEHHYXDy42HKj6DW03H1yTJZduH5qWCjbxF84OXtd
	 GdxviGglTCt2Q==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso1251403a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 04:26:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBw2D7V9B6p6CZIIptJGrAR5++HXuXQe5JZs+glb3qTDLrsI5M5QYaUemzKv1SzjjG/tzZIuzNB7AIwSTS3Y@vger.kernel.org
X-Gm-Message-State: AFq9FYJTAf9fk2zG03uACfuQDRjjdLxSKIQYcASxqa1YqAJvxED/yWT1
	oFlrF/qzTZiB71ofSWUbzAJ2JMtZ/LLmTFRMqqedCLSojgzYTuzi3P78wHFxm4hKJ1d1HqQmzUk
	w1T8CX0NZJT4XTOOzRyV9/7R2Jxirrms=
X-Received: by 2002:a17:907:6e87:b0:c29:4b57:503e with SMTP id
 a640c23a62f3a-c468d5dafdbmr240442766b.1.1792668417000; Thu, 22 Oct 2026
 04:26:57 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260928012812.2890035-1-neilb@ownmail.net> <20261021-sodbrennen-ausdruck-kurven-72d0b7cc7db9@brauner>
 <655e5d4f-7890-4956-88d2-cb571be218d6@talpey.com>
In-Reply-To: <655e5d4f-7890-4956-88d2-cb571be218d6@talpey.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 22 Oct 2026 20:26:43 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-_WQTr_5zNLjrp3Q1+zBtRNTFYkvMpC6RpDEjY0xi=zg@mail.gmail.com>
X-Gm-Features: AclHuK8zNS3wgHEO5R7ujwkr3nixmETTfEc_4BRtiMijOW7Jer_U3sEFhzfjwKY
Message-ID: <CAKYAXd-_WQTr_5zNLjrp3Q1+zBtRNTFYkvMpC6RpDEjY0xi=zg@mail.gmail.com>
Subject: Re: [PATCH 0/3] smb/client(cifs): prepare for locking changes.
To: Tom Talpey <tom@talpey.com>
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>, 
	Paulo Alcantara <pc@manguebit.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 12:32=E2=80=AFAM Tom Talpey <tom@talpey.com> wrote:
>
> On 10/21/2026 5:55 AM, Christian Brauner wrote:
> > On Mon, Sep 28, 2026 at 11:25:01AM +1000, NeilBrown wrote:
> >> I am working on changes to directory locking.  The medium term goal is
> >> to lift d_alloc_parallel() locking above i_rwsem, so d_alloc_paralle()
> >> can be run unlocked, and consequently cannot be called when ->i_rwsem =
is
> >> held.
> >>
> >> The requires:
> >>   1/ that d_alloc_parallel() not be called while i_rwsem is held.  cif=
s
> >>      does this in a couple of places.  A new interface d_alloc_trylock=
()
> >>      is now available and can be used instead.
> >>
> >>   2/ a dentry must not be d_drop()ed while an operation is ongoing, as=
 an
> >>      unlocked d_alloc_parallel() would then be able to create a new
> >>      dentry with the same name.  In particular d_rehash() must be phas=
ed
> >>      out as it won't be safe.  This particularly affects the mechanism=
 to
> >>      block lookups/revalidates while an unlink/rename is happening.  T=
he
> >>      mechanism is changed to use one similar to how NFS addresses this
> >>      needed, though using the new LOOKUP_PRIVATE flag.
> >>
> >> The patches depend on patches recently added to the vfs tree.  I would
> >> prefer these land in that tree too with an Acked-by or similar from ci=
fs
> >> maintainers.
> >
Hi Christian,
> > Can do, will need an Ack.
> I will defer to Paulo for the Ack, but for the series, modulo my nit
> on DCACHE_BLOCKED:
>
> Reviewed-by: Tom Talpey <tom@talpey.com>
There is a v2 patch series. Please make sure not to pick up the older
v1 patches.

https://lore.kernel.org/linux-fsdevel/20260929024352.1433257-1-neilb@ownmai=
l.net/

Thanks.
