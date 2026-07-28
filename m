Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F96F43F08C
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245500; cv=none; b=au1H+d3bpYsSR/4RV1ZIgvm80XP4WG7it/i/QjjKmdBT9z//cUUMgCia4USBYCmUWT2czU97VpLe07g24cKg2S6JNvlgT59RiZSS9zLK69pMEKFe3e3nbCCsiko81ro8J8b+J4FXpoope7DCXUKTH3fb/r3HXbOwnLdrFLccR1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245500; c=relaxed/simple;
	bh=2oFKQj2LOMTsmt4JuBs2TXh8g2RDGarnVWjVeWWwl/0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=k9rdo7xQv1tQSxWSCnS5mSze1ahmY/Mfbtc+ywlrgIODq/S2BQRWY0pXSLSTntUoPU4gFV/dyfr15xvuA08tW+cWGFC5myWoy1BIZmCQR1CgZz/CipbpTEZhKK9oefAZg0N86X6zotuetRpFwDsq0BTiqeXuszdtGhxIQsWS4SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-49d4cb3ca23so5059275b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 06:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785245489; x=1785850289;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwJ6tc+LoIte3L/2ELtAEEHw4LCIRUhZiYrCpxiXbhY=;
        b=kWVfox6BoDoO7A4HGWuCTiQkBSvFzPRy2IuW6vJZa4vsm76DhncbNEceQ6tBodO1Fr
         T2ztQV1lorFhyGzuXmHxFe3zwagPZHl8KHjOaZhMR5Qcm3grE3wVxFUHYTxRzlgNlXtB
         wlbThTM5wFCZ0PMZtAkHtGIgG2iGDgr/rNGU/6tFet8nRJZpWSbIV7GKdte+qkMwZKBY
         dmHNfuC7Vw/q231a2SGq+GK3fufURqc/Fkb2HsI+9Ks3iFTsmLazbqm4U5zHk0F/jck0
         j1Q9Ft9XJucaeQkrVa+m097fX6RPm1I50vo06HnCX4uDqanTf5PBKCkYtM9LjyizOi65
         juNA==
X-Forwarded-Encrypted: i=1; AHgh+RqcJ6Bys5XGPIHPKxM2S4LWyJ6SaO9liooERUIYsYyg1GtFUN/o3Q5zwkBgHWLmEJCvg96OA254UgJ/nXcJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNS6Gh7eOPcx9kVqdW9pfzeh3INuoOGmSIYDEDTsHfHkJuktN
	bK3hcHhqfZVazHAX7vm4ICj9l/0Tz7Ivs5821H1DyEXJEm9jHZL3Kfvy+VUE4UcRrV7t9ja/Nw9
	cE+JJCzKxTT7WrgBx77Ig/T/4X0nA5ZBhQrmW/WsiJpSHD7I1tW9hycaD1Hk=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:192a:b0:495:e1b6:2c5 with SMTP id
 5614622812f47-4ad5b964e3dmr1896961b6e.1.1785245489414; Tue, 28 Jul 2026
 06:31:29 -0700 (PDT)
Date: Tue, 28 Jul 2026 06:31:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a68af31.073198cf.94f0f.0048.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in configfs_rmdir
From: syzbot <syzbot+c9f9d646b08f3b6032fe@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    62cc90241548 Merge tag 'mm-hotfixes-stable-2026-07-27-14-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17cbd8c6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb17729fb04b1e3a
dashboard link: https://syzkaller.appspot.com/bug?extid=c9f9d646b08f3b6032fe
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/727c8b2ee0d6/disk-62cc9024.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4e2cc8ae0237/vmlinux-62cc9024.xz
kernel image: https://storage.googleapis.com/syzbot-assets/beb9a012f168/bzImage-62cc9024.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c9f9d646b08f3b6032fe@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.7.499/12527 is trying to acquire lock:
ffffffff8ef6f200 (gadget_subsys.su_mutex){+.+.}-{4:4}, at: configfs_rmdir+0x5f0/0x950 fs/configfs/dir.c:1556

but task is already holding lock:
ffff88803d44d7f8 (&sb->s_type->i_mutex_key#33){++++}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
ffff88803d44d7f8 (&sb->s_type->i_mutex_key#33){++++}-{4:4}, at: vfs_rmdir+0xf8/0x6b0 fs/namei.c:5366

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sb->s_type->i_mutex_key#33){++++}-{4:4}:
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1631
       inode_lock include/linux/fs.h:1024 [inline]
       configfs_depend_item_unlocked+0x153/0x420 fs/configfs/dir.c:1259
       usbg_make_tpg+0x1f6/0x590 drivers/usb/gadget/function/f_tcm.c:1686
       target_fabric_make_tpg+0xa8/0x6d0 drivers/target/target_core_fabric_configfs.c:939
       configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1360
       vfs_mkdir+0x402/0x620 fs/namei.c:5276
       filename_mkdirat+0x289/0x520 fs/namei.c:5309
       __do_sys_mkdirat fs/namei.c:5330 [inline]
       __se_sys_mkdirat+0x35/0x150 fs/namei.c:5327
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&opts->dep_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       tcm_set_name+0x2b/0xd0 drivers/usb/gadget/function/f_tcm.c:2669
       function_make+0x1a8/0x360 drivers/usb/gadget/configfs.c:636
       configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1360
       vfs_mkdir+0x402/0x620 fs/namei.c:5276
       filename_mkdirat+0x289/0x520 fs/namei.c:5309
       __do_sys_mkdirat fs/namei.c:5330 [inline]
       __se_sys_mkdirat+0x35/0x150 fs/namei.c:5327
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (gadget_subsys.su_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x1520/0x2ce0 kernel/locking/lockdep.c:5237
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       configfs_rmdir+0x5f0/0x950 fs/configfs/dir.c:1556
       vfs_rmdir+0x3e9/0x6b0 fs/namei.c:5381
       filename_rmdir+0x292/0x520 fs/namei.c:5438
       __do_sys_rmdir fs/namei.c:5461 [inline]
       __se_sys_rmdir+0x2e/0x140 fs/namei.c:5458
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  gadget_subsys.su_mutex --> &opts->dep_lock --> &sb->s_type->i_mutex_key#33

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#33);
                               lock(&opts->dep_lock);
                               lock(&sb->s_type->i_mutex_key#33);
  lock(gadget_subsys.su_mutex);

 *** DEADLOCK ***

3 locks held by syz.7.499/12527:
 #0: ffff88801d3b4500 (sb_writers#25){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:494
 #1: ffff88805de43cf0 (&default_group_class[depth - 1]#2/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1069 [inline]
 #1: ffff88805de43cf0 (&default_group_class[depth - 1]#2/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2918 [inline]
 #1: ffff88805de43cf0 (&default_group_class[depth - 1]#2/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2942 [inline]
 #1: ffff88805de43cf0 (&default_group_class[depth - 1]#2/1){+.+.}-{4:4}, at: filename_rmdir+0x1cd/0x520 fs/namei.c:5431
 #2: ffff88803d44d7f8 (&sb->s_type->i_mutex_key#33){++++}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
 #2: ffff88803d44d7f8 (&sb->s_type->i_mutex_key#33){++++}-{4:4}, at: vfs_rmdir+0xf8/0x6b0 fs/namei.c:5366

stack backtrace:
CPU: 1 UID: 0 PID: 12527 Comm: syz.7.499 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x1520/0x2ce0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
 mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
 configfs_rmdir+0x5f0/0x950 fs/configfs/dir.c:1556
 vfs_rmdir+0x3e9/0x6b0 fs/namei.c:5381
 filename_rmdir+0x292/0x520 fs/namei.c:5438
 __do_sys_rmdir fs/namei.c:5461 [inline]
 __se_sys_rmdir+0x2e/0x140 fs/namei.c:5458
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f74b0eede99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f74af125028 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
RAX: ffffffffffffffda RBX: 00007f74b1176090 RCX: 00007f74b0eede99
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000800
RBP: 00007f74b0f83eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f74b1176128 R14: 00007f74b1176090 R15: 00007ffdc0ba11b8
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
