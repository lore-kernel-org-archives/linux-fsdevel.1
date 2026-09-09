Received: from mail-oa2-f8.google.com (mail-oa2-f8.google.com [74.125.231.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE10751C321
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 11:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952115; cv=none; b=vAiq+SdJPzTwwJ0w8vK6WWqVddNtuE3dIK2NkLodHdgz3Z3KxzDqh8HMVWgwtxrYU/JJWSrutLQXtuYPOnbmzxydXuYfYSmI+9hU8yhCr7a6XKYJmYqCCrCGI2ISvjNfKKPnRZw0WUjI2VYOm337lbIMpLVAXl3amYx+X4Ou0ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952115; c=relaxed/simple;
	bh=zLFT2midDUIE08jFtiZXoNTa28LZis4aapNizkR9Pl4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JYhc7zUMZF5pJ0E4lo5GFNpMFBOagptrszvgYw6vy48pRQv6HmNjppqqayimLUhKtP/ILnIwC/LIxSO6z63Ji7AFtWQONBcdI+6APF5WinW22zHbW58UUAr3mBExS+ngPD8LZKmW98QzWSbo/Jj90bT6ljRUplJcg44DOhlQ5D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f8.google.com with SMTP id 586e51a60fabf-46683b030d9so2209854fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 04:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788952112; x=1789556912;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=poOtJKRFcKQRNN+xN9bSoCheSB1ECKcVLBbKDneilbo=;
        b=adUmVdEHKLvA2Fc84QZ+jZkWv96tcx1XfnQ3VmhOZRsdGH4e0wFFPqHymSnu4aTkcC
         t2evE7EmGXpMNQLtjXItrZHlTTU1J9isceGSFRubm696gojIFVjtF8geRwnmgM9i/QN7
         q3H0htLYV7Be8RWy2jKsOx0122WeyO07s/BvqGJBXg6qTEEOrAa0HaJBwsUQSGS2qzsq
         /istLqNhvK/wGuL8ZJdiu1Hwyly3icymC6fsziOv2deha7RXFfUkl2b7w9g1EAr9rHtR
         OjLoWmGIUwsT65k7PHDkdXv4kK0xIW2KekLlP8KUh98AHmyo4zq6Wu6CUK3IIViSy+T1
         r8Tw==
X-Forwarded-Encrypted: i=1; AKwUvBx4srCSee6XCzpaxRoW0baLxpezhZIpBmigNEAKAOUyugsizRxKiRvsiIk1iDX9iT0yucyvrilasV3KKdEg@vger.kernel.org
X-Gm-Message-State: AFuF++kKGgoQB3+y5PVWNSNzDFKGTo723ZrY3znTDtLi/VQNR4x6Mvol
	4oXHOUJYy32Aev7f3UimgMRPheKqa53jWSmY7WzQzCt25p3ZXqegJTQZ6EWKyXSOXX9hUJ9F2dJ
	pYZLMIAL/lAIq5DpcsJ7Ug8bKK9V7xhCIxdkVxZtIjFJbA500u/b/RevDOFE=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f08:b0:6bd:ec40:e809 with SMTP id
 006d021491bc7-6bee4da46bdmr181333eaf.13.1788952112746; Wed, 09 Sep 2026
 04:08:32 -0700 (PDT)
Date: Wed, 09 Sep 2026 04:08:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa13e30.f614420e.2bf292.0015.GAE@google.com>
Subject: [syzbot] [exfat?] WARNING in fat_write_inode
From: syzbot <syzbot+4cb66d4011e51657d6b4@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    654ae5d73c05 Merge tag 'drm-fixes-2026-09-05' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146d68f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e909ffe6b35dddb7
dashboard link: https://syzkaller.appspot.com/bug?extid=4cb66d4011e51657d6b4
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-654ae5d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b52a78a429eb/vmlinux-654ae5d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee752e9e76b3/bzImage-654ae5d7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4cb66d4011e51657d6b4@syzkaller.appspotmail.com

------------[ cut here ]------------
!buffer_uptodate(bh)
WARNING: fs/buffer.c:991 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:991, CPU#0: syz.0.0/5320
Modules linked in:
CPU: 0 UID: 0 PID: 5320 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:991
Code: 4c 89 f7 e8 d9 01 d8 ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 74 52 fb ff e8 bf 8b 66 ff eb 8c e8 b8 8b 66 ff 90 <0f> 0b 90 e9 a5 fd ff ff e8 aa 8b 66 ff 90 0f 0b 90 e9 cf fd ff ff
RSP: 0018:ffffc9000e3cf850 EFLAGS: 00010293
RAX: ffffffff82614078 RBX: ffff888043def620 RCX: ffff8880003fcb00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: ffffc9000e3cf901 R08: ffff888043def627 R09: 1ffff110087bdec4
R10: dffffc0000000000 R11: ffffed10087bdec5 R12: 1ffff92001c79f20
R13: ffff888043def620 R14: ffff888041c13410 R15: dffffc0000000000
FS:  00005555923af540(0000) GS:ffff88808c2cd000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563f7528d660 CR3: 000000004429a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __fat_write_inode fs/fat/inode.c:946 [inline]
 fat_write_inode+0x939/0xca0 fs/fat/inode.c:963
 write_inode fs/fs-writeback.c:1608 [inline]
 __writeback_single_inode+0x69d/0x1220 fs/fs-writeback.c:1851
 writeback_single_inode+0x544/0xf70 fs/fs-writeback.c:1926
 sync_inode_metadata+0x122/0x1d0 fs/fs-writeback.c:3100
 writeback_inode fs/fat/inode.c:1916 [inline]
 fat_flush_inodes+0x9b/0x1d0 fs/fat/inode.c:1936
 fat_file_release+0xe0/0x1a0 fs/fat/file.c:180
 __fput+0x418/0xa50 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x204/0x770 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:336 [inline]
 do_syscall_64+0x328/0x520 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f597199e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff8b9d4328 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f5971c27da0 RCX: 00007f597199e159
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f5971c27da0 R08: 0000000000000006 R09: 0000000000000000
R10: 00007f5971c27cb0 R11: 0000000000000246 R12: 00000000000179c9
R13: 00007f5971c2645c R14: 0000000000017964 R15: 00007fff8b9d4430
 </TASK>


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
