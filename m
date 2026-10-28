Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793226022;
	b=mSZw4MsjXE+jgEYSGd0d3u1F0QIhOkWDJ9/kRFEC4urxdIgH+TyYHTVWbciNvNkRuT1C
	 5u3OWw1gOAJU1d9xSUC/OP+VFMqpKl4CmTwi2m29PO13hC71dUZt4oK9ZQtV1TSiv3Aos
	 eRAtwPzLz/qd+OqHBbh9I1X0Rkiot2JsVxs4lAgDAqswE2dW+B5JQMhrmC9UPmVX44P9r
	 v2EXamvVIt0rvSGBe3RvjlVsh7g1VgtcaXpBLw6y7rdSwTz7cZ0h4zV4GRSi9DPC+Pous
	 MtTavpIWePce3RhQ2ucTL1paNIkcVzB8xAFRspMoWPW9iggOqWKB1ZvlGiYbKrjalOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793226022;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=aemFw6LC+vpz+tNnFpw3s8C256peelxZyCzI/2jyUzg=;
	b=hSZzeXUn0j6p659+l+GJ9+4eCg7o2TqYJek65bPAcJsjuSjYdl7kMYil7p7PLh+rWay7
	 66IwAVthR950NQBx4E0vuc8xiMXHUZAicYwktMGPGf8Wl7sItUZNl/BXGrexl7plj/xli
	 yc8gijKMFYLUMNks1GIZjsndLesnJwfU0PvCS/Mez4+wmFDl22BLuPWVp3no4y8zDAI2j
	 E5gCigDCWO48xMZF/AxJUbjkZ1IA6fLHiYPDuYhXUpf8UMjkG/VCKYHlsfxwMY3ClNpCV
	 LblUe9xdfiA6ACuCpD4uIes+1lga36gHYb0iW3xZU9Z67A00WMYcC6pCIsyIWykMqxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB9606A31C
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 22:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64AB9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4e937c5bd4fso1521112b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 15:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793226021; x=1793830821;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aemFw6LC+vpz+tNnFpw3s8C256peelxZyCzI/2jyUzg=;
        b=k+wpnGF6W9XseV5WneyaMg4Wp5A0/hFZgpW+WLfgOYg0IuD7ntFuzqYqV6432BbDzh
         9ojbCUg98W/+omaboVsT9lQEtEyRwzcbJSLrTRu9F7upW5cNHYgK5oJTixDp+arzIBuq
         qbABgsfsBxQc3PMJIbOEpIOknyOFyVL/LCpP8MAJyNNbjgdt4htyxXVHsqG8sX6T5Uhw
         ieALFC+0vriZDvl5ekJe5ZuUzoMldXCaPGQo3ANV/+nypok/UARRakbFpHfM3fP//NeG
         HJu4zED57eoVEHLYlj+nPpWZNd9cjJVkhIesKZV2Na6hdGfPuzByOiPTDL6bOxgW7i6K
         PDOQ==
X-Gm-Message-State: AFq9FYIxgzYdFMsfy/x2dxwNd9ZF4KCWHlVv3draZbfkvHt8GIuGCxYs
	tDjKunvmbBMa8TMFQkzHsvnj4xAg6y2Y8TwO7nC01bw/lL8v/1H8pXI/UaPN3Fqy5oKpdjOPJBK
	hQZs3xGQga/pkHVwd3wVS8PpsaKRxovPQy+80gjdjvGW/2oAN1up3OnWkduA=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:470c:b0:4d6:90f3:74b1 with SMTP id
 5614622812f47-563844978e8mr3012029b6e.49.1793226021511; Wed, 28 Oct 2026
 15:20:21 -0700 (PDT)
Date: Wed, 28 Oct 2026 15:20:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae27525.5451848c.f7707.0001.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] KASAN: slab-use-after-free Read in trace_event_raw_event_hugetlbfs__inode
From: syzbot <syzbot+91e1fc35f51774c479b2@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d135ab453a74 Merge tag 'backlight-next-7.4' of git://git.k..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=142de17f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f2905533069b0f5
dashboard link: https://syzkaller.appspot.com/bug?extid=91e1fc35f51774c479b2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17432995580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+91e1fc35f51774c479b2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in do_trace_event_raw_event_hugetlbfs__inode include/trace/events/hugetlbfs.h:36 [inline]
BUG: KASAN: slab-use-after-free in trace_event_raw_event_hugetlbfs__inode+0x45b/0x4c0 include/trace/events/hugetlbfs.h:36
Read of size 4 at addr ffff888038850010 by task syz-executor952/6134

CPU: 3 UID: 0 PID: 6134 Comm: syz-executor952 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x13d/0x4b0 mm/kasan/report.c:482
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 do_trace_event_raw_event_hugetlbfs__inode include/trace/events/hugetlbfs.h:36 [inline]
 trace_event_raw_event_hugetlbfs__inode+0x45b/0x4c0 include/trace/events/hugetlbfs.h:36
 __do_trace_hugetlbfs_free_inode include/trace/events/hugetlbfs.h:75 [inline]
 trace_hugetlbfs_free_inode include/trace/events/hugetlbfs.h:75 [inline]
 hugetlbfs_free_inode+0x15e/0x1f0 fs/hugetlbfs/inode.c:1182
 i_callback+0x46/0x80 fs/inode.c:317
 rcu_do_batch kernel/rcu/tree.c:2650 [inline]
 rcu_core+0x5f0/0x1220 kernel/rcu/tree.c:2919
 handle_softirqs+0x216/0xa20 kernel/softirq.c:669
 __do_softirq kernel/softirq.c:703 [inline]
 invoke_softirq kernel/softirq.c:542 [inline]
 __irq_exit_rcu+0x178/0x220 kernel/softirq.c:786
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:809
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:__sanitizer_cov_trace_pc+0x46/0x70 kernel/kcov.c:213
Code: 00 01 00 ff 74 1e f6 c4 01 74 44 a9 00 00 00 0f 75 3d f7 c1 00 00 00 f0 75 35 8b 82 44 17 00 00 85 c0 74 2b 8b 82 18 17 00 00 <83> f8 02 75 20 48 8b 8a 20 17 00 00 8b 92 1c 17 00 00 48 8b 01 48
RSP: 0018:ffffc900035dfd38 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffc90000327df0 RCX: 0000000000000003
RDX: ffff8880311b0000 RSI: ffffffff82a3cf67 RDI: ffff8880311b0000
RBP: ffffc90000327df0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88803b243da8 R15: 0000000000000000
 __hlist_bl_del include/linux/list_bl.h:123 [inline]
 ___d_drop+0xe7/0x2d0 fs/dcache.c:584
 __d_drop fs/dcache.c:591 [inline]
 __d_drop fs/dcache.c:588 [inline]
 d_delete+0xd1/0x280 fs/dcache.c:2785
 d_delete_notify include/linux/fsnotify.h:379 [inline]
 vfs_unlink+0x688/0xbd0 fs/namei.c:5676
 filename_unlinkat+0x408/0x730 fs/namei.c:5731
 __do_sys_unlink fs/namei.c:5766 [inline]
 __se_sys_unlink fs/namei.c:5763 [inline]
 __x64_sys_unlink+0x46/0x70 fs/namei.c:5763
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f62cdcc0047
Code: 1f 40 00 48 89 f2 31 c9 48 89 fe bf 9c ff ff ff e9 ce 5f 03 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 57 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 d0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007f62cc488088 EFLAGS: 00000202 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007ffd4150bf90 RCX: 00007f62cdcc0047
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f62cc488160
RBP: 0000000000000017 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000001b6 R11: 0000000000000202 R12: 00007f62cc4880a0
R13: 00007f62cdd315b8 R14: 00007f62cc4880e0 R15: 00007f62cc488160
 </TASK>

Allocated by task 6134:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:409 [inline]
 __kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:426
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __kmalloc_cache_noprof+0x2f8/0x6d0 mm/slub.c:5680
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 alloc_super fs/super.c:326 [inline]
 sget_fc+0x1ba/0x1f60 fs/super.c:874
 get_tree_super fs/super.c:1395 [inline]
 get_tree_nodev+0x28/0x190 fs/super.c:1420
 hugetlbfs_get_tree+0x1e7/0x2b0 fs/hugetlbfs/inode.c:1431
 vfs_get_tree+0x92/0x320 fs/super.c:1943
 fc_mount fs/namespace.c:1282 [inline]
 do_new_mount_fc fs/namespace.c:3910 [inline]
 do_new_mount fs/namespace.c:3986 [inline]
 path_mount+0x7d0/0x2850 fs/namespace.c:4337
 do_mount fs/namespace.c:4350 [inline]
 __do_sys_mount fs/namespace.c:4565 [inline]
 __se_sys_mount fs/namespace.c:4542 [inline]
 __x64_sys_mount+0x293/0x310 fs/namespace.c:4542
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 855:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:264 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:296
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2780 [inline]
 slab_free mm/slub.c:6630 [inline]
 kfree+0x22b/0x6d0 mm/slub.c:6923
 process_one_work+0xac7/0x1b10 kernel/workqueue.c:3495
 process_scheduled_works kernel/workqueue.c:3578 [inline]
 worker_thread+0x5ef/0xe50 kernel/workqueue.c:3659
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 insert_work+0x36/0x230 kernel/workqueue.c:2356
 __queue_work+0xac1/0x16f0 kernel/workqueue.c:2546
 queue_work_on+0x180/0x1e0 kernel/workqueue.c:2599
 rcu_do_batch kernel/rcu/tree.c:2650 [inline]
 rcu_core+0x5f0/0x1220 kernel/rcu/tree.c:2919
 handle_softirqs+0x216/0xa20 kernel/softirq.c:669
 __do_softirq kernel/softirq.c:703 [inline]
 invoke_softirq kernel/softirq.c:542 [inline]
 __irq_exit_rcu+0x178/0x220 kernel/softirq.c:786
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:809
 instr_sysvec_call_function_single arch/x86/kernel/smp.c:267 [inline]
 sysvec_call_function_single+0xa3/0xc0 arch/x86/kernel/smp.c:267
 asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentry.h:681

Second to last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 __call_rcu_common.constprop.0+0x7b/0x2b0 kernel/rcu/tree.c:3287
 put_super fs/super.c:432 [inline]
 put_super+0x30e/0x420 fs/super.c:419
 deactivate_locked_super+0xe5/0x130 fs/super.c:594
 deactivate_super fs/super.c:614 [inline]
 deactivate_super+0xea/0x110 fs/super.c:610
 cleanup_mnt+0xb7/0x160 fs/namespace.c:1396
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x1d8/0x700 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
 do_syscall_64+0x661/0x790 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888038850000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 16 bytes inside of
 freed 4096-byte region [ffff888038850000, ffff888038851000)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x38850
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88801d443040 dead000000000100 dead000000000122
raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88801d443040 dead000000000100 dead000000000122
head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
head: 00fff00000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5207, tgid 5207 (udevd), ts 22161561359
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0xfd/0x120 mm/page_alloc.c:1854
 prep_new_page mm/page_alloc.c:1862 [inline]
 get_page_from_freelist+0x1113/0x35e0 mm/page_alloc.c:3933
 __alloc_frozen_pages_noprof+0x2f6/0x3190 mm/page_alloc.c:5429
 alloc_slab_page mm/slub.c:3384 [inline]
 allocate_slab mm/slub.c:3499 [inline]
 new_slab+0xb1/0x6d0 mm/slub.c:3550
 refill_objects+0xe3/0x410 mm/slub.c:7539
 refill_sheaf mm/slub.c:2917 [inline]
 __pcs_replace_empty_main+0x35e/0x650 mm/slub.c:4811
 alloc_from_pcs mm/slub.c:4887 [inline]
 slab_alloc_node mm/slub.c:5021 [inline]
 __kmalloc_cache_noprof+0x4ef/0x6d0 mm/slub.c:5676
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 kernfs_iop_get_link fs/kernfs/symlink.c:148 [inline]
 kernfs_iop_get_link+0x65/0x1770 fs/kernfs/symlink.c:139
 vfs_readlink+0x213/0x440 fs/namei.c:6431
 do_readlinkat+0x250/0x370 fs/stat.c:587
 __do_sys_readlink fs/stat.c:609 [inline]
 __se_sys_readlink fs/stat.c:606 [inline]
 __x64_sys_readlink+0x78/0xc0 fs/stat.c:606
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5196 tgid 5196 ts 22123403954 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1401 [inline]
 __free_frozen_pages+0x7b4/0x1110 mm/page_alloc.c:2952
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xf0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:361
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4720 [inline]
 slab_alloc_node mm/slub.c:5033 [inline]
 __kmalloc_cache_noprof+0x278/0x6d0 mm/slub.c:5676
 _kmalloc_noprof include/linux/slab.h:991 [inline]
 _kzalloc_noprof include/linux/slab.h:1312 [inline]
 kernfs_fop_open+0x347/0x10f0 fs/kernfs/file.c:648
 do_dentry_open+0x674/0x1470 fs/open.c:1000
 vfs_open_consume+0xcc/0x460 fs/open.c:1131
 do_open fs/namei.c:4845 [inline]
 path_openat+0x1547/0x23f0 fs/namei.c:5010
 do_file_open+0x20e/0x430 fs/namei.c:5039
 do_sys_openat2+0x163/0x1d0 fs/open.c:1442
 do_sys_open fs/open.c:1448 [inline]
 __do_sys_openat fs/open.c:1464 [inline]
 __se_sys_openat fs/open.c:1459 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1459
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88803884ff00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88803884ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888038850000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff888038850080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888038850100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	00 01                	add    %al,(%rcx)
   2:	00 ff                	add    %bh,%bh
   4:	74 1e                	je     0x24
   6:	f6 c4 01             	test   $0x1,%ah
   9:	74 44                	je     0x4f
   b:	a9 00 00 00 0f       	test   $0xf000000,%eax
  10:	75 3d                	jne    0x4f
  12:	f7 c1 00 00 00 f0    	test   $0xf0000000,%ecx
  18:	75 35                	jne    0x4f
  1a:	8b 82 44 17 00 00    	mov    0x1744(%rdx),%eax
  20:	85 c0                	test   %eax,%eax
  22:	74 2b                	je     0x4f
  24:	8b 82 18 17 00 00    	mov    0x1718(%rdx),%eax
* 2a:	83 f8 02             	cmp    $0x2,%eax <-- trapping instruction
  2d:	75 20                	jne    0x4f
  2f:	48 8b 8a 20 17 00 00 	mov    0x1720(%rdx),%rcx
  36:	8b 92 1c 17 00 00    	mov    0x171c(%rdx),%edx
  3c:	48 8b 01             	mov    (%rcx),%rax
  3f:	48                   	rex.W


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
