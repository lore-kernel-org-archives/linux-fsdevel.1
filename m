Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.28
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440684;
	b=wYNqFlENafmBleIhZElf01D1adLyugaGHDdiQq9hYjaX+FRT3tkgeLdAGX/KxvqYc3Fg
	 UUCoZ6k5oQiect48ZfNONRK4SWNV06orPFI3svXhy88rJ8WN2v6tGLDHfMVjMVDnbq6Aw
	 dhWA8C7ZkkjUuvb1u3zryrD1OIntabEsOQJRwciTfqYaUmfytjXWUX9kSDoHKW2EGr/ps
	 2HVLEHkiNII+wF1Jg9n+vae9CTnoRNNRbDUG16MSsRYK9newhFvNPhWl+EMPZkHCRsThC
	 WZTLEBUmCaWmB1/OMyTj7CCPXRxeF/s3GuIzfkD9ztMhNFcZg+oFlX5paaQFm9NbSDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440684;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=Nq5w7tqX+Crh0A207ydeLLwQB2c0ADg2faM9Ie5AIOM=;
	b=IP6Ql0YMYHZuIagDCzMF8fZ1CrEp43/Uv/0WjokOPvdJb97UPo49/MFD6uqvjv8e+eD6
	 bVuR3goaFJohzWU4/IiNZ0kIZVuyx+bVQh0FrEXQMPO+CEqqC0eVZ4GNk9dJbW/gVPx3U
	 XqypvT5Q07gRHJHWVf7A6oKjvJ97sYFnxcJa4QMCDKdbcXctTrv8FCvo84biM52/C4/WC
	 FhWCbV8RpvZ21kEGCfaMqH6Sol/pm0c5HYUqnjbqOji1beaAuCQar7Xk5zguR8VasOizb
	 Hk0dDEhzUP6mFoSEYCqkK55Qs8KFCGs6ACeU0qNMRlK2/julVc79HlSm9GV2Nv/pteA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=O7TvMs3W;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=X8j3Z8E6;
	arc=none smtp.remote-ip=188.121.53.28
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [188.121.53.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE68606A88D
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAE68606A88D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=O7TvMs3W;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=X8j3Z8E6
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHzWxAFY7; Wed, 11 Nov 2026 23:44:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440676;
	bh=Nq5w7tqX+Crh0A207ydeLLwQB2c0ADg2faM9Ie5AIOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O7TvMs3WEzyFEGALIWvUBPeXNyoEYLNtGbjO77xVURdiFZrFBpq4aFABo18Z9k2i5
	 xi734Y3gbdMKa4XlmurfiGYdA2E4WUXnaLtiw0+c2IyZD5331zO9r4IhROvEcFL7nk
	 kH6ny3URALdfkN51hhBVnJmqD42Ceg9ljeBU2a58zJ6QcFjq7L9bQ0FR71pe1IH2Y5
	 GpFmPM2PyxpCON5dzw7MJLlPV/eH9RlW4X3u8rw063k5wbzmn7ExhNNWBM4Z7r1VHO
	 RKzc9n1XHPfjLidwTf/lmb9M1rL6XFBYJuKeKKNh86tnfqVKtCZTPgmnZ1D3zSJM/g
	 IZ6ozMk+fkrXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440676;
	bh=Nq5w7tqX+Crh0A207ydeLLwQB2c0ADg2faM9Ie5AIOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X8j3Z8E6ks5nFSIr0YoxfxOibcdwuqbUSSzm+I0SU6PZoPtvktXqFENXTQTWz5kHX
	 5rrY6dqVwqs2GrSI3OqInhSUJoq4TVbR3y2jfUMCFGCHAGq0ZiV0YhkBmSCTATgKlQ
	 5traPCNErTs7rv5uDwYoQSWapzfaqT2vPV8VJvpLBlRhs0oNkPIWbK6K28CAesS+x0
	 k8YoN0unmNcnwMrRlCEiM5ILKpNwWbY3eMNF3aXVkZukBslGiNGm6dnLUNB9tkJSPY
	 axZQjxDV3q1oB4BmzAU/xzQvItaACD9mHPlb9kbDMF2kopABekRu6EIrlTgvtc6E7V
	 PqaayRvs0z96w==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fde3
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=dA03S5-tUKIFcmplmssA:9 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: 1eeff0661fb0714758344348f282690a:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 06/22] Squashfs: convert SQUASHFS_XATTR_* to inline functions
Date: Wed, 11 Nov 2026 23:43:46 +0000
Message-ID: <20261111234402.252354-7-phillip@squashfs.org.uk>
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
X-CMAE-Envelope: MS4xfGHxkB5YfBGmDKoXfHMGnj7s+rLCplpDX6NFJWAp37lWdO3LP5aJlByS1GIrCL7dyfHRptH5zGeZn7nqzryCjqZ9WuzkJzwjXy1zTKAGXk/nx9I4kMEj
 kfw8N/zS/pxLSG6zWNJW1eD21rO7tCu06zkaqQCQzLi+bnFFpsa2SHvJg5GtI0Hn+XRGu0yAsq5drqsroSHrYFvgcITGoLPXLljFm0Ht0TazXBrw8p5di7ir
 LAzrXA5AjEIURxDxYW1LMtOOFHvc6lrNt0XnLgnYUTNwuaTNIvtxr+hdVTfhplks49EpEw8dtqXoc8hSjNqhtaSHSXOygJR13jRojQcUW0s=

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
 fs/squashfs/squashfs_fs.h      | 19 -----------------
 fs/squashfs/squashfs_helpers.h | 37 ++++++++++++++++++++++++++++++++++
 fs/squashfs/xattr.c            | 18 ++++++++---------
 fs/squashfs/xattr_id.c         |  9 +++++----
 4 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/fs/squashfs/squashfs_fs.h b/fs/squashfs/squashfs_fs.h
index 25dd89a2c6ad..3e7d0730b2d9 100644
--- a/fs/squashfs/squashfs_fs.h
+++ b/fs/squashfs/squashfs_fs.h
@@ -107,25 +107,6 @@ static inline int squashfs_block_size(__le32 raw)
 	return (size >> 25) ? -EIO : size;
 }
 
-/* xattr id lookup table defines */
-#define SQUASHFS_XATTR_BYTES(A)		(((u64) (A)) * sizeof(struct squashfs_xattr_id))
-
-#define SQUASHFS_XATTR_BLOCK(A)		(SQUASHFS_XATTR_BYTES(A) / \
-					SQUASHFS_METADATA_SIZE)
-
-#define SQUASHFS_XATTR_BLOCK_OFFSET(A)	(SQUASHFS_XATTR_BYTES(A) % \
-					SQUASHFS_METADATA_SIZE)
-
-#define SQUASHFS_XATTR_BLOCKS(A)	((SQUASHFS_XATTR_BYTES(A) + \
-					SQUASHFS_METADATA_SIZE - 1) / \
-					SQUASHFS_METADATA_SIZE)
-
-#define SQUASHFS_XATTR_BLOCK_BYTES(A)	(SQUASHFS_XATTR_BLOCKS(A) *\
-					sizeof(u64))
-#define SQUASHFS_XATTR_BLK(A)		((unsigned int) ((A) >> 16))
-
-#define SQUASHFS_XATTR_OFFSET(A)	((unsigned int) ((A) & 0xffff))
-
 /* cached data constants for filesystem */
 #define SQUASHFS_CACHED_BLKS		8
 
diff --git a/fs/squashfs/squashfs_helpers.h b/fs/squashfs/squashfs_helpers.h
index b9c517a50642..4088e598400f 100644
--- a/fs/squashfs/squashfs_helpers.h
+++ b/fs/squashfs/squashfs_helpers.h
@@ -132,4 +132,41 @@ static inline s16 squashfs_id_block_bytes(u16 ids)
 {
 	return squashfs_id_blocks(ids) * sizeof(long long);
 }
+
+/* xattr id lookup table defines */
+static inline s64 squashfs_xattr_bytes(u32 xattrs)
+{
+	return (s64) xattrs * sizeof(struct squashfs_xattr_id);
+}
+
+static inline s32 squashfs_xattr_block(u32 xattrs)
+{
+	return squashfs_xattr_bytes(xattrs) / SQUASHFS_METADATA_SIZE;
+}
+
+static inline s16 squashfs_xattr_block_offset(u32 xattrs)
+{
+	return squashfs_xattr_bytes(xattrs) % SQUASHFS_METADATA_SIZE;
+}
+
+static inline s32 squashfs_xattr_blocks(u32 xattrs)
+{
+	return (squashfs_xattr_bytes(xattrs) + SQUASHFS_METADATA_SIZE - 1) /
+		SQUASHFS_METADATA_SIZE;
+}
+
+static inline s32 squashfs_xattr_block_bytes(u32 xattrs)
+{
+	return squashfs_xattr_blocks(xattrs) * sizeof(long long);
+}
+
+static inline u32 squashfs_xattr_blk(s64 xattr)
+{
+	return xattr >> 16;
+}
+
+static inline s16 squashfs_xattr_offset(s64 xattr)
+{
+	return xattr & 0xffff;
+}
 #endif
diff --git a/fs/squashfs/xattr.c b/fs/squashfs/xattr.c
index ce6608cabd49..f9ef669544f8 100644
--- a/fs/squashfs/xattr.c
+++ b/fs/squashfs/xattr.c
@@ -19,6 +19,7 @@
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
 #include "squashfs_fs_i.h"
+#include "squashfs_helpers.h"
 #include "squashfs.h"
 
 static const struct xattr_handler *squashfs_xattr_handler(int);
@@ -29,9 +30,9 @@ ssize_t squashfs_listxattr(struct dentry *d, char *buffer,
 	struct inode *inode = d_inode(d);
 	struct super_block *sb = inode->i_sb;
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	u64 start = SQUASHFS_XATTR_BLK(squashfs_i(inode)->xattr)
-						 + msblk->xattr_table;
-	int offset = SQUASHFS_XATTR_OFFSET(squashfs_i(inode)->xattr);
+	u64 start = squashfs_xattr_blk(squashfs_i(inode)->xattr)
+						+ msblk->xattr_table;
+	int offset = squashfs_xattr_offset(squashfs_i(inode)->xattr);
 	int count = squashfs_i(inode)->xattr_count;
 	size_t rest = buffer_size;
 	int err;
@@ -107,14 +108,13 @@ static int squashfs_xattr_get(struct inode *inode, int name_index,
 {
 	struct super_block *sb = inode->i_sb;
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	u64 start = SQUASHFS_XATTR_BLK(squashfs_i(inode)->xattr)
-						 + msblk->xattr_table;
-	int offset = SQUASHFS_XATTR_OFFSET(squashfs_i(inode)->xattr);
+	u64 start = squashfs_xattr_blk(squashfs_i(inode)->xattr)
+						+ msblk->xattr_table;
+	int offset = squashfs_xattr_offset(squashfs_i(inode)->xattr);
 	int count = squashfs_i(inode)->xattr_count;
 	int name_len = strlen(name);
 	int err, vsize;
 	char *target = kmalloc(name_len, GFP_KERNEL);
-
 	if (target == NULL)
 		return  -ENOMEM;
 
@@ -158,9 +158,9 @@ static int squashfs_xattr_get(struct inode *inode, int name_index,
 				if (err < 0)
 					goto failed;
 				xattr = le64_to_cpu(xattr_val);
-				start = SQUASHFS_XATTR_BLK(xattr) +
+				start = squashfs_xattr_blk(xattr) +
 							msblk->xattr_table;
-				offset = SQUASHFS_XATTR_OFFSET(xattr);
+				offset = squashfs_xattr_offset(xattr);
 			}
 			/* read xattr value */
 			err = squashfs_read_metadata(sb, &val, &start, &offset,
diff --git a/fs/squashfs/xattr_id.c b/fs/squashfs/xattr_id.c
index c8469c656e0d..ff85247e2d80 100644
--- a/fs/squashfs/xattr_id.c
+++ b/fs/squashfs/xattr_id.c
@@ -19,6 +19,7 @@
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
+#include "squashfs_helpers.h"
 #include "squashfs.h"
 #include "xattr.h"
 
@@ -29,8 +30,8 @@ int squashfs_xattr_lookup(struct super_block *sb, unsigned int index,
 		int *count, unsigned int *size, unsigned long long *xattr)
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
-	int block = SQUASHFS_XATTR_BLOCK(index);
-	int offset = SQUASHFS_XATTR_BLOCK_OFFSET(index);
+	int block = squashfs_xattr_block(index);
+	int offset = squashfs_xattr_block_offset(index);
 	u64 start_block;
 	struct squashfs_xattr_id id;
 	int err;
@@ -79,8 +80,8 @@ __le64 *squashfs_read_xattr_id_table(struct super_block *sb, u64 table_start,
 	if (*xattr_ids == 0)
 		return ERR_PTR(-EINVAL);
 
-	len = SQUASHFS_XATTR_BLOCK_BYTES(*xattr_ids);
-	indexes = SQUASHFS_XATTR_BLOCKS(*xattr_ids);
+	len = squashfs_xattr_block_bytes(*xattr_ids);
+	indexes = squashfs_xattr_blocks(*xattr_ids);
 
 	/*
 	 * The computed size of the index table (len bytes) should exactly
-- 
2.47.3

