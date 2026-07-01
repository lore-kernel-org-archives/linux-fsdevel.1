Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAD939C631
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782936170; cv=pass; b=Bsi/vNbZvzPALYfbtcNXSQvesEmxmCERljn7NLCgFZ1saU41hrQIEDm54tjRKzFe0ccMiOFI5cNdvxwwnf57Ye91B7ma6tbkp24rCWYP0uRDynnFaBcTD9/kkZlronStbOFcQtWTS6ODmcR1GVJNOGN/ZlotSOtawjJclcE225A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782936170; c=relaxed/simple;
	bh=iVfuNUZDpw/Gom5uOVQvX6ChqXT9RekAmG+OEs7xoRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YMGDUYOEUnN0VqdHtnnN1U5gjESWBPM78zhen5rFOTaOUSgvslEwcHhPSKp5nn+I84LNUdGfhjsV4ONy10QBGouL0TNBjR/qzNCCqKkYfU/8CyvphH3yOSQJVWaeV6zHYchPT55iT3XF6NAxFCD+z9dmA32OS4mAhEZLlpJWRro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TKyRUaxX; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TKyRUaxX"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c9b1edf2bdso8222955ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 13:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782936168; cv=none;
        d=google.com; s=arc-20260327;
        b=c9WWFYqaJ8ZDRK+QIBure9L1Qt6RO6/LpqTxQm79sYap7+C8akrObF9Nf44Cr/olpb
         zdRoiBFCR+yfawVtW65DYBzD2z3gJkSKbtcR/iq9i1JB7WDiQv+e3QRa1GcQoFpoFcmw
         fsY+/pK+Rp0ITmcTRNTinZmRtZlBTg4EiWUZHyWQcbLHHsCZq9HBeUQubZB6Y7G+rif6
         9UwUdQ7zFurxJpOB/RQ86gcl3Kl9p2xSm+SHmdST5MI8mb4BMM8yGj3oJLrsOwrh1RLP
         JkqPBe9SCmsROvLb2M7J/tj4TNkshrO0+QbGKKKK4tfxzk5ou+QoDJ3H/qs3vKBrVEwm
         tqIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SbFwNjOhUtQGqyifkvdIPmu0/Gl8BSc/ExNswwVBw5U=;
        fh=pCkUDFFrLtfYLxohsYPtj/VsGLJ9zd8Nb7Xyg2J248w=;
        b=HCbbpj10IoLzMTiMyxB7lgQQG52mksRt2R35JO+Vm2uROV0wu2W19z24y95hVI0pic
         3MgF8W3SCIoqmdvnGUubPW/Z0lwuVJ6t/tIkFHzVx/2lFXeYlu90NSe83MESFeSInPFD
         O4KQjGI3sBgXDOl4EpT3zV4CfkpP8N4uhG6XThz+O6uuDvtFnlDbBuhXb2lqqDqGGhK8
         8QSl4uZ0uW1zpfzKpAN9WaEHGsTnm3Ni3Uj3YSU/B0b4LmP7LB1YNkrJiSTsvmT/Mf9C
         X8IHO1ELbB/DwBX+GnSPttrJsl3Q5qRioz+nMBpzL0reyF7nyfHDYh5aGEOCPPDUcKzy
         TQ0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782936168; x=1783540968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbFwNjOhUtQGqyifkvdIPmu0/Gl8BSc/ExNswwVBw5U=;
        b=TKyRUaxXoeNxg6Avs0Fx7V6UYAYcR+7CGd6XAfTq3C9dUpuDZ2RUUl7We1M4tO0OaP
         /zKZBgFuOOQoedvDaM7ViqZpijeoi5X0OwnYrWjXfxZeHZYEtovi9XcAuEmHKly4nxjZ
         rdFXfFdZN2enuO6coyFzc5lvbSLcq3Swfl2zvIizXb5zTBWXMQ1yI0nSfvAysKIi7M+u
         e08777MfNMhTw680Fk9PNQL9yx6+mqpz/9WJMt/eK+w9ENAYQw9U66IUZt9OaKjNQDyL
         lomawKfn/ue/jdvLbSiQ8zzBe2A11Osjon6Ih+8Vt/eYfx7IEs8m4bp7Ps6OEsgBhQ0i
         zHwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782936168; x=1783540968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SbFwNjOhUtQGqyifkvdIPmu0/Gl8BSc/ExNswwVBw5U=;
        b=oKgnOuBS/Bs4isruBmD0mLtkkAaliH9zrDgyIrhHQ5Z2ZFFPV1rEmiOSALZe6JC1mj
         MmC6NzAZNsEpMTDsCoFln6wpLGHQ4ezX9WEZcjdqsocgy1PCLpTOBohpxcX+PVY6U+QZ
         2B/BlUupos2UPRlsAnuRj1DG54dC6e7YWfG/SFwjLE7wwI5aMGouhwfZKSxh+Iqpp5TF
         wXw+IG38Y67BXU0jR2JQXMR/cmSntR6q5jjg+iY/f3TmGMcOuzFWxjHeqkSM0qFrOamk
         bhGA+ufBDuDvcC0PUieJicS493ijRfaL4w73stqQeiWm20yfbmsssE+iXGDA4Tjza4Op
         BO+Q==
X-Forwarded-Encrypted: i=1; AHgh+RpvjwME2nf7huarfifhNRWq/NYyawnillWWJjEc6wqAoDg24/HxwZrqxmJgx1OFBK765yv3BQryXwcONHL+@vger.kernel.org
X-Gm-Message-State: AOJu0YwSYHSW8SE0WWiaS2PsVYwU1zPVGLCBxKJPbYAJR+miP7IMrHlU
	/DAQxPq0K3dBVFn7gJXOmsGrApfUnnszFg1dtD+k/rh9me7Ant15allTxSNtef6LtXyfZ3JdA7e
	RIqrEaMy9n4uqnMatJ7vGVHN43Aic80FsdyqggQZH
X-Gm-Gg: AfdE7ckh0cCdYl08sD9C+SlS4SvyKc4ElSuUIxTlHLxjdR59bZEz6NsQ20ZNvN7Kox+
	uxsQRufeHFFSuTStISufawKjJY8G8JCMsXm79rqExWW/SP49jUwbFGBvqirfYKEWQTONAYPwaUD
	vJa8PA8sKXj9tt5ztuxNHPOIxaW/QR9X6CrNBqFTNFNsINM9GNWr2M+BKrmTE82U5FWCcl1NSZG
	bLFtFgZWzmIb/AC9rBKcgAM0mfDWLxJpiUV5P+0EMrsUdxzYnJYdgJkfsmmxPXk0I00JZnT
X-Received: by 2002:a17:902:e743:b0:2ca:304:f93e with SMTP id
 d9443c01a7336-2ca7e7579dbmr35871365ad.22.1782936167815; Wed, 01 Jul 2026
 13:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-7-utilityemal77@gmail.com> <20260701.ze4eph1eKo7a@digikod.net>
 <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox> <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
 <20260701.jei4Paej3zen@digikod.net> <CAHC9VhRzZVUz8icZ2RD9OVvscJdZW3ivPERJLEkNi5poBeguxw@mail.gmail.com>
 <20260701.oTeikequi3ee@digikod.net> <akVvkA3kmlv_POsF@zenbox>
In-Reply-To: <akVvkA3kmlv_POsF@zenbox>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 16:02:36 -0400
X-Gm-Features: AVVi8Cdkaysddhch2qqzWj5e0tZs2D9PIXTSkNjNLTTiuJP0QwrJjf46eYSL4uc
Message-ID: <CAHC9VhTQtHPFGqu58EaFqMobV3LCcTsdzYfxy568P8mU769TMg@mail.gmail.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
To: Justin Suess <utilityemal77@gmail.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, ast@kernel.org, 
	daniel@iogearbox.net, kpsingh@kernel.org, john.fastabend@gmail.com, 
	andrii@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	kees@kernel.org, gnoack@google.com, jack@suse.cz, jmorris@namei.org, 
	serge@hallyn.com, song@kernel.org, yonghong.song@linux.dev, 
	martin.lau@linux.dev, m@maowtm.org, eddyz87@gmail.com, sdf@fomichev.me, 
	skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 3:55=E2=80=AFPM Justin Suess <utilityemal77@gmail.co=
m> wrote:
> On Wed, Jul 01, 2026 at 09:49:07PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Wed, Jul 01, 2026 at 02:38:08PM -0400, Paul Moore wrote:
> > > On Wed, Jul 1, 2026 at 2:34=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@=
digikod.net> wrote:
> > > > On Wed, Jul 01, 2026 at 09:28:22AM -0400, Paul Moore wrote:
> > > > > On Wed, Jul 1, 2026 at 8:52=E2=80=AFAM Justin Suess <utilityemal7=
7@gmail.com> wrote:
> > > > > > On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> > > > > > > On Wed, Jul 1, 2026 at 6:59=E2=80=AFAM Micka=C3=ABl Sala=C3=
=BCn <mic@digikod.net> wrote:
> > > > > > > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrot=
e:
> > > > > > > > > Create 2 kfuncs exposing control over Landlock functional=
ity to BPF
> > > > > > > > > callers. Export an opaque struct bpf_landlock_ruleset pre=
venting callers
> > > > > > > > > from accessing unstable internal Landlock fields.
> > > > > > >
> > > > > > > Generally speaking we don't want to provide APIs, either in-k=
ernel or
> > > > > > > at the userspace/kernel boundary, that are specific to a sing=
le LSM,
> > > > > > > see the LSM syscalls or the security_current_getlsmprop_subj(=
)
> > > > > > > function as examples.
> > > >
> > > > This patch series is not about the LSM framework, only about Landlo=
ck
> > > > and its specific model and use case.  Landlock using some of the LS=
M API
> > > > is not relevant here.
> > >
> > > Based on a quick look the patchset enables BPF programs to call
> > > directly into Landlock.  For the same reason we discourage other part=
s
> > > of the kernel to call directly into individual LSMs, we want to
> > > discourage BPF programs from calling directly into individual LSMs.
> >
> > We're OK for a dedicated kfunc to call directly into Landlock (with a
> > tailored interface).  Landlock is designed around its syscall interface=
s
> > (well documented, tailored, tested), and this would be a new user of
> > almost the same UAPI.
>
> Paul, Micka=C3=ABl,
>
> I think there's a cleaner way to resolve this.
>
> First, walking back my earlier email: I was wrong saying that we need to =
call
> into security/security.c to check whether Landlock is enabled. Landlock's
> init only runs when it's in the active lsm=3D list, so I can just test
> landlock_initialized directly. There's no per-invocation reason to route
> through the LSM framework for that.

The landlock_initialized flag is not really a LSM framework API, that
is still Landlock specific which is something we try hard to avoid.

> Rather than routing each kfunc *invocation* through a security/security.c
> wrapper, I think the right place for the framework to be involved is
> *registration*: have the LSM framework own registration of an LSM's
> kfunc sets, e.g.
>
>     int security_register_lsm_kfunc_set(u64 lsm_id, enum bpf_prog_type ty=
pe,
>                                         const struct btf_kfunc_id_set *ks=
et);

That implies a set of LSM kfunc APIs which Alexei has been deadset
against (see other ongoing threads).

> Each LSM calls this once to register its sets. Because registration goes
> through the framework, the framework gets to decide whether to actually
> register them so you could, for example, run an LSM while explicitly
> opting its BPF kfuncs out. (something that should be done at the LSM
> framework level).

I'm not opposed to the LSM supporting a set of kfuncs, see my comments
in other threads, but we should treat these kfuncs just as we treat
other LSM hooks today because that is what they are: LSM hooks that
happened to be called from within a BPF program.

--=20
paul-moore.com
