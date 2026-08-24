Received: from mail-oi2-f4.google.com (mail-oi2-f4.google.com [74.125.231.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5B139EF25
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787557655; cv=none; b=osH11YxOuY24x2Go/Or4V5HNLbbwsvyCm6PPYqiRkMlrVr8nmrbbQyUNaT30t+3jxwUuo6NrhiT1G5KTQ8Ay0P2SiOEzQTjE8kvpytr7OkRE+p0qo62wLSvWy7zPIGdiY2t3Lx/lUh0c9MMAFAo9anybkooyfj0+pZJEpYrwk50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787557655; c=relaxed/simple;
	bh=uSxWJY8a5CLjZuEErwvpCzXXvGzdqJAZZGIqu/KXbKw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ATs9gXnRcYFNKnHf2zu8ylc7xFZrAb30/nzf0iNZHkvFz9hFkeLPcIgDZZeJjKNv7EvECTtOldSf73LjWsjElO+AHNxfjHsbMstDdLFLkDMaDizxuE/64F1sejgzhAfqwviV+xwv88LFq68VVnvnbwyKoJvoBeg2Cl4GG55WKGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f4.google.com with SMTP id 5614622812f47-4961058e787so427709b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 00:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787557653; x=1788162453;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rdFTXNKdZnj8wRa0kB+fQ1jCWh5iT/QDPNx/L7O9Mtg=;
        b=iRoaE03kqxdPib0wAT3EKLkuXjsPGjPkmsZ7+MibBHWDR5NT++NNYCJAsGxczYK2FN
         X4asqEO9g/WDYWSTsFA8or44aZ8H7xsM5LY9BhZxj0yyOG1Ft45Az7edRh0fxaFv84i9
         w/Cqhh60xvyxiXghcxe9ZU3285brJMdjXb2/Ek27fVX0QNfQE3j0rFv9P8m+pZTqlObc
         x9doFVp0dg9Kee6iXKfuMdOyXpGxk+pBEhHV8Gm/0MlrwQ/z/HQ2wNSTjKzKVhDeF0sy
         ZlsqQntAIr0rQ2lr9rdjXyxMIoFwNEgwPmQ01hJv7UcanwxwxQ+57kgYpm541gZj19Z9
         HbQw==
X-Forwarded-Encrypted: i=1; AHgh+Rog0weLTzA47gtvFHVqykPSZlci/NldWL3+RjZr1bjdltOSQdNknqguF19SrVtXgetZdExyY5V0PX4s9tS4@vger.kernel.org
X-Gm-Message-State: AFuF++mDroSbJRUgs5k4Jkmbhl6CdY3OP7fcTXo9oweTgDSO3I6Ppn47
	BYzvkVjtqg6/VixwfrypWfp7zuoUxsfz8oaSWczbGgWBp/zagbB939h5DGQ6vJwkHIK2OAMBpv8
	M6fGMRn6RhBKXLcArv3xZodNtN2O11UVGL1WyCsFZLZfYLHY6O/yOYBtZQ8E=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c1ba:b0:495:ce61:4e0c with SMTP id
 5614622812f47-4b309a0034bmr14802496b6e.3.1787557653158; Mon, 24 Aug 2026
 00:47:33 -0700 (PDT)
Date: Mon, 24 Aug 2026 00:47:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8bf715.dbb3a75c.13dd47.0065.GAE@google.com>
Subject: [syzbot] [exfat?] WARNING in fat_ent_write
From: syzbot <syzbot+26461e903494e689c24f@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6a746cd265ae Add linux-next specific files for 20260819
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13cdee79580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a1369648c551bbe
dashboard link: https://syzkaller.appspot.com/bug?extid=26461e903494e689c24f
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17760e79580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/32d71a199871/disk-6a746cd2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7bfb88f0043e/vmlinux-6a746cd2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4bc2ab35db01/bzImage-6a746cd2.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/500a74ccb5d4/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17e3d679580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+26461e903494e689c24f@syzkaller.appspotmail.com

         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
Buffer I/O error on dev loop0, logical block 1, lost sync page write
------------[ cut here ]------------
!buffer_uptodate(bh)
WARNING: fs/buffer.c:991 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:991, CPU#1: syz.0.17/5854
Modules linked in:
CPU: 1 UID: 0 PID: 5854 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:991
Code: 4c 89 f7 e8 09 0a d8 ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 74 52 fb ff e8 4f 40 68 ff eb 8c e8 48 40 68 ff 90 <0f> 0b 90 e9 a5 fd ff ff e8 3a 40 68 ff 90 0f 0b 90 e9 cf fd ff ff
RSP: 0018:ffffc9000345f2d0 EFLAGS: 00010293
RAX: ffffffff825f7f28 RBX: ffff8880714019a0 RCX: ffff8880317c5dc0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: dffffc0000000001 R08: ffff8880714019a7 R09: 1ffff1100e280334
R10: dffffc0000000000 R11: ffffed100e280335 R12: ffffffff8c288c60
R13: ffff888032a9c248 R14: dffffc0000000000 R15: ffff8880717c46a8
FS:  00007fc05a3146c0(0000) GS:ffff888124dda000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9293991000 CR3: 000000007992c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 mmb_mark_buffer_dirty+0x2c/0x1f0 fs/buffer.c:624
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
 generic_perform_write+0x2d5/0x8f0 mm/filemap.c:4374
 generic_file_write_iter+0xae/0x330 mm/filemap.c:4517
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_pwrite64 fs/read_write.c:794 [inline]
 __do_sys_pwrite64 fs/read_write.c:802 [inline]
 __se_sys_pwrite64 fs/read_write.c:799 [inline]
 __x64_sys_pwrite64+0x196/0x220 fs/read_write.c:799
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc05939e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc05a314028 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
RAX: ffffffffffffffda RBX: 00007fc059625fa0 RCX: 00007fc05939e0d9
RDX: 000000000000fdef RSI: 0000200000000140 RDI: 0000000000000004
RBP: 00007fc059435024 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000fecc R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc059626038 R14: 00007fc059625fa0 R15: 00007fff03653f68
 </TASK>


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
