Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC65334404A
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776117039; cv=none; b=KE5iScXuGyHucMLtKNrMYMTB4FLDV+wKKmFHWvskdVGykimugwFKQPMauIQ4ogWL1gRfNBWjODJSu24TDIb1E1bczbMOMBaF2xCcCqMMnQc+WlquXXzy0xpJLSb+6VIUtFja7m8UvlhsQ355XeexCxpb5gWRKhT2Bg1NTwGrcs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776117039; c=relaxed/simple;
	bh=c+E4eRjAaW/lr/CqAgJ3dUHPMdCkswslkPy6X9zSgU8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XInSfOlbB+Tzuh7r019btWwnYT5wn4rlXSjoy0HLi7oEg8gkYAV+9DfwuXnwYUl9oXAztlmErrBGw1kz3Vu6v4041EXoh/+hlaNsBLzT1U1qmm7YQfzE2rtsgn+92pciIwzqNn4S/YsFr0sJMDO3WUm7WjQy92nKw/tKa6HgaBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-68d5974b947so5820582eaf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 14:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776117037; x=1776721837;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OOvOK1zozUXDfJnQ6T41CBvF6hsgMt5kdcyiaW4zRzA=;
        b=oS8eBIf/lsDZ8GtD0Ii/STsh2cqckRBxqm6+FQQelP5V4t1emvnvQjG5JjXfNTk0q7
         /imgQrpzcmc0PDzizZKg1QSSEmMyRya+zbiKXK4DjyKUAJpcfrhlduQcbUxHcJ/dk4HM
         fwbSWMtRLHCer1tmSwUeXYpOT39wd/uzCDN0rttFjAS9YfpbBHI1Z1Lv5bHgFM9og6Xr
         eVc05Z0jSZ8obkbhqPLfop7EdnG6+U9fadTfgVtIMNhwsvBh9L+z8RR+wlvbo1duwxbf
         iuPQz6ABx5itPfNey+lnHwysctAeoGYk7v6APUPzr9ib1Cdvl+yfc5u3ogzd4cbDYgvW
         2pJw==
X-Forwarded-Encrypted: i=1; AFNElJ9hlTfZpnCn70YsbYKgTTA2Ez7DEMyp/wmuXqrkY1XI9rE5/k+/ivqrUyTn8VMZkroLhfxX2HEIaMdOR+sE@vger.kernel.org
X-Gm-Message-State: AOJu0YzWhmK89rZsUXtSe03LNV3wyaTEM4bFMT1bJHkBztlOpKUSi97I
	VJasrcxofyXWyFC/+18HOJ3KeO8+3Lph4hZd17M6JnZ0rEQB2A2TcVDPyIRaXuLdwuGEFHxxwlu
	1V/DH6s9HZywa0IiyJAdDR/Y7cYKdYhn7nXWPCYPKPBsLr/8mYPGntDdTuCQ=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:290e:b0:68e:314a:aefa with SMTP id
 006d021491bc7-68e314abe27mr4743672eaf.28.1776117036870; Mon, 13 Apr 2026
 14:50:36 -0700 (PDT)
Date: Mon, 13 Apr 2026 14:50:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69dd652c.a00a0220.475f0.002d.GAE@google.com>
Subject: [syzbot] [hfs?] general protection fault in hfsplus_cat_write_inode
From: syzbot <syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    26ff969926a0 Merge tag 'rust-7.1' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123510ce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bcb138057684c76a
dashboard link: https://syzkaller.appspot.com/bug?extid=c0ba772a362e70937dfb
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163510ce580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112bdb02580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8710bc1acc42/disk-26ff9699.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f03e7f936c8a/vmlinux-26ff9699.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ba58fa2f951e/bzImage-26ff9699.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/08271f11c795/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
hfsplus: xattr search failed
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 UID: 0 PID: 6072 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
RIP: 0010:hfsplus_cat_write_inode+0xbe/0x8f0 fs/hfsplus/inode.c:637
Code: f3 f3 4a 89 44 33 51 4a 89 44 33 59 66 42 c7 44 33 61 f3 f3 42 c6 44 33 63 f3 e8 2d 77 23 ff 4d 8d 7d 28 4c 89 f8 48 c1 e8 03 <42> 80 3c 30 00 74 08 4c 89 ff e8 73 9b 89 ff 41 be 98 07 00 00 4d
RSP: 0018:ffffc900040f7880 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 1ffff9200081ef14 RCX: ffff888028725b80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900040f7c10 R08: 0000000000000004 R09: 0000000000000004
R10: fffff5200081ef24 R11: fffffbfff1ed4f17 R12: 1ffff9200081ef8c
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000028
FS:  0000555586e4a500(0000) GS:ffff888126332000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f427032f000 CR3: 0000000036c06000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 hfsplus_unlink+0x57a/0x930 fs/hfsplus/dir.c:435
 vfs_unlink+0x272/0x6d0 fs/namei.c:5476
 filename_unlinkat+0x3d3/0x610 fs/namei.c:5546
 __do_sys_unlink fs/namei.c:5581 [inline]
 __se_sys_unlink+0x2e/0x140 fs/namei.c:5578
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f464eabc819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd69795788 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007f464ed35fa0 RCX: 00007f464eabc819
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000200
RBP: 00007f464eb52c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f464ed35fac R14: 00007f464ed35fa0 R15: 00007f464ed35fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfsplus_cat_write_inode+0xbe/0x8f0 fs/hfsplus/inode.c:637
Code: f3 f3 4a 89 44 33 51 4a 89 44 33 59 66 42 c7 44 33 61 f3 f3 42 c6 44 33 63 f3 e8 2d 77 23 ff 4d 8d 7d 28 4c 89 f8 48 c1 e8 03 <42> 80 3c 30 00 74 08 4c 89 ff e8 73 9b 89 ff 41 be 98 07 00 00 4d
RSP: 0018:ffffc900040f7880 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 1ffff9200081ef14 RCX: ffff888028725b80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900040f7c10 R08: 0000000000000004 R09: 0000000000000004
R10: fffff5200081ef24 R11: fffffbfff1ed4f17 R12: 1ffff9200081ef8c
R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000028
FS:  0000555586e4a500(0000) GS:ffff888126332000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f427032f000 CR3: 0000000036c06000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	f3 f3 4a 89 44 33 51 	repz xrelease mov %rax,0x51(%rbx,%r14,1)
   7:	4a 89 44 33 59       	mov    %rax,0x59(%rbx,%r14,1)
   c:	66 42 c7 44 33 61 f3 	movw   $0xf3f3,0x61(%rbx,%r14,1)
  13:	f3
  14:	42 c6 44 33 63 f3    	movb   $0xf3,0x63(%rbx,%r14,1)
  1a:	e8 2d 77 23 ff       	call   0xff23774c
  1f:	4d 8d 7d 28          	lea    0x28(%r13),%r15
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ff             	mov    %r15,%rdi
  34:	e8 73 9b 89 ff       	call   0xff899bac
  39:	41 be 98 07 00 00    	mov    $0x798,%r14d
  3f:	4d                   	rex.WRB


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
