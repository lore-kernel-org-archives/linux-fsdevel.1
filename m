Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D379D213254;
	Mon,  6 Jul 2026 05:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317020; cv=none; b=dqplLuXi9HOkTZuH8udu+M300IwCPPqT9NAEhqJzCXUzsti84sEgpzVQ1Vxx21LEwX196UQVS2lAaVefCMVVgvKVIwvP4aRpHvmSbN6HgQQ4s3JJ7JVyxHc9ZMZewRsssvoeJ77I61t/UV07LpMn2gh/2gFVzHD1tDb/UmWghE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317020; c=relaxed/simple;
	bh=k0hntwHUEdmIA8PMH3RLG8UOYJ8hNPiJr2xnIDDjEhQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=VAbZARBIsHDPIms1YDyXwk2kBu2t+qWB+UoSzPp4xPywNg2JfCloidCr1fYX3Gv5EBDX7KgpFs+kh8GUsFbH//zfVniP4xqNtBEpNvsOv8ZpnAFXPw1Gw+L79EFQCwlf8eL525fhRuojl7isgm2bf5dcmYjkIhDgfdv76YLP8qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=CSR5QSlU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pzJhycOb; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="CSR5QSlU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pzJhycOb"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id F1C7B1D000BB;
	Mon,  6 Jul 2026 01:50:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jul 2026 01:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783317017; x=1783403417; bh=jaTO8v/qrimWfDJZctTdvY1HVySdfC1WHp+
	XxoT2hBA=; b=CSR5QSlUsTqrVy8OsfFC+aXgEMMj2vstjBV4hQ645Wi7oyBVdAa
	uyA2/bzhWWd7uZue3rjxY6sK24/c0jWssPIBJL9nnPWyaW2ebsqYqgf2iUEnYGVs
	S8tw1ZU+VCf8L4eiRdfDVwV2sH2KHEyC+GR9ZOFzh/QbGUgm1+saUWjreH1SRDro
	ln+nHXlxtVGgUMAzsC+3iwvb/2wA5nA4uuIwPDLqHezBX0G1M+QjCM2OXW1SAVxo
	/nPEYRGCks3+mGuDOf3kAimnorm6JJtvogSa0AyxGhT086qTDxd8Q1BxkfRF5U1u
	mLSyx89sDTfSG0DP5x7kHksNjbbTGrfx+jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783317017; x=
	1783403417; bh=jaTO8v/qrimWfDJZctTdvY1HVySdfC1WHp+XxoT2hBA=; b=p
	zJhycObePo2l8mQvAjhsIMpjSnQxTB5OJ96LX/gCUewX/L/Wgf+7qj9+B9k9TUKA
	Iht53QMoc6DtCAZjvnuqshgSo8hLKf/rFI5htBiFod3bnHDkoUPU6B7Z4a9zHu6m
	uDtfap94g3N3lLIc9PTtwP+C1Kzmkd5djv5FJl/zb3CQbrL8ZlBnzFsskZhEY1wm
	SNmbAULCyzZ9O3LCn/e9OJ/Lg8Hy2BdlQY6EAd8/EBYmEm7d4QEvtdTOiqYNAdqJ
	dJMn2IWKngei8jcbmlrOHV0WvsfySjsvinw+5zgeQDYwkzXW+kvlBuGlTxXhG+ko
	inxnp5sVbnDU12/wOTgXQ==
X-ME-Sender: <xms:GUJLahbR-lyPuJqDkm2WE6HA2LG8ai0KY00DM-cm7qOhAoUOyTL1bg>
    <xme:GUJLak-xuDr6yAgldtDaxjapYLiTKxtCnbE3PhvNIuASsgocGcQQXSZkYAmgqY51z
    TJtqjZjcM7DTgQfpU639EEMXUwoAHVM13W6Dvq83zcJGefyGoQ>
X-ME-Received: <xmr:GUJLaoaxalr7wvOLl03jadZYGHnEaUtPbAxuzMXHJ6Pe28HqmE7_HYhTtHiksvOSdfmtTAU6A_p9CSBMKt5NwaOOgKFsFJY>
X-ME-Proxy-Cause: dmFkZTEi4gFgSXZ1Buqb38D/V9Y4CZdYez94bFbR4XeR2jsO9lv5wGWReoYji6JHjuwtT8
    oYAuGGbD4VBvOb9Zh8wx+IWLe3/TyJePkJ+9cqWj/OJR1OhQlL57oiiNknmJLxnUQg/GoO
    7k3OE8k1KaFjA/POjVAXDGH/+QMv3hcyIMJxHu2SCGttJvVQKy3egbp5M+TSwosb0xNsnZ
    paenvU2aTFoR43QYOhxDsAa8uWUBl2kSvOzuwp/gGBkFIkbwsMGHyjdcgFrwakY69sdlRZ
    8pNJzatV2D8TFp2DULTwWwKjIrFagnntYUT9LWTJ5i8/4kAXZ+FN9YsnM/+qLtxCI99Hmm
    c6buffCJECUrhb8ZHmDZhPwtlAkphhgKnS4PgkqOYZdQK6gwTnAq5PPXEfSW7mBjJf54uh
    VchTGFSK/qK/KxIDUGadSxtWJw+w6EY0vtwUFGRo/QnYVL+oQXbUNRBLaHdonHrRHCKqES
    HaeTfX5PIzVRP1nBoz+O56zubRJIm6UejUamw6u34ySFKNtl3D+TZ/iWXJb6rz1j5bA8/M
    bawqqrTE9YNvyemTpbF3AFivIlj8hf3/pTT5jra4wTZP4yJ/NKZnJM8ccomfrz25ey5orW
    uMHVBhilepJTaM76UaFwRoFbGctxHN6u3eSjyp4u9ZYQEZCnt1cx3jRvkhqw
X-ME-Proxy: <xmx:GUJLamf76GbU9PctToH4AhEMfr2FtJJbi6_NTP_6y9U9-LKxYPGhOw>
    <xmx:GUJLatlsI5QkXYjZEPTeDbiZ_iPrb_6WL1Qupn6u0Lnzcn9V7TGHGg>
    <xmx:GUJLau3F7kUJRvqeEmrx1iwCwsbvpv4mgfhs8aKAT28PbIhn_MCeEQ>
    <xmx:GUJLauecudxAweKTLwfy8rJSARAoE44e2eujWiFa-Qi3ZO-l0Zhp2Q>
    <xmx:GUJLamtKIfwKg8-AE7pVG3_Tc9rO7hV3CHbBdRzAzR7q3XJFCyLDFyst>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 01:50:14 -0400 (EDT)
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
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>,
 "Aleksa Sarai" <aleksa@amutable.com>, "Amir Goldstein" <amir73il@gmail.com>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Jori Koolstra" <jkoolstra@xs4all.nl>
Subject: Re: [PATCH v3 10/14] vfs: move O_IS_MKDIR check from lookup_open()
 into individual filesystems
In-reply-to: <20260704164149.3480051-11-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
  <20260704164149.3480051-11-jkoolstra@xs4all.nl>
Date: Mon, 06 Jul 2026 15:50:12 +1000
Message-id: <178331701271.27465.14344875571165397012@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 05 Jul 2026, Jori Koolstra wrote:
> Individual filesystems that implement ->atomic_open() need to get the
> chance to implement O_CREAT|O_DIRECTORY or not, rather than decide
> this at the VFS level in lookup_open().
>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

This look straight forward.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


> ---
>  fs/9p/vfs_inode.c      | 3 +++
>  fs/9p/vfs_inode_dotl.c | 3 +++
>  fs/ceph/file.c         | 3 +++
>  fs/fuse/dir.c          | 3 +++
>  fs/gfs2/inode.c        | 3 +++
>  fs/namei.c             | 3 ---
>  fs/nfs/dir.c           | 6 ++++++
>  fs/smb/client/dir.c    | 3 +++
>  fs/vboxsf/dir.c        | 3 +++
>  9 files changed, 27 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index 5783d0336f96..bb555e5ba261 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -777,6 +777,9 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *=
dentry,
>  	struct inode *inode;
>  	int p9_omode;
> =20
> +	if (O_IS_MKDIR(flags))
> +		flags &=3D ~O_CREAT;
> +
>  	if (d_in_lookup(dentry)) {
>  		struct dentry *res =3D v9fs_vfs_lookup(dir, dentry, 0);
>  		if (res || d_really_is_positive(dentry))
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index f7396d20cb6c..ff3facb420c2 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -239,6 +239,9 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct den=
try *dentry,
>  	struct v9fs_session_info *v9ses;
>  	struct posix_acl *pacl =3D NULL, *dacl =3D NULL;
> =20
> +	if (O_IS_MKDIR(flags))
> +		flags &=3D ~O_CREAT;
> +
>  	if (d_in_lookup(dentry)) {
>  		struct dentry *res =3D v9fs_vfs_lookup(dir, dentry, 0);
>  		if (res || d_really_is_positive(dentry))
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index 71161f2b2151..e79abdbd9f61 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -811,6 +811,9 @@ int ceph_atomic_open(struct inode *dir, struct dentry *=
dentry,
>  	      dir, ceph_vinop(dir), dentry, dentry,
>  	      d_unhashed(dentry) ? "unhashed" : "hashed", flags, mode);
> =20
> +	if (O_IS_MKDIR(flags))
> +		flags &=3D ~O_CREAT;
> +
>  	if (dentry->d_name.len > NAME_MAX)
>  		return -ENAMETOOLONG;
> =20
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 0e2a1039fa43..e01869565d5e 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -935,6 +935,9 @@ static int fuse_atomic_open(struct inode *dir, struct d=
entry *entry,
>  	struct mnt_idmap *idmap =3D file_mnt_idmap(file);
>  	struct fuse_conn *fc =3D get_fuse_conn(dir);
> =20
> +	if (O_IS_MKDIR(flags))
> +		flags &=3D ~O_CREAT;
> +
>  	if (fuse_is_bad(dir))
>  		return -EIO;
> =20
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index 8a77794bbd4a..9859ae0341a9 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -1387,6 +1387,9 @@ static int gfs2_atomic_open(struct inode *dir, struct=
 dentry *dentry,
>  {
>  	bool excl =3D !!(flags & O_EXCL);
> =20
> +	if (O_IS_MKDIR(flags))
> +		flags &=3D ~O_CREAT;
> +
>  	if (d_in_lookup(dentry)) {
>  		struct dentry *d =3D __gfs2_lookup(dir, dentry, file);
>  		if (file->f_mode & FMODE_OPENED) {
> diff --git a/fs/namei.c b/fs/namei.c
> index 5113ac986f50..76916caa264d 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4497,9 +4497,6 @@ static struct dentry *lookup_open(struct nameidata *n=
d, struct file *file,
>  	if (unlikely(IS_DEADDIR(dir_inode)))
>  		return ERR_PTR(-ENOENT);
> =20
> -	if (O_IS_MKDIR(open_flag) && dir_inode->i_op->atomic_open)
> -		open_flag &=3D ~O_CREAT;
> -
>  	file->f_mode &=3D ~FMODE_CREATED;
>  	dentry =3D d_lookup(dir, &nd->last);
>  	for (;;) {
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index c7b723c18620..c815d9aa9b69 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2121,6 +2121,9 @@ int nfs_atomic_open(struct inode *dir, struct dentry =
*dentry,
>  	dfprintk(VFS, "NFS: atomic_open(%s/%llu), %pd\n",
>  			dir->i_sb->s_id, dir->i_ino, dentry);
> =20
> +	if (O_IS_MKDIR(open_flags))
> +		open_flags &=3D ~O_CREAT;
> +
>  	err =3D nfs_check_flags(open_flags);
>  	if (err)
>  		return err;
> @@ -2313,6 +2316,9 @@ int nfs_atomic_open_v23(struct inode *dir, struct den=
try *dentry,
>  	 */
>  	int error =3D 0;
> =20
> +	if (O_IS_MKDIR(open_flags))
> +		open_flags &=3D ~O_CREAT;
> +
>  	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
>  		return -ENAMETOOLONG;
> =20
> diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
> index 88a4a1787ff0..75bf86cc0612 100644
> --- a/fs/smb/client/dir.c
> +++ b/fs/smb/client/dir.c
> @@ -538,6 +538,9 @@ int cifs_atomic_open(struct inode *dir, struct dentry *=
direntry,
>  	if (unlikely(cifs_forced_shutdown(cifs_sb)))
>  		return smb_EIO(smb_eio_trace_forced_shutdown);
> =20
> +	if (O_IS_MKDIR(oflags))
> +		oflags &=3D ~O_CREAT;
> +
>  	/*
>  	 * Posix open is only called (at lookup time) for file create now. For
>  	 * opens (rather than creates), because we do not know if it is a file
> diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
> index c5bd3271aa96..77ae2f696fd4 100644
> --- a/fs/vboxsf/dir.c
> +++ b/fs/vboxsf/dir.c
> @@ -318,6 +318,9 @@ static int vboxsf_dir_atomic_open(struct inode *parent,=
 struct dentry *dentry,
>  	u64 handle;
>  	int err;
> =20
> +	if (O_IS_MKDIR(flags))
> +		flags &=3D ~O_CREAT;
> +
>  	if (d_in_lookup(dentry)) {
>  		struct dentry *res =3D vboxsf_dir_lookup(parent, dentry, 0);
>  		if (res || d_really_is_positive(dentry))
> --=20
> 2.55.0
>=20
>=20

