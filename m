Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6D42E8C2
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786697976; cv=none; b=c+Xf4wxrUgj6P90iMIUVxLKsO2XH5qktWMjbDSPJaIuvJTN7tjv7vUdhkAmjVXaUpTO1Mpe+T/IwLtEvXsVwAhjWjV0qSJyRVgEUKeLLVVkL+ujgKSo+PbHTduNwMnXJ/ot1f3cYvKgKgToHFO5BODFON0oRNbhtfkYiGsTlLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786697976; c=relaxed/simple;
	bh=NKKwm28G48/HON8PGLtrBAwo+veQl1Lm5LYpbIgZinU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G3PyrRQ/S5LQKgTBNv1Y4GWtbSrQb7sM1xZv1+dHECNeb6Yrn8doDBnnMieLh6+p+CQ695OLGIVvU9tq+CROxSQKSBQklTMYoH8Z3B4YGxKIIgrLDzA1E9FMLdu8fDzXr+Q9Evjl8bOjL8frIHyfDAivni6LcZU+S4PrxxxRikY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-6a0f261aeb6so966211eaf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 01:59:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786697973; x=1787302773;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h8fC/Tv0EhojxsriFVYDUOaebugZ8Tir3LiUkWf7dMY=;
        b=i8gODUo06x4r+2aEzSBdQoqBQpj2CBzE/muKZFXeOb9Raz7w7Cuju9HTYO9M+QcVdi
         +PwQ8GNIXWR0Ss5aXEmX46Ac6fS4/wU2oSZecye0YoTx0eTVKAz9aKphNPy5/H117wHX
         Jbm3/ghpWWre2/KapU1UjX0dac2qun9KMjUxvm+LxNUG5r4FVcIw3tHCpZg9imhHLYfm
         Yqg5hs3hyCZs4AdqPEQ53+Czt+AYZmArAModr3KdL6gyaxTnZirceIHnRt35Do7pe56G
         t94OjNl09HyVQ5BajUooMR7+HR1Z5fhMV+XTcLgYIqIty8cuacrBuoaJqIahQfbFmUAN
         ORhw==
X-Forwarded-Encrypted: i=1; AHgh+Rq7pAHnGKnIc7KwTFu/+x8MzdN+NihIvb2tBtS4BPQnDRFh8Ytb521zlEYYq4cPsshHek5ufNbKLYxkbhGi@vger.kernel.org
X-Gm-Message-State: AOJu0Yww/O1UbO4eUff6+86Sf5pRmNrhBMe+8//SlQOK0L9cK+BDP4lC
	uRkWGogxaemnSuqUoCgd7apxCNrVzr0FGJu7a0osivAVajmE+klmNYLwwywD4cyTP5t96j0GNWh
	qEU+EsO3t3xvyh2nfkATkdhEyXP6pHEg3hb6Atz5S9GW/lLX8Ky5zYSY5/Po=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c8a:b0:6b0:dfa2:830b with SMTP id
 006d021491bc7-6b0dfa287d6mr680739eaf.12.1786697973142; Fri, 14 Aug 2026
 01:59:33 -0700 (PDT)
Date: Fri, 14 Aug 2026 01:59:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7ed8f5.91706f20.9568a.0003.GAE@google.com>
Subject: [syzbot] [fs?] general protection fault in configfs_symlink
From: syzbot <syzbot+fb804e639c963f8eea9c@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f1baf1fc892 Merge tag 'trace-v7.2-rc7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1545f149580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=158601bb8cb292dd
dashboard link: https://syzkaller.appspot.com/bug?extid=fb804e639c963f8eea9c
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8dd1ca52ce7b/disk-2f1baf1f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8fdd3c891266/vmlinux-2f1baf1f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c83197355e17/bzImage-2f1baf1f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fb804e639c963f8eea9c@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000016: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000000b0-0x00000000000000b7]
CPU: 1 UID: 0 PID: 8680 Comm: syz.3.808 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:create_link fs/configfs/symlink.c:81 [inline]
RIP: 0010:configfs_symlink+0x5fc/0x1030 fs/configfs/symlink.c:199
Code: 03 42 80 3c 20 00 74 08 48 89 df e8 ae a3 c2 ff 41 bc b0 00 00 00 4c 03 23 4c 89 e0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 e7 e8 86 a3 c2 ff 4d 8b 2c 24 4c 89 ef e8
RSP: 0018:ffffc90006b27c80 EFLAGS: 00010202
RAX: 0000000000000016 RBX: ffff88805b9a9a48 RCX: dffffc0000000000
RDX: 0000000000000006 RSI: ffffffff8d881af0 RDI: 00000000ffffffff
RBP: ffffc90006b27d88 R08: ffffffff8faf4f37 R09: 1ffffffff1f5e9e6
R10: dffffc0000000000 R11: fffffbfff1f5e9e7 R12: 00000000000000b0
R13: 0000000000000000 R14: ffffffff8c21fe48 R15: 1ffff92000d64fa0
FS:  00007f70373346c0(0000) GS:ffff888125d45000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff9610f56c8 CR3: 000000005e8fe000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 vfs_symlink+0x18b/0x330 fs/namei.c:5660
 filename_symlinkat+0x1cd/0x420 fs/namei.c:5685
 __do_sys_symlinkat fs/namei.c:5705 [inline]
 __se_sys_symlinkat+0x4e/0x2b0 fs/namei.c:5700
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f703911e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7037334028 EFLAGS: 00000246 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 00007f70393a6180 RCX: 00007f703911e0d9
RDX: 0000200000001c00 RSI: ffffffffffffff9c RDI: 0000200000001b00
RBP: 00007f70391b5024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f70393a6218 R14: 00007f70393a6180 R15: 00007ffd2a6d2ad8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:create_link fs/configfs/symlink.c:81 [inline]
RIP: 0010:configfs_symlink+0x5fc/0x1030 fs/configfs/symlink.c:199
Code: 03 42 80 3c 20 00 74 08 48 89 df e8 ae a3 c2 ff 41 bc b0 00 00 00 4c 03 23 4c 89 e0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 e7 e8 86 a3 c2 ff 4d 8b 2c 24 4c 89 ef e8
RSP: 0018:ffffc90006b27c80 EFLAGS: 00010202
RAX: 0000000000000016 RBX: ffff88805b9a9a48 RCX: dffffc0000000000
RDX: 0000000000000006 RSI: ffffffff8d881af0 RDI: 00000000ffffffff
RBP: ffffc90006b27d88 R08: ffffffff8faf4f37 R09: 1ffffffff1f5e9e6
R10: dffffc0000000000 R11: fffffbfff1f5e9e7 R12: 00000000000000b0
R13: 0000000000000000 R14: ffffffff8c21fe48 R15: 1ffff92000d64fa0
FS:  00007f70373346c0(0000) GS:ffff888125d45000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c3f0968 CR3: 000000005e8fe000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	03 42 80             	add    -0x80(%rdx),%eax
   3:	3c 20                	cmp    $0x20,%al
   5:	00 74 08 48          	add    %dh,0x48(%rax,%rcx,1)
   9:	89 df                	mov    %ebx,%edi
   b:	e8 ae a3 c2 ff       	call   0xffc2a3be
  10:	41 bc b0 00 00 00    	mov    $0xb0,%r12d
  16:	4c 03 23             	add    (%rbx),%r12
  19:	4c 89 e0             	mov    %r12,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 e7             	mov    %r12,%rdi
  33:	e8 86 a3 c2 ff       	call   0xffc2a3be
  38:	4d 8b 2c 24          	mov    (%r12),%r13
  3c:	4c 89 ef             	mov    %r13,%rdi
  3f:	e8                   	.byte 0xe8


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
