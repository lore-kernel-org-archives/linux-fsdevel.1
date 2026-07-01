Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6573033E1
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 19:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935788; cv=pass; b=U44m5vv3pqDMeVsBxaExoTOF/hEc/+0jID3L3GNsEuONLj4DGZ5tI8q0qOI/tLTzoR5mAJptkRjQSuNHaak+XyiywU7+6PQPrrXMtC5zRXh/p7wL69NRR51MmHa5CuWUEuifJBHFWjsVVu0hey246AJ6j2FVwcCSDFa9R1jNfsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935788; c=relaxed/simple;
	bh=n6YHQIP0YEZBjX3N4RIfYi4Tv10PSi2zYyplxcrhn8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glGvoEYRXBwaLbuwaThspnre+RApIVXILG2tRu5alU9WoAER3ZnYbSYyu2s2MXzIfRFy4K5OHZu+mCZNDKMIwQx0GSAiONvQEGZfnv6rhOA04XhDUFS83YaCskto2EW8Qdw09R96XghuOUyQayFWug89efDoIGtdDkK06Rq8nPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cpAdbRH7; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cpAdbRH7"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-36b9d265355so660090a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 12:56:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782935787; cv=none;
        d=google.com; s=arc-20260327;
        b=c1pbIH8zcJkD+TmYeKuo87dBSYCTIf2q1INzvnIVrTEQoAl//XZLEXw1GtV/IGCSMr
         M3tYCOxV+3doUF601ZslXO1lhQ4RxFo3m/KADV07av8giVzDoLNTmh4KQHtYOPcvmG7z
         0uI+AkBjT1nNl17EA8gyztoknA+vEus3KZN3P3UH7BXxa2Jqn8e2Q7h7BRNZK9tlvxrN
         0kmoOwdL15HMuYkwhevY+3lgaGTQfK8aw6tBmI/BsEUpHZbrudQETbqQ927HbZ+mtbPo
         tMqG1C2eTU0557SdTR6Q16H1154mso7a0pb1gV3F4da36+Vdgl/C7x8R4cpqvGC7c+k/
         iC/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EuC7YOrXqKERMVFGX7ZLvFfBBccRnw3BjEw2WRs5hiQ=;
        fh=gyN1kve5qoo6uwYVAuahBSErQAhqQPcLbgm8sD05lq8=;
        b=CJGKyc0a1DgcSPya6r7cFz0dqaWYvjT7eMZapHKyq3QwoFjSqCrhcvYwldbhvfaV2/
         617p/74eukC8XOMSsw5jRTa5lseTlW61T3Gz4Vnbb389XB0ZuSCh3a4AQEs+/Y23x7RD
         NXtw6vetfJsZBe+rLFJrDtFgzXYFftzBImW3eOTA49DEOl1mDdJ9nx5VR1fr2o2/n7LN
         3FteHCBaRJV+4u9kTRWLGu9Uc/pE2f+Qs0IEesFT0INNKE51TkWFlwQp7ROJIKPmFFfM
         bLr0aTrfUK2YcfjjBz1wbbUX2GG8CbdxSyItbfxjUVOZZmcUUfj5Ge8aBdoPjW3HiMq7
         z2kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782935787; x=1783540587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EuC7YOrXqKERMVFGX7ZLvFfBBccRnw3BjEw2WRs5hiQ=;
        b=cpAdbRH7t5xAMwguDDuZK37rPcEOaYzQ4ETTYy9WXq6WKUjUW3ouLoSVzV5uKd2dSx
         zxaBFrPb00r7pIIwa/qVQBvngoMQKUser31oKRm87CahPJCy6wh8+T83fwnF/Z4xaZyf
         W2GceJ+KPjmm4wyycgPGexEym9ouWL07tnCzExbNVCUvfk/0Cuv4b2mnd6nH0EguB5Pl
         dQRuTgMwZwE9mDrHL6IeNvWsFSHh0guy+I6UdTwWdZ3AuAgIpfOlj122dBrzrmJLjHSN
         qtlIywFntFuCBmxSXwI25QEXl5GMN7o/GSOlTuZKvQ4/dKRhvA5dHZnO+sWjfIMvQfuM
         biwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782935787; x=1783540587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EuC7YOrXqKERMVFGX7ZLvFfBBccRnw3BjEw2WRs5hiQ=;
        b=S70c8VsLhdXwIxaF54MIP0/3RTlThIcmFohAsjyJcwGFc0Np1FL1eYDAEsLd2QZVjQ
         YtwIHEtIu07lcpYYpiHIyDjBnMCdJgeGdvzp8+Cs2wTrXeVitBT7F9D2Gsp5/cI9T3c4
         KahizoqfzWSw0aqkKWCcpE2bxafrIE62a6VqqWCGZPsihZ49ktxoPox9UOfk+3ykRGbE
         j/PZxmYX5p90dzxOFJ7e5iTYwhGJijGPtgeNGqdZDpvof0VDjf+9vNJPrvW5DMxurllV
         Q6Mfp1vy5C6kLiBQb2MfKwPJEWAoCxohegD/MxqV+lUOKnplVriX0k2n7c46OORaK4/z
         FzRQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvN5afnXowS17BGlzUgHT01vmymxRe8Mq+CPOI1vnfqK2EatsV2OwZrAAchIs8Y5ZMv1Y3yHja1kANky/P@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+OfkxFrQnGKIlATuNzV/IFWFTTry7XXkAsnplHYPAFk2C1JfP
	P0nDFKIWw8yiwp8BTjIMfib8i9tHng/x+bWYwR8ghZ18qg4gdjE/t7bZKeBi3h3foPzC9XwB5ua
	0LnyOx1udf1W/oT29gGauKHslBLCZaKTOril0UYJX
X-Gm-Gg: AfdE7ckSnT4jj5f92YfUAgvbFWYZUz1cMHTiY3BJmgBAEJSPgouIxC6RhjCdPHqDgBD
	uVbIvbtC/0bS68QMl8E4aQJS/9A+W/SHGnhWTccQ+h7B3IKZW+Ra/rS+rcoygQ9HM7OkvXf6m6q
	8MtSIDaYIqANI3+dbRHqxXBtjqf+LMa6L51CNj6PN73glTSwiX2faun+/wKQdDJgcPkhr/CSdcs
	Y9XrUN1yeL+YPSGmQrMlwRAKk4PBG2qjeSUQupuO0jbcM5zaYLaXxwENLIPZtkCJn23ASTB
X-Received: by 2002:a17:90b:3dce:b0:37f:ec5e:12d9 with SMTP id
 98e67ed59e1d1-380ba8d5433mr2217986a91.16.1782935786771; Wed, 01 Jul 2026
 12:56:26 -0700 (PDT)
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
 <20260701.oTeikequi3ee@digikod.net>
In-Reply-To: <20260701.oTeikequi3ee@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 Jul 2026 15:56:15 -0400
X-Gm-Features: AVVi8CchkWBXMOb3h-xrc92CuqNk9C2bKMYW9zj_XiDt_Bb5zyUcKbp9tgMfNuk
Message-ID: <CAHC9VhQKda2hBaNkb2OcqmEg3S_2n7HwQGkFFNDNaxMkTCn1TQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/20] bpf: lsm: Add Landlock kfuncs
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org, 
	john.fastabend@gmail.com, Justin Suess <utilityemal77@gmail.com>, andrii@kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	gnoack@google.com, jack@suse.cz, jmorris@namei.org, serge@hallyn.com, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	eddyz87@gmail.com, sdf@fomichev.me, skhan@linuxfoundation.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Frederick Lawler <fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 3:49=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
> On Wed, Jul 01, 2026 at 02:38:08PM -0400, Paul Moore wrote:
> > On Wed, Jul 1, 2026 at 2:34=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@di=
gikod.net> wrote:
> > > On Wed, Jul 01, 2026 at 09:28:22AM -0400, Paul Moore wrote:
> > > > On Wed, Jul 1, 2026 at 8:52=E2=80=AFAM Justin Suess <utilityemal77@=
gmail.com> wrote:
> > > > > On Wed, Jul 01, 2026 at 08:12:34AM -0400, Paul Moore wrote:
> > > > > > On Wed, Jul 1, 2026 at 6:59=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn=
 <mic@digikod.net> wrote:
> > > > > > > On Tue, Apr 07, 2026 at 04:01:28PM -0400, Justin Suess wrote:
> > > > > > > > Create 2 kfuncs exposing control over Landlock functionalit=
y to BPF
> > > > > > > > callers. Export an opaque struct bpf_landlock_ruleset preve=
nting callers
> > > > > > > > from accessing unstable internal Landlock fields.
> > > > > >
> > > > > > Generally speaking we don't want to provide APIs, either in-ker=
nel or
> > > > > > at the userspace/kernel boundary, that are specific to a single=
 LSM,
> > > > > > see the LSM syscalls or the security_current_getlsmprop_subj()
> > > > > > function as examples.
> > >
> > > This patch series is not about the LSM framework, only about Landlock
> > > and its specific model and use case.  Landlock using some of the LSM =
API
> > > is not relevant here.
> >
> > Based on a quick look the patchset enables BPF programs to call
> > directly into Landlock.  For the same reason we discourage other parts
> > of the kernel to call directly into individual LSMs, we want to
> > discourage BPF programs from calling directly into individual LSMs.
>
> We're OK for a dedicated kfunc to call directly into Landlock (with a
> tailored interface).  Landlock is designed around its syscall interfaces
> (well documented, tailored, tested), and this would be a new user of
> almost the same UAPI.

Larger issues exist beyond the suitability of Landlock's API; in fact
Landlock's API isn't really the issue as far as I'm concerned.  The
issue is that we don't want the kernel, whether via C code or BPF
code, calling directly into individual LSMs.  We don't even support
LSM A calling directly into LSM B.  Any caller making a call into an
LSM really needs to do so through an LSM hook.

I'm not opposed to allowing BPF code to call into Landlock, it just
needs to do so through an LSM hook like everything else to date.

--=20
paul-moore.com
