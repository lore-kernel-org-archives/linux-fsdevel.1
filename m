Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DAA3F1AB2;
	Wed,  1 Jul 2026 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902808; cv=none; b=TGppDX0HZHb0ttSGNxjM9gjc4TguqSwxBOisd4mh2VRVoDNYfzRmSnbqtBGpfgsYCH0mKSfvdLBklf+CqCLKMSgAbdShSlbR7tMrtJqdsNxw6t47lDWck0ZAmreFymS1n8A8T04bViarM5xQzX4Jq2zRzkIHPRUSU9L1oD+XJDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902808; c=relaxed/simple;
	bh=hhieELwgg5yCYcpe5KPfJHR7CeKxIhfLGjeP0D3Mb6s=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Y9CyWrBcIasNChpGa3NRNi8Zt1TQ9BUuzVGpkcSoKyBI4Te7xyoiAWrA/REfVw46jan7I6grIC5vosFsc3MlK0ExJ+yUEyxChplioitxjLa+c594Hkudb+xKekVZmx5IW6ZUHXikppZ3qzqWPZ3qHiyYOBvZpSNVgC6LULdWz7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=K9gkSy04; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="K9gkSy04"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1782902768;
	bh=mzZWQKB1OwOduP2E2sleeDah/NAIEr1UJF0Js1CBHJE=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=K9gkSy04jH/vkSlJlbPq04dXW7EoDNSKAMTdlXi4cDynhpE7H1bwqb3QuivJ+Muz/
	 T2jaxiGnBO5BOAEsOjvIG0DKSxpjIWQ2+JocKJarxvzDzIAZjq08KiNwaG/L0m74Lc
	 FM7z6a5rTVh8brXgAG7RGfgOAlRGeztDLuQmY8mA=
X-QQ-mid: esmtpsz19t1782902766t7aa7375a
X-QQ-Originating-IP: vmyvT3ticviOmTrIssK7i81PsjsZ/Qctak6QV5xG12A=
Received: from [172.27.139.54] ( [218.94.142.77])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 01 Jul 2026 18:46:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18292100359742010705
Message-ID: <AB8D5E603E6EA856+ae5f622a-dd3a-4e38-bdd2-42276ae0e1a8@smail.nju.edu.cn>
Date: Wed, 1 Jul 2026 18:46:04 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Namjae Jeon <linkinjeon@kernel.org>, hyc.lee@gmail.com
Cc: syzkaller@googlegroups.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [BUG] ntfs: task hung in find_inode due to self-deadlock in
 ntfs_attrlist_update() during unmount
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NK1jrlzPMOAHnPTPSehpKNiBaRqHeFVh4EEsnI0QrZeMmbeYWVGQC3tl
	smSTHooeJFDvJdt9cqq0nX0uIJ7a53LwoWTLy74ESpkzsdPl/AtXGyyENB5xnldZSjmXG7/
	k5ijzjigy6EzQDXxdyGpeaiij9n6LVJdFeyf9+Ow/pJgep/yENKMuWOOKfaOghBJGOv/vhj
	WnlcgrX+HI75ayUL5vMN+wcYV/Dyx6s4Kk7GGAFIUw8V+2MjOoE2lCKLACeIemo0OPrNZWx
	KXVvg2wgMODVhbML2/6bdFE+MHUbUjisRUYtv1WjiX2ISrTCIAmmfTVnxmxoTguA6qI57UM
	zEetmlfIU1Dz45pgh/nZFp6NJgQqt+O5C3y247IOO4j/kjy5oJmXfno+7K08LDMB6HUdpKk
	a7DTK0mMgUJkK65wbhcbTWqCmfckA2KMeUY8asK37RVKoCMDvpU5GwMYHKTauzx+RHYphzn
	uincBwDTepgV01INj/vVonIlKJ2dPSpi1muUbJi5aG0aQCL+by4ke6yrKvnNHRebw3Hxsyv
	+Tz1O8onm4seGRiUdeDD6FnxprPlJqIuOzZlDOFGvpn+JfT1cvmaj4C3IKP56wnjNl2J6e5
	7oikrT+N+4mUTO68ntZ7ndVlZ9r+0J24J7dvQgrmj2mVNWBtaXMJnpIs4W8Xz7WIIZvViiU
	uDaoyI9GYWnVnQRbQK+9aC2dTfL/yMRMIuWt/wApP+hHkgE3AlSH70rFB3Ay8Fu2pIhMVd8
	u/i9jqd7PbrmUmasLLpBvNJS49tf6THqcfuWsOy+Z79OhV3/9scNvwDbjc6cIoqBHpp6nhG
	xQVQg183u4hNPYGKDW5zXBElE9WPvfGfgLgkmA4HgbVpXEm1ummek/QHW0TpAfqNZZ4ihrJ
	disBaJnLxuAisqHgpooi3w9mFRnGH+DBMhYp4ywzV/GWDe3J1MUNbTHPC3ajGvsWzA0efQc
	OAbEMBA8hmKTVwzeVH4E1oyzBEn6+NSpo/H8QSJv3Zec8jQ+YTKHRdKN+ILiAygKXSdP8eN
	+QdRL6B9rccfS044zEhGDQjpK1VP9jvyg4KwoHyg==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

Hello Linux kernel developers and maintainers,

We found a task hung in find_inode when fuzzing the new NTFS with Syzkaller.

Although find_inode() itself is defined in fs/inode.c, but after our digging, 
we believe the root cause lies in fs/ntfs/attrlist.c:
ntfs_attrlist_update() *unconditionally* calls ntfs_attr_iget() during teardown,
unlike __ntfs_write_inode(), which guards its ntfs_inode_sync_filename() call
with SB_ACTIVE. This allows re-entering lookup of an I_FREEING fake attribute inode 
and causes task hung. Detailed root cause analysis is given below.

Kernel version: commit 8cd9520d35a6c38db6567e97dd93b1f11f185dc6 (tag v7.1).
And we believe the bug is also possible in the current mainline. 
Note that the code line numbers in the following analysis are also based on this kernel version.

Relevant kernel config:

CONFIG_NTFS_FS=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DETECT_HUNG_TASK_BLOCKER=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=140
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_DEBUG_MUTEXES=y

================
Syzkaller report
================

INFO: task syz-executor:8166 blocked for more than 143 seconds.
      Not tainted 7.1.0 #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:22408 pid:8166  tgid:8166  ppid:1      task_flags:0x400140 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5388 [inline]
 __schedule+0x1f62/0x6760 kernel/sched/core.c:7189
 __schedule_loop kernel/sched/core.c:7268 [inline]
 schedule+0xdd/0x380 kernel/sched/core.c:7283
 __wait_on_freeing_inode+0x2fe/0x3f0 fs/inode.c:2560
 find_inode+0x2ac/0x910 fs/inode.c:1061
 ilookup5_nowait fs/inode.c:1620 [inline]
 ilookup5+0x123/0x210 fs/inode.c:1653
 iget5_locked+0x37/0xb0 fs/inode.c:1379
 ntfs_attr_iget+0x13a/0x2a50 fs/ntfs/inode.c:224
 ntfs_attrlist_update+0x32/0x630 fs/ntfs/attrlist.c:60
 ntfs_attr_update_mapping_pairs+0xc58/0x32a0 fs/ntfs/attrib.c:3712
 ntfs_attr_map_cluster+0x9b5/0x1010 fs/ntfs/attrib.c:4948
 ntfs_write_da_iomap_begin_non_resident fs/ntfs/iomap.c:588 [inline]
 ntfs_write_iomap_begin_non_resident fs/ntfs/iomap.c:727 [inline]
 __ntfs_write_iomap_begin+0x11a9/0x2730 fs/ntfs/iomap.c:764
 ntfs_writeback_range+0x100/0x180 fs/ntfs/iomap.c:868
 iomap_writeback_range fs/iomap/buffered-io.c:1777 [inline]
 iomap_writeback_folio+0x985/0x1f30 fs/iomap/buffered-io.c:1896
 iomap_writepages+0x13e/0x2a0 fs/iomap/buffered-io.c:1959
 ntfs_writepages+0x221/0x290 fs/ntfs/aops.c:270
 do_writepages+0x278/0x600 mm/page-writeback.c:2571
 __writeback_single_inode+0x165/0x1420 fs/fs-writeback.c:1764
 writeback_single_inode+0x425/0x10b0 fs/fs-writeback.c:1883
 write_inode_now+0x170/0x1e0 fs/fs-writeback.c:2974
 iput_final fs/inode.c:1950 [inline]
 iput fs/inode.c:2009 [inline]
 iput+0x541/0xd30 fs/inode.c:1972
 ntfs_evict_big_inode+0x970/0x12d0 fs/ntfs/inode.c:2307
 evict+0x3c2/0xad0 fs/inode.c:841
 dispose_list+0x117/0x1e0 fs/inode.c:883
 evict_inodes+0x51b/0x6b0 fs/inode.c:937
 generic_shutdown_super+0xc2/0x390 fs/super.c:632
 kill_block_super+0x3b/0x90 fs/super.c:1725
 deactivate_locked_super+0xc1/0x1a0 fs/super.c:476
 deactivate_super fs/super.c:509 [inline]
 deactivate_super+0xe2/0x100 fs/super.c:505
 cleanup_mnt+0x21f/0x450 fs/namespace.c:1312
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:67 [inline]
 exit_to_user_mode_loop+0x107/0x4e0 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x629/0x800 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff86cba928b
RSP: 002b:00007ffd8f1a5568 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 00007ff86cc4dddb RCX: 00007ff86cba928b
RDX: 00007ff86ca52f01 RSI: 0000000000000009 RDI: 00007ffd8f1a5620
RBP: 00007ffd8f1a5620 R08: 0000000000000073 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd8f1a66f0
R13: 00007ff86cc4dddb R14: 0000000000000032 R15: 00000000001c775f
 </TASK>

Showing all locks held in the system:
1 lock held by systemd/1:
1 lock held by khungtaskd/31:
 #0: ffffffff8dfc4fa0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8dfc4fa0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8dfc4fa0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
1 lock held by syz-executor/8165:
3 locks held by syz-executor/8166:
 #0: ffff888046e220d8 (&type->s_umount_key#74){++++}-{4:4}, at: __super_lock fs/super.c:58 [inline]
 #0: ffff888046e220d8 (&type->s_umount_key#74){++++}-{4:4}, at: __super_lock_excl fs/super.c:73 [inline]
 #0: ffff888046e220d8 (&type->s_umount_key#74){++++}-{4:4}, at: deactivate_super fs/super.c:508 [inline]
 #0: ffff888046e220d8 (&type->s_umount_key#74){++++}-{4:4}, at: deactivate_super+0xda/0x100 fs/super.c:505
 #1: ffff8880525e56f8 (&ni->mrec_lock){+.+.}-{4:4}, at: ntfs_write_iomap_begin_non_resident fs/ntfs/iomap.c:722 [inline]
 #1: ffff8880525e56f8 (&ni->mrec_lock){+.+.}-{4:4}, at: __ntfs_write_iomap_begin+0xfff/0x2730 fs/ntfs/iomap.c:764
 #2: ffff8880525e5630 (&rl->lock){++++}-{4:4}, at: ntfs_write_da_iomap_begin_non_resident fs/ntfs/iomap.c:587 [inline]
 #2: ffff8880525e5630 (&rl->lock){++++}-{4:4}, at: ntfs_write_iomap_begin_non_resident fs/ntfs/iomap.c:727 [inline]
 #2: ffff8880525e5630 (&rl->lock){++++}-{4:4}, at: __ntfs_write_iomap_begin+0x115e/0x2730 fs/ntfs/iomap.c:764
1 lock held by syz-executor/8171:
2 locks held by syz-executor/8186:
 #0: ffff888048b2cea0 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close+0x26/0xc0 net/bluetooth/hci_core.c:500
 #1: ffffffff8dfcfbe8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock+0x1a0/0x3c0 kernel/rcu/tree_exp.h:343
1 lock held by syz-executor/8212:
 #0: ffff888056fc4ea0 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close+0x26/0xc0 net/bluetooth/hci_core.c:500
3 locks held by kworker/0:1/15231:
 #0: ffff888015c6f140 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1308/0x1c30 kernel/workqueue.c:3289
 #1: ffffc90003be7ce8 (free_ipc_work){+.+.}-{0:0}, at: process_one_work+0x96d/0x1c30 kernel/workqueue.c:3290
 #2: ffffffff8dfcfbe8 (rcu_state.exp_mutex){+.+.}-{4:4}, at: exp_funnel_lock+0x281/0x3c0 kernel/rcu/tree_exp.h:311

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 7.1.0 #2 PREEMPT(full) 
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x10e/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x280/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x133/0x180 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:353 [inline]
 watchdog+0xfe1/0x1650 kernel/hung_task.c:561
 kthread+0x367/0x480 kernel/kthread.c:436
 ret_from_fork+0x72b/0xd50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 8171 Comm: syz-executor Not tainted 7.1.0 #2 PREEMPT(full) 
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__debug_check_no_obj_freed lib/debugobjects.c:1146 [inline]
RIP: 0010:debug_check_no_obj_freed+0x210/0x600 lib/debugobjects.c:1184
Code: 00 00 48 89 c2 31 f6 49 89 df 4c 89 74 24 28 48 c1 ea 03 89 f3 42 80 3c 22 00 0f 85 dd 00 00 00 48 8d 78 18 83 c3 01 4c 8b 30 <48> 89 fa 48 c1 ea 03 42 80 3c 22 00 0f 85 0c 03 00 00 48 8b 50 18
RSP: 0018:ffffc900021bfa60 EFLAGS: 00000002
RAX: ffff8880276e2dc8 RBX: 0000000000000002 RCX: ffffffff819ac5e8
RDX: 1ffff11004edc5b9 RSI: 0000000000000000 RDI: ffff8880276e2de0
RBP: ffffc900021bfb90 R08: 0000000000000001 R09: fffff52000437f3a
R10: 0000000000000003 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88806b94a000 R14: 0000000000000000 R15: ffff88806b94b000
FS:  0000000000000000(0000) GS:ffff8880eb991000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc2764fcc48 CR3: 000000000dd88000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __free_pages_prepare mm/page_alloc.c:1404 [inline]
 __free_frozen_pages+0x3c4/0xfc0 mm/page_alloc.c:2938
 vfree mm/vmalloc.c:3472 [inline]
 vfree+0x180/0x970 mm/vmalloc.c:3436
 kcov_put kernel/kcov.c:442 [inline]
 kcov_put kernel/kcov.c:438 [inline]
 kcov_close+0x34/0x60 kernel/kcov.c:543
 __fput+0x402/0xb80 fs/file_table.c:510
 task_work_run+0x150/0x240 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x946/0x2bb0 kernel/exit.c:976
 do_group_exit+0xd5/0x2a0 kernel/exit.c:1119
 __do_sys_exit_group kernel/exit.c:1130 [inline]
 __se_sys_exit_group kernel/exit.c:1128 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1128
 x64_sys_call+0x12e2/0x1880 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffafd9a788d
Code: Unable to access opcode bytes at 0x7ffafd9a7863.
RSP: 002b:00007ffe4f4db6f8 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007ffafda4f933 RCX: 00007ffafd9a788d
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000043
RBP: 00007ffafda4f945 R08: 0000000000000000 R09: 0000000000000032
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000010
R13: 00000000001c7a20 R14: 0000000000000032 R15: 00000000001c79b6
 </TASK>

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

==========
Root cause
==========

A = the NTFS base inode whose delayed allocation / mapping pairs are being
    written back.

B = the fake NTFS attribute inode for A's unnamed $ATTRIBUTE_LIST attribute,
    i.e. the inode returned by ntfs_attr_iget(VFS_I(A), AT_ATTRIBUTE_LIST, AT_UNNAMED, 0)

Timeflow (all code should be executed within one task):

1. The task starts unmounting the NTFS filesystem that contains A:

        cleanup_mnt()                    fs/namespace.c:1292
        --> deactivate_super()           fs/super.c:505
        --> deactivate_locked_super()    fs/super.c:471
            --> fs->kill_sb(s)           fs/super.c:476
                /* ntfs_fs_type.kill_sb is kill_block_super. */
                                           fs/ntfs/super.c:2645
        --> kill_block_super()           fs/super.c:1721
        --> generic_shutdown_super()     fs/super.c:618

   generic_shutdown_super() clears SB_ACTIVE and then evicts cached inodes:

        sb->s_flags &= ~SB_ACTIVE        fs/super.c:626
        evict_inodes(sb)                 fs/super.c:632

2. evict_inodes(sb) selects B, marks it I_FREEING, and the same task starts
   evicting B:

        evict_inodes(sb)                 fs/inode.c:897
        --> inode_state_set(B, I_FREEING)
                                           fs/inode.c:918
        --> dispose_list(&dispose)       fs/inode.c:875
        --> evict(B)                     fs/inode.c:883
        --> ntfs_evict_big_inode(B)      fs/ntfs/inode.c:2261

   B is a fake attribute inode.  During its eviction, NTFS drops B's reference
   on its base inode A:

        iput(VFS_I(B->ext.base_ntfs_ino))
                                           fs/ntfs/inode.c:2307

   At this point B is still in the inode hash.  VFS removes B from the hash
   and wakes __wait_on_freeing_inode() waiters only after
   ntfs_evict_big_inode(B) returns:

        remove_inode_hash(B)             fs/inode.c:849
        inode_wake_up_bit(B, __I_NEW)    fs/inode.c:862

3. The iput(A) from ntfs_evict_big_inode(B) starts synchronous writeback of A:

        iput(A)                         fs/inode.c:1972
        --> iput_final(A)               fs/inode.c:1916
        --> write_inode_now(A, 1)       fs/fs-writeback.c:2961
        --> ntfs_writepages(A->i_mapping)
                                          fs/ntfs/aops.c:244
        --> ntfs_writeback_range(... A ...)
                                          fs/ntfs/iomap.c:861

   SB_ACTIVE is already clear, so iput_final(A) cannot keep A on the inode LRU.
   It has to write and evict A.

4. A's writeback updates mapping pairs and then updates A's attribute list:

        __ntfs_write_iomap_begin(A, ...)
                                          fs/ntfs/iomap.c:868
        --> ntfs_attr_map_cluster(A, ...)
                                          fs/ntfs/attrib.c:4948
        --> ntfs_attr_update_mapping_pairs(A, 0)
                                          fs/ntfs/attrib.c:3535
        --> ntfs_attrlist_update(A)      fs/ntfs/attrib.c:3712
        --> ntfs_attr_iget(VFS_I(A),
                           AT_ATTRIBUTE_LIST, AT_UNNAMED, 0)
                                          fs/ntfs/attrlist.c:60
                                          fs/ntfs/inode.c:209

   This attempts to get B *again* while B is still being evicted.

5. ntfs_attr_iget() reaches find_inode().  find_inode() finds B, sees that B
   already has I_FREEING set, and sleeps waiting for B's eviction to finish:

        iget5_locked()                  fs/ntfs/inode.c:224
                                         fs/inode.c:1375
        --> find_inode()                fs/inode.c:1040
        --> __wait_on_freeing_inode(B)  fs/inode.c:1061
                                         fs/inode.c:2537
        --> schedule()                  fs/inode.c:2560

   This is a self-deadlock.  The task waits for B's eviction to complete, but
   the only code that can complete B's eviction is the later part of evict(B),
   after ntfs_evict_big_inode(B) returns.  The same task cannot return there
   because it is now sleeping in the nested find_inode() path.

============
Proposed fix
============

__ntfs_write_inode() in fs/ntfs/inode.c already handled a very similar teardown-time
problem. Its comment says that when NTFS is being unmounted and inodes are
evicted, write_inode() can be called with all inodes marked I_FREEING; in that
state, ntfs_inode_sync_filename() may wait forever because it calls ntfs_iget().

__ntfs_write_inode() handles this correctly by treating a cleared SB_ACTIVE as
the unmount/teardown signal and skipping ntfs_inode_sync_filename() in that
state:

        if ((vi->i_sb->s_flags & SB_ACTIVE) && NInoTestClearFileNameDirty(ni))
                ntfs_inode_sync_filename(ni);
                                            fs/ntfs/inode.c:2762

So we propose to fix ntfs_attrlist_update() with the same guard,
i.e., ntfs_attrlist_update() should not try to iget the AT_ATTRIBUTE_LIST
fake attribute inode after SB_ACTIVE has been cleared:

        int ntfs_attrlist_update(struct ntfs_inode *base_ni)
        {
                if (!(VFS_I(base_ni)->i_sb->s_flags & SB_ACTIVE))
                        return -EIO;

                attr_vi = ntfs_attr_iget(VFS_I(base_ni), AT_ATTRIBUTE_LIST, AT_UNNAMED, 0);
                ...
        }

One question: should we return 0 or an error?

====
Note
====
LLM assistance was used when analyzing the root cause and writing this report.
But we have made our best effort to ensure the description and analysis in
this report are accurate and correct.

Also we are happy to make a patch if the proposed fix is considered reasonable.

Thanks,
Peiyang
