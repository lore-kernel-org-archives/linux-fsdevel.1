Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A80302767
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784985576; cv=none; b=SHBVS/fGjN938vu4UGrqWb+qg588BosSwqIbm3WKuw+mmdOBqGtXqFkr0Wc3M6WQfvug2zDrYicMA5ijIaM0XUUeRD1yOgDWsFO1tMdxcP2EfaGQGzfdAKB4AcbGOUqMxx1UENWVnfWTGMSx63Qv052CbD99DgRbv0fVaz2Joo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784985576; c=relaxed/simple;
	bh=/GHvEU4DvR8iU5S2Wkxo8LoV5+oBHvjw8A06xPVmWcw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JiYYURoAIUf+DZ0Sub8wgvXfRd5SkZh9Y7GGWwqlEyIgiUDZZwykonvMeTkPFKmdjKhJysNhmup727DAG4NkuFgei+6BQ5MGYABRhxHURNAZBKQIPllK+hAMu5OwOM+Zi85/qgCECtBmpFDOevgQzZVqePcFU8FCjXmqZvQlxQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-4a7de733fa9so1607829b6e.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 06:19:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784985573; x=1785590373;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Tt2zqDo8gV42JanURGdhRm83gbjP10nXNsRPce+zbc=;
        b=UkOOWMb43H4tHFxdrfQfOWHGGmUX0UdL7cnt8cnMdYfGudyI78hkkE4u/QPpreCbxF
         3Ta7n8Gd2jV0wOuN8Bshth8S3WuS7adgmg7D+gJxFFb2H/Tm7FlevLV62MrRxvo6N6P1
         jOdGQVncV1ueK1dnhMktE9boBGiJkDYNEtVq/ap9QSn8DEdSsdUcilH+C1jTYc3gBIan
         HMs0Tf6E1IEQFR+AwhsA5r5BuMGPAn+KhZTKC32/tWWWUQn9OkZgelkQKrT70XFOEc3f
         h1N0UMcjAKIdz9nAh9OSt+9h7Yv0ZpgG9WsS37zFDMweIo1y86D5w5KCv52LonvBvDPo
         5HEw==
X-Forwarded-Encrypted: i=1; AHgh+RqlvezMvXgZXcbMwtqAy/eRthFIxDFuEmgrOGp1EYH6l6dPB1kdmAWl2Xuv/OjFjlE620aZ8yBUrUwiwegh@vger.kernel.org
X-Gm-Message-State: AOJu0YwhOGbE2VkfWbizbaKeBS+ZPGNs2nDRthYZfZY2j5UV7797N6Ar
	34gCSEVzIk2GFByeRnpaIMMoLrs7J0QZRZknGISLKq3e2HPnG7u+PjRGFEFdDecrgpK/cRmHx9v
	ZttV+rmBCTxgWY63BCu3vBVi4BnuMwE+Zx4tDizOzY4+d2bev5K5NduQdPBM=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1b21:b0:495:adee:29e9 with SMTP id
 5614622812f47-4ab6a3e85b9mr2031099b6e.41.1784985573428; Sat, 25 Jul 2026
 06:19:33 -0700 (PDT)
Date: Sat, 25 Jul 2026 06:19:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a64b7e5.70955b6c.323240.001d.GAE@google.com>
Subject: [syzbot] [net?] [fs?] possible deadlock in rht_lock
From: syzbot <syzbot+ef8d17bae14efb960935@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    94515f3a7d42 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=119bf789580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c4196ba0e33631d
dashboard link: https://syzkaller.appspot.com/bug?extid=ef8d17bae14efb960935
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148d72b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105a1746580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f43aa5dbbaea/disk-94515f3a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d34e80893dbb/vmlinux-94515f3a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/62b4a6d766f6/bzImage-94515f3a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ef8d17bae14efb960935@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz-executor/5768 is trying to acquire lock:
ffff88807d7f7038 (rhashtable_bucket){-.-.}-{0:0}, at: rht_lock+0x8b/0x180 include/linux/rhashtable.h:331

but task is already holding lock:
ffff88802cc48038 (rhashtable_bucket){-.-.}-{0:0}, at: rht_lock+0x8b/0x180 include/linux/rhashtable.h:331

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(rhashtable_bucket);
  lock(rhashtable_bucket);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

5 locks held by syz-executor/5768:
 #0: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #0: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #0: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: __rhashtable_insert_fast include/linux/rhashtable.h:774 [inline]
 #0: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rhashtable_insert_fast include/linux/rhashtable.h:887 [inline]
 #0: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: pidfs_add_pid+0x169/0xc50 fs/pidfs.c:178
 #1: ffff88802cc48038 (rhashtable_bucket){-.-.}-{0:0}, at: rht_lock+0x8b/0x180 include/linux/rhashtable.h:331
 #2: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #2: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #2: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: trace_call_bpf+0xb6/0xb80 kernel/trace/bpf_trace.c:-1
 #3: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #3: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #3: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: class_rcu_constructor include/linux/rcupdate.h:1183 [inline]
 #3: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rhtab_map_delete_elem+0x21/0x190 kernel/bpf/hashtab.c:2979
 #4: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #4: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:840 [inline]
 #4: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: __rhashtable_remove_fast include/linux/rhashtable.h:1137 [inline]
 #4: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rhashtable_remove_fast include/linux/rhashtable.h:1175 [inline]
 #4: ffffffff8eb59c60 (rcu_read_lock){....}-{1:3}, at: rhtab_delete_elem+0x15c/0x1b30 kernel/bpf/hashtab.c:-1

stack backtrace:
CPU: 1 UID: 0 PID: 5768 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/25/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_deadlock_bug+0x279/0x290 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x24df/0x2cf0 kernel/locking/lockdep.c:5237
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5868
 rht_lock+0xa3/0x180 include/linux/rhashtable.h:331
 __rhashtable_remove_fast_one include/linux/rhashtable.h:1065 [inline]
 __rhashtable_remove_fast include/linux/rhashtable.h:1146 [inline]
 rhashtable_remove_fast include/linux/rhashtable.h:1175 [inline]
 rhtab_delete_elem+0x404/0x1b30 kernel/bpf/hashtab.c:2954
 rhtab_map_delete_elem+0xe2/0x190 kernel/bpf/hashtab.c:2985
 bpf_prog_a4f1e23443ac9f8e+0x4e/0x56
 bpf_dispatcher_nop_func include/linux/bpf.h:1454 [inline]
 __bpf_prog_run include/linux/filter.h:724 [inline]
 bpf_prog_run include/linux/filter.h:731 [inline]
 bpf_prog_run_array include/linux/bpf.h:2597 [inline]
 trace_call_bpf+0x3f0/0xb80 kernel/trace/bpf_trace.c:147
 perf_trace_run_bpf_submit+0x78/0x170 kernel/events/core.c:11398
 do_perf_trace_lock include/trace/events/lock.h:49 [inline]
 perf_trace_lock+0x32d/0x410 include/trace/events/lock.h:49
 __do_trace_lock_release include/trace/events/lock.h:68 [inline]
 trace_lock_release include/trace/events/lock.h:68 [inline]
 lock_release+0x38e/0x3c0 kernel/locking/lockdep.c:5879
 rht_assign_unlock include/linux/rhashtable.h:431 [inline]
 __rhashtable_insert_fast include/linux/rhashtable.h:850 [inline]
 rhashtable_insert_fast include/linux/rhashtable.h:887 [inline]
 pidfs_add_pid+0x650/0xc50 fs/pidfs.c:178
 alloc_pid+0xe7a/0x1310 kernel/pid.c:338
 copy_process+0x20ea/0x4390 kernel/fork.c:2305
 kernel_clone+0x2d7/0x940 kernel/fork.c:2748
 __do_sys_clone kernel/fork.c:2889 [inline]
 __se_sys_clone kernel/fork.c:2873 [inline]
 __x64_sys_clone+0x1b6/0x230 kernel/fork.c:2873
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f703d7c6912
Code: 89 e7 e8 71 8b f7 ff 45 31 c0 31 d2 31 f6 64 48 8b 04 25 10 00 00 00 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 66 89 c5 85 c0 75 3b 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffe5db74e40 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffe5db74e40 RCX: 00007f703d7c6912
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 00007ffe5db74fcc R08: 0000000000000000 R09: 0000000000000000
R10: 000055556f65e7d0 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000000927c0 R14: 0000000000025e7d R15: 00007ffe5db75020
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
