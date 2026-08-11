Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306D282F30
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 00:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407881; cv=none; b=F7vXCdKtQ8sx/VuLkzBjKsBfW+dV/oxI9I4XxbXt/Tkb8LK3zvDwHMaSkg9+i+J84TlW/ee9FE9AqbuRmANhhAMpKOqloy/a3zepUL7v4QdOShUUNnvWSga1zFQ6c7CVOb/Ptr0kJA6/6uJ//BZpQYHrAORvJetQwaB4rt4d7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407881; c=relaxed/simple;
	bh=eFaL3PhCM5GHJIoFVqTIXGCmnCfmQTeTPnHVkMcgzFo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s8Um6ZeHnN369TOwF6Tml/9lDhDj0zQJUlOiEuJeMka0GwHh2YCSlbGZEAWdSFshywEB+3YyRaiJhDKgvIsIipWeOT9fw+lb7LJUh58e3NKYqwaSR38q/k0+I8CGVxrRDsKAhHRWsQ3cFHJdnb/rfxW/h34130NlapYuXJFBS9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-44d0960fb5bso2382974fac.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 17:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786407878; x=1787012678;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XQnErzs2gusx3xUaACthm5DWDtRQ37KBnVLE5kRuOhw=;
        b=IDxvY1jFWpr/uN61Y3CH6a6hRWS7rN9fPiCfYrzUwEXraJBTq6oOgqiQ7WiXQQRXGO
         jOfpEB1D8ic2naZwjNYI6eU4ZsrU68sac4itcuVOhqIU4tLXIc0NU6IqcnGH3Myq739w
         0ES2l2mFxJZtksB3RHDCMw3f4Rsf1RXQdtww9Kqk/2A8W2TDIWQKGDtABToQ14oasETs
         5Sb6Sos9YplrW3JblRiaRaQS34KMax7DwP+1nHUa/bBG5V4G8EwIlSV+fgL9TCUoglyh
         /uUFmDxT2KXnuT9iyAcu/iP52dVHZxmk0RDM6AKTqQkPhYpCQ1ptL/JmBkA7AgtsvxSj
         0wcw==
X-Forwarded-Encrypted: i=1; AHgh+Rr/i0+4w2WNZnUMjEzc/heAknJkC17hc178mE6D0b52JaONzXJIdFxxKpA5fIvgApOcWcKVPx3iQtWr0tZu@vger.kernel.org
X-Gm-Message-State: AOJu0YwR2pG5DiXmNqK+y0pi1fYEVCtkbxQ4bRjNbAHjqkgpZhLlRXAz
	McJCzsmxRr8j38kSJ3RtcPhyazFPCDeFmLsZMIURQ7JXVKeGg7QTvU0OA8qYQy/cHfrc74YDKzP
	huTud2PS1TB9kQRsu+LvNmpdia6gqVVsDMBm2I86fjIE3+TWhBpXTqJjYZFc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c198:b0:491:3ade:8ba0 with SMTP id
 5614622812f47-4b1e7936f09mr3127397b6e.16.1786407878534; Mon, 10 Aug 2026
 17:24:38 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:24:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7a6bc6.01d0871a.3a0d52.00b3.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in configfs_detach_group
From: syzbot <syzbot+245b08b227dcdeb63e2c@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c21bb4193868 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a63bb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f221a1b5d497ed15
dashboard link: https://syzkaller.appspot.com/bug?extid=245b08b227dcdeb63e2c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c21bb419.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ff1def389cf6/vmlinux-c21bb419.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab751d30f9d2/bzImage-c21bb419.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+245b08b227dcdeb63e2c@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.3.304/7178 is trying to acquire lock:
ffff8880005e4880 (&default_group_class[depth - 1]#9){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
ffff8880005e4880 (&default_group_class[depth - 1]#9){+.+.}-{4:4}, at: detach_groups fs/configfs/dir.c:680 [inline]
ffff8880005e4880 (&default_group_class[depth - 1]#9){+.+.}-{4:4}, at: configfs_detach_group+0x21c/0x440 fs/configfs/dir.c:887

but task is already holding lock:
ffff8880005e1900 (&default_group_class[depth - 1]#8){++++}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
ffff8880005e1900 (&default_group_class[depth - 1]#8){++++}-{4:4}, at: detach_groups fs/configfs/dir.c:680 [inline]
ffff8880005e1900 (&default_group_class[depth - 1]#8){++++}-{4:4}, at: configfs_detach_group+0x21c/0x440 fs/configfs/dir.c:887

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&default_group_class[depth - 1]#8){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       down_write+0x8b/0x1f0 kernel/locking/rwsem.c:1631
       inode_lock include/linux/fs.h:1024 [inline]
       detach_groups fs/configfs/dir.c:680 [inline]
       configfs_detach_group+0x21c/0x440 fs/configfs/dir.c:887
       detach_groups fs/configfs/dir.c:682 [inline]
       configfs_detach_group+0x224/0x440 fs/configfs/dir.c:887
       configfs_rmdir+0x598/0x950 fs/configfs/dir.c:1554
       vfs_rmdir fs/namei.c:5381 [inline]
       vfs_rmdir+0x328/0x8a0 fs/namei.c:5354
       filename_rmdir+0x31a/0x5c0 fs/namei.c:5438
       __do_sys_rmdir fs/namei.c:5461 [inline]
       __se_sys_rmdir fs/namei.c:5458 [inline]
       __ia32_sys_rmdir+0x45/0x60 fs/namei.c:5458
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
       __do_fast_syscall_32+0xe7/0x970 arch/x86/entry/syscall_32.c:307
       do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #4 (&default_group_class[depth - 1]#2){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       down_write+0x8b/0x1f0 kernel/locking/rwsem.c:1631
       inode_lock include/linux/fs.h:1024 [inline]
       detach_groups fs/configfs/dir.c:680 [inline]
       configfs_detach_group+0x21c/0x440 fs/configfs/dir.c:887
       configfs_rmdir+0x598/0x950 fs/configfs/dir.c:1554
       vfs_rmdir fs/namei.c:5381 [inline]
       vfs_rmdir+0x328/0x8a0 fs/namei.c:5354
       filename_rmdir+0x31a/0x5c0 fs/namei.c:5438
       __do_sys_rmdir fs/namei.c:5461 [inline]
       __se_sys_rmdir fs/namei.c:5458 [inline]
       __ia32_sys_rmdir+0x45/0x60 fs/namei.c:5458
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
       __do_fast_syscall_32+0xe7/0x970 arch/x86/entry/syscall_32.c:307
       do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #3 (&sb->s_type->i_mutex_key#26){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       down_write+0x8b/0x1f0 kernel/locking/rwsem.c:1631
       inode_lock include/linux/fs.h:1024 [inline]
       configfs_depend_item_unlocked+0xf3/0x6a0 fs/configfs/dir.c:1259
       usbg_make_tpg+0x261/0x620 drivers/usb/gadget/function/f_tcm.c:1686
       target_fabric_make_tpg+0xab/0x8c0 drivers/target/target_core_fabric_configfs.c:939
       configfs_mkdir+0x51e/0xb70 fs/configfs/dir.c:1360
       vfs_mkdir+0x361/0x850 fs/namei.c:5276
       filename_mkdirat+0x48b/0x5e0 fs/namei.c:5309
       __do_sys_mkdir fs/namei.c:5336 [inline]
       __se_sys_mkdir fs/namei.c:5333 [inline]
       __ia32_sys_mkdir+0x6a/0x90 fs/namei.c:5333
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
       __do_fast_syscall_32+0xe7/0x970 arch/x86/entry/syscall_32.c:307
       do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #2 (&opts->dep_lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       tcm_set_name+0x29/0xb0 drivers/usb/gadget/function/f_tcm.c:2669
       function_make+0x21c/0x3f0 drivers/usb/gadget/configfs.c:636
       configfs_mkdir+0x51e/0xb70 fs/configfs/dir.c:1360
       vfs_mkdir+0x361/0x850 fs/namei.c:5276
       filename_mkdirat+0x48b/0x5e0 fs/namei.c:5309
       __do_sys_mkdir fs/namei.c:5336 [inline]
       __se_sys_mkdir fs/namei.c:5333 [inline]
       __ia32_sys_mkdir+0x6a/0x90 fs/namei.c:5333
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
       __do_fast_syscall_32+0xe7/0x970 arch/x86/entry/syscall_32.c:307
       do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #1 (gadget_subsys.su_mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       uvcg_streaming_class_allow_link+0x100/0x6b0 drivers/usb/gadget/function/uvc_configfs.c:3432
       configfs_symlink+0x540/0x11f0 fs/configfs/symlink.c:196
       vfs_symlink fs/namei.c:5660 [inline]
       vfs_symlink+0x178/0x4d0 fs/namei.c:5639
       filename_symlinkat+0x2a6/0x560 fs/namei.c:5685
       __do_sys_symlinkat fs/namei.c:5705 [inline]
       __se_sys_symlinkat fs/namei.c:5700 [inline]
       __ia32_sys_symlinkat+0x9b/0xe0 fs/namei.c:5700
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
       __do_fast_syscall_32+0xe7/0x970 arch/x86/entry/syscall_32.c:307
       do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (&default_group_class[depth - 1]#9){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       down_write+0x8b/0x1f0 kernel/locking/rwsem.c:1631
       inode_lock include/linux/fs.h:1024 [inline]
       detach_groups fs/configfs/dir.c:680 [inline]
       configfs_detach_group+0x21c/0x440 fs/configfs/dir.c:887
       detach_groups fs/configfs/dir.c:682 [inline]
       configfs_detach_group+0x224/0x440 fs/configfs/dir.c:887
       detach_groups fs/configfs/dir.c:682 [inline]
       configfs_detach_group+0x224/0x440 fs/configfs/dir.c:887
       configfs_rmdir+0x598/0x950 fs/configfs/dir.c:1554
       vfs_rmdir fs/namei.c:5381 [inline]
       vfs_rmdir+0x328/0x8a0 fs/namei.c:5354
       filename_rmdir+0x31a/0x5c0 fs/namei.c:5438
       __do_sys_rmdir fs/namei.c:5461 [inline]
       __se_sys_rmdir fs/namei.c:5458 [inline]
       __ia32_sys_rmdir+0x45/0x60 fs/namei.c:5458
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
       __do_fast_syscall_32+0xe7/0x970 arch/x86/entry/syscall_32.c:307
       do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

Chain exists of:
  &default_group_class[depth - 1]#9 --> &default_group_class[depth - 1]#2 --> &default_group_class[depth - 1]#8

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&default_group_class[depth - 1]#8);
                               lock(&default_group_class[depth - 1]#2);
                               lock(&default_group_class[depth - 1]#8);
  lock(&default_group_class[depth - 1]#9);

 *** DEADLOCK ***

5 locks held by syz.3.304/7178:
 #0: ffff88802250c450 (sb_writers#15){.+.+}-{0:0}, at: filename_rmdir+0x1ff/0x5c0 fs/namei.c:5427
 #1: ffff888013f76e80 (&default_group_class[depth - 1]#2/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1069 [inline]
 #1: ffff888013f76e80 (&default_group_class[depth - 1]#2/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2918 [inline]
 #1: ffff888013f76e80 (&default_group_class[depth - 1]#2/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2942 [inline]
 #1: ffff888013f76e80 (&default_group_class[depth - 1]#2/1){+.+.}-{4:4}, at: filename_rmdir+0x258/0x5c0 fs/namei.c:5431
 #2: ffff8880005e0f80 (&sb->s_type->i_mutex_key#26){++++}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
 #2: ffff8880005e0f80 (&sb->s_type->i_mutex_key#26){++++}-{4:4}, at: vfs_rmdir fs/namei.c:5366 [inline]
 #2: ffff8880005e0f80 (&sb->s_type->i_mutex_key#26){++++}-{4:4}, at: vfs_rmdir+0xed/0x8a0 fs/namei.c:5354
 #3: ffff8880005e6e80 (&default_group_class[depth - 1]#2){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
 #3: ffff8880005e6e80 (&default_group_class[depth - 1]#2){+.+.}-{4:4}, at: detach_groups fs/configfs/dir.c:680 [inline]
 #3: ffff8880005e6e80 (&default_group_class[depth - 1]#2){+.+.}-{4:4}, at: configfs_detach_group+0x21c/0x440 fs/configfs/dir.c:887
 #4: ffff8880005e1900 (&default_group_class[depth - 1]#8){++++}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
 #4: ffff8880005e1900 (&default_group_class[depth - 1]#8){++++}-{4:4}, at: detach_groups fs/configfs/dir.c:680 [inline]
 #4: ffff8880005e1900 (&default_group_class[depth - 1]#8){++++}-{4:4}, at: configfs_detach_group+0x21c/0x440 fs/configfs/dir.c:887

stack backtrace:
CPU: 3 UID: 0 PID: 7178 Comm: syz.3.304 Not tainted syzkaller #0 PREEMPT(full) 
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
 down_write+0x8b/0x1f0 kernel/locking/rwsem.c:1631
 inode_lock include/linux/fs.h:1024 [inline]
 detach_groups fs/configfs/dir.c:680 [inline]
 configfs_detach_group+0x21c/0x440 fs/configfs/dir.c:887
 detach_groups fs/configfs/dir.c:682 [inline]
 configfs_detach_group+0x224/0x440 fs/configfs/dir.c:887
 detach_groups fs/configfs/dir.c:682 [inline]
 configfs_detach_group+0x224/0x440 fs/configfs/dir.c:887
 configfs_rmdir+0x598/0x950 fs/configfs/dir.c:1554
 vfs_rmdir fs/namei.c:5381 [inline]
 vfs_rmdir+0x328/0x8a0 fs/namei.c:5354
 filename_rmdir+0x31a/0x5c0 fs/namei.c:5438
 __do_sys_rmdir fs/namei.c:5461 [inline]
 __se_sys_rmdir fs/namei.c:5458 [inline]
 __ia32_sys_rmdir+0x45/0x60 fs/namei.c:5458
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xe7/0x970 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7ff3fec
Code: Unable to access opcode bytes at 0xf7ff3fc2.
RSP: 002b:00000000f54b650c EFLAGS: 00000292 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000080000200 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
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
