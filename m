Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7852C4477E3
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135973; cv=none; b=tXRH62cQXkhyKvGt2gQhnv+oParA6VwdKFB3SomY0h3vsMCKEZwJMRDp7XWtDrjxfmM/oaKbwZMIGFKaW+phI7j7SId+0rm0DVIg1K0uhK+qzS/DiKjcNzrTjeQ0TPQm0BDGj7sTEwRDF4XfKKk7qMIJSCUHEKTODgqxdBGZxR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135973; c=relaxed/simple;
	bh=0lqg0zig61PhYIVpk8JV6/dZoMgln3ExA6zGv3cfk+w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G4qBZZmAZTYQIR5N3kE/4rDhOdpYNTYi7Zi4ApqDA6zO/eju2L51PUIIG5HMQjSelG83agFJEPmqkeTysgbvm3NhOXGrivP1uxlGVElpW954q4ll6qG0h44pIWxMOihaJRwRRpiVoyYTsiHoSasP6cWZSAdwQBxtFwjFAQXAxVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4b2f2b8d88fso10366037b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 00:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792135969; x=1792740769;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D8SkBXaAciW9b0ju2efjjoDka8elPLR9VCB9wPB/O2o=;
        b=xqhggLicXD6Qi/rBcxYz+zDsiOTiq/Zz6XDxR3yJeuZJAF34EjAiVfAR4NkpolZU7p
         V26MfplY4ZHDLOGl/Jw2nygy948wmJsUTSGp+gs1GdKNYBpm3SiZN2ZNP/UBS0OS6wvw
         tOOnCRh07XbNhwXb9Php92DM2KDtMZQPP5hSymXrPr5cCjQn1WbXQHiDlL5pd8ZDI1Ps
         7BIeFDAgK+e84lMLp3jInnbNQf44EvGMTd15glYAs0CyUlUYyeQV8YqiZZzCYuSsQxPq
         /r0oJ6Wkwa2HjZmJx4tlweIirDNRFJzYK2YfIz3Tscdq0qqFKN8m7/NnzbZZY388ypiS
         /uBg==
X-Gm-Message-State: AFq9FYI9BnEYeGj4MDzwNrCODnoD4TxAvwz5JkVg/aoAVJyHeidql36b
	p/argmOZkenZis4CV0FWwFe3N1nUMM98ag0EPAsT/0capsqgV8OncZj9lGl79uNqSY0K0RHQTb9
	8FzOK9VDIaEF2f5zF57Ars+FHiW1t31znSo72LMBCS08urHmsCXt2QeI2Qrw=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f4b:b0:4e8:2150:2a1 with SMTP id
 5614622812f47-50c57c62debmr22950300b6e.68.1792135968946; Fri, 16 Oct 2026
 00:32:48 -0700 (PDT)
Date: Fri, 16 Oct 2026 00:32:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad1d320.a6d1a155.34a93f.0000.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in minix_rmdir (2)
From: syzbot <syzbot+8420e667af06b1709c00@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b88c841d1164 Merge tag 'input-for-v7.3-rc6' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14db50a5580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d1b274ca9837366
dashboard link: https://syzkaller.appspot.com/bug?extid=8420e667af06b1709c00
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ba149c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114291d1580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b88c841d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c64cd81f2bae/vmlinux-b88c841d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/605b0408da7b/bzImage-b88c841d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3ed2a0024dcf/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8420e667af06b1709c00@syzkaller.appspotmail.com

------------[ cut here ]------------
inode->i_nlink == 0
WARNING: fs/inode.c:408 at drop_nlink+0xc5/0x110 fs/inode.c:408, CPU#0: syz-executor/5454
Modules linked in:
CPU: 0 UID: 0 PID: 5454 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:drop_nlink+0xc5/0x110 fs/inode.c:408
Code: a8 07 00 00 be 08 00 00 00 e8 f7 68 e4 ff f0 48 ff 83 a8 07 00 00 5b 41 5c 41 5e 41 5f 5d e9 52 90 97 09 cc e8 0c e7 71 ff 90 <0f> 0b 90 eb 81 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 5b ff ff ff
RSP: 0018:ffffc900033b7d10 EFLAGS: 00010293
RAX: ffffffff82563a14 RBX: ffff8880439c30b0 RCX: ffff888013d0cb00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff917a977f R09: 1ffffffff22f52ef
R10: dffffc0000000000 R11: fffffbfff22f52f0 R12: 1ffff1100873861f
R13: dffffc0000000000 R14: ffff8880439c30f8 R15: dffffc0000000000
FS:  000055555e111500(0000) GS:ffff88808b0b4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556e57c72048 CR3: 0000000013446000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 inode_dec_link_count include/linux/fs.h:2269 [inline]
 minix_rmdir+0xfc/0x140 fs/minix/namei.c:183
 vfs_rmdir+0x3e6/0x6a0 fs/namei.c:5544
 filename_rmdir+0x292/0x520 fs/namei.c:5601
 __do_sys_unlinkat fs/namei.c:5776 [inline]
 __se_sys_unlinkat+0x71/0x1a0 fs/namei.c:5769
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f819279d2f7
Code: 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 07 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffef5481018 EFLAGS: 00000207 ORIG_RAX: 0000000000000107
RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 00007f819279d2f7
RDX: 0000000000000200 RSI: 00007ffef54821c0 RDI: 00000000ffffff9c
RBP: 00007f8192834ccb R08: 0000000000018560 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000207 R12: 00007ffef54821c0
R13: 00007f8192834ccb R14: 0000000000028576 R15: 00007ffef5484380
 </TASK>


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
