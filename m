Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEBC3115A2
	for <linux-fsdevel@vger.kernel.org>; Sun, 16 Aug 2026 06:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786862785; cv=none; b=GE7UJbsGCjtuA3wQBnWrtjl6Wzn7GHUnE8HgmGrtz5mtnAEDgJbkwlmFZjGCtegk7C/zPQUwxu4QMo2oYDHEPbWxZbY5Rtq++sixzQjCEpUUfa6oL39g7IwcNUXMHBTDlBtYqG3t7YlM/nYgs6QoJRsUHG9Oj8H2VO5T57dymu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786862785; c=relaxed/simple;
	bh=cBDHEsWTeBXksJ9c9vlKC2mJbZdiQ2DN9v4xr3gB+Iw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=u2dyaRZAXEDGtiqBSfRrPkurEr5lQ0ofUjndRqC+jA525PW5j4MnS9OAL3gR3UhT2c6ojv8WjYQpGuDYO753rufbbkYBB85pxfuox+sQaYYRh4d93RKksNQxBK3qlKQBQVv5SUUv4hod18YUKED9D8zdDqU8SBrE2t6MbbwaudU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-49aa4525b82so2749171b6e.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2026 23:46:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786862783; x=1787467583;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xV4687rTqE9lsdbqyMEI9ZU2c9fh9f4443PgN01nqtg=;
        b=HjUl0O1CbRZLBROn9GWg3bwreM4pDqKQw1325/vc3/j3p9pzI/xw5dQe8td/DvRqRA
         /DrYxv4BujVQSwNoy3UFUV08FYr/QvVtPk+dtl3z+ZYEGForJQyYJSjFeGMW93zm/yDz
         ZJmsSeCnQRP5gXjzgkgoVmvMJsbQRiCu7bRAGNEUaZ0umj3vueFlk2ACxw7zRlxSZDp5
         Lrqh/Ksoq5yCWza+xeWPpsMXehoaEAHQ/VdhPmrV+ImpNpA+mmEed4JJwqOTUgs+8oEU
         yTUjTTUV1c+hzw9IPvZEpUWmzjEQuIAj8Wrvj0f5PNX5QEn+dgFecvmsiSUvUM7FMJyU
         U2ZA==
X-Forwarded-Encrypted: i=1; AHgh+RqHH3vUe/mjGaejsyUo0CihEeTqzyBB2QNOotf7wbfCaBvCOMxMDcgmS1ChKaKl+niyTp1tXLNzp7Ti9Orf@vger.kernel.org
X-Gm-Message-State: AOJu0YzSeRUnITZBQAEFPsn58wOul8ILTrngrvkwe6bgvy0s1knuKbxF
	TYgrWE+YQMYaXvI6U4NoDSK0tSHGBbLkfw9fqAdH6mc2Hj3pAY3gR9GA5yHXV0FoKx2lF/S8Ksu
	tpRpSWWVKmldCphZ0XKYb8rDxULDSao/6PpgTn14v7y7vi8qg8ahOB277mqg=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:f0d:b0:497:da7f:179a with SMTP id
 5614622812f47-4b241f43193mr15366086b6e.21.1786862783012; Sat, 15 Aug 2026
 23:46:23 -0700 (PDT)
Date: Sat, 15 Aug 2026 23:46:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a815cbe.f7a79266.2f965f.000e.GAE@google.com>
Subject: [syzbot] [exfat?] KCSAN: data-race in copy_folio_from_iter_atomic / fat_add_entries
From: syzbot <syzbot+f72da8b30ddc89cc2371@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3eb40771c00a Merge tag 'soc-fixes-7.2-3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=108a9a79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e71a508528491732
dashboard link: https://syzkaller.appspot.com/bug?extid=f72da8b30ddc89cc2371
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b72e40f7d2c6/disk-3eb40771.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/19423dd4d544/vmlinux-3eb40771.xz
kernel image: https://storage.googleapis.com/syzbot-assets/08b66d3a6723/bzImage-3eb40771.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f72da8b30ddc89cc2371@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in copy_folio_from_iter_atomic / fat_add_entries

write to 0xffff8881090508c0 of 32 bytes by task 4733 on cpu 1:
 fat_add_entries+0x7d8/0x11c0 fs/fat/dir.c:1409
 msdos_add_entry+0x1a2/0x270 fs/fat/namei_msdos.c:250
 msdos_create+0x205/0x350 fs/fat/namei_msdos.c:289
 lookup_open fs/namei.c:4508 [inline]
 open_last_lookups fs/namei.c:4608 [inline]
 path_openat+0xcfb/0x2000 fs/namei.c:4860
 do_file_open+0x16c/0x290 fs/namei.c:4892
 do_sys_openat2+0xa0/0x130 fs/open.c:1368
 do_sys_open fs/open.c:1374 [inline]
 __do_sys_openat fs/open.c:1390 [inline]
 __se_sys_openat fs/open.c:1385 [inline]
 __x64_sys_openat+0xf2/0x120 fs/open.c:1385
 x64_sys_call+0x1e39/0x3020 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x136/0x3c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888109050800 of 2048 bytes by task 40 on cpu 0:
 memcpy_from_iter lib/iov_iter.c:85 [inline]
 iterate_bvec include/linux/iov_iter.h:123 [inline]
 iterate_and_advance2 include/linux/iov_iter.h:306 [inline]
 iterate_and_advance include/linux/iov_iter.h:330 [inline]
 __copy_from_iter lib/iov_iter.c:261 [inline]
 copy_folio_from_iter_atomic+0x728/0x10a0 lib/iov_iter.c:491
 generic_perform_write+0x2c4/0x490 mm/filemap.c:4382
 shmem_file_write_iter+0xc5/0xf0 mm/shmem.c:3424
 lo_rw_aio+0x6a9/0x760 drivers/block/loop.c:-1
 do_req_filebacked drivers/block/loop.c:-1 [inline]
 loop_handle_cmd drivers/block/loop.c:1917 [inline]
 loop_process_work+0x567/0xac0 drivers/block/loop.c:1952
 loop_workfn+0x31/0x40 drivers/block/loop.c:1976
 process_one_work kernel/workqueue.c:3322 [inline]
 process_scheduled_works+0x4d4/0x9a0 kernel/workqueue.c:3405
 worker_thread+0x569/0x750 kernel/workqueue.c:3486
 kthread+0x221/0x270 kernel/kthread.c:436
 ret_from_fork+0x146/0x330 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 40 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: loop4 loop_workfn
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
