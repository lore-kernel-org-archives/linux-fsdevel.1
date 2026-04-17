Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C4A27A133
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776390990; cv=none; b=ubj8FSyw29egSJ+rH+qRTz0fc1jSVZiqMeiQ1LjV7D8MVCFF4Qsu8LIFIaIdZyt/5ifFjRSIx0xIxTiZlw8DunBmEnEwY26o+575CHMwZYDAA4jl6LsQw6+sy0TReS4Pp3oYeQBGpBmpnzlJLdfMOPYmwMf5i/rtPpjy7MdkOrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776390990; c=relaxed/simple;
	bh=Rbs19hQ2Re/HS6wCwe0W3mR2Ij1FKxO/7qqJC/tKqRM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Fboveh9irngTzojtTSiyC8kyMKal8b69W3s/JVuAo61jBsYE3hP5wzJd46gsq2fbHSqLjPAvPsWL/VJQ5EgSCWkCnf9LXfDtVdWV24rfLLvFSD6x3m9TqfXF4xwgFmdME4bDa6s85jj97KAQgk7VfVjdG2j59k2cvuk+CtZttu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-66308f16ea1so357495eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 18:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776390988; x=1776995788;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8n5d8DMVM4BVKji/sHcvV+0h31uCKoYjxdEb8rGJSMU=;
        b=BLNFDr+f9lxIMb/cqjP4lu4n4aGwlkB/i+LgUAZ3DbDiBhuqiY6gaojxnYCi+CXzZl
         fULrpvAAtkYRxQP9n+Md4wtGf1KqT+jFQyDlfdFK2MoMDvcbHy7NEGNGdGp9d6VrJtSZ
         5Qb31UjFxSq7oXyssKHLi8/KPkujrtX+xbJC9ag5z3cNSgBRoU3H47OJj5oopUGp9kdw
         EQCrN4+u2TaBwQONTS8t2Xj5/E5vcOWfENxQuTkfJTpL68IM5W0JtUwWLhwhwzuIrANg
         w3eMcDvyzGbATBlM5SMQIkP/h/ou+cpopFHRquKuOgVnghuQ6ctMx3ZU7yIrD7zijw9Z
         unzA==
X-Forwarded-Encrypted: i=1; AFNElJ971OCUofl9NRKAB0TCD/1U/P+cKna2S3kCCjxjsXX2zNjBkHL5BuGZWzK8vSrGDV/TB19DZZHqzt1w7hJG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhegkz3kPNFqXo+317F34rXcqrDHFsVoTnsKrZtely/MAwnN+W
	Fql6/JZH62o62M0oIQSjCpoLyrIxSgRfH4J6XCcl8LG6ySeJcySTkidAEt73+mdUnsA4sX/ZtRh
	AkfCv7sx5CvA3IngnUBplqVKffRGnyMbCILvx2gyR3D793hi10IIRJa6T+9U=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:168c:b0:67d:e0fe:8434 with SMTP id
 006d021491bc7-69462e5e0c6mr589093eaf.27.1776390988323; Thu, 16 Apr 2026
 18:56:28 -0700 (PDT)
Date: Thu, 16 Apr 2026 18:56:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e1934c.a70a0220.7229.0011.GAE@google.com>
Subject: [syzbot] [hfs?] memory leak in __hfs_bnode_create
From: syzbot <syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    508fed679541 Merge tag 'ras_core_for_v7.1_rc1' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1481bb16580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7349847759051f
dashboard link: https://syzkaller.appspot.com/bug?extid=98547b0428b6a6a3467c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1281bb16580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=107938ce580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/36836f0baa65/disk-508fed67.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ab35bf742ab5/vmlinux-508fed67.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5fbf86a0b4d3/bzImage-508fed67.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d2ddc5d747a0/mount_4.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+98547b0428b6a6a3467c@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88811cabc840 (size 96):
  comm "syz.0.18", pid 6071, jiffies 4294943951
  hex dump (first 32 bytes):
    00 f0 54 15 81 88 ff ff 00 00 00 00 00 00 00 00  ..T.............
    00 00 00 00 00 00 00 00 03 00 7f 00 00 00 00 00  ................
  backtrace (crc 3e2dadb7):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4543 [inline]
    slab_alloc_node mm/slub.c:4866 [inline]
    __do_kmalloc_node mm/slub.c:5259 [inline]
    __kmalloc_noprof+0x3b7/0x550 mm/slub.c:5272
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __hfs_bnode_create+0x59/0x310 fs/hfsplus/bnode.c:469
    hfsplus_bnode_find+0x13e/0x580 fs/hfsplus/bnode.c:547
    hfsplus_btree_open+0x2fa/0x6d0 fs/hfsplus/btree.c:382
    hfsplus_fill_super+0x272/0x880 fs/hfsplus/super.c:548
    get_tree_bdev_flags+0x1c0/0x290 fs/super.c:1694
    vfs_get_tree+0x30/0x120 fs/super.c:1754
    fc_mount fs/namespace.c:1193 [inline]
    do_new_mount_fc fs/namespace.c:3763 [inline]
    do_new_mount fs/namespace.c:3839 [inline]
    path_mount+0x5a9/0x1360 fs/namespace.c:4159
    do_mount fs/namespace.c:4172 [inline]
    __do_sys_mount fs/namespace.c:4361 [inline]
    __se_sys_mount fs/namespace.c:4338 [inline]
    __x64_sys_mount+0x1a3/0x1e0 fs/namespace.c:4338
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xee/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88812c724d80 (size 96):
  comm "syz.0.19", pid 6082, jiffies 4294943963
  hex dump (first 32 bytes):
    00 90 e5 13 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 03 00 7f 00 00 00 00 00  ................
  backtrace (crc 289d56ee):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4543 [inline]
    slab_alloc_node mm/slub.c:4866 [inline]
    __do_kmalloc_node mm/slub.c:5259 [inline]
    __kmalloc_noprof+0x3b7/0x550 mm/slub.c:5272
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __hfs_bnode_create+0x59/0x310 fs/hfsplus/bnode.c:469
    hfsplus_bnode_find+0x13e/0x580 fs/hfsplus/bnode.c:547
    hfsplus_btree_open+0x2fa/0x6d0 fs/hfsplus/btree.c:382
    hfsplus_fill_super+0x272/0x880 fs/hfsplus/super.c:548
    get_tree_bdev_flags+0x1c0/0x290 fs/super.c:1694
    vfs_get_tree+0x30/0x120 fs/super.c:1754
    fc_mount fs/namespace.c:1193 [inline]
    do_new_mount_fc fs/namespace.c:3763 [inline]
    do_new_mount fs/namespace.c:3839 [inline]
    path_mount+0x5a9/0x1360 fs/namespace.c:4159
    do_mount fs/namespace.c:4172 [inline]
    __do_sys_mount fs/namespace.c:4361 [inline]
    __se_sys_mount fs/namespace.c:4338 [inline]
    __x64_sys_mount+0x1a3/0x1e0 fs/namespace.c:4338
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xee/0xf80 arch/x86/entry/syscall_64.c:94
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
