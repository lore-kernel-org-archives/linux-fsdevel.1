Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F54345729
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512005; cv=pass; b=N9Fn80IM7BnQSGFHQ3BphVNBNc40WatJgQsXE2YsMpjY1rQCtpbCVgNL6xahspfmdMWWPzrghvmP8979hRXnAA7vDX7gXMRWwpTRBwTbs/Y/lxj3BlrVk5ndTS8AKq3NXcAkBO1y12mBXgOPgERTuEMHOR0TPSoJ5LpfUQ4YMWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512005; c=relaxed/simple;
	bh=VuFNcnIpHKuBE9TqXe/JfxuxV9DEEfYcH5BhOui7Tz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sEE+THOcHyMiqSiYNaX6WdEdeju5C+Ru6L3sQtFJ+ouhCUolgkeUxvJ02G3j6g3Ir3XBZUtLSbbtM8dVGcAqOjL3Fp6HfNnSkbTjEB30iKdFm0i3oCrnSeltVjSvowb6sVPMIZJBiJutOXKn4TlMcuz9bO+0bcTbi7WGpNaVnQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WlLS7APe; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WlLS7APe"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so942213a91.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 08:33:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785512001; cv=none;
        d=google.com; s=arc-20260327;
        b=EvZ3hW/NSXsx6nw+TLqdZCg6iSZuYLwUeRhQNUe750tysu3XFcx0Cg+wcCsLJIzpgN
         OcUVZe6OsOfHD95BOQ8+bhjo+OcSC+/ODEQyvKIobsoMJA5+YUw8L6isq08kGb7xq2yc
         IHSUKrMRZoZG7Mt9IGEE9QLU9VQBl2N7Nc6AFGshq4yxA1olO3DVVxnEJed1V48CKDrg
         Q1FwHADpUqZ7l/twbwTqoM2nuob4zIAp+Sz+EqLlgB9xaa8W1Tj2dsP4J7D96zN2NZe6
         IC1dgmeqXlVbZG+Y9z1bl0HnUyWp/oNx3W95tHx9gnJM25bvVge9huw4S90MwyLOKcxh
         jOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XnQ75jYzm8moYl46g1ePyO1gywKf+IeSpDPhO/wg5nE=;
        fh=kVzM5N1/U0SddYeVD/2TTEpMeItve5DZ75REfMYwTHc=;
        b=cTP48oz4QzsAdISTaviNXL9IcWwxEHJyYI+QFnp5uxiZr4bskb9VPLus8FTZjOYgO5
         RMRa264WCF81NLwGIT5Pw2wuWzJTGY2pvYsEuDxBxYZibZy/J1JR/3xZ8d8aCUyjaK9v
         KEnfwo1zrWV7zRHaknHfiJnDWtLudW2vsbC0OA0zNg9nE572kKCE8vXNUZWmCSM1flao
         vEvmg124/vs9+ZqfVF8exb4+jUag5L3Wqt2LpDxpYYJXyOo/hV8Sp9+R1G/QDY8RbJ10
         nBgRjCEnRke7WeA6VJm2s1omMqFIJyK0vq31rm8Z/44nYH7lfz+TSOn14/HV3budxW2S
         zmWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1785512001; x=1786116801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XnQ75jYzm8moYl46g1ePyO1gywKf+IeSpDPhO/wg5nE=;
        b=WlLS7APeX/hA7NEpMaOEESuBOy9fewR9hgrNZhDweuEfsAh/zoyTHKGTJF9U9J5tq/
         s847tazcBtQqqpEIPCZXBYyQ3TC7humVlzydKPbO8qx9opWFdjz7TCnoMEGa4QIO2Wi+
         Ahj5xFgBiGOukwhXTPUjJYDHwXCGm1hXlbLknTbkVQvxbQqL2OkPbu3WWjJxOCfQoua4
         v0rgXyVwMwKBUiPTrtFyuoJ3JH1JQYPFRfSarLn5gtHHWLOZnhRsC/r1ro+0psVHAY3z
         /saiuR+VjYl9I0MSElkym7L/BAmicvjWjbB3CcOZUS1cwve44tpIhC2lftzsyegxt5Ww
         Z7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512001; x=1786116801;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XnQ75jYzm8moYl46g1ePyO1gywKf+IeSpDPhO/wg5nE=;
        b=ko89+Tj2T5fy1/YG3N25Z8QWkbhfYpFzDoNKrHUpHbz5whXWXKYrCWeisWoSO64/mc
         FSz5acwZLtxyuCH9nS6ijyCuhfQIApAQo0EEiqsZ8BuWoWN27qaal6Ozb/CarNuRRDY5
         34ZfauVYYHroN/tmd5bj5Ft3FvnMeDQwn/StJYnF92pgVwO/GqYtkot/YXfqbJ5nM77e
         7Gy7GK833R4Vrdr4UZEAiwjCUwv/nOtE6MntGfnlgCdfjnPeZQCnajb49fmVzyTgD+eA
         3cwhT71esywAMuvii73c+PXXLCkKRNgTTA07+rddkxStfrraJgWnadp6+PV7DsIgeBkl
         q+SA==
X-Forwarded-Encrypted: i=1; AHgh+RqB/eVVCYkq9F0Rn4qmCf435HWoqnQ9KMjykBb9CyjO9xs1WjwCkk5Wpr4l7H6gLSks9UoublMo4VdL0zK1@vger.kernel.org
X-Gm-Message-State: AOJu0YyftP5I6AwCwKjdccZmpEr1kLEt3AdcchSuRppBSKZNmal7ec8A
	HFhEWBPmb9vQtm6pjGQd5z4EpuOLsutzNAYUfEjId32BiBwqAlBhHqGSeeqG0vf1vcTmCuWBhee
	j0nxUatzOB+qG7s0hUsrbSQkdzEZuRdDeX9FPk9lX
X-Gm-Gg: AR+sD12arzmiARfjYvYnsNclrIBrzATtYqVZjuAr7KszSmfzqqJEKmK9LfI+P9V2fdm
	2FeOzeyPm8inHU4PdpDC9Yq23qqZ7tMDZAFMy2cNWrzPR3itbYG+YnA9eqKqpstfe2bah6A9xb5
	Ejy8hJPEHkni9s6bTqviUbfIwOodJaGMldpuzRN7Q2j9Nn0J9ltMsZPtupdATCAQm5gq/YkoE+p
	X5VX54xBNWM4HHpmkrGi3ZHThvZzn/FOeVvdhDvXyNLH+ZDhBWE4dZy38KM/Bjae4SczY+fmK+7
	ZLWdeZArwZPt+pW1ktCED8MIKVTI1HrQLWmcCSulLT4R
X-Received: by 2002:a17:90a:dfd0:b0:387:e0db:bc24 with SMTP id
 98e67ed59e1d1-38fbc5225dbmr287131a91.36.1785512001460; Fri, 31 Jul 2026
 08:33:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730234533.1912709-1-dwindsor@gmail.com> <20260730234533.1912709-4-dwindsor@gmail.com>
 <CAHC9VhT=m-GtOZx2AHym7uN1CNx94arKBiXeVC7LTEJ-b=1EVQ@mail.gmail.com>
 <CAEXv5_iiNspub=qE1YW-01sV_bxxFUrrcAR4KV4Ec5i_mePtHw@mail.gmail.com>
 <CAHC9VhTS7rSnBqg00ZxNkcZyh_=EeJmn_4z3CTCCxreEEDtTtg@mail.gmail.com> <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
In-Reply-To: <CAEXv5_iHLmzPT3Jj+qZsdt1Nk_5OD4Up3GGV0S9G7KyQshFhDA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jul 2026 11:33:09 -0400
X-Gm-Features: AUfX_myWZz1m6PowWXy7WcdAAbaku2QnixOSUt9yTgIUfLpwiNvXahY7xKnDbwo
Message-ID: <CAHC9VhQXtV_dGt_b5oD_LFNOygfx=37u6P_S32xo3A5aHvnj-g@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 3/4] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 11:30=E2=80=AFAM David Windsor <dwindsor@gmail.com>=
 wrote:
> On Fri, Jul 31, 2026 at 11:17=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> >
> > Okay, it looks like there was some confusion/misunderstanding.
> >
> > My understanding of Kumar's comments was that he was referring to the
> > exisiting LSM related kfuncs that are located in fs/bpf_fs_kfuncs.c,
> > not necessarily the new kfunc you are proposing in this patchset.
> > Kumar is welcome to correct either one or both of us, if we read that
> > wrong :)
> >
>
> Yes, after another reading, that does appear to be the case =3D).
>
> We'll need v7 anyway to fix the ocfs-related UAF the bot found.
>
> > However, regardless of Kumar's intent, speaking as the LSM maintainer,
> > my stance on this is that the kfunc you are proposing must live in
> > security/bpf_lsm_kfuncs.c to be acceptable.
> >
>
> Ack, will do this in v7.
>
> The Landlock series currently up for discussion [1] is proposing
> placing its kfuncs in a new kernel/bpf/bpf_lsm.c. Should these maybe
> go there?

Nope.  That patchset has its own issues, one of which is the location
of the kfuncs outside of security/; I simply haven't had the time to
review that in full and reply.

--=20
paul-moore.com
