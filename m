Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9543803C
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 13:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246170; cv=none; b=H6GKcMuVxEYJ6ljlYiSCpilh66oAmvyil0dnTYi0O69iXSJL3c5Pb/sAFqDDn5/1S166MFDzp/pQjb7v/5zv3ApesqY5Tn+lGyL9C7X5FgL8wjFE9H+Se5trBi9vI4VLmbPI6NrK31Q78NWirDCRTBsKscaA3YEHAfxi2v6YhPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246170; c=relaxed/simple;
	bh=rC4ixOYaB1+TVv8Ld8Ihww/HS0U/t6h3dv0GeuFYLG4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=X99WstQnlqB69oem24rOidN2Gm3BaqeXIr6EW2ShyD+x3ke/H8WY8c2oFuzSXI4k+qfZAlO6HGVmQ0e1YwpNaNXCqoEx86rn9Yl1OQIyK25ielp+JU+NmPityjdPVfeyOUmLR9tX85BErKR4PjSbslgsRe9yNcEEXfa1vPQSTiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-456ab1a7f2cso3946583fac.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 06:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785246155; x=1785850955;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=acF5tcKhDcr9QoRmmG9oBH4rw7Ot2b2XCU5TbPnOgiE=;
        b=RRL5W3r4HjUFi3VRH5Re/BQHhHjGwx8nSIvo0KZoVW9Se/2xzZsUWkJ1pbjV5H9jdc
         Qn/fDp2+GOVze3yLGV852rMruBLPz3X3MkquedhlWRtLoekPxedW9dqTMUmf8zFXNzf6
         2Idr+vfajpJPJEGqXFctRI8Qt3gNBizfmjq5+b5sfjEA6i0jjTt1ikO0U5pMazX/F7jY
         wFWGKRrVEqPrwKKY6C3lqyiW3yj/slmCKuhBUd24qnd+Qh5RIgNIhzR8mkZhuV35dyxu
         tPN6t5NDvgI8cKykhF5abKIOehc/zVXTelv7/rij6W2Ou0ymO12eHSBS5gO83Wjk8vJA
         I5EA==
X-Forwarded-Encrypted: i=1; AHgh+RrcT7bxgKNnrvDX/w/RylC4xrHU4T4zHKB1AQL9OFfEuztPnroFw6KehywhIwZpKR1gjFuXFU0N1APlGsZm@vger.kernel.org
X-Gm-Message-State: AOJu0YytsLMcBudzbior8vKoXZvycozI40kCAPrBMGhNGkSYtdloL4I+
	IOh2sWcUkMTXYkql18JJqz1dWzlbHVwjTFPoH0MMiIznGzomqZ7tuiF6H8xIFwbGtZneu3qxrpE
	0z6DHwTzgXCOi3N20QOHX4XMMwro97/7EM1v35zOJlsyVrNO2dAozLtiFmz0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4c88:b0:6aa:da48:42c7 with SMTP id
 006d021491bc7-6ac96cacaf1mr1324944eaf.47.1785246155280; Tue, 28 Jul 2026
 06:42:35 -0700 (PDT)
Date: Tue, 28 Jul 2026 06:42:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a68b1cb.b6659fcc.241ab8.00e5.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in configfs_depend_item_unlocked
From: syzbot <syzbot+c75a7db5ca6ae96ed2d4@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    48a5a7ab8d6a Merge tag 'v7.2-rc4-smb3-client-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1382c7b1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb17729fb04b1e3a
dashboard link: https://syzkaller.appspot.com/bug?extid=c75a7db5ca6ae96ed2d4
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15065fde580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=133361b9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d0d4e9604889/disk-48a5a7ab.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d0017d0f35e6/vmlinux-48a5a7ab.xz
kernel image: https://storage.googleapis.com/syzbot-assets/81888db0a443/bzImage-48a5a7ab.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c75a7db5ca6ae96ed2d4@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.18/5951 is trying to acquire lock:
ffff8880230411b0 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
ffff8880230411b0 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: configfs_depend_item_unlocked+0x153/0x420 fs/configfs/dir.c:1259

but task is already holding lock:
ffff888034090110 (&opts->dep_lock){+.+.}-{4:4}, at: usbg_make_tpg+0x147/0x590 drivers/usb/gadget/function/f_tcm.c:1678

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&opts->dep_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       tcm_set_name+0x2b/0xd0 drivers/usb/gadget/function/f_tcm.c:2540
       function_make+0x1a8/0x360 drivers/usb/gadget/configfs.c:636
       configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1360
       vfs_mkdir+0x402/0x620 fs/namei.c:5276
       filename_mkdirat+0x289/0x520 fs/namei.c:5309
       __do_sys_mkdirat fs/namei.c:5330 [inline]
       __se_sys_mkdirat+0x35/0x150 fs/namei.c:5327
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (gadget_subsys.su_mutex){+.+.}-{4:4}:
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

-> #0 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x1520/0x2ce0 kernel/locking/lockdep.c:5237
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
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

other info that might help us debug this:

Chain exists of:
  &sb->s_type->i_mutex_key#24 --> gadget_subsys.su_mutex --> &opts->dep_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&opts->dep_lock);
                               lock(gadget_subsys.su_mutex);
                               lock(&opts->dep_lock);
  lock(&sb->s_type->i_mutex_key#24);

 *** DEADLOCK ***

5 locks held by syz.0.18/5951:
 #0: ffff88801df72500 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:494
 #1: ffff88803de41718 (&sb->s_type->i_mutex_key#7/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1069 [inline]
 #1: ffff88803de41718 (&sb->s_type->i_mutex_key#7/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2918 [inline]
 #1: ffff88803de41718 (&sb->s_type->i_mutex_key#7/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2942 [inline]
 #1: ffff88803de41718 (&sb->s_type->i_mutex_key#7/1){+.+.}-{4:4}, at: filename_create+0x200/0x370 fs/namei.c:4955
 #2: ffffffff8ec97520 (&subsys->su_mutex){+.+.}-{4:4}, at: configfs_mkdir+0x4b0/0x9e0 fs/configfs/dir.c:1358
 #3: ffffffff8efcd1b8 (tpg_instances_lock){+.+.}-{4:4}, at: usbg_make_tpg+0xf7/0x590 drivers/usb/gadget/function/f_tcm.c:1669
 #4: ffff888034090110 (&opts->dep_lock){+.+.}-{4:4}, at: usbg_make_tpg+0x147/0x590 drivers/usb/gadget/function/f_tcm.c:1678

stack backtrace:
CPU: 0 UID: 0 PID: 5951 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
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
RIP: 0033:0x7f3fd9bcde99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3710df98 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f3fd9e55fa0 RCX: 00007f3fd9bcde99
RDX: 00000000000001ff RSI: 0000200000001000 RDI: ffffffffffffff9c
RBP: 00007f3fd9c63eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3fd9e55fac R14: 00007f3fd9e55fa0 R15: 00007f3fd9e55fa0
 </TASK>
Mass Storage Function, version: 2009/09/11
LUN: removable file: (no medium)


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
