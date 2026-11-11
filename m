Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440684;
	b=ZfJtCq23LAOzuRoDTd9U8BDXm/S9Z2za3u86a+zXGM6+cZnp9U4tHe60DpXzITehk/s3
	 CM4F6JxuTewZTfoE1YBci3u1rg9M3r6BHHBJOLdps8bcJ5NsYDHlz/eheiCGvKi++F0bm
	 uTI3ELsIVVdy94AWP2NVArtfVfAeHs9r7OF5/ErynZZEySNRvfnehedtx5EdXDUP6Syvl
	 gsWztOig/snTs6Brw93Zl1Nsc9Z1S+EZbB+tcs+BFbuavi2+uoISulHEfMzlbcCaaaj2m
	 lBeSz7TIk34H6+7AQ+/UK2Li0dsjpSx/rURFxWiXBotG7HWHZn1fxGN5vt6QuqEQgow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440684;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=JSepGz5DKI1NJiNr575qI8bfT6lUZtjmSCack+O4Wdg=;
	b=z/sQhEmgKbV8n5WN6b7iyc7+hHb8sWIiKZQiWjpBztNll+B6mKP8E6SDJcACYyHfLDVR
	 POP9jPcF794gypyhLVgcEbfamy0S3AfmWM1z0o+N14bfBT6YApbkERRTY5C4NPbS/wdaK
	 MTf9apdWWabqsf/2/Sx3rBgDQxTPCh9Em/qHURMQleGqDtK9KcTyuOHOF0CrLvO90wFwG
	 qNrqzC5RLgVy8HMWjX70DMTp8qjDiEfIuxhgstJk+ZsUUqSLtLEzst+37IwvuVVD0bJsa
	 5K0OVPsuOobZsgQ65+ub7t2ZDseYl4Ytt0uHdabsAMkxUD0FE5JGdgY8NTyIIo1Hn5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=poFhXyIB;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=CQsZBuew;
	arc=none smtp.remote-ip=188.121.53.29
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [188.121.53.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5816E606A894
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5816E606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=poFhXyIB;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=CQsZBuew
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHzRxAFXt; Wed, 11 Nov 2026 23:44:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440670;
	bh=JSepGz5DKI1NJiNr575qI8bfT6lUZtjmSCack+O4Wdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=poFhXyIBrvdwo4Z9/TVEufJFy/uXf8cDbqY1lKHTfUSNQqe30ME7KxZCrQheiQIrT
	 pa6sPurTfzcAltdZrEDT/AmJe3OBUr4AAdX2DtzsKYd3nn1eI54C+HVBZX+MP+1q2v
	 MjGohoESKv99zm45WRbGuSAGzZAvHOzXV/94RID1g6KSkuyN89Z/mNGr1c8ma6EVeG
	 utxKwepB74Zi6GBShc4rvysS8U3AZl+/sipNtUb2t5xrC3W3jbB1zRHBFaaWhE7hH7
	 fuw7s5fx5NKt8InoNkH44Sc58HTdjEN44kQoOOd5kCQMFn97yGOOH0ebxbpRfdl3H2
	 0IP6if+CtCj/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440670;
	bh=JSepGz5DKI1NJiNr575qI8bfT6lUZtjmSCack+O4Wdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CQsZBuewCToG6sgxaHPyoSYK7P8ahszNJuSXiXJFwlsm4RurZH6qr1/i4x2egp972
	 eSBk22t6BmEXMm8tgGlge910MB7JKxU8IqxES0a1YFL/Bsg4k+nE+eYu7cpCCUCyvo
	 eJ8lDYWqEMHMlnYNfNyuTG2LONaDNbXOqiRh47SknnILAh8UGBIbDPPkru6OxKyYWu
	 TngdulIJ/YztsDLpRcB2/9e6N15ES5WXQujxbKpZYvhm7xiv9hAKzm6SeCbnYPiYPn
	 ICFHb7Bxag4+ACWdL3WeSSTu2rJkLVgEvIpYslmMqTCr8LtFAW+NMbyy2T8AvLxdON
	 msLb4jLYpyXZA==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fdde
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=1h8doul4msz9IIiYaa0A:9 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: ff45c310a146397a28b539a4c02d6b77:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 03/22] Squashfs: convert SQUASHFS_FRAGMENT_* to inline functions
Date: Wed, 11 Nov 2026 23:43:43 +0000
Message-ID: <20261111234402.252354-4-phillip@squashfs.org.uk>
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
X-CMAE-Envelope: MS4xfAvZ5/RIb6ITomAO6WyoZ+JS8aOjnnNQVfaSoS1YkzTtia0QXCckDmxUzq70YsbYOL6ZsD3ll9w0w9RWT/nYZSEsR3y58RJEIoFmvGNsFtgCXlGdqZ1m
 xYKj98Dz+4Up1xHfcqijDbsSgcjK3vmrYYMB3BlOZ/XYDpkTgzWoKq8m4hGARp0VyshSacHyM6vYttXr0NRuiyuA8Dl+6jKCzi/xuh60Tk6MmJi4n7cw2JdV
 UsiM2APy3f47fAnVAgRa/JUXodsxGq5Om57Pz1UJHOqIeypMYKjU3qiktO69iBu7X0uMaEBRkarl5FZVLuOKCxer63EN08xbypTFTYFgi+4=

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
 fs/squashfs/fragment.c         |  7 ++++---
 fs/squashfs/squashfs_fs.h      | 17 -----------------
 fs/squashfs/squashfs_helpers.h | 27 +++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/fs/squashfs/fragment.c b/fs/squashfs/fragment.c
index 49602b9a42e1..e945d045d55e 100644
--- a/fs/squashfs/fragment.c
+++ b/fs/squashfs/fragment.c
@@ -26,6 +26,7 @@
 
 #include "squashfs_fs.h"
 #include "squashfs_fs_sb.h"
+#include "squashfs_helpers.h"
 #include "squashfs.h"
 
 /*
@@ -42,8 +43,8 @@ int squashfs_frag_lookup(struct super_block *sb, unsigned int fragment,
 
 	if (fragment >= msblk->fragments)
 		return -EIO;
-	block = SQUASHFS_FRAGMENT_INDEX(fragment);
-	offset = SQUASHFS_FRAGMENT_INDEX_OFFSET(fragment);
+	block = squashfs_fragment_index(fragment);
+	offset = squashfs_fragment_index_offset(fragment);
 
 	start_block = le64_to_cpu(msblk->fragment_index[block]);
 
@@ -63,7 +64,7 @@ int squashfs_frag_lookup(struct super_block *sb, unsigned int fragment,
 __le64 *squashfs_read_fragment_index_table(struct super_block *sb,
 	u64 fragment_table_start, u64 next_table, unsigned int fragments)
 {
-	unsigned int length = SQUASHFS_FRAGMENT_INDEX_BYTES(fragments);
+	unsigned int length = squashfs_fragment_index_bytes(fragments);
 	__le64 *table;
 
 	/*
diff --git a/fs/squashfs/squashfs_fs.h b/fs/squashfs/squashfs_fs.h
index 6d993531a5df..3dbd174b5f21 100644
--- a/fs/squashfs/squashfs_fs.h
+++ b/fs/squashfs/squashfs_fs.h
@@ -107,23 +107,6 @@ static inline int squashfs_block_size(__le32 raw)
 	return (size >> 25) ? -EIO : size;
 }
 
-/* fragment and fragment table defines */
-#define SQUASHFS_FRAGMENT_BYTES(A)	\
-				((A) * sizeof(struct squashfs_fragment_entry))
-
-#define SQUASHFS_FRAGMENT_INDEX(A)	(SQUASHFS_FRAGMENT_BYTES(A) / \
-					SQUASHFS_METADATA_SIZE)
-
-#define SQUASHFS_FRAGMENT_INDEX_OFFSET(A)	(SQUASHFS_FRAGMENT_BYTES(A) % \
-						SQUASHFS_METADATA_SIZE)
-
-#define SQUASHFS_FRAGMENT_INDEXES(A)	((SQUASHFS_FRAGMENT_BYTES(A) + \
-					SQUASHFS_METADATA_SIZE - 1) / \
-					SQUASHFS_METADATA_SIZE)
-
-#define SQUASHFS_FRAGMENT_INDEX_BYTES(A)	(SQUASHFS_FRAGMENT_INDEXES(A) *\
-						sizeof(u64))
-
 /* inode lookup table defines */
 #define SQUASHFS_LOOKUP_BYTES(A)	((A) * sizeof(u64))
 
diff --git a/fs/squashfs/squashfs_helpers.h b/fs/squashfs/squashfs_helpers.h
index afef13cd6dc0..b99ca67c729a 100644
--- a/fs/squashfs/squashfs_helpers.h
+++ b/fs/squashfs/squashfs_helpers.h
@@ -51,4 +51,31 @@ static inline s64 squashfs_mkinode(u32 start, u16 offset)
 {
 	return ((s64)start << 16) | offset;
 }
+
+/* fragment and fragment table defines */
+static inline s64 squashfs_fragment_bytes(u32 fragments)
+{
+	return fragments * sizeof(struct squashfs_fragment_entry);
+}
+
+static inline s32 squashfs_fragment_index(u32 fragments)
+{
+	return squashfs_fragment_bytes(fragments) / SQUASHFS_METADATA_SIZE;
+}
+
+static inline s16 squashfs_fragment_index_offset(u32 fragments)
+{
+	return squashfs_fragment_bytes(fragments) % SQUASHFS_METADATA_SIZE;
+}
+
+static inline s32 squashfs_fragment_indexes(u32 fragments)
+{
+	return (squashfs_fragment_bytes(fragments) + (SQUASHFS_METADATA_SIZE - 1)) /
+		SQUASHFS_METADATA_SIZE;
+}
+
+static inline s32 squashfs_fragment_index_bytes(u32 fragments)
+{
+	return squashfs_fragment_indexes(fragments) * sizeof(long long);
+}
 #endif
-- 
2.47.3

