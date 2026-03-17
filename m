Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB4337998B
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768807; cv=none; b=MP1mwsG65FqLkNq0HLGCOQLY1dsLv8vvBE8Ksyn9ZltusS7mRweQNPag6gE73gYPtRB9P5uZZl5ez/90Ylkr0ivGMN3xY5wKzCpn9Y8/qwyMOGBr9pz+uu5SquGbRIolOqf6w/jfY1aonegrLKXZyC53GgvfGz8dLKzpNHg3Guo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768807; c=relaxed/simple;
	bh=lsEM0oLheBUU4eKIcHNAjpseHr2R5mGWcVr1gdHRI10=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=L8z/h3bhe1D8BLYMk6yfPOkwZdRS0djlFBtIttLjELn6kwEazhDIBJpnzzzoaG0V9wjLYeEXJpStS9OlLsm2PKgVcZniCOtlloXkSXe1ZES4WMMtJ7FVpnnojjqvBY1HsRieTxjcEWVvYL2PuWaFMdSM91CDpWIARJysGNUtrjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-67bf2b72878so30154455eaf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 10:33:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773768805; x=1774373605;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OipRQ9zxvTmfpMfkIU9uvHVnNwcyXRRqK7vPZDKQeZg=;
        b=iOHAOWiBzLy6reVYDY9w2BFZYiS2PofzayPXRd94jJCiCgOKJiDXetIbt8xE6l3p//
         /3EJw/jtcRE+trrmR709aW5JGjY2PGH5r8K0N/AjtAjXU1Q+2QYGaKewU92T/rVZZRyB
         i3KLPq2WHk7un23wGvnsLjqLf85d/zqe+5KHEG5LD3SXFe1qibZoAiXfah3ZCb/9VrD5
         l8RV+GGr9eeLcwi/x5nYvlm1MyFL06RXMMRb+G6xqXbYVxSygl78FhwzSwZopCLeFOuG
         dDl+aGVg8uWhJ5u3blnE3pBAlW2f/vVJc1OJabnw9dJlnsg3pMc+PDRMzDXgUBdkEMU8
         +lSg==
X-Forwarded-Encrypted: i=1; AJvYcCWwMbx3tTsXi+j31KOr00DMPFh5iNTQbAIXNTzGj3b0V40yInfakpecOJBwjUg4KFNDwAs2u8Isvb32e5M1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+N+yTtZ3FzA1PFidrmcV193NGDjgUyy5AbNmbv88jL4g+nbv
	857MIs7oV7TMb+GCrmkihVFp1wBkLu/0VyjHGx/llMmWGLlxY/fJl3iDVixeW4L82PcREutUwr0
	Fx8mgPBW83oo6jrtjjdxGtmgrRPNLJ7FW3ElLSr0tOQugG3rk/YhLUPEhgME=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:823:b0:664:86ce:df65 with SMTP id
 006d021491bc7-67c0dacf554mr97455eaf.32.1773768805323; Tue, 17 Mar 2026
 10:33:25 -0700 (PDT)
Date: Tue, 17 Mar 2026 10:33:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b99065.050a0220.248e02.012f.GAE@google.com>
Subject: [syzbot] [mm?] [fs?] general protection fault in rwsem_mark_wake
From: syzbot <syzbot+334054c6077f3a88ab3a@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, luto@kernel.org, mingo@redhat.com, 
	syzkaller-bugs@googlegroups.com, tglx@kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b84a0ebe421c Add linux-next specific files for 20260313
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=159fdd52580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7280ad1f68b2dce
dashboard link: https://syzkaller.appspot.com/bug?extid=334054c6077f3a88ab3a
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ee4216580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b478da580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/09145161a8a9/disk-b84a0ebe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b64c254e474c/vmlinux-b84a0ebe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a7c33f5f7f45/bzImage-b84a0ebe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+334054c6077f3a88ab3a@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 6080 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:rwsem_mark_wake+0xfa/0x7c0 kernel/locking/rwsem.c:445
Code: 01 00 74 08 4c 89 f7 e8 e4 c2 8d 00 4c 89 74 24 10 4d 8b 26 4d 8d 74 24 18 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 0f 85 75 06 00 00 41 83 3e 00 74 64 4c 89 ef be
RSP: 0018:ffffc900021cf9a0 EFLAGS: 00010006
RAX: 0000000000000003 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 1ffff92000439f40 RSI: ffffffff8e4a660a RDI: ffffffff8c4a5c80
RBP: ffffc900021cfaa0 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000439f50 R12: 0000000000000000
R13: ffff88807da38f50 R14: 0000000000000018 R15: ffffc900021cfc20
FS:  00005555890a6500(0000) GS:ffff888124de0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000605000 CR3: 000000007a580000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rwsem_del_wake_waiter+0x25d/0x2e0 kernel/locking/rwsem.c:612
 rwsem_down_write_slowpath+0xa6f/0x1080 kernel/locking/rwsem.c:1234
 __down_write_common kernel/locking/rwsem.c:1347 [inline]
 __down_write_killable kernel/locking/rwsem.c:1361 [inline]
 down_write_killable+0x1eb/0x240 kernel/locking/rwsem.c:1639
 mmap_write_lock_killable include/linux/mmap_lock.h:554 [inline]
 vm_mmap_pgoff+0x234/0x4f0 mm/util.c:579
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6cd219c502
Code: 4f 01 00 0f 1f 44 00 00 41 f7 c1 ff 0f 00 00 75 27 55 89 cd 53 48 89 fb 48 85 ff 74 3b 41 89 ea 48 89 df b8 09 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 6e 5b 5d c3 0f 1f 00 48 c7 c0 e8 ff ff ff 64
RSP: 002b:00007ffdcb93dea8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f6cd219c502
RDX: 0000000000000000 RSI: 0000000000021000 RDI: 0000000000000000
RBP: 0000000000020022 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000020022 R11: 0000000000000246 R12: 00007ffdcb93e010
R13: ffffffffffffffc0 R14: 0000000000001000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rwsem_mark_wake+0xfa/0x7c0 kernel/locking/rwsem.c:445
Code: 01 00 74 08 4c 89 f7 e8 e4 c2 8d 00 4c 89 74 24 10 4d 8b 26 4d 8d 74 24 18 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <0f> b6 04 08 84 c0 0f 85 75 06 00 00 41 83 3e 00 74 64 4c 89 ef be
RSP: 0018:ffffc900021cf9a0 EFLAGS: 00010006
RAX: 0000000000000003 RBX: 0000000000000000 RCX: dffffc0000000000
RDX: 1ffff92000439f40 RSI: ffffffff8e4a660a RDI: ffffffff8c4a5c80
RBP: ffffc900021cfaa0 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000439f50 R12: 0000000000000000
R13: ffff88807da38f50 R14: 0000000000000018 R15: ffffc900021cfc20
FS:  00005555890a6500(0000) GS:ffff888124de0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000605000 CR3: 000000007a580000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	01 00                	add    %eax,(%rax)
   2:	74 08                	je     0xc
   4:	4c 89 f7             	mov    %r14,%rdi
   7:	e8 e4 c2 8d 00       	call   0x8dc2f0
   c:	4c 89 74 24 10       	mov    %r14,0x10(%rsp)
  11:	4d 8b 26             	mov    (%r14),%r12
  14:	4d 8d 74 24 18       	lea    0x18(%r12),%r14
  19:	4c 89 f0             	mov    %r14,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	0f b6 04 08          	movzbl (%rax,%rcx,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 75 06 00 00    	jne    0x6ab
  36:	41 83 3e 00          	cmpl   $0x0,(%r14)
  3a:	74 64                	je     0xa0
  3c:	4c 89 ef             	mov    %r13,%rdi
  3f:	be                   	.byte 0xbe


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
