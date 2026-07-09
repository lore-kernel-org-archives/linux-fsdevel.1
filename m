Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1E438758E
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 22:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783637436; cv=none; b=L6TVOUUJmTg0+pRFQzFE1G7KcGriITrx5uCgyeJlClLs5u8+eTnQr3Puce+EpTxc+WTO6Po0YQM9ilHq+0ejh9DFvaLTPHf037stxibSkk4IhLiX4mzX3eokNts1ssUUnufPhDbyjWB2/gDR1Qj8Kv+8FoX5J/ZdBwhU8J4Irl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783637436; c=relaxed/simple;
	bh=lKyL9gz3vBNCA/mVzw/ecXvm4uelP6Vm9InVblcJais=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sq7vZKLkCLZAfKMUtHPWqnahdjR44/zwPW5EWSCsSCCRrfPqsNb4K4Rn1Svq91qoH869dQ9/LVZv/NpvOuBMvz4x/KWScMHRyR+j1niZX8NLemzfZrmbIlS5EayBvWiEFrOACJ8UAOHF0AV0twy8aL/tWqRFUMfqBLnex/eUL64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=H6KAqSrv; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="H6KAqSrv"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-664cdeab266so459073d50.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2026 15:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783637433; x=1784242233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q3VWenFIyTPKXPjl/2eGbBJPh7tSwc/FJpGNTYnREL4=;
        b=H6KAqSrvj4DBhGWEB/YotXutSCHcFbAtprrEJ7O72gU6/OwQIHu5/NYCqTRGG+DOZV
         tq4cjMcexFcHoO1KFLLqi+DkTUa0CbsRODGMZtiqHHNf3Y6PLWmxotwkvnXYUccs5bQ6
         tit2EiebpQQZ+vc2QUVK6Z4UwI59o3po50qKCR+sroIVZy1KhZOy6XGgr7qGaRJYcCLD
         Ejb99StIbXKEGziDlSYfvpRJ14T2i+/aQSfO80zAg53i/Q0Q6KiCjF81pfaFjl5xyszL
         /SwitCDUZjOE9TEKIsJrVLF9CQ6vcbmBgfRyyoY4AEtt/4XjFSdzhkTkZGqzfl9brdCP
         oxCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783637433; x=1784242233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q3VWenFIyTPKXPjl/2eGbBJPh7tSwc/FJpGNTYnREL4=;
        b=Eenb4rnnCtMNHG5Wiyfq9+fgS1ceNGc5HtPFiULRWeecdhv+mjUqBjkVIWitqhlqyi
         35Trj8qJBviZQ3oce+TJWUpwvagfsrkMXhiPIeegVrzRWk1+NLhv/F44iGRwxd/lcJGM
         ye3s8ipvMpPZevEaLcUGwEYKjNq+hFr6k9oSzQO5r8onhiPbGmtMlE0t79F8JYEHMfjx
         BMQURaG1AG2MzSmeuWiIUh6QB2QHdoMuDpv7WCEdSWOrrUBj7EXl5aYOCctmTMZZHnxN
         9B2VF3jODSnqOeQHXATCRAWSPAtxej238KBSVqg78wbAJl3nkZQrVvbKMj8qWnfIgesf
         zB+g==
X-Forwarded-Encrypted: i=1; AHgh+RoiO+1jQk0b0RmkZjyCPJkm3FBlsto0MbuRwO1M/0pr+lvwsBu2aydMHoc9aLoCi4TUQPc5PEhfG4mt7fIN@vger.kernel.org
X-Gm-Message-State: AOJu0YxUzaHcxAx5B7nKDfJPvJaPwauFEZYPz00DBmP4Zt92e7/kww8S
	fjVC3ldBfH+TFYK2r5axMW3hJuhwnxL3/yGdRC1mauWdqGx5ki5gdQg9834wcrdc1qI=
X-Gm-Gg: AfdE7cmcdMrzk7p7pG4lILVP8OQdBYY+PVxTiPZP0Xmwp620f5YX+Dqbkqq3GvMR4TJ
	3vuGIEc4eFYxjfMgkl/737suOnBRw0jOOT9JvKfxwjR1c0A/a8kANxHUj/4WojV32IdYB2gq9c3
	sk3bA5ADgjg4Z197hp7oj/mkrLGvcFJAQVusEEl77g3Q25o46OB3te5vPLjfZDVXByBTDGVNTjR
	+Thfv7glSW7IwSGDutfrfZ2kpEMTJSKFTtI0VJTZ+bV9NocXqtUaM4gsVFrBYpdqBYTxV0Qq0Tb
	hVqFewtAOPUUoo09RdmCyZwzkHypskztF6niVb+MjkF++GX6QeETRTygTuYFsuY5lLydgLhbc68
	I1TKDStMNft7lo7BZ7HDfKDnT96sTswtTMueNaU/1ndi4W3LlTc0zK2RTEQTB9b+M1fOoIDDBs3
	NX+Cg5qyEyDCSJW2V+zGGZw3GkmlfQNCaeSw5z1mJOe/SOX+LW54sWNr77IitXBG5v99UAtVnUg
	TRUGKfhRPAYtMCFGlSz7mcvHAk5o61Mo2z3txs0rOexJWYQt5Q=
X-Received: by 2002:a05:690e:128a:b0:665:2100:990 with SMTP id 956f58d0204a3-6679f03ce42mr7141055d50.28.1783637431504;
        Thu, 09 Jul 2026 15:50:31 -0700 (PDT)
Received: from system76-pc.attlocal.net ([2600:1700:6476:1430:a1d2:68f:12b6:e18d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-667c2efa583sm1231466d50.15.2026.07.09.15.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 15:50:30 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	syzbot+c149ad75e9633be0c1ad@syzkaller.appspotmail.com
Subject: [PATCH] hfs: don't re-dirty MDB buffers after a write failure
Date: Thu,  9 Jul 2026 15:50:02 -0700
Message-ID: <20260709225001.473320-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hfs_mdb_commit() and hfs_mdb_close() keep the MDB and alternate-MDB
buffer heads (mdb_bh, alt_mdb_bh) pinned for the lifetime of the
mount and write into them in place. If a write against the backing
device fails, the block layer clears BH_Uptodate on the buffer
(end_buffer_write_sync(), fs/buffer.c) to mark its contents as no
longer trustworthy.

!buffer_uptodate(bh)
WARNING: fs/buffer.c:1093 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:1093, CPU#0: syz.1.1033/6784
Modules linked in:
CPU: 0 UID: 0 PID: 6784 Comm: syz.1.1033 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:1093
Code: 4c 89 f7 e8 f9 0d d9 ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 d4 5e fb ff e8 af e7 69 ff eb 8c e8 a8 e7 69 ff 90 <0f> 0b 90 e9 a5 fd ff ff e8 9a e7 69 ff 90 0f 0b 90 e9 cf fd ff ff
RSP: 0018:ffffc90005d379a8 EFLAGS: 00010293
RAX: ffffffff825c9ae8 RBX: ffff8880123aa700 RCX: ffff888034a30000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 1ffff1100a45f401 R08: ffff8880123aa707 R09: 1ffff110024754e0
R10: dffffc0000000000 R11: ffffed10024754e1 R12: dffffc0000000000
R13: ffff8880522fa668 R14: ffff888045ba945b R15: ffff888045ba9400
FS:  000055556b366500(0000) GS:ffff88808c54e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31a63fff CR3: 0000000034b1d000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 hfs_mdb_commit+0x503/0x1160 fs/hfs/mdb.c:309
 hfs_sync_fs+0x1d/0x30 fs/hfs/super.c:38
 sync_filesystem+0x1cf/0x230 fs/sync.c:66
 fs_bdev_sync+0x2c/0x50 fs/super.c:1433
 blkdev_flushbuf block/ioctl.c:520 [inline]
 blkdev_common_ioctl+0x12e1/0x3250 block/ioctl.c:658
 blkdev_ioctl+0x528/0x740 block/ioctl.c:791
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1d9239de59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd0ece148 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1d92625fa0 RCX: 00007f1d9239de59
RDX: 0000000000000000 RSI: 0000000000001261 RDI: 0000000000000004
RBP: 00007f1d92433e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1d92625fac R14: 00007f1d92625fa0 R15: 00007f1d92625fa0
 </TASK>

This was found by fuzzing an HFS image on a loop device backed by a
memfd; under memory pressure the shmem write-back path returned
-ENOSPC (mm/shmem.c, shmem_acct_blocks()), which surfaced as a plain
write error on the block device. The call path: ioctl(BLKFLSBUF) ->
blkdev_common_ioctl() -> sync_filesystem() -> hfs_sync_fs() ->
hfs_mdb_commit().

Check buffer_uptodate() on mdb_bh/alt_mdb_bh before dirtying them.
If either has gone stale, mark the volume read-only and skip the
write instead of asserting on it. Also, hfs_mdb_commit() returns
-EIO error code in such situation. As a result, hfs_sync_fs() can
report the failure instead of always returning 0.
The sync()/fsync()/BLKFLSBUF now observe -EIO instead of silently
succeeding while the volume goes read-only underneath them.

Reported-by: syzbot+c149ad75e9633be0c1ad@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=c149ad75e9633be0c1ad
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfs/hfs_fs.h |  2 +-
 fs/hfs/mdb.c    | 28 +++++++++++++++++++++++++---
 fs/hfs/super.c  |  3 +--
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index f3624514fcb0..8e9a1673a142 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -201,7 +201,7 @@ extern const struct xattr_handler * const hfs_xattr_handlers[];
 /* mdb.c */
 extern bool is_hfs_cnid_counts_valid(struct super_block *sb);
 extern int hfs_mdb_get(struct super_block *sb);
-extern void hfs_mdb_commit(struct super_block *sb);
+extern int hfs_mdb_commit(struct super_block *sb);
 extern void hfs_mdb_close(struct super_block *sb);
 extern void hfs_mdb_put(struct super_block *sb);
 
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index a97cea35ca2e..f4578f634302 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -274,7 +274,9 @@ int hfs_mdb_get(struct super_block *sb)
  * Output Variable(s):
  *   NONE
  * Returns:
- *   void
+ *   0 on success, -EIO if the MDB or alternate MDB buffer is no longer
+ *   valid (e.g. after a prior write error), in which case the volume is
+ *   remounted read-only.
  * Preconditions:
  *   'mdb' points to a "valid" (struct hfs_mdb).
  * Postconditions:
@@ -284,12 +286,19 @@ int hfs_mdb_get(struct super_block *sb)
  *   If 'backup' is non-zero then the alternate MDB is also written
  *   and the function doesn't return until it is actually on disk.
  */
-void hfs_mdb_commit(struct super_block *sb)
+int hfs_mdb_commit(struct super_block *sb)
 {
 	struct hfs_mdb *mdb = HFS_SB(sb)->mdb;
+	int ret = 0;
 
 	if (sb_rdonly(sb))
-		return;
+		return 0;
+
+	if (!buffer_uptodate(HFS_SB(sb)->mdb_bh)) {
+		pr_err("primary MDB is corrupt, mounting read-only\n");
+		sb->s_flags |= SB_RDONLY;
+		return -EIO;
+	}
 
 	lock_buffer(HFS_SB(sb)->mdb_bh);
 	if (test_and_clear_bit(HFS_FLG_MDB_DIRTY, &HFS_SB(sb)->flags)) {
@@ -314,6 +323,13 @@ void hfs_mdb_commit(struct super_block *sb)
 	 * files grow. */
 	if (test_and_clear_bit(HFS_FLG_ALT_MDB_DIRTY, &HFS_SB(sb)->flags) &&
 	    HFS_SB(sb)->alt_mdb) {
+		if (!buffer_uptodate(HFS_SB(sb)->alt_mdb_bh)) {
+			pr_err("alternate MDB is corrupt, mounting read-only\n");
+			sb->s_flags |= SB_RDONLY;
+			ret = -EIO;
+			goto out;
+		}
+
 		hfs_inode_write_fork(HFS_SB(sb)->ext_tree->inode, mdb->drXTExtRec,
 				     &mdb->drXTFlSize, NULL);
 		hfs_inode_write_fork(HFS_SB(sb)->cat_tree->inode, mdb->drCTExtRec,
@@ -360,7 +376,9 @@ void hfs_mdb_commit(struct super_block *sb)
 			size -= len;
 		}
 	}
+out:
 	unlock_buffer(HFS_SB(sb)->mdb_bh);
+	return ret;
 }
 
 void hfs_mdb_close(struct super_block *sb)
@@ -368,6 +386,10 @@ void hfs_mdb_close(struct super_block *sb)
 	/* update volume attributes */
 	if (sb_rdonly(sb))
 		return;
+
+	if (!buffer_uptodate(HFS_SB(sb)->mdb_bh))
+		return;
+
 	HFS_SB(sb)->mdb->drAtrb |= cpu_to_be16(HFS_SB_ATTRIB_UNMNT);
 	HFS_SB(sb)->mdb->drAtrb &= cpu_to_be16(~HFS_SB_ATTRIB_INCNSTNT);
 	mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index a466c401f6bb..67eca6f80746 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -35,8 +35,7 @@ MODULE_LICENSE("GPL");
 static int hfs_sync_fs(struct super_block *sb, int wait)
 {
 	is_hfs_cnid_counts_valid(sb);
-	hfs_mdb_commit(sb);
-	return 0;
+	return hfs_mdb_commit(sb);
 }
 
 /*
-- 
2.43.0

