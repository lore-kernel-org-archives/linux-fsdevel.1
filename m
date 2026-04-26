Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A540DFCF
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 02:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777168906; cv=none; b=ZX6NPG5GU4hOsOAs8yGVfB7CM6HvOs0FrH320LEg6ry5poNRM0ug6+eSulwKHDAT6fkmvCoiCCT5bDC+lVtEytJYlbCZ0NUkLgPvqr65gRRez9tQDp5wL6z6kqmeJWyoR7ocgQwQxwuAw9H/V0CoxjJOoPjp9rZqYy73xjLYm+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777168906; c=relaxed/simple;
	bh=9NaZesoDM/ryxq7jkZ4oEEQxN7g1m2eWIhyK9JDfE/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JuoEDhvE+iGB+StgeSbSd4rFvr0k1T6vNgFTQ3Y6NjyR1t5eXeXpaFEkZ5SwCNkoyOgvmX8pbVlw7J3a0uT1lzwe32T5t5GKDH/vJkzxB98J+L9HSAOA5ldlg4NuoG2j5vvD3aCAqGjwcFF/MyiRK2umlW36vGrzvHrhYxnOQPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLR26t9e; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLR26t9e"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-956995b5bb6so2305191241.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 19:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777168903; x=1777773703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ROdrh5QX8hoV2xqZ+4RAD5dwLaJZGrNA1ByRkwvfeKY=;
        b=XLR26t9ex7XpYqyq/rznf94NuJUu0MY1RlqR+hm4lWXbe3WEYPHMyoUbyjsBMAR7Jm
         KIypEMsK5Ted59Qze5G/WlFGQMRuwnLLgmpnXCiWNvABI7LDansFFXgNosGkbmOns/ZA
         gaNXdPM/e8VR2iM1JkS/KagcffveeWu3HGDorGF7by7GMcI66IfiYHMUGMkDNHEzG6HJ
         ueq16mCcAiwByj+04TmoyZiTKQjclO2FClvYDLqgl7HG4G0JLSxqmUNElL7sbZFU+6/Z
         sZTBediu/4migIeQucIOHbd0PldKi8/mqbNYExMacZW2yoo1EGKLLCUE5AQ5KH5Afa6l
         dt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777168903; x=1777773703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROdrh5QX8hoV2xqZ+4RAD5dwLaJZGrNA1ByRkwvfeKY=;
        b=raTAHDDEQg7QzEWKDvb9ujzY2yyL/OhWXxH2W0wM7tbnaDLXa4hwcuQOqrSfcQ5cKg
         k23yyRjSPJYZN0SifCDFSEkm4Cu+ECuKcMkj2D4OPeZfg54Cqb/Yb09GQ6AqGJeRmyiM
         nLdQZvak7L5/efnkxI2lKGTct/35GTsGbzj233BRM6bzye17K6NwWy01dgdibdE/XUdi
         TSbBwKhCa/ZJ4HpYeXfYQbP4eczZnp9lD3u6NMUb885NWaUB5cmOWtis60FADju9nM9C
         qn2QRpF1XYHcH8azyWokMlbBjQKTDUo4rkV4yv+XDfncFIl6iyRAqCyXGHA6yL35q+cq
         Lkag==
X-Forwarded-Encrypted: i=1; AFNElJ9a3+MauBq1VcBRZ5jwvJV5Ixjq9d7CKUhrF8EY51Xq6Jv29i95EI7WXDGVxaKmL/Cw5RK+75o+LGYLYXck@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0my4aUAC6a259RgMstgB1jghE0a1j9pxBQo4bbr+1x9fSnF/P
	1chylklD92DE3VBKoola6YTxvqyA8IMbyM+sJtfrZOHkAlg5OI78fW0O
X-Gm-Gg: AeBDieu0bgl/KyEHfGHzkeid9zUK3kYiNO2MwGiprRaJTzgU2off8ddMsfecKZiPV6F
	EMpbinYySYTHSzVrNwoQLmEZNbmOobS9FUEc9yHU84FGzlazoAcU3D2Vgf2E0W86JM1H1TEUSzS
	8zQ0HWuT0KWao3F9yZks5d9UFpMLjKkYh92XvYdSJR822l3eG9p9AQv+lZ83kzZDGsH5m8RuxYV
	92KLL7zwoQ7TOKTDgGNt08869TmeVEI9nEctF+wnUwRmNTmf/Ispyz6vXwwPSJJAoJlHNviFkbg
	SmFv7jHF6t+fLiwHoF09ZOnJo9V/BRn4YKCmDdXHcSz331vyb+G2LO/Mp9u7Hhpe9+RH2qUqTCb
	WKeh0ASzAikCyg/vxoJZDKjPbWfxcOlDfGUDiKW6TCJanDhTE0D4hyqWwW91Ny5Gb6XNS9StFZ0
	wdEVSAk3ePxXc7F466ijo5KQDIxWJc9SdPc9U3DhoQwQGq6+jRVutR
X-Received: by 2002:a05:6122:1d91:b0:56c:ce8a:b07a with SMTP id 71dfb90a1353d-56fa589cdb0mr17733883e0c.7.1777168903465;
        Sat, 25 Apr 2026 19:01:43 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56fa91ea606sm16057942e0c.5.2026.04.25.19.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 19:01:43 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org,
	Chao Shi <coshi036@gmail.com>,
	Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>,
	Weidong Zhu <weizhu@fiu.edu>
Subject: [RFC PATCH] fs/buffer: serialize set_buffer_uptodate against concurrent clears
Date: Sat, 25 Apr 2026 22:01:37 -0400
Message-ID: <20260426020137.1221985-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A WARN_ON_ONCE(!buffer_uptodate(bh)) in mark_buffer_dirty() is reachable
from the buffered write path on a block device when the underlying
device returns I/O errors at high density.  Reproduced by fuzzing an
NVMe controller (FEMU) that returns crafted error completions for a
sustained workload from /dev/nvme0n1.

The race is:

  CPU A: block_commit_write (folio lock held)        CPU B: end_buffer_async_read
    set_buffer_uptodate(bh);
                                                       clear_buffer_uptodate(bh);
    mark_buffer_dirty(bh);  /* WARN fires */

The contract documented at set_buffer_uptodate() in
include/linux/buffer_head.h:140 already states:

  "Any other serialization (with IO errors or whatever that might
   clear the bit) has to come from other state (eg BH_Lock)."

block_commit_write() and the buffer_new() branch in
__block_write_begin_int() violate this contract: they hold the folio
lock but not BH_Lock when calling set_buffer_uptodate() immediately
followed by mark_buffer_dirty().  Take BH_Lock around the pair so the
documented serialization holds.

The race is the same family as 558d6450c775 ("ext4: fix
WARN_ON_ONCE(!buffer_uptodate) after an error writing the
superblock"), which addressed the ext4 superblock-specific case via
state recovery.  No equivalent recovery hook exists in the generic
block_commit_write() path, so apply BH_Lock instead.

WARN stack:

  RIP: mark_buffer_dirty+0x4c2/0x560 fs/buffer.c:1183
  Call Trace:
    block_commit_write          fs/buffer.c
    block_write_end             fs/buffer.c
    iomap_write_end             fs/iomap/buffered-io.c
    iomap_file_buffered_write
    blkdev_buffered_write       block/fops.c
    blkdev_write_iter
    vfs_write
    __x64_sys_write

Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).

Acked-by: Sungwoo Kim <iam@sung-woo.kim>
Acked-by: Dave Tian <daveti@purdue.edu>
Acked-by: Weidong Zhu <weizhu@fiu.edu>
Signed-off-by: Chao Shi <coshi036@gmail.com>
---

Notes for reviewers (RFC):

1. lock_buffer() in the buffered-write end path: in the steady state
   the bh should be unlocked when block_commit_write() runs
   (block_write_begin already waited for any RMW read), so contention
   should be rare.  fio numbers TBD; happy to defer until measured if
   that is the bar.

2. Several other call sites have the same set_buffer_uptodate(bh)
   immediately followed by mark_buffer_dirty(bh) pattern without
   BH_Lock:

     fs/nilfs2/mdt.c:60
     fs/ocfs2/alloc.c:6840
     fs/ocfs2/aops.c:655
     fs/exfat/fatent.c:408
     fs/exfat/misc.c:168
     fs/ufs/ialloc.c:146
     fs/ufs/inode.c:1076, 1088
     fs/ufs/balloc.c:324
     fs/jfs/super.c:770
     fs/ext2/super.c:1594
     fs/ntfs3/fsntfs.c:1096, 1491
     fs/ntfs3/bitmap.c:755, 796, 1387

   Most look like one-shot init / metadata paths where concurrent IO
   completion on the same bh is unlikely, but I have not audited each.
   Per-fs follow-ups by respective maintainers, or one tree-wide
   series?

3. Reproducer is currently fuzzer-only (FEMU + syz-executor).  A
   minimal C reproducer using dm-flakey for read-error injection is
   in progress.

 fs/buffer.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 4d7f84e77d2..bc4fad93392 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2041,9 +2041,16 @@ int __block_write_begin_int(struct folio *folio, loff_t pos, unsigned len,
 			if (buffer_new(bh)) {
 				clean_bdev_bh_alias(bh);
 				if (folio_test_uptodate(folio)) {
+					/*
+					 * See block_commit_write() for why we
+					 * must hold BH_Lock around set_uptodate
+					 * + mark_dirty.
+					 */
+					lock_buffer(bh);
 					clear_buffer_new(bh);
 					set_buffer_uptodate(bh);
 					mark_buffer_dirty(bh);
+					unlock_buffer(bh);
 					continue;
 				}
 				if (block_end > to || block_start < from)
@@ -2104,8 +2111,20 @@ void block_commit_write(struct folio *folio, size_t from, size_t to)
 			if (!buffer_uptodate(bh))
 				partial = true;
 		} else {
+			/*
+			 * Per the contract documented at set_buffer_uptodate()
+			 * (include/linux/buffer_head.h), callers must hold
+			 * BH_Lock to serialize against concurrent clears of
+			 * BH_Uptodate.  Holding only the folio lock is not
+			 * sufficient: a concurrent end_buffer_async_read() on
+			 * a previously failed read can clear BH_Uptodate
+			 * between set_buffer_uptodate() and mark_buffer_dirty(),
+			 * tripping the WARN_ON_ONCE in mark_buffer_dirty().
+			 */
+			lock_buffer(bh);
 			set_buffer_uptodate(bh);
 			mark_buffer_dirty(bh);
+			unlock_buffer(bh);
 		}
 		if (buffer_new(bh))
 			clear_buffer_new(bh);
-- 
2.43.0

