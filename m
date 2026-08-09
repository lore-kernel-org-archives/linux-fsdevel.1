Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F04353A6A
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Aug 2026 05:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786252650; cv=none; b=qNRQ2FjO6hLa3C9J2kCC1hXRaPkc/fnRQi4o5dlucPFO2rk7rmWqP9m6apDt6qnHIJHm8WjziAS1AolWENT9w9LQsVQx065BogJ3Z/jXnvHgirZsh7/6Au+bwQceZnclW3kzgYVJsT8bZjYj96W1fBDF7+QJ9GTgv8aZ66/kJCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786252650; c=relaxed/simple;
	bh=6rf9DNcFmUeHBIAD3k7+LZHmY6Fort1VqQQCDNvTd2o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=VeEr1aK7rc+nYQwwGvFtYFoDeZl0RdS7gglbiCVuTVqjzclQ4EycPp9MkUDCa18GasX5NrMkBGUcT49QvTnuJPzlb6gQG91x3tu87qRsreUood/Iv7h2Q8CRizWVSDxxPWkRx40792jll6XXJy500CgPYcafhw6+nlhpgdaldRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-455e3cdda0dso651227fac.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Aug 2026 22:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786252648; x=1786857448;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cir+hjq1/GcjmbQ+u2CnKvFg129q3AEWuRxIVt/GoKQ=;
        b=LxdcUBXB6v2YBVdpZ8Q9jd4kMjZa8KVRLSO2ga8fTIW+GROAIRJYvQOw1M4M5Grdjd
         9jHsKv+XMOGV9rXROtZNvDPS5Hpv/BdlcZJN6hZY7CPzTPS4bf0pBrSh2i9Gz0W+W8iv
         1RHnOmawYkH2sUrtY+sQREGhxWnsL5qIk9I4D5o9g0sTRmq9jVb+NfbHgtVpeX+LsIZy
         r+Z1tjCEDMnhOeIC9RRb9hzjIXVI66EracrghMXob+FvqaJbd7rONyXkYXJMg+L1ql+S
         zKS3y+W3d95U1Beh32OK3Z+/HClsBV+Bf+6h4LnlAqa2bL40XpJJE+6r3BLovULb8oFz
         7S/w==
X-Forwarded-Encrypted: i=1; AHgh+RpzqO+OUOUcB1+NWA/z6UYaW22agBLagfXLn81l1UO5eQYVV7kIyNAsB8IQblTRQhuoZOjZdKrzR0eJA8Oz@vger.kernel.org
X-Gm-Message-State: AOJu0YwtzbdTw76k4F64Tqv+AceytV0xWUwb5L7/DWYu+qzLpCfpC1Po
	2pJi3sCVEdFC212PtwlUwzXfAqUeIX2FOC7KVfyUqms84jt4P5u6mmlKjKjWSE4ex5OzsZ+X8w4
	Px0OAgZomKc7ItXp8+iY5fnmTadsYmAQTQW1etaw7KqWKdBsws4+AQq0zR3U=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2083:b0:6aa:9be1:484a with SMTP id
 006d021491bc7-6ae96c10158mr19163201eaf.7.1786252647937; Sat, 08 Aug 2026
 22:17:27 -0700 (PDT)
Date: Sat, 08 Aug 2026 22:17:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a780d67.9c11d2ce.289b96.00c5.GAE@google.com>
Subject: [syzbot] [fs?] VFS: Close: file count is zero (use-after-free) (2)
From: syzbot <syzbot+592c653b056459925299@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    06cf61899d64 Merge tag 'x86-urgent-2026-08-08' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100e8149580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c44651ea7dd2f307
dashboard link: https://syzkaller.appspot.com/bug?extid=592c653b056459925299
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=140e8149580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-06cf6189.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0e1bfee0387b/vmlinux-06cf6189.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c8ce37486654/bzImage-06cf6189.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+592c653b056459925299@syzkaller.appspotmail.com

 slab filp start ffff888028e2dc00 pointer offset 0 size 352
VFS: Close: file count is 0 (f_op=snd_ctl_f_ops)
------------[ cut here ]------------
kernel BUG at fs/open.c:1464!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 2 UID: 0 PID: 5914 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:filp_flush.cold+0x30/0x39 fs/open.c:1464
Code: 8d 7b 48 b8 ff ff 37 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 80 3c 02 00 75 13 48 8b 73 48 48 c7 c7 20 a7 e5 8b e8 f9 4f fd ff 90 <0f> 0b e8 11 07 56 01 eb e6 e8 ca 78 e5 00 65 48 8b 2d 5a 45 3e 13
RSP: 0018:ffffc900037e7828 EFLAGS: 00010286
RAX: 0000000000000030 RBX: ffff888028e2dc00 RCX: 0000000000000000
RDX: 0000000000000030 RSI: ffffffff81e8bfd9 RDI: fffff520006fcef6
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: e000000000000000
R13: bfffffffffffffff R14: ffff88802e9e2528 R15: 0000000000000000
FS:  00007f799a6e96c0(0000) GS:ffff8880d5fec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7999670000 CR3: 0000000048439000 CR4: 0000000000352ef0
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
RIP: 0033:0x7f799979e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f799a6e9028 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f7999a25fa0 RCX: 00007f799979e0d9
RDX: 000000000000000c RSI: 0000200000000400 RDI: 0000000000000003
RBP: 00007f7999835024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7999a26038 R14: 00007f7999a25fa0 R15: 00007ffe3d1aeca8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:filp_flush.cold+0x30/0x39 fs/open.c:1464
Code: 8d 7b 48 b8 ff ff 37 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 80 3c 02 00 75 13 48 8b 73 48 48 c7 c7 20 a7 e5 8b e8 f9 4f fd ff 90 <0f> 0b e8 11 07 56 01 eb e6 e8 ca 78 e5 00 65 48 8b 2d 5a 45 3e 13
RSP: 0018:ffffc900037e7828 EFLAGS: 00010286
RAX: 0000000000000030 RBX: ffff888028e2dc00 RCX: 0000000000000000
RDX: 0000000000000030 RSI: ffffffff81e8bfd9 RDI: fffff520006fcef6
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: e000000000000000
R13: bfffffffffffffff R14: ffff88802e9e2528 R15: 0000000000000000
FS:  00007f799a6e96c0(0000) GS:ffff8880d5fec000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7999670000 CR3: 0000000048439000 CR4: 0000000000352ef0


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
