Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6974835E1AE
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 04:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790915197; cv=none; b=f9UCGDZK28DR6YDUg3hfYUfJOK6VZQ9E83Or6ueJOOwlnQl5DW+7KztVkE4gtEDgm/ppw79emOFFjBrib4EDjYYBDQWQp/yLTNYCiJK3ep2iJb7qJXNvD0vvRZ5CKQmtjTzMZhfoUVczn2YvCmdUUW7IkALofFBYLuD4LIdUw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790915197; c=relaxed/simple;
	bh=LCR2JBPCr9b9PvvbUIwHG1o1bbom3rQF9fJDcnI02NM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N08tMjz844ANx4vRzJ3zgzuMdZoMmYnY7sKgCDfpIvlFI/S82ZmvlzFHSFFq0BZpdu7G2KnwEtl1qLVZqFIbf+T+epgPPHLwhEzQH2lhG4lFCnPNUbh+DEMCc/jVUXzQNUCrE4jQurtwxgK8qBUGdEuPQumSclylsjkxp8sxdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1WssdSG; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1WssdSG"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a4c0da0145so1545670a91.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 21:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790915195; x=1791519995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ch59/OCcOGgQy9W6cxXyKxD4pGxnDPiLx3tiRY8B8Ow=;
        b=U1WssdSGmm/Wedg96jNwSeOudt9KMnnuPuto8yXw9OuttC70rjoeECeWC10+xauxkA
         LdrLkA9TBK7y6ya1a+cHD9S0X5VAQjtjpYfa3PO8LbshYiWVkWRKakadUb9m0bZVbD1X
         NXnskSjwEUYaHtIktBDaPAIDVIzz+2/msRQFzl0gqLCZ3h044JTtFJWAEFE9iC0ukYMS
         mTlx90yt9oqljB9dgf4naONrQ4235LAphzJID1zfBiHaiH/sFd1dkeZHeySYwfeHBjzX
         HHYi3B26y5PlTxaNMtglMg7YR6AeRnJpvBQAVOUTHySyzhEQbnCR4tj8q47llhOv/vI5
         /jcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790915195; x=1791519995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ch59/OCcOGgQy9W6cxXyKxD4pGxnDPiLx3tiRY8B8Ow=;
        b=eDrJNYb585AkuNApHLsJx6dhe5oX4pLacxWtsCb85CVfjoHpb6updYG0MFlOXvy45h
         Kq1JFvYC5Sarqf+nJZkcqeZQFDbgSMv152/DqzYN5L8sB7LB3sAnGtsueDkbV5QxZPOX
         Qo6POF/bBAAKzcC6bHS+ygilnX/kLa8uPbYlf4XJmCIDs2GJGTomu0gx2gXDirpoLBP6
         y9poZcxqDirkw4lHLhdwnPmPk2eqOc6BIKj6q/INVY1RYQECosAVvOomXBRGYOE2dTzq
         /LI+vF2RG+au9g+CZyzsXIX/MtHz1PPMZ0FAwJfEomdoFWbhYlrNItYQtfIGFZkqGA9S
         fgxg==
X-Gm-Message-State: AFq9FYKLnp/9Lzp138ZppJoJCxKMH7h8se+xyj9Ny1WsIN8hJHEIF3zd
	cpAh3ABjx0oDE+VoG2WR5ZJ0nruuBMifj/bMxboh1uACt6UQ8brviwQO
X-Gm-Gg: AYBFou1wZExA3aw0hXzHweTm4zRbZVVSVc7PicvOzIfRZ4wswa1d/+Lq2Kx3qecTi5l
	JlgxQt0gDLqxTY4flshJTqahcQuFkTa5WHn2onmY2WGA5u5wJx6PQI9Pu0RVTPk6vXQqUlA5TXR
	Jcecq8/8js1VROXcEjKnbplGP41mhKjZACpyH3zo6XGuht3v9whQ/4SJtvEEdxAOu7LMsRPvD+U
	wn/9cYATTsygvKiy2Ork20/w8UQR3Xtk0H/w0YsHeNhhQfvd6JtBGezafnD2EUr5s20JsMdpry8
	cfFTsXIxbydXoapGlHb7TV3f3npy8j4xwmRoPaaK2OBNyqezfAG0rcxD8Rb/pHBNpjfZ5qc9a3E
	HJHnscZG1uuU7TDfLIxmHZMWmGPuJSJAPQhAq3/GBW2nZOQeMlJWflH7275O3IZO2sGK8I4S7Cn
	QhsIOsRFTfgsIADhaqQ/9dWOOm+KX2J03K4K5dPVHqAHhnuGLmUaNwzyJdhvdzlIK3sUrhRT9Oo
	Nvuni7nIgTr4k9YDcQkCBao7VHhVJbGE2kr4e881UzDOGU2pbg4gCXtSKLiLEZkjbog58UwhKaR
	hF36U9cLT6e6rEkAkV4Vq0shuBQYNHMqSbGAcwd+PjkigcpYlN65Pys8+9bL
X-Received: by 2002:a17:90a:da8b:b0:3a0:79e6:b45d with SMTP id 98e67ed59e1d1-3a6ceb1393dmr1425867a91.54.1790915194596;
        Thu, 01 Oct 2026 21:26:34 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6cd5ddb51sm2205054a91.14.2026.10.01.21.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 21:26:34 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+799a0e744ac47f928024@syzkaller.appspotmail.com,
	syzbot+43fc5ba6dcb33e3261ca@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH RESEND 1/3] udf: don't let the extent type hide an exhausted free-space table extent
Date: Fri,  2 Oct 2026 12:26:25 +0800
Message-ID: <20261002042627.1677228-2-matthias.goergens@gmail.com>
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

udf_table_new_block() takes the first block of the free-space table
extent closest to the goal.  It keeps that extent's type and length
together in goal_elen, subtracts one block, and deletes the extent only
if goal_elen then reaches zero.  UDF 2.60 section 2.3.7.1 requires the
free-space extents of an Unallocated Space Entry to be of type 1
(allocated but not recorded), and mkudffs writes them that way.  For
such an extent the type bits keep goal_elen non-zero, so taking its last
block leaves a type-1 extent of length zero behind, starting at the
block after the extent, which is in use.

The next allocation that picks this empty extent returns that in-use
block.  Subtracting a block from 0x40000000 then borrows from the type
bits, and the extent becomes type 0 with a length of 2^30 - blocksize:
about a gigabyte of "free" space overlapping live metadata, the other
table extents and whatever lies behind the partition.  From then on
blocks are handed out twice, or past the end of the partition.

Extents that udf_table_free_blocks() adds are type 0, where the check
works, so only tables written by mkudffs or by another implementation
are affected.  Nothing more than filling such a filesystem is needed:
on a fresh 1 MiB "mkudffs --space=unalloctable" image, creating empty
files until the partition is full writes file entries over the reserve
volume descriptor sequence and the backup anchor, and df then reports a
negative amount of used space.

On syzbot's images the same double allocation is what the two reports
below trip over.  In the first, ftruncate() extends a new file with
enough hole extents to need a chain of allocation extent descriptors;
one AED is placed on another inode's file entry, and a later one is
placed on the block of the AED currently being filled, which
udf_setup_indirect_aext() zeroes, so __udf_add_aext() finds
lengthAllocDescs out of step with its cursor.  In the second, an AED
is placed past the end of the device, sb_getblk() fails, and the error
path of udf_do_extend_file() calls udf_truncate_extents() on an extent
list that no longer covers i_size.

Keep the type separately from the length, as udf_table_prealloc_blocks()
already does.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: syzbot+799a0e744ac47f928024@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=799a0e744ac47f928024
Reported-by: syzbot+43fc5ba6dcb33e3261ca@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
Reproducer, with mkudffs from udftools:

  truncate --size=1M udf.img
  mkudffs --blocksize=512 --space=unalloctable udf.img
  mount -t udf -o loop udf.img /mnt
  mkdir /mnt/d
  i=0; while touch /mnt/d/f$i 2> /dev/null; do i=$((i + 1)); done
  df /mnt
  umount /mnt
  dd if=udf.img bs=512 skip=2047 count=1 | od -A n -t u2 -N 2

Without this patch df shows a negative used count, and the last block,
the backup anchor (tag identifier 2), now holds an extended file entry
(266).  With it, file creation stops when the partition is full, df
shows it 100% used, and the anchor is intact.

 fs/udf/balloc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 30cec5600149..2ec577b4321c 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -572,7 +572,7 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
 	uint32_t elen, goal_elen = 0;
 	struct kernel_lb_addr eloc, goal_eloc;
 	struct extent_position epos, goal_epos;
-	int8_t etype;
+	int8_t etype, goal_etype = 0;
 	struct udf_inode_info *iinfo = UDF_I(table);
 	int ret = 0;
 
@@ -623,7 +623,8 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
 			goal_epos.block = epos.block;
 			goal_epos.offset = epos.offset - adsize;
 			goal_eloc = eloc;
-			goal_elen = (etype << 30) | elen;
+			goal_elen = elen;
+			goal_etype = etype;
 		}
 	}
 
@@ -647,7 +648,8 @@ static udf_pblk_t udf_table_new_block(struct super_block *sb,
 	goal_elen -= sb->s_blocksize;
 
 	if (goal_elen)
-		udf_write_aext(table, &goal_epos, &goal_eloc, goal_elen, 1);
+		udf_write_aext(table, &goal_epos, &goal_eloc,
+			       (goal_etype << 30) | goal_elen, 1);
 	else
 		udf_delete_aext(table, goal_epos, &freed);
 	brelse(goal_epos.bh);
-- 
2.55.0

