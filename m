Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764B2368D69
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 23:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781913385; cv=none; b=c29RKmjkv4XgBJxI8kq/ZxuFZz4UwxJmNcSAiMAsG9w5PKsufO3ZIfVbYqBKTk/4KAK/InrIwikdcQ1rAYammlG4psz0Dj6fHaRtmn5k93V+kzyoEuDrUwL5JB+y5XaFmWVe8Ikm26x79JJSUshPdgM72OvXUGdTDaknBJOAMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781913385; c=relaxed/simple;
	bh=aAfdJLlVJcDmjdHmVH9q3g1T0k8dCsl5dmxqh6Lu7ys=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ki7YRMIbr0bKdu9Tv/97shOq0OhmjrgIIGXHqLJBbw4mbJ5ylNwoIC+w9dXurlpmpFJ6rn0n3uv2kziLU/4dICY9J5i9nV8XZRn6bko7UlqhCirLDDkA7Pr43/CzxLEqyU3wefXVQixpsncsyOOEcBzBGzh2yKohbvtXqENCQN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-441d7a137d1so3973159fac.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 16:56:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781913381; x=1782518181;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ZB/J2YWf86q4RH+5UAdqXIwJKtQ8pjnjE8k/mYjT9k=;
        b=nfgViiiY0RcMh1/nPNbWVdAx+U86ITeZVsroPICg3tJivSMb9XqYbjQeXIN0y/UPLs
         yv81cX4vDsdHz6TNoAFHfVRgnYq1+YTNmE2MNEW5a6nKc5FDwh0FwOzT6R85IOcw5Rxh
         lToESMlfWUSuHwCkLoLjfzmeIylRnTy3SyW4frDiNV2RRtIwgK+S5ppk4RXO/szcTRNM
         vbzDM9xV8j/ktKh4hgV6LpPwUst5lCM2s+eYAf17yUHOVg3wnjA/Xe6PYcdRE56+jtqQ
         ysmzScgZiziU0way8pr76FWiC0PPNOWv3bbDhkmgy8CMwLm/0stCqExMz1Jiww/6dyWS
         egYA==
X-Forwarded-Encrypted: i=1; AFNElJ9SpO+wk5ytAEhZuHrxsLfsC+zWgCj7JDFWbKtTkRt9uVxeb1XadY2B49pZQYiCrrLYl4Yk8PkcfwSSiraj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5bbFP4rdW/W2oAVPdX1Vp3WnhU6NcOQUYIv1Y7AOoepDfZ9lz
	QuJlQBRTZc/wTCYcjMvKWfpYWfmnIMIJh0qM3qQGUCMfoGinGzgfwwiHJ4bh4YFn1HLTxAHO+rt
	LxTCsLPpePdzztHh/xuBYkcWTUyoL7Fl/Fg2YKR6NTDGTVt59th64OWYcOk4=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1529:b0:489:7060:4b05 with SMTP id
 5614622812f47-489b078592cmr4628236b6e.21.1781913381599; Fri, 19 Jun 2026
 16:56:21 -0700 (PDT)
Date: Fri, 19 Jun 2026 16:56:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a35d725.280d05a0.1060c1.0001.GAE@google.com>
Subject: [syzbot] [fs?] KASAN: slab-use-after-free Read in d_alloc_parallel
From: syzbot <syzbot+bcc49cd0a89969bb101a@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ec039126b7fa Add linux-next specific files for 20260611
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11f307f2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0d1fa2afcbce17c
dashboard link: https://syzkaller.appspot.com/bug?extid=bcc49cd0a89969bb101a
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/be809c32a471/disk-ec039126.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/13ea1053e3b5/vmlinux-ec039126.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1bcdab47ddc8/bzImage-ec039126.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bcc49cd0a89969bb101a@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:166
Read of size 1 at addr ffff8880273bb728 by task kworker/u8:2/1377

CPU: 1 UID: 0 PID: 1377 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report+0x117/0x150 mm/kasan/report.c:595
 __kasan_check_byte+0x2a/0x40 mm/kasan/common.c:574
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire+0x84/0x350 kernel/locking/lockdep.c:5844
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:132 [inline]
 _raw_spin_lock_irqsave+0x40/0x60 kernel/locking/spinlock.c:166
 rt_mutex_slowunlock+0xbf/0x8b0 kernel/locking/rtmutex.c:1430
 spin_unlock include/linux/spinlock_rt.h:109 [inline]
 d_alloc_parallel+0x103d/0x1630 fs/dcache.c:2826
 __lookup_slow+0x82/0x2f0 fs/namei.c:1904
 lookup_slow+0x53/0x70 fs/namei.c:1936
 walk_component fs/namei.c:2282 [inline]
 link_path_walk+0xd1e/0x18d0 fs/namei.c:2656
 path_openat+0x22c/0x37e0 fs/namei.c:4855
 do_file_open+0x23e/0x4a0 fs/namei.c:4888
 do_open_execat+0x12b/0x590 fs/exec.c:785
 alloc_bprm+0x28/0x660 fs/exec.c:1431
 class_bprm_constructor fs/exec.c:1496 [inline]
 kernel_execve+0x87/0x930 fs/exec.c:1889
 call_usermodehelper_exec_async+0x212/0x360 kernel/umh.c:109
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 1378:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4614 [inline]
 slab_alloc_node mm/slub.c:4941 [inline]
 kmem_cache_alloc_lru_noprof+0x354/0x6b0 mm/slub.c:4974
 __d_alloc+0x37/0x6f0 fs/dcache.c:1902
 d_alloc_parallel+0xe3/0x1630 fs/dcache.c:2761
 __lookup_slow+0x82/0x2f0 fs/namei.c:1904
 lookup_slow+0x53/0x70 fs/namei.c:1936
 walk_component fs/namei.c:2282 [inline]
 link_path_walk+0xd1e/0x18d0 fs/namei.c:2656
 path_openat+0x22c/0x37e0 fs/namei.c:4855
 do_file_open+0x23e/0x4a0 fs/namei.c:4888
 do_open_execat+0x12b/0x590 fs/exec.c:785
 alloc_bprm+0x28/0x660 fs/exec.c:1431
 class_bprm_constructor fs/exec.c:1496 [inline]
 kernel_execve+0x87/0x930 fs/exec.c:1889
 call_usermodehelper_exec_async+0x212/0x360 kernel/umh.c:109
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Freed by task 29:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 kasan_save_free_info+0x46/0x50 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5c/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2699 [inline]
 slab_free mm/slub.c:6400 [inline]
 kmem_cache_free+0x187/0x6c0 mm/slub.c:6527
 rcu_do_batch kernel/rcu/tree.c:2645 [inline]
 rcu_core kernel/rcu/tree.c:2897 [inline]
 rcu_cpu_kthread+0x99e/0x1470 kernel/rcu/tree.c:2985
 smpboot_thread_fn+0x541/0xa50 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:57
 kasan_record_aux_stack+0xbd/0xd0 mm/kasan/generic.c:556
 __call_rcu_common kernel/rcu/tree.c:3159 [inline]
 call_rcu+0xee/0x890 kernel/rcu/tree.c:3279
 dentry_kill+0x4ed/0x890 fs/dcache.c:845
 finish_dput+0x1a/0x260 fs/dcache.c:1001
 handle_mounts fs/namei.c:1753 [inline]
 step_into_slowpath+0x487/0x7e0 fs/namei.c:2104
 step_into fs/namei.c:2152 [inline]
 walk_component fs/namei.c:2288 [inline]
 link_path_walk+0xd50/0x18d0 fs/namei.c:2656
 path_openat+0x22c/0x37e0 fs/namei.c:4855
 do_file_open+0x23e/0x4a0 fs/namei.c:4888
 do_open_execat+0x12b/0x590 fs/exec.c:785
 alloc_bprm+0x28/0x660 fs/exec.c:1431
 class_bprm_constructor fs/exec.c:1496 [inline]
 kernel_execve+0x87/0x930 fs/exec.c:1889
 call_usermodehelper_exec_async+0x212/0x360 kernel/umh.c:109
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

The buggy address belongs to the object at ffff8880273bb658
 which belongs to the cache dentry of size 376
The buggy address is located 208 bytes inside of
 freed 376-byte region [ffff8880273bb658, ffff8880273bb7d0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff8880273bb810 pfn:0x273ba
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x80000000000240(workingset|head|node=0|zone=1)
page_type: f5(slab)
raw: 0080000000000240 ffff88801c68c500 ffff88801c68bb88 ffff88801c68bb88
raw: ffff8880273bb810 000000080012000e 00000000f5000000 0000000000000000
head: 0080000000000240 ffff88801c68c500 ffff88801c68bb88 ffff88801c68bb88
head: ffff8880273bb810 000000080012000e 00000000f5000000 0000000000000000
head: 0080000000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Reclaimable, gfp_mask 0xd20d0(__GFP_RECLAIMABLE|__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1378, tgid 1378 (kworker/u8:6), ts 9289059430, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f9/0x250 mm/page_alloc.c:1859
 prep_new_page mm/page_alloc.c:1867 [inline]
 get_page_from_freelist+0x265c/0x26e0 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5304
 alloc_slab_page mm/slub.c:3288 [inline]
 allocate_slab+0x76/0x5d0 mm/slub.c:3406
 new_slab mm/slub.c:3452 [inline]
 refill_objects+0x2d9/0x350 mm/slub.c:7333
 refill_sheaf mm/slub.c:2826 [inline]
 __pcs_replace_empty_main+0x331/0x690 mm/slub.c:4698
 alloc_from_pcs mm/slub.c:4796 [inline]
 slab_alloc_node mm/slub.c:4929 [inline]
 kmem_cache_alloc_lru_noprof+0x46b/0x6b0 mm/slub.c:4974
 __d_alloc+0x37/0x6f0 fs/dcache.c:1902
 d_alloc_parallel+0xe3/0x1630 fs/dcache.c:2761
 __lookup_slow+0x82/0x2f0 fs/namei.c:1904
 lookup_slow+0x53/0x70 fs/namei.c:1936
 walk_component fs/namei.c:2282 [inline]
 link_path_walk+0xd1e/0x18d0 fs/namei.c:2656
 path_openat+0x22c/0x37e0 fs/namei.c:4855
 do_file_open+0x23e/0x4a0 fs/namei.c:4888
 do_open_execat+0x12b/0x590 fs/exec.c:785
 alloc_bprm+0x28/0x660 fs/exec.c:1431
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880273bb600: fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb fb
 ffff8880273bb680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880273bb700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff8880273bb780: fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc
 ffff8880273bb800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
