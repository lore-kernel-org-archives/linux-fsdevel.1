Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D774D3DA7E0
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 21:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840460; cv=none; b=tA+DjFWqT7Yb4jwVat2JfucX54HlNzVB/z0II7GnrIAUDZHhKhwKKJkUhomkIMsKaOUIBMjc2YoRJAIy/+bmJzl4YPNJhP6ASFSUQnCLX2TTL2022Jxw/zv++7/s0j803qlOg0R3fIxN29Wg+udZXHFJfVdOjwWRiLXKOjXxSkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840460; c=relaxed/simple;
	bh=poRP7bkdu+pHP29KgUY3au9YK62nm4psItoe/7pMQes=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gnTe7vI7J6lPGpH87hK4Zzu5f2ZOBRmdtMQyw/ZbUojpOI1hapHX72WZtVEhnmmyA5X4RMplvPf0NbowAipAPf1ZyzBklpHotDHYvmAoh63o5L5YJgluhCKV3NiTgx0G5WdV1IVAv901uhl1qwjPLflNx/kH28LV9D01JZIuP4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cUFkaEwo; arc=none smtp.client-ip=79.135.106.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cUFkaEwo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791840454; x=1792099654;
	bh=poRP7bkdu+pHP29KgUY3au9YK62nm4psItoe/7pMQes=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=cUFkaEwoN4O/yIzb+RC0coXrb6c2FwZJHCumriotwq+cxSMc5+6lHaapK0BHRCwj7
	 DL8435W9UlJGLgOUcnXy08RD+WYm40vogArXyG3ipKREjhmlWtPJ8kSu3qPW8Z24H5
	 mfl8DmLhOYvchC+4ZD3xITUZa1v4ay+QtGOX+A9Ygm4qLMQrURHUzYQYrwrXpf3QtP
	 Qb2MXSYL2kQ1uteYn9kp86w2POH7gKT2bD3+XHAfjUDT6e2nzJRme6FAhNyanepVgB
	 dl4BSNlL0yv2SnCBR8klx5i2MdC4tH++cz5h2EZhsUZeVHQENVN1US8Ys0QW+KBngO
	 1X/4xgLLfLPCA==
Date: Mon, 12 Oct 2026 21:27:32 +0000
To: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From: kerhunt <kerhunt@proton.me>
Cc: "al@alarsen.net" <al@alarsen.net>
Subject: =?utf-8?Q?[PATCH/report]_qnx4:_OOB_read_in_qnx4=5Fblock=5Fmap()_=E2=80=94_xblk=5Fnum=5Fxtnts_not_validated_against_QNX4=5FMAX=5FXTNTS=5FPER=5FXBLK?=
Message-ID: <lFkvlZiS6r6eoluUzuePTelWdD4Z7Vx5SbEhV7qUqYcDJUtoXpyLVDm3cA05RHQ0CqR5-vnhJtEsghutpE3rlXwC3czdrydo1f1sG-t4CqA=@proton.me>
Feedback-ID: 227694322:user:proton
X-Pm-Message-ID: 844b03cb8eb2613960e9462e9a9b392ff39efe31
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi linux-fsdevel,
Out-of-bounds READ in qnx4_block_map() (fs/qnx4/inode.c) =E2=80=94 the
extent count read from disk is never validated against the fixed
array size, allowing OOB accesses past the extent array and past
the buffer_head, with the OOB-read values subsequently used to map
disk sectors whose contents are returned to userspace.

=3D=3D AFFECTED =3D=3D

- Linux 6.12.112 (linux-6.12.y stable), commit 7aba70ab
- Linux mainline, HEAD 24a19b953e2a (torvalds/linux), as of this report

The pattern appears unchanged since the filesystem was introduced
(1998); no validation of this count was found in mainline as of
this writing.

=3D=3D ROOT CAUSE =3D=3D

struct qnx4_xblk (include/uapi/linux/qnx4_fs.h:71-80) has a fixed
extent array:

=C2=A0 =C2=A0 __u8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xblk_num_xtnts;=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* from disk */
=C2=A0 =C2=A0 qnx4_xtnt_t =C2=A0 =C2=A0 xblk_xtnts[QNX4_MAX_XTNTS_PER_XBLK]=
; =C2=A0/* =3D 60 */

qnx4_block_map() (fs/qnx4/inode.c:84-133) walks the extent chain
using ONLY the disk-controlled count as the loop limit:

=C2=A0 =C2=A0 u16 nxtnt =3D le16_to_cpu(qnx4_inode->di_num_xtnts); =C2=
=A0 /* :91 */
=C2=A0 =C2=A0 ...
=C2=A0 =C2=A0 block =3D try_extent(&xblk->xblk_xtnts[ix], &offset); =C2=
=A0/* :115 */
=C2=A0 =C2=A0 if ( ++ix >=3D xblk->xblk_num_xtnts ) { ... } =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0/* :120 */

xblk_num_xtnts is __u8 (up to 255), read from the on-disk extent
block; nothing compares it against QNX4_MAX_XTNTS_PER_XBLK (60) or
against the size of the buffer_head (1024 bytes).

=3D=3D OOB ARITHMETIC =3D=3D

- ix =3D 60..~127: reads past xblk_xtnts[] into xblk_signature /
=C2=A0 xblk_first_xtnt / block slack =E2=80=94 still inside the 1024-byte b=
h.
- ix >=3D ~128: reads past the entire bh->b_data =E2=80=94 slab
=C2=A0 out-of-bounds read.
- The OOB-read extents feed try_extent() =E2=86=92 xtnt_blk / xtnt_size
=C2=A0 become kernel-memory values read out of bounds, and
=C2=A0 qnx4_get_block() maps them via map_bh(): an arbitrary-sector
=C2=A0 mapping derived from out-of-bounds kernel memory. A subsequent
=C2=A0 read() returns those sectors' contents to userspace =E2=80=94 a kern=
el
=C2=A0 information leak.

Additionally, sb_bread(inode->i_sb, i_xblk - 1) with i_xblk =3D=3D 0
(from a crafted inode) computes sector (sector_t)-1 =E2=80=94 an underflow
in the block layer path (secondary hardening issue).

=3D=3D REPRODUCTION OUTLINE =3D=3D

1. Craft a qnx4 image where an inode's extent chain points to an
=C2=A0 =C2=A0xblk with signature "IamXblk" and xblk_num_xtnts =3D 255.
2. Mount the image (FS_REQUIRES_DEV =E2=80=94 requires privileges).
3. Read() past the first 60 extents of the file =E2=80=94 qnx4_block_map()
=C2=A0 =C2=A0walks past the fixed array, reading OOB extents, and the file
=C2=A0 =C2=A0contents are served from sectors derived from OOB kernel memor=
y.

(KASAN confirms the slab-out-of-bounds read on the xblk array under
this access pattern.)

=3D=3D IMPACT =3D=3D

- Kernel memory disclosure to userspace via crafted on-disk
=C2=A0 metadata (CWE-125), plus block-layer sector underflow.
- Reachability requires mounting a crafted block device
=C2=A0 (CAP_SYS_ADMIN); this is an info-leak/hardening issue rather
=C2=A0 than a privilege escalation.

=3D=3D PROPOSED FIX =3D=3D

Validate the disk count immediately after the signature check:

=C2=A0 =C2=A0 if (xblk->xblk_num_xtnts > QNX4_MAX_XTNTS_PER_XBLK) {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 brelse(bh);
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EIO;
=C2=A0 =C2=A0 }

and (optionally, second hardening) reject i_xblk =3D=3D 0 before the
sb_bread() call. Both are one-line changes localized to
qnx4_block_map().

=3D=3D NOTES =3D=3D

- Found by static analysis of the 6.12.y stable tree,
=C2=A0 cross-verified against mainline. I have not built a dynamic
=C2=A0 proof-of-concept; I can attempt one on request if useful.
- Happy to test the patch; please credit "kerhunt
=C2=A0 <kerhunt@proton.me>".
- Anders (CC'd): the proposed fix is the two-line validation in
=C2=A0 qnx4_block_map() described under PROPOSED FIX =E2=80=94 happy to sen=
d
=C2=A0 it as a formal patch to your tree if you prefer.

Best regards,
kerhunt
