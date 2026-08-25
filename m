Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42523484256
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787670104; cv=pass; b=l95veuQOvB4utkPKQ+Tk5gNXngkoAfCAu1Vreq7SdRIHITCLLcbg2qc8Jm0KWWdgD/hh+Kvp4vjoCA3TH8o5a/bMYFWaiPrWWdZ7EWmLCKT203q5ClkU4k29IY8OkqlWLp+3eZncRZYnBMaJVD0y9Vj3PvEWl/JhhoodvBPluMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787670104; c=relaxed/simple;
	bh=0oIFfbtqqpkWwrgVhDrxQYn46cLcGtScXKxY6SpqPlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dVTdj2ydfSvNomeWe6soqyXT7DjJIOrPYYZrXgePVbs8C7R8LMCIkzbBz0Zac2maZ614+c7rg3wF9BKTcfAm8FfLOXOcoT4SDjkHjDx1jBbxOGeS94DwFY2vVNeXK3g+S0VmYV6MYnmCIzeBJczQmtQ4DTP1/CZDVZBLUsG2Bes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QRHUBOKl; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QRHUBOKl"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cede6375caso135565ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 08:01:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787670098; cv=none;
        d=google.com; s=arc-20260327;
        b=KmYDwXrPAJyExvaXH/Ox6NiF0PnlMhIvykGorl7do5f65WVCDOLyf9CgGhmTsr5/JV
         TFagtLvXz0qnToy4drIdJs/c3X0JywuPWfbdSMXPALtMip/49nn7iJjsWOaT0xRE73Tw
         JhAsgkdfk0L+y0vEZEFxmK6QVS4jclG3X7FIqVZdq5UhEW2PZXt71ntv94sLtNV7QkJa
         2N2+tF3mN4NJ0cBhtjmGH8ghBG7GwLXQ503BfQue1z9i/YGdfMF6bLadOa5sxmqRs2pC
         ebnAHSJbL4+JK0KA6+wGCu/YNQslomAEB7nIJWZsnKfFUceHVLz2LuxTvIZDo3EZFMUB
         aNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0oIFfbtqqpkWwrgVhDrxQYn46cLcGtScXKxY6SpqPlY=;
        fh=7KBO+VbzY/mDFdg9EsycLnswe0XlmvCTraof+e+33Jw=;
        b=Ua22aLYMyCoOA2J50Hd5ec8DTxTHv0m62LnS6iGBonxnAZsBvR0+t4GxZtzTmbAid7
         6BdsRKWen+PpsVRHxUx157y8kdTZzvpxLDGOoUrBD2O+2447KIzsbn0C/3H8jXYBi4Eo
         PyP2FKxuYnKOIbo62FKt1YiNCtUDzB8ixndlenVSZn7MAEBf+bufOz8StDIiiJJOg8P2
         uAEE7ROkDEpjLeDSKe2j3gGBCOY/nQEU78RyjSQPInn1iCRyIb+/Nz+rP9dGOQoeJiqi
         ukb51qyMRavbwdnT8nsnEdJIdvm+iOzi6/+juW2NBCiVhAgCF5seCkQsy4kzc+FbpPoc
         MlTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787670098; x=1788274898; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0oIFfbtqqpkWwrgVhDrxQYn46cLcGtScXKxY6SpqPlY=;
        b=QRHUBOKlzFp2EUDbgAbVIUmvSQxukfXIgYGIoHnPGvAN91/GN0MZQHvc60BWiuqmgo
         kr/PtF59JhfSWOJZ+P21JoGDBIu4Pzd7BTtKT2CPaveAXjfHx+TFxdDCDaNemPUbXFPn
         UWvnoFI1GObNx3QM0ytQk3/4ScytjtfU16KAkq+5zwGr4w0XzR/RoupLTMzEygVELayQ
         8voun+KYDqp226WBWpNuM4whG8NKscmcgnUm+EOMCBR0ucOpp7kGCPemZLNVqp4dtJBu
         HCSTeLH32SzoAZTPLORsjG5kekL4Gno7XZPltPsyA15Zv3GPjDlRI46mK7YRn+4tHOpq
         MFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787670098; x=1788274898;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0oIFfbtqqpkWwrgVhDrxQYn46cLcGtScXKxY6SpqPlY=;
        b=GxCcI/1Ne5prJ0jToh6bI8IurcrE7cReTxc//Y7WsEgofnaj9EuXi7BNmgjwvlxBcQ
         M8GX8EH9lP9Bib61BuqGQ7KEjYhyBzi/ITNJ+Jg+9utEPqolwrR/nfhxHDqZD+UGQ1eW
         EuqOUxb+hGUQLe6P03ibrn8DrjYWyh5/kLEAGIcXC9j9dt7VZR4/+0M9X4WLZCJ/azLb
         /zm0kaEAxZVxENI/y8cm2sYpXroqye4+Mup86oENYFPoxnprxlSY4gEwHbzwe3gam8J7
         +agvMoHttSaCXLeUbFljyTtfDn/XTvyOuydNhQP1Udkn//n+iMxs6ocyJJ6waWP8MP3m
         V6Iw==
X-Forwarded-Encrypted: i=1; AHgh+Rr2lFelWX9OB6muGtkk8v96wax2s76KfNb7FTmVZiWHe9BfB8rW63QqazwS9gWevc/fLJYOcJwHSgH+9CJJ@vger.kernel.org
X-Gm-Message-State: AFuF++mtijfRIuCIwCd3NQuUEj+pkzG+pTnE6aOJVLZ1HdCm4s35rdyt
	+ymld/CsgJ5tLXXbIXpdm4lIWMCPBaR82AI7w2udvURStxzBc190czJaaUrfRrkITHxF8GTP/aO
	ZD29E1ROi0YvNNkzAGy08iND9uzCvTwL86noF9DyQ
X-Gm-Gg: AR+sD10yJaep/bme9A52bVge2bqXsyfuq/7aE7GZJhyju6vN5MQ2dFkNL/N9oVoC8Wr
	CUVAxzmsawqu/MH+1TPJUI2lqBCpTp3xU5o6IhFt4VjLPe+1GadWLoI+6G07tLG/flqAe0IjmYV
	/TZzgUSwyb1hpr0ZuiW795AE4X9ugGUYoDAeWn4tQ6uoyAHh1sbuIiXhoEmIbpGsn00mRxrUobJ
	64NVoq/bFX4ea6ar25pWhZWKkOTRGOlNiRcHKviSkP71uwurDQcpcYsVn4ZnqaiH6E/HI0axbox
	drNP36ALGMd40tIaQ1mALZsB2z+JK12VHWywwe23rTYcibq4w9vEkHhyPEREitznnzytMRyEnrm
	jGwrIXy5QvdAVNd1oE96HNzpB1whecg==
X-Received: by 2002:a17:902:f142:b0:2c0:defb:557e with SMTP id
 d9443c01a7336-2d6e07f52b9mr5455445ad.1.1787670096873; Tue, 25 Aug 2026
 08:01:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
 <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com>
 <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org> <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
 <aoibvf6CY99IXynk@gremlin> <CAG48ez0CX-PT5Yk5gYJuB6wPe26j0gHHXQqYoNtTA=iHe_5Wdw@mail.gmail.com>
 <aox7tVIQBMuz-xFO@gremlin> <CAG48ez2-8UjzOp=St5eTPyG_yd2iBmPF6y7qVBTNaPNJgoX=BA@mail.gmail.com>
 <ao2a33Xf3U0kQmM_@gremlin> <CAG48ez00PjoaXt4xJn1DCNdZfmFn4faya++=U2EeW0_vcYXcqg@mail.gmail.com>
 <ao2jfUGzbtlW0LBI@gremlin>
In-Reply-To: <ao2jfUGzbtlW0LBI@gremlin>
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Aug 2026 17:00:59 +0200
X-Gm-Features: AcwNN1U7WXh0ifC0L0ioBcpyrRebieCgpS1C9eeY3jXHe62YSQNBLeFZPlG6sX8
Message-ID: <CAG48ez1ttTOf6wobCpRK+upYJqU82jgmxGSX_e7xWuxU7xYoYg@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 4:24=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> On Tue, Aug 25, 2026 at 04:08:42PM +0200, Jann Horn wrote:
> > On Tue, Aug 25, 2026 at 3:42=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kern=
el.org> wrote:
> > > On Mon, Aug 24, 2026 at 07:43:02PM +0200, Jann Horn wrote:
> > > > On Mon, Aug 24, 2026 at 7:33=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@=
kernel.org> wrote:
> > > > > On Mon, Aug 24, 2026 at 07:06:04PM +0200, Jann Horn wrote:
> > > > > > On Fri, Aug 21, 2026 at 8:52=E2=80=AFPM Lorenzo Stoakes (ARM) <=
ljs@kernel.org> wrote:
> > > > > > > The sharing a /proc/mem fd seems like that's a pretty dumb th=
ing to do in
> > > > > > > general :) but I guess you have to protect against that.
> > > > > >
> > > > > > Yeah, it's a kinda weird thing to do...
> > > > >
> > > > > Yup :)) but I guess we have to account for people doing weird stu=
ff...
> > > > >
> > > > > In this case (I do mention it in a reply elsewhere I think) it do=
es seem
> > > > > like perhaps you should separately check for current->mm !=3D mm =
of (what was
> > > > > originally /proc/self/mm)?
> > > >
> > > > I wouldn't want to do it for this access check, since that could le=
ad
> > > > to "confused deputy" problems.
> > >
> > > I guess if it got the decision wrong somehow that'd be a problem? Or =
wrongly
> > > OK'd it on one level but then that led to the fd being passed on assu=
mption it
> > > was OK to do it or something?
> >
> > The problematic scenario would be something like:
> >
> > 1. process A opens fd1=3Dopen("/proc/self/mem",O_RDWR)
> > 2. process A does lseek(fd1, <address of libc>, SEEK_SET)
> > 3. A sends fd1 to privileged daemon B as a "log output" FD
> > 4. privileged daemon B write()s into fd1
> >
> > In this scenario, daemon B is just trying to write log output into a
> > file descriptor. If we checked the current credentials on write(), we
> > might enable FOLL_FORCE just because daemon B is generally permitted
> > to use ptrace.
> >
> > This illustrates why, in general, the "ambient privilege" that a
> > process has must not influence write() access decisions.
>
> Ahh. That makes sense.
>
> But I mean in this case the check would be that the mm is the one belongi=
ng to
> the process in question so wouldn't you need in the first place to have o=
btained
> a privileged mm anyway?
>
> If the check is literally mm of /proc/$pid/mem =3D=3D current->mm?

Ah, right, true.

Still, I think I want to generally avoid looking at the current
process in write(). If I did add such a check, and the check failed,
I'm also not sure what I'd do with this information.

> And wouldn't prilileged process -> fd to /proc/$pid/mem -> less privilege=
d
> process be a fail in itself?

Yes, true.
