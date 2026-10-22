Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708421;
	b=ADgOYTVEjrJeP/ZgJsNlGV3RgWau/qUfaSqIpuF68uYhU00Ju4FyFBxuw/RAaQiP5iX+
	 ScyuYQIWboXW8oaIAvwcMpuTuZPRCaN9FNTveQlYx5Dkp7NczSvwf9m7HLWQDJOF563dn
	 La/EUYj8PBwGF+SuMBfGY04GCiPbeZsQ9t5Vi/t3H8OEaFnH0+PueZb5SA08Bent5bOI3
	 ILrhcXkYvzD17yXt7188IdH+PcfZHBGHUaCmf1Nli9HVJSVloneIXMegzN62O37mgg8JF
	 rOApp2mOrQ0nhDAeXCNkNwpzB5NW4N2HrQrkNq/RSOXj2J4LopPGlm6jYhl9ncA/I+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708421;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=2YhGmICq4X0jtn4PR3OTh5SkzrcHalK2T3Oao0NE/oU=;
	b=s52NvV6x/J4IHRLqHe8F4dV59+EKHO1hAS5COOSGjBEp11/icVVlkVvyEJKmQoP2dizV
	 iqYqcgDRpyw7qvVV/2Ti73RROH6Qd8tdV4hTOWZBIKRyRUOjoygbqk6AejqZph5Xg+Xt7
	 5EoU7NHtATn/nYb+Kzn9BQ8VohTwzKyNSAGnS44s7O/wQnm7TjeGwcQGgK6Ld4VdeF9gt
	 PwoTStFZ/g/EGJkKJvMexiD6VEJf/gKXi7yzaMO33r8vd/MKvcz1qklPqSLk6jLypZXSd
	 4jyKRdTk7UJqZBYaaNWmXddclCUrm0VSlyb4juVE1rGNK6FMnaQF7yAGA4Jd8/yjudQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.70
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96F5606A31A
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 22:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C96F5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-82315dbce25so151425a34.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 15:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792708420; x=1793313220;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2YhGmICq4X0jtn4PR3OTh5SkzrcHalK2T3Oao0NE/oU=;
        b=coRyta/5EsG+AvkcvXg3vYxmI3VA+SxP+a6rWY0ttniM3cSNVZpOJ4Hl/ZTMXzSnhy
         ZaLmMMbfd2xYrEBF4an6Y0hnDumVFwTqtcuUOyyJUFCmkgePb/aFZm0f2NMk9HEbkMzV
         vFSAJ6y2FDpEJCaTYKoovfy3brr7aXs+aB/jt0Vtt8JoKm4wBIk3b4r+5PuX8/kcYxRR
         ciyPCkA9UKpd0hluKnxevU87bm1z68xFV7+Sxa9KHwWHrytO7R/9dMVZS4r4oBYRI21r
         VtVjxJYqZq9BPJYTED8uwoJ73/HNgh1OkYBiYeGldvUCWsObSMKqH8JH5N5SaRsrnpvv
         Xtug==
X-Forwarded-Encrypted: i=1; AKwUvBzar3aTgxtQbs9M3eNH/UbaCJegWKjGPqZ+xv0o4ocffbxpYWlvxVBedMLfXWewwAGtVD4LPCFklVL6ZImG@vger.kernel.org
X-Gm-Message-State: AFq9FYLYp5svY8w4CETlg5oDnSvR+laYDQetvRgBk5PPqvd1dOdqZ6Z/
	srMhSwAtULL66LsfZmFNeXs4i1i5cf7jfDX5iFHgN4WXi1CBIRaSlZIl3P3kPHUo2ydLTrZ6JmU
	wslhWNucRfOW8t6FsSxgkl8mFEIX2fGsUgXtZCDvbHSymKSyMh+RcUGvoMRk=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1209:b0:4c4:9f7e:92ce with SMTP id
 5614622812f47-55be85c1e6fmr338343b6e.38.1792708419882; Thu, 22 Oct 2026
 15:33:39 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:33:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ada8f43.d1c214cc.659fa.00e0.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in v2_write_dquot
From: syzbot <syzbot+75d986c18cef4710fc85@syzkaller.appspotmail.com>
To: jack@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a0ff06b3a7bd Merge tag 'firewire-fixes-7.3-final' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a993a9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4b098695335c89f
dashboard link: https://syzkaller.appspot.com/bug?extid=75d986c18cef4710fc85
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2a3b826702d4/disk-a0ff06b3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6b5a43d8b46c/vmlinux-a0ff06b3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3a84903a147f/bzImage-a0ff06b3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+75d986c18cef4710fc85@syzkaller.appspotmail.com

EXT4-fs (loop5): mounted filesystem 00000000-0000-0000-0000-000000000000 r/w without journal. Quota mode: writeback.
ext4 filesystem being mounted at /1334/file0 supports timestamps until 2038-01-19 (0x7fffffff)
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.5.7752/28220 is trying to acquire lock:
ffff8880535c6248 (&s->s_dquot.dqio_sem){++++}-{4:4}, at: v2_write_dquot+0xab/0x260 fs/quota/quota_v2.c:367

but task is already holding lock:
ffff88805537bca0 (&dquot->dq_lock){+.+.}-{4:4}, at: dquot_acquire+0x67/0x620 fs/quota/dquot.c:486

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #9 (&dquot->dq_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       wait_on_dquot fs/quota/dquot.c:357 [inline]
       dqget+0x69d/0xbd0 fs/quota/dquot.c:997
       __dquot_initialize+0x3c8/0xd40 fs/quota/dquot.c:1462
       __ext4_new_inode+0x7ed/0x3ec0 fs/ext4/ialloc.c:1004
       ext4_xattr_inode_create fs/ext4/xattr.c:1494 [inline]
       ext4_xattr_inode_lookup_create+0xb1e/0x1d70 fs/ext4/xattr.c:1604
       ext4_xattr_block_set+0x223/0x29a0 fs/ext4/xattr.c:1924
       ext4_xattr_set_handle+0xed9/0x15f0 fs/ext4/xattr.c:2461
       ext4_xattr_set+0x257/0x340 fs/ext4/xattr.c:2563
       __vfs_setxattr+0x442/0x480 fs/xattr.c:223
       __vfs_setxattr_noperm+0x12a/0x660 fs/xattr.c:257
       vfs_setxattr+0x163/0x360 fs/xattr.c:344
       do_setxattr fs/xattr.c:662 [inline]
       filename_setxattr+0x296/0x630 fs/xattr.c:690
       path_setxattrat+0x408/0x450 fs/xattr.c:734
       __do_sys_setxattr fs/xattr.c:768 [inline]
       __se_sys_setxattr fs/xattr.c:764 [inline]
       __x64_sys_setxattr+0xbc/0xe0 fs/xattr.c:764
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #8 (&ei->xattr_sem){++++}-{4:4}:
       down_write+0x96/0x200 kernel/locking/rwsem.c:1631
       ext4_write_lock_xattr fs/ext4/xattr.h:152 [inline]
       ext4_inline_data_truncate+0x1cf/0xbd0 fs/ext4/inline.c:1882
       ext4_truncate+0x444/0x1110 fs/ext4/inode.c:4650
       ext4_setattr+0x1147/0x1df0 fs/ext4/inode.c:6220
       notify_change+0xbba/0xea0 fs/attr.c:556
       do_truncate+0x1c2/0x250 fs/open.c:68
       handle_truncate fs/namei.c:4300 [inline]
       do_open fs/namei.c:4840 [inline]
       path_openat+0x185e/0x2090 fs/namei.c:4999
       do_file_open+0x23e/0x4a0 fs/namei.c:5028
       do_sys_openat2+0x115/0x200 fs/open.c:1417
       do_sys_open fs/open.c:1423 [inline]
       __do_sys_creat fs/open.c:1501 [inline]
       __se_sys_creat fs/open.c:1495 [inline]
       __x64_sys_creat+0x8f/0xc0 fs/open.c:1495
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #7 (mapping.invalidate_lock#2){++++}-{4:4}:
       down_read+0x4a/0x330 kernel/locking/rwsem.c:1574
       filemap_invalidate_lock_shared include/linux/fs.h:1089 [inline]
       do_page_cache_ra mm/readahead.c:347 [inline]
       page_cache_ra_order+0xb37/0xee0 mm/readahead.c:558
       do_sync_mmap_readahead+0x75e/0x990 mm/filemap.c:3443
       filemap_fault+0x7d9/0x13b0 mm/filemap.c:3597
       __do_fault+0x138/0x2a0 mm/memory.c:5565
       do_read_fault mm/memory.c:6000 [inline]
       do_fault mm/memory.c:6134 [inline]
       do_pte_missing+0x2215/0x34b0 mm/memory.c:4700
       handle_pte_fault mm/memory.c:6558 [inline]
       __handle_mm_fault mm/memory.c:6707 [inline]
       handle_mm_fault+0x1a53/0x3750 mm/memory.c:6876
       do_user_addr_fault+0x746/0x1340 arch/x86/mm/fault.c:1394
       handle_page_fault arch/x86/mm/fault.c:1483 [inline]
       exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1536
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:595
       copy_user_generic arch/x86/include/asm/uaccess_64.h:126 [inline]
       raw_copy_from_user arch/x86/include/asm/uaccess_64.h:141 [inline]
       copy_from_user_iter lib/iov_iter.c:67 [inline]
       iterate_ubuf include/linux/iov_iter.h:30 [inline]
       iterate_and_advance2 include/linux/iov_iter.h:302 [inline]
       iterate_and_advance include/linux/iov_iter.h:330 [inline]
       __copy_from_iter lib/iov_iter.c:261 [inline]
       _copy_from_iter+0x216/0x1660 lib/iov_iter.c:272
       copy_from_iter include/linux/uio.h:228 [inline]
       copy_from_iter_full include/linux/uio.h:245 [inline]
       skb_do_copy_data_nocache include/net/sock.h:2329 [inline]
       skb_copy_to_page_nocache include/net/sock.h:2355 [inline]
       tcp_sendmsg_locked+0x20cf/0x5400 net/ipv4/tcp.c:1310
       tcp_sendmsg+0x2f/0x50 net/ipv4/tcp.c:1451
       sock_sendmsg_nosec+0x10e/0x180 net/socket.c:801
       __sock_sendmsg net/socket.c:815 [inline]
       sock_write_iter+0x2de/0x3e0 net/socket.c:1266
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x612/0xba0 fs/read_write.c:687
       ksys_write+0x150/0x270 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_sock_nested+0x41/0x100 net/core/sock.c:3837
       lock_sock include/net/sock.h:1713 [inline]
       inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:913
       nbd_mark_nsock_dead+0x2cb/0x550 drivers/block/nbd.c:319
       recv_work+0x1cee/0x1e10 drivers/block/nbd.c:1030
       process_one_work kernel/workqueue.c:3396 [inline]
       process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #5 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
       nbd_queue_rq+0x373/0xff0 drivers/block/nbd.c:1207
       blk_mq_dispatch_rq_list+0x499/0x1990 block/blk-mq.c:2130
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xd36/0x1580 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_work_fn+0x16c/0x300 block/blk-mq.c:2545
       process_one_work kernel/workqueue.c:3396 [inline]
       process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #4 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       nbd_queue_rq+0xc1/0xff0 drivers/block/nbd.c:1199
       blk_mq_dispatch_rq_list+0x499/0x1990 block/blk-mq.c:2130
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xd36/0x1580 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_work_fn+0x16c/0x300 block/blk-mq.c:2545
       process_one_work kernel/workqueue.c:3396 [inline]
       process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3479
       worker_thread+0xa47/0xfb0 kernel/workqueue.c:3560
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #3 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:210 [inline]
       __synchronize_srcu+0xc9/0x2f0 kernel/rcu/srcutree.c:1462
       elevator_switch+0x1e8/0x7b0 block/elevator.c:576
       elevator_change+0x2fa/0x480 block/elevator.c:681
       elevator_set_default+0x375/0x440 block/elevator.c:754
       blk_register_queue+0x3f3/0x4e0 block/blk-sysfs.c:992
       __add_disk+0x6b8/0xdb0 block/genhd.c:531
       add_disk_fwnode+0x100/0x3a0 block/genhd.c:600
       add_disk include/linux/blkdev.h:798 [inline]
       nbd_dev_add+0x733/0xb60 drivers/block/nbd.c:2026
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2743
       do_one_initcall+0x250/0x870 init/main.c:1362
       do_initcall_level+0x10a/0x1a0 init/main.c:1424
       do_initcalls+0x59/0xa0 init/main.c:1440
       kernel_init_freeable+0x29d/0x3e0 init/main.c:1675
       kernel_init+0x22/0x1d0 init/main.c:1565
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       elevator_change+0x1af/0x480 block/elevator.c:679
       elv_iosched_store+0x504/0x630 block/elevator.c:826
       queue_attr_store+0x207/0x2b0 block/blk-sysfs.c:906
       kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x612/0xba0 fs/read_write.c:687
       ksys_write+0x150/0x270 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&q->q_usage_counter(io)#17){++++}-{0:0}:
       bio_queue_enter block/blk.h:95 [inline]
       blk_mq_submit_bio+0x7a7/0x2bb0 block/blk-mq.c:3138
       __submit_bio_noacct_mq block/blk-core.c:756 [inline]
       submit_bio_noacct_nocheck+0x2f4/0xa40 block/blk-core.c:790
       __ext4_read_bh fs/ext4/super.c:181 [inline]
       ext4_read_bh+0x182/0x230 fs/ext4/super.c:206
       ext4_bread+0x12d/0x180 fs/ext4/inode.c:1060
       ext4_quota_read+0x189/0x390 fs/ext4/super.c:7397
       read_blk fs/quota/quota_tree.c:61 [inline]
       find_tree_dqentry+0x1fc/0x1090 fs/quota/quota_tree.c:671
       find_tree_dqentry+0x6c0/0x1090 fs/quota/quota_tree.c:698
       find_tree_dqentry+0x6c0/0x1090 fs/quota/quota_tree.c:698
       find_tree_dqentry+0x6c0/0x1090 fs/quota/quota_tree.c:698
       find_dqentry fs/quota/quota_tree.c:716 [inline]
       qtree_read_dquot+0x5ac/0x8a0 fs/quota/quota_tree.c:736
       v2_read_dquot+0x117/0x1d0 fs/quota/quota_v2.c:344
       dquot_acquire+0x183/0x620 fs/quota/dquot.c:489
       ext4_acquire_dquot+0x2f0/0x4e0 fs/ext4/super.c:7075
       dqget+0x725/0xbd0 fs/quota/dquot.c:1002
       __dquot_initialize+0x33a/0xd40 fs/quota/dquot.c:1462
       ext4_rename fs/ext4/namei.c:3831 [inline]
       ext4_rename2+0x758/0x3270 fs/ext4/namei.c:4218
       vfs_rename+0xbd9/0xef0 fs/namei.c:6207
       filename_renameat2+0x533/0x9a0 fs/namei.c:6325
       __do_sys_renameat2 fs/namei.c:6354 [inline]
       __se_sys_renameat2+0x5a/0x2c0 fs/namei.c:6349
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&s->s_dquot.dqio_sem){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3209 [inline]
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
       down_write+0x96/0x200 kernel/locking/rwsem.c:1631
       v2_write_dquot+0xab/0x260 fs/quota/quota_v2.c:367
       dquot_acquire+0x328/0x620 fs/quota/dquot.c:498
       ext4_acquire_dquot+0x2f0/0x4e0 fs/ext4/super.c:7075
       dqget+0x725/0xbd0 fs/quota/dquot.c:1002
       dquot_set_dqblk+0x2b/0xfd0 fs/quota/dquot.c:2777
       quota_setquota+0x4e0/0x590 fs/quota/quota.c:310
       __do_sys_quotactl fs/quota/quota.c:961 [inline]
       __se_sys_quotactl+0x2cc/0x9f0 fs/quota/quota.c:917
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &s->s_dquot.dqio_sem --> &ei->xattr_sem --> &dquot->dq_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&dquot->dq_lock);
                               lock(&ei->xattr_sem);
                               lock(&dquot->dq_lock);
  lock(&s->s_dquot.dqio_sem);

 *** DEADLOCK ***

locks held by syz.5.7752/28220: 2, last CPU#0:
 #0: ffff8880535c60e8 (&type->s_umount_key#33){++++}-{4:4}, at: __super_lock fs/super.c:62 [inline]
 #0: ffff8880535c60e8 (&type->s_umount_key#33){++++}-{4:4}, at: super_lock+0x2d6/0x3d0 fs/super.c:124
 #1: ffff88805537bca0 (&dquot->dq_lock){+.+.}-{4:4}, at: dquot_acquire+0x67/0x620 fs/quota/dquot.c:486

stack backtrace:
CPU: 0 UID: 0 PID: 28220 Comm: syz.5.7752 Tainted: G             L      syzkaller #0 PREEMPT(lazy) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2087
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2219
 check_prev_add kernel/locking/lockdep.c:3209 [inline]
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 down_write+0x96/0x200 kernel/locking/rwsem.c:1631
 v2_write_dquot+0xab/0x260 fs/quota/quota_v2.c:367
 dquot_acquire+0x328/0x620 fs/quota/dquot.c:498
 ext4_acquire_dquot+0x2f0/0x4e0 fs/ext4/super.c:7075
 dqget+0x725/0xbd0 fs/quota/dquot.c:1002
 dquot_set_dqblk+0x2b/0xfd0 fs/quota/dquot.c:2777
 quota_setquota+0x4e0/0x590 fs/quota/quota.c:310
 __do_sys_quotactl fs/quota/quota.c:961 [inline]
 __se_sys_quotactl+0x2cc/0x9f0 fs/quota/quota.c:917
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffb1039e559
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffb11205028 EFLAGS: 00000246 ORIG_RAX: 00000000000000b3
RAX: ffffffffffffffda RBX: 00007ffb10625fa0 RCX: 00007ffb1039e559
RDX: 0000000000000000 RSI: 0000200000000000 RDI: ffffffff80000801
RBP: 00007ffb10435ab8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000200000000100 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffb10626038 R14: 00007ffb10625fa0 R15: 00007fff0c429e18
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
