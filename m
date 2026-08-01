Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EBB34AB14
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785581152; cv=pass; b=ucyi0OA1QUVjdmmPt7fGWWXC860R5KiEILXR6C2ywhcWqarOghs7+OzA53NnLwT8gUbFHqDrO2WsxA1J4pMClZT53IoYL7enUvvMDx7jUYIvV7Zu6clGIcFJ14uDF2yIplQ0bCURVHKqce7ztqiVcQ7zTFUG3ymGh3HbjQpSw+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785581152; c=relaxed/simple;
	bh=xw0mDJ/J+46rWB6ZD8G/eCScOkTXGEEN33n4aloiE6M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mOP5JIweH6IqNa+Do/MrWcc1o0pzh69YMy2aNmGgvgGtBz7ltcGjou62xND2xyJzVZ+HwseGE3X1wGnNIPwM8Fv0J0hlHKzlxGOOJpQmIAhXpwUrBU5k8orUuqyJSm8wYYF4YhF0BT4NqT1ZdwieV9H4Y8r30IjbdMDFMVsHPTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hw+MNrLR; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hw+MNrLR"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8edda5d56a5so18574226d6.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Aug 2026 03:45:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785581149; cv=none;
        d=google.com; s=arc-20260327;
        b=LyPlelrushtD4xF4WgAtC++0TQJ7TkvpbrpnyBULVKQQ5SoAYfu479eF6a8HmmBj2c
         OwWWnsqM/a3M+jaJQ5q1124ZHf5dzFasodW4tmZysdyG9QZI+c8xpGKp1WmcLbqAA8Sk
         zhQjy0LIcSRtqxIK5nCrLxXp38lPaZ1T9KiWVtxWKyIOHctMb0zjyT49aCZVhcRiMO5s
         tEapEGEjmVxTyrF+HnDdvWl8K8KcO2OLk/KCKnrPphJV3Gpechti6pdoBscDGXHtmMgS
         DJh8Pv7pcSMlBmwqmA8mgzxfS0SP3UoM/CnKoSgd0O43WT34OCwtp6vAXlwp/l/sDQz7
         3klA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=uulZJQHRZOGVz9GVE1j0LkjMnS/Yn2XWMcuKNx0w1L4=;
        fh=xvqSoy+xVxaf3r3huTk4C7NRXbij3mD0KrK0WqXWNIw=;
        b=O2fjt3y/hMBL1xmxNdMFef8LPmWksDzKTIPv9QMlmnsTBRi6Pkpk0XIDSLAimX5KFK
         iWhawu2PeoVEyQ14YtQ+U3ybJ10Dj+PFfNekue9Mu2LbMTlV0csYXri9jM/ZsxcIX1sO
         hrJOMrARtY4ltjEggR6SFM3yodAA67Nr6RPGbLYm+o+SVmlkrTX1xa7EtbBJ8GRmsId9
         UGVCN8/LLGuugtzsZ38P9XMpIMrmq1ggXpOIeiRjTw0ji1DQ7XZfeM7s7IKj2OCq4VyT
         Ohdv46SV54NpObD5lShOybvpWvGb4gvpHxc7eqHeAi141Q+sf6UIMTifvLzOpEA8JsL9
         ujcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785581149; x=1786185949; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uulZJQHRZOGVz9GVE1j0LkjMnS/Yn2XWMcuKNx0w1L4=;
        b=Hw+MNrLRDGXc7ja+divIa7qF/52+Gp/ZuRn0vxRsYiWlrC9hZkkrzCYmgfQO1y09Zi
         nDJ2PlDj91W1C3wQt0UX1dFaRGlUkSNPnvatRHB5WdmZUGF1djZl0UE9nMPm8CkqSwqO
         h/XcSY7w9FArChQDWQVMDL4y7w+/kd0BeTMFDIlHTr0/eCseKtUOd1wSoLc9FQ1ug/4D
         E4ypp8+qDJuueGeggttgKCMDg1UOXn9nYWSa2snx2sIUIWckWlhuHYpEkFgiZTwgPwNO
         qyekXVoxSyUyGUNGH9NnmlutTh2FynOHh0bQtc1VhtWkICXQjHDQ/USBWUuo3lp7/c8c
         cdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785581149; x=1786185949;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uulZJQHRZOGVz9GVE1j0LkjMnS/Yn2XWMcuKNx0w1L4=;
        b=nBPAgEiUqs54TrDsAadnPys/czn7QWOtxX7W3DyKxrtcDAe6gq5Bh5uBPtHH1hLpnP
         HZ+eg8WpUoCCkcluLeEtFI16UuQkdtarbcUpOxHE6mEvEeFtK25cVhhtNi6oS11Rhx96
         oOa9fyF/Qy+QebK64ywXp/FFVEUrZy5rIZ/xNAQE+FX5CH1f4Mrvb+4dYL+OSflQjA5r
         nSAekIf2H8aWO/g4cSuCmqzEYynFVL7Qs6mCeseWeb2emSJFikzKMho+1r2TaeGljdjO
         Sv028BPN0+04ZFmSDLc/jrlZlvLfoensK3YcRV636eKbt1qt8sB+3ZcduahZKXv9bqLp
         pa2g==
X-Forwarded-Encrypted: i=1; AHgh+Rq2MUOvkixWRFPVQ1ExvFKvafasmJISeGSuXNiErpOKaUuBp3z0ne338v09l2nGzzgpqatnvumRjn5KFdc8@vger.kernel.org
X-Gm-Message-State: AOJu0YwYTA9Mnl9vAST/DQpIyjTMQ69v+hw9EyFCLsQQGuxjMWkMrX/H
	NlSES+QN+xcG3UI0JKdYtKgwiIIyqqeQXO05mnOZTjdWq4KXbHKASQGEx30ccKCaVnSwrGbUbyq
	oWnXlOFjP8YSVrAJMJitf6eo8zE/zUms=
X-Gm-Gg: AR+sD11Yz8kwoMpsbfvGcNrIiW3o/ZXyDWx6ZyTYyzAVFzBMS5+aDdRddwjKsCtDcs9
	GS37oOWBf5LTanYyMPBHJVnnTJry6agl/0I5+PwT4En9+5XRZga0kwbuSYbz0P7pT+DIOwgcRQ+
	wZxLR3iblRmzMPwCkU2PAu9ReE6rJM+OgzpPcpzHenF4L92Lq4d8SyPD22rN7iRaZNDta5lyEAl
	WCFl7imph4JyqSO6gSZT40wVEvqXgDihV4EXrFnPvTAP/nW8fS+0mli8w1TBgNqKGzafFfYGa7v
	fbtrDp1GvjattScQE8Glp+M0gtyvjSgx9gMFRMkA80w7uQ==
X-Received: by 2002:a05:6214:4014:b0:907:bfc0:781e with SMTP id
 6a1803df08f44-90849673497mr56715356d6.30.1785581149291; Sat, 01 Aug 2026
 03:45:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?xJDhu6ljIEPhuqNuaCBOZ3V54buFbg==?= <0206canh@gmail.com>
Date: Sat, 1 Aug 2026 17:45:37 +0700
X-Gm-Features: AUfX_mxSpiLlXpuQywhIuudO-6Ranqkb740b_MCeiEXPY-SlY4DJuNS9ya--BAM
Message-ID: <CALFmVm4k=ZKZ_f02L9fB4-kWyPVWrF2iDx0yFr2wsCcL8pizwQ@mail.gmail.com>
Subject: [PATCH] freevxfs: fix divide-by-zero in vxfs_bmap_ext4() causing oops
 on mount
To: hch@infradead.org
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000020176d0657fa02b8"

--00000000000020176d0657fa02b8
Content-Type: multipart/alternative; boundary="00000000000020176c0657fa02b6"

--00000000000020176c0657fa02b6
Content-Type: text/plain; charset="UTF-8"

vxfs_bmap_ext4() divides by attacker-controlled values from the on-disk
inode without fully validating them.  A crafted VxFS image triggers a
kernel "divide error" (oops) as soon as it is mounted -- no read or
ioctl is required.  The crash is reached from vxfs_fill_super() ->
vxfs_iget() -> vxfs_get_page() -> vxfs_read_folio() -> vxfs_bmap1() ->
vxfs_bmap_ext4().

Two independent paths hit the division by zero:

1. ve4_indsize == 0: line 62 computes the denominator
   (indsize * indsize * bsize / 4) == 0.  The existing guard
   (line 52) only rejects indsize > s_blocksize, so 0 gets through.

2. bn == 0: if block 0 is not covered by the first direct extent
   (size == 0), bn stays 0 after the direct-extent loop.  With
   indsize > 0 the expression at line 73,
   indir[(bn / indsize) % (indsize * bn)], becomes 0 % 0.

Reproduced in QEMU on a 7.0.0-28-generic kernel:

  Oops: divide error: 0000 [#1] SMP NOPTI
  RIP: 0010:vxfs_bmap_ext4+0xfc/0x1c0 [freevxfs]
  RAX: 0000000000000000 RBX: 0000000000000000 RDX: 0000000000000000
  Call Trace:
    vxfs_bmap_ext4+0xfc/0x1c0 [freevxfs]
    vxfs_bmap1+0x42/0x70 [freevxfs]
    vxfs_getblk+0x17/0x70 [freevxfs]
    block_read_full_folio+0x109/0x270
    vxfs_read_folio+0x18/0x30 [freevxfs]
    vxfs_get_page+0x13/0x40 [freevxfs]
    __vxfs_iget+0x3a/0xd0 [freevxfs]
    vxfs_iget+0x5b/0x1a0 [freevxfs]
    vxfs_fill_super+0x159/0x340 [freevxfs]
    get_tree_bdev_flags+0x141/0x1e0
    ...
    __x64_sys_mount+0x12b/0x160

Reject indsize == 0 up front and bail out when the logical block is 0.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: canhnguyen26 (Nguyen Duc Canh) <0206canh@gmail.com>
---
 fs/freevxfs/vxfs_bmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/freevxfs/vxfs_bmap.c b/fs/freevxfs/vxfs_bmap.c
index e85222892038..4c2a5b42df3c 100644
--- a/fs/freevxfs/vxfs_bmap.c
+++ b/fs/freevxfs/vxfs_bmap.c
@@ -49,7 +49,7 @@ vxfs_bmap_ext4(struct inode *ip, long bn)
  unsigned long bsize = sb->s_blocksize;
  u32 indsize = fs32_to_cpu(sbi, vip->vii_ext4.ve4_indsize);
  int i;

- if (indsize > sb->s_blocksize)
+ if (indsize == 0 || indsize > sb->s_blocksize)
  goto fail_size;

  for (i = 0; i < VXFS_NDADDR; i++) {
@@ -62,7 +62,8 @@ vxfs_bmap_ext4(struct inode *ip, long bn)
  bn -= fs32_to_cpu(sbi, d->size);
  }

- if ((bn / (indsize * indsize * bsize / 4)) == 0) {
+ if (bn == 0)
+ goto fail_buf;
+ if ((bn / (indsize * indsize * bsize / 4)) == 0) {
  struct buffer_head *buf;
  daddr_t bno;
  __fs32 *indir;
-- 
2.39.5

--00000000000020176c0657fa02b6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">vxfs_bmap_ext4() divides by attacker-controlled values fro=
m the on-disk<br>inode without fully validating them.=C2=A0 A crafted VxFS =
image triggers a<br>kernel &quot;divide error&quot; (oops) as soon as it is=
 mounted -- no read or<br>ioctl is required.=C2=A0 The crash is reached fro=
m vxfs_fill_super() -&gt;<br>vxfs_iget() -&gt; vxfs_get_page() -&gt; vxfs_r=
ead_folio() -&gt; vxfs_bmap1() -&gt;<br>vxfs_bmap_ext4().<br><br>Two indepe=
ndent paths hit the division by zero:<br><br>1. ve4_indsize =3D=3D 0: line =
62 computes the denominator<br>=C2=A0 =C2=A0(indsize * indsize * bsize / 4)=
 =3D=3D 0.=C2=A0 The existing guard<br>=C2=A0 =C2=A0(line 52) only rejects =
indsize &gt; s_blocksize, so 0 gets through.<br><br>2. bn =3D=3D 0: if bloc=
k 0 is not covered by the first direct extent<br>=C2=A0 =C2=A0(size =3D=3D =
0), bn stays 0 after the direct-extent loop.=C2=A0 With<br>=C2=A0 =C2=A0ind=
size &gt; 0 the expression at line 73,<br>=C2=A0 =C2=A0indir[(bn / indsize)=
 % (indsize * bn)], becomes 0 % 0.<br><br>Reproduced in QEMU on a 7.0.0-28-=
generic kernel:<br><br>=C2=A0 Oops: divide error: 0000 [#1] SMP NOPTI<br>=
=C2=A0 RIP: 0010:vxfs_bmap_ext4+0xfc/0x1c0 [freevxfs]<br>=C2=A0 RAX: 000000=
0000000000 RBX: 0000000000000000 RDX: 0000000000000000<br>=C2=A0 Call Trace=
:<br>=C2=A0 =C2=A0 vxfs_bmap_ext4+0xfc/0x1c0 [freevxfs]<br>=C2=A0 =C2=A0 vx=
fs_bmap1+0x42/0x70 [freevxfs]<br>=C2=A0 =C2=A0 vxfs_getblk+0x17/0x70 [freev=
xfs]<br>=C2=A0 =C2=A0 block_read_full_folio+0x109/0x270<br>=C2=A0 =C2=A0 vx=
fs_read_folio+0x18/0x30 [freevxfs]<br>=C2=A0 =C2=A0 vxfs_get_page+0x13/0x40=
 [freevxfs]<br>=C2=A0 =C2=A0 __vxfs_iget+0x3a/0xd0 [freevxfs]<br>=C2=A0 =C2=
=A0 vxfs_iget+0x5b/0x1a0 [freevxfs]<br>=C2=A0 =C2=A0 vxfs_fill_super+0x159/=
0x340 [freevxfs]<br>=C2=A0 =C2=A0 get_tree_bdev_flags+0x141/0x1e0<br>=C2=A0=
 =C2=A0 ...<br>=C2=A0 =C2=A0 __x64_sys_mount+0x12b/0x160<br><br>Reject inds=
ize =3D=3D 0 up front and bail out when the logical block is 0.<br><br>Fixe=
s: 1da177e4c3f4 (&quot;Linux-2.6.12-rc2&quot;)<br>Signed-off-by: canhnguyen=
26 (Nguyen Duc Canh) &lt;<a href=3D"mailto:0206canh@gmail.com">0206canh@gma=
il.com</a>&gt;<br>---<br>=C2=A0fs/freevxfs/vxfs_bmap.c | 4 +++-<br>=C2=A01 =
file changed, 3 insertions(+), 1 deletion(-)<br><br>diff --git a/fs/freevxf=
s/vxfs_bmap.c b/fs/freevxfs/vxfs_bmap.c<br>index e85222892038..4c2a5b42df3c=
 100644<br>--- a/fs/freevxfs/vxfs_bmap.c<br>+++ b/fs/freevxfs/vxfs_bmap.c<b=
r>@@ -49,7 +49,7 @@ vxfs_bmap_ext4(struct inode *ip, long bn)<br>=C2=A0	uns=
igned long bsize =3D sb-&gt;s_blocksize;<br>=C2=A0	u32 indsize =3D fs32_to_=
cpu(sbi, vip-&gt;vii_ext4.ve4_indsize);<br>=C2=A0	int i;<br>=C2=A0<br>-	if =
(indsize &gt; sb-&gt;s_blocksize)<br>+	if (indsize =3D=3D 0 || indsize &gt;=
 sb-&gt;s_blocksize)<br>=C2=A0		goto fail_size;<br>=C2=A0<br>=C2=A0	for (i =
=3D 0; i &lt; VXFS_NDADDR; i++) {<br>@@ -62,7 +62,8 @@ vxfs_bmap_ext4(struc=
t inode *ip, long bn)<br>=C2=A0		bn -=3D fs32_to_cpu(sbi, d-&gt;size);<br>=
=C2=A0	}<br>=C2=A0<br>-	if ((bn / (indsize * indsize * bsize / 4)) =3D=3D 0=
) {<br>+	if (bn =3D=3D 0)<br>+		goto fail_buf;<br>+	if ((bn / (indsize * in=
dsize * bsize / 4)) =3D=3D 0) {<br>=C2=A0		struct buffer_head *buf;<br>=C2=
=A0		daddr_t	bno;<br>=C2=A0		__fs32 *indir;<br>-- <br>2.39.5<br></div>

--00000000000020176c0657fa02b6--
--00000000000020176d0657fa02b8
Content-Type: text/x-patch; charset="US-ASCII"; name="freevxfs-fix-divide-by-zero.patch"
Content-Disposition: attachment; 
	filename="freevxfs-fix-divide-by-zero.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_msa8wkvu0>
X-Attachment-Id: f_msa8wkvu0

ZGlmZiAtLWdpdCBhL2ZzL2ZyZWV2eGZzL3Z4ZnNfYm1hcC5jIGIvZnMvZnJlZXZ4ZnMvdnhmc19i
bWFwLmMKLS0tIGEvZnMvZnJlZXZ4ZnMvdnhmc19ibWFwLmMKKysrIGIvZnMvZnJlZXZ4ZnMvdnhm
c19ibWFwLmMKQEAgLTQ5LDcgKzQ5LDcgQEAgdnhmc19ibWFwX2V4dDQoc3RydWN0IGlub2RlICpp
cCwgbG9uZyBibikKIAl1bnNpZ25lZCBsb25nIGJzaXplID0gc2ItPnNfYmxvY2tzaXplOwogCXUz
MiBpbmRzaXplID0gZnMzMl90b19jcHUoc2JpLCB2aXAtPnZpaV9leHQ0LnZlNF9pbmRzaXplKTsK
IAlpbnQgaTsKIAotCWlmIChpbmRzaXplID4gc2ItPnNfYmxvY2tzaXplKQorCWlmIChpbmRzaXpl
ID09IDAgfHwgaW5kc2l6ZSA+IHNiLT5zX2Jsb2Nrc2l6ZSkKIAkJZ290byBmYWlsX3NpemU7CiAK
IAlmb3IgKGkgPSAwOyBpIDwgVlhGU19OREFERFI7IGkrKykgewpAQCAtNjIsNyArNjIsOCBAQCB2
eGZzX2JtYXBfZXh0NChzdHJ1Y3QgaW5vZGUgKmlwLCBsb25nIGJuKQogCQlibiAtPSBmczMyX3Rv
X2NwdShzYmksIGQtPnNpemUpOwogCX0KIAotCWlmICgoYm4gLyAoaW5kc2l6ZSAqIGluZHNpemUg
KiBic2l6ZSAvIDQpKSA9PSAwKSB7CisJaWYgKGJuID09IDApCisJCWdvdG8gZmFpbF9idWY7CisJ
aWYgKChibiAvIChpbmRzaXplICogaW5kc2l6ZSAqIGJzaXplIC8gNCkpID09IDApIHsKIAkJc3Ry
dWN0IGJ1ZmZlcl9oZWFkICpidWY7CiAJCWRhZGRyX3QJYm5vOwogCQlfX2ZzMzIgKmluZGlyOwo=
--00000000000020176d0657fa02b8--
