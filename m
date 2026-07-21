Received: from va-1-112.ptr.blmpb.com (va-1-112.ptr.blmpb.com [209.127.230.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0743451DA
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2026 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784633934; cv=none; b=CsShUekaB3ODj1qKDM3G9lf7oPslIIrV4dQZN3D0pOcBoxQN6XMZTqSiF+gmIpqs1wRNQBwEQo+n3b4inrauK+qcktLTT5sU/zlCSA1MKve+cIpb0ph3cQEgNkaJkF0c5g+uwwcmE18FxvL47WBr/8UIsdy/anMc13K51gUCLB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784633934; c=relaxed/simple;
	bh=TkzFHzOX5j62qGGq5uMApwTNOaFFgiuZkT2kiO/5Z1Q=;
	h=To:Subject:References:In-Reply-To:Message-Id:Cc:From:Mime-Version:
	 Content-Type:Date; b=RE20gUGNojD/UG4Hx9sxG7h1VlyoprYPzVPc+mMWYdjopep8o8ByKmCdWZChioWmxmKnhc2t+cac70z/vMn5DT4k2csBEhl4ocUzOc+/K02aVxZ87l8nHxmMxq4ybSPKPO6kq23M0rZ5LNsHBxtXll2sH4nGXCA67wEIl52g6ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=eMGmtGax; arc=none smtp.client-ip=209.127.230.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="eMGmtGax"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784633926; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=TkzFHzOX5j62qGGq5uMApwTNOaFFgiuZkT2kiO/5Z1Q=;
 b=eMGmtGaxF/igtsz2XrMJjVXlmiEJyr61GaA/+0dDWZ0KFMQd2lzaNe3roF/wS3bCp9UfsE
 dofBATgtKdGAMaaw8BjdrQQwqMDrl0avnQb4EofWvmVGGymEbyBZHdJo4Gb/TRLjCrHlW0
 EKfK8g4oWtidP8SKM744M/z4IVCYVGkxHH7LIRuuiZe0wMN5VMQaWyR0DOeocbD7DVHa9r
 e6A/JRiOtgK7vyaxNuI5Nz9CykHn1EXP5ffWJ4ipLkxkOVqF3fBIRWN+3wGc0fnF79HBTQ
 7a5gwNIhWHDZUXRZX3s+mE6cOdKZULXcXPDzKBLzr+QyV8rBB+B93iihZ8noEw==
To: "Joanne Koong" <joannelkoong@gmail.com>
Subject: Re: [PATCH v3 18/20] iomap: remove ->iomap_begin()/->iomap_end() legacy path
References: <20260720210202.1163861-1-joannelkoong@gmail.com>
	<20260720210202.1163861-19-joannelkoong@gmail.com>
In-Reply-To: <20260720210202.1163861-19-joannelkoong@gmail.com>
X-Lms-Return-Path: <lba+16a5f5a44+5060f5+vger.kernel.org+changfengnan@bytedance.com>
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.ed525b9b.50e8.484e.af0c.ccb4f8769a71@bytedance.com>
Cc: "Christian Brauner" <brauner@kernel.org>, <hch@lst.de>, 
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
From: "changfengnan" <changfengnan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 19:38:41 +0800


> From: "Joanne Koong"<joannelkoong@gmail.com>
> Date:=C2=A0 Tue, Jul 21, 2026, 05:03
> Subject:=C2=A0 [PATCH v3 18/20] iomap: remove ->iomap_begin()/->iomap_end=
() legacy path
> To: "Christian Brauner"<brauner@kernel.org>, <hch@lst.de>, "Darrick J . W=
ong"<djwong@kernel.org>, <linux-fsdevel@vger.kernel.org>
> Cc: <changfengnan@bytedance.com>, <kbusch@kernel.org>, "Matthew Wilcox"<w=
illy@infradead.org>, "Jan Kara"<jack@suse.cz>, "Jonathan Corbet"<corbet@lwn=
.net>, "David Sterba"<dsterba@suse.com>, "Dan Williams"<djbw@kernel.org>, "=
Gao Xiang"<xiang@kernel.org>, "Namjae Jeon"<linkinjeon@kernel.org>, "Theodo=
re Ts'o"<tytso@mit.edu>, "Jaegeuk Kim"<jaegeuk@kernel.org>, "Miklos Szeredi=
"<miklos@szeredi.hu>, "Andreas Gruenbacher"<agruenba@redhat.com>, "Mikulas =
Patocka"<mikulas@artax.karlin.mff.cuni.cz>, "Hyunchul Lee"<hyc.lee@gmail.co=
m>, "Konstantin Komarov"<almaz.alexandrovich@paragon-software.com>, "Carlos=
 Maiolino"<cem@kernel.org>, "Damien Le Moal"<dlemoal@kernel.org>
> With all in-tree filesystems implementing ->iomap_next(), drop the
> ->iomap_begin()/->iomap_end() path.
>=C2=A0
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Reviewed-by: Fengnan Chang <changfengnan@bytedance.com>

I ran some tests on the simple=C2=A0 path and didn't notice any
performance degradation.=C2=A0

> ---
> =C2=A0fs/iomap/direct-io.c =C2=A0| 47 ++++++++++++++---------------------=
--------
> =C2=A0fs/iomap/iter.c =C2=A0 =C2=A0 =C2=A0 | =C2=A06 +-----
> =C2=A0include/linux/iomap.h | =C2=A06 ++----
> =C2=A03 files changed, 18 insertions(+), 41 deletions(-)
>=C2=A0
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index fcdae3ef6dd0..a47369e6b4e1 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -1001,18 +1001,13 @@ iomap_dio_simple_supported(struct kiocb *iocb, st=
ruct iov_iter *iter,
> =C2=A0}
> =C2=A0
> =C2=A0static inline void
> -iomap_dio_simple_finish(struct iomap_iter *iomi, const struct iomap_ops =
*ops,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len, size=
_t written)
> +iomap_dio_simple_finish(struct iomap_iter *iomi, iomap_iter_next_fn next=
,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t written)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ops->iomap_next) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iomi->iter_start=
_pos =3D iomi->pos;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iomi->pos +=3D w=
ritten;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iomi->len -=3D w=
ritten;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ops->iomap_next(=
iomi, &iomi->iomap, &iomi->srcmap);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (ops->iomap_end) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ops->iomap_end(i=
omi->inode, iomi->pos, len, written,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 iomi->flags, &iomi->iomap);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0iomi->iter_start_pos =3D iomi->pos;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0iomi->pos +=3D written;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0iomi->len -=3D written;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0next(iomi, &iomi->iomap, &iomi->srcmap);
> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -1079,25 +1074,13 @@ iomap_dio_simple(struct kiocb *iocb, struct iov_i=
ter *iter,
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inode_dio_begin(inode);
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ops->iomap_next) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ops->iom=
ap_next(&iomi, &iomi.iomap, &iomi.srcmap);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret <=3D 0) =
{
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0inode_dio_end(inode);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/*
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 * the first iteration must yield a mapping (>0) or an
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 * error
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (WARN_ON_ONCE(!ret))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EFAULT;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return ret;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ops->iom=
ap_begin(inode, iomi.pos, count, iomi.flags,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &iomi.iomap,=
 &iomi.srcmap);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0inode_dio_end(inode);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return ret;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ops->iomap_next(&iomi, &iomi.iomap, =
&iomi.srcmap);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret <=3D 0) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inode_dio_end(in=
ode);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* the first ite=
ration must yield a mapping (>0) or an error */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (WARN_ON_ONCE=
(!ret))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0return -EFAULT;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (iomi.iomap.type !=3D IOMAP_MAPPED |=
|
> @@ -1163,7 +1146,7 @@ iomap_dio_simple(struct kiocb *iocb, struct iov_ite=
r *iter,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * iomap_next() call on the hot read pa=
th.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(dio_flags & IOMAP_DIO_NO_IOMAP_EN=
D))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iomap_dio_simple=
_finish(&iomi, ops, count, count);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iomap_dio_simple=
_finish(&iomi, ops->iomap_next, count);
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!wait_for_completion) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bio->bi_end=
_io =3D iomap_dio_simple_end_io;
> @@ -1181,7 +1164,7 @@ iomap_dio_simple(struct kiocb *iocb, struct iov_ite=
r *iter,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bio_put(bio);
> =C2=A0out_iomap_end:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(dio_flags & IOMAP_DIO_NO_IOMAP_EN=
D))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iomap_dio_simple=
_finish(&iomi, ops, count, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iomap_dio_simple=
_finish(&iomi, ops->iomap_next, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0inode_dio_end(inode);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
> diff --git a/fs/iomap/iter.c b/fs/iomap/iter.c
> index e05574602946..f7c4d5cf56be 100644
> --- a/fs/iomap/iter.c
> +++ b/fs/iomap/iter.c
> @@ -107,11 +107,7 @@ int iomap_iter(struct iomap_iter *iter, const struct=
 iomap_ops *ops)
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_iomap_iter(iter, ops, _RET_IP_);
> =C2=A0
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ops->iomap_next)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ops->iom=
ap_next(iter, &iter->iomap, &iter->srcmap);
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D iomap_it=
er_next(iter, &iter->iomap, &iter->srcmap,
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ops->iomap_begin, ops->iomap_end);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ops->iomap_next(iter, &iter->iomap, =
&iter->srcmap);
> =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iter->status =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret > 0)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 8662bd528e9e..66e2f7186299 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -194,7 +194,7 @@ struct iomap_write_ops {
> =C2=A0};
> =C2=A0
> =C2=A0/*
> - * Flags for iomap_begin / iomap_end. =C2=A0No flag implies a read.
> + * Flags for iomap_next. =C2=A0No flag implies a read.
> =C2=A0 */
> =C2=A0#define IOMAP_WRITE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(1 << 0) /* writing, must allocate blocks */
> =C2=A0#define IOMAP_ZERO =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(1 << 1) /* zeroing operation, may skip holes */
> @@ -239,8 +239,6 @@ typedef int (*iomap_iter_next_fn)(const struct iomap_=
iter *iter,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ioma=
p *iomap, struct iomap *srcmap);
> =C2=A0
> =C2=A0struct iomap_ops {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0iomap_iter_begin_fn iomap_begin;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0iomap_iter_end_fn iomap_end;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iomap_iter_next_fn iomap_next;
> =C2=A0};
> =C2=A0
> @@ -255,7 +253,7 @@ struct iomap_ops {
> =C2=A0 * =C2=A0 =C2=A0 =C2=A0 =C2=A0incremental iter advance.
> =C2=A0 * @status: Status of the most recent iteration. Zero on success or=
 a negative
> =C2=A0 * =C2=A0 =C2=A0 =C2=A0 =C2=A0errno on error.
> - * @flags: Zero or more of the iomap_begin flags above.
> + * @flags: Zero or more of the iomap_next flags above.
> =C2=A0 * @iomap: Map describing the I/O iteration
> =C2=A0 * @srcmap: Source map for COW operations
> =C2=A0 */
> --=C2=A0
> 2.52.0
>=C2=A0
