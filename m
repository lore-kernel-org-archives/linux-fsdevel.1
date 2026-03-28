Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9139021ADC7
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774703789; cv=none; b=QXNfyEAn+sdzmMvsJtrkGVTEUUM/zWw34BXMW8JZwkL8dk94JCJsNa0TNN5mzim/BsW73YaOaELEXOe7iv43c8Xt6M0sPgXZvJ7ErtW8TsKNV0U1sfg07Ul9oQ+ElourLfH+9hVaU2vpi/+H0k4Nrq66xtNuxhs82H4KVaKqZMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774703789; c=relaxed/simple;
	bh=ZiGsgeSrjg9uAoMFtJzJ4q6AW+ojb9G1levg4AcoLJE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oS1Gd4cWx67PFZ9RjrI6DGQUKSdKsOpYFyVugmo673mNwbwLCU7SsKeSmmkAILs8XVFf3dbM2psgt8MfSVkleFrG1SebEcneQpz0PalKquIMdLPwCesQgUu8TBHJsu1A3rCJcDnQJXVcmzw40B78QEla+VbiYvCQatFwik1REgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7d7fd0be5e3so10189565a34.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 06:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774703786; x=1775308586;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8FBeW+oWPHXB8K+fjGBmACrI1VjwV0GA6TY2uP7YaJg=;
        b=jfQ+EhWzBu6ikWeuNxphg3uNleJ2aCGjVRGwMsmiCKrV+cRTTRNF7kn4tGh/bjmqJ+
         8erQp6kFxXTg9+Enspr6beBoxD2Cs9r5j3j0F5R5lFs04gVphYvcej3e753NcRZwiblb
         YSameig+x4mPl9ZxZ0tTB9etc9RhpoGfekJBdUBFFMHp71tYblo/19McZIrb8NJ2uHCW
         k0WtrGmA7k8rBaM3C7G4NkUT1jd2OVCXSx9l2ZKlSMwPu40DxI6dbJ3y2b+ql6ZlaTfV
         g0D69cJAa9lu/USJES1n0OPb4S9bKNqNcbJW9/QvSj5uKzunklLV6Xw3KOl90OTcly4K
         oYiw==
X-Forwarded-Encrypted: i=1; AJvYcCXQBlxWqQUXFsNevNzKPdUgDA4g8/0ldiBDoDHvpaXc9aB9pe0BQREwiTyoOEO5ylQfNDaXwd1Y4vvRd0rf@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5M7ei4thtXZRucMR3rr30vbRkZfXm7MjfmPBaxhJvO4Ks+V2s
	YpM5XEdlqfTAmkeaK5LwM3qEGeG+tvRtjIF1DlkeQTcDZ6XbmaOnY338DSvrjvOde1+P/GbZl8l
	oLvLIx4zbZcU1ebY8rVebz8xHSrPqx3eGhmOkDW3a+os7DQlcVwyk+1PaNOE=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:bb88:0:b0:67c:2bfd:24a3 with SMTP id
 006d021491bc7-67e10ce7d8dmr3355794eaf.20.1774703786513; Sat, 28 Mar 2026
 06:16:26 -0700 (PDT)
Date: Sat, 28 Mar 2026 06:16:26 -0700
In-Reply-To: <69bdce08.050a0220.3bf4de.0031.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69c7d4aa.a70a0220.128fd0.0027.GAE@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in __umount_mnt
From: syzbot <syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kartikey406@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mszeredi@redhat.com, raven@themaw.net, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3b058d1aeeef Add linux-next specific files for 20260327
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11bd16f6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4acce231a75c746f
dashboard link: https://syzkaller.appspot.com/bug?extid=e4470cc28308f2081ec8
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11dc6606580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15baca26580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5a5b73363d45/disk-3b058d1a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecba5c3ac106/vmlinux-3b058d1a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/348124eb71de/bzImage-3b058d1a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xfbd59c0000000024: 0000 [#1] SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0xdead000000000120-0xdead000000000127]
CPU: 0 UID: 0 PID: 6113 Comm: syz.0.28 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:__hlist_del include/linux/list.h:992 [inline]
RIP: 0010:hlist_del_init include/linux/list.h:1020 [inline]
RIP: 0010:__umount_mnt+0x24e/0x490 fs/namespace.c:997
Code: 85 e4 74 61 4d 8d be f8 00 00 00 4c 89 f8 48 c1 e8 03 80 3c 28 00 74 08 4c 89 ff e8 ac 3f e3 ff 4d 8b 2f 4c 89 e0 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 e7 e8 84 40 e3 ff 4d 89 2c 24 4d 85 ed 74
RSP: 0018:ffffc900033a7a20 EFLAGS: 00010a06
RAX: 1bd5a00000000024 RBX: ffff88807dcb5188 RCX: ffff88803244bd00
RDX: 0000000000000000 RSI: ffffffff8e8d83a0 RDI: ffff88807dcb51f8
RBP: dffffc0000000000 R08: ffffffff90128af7 R09: 1ffffffff202515e
R10: dffffc0000000000 R11: fffffbfff202515f R12: dead000000000122
R13: dead000000000100 R14: ffff88807dcb5180 R15: ffff88807dcb5278
FS:  000055558d53f500(0000) GS:ffff88812543f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f50a85ea078 CR3: 0000000076400000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 umount_mnt fs/namespace.c:1008 [inline]
 umount_tree+0x925/0xd90 fs/namespace.c:1819
 put_mnt_ns+0x1d6/0x2f0 fs/namespace.c:6264
 evict+0x61e/0xb10 fs/inode.c:846
 __dentry_kill+0x1a2/0x5e0 fs/dcache.c:670
 finish_dput+0xc9/0x480 fs/dcache.c:879
 __fput+0x691/0xa70 fs/file_table.c:477
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:269 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:328 [inline]
 do_syscall_64+0x33e/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f265d99c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe16be4ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f265dc17da0 RCX: 00007f265d99c799
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f265dc17da0 R08: 00007f265dc16038 R09: 0000000000000000
R10: 000000000003fda8 R11: 0000000000000246 R12: 00000000000161c9
R13: 00007f265dc1609c R14: 0000000000015fb1 R15: 00007f265dc16090
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__hlist_del include/linux/list.h:992 [inline]
RIP: 0010:hlist_del_init include/linux/list.h:1020 [inline]
RIP: 0010:__umount_mnt+0x24e/0x490 fs/namespace.c:997
Code: 85 e4 74 61 4d 8d be f8 00 00 00 4c 89 f8 48 c1 e8 03 80 3c 28 00 74 08 4c 89 ff e8 ac 3f e3 ff 4d 8b 2f 4c 89 e0 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 e7 e8 84 40 e3 ff 4d 89 2c 24 4d 85 ed 74
RSP: 0018:ffffc900033a7a20 EFLAGS: 00010a06
RAX: 1bd5a00000000024 RBX: ffff88807dcb5188 RCX: ffff88803244bd00
RDX: 0000000000000000 RSI: ffffffff8e8d83a0 RDI: ffff88807dcb51f8
RBP: dffffc0000000000 R08: ffffffff90128af7 R09: 1ffffffff202515e
R10: dffffc0000000000 R11: fffffbfff202515f R12: dead000000000122
R13: dead000000000100 R14: ffff88807dcb5180 R15: ffff88807dcb5278
FS:  000055558d53f500(0000) GS:ffff88812543f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f50a85ea078 CR3: 0000000076400000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	85 e4                	test   %esp,%esp
   2:	74 61                	je     0x65
   4:	4d 8d be f8 00 00 00 	lea    0xf8(%r14),%r15
   b:	4c 89 f8             	mov    %r15,%rax
   e:	48 c1 e8 03          	shr    $0x3,%rax
  12:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
  16:	74 08                	je     0x20
  18:	4c 89 ff             	mov    %r15,%rdi
  1b:	e8 ac 3f e3 ff       	call   0xffe33fcc
  20:	4d 8b 2f             	mov    (%r15),%r13
  23:	4c 89 e0             	mov    %r12,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 e7             	mov    %r12,%rdi
  33:	e8 84 40 e3 ff       	call   0xffe340bc
  38:	4d 89 2c 24          	mov    %r13,(%r12)
  3c:	4d 85 ed             	test   %r13,%r13
  3f:	74                   	.byte 0x74


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
