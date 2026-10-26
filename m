Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793046699;
	b=eJwovL/2T2xi4T19A/ki4aqOZVxsQ1Jr4zRzM4aheGEXtHsMAtnQcNINSx+VIiuOFPD7
	 R90cjozLbVaCAU/cI2jjt9Yv2tb4otXMwS/qtd6/yJLYYekSbHXsXHpSiF0RuQl4eGObK
	 T0Fkp6zy3Pz5v8oWLGl1vctBSN80mzs1XnjKkBBIjc8JBccKnQ6CdMOooe25tPXWzfsbo
	 wH19QlW4jWHaRDDJ6wegHZlkqxLc0Gwso7LX+GzpKOiGII20PNmncGlUnTutpAPIF63Ck
	 1zkgHnEdP0lo/Zm70+fqmEJrInJkuWFEMdSai3O6GOP1Dx0KNCZz+gQuY6tvMASDU4A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=oLlOcSCQ32pMuVJGiKdjmwfrqV55t/QVJ+mNxxfwt1w=;
	b=1yJG5/uCR62drM2Jen5aztZw8FgQD+LgsM7T4r7YwlJYTdIjyvfA9qkfjR86O7zZRnhH
	 /ekOO/espb03nGTF6iVeRFWapuynjmNMOGWotdZ9DXz25nzTtvZNrQcB/2KA5H4OdwHWH
	 Iu9yOWoZ5dQUKfaEMu+FNXF7lcL2RXjD6b9nuuOqkiIiyPzsvSXsebf00b2lcDsiV+IGd
	 3TC/usbZZAeGVllye51Ztlyw2IgTECCBpvtizJW3/pqzE15OtORWiSW2m7I3dva3fUx4F
	 eW3IX5drmXSQakzkRspzhUEAL4ld8eA/Ge9dNTf8GeYfG18/AGvuzrc32xju5TZMQjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=L+wootqW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D3B606A31A
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 20:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94D3B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=L+wootqW
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8246b13cbso30312085ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 13:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793046698; cv=none;
        d=google.com; s=arc-20260327;
        b=sAxKKM4jo+F33Z8Pw3JB2fDvxRxJa2MphnUDMpQV1C+kgFxD4cb1qIGRHsY+/kmd5i
         4TuMt2zcTBUtZF1Np9G/j81ZQyP0c5KsjDDwEg1xgwlJbL+BSI3jTLn0p4YapySSgcP0
         sYrT2zjQwf4fIoobkX/PaZLD3ByU3e/7nbvHPz+sxr5ljgVBHFCb9Hc6epirEYtecMNZ
         4nMegt3ff3/nepd+oFq5PGcPSGV4mV7qS0ZM0I/G24VQ4lyA7XG1vf+eA5IdJMDHIifc
         NcZiR2quObz/OjuMc2oMsvdlSnn5ofXm35CzrkYv5UpxKu0g4WpC4XxXnJW3aYR+je1/
         UvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLlOcSCQ32pMuVJGiKdjmwfrqV55t/QVJ+mNxxfwt1w=;
        fh=JbH9auQTjv+lhcKDipyCaKb98OQ4p7gHQEfuMatDpIE=;
        b=SrhZ6mDwRpclkGLVYCx/48docTXCTfBGyXnkxp3ldR0+7m4+kS2CcSysiyB4MNVMLi
         8jDjeWZa69pdIZ+l1oXvUZdlQdQSbN2Xib5B8UYhyf4OaSdQdMA3MoCrO8IiotzInPD0
         2c5j5ISDcZylWn81XGWru2K+wLRwDd6nh0FDiNjFBqATulULQMCexoPsS/wzxtLhw1VC
         HKMttz14vB9Lyh4sYYnpZhGINt7xstMGbQviphBdPzMAGNSHltB+Vq97LY0F9ShBo8Kj
         jdXEYfojSlJWuMQTJuUpXh1XKAi+O+Y2OhcbNVTDMbet2+ksPho8cOrV8rmi+XXpOx02
         UqJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793046698; x=1793651498; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLlOcSCQ32pMuVJGiKdjmwfrqV55t/QVJ+mNxxfwt1w=;
        b=L+wootqW5T77UGOryyw3TrOnPRmPjLL2i4uoI36Fb52hAChavbUjC2oAErcwcWcJq1
         gwgn++rWkrUiN4eZmtVkxuIBOAsAZefl8wqr6EQCDZZBTjk1hO2UkuEyI8i5m5RjX7DJ
         EK1ndGeANRMX4aTbpO+nvR7fIU63VxFQ9ffp4FXCojFjYD+fdWAL9RHBV9A1L4pnrwWe
         CwArxDWTNOmGZ0DS0oKM86YGqSE9zdjWjrY330iiwsDo23ENOID23IQ7tNUIGTMjbHgT
         BUbvwez+Hzl4lCCb8TSHKJZNqHNNnbu8YjtxV98iTts8xUYoVruc0kCp8wqVv0S6jf5w
         /EUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793046698; x=1793651498;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLlOcSCQ32pMuVJGiKdjmwfrqV55t/QVJ+mNxxfwt1w=;
        b=pdYKWDKgYCOJedo8FkDvKwGDF+q6ciCAZPm+7QznktiaGiHGmZsLHW4ikLr5L1OAsY
         AqnAeLpb9/pKfHNAwGNxlVG/Qf11S/oTv3CFIGH/H6mEyw8R1FVaQ5TuI9gGp0Xwep0u
         0So9XRTf6HEk4SYKQImufGLUwHfan+QFAiwOjBGF7brr5K4OpYa4Ko38Ou2j+oBUUUr6
         KNa6wsMaWGvc6IqbHEH+gDngeSEfTvEBIeWgO05efG3stWwqufsuH2PRvbrJ0vVtqMkk
         15r1Af5wF5QphA2TaPm6gUQg6fF1bZhgqcluRhyqrGXek3xbaHO+F9CLRQCjMaUTeSip
         LUqg==
X-Gm-Message-State: AFq9FYIHoBLh3myiSuoGIA1UweBZomMG5ATbfi0Y5SwZaizC60vHFDcb
	uqYFVP/RB74oiUdz7DMzDU6Ofxhcxl/QQ3EODDvnqUiAEvhwBsSoXdKymMpGFNob69Rh0bI4d9f
	htqk8lZbB9v6Zh5+qqOJSMkRUn1V18A5e83fUqqWY
X-Gm-Gg: AYBFou1GBUiAG7fjOn6CrWVO/Ij4y9RU5OUj4YYOAxI1ui5nunIoTWoZuJTHwZwqIY0
	oSaBzQ1fRJQ8mwAJ/+FAXBEklzTyeOTGUSe+zO1IHoDSihC7Fb6IqYro/9bSXPjuX4ufpjHid5O
	Rl7qEZIPcs/Mqwis5NBh57BvVqija0RtmFNS1bqeJB4W7AUSWql3RGeZQwsJUZPn4EqF0nuVfCp
	ff5h+BQacMBRbN2VEy4QBlYrdN/5dkViY0T0w/nyP8sAr5hsvRsTVPxGuI47iZngSZLotfFOruB
	xedT6bbSmKQ+QDyrujCDV8BHgDsfBfeMsEtICyA7BWnf8QSmdhYPQck7o7+81QMzaLcV3udIUkQ
	R5WA4Lsrx4ke9nK+kw6UkuWz5AyTYhihDZC5HvSb17H5txmNdBDijDkX819TjwSvmCg6LGR46yj
	+7Ni5JRLkYJFLv2A==
X-Received: by 2002:a17:902:ecd2:b0:2e8:30dd:523d with SMTP id
 d9443c01a7336-2ea9c620609mr71569325ad.13.1793046697876; Mon, 26 Oct 2026
 13:31:37 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
In-Reply-To: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 26 Oct 2026 16:31:25 -0400
X-Gm-Features: AclHuK_MBYtdpmV00LiIGiHwgdDyciJ8YZFfqnRLK0ynU1qoZWOLvejR9vdc3xM
Message-ID: <CAHC9VhR4rMydWiD-RFv-ABiYSG_txJuyrtdaowEXPY=CHEvFXA@mail.gmail.com>
Subject: Re: [PATCH 0/8] ns: fixes for the namespace LSM hooks
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 5:57=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> I tried to switch systemd-nsresourced over to the namespace_free LSM
> hook that went in this cycle. I explicitly developed it to work nicely
> with that. But the version that is merged is broken for that case.
>
> The namespace_free hook is never called. security_namespace_free() bails
> if ns->ns_security is NULL and that's only allocated if an LSM requests
> a namespace blob. Nobody does. Landlock doesn't care as it only uses
> namespace_init and namespace_install but a bpf program attached to
> namespace_free never runs. And it can't work around that either. We
> could make the bpf LSM request a blob but that would just be a way to
> make the hook fire. So call it unconditionally like we do for
> superblocks, files and bpf maps.
>
> The bpf LSM also marks the arguments of namespace_init and
> namespace_free as trusted. Curiously that patch was also dropped.
>
> namespace_init is called before the namespace is set up and if anything
> fails afterwards the namespace is freed without looking at its reference
> count. namespace_free is called on the way out. There's no kfunc that
> takes a namespace yet but once there is one a program could take a
> reference to a namespace that's about to be freed. So add both hooks to
> untrusted_lsm_hooks.
>
> The namespace_init hook also always sees a namespace id of zero because
> the id is only allocated after the hook has run. The id is the only
> identifier of a namespace that is never recycled. So it's what a bpf LSM
> wants to use to track a namespace from namespace_init until
> namespace_free.
>
> The inode number is recycled way too quickly for that. So allocate the
> id in __ns_common_init() before the hook is called. Then ns_tree_add()
> doesn't need to allocate ids anymore and ns_tree_add_raw() can go.
> Landlock keeps logging zero for denied namespace creation because that's
> what it documents.
>
> I'd want to get the first three patches into v7.4 since the hooks are
> new this cycle. The systemd change I have for this uses the
> namespace_free hook whenever the kernel has it. On a kernel with the
> hook but without the first fix it would never learn about dead user
> namespaces.

From what I'm reading the LSM framework patches don't meet the typical
LSM criteria for stable/RC fixes: there is no serious bug/panic, and
there is no functional regression from a previous release.  It also
appears that the existing Landlock namespace code still works as
expected.  This looks like one of those unfortunate circumstances
where a new use case wasn't tested thoroughly enough before the merge
window, so it can wait for the next one.  We've already identified
other LSM/namespace issues that are targeting Linux v7.5, the
security_namespace_free() change is one of those as far as I'm
concerned.

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Christian Brauner (8):
>       lsm: always call the namespace_free hook
>       bpf: don't mark namespace_init and namespace_free arguments as trus=
ted
>       selftests/bpf: add verifier tests for the namespace LSM hooks
>       landlock: pass the namespace id to log to check_ns_type()
>       ns: allocate the namespace id before the namespace_init hook
>       nstree: drop ns_tree_add_raw()
>       lsm: fix the security_namespace_init() kernel-doc
>       selftests/bpf: add a lifecycle test for the namespace LSM hooks
>
>  fs/namespace.c                                     |   6 +-
>  include/linux/ns_common.h                          |  16 ++-
>  include/linux/nstree.h                             |  29 +----
>  ipc/namespace.c                                    |   3 +-
>  kernel/bpf/bpf_lsm.c                               |   2 +
>  kernel/nscommon.c                                  |   7 +-
>  kernel/nstree.c                                    |   2 +-
>  net/core/net_namespace.c                           |   4 +-
>  security/landlock/ns.c                             |  11 +-
>  security/security.c                                |   9 +-
>  .../selftests/bpf/prog_tests/ns_lifecycle.c        | 145 +++++++++++++++=
++++++
>  tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
>  .../selftests/bpf/progs/test_ns_lifecycle.c        |  88 +++++++++++++
>  .../selftests/bpf/progs/verifier_lsm_namespace.c   |  38 ++++++
>  .../testing/selftests/bpf/test_kmods/bpf_testmod.c |   5 +
>  .../selftests/bpf/test_kmods/bpf_testmod_kfunc.h   |   1 +
>  16 files changed, 314 insertions(+), 54 deletions(-)
> ---
> base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
> change-id: 20261026-work-security-namespace_free-7aaf89b5b00e

--=20
paul-moore.com
