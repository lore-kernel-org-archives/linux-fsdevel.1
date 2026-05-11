Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914B5386425
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 07:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484572; cv=none; b=BuJiz3fqvqr5g2P4H6ThUjU0zxrr4dgUus/LLFIfZgPEmOWpN0ozpg4GFxsjBaP7x9ao6SWC0B59KwRDD7RvMa18b0wPT6wzKhjysEEHDQauzh2xtII7t0OzvRTvd9SRk7+5crzkJZE1rXVKKCocAbBX5i9ojuMZ2blrNN4NRAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484572; c=relaxed/simple;
	bh=E5C8dAUvAF6PK3tHWEWWwVfrtsNN2sP7v+XN8di0ieY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Z/bU3jA7u986EqXTRsGEJ1r346iUBdGtHRQwWrtuDEsiP8ssMvbFLZC9Sj4q3waRDV7J6SKByu3HGTZQWsj49R1RwFBDnhjGqaBe3YFyJh3ZUU1s7TKMb65SWkZlJZsAIpwpRMAOfK1AK1aZsdYHNyn3B6dQSPmT5LoVgFc8MKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-69b4f753046so1137934eaf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 00:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778484569; x=1779089369;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrSzxj794BQXYltWHMaeU7bNnVUTfnI0zgOGBibu8Js=;
        b=QhBKviVpWDUQgMD0GeEfZLZgD25bQSgmLoxh7OSHGFApaYG36LfYmhvOEa86G6hh4g
         iHXt1bE9hz8932wr0HPnLY6xo3iVP5DLrwX7PR7JgjpC9Oxhmo1GesqBXfEXNZ0afH+k
         upQMwdj3FTUwfJum4ivHzlxLIXbwzAITBXsbdH5IOSTWAOb3xUOJ8pkTiIhcUxH1Ba1X
         MBCzhg5wAdvQf3qvPSvvrgE3EYvb19yadttEFepUdAM7f5ggRIoHGhPaPF831aSN0Nu+
         tlxiCHI8M0C0yc6czKRml8Vm7cACKeffgAe30e8aWBTNU2VMDYSarK/0q57F4O9DCQb4
         53Tw==
X-Forwarded-Encrypted: i=1; AFNElJ8GLNzZ1gD8tyUPx+IYMNZw15AQegaCGAL8lEQhVkcKyQHXTrgE5J1y+eslNcwP2uqgaczynWFHRJPiM2bo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/BXWnj6T7aH+IgVK1vAcsJt4PSQW/gwnp49BAf540iAD+A4fI
	fzlAecIWV1kbzDGn4BFWNLq7ZI1GET/Gu8q7TG+7w97ZnqAsupSTY1K+L/y1XwzqpRWU9F0Q770
	osgXxVFNwEdgzlP47MkY1hM3mLLvtJ4XVdDOF19Pl4V27zcw3bF2s0x19934=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:7510:b0:69b:545b:a182 with SMTP id
 006d021491bc7-69b545ba243mr984468eaf.32.1778484569442; Mon, 11 May 2026
 00:29:29 -0700 (PDT)
Date: Mon, 11 May 2026 00:29:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a018559.170a0220.286ecb.0000.GAE@google.com>
Subject: [syzbot] [exfat?] WARNING in fat_add_entries
From: syzbot <syzbot+872e83c344f0ae2cf617@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    adc1e5c6203c Merge tag 'efi-fixes-for-v7.1-1' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14b4bb26580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f195f6be48c12ec
dashboard link: https://syzkaller.appspot.com/bug?extid=872e83c344f0ae2cf617
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-adc1e5c6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f67d79b10054/vmlinux-adc1e5c6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f9dcdab6fabb/bzImage-adc1e5c6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+872e83c344f0ae2cf617@syzkaller.appspotmail.com

loop0: detected capacity change from 128 to 0
FAT-fs (loop0): Directory bread(block 40) failed
FAT-fs (loop0): Directory bread(block 40) failed
------------[ cut here ]------------
!buffer_uptodate(bh)
WARNING: fs/buffer.c:1087 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:1087, CPU#0: syz.0.0/5323
Modules linked in:
CPU: 0 UID: 0 PID: 5323 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:1087
Code: 4c 89 f7 e8 89 5d da ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 b4 63 fb ff e8 ef 93 6d ff eb 8c e8 e8 93 6d ff 90 <0f> 0b 90 e9 a5 fd ff ff e8 da 93 6d ff 90 0f 0b 90 e9 cf fd ff ff
RSP: 0018:ffffc900057df208 EFLAGS: 00010287
RAX: ffffffff82583af8 RBX: ffff888046d92000 RCX: 0000000000100000
RDX: ffffc90020802000 RSI: 00000000000029e1 RDI: 00000000000029e2
RBP: ffffc900057df401 R08: ffff888046d92007 R09: 1ffff11008db2400
R10: dffffc0000000000 R11: ffffed1008db2401 R12: dffffc0000000000
R13: 00000000000002a0 R14: dffffc0000000000 R15: ffff888046e3ba50
FS:  00007f247469b6c0(0000) GS:ffff88808c885000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f247469aff8 CR3: 0000000039246000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 mmb_mark_buffer_dirty+0x2f/0x200 fs/buffer.c:719
 fat_add_entries+0x799/0x2320 fs/fat/dir.c:1362
 vfat_add_entry+0x2def/0x3580 fs/fat/namei_vfat.c:675
 vfat_create+0x148/0x270 fs/fat/namei_vfat.c:769
 lookup_open fs/namei.c:4511 [inline]
 open_last_lookups fs/namei.c:4611 [inline]
 path_openat+0x1395/0x3860 fs/namei.c:4855
 do_file_open+0x23e/0x4a0 fs/namei.c:4887
 do_sys_openat2+0x113/0x200 fs/open.c:1364
 do_sys_open fs/open.c:1370 [inline]
 __do_sys_creat fs/open.c:1448 [inline]
 __se_sys_creat fs/open.c:1442 [inline]
 __x64_sys_creat+0x8f/0xc0 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f247379cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f247469afe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f2473a16090 RCX: 00007f247379cdd9
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 0000200000000e00
RBP: 00007f2473832d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2473a16128 R14: 00007f2473a16090 R15: 00007ffd5e53e4e8
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
