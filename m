Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0230384039
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783039771; cv=none; b=IRpjxEGD5CxzgRDeA+3TDLaQcfqnsz0c/5gTTsulf3CdhDMpTHwrZWodqAiegCqTu7vByfxfgBVgKf2roMUBTJqF9SXFm0u25Tmz0bxfNat8uE8ctlH5IdZaHt1uSQ9BuosKf8qD818TCgvs4GLTCP5XfZfZEJ3M8Fnfhj+apgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783039771; c=relaxed/simple;
	bh=zfkKAi23sFHuTQtbw/16iaKd/hbewsaa/oEMWcA8IR8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=c0Dywlxc2LHHoAVbRzCf/21pGB5/vkF0Z7CY9aZjFkVhRsTJoooagIQ4U9Ilwug9rBvryXZwE0zE5BoHFsJFzE2j0zWrV/XDdKuOsEijCPmoDPOfAxjugxHQTrgTo9OMADmuGHsmc16ri5/NkowxqKhDRWH9GPvheAxLJVJA2PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-48e5de5a23cso17210b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 17:49:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783039769; x=1783644569;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=72vkMoAkyO/RjRcmBneuTlcd8PRMwwf4g5+yF9K2ubE=;
        b=D78cljdqLRIWUsyirjmkGo+um22N8in2Ug6Dhbisb7zZwTwM40UTNrUTAyN3h2foNW
         dUqnX/PzqDFBrJ9ZpcdYymnwavvXrOZdL2likKri8uQb20jkLpLj9AlLGGfr/EeZg5Vg
         C1hYKN/jUt3chSu1SsAZObtZKSXhkHww9EtadIwETHbEerTOfsDhrpmVvRiN+XSUGuA7
         CP2Ev+jqUDJiLAGXdg4Q2Q6f+yTD7hKdaUVF+OnnVdiWQ1QrmxEPOq4HID8HdbN2Cx+S
         lg7tO1fltVWlepod8qtbvixrbPx8wBOZ02sd+9lxcJRh5QWSoXZnYCUYm3ijnNXh3hiX
         su3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9ovgi1gQlq40iHEAbtWbuIkiPA+9tuZL6LDNXCD5UviH3pMpu6YOxwl9TpTggdap+zWncjq+8XWJUTSZj/@vger.kernel.org
X-Gm-Message-State: AOJu0YwJjdapAw/q9qjMMzhqxJNDM+N9skGf5d3aTnWWlLFtCcNnJDDt
	T/7IQSi7afQ6ISFRRzmlWPbLNNeVSOq8SDAbkvgiEo7ZFqtgqOCk9bZ2OVc6IKBfrUhvcBggnUX
	W3a8xC4p3VRXoQCYdTpzQM/+MKthbUQlXBZvr9vCDN8XNYWcxnqLoLH7UNIc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2209:b0:497:da7f:179c with SMTP id
 5614622812f47-497da7f2670mr2635291b6e.27.1783039769019; Thu, 02 Jul 2026
 17:49:29 -0700 (PDT)
Date: Thu, 02 Jul 2026 17:49:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a470719.6912059f.e0473.0007.GAE@google.com>
Subject: [syzbot] [exfat?] KCSAN: data-race in copy_folio_from_iter_atomic /
 fat12_ent_put (5)
From: syzbot <syzbot+e9aa2f4bc3623d1be5cf@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    665159e24674 Merge tag 'probes-fixes-v7.2-rc1' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1484b146580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=84b3039e8461eef5
dashboard link: https://syzkaller.appspot.com/bug?extid=e9aa2f4bc3623d1be5cf
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/31c1c90dee17/disk-665159e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d073e04a63f4/vmlinux-665159e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0421e67defd8/bzImage-665159e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e9aa2f4bc3623d1be5cf@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in copy_folio_from_iter_atomic / fat12_ent_put

write to 0xffff888121f76082 of 1 bytes by task 6014 on cpu 1:
 fat12_ent_put+0x74/0x180 fs/fat/fatent.c:168
 fat_alloc_clusters+0x55e/0xc40 fs/fat/fatent.c:508
 fat_add_cluster fs/fat/inode.c:108 [inline]
 __fat_get_block fs/fat/inode.c:155 [inline]
 fat_get_block+0x252/0x5e0 fs/fat/inode.c:190
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

read to 0xffff888121f76000 of 512 bytes by task 49 on cpu 0:
 memcpy_from_iter lib/iov_iter.c:85 [inline]
 iterate_bvec include/linux/iov_iter.h:123 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:306 [inline]
 iterate_and_advance include/linux/iov_iter.h:330 [inline]
 __copy_from_iter lib/iov_iter.c:261 [inline]
 copy_folio_from_iter_atomic+0x728/0x10a0 lib/iov_iter.c:491
 generic_perform_write+0x2c4/0x490 mm/filemap.c:4376
 shmem_file_write_iter+0xc5/0xf0 mm/shmem.c:3414
 lo_rw_aio+0x6a9/0x760 drivers/block/loop.c:-1
 do_req_filebacked drivers/block/loop.c:-1 [inline]
 loop_handle_cmd drivers/block/loop.c:1921 [inline]
 loop_process_work+0x567/0xac0 drivers/block/loop.c:1956
 loop_workfn+0x31/0x40 drivers/block/loop.c:1980
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0x4d4/0x9a0 kernel/workqueue.c:3405
 worker_thread+0x569/0x750 kernel/workqueue.c:3486
 kthread+0x221/0x270 kernel/kthread.c:436
 ret_from_fork+0x146/0x330 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 49 Comm: kworker/u8:3 Tainted: G        W           syzkaller #0 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
Workqueue: loop6 loop_workfn
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
