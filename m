Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=182.48.54.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605897;
	b=u8W7b4YEEoWKlNr52WBhap74Drf9NABec5FiXF50lVp21RMm5GUnb8X/9dwbzWVTo7Wf
	 xlNRlZLUys6i41btc2+dQqz5SaXuwtEPB4GF2BQ3ssYwRpW0xxcd0vrYRX1uyUmHnpli/
	 DmYksVoqnbqcb67zbU2xVTuL+kWCy7UeLTF1U88pLyzasKHTXh4dzNpWqLxcy5akgkU2T
	 xqTW+U+MlNozGIV88MY2pY9O95jP5Ir8artplxxLLqIeeizj2uDY8LITLG22y2uxxvtXw
	 5d4LUWk1feULVAgtJ6SSVmlU37xI8ETiZgSbn4wVipMLf1RnisWjudiDOGABp8xDCGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605897;
	h=DMARC-Filter:Received:From:Date:Subject:To:Cc:Message-Id;
	bh=1UrqxeCooPRnOwiqPC3no5IYvXN2UbiYVeYhqdcmMmM=;
	b=2uhKCTQTwhyB9ugGAJG0sUAYMUuQkoqFUS85gF8dYE9htA4CWKgTKwwZgnOpqavyGvkm
	 /QrAmZf9jjbvPrVtcllPqTMjU+HKYRJwNTm2jGvjz+VHLrAZnrNTX0Nc6/OzVNtZXGIst
	 1VUwHJaU6t4W7e3PXnZmj5i8osOPNu/fY2GFUQrKl+XWHrPm9aLm79sRn7hYs4tJF3dEr
	 jznielzrWFglCAp8xGM/mCo2SIWBo55xPJlD2JicYkSVM2nHxr+LXTpnuGctONC/8+IKH
	 31kAF9SARkfBxHI+8b8+NztZ4g5o31JSPj7BJPERTdwccFmNAMf1S9Ur1fvLoltOYPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=snowrabbit.org;
	spf=pass smtp.mailfrom=snowrabbit.org;
	arc=none smtp.remote-ip=182.48.54.220
Received: from bambi.snowrabbit.org (bambi.snowrabbit.org [182.48.54.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C54606A31E;
	Wed, 25 Nov 2026 11:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07C54606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=snowrabbit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snowrabbit.org
Received: by bambi.snowrabbit.org (Postfix, from userid 3001)
	id 392FFC9314; Wed, 25 Nov 2026 20:24:49 +0900 (JST)
From: Showta Ishizaki <zakinko@snowrabbit.org>
Date: Wed, 25 Nov 2026 20:20:22 +0900
Subject: [PATCH] ufs: mount filesystems on disks with 4K logical blocks
To: Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
    linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Showta Ishizaki <zakinko@snowrabbit.org>
Message-Id: <20261125112449.392FFC9314@bambi.snowrabbit.org>
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

I tried it with loop devices of 512 and 4096 byte sectors.  With 4096,
UFS1 and UFS2 images made on FreeBSD 15.0 now mount, and the contents of
all 5037 files match the SHA-256 recorded on FreeBSD.  Files written
there were the same after a remount.  fsck_ffs on FreeBSD finds nothing
wrong in the UFS1 one.  In the UFS2 one it reports the check hashes,
which Linux does not keep, and the cylinder group it rebuilds for that;
it reports the same for one written with 512 byte sectors without the
patch.  Images with 1K fragments from NetBSD are refused with the new
message.  With 512 the results are the same with and without the patch.

Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
---
 fs/ufs/super.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 3569ac92b..da7520b5f 100644
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
+		super_block_size = max(super_block_size, logical_size);
+		uspi->s_fsize = block_size;
+		uspi->s_fmask = ~(block_size - 1);
+		uspi->s_fshift = (unsigned int)ilog2(block_size);
+		uspi->s_sbsize = super_block_size;
+	}
+
 again:	
 	if (!sb_set_blocksize(sb, block_size)) {
 		pr_err("failed to set blocksize\n");
@@ -1033,6 +1053,11 @@ magic_found:
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
-- 
2.54.0 (Apple Git-157)

