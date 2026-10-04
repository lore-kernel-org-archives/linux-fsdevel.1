Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797283F1AB4
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Oct 2026 22:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151724; cv=none; b=De2t8jBXEb6aX0SQsjuaeSVCM2YsziyeqARELSlUNquIF8LlAz+9Ufz/HklbbubqUS/sL0t/nbiQizC8maTDMkpvfH31d91J2P36LlgkoKyArMm1WdytqpprY+LwjsZXemL7WuojOzpl9AzSQg6Qj5qZhZquuQeSIbd6nglLbyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151724; c=relaxed/simple;
	bh=htKgqRb7W6N+YSUappcuDU6wlqcAeZr5HGe3s3V39f0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=O8v+S/hNoJ/dFYOlofwo872vi1dPwS5QqjXJE21F9h6VzS3B7bdZtSZC6eAZq/symGBzMO6ghfftnMaFu6fd8r4M7D3dFrJCExR3sDFrrFQPYJHs6vuWRg/XKm92/5scLTwtW8yNTbsMasCexGspEDM9jOU7AhahN1ioucYxRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=BeOM26id; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DF4xOeG+; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="BeOM26id";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DF4xOeG+"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 3F0E41D0018B
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Oct 2026 18:08:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sun, 04 Oct 2026 18:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1791151718; x=1791238118; bh=GBI2DoZEDSri02h62spy4YiY6yjgdRWwMNr
	yzx+T9P8=; b=BeOM26idiKqfjEx/sY4S5j+Lh/xa1V/WR6nBBgffSHT2JsWsCqI
	AaAQXowLQO+DIZm+1qEKNuR46P0eQE3w1Bcgx0Ndn5Zc2kHaWpYLYG7lY4WgJ8/C
	T11s9DGFgjfmsMg0pyOgsOZSYoJGhnYpNlGwtJYjiglO8nbKjBKakuAxl9CFAMHi
	refL6oC5lFHorzru/tEzNeQ387w3NS4lB7ij6slppDO5Bbl0yOQKErLJ/scS5fDT
	3aP1oU9XgRiu5oIzg1FGxO0cVVFSWWy+2DV23MnUznTsEeXOVu5YTjyA9OxWGmFg
	PNSMvNxRMqkxDbbcNad/JqtjN6d1+DtoMSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791151718; x=
	1791238118; bh=GBI2DoZEDSri02h62spy4YiY6yjgdRWwMNryzx+T9P8=; b=D
	F4xOeG+VhVnm9qDtLcqWWimyZM85Jg3q766CXWl8KwngzJ5+p32oVCZDrHJKJH7L
	wxqvCzJJB2W5FZzY38Mep0XY/I8bwwyacootkOo4tTk5bM3gUOwZ+MH8JiqGyShJ
	DmPy9IMO7xH0DhHDgDVjQXxb4ZEeOv+7Ixz6EHVSZ5jJSXW5tyhEuD/DFNKeTr9W
	KGQdGGduX5nd5dMp2KVqkRqo4hddFXXkXPwLo1vp840uwozUclARtvTrU2lkdlBK
	8XFErNb2see6CUUZ8PpyW9PEqoUeoWN7FHgip0ML82H8D77j/QPjGwqE/dXO32vf
	zNURkjWIYqu2+BXlWV+zQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=ownmail.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791151718; d=ownmail.net;
	mf=PG5laWxiQG93bm1haWwubmV0Pg==;
	rt=PGxpbnV4LWZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg==;
	s=fm2:rsa-sha256:mE3kFnPGzfwc2oJUr9KvxMo54oYod6tUTod8ZhRl+089BBB
	RHPntp5eLPcdAvu3Q6dleERSRgZHf1TXyXdMhsGFATcQW+ABIlOndT1rOVWqzF10
	8vKzylpUtivbA4XnsTPghMRGxveLoUGh/shg8RT9e7kJQhdbUuO+iDHZqorUYfK+
	2gpHaZpL5Mw98u/+f3RsWFKoYn1dlzHSqJxxIWWNn3C0r8wOFzuHNPpo3rsErz06
	ZBjuKnwR2r9zKIcinGx9U2wvo1FVS7KBMdD7Lj62UYfpqmbf8XsBX1OmuaSBrop2
	CeEPXaYH2juqnMjIdpHbkY01q/gm2cVDGz3Z9KA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,reply-to,
	subject,to;
Message-Instance: m=1; h=sha256:sP3eiEIrRTFPrPMW7tyHybRwRbcRaUzxU8SEPXIZLN4=:htKgqRb7W6N+YSUappcuDU6wlqcAeZr5HGe3s3V39f0=;
X-ME-Sender: <xms:Zs7CaorwNELKfZd7nbFkPVrkGPadT2UxqQOndMXGzEaLrVjziMtPXA>
    <xme:Zs7CahNHkl5G5j7mPoXEgIncQ7LXHFFhAShJWwwv_KBLdW1epNYBpmeXfxCxrCRWS
    XuNt6JsGQbktO_4GXUR0fwhZdwcH4lODEfNcfv7-EEpGrrH7eE>
X-ME-Received: <xmr:Zs7Cag0qxTbWcenGbEIfAHhD1x4si59Hp0NN3mPu0nvvqEFd8dqo6S6ScZ1znBflVbUG1PWtmlLPVV8QhFMC62glxgxKDlk>
X-ME-Proxy-Cause: dmFkZTFeqVhXH1YoKcMaMXemCVSqhpf8NWSTyIdVxWlErObmRFo3QhrNdEZDfZfno/qS0Z
    K99hO2d+m8F9E4PPpwkfDTdLnIdhvYVNc/DJpdPTXpsM8i0T/xXMezJ59ZFoZDNiCXWqxA
    1svoyAXSKIoh/fQWDD1/9BXoLE3DUbDfkdXbbCJvf+8T5PSkdCfCtbOvlzEBk5UPkPgLkn
    Uq16FrD0esOK3jzynAk6NWOnF5TV9U8RzxzhYi0YdKpI8xiHm/GjWrIWVEJZzf9S9zgugW
    kgUoaA9ZHrhbkdWD5guGLl9UpNKo+FaSutUZsVUylYTEkFx/Ngl5PC4MLROtXmC2L4cBjQ
    FqDStJThg7JInR/SELjYL6qXBQmHAj4hYiGhdqPXJ2p/SSwWUOmvYGfZ1Irybt7axFFyR2
    Bns47tITnHsbUG6kOF16rF1p0unK+OF8WNV1NiZsw4NpEml731CcS4Bih6PDyTEFvgPyBI
    bPIi+yAUBLwpPJHpNonGL4AQKgAevgeU1rbzYvos2vhtQqARp/46NjdRJeg1S5gT/woXTd
    h1KhgV+SvS7GryU2udNbAuRaxsOkkxnhgbndDSUJD/Oi/40qsvSiEYOcqJ7T0T5Ehz2xTs
    ZvJJEFupfFVjrMz30kqcBsK0YNVoaUrPx931YY7nTH4X3+sllpTUeEHwJl4Q
X-ME-Proxy: <xmx:Zs7CagBLQ41HsXHyqzlQgFCbSKH3HKCwyd4pWD-f6WOxNyGG3AELvA>
    <xmx:Zs7CatIeiUCuqPxSsOSnCHhA1qJwsTPR5DIBg9l5g-eP0prhDXSSQQ>
    <xmx:Zs7CapmBTEO9o-2Eo0Xv6e1jV-YJBuVOCpNz6WdwefKVqCm6O_iOQg>
    <xmx:Zs7CamagFVRraonm6kLMTUxlS6kBIjLaZMbbczzxKd8iJinVZ2Z6Mw>
    <xmx:Zs7Came3LFEBKV251_fg_hS5toTS34L0bnyqGL3YM4VJJTbD9vI-1QEe>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Oct 2026 18:08:36 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jan Kara" <jack@suse.cz>, linux-kernel@vger.kernel.org,
 "Jeff Layton" <jlayton@kernel.org>, "Jann Horn" <jannh@google.com>,
 "Amir Goldstein" <amir73il@gmail.com>,
 "Christian Brauner (Amutable)" <brauner@kernel.org>
Subject: Re: [PATCH 17/21] nullfs: refuse file locks
In-reply-to: <20261002-work-mount-fixes-4-v1-17-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
  <20261002-work-mount-fixes-4-v1-17-dd44b89d44ce@kernel.org>
Date: Mon, 05 Oct 2026 09:08:33 +1100
Message-id: <179115171370.37859.12524843145958864322@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 02 Oct 2026, Christian Brauner wrote:
> Refuse flock() and POSIX locks on nullfs. Its one inode is the root of
> every kernel thread and the following patches make it the directory
> that stands in for an unmounted mount, so a lock taken through one such
> directory would block the locks of every other holder and F_GETLK would
> tell them the pid of the holder. Give the directory file operations of
> its own: what libfs gives an empty directory plus ->lock and ->flock
> that fail with ENOLCK, the way a filesystem without lock support does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/nullfs.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/fs/nullfs.c b/fs/nullfs.c
> index 55a04f2d7761..d90c71f5eece 100644
> --- a/fs/nullfs.c
> +++ b/fs/nullfs.c
> @@ -10,6 +10,34 @@ static const struct super_operations nullfs_super_operat=
ions =3D {
>  	.statfs	=3D simple_statfs,
>  };
> =20
> +static loff_t nullfs_dir_llseek(struct file *file, loff_t offset, int when=
ce)
> +{
> +	/* an empty directory has two entries . and .. at offsets 0 and 1 */
> +	return generic_file_llseek_size(file, offset, whence, 2, 2);
> +}
> +
> +static int nullfs_dir_readdir(struct file *file, struct dir_context *ctx)
> +{
> +	dir_emit_dots(file, ctx);
> +	return 0;
> +}
> +
> +/* the one inode of nullfs is shared by every holder, so no locks on it */
> +static int nullfs_nolock(struct file *file, int cmd, struct file_lock *fl)
> +{
> +	return -ENOLCK;
> +}
> +
> +/* what libfs gives an empty directory, plus the refusal of file locks */

It's a pity that you need separate copies for readdir and llseek -
identical to what is in libfs.

I would probably put all this code in libfs.c with make_null_dir_inode()
or similar.  But I cannot argue strongly in that direction, and the code
looks sensible as-is.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown


> +static const struct file_operations nullfs_dir_operations =3D {
> +	.llseek		=3D nullfs_dir_llseek,
> +	.read		=3D generic_read_dir,
> +	.iterate_shared	=3D nullfs_dir_readdir,
> +	.fsync		=3D noop_fsync,
> +	.lock		=3D nullfs_nolock,
> +	.flock		=3D nullfs_nolock,
> +};
> +
>  static int nullfs_fs_fill_super(struct super_block *s, struct fs_context *=
fc)
>  {
>  	struct inode *inode;
> @@ -30,6 +58,7 @@ static int nullfs_fs_fill_super(struct super_block *s, st=
ruct fs_context *fc)
> =20
>  	/* nullfs is permanently empty... */
>  	make_empty_dir_inode(inode);
> +	inode->i_fop =3D &nullfs_dir_operations;
>  	simple_inode_init_ts(inode);
>  	inode->i_ino	=3D 1;
>  	/* ... and immutable, reading it leaves no trace either. */
>=20
> --=20
> 2.53.0
>=20
>=20

