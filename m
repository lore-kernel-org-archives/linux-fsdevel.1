Received: from mail-oa2-f11.google.com (mail-oa2-f11.google.com [74.125.231.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962FE2E612E
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 01:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830490; cv=none; b=fsUfVOhr55sbq7veNzzA6uL0nqb8PI7iMdbgo4Qpul58fErR51JAkr3dMZzGgnkhxPk9++3goGG+EPpqewaZZLoo49VoXC+tTKzBs4T6MyLcvQu8IymO/sMvlr/iwRJ+TXikamUnkA3yohV8yX452PFPeODB/ENCEaG1+e68QQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830490; c=relaxed/simple;
	bh=5zT4sF2jCjYpsuSxYEnTY/3MK0x0xywUcP6NuyidrRo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WbOmVw6EVZ6Shg7bpk5o7XSAgUl8MAkCs8q7DSDaaRTr0Fvt6GpTRQNUb3TQFEQk2Bx1sWnQaXoXhyC+DxJJ8peVkjZjrTkYYFUi3yv2ulKoH+eN82pBdsc4sJsTv69fp/TVLp6DwdMsekkmhVgTMzDq7tj8/aoUKigCv1keZ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f11.google.com with SMTP id 586e51a60fabf-462dec1c4c5so1246427fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 18:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788830485; x=1789435285;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wj4LB9nxthiGiSxJ3o+Z6kc/vLG2la/KudYqRMk2urw=;
        b=ro97lixqJeCVafpXaTet0f4GTknp04f6jRaTID/i7p8m/daZjAJ2TMaZq7n2bLseb7
         50HAvjXyi7sJgR00L+HonD9UOnnyCOIlC/KBhdiCCT13s4iF8J1aKZcPR4Zb4QE8nepo
         67h6kacDmZun6KnAkpk9RXkYZ4Z60uuL96ClbFYUK2jeily6MnHLnTfy/ouJgFlj5Sf8
         FIhOf+bsw6Fjq5pPRkP8ZgWqsEVpBANuchD+f45bFw8Aw/z1pS08qhuxhcRBkiz7uY+f
         BjUi76AhnO/CSLNgJhb49RvoXKOzge9QU3Yq8kNFowvu58Nt5UjVz0O1FT+6ZBmtrv+f
         oWAw==
X-Forwarded-Encrypted: i=1; AKwUvBy0KgDhoTj8WoqKQY///mm37gP0j++Mdxk3iuNj/h4x5Von8kaGz9mM3RTdNqIqrzCLBDTFdbPQiNe6ZRpU@vger.kernel.org
X-Gm-Message-State: AFuF++mWNGvTxfHRJLxQOhbn46W+w5JOBbvne3IVqwIAe3w2DKD8/zOM
	1EKMyMlvdYU9ZDgIVT/UTIHBifb1FxgoP1c0ku/HtWvojm9tEBzs1hQQXKehU6Cvk1yRCn0LdG8
	zNL1gr6krGlN+10bNXrL8OKlvXMr1a5iB2aPavS7ejUrtIpo37o9ZFrh43V4=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:211:b0:6b7:83d6:2926 with SMTP id
 006d021491bc7-6b783d62ecamr12022027eaf.41.1788830484812; Mon, 07 Sep 2026
 18:21:24 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:21:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9f6314.6e6c5f9e.28f11f.0001.GAE@google.com>
Subject: [syzbot] [fs?] BUG: unable to handle kernel NULL pointer dereference
 in getname_kernel
From: syzbot <syzbot+6c46a179b56c651c4c96@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    73ae59e97596 Merge tag 'erofs-for-7.3-rc1-2' of git://git...
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux master
console output: https://syzkaller.appspot.com/x/log.txt?x=12e13125580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c35e49327a11721f
dashboard link: https://syzkaller.appspot.com/bug?extid=6c46a179b56c651c4c96
compiler:       aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100ae749580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e13125580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-73ae59e9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aa44bfbf1645/vmlinux-73ae59e9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ec41058a1639/Image-73ae59e9.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c46a179b56c651c4c96@syzkaller.appspotmail.com

nvmet: adding nsid 1 to subsystem testsubsys
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0
user pgtable: 4k pages, 52-bit VAs, pgdp=00000000437b3a80
[0000000000000000] pgd=0800000053c32403, p4d=0800000053721403, pud=0800000049146403, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 3633 Comm: syz.2.17 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: linux,dummy-virt (DT)
pstate: 61402009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
pc : __pi_strlen+0x14/0x150 arch/arm64/lib/strlen.S:87
lr : __fortify_strlen include/linux/fortify-string.h:218 [inline]
lr : do_getname_kernel+0x20/0x12c fs/namei.c:260
sp : ffff800089c2bb60
x29: ffff800089c2bb60 x28: fbf0000003fa8000 x27: 0000000000000000
x26: 0000000000000000 x25: 0000000000000000 x24: fcf0000008b7db00
x23: f3f00000067df000 x22: 0000000000000000 x21: 0000000000000000
x20: 00000000fffffff1 x19: 0000000000020002 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 00000000200004c0
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000078
x8 : 0101010101010101 x7 : fcf0000008b7db08 x6 : fdf0000013703002
x5 : fdf0000013703002 x4 : 0000000000000000 x3 : fbf0000003fa8000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 __pi_strlen+0x14/0x150 arch/arm64/lib/strlen.S:86 (P)
 getname_kernel+0x14/0x20 fs/namei.c:289
 class_filename_kernel_constructor include/linux/fs.h:2586 [inline]
 filp_open+0x34/0x104 fs/open.c:1391
 nvmet_file_ns_enable+0x38/0xfc drivers/nvme/target/io-cmd-file.c:41
 nvmet_ns_enable+0x12c/0x1e0 drivers/nvme/target/core.c:596
 nvmet_ns_enable_store+0x64/0xd4 drivers/nvme/target/configfs.c:737
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0xc4/0x128 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x244/0x36c fs/read_write.c:687
 ksys_write+0x70/0x108 fs/read_write.c:739
 __do_sys_write fs/read_write.c:750 [inline]
 __se_sys_write fs/read_write.c:747 [inline]
 __arm64_sys_write+0x18/0x24 fs/read_write.c:747
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x54/0x10c arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x1c/0x34 arch/arm64/kernel/syscall.c:140
 el0_svc+0x38/0x1fc arch/arm64/kernel/entry-common.c:758
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:590
Code: 92400c04 b200c3e8 f100009f 5400088c (a9400c02) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	92400c04 	and	x4, x0, #0xf
   4:	b200c3e8 	mov	x8, #0x101010101010101     	// #72340172838076673
   8:	f100009f 	cmp	x4, #0x0
   c:	5400088c 	b.gt	0x11c
* 10:	a9400c02 	ldp	x2, x3, [x0] <-- trapping instruction


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
