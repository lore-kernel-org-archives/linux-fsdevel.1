Received: from va-1-111.ptr.blmpb.com (va-1-111.ptr.blmpb.com [209.127.230.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE18F30C164
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784703881; cv=none; b=SROeWTRdhJzfNbXClMC6SOQKx/a7hqR/nxOcdHvT7njFfmZiXpDB2J7G/ymYHy1K+5iYzMQ3iqusOQUKQRsAWIgnGJuBB6TTxWvV2JWa3QYiGXNcRNnQCLIA6eZv77O+pbRwDHWXFh5WraOphDMjv2cQgMu1rQ/yfiDfPZGkWXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784703881; c=relaxed/simple;
	bh=DRA0a8e9ueKtxGunzBV9ENtnFTLSE+RKdaotcNFWl7w=;
	h=Date:Message-Id:Cc:Mime-Version:In-Reply-To:Content-Type:To:
	 Subject:From:References; b=ULdvVH3y8rEJG7aTcHtK6rC4/DmF/mle5EWRl6gGEyX3+ygwTywU+AzGCMJG8jouvL7obMqKHgU/uo49FV0fvkzinvw5DzBNTGDQ562X2TNfZOADbBvvzm/w/e4I6ELrzWTZ/kKnb/+rhLhbGR9AljY5+cmF8o2a0FA2vhFXybo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Vk6OWBzu; arc=none smtp.client-ip=209.127.230.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Vk6OWBzu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784703870; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=DRA0a8e9ueKtxGunzBV9ENtnFTLSE+RKdaotcNFWl7w=;
 b=Vk6OWBzux8zfpgygQxGM0Rn20nxphSTcd0pb6mhn2rRx00U+JgmqqSRfGMSbydXXshMCGm
 kbHgeeZ7IjGd4Hp9GJ0kcV4euUJxe2bOX94i7OCc+4fJTshlpXO+TXx9/U6TFUfFlR+J5T
 MiCabs5JlGXCwDPAPmRHg60vYp73HXIISN9NHnOdKTM3gY0ND8ab8yRV7aHRoKKA99OxDW
 V9JhTZFKiYYyuH3HYtOj+VjbjFHxYOwNob3/ZqnLVWNWh6CDEo0Xl9Wu1YfFRSVD3YRww6
 gXd1Xsxlbg3dUYxYLWfXYwquxrriIvfE7bIco6FKeauuJi7eWEhkAaQsWF7iDQ==
X-Lms-Return-Path: <lba+16a606b7c+80bed0+vger.kernel.org+changfengnan@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 15:04:24 +0800
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.7d28bf40.2201.47ab.bf41.5b700aefabf7@bytedance.com>
Cc: "Joanne Koong" <joannelkoong@gmail.com>, 
	"Christian Brauner" <brauner@kernel.org>, <hch@lst.de>, 
	"Darrick J . Wong" <djwong@kernel.org>, <linux-fsdevel@vger.kernel.org>, 
	<kbusch@kernel.org>, "Matthew Wilcox" <willy@infradead.org>, 
	"Jan Kara" <jack@suse.cz>, "Jonathan Corbet" <corbet@lwn.net>, 
	"David Sterba" <dsterba@suse.com>, "Dan Williams" <djbw@kernel.org>, 
	"Gao Xiang" <xiang@kernel.org>, "Namjae Jeon" <linkinjeon@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, "Jaegeuk Kim" <jaegeuk@kernel.org>, 
	"Miklos Szeredi" <miklos@szeredi.hu>, 
	"Andreas Gruenbacher" <agruenba@redhat.com>, 
	"Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>, 
	"Hyunchul Lee" <hyc.lee@gmail.com>, 
	"Konstantin Komarov" <almaz.alexandrovich@paragon-software.com>, 
	"Carlos Maiolino" <cem@kernel.org>, 
	"Damien Le Moal" <dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260721142842.GA11935@lst.de>
Content-Type: text/plain; charset=UTF-8
To: "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH v3 00/20] iomap: convert to in-iter iomap_next() model
From: "changfengnan" <changfengnan@bytedance.com>
References: <20260720210202.1163861-1-joannelkoong@gmail.com>
	<20260721142842.GA11935@lst.de>


> From: "Christoph Hellwig"<hch@lst.de>
> Date:=C2=A0 Tue, Jul 21, 2026, 22:29
> Subject:=C2=A0 Re: [PATCH v3 00/20] iomap: convert to in-iter iomap_next(=
) model
> To: "Joanne Koong"<joannelkoong@gmail.com>
> Cc: "Christian Brauner"<brauner@kernel.org>, <hch@lst.de>, "Darrick J . W=
ong"<djwong@kernel.org>, <linux-fsdevel@vger.kernel.org>, <changfengnan@byt=
edance.com>, <kbusch@kernel.org>, "Matthew Wilcox"<willy@infradead.org>, "J=
an Kara"<jack@suse.cz>, "Jonathan Corbet"<corbet@lwn.net>, "David Sterba"<d=
sterba@suse.com>, "Dan Williams"<djbw@kernel.org>, "Gao Xiang"<xiang@kernel=
.org>, "Namjae Jeon"<linkinjeon@kernel.org>, "Theodore Ts'o"<tytso@mit.edu>=
, "Jaegeuk Kim"<jaegeuk@kernel.org>, "Miklos Szeredi"<miklos@szeredi.hu>, "=
Andreas Gruenbacher"<agruenba@redhat.com>, "Mikulas Patocka"<mikulas@artax.=
karlin.mff.cuni.cz>, "Hyunchul Lee"<hyc.lee@gmail.com>, "Konstantin Komarov=
"<almaz.alexandrovich@paragon-software.com>, "Carlos Maiolino"<cem@kernel.o=
rg>, "Damien Le Moal"<dlemoal@kernel.org>
> The submission seems to be missing most of the relevant mailing lists,
> e.g., xfs for iomap itself and the file system-specific lists.
>=C2=A0
> For now I didn't have too much time to look at it, and the little I had
> I used to jump on the simple direct I/O thing, as that's the only part
> that stood out as something I didn't like. =C2=A0The new "don't advance t=
he
> iter" magic flag just didn't feel right.
>=C2=A0
> What I came up with is the patch below which sits ontop of your entire
> series. =C2=A0I redoes the simple read path very heavily and now requires=
 the
> file system to opt in, and provide the begin callback only, i.e. we
> require the file system to only call it if it can, which simplifies the
> logic a lot, but requires more care from the file systems, and exposing
> the old iomap_begin callback.
>=C2=A0
> Fengnan, can you check if this keeps your performance? =C2=A0It does more
> inlining and avoid the direct call, but hopefully doesn't inline too
> much like the previous attempt. =C2=A0If this works, it probably needs
> to move before the conversion.

Hi Christoph,
I tested the simple direct I/O path and did not observe any performance
degradation.

>=C2=A0
> ---
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index adda6342de5b..67b226edb287 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -809,8 +809,8 @@ static ssize_t exfat_file_read_iter(struct kiocb *ioc=
b, struct iov_iter *iter)
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iocb->ki_flags & IOCB_DIRECT) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file_access=
ed(iocb->ki_filp);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iomap_di=
o_rw(iocb, iter, exfat_iomap_next, NULL,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IOMAP_DIO_NO_IOMAP_END, NULL, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iomap_di=
o_rw(iocb, iter, exfat_iomap_next, NULL, 0, NULL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D gen=
eric_file_read_iter(iocb, iter);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 755fde1baf03..66d281d00d3e 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -4004,6 +4004,8 @@ static inline void ext4_clear_io_unwritten_flag(ext=
4_io_end_t *io_end)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0io_end->fla=
g &=3D ~EXT4_IO_END_UNWRITTEN;
> =C2=A0}
> =C2=A0
> +inline int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t l=
ength,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned flags, =
struct iomap *iomap, struct iomap *srcmap);
> =C2=A0int ext4_iomap_next(const struct iomap_iter *iter, struct iomap *io=
map,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ioma=
p *srcmap);
> =C2=A0int ext4_iomap_next_report(const struct iomap_iter *iter, struct io=
map *iomap,
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index bf0c18cf1017..491854e93f92 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -91,8 +91,10 @@ static ssize_t ext4_dio_read_iter(struct kiocb *iocb, =
struct iov_iter *to)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return gene=
ric_file_read_iter(iocb, to);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iomap_dio_rw(iocb, to, ext4_iomap_ne=
xt, NULL,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 IOMAP_DIO_NO_IOMAP_END, NULL, 0);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iomap_dio_read_simple(iocb, to, ext4=
_iomap_begin);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -ENOTBLK)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iomap_di=
o_rw(iocb, to, ext4_iomap_next, NULL, 0, NULL, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inode_unlock_shared(inode);
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file_accessed(iocb->ki_filp);
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index f455708a8c31..973ee7a97f61 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3771,7 +3771,7 @@ static int ext4_iomap_alloc(struct inode *inode, st=
ruct ext4_map_blocks *map,
> =C2=A0}
> =C2=A0
> =C2=A0
> -static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t l=
ength,
> +inline int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t l=
ength,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned fl=
ags, struct iomap *iomap, struct iomap *srcmap)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index 9c50adc93cfa..33c2c6d3e134 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -894,6 +894,21 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *=
iter,
> =C2=A0}
> =C2=A0EXPORT_SYMBOL_GPL(__iomap_dio_rw);
> =C2=A0
> +ssize_t
> +iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter, iomap_iter_next_=
fn next,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct iom=
ap_dio_ops *dops, unsigned int dio_flags,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *private, s=
ize_t done_before)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iomap_dio *dio;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0dio =3D __iomap_dio_rw(iocb, iter, next, dop=
s, dio_flags, private,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 done_before);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR_OR_NULL(dio))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR_O=
R_ZERO(dio);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return iomap_dio_complete(dio);
> +}
> +EXPORT_SYMBOL_GPL(iomap_dio_rw);
> +
> =C2=A0struct iomap_dio_simple {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct kiocb =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*iocb;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size;
> @@ -968,159 +983,47 @@ static void iomap_dio_simple_end_io(struct bio *bi=
o)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iocb->ki_complete(iocb, iomap_dio_simpl=
e_complete(sr));
> =C2=A0}
> =C2=A0
> -static inline bool
> -iomap_dio_simple_supported(struct kiocb *iocb, struct iov_iter *iter,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 const struct iomap_dio_ops *dops,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 unsigned int dio_flags, size_t done_before)
> +ssize_t __iomap_dio_simple(struct kiocb *iocb, struct iov_iter *iter,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iomap_iter_begin=
_fn begin, struct iomap_iter *iomi)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0struct inode *inode =3D file_inode(iocb->ki_=
filp);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t count =3D iov_iter_count(iter);
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dops || done_before)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iov_iter_rw(iter) !=3D READ)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!count)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Simple dio is an optimization for small I=
O. Filter out large IO
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 * early as it's the most common case to fai=
l for typical direct IO
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 * workloads.
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (count > inode->i_sb->s_blocksize)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dio_flags & (IOMAP_DIO_FORCE_WAIT | IOMA=
P_DIO_PARTIAL |
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 IOMAP_DIO_BOUNCE))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iocb->ki_pos + count > i_size_read(inode=
))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ENCRYPTED(inode))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return false;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;
> -}
> -
> -static inline void
> -iomap_dio_simple_finish(struct iomap_iter *iomi, iomap_iter_next_fn next=
,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t written)
> -{
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0iomi->iter_start_pos =3D iomi->pos;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0iomi->pos +=3D written;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0iomi->len -=3D written;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0next(iomi, &iomi->iomap, &iomi->srcmap);
> -}
> -
> -/*
> - * Fast path for small, block-aligned direct I/Os that map to a single
> - * contiguous on-disk extent.
> - *
> - * iomap_dio_simple_supported() enforces the cheap up-front constraints =
before
> - * entering this path.
> - *
> - * @dops must be NULL: a non-NULL @dops means the caller wants its
> - * ->end_io / ->submit_io hooks invoked, and in particular wants its bio=
s to be
> - * allocated from the filesystem-private @dops->bio_set (whose front_pad=
 sizes a
> - * filesystem-private wrapper around the bio). =C2=A0The fast path inste=
ad allocates
> - * from the shared iomap_dio_simple_pool, whose front_pad matches struct
> - * iomap_dio_simple; the two wrappers are not interchangeable, so we mus=
t fall
> - * back to __iomap_dio_rw() in that case.
> - *
> - * @done_before must be zero: a non-zero caller-accumulated residual can=
not be
> - * carried through a single-bio inline completion.
> - *
> - * @iter must describe a non-empty READ no larger than the inode block s=
ize:
> - * writes, zero-length I/O, and larger requests need the generic iomap d=
irect
> - * I/O path.
> - *
> - * @dio_flags must not request IOMAP_DIO_FORCE_WAIT, IOMAP_DIO_PARTIAL, =
or
> - * IOMAP_DIO_BOUNCE: this path does not support forced waiting, partial =
direct
> - * I/O, or bouncing. =C2=A0The range must also stay within i_size and en=
crypted
> - * inodes must use the generic iomap direct I/O path. IOMAP_DIO_NO_IOMAP=
_END is
> - * a fast-path optimization the caller can set if there is no work that =
needs to
> - * be finished after a mapping.
> - *
> - * -ENOTBLK is the private sentinel returned by iomap_dio_simple() when =
it
> - * decides the request does not fit the fast path. =C2=A0In that case we=
 proceed to
> - * the generic __iomap_dio_rw() slow path. =C2=A0Any other errno is a re=
al result and
> - * is propagated as-is, in particular -EAGAIN for IOCB_NOWAIT must reach=
 the
> - * caller.
> - */
> -static ssize_t
> -iomap_dio_simple(struct kiocb *iocb, struct iov_iter *iter,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iomap_iter_next=
_fn next, void *private, unsigned int dio_flags)
> -{
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0struct inode *inode =3D file_inode(iocb->ki_=
filp);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t count =3D iov_iter_count(iter);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0bool wait_for_completion =3D is_sync_kiocb(i=
ocb);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iomap_iter iomi =3D {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.inode =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D inode,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.pos =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D iocb->ki_pos,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.len =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D count,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D IOMAP_DIRECT,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.private =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=3D private,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0};
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iomap_dio_simple *sr;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int alignment;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct bio *bio;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t ret;
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iocb->ki_flags & IOCB_NOWAIT)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iomi.flags |=3D =
IOMAP_NOWAIT;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D kiocb_write_and_wait(iocb, count);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0inode_dio_begin(inode);
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D next(&iomi, &iomi.iomap, &iomi.srcma=
p);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret <=3D 0) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inode_dio_end(in=
ode);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* the first ite=
ration must yield a mapping (>0) or an error */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (WARN_ON_ONCE=
(!ret))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EFAULT;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iomi.iomap.type !=3D IOMAP_MAPPED ||
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iomi.iomap.offset + iomi.iomap=
.length < iomi.pos + count ||
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(iomi.iomap.flags & IOMAP_F_IN=
TEGRITY)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -ENOTBLK=
;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_iomap_e=
nd;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iomi->iomap.type !=3D IOMAP_MAPPED ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iomi->iomap.offset + iomi->iom=
ap.length < iomi->pos + iomi->len ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(iomi->iomap.flags & IOMAP_F_I=
NTEGRITY))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTBLK;
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0alignment =3D iomap_dio_alignment(inode, iom=
i.iomap.bdev, dio_flags);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((iomi.pos | count) & (alignment - 1)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EINVAL;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_iomap_e=
nd;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0alignment =3D iomap_dio_alignment(iomi->inod=
e, iomi->iomap.bdev, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((iomi->pos | iomi->len) & (alignment - 1=
))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!wait_for_completion && unlikely(!inode-=
>i_sb->s_dio_done_wq)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D sb_init_=
dio_done_wq(inode->i_sb);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(!iomi->inode->i_sb->s_dio_done_=
wq &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0!is_sync_kiocb(iocb))) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D sb_init_=
dio_done_wq(iomi->inode->i_sb);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret < 0=
)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0goto out_iomap_end;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return ret;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_iomap_dio_rw_begin(iocb, iter, dio_fla=
gs, 0);
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (user_backed_iter(iter))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dio_flags |=3D I=
OMAP_DIO_USER_BACKED;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_iomap_dio_rw_begin(iocb, iter, 0, 0);
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0bio =3D bio_alloc_bioset(iomi.iomap.bdev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0bio =3D bio_alloc_bioset(iomi->iomap.bdev,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bio_iov_vecs_to_alloc(iter, BIO_MAX_=
VECS),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 REQ_OP_READ, GFP_KERNEL, &iomap_dio_=
simple_pool);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sr =3D container_of(bio, struct iomap_d=
io_simple, bio);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sr->iocb =3D iocb;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0sr->dio_flags =3D dio_flags;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0sr->dio_flags =3D 0;
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0bio->bi_iter.bi_sector =3D iomap_sector(&iom=
i.iomap, iomi.pos);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0bio->bi_iter.bi_sector =3D iomap_sector(&iom=
i->iomap, iomi->pos);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bio->bi_ioprio =3D iocb->ki_ioprio;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D bio_iov_iter_get_pages(bio, ite=
r, alignment - 1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (unlikely(ret))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_bi=
o_put;
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bio->bi_iter.bi_size !=3D count) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (bio->bi_iter.bi_size !=3D iomi->len) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iov_iter_re=
vert(iter, bio->bi_iter.bi_size);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EN=
OTBLK;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out_bi=
o_release_pages;
> @@ -1128,68 +1031,35 @@ iomap_dio_simple(struct kiocb *iocb, struct iov_i=
ter *iter,
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sr->size =3D bio->bi_iter.bi_size;
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dio_flags & IOMAP_DIO_USER_BACKED)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (user_backed_iter(iter)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bio_set_pag=
es_dirty(bio);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sr->dio_flags |=
=3D IOMAP_DIO_USER_BACKED;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iocb->ki_flags & IOCB_NOWAIT)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bio->bi_opf=
 |=3D REQ_NOWAIT;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((iocb->ki_flags & IOCB_HIPRI) && !wait_f=
or_completion) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bio->bi_opf |=3D=
 REQ_POLLED;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WRITE_ONCE(iocb-=
>private, bio);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The finishing iomap_iter() only runs the =
filesystem's iomap_end()
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 * work and releases any attached folio batc=
h. =C2=A0When the caller promised
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 * neither applies (IOMAP_DIO_NO_IOMAP_END),=
 skip it to avoid an extra
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 * iomap_next() call on the hot read path.
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(dio_flags & IOMAP_DIO_NO_IOMAP_END))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iomap_dio_simple=
_finish(&iomi, next, count);
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!wait_for_completion) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bio->bi_end_io =
=3D iomap_dio_simple_end_io;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0submit_bio(bio);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_iomap_dio_=
rw_queued(inode, iocb->ki_pos, count);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIOCBQUE=
UED;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (is_sync_kiocb(iocb)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0submit_bio_wait(=
bio);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return iomap_dio=
_simple_complete(sr);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0submit_bio_wait(bio);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0return iomap_dio_simple_complete(sr);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((iocb->ki_flags & IOCB_HIPRI)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bio->bi_opf |=3D=
 REQ_POLLED;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WRITE_ONCE(iocb-=
>private, bio);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0bio->bi_end_io =3D iomap_dio_simple_end_io;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0submit_bio(bio);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_iomap_dio_rw_queued(iomi->inode, iocb-=
>ki_pos, iomi->len);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIOCBQUEUED;
> =C2=A0
> =C2=A0out_bio_release_pages:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bio_release_pages(bio, false);
> =C2=A0out_bio_put:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bio_put(bio);
> -out_iomap_end:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(dio_flags & IOMAP_DIO_NO_IOMAP_END))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iomap_dio_simple=
_finish(&iomi, next, 0);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0inode_dio_end(inode);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
> -
> -ssize_t
> -iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter, iomap_iter_next_=
fn next,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct iom=
ap_dio_ops *dops, unsigned int dio_flags,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *private, s=
ize_t done_before)
> -{
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iomap_dio *dio;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t ret;
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iomap_dio_simple_supported(iocb, iter, d=
ops, dio_flags,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 done_before)=
) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iomap_di=
o_simple(iocb, iter, next, private, dio_flags);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=3D -EN=
OTBLK)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return ret;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> -
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0dio =3D __iomap_dio_rw(iocb, iter, next, dop=
s, dio_flags, private,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 done_before);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR_OR_NULL(dio))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR_O=
R_ZERO(dio);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0return iomap_dio_complete(dio);
> -}
> -EXPORT_SYMBOL_GPL(iomap_dio_rw);
> +EXPORT_SYMBOL_GPL(__iomap_dio_simple);
> =C2=A0
> =C2=A0static int __init iomap_dio_init(void)
> =C2=A0{
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 012c073c9b01..d36a77b854aa 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -127,8 +127,7 @@ DEFINE_RANGE_EVENT(iomap_zero_iter);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{IOMAP_DIO_FORCE_WAIT, =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"DIO_FORCE_WAIT" }, \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{IOMAP_DIO_OVERWRITE_ONLY, =C2=A0 =C2=
=A0 =C2=A0 =C2=A0"DIO_OVERWRITE_ONLY" }, \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{IOMAP_DIO_PARTIAL, =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"DIO_PARTIAL" }, \
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0{IOMAP_DIO_FSBLOCK_ALIGNED, =C2=A0 =C2=A0 =
=C2=A0 =C2=A0"DIO_FSBLOCK_ALIGNED" }, \
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0{IOMAP_DIO_NO_IOMAP_END, =C2=A0 =C2=A0 =C2=
=A0 =C2=A0"DIO_NO_IOMAP_END" }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0{IOMAP_DIO_FSBLOCK_ALIGNED, =C2=A0 =C2=A0 =
=C2=A0 =C2=A0"DIO_FSBLOCK_ALIGNED" }
> =C2=A0
> =C2=A0DECLARE_EVENT_CLASS(iomap_class,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TP_PROTO(struct inode *inode, struct io=
map *iomap),
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 24c621ac984a..a4f99128b46c 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -458,8 +458,8 @@ static ssize_t ntfs_file_read_iter(struct kiocb *iocb=
, struct iov_iter *to)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file_access=
ed(iocb->ki_filp);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iomap_di=
o_rw(iocb, to, ntfs_read_iomap_next, NULL,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0IOMAP_DIO_NO_IOMAP_END, NULL, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iomap_di=
o_rw(iocb, to, ntfs_read_iomap_next, NULL, 0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D gen=
eric_file_read_iter(iocb, to);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index ea709e4c9607..877f9024d333 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -251,8 +251,6 @@ xfs_file_dio_read(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iov_iter =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*to)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct xfs_inode =C2=A0 =C2=A0 =C2=A0 =
=C2=A0*ip =3D XFS_I(file_inode(iocb->ki_filp));
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dio_flags =3D IOMAP_DIO_NO_IOMAP_END;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct iomap_dio_ops *dio_ops =3D NULL=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret;
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_xfs_file_direct_read(iocb, to);
> @@ -266,11 +264,15 @@ xfs_file_dio_read(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mapping_stable_writes(iocb->ki_filp=
->f_mapping)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dio_ops =3D &xfs=
_dio_read_bounce_ops;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dio_flags |=3D I=
OMAP_DIO_BOUNCE;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iomap_di=
o_rw(iocb, to, xfs_read_iomap_next,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&xfs_dio_read_bounce_ops, IOMAP_DI=
O_BOUNCE,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iomap_di=
o_read_simple(iocb, to, xfs_read_iomap_begin);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret =3D=3D -=
ENOTBLK)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ret =3D iomap_dio_rw(iocb, to, xfs_read_iomap_next, NULL,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, NUL=
L, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iomap_dio_rw(iocb, to, xfs_read_ioma=
p_next, dio_ops, dio_flags,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0NULL, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xfs_iunlock(ip, XFS_IOLOCK_SHARED);
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index 1314c95f7416..534cdf537224 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -2167,7 +2167,7 @@ xfs_buffered_write_iomap_end(
> =C2=A0DEFINE_IOMAP_ITER_NEXT_END(xfs_buffered_write_iomap_next,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xfs_buffere=
d_write_iomap_begin, xfs_buffered_write_iomap_end);
> =C2=A0
> -static int
> +inline int
> =C2=A0xfs_read_iomap_begin(
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct inode =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*inode,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loff_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0offset,
> diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
> index 01875d20fb66..d271db75d891 100644
> --- a/fs/xfs/xfs_iomap.h
> +++ b/fs/xfs/xfs_iomap.h
> @@ -55,6 +55,9 @@ int xfs_direct_write_iomap_next(const struct iomap_iter=
 *iter,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ioma=
p *iomap, struct iomap *srcmap);
> =C2=A0int xfs_zoned_direct_write_iomap_next(const struct iomap_iter *iter=
,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ioma=
p *iomap, struct iomap *srcmap);
> +inline int xfs_read_iomap_begin(struct inode *inode, loff_t offset,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0loff_t length, u=
nsigned flags, struct iomap *iomap,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iomap *sr=
cmap);
> =C2=A0int xfs_read_iomap_next(const struct iomap_iter *iter, struct iomap=
 *iomap,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ioma=
p *srcmap);
> =C2=A0int xfs_seek_iomap_next(const struct iomap_iter *iter, struct iomap=
 *iomap,
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 519613f281aa..368be7e87c6a 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -10,6 +10,7 @@
> =C2=A0#include <linux/mm_types.h>
> =C2=A0#include <linux/blkdev.h>
> =C2=A0#include <linux/folio_batch.h>
> +#include <linux/pagemap.h>
> =C2=A0
> =C2=A0struct address_space;
> =C2=A0struct fiemap_extent_info;
> @@ -668,14 +669,6 @@ struct iomap_dio_ops {
> =C2=A0 */
> =C2=A0#define IOMAP_DIO_BOUNCE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(1 << 4)
> =C2=A0
> -/*
> - * The caller's ->iomap_next() has no ->iomap_end() work to run and this=
 I/O
> - * does not use a folio batch, so the iomap_dio_simple() fast path may s=
kip the
> - * finishing iomap_iter() call entirely. =C2=A0Only meaningful on the si=
mple read
> - * fast path; ignored by the generic __iomap_dio_rw() slow path.
> - */
> -#define IOMAP_DIO_NO_IOMAP_END =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0(1 << 5)
> -
> =C2=A0ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iomap_iter_=
next_fn next, const struct iomap_dio_ops *dops,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned in=
t dio_flags, void *private, size_t done_before);
> @@ -685,6 +678,70 @@ struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb,=
 struct iov_iter *iter,
> =C2=A0ssize_t iomap_dio_complete(struct iomap_dio *dio);
> =C2=A0void iomap_dio_bio_end_io(struct bio *bio);
> =C2=A0
> +/*
> + * Fast path for small, block-aligned direct I/Os that map to a single
> + * contiguous on-disk extent.
> + *
> + * @iter must describe a non-empty READ no larger than the inode block s=
ize:
> + * writes, zero-length I/O, and larger requests need the generic iomap d=
irect
> + * I/O path.
> + *
> + * Does not support iomap_dio_ops, dio_flags, done_before or private dat=
a.
> + * The range must also stay within i_size and encrypted inodes must use =
the
> + * generic iomap direct I/O path.
> + *
> + * -ENOTBLK inidicates the generic path must be used by the caller inste=
ad.
> + * Any other errno is a real result and is propagated as-is, in particul=
ar
> + * -EAGAIN for IOCB_NOWAIT must reach the caller.
> + *
> + * The caller can only provide an iomap begin handler, and the iterator
> + * is never advanced.
> + */
> +ssize_t __iomap_dio_simple(struct kiocb *iocb, struct iov_iter *iter,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iomap_iter_begin=
_fn begin, struct iomap_iter *iomi);
> +static __always_inline ssize_t iomap_dio_read_simple(struct kiocb *iocb,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iov_iter =
*iter, iomap_iter_begin_fn begin)
> +{
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iomap_iter iomi =3D {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.inode =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D file_inode(iocb->ki_fil=
p),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.pos =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D iocb->ki_pos,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.len =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D iov_iter_count(iter),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.flags =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D IOMAP_DIRECT,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0};
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ssize_t ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!iomi.len)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Simple dio is an optimization for small I=
O. Filter out large IO
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * early as it's the most common case to fai=
l for typical direct IO
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 * workloads.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iomi.len > iomi.inode->i_sb->s_blocksize=
)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTBLK;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iocb->ki_pos + iomi.len > i_size_read(io=
mi.inode))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTBLK;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ENCRYPTED(iomi.inode))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOTBLK;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D kiocb_write_and_wait(iocb, iomi.len)=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iocb->ki_flags & IOCB_NOWAIT)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iomi.flags |=3D =
IOMAP_NOWAIT;
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0inode_dio_begin(iomi.inode);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D begin(iomi.inode, iomi.pos, iomi.len=
, iomi.flags, &iomi.iomap,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&iomi.srcmap);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ret)=C2=A0
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D __iomap_=
dio_simple(iocb, iter, begin, &iomi);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret <=3D 0 && ret !=3D -EIOCBQUEUED)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inode_dio_end(io=
mi.inode);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> +}
> +
> =C2=A0#ifdef CONFIG_SWAP
> =C2=A0struct file;
> =C2=A0struct swap_info_struct;
>=C2=A0
