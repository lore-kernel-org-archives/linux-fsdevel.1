Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183391;
	b=0pbeKE026geR/H3h7m8pwib2ScFZKYsIswwlaWw63YRMKsAMOZfnFn6Ic/T/H91O3lqV
	 kRQnmKznTzlumMdRyX2v7lgwovxTwxiNPTo9RaEKb1CQYOGMtRjXbeTx7JcrWmp2tWdw/
	 U4OE3HxS+dBc9aVK8nYXJksp7xWHYL2lsPPydsoLNsbvlM40/xFafX49M9ueU7xoVBuWI
	 GtqStmNOEamVJAM2f4UBi+2IK7XHvvcMNGAWkvuK8hWQqpUQhxLKNJoUXuS8g719jYTld
	 JIjHJHBA/953/KBP4TBteSXAxezcvkNlG6PHFKblLM1ksCp/x41HoCx47n6Q1QYBdUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=D98RljPeJIlkIJBWYWPihvZLS/ylF7xKs07IaIfeuMA=;
	b=Yp93IssG8QzTC5ZrEuzmKnUClAu10pWj4dPvF8MVuYFk7nBQhQdTQu2CHGWP+mwoziG9
	 ChjOZQFZqLMBfyS/TH1eUrINqfMXb7HcGT/YROqL8aIYWAMbXUn7WUhfYRNcrWao3DjLN
	 u+PanwjotUFIz2UEEdbQjTS36oSuv5pKYZSaQjF43H7HG/xqihi/w9sduf7fJyrQ4R07z
	 Xx427lbLRt8ISDnGmdqQFvH7oWHzQO2kH/Vxho/xHvrvCV1mWJZMC/8Itmpqos1ttb/qn
	 XKKt3HC0/k3Jnd/EMIkHF+bqNd1od/4hGzMoPV1idObG17KDVji/pick/RMPHbnsGHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=h5Ehnf9j;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F26606A320
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 14:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9F26606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=h5Ehnf9j
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so9237275e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 06:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795183389; x=1795788189; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=D98RljPeJIlkIJBWYWPihvZLS/ylF7xKs07IaIfeuMA=;
        b=h5Ehnf9jIz3LtPeuuxWNWibJhcsgYdo6LbDCPxb7qbCEacvBepFAN1vaFoFBY9g/+/
         M5zYm2SfcxgriuwHyR6RP+vhr5nLR/Lvj8UgVoHi8bsU2ZhHSGjhNYPZeDS0f9OJWdC0
         h2wl2uU4zG2vUgDvJuu3UiWXmcpL5feNQz9D6q60a/mhU3ecNzAQM5knbzkVQWxZCVPJ
         W5vCfSyV2bRoX5TyZd5GtFRFTSNoQ81FsuhLDOc1D0PP2uYg9cWvwpLiDJTCxeI/c6JC
         uPkZXZa+acVx8vOQXRxYIg4E5nGe0wgaw7bZB6lJZBg8TUfJDjTR+bXVcIUxkun0SMQV
         Rvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795183389; x=1795788189;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D98RljPeJIlkIJBWYWPihvZLS/ylF7xKs07IaIfeuMA=;
        b=cglX4+eY1XKJGnyp7uOHeIJLWu/uG3GQjER68MF8XtzZsO5Fpvrbvzc8oY1LDtEZsu
         HujM8lgjGtqt+QXNy4LmlhVkWxjWCqHG9LV6I6RHJtKrtNwilIEPbQkkn98jHgFCuPEm
         gq6CfbqeZNFIm2ddmwO5kARobtbgnSh+/cTcKDjbON1rnKAvuqbxqbcoHkS75IckfLfH
         TbnR+9Y4XQJRD0LzNvpaisXT/3bmDz1lwNPTtwoQLx+++B9kea4eDMvcZgMRJ5AcNnPn
         nnuUKoFmgR4y7QDwfGii2ntSQGES9g/oKIAsViHEUgpB2hXejbDJCRfC1iqzQ6lrWVbJ
         3OMA==
X-Forwarded-Encrypted: i=1; AL+hErEsHuQtFwCDkS8cBPgyeC5VPCv1/Ro+gQJ5RzD3dKJluFxuBa5Srj8V1/5b/oAMiGbp+o1VXt1W/dGU9wFQ@vger.kernel.org
X-Gm-Message-State: APuU4Z8Fv95UwFAsWjzP9oZ4+6DI8X7B9az2ghbmbC/nA8PQYuQFpw+X
	QA9QpbfrWtKZbFr982OuAGjl8yeHyD6U0dAvxDuZnX33QRx9d/y8xN2XwxeisW8W1Bdng5d6g7E
	2mDu/uKbV
X-Gm-Gg: AYBFou1K38OFd9e8wgnQRPYWhptaZLyllIIWpbcVDjUDsokgPTgBQ5aJD/NZtO8Jpfw
	vf3pVHe1FOvOqzNuQS9cy5tIC74jkyf9gMtIPYRA7gNQhyI/gga9FBxRvmrbWf+/a9fxSbfoDFl
	tqdIERinNAYzoPrOG/VBeKvd1vkRK7HZCahvN5RjfmRWcTAai0GLzbg1ZkQy5mHDbz0s/0VPnTX
	BnJ3B2cdI4VVbNXmb6dZWv/LWH3pDepiQzli8gxxq27WdUqChqsDRPlDbJG6QqzLzmnzTKYqaWr
	uXFbZhvs+iN3H8RoxWPxw5HZRqGDC9HvBye7hWDMRe9ylaNFjiDl87fMZQBZk8mujsAz3pI6pYT
	4P057vEuzn2st9pwuQuVrFlaWb6U2HFTZoIWQvaeJ3pj6ezMwEYMb5DSPTKOujZQgI6qC/MF+jz
	gO5AeontOHQRjvEALV6+iWIMjffxIfUbDSTPB4yPEXZHM+kPkFFj4i5fDqHYUrqjvBUuR3uAyEF
	RwriYROzvBlRZ/4gwr5hgWfZSgAMefMBnfg78Yf0F3sbDMNPFSAIeJn81XsRqFuQX4V3mKlfvkH
	S0dxNbfynDKHW4owax4nGTdYhqFTBvSu4YVszJ+0BhnsLfn7L7l6PjA+zYhG0kGyj6oUsRcq2Um
	PwJxZwaoaPMM=
X-Received: by 2002:a05:600c:6749:b0:4a2:1867:10e8 with SMTP id 5b1f17b1804b1-4bb8881a294mr70028995e9.25.1795183388769;
        Fri, 20 Nov 2026 06:03:08 -0800 (PST)
Received: from [10.0.0.233] (tmo-084-188.customers.d1-online.com. [80.187.84.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884ab091sm126078465e9.11.2026.11.20.06.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:03:08 -0800 (PST)
Message-ID: <ecb63d95f150bd91bbd8a3c83211055461bc9594.camel@amutable.com>
Subject: Re: [PATCH 2/2] ns: don't call the namespace LSM hooks for
 kernel-internal namespaces
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, Alexander Viro	
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, bpf@vger.kernel.org,
 Zhiqi Zhang <zhiqizhangg@gmail.com>
Date: Fri, 20 Nov 2026 15:03:07 +0100
In-Reply-To: <20261120-work-ns-mount_subtree-v1-2-06337377f94a@kernel.org>
References: <20261120-work-ns-mount_subtree-v1-0-06337377f94a@kernel.org>
	 <20261120-work-ns-mount_subtree-v1-2-06337377f94a@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, 2026-11-20 at 13:29 +0100, Christian Brauner wrote:
> mount_subtree() allocates a private anonymous mount namespace so that
> automounts triggered while it looks up the path have somewhere to go.
> That namespace never becomes anyone's namespace and it's gone again
> before mount_subtree() returns. btrfs goes through it on every mount:
>=20
> =C2=A0 btrfs_get_tree()
> =C2=A0 -> btrfs_get_tree_subvol()
> =C2=A0=C2=A0=C2=A0=C2=A0 -> mount_subvol()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> mount_subtree()
>=20
> and NFS on every NFSv4 mount and whenever it follows a referral:
>=20
> =C2=A0 nfs4_try_get_tree() / nfs4_get_referral_tree()
> =C2=A0 -> do_nfs4_mount()
> =C2=A0=C2=A0=C2=A0=C2=A0 -> mount_subtree()
>=20
> But __ns_common_init() calls security_namespace_init() for it like
> for
> any other namespace. Since commit 15dd86021b57a ("landlock: Enforce
> namespace use restrictions") Landlock enforces
> LANDLOCK_PERMISSION_NAMESPACE_USE in its namespace_init hook. So a
> task
> in a domain that handles that permission without allowing CLONE_NEWNS
> can't mount btrfs or NFSv4 anymore. mount(2) fails with EPERM even
> though the caller never asked for a mount namespace.
>=20
> Mark such namespaces as kernel-internal and don't call the namespace
> LSM hooks for them at all. That includes namespace_free. Currently
> security_namespace_free() only calls the hook if an LSM requested a
> namespace blob and none does. But we shouldn't rely on that.
> Otherwise
> a bpf program attached to namespace_free would see namespaces go away
> that it never saw being created.
>=20
> The anonymous mount namespaces created by open_tree(OPEN_TREE_CLONE)
> and fsmount() are handed to userspace and keep going through the
> hooks.
> Landlock covers them on purpose.
>=20
> Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
> Reported-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
> Closes:
> https://lore.kernel.org/20261114141323.19029-1-zhiqizhangg@gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good to me.

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/namespace.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 9 +++++++--
> =C2=A0include/linux/ns/ns_common_types.h |=C2=A0 2 ++
> =C2=A0include/linux/ns_common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 20 +++++++++++++-------
> =C2=A0kernel/nscommon.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++++++---
> =C2=A04 files changed, 28 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 756f9011cbf1d..82738b818c1d0 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2355,6 +2355,7 @@ void drop_collected_paths(const struct path
> *paths, const struct path *prealloc)
> =C2=A0
> =C2=A0enum mnt_ns_flags_t {
> =C2=A0	MNT_NS_ANON	=3D (1 << 0),
> +	MNT_NS_KERNEL	=3D (1 << 1),
> =C2=A0};
> =C2=A0
> =C2=A0static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *,
> @@ -4377,10 +4378,14 @@ static void free_mnt_ns(struct mnt_namespace
> *ns)
> =C2=A0static struct mnt_namespace *alloc_mnt_ns(struct user_namespace
> *user_ns,
> =C2=A0					=C2=A0 enum mnt_ns_flags_t flags)
> =C2=A0{
> +	enum ns_common_flags_t ns_flags =3D 0;
> =C2=A0	struct mnt_namespace *new_ns;
> =C2=A0	struct ucounts *ucounts;
> =C2=A0	int ret;
> =C2=A0
> +	if (flags & MNT_NS_KERNEL)
> +		ns_flags |=3D NS_COMMON_KERNEL;
> +
> =C2=A0	ucounts =3D inc_mnt_namespaces(user_ns);
> =C2=A0	if (!ucounts)
> =C2=A0		return ERR_PTR(-ENOSPC);
> @@ -4392,7 +4397,7 @@ static struct mnt_namespace
> *alloc_mnt_ns(struct user_namespace *user_ns,
> =C2=A0	}
> =C2=A0
> =C2=A0	if (flags & MNT_NS_ANON)
> -		ret =3D ns_common_init_inum(new_ns, MNT_NS_ANON_INO);
> +		ret =3D ns_common_init_inum(new_ns, MNT_NS_ANON_INO,
> ns_flags);
> =C2=A0	else
> =C2=A0		ret =3D ns_common_init(new_ns);
> =C2=A0	if (ret) {
> @@ -4515,7 +4520,7 @@ struct dentry *mount_subtree(struct vfsmount
> *m, const char *name)
> =C2=A0	struct path path;
> =C2=A0	int err;
> =C2=A0
> -	ns =3D alloc_mnt_ns(&init_user_ns, MNT_NS_ANON);
> +	ns =3D alloc_mnt_ns(&init_user_ns, MNT_NS_ANON |
> MNT_NS_KERNEL);
> =C2=A0	if (IS_ERR(ns)) {
> =C2=A0		mntput(m);
> =C2=A0		return ERR_CAST(ns);
> diff --git a/include/linux/ns/ns_common_types.h
> b/include/linux/ns/ns_common_types.h
> index 47a5cfe2326a3..5f8b0930ae065 100644
> --- a/include/linux/ns/ns_common_types.h
> +++ b/include/linux/ns/ns_common_types.h
> @@ -102,6 +102,7 @@ extern const struct proc_ns_operations
> utsns_operations;
> =C2=A0 *=C2=A0=C2=A0 __ns_ref_active =3D 1 and remain active forever.
> =C2=A0 *
> =C2=A0 * @ns_type: type of namespace (e.g., CLONE_NEWNET)
> + * @ns_flags: NS_COMMON_* flags
> =C2=A0 * @stashed: cached dentry to be used by the vfs
> =C2=A0 * @ops: namespace operations
> =C2=A0 * @inum: namespace inode number (quickly recycled for non-initial
> namespaces)
> @@ -113,6 +114,7 @@ struct ns_common {
> =C2=A0		refcount_t __ns_ref; /* do not use directly */
> =C2=A0	} ____cacheline_aligned_in_smp;
> =C2=A0	u32 ns_type;
> +	u32 ns_flags;
> =C2=A0	struct dentry *stashed;
> =C2=A0	const struct proc_ns_operations *ops;
> =C2=A0	unsigned int inum;
> diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
> index e8b2bf0da5ede..524b77904d3b4 100644
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -8,9 +8,14 @@
> =C2=A0#include <uapi/linux/sched.h>
> =C2=A0#include <uapi/linux/nsfs.h>
> =C2=A0
> +enum ns_common_flags_t {
> +	/* Kernel-internal namespace. The LSM namespace hooks never
> see it. */
> +	NS_COMMON_KERNEL	=3D (1 << 0),
> +};
> +
> =C2=A0bool is_current_namespace(struct ns_common *ns);
> =C2=A0int __ns_common_init(struct ns_common *ns, u32 ns_type, const struc=
t
> proc_ns_operations *ops,
> -		=C2=A0=C2=A0=C2=A0=C2=A0 int inum, u64 ns_id);
> +		=C2=A0=C2=A0=C2=A0=C2=A0 int inum, u64 ns_id, enum ns_common_flags_t
> flags);
> =C2=A0void __ns_common_free(struct ns_common *ns);
> =C2=A0struct ns_common *__must_check ns_owner(struct ns_common *ns);
> =C2=A0
> @@ -47,13 +52,14 @@ static __always_inline bool is_ns_init_id(const
> struct ns_common *ns)
> =C2=A0		=09
> ns_common_type(__ns),				\
> =C2=A0		=09
> to_ns_operations(__ns),			\
> =C2=A0			 (((__ns) =3D=3D ns_init_ns(__ns)) ?
> ns_init_inum(__ns) : 0), \
> -			 (((__ns) =3D=3D ns_init_ns(__ns)) ?
> ns_init_id(__ns) : 0))
> +			 (((__ns) =3D=3D ns_init_ns(__ns)) ?
> ns_init_id(__ns) : 0), \
> +			 0)
> =C2=A0
> -#define ns_common_init_inum(__ns, __inum)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
> -	__ns_common_init(to_ns_common(__ns),=C2=A0=C2=A0=C2=A0=C2=A0 \
> -			 ns_common_type(__ns),=C2=A0=C2=A0 \
> -			 to_ns_operations(__ns), \
> -			 __inum, 0)
> +#define ns_common_init_inum(__ns, __inum, __flags) \
> +	__ns_common_init(to_ns_common(__ns),=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 \
> +			 ns_common_type(__ns),=C2=A0=C2=A0=C2=A0=C2=A0 \
> +			 to_ns_operations(__ns),=C2=A0=C2=A0 \
> +			 __inum, 0, __flags)
> =C2=A0
> =C2=A0#define ns_common_free(__ns) __ns_common_free(to_ns_common((__ns)))
> =C2=A0
> diff --git a/kernel/nscommon.c b/kernel/nscommon.c
> index 4438c6b663f91..20fc0d0e98212 100644
> --- a/kernel/nscommon.c
> +++ b/kernel/nscommon.c
> @@ -55,7 +55,7 @@ static void ns_debug(struct ns_common *ns, const
> struct proc_ns_operations *ops)
> =C2=A0#endif
> =C2=A0
> =C2=A0int __ns_common_init(struct ns_common *ns, u32 ns_type, const struc=
t
> proc_ns_operations *ops,
> -		=C2=A0=C2=A0=C2=A0=C2=A0 int inum, u64 ns_id)
> +		=C2=A0=C2=A0=C2=A0=C2=A0 int inum, u64 ns_id, enum ns_common_flags_t
> flags)
> =C2=A0{
> =C2=A0	int ret =3D 0;
> =C2=A0
> @@ -66,6 +66,7 @@ int __ns_common_init(struct ns_common *ns, u32
> ns_type, const struct proc_ns_ope
> =C2=A0#endif
> =C2=A0	ns->ops =3D ops;
> =C2=A0	ns->ns_type =3D ns_type;
> +	ns->ns_flags =3D flags;
> =C2=A0	ns_tree_node_init(&ns->ns_tree_node);
> =C2=A0	ns_tree_node_init(&ns->ns_unified_node);
> =C2=A0	ns_tree_node_init(&ns->ns_owner_node);
> @@ -85,7 +86,8 @@ int __ns_common_init(struct ns_common *ns, u32
> ns_type, const struct proc_ns_ope
> =C2=A0	/* Allocate the id before the LSM hook so it can track the
> namespace by it. */
> =C2=A0	__ns_tree_gen_id(ns, ns_id);
> =C2=A0
> -	ret =3D security_namespace_init(ns);
> +	if (!(flags & NS_COMMON_KERNEL))
> +		ret =3D security_namespace_init(ns);
> =C2=A0	if (ret) {
> =C2=A0		if (!inum)
> =C2=A0			proc_free_inum(ns->inum);
> @@ -106,7 +108,8 @@ int __ns_common_init(struct ns_common *ns, u32
> ns_type, const struct proc_ns_ope
> =C2=A0
> =C2=A0void __ns_common_free(struct ns_common *ns)
> =C2=A0{
> -	security_namespace_free(ns);
> +	if (!(ns->ns_flags & NS_COMMON_KERNEL))
> +		security_namespace_free(ns);
> =C2=A0
> =C2=A0	if (ns->inum > MNT_NS_INO_SPECIAL_MAX)
> =C2=A0		proc_free_inum(ns->inum);
