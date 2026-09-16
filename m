Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E576435DA41
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 02:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524942; cv=none; b=lsP6QxVhzJfBZJhALYaDgQWZQdzDhvp1P8ZGS92li24kZ6b/hsFE8VhjAO9Qus7R+NwElpaPtRQh8yYWapQAPiYkiw3nl52/J3yYC0gVjjuLBkbGk0bO9AqxA37z8XX04Yg2EKDM1GkiEz3F8QT1V1kah9b1n1F9bBczl5ucPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524942; c=relaxed/simple;
	bh=2H60UeEyFUGtJ2Hs4Q/9QGKw7hhhE6EVirUtBXZOGQk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Nq23a4eZaQCY4Y12JTCXXKYxAGPoL1Morw5jIRaS1ii9Ke5rrc75Zq6ylma9OJ3wDeyESvzUMb3QRg3/mtgNW6TMRdH67SuDTDqJYt8k/W6k1+a31RghQzLpF4mFWXak+wRALk/eFx4PF/Ul5W2Bx3U9tpKhCImJPLv37mtab9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-46ae9734a12so1377224fac.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 19:15:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789524934; x=1790129734;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KW8L0IZy9f8Ym6HcpkcmLukANbz/LCl2l9Bg0IabelI=;
        b=XcxronuET4EeD9LV65qGWYkhw7XRg5q7Z124TI7qUGexbGSrvARKYWJBOdqwlv1wLT
         iX+ZzSWqUxN9QYYzD6PwDvTGyp6Ih1Be4z7Iwbwavixee7YBrD9FY6sx+unNEVSP9OYw
         LF03/JHt/RMlwCqYEzA1hIZgBluCYXOcKeu2iy5VjFXZGAPFLjBYI5j8gTP+HPxqPofs
         uR9s/3Fcg0FusqSoJXYlv/xdWabyCwbhc2OIby+2PqlqG6Gdaet/Rw6bQF2qoISzjhun
         72D5YpIsoszqNjmxb50dkIHkoko7tVCOTZp5nfArAIEoXvNWglKu8d5bvsacIw3NDklU
         /F+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxsGmnAXrLXtLQfsFaQ9Su6rdj6AZcXk7L2CXNgD6xlrKCZ27Q0Z0147MYNts42jJF9d3O42zGVheD2/RRi@vger.kernel.org
X-Gm-Message-State: AFuF++kMzGAzLGQTkZULmpqjhZwspELHY76Ns4AJQAHnv76HsMYr2bA2
	bgCrcL9YniC6eS0Zo8IaJMJdnPPges+vneqr0cqrrZm3Sive1d5dleUPbiIpgzi2TwquubHass2
	x4hrh4PQtIdaP9cn7ERvTs2QSKFglxkPsQOwcju7X9182B1/vyTfTNvP4cNQ=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:170c:b0:4c5:12a4:ec8a with SMTP id
 5614622812f47-4ca4c2828e9mr1113235b6e.36.1789524934451; Tue, 15 Sep 2026
 19:15:34 -0700 (PDT)
Date: Tue, 15 Sep 2026 19:15:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa9fbc6.4c28b7d0.c1bba.0043.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in uvcg_format_bma_controls_store
From: syzbot <syzbot+50560f9ba016e97e2023@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3026c6e4f223 Merge tag 'slab-for-7.3-rc2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f1e901580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=50560f9ba016e97e2023
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/98fa15ee8f48/disk-3026c6e4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/36b1db5cf167/vmlinux-3026c6e4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f745756a36c/bzImage-3026c6e4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50560f9ba016e97e2023@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.3.8436/729 is trying to acquire lock:
ffffffff8fc11b68 (gadget_subsys.su_mutex){+.+.}-{4:4}, at: uvcg_format_bma_controls_store+0x55/0x2b0 drivers/usb/gadget/function/uvc_configfs.c:1707

but task is already holding lock:
ffff888028d20770 (&p->frag_sem){++++}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
ffff888028d20770 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x238/0x430 fs/configfs/file.c:229

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&p->frag_sem){++++}-{4:4}:
       down_write_killable+0xa6/0x240 kernel/locking/rwsem.c:1643
       configfs_rmdir+0x3b0/0x950 fs/configfs/dir.c:1543
       vfs_rmdir+0x3e6/0x6a0 fs/namei.c:5515
       filename_rmdir+0x292/0x520 fs/namei.c:5572
       __do_sys_unlinkat fs/namei.c:5747 [inline]
       __se_sys_unlinkat+0x71/0x1a0 fs/namei.c:5740
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&sb->s_type->i_mutex_key#27){++++}-{4:4}:
       down_write+0x96/0x200 kernel/locking/rwsem.c:1631
       inode_lock include/linux/fs.h:1024 [inline]
       configfs_depend_item_unlocked+0x153/0x420 fs/configfs/dir.c:1268
       usbg_make_tpg+0x1e0/0x550 drivers/usb/gadget/function/f_tcm.c:1692
       target_fabric_make_tpg+0xa8/0x6d0 drivers/target/target_core_fabric_configfs.c:947
       configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1369
       vfs_mkdir+0x40c/0x620 fs/namei.c:5410
       filename_mkdirat+0x285/0x510 fs/namei.c:5443
       __do_sys_mkdir fs/namei.c:5470 [inline]
       __se_sys_mkdir+0x34/0x150 fs/namei.c:5467
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (tpg_instances_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       tcm_alloc_inst+0x65/0x1a0 drivers/usb/gadget/function/f_tcm.c:2687
       try_get_usb_function_instance drivers/usb/gadget/functions.c:28 [inline]
       usb_get_function_instance+0xe3/0x2f0 drivers/usb/gadget/functions.c:44
       function_make+0x127/0x360 drivers/usb/gadget/configfs.c:626
       configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1369
       vfs_mkdir+0x40c/0x620 fs/namei.c:5410
       filename_mkdirat+0x285/0x510 fs/namei.c:5443
       __do_sys_mkdir fs/namei.c:5470 [inline]
       __se_sys_mkdir+0x34/0x150 fs/namei.c:5467
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (func_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       try_get_usb_function_instance drivers/usb/gadget/functions.c:18 [inline]
       usb_get_function_instance+0x2e/0x2f0 drivers/usb/gadget/functions.c:44
       function_make+0x127/0x360 drivers/usb/gadget/configfs.c:626
       configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1369
       vfs_mkdir+0x40c/0x620 fs/namei.c:5410
       filename_mkdirat+0x285/0x510 fs/namei.c:5443
       __do_sys_mkdir fs/namei.c:5470 [inline]
       __se_sys_mkdir+0x34/0x150 fs/namei.c:5467
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (gadget_subsys.su_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3209 [inline]
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       uvcg_format_bma_controls_store+0x55/0x2b0 drivers/usb/gadget/function/uvc_configfs.c:1707
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x337/0x430 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x612/0xba0 fs/read_write.c:687
       ksys_write+0x150/0x270 fs/read_write.c:739
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

locks held by syz.3.8436/729: 4, last CPU#1:
 #0: ffff88802cacd270 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x246/0x320 fs/file.c:1259
 #1: ffff88801d716460 (sb_writers#16){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2753 [inline]
 #1: ffff88801d716460 (sb_writers#16){.+.+}-{0:0}, at: vfs_write+0x22b/0xba0 fs/read_write.c:683
 #2: ffff888076ff2c80 (&buffer->mutex#2){+.+.}-{4:4}, at: configfs_write_iter+0x7e/0x430 fs/configfs/file.c:226
 #3: ffff888028d20770 (&p->frag_sem){++++}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
 #3: ffff888028d20770 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x238/0x430 fs/configfs/file.c:229

stack backtrace:
CPU: 1 UID: 0 PID: 729 Comm: syz.3.8436 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2087
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2219
 check_prev_add kernel/locking/lockdep.c:3209 [inline]
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
 uvcg_format_bma_controls_store+0x55/0x2b0 drivers/usb/gadget/function/uvc_configfs.c:1707
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x337/0x430 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fee74b9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fee7597e028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fee74e25fa0 RCX: 00007fee74b9e159
RDX: 0000000000000002 RSI: 0000200000000300 RDI: 0000000000000003
RBP: 00007fee74c3503b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fee74e26038 R14: 00007fee74e25fa0 R15: 00007ffd3a9e87e8
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
