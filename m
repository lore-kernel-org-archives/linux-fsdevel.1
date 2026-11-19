Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795067159;
	b=QpxGhICFs6bMV4JnU2d5l+v3Pfmqs2kuFydmquNOyohKthK4Ok9TjmQrgVTfHEmDItIt
	 fzqFKx/xdd3pt2Fkqal0KvjCD7sfhSrALb+1UgRQlojJQACkJvqOwGsWGsxvQhIwfPoX9
	 Pe8+kECImbFXkWsFCkRtaPh5fFl05tMPX9UfVY2sFM4u+q45WFIENMzt1MM+2Fg0sJr3o
	 M7R3O/H9kCHwA7oT6YwrcLzEL/tNqFuoAcBX5Zm0Ff0qgAuHs9IxrwTv4o0o64AxUJFE0
	 A3GM4qSJ/SondVWpyanFDcdhLdQmeS6His7XeZzPCXf/s61GUTaDkddzQJFs2vYrp4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067159;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
	b=K9WV7NUqimXyBijVaZ9SK6PnUpg0KOjEAh78J8CKVjrPyV0KKzRvFAEVLPCQQ+qx3zBC
	 Rvgg6sroNWBfuhxstDoPw+lGzfG/0uigvTSj/IOwi2kerrmTo+/ICwqw+XvpKjkhms21p
	 nAwy0PAz4jpdgBkN/1Bezye08b9ZJDYkX200G0EPg5ar6igdEv75z2fmcYHlXSaGmh2TR
	 vWnvr0uci45uEu5eRMg1gEuPr5f3cxDQzWDT+k80j6AD614KEVnAd3cP/fjxnR6C5cG7a
	 XUuDIcowf2mhxLTkkCBelJ1+UzIXZOi7SfGhCUYphslnxg8m0nCc1paEJMLj7M6L9rQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G9sTcZLh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CB7606A325
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 05:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14CB7606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=G9sTcZLh
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-55be673e029so117451cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 21:45:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067158; cv=none;
        d=google.com; s=arc-20260327;
        b=YpLJt8AOBfJswCa+5euHPKuO/GkPPknU/l3Qvqg2iQrTGrl/z2fctE6ef6Jdm2C8Eg
         g5nX/7DpxPENFtcbBQ/AdE9Q71BLjaQvn/rkUjY7UHKBEEWYF5UpY7Wi4bVNi7sMoUtx
         2kP62QJpGlpTAo21r1chWerlWv+tb7QeCftU/17EazhRi7Uxwb6FJeVCyWgSUSRAlb/H
         Wty9W2WZejQ5euYchcs+SDSXxMwCkzgOs9q7NmhehRyL2xbcwJAGaV1zdXzzh+0X360T
         Vm8+XRevV9RsJJ8Sg7AeN0DcT4kF3B0HMZMChsJzuq1NE4s8KqfkQ5nTPIhoayyDsYMn
         +o6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        fh=T8SYouZZIdGE+ERndnLjJz3rz1TGh8o08WJ2VdlAz9w=;
        b=CSR1yiOiP/iByXtNb5n0o5+srV0svudlTdAXhW8eFHm8p4lhvmYdQjTWiI3n+XSlpS
         8OMTyWbFnDIIwT8OT+a0YuoYK9zRwLugh9UVaZwdc9K9bka+1VmtmBEHNqhr+CCX/PuB
         qLQQLorIjS8hn/tN+lBO6vXJQ8+wFxEv/7GJ2J21u8Z7wi960E70YJUZBUrYgZ6c6fjQ
         db8EtcM4dPnAMLkkPmXiKRvv4T+8UIA58i/ISq+l6qWvnzEnujGk+B37E76PGF/JvSZ0
         8dM19dLwaBIa1RwlVX04xxZFWMR4hsGYc43BYEstuylhyX75GhdmNy6LxgpFvz1cRuW+
         sNLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795067158; x=1795671958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        b=G9sTcZLhDZovHsgCx5Yv7CDMxJM8G5FDawL5JBd36y8NAy88YZsvFaSPGxL2OJDQWl
         D8l1zhaslplXpC+LH5CUyVM6fiya54hKkm3044CoRWwH6cYkMSxwEs9IE4R9vJJik3G9
         PaGymfho5RIhVhS+d5TUg18WON8Y60WBZxMM5gYyXKhy/KCwkwn+iT9No3gldijeO5tx
         xp5Gg8oePFUL/bdSJWKKtm4OA3cKKfEuUGn9FzCr/u57K1nN+6BjTy/XuUfYpf49AuBU
         GF3mrNTIV4ZWpGu4KegbuhUlLkOSriAaKH7KHmdnomUVdJlrrfe8QiZH1hsMd7fqVOCf
         HQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067158; x=1795671958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cIkoHsOVRZS7gIowPl6xkao6tH+bfcK9X/Z+HF8PGU0=;
        b=O+N3E3kHzI3DTF8bo/Qv4C7UxZ+ZueT8Hu8Q8GYwYseO3ql4RAcznHvaVP5KG2biAw
         9Eq4Yqb3p7lSLag2XEoSIlw1TpWnCZhMLzWx6O38r2qKF3kEq36x5gLO1c/nh/zielO7
         jUlQPG10ywK8QRPb+DyBsbBt+mYkX4NBEe6KmQQvMxPb1LDWG/CWDLD51FyhvmW28+AG
         XUsJaPtx8/ziVm867TB6Zz4CxuSGvUM0bw30tOcY2ZeylAygxxgyeS0rwAjkBwPGILTe
         1chTMkqipcR15NEFagrWKVj58kcJkKjzkZoANOu08pKbskwrNB8mjK2CS5I8xeJv4xPi
         cJzg==
X-Forwarded-Encrypted: i=1; AL+hErGfeuXhpxNccxBnAR3det2R2QI89/YevxRMVhxycaKf3ExGNND0IQu6hH83MpgdIr9jtCDcRptk2mySVbH8@vger.kernel.org
X-Gm-Message-State: APuU4Z+FaXTEJboHeh1w+8WC0Sk/yGRSowJ4DJWn+xrLsnuhi+ob4NRf
	Oro9F/R49mPHEbx4218z4eYVMt7CCv5Sof9UVicBdi8VXg7FTzaijJsXMjDUhQoZYkspAC6IRLL
	579ltWcoigc2eiuHCCe3RCs4qfVTTULKYXqqB4LA+
X-Gm-Gg: AYBFou26hah2yug/HOSdYzIZZmhznVEeaV6twUY1eGlwr4hrgGPS5rRLkeFTdoz6no4
	/jtYEz1WhX8X6MNu5O9rN0p+uVmIJ0s8HFJ2oKwKJ8bIT3kduaRbujqdueVRU2lRig7LC+c584H
	N0hkdPF7pOA3+lHDhiEqSsbyeSd2akxQCv03RunvdH2J7nkwN7jvdLtZYicSOd1mjphhGjHkzFG
	Inrd2NjLYFb8QAe7skudGLMptrbMhE51TqpiimRnn+sFzzh7v53g8NtSXSoZyophT42TfulXjsD
	PlS8KBGCryvQHXZKMbjRC8Xg0PViatSjCS63yZ3/Y8/IVswVpZ8YB2e+WjBhJZz4pYatacyggWy
	gLGDYyBT01lZVzv3cbZxPHGJUFv6yks3ypk6q
X-Received: by 2002:a05:622a:4808:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-55d6c7995f9mr6557911cf.2.1795067157461; Wed, 18 Nov 2026
 21:45:57 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261108223913.3624571-1-irogers@google.com> <20261108223913.3624571-10-irogers@google.com>
 <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
In-Reply-To: <DMYN979QJFNV.LM3T6O68OHW6@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Nov 2026 21:45:45 -0800
X-Gm-Features: Aa3M54p8GzPfKDPQ_HJcPbdLHGq3vwK7n9VGnVvnVB1ODjbFHeHwrlgOfVCaaEo
Message-ID: <CAP-5=fXrMyfLFXq6CiqwWMSbtYVRNESxuDo-ddqNwDmq5Nm4SA@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] kobject: Require explicit initialization of struct kobj_type::release
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>, 
	Srish Srinivasan <ssrish@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Juergen Gross <jgross@suse.com>, 
	Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, Alexander Aring <aahringo@redhat.com>, 
	Felix Kuehling <felix.kuehling@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, driver-core@lists.linux.dev, 
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, 
	linux-s390@vger.kernel.org, gfs2@lists.linux.dev, 
	xen-devel@lists.xenproject.org, linux-mtd@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 1:11=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Sun Nov 8, 2026 at 11:39 PM CET, Ian Rogers wrote:
> >  static const struct kobj_type cpuregs_kobj_type =3D {
> > +     /*
> > +      * Pre-existing: info->kobj is embedded in per-CPU cpu_data;
> > +      * cpuid_cpu_offline() only calls kobject_del().
> > +      */
>
> All of these comments carry a =E2=80=9CPre-existing:=E2=80=9D prefix, but=
 that doesn=E2=80=99t
> distinguish cases with broken lifetime management from those where the st=
orage
> remains valid despite the API misuse.
>
> For example:
>
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_xcp.c
> > index ab14079d1c42..0847134a1391 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> > @@ -797,6 +797,11 @@ static const struct sysfs_ops xcp_cfg_res_sysfs_op=
s =3D {
> >  };
> >
> >  static const struct kobj_type xcp_cfg_res_sysfs_ktype =3D {
> > +     /*
> > +      * Pre-existing: xcp_res is embedded in struct amdgpu_xcp_cfg
> > +      * rather than freed individually by kobject_put().
> > +      */
> > +     .release =3D NULL,
>
> Being embedded in another structure doesn't explain what guarantees that =
the
> enclosing allocation outlives the kobject=E2=80=99s final cleanup.
>
> Could you please drop the =E2=80=9CPre-existing:=E2=80=9D prefix and make=
 that distinction
> explicit? For broken cases, describe the lifetime problem and mark it as =
needing
> a follow-up fix. For cases where the lifetime is safe, explain what guara=
ntees
> that safety, while acknowledging that omitting release() still violates t=
he
> documented API contract.
>
> Also, do you plan to follow up on those cases?

Makes complete sense, thanks Danilo!

Auditing all 17 files in patch 9 with that distinction in mind:
- Only 3 built-in sites (arm64 cpuinfo, ACPI hotplug profiles, and
s390 sclp_mem) have backing storage that genuinely remains valid for
the lifetime of the kernel.
- The other 14 files either free/zero an enclosing dynamic or devm
allocation without waiting for final kobject cleanup, or are tristate
modules that unregister static kobjects/ksets on module_exit and can
unmap module memory before delayed cleanup finishes.

I've dropped the "Pre-existing:" prefix, documented the specific
guarantee or FIXME lifetime hazard at each site in v4, and yes, I plan
to send follow-up fixes to the respective subsystems once __must_init
is in place.

Thanks,
Ian

> Thanks,
> Danilo
>
