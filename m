Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801FD341AD6
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 10:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779964471; cv=none; b=eShMwmdnM/jzxtYEpE7LrdoiS3Bf0Trew6NrQr5SE+BAF2Ewsp22k2068qp0voLjLUCKGQ8hrvC+xTnu6a5DEK3cqnZRu3JFt2fEEku8JQtK/8YxWyp3ZU+Bbxl4/GC1GdmyFBVfLdLdRQCjcqiNGKFoVyor7guy5bZPfqEgxMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779964471; c=relaxed/simple;
	bh=+gG9kxzulC3/UIIRKMFhT0zH08XcSk1nymwD6JcTTpA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lVUZeIw//Kir4dQ072OksOrXsiJC6C3ufA3kV/8EE3YWVxJo8lbMoAgAifhNWBz4ElkuvR+MzBWpAm+ZQo1n7InEZTGdXQhofmWZx5FZMIgdPwygaN1I9OaYY3T03p6FoQ77GMw2hkyOQ0JZIPWp/JGalRM6sf397kiohF5+T6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-69d94704126so5839814eaf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 03:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779964468; x=1780569268;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WxTWhZBQmACy01MS5728RsrbPAjvlvzxraTYTr2OjP0=;
        b=ZhiGXNNanrdiGbEM5rmf3VRWf4Le8+0rV2mI2FDpBoTKL4FdDH3zXwJjJLNq7v/Ird
         bRZsDHMTktm1pUlO5Nth1bEQHxPivzuoCDL8G4Wa59H9suBvmdaYh+7Va0OCaoA0Rbrs
         Qf0wz+wSHCVzY5uJJIjVV0v4tTF84a83c7gX8CS/ck3IKM3Rdzi9vI0eI+Y94BT/t/xQ
         JwZl7Echzd1XR7ME0jwbVE9w2uvVSv5JVTT0XNvmDq0wWKZMxa7iP4chVeiqCaES1vGb
         JsPn5Uu+CcZj+LM3Q4E2ZcRUWrqse3qiqca4/wvGCcgPuD7fXIEvrTjWtdWrHb7qwu23
         rUEg==
X-Forwarded-Encrypted: i=1; AFNElJ8itIw2p5aDnuji4tOeoOcwSbbsdeVH63uCFQYnY2PVyI9ni47iTwK2LijUtaCaQF5qYCX0AYcJa5zff2lC@vger.kernel.org
X-Gm-Message-State: AOJu0Yys+aCl3LwcFxvxMePvJrQDoz+/9MwEit9cfJif71bkxuSzQN4u
	4l4nZJelipMpwjUpwkiraav4lWAdSvC9J4DLLNJMGQYFh2wL5cOiqbMfc3NoMJexA3EUNloCZ4D
	BPacT3nd8lrvJ/h2Swimmg4cX6cUuEVrHM3vWjqJyvIuoufcUlHibrrD1NZk=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:150c:b0:69d:e275:a11 with SMTP id
 006d021491bc7-69de2750c3fmr3685478eaf.55.1779964468413; Thu, 28 May 2026
 03:34:28 -0700 (PDT)
Date: Thu, 28 May 2026 03:34:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a181a34.a5d0663d.c282a.0000.GAE@google.com>
Subject: [syzbot] [kernfs?] INFO: task hung in do_epoll_ctl_file
From: syzbot <syzbot+f83fa2cf571bd7650422@syzkaller.appspotmail.com>
To: brauner@kernel.org, gregkh@linuxfoundation.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c1ecb239fa34 Add linux-next specific files for 20260522
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=123e2ac8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0299bf0261ddd5
dashboard link: https://syzkaller.appspot.com/bug?extid=f83fa2cf571bd7650422
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11997cec580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12672cec580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b8845b668755/disk-c1ecb239.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/517b638d908a/vmlinux-c1ecb239.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dd5e3b587fce/bzImage-c1ecb239.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f83fa2cf571bd7650422@syzkaller.appspotmail.com

INFO: tas[  358.361221][   T39] INFO: task syz.1.18:6030 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.18        state:D stack:26808 pid:6030  tgid:6030  ppid:5779   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5402 [inline]
 __schedule+0x16f9/0x5500 kernel/sched/core.c:7204
 __schedule_loop kernel/sched/core.c:7283 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7579
 rt_mutex_slowlock_block+0x508/0x680 kernel/locking/rtmutex.c:1666
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1743 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1783 [inline]
 rt_mutex_slowlock+0x2dc/0x780 kernel/locking/rtmutex.c:1823
 __rt_mutex_lock kernel/locking/rtmutex.c:1838 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:560 [inline]
 mutex_lock_nested+0x168/0x1d0 kernel/locking/rtmutex_api.c:578
 epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 ep_ctl_lock fs/eventpoll.c:2559 [inline]
 do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
 do_epoll_ctl fs/eventpoll.c:2698 [inline]
 __do_sys_epoll_ctl fs/eventpoll.c:2715 [inline]
 __se_sys_epoll_ctl+0x14e/0x210 fs/eventpoll.c:2706
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa0ef9ece59
RSP: 002b:00007ffe81e0f328 EFLAGS: 00000246 ORIG_RAX: 00000000000000e9
RAX: ffffffffffffffda RBX: 00007fa0efc65fa0 RCX: 00007fa0ef9ece59
RDX: 0000000000000004 RSI: 0000000000000001 RDI: 0000000000000005
RBP: 00007fa0efa82d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000200000000100 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa0efc65fac R14: 00007fa0efc65fa0 R15: 00007fa0efc65fa0
 </TASK>
INFO: task syz.2.19:6031 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.19        state:D stack:26808 pid:6031  tgid:6031  ppid:5786   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5402 [inline]
 __schedule+0x16f9/0x5500 kernel/sched/core.c:7204
 __schedule_loop kernel/sched/core.c:7283 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7579
 rt_mutex_slowlock_block+0x508/0x680 kernel/locking/rtmutex.c:1666
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1743 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1783 [inline]
 rt_mutex_slowlock+0x2dc/0x780 kernel/locking/rtmutex.c:1823
 __rt_mutex_lock kernel/locking/rtmutex.c:1838 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:560 [inline]
 mutex_lock_nested+0x168/0x1d0 kernel/locking/rtmutex_api.c:578
 epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 ep_ctl_lock fs/eventpoll.c:2559 [inline]
 do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
 do_epoll_ctl fs/eventpoll.c:2698 [inline]
 __do_sys_epoll_ctl fs/eventpoll.c:2715 [inline]
 __se_sys_epoll_ctl+0x14e/0x210 fs/eventpoll.c:2706
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4ea623ce59
RSP: 002b:00007ffc16d0ea78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e9
RAX: ffffffffffffffda RBX: 00007f4ea64b5fa0 RCX: 00007f4ea623ce59
RDX: 0000000000000004 RSI: 0000000000000001 RDI: 0000000000000005
RBP: 00007f4ea62d2d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000200000000100 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4ea64b5fac R14: 00007f4ea64b5fa0 R15: 00007f4ea64b5fa0
 </TASK>
INFO: task syz.0.17:6032 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.17        state:D stack:26808 pid:6032  tgid:6032  ppid:5782   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5402 [inline]
 __schedule+0x16f9/0x5500 kernel/sched/core.c:7204
 __schedule_loop kernel/sched/core.c:7283 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7579
 rt_mutex_slowlock_block+0x508/0x680 kernel/locking/rtmutex.c:1666
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1743 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1783 [inline]
 rt_mutex_slowlock+0x2dc/0x780 kernel/locking/rtmutex.c:1823
 __rt_mutex_lock kernel/locking/rtmutex.c:1838 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:560 [inline]
 mutex_lock_nested+0x168/0x1d0 kernel/locking/rtmutex_api.c:578
 epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 ep_ctl_lock fs/eventpoll.c:2559 [inline]
 do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
 do_epoll_ctl fs/eventpoll.c:2698 [inline]
 __do_sys_epoll_ctl fs/eventpoll.c:2715 [inline]
 __se_sys_epoll_ctl+0x14e/0x210 fs/eventpoll.c:2706
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc5b492ce59
RSP: 002b:00007ffcdf2d99c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e9
RAX: ffffffffffffffda RBX: 00007fc5b4ba5fa0 RCX: 00007fc5b492ce59
RDX: 0000000000000004 RSI: 0000000000000001 RDI: 0000000000000005
RBP: 00007fc5b49c2d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000200000000100 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc5b4ba5fac R14: 00007fc5b4ba5fa0 R15: 00007fc5b4ba5fa0
 </TASK>
INFO: task syz.4.21:6033 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.21        state:D stack:26808 pid:6033  tgid:6033  ppid:5790   task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5402 [inline]
 __schedule+0x16f9/0x5500 kernel/sched/core.c:7204
 __schedule_loop kernel/sched/core.c:7283 [inline]
 rt_mutex_schedule+0x76/0xf0 kernel/sched/core.c:7579
 rt_mutex_slowlock_block+0x508/0x680 kernel/locking/rtmutex.c:1666
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1743 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1783 [inline]
 rt_mutex_slowlock+0x2dc/0x780 kernel/locking/rtmutex.c:1823
 __rt_mutex_lock kernel/locking/rtmutex.c:1838 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:560 [inline]
 mutex_lock_nested+0x168/0x1d0 kernel/locking/rtmutex_api.c:578
 epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 ep_ctl_lock fs/eventpoll.c:2559 [inline]
 do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
 do_epoll_ctl fs/eventpoll.c:2698 [inline]
 __do_sys_epoll_ctl fs/eventpoll.c:2715 [inline]
 __se_sys_epoll_ctl+0x14e/0x210 fs/eventpoll.c:2706
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3f07c9ce59
RSP: 002b:00007ffc9dc2e578 EFLAGS: 00000246 ORIG_RAX: 00000000000000e9
RAX: ffffffffffffffda RBX: 00007f3f07f15fa0 RCX: 00007f3f07c9ce59
RDX: 0000000000000004 RSI: 0000000000000001 RDI: 0000000000000005
RBP: 00007f3f07d32d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000200000000100 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3f07f15fac R14: 00007f3f07f15fa0 R15: 00007f3f07f15fa0
 </TASK>

Showing all locks held in the system:
6 locks held by ktimers/1/30:
 #0: ffffffff8de61600 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #1: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #2: ffff8880b8726220 (&base->expiry_lock){+...}-{3:3}, at: spin_lock include/linux/spinlock_rt.h:45 [inline]
 #2: ffff8880b8726220 (&base->expiry_lock){+...}-{3:3}, at: timer_base_lock_expiry kernel/time/timer.c:1502 [inline]
 #2: ffff8880b8726220 (&base->expiry_lock){+...}-{3:3}, at: __run_timer_base+0x120/0x9f0 kernel/time/timer.c:2384
 #3: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #3: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #3: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #3: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1e0/0x400 kernel/locking/spinlock_rt.c:57
 #4: ffffc90000a4fa80 ((&ndev->rs_timer)){+...}-{0:0}, at: call_timer_fn+0xd4/0x5e0 kernel/time/timer.c:1745
 #5: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #5: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #5: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: ndisc_send_skb+0x215/0x1670 net/ipv6/ndisc.c:482
1 lock held by khungtaskd/39:
 #0: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6777
8 locks held by kworker/u8:4/67:
 #0: ffff88813fe84138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x897/0x1630 kernel/workqueue.c:3293
 #1: ffffc9000152fc40 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, at: process_one_work+0x8be/0x1630 kernel/workqueue.c:3294
 #2: ffff8880626608d8 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6885 [inline]
 #2: ffff8880626608d8 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_wiphy_work+0xb4/0x460 net/wireless/core.c:524
 #3: ffffffff8de61600 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #4: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #5: ffff888062660228 (&rdev->bss_lock){+...}-{3:3}, at: spin_lock_bh include/linux/spinlock_rt.h:90 [inline]
 #5: ffff888062660228 (&rdev->bss_lock){+...}-{3:3}, at: cfg80211_inform_single_bss_data+0xbbf/0x1b80 net/wireless/scan.c:2367
 #6: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #6: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #6: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #6: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1e0/0x400 kernel/locking/spinlock_rt.c:57
 #7: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #7: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #7: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1181 [inline]
 #7: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: unwind_next_frame+0xa6/0x2550 arch/x86/kernel/unwind_orc.c:495
6 locks held by kworker/u8:7/405:
 #0: ffff88813fe84138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x897/0x1630 kernel/workqueue.c:3293
 #1: ffffc9000419fc40 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, at: process_one_work+0x8be/0x1630 kernel/workqueue.c:3294
 #2: ffff8880566c08d8 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6885 [inline]
 #2: ffff8880566c08d8 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_wiphy_work+0xb4/0x460 net/wireless/core.c:524
 #3: ffffffff8de61600 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #4: ffffffff8dfcabc0 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
 #5: ffff8880566c0228 (&rdev->bss_lock){+...}-{3:3}, at: spin_lock_bh include/linux/spinlock_rt.h:90 [inline]
 #5: ffff8880566c0228 (&rdev->bss_lock){+...}-{3:3}, at: cfg80211_put_bss+0x5b/0x270 net/wireless/scan.c:3347
4 locks held by kworker/u8:8/1024:
 #0: ffff88813fe84138 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x897/0x1630 kernel/workqueue.c:3293
 #1: ffffc90005c67c40 ((work_completion)(&rdev->wiphy_work)){+.+.}-{0:0}, at: process_one_work+0x8be/0x1630 kernel/workqueue.c:3294
 #2: ffff8880634908d8 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6885 [inline]
 #2: ffff8880634908d8 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: cfg80211_wiphy_work+0xb4/0x460 net/wireless/core.c:524
 #3: ffffffff8de61600 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x3c/0x420 kernel/softirq.c:163
2 locks held by getty/5375:
 #0: ffff8880361670a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003cc62e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x462/0x13a0 drivers/tty/n_tty.c:2211
2 locks held by syz.3.20/6016:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
 #1: ffff888028754058 (&ep->mtx){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #1: ffff888028754058 (&ep->mtx){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2573 [inline]
 #1: ffff888028754058 (&ep->mtx){+.+.}-{4:4}, at: do_epoll_ctl_file+0xc69/0xed0 fs/eventpoll.c:2636
1 lock held by syz.1.18/6030:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.2.19/6031:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.0.17/6032:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.4.21/6033:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.5.22/6168:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.6.23/6240:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.7.24/6241:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.8.25/6245:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.9.26/6246:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.3.27/6289:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.1.28/6406:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.2.29/6467:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.0.30/6476:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.4.31/6481:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.5.32/6482:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.6.33/6535:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.7.34/6704:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.8.35/6724:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.9.36/6735:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.3.37/6737:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
1 lock held by syz.1.38/6739:
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: epoll_mutex_lock fs/eventpoll.c:2512 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: ep_ctl_lock fs/eventpoll.c:2559 [inline]
 #0: ffffffff8e157958 (epnested_mutex){+.+.}-{4:4}, at: do_epoll_ctl_file+0x9d1/0xed0 fs/eventpoll.c:2636
2 locks held by syz-executor/6744:
 #0: ffffffff8eae37a8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8eae37a8 (&ops->srcu#2){.+.+}-{0:0}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8eae37a8 (&ops->srcu#2){.+.+}-{0:0}, at: rtnl_link_ops_get+0x23/0x250 net/core/rtnetlink.c:570
 #1: ffffffff8f37fa78 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #1: ffffffff8f37fa78 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #1: ffffffff8f37fa78 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x883/0x1bb0 net/core/rtnetlink.c:4122

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 39 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:119
 nmi_trigger_cpumask_backtrace+0x17a/0x380 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfd3/0x1030 kernel/hung_task.c:561
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 17 Comm: pr/legacy Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:rdtsc_ordered arch/x86/include/asm/tsc.h:57 [inline]
RIP: 0010:delay_tsc+0x71/0xc0 arch/x86/lib/delay.c:72
Code: 00 00 e8 b2 4a 68 f6 65 8b 05 eb c5 47 07 85 c0 74 1c f3 90 bf 01 00 00 00 e8 fb 48 68 f6 e8 76 86 01 00 39 c5 75 0e 0f 01 f9 <66> 90 eb bd e8 f6 c0 07 f6 eb dd 4c 29 fb e8 5c 86 01 00 89 c5 0f
RSP: 0018:ffffc900001679d0 EFLAGS: 00000246
RAX: 00000000499b963d RBX: 0000000000000899 RCX: 0000000000000001
RDX: 00000000000000ba RSI: ffffffff8ba9cd60 RDI: ffffffff8ba9cd20
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffffff8b2b79f0 R12: 1ffffffff3374446
R13: 00000000ffffffff R14: 000000ba499b91db R15: 000000000000038d
FS:  0000000000000000(0000) GS:ffff888125fec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc83a6dee9c CR3: 00000000352e2000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 udelay include/asm-generic/delay.h:62 [inline]
 wait_for_lsr+0x166/0x2f0 drivers/tty/serial/8250/8250_port.c:1981
 serial8250_fifo_wait_for_lsr_thre drivers/tty/serial/8250/8250_port.c:3212 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3277 [inline]
 serial8250_console_write+0x11c9/0x1b90 drivers/tty/serial/8250/8250_port.c:3362
 console_emit_next_record kernel/printk/printk.c:3163 [inline]
 console_flush_one_record+0x68b/0xb90 kernel/printk/printk.c:3269
 legacy_kthread_func+0x1b6/0x250 kernel/printk/printk.c:3712
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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
