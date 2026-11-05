Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.167.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793897971;
	b=EpezCv/CudSXPhVup9yixPalp9sJvXaw1Rg8W0v8ZqCk0Ib1OAdz/vn1WSe/1AH+iivA
	 n9k+UJiUo/UdTK4J26fWjG/eC8jFbytwofWwxLZ+v8bF15l6WZe9vvLjgSKySZybpPv6J
	 cHm3861S+LN+cQpszXOvgixIKpy/dDeg2VNpKNuFTd+bqlvF+AMX2BZvgNB3cIhN7Jwrm
	 PwymkwaXealPjwdGpJQeTqLxLn7vrWTDjelxsqlIYJfpYVJwx8S3OzYJzcSy0c12sFufP
	 RQwacUzpY7Tz4aPJ5mMCMERAkgmXbGt24xS1XbmR00KrakoDFXGFGevTLPIfPptbSBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897971;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ENTWrgdqNOnhBXm7Ydoc9z3n/Zlmn8Dt6MNiq3/7nzs=;
	b=WY7Zveha0FLpBv2dkIai8wzxMygwCCScau7Kmwu+1UTlEA/QQQuQuSem8bvL6pILPr7z
	 0PyaV5Bcf2SaAGHpge+PVEZvZgF3PutAU+OwlJMm2FZZiQBci9F3aiVvONvt6ZeAf3WEw
	 F8cb3iCUw7l1GPTM2zhcQQucQYG4FmBQZHzQU6tGAvrYTe+3PZgp4dD3nUeKijbcKWj6C
	 +Cj83yhkd36wpGdKCoNXILNGcY33/WgKwdi1IgxtTwqa0In5rkNbneoASHGMWpeTVu5c9
	 UbVHeCmn3TcaHlOx0CkymZK1kjB4rr175csUd45niKt+C8BrcniioK+t9VCNsry7MYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=M4rBHBr6;
	arc=fail smtp.remote-ip=209.85.167.44
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61510606A32D
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 16:59:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61510606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=M4rBHBr6
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5ba36cc21cdso2074850e87.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 08:59:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793897969; cv=none;
        d=google.com; s=arc-20260327;
        b=jV2fNxXuPkiCYvQCwqK2V+DJvnpvu+yvB/DDBjDY5HHt9KSiOe6dwpHdD8J+qL4BF1
         frWZUEpNwwt1AB4Jkk3zLwwVaY2Hwo6KpEqnR8Lg5tw9DMriM4Wak5W16RYq1L9+fd0s
         zFxyCgEpQEDJ5iBvma/91HqTNV+P1XTwA2Gsj3lwbDJPF3dpRsbW2BT3hRNAI86kZMEo
         sW7jijQP9/S0kBRIHgF25yxczVh8aU6yxKFDK55BatIfR/WjeG5qVIpaU23RmE/2XBWI
         GCEDESMrPQcb3BHCheiZTg7Ocm63/vfqpDtnvHkDziQ4yEdStFXODBB5uZxKZM7n9lCC
         e/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ENTWrgdqNOnhBXm7Ydoc9z3n/Zlmn8Dt6MNiq3/7nzs=;
        fh=4BqrLw8WptFYRDqshNNdmNthDwJdY0qukpyqqHLOdts=;
        b=dXSkd0dZHA15isfpY2iMDEVNHJCSbcjo2s1QGaHFA6anpHltKWNu8JQ0+lsOM6tgc6
         1zcRuWXe92XvBEWK5MVIEpO83BGa2mYfqgLCGwdsKKI8mIFAlaxq7tcitXxpktAMGBw+
         dOm8CZzbnMqU0AzwQ08HyMyhyXSbBzMZz8MBugA3kj/P8sh+ug//urfMlhQnd6USrLZ9
         UMgYnIEG0f/sVlt2RPXj0S3EbtgdCzbSnKMwzD5AnJrlhZ3LO9nVM86KUHkmAPL04IpF
         +jjPoDCiT3d6Q4i9TQC0Wb5rBKjNLId7TomIQ//UcfWz4CFZYoWZZaR/mSNyb11EyO+X
         9ypw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1793897969; x=1794502769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ENTWrgdqNOnhBXm7Ydoc9z3n/Zlmn8Dt6MNiq3/7nzs=;
        b=M4rBHBr63W/SAVwNNbCQfErkFQNKWB1qkv3HtqteP54rOiV/HHnDMbtUKJCArIzFu4
         mYj0S1RcIb0q9pNYYwzfkrgcW/4hpcfT9cokBuN88bZN0gEMLrtAd9p4+/Q1wKWLERCs
         DrW00xbJ3OukwQpHPe/em0QG+3GlYH+g3IYsga7TvOEBXsyzoIivcIrFXjcPfBtQMsJx
         dhhKFMCZQePt2r/MCoc/hvcGaP1eaY7HE+KfNY0jNPytwrHw0Re5wyWLV4CIYYEeqBaz
         M8PdhqQP2K58xdjOL5tlAIrLEOG/UBLGLNET3to0NrS8A3suRDOPofJdLYHDtzflD6hB
         0Dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897969; x=1794502769;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ENTWrgdqNOnhBXm7Ydoc9z3n/Zlmn8Dt6MNiq3/7nzs=;
        b=hfZ5P2p2HYeye5ja19Tw/GoEkOX4Snl8+4K8lFurm2fpABVpH71voZy4IZ1GTM3J54
         CE+7pLPQh9ciL7/FrGJTDc77ApCyB79MR6TBz/elqKzri74OmJfk5gKSHTawe3/FMpnx
         lc/BQn+VJ0NvSac+0lJEhBDdudN1IyCM5HfFVvb9gxr6evVF2WYkV5G5rtx7gXwxJUFA
         RRR+gysI6c9mmH52KTHFUFpTechk4FU7tmt5IgNFLXZ31JVATyLIRwK3w1X4JQR+JlRo
         uEBqchXDjL41Y2HNjPnmqb1CDaXoLMpMtyM/NAVOGNSgScm2ZT9cbC3zOmOEI8Xko3wA
         1f6A==
X-Forwarded-Encrypted: i=1; AKwUvBzMNQm1rMvLiTxoOVDnZ62q3LRSASns5mOZpUH475TB7SJDEHdpbAH/9CbdjPR4IN9Lw7jJNRjL9pXUFQnR@vger.kernel.org
X-Gm-Message-State: APuU4Z893tldZ74WqAXkt8QmKHJNSgJltXT1Wi3kAfNmTWo365LAZRXl
	DM1omAP7fZLgzJmNpb3n4cFEbjPv7ROidDvdkv3JnMy/1ZcgFnHexZk6co7AamZ9oxrcy/Re9BD
	X+ebGwYScoEIiDdw68LTcqoAvevgB2KQ/f94dRSzl
X-Gm-Gg: AYBFou2y7aSDQYQMg3pXJwmNGNwjFZMihXPVDGlnSJOPW0fL3Ov/sFQnsOCCROM11fk
	frzbzbgpH+4PcDsNoT/nqp46vSsvN3HnCxcU7DK4YW15O3CGMnv29j/PsEHs+DweByas8aVV9/l
	/1ShYfTO2d6I3vtGmPosto0oC8aqwI7yW758el5q0DGnS9sOCuLNiCSOm64Cyp5CqC5zOb+rkWa
	anSHcFNO8lehcOdb9hw9TjDKmGPQWQA+NnKhZe+k4a3NITOTNW8Doacw6VI/1Usc0SlQr3dgyvy
	M0SDMAn9yu7wW5rUHaTmDchDm3qAGukyRagSWnEHr4b8HX6HJ8jm0DQJMIbJqqwALJWvjxS0LcO
	vd76M7sUExbjARO3E+hWJhEeQhnqSTq2tmg==
X-Received: by 2002:a05:6512:3e1c:b0:5b8:f97f:7a22 with SMTP id
 2adb3069b0e04-5bfd957683fmr6945728e87.54.1793897969539; Thu, 05 Nov 2026
 08:59:29 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028221705.3915340-1-halg@google.com> <aunVmg42/S2uUDWR@hallyn.com>
 <auyink594bxptAPN@google.com>
In-Reply-To: <auyink594bxptAPN@google.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 5 Nov 2026 08:59:17 -0800
X-Gm-Features: AclHuK99RUxjga4Yt7Cih1iKUoXn780fqABuH5tRHwVrGa5--KTUob_Z762ltig
Message-ID: <CALCETrWaFf-X-mD0moxqaqEDWOV+85geK2B2Rs3ArixKd=Ntfw@mail.gmail.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
To: "Hallgrimur H. Gunnarsson" <halg@google.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Jonathan Calmels <jcalmels@3xx0.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 7:48=E2=80=AFAM Hallgrimur H. Gunnarsson <halg@googl=
e.com> wrote:
>
> On Tue, Nov 03, 2026 at 06:37:46AM -0600, Serge E. Hallyn wrote:
> > Generally, if I, or some users I support, need to use unprivileged cont=
ainers
> > or user namespaces, then when an 0day comes along, I can hopefully trus=
t them
> > not to exploit it.  The biggest danger comes from the fact that, right =
now, if
> > they can use them, anyone can.  So if someone can trigger some other co=
de running
> > as user nginx or something, that can become a root vector.
> >
> > So what if we had a built-in feature or LSM which implemented a credent=
ial based
> > whitelist, entered at firstboot?  Something like
> >
> > ```
> > # Default deny
> > uid =3D=3D 1000  # approved
> > 1005 < uid < 1010  # approved
> > gid =3D=3D 1005
> > security_label =3D lxc_user_t  # Not sure how far we want to go with th=
is
> > tty # must have a session
> > ```
> >
> > Now, if you want to use user namespaces for generic sandboxes for all
> > users, e.g. to confine browser activity or nginx modules, then this mod=
el
> > may not fit.  Or rather, it might need a few tweaks.
>
> Thanks for taking a look and sharing the credential-based allowlist.
>
> The latter scenario (generic sandboxes for all users) is actually the
> primary use case that I'm targeting. I want to allow unprivileged users t=
o
> create user namespaces, e.g. for sandboxing, but without granting them
> security-sensitive network capabilities (CAP_NET_ADMIN/CAP_NET_RAW) when
> they are not strictly needed, given the historically high risk of local
> privilege escalation associated with them.
>
> The two approaches target complementary layers of the problem. A credenti=
al
> allowlist at creation time controls who can create a user namespace, whil=
e
> this patch series controls what capabilities are available inside that
> namespace (and its descendants) once it is created.
>
> Gating creation works well when there is a clear boundary between trusted
> and untrusted users. However, in a multi-tenant environment (like a large
> container fleet), we generally treat workloads as untrusted by default.
> Because we still want to allow these untrusted workloads to use unprivile=
ged
> user namespaces for sandboxing, it is essential to keep the attack surfac=
e
> small and follow the principle of least privilege whenever possible.
>
> More specifically, this patch series enables that model of safe sandboxin=
g
> across three key use cases:
>
> 1. Configurable capability stripping: Administrators can enable unprivile=
ged
>    user namespaces for all users to support sandboxing, but configure the
>    system to strip CAP_NET_ADMIN and CAP_NET_RAW by default in new user
>    namespaces created by unprivileged users. Basic sandboxing rarely need=
s
>    these (except to bring up loopback, which Patch 1 addresses via
>    CLONE_NEWNET_LOOPBACK).
>
>    The per-namespace bounding set can enforce this either globally via th=
e
>    sysctl, or explicitly via clone3() at the container manager level. Thi=
s
>    restriction is monotonic and persists down the namespace hierarchy.
>
> 2. Selectively granting CAP_NET_ADMIN: Some containerized workloads
>    legitimately need CAP_NET_ADMIN to configure advanced networking for
>    sub-containers. Because an unprivileged creator's child namespace is
>    bounded by:
>
>      parent_bset & (sysctl_ceiling | creator_effective)

Right after sending my last email, I had the following thought of a
variant of the model.  Permission to gain CAP_NET_ADMIN via creating a
userns is kind of like a capability itself, right?  We could get
pretty close to nice semantics if we allocated a capability bit for
this (CAP_USERNS_NET_ADMIN perhaps?) and, by default, giving it to all
users.  Unfortunately, the latter part is tricky because even sticking
it in the ambient set won't keep it from being dropped by setuid.

Perhaps we could have an extra capability mask that is for default-on
capabilities.

The intuition for this is that permission to gain capabilities in a
userns is a mess if it's a sysctl (as sysctls are global and there is
no clean way to say that a particular unprivileged task may
nonetheless create namespaces with CAP_NET_ADMIN) and it's a mess if
it's a securebit (still has the latter problem), but it's much tidier
if it's tied to a task.
