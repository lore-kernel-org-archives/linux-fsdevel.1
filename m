Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A342DA26
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 12:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415166; cv=none; b=fvqLKgPUTc7cUGKm2DGXJ4lr9y3Oo2ra0ges+dpes9RsMOgnXRiTyLIN1uaNtSed+Lbm2B1+/je60/mLrDC/GLUQhUuwrLFf28BBdsKXWJcp45uCBqtA0eVZ8tVqR0PbMOitJbwO8kyNwz6bdzJA1sIn0XCbeg/gIsQ+0NYjAT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415166; c=relaxed/simple;
	bh=872RtX+Eg/Janu9ChgicVLa25i1SOwbk6ghPIHvTVYY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=j2ZXqdPuDA1qtIIJnd5SPYpq7yVnAx1w5MzbNEL3kl4uK43iLQY/VtQjS+FAKo6Y4XCj/60VZ5CRgTWu4+Ax4Ewb6aaLjZ54wR9/UaFitaJYFMwcdNNl1RzwT057/li/jUn46/m27Fc2YAaZuSuNSEIeIh+ot+TPmbnlcavydwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6a13b72112dso2078848eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 05:39:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785415163; x=1786019963;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xNsBLlBMq04JQ0HQtCl756pE3w1ThuI4TF06dXtxVcQ=;
        b=bButJBwOK82kawbRljBxXNsvDMVBdWpY3MDvvOCLV2gfUxtvgDMmaDYBhVE5TRbPk/
         Ys6iQH6F4K8RgBlRK9lAiWjotppfIis5MkwFN1OjYt1ZASRr/f9EyXbCzlvW+tBr3X3w
         GH+53fwEtrHafesr/c0tYbs+pNQajCSOTcycvJqK3p8Mw3u2Vx7lvo7u+ulWOTSyOOw5
         CNGoRkyEu0iWKvS62Wg/O2xV/7zeV5298HdXdLYflMczLVmHlo5kB8dQn97tXCMssd1j
         jNngLFNMlQ2+V9ych7qRrOkYvVVM+/toOx49AU5SR4eB4Iv337R4LSUbelMV6IZQDKsH
         CrJA==
X-Forwarded-Encrypted: i=1; AHgh+RppU6rIiroKCUGwqsuN81SvOtl/GFjN1eqdNlD6dzVbre3daR9tddZPqabQYMCHUNe32v23U3sra/RDWinW@vger.kernel.org
X-Gm-Message-State: AOJu0YziXBLvdwJM5pCP4yyi7Ai9O66EFVwfIknz9Rs/WL8exE6LGeET
	UAURE5uRcPGu5YF67vactYsAJFwR6n4ngAx0UcDHieu/1ZT7lv+vfeBxvBuGH2VhvwYssqw2QEm
	SRJiJko0O8pyo2Ze7eLPLE3f2Nk3X6jikqE/ex824XdXzs3mUG85uQ69Ja4I=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2221:b0:6ab:15d:e295 with SMTP id
 006d021491bc7-6acbc0dd21fmr1260876eaf.52.1785415163495; Thu, 30 Jul 2026
 05:39:23 -0700 (PDT)
Date: Thu, 30 Jul 2026 05:39:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6b45fb.57649fcc.360844.0016.GAE@google.com>
Subject: [syzbot] [fs?] general protection fault in __simple_recursive_removal (2)
From: syzbot <syzbot+cc460646984184ad435a@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    11028ab62899 Merge tag 'probes-fixes-v7.2-rc5' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1667d632580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=cc460646984184ad435a
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14dc25b9580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-11028ab6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2be78614a29/vmlinux-11028ab6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/301a11d315af/bzImage-11028ab6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc460646984184ad435a@syzkaller.appspotmail.com

i2c i2c-4: failure writing data
retu-mfd 4-0002: could not read Tahvo revision: -5
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000028: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000140-0x0000000000000147]
CPU: 3 UID: 0 PID: 6038 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:kasan_byte_accessible+0x15/0x30 mm/kasan/generic.c:210
Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03 48 01 c7 <0f> b6 07 3c 07 0f 96 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00
RSP: 0018:ffffc9000388f530 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81e53a84 RDI: dffffc0000000028
RBP: 0000000000000140 R08: 0000000000000001 R09: 0000000000000000
R10: ffff88803eb7a69b R11: 0000000000000000 R12: ffffffff81e53a84
R13: 0000000000000001 R14: 0000000000000002 R15: 0000000000000000
FS:  00007f75557fe6c0(0000) GS:ffff8880d60dc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f94181cf708 CR3: 000000003a18e000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __kasan_check_byte+0x13/0x50 mm/kasan/common.c:573
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire kernel/locking/lockdep.c:5842 [inline]
 lock_acquire+0x132/0x370 kernel/locking/lockdep.c:5825
 down_write_nested+0x94/0x200 kernel/locking/rwsem.c:1757
 inode_lock_nested include/linux/fs.h:1069 [inline]
 __simple_recursive_removal+0x7f/0x5c0 fs/libfs.c:606
 debugfs_remove+0x5d/0x80 fs/debugfs/inode.c:781
 i2c_device_probe+0x6e2/0xd10 drivers/i2c/i2c-core-base.c:610
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __device_attach_driver+0x1df/0x320 drivers/base/dd.c:1026
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1098
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x64/0x160 drivers/base/bus.c:620
 device_add+0x121d/0x1970 drivers/base/core.c:3772
 i2c_new_client_device+0x660/0xd30 drivers/i2c/i2c-core-base.c:1019
 new_device_store+0x20f/0x420 drivers/i2c/i2c-core-base.c:1307
 dev_attr_store+0x58/0x80 drivers/base/core.c:2505
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f755619df99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f75557fe028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f7556425fa0 RCX: 00007f755619df99
RDX: 0000000000000007 RSI: 0000200000000680 RDI: 0000000000000005
RBP: 00007f7556234ec4 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7556426038 R14: 00007f7556425fa0 R15: 00007ffcd129f658
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kasan_byte_accessible+0x15/0x30 mm/kasan/generic.c:210
Code: 00 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03 48 01 c7 <0f> b6 07 3c 07 0f 96 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00
RSP: 0018:ffffc9000388f530 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81e53a84 RDI: dffffc0000000028
RBP: 0000000000000140 R08: 0000000000000001 R09: 0000000000000000
R10: ffff88803eb7a69b R11: 0000000000000000 R12: ffffffff81e53a84
R13: 0000000000000001 R14: 0000000000000002 R15: 0000000000000000
FS:  00007f75557fe6c0(0000) GS:ffff8880d60dc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f94181cf708 CR3: 000000003a18e000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	0f 1f 00             	nopl   (%rax)
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	90                   	nop
  14:	90                   	nop
  15:	0f 1f 40 d6          	nopl   -0x2a(%rax)
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 c1 ef 03          	shr    $0x3,%rdi
  27:	48 01 c7             	add    %rax,%rdi
* 2a:	0f b6 07             	movzbl (%rdi),%eax <-- trapping instruction
  2d:	3c 07                	cmp    $0x7,%al
  2f:	0f 96 c0             	setbe  %al
  32:	c3                   	ret
  33:	cc                   	int3
  34:	cc                   	int3
  35:	cc                   	int3
  36:	cc                   	int3
  37:	66                   	data16
  38:	66                   	data16
  39:	2e                   	cs
  3a:	0f                   	.byte 0xf
  3b:	1f                   	(bad)
  3c:	84 00                	test   %al,(%rax)


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
