Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A15246AA97
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863762; cv=none; b=O4pvM38vR7QzNjKFQh3raJk9Zbr9L4m0acLJDPh0GCKrWDLs89+Bf2QyeGKbFfcV1jnRIu4mwriHCIKZFpavE2dKDSNLQisG//dHlIA/m04v5hct3FvoC2tsZeF9ExunLfvjJoKpHNwzYEu5h3E9FnxUrbxFvxOxCSmlBtxljzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863762; c=relaxed/simple;
	bh=VwwTpV+ezdcw39Sr3AKQMGIAF2VE506c/8kWk/yhDXc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iFLW5N0aEGnRYsRRs1rwg76WPVCPm5K5cFHtkk7gdBVjVN4FcpEArORnOIHCKYYgk4u3BelVcRP6qKo+H0WG4bDk+XAvdU9MJSyPjRgXUGvIlxgllwTumYAFfjCnvQgQLHKFfBzf92Qlve3KJ6QVD5L+kyfyf7JcYytv9+ey3jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7ead32f5c6aso77892a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 10:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863739; x=1786468539;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XKd940BQHqh/j+Z3cKxp/K2Wgbp0NxV7joqVuJPtBE0=;
        b=BBtjdg4SMAOl2s0TFA3G+gA0fmNaaKkpgswFT2pac9gOyU/MKQlqrd0ALWQksD9y3P
         Q9cBvlzrmwfZpR6U3fo4YH8HwLgbvFM1sLHmgfu3G9xcjVKIoG5NjowSFl61L2YJ+ad4
         gD2qmu5ILgPwQGkNXUyOoCPP5KuPMl8Z1D2y+AcHrXJ12ygkdkCEOdcQH9RuKqSYPzLC
         OizTbG3wvNrqdAhwyoTxG+owscqGFlfitAZrI/O+O1T9P4a/8/i/YhbGBWQCju5pEcUb
         /avWlsmdg9rtjblooYfxi2/oonROE9sRrRUmZgRkIBxlmJt3cdy9NDGJwovJ1SMPB3OD
         TTAA==
X-Forwarded-Encrypted: i=1; AHgh+RqqCVaXcjFfpkfB+fns08jRtbrza0pnvEMFT2EPNvjZ8ihAgeIjoNdtwd8PyuWpZmb+b7UcLAz+nHsoHhpy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj2jwoaqiDL3UsIihejhCye0JlAhhZWFap3UpK0dcAacmbKSf8
	qFw4ZzYlVMbX1Q43ilhWRcr9BkoHixdI4BsjyZjb2hBnJC6QIb1o6P/IuBII0rWDrvpJKLrPp4b
	ms3FLtQWupx8NXuQuZzb+BWpx8ad4BU+nk5C1KJ2ZAp5Zkh6YUFUesfFHrHk=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4fd3:b0:496:2b3:ae71 with SMTP id
 5614622812f47-4afadef488fmr149848b6e.18.1785863739303; Tue, 04 Aug 2026
 10:15:39 -0700 (PDT)
Date: Tue, 04 Aug 2026 10:15:39 -0700
In-Reply-To: <6a6b45fb.57649fcc.360844.0016.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a721e3b.40259c87.584f4.04bd.GAE@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in __simple_recursive_removal
 (2)
From: syzbot <syzbot+cc460646984184ad435a@syzkaller.appspotmail.com>
To: dakr@kernel.org, driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7235a3e71949 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16c913b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ccf4bea59f67007
dashboard link: https://syzkaller.appspot.com/bug?extid=cc460646984184ad435a
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1116acc6580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=121fb649580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd45635beaae/disk-7235a3e7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d7d2e6507223/vmlinux-7235a3e7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b5b5d8de4cea/Image-7235a3e7.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc460646984184ad435a@syzkaller.appspotmail.com

i2c i2c-1: failure reading functionality
i2c i2c-1: failure reading functionality
Unable to handle kernel paging request at virtual address dfff800000000028
KASAN: null-ptr-deref in range [0x0000000000000140-0x0000000000000147]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0
[dfff800000000028] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 5728 Comm: syz.4.648 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/02/2026
pstate: 23400005 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : kasan_byte_accessible+0x10/0x20 mm/kasan/generic.c:210
lr : __kasan_check_byte+0x20/0x54 mm/kasan/common.c:573
sp : ffff800096777240
x29: ffff800096777240 x28: ffff800088b0a000 x27: ffff0000d0da3a80
x26: 2eb980008045b830 x25: 0000000000000000 x24: 0000000000000001
x23: 0000000000000000 x22: 0000000000000140 x21: 0000000000000140
x20: 0000000000000002 x19: ffff80008045b830 x18: 1fffe00035bc9e28
x17: 0000000000000003 x16: ffff800088b07000 x15: ffff800088bbd0a0
x14: 00000000ffff8000 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000000003 x9 : dfff800000000000
x8 : 0000000000000028 x7 : ffff8000818fc2c8 x6 : ffff800080d4edec
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : ffff80008045b830 x0 : 0000000000000140
Call trace:
 kasan_mem_to_shadow include/linux/kasan.h:65 [inline] (P)
 kasan_byte_accessible+0x10/0x20 mm/kasan/generic.c:210 (P)
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire+0xa4/0x364 kernel/locking/lockdep.c:5842
 down_write_nested+0x58/0xcc kernel/locking/rwsem.c:1757
 inode_lock_nested include/linux/fs.h:1069 [inline]
 __simple_recursive_removal+0x7c/0x430 fs/libfs.c:606
 simple_recursive_removal+0x2c/0x3c fs/libfs.c:646
 debugfs_remove+0x60/0x88 fs/debugfs/inode.c:781
 i2c_device_probe+0x884/0x9d4 drivers/i2c/i2c-core-base.c:610
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x29c/0x800 drivers/base/dd.c:706
 __driver_probe_device+0x1e0/0x350 drivers/base/dd.c:868
 driver_probe_device+0x6c/0x19c drivers/base/dd.c:898
 __device_attach_driver+0x198/0x2f8 drivers/base/dd.c:1026
 bus_for_each_drv+0x144/0x1dc drivers/base/bus.c:500
 __device_attach+0x248/0x390 drivers/base/dd.c:1098
 device_initial_probe+0x90/0xc8 drivers/base/dd.c:1153
 bus_probe_device+0x58/0x120 drivers/base/bus.c:620
 device_add+0x6cc/0x9e0 drivers/base/core.c:3772
 device_register+0x28/0x38 drivers/base/core.c:3854
 i2c_new_client_device+0x5ac/0xadc drivers/i2c/i2c-core-base.c:1019
 new_device_store+0x210/0x3d4 drivers/i2c/i2c-core-base.c:1307
 dev_attr_store+0x6c/0x90 drivers/base/core.c:2505
 sysfs_kf_write+0xe0/0x108 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x260/0x3b8 fs/kernfs/file.c:345
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x51c/0xa0c fs/read_write.c:687
 ksys_write+0x12c/0x228 fs/read_write.c:739
 __do_sys_write fs/read_write.c:750 [inline]
 __se_sys_write fs/read_write.c:747 [inline]
 __arm64_sys_write+0x84/0x98 fs/read_write.c:747
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x64/0x260 arch/arm64/kernel/entry-common.c:736
 el0t_64_sync_handler+0x48/0x148 arch/arm64/kernel/entry-common.c:755
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:594
Code: d503245f d343fc08 d2d00009 f2fbffe9 (38696908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	d503245f 	bti	c
   4:	d343fc08 	lsr	x8, x0, #3
   8:	d2d00009 	mov	x9, #0x800000000000        	// #140737488355328
   c:	f2fbffe9 	movk	x9, #0xdfff, lsl #48
* 10:	38696908 	ldrb	w8, [x8, x9] <-- trapping instruction


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
