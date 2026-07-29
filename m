Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A713FCB0C
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 10:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320365; cv=none; b=sf0qtcbWMQbAv1d1aVuA1n90fTR26ChRYoJJb3IDLNTLJsP9+pikhCja4JQ1AYaUL2xq9Oweruu2ymqNtmaAhKjTYe82m0oj1SnwnCnISso3ENg0H+z7jDCFpZx0Ncf0Ih6pFVEj8K3VwwQ56jokDwFksbqvUkPt6ze6G2QeIvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320365; c=relaxed/simple;
	bh=ZrnBhC2pV/NrAagh1VKoynYj4bPkT4h92zuCTuyWyYE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=vA0WNgLGYqpToEihSTYUrwuoHh/0xpiyrqTcZG+Op9LOUJXC6/oRPYDvM7+bHKO5Y01KkixlSG3JW5i86xsu8zHlyK7vPiX1J7T3pbh/yN8j2fpKuL9BRgeNyie93WAhtNNOiCFbCQeidbWcTJUyeg1Ntru00INvm2y2UAiBNsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-495b8120909so796782b6e.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 03:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785320362; x=1785925162;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qqc+pHP6TpW5Ej1qgOPRg3Oevh1pyPNqFCPunPsaHdM=;
        b=WQhuuG68Vqkear70WTw61KOyLGO4qwDw/CBKHwoMIHF72p4vwWoo3qAVk1YkEd198M
         8TZ/MaD2PlXYJIbW4mVkNmOtzxSyVvffL6ZQAXSOsELajDmbetUY9kgNcudJHs7ZZzsy
         Ya02XZAuxCLKjwD+46xQzgdW8eu1jrPY70WpoiFumTL1giHSp5rF/J/ObOJ+k9Bd4uo+
         q9PkFSKCRHXUcYwZH7o1hGwF8OQ9grWC3PQ//CoS/ASFbb0GJL7dXcFGINBEYruI38jn
         kRRXM6FC4/CrI2IITTrQJx/nXKjUYnvk4BExZrf4W7EIHSZMYUPDhyzKAqUpLCwBOB84
         ny8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrbr0ADuRm4O+z0RZiT/mrEzgZpvZTIsRNpzR1Q3djTvzW8RwtlMfHxL9jQE1BSTQ/X/8kuE8HV7Nl5R4s6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsxd32SV75Ni4k5fWMmjfFxGwvR4pz7ruuGDK7GmMpVQY/2ovH
	dJ/rfqRt+0S7idu+UiLS5l7FrTz2d5LyhlguZTen10aJZLRrAr4NGd76pHmt4RBSxh7pVgu7bp3
	etN7xQiBy0lsQPNU2284OcHzJNdjblaF4RI0sJ3hFs04NzWNg934iY7q+yuQ=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1407:b0:49a:72a:4e45 with SMTP id
 5614622812f47-4ad5bbe0d65mr3076496b6e.39.1785320362465; Wed, 29 Jul 2026
 03:19:22 -0700 (PDT)
Date: Wed, 29 Jul 2026 03:19:22 -0700
In-Reply-To: <6a68af31.073198cf.94f0f.0048.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a69d3aa.cf6637f5.2f8219.0031.GAE@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in configfs_rmdir
From: syzbot <syzbot+c9f9d646b08f3b6032fe@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fc02acf6ac0c Merge tag 'platform-drivers-x86-v7.2-4' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15db5632580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=c9f9d646b08f3b6032fe
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1496003e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142017b1580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-fc02acf6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eca05900a79c/vmlinux-fc02acf6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e655b72e0b5f/bzImage-fc02acf6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c9f9d646b08f3b6032fe@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.18/5928 is trying to acquire lock:
ffffffff901d0908 (gadget_subsys.su_mutex){+.+.}-{4:4}, at: configfs_rmdir+0x5ae/0x950 fs/configfs/dir.c:1556

but task is already holding lock:
ffff88803aa6f800 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
ffff88803aa6f800 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: vfs_rmdir fs/namei.c:5366 [inline]
ffff88803aa6f800 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: vfs_rmdir+0xed/0x8a0 fs/namei.c:5354

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}:
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
       __x64_sys_mkdir+0x6b/0x90 fs/namei.c:5333
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&opts->dep_lock){+.+.}-{4:4}:
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
       __x64_sys_mkdir+0x6b/0x90 fs/namei.c:5333
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (gadget_subsys.su_mutex){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       configfs_rmdir+0x5ae/0x950 fs/configfs/dir.c:1556
       vfs_rmdir fs/namei.c:5381 [inline]
       vfs_rmdir+0x328/0x8a0 fs/namei.c:5354
       filename_rmdir+0x31a/0x5c0 fs/namei.c:5438
       __do_sys_unlinkat fs/namei.c:5613 [inline]
       __se_sys_unlinkat fs/namei.c:5606 [inline]
       __x64_sys_unlinkat+0xf5/0x130 fs/namei.c:5606
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  gadget_subsys.su_mutex --> &opts->dep_lock --> &sb->s_type->i_mutex_key#24

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#24);
                               lock(&opts->dep_lock);
                               lock(&sb->s_type->i_mutex_key#24);
  lock(gadget_subsys.su_mutex);

 *** DEADLOCK ***

3 locks held by syz.0.18/5928:
 #0: ffff888023d44450 (sb_writers#13){.+.+}-{0:0}, at: filename_rmdir+0x1ff/0x5c0 fs/namei.c:5427
 #1: ffff888047c6e9c0 (&default_group_class[depth - 1]#2/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1069 [inline]
 #1: ffff888047c6e9c0 (&default_group_class[depth - 1]#2/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2918 [inline]
 #1: ffff888047c6e9c0 (&default_group_class[depth - 1]#2/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2942 [inline]
 #1: ffff888047c6e9c0 (&default_group_class[depth - 1]#2/1){+.+.}-{4:4}, at: filename_rmdir+0x258/0x5c0 fs/namei.c:5431
 #2: ffff88803aa6f800 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1024 [inline]
 #2: ffff88803aa6f800 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: vfs_rmdir fs/namei.c:5366 [inline]
 #2: ffff88803aa6f800 (&sb->s_type->i_mutex_key#24){+.+.}-{4:4}, at: vfs_rmdir+0xed/0x8a0 fs/namei.c:5354

stack backtrace:
CPU: 3 UID: 0 PID: 5928 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
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
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
 configfs_rmdir+0x5ae/0x950 fs/configfs/dir.c:1556
 vfs_rmdir fs/namei.c:5381 [inline]
 vfs_rmdir+0x328/0x8a0 fs/namei.c:5354
 filename_rmdir+0x31a/0x5c0 fs/namei.c:5438
 __do_sys_unlinkat fs/namei.c:5613 [inline]
 __se_sys_unlinkat fs/namei.c:5606 [inline]
 __x64_sys_unlinkat+0xf5/0x130 fs/namei.c:5606
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f838c39de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd033e6618 EFLAGS: 00000246 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 00007f838c625fa0 RCX: 00007f838c39de99
RDX: 0000000000000200 RSI: 0000200000000480 RDI: ffffffffffffff9c
RBP: 00007f838c433eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f838c625fac R14: 00007f838c625fa0 R15: 00007f838c625fa0
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
