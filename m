Received: from mail-oi2-f5.google.com (mail-oi2-f5.google.com [74.125.231.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E72175A80
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2026 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273831; cv=none; b=R7ktj4S51bI2g+Hibk1ayL/ZIobW6RTv9JKFFIQTeL3xMstcl/9EZ+7fEYRPU4wl0gvUdZciaUmGmQLcPYBeOorfPqPIoxLcFOozDW7O/fl5JZMaNwgD530uf0JTryBalg+93dF/iDarPwG9a/wXxtONWpmdNeDKNB+K3DrYsX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273831; c=relaxed/simple;
	bh=TQgFlwPdI4zA03bXAdtEJSGhgdqgKCcQyo9J97o4buQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dcoVtG+bTjIKCEYzCW4UZsbfK4CTF6/oTygk2Kgc9u1g83m77opNR2QTB5ZhCye/pBVRhRRKHLzRE55y9Pslwu1Hr48SLQQCwV/UcwVuH65HjKw+Omj/RBANFd4WfKfSnOvwiyurWCdMoIRZj3xXC5/NB2GIAnmRzI0FC3BiRLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f5.google.com with SMTP id 5614622812f47-4b3759b7ff0so1948454b6e.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2026 07:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273829; x=1788878629;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SGFAxB12JeY2QizAxCcdqjroGpz+aeSxqyXMKgYLsNE=;
        b=X2TO83O4ywQv5guXBO+9841QN4F0Kh9crwj/Vj35zkQMt5EjKPyShe3mAM98iwcT9T
         OVs8XRu1wYc6QJ2AKHHoigxlRvfcJOtXo5ZVEAnU1+fmTri4HFnTcKbc0FsspCADQr18
         xCgMpReGB3+3C0wva0AMjGWY2D0XGG1T4vNFanWGgqRAG38cvI28ly5RRiN46sV8ZJB7
         epIrr3wnIT/ESMV2XE59mvtjcNpVx2ETdit7Myyd2biODSkGx3mySQBzBISq0oyAiS18
         nCCOZb4AJSoX5WhGHFDPQp5fg7wIiANURERgvNfmCb4mtCVjqlhzWxtWYwI9qoqqqUK7
         wobg==
X-Forwarded-Encrypted: i=1; AHgh+RquQ/A2dgkwLoJI4FSM8sKcV2iWYBIsNETIxf8NJF/sMYRd8686/VgJmKOPQP1IVfYDufl73V6DWkU4evSS@vger.kernel.org
X-Gm-Message-State: AFuF++nOXUpQu+NK6wnvNLeylE88uQAjRkpwXsHMcOWXQti3g8CFY+nP
	CrxtVjHiON7uy36fPMxhj6mNEvdiI3dr/KID5/bJNzZ/Tp7wk3ggATpoV1wv484elR8iMEsHhz4
	U5CK0QrNASkCEBX58vsy44SxaZuk3WmR8eIC0iGupE9mOXoQYhcIAiolvtco=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:14d5:b0:4b1:b037:da8b with SMTP id
 5614622812f47-4b39818826cmr31619891b6e.11.1788273828862; Tue, 01 Sep 2026
 07:43:48 -0700 (PDT)
Date: Tue, 01 Sep 2026 07:43:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a96e4a4.04428c52.29b18.0006.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in uvcg_extension_ba_source_id_store
From: syzbot <syzbot+76d92b6236b6ff1fc991@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    818bebeb63dd drm/xe: Don't hand out the flat CCS storage a..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ba6d79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccca94d2c01b9e78
dashboard link: https://syzkaller.appspot.com/bug?extid=76d92b6236b6ff1fc991
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-818bebeb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6e4100526b12/vmlinux-818bebeb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/723c4783ee96/bzImage-818bebeb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76d92b6236b6ff1fc991@syzkaller.appspotmail.com

openvswitch: netlink: Either Ethernet header or EtherType is required.
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.0.1880/13612 is trying to acquire lock:
ffffffff903dfc08 (gadget_subsys.su_mutex){+.+.}-{4:4}, at: uvcg_extension_ba_source_id_store+0xdb/0x430 drivers/usb/gadget/function/uvc_configfs.c:1046

but task is already holding lock:
ffff888049f5da70 (&p->frag_sem){++++}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
ffff888049f5da70 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x218/0x4e0 fs/configfs/file.c:229

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&p->frag_sem){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5886 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5843
       down_write_killable+0x93/0x240 kernel/locking/rwsem.c:1643
       configfs_rmdir+0x3fa/0x950 fs/configfs/dir.c:1534
       vfs_rmdir fs/namei.c:5515 [inline]
       vfs_rmdir+0x328/0x8a0 fs/namei.c:5488
       filename_rmdir+0x31a/0x5c0 fs/namei.c:5572
       __do_sys_rmdir fs/namei.c:5595 [inline]
       __se_sys_rmdir fs/namei.c:5592 [inline]
       __x64_sys_rmdir+0x46/0x70 fs/namei.c:5592
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&sb->s_type->i_mutex_key#29){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5886 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5843
       down_write+0x8b/0x1f0 kernel/locking/rwsem.c:1631
       inode_lock include/linux/fs.h:1025 [inline]
       configfs_depend_item_unlocked+0xf3/0x6a0 fs/configfs/dir.c:1259
       usbg_make_tpg+0x261/0x620 drivers/usb/gadget/function/f_tcm.c:1686
       target_fabric_make_tpg+0xab/0x8c0 drivers/target/target_core_fabric_configfs.c:939
       configfs_mkdir+0x51e/0xb70 fs/configfs/dir.c:1360
       vfs_mkdir+0x364/0x850 fs/namei.c:5410
       filename_mkdirat+0x48b/0x5e0 fs/namei.c:5443
       __do_sys_mkdir fs/namei.c:5470 [inline]
       __se_sys_mkdir fs/namei.c:5467 [inline]
       __x64_sys_mkdir+0x6b/0x90 fs/namei.c:5467
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&opts->dep_lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5886 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5843
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bc0 kernel/locking/mutex.c:821
       tcm_set_name+0x29/0xb0 drivers/usb/gadget/function/f_tcm.c:2669
       function_make+0x21c/0x3f0 drivers/usb/gadget/configfs.c:636
       configfs_mkdir+0x51e/0xb70 fs/configfs/dir.c:1360
       vfs_mkdir+0x364/0x850 fs/namei.c:5410
       filename_mkdirat+0x48b/0x5e0 fs/namei.c:5443
       __do_sys_mkdir fs/namei.c:5470 [inline]
       __se_sys_mkdir fs/namei.c:5467 [inline]
       __x64_sys_mkdir+0x6b/0x90 fs/namei.c:5467
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (gadget_subsys.su_mutex){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3181
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x1492/0x1ec0 kernel/locking/lockdep.c:5253
       lock_acquire kernel/locking/lockdep.c:5886 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5843
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bc0 kernel/locking/mutex.c:821
       uvcg_extension_ba_source_id_store+0xdb/0x430 drivers/usb/gadget/function/uvc_configfs.c:1046
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6af/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  gadget_subsys.su_mutex --> &sb->s_type->i_mutex_key#29 --> &p->frag_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&p->frag_sem);
                               lock(&sb->s_type->i_mutex_key#29);
                               lock(&p->frag_sem);
  lock(gadget_subsys.su_mutex);

 *** DEADLOCK ***

locks held by syz.0.1880/13612: 4, last CPU#2:
 #0: ffff888035452470 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2aa/0x380 fs/file.c:1259
 #1: ffff888024144460 (sb_writers#16){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #2: ffff888064e84080 (&buffer->mutex#2){+.+.}-{4:4}, at: configfs_write_iter+0x76/0x4e0 fs/configfs/file.c:226
 #3: ffff888049f5da70 (&p->frag_sem){++++}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
 #3: ffff888049f5da70 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x218/0x4e0 fs/configfs/file.c:229

stack backtrace:
CPU: 2 UID: 0 PID: 13612 Comm: syz.0.1880 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2059
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2191
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3181
 check_prevs_add kernel/locking/lockdep.c:3300 [inline]
 validate_chain kernel/locking/lockdep.c:3924 [inline]
 __lock_acquire+0x1492/0x1ec0 kernel/locking/lockdep.c:5253
 lock_acquire kernel/locking/lockdep.c:5886 [inline]
 lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5843
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x1a4/0x1bc0 kernel/locking/mutex.c:821
 uvcg_extension_ba_source_id_store+0xdb/0x430 drivers/usb/gadget/function/uvc_configfs.c:1046
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6af/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f475e39e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f475f310028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f475e625fa0 RCX: 00007f475e39e159
RDX: 0000000000000011 RSI: 0000200000000440 RDI: 0000000000000009
RBP: 00007f475e435024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f475e626038 R14: 00007f475e625fa0 R15: 00007fff043810d8
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
