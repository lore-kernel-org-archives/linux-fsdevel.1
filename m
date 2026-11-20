Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795183363;
	b=yzF3Otfk7Tg4tGM4Myjll+7/z7kfopwc8o8tsiYkrzY3PROlOjRmMxQzy9RlxAOSgIWO
	 KkWu9whAFuVFQS9X24kBCr2jJHMmD+aIWNBgT8bxc6lS7krgMsUuCDtXTPXV8Sf/gRSVf
	 CyAj9EPqRSjwl5tVlYv4KLXxlc2bY4Et/47y12DLpi2qDF2L5/4xL9/csZEEB5X8T+8ZB
	 o13t7YW59ps5f8mUr0T8EP87NX9YraL6hTfuL0HvZnWBlIU+WUdqv8FttUzz1JvR8L/X3
	 H+NZ/GrqmDGUwUTLZ3SBw0ErJ4RnDUvVvp0wb48H5F5W1woQ1kOwLmGV92A7Q/JHkFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183363;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Rt0RtCssS6m9x3qIGE05pU4mRxZ/g5pdTkvBx4YxX0M=;
	b=Ui/qRmacaPUQvxzUI/uG4hBRbFpJyHQPSknST8a2wY++gPcwNEEX48a1R5uEmMWRqVOb
	 DWmukhZ8EVIRWFwExaZLuh8Sz7SC+Nf3SqRrReeSy5rppESk91tDslmbxgtPbE7kaw/xP
	 5L0OnpHUsFzS7R5VITYpl3Rh/aZqIgoStT2SBI+8IG0sdhbyVqinWs1ZiKDt4bVPghTlB
	 ZfNQXjtIdvBiBNsY8V1RqkaG+4nLVU98eRld2Tmr+JXohkxvoTnVYcedI1w9YVHwebN6Y
	 xeuAcFNzcypy0O6CrpW3CCJCrmabwbQzZNcCkpguMzdFgozuFwZMZkN1qXz7F5KBqwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="LtzukpA/";
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD93F606A32A
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 14:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD93F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=LtzukpA/
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c40e30c26a4so435189866b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 06:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795183360; x=1795788160; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Rt0RtCssS6m9x3qIGE05pU4mRxZ/g5pdTkvBx4YxX0M=;
        b=LtzukpA/0jvvfr5IGHmG5eW/AvDJ5zy/rQ6+dvM4F2RpJAWjNLDa2Y4G8e+sqh3/D1
         fjBZpl8QQS7+jyRSThKW3091/kr/97HWHpQl5AGvlH+SL6p/BJUMJ7GLqbXaHE4sfY3o
         SE7YIky4Qxsupb42QS8OsBGTQ2x6Rt4W7bBX2Y021GvNAYGzW0+TXQqTOCjI6etMkIdr
         yZ4JsLbV17sU1Phs1U08GZpsGfz8eRPN9Tb7qqLc5E928B8EMhwPPaYxN0/J7TV5cHCU
         EApaErnhp7rWGukwpBhVDkD2jx3q2rWdm+thPH+86/Wep9jsPjn4GOyKrjXlCWbnVr2s
         81yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795183360; x=1795788160;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rt0RtCssS6m9x3qIGE05pU4mRxZ/g5pdTkvBx4YxX0M=;
        b=egLvexqvpXnT2umhdCH+ApmTMXUsDonHvNkagEblEXDT0SpFxYYNS4O5XMaZjApusB
         3MgqrU/gCVyA+UDsraW4PhuWkbjptSQk+WMdHHZMtMOkVMTFqZmFKZpYyNgjzbJ4pT2q
         MVB+vHlwChm9d5fpNeWXGaiDt8YXxoLsOM1TiaaRgTcO5iODZatLeyadld+nKa+P+8rk
         CSercWhXnxRAFVlDs/1H4m8Fv/9JoL/S/d0cyRSSJ9t9/3YsKPvwIZ9YEAoTzXl8lGO5
         /0ELd3+9mWJqryLeC34kJgv+cSU2DZ8Z1448kbkn7AMH3XyrEbUVZHM6Dngp0I84Lzg2
         XWEQ==
X-Forwarded-Encrypted: i=1; AL+hErHn+eBAusPtNeBvxyZOtaSqKMWGuZMVGZc6h6W805gIaIaWm1O0fDTsIed5H5WNmLRYvOIAPcAeRfCG/5yG@vger.kernel.org
X-Gm-Message-State: APuU4Z8HmOZy/mi+2ZjU8XE1i/U1S1CqoIp+hgewMstA/ddTql6RT5h8
	iu3fMn78Cwd/Fpeur9fJRAuyBH2euaZDoHO62ZmbwewCgIQNMjsav2UYSG3Wv1D46w4J
X-Gm-Gg: AYBFou0asNe3Iqj5pWEVpRChUJQ7C8VJvFtSwMZzhMRrWGjhI3CvwgcX9pxt9+gLkfZ
	L2GIs2ZAQPJl/QSoSLrfmkAv3pIvthQBtCgOa+mgHsQmyGsvXuNp3F9YUit3Htfyz+StOiigy3h
	jPMQYff66GWKZnoUGDBSmFycWb9wX0VVFfUk+dQFs8EpiT70uOxy8eK38v9SeDaJZxZmjpcv9tP
	WO40Efw07bofkzgmGcgc7M/UcZ+OT4BPXfMqhgDcHPFTqMuljJpqZ4PQxmpGKvYBld7V5GHC/qM
	sZ+B+68g5uNRnqllRHRB7gIacrIMsXBvFGdA1AJxeR0MPageOJCkG4zO8tqRC2NQbKi0N4J2dPw
	qKHXoGPKaPkXLRRKY8I7HE7/TDwkr23t/yCuZ2bErbE43pthNTJ/zDYRHATwZ9ilqmnJhXejvS5
	Z0c2YKvpwjsEQ5/lE0QENFngNwOBOnfbZsaN7G87/VvwQHNbCuvM3QSM/TRST1iV9j8mFHItia2
	5X3wo90xHEWveA3oR0M2kFIJIMUqeabX98u9oB0+JvYJ6vJO+5+I/YV5G7X8vmf6VHARyVrRNIa
	Zixl9ePjZh6LT646YHSvCBj+qLR//+MBmN/2g4JaiQcL9zAjtWZIMFiWro+kZyrn3A==
X-Received: by 2002:a17:906:184e:b0:c51:b2d:acf4 with SMTP id a640c23a62f3a-c513a856e78mr234468166b.14.1795183359156;
        Fri, 20 Nov 2026 06:02:39 -0800 (PST)
Received: from [10.0.0.233] (tmo-084-188.customers.d1-online.com. [80.187.84.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513ae6780esm99588766b.17.2026.11.20.06.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 06:02:38 -0800 (PST)
Message-ID: <a999a6a9f593638228c93f90aec7425a0c6a8215.camel@amutable.com>
Subject: Re: [PATCH 1/2] mount: pass flags to alloc_mnt_ns()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, Alexander Viro	
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, bpf@vger.kernel.org,
 Zhiqi Zhang <zhiqizhangg@gmail.com>
Date: Fri, 20 Nov 2026 15:02:37 +0100
In-Reply-To: <20261120-work-ns-mount_subtree-v1-1-06337377f94a@kernel.org>
References: <20261120-work-ns-mount_subtree-v1-0-06337377f94a@kernel.org>
	 <20261120-work-ns-mount_subtree-v1-1-06337377f94a@kernel.org>
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
> Turn the anon argument of alloc_mnt_ns() into a flags argument. The
> next patch needs to pass another property of the new mount namespace
> and two booleans in a row would make the callers unreadable.
>=20
> No functional changes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0fs/namespace.c | 24 +++++++++++++++---------
> =C2=A01 file changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/namespace.c b/fs/namespace.c
> index aecd05ac01705..756f9011cbf1d 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2353,7 +2353,12 @@ void drop_collected_paths(const struct path
> *paths, const struct path *prealloc)
> =C2=A0		kfree(paths);
> =C2=A0}
> =C2=A0
> -static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *,
> bool);
> +enum mnt_ns_flags_t {
> +	MNT_NS_ANON	=3D (1 << 0),
> +};
> +
> +static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *,
> +					=C2=A0 enum mnt_ns_flags_t);
> =C2=A0
> =C2=A0/* Consumes the caller's reference to @mnt. */
> =C2=A0void dissolve_on_fput(struct vfsmount *mnt)
> @@ -3149,7 +3154,7 @@ static struct mnt_namespace
> *get_detached_copy(const struct path *path, unsigned
> =C2=A0	struct user_namespace *user_ns =3D mnt_ns->user_ns;
> =C2=A0	struct mount *mnt, *p;
> =C2=A0
> -	ns =3D alloc_mnt_ns(user_ns, true);
> +	ns =3D alloc_mnt_ns(user_ns, MNT_NS_ANON);
> =C2=A0	if (IS_ERR(ns))
> =C2=A0		return ns;
> =C2=A0
> @@ -3230,7 +3235,7 @@ static struct mnt_namespace
> *create_new_namespace(struct path *path,
> =C2=A0	if (foreign)
> =C2=A0		copy_flags |=3D CL_SLAVE | CL_COPY_UNBINDABLE;
> =C2=A0
> -	new_ns =3D alloc_mnt_ns(user_ns, false);
> +	new_ns =3D alloc_mnt_ns(user_ns, 0);
> =C2=A0	if (IS_ERR(new_ns))
> =C2=A0		return ERR_CAST(new_ns);
> =C2=A0
> @@ -4369,7 +4374,8 @@ static void free_mnt_ns(struct mnt_namespace
> *ns)
> =C2=A0	mnt_ns_tree_remove(ns);
> =C2=A0}
> =C2=A0
> -static struct mnt_namespace *alloc_mnt_ns(struct user_namespace
> *user_ns, bool anon)
> +static struct mnt_namespace *alloc_mnt_ns(struct user_namespace
> *user_ns,
> +					=C2=A0 enum mnt_ns_flags_t flags)
> =C2=A0{
> =C2=A0	struct mnt_namespace *new_ns;
> =C2=A0	struct ucounts *ucounts;
> @@ -4385,7 +4391,7 @@ static struct mnt_namespace
> *alloc_mnt_ns(struct user_namespace *user_ns, bool a
> =C2=A0		return ERR_PTR(-ENOMEM);
> =C2=A0	}
> =C2=A0
> -	if (anon)
> +	if (flags & MNT_NS_ANON)
> =C2=A0		ret =3D ns_common_init_inum(new_ns, MNT_NS_ANON_INO);
> =C2=A0	else
> =C2=A0		ret =3D ns_common_init(new_ns);
> @@ -4394,7 +4400,7 @@ static struct mnt_namespace
> *alloc_mnt_ns(struct user_namespace *user_ns, bool a
> =C2=A0		dec_mnt_namespaces(ucounts);
> =C2=A0		return ERR_PTR(ret);
> =C2=A0	}
> -	new_ns->is_anon =3D anon;
> +	new_ns->is_anon =3D flags & MNT_NS_ANON;
> =C2=A0	refcount_set(&new_ns->passive, 1);
> =C2=A0	new_ns->mounts =3D RB_ROOT;
> =C2=A0	init_waitqueue_head(&new_ns->poll);
> @@ -4422,7 +4428,7 @@ struct mnt_namespace *copy_mnt_ns(u64 flags,
> struct mnt_namespace *ns,
> =C2=A0
> =C2=A0	old =3D ns->root;
> =C2=A0
> -	new_ns =3D alloc_mnt_ns(user_ns, false);
> +	new_ns =3D alloc_mnt_ns(user_ns, 0);
> =C2=A0	if (IS_ERR(new_ns))
> =C2=A0		return new_ns;
> =C2=A0
> @@ -4509,7 +4515,7 @@ struct dentry *mount_subtree(struct vfsmount
> *m, const char *name)
> =C2=A0	struct path path;
> =C2=A0	int err;
> =C2=A0
> -	ns =3D alloc_mnt_ns(&init_user_ns, true);
> +	ns =3D alloc_mnt_ns(&init_user_ns, MNT_NS_ANON);
> =C2=A0	if (IS_ERR(ns)) {
> =C2=A0		mntput(m);
> =C2=A0		return ERR_CAST(ns);
> @@ -4699,7 +4705,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned
> int, flags,
> =C2=A0		return FD_ADD((flags & FSMOUNT_CLOEXEC) ? O_CLOEXEC
> : 0,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 open_new_namespace(&new_path,
> MOUNT_COPY_NEW));
> =C2=A0
> -	ns =3D alloc_mnt_ns(current->nsproxy->mnt_ns->user_ns, true);
> +	ns =3D alloc_mnt_ns(current->nsproxy->mnt_ns->user_ns,
> MNT_NS_ANON);
> =C2=A0	if (IS_ERR(ns))
> =C2=A0		return PTR_ERR(ns);
> =C2=A0	mnt =3D real_mount(new_path.mnt);
