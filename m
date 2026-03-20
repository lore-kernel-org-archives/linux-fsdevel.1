Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0130435F176
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774046731; cv=none; b=WJUbVikzIO3s4LwjEuRk7agF6D8E0vPkY1xnRKQU4mo9Q3zzUxeTqcEYdQfgHWn7y75PXlAQQcDmnadq6iSa2fIS+Ev+TtJObF0GTS53BptpvPGX2zO6SGVKpVwFl+YDFrSJw7EN21MLS9smDg/DJkpNiH2Zp99DEBltZaiebLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774046731; c=relaxed/simple;
	bh=a2n4pSBqcR34c6G9cUVfmgqIMwOzvDup0ASey2sbvUQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AOz5ntQ9awmEhbH94liCExqFjyMUPTu10mzGc1RdW5qWKKq79SQLaMdS+In1jP/RYPbYOFx9TIsqlpm7tCOpKAuU/MUQHQ65VMKkjPbdSClqHfF+3rzHRfEgbTBtXBGsn4lYY7wfXwv1YTENQO70P0on3DRpJZyVv0SsMg335CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7d7e660f1e2so18743309a34.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 15:45:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774046729; x=1774651529;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZAtC2lhbG2YZSINlOyiGuI6fYnHaFTjqBNqsFUizz1c=;
        b=ZiSYbTQMR4fVhVdq5RevynJg/6v4t+to3kdBoxnwmFMP1v4Js+NBZhr7ywVB1Pfudm
         YHDTACLZoro6rSOAuIYjFfyU9HGZSyvjazWcEn7mGwd4IHKq5NpqdJLpTVL/3Gk/Im8Z
         fQ3r5yV3aia7lbs+GaPStN241M9X+KG/qVXC+mbJSTIMsme5aRHvEJPUcV40/cGU8aea
         Q5a0nr51HxHgFn4UGIezvKKwx+64ANPyFeDzjoDDe/HvPeV/fHNhgg/cHAUtj7zFbIva
         x7x9r/WbEx4bi6gnStXVcG35BlEZ3z0rv6STKZGSkgMBRaEMoH11gc1Rgxxhiz2UfOy+
         TyKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqHj10MZhujoNkrGm6ADfGGFcLsZ9xQ6EGmOTjW1JmsTwHOmMHE+/ICtxcmjVW3wsWjHVUbNT6gS9eFqxS@vger.kernel.org
X-Gm-Message-State: AOJu0YyZTZ3vhcst7N7NWFutfJhKmwj3MvV8x5o5vlxFsT2qEzqpOqpo
	2chsB24XOJbUl9AIWDGq8NRyZ1ir6ajDCJytwLflJlTzXOE4RnMPg3GgAmm/xawp4KDpujMyexo
	rQKG3KPBpYvzPOwZiwSFAq1cS2H2xhcABw4R7DfU6OlPHKre8l5d6KyQreKg=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1389:b0:67b:f0ed:7fcd with SMTP id
 006d021491bc7-67c231260c9mr3504098eaf.70.1774046729007; Fri, 20 Mar 2026
 15:45:29 -0700 (PDT)
Date: Fri, 20 Mar 2026 15:45:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69bdce08.050a0220.3bf4de.0031.GAE@google.com>
Subject: [syzbot] [fs?] general protection fault in __umount_mnt
From: syzbot <syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8e42d2514a7e Add linux-next specific files for 20260318
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10808cba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f5b21566f9d8af6
dashboard link: https://syzkaller.appspot.com/bug?extid=e4470cc28308f2081ec8
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16eb72da580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cb90c31a24db/disk-8e42d251.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e0c08a5de437/vmlinux-8e42d251.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d6b18a5e03f8/bzImage-8e42d251.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e4470cc28308f2081ec8@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xfbd59c0000000024: 0000 [#1] SMP KASAN PTI
KASAN: maybe wild-memory-access in range [0xdead000000000120-0xdead000000000127]
CPU: 1 UID: 0 PID: 15793 Comm: syz.3.4827 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:__hlist_del include/linux/list.h:992 [inline]
RIP: 0010:hlist_del_init include/linux/list.h:1020 [inline]
RIP: 0010:__umount_mnt+0x24e/0x490 fs/namespace.c:997
Code: 85 e4 74 61 4d 8d be f8 00 00 00 4c 89 f8 48 c1 e8 03 80 3c 28 00 74 08 4c 89 ff e8 fc 33 e3 ff 4d 8b 2f 4c 89 e0 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 e7 e8 d4 34 e3 ff 4d 89 2c 24 4d 85 ed 74
RSP: 0018:ffffc90003297a40 EFLAGS: 00010a06
RAX: 1bd5a00000000024 RBX: ffff8880338796c8 RCX: ffff888029f08000
RDX: 0000000000000000 RSI: ffffffff8e8d9060 RDI: ffff888033879738
RBP: dffffc0000000000 R08: ffffffff90122ff7 R09: 1ffffffff20245fe
R10: dffffc0000000000 R11: fffffbfff20245ff R12: dead000000000122
R13: dead000000000100 R14: ffff8880338796c0 R15: ffff8880338797b8
FS:  0000555561679500(0000) GS:ffff888125536000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0ebc84eddd CR3: 00000000791b8000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 umount_mnt fs/namespace.c:1008 [inline]
 umount_tree+0x925/0xd90 fs/namespace.c:1819
 put_mnt_ns+0x1d6/0x2f0 fs/namespace.c:6264
 evict+0x61e/0xb10 fs/inode.c:846
 __dentry_kill+0x1a2/0x5e0 fs/dcache.c:670
 finish_dput+0xc9/0x480 fs/dcache.c:879
 __fput+0x697/0x8c0 fs/file_table.c:508
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0xed/0x480 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:238 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:269 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:325 [inline]
 do_syscall_64+0x32d/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f14bbb9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd2857c408 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f14bbe17da0 RCX: 00007f14bbb9c799
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f14bbe17da0 R08: 00007f14bbe16038 R09: 0000000000000000
R10: 000000000003fdc0 R11: 0000000000000246 R12: 0000000000033731
R13: 00007f14bbe1609c R14: 000000000003345d R15: 00007f14bbe16090
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__hlist_del include/linux/list.h:992 [inline]
RIP: 0010:hlist_del_init include/linux/list.h:1020 [inline]
RIP: 0010:__umount_mnt+0x24e/0x490 fs/namespace.c:997
Code: 85 e4 74 61 4d 8d be f8 00 00 00 4c 89 f8 48 c1 e8 03 80 3c 28 00 74 08 4c 89 ff e8 fc 33 e3 ff 4d 8b 2f 4c 89 e0 48 c1 e8 03 <80> 3c 28 00 74 08 4c 89 e7 e8 d4 34 e3 ff 4d 89 2c 24 4d 85 ed 74
RSP: 0018:ffffc90003297a40 EFLAGS: 00010a06
RAX: 1bd5a00000000024 RBX: ffff8880338796c8 RCX: ffff888029f08000
RDX: 0000000000000000 RSI: ffffffff8e8d9060 RDI: ffff888033879738
RBP: dffffc0000000000 R08: ffffffff90122ff7 R09: 1ffffffff20245fe
R10: dffffc0000000000 R11: fffffbfff20245ff R12: dead000000000122
R13: dead000000000100 R14: ffff8880338796c0 R15: ffff8880338797b8
FS:  0000555561679500(0000) GS:ffff888125536000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f0ebc84eddd CR3: 00000000791b8000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	85 e4                	test   %esp,%esp
   2:	74 61                	je     0x65
   4:	4d 8d be f8 00 00 00 	lea    0xf8(%r14),%r15
   b:	4c 89 f8             	mov    %r15,%rax
   e:	48 c1 e8 03          	shr    $0x3,%rax
  12:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1)
  16:	74 08                	je     0x20
  18:	4c 89 ff             	mov    %r15,%rdi
  1b:	e8 fc 33 e3 ff       	call   0xffe3341c
  20:	4d 8b 2f             	mov    (%r15),%r13
  23:	4c 89 e0             	mov    %r12,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 28 00          	cmpb   $0x0,(%rax,%rbp,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 e7             	mov    %r12,%rdi
  33:	e8 d4 34 e3 ff       	call   0xffe3350c
  38:	4d 89 2c 24          	mov    %r13,(%r12)
  3c:	4d 85 ed             	test   %r13,%r13
  3f:	74                   	.byte 0x74


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
