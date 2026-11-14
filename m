Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794658169;
	b=AQCGNYqs7ISqbtLr0OUzn/eVoGhjhLNv8c7VmI1GjjUooXFRppe4llT5GDjC5da+j5KZ
	 zaYcAfjTpU2lanp7elmotKgXPAuN1FmckMTDgc5TgAqkUpzASZo81lJymiftorLnb9OhM
	 xuRvAxKMv+wggLA8/zK6+D4QZ3GAixzOeyfOeiFL/nVy0a+ozxF/bSktGW9SaQqShs+3q
	 VhYBDm6hFiRmEJCkBa0iBb1OGisoQSll6d7RXu5IPcqrriXosZkcS8oZUzu8BkmPzjYq5
	 93uVJBvBRUC2VaoK2UXEETOQ3sqlxDWDeDGZmR48kp7fbvrKIBfOACPflwy1gAFW0yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794658169;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=UureYaaeVfHQ486k+R1nqPXa2SkWUzwY9akojhfzklY=;
	b=gHwO8DOl4OxeEkzWPTik9aJ8M00lOV/j8l3nDrsmBg4oA/DkaaylcXTZoTCPccIkoE8c
	 Qp8tTtxlt5IBeV/SgX4QFRCrVascKxnT/9fbOuSze45y352RwmMkDj8kVnukzqxjrwHEY
	 efR90cSWUqzNcnD82/9ALRVX5SXEI08MAwG5OQBwWvEIQcfe1wO9A9pJ8Lekjihl/D/As
	 roQb0N6gE9JiiJyEsGFOI0GrsEgisSekwDalmykeFB/3piVBHK0SjEOtTCEdmYoj07ow1
	 q0y9/fWVV8wtK6Us6GbtFQxTJmX0zTJV7cAdCWwR3DPozz5s+wHZG4xgSIEBD31o2ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A8D606A323
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 12:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75A8D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4c467e19391so3061516b6e.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 04:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794658168; x=1795262968;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UureYaaeVfHQ486k+R1nqPXa2SkWUzwY9akojhfzklY=;
        b=CCWQz7EkIXun7DwrkLWkPwmC+N9TPyF5AdxYdN9xuFsRpEzWBNw/5PuPwr/QMh9eAA
         zeUUwOyH2s0U+cb0ls6+bWV6oibBhieajd70XtOyVI7m/hZayZfyG+qd+BBAGGd9MjBD
         RHUEvdhAKWF9mdgjBr1ENlcHJ/Eg8bOnOI84KEeOuOIyXZ1VhkNNkdnUhPUIa51ytcub
         6chKRiPj90uRPzaMGvT/yzzmf90iIH9kDC/yMcJEA2QbrbLxMcPCPlptY1HlqjipFN8H
         2Gokx7VJulNiZGJvLNZ0xNv3HfnSfikavpRLpHsB1nYrBamIFFOQgCOdwWdtKS/82Dxs
         8WjQ==
X-Forwarded-Encrypted: i=1; AL+hErHp/P6jxAGxQxb3E/K6Z14oR8SYBkdq7xg4u2lz7r42mT1QSUJ6S7S7PPoQcQUEtV8FvNy16BU3/+8P3h3/@vger.kernel.org
X-Gm-Message-State: APuU4Z+8MD8yL/M6XQY/INZy5F3UOQiGKI/qznQmq8ofJBHT3a6p4XFK
	Xr5AnAPVx6UoZ9HW+aop2pSi46Q6ex/7zA+CeDS6Aq5+z2hNHj7rbBpKlD76kIL1M8JwJKSSYgE
	6QsBbXdzzmKM/cdeLPhIO+dl1bQfwluy34bHms0owOkoQdQAFbT5TY9MnC4s=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1917:b0:4f0:a3f9:9f89 with SMTP id
 5614622812f47-56e62c69198mr4296410b6e.18.1794658168260; Sat, 14 Nov 2026
 04:09:28 -0800 (PST)
Date: Sat, 14 Nov 2026 04:09:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af84f78.097d52ff.3d440.0004.GAE@google.com>
Subject: [syzbot] [squashfs?] general protection fault in lookup_open
From: syzbot <syzbot+0b7a8fb8279a59e8a188@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk, 
	squashfs-devel@lists.sourceforge.net, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    84abb955b101 Add linux-next specific files for 20261113
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1082844d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9d5eeb0ba036071
dashboard link: https://syzkaller.appspot.com/bug?extid=0b7a8fb8279a59e8a188
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148b45be580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160f55a1580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ffae1d4a717e/disk-84abb955.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd2a35a63abf/vmlinux-84abb955.xz
kernel image: https://storage.googleapis.com/syzbot-assets/039ccf647778/bzImage-84abb955.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/90d273be2ea1/mount_0.gz

AI-generated root cause summary:
In fs/squashfs/namei.c:squashfs_lookup(), sanity checks using
squashfs_dir_space() jump directly to label read_failure instead of data_error
upon detecting that a directory entry extends beyond inode size. Jumping to
read_failure bypasses the assignment of err = -EIO, leaving err set to either an
uninitialized value or a positive value returned by a prior successful call to
squashfs_read_metadata() (such as sizeof(struct squashfs_dir_entry) == 8).
Consequently, squashfs_lookup() returns ERR_PTR(8), which IS_ERR() does not
recognize as an error pointer; VFS lookup_open() subsequently dereferences
dentry->d_inode at address 0x8 + 0x68 = 0x70, triggering a near-NULL pointer
dereference crash.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=0b7a8fb8279a59e8a188

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0b7a8fb8279a59e8a188@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 8
SQUASHFS error: Unable to read directory block [0:26]
Oops: general protection fault, probably for non-canonical address 0xdffffc000000000d: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
CPU: 1 UID: 0 PID: 5645 Comm: syz-executor126 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
RIP: 0010:lookup_open+0x890/0x16e0 fs/namei.c:4648
Code: 09 00 00 e8 a2 60 68 ff 49 81 ff 01 f0 ff ff 0f 83 2a ff ff ff 4d 8d 77 68 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 f7 e8 92 54 e8 ff 49 83 3e 00 74 07 e8 67
RSP: 0018:ffffc900039579c0 EFLAGS: 00010203
RAX: 000000000000000d RBX: 0000000000000040 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 00000000ffffffff
RBP: 00000000ffffffe2 R08: ffff8880134403fb R09: 1ffff1100268807f
R10: dffffc0000000000 R11: ffffed1002688080 R12: 1ffff110026f064c
R13: ffffc90003957e00 R14: 000000000000006e R15: 0000000000000006
FS:  0000555559c4d400(0000) GS:ffff8881234cd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000000b400 CR3: 0000000071a58000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 open_last_lookups fs/namei.c:4880 [inline]
 path_openat+0x7a5/0x20e0 fs/namei.c:5119
 do_file_open+0x23e/0x4a0 fs/namei.c:5151
 do_sys_openat2+0x115/0x200 fs/open.c:1492
 do_sys_open fs/open.c:1498 [inline]
 __do_sys_openat fs/open.c:1838 [inline]
 __se_sys_openat fs/open.c:1833 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1833
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x00007fc862573909
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff58fa7d68 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc862573909
RDX: 000000000000275a RSI: 000020000000b400 RDI: 00000000ffffff9c
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000555559c4e580
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff58fa7d90
R13: 0000000000000002 R14: 431bde82d7b634db R15: 00007fc8625d304b
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:lookup_open+0x890/0x16e0 fs/namei.c:4648
Code: 09 00 00 e8 a2 60 68 ff 49 81 ff 01 f0 ff ff 0f 83 2a ff ff ff 4d 8d 77 68 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 f7 e8 92 54 e8 ff 49 83 3e 00 74 07 e8 67
RSP: 0018:ffffc900039579c0 EFLAGS: 00010203
RAX: 000000000000000d RBX: 0000000000000040 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 00000000ffffffff
RBP: 00000000ffffffe2 R08: ffff8880134403fb R09: 1ffff1100268807f
R10: dffffc0000000000 R11: ffffed1002688080 R12: 1ffff110026f064c
R13: ffffc90003957e00 R14: 000000000000006e R15: 0000000000000006
FS:  0000555559c4d400(0000) GS:ffff8881233cd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557377da1760 CR3: 0000000071a58000 CR4: 00000000003526f0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	e8 a2 60 68 ff       	call   0xff6860a9
   7:	49 81 ff 01 f0 ff ff 	cmp    $0xfffffffffffff001,%r15
   e:	0f 83 2a ff ff ff    	jae    0xffffff3e
  14:	4d 8d 77 68          	lea    0x68(%r15),%r14
  18:	4c 89 f0             	mov    %r14,%rax
  1b:	48 c1 e8 03          	shr    $0x3,%rax
  1f:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  26:	fc ff df
* 29:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2d:	74 08                	je     0x37
  2f:	4c 89 f7             	mov    %r14,%rdi
  32:	e8 92 54 e8 ff       	call   0xffe854c9
  37:	49 83 3e 00          	cmpq   $0x0,(%r14)
  3b:	74 07                	je     0x44
  3d:	e8                   	.byte 0xe8
  3e:	67                   	addr32


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
