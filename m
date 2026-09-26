Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0D33AB286
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 14:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790434476; cv=none; b=DM0adk1K48Du5iXpLqt54UpmpSQsDXwXQduk+HGqRoz8kHtPAe05imdWOLLYbxI24BTf6Gd7C7dKwCwjdBZKmCsCRCfgoChR3jfYGTlKyvANL/qG1nXGn0vUTcF5/KJlvrFfz6HyOzYTZctkpMY7QkkumSNTAfOG4xMYJXjCBoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790434476; c=relaxed/simple;
	bh=wpoe2NbyDw8UDfaaqOWcUSlSP/xT09RLX4P5/7CZaJk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NLJRla6QulOfalq7uhyxb/whiQ1YPKtL0SE8om4oTRq5EZQ+Xb5UgsuZlisXKK9YgPJJ+7f6wuN/9yGzuTQO7R3v8YGv31XpLY4ZlslDU0TWAPEEdjX83QilvhQPMpfsaHOvqlSb5R2Dg7N5jgRC/fo0EoAq57oTKD4VE8Wh3b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4c55ba309c2so3229482b6e.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 07:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790434473; x=1791039273;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ahls61jkZLVMkVh3QQjBqgRuSrPo5tBwRCH8iAs3so=;
        b=fKjP/Oni3N855gwwgoaXeK4SOhueRN0U+uyiZeBKrNNVfQlTRSl8Dfk/4HdkPKrvcm
         CPaDQTXsxbj95CaaKQ7Q9LOzCWcPHSXkum1MDHJuRhWe2c75JEelNrj0Df8ZuA4E6QlJ
         iUtzSQ0/BYchcGGZn8vTfjg9uRO4yokD7hrXGrbm99SsePMKMW4SCZZ+IUmHPhDKh8J9
         O3Ibr3uLvRI8XSGNBzhbcLFN2FvmYqp0tYSZwrne82vkgoSSUnJYW8fv8PZt6HulR29a
         XYHU9m2jNLYkkc8dkjYqfG1sN2eeoZTP7rFNXL7rSRuj3vMh72LJjIu5WPrpDFhRhiz/
         62Uw==
X-Forwarded-Encrypted: i=1; AKwUvBwAxczNeyX8mm6ax7axKkcc3Q7JT3ocWjSlX87QR6klC9nQNaH2bIAUG21cj2Qv1HQAHcGYnAiyOkJ0GyBD@vger.kernel.org
X-Gm-Message-State: AFuF++kreG5vI7yTI5na66NTNuV8f/y1W2YFqByPmUm/FeYH+0qB3Jgb
	yYdmlKiLBTMZNV4XrXcM5QLxPp+wND7//DSpKrTuO+e/5HmaqPzkSGw7rpwq3V1fRyqMwc1cjXY
	g7SzDg69m8E7iIkxz+/ebVia2MPG1l1CavSXu5kuwBmxVfGTw6L6MZVCnTcs=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1703:b0:4c2:d7e8:cf67 with SMTP id
 5614622812f47-4d72c73d035mr8014457b6e.24.1790434473688; Sat, 26 Sep 2026
 07:54:33 -0700 (PDT)
Date: Sat, 26 Sep 2026 07:54:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab7dca9.80e1c6cc.1e8e5f.0046.GAE@google.com>
Subject: [syzbot] [fuse?] WARNING in fuse_iomap_writeback_range
From: syzbot <syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com>
To: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f0100363d8c3 Merge tag 'xfs-fixes-7.3-rc5' of gitolite.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1774b805580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d4242cb1c54cdf7
dashboard link: https://syzkaller.appspot.com/bug?extid=e8200299b0556976e13c
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c3a75fc0731f/disk-f0100363.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0cc808123f1b/vmlinux-f0100363.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a0fc6abfffe3/bzImage-f0100363.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com

------------[ cut here ]------------
!ff
WARNING: fs/fuse/file.c:2043 at fuse_write_file_get fs/fuse/file.c:2043 [inline], CPU#0: syz.6.4727/24915
WARNING: fs/fuse/file.c:2043 at fuse_iomap_writeback_range+0x7c8/0x18f0 fs/fuse/file.c:2227, CPU#0: syz.6.4727/24915
Modules linked in:
CPU: 0 UID: 0 PID: 24915 Comm: syz.6.4727 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:fuse_write_file_get fs/fuse/file.c:2043 [inline]
RIP: 0010:fuse_iomap_writeback_range+0x7c8/0x18f0 fs/fuse/file.c:2227
Code: fe 48 83 3b 00 74 5b e8 16 00 6d fe 4c 8b 3c 24 e9 08 0b 00 00 e8 08 00 6d fe eb 5c e8 01 00 6d fe 4c 89 f7 e8 69 c2 8d 08 90 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 48 8b 4c 24 58 80 3c 01 00
RSP: 0018:ffffc9000738f2b8 EFLAGS: 00010286
RAX: 8000000000000000 RBX: ffff888057eb0d80 RCX: ffffffff9a9e9501
RDX: 0000000000000001 RSI: 0000000000000004 RDI: 00000000ffffffff
RBP: 0000000000001000 R08: ffff888057eb1363 R09: 1ffff1100afd626c
R10: dffffc0000000000 R11: ffffed100afd626d R12: ffff888057eb1208
R13: 0000000000001000 R14: ffff888057eb1360 R15: ffff888057eb1208
FS:  00007fc6e84ad6c0(0000) GS:ffff888124ccb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f22f05eb840 CR3: 000000007d23c000 CR4: 00000000003526f0
DR0: 0000000000000008 DR1: 0000000000000002 DR2: 0000000000000404
DR3: ffffffffefffff14 DR6: 00000000ffff0ff0 DR7: 0000000000000400
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
RIP: 0033:0x7fc6e759e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc6e84ad028 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fc6e7826090 RCX: 00007fc6e759e159
RDX: 0000000000000040 RSI: 000020000000c380 RDI: ffffffffffffff9c
RBP: 00007fc6e763506b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc6e7826128 R14: 00007fc6e7826090 R15: 00007fc6e794fa48
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
