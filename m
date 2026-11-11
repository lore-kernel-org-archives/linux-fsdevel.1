Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.26
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440701;
	b=nYmEdJFhyGclj3Xtqc9znvZoMFEERIXv23kuo0Og91xhuRXPlDnGKL3SNfIt9q2JdgDJ
	 pIrnSXprlMPrJ8Zd6ctiQ1hwfAmBNt3zw418lV5ID3/gIXMzOfNOv2CcKjANyBtgYIym3
	 aG4JPRSzoF8bwyP5Qdr5g8yRbyRpwG0ZWCjzbWa6rv7/Lviac1Vbi0GeeInjUiCDK74yO
	 smX7R7zRdI+C+e8TVrHWfRS7oXHJSJx7QETpv8AfPQOvC35aiyuNLBxfDmO/DQ09b64qv
	 DgmffdnBJ5VukzDKt4B8WbHyo/X/Ey9WXFtR+gt1kt/NwFkSGcnlNqQwf6zrSUteLzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440701;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=bcj8JClKKOuj2flOo3CRoJC7KiL6mFt0YjclDonLtaY=;
	b=HToyK/kRVhNpFbNC9avcIJbeyWwOZIxuQ9fk1YD8e50M6eYdzy5LbhHC28P0sqKiuLf6
	 8V0Ikt5QqnfGMj2gkqli47YgvnXb2rRi3EKgnUdioj9E1xJq2GNn9DEvx3xDSxtYmhng5
	 QUeV0QlzbFfL/4J4EbIdaAlBnSKbIwuYTE3uYXUtOxgFXNJmBfRYYx9cTSPy1vPhzbGjM
	 2ZBuMxwgM21xW0YwG9WEjkdxySAM2FC/+6i460RysSSEQYlZwvfbC495CJAZMCdwoKaua
	 T6aLYG6bElCKiF8XO+7Ih8p0pShk0VorHPR4Bh0widTRW6JnHorKBNwnErzSFP9ZCRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=nBhp8Ia7;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=PKfcLsqN;
	arc=none smtp.remote-ip=188.121.53.26
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [188.121.53.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9330606C091
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9330606C091
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=nBhp8Ia7;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=PKfcLsqN
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHzoxAFZE; Wed, 11 Nov 2026 23:44:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440694;
	bh=bcj8JClKKOuj2flOo3CRoJC7KiL6mFt0YjclDonLtaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nBhp8Ia7nRZhnCZWMYXqyNkYTC8C9QmA/RWXwtbovkmI9LYg8BVlDy0JX0kwVb5Qh
	 q6YtNK2jWYs6TwuW9uWJ4pHKkSgeYpZ80Nt9eXrzQHYBJb35ERShxVi4bLOwmcdq65
	 gouJujyrbs/rECro8QDmBRoCnpHRMu57p1TBlXaeURru6u4pvwxOHWGTmaMx41kZ89
	 oThQmi5V/QkG8lIuYXdzm1mP5sB8WIHp498gYpJwMxDacb1LdElUwndM1gyPAevWyo
	 +jCY+v+uJjdr0zN2cuhjrbCCaCkWem2WdLoq5A4C4SzpDnSzeC5ez2yNVlieHNolri
	 biZ9vm3XQM4Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440694;
	bh=bcj8JClKKOuj2flOo3CRoJC7KiL6mFt0YjclDonLtaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PKfcLsqN6CGz5wegdkOL+jK+/T7AIXXVrbYMewVBtklhDQXBafftRg5LULMPbL8w0
	 ZNQYgl7EJMEco0liwUk7FTKhOxohT5RbN/DY/HBiN18PbQnpPJqnwu9D6o3SxJx1ad
	 jXpm1/94fwjzc040XbT4dNTqWCKBORC5hoVbLYW0poR8d4jFqjRbFHLV+kC8vuFRdI
	 mFiCb7d1yfak4bVW7btDfxgQCqowufuZsJD8u9e3ApZMMslgMXHBWMowi54ymQ9Nu/
	 7D0pq+2QyV8NkjKLx0Vfix/Wl9IUWpPnmD4c8CdtWFBEeawEcL0z9Qjxf7qrJ5UcVX
	 sg7MQPA9EDHbA==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fdf5
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=TSaEOjpj3gRMpAirYekA:9 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: 40a9fa37b4a7a256ef751829aa5edc86:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 16/22] Squashfs: sanity check block list sizes and range
Date: Wed, 11 Nov 2026 23:43:56 +0000
Message-ID: <20261111234402.252354-17-phillip@squashfs.org.uk>
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
X-CMAE-Envelope: MS4xfOK/0MI2WwK1qXzgeuBUqyap1QPMxbFpan9N4yhcrJXc0/RjAT5+5q+ycSSf+KQjpJPaUp/wxkeWFQIhMAKHP1ERlIAfh36jbomyGmgq337GkKPPu7WJ
 1lWMivqEMR4zmX5oen3n45dt1LAOTw9IVZgGLVeqNLWfefFrUJjMdjHcPNDNBADnfZcMolyoeDZ3KJkvI4svE24SDuTniu7/AIXE7E3h2siXGFJHTiADQmF7
 HO2S09wn5s3uhevFif3dzXkCpblVVa5OKA1ank1dGBmF7HewplQRY3EuWZBLHVssFK1WfmWyH6IA9a/gAPkkQ5C89aCKW72b8pMoEsrptg4=

A Squashfs file has a list of block sizes, storing the compressed size
of each data block.  This block list is scanned to discover the size and
location of block x, where the sizes of previous data blocks are added
to the start of the data blocks to produce the location.

But, when scanning this block list and adding the block sizes, the code
does not check for arithmetic overflow.  This means the data block start
location can be crafted to be close to 2^64, and so the addition of the
block sizes can cause arithmetic overflow and thereby evade any sanity
checks.

Additionally, the range (start and end) of the data block that is to be
read from the filesystem is not checked for correctness before
squasfs_read_data().

This commit adds checks for arithmetic overflow and sanity checks the
range of the data block before attempting to read from disk.

Reproducer
==========

The reproducer generates a Squashfs filesystem with a file with two
data blocks, and then corrupts the location of the start of the data
blocks to 2^64 - 128 KiB.  This added to the size of data block 0 (128
KiB) will overflow, producing a location of 0.  If the exploit succeeds,
when the second block is read, Squashfs will not produce an I/O error
and instead print the Squashfs filesystem superblock starting with hsqs.

====================================================================
#!/bin/bash

ARGS="-quiet -no-progress -noI -noD -no-sparse -no-fragments -comp gzip"

finish() {
	popd 2>&1 > /dev/null
	rm -rf $DIR
	exit 1
}

DIR=$(mktemp -d)

pushd $DIR 2>&1 > /dev/null

echo "Create Squashfs filesystem with one file, with 2 data blocks"
echo "Create a hard link to it, to force Mksquashfs to use an extended inode"
echo "(more than one nlink).  This means the start_block field will"
echo "be 64-bits"

echo "/ d 0777 0 0" > pseudo
echo "zero f 0777 0 0 dd if=/dev/zero bs=1024 count=256 2>/dev/null" >> pseudo
echo "hardlink L zero" >> pseudo

if ! mksquashfs - img.sqsh -pf pseudo $ARGS; then
	echo Failed to create Squashfs filesystem
	finish

fi

echo "Corrupt the start_block field of file zero's inode, which"
echo "points to the start of the file's data blocks."
echo "Alter it to the value 0xFFFFFFFFFFFE0000 (2^64 - 128 KiB)."
echo "That value added to the size of the first data block (128 KiB)"
echo "will overflow"
echo "The inode start_block field is stored at byte offset 262258"

/usr/bin/echo -en "\x00\x00\xfe\xff\xff\xff\xff\xff" > file
dd if=file of=img.sqsh seek=262258 bs=1 count=8 conv=notrunc status=none

echo Mount the filesystem to /mnt

if ! mount -t squashfs img.sqsh /mnt; then
	echo Mount of Squashfs filesystem failed
	finish
fi

echo Read the file zero.
echo If the exploit succeeds, dd will not fail, and it will display the Squashfs
echo superblock, beginning with hsqs
echo

dd if=/mnt/zero bs=1024 skip=128

popd 2>&1> /dev/null

rm -rf $DIR
====================================================================

Fixes: 1701aecb6849c ("Squashfs: regular file operations")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
v2: Ensure sparse blocks at the end of the inode table do not trigger
    new sanity checks.
---
 fs/squashfs/cache.c            |  2 +-
 fs/squashfs/file.c             | 27 +++++++++++++++++++++------
 fs/squashfs/squashfs_helpers.h | 20 +++++++++++++++++---
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/fs/squashfs/cache.c b/fs/squashfs/cache.c
index 4b6ef8838bc6..a81a1d396074 100644
--- a/fs/squashfs/cache.c
+++ b/fs/squashfs/cache.c
@@ -490,7 +490,7 @@ struct squashfs_cache_entry *squashfs_get_fragment(struct super_block *sb,
 				u64 start_block, int length)
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	int res = squashfs_check_range(start_block, length, msblk);
+	int res = squashfs_check_range(start_block, squashfs_frag_size(length, msblk->block_size), msblk);
 
 	if (res < 0)
 		return ERR_PTR(res);
diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index d42832d46885..6ad9fa8ac967 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -281,6 +281,9 @@ static s64 fill_meta_index(struct inode *inode, s64 index,
 			long long res = read_indexes(inode->i_sb, blocks,
 					&cur_index_block, &cur_offset);
 
+			if (res >= 0)
+				res = squashfs_add_indexes(cur_data_block, res, msblk);
+
 			if (res < 0) {
 				if (meta->entries == 0)
 					/*
@@ -292,7 +295,7 @@ static s64 fill_meta_index(struct inode *inode, s64 index,
 				goto failed;
 			}
 
-			cur_data_block += res;
+			cur_data_block = res;
 			meta_entry = &meta->meta_entry[i - meta->offset];
 			meta_entry->index_block = cur_index_block -
 				msblk->inode_table;
@@ -353,8 +356,13 @@ static int read_blocklist_ptrs(struct inode *inode, s64 index, u64 *start,
 		blks = read_indexes(inode->i_sb, index - res, start, offset);
 		if (blks < 0)
 			return (int) blks;
-		if (block)
-			*block += blks;
+		if (block) {
+			res = squashfs_add_indexes(*block, blks, msblk);
+			if (res < 0)
+				return (int) res;
+
+			*block = res;
+		}
 	}
 
 	/*
@@ -492,8 +500,11 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
 
 		if (res == 0)
 			res = squashfs_readpage_sparse(folio, expected);
-		else
-			res = squashfs_readpage_block(folio, block, res, expected);
+		else {
+			res = squashfs_check_range(block, res, msblk);
+			if (res >= 0)
+				res = squashfs_readpage_block(folio, block, res, expected);
+		}
 	} else
 		res = squashfs_readpage_fragment(folio, expected);
 
@@ -629,7 +640,11 @@ static void squashfs_readahead(struct readahead_control *ractl)
 		}
 
 		bsize = read_blocklist(inode, start >> msblk->block_log, &block);
-		if (bsize == 0)
+		if (bsize <= 0)
+			goto skip_pages;
+
+		bsize = squashfs_check_range(block, bsize, msblk);
+		if (bsize < 0)
 			goto skip_pages;
 
 		actor = squashfs_page_actor_init_special(msblk, pages, nr_pages,
diff --git a/fs/squashfs/squashfs_helpers.h b/fs/squashfs/squashfs_helpers.h
index b19b5327d2b4..33e617c62918 100644
--- a/fs/squashfs/squashfs_helpers.h
+++ b/fs/squashfs/squashfs_helpers.h
@@ -241,10 +241,8 @@ static inline int squashfs_frag_size(u32 disk_size, s32 block_size)
 	return size;
 }
 
-static inline int squashfs_check_range(u64 start_block, s32 disk_size, struct squashfs_sb_info *msblk)
+static inline int squashfs_check_range(u64 start_block, s32 size, struct squashfs_sb_info *msblk)
 {
-	int size = squashfs_frag_size(disk_size, msblk->block_size);
-
 	if (size < 0)
 		return size;
 
@@ -260,4 +258,20 @@ static inline int squashfs_check_range(u64 start_block, s32 disk_size, struct sq
 
 	return size;
 }
+
+static inline s64 squashfs_add_indexes(u64 block, s64 blks, struct squashfs_sb_info *msblk)
+{
+
+	if (block > S64_MAX)
+		return -EIO;
+
+	/*
+	 * the above check ensured block is not 2^63 or larger, and so
+	 * this addition will not overflow
+	 */
+	if (block + blks > msblk->inode_table)
+		return -EIO;
+
+	return block + blks;
+}
 #endif
-- 
2.47.3

