Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480079;
	b=FGVe9AVp0SpQVu6z3j8EhAIdEyXIs8cEkn77KnRUOMAb5cA33mHmkQg8A9UhCpWqNhnf
	 ivZwPWh85zZQxXKWAQQFBxUzMrd3KzqYOetk/3KCALLIBK4McDXp8R/708AMiJo7NSh6R
	 8fgFQeSsB20QgDy8aoxFQpBuzMYAyy9A1Yhvb6yYhRLstgMPYdEoJMhFZLUjHUpxZwB/J
	 a/51LiMFYxDRtNuUnoSYCOz9jTp+nWvcE8ovEsxAAJoY+TyTA18GCkdT3gxnD8O+gxdIk
	 O4AGageEDAfU9aVBoXz5UOmZcG5QRMTqq1RiOSSUsJTI04HT1bjo3fIQyl4ocvzJzCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480079;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=niGpBEBKZQ30gEFAKXw7SZgk8z9v7/XaYOYlCfDIrrI=;
	b=xbZIkYpvy+O/NJW6tpXkNqhpk2jFZ5N9wm+dHHyJDnNk29kmTfjzCHJIlsLAVfgA+kT+
	 G28a1zWVlyBKdQsRZ/9EWDoNFqxRXMkTrL+TW1u857O86t7FhjqsZhBoJIx8XEamzh183
	 LpMDrPW7UGelQIoTT82ZlCn/jBhU667GaA/D70K6Cvi0dS31m1n1TPUDK73agBmOW+TVF
	 a2M+LWjM8yOV5Xh6suRTrejdFWV5+wD88LrwKv0//89H2BrfDCNbjKirHc7JNqVQAYv5R
	 k1pb62io2aQFM4xnIquCdWlxGHQnFjmjjw1+LG+ztmE0qOSwaoQMXqrk0r78lScH0cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5DB606A320
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 07:07:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA5DB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b28d7ffab1so646965b6e.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 00:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792480077; x=1793084877;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=niGpBEBKZQ30gEFAKXw7SZgk8z9v7/XaYOYlCfDIrrI=;
        b=Kfdeqca8yX3rlwv09OtYcfZfN7qKEbTMvYn+3YpqHmMgwUQW2M1TuWzI3V5JfVissB
         8dfB/Oik5Liw51OyUX2JmLnpTpmlpSkbNrvCTxrvSmWkkQKrQpOAHn4Tob7thGBHRpXW
         i+do0r+b+9BssfULFRErgnpSs1S1xOJnmNc6Fgy6Yrrv1AC6lKpjPDSIF0V7QnDeuvYy
         XcANhNgEvaCYrH+cx4qiUJxFa9BMX1UdfOAmKfj3X2vOBcKxKRBBZqoZs/bjb33PZGnS
         OhstlSljM3ttYDuwDzHMaL0sJYSdpnDS6QWJrzftFM8h/lCriQSmgTZdyWC5lixzp8u+
         dnPw==
X-Gm-Message-State: AFq9FYKiT/CjAICn6xxhdCYFHuGm1pNPXR46Ho54eqIWS3GziN2x+F2W
	o8D1hlZ44GQ0f5i7HWVqftJDze/g+K2yvCXCzHQNNjylHraUyPkKjh4Vrjyj73NY5ObLk/t7g+0
	Oyv4qYj7iZq/iAlPCAoOErxn9pc/CywOdjR96xG2wRfqhB4FQ3ZVB3l5o1Jw=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:660a:b0:4ea:935e:43d6 with SMTP id
 5614622812f47-54d98a26ef8mr713958b6e.45.1792480077641; Tue, 20 Oct 2026
 00:07:57 -0700 (PDT)
Date: Tue, 20 Oct 2026 00:07:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad7134d.b5bd089a.6b57.0088.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in uvcg_default_processing_bm_controls_show
From: syzbot <syzbot+d123c96491067a2ee754@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a0ff06b3a7bd Merge tag 'firewire-fixes-7.3-final' of git:/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10c64bc9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=44ac479246d4559b
dashboard link: https://syzkaller.appspot.com/bug?extid=d123c96491067a2ee754
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cb5495580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d123c96491067a2ee754@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz-executor434/6013 is trying to acquire lock:
ffffffff91402ce8 (gadget_subsys.su_mutex){+.+.}-{4:4}, at: uvcg_default_processing_bm_controls_show+0x57/0x2a0 drivers/usb/gadget/function/uvc_configfs.c:408

but task is already holding lock:
ffff888000c93470 (&p->frag_sem){++++}-{4:4}, at: fill_read_buffer fs/configfs/file.c:66 [inline]
ffff888000c93470 (&p->frag_sem){++++}-{4:4}, at: configfs_read_iter+0x346/0x6f0 fs/configfs/file.c:88

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&p->frag_sem){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       down_write_killable+0x93/0x240 kernel/locking/rwsem.c:1643
       configfs_rmdir+0x3fa/0x950 fs/configfs/dir.c:1543
       vfs_rmdir fs/namei.c:5514 [inline]
       vfs_rmdir+0x328/0x8a0 fs/namei.c:5487
       filename_rmdir+0x31a/0x5c0 fs/namei.c:5571
       __do_sys_rmdir fs/namei.c:5594 [inline]
       __se_sys_rmdir fs/namei.c:5591 [inline]
       __ia32_sys_rmdir+0x45/0x60 fs/namei.c:5591
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
       __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
       do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #3 (&sb->s_type->i_mutex_key#25){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       down_write+0x8b/0x1f0 kernel/locking/rwsem.c:1631
       inode_lock include/linux/fs.h:1024 [inline]
       configfs_depend_item_unlocked+0xf3/0x6a0 fs/configfs/dir.c:1268
       usbg_make_tpg+0x251/0x610 drivers/usb/gadget/function/f_tcm.c:1692
       target_fabric_make_tpg+0xab/0x8c0 drivers/target/target_core_fabric_configfs.c:947
       configfs_mkdir+0x525/0xd40 fs/configfs/dir.c:1369
       vfs_mkdir+0x364/0x850 fs/namei.c:5409
       filename_mkdirat+0x48b/0x5e0 fs/namei.c:5442
       __do_sys_mkdir fs/namei.c:5469 [inline]
       __se_sys_mkdir fs/namei.c:5466 [inline]
       __ia32_sys_mkdir+0x6a/0x90 fs/namei.c:5466
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
       __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
       do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #2 (tpg_instances_lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       tcm_alloc_inst+0x5f/0x1e0 drivers/usb/gadget/function/f_tcm.c:2687
       try_get_usb_function_instance+0x136/0x1f0 drivers/usb/gadget/functions.c:28
       usb_get_function_instance+0x16/0x70 drivers/usb/gadget/functions.c:44
       function_make+0x18c/0x3f0 drivers/usb/gadget/configfs.c:626
       configfs_mkdir+0x525/0xd40 fs/configfs/dir.c:1369
       vfs_mkdir+0x364/0x850 fs/namei.c:5409
       filename_mkdirat+0x48b/0x5e0 fs/namei.c:5442
       __do_sys_mkdir fs/namei.c:5469 [inline]
       __se_sys_mkdir fs/namei.c:5466 [inline]
       __ia32_sys_mkdir+0x6a/0x90 fs/namei.c:5466
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
       __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
       do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #1 (func_lock){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       try_get_usb_function_instance+0x26/0x1f0 drivers/usb/gadget/functions.c:18
       usb_get_function_instance+0x16/0x70 drivers/usb/gadget/functions.c:44
       function_make+0x18c/0x3f0 drivers/usb/gadget/configfs.c:626
       configfs_mkdir+0x525/0xd40 fs/configfs/dir.c:1369
       vfs_mkdir+0x364/0x850 fs/namei.c:5409
       filename_mkdirat+0x48b/0x5e0 fs/namei.c:5442
       __do_sys_mkdir fs/namei.c:5469 [inline]
       __se_sys_mkdir fs/namei.c:5466 [inline]
       __ia32_sys_mkdir+0x6a/0x90 fs/namei.c:5466
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
       __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
       do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

-> #0 (gadget_subsys.su_mutex){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       uvcg_default_processing_bm_controls_show+0x57/0x2a0 drivers/usb/gadget/function/uvc_configfs.c:408
       fill_read_buffer fs/configfs/file.c:68 [inline]
       configfs_read_iter+0x426/0x6f0 fs/configfs/file.c:88
       new_sync_read fs/read_write.c:493 [inline]
       vfs_read+0x82e/0xb40 fs/read_write.c:574
       ksys_read+0x12a/0x250 fs/read_write.c:716
       do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
       __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
       do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
       entry_SYSENTER_compat_after_hwframe+0x84/0x8e

other info that might help us debug this:

Chain exists of:
  gadget_subsys.su_mutex --> &sb->s_type->i_mutex_key#25 --> &p->frag_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&p->frag_sem);
                               lock(&sb->s_type->i_mutex_key#25);
                               lock(&p->frag_sem);
  lock(gadget_subsys.su_mutex);

 *** DEADLOCK ***

locks held by syz-executor434/6013: 2, last CPU#1:
 #0: ffff8880500c0280 (&buffer->mutex){+.+.}-{4:4}, at: configfs_read_iter+0x79/0x6f0 fs/configfs/file.c:86
 #1: ffff888000c93470 (&p->frag_sem){++++}-{4:4}, at: fill_read_buffer fs/configfs/file.c:66 [inline]
 #1: ffff888000c93470 (&p->frag_sem){++++}-{4:4}, at: configfs_read_iter+0x346/0x6f0 fs/configfs/file.c:88

stack backtrace:
CPU: 1 UID: 0 PID: 6013 Comm: syz-executor434 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2087
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2219
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
 lock_acquire kernel/locking/lockdep.c:5942 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
 uvcg_default_processing_bm_controls_show+0x57/0x2a0 drivers/usb/gadget/function/uvc_configfs.c:408
 fill_read_buffer fs/configfs/file.c:68 [inline]
 configfs_read_iter+0x426/0x6f0 fs/configfs/file.c:88
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x82e/0xb40 fs/read_write.c:574
 ksys_read+0x12a/0x250 fs/read_write.c:716
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:79 [inline]
 __do_fast_syscall_32+0x13a/0x8b0 arch/x86/entry/syscall_32.c:291
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:316
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf7ee5fec
Code: Unable to access opcode bytes at 0xf7ee5fc2.
RSP: 002b:00000000ff9e98b0 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000ff9e9970
RDX: 00000000000000ff RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
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
