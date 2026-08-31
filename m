Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C206739524B
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211594; cv=pass; b=GWQ1sFiAJ/jOO2NgUUjb0gzt3P9WuS9Ml37tBcRXq8rWJtWvSFBGLg/sJzWX+kHXW93C974dwqBQ9UTDgmrsF3UI9PU+WryCjd7SjDWNqHbpB3o9v6V1VLqYRoo9YunE1FtRD/LVDr2M2pD98wSFd1XnQIdD/zOnUnBtr04KgiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211594; c=relaxed/simple;
	bh=SNlsz2MPRq4levA4MX+yohL5QexaYB539yJgxQLixV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CL8lr2k5pdXjZIo1NMVK4q9CnnZzzlVcdLL43uzGOwClSIKCuMJx8Mxl2v3Qv0FhqetneIRXOYL1DoOhbAcpStb07wx/DCzH0+Ch4J0nOgDKhlAbeu99tBOET0AKqCGd65AKfYcrQjlNYImrZDLmKLzae7onNKkXLzkEIH5pG5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PQIMo9RI; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PQIMo9RI"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8535a9be75eso3043218b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 14:26:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788211592; cv=none;
        d=google.com; s=arc-20260327;
        b=pEQxA83yv40URvaq02I1g+itpxqfJbwYcYG1nzlKwjNtIoMCyNDU9qSyeIHh5G6O9/
         W7X1JEC2ukYGSedKaRxmDFGateeEH64AzASvIsPtN7nnW4CpmdSkonS9x0Kzd6yEtO4D
         +5bUa+FgiVk3AkCDgTGMJINVBdqj2X9X1octQU19nba/PBsZJb3ZeCniA3t3Jt4kzXLk
         JXkDu/6+kd75+xuCZgVYjpF1ZrLB+YKzMHUcIzG5Zyl2/56jG5kqoscZqRvdsQtn7fpk
         m/6gi88yVUeF1wrF0LxDeB+ikr7K7w6UaAabQjcjwopZGZtwEgsfURsHtp65zPxawRHy
         zJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B0t0GoOAIGAPmJB6jitdBOXKLd7x+wtGWWpKwR8Li5c=;
        fh=bS19Edu1MaRe7rcpVV9ChpaDy0kkbXGsjhnmYukWCvs=;
        b=OzMMHFRuPx0Fuzo7gftLQtwN4dkyKB9hw10ATOHOoIq2XfF6d5+Vk5WpRwqGMRCuKW
         yfETNnPXJF3iKam92V7LV0K1rOVMKTlsy1S6feOLpl40PSR4UYkVr7PK7H2RBcZQC14g
         ks3J4Yw1LgGT1Sbz8Ch3AA4hVue9mfknl+ZprkC8Y38JzkkagTzNjtSpd3FA9UbuWwtC
         0odUNlSzQHS/F38t8EJ0HqV1F6TyY9yNjyItXjJtuG2fSafX+3YAuUZslVRXg+37avPV
         8HEzQDrj98PwOBVVLgKuLCCGPL8X9ILmhtdAXENqzhNXGbFDPsu57bPLXd1WWc4MF0F2
         ehwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1788211592; x=1788816392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B0t0GoOAIGAPmJB6jitdBOXKLd7x+wtGWWpKwR8Li5c=;
        b=PQIMo9RIZT6w7HmQKV2ItxMWnQ7jJyw4LDw3Sxt1Fq1/4DVLN4pgtpgAvRvhz211bU
         VtUJrxLCUImzY8K22youYRZ9bk6Nm7/vW4fFHUnZKcGluCpZ7aubtE3U4Wfm+/FjntTu
         z/6V+7VDf4SX6e5HWf2GnV73XK/HpkYoauBpjntBsyCzEe98qCEvMXE0T04Fjzp+uIqr
         NP7VE2I18KgJEnAOlaxy1kTaJoDjqkjzc4ZJlPlVyp+sfH0OZiSEBnIEY1UqMzyxCIQ+
         IyNCIsKsFVEzVH+jz5prz8x4Ga138WHh9chWvYOO7xHD3+OomyDnNBDb7Gsf/iU9LFu2
         GW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211592; x=1788816392;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B0t0GoOAIGAPmJB6jitdBOXKLd7x+wtGWWpKwR8Li5c=;
        b=TdJqA5WyXOO80j90yw4JiimPMW2qROzabr43AqEjFj/YbNmYV2P3HwAq19WH2bd6Vd
         x4qKPYlXjGY4zkKJHyO4w4l7A8JVG7hRDKnOuJqWiIxpyx5mFJZxM29NnqjustEpUFvE
         dKf7u61kJsxi/MVcb+rzJwu2GfjIhE5y+QwqndKRYUsEakk3ys4dqI4p0GzSXl00Rcxd
         vG8HKGK8e758Aljt47xJt6umLcu+UVAGeQPbIpg3M50lVc4L5CAdvhx8sAXyTRXg95OL
         PB/2RCJhzjmi4GmGN8YPlvwBScRUs8ciAY5wmdPyAm5eMAyOzGjbNl6dSodlSucBabdk
         L9ZA==
X-Forwarded-Encrypted: i=1; AHgh+RqNDfGzllMdebjLgKXs04kWvVdblu8gTTwwGnwZJ1WtxOfDRfWd/ScNqB4awKpWN9SFXwAD7nASkrkG4hcF@vger.kernel.org
X-Gm-Message-State: AFuF++kXBTEVhvNh4wgYec7JCjn/+SaWfwLMOgZKdfM3jVJu3mbTHJ0F
	NUIWhFBUGQRftmrBlIuV/BR/ZMvSVc85lv7XbMfaX8nSqw1OH3nnFSTZ7HiWnZHVm6QTZwNKAu2
	RN1hLJwzeD2Bs4zqTEkTd8deLKyXwGJMq8E2enmEp
X-Gm-Gg: AR+sD10ED7uoMJG7LeHinYVfTtZZBDdLi4Q5Hra+ZVAfeWXNI/lNv67MfsU6FKhAeZp
	WRPxBpOd+MkVMlUKgA+0u9lLWbiBdDSaWK6QS1CzqjEBVWFqlnuNHmEpnUJla2uqDgSzfQIkGDT
	n8eS0C6FZQdLrk6SLebKa+fap6Hwjr5Ut3NjixbYw7Ddg8WCw1g4f+RrxeazJRtgQvRAnZe2q7+
	ZoTxeLQXELojTTc+bzP6znqrD9JUT6hWrow5b4+NJSNekEQ4Hz3WKCwmXPLJauyRcnzVEU4lSb2
	qjJmXeNnhJhpyNzJkPMyPp0LCgzt4YBgDWUFn2o3q5jv0g==
X-Received: by 2002:a05:6a00:2da7:b0:851:bf92:34c9 with SMTP id
 d2e1a72fcca58-8562a8d2cdfmr43570322b3a.9.1788211591833; Mon, 31 Aug 2026
 14:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726161400.3010511-4-mic@digikod.net> <5cabf9b33a20f130cedcc423b8b2d151@paul-moore.com>
In-Reply-To: <5cabf9b33a20f130cedcc423b8b2d151@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 31 Aug 2026 17:26:20 -0400
X-Gm-Features: AcwNN1VcoP3dcmF-y7p30PIUoPvKVk5sVz3Ko6oQrIqfztGFDqzJ9T0P3PiRYsc
Message-ID: <CAHC9VhS_WP-bLgMGiFAfE1MT76iKvVJ-OV5r7xju-KMdrfjssQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/12] security: Add LSM_AUDIT_DATA_NS for namespace
 audit records
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christian Brauner <brauner@kernel.org>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: Daniel Durning <danieldurning.work@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Suess <utilityemal77@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
	Shervin Oloumi <enlightened@google.com>, Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 4:16=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Jul 26, 2026 =3D?UTF-8?q?Micka=3DC3=3DABl=3D20Sala=3DC3=3DBCn?=3D <mic=
@digikod.net> wrote:
> >
> > Add a new LSM audit data type LSM_AUDIT_DATA_NS that logs namespace
> > information in audit records.  Two fields are provided:
> >
> > - ns_type: the CLONE_NEW* flag identifying the namespace type, logged
> >   in hexadecimal.
> >
> > - ns_id: the unique 64-bit namespace identifier, retrievable from
> >   userspace via NS_GET_ID or listns(2).  Unlike the proc inode number
> >   (inum), ns_id is never recycled.  For namespace creation denials,
> >   ns_id is 0 because the namespace does not exist yet.
>
> Based on the code in this patch, "ns_type" should be "namespace_type"
> and a similar change needs to be done for "ns_id".  Regardless, the
> first three patches look fine to me (I can fixup the above during a
> merge).
>
> As mentioned previously, I want to merge at least the first three
> patches via the LSM tree since we have multiple LSMs which depend on
> these new hooks.  I'm happy to also merge the remaining Landlock
> patches in this patchset via the LSM tree, or you can manage those
> separately; let me know how you would like to proceed with that.
>
> Since we are at -rc7, this is obviously something for after the
> upcoming merge window so I'm going to merge the first three patches
> into the lsm/dev-staging branch now with the understanding that they
> will move over to the lsm/dev branch after the upcoming merge window
> is finished.  If you want me to merge the Landlock patches too, just
> let me know.

The first three patches are now in lsm/dev, thanks everyone.

Micka=C3=ABl, if you would like me to merge the remaining patches in this
patchset into the lsm/dev branch just let me know.

--=20
paul-moore.com
