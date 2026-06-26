Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4FF3BFAE8
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 21:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782509364; cv=none; b=CJnNDNebkXHZo91K0/Io4tXtnK0Rx3iBiy8tTJXxZpyo4zmRTf8HhQAoPl7HZ4DyV+RUQifqrvOW31HCkPSKRuuOjQsmZe+5PfdP81ICZan4dpcmr3s6BnbiT1KGfsT7rRc1hkm/9JowFM3XDod2jgGivICNY52YJtX4Ecxq0ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782509364; c=relaxed/simple;
	bh=MfRUoW40kmaGb7J8m493jgh1oUZJuT1eUEhly6771Vk=;
	h=Message-ID:Date:Subject:To:Cc:Content-Type:MIME-Version:From; b=UzouCt2eq5smTr3+SmbrnZQnuA7sU8aZCYupVmBJUKTL7EgDQYfk9eedINi+bFuNYXhf6lB37Mgwx5V9FItWORDsZJ7J4f/2d9HQKhdrN+3UbKp9hYabKgOQS0EJowV7lKnGg12Q3c2/I63LPXbEOS2HVqfoRCI3mnS87aVGSBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3qFyB9o; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3qFyB9o"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5bd7309b0ccso34910e0c.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782509362; x=1783114162; darn=vger.kernel.org;
        h=from:mime-version:content-transfer-encoding:content-type:cc:to
         :subject:date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLwRtPkE1smI4SHyJ30puDqc6wL0+REZ1BEFcC6DVk8=;
        b=g3qFyB9oK6DJuYVVJk1xbl8PWSK96bek62QasB5sqTV6XaF7zwcnO0YUT8Z4H+HCsA
         aYZwR8qnTjzbEhDe9dBl62bzGLy/8US6EMVq0QAw1S7BYVs6pngiVK+slzMNFynjqXe4
         rfoWQDIIMFBwphy1M/Myj2EvR86DsRgPSuM4CrspTq550xPhAtw1bz2MOYJpzWU3ZUbV
         KmfU2BkQ3AOa7dPS9i39U3zLqoZ6Ny7gDnJ8C0N/qg1oOf6J8dV6y0EOz2jGrTm4bL24
         fozIwk3vL0xJQ8G6ZEwvh6ftjrL5Vn+LfTxfJKA2OxZ5P2KURkYahTOnFbUAVIJ+dR7/
         nnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782509362; x=1783114162;
        h=from:mime-version:content-transfer-encoding:content-type:cc:to
         :subject:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XLwRtPkE1smI4SHyJ30puDqc6wL0+REZ1BEFcC6DVk8=;
        b=NRxoKLr9C2pPUUskMwACQIQqF4RRLBzjtLVdKd3ECTLYRUh+3olYRbwvkgp+u2OwAE
         iQL9K54S8E+a8bs4u1gltMQnUZdG46ys1kSJ0fFLxR9kr9lmuqNuDEi1zIDpd1tPeoKS
         izZdztXaBjAascTDyzCzVDCasMEMRay+LR4m9BnAEq0O3mN4zLz9xYMBpxzL02VQoRVj
         0cYL2//veGembuhdTZUQVWLp8nzBB9hCUA+69uLtx1Wa6IbaKItFIC0nb7VUzGQxPrxJ
         tHcUV7SakuTnsK+xCFN/0dNBQvkVMXvlD9GeGPexuu0qmFdxSRsveVzIbcCAvSR/vd/X
         scUg==
X-Forwarded-Encrypted: i=1; AHgh+RpIoPXbTZMvd2e0o6Rcgy77MrJeZzMrVUQHp5YnWJNxsfqzYGCKHS53SrNQCJOXphNh7ed4pvSlJhAiZQov@vger.kernel.org
X-Gm-Message-State: AOJu0YwTo7Uisb5F4GZdlJLBYOHun4TjI3ip0z8VhUSMiykgnRlsMRgj
	7EMB8njHZlgB0R2Lu3zbjJ6FYtw6xm3JQ033vTXGx6vf4gb8bWh9IWdx
X-Gm-Gg: AfdE7cntwcIWHP3u6radu7keGzaXDFutaZc4ROgvjyrHLzK3cU3JcPnnuCRaYJFvWM6
	PD9Cck8yzaMRZI6Bg7bAiKV/cGY+2SGgqh7jvgBgkLscHXlF0US/32AGSBe8OUmi82qYDlVhgdk
	GGdODhocuM0bHyYFzRIvwWC6jsioTpQoyICC0/xM3YXP/ccB9H1OveTUHk6glA5NKWSz140asKr
	f1nwb2m0i25Z2v4OaXKNso7aeq0q1pjcoQLAe/7nPYpn3NmxwB5FH3rrNARLgDowvE2qDOTET3e
	eSKn0x00V7eKoQx/YuPSzBzE2Y5xoXVPgaEcb5Zt4EqVQAbxzNYYSaftlQYQFJ0eg6SDNOPp8yv
	KF84jqNe6pJpg+yhVV2FFAaEJ4k74PPAK7a9Ye9uqfoF0ds0njnA3tpoVSrEWEFnuxBwrC+2xZy
	mBWVN8nO6KbqzUO2tu17hoq431iKZUYo8ZeQHebKzc7IbfvMqJJ1F88BUnWSPJklYU/G9Hqaxhs
	5nG3/wM2wb+9Z4ekSpamMA=
X-Received: by 2002:a05:6122:2bc9:b0:59b:96df:f92b with SMTP id 71dfb90a1353d-5bd69e016e8mr1043272e0c.3.1782509361583;
        Fri, 26 Jun 2026 14:29:21 -0700 (PDT)
Received: from [192.168.10.115] ([132.170.207.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bd78e4c6c0sm1887501e0c.3.2026.06.26.14.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:29:21 -0700 (PDT)
Message-ID: <6a3eef31.2bc1d9cf.3ebea.506b@mx.google.com>
Date: Fri, 26 Jun 2026 14:29:21 -0700 (PDT)
Subject: KASAN: slab-use-after-free Read in fserror_worker
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, contact@pgazz.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: sanan.hasanou@gmail.com

Good day, dear maintainers,

We found a bug using a modified version of syzkaller.

Kernel Branch: 7.0-rc1
Kernel Config: <https://drive.google.com/open?id=1dd0qteaHHIsE3puUVyWFoRLtF4bP2IOy>
Unfortunately, we don't have any reproducer for this bug yet.
Thank you!

Best regards,
Sanan Hasanov

==================================================================
BUG: KASAN: slab-use-after-free in inode_state_read_once include/linux/fs.h:884 [inline]
BUG: KASAN: slab-use-after-free in iput+0x34c/0xc60 fs/inode.c:1986
Read of size 4 at addr ffff888066ffafb8 by task kworker/0:1/448004

CPU: 0 UID: 0 PID: 448004 Comm: kworker/0:1 Tainted: G             L      7.0.0-rc1 #1 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: events fserror_worker
Call Trace:
 <TASK>
 __dump_stack+0x21/0x30 lib/dump_stack.c:94
 dump_stack_lvl+0xee/0x150 lib/dump_stack.c:120
 print_address_description+0x51/0x1e0 mm/kasan/report.c:378
 print_report+0x67/0x80 mm/kasan/report.c:482
 kasan_report+0x135/0x170 mm/kasan/report.c:595
 __asan_report_load4_noabort+0x18/0x20 mm/kasan/report_generic.c:380
 inode_state_read_once include/linux/fs.h:884 [inline]
 iput+0x34c/0xc60 fs/inode.c:1986
 fserror_worker+0x215/0x310 fs/fserror.c:69
 process_one_work kernel/workqueue.c:3275 [inline]
 process_scheduled_works+0xa30/0x13d0 kernel/workqueue.c:3358
 worker_thread+0xacb/0x1060 kernel/workqueue.c:3439
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x5e4/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 475317:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x70 mm/kasan/common.c:78
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:570
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x73/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4501 [inline]
 slab_alloc_node mm/slub.c:4830 [inline]
 kmem_cache_alloc_lru_noprof+0x2bc/0x4a0 mm/slub.c:4849
 xfs_inode_alloc+0xf8/0x7b0 fs/xfs/xfs_icache.c:97
 xfs_iget_cache_miss fs/xfs/xfs_icache.c:635 [inline]
 xfs_iget+0x635/0x2330 fs/xfs/xfs_icache.c:799
 xfs_lookup+0x2fb/0x4f0 fs/xfs/xfs_inode.c:553
 xfs_vn_lookup+0x11d/0x1e0 fs/xfs/xfs_iops.c:327
 __lookup_slow+0x28f/0x3c0 fs/namei.c:1916
 lookup_slow+0x5c/0x80 fs/namei.c:1933
 walk_component fs/namei.c:2279 [inline]
 lookup_last fs/namei.c:2780 [inline]
 path_lookupat+0x403/0x8f0 fs/namei.c:2804
 filename_lookup+0x217/0x570 fs/namei.c:2833
 filename_listxattr fs/xattr.c:945 [inline]
 path_listxattrat+0x117/0x3a0 fs/xattr.c:975
 __do_sys_listxattr fs/xattr.c:988 [inline]
 __se_sys_listxattr fs/xattr.c:985 [inline]
 __x64_sys_listxattr+0x8b/0xa0 fs/xattr.c:985
 x64_sys_call+0x1899/0x2900 arch/x86/include/generated/asm/syscalls_64.h:195
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x13f/0x860 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

Freed by task 15:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x70 mm/kasan/common.c:78
 kasan_save_free_info+0x4a/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x63/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2687 [inline]
 slab_free mm/slub.c:6124 [inline]
 kmem_cache_free+0x20c/0x5a0 mm/slub.c:6254
 xfs_inode_free_callback+0x1ad/0x1e0 fs/xfs/xfs_icache.c:165
 rcu_do_batch+0x541/0xc90 kernel/rcu/tree.c:2617
 rcu_core+0x455/0x870 kernel/rcu/tree.c:2869
 rcu_core_si+0x12/0x20 kernel/rcu/tree.c:2886
 handle_softirqs+0x229/0x750 kernel/softirq.c:622
 run_ksoftirqd+0x3f/0x70 kernel/softirq.c:1063
 smpboot_thread_fn+0x611/0xbe0 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x5e4/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xc1/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3131 [inline]
 call_rcu+0xec/0x7d0 kernel/rcu/tree.c:3251
 __xfs_inode_free fs/xfs/xfs_icache.c:177 [inline]
 xfs_inode_free+0x1c5/0x240 fs/xfs/xfs_icache.c:197
 xfs_iget_cache_miss fs/xfs/xfs_icache.c:740 [inline]
 xfs_iget+0x6b6/0x2330 fs/xfs/xfs_icache.c:799
 xfs_lookup+0x2fb/0x4f0 fs/xfs/xfs_inode.c:553
 xfs_vn_lookup+0x11d/0x1e0 fs/xfs/xfs_iops.c:327
 __lookup_slow+0x28f/0x3c0 fs/namei.c:1916
 lookup_slow+0x5c/0x80 fs/namei.c:1933
 walk_component fs/namei.c:2279 [inline]
 lookup_last fs/namei.c:2780 [inline]
 path_lookupat+0x403/0x8f0 fs/namei.c:2804
 filename_lookup+0x217/0x570 fs/namei.c:2833
 filename_listxattr fs/xattr.c:945 [inline]
 path_listxattrat+0x117/0x3a0 fs/xattr.c:975
 __do_sys_listxattr fs/xattr.c:988 [inline]
 __se_sys_listxattr fs/xattr.c:985 [inline]
 __x64_sys_listxattr+0x8b/0xa0 fs/xattr.c:985
 x64_sys_call+0x1899/0x2900 arch/x86/include/generated/asm/syscalls_64.h:195
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x13f/0x860 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x4b/0x53

The buggy address belongs to the object at ffff888066ffad00
 which belongs to the cache xfs_inode of size 1776
The buggy address is located 696 bytes inside of
 freed 1776-byte region [ffff888066ffad00, ffff888066ffb3f0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff888066ffe180 pfn:0x66ff8
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff888066ff8719
flags: 0x2000000000000240(workingset|head|zone=1)
page_type: f5(slab)
raw: 2000000000000240 ffff888019fd2640 ffff888019fd1ac8 ffffea0000adde10
raw: ffff888066ffe180 0000078000110009 00000000f5000000 ffff888066ff8719
head: 2000000000000240 ffff888019fd2640 ffff888019fd1ac8 ffffea0000adde10
head: ffff888066ffe180 0000078000110009 00000000f5000000 ffff888066ff8719
head: 2000000000000003 ffffea00019bfe01 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 40578, tgid 40575 (syz.3.7187), ts 249736208593, free_ts 245599182745
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x25f/0x490 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x2da9/0x2ed0 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x17c/0x340 mm/page_alloc.c:5250
 alloc_slab_page+0x62/0x130 mm/slub.c:-1
 allocate_slab+0x7a/0x530 mm/slub.c:3444
 new_slab mm/slub.c:3502 [inline]
 refill_objects+0x4bf/0x640 mm/slub.c:7134
 refill_sheaf+0x32/0x50 mm/slub.c:2804
 alloc_full_sheaf mm/slub.c:2825 [inline]
 __pcs_replace_empty_main+0x335/0x580 mm/slub.c:4588
 alloc_from_pcs mm/slub.c:4681 [inline]
 slab_alloc_node mm/slub.c:4815 [inline]
 kmem_cache_alloc_lru_noprof+0x41c/0x4a0 mm/slub.c:4849
 xfs_inode_alloc+0xf8/0x7b0 fs/xfs/xfs_icache.c:97
 xfs_iget_cache_miss fs/xfs/xfs_icache.c:635 [inline]
 xfs_iget+0x635/0x2330 fs/xfs/xfs_icache.c:799
 xfs_mountfs+0xf84/0x2050 fs/xfs/xfs_mount.c:1072
 xfs_fs_fill_super+0x1225/0x16a0 fs/xfs/xfs_super.c:1938
 get_tree_bdev_flags+0x407/0x4d0 fs/super.c:1694
 get_tree_bdev+0x28/0x30 fs/super.c:1717
 xfs_fs_get_tree+0x25/0x30 fs/xfs/xfs_super.c:1985
page last free pid 5023 tgid 5023 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0xb63/0x1040 mm/page_alloc.c:2978
 free_frozen_pages+0x14/0x20 mm/page_alloc.c:3016
 __free_slab+0x1a2/0x290 mm/slub.c:3518
 free_slab+0xdd/0x100 mm/slub.c:3552
 discard_slab+0x28/0x30 mm/slub.c:3558
 __slab_free+0x2a8/0x2b0 mm/slub.c:5532
 ___cache_free+0x72/0x80 mm/slub.c:6199
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0xa3/0x110 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x13f/0x150 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x28/0x80 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4501 [inline]
 slab_alloc_node mm/slub.c:4830 [inline]
 __do_kmalloc_node mm/slub.c:5218 [inline]
 __kmalloc_noprof+0x329/0x610 mm/slub.c:5231
 kmalloc_noprof include/linux/slab.h:966 [inline]
 tomoyo_realpath_from_path+0x172/0x710 security/tomoyo/realpath.c:251
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x208/0x460 security/tomoyo/file.c:827
 tomoyo_inode_getattr+0x25/0x30 security/tomoyo/tomoyo.c:123
 security_inode_getattr+0x1eb/0x3d0 security/security.c:1869
 vfs_getattr fs/stat.c:259 [inline]
 vfs_fstat fs/stat.c:281 [inline]
 __do_sys_newfstat fs/stat.c:551 [inline]
 __se_sys_newfstat+0xe9/0x3e0 fs/stat.c:546

Memory state around the buggy address:
 ffff888066ffae80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888066ffaf00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888066ffaf80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                        ^
 ffff888066ffb000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888066ffb080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>
