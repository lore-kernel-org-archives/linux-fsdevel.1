Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C03235DD1C
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Aug 2026 00:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785544464; cv=none; b=XJv39ZR/dMR7avn2+jL1nk5L01xvh/UJljfMWAJhhdLSQ1AopJR+gFBuBIGWyWvZQllbWg3jdWUrfrA6DnM3D/fQGwR7bWhkrLQBXjqSw95xpKGCvJwxrJVZ/bFTUkawO+Qs5naiW7tWo6bEFF/g7LUL5DNaJGaAWZ+oXIVwSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785544464; c=relaxed/simple;
	bh=Hwpw4FRMo4T82VUXaNU7MMOxiB0WKOAby76IXxWyNVs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Hpx0tW/5NU5G3awYt0rupTQ7rZIOkX1ybV4EDWJX7a5VQ+Ja08lFh7RmbsIbFlyIVeEVaMa3ZX56g5oA9xz65awgIUIKe/bVHfYF73ucnVAYOZRRlhqcPU5hrZl8Qn4XJ7oduc70k8aj5NAVdUDzVpa54PllLGeD1rymVm10Pk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-49aa4525b82so1950392b6e.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 17:34:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785544462; x=1786149262;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ddi5Ns4QPmx8AFfs9ckJ3u7R/GPPNXBiqa2+ZdsS90M=;
        b=cojLfWeHC8FOYIKRwQwy4foUU5ZWxzCRgQOOMFaySbQ6E0qAekwIUY584j2RzI99Se
         fcRq+5rHSpA4vySsknARYqkFLkpIeH2p92ZLiKMgzvOGx/rejbkDlu/pVjfjU7YKFwUs
         KnH2aaXrSW9QyYm9ohPDZpjhvLu8rrpxRoyvcD5oKyL2irsLl/cJSTXNhhXCChlSmugj
         82YQTA2/dmOFMDK3qMx41e8DrivVqyFlXXALBhXSpS7KMYWgXCGzC7fzgKA/WIe2TxT3
         Obth5pYA5PK1Nteyk0AvhIjm0gDdE7iEInkikgtlVdVwWvcEC8W/P1V/5kcAXLos7Jb3
         /f3w==
X-Forwarded-Encrypted: i=1; AHgh+RrPU6OhtWzicWx2rNLjWUqiE7GGj52PmMUzz6TQsoiCkxu68DFzn49ZkVMZ4e4pYYEuEDq2kSGtja7scUdX@vger.kernel.org
X-Gm-Message-State: AOJu0YxeoAwIWXMKdTPQuY/Vq/dw/x208fQy5b07idPkOi5bFyPzjeME
	kFGaCRQnp5KGprJQV3qte3M06o8QJyfFqul177sU2Nr4/C3jVmywWl00yG28dWpFYfDGCL3uGsg
	iU7XIP33EIrYt8DWAPZXxOjX+c+03c2i4Q+li2m1UIRAuW0gOeFe0E4pZSWY=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:bcd:b0:497:8f1:df07 with SMTP id
 5614622812f47-4af5e0583c4mr4388585b6e.7.1785544462058; Fri, 31 Jul 2026
 17:34:22 -0700 (PDT)
Date: Fri, 31 Jul 2026 17:34:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6d3f0e.f794c993.27aeb.000a.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in configfs_symlink
From: syzbot <syzbot+608f7f2a86361e18ba0b@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3b5f4b83c4ab Merge tag 'for-7.2-rc5-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139672a9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=608f7f2a86361e18ba0b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1431c561580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=102ae401580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3b5f4b83.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ed6d6b480fd7/vmlinux-3b5f4b83.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d5a591a74024/bzImage-3b5f4b83.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+608f7f2a86361e18ba0b@syzkaller.appspotmail.com

------------[ cut here ]------------
!atomic_read(&sd->s_count)
WARNING: fs/configfs/configfs_internal.h:146 at configfs_get fs/configfs/configfs_internal.h:146 [inline], CPU#0: syz.2.1991/9996
WARNING: fs/configfs/configfs_internal.h:146 at create_link fs/configfs/symlink.c:92 [inline], CPU#0: syz.2.1991/9996
WARNING: fs/configfs/configfs_internal.h:146 at configfs_symlink+0xdd4/0x11f0 fs/configfs/symlink.c:199, CPU#0: syz.2.1991/9996
Modules linked in:
CPU: 0 UID: 0 PID: 9996 Comm: syz.2.1991 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:configfs_get fs/configfs/configfs_internal.h:146 [inline]
RIP: 0010:create_link fs/configfs/symlink.c:92 [inline]
RIP: 0010:configfs_symlink+0xdd4/0x11f0 fs/configfs/symlink.c:199
Code: 48 c1 e8 03 80 3c 10 00 0f 85 63 03 00 00 48 8b 74 24 18 48 8b 3d 8c 26 bb 18 e8 97 6e ad ff e9 4f fe ff ff e8 dd df 48 ff 90 <0f> 0b 90 e9 a6 f8 ff ff e8 cf df 48 ff 48 c7 c7 40 49 eb 8e e8 a3
RSP: 0018:ffffc900020bfcc8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888039383be8 RCX: ffffffff82c1790a
RDX: ffff888034e38000 RSI: ffffffff82c18063 RDI: ffff888034e38000
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888046851c80
R13: ffff888046851d58 R14: ffff88802bdacc80 R15: ffff888058814000
FS:  00007fbd7c4276c0(0000) GS:ffff8880d5ddc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbd7c426ff8 CR3: 000000002d0d2000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 vfs_symlink fs/namei.c:5660 [inline]
 vfs_symlink+0x178/0x4d0 fs/namei.c:5639
 filename_symlinkat+0x2a6/0x560 fs/namei.c:5685
 __do_sys_symlinkat fs/namei.c:5705 [inline]
 __se_sys_symlinkat fs/namei.c:5700 [inline]
 __x64_sys_symlinkat+0x9c/0xe0 fs/namei.c:5700
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbd7b59de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbd7c427028 EFLAGS: 00000246 ORIG_RAX: 000000000000010a
RAX: ffffffffffffffda RBX: 00007fbd7b825fa0 RCX: 00007fbd7b59de99
RDX: 0000200000000340 RSI: ffffffffffffff9c RDI: 0000200000000300
RBP: 00007fbd7b633eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbd7b826038 R14: 00007fbd7b825fa0 R15: 00007fff25ff7358
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
