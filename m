Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA77D2E282B
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787147967; cv=none; b=N3N2F2o/iw9mqNvxvEfWYTw4xATTS5kH+Di0XAuv2sNGSrnHtmMSD98mSa10Mc8MgteIyulK8xL5B9B1zOlRPX51jnxFMnbpeh+BZFCAULK9RElFQBQzMmh1DUDRiqtRwBeaz5ScQ7ix7wdGKKYfJYqj9EZxrGcSDoyBUeFWa5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787147967; c=relaxed/simple;
	bh=lkwd4xaWDH9v1h5LPrq9bIkv9SP3Cdwxy90Cw4GuRNg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jgAG0SuzsGFQfIVWiR4/79pXxRQUDcMWGtS3C2sE46+rL5FlUgK6J8ty1lh7fYbDCOKnpFucEfE97cl0ajuhZFwyUB6UoyR4ELC6hA1Q8Bgt1/A66sEThPY/njha06OPjpRJb813j5uqgtYWMM76Fw1jZA4VLiQqbuXNo3Hzi4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7f1ddcd241aso1547106a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 06:59:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787147964; x=1787752764;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=unTYUURzWODVnb8yGUpkuzSl+ZwsipDCuvxKtdFso8o=;
        b=Rlyv8+gyHhipS4ndJ2u+NrcNH0uybCBGgHkR0D7PgIZBn5MswujkaTql2OomvoggWi
         tNCUfmmKppVGhX0QrtBZfDLHjIL8VQlFvy/SGdgcK3RKdWtKSv95g2eHEnY57yNUZuE/
         TJQwySWvQSfeEZp+TRMwZYcSQbSwCvJkmK8sEaUK5DE2cMazFhv/QGsGwmuj4Nyd7IIU
         EzC2r8Y2UKQVSVM4YdMgtw0DVrMrNd6dFnURJ3wIN2d+nzXmDscixw97UoAAmGm3pl6f
         X9k/jf9oMKcK3z2C53ssLW/Y6rKlivdCPBMbjARsmBGxmdqfeUJIvjowiMTvGwavCvh0
         NAlA==
X-Forwarded-Encrypted: i=1; AHgh+RrPDgmxito28onJqtb2RWEQCszx+c4I9O/MoSpTpy9SQiKLCg7+UqEZ/LkkGSV0fdAgHSjsh4rZSe+nCWi2@vger.kernel.org
X-Gm-Message-State: AOJu0YzIBEDofj6LBgLSK8SUsvETi969QohF8oteXQWI+JPrHXmbe55w
	uAVc9ZheuqLJK9Skq3uMlp1pSmKyEj4QMVdMFt/Ra9g1a6+VgB+XaoiRr2lhpqEgzdQRZ74SCSb
	wnLgQGw6JIKsFcuWW+qpWinc+gi6xQNwqu8ujChRA0H6O+EhnIcn0KJCaeoo=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:811b:b0:6b0:dfa2:8315 with SMTP id
 006d021491bc7-6b13c348134mr4519816eaf.13.1787147964561; Wed, 19 Aug 2026
 06:59:24 -0700 (PDT)
Date: Wed, 19 Aug 2026 06:59:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a85b6bc.c8649fcc.3bb87.0011.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in uvcg_frame_dw_max_video_frame_buffer_size_store
From: syzbot <syzbot+52720fcb44cb7f79c0cd@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    15ef2f78c49d Merge tag 'input-for-v7.2-rc7' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1167ca25580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca5f2f2c4197664
dashboard link: https://syzkaller.appspot.com/bug?extid=52720fcb44cb7f79c0cd
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d913f78d9891/disk-15ef2f78.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d5273ff4be42/vmlinux-15ef2f78.xz
kernel image: https://storage.googleapis.com/syzbot-assets/71fd7f7b71b6/bzImage-15ef2f78.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52720fcb44cb7f79c0cd@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.5.6856/28306 is trying to acquire lock:
ffffffff8f9eb728 (gadget_subsys.su_mutex){+.+.}-{4:4}, at: uvcg_frame_dw_max_video_frame_buffer_size_store+0x114/0x370 drivers/usb/gadget/function/uvc_configfs.c:2033

but task is already holding lock:
ffff88803523b070 (&p->frag_sem){++++}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
ffff88803523b070 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x238/0x430 fs/configfs/file.c:229

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

-> #2 (&sb->s_type->i_mutex_key#24){++++}-{4:4}:
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
       uvcg_frame_dw_max_video_frame_buffer_size_store+0x114/0x370 drivers/usb/gadget/function/uvc_configfs.c:2033
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
  gadget_subsys.su_mutex --> &sb->s_type->i_mutex_key#24 --> &p->frag_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&p->frag_sem);
                               lock(&sb->s_type->i_mutex_key#24);
                               lock(&p->frag_sem);
  lock(gadget_subsys.su_mutex);

 *** DEADLOCK ***

4 locks held by syz.5.6856/28306:
 #0: ffff888078c67cf0 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x246/0x320 fs/file.c:1259
 #1: ffff88801d71a450 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2733 [inline]
 #1: ffff88801d71a450 (sb_writers#12){.+.+}-{0:0}, at: vfs_write+0x22b/0xba0 fs/read_write.c:683
 #2: ffff88807f11de80 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x7e/0x430 fs/configfs/file.c:226
 #3: ffff88803523b070 (&p->frag_sem){++++}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
 #3: ffff88803523b070 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x238/0x430 fs/configfs/file.c:229

stack backtrace:
CPU: 0 UID: 0 PID: 28306 Comm: syz.5.6856 Tainted: G             L      syzkaller #0 PREEMPT(full) 
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
 uvcg_frame_dw_max_video_frame_buffer_size_store+0x114/0x370 drivers/usb/gadget/function/uvc_configfs.c:2033
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x337/0x430 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f451779e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f451858a028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f4517a25fa0 RCX: 00007f451779e0d9
RDX: 0000000000000004 RSI: 00002000000006c0 RDI: 0000000000000004
RBP: 00007f4517835024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4517a26038 R14: 00007f4517a25fa0 R15: 00007ffd3ad99718
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
