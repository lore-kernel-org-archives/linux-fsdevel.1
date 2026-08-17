Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EBD285058
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 02:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786932933; cv=none; b=SZpQFffHe2yNx+ELwKIz3e0r0Xu21YMM+zSoV2leRJlMz+fWgWVCBMdo8aS9MbZcVy38wQuzQ431MVBbkoj9LyedWPrKCrPs6xCO7emEQmbCcMZOhMsZPcKQxO1F+RmaO5kX+bmFUrcQmuwrxdhtOLYpAspgXSXne2khUFvCNhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786932933; c=relaxed/simple;
	bh=mNkSF1ZcoMn+ga59hTYTohTkP7ZiRYj4ZunpmVCfzo4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Cs8EaSMs04RVIGgMYJYTWVfvi8p8c4CyuJGy9P7maEa120jGRd0xvj2pzLk6oByhyEZJy5RrFwrYJEPFmCPpA2IaBcbTa6F1pnwGzZqjLehIEfJblhwZckDdSuvcaitDvV4awakakz2z8qn8e5GTgsxadOTeLn0wQTt8I+MZfN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6b03663d906so1239186eaf.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Aug 2026 19:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786932930; x=1787537730;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/VsnQs59f+hlKY30my1HgtF1nrtn+p2VRuv+FAV5UAQ=;
        b=ILh05Zi7ZzGpdmm4B0lNUMUxsiHOCYKqIi7+oJFLO4Jnu0ulpYS2lQo/8Zv6QywxNM
         EV1vr9vy5KHtWx+WZ43y/DcmG0yx90ufAAh1RhOfqt8JbrYCxboyd2AYGHEBqubQeoET
         mXM//bSoxLPulw7tiZj/M49PNItuVss7gpRxz8R9Z46TvhrNVaHjE28Az0vAUfETFkXe
         StRttpdvDf22KfOtlTJ4/MAyq8LfPFSZyuRdQe1fUBy93efxI4E0s6ipru86QZOXt6tS
         mG5T1WoHmi+1UJZAzaTXHW1bjq9y7JsBFTgFgUdn+ZpdRvs4Lg6AxyIDppH3g+YAyCnF
         7N+w==
X-Forwarded-Encrypted: i=1; AHgh+Rrq5F6X5klG7kwFKJcM5pQRBHr0wbaLyG/ovJ6fLWHaeszzVUxpv26w8XpYWHDuXbPEeDGP+CoJl98y5aa2@vger.kernel.org
X-Gm-Message-State: AOJu0YzLtX8dnEYYyIPPRQU0iGgJrOAjCCmnrkWdre6WAPKdRaAfGLCh
	nS9MGrxFRKP5DgYFfEG/oOS2rsQEEKGobrIYqkG3Xmhg3VwLe1t7OgcaFVgCfGRNaGNGauoYi0L
	EuUwYKGdiwn9NK9DmckQP/KU93hOw4pxqYmI+WiJZ9Cst4DUOP6vKDJGJU/0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1986:b0:6a3:c5:30ca with SMTP id
 006d021491bc7-6b0d6919fc7mr19587446eaf.31.1786932930395; Sun, 16 Aug 2026
 19:15:30 -0700 (PDT)
Date: Sun, 16 Aug 2026 19:15:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a826ec2.dbb3a75c.20434b.003e.GAE@google.com>
Subject: [syzbot] [exfat?] WARNING in fat12_ent_put
From: syzbot <syzbot+e64c6472a3d96a75172a@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    28d012efb432 Add linux-next specific files for 20260812
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=104eec79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a13c7bc480b5c3f
dashboard link: https://syzkaller.appspot.com/bug?extid=e64c6472a3d96a75172a
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/de882be6df4b/disk-28d012ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/412cb9fb7e2d/vmlinux-28d012ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9d7096c27f1b/bzImage-28d012ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e64c6472a3d96a75172a@syzkaller.appspotmail.com

Buffer I/O error on dev loop0, logical block 1, lost sync page write
------------[ cut here ]------------
!buffer_uptodate(bh)
WARNING: fs/buffer.c:991 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:991, CPU#1: syz.0.824/10458
Modules linked in:
CPU: 1 UID: 0 PID: 10458 Comm: syz.0.824 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:991
Code: 4c 89 f7 e8 49 11 d8 ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 34 53 fb ff e8 9f a3 69 ff eb 8c e8 98 a3 69 ff 90 <0f> 0b 90 e9 a5 fd ff ff e8 8a a3 69 ff 90 0f 0b 90 e9 cf fd ff ff
RSP: 0018:ffffc900065273f8 EFLAGS: 00010287
RAX: ffffffff825e07c8 RBX: ffff888056e9e460 RCX: 0000000000080000
RDX: ffffc90003f49000 RSI: 0000000000001234 RDI: 0000000000001235
RBP: dffffc0000000001 R08: ffff888056e9e467 R09: 1ffff1100add3c8c
R10: dffffc0000000000 R11: ffffed100add3c8d R12: dffffc0000000000
R13: 1ffff92000ca4eb6 R14: ffffc900065275b0 R15: ffff888050e4ccf8
FS:  00007fe3dc5436c0(0000) GS:ffff888124dfc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2e6edff8 CR3: 000000007c12c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 mmb_mark_buffer_dirty+0x2c/0x1f0 fs/buffer.c:624
 fat12_ent_put+0x1b7/0x2f0 fs/fat/fatent.c:173
 fat_ent_write+0xb8/0x190 fs/fat/fatent.c:422
 fat_chain_add+0x409/0x8e0 fs/fat/misc.c:140
 fat_add_cluster fs/fat/inode.c:113 [inline]
 __fat_get_block fs/fat/inode.c:155 [inline]
 fat_get_block+0x768/0xae0 fs/fat/inode.c:190
 __block_write_begin_int+0x6c2/0x1900 fs/buffer.c:2030
 block_write_begin fs/buffer.c:2144 [inline]
 cont_write_begin+0x71b/0xac0 fs/buffer.c:2506
 fat_write_begin+0x7a/0x150 fs/fat/inode.c:230
 cont_expand_zero fs/buffer.c:2434 [inline]
 cont_write_begin+0x2d6/0xac0 fs/buffer.c:2496
 fat_write_begin+0x7a/0x150 fs/fat/inode.c:230
 generic_cont_expand_simple+0x146/0x210 fs/buffer.c:2397
 fat_cont_expand+0x61/0x1f0 fs/fat/file.c:226
 fat_fallocate+0x22f/0x2f0 fs/fat/file.c:304
 vfs_fallocate+0x65a/0x7e0 fs/open.c:338
 ksys_fallocate fs/open.c:362 [inline]
 __do_sys_fallocate fs/open.c:367 [inline]
 __se_sys_fallocate fs/open.c:365 [inline]
 __x64_sys_fallocate+0xbf/0x110 fs/open.c:365
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe3db59e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe3dc543028 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007fe3db825fa0 RCX: 00007fe3db59e0d9
RDX: 0000000000000009 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 00007fe3db635024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000010001 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe3db826038 R14: 00007fe3db825fa0 R15: 00007fffaef17d98
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
