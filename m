Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98CC1A6830
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 01:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780189388; cv=none; b=hsVQDfKgRF8Ne79Y92XzUkJztZo6D/mTiuByMt85zPiiNZUPGgiNKyH/vVQhbUd3lAyGN3e9Lq8lyFnniIyntrx96tc6mR0Qq+OgrIAWrtyWqzfgcVo90n/jPFTHI6pcAwvgO/4jzr3knmja9c1pgm1ufp9UurRX2PSGNB20TDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780189388; c=relaxed/simple;
	bh=APiFWZXTnRfbG+HwF1DJ9n4FtfK50FyeJSRq8kImSmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vw1rLOboOHFCMxiQbSu65WmXwC14YAdLLF3MyQbqq4jbG69ZvEXV9mvOQ07QJKLZPvWuFvZLDg1j19B8DQGofKDXZMZp0etNUpRjXAdhg0fPAmdLupHb+OZ9jk6/G7lEY+x+q8vPm9w/je4tkqGrqOuJJbbPAHStG/XyI0vwzZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCfvO7qB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCfvO7qB"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4904fd4f6aeso74251955e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 18:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780189385; x=1780794185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xcR4llDLZ21dX5aGAHoZFyM5vQ6lE/uFW6fHX8pUaI=;
        b=jCfvO7qBVVXKTcOlfUa6tSZO8/gjbdh1BF6NE9G3o80DPXyDhMitwi1hSC20yG73Zr
         Di/I9DSUSzgUkdD/Xnhme2MNWHgw679ZK6z8dT+WEPR/B6Mxgfsnu20MZpLqQjLgDz20
         lzbSB6VVmc/BvsDeK7tPSK90BaGVhabvFMQNyQtoWPVYdbeqUoU6o27XN/xwFNFEwywD
         dSshlovJ0vlIZaUjuAlnMnrkeUlMmj29U0pB/x3rI0wtn83yzuIWa/d8O8Vwt8IkYmq6
         jSgQ4EJ+MK+Ie+hCNmf32BtZmbr3w+6rszUuUOCGPtkXRAhjEx+ggatc0Wwe6X+pu3x0
         U3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780189385; x=1780794185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+xcR4llDLZ21dX5aGAHoZFyM5vQ6lE/uFW6fHX8pUaI=;
        b=T6sMRuPseO+6cgvlWRLBM23XYaHpJPmd3bO80Ip4e9UxW1yyJy5OXysfIIUbKaT0Li
         5Mkl9yDRQoSppqdLttMw8nWir3ZpWqCgTVyDIMMUcKBK3uhkJHSWLFL+RZ8qURKDPzlq
         lfXbwze1X8drs+EBu26f2CUlc/WcgCw2nUoNXjMRYdZLu4Pu9K/kl+xjSh+PuaxGsySs
         dCR7VXxuD5z8RmfRYWLfE/P2hFTuHPcw4Ci77vPupk1enoV7AX0MMFOye985WySoGbEd
         Dok+5oQ3k2W2YT9Hq9bcliWP3Ec3Y6GDfvpcpNkVVctkJGwoXFNaFv8SuEPvvOxylwqa
         S+/A==
X-Gm-Message-State: AOJu0Yw9Jc7D0lV9xXKvjqDt7rE6Yjb3T8YOSN1lSAuHbLBu4uC8GELl
	gc/AauMLQSAySbZF8tT/qAidFrjwGG7lV/4Le70nwEDkAN2b8vsNxzwBKKpIGQ==
X-Gm-Gg: Acq92OEcmegf9ZVtc2/P+R7mnF25AW5aGGBfIPhZ3AB0xUFn/RldMthzMfMDBZ/S7aW
	Rn2wznXZGFPhi1JvU1v283vXdYoIvJ6VbVkoX+Zm3YKpRvwz7ryPjXtwBluMzbf76ia0FBGaKhv
	EVnsY95q9Tp9QpYGNwX4A6eH+nVDMYXNji8aAiYTibHQewtu/A8QyYhOSA+kLschpiOkKAQi9a7
	dSauuN3WhnpKiHvFb69LGAqOaBMlyW0WbonWbyIQq22KII6GtDaOdCB7aM3a8LFS/QYbd6NeGlQ
	mpVjcTXe4B779Hseq6cZ3Azd6GhDKZIylKiIOia4GxUIe0E5LH8aMCG8L0yNULAKd5ZSEkCx65b
	VVdvr9uF3CHTB+VdZz1ldZF+bSVdDjI8SaYXQmmyu1ox5TkOMoqyjLnPTfPjl9VyI5cjXl06Cm3
	LTiZD8lCixNdFcsRW9G20j45TEF7PNdg==
X-Received: by 2002:a05:600c:e489:20b0:490:467e:a3d7 with SMTP id 5b1f17b1804b1-490a2952798mr65855195e9.30.1780189385274;
        Sat, 30 May 2026 18:03:05 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4909ca6575csm218111405e9.4.2026.05.30.18.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 18:03:04 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	patches@lists.linux.dev
Subject: [PATCH 3/3] splice: remove PIPE_BUF_FLAG_GIFT
Date: Sun, 31 May 2026 01:01:07 +0000
Message-ID: <20260531010107.1953702-4-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260531010107.1953702-1-safinaskar@gmail.com>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is unused now.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/fuse/dev.c             | 1 -
 fs/splice.c               | 6 ++----
 include/linux/pipe_fs_i.h | 1 -
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5dda7080f4a9..fb8fe0c96692 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2352,7 +2352,6 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 				goto out_free;
 
 			*obuf = *ibuf;
-			obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 			obuf->len = rem;
 			ibuf->offset += obuf->len;
 			ibuf->len -= obuf->len;
diff --git a/fs/splice.c b/fs/splice.c
index b1a4e3713bd6..6ddf7dd72f7b 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1622,10 +1622,9 @@ static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			*obuf = *ibuf;
 
 			/*
-			 * Don't inherit the gift and merge flags, we need to
+			 * Don't inherit the merge flag, we need to
 			 * prevent multiple steals of this page.
 			 */
-			obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 			obuf->flags &= ~PIPE_BUF_FLAG_CAN_MERGE;
 
 			obuf->len = len;
@@ -1711,10 +1710,9 @@ static ssize_t link_pipe(struct pipe_inode_info *ipipe,
 		*obuf = *ibuf;
 
 		/*
-		 * Don't inherit the gift and merge flag, we need to prevent
+		 * Don't inherit the merge flag, we need to prevent
 		 * multiple steals of this page.
 		 */
-		obuf->flags &= ~PIPE_BUF_FLAG_GIFT;
 		obuf->flags &= ~PIPE_BUF_FLAG_CAN_MERGE;
 
 		if (obuf->len > len)
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 7f6a92ac9704..a1eeed800669 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -6,7 +6,6 @@
 
 #define PIPE_BUF_FLAG_LRU	0x01	/* page is on the LRU */
 #define PIPE_BUF_FLAG_ATOMIC	0x02	/* was atomically mapped */
-#define PIPE_BUF_FLAG_GIFT	0x04	/* page is a gift */
 #define PIPE_BUF_FLAG_PACKET	0x08	/* read() as a packet */
 #define PIPE_BUF_FLAG_CAN_MERGE	0x10	/* can merge buffers */
 #define PIPE_BUF_FLAG_WHOLE	0x20	/* read() must return entire buffer or error */
-- 
2.47.3

