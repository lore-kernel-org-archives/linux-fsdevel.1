Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEFB46AF18
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084891; cv=none; b=ZiwnnphJ1yY/jZ4e5lHLchJlFtZ5f+MR1qZ8nSwSqHYVCA1cOpvaYl9lktT4XI9lcKUpCtuk4DDA7iJGnWAHdfcbRQelS0GGvSBbOtisNzOuA8P1V5uBccDMK4Mzdn4jqJjU+sQGCtAaJgTPTHuz6o2/rR11bAoCsy7xvydr93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084891; c=relaxed/simple;
	bh=3IpUrlo62Dfpe2727IVWPo0EwIMZEWc147ANblrJSwk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l2K1xfr9LVqGX7CRIkMkRHhIKPmIRtPubvuIYHGivhXqivX85rlVa0vKbKAJlQI9roGmV7bO3iWqOYj65SDC19bSnxSrW+BDSdOlEgmLYygxcBToVWO09qJYdH0LDr3/bTby0Gc/RqMJFonwcWncP0Ef+lKe5AihuM7ML9vgZig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-4856a701421so8541599b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 13:01:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780084888; x=1780689688;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7nPRUEnRNqMa+1+PQQpjITRPLsPNU9LXJQSlKO+AT60=;
        b=ZPsZHAc0LHphPDlX3VkO/XEdYj7sTqT0JPy8FrieldZAJfBfZ1TGxYcprXfwdzorm8
         xCZe6MWDfw2fVqvDyVFXt2v5qHfn22g89VfgDzquOTO4A8Fl+ooMEMOhE+O67Aoltk/G
         DLSCHs6vMRh+C9nREWUov7Ab/is3sXIksMOv2fHOAacD/oik94gmyxIlUfnjFUoLjQwp
         m2aeGMGPSnTYfRPuiGLuB8vI3H3oesw9O1wXqxIjQ1MbmV6B76baVVf3GiQWAYBUxHOV
         yS0tkA8bsHkm9PnbvCGLTu+ZQAtr4V25+TCZGfh/th+eWf5b778SAFgCEhLaczuXbY60
         nszw==
X-Forwarded-Encrypted: i=1; AFNElJ9PEV3s6dIJ2180Oq++D+cOhery077HI3NCwdQS6/ISmLBUFDd1F9vyKhMV4euchZ2v9Ewqx1AqNxYm0XGE@vger.kernel.org
X-Gm-Message-State: AOJu0YywogoJLghyPVzqthDggHeCEX7iFP2M2ysqkef2CDGUZKpbXxvB
	7F45p3H7M2/tqtcsBNYRMlS1jir/1qDEVcFN7W5ILC/9EaZL9Es35/zYYYRCSa2dMfSc0FhqB80
	uEFY4OfaJoIntaTyzZlOGXiPSJW4rAMaCvr9h8AjxzwZ8UjYpgI+duWOb20E=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:148d:b0:482:48e1:cdf1 with SMTP id
 5614622812f47-485fb4a82ccmr557428b6e.5.1780084888142; Fri, 29 May 2026
 13:01:28 -0700 (PDT)
Date: Fri, 29 May 2026 13:01:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a19f098.abb04025.19af7b.0002.GAE@google.com>
Subject: [syzbot] [hfs?] WARNING in hfsplus_bnode_create (2)
From: syzbot <syzbot+2bf21610eea63cb2ce93@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    eb3f4b7426cf Merge tag 'nfsd-7.1-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144f912e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd38685893011045
dashboard link: https://syzkaller.appspot.com/bug?extid=2bf21610eea63cb2ce93
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109c991f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148dd97e580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82ff9dc3956e/disk-eb3f4b74.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/be01a7a564dd/vmlinux-eb3f4b74.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5d5168563228/bzImage-eb3f4b74.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a4a0cfb0b4a1/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2bf21610eea63cb2ce93@syzkaller.appspotmail.com

WARNING: The mand mount option has been deprecated and
         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
hfsplus: new node 0 already hashed?
------------[ cut here ]------------
1
WARNING: fs/hfsplus/bnode.c:634 at hfsplus_bnode_create+0x45d/0x4f0 fs/hfsplus/bnode.c:634, CPU#0: syz.0.17/5942
Modules linked in:
CPU: 0 UID: 0 PID: 5942 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:hfsplus_bnode_create+0x45d/0x4f0 fs/hfsplus/bnode.c:634
Code: 47 8b 89 ee e8 24 6f 83 fe e9 cf fc ff ff e8 da 88 20 ff 4c 89 f7 e8 92 d0 79 08 48 c7 c7 a0 52 47 8b 89 ee e8 04 6f 83 fe 90 <0f> 0b 90 49 c7 c5 ef ff ff ff eb a9 44 89 f9 80 e1 07 80 c1 03 38
RSP: 0018:ffffc90003a5f5a0 EFLAGS: 00010246
RAX: 0000000000000023 RBX: dffffc0000000000 RCX: 89c16ee503352d00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff5200074be65 R12: 0000000000000000
R13: ffff888039ca0000 R14: ffff888039ca00d0 R15: ffff88802808fc00
FS:  00005555881da500(0000) GS:ffff888126386000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000038b22000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 hfs_bnode_split+0xd2/0x1090 fs/hfsplus/brec.c:248
 hfsplus_brec_insert+0x3bc/0xd70 fs/hfsplus/brec.c:100
 hfsplus_create_cat+0xa64/0x11f0 fs/hfsplus/catalog.c:308
 hfsplus_mknod+0x186/0x3f0 fs/hfsplus/dir.c:538
 hfsplus_mkdir+0x2c/0x40 fs/hfsplus/dir.c:579
 vfs_mkdir+0x40b/0x630 fs/namei.c:5261
 filename_mkdirat+0x289/0x520 fs/namei.c:5294
 __do_sys_mkdirat fs/namei.c:5315 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5312
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efc691dbcc7
Code: 00 66 90 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff ff ff e9 db f7 ff ff 66 2e 0f 1f 84 00 00 00 00 00 90 b8 02 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd3adf41f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007ffd3adf4280 RCX: 00007efc691dbcc7
RDX: 00000000000001ff RSI: 0000200000000440 RDI: 00000000ffffff9c
RBP: 0000200000000080 R08: 0000200000000140 R09: 0000000000000000
R10: 0000200000000080 R11: 0000000000000246 R12: 0000200000000440
R13: 00007ffd3adf4240 R14: 0000000000000000 R15: 0000000000000000
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
