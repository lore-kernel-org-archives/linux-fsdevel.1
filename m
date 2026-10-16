Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9017425B0BD
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 00:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110149; cv=none; b=tnn45RnuSooFPx9MHTipT6WHRe3j4l460yT6+xZ6G9x6Dv7n/LIAxkdD/1uvDOgK14K3xVTrYpJMK39GyL9uDb5Q7XYrVVF8ZYb2TCBolrNsyTz0op4yfnY3R70ffwYtSaTdWu/ZoOa4wR+ZIT91zTIxI0k3SkOT90KpCOndhms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110149; c=relaxed/simple;
	bh=vtukoT/IVvUoyOeSXGYXiBdEdEU8VVbif8eyTKnzLLM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JMYhj8+IzoTeVCMqKLAm7TdFEh+5uh+7cUZMijNvUWdRF6TMkGjxl5BGVutPdCp8vGeaAAjUsSmm07O4EoLxjBMMl/T3yThiHu2W7rJs+vnvVm1gg7UzYZhMXUCj5Qh5jB/m5Lm5NW4xygP9WyED3R5vgWlsutOx9mzPOhfNbCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4fb73e868aaso8444848b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 17:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792110147; x=1792714947;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z7Xg/RJKdIEXw8q8/kyiWA1ldTx+K5OVKImU2864UHM=;
        b=qNVPDgb9M7EEoDim9lynJ3OZ62ajnV8D4FcfrsKC1s/Offbv0NynlkdGPEsift7eQY
         CTVsKVpPHTgTy3uEvr2vbT65Q2PH+hiXaxKkZQKXOvKhp65WoZVz77HdJI3BaD+GKzJu
         XW8oYwctODW66eyMCdJfYcL4wNE71ZPB7Wuv1cecoLOt0xxw4BQpckZllxfjtReNpKCg
         2xIHqJAeRIB9Q4/7qw5k+wsMKkrHyq289rhC5Wd8e09057Trwldcc9cIOfbikaC5mrHj
         krHyvouoLZn3XTIW8A02qPjYj/dlWoK6Jh7xx3QnLNo3t4Ximy5kVIp3F8GkvbgyzdER
         t0ng==
X-Gm-Message-State: AFq9FYKQZbzl0zwZqnZWJrVQ+jFO9kuBzOIK9nUaSSgCAXhFc2iXuH0E
	7nJtAeRi7xHvQ4GY4ZoquLPFbf8OCedgcpMxQcA0RTHszoeCo0YAi5tz7HHi9fceIiDYpzbyITQ
	hsLkqImG4xdOaWS/nZVJphKHzbZz3STP1CJIncQrUf9jOA/5cwgBe9EXmXyo=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:bc2:b0:4e7:d54b:1208 with SMTP id
 5614622812f47-50c532f48a4mr19402208b6e.15.1792110147325; Thu, 15 Oct 2026
 17:22:27 -0700 (PDT)
Date: Thu, 15 Oct 2026 17:22:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad16e43.7514cce4.1ece07.010d.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in V1_minix_truncate (2)
From: syzbot <syzbot+e353ad4408c4f9fac965@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b88c841d1164 Merge tag 'input-for-v7.3-rc6' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1043540d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d1b274ca9837366
dashboard link: https://syzkaller.appspot.com/bug?extid=e353ad4408c4f9fac965
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1280a9c9580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b88c841d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c64cd81f2bae/vmlinux-b88c841d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/605b0408da7b/bzImage-b88c841d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bf4cfcb2c7e6/mount_13.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e353ad4408c4f9fac965@syzkaller.appspotmail.com

IO error syncing minix inode [loop0:00000008]
------------[ cut here ]------------
!buffer_uptodate(bh)
WARNING: fs/buffer.c:991 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:991, CPU#0: syz.0.182/5880
Modules linked in:
CPU: 0 UID: 0 PID: 5880 Comm: syz.0.182 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:991
Code: 4c 89 f7 e8 d9 d5 d7 ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 34 44 fb ff e8 8f 56 65 ff eb 8c e8 88 56 65 ff 90 <0f> 0b 90 e9 a5 fd ff ff e8 7a 56 65 ff 90 0f 0b 90 e9 cf fd ff ff
RSP: 0018:ffffc90004a979f0 EFLAGS: 00010293
RAX: ffffffff8262ca98 RBX: ffff8880459b49a0 RCX: ffff888034650000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: ffffc90004a97b01 R08: ffff8880459b49a7 R09: 1ffff11008b36934
R10: dffffc0000000000 R11: ffffed1008b36935 R12: ffff88800bf46596
R13: ffff88800bf46620 R14: ffff88800bf46588 R15: 0000000000000017
FS:  00007ff0885f46c0(0000) GS:ffff88808b0b4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f24c7d6a000 CR3: 000000001d368000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 free_data fs/minix/itree_common.c:272 [inline]
 truncate fs/minix/itree_common.c:321 [inline]
 V1_minix_truncate+0x310/0x10c0 fs/minix/itree_v1.c:61
 minix_truncate fs/minix/inode.c:750 [inline]
 minix_evict_inode+0x1c9/0x260 fs/minix/inode.c:52
 evict+0x624/0xb50 fs/inode.c:822
 minix_mkdir+0xdc/0x120 fs/minix/namei.c:136
 vfs_mkdir+0x40c/0x620 fs/namei.c:5439
 filename_mkdirat+0x285/0x510 fs/namei.c:5472
 __do_sys_mkdirat fs/namei.c:5493 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5490
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff08779e1d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff0885f4028 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007ff087a25fa0 RCX: 00007ff08779e1d9
RDX: 00000000000001c0 RSI: 0000200000000700 RDI: ffffffffffffff9c
RBP: 00007ff087835888 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff087a26038 R14: 00007ff087a25fa0 R15: 00007fff1b9cc468
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
