Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7292338656C
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 22:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778969195; cv=none; b=NWB5cYtDkQT6Pst0y8ahqpzkGpqkb62d2IFng8liRqCdVUN9C4cORLed5ai5eJ/Nb84/ps07z44DtEm982jBoEhGJ+Kjnje4HWN7qS5CtZ1Kf1Mpzzy/civVDwp33r7GROzeGfAKiT1HfqQ/ZGJbAwQYbJ+CpRNjICeVPtWeHEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778969195; c=relaxed/simple;
	bh=LQ+9u5KQTw3Qe4V1V0aVpJHbgudPG/BxPdJfTMzzs/I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=diGE3I2klTkGIpxJRqahS6aqIeyhZ/MsOsfW8ssBjdjE4OMaklmefRnXdTuH0r7IsR1rbtg/NosoafV9E3ls1Opj/+BmPpsGdHrDgczlV0+hRagxKaBs/bUsfk4sBMJ40R0IfrIhdeBrdRHkDksa9PSrwP2pJvotoZ3WfREsyh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7dcda4880efso961866a34.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 15:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778969192; x=1779573992;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+HDpYUYQUWYHmnaCi05DCcS4ksCaYX23ZoYkYWXPkU0=;
        b=W40WQGB57SEy6tnXHUunACYs4Fo2Bz7B4W0G0XJuFQUPhPQxFQJxDwUwu2de63akxR
         Q00Tu8HtCbK3/wa0cOeZRBEyC7lXNpep6PWy5bDNr+3knIuxTXmZFNWXfncHnnIhVZxJ
         igCP8J7FhetN3qF/lWcQdH5nrewPsUSFc12N0sJNbZt6Xi5ZWPsFW6grSO+6q8V3GPSV
         FLf/1N+rn3qQd2nL8LoR7ketV4+xKLBBLk3yZrRbHkkC8A93a47ZgD6aB/RfjOOnwhuC
         6CgzhwCQhSPkS2kMQA4VDpXQh5sShH8u7F2ptUKpUN5L79JeSIBKUpRF4GTLdBpVgSxQ
         9m8g==
X-Forwarded-Encrypted: i=1; AFNElJ90IS92YPhWPtmwkoXie6oGuftbJx0E3tcXbLAS+s2KvJXxV2H109wsG23EnmjX7474Nc9JtjUh+v1WfwHG@vger.kernel.org
X-Gm-Message-State: AOJu0YxSR5IfVkkS3JEJTuUN8PnKR3Unhx+P2OtOJNUQYuSP8Ysihiyj
	dJ9QiRu5ffXWygyoIE+supb4ZVuWuMAS3vP+dnAXfjSEKDjxbvo4yGUrrk0I/RGpscOThQ6YuEf
	4+akYOVxgQDHAD+wiy8Lw78tz7fhy/TBmzBf9JWYq0mdxJs4+LnFn6yynWuQ=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c90:b0:694:99b7:1a2 with SMTP id
 006d021491bc7-69c9435bcf0mr5714924eaf.22.1778969192411; Sat, 16 May 2026
 15:06:32 -0700 (PDT)
Date: Sat, 16 May 2026 15:06:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a08ea68.170a0220.1ad1c0.000f.GAE@google.com>
Subject: [syzbot] [fs?] KCSAN: data-race in fill_mg_cmtime / inode_set_ctime_to_ts
From: syzbot <syzbot+8091e831a26b0f999002@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6916d5703ddf Merge tag 'drm-fixes-2026-05-16' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164de8a6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e40c0f41e01837e
dashboard link: https://syzkaller.appspot.com/bug?extid=8091e831a26b0f999002
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/68f41c193b0d/disk-6916d570.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b43a9332252c/vmlinux-6916d570.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6d9ea22a0feb/bzImage-6916d570.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8091e831a26b0f999002@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in fill_mg_cmtime / inode_set_ctime_to_ts

write to 0xffff888103f6ee90 of 8 bytes by task 9889 on cpu 1:
 inode_set_ctime_to_ts+0x8f/0x170 fs/inode.c:2771
 __simple_unlink fs/libfs.c:792 [inline]
 simple_unlink+0x38/0x80 fs/libfs.c:807
 shmem_unlink+0x12d/0x140 mm/shmem.c:3981
 vfs_unlink+0x1c7/0x490 fs/namei.c:5498
 filename_unlinkat+0x1e2/0x410 fs/namei.c:5568
 __do_sys_unlink fs/namei.c:5603 [inline]
 __se_sys_unlink+0x2b/0xe0 fs/namei.c:5600
 __x64_sys_unlink+0x1f/0x30 fs/namei.c:5600
 x64_sys_call+0x2eb6/0x3020 arch/x86/include/generated/asm/syscalls_64.h:88
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff888103f6ee90 of 8 bytes by task 3291 on cpu 0:
 fill_mg_cmtime+0x86/0x240 fs/stat.c:56
 generic_fillattr+0x24a/0x340 fs/stat.c:99
 shmem_getattr+0x181/0x200 mm/shmem.c:1302
 vfs_getattr_nosec+0x146/0x1e0 fs/stat.c:213
 vfs_getattr+0x48/0x60 fs/stat.c:262
 vfs_statx_path+0x28/0x140 fs/stat.c:299
 vfs_statx+0xc4/0x170 fs/stat.c:356
 vfs_fstatat+0x118/0x170 fs/stat.c:373
 __do_sys_newfstatat fs/stat.c:538 [inline]
 __se_sys_newfstatat+0x55/0x3e0 fs/stat.c:532
 __x64_sys_newfstatat+0x55/0x70 fs/stat.c:532
 x64_sys_call+0x2c64/0x3020 arch/x86/include/generated/asm/syscalls_64.h:263
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x12c/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x0000000077359407 -> 0x0000000077359408

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3291 Comm: udevd Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
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
