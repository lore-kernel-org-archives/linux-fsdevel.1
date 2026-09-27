Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7202D3CBE66
	for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 08:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790496747; cv=none; b=W2V2sRVBg94U9Uq80dCnU5ceq2fvlfEtMwc+9PqnnG5eiX7XqporDwIH28op1ZgX1aXLLcX554jr8Lo0C1d8QKvWV107Lb9b114J8ztVa/dMkeKiqBXSqGygkOeHI/lng+qeO0Epqk0/XfkDJNsCeIHtEk+6xrZkR5EqZzG47c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790496747; c=relaxed/simple;
	bh=lLMJealxkAdXTURrDg7UpeKv4UMlYxrVStomrTmBkek=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fjJBGIPgVnbuDWP8ZclIPWBxvltKTVfSNJj8dCZ7y2BVwSxfPu/ORJtjHN8P7qO5Kt3cszS9oZtJMti5nd23XNjzmmk+lN+RM5eN2AP7wZKi3TP+QMK99Tx7U43B5b9HuUg4XtQyWyvnd4UwC+0aaalUbZNJeU96xFVeQoUmgRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4e937c5bd4fso147991b6e.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 27 Sep 2026 01:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790496744; x=1791101544;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=K9X8BY6U+YIcepRPV0MZIBm8qRqdDSo7Q6FIIDDCDBA=;
        b=pes49NR5y4fjJ0UJ9Hzs9Hv2LrUU6OYyruOBfKwnK/6SeI90ADm3jXO0Uk56GFRSt1
         wD88xYW7xZFMeJ5nWh3/tJQdZvpXDo1Hh0tw2EYdYNPN73SYb7qMUnbli9RAn72/BgBu
         +vhcQN35vLRYi8aGcIUiEeL02HQfXBq4WzOkrdQOHoUoLh0ERcgt35P66Km+Elb9rW2V
         K6LWkgIw9/7I+AGtXwG+4Ktulkc+7YFatt90CibhjI6zuMiCwup5gDUmpGFu2xMYr+iS
         vq2LKCv2mSsp49JNKu0V7pOTXcJA10LxQ5C57EgZ2rajgfF1MIGoRjmd1m/wnpsr69hr
         Xnuw==
X-Forwarded-Encrypted: i=1; AKwUvBwRG//KHUd+bE3aAuhUFOn/XCuB7IJTDQa9O98X83QONAWDy7+JQ4YrtT+5VqR3K0lP7iYHWIl7rH39jwpA@vger.kernel.org
X-Gm-Message-State: AFuF++mst+sOZx73dMH6tXDxnL1J6Fz+3jW/IMRSfUAbEk9etsu7Afb3
	vwBRAuXvpER5/Mj1lOMXLisdKPaLbXZdaQhnVnVzkYGCnFWlky6ANGQkUc2xhd4FR8fmtX5VBeQ
	iTGYeHRb4QoEc8zbnCun4AdAnD3nk6oPl9lS/JR2ecq6J8rgMisOrsFCREUU=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:10c6:b0:4d3:6be7:c64a with SMTP id
 5614622812f47-4dc478167f9mr6530733b6e.0.1790496744441; Sun, 27 Sep 2026
 01:12:24 -0700 (PDT)
Date: Sun, 27 Sep 2026 01:12:24 -0700
In-Reply-To: <6ab7dca9.80e1c6cc.1e8e5f.0046.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab8cfe8.dc2998a4.2261f5.0062.GAE@google.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_iomap_writeback_range
From: syzbot <syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com>
To: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fd179f8a05be Merge tag 'ata-7.3-rc5' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13490605580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d4242cb1c54cdf7
dashboard link: https://syzkaller.appspot.com/bug?extid=e8200299b0556976e13c
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1523f2c9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14385315580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c4cebd01ff3c/disk-fd179f8a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9fd8641fa35c/vmlinux-fd179f8a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c6e8e6332600/bzImage-fd179f8a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com

------------[ cut here ]------------
!ff
WARNING: fs/fuse/file.c:2043 at fuse_write_file_get fs/fuse/file.c:2043 [inline], CPU#0: syz-executor122/5774
WARNING: fs/fuse/file.c:2043 at fuse_iomap_writeback_range+0x7c8/0x18f0 fs/fuse/file.c:2227, CPU#0: syz-executor122/5774
Modules linked in:
CPU: 0 UID: 0 PID: 5774 Comm: syz-executor122 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:fuse_write_file_get fs/fuse/file.c:2043 [inline]
RIP: 0010:fuse_iomap_writeback_range+0x7c8/0x18f0 fs/fuse/file.c:2227
Code: fe 48 83 3b 00 74 5b e8 e6 f0 6c fe 4c 8b 3c 24 e9 08 0b 00 00 e8 d8 f0 6c fe eb 5c e8 d1 f0 6c fe 4c 89 f7 e8 39 63 8e 08 90 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 48 8b 4c 24 58 80 3c 01 00
RSP: 0018:ffffc90003e172b8 EFLAGS: 00010286
RAX: 8000000000000000 RBX: ffff88806e4ea880 RCX: ffffffff9a9ec501
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 00000000ffffffff
RBP: 0000000000001000 R08: ffff88806e4eae63 R09: 1ffff1100dc9d5cc
R10: dffffc0000000000 R11: ffffed100dc9d5cd R12: ffff88806e4ead08
R13: 0000000000001000 R14: ffff88806e4eae60 R15: ffff88806e4ead08
FS:  00007f6a3f53e6c0(0000) GS:ffff888124cc8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000000b000 CR3: 0000000078090000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 iomap_writeback_range fs/iomap/buffered-io.c:1896 [inline]
 iomap_writeback_folio+0x1526/0x2490 fs/iomap/buffered-io.c:2022
 fuse_launder_folio+0x17b/0x240 fs/fuse/file.c:2331
 folio_launder mm/truncate.c:612 [inline]
 folio_unmap_invalidate+0x4cd/0x830 mm/truncate.c:634
 invalidate_inode_pages2_range+0x629/0xb30 mm/truncate.c:726
 fuse_open+0x5a6/0x770 fs/fuse/file.c:297
 do_dentry_open+0x816/0x1380 fs/open.c:996
 vfs_open+0x3b/0x340 fs/open.c:1101
 do_open fs/namei.c:4837 [inline]
 path_openat+0x1443/0x1d60 fs/namei.c:5000
 do_file_open+0x23e/0x4a0 fs/namei.c:5029
 do_sys_openat2+0x115/0x200 fs/open.c:1417
 do_sys_open fs/open.c:1423 [inline]
 __do_sys_openat fs/open.c:1439 [inline]
 __se_sys_openat fs/open.c:1434 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1434
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6a3f58fae9
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6a3f53e1d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f6a3f644b98 RCX: 00007f6a3f58fae9
RDX: 0000000000000040 RSI: 000020000000c380 RDI: 00000000ffffff9c
RBP: 00007f6a3f644b90 R08: 31203a6b63617473 R09: 31203a6b63617473
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6a3f6117f4
R13: 000020000000e3c0 R14: 00002000000062c0 R15: 00007ffe0b2d2af8
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
