Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772953;
	b=oPiXNEI94ZoqNA+NXmOm1PfuE5dFPa5UWUEo3TTQrOhZli/JAJ5BCq0wYTTbIwK+3NDB
	 IIinnSRkTbcW2zyPj0PYXn0PbAB4kreWLQeHPFaQw0XppgeYMohLFp+IzlIwUGka3pvzg
	 stktOmxgVEIw+OZ1yLSa3E2c+wmRA54zVHCQ5VJu+ueczWpIEjCkAXY+bfyLbNS1YnosK
	 +nWtUd3cdbi0PrciPc2sRLKkdM0ZAcJpfpJs8Giqv4jSfoMQLCsWDmfYRgpxT4oG38om2
	 5C7zX5kpWUFUoSJCZzMmycXB96hH+YtZDyf9G2f+DowHfFNfmWCMtYeCLL4hkyJir/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MCcCJzJcyMLfAALTRppy1JcclrYetPHK7Z4PTdaUix0=;
	b=ES54PqCXPMXEMHbqjWXM+ouQv0sTZ0Uv58gLJigdQ3nbIpc4cxfu3KVhrBXVz+TTMOwG
	 NLHhHL8r/+t+7IW+pzn8rVJm/S8nEbLf8mA57spDo+TI/YVmouJ7130wjeAMXxXGLjayb
	 fZiEcoy+Mw1DbGN7T0xsPf68LiaTAIpu89VjYUzK/POVpBvSCUzzEQMsVQH9PdHYvOFus
	 HpYi6HCXxOnzYzD2fBW+KdAIN9vebwOLb7MSie7WXu5P5fUKHqKUO08bFxaXAvQlPPGXm
	 uE5dPk1kdMn+0VD9638dfOnBbXFzT8F9rjyOisMAFUbL4IOrxYNtMkQvr9+0vnUtpng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PkVcJYAR;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9465D606A31B
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 16:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9465D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PkVcJYAR
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso698023f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 09:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792772951; x=1793377751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MCcCJzJcyMLfAALTRppy1JcclrYetPHK7Z4PTdaUix0=;
        b=PkVcJYARO8fjYAI3jhqXDBujBBuUvnfVWUFmgjS7Z56NnLwAoDT8xOHqF7x5s68qgt
         gaBLCllAu7gMpHkGD+KRyRkmdxdeW0S0danjpIRL7/U6KwJ5UNwVQKLXhfJ3NVuV0nE+
         RnzMsEN5SU20V3+2KOftWZCjnPj/DYwyY3tJ6kMf06rW59smD996pB7UgOXZCoPj9kK1
         1n72B1kbSCuZsYfgl5e596W2mUVwB4cfvgI7FbE3dqtvJyODPDXAE7xk0oQW0C56Umnd
         s7lEoQYjYNFWYIOz2KHTw5qRIj4hP9rRQ9w4HL7ghsxBXa0PTYeCn/KZbKNxAUIDQKWJ
         9Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792772951; x=1793377751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MCcCJzJcyMLfAALTRppy1JcclrYetPHK7Z4PTdaUix0=;
        b=2nhVzxykY4lz4M/Nvk+O/3Uz3vQ10sexW7n7VLO2GtDB6J9X5dulrRT79CKzYdgUsC
         RWTI7cPT6Ck0vB9ZFotKaomy9zw0u+/aFmHH2PRE1vySh7g7l1NeU+p5IHegcQooIe6W
         eAi31kgEiAIR9LS73kCLoG5qbhinQx1XA4X1Qd3MbgUxK/JWJTTK0FUAZMNiffIjfXLX
         O5UEeLQU+gbob4+SSmC8bjqffd7McKgpE9FkRH6/rjUhlEoSG6UcEmzY2eEky6CloE+1
         I6hjAgJcKx5TJYLMz8mvydqs8n4suBO/AoQfgFQ8Ks1IuaLDfAC0fNuACF7eoDiiTl4i
         X3ow==
X-Forwarded-Encrypted: i=1; AKwUvBySww6xBxL3vmfjG64D4MoJofbkUVIkTvsofsfp4wPx29qpS51xEJYjP8ugO5rpRmKsbSznGGpulMYdvFCV@vger.kernel.org
X-Gm-Message-State: AFq9FYIe0HqX/E6ZvopS/AsyH2UMvgeXNzyMGoaN6FF6BTrHBE5paXj+
	Mr0BQIM7JvGbXHAnE/2X5x3OsLzgxzAxgpzuio3+MpeApeYmmfkhUwso
X-Gm-Gg: AYBFou0XCVWTGsBq/Ty7aPYwBw3Z+/Gik36ikpys2Ih/XyJyGAqsUsbrgE2p++FIIBX
	CQ4LCGV5p3Vj98j22wmKDr84QIaz/3oTM0dWyThyILjylVsai3FV84Zf+mX+/HdfLZwQuEnAel/
	Cvuxu5RpKDHV5hV9zgu3nhslFGEiCCDqJ/yv6isAPq8sG7tWoQOLRlzO5RWECThFT5prHKrOapp
	FXn6Bw0UesosisnygEn+z+RV6o8Al+pUhZTr9lW0Rz03xMfnTEGMwl4jd9Qs0VN+esXVDODJLIq
	WOi9tYtR39tNtQkIy1ZwrHRT/UKUwLL+eb2PqE8/48RgGLK9AqidzgFucVZvBQRx+e4BiFfl2U9
	UDkv+r/nN6edS2LMrc69fPGLUX+n2XcexmOUqq7H5rwyUckZQ7WyFr+wwo8/ZwN0bE2XzWBZOqC
	PoJxizpMoTCIKsybiIkxqvv8wyHfPcWWb04toEuJLIFOZyYNAvfEj3uyXP8YZpsPCPjUPhIsnu1
	2LAl+OejZiw7higCZEUcHFFP96kG6VeV8zHrc/80C98/6yzlhiCFe3A+1qDmQ7xxcRJfyxdZY2T
	I584Z3DSmAHXmxOaGlUnr7hmag21
X-Received: by 2002:a05:600c:3f16:b0:4a2:526b:d417 with SMTP id 5b1f17b1804b1-4a2526bd79fmr16181255e9.7.1792772950799;
        Fri, 23 Oct 2026 09:29:10 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([105.98.0.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2958bf246sm16379855e9.1.2026.10.23.09.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:29:10 -0700 (PDT)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: Breno Leitao <leitao@debian.org>,
	Andreas Hindborg <a.hindborg@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+63336d70e1af377d7388@syzkaller.appspotmail.com,
	Ran Hongyun <ranhongyun1@huawei.com>,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Subject: [PATCH v2] configfs: fix slab-UAF Write in config_item_put
Date: Fri, 23 Oct 2026 17:29:06 +0100
Message-ID: <20261023162906.2938-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Re-looking up parent_item is not sufficient on its own.
configfs_get_config_item() only fails if the parent dentry has been
unhashed, and the rmdir path in another thread may skip that: if
simple_rmdir() failed, the earlier d_drop() was skipped, so the dentry
can stay hashed even though the directory has already been detached.

Such a directory was created as a default group (CONFIGFS_USET_DIR), so
configfs_rmdir() takes the CONFIGFS_USET_DIR branch and calls
configfs_detach_group(). detach_groups() then marks each child inode
S_DEAD (d_inode(child)->i_flags |= S_DEAD). Check IS_DEADDIR(dir)
after retaking the inode lock and before taking a reference on the
parent, and return -ENOENT. This also rejects a detached directory
whose dentry is still hashed.

Reported-by: syzbot+63336d70e1af377d7388@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=63336d70e1af377d7388
Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
---
v2: Added check for dead dir, this would be helpful when configfs_remove_dir skips
unhashing the dentry.
v1: https://lore.kernel.org/all/20261017123748.4430-1-drifabdelmalekmohamedsaid@gmail.com/T/
 fs/configfs/symlink.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
index 89178f5d371a..7d746a10c369 100644
--- a/fs/configfs/symlink.c
+++ b/fs/configfs/symlink.c
@@ -196,11 +196,26 @@ int configfs_symlink(const struct mnt_idmap *idmap, struct inode *dir,
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
+	if (IS_DEADDIR(dir)) {
+		ret = -ENOENT;
+		goto out_put_target;
+	}
+
+	parent_item = configfs_get_config_item(dentry->d_parent);
+	if (!parent_item) {
+		ret = -ENOENT;
+		goto out_put_target;
+	}
 
 	if (dentry->d_inode || d_unhashed(dentry))
 		ret = -EEXIST;
@@ -218,6 +233,7 @@ int configfs_symlink(const struct mnt_idmap *idmap, struct inode *dir,
 						     target_item);
 	}
 
+out_put_target:
 	configfs_put(target_sd);
 	config_item_put(target_item);
 
-- 
2.43.0

