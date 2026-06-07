Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D6A374E6F
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 08:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780822322; cv=pass; b=QkCDh0vB5W/zZYnLhcbZNawkPIuG/47YWXd/R76j4EQo87nWTVV6Hs0EROsVxbPXhUbgt7Eu/eJhbnLxjoXrpV5ZwkZM273H1r6MOxzyu+oAP75i73KD7HuQyO1AyVllrWTqBhs/V0i1j06bdnciuYq9R9zmW7tdxrMfXbUoh4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780822322; c=relaxed/simple;
	bh=HQ7eL9H0vx1RkQQYjPnLRgCiNO5wDU8NIfENntL+T0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrWnSRl/VllifWYDOryyWWOs/9mTE9ilXKNW5W3rv0RuOOg6WvihwnHTF0eqS8AoqwTW/hsdZO5UXBPZeJFFMHHxiz3hpuEpJXPZh00HrPGgflrqrXbT8B39MXKeiU6xDA4OCzPJLS7s4w96R1JZkGgrwAfYNSUKSr15C8Lekek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pohkLFCO; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pohkLFCO"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-beb8a08a6c8so463229566b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jun 2026 01:51:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780822318; cv=none;
        d=google.com; s=arc-20240605;
        b=VHsgKxAKlB9mejC7nsDLx4sBOy2JkbD5CeaBqMtDtzh3+QC8HxxAwdrLM5cRH4scU3
         wv0g+9Z6Tgw5rfi4wd50OxMKdjp4y5O77xITWKsYXuaO/VEtdrcoB2+VEn4jygL2sARb
         QPp/WUdkPoT8u0wGbbBdwzF9mROT/1imV0ztcPdXx9uOV3WQ4yxU4htLsrui1cKy9Poa
         C6dIExX4L+6nV3HqbMlwYF4WXWaGLavEWQeG+we4JEBKHavWCU7M8vHUlJ8cxT6E21Q/
         rQc25540CzEyaH+BQ+xcFmduFuEn089OAMNFx3izRZw+a7S497b+qZs9VQW8fFrgraDh
         bMog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oJViM4BQ64chJ+VWkODF1kN38NNZkSsZpn+5VIMmcf0=;
        fh=mJ40TL5Tysvw5C3OO9KCjCvnFWiSc4vH0sAC/xVBxp8=;
        b=Kyf92WlKUhDKtmVlCOuYq/C3hSkXGi+v+J5AJHyRhYflU5U6Z5Iel4B9RiPTILCy0s
         sPK7BX1PLfNwB8PAP1ysyTpe/U6mu36SiankBHYUjt1TGQ7wTJaFyoRBkqddguiEo2Vf
         XvvXUmaUfGqGhGZ4rnU37UJfAnW6q2hHSrJwz17VSdmU7xT8uFVYOJJ1qW5AMeq+77Q4
         u6KsWgQFkyv21uXdZyvDAiGLOqsArWFa2VwcrKasj9zEFgrK8O2iO1AaHhkLXYsgTN1E
         9duLN9F96Mii6VYv7LEHKyIOwGVlJb9QJMvHGQohZIZhmgxeD0hU+ZtjryfscoIvBljA
         5FJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780822318; x=1781427118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJViM4BQ64chJ+VWkODF1kN38NNZkSsZpn+5VIMmcf0=;
        b=pohkLFCOrK+PE33sMCk4JH2ydXgDiKXlr/hp6fPDDAcOOWQs5BkeaH29kO8V0Rbyof
         MzfkDDodi1Fkp5H34UDQIOvxNg95YL4kMIzIP6/k5EgVkhuv94g+ecmKqJ6Uy0jcnP0F
         HyJqj72Q4mDOOL6IWLo+TcFXOeQwLdfydYRtDPqDPGjLq8wzQ4q1mbBPkAOSg2TC0jAj
         /hMyWQF0jqK80WSrRqWUyZomrscuDOZ1pdmjykRDZQ/EMLAhBp/A41cmFxP1wM6RSd+1
         RjNo+Mz2EY/wUakvg7p56lgHQdV+2zbr/bn9OxqFXiu2waWjIelpa9H+ZHV7da25FwKf
         79LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780822318; x=1781427118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oJViM4BQ64chJ+VWkODF1kN38NNZkSsZpn+5VIMmcf0=;
        b=Sof/lohHy//hIEQArbqv0dQZ2qXxOreHuxwzu6HgJvnmimxuTJam6wY5BTkxbYO1LG
         Nep+tCPJ56YwxwH5mBwllD+avIM9t+dnC8w6bwapzykAxpcKEfDStQ6w8jwgiqOEM8Zc
         Bvqq9TKD6CJzcVzghOPu59UKzgjuacTf4SZXWQ7xAPMoFHddbrl2XunpEvROqdVSoRK9
         aCbFaKZJyA1sEpxRF6tzMRObc2oR3Qndu5ycaCtrbafk7ljyqxSbcfVFm0A1X3vcPshM
         2It50xiGYucpy3D+yeuPthe4nWSYBqkutp5mJFFXrTM1EKlNWvSF8LlTLQFj/Jqt5k1r
         tEjw==
X-Forwarded-Encrypted: i=1; AFNElJ8ROIb6KasS4nCIhJvxzIikKVClyqKdF2SyCAI16+NPl36J6sZd86170CRqCMEvu9ir2SSBoh5eSXLSOVHP@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2A9Ny6h9dSGMfCB2TyLbgPSYx4xJRPb9FQCr+uQAXq8WJkvV
	0Q2HEXhTRJfeDkOP/4Lj6CdNap/U6i1BIo5HAB8zqNFtux5+BZkgf1f3z3lskieMTvoEe5NtKjs
	brmTZSVpvRGrJde+ID4bqHIBFkYjvHPg=
X-Gm-Gg: Acq92OEt83SZldEzqFyC5Y5u5FgaBFYhEqXg00I8VItjkhiKDWTFLFCgsHihntwfwdR
	22yMulJs1GKr6jwSoDe64gUko3+N59cZiTuaGCzabpyLM+fWRt1ZOQvivhIA0NhdNvP2lHvHTpP
	VDrsqu5jUpbe0So8uujWmORV4JRq/kHmxY/JTuv7Afo9P3UpJkI4Ztayr+vTVPf3Zrgw+WMB9Gi
	kMZT2dUbduqWE6UH7VkAirj9Q/spgm1ziLux1et5mNhcEHKo2BO+qLxkKc5e/oHCosWm4qguKXT
	+I77pjlt6fbNbGz7vsn03r3Mn9DD3EzzG11JTYIPmWO4a9tgqWQk
X-Received: by 2002:a17:907:948e:b0:bec:5ebd:e169 with SMTP id
 a640c23a62f3a-bf37263c586mr540431666b.22.1780822317605; Sun, 07 Jun 2026
 01:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177922944800.2436629.7011047808676668088.stgit@frogsfrogsfrogs>
 <177922944844.2436629.11205124993260163523.stgit@frogsfrogsfrogs>
 <CAOQ4uxjJ0eF0vE0hgsNoWqqD+UQ4r-1-b7493cYNPUGSUR+tcA@mail.gmail.com> <20260606045414.GK6095@frogsfrogsfrogs>
In-Reply-To: <20260606045414.GK6095@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 7 Jun 2026 10:51:46 +0200
X-Gm-Features: AVVi8CeX-CYWtozPdEggLEr7SF-dFvqQRU9-1yBy6T9oPM-xGLFMx0PzO09WKqo
Message-ID: <CAOQ4uxgWmXFxg1LG-J7hEW-Xs3jeEP2WP-zL23aZG-XGhRZ9KA@mail.gmail.com>
Subject: Re: [PATCH 1/4] fuse: move the passthrough-specific code back to passthrough.c
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, neal@gompa.dev, 
	bernd@bsbernd.com, joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 6:54=E2=80=AFAM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Fri, May 22, 2026 at 12:03:38PM +0200, Amir Goldstein wrote:
> > On Wed, May 20, 2026 at 12:29=E2=80=AFAM Darrick J. Wong <djwong@kernel=
.org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > In preparation for iomap, move the passthrough-specific validation co=
de
> > > back to passthrough.c and create a new Kconfig item for conditional
> > > compilation of backing.c.  In the next patch, iomap will share the
> > > backing structures.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> >
> > Please add
> >
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> >
> > and please keep in it future postings even with minor changes.
> > I realize that fuse_backing_id_remove() was changed in this version,
> > so that's fine, but I only know that because recent revision still fits=
 in
> > my ever shrinking context window..
> >
> > We discussed the fact that no one has lots of spare time for review
> > and re-review is a big production killer (in general).
> >
> > You must know that very well as a review and also that having
> > a "what has changed since last patch rev" is very useful for reviewers
> > and also very expensive for authors to maintain...
> > ...unless AI agents can help to generate per patch Changes
> > for the post --- notes?
> >
> > I assume that Agent can do that on a patch set after it was created
> > just by giving it two sets of patches?
> > For the very least, producing a "No changes since v.." should be easy
> > and useful.
> > Letting Agent go over mailbox and verifying that all RVBs have been
> > applied is also trivial.
> > I realize that patchworks and b4 review can help with these tasks
> > but they are more tuned for maintainers and less for authors
> > (I think).
> >
> > Obviously, I could do that with an agent on my side, but that is not
> > a good use of resources and not a good model to put this burden
> > on all the reviewers.
> >
> > Worth a try IMO.
>
> How about a range diff? e.g.
>
> https://lore.kernel.org/linux-fsdevel/177758364789.1315233.15610945404741=
826500.stg-ugh@frogsfrogsfrogs/
>
> I think I'd rather spit those out than either (a) try to remember all
> the changes (esp. minor ones) that I slipped in between two patchbombs,
> or (b) go all agenthappy.

Maybe I don't know.
At the very least, range diff would provide the annotation
"no change since last version", which I find useful.

My point was that the load of reviews is very high
so if something can be done to reduce the load of re-review
it is going to be a win.

Anyway, as long as my RVB is preserved across revisions
I am good.

Thanks,
Amir.
