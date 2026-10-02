Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF33590A9
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 04:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790915199; cv=none; b=ar3vcPJPey/XvxuO53JNYEGRaLspAUFr6pr12KECSlNYMirWHBX0P1jSnzQDw4/Z30OND3karV8eFpT62KvXdCseQpFoABaHgX8CO091rlZVdWWL5Rvt8r+DfsOxJ39Tq1UeKDWQ/vUUEFr5dGmOUM9sKOgknpkO0HPJVdvQm9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790915199; c=relaxed/simple;
	bh=zrZwbjnwFa2fvtKd1riZTpYubuiOygKlk11p9wvAiaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNFP7kRZj3At2u9E7tkcGe+EEqb7Jn/AYU+b+qruwcBBEx7Fi397rvjEijl3lpBDJPEY7dlSg6zuyiejJ0i47pGS15aHrYtyi3VIOvXuW3FhEvn+Lg1sTbLPS2N0ffxDN91Ko7tdHyob+tK8ATsZCwvapk3xOHmtqMrnoZ3ByJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ila25MHI; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ila25MHI"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2d58a3b05so29457765ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 21:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790915197; x=1791519997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IoKxOTjOYPY0jJKf2vvmoT8EEKuylC7jQJjw/PcHr2A=;
        b=ila25MHIe3o/eK1FW9hSzDNB4AmMJ1mRmhb7pMrUxFM0v2RS8u4p9kspsuu4Uwe6U7
         G3EPkAMpo2IuGVJ+1VLRLJ0gcex39wYTzWz7k6uFYWM7t288GOVEXJlNxkCx8bTHHfQj
         zsv3gH6Z6KIIcRLC2NrowGTAeGGAnGjTIKRCm4zlLslthUG6OUP12PlvZ8MvpuwzkkO3
         kI7PuxnZpQn5DgMbKcbkKGy7ymOXvlcKpKqB2q6FQYrmBdBwUonjIEA7U/RVO/nKhd/o
         DdYTfUk2y3oz0oULpLudCpAQhOKwKdA9Rxt5pTxYyGbrwi7xi1fy+5v/1eBSFRhPEpYd
         EtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790915197; x=1791519997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IoKxOTjOYPY0jJKf2vvmoT8EEKuylC7jQJjw/PcHr2A=;
        b=UiQbOEga1tDXhypHEwN8sCrV5P+P1f9QcpoVO0gsl6chQGaZkz1BRrV70yxWxLGC7o
         PTVoaoeXdnRv6i6eI3DuGnRso10eAdutqqR7X3PQRLkEdqjmojtEmSUGzLHg2lqsAgKA
         ZIEoezkTMHiYlNvZe/BPUG06WvZQ0bwoscnwp3qaAx6WFLd5MYOzTmX+OYwnJWnPF+JN
         UKiVIDYNP9EXW8JiN46aS4ICXeUer8Ka5xBveFh6jWep7lMiuGFrf96De0udBpTgKrJd
         lU3kSVPLe9at3ayHFvWMuT/9uFEqunwxsceHYlx+GvA2DfQzdTdcs9XP2CX5q0Yt1L+S
         k8Rg==
X-Gm-Message-State: AFq9FYJh/J0r0wkWoXmOZlv+ZWpa4fj+nGIIJJFXaF9QtqvZD+Q531ll
	MYhc6NoGCGP8p2TbPoxPG027QU8GHNcCAO2n5O3VXDKHxnrqVGHmW2l0
X-Gm-Gg: AYBFou17FpIuaiV1bC9z3JMdVFXarI+h7KdhCm6XsDQw0DT4+LC7YB2wk9vOJ1p31p/
	Kh+As1a/xGxDoHKfdpsup9NqoatAf1QRQ0EnaH1sruOtAq2xf7eK5LwZyiPrzgrWlu4yNNMw0w2
	CHCElaLgPrjGSPYvNs5DLU4pgKW9QGl8IohYanRZwM6cyU+ESqnZW3SuGhMimO+HKIKWiQwaRTj
	nWpxynEMO3yP/S2TAOqRtnU74Mo86EEHqRPn8Dvv4+tNGYA2gUtP79cA61OP1nxRy8rPCIGYuKR
	O4WV8T7n4mY0zDBpu6yBs/5tJh3W4E2a0BurVjmPAFPnZmZfioO57Yx+1MFm8f8HGGrcT7JPwhP
	czuzFthqj8Ex4XTZkWnuMTBfZc8woedLVz4g+HFyZT3F8TcXYJ8xzt8TTqNGeZ4ebLi1y1/FCh8
	tyVZb7Q3pYY1hBq4r+NNhS6aXjMj+sCn5jJmidScrXsN3L9eQqe8dYU0m/kSR2jCE9rEvNuYeAX
	b6imdaiUIOdL0K3Qolk2u1J5xfEy1xtqxGt6ZzXARBzC39Eu2Ja6Y5F8ZXk+e0zHYoc55SUDvNy
	I+NukW82s0qgNkDAdGR5W7j/lwXV3xsC0fo99zvgD4+xJMvSTaVl+zPccSo=
X-Received: by 2002:a17:90a:dfd0:b0:3a4:f75d:d194 with SMTP id 98e67ed59e1d1-3a6cec99dacmr1321004a91.36.1790915197005;
        Thu, 01 Oct 2026 21:26:37 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6cd5ddb51sm2205054a91.14.2026.10.01.21.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 21:26:36 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+799a0e744ac47f928024@syzkaller.appspotmail.com,
	syzbot+43fc5ba6dcb33e3261ca@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH RESEND 2/3] udf: check the unallocated space table when it is loaded
Date: Fri,  2 Oct 2026 12:26:26 +0800
Message-ID: <20261002042627.1677228-3-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261002042627.1677228-1-matthias.goergens@gmail.com>
References: <20261002042627.1677228-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udf_table_new_block() hands out the first block of the extent closest
to its goal and trusts that the extent covers at least one whole block
inside the partition.  Nothing checks that.  A zero-length extent makes
it return the block the extent points at, which need not be free, and
the subtraction of one block then underflows the length into the type
bits, turning the entry into a bogus continuation.  An extent running
past the end of the partition makes it return blocks behind the
partition.

Such tables are not only found on crafted images: until the previous
commit, udf_table_new_block() itself left zero-length extents behind
in tables written by mkudffs, and then converted them into extents
running past the partition.

Check every extent once when the table is loaded, and refuse
read-write access if one is empty, is not a whole number of blocks, or
does not lie inside the partition, in the same way as for other
allocation information the kernel cannot use.  Check first that the
table is an Unallocated Space Entry at all: the walk starts at the
offset of the allocation descriptors in one, and for a file entry that
offset lies before the inode's in-memory copy of the descriptors.
Treat a chain of allocation extent descriptors that leads back to
itself the same way: the walk would otherwise return the same extents
forever, and the mount would never finish.  Let a fatal signal
interrupt the walk and fail the mount.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/udf/super.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 5351755aca3e..995969e6c7c5 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1106,6 +1106,73 @@ static int check_partition_desc(struct super_block *sb,
 	return 0;
 }
 
+/*
+ * Check the Unallocated Space Table once when it is loaded: the allocator
+ * hands out blocks from the start of each extent and trusts that every
+ * extent covers at least one whole block inside the partition.
+ */
+static int udf_check_unalloc_table(struct super_block *sb,
+				   struct inode *table, u32 partition_len)
+{
+	struct extent_position epos = {
+		.block = UDF_I(table)->i_location,
+		.offset = sizeof(struct unallocSpaceEntry),
+	};
+	struct kernel_lb_addr eloc;
+	uint32_t elen, blocks;
+	struct kernel_lb_addr seen_block = {};
+	uint32_t seen_offset = 0;
+	u64 steps = 0, period = 1;
+	int8_t etype;
+	int ret;
+
+	/* The walk below assumes the layout of an Unallocated Space Entry */
+	if (!UDF_I(table)->i_use) {
+		udf_err(sb, "unallocated space table is not an unallocated space entry\n");
+		return -EFSCORRUPTED;
+	}
+
+	while ((ret = udf_next_aext(table, &epos, &eloc, &elen, &etype, 1)) > 0) {
+		blocks = elen >> sb->s_blocksize_bits;
+		if (!blocks || (elen & (sb->s_blocksize - 1)) ||
+		    eloc.logicalBlockNum >= partition_len ||
+		    blocks > partition_len - eloc.logicalBlockNum) {
+			udf_err(sb, "invalid unallocated space table extent (block %u, length %u)\n",
+				eloc.logicalBlockNum, elen);
+			ret = -EFSCORRUPTED;
+			break;
+		}
+		/*
+		 * A chain of allocation extents can lead back to itself, and
+		 * then the walk returns the same extents forever.  Remember a
+		 * position at doubling intervals (Brent's cycle detection);
+		 * a walk that comes back to it is in a loop.
+		 */
+		if (epos.block.logicalBlockNum == seen_block.logicalBlockNum &&
+		    epos.block.partitionReferenceNum ==
+				seen_block.partitionReferenceNum &&
+		    epos.offset == seen_offset) {
+			udf_err(sb, "unallocated space table loops back on itself\n");
+			ret = -EFSCORRUPTED;
+			break;
+		}
+		if (++steps == period) {
+			seen_block = epos.block;
+			seen_offset = epos.offset;
+			steps = 0;
+			period <<= 1;
+		}
+		if (fatal_signal_pending(current)) {
+			udf_err(sb, "interrupted while checking the unallocated space table\n");
+			ret = -EINTR;
+			break;
+		}
+		cond_resched();
+	}
+	brelse(epos.bh);
+	return ret;
+}
+
 static int udf_fill_partdesc_info(struct super_block *sb,
 		struct partitionDesc *p, int p_index)
 {
@@ -1166,6 +1233,16 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 				  p_index);
 			return PTR_ERR(inode);
 		}
+		err = udf_check_unalloc_table(sb, inode, map->s_partition_len);
+		if (err) {
+			iput(inode);
+			if (err == -EINTR)
+				return err;
+			if (!sb_rdonly(sb))
+				return -EACCES;
+			UDF_SET_FLAG(sb, UDF_FLAG_RW_INCOMPAT);
+			return 0;
+		}
 		map->s_uspace.s_table = inode;
 		map->s_partition_flags |= UDF_PART_FLAG_UNALLOC_TABLE;
 		udf_debug("unallocSpaceTable (part %d) @ %llu\n",
@@ -2233,8 +2310,9 @@ static int udf_fill_super(struct super_block *sb, struct fs_context *fc)
 				/*
 				 * EACCES is special - we want to propagate to
 				 * upper layers that we cannot handle RW mount.
+				 * EINTR means that a fatal signal is pending.
 				 */
-				if (ret == -EACCES)
+				if (ret == -EACCES || ret == -EINTR)
 					break;
 			} else
 				break;
-- 
2.55.0

