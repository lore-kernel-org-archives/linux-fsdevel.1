Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663284;
	b=uUPaQGXNl8DNPDQmqV8LaXj1kcKupy9Ld8u9DxZBwLrxZw7TTcguTt+TFTfPW/nyVY0v
	 DiVCCwJnoYo/bO1smtcN59Y1ax1IEHa5Nlgjp/9dj/4rSa6UbWoHiZzMdWtho3uxIlGzo
	 UhVn9YmQxKrt9Hh03cTNJ7qgm396IOykbbXSz3jrQDVq5JhoobIbo82fI8E43mcSF2LKc
	 aNcbhpQe/33UXAzTSGSd3UUAReE6iozEDYCEXr1rgbRezNoM7Gz38kALLmdeQRrjbtHIR
	 baIDTsiCqsn7BA2sT5O/u6oALNqAWexd98VULTi0K+KQYEbqGPLUgJKsREdfV3T0otQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663284;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=BWI3Lrcifhq07nHl0S5uej8tCbV/Fgv3NaO9h++jNTo=;
	b=tYkV3hxydHZ2CFVYaWzyhp1++T75qX40D7t5gYuotHLuwqOJwlUQrK3nkzXYiOEEwCtE
	 efxM8S0e8D1rAkBcz1pYVnygZO/sIdkR1iyNbZp0l7aDUZh+bqJsZ38fwo6BfS62JBwfc
	 0G8Hy9aVOF6qesgWiF71bdKQFYT1ggtb7tlC1FYWFoKjpQAI8AmsiIT/2Ut1sfMK4HVP9
	 oPgTKMATiKceUnBOaKJif4gGwWViy1G/a8t/2feP+dyw8rgI0iY/vEIBglCLatvn3O9FV
	 hTATYlvl/njgeQOlQAUSZ2Le5HHgapohchIEX+Uf4ODYC3GV6qdhOdo/G7RlijDLrrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78814606A31D
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 10:01:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78814606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-5587351d419so398710b6e.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 03:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792663283; x=1793268083;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BWI3Lrcifhq07nHl0S5uej8tCbV/Fgv3NaO9h++jNTo=;
        b=o1Nk7zZaDoGMOXaGGTADlnypwORtq0j/GS75ErtITvkg/g4NGgadqk5gUj1OH1W7rV
         ThThUtFiWbnyKwnxVvLwlo5vy2krgzMlkg1y+30pv3mjOGGXvOmoI45hc7tlwu0xzpfM
         BSCAz2Z4TGZYPFO+W5bP0S1hmu1wdtdQC40fA1RcO85bcnGC3rLmgGa/MBvO5/bAOx+K
         m3F/2TMnucSgVYGXH0qzxlZRYq9bJ3Xr+JZNIDiv6Q+ODQxSYZ/Wdgqtzf1/0xDDzMuk
         UVpvR00QUKohJczNgBkl3f/woLpU1m0p9FC44CCdIiooL/jyD4JQ2Dj5nuzCHOjRaCWH
         vocQ==
X-Forwarded-Encrypted: i=1; AKwUvBwEas3JC3Jq80XinB3pun0XR12EDw0N6w7alpJ75dNpBbsyEbj2cFAOYmDZRYRuaARfUbY413DvUEp/AZbb@vger.kernel.org
X-Gm-Message-State: AFq9FYKwGsGZCpqV2bpy7oOt/2H/Bf6nZ2IIEcjfrWQ1CP3KgP+E2NTb
	o4/g4Hi5lo0Jvf+v62k7iPC27AQTnNsTcG4CWbNhyLTzUJx1zdIeqIR+P869rA810fj+qbkvu3B
	ipQYexNSVZbYVpILE/2Usi8ilBgkEHru6OcuJmE17eVKfJxRBd0a7grkH64s=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:152a:b0:4a4:744:a4ff with SMTP id
 5614622812f47-5534f045a74mr2683712b6e.4.1792663283371; Thu, 22 Oct 2026
 03:01:23 -0700 (PDT)
Date: Thu, 22 Oct 2026 03:01:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad9def3.3ebfcf67.79b0c.0095.GAE@google.com>
Subject: [syzbot] [fs?] [mm?] KCSAN: data-race in xas_create / xas_find (10)
From: syzbot <syzbot+73641b60a3bc11dfca8c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    a804c5742bff Merge tag 'lsm-pr-20261016' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10762231580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0a09745349d136e
dashboard link: https://syzkaller.appspot.com/bug?extid=73641b60a3bc11dfca8c
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/171f09113e28/disk-a804c574.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f8812b149fb/vmlinux-a804c574.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6349a85938ab/bzImage-a804c574.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+73641b60a3bc11dfca8c@syzkaller.appspotmail.com

loop6: detected capacity change from 0 to 1024
EXT4-fs: Ignoring removed i_version option
EXT4-fs (loop6): Unsupported encryption level 6
==================================================================
BUG: KCSAN: data-race in xas_create / xas_find

write to 0xffff88811a8efda9 of 1 bytes by task 6715 on cpu 1:
 xas_expand lib/xarray.c:620 [inline]
 xas_create+0x685/0xbf0 lib/xarray.c:661
 xas_store+0x6f/0xce0 lib/xarray.c:795
 __filemap_add_folio+0x647/0x910 mm/filemap.c:915
 filemap_add_folio+0x1cd/0x380 mm/filemap.c:972
 page_cache_ra_unbounded+0x1a4/0x3a0 mm/readahead.c:293
 do_page_cache_ra mm/readahead.c:348 [inline]
 force_page_cache_ra+0x190/0x1d0 mm/readahead.c:378
 page_cache_sync_ra+0x11d/0x560 mm/readahead.c:602
 filemap_get_pages+0x2f2/0x1360 mm/filemap.c:2714
 filemap_read+0x21c/0xad0 mm/filemap.c:2824
 blkdev_read_iter+0x21e/0x2d0 block/fops.c:838
 new_sync_read fs/read_write.c:493 [inline]
 vfs_read+0x699/0x7c0 fs/read_write.c:574
 ksys_read+0xdc/0x1a0 fs/read_write.c:716
 __do_sys_read fs/read_write.c:725 [inline]
 __se_sys_read fs/read_write.c:723 [inline]
 __x64_sys_read+0x40/0x50 fs/read_write.c:723
 x64_sys_call+0x2135/0x2550 arch/x86/include/generated/asm/syscalls_64.h:1
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x112/0x360 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff88811a8efda9 of 1 bytes by task 6813 on cpu 0:
 xas_find+0x360/0x3e0 lib/xarray.c:1421
 find_get_entry mm/filemap.c:2085 [inline]
 find_lock_entries+0xd4/0x6b0 mm/filemap.c:2189
 mapping_try_invalidate+0xc7/0x430 mm/truncate.c:545
 invalidate_mapping_pages+0x27/0x40 mm/truncate.c:602
 invalidate_bdev+0x58/0x70 block/bdev.c:101
 __ext4_fill_super fs/ext4/super.c:5840 [inline]
 ext4_fill_super+0x2cd3/0x37c0 fs/ext4/super.c:5865
 get_tree_bdev_flags+0x291/0x300 fs/super.c:1883
 get_tree_bdev+0x1f/0x30 fs/super.c:1906
 ext4_get_tree+0x1c/0x30 fs/ext4/super.c:5897
 vfs_get_tree+0x57/0x1d0 fs/super.c:1943
 fc_mount fs/namespace.c:1282 [inline]
 do_new_mount_fc fs/namespace.c:3910 [inline]
 do_new_mount+0x288/0x730 fs/namespace.c:3986
 path_mount+0x4ad/0xb90 fs/namespace.c:4337
 do_mount fs/namespace.c:4350 [inline]
 __do_sys_mount fs/namespace.c:4565 [inline]
 __se_sys_mount+0x28c/0x2e0 fs/namespace.c:4542
 __x64_sys_mount+0x67/0x80 fs/namespace.c:4542
 x64_sys_call+0xc3b/0x2550 arch/x86/include/generated/asm/syscalls_64.h:166
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x112/0x360 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x03 -> 0x00

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 6813 Comm: syz.6.569 Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
==================================================================


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
