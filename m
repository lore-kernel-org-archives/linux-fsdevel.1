Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4A537AA95
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798377; cv=pass; b=pwx4I8flPBbF2OkI6iwZ96km+ub5sv4zkKeOKIutgPe8BR8BkSf/c0tcKyohhA2Q6WaynniIelhGkZGuc2QTjVJnfHrDaX5UHh2d5oM3MTPikamxrPuSYc8RvYYZRYse/xSOJRwXiIbNg5ZO4syuJ0Nld2bzGyHgE+Eh+EewDqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798377; c=relaxed/simple;
	bh=ptb5ZxUirqu3cGwvf8pr6jbj/gODGCQR5YHXZ8pfSO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnZXOV45P04ep7YXpq2KIvllN7Hq0eZsjfHEMjvf60YkGtHBLvaWhZLryZn0rdXrZEH8G42LRTDbo4KEXQn3iJwRgF1WapqgCh5qpfmITVqcFC1cHteAgi9wuQzjhLOK3WZorlQaj4krbEmRyLY2aXIZDcrMRpZUhL9bGAfd8E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=keOlB1AH; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="keOlB1AH"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-52192509869so3057871cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 02:19:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784798368; cv=none;
        d=google.com; s=arc-20260327;
        b=gDApNJTGeHLES5crwPGSkrhOcyNdNLD7rtYzsw3zEZxMZYXoqQzu+ETHKtwrZqKgQh
         xPVzfq2Hrb12w5ie6Gc8vYL/zx/zVihuM8T1JnbQm6XQ7GIHOjlHPbj6aQeA0Z0+YwOQ
         ln3LLTk4MYq3USoIUW3a/BdEFrqIdz/4DkeVcSROWmgAQnRqSUkorWCiiXOL5OCmvl1/
         /rVltUacFMlnwkx8NUIsz9B1LJZBlGGoJ4h7fVMtyavl7C59EOU84vA19QpfrYsEbFUO
         v3keZUtPjIh+9/jghNkaHdLy3JMj8uvITgN2ifv8L3A9rt+JBnW18a31SCzFpw6wS6vE
         daFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kfYZU6mmSr/3MS4E2nALRlpwiopOrciEufMpSapbBDU=;
        fh=OLzzEJezdqVPNfZ2HJfqEvJG3AnKEB/Iasa9fmjM3/I=;
        b=TCw8DkGzvRFbM4x1rI+rT6L4yA0suo1ZFMKdAQUY5DXS2ZqRB1exXrGCE/umdS8EH7
         8gHTUfT8g27Fi5kSDaho8Y+hs0QuRKtVhdY1wINNYxsDo5HM8ALPvwCMOOSCSMrkoLRX
         FV4eo7W3vPzgNH4B+bKvYAKm9NWDyBvLvWT75W5ODikEEJRaGi6LbJGQJKHz1VFX9uCz
         PhgfJ/fInbakCZGoNT1/byltGc3Smd+Pv+5+Qz7nYB+blsz6qE4c3sKhFsIwIJSc2AnK
         PFGhQXhFPiPh74fvYUx41+qkaFtLuvShDa17KR8cq1jD+rNbpFD0MesbXbZcowyzT9Wi
         y/JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1784798368; x=1785403168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kfYZU6mmSr/3MS4E2nALRlpwiopOrciEufMpSapbBDU=;
        b=keOlB1AHBBO6T/T1hkgCA6EQ0WgybPZ/+m0GoxIu0MtX5Jhz5FRd9RjOkni5HCsGVD
         1io27rV8ikCj2LQfGSvlA7ZcSH8v21LLVgVLTS7dAOFbdz2lZsR+AIFiYb7IJZefSKvo
         w9ODy+WQ2kChww/7p+4YeozuzCm5dAQI+GEfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784798368; x=1785403168;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kfYZU6mmSr/3MS4E2nALRlpwiopOrciEufMpSapbBDU=;
        b=hjELieBd4LqIJQD1/zKPVtRQOFeQy/aGB7zCk2bKYlMwVxllxWkoLZ2Wc8vn+K8D9j
         ThYaEDb/V+IAxxkocGgFqK2LdTm3awlxHj9M+UR04zmU+Lx7xs4PAoMknsujXkJlMyiS
         Si0J8DnNppmuvLWafxpSJ+74yMl9KnOZHK/8u4PhyMqTjMKxAv3oNf10AeTMn/SpUG+L
         06sNvxO1QwEWuSz6PNvoBH3QZfmcnkKId8ugWm1wAuScU1QlwCuRfQVj4TIk99PtVHGS
         ZERlTM/hOl56S3Nl/RCCV6Dt7Pkhvi9aM7l2pzOJHjeUICAoOzymC9mJxBETlL2PqeWN
         ebJg==
X-Forwarded-Encrypted: i=1; AHgh+RoVuoh5GRZ4tqOMXwLr2wTI0d4omoe7fpQQgP3JXUYz82PoLOZ9A8rDOmXhGb3Gva3kXDr6TzfNUbw4xAAj@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ5i0+jlpwHOa483Xe7Mn2Ydoj7HwctDraIRS0+VgKpBzjO4eP
	ONB9Xx1UfoOrdjZYyRndVFiPfm0kapJlWitXGqc4WX4s/DKWs0rBHVZ9MHdZafeYwa421xQwak1
	gQr6f8ULZFdDA1+Dwn7hJssuTLir8FeHDpGzUhkp8HQ==
X-Gm-Gg: AR+sD12wwzFP80TXY7VtBh8YIEnyh7cZA8gQuR/gLSXuiz3fAL9RRL0BoYgAwl50Q1+
	4WvGZGlG7eBkZQiEyUMY5Ub4IZcsuQde+1uUewxQveG31dAGWhrVnfY/PunkMej4OSPclMF5iUY
	ZPniWuLDYbiH7k4fB4K6gL5iSNY3+0xdO3uaTbPDQVSMuyjdu+OfM8TmBXpqx68gzMV88jh08UB
	FJQ1KOUU4VLzZSgcP0MGNYHzetwkR0z4y3aEt5d6GJUgsnQ8qkGUQU57lsdSPKnpg/GRg58s6gx
	EukTvFcU7zNabfIkDL0RgEQUcNbC
X-Received: by 2002:a05:622a:1829:b0:51c:8439:14d1 with SMTP id
 d75a77b69052e-5283dfcded8mr20528451cf.63.1784798368136; Thu, 23 Jul 2026
 02:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegupwNTaVNZtdQTmvtz9x=ehH59hzsRT7D0=VbhOZvaqrQ@mail.gmail.com>
 <6C96C8A7-345E-4388-8EDC-D94E9463D214@amacapital.net>
In-Reply-To: <6C96C8A7-345E-4388-8EDC-D94E9463D214@amacapital.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Jul 2026 11:19:16 +0200
X-Gm-Features: AUfX_mwYbGEjI6yeBtsXmiyva2-bOQkj3_zJ1N3_FyC9B2rBmuR5k88F1rTJxak
Message-ID: <CAJfpegteZbnPkiTSAPWXDqZbf5eALK0E_npBLtLTmJyZaHXdyg@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: allow opening overlayfs/erofs layers through O_ALT
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christian Brauner <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Giuseppe Scrivano <gscrivan@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Amir Goldstein <amir73il@gmail.com>, 
	Xiang Gao <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Jul 2026 at 11:01, Andy Lutomirski <luto@amacapital.net> wrote:

> - O_XYZ flags to open() are all kinds of awful, for historical reasons th=
at are not fundamental to the concept.

I'm fine with limiting this to openat2().

> - symlinks. If we have a new API where opening /proc/something/magic/blah=
 can access something that ought to be inaccessible when accessed intention=
ally and with privilege, a symlink pointing at /proc/something/=E2=80=A6 ca=
n cause the API to be used inadvertently.  Admittedly we have this problem =
with basically all symlinks, so this isn=E2=80=99t exactly unique.
>
> - our nasty fs permission model. We gave a sort of gnarly mix of a bit of=
 fd-based permission and mostly mode/ACL-based permissions for path travers=
al and opening, and mapping this nicely only new APIs (as opposed to actual=
 files and directories) can have unpleasant results.

Pseudo filesystems don't usually do mode/acl based permission checks.
 I don't see any issue with that.

> Of course, I=E2=80=99m busy arguing (slowly and without a concrete propos=
al) that we should have proper capability-like fds, and maybe that=E2=80=99=
s kind of an answer to this:
>
> What if we had an API to get an fd to the =E2=80=9Ccontrol filesystem=E2=
=80=9D for a superblock, like your O_ALT but as a real syscall or maybe onl=
y accessible via one of the newer and less janky open variants?  And what i=
f the resulting fd and the filesystem tree it represented had a few propert=
ies that made it very different from normal directory fds:
>
> - You cannot mount anything on it or its subdirectories, nor can you open=
_tree or otherwise mount it anywhere.  But you can open_tree the very speci=
fic things in it that point outside of the special API (e.g. the overlayfs =
layers).

This patch provides exeactly those properties.

> - Privilege is fully captured by the original call that gets you the fd. =
 current->cred is not checked when *using* it except to the extent that you=
 might need privileges over your own namespaces to do operations that might=
 affect them.

This is trivial to add to metafs: just store a ref to current->cred
besides the path.

Not sure how this security model would work, though.

>
> - You can=E2=80=99t fchdir or (hypothetically) fchroot into it.  (Not sur=
e how important this is.)

Not sure if there are internal mounts that have directories?  If not,
we can just add a check to fchdir/chroot against mnt_ns being NULL.

> - Maybe you can=E2=80=99t follow /proc/pid/fd/N links into it either?  Or=
 maybe that would break CRIU too badly.
>
> The basic idea here is to try to treat it like an API that happens to use=
 the open machinery but not as part of the filesystem hierarchy.

I'm not opposed to limiting this in various ways, though I don't
really see the advantage.

One thing I hate vehemently is directory lseek to a non-zero offset.
I'd happily error out on that one.

Thanks,
Miklos
