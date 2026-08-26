Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078AA31D72E
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 04:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787717607; cv=none; b=WVHmx7X2dSEvqpA45c3eZpSVVz5SgjwIRM2lGfd3n7ZOpxdczjOilRMJyofnI2rK/XUYba1wNJUYd3HfESyc3HXadQhvvYrTMIOCD/xx9wbdP5b4noLRkkDgCaAvuQs6bV0WpYNnYuLcyeSL0Mg1MF142J2SkQ/prW+ZlGf+lCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787717607; c=relaxed/simple;
	bh=1OI7Hn2OtUsGj2g6wD2ncM/i6yJfXdGnkt+CXZRmuhI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oO9vYt2YyqBUzSeAEsvD78tZXpKvbJKyCRhR5GvDKpOJ9gCL4kp5azmwAPxkv8Ol5JxUSL+OTneN+z+6iPQaFe64jXxcs4syvb0b5tYd+fVoNw9PZffFEMCkb4nk7vrh+neRU62mwtV23bzmc8CnKqI+5TfygMxIwG8NAisvZ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-485ebc5706cso2894917b6e.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 21:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787717604; x=1788322404;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dH8LMgq2lClqzertM4aEA6NkNerUxL8wmZ/eyeuD01A=;
        b=Qqeds2YphxnfTkF9vu+As/G7HW8SiGcxeozCccNk3Nor8Rto6fioJisty3GvdFhYHs
         mqk+cO8pVgo+tSXE931JhJuOGZ7wb7wEd21SAgwP5MmEA8RyadxCNeLlWidXY4HAKCCP
         HRDjPWo8zfO5yMhjD12QpCGAv4IbH71xIuEYlFTfdj4YmRvs9KOd6qU/AN8eoxHvZc6x
         Oe28h/lIbSQZmA+QXjs1Ctp+HSmaIlbJtQ0hOV1xYMRi/XFKQt1hDOpdooKgUqRL8VQl
         22rR0pBSCLZcFTiszeMGYRVM1QI8WIJ2FvyOzNFODPBu30dWxqD7O/Fw+/Gu9rdheqfd
         epcQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrl/9pDLtNges8pOSkZ76jtiMOOuRDs5mDM6oj5qKnL9YDuyyPGv2Pt/XWHo2bfvv3RQ0g51stK3XOAEhFA@vger.kernel.org
X-Gm-Message-State: AFuF++n4XkhQJ/5aC45gus93vxD1z/IWxpBNaJ685VcwLK2588LEkbI7
	d/sJIR4GmDkh9RabV4DaHy7tzbSf1mBzQnEXDkH4C1lnmL8WM9BUJzKLqb/cV5mi2UYt/q2bvzG
	BCqnCmZZ51pCeJSDQ88rG8nf7GqHUTloe5yKoCV8EMLXPqRSQjkPSPw7l3oI=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6f93:b0:496:9ee:e538 with SMTP id
 5614622812f47-4b3502886bemr9512518b6e.5.1787717604000; Tue, 25 Aug 2026
 21:13:24 -0700 (PDT)
Date: Tue, 25 Aug 2026 21:13:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8e67e3.91706f20.ef82.0014.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in uvcg_frame_dw_max_video_frame_buffer_size_show
From: syzbot <syzbot+56ec747ac8dd3a35cdeb@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    818bebeb63dd drm/xe: Don't hand out the flat CCS storage a..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133d1549580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a263b38e64491d5
dashboard link: https://syzkaller.appspot.com/bug?extid=56ec747ac8dd3a35cdeb
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/987f25555283/disk-818bebeb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0b351e1afd72/vmlinux-818bebeb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/58f64cf2ad53/bzImage-818bebeb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+56ec747ac8dd3a35cdeb@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.6.2659/15951 is trying to acquire lock:
ffffffff8ef795e0 (gadget_subsys.su_mutex){+.+.}-{4:4}, at: uvcg_frame_dw_max_video_frame_buffer_size_show+0x6c/0x180 drivers/usb/gadget/function/uvc_configfs.c:2033

but task is already holding lock:
ffff888040528a68 (&p->frag_sem){++++}-{4:4}, at: fill_read_buffer fs/configfs/file.c:66 [inline]
ffff888040528a68 (&p->frag_sem){++++}-{4:4}, at: configfs_read_iter+0x1cf/0x620 fs/configfs/file.c:88

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&p->frag_sem){++++}-{4:4}:
       down_write_killable+0x4a/0x80 kernel/locking/rwsem.c:1643
       configfs_rmdir+0x3b0/0x950 fs/configfs/dir.c:1534
       vfs_rmdir+0x3e9/0x6b0 fs/namei.c:5515
       filename_rmdir+0x292/0x520 fs/namei.c:5572
       __do_sys_rmdir fs/namei.c:5595 [inline]
       __se_sys_rmdir+0x2e/0x140 fs/namei.c:5592
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&sb->s_type->i_mutex_key#27){++++}-{4:4}:
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1631
       inode_lock include/linux/fs.h:1025 [inline]
       configfs_depend_item_unlocked+0x153/0x420 fs/configfs/dir.c:1259
       usbg_make_tpg+0x1f6/0x590 drivers/usb/gadget/function/f_tcm.c:1686
       target_fabric_make_tpg+0xa8/0x6d0 drivers/target/target_core_fabric_configfs.c:939
       configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1360
       vfs_mkdir+0x408/0x620 fs/namei.c:5410
       filename_mkdirat+0x289/0x520 fs/namei.c:5443
       __do_sys_mkdir fs/namei.c:5470 [inline]
       __se_sys_mkdir+0x34/0x150 fs/namei.c:5467
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&opts->dep_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       tcm_set_name+0x2b/0xd0 drivers/usb/gadget/function/f_tcm.c:2669
       function_make+0x1a8/0x360 drivers/usb/gadget/configfs.c:636
       configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1360
       vfs_mkdir+0x408/0x620 fs/namei.c:5410
       filename_mkdirat+0x289/0x520 fs/namei.c:5443
       __do_sys_mkdir fs/namei.c:5470 [inline]
       __se_sys_mkdir+0x34/0x150 fs/namei.c:5467
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (gadget_subsys.su_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3181 [inline]
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x1520/0x2ce0 kernel/locking/lockdep.c:5253
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5886
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       uvcg_frame_dw_max_video_frame_buffer_size_show+0x6c/0x180 drivers/usb/gadget/function/uvc_configfs.c:2033
       fill_read_buffer fs/configfs/file.c:68 [inline]
       configfs_read_iter+0x2ba/0x620 fs/configfs/file.c:88
       __kernel_read+0x4d3/0x970 fs/read_write.c:532
       integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:222 [inline]
       ima_calc_file_hash+0x45d/0x8a0 security/integrity/ima/ima_crypto.c:280
       ima_collect_measurement+0x521/0xa10 security/integrity/ima/ima_api.c:300
       process_measurement+0x1282/0x1c20 security/integrity/ima/ima_main.c:425
       ima_file_check+0xe1/0x130 security/integrity/ima/ima_main.c:685
       security_file_post_open+0xb3/0x260 security/security.c:2755
       do_open fs/namei.c:4839 [inline]
       path_openat+0x148a/0x1d60 fs/namei.c:5000
       do_file_open+0x23e/0x4a0 fs/namei.c:5029
       do_sys_openat2+0x115/0x200 fs/open.c:1417
       do_sys_open fs/open.c:1423 [inline]
       __do_sys_open fs/open.c:1431 [inline]
       __se_sys_open fs/open.c:1427 [inline]
       __x64_sys_open+0x11e/0x150 fs/open.c:1427
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  gadget_subsys.su_mutex --> &sb->s_type->i_mutex_key#27 --> &p->frag_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&p->frag_sem);
                               lock(&sb->s_type->i_mutex_key#27);
                               lock(&p->frag_sem);
  lock(gadget_subsys.su_mutex);

 *** DEADLOCK ***

locks held by syz.6.2659/15951: 3, last CPU#0:
 #0: ffff88803b82a658 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: process_measurement+0x7e0/0x1c20 security/integrity/ima/ima_main.c:319
 #1: ffff888033ff3078 (&buffer->mutex){+.+.}-{4:4}, at: configfs_read_iter+0x73/0x620 fs/configfs/file.c:86
 #2: ffff888040528a68 (&p->frag_sem){++++}-{4:4}, at: fill_read_buffer fs/configfs/file.c:66 [inline]
 #2: ffff888040528a68 (&p->frag_sem){++++}-{4:4}, at: configfs_read_iter+0x1cf/0x620 fs/configfs/file.c:88

stack backtrace:
CPU: 0 UID: 0 PID: 15951 Comm: syz.6.2659 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2059
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2191
 check_prev_add kernel/locking/lockdep.c:3181 [inline]
 check_prevs_add kernel/locking/lockdep.c:3300 [inline]
 validate_chain kernel/locking/lockdep.c:3924 [inline]
 __lock_acquire+0x1520/0x2ce0 kernel/locking/lockdep.c:5253
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5886
 __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
 mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
 uvcg_frame_dw_max_video_frame_buffer_size_show+0x6c/0x180 drivers/usb/gadget/function/uvc_configfs.c:2033
 fill_read_buffer fs/configfs/file.c:68 [inline]
 configfs_read_iter+0x2ba/0x620 fs/configfs/file.c:88
 __kernel_read+0x4d3/0x970 fs/read_write.c:532
 integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:222 [inline]
 ima_calc_file_hash+0x45d/0x8a0 security/integrity/ima/ima_crypto.c:280
 ima_collect_measurement+0x521/0xa10 security/integrity/ima/ima_api.c:300
 process_measurement+0x1282/0x1c20 security/integrity/ima/ima_main.c:425
 ima_file_check+0xe1/0x130 security/integrity/ima/ima_main.c:685
 security_file_post_open+0xb3/0x260 security/security.c:2755
 do_open fs/namei.c:4839 [inline]
 path_openat+0x148a/0x1d60 fs/namei.c:5000
 do_file_open+0x23e/0x4a0 fs/namei.c:5029
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_open fs/open.c:1431 [inline]
 __se_sys_open fs/open.c:1427 [inline]
 __x64_sys_open+0x11e/0x150 fs/open.c:1427
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae2ac1e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fae28a11028 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fae2aea6270 RCX: 00007fae2ac1e0d9
RDX: 0000000000000082 RSI: 0000000000000000 RDI: 0000200000000640
RBP: 00007fae2acb5024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fae2aea6308 R14: 00007fae2aea6270 R15: 00007ffdeb312178
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
