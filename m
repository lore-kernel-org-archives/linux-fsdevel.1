Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795486419;
	b=FQPCCtZ7epLaHmKSHYz8paDlJPBqWAf5bQg3crg1lFyQM+U18XgdjakzaWesVhHAWTpu
	 vU4QQYTWeXK6saGCCZLEc8Qrn/pHOuVUZXc6as2oHzkTgQvvmVylyFhpu4WModNxn29V0
	 hNvtJVrAyFb08/4kQhkfEDg+9mGbHPHO1PA8ytQKuOs5xwpeiSqctaUGrs0fv9b3xoBHp
	 1H6P8PcLGnRh4rIW5nOtGjtqJZC+CCTELjJkJ9uRnVEFKxgR785+HJ4CKWG1NjoZ+QDqm
	 mHBBBQtri1siMvoLORwzrPFb8/I1+s9P17T+qKnhLoPzgjZtspo+xldfBg6lK4eWxiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795486419;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=jl9dB7jJGIlY2PKhHfBeUr5m/KPu4eSitwR+RChvQeM=;
	b=kAVJbGnzHUO3unCm41ACblr9NZI02pn1t4BayJ78o2StVjEsOrFAEK7kY19K8cGAOe4M
	 mAqWAwVgysE3zL2Fdk8RkaT9ggvz3lZx0dU+qgikHU7lFxUru25xzhpZCZ4gCVu+UeyfP
	 gc3RrI0AkOFWovMpwf8+yphIdevpKJKTyDjUlvXZirN141nXVVZHhTF8cw2k5oboiGi9+
	 wqy5z7TzNtcQh1PEaQQd8KgqBYSXp8VrwLaKw71J5i7ykkW2XnPmVYHMBJHugF2jOw6gf
	 pbIO2bhT34wv1NcKDCBpbr9I3ivYHfQbkbdCH9KwsmZsOGfenQ0tPxrMDNq7bKBDGdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.72
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6BB606A321
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2026 02:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C6BB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-862a5ad18d0so4696855a34.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2026 18:13:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795486418; x=1796091218;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jl9dB7jJGIlY2PKhHfBeUr5m/KPu4eSitwR+RChvQeM=;
        b=Q9AZQtEuJwas7zARRtwMmRM1bnJzt3G6n5wBw5m3tyFVcgAfD0eiCTY9yxo3+WbPzI
         rWh+g4i5GqSlewA5w+eVAo9fE92I9DKe5VToG/jULkI5mZf9aFFFm4eo6NpQ8jmAnFCK
         tDln6WRtEA5+v9og0VywBO6s3MEd35ihp8zykn6Ew0lcRsP0hu/1flzn3AH4qQTsS9T+
         Vj4PYpoIBgDyhZu7Vu9Oakaoyv7qC0v86mkIQoT0oZJPOTJ7lHwa2LIpERlUPokaaDn+
         rDcEbydY2hTHHA6PY+SpSuujmvFOKfr4/Jxhuq+7m0RRpPGew4/jjtcPMHiObJp5ht7L
         3Yew==
X-Forwarded-Encrypted: i=1; AL+hErFGaRLIvdgeIcD544Ih+wEXd8+5i4xbnanqp/4+ZzhylutcHpY9KOS/8ucgMCZbFEbqm0eRU8a/x/BYKPXh@vger.kernel.org
X-Gm-Message-State: APuU4Z+M2oLaVal8rrfQzDq28p8xzp4Oackgb4c72XuQaD77r5jQw2tw
	cFVP5l7D/5IeOQvccKO8QpJXvZF7cpZL3Y/l2lBXjFSu4yfPY/PpCUfajFrXUU/CElFnjz9p4Ed
	z5OS7m/9hE956VYoJGhasR002Vs5/HCejM8KDFPvK/FrgWnWIfzJsmsCKocs=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1484:b0:53a:65aa:152e with SMTP id
 5614622812f47-57a0a50658amr16332018b6e.35.1795486418522; Mon, 23 Nov 2026
 18:13:38 -0800 (PST)
Date: Mon, 23 Nov 2026 18:13:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b04f2d2.44b41460.34b83f.0037.GAE@google.com>
Subject: [syzbot] [fs?] KCSAN: data-race in task_dump_owner / task_dump_owner (2)
From: syzbot <syzbot+3b8f4ae71137f7af00ca@syzkaller.appspotmail.com>
To: adobriyan@gmail.com, akpm@linux-foundation.org, brauner@kernel.org, 
	jack@suse.cz, jannh@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sforshee@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4843f6873f7c Merge tag 'sysctl-7.04-fixes-rc4' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149a7363580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=886d2ddd2d6b664e
dashboard link: https://syzkaller.appspot.com/bug?extid=3b8f4ae71137f7af00ca
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9b25bc73ef7f/disk-4843f687.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/acc9d8469c04/vmlinux-4843f687.xz
kernel image: https://storage.googleapis.com/syzbot-assets/83adc8d7ee5c/bzImage-4843f687.xz

AI-generated root cause summary:
During concurrent VFS lookups of the same `/proc/<pid>` dentry, `lookup_fast()`
invokes `pid_revalidate()` without holding any inode lock (including in RCU-walk
mode). `pid_revalidate()` calls `pid_update_inode()`, which calls
`task_dump_owner(task, inode->i_mode, &inode->i_uid, &inode->i_gid)`.
`task_dump_owner()` performs plain, unsynchronized 4-byte writes to
`inode->i_uid` and `inode->i_gid`, causing concurrent writers across CPUs to
race on the same `struct inode` fields.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=3b8f4ae71137f7af00ca

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3b8f4ae71137f7af00ca@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in task_dump_owner / task_dump_owner

write to 0xffff88811b422a60 of 4 bytes by task 6557 on cpu 0:
 task_dump_owner+0x146/0x170 fs/proc/base.c:-1
 pid_update_inode fs/proc/base.c:2032 [inline]
 pid_revalidate+0x65/0xb0 fs/proc/base.c:2057
 d_revalidate fs/namei.c:1041 [inline]
 lookup_fast+0x232/0x320 fs/namei.c:1874
 walk_component fs/namei.c:2284 [inline]
 link_path_walk+0x5d9/0xde0 fs/namei.c:2659
 path_openat+0x142/0x11e0 fs/namei.c:5012
 do_file_open+0x16c/0x290 fs/namei.c:5045
 do_sys_openat2+0xa1/0x140 fs/open.c:1443
 do_sys_open fs/open.c:1449 [inline]
 __do_sys_openat fs/open.c:1465 [inline]
 __se_sys_openat fs/open.c:1460 [inline]
 __x64_sys_openat+0xf2/0x120 fs/open.c:1460
 x64_sys_call+0x1f72/0x2550 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x11e/0x3a0 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

write to 0xffff88811b422a60 of 4 bytes by task 6556 on cpu 1:
 task_dump_owner+0x146/0x170 fs/proc/base.c:-1
 pid_update_inode fs/proc/base.c:2032 [inline]
 pid_revalidate+0x65/0xb0 fs/proc/base.c:2057
 d_revalidate fs/namei.c:1041 [inline]
 lookup_fast+0x232/0x320 fs/namei.c:1874
 walk_component fs/namei.c:2284 [inline]
 link_path_walk+0x5d9/0xde0 fs/namei.c:2659
 path_openat+0x142/0x11e0 fs/namei.c:5012
 do_file_open+0x16c/0x290 fs/namei.c:5045
 do_sys_openat2+0xa1/0x140 fs/open.c:1443
 do_sys_open fs/open.c:1449 [inline]
 __do_sys_openat fs/open.c:1465 [inline]
 __se_sys_openat fs/open.c:1460 [inline]
 __x64_sys_openat+0xf2/0x120 fs/open.c:1460
 x64_sys_call+0x1f72/0x2550 arch/x86/include/generated/asm/syscalls_64.h:258
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x11e/0x3a0 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 6556 Comm: syz.5.482 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
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
