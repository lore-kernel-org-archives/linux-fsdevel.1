Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=92.204.81.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440697;
	b=W0+lNcHzcbqYxRUdrUi7G1fWlqjdvzf1AfH+4dgLxY/TbJ0qK9wGH+vj+yhX0OfVK0R7
	 aiXJSAyO721kJ5K+Ld6JBYQxIQP4zV1YpMa5mNChOTPx1cutt7s5kTlyBR5PTGO2vBhBZ
	 W8K8xVCogDpagjQMU+8UzMZEcIU6GhfVf9kIU3wsWwY1rJZLL1D/4EWj5c0FJ0yMg8U90
	 xoQ/X7UjT+msHfW9KhxakxzM7u558BOB/2ITpBY0VIU55864gZOlYfUpDmFU+cDLDHn3T
	 SldVOLTP0jVfwsgarDBs5+ngRtLEXpqjNFYBJ+FKsNlFH+/W5xbSvk9WdrzE+4t6Zsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440697;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=JgATLH6zKQKTOc9e1w1ejnf6eH7WAhhgNo/J6AvQ39o=;
	b=cR3ugg5aCLLjKO6h1aVZfubQIFGnJ6DtXefmICJNKSkxA4e5zgtEORgBbrkNp9fPAvRS
	 d1AyJ2wqlo/2BZn31CSBgPXPCReR98MLXT5boJF8fQnarYHJuJLmJ629EndpOHUsluMJZ
	 8ExeLi3NLwq3AK8LVe/yt7hHmh+Wb66fLdMjE3nH3wauxOPfV+ffVKe5fnJxUCN/asWBt
	 BLbczbFjwWgaBw+oAloD3ZZi7xjaLbwxcYEtliMwflZY5peDsVXbR++xFwWS1vD7shjNY
	 3jUkFK7PPp7sIpcfsL6TYm/OiHuswrAOZ1nf7VupfbaR8vx+W1MK1VfKMVzKua20uGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=OOcjaJzW;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b="R7o1/D0V";
	arc=none smtp.remote-ip=92.204.81.38
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [92.204.81.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB0A606A893
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDB0A606A893
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=OOcjaJzW;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=R7o1/D0V
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHzkxAFYx; Wed, 11 Nov 2026 23:44:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440690;
	bh=JgATLH6zKQKTOc9e1w1ejnf6eH7WAhhgNo/J6AvQ39o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OOcjaJzW673MbWyFRXB+pwyQWIa0EW/KAgi1d5Jj9xDrh6B3Iy/SkDl8OJO76n1rT
	 8s8sWpxzkXDDRnzJVhl61SbU41Zlt3jCtPQG6NqHnBr+2m2/yWAuFwoQSV8hLN9Sim
	 Mm27Zy+W5q/vo/JnAkoW53O56unTMpHG16t+14A5Rux234BG2gAxJaixkqYOZpyPY2
	 kXg9ex1L2viGm5vsqWXqouRwVmEWOw8c7J99mxrSR+UsBsH54W8djhjwa2eTaaewjO
	 LoJBM3pKr5LsYbdhxYv4ITbZIYkE6VWAGysr1f6MSGbHzmZVlYnbL3CI6v8auorBKx
	 24zBZ0gjjQ8Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440690;
	bh=JgATLH6zKQKTOc9e1w1ejnf6eH7WAhhgNo/J6AvQ39o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R7o1/D0Vxkbv9x9j62zvgytGaqd9gYRAIhBaDKCa+TzjBgp8/6Cbx8Lxes9vk39Tw
	 E2B15rEBRqmDH0pHr6mLePYhnzoXuXkmgAnoFhUlVA2VT0ViX+ie3xY6Oyscn5NCUE
	 a47vR6SLic2UQeWatqDxVohVgj8DIKy5xvLwNA5NJxLiWlka7q3h0hUc2sFGomfBvR
	 Z/vhriTn2mLTWmy7ad+wjnuxVW9MMTwSRCOh+xCgK0W5oNvqSYifMfXQTsDtRuljJM
	 AjMJeZxisKLcI8Pq8DR6p63uoeKUdujjT8pcoxwd8eoVGF1k2K6bQQqr4wjP1+8Y7P
	 HmNCmwm0eprEg==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fdf2
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=RkH14jvAPMWmjoHUV8UA:9 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: 19798285c647448f3e954976d0aaa4f7:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 14/22] Squashfs: add more sanity checking to squashfs_block_size()
Date: Wed, 11 Nov 2026 23:43:54 +0000
Message-ID: <20261111234402.252354-15-phillip@squashfs.org.uk>
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
X-CMAE-Envelope: MS4xfMXW3MSYyY2yhkdV97QvtRnnKFNdaCAFk5PrqfkfbPqDSpl8lDyS46jNkUlmlxomlh7DycyrxSVTRZPPMY9DWI1LCpYkOHiloVNIVVa8US/ukfAzI50T
 ZgUmXXcGymwz+Y0GRbBfSxsCtWXzAk2QrO34eLWufhZ4Ycu7LNe7GxTQ4imLe1MUcBpAtktRwinVAqmCgjayiFzM0A/NKksVoYoJIFWJC8BDwvFXq+2JuLnd
 WOoiEK1E/ABCPefsociSNnpwZD2gggcGtixplI4G6mpnL3rTgYp0haxc/raL0jy8RrkTs+u5gmnEMioifjGe+6a0/j/FlssuqLPE6Xpmirs=

Squashfs_block_size() sanity checks the data and fragment block size
read from disk.  However, it doesn't do all the sanity checking that
it could do.  This means detectably invalid block sizes are passed
down to squashfs_read_data().

This situation is sub-optimal because in the case of fragment
blocks, a fragment cache buffer has to obtained (with possible
waits for a free buffer etc.) before squashfs_read_data() is called.

In both fragment and data block cases if the buffer is compressed, it
means a free decompressor may be obtained (with possible waits for a
decompressor) by squashfs_read_data(), only to have the decompression
fail.

In both these cases this adds unnecessary overhead which may impact
performance, and this is with values that should have been detected
earlier.

This commit adds extra sanity checking to trap additional incorrect
values.

Reproducer
==========

The reproducer generates a Squashfs filesystem and then corrupts the
block size value for file zero block 0.  If the exploit succeeds this
corrupted value is not detected, and it is passed to the decompressor
via squashfs_read_data() which then fails at that point.

====================================================================
#!/bin/bash

ARGS="-quiet -no-progress -no-fragments -noI -noD -no-sparse -comp gzip"

finish() {
	popd 2>&1 > /dev/null
	rm -rf $DIR
	exit 1
}

DIR=$(mktemp -d)

pushd $DIR 2>&1 > /dev/null

echo Create Squashfs filesystem with one file

echo "/ d 0777 0 0" > pseudo
echo "zero f 0777 0 0 dd if=/dev/zero bs=1024 count=128 2>/dev/null" >> pseudo

if ! mksquashfs - img.sqsh -pf pseudo $ARGS; then
	echo Failed to create Squashfs filesystem
	finish

fi

echo Corrupt the data block size for block 0 in file zero
echo Flip the compression bit from uncompressed to compressed.
echo "This is at byte offset 131207 (96 + 128 KiB + 37)"

dd if=/dev/zero of=img.sqsh seek=131205 bs=1 count=1 conv=notrunc status=none

echo Mount the filesystem to /mnt

if ! mount -t squashfs img.sqsh /mnt; then
	echo Mount of Squashfs filesystem failed
	finish
fi

echo Read the file zero.
echo If the exploit succeeds, dmesg should show the following:
echo "SQUASHFS error: zlib decompression failed, data probably corrupt"
echo "SQUASHFS error: Failed to read block 0x60: -5"
echo "SQUASHFS error: zlib decompression failed, data probably corrupt"
echo "SQUASHFS error: Failed to read block 0x60: -5"
echo "SQUASHFS error: Unable to read data cache entry [60]"
echo "SQUASHFS error: Unable to read page, block 60, size 20000"

dd if=/mnt/zero

popd 2>&1> /dev/null

rm -rf $DIR
==============================================================================

Fixes: 1701aecb6849c ("Squashfs: regular file operations")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
v2: Add additional sanity check, a zero size cannot have
    SQUASHFS_COMPRESSED_BIT_BLOCK set.
---
 fs/squashfs/file.c             |  8 +++++---
 fs/squashfs/fragment.c         |  2 +-
 fs/squashfs/squashfs_fs.h      |  6 ------
 fs/squashfs/squashfs_helpers.h | 36 ++++++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index 2396fad1de61..96c15088cdee 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -166,6 +166,7 @@ static long long read_indexes(struct super_block *sb, s64 n,
 {
 	int err, i;
 	long long block = 0;
+	struct squashfs_sb_info *msblk = sb->s_fs_info;
 	__le32 *blist = kmalloc(PAGE_SIZE, GFP_KERNEL);
 
 	if (blist == NULL) {
@@ -185,7 +186,7 @@ static long long read_indexes(struct super_block *sb, s64 n,
 		}
 
 		for (i = 0; i < blocks; i++) {
-			int size = squashfs_block_size(blist[i]);
+			int size = squashfs_data_size(blist[i], msblk->block_size);
 			if (size < 0) {
 				err = size;
 				goto failure;
@@ -333,6 +334,7 @@ static int read_blocklist_ptrs(struct inode *inode, s64 index, u64 *start,
 {
 	long long blks;
 	__le32 size;
+	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
 	s64 res = fill_meta_index(inode, index, start, offset, block);
 
 	TRACE("read_blocklist: res %lld, index %lld, start 0x%llx, offset 0x%x, block 0x%llx\n",
@@ -362,7 +364,7 @@ static int read_blocklist_ptrs(struct inode *inode, s64 index, u64 *start,
 			sizeof(size));
 	if (res < 0)
 		return res;
-	return squashfs_block_size(size);
+	return squashfs_data_size(size, msblk->block_size);
 }
 
 static inline int read_blocklist(struct inode *inode, s64 index, u64 *block)
@@ -720,7 +722,7 @@ static loff_t seek_hole_data(struct file *file, loff_t offset, int whence)
 			goto finished;
 
 		for (i = 0; i < indexes; i++) {
-			length = squashfs_block_size(blist[i]);
+			length = squashfs_data_size(blist[i], msblk->block_size);
 			if (length < 0) {
 				offset = length;
 				goto finished;
diff --git a/fs/squashfs/fragment.c b/fs/squashfs/fragment.c
index 9f63e5b5c513..1f372374c29d 100644
--- a/fs/squashfs/fragment.c
+++ b/fs/squashfs/fragment.c
@@ -54,7 +54,7 @@ int squashfs_frag_lookup(struct super_block *sb, unsigned int fragment,
 		return size;
 
 	*fragment_block = le64_to_cpu(fragment_entry.start_block);
-	return squashfs_block_size(fragment_entry.size);
+	return squashfs_frag_size(fragment_entry.size, msblk->block_size);
 }
 
 
diff --git a/fs/squashfs/squashfs_fs.h b/fs/squashfs/squashfs_fs.h
index 3e7d0730b2d9..6ca8d7227a0e 100644
--- a/fs/squashfs/squashfs_fs.h
+++ b/fs/squashfs/squashfs_fs.h
@@ -101,12 +101,6 @@
 #define SQUASHFS_XATTR_VALUE_OOL        256
 #define SQUASHFS_XATTR_PREFIX_MASK      0xff
 
-static inline int squashfs_block_size(__le32 raw)
-{
-	u32 size = le32_to_cpu(raw);
-	return (size >> 25) ? -EIO : size;
-}
-
 /* cached data constants for filesystem */
 #define SQUASHFS_CACHED_BLKS		8
 
diff --git a/fs/squashfs/squashfs_helpers.h b/fs/squashfs/squashfs_helpers.h
index 4fb13096fcbc..d46d123aefc4 100644
--- a/fs/squashfs/squashfs_helpers.h
+++ b/fs/squashfs/squashfs_helpers.h
@@ -204,4 +204,40 @@ static inline s16 squashfs_xattr_offset(s64 xattr)
 {
 	return xattr & 0xffff;
 }
+
+static inline int squashfs_block_size(u32 size, s32 block_size)
+{
+	/* reject any size with bits set where they should not be */
+	if ((size & ~SQUASHFS_COMPRESSED_BIT_BLOCK) > block_size)
+		return -EIO;
+
+	/* a block can't be both full size and compressed */
+	if (size == block_size)
+		return -EIO;
+
+	/* a zero size block will never have SQUASHFS_COMPRESSED_BIT_BLOCK set */
+	if (size == SQUASHFS_COMPRESSED_BIT_BLOCK)
+		return -EIO;
+
+	return size;
+}
+
+static inline int squashfs_data_size(__le32 raw, s32 block_size)
+{
+	return squashfs_block_size(le32_to_cpu(raw), block_size);
+}
+
+static inline int squashfs_frag_size(__le32 raw, s32 block_size)
+{
+	int size = squashfs_block_size(le32_to_cpu(raw), block_size);
+
+	if (size < 0)
+		return size;
+
+	/* a fragment block can't be zero size */
+	if (size == 0)
+		return -EIO;
+
+	return size;
+}
 #endif
-- 
2.47.3

