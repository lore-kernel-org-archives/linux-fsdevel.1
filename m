Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420062FD1A5
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780193138; cv=none; b=o5qR3v/WKcvhy5XSUH9dBy5wy35JnX2BhMo1UQbI59+iwz2LOAA4N1gEUBLBX4K6hi8Ny5Yh5y7DG5Vmx5idKkcUzbh1adxF1Qwi5K3FnsQ0pmkwkR68wY1XOLdclqUmF9z6NrB/qBojq/y19l0hx5ORjg2x7S0GzZNNlksa5K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780193138; c=relaxed/simple;
	bh=I4g7FzUxvM1SI0tZjI3ToMdvph6DcYYHtzy/eHHJ3VI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rxrpU/+Ias24DDUczw6vBblJUxhhX/7ygauc/FyakwHUGRj1QdSW2HFl16OTwlkVH01MEsJ7e8sWyLoPstT8msIBwYCOTdl03utlHCQTTnZrN9HMclira8bn1YVwNFPjgCVYD6RD678HIxsy/YOvRPPG7vojoai692mZoaRQG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-69d7fee2b39so5864271eaf.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 19:05:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780193136; x=1780797936;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ne4GzdzdnKm+4BhwlEFgMY6GWR7zMb3d/gEca9fJHag=;
        b=cZFXQE6loBsrviglePaa9muC62AMdjBN/LsmfVoXWaSiS0Xkht/hFhM1ZCk02BqDov
         NyMIQ3BCxJ9jXGDwzutV8/kp00JIdIlCTBWoYxSLgvYJqTdKiMrl22JqCf8s37BU2KPK
         mDEuD7NMDhVTONvkS8I/rJ0OY9Dz0LUBSQYF7/PWXtMTHEKjVHfXlSCqs630BMMuavLs
         n1adrgJSH9TFCck9n5ON3NxozjJF3WhVvjI6E+T0mDLyVDLk2Ls65jT4jHIpiSNENsUP
         i1a4F2UwhWPmL5/bTahzhRBW6RJUujSQpq9QRFChZ+d5nr7XEh9zQrWPkBCTvvz9Fnpn
         ogYg==
X-Forwarded-Encrypted: i=1; AFNElJ8AZUwMjsIB733HLkWywkrY/RLP0xrBoua+kL21rkpyRgj82vBlWhrH5fwDNzSmLQLEwiR/9fGjL0rNQA45@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/yzu7UUbx8fOrhxv1AevisFLFvlXNxlA3AFCG70mCtDrV9/Wu
	dDGIhXzOtkgLyeq8fgbbqWwPJM5LcsMCqPAmZ89l5Dj7FykMI8p/Qe2MAssbkuLl8YRS+igvnPT
	CaaMf02IqKJqC10wiWfkVodfU+WAIz+iQ/nVN844Ggw8gg0SlRBhWIqmkYAI=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4d0b:b0:69d:9e7c:cb67 with SMTP id
 006d021491bc7-69e103fb737mr2454780eaf.53.1780193136287; Sat, 30 May 2026
 19:05:36 -0700 (PDT)
Date: Sat, 30 May 2026 19:05:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a1b9770.fd5edf16.2e7427.0008.GAE@google.com>
Subject: [syzbot] [mm?] [fs?] possible deadlock in page_cache_ra_order
From: syzbot <syzbot+8bd419f88e25ab12cb75@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e7e28506af98 Add linux-next specific files for 20260526
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1377f67e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1701da6552dd9b8
dashboard link: https://syzkaller.appspot.com/bug?extid=8bd419f88e25ab12cb75
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0060088615f7/disk-e7e28506.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bee8a0723af7/vmlinux-e7e28506.xz
kernel image: https://storage.googleapis.com/syzbot-assets/040209574106/bzImage-e7e28506.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8bd419f88e25ab12cb75@syzkaller.appspotmail.com

loop4: detected capacity change from 0 to 4096
ntfs3(loop4): failed to convert "0080" to koi8-ru
======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.4.188/6496 is trying to acquire lock:
ffff888062d66830 (mapping.invalidate_lock#3){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:1089 [inline]
ffff888062d66830 (mapping.invalidate_lock#3){++++}-{4:4}, at: do_page_cache_ra mm/readahead.c:349 [inline]
ffff888062d66830 (mapping.invalidate_lock#3){++++}-{4:4}, at: page_cache_ra_order+0x2b4/0x4a0 mm/readahead.c:562

but task is already holding lock:
ffff88803fd78888 (&ni->ni_lock/5){+.+.}-{4:4}, at: ni_lock fs/ntfs3/ntfs_fs.h:1214 [inline]
ffff88803fd78888 (&ni->ni_lock/5){+.+.}-{4:4}, at: ntfs_readdir+0x6c9/0xf40 fs/ntfs3/dir.c:497

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ni->ni_lock/5){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/rtmutex_api.c:559 [inline]
       mutex_lock_nested+0x5a/0x1d0 kernel/locking/rtmutex_api.c:578
       ni_lock fs/ntfs3/ntfs_fs.h:1214 [inline]
       ntfs_fallocate+0x59f/0x1230 fs/ntfs3/file.c:543
       vfs_fallocate+0x672/0x7f0 fs/open.c:338
       ioctl_preallocate fs/ioctl.c:289 [inline]
       file_ioctl+0x64b/0x870 fs/ioctl.c:332
       do_vfs_ioctl+0xc29/0x1540 fs/ioctl.c:576
       __do_sys_ioctl fs/ioctl.c:595 [inline]
       __se_sys_ioctl+0x82/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (mapping.invalidate_lock#3){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3167 [inline]
       check_prevs_add kernel/locking/lockdep.c:3286 [inline]
       validate_chain kernel/locking/lockdep.c:3910 [inline]
       __lock_acquire+0x15a5/0x2d10 kernel/locking/lockdep.c:5239
       lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
       down_read+0x97/0x200 kernel/locking/rwsem.c:1568
       filemap_invalidate_lock_shared include/linux/fs.h:1089 [inline]
       do_page_cache_ra mm/readahead.c:349 [inline]
       page_cache_ra_order+0x2b4/0x4a0 mm/readahead.c:562
       do_sync_mmap_readahead+0x698/0x7b0 mm/filemap.c:3409
       filemap_fault+0x790/0x13a0 mm/filemap.c:3559
       __do_fault+0x138/0x2a0 mm/memory.c:5421
       do_shared_fault mm/memory.c:5920 [inline]
       do_fault mm/memory.c:5994 [inline]
       do_pte_missing+0x65b/0x2940 mm/memory.c:4566
       handle_pte_fault mm/memory.c:6375 [inline]
       __handle_mm_fault mm/memory.c:6513 [inline]
       handle_mm_fault+0xdc2/0x14d0 mm/memory.c:6682
       do_user_addr_fault+0x75b/0x1340 arch/x86/mm/fault.c:1390
       handle_page_fault arch/x86/mm/fault.c:1479 [inline]
       exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1532
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:595
       filldir64+0x2b2/0x640 fs/readdir.c:368
       dir_emit include/linux/fs.h:3587 [inline]
       ntfs_dir_emit fs/ntfs3/dir.c:344 [inline]
       ntfs_read_hdr+0x8fb/0xc80 fs/ntfs3/dir.c:385
       ntfs_readdir+0x98e/0xf40 fs/ntfs3/dir.c:545
       iterate_dir+0x3a5/0x580 fs/readdir.c:110
       __do_sys_getdents64 fs/readdir.c:399 [inline]
       __se_sys_getdents64+0xf1/0x280 fs/readdir.c:384
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
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

3 locks held by syz.4.188/6496:
 #0: ffff888037dde928 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x252/0x320 fs/file.c:1260
 #1: ffff88803fd78b40 (&type->i_mutex_dir_key#10){++++}-{4:4}, at: iterate_dir+0x29e/0x580 fs/readdir.c:103
 #2: ffff88803fd78888 (&ni->ni_lock/5){+.+.}-{4:4}, at: ni_lock fs/ntfs3/ntfs_fs.h:1214 [inline]
 #2: ffff88803fd78888 (&ni->ni_lock/5){+.+.}-{4:4}, at: ntfs_readdir+0x6c9/0xf40 fs/ntfs3/dir.c:497

stack backtrace:
CPU: 0 UID: 0 PID: 6496 Comm: syz.4.188 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e1/0x300 kernel/locking/lockdep.c:2045
 check_noncircular+0x12e/0x150 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3167 [inline]
 check_prevs_add kernel/locking/lockdep.c:3286 [inline]
 validate_chain kernel/locking/lockdep.c:3910 [inline]
 __lock_acquire+0x15a5/0x2d10 kernel/locking/lockdep.c:5239
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
 down_read+0x97/0x200 kernel/locking/rwsem.c:1568
 filemap_invalidate_lock_shared include/linux/fs.h:1089 [inline]
 do_page_cache_ra mm/readahead.c:349 [inline]
 page_cache_ra_order+0x2b4/0x4a0 mm/readahead.c:562
 do_sync_mmap_readahead+0x698/0x7b0 mm/filemap.c:3409
 filemap_fault+0x790/0x13a0 mm/filemap.c:3559
 __do_fault+0x138/0x2a0 mm/memory.c:5421
 do_shared_fault mm/memory.c:5920 [inline]
 do_fault mm/memory.c:5994 [inline]
 do_pte_missing+0x65b/0x2940 mm/memory.c:4566
 handle_pte_fault mm/memory.c:6375 [inline]
 __handle_mm_fault mm/memory.c:6513 [inline]
 handle_mm_fault+0xdc2/0x14d0 mm/memory.c:6682
 do_user_addr_fault+0x75b/0x1340 arch/x86/mm/fault.c:1390
 handle_page_fault arch/x86/mm/fault.c:1479 [inline]
 exc_page_fault+0x6a/0xc0 arch/x86/mm/fault.c:1532
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:595
RIP: 0010:filldir64+0x2b2/0x640 fs/readdir.c:369
Code: 00 48 39 c8 48 0f 47 c1 0f 01 cb 48 8b 4c 24 28 48 89 48 08 48 bd 00 00 00 00 00 fc ff df 48 8b 44 24 60 48 89 02 8b 44 24 04 <66> 89 42 10 41 80 e7 0f 44 88 7a 12 42 c6 44 2a 13 00 48 89 54 24
RSP: 0018:ffffc9000e517aa8 EFLAGS: 00050287
RAX: 0000000000000020 RBX: ffffc9000e517e38 RCX: 00000000000008c0
RDX: 0000200000000ff0 RSI: 0000000000000a29 RDI: 0000000000000a2a
RBP: dffffc0000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed10054a03e1 R12: ffff88802699c000
R13: 0000000000000009 R14: 0000000000000009 R15: 0000000000000008
 dir_emit include/linux/fs.h:3587 [inline]
 ntfs_dir_emit fs/ntfs3/dir.c:344 [inline]
 ntfs_read_hdr+0x8fb/0xc80 fs/ntfs3/dir.c:385
 ntfs_readdir+0x98e/0xf40 fs/ntfs3/dir.c:545
 iterate_dir+0x3a5/0x580 fs/readdir.c:110
 __do_sys_getdents64 fs/readdir.c:399 [inline]
 __se_sys_getdents64+0xf1/0x280 fs/readdir.c:384
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7feadcacce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007feadad1e028 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 00007feadcd45fa0 RCX: 00007feadcacce59
RDX: 00000000000000e0 RSI: 0000200000000fc0 RDI: 0000000000000006
RBP: 00007feadcb62d6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007feadcd46038 R14: 00007feadcd45fa0 R15: 00007ffebb7a32a8
 </TASK>
ntfs3(loop4): failed to convert name for inode 1e.
ntfs3(loop4): ino=1f, mi_enum_attr
----------------
Code disassembly (best guess):
   0:	00 48 39             	add    %cl,0x39(%rax)
   3:	c8 48 0f 47          	enter  $0xf48,$0x47
   7:	c1 0f 01             	rorl   $0x1,(%rdi)
   a:	cb                   	lret
   b:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
  10:	48 89 48 08          	mov    %rcx,0x8(%rax)
  14:	48 bd 00 00 00 00 00 	movabs $0xdffffc0000000000,%rbp
  1b:	fc ff df
  1e:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
  23:	48 89 02             	mov    %rax,(%rdx)
  26:	8b 44 24 04          	mov    0x4(%rsp),%eax
* 2a:	66 89 42 10          	mov    %ax,0x10(%rdx) <-- trapping instruction
  2e:	41 80 e7 0f          	and    $0xf,%r15b
  32:	44 88 7a 12          	mov    %r15b,0x12(%rdx)
  36:	42 c6 44 2a 13 00    	movb   $0x0,0x13(%rdx,%r13,1)
  3c:	48                   	rex.W
  3d:	89                   	.byte 0x89
  3e:	54                   	push   %rsp
  3f:	24                   	.byte 0x24


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
