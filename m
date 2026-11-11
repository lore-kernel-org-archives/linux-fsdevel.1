Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.27
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440682;
	b=BO2Yxe4wLo4JKr/3JKyr2xFw1uq9wnwza8CvLxblKcpFA8no1Na7RkuvoZ7uwoN0th5s
	 jej8C0QfoSlkeBV0YsIqZUQs+iASEU7nyEPUnFzVocrs0LLq3H8tXkkoWzwkAu5X/yMCP
	 LRVkTZowVX+3lulNhRTbQKb8HXfKo/6QLzPjvqgAGSGMt4o9HJ/4AhfVKkrc1OqUSRw92
	 zyPxCeVwfMa3DG0TiqFSOFJnWLQoAGxuyyAJe6pymYu63DpLso4Zlg10keRncPG1gFCgX
	 23V0gOFFDy8EmwNLsHtCKcO7qJnFR1EBuf8s+Xc+RBA8Y663v+DfFFS+KmNo3lTJ4Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440682;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=kfZKb+a68PKJvsiWI18aCV6I4EXilYNnOuTBJByb1Mw=;
	b=NEnIjsJkTyRv6BnA6zaZTBebTMq6nBWNpZnY1js/G65L6WCLddfg8AgsJZa6xnQ++ewf
	 9tFyJpnpTd04zEyVjzktKrxGg1z9tggNEXwS9vX/HwDHOzz4Lj4miNjc3ejscicAkyHDm
	 WiLtTqXY9aYboPXr+sn66t5ls0oDE4hNfB5/Z01twd9FIxBaPxomWSWCIrkviGkDSD1hp
	 tv015mTaL1Dyy8QPW9MoQ8XGombxGxcgPxS+ci/yq55hYAJ5x3kGBZfjfm25hzHKyg1s3
	 gK0pLlxLFVhPVSmvpfxN78pnr9RXQY0urjbMmb3SR8A3sLUzbgXDoWH86hiwC/RO7uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=IZhVqtxb;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=QqNTTXTc;
	arc=none smtp.remote-ip=188.121.53.27
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [188.121.53.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1AE606A324
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E1AE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=IZhVqtxb;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=QqNTTXTc
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHzNxAFXd; Wed, 11 Nov 2026 23:44:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440667;
	bh=kfZKb+a68PKJvsiWI18aCV6I4EXilYNnOuTBJByb1Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IZhVqtxbMgSZP+nnZZ37ANfwdJowclRAjYPlueuyCuDug4+D9lZib5ey6GRNHUNJ2
	 VfQ8eZ5dJRhely5eO2nMg6Ac6E6bUilam8BDZt/W2EwlxkSosvYpx+mxZof3Bipug8
	 Jr4TxXdF3lfghB70ylG55qaEGGnNnt+C0cjvcoXaW8t0/O+A5zoXo9hK0lIBZAACj+
	 Rkne7XOzr1gvl7lCy3hlYaBP0FWcbZ+poJ55L2FJY5JNP3oTVhLGP5Tr3rnHMSxCZZ
	 rlX6AoE0OK/mFEIzTC4+tuhIgfsMqbDDT7OgdIMV4mAkW8mBnrWoIaZNDKmrfiwoZx
	 JdEaa4IgFDeqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440667;
	bh=kfZKb+a68PKJvsiWI18aCV6I4EXilYNnOuTBJByb1Mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QqNTTXTchRncgCA1UofQ3cVgoHzlhTrzByGE42kMDui5rtovFz+dlZoHe9/5InskP
	 AteTNx3z7Fq1tP62qEHUp647u0k5Yed/B440KIV1N30cfujic67ElJCkwdc4aMTQRf
	 zfxAG/uP+9OnwedxWE8pXNHQxRDeIb5pvazmT/OIbneHE62rPfnScnvEc1aNvHBHSx
	 NvNNlnyiK7GQgKK69fR7SWHh74fewseU1TJn3a+WiUKrsWANaRDpIk9Z1MBBfDHhOl
	 R/eWcCDvqUnqOsgWjDlHrqBQLumsj1eO0QtpDuaBBMfPT8Si7eBhDZeS33U85I2/ox
	 hT8CNOue3PNXA==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fdda
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=sSupuuxbErciYv1SbbcA:9 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: 1aeb6f86b77ed2bec1d6bda2403537b8:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 01/22] Squashfs: convert SQUASHFS_COMPRESSED_* to inline functions
Date: Wed, 11 Nov 2026 23:43:41 +0000
Message-ID: <20261111234402.252354-2-phillip@squashfs.org.uk>
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
X-CMAE-Envelope: MS4xfDSUifKDI9GWrTm0gi5TY3CkA67Zm7NEgspdkKnvV5ZgJ9kVeHHYwn0wcLNhVWj4mDEsCyQxBzDdFm0beKRCLo8KJrn6l0mQepsENTwkM/1UAr1EFi6l
 kDa4nnIW+caj1i9NbVYYFyAo9248UO9LGWe2Hs09lP7/PoXbLoZIowM4WY8nDCTKTt/ay5sVwwoWYzBm8p0myzQkWj9U0KtqElW3nMNGoVkQ01m/JFN5zdhO
 G2eJCEZLeib5XFaUAKDwJa4He8Nyv1nVwEaw0zBXa9LI0jBDZqyJF3oAZEy6THQ8df8gA7QKKfqcpDtxdXam03gWMqJBwl45XRD432wTgjY=

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
 fs/squashfs/block.c            | 11 ++++++-----
 fs/squashfs/cache.c            |  1 +
 fs/squashfs/file.c             |  3 ++-
 fs/squashfs/squashfs_fs.h      | 17 -----------------
 fs/squashfs/squashfs_helpers.h | 35 ++++++++++++++++++++++++++++++++++
 5 files changed, 44 insertions(+), 23 deletions(-)
 create mode 100644 fs/squashfs/squashfs_helpers.h

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 2d5850168026..20c3030b4f96 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -23,6 +23,7 @@
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
+#include "squashfs_helpers.h"
 #include "squashfs.h"
 #include "decompressor.h"
 #include "page_actor.h"
@@ -292,7 +293,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 {
 	struct squashfs_sb_info *msblk = sb->s_fs_info;
 	struct bio *bio = NULL;
-	int compressed;
+	bool compressed;
 	int res;
 	int offset;
 
@@ -300,8 +301,8 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 		/*
 		 * Datablock.
 		 */
-		compressed = SQUASHFS_COMPRESSED_BLOCK(length);
-		length = SQUASHFS_COMPRESSED_SIZE_BLOCK(length);
+		compressed = squashfs_compressed_block(length);
+		length = squashfs_compressed_size_block(length);
 		TRACE("Block @ 0x%llx, %scompressed size %d, src size %d\n",
 			index, compressed ? "" : "un", length, output->length);
 	} else {
@@ -341,8 +342,8 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 		bio_uninit(bio);
 		kfree(bio);
 
-		compressed = SQUASHFS_COMPRESSED(length);
-		length = SQUASHFS_COMPRESSED_SIZE(length);
+		compressed = squashfs_compressed(length);
+		length = squashfs_compressed_size(length);
 		index += 2;
 
 		TRACE("Block @ 0x%llx, %scompressed size %d\n", index - 2,
diff --git a/fs/squashfs/cache.c b/fs/squashfs/cache.c
index c1a83bb0e519..7cb16414cd23 100644
--- a/fs/squashfs/cache.c
+++ b/fs/squashfs/cache.c
@@ -42,6 +42,7 @@
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
+#include "squashfs_helpers.h"
 #include "squashfs.h"
 #include "page_actor.h"
 
diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index d83594ce91d2..ad6382cd22d3 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -39,6 +39,7 @@
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
 #include "squashfs_fs_i.h"
+#include "squashfs_helpers.h"
 #include "squashfs.h"
 #include "page_actor.h"
 
@@ -188,7 +189,7 @@ static long long read_indexes(struct super_block *sb, int n,
 				err = size;
 				goto failure;
 			}
-			block += SQUASHFS_COMPRESSED_SIZE_BLOCK(size);
+			block += squashfs_compressed_size_block(size);
 		}
 		n -= blocks;
 	}
diff --git a/fs/squashfs/squashfs_fs.h b/fs/squashfs/squashfs_fs.h
index a955d9369749..b406e52a83c2 100644
--- a/fs/squashfs/squashfs_fs.h
+++ b/fs/squashfs/squashfs_fs.h
@@ -101,22 +101,6 @@
 #define SQUASHFS_XATTR_VALUE_OOL        256
 #define SQUASHFS_XATTR_PREFIX_MASK      0xff
 
-/* Flag whether block is compressed or uncompressed, bit is set if block is
- * uncompressed */
-#define SQUASHFS_COMPRESSED_BIT		(1 << 15)
-
-#define SQUASHFS_COMPRESSED_SIZE(B)	(((B) & ~SQUASHFS_COMPRESSED_BIT) ? \
-		(B) & ~SQUASHFS_COMPRESSED_BIT :  SQUASHFS_COMPRESSED_BIT)
-
-#define SQUASHFS_COMPRESSED(B)		(!((B) & SQUASHFS_COMPRESSED_BIT))
-
-#define SQUASHFS_COMPRESSED_BIT_BLOCK	(1 << 24)
-
-#define SQUASHFS_COMPRESSED_SIZE_BLOCK(B)	((B) & \
-						~SQUASHFS_COMPRESSED_BIT_BLOCK)
-
-#define SQUASHFS_COMPRESSED_BLOCK(B)	(!((B) & SQUASHFS_COMPRESSED_BIT_BLOCK))
-
 static inline int squashfs_block_size(__le32 raw)
 {
 	u32 size = le32_to_cpu(raw);
@@ -449,5 +433,4 @@ struct squashfs_xattr_id_table {
 	__le32			xattr_ids;
 	__le32			unused;
 };
-
 #endif
diff --git a/fs/squashfs/squashfs_helpers.h b/fs/squashfs/squashfs_helpers.h
new file mode 100644
index 000000000000..94edc7f46ae4
--- /dev/null
+++ b/fs/squashfs/squashfs_helpers.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SQUASHFS_HELPERS_H
+#define SQUASHFS_HELPERS_H
+/*
+ * Copyright (c) 2026
+ * Phillip Lougher <phillip@squashfs.org.uk>
+ */
+
+/* Flag whether block is compressed or uncompressed, bit is set if block is
+ * uncompressed
+ */
+#define SQUASHFS_COMPRESSED_BIT		(1 << 15)
+
+static inline s16 squashfs_compressed_size(s16 size)
+{
+	return size & ~SQUASHFS_COMPRESSED_BIT;
+}
+
+static inline bool squashfs_compressed(s16 size)
+{
+	return (size & SQUASHFS_COMPRESSED_BIT) == 0;
+}
+
+#define SQUASHFS_COMPRESSED_BIT_BLOCK		(1 << 24)
+
+static inline s32 squashfs_compressed_size_block(s32 size)
+{
+	return size & ~SQUASHFS_COMPRESSED_BIT_BLOCK;
+}
+
+static inline bool squashfs_compressed_block(s32 size)
+{
+	return (size & SQUASHFS_COMPRESSED_BIT_BLOCK) == 0;
+}
+#endif
-- 
2.47.3

