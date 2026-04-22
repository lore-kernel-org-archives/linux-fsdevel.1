Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7CA374185
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776844304; cv=none; b=f746v8FRrjM+MErkPh8letrbUpV+Zll60h/ijGy47OxFrdyfVf5dCQBWub//+c657cisTGNrPw25faPg+LtUFP3tZFPhewCoDOPsBxXr5mo+2hEb1Uv/jaqLvOrdL8A0AnPoiUCJCaFvwLw4Z1YsdxXUnCgpLdjO6nMH4SRqbEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776844304; c=relaxed/simple;
	bh=iMCEn6/9aY1zgO+c75wdSdMeBzuvzS+W118TlkDvocU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HglKr1OFhKXK4GBW/8W/GdGj8VQnIzHff2OGc+wYqY7vdp0+K5YY9WFUQDmNOn97791e2vctbPdAlGPZpFPB3Epf4DuoxRxMDZiKZz0GUOCrUhkBJJWt/pZhX6o+gcgtgcj1XX1XP9Yrpq2cTre9/DeADe2hHwOhL1e6jtbZGFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-679c5ed0942so7965282eaf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 00:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776844302; x=1777449102;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7mKqtV6o3nvTDKJ8UyCQde9iDS2m5MtQg43r+XP/SJg=;
        b=dpKY+LUfYg+atq6VpjYIlbNCuCZASpg47gcU13/PdiVy+wN22IySGKahNrsocKxOWj
         WnFoxg2TRooXgkfnLppkSnZ7Tw7NUEow/gAzzXvbostBMOEhnkRfIYGHvBNRH6RCpEwB
         mTt1Ong+SKX480/UMonoFxAOoCCqkrLO5xpgSl0SEQ0Vp8vmOcMAiE75DuChJG1Pg1ou
         JIHD1g6EocmML0VHB3AK4K9sMze+cNvuzdiyI+j8TXfwjVAK+2Qq5XOXVJDKPD8jkDcS
         7tNgTu+Wt/mL0546PXhcSw2tH58OrGQ3bqu7bSZHbEeQLZs9ltL2rWRIl6G6cXNgAeoU
         6TcA==
X-Forwarded-Encrypted: i=1; AFNElJ/gaJfs0goJ+xNxld77baTqH1MUD/Q14kvESyZSvom9KmTVJfEqlIFck+cwxEUmW79vX6V0Qwp0lupKOhF8@vger.kernel.org
X-Gm-Message-State: AOJu0YzsdWpPLfG/R1QGZjxR06fBbsBJKMxXSLmnT0z8d9f6QSjBecoG
	hWCe+G2XxFxUN5UUTZsKBXoH8dwVS/xQ8PB0WwVjXnaEDb6iNQ8JBJCJ7zXcoGpI5cC0geUi6fB
	VMQ5hUqTdlp66oq2j+iv+ymaT1e0Qgirx6s1qjR3/HC9mUMkUMjW8xS4oID8=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3108:b0:68c:c971:9ef0 with SMTP id
 006d021491bc7-69462dee1ecmr11582334eaf.1.1776844302419; Wed, 22 Apr 2026
 00:51:42 -0700 (PDT)
Date: Wed, 22 Apr 2026 00:51:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e87e0e.a00a0220.9259.001c.GAE@google.com>
Subject: [syzbot] [fs?] kernel BUG in sock_release
From: syzbot <syzbot+f2b5401166003c7d09c1@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6596a02b2078 Merge tag 'drm-next-2026-04-22' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1156ac36580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e19fa1907a3dfda
dashboard link: https://syzkaller.appspot.com/bug?extid=f2b5401166003c7d09c1
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-6596a02b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1e78cc4623b5/vmlinux-6596a02b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ae78b19bafa/bzImage-6596a02b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2b5401166003c7d09c1@syzkaller.appspotmail.com

VFS_BUG_ON_INODE(inode_state_read_once(inode) & (I_FREEING | I_CLEAR)): inode:ffff888059f79900 fs:sockfs mode:140777 opflags:0x8 flags:0x0 state:0x300 count:0
------------[ cut here ]------------
kernel BUG at fs/inode.c:1980!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 17707 Comm: syz.6.3284 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:iput.part.0+0xa94/0xf50 fs/inode.c:1980
Code: 88 76 ff 48 c7 c6 60 9a c5 8b 48 89 df e8 74 68 ff ff 90 0f 0b e8 ac 88 76 ff 48 c7 c6 40 8f c5 8b 48 89 df e8 5d 68 ff ff 90 <0f> 0b e8 95 88 76 ff 48 c7 c6 00 9a c5 8b 48 89 df e8 46 68 ff ff
RSP: 0018:ffffc90005107128 EFLAGS: 00010296
RAX: 0000000000000000 RBX: ffff888059f79900 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81250760 RDI: fffff52000a20de7
RBP: 0000000000000300 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffff888059f79860
R13: ffffffff90dc56e4 R14: ffff888059f799d0 R15: dffffc0000000000
FS:  00007f3057bab6c0(0000) GS:ffff8880d65db000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3056de9f00 CR3: 0000000058d5d000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 iput+0x35/0x40 fs/inode.c:1975
 __sock_release net/socket.c:734 [inline]
 sock_release+0x169/0x1c0 net/socket.c:750
 rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
 rxe_sock_put+0xae/0x130 drivers/infiniband/sw/rxe/rxe_net.c:639
 rxe_net_del+0x83/0x120 drivers/infiniband/sw/rxe/rxe_net.c:660
 rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
 nldev_dellink+0x289/0x3c0 drivers/infiniband/core/nldev.c:1849
 rdma_nl_rcv_msg+0x392/0x6f0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2cb/0x410 drivers/infiniband/core/netlink.c:239
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2698
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2752
 __sys_sendmsg+0x170/0x220 net/socket.c:2784
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3056d9c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3057bab028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f3057015fa0 RCX: 00007f3056d9c819
RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000000000000003
RBP: 00007f3056e32c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3057016038 R14: 00007f3057015fa0 R15: 00007ffd5324c968
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:iput.part.0+0xa94/0xf50 fs/inode.c:1980
Code: 88 76 ff 48 c7 c6 60 9a c5 8b 48 89 df e8 74 68 ff ff 90 0f 0b e8 ac 88 76 ff 48 c7 c6 40 8f c5 8b 48 89 df e8 5d 68 ff ff 90 <0f> 0b e8 95 88 76 ff 48 c7 c6 00 9a c5 8b 48 89 df e8 46 68 ff ff
RSP: 0018:ffffc90005107128 EFLAGS: 00010296
RAX: 0000000000000000 RBX: ffff888059f79900 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81250760 RDI: fffff52000a20de7
RBP: 0000000000000300 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffff888059f79860
R13: ffffffff90dc56e4 R14: ffff888059f799d0 R15: dffffc0000000000
FS:  00007f3057bab6c0(0000) GS:ffff8880d65db000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f3056de9f00 CR3: 0000000058d5d000 CR4: 0000000000352ef0


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
