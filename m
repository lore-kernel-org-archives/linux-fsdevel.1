Received: from mail-oo2-f4.google.com (mail-oo2-f4.google.com [74.125.231.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5D352008
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 15:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967167; cv=none; b=UDUqd9KHf1+Als9E6pMiyPZi6h940jvRu9H5lOaPquHImnMarloLRGBgp5MnAPGItvYrHXsZmwJg8EIJRB31IGDoeEYPcw7HMQBNtsdYivbE3r3rIQwndls09Z2+ZAOkzdGyk6GkhmL8iXfSKL23WqI+FUhv2trQO0jQw9skEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967167; c=relaxed/simple;
	bh=fBXbFpbcQbjFQINt1XxYvnOz0zlP+VZPixWHDI+5LpQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mgwJkuH+1MyXV3W4tj/GRpQ5UT7vDG/J9waFPUHlCEifaFB5Qq9z2eWd5UXMF/hu7ikie+Y7aC2WS63A8VlpXeJMRomkTCCRYWfMFTgYol+H9AgRxuOhzjKT/iai20eNHVIYzpyjq2k9o0TZXGlybvFFHJ5Eh8sa9r/JJ6cQdlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f4.google.com with SMTP id 46e09a7af769-7f4e9ec63a7so1428560a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 08:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788967164; x=1789571964;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=poVcBc/nmVPP4K5lL2InQVuUDiv4ng734KLoRF+5fug=;
        b=pM2rsoKgelq+IMEL2lvP+p0/AnOU4VmqCG3TelPNb850nAyNzshfv2rH/Z5OWxhuEB
         /e4NYg3DgiAz/6ZOx3bl66RHeIKOfkC/qKhGHRTZhNZ289vN4CMq8ru0PR/K2H0jmsBf
         DxiULGx532sFftGh/FBMJO8vWKUvSOsmDQA9s6LF1S5XbpgAGSAxmd6N0t2ttag9r+Zo
         xPTXSfRjLo7wIbJRg4jdqBkmFbef0BAtntQNVJ/g3dc61wlZMaubwXmkoAfGjuHrWilT
         0uXNCFnhkaKii3rMyAl4ecTSDbVdaa/ZLYG3b8xdYgO2UH9Lkr5s0UpTbnANkG3h2BL2
         0NlQ==
X-Forwarded-Encrypted: i=1; AKwUvBzNk0dyqG4aO5vIdJDlOuY5TjeO2aSXjEUgN6TSiXXKOV2HVge5TJA1+GsmHPBfVcGGxD8P3Z3Et9L5FeqL@vger.kernel.org
X-Gm-Message-State: AFuF++k4z4cOcKtKr8mGSXxrDYOhPb4w0WMekxdBBDei9p9jASxEpJ7z
	IIPq9WQlHT+YK8aYlAxCrgEr2Zwg1HpOL4Fb3TE0GwDvI7ds9wVKMHcgTF76ecOBifIfELRkBY2
	km/mN5pjltaHOPnq5qfBywkgA4V4OgAthP0hJO5Vf7HPGK5W1Jlz9doMCg94=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4b97:b0:6bd:5506:aadc with SMTP id
 006d021491bc7-6bd5506ae79mr4764719eaf.35.1788967164386; Wed, 09 Sep 2026
 08:19:24 -0700 (PDT)
Date: Wed, 09 Sep 2026 08:19:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa178fc.f2639fcc.29487d.0008.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in ovl_create_object (2)
From: syzbot <syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    654ae5d73c05 Merge tag 'drm-fixes-2026-09-05' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11860cf9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5c3949d762a91f
dashboard link: https://syzkaller.appspot.com/bug?extid=7cab6a19619f1b8efc00
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/90a1eb1b2bfe/disk-654ae5d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dcbbe9cf09c5/vmlinux-654ae5d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c80eca6821dd/bzImage-654ae5d7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7cab6a19619f1b8efc00@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.6.857/9678 is trying to acquire lock:
ffff88803cd16460 (sb_writers#6){.+.+}-{0:0}, at: ovl_create_object+0x130/0x3b0 fs/overlayfs/dir.c:705

but task is already holding lock:
ffff888058c6e948 (&ovl_i_mutex_dir_key[depth]){++++}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
ffff888058c6e948 (&ovl_i_mutex_dir_key[depth]){++++}-{4:4}, at: lookup_open+0xb13/0x1990 fs/namei.c:4458

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&ovl_i_mutex_dir_key[depth]){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5908 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
       down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
       inode_lock_shared include/linux/fs.h:1039 [inline]
       lookup_slow+0x42/0x70 fs/namei.c:1935
       walk_component fs/namei.c:2282 [inline]
       lookup_last fs/namei.c:2789 [inline]
       path_lookupat+0x5e8/0xc40 fs/namei.c:2813
       filename_lookup+0x202/0x590 fs/namei.c:2842
       kern_path+0x37/0x50 fs/namei.c:3036
       lookup_bdev+0xd8/0x2a0 block/bdev.c:1268
       bdev_file_open_by_path+0x82/0x330 block/bdev.c:1123
       add_device drivers/mtd/devices/block2mtd.c:279 [inline]
       block2mtd_setup2.isra.0+0x2ee/0xbd0 drivers/mtd/devices/block2mtd.c:459
       block2mtd_setup+0xbd/0xd0 drivers/mtd/devices/block2mtd.c:476
       param_attr_store+0x199/0x300 kernel/params.c:591
       module_attr_store+0x58/0x80 kernel/params.c:906
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6af/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (param_lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5908 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       ieee80211_rate_control_ops_get net/mac80211/rate.c:221 [inline]
       rate_control_alloc net/mac80211/rate.c:267 [inline]
       ieee80211_init_rate_ctrl_alg+0x1df/0x3b0 net/mac80211/rate.c:1008
       ieee80211_register_hw+0x2c1e/0x4580 net/mac80211/main.c:1561
       mac80211_hwsim_new_radio+0x2b08/0x6510 drivers/net/wireless/virtual/mac80211_hwsim_main.c:6138
       init_mac80211_hwsim+0x5e2/0x6f0 drivers/net/wireless/virtual/mac80211_hwsim_main.c:7624
       do_one_initcall+0x11c/0x6f0 init/main.c:1357
       do_initcall_level init/main.c:1419 [inline]
       do_initcalls init/main.c:1435 [inline]
       do_basic_setup init/main.c:1455 [inline]
       kernel_init_freeable+0x6ea/0x7b0 init/main.c:1670
       kernel_init+0x21/0x1e0 init/main.c:1560
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (rtnl_mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5908 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       rtnl_lock net/core/rtnetlink.c:80 [inline]
       rtnetlink_rcv_msg+0x371/0xe90 net/core/rtnetlink.c:7138
       netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2556
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1900
       sock_sendmsg_nosec net/socket.c:800 [inline]
       __sock_sendmsg net/socket.c:815 [inline]
       sock_sendmsg+0x394/0x410 net/socket.c:838
       splice_to_socket+0xb3c/0x11a0 fs/splice.c:884
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0x109c/0x1fa0 fs/splice.c:1349
       __do_splice+0x33b/0x370 fs/splice.c:1431
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice fs/splice.c:1616 [inline]
       __x64_sys_splice+0x187/0x250 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&pipe->mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5908 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       pipe_lock fs/pipe.c:91 [inline]
       pipe_lock+0x69/0x80 fs/pipe.c:88
       iter_file_splice_write+0x1fd/0x10b0 fs/splice.c:682
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0x109c/0x1fa0 fs/splice.c:1349
       __do_splice+0x33b/0x370 fs/splice.c:1431
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice fs/splice.c:1616 [inline]
       __x64_sys_splice+0x187/0x250 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sb_writers#6){.+.+}-{0:0}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3181
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x1492/0x1ec0 kernel/locking/lockdep.c:5254
       lock_acquire kernel/locking/lockdep.c:5908 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs/super.h:19 [inline]
       sb_start_write include/linux/fs/super.h:125 [inline]
       mnt_want_write+0x6f/0x420 fs/namespace.c:494
       ovl_create_object+0x130/0x3b0 fs/overlayfs/dir.c:705
       lookup_open+0x1255/0x1990 fs/namei.c:4567
       open_last_lookups fs/namei.c:4767 [inline]
       path_openat+0xa2c/0x2440 fs/namei.c:4997
       do_file_open+0x20e/0x430 fs/namei.c:5029
       do_sys_openat2+0x10f/0x1e0 fs/open.c:1417
       do_sys_open fs/open.c:1423 [inline]
       __do_sys_openat fs/open.c:1439 [inline]
       __se_sys_openat fs/open.c:1434 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1434
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sb_writers#6 --> param_lock --> &ovl_i_mutex_dir_key[depth]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ovl_i_mutex_dir_key[depth]);
                               lock(param_lock);
                               lock(&ovl_i_mutex_dir_key[depth]);
  rlock(sb_writers#6);

 *** DEADLOCK ***

locks held by syz.6.857/9678: 2, last CPU#1:
 #0: ffff88802ba66460 (sb_writers#13){.+.+}-{0:0}, at: lookup_open+0x150/0x1990 fs/namei.c:4451
 #1: ffff888058c6e948 (&ovl_i_mutex_dir_key[depth]){++++}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
 #1: ffff888058c6e948 (&ovl_i_mutex_dir_key[depth]){++++}-{4:4}, at: lookup_open+0xb13/0x1990 fs/namei.c:4458

stack backtrace:
CPU: 1 UID: 0 PID: 9678 Comm: syz.6.857 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2059
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2191
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3181
 check_prevs_add kernel/locking/lockdep.c:3300 [inline]
 validate_chain kernel/locking/lockdep.c:3924 [inline]
 __lock_acquire+0x1492/0x1ec0 kernel/locking/lockdep.c:5254
 lock_acquire kernel/locking/lockdep.c:5908 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5865
 percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
 percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
 __sb_start_write include/linux/fs/super.h:19 [inline]
 sb_start_write include/linux/fs/super.h:125 [inline]
 mnt_want_write+0x6f/0x420 fs/namespace.c:494
 ovl_create_object+0x130/0x3b0 fs/overlayfs/dir.c:705
 lookup_open+0x1255/0x1990 fs/namei.c:4567
 open_last_lookups fs/namei.c:4767 [inline]
 path_openat+0xa2c/0x2440 fs/namei.c:4997
 do_file_open+0x20e/0x430 fs/namei.c:5029
 do_sys_openat2+0x10f/0x1e0 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2d2539e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2d261d2028 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f2d25625fa0 RCX: 00007f2d2539e159
RDX: 0000000000000040 RSI: 0000200000000180 RDI: ffffffffffffff9c
RBP: 00007f2d25435024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000023 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2d25626038 R14: 00007f2d25625fa0 R15: 00007ffeef1e4b18
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
