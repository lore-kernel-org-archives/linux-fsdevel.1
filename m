Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEF744C4FF
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785518019; cv=none; b=PXjNaKEFsAa4yc2UlkbWGm8Pkk7n6tPNS/mj6ZZ+AjNYdomExpkiV4JIDCVwJH6CT+lFitDKGCX03VAYFqUPmyS6mgW65a4OmaTUNIv9NtsGKtUTAme5p3GKHJenIiVQlirc/d34PxUuXoAAj5AFlcPLgvwHntP3WBYb/RNi4fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785518019; c=relaxed/simple;
	bh=I9MBgBAfXEJmWipl0chbaMULPEE5Kh9HA0OjF+R/rrE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=q1Md82A5ZEE2m/2qlC06u+LiAIiA684O0kGzrUJfToCOIPg74xlExhz6ixBUtkq6cLjGtjzI6nwqHHfkRnAsfpzFHfWBhU+2Hr/KChx1RNSzxG7n1A7TxM1L/DzCo2gqfP9CpOpB2tBphfjjfAP1vtrVe+91HcC0fwWI4kIGsSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-456ae656699so1418365fac.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 10:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785518014; x=1786122814;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hmr+cege5SvwIdUEK0yjKrq+OpjxBCZUrxDQykxDDes=;
        b=TTZhTP2+cUuglgpP0NKMua7dDi5Kjq6zrHelV45gYysizL4lOV4ARpzHu3lH4YZtFr
         BLg93UOuyQsK0+DcuqZVZz7SXqkeT8xI5LPnEZIx/bDrTjUCeKV0mT9WBemfDt1uGA90
         l+STtAg0R7KPki8DEa74X3w9ic94czMkSfJ5p1BpvR+Za9DwB8slbZZ4ukSxbHRLPVr6
         aYHWuUu6IgP5hj6U9b6KhGU1Cpzi/R3FwpcPp8Hwruv9AZP6NzKD83ZPhAZ75fI+jBm3
         s2d2KaXw/n0tV4FiGhmypQ0G4rlsouPpih8TZmGOfgcoMB+3FalPuDlyqlI8wTGjWPjw
         /VRg==
X-Forwarded-Encrypted: i=1; AHgh+RrLtAK9DerZ1jbzqpLy5avbP1RI6GaiZxzAOoIr9XuvQCMoMEXWANk9a8vj275UfBoUIajpo97vYVLNriEv@vger.kernel.org
X-Gm-Message-State: AOJu0YxjEt90nG+53TTijROMZ+QmJLyacG2PY0wtNvPGYDQOLis+Ejwp
	QajEqpdejQ7ZBMlFmErs01V8s+p6o8eydmfI8SyKV69xgeeGtYFsc8xT3WKVuBeZeI45CvRkWLB
	ZUhDPWL0bhpTz8QRwibXcygMR4Z2FVap94KnKKfkSMm3mE0RMdSk+H9h03mE=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1310:b0:495:e5a5:d62 with SMTP id
 5614622812f47-4af5e031ed4mr1445978b6e.6.1785518014493; Fri, 31 Jul 2026
 10:13:34 -0700 (PDT)
Date: Fri, 31 Jul 2026 10:13:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6cd7be.1aa927e4.17d4bf.0006.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in filp_flush
From: syzbot <syzbot+df868600fe111c5ff79f@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    cc2b5f627e8c Add linux-next specific files for 20260714
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=118871b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2290ccbf984c524f
dashboard link: https://syzkaller.appspot.com/bug?extid=df868600fe111c5ff79f
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1367d632580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=104b9499580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6836f8efb1da/disk-cc2b5f62.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0109d3477cc7/vmlinux-cc2b5f62.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c2e49e350bbf/bzImage-cc2b5f62.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+df868600fe111c5ff79f@syzkaller.appspotmail.com

=========[   98.796662][ T5617] ==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:82 [inline]
BUG: KASAN: slab-use-after-free in atomic_long_read include/linux/atomic/atomic-instrumented.h:3188 [inline]
BUG: KASAN: slab-use-after-free in file_ref_read include/linux/file_ref.h:198 [inline]
BUG: KASAN: slab-use-after-free in filp_flush+0x31/0x190 fs/open.c:1464
Read of size 8 at addr ffff888045f01990 by task syz-executor659/5617

CPU: 1 UID: 0 PID: 5617 Comm: syz-executor659 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2c0 mm/kasan/generic.c:200
 instrument_atomic_read include/linux/instrumented.h:82 [inline]
 atomic_long_read include/linux/atomic/atomic-instrumented.h:3188 [inline]
 file_ref_read include/linux/file_ref.h:198 [inline]
 filp_flush+0x31/0x190 fs/open.c:1464
 filp_close+0x1d/0x40 fs/open.c:1484
 gaudio_close_snd_dev drivers/usb/gadget/function/u_uac1_legacy.c:263 [inline]
 gaudio_cleanup+0x54/0xf0 drivers/usb/gadget/function/u_uac1_legacy.c:305
 f_audio_bind+0x4a0/0x630 drivers/usb/gadget/function/f_uac1_legacy.c:792
 usb_add_function+0x290/0x930 drivers/usb/gadget/composite.c:333
 configfs_composite_bind+0xde0/0x1410 drivers/usb/gadget/configfs.c:1802
 gadget_bind_driver+0x2ca/0x9e0 drivers/usb/gadget/udc/core.c:1662
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __driver_attach+0x339/0x600 drivers/base/dd.c:1292
 bus_for_each_dev+0x23e/0x2c0 drivers/base/bus.c:383
 bus_add_driver+0x348/0x670 drivers/base/bus.c:763
 driver_register+0x23a/0x320 drivers/base/driver.c:174
 usb_gadget_register_driver_owner+0xf9/0x270 drivers/usb/gadget/udc/core.c:1752
 gadget_dev_desc_UDC_store+0x1c9/0x2f0 drivers/usb/gadget/configfs.c:300
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x33a/0x430 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61e/0xbb0 fs/read_write.c:687
 ksys_write+0x156/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faa645b0db9
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd75524398 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000200000000000 RCX: 00007faa645b0db9
RDX: 000000000000000c RSI: 0000200000000400 RDI: 0000000000000003
RBP: 6769666e6f632f2e R08: 000055558b0c7050 R09: 000055558b0c7050
R10: 000055558b0c7050 R11: 0000000000000246 R12: 00007ffd755243bc
R13: 00007ffd755243f0 R14: 00007ffd755243d0 R15: 0000200000000008
 </TASK>

Allocated by task 5615:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4608 [inline]
 slab_alloc_node mm/slub.c:4921 [inline]
 kmem_cache_alloc_noprof+0x358/0x680 mm/slub.c:4935
 alloc_empty_file+0x5b/0x1d0 fs/file_table.c:262
 path_openat+0x8f/0x3850 fs/namei.c:4843
 do_file_open+0x23e/0x4a0 fs/namei.c:4886
 file_open_name fs/open.c:1326 [inline]
 filp_open+0x16d/0x1d0 fs/open.c:1343
 gaudio_open_snd_dev drivers/usb/gadget/function/u_uac1_legacy.c:211 [inline]
 gaudio_setup+0x11b/0xf10 drivers/usb/gadget/function/u_uac1_legacy.c:289
 f_audio_bind+0x137/0x630 drivers/usb/gadget/function/f_uac1_legacy.c:740
 usb_add_function+0x290/0x930 drivers/usb/gadget/composite.c:333
 configfs_composite_bind+0xde0/0x1410 drivers/usb/gadget/configfs.c:1802
 gadget_bind_driver+0x2ca/0x9e0 drivers/usb/gadget/udc/core.c:1662
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __driver_attach+0x339/0x600 drivers/base/dd.c:1292
 bus_for_each_dev+0x23e/0x2c0 drivers/base/bus.c:383
 bus_add_driver+0x348/0x670 drivers/base/bus.c:763
 driver_register+0x23a/0x320 drivers/base/driver.c:174
 usb_gadget_register_driver_owner+0xf9/0x270 drivers/usb/gadget/udc/core.c:1752
 gadget_dev_desc_UDC_store+0x1c9/0x2f0 drivers/usb/gadget/configfs.c:300
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x33a/0x430 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61e/0xbb0 fs/read_write.c:687
 ksys_write+0x156/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 21:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2706 [inline]
 slab_free_after_rcu_debug+0x12a/0x220 mm/slub.c:6450
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core kernel/rcu/tree.c:2897 [inline]
 rcu_cpu_kthread+0x950/0x1480 kernel/rcu/tree.c:2985
 smpboot_thread_fn+0x57c/0xa80 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 slab_free_hook mm/slub.c:2667 [inline]
 slab_free mm/slub.c:6388 [inline]
 kmem_cache_free+0x513/0x6c0 mm/slub.c:6515
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 ptrace_notify+0x27c/0x2b0 kernel/signal.c:2524
 ptrace_report_syscall include/linux/ptrace.h:416 [inline]
 ptrace_report_syscall_exit+0x2d/0x50 include/linux/ptrace.h:477
 arch_ptrace_report_syscall_exit include/linux/entry-common.h:236 [inline]
 syscall_exit_work include/linux/entry-common.h:269 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:300 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:337 [inline]
 do_syscall_64+0x4ae/0x530 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Second to last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 task_work_add+0xae/0x420 kernel/task_work.c:70
 __fput_deferred+0x183/0x3e0 fs/file_table.c:573
 fput_close+0x11f/0x240 fs/file_table.c:629
 filp_close+0x27/0x40 fs/open.c:1485
 gaudio_close_snd_dev drivers/usb/gadget/function/u_uac1_legacy.c:263 [inline]
 gaudio_cleanup+0x54/0xf0 drivers/usb/gadget/function/u_uac1_legacy.c:305
 f_audio_bind+0x4a0/0x630 drivers/usb/gadget/function/f_uac1_legacy.c:792
 usb_add_function+0x290/0x930 drivers/usb/gadget/composite.c:333
 configfs_composite_bind+0xde0/0x1410 drivers/usb/gadget/configfs.c:1802
 gadget_bind_driver+0x2ca/0x9e0 drivers/usb/gadget/udc/core.c:1662
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:706
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __driver_attach+0x339/0x600 drivers/base/dd.c:1292
 bus_for_each_dev+0x23e/0x2c0 drivers/base/bus.c:383
 bus_add_driver+0x348/0x670 drivers/base/bus.c:763
 driver_register+0x23a/0x320 drivers/base/driver.c:174
 usb_gadget_register_driver_owner+0xf9/0x270 drivers/usb/gadget/udc/core.c:1752
 gadget_dev_desc_UDC_store+0x1c9/0x2f0 drivers/usb/gadget/configfs.c:300
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x33a/0x430 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61e/0xbb0 fs/read_write.c:687
 ksys_write+0x156/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888045f01800
 which belongs to the cache filp of size 408
The buggy address is located 400 bytes inside of
 freed 408-byte region [ffff888045f01800, ffff888045f01998)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x45f00
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000040(head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000040 ffff88801c6af780 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 0080000000000040 ffff88801c6af780 dead000000000100 dead000000000122
head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 0080000000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5612, tgid 5612 (sshd-session), ts 97898029454
 set_page_owner include/linux/page_owner.h:33 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1871
 prep_new_page mm/page_alloc.c:1879 [inline]
 get_page_from_freelist+0x264c/0x26c0 mm/page_alloc.c:3955
 __alloc_frozen_pages_noprof+0x222/0x5b0 mm/page_alloc.c:5394
 alloc_slab_page mm/slub.c:3295 [inline]
 allocate_slab+0x7c/0x5e0 mm/slub.c:3410
 new_slab mm/slub.c:3456 [inline]
 refill_objects+0x2d8/0x350 mm/slub.c:7321
 refill_sheaf mm/slub.c:2833 [inline]
 __pcs_replace_empty_main+0x330/0x690 mm/slub.c:4699
 alloc_from_pcs mm/slub.c:4775 [inline]
 slab_alloc_node mm/slub.c:4909 [inline]
 kmem_cache_alloc_noprof+0x455/0x680 mm/slub.c:4935
 alloc_empty_file+0x5b/0x1d0 fs/file_table.c:262
 path_openat+0x8f/0x3850 fs/namei.c:4843
 do_file_open+0x23e/0x4a0 fs/namei.c:4886
 do_open_execat+0x12b/0x590 fs/exec.c:785
 alloc_bprm+0x24/0x640 fs/exec.c:1431
 class_bprm_constructor fs/exec.c:1497 [inline]
 do_execveat_common+0x172/0x670 fs/exec.c:1829
 __do_sys_execve fs/exec.c:1949 [inline]
 __se_sys_execve fs/exec.c:1943 [inline]
 __x64_sys_execve+0x97/0xc0 fs/exec.c:1943
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
page last free pid 5601 tgid 5601 ts 92377421343 stack trace:
 reset_page_owner include/linux/page_owner.h:26 [inline]
 __free_pages_prepare mm/page_alloc.c:1418 [inline]
 __free_frozen_pages+0x1185/0x1270 mm/page_alloc.c:2962
 __folio_put+0x30f/0x3c0 mm/folio.c:105
 pipe_buf_release include/linux/pipe_fs_i.h:273 [inline]
 pipe_update_tail fs/pipe.c:334 [inline]
 anon_pipe_read+0x67a/0x10c0 fs/pipe.c:453
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x59e/0xa90 fs/read_write.c:574
 ksys_read+0x156/0x270 fs/read_write.c:716
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x17b/0x530 arch/x86/entry/syscall_64.c:85
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff888045f01880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888045f01900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888045f01980: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
                         ^
 ffff888045f01a00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888045f01a80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


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
