Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E337083C
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787012972; cv=none; b=J5IQregTznW0qvqzx9UnVKMoNCvK2y1vvMG6JQeBMt5zsTD+yrR94ZNxwTDpHEffAR0BdwX70As7CVFgv4gArHUEa+348FvioXLJtACxqXNTTC2xUvMV7kCOJFUCvJ7ZdUQv2dif2h/sOr74e2X2o99CVspwksd8/G6BiKFIMnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787012972; c=relaxed/simple;
	bh=UuCchqbDEwctFuq8b0pty1cAkYgCBgZFTswO/9kdAAs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=O9iPqC2LNk9ES7ika4KgkFZGG2v/50/RugU9VsRQWkgS7aZI9+6ofQRuCDZUZCLVov8Ogt1PuvRWyjJjDpq18WW3cQadmbeMPh+0lJdrPu/MswFYTQoUOhPqsBPMewZrLYyCEmZIr1SXK8wpVJ8MpVdIO4Mx/C31DHDd74q8Qsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7ec6685adabso5892539a34.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 17:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787012970; x=1787617770;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dbFmDevF/ewQr//rxE5Al15zDi6A8CIgeBT7RBb5/KA=;
        b=UPvlY1Nww+an235Fe17CjYOnkqD48kNvet+l6wAsc0N07eKUwShNPpk/PUht/2bPD3
         h86iXXhhFNEyI/9ukKSeA3KHBj4j7OhEmOnvWOm6+QKDyKEoPIIEASX/bbEeIQ3ErC7T
         cJvPSuFuoi5etuMJTpsNRdv6TerV3Ruwk/GmBX8XZ/8K04yxZX6LnBMjdZ///blrtSfJ
         Ia1IoTrbaUTvm63eBRtwAlFHSW5ovYKMT/iDLUdw33xzVTMSkIlv+XjfzsPjHG7ZdWp0
         q/2eWuH4OInIpbwxYvMmvg+aAvaTYAlb457A3aCS8tgkkdLikzs5jo7BX4ndcmiC7hXj
         u1eQ==
X-Forwarded-Encrypted: i=1; AHgh+RpBgKGrFtkjLndBKG0Ofie/4nFPofeVhP7Umxb7WoD3LbgWxbanN8vEkEU8Fm9R6seu54h+u8eQ/coCNYo7@vger.kernel.org
X-Gm-Message-State: AOJu0YxNf5mJ3Rn2OCoWN89MsJ6D7eCUZEHVMXPTJBsxPdKK/IRKWhA+
	IplCbfexR72M+qwQZTZmIBvdAJxo7WX+0NONozRS9+Nc4xVDRO8fYzfalcXgquJ6/P++kMwAy3T
	bPUhaLHf7bur5agjd+tEWz8pAUM6V107owP1pMo/rxbTRkDCNsafeTlZoVmo=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1627:b0:6af:eac8:3d92 with SMTP id
 006d021491bc7-6b0d5daa746mr24203975eaf.0.1787012969814; Mon, 17 Aug 2026
 17:29:29 -0700 (PDT)
Date: Mon, 17 Aug 2026 17:29:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a83a769.4d75e56a.c9a88.0007.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in uvcg_extension_bm_controls_store
From: syzbot <syzbot+300213c2b5b55c0244f4@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3aa1dcaa4f6f Revert "wifi: mt76: Disable napi when removin..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1619d149580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aaf0da806f995318
dashboard link: https://syzkaller.appspot.com/bug?extid=300213c2b5b55c0244f4
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6f9bf8386a97/disk-3aa1dcaa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/11e9065ece34/vmlinux-3aa1dcaa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0c2427f0862d/bzImage-3aa1dcaa.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+300213c2b5b55c0244f4@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.1.302/7497 is trying to acquire lock:
ffffffff8f9eb2a8 (gadget_subsys.su_mutex){+.+.}-{4:4}, at: uvcg_extension_bm_controls_store+0xe4/0xb00 drivers/usb/gadget/function/uvc_configfs.c:1125

but task is already holding lock:
ffff88803317f470 (&p->frag_sem){++++}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
ffff88803317f470 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x238/0x430 fs/configfs/file.c:229

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&p->frag_sem){++++}-{4:4}:
       down_write_killable+0xa6/0x240 kernel/locking/rwsem.c:1643
       configfs_rmdir+0x3b0/0x950 fs/configfs/dir.c:1534
       vfs_rmdir+0x3e6/0x6a0 fs/namei.c:5381
       filename_rmdir+0x292/0x520 fs/namei.c:5438
       __do_sys_unlinkat fs/namei.c:5613 [inline]
       __se_sys_unlinkat+0x71/0x1a0 fs/namei.c:5606
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&sb->s_type->i_mutex_key#32){++++}-{4:4}:
       down_write+0x96/0x200 kernel/locking/rwsem.c:1631
       inode_lock include/linux/fs.h:1024 [inline]
       configfs_depend_item_unlocked+0x153/0x420 fs/configfs/dir.c:1259
       usbg_make_tpg+0x1f6/0x590 drivers/usb/gadget/function/f_tcm.c:1686
       target_fabric_make_tpg+0xa8/0x6d0 drivers/target/target_core_fabric_configfs.c:939
       configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1360
       vfs_mkdir+0x406/0x620 fs/namei.c:5276
       filename_mkdirat+0x285/0x510 fs/namei.c:5309
       __do_sys_mkdirat fs/namei.c:5330 [inline]
       __se_sys_mkdirat+0x35/0x150 fs/namei.c:5327
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&opts->dep_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       tcm_set_name+0x2b/0xd0 drivers/usb/gadget/function/f_tcm.c:2669
       function_make+0x1a8/0x360 drivers/usb/gadget/configfs.c:636
       configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1360
       vfs_mkdir+0x406/0x620 fs/namei.c:5276
       filename_mkdirat+0x285/0x510 fs/namei.c:5309
       __do_sys_mkdirat fs/namei.c:5330 [inline]
       __se_sys_mkdirat+0x35/0x150 fs/namei.c:5327
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (gadget_subsys.su_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x1520/0x2cf0 kernel/locking/lockdep.c:5237
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       uvcg_extension_bm_controls_store+0xe4/0xb00 drivers/usb/gadget/function/uvc_configfs.c:1125
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x337/0x430 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x612/0xba0 fs/read_write.c:687
       ksys_write+0x150/0x270 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  gadget_subsys.su_mutex --> &sb->s_type->i_mutex_key#32 --> &p->frag_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&p->frag_sem);
                               lock(&sb->s_type->i_mutex_key#32);
                               lock(&p->frag_sem);
  lock(gadget_subsys.su_mutex);

 *** DEADLOCK ***

4 locks held by syz.1.302/7497:
 #0: ffff888061692470 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x246/0x320 fs/file.c:1259
 #1: ffff88801bf16450 (sb_writers#22){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2733 [inline]
 #1: ffff88801bf16450 (sb_writers#22){.+.+}-{0:0}, at: vfs_write+0x22b/0xba0 fs/read_write.c:683
 #2: ffff8880783f4480 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x7e/0x430 fs/configfs/file.c:226
 #3: ffff88803317f470 (&p->frag_sem){++++}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
 #3: ffff88803317f470 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x238/0x430 fs/configfs/file.c:229

stack backtrace:
CPU: 0 UID: 0 PID: 7497 Comm: syz.1.302 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2043
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x1520/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
 uvcg_extension_bm_controls_store+0xe4/0xb00 drivers/usb/gadget/function/uvc_configfs.c:1125
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x337/0x430 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9d8819e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9d890b3028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f9d88425fa0 RCX: 00007f9d8819e0d9
RDX: 0000000000000050 RSI: 0000200000000440 RDI: 0000000000000009
RBP: 00007f9d88235024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9d88426038 R14: 00007f9d88425fa0 R15: 00007fffe7d8ced8
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
