Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6672F8EBB
	for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791758782; cv=none; b=e04ITg7sEINdv6Se2elGi2i+2vuSObzTe7DCT8iDf1cauEtlTcLNYqwknalTOh5RkQD7oTmDJzhOiqZ3kBpTPzxBN7DR7h6/fhKeTCUgxY4s2Se6SybcftmiFI1H9IsgU3AquQF0hzI4UjOuDBKAZ4GPeCJOj4Absm+6wNS+Aag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791758782; c=relaxed/simple;
	bh=FJP/2wgwUV7p7dradmogy7xQ59T+IC6AfzAz4bHq48o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CzdlSZJFGGUAL9rTytDrrHxV6oP1LiibBDZmIEbYub5wB1HYnvw4jpX5+9V/L6y9VI4rXPCOVe8NUkYcH/k5yfH8WA98NGXvmDkAW2sIAaNUuhxFEbTZ6lOhYcLls4qB+sGV1lC8l5QklOCmI6Dnzmmiqv5csfrs1tVHYOnkIWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-4a24569d986so912382fac.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Oct 2026 15:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791758780; x=1792363580;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D20FPDGSgFS06e7oYFxEG6Jl8SvzQPVnUbx/KmCYwQk=;
        b=RTiaXni7bXienncuZqjgnTaTWrElHqpJ5OM1PXsdmViXnPFe2izOyX5L0+BUmXja3t
         f6iWwYDBhDhywswvwAKiH6JrRm4xl9wWK0lCA6ALusEoCHKtTzHidMq2NTyEaQZuWqF2
         Om7ZtXdkYPsNA1w3LzAYI7D9et6gvhCsKNgTfXqGHpDvqMclpXTpmsxOLugxjrNV7Hg2
         X4BQJEnfYqeYCqiT+o0RKyNEk2WMR3lJKdFvVFDzk7Hsf0Sk8UgW/Aw9V9lBiQ/0tCuh
         HdFWBXl/2lcbFdXml1XxcYU6DMAR1VaWHGkErkMpvo605q3+4Vkn3ZHRLD6PF16/iGEh
         sPJw==
X-Gm-Message-State: AFq9FYKU1b7S68FQolkGJSOwbDJ7N34gWRE+eNDcRhM8uzzIap11/3pY
	3t5pzS4bseCuTCpwm7LadK53FQM3Ow7cbjBitqvRbzpPU7h21PglL7Lu7pQHvGYEVrSKmP2vrGr
	4erijyYKJNDw6oSB1p1tRhEiV+QUhD5eMaty+4dVmfbSLZkq1ZR9rlqgoHsk=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f8d:b0:4f5:98d:d1ae with SMTP id
 5614622812f47-50c56915333mr6961736b6e.55.1791758779901; Sun, 11 Oct 2026
 15:46:19 -0700 (PDT)
Date: Sun, 11 Oct 2026 15:46:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6acc11bb.6c14cce4.1b350.08f5.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in evict (2)
From: syzbot <syzbot+d35de3666410c93fd821@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b88c841d1164 Merge tag 'input-for-v7.3-rc6' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10fc65a9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d1b274ca9837366
dashboard link: https://syzkaller.appspot.com/bug?extid=d35de3666410c93fd821
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fc65a9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1515e5d1580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-b88c841d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c64cd81f2bae/vmlinux-b88c841d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/605b0408da7b/bzImage-b88c841d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d828a19809d6/mount_10.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d35de3666410c93fd821@syzkaller.appspotmail.com

------------[ cut here ]------------
!buffer_uptodate(bh)
WARNING: fs/buffer.c:991 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:991, CPU#0: syz.0.24/5465
Modules linked in:
CPU: 0 UID: 0 PID: 5465 Comm: syz.0.24 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:991
Code: 4c 89 f7 e8 d9 d5 d7 ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 34 44 fb ff e8 8f 56 65 ff eb 8c e8 88 56 65 ff 90 <0f> 0b 90 e9 a5 fd ff ff e8 7a 56 65 ff 90 0f 0b 90 e9 cf fd ff ff
RSP: 0018:ffffc9000e15f810 EFLAGS: 00010293
RAX: ffffffff8262ca98 RBX: ffff8880146bc7e0 RCX: ffff88803bd40000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: ffffc9000e15f901 R08: ffff8880146bc7e7 R09: 1ffff110028d78fc
R10: dffffc0000000000 R11: ffffed10028d78fd R12: ffff888013cb7628
R13: 1ffff92001c2bf14 R14: ffffffff82b04fe0 R15: 0000000000000001
FS:  000055556477c500(0000) GS:ffff88808b0b4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f16fb1fe000 CR3: 0000000044d33000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 evict+0x624/0xb50 fs/inode.c:822
 add_nondir fs/minix/namei.c:18 [inline]
 minix_mknod fs/minix/namei.c:50 [inline]
 minix_create+0x88/0xb0 fs/minix/namei.c:69
 lookup_open+0xc0d/0x1a40 fs/namei.c:4596
 open_last_lookups fs/namei.c:4796 [inline]
 path_openat+0x677/0x1d60 fs/namei.c:5026
 do_file_open+0x23e/0x4a0 fs/namei.c:5058
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_creat fs/open.c:1501 [inline]
 __se_sys_creat fs/open.c:1495 [inline]
 __x64_sys_creat+0x8f/0xc0 fs/open.c:1495
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f958b39e1d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc158e2fe8 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f958b625fa0 RCX: 00007f958b39e1d9
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000200000000040
RBP: 00007f958b435888 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f958b625fac R14: 00007f958b625fa0 R15: 00007f958b625fa0
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
