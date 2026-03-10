Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB5E3B95E4
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 03:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773114846; cv=none; b=Ihnp7KbysGijENWc/qTkvc3sBDK8IKqOzbijQeDVB9+tZ/HzRKlvlr68kV4SRBPjBRsB0a82VD6ryYGToS7L/NwvzLlHXpeeXYEDnZIlLO77Kv78UlRpLgiLuUoFzPPFUnFhMmC0RH1lYF7a8i6u+3ypCCcx1NBXHVkNFwDs4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773114846; c=relaxed/simple;
	bh=vbtP3VKiwZUu7DqXyAtAieLI1lNczSRyZzwKMtsUyiY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ihu7hViTLBnpDDDO3MU8x87aHz00IlLj/rkc2DSHdyuFduM0qKNqjrYuIpnRN9Jiz6ttgC1XFnivxwu17A1k7xENmNXPeKmEoZSOV2RzRxsi0f7N/Oee8G0qYvFPLek8GD6DaK5Icso9EQKXdbmSuA5gTuYSSOKVcZzCf1nxs8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-672c40f3873so211041287eaf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Mar 2026 20:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773114844; x=1773719644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oIx85w9W7IsG0j4v1Wx1+1hfwFsNA9DgmZnpX/ajWn4=;
        b=TSn4REiJVMNRUlGGd8wRziXcQ5Pva6K62xyHN3eBhL3WcTXyKBbhkru1u2QKuL2oMc
         VtNXKj6tfOhUYfg3+gvu4e08M4tiWj6Emy6JJxp8sOmsShj0yYIonSr23AocHJMjK3ta
         XYX5eaTHRFHIpOnF04oLeMht+9J4eQFEeU5VQqUJh+Y5o6yGVAddehJnjcofHZ6cqhM8
         lja/hWfpu3mJhlZa2oHMXlGUtShThVT/IAhWITaA+RziECwg57a6zybU1xDD0F3Oh4P2
         0+t38G9CQt2TM3frq7ObgWDAW/oX1sJQ43ywEWXTqfaHdNnkwUu8qoM+1gsY54+i/l9f
         ptjg==
X-Forwarded-Encrypted: i=1; AJvYcCWjsgcXe1yB+8RbP2s246erjUQL3rkpvjIaxjJbwNuZqq/weZe85Z6vFnA/9GXjj2Nm3yHj9hfStkY3EpNG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzmmj+d/rYbzO1dX3U+g/NXO8KldvBiKidun5R8ZM3Cck8AOOT
	1Pw9GKzA2kHleB6tlMldNNHo02As0w/fPFjN1N2g3wmgLr1WP1queREupWcnI3rHAKfDiJc9AHw
	mkQOUOhmoi0T1wFtiqi9ycuJVT0BJ/giB7YETp0yp5ZCraxGUkT3QdWJ+L6Q=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:edc8:0:b0:662:f763:c539 with SMTP id
 006d021491bc7-67b9bc6ad80mr8703060eaf.14.1773114843722; Mon, 09 Mar 2026
 20:54:03 -0700 (PDT)
Date: Mon, 09 Mar 2026 20:54:03 -0700
In-Reply-To: <aa-SinLe2jrtO1pS@hyeyoo>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69af95db.a00a0220.d013.0001.GAE@google.com>
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
From: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, catalin.marinas@arm.com, chao@kernel.org, 
	hao.li@linux.dev, harry.yoo@oracle.com, jaegeuk@kernel.org, jannh@google.com, 
	liam.howlett@oracle.com, linkinjeon@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	pfalcato@suse.de, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	vbabka@kernel.org, vbabka@suse.cz, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in __pcs_replace_empty_main

BUG: memory leak
unreferenced object 0xffff888100b60200 (size 512):
  comm "kthreadd", pid 2, jiffies 4294937343
  hex dump (first 32 bytes):
    00 6c c3 09 81 88 ff ff 00 9a 9d 0a 81 88 ff ff  .l..............
    00 16 04 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc 8a95531e):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4552 [inline]
    slab_alloc_node mm/slub.c:4874 [inline]
    __do_kmalloc_node mm/slub.c:5267 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5280
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    alloc_full_sheaf mm/slub.c:2834 [inline]
    __pcs_replace_empty_main+0x1d2/0x260 mm/slub.c:4634
    alloc_from_pcs mm/slub.c:4725 [inline]
    slab_alloc_node mm/slub.c:4859 [inline]
    __do_kmalloc_node mm/slub.c:5267 [inline]
    __kmalloc_node_noprof+0x57e/0x5d0 mm/slub.c:5274
    kmalloc_node_noprof include/linux/slab.h:1081 [inline]
    __vmalloc_area_node mm/vmalloc.c:3855 [inline]
    __vmalloc_node_range_noprof+0x284/0xe50 mm/vmalloc.c:4064
    __vmalloc_node_noprof+0x71/0x90 mm/vmalloc.c:4124
    alloc_thread_stack_node kernel/fork.c:355 [inline]
    dup_task_struct kernel/fork.c:924 [inline]
    copy_process+0x3e5/0x28c0 kernel/fork.c:2050
    kernel_clone+0xac/0x6e0 kernel/fork.c:2654
    kernel_thread+0x80/0xb0 kernel/fork.c:2715
    create_kthread kernel/kthread.c:459 [inline]
    kthreadd+0x186/0x250 kernel/kthread.c:817
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88810438c200 (size 512):
  comm "swapper/0", pid 1, jiffies 4294937794
  hex dump (first 32 bytes):
    00 02 10 0e 81 88 ff ff 00 56 c3 09 81 88 ff ff  .........V......
    00 17 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 3e1bb722):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4552 [inline]
    slab_alloc_node mm/slub.c:4874 [inline]
    __do_kmalloc_node mm/slub.c:5267 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5280
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5730
    free_to_pcs mm/slub.c:5783 [inline]
    slab_free mm/slub.c:6185 [inline]
    kfree+0x352/0x390 mm/slub.c:6498
    v4l2_ctrl_handler_free drivers/media/v4l2-core/v4l2-ctrls-core.c:1756 [inline]
    v4l2_ctrl_handler_free+0x92/0x290 drivers/media/v4l2-core/v4l2-ctrls-core.c:1736
    vivid_dev_release+0x26/0x90 drivers/media/test-drivers/vivid/vivid-core.c:857
    v4l2_device_release drivers/media/v4l2-core/v4l2-device.c:51 [inline]
    kref_put include/linux/kref.h:65 [inline]
    v4l2_device_put+0x6b/0xa0 drivers/media/v4l2-core/v4l2-device.c:56
    vivid_create_instance drivers/media/test-drivers/vivid/vivid-core.c:2070 [inline]
    vivid_probe.cold+0x55a/0x386d drivers/media/test-drivers/vivid/vivid-core.c:2095
    platform_probe+0x86/0xf0 drivers/base/platform.c:1446
    call_driver_probe drivers/base/dd.c:583 [inline]
    really_probe+0x12f/0x3a0 drivers/base/dd.c:661
    __driver_probe_device+0xc7/0x160 drivers/base/dd.c:803
    driver_probe_device+0x2a/0x120 drivers/base/dd.c:833
    __driver_attach drivers/base/dd.c:1227 [inline]
    __driver_attach+0x10a/0x200 drivers/base/dd.c:1167
    bus_for_each_dev+0xb8/0x120 drivers/base/bus.c:383
    bus_add_driver+0x122/0x280 drivers/base/bus.c:715
    driver_register+0xb1/0x140 drivers/base/driver.c:249

BUG: memory leak
unreferenced object 0xffff888109c35c00 (size 512):
  comm "kworker/0:1", pid 10, jiffies 4294937868
  hex dump (first 32 bytes):
    00 68 d4 09 81 88 ff ff 00 9c de 09 81 88 ff ff  .h..............
    00 16 04 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc 9ab54a7c):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4552 [inline]
    slab_alloc_node mm/slub.c:4874 [inline]
    __do_kmalloc_node mm/slub.c:5267 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5280
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5730
    free_to_pcs mm/slub.c:5783 [inline]
    slab_free mm/slub.c:6185 [inline]
    kfree+0x352/0x390 mm/slub.c:6498
    vfree.part.0+0x1cd/0x4d0 mm/vmalloc.c:3484
    vfree mm/vmalloc.c:3456 [inline]
    delayed_vfree_work+0x5b/0x90 mm/vmalloc.c:3398
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88810a9d9a00 (size 512):
  comm "swapper/0", pid 1, jiffies 4294937887
  hex dump (first 32 bytes):
    00 02 b6 00 81 88 ff ff 00 98 9d 0a 81 88 ff ff  ................
    00 16 04 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc 368f6316):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4552 [inline]
    slab_alloc_node mm/slub.c:4874 [inline]
    __do_kmalloc_node mm/slub.c:5267 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5280
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5730
    free_to_pcs mm/slub.c:5783 [inline]
    slab_free mm/slub.c:6185 [inline]
    kfree+0x352/0x390 mm/slub.c:6498
    slab_sysfs_init+0xce/0xf0 mm/slub.c:9613
    do_one_initcall+0x79/0x4c0 init/main.c:1382
    do_initcall_level init/main.c:1444 [inline]
    do_initcalls init/main.c:1460 [inline]
    do_basic_setup init/main.c:1479 [inline]
    kernel_init_freeable+0x2a4/0x340 init/main.c:1692
    kernel_init+0x1b/0x1d0 init/main.c:1582
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88810a9d9600 (size 512):
  comm "swapper/0", pid 1, jiffies 4294937887
  hex dump (first 32 bytes):
    00 b6 34 0a 81 88 ff ff 00 6c c3 09 81 88 ff ff  ..4......l......
    00 16 04 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc d6fcd7dc):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4552 [inline]
    slab_alloc_node mm/slub.c:4874 [inline]
    __do_kmalloc_node mm/slub.c:5267 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5280
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5730
    free_to_pcs mm/slub.c:5783 [inline]
    slab_free mm/slub.c:6185 [inline]
    kfree+0x352/0x390 mm/slub.c:6498
    slab_sysfs_init+0xce/0xf0 mm/slub.c:9613
    do_one_initcall+0x79/0x4c0 init/main.c:1382
    do_initcall_level init/main.c:1444 [inline]
    do_initcalls init/main.c:1460 [inline]
    do_basic_setup init/main.c:1479 [inline]
    kernel_init_freeable+0x2a4/0x340 init/main.c:1692
    kernel_init+0x1b/0x1d0 init/main.c:1582
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


Tested on:

commit:         1f318b96 Linux 7.0-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17bde806580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c6ad6fefffa76b1
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1065375a580000

