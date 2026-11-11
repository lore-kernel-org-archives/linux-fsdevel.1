Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440703;
	b=bOhkHIZJcvbDapTFHyiJZWiknwCfChwiWBgw3gw1SgrIEcC8z6Xa8SsAymUciSsmXRvi
	 P3hBESXL/H4bQ8cBvYgdVzDnza7XgHCog4VDTJDktmb6f+PBH/TKamL+oP6HMurwEa9TM
	 26hz8oD+d2nRUxa2iyVRgB2XrnUbuaRJV3NM51Xha0P3bCq0tCi1mcTkatYnkjalgb5MU
	 e5HCpLZ5pG0NZ4QJzTTnN7Z6p8Yx+b/WwiO0Tp/evpoPWAXEHSEOXrzNVAmpK3lBIZm6S
	 ht8I8n9cJzrarDKl6XYUlNCZGl/ENBXGWi5AkM2nNzjOBjbEKpice6uX94yH6Erm8TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440703;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=Mw7DwHZ86PJcb1W/8SP4G8WYJBm9z/JCkSJ5qlf1/HE=;
	b=MUEhA0nYdkX2qioujScS8jsQ/XD24LoMFDWMgy9U/rXqi5uDhAALjjRZAcQGSR7fyLJW
	 gnhLaIqDLgTuYThe2J2BkeKoXifuGPBi7i9f4OlQrKBt4RnXMKnDtOJRsJAK8PR2wAmBa
	 eYj79eH5X/PLgPHALiEn2v28TjEZw8CNBE0jj3XV2auJD1WtE95eIH5Tw/+Wkh/3CIVu9
	 PN+SWF2vpIrbWAEQ8/NCtK4Hkh3ATfRIjmHoy5pzSK0D3xcMDiaL4c0HPcj5+RJbe+uUb
	 rLWcFmly5ByIQcbHpc+LeHfCLqcLAf1VFg40aLQTp82dPdSYN2t7J6RcWa/g4pSLd9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=cRjhdz6A;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=YQtwmYyj;
	arc=none smtp.remote-ip=188.121.53.23
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [188.121.53.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD2A606C0B3
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECD2A606C0B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=cRjhdz6A;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=YQtwmYyj
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHzqxAFZK; Wed, 11 Nov 2026 23:44:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440695;
	bh=Mw7DwHZ86PJcb1W/8SP4G8WYJBm9z/JCkSJ5qlf1/HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cRjhdz6ASlc163byW4j7Ao+w6Jrq8UQVtQU7b2kYZl9sYIO9FiKnGcJere1wM065V
	 DqcqWIDHPM/nVtg5Rx7EbGhirD78hzNnJ6dyZPWE1jrmvyBsxDLLkuAU+htnLj66kk
	 ud8X9w4ibeO3gGOURJvNveqrKPJfE0BiwUMXuokOQSeXaC28rB6jp4kSLtQJE3V3Yb
	 LbIKrowlFRbzbDm5E03+i3nirk09FBo+Nrx9N4sVjgJ8kBjmN3Vj2/wbQuUvlN5biQ
	 qMQCPBREksSnh52Oi2oBo+0yjuvnsX/ivv41oVhaZpZqAZYd+5/t17QjGItK3/Ydc4
	 ADVBhU3sAfFIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440695;
	bh=Mw7DwHZ86PJcb1W/8SP4G8WYJBm9z/JCkSJ5qlf1/HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YQtwmYyjVEw4DHRJDg0uVN2nHMlhBIEfSH+Owlfjbe8njDYiNk/eHCsASY47WioJU
	 wjcJIOTdAZ+gWPwiIETB7+pTT7ggqKm3kAeuopsnMiate5o18WsFFOrmjJX2VjwEqq
	 GSTLaEuTsz0w/577I7a/SdTb/JJ3IW4d0N3kSw45tUonD7qjfcyX1PsCHZtiYipzWm
	 XrEs0aKQTv71ESmKXsXatA6eINFCXurTdVcAW0t4+tqsQyfVyb+0qYL5ctxpLOYfkO
	 nrEQtB+qfOe4kiQB094mF6JEn9jPKWhtqQHlICln58IuUGD8rUrUwPyFXFv9i6bvyh
	 DLhf1zvf7tdqA==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fdf7
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=CSAkETy8TeNUzzMbOh8A:9 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: 122f59afdc0f0633c33ab761d99d0251:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 17/22] Squashfs: don't store large export table indexes in memory
Date: Wed, 11 Nov 2026 23:43:57 +0000
Message-ID: <20261111234402.252354-18-phillip@squashfs.org.uk>
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
X-CMAE-Envelope: MS4xfHXL2bu5DGY80ShIbexCWpEXpyxz+S9EEfXNumXbEzyCzeaTVSL5Qfhh+Y4FtbhPRLxqkEVFBLIqAZSN1nEpPA9Pj94Z69rcctU8OQ78HFKCgFINseJv
 8g5DNlPzQ+WwkqbuWjIU3FDv1bgXu6baB892pbChmoC+FN+DXR5aPVmbVuAeOg/957WuOSOJuqAsX3WAFjfJPyyx1qm6hS7YeuV1lCPJ68T/Tq+JmOhyL6Ma
 Gwrhu9+CXWOCdjZbw9KD/PFqQ3Z07Qtd6+jVBIKd0GEUGN/B+v5EFtS0QthgpP8JnlKIfOCMP1PkDF+DSlx5Eeojc6cOMRn9z3Z51/YIS5c=

When mounting a Squashfs filesystem, the code reads the entire
export table indexes into memory.  Their size is determined by the
number of inodes in the filesystem.  For the maximum inode
count of 2^32, this will allocate and read 32 MiB.

This is an excessive and unnecessary amount of memory because the
indexes do not need to be read into memory in their entirety.  In
addition kmalloc() is used to allocate memory, and this can fail when
large amounts of memory are requested.  Kmalloc() on modern kernels is
usually limited to 4096 KiB.  If panic-on-warn is set, then failure to
allocate memory will result in a kernel panic.

This commit uses a 4 page cache if the size of the export table indexes
are 4 pages in size or larger.  A simple and fast lookup array is
retained where the total index size is less than 4 pages in size, which
is the vast majority of Squashfs filesystems.

Reproducer
==========

The following reproducer will create a Squashfs filesystem with
540,540,568 inodes (540 million files).  This will cause the export
table indexes to exceed 4096 KiB, and the kmalloc() should fail when the
filesystem is mounted.  Due to the large amount of inodes the Squashfs
filesystem reproducer needs to be run on a 64-bit machine with around
60 GiB of memory (or swap).

The latest development Mksquashfs from the GitHub Squashfs-tools
repository also needs to be used.

=====================================================================
#!/bin/bash

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
			echo "x/$a/$b/$c l a" >> file
			(( c ++ ))
		done
		(( b ++ ))
	done
	(( a ++ ))
done

for i in $(seq 1 27); do
	sed "s/x/$i/g" file > pseudo
	echo
	echo Iteration $i - appending 20 million files to Squashfs filesystem
	echo
	if ! mksquashfs - $IMG -pf pseudo -no-hardlinks -pd "d 0777 0 0" -no-recovery -no-progress -comp lz4; then
		echo Appending to Squashfs filesystem failed
		finish
	fi
done

popd 2>&1 > /dev/null
rm -rf $DIR

echo Generated Squashfs filesystem $IMG
=====================================================================

Fixes: 122601408d20c ("Squashfs: export operations")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
v2:
  - Widen offset in squashfs_inode_lookup_start() to s32, to prevent
    overflow when PAGE_SIZE is 64 KiB or larger.
  - Prevent squashfs_inode_lookup_start() from passing back an erroneous
    error value by checking lookup_table_start >= next_table in
    squashfs_read_inode_lookup_table().
---
 fs/squashfs/export.c           | 146 +++++++++++++++++++++++----------
 fs/squashfs/squashfs.h         |   3 +-
 fs/squashfs/squashfs_fs_sb.h   |   8 +-
 fs/squashfs/squashfs_helpers.h |  28 ++++++-
 fs/squashfs/super.c            |  36 +++++---
 5 files changed, 160 insertions(+), 60 deletions(-)

diff --git a/fs/squashfs/export.c b/fs/squashfs/export.c
index ad7cc882d789..dcf8f2478fcf 100644
--- a/fs/squashfs/export.c
+++ b/fs/squashfs/export.c
@@ -34,24 +34,64 @@
 #include "squashfs_helpers.h"
 #include "squashfs.h"
 
+s64 squashfs_inode_lookup_start(struct super_block *sb, u32 ino_num)
+{
+	struct squashfs_sb_info *msblk = sb->s_fs_info;
+	s64 start;
+	int err;
+
+	if (msblk->lookup_table_is_cache) {
+		s32 length = squashfs_lookup_blocks_bytes(msblk->inodes);
+		s32 base = squashfs_lookup_blocks_base(ino_num - 1);
+		s32 offset = squashfs_lookup_blocks_offset(ino_num - 1);
+		s32 avail = min_t(int, length - base, PAGE_SIZE);
+		struct squashfs_cache_entry *entry;
+
+		start = squashfs_lookup_blocks_start(ino_num - 1, msblk);
+		if (start < 0)
+			return start;
+
+		entry = squashfs_cache_get(sb, msblk->inode_lookup_cache, start,
+					avail | SQUASHFS_COMPRESSED_BIT_BLOCK);
+		if (entry->error < 0) {
+			err = entry->error;
+			squashfs_cache_put(entry);
+			return err;
+		}
+
+		start = le64_to_cpu(((__le64 *)entry->data[0])[offset >> 3]);
+		squashfs_cache_put(entry);
+	} else {
+		s32 blk = squashfs_lookup_block(ino_num - 1);
+
+		start = le64_to_cpu(msblk->inode_lookup_array[blk]);
+	}
+
+	if (start < msblk->lookup_table_start || start >= msblk->lookup_table)
+		return -EIO;
+
+	return start;
+}
+
 /*
  * Look-up inode number (ino) in table, returning the inode location.
  */
-static long long squashfs_inode_lookup(struct super_block *sb, int ino_num)
+static long long squashfs_inode_lookup(struct super_block *sb, u32 ino_num)
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	int blk = squashfs_lookup_block(ino_num - 1);
-	int offset = squashfs_lookup_block_offset(ino_num - 1);
-	u64 start;
+	s32 offset = squashfs_lookup_block_offset(ino_num - 1);
+	s64 start;
 	__le64 ino;
 	int err;
 
-	TRACE("Entered squashfs_inode_lookup, inode_number = %d\n", ino_num);
+	TRACE("Entered squashfs_inode_lookup, inode_number = %u\n", ino_num);
 
 	if (ino_num == 0 || (ino_num - 1) >= msblk->inodes)
 		return -EINVAL;
 
-	start = le64_to_cpu(msblk->inode_lookup_table[blk]);
+	start = squashfs_inode_lookup_start(sb, ino_num);
+	if (start < 0)
+		return start;
 
 	err = squashfs_read_metadata(sb, &ino, &start, &offset, sizeof(ino));
 	if (err < 0)
@@ -113,14 +153,11 @@ static struct dentry *squashfs_get_parent(struct dentry *child)
 /*
  * Read uncompressed inode lookup table indexes off disk into memory
  */
-__le64 *squashfs_read_inode_lookup_table(struct super_block *sb,
+int squashfs_read_inode_lookup_table(struct super_block *sb,
 		u64 lookup_table_start, u64 next_table, unsigned int inodes)
 {
-	unsigned int length = squashfs_lookup_block_bytes(inodes);
-	unsigned int indexes = squashfs_lookup_blocks(inodes);
-	int n;
-	__le64 *table;
-	u64 start, end;
+	struct squashfs_sb_info *msblk = sb->s_fs_info;
+	s32 length = squashfs_lookup_blocks_bytes(inodes);
 
 	TRACE("In read_inode_lookup_table, length %d\n", length);
 
@@ -128,51 +165,69 @@ __le64 *squashfs_read_inode_lookup_table(struct super_block *sb,
 
 	/* there should always be at least one inode */
 	if (inodes == 0)
-		return ERR_PTR(-EINVAL);
+		return -EIO;
 
 	/*
 	 * The computed size of the lookup table (length bytes) should exactly
 	 * match the table start and end points
 	 */
-	if (length != (next_table - lookup_table_start))
-		return ERR_PTR(-EINVAL);
-
-	table = squashfs_read_table(sb, lookup_table_start, length);
-	if (IS_ERR(table))
-		return table;
+	if (lookup_table_start >= next_table ||
+				length != (next_table - lookup_table_start))
+		return -EIO;
+
+	if (length <= (PAGE_SIZE * 4)) {
+		/* Read lookup table index into memory */
+		s32 indexes = squashfs_lookup_blocks(inodes);
+		__le64 *array;
+		u64 start, end;
+		int n;
+
+		array = squashfs_read_table(sb, lookup_table_start, length);
+		if (IS_ERR(array))
+			return PTR_ERR(array);
+
+		/*
+		 * array0], array[1], ... array[indexes - 1] store the locations
+		 * of the compressed inode lookup blocks.  Each entry should be
+		 * less than the next (i.e. array[0] < array[1]), and the difference
+		 * between them should be SQUASHFS_METADATA_SIZE or less.
+		 * array[indexes - 1] should  be less than lookup_array_start, and
+		 * again the difference should be SQUASHFS_METADATA_SIZE or less
+		 */
+		for (n = 0; n < (indexes - 1); n++) {
+			start = le64_to_cpu(array[n]);
+			end = le64_to_cpu(array[n + 1]);
+
+			if (start >= end || (end - start) > (SQUASHFS_METADATA_SIZE
+						+ SQUASHFS_BLOCK_OFFSET)) {
+				kfree(array);
+				return -EIO;
+			}
+		}
 
-	/*
-	 * table0], table[1], ... table[indexes - 1] store the locations
-	 * of the compressed inode lookup blocks.  Each entry should be
-	 * less than the next (i.e. table[0] < table[1]), and the difference
-	 * between them should be SQUASHFS_METADATA_SIZE or less.
-	 * table[indexes - 1] should  be less than lookup_table_start, and
-	 * again the difference should be SQUASHFS_METADATA_SIZE or less
-	 */
-	for (n = 0; n < (indexes - 1); n++) {
-		start = le64_to_cpu(table[n]);
-		end = le64_to_cpu(table[n + 1]);
-
-		if (start >= end
-		    || (end - start) >
-		    (SQUASHFS_METADATA_SIZE + SQUASHFS_BLOCK_OFFSET)) {
-			kfree(table);
-			return ERR_PTR(-EINVAL);
+		start = le64_to_cpu(array[indexes - 1]);
+		if (start >= lookup_table_start || (lookup_table_start - start) >
+			    (SQUASHFS_METADATA_SIZE + SQUASHFS_BLOCK_OFFSET)) {
+			kfree(array);
+			return -EIO;
 		}
-	}
 
-	start = le64_to_cpu(table[indexes - 1]);
-	if (start >= lookup_table_start ||
-	    (lookup_table_start - start) >
-	    (SQUASHFS_METADATA_SIZE + SQUASHFS_BLOCK_OFFSET)) {
-		kfree(table);
-		return ERR_PTR(-EINVAL);
+		msblk->inode_lookup_array = array;
+		msblk->lookup_table_is_cache = false;
+	} else {
+		/* Use a cache to store the last 4 pages of indexes read */
+		struct squashfs_cache *cache = squashfs_cache_init("inode index", 4, PAGE_SIZE);
+
+		if (IS_ERR(cache))
+			return PTR_ERR(cache);
+
+		msblk->inode_lookup_cache = cache;
+		msblk->lookup_table_is_cache = true;
 	}
 
-	return table;
+	return 0;
 }
 
-
 const struct export_operations squashfs_export_ops = {
 	.encode_fh = generic_encode_ino32_fh,
 	.fh_to_dentry = squashfs_fh_to_dentry,
diff --git a/fs/squashfs/squashfs.h b/fs/squashfs/squashfs.h
index 1947a469a0b4..14ccc2776b5c 100644
--- a/fs/squashfs/squashfs.h
+++ b/fs/squashfs/squashfs.h
@@ -64,8 +64,9 @@ extern const struct squashfs_decompressor_thread_ops squashfs_decompressor_percp
 #endif
 
 /* export.c */
-extern __le64 *squashfs_read_inode_lookup_table(struct super_block *, u64, u64,
+extern int squashfs_read_inode_lookup_table(struct super_block *, u64, u64,
 				unsigned int);
+extern s64 squashfs_inode_lookup_start(struct super_block *sb, u32 ino_num);
 
 /* fragment.c */
 extern int squashfs_frag_lookup(struct super_block *sb, unsigned int fragment,
diff --git a/fs/squashfs/squashfs_fs_sb.h b/fs/squashfs/squashfs_fs_sb.h
index 949dab87a241..d6b5908fff51 100644
--- a/fs/squashfs/squashfs_fs_sb.h
+++ b/fs/squashfs/squashfs_fs_sb.h
@@ -64,11 +64,16 @@ struct squashfs_sb_info {
 	struct mutex				meta_index_mutex;
 	struct meta_index			*meta_index;
 	void					*stream;
-	__le64					*inode_lookup_table;
+	union {
+		__le64				*inode_lookup_array;
+		struct squashfs_cache		*inode_lookup_cache;
+	};
 	u64					inode_table;
 	u64					directory_table;
 	u64					directory_table_end;
 	u64					xattr_table;
+	u64					lookup_table;
+	u64					lookup_table_start;
 	unsigned int				block_size;
 	unsigned short				block_log;
 	long long				bytes_used;
@@ -79,5 +84,6 @@ struct squashfs_sb_info {
 	bool					panic_on_errors;
 	const struct squashfs_decompressor_thread_ops *thread_ops;
 	int					max_thread_num;
+	bool					lookup_table_is_cache;
 };
 #endif
diff --git a/fs/squashfs/squashfs_helpers.h b/fs/squashfs/squashfs_helpers.h
index 33e617c62918..3767bd6ebe45 100644
--- a/fs/squashfs/squashfs_helpers.h
+++ b/fs/squashfs/squashfs_helpers.h
@@ -136,11 +136,37 @@ static inline s32 squashfs_lookup_blocks(u32 inodes)
 		SQUASHFS_METADATA_SIZE;
 }
 
-static inline s32 squashfs_lookup_block_bytes(u32 inodes)
+static inline s32 squashfs_lookup_blocks_bytes(u32 inodes)
 {
 	return squashfs_lookup_blocks(inodes) * sizeof(long long);
 }
 
+static inline s32 squashfs_lookup_blocks_base(u32 inodes)
+{
+	return (squashfs_lookup_block(inodes) * sizeof(long long)) & ~(PAGE_SIZE - 1);
+}
+
+static inline s64 squashfs_lookup_blocks_start(u32 inodes, struct squashfs_sb_info *msblk)
+{
+	s32 base = squashfs_lookup_blocks_base(inodes);
+	s64 start;
+
+	if (S64_MAX - msblk->lookup_table < base)
+		return -EINVAL;
+
+	start = msblk->lookup_table + base;
+
+	if (start > msblk->bytes_used)
+		return -EINVAL;
+
+	return start;
+}
+
+static inline s16 squashfs_lookup_blocks_offset(u32 inodes)
+{
+	return (squashfs_lookup_block(inodes) * sizeof(long long)) & (PAGE_SIZE - 1);
+}
+
 /* uid lookup table defines */
 static inline s32 squashfs_id_bytes(u16 ids)
 {
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 8c42f1eb375b..8504939f9a8e 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -177,6 +177,13 @@ static const struct squashfs_decompressor *supported_squashfs_filesystem(
 	return decompressor;
 }
 
+static void squashfs_free_inode_table(struct squashfs_sb_info *msblk)
+{
+	if (msblk->lookup_table_is_cache)
+		squashfs_cache_delete(msblk->inode_lookup_cache);
+	else
+		kfree(msblk->inode_lookup_array);
+}
 
 static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
@@ -187,8 +194,9 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	long long root_inode;
 	unsigned short flags;
 	unsigned int fragments;
-	u64 lookup_table_start, xattr_id_table_start, next_table;
-	int err, devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
+	u64 xattr_id_table_start, next_table;
+	s64 err;
+	int devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
 
 	TRACE("Entered squashfs_fill_superblock\n");
 
@@ -391,20 +399,24 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	next_table = le64_to_cpu(msblk->id_table[0]);
 
 	/* Handle inode lookup table */
-	lookup_table_start = le64_to_cpu(sblk->lookup_table_start);
-	if (lookup_table_start == SQUASHFS_INVALID_BLK)
+	msblk->lookup_table = le64_to_cpu(sblk->lookup_table_start);
+	if (msblk->lookup_table == SQUASHFS_INVALID_BLK)
 		goto handle_fragments;
 
 	/* Allocate and read inode lookup table */
-	msblk->inode_lookup_table = squashfs_read_inode_lookup_table(sb,
-		lookup_table_start, next_table, msblk->inodes);
-	if (IS_ERR(msblk->inode_lookup_table)) {
+	err = squashfs_read_inode_lookup_table(sb, msblk->lookup_table,
+			next_table, msblk->inodes);
+	if (err < 0) {
+		errorf(fc, "unable to read inode lookup table");
+		goto failed_mount;
+	}
+
+	err = squashfs_inode_lookup_start(sb, 1);
+	if (err < 0) {
 		errorf(fc, "unable to read inode lookup table");
-		err = PTR_ERR(msblk->inode_lookup_table);
-		msblk->inode_lookup_table = NULL;
 		goto failed_mount;
 	}
-	next_table = le64_to_cpu(msblk->inode_lookup_table[0]);
+	next_table = msblk->lookup_table_start = err;
 
 	sb->s_export_op = &squashfs_export_ops;
 
@@ -480,7 +492,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (msblk->cache_mapping)
 		iput(msblk->cache_mapping->host);
 	msblk->thread_ops->destroy(msblk);
-	kfree(msblk->inode_lookup_table);
+	squashfs_free_inode_table(msblk);
 	kfree(msblk->fragment_index);
 	kfree(msblk->id_table);
 	kfree(msblk->xattr_id_table);
@@ -603,7 +615,7 @@ static void squashfs_put_super(struct super_block *sb)
 		kfree(sbi->id_table);
 		kfree(sbi->fragment_index);
 		kfree(sbi->meta_index);
-		kfree(sbi->inode_lookup_table);
+		squashfs_free_inode_table(sbi);
 		kfree(sbi->xattr_id_table);
 		kfree(sb->s_fs_info);
 		sb->s_fs_info = NULL;
-- 
2.47.3

