Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00899445AFF
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785518073; cv=none; b=PnlNm3Hvk0fIvqqC9thJPfxU0m7tHQOdvQJESRfGo6TWMSUo6gWlqAzlXgPCAcot1bLqtHxF0jftqH9XrHmH8IFZJjV/E+uD428orm+MW3MiJciQ9/JMekna4Ox5hn5QTiAL4sU2vLlkx0yhIx7nXN/oSz9M2OO4+yuEr2n8W9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785518073; c=relaxed/simple;
	bh=GbsZ42c9Ct216hTiBMFAnKCAWIvIVGetma4/x4feBkw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AINjRknskwJHr2n/eDWiHNYpp5c1stvYtyDfpYTosK2rsKhFaBUlkorYeIcq+UzR+QnKklRDcTxF/j3oFiQ1uaWEcbp/0HhsdUHGdOaTEEwxwngVJi2XcBnaHl7c1OgRBjXsCyX8nrDS9xUvfsEYrs1aPrwEYXGhfNUDL3sWltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-49001defc4dso1744042b6e.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 10:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785518071; x=1786122871;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rQ2CTzYQc65yCHluHvU2vADHSylNpT+V4b80bDedzxE=;
        b=rLc3e5+pfSr0kJ9GvQoCGCmoOIFyNQ1tkEk4ORF6Bpk0bbjSVty7y5vuW39+Cn/WKU
         ueh3B4hDnTpgQSL4uyEeh80jdrItdtAQd7UAOUI2tqKcpWnpuWZzwMWMUQvUJ/HCP9Y5
         5SledjXq4FMFwDufmXAPSIOJ690lU05HVjELgKlt92yRI3CwTw9hLb4o8XyxOboQ8+dp
         gcpQIgRSUFrkMnoHIYrrUtQhDWREIiXKFzJhTw4fOadcY7LvRSTPt+SDD7+dy1f2jJj8
         3zK8sdYi1UCKTkA1Ki9OuoknJtM8BmlztQcR/An4C91fSLDjWILooy/TPvKUsoDhztTu
         yruA==
X-Forwarded-Encrypted: i=1; AHgh+RpirgtLdhnrxtcQbiprQ29x2aW8Du4bW7WeuY0Bp+svY/ECs7KTvR/h/0vV4h2zKqvTwUKeHYzpONpPNZe/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0ce2Bxv4DAF7O9JuuQ1r5gyNM2k0NOyOnPNp2yi5jj45QCdvT
	IZ7Sk+O2aouT9YsmAcUMXT/gZO44PBOhBGLaQOedVf+WpAYWbD9jcnubcOR8naGuW2U6xwLUCmw
	tP52Y43BRmgugbMem1cXEO8DR2EG53LZMIk8unjdbqAACPLFxawNGIL5FDnA=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1792:b0:497:d252:d609 with SMTP id
 5614622812f47-4af5dfb8079mr1528242b6e.4.1785518070781; Fri, 31 Jul 2026
 10:14:30 -0700 (PDT)
Date: Fri, 31 Jul 2026 10:14:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6cd7f6.2d659fcc.1d46f5.0199.GAE@google.com>
Subject: [syzbot] [fs?] general protection fault in path_put
From: syzbot <syzbot+1686d17ae576cc5f8a57@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    11028ab62899 Merge tag 'probes-fixes-v7.2-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179d4aea580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=1686d17ae576cc5f8a57
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e497b1580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e2a48e580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-11028ab6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2be78614a29/vmlinux-11028ab6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/301a11d315af/bzImage-11028ab6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1686d17ae576cc5f8a57@syzkaller.appspotmail.com

RBP: 00007fffaa9085c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007feae0225fac R14: 00007feae0225fa0 R15: 00007feae0225fa0
 </TASK>
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
CPU: 0 UID: 0 PID: 5912 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:path_put+0x22/0x70 fs/namei.c:722
Code: 90 90 90 90 90 90 90 90 f3 0f 1e fa 53 48 89 fb e8 a3 61 78 ff 48 8d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 29 48 8b 7b 08 e8 4f 97 04 00 48 89 da 48 b8 00 00
RSP: 0018:ffffc900040c7a68 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: 000000000000003c RCX: 0000000000000000
RDX: 0000000000000008 RSI: ffffffff8291fe9d RDI: 0000000000000044
RBP: ffffc900040c7bf8 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff9b74bc40 R11: 0000000000000000 R12: ffff888022ab1f88
R13: ffff88802dcb4a60 R14: ffff888022a9c680 R15: fffffffffffffff4
FS:  000055557d29f500(0000) GS:ffff8880d5ddc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32f63fff CR3: 000000003cf56000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 free_trace_uprobe kernel/trace/trace_uprobe.c:374 [inline]
 free_trace_uprobe kernel/trace/trace_uprobe.c:369 [inline]
 __free_free_trace_uprobe kernel/trace/trace_uprobe.c:536 [inline]
 __trace_uprobe_create+0x96d/0x22f0 kernel/trace/trace_uprobe.c:545
 trace_probe_create+0xef/0x100 kernel/trace/trace_probe.c:2371
 dyn_event_create+0x46/0x70 kernel/trace/trace_dynevent.c:128
 create_or_delete_trace_uprobe+0x5a/0xb0 kernel/trace/trace_uprobe.c:739
 trace_parse_run_command+0x1ab/0x3b0 kernel/trace/trace.c:9565
 vfs_write+0x2aa/0x1050 fs/read_write.c:685
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feadff9df99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffaa908558 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007feae0225fa0 RCX: 00007feadff9df99
RDX: 000000000000000f RSI: 0000200000000180 RDI: 0000000000000004
RBP: 00007fffaa9085c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007feae0225fac R14: 00007feae0225fa0 R15: 00007feae0225fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:path_put+0x22/0x70 fs/namei.c:722
Code: 90 90 90 90 90 90 90 90 f3 0f 1e fa 53 48 89 fb e8 a3 61 78 ff 48 8d 7b 08 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 29 48 8b 7b 08 e8 4f 97 04 00 48 89 da 48 b8 00 00
RSP: 0018:ffffc900040c7a68 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: 000000000000003c RCX: 0000000000000000
RDX: 0000000000000008 RSI: ffffffff8291fe9d RDI: 0000000000000044
RBP: ffffc900040c7bf8 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff9b74bc40 R11: 0000000000000000 R12: ffff888022ab1f88
R13: ffff88802dcb4a60 R14: ffff888022a9c680 R15: fffffffffffffff4
FS:  000055557d29f500(0000) GS:ffff8880d5edc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b32f24008 CR3: 000000003cf56000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	f3 0f 1e fa          	endbr64
   c:	53                   	push   %rbx
   d:	48 89 fb             	mov    %rdi,%rbx
  10:	e8 a3 61 78 ff       	call   0xff7861b8
  15:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 29                	jne    0x59
  30:	48 8b 7b 08          	mov    0x8(%rbx),%rdi
  34:	e8 4f 97 04 00       	call   0x49788
  39:	48 89 da             	mov    %rbx,%rdx
  3c:	48                   	rex.W
  3d:	b8                   	.byte 0xb8


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
