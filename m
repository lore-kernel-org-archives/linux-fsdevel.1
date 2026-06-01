Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B550399CE9
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 10:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309645; cv=none; b=ruTPyJ+mxSa/yYSaplNyqOHHYG6jiWoxoTn5CYbRHQ5nADM0tIHmS4ZoI+g+7nw8D9mMDIe+hkQ1kxADriQ3PrRCYhBLs7IpqmnAs0MYKqACt5whzjRq30RaFHStr0wcqIazC/4dP3h7QwahfFrM40fEZXG20F0eJ3WBgSDvnQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309645; c=relaxed/simple;
	bh=QZpjG/UzxfBrqmGrDSnbKNCojASn/9+1q3s57nBkk6A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pWID7Su49EgsXFRdK6Cqd6keyK/9S9vZN7QEpUEJDjFc8OvO9KNzD5X6IinbLqSSHPR+AYHp/AizQPVSsfRMQdPw2tLwr/LFD/+Z1p1rjL70O9VQ5OblTqIByhToSs+m/xVf43m2fPttXkxIUGXwjGA79EoJP+fmvdlUYwQISHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-69dc70d4b0aso8263637eaf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 03:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780309642; x=1780914442;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9OAj8tpwVCz7sqt4lnsIHvwwRrgLo88h/anUIIEmmuo=;
        b=JRBo5qgndHrMon7LvMo7vhFLah5Mp157U3dXwFb3fTpFzfi0L2SX+G7vzb5NtPArc/
         BFR5S87Lig4F3KCJHccNlDtYmgNn1Nb7NFiiVz/4HFv0Uf/awpRH+aWlgNBts2ynzmBN
         awB4XEbZuzPbwqFHdydaLdBt6Jj0g/JcCs5J+kBiqLb/EnAwksj0KpNOC5hff8LKPDGI
         /JawNfrgUU3L6hATcpZBKxo4J0V63Pq1UEj1bNGEdTkf4YxPyy0wvsAIjxya/ARCAzGG
         Oo1gXAbby0ereKFMwbmzNyN7lOpgOo+oWe9A46RbnxOUhUgTMlP0NxMJBxQ+c0t4I6by
         fe+A==
X-Forwarded-Encrypted: i=1; AFNElJ/xuZ0aK3xE3wa+GxGogVdE/S4iRTMQ/J3U+WUqP6X54Dxl9hoxjIyBOSq3ZP6or8p0G9RsQ5xQWLj54VBy@vger.kernel.org
X-Gm-Message-State: AOJu0YwaIgteOu8AKDhHaKLRiCnqFo6cOkdfnjEkp6ABlNVcxJ4NJqEA
	ViOkd7H5kzNpJV46rk6zAus+CIWHEHtGguNJt9A6m6FNzuwdmywpkTc6IUeSy4LlqSU9T5Pdk4n
	g/0vnWdgNIurIyxUQItfWPPbpAgTIKpCSPVuFcfXOCyqVEg7wvxuE4VB3dYc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:150e:b0:69d:fa6b:eec6 with SMTP id
 006d021491bc7-69e102b2a55mr5538336eaf.4.1780309642621; Mon, 01 Jun 2026
 03:27:22 -0700 (PDT)
Date: Mon, 01 Jun 2026 03:27:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1d5e8a.fd5edf16.2e7427.000f.GAE@google.com>
Subject: [syzbot] [fuse?] general protection fault in fuse_dev_release
From: syzbot <syzbot+5bfc774fd6dffbbc4b70@syzkaller.appspotmail.com>
To: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f7af91adc230 Add linux-next specific files for 20260528
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14f1f57e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9ace0a34301dcd68
dashboard link: https://syzkaller.appspot.com/bug?extid=5bfc774fd6dffbbc4b70
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d3fc56ffd7af/disk-f7af91ad.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ac5990ec0e63/vmlinux-f7af91ad.xz
kernel image: https://storage.googleapis.com/syzbot-assets/46b531c86f46/bzImage-f7af91ad.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5bfc774fd6dffbbc4b70@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 5919 Comm: syz.3.28 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:list_empty include/linux/list.h:404 [inline]
RIP: 0010:list_splice_init include/linux/list.h:602 [inline]
RIP: 0010:fuse_dev_release+0x19c/0x670 fs/fuse/dev.c:2221
Code: 5c 24 28 48 8b 44 24 30 42 80 3c 38 00 74 08 48 89 df e8 17 22 eb fe 48 8b 0b 48 89 4c 24 18 4e 8d 24 31 4d 89 e5 49 c1 ed 03 <43> 80 7c 3d 00 00 74 08 4c 89 e7 e8 f4 21 eb fe 4d 8b 3c 24 4d 39
RSP: 0018:ffffc90005cdfc60 EFLAGS: 00010246
RAX: 1ffff110055a2853 RBX: ffff88802ad14298 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90005cdfd40 R08: ffffffff8b325a20 R09: ffffffff8dfcac60
R10: dffffc0000000000 R11: fffffbfff1f1a07f R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  000055559158b500(0000) GS:ffff888125fcd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff1eab87879 CR3: 000000003329e000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __fput+0x461/0xa70 fs/file_table.c:510
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x193/0x680 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x353/0x580 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd2f2dcce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe4cd86cc8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fd2f3047d[  137.410093][ T5919] RAX: 0000000000000000 RBX: 00007fd2f3047da0 RCX: 00007fd2f2dcce59
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007fd2f3047da0 R08: 0000000000000006 R09: 0000000000000000
R10: 00007fd2f3047cb0 R11: 0000000000000246 R12: 0000000000021201
R13: 00007fd2f304618c R14: 00000000000210c9 R15: 00007ffe4cd86dd0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:list_empty include/linux/list.h:404 [inline]
RIP: 0010:list_splice_init include/linux/list.h:602 [inline]
RIP: 0010:fuse_dev_release+0x19c/0x670 fs/fuse/dev.c:2221
Code: 5c 24 28 48 8b 44 24 30 42 80 3c 38 00 74 08 48 89 df e8 17 22 eb fe 48 8b 0b 48 89 4c 24 18 4e 8d 24 31 4d 89 e5 49 c1 ed 03 <43> 80 7c 3d 00 00 74 08 4c 89 e7 e8 f4 21 eb fe 4d 8b 3c 24 4d 39
RSP: 0018:ffffc90005cdfc60 EFLAGS: 00010246
RAX: 1ffff110055a2853 RBX: ffff88802ad14298 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90005cdfd40 R08: ffffffff8b325a20 R09: ffffffff8dfcac60
R10: dffffc0000000000 R11: fffffbfff1f1a07f R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  000055559158b500(0000) GS:ffff888125fcd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff1eab87879 CR3: 000000003329e000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	5c                   	pop    %rsp
   1:	24 28                	and    $0x28,%al
   3:	48 8b 44 24 30       	mov    0x30(%rsp),%rax
   8:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1)
   d:	74 08                	je     0x17
   f:	48 89 df             	mov    %rbx,%rdi
  12:	e8 17 22 eb fe       	call   0xfeeb222e
  17:	48 8b 0b             	mov    (%rbx),%rcx
  1a:	48 89 4c 24 18       	mov    %rcx,0x18(%rsp)
  1f:	4e 8d 24 31          	lea    (%rcx,%r14,1),%r12
  23:	4d 89 e5             	mov    %r12,%r13
  26:	49 c1 ed 03          	shr    $0x3,%r13
* 2a:	43 80 7c 3d 00 00    	cmpb   $0x0,0x0(%r13,%r15,1) <-- trapping instruction
  30:	74 08                	je     0x3a
  32:	4c 89 e7             	mov    %r12,%rdi
  35:	e8 f4 21 eb fe       	call   0xfeeb222e
  3a:	4d 8b 3c 24          	mov    (%r12),%r15
  3e:	4d                   	rex.WRB
  3f:	39                   	.byte 0x39


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
