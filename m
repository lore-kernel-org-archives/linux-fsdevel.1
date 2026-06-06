Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25F531715A
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 08:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780734104; cv=none; b=Msutbs2Mka4mjVa8u13QPJsF/VNE8x+rix01T+Mq6zX5VB0+BMFeSHtJ/GDPmTVbwHcz7ETUhNf6O87NG0qtTcSSIJu4IQHM+UT11jzdBiqFOtrCnK3okP/p15QnbxR35pK6Fd5RKDsM3joF8l0xEG/6zw5sjlAnTar/XAnVGc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780734104; c=relaxed/simple;
	bh=nHejhsIfeJuaXTY01mr9HNqqMY8jn50uROXEEzlAnSQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/h6olRYHzecLFi0O9+bX0etYIwa/Fsv0ESSfKGA7bWWfcyxDOcYKHO/xa4LIkOjC6UB7wqe+l/0Qcwf8mQvdx5WeV6BY8CTU2UwxrHfBXuQFyPbXYU8++4VJm0o6NauPAdTavkhvmnxZqVAFMB4uxOfrcIpJsUP2r/n7T1MbsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=a+byetKl; arc=none smtp.client-ip=79.135.106.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="a+byetKl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=gi4cosge6zgcbgjrdyfs7phpbm.protonmail; t=1780734097; x=1780993297;
	bh=s/zihKOq1Ep7P1soX/FqpAMcaSeZt5ktnyeRrSV9INM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=a+byetKl4zUfZLidDhzuEsPnycgd7uZYETQc/HsqUMDoFJUaNvfz5a5ibcvANKs7f
	 x1yUeGzLYO/SU4R6y9MI7g1Y/Vbjp7Kz2QzyiUVUrypzMSwEk5lfHHsN7dvg7NxzE8
	 d7AsS5dvtLtc5q1hpSM+Icgj9MBaB1Tstl5C4lLXxpfSBNcF52R5rNi2aauTm5uamx
	 JzTM0g0QceXUskbD9kgsU2eTIVX0/TYo5bPt6fzjq54NFb8GAVHcYoQXmGShrQ1S59
	 OS39U0JcfYGIX2pSmRxmswb65zgSbZOuzo94tnPU7v4HMzIZi9UDido7Oa7suc9d9p
	 Pc09JO7I1ryKw==
Date: Sat, 06 Jun 2026 08:21:32 +0000
To: Anders Larsen <al@alarsen.net>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] fs/qnx4: validate the extent count before walking the extent block
Message-ID: <a450ab64e05e4b07e4ecef0130ce3a0bdf38eb74.1780733712.git.hexlabsecurity@proton.me>
In-Reply-To: <cover.1780733712.git.hexlabsecurity@proton.me>
References: <cover.1780733712.git.hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 1de4bad1586a76fe6efc9c40d4786413b463f11d
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

qnx4_block_map() follows the on-disk extent chain. For each extent block
(struct qnx4_xblk, one 512-byte QNX4 block) it walks xblk->xblk_xtnts[ix]
using xblk->xblk_num_xtnts as the loop bound:

=09block =3D try_extent(&xblk->xblk_xtnts[ix], &offset);
=09...
=09if (++ix >=3D xblk->xblk_num_xtnts) { ... ix =3D 0; }

xblk_xtnts[] is a fixed QNX4_MAX_XTNTS_PER_XBLK (60) array, but
xblk_num_xtnts is an on-disk u8 (up to 255) that is never validated. A
crafted image with xblk_num_xtnts > 60 makes ix walk past xblk_xtnts[60],
reading past the end of the 512-byte extent block (an out-of-bounds read
of the buffer_head data).

Reject an extent count larger than the array, right after the "IamXblk"
signature check.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Everything below the --- is dropped by git am.

Class / impact: CWE-125 out-of-bounds read (root CWE-129). Reachable only
by mounting a crafted qnx4 image (CAP_SYS_ADMIN; not unprivileged-userns
mountable) and reading a file with a long extent chain. Read-only, no write
primitive; on a live mount the 512-byte block shares a 4096-byte page-cache
page so the read lands in adjacent in-page data of the same image -> a
robustness/hardening fix.

Affected: present since fs/qnx4/inode.c entered git at v2.6.12-rc2 (the
extent walk predates git). Verified at mainline v7.1-rc6 and stable
v6.12.92.

Reproducer: a qnx4 image whose file uses an indirect extent block
("IamXblk") with xblk_num_xtnts > 60 (e.g. 255); mount and read that file.

A/B verification (CONFIG_KASAN_GENERIC=3Dy, kasan.fault=3Dreport, x86-64). =
The
on-disk extent block is exactly 512 bytes; reproduced on a kmalloc(512)
copy of the walk so KASAN sees the boundary:
  - Without this patch (xblk_num_xtnts =3D 255):
      BUG: KASAN: slab-out-of-bounds in <qnx4 xtnt walk>
      Read of size 4 ... located 4 bytes to the right of the 512-byte
        region (cache kmalloc-512)
  - Control (xblk_num_xtnts =3D 5): no report.
  - With this patch (xblk_num_xtnts =3D 255): no report, block rejected -EI=
O.
  Also an ABI-invariant AddressSanitizer extraction (-m64 and -m32):
  heap-buffer-overflow read without the patch, clean with it.

 fs/qnx4/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 3828ba7d4492..f244e197e2df 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -112,6 +112,12 @@ unsigned long qnx4_block_map( struct inode *inode, lon=
g iblock )
 =09=09=09=09=09brelse(bh);
 =09=09=09=09=09return -EIO;
 =09=09=09=09}
+=09=09=09=09if (xblk->xblk_num_xtnts > QNX4_MAX_XTNTS_PER_XBLK) {
+=09=09=09=09=09QNX4DEBUG((KERN_ERR "qnx4: bad xtnt count %u\n",
+=09=09=09=09=09=09   xblk->xblk_num_xtnts));
+=09=09=09=09=09brelse(bh);
+=09=09=09=09=09return -EIO;
+=09=09=09=09}
 =09=09=09}
 =09=09=09block =3D try_extent(&xblk->xblk_xtnts[ix], &offset);
 =09=09=09if (block) {
--=20
2.43.0


