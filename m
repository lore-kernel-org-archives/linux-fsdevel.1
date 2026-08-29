Received: from mail-oi2-f4.google.com (mail-oi2-f4.google.com [74.125.231.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C5D7082D
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787996741; cv=none; b=tCXPJJnDaESD2ZBarWrbZtWxc7kVbekrWn5NzlepYkD3YD2qGUDJ6P5RBWzcNk5ioKU9WSzNnCtcplvUTMvcCS8rF8vL2eZcSDFsApr+wy+L6yDOeOl6qzj1rBLyijvQwJYTPuP7rA+mPjKG9WA9mfU9xfyy6PFLmFr94cjSRQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787996741; c=relaxed/simple;
	bh=mdjEtmYNt6m0PH+g5Pl1yWCdrS33hSY1MaQVZQgn4T8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T33keDL7/H8df2IyalofpTyiGL6LjebfhY/2acwYSyD4m8lNDBDf/C+koe/Za042wWtq7Ueqj6x5U6F9d56RhCrN/MhAS7ulccqPoJLAt3V5C4WHnAuPN3/aSHGZAJ1egG17M+C4xOSjgO/aOePXoEraQOlELap8LeW7RGKjHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f4.google.com with SMTP id 5614622812f47-4b3880be385so811821b6e.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Aug 2026 02:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787996738; x=1788601538;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qfen64N2iwo0bEIW3peyN+gV06ebUNeOYObnSGw4AG0=;
        b=o4GWGZEiiVFnYBr5l1QowItGI7IEnTah9xrDZ5ZD6tKh1NHOYVtpNDjq/r1UQpIxhj
         FgD+PMhn13m90RVmhLUAdt7viy7glM+Y5iDm8hPvs0XeGKOTTnUzbRDjJuZIcS9jr64J
         1A+FO5fuZbRNgQvHFB/HbzhIdgCrtLM3NWEWEhBYmqa0ag4OxCzMWv9DUmlGG5jFAgK5
         Z6igauncPz3DwyawToSM+9DgDJudkwBZV4OUKrfLqjgpdTKe3T5etoPmd0flmyPrk0I7
         pNkhaRSrfq6T3w3GjOhXnsbxySW79EUcC6izz/xbvOAeGPsg7r9xf9BkCsDmGPSPpLJf
         57dg==
X-Forwarded-Encrypted: i=1; AHgh+RrmiHwSl1gYdbPPya6GjYweILzsObpLzS6dQ3easLpdgM1zS8jcyj/CPrQzxlweytzddEkLlmLtMkHevMyT@vger.kernel.org
X-Gm-Message-State: AFuF++nYCnVZhdrSLDt8zKq3U+cPjiMtQxtEWtV1DqeIZSs69gbHj0fd
	HJETUAReriXZ+fPreCfsAzxNTfdnU1GrQb7olf4a5PDvgnpRZjB4ulqce6REFr7LvmOgiBQfN8I
	yL9bcH61rQHfZpQXcPxc5Gwz2O9bYrYePI8JRYEfq+pEMoLDAHOeeO+mlAKk=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:190f:b0:4b3:74d0:6ef7 with SMTP id
 5614622812f47-4b398037cdamr12522980b6e.4.1787996738186; Sat, 29 Aug 2026
 02:45:38 -0700 (PDT)
Date: Sat, 29 Aug 2026 02:45:38 -0700
In-Reply-To: <6a8ce445.dbb3a75c.7844.0016.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a92aa42.08e933ee.dbf97.0088.GAE@google.com>
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Write in do_bad_area
From: syzbot <syzbot+7bf725ed337e37307001@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    45c13f3f9e3b Merge tag 'hwlock-v7.3' of git://git.kernel.o..
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux master
console output: https://syzkaller.appspot.com/x/log.txt?x=16a01d79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c4b7daf40ce2cde
dashboard link: https://syzkaller.appspot.com/bug?extid=7bf725ed337e37307001
compiler:       aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15e5bd49580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a01d79580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/fa3fbcfdac58/non_bootable_disk-45c13f3f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e9902fa4027d/vmlinux-45c13f3f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b6ce3ac93fda/Image-45c13f3f.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7bf725ed337e37307001@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __lse__cmpxchg_case_acq_64 arch/arm64/include/asm/atomic_lse.h:272 [inline]
BUG: KASAN: slab-use-after-free in __cmpxchg_case_acq_64 arch/arm64/include/asm/cmpxchg.h:122 [inline]
BUG: KASAN: slab-use-after-free in __cmpxchg_acq arch/arm64/include/asm/cmpxchg.h:170 [inline]
BUG: KASAN: slab-use-after-free in raw_atomic64_cmpxchg_acquire include/linux/atomic/atomic-arch-fallback.h:4181 [inline]
BUG: KASAN: slab-use-after-free in raw_atomic64_try_cmpxchg_acquire include/linux/atomic/atomic-arch-fallback.h:4299 [inline]
BUG: KASAN: slab-use-after-free in raw_atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-long.h:1482 [inline]
BUG: KASAN: slab-use-after-free in atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4458 [inline]
BUG: KASAN: slab-use-after-free in __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
BUG: KASAN: slab-use-after-free in mutex_lock_interruptible+0x10/0x70 kernel/locking/mutex.c:1109
Write at addr faf0000016813780 by task syz.3.150/3858
Pointer tag: [fa], memory tag: [fe]

CPU: 0 UID: 0 PID: 3858 Comm: syz.3.150 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace arch/arm64/kernel/stacktrace.c:498 [inline] (C)
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x60/0x80 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x1c4/0x4b0 mm/kasan/report.c:482
 kasan_report+0x84/0xac mm/kasan/report.c:595
 report_tag_fault arch/arm64/mm/fault.c:368 [inline]
 do_tag_recovery arch/arm64/mm/fault.c:380 [inline]
 __do_kernel_fault+0x1b4/0x220 arch/arm64/mm/fault.c:424
 do_bad_area+0x68/0x80 arch/arm64/mm/fault.c:529
 do_tag_check_fault+0x34/0x44 arch/arm64/mm/fault.c:909
 do_mem_abort+0x40/0x90 arch/arm64/mm/fault.c:985
 el1_abort+0x44/0x64 arch/arm64/kernel/entry-common.c:342
 el1h_64_sync_handler+0x50/0xac arch/arm64/kernel/entry-common.c:469
 el1h_64_sync+0x6c/0x70 arch/arm64/kernel/entry.S:585
 __lse__cmpxchg_case_acq_64 arch/arm64/include/asm/atomic_lse.h:272 [inline] (P)
 __cmpxchg_case_acq_64 arch/arm64/include/asm/cmpxchg.h:122 [inline] (P)
 __cmpxchg_acq arch/arm64/include/asm/cmpxchg.h:170 [inline] (P)
 raw_atomic64_cmpxchg_acquire include/linux/atomic/atomic-arch-fallback.h:4181 [inline] (P)
 raw_atomic64_try_cmpxchg_acquire include/linux/atomic/atomic-arch-fallback.h:4299 [inline] (P)
 raw_atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-long.h:1482 [inline] (P)
 atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4458 [inline] (P)
 __mutex_trylock_fast kernel/locking/mutex.c:161 [inline] (P)
 mutex_lock_interruptible+0x10/0x70 kernel/locking/mutex.c:1109 (P)
 do_dentry_open+0x128/0x4fc fs/open.c:996
 vfs_open+0x2c/0xe8 fs/open.c:1101
 do_open fs/namei.c:4837 [inline]
 path_openat+0x5b4/0x960 fs/namei.c:5000
 do_file_open+0xb0/0x168 fs/namei.c:5029
 do_sys_openat2+0x84/0x104 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __arm64_sys_openat+0x64/0xc0 fs/open.c:1434
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x54/0x10c arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x1c/0x34 arch/arm64/kernel/syscall.c:140
 el0_svc+0x38/0x1fc arch/arm64/kernel/entry-common.c:758
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:590

Allocated by task 3857:
 kasan_save_stack+0x3c/0x64 mm/kasan/common.c:57
 save_stack_info+0x40/0x160 mm/kasan/tags.c:106
 kasan_save_alloc_info+0x14/0x20 mm/kasan/tags.c:142
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 poison_kmalloc_redzone mm/kasan/common.c:371 [inline]
 __kasan_kmalloc+0xf8/0x120 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x1d0/0x470 mm/slub.c:5563
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 activate_ep_files drivers/usb/gadget/legacy/inode.c:1610 [inline]
 gadgetfs_bind+0xd0/0x3c0 drivers/usb/gadget/legacy/inode.c:1701
 gadget_bind_driver+0x90/0x284 drivers/usb/gadget/udc/core.c:1662
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0xbc/0x2bc drivers/base/dd.c:706
 __driver_probe_device+0x11c/0x184 drivers/base/dd.c:868
 driver_probe_device+0x3c/0x114 drivers/base/dd.c:898
 __driver_attach+0x90/0x180 drivers/base/dd.c:1292
 bus_for_each_dev+0x7c/0xdc drivers/base/bus.c:383
 driver_attach+0x24/0x30 drivers/base/dd.c:1310
 bus_add_driver+0xe4/0x208 drivers/base/bus.c:763
 driver_register+0x68/0x130 drivers/base/driver.c:174
 usb_gadget_register_driver_owner+0x54/0xfc drivers/usb/gadget/udc/core.c:1752
 dev_config+0x214/0x484 drivers/usb/gadget/legacy/inode.c:1892
 vfs_write+0xd4/0x36c fs/read_write.c:685
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

Freed by task 3857:
 kasan_save_stack+0x3c/0x64 mm/kasan/common.c:57
 save_stack_info+0x40/0x160 mm/kasan/tags.c:106
 kasan_save_free_info+0x18/0x40 mm/kasan/tags.c:147
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0xe8/0x160 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2748 [inline]
 slab_free mm/slub.c:6499 [inline]
 kfree+0x150/0x420 mm/slub.c:6792
 put_ep.part.0+0x44/0x60 drivers/usb/gadget/legacy/inode.c:225
 put_ep include/linux/refcount.h:396 [inline]
 destroy_ep_files+0x104/0x170 drivers/usb/gadget/legacy/inode.c:1591
 gadgetfs_unbind+0x7c/0xc0 drivers/usb/gadget/legacy/inode.c:1664
 gadget_unbind_driver+0x7c/0x118 drivers/usb/gadget/udc/core.c:1724
 device_remove+0x4c/0x80 drivers/base/dd.c:616
 __device_release_driver drivers/base/dd.c:1349 [inline]
 device_release_driver_internal+0x1cc/0x224 drivers/base/dd.c:1372
 driver_detach+0x4c/0xb0 drivers/base/dd.c:1435
 bus_remove_driver+0x6c/0xbc drivers/base/bus.c:832
 driver_unregister+0x30/0x60 drivers/base/driver.c:202
 usb_gadget_unregister_driver+0x20/0x40 drivers/usb/gadget/udc/core.c:1784
 dev_release+0x68/0x80 drivers/usb/gadget/legacy/inode.c:1207
 __fput+0xcc/0x2f8 fs/file_table.c:512
 ____fput+0x14/0x20 fs/file_table.c:540
 task_work_run+0x70/0xe0 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x168/0x19c kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 arm64_syscall_exit_to_user_mode arch/arm64/kernel/entry-common.c:108 [inline]
 el0_svc+0x1f0/0x1fc arch/arm64/kernel/entry-common.c:759
 el0t_64_sync_handler+0xa0/0xe4 arch/arm64/kernel/entry-common.c:777
 el0t_64_sync+0x1a4/0x1a8 arch/arm64/kernel/entry.S:590

The buggy address belongs to the object at fff0000016813780
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 0 bytes inside of
 192-byte region [fff0000016813780, fff0000016813840)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x56813
flags: 0x1ffc00000000000(node=0|zone=0|lastcpupid=0x7ff|kasantag=0x0)
page_type: f5(slab)
raw: 01ffc00000000000 f0f0000003401300 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000150015 00000000f5000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 fff0000016813500: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 fff0000016813600: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
>fff0000016813700: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                                           ^
 fff0000016813800: fe fe fe fe f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 f3 fe
 fff0000016813900: fb fb fb fb fb fb fb fb fb fb fb fe fe fe fe fe
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
