Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767728;
	b=BxXkXiyndWD0MEWTGCfM8QHiJXepXm69K4pAzGa4HbGblk3udqd0GxeI+TJl3qL7pAee
	 wmXpDQurfnNG5R+hZm0LthzXwKGonV8b2qSjT9NBaVQvBTmNtdKKiSWewKkWWL9kFCmLn
	 cCo//TKXBo6ngq+FVUl3NamG43f2OHI2prQ/dqgdGjg+PxFViWY0AgpI4jEFp3LakbHN2
	 LJ6jw14B5t67GxP86BY9ppi+zXrwS28+LrsWrV6UsOzBt/JOV+XzQZ0vvi86qax7GWLtI
	 Xznmx2DuRAFAAz6TWVTzoxJofeqVqkjcVkwvVHA8G2FEl+v+7zbK8Hco6ZkzEm+J7KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=tkHm2vnnmTZBC/nT+La6StfKwTQIeierHvMxqpEy1kI=;
	b=OmlVMwdq9t+XSg2/O0CLRWjtApUD8vmXBYU1MwQmaANuRYq17V7Pv01yai8kIbUx3Vvg
	 EK5986h9wCzldo8ack6JSBug0G+RemwqLOUmlMkaljDrPjtX8aWh0YCDU+edLVcJlczq9
	 5kXDDcJbdDqRxYCVQN+RLtTdClhHcmtCkNYj6jtnpZ1seYqrXFRlfDgp4YURiW8JfK4Ol
	 R4tsGcEBSRdD65+s1uw971OjgXvKOS7bveTqzX/fHfR4uyLuxLYP4XRwXl9MKdjSv1Y9H
	 BiHogjXWiQLW3Y93f5GdFddayU2dByr3G062w9SurF0RjamUAiXU/UCN8vkMIemDt+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NhZDmqTQ;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A54606A31E
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 08:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36A54606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NhZDmqTQ
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-49a92144733so3896620f8f.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 00:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795767725; x=1796372525; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tkHm2vnnmTZBC/nT+La6StfKwTQIeierHvMxqpEy1kI=;
        b=NhZDmqTQ6t+bJA1qQ2XaaKi4BNx62iZ2z63LDV98NZZh7dK5xiNLvrN+Jo4BpyzXp3
         BZ/PxZ2eVjpQ9mDP+icMhMr4W4aO5x6Gi7h19FL/QQYRMlrX4AQFfTkG6SjDE+dewYqw
         XMqB9QaeFy/h5SC89NWhhmk7Ek1uyK4oTkPPenVTcm/rb3xicNJh5taaA1TG9L4FPtoU
         WT2Nj8b5U0rzR385f4BaZXsRBVBA68pGu3RtA6i+cOQitpgzwI9vuHAkOz1nN8eQOemw
         uWCRKV6b6ef9D41BZHuMsPfBJXY48pJiNgF6z5IJIe/pmfi0ficeSL2J3LVHW3GuRi0Z
         IHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795767725; x=1796372525;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tkHm2vnnmTZBC/nT+La6StfKwTQIeierHvMxqpEy1kI=;
        b=O8aX8LFH4fcbYOpZvhI9TbEms9GUGPRyDd4QBdB64UXdfylOL54J3lbyHr+ebG2eII
         rpXlT1kkPTDs3WQfnksPEvrqBoMCLsIrwSOuM0XemZy1HpgnwH9PYO60kDn08BiU5czz
         9hCqnK9w3EKVyAwv+XyKlHdl4q5SaO5vRJB0wMO7GIdCHnxWzoKgg0rLWrPRI7IKL931
         H6Cd/K3wprvwbYT3ySUfUYNgrAWi8jneVLB9nVaof5xKx3kKUFEZZYZlpD0etiDlVPM4
         Z6etusE+MvlASuWK/qACImPcVOvP1tUGrJBGgTpF5duAJ9VIvBJlyXc/sxWpt8iRgOaW
         7NNA==
X-Forwarded-Encrypted: i=1; AL+hErGV8y8luVbxqTnCpzH+MO5gqe3JtpWOMA3otOPQJCA8QKeVvIRjf2CrQ6WesnRGW71ZXByBNPeNtoOwycl9@vger.kernel.org
X-Gm-Message-State: APuU4Z9dzRpjqyxb4GudJ14/wKSqH47ePtIJJ6r6r4k37Av1CdpV1fHK
	BfidABJukFI1Ax+uILsEpd6Qxf3Jor3dtTdCHEK60cqArb8cPvhrH4UN7A14pGw5pcFk
X-Gm-Gg: AZFdTZcWXBJJK+msmwRAHl+Fef+cDLIO6ApHYAXAXs5Xv/PIRp2Ay/VyLQs7ffYdpsF
	/JjX744Y/fGZzZxdC1T8ofhsUwj7vgaNy+k75gpAfe+2IApQ9ZLuF2v23cwibW13sEBuPcYXE3T
	APKZDJLKDFic/WBp21cR8HwygMABsUdH+bvEOeXhc7OaQqCaQyPDmDw3mvypKb2yKeth7TrLnhb
	WIQ4R15HRmTlvRzMOcHx2AOVxy9ll59Deq410hmcIIUtj5QZEd9mb42H+0WurONNMWl4G2pdanv
	eErod6bmwRhybwRAPz5Vm1LZQpDvwsKu/tpcS4Uy1xHdsNyFyF3KCIo4aztAtjEX9MO8htt3A6h
	lOCAvQbNeIyzlLZ4fSDDG1mKgMjNJp11XXm3gmBJMDT2vxogftbT5mVq/1XpKgr8f1Haf/wCKNZ
	kaFVyi6DNA4lSginUL2zPWdkLG2zGfqUlXLMzIK5fnqb5ozVldUciyeFt3xcAJQ9gjMdiU2hLvq
	vZXCD1F8r1nU9HInuioKXjjU67HjId4/2I2/NSgy3d0vuJkZ2DcTDGo4E8Yc7XjCcS7765f6We1
	kV0OFyQkXIBMlJAAJKc2s9qZGXuhBldXi8oMhs3YDxZ0OR70dYe4AdjMXoeckWYFhQ==
X-Received: by 2002:a05:6000:2f81:b0:4aa:ba0f:c1a with SMTP id ffacd0b85a97d-4abb683bca6mr45119910f8f.40.1795767725372;
        Fri, 27 Nov 2026 00:22:05 -0800 (PST)
Received: from [10.0.0.233] (tmo-084-240.customers.d1-online.com. [80.187.84.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d1bsm47444432f8f.8.2026.11.27.00.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:22:04 -0800 (PST)
Message-ID: <2b0198ff605e865fa1b17df354511949bce70038.camel@amutable.com>
Subject: Re: [PATCH 1/2] namespace: allow bind mounts of ephemeral procfs
 files again
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Aleksa Sarai <cyphar@cyphar.com>, stable@vger.kernel.org
Date: Fri, 27 Nov 2026 09:22:03 +0100
In-Reply-To: <20261126-work-mount-cant_mount-v1-1-781d911a32e1@kernel.org>
References: <20261126-work-mount-cant_mount-v1-0-781d911a32e1@kernel.org>
	 <20261126-work-mount-cant_mount-v1-1-781d911a32e1@kernel.org>
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

On Thu, 2026-11-26 at 12:40 +0100, Christian Brauner wrote:
> Commit 75f4197f1e11 ("dcache: don't put a mountpoint on a dentry
> that's
> being removed") made d_set_mounted() refuse dentries that
> dont_mount()
> was called on. I overlooked that procfs calls dont_mount() on the
> files
> in /proc/<pid>/{fd,fdinfo,map_files} and below /proc/<pid>/net when
> it
> creates them and that attach_recursive_mnt() makes a mountpoint out
> of
> the root of every source in case it goes beneath a mount. So
> bind-mounting one of these files fails with ENOENT now. libpathrs
> does
> that in its tests, e.g., by bind-mounting /proc/1/fd/0 over
> /proc/self/exe.
>=20
> Nothing may be mounted on top of these files but they can be the
> source
> of a mount. So drop the check from d_set_mounted() again and refuse
> such
> a root only if the source or one of its copies would go beneath a
> mount
> that is already there. attach_recursive_mnt() checks the source and
> propagate_mnt() checks each copy right after making it. The root is a
> mountpoint by then so either we see the flag or detach_mounts() finds
> the mount, same as before.
>=20
> Fixes: 75f4197f1e11 ("dcache: don't put a mountpoint on a dentry
> that's being removed")
> Cc: stable@vger.kernel.org
> Reported-by: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0fs/dcache.c=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++---
> =C2=A0fs/namespace.c | 25 +++++++++++++++++++++++++
> =C2=A0fs/pnode.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++++
> =C2=A0fs/pnode.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A04 files changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/dcache.c b/fs/dcache.c
> index ba17f49f8a636..b734ce65e6377 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -1628,8 +1628,7 @@ static __cacheline_aligned_in_smp
> DEFINE_SEQLOCK(d_set_mounted_lock);
> =C2=A0 *
> =C2=A0 * Only one of d_invalidate() and d_set_mounted() must succeed.=C2=
=A0 For
> =C2=A0 * this reason take rename_lock, d_set_mounted_lock and d_lock on
> dentry
> - * and ancestors.=C2=A0 Likewise for dont_mount() which marks a dentry
> that
> - * is being removed under d_lock.
> + * and ancestors.
> =C2=A0 */
> =C2=A0int d_set_mounted(struct dentry *dentry)
> =C2=A0{
> @@ -1647,7 +1646,7 @@ int d_set_mounted(struct dentry *dentry)
> =C2=A0		spin_unlock(&p->d_lock);
> =C2=A0	}
> =C2=A0	spin_lock(&dentry->d_lock);
> -	if (!d_unlinked(dentry) && !cant_mount(dentry)) {
> +	if (!d_unlinked(dentry)) {
> =C2=A0		ret =3D -EBUSY;
> =C2=A0		if (!d_mountpoint(dentry)) {
> =C2=A0			dentry->d_flags |=3D DCACHE_MOUNTED;
> diff --git a/fs/namespace.c b/fs/namespace.c
> index aecd05ac01705..443a8e3b74f9b 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2561,6 +2561,21 @@ int count_mounts(struct mnt_namespace *ns,
> struct mount *mnt)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/*
> + * Would @source_mnt or a copy of it go beneath a mount that is
> already at
> + * @mp on @parent? Call under namespace_sem, without mount_lock.
> + */
> +bool mount_goes_beneath(struct mount *parent, struct mountpoint *mp,
> +			struct mount *source_mnt)
> +{
> +	struct mount *q;
> +
> +	guard(mount_locked_reader)();
> +	q =3D __lookup_mnt(&parent->mnt, mp->m_dentry);
> +	/* a moved @source_mnt is gone from there by then */
> +	return q && q !=3D source_mnt;
> +}
> +
> =C2=A0enum mnt_tree_flags_t {
> =C2=A0	MNT_TREE_BENEATH =3D BIT(0),
> =C2=A0	MNT_TREE_PROPAGATION =3D BIT(1),
> @@ -2677,6 +2692,16 @@ static int attach_recursive_mnt(struct mount
> *source_mnt,
> =C2=A0	if (err)
> =C2=A0		return err;
> =C2=A0
> +	/*
> +	 * Don't mount on top of a root that dont_mount() was called
> on. It's
> +	 * a mountpoint now so a later detach_mounts() will find it.
> +	 */
> +	if (cant_mount(root.mp->m_dentry) &&
> +	=C2=A0=C2=A0=C2=A0 mount_goes_beneath(dest_mnt, dest_mp, source_mnt)) {
> +		err =3D -ENOENT;
> +		goto out;
> +	}
> +
> =C2=A0	/* Is there space to add these mounts to the mount
> namespace? */
> =C2=A0	if (!moving) {
> =C2=A0		err =3D count_mounts(ns, source_mnt);
> diff --git a/fs/pnode.c b/fs/pnode.c
> index 5f07fa14099bf..4514e75311972 100644
> --- a/fs/pnode.c
> +++ b/fs/pnode.c

Hi Christian,

> @@ -351,6 +351,12 @@ int propagate_mnt(struct mount *dest_mnt, struct
> mountpoint *dest_mp,
> =C2=A0			err =3D count_mounts(n->mnt_ns, this);
> =C2=A0			if (err)
> =C2=A0				break;
> +			/* what is already there would end up on
> this root */
> +			if (cant_mount(topmost_overmount(this)-
> >mnt.mnt_root) &&
> +			=C2=A0=C2=A0=C2=A0 mount_goes_beneath(n, dest_mp,
> source_mnt)) {
> +				err =3D -ENOENT;
> +				break;
> +			}

Please correct me if I'm wrong, but shouldn't we do this check before
count_mounts()? AFAIU, it changes ns->pending_mounts and then I can't
see where we clean it up on the error path.

Kind regards,
Alex

> =C2=A0			type =3D CL_MAKE_SHARED;
> =C2=A0		} while ((n =3D next_peer(n)) !=3D m);
> =C2=A0	}
> diff --git a/fs/pnode.h b/fs/pnode.h
> index b029db225f33c..0fb217c48f17a 100644
> --- a/fs/pnode.h
> +++ b/fs/pnode.h
> @@ -59,6 +59,8 @@ struct mount *copy_tree(struct mount *, struct
> dentry *, int);
> =C2=A0bool is_path_reachable(struct mount *, struct dentry *,
> =C2=A0			 const struct path *root);
> =C2=A0int count_mounts(struct mnt_namespace *ns, struct mount *mnt);
> +bool mount_goes_beneath(struct mount *parent, struct mountpoint *mp,
> +			struct mount *source_mnt);
> =C2=A0bool propagation_would_overmount(const struct mount *from,
> =C2=A0				 const struct mount *to,
> =C2=A0				 const struct mountpoint *mp);
