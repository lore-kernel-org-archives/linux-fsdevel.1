Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD13783BB
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791751824; cv=none; b=YxtHOfR53SIUP08qHXOEK6/TwW1Zd4XNJPPvhSHLPjJUOBBWOZouXWzllReWlMzI6HaHwMC3wPhuuXZEXi5u4tRtulHhjQvRjY+k/rfXfzFVNdvWBaAt6tn383/xwo10JUASdYg57Tuu21YeRDmZbCfv48+neCtig/kxJxJzJBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791751824; c=relaxed/simple;
	bh=VOMUI7EGgh3ylAYuYLulNkmJ/7OfDzhyWa0Rz4EZ8Qg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Y8exPr1tJ3vW9i5t4V/X+2JsRy+ePSSFIJdGu6zC2Ai0sBJm++6dsJQPvvcLqDDgzmIQchyCU+XbHjvZBM3xgYSh8Bo96KGCp3KOG7+Ei/gRyx25UFJJZ5zRCw58rjgschn/xRLXLvE3tSkSbJDAV939+e0zth6U/WgjKeVSqck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4ab260600easo4825471b6e.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 13:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791751822; x=1792356622;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vkFr1A6iIW6UxVEf74UCASeA3APYa9ah9qSVFDORK9U=;
        b=WKx5TIQyafncxP5x5NXHYKlLEudSxfbQKIF80s4WB93AWpuMsOqv6a4zfzwQMNIJnc
         MAwYMbvhf6t8/65Ea5fiZquWOsSQUlYaJ///piDyahaC8lS+5AtrqM219piqveSXF15y
         PTHSJqkslth2Dqz2jtmgFcJzI/zjVZOPuXzrwLw+qqq0IzFWfAHvYLdiQGTGgz519gRr
         xxZ48cTUaZbpQBbvqDJVDpE5Mrfktc4fQ0xAeMyjVGn0UvmXEBdQOLUv5Jwizq0yATo/
         7mcDea4qjnZ2UeVBCHzwEYSrK4hkEbR/wPE3FusYg7n/gOsk9koWGp/mX4IoksmcFUiB
         Pk5w==
X-Gm-Message-State: AFq9FYJ3zJHNqLIZBAG+5f5/2qhmyxdmK4oTFOTsrop1qwuwIF2UmLyv
	ZXurmYMn26Bl/04IwK9MxSRTYyYeatBY0kUx8+/EBcKLgJhIWKtGCdu//oQ9jF3ZcNVrggueGhW
	XHtVpTlXyJQLiO36UDPLd+CuRgGlCzNkVSc5TXyC4CDLPF0hqSQOdFUrjk4Q=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:e84:b0:4d6:9133:cfde with SMTP id
 5614622812f47-50b657ec2famr5832006b6e.35.1791751822133; Sun, 11 Oct 2026
 13:50:22 -0700 (PDT)
Date: Sun, 11 Oct 2026 13:50:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6acbf68e.6d14cce4.2677ed.016a.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in minix_put_super
From: syzbot <syzbot+bffc332f376fdab5cef0@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b88c841d1164 Merge tag 'input-for-v7.3-rc6' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12adc5d1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d1b274ca9837366
dashboard link: https://syzkaller.appspot.com/bug?extid=bffc332f376fdab5cef0
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fbc1d1580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b88c841d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c64cd81f2bae/vmlinux-b88c841d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/605b0408da7b/bzImage-b88c841d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/adc9f1a572c3/mount_10.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bffc332f376fdab5cef0@syzkaller.appspotmail.com

------------[ cut here ]------------
!buffer_uptodate(bh)
WARNING: fs/buffer.c:991 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:991, CPU#0: syz-executor/5457
Modules linked in:
CPU: 0 UID: 0 PID: 5457 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:991
Code: 4c 89 f7 e8 d9 d5 d7 ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 34 44 fb ff e8 8f 56 65 ff eb 8c e8 88 56 65 ff 90 <0f> 0b 90 e9 a5 fd ff ff e8 7a 56 65 ff 90 0f 0b 90 e9 cf fd ff ff
RSP: 0018:ffffc9000e597c90 EFLAGS: 00010293
RAX: ffffffff8262ca98 RBX: ffff8880468d50e0 RCX: ffff888036f5cb00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 0000000000000001 R08: ffff8880468d50e7 R09: 1ffff11008d1aa1c
R10: dffffc0000000000 R11: ffffed1008d1aa1d R12: 1ffff1100af668cf
R13: ffff888041a50580 R14: ffff888057b34678 R15: ffff888041a505c8
FS:  000055557bc8e500(0000) GS:ffff88808b0b4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f34db7ef158 CR3: 0000000014819000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 minix_put_super+0x16d/0x460 fs/minix/inode.c:70
 generic_shutdown_super+0x13d/0x2d0 fs/super.c:751
 kill_block_super+0x44/0xa0 fs/super.c:1903
 deactivate_locked_super+0xbe/0x110 fs/super.c:586
 cleanup_mnt+0x204/0x2a0 fs/namespace.c:1392
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x204/0x770 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
 do_syscall_64+0x328/0x520 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4096b9f417
Code: a2 c7 05 dc 62 25 00 00 00 00 00 eb 96 e8 e1 12 00 00 90 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 e8 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007ffeab55db28 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007f4096c34ccb RCX: 00007f4096b9f417
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 00007ffeab55dbe0
RBP: 00007ffeab55dbe0 R08: 00007ffeab55ebe0 R09: 00000000ffffffff
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeab55ec70
R13: 00007f4096c34ccb R14: 000000000003a52d R15: 00007ffeab55ecb0
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
