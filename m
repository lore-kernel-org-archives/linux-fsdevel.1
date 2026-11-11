Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440683;
	b=0QjAGT9mhGsyllTRNBX1q3CdAzFJ+RljHC/+SAi2AUpXfosyEiDyKeQefQnEvnbrr/PV
	 qDt1ehAAzDpPZDAq5nzINOpShN1ERHcSfywK/CCoGOK7WIXVBIXj3NZKoTJ9meMrC4l/2
	 1tTateR17Ks3h71BqeE3Jm/NthBaDUyQDy/ko5WXIf56vV07ConsUK4rraUkIl5O4AiTm
	 6VXfLX8zGHSqMubf1ERk1D244xqvNjs8aqGEojJsbal9wArjixUHKZ7b+vwKheZtngZ2r
	 viqq4/vxJym9B+XDUm0BOw4da0tXTDLSwiGESCLPs7BagG8usFK7PkUAEW4yQuexJPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440683;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=OSSnWYxofcAIw2Celhl2lPdZe1FE66E9R2PrIMJ0ANc=;
	b=qjl1EX7M9eGmE754uYA4mFBcZsUuVLxzdETZvblFU5LuNkp0mgbIYAK73f21CoeGCeRf
	 AAXYjM9Y/KryAvbT/na1eYVUTqpDtIpoksJwuGRSX84AN1iG0hDCzyMwuC2CHwedenitn
	 mMk6TVGYkf8Sqqn33BdZld3IsSAN6nRypM6SbPPadYjFEDLKEKsA4MGLGdm60hpaJc0Gu
	 HSvIWY/TVrBC747ykfgHAAqaRwiTM+iGsLJKw5XRI4CrtFeyqvxCOQIxgGoJqZimjEFB2
	 Tvpt/UumPNtabd7Ba23tRyKPdmHkgIx5cUnOet3xGjPz5VbXgOBRlrgDkhGxu3ssz/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=Uti8sIsY;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=SgeXr3FI;
	arc=none smtp.remote-ip=188.121.53.23
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [188.121.53.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2D6606A881
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F2D6606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=Uti8sIsY;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=SgeXr3FI
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHzPxAFXn; Wed, 11 Nov 2026 23:44:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440669;
	bh=OSSnWYxofcAIw2Celhl2lPdZe1FE66E9R2PrIMJ0ANc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uti8sIsYYl+VZcpRKxQdsUwPci1bakbwj8A9+xdeXpVMMxqRxqkZEntZy/xZF0XLU
	 DUJ+B23xZJqFd/k+Acb6v0x+TYTk/CNlFvUf9JvPW9dB3Bz+66+05WMVu42RIxqZxE
	 Cvyj/zKDec7If6VFBzu5NO7R887mzM4jq3wOe5Ify84LQiswqgoYHIMiis7xb7gYuw
	 TC5slUlMG/8t0KQNw3eCrcqxMmxW+/zeQV6N5pFKgaDOPXQfSlLHtzQVYe0UmC/Oms
	 n7j9baF/Wom/iqlQqYu65aFa8U4bL3TTR951x9JXuHRwGWrLxjxe8lutRcprTirgil
	 NjjMoVJvnULzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440669;
	bh=OSSnWYxofcAIw2Celhl2lPdZe1FE66E9R2PrIMJ0ANc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SgeXr3FIYJjpZavzpeLONCIn7oE1aYM8kMUqWyXU7FKB4LZ/UpSp9KRlV6opPiJVS
	 AS/K2+AjaqHoxhVhJ+0UEAzYWY2YyUAYU133tD+L17CI6LOOBPhzWA+ZTUpYa3ZcSi
	 ydGWj5BAGDWhIzjE0enoJ0sfr9kJ4Yn0RSHPasrarqB5Xq5mc9Dn6WYiUEj0sQaAjF
	 pgAI8LCdmDYj989ZYD9SNkFMBYXgMJxbkCd+pzqhctb7RnubSPKVzydu+2/ubEfqq4
	 ePKT4+2TkRJ0Ug2IJ0wAxNdgIqy0oFzh6kam66kHuc6nQxxiwxemXKjgi/vESQhmt7
	 vp9/HyBsC5u1Q==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fddc
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=blB7sX4d8Brpto9GhyAA:9 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: 0ef4e234354bf02aa63f4592e9fb1d64:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 02/22] Squashfs: convert SQUASHFS_INODE_* and SQUASHFS_MKINODE to inline functions
Date: Wed, 11 Nov 2026 23:43:42 +0000
Message-ID: <20261111234402.252354-3-phillip@squashfs.org.uk>
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
X-CMAE-Envelope: MS4xfK70F58VTSePpeIeHFfUJMh48GLR7fQqwMDSaR0BDXAyQfC4GhF+3GZwJQqVQfBklzpGIKhP1JlwhOxOawbqNjdc5rdcXfIVSHdV2Bx5syEWXOmqj062
 AlCXDYBJGJH7aVZ+BhNLbuSBArS9ETQC6D2CtLesr5voy8KcEj8V6XNlcvmIwZbAhFgmqj9yUuGznB2UIjKvRTOx7zc096ucmDRQ5LSRx/69SpRaj0KwRHV5
 Uaz0gslrs2jpDV2imclx5YKmaVsbuYNSF63bFTCI5KVvKyjspHVBobJAjCNYgxwzbLlLUtk6U9dVTk/T0sEv6pPPLlh7qgZO0AXIZLDSJbM=

Convert old fashioned #define macros into inline functions.  This has
the following improvements:

1. Inline functions are typed, which makes the width and sigedness of
   input and outputs explicit, which reduces errors.

2. The inline functions enable more sanity checking to be added in
   later commits.

3. Inline functions are easier to read than #define macros, which
   improves code comprehension.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
v2: Remove squashfs_inode_offset() additions to TRACE statements.
    This is now a separate patch.
--- 
 fs/squashfs/inode.c            | 24 +++++++++++++-----------
 fs/squashfs/namei.c            |  3 ++-
 fs/squashfs/squashfs_fs.h      | 11 -----------
 fs/squashfs/squashfs_helpers.h | 19 +++++++++++++++++++
 fs/squashfs/super.c            |  3 ++-
 5 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index 82b687414e65..bc7c81d442f2 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -33,6 +33,7 @@
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
 #include "squashfs_fs_i.h"
+#include "squashfs_helpers.h"
 #include "squashfs.h"
 #include "xattr.h"
 
@@ -108,8 +109,9 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 {
 	struct super_block *sb = inode->i_sb;
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	u64 block = SQUASHFS_INODE_BLK(ino) + msblk->inode_table;
-	int err, type, offset = SQUASHFS_INODE_OFFSET(ino);
+	u64 block = squashfs_inode_blk(ino) + msblk->inode_table;
+	int offset = squashfs_inode_offset(ino);
+	int err, type;
 	union squashfs_inode squashfs_ino;
 	struct squashfs_base_inode *sqshb_ino = &squashfs_ino.base;
 	int xattr_id = SQUASHFS_INVALID_XATTR;
@@ -128,8 +130,8 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 	if (err)
 		goto failed_read;
 
-	block = SQUASHFS_INODE_BLK(ino) + msblk->inode_table;
-	offset = SQUASHFS_INODE_OFFSET(ino);
+	block = squashfs_inode_blk(ino) + msblk->inode_table;
+	offset = squashfs_inode_offset(ino);
 
 	type = le16_to_cpu(sqshb_ino->inode_type);
 	switch (type) {
@@ -181,7 +183,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		inode->i_data.a_ops = &squashfs_aops;
 
 		TRACE("File inode %x:%x, start_block %llx, block_list_start "
-			"%llx, offset %x\n", SQUASHFS_INODE_BLK(ino),
+			"%llx, offset %x\n", squashfs_inode_blk(ino),
 			offset, squashfs_i(inode)->start, block, offset);
 		break;
 	}
@@ -241,7 +243,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		inode->i_data.a_ops = &squashfs_aops;
 
 		TRACE("File inode %x:%x, start_block %llx, block_list_start "
-			"%llx, offset %x\n", SQUASHFS_INODE_BLK(ino),
+			"%llx, offset %x\n", squashfs_inode_blk(ino),
 			offset, squashfs_i(inode)->start, block, offset);
 		break;
 	}
@@ -264,7 +266,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		squashfs_i(inode)->parent = le32_to_cpu(sqsh_ino->parent_inode);
 
 		TRACE("Directory inode %x:%x, start_block %llx, offset %x\n",
-				SQUASHFS_INODE_BLK(ino), offset,
+				squashfs_inode_blk(ino), offset,
 				squashfs_i(inode)->start,
 				le16_to_cpu(sqsh_ino->offset));
 		break;
@@ -291,7 +293,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		squashfs_i(inode)->parent = le32_to_cpu(sqsh_ino->parent_inode);
 
 		TRACE("Long directory inode %x:%x, start_block %llx, offset "
-				"%x\n", SQUASHFS_INODE_BLK(ino), offset,
+				"%x\n", squashfs_inode_blk(ino), offset,
 				squashfs_i(inode)->start,
 				le16_to_cpu(sqsh_ino->offset));
 		break;
@@ -335,7 +337,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		}
 
 		TRACE("Symbolic link inode %x:%x, start_block %llx, offset "
-				"%x\n", SQUASHFS_INODE_BLK(ino), offset,
+				"%x\n", squashfs_inode_blk(ino), offset,
 				block, offset);
 		break;
 	}
@@ -359,7 +361,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		squashfs_i(inode)->parent = 0;
 
 		TRACE("Device inode %x:%x, rdev %x\n",
-				SQUASHFS_INODE_BLK(ino), offset, rdev);
+				squashfs_inode_blk(ino), offset, rdev);
 		break;
 	}
 	case SQUASHFS_LBLKDEV_TYPE:
@@ -384,7 +386,7 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		squashfs_i(inode)->parent = 0;
 
 		TRACE("Device inode %x:%x, rdev %x\n",
-				SQUASHFS_INODE_BLK(ino), offset, rdev);
+				squashfs_inode_blk(ino), offset, rdev);
 		break;
 	}
 	case SQUASHFS_FIFO_TYPE:
diff --git a/fs/squashfs/namei.c b/fs/squashfs/namei.c
index 65aae7e2a859..2260a3f05fde 100644
--- a/fs/squashfs/namei.c
+++ b/fs/squashfs/namei.c
@@ -49,6 +49,7 @@
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
 #include "squashfs_fs_i.h"
+#include "squashfs_helpers.h"
 #include "squashfs.h"
 #include "xattr.h"
 
@@ -197,7 +198,7 @@ static struct dentry *squashfs_lookup(struct inode *dir, struct dentry *dentry,
 				off = le16_to_cpu(dire->offset);
 				ino_num = le32_to_cpu(dirh.inode_number) +
 					(short) le16_to_cpu(dire->inode_number);
-				ino = SQUASHFS_MKINODE(blk, off);
+				ino = squashfs_mkinode(blk, off);
 
 				TRACE("calling squashfs_iget for directory "
 					"entry %s, inode  %x:%x, %d\n", name,
diff --git a/fs/squashfs/squashfs_fs.h b/fs/squashfs/squashfs_fs.h
index b406e52a83c2..6d993531a5df 100644
--- a/fs/squashfs/squashfs_fs.h
+++ b/fs/squashfs/squashfs_fs.h
@@ -107,17 +107,6 @@ static inline int squashfs_block_size(__le32 raw)
 	return (size >> 25) ? -EIO : size;
 }
 
-/*
- * Inode number ops.  Inodes consist of a compressed block number, and an
- * uncompressed offset within that block
- */
-#define SQUASHFS_INODE_BLK(A)		((unsigned int) ((A) >> 16))
-
-#define SQUASHFS_INODE_OFFSET(A)	((unsigned int) ((A) & 0xffff))
-
-#define SQUASHFS_MKINODE(A, B)		((long long)(((long long) (A)\
-					<< 16) + (B)))
-
 /* fragment and fragment table defines */
 #define SQUASHFS_FRAGMENT_BYTES(A)	\
 				((A) * sizeof(struct squashfs_fragment_entry))
diff --git a/fs/squashfs/squashfs_helpers.h b/fs/squashfs/squashfs_helpers.h
index 94edc7f46ae4..afef13cd6dc0 100644
--- a/fs/squashfs/squashfs_helpers.h
+++ b/fs/squashfs/squashfs_helpers.h
@@ -32,4 +32,23 @@ static inline bool squashfs_compressed_block(s32 size)
 {
 	return (size & SQUASHFS_COMPRESSED_BIT_BLOCK) == 0;
 }
+
+/*
+ * Inode number ops.  Inodes consist of a compressed block number, and an
+ * uncompressed  offset within that block
+ */
+static inline u32 squashfs_inode_blk(s64 inode)
+{
+	return inode >> 16;
+}
+
+static inline u16 squashfs_inode_offset(s64 inode)
+{
+	return inode & 0xffff;
+}
+
+static inline s64 squashfs_mkinode(u32 start, u16 offset)
+{
+	return ((s64)start << 16) | offset;
+}
 #endif
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 5dabc5770f1b..0e511dd29d58 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -33,6 +33,7 @@
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
 #include "squashfs_fs_i.h"
+#include "squashfs_helpers.h"
 #include "squashfs.h"
 #include "decompressor.h"
 #include "xattr.h"
@@ -286,7 +287,7 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	/* Check the root inode for sanity */
 	root_inode = le64_to_cpu(sblk->root_inode);
-	if (SQUASHFS_INODE_OFFSET(root_inode) > SQUASHFS_METADATA_SIZE)
+	if (squashfs_inode_offset(root_inode) > SQUASHFS_METADATA_SIZE)
 		goto insanity;
 
 	msblk->inode_table = le64_to_cpu(sblk->inode_table_start);
-- 
2.47.3

