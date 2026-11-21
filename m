Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795220445;
	b=40N5TseVtfTg3QCPRbD1zzYuwQ8ifPYFGVJX4yOiXx7dVV2IwOj9ERe07WvE8h3ZjBYv
	 bUJUXmzBATFg1ElhKftBA2CyA6fge9jJ66O/YYc4CrhkXNJSicDvLQPk18cxQuNPaydyR
	 JAAhQtfCIfkX9i1i/Ka9MZFj8jYyQWzvfrEfIQXOfrWgC2m+no1Em4ENg1nAEg1vu+gW4
	 q/Wstl7xQo17WqDxgm9jyZv83O/lXHGxLMsX2RAmuG5SdmWw1V5m9IChSKQt9OLf87/dC
	 BC/gzlqiQLbxMLfHJKnjQt0brD1GWBeirdd7IUap9cltbvdpQavxoKbwad8y3dQ2Ggw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795220445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=oTW1ECUqKZPFZMGwmFF0XG/dMWrRIOOKKmtz6Ts2T3U=;
	b=3Bgtk3dHl+GxzlMKk30zL1gxE2sD4XQWnpYwn9+0Wk8vfX8VcfCusGQCYtfezevW9Ye3
	 HwBJZtDox/QcjWkT09KxhWmwY9xZuufrCQrsBE1xdAdl6ACbnNNgURl0KzS9VdgmdAzaf
	 xfszbsSRL7XiLpR8m4beDm7IjQfqssISnOcQcAoKCSIg1HDHCRaU8A8p4l41+RJY+axFz
	 Mj8+zmJtFKIlfgmqPFEpIwPEBHUFnpBzr2mGZqHYg5n/RpJcedjHw4gJMU1Ygg7aW89hi
	 1EVjL748RT5W47v8LVWiRvU6kYMAtdkvBCEPPh9KOHh0UbIoVRl695evYCTM+1fTHjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=LklpZjfD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474F8606A696
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Nov 2026 00:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 474F8606A696
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=LklpZjfD
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f03f3631b2so8558695ad.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 16:20:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795220442; cv=none;
        d=google.com; s=arc-20260327;
        b=eLcg460dBDkuzpsTSSRufuhmffygpOoqFcb4RTEzeaJ0u4QpERvqMfxqiOxkg6N+DI
         QVc3VYtcjvbdEP6cfzx85yq1VKecdvj99Lp9rGt7nttUlnXrAkFuIrZsmJyh3OUBz7Ez
         UtuxLhguE4yysLfG01U+mYtpUQ2a6d7nzDjWWIGC9w6GUQcxFwO+Yj2dtCtrj3Ru4rWO
         nbu7CcLPmtflQ1ccuYri0GPIEHQLFdYiVRfNllqTzmJ+gor/8nCCmugweBqAkz6cHfRj
         weDhduxXn9uhEpJVS1jlkoPRZnDI6Xg/O/dKuJNwrhOFBua0yRh59BDh/ih0Ek8ZMaHW
         NAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oTW1ECUqKZPFZMGwmFF0XG/dMWrRIOOKKmtz6Ts2T3U=;
        fh=xdSYuYbJRnYGhkHKQ2/XSxXOHHWisyWq2CkO1Bo1zC0=;
        b=FiI2QVo7XEMUFAXqkJT63wOIYk2fdT//0GQwISyBC/fRleESFzUdcvyi0tXdoYL6Ou
         LMypa2VSVqtW1z1GWv/utwx9a6gwNjVXYasIsT8JijUSyOl+sdGL/fiU5T39EgoNQxMG
         2CziPFh1U4uvmxuFo4zs2CnGXiG3m0Cmj2BFP1QvICfG5a2Y9/OZ+rgM+x03/7u6iNDv
         FJctpR5pVlVXB4hpbgZqvibq4JBxevZODggHeWUg2Vmo8z/NzRmwnoJYKUd4foZeo4dU
         Kdd+P2XMl/5Zbh8MkQgEWSNxJLERnmRR3UW2ntSWOvgalIfrgAb3MLBszD6NKC8ZEBvd
         2TIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795220442; x=1795825242; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oTW1ECUqKZPFZMGwmFF0XG/dMWrRIOOKKmtz6Ts2T3U=;
        b=LklpZjfDtnvNwzndHIjW8ZNQ8zMlt3I98Fdj6dWCKzaDJHMX2vBYb0r30EuTxy9M06
         eQGhuC7Yd00TmtaxH7l61w5nkPpoOIydtVskUsiv/RWg/4GHNeQZO7yXThSxIg/cMJvq
         s55skHl3XgM2Hjtfb2lXYxlXe5AyNPaWs8TDCRw2j2xcvkU6RSPUD6Qj2LEElOHa+vRt
         Ke+/y0j0acY9FV8MnSNLvTrorvLnJ9CFyO7xdWgnxq4unh+56/00JLLA9wfiUbOJAafX
         uJk0bi/Qov+0va5b24OMN8H+By8PZUz/+csFTkmKtGJ2Y66fsZIybqh8WSdpGQQaP42R
         PWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795220442; x=1795825242;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oTW1ECUqKZPFZMGwmFF0XG/dMWrRIOOKKmtz6Ts2T3U=;
        b=2mv1sMO1F5ZZf3Ux/vO12UKWikfFfJT9yWVTEdds+eN/V9mmUFZoNAJVmJ/i2+6sAM
         9rlmPETYD96wT//v0qwd6yF5jAZPYfJABL3ilhU+e/1DmoSNj5a7F3Q1gI+RjqjK4QZT
         TPWe0GuxbD5PSjSRhyc94J56jRogO/MlWscxIc1dDRtiOywo0uLYJTuhyK+0jxyPW6vy
         7bA+WWWgshaPA9kGDscp2kdTrQ8SdKm9GA+8Y2t9KjGJrF7yMWDvXJ+LDFXSooKnQbPN
         HYnUOT9FSoWdc0DwWxxnvwS5tPXIrbjxxJnqZ6EQmi+AGMoVuvUZ/ZkZXpaj6+scCqm8
         d9Yw==
X-Gm-Message-State: APuU4Z+LJn9nt/pzZ8nHBqlENKFozC5CZKBIukH35XwxEZdylFYW5stM
	6xndgg+dxbotFA6MPC6sgE8y+EizI/owObvZ7krEtLEpctl/aBfFdL3WsKn/afNHCx9clPqDp0S
	IN5OU96ckZ8Ib0GDLrOXqsR+Quo/lFS0zMgUoNV/B
X-Gm-Gg: AZFdTZczngwb2PSU2FHafHsSvRrTuGWrrUgOAA0lX4igt9pewthAU3yD9LoRBV4Q3GX
	PB/tuTViVnBL3SociYKDBoo7EiIdNvCQVK45Ii2Lx5JYYFSbeS8j/2SWyEzBR2JXsHwD3qW6L6r
	YiT8CBIVrqyO27F3xfT+Ib6x82b7eXJArCA7mhNTM7yyCaDyzbFbzkZ6HvwX7cwEEfcUaHozDkJ
	XE6Kep7zVZv0s0Kh0ngwmke6JEIjB7+aELEGVfwVJT+lI2KknI+rWsDltYNNbfXEWtBeNBcIsB9
	slcdTVGU5dsm7C+3lYJgNfKRIiqe6NjpmK6DzLdDwZayfxag92qbEoarcp8RAIJgD0wmuow6Qe+
	8qNtDLnSn6vj42EC8qFb9xKiRgLddLJQg3+LWcd1m/iERsOmO0GAIzEIz56DPypDQ+31y
X-Received: by 2002:a17:902:e811:b0:2f0:22b2:bfe2 with SMTP id
 d9443c01a7336-2f03f201151mr45499255ad.31.1795220442596; Fri, 20 Nov 2026
 16:20:42 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120-work-ns-mount_subtree-v1-0-06337377f94a@kernel.org> <20261120-work-ns-mount_subtree-v1-2-06337377f94a@kernel.org>
In-Reply-To: <20261120-work-ns-mount_subtree-v1-2-06337377f94a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Nov 2026 19:20:30 -0500
X-Gm-Features: Aa3M54rUKAyhudO_NMmwLoQSP6nA25xTN_t_G9kBgfIIkvZyJM13Qz-1vfwego8
Message-ID: <CAHC9VhQrbBEX7tHtCUSPGgUqLLObCdBCRPkNLgDdtcgxTC3V_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] ns: don't call the namespace LSM hooks for
 kernel-internal namespaces
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, bpf@vger.kernel.org, 
	Zhiqi Zhang <zhiqizhangg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 7:30=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> mount_subtree() allocates a private anonymous mount namespace so that
> automounts triggered while it looks up the path have somewhere to go.
> That namespace never becomes anyone's namespace and it's gone again
> before mount_subtree() returns. btrfs goes through it on every mount:
>
>   btrfs_get_tree()
>   -> btrfs_get_tree_subvol()
>      -> mount_subvol()
>         -> mount_subtree()
>
> and NFS on every NFSv4 mount and whenever it follows a referral:
>
>   nfs4_try_get_tree() / nfs4_get_referral_tree()
>   -> do_nfs4_mount()
>      -> mount_subtree()
>
> But __ns_common_init() calls security_namespace_init() for it like for
> any other namespace. Since commit 15dd86021b57a ("landlock: Enforce
> namespace use restrictions") Landlock enforces
> LANDLOCK_PERMISSION_NAMESPACE_USE in its namespace_init hook. So a task
> in a domain that handles that permission without allowing CLONE_NEWNS
> can't mount btrfs or NFSv4 anymore. mount(2) fails with EPERM even
> though the caller never asked for a mount namespace.
>
> Mark such namespaces as kernel-internal and don't call the namespace
> LSM hooks for them at all. That includes namespace_free. Currently
> security_namespace_free() only calls the hook if an LSM requested a
> namespace blob and none does. But we shouldn't rely on that. Otherwise
> a bpf program attached to namespace_free would see namespaces go away
> that it never saw being created.
>
> The anonymous mount namespaces created by open_tree(OPEN_TREE_CLONE)
> and fsmount() are handed to userspace and keep going through the hooks.
> Landlock covers them on purpose.
>
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Reported-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
> Closes: https://lore.kernel.org/20261114141323.19029-1-zhiqizhangg@gmail.=
com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/namespace.c                     |  9 +++++++--
>  include/linux/ns/ns_common_types.h |  2 ++
>  include/linux/ns_common.h          | 20 +++++++++++++-------
>  kernel/nscommon.c                  |  9 ++++++---
>  4 files changed, 28 insertions(+), 12 deletions(-)

...

> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index 4438c6b663f91..20fc0d0e98212 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c

...

> @@ -66,6 +66,7 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type,=
 const struct proc_ns_ope
>  #endif
>         ns->ops =3D ops;
>         ns->ns_type =3D ns_type;
> +       ns->ns_flags =3D flags;
>         ns_tree_node_init(&ns->ns_tree_node);
>         ns_tree_node_init(&ns->ns_unified_node);
>         ns_tree_node_init(&ns->ns_owner_node);
> @@ -85,7 +86,8 @@ int __ns_common_init(struct ns_common *ns, u32 ns_type,=
 const struct proc_ns_ope
>         /* Allocate the id before the LSM hook so it can track the namesp=
ace by it. */
>         __ns_tree_gen_id(ns, ns_id);
>
> -       ret =3D security_namespace_init(ns);
> +       if (!(flags & NS_COMMON_KERNEL))
> +               ret =3D security_namespace_init(ns);

We try not to make calls into LSM hooks conditional whenever possible,
preferring to leave that up to the individual LSMs.  In some cases it
isn't possible due the state used for the decision not being visible
in all of the cases where it is needed inside the LSM, but in this
case the flags/NS_COMMON_KERNEL state should already be present in the
ns_common variable passed to the LSM hook so we should be able to drop
the flags check and always call security_namespace_init(), letting the
LSM decide how to handle NS_COMMON_KERNEL namespaces.

The LSM could make a similar decision in the security_namespace_free()
hook below.

The update to Landlock's hook_namespace_init() should be as trivial as
the check here.

>         if (ret) {
>                 if (!inum)
>                         proc_free_inum(ns->inum);
> @@ -106,7 +108,8 @@ int __ns_common_init(struct ns_common *ns, u32 ns_typ=
e, const struct proc_ns_ope
>
>  void __ns_common_free(struct ns_common *ns)
>  {
> -       security_namespace_free(ns);
> +       if (!(ns->ns_flags & NS_COMMON_KERNEL))
> +               security_namespace_free(ns);
>
>         if (ns->inum > MNT_NS_INO_SPECIAL_MAX)
>                 proc_free_inum(ns->inum);
>
> --
> 2.53.0

--=20
paul-moore.com
