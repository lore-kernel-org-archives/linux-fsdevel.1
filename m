Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A69339378
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 06:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786344691; cv=none; b=E5+iurKBI6WzlgwkcC1EmglLVwpp5JET0Y7C/5ZiRJCsOsf8nS4DAvuj8aS7b/qiJ5eUZuXzDNoKWuHGyg7IWAqPUJ2R+SIV0mNQsWL5sud19GbXbtoUSNSWVuqeWhnBqedsvZt1Bkc7f+L4xHQWDitc0ywaySu6p0OX58noZw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786344691; c=relaxed/simple;
	bh=6qhdnA4FsO3ujZJcF60jrKRJ7LofjlSCpuQNm3fYe/0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hBpT5ePm7g6G+iNoDRxMJD6W+IPLu371qviZc5YMPMFO3L+4K9MficdRSFFlP50WHGXD/Wr7x40qTCESWpMMOpu7n94vPrgu0GFQIPq1sBpvO87SlbACzvZsffTyQN3TqNsG8svtKwb8F1tS7PMlihZ7mkqztz0hWoQ0/WfV9l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7e9fdc2870fso957864a34.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Aug 2026 23:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786344689; x=1786949489;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nIJBDA7AsowxSH5xDU7NSUE60BtJkb/Ozou0eGLS6Ow=;
        b=r2r6+Sdx9m5jTxriOSm+BXU1UwFttElkyqQgyqlIGpNpHc0TPQvUq+jUF1XQOC7zj9
         0TTWnKRsNVRWKNtTYvDS5XRnZ+OOuTZH+w2KgQOmvPjx9Kf7ow56kpvDehFVnI28/Rbt
         uT1xIUvTNC6ijMyMN02mVeuhGA+lOkyv0eBPpcUdSFBnpU6uAh132FNitxFMUNiVZnSB
         upFM9ZibGj44weRNseY4fUjxPPdq99WaEeSEnr5vrNz6dOlo0UkioEo0AsGwF97uPkQM
         cWkLG+E1SM9F2HvHmtUA5/FlqReuw6Dh+qcAyFzLxqIKmsAwFT0rI73MGtFB7LoVVsQX
         RGfw==
X-Forwarded-Encrypted: i=1; AHgh+Rq4OepuvR6QuVDLj8hebqXNCSDV7LXsdqAFcFb6Jp2V62Hz73sCoRPSNok83NYngby1WvlNuqb1HECZzHuY@vger.kernel.org
X-Gm-Message-State: AOJu0YywtbKhNOA0Rd+mwuZErPBxh6H+t6vt+fSYo09sQtHMhxF4QqJu
	5nbojygT1POljQqcNPyJU8xiWk8Rkw7VN3P2sa2YV6hAjteK5Z+UsF3B6uQ7+n6N5yvQy3aEmgq
	rxclroZKT6mdq5ETT9uGCuH8lzfDWQ8Rn+5STzzeexPt2xZPPCmw8G4PE+Nc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee17:0:b0:6ae:42c7:ef95 with SMTP id
 006d021491bc7-6b041f7ff09mr8184468eaf.13.1786344689091; Sun, 09 Aug 2026
 23:51:29 -0700 (PDT)
Date: Sun, 09 Aug 2026 23:51:29 -0700
In-Reply-To: <6a780d67.9c11d2ce.289b96.00c5.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7974f1.01d0871a.3a0d52.00a1.GAE@google.com>
Subject: Re: [syzbot] [fs?] VFS: Close: file count is zero (use-after-free) (2)
From: syzbot <syzbot+592c653b056459925299@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    db2ddb871435 Linux 7.2-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12ce2079580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=592c653b056459925299
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15406079580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11745132580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-db2ddb87.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/698def9fcf7a/vmlinux-db2ddb87.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fd8b6091a563/bzImage-db2ddb87.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+592c653b056459925299@syzkaller.appspotmail.com

 slab filp start ffff888033422a80 pointer offset 0 size 352
VFS: Close: file count is 0 (f_op=snd_ctl_f_ops)
------------[ cut here ]------------
kernel BUG at fs/open.c:1464!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 5911 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:filp_flush.cold+0x30/0x39 fs/open.c:1464
Code: 8d 7b 48 b8 ff ff 37 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 80 3c 02 00 75 13 48 8b 73 48 48 c7 c7 20 a7 e5 8b e8 f9 4f fd ff 90 <0f> 0b e8 91 07 56 01 eb e6 e8 ca 78 e5 00 65 48 8b 2d 5a 45 3e 13
RSP: 0018:ffffc9000681f828 EFLAGS: 00010286
RAX: 0000000000000030 RBX: ffff888033422a80 RCX: 0000000000000000
RDX: 0000000000000030 RSI: ffffffff81e8bfd9 RDI: fffff52000d03ef6
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: e000000000000000
R13: bfffffffffffffff R14: ffff888027786528 R15: 0000000000000000
FS:  000055556f1f4500(0000) GS:ffff8880d5dec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb5d8c70000 CR3: 000000003c1d3000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 filp_close+0x1c/0x30 fs/open.c:1484
 gaudio_close_snd_dev drivers/usb/gadget/function/u_uac1_legacy.c:263 [inline]
 gaudio_cleanup+0x59/0x100 drivers/usb/gadget/function/u_uac1_legacy.c:305
 f_audio_bind+0x56c/0x660 drivers/usb/gadget/function/f_uac1_legacy.c:792
 usb_add_function+0x219/0x890 drivers/usb/gadget/composite.c:333
 configfs_composite_bind+0xd83/0x1960 drivers/usb/gadget/configfs.c:1802
 gadget_bind_driver+0x28c/0xbf0 drivers/usb/gadget/udc/core.c:1662
 call_driver_probe drivers/base/dd.c:628 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:706
 __driver_probe_device+0x20e/0x450 drivers/base/dd.c:868
 driver_probe_device+0x4a/0x140 drivers/base/dd.c:898
 __driver_attach+0x21f/0x5b0 drivers/base/dd.c:1292
 bus_for_each_dev+0x13e/0x1d0 drivers/base/bus.c:383
 bus_add_driver+0x305/0x5b0 drivers/base/bus.c:763
 driver_register+0x1e2/0x360 drivers/base/driver.c:174
 usb_gadget_register_driver_owner+0x132/0x210 drivers/usb/gadget/udc/core.c:1752
 gadget_dev_desc_UDC_store+0x1b0/0x2e0 drivers/usb/gadget/configfs.c:300
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1050 fs/read_write.c:687
 ksys_write+0x12a/0x250 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb5d8d9e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdccfb2e58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fb5d9025fa0 RCX: 00007fb5d8d9e0d9
RDX: 000000000000000c RSI: 0000200000000400 RDI: 0000000000000003
RBP: 00007fb5d8e35024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fb5d9025fac R14: 00007fb5d9025fa0 R15: 00007fb5d9025fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:filp_flush.cold+0x30/0x39 fs/open.c:1464
Code: 8d 7b 48 b8 ff ff 37 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 80 3c 02 00 75 13 48 8b 73 48 48 c7 c7 20 a7 e5 8b e8 f9 4f fd ff 90 <0f> 0b e8 91 07 56 01 eb e6 e8 ca 78 e5 00 65 48 8b 2d 5a 45 3e 13
RSP: 0018:ffffc9000681f828 EFLAGS: 00010286
RAX: 0000000000000030 RBX: ffff888033422a80 RCX: 0000000000000000
RDX: 0000000000000030 RSI: ffffffff81e8bfd9 RDI: fffff52000d03ef6
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: e000000000000000
R13: bfffffffffffffff R14: ffff888027786528 R15: 0000000000000000
FS:  000055556f1f4500(0000) GS:ffff8880d5eec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdccfb3118 CR3: 000000003c1d3000 CR4: 0000000000352ef0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
