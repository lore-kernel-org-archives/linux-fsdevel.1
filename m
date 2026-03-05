Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD91307AC6
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772692768; cv=none; b=i2neeX2XfKJ+eLI2cHRP3v2TuWu1X9nMOTsnsj5FwLk7azUsOHRciG3vGVNYh0NMzbX+jSzMwBI/aJP6kZPIQ0QQw+CoqARpDox3soUqTHUduENQKfEABLpfymAcgni5rhQcoNRPqb9X6ZW7I0Nw2Utx9IIjobk62lAG3eVhIEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772692768; c=relaxed/simple;
	bh=5atin/QyTMJPaHN908vw3jHVrcVvtUrPmM/HRy6F4Nc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OIA5UwC5jWDSZnIBJ/mNetxhpbGPe+191Ty3cXToR8Lau+Vk6RzhCi0lX5vUY6wsS/DRKDARa41UZel7huq+RYK+N6cjD6K2009zTSWn4d3TQ/Lgko6CKrmXSCNOLYklP/MkaqN29hc+KF6CcsGplG0M7p5ccW3jJGGhO5+iqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-67999893008so64118845eaf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2026 22:39:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772692765; x=1773297565;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T69q03Ql39fiZ9I4Pdgi0mPljH+4/RNKrqL5XYzH1fU=;
        b=RrYaUgxay9fvYCaC0jO3AT3KbquBE3oIrYRJ0hv+9QP4nVlU4zEHLZzd1oZ+XG+ESF
         yPZ7ftN6ESyC82R/tdPXEvkdWpDf7DJM1QPbNkYNe3lgeff/DRPlCIHJmVXAU4yoAZiu
         ZLq9X5FV6s7FEkcS+tbZp212zfALv0fafaLVxWa8j72VWU0UQ+cEyvBfv3oZz9p5A/Rf
         yqCUOnzdtPPqr9SkEZsAfSSOu2Xf/Q1D23/y0AKcZU3TxpXvug2rJAvTorKsWzeHfrtU
         GfXAGnCaCt+yPKNhheHDb7JdnMWjvU3HuAWDUyOX4/oKwkXyaCo9I1h01Of1DGKlWufV
         HtpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnePkgdKvgIVOBc9/v6UhXw6sYi9tuhMoJhk9Q3H7kI3oNMs3ZMb3j7owKsacmOe4boFY7GRtc05F1cMKf@vger.kernel.org
X-Gm-Message-State: AOJu0YwZhf+lR0kkxZ/7PLOJL2r6PN5nRppN/YQ0fW9tg+VLBdGxb4a7
	do2Vi2G2zIb6urRsFNzMI1jzZiqEEM/ubfjahRthPojPH8mLEaicgaOVHvrodB0c+i80Ds7gRlY
	eb/mIH/xtPY6lVWK0bfKpt6HGaTGNtAuSG/DDxt8gN8YvDbR1K+MZZyOZPCc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c9e:b0:679:e595:ff30 with SMTP id
 006d021491bc7-67b17750586mr3093380eaf.36.1772692765699; Wed, 04 Mar 2026
 22:39:25 -0800 (PST)
Date: Wed, 04 Mar 2026 22:39:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a9251d.a70a0220.2f119.0003.GAE@google.com>
Subject: [syzbot] [exfat?] [gfs2?] WARNING in filename_symlinkat
From: syzbot <syzbot+2ed46b6b748df855347f@syzkaller.appspotmail.com>
To: brauner@kernel.org, gfs2@lists.linux.dev, jack@suse.cz, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ecc64d2dc9ff Merge tag 'sysctl-7.00-fixes-rc3' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1754b5aa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5c49ee0942d1cdb
dashboard link: https://syzkaller.appspot.com/bug?extid=2ed46b6b748df855347f
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123dbe4a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c99b5a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ecc64d2d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/86a2ecaacd1b/vmlinux-ecc64d2d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b1dad86775e5/bzImage-ecc64d2d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1d38e5a93707/mount_4.gz
  fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=17c57006580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2ed46b6b748df855347f@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff8880460da1f8, owner = 0x0, curr 0xffff8880371624c0, list empty
WARNING: kernel/locking/rwsem.c:1381 at __up_write kernel/locking/rwsem.c:1380 [inline], CPU#0: syz.0.31/5575
WARNING: kernel/locking/rwsem.c:1381 at up_write+0x2d6/0x410 kernel/locking/rwsem.c:1643, CPU#0: syz.0.31/5575
Modules linked in:
CPU: 0 UID: 0 PID: 5575 Comm: syz.0.31 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__up_write kernel/locking/rwsem.c:1380 [inline]
RIP: 0010:up_write+0x388/0x410 kernel/locking/rwsem.c:1643
Code: cc 8b 49 c7 c2 80 eb cc 8b 4c 0f 44 d0 48 8b 7c 24 08 48 c7 c6 e0 ed cc 8b 48 8b 14 24 4c 89 f1 4d 89 e0 4c 8b 4c 24 10 41 52 <67> 48 0f b9 3a 48 83 c4 08 e8 5a 83 0b 03 e9 67 fd ff ff 48 c7 c1
RSP: 0018:ffffc9000298fd80 EFLAGS: 00010246
RAX: ffffffff8bcceb60 RBX: ffff8880460da1f8 RCX: ffff8880460da1f8
RDX: 0000000000000000 RSI: ffffffff8bccede0 RDI: ffffffff901501f0
RBP: ffff8880460da250 R08: 0000000000000000 R09: ffff8880371624c0
R10: ffffffff8bcceb60 R11: ffffed1008c1b441 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff8880460da1f8 R15: 1ffff11008c1b440
FS:  00007fbd46c406c0(0000) GS:ffff88808ca58000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbd45de9e80 CR3: 00000000412ea000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:1038 [inline]
 end_dirop fs/namei.c:2947 [inline]
 end_creating include/linux/namei.h:126 [inline]
 end_creating_path fs/namei.c:4962 [inline]
 filename_symlinkat+0x222/0x410 fs/namei.c:5642
 __do_sys_symlinkat fs/namei.c:5660 [inline]
 __se_sys_symlinkat+0x4e/0x2b0 fs/namei.c:5655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbd45d9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbd46c40028 EFLAGS: 00000246 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 00007fbd46016090 RCX: 00007fbd45d9c799
RDX: 00002000000003c0 RSI: 0000000000000007 RDI: 0000200000000240
RBP: 00007fbd45e32bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbd46016128 R14: 00007fbd46016090 R15: 00007ffcbe33eb58
 </TASK>
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	49 c7 c2 80 eb cc 8b 	mov    $0xffffffff8bcceb80,%r10
   7:	4c 0f 44 d0          	cmove  %rax,%r10
   b:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  10:	48 c7 c6 e0 ed cc 8b 	mov    $0xffffffff8bccede0,%rsi
  17:	48 8b 14 24          	mov    (%rsp),%rdx
  1b:	4c 89 f1             	mov    %r14,%rcx
  1e:	4d 89 e0             	mov    %r12,%r8
  21:	4c 8b 4c 24 10       	mov    0x10(%rsp),%r9
  26:	41 52                	push   %r10
* 28:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2d:	48 83 c4 08          	add    $0x8,%rsp
  31:	e8 5a 83 0b 03       	call   0x30b8390
  36:	e9 67 fd ff ff       	jmp    0xfffffda2
  3b:	48                   	rex.W
  3c:	c7                   	.byte 0xc7
  3d:	c1                   	.byte 0xc1


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
