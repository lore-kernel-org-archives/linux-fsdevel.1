Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0518B0A;
	Mon,  1 Jun 2026 03:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283911; cv=none; b=kx1msY8nB0m1Ev9GQsrYAttus3o5NXfeefwixLSs1lCMpRioOD9+v5JnQjW9/BagdBLNoIaOs3WXK413fZ6/g5YL4WhJabtBlSf4qnkm1zpGwZLpHTHrd9goPmO5f6dbC7VuPVwMuORUKupcbzwGe5lQwtk1qbNspan339NrggU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283911; c=relaxed/simple;
	bh=kHIHc04Ob3T5hRyvZgF34Cig4sixWSAd5Xk4UeDILwA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=K9mMRCogMj2Liingh40V/T27PN9REMBObZFOAM/IstAUuCcql9XZ2o8tMEKUe0nysaL8rp6vydbd8Fxssb7Z9T+Bky9afHPW3/RiijYw6DQexUx7d4JYQl2qbk+PZfDu83/NWquKaaLgDsFBAEVYewn7GLa0X5tYm0LlmqrOnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=MS0yxCde; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QPJcG3se; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="MS0yxCde";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QPJcG3se"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C04D1D00030;
	Sun, 31 May 2026 23:18:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Sun, 31 May 2026 23:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1780283909; x=1780370309; bh=M6ls4GmsxLFuEZFx5g8uhP+jb9gNh+gDEKp
	xmY9iOuw=; b=MS0yxCdeGDYMyUUh7cicdBgfyA8zI5SACQUoCJMOevMr+etSQta
	RKtPiGNaUbhvIRA4s+53hpbAH47+CfkRekYLfgAkWskW0QR3ApCzViPF/t5f+r8Z
	oYsMff+gb4/EJvKNNpi6WgVurW98W800e1zBSgzIBkCqxU+xGW/kv5Rt0TLFIqlf
	XkpAq8Fa0Z2RjDikP5r/yqXiHRmx35b/sHgZuuRz2PElHicILgBssfMePgxl+NUv
	cGkyoPoYf2cJXVSUN7w7vUSim4dwzgAaahQcm3cnOQkohmZgZ5+1SCo2CA6XLjFv
	l9jxHqOweWHF6N0G1PfsB40Tcro4oY2YPcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780283909; x=
	1780370309; bh=M6ls4GmsxLFuEZFx5g8uhP+jb9gNh+gDEKpxmY9iOuw=; b=Q
	PJcG3sea8qGuEkHMIgCQ11p8TXYtGADlH3hdV2O0ruLzBNEns99aONg4e6kI4Pw/
	cL84Ju+mXCp1huFipqhOnxK3OSG6IhJyWCHwi6YbkwaCZsSTHtkABUe0jU+2hTs2
	8841N+3gEzVDtDPXc99tNMDRMKw9bqbjZlppUCXptaZXIsev+rNbr7uVnVqul/jL
	QTsQ6vdzKnJ+yLpONtqiShbYkLshWQREDDh1b/LB7nNNCa8FhN6s+DOlaOiXHPH5
	emuxMzrkKaEg8xiVaa1IEP0LFdyYDy37Zdwfvn7IzniJ6fAa0V8jHUJUlsbmdiov
	wZeAQ1a0u/f2Y6W0dRafQ==
X-ME-Sender: <xms:BPocasM4ydy7GWuJaI_YTSbfrgxTI4IYVQzq9DX0Bn_Tm1HJw8TsVA>
    <xme:BPocarJt4voaOjJzviqyhiMhhoLrx4snu1ze74LbtE3w4vIrt7-u_oynY49BElSVt
    ly8GstRb835_ywYusFHVU1eErKX309SASwRmEloCyb8OJpV6F8>
X-ME-Received: <xmr:BPocau1iiUa6t85banmo8pVcfOA1qkjfs7FEToTINVBbTcp1b-pO57b-P263M4AV88xjrmH-TX4IfIumTRQ-Puem48mbHA8>
X-ME-Proxy-Cause: dmFkZTF8xyPWOEUrN44GLZ0phuPp4WomwiecC4aFZoKv+7fKv7pVkcEArns29uuIqhpB7J
    SFMe82KBV6ukYr9W3IsqJYe2RK2e6kas/Ugk3kd/15O6rBy2ebRvOyMZNhV75kel53j0ML
    Bxi/mYop1cZdU/5tOMFeoiGuuVWCB06+13IJ8pNtRjKlFTyr5PQBH37KhiY1xNpYGq6hVf
    gm6BA5X+PYXdIAFWybLaxjr+kUZiy1qhvXOno7FbJhzf6M+61Np7atDyyNaW8Y84N94QcR
    z3WO5eSrFn4W1KEQ1wAUN96JFIf8THdNb3versgr2VaOD/ZfYBLvrVvxlzoyLJSVtdYdit
    BUZ3oLspkdK0HXVnhXg0ljq0s1XDM3blaJ08ONx/KV/hUXmF/tObAOr4dLCPWz/IizDkQK
    1Hv6wQONnlkXe0/60QvdYcPFXgVeIk86a7FDEKYgCwI9XqLyIruted4rMLk3JxW1SQfZAh
    QEBlZpJ4Nyda2tFuaYzVY+/Dwv94tvtt7REU3U3Vao9+HND8/fDDWYvYOoaeMEWGJvU+ap
    vZJ0LC2PxzrcagBLnF+hME2hAYuWW+an4elo3z6YahkGd1j0+sGW3wAVzxU9pcav0gsKtP
    nK+8jKAEtcxOR6L+XIK5GG/F9dM8EOXnXIa9MMlQSNaE4RYrOJtudRCeKCEA
X-ME-Proxy: <xmx:BPocavWSVJIJBZJaCEk2XD7K5hc_mm_Ukc-jic56nNEYRGUPoDc5ug>
    <xmx:BPocagP0NDFPcH8x7kRYSWe3kG8eaKwoGI09FmzNjFMolgaM_rH1kQ>
    <xmx:BPocai1qbwqUyr6fgKfsWYwilwFj7toYknvSYOoy0Fxt5oG6mKr8_Q>
    <xmx:BPocakS-G0Lce2tP4f1TEmDCSPVYkD1GJYxzym9DpuVqIobdxnwvFw>
    <xmx:BfocahUemgBKhRX0jt2_eraqreVQfrk5x_lqRAlWMEm3XFmI4KmjST1b>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 23:18:25 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jori Koolstra" <jkoolstra@xs4all.nl>
Cc: "Al Viro" <viro@zeniv.linux.org.uk>, "Aleksa Sarai" <cyphar@cyphar.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>, "Mateusz Guzik" <mjguzik@gmail.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Charles Mirabile" <cmirabil@redhat.com>
Subject: Re: [RFC PATCH v6 8/9] vfs: move O_IS_MKDIR check out atomic_open()
 to individual filesystems
In-reply-to: <20260531182045.171711-9-jkoolstra@xs4all.nl>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
  <20260531182045.171711-9-jkoolstra@xs4all.nl>
Date: Mon, 01 Jun 2026 13:18:23 +1000
Message-id: <178028390395.2923901.6404705725351139712@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 01 Jun 2026, Jori Koolstra wrote:
> Individual filesystems need to get the chance to implement
> O_CREAT|O_DIRECTORY or not, rather than decide this at the VFS level in
> atomic_open().
>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/9p/vfs_inode.c      | 3 +++
>  fs/9p/vfs_inode_dotl.c | 3 +++
>  fs/ceph/file.c         | 3 +++
>  fs/fuse/dir.c          | 3 +++
>  fs/gfs2/inode.c        | 3 +++
>  fs/namei.c             | 8 ++------
>  fs/nfs/dir.c           | 3 +++
>  fs/nfs/file.c          | 3 +++
>  fs/smb/client/dir.c    | 3 +++
>  fs/vboxsf/dir.c        | 3 +++
>  10 files changed, 29 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index f468acb8ee7d..8eff9320aa8a 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -771,6 +771,9 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *=
dentry,
>  	struct inode *inode;
>  	int p9_omode;
> =20
> +	if (O_IS_MKDIR(flags))
> +		return -EINVAL;
> +
>  	if (d_in_lookup(dentry)) {
>  		struct dentry *res =3D v9fs_vfs_lookup(dir, dentry, 0);
>  		if (res || d_really_is_positive(dentry))
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 141fb54db65d..9a63ae0f3b58 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -239,6 +239,9 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct den=
try *dentry,
>  	struct v9fs_session_info *v9ses;
>  	struct posix_acl *pacl =3D NULL, *dacl =3D NULL;
> =20
> +	if (O_IS_MKDIR(flags))
> +		return -EINVAL;
> +
>  	if (d_in_lookup(dentry)) {
>  		struct dentry *res =3D v9fs_vfs_lookup(dir, dentry, 0);
>  		if (res || d_really_is_positive(dentry))
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index d54d71669176..a82a711a86e6 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -813,6 +813,9 @@ int ceph_atomic_open(struct inode *dir, struct dentry *=
dentry,
>  	if (dentry->d_name.len > NAME_MAX)
>  		return -ENAMETOOLONG;
> =20
> +	if (O_IS_MKDIR(flags))
> +		return -EINVAL;
> +
>  	err =3D ceph_wait_on_conflict_unlink(dentry);
>  	if (err)
>  		return err;
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index b658b6baf72f..58f3310f828f 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -940,6 +940,9 @@ static int fuse_atomic_open(struct inode *dir, struct d=
entry *entry,
>  	if (fuse_is_bad(dir))
>  		return -EIO;
> =20
> +	if (O_IS_MKDIR(flags))
> +		return -EINVAL;
> +
>  	if (d_in_lookup(entry)) {
>  		struct dentry *res =3D fuse_lookup(dir, entry, 0);
>  		if (res || d_really_is_positive(entry))
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index e9bf4879c07f..df66ac2d0c15 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -1384,6 +1384,9 @@ static int gfs2_atomic_open(struct inode *dir, struct=
 dentry *dentry,
>  {
>  	bool excl =3D !!(flags & O_EXCL);
> =20
> +	if (O_IS_MKDIR(flags))
> +		return -EINVAL;
> +
>  	if (d_in_lookup(dentry)) {
>  		struct dentry *d =3D __gfs2_lookup(dir, dentry, file);
>  		if (file->f_mode & FMODE_OPENED) {
> diff --git a/fs/namei.c b/fs/namei.c
> index 724b9de6831a..6cc3d42dc1a5 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4409,12 +4409,8 @@ static struct dentry *atomic_open(const struct path =
*path, struct dentry *dentry
> =20
>  	file->__f_path.dentry =3D DENTRY_NOT_SET;
>  	file->__f_path.mnt =3D path->mnt;
> -
> -	if (O_IS_MKDIR(open_flag))
> -		error =3D EINVAL;
> -	else
> -		error =3D dir->i_op->atomic_open(dir, dentry, file,
> -					       open_to_namei_flags(open_flag), mode);
> +	error =3D dir->i_op->atomic_open(dir, dentry, file,
> +				       open_to_namei_flags(open_flag), mode);
>  	d_lookup_done(dentry);
>  	if (!error) {
>  		if (file->f_mode & FMODE_OPENED) {
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index e9ce1883288c..cbbc61788d0e 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2314,6 +2314,9 @@ int nfs_atomic_open_v23(struct inode *dir, struct den=
try *dentry,
>  	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
>  		return -ENAMETOOLONG;
> =20
> +	if (O_IS_MKDIR(open_flags))
> +		return -EINVAL;
> +

Maybe this should use nfs_check_flags() ?

But either way:
 Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


>  	if (open_flags & O_CREAT) {
>  		error =3D nfs_do_create(dir, dentry, mode, open_flags);
>  		if (!error) {
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index 25048a3c2364..b885d8facaf5 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -52,6 +52,9 @@ int nfs_check_flags(int flags)
>  	if ((flags & (O_APPEND | O_DIRECT)) =3D=3D (O_APPEND | O_DIRECT))
>  		return -EINVAL;
> =20
> +	if (O_IS_MKDIR(flags))
> +		return -EINVAL;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(nfs_check_flags);
> diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
> index e4295a5b55b3..b282753713d6 100644
> --- a/fs/smb/client/dir.c
> +++ b/fs/smb/client/dir.c
> @@ -526,6 +526,9 @@ int cifs_atomic_open(struct inode *dir, struct dentry *=
direntry,
>  	if (unlikely(cifs_forced_shutdown(cifs_sb)))
>  		return smb_EIO(smb_eio_trace_forced_shutdown);
> =20
> +	if (O_IS_MKDIR(oflags))
> +		return -EINVAL;
> +
>  	/*
>  	 * Posix open is only called (at lookup time) for file create now. For
>  	 * opens (rather than creates), because we do not know if it is a file
> diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
> index 42bedc4ec7af..cc999c1ab7cf 100644
> --- a/fs/vboxsf/dir.c
> +++ b/fs/vboxsf/dir.c
> @@ -318,6 +318,9 @@ static int vboxsf_dir_atomic_open(struct inode *parent,=
 struct dentry *dentry,
>  	u64 handle;
>  	int err;
> =20
> +	if (O_IS_MKDIR(flags))
> +		return -EINVAL;
> +
>  	if (d_in_lookup(dentry)) {
>  		struct dentry *res =3D vboxsf_dir_lookup(parent, dentry, 0);
>  		if (res || d_really_is_positive(dentry))
> --=20
> 2.54.0
>=20
>=20

