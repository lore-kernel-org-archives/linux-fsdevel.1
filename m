Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7556B126BE1
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 00:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787530413; cv=none; b=Du958HE2U3iXLbGoZ+mRw16PCTJ+mUXblIdtpJ/fWg0UOPEMXMgWviFgHykSdlE3sOhWF66SWRSJJAz6s46qoSjLvIr2awMNbffuJzVsQ9d330sRHYuMwUamvsRs/UDhrJExkmYURgAcqsTJWsrlp9CfVU679iiCpvD99G67ubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787530413; c=relaxed/simple;
	bh=06AUqY0NWATXGns1wdsxvPErqV1uSYg2ZCeBcWJbPdA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kbEY/kPKJPCNnlVXrTdg37zLlbiAjOaE291jC8VwLcR8US+Z3eSwJuzEJg0rQq0BapcI/gVC1/WCTgASbynT6RII1Ulap8bESI4lCNixkW2KgpYFOtQWnI3sOXAGPmybwUymfb3TpkcLXwaw9XgaMdZpP9Fw+5nDmAoQyRh+4NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4a45b3f0bdfso5861190b6e.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 17:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787530410; x=1788135210;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z/+449VjIMMZq2CJMT31++BUW5kE71Qr3CUfJ8j1g/Q=;
        b=omv4BcbM+2na+SCWLQul+0kgysS2xntUaBYLLF6WAOZcJUYt4XJw8AK2+ANS23srBd
         5HYEFwaZWvza8wXQaQRec7QEO7NmCnHBgBiru0JJh1D7UX79PhNjAj0CfHQkoWcTWgOM
         cyKxZ/LtBYRL/yZAU4S5kU95jcMG1DYM0Jo0oXIm3W8He2zl49gOQYZy/KkqXN12mj1R
         GHWXrmTSf9Ff2/YM5jQr4uLmX8NSrqjMEa6YcUOko7Tw0hEdpbUY/3f5NRsnCYIZYu3r
         O8omF2WhIoo9Yn4Q+37ZnhodRqLNhG/MiCTEoCH+1GqfOMAT2ypkJMKYvY2RdeOpTntK
         pOAw==
X-Gm-Message-State: AFuF++kwcttBnSxnhe1YrT4xda35RKVLO0xNuLe+fyGrfs98/+G5KOvY
	nLzq00VkTLy7pA3VAzkPdV0TZ4iNJHjB/htz3DUxdcYUtcXZbGxqZ+GvVtTcmfhtyWZHaxtoqf4
	gd6e33eSGwNmmA4mGMrufKFeCztoawCDa+kG47Z+5J/7VRidx68tszPmLLy64tg==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b0d:b0:4a4:12c4:9c16 with SMTP id
 5614622812f47-4b2ef1fa073mr22692353b6e.7.1787530410429; Sun, 23 Aug 2026
 17:13:30 -0700 (PDT)
Date: Sun, 23 Aug 2026 17:13:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8b8caa.ae6ddae5.3da009.0071.GAE@google.com>
Subject: [syzbot] [trace?] [fs?] WARNING in free_ei
From: syzbot <syzbot+88bc830c26215a9f38dc@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    98f21c54f995 Merge tag 'for-linus-fwctl' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100af815580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87880a67258a10c5
dashboard link: https://syzkaller.appspot.com/bug?extid=88bc830c26215a9f38dc
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/14ce45f3c743/disk-98f21c54.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b189ccebbda8/vmlinux-98f21c54.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2d83175df409/bzImage-98f21c54.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+88bc830c26215a9f38dc@syzkaller.appspotmail.com

Could not create tracefs 'set_event_notrace_pid' entry
------------[ cut here ]------------
!list_empty(&ei->children)
WARNING: fs/tracefs/event_inode.c:128 at free_ei+0x284/0x340 fs/tracefs/event_inode.c:128, CPU#1: syz.4.591/8581
Modules linked in:
CPU: 1 UID: 0 PID: 8581 Comm: syz.4.591 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:free_ei+0x284/0x340 fs/tracefs/event_inode.c:128
Code: 48 c7 c7 00 c1 11 8f 48 89 de 48 c7 c2 e0 94 d9 83 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d e9 32 a5 d1 fd e8 cd 6c ed fd 90 <0f> 0b 90 e9 c7 fd ff ff e8 bf 6c ed fd 90 0f 0b 90 48 b8 00 00 00
RSP: 0018:ffffc9000432fa88 EFLAGS: 00010202
RAX: ffffffff83d99873 RBX: ffff8880752fe210 RCX: ffff888036070000
RDX: 0000000000000003 RSI: ffffffff8c4bdd60 RDI: ffff8880752fe200
RBP: ffff8880752fe200 R08: 00000000ffffffff R09: 1ffffffff20afb46
R10: dffffc0000000000 R11: fffffbfff20afb47 R12: 0000000000000000
R13: ffff888066e81800 R14: ffff8880752fe200 R15: 0000000000000003
FS:  00007f59a15ec6c0(0000) GS:ffff888125036000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8cd675da08 CR3: 000000006f27f000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 cleanup_ei fs/tracefs/event_inode.c:150 [inline]
 eventfs_create_events_dir+0x7c4/0x9f0 fs/tracefs/event_inode.c:834
 create_event_toplevel_files+0x11e/0x1a0 kernel/trace/trace_events.c:4593
 event_trace_add_tracer+0x8a/0x3b0 kernel/trace/trace_events.c:4624
 trace_array_create_dir+0x77/0x160 kernel/trace/trace.c:8548
 trace_array_create_systems+0xb3c/0xe60 kernel/trace/trace.c:8639
 trace_array_create kernel/trace/trace.c:8666 [inline]
 instance_mkdir+0xd5/0x140 kernel/trace/trace.c:8681
 tracefs_syscall_mkdir+0x11a/0x190 fs/tracefs/inode.c:121
 vfs_mkdir+0x40c/0x620 fs/namei.c:5410
 filename_mkdirat+0x285/0x510 fs/namei.c:5443
 __do_sys_mkdirat fs/namei.c:5464 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5461
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f59a079e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f59a15ec028 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f59a0a25fa0 RCX: 00007f59a079e0d9
RDX: 00000000000001ff RSI: 0000200000000140 RDI: ffffffffffffff9c
RBP: 00007f59a0835024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f59a0a26038 R14: 00007f59a0a25fa0 R15: 00007ffde26bcc48
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
