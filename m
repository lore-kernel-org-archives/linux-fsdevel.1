Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E863A0E86
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773905491; cv=none; b=TtnrV4uwh6Vdv+2EvQkGoetDQk9PcA2G3U2kXSUTefdvZd6ShBF3BfZg22wC5FkRyE7zDzOaG4yDcOI1sPKsRA4bO2D/tnmYyy8Qrh1rDPqyBbWes4jGb76Jj2GfT8VU5HLVX65zpbse2JI5chLnmtY3neugLZLfsXRGzTosRVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773905491; c=relaxed/simple;
	bh=xM5hNhO2e5gNDipVGrxh5NGuq9WkGm16rbenqLSGxw8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=D/kfLGyXZ+rZpbGV0DHcuqOXQh991rA4Wn21aFIoWl0khgL22RPpI/ElMzAkMTkDzIp6skAi/+N39RDMwBrd89/knPApQTnQXFjqtHPE7+LUbIx3Xw1xj2f98y5GrkqNb6cBeWhB1oKkD5d19ZE45d2J0sBd+Upv8fCPT3guxlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-67ba8eabf6dso8368129eaf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 00:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773905488; x=1774510288;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=efhXajGEWPGKaDrVssJqOheRKGJu4oUX6wi8aA/rI2g=;
        b=HQqrNwPVAK/Y+232WQxFstchgd41edlJErty0kRfJhU35lSNJnpZVf81sN96Ussd3s
         31iR3I8qqZhz9BhZKURYVKkubdfNj7o64ecvZc4iRK9xAsIBNmCB8x4u5Sky5UqhuiTE
         +THqbLyQqp4+Hpk78nz8nnrVi/uFwxFcAqTq+geNsXpPUDYViLBHmGsJ72u+d2bP9lnZ
         lNflEX0wLnCX1CR6j/ya1cqoEp2zh23OeuPxZcxibyQoosV1q+P1W4BfPb0z0ROiUoCW
         dBsAVizTJbmQgOG1JH3LnavHP8OY0lB9JgNEL9NTpu+5yv458QblUHW4JZxjZn+XQzi+
         NmYw==
X-Gm-Message-State: AOJu0YzR5WN3GtsvXj2ZS2eYx/PjvCnE14q6wYznvXie+jLPK8Jw+VWS
	n65MfRTG9OK2pz1g6dyOlzJTxsXAOfueMZsXzM4fTF2dTu3cMSGV/kMRSCrzYAs/mjK8QvS+uL/
	ZuJWnwqUW1oujs7U9A4CkeLuxNqYeFb5vHNBc0DmkFIPDJIiaFUmRIR6ptEMyLA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:6ac3:b0:67b:f209:bdb8 with SMTP id
 006d021491bc7-67c0daf415bmr4209198eaf.47.1773905488338; Thu, 19 Mar 2026
 00:31:28 -0700 (PDT)
Date: Thu, 19 Mar 2026 00:31:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69bba650.050a0220.1b2d94.0008.GAE@google.com>
Subject: [syzbot] [fuse?] general protection fault in fuse_opt_fd
From: syzbot <syzbot+3c38f696edf9e331cd53@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    95c541ddfb08 Add linux-next specific files for 20260316
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16193d52580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bcbfd105f37ac57
dashboard link: https://syzkaller.appspot.com/bug?extid=3c38f696edf9e331cd53
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b378da580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16b162d6580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b0922a82fd2b/disk-95c541dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/869dec734b46/vmlinux-95c541dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/def78cc5a6eb/bzImage-95c541dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3c38f696edf9e331cd53@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000009: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000048-0x000000000000004f]
CPU: 1 UID: 0 PID: 6045 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:fuse_opt_fd+0x49/0x220 fs/fuse/inode.c:807
Code: 4c 8d bb 98 00 00 00 4c 89 f8 48 c1 e8 03 80 3c 28 00 74 08 4c 89 ff e8 15 f7 e4 fe 4d 8b 3f 4d 8d 66 48 4c 89 e0 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 e7 e8 f9 f6 e4 fe 49 81 3c 24 00 2b 29 8c
RSP: 0018:ffffc90002dd7a68 EFLAGS: 00010206
RAX: 0000000000000009 RBX: ffff88807a954a00 RCX: ffff888031dbdb80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88807a954a00
RBP: dffffc0000000000 R08: ffffffff824b518a R09: ffffffff8eb5d6a0
R10: 0000000000000009 R11: 0000000000000000 R12: 0000000000000048
R13: 0000000000000002 R14: 0000000000000000 R15: ffff88801ebe3080
FS:  00005555945e4500(0000) GS:ffff888124ee2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000003000 CR3: 000000007ae84000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 fuse_parse_param+0x69b/0xa80 fs/fuse/inode.c:865
 vfs_parse_fs_param+0x1a9/0x420 fs/fs_context.c:132
 vfs_parse_fs_qstr fs/fs_context.c:173 [inline]
 vfs_parse_fs_string include/linux/fs_context.h:142 [inline]
 vfs_parse_monolithic_sep+0x283/0x360 fs/fs_context.c:213
 do_new_mount+0x304/0xd30 fs/namespace.c:3836
 do_mount fs/namespace.c:4173 [inline]
 __do_sys_mount fs/namespace.c:4372 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4349
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0932d9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffbe74bc28 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f0933015fa0 RCX: 00007f0932d9c799
RDX: 0000200000002100 RSI: 00002000000020c0 RDI: 0000000000000000
RBP: 00007f0932e32c99 R08: 0000200000002140 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0933015fac R14: 00007f0933015fa0 R15: 00007f0933015fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:fuse_opt_fd+0x49/0x220 fs/fuse/inode.c:807
Code: 4c 8d bb 98 00 00 00 4c 89 f8 48 c1 e8 03 80 3c 28 00 74 08 4c 89 ff e8 15 f7 e4 fe 4d 8b 3f 4d 8d 66 48 4c 89 e0 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 e7 e8 f9 f6 e4 fe 49 81 3c 24 00 2b 29 8c
RSP: 0018:ffffc90002dd7a68 EFLAGS: 00010206
RAX: 0000000000000009 RBX: ffff88807a954a00 RCX: ffff888031dbdb80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88807a954a00
RBP: dffffc0000000000 R08: ffffffff824b518a R09: ffffffff8eb5d6a0
R10: 0000000000000009 R11: 0000000000000000 R12: 0000000000000048
R13: 0000000000000002 R14: 0000000000000000 R15: ffff88801ebe3080
FS:  00005555945e4500(0000) GS:ffff888124ee2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000003000 CR3: 000000007ae84000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	4c 8d bb 98 00 00 00 	lea    0x98(%rbx),%r15
   7:	4c 89 f8             	mov    %r15,%rax
   a:	48 c1 e8 03          	shr    $0x3,%rax
   e:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
  12:	74 08                	je     0x1c
  14:	4c 89 ff             	mov    %r15,%rdi
  17:	e8 15 f7 e4 fe       	call   0xfee4f731
  1c:	4d 8b 3f             	mov    (%r15),%r15
  1f:	4d 8d 66 48          	lea    0x48(%r14),%r12
  23:	4c 89 e0             	mov    %r12,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 e7             	mov    %r12,%rdi
  33:	e8 f9 f6 e4 fe       	call   0xfee4f731
  38:	49 81 3c 24 00 2b 29 	cmpq   $0xffffffff8c292b00,(%r12)
  3f:	8c


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
