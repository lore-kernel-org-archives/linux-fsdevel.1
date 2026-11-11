Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440686;
	b=Y7nps63RBO8naC6PiNASjQLlPsnisolpwwT8IlKyCN8/XdqJg+2+08vgqJaIc+4UnQ2Y
	 Wq4lX3/fgkOcBbR4ON7dbAp4ztRMRiG9RxDtNtbtipybh012JyEQo6tx4C3ON6BvinEA3
	 /xEcko+zju2wal+mJIt5apbqjy8DUvrH2M4f2zq747p8pFBlN+k1Yi6ybiSQr8F04ORYP
	 NSerlQZeqO9kBMJHcfxT7t7lq/U8WuSpARp/tbzzNkN9qDF5DsXjmtFtwiSy0leQtsdqr
	 TQJ5Atqy4b0KcvwA86r+yGUhVlUmNqc+CtfFAZQQZAf8CON6wm4ZQJTlxe1vhg6Slcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440686;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=9wlDNnuCvBStgBEGoigiOA7iJ7WaSzOQIuxUEhH7lXI=;
	b=jXCG9AxRCMBTvaoRZluO4odpoXiTpY2J3fY1EbhWKjLDDcnx4d1oRLiUeo8AyYXFJ9Fo
	 8KcQ1AQnB+E0DZyUuXtxekBt83KiMyCKhvYcBshsVZA781oLPeVRf9sps9oHZds0ys8yo
	 0GITxExJs0xIEQ1F4C91CAd65ZDv9PF3OoGvFSxeBURm79PxDVCHAQZcbe0xmVGRguZ5B
	 69+asp2bM6d2wuf+yNDay6kUrevoh9TJMjLdzreSxZegA+k3RDZ7sgLoCwEw4WTo6McbQ
	 Q68Nakml44JreHgx0Nm8ivbGxtWmRAe/c5peZLZOpT9ialMai3Lm81DMk7PvOO30tWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=sF6AmplW;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=mwpMMRL0;
	arc=none smtp.remote-ip=188.121.53.29
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [188.121.53.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F22D60A2604
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F22D60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=sF6AmplW;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=mwpMMRL0
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHzYxAFYD; Wed, 11 Nov 2026 23:44:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440677;
	bh=9wlDNnuCvBStgBEGoigiOA7iJ7WaSzOQIuxUEhH7lXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=sF6AmplWgYw0WMR+XgnkuGuetPIjPLDgipccZneuT0H7aG2OoBrR+o1r8aw4SQjwH
	 sBhpIK5OOUdE6CHCmKeGt8M8ur+D5U9q+7tglm+QsLu1a5MTrpbjVzHMcSR/nWm5Aj
	 qOW62XFe4fNNa4v0BxQctWWEeY+2WG1VezZd2a9g4X2KtojRwI0fjhdPVVozTxt2wJ
	 0SPkN0JJxKPIpcEMAxISH47vIH5/k3/igR9eoqI1G4KItp7bdqGtvvzBDa4iCpQK09
	 UiGa9934TLB21YGiqcor9R9jcUuu64RCtZ/crjR4Qpmpvy/fHy3zyjwrm7KeW2WWQP
	 skQPuNpQ1bRVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440677;
	bh=9wlDNnuCvBStgBEGoigiOA7iJ7WaSzOQIuxUEhH7lXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mwpMMRL0JyZ/DyUhccaYen/sQUU8YmdiVnAzW2kHcTRzRA240LKBKPPV7gmAyJ9wY
	 R872qK47Jd7wfpsE609kQiTy6xmTLHN9OY3GENvSOXcZrWAzIff2Fuf79SuWmdWlCL
	 BOyRzkBQN0+vUSQJ8fMtpFdUbAz29hTHUbs7UfrAdXeyBY8btt10iYJMocf5DBXrQG
	 v6hc4SsfT6zdmRNQmZFtylaybKXyY4ZeGtQOG0439c6kOb+S3t4VfgBdv3/HqpbrSn
	 ZfqqknK7QKsHYvQTv3Dc2bg5ZYgpSSDuyOw+hhbAz3+tvfr4I94DlTIXfiIsVyMEEG
	 mDMkOHn4ZRKOg==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fde5
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=UIc8XRgxpZH_YXcB3xwA:9 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: c143c834ea9736d6768728c32c1457a6:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 07/22] Squashfs: fix offset in squashfs_read_inode() TRACE statements
Date: Wed, 11 Nov 2026 23:43:47 +0000
Message-ID: <20261111234402.252354-8-phillip@squashfs.org.uk>
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
X-CMAE-Envelope: MS4xfOynBZjBMFrVYbSLwNKRv/T50sAbbFZmjm2dM63ZxnCxf+1bW86KJdhurRhE+4yJkaoct12LZ+MwEJbiRGz+S0yL8xlp525yNXlnKAGYpOfHFOgQ80YQ
 v9lbPaVN7geg9Pn9XJIeTfLm5Lwv5eiD3+Wg7+HJ+PKRa7bk+kZb7Ql7FSIRTKwDJGPbJv7XDaRxZF3eF8UgDnEEUDW2uyiCgIkIZtI0k0aJm3AZFq0LTkGi
 HlLxW0j6OPvSqnvj/UEZ9Qc+omgQuzbedO8oAMypeTo5y8q+2MFiB6tQVN+1gnexzYYmXF2FJOLW8jXHzCTmq4f3gIRP+w+nk9C1RCR8n+k=

The offset used in the TRACE statements has been advanced past the start
of the inode header by the squashfs_read_metadata() call.  This means
the offset printed is incorrect.

Fix this by using the original offset, which is obtained by calling
squashfs_inode_offset(ino).

Fixes: 6545b246a2c81 ("Squashfs: inode operations")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/inode.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index bc7c81d442f2..66858fabed1a 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -184,7 +184,8 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 
 		TRACE("File inode %x:%x, start_block %llx, block_list_start "
 			"%llx, offset %x\n", squashfs_inode_blk(ino),
-			offset, squashfs_i(inode)->start, block, offset);
+			squashfs_inode_offset(ino),
+			squashfs_i(inode)->start, block, offset);
 		break;
 	}
 	case SQUASHFS_LREG_TYPE: {
@@ -244,7 +245,8 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 
 		TRACE("File inode %x:%x, start_block %llx, block_list_start "
 			"%llx, offset %x\n", squashfs_inode_blk(ino),
-			offset, squashfs_i(inode)->start, block, offset);
+			squashfs_inode_offset(ino), squashfs_i(inode)->start,
+			block, offset);
 		break;
 	}
 	case SQUASHFS_DIR_TYPE: {
@@ -266,7 +268,8 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		squashfs_i(inode)->parent = le32_to_cpu(sqsh_ino->parent_inode);
 
 		TRACE("Directory inode %x:%x, start_block %llx, offset %x\n",
-				squashfs_inode_blk(ino), offset,
+				squashfs_inode_blk(ino),
+				squashfs_inode_offset(ino),
 				squashfs_i(inode)->start,
 				le16_to_cpu(sqsh_ino->offset));
 		break;
@@ -293,7 +296,8 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		squashfs_i(inode)->parent = le32_to_cpu(sqsh_ino->parent_inode);
 
 		TRACE("Long directory inode %x:%x, start_block %llx, offset "
-				"%x\n", squashfs_inode_blk(ino), offset,
+				"%x\n", squashfs_inode_blk(ino),
+				squashfs_inode_offset(ino),
 				squashfs_i(inode)->start,
 				le16_to_cpu(sqsh_ino->offset));
 		break;
@@ -337,8 +341,8 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		}
 
 		TRACE("Symbolic link inode %x:%x, start_block %llx, offset "
-				"%x\n", squashfs_inode_blk(ino), offset,
-				block, offset);
+				"%x\n", squashfs_inode_blk(ino),
+				squashfs_inode_offset(ino), block, offset);
 		break;
 	}
 	case SQUASHFS_BLKDEV_TYPE:
@@ -361,7 +365,8 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		squashfs_i(inode)->parent = 0;
 
 		TRACE("Device inode %x:%x, rdev %x\n",
-				squashfs_inode_blk(ino), offset, rdev);
+				squashfs_inode_blk(ino),
+				squashfs_inode_offset(ino), rdev);
 		break;
 	}
 	case SQUASHFS_LBLKDEV_TYPE:
@@ -386,7 +391,8 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		squashfs_i(inode)->parent = 0;
 
 		TRACE("Device inode %x:%x, rdev %x\n",
-				squashfs_inode_blk(ino), offset, rdev);
+				squashfs_inode_blk(ino),
+				squashfs_inode_offset(ino), rdev);
 		break;
 	}
 	case SQUASHFS_FIFO_TYPE:
-- 
2.47.3

