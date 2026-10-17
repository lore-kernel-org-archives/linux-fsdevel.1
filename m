Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F27947B43A
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792240673; cv=none; b=gwSWnAM2DxsodfnfXru2cQBPvu93Okfz7Vv+pA8SUH9fNOQ0sBm8PLcixGvPyWwxfwZIF/7CBvvL7uueKlu1hHP9bQ0smc/8BTyoBOxv2LROIJHLUCL5uQMWILSm9+oC3pDpd6ASFTOezSw5FGsAbF+WygCylXB4qnbeUCXdwpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792240673; c=relaxed/simple;
	bh=aUrT+nVSDOfke71D9bNaxj810wNJzDs7psdvneAt1Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qJ/gp9PVG2uufqmvdvIfdQSzN58rcoDnp+aLCd8vBdR2RR6ETuk7PpMbF5L52ngKFHF7WPnBVfc7xQO9oiPoAulAIJtYY0D3Ts96IWR2h231zbGFXlh42c4yCGQdziBo5o6yqn3SQ4MVYE+5iiZ6zav+dIUy0FwdA5AKzXspBKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=du1X7Bnt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="du1X7Bnt"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1d484b4a9so10173815e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 05:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792240670; x=1792845470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4cj4POmn8nl8GvGmfpfjwWY0pFMOBaM2EXNXfoPc+dQ=;
        b=du1X7Bnta3kF0mJ45qOkjPYT4v4yHt2JklzDFQugu4h5WhRir9YFzJX1qEgh9VVwCM
         OA57nb+puyLKhnb08rOi+NjYErxmcVdpeP3V3Yp6QRxcyKsuyB0raUbP0Mx6NNsElsDI
         nMmrkbDVnYVYjU6kYn9R7vsdMOINesYmObHDDiwlUl5BoxZLTL1jKfK4GOZ+aWWFTm9H
         OCewp8fQTTVlYT7TMMkTqJ1rAb1sROPgxuYAe6bnyIXmddu3CvsvaTNT76WktNrlaZhl
         shxNUT+EsLux5l5ReHGJGH7bjIoGQ5fC7XfEIm6bpRb4JzoVuu0A9gR+Q4qYHd/v3rCK
         Dy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792240670; x=1792845470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4cj4POmn8nl8GvGmfpfjwWY0pFMOBaM2EXNXfoPc+dQ=;
        b=R5ibdMIRu3+733gy0+f1a+yPGYb8i0hszmEQb7VqIaGoFkLJbulXQuk/nhd4ibQzS9
         h/2dli4sbDf6Pit3D9FaaJKegnTHzgZBregylEIbKUuVOVa/3Wpiyq9y/UlmrdC9S3YC
         68wMIkzSDGZh8Y7KmqW5FsJF5IPdfGjbTcGBct1TEeNiw+yQuM1pTbCerBvknbffk0SK
         Y4W5WV60SasN/7iFa9SCAxXSzMK7uOYHCJ8WaYgiNdcPatN3O4e/9IEj3LxeZitYuciL
         q3/A/kkrUz9EynSKOpaGBHcTLxpKYGFavm2/IfCOROyPvyU8XtPfWf2ZjpX5Hl8D7WyB
         DLEw==
X-Forwarded-Encrypted: i=1; AKwUvBywqfMGcynY+gkx5FEUQb4DEMsVjJSxn/yHvO9szure3MI9v4sBTMaPNR+4vWlb6OTOEPfg/dpnSeNuPldi@vger.kernel.org
X-Gm-Message-State: AFq9FYIaRT6pvp2l8CXqXe/M0Oq18nqmxCQq+e/u/U0LDrrqtM7iealm
	lg/ZuZGqIPvbOhKBeMTHCLPk8TZZZFmngOmKiWoVQS2oeY2geQId23q1
X-Gm-Gg: AYBFou3Ui+RbrpcA8Bqj1yAYqNyk9kt/DhjmuwBDkuB44K+jA4fJlScv5HNY2elVVHs
	/RpHqKJf7+opeAOkJE65WnPG+YyyCN+CnQKI0oBYi2qooaX/MWdVK4HvuvYHWTew1RHuqhE6I2R
	WVczlbkPlcnGGOoj/VhFxp1jH2p3Wy4YpcC/5oPuyOQVWADZfa85hQF0DX+ARPkeaPaVHifJo6B
	/6QolOmxjSEvQxHKldUjlIgewNKNU6tNJJO2UKXYRI1bhNjgrJhP9kxAM9sgzV3s6kDxfxbjPUS
	kgCMIwcdNvV3ESeYqGmwVxTLOTpZagUcm+yVYNtpOIrYLh6kRRhfqR3FxmmmtR78Kf/et5+mEl1
	EENCPGejRAxxQX17OH9ppq6Tiudd+Vti8Z5EoiE14aBb3tK5MFz0cWVx4udcIzmnjW+RW+AHidY
	GondZlytVVSdn7qxGXQ1rKhW7B4h9f8h5bVJE8y8GiJM4SnrNwEsV1N9McYRVSPB1f53f3sNlfL
	WTPvxefKw7G8Umi8q311RET6hq8GzlQ7ggRuLU++76ll7cwaw==
X-Received: by 2002:a05:600c:3513:b0:4a1:d05d:2af7 with SMTP id 5b1f17b1804b1-4a1d7607497mr53066795e9.10.1792240670336;
        Sat, 17 Oct 2026 05:37:50 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([105.102.86.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd50aafbsm11716185f8f.52.2026.10.17.05.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 05:37:49 -0700 (PDT)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: Breno Leitao <leitao@debian.org>,
	Andreas Hindborg <a.hindborg@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>,
	syzbot+63336d70e1af377d7388@syzkaller.appspotmail.com
Subject: [PATCH] configfs: fix slab-UAF Write in config_item_put
Date: Sat, 17 Oct 2026 13:37:47 +0100
Message-ID: <20261017123748.4430-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported:

BUG: KASAN: slab-use-after-free in instrument_atomic_read_write
           include/linux/instrumented.h:112 [inline]
BUG: KASAN: slab-use-after-free in atomic_fetch_sub_release
           include/linux/atomic/atomic-instrumented.h:400 [inline]
BUG: KASAN: slab-use-after-free in __refcount_sub_and_test
           include/linux/refcount.h:389 [inline]
BUG: KASAN: slab-use-after-free in __refcount_dec_and_test
           include/linux/refcount.h:432 [inline]
BUG: KASAN: slab-use-after-free in refcount_dec_and_test
           include/linux/refcount.h:450 [inline]
BUG: KASAN: slab-use-after-free in kref_put
           include/linux/kref.h:64 [inline]
BUG: KASAN: slab-use-after-free in config_item_put+0x26/0x90
           fs/configfs/item.c:149
Write of size 4 at addr ffff88803b6444b4 by task syz-executor324/5709

Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:400 [inline]
 __refcount_sub_and_test include/linux/refcount.h:389 [inline]
 __refcount_dec_and_test include/linux/refcount.h:432 [inline]
 refcount_dec_and_test include/linux/refcount.h:450 [inline]
 kref_put include/linux/kref.h:64 [inline]
 config_item_put+0x26/0x90 fs/configfs/item.c:149
 configfs_symlink+0x6be/0x11d0 fs/configfs/symlink.c:225
 vfs_symlink+0x18b/0x330 fs/namei.c:5823
 filename_symlinkat+0x1cd/0x420 fs/namei.c:5848
 __do_sys_symlinkat fs/namei.c:5868 [inline]
 __se_sys_symlinkat+0x4e/0x2b0 fs/namei.c:5863
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Allocated by task 5712:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:409 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:426
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x3d5/0x680 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 nvmet_ports_make+0xe6/0xf00 drivers/nvme/target/configfs.c:2054
 configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1369
 vfs_mkdir+0x408/0x620 fs/namei.c:5439
 filename_mkdirat+0x289/0x520 fs/namei.c:5472
 __do_sys_mkdir fs/namei.c:5499 [inline]
 __se_sys_mkdir+0x34/0x150 fs/namei.c:5496
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 5712:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:264 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:296
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6509 [inline]
 kfree+0x1c5/0x6d0 mm/slub.c:6802
 config_item_cleanup fs/configfs/item.c:128 [inline]
 config_item_release+0x13a/0x2d0 fs/configfs/item.c:137
 configfs_rmdir+0x885/0x950 fs/configfs/dir.c:1580
 vfs_rmdir+0x3e9/0x6b0 fs/namei.c:5544
 filename_rmdir+0x292/0x520 fs/namei.c:5601
 __do_sys_rmdir fs/namei.c:5624 [inline]
 __se_sys_rmdir+0x2e/0x140 fs/namei.c:5621
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88803b644000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1204 bytes inside of
 freed 4096-byte region [ffff88803b644000, ffff88803b645000)

This is a race between a thread creating a symlink and another one
doing rmdir on a parent (or ancestor) directory of symlink creation dir.

configfs_symlink() takes a reference on parent_item, the directory the
link is created in, and then drops the directory inode lock around
get_target(). While the lock is dropped, a concurrent rmdir can remove
the group that parent_item belongs to.

If parent_item is a default group embedded in a larger object, such as
nvmet_port.subsys_group, the reference on the embedded item does not
keep the containing object alive. rmdir frees the object, and the final
config_item_put(parent_item) in configfs_symlink() then decrements a
kref inside freed memory.

Fix this by not holding parent_item across the unlocked window. Drop
the reference before inode_unlock() and look it up again from
dentry->d_parent after inode_lock(). configfs_get_config_item() returns
NULL if the parent dentry was unhashed in the meantime, in which case
release the target references and return -ENOENT.

Reported-by: syzbot+63336d70e1af377d7388@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=63336d70e1af377d7388
Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
---
 fs/configfs/symlink.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 89178f5d371a..51eb58b68b55 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -196,11 +196,21 @@ int configfs_symlink(const struct mnt_idmap *idmap, struct inode *dir,
 	 *
 	 *  AV, a thoroughly annoyed bastard.
 	 */
+
+	/* Put the reference back, retake and check after relocking*/
+	config_item_put(parent_item);
+	parent_item = NULL;
 	inode_unlock(dir);
 	ret = get_target(symname, &target_item, &target_sd, dentry->d_sb);
 	inode_lock(dir);
 	if (ret)
-		goto out_put;
+		goto out_put; /* config_item_put on NULL, no problem */
+
+	parent_item = configfs_get_config_item(dentry->d_parent);
+	if (!parent_item) {
+		ret = -ENOENT;
+		goto out_put_target;
+	}
 
 	if (dentry->d_inode || d_unhashed(dentry))
 		ret = -EEXIST;
@@ -218,6 +228,7 @@ int configfs_symlink(const struct mnt_idmap *idmap, struct inode *dir,
 						     target_item);
 	}
 
+out_put_target:
 	configfs_put(target_sd);
 	config_item_put(target_item);
 
-- 
2.43.0

