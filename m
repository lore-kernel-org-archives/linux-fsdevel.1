Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369145;
	b=jDR9tQOE7zB0UGAL+vQ2DQwaGs3JpAGYAbzkRlU/BSMf9l/D6HgvHkMbH630puKKSWOE
	 ppsELMgn/MqpMOTXzZmY7xfNPJaWfDOrr2QO7DzYAfznoVGuHhUCwrFKFSusjr8BkmULc
	 Kbbba112TLrhxVVNIevpZ76cRWwRadoalnfoxVcrdYJoOfEqHgJOPz3mc+DotS1xokZQP
	 QJRID0rFk2T5SMf0/SX0YAYxwy6t3YYLchaSzTgawAc2UMok5jwGNRrz9MuP57nOnJX6o
	 94nsDoJ/o3PI7r6PpVoWz195154HoJYqVGGtdLkqDW1/wG/XCMbQBE+2nu6DdS+JzVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5nu3SzhatD4xvI8hewKAeKQkufqkhvvvAx3slr33gYc=;
	b=eacUy7OFTIEKxGMva0/cuGIcwuxYRg+9Zg3HdfeFRAlXrAgVGooiufA8OlZC7QEHWqKN
	 +7xiCG2Hk+WbAtCZp4IBnvQCuUQWRf/D0om9lDeujaPGOgDfk2t39Vl84whf6Zppzqr36
	 tb+MNYSLPBZjv4GsH9v9P14eGbuIo6J9K/fHRfGpn0Rh9GIxSW6CPpBFA09vxBLkp0vaz
	 P+hQtPLWM9gy/ous7Jo0wnJFUuAEPVA1OJxRorz8rjObh0QOV1Wq1yjPiGCiGnTzg/rhw
	 sM8jDs9Y2xT/bb8VQNccjzfTva/JhsZyI0Bcg4TN+vAs2HjRCp6XScxM6v+MMN1vNeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qfUnPceR;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D5606A329
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 14:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 986D5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qfUnPceR
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a06cc097c7so543656b3a.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 07:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793369144; x=1793973944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5nu3SzhatD4xvI8hewKAeKQkufqkhvvvAx3slr33gYc=;
        b=qfUnPceRUbpGM6V6UDM38c5gD17XZbam5SQ3c2cdf8J5CZEx9vsBJiWze1Z927iEiJ
         UBq1hYpulhusAyH/+o1sHU/V8mSVBBeeJcHLyqPiE71B6nV0je6UVGXAFcsghVeflP2N
         vyYkvV71hO0AqP8yf7mICmkLPVk+1UE4e2WT5l8t6NQ04kz/bhVqrszUqkGzeaJ4ZoCW
         KZZhqe5IyQ2KF5MZM1HH8tv1l0TPhlPIrlD0mdG/KShT5zHmdgKxiczOsQdTjNsJGmly
         Y0YXd/YaqhZ97tabiedDJtGVkwO5ABQGs2rF1K5dSBwzDNwaPfdIGkV6oqvVl2sO3yXu
         fMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793369144; x=1793973944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5nu3SzhatD4xvI8hewKAeKQkufqkhvvvAx3slr33gYc=;
        b=sPeoJQMtNC71qWs2HmGsV1zlfmTKQhDXH9AzRqPLalqPMJIivlzQ7PWBkNmViG2YDI
         wXDQ96/MfptpACWLj6fHJIJmOUgAzmLcWUUAlOLh+WoqNZqkA4hetxxRX/Sdzq6QST/F
         GpvsqzisU0wobccajOKWVwlJNMgw2ZzwPNcO30j/Sx1X2rhetKCLEbtYR61nuUunQJYl
         T0ZVDxgVDZ92/TFrRdM40pIMZuaT4Gc0lj/0yumZLXOdqeqdlXBheRN5xubho+GL9UMR
         GgUqcp4U9FJ3Jta0FEIuJvyujZz0aKDsMwRv3mvnfnb1gK/pogSCuRvrYI2V2hOiCwac
         io8g==
X-Gm-Message-State: AFq9FYLwpGkQba61ckKqVk/43yeVgIMFklMvlEnZBH4QGeuHCIQr1CBn
	/WzTlmEuRfuFO+6v2VPS4OeW3MAZUsoP1LyU5jGYYWTPiZxgJnu/xPpN
X-Gm-Gg: AYBFou0skjURw5kkw4EzLLLX+bAQ4Cx6xLiH0aeZCSeUSUltY4uDlzFgEzu8qaLBVul
	uIKSfxOd6Ytu8AGwYUCRqLQsASnLrpflOZmcDcmRlQp0nUuknRv+4dCKIp7brkk2SUEiB1a84lV
	U4F+bCj/vqBnqpwiz0nNYZobDsoVAmd6zk94e4BcW5JNGfb+cyKp/jBm02lIrXhJkHcyc4MOZZt
	A4Ut6yc690/xz9DoK3xn+algJfCVDNlb8hUHbtBXmjiq7UoQyYcmIjMLvqeCSk4lJ3tu4yrSnSB
	VctJOpA7h5FZQm3ZU3PiSgThMfPMq2cQm01eG9BKQn571Si0fD+XAYsQjin7ZbqAz4mJpUO+GFY
	FKAf06psrnp/vIcvZrbQ/u5X4sHsIG6P+C+ZqCSjX651moGWGkjmnsqhk6N/zHV5+hnYiFCitwL
	0JSiy8O7o9zL5Rx9XugPcl55oceWHBT7xs9qyh+tXAMr5H+qj5kenJWtLQNJbhh8auMZUH5cX/m
	9fmpx28LUZZuHjxSf7ZF/3RLehobvnMx4xncVsWyYbBBapYpoAsrq0Q5hGV/2qp9RmFEKNppidO
	fDdMvssxt1f4PS99k2T3tsNhEw2fKX9sg6xeVwZ+yygAaPAtlYegF2U06sGvgr1FBrpC0Kjc5mr
	n+AGbgjNyJT0WHSpfvIqkcAWFJ9+gRdsmeXMoqORgjDI5AN6Wn18b1xX3rF4/zlteTfjwJvL5Gw
	mXCb/whr0butauRkYRNva+qlORZobKktHgZ+s=
X-Received: by 2002:a05:6a00:21cf:b0:882:905d:aa05 with SMTP id d2e1a72fcca58-8a9bfde689amr2254464b3a.50.1793369143612;
        Fri, 30 Oct 2026 07:05:43 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad77fd956sm26043b3a.3.2026.10.30.07.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:05:43 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Jan Kara <jack@suse.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+799a0e744ac47f928024@syzkaller.appspotmail.com,
	syzbot+43fc5ba6dcb33e3261ca@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH v2 1/4] udf: don't let the extent type hide an exhausted free-space table extent
Date: Fri, 30 Oct 2026 22:05:34 +0800
Message-ID: <6b51c38d2d069544053c542470950e2a448b0b8d.1793349907.git.matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1793349907.git.matthias.goergens@gmail.com>
References: <cover.1793349907.git.matthias.goergens@gmail.com>
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
index 30cec56..2ec577b 100644
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
2.56.0

