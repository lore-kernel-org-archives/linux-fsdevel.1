Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF183563CD
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785376049; cv=none; b=n18mVWDOKo0SGfFaM41qyElTeEtXEmFN57iQUtKGQFDGYLsaUw/5OLXYf3MZuNGgmRs1GlPPjhXZ2LnfNairdzxVBuUnbpNTuhXnkeSd6QLjuaSJWg7zGiAM7y3iLnzfG9lp9nqT20Dbb7JyJmH33Sj/KJPe+tJ8OCmPwsyEQZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785376049; c=relaxed/simple;
	bh=snqRZmWCA7yoIq0Og2pP71x+ALv3xk2sxJGYy7QwwHs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=anUQU96b2YZfm0mVoEqgMbzgFmDYuRss/CDtpBi4x4eSB0bZa9ijoZRNmuZ5R0MHhr4n85zIMXtQdl+ndcdgFc80Rlc677WChvGhiNHToRy8aVnti2RiIusw0In2LTVoyMWx2ShgiCRSuTr1FrKJq025YEWliRVQIq/OAfN9LNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-458582a8c9fso518817fac.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 18:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785376046; x=1785980846;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uOYhb3R4Ro9HUVZkpd8Z/M/+URfC+VWeDr7MMYbnATs=;
        b=D5eq4ZBVZbfyzfKDRXo9CV0OwzgQB8tpuHGH5Q/P9vcTqc/jYk+o3VmNlCP/8Q2a8D
         XdEbBpKhK4sOKta3OBl6UO4rEGf/akmMHRK8Z9N7Bq6rpwMZFikJ5KIIVYXUip+dsHM0
         p+Ylc1SHrGPvVMxHV2m8NN1QWEevQBi3DlwJDTjqcqNCGEamSksQ6b7tX12dd2dmPEE9
         mc0MkVKTmpWyF/9b8Ku8Vzmu+wiFRWIxFnuuuExPI0cP2OqP4cObkDS6OxolIE8WdL98
         mU2dDw6XTwA/QOZToMwAPnvviB+b+Mh8UCZN8nufjiPWKLUNhwkpfIIsUlb+SU75Pzgd
         UISw==
X-Forwarded-Encrypted: i=1; AHgh+RrqhZ1ZS6s0QMyP88NJ+vbNftM/7+5GusKZoU/cy5+ihrSs6kDCJiwJi83Hw6XLXDGlh/HOnzGJIQ149ob1@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv2pTEpeaKog83THGMoGIEbcSGaYPMQ1UzPVAayT4GxpVF6E5H
	dkg/U7LynzlZBXumkNPJm9TbO0MzKgKhRkQ7O4WZc/o+nrCM+RnpE/PB0/3Bul9+6bq5Q9LVVhO
	VGPnzjGxPW1UuVVRFYxwknOICWwO3GZPkoWnDJXFWuAvc5tBl3Ew+g5Dvk4A=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:14d5:b0:495:cfc7:9137 with SMTP id
 5614622812f47-4ad879b8f6amr447440b6e.38.1785376046482; Wed, 29 Jul 2026
 18:47:26 -0700 (PDT)
Date: Wed, 29 Jul 2026 18:47:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6aad2e.57649fcc.360844.000d.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in __configfs_open_file (2)
From: syzbot <syzbot+c87014f645f2fd24312e@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3dab139d4795 Merge tag 'rust-fixes-7.2-2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108ca499580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=c87014f645f2fd24312e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3dab139d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2b5a401a9dc7/vmlinux-3dab139d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ed2d255bd44/bzImage-3dab139d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c87014f645f2fd24312e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.0.1655/12104 is trying to acquire lock:
ffff88802a295570 (&p->frag_sem){++++}-{4:4}, at: __configfs_open_file+0xe8/0x9c0 fs/configfs/file.c:304

but task is already holding lock:
ffff88803cc7bc38 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: process_measurement+0x5ab/0x2350 security/integrity/ima/ima_main.c:319

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       process_measurement+0x5ab/0x2350 security/integrity/ima/ima_main.c:319
       ima_file_check+0xc3/0x110 security/integrity/ima/ima_main.c:685
       security_file_post_open+0xc4/0x210 security/security.c:2755
       do_open fs/namei.c:4702 [inline]
       path_openat+0x985/0x4280 fs/namei.c:4863
       do_file_open_root+0x2f6/0x5a0 fs/namei.c:4916
       file_open_root+0x1c6/0x3f0 fs/open.c:1355
       kernel_read_file_from_path_initns+0x189/0x260 fs/kernel_read_file.c:163
       fw_get_filesystem_firmware drivers/base/firmware_loader/main.c:549 [inline]
       _request_firmware+0x733/0x13c0 drivers/base/firmware_loader/main.c:873
       request_firmware+0x35/0x50 drivers/base/firmware_loader/main.c:948
       reg_reload_regdb+0x85/0x460 net/wireless/reg.c:1067
       genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2556
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1900
       sock_sendmsg_nosec net/socket.c:775 [inline]
       __sock_sendmsg net/socket.c:790 [inline]
       ____sys_sendmsg+0xa4d/0xbe0 net/socket.c:2684
       ___sys_sendmsg+0x190/0x1e0 net/socket.c:2738
       __sys_sendmsg+0x160/0x210 net/socket.c:2770
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (cb_lock){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
       genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1900
       sock_sendmsg_nosec net/socket.c:775 [inline]
       __sock_sendmsg net/socket.c:790 [inline]
       sock_sendmsg+0x394/0x410 net/socket.c:813
       splice_to_socket+0xb3c/0x11a0 fs/splice.c:884
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0x109c/0x1f90 fs/splice.c:1349
       __do_splice+0x33b/0x370 fs/splice.c:1431
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice fs/splice.c:1616 [inline]
       __x64_sys_splice+0x187/0x250 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&pipe->mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       pipe_lock fs/pipe.c:91 [inline]
       pipe_lock+0x69/0x80 fs/pipe.c:88
       iter_file_splice_write+0x1fd/0x10b0 fs/splice.c:682
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0x109c/0x1f90 fs/splice.c:1349
       __do_splice+0x33b/0x370 fs/splice.c:1431
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice fs/splice.c:1616 [inline]
       __x64_sys_splice+0x187/0x250 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (sb_writers#6){.+.+}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs/super.h:19 [inline]
       sb_start_write include/linux/fs/super.h:125 [inline]
       mnt_want_write+0x6f/0x410 fs/namespace.c:494
       open_last_lookups fs/namei.c:4597 [inline]
       path_openat+0xad9/0x4280 fs/namei.c:4860
       do_file_open+0x20e/0x430 fs/namei.c:4892
       file_open_name+0x1c3/0x3e0 fs/open.c:1326
       filp_open+0x2e/0x50 fs/open.c:1343
       fsg_lun_open+0x6b/0x7b0 drivers/usb/gadget/function/storage_common.c:194
       fsg_store_file+0x1e7/0x450 drivers/usb/gadget/function/storage_common.c:455
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&common->filesem){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       down_write+0x8b/0x1f0 kernel/locking/rwsem.c:1631
       fsg_store_file+0x193/0x450 drivers/usb/gadget/function/storage_common.c:452
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&p->frag_sem){++++}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
       __configfs_open_file+0xe8/0x9c0 fs/configfs/file.c:304
       do_dentry_open+0x6ab/0x14d0 fs/open.c:947
       vfs_open+0x82/0x3f0 fs/open.c:1052
       dentry_open+0x71/0xd0 fs/open.c:1075
       ima_calc_file_hash+0xe1/0x380 security/integrity/ima/ima_crypto.c:269
       ima_collect_measurement+0x94f/0xb30 security/integrity/ima/ima_api.c:300
       process_measurement+0xdfe/0x2350 security/integrity/ima/ima_main.c:425
       ima_file_mmap+0x1bb/0x1e0 security/integrity/ima/ima_main.c:523
       security_mmap_file+0x278/0x9b0 security/security.c:2581
       vm_mmap_pgoff+0xec/0x470 mm/util.c:575
       ksys_mmap_pgoff+0x3cb/0x610 mm/mmap.c:606
       __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
       __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
       __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &p->frag_sem --> cb_lock --> &ima_iint_mutex_key[depth]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ima_iint_mutex_key[depth]);
                               lock(cb_lock);
                               lock(&ima_iint_mutex_key[depth]);
  rlock(&p->frag_sem);

 *** DEADLOCK ***

1 lock held by syz.0.1655/12104:
 #0: ffff88803cc7bc38 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: process_measurement+0x5ab/0x2350 security/integrity/ima/ima_main.c:319

stack backtrace:
CPU: 0 UID: 0 PID: 12104 Comm: syz.0.1655 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1c7 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
 down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
 __configfs_open_file+0xe8/0x9c0 fs/configfs/file.c:304
 do_dentry_open+0x6ab/0x14d0 fs/open.c:947
 vfs_open+0x82/0x3f0 fs/open.c:1052
 dentry_open+0x71/0xd0 fs/open.c:1075
 ima_calc_file_hash+0xe1/0x380 security/integrity/ima/ima_crypto.c:269
 ima_collect_measurement+0x94f/0xb30 security/integrity/ima/ima_api.c:300
 process_measurement+0xdfe/0x2350 security/integrity/ima/ima_main.c:425
 ima_file_mmap+0x1bb/0x1e0 security/integrity/ima/ima_main.c:523
 security_mmap_file+0x278/0x9b0 security/security.c:2581
 vm_mmap_pgoff+0xec/0x470 mm/util.c:575
 ksys_mmap_pgoff+0x3cb/0x610 mm/mmap.c:606
 __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
 __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
 __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f06a959de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f06aa49a028 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f06a9826180 RCX: 00007f06a959de99
RDX: 000000000100000d RSI: 0000000000002000 RDI: 0000200000000000
RBP: 00007f06a9633eaf R08: 0000000000000006 R09: 0000000000000000
R10: 0000000000000010 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f06a9826218 R14: 00007f06a9826180 R15: 00007fffeb1fe648
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
