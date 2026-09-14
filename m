Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277893955D1
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789413460; cv=none; b=ZJMZZuGHsZmy2evS4iYoi15bsaC8YR+hqaUKITSXhW1rCKdxvubCBoFCsiRV/kskbnGfWyuRiD4JIJzikPoeeJ2LtdbuTAl3T9oNqluRrmMC4eookjYHU+2VhUNInqtFuY448vZigz2WkAYPXKTG1xLBa3PbPOXyXkW1/eFgTVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789413460; c=relaxed/simple;
	bh=yom6kTnMguYwNWk6qOj/thh6qLO8yOVxYIgU9rjyRy8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VcOO7FUJ3fdSiQXjA7agK006yc5pBhWQwrvEeAq8C92Mryh4KEL9pK8p1bKKFNLGcuSLH4jQXVnAKe6WYC6EZnye7/8HLYJY/6oNNmgApbdoEpvwiR6S4meVU5UHKSVvfZH0s9xj0HbC0bZLHtYvBFctcP4g4Dl/ylRvVW+sBlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f8.google.com with SMTP id 006d021491bc7-6b1bf394d3bso549783eaf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 12:17:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789413457; x=1790018257;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ekHSujZ932WooFHmacuU20SolwiHbECmUQMmL2g+luU=;
        b=OkOxS24y8hVEbNyWFwPkuVOSPiQcO47yDOTvKhwlxYj3xtO5p1GhFck6QLGtmEaFnd
         OWLMZzyR8R8XLrku+a/4niFHFm6V8ZPVEyn+rOiqeZ+5HeL/jpc1OB8dKYYWjGtXrtnS
         q8J9Z/E1d3ZrR3YhteAXQ4fbuMhj7FJl4KExBOPVugJVxOSG68g+ZP9dWK3PSSyL6Ghm
         hlHGjuUKH4Bg6kG6Wtja0Gu0TmucVQ1QPulfUpGiVXOR7oYp0Oi5hItfeUP1Cu2O7wQg
         o6bq8dWc1BA6jf2OOUxIWYxm2z8I5pNNbrWu5QtblFFwDX8e5Lhh50QAVDrSndiOfDiJ
         yj3Q==
X-Forwarded-Encrypted: i=1; AKwUvByzgajdylGtVkvpM3pR4ZUf1qdms/dzWWtRgN7dpNsLJghq4hQ8GRot12dl7QYCMw8eCDX8LJEElyJGqOby@vger.kernel.org
X-Gm-Message-State: AFuF++kj1iqlw8TdZGjnfS/HJtbAld7pv9IFBGMSychQzlhOax/fii5i
	VoY+0O80nEu0e8LPyGenbtuFv/YU8Tj/qE2RFRgNGcCc2YCzES4u2szLUek/Bh7AoL7uxTtJKZq
	R3PQtJZ7nr8aWKcQ2iRHqh5ZJweFx6+kSzIPPVVerm4+rrWqjz+tVg9YL0uk=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:221f:b0:6a1:77ce:1b09 with SMTP id
 006d021491bc7-6c53ee55e0cmr3296277eaf.6.1789413456943; Mon, 14 Sep 2026
 12:17:36 -0700 (PDT)
Date: Mon, 14 Sep 2026 12:17:36 -0700
In-Reply-To: <6a1b9770.fd5edf16.2e7427.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa84850.f81106d8.2ab401.0053.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in page_cache_ra_order
From: syzbot <syzbot+8bd419f88e25ab12cb75@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, almaz.alexandrovich@paragon-software.com, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    704340f1cd0d Merge tag 'x86_urgent_for_7.3-rc4' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14118df9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=8bd419f88e25ab12cb75
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154788c9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134788c9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a1f812f889ad/disk-704340f1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8aa4ccae83ac/vmlinux-704340f1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f86a50bf181/bzImage-704340f1.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/54fd657ced87/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8bd419f88e25ab12cb75@syzkaller.appspotmail.com

ntfs3(loop1): ino=1f, mi_enum_attr
ntfs3(loop1): Mark volume as dirty due to NTFS errors
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.1.68/6182 is trying to acquire lock:
ffff88803364abd0 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:1089 [inline]
ffff88803364abd0 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: do_page_cache_ra mm/readahead.c:347 [inline]
ffff88803364abd0 (mapping.invalidate_lock#3){.+.+}-{4:4}, at: page_cache_ra_order+0x2b1/0x4a0 mm/readahead.c:558

but task is already holding lock:
ffff88803364aee0 (&ni->ni_lock/5){+.+.}-{4:4}, at: ni_lock fs/ntfs3/ntfs_fs.h:1247 [inline]
ffff88803364aee0 (&ni->ni_lock/5){+.+.}-{4:4}, at: ntfs_readdir+0x717/0xf70 fs/ntfs3/dir.c:541

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ni->ni_lock/5){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:561 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:580
       ni_lock fs/ntfs3/ntfs_fs.h:1247 [inline]
       attr_data_get_block+0x1cd/0x2c0 fs/ntfs3/attrib.c:976
       ntfs_iomap_begin+0x4f0/0xf30 fs/ntfs3/inode.c:978
       iomap_iter_next include/linux/iomap.h:382 [inline]
       ntfs_iomap_next+0x5b6/0x880 fs/ntfs3/inode.c:2319
       iomap_iter+0xe2/0xec0 fs/iomap/iter.c:122
       iomap_readahead+0xa4a/0xe80 fs/iomap/buffered-io.c:751
       ntfs_readahead+0x193/0x210 fs/ntfs3/inode.c:880
       read_pages+0x193/0x5a0 mm/readahead.c:174
       page_cache_ra_unbounded+0x679/0x8f0 mm/readahead.c:315
       do_page_cache_ra mm/readahead.c:348 [inline]
       page_cache_ra_order+0x2c1/0x4a0 mm/readahead.c:558
       filemap_get_pages+0x493/0x1e80 mm/filemap.c:2714
       filemap_read+0x429/0x11e0 mm/filemap.c:2824
       __kernel_read+0x4d3/0x970 fs/read_write.c:532
       integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:222 [inline]
       ima_calc_file_hash+0x45d/0x8a0 security/integrity/ima/ima_crypto.c:280
       ima_collect_measurement+0x521/0xa10 security/integrity/ima/ima_api.c:300
       process_measurement+0x1282/0x1c20 security/integrity/ima/ima_main.c:425
       ima_file_check+0xe1/0x130 security/integrity/ima/ima_main.c:685
       security_file_post_open+0xb3/0x260 security/security.c:2755
       do_open fs/namei.c:4839 [inline]
       path_openat+0x148a/0x1d60 fs/namei.c:5000
       do_file_open+0x23e/0x4a0 fs/namei.c:5029
       do_sys_openat2+0x115/0x200 fs/open.c:1417
       do_sys_open fs/open.c:1423 [inline]
       __do_sys_openat fs/open.c:1439 [inline]
       __se_sys_openat fs/open.c:1434 [inline]
       __x64_sys_openat+0x138/0x170 fs/open.c:1434
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (mapping.invalidate_lock#3){.+.+}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3209 [inline]
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
       down_read+0x97/0x200 kernel/locking/rwsem.c:1574
       filemap_invalidate_lock_shared include/linux/fs.h:1089 [inline]
       do_page_cache_ra mm/readahead.c:347 [inline]
       page_cache_ra_order+0x2b1/0x4a0 mm/readahead.c:558
       do_sync_mmap_readahead+0x4d6/0x7c0 mm/filemap.c:3443
       filemap_fault+0x7e2/0x13c0 mm/filemap.c:3597
       __do_fault+0x138/0x2a0 mm/memory.c:5565
       do_shared_fault mm/memory.c:6064 [inline]
       do_fault mm/memory.c:6138 [inline]
       do_pte_missing+0x659/0x28f0 mm/memory.c:4700
       handle_pte_fault mm/memory.c:6558 [inline]
       __handle_mm_fault mm/memory.c:6707 [inline]
       handle_mm_fault+0xf64/0x28c0 mm/memory.c:6876
       do_user_addr_fault+0x746/0x1340 arch/x86/mm/fault.c:1394
       handle_page_fault arch/x86/mm/fault.c:1483 [inline]
       exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1536
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:595
       stac arch/x86/include/asm/smap.h:-1 [inline]
       filldir+0x29f/0x630 fs/readdir.c:286
       dir_emit include/linux/fs.h:3607 [inline]
       ntfs_dir_emit fs/ntfs3/dir.c:388 [inline]
       ntfs_read_hdr+0x8a7/0xc10 fs/ntfs3/dir.c:429
       ntfs_readdir+0x9ab/0xf70 fs/ntfs3/dir.c:589
       iterate_dir+0x2f1/0x4e0 fs/readdir.c:110
       __do_sys_getdents fs/readdir.c:319 [inline]
       __se_sys_getdents+0xf1/0x270 fs/readdir.c:304
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->ni_lock/5);
                               lock(mapping.invalidate_lock#3);
                               lock(&ni->ni_lock/5);
  rlock(mapping.invalidate_lock#3);

 *** DEADLOCK ***

locks held by syz.1.68/6182: 3, last CPU#0:
 #0: ffff88803c3c2328 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1259
 #1: ffff88803364b1a8 (&type->i_mutex_dir_key#8){++++}-{4:4}, at: iterate_dir+0x215/0x4e0 fs/readdir.c:103
 #2: ffff88803364aee0 (&ni->ni_lock/5){+.+.}-{4:4}, at: ni_lock fs/ntfs3/ntfs_fs.h:1247 [inline]
 #2: ffff88803364aee0 (&ni->ni_lock/5){+.+.}-{4:4}, at: ntfs_readdir+0x717/0xf70 fs/ntfs3/dir.c:541

stack backtrace:
CPU: 0 UID: 0 PID: 6182 Comm: syz.1.68 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2087
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2219
 check_prev_add kernel/locking/lockdep.c:3209 [inline]
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 down_read+0x97/0x200 kernel/locking/rwsem.c:1574
 filemap_invalidate_lock_shared include/linux/fs.h:1089 [inline]
 do_page_cache_ra mm/readahead.c:347 [inline]
 page_cache_ra_order+0x2b1/0x4a0 mm/readahead.c:558
 do_sync_mmap_readahead+0x4d6/0x7c0 mm/filemap.c:3443
 filemap_fault+0x7e2/0x13c0 mm/filemap.c:3597
 __do_fault+0x138/0x2a0 mm/memory.c:5565
 do_shared_fault mm/memory.c:6064 [inline]
 do_fault mm/memory.c:6138 [inline]
 do_pte_missing+0x659/0x28f0 mm/memory.c:4700
 handle_pte_fault mm/memory.c:6558 [inline]
 __handle_mm_fault mm/memory.c:6707 [inline]
 handle_mm_fault+0xf64/0x28c0 mm/memory.c:6876
 do_user_addr_fault+0x746/0x1340 arch/x86/mm/fault.c:1394
 handle_page_fault arch/x86/mm/fault.c:1483 [inline]
 exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1536
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:595
RIP: 0010:filldir+0x29f/0x630 fs/readdir.c:288
Code: df 49 29 ef 48 b8 00 f0 ff ff ff 7f 00 00 49 39 c7 4c 0f 47 f8 bf 07 00 00 00 44 89 f6 e8 e9 35 7f ff 0f 01 cb 48 8b 44 24 20 <49> 89 47 08 48 bd 00 00 00 00 00 fc ff df 48 8b 44 24 40 48 89 03
RSP: 0018:ffffc90004cf7ab0 EFLAGS: 00050293
RAX: 00000000000009e8 RBX: 0000200000002050 RCX: ffff888026543e80
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000007
RBP: 0000000000000020 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed1004ca87d1 R12: ffff88803ae8a000
R13: 0000000000000005 R14: 0000000000000005 R15: 0000200000002030
 dir_emit include/linux/fs.h:3607 [inline]
 ntfs_dir_emit fs/ntfs3/dir.c:388 [inline]
 ntfs_read_hdr+0x8a7/0xc10 fs/ntfs3/dir.c:429
 ntfs_readdir+0x9ab/0xf70 fs/ntfs3/dir.c:589
 iterate_dir+0x2f1/0x4e0 fs/readdir.c:110
 __do_sys_getdents fs/readdir.c:319 [inline]
 __se_sys_getdents+0xf1/0x270 fs/readdir.c:304
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe25947e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe258a9c028 EFLAGS: 00000246 ORIG_RAX: 000000000000004e
RAX: ffffffffffffffda RBX: 00007fe259706180 RCX: 00007fe25947e159
RDX: 0000000020002078 RSI: 0000200000001fc0 RDI: 0000000000000007
RBP: 00007fe25951503b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe259706218 R14: 00007fe259706180 R15: 00007ffeaad84d78
 </TASK>
ntfs3(loop1): ino=1f, mi_enum_attr
----------------
Code disassembly (best guess):
   0:	df 49 29             	fisttps 0x29(%rcx)
   3:	ef                   	out    %eax,(%dx)
   4:	48 b8 00 f0 ff ff ff 	movabs $0x7ffffffff000,%rax
   b:	7f 00 00
   e:	49 39 c7             	cmp    %rax,%r15
  11:	4c 0f 47 f8          	cmova  %rax,%r15
  15:	bf 07 00 00 00       	mov    $0x7,%edi
  1a:	44 89 f6             	mov    %r14d,%esi
  1d:	e8 e9 35 7f ff       	call   0xff7f360b
  22:	0f 01 cb             	stac
  25:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
* 2a:	49 89 47 08          	mov    %rax,0x8(%r15) <-- trapping instruction
  2e:	48 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbp
  35:	fc ff df
  38:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  3d:	48 89 03             	mov    %rax,(%rbx)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
