Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=182.48.54.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620428;
	b=z+c7bzCuphp0/VAV+nU9EwtoM+IMAjlY93Y5nPc0EzLZZgyA7XT45+ug/CAwwVYsp+aq
	 ep0FDwxtafmHDjj0GqysL/4xmd3sFsRQ5dWW7pmL3OkOiCrCGy00cE0DctlSlZYDget0y
	 qvdjGTmlHX1IsE05ZXEm0AyAk9j9ybxIxMqy67FsCD4kmGH4H2x1VNx63IeBS6Ls6V7hn
	 NYAYyEky3L6ev5rOOuDMIIZ0ztcR3bTbR8DEAe/a3Mgdme5cGspbql9Uio4+hb2w2wY39
	 QxbWF6ph477bFIPhOZDVH/0rVPwSYc5immixRC+RZvQYEui42jXtL+QKgyNz38hTCAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620428;
	h=DMARC-Filter:Received:From:Date:To:Cc:Subject:Message-ID;
	bh=q/mvSpaiJ3B2JktFdG89NvAVaEYEJyhRx8XQe7Y8qLQ=;
	b=oCZYH+qkawT5IuMLeAebyMDGjjEdyaDaYdGeMQehYjtYuQT7587peKFQV89LyoknvzzM
	 CPn+qTxQoTvs3VOfRl24EyaCrIu7wIITYVQ7EoWD/Ol4u1kOCQipkvcA+CO/d7QOZHdiX
	 iXLBJb5xfcjcQqoAlYfv1jmokT4EKwJN1YfzFMy5LNLCD9D66Hmyg1Tbp/zNC0hcUpLTJ
	 meknr/WySwkmG2EpPCRuSLUfy49ybIw8+XLzSMqGAbf1JkK7JWPZprmrALgNOn3h7chkz
	 y/Cl5TP7G324z2Eq/o3lJzfcTCQViu4zeK9EpE9JOuuaXGuROEeB81BqXGvLiNQ/YKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=snowrabbit.org;
	spf=pass smtp.mailfrom=snowrabbit.org;
	arc=none smtp.remote-ip=182.48.54.220
Received: from bambi.snowrabbit.org (bambi.snowrabbit.org [182.48.54.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E11B606A323;
	Wed, 25 Nov 2026 15:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E11B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snowrabbit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snowrabbit.org
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id CBFA7C9314; Thu, 26 Nov 2026 00:27:05 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
Date: Thu, 26 Nov 2026 00:26:47 +0900
To: Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Showta Ishizaki <zakinko@snowrabbit.org>
Subject: [PATCH v2] ufs: mount filesystems on disks with 4K logical blocks
Message-ID: <20261126-ufs-06-v2@snowrabbit.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list

A UFS made by FreeBSD with its default 4K fragments does not mount when
the disk has 4K logical blocks:

  # losetup --sector-size 4096 /dev/loop0 ufs2.img
  # mount -t ufs -o ro,ufstype=ufs2 /dev/loop0 /mnt

fails, and the kernel logs "ufs: failed to set blocksize".

ufs_fill_super() starts from the block size each flavour usually has,
512 bytes for 44bsd and ufs2, only to read the superblock, and
sb_set_blocksize() cannot go below the logical block size of the
device.  Start from the logical block size where it is the larger of
the two.  The fragment size in the superblock takes over afterwards, as
it did before.

A filesystem whose fragments are smaller than a logical block still
cannot be used on such a disk.  Say so, instead of failing to set the
block size.

I tried it with loop devices of 512, 1024, 2048 and 4096 byte sectors.
UFS1 and UFS2 images made on FreeBSD 15.0 with 4K fragments mount on all
of them, and ones made on NetBSD with 1K fragments on the first two.
The contents of all 5037 files match the SHA-256 recorded where the
image was made, and files written were the same after a remount.  On
2048 and 4096 the NetBSD ones are refused with the new message.  With
512 the results are the same with and without the patch.

fsck_ffs on FreeBSD finds nothing wrong in the UFS1 one written with
4096 byte sectors.  In the UFS2 one it reports the check hashes, which
Linux does not keep, and the cylinder group it rebuilds for that; it
reports the same for one written with 512 byte sectors without the
patch.

Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
v2: round the superblock size up instead of taking the larger one.  With
    1024 byte logical blocks 1536 is not a multiple of the block size and
    the mount failed without a message.  With 512, 2048 and 4096 it gives
    the same sizes as v1; fsck_ffs was run with v1.
v1: https://lore.kernel.org/linux-fsdevel/20261125112449.392FFC9314@bambi.snowrabbit.org/

 fs/ufs/super.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 3569ac92b..4e1bb7578 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -725,6 +725,7 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct ufs_buffer_head * ubh;	
 	struct inode *inode;
 	unsigned block_size, super_block_size;
+	unsigned int logical_size;
 	unsigned flags;
 	unsigned super_block_offset;
 	unsigned maxsymlen;
@@ -922,6 +923,25 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 		goto failed;
 	}
 	
+	/*
+	 * The sizes above are what each flavour usually has, and are only
+	 * used to read the superblock.  The buffer cache cannot use a block
+	 * smaller than the device's logical block, so on a disk with 4K
+	 * logical blocks they could not even do that, and a filesystem with
+	 * 4K fragments was refused before its superblock was looked at.
+	 * Read it in logical blocks instead; the fragment size it gives then
+	 * takes over below, as before.
+	 */
+	logical_size = bdev_logical_block_size(sb->s_bdev);
+	if (block_size < logical_size) {
+		block_size = logical_size;
+		super_block_size = round_up(super_block_size, logical_size);
+		uspi->s_fsize = block_size;
+		uspi->s_fmask = ~(block_size - 1);
+		uspi->s_fshift = (unsigned int)ilog2(block_size);
+		uspi->s_sbsize = super_block_size;
+	}
+
 again:	
 	if (!sb_set_blocksize(sb, block_size)) {
 		pr_err("failed to set blocksize\n");
@@ -1033,6 +1053,11 @@ static int ufs_fill_super(struct super_block *sb, struct fs_context *fc)
 		       __func__, uspi->s_bsize / uspi->s_fsize);
 		goto failed;
 	}
+	if (uspi->s_fsize < logical_size) {
+		pr_err("%s(): fragment size %u is smaller than the device's logical block size %u\n",
+		       __func__, uspi->s_fsize, logical_size);
+		goto failed;
+	}
 	if (uspi->s_fsize != block_size || uspi->s_sbsize != super_block_size) {
 		ubh_brelse_uspi(uspi);
 		ubh = NULL;

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
