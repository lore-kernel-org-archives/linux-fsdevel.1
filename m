Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793201765;
	b=gzUuitHACfk6O4XSzCzdlzSj6MDllUlgpmRAtaOV7dx2lbegvdKvl77qVYg0ZVR7tcOb
	 q7MYZ5frNfUZF5QdRyoQLcJGFmHs3TL8INkeviq+XEyQJzwfcm4sXzVO1YWGkALKQ0Z4t
	 UDQf4Nmu7reVnC4zGH8u6ZdWfHVl8LxyH+yBV9yX0q/e69A693ql5V/mO54suy+ppeoqS
	 bhLxXmYolWMNn1dDrjfWadRMPp04ZoKTUe9VdYJLVpM/lYLcpWxz6lMPzFarrhDOO3cwg
	 +gUhqMRu35BeIsE/0pS/ig5qkIyNbzZ1fxTNADqaQbKcyH4jQTz7U9LSCPCAtmZ83fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
	b=mbdq0RqqYEMrBbJht79+pxY7s1XSH9lGDL9nvuQkAeEvEe0pDoPwkl6cKjPETN4FhoXX
	 yA9lWAoPxDIHsCZgDqclfJ6aqpFLBxTN5KUokJq6gndntUZQoyyvnzAg8L0hpaTBON1gl
	 Ah7YJWZjdFl73wkid/ly8pN6xbV8yyyFfK9lsj02BiCpj8atWSouzpu4PN9kZ/VPD0Hfh
	 FzA8NPcj69YFFH7JswtBHEfCnXdVj8Vo7wQxYn+FUcv/hVx5DRujLkc5hb3RuLAmnFYRQ
	 IoTdX40SpIQMyC44n/ceww4UDpcwMwXQBUDKYiG0foV2ZEUMxvCG1zCSJT76udsbqXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iyuv9E6o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31375606A325
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 15:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31375606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iyuv9E6o
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-533202fe429so405311cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 08:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793201764; cv=none;
        d=google.com; s=arc-20260327;
        b=YufG+k58MPrkzLnBJP4W2WiwPb6ys7RXV5QYYJ0FODsyeaV9exV++PhrbTcm0rfifw
         cOcxgiT+CiZ+qBF3BxwDeGD+JzOkUL5CdgZWFM0JWI1JzJt/jD5OWBv4ajF++UTqS/jt
         x7D7+2K4+myx2vBn6ey4RMyb5bRElmCT/InIOfU8lAfBocyMnoMkwP4dBbRGLkX8VOGA
         vlN/q8T3/BoUlNMBVWPpS1XIPMw6LMn/xtaAA76d38vRwEZ+Fruj/3u3G7KjjhyTs+D6
         mQ39ip4hgcz36pV3EakYxJ8h4R3brzQr5Cs9X+OBmp43646S89uRYOWr5QwlUB6Xjo0h
         o9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        fh=AuJImP+cd7alMdznvR+8Y9SGt1Ke6Kt3KdXCF63x12g=;
        b=SPja+K6LBMxiGTTc8vc1gksQeKp7MxE3oLp7gFvAkMUsS9ehQOdaEA8TToDHdOKiRc
         DifOWAccqrB3oMf8JGR3mrTJaKjN9vWq1iLfERNvv4G4FRIQHcGrh7gLQ/IJs9BaPCMi
         9k9PS1uHYQKaJSee3QPmkrdHzehlSMA7RsX5yaGVUW097U66Ap6br+H7wWbHsxmSYpp2
         g65UAxw1VBbqz0oHPH/Uwbpp1OwXG5MiKXVaRHsySCKHANBJ8HKAWbOUN3YQlMeR49Gn
         h1UmDtLZ0RH8hwpVMMSFsCwKyOgKcd8en/ujSoH27TCASaYtOrY+1y3wdRH6QZGvf/uZ
         eHZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793201764; x=1793806564; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        b=iyuv9E6ogXiaYB/Kf9bGMjc5uDovw1VYZpmRLrRXT+kN2fxJMnJdnor+qZvLAhWzf5
         5ZpgEidLwgoDr/m7PqAQNgkvMJs1jQGMfEjgDsfaqWJdA0ll7UHpSzdRyuFyqOtcPvQf
         74bwXpyLamSNVYlWo12Hkt8sY/BkzbtDkw3FeAjFHel30AzWVvD9K5nLau0ciJ6j7CSK
         ZH4qBM8JvT2aPZPJYm3XwzxSYHZi04WkjIZrQEfBjgxa7Wsg9Sh5hAk/6QBMmPYkwRlc
         e+Xy3nhgo0JAgGmpn+QnHGzm1VxXA8IyWASy4/EEGYKtjCnWmnqGfUf8AjkGoqR/opbF
         W1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201764; x=1793806564;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IMDYK1ZjnbIiPQHcJc7SpOjyQ4Wy/ZaG15fuBEkM+6c=;
        b=0w2/QlWAfyGyeJkn8/639gD1pWphRkSM/KI7V5ErsMqNl3XFQD7/JsVsBSW9zYqvj6
         +BFXe/cOv7/dhBWRuLckJ6njNHGgOAKgj7Od4QmneO7wADN5L9un7o9Swy8XQ6HIAOR4
         lROlAMNWvba7wkaIqOOFcjUYBnXq9xfzIcriZqe4GUJfD9vupCj61cddIV7Vi8hKuYBD
         ZqqV4aQ2ijBz+ELmzRaWyp8tnR3xD7nUgku8XVddD/9JtXkxCxfDrOqnI1KMVg4KgI+y
         DvNIC+mMamGMWfgO+kH6bSWQVAL4rgP1zd+IzQbhWoyrG9WbNt/ACkgGJxfaL8PjY0Ky
         5GyQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwRsykVBsLSAlZIt9DkqkzDIBRyvb42P1dUtDrhk61w183glqnRyCu0MPiA/8808lfrIGaDiMw1sWO1aO1@vger.kernel.org
X-Gm-Message-State: AFq9FYIm2xfodsrivF8iLT754/wOA9GGAtA6eIoUsSomxk7LEym1mdFo
	uFH07EcjImTTYWNXtIJfGXHsgTv9FNbaRgl+Jw9+NDGrOomrMNGSfOgvJ/fIZXlxyxEU9+v3/Mo
	8TfxgIDvtRnKjyhW/f6Tkp+RHSVWgsMowekoBTey1
X-Gm-Gg: AYBFou00P2KJWrm5/cAs0AMwEIXzl8OgXcGdNgP7x0v2wrgRwrWWhLoG6DtJbPAg5JV
	rRT6vP3OYKcTxtFV9tWcMqI3gPhieNgjCcO80I18Dyl/pH1JkHICzd80YovcKh8ElDkGbkc2tpw
	AMLU490Ey2LwkeRrRoMBSKh6co4OIFeoeU15/CRm9ZOS9OUPLzmwo3ChYNryosGR9Jy7Nf0zkZL
	gfMh6WNtdKZBBXiruEMMC+asU0mY+m/sSZceOA6RAxIqnCa9EcovecG9Ol+/hH3FrAdbQrpfUvN
	wjK4hBicFhSNQRPsiJlMyxGIoqPU7JkjpCd21tSJH99VZTpFVp429qoNYWulHjdMiRjYYX7IYOc
	IOx88cWbTvrNYLXBujDvQ3mzqUAIPgvFIMh3hBpzsEVp/fsLd05zfR+AXVdY=
X-Received: by 2002:a05:622a:22a9:b0:536:97c0:dcd0 with SMTP id
 d75a77b69052e-53fc2aa1fa2mr21345071cf.4.1793201763129; Wed, 28 Oct 2026
 08:36:03 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027223847.652884-1-irogers@google.com> <20261027223847.652884-5-irogers@google.com>
 <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
In-Reply-To: <CAJZ5v0juvZ2ZVRBkY6FxBM=NhPt9vMA3+yRugXc5u=U1jO9AXg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Oct 2026 08:35:50 -0700
X-Gm-Features: AclHuK8Z1SdNi4k8-UQceLsnqDJD6d9aTo0cl8IQ7vlO1Fmucv2n8goL0VFX4iw
Message-ID: <CAP-5=fWVZ=7-qDRODiEQzRzhpQqribv9Morj=OoAXW_6uaW2dA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] cpufreq: governor: Initialize kobj_type release
 callback statically
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, llvm@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 4:39=E2=80=AFAM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Tue, Oct 27, 2026 at 11:39=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > Export cpufreq_dbs_data_release() and set .kobj_type.release statically
> > in the ondemand and conservative governors so their gov_attr_set
> > kobjects have a valid release callback statically initialized, matching
> > cpufreq_governor_dbs. Remove the redundant runtime assignment in
> > cpufreq_dbs_governor_init().
> >
> > This prepares for annotating struct kobj_type::release with
> > __must_init.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> Do you want stuff to be picked up by maintainers, or do you want to
> route it yourself?

Hi Rafael,

Just a quick note: I agree with Zhongqiu's feedback and the commit
message needs a fix.

Regarding merging the patches, the issue with maintainers picking up
fixes is that the series will break the clang/llvm build without them.
So the maintainers need to either merge the patches (and the series be
rebased on top of them) or merge the series as a unit. Perhaps since
the patches align, merge conflicts won't happen, so maintainers
merging and landing the series is okay. I don't have the experience to
know.

Thanks,
Ian

> > ---
> >  drivers/cpufreq/cpufreq_conservative.c | 5 ++++-
> >  drivers/cpufreq/cpufreq_governor.c     | 4 ++--
> >  drivers/cpufreq/cpufreq_governor.h     | 1 +
> >  drivers/cpufreq/cpufreq_ondemand.c     | 5 ++++-
> >  4 files changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/c=
pufreq_conservative.c
> > index 02bfd46543e9..146a2353b1a2 100644
> > --- a/drivers/cpufreq/cpufreq_conservative.c
> > +++ b/drivers/cpufreq/cpufreq_conservative.c
> > @@ -318,7 +318,10 @@ static void cs_limits(struct cpufreq_policy *polic=
y)
> >
> >  static struct dbs_governor cs_governor =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("conservative"),
> > -       .kobj_type =3D { .default_groups =3D cs_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D cs_groups,
> > +       },
> >         .gov_dbs_update =3D cs_dbs_update,
> >         .alloc =3D cs_alloc,
> >         .free =3D cs_free,
> > diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufr=
eq_governor.c
> > index f3bd3dbe7c41..f8b5aca09b6b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.c
> > +++ b/drivers/cpufreq/cpufreq_governor.c
> > @@ -419,7 +419,7 @@ static void free_policy_dbs_info(struct policy_dbs_=
info *policy_dbs,
> >         gov->free(policy_dbs);
> >  }
> >
> > -static void cpufreq_dbs_data_release(struct kobject *kobj)
> > +void cpufreq_dbs_data_release(struct kobject *kobj)
> >  {
> >         struct dbs_data *dbs_data =3D to_dbs_data(to_gov_attr_set(kobj)=
);
> >         struct dbs_governor *gov =3D dbs_data->gov;
> > @@ -427,6 +427,7 @@ static void cpufreq_dbs_data_release(struct kobject=
 *kobj)
> >         gov->exit(dbs_data);
> >         kfree(dbs_data);
> >  }
> > +EXPORT_SYMBOL_GPL(cpufreq_dbs_data_release);
> >
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
> >  {
> > @@ -488,7 +489,6 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy=
 *policy)
> >         policy->governor_data =3D policy_dbs;
> >
> >         gov->kobj_type.sysfs_ops =3D &governor_sysfs_ops;
> > -       gov->kobj_type.release =3D cpufreq_dbs_data_release;
> >         ret =3D kobject_init_and_add(&dbs_data->attr_set.kobj, &gov->ko=
bj_type,
> >                                    get_governor_parent_kobj(policy),
> >                                    "%s", gov->gov.name);
> > diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufr=
eq_governor.h
> > index 806d8fb4dff1..1026712bb79b 100644
> > --- a/drivers/cpufreq/cpufreq_governor.h
> > +++ b/drivers/cpufreq/cpufreq_governor.h
> > @@ -150,6 +150,7 @@ static inline struct dbs_governor *dbs_governor_of(=
struct cpufreq_policy *policy
> >  }
> >
> >  /* Governor callback routines */
> > +void cpufreq_dbs_data_release(struct kobject *kobj);
> >  int cpufreq_dbs_governor_init(struct cpufreq_policy *policy);
> >  void cpufreq_dbs_governor_exit(struct cpufreq_policy *policy);
> >  int cpufreq_dbs_governor_start(struct cpufreq_policy *policy);
> > diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufr=
eq_ondemand.c
> > index 9942dbb38dae..7386d043c665 100644
> > --- a/drivers/cpufreq/cpufreq_ondemand.c
> > +++ b/drivers/cpufreq/cpufreq_ondemand.c
> > @@ -374,7 +374,10 @@ static struct od_ops od_ops =3D {
> >
> >  static struct dbs_governor od_dbs_gov =3D {
> >         .gov =3D CPUFREQ_DBS_GOVERNOR_INITIALIZER("ondemand"),
> > -       .kobj_type =3D { .default_groups =3D od_groups },
> > +       .kobj_type =3D {
> > +               .release =3D cpufreq_dbs_data_release,
> > +               .default_groups =3D od_groups,
> > +       },
> >         .gov_dbs_update =3D od_dbs_update,
> >         .alloc =3D od_alloc,
> >         .free =3D od_free,
> > --
> > 2.56.0.313.g2479322e68-goog
> >
> >
