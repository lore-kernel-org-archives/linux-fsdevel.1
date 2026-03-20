Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602E38F63D
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 10:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774002844; cv=none; b=IsSlP4HAtHGWqm07HsnhGOop0kmbKE1zD7X5Yo0J5VuC3ZsEMmtAMksRFcRyIQFahiGfTTvV6TIb1o+0h7Z9KG7pMYM7PDa4m52mXq4ZmRFV4OqLrGdgoff812jl3f/oY7pRjnrGCSmVNi3UtmXcPmLeUxotIXfVBLlEKcSTs+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774002844; c=relaxed/simple;
	bh=rzZaQLfEDUrBFZYBdtxge1aiSCig8HiSRfi7DP5KHVM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Fm6bf/pQUh8ntlbkWd2U1gpNtiKqbP+HNRQPhBsSb3DDnsWCKvRJIqTJphGfqamFIUh75KYSOyI8HujiqJY4Q2q3z4FfXkyn5n1Hwqj6A8x4L+cJqRf+Sz8+z9WBncQz6NPP8vLF83N8j/Ry4DAI4SJEr6EAq6dUcbHVtLnaeP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d7e0787438so1920418a34.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 03:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774002842; x=1774607642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PyurhFL0srbaHFfNujAbyanPsO6WBW5rLYYsYSOSV7A=;
        b=XxC5UjgJshqYn9jjCANCRHAIm9xVb8r7eC2qsjNxqsunruM91sYcUQ9HtGsA6isPhJ
         lvuMxlk0ywHIXelrHWJ8k9jjrESC3k6Ah9kveQBw3AuLVD7MTqGMixybc1t4NYU7CNWb
         pRWmG1e7mV6vxe3IT8OoqKsHdJounDV2lE/mbQSjHJOzU21hTlvOC9T6HRHGVMn0kQVo
         OSFC4LmMTRKlEyil7UDthvyyLW7YFyGvQmSXEDCJ2UCNXwkfyn9hzQ4eA6firSJkXb7n
         d1OAsFMM2sZbXm3LU/weQ1EzilVz40FvNz844S9Og7eDG7jpf7HrNNhXrkfH6IwLL2Yj
         om2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoHYMOpbxOmxCjxyJFQx03WBnt0A1g7YbfGZ8F5eMbqAEPzzhK5zIcIcmHLQPKXrX6scxEraEPqGtTS4cZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx0F6Lp7bNga2e8nDhg1aJhAOhwoddzDmau0drk8s9PVq8lHNW
	LBHEllEPYnwG3QnI3OnkwAO8QqloDNWe65l+FjaOOgTFJH2wplisHYdcPCqZNMR1mb15Gc6oyHY
	veKJeUkpt48eRjqR7htX7jt6EMEhNVb4dNLt6PBGP5yfysONUkJw/ONFGbvY=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:818b:b0:67b:e3cf:a416 with SMTP id
 006d021491bc7-67c22ec467emr1960545eaf.25.1774002842204; Fri, 20 Mar 2026
 03:34:02 -0700 (PDT)
Date: Fri, 20 Mar 2026 03:34:02 -0700
In-Reply-To: <abyPiI_4bCRGQLBV@hyeyoo>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69bd229a.050a0220.3bf4de.001c.GAE@google.com>
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
From: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chao@kernel.org, harry.yoo@oracle.com, 
	jaegeuk@kernel.org, jannh@google.com, liam.howlett@oracle.com, 
	linkinjeon@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, pfalcato@suse.de, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in __pcs_replace_empty_main

BUG: memory leak
unreferenced object 0xffff88810005f800 (size 512):
  comm "swapper/0", pid 0, jiffies 4294937296
  hex dump (first 32 bytes):
    60 bd 2a 2f 81 88 ff ff 30 ba ad 81 ff ff ff ff  `.*/....0.......
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 81834c79):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4543 [inline]
    slab_alloc_node mm/slub.c:4866 [inline]
    __do_kmalloc_node mm/slub.c:5259 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5272
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2764
    alloc_empty_sheaf mm/slub.c:2779 [inline]
    alloc_full_sheaf mm/slub.c:2829 [inline]
    __pcs_replace_empty_main+0x1e0/0x2f0 mm/slub.c:4626
    alloc_from_pcs mm/slub.c:4717 [inline]
    slab_alloc_node mm/slub.c:4851 [inline]
    __kmalloc_cache_noprof+0x3ac/0x480 mm/slub.c:5375
    kmalloc_noprof include/linux/slab.h:950 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __irq_domain_alloc_fwnode+0x37/0x140 kernel/irq/irqdomain.c:95
    irq_domain_alloc_named_fwnode include/linux/irqdomain.h:271 [inline]
    arch_early_irq_init+0x1c/0x70 arch/x86/kernel/apic/vector.c:803
    start_kernel+0x931/0xb80 init/main.c:1114
    x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
    x86_64_start_kernel+0xce/0xd0 arch/x86/kernel/head64.c:291
    common_startup_64+0x13e/0x148

BUG: memory leak
unreferenced object 0xffff8881008f6c00 (size 512):
  comm "kthreadd", pid 2, jiffies 4294937342
  hex dump (first 32 bytes):
    d0 16 c9 29 81 88 ff ff 30 ba ad 81 ff ff ff ff  ...)....0.......
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 38b48d73):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4543 [inline]
    slab_alloc_node mm/slub.c:4866 [inline]
    __do_kmalloc_node mm/slub.c:5259 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5272
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2764
    alloc_empty_sheaf mm/slub.c:2779 [inline]
    alloc_full_sheaf mm/slub.c:2829 [inline]
    __pcs_replace_empty_main+0x1e0/0x2f0 mm/slub.c:4626
    alloc_from_pcs mm/slub.c:4717 [inline]
    slab_alloc_node mm/slub.c:4851 [inline]
    __kmalloc_cache_node_noprof+0x3ef/0x4e0 mm/slub.c:5388
    kmalloc_node_noprof include/linux/slab.h:1077 [inline]
    __get_vm_area_node+0xc6/0x1d0 mm/vmalloc.c:3221
    __vmalloc_node_range_noprof+0x1d3/0xe50 mm/vmalloc.c:4024
    __vmalloc_node_noprof+0x71/0x90 mm/vmalloc.c:4124
    alloc_thread_stack_node kernel/fork.c:355 [inline]
    dup_task_struct kernel/fork.c:924 [inline]
    copy_process+0x3e5/0x28c0 kernel/fork.c:2050
    kernel_clone+0xac/0x6e0 kernel/fork.c:2653
    kernel_thread+0x80/0xb0 kernel/fork.c:2714
    create_kthread kernel/kthread.c:459 [inline]
    kthreadd+0x186/0x250 kernel/kthread.c:817
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888102011400 (size 512):
  comm "kworker/u8:1", pid 274, jiffies 4294937433
  hex dump (first 32 bytes):
    28 f6 7b 31 81 88 ff ff 30 ba ad 81 ff ff ff ff  (.{1....0.......
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc c5ce2dfb):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4543 [inline]
    slab_alloc_node mm/slub.c:4866 [inline]
    __do_kmalloc_node mm/slub.c:5259 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5272
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2764
    alloc_empty_sheaf mm/slub.c:2779 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5722
    free_to_pcs mm/slub.c:5775 [inline]
    slab_free mm/slub.c:6170 [inline]
    kfree+0x352/0x390 mm/slub.c:6483
    call_usermodehelper_freeinfo kernel/umh.c:43 [inline]
    umh_complete kernel/umh.c:57 [inline]
    call_usermodehelper_exec_async+0x1c7/0x1f0 kernel/umh.c:119
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888102010600 (size 512):
  comm "kworker/1:1", pid 41, jiffies 4294937437
  hex dump (first 32 bytes):
    88 c3 c4 29 81 88 ff ff 30 ba ad 81 ff ff ff ff  ...)....0.......
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 5d48f1c0):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4543 [inline]
    slab_alloc_node mm/slub.c:4866 [inline]
    __do_kmalloc_node mm/slub.c:5259 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5272
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2764
    alloc_empty_sheaf mm/slub.c:2779 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5722
    free_to_pcs mm/slub.c:5775 [inline]
    slab_free mm/slub.c:6170 [inline]
    kfree+0x352/0x390 mm/slub.c:6483
    vfree.part.0+0x1d5/0x4d0 mm/vmalloc.c:3485
    vfree mm/vmalloc.c:3456 [inline]
    delayed_vfree_work+0x5b/0x90 mm/vmalloc.c:3398
    process_one_work+0x277/0x5f0 kernel/workqueue.c:3276
    process_scheduled_works kernel/workqueue.c:3359 [inline]
    worker_thread+0x255/0x4a0 kernel/workqueue.c:3440
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888102010400 (size 512):
  comm "kworker/u8:1", pid 443, jiffies 4294937439
  hex dump (first 32 bytes):
    e8 50 dd 31 81 88 ff ff 30 ba ad 81 ff ff ff ff  .P.1....0.......
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 11032afc):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4543 [inline]
    slab_alloc_node mm/slub.c:4866 [inline]
    __do_kmalloc_node mm/slub.c:5259 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5272
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2764
    alloc_empty_sheaf mm/slub.c:2779 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5722
    free_to_pcs mm/slub.c:5775 [inline]
    slab_free mm/slub.c:6170 [inline]
    kfree+0x352/0x390 mm/slub.c:6483
    call_usermodehelper_freeinfo kernel/umh.c:43 [inline]
    umh_complete kernel/umh.c:57 [inline]
    call_usermodehelper_exec_async+0x1c7/0x1f0 kernel/umh.c:119
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff8881095d5a00 (size 256):
  comm "swapper/0", pid 1, jiffies 4294937857
  hex dump (first 32 bytes):
    00 d4 9c 1d 81 88 ff ff 88 fc 04 00 81 88 ff ff  ................
    00 1a 04 00 81 88 ff ff 1c 00 00 00 00 00 00 00  ................
  backtrace (crc deebd371):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4543 [inline]
    slab_alloc_node mm/slub.c:4866 [inline]
    __do_kmalloc_node mm/slub.c:5259 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5272
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2764
    alloc_empty_sheaf mm/slub.c:2779 [inline]
    alloc_full_sheaf mm/slub.c:2829 [inline]
    __pcs_replace_empty_main+0x1e0/0x2f0 mm/slub.c:4626
    alloc_from_pcs mm/slub.c:4717 [inline]
    slab_alloc_node mm/slub.c:4851 [inline]
    __kmalloc_cache_noprof+0x3ac/0x480 mm/slub.c:5375
    kmalloc_noprof include/linux/slab.h:950 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    init_srcu_struct_fields+0x29d/0x320 kernel/rcu/srcutree.c:241
    rtnl_link_register+0x81/0x1c0 net/core/rtnetlink.c:615
    ipgre_init+0x10d/0x1a0 net/ipv4/ip_gre.c:1828
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

commit:         0e4f8f1a Merge tag 'parisc-for-7.0-rc5' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b18cba580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2bba615ee79faa5
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12608cba580000

