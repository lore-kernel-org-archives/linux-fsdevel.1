Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.24
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440695;
	b=oe1J+R8I7RahC6m6CJ+25McydMEARkSl2xgRmx63DHxJreEC0lyrpMn+2mPflzW6fZlL
	 uAM0taVfS2ma6L6N/4x4JHfevJl8y5GFJVPTTM2iAedGIaKsvAEijsa7m4u28IR1G0wgh
	 yPRzilASSFsvCZpsV/En+wQpapkfrRNVutmfD8mdn6Ew1hjvDUF2GWAOXAXzVbt8RBkwB
	 LjyiNTVKwF9xkFv5Tm1+Ao2VnEkSupphunR8TqNMy24ReK/av/u+ikZ64TYatPKzYRukF
	 9iPLlveuMvBZSQTB/AHmR6AKv/cKhvbTpMpJLQZhhanUVwpqsc1Nt0ITGLiCqQjgDZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440695;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=8OC7I4ZQQIOfILX9f81Nguo/RpQaFNoWsWwoBJXWhT4=;
	b=todnadh/6aJXpGWcwctwKAj8kp+kyaXl5dtZ7mF5V4+FX1ENZrkxqsk8lmF6rC0mrvhO
	 Ncj1jrkBxtvVOpDBRXxr/yfoUzbfkC6KxDhj84gkFXArmXI3cjknGgEDROd3izUTFYLPX
	 yUYSvvhPExlK8QXnv2/A6r1QsyQlHdKO1LL41K5VrMmr2ZtnGX6c1596jxN1UgvKHrhaV
	 o4wVIJnJ0FziMBBbspea6Fjfa94QrQ+R0Ja44RmHRPOImz2uOKVwbzZugkwsM7jltWY4K
	 PgSQDjfUAH/QKXKt/49lGts3kluVjbM0IpRthbZXLc7AQbSYYpiViBW48mLtccxhVpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=GTVSHWGP;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=ZgzL2zf8;
	arc=none smtp.remote-ip=188.121.53.24
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [188.121.53.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9971606F713
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9971606F713
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=GTVSHWGP;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=ZgzL2zf8
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHzixAFYp; Wed, 11 Nov 2026 23:44:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440688;
	bh=8OC7I4ZQQIOfILX9f81Nguo/RpQaFNoWsWwoBJXWhT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GTVSHWGPFsebjp7AW952KzmubhBDafu8w3Vv+KRButZZE6iO06holW39Qhm1HbH8M
	 rrBkQa71vF1XHF/+TNhsRhnAM5lr7fsXbcKsZnsJlGn+18kbWxnx7SEeN4ShHPBymN
	 IXN7QtM7526e/RzVrBlCivmYgbSPS2DYNcbhbbmPw1ecB4LNkqq51OFBVyXy/dSAjK
	 /e26XJ34USZVCfXc6Ug2szPhh8SQzZz2UtD9wTE0++hY6BFva4RRxGGmGL9ehu4ZUG
	 J+EvMXpFoHJJgOS1Sg630Ku0vdq3FjUX41k9FGnhYw7r7tLLTMNpBLoLiqvDxd8QwX
	 OuvsvRIyuc3nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440688;
	bh=8OC7I4ZQQIOfILX9f81Nguo/RpQaFNoWsWwoBJXWhT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZgzL2zf8+ojENEFdXn7QVJcnV9sImtytrbfRlOcb3hzYA7XxBorpU+sCC673VdxUb
	 yGmr2hxooCRGLw8wYZnbf7Oa/3pT1yiNrpbtgDiCW7ZLtMN4/CPr6dbBg16dudhcbt
	 wgk7ft0KJf3ER+zJhlHqGXnL6eMoLMujBT1ZJBJ7GTiYJbvJlVS24Yyd+VHnSeyE0p
	 qaD5hmFkfDOUVWFLOrYBA+eM2dfbpKsPKweZK3+GI1oRra/F6rIRXe3ajDkCLkCY6f
	 xrUU7DcIZ6iMwzB3v57crsZFmp1++9kCx8lFeCWiKIKoMlrju4EYNhXNtxCyAPvXMW
	 eB5X/Gd7dA8Lg==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fdf0
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=lGTX8VaO4shjFcm2bYEA:9 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: 2a3e655b2ad8790b03e7620b85b13085:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 13/22] Squashfs: very large files can exceed an int block count
Date: Wed, 11 Nov 2026 23:43:53 +0000
Message-ID: <20261111234402.252354-14-phillip@squashfs.org.uk>
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
X-CMAE-Envelope: MS4xfBKaC+xuHfux9eYlL0auSmXKmaxYVAaeoZWh0pCc5LhEe3ftBi4ZJudC49O6gTXwgRWcpqGu40PvPNLBs1C2O/5+ai6rDpSHhNhw+dc5UBZGJ2+ykf2H
 1DeIg4HdKNy/CJfEA4t/WY52xc4trruV+GlUG4ttUgKFY98P9QI83FIQE7q7lfOxLcCtsjfpDVVme9u++Mlf83mDZhYcNMswiIz4sAWg5JE7MI2ymIEdYegA
 MJgrdFLOgnAA2KrCMRy6seRzskihlTTkmfriZ2oaYMY2qYk2ii8zPmdwsHuF6uR6iqL6U0+mSQ34kd02RHGUfhNknTlVphD6uk4xjGXq7f0=

Squashfs in many places uses a signed int to store the block number and
block count of a file.  If the block size is using the Linux page size
(normally 4 KiB), it means any file larger than 8 TiB (2^43) will
overflow a signed int.

If the block number and block count is in terms of the Squashfs
filesystem block size (which can be between 4 kiB and 1 MiB), it
depends on the block size as to when a signed int will overflow, but a
file larger than 256 TiB (2^48) using 128 KiB blocks will overflow a
signed int.

This commit widens all appropriate variables to long long (s64) to
avoid overflow.

Reproducer
==========

The following reproducer creates a Squashfs filesystem with a 8 TiB +
4096 byte sparse file.  The filestem is mounted, and the last 4096
bytes are read from the file.  If the reproducer is successful the
process will hang.  This is because signed int overflow occurs in
squashfs_copy_cache() with the result that folio_end_read() is
not called.

====================================================================

finish() {
	popd 2>&1 > /dev/null
	rm -rf $DIR
	exit 1
}

DIR=$(mktemp -d)

pushd $DIR 2>&1 > /dev/null

echo "Create an 8 Tib (2^43) + 4096 byte sparse file"

if ! truncate --size 8796093026304 bigfile; then
	echo Create of sparse file failed.
	finish
fi

echo Generate the Squashfs filesystem containing the sparse file
echo This will be VERY slow on Squashfs-tools older than 4.7.3

mksquashfs bigfile bigfile.sqsh -b 1M -quiet

echo Mount the filesystem to /mnt

if ! mount -t squashfs bigfile.sqsh /mnt; then
	echo Mount of Squashfs filesystem failed
	finish
fi

echo Read the last 4096 bytes from the sparse file.
echo If the exploit succeeds the process will hang

dd if=/mnt/bigfile bs=1 skip=8796093022208

popd 2>&1 > /dev/null
rm -rf $DIR
exit 0
====================================================================

Fixes: 1701aecb6849c ("Squashfs: regular file operations")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
v2:
  - Ensure return value of fill_meta_data() is evaluated using 64-bit
    arithmetic
  - Widen int n to s64 in read_indexes()
---
 fs/squashfs/file.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index ad6382cd22d3..2396fad1de61 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -35,6 +35,7 @@
 #include <linux/string.h>
 #include <linux/pagemap.h>
 #include <linux/mutex.h>
+#include <linux/math64.h>
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
@@ -160,7 +161,7 @@ static void release_meta_index(struct inode *inode, struct meta_index *meta)
  * Read the next n blocks from the block list, starting from
  * metadata block <start_block, offset>.
  */
-static long long read_indexes(struct super_block *sb, int n,
+static long long read_indexes(struct super_block *sb, s64 n,
 				u64 *start_block, int *offset)
 {
 	int err, i;
@@ -173,7 +174,7 @@ static long long read_indexes(struct super_block *sb, int n,
 	}
 
 	while (n) {
-		int blocks = min_t(int, n, PAGE_SIZE >> 2);
+		int blocks = min_t(s64, n, PAGE_SIZE >> 2);
 
 		err = squashfs_read_metadata(sb, blist, start_block,
 				offset, blocks << 2);
@@ -216,7 +217,7 @@ static long long read_indexes(struct super_block *sb, int n,
  */
 static inline int calculate_skip(u64 blocks)
 {
-	u64 skip = blocks / ((SQUASHFS_META_ENTRIES + 1)
+	u64 skip = div_u64(blocks, (SQUASHFS_META_ENTRIES + 1)
 		 * SQUASHFS_META_INDEXES);
 	return min((u64) SQUASHFS_CACHED_BLKS - 1, skip + 1);
 }
@@ -227,7 +228,7 @@ static inline int calculate_skip(u64 blocks)
  * on-disk locations of the datablock and block list metadata block
  * <index_block, index_offset> for index (scaled to nearest cache index).
  */
-static int fill_meta_index(struct inode *inode, int index,
+static s64 fill_meta_index(struct inode *inode, s64 index,
 		u64 *index_block, int *index_offset, u64 *data_block)
 {
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
@@ -243,7 +244,7 @@ static int fill_meta_index(struct inode *inode, int index,
 	/*
 	 * Scale index to cache index (cache slot entry)
 	 */
-	index /= SQUASHFS_META_INDEXES * skip;
+	index = div_u64(index, SQUASHFS_META_INDEXES * skip);
 
 	while (offset < index) {
 		meta = locate_meta_index(inode, offset + 1, index);
@@ -315,7 +316,7 @@ static int fill_meta_index(struct inode *inode, int index,
 	/*
 	 * Scale cache index (cache slot entry) to index
 	 */
-	return offset * SQUASHFS_META_INDEXES * skip;
+	return (s64)offset * SQUASHFS_META_INDEXES * skip;
 
 failed:
 	release_meta_index(inode, meta);
@@ -327,14 +328,14 @@ static int fill_meta_index(struct inode *inode, int index,
  * Get the on-disk location and compressed size of the datablock
  * specified by index.  Fill_meta_index() does most of the work.
  */
-static int read_blocklist_ptrs(struct inode *inode, int index, u64 *start,
+static int read_blocklist_ptrs(struct inode *inode, s64 index, u64 *start,
 	int *offset, u64 *block)
 {
 	long long blks;
 	__le32 size;
-	int res = fill_meta_index(inode, index, start, offset, block);
+	s64 res = fill_meta_index(inode, index, start, offset, block);
 
-	TRACE("read_blocklist: res %d, index %d, start 0x%llx, offset 0x%x, block 0x%llx\n",
+	TRACE("read_blocklist: res %lld, index %lld, start 0x%llx, offset 0x%x, block 0x%llx\n",
 				res, index, *start, *offset, block ? *block : 0);
 
 	if (res < 0)
@@ -364,7 +365,7 @@ static int read_blocklist_ptrs(struct inode *inode, int index, u64 *start,
 	return squashfs_block_size(size);
 }
 
-static inline int read_blocklist(struct inode *inode, int index, u64 *block)
+static inline int read_blocklist(struct inode *inode, s64 index, u64 *block)
 {
 	u64 start;
 	int offset;
@@ -397,8 +398,8 @@ void squashfs_copy_cache(struct folio *folio,
 	struct address_space *mapping = folio->mapping;
 	struct inode *inode = mapping->host;
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
-	int i, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
-	int start_index = folio->index & ~mask, end_index = start_index | mask;
+	s64 i, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
+	s64 start_index = folio->index & ~mask, end_index = start_index | mask;
 
 	/*
 	 * Loop copying datablock into pages.  As the datablock likely covers
@@ -412,7 +413,7 @@ void squashfs_copy_cache(struct folio *folio,
 		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
 		bool updated = false;
 
-		TRACE("bytes %zu, i %d, available_bytes %zu\n", bytes, i, avail);
+		TRACE("bytes %zu, i %lld, available_bytes %zu\n", bytes, i, avail);
 
 		push_folio = (i == folio->index) ? folio :
 			__filemap_get_folio(mapping, i,
@@ -464,8 +465,8 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 {
 	struct inode *inode = folio->mapping->host;
 	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
-	int index = folio->index >> (msblk->block_log - PAGE_SHIFT);
-	int file_end = i_size_read(inode) >> msblk->block_log;
+	s64 index = folio->index >> (msblk->block_log - PAGE_SHIFT);
+	s64 file_end = i_size_read(inode) >> msblk->block_log;
 	int expected = index == file_end ?
 			(i_size_read(inode) & (msblk->block_size - 1)) :
 			 msblk->block_size;
@@ -584,7 +585,7 @@ static void squashfs_readahead(struct readahead_control *ractl)
 	unsigned int nr_pages = 0;
 	struct page **pages;
 	int i;
-	loff_t file_end = i_size_read(inode) >> msblk->block_log;
+	s64 file_end = i_size_read(inode) >> msblk->block_log;
 	unsigned int max_pages = 1UL << shift;
 
 	readahead_expand(ractl, start, (len | mask) + 1);
-- 
2.47.3

