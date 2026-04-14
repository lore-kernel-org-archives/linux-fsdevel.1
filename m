Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D73638A710
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 23:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776208850; cv=none; b=Z81xlwqbR19UubM4UZoz6zuTde921Zsg/YOARvpX96gf08jgbgqOO6kjnPfNFHkAMYP1P0ucIPXV4AkGOe1QiJ/GPrwpnuloQUxVMemjhVNxEh9ndPSOXKNaVNQXPwP4JNepjWLPooHSjDL0EawKA+T7+0x3h3CLoRf8jrB2JW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776208850; c=relaxed/simple;
	bh=6JOf/hIBiqX2D7949boXh1336cGQ+q47OYt8p5XGIYE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=n9I9gfWlI940wtg1OOPsXX4dzQeSusaeNOqq7eqoh43mojerMdxFSVylfo5+XNhGsggnI3m8OUpD1dU/1Ok3bBqYCXUxVzT3vUY3GZzZeAb4wTxWH2Ze1ElOjWqZRphzzbIUlvIjsgoUBdQrcff6YgnuFGP3C4wZOZtiF3h9+8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-40ad1c724daso9598056fac.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 16:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776208848; x=1776813648;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3KG01RFFg8KZFhfZ6cLVjTgJntF7tjXwqDBRwaszFvY=;
        b=aM1QxrF31KuUQ01rhClXWZnV1WSsRa9SfM3Ah1yb+9GDtu0k5P6Y4Y53mqS36MDwY4
         rjP/TWFgXky5FRrljWrvN1qCnSgsoYGdFdui5pk8ddsNRWg2vhPreYoVIRXEJEdJtzen
         uSjRRcrc1m4ce8cmL0+9lKVhy84GAnkOV7MVgCJfRPrN34ElkUkWGkXoxcyfsQpgd86l
         ua1GApvc9z970iL/k1g9eDr0Hh9n1QVQqUUdCH+eFyok/fLnaS1Nxm01jRHmOOtFCDla
         3mdkoe2STdUpph702ETvSfOLlOhQ5ZCRbdg8qiwc/p8dbsH630nGRfiRc1rW9SWhM3Pe
         +aWg==
X-Forwarded-Encrypted: i=1; AFNElJ91HfI4dbbMUnPNsJUVM2W0l+8/bzKMb8WnajumUug85pHwTCJjt+FmDe0Rz/hJSW6+Gwhrt+vugFb9s2zc@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzJ/+xtsOX/baTxbUV0aL7t4ZcW1pkmoTTRbqGOh1LYzUpAgE
	hKWlMW5PuqlfIGv4Vyxp1VDhaUm7V8ACn12XRzMWqj2Vx7cf+VLVq5RKQC/ScH1oWWYf7hmtYQI
	1wUiczCnxe93npEM+C0m/cM7pxzqQ+Ac6PJlK0/g7G8cfY3LE+B1EzHn1QKw=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:308d:b0:692:9993:3fad with SMTP id
 006d021491bc7-692999347b6mr1424088eaf.64.1776208848133; Tue, 14 Apr 2026
 16:20:48 -0700 (PDT)
Date: Tue, 14 Apr 2026 16:20:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69decbd0.a00a0220.468cb.006b.GAE@google.com>
Subject: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_bnode_find
From: syzbot <syzbot+217eb327242d08197efb@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d60bc1401583 Merge tag 'pwrseq-updates-for-v7.1-rc1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16cbe8ce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b03ae1ea24aea48
dashboard link: https://syzkaller.appspot.com/bug?extid=217eb327242d08197efb
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13fe84ce580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11d5feba580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0751271be83e/disk-d60bc140.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f53e11b04b29/vmlinux-d60bc140.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c57f9a8e1f1/bzImage-d60bc140.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/438dc293e7d9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 1024
hfsplus: requested invalid offset: NODE: id 0, type 0x1, height 0, node_size 1, offset 4294967295
=====================================================
BUG: KMSAN: uninit-value in hfsplus_bnode_find+0x141c/0x1600 fs/hfsplus/bnode.c:584
 hfsplus_bnode_find+0x141c/0x1600 fs/hfsplus/bnode.c:584
 hfsplus_btree_open+0x169a/0x1e40 fs/hfsplus/btree.c:382
 hfsplus_fill_super+0x111f/0x2770 fs/hfsplus/super.c:553
 get_tree_bdev_flags+0x6e6/0x920 fs/super.c:1694
 get_tree_bdev+0x38/0x50 fs/super.c:1717
 hfsplus_get_tree+0x35/0x40 fs/hfsplus/super.c:709
 vfs_get_tree+0xb3/0x5d0 fs/super.c:1754
 fc_mount fs/namespace.c:1193 [inline]
 do_new_mount_fc fs/namespace.c:3763 [inline]
 do_new_mount+0x885/0x1dd0 fs/namespace.c:3839
 path_mount+0x7a2/0x20b0 fs/namespace.c:4159
 do_mount fs/namespace.c:4172 [inline]
 __do_sys_mount fs/namespace.c:4361 [inline]
 __se_sys_mount+0x704/0x7f0 fs/namespace.c:4338
 __x64_sys_mount+0xe4/0x150 fs/namespace.c:4338
 x64_sys_call+0x39f0/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x134/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable data.i created at:
 hfsplus_bnode_read_u16 fs/hfsplus/bnode.c:58 [inline]
 hfsplus_bnode_find+0xd6f/0x1600 fs/hfsplus/bnode.c:583
 hfsplus_btree_open+0x169a/0x1e40 fs/hfsplus/btree.c:382

CPU: 0 UID: 0 PID: 6044 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
=====================================================


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
