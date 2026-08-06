Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E686A3F0749
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786029935; cv=none; b=fvQtCD+TMGXu+5hvX2B89hw9bi7KOt9TpiXNVXYCsRAMvDBCe7FzJw82n/DrLQoIrZjt7S0qXp/OzOkSPjn81+tHIMzqfSZXhEHcrcBfu7FzP2/ZGx3++R0z4UvLsG/pHubYyEPC5BpyG9XUKOYyNyIUUjm9S59exF9It6IcCRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786029935; c=relaxed/simple;
	bh=FTexZWZFMIEQkErZju8gTFqXku+BI8Bd8pRsI5ns8yA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mp8PQmtkVZAWx+VRV7jQ3wKtI14uRASfUxwHvrOV+dFKOSDkv1poehfJtjWnJfxlLpqvpQhXQ/Y5EAXEPYFP2wNtpwhzx9bc43iHJrugZ2H+t0561qyhHiIQ1cbD0I/1RakjqUItJWxYn8Ed9jyriygHb55CaG/yFWztBlCuYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7ec54966bedso1104682a34.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Aug 2026 08:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786029933; x=1786634733;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8+N30TCHh1rR3/tcI+fD3V9ui3OzGXU7DEIqj8gKHYs=;
        b=VpZ6DJxJCzLkenFU/2qoGCx5qn2oBW+C0JxPsk3eXCHqhRmVigSQSoHRzen2Gv+Uy7
         LB67HDPEMVHJfTTh8KPY5bJxgxUZs/494pAJWkRayZTyH9OJRIQalNG3yAyVcgBHcSWL
         ZeN70FupTFxvzOTe2pbJGsigqxp2War9JUg/NrOLgB1eL2WScQXEvvC9jGw4RItzlzzf
         hOzGKMmxBjz8hQKNykKOY0HvodHte/4aA+tUQo/fdxWL1668uCCUiz+1kAUZCKL6RwG9
         WKbw52et+Nsm3pucGY4f4ydNSRt3q5GOO9VeVObTsEQvUKxkjsIBCgS+ZRpzwVgcWgqh
         0PGQ==
X-Gm-Message-State: AOJu0Ywj5xO2lh3C6H++zowLUa99p6L0wGn+24y4RfvKqiRB8Nr068nw
	uSLV3+ahciZBfEFp4M4Zq4r9aaE7WKFYoFSb8gZSJFjcFq1EpWg88b9Ap5g2jqzUXYSOqu36Q7S
	lJh10b2bAZRx4B/C7R3Kp/e+g6Hmp5v5qeXb4zM/fnc9xayLSi9LjwaRv7DgYPQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:290b:b0:6aa:e367:a3e2 with SMTP id
 006d021491bc7-6aeb24fa433mr4098321eaf.19.1786029932873; Thu, 06 Aug 2026
 08:25:32 -0700 (PDT)
Date: Thu, 06 Aug 2026 08:25:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a74a76c.ec7c9571.3ac9bb.0055.GAE@google.com>
Subject: [syzbot] [fs?] UBSAN: shift-out-of-bounds in ufs_fill_super
From: syzbot <syzbot+5585f47221c0de04168d@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    562bfb501c54 Merge tag 'integrity-v7.2-rc7' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174453b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c05be6c9b0d36cb9
dashboard link: https://syzkaller.appspot.com/bug?extid=5585f47221c0de04168d
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-562bfb50.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7580e6506574/vmlinux-562bfb50.xz
kernel image: https://storage.googleapis.com/syzbot-assets/883f7f234497/bzImage-562bfb50.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5585f47221c0de04168d@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 128
ufs: ufs_fill_super(): fs needs fsck
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/ufs/super.c:1177:18
shift exponent 4294967294 is too large for 32-bit type 'int'
CPU: 0 UID: 0 PID: 5327 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x36d/0x400 lib/ubsan.c:494
 ufs_fill_super+0x5f8d/0x67e0 fs/ufs/super.c:1177
 get_tree_bdev_flags+0x430/0x4f0 fs/super.c:1640
 vfs_get_tree+0x92/0x2a0 fs/super.c:1700
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3765 [inline]
 do_new_mount+0x319/0xdc0 fs/namespace.c:3841
 do_mount fs/namespace.c:4174 [inline]
 __do_sys_mount fs/namespace.c:4390 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4367
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6c6519e019
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6c66037fe8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f6c65425fa0 RCX: 00007f6c6519e019
RDX: 0000200000004000 RSI: 0000200000003000 RDI: 0000200000000040
RBP: 00007f6c6523500c R08: 0000200000005000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6c65426038 R14: 00007f6c65425fa0 R15: 00007ffd05bb6728
 </TASK>
---[ end trace ]---


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
