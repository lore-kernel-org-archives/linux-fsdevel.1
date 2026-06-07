Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC492DECB2;
	Sun,  7 Jun 2026 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780814522; cv=none; b=HZdo3stz9UmSycIPn+FUu72Beu8elJ4BngCo7PlOInfOZDq+qMr/CFDwpQShwKGizg4RDB9ggk34WGtpsgWOwOUwg13jendqA9yLuKxfB5l00ygk0FkdAJ2bmTN7nNYOj0+6/cdYKX+c5vodVwDrSO6QWS6vJS/BG8LkvDhWUqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780814522; c=relaxed/simple;
	bh=BuiSfxqDRqy+bZd1DDJdaeMdjXpeMvAcnPTxMBU/cBo=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZWqknEUAPzt8ymuXHK54gk76kIoZ4tAmGQOcI+x0y33jU0uhxLupqnpxzRPcoHRgTZ3N+85Taim3bFSVJ0JHTtpYmXB0PGzvET4DI6byg1i2mBRFVHsF+iwnguBqWwavkq0GNpyGdTGaVI3sQV4EDI6OkBKeEs655UhtLUWjzus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SOfgBux8; arc=none smtp.client-ip=109.224.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SOfgBux8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=hl3rxk3g3zeibjpbkndxqgvdx4.protonmail; t=1780814516; x=1781073716;
	bh=ouxlaolgQp+Gc3+2G3Aor3mUeIjJ+oLThyUA98+rHQI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SOfgBux8ntD21c44NYVCfIHeVkEA+sqGTRydExS92UAgWgb+FxEnrZn3otCOe+lRY
	 ptr5Q9eAS3G2razxFkRxG0Lw7TFfk5eDJoPgAaZPjoJH+SC0eN2+qYDVwV4H1xl0JM
	 krzBhPk1p/1JcmfyNsY74XldIYvylqThVfY9zd25YKMrNBJR54KVJw+VtxUKyXjeKY
	 1EFxDj2RaC+OvQSzQrHD94amAo3q0lq2rWentyVEW4d+ZNbdJ2srMaAD2uPqQjK4/S
	 xRYp8RYk1UMQaR2f+JgrINB2ZnPQiRzbAge0G51ut9ZFgVZzULqE3GB5l7Q5jn8Xhq
	 snh5C4I+Vg4cw==
Date: Sun, 07 Jun 2026 06:41:50 +0000
To: Nicolas Pitre <nico@fluxnic.net>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cramfs: bound the XIP direct-mapping reads to the image size
Message-ID: <20260607064146.302647-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 1668ab6b1a046ac4c87d1648c0d05d8993f4bd88
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The physically-mapped (XIP) fast path dereferences the linear filesystem
image directly using offsets taken from the on-disk inode.  Unlike the
normal read path (cramfs_direct_read()), cramfs_get_block_range() and
cramfs_last_page_is_shared() do not check those offsets against the image
size before dereferencing:

=09blockptrs =3D (u32 *)(sbi->linear_virt_addr + OFFSET(inode) + pgoff * 4)=
;
=09first_block_addr =3D blockptrs[0] & ~CRAMFS_BLK_FLAGS;

OFFSET(inode) (the inode data offset) and the block pointers are read
from the untrusted on-disk image.  A crafted cramfs image with the
CRAMFS_FLAG_EXT_BLOCK_POINTERS feature and an out-of-range inode offset
makes the block-pointer read -- and the subsequent tail-data scan in
cramfs_last_page_is_shared() -- dereference memory outside the mapped
image.  mmap()ing a regular file on such an image then faults in the
kernel (page fault in cramfs_physmem_mmap()).

Bound every linear-image dereference in the XIP path to sbi->size, the
same way cramfs_direct_read() already does, and fall back to the bounded
paging path on any out-of-range access.

Fixes: eddcd97659e3 ("cramfs: add mmap support")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Reproduced on v7.1-rc6 with KASAN, CONFIG_CRAMFS_MTD + MTD_MTDRAM (a small
RAM-backed mtd as the linear cramfs backing).  A crafted cramfs image with
CRAMFS_FLAG_EXT_BLOCK_POINTERS set and a regular file whose on-disk inode
offset is out of range, mounted over the mtd backend, faults the kernel whe=
n
the file is mmap()ed:

  BUG: unable to handle page fault for address ...
  #PF: supervisor read access in kernel mode
  RIP: ... cramfs_physmem_mmap+0x...
   __mmap_region
   mmap_region
   do_mmap
   vm_mmap_pgoff
   ksys_mmap_pgoff

A control image with an in-range offset maps and reads cleanly.  With this
patch the crafted image's XIP fast path detects the out-of-range offset and
falls back to the bounded paging path; no fault occurs.

 fs/cramfs/inode.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 4edbfccd0bbe..014072a65c5b 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -298,13 +298,22 @@ static u32 cramfs_get_block_range(struct inode *inode=
, u32 pgoff, u32 *pages)
 {
 =09struct cramfs_sb_info *sbi =3D CRAMFS_SB(inode->i_sb);
 =09int i;
-=09u32 *blockptrs, first_block_addr;
+=09u32 *blockptrs, first_block_addr, data_addr;
=20
 =09/*
 =09 * We can dereference memory directly here as this code may be
 =09 * reached only when there is a direct filesystem image mapping
 =09 * available in memory.
+=09 *
+=09 * The block pointer array lives at OFFSET(inode) inside the image.
+=09 * OFFSET() and the block pointers are taken from the (untrusted)
+=09 * on-disk inode, so bound every access to the image the same way
+=09 * cramfs_direct_read() does before dereferencing it.
 =09 */
+=09if (OFFSET(inode) > sbi->size ||
+=09    ((u64)pgoff + *pages) * 4 > sbi->size - OFFSET(inode))
+=09=09return 0;
+
 =09blockptrs =3D (u32 *)(sbi->linear_virt_addr + OFFSET(inode) + pgoff * 4=
);
 =09first_block_addr =3D blockptrs[0] & ~CRAMFS_BLK_FLAGS;
 =09i =3D 0;
@@ -324,7 +333,14 @@ static u32 cramfs_get_block_range(struct inode *inode,=
 u32 pgoff, u32 *pages)
 =09} while (++i < *pages);
=20
 =09*pages =3D i;
-=09return first_block_addr << CRAMFS_BLK_DIRECT_PTR_SHIFT;
+
+=09/* The mapped data range must also lie within the image. */
+=09data_addr =3D first_block_addr << CRAMFS_BLK_DIRECT_PTR_SHIFT;
+=09if (data_addr > sbi->size ||
+=09    (u64)*pages * PAGE_SIZE > sbi->size - data_addr)
+=09=09return 0;
+
+=09return data_addr;
 }
=20
 #ifdef CONFIG_MMU
@@ -345,9 +361,21 @@ static bool cramfs_last_page_is_shared(struct inode *i=
node)
 =09if (!partial)
 =09=09return false;
 =09last_page =3D inode->i_size >> PAGE_SHIFT;
+
+=09/*
+=09 * The block pointer and the tail data are read directly from the
+=09 * image at offsets derived from the untrusted on-disk inode; bound
+=09 * both accesses to the image.  On any overflow treat the last page
+=09 * as shared so the caller falls back to the bounded paging path.
+=09 */
+=09if (OFFSET(inode) > sbi->size ||
+=09    ((u64)last_page + 1) * 4 > sbi->size - OFFSET(inode))
+=09=09return true;
 =09blockptrs =3D (u32 *)(sbi->linear_virt_addr + OFFSET(inode));
 =09blockaddr =3D blockptrs[last_page] & ~CRAMFS_BLK_FLAGS;
 =09blockaddr <<=3D CRAMFS_BLK_DIRECT_PTR_SHIFT;
+=09if (blockaddr > sbi->size || sbi->size - blockaddr < PAGE_SIZE)
+=09=09return true;
 =09tail_data =3D sbi->linear_virt_addr + blockaddr + partial;
 =09return memchr_inv(tail_data, 0, PAGE_SIZE - partial) ? true : false;
 }
--=20
2.43.0


