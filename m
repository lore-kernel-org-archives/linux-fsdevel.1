Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4192282F04
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 07:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777792624; cv=none; b=Ehzo11ZivMS/Jz8d4D/9Cc3u/M2H8BjPke1Hgrv4a7LiU4QPjzzKdUAWrWlOBHAmXvjIj8VdLf5Neu22exuw6MVDk4op11uf7ehBxBIx8DINEk7Lztq+P2pF2lMkJBzLmMYHW2J4YKaGqsaAMY0S/0TZkuRrJOwuTyTYUB2ADjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777792624; c=relaxed/simple;
	bh=dqUieI8Kr9p6srJiGx0+pY67OmzHqv9NA9xPU7J5Tk0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KGVu86TfvXwI0T64kLLH0SutclUqUmuVWDwtoPpEWArFaNbEJTAhljhcyZXHBlgflDvdQ31BzTE9N4I+UeSL5D6YwZBEzB3euki43odVY4sCoQXs7cIm7x2cG0lXOzuUddgsDatuQd6NX/Lw3/KtfYVtSsfebqmHaU9oraTKBkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7dbe76e3abcso9461334a34.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 00:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777792622; x=1778397422;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBJ+nqiJeCAh7ANanxHfUmzC7i4o2jYq4KYC2pamiXg=;
        b=nL5bLUfJVhDH2rAVgBW5u8uqBwGXv4X+B209s+MgHOtr51lPwbTPL8BilzMwG+rlAb
         Z89Qci5D2Upv0uORD7mMisRd/K0ZgCGYjqo4J9BnCBa7lf2KATvELHxCIQzQ5VragrmQ
         9dLoSKU9i0RbCrjMBGLzA+SAeaR3TSxVtUb+h73v6M2B474y4viReK2Y9NWLHTewnFOd
         mIlgsYBBIWjYUHhL1BSO8J1ODmsdnwBqqHXmF1TxNsvApHKhqCRFfegvLjOZ3byCHVjY
         GHOMatvWVIDgi+ZBj6Zx+MOgQt235GplKZ9IbfEqKLucpq6DjO3QDAMD8vnUgfifNbII
         xlYg==
X-Forwarded-Encrypted: i=1; AFNElJ946N/rpgOzzaD4HmbFAwhEJLKY4q8jHz5tLCmw+oJSu5LswUUEGC3dHuYrvMSEN/XV8GtSGiJXON5S8Y7g@vger.kernel.org
X-Gm-Message-State: AOJu0YwL9kAfTsrhJGRq/Bg2MHB5ju/y7kjTkrKACIJPQhkSwau4ukYI
	IhwgF1wr20BjLaPJl4XVbJz/T5mpzCqUIQTdGUcK3JRMYhxlDVqWy0WBplitja7ANfKmml1HcGH
	JQUoZa53UZaPEtsO3N+jUVpO8VUX2ZGifPf/fMEn1BeWh2p6tU2frbUhr4wg=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:210e:b0:696:2674:8a18 with SMTP id
 006d021491bc7-69697c50cbcmr2729750eaf.35.1777792621895; Sun, 03 May 2026
 00:17:01 -0700 (PDT)
Date: Sun, 03 May 2026 00:17:01 -0700
In-Reply-To: <4b30ba28-6f75-43a1-a108-5c0288ab021a@dev.snart.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f6f66d.050a0220.312cd3.002c.GAE@google.com>
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
    e0 e2 ee 2c 81 88 ff ff a0 13 ad 81 ff ff ff ff  ...,............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 2486057c):
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
    __kmalloc_cache_noprof+0x3a6/0x480 mm/slub.c:5410
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
unreferenced object 0xffff888101d04e00 (size 512):
  comm "kworker/u8:5", pid 311, jiffies 4294937428
  hex dump (first 32 bytes):
    b8 1c b8 28 81 88 ff ff a0 13 ad 81 ff ff ff ff  ...(............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 1d48d83d):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __do_kmalloc_node mm/slub.c:5294 [inline]
    __kmalloc_noprof+0x3b7/0x550 mm/slub.c:5307
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2768
    alloc_empty_sheaf mm/slub.c:2783 [inline]
    __pcs_replace_full_main+0xdf/0x300 mm/slub.c:5757
    free_to_pcs mm/slub.c:5810 [inline]
    slab_free mm/slub.c:6249 [inline]
    kfree+0x361/0x3a0 mm/slub.c:6561
    call_usermodehelper_freeinfo kernel/umh.c:43 [inline]
    umh_complete kernel/umh.c:57 [inline]
    call_usermodehelper_exec_async+0x1c7/0x1f0 kernel/umh.c:119
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888101d18800 (size 512):
  comm "kworker/0:1", pid 10, jiffies 4294937813
  hex dump (first 32 bytes):
    00 c8 ec 0b 81 88 ff ff 00 18 d3 0b 81 88 ff ff  ................
    00 12 04 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc 307f46be):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __do_kmalloc_node mm/slub.c:5294 [inline]
    __kmalloc_noprof+0x3b7/0x550 mm/slub.c:5307
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2768
    alloc_empty_sheaf mm/slub.c:2783 [inline]
    __pcs_replace_full_main+0xdf/0x300 mm/slub.c:5757
    free_to_pcs mm/slub.c:5810 [inline]
    slab_free mm/slub.c:6249 [inline]
    kfree+0x361/0x3a0 mm/slub.c:6561
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
unreferenced object 0xffff888101d2be00 (size 512):
  comm "kworker/0:1", pid 10, jiffies 4294937856
  hex dump (first 32 bytes):
    c8 2c 04 00 81 88 ff ff 00 90 b7 2a 81 88 ff ff  .,.........*....
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 9ff75ca2):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __do_kmalloc_node mm/slub.c:5294 [inline]
    __kmalloc_noprof+0x3b7/0x550 mm/slub.c:5307
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2768
    alloc_empty_sheaf mm/slub.c:2783 [inline]
    __pcs_replace_full_main+0xdf/0x300 mm/slub.c:5757
    free_to_pcs mm/slub.c:5810 [inline]
    slab_free mm/slub.c:6249 [inline]
    kfree+0x361/0x3a0 mm/slub.c:6561
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
unreferenced object 0xffff888101d2b000 (size 512):
  comm "kworker/u8:9", pid 4643, jiffies 4294937873
  hex dump (first 32 bytes):
    00 72 5a 03 81 88 ff ff c8 2c 04 00 81 88 ff ff  .rZ......,......
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc bcccad5b):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4574 [inline]
    slab_alloc_node mm/slub.c:4898 [inline]
    __do_kmalloc_node mm/slub.c:5294 [inline]
    __kmalloc_noprof+0x3b7/0x550 mm/slub.c:5307
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2768
    alloc_empty_sheaf mm/slub.c:2783 [inline]
    __pcs_replace_full_main+0xdf/0x300 mm/slub.c:5757
    free_to_pcs mm/slub.c:5810 [inline]
    slab_free mm/slub.c:6249 [inline]
    kfree+0x361/0x3a0 mm/slub.c:6561
    call_usermodehelper_freeinfo kernel/umh.c:43 [inline]
    umh_complete kernel/umh.c:57 [inline]
    call_usermodehelper_exec_async+0x1c7/0x1f0 kernel/umh.c:119
    ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff8881035a7400 (size 512):
  comm "udevadm", pid 4981, jiffies 4294938333
  hex dump (first 32 bytes):
    00 88 b7 2a 81 88 ff ff 00 4e d0 01 81 88 ff ff  ...*.....N......
    00 12 04 00 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace (crc 82d289ee):
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
    __kmalloc_cache_noprof+0x3a6/0x480 mm/slub.c:5410
    kmalloc_noprof include/linux/slab.h:950 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    kernfs_get_open_node fs/kernfs/file.c:543 [inline]
    kernfs_fop_open+0x4f4/0x580 fs/kernfs/file.c:718
    do_dentry_open+0x1fc/0x8c0 fs/open.c:947
    vfs_open+0x3d/0x1b0 fs/open.c:1079
    do_open fs/namei.c:4699 [inline]
    path_openat+0x154d/0x1e20 fs/namei.c:4858
    do_file_open+0x121/0x200 fs/namei.c:4887
    do_sys_openat2+0xa5/0x140 fs/open.c:1364
    do_sys_open fs/open.c:1370 [inline]
    __do_sys_openat fs/open.c:1386 [inline]
    __se_sys_openat fs/open.c:1381 [inline]
    __x64_sys_openat+0x82/0xf0 fs/open.c:1381
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xee/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


Tested on:

commit:         66edb901 Merge tag 'v7.1-p3' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13db0ad2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9645c21cfd1d3e8f
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=153b7ece580000

