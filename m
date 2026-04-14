Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E2F358367
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 23:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776208850; cv=none; b=XD4poPxMGv+43WvsVl4GKlFNNujClEvQ3ntXU/c4etU2ztRdJFu8Ioc2p/QvUEiVH7JJDbaGuRf5BmE36z7KNCCjaFFECeEmiF988punwtczBH1pN2W5kB+B7UVXwMXdQrTt/4NtZVz7UVu4M5txoGm71ezPcSEngMyg+IVf87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776208850; c=relaxed/simple;
	bh=NY2uLHN8SidzwT+5WuVcjmzJWb88q9PiKVr5fd0Sfi4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QBQ11Smja7NKM49XuMKG6qr1tH9zWZODZk4RON4E1V53WZFlXZnjwPjJwqgZTgjbPia5YGK3B45gY0suxrk+76iyAvw4R0aVqE4c0KIRsi8698LquyfwyOIogbGlJc2Il5q2ECIqkakDPKgR/b4keu5hnFukPrABZwiw1ilqX5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-40a4d2264abso12176416fac.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 16:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776208847; x=1776813647;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TXGIJMGbwoMOQTyKqYXmmRKhfwZTsunbcz9va/m6wTY=;
        b=jC3f8jpFsIvLZmIGvYMW83v1TdzfigaG4rXjG5wC8DqrFlyh6iiEuTFMRQg97ySpEV
         Z6k1uCf0JsAW1umPyA9IytNFfD5PnHdVJaTBJ7pRp1VW/eRsRYv2bHCVw/u0hd0PEt0H
         mCFTK9nZ4EUr9blEbCIvZbUTmV7DYVXp3meuBDQK3vKAzHka49v9pWTnPJrVaOiFfS0a
         /YIqkWcxdvn7hf+p0C5SV0rIEL4teoVnx8VBJs3EeSVWyCozJ+RDpqAPv4KS32PzRxoj
         iN3WU6wrWjkUvFmjmNRiak2s2EMxhm2TwWeIhhyZ+xzkwyNECCJZBixvbEbN94Xp/4+c
         l7Jg==
X-Forwarded-Encrypted: i=1; AFNElJ9RHltXqQQgCZmLtopPlde3gY42Fgjv83tyrFnE3YQaxRc30Fsdt6Ql6//BxnAe7igVrQFcWc9Qglu1IK5s@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7OEwIwzqClI46KJ15PpoqAvl0Yy7Op4irF37/qX1+NcMsUd12
	pJc1pzgiMoNBCx47BsDWbq9eGcfnrlj2ia1AqZfcl4TWxxfSVaeKvh6PnDz8e3t8nCA3pNCLRIz
	mF9FCjyop4OQAz0VJ5p3om6YOzgrtb/tmNaaYZPQpi4gF8lb0ntWxpotSzto=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:a289:20b0:68a:1294:c9 with SMTP id
 006d021491bc7-68be8be18bcmr7021691eaf.62.1776208847640; Tue, 14 Apr 2026
 16:20:47 -0700 (PDT)
Date: Tue, 14 Apr 2026 16:20:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69decbcf.a00a0220.468cb.0069.GAE@google.com>
Subject: [syzbot] [hfs?] general protection fault in __hfsplus_setxattr
From: syzbot <syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d60bc1401583 Merge tag 'pwrseq-updates-for-v7.1-rc1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1605b036580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85bd86f990609a1
dashboard link: https://syzkaller.appspot.com/bug?extid=bc70a12e438dadba4fb4
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143efeba580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1769e8ce580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c962a506ef36/disk-d60bc140.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8590a2666b51/vmlinux-d60bc140.xz
kernel image: https://storage.googleapis.com/syzbot-assets/75aa1f8fc11f/bzImage-d60bc140.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e3cd44efac38/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 1 UID: 0 PID: 5977 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
RIP: 0010:hfsplus_create_attributes_file fs/hfsplus/xattr.c:320 [inline]
RIP: 0010:__hfsplus_setxattr+0x1c68/0x2860 fs/hfsplus/xattr.c:432
Code: 8b 36 49 83 c6 30 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 46 f8 80 ff 4d 8b 36 49 83 c6 08 4c 89 f0 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 f7 e8 29 f8 80 ff 4d 8b 36 49 8d 7e 90
RSP: 0018:ffffc90002f37420 EFLAGS: 00010212
RAX: 0000000000000001 RBX: fffff520005e6ea4 RCX: ffff88802f39db80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002f378f8 R08: ffffea00017e23f7 R09: 1ffffd40002fc47e
R10: dffffc0000000000 R11: fffff940002fc47f R12: dffffc0000000000
R13: ffff88802bb42a30 R14: 0000000000000008 R15: ffff88802bb43740
FS:  000055555c219500(0000) GS:ffff88812554b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f407bb7b000 CR3: 0000000077cf5000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 hfsplus_setxattr+0x124/0x340 fs/hfsplus/xattr.c:555
 hfsplus_trusted_setxattr+0x40/0x60 fs/hfsplus/xattr_trusted.c:30
 __vfs_setxattr+0x43c/0x480 fs/xattr.c:218
 __vfs_setxattr_noperm+0x12d/0x660 fs/xattr.c:252
 vfs_setxattr+0x163/0x360 fs/xattr.c:339
 do_setxattr fs/xattr.c:654 [inline]
 filename_setxattr+0x296/0x630 fs/xattr.c:682
 path_setxattrat+0x3eb/0x440 fs/xattr.c:726
 __do_sys_setxattr fs/xattr.c:760 [inline]
 __se_sys_setxattr fs/xattr.c:756 [inline]
 __x64_sys_setxattr+0xbc/0xe0 fs/xattr.c:756
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcafdf9c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd135f08f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007fcafe215fa0 RCX: 00007fcafdf9c819
RDX: 0000200000001400 RSI: 00002000000001c0 RDI: 0000200000000380
RBP: 00007fcafe032c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000835 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fcafe215fac R14: 00007fcafe215fa0 R15: 00007fcafe215fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfsplus_create_attributes_file fs/hfsplus/xattr.c:320 [inline]
RIP: 0010:__hfsplus_setxattr+0x1c68/0x2860 fs/hfsplus/xattr.c:432
Code: 8b 36 49 83 c6 30 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 46 f8 80 ff 4d 8b 36 49 83 c6 08 4c 89 f0 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 f7 e8 29 f8 80 ff 4d 8b 36 49 8d 7e 90
RSP: 0018:ffffc90002f37420 EFLAGS: 00010212
RAX: 0000000000000001 RBX: fffff520005e6ea4 RCX: ffff88802f39db80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90002f378f8 R08: ffffea00017e23f7 R09: 1ffffd40002fc47e
R10: dffffc0000000000 R11: fffff940002fc47f R12: dffffc0000000000
R13: ffff88802bb42a30 R14: 0000000000000008 R15: ffff88802bb43740
FS:  000055555c219500(0000) GS:ffff88812544b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562d49fd15e0 CR3: 0000000077cf5000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	8b 36                	mov    (%rsi),%esi
   2:	49 83 c6 30          	add    $0x30,%r14
   6:	4c 89 f0             	mov    %r14,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  12:	74 08                	je     0x1c
  14:	4c 89 f7             	mov    %r14,%rdi
  17:	e8 46 f8 80 ff       	call   0xff80f862
  1c:	4d 8b 36             	mov    (%r14),%r14
  1f:	49 83 c6 08          	add    $0x8,%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 29 f8 80 ff       	call   0xff80f862
  39:	4d 8b 36             	mov    (%r14),%r14
  3c:	49 8d 7e 90          	lea    -0x70(%r14),%rdi


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
