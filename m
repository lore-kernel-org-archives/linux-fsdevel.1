Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC813783B0
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 23:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782948791; cv=pass; b=lwASlQSF7fW9YALCaDNXSSZTQ8MANLijod6uedOjNe+rp4ByeEalu9I4O3CBa5/077L6qUoSQP2ZqIPBhzyohA93REds2gAMY/nWc9BbQmAcvz2Y8OYIMrflBq8YFH3sA5GNGPeGcN/mEYSavZQ5p0n4yfVdVF0mXyGxrbaJqHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782948791; c=relaxed/simple;
	bh=x+PfjKVNwhtTJ6HLqRsWaTMGPvbCj84f9CeR96i7c3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=om3D0Z1/e4YGtFprDDqR3tzlhDn5n4uawgfuuxe9wHgpSFsnZ2w4YRIcDUFFCXsSbZyqAGXI79url0ebsoCvIHoKjH8CH6UPNaqmktCyD8pKYzLS+AKedxpiwyNhbAcMJCAfGVHIjtEToHJIRtvJOkWivD89mVhqdQo8kI5sO0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LVyzkOIo; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LVyzkOIo"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c88973b6965so6116a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 16:33:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782948789; cv=none;
        d=google.com; s=arc-20260327;
        b=IJRm5DpzJQ4HHmS4u9DR5CzIG92FRcARrs7gBYDwqgods613R6pggSmYBi6kvMglYT
         2F8iFGo643DpaYHuXzyIluszb8tTYXnkVZ/h3SmhbA21VeV6t134l9tkrFo/OpMRb9G7
         EazjTD8M0VbypM1HctwfmxHrK/M9J87xyPwRXFS1dceE4Mjpo0sl9xnJH4Kt9D/dKjDm
         ORRA0Ct8DHMaZeFg0QwmUS4e05tho7e67eqXg3VaSgY8cQPUKXTSMM7XzraFBE0iWZFi
         YcohvO53v8I2q7Ex0aNquMlJzmHxfzv0SaWAjv0/gGKF+E60KOktRYzG18BBPNcPDmfB
         yDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6GUALnlVtkXCdajNjYciE/WDRaKf7yBrgHsvGDrElLI=;
        fh=Y/8K3/IJFaS0fhO1ryit2yd2mlGwDNmfH2MWpwTukhA=;
        b=NNnG3athyOeX9roMJqmBiWPGekqMbYGSlAVl4gW3SnYLJYxmlZWzeWUH1jUDaDvV2+
         nGl4uLBGYvfU0pZ9vmCh6hO7a9VNiPALCTZWiwny9Y1GW6YUWIPdk8O0/82N/i6apKJQ
         6/TWkr56aDpfcVodLXFi/yyF7FN+WTIhE+EV0zZY/sLgNduQg8Cr6QmAaKqXsYoDzKbd
         3TvaF2E6HieGaN6jRBkIJNj8/B72G//cojmCP28zIGC4PzDChfMI9GtmLqs3OwScQSDO
         agEzqtGQYwpGiN0Kl96wEHLi9kqAjHtLMCrvS0QLhMe/dw2YTKuLWNHkLB9MGF7Wb3lu
         5VqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782948789; x=1783553589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GUALnlVtkXCdajNjYciE/WDRaKf7yBrgHsvGDrElLI=;
        b=LVyzkOIofmFpPQyhLFmIbykN56ijwkQPqYLeaYggJMZJmzpqkusGyskDSk3vC/y0zK
         4YHcL21rhW0g7oBV7Z/6HF6kpyrxFbdj7yyjhN9lKrNreBhXLVgkyBrnR7Xof1Lws5f1
         sGjkPLnJixsgE63pJBT8zkcvoIFsSLwYcRn1rltpETGUwLlyCZTuh8yrNvtcZwpw6JEl
         vSplxbRPROADM6zqr/M+PtwZltDEFBaH8Ig4I+S5zZSPMxVhycg5jkBMhPkCqGj5H0AL
         ODvqPWOn3sEsJPWW6qI6XH1pSBhj0kE+AtJJAHu6YRFRi0XKrpTOuc8+AjTKiVNanSFm
         8Abg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782948789; x=1783553589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6GUALnlVtkXCdajNjYciE/WDRaKf7yBrgHsvGDrElLI=;
        b=kT7FeFwDh6EbjfTeiUSanCHB6gmm1jzqYDoaUcfWJF6UAZp2fnWVozuK8VW7mnoFN1
         kixFsbC+O1uLEhslLnGYe9e1VtN26QpQSQ5pFDQZTj9Fg2CJk+87nGHPy2Gr5skktd+2
         olfqWwfnVy/JfFB9eo30tMaJAxjnWZYPWpn8q0v/ug/kSjDmYKAJOl3Y196biBjnGssI
         JFGYiCWFNbrmlso/6lIrHD6rOYdo4ao1imAoZvVvhJJonkIrzMJWZecxWBmbineeFjIM
         JKhD/HU9kBzSAYkn0Ex0i5P+p9qgbBtWjbv5fAtrHJ2/WAONVKq3loevylxz04ASm9xV
         7fpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IKK7w5Igfx+XMYtt/sbUY1SI7gGZBKfXSJ1k/xbSgxwZrJP6EbVDHTI4/+M7Qs/tgWJIGnNBXi2izbXtK@vger.kernel.org
X-Gm-Message-State: AOJu0YxK3Y+A0mST+8bfxvdA+5hc9Kc//rC8TBn2ZxfQAU/yqsjsCw+1
	RAO9ZYxlgrcLSbt61vlnjHJKBELO5a4Qr7DGzD/omjXc0fyFfXF17fSjv7skVmgjLPAOIR5oeUE
	RIH1oj4hM+We06jO2LPiPvahNbb6TbT/9jbqCoXKn
X-Gm-Gg: AfdE7cnXdm6vkK0V5K161DP870Cck+bWW5boRBJBIEtiB0LrjukzbgECzQEb3JdF0Gl
	jHsWbgOFWOx4tHKDYpmQi3FU0if3TbYn+k/KK1DasJ7j3PYww4TMyE4tsdH6i+SzH8TRApI8ONh
	0NPPB5osArFBpsKJX9dp0YDznpirSbZ1sIdMraP5pLRvmPDcxyUCG8PpXdWUkBRR/aOXi/ifElh
	O8LPGtH3XBRoqeOQu706ENRhWn0wo9LI2wvS9hHa4cYfyKMSujNGNjKKgmohvJPNWdrn/Vv
X-Received: by 2002:a05:6a21:e082:b0:3bf:78a1:c140 with SMTP id
 adf61e73a8af0-3bfec8575bemr3706763637.7.1782948789212; Wed, 01 Jul 2026
 16:33:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-7-utilityemal77@gmail.com>
 <20260701.ze4eph1eKo7a@digikod.net> <CAHC9VhRfqSoM89WC6TdQHapUVQe8a18rW2c-F7+tu6EjM9EdCA@mail.gmail.com>
 <akUH13qbsEnJLgQu@zenbox> <CAHC9VhSjRcMr9+5dMkep_TPKduYdob-bZ73FLfXd_o2xiWwOSg@mail.gmail.com>
 <20260701.jei4Paej3zen@digikod.net> <CAHC9VhRzZVUz8icZ2RD9OVvscJdZW3ivPERJLEkNi5poBeguxw@mail.gmail.com>
 <20260701.oTeikequi3ee@digikod.net> <akVvkA3kmlv_POsF@zenbox>
 <CAHC9VhTQtHPFGqu58EaFqMobV3LCcTsdzYfxy568P8mU769TMg@mail.gmail.com> <20260701.aeghohNoe3ek@digikod.net>
In-Reply-To: <20260701.aeghohNoe3ek@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 19:32:57 -0400
X-Gm-Features: AVVi8CeyMVw8_mgL868rsLToGDrdGrpq5mae6FW27hWQBDl1h-WMxAl-Hsaj0yE
Message-ID: <CAHC9VhSYJPdn3Y+C1s8VExQ0DhV9Kg-NZiWhhOA657JeHDnzjQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Justin Suess <utilityemal77@gmail.com>, ast@kernel.org, daniel@iogearbox.net, 
	kpsingh@kernel.org, john.fastabend@gmail.com, andrii@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	gnoack@google.com, jack@suse.cz, jmorris@namei.org, serge@hallyn.com, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	eddyz87@gmail.com, sdf@fomichev.me, skhan@linuxfoundation.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 5:28=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Wed, Jul 01, 2026 at 04:02:36PM -0400, Paul Moore wrote:
> > On Wed, Jul 1, 2026 at 3:55=E2=80=AFPM Justin Suess <utilityemal77@gmai=
l.com> wrote:
> > > On Wed, Jul 01, 2026 at 09:49:07PM +0200, Micka=C3=ABl Sala=C3=BCn wr=
ote:
> > > > On Wed, Jul 01, 2026 at 02:38:08PM -0400, Paul Moore wrote:
> > > > > On Wed, Jul 1, 2026 at 2:34=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <=
mic@digikod.net> wrote:
> > > > > > On Wed, Jul 01, 2026 at 09:28:22AM -0400, Paul Moore wrote:
> > > > > > > On Wed, Jul 1, 2026 at 8:52=E2=80=AFAM Justin Suess <utilitye=
mal77@gmail.com> wrote:
> > > > > > > > On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> > > > > > > > > On Wed, Jul 1, 2026 at 6:59=E2=80=AFAM Micka=C3=ABl Sala=
=C3=BCn <mic@digikod.net> wrote:
> > > > > > > > > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess =
wrote:
> > > > > > > > > > > Create 2 kfuncs exposing control over Landlock functi=
onality to BPF
> > > > > > > > > > > callers. Export an opaque struct bpf_landlock_ruleset=
 preventing callers
> > > > > > > > > > > from accessing unstable internal Landlock fields.
> > > > > > > > >
> > > > > > > > > Generally speaking we don't want to provide APIs, either =
in-kernel or
> > > > > > > > > at the userspace/kernel boundary, that are specific to a =
single LSM,
> > > > > > > > > see the LSM syscalls or the security_current_getlsmprop_s=
ubj()
> > > > > > > > > function as examples.
> > > > > >
> > > > > > This patch series is not about the LSM framework, only about La=
ndlock
> > > > > > and its specific model and use case.  Landlock using some of th=
e LSM API
> > > > > > is not relevant here.
> > > > >
> > > > > Based on a quick look the patchset enables BPF programs to call
> > > > > directly into Landlock.  For the same reason we discourage other =
parts
> > > > > of the kernel to call directly into individual LSMs, we want to
> > > > > discourage BPF programs from calling directly into individual LSM=
s.
> > > >
> > > > We're OK for a dedicated kfunc to call directly into Landlock (with=
 a
> > > > tailored interface).  Landlock is designed around its syscall inter=
faces
> > > > (well documented, tailored, tested), and this would be a new user o=
f
> > > > almost the same UAPI.
> > >
> > > Paul, Micka=C3=ABl,
> > >
> > > I think there's a cleaner way to resolve this.
> > >
> > > First, walking back my earlier email: I was wrong saying that we need=
 to call
> > > into security/security.c to check whether Landlock is enabled. Landlo=
ck's
> > > init only runs when it's in the active lsm=3D list, so I can just tes=
t
> > > landlock_initialized directly. There's no per-invocation reason to ro=
ute
> > > through the LSM framework for that.
> >
> > The landlock_initialized flag is not really a LSM framework API, that
> > is still Landlock specific which is something we try hard to avoid.
> >
> > > Rather than routing each kfunc *invocation* through a security/securi=
ty.c
> > > wrapper, I think the right place for the framework to be involved is
> > > *registration*: have the LSM framework own registration of an LSM's
> > > kfunc sets, e.g.
> > >
> > >     int security_register_lsm_kfunc_set(u64 lsm_id, enum bpf_prog_typ=
e type,
> > >                                         const struct btf_kfunc_id_set=
 *kset);
> >
> > That implies a set of LSM kfunc APIs which Alexei has been deadset
> > against (see other ongoing threads).
> >
> > > Each LSM calls this once to register its sets. Because registration g=
oes
> > > through the framework, the framework gets to decide whether to actual=
ly
> > > register them so you could, for example, run an LSM while explicitly
> > > opting its BPF kfuncs out. (something that should be done at the LSM
> > > framework level).
> >
> > I'm not opposed to the LSM supporting a set of kfuncs, see my comments
> > in other threads, but we should treat these kfuncs just as we treat
> > other LSM hooks today because that is what they are: LSM hooks that
> > happened to be called from within a BPF program.
>
> What an LSM hook is or should be is the crux of the misunderstanding.  I
> explained my point of view here:
> https://lore.kernel.org/all/20260701.jei4Paej3zen@digikod.net/
>
>   LSM hooks make sense because they are designed for a specific subsystem
>   (the caller) and their goal is to return an access decision or to keep
>   up-to-date related states, which means that their API is designed for
>   the caller, with its own types and specificities, not the other way
>   around.  This case is different, the kfunc is strongly typed and tied t=
o
>   the Landlock (subsystem) semantic with an API defined by and for
>   Landlock.  I don't think a multiplexer would be a good idea.
>
> I'd try to explain better: in a nutshell, an LSM hook exposes a subset
> of the context of the caller, for any access control system to be able
> to make a decision.

That is true for some LSM hooks, but not all of them.  LSM hooks are
really just another name for the functions that compose parts of the
LSM framework API; it isn't always strictly about access control in
the kernel.  We leverage the "hooks" for the LSM syscalls, we've
discussed "hooks" for implementing a common LSM namespace API, and
there have also been early efforts at LSM policy loading via "hooks".

> It makes sense to have such dispatcher because the
> callees must adapt to the caller's context, and then the API is tailored
> to the caller, so even with several consumers, the API would ultimately
> be the same.  In the case of this kfunc, the callee is one specific
> subsystem that happens to be Landlock.  The caller asks a specific
> subsystem to do something specific to this subsystem, not to ask all
> potential access control systems to give a generic verdict to grant an
> access or not.

> For this kfunc, the caller passes arguments which are
> specific to the callee subsystem (e.g. a Landlock ruleset), not the
> other way around.  Every LSM has its own configuration, and it doesn't
> make sense to somehow wrap these configurations with a common layer/API.

Once again, there have already been discussions about trying to build
a common API for that.  I'd rather have us pick that up for an
in-kernel/kfunc users than treat Landlock as an exception.  We're
trying to get rid of the exceptions in the LSM space.

> Why not start with something simple that fits a use case now?  If and
> when another LSM will need a kfunc, then we'll have something concrete
> to talk about.

I think Casey's reply answers that question rather well.

--=20
paul-moore.com
