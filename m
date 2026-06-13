Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C7623ABBF
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2026 01:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781314107; cv=none; b=ZyNdsv6Tu26vV7eq9B/T/di6pQHOxw4lw9VfsjObDHYmm7Kz8gAgdbxWvjsmpZgJudKHGIlzPlDlXcmc9903eRUxbDlszaOmtd/x5AElYjcHEVv5mfP0aYQVmiG6x2HY/uaQbD23/FlNyfFM3cgjvm/Xi4GzbrLJEallzRWHT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781314107; c=relaxed/simple;
	bh=TelGtIEGuz21jz9kJbNRXQPkjmj9xInbKVaoA1lkBS8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=dHxoaHtZQJLk5rgYlK4z3ZS8lAGidb4AK/Z6vdkEqlkMwlvMNh0TRa1A6jjWmXBIDpi3A1LDBVflZPIJEnMtyydPDeinG7vOhsfSCWFJBOTiWkPPGuTbI76FyrhftHph3WUUPr2X//rA5OP84Z9KFkD8+RPHFaPAeNSb63K1adM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-48576b535b6so1393277b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 18:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781314105; x=1781918905;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qrmxWSxT+zmCLxGBD33Eu7CuuJc830oeZq1LbtG4BoA=;
        b=FKuf9VhpX/48OJH1T3zeM97EkKTjOtOjWaAXyb34wNf0HBkif/srGZo3Sgc1U26A+l
         lNRQSPuj9/Kk+g4wi64ZTT9fuTQbaG8ZwA1PYU3q9ZAqd45iLzKFf9GIhRUMlAK+SLfK
         I4dpAsWws5y/g3lF1vtdp/5EaGHATzMsfVGbIbkxPChDHqHXm0X0VwFSpyFVRB34cDA6
         EnNlwPahUkTSKGlm4dyJCt3YdQKLZvR/6GK04w+bQsKsJDOaO1pN2/9K9cVr9DoG6GgU
         ZDWy4wR696GrxlZtsk/0WMLkphmvfQ1htIxkvmu7niUJxXVnYFuOYS4sYX4JkSrK9iQA
         9U0g==
X-Forwarded-Encrypted: i=1; AFNElJ/XcG3bgxF+EDDKD4VuV/Bvli5b5lyRRXSch8ems/IBGf3wAi7kKJ3T+JFVvUaEz7fXh7C4nlOJNTLND01p@vger.kernel.org
X-Gm-Message-State: AOJu0YzCjiRrOlBVdvpAtsErNliOHxb8TlOhjpQIGDZBi3NcC0A7OSrw
	mredGU/TxwNv8JrT7/vT2deCgopWK19l35EcalWxArmop7DSkDkOPSoytQlE9/ooRVPBj1/82Sb
	aqipa8f3uV6LazydLJT1fNPr3aGy3oxTmzPsVzcLuKBtMJVp/pNzDxNblTFI=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:170f:b0:485:15bd:60e8 with SMTP id
 5614622812f47-48741b51368mr1363079b6e.35.1781314104923; Fri, 12 Jun 2026
 18:28:24 -0700 (PDT)
Date: Fri, 12 Jun 2026 18:28:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a2cb238.be3f099c.2836ae.0006.GAE@google.com>
Subject: [syzbot] [fs?] memory leak in path_openat (3)
From: syzbot <syzbot+2cd473471e77bda12b0e@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2b414a95b8f7 Merge tag 's390-7.1-5' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=157e78ae580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4044c5352cad3e68
dashboard link: https://syzkaller.appspot.com/bug?extid=2cd473471e77bda12b0e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=131d98ae580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14838986580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/86194cb79270/disk-2b414a95.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/11136f1a297f/vmlinux-2b414a95.xz
kernel image: https://storage.googleapis.com/syzbot-assets/809371abba53/bzImage-2b414a95.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2cd473471e77bda12b0e@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810ac98000 (size 176):
  comm "syz.0.19", pid 5920, jiffies 4294944647
  hex dump (first 32 bytes):
    00 00 00 00 1b 00 0e 04 60 7e a7 85 ff ff ff ff  ........`~......
    70 15 3e 06 81 88 ff ff 80 61 3c 2b 81 88 ff ff  p.>......a<+....
  backtrace (crc df7849cb):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4575 [inline]
    slab_alloc_node mm/slub.c:4899 [inline]
    kmem_cache_alloc_noprof+0x36c/0x480 mm/slub.c:4906
    alloc_empty_file+0x57/0x180 fs/file_table.c:262
    path_openat+0x44/0x1e20 fs/namei.c:4844
    do_file_open+0x121/0x200 fs/namei.c:4887
    do_sys_openat2+0xa5/0x140 fs/open.c:1364
    do_sys_open fs/open.c:1370 [inline]
    __do_sys_openat fs/open.c:1386 [inline]
    __se_sys_openat fs/open.c:1381 [inline]
    __x64_sys_openat+0x82/0xf0 fs/open.c:1381
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xf8/0x610 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


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
