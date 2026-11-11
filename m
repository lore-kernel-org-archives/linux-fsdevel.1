Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440705;
	b=HO5FLXywGylMZkSvQuVPWgwlUhigiBn/zAY2L7ZzshFEhqC2GT6OMShB1ofZvE1qIDN+
	 F29uZJSC9SWQ46Ebboc8cgxm/Vqq49478XzmytHDC7H2fW8BcWgtFrX9OPX3wScNUfhxw
	 NQ4WI1IQtmx5xorxhOmWlQbvdIksN1RZzJ5she4VI1JnN3hVwYfZpwIZ9Js9huTtHGIl1
	 r6ZSy1yY5indps5h+Gaes8qygf1qCV+64+MVOR1rcrXNkvDFVQGzjMgmmTUJMCS855yXA
	 k/hWdX9PwhiXd9z/6S4+0zJXYLr6yv1gW08QN3chrVl1TEOwRrr8c4LebqBwVSrzhcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440705;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=0mJmyH4dlr16c7cyVywiCkC70TJeRP6mK1aVf8SiT34=;
	b=q0Z8MPr+sIQ0/SLY4OykeJC6DZHEo5r4VlTZwUD+xGulio1MEuJUId0qfUNpXEolp8Yr
	 lzQSrxnVT/DNgq+RMQMNTaFclDMKU3hLkvhoZcZXLtojxfwtu7zFJFK/wZe6/ueB4SUwp
	 2KzWnQq1hpoxc273Pr4te8/C+K5LhDk4R+Gtzie7kxz8+H88G1MSjMl+mxihjAjOkRRQO
	 H1DEOcmPVhISNPw0G0GCkKxM9/D5FbGGzYsG0hwY1vwkMz0jdlOTvzrExGmTaUkZFdNRv
	 oC5qR2EaIqxONrtj/9dL+QwivjtVrHR1PWXr2u+lcH9BwPAV7k67JXi2ng9JmrKt4lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=uy0zRzDi;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=dsbn0X2P;
	arc=none smtp.remote-ip=188.121.53.29
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [188.121.53.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8342606AE5C
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:45:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8342606AE5C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=uy0zRzDi;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=dsbn0X2P
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHzrxAFZR; Wed, 11 Nov 2026 23:44:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440697;
	bh=0mJmyH4dlr16c7cyVywiCkC70TJeRP6mK1aVf8SiT34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=uy0zRzDiyuxcc4XnB52BstdFbRMeAfhlwlg/kJFxjyyluadNQ68lk3k1gOWwF0C0+
	 86ORBuqG8X7Bnklfkzd+AG9vk9polkCDL18l90XjIiJCqojn/kN3/BZ+Rc+V7bXxGk
	 H9BAQKppBW3UJON1+6GiPGoMBy7+1XRHhwuAC3t7Fvn49n+aS0h+aTT8pBGPM0/Lyd
	 9rFqv9K0GuD8DHvWkzcyCZsWJN2C6DIbmby13Woa2Zg7t61RL9E9uPNC3KCyrXvR5S
	 XXxFtRW9XjEUDKidW6AxzRovvFEaKL/EC5vxciLxKiK7iJwvGNH48H+NAHnXSNmKP/
	 MiCur9NqZaV1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440697;
	bh=0mJmyH4dlr16c7cyVywiCkC70TJeRP6mK1aVf8SiT34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dsbn0X2PLnUsW7jOgT0p4g2NkVr2xnWvJ+2yncQTNaWNdQSsi9BaDchnUjePmYIDf
	 HMNpsZydoraIACIYcesQbiF/Evn19veSRuDQDAa38Wnamih2MruvBwPHX4CnArj6Vu
	 7LL7GNmtQ7Pr5eamwV0Rv9gWh12e/nUmzEtLrbiHqg424Efpfy6LNqPz3s2JWY/+CU
	 umvZemW6ERRi10tYikyoxzfANR15HDPBGssq0lFG+GL5gNaYfoGL3xialWtrRajCgK
	 +01uAGRh6ewoPkGbsx3Vbgx0Avi24/H8J64woB4Q6eGODLbK2Dud/ZLI5/JtE+mBFs
	 cFs3mrwjK7eww==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fdf9
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=bQtJiiKavY242qEU4p8A:9 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: d86520d012f28480aed7114c4e614ae0:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 18/22] Squashfs: don't store large fragment table indexes in memory
Date: Wed, 11 Nov 2026 23:43:58 +0000
Message-ID: <20261111234402.252354-19-phillip@squashfs.org.uk>
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
X-CMAE-Envelope: MS4xfC9o+jzprorz4MFHekl4n1w8Ls+Fg2GEnFmPJqX5FIpRibQLO5dl/CpT+cx/Gm+2RHbLtAUF50lRrI9tv5LbeadyzAY9vxTOhAa5qsbjcFg0w2UIwdJV
 HH4KZfDV4sV6/6Y9CDjYQQhNnycHjD53t0CJkpRt2WlrPAOhIW/TRHYO4Lq1EF0vr92o9g3obZjnCRw0h6tioY3KJT7Yg0XsUXGvdCXfy4oHaHd4r6pj1bzH
 4KRfsIrEkUTK+/RG/7nZNLNDVxCObjA0FTX/xkBP4ogCb5qhCiBweXRGFHszIpnK3n0SYusgC1LOcWFM1xgrEVWxXFGXRpOefax2ulA21NQ=

When mounting a Squashfs filesystem, the code reads the entire fragment
table indexes into memory.  Their size is determined by the number of
fragments in the filesystem, where the maximum number of fragments is
2^32, and this will allocate and read 64 MiB.

This is an execessive and unnecessary amount of memory because the
indexes do not need to be read into memory in their entirety.  In
addition kmalloc() is used to allocate memory, and this can fail when
large amounts of memory are requested.  Kmalloc() on modern kernels is
usually limited to 4096 KiB. If panic-on-warn is set, then failure to
allocate memory willl result in a kernel panic.

This commit uses a 4 page cache if the size of the fragment table
indexes are 4 pages or larger.  A simple and fast lookup array is
retained where the total index size is less than 4 pages in size, which
is the vast majority of Squashfs filesystems.

Reproducer
==========

The following reproducer will create a Squashfs filesystem with
280 million fragments, which will cause the fragment table indexes to
exceed 4096 KiB, and the kmalloc() should fail when the filesystem is
mounted.

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

# create 20 million pseudo file links to file 2049 bytes in size
truncate -s 2049 a
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

for i in $(seq 1 14); do
	sed "s/x/$i/g" file > pseudo
	echo
	echo Iteration $i - appending 20 million files to Squashfs filesystem
	echo
	if ! mksquashfs - $IMG -pf pseudo -mem 100m -no-hardlinks -no-sparse -no-duplicates -no-exports -pd "d 0777 0 0" -no-recovery -b 4096; then
		echo Appending to Squashfs filesystem failed
		finish
	fi
done

popd 2>&1 > /dev/null
rm -rf $DIR

echo Generated Squashfs filesystem $IMG
=====================================================================

Fixes: 122edd1514aaa ("Squashfs: fragment block operations")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
v2: Widen offset in squashfs_frag_lookup_start() to s32, to prevent
    overflow when PAGE_SIZE is 64 KiB or larger.
---
 fs/squashfs/fragment.c         | 99 ++++++++++++++++++++++++++--------
 fs/squashfs/squashfs.h         |  3 +-
 fs/squashfs/squashfs_fs_sb.h   |  8 ++-
 fs/squashfs/squashfs_helpers.h | 28 +++++++++-
 fs/squashfs/super.c            | 32 +++++++----
 5 files changed, 136 insertions(+), 34 deletions(-)

diff --git a/fs/squashfs/fragment.c b/fs/squashfs/fragment.c
index 429dbeba9c21..962ed1ce6497 100644
--- a/fs/squashfs/fragment.c
+++ b/fs/squashfs/fragment.c
@@ -29,26 +29,67 @@
 #include "squashfs_helpers.h"
 #include "squashfs.h"
 
+s64 squashfs_frag_lookup_start(struct super_block *sb, u32 fragment)
+{
+	struct squashfs_sb_info *msblk = sb->s_fs_info;
+	s64 start;
+
+	if (msblk->fragment_index_is_cache) {
+		s32 length = squashfs_fragment_indexes_bytes(msblk->fragments);
+		s32 base = squashfs_fragment_indexes_base(fragment);
+		s32 offset = squashfs_fragment_indexes_offset(fragment);
+		s32 avail = min_t(int, length - base, PAGE_SIZE);
+		struct squashfs_cache_entry *entry;
+
+		start = squashfs_fragment_indexes_start(fragment, msblk);
+		if (start < 0)
+			return start;
+
+		entry = squashfs_cache_get(sb, msblk->fragment_index_cache,
+				start, avail | SQUASHFS_COMPRESSED_BIT_BLOCK);
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
+		s32 block = squashfs_fragment_index(fragment);
+
+		start = le64_to_cpu(msblk->fragment_index_array[block]);
+	}
+
+	if (start < msblk->fragment_table_start || start >= msblk->fragment_table)
+		return -EIO;
+
+	return start;
+}
+
 /*
  * Look-up fragment using the fragment index table.  Return the on disk
  * location of the fragment and its compressed size
  */
+
 int squashfs_frag_lookup(struct super_block *sb, unsigned int fragment,
 				u64 *fragment_block, int *fragment_size)
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	int block, offset, size;
+	s32 offset, size;
 	struct squashfs_fragment_entry fragment_entry;
-	u64 start_block;
+	s64 start;
 
 	if (fragment >= msblk->fragments)
 		return -EIO;
-	block = squashfs_fragment_index(fragment);
-	offset = squashfs_fragment_index_offset(fragment);
 
-	start_block = le64_to_cpu(msblk->fragment_index[block]);
+	start = squashfs_frag_lookup_start(sb, fragment);
+	if (start < 0)
+		return start;
 
-	size = squashfs_read_metadata(sb, &fragment_entry, &start_block,
+	offset = squashfs_fragment_index_offset(fragment);
+	size = squashfs_read_metadata(sb, &fragment_entry, &start,
 					&offset, sizeof(fragment_entry));
 	if (size < 0)
 		return size;
@@ -57,16 +98,14 @@ int squashfs_frag_lookup(struct super_block *sb, unsigned int fragment,
 	*fragment_size = le32_to_cpu(fragment_entry.size);
 	return 0;
 }
-
-
 /*
  * Read the uncompressed fragment lookup table indexes off disk into memory
  */
-__le64 *squashfs_read_fragment_index_table(struct super_block *sb,
+int squashfs_read_fragment_index_table(struct super_block *sb,
 	u64 fragment_table_start, u64 next_table, unsigned int fragments)
 {
-	unsigned int length = squashfs_fragment_index_bytes(fragments);
-	__le64 *table;
+	struct squashfs_sb_info *msblk = sb->s_fs_info;
+	s32 length = squashfs_fragment_indexes_bytes(fragments);
 
 	/*
 	 * The computed size of the index table (length bytes) should exactly
@@ -74,18 +113,36 @@ __le64 *squashfs_read_fragment_index_table(struct super_block *sb,
 	 */
 	if (fragment_table_start >= next_table ||
 				length != (next_table - fragment_table_start))
-		return ERR_PTR(-EINVAL);
+		return -EINVAL;
 
-	table = squashfs_read_table(sb, fragment_table_start, length);
+	if (length <= (PAGE_SIZE * 4)) {
+		/* Read fragment index into memory */
+		__le64 *array = squashfs_read_table(sb, fragment_table_start, length);
 
-	/*
-	 * table[0] points to the first fragment table metadata block, this
-	 * should be less than fragment_table_start
-	 */
-	if (!IS_ERR(table) && le64_to_cpu(table[0]) >= fragment_table_start) {
-		kfree(table);
-		return ERR_PTR(-EINVAL);
+		if (IS_ERR(array))
+			return PTR_ERR(array);
+
+		/*
+		 * table[0] points to the first fragment table metadata block, this
+		 * should be less than fragment_table_start
+		 */
+		if (le64_to_cpu(array[0]) >= fragment_table_start) {
+			kfree(array);
+			return -EINVAL;
+		}
+
+		msblk->fragment_index_array = array;
+		msblk->fragment_index_is_cache = false;
+	} else {
+		/* Use a cache to store the last 16Kbytes of indexes read */
+		struct squashfs_cache *cache = squashfs_cache_init("fragment index", 4, PAGE_SIZE);
+
+		if (IS_ERR(cache))
+			return PTR_ERR(cache);
+
+		msblk->fragment_index_cache = cache;
+		msblk->fragment_index_is_cache = true;
 	}
 
-	return table;
+	return 0;
 }
diff --git a/fs/squashfs/squashfs.h b/fs/squashfs/squashfs.h
index 14ccc2776b5c..c4b8ff75ae3c 100644
--- a/fs/squashfs/squashfs.h
+++ b/fs/squashfs/squashfs.h
@@ -71,8 +71,9 @@ extern s64 squashfs_inode_lookup_start(struct super_block *sb, u32 ino_num);
 /* fragment.c */
 extern int squashfs_frag_lookup(struct super_block *sb, unsigned int fragment,
 				u64 *fragment_block, int *fragment_size);
-extern __le64 *squashfs_read_fragment_index_table(struct super_block *,
+extern int squashfs_read_fragment_index_table(struct super_block *,
 				u64, u64, unsigned int);
+extern s64 squashfs_frag_lookup_start(struct super_block *sb, u32 fragment);
 
 /* file.c */
 void squashfs_copy_cache(struct folio *, struct squashfs_cache_entry *,
diff --git a/fs/squashfs/squashfs_fs_sb.h b/fs/squashfs/squashfs_fs_sb.h
index d6b5908fff51..77f7085ad2d0 100644
--- a/fs/squashfs/squashfs_fs_sb.h
+++ b/fs/squashfs/squashfs_fs_sb.h
@@ -59,7 +59,10 @@ struct squashfs_sb_info {
 	struct address_space			*cache_mapping;
 	int					next_meta_index;
 	__le64					*id_table;
-	__le64					*fragment_index;
+	union {
+		__le64				*fragment_index_array;
+		struct squashfs_cache		*fragment_index_cache;
+	};
 	__le64					*xattr_id_table;
 	struct mutex				meta_index_mutex;
 	struct meta_index			*meta_index;
@@ -71,6 +74,8 @@ struct squashfs_sb_info {
 	u64					inode_table;
 	u64					directory_table;
 	u64					directory_table_end;
+	u64					fragment_table;
+	u64					fragment_table_start;
 	u64					xattr_table;
 	u64					lookup_table;
 	u64					lookup_table_start;
@@ -85,5 +90,6 @@ struct squashfs_sb_info {
 	const struct squashfs_decompressor_thread_ops *thread_ops;
 	int					max_thread_num;
 	bool					lookup_table_is_cache;
+	bool					fragment_index_is_cache;
 };
 #endif
diff --git a/fs/squashfs/squashfs_helpers.h b/fs/squashfs/squashfs_helpers.h
index 3767bd6ebe45..0f1aad9450cc 100644
--- a/fs/squashfs/squashfs_helpers.h
+++ b/fs/squashfs/squashfs_helpers.h
@@ -109,11 +109,37 @@ static inline s32 squashfs_fragment_indexes(u32 fragments)
 		SQUASHFS_METADATA_SIZE;
 }
 
-static inline s32 squashfs_fragment_index_bytes(u32 fragments)
+static inline s32 squashfs_fragment_indexes_bytes(u32 fragments)
 {
 	return squashfs_fragment_indexes(fragments) * sizeof(long long);
 }
 
+static inline s32 squashfs_fragment_indexes_base(u32 fragments)
+{
+	return (squashfs_fragment_index(fragments) * sizeof(long long)) & ~(PAGE_SIZE - 1);
+}
+
+static inline s64 squashfs_fragment_indexes_start(u32 fragments, struct squashfs_sb_info *msblk)
+{
+	s32 base = squashfs_fragment_indexes_base(fragments);
+	s64 start;
+
+	if (S64_MAX - msblk->fragment_table < base)
+		return -EINVAL;
+
+	start = msblk->fragment_table + base;
+
+	if (start > msblk->bytes_used)
+		return -EINVAL;
+
+	return start;
+}
+
+static inline s16 squashfs_fragment_indexes_offset(u32 fragments)
+{
+	return (squashfs_fragment_index(fragments) * sizeof(long long)) & (PAGE_SIZE - 1);
+}
+
 /* inode lookup table defines */
 static inline s64 squashfs_lookup_bytes(u32 inodes)
 {
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 8504939f9a8e..287cbc6ad41c 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -185,6 +185,14 @@ static void squashfs_free_inode_table(struct squashfs_sb_info *msblk)
 		kfree(msblk->inode_lookup_array);
 }
 
+static void squashfs_free_fragment_indexes(struct squashfs_sb_info *msblk)
+{
+	if (msblk->fragment_index_is_cache)
+		squashfs_cache_delete(msblk->fragment_index_cache);
+	else
+		kfree(msblk->fragment_index_array);
+}
+
 static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct squashfs_mount_opts *opts = fc->fs_private;
@@ -300,6 +308,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	msblk->inode_table = le64_to_cpu(sblk->inode_table_start);
 	msblk->directory_table = le64_to_cpu(sblk->directory_table_start);
+	msblk->fragment_table = le64_to_cpu(sblk->fragment_table_start);
 	msblk->inodes = le32_to_cpu(sblk->inodes);
 	msblk->fragments = le32_to_cpu(sblk->fragments);
 	msblk->ids = le16_to_cpu(sblk->no_ids);
@@ -317,8 +326,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	TRACE("Number of ids %d\n", msblk->ids);
 	TRACE("sblk->inode_table_start %llx\n", msblk->inode_table);
 	TRACE("sblk->directory_table_start %llx\n", msblk->directory_table);
-	TRACE("sblk->fragment_table_start %llx\n",
-		(u64) le64_to_cpu(sblk->fragment_table_start));
+	TRACE("sblk->fragment_table_start %llx\n", msblk->fragment_table);
 	TRACE("sblk->id_table_start %llx\n",
 		(u64) le64_to_cpu(sblk->id_table_start));
 
@@ -433,15 +441,19 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 
 	/* Allocate and read fragment index table */
-	msblk->fragment_index = squashfs_read_fragment_index_table(sb,
-		le64_to_cpu(sblk->fragment_table_start), next_table, fragments);
-	if (IS_ERR(msblk->fragment_index)) {
+	err = squashfs_read_fragment_index_table(sb, msblk->fragment_table,
+			next_table, fragments);
+	if (err < 0) {
+		errorf(fc, "unable to read fragment index table");
+		goto failed_mount;
+	}
+
+	err = squashfs_frag_lookup_start(sb, 0);
+	if (err < 0) {
 		errorf(fc, "unable to read fragment index table");
-		err = PTR_ERR(msblk->fragment_index);
-		msblk->fragment_index = NULL;
 		goto failed_mount;
 	}
-	next_table = le64_to_cpu(msblk->fragment_index[0]);
+	next_table = msblk->fragment_table_start = err;
 
 check_directory_table:
 	/* Sanity check directory_table */
@@ -493,7 +505,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 		iput(msblk->cache_mapping->host);
 	msblk->thread_ops->destroy(msblk);
 	squashfs_free_inode_table(msblk);
-	kfree(msblk->fragment_index);
+	squashfs_free_fragment_indexes(msblk);
 	kfree(msblk->id_table);
 	kfree(msblk->xattr_id_table);
 	kfree(sb->s_fs_info);
@@ -613,7 +625,7 @@ static void squashfs_put_super(struct super_block *sb)
 			iput(sbi->cache_mapping->host);
 		sbi->thread_ops->destroy(sbi);
 		kfree(sbi->id_table);
-		kfree(sbi->fragment_index);
+		squashfs_free_fragment_indexes(sbi);
 		kfree(sbi->meta_index);
 		squashfs_free_inode_table(sbi);
 		kfree(sbi->xattr_id_table);
-- 
2.47.3

