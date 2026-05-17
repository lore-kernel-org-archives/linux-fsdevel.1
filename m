Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE02D8DC3
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 11:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779016351; cv=none; b=EYWsANLcAWypz6laQfnj5jr2MKvAyC2EQ80+OHUyLq4a/+DqowgKOjwyRvyu32IRZ71N63CAxRVbhBekdF2fe5d8O3Tt267+7S8PTZDo/6VoTebacDymutPKI3zr3V8iVg/vlvXvDgxHpsNiyyz+ibkdzeH8+vbzYEHBtJ13YyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779016351; c=relaxed/simple;
	bh=qHUa4o1dbUb4d0OqeHtqsHcXy3WzFL/0woDpCQRzLgs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rVWfnl+kaxJiqrTbzPxXFubsPmTdXC9KiNQiSxCODv4ghwJCubEI27a03bgKqLBslfafbnScNnSXzsMeBybNJ3BrQyYZWDIbiGAVSsnrbHTlfkuvLNH3MYvV9+Q7IV7WdfP/GqTWRToInOkQb8UnuTCL1e05T5jgr5gUMgsqbaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6967fe3eeb1so1218551eaf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 04:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779016348; x=1779621148;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+fjLBiKEHLBRPEaTz5NraYkWeoX31Di+HZhKCV7pkU=;
        b=bmQNa7/Fj1Lv3but4IhKkkrm1XbgN09I8A1Y1zXoN50DqmqKr4nBJiO++fFCC2Ss52
         fQz/Sqs9IGHdW0Dnn0BVW8GbJh1QNHutHhp9/hj7WX+HA6hZ9CaJEESuveyNGe1m45jm
         sot52KU1brqQuYKbEF+is3DLs9sO8ri0eJ/VQSxapKan+K0hwu+l3rnHCmdgocVWP4Yv
         zAgb/+LQaaGiSPkIoJKlnHlZrBWtV0WyXDhf6V7XZOy+/WvMXwV+iYAn5FDA+XQFRpnf
         7UZaIpns7kOhgOciL1p9Ff5sxtzBBNpH78HtbYessjLg8ZX5l7h4jRUnOJUpUjtvPmaN
         rT7A==
X-Forwarded-Encrypted: i=1; AFNElJ/qVdDb/NJ1vlCxlhlkOeDsCZ5TSp/2Mtp/mdZBEt2Ee8Gp0DdRhjg28I+zcBnQFothp19QkaqXhdshRtgI@vger.kernel.org
X-Gm-Message-State: AOJu0YyXOyalVejgZD+xsq62GitGVMm5USrOZd4iE99aM0AW7YRmefnc
	DH+gqJODX6QKXqXeTDA/1uW12V7o9gdGzAc3Mu/LaGMqB82LBfITNrXLiJ/CAPraprXgRgYaO7u
	dJT7duwNlFXkVurmCAXzIuin7R+auyLAEQaUxMuGWJSzf8llT6Ea/v1GlTOQ=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee08:0:b0:695:818c:e552 with SMTP id
 006d021491bc7-69c9c05b9c9mr6671280eaf.55.1779016348296; Sun, 17 May 2026
 04:12:28 -0700 (PDT)
Date: Sun, 17 May 2026 04:12:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a09a29c.a00a0220.300e5b.0007.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] possible deadlock in hugetlbfs_fallocate
From: syzbot <syzbot+822094e2aeaa27ebdc24@syzkaller.appspotmail.com>
To: david@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev, 
	osalvador@suse.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1d5dcaa3bd65 Merge tag 'probes-fixes-v7.1-rc3' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b44fce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0
dashboard link: https://syzkaller.appspot.com/bug?extid=822094e2aeaa27ebdc24
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/01f00470052a/disk-1d5dcaa3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fa5a4ec855b2/vmlinux-1d5dcaa3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/518a4030a9e5/bzImage-1d5dcaa3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+822094e2aeaa27ebdc24@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.1.1475/9895 is trying to acquire lock:
ffff8880202ca280 (&hugetlb_fault_mutex_table[i]){+.+.}-{4:4}, at: hugetlbfs_fallocate+0x7f9/0x1180 fs/hugetlbfs/inode.c:795

but task is already holding lock:
ffff88801b3314a0 (&sb->s_type->i_mutex_key#29){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1029 [inline]
ffff88801b3314a0 (&sb->s_type->i_mutex_key#29){+.+.}-{4:4}, at: hugetlbfs_fallocate+0x2f0/0x1180 fs/hugetlbfs/inode.c:751

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #9 (&sb->s_type->i_mutex_key#29){+.+.}-{4:4}:
       down_write+0x96/0x200 kernel/locking/rwsem.c:1625
       inode_lock include/linux/fs.h:1029 [inline]
       hugetlbfs_file_mmap_prepare+0x319/0x6c0 fs/hugetlbfs/inode.c:146
       vfs_mmap_prepare include/linux/fs.h:2076 [inline]
       call_mmap_prepare mm/vma.c:2672 [inline]
       __mmap_region mm/vma.c:2755 [inline]
       mmap_region+0xe8f/0x22a0 mm/vma.c:2857
       do_mmap+0xc39/0x10c0 mm/mmap.c:560
       vm_mmap_pgoff+0x2c9/0x4f0 mm/util.c:581
       ksys_mmap_pgoff+0x586/0x760 mm/mmap.c:606
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #8 (&mm->mmap_lock){++++}-{4:4}:
       __might_fault+0xcb/0x130 mm/memory.c:7324
       _inline_copy_from_user include/linux/uaccess.h:169 [inline]
       _copy_from_user+0x28/0xb0 lib/usercopy.c:18
       copy_from_user include/linux/uaccess.h:223 [inline]
       csum_and_copy_from_user include/net/checksum.h:31 [inline]
       copy_from_user_iter_csum net/core/skbuff.c:7402 [inline]
       iterate_ubuf include/linux/iov_iter.h:30 [inline]
       iterate_and_advance2 include/linux/iov_iter.h:302 [inline]
       csum_and_copy_from_iter_full+0x1e7/0x1f00 net/core/skbuff.c:7414
       ip_generic_getfrag+0x149/0x2d0 net/ipv4/ip_output.c:942
       __ip6_append_data+0x39cd/0x3f60 net/ipv6/ip6_output.c:1736
       ip6_append_data+0x10f/0x280 net/ipv6/ip6_output.c:1891
       rawv6_sendmsg+0x12d3/0x18e0 net/ipv6/raw.c:913
       sock_sendmsg_nosec net/socket.c:787 [inline]
       __sock_sendmsg net/socket.c:802 [inline]
       ____sys_sendmsg+0x80a/0x9f0 net/socket.c:2698
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
       __sys_sendmsg net/socket.c:2784 [inline]
       __do_sys_sendmsg net/socket.c:2789 [inline]
       __se_sys_sendmsg net/socket.c:2787 [inline]
       __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #7 (sk_lock-AF_INET6){+.+.}-{0:0}:
       lock_sock_nested+0x41/0x100 net/core/sock.c:3783
       lock_sock include/net/sock.h:1713 [inline]
       inet_shutdown+0x6a/0x390 net/ipv4/af_inet.c:915
       nbd_mark_nsock_dead+0x2e9/0x560 drivers/block/nbd.c:318
       sock_shutdown+0x15e/0x260 drivers/block/nbd.c:411
       nbd_clear_sock+0x24/0x170 drivers/block/nbd.c:1427
       nbd_config_put+0x2dd/0x580 drivers/block/nbd.c:1451
       nbd_genl_connect+0x19d5/0x1cf0 drivers/block/nbd.c:2248
       genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:787 [inline]
       __sock_sendmsg net/socket.c:802 [inline]
       ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
       __sys_sendmsg net/socket.c:2784 [inline]
       __do_sys_sendmsg net/socket.c:2789 [inline]
       __se_sys_sendmsg net/socket.c:2787 [inline]
       __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #6 (&nsock->tx_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a3/0x1550 kernel/locking/mutex.c:820
       nbd_handle_cmd drivers/block/nbd.c:1143 [inline]
       nbd_queue_rq+0x37b/0x1100 drivers/block/nbd.c:1207
       blk_mq_dispatch_rq_list+0xa70/0x1910 block/blk-mq.c:2148
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xdcc/0x1600 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2386
       blk_mq_dispatch_list+0xd16/0xe10 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x48d/0x570 block/blk-mq.c:2997
       __blk_flush_plug+0x3ed/0x4d0 block/blk-core.c:1230
       blk_finish_plug block/blk-core.c:1257 [inline]
       __submit_bio+0x28d/0x580 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x2f4/0xa40 block/blk-core.c:753
       submit_bh fs/buffer.c:2742 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2344
       filemap_read_folio+0x137/0x3b0 mm/filemap.c:2502
       do_read_cache_folio+0x358/0x590 mm/filemap.c:4107
       read_mapping_folio include/linux/pagemap.h:1017 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:724
       adfspart_check_ICS+0xb1/0x960 block/partitions/acorn.c:356
       check_partition block/partitions/core.c:143 [inline]
       blk_add_partitions block/partitions/core.c:591 [inline]
       bdev_disk_changed+0x817/0x1770 block/partitions/core.c:695
       blkdev_get_whole+0x380/0x510 block/bdev.c:756
       bdev_open+0x31e/0xd30 block/bdev.c:965
       blkdev_open+0x470/0x610 block/fops.c:697
       do_dentry_open+0x785/0x14e0 fs/open.c:947
       vfs_open+0x3b/0x340 fs/open.c:1079
       do_open fs/namei.c:4699 [inline]
       path_openat+0x2e08/0x3860 fs/namei.c:4858
       do_file_open+0x23e/0x4a0 fs/namei.c:4887
       do_sys_openat2+0x113/0x200 fs/open.c:1364
       do_sys_open fs/open.c:1370 [inline]
       __do_sys_openat fs/open.c:1386 [inline]
       __se_sys_openat fs/open.c:1381 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1381
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (&cmd->lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a3/0x1550 kernel/locking/mutex.c:820
       nbd_queue_rq+0xc6/0x1100 drivers/block/nbd.c:1199
       blk_mq_dispatch_rq_list+0xa70/0x1910 block/blk-mq.c:2148
       __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
       blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
       __blk_mq_sched_dispatch_requests+0xdcc/0x1600 block/blk-mq-sched.c:307
       blk_mq_sched_dispatch_requests+0xd7/0x190 block/blk-mq-sched.c:329
       blk_mq_run_hw_queue+0x348/0x4f0 block/blk-mq.c:2386
       blk_mq_dispatch_list+0xd16/0xe10 include/linux/spinlock.h:-1
       blk_mq_flush_plug_list+0x48d/0x570 block/blk-mq.c:2997
       __blk_flush_plug+0x3ed/0x4d0 block/blk-core.c:1230
       blk_finish_plug block/blk-core.c:1257 [inline]
       __submit_bio+0x28d/0x580 block/blk-core.c:649
       __submit_bio_noacct_mq block/blk-core.c:722 [inline]
       submit_bio_noacct_nocheck+0x2f4/0xa40 block/blk-core.c:753
       submit_bh fs/buffer.c:2742 [inline]
       block_read_full_folio+0x599/0x830 fs/buffer.c:2344
       filemap_read_folio+0x137/0x3b0 mm/filemap.c:2502
       do_read_cache_folio+0x358/0x590 mm/filemap.c:4107
       read_mapping_folio include/linux/pagemap.h:1017 [inline]
       read_part_sector+0xb6/0x2b0 block/partitions/core.c:724
       adfspart_check_ICS+0xb1/0x960 block/partitions/acorn.c:356
       check_partition block/partitions/core.c:143 [inline]
       blk_add_partitions block/partitions/core.c:591 [inline]
       bdev_disk_changed+0x817/0x1770 block/partitions/core.c:695
       blkdev_get_whole+0x380/0x510 block/bdev.c:756
       bdev_open+0x31e/0xd30 block/bdev.c:965
       blkdev_open+0x470/0x610 block/fops.c:697
       do_dentry_open+0x785/0x14e0 fs/open.c:947
       vfs_open+0x3b/0x340 fs/open.c:1079
       do_open fs/namei.c:4699 [inline]
       path_openat+0x2e08/0x3860 fs/namei.c:4858
       do_file_open+0x23e/0x4a0 fs/namei.c:4887
       do_sys_openat2+0x113/0x200 fs/open.c:1364
       do_sys_open fs/open.c:1370 [inline]
       __do_sys_openat fs/open.c:1386 [inline]
       __se_sys_openat fs/open.c:1381 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1381
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (set->srcu){.+.+}-{0:0}:
       srcu_lock_sync include/linux/srcu.h:199 [inline]
       __synchronize_srcu+0xca/0x300 kernel/rcu/srcutree.c:1481
       elevator_switch+0x1e8/0x7a0 block/elevator.c:576
       elevator_change+0x2cc/0x450 block/elevator.c:681
       elevator_set_default+0x36c/0x430 block/elevator.c:754
       blk_register_queue+0x3e9/0x4e0 block/blk-sysfs.c:987
       __add_disk+0x677/0xd50 block/genhd.c:528
       add_disk_fwnode+0xfb/0x480 block/genhd.c:597
       add_disk include/linux/blkdev.h:794 [inline]
       nbd_dev_add+0x72c/0xb50 drivers/block/nbd.c:1984
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2692
       do_one_initcall+0x250/0x870 init/main.c:1392
       do_initcall_level+0x104/0x190 init/main.c:1454
       do_initcalls+0x59/0xa0 init/main.c:1470
       kernel_init_freeable+0x2a6/0x3e0 init/main.c:1703
       kernel_init+0x1d/0x1d0 init/main.c:1593
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #3 (&q->elevator_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a3/0x1550 kernel/locking/mutex.c:820
       elevator_change+0x1b3/0x450 block/elevator.c:679
       elevator_set_none+0xb5/0x140 block/elevator.c:769
       blk_mq_elv_switch_none block/blk-mq.c:5131 [inline]
       __blk_mq_update_nr_hw_queues block/blk-mq.c:5176 [inline]
       blk_mq_update_nr_hw_queues+0x5e7/0x1a60 block/blk-mq.c:5241
       nbd_start_device+0x17f/0xb10 drivers/block/nbd.c:1489
       nbd_genl_connect+0x165b/0x1cf0 drivers/block/nbd.c:2239
       genl_family_rcv_msg_doit+0x22a/0x330 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x61c/0x7a0 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x232/0x4b0 net/netlink/af_netlink.c:2550
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
       netlink_unicast+0x75c/0x8e0 net/netlink/af_netlink.c:1344
       netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
       sock_sendmsg_nosec net/socket.c:787 [inline]
       __sock_sendmsg net/socket.c:802 [inline]
       ____sys_sendmsg+0x972/0x9f0 net/socket.c:2698
       ___sys_sendmsg+0x2a5/0x360 net/socket.c:2752
       __sys_sendmsg net/socket.c:2784 [inline]
       __do_sys_sendmsg net/socket.c:2789 [inline]
       __se_sys_sendmsg net/socket.c:2787 [inline]
       __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2787
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&q->q_usage_counter(io)#49){++++}-{0:0}:
       blk_alloc_queue+0x546/0x680 block/blk-core.c:461
       blk_mq_alloc_queue block/blk-mq.c:4450 [inline]
       __blk_mq_alloc_disk+0x197/0x390 block/blk-mq.c:4497
       nbd_dev_add+0x499/0xb50 drivers/block/nbd.c:1954
       nbd_init+0x168/0x1f0 drivers/block/nbd.c:2692
       do_one_initcall+0x250/0x870 init/main.c:1392
       do_initcall_level+0x104/0x190 init/main.c:1454
       do_initcalls+0x59/0xa0 init/main.c:1470
       kernel_init_freeable+0x2a6/0x3e0 init/main.c:1703
       kernel_init+0x1d/0x1d0 init/main.c:1593
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4325 [inline]
       fs_reclaim_acquire+0x71/0x100 mm/page_alloc.c:4339
       might_alloc include/linux/sched/mm.h:317 [inline]
       prepare_alloc_pages+0x152/0x650 mm/page_alloc.c:4995
       __alloc_frozen_pages_noprof+0x12f/0x380 mm/page_alloc.c:5215
       alloc_pages_mpol+0x235/0x490 mm/mempolicy.c:2490
       alloc_frozen_pages_noprof mm/mempolicy.c:2561 [inline]
       alloc_pages_noprof+0xac/0x2a0 mm/mempolicy.c:2581
       pagetable_alloc_noprof include/linux/mm.h:3651 [inline]
       __pud_alloc_one_noprof include/asm-generic/pgalloc.h:181 [inline]
       pud_alloc_one_noprof include/asm-generic/pgalloc.h:206 [inline]
       __pud_alloc+0x3a/0x460 mm/memory.c:6780
       pud_alloc include/linux/mm.h:3561 [inline]
       huge_pte_alloc+0x4f7/0x630 mm/hugetlb.c:7011
       hugetlb_fault+0x51b/0x1510 mm/hugetlb.c:5995
       handle_mm_fault+0x2007/0x3170 mm/memory.c:6716
       faultin_page mm/gup.c:1126 [inline]
       __get_user_pages+0x1683/0x2720 mm/gup.c:1428
       populate_vma_page_range+0x2be/0x3c0 mm/gup.c:1860
       __mm_populate+0x25f/0x390 mm/gup.c:1963
       mm_populate include/linux/mm.h:4137 [inline]
       vm_mmap_pgoff+0x3aa/0x4f0 mm/util.c:586
       ksys_mmap_pgoff+0x586/0x760 mm/mmap.c:606
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&hugetlb_fault_mutex_table[i]){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a3/0x1550 kernel/locking/mutex.c:820
       hugetlbfs_fallocate+0x7f9/0x1180 fs/hugetlbfs/inode.c:795
       vfs_fallocate+0x669/0x7e0 fs/open.c:338
       ksys_fallocate fs/open.c:362 [inline]
       __do_sys_fallocate fs/open.c:367 [inline]
       __se_sys_fallocate fs/open.c:365 [inline]
       __x64_sys_fallocate+0xc0/0x110 fs/open.c:365
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &hugetlb_fault_mutex_table[i] --> &mm->mmap_lock --> &sb->s_type->i_mutex_key#29

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#29);
                               lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#29);
  lock(&hugetlb_fault_mutex_table[i]);

 *** DEADLOCK ***

2 locks held by syz.1.1475/9895:
 #0: ffff88801b37c410 (sb_writers#26){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2724 [inline]
 #0: ffff88801b37c410 (sb_writers#26){.+.+}-{0:0}, at: vfs_fallocate+0x5f0/0x7e0 fs/open.c:337
 #1: ffff88801b3314a0 (&sb->s_type->i_mutex_key#29){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1029 [inline]
 #1: ffff88801b3314a0 (&sb->s_type->i_mutex_key#29){+.+.}-{4:4}, at: hugetlbfs_fallocate+0x2f0/0x1180 fs/hugetlbfs/inode.c:751

stack backtrace:
CPU: 0 UID: 0 PID: 9895 Comm: syz.1.1475 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x15a5/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x1a3/0x1550 kernel/locking/mutex.c:820
 hugetlbfs_fallocate+0x7f9/0x1180 fs/hugetlbfs/inode.c:795
 vfs_fallocate+0x669/0x7e0 fs/open.c:338
 ksys_fallocate fs/open.c:362 [inline]
 __do_sys_fallocate fs/open.c:367 [inline]
 __se_sys_fallocate fs/open.c:365 [inline]
 __x64_sys_fallocate+0xc0/0x110 fs/open.c:365
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2f8779ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2f88720028 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f2f87a15fa0 RCX: 00007f2f8779ce59
RDX: 0000000000000009 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007f2f87832d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2f87a16038 R14: 00007f2f87a15fa0 R15: 00007ffe26fa6938
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
