Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312E641DDE5
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699188; cv=none; b=rKZUCRVr7bk8pR+6bIMbJRHM84kHTYLVfMl2Q1BlsUKy+qIQGyKsyNXxaWFwdguk0up17uKqOIGcPg7BZRz6PxuO0pIhjH/OtggT0gk0RWwR7KKI4Wk7JUAyhbpNwzyeQrZmL8nn8cgKIQQvcQNu91Tf0/2yIHgPhY7uXpPjTQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699188; c=relaxed/simple;
	bh=BlhSMIN+mmE8n9nN/akGDcUnE3P6L8FRrfFSuq9fGG0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WRCZ33U+1w/HKguM6mCuLNia0Dx/tc9Oj0jcNR92EpUCD+IBs7mDBh80xOIQKNOumr3FmgS5h4BPPALTu5KyVJrbk+Uj97ofoK4YL9WXw33YBTqiFSlgVbFA+JTUkOYtOalswQVhbLXOzAq2uwTdOZlWZ4r2tCTYLq0RGCqf72E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4b19ce23e5cso449648b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 02:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786699185; x=1787303985;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YBo660HfkNsRnj5eBwAkX1v/L2lPZlVGJtLQYSokVrk=;
        b=qQn+WwC6raGgq86FDihaj/rc9nS/CDBxkzd7EXcrFo5RbhBAm/2ChoUyDBJgBN+FPD
         lp6ezB6suJJP3WUlNaBQ/F4i3ISwxc9voY0QSA/YWONfzPRRFYaaGvvVyTVpF4IoOrlj
         xdn/1UkCY7EdRlMIOyQKeXSDXBSeh6IzpsZ0wLr1Tgcj6Jp6r4cbVkCt5Lxij+RXx1do
         xrL/I/32Ylied8tva202y06XbBQcjtt5Pn7RwseO/sZuKHTQp2LuVGZna3vznp7peZ9J
         RYYQQXKZ5kD6Vu+LksuLy19c4C9WZeQQknlcLKiEzKnAcc8QgL9c9bKCjeD/D4N7A+Is
         dEtQ==
X-Gm-Message-State: AOJu0Yyk8Up3aPhRjvImZq3/WfnsfMtLSeDG/ME3p61OVwgx5j3YD8pq
	piOj65OFjeKYy2WUXnFtQpjdhf5fDNIGtWLYG7hROSQFqtSZ1PH6faHuCwG3twDfxO0OCoW5t8u
	wSZfbQAJWdowvQxLBi5VPAZX5/UIJnfvU7lpW/YVxlZghtCjdPIum50mLl1I=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c84:b0:6b0:1b86:fa8 with SMTP id
 006d021491bc7-6b0d61f1e39mr3369133eaf.15.1786699185038; Fri, 14 Aug 2026
 02:19:45 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:19:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7eddb1.dbb3a75c.20434b.0003.GAE@google.com>
Subject: [syzbot] [fs?] BUG: sleeping function called from invalid context in null_process_zoned_cmd
From: syzbot <syzbot+b6fd00508cc05a5c003c@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f1baf1fc892 Merge tag 'trace-v7.2-rc7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10498a25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=b6fd00508cc05a5c003c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1715f149580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6fd00508cc05a5c003c@syzkaller.appspotmail.com

null_blk: mydev: using native zone append
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:623
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 6035, name: syz-executor507
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
6 locks held by syz-executor507/6035:
 #0: ffff888023e9e450 (sb_writers#13){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff8880385e1080 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x76/0x4e0 fs/configfs/file.c:226
 #2: ffff88802ca06570 (&p->frag_sem){.+.+}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
 #2: ffff88802ca06570 (&p->frag_sem){.+.+}-{4:4}, at: configfs_write_iter+0x218/0x4e0 fs/configfs/file.c:229
 #3: ffffffff9ba14a40 (&lock){+.+.}-{4:4}, at: nullb_device_power_store+0xde/0x350 drivers/block/null_blk/main.c:496
 #4: ffff888045820350 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0x41a/0xe40 block/bdev.c:948
 #5: ffffffff8ebe8200 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #5: ffffffff8ebe8200 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #5: ffffffff8ebe8200 (rcu_read_lock){....}-{1:3}, at: blk_mq_submit_bio+0x21b2/0x3000 block/blk-mq.c:3208
CPU: 3 UID: 0 PID: 6035 Comm: syz-executor507 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 __might_resched.cold+0x1ec/0x232 kernel/sched/core.c:9197
 __mutex_lock_common kernel/locking/mutex.c:623 [inline]
 __mutex_lock+0x10e/0x1bd0 kernel/locking/mutex.c:821
 null_lock_zone drivers/block/null_blk/zoned.c:39 [inline]
 null_lock_zone drivers/block/null_blk/zoned.c:33 [inline]
 null_process_zoned_cmd+0x943/0x10a0 drivers/block/null_blk/zoned.c:732
 null_handle_cmd drivers/block/null_blk/main.c:1455 [inline]
 null_queue_rq+0x664/0xfb0 drivers/block/null_blk/main.c:1703
 __blk_mq_issue_directly+0xe2/0x200 block/blk-mq.c:2694
 blk_mq_try_issue_directly+0x21b/0x420 block/blk-mq.c:2754
 blk_mq_submit_bio+0x21ec/0x3000 block/blk-mq.c:3208
 __submit_bio+0x90/0x3d0 block/blk-core.c:673
 __submit_bio_noacct_mq block/blk-core.c:756 [inline]
 submit_bio_noacct_nocheck+0x549/0xc00 block/blk-core.c:790
 submit_bio_noacct+0xd18/0x1ff0 block/blk-core.c:921
 blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
 __bh_submit+0x721/0x950 fs/buffer.c:1225
 bh_submit fs/buffer.c:1239 [inline]
 block_read_full_folio+0x496/0x8c0 fs/buffer.c:2463
 filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2516
 do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4146
 read_mapping_folio include/linux/pagemap.h:1015 [inline]
 read_part_sector+0xd1/0x370 block/partitions/core.c:724
 adfspart_check_ICS+0x91/0x7d0 block/partitions/acorn.c:357
 check_partition block/partitions/core.c:143 [inline]
 blk_add_partitions block/partitions/core.c:591 [inline]
 bdev_disk_changed+0x7b1/0x1260 block/partitions/core.c:695
 blkdev_get_whole+0x187/0x290 block/bdev.c:751
 bdev_open+0x2c7/0xe40 block/bdev.c:960
 bdev_file_open_by_dev block/bdev.c:1062 [inline]
 bdev_file_open_by_dev+0x179/0x210 block/bdev.c:1037
 disk_scan_partitions+0x1ef/0x320 block/genhd.c:387
 add_disk_final block/genhd.c:412 [inline]
 add_disk_fwnode+0x3f4/0x480 block/genhd.c:606
 add_disk include/linux/blkdev.h:800 [inline]
 null_add_dev+0x129d/0x1df0 drivers/block/null_blk/main.c:2052
 nullb_device_power_store+0x29d/0x350 drivers/block/null_blk/main.c:501
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdede8c12f7
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffc5fd85ed0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000055557028a400 RCX: 00007fdede8c12f7
RDX: 0000000000000002 RSI: 00007fdede8fa060 RDI: 0000000000000003
RBP: 00007fdede8fa060 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fdede8fc238
R13: 0000000000000002 R14: 00007fdede924cc0 R15: 0000000000000002
 </TASK>

=============================
[ BUG: Invalid wait context ]
syzkaller #0 Tainted: G        W          
-----------------------------
syz-executor507/6035 is trying to lock:
ffff8880455c0060 (&zone->mutex){+.+.}-{4:4}, at: null_lock_zone drivers/block/null_blk/zoned.c:39 [inline]
ffff8880455c0060 (&zone->mutex){+.+.}-{4:4}, at: null_lock_zone drivers/block/null_blk/zoned.c:33 [inline]
ffff8880455c0060 (&zone->mutex){+.+.}-{4:4}, at: null_process_zoned_cmd+0x943/0x10a0 drivers/block/null_blk/zoned.c:732
other info that might help us debug this:
context-{5:5}
6 locks held by syz-executor507/6035:
 #0: ffff888023e9e450 (sb_writers#13){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff8880385e1080 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x76/0x4e0 fs/configfs/file.c:226
 #2: ffff88802ca06570 (&p->frag_sem){.+.+}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
 #2: ffff88802ca06570 (&p->frag_sem){.+.+}-{4:4}, at: configfs_write_iter+0x218/0x4e0 fs/configfs/file.c:229
 #3: ffffffff9ba14a40 (&lock){+.+.}-{4:4}, at: nullb_device_power_store+0xde/0x350 drivers/block/null_blk/main.c:496
 #4: ffff888045820350 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_open+0x41a/0xe40 block/bdev.c:948
 #5: ffffffff8ebe8200 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #5: ffffffff8ebe8200 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #5: ffffffff8ebe8200 (rcu_read_lock){....}-{1:3}, at: blk_mq_submit_bio+0x21b2/0x3000 block/blk-mq.c:3208
stack backtrace:
CPU: 3 UID: 0 PID: 6035 Comm: syz-executor507 Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4830 [inline]
 check_wait_context kernel/locking/lockdep.c:4902 [inline]
 __lock_acquire+0xf75/0x1a40 kernel/locking/lockdep.c:5187
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
 null_lock_zone drivers/block/null_blk/zoned.c:39 [inline]
 null_lock_zone drivers/block/null_blk/zoned.c:33 [inline]
 null_process_zoned_cmd+0x943/0x10a0 drivers/block/null_blk/zoned.c:732
 null_handle_cmd drivers/block/null_blk/main.c:1455 [inline]
 null_queue_rq+0x664/0xfb0 drivers/block/null_blk/main.c:1703
 __blk_mq_issue_directly+0xe2/0x200 block/blk-mq.c:2694
 blk_mq_try_issue_directly+0x21b/0x420 block/blk-mq.c:2754
 blk_mq_submit_bio+0x21ec/0x3000 block/blk-mq.c:3208
 __submit_bio+0x90/0x3d0 block/blk-core.c:673
 __submit_bio_noacct_mq block/blk-core.c:756 [inline]
 submit_bio_noacct_nocheck+0x549/0xc00 block/blk-core.c:790
 submit_bio_noacct+0xd18/0x1ff0 block/blk-core.c:921
 blk_crypto_submit_bio include/linux/blk-crypto.h:203 [inline]
 __bh_submit+0x721/0x950 fs/buffer.c:1225
 bh_submit fs/buffer.c:1239 [inline]
 block_read_full_folio+0x496/0x8c0 fs/buffer.c:2463
 filemap_read_folio+0xfc/0x3b0 mm/filemap.c:2516
 do_read_cache_folio+0x2d7/0x6b0 mm/filemap.c:4146
 read_mapping_folio include/linux/pagemap.h:1015 [inline]
 read_part_sector+0xd1/0x370 block/partitions/core.c:724
 adfspart_check_ICS+0x91/0x7d0 block/partitions/acorn.c:357
 check_partition block/partitions/core.c:143 [inline]
 blk_add_partitions block/partitions/core.c:591 [inline]
 bdev_disk_changed+0x7b1/0x1260 block/partitions/core.c:695
 blkdev_get_whole+0x187/0x290 block/bdev.c:751
 bdev_open+0x2c7/0xe40 block/bdev.c:960
 bdev_file_open_by_dev block/bdev.c:1062 [inline]
 bdev_file_open_by_dev+0x179/0x210 block/bdev.c:1037
 disk_scan_partitions+0x1ef/0x320 block/genhd.c:387
 add_disk_final block/genhd.c:412 [inline]
 add_disk_fwnode+0x3f4/0x480 block/genhd.c:606
 add_disk include/linux/blkdev.h:800 [inline]
 null_add_dev+0x129d/0x1df0 drivers/block/null_blk/main.c:2052
 nullb_device_power_store+0x29d/0x350 drivers/block/null_blk/main.c:501
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdede8c12f7
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffc5fd85ed0 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000055557028a400 RCX: 00007fdede8c12f7
RDX: 0000000000000002 RSI: 00007fdede8fa060 RDI: 0000000000000003
RBP: 00007fdede8fa060 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007fdede8fc238
R13: 0000000000000002 R14: 00007fdede924cc0 R15: 0000000000000002
 </TASK>
null_blk: disk mydev created


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
