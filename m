Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D721C359A99
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 13:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784725565; cv=pass; b=JEgd0wGGjXMD23tk8VeXNT41a++NrTWrSDoX31CfuFSsCJA8sJZU9Si5NXe5VH/l2CMTETK9tztVeUjZE8RkTa8/1eDJAAVrNNrr0mYAVnVjtZnYtEz65++oVIPla6PCI7qz+dKmAG2mUV5S8+iHoWPzKCvyphu/JXOYpesa3xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784725565; c=relaxed/simple;
	bh=jtONZb8KF9+tmw+wCMSn1h1T1/7RtcaUMdmWmHxTQQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDlOGPDmB3QsXAEekq+PgCvT7ujWODxErwUv+nQTDHrdvV18T81D87yJ+sIIhOVZUIMcG4MjGS1oUCTEGkyyD1MgVwWseh2iSg+zzeyE9532YGQrJW+V6V8ZrHDfVXKLORZiaPeR8A9HdiR4VrrkEFfqwSIQegnNB8zt1MwEDKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RJpaL5dn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bYl7oobg; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJpaL5dn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bYl7oobg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784725561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P2EDvWx2wmPVwR+EyoXNEoh9jAz5fPv9riDeA7I8M2c=;
	b=RJpaL5dncxOp1d8FaXYKCVo8r0peg5m2v2uWZ6cwKQzduOdHYVQ66g1oO1JvgAmqBXfO3R
	J2eN4cqZT2/TvNhj0MrdB8WUKUhnwO9gddZA839/ZOfSMr5Dejk4C9xr8bHggZKxAngGjt
	Kq4wVDa6j+7BkQExM1VPREeWSCTYZyk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-ShvhnrC_MuyySfYYA11JEQ-1; Wed, 22 Jul 2026 09:06:00 -0400
X-MC-Unique: ShvhnrC_MuyySfYYA11JEQ-1
X-Mimecast-MFC-AGG-ID: ShvhnrC_MuyySfYYA11JEQ_1784725559
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c1c232fa136so269152966b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 06:06:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784725559; cv=none;
        d=google.com; s=arc-20260327;
        b=VDZ7o/0+jh0AfA7j/IL3+GF9R0BIihnFo61haHgBIjyRcLTUbvFQLzQ/WLXMEk47pP
         ne+gKn2xwgO3CdJvtGcbA7kvvdb3d7uH8bN2SOjbrtXVUJ4EiAdz5lI0b1NtKrF3Ynb0
         h6kw46DRkCyQAO80W8/nxcE4f1XrcJdPem9YSSTN6h/AXrClo/Eq+HLrmxkA5CAdKz6V
         86aH3aPTUouQzuDTt6uDANuGyO80zkxAloq9TE4NGKU043fPf+War19iAAtaZSGPDZ2D
         E5IFVLvRU+P2q2qkfLXyp/uEdTnp5shsOBSNmAvTFiB2IrAz6x/HG67IwhT1EmN7OUnw
         dGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P2EDvWx2wmPVwR+EyoXNEoh9jAz5fPv9riDeA7I8M2c=;
        fh=dIoO7VNNkA6S7bMASs3COR3f7GhQlatuTmqbLdeDGyY=;
        b=ihnv7VpqcooDpfXow+PBW9kuQogj5p8b7bX0Y9EVZKD6B2fQEeCUkVYoszCFBqg5o5
         m9uKAF+sMy0rXVlQZ4hlkYsNj38PvoyKHddqSG0+FM1JO2yRbztaNhukf42NOJQaM8QN
         UCSAJwyl3PcrKROo2cRJdnWFK7NC0VX8UQvD3vDhM1Vu+R2fuVacK8PaXgAbKWCl8+ob
         zVR7MWU0XxGMREKtKIVSjZNcFdYeM4riGEmzqeaqr1g+Aq8JZqWlprA3GI3WVjfRh1Ev
         53XcMVECrIbXWMe1ZvFrQgoGgGTuKen4raJYHeXabqKdhd1ICKOyZeMW5UTP0crXU/rF
         QesA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784725559; x=1785330359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P2EDvWx2wmPVwR+EyoXNEoh9jAz5fPv9riDeA7I8M2c=;
        b=bYl7oobglTx7fabZfGjWlIzTGIrkT8KX348EPlSpfSpUh9q/OSO40+dqPRLqXCg9OK
         8hRv0Hi/50SZ6pH/RKbCt9UaZ1ia6+63A5KlfJ69/G3Flzp5SjqWahcImw/PXFUslhaM
         PEVWO/1bFvSfH7oaic30qhVZUe9FPyXMmSrpPS9hhfPQxy7dzAOrCz+6u4fRH779qXPV
         LPvG/vSb0xssoZzO20MqjP+mQLHx0e+oK+U7+JfCPc+HmXPDAG6WzSLKgV4amBytqWJQ
         49eKzECF1eybdDrC3ISjA/fjqfmkWNxcAX4O+jkk8440szt8Gagtxwdrx4unSoxoYO6x
         YP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784725559; x=1785330359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P2EDvWx2wmPVwR+EyoXNEoh9jAz5fPv9riDeA7I8M2c=;
        b=SuvlSaE0F6Zjze+9DwtFEWnFqbtWS9l8YNMR8iY5LVLZHlxkf+mG6OCOAgNy3lj+0P
         IycKlxIrRrOV5NGYYFB0vI+8aaT4oZ1OIiZqGYO1ZK/nvuq8F2wzPC9RgUkYb39k2uiv
         abnRN8mkF70CjC0108k8wzn/I56bt2YQ94Z3ur7D7EwNz+ilbtKqIwzSzkDuye5Zck//
         9YJ+C8d9zVJZGja9M9pnUqu4r1PrXr8GrNvWsljaI9n3v5ksMmh8nJpBfyN6947RKDtb
         CK2b/TmNGtKgYOEbfG404CfbSrfEpWI/zjPQ2Mu07BawXjYf9V07M+tIL0+xlXTnJhNe
         J84g==
X-Forwarded-Encrypted: i=1; AHgh+RrZVZM2GpHO/ebgDcXm8Qbx+L7xqzxifmrHccucyCOVuQmA7NKS0UHp4+1wqIrhNh8dy9/wkGRiTEJMihvP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7wucJFsp1ISV34Nwje8FqjCg1agejCKVZClF63fLPglbvr5UE
	hogpdhaL5INIbzKzT81AYskxKp+p6nrX3/fPTYrByjIZ/kVST2igheo3befmxFjIMwUwlq0365A
	qrPM+OoDePxiFw5E4O4AsLZ5ku7vW6VKbiWFF5OnGOZ04XxKxZoLl8wt37JVBhMyrlFKkcSbZ4+
	FGSehuCpUZAIyQGf47jPVaTb2/hF2InWEfwXbkd0jAig==
X-Gm-Gg: AR+sD12Bb2FONvK+wfW16HlgKW30McpZeONl3WnmBX0D1nqAynLCAraCB2ZJi93uC4R
	CaKBY/xICEO3c4ERS3oPvN2fTmprL/A/DRJBVehn2gp7Af7UU0prMAMmJMMes++G9jHvXa58+vl
	8/E/FQLk/y8QaVdz8jcNjG6/W24izlpmhaC0pcNtP+iuKusxdANvi7y33lLkpanQo373nfsWx6b
	5mDaieScWQlmjkMRyNHw8KoGEqkSPGQLuJ3SuhGE2FqtRCk574H9emkBNaqSh9u/3q5zt93r0aY
	4Aw=
X-Received: by 2002:a17:907:3e23:b0:c15:ee17:47a with SMTP id a640c23a62f3a-c1c31016077mr156071466b.15.1784725558813;
        Wed, 22 Jul 2026 06:05:58 -0700 (PDT)
X-Received: by 2002:a17:907:3e23:b0:c15:ee17:47a with SMTP id
 a640c23a62f3a-c1c31016077mr156068966b.15.1784725558240; Wed, 22 Jul 2026
 06:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713170013.4073499-1-rrobaina@redhat.com> <al/wQsmHmVMSo+RH@madcap2.tricolour.ca>
In-Reply-To: <al/wQsmHmVMSo+RH@madcap2.tricolour.ca>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 22 Jul 2026 10:05:46 -0300
X-Gm-Features: AUfX_mzQlQH1q_C4gRpCynDHph_irPi10-leduWD5odsmTngWowUNj4SLQAPEGU
Message-ID: <CAABTaaBP3g-np2MhYHebiQpGHFpTe6Z_itqvt2qu9hsymkbHCw@mail.gmail.com>
Subject: Re: [PATCH] audit: add FSCONFIG auxiliary record to log filesystem configuration
To: Richard Guy Briggs <rgb@redhat.com>
Cc: audit@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paul@paul-moore.com, eparis@redhat.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 7:18=E2=80=AFPM Richard Guy Briggs <rgb@redhat.com>=
 wrote:
>
> On 2026-07-13 14:00, Ricardo Robaina wrote:
> > Modern mount tools (util-linux >=3D 2.39.1) use the new mount API
> > (fsopen, fsconfig, fsmount, move_mount) instead of the legacy mount(2)
> > syscall. The generic SYSCALL audit record logs the fsconfig syscall but
> > does not capture the configuration parameters, creating an audit gap fo=
r
> > critical mount information such as the device being mounted.
> >
> > Add an FSCONFIG auxiliary record that logs the command type, parameter
> > name (key), parameter value, and aux parameter passed to fsconfig(2).
> >
> >  ----
> >  type=3DSYSCALL : syscall=3Dfsconfig a1=3DFSCONFIG_SET_STRING ...
>
> This looks like it is missing "a0=3D..."?
>
> >  type=3DFSCONFIG : fs_cmd=3D1 fs_key=3Dsource fs_val=3D"tmpfs" fs_aux=
=3D0
> >  ----
> >  type=3DSYSCALL : syscall=3Dfsconfig a1=3DFSCONFIG_CMD_CREATE ...
>
> This looks like it is missing "a0=3D..."?
> I'm guessing this isn't actually real test output?
>

Thanks for reviewing this patch, Richard!

That's real test output; I just trimmed the SYSCALL record output to
fit in the commit message. Since this patch does not touch this
record, I don't see a problem. I can
add a0=3D... for consistency if you prefer, though.

> >  type=3DFSCONFIG : fs_cmd=3D6 fs_key=3D(null) fs_val=3D(null) fs_aux=3D=
0
>
> Was there a fs_key output here that didn't make it due to the issue below=
?

Actually, in this case, the test result happened to be right (that's
why I missed it).
FSCONFIG_CMD_CREATE has no key or value, so both are NULL[1].

[1] https://man7.org/linux/man-pages/man2/fsconfig.2.html

>
> >  ----
> >  type=3DSYSCALL : syscall=3Dfsconfig a0=3D0x4 a1=3DFSCONFIG_SET_BINARY =
...
> >  type=3DFSCONFIG : fs_cmd=3D2 fs_key=3Dhidepid fs_val=3D"<binary>" fs_a=
ux=3D4
> >
> > Link: https://github.com/linux-audit/audit-kernel/issues/153
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  fs/fsopen.c                |  7 +++++++
> >  include/linux/audit.h      | 13 +++++++++++++
> >  include/uapi/linux/audit.h |  1 +
> >  kernel/auditsc.c           | 27 +++++++++++++++++++++++++++
> >  4 files changed, 48 insertions(+)
> >
> > diff --git a/fs/fsopen.c b/fs/fsopen.c
> > index ae19e5136598..9b3c02f59df4 100644
> > --- a/fs/fsopen.c
> > +++ b/fs/fsopen.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/namei.h>
> >  #include <linux/file.h>
> >  #include <uapi/linux/mount.h>
> > +#include <linux/audit.h>
> >  #include "internal.h"
> >  #include "mount.h"
> >
> > @@ -357,6 +358,7 @@ SYSCALL_DEFINE5(fsconfig,
> >       struct fs_context *fc;
> >       int ret;
> >       int lookup_flags =3D 0;
> > +     const char *value_str =3D NULL;
> >
> >       struct fs_parameter param =3D {
> >               .type   =3D fs_value_is_undefined,
> > @@ -423,6 +425,7 @@ SYSCALL_DEFINE5(fsconfig,
> >                       goto out_key;
> >               }
> >               param.size =3D strlen(param.string);
> > +             value_str =3D param.string;
> >               break;
> >       case FSCONFIG_SET_BINARY:
> >               param.type =3D fs_value_is_blob;
> > @@ -432,6 +435,7 @@ SYSCALL_DEFINE5(fsconfig,
> >                       ret =3D PTR_ERR(param.blob);
> >                       goto out_key;
> >               }
> > +             value_str =3D "<binary>";
> >               break;
> >       case FSCONFIG_SET_PATH_EMPTY:
> >               lookup_flags =3D LOOKUP_EMPTY;
> > @@ -445,6 +449,7 @@ SYSCALL_DEFINE5(fsconfig,
> >               }
> >               param.dirfd =3D aux;
> >               param.size =3D strlen(param.name->name);
> > +             value_str =3D param.name->name;
> >               break;
> >       case FSCONFIG_SET_FD:
> >               param.type =3D fs_value_is_file;
> > @@ -458,6 +463,8 @@ SYSCALL_DEFINE5(fsconfig,
> >               break;
> >       }
> >
> > +     audit_log_fsconfig(cmd, param.key, value_str, aux);
> > +
> >       ret =3D mutex_lock_interruptible(&fc->uapi_mutex);
> >       if (ret =3D=3D 0) {
> >               ret =3D vfs_fsconfig_locked(fc, cmd, &param);
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 45abb3722d30..978eb881974c 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -449,6 +449,8 @@ extern void __audit_tk_injoffset(struct timespec64 =
offset);
> >  extern void __audit_ntp_log(const struct audit_ntp_data *ad);
> >  extern void __audit_log_nfcfg(const char *name, u8 af, unsigned int ne=
ntries,
> >                             enum audit_nfcfgop op, gfp_t gfp);
> > +extern void __audit_log_fsconfig(unsigned int cmd, const char *key,
> > +                              const char *value, int aux);
> >
> >  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
> >  {
> > @@ -598,6 +600,13 @@ static inline void audit_log_nfcfg(const char *nam=
e, u8 af,
> >               __audit_log_nfcfg(name, af, nentries, op, gfp);
> >  }
> >
> > +static inline void audit_log_fsconfig(unsigned int cmd, const char *ke=
y,
> > +                                   const char *value, int aux)
> > +{
> > +     if (!audit_dummy_context())
> > +             __audit_log_fsconfig(cmd, key, value, aux);
> > +}
> > +
> >  extern int audit_n_rules;
> >  extern int audit_signals;
> >  #else /* CONFIG_AUDITSYSCALL */
> > @@ -730,6 +739,10 @@ static inline void audit_log_nfcfg(const char *nam=
e, u8 af,
> >                                  enum audit_nfcfgop op, gfp_t gfp)
> >  { }
> >
> > +static inline void audit_log_fsconfig(unsigned int cmd, const char *ke=
y,
> > +                                   const char *value, int aux)
> > +{ }
> > +
> >  #define audit_n_rules 0
> >  #define audit_signals 0
> >  #endif /* CONFIG_AUDITSYSCALL */
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index e8f5ce677df7..5cd0eb602528 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -122,6 +122,7 @@
> >  #define AUDIT_OPENAT2                1337    /* Record showing openat2=
 how args */
> >  #define AUDIT_DM_CTRL                1338    /* Device Mapper target c=
ontrol */
> >  #define AUDIT_DM_EVENT               1339    /* Device Mapper events *=
/
> > +#define AUDIT_FSCONFIG               1341    /* Record showing fsconfi=
g args */
> >
> >  #define AUDIT_AVC            1400    /* SE Linux avc denial or grant *=
/
> >  #define AUDIT_SELINUX_ERR    1401    /* Internal SE Linux Errors */
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 6610e667c728..222bf79ee9bd 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2882,6 +2882,33 @@ void __audit_log_nfcfg(const char *name, u8 af, =
unsigned int nentries,
> >  }
> >  EXPORT_SYMBOL_GPL(__audit_log_nfcfg);
> >
> > +void __audit_log_fsconfig(unsigned int cmd, const char *key,
> > +                       const char *value, int aux)
> > +{
> > +     struct audit_buffer *ab;
> > +
> > +     ab =3D audit_log_start(audit_context(), GFP_KERNEL, AUDIT_FSCONFI=
G);
> > +     if (!ab)
> > +             return;
> > +
> > +     audit_log_format(ab, "fs_cmd=3D%u", cmd);
> > +     audit_log_format(ab, " fs_key=3D");
> > +     if (value)
>
> This looks like it should be "if (key)".

Good catch!

>
> > +             audit_log_untrustedstring(ab, key);
> > +     else
> > +             audit_log_format(ab, "(null)");
> > +
> > +     audit_log_format(ab, " fs_val=3D");
> > +     if (value)
> > +             audit_log_untrustedstring(ab, value);
> > +     else
> > +             audit_log_format(ab, "(null)");
> > +
> > +     audit_log_format(ab, " fs_aux=3D%d", aux);
> > +
> > +     audit_log_end(ab);
> > +}
> > +
> >  static void audit_log_task(struct audit_buffer *ab)
> >  {
> >       kuid_t auid, uid;
> > --
> > 2.53.0
>
> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> Upstream IRC: SunRaycer
> Voice: +1.613.860 2354 SMS: +1.613.518.6570
>

-Ricardo

