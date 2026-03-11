Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78BC3A383F
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 11:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773226988; cv=none; b=I3XnySliyUmmQU418RPDbCx7MlGz1EsPcO9TZ5zfR2w9WEhvC9kPvJgo4b0zVIuUbHEcyFzAYySt0bWQJPMcKGsjdlBT6ZKiDXS0AYMoiRDi4fgoTebXhwzvPN8VXGOCtp3tz9cfJPUguQv7Kuo105ejqaARwrh3Ammodeq+NK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773226988; c=relaxed/simple;
	bh=GzBNSvQDgN4Gylhx3fqfNEKjHrAbaXLxx+o0FNemOuY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dg+d6t5cRdrUIFlQyA/tzIBeG4Dxtfs2n4nR8nR7ZOe/qOlw9EeWqdG3iklxOyVWkXvH813Du6fG2s3kjXzUfPMdChQArwf/SrKzN/GgGH/kHq5fOwgNEIdCsUHlr4rjjeqUTasFSmemJcmFmweHQHkAyKD61EEwhpEBNznXGKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-67bbb814617so12896919eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 04:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773226986; x=1773831786;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00o6g65oUdrN243+trpF7SWGsKEiuTr8VPwUn01kWqM=;
        b=K1dIQh4P/Vq+BVSpWjK4Ij4edZZe8HeZDyI3PzEsDU8o98BCwsr1fYhceKp/8GjY8h
         GUBDejYCf3LS/r/T8SAhtCEeOM6DscfQzOKalk3UWP9FwcJyz4CFXpBMzB/upj7wCADw
         4BfOsF1wTd/2LAouOC8mJpFVpMgiQ8SH3OD9wvYPpJKTWHaLoMujlVSHYpt8Xn5u0GPZ
         ezKHxXkUmdHX3ZPDIxRhDpuik0/rJNgxmyPhAh+fjUG39GEh61YD2/k35ZPhsz6WE0Yj
         Q8AB+iAlI2ojdyXwCOSUKGgxCzA8eNT1cRm2NDAwM2FGFj8JB6qtwoOLby8zrACLvfaq
         v+iw==
X-Forwarded-Encrypted: i=1; AJvYcCULOphXitl1rGGir0HeFRrdZ866uwVyvts6txoNWRj1UB3EshJCjZ4jTvrm9KqXqE9uuRqWcQnkHpr/KBRK@vger.kernel.org
X-Gm-Message-State: AOJu0YxNfC4QVNUMYdyiaZoxqkN/Cio9JQdVX9J2hPodGZ8sIlKLmMUV
	Ihn6ZdRiP+UDSTZynFhOP1LnkOQDKj2hdYZkHfsK/hIQ+umIFEI+pMkiBn/hrk5KuYBEZiZDM1z
	kZizH4NcLn80JBLlsSieYQzArstQby72ENRD00OK0m0/0NTcGJ2JNX9fXShE=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c9e:b0:67b:b63b:6fe4 with SMTP id
 006d021491bc7-67bbc7330d5mr4435697eaf.19.1773226985864; Wed, 11 Mar 2026
 04:03:05 -0700 (PDT)
Date: Wed, 11 Mar 2026 04:03:05 -0700
In-Reply-To: <20260311104855.102050-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b14be9.050a0220.209d0e.0001.GAE@google.com>
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
From: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chao@kernel.org, jaegeuk@kernel.org, 
	jannh@google.com, liam.howlett@oracle.com, linkinjeon@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	pfalcato@suse.de, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in __pcs_replace_empty_main

BUG: memory leak
unreferenced object 0xffff88810005f800 (size 512):
  comm "swapper/0", pid 0, jiffies 4294937296
  hex dump (first 32 bytes):
    18 ca 17 2e 81 88 ff ff 00 b6 ad 81 ff ff ff ff  ................
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 9b7d1e76):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4550 [inline]
    slab_alloc_node mm/slub.c:4873 [inline]
    __do_kmalloc_node mm/slub.c:5266 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5279
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    alloc_full_sheaf mm/slub.c:2836 [inline]
    __pcs_replace_empty_main+0x1e0/0x2f0 mm/slub.c:4633
    alloc_from_pcs mm/slub.c:4724 [inline]
    slab_alloc_node mm/slub.c:4858 [inline]
    __kmalloc_cache_noprof+0x3ac/0x480 mm/slub.c:5382
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
  comm "kthreadd", pid 2, jiffies 4294937344
  hex dump (first 32 bytes):
    08 5e e1 28 81 88 ff ff 00 b6 ad 81 ff ff ff ff  .^.(............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 89324f2):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4550 [inline]
    slab_alloc_node mm/slub.c:4873 [inline]
    __do_kmalloc_node mm/slub.c:5266 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5279
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    alloc_full_sheaf mm/slub.c:2836 [inline]
    __pcs_replace_empty_main+0x1e0/0x2f0 mm/slub.c:4633
    alloc_from_pcs mm/slub.c:4724 [inline]
    slab_alloc_node mm/slub.c:4858 [inline]
    __kmalloc_cache_node_noprof+0x3ef/0x4e0 mm/slub.c:5395
    kmalloc_node_noprof include/linux/slab.h:1077 [inline]
    __get_vm_area_node+0xc6/0x1d0 mm/vmalloc.c:3221
    __vmalloc_node_range_noprof+0x1d3/0xe50 mm/vmalloc.c:4024
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
unreferenced object 0xffff8881023c6800 (size 512):
  comm "kworker/u8:3", pid 829, jiffies 4294937473
  hex dump (first 32 bytes):
    00 56 0a 2b 81 88 ff ff 00 fe 03 2b 81 88 ff ff  .V.+.......+....
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 175b82b9):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4550 [inline]
    slab_alloc_node mm/slub.c:4873 [inline]
    __do_kmalloc_node mm/slub.c:5266 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5279
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5729
    free_to_pcs mm/slub.c:5782 [inline]
    slab_free mm/slub.c:6177 [inline]
    kfree+0x352/0x390 mm/slub.c:6490
    call_usermodehelper_freeinfo kernel/umh.c:43 [inline]
    umh_complete kernel/umh.c:57 [inline]
    call_usermodehelper_exec_async+0x1c7/0x1f0 kernel/umh.c:119
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff8881023e9000 (size 512):
  comm "kworker/0:1", pid 10, jiffies 4294937519
  hex dump (first 32 bytes):
    e0 52 f6 28 81 88 ff ff 00 b6 ad 81 ff ff ff ff  .R.(............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc d8ec9e0d):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4550 [inline]
    slab_alloc_node mm/slub.c:4873 [inline]
    __do_kmalloc_node mm/slub.c:5266 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5279
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5729
    free_to_pcs mm/slub.c:5782 [inline]
    slab_free mm/slub.c:6177 [inline]
    kfree+0x352/0x390 mm/slub.c:6490
    blk_free_flush_queue+0x28/0x40 block/blk-flush.c:514
    srcu_invoke_callbacks+0x11a/0x1c0 kernel/rcu/srcutree.c:1941
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888104850a00 (size 512):
  comm "kworker/0:1", pid 10, jiffies 4294937528
  hex dump (first 32 bytes):
    00 6c 8f 00 81 88 ff ff 00 10 0a 2b 81 88 ff ff  .l.........+....
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc c75772dc):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4550 [inline]
    slab_alloc_node mm/slub.c:4873 [inline]
    __do_kmalloc_node mm/slub.c:5266 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5279
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5729
    free_to_pcs mm/slub.c:5782 [inline]
    slab_free mm/slub.c:6177 [inline]
    kfree+0x352/0x390 mm/slub.c:6490
    blk_free_flush_queue+0x28/0x40 block/blk-flush.c:514
    srcu_invoke_callbacks+0x11a/0x1c0 kernel/rcu/srcutree.c:1941
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888104850800 (size 512):
  comm "kworker/0:1", pid 10, jiffies 4294937528
  hex dump (first 32 bytes):
    18 6a 89 26 81 88 ff ff 00 b6 ad 81 ff ff ff ff  .j.&............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 1ece07b3):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4550 [inline]
    slab_alloc_node mm/slub.c:4873 [inline]
    __do_kmalloc_node mm/slub.c:5266 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5279
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5729
    free_to_pcs mm/slub.c:5782 [inline]
    slab_free mm/slub.c:6177 [inline]
    kfree+0x352/0x390 mm/slub.c:6490
    vfree.part.0+0x1d5/0x4d0 mm/vmalloc.c:3485
    vfree mm/vmalloc.c:3456 [inline]
    delayed_vfree_work+0x5b/0x90 mm/vmalloc.c:3398
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


Tested on:

commit:         b29fb882 Merge tag 'v7.0-rc3-ksmbd-server-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fb694a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c6ad6fefffa76b1
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14023016580000

