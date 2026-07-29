Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C15201278
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785284373; cv=none; b=t0jk1C08DosvuAzMX+dcQEjaIOHPIK7f4lEEqedPDygdrijjJ4pbkgA8GmmIWtU0zm47UTwm5SBTdjyCA2YY4ZM6GLUAAtdj6/GMzSoRWBtGCl5B/8AnxzG7ZASGJcjxkWAy5B3mDAuGc7AOmWNF0B1pdv2lFkEjSRcic7fqVKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785284373; c=relaxed/simple;
	bh=9Cxucgz2jOUKzxD3uGKI6IuDzNg5X0waI8NHwa2jTMk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pRsawFHKnrZDtRSh0232M77VK2v9RRVYI/zHApjjmAFxPXklPSXtecAcYxlSRvc8GLbfc51HTTALylZ+CB/P3EgDuUsswQ6Q9ss8i1jrCO3LVFWnIPoVE5q+ccUupbe96oM6+WGfKoHpd2ZB9lLIk1WhyWDUtx5NkwQFUTy8ieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4ab4dd46ddeso250413b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 17:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785284371; x=1785889171;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bLWTjEE4qXnSWbQn7DsdsMFeJ9JENAqaTmYk0lYRMgU=;
        b=HvMcw073LVr3XRmyLjFvTBIpn26dMcWS5o1XdogQsXclYf0ONmSoReYgoNuNUcnIys
         oAMlCbf2J6TI4EUvE+HwKn4i7yNXRPFZZaZDpdL4JRgfDFqtby5bh4IeVQ76Tdrmd/9C
         ZbJAGnBCB3PX23o8h5n43h9dG0FwwFNfeJfpdt/KJoSNzkM9fdfySGJBBwm4pmhmkBzE
         WwDbmdRdtrOvbNbtfr2ySWWInm0A9BrhApsvKw3lOo45aGI+4B2XrvZ9SxQrmW6ogxUF
         JpFe7LSYVDOojPFEEJxEV3hwsda5wPNT5ORrAsYZRs9YeLP+LQ/VxEwK8O7u6F4HGi1g
         TwLg==
X-Forwarded-Encrypted: i=1; AHgh+RqTzz4VXysb1QZ+jkCxYIP0tc2LI0khS3VBTuXjL+BuOfBdECKvLMlzzNdcyY35cL5HqRgLfGr3voWrGDr2@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlxz2TXnGArVrfKTqyK46bnw0W5eceVW3S1oL3KRNgh1bj9bM0
	Xssz7fjyhonux1lIkJglhmSro8FsWEnkFo+qbHuFsasa9I7Z7DNYChTp6l2ww/qj1R1wtIT6rGu
	C28kNb6fLSrQisddYFcGd/Xrg6yZHJ1CEgo90SZOF4ZHi2MVUuUaVslIfAI0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3507:b0:495:f67c:d96a with SMTP id
 5614622812f47-4ad5ba67800mr2740939b6e.12.1785284371326; Tue, 28 Jul 2026
 17:19:31 -0700 (PDT)
Date: Tue, 28 Jul 2026 17:19:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a694713.6bd615f2.c0aa.0004.GAE@google.com>
Subject: [syzbot] [fs?] general protection fault in start_dirop
From: syzbot <syzbot+1e3d934ee3cff1ac188b@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    62cc90241548 Merge tag 'mm-hotfixes-stable-2026-07-27-14-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13377fde580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=1e3d934ee3cff1ac188b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111916b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10aa0aea580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-62cc9024.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b10a9ae7e3d1/vmlinux-62cc9024.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b89124d39495/bzImage-62cc9024.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e3d934ee3cff1ac188b@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000028: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000140-0x0000000000000147]
CPU: 3 UID: 0 PID: 6582 Comm: syz.0.150 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:kasan_byte_accessible+0x15/0x30 mm/kasan/generic.c:210
Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03 48 01 c7 <0f> b6 07 3c 07 0f 96 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00
RSP: 0018:ffffc900030274b0 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81e53a84 RDI: dffffc0000000028
RBP: 0000000000000140 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff81e53a84
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f68146b06c0(0000) GS:ffff8880d60dc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33a63fff CR3: 000000002ca1c000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __kasan_check_byte+0x13/0x50 mm/kasan/common.c:573
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire kernel/locking/lockdep.c:5842 [inline]
 lock_acquire+0x132/0x370 kernel/locking/lockdep.c:5825
 down_write_nested+0x94/0x200 kernel/locking/rwsem.c:1757
 inode_lock_nested include/linux/fs.h:1069 [inline]
 __start_dirop fs/namei.c:2918 [inline]
 start_dirop+0x4b/0xb0 fs/namei.c:2942
 simple_start_creating+0xf9/0x110 fs/libfs.c:2305
 debugfs_start_creating.part.0+0x82/0x170 fs/debugfs/inode.c:394
 debugfs_start_creating fs/debugfs/inode.c:371 [inline]
 debugfs_create_dir+0x72/0x440 fs/debugfs/inode.c:572
 i2c_device_probe+0x5f5/0xd10 drivers/i2c/i2c-core-base.c:588
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 i2c_new_client_device+0x660/0xd30 drivers/i2c/i2c-core-base.c:1019
 new_device_store+0x20f/0x420 drivers/i2c/i2c-core-base.c:1307
 dev_attr_store+0x58/0x80 drivers/base/core.c:2505
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f681379de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f68146b0028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f6813a25fa0 RCX: 00007f681379de99
RDX: 000000000000000c RSI: 0000200000000280 RDI: 0000000000000004
RBP: 00007f6813833eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6813a26038 R14: 00007f6813a25fa0 R15: 00007fff65603768
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_byte_accessible+0x15/0x30 mm/kasan/generic.c:210
Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03 48 01 c7 <0f> b6 07 3c 07 0f 96 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00
RSP: 0018:ffffc900030274b0 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81e53a84 RDI: dffffc0000000028
RBP: 0000000000000140 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff81e53a84
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f68146b06c0(0000) GS:ffff8880d60dc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33a63fff CR3: 000000002ca1c000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	0f 1f 00             	nopl   (%rax)
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	0f 1f 40 d6          	nopl   -0x2a(%rax)
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 c1 ef 03          	shr    $0x3,%rdi
  27:	48 01 c7             	add    %rax,%rdi
* 2a:	0f b6 07             	movzbl (%rdi),%eax <-- trapping instruction
  2d:	3c 07                	cmp    $0x7,%al
  2f:	0f 96 c0             	setbe  %al
  32:	c3                   	ret
  33:	cc                   	int3
  34:	cc                   	int3
  35:	cc                   	int3
  36:	cc                   	int3
  37:	66                   	data16
  38:	66                   	data16
  39:	2e                   	cs
  3a:	0f                   	.byte 0xf
  3b:	1f                   	(bad)
  3c:	84 00                	test   %al,(%rax)


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
