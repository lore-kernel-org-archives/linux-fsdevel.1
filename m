Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB6B2472AF
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602253; cv=pass; b=Mz7gr2vCfZdoj1y9v3owSohISJN1j6J2hWJAKWPsM23ZPU/W0/+iFjyzYOhW4xGBI9RMERo41TwNdbGQjL5/gmTwLd9IKEmucOK4npWFF/666mMzGiSjtDXRoSx4XlbiMbpTozaVwlmbUzxmu79ap7rEtrzLPQPBpgYtTodpu5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602253; c=relaxed/simple;
	bh=k2/f6UIwAG7NHkU2DktDLP+xMov7JPi3pU0ljjUVvtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=StUb/XrBG5GCINehww4gmtXJSU9bZgE96uHi8a3CyGco7QJR6Gn10YLGe9EC0KGqSJWLVjWleajIFd3v0XjUyo4VdMlKhQevVz4CXwcOna4mt9vooZ6Ntsy21Lr9x3uDbZ0rhtJrW8Vnd81z62Xefl+KpZ+xnSUtDIrFsxOMTrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EyVTBtYx; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EyVTBtYx"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cab973140bso22737935ad.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2026 06:04:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783602251; cv=none;
        d=google.com; s=arc-20260327;
        b=IiBIdopsUTOqVOeYiLKWAo6OZtezF5iVW668vlkl4qfzhx/t05zi9T/BcN5sFMnNWz
         NFEllz2bNyXQECapXQFQJi9xoRAlQ4j1iPKcyh9emNFrsFgFuTXO3vydUGgcLGOa5Xu8
         B6HmrT2kEg/2NV2H1vbvRjiWFfz5kr2IjVS7fGFD5pCs5CORLKTROXlDkiPv1ne0Fr2Z
         AobhpnFkpUygxyPmMKc42qZEYTTCrEB3/d0p3xM4QuqWHY5JB8nE1JSeM/tMdkefs7M4
         XAnP65+a8IJwMn3usr+TP6ULMIq3tlFi9fJp4TWFDus797ssm8eP4+wdE+x238XtXa3O
         1zEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7zIvFmIDYE6W4LWpeVv0pxPnUShx5Qma8ITAgool7ZA=;
        fh=uVaocvh2WVBio8JmlJMXKuoSeEcu2LyaqkvFr3zTc6E=;
        b=KH0QRWcj7ug8L8kl2FjsqnJ2AAu0Bv1RNXsfWr+L0J21ARwUjO0uhxGaYyq3HwRhtY
         UDlJ/3/Tl5BAc4uXFKTdgx7mAb8BwSOI6LEvU8UkDJ6s6d6bSsTPBf4+Hc/5kbux2t2l
         vj5b76u4aRjiIxez0hWEGmmdyWBUOWmxoLhDSll+4NJyzdI5jXlaJcQiEAyBDXAhxOCK
         PR2GTVLXhbz0LwmvvccKICx3fbNM8xle2ZOr32OyzXCD/+2HliWwFFkO7oR3J6BPfjV6
         UElvSFe2YxGj/aU8QbG65eJ7rdY0wAxYbG+N8S1e99kDcRR4qjg91yvY67M1/qtyR0OO
         uJzA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783602251; x=1784207051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7zIvFmIDYE6W4LWpeVv0pxPnUShx5Qma8ITAgool7ZA=;
        b=EyVTBtYxHImOEElTiFt3XS8TAGbTJmYKMsvtJqK519eVtxGdGeVFURng18+N0qKmZY
         XI05BTM7NP0skmrQCSfnHrgxobUF57n50tN38/gmXBZMZQPLEINTuu7jyIK2FTtl2t3+
         UipGNqDkoyEV0XPWlX8ak5Mwl/JkSkMsmrWRenQmr4RuIcTUJ9iKOWBTrMXLtREEiq4z
         jeAOaVEGQLQW1uHqyb8ZFI4+Ov3f6JlfOU1hH/tq0OHM5yvO3W36HlZe39mE5pzLIxYn
         qNbkGJa0oCHUdZpmIo6Mk2wDOc32LmUcVtPYzickyjr1rks4dPSgyuOBA9KRH7dnMA4B
         FBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783602251; x=1784207051;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7zIvFmIDYE6W4LWpeVv0pxPnUShx5Qma8ITAgool7ZA=;
        b=GGZpwSQWVFRKCVnSqxO3xrNKvOcu4fcM5xUHcfNfpIrGf6i+ZAJb6g9HkcSeRus/AO
         0LhnhzA97Jl+4hw+Pp4LzulGEbJ6vcP0iyeDm+l8/FC8sROmvyawGx51DRlcMd/Eb1PR
         R60fzhswcaFrV5wcqZ93tK3alEcA3ANTJmrMBCsTj3V4RvLFYzU2rhXrEf/syS9yUn1V
         0RcjlXrlN5xcwJTGuAmCDcbtNkr0lx7/qf/wUQMj9/g+ivCZ8IU/R6dTltoaqNWEfffA
         ZhExMIyoQhcI7WW9wYrg6uP7ep2j5dgcZ6EqWXScpftyMn+7/puA0QhLB1HxDjHzzXg1
         lmOQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro78u/CtC8JHoMz86+yzkH4YZZP0jS1a7EY3rdUofURixlDnoOpGrmNv07VHSoS8tpZYTaqOn7iflDD6uPE@vger.kernel.org
X-Gm-Message-State: AOJu0YxfOgLErL7eAwUVdDk7B3zMZc7EZHiLdB8f45QeYG/7r7aQYsr5
	S3YKNhQvaGs+7MyOGwoNRp1PEK9TPCQcDSX7HJ7LdAIlLcPUyKdXx0uqV5ziiWBXIWh4U//HZjP
	CDt63Rlzun07CF7YKLn1+RYlstKlG7cX0YuoFflTl
X-Gm-Gg: AfdE7ckz203KAL0bZGESmPpojrxgKttFodlf+UqhBMo0Hd12AMzOHu06T14mLd2SA7E
	bSuFFBuLvrKcdVJxPUGc0DU5+f31Fc2HfvHlvqf95D9Nl6ovCMvT+mXWTaviiOBV+vuHfXivJJU
	BHBKjGhMtEA1qmDkCgcJZY6skn5ztmLkw1wnniYAF6uY0qwzLnS4ediC8etefqIYRy8RUf5/fUG
	UU9bP+pT0uMwU0mQzGQNYBVIadYiheuQN0RLKErNjGAn1daHtpaZ92SIvkUtVsJbJnYc2vW
X-Received: by 2002:a17:903:2ac4:b0:2c6:90ec:f601 with SMTP id
 d9443c01a7336-2ccea36a13bmr75441305ad.8.1783602251063; Thu, 09 Jul 2026
 06:04:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3d4fe99cd1665a1be0b36636aeeaf4ab@paul-moore.com> <20260709.kaemaiTia6Li@digikod.net>
In-Reply-To: <20260709.kaemaiTia6Li@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 Jul 2026 09:03:58 -0400
X-Gm-Features: AVVi8CdnZei5xXRKKtGuYRW9Q1XI6Otbura1DuRw3rfdDThUQwQ7WOp0MyzhV0s
Message-ID: <CAHC9VhSVQ0MLwU=C90FmohAThwaQj-mfB7L03fvkB5A0-J2jCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] security: add LSM blob and hooks for namespaces
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Daniel Durning <danieldurning.work@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Suess <utilityemal77@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 5:12=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Wed, Jul 08, 2026 at 11:22:17PM -0400, Paul Moore wrote:
> > On May 27, 2026 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=3D <m=
ic@digikod.net> wrote:
> > >
> > > All namespace types now share the same ns_common infrastructure. Exte=
nd
> > > this to include a security blob so LSMs can start managing namespaces
> > > uniformly without having to add one-off hooks or security fields to
> > > every individual namespace type.

...

> > > @@ -91,7 +103,10 @@ int __ns_common_init(struct ns_common *ns, u32 ns=
_type, const struct proc_ns_ope
> > >
> > >  void __ns_common_free(struct ns_common *ns)
> > >  {
> > > -   proc_free_inum(ns->inum);
> > > +   security_namespace_free(ns);
> > > +
> > > +   if (ns->inum > MNT_NS_INO_SPECIAL_MAX)
> > > +           proc_free_inum(ns->inum);
> >
> > The ns->inum check in the if-conditional above isn't quite the same as
> > the is_anon_ns() check it replaces in free_mnt_ns().  You touch on this
> > a bit in the changelog, but that really should be explained in the
> > commit description.
> >
> > ... or honestly, should that change be a separate patch?
>
> I think it's fine, but it's Christian's patch, so I'll let him answer
> and propose a new commit description.

I don't have a strong opinion on either approach, either a separate
patch or doc update, but one of the two needs to happen.

> > > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> > > index d9d3d5973bf5..0f1b208d8eef 100644
> > > --- a/kernel/nsproxy.c
> > > +++ b/kernel/nsproxy.c
> > > @@ -385,6 +385,12 @@ static int prepare_nsset(unsigned flags, struct =
nsset *nsset)
> > >
> > >  static inline int validate_ns(struct nsset *nsset, struct ns_common =
*ns)
> > >  {
> > > +   int ret;
> > > +
> > > +   ret =3D security_namespace_install(nsset, ns);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > >     return ns->ops->install(nsset, ns);
> > >  }
> >
> > In the previous revision to the patchset I asked about a
> > security_namespace_switch() hook as we don't know if a namespace is
> > actually attached to a process until we get to switch_task_namespaces()=
.
> > Perhaps that was answered, but I don't recall reading any mail about th=
at
> > and I'm not able to uncover any responses on lore.
>
> From the cover letter:
>
>   no security_namespace_switch() post-hook is
>   added in this series: such a hook would only serve LSMs that maintain
>   per-task state derived from the active namespace set (SELinux-style
>   state tracking), and no current LSM (including this series) needs that.
>   Landlock enforces at namespace_install() and namespace_init(), before
>   the task-to-nsproxy switch.  The hook is left for a separate LSM
>   infrastructure proposal once a concrete user emerges.
>
> This follows the guidance of adding new hooks: there must be at least
> one user.

I'm aware of the new hook guidance, I was the one who documented it :)

In the future, it's both helpful and polite to reply to the email
asking the question with your response.  Adding it to the cover letter
is fine, but to be perfectly honest, once we get past v1 of a
patchset, I don't often read the cover letter very closely unless
there is a significant change.  However, I do look back at the
previous posting to ensure all the feedback from everyone has been
either answered or incorporated into the current revision.

--=20
paul-moore.com
