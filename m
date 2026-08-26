Received: from mail-oi2-f10.google.com (mail-oi2-f10.google.com [74.125.231.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1A52E736A
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 04:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787719547; cv=none; b=skqmNEY2ztFSzrUKSfm/4Bbx+AzbulZXT96G877MWF/TGDYfaqIaYN6262TBUc0JLFSuFg9PMJepAjfcKoTJgrdKh/OcXaM1D0nv2hKFZBxGVEHc3Gc3rIdkveKrTMkZQsqAsQcJ9dZJu/rnr3w9+l/2nZ4t2iHvSy0qmQEF3dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787719547; c=relaxed/simple;
	bh=v8bNBNIrtYci+an59Te+5foA8rGdKCS+ZHpfYAfPnig=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oC+JwkpOAGHO6PzxXEhvMHbuxVcbYrBLAnyZexOORDNKW/B+R+ojgPwmry5+1BhyLYmBOvmfoLy46T5UMCaJn8rukCl2ddimes0baNRj4MwDvZfOFVpm2XIEEBc2BGjyvkIM2awKiJl4cRM2OB5lqR71KQGj4aTtWvHEM0/zHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f10.google.com with SMTP id 46e09a7af769-7e9fdad388fso127226a34.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 21:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787719544; x=1788324344;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+0RtdsKazd3O4xthbUUPh5mEozlGgKGFCFUb2b9CwKM=;
        b=NQqL0p6iPjijXxEYEowq13zVpYr4D38J2yZ2D7guAyT0mR7OFCObvxq6+NmPgU0YUp
         Gf2gfVC15DMPs1GinByWVZJuSf03b54srSXKZl7ID3nNaR/T01ZhTv/fYVfsfU/1OCTc
         8fzksuvHSh0SVfYXg98Bv/QAjqUjQ2/4jh8KRuBohy0Bzh6LkaJ8elqpmUUdHbVlMGqn
         JRFkmCVHiRMYSsARLB5RXY7hFjv7wJ2Z8kzwSIAsteeXwsARycuzmmo4/RgxCH1VrqEa
         bEkZS3girG0hfgWckFruPvH/beXq8JmwpjSoukiI94vO7EF6NAwmvXokYvc/Lnz1OxA8
         CJqg==
X-Forwarded-Encrypted: i=1; AHgh+Rq1KVUB6gf7tc/NAyx5B7LEwH/Nvke8ppoGNIBIgXUgHehOAAyoX/BND2sD0/yjKBuqUDkMpFGxc4ve31xa@vger.kernel.org
X-Gm-Message-State: AFuF++m3uwGTp2oIR7AA1V9vUpF4mcCVuCpAEMQhWhQhowfuQUgm9itF
	wTusv/kQf4RO0L3oZQ9IVfcha0CZJkaQcZAdhT9kmVrnlA98QYgIAVV0qbHPQe8DwD/ePoopTsp
	qoMYBo4KejIPxkY4Y1v8cZs9zB1y2/pfOtlb4mZlaNX6RLpTTStDfisxJ/aI=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:508a:b0:4b2:8d77:511 with SMTP id
 5614622812f47-4b366a90cadmr5109764b6e.10.1787719544591; Tue, 25 Aug 2026
 21:45:44 -0700 (PDT)
Date: Tue, 25 Aug 2026 21:45:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8e6f78.dbb3a75c.7844.0033.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in ima_path_truncate
From: syzbot <syzbot+ecf337bf2c6f75c1ddd8@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    818bebeb63dd drm/xe: Don't hand out the flat CCS storage a..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17c6be79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c35c7e43de75adb
dashboard link: https://syzkaller.appspot.com/bug?extid=ecf337bf2c6f75c1ddd8
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-818bebeb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9adea981957f/vmlinux-818bebeb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6676075cd03e/bzImage-818bebeb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ecf337bf2c6f75c1ddd8@syzkaller.appspotmail.com


======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.0/5310 is trying to acquire lock:
ffff888043b8ecc0 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_reset_action_flags security/integrity/ima/ima_main.c:708 [inline]
ffff888043b8ecc0 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: ima_path_truncate+0xd3/0x190 security/integrity/ima/ima_main.c:717

but task is already holding lock:
ffff8880347c0460 (sb_writers#11){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:494

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (sb_writers#11){.+.+}-{0:0}:
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs/super.h:19 [inline]
       sb_start_write+0x4d/0x1d0 include/linux/fs/super.h:125
       mnt_want_write+0x41/0x90 fs/namespace.c:494
       lookup_open+0x1e6/0x1a40 fs/namei.c:4451
       open_last_lookups fs/namei.c:4767 [inline]
       path_openat+0x677/0x1d60 fs/namei.c:4997
       do_file_open+0x23e/0x4a0 fs/namei.c:5029
       file_open_name fs/open.c:1375 [inline]
       filp_open+0x16d/0x1d0 fs/open.c:1392
       fsg_lun_open+0x6c/0xdf0 drivers/usb/gadget/function/storage_common.c:194
       fsg_store_file+0x19e/0x400 drivers/usb/gadget/function/storage_common.c:455
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x337/0x430 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x612/0xba0 fs/read_write.c:687
       ksys_write+0x150/0x270 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&common->filesem){++++}-{4:4}:
       down_read+0x4a/0x330 kernel/locking/rwsem.c:1574
       fsg_show_file+0x2d/0x140 drivers/usb/gadget/function/storage_common.c:339
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
       do_open fs/namei.c:4839 [inline]
       path_openat+0x1485/0x1d60 fs/namei.c:5000
       do_file_open+0x23e/0x4a0 fs/namei.c:5029
       do_sys_openat2+0x115/0x200 fs/open.c:1417
       do_sys_open fs/open.c:1423 [inline]
       __do_sys_openat fs/open.c:1439 [inline]
       __se_sys_openat fs/open.c:1434 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1434
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&p->frag_sem){.+.+}-{4:4}:
       down_read+0x4a/0x330 kernel/locking/rwsem.c:1574
       fill_read_buffer fs/configfs/file.c:66 [inline]
       configfs_read_iter+0x1cc/0x620 fs/configfs/file.c:88
       __kernel_read+0x4ca/0x960 fs/read_write.c:532
       integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:222 [inline]
       ima_calc_file_hash+0x451/0x890 security/integrity/ima/ima_crypto.c:280
       ima_collect_measurement+0x51b/0xa00 security/integrity/ima/ima_api.c:300
       process_measurement+0x1272/0x1c10 security/integrity/ima/ima_main.c:425
       ima_file_check+0xe1/0x130 security/integrity/ima/ima_main.c:685
       security_file_post_open+0xb3/0x260 security/security.c:2755
       do_open fs/namei.c:4839 [inline]
       path_openat+0x1485/0x1d60 fs/namei.c:5000
       do_file_open+0x23e/0x4a0 fs/namei.c:5029
       do_sys_openat2+0x115/0x200 fs/open.c:1417
       do_sys_open fs/open.c:1423 [inline]
       __do_sys_openat fs/open.c:1439 [inline]
       __se_sys_openat fs/open.c:1434 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1434
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&buffer->mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       configfs_read_iter+0x70/0x620 fs/configfs/file.c:86
       __kernel_read+0x4ca/0x960 fs/read_write.c:532
       integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:222 [inline]
       ima_calc_file_hash+0x451/0x890 security/integrity/ima/ima_crypto.c:280
       ima_collect_measurement+0x51b/0xa00 security/integrity/ima/ima_api.c:300
       process_measurement+0x1272/0x1c10 security/integrity/ima/ima_main.c:425
       ima_file_check+0xe1/0x130 security/integrity/ima/ima_main.c:685
       security_file_post_open+0xb3/0x260 security/security.c:2755
       do_open fs/namei.c:4839 [inline]
       path_openat+0x1485/0x1d60 fs/namei.c:5000
       do_file_open+0x23e/0x4a0 fs/namei.c:5029
       do_sys_openat2+0x115/0x200 fs/open.c:1417
       do_sys_open fs/open.c:1423 [inline]
       __do_sys_openat fs/open.c:1439 [inline]
       __se_sys_openat fs/open.c:1434 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1434
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3181 [inline]
       check_prevs_add kernel/locking/lockdep.c:3300 [inline]
       validate_chain kernel/locking/lockdep.c:3924 [inline]
       __lock_acquire+0x1520/0x2cf0 kernel/locking/lockdep.c:5253
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5886
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       ima_reset_action_flags security/integrity/ima/ima_main.c:708 [inline]
       ima_path_truncate+0xd3/0x190 security/integrity/ima/ima_main.c:717
       security_path_truncate+0x1d0/0x310 security/security.c:1563
       vfs_truncate+0x46b/0x540 fs/open.c:116
       ksys_truncate+0xf3/0x1c0 fs/open.c:142
       __do_sys_truncate fs/open.c:154 [inline]
       __se_sys_truncate fs/open.c:152 [inline]
       __x64_sys_truncate+0x5b/0x70 fs/open.c:152
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ima_iint_mutex_key[depth] --> &common->filesem --> sb_writers#11

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(sb_writers#11);
                               lock(&common->filesem);
                               lock(sb_writers#11);
  lock(&ima_iint_mutex_key[depth]);

 *** DEADLOCK ***

locks held by syz.0.0/5310: 1, last CPU#0:
 #0: ffff8880347c0460 (sb_writers#11){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:494

stack backtrace:
CPU: 0 UID: 0 PID: 5310 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2059
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2191
 check_prev_add kernel/locking/lockdep.c:3181 [inline]
 check_prevs_add kernel/locking/lockdep.c:3300 [inline]
 validate_chain kernel/locking/lockdep.c:3924 [inline]
 __lock_acquire+0x1520/0x2cf0 kernel/locking/lockdep.c:5253
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5886
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
 ima_reset_action_flags security/integrity/ima/ima_main.c:708 [inline]
 ima_path_truncate+0xd3/0x190 security/integrity/ima/ima_main.c:717
 security_path_truncate+0x1d0/0x310 security/security.c:1563
 vfs_truncate+0x46b/0x540 fs/open.c:116
 ksys_truncate+0xf3/0x1c0 fs/open.c:142
 __do_sys_truncate fs/open.c:154 [inline]
 __se_sys_truncate fs/open.c:152 [inline]
 __x64_sys_truncate+0x5b/0x70 fs/open.c:152
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f92a899e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f92a97d3fe8 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007f92a8c26090 RCX: 00007f92a899e0d9
RDX: 0000000000000000 RSI: 0000000000000c88 RDI: 0000200000000100
RBP: 00007f92a8a35024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f92a8c26128 R14: 00007f92a8c26090 R15: 00007ffcdcc3c1d8
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
