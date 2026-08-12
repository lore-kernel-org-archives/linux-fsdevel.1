Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2293B1F4631
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786578992; cv=none; b=omi287ir2VdupHHXMyOIEMkHOd71jbTFXS4WOtL4N5diDLR1HynXgRFQ7tjhzo6y6HHzxiM0XKZ9NbXHfmMI0eEdF2F6eu1rjcS3qkF0G0QVX2x8cpHNpGAJojWDJOn/PlGMo23BvtMjVM3Knnr9EfEiUghfxuvq3YTGtoHAbAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786578992; c=relaxed/simple;
	bh=pmVqbuYfiqTFkBbZGqyuzlVEPLnzEJOct3P0msUPe/o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JjL1BC4/h9GkD5ISoTpMNkm8TG8UZ9mxqgAf8Zkw7usEBJYf9FQIuSdrjXspWiyYnlwX3GibQ9MPcyciaRZSt7Ou6DuheWorDjPrtIaNkGa3KUpci+FiePI2qfdOVzr/n2KXbLPE4ajNTjvM+4oYi9vgIeEIQH+ki8n7zrEkj4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-6a344ad5c7bso75314eaf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 16:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786578990; x=1787183790;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+v5oTfyGF2lTff6vcwWwqW2v/d8rOItbnNCVE9cW5JY=;
        b=bewqlPK3U1i0lQsByx1xJNPixypM6nWQ9XpobUZw9rl2JfZJH+AQ1Bi6c+aqbrrNE1
         7wTpc/RVyv6jDe6SNTesIP5R9tW2dTW9rSL/4B9Es8lTsnrJm8fT5TxCCiHku+zR2kut
         nOTfvX5JQfly0qTv8Cq9CM0iH7bsQfZqXzfZqSdjZxAXXuXuqONv9lDSo/TKlAcwp2YT
         QpIQ3Y+8WF6Grcv90Xve8rQHBBIhIO5jxilRYtqnEKLuzQi0ZQFoN3m60pPkDpgsyWZ4
         /PHCVAosYX/pN9nDOVRC53MnEbFELlmE3A0z1hplWYPftsi+gT41f+shAx/0NtAqFISx
         bMew==
X-Forwarded-Encrypted: i=1; AHgh+RrYazOPID/anJdcXvxJwI1Yp9ZG0F1QGDn266R9p4olqftkiXhr7w2bOP4FfvYd6VIzU2fWsjebbR8ebPfJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzmUPwMD9+kebMZiwcWFc6p6+2sjj4RooIZ2kgZGjn2qL50nsU0
	vmEL/YUUKY7oC/PjCt3TJFwtpUoYEMF4T+3wBxRTNPvRn0T3aDt8l6PEM+7+HeCGK+vKS8fVk/z
	RAicTJOlxPsISYJAySyDxtmomn4KR1osEfocCh61nqfMbZJwSJQSnnyXWmQ4=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c86:b0:6b0:4355:3c8d with SMTP id
 006d021491bc7-6b0c465f18dmr2109852eaf.34.1786578990086; Wed, 12 Aug 2026
 16:56:30 -0700 (PDT)
Date: Wed, 12 Aug 2026 16:56:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7d082e.d5f0ebe7.22d851.0012.GAE@google.com>
Subject: [syzbot] [exfat?] KCSAN: data-race in fat32_ent_put / fat_mirror_bhs (4)
From: syzbot <syzbot+9435f33de7962a2cb62d@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d6d817622b0 Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15263225580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=33c5ac947f6be69e
dashboard link: https://syzkaller.appspot.com/bug?extid=9435f33de7962a2cb62d
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8a0f9e563bc1/disk-3d6d8176.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a3d8fcb60747/vmlinux-3d6d8176.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f5e1d8d94487/bzImage-3d6d8176.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9435f33de7962a2cb62d@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in fat32_ent_put / fat_mirror_bhs

read-write to 0xffff88811db1234c of 4 bytes by task 4861 on cpu 1:
 fat32_ent_put+0x4e/0x90 fs/fat/fatent.c:194
 fat_ent_write+0x6c/0xe0 fs/fat/fatent.c:422
 fat_chain_add+0x174/0x4a0 fs/fat/misc.c:136
 fat_add_cluster fs/fat/inode.c:113 [inline]
 __fat_get_block fs/fat/inode.c:155 [inline]
 fat_get_block+0x468/0x5e0 fs/fat/inode.c:190
 __block_write_begin_int+0x400/0xf90 fs/buffer.c:2123
 block_write_begin fs/buffer.c:2234 [inline]
 cont_write_begin+0x5bf/0x920 fs/buffer.c:2596
 fat_write_begin+0x52/0xe0 fs/fat/inode.c:230
 cont_expand_zero fs/buffer.c:2524 [inline]
 cont_write_begin+0x18d/0x920 fs/buffer.c:2586
 fat_write_begin+0x52/0xe0 fs/fat/inode.c:230
 generic_cont_expand_simple+0xb0/0x150 fs/buffer.c:2487
 fat_cont_expand+0x3e/0x170 fs/fat/file.c:227
 fat_fallocate+0x177/0x1c0 fs/fat/file.c:305
 vfs_fallocate+0x3ac/0x400 fs/open.c:338
 ksys_fallocate fs/open.c:362 [inline]
 __do_sys_fallocate fs/open.c:367 [inline]
 __se_sys_fallocate fs/open.c:365 [inline]
 __x64_sys_fallocate+0x7a/0xd0 fs/open.c:365
 x64_sys_call+0x298e/0x3020 arch/x86/include/generated/asm/syscalls_64.h:286
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x136/0x3c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811db12000 of 2048 bytes by task 4866 on cpu 0:
 fat_mirror_bhs+0x1df/0x330 fs/fat/fatent.c:399
 fat_ent_write+0xd0/0xe0 fs/fat/fatent.c:428
 fat_chain_add+0x174/0x4a0 fs/fat/misc.c:136
 fat_add_cluster fs/fat/inode.c:113 [inline]
 __fat_get_block fs/fat/inode.c:155 [inline]
 fat_get_block+0x468/0x5e0 fs/fat/inode.c:190
 __block_write_begin_int+0x400/0xf90 fs/buffer.c:2123
 block_write_begin fs/buffer.c:2234 [inline]
 cont_write_begin+0x5bf/0x920 fs/buffer.c:2596
 fat_write_begin+0x52/0xe0 fs/fat/inode.c:230
 generic_perform_write+0x186/0x490 mm/filemap.c:4364
 __generic_file_write_iter+0x9e/0x120 mm/filemap.c:4481
 generic_file_write_iter+0x77/0x1f0 mm/filemap.c:4507
 __kernel_write_iter+0x30f/0x590 fs/read_write.c:621
 dump_emit_page fs/coredump.c:1298 [inline]
 dump_user_range+0xa73/0xd00 fs/coredump.c:1372
 elf_core_dump+0x21c0/0x2340 fs/binfmt_elf.c:2109
 coredump_write+0xaf9/0xdd0 fs/coredump.c:1052
 do_coredump fs/coredump.c:1131 [inline]
 vfs_coredump+0x2770/0x3290 fs/coredump.c:1200
 get_signal+0xd33/0xf10 kernel/signal.c:3031
 arch_do_signal_or_restart+0x96/0x480 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:101 [inline]
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 irqentry_exit_to_user_mode_prepare include/linux/irq-entry-common.h:244 [inline]
 irqentry_exit_to_user_mode include/linux/irq-entry-common.h:315 [inline]
 irqentry_exit+0x14d/0x610 kernel/entry/common.c:165
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:595

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 4866 Comm: syz.3.376 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
==================================================================
syz.3.376 (4866) used greatest stack depth: 9320 bytes left


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
