Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E2E3A1A22
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 21:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326401; cv=pass; b=dC45bm4HJ6Tp5D18GefIXgCy/TlYXDL0XT2bsIRjdcGivZcl84Nsnfci/b4WalZ4vokif2gkKa4MNlbb1ZCCXjwpue5MQ0oNf9+EMKTQhaNetDVMooZcbl6NV7huih5FUeBY7JzOKWaBnIb1CVSyLtPea7++rwYwWIMUP8kg61g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326401; c=relaxed/simple;
	bh=zhqPdLsliCeh4Cq3JMCBkHOX7txM8MBXqZidergodxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bftDs1THjW4irWIUbaklCPlmzK5+S31Q3zaQG4bYYbZQ4NNuaQF8tr8zTH1wPa9xM+rD6nBm0xgs8z31Di+/zFHZr5Tk5egWYm7GI9+0i9190SX8WXNWcnoFTOzkDAGf0lAF+/mymllqRorizAH2ugsrYo2qpS1uS3u5dRkHQ1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N8D/H87m; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N8D/H87m"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35fc2b18363so11381422a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 14:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777326399; cv=none;
        d=google.com; s=arc-20240605;
        b=NvcZmY+9S3hv/VhauKCmaBwpYsoj2Gj+lwkB6oLceRQJRMlueervnsr1MMWRTdfBrB
         HZjVHUjEe3l/B1aQahPK3fh5yjB5qfOgVZewNap+bXPokxcNcc7yTgZOAdAfROb3RTpT
         vWScL60JNfXw50Q9wDmriwiqTO3xDZWJ2qoXQJ6tWpHQlAjKY7rKRnOMw/brrWMPiHIz
         iGGx0GCPwHw3pZJThVMGYpOnyXEaG3rj+pSRB0Hwkv12M8qswP3J9W9/Ts27z1m+SrQn
         Q4ZsCz6x96d7te8OOrzUmFqURhQa4IyZDtV3L3yHfyBYzq5d3lLdpZIUB8hKXRaaJaPy
         3MTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B3Kg5U1Zkn3lza4GlbBGatxlj+BMyoEuS2pqFmvkL9A=;
        fh=GwvKFj5Uy6XtdRzontyo+xl2C5/Zl5IhrLu6AMxyUA8=;
        b=Cp2PjwdgF+8CGbJ0HWmXE7KCCGdKgVraptAD2KS638xMrKZDjrsB661pTcuhy7eLjm
         iOEO8fso1KgNUWW1YlkNVfZtpIL8kd7N1n07JYiUTeE5xKXp87ck74sFCpX8uWGNQq2L
         +T+t2geLkOMS0R6QOG3VnmT5iokj3kBbeW/O/pZF2QzKjfi1h/4z2MLO7dO1VUxxgCp4
         M7nvq4MZxJaVneTdJiF8HfJUGc5HqBisO1ePgGd4xZydLilb7Scx7cUaVPhrjOQKDYvH
         hhLtHzMVXGZb8FjfpRajhm7tEAvP3i2isNoC4O/+yZHC0URggL8pxCIf1evoZBKatX1B
         Zo7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777326399; x=1777931199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3Kg5U1Zkn3lza4GlbBGatxlj+BMyoEuS2pqFmvkL9A=;
        b=N8D/H87mGkun8WKza0FtKRjUUlcMkalb5lk+brGk6cke3VqrOBpaCtXhCLKsbiy+6k
         SCO2zzIkbWoL9iBg+Riqrey6pLie0x7lJnbbmMhSk3J0AtYP+k4E+6x5TXH2OhOeOYB7
         2sWhidaomi9JL0nRNyEc1OxTuUD8VFW78irKFtOK2g1ZodCzJZowvKYzj8yqe8TOI9JZ
         eJodTm5z2Zgok/0pjl50UGTt9LfcAt1tccMCfVFpLJ9ly/nE7ZOj5iwcAeWE6KokMlft
         U40i0vgcqc6ra6gTg1gtkVnkfu/vD9KBNZnT3cOiHXWHcP06WDvwaM2mIEi+ASdCCIPv
         ckyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326399; x=1777931199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B3Kg5U1Zkn3lza4GlbBGatxlj+BMyoEuS2pqFmvkL9A=;
        b=lhWMpxT20jkFQxXDiH3ovcV/K7wX01xDcaedvq4EkCeER7ogP6x2WnrPHX6UzI22SH
         e5TbPK36UmhRyaDBoF7tQytknf3lNwbFo1LCXLssKPXMt+NiZQw8qTzpBvIdPMnLN5We
         6iltpaACi50MscpwEPAKFWsCkoA286EhlY3UC0/xzwpK9BC5eJHl8yRycYu6+mPpiMwq
         UuhgCbDKEJQwpSfAV/Fq8F8BVhNH8QSe96ClCEX7M7LwfzjUVHOHII5OeDgdawEsp9x6
         Pqc+yVTUCAIDlMUa15HGJ1oB/lLelN4XlNZaNp9YWq24P3LZyHLnZjrggt0ZYIPnolZx
         iudQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wtAgxuyb+koKjiOO4e12jqcUnLTzI6Drvxrs4PZPehig8ydGZO5pNdqhtcFsEgDkP67EyuzxvU1yLsWVw@vger.kernel.org
X-Gm-Message-State: AOJu0YwUpwPOGBGVBgrjiJTCp8D+uhEPp/rmg+J+ESPy6mpu9sfTVB3c
	f5woxEZ37s8FxmDAxH+jeim/qVZ0e138NGGDvxzIHL9m901VSTkvCIDA7PEuIMCZdx8M+gJ6O3s
	fYw++cBNDiCXViMyGy4rY3WTg56+g73i/hOI5wmJx
X-Gm-Gg: AeBDievuhGClncCXkL9jjIEx/x97TK5EXJ1fEKgHXX5gUd/mpCxqDvLKT1H5+NO984H
	lD2AqIW4KzyZLvl9a6y9XoUqsp7N2IkGbkwfnTvmIRg4kFB8cW9L2e04eow8xtJNzPC66Kwmal/
	rSAwe5ixZUiJYXQg7A28inXLlFzyXjSB9FA1Cgq47uJtthmVHv4S5p+8hxW5Xsza/SOzr6oMvak
	eHBwcgj0CCrF1+zJp6qTXNIcmpQJytZ56yIKQkxpwp9DP6yeY8S22QgEbkMsKp3CAZSPvacTPfU
	hvrE9bdfturM2cL7eCqvOZ2RppdU
X-Received: by 2002:a17:90b:3510:b0:35f:b5df:463 with SMTP id
 98e67ed59e1d1-364920a5111mr316885a91.14.1777326399595; Mon, 27 Apr 2026
 14:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312100444.2609563-1-mic@digikod.net> <20260312100444.2609563-2-mic@digikod.net>
 <CAHC9VhT4Cd-FMYhaKgt6Gv-Suu7YJm7YbKZ-vdMwQV7EiWDryA@mail.gmail.com>
 <20260424.ein5Aiwah6Ai@digikod.net> <CAHC9VhRcokUR0ZKzCuZnZAyaFEMd6EH93BE3OTTKHY9Mo9pVkQ@mail.gmail.com>
 <20260427-belegen-euren-997f91347820@brauner>
In-Reply-To: <20260427-belegen-euren-997f91347820@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Apr 2026 17:46:26 -0400
X-Gm-Features: AVHnY4J_aORyQwUH7L8dzaXakX9ALCnxs85Yx7un-cTrHulHFgAyL_bsxR0vkU4
Message-ID: <CAHC9VhSFc217Msagi8wenJBkuqAZ6ftNBdd_HzejkWF60wPG2A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 01/11] security: add LSM blob and hooks for namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Justin Suess <utilityemal77@gmail.com>, 
	Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 10:57=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Fri, Apr 24, 2026 at 03:28:44PM -0400, Paul Moore wrote:
> > On Fri, Apr 24, 2026 at 2:56=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Wed, Apr 22, 2026 at 08:19:59PM -0400, Paul Moore wrote:
> > > > On Thu, Mar 12, 2026 at 6:05=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > >
> > > > > From: Christian Brauner <brauner@kernel.org>
> > > > >
> > > > > All namespace types now share the same ns_common infrastructure. =
Extend
> > > > > this to include a security blob so LSMs can start managing namesp=
aces
> > > > > uniformly without having to add one-off hooks or security fields =
to
> > > > > every individual namespace type.
> > > > >
> > > > > Add a ns_security pointer to ns_common and the corresponding lbs_=
ns
> > > > > blob size to lsm_blob_sizes. Allocation and freeing hooks are cal=
led
> > > > > from the common __ns_common_init() and __ns_common_free() paths s=
o
> > > > > every namespace type gets covered in one go. All information abou=
t the
> > > > > namespace type and the appropriate casting helpers to get at the
> > > > > containing namespace are available via ns_common making it
> > > > > straightforward for LSMs to differentiate when they need to.
> > > > >
> > > > > A namespace_install hook is called from validate_ns() during setn=
s(2)
> > > > > giving LSMs a chance to enforce policy on namespace transitions.
> > > > >
> > > > > Individual namespace types can still have their own specialized s=
ecurity
> > > > > hooks when needed. This is just the common baseline that makes it=
 easy
> > > > > to track and manage namespaces from the security side without req=
uiring
> > > > > every namespace type to reinvent the wheel.
> > > > >
> > > > > Cc: G=C3=BCnther Noack <gnoack@google.com>
> > > > > Cc: Paul Moore <paul@paul-moore.com>
> > > > > Cc: Serge E. Hallyn <serge@hallyn.com>
> > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > Link: https://lore.kernel.org/r/20260216-work-security-namespace-=
v1-1-075c28758e1f@kernel.org
> > > > > ---
> > > > >  include/linux/lsm_hook_defs.h      |  3 ++
> > > > >  include/linux/lsm_hooks.h          |  1 +
> > > > >  include/linux/ns/ns_common_types.h |  3 ++
> > > > >  include/linux/security.h           | 20 ++++++++
> > > > >  kernel/nscommon.c                  | 12 +++++
> > > > >  kernel/nsproxy.c                   |  8 +++-
> > > > >  security/lsm_init.c                |  2 +
> > > > >  security/security.c                | 76 ++++++++++++++++++++++++=
++++++
> > > > >  8 files changed, 124 insertions(+), 1 deletion(-)
> >
> > ...
> >
> > > > > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> > > > > index 259c4b4f1eeb..f0b30d1907e7 100644
> > > > > --- a/kernel/nsproxy.c
> > > > > +++ b/kernel/nsproxy.c
> > > > > @@ -379,7 +379,13 @@ static int prepare_nsset(unsigned flags, str=
uct nsset *nsset)
> > > > >
> > > > >  static inline int validate_ns(struct nsset *nsset, struct ns_com=
mon *ns)
> > > > >  {
> > > > > -       return ns->ops->install(nsset, ns);
> > > > > +       int ret;
> > > > > +
> > > > > +       ret =3D ns->ops->install(nsset, ns);
> > > > > +       if (ret)
> > > > > +               return ret;
> > > > > +
> > > > > +       return security_namespace_install(nsset, ns);
> > > > >  }
> > > >
> > > > Do we also want a security_namespace_switch() called from within
> > > > switch_task_namespaces()?  Of course LSMs would not be able to fail=
 or
> > > > return an error at that point, but it seems reasonable that LSMs mi=
ght
> > > > want to update LSM state associated with the current task once the
> > > > namespaces have been changed.  This is similar to all the "_post_" =
LSM
> > > > hooks we have for various operations in the VFS and network layers.
> > >
> > > What cannot be infered from security_namespace_install()?
> >
> > We don't actually know if the namespace is attached to a process until
> > we get to switch_task_namespaces().
> >
> > Now that I'm looking at this again, why is the
> > security_namespace_install() call placed after the ns->ops->install()
> > call?  From an access control perspective we want the LSM hook before
>
> See https://lore.kernel.org/20260325-filmverleih-auffressen-e897fcf8d3f2@=
brauner
> where I requested the order to be changed.

So ... does anyone not want this moved?  It's time to speak up :)

--=20
paul-moore.com
