Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60D43438B0
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782915667; cv=none; b=Wl22pzdc5i2WsU78pOBsORYECdgesq/ZDsQrh5xBNJNG1nSkB2tDW48bvT34X57MMtpshjyuzRM9fjcmXbCgXusYK/sSZQjIqSoORH67+6gI2BLkmM3IWZoVKPAnl2yABJ1BujSmhon+NUtPDkYyCKJhdDD0p0P9Iq+b9aM11qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782915667; c=relaxed/simple;
	bh=4BNgd14Jic9Qjm/aIRlvWP0ZkCfwyzRThTknF5C49RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErAquI0YfNR4VI2wNWCT7dzQzpPwQyG2FXcmdMPaeP0BxyFe4DGjkeqhXRp5LrP1aF9VK6XWJjXC+YXOivRkzvJxxQngayxDRoLDbfGN3tWU57fgRcqn9EXc0xlJDWj/jPZ9vU6JhTQql6sXXzH58ujSM0UMY36iCBE2p+/9Re8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9rNz5Iy; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9rNz5Iy"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so357926a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 07:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782915664; x=1783520464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TF7sGPbeyivH8d5psZsdDfGtI/uaouyOVCHLn2DhWc0=;
        b=Z9rNz5Iyu+XRPByJPLkiz+Tme3QwVFjAqKjl1ojhWh8FyfmX/THYBNK7EeTrY8GW92
         WwwH17C2alfqfnw9D5r2U3QFW5BRcxpOtWZJU0vcPBhi3l0eVktYb8inJfw7MeyOeWou
         LUbMU6IAVTtWe8FBRVOd9LS7IN7D7lAlWWTPk9bG8E8MfUFPvx2zJQ4KAfKqUne6BNwU
         spfWN0UWRJbAYlqiifwT6MhFr3Zy/A9CYFKAIMS4Yqg4M6lsotKtEpd5R54UxScUHoXE
         ZxKdeaPjcSlZHpD97lWbx64+6EWfsaN7Ah/jbjixp5TdHsYawhkRgZ4fzNByflA4sZP0
         v0zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782915664; x=1783520464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TF7sGPbeyivH8d5psZsdDfGtI/uaouyOVCHLn2DhWc0=;
        b=GE3evYnA+O42WWdahKxyKYWfmK+5lWY63tWYQs5k5R2ATkQ/IvYR+BD7AVo4Db1l+G
         nf1iAGM1zGvPh1xtgqrUkk6+NbNFkdnC2bp7Mi4+uRhxNrUmOzN/tXSSGvaEuINVt7KQ
         86qsghbW6Tm5GudQIPmIBRVBuF58Ill0/ChH0sNE7I6fV/StNopHgPN4UWBTqhUVIGkR
         9M6kMQatevFhIIuLqvsspqMWJvI9gBfTynQU/ZFYLLlgdYu8GIHW4yBbrZiOditjZ1TV
         m+hd6Aa3h0yozCwA0Cg9SPk+Xm88lxJqUQKcZV7IxBPYDuzVtdDd3+lzp3crHt4+gZnI
         ditg==
X-Gm-Message-State: AOJu0YzVmeGqgkW04FjoLwOyYoSU7IGhYApUTqAOldgvHE7evTSkRvAS
	nsS6rmMLCFNUj4lkdiu8SC2x6cjEOSESH9Lc6OwSZJD4CY1FZe2/BPFG
X-Gm-Gg: AfdE7cm5YTSfk8qV33Vpz4zRlPFV1xQhikRofu2bGkE7H0j7h+GmldQbZh9E2BqNh6/
	b0JTSljLqmXl3MPmSy+vCuY7ulcoq9qkMTXGpM4QoK/EegUwBOZGxeJkGzWcDgOQ6TnnwpQm4jy
	q46lE0gc+svIED3oqaVP0sS+6KTnzTeEKg3jAZ7sfgZ4wXSQ1wa+xt50cordX8lGXUIu5M20FTo
	ECJw5stv7eOBGHQ0e/erXDtj8mS6fIHwZP/A6swdCp55HZ0/idp1JLoSVb/Elr18chpr597AldT
	BJKMnW/O6rke5KoXp/gXXqJp1+lLcIZH1BMK4rqp22RmgJ+rWuitoAlT4hPvw18pSkoxnPhnu/+
	Jzy1S/AdZxJ15u81/viO89dWldB5RaKF0WzjCXAt75iZuaRncN/8KqdXb05O3IO4N7JcJKTzYk5
	BV6UfYgk/Tk/++fTvpiZzB2WRGAZAimM1PhSe0gkUWRiI=
X-Received: by 2002:a05:6a21:4d8e:b0:3bf:a0e5:99a1 with SMTP id adf61e73a8af0-3bfed4e5912mr2024732637.51.1782915664079;
        Wed, 01 Jul 2026 07:21:04 -0700 (PDT)
Received: from DESKTOP-DK6PUT8.localdomain ([124.70.231.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e32ef8e49sm383894a12.19.2026.07.01.07.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 07:21:03 -0700 (PDT)
From: yizhang089@gmail.com
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	libaokun@linux.alibaba.com,
	jack@suse.cz,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	yizhang089@gmail.com,
	chengzhihao1@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 3/6] ext4: track partial-zero outcome per edge in ext4_zero_partial_blocks()
Date: Wed,  1 Jul 2026 22:20:06 +0800
Message-ID: <20260701142009.1510104-4-yizhang089@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701142009.1510104-1-yizhang089@gmail.com>
References: <20260701142009.1510104-1-yizhang089@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

Replace the single bool did_zero output of ext4_zero_partial_blocks()
with a bitmask that records which edge (start, end, or both in the
single-block case) was actually partial-zeroed. This allows callers to
distinguish which edges have been zeroed, preparing for unaligned
FALLOC_FL_WRITE_ZEROES handling in later patches.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    |  5 ++++-
 fs/ext4/extents.c |  2 +-
 fs/ext4/inode.c   | 36 ++++++++++++++++++++++++++++++------
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 94283a991e5c..b2e55876d0e3 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3099,8 +3099,11 @@ extern int ext4_chunk_trans_extent(struct inode *inode, int nrblocks);
 extern int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 				  int pextents);
 extern int ext4_block_zero_eof(struct inode *inode, loff_t from, loff_t end);
+
+#define EXT4_PARTIAL_ZERO_START	0x1
+#define EXT4_PARTIAL_ZERO_END	0x2
 extern int ext4_zero_partial_blocks(struct inode *inode, loff_t lstart,
-				    loff_t length, bool *did_zero);
+				    loff_t length, unsigned int *partial_zeroed);
 extern vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf);
 extern qsize_t *ext4_get_reserved_space(struct inode *inode);
 extern int ext4_get_projid(struct inode *inode, kprojid_t *projid);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 27ca641e701b..7a8f9f188a29 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4715,7 +4715,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	loff_t align_start, align_end, new_size = 0;
 	loff_t end = offset + len;
 	unsigned int blocksize = i_blocksize(inode);
-	bool partial_zeroed = false;
+	unsigned int partial_zeroed = 0;
 	int ret, flags;
 
 	trace_ext4_zero_range(inode, offset, len, mode);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0b31fa873743..d68f7be4ff02 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4256,13 +4256,26 @@ int ext4_block_zero_eof(struct inode *inode, loff_t from, loff_t end)
 	return 0;
 }
 
+/*
+ * Zero out the unaligned head and tail of the [lstart, lstart+length)
+ * range.
+ *
+ * On return, @partial_zeroed records which edges actually got
+ * partial-zeroed.  Set EXT4_PARTIAL_ZERO_START/EXT4_PARTIAL_ZERO_END if
+ * the head/tail block got actually partially zeroed (in written, dirty
+ * unwritten or delalloc state).  Cleared if the head/tail block is a
+ * hole or a clean unwritten block, in which case there is nothing needs
+ * to zero.  When the head and tail land in the same block, both bits
+ * are set together on a successful zero.
+ */
 int ext4_zero_partial_blocks(struct inode *inode, loff_t lstart, loff_t length,
-			     bool *did_zero)
+			     unsigned int *partial_zeroed)
 {
 	struct super_block *sb = inode->i_sb;
 	unsigned partial_start, partial_end;
 	ext4_fsblk_t start, end;
 	loff_t byte_end = (lstart + length - 1);
+	bool did_zero = false;
 	int err = 0;
 
 	partial_start = lstart & (sb->s_blocksize - 1);
@@ -4274,21 +4287,32 @@ int ext4_zero_partial_blocks(struct inode *inode, loff_t lstart, loff_t length,
 	/* Handle partial zero within the single block */
 	if (start == end &&
 	    (partial_start || (partial_end != sb->s_blocksize - 1))) {
-		err = ext4_block_zero_range(inode, lstart, length, did_zero,
+		err = ext4_block_zero_range(inode, lstart, length, &did_zero,
 					    NULL);
+		if (did_zero)
+			*partial_zeroed |= (EXT4_PARTIAL_ZERO_START |
+					    EXT4_PARTIAL_ZERO_END);
 		return err;
 	}
 	/* Handle partial zero out on the start of the range */
 	if (partial_start) {
 		err = ext4_block_zero_range(inode, lstart, sb->s_blocksize,
-					    did_zero, NULL);
+					    &did_zero, NULL);
 		if (err)
 			return err;
+		if (did_zero)
+			*partial_zeroed |= EXT4_PARTIAL_ZERO_START;
 	}
 	/* Handle partial zero out on the end of the range */
-	if (partial_end != sb->s_blocksize - 1)
+	if (partial_end != sb->s_blocksize - 1) {
+		did_zero = false;
 		err = ext4_block_zero_range(inode, byte_end - partial_end,
-					    partial_end + 1, did_zero, NULL);
+					    partial_end + 1, &did_zero, NULL);
+		if (err)
+			return err;
+		if (did_zero)
+			*partial_zeroed |= EXT4_PARTIAL_ZERO_END;
+	}
 	return err;
 }
 
@@ -4437,7 +4461,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	loff_t end = offset + length;
 	handle_t *handle;
 	unsigned int credits;
-	bool partial_zeroed = false;
+	unsigned int partial_zeroed = 0;
 	int ret;
 
 	trace_ext4_punch_hole(inode, offset, length, 0);
-- 
2.53.0

