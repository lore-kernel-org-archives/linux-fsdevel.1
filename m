Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DEE347BD7
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 04:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787115583; cv=none; b=lwRwmzBelHIyRI16ez61RfktIuy7guNi6IVMKAuTKvCind1fhSq98IMEJO1HW892XYisbt9OxOnMbOWPCfH7BoPLjIwb05FQ/PPuJk2/73C5tph285ByKkj97g56z+9m8ehAkUXr3oxWrFpj8xa3b6KVRSl1YymuuS/nqrCYu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787115583; c=relaxed/simple;
	bh=bo4znDchKDTpqKGuxejfa4Kzgk9A8y4VUNzbraNkAFQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ilckJYi+nvF3mE7MGZekH7KBf7pWCRptwxed/RDNJIl/h2AyDOTLNWVpxPci97qekbsQy3X9m3jaCy37hyvkQMDTozvvSBZh3Zs1N8D0xzquhbqm9Q1COEpc48UQblr9sz8sulEYej7mhBV2jHYnUnkbSbdApDFv/Z1PC46xkmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4ad778bacbeso856251b6e.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 21:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787115580; x=1787720380;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hu5Ps8lSVhPkxS4r+5ohowZQxB42afhKLWR6caqDX0g=;
        b=rDXUUXryod9hteO/7obPc0yygt5kvMIRfCNqeDhPyBtOXjvSCnwteGYuhjNqY99hik
         yffgQ2R7YxPJFs5KGMOfJFQxpKDTK+R24hvV6W+6vGFNXuGfwPbVGU7AxFd4OwgZQ6DY
         4/+7H8klzVYY+pctlh929Huxz2hlPcOem8ED++20p5sKkmWnFE5mK2H/0ST7vzKn3cLR
         C+SmYIB9SNnG4QDZQAEisy5f1j6oX7Qy8mUkQCUFL4FJml1eo9/YxUZyKNaBz9evlmXe
         +YaMJP+lpHho0JY+eBYxCIZrbGOgbUmr/6rWpL2Kc+Gda0UfVSU/15rG+oFq3648hJgV
         YL5A==
X-Forwarded-Encrypted: i=1; AHgh+RoG7je0M+Zsy67qFj2Vk5jqS5BIpfvl41DDxOdm2A3Umdmn2hgL4JHF3x+rKlV+graDpqlbKtpvU7qa8ENu@vger.kernel.org
X-Gm-Message-State: AOJu0YzhIgWteF6HaP1TdN9lIqAijYEUU1V2Fp1j2FPpAU3+ZpabZmCg
	ZWvGS+2a3gMauxeoXQRY6U93cR3UgCjlF7AFvwNU5aSoutemPZif5gxMsfETH+eNfywBSDPzt5q
	1Tus99kCr35qWBdm294nqSnzk/GCz84L8tRot7uhcr1r9XEg4BfGGbnUtB3Q=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:bc4:b0:496:a36:b5e5 with SMTP id
 5614622812f47-4b2bcac63e5mr2082822b6e.17.1787115580451; Tue, 18 Aug 2026
 21:59:40 -0700 (PDT)
Date: Tue, 18 Aug 2026 21:59:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a85383c.c8649fcc.3bb87.000c.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in uvcg_frame_w_width_store
From: syzbot <syzbot+35082e842882ade33a27@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d3ae59288f1 Linux 7.2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143c0679580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d67342c314f228d
dashboard link: https://syzkaller.appspot.com/bug?extid=35082e842882ade33a27
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d7827cbad2ef/disk-8d3ae592.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb86c4d0d627/vmlinux-8d3ae592.xz
kernel image: https://storage.googleapis.com/syzbot-assets/108cb159a1ee/bzImage-8d3ae592.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+35082e842882ade33a27@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.9.5185/30580 is trying to acquire lock:
ffffffff903ca368 (gadget_subsys.su_mutex){+.+.}-{4:4}, at: uvcg_frame_w_width_store+0x12c/0x370 drivers/usb/gadget/function/uvc_configfs.c:2029

but task is already holding lock:
ffff888074199270 (&p->frag_sem){++++}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
ffff888074199270 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x218/0x4e0 fs/configfs/file.c:229

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&p->frag_sem){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       down_write_killable+0x93/0x250 kernel/locking/rwsem.c:1643
       configfs_rmdir+0x3fa/0x950 fs/configfs/dir.c:1534
       vfs_rmdir fs/namei.c:5381 [inline]
       vfs_rmdir+0x328/0x8a0 fs/namei.c:5354
       filename_rmdir+0x31a/0x5c0 fs/namei.c:5438
       __do_sys_unlinkat fs/namei.c:5613 [inline]
       __se_sys_unlinkat fs/namei.c:5606 [inline]
       __x64_sys_unlinkat+0xf5/0x130 fs/namei.c:5606
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&sb->s_type->i_mutex_key#26){++++}-{4:4}:
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
       uvcg_frame_w_width_store+0x12c/0x370 drivers/usb/gadget/function/uvc_configfs.c:2029
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  gadget_subsys.su_mutex --> &sb->s_type->i_mutex_key#26 --> &p->frag_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&p->frag_sem);
                               lock(&sb->s_type->i_mutex_key#26);
                               lock(&p->frag_sem);
  lock(gadget_subsys.su_mutex);

 *** DEADLOCK ***

4 locks held by syz.9.5185/30580:
 #0: ffff88802728b5f0 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x2aa/0x380 fs/file.c:1259
 #1: ffff88801e70c450 (sb_writers#16){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #2: ffff88807b926080 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x76/0x4e0 fs/configfs/file.c:226
 #3: ffff888074199270 (&p->frag_sem){++++}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
 #3: ffff888074199270 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x218/0x4e0 fs/configfs/file.c:229

stack backtrace:
CPU: 0 UID: 0 PID: 30580 Comm: syz.9.5185 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
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
 uvcg_frame_w_width_store+0x12c/0x370 drivers/usb/gadget/function/uvc_configfs.c:2029
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fad2b59e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fad297d5028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fad2b826090 RCX: 00007fad2b59e0d9
RDX: 0000000000000001 RSI: 0000200000000540 RDI: 0000000000000004
RBP: 00007fad2b635024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fad2b826128 R14: 00007fad2b826090 R15: 00007ffeda500b18
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
