Received: from mail-oa2-f8.google.com (mail-oa2-f8.google.com [74.125.231.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D542A45D92E
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 16:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789403907; cv=none; b=s5JUypLWrrxxyZr9qra+wtnolvagmsdfRvCmVjb5U/QuDFvOL0PuzpVIGddIPgC3PM/gdP3ZajJhaaV54/N7xUgD1Kgza6Ce3KHLjDNlQ1WMTyjY85o3FrTBgbuOPKQ12o1PNEs4+Tq/GwAzVdPEpwwBTS5dapMuf5tWaUuaYGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789403907; c=relaxed/simple;
	bh=xn7LQ0PXlxIeeF8zzyZvPpHydODrJ+C406gP7HxEXJk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aDErsubvwoJXAxYJXv3LtIOOeOSmn9aA5pYXyv8lw7CY9QILVP4VeEtJA/T0Xm+NawS3zrCykJr9KehhzXmQVl4GrtWBWhFwH0yKdYuRXwysN84BMEbceOfLVZhiza+4ZYucKZY4ROKfTw3uTIxOt2+1yr63qU+2nTVXSZ/+fkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f8.google.com with SMTP id 586e51a60fabf-46683b030d9so1095032fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2026 09:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789403905; x=1790008705;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LAzyC7Lu5MFRo20mDnBb8gws1b+bAcif7S6636vTpgE=;
        b=zrS8ZfQZ91FyJf9IGesCtpygUuYEob8/xLhG4QwdCsA2kWB4f2Jg8Z786VmM3eEmZB
         Vnntqtw5b9HUv5FfKo1EMbyuiNfTtsMaSJSYCJJKQOrzsRD6STiEb7CGInGu3pmPYxKa
         3Pv8d5oloaUXKjrACdrbUHhFvzQxwdVftmbBk9vGCWtDlOuAOXkqtjl2hyoMlncz8sye
         kFvaNp/ALXdkP+lDe2DzhvNiGX7f2jgj+fG3xvx28mywbAUCgRNZJ2xpji6qwsXcTiFv
         Ln+bIxkcMJ29PtklvNphNGwgBnV22Mm6DircuCYK3QN/H9UeOkMTGlQaY6h2Kfgc8mLt
         NeNw==
X-Forwarded-Encrypted: i=1; AKwUvBz5vItMDA8xpzRj3hMBXVbEad5RJyLoup/M0RNd2cr7b+TeGMXlRhb45M6vmqIexPwkjiMsxbJipJmqo7kc@vger.kernel.org
X-Gm-Message-State: AFuF++mQ7SwFRyxU/0Kbtac4sTfW9CbF/VrK7rNkFMMDDnJ/oLer5NNl
	wb2ofpSRoJmPJJOl65NHrgWx6m8vRjRFAAxKtVhd43XiPmdgFGmdGFYnZUhwYgjfDAqYaCHDT0u
	/1wl3H0k0xJwYPoGHc7FHZ8zQLbggFgzL3D/EALa/TISMZi0A4J8r/WUqwPQ=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:616:b0:6c2:b9f8:b1f0 with SMTP id
 006d021491bc7-6c53f44bc24mr2045585eaf.7.1789403904771; Mon, 14 Sep 2026
 09:38:24 -0700 (PDT)
Date: Mon, 14 Sep 2026 09:38:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa82300.a211d2ce.1a5198.0295.GAE@google.com>
Subject: [syzbot] [exfat?] WARNING in vfat_update_dotdot_de
From: syzbot <syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5225b8eec4c9 mailmap: update entry for Jens Axboe
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11cd61f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5e4e3a0e188a497e
dashboard link: https://syzkaller.appspot.com/bug?extid=b0aebd03565f5774f7f8
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b455f9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a1b615580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fdabe739a017/disk-5225b8ee.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ef60d7040756/vmlinux-5225b8ee.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ccb7b942e430/bzImage-5225b8ee.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/be5074fab5f0/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=16cd61f9580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0aebd03565f5774f7f8@syzkaller.appspotmail.com

loop0: rw=8912896, sector=102, nr_sectors = 1 limit=63
syz.0.17: attempt to access beyond end of device
loop0: rw=8912896, sector=103, nr_sectors = 1 limit=63
syz.0.17: attempt to access beyond end of device
loop0: rw=8390657, sector=98, nr_sectors = 1 limit=63
Buffer I/O error on dev loop0, logical block 98, lost sync page write
------------[ cut here ]------------
!buffer_uptodate(bh)
WARNING: fs/buffer.c:991 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:991, CPU#0: syz.0.17/6146
Modules linked in:
CPU: 0 UID: 0 PID: 6146 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:991
Code: 4c 89 f7 e8 a9 01 d8 ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 74 52 fb ff e8 ef 00 68 ff eb 8c e8 e8 00 68 ff 90 <0f> 0b 90 e9 a5 fd ff ff e8 da 00 68 ff 90 0f 0b 90 e9 cf fd ff ff
RSP: 0018:ffffc90003b57858 EFLAGS: 00010293
RAX: ffffffff825fc9c8 RBX: ffff888076b98460 RCX: ffff888020348000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: dffffc0000000001 R08: ffff888076b98467 R09: 1ffff1100ed7308c
R10: dffffc0000000000 R11: ffffed100ed7308d R12: ffff88806768a434
R13: 0000000000000000 R14: ffff8880544440b0 R15: ffff88807688ba08
FS:  00007fa0804ca6c0(0000) GS:ffff888124cd2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdc870d998 CR3: 0000000035986000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 mmb_mark_buffer_dirty+0x2c/0x1f0 fs/buffer.c:624
 vfat_update_dotdot_de+0x90/0x1c0 fs/fat/namei_vfat.c:917
 vfat_rename_exchange fs/fat/namei_vfat.c:1140 [inline]
 vfat_rename2+0xe3e/0x1c90 fs/fat/namei_vfat.c:1171
 vfs_rename+0xbd9/0xef0 fs/namei.c:6208
 filename_renameat2+0x533/0x9a0 fs/namei.c:6326
 __do_sys_renameat2 fs/namei.c:6355 [inline]
 __se_sys_renameat2+0x5a/0x2c0 fs/namei.c:6350
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa07f59e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa0804ca028 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
RAX: ffffffffffffffda RBX: 00007fa07f826090 RCX: 00007fa07f59e159
RDX: ffffffffffffff9c RSI: 0000200000000480 RDI: ffffffffffffff9c
RBP: 00007fa07f63503b R08: 0000000000000002 R09: 0000000000000000
R10: 00002000000004c0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa07f826128 R14: 00007fa07f826090 R15: 00007ffc6d0e6af8
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
