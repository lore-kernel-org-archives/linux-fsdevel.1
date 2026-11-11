Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440707;
	b=wY7MYig3y+UmaKul6hvRxd5KWxXSsAiVw0IIc2G0VzcUDr5geWvZBjGc/RXbKdacIwxG
	 6T5stJSrv44aFbmrgigJ5+N4N0RPND2qbFoUO7/rlF0kgUC3wM77b2F0OvRXCm+/N2mXa
	 k5cT0KwLrQGhdi9WQTzvtgBGWQbg2LldNkJz2SGXM90yiNUypYYo7E8gioTq46AmMFoGD
	 qSP7SLm/yRb6l7qYypfNBfWrvv0NxjuUd0vTpIEtAZKUA+qKjUlbH0EgFHCKzvFUFqUNG
	 iZGDy84pcLdnX/ParvVIio8RPsj+6gx35+LT/31t/DLZBnGSHxsGhw24yJb55PKekKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440707;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=k28rUPyjDNlD+hyGsW5Okfm6FxHu0DvBbTlMFmzRvLM=;
	b=dGCfECqOsoGRD/1EyeU0uWMqlSDyESbnsxYmCeBXTitX/hAZkDr4A6NmjNUZwezwfA9h
	 3w3KbpCBa1lXmGWpW+GbUXHl1vVT+sHjUlxDtzbcOJpPIT8UB8vH7OeFVoRQ3NK0pL7Am
	 PLROj2GbZ7KiO7yu8g1kVDXHYlxpJnH7/uzGzw0F/i8sBBmGprhU3WDVbUc5jcUSyvG6e
	 HDT6h59WYxBOUC1VylU9mw9N0Q16CKvEIfZsXQaBA0Z9UBLeBa44dsYtT1V45vUtxS80/
	 8WJyvwNPMzlg54otG3gDiel6WXkjDU1FIPnpNHM111lmiqVD3OD0yvDhX/lly3z/N6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=km0R4lWz;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=SZYndogt;
	arc=none smtp.remote-ip=188.121.53.33
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [188.121.53.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED507606AE75
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED507606AE75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=km0R4lWz;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=SZYndogt
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHztxAFZd; Wed, 11 Nov 2026 23:44:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440699;
	bh=k28rUPyjDNlD+hyGsW5Okfm6FxHu0DvBbTlMFmzRvLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=km0R4lWzmTFJhMSVwW8zOaYPBqi7NRHZsnkWMbKH9XtaWbrHHcvG6XOV3K6IgaGHW
	 UhhiAX/zIrC+5fZxeK9mbJVM/9AYRHoSZo7HrGgjplOhfzLhgRoD3JL1rhhbh0qReP
	 ix6QLms9tWjDnRycV9zUf4oxiRv4COGzfPqiCcEuSYY7r/APDNi5/Of8SGo3XmSD1L
	 5fLZ5jvB9hyYxkb1IZZiFanSpxDGvz1qerQWDAPp7OL6PZTQ0EjOsPBOYmj6soJmWq
	 GWABvbgizutEm/wZATdQMZfCit/o6GU5lfS1iZkgCZAnTFt4CeKdbPXfzfGg3CLLM0
	 8Mt3UKLpoBLZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440699;
	bh=k28rUPyjDNlD+hyGsW5Okfm6FxHu0DvBbTlMFmzRvLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SZYndogt1MQTBKtWJPlOGchfsRf3DB8SoFsKFStmIL7QvvBzNCpyNBasxkY7AZe5o
	 0NBhb87ichUO49e3AEWHmcnSiu/jtX01d0jbRyS4NBHgdXa1hTJN3kIlxhRhvxcs/k
	 JO/ECaVU4cJngXeHPkszvE2OhjzFYCn6dyT+Y/f2r1u06fxQhCv/tb0Rm8nIZgrs+r
	 cKs2Z4OU8xuXbyydQT+jAEGEaUbHsdUBMGUENHy4c0p/LHBcTcalCfdGQ2CAGF8mkE
	 15cWaevMJ37Sj0/mj6q2pkT/rOHzrENhnN/jbjsdfiyY1pqLUi0FpYD6o6qhlY6kOb
	 H/rFQIgVtQeaA==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fdfb
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=BjB-n3F9ADh-iJCbTToA:9 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: e13796eb4b4bca7ff4a3fab61013f5f9:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 19/22] Squashfs: don't store large xattr id table indexes in memory
Date: Wed, 11 Nov 2026 23:43:59 +0000
Message-ID: <20261111234402.252354-20-phillip@squashfs.org.uk>
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
X-CMAE-Envelope: MS4xfI6+3yXyBsksc2OUSURMPhAaKZuH4syAzI0G+pc4Lg5X3EZUT2a+c7cR5ip9k/avv1MkALDSY2X2NDd3mnREbZe9wuTuk3WH5GkFtEPkM64TvEP3XBBc
 47VAE/fFhHVm/MZTcFt7Tid4j3csowdiX+dIxuJxRWKImJsdmO0sEgbalZ0QM+uDeMtCM5VUJ/2+UhgCFlr14M/eIehNIJF6+XnMReYd8XU7DIx6bP+XHtdC
 VdYjxwI56xFMYBxRSqS0dxDPm2KH+xhvyT+hnH50JFvnK0BX3WyyrMbPdIY+3Ayygv/mMAPSH4vnJato3pw2EIvA6+a9/8RZMHCbIngCycQ=

When mounting a Squashfs filesystem, the code reads the entire xattr id
table indexes into memory.  Their size is determined by the number of
xattr ids in the filesystem, where the maximum number of xattr ids is
2^32, and this will allocate and read 64 MiB.

This is an excessive and unnecessary amount of memory because the
indexes do not need to be read into memory in their entirety.  In
addition kmalloc() is used to allocate memory, and this can fail when
large amounts of memory are requested.  Kmalloc() on modern kernels is
usually limited to 4096 KiB.  If panic-on-warn is set, then failure to
allocate memory will result in a kernel panic.

This commit uses a 4 page cache if the size of the xattr id table
indexes are 4 pages or larger.  A simple and fast lookup array is
retained where the total index size is less than 4 pages in size, which
is the vast majority of Squashfs filesystems.

Reproducer
==========

The following reproducer will create a Squashfs filesystem with
280 million xattr ids, which will cause the xattr id table indexes to
exceed 4096 KiB, and the kmalloc() should fail when the filesystem is
mounted.

=====================================================================
#!/bin/bash

ARGS="-pf pseudo -mem 100m -no-hardlinks -no-sparse -no-duplicates "
ARGS+="-no-exports -no-recovery -no-progress -no-xattr-dups"

finish() {
	popd 2>&1 > /dev/null
	rm -rf $DIR
	exit 1
}

IMG=$PWD/reproducer.sqsh
DIR=$(mktemp -d)

if [ -e $IMG ]; then
	rm $IMG
fi

pushd $DIR 2>&1 > /dev/null

# create 20 million pseudo file links to empty file
touch a
a=0
while [ $a -le 19 ]; do
	b=0
	while [ $b -le 999 ]; do
		c=0
		while [ $c -le 999 ]; do
			echo "X/$a/$b/$c l a" >> file
			echo "X/$a/$b/$c x user.x=1" >> file
			(( c ++ ))
		done
		(( b ++ ))
	done
	(( a ++ ))
done

for i in $(seq 1 14); do
	sed "s/X/$i/g" file > pseudo
	echo
	echo Iteration $i - appending 20 million files to Squashfs filesystem
	echo
	if ! mksquashfs - $IMG -pd "d 0777 0 0" $ARGS; then
		echo Appending to Squashfs filesystem failed
		finish
	fi
done

popd 2>&1 > /dev/null
rm -rf $DIR

echo Generated Squashfs filesystem $IMG
=====================================================================

Fixes: 4b5397dc24ab1 ("squashfs: add xattr id support")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
v2: Widen offset in squashfs_xattr_lookup_start() to s32, to prevent
    overflow when PAGE_SIZE is 64 KiB or larger.
---
 fs/squashfs/inode.c            |   2 +-
 fs/squashfs/squashfs_fs_sb.h   |   8 +-
 fs/squashfs/squashfs_helpers.h |  29 +++++-
 fs/squashfs/super.c            |  26 +++--
 fs/squashfs/xattr.c            |  22 +++--
 fs/squashfs/xattr.h            |  15 ++-
 fs/squashfs/xattr_id.c         | 169 +++++++++++++++++++++++----------
 7 files changed, 198 insertions(+), 73 deletions(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index f773f5008388..a512e8d00c41 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -434,7 +434,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		return -EINVAL;
 	}
 
-	if (xattr_id != SQUASHFS_INVALID_XATTR && msblk->xattr_id_table) {
+	if (xattr_id != SQUASHFS_INVALID_XATTR && msblk->xattr_id_array) {
 		err = squashfs_xattr_lookup(sb, xattr_id,
 					&squashfs_i(inode)->xattr_count,
 					&squashfs_i(inode)->xattr_size,
diff --git a/fs/squashfs/squashfs_fs_sb.h b/fs/squashfs/squashfs_fs_sb.h
index 77f7085ad2d0..52ff4f270939 100644
--- a/fs/squashfs/squashfs_fs_sb.h
+++ b/fs/squashfs/squashfs_fs_sb.h
@@ -63,7 +63,10 @@ struct squashfs_sb_info {
 		__le64				*fragment_index_array;
 		struct squashfs_cache		*fragment_index_cache;
 	};
-	__le64					*xattr_id_table;
+	union {
+		__le64				*xattr_id_array;
+		struct squashfs_cache		*xattr_id_cache;
+	};
 	struct mutex				meta_index_mutex;
 	struct meta_index			*meta_index;
 	void					*stream;
@@ -79,6 +82,8 @@ struct squashfs_sb_info {
 	u64					xattr_table;
 	u64					lookup_table;
 	u64					lookup_table_start;
+	u64					xattr_id_table;
+	u64					xattr_id_table_start;
 	unsigned int				block_size;
 	unsigned short				block_log;
 	long long				bytes_used;
@@ -91,5 +96,6 @@ struct squashfs_sb_info {
 	int					max_thread_num;
 	bool					lookup_table_is_cache;
 	bool					fragment_index_is_cache;
+	bool					xattr_id_is_cache;
 };
 #endif
diff --git a/fs/squashfs/squashfs_helpers.h b/fs/squashfs/squashfs_helpers.h
index 0f1aad9450cc..c25f5918b8fa 100644
--- a/fs/squashfs/squashfs_helpers.h
+++ b/fs/squashfs/squashfs_helpers.h
@@ -242,11 +242,38 @@ static inline s32 squashfs_xattr_blocks(u32 xattrs)
 		SQUASHFS_METADATA_SIZE;
 }
 
-static inline s32 squashfs_xattr_block_bytes(u32 xattrs)
+static inline s32 squashfs_xattr_blocks_bytes(u32 xattrs)
 {
 	return squashfs_xattr_blocks(xattrs) * sizeof(long long);
 }
 
+static inline s32 squashfs_xattr_blocks_base(u32 xattrs)
+{
+	return (squashfs_xattr_block(xattrs) * sizeof(long long)) & ~(PAGE_SIZE - 1);
+}
+
+static inline s64 squashfs_xattr_blocks_start(u32 xattrs, struct squashfs_sb_info *msblk)
+{
+	s32 base = squashfs_xattr_blocks_base(xattrs);
+	s64 table_start = msblk->xattr_id_table + sizeof(struct squashfs_xattr_id_table);
+	s64 start;
+
+	if (S64_MAX - table_start < base)
+		return -EINVAL;
+
+	start = table_start + base;
+
+	if (start > msblk->bytes_used)
+		return -EINVAL;
+
+	return start;
+}
+
+static inline s16 squashfs_xattr_blocks_offset(u32 xattrs)
+{
+	return (squashfs_xattr_block(xattrs) * sizeof(long long)) & (PAGE_SIZE - 1);
+}
+
 static inline u32 squashfs_xattr_blk(s64 xattr)
 {
 	return xattr >> 16;
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 287cbc6ad41c..b7deedb0850f 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -193,6 +193,14 @@ static void squashfs_free_fragment_indexes(struct squashfs_sb_info *msblk)
 		kfree(msblk->fragment_index_array);
 }
 
+static void squashfs_free_xattr_indexes(struct squashfs_sb_info *msblk)
+{
+	if (msblk->xattr_id_is_cache)
+		squashfs_cache_delete(msblk->xattr_id_cache);
+	else
+		kfree(msblk->xattr_id_array);
+}
+
 static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct squashfs_mount_opts *opts = fc->fs_private;
@@ -202,7 +210,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	long long root_inode;
 	unsigned short flags;
 	unsigned int fragments;
-	u64 xattr_id_table_start, next_table;
+	u64 next_table;
 	s64 err;
 	int devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
 
@@ -376,19 +384,17 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/* Handle xattrs */
 	sb->s_xattr = squashfs_xattr_handlers;
-	xattr_id_table_start = le64_to_cpu(sblk->xattr_id_table_start);
-	if (xattr_id_table_start == SQUASHFS_INVALID_BLK) {
+	msblk->xattr_id_table = le64_to_cpu(sblk->xattr_id_table_start);
+	if (msblk->xattr_id_table == SQUASHFS_INVALID_BLK) {
 		next_table = msblk->bytes_used;
 		goto allocate_id_index_table;
 	}
 
 	/* Allocate and read xattr id lookup table */
-	msblk->xattr_id_table = squashfs_read_xattr_id_table(sb,
-		xattr_id_table_start, &msblk->xattr_table, &msblk->xattr_ids);
-	if (IS_ERR(msblk->xattr_id_table)) {
+	err = squashfs_read_xattr_id_table(sb, msblk->xattr_id_table,
+				&msblk->xattr_table, &msblk->xattr_ids);
+	if (err < 0) {
 		errorf(fc, "unable to read xattr id index table");
-		err = PTR_ERR(msblk->xattr_id_table);
-		msblk->xattr_id_table = NULL;
 		if (err != -ENOTSUPP)
 			goto failed_mount;
 	}
@@ -507,7 +513,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	squashfs_free_inode_table(msblk);
 	squashfs_free_fragment_indexes(msblk);
 	kfree(msblk->id_table);
-	kfree(msblk->xattr_id_table);
+	squashfs_free_xattr_indexes(msblk);
 	kfree(sb->s_fs_info);
 	sb->s_fs_info = NULL;
 	kfree(sblk);
@@ -628,7 +634,7 @@ static void squashfs_put_super(struct super_block *sb)
 		squashfs_free_fragment_indexes(sbi);
 		kfree(sbi->meta_index);
 		squashfs_free_inode_table(sbi);
-		kfree(sbi->xattr_id_table);
+		squashfs_free_xattr_indexes(sbi);
 		kfree(sb->s_fs_info);
 		sb->s_fs_info = NULL;
 	}
diff --git a/fs/squashfs/xattr.c b/fs/squashfs/xattr.c
index d7247648ac35..18ab9b67a0e6 100644
--- a/fs/squashfs/xattr.c
+++ b/fs/squashfs/xattr.c
@@ -30,10 +30,9 @@ ssize_t squashfs_listxattr(struct dentry *d, char *buffer,
 	struct inode *inode = d_inode(d);
 	struct super_block *sb = inode->i_sb;
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	u64 start = squashfs_xattr_blk(squashfs_i(inode)->xattr)
-						+ msblk->xattr_table;
-	int offset = squashfs_xattr_offset(squashfs_i(inode)->xattr);
-	unsigned int count = squashfs_i(inode)->xattr_count;
+	u64 start;
+	int offset;
+	unsigned int count;
 	size_t rest = buffer_size;
 	int err;
 
@@ -41,9 +40,13 @@ ssize_t squashfs_listxattr(struct dentry *d, char *buffer,
 	if (squashfs_i(inode)->xattr == SQUASHFS_INVALID_BLK)
 		return 0;
 
+	count = squashfs_i(inode)->xattr_count;
 	if (count == 0 || count > squashfs_i(inode)->xattr_size)
 		return -EIO;
 
+	start = squashfs_xattr_blk(squashfs_i(inode)->xattr) + msblk->xattr_table;
+	offset = squashfs_xattr_offset(squashfs_i(inode)->xattr);
+
 	/* loop reading each xattr name */
 	while (count--) {
 		struct squashfs_xattr_entry entry;
@@ -111,10 +114,9 @@ static int squashfs_xattr_get(struct inode *inode, int name_index,
 {
 	struct super_block *sb = inode->i_sb;
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	u64 start = squashfs_xattr_blk(squashfs_i(inode)->xattr)
-						+ msblk->xattr_table;
-	int offset = squashfs_xattr_offset(squashfs_i(inode)->xattr);
-	unsigned int count = squashfs_i(inode)->xattr_count;
+	u64 start;
+	int offset;
+	unsigned int count;
 	int name_len = strlen(name);
 	int err, vsize;
 	char *target;
@@ -123,6 +125,7 @@ static int squashfs_xattr_get(struct inode *inode, int name_index,
 	if (squashfs_i(inode)->xattr == SQUASHFS_INVALID_BLK)
 		return -ENODATA;
 
+	count = squashfs_i(inode)->xattr_count;
 	if (count == 0 || count > squashfs_i(inode)->xattr_size)
 		return -EIO;
 
@@ -130,6 +133,9 @@ static int squashfs_xattr_get(struct inode *inode, int name_index,
 	if (target == NULL)
 		return -ENOMEM;
 
+	start = squashfs_xattr_blk(squashfs_i(inode)->xattr) + msblk->xattr_table;
+	offset = squashfs_xattr_offset(squashfs_i(inode)->xattr);
+
 	/* loop reading each xattr name */
 	for (; count; count--) {
 		struct squashfs_xattr_entry entry;
diff --git a/fs/squashfs/xattr.h b/fs/squashfs/xattr.h
index b33e9ad4057f..799b328b0e6c 100644
--- a/fs/squashfs/xattr.h
+++ b/fs/squashfs/xattr.h
@@ -9,25 +9,26 @@
  */
 
 #ifdef CONFIG_SQUASHFS_XATTR
-extern __le64 *squashfs_read_xattr_id_table(struct super_block *, u64,
+extern int squashfs_read_xattr_id_table(struct super_block *, u64,
 		u64 *, unsigned int *);
 extern int squashfs_xattr_lookup(struct super_block *, unsigned int,
 		unsigned int *, unsigned int *, unsigned long long *);
+extern s64 squashfs_xattr_lookup_start(struct super_block *sb, u32 index);
 #else
-static inline __le64 *squashfs_read_xattr_id_table(struct super_block *sb,
+static inline int squashfs_read_xattr_id_table(struct super_block *sb,
 		u64 start, u64 *xattr_table_start, unsigned int *xattr_ids)
 {
 	struct squashfs_xattr_id_table *id_table;
 
 	id_table = squashfs_read_table(sb, start, sizeof(*id_table));
 	if (IS_ERR(id_table))
-		return (__le64 *) id_table;
+		return PTR_ERR(id_table);
 
 	*xattr_table_start = le64_to_cpu(id_table->xattr_table_start);
 	kfree(id_table);
 
 	ERROR("Xattrs in filesystem, these will be ignored\n");
-	return ERR_PTR(-ENOTSUPP);
+	return -ENOTSUPP;
 }
 
 static inline int squashfs_xattr_lookup(struct super_block *sb,
@@ -36,6 +37,12 @@ static inline int squashfs_xattr_lookup(struct super_block *sb,
 {
 	return 0;
 }
+
+static inline s64 squashfs_xattr_lookup_start(struct super_block *sb, u32 index)
+{
+	return 0;
+}
+
 #define squashfs_listxattr NULL
 #define squashfs_xattr_handlers NULL
 #endif
diff --git a/fs/squashfs/xattr_id.c b/fs/squashfs/xattr_id.c
index 621777e0a3b4..bf6efc604bd3 100644
--- a/fs/squashfs/xattr_id.c
+++ b/fs/squashfs/xattr_id.c
@@ -23,6 +23,45 @@
 #include "squashfs.h"
 #include "xattr.h"
 
+s64 squashfs_xattr_lookup_start(struct super_block *sb, u32 index)
+{
+	struct squashfs_sb_info *msblk = sb->s_fs_info;
+	s64 start;
+
+	if (msblk->xattr_id_is_cache) {
+		s32 length = squashfs_xattr_blocks_bytes(msblk->xattr_ids);
+		s32 base = squashfs_xattr_blocks_base(index);
+		s32 offset = squashfs_xattr_blocks_offset(index);
+		s32 avail = min_t(int, length - base, PAGE_SIZE);
+		struct squashfs_cache_entry *entry;
+
+		start = squashfs_xattr_blocks_start(index, msblk);
+		if (start < 0)
+			return start;
+
+		entry = squashfs_cache_get(sb, msblk->xattr_id_cache, start,
+				avail | SQUASHFS_COMPRESSED_BIT_BLOCK);
+		if (entry->error < 0) {
+			int err = entry->error;
+
+			squashfs_cache_put(entry);
+			return err;
+		}
+
+		start = le64_to_cpu(((__le64 *)entry->data[0])[offset >> 3]);
+		squashfs_cache_put(entry);
+	} else {
+		s32 block = squashfs_xattr_block(index);
+
+		start = le64_to_cpu(msblk->xattr_id_array[block]);
+	}
+
+	if (start < msblk->xattr_id_table_start || start >= msblk->xattr_id_table)
+		return -EIO;
+
+	return start;
+}
+
 /*
  * Map xattr id using the xattr id look up table
  */
@@ -31,19 +70,19 @@ int squashfs_xattr_lookup(struct super_block *sb, unsigned int index,
 		unsigned long long *xattr)
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	int block = squashfs_xattr_block(index);
-	int offset = squashfs_xattr_block_offset(index);
-	u64 start_block;
+	s32 offset = squashfs_xattr_block_offset(index);
+	s64 start;
 	struct squashfs_xattr_id id;
 	int err;
 
 	if (index >= msblk->xattr_ids)
 		return -EINVAL;
 
-	start_block = le64_to_cpu(msblk->xattr_id_table[block]);
+	start = squashfs_xattr_lookup_start(sb, index);
+	if (start < 0)
+		return start;
 
-	err = squashfs_read_metadata(sb, &id, &start_block, &offset,
-							sizeof(id));
+	err = squashfs_read_metadata(sb, &id, &start, &offset, sizeof(id));
 	if (err < 0)
 		return err;
 
@@ -57,19 +96,19 @@ int squashfs_xattr_lookup(struct super_block *sb, unsigned int index,
 /*
  * Read uncompressed xattr id lookup table indexes from disk into memory
  */
-__le64 *squashfs_read_xattr_id_table(struct super_block *sb, u64 table_start,
+int squashfs_read_xattr_id_table(struct super_block *sb, u64 table_start,
 		u64 *xattr_table_start, unsigned int *xattr_ids)
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	unsigned int len, indexes;
+	s32 len;
 	struct squashfs_xattr_id_table *id_table;
-	__le64 *table;
 	u64 start, end;
-	int n;
+	s64 res;
 
+	/* Untrusted table_start will be validated by squashfs_read_data() */
 	id_table = squashfs_read_table(sb, table_start, sizeof(*id_table));
 	if (IS_ERR(id_table))
-		return (__le64 *) id_table;
+		return PTR_ERR(id_table);
 
 	*xattr_table_start = le64_to_cpu(id_table->xattr_table_start);
 	*xattr_ids = le32_to_cpu(id_table->xattr_ids);
@@ -79,10 +118,9 @@ __le64 *squashfs_read_xattr_id_table(struct super_block *sb, u64 table_start,
 
 	/* there is always at least one xattr id */
 	if (*xattr_ids == 0)
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
-	len = squashfs_xattr_block_bytes(*xattr_ids);
-	indexes = squashfs_xattr_blocks(*xattr_ids);
+	len = squashfs_xattr_blocks_bytes(*xattr_ids);
 
 	/*
 	 * The computed size of the index table (len bytes) should exactly
@@ -92,43 +130,78 @@ __le64 *squashfs_read_xattr_id_table(struct super_block *sb, u64 table_start,
 	end = msblk->bytes_used;
 
 	if (len != (end - start))
-		return ERR_PTR(-EINVAL);
-
-	table = squashfs_read_table(sb, start, len);
-	if (IS_ERR(table))
-		return table;
-
-	/* table[0], table[1], ... table[indexes - 1] store the locations
-	 * of the compressed xattr id blocks.  Each entry should be less than
-	 * the next (i.e. table[0] < table[1]), and the difference between them
-	 * should be SQUASHFS_METADATA_SIZE or less.  table[indexes - 1]
-	 * should be less than table_start, and again the difference
-	 * shouls be SQUASHFS_METADATA_SIZE or less.
-	 *
-	 * Finally xattr_table_start should be less than table[0].
-	 */
-	for (n = 0; n < (indexes - 1); n++) {
-		start = le64_to_cpu(table[n]);
-		end = le64_to_cpu(table[n + 1]);
-
-		if (start >= end || (end - start) >
-				(SQUASHFS_METADATA_SIZE + SQUASHFS_BLOCK_OFFSET)) {
-			kfree(table);
-			return ERR_PTR(-EINVAL);
+		return -EINVAL;
+
+	if (len <= (PAGE_SIZE * 4)) {
+		/* Read fragment indexes into memory */
+		s32 n, indexes = squashfs_xattr_blocks(*xattr_ids);
+		__le64 *array = squashfs_read_table(sb, start, len);
+
+		if (IS_ERR(array))
+			return PTR_ERR(array);
+
+		/* array[0], array[1], ... array[indexes - 1] store the locations
+		 * of the compressed xattr id blocks.  Each entry should be less than
+		 * the next (i.e. array[0] < array[1]), and the difference between them
+		 * should be SQUASHFS_METADATA_SIZE or less.  array[indexes - 1]
+		 * should be less than array_start, and again the difference
+		 * shouls be SQUASHFS_METADATA_SIZE or less.
+		 *
+		 * Finally xattr_array_start should be less than array[0].
+		 */
+		for (n = 0; n < (indexes - 1); n++) {
+			start = le64_to_cpu(array[n]);
+			end = le64_to_cpu(array[n + 1]);
+
+			if (start >= end || (end - start) >
+					(SQUASHFS_METADATA_SIZE + SQUASHFS_BLOCK_OFFSET)) {
+				kfree(array);
+				return -EINVAL;
+			}
 		}
-	}
 
-	start = le64_to_cpu(table[indexes - 1]);
-	if (start >= table_start || (table_start - start) >
-				(SQUASHFS_METADATA_SIZE + SQUASHFS_BLOCK_OFFSET)) {
-		kfree(table);
-		return ERR_PTR(-EINVAL);
-	}
+		start = le64_to_cpu(array[indexes - 1]);
+		if (start >= table_start || (table_start - start) >
+					(SQUASHFS_METADATA_SIZE + SQUASHFS_BLOCK_OFFSET)) {
+			kfree(array);
+			return -EINVAL;
+		}
+
+		msblk->xattr_id_table_start = le64_to_cpu(array[0]);
+		if (*xattr_table_start >= msblk->xattr_id_table_start) {
+			kfree(array);
+			return -EINVAL;
+		}
+
+		msblk->xattr_id_array = array;
+		msblk->xattr_id_is_cache = false;
+	} else {
+		/* Use a cache to store the last 16Kbytes of indexes read */
+		struct squashfs_cache *cache = squashfs_cache_init("xattr index", 4, PAGE_SIZE);
+
+		if (IS_ERR(cache))
+			return PTR_ERR(cache);
 
-	if (*xattr_table_start >= le64_to_cpu(table[0])) {
-		kfree(table);
-		return ERR_PTR(-EINVAL);
+		msblk->xattr_id_cache = cache;
+		msblk->xattr_id_is_cache = true;
+		msblk->xattr_id_table_start = 0;
+
+		res = squashfs_xattr_lookup_start(sb, 0);
+		if (res < 0)
+			goto corrupted;
+
+		if (*xattr_table_start >= res) {
+			res = -EINVAL;
+			goto corrupted;
+		}
+
+		msblk->xattr_id_table_start = res;
 	}
 
-	return table;
+	return 0;
+
+corrupted:
+	squashfs_cache_delete(msblk->xattr_id_cache);
+	msblk->xattr_id_cache = NULL;
+	return res;
 }
-- 
2.47.3

