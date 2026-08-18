Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C743CE4B
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043397; cv=none; b=mM6RKGdNX7/cVNEgf3JjLvEAaog0pf1zSLFreMkeDu5eC8q3LD6J9y29wZl4kqnC+4+E6FlZYn6d5uG0aWfIOXOHVplmKv0A9IrpMvO+3E+TVJcbOwcwU9Hd1P3CFTEvKPgwKoU9bsHTe3+16WrcN4MyPFF6fMm8mjXoQTe9FUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043397; c=relaxed/simple;
	bh=nZu6WiKb8KuJJVZs144PW9PKFVh0eeTDgD3oJunSUoM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jwsLjyqq16O2lx98NfeiljpXww0SFtQnW8DDBWImqDEJSFsvS6fi40vJFO0f073sV30Gtq5u7OCCblJZeRUqaAykr2iilpeVudIT07YZOUmUo9HgfhymNg/7kRfukoQTa+qtCtqT+R4Vo96pPuZBolX8CGRC3bI8hw0Uid4MAms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7e7624e584dso6484705a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 01:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787043393; x=1787648193;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ENI8MWt7Uf6kAha9jb7krNyo2Su1eqZJBp6mhmYxwEQ=;
        b=skCyuCp3wsdL2dd17abLHR/QwsP9cp0dJFo2b4iB7Pm35bLy9sNr10k5egFNpM2XHj
         SQVTmyXUnc2OW3BxeJqizcbeV+jnC7kXYYuUuRLuoN7HRmcI12wK9YcyO9DqEAUPV6Ap
         kSDWRmL2eumLZ6qcGmcoozIXcWWf5Vt2XmF+jLX4jKKKJnin8QOUcmCiDrjfAjZKeEy/
         GSKf/8IPjmBwTeq24TfWlzbiHEJcFqKHflx9/0nZIAj1DsG273R3S1HiJXG0qvGgNzpZ
         k2kxVtJCq1F2NUkwf4bewMC0inizjvwZNw6+xtQQTXBDZ/fWCuhcDirZ5RcHMihhGExw
         6SRw==
X-Forwarded-Encrypted: i=1; AHgh+RpT0q3V9KkbrLfAc95aJbJ3YeGg3VkKi5Ys0dWSPkEKhLPVrJAJJBBcijl9AHUVxJ8k6Inh1WivxqtlpkyG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5hI22cem4cmzWVdJfl2t890f0UGBgkrXF34TBSGsYW7GuDL5A
	FjJ3LYKAfhre7NQ5ZiXzyjMY6Ncgc+wmhM9pgrQfLtgkqct7Iaxp4oPER/eTlnq+XlkDeGAMmRM
	mES+1ii0L5jC8+Rw7HSecelmrgeYlJzLn2MKvxu+x7qjYBC5m/I4poq14Ltk=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4c11:b0:6ac:a539:bc41 with SMTP id
 006d021491bc7-6b0d613c77emr25139158eaf.12.1787043392998; Tue, 18 Aug 2026
 01:56:32 -0700 (PDT)
Date: Tue, 18 Aug 2026 01:56:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a841e40.c8649fcc.3bb87.0003.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in uvcg_mjpeg_bma_controls_show
From: syzbot <syzbot+2b082cefcfb1439289ef@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8d3ae59288f1 Linux 7.2
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10b1d69e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ca5f2f2c4197664
dashboard link: https://syzkaller.appspot.com/bug?extid=2b082cefcfb1439289ef
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/79f5b21ede1d/disk-8d3ae592.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f43313295ab/vmlinux-8d3ae592.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5de229a3986e/bzImage-8d3ae592.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b082cefcfb1439289ef@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.9.535/9115 is trying to acquire lock:
ffffffff8f9eb768 (gadget_subsys.su_mutex){+.+.}-{4:4}, at: uvcg_format_bma_controls_show drivers/usb/gadget/function/uvc_configfs.c:1681 [inline]
ffffffff8f9eb768 (gadget_subsys.su_mutex){+.+.}-{4:4}, at: uvcg_mjpeg_bma_controls_show+0x4d/0x140 drivers/usb/gadget/function/uvc_configfs.c:2635

but task is already holding lock:
ffff88803207b570 (&p->frag_sem){++++}-{4:4}, at: fill_read_buffer fs/configfs/file.c:66 [inline]
ffff88803207b570 (&p->frag_sem){++++}-{4:4}, at: configfs_read_iter+0x1cc/0x620 fs/configfs/file.c:88

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

-> #2 (&sb->s_type->i_mutex_key#27){++++}-{4:4}:
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
       uvcg_format_bma_controls_show drivers/usb/gadget/function/uvc_configfs.c:1681 [inline]
       uvcg_mjpeg_bma_controls_show+0x4d/0x140 drivers/usb/gadget/function/uvc_configfs.c:2635
       fill_read_buffer fs/configfs/file.c:68 [inline]
       configfs_read_iter+0x2b7/0x620 fs/configfs/file.c:88
       __kernel_read+0x4ca/0x960 fs/read_write.c:532
       integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:222 [inline]
       ima_calc_file_hash+0x451/0x890 security/integrity/ima/ima_crypto.c:280
       ima_collect_measurement+0x51b/0xa00 security/integrity/ima/ima_api.c:300
       process_measurement+0x1272/0x1c10 security/integrity/ima/ima_main.c:425
       ima_file_check+0xe1/0x130 security/integrity/ima/ima_main.c:685
       security_file_post_open+0xb3/0x260 security/security.c:2755
       do_open fs/namei.c:4702 [inline]
       path_openat+0x2e90/0x3830 fs/namei.c:4863
       do_file_open+0x23e/0x4a0 fs/namei.c:4892
       do_sys_openat2+0x115/0x200 fs/open.c:1368
       do_sys_open fs/open.c:1374 [inline]
       __do_sys_openat fs/open.c:1390 [inline]
       __se_sys_openat fs/open.c:1385 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1385
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
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

3 locks held by syz.9.535/9115:
 #0: ffff88807ddab480 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: process_measurement+0x7d0/0x1c10 security/integrity/ima/ima_main.c:319
 #1: ffff88801f7dd080 (&buffer->mutex){+.+.}-{4:4}, at: configfs_read_iter+0x70/0x620 fs/configfs/file.c:86
 #2: ffff88803207b570 (&p->frag_sem){++++}-{4:4}, at: fill_read_buffer fs/configfs/file.c:66 [inline]
 #2: ffff88803207b570 (&p->frag_sem){++++}-{4:4}, at: configfs_read_iter+0x1cc/0x620 fs/configfs/file.c:88

stack backtrace:
CPU: 0 UID: 0 PID: 9115 Comm: syz.9.535 Tainted: G             L      syzkaller #0 PREEMPT(full) 
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
 uvcg_format_bma_controls_show drivers/usb/gadget/function/uvc_configfs.c:1681 [inline]
 uvcg_mjpeg_bma_controls_show+0x4d/0x140 drivers/usb/gadget/function/uvc_configfs.c:2635
 fill_read_buffer fs/configfs/file.c:68 [inline]
 configfs_read_iter+0x2b7/0x620 fs/configfs/file.c:88
 __kernel_read+0x4ca/0x960 fs/read_write.c:532
 integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:222 [inline]
 ima_calc_file_hash+0x451/0x890 security/integrity/ima/ima_crypto.c:280
 ima_collect_measurement+0x51b/0xa00 security/integrity/ima/ima_api.c:300
 process_measurement+0x1272/0x1c10 security/integrity/ima/ima_main.c:425
 ima_file_check+0xe1/0x130 security/integrity/ima/ima_main.c:685
 security_file_post_open+0xb3/0x260 security/security.c:2755
 do_open fs/namei.c:4702 [inline]
 path_openat+0x2e90/0x3830 fs/namei.c:4863
 do_file_open+0x23e/0x4a0 fs/namei.c:4892
 do_sys_openat2+0x115/0x200 fs/open.c:1368
 do_sys_open fs/open.c:1374 [inline]
 __do_sys_openat fs/open.c:1390 [inline]
 __se_sys_openat fs/open.c:1385 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1385
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc9faf9e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc9fbdd8028 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fc9fb226180 RCX: 00007fc9faf9e0d9
RDX: 0000000000000002 RSI: 00002000000002c0 RDI: ffffffffffffff9c
RBP: 00007fc9fb035024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc9fb226218 R14: 00007fc9fb226180 R15: 00007ffe7532db78
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
