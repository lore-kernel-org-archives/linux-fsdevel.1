Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F5233EAED
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777929125; cv=none; b=suZdXlnXgNIKWPqDWToiI999KJi4+L0GIMlueiyCr6GLJTrOL2ev/FUsKU1nihLt+xGFAQTb6fnHBL8M/2DMlqckbqx1Jzh3wBhkM3BTBL8clTyWQVRr2FaLzLd86GJHd3G/iuNwOYtCj8NqjIHelENn+eEcGRvl1ZBDOhuS92k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777929125; c=relaxed/simple;
	bh=piKeknRA0FM2ffTMiz94tMScAA1j4msi7rvBXo3BA+g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OpLjnvGrXBRUgG2AXbvgNMh04BoL2s55tai65UR240ZsDRC0H2r9XV3hwcbhWD2gn5ckjTr27/MGckOo/0CkcHW491m0ldkixEpN7R7vqwz6mmnIWvLNz78eCswD/bMkyaWurVH97jwlidEKuJm7cDW6eOOW2VguAJTO6asjHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-6949742b3ebso9955485eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2026 14:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777929122; x=1778533922;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSQFQVdI6dfDQGPwxlzx44ntf4feAWwEORf5sBnWwwc=;
        b=lPzBGm9VF7V53c4dP5y/EDzjErQyS7fflM67kTnI9icpqb4qQ1++9/DlXRZzG6U+rc
         cLPu/fh4CrbWsd0/lzcwDlF5/5q5fCxxQlhlHQy6XCSB/3wb0Hi+rSZXAtBIpmlzmyct
         FygJsqvZyb1+SegpNtObg6xguqrSSIgPIuZqmAemao84ut3H/7jNrWgOGvtog3LEBG/n
         1yAXsi8zMmU1wn767N8MI+y5jbPcSH1nLAmMpzqqmK3az4ZMaapQedpf4aPHHCTUUqGS
         URRd3u/LQXYaKwv0vmxCSuL97ztef36ZNaUoO53AO+tMkJyppReG7eGx+IsDASED+qN9
         UKpg==
X-Forwarded-Encrypted: i=1; AFNElJ/QzDjsXpS7e+uBymtpH5uEc7XoJif61gcR62ghcYVtVwJ1wplXkL0DSDAD7ZpouQ82bLNZB8AVnl8eRVyD@vger.kernel.org
X-Gm-Message-State: AOJu0YzvL1Pg6gnNoTc00ocFWeLOOi2/9CoJPh8ucmUAyGq4nHf0o1hp
	08nMb6NFsjMV4WvZ3digt2h/aks2wwgcIsOQJjZgpw1keR7s7NBzqnd4jRSp2KdWWMgLmulRAc+
	01xezmFPNbPhJUZoWyf6i7jIDrpEVhEuZIqx3XHJ0suLlQ0SCJOIIIhH+wP8=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81cb:b0:695:b571:e574 with SMTP id
 006d021491bc7-69697de88c3mr6094119eaf.59.1777929122596; Mon, 04 May 2026
 14:12:02 -0700 (PDT)
Date: Mon, 04 May 2026 14:12:02 -0700
In-Reply-To: <13bb1c13-98b6-4a4a-b03d-ba0f88680f1e@dev.snart.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f90ba2.170a0220.bb392.0007.GAE@google.com>
Subject: Re: [syzbot] [mm?] [exfat?] [f2fs?] memory leak in __kfree_rcu_sheaf
From: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
To: dxdt@dev.snart.me, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in __pcs_replace_empty_main

BUG: memory leak
unreferenced object 0xffff88810005f600 (size 512):
  comm "swapper/0", pid 0, jiffies 4294937296
  hex dump (first 32 bytes):
    40 a0 ce 2f 81 88 ff ff e0 13 ad 81 ff ff ff ff  @../............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 6fa78c59):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __do_kmalloc_node mm/slub.c:5294 [inline]
    __kmalloc_noprof+0x3b7/0x550 mm/slub.c:5307
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2768
    alloc_empty_sheaf mm/slub.c:2783 [inline]
    __pcs_replace_empty_main+0x22a/0x2a0 mm/slub.c:4646
    alloc_from_pcs mm/slub.c:4749 [inline]
    slab_alloc_node mm/slub.c:4883 [inline]
    __kmalloc_cache_noprof+0x3a6/0x480 mm/slub.c:5414
    kmalloc_noprof include/linux/slab.h:950 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __irq_domain_alloc_fwnode+0x37/0x140 kernel/irq/irqdomain.c:95
    irq_domain_alloc_named_fwnode include/linux/irqdomain.h:271 [inline]
    arch_early_irq_init+0x1c/0x70 arch/x86/kernel/apic/vector.c:803
    start_kernel+0x931/0xb80 init/main.c:1123
    x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
    x86_64_start_kernel+0xce/0xd0 arch/x86/kernel/head64.c:291
    common_startup_64+0x13e/0x148

BUG: memory leak
unreferenced object 0xffff888100902c00 (size 512):
  comm "kthreadd", pid 2, jiffies 4294937340
  hex dump (first 32 bytes):
    70 09 2a 29 81 88 ff ff e0 13 ad 81 ff ff ff ff  p.*)............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 638a9d9a):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __do_kmalloc_node mm/slub.c:5294 [inline]
    __kmalloc_noprof+0x3b7/0x550 mm/slub.c:5307
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2768
    alloc_empty_sheaf mm/slub.c:2783 [inline]
    __pcs_replace_empty_main+0x22a/0x2a0 mm/slub.c:4646
    alloc_from_pcs mm/slub.c:4749 [inline]
    slab_alloc_node mm/slub.c:4883 [inline]
    __kmalloc_cache_node_noprof+0x3e9/0x4d0 mm/slub.c:5427
    kmalloc_node_noprof include/linux/slab.h:1077 [inline]
    __get_vm_area_node+0xc6/0x1d0 mm/vmalloc.c:3215
    __vmalloc_node_range_noprof+0x1bc/0xdf0 mm/vmalloc.c:4024
    __vmalloc_node_noprof+0x71/0x90 mm/vmalloc.c:4124
    alloc_thread_stack_node kernel/fork.c:357 [inline]
    dup_task_struct kernel/fork.c:926 [inline]
    copy_process+0x51f/0x2c90 kernel/fork.c:2090
    kernel_clone+0xde/0x700 kernel/fork.c:2721
    kernel_thread+0x80/0xb0 kernel/fork.c:2782
    create_kthread kernel/kthread.c:459 [inline]
    kthreadd+0x186/0x250 kernel/kthread.c:817
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888100f8fa00 (size 512):
  comm "kworker/1:1", pid 41, jiffies 4294937424
  hex dump (first 32 bytes):
    38 42 0d 30 81 88 ff ff e0 13 ad 81 ff ff ff ff  8B.0............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 185e046f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __do_kmalloc_node mm/slub.c:5294 [inline]
    __kmalloc_noprof+0x3b7/0x550 mm/slub.c:5307
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2768
    alloc_empty_sheaf mm/slub.c:2783 [inline]
    __pcs_replace_full_main+0xdf/0x300 mm/slub.c:5761
    free_to_pcs mm/slub.c:5814 [inline]
    slab_free mm/slub.c:6253 [inline]
    kfree+0x361/0x3a0 mm/slub.c:6565
    vfree mm/vmalloc.c:3476 [inline]
    vfree+0x14d/0x3d0 mm/vmalloc.c:3436
    delayed_vfree_work+0x29/0x40 mm/vmalloc.c:3392
    process_one_work+0x277/0x5b0 kernel/workqueue.c:3302
    process_scheduled_works kernel/workqueue.c:3385 [inline]
    worker_thread+0x255/0x4a0 kernel/workqueue.c:3466
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88810255bc00 (size 512):
  comm "kworker/u8:2", pid 498, jiffies 4294937434
  hex dump (first 32 bytes):
    80 35 67 2e 81 88 ff ff e0 13 ad 81 ff ff ff ff  .5g.............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 804b7261):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __do_kmalloc_node mm/slub.c:5294 [inline]
    __kmalloc_noprof+0x3b7/0x550 mm/slub.c:5307
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2768
    alloc_empty_sheaf mm/slub.c:2783 [inline]
    __pcs_replace_full_main+0xdf/0x300 mm/slub.c:5761
    free_to_pcs mm/slub.c:5814 [inline]
    slab_free mm/slub.c:6253 [inline]
    kfree+0x361/0x3a0 mm/slub.c:6565
    call_usermodehelper_freeinfo kernel/umh.c:43 [inline]
    umh_complete kernel/umh.c:57 [inline]
    call_usermodehelper_exec_async+0x1c7/0x1f0 kernel/umh.c:119
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88810256da00 (size 512):
  comm "kworker/0:1", pid 10, jiffies 4294937506
  hex dump (first 32 bytes):
    40 40 38 2d 81 88 ff ff e0 13 ad 81 ff ff ff ff  @@8-............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc e83216dd):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __do_kmalloc_node mm/slub.c:5294 [inline]
    __kmalloc_noprof+0x3b7/0x550 mm/slub.c:5307
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2768
    alloc_empty_sheaf mm/slub.c:2783 [inline]
    __pcs_replace_full_main+0xdf/0x300 mm/slub.c:5761
    free_to_pcs mm/slub.c:5814 [inline]
    slab_free mm/slub.c:6253 [inline]
    kfree+0x361/0x3a0 mm/slub.c:6565
    blk_free_flush_queue+0x28/0x40 block/blk-flush.c:514
    srcu_invoke_callbacks+0x11a/0x1c0 kernel/rcu/srcutree.c:1917
    process_one_work+0x277/0x5b0 kernel/workqueue.c:3302
    process_scheduled_works kernel/workqueue.c:3385 [inline]
    worker_thread+0x255/0x4a0 kernel/workqueue.c:3466
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff8881069d1400 (size 512):
  comm "kworker/0:1", pid 10, jiffies 4294937917
  hex dump (first 32 bytes):
    78 b7 d0 2f 81 88 ff ff e0 13 ad 81 ff ff ff ff  x../............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 927c2de1):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __do_kmalloc_node mm/slub.c:5294 [inline]
    __kmalloc_noprof+0x3b7/0x550 mm/slub.c:5307
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2768
    alloc_empty_sheaf mm/slub.c:2783 [inline]
    __pcs_replace_full_main+0xdf/0x300 mm/slub.c:5761
    free_to_pcs mm/slub.c:5814 [inline]
    slab_free mm/slub.c:6253 [inline]
    kfree+0x361/0x3a0 mm/slub.c:6565
    vfree mm/vmalloc.c:3476 [inline]
    vfree+0x14d/0x3d0 mm/vmalloc.c:3436
    delayed_vfree_work+0x29/0x40 mm/vmalloc.c:3392
    process_one_work+0x277/0x5b0 kernel/workqueue.c:3302
    process_scheduled_works kernel/workqueue.c:3385 [inline]
    worker_thread+0x255/0x4a0 kernel/workqueue.c:3466
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


Tested on:

commit:         c7e4e4d5 Merge tag 'for-linus-7.1-2' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16963a36580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9645c21cfd1d3e8f
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1650eb26580000

