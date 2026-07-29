Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A535C22F01
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 00:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785283713; cv=none; b=ZfZCINCocJdEMS4lI3RXBPwoL0K6UiI2GlkJm0OxF0bv086EHxbT6HbrAYTu1M4bKDcXDOjPtUwQpZq2jOKbkj5NaEalKWvU2EDWi/XlY+Qm34doKu/Hq55/Pg+JGSyQbTzBFbyFEuC9nIERGHt2uwTvzLCc/MAdkKIx0Ct5DHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785283713; c=relaxed/simple;
	bh=m15/uLQUzt1/qMxqLD5P4CFQbcibhOAPueOU1QolVns=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iOnoCpFkcUpQciyp14aI7QumPy97JjYocQFw+T+PT7qb6iDAqtRQXhYh7ByJClTQFvMY1k8fDXr9xibOc4M/z6e/6+PBXMnw/w8zHo4y8eYa/t4yqVfPmW11BtbnYLNyldrsF2YeBDddrK+JrLpLlm1/Lq3FCVqYyCEaceZFpj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-4a43d32fa9fso514208b6e.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 17:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785283710; x=1785888510;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sQfd443m869Z315NskmbdGV/Ciywl9JKFn4B+STkpGc=;
        b=X8rg0ZbeTO4IWSn2H54uneNrp/uO+eDoQ47ZHyRn49F/AMfHzQIDaSsTWEX0G2IvoD
         TeLDu4vQnjqIPY0NKW84eNSOMbuWNlzmD+HHSsSSCOcmgkimD+cbB/tWmHr0BdraKtlR
         ywYbsxK8KM2GV8uBbzsVhKOhSsOPqlg26ieZGd9FukdJreuIIYnnyJjimnCVCKD8n9SQ
         zznr7K31LmZbXqV58SBnR9jXghmw+nWLb9KIQ44UQJivoAeCUWn/B3cArpC24w+D3ZaJ
         plxoUkJWwYlWI6kdtm4mXthWJew/wYUVSXG4Jje56BABc3sMyk1NKFsfhlWpGCtUlfAq
         lPiw==
X-Forwarded-Encrypted: i=1; AHgh+RqG6sNGb3igR0REDZA2BtkfBnHwLFCaHOmIKdjjCG2qIW5+PrB+B9JtbgwcoK9HJonbQg/BkQ2DEhMx0vV/@vger.kernel.org
X-Gm-Message-State: AOJu0YyhjDt1VhZZKsjs7x1cs5Od2F1K0eynd0oIt7VJJebD+rgik89d
	wJQHxHqpFNP+vadpJOP9N3Ry+x6j3HWQPHmRldeqCX4ngtikfryr4XWJI7JvtEnmb2lgP7oCx/+
	iSxFTeNwD8vNaeX/YMllyZNOo2T2rn3ZHBkvpGwcVdLwCrQ1P4XpcKmiPouY=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:130a:b0:48b:17c4:3572 with SMTP id
 5614622812f47-4ad5b9e93acmr2896992b6e.29.1785283710551; Tue, 28 Jul 2026
 17:08:30 -0700 (PDT)
Date: Tue, 28 Jul 2026 17:08:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a69447e.6bd615f2.c0aa.0000.GAE@google.com>
Subject: [syzbot] [fs?] WARNING: refcount bug in config_item_get
From: syzbot <syzbot+35790eb7861f8fc57382@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0ce37745d4bf Merge tag 'block-7.2-20260724' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1752909e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb17729fb04b1e3a
dashboard link: https://syzkaller.appspot.com/bug?extid=35790eb7861f8fc57382
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13603fde580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1147e1b9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c6e920012605/disk-0ce37745.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f5c4d270d5f3/vmlinux-0ce37745.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9e5e96acc1aa/bzImage-0ce37745.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+35790eb7861f8fc57382@syzkaller.appspotmail.com

Mass Storage Function, version: 2009/09/11
LUN: removable file: (no medium)
------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25, CPU#0: syz.4.481/6445
Modules linked in:
CPU: 0 UID: 0 PID: 6445 Comm: syz.4.481 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:refcount_warn_saturate+0x9f/0x110 lib/refcount.c:25
Code: eb 66 85 db 74 3e 83 fb 01 75 4c e8 bb cc 02 fd 48 8d 3d 64 60 f7 0a 67 48 0f b9 3a eb 4a e8 a8 cc 02 fd 48 8d 3d 61 60 f7 0a <67> 48 0f b9 3a eb 37 e8 95 cc 02 fd 48 8d 3d 5e 60 f7 0a 67 48 0f
RSP: 0018:ffffc90004777c48 EFLAGS: 00010293
RAX: ffffffff84c2fbe8 RBX: 0000000000000002 RCX: ffff88802809be00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8fba5c50
RBP: 0000000000000000 R08: ffff88802809be00 R09: 0000000000000005
R10: 0000000000000100 R11: 0000000000000004 R12: dffffc0000000000
R13: ffff888042748fb0 R14: ffff888034a6d424 R15: 1ffff920008eefa0
FS:  00005555785d9500(0000) GS:ffff888125c42000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc5c2af56b8 CR3: 00000000421ca000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:-1 [inline]
 __refcount_inc include/linux/refcount.h:366 [inline]
 refcount_inc include/linux/refcount.h:383 [inline]
 kref_get include/linux/kref.h:45 [inline]
 config_item_get+0x88/0x90 fs/configfs/item.c:104
 configfs_get_config_item fs/configfs/configfs_internal.h:127 [inline]
 get_target fs/configfs/symlink.c:128 [inline]
 configfs_symlink+0x4ab/0x1030 fs/configfs/symlink.c:185
 vfs_symlink+0x18b/0x330 fs/namei.c:5660
 filename_symlinkat+0x1cd/0x420 fs/namei.c:5685
 __do_sys_symlinkat fs/namei.c:5705 [inline]
 __se_sys_symlinkat+0x4e/0x2b0 fs/namei.c:5700
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb94cbede99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeae1a3f68 EFLAGS: 00000246 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 00007fb94ce75fa0 RCX: 00007fb94cbede99
RDX: 0000200000000300 RSI: ffffffffffffff9c RDI: 0000200000000200
RBP: 00007fb94cc83eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb94ce75fac R14: 00007fb94ce75fa0 R15: 00007fb94ce75fa0
 </TASK>
----------------
Code disassembly (best guess):
   0:	eb 66                	jmp    0x68
   2:	85 db                	test   %ebx,%ebx
   4:	74 3e                	je     0x44
   6:	83 fb 01             	cmp    $0x1,%ebx
   9:	75 4c                	jne    0x57
   b:	e8 bb cc 02 fd       	call   0xfd02cccb
  10:	48 8d 3d 64 60 f7 0a 	lea    0xaf76064(%rip),%rdi        # 0xaf7607b
  17:	67 48 0f b9 3a       	ud1    (%edx),%rdi
  1c:	eb 4a                	jmp    0x68
  1e:	e8 a8 cc 02 fd       	call   0xfd02cccb
  23:	48 8d 3d 61 60 f7 0a 	lea    0xaf76061(%rip),%rdi        # 0xaf7608b
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	eb 37                	jmp    0x68
  31:	e8 95 cc 02 fd       	call   0xfd02cccb
  36:	48 8d 3d 5e 60 f7 0a 	lea    0xaf7605e(%rip),%rdi        # 0xaf7609b
  3d:	67                   	addr32
  3e:	48                   	rex.W
  3f:	0f                   	.byte 0xf


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
