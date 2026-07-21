Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E311B40A93C;
	Tue, 21 Jul 2026 06:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616130; cv=none; b=qLIQLMzunnjJKjTM/K2GSwWAtcqv6S1bbYu8ul31Hh3P3vRPj3S7+EqxeVVqTP/iwVPW5+ibLPpavb+QnHCW0kpRYlCPsbGEskmk85+W6NMB4rihIkgPbmpC2XityBzb+F9kBypLpcKLHbEh/g3tj6af8f2xhSHI4Hd+sEaWxhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616130; c=relaxed/simple;
	bh=MUp3M/PRoxdjmGgF6XS/lYG99xxHw/qTlcC3+dp613I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V3rvVDZ25h2nG4ArimWjXsSKpkYV8J+HsPeWE2hxUGM0jlCS6jQndr+X1Z1qzjj1S1urZ4RxgIsqsES1StRf1cstHlVKuwrBooE3/z+ZoibmXkr4dd3F17G71bccaNBzBhii1sFgTPVojSKReOz9/Q2S4Ii5RIf8an1CWIzqA80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 4542024884cf11f1aa26b74ffac11d73-20260721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:dfec23a3-6eaa-487a-acdf-dcc4697b58c2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:c9cb3be94a39ecf3f972ca8e550d3dec,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|16|5
	0,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4542024884cf11f1aa26b74ffac11d73-20260721
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <chenchangcheng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 469598887; Tue, 21 Jul 2026 14:41:58 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ccc194101@163.com,
	Chen Changcheng <chenchangcheng@kylinos.cn>
Subject: [PATCH] fs/super: fix emergency thaw double-unlock of s_umount
Date: Tue, 21 Jul 2026 14:41:40 +0800
Message-Id: <20260721064140.152305-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

do_thaw_all() iterates over all superblocks via __iterate_supers()
with SUPER_ITER_EXCL, which acquires s_umount exclusively before
calling the callback and releases it afterwards. However, the
callback do_thaw_all_callback() calls thaw_super_locked() which
unconditionally releases s_umount on every code path. This results
in a second unlock attempt in __iterate_supers() that corrupts the
rwsem state, triggering a DEBUG_RWSEMS warning:

[  182.601148] sysrq: Emergency Thaw of all frozen filesystems
[  182.601865] ------------[ cut here ]------------
[  182.602375] DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff99b1011e5870, owner = 0x0, curr 0xffff99b101b06c80, list not empty
[  182.603817] WARNING: kernel/locking/rwsem.c:1412 at up_write+0xa3/0x170, CPU#2: kworker/2:1/53
[  182.604578] Modules linked in:
[  182.604864] CPU: 2 UID: 0 PID: 53 Comm: kworker/2:1 Not tainted 7.2.0-rc4-00001-gbd3bd93ea98a-dirty #4 PREEMPT(lazy)
[  182.605711] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1kylin1 04/01/2014
[  182.606417] Workqueue: events do_thaw_all
[  182.606750] RIP: 0010:up_write+0xaf/0x170
[  182.607076] Code: 19 3a 92 48 0f 44 c2 48 8b 55 08 48 8b 55 00 4c 8b 45 08 48 8b 55 00 48 8d 3d ad 91 e0 01 48 8b 4d 20 50 48 c7 c6 f0 8c 26 92 <67> 48 0f b9 3a e8 d7 93 4e 00 58 eb 81 48 83 7f 18 00 48 c7 c2 8d
[  182.608563] RSP: 0018:ffffb670001d7e08 EFLAGS: 00010246
[  182.609007] RAX: ffffffff92349e8d RBX: 0000000000000000 RCX: ffff99b1011e5870
[  182.609595] RDX: 0000000000000000 RSI: ffffffff92268cf0 RDI: ffffffff92914d10
[  182.610283] RBP: ffff99b1011e5870 R08: 0000000000000000 R09: ffff99b101b06c80
[  182.610847] R10: ffff99b10139a808 R11: fefefefefefefeff R12: 0000000000000000
[  182.611414] R13: ffffffff90cf74d0 R14: 0000000000000000 R15: ffff99b1011e5800
[  182.612009] FS:  0000000000000000(0000) GS:ffff99b1eaaee000(0000) knlGS:0000000000000000
[  182.612670] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  182.613146] CR2: 00000000005c631c CR3: 00000000013ee000 CR4: 00000000000006f0
[  182.613722] Call Trace:
[  182.613946]  <TASK>
[  182.614130]  __iterate_supers+0x128/0x150
[  182.614463]  do_thaw_all+0x1b/0x30
[  182.614759]  process_scheduled_works+0xbb/0x3f0
[  182.615150]  ? __pfx_worker_thread+0x10/0x10
[  182.615499]  worker_thread+0x129/0x270
[  182.615816]  ? __pfx_worker_thread+0x10/0x10
[  182.616201]  kthread+0xe2/0x120
[  182.616469]  ? __pfx_kthread+0x10/0x10
[  182.616792]  ret_from_fork+0x15b/0x240
[  182.617115]  ? __pfx_kthread+0x10/0x10
[  182.617426]  ret_from_fork_asm+0x1a/0x30
[  182.617761]  </TASK>
[  182.617968] ---[ end trace 0000000000000000 ]---
[  182.618412] Emergency Thaw complete

Fix this by switching to SUPER_ITER_UNLOCKED and acquiring s_umount
in the callback via super_lock_excl() before calling
thaw_super_locked(). This matches the locking pattern expected by
thaw_super_locked() and eliminates the double unlock.

While at it, remove the dead 'return;' at the end of
do_thaw_all_callback().

Fixes: b47e42d10e8c ("super: use common iterator (Part 2)")
Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
---
 fs/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index a8fd61136aaf..70dcb07e7fa5 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1084,16 +1084,19 @@ void emergency_remount(void)
 
 static void do_thaw_all_callback(struct super_block *sb, void *unused)
 {
+	if (!super_lock_excl(sb))
+		return;
+
 	if (IS_ENABLED(CONFIG_BLOCK))
 		while (sb->s_bdev && !bdev_thaw(sb->s_bdev))
 			pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
+
 	thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE, NULL);
-	return;
 }
 
 static void do_thaw_all(struct work_struct *work)
 {
-	__iterate_supers(do_thaw_all_callback, NULL, SUPER_ITER_EXCL);
+	__iterate_supers(do_thaw_all_callback, NULL, SUPER_ITER_UNLOCKED);
 	kfree(work);
 	printk(KERN_WARNING "Emergency Thaw complete\n");
 }
-- 
2.25.1

