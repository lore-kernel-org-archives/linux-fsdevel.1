Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91618AE2
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 03:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778729856; cv=none; b=VuJONaOIh65l9K8ZRSNIfCG07Ms0wjmPS40A6x6RFRD5tnk3igHdJDpuuqo49Y30PqwpwlDTEkP5Oo6AskHynaQzAgWNoTlUiIclQr/9o3c4KyJxB+Aa5z7I8wYN8UtrYrpEglyzPnES4/RCn+wEd+Homi1LLdACKsolXp0ozq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778729856; c=relaxed/simple;
	bh=U0QGXp0FIA67QQAMYmJNyj+LHF/TUjXMmcTUzkjimDU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lGb/HChttlLqxFl3EDmFW/YRkREYJAbrGqXgKs/Hwkeu2eCeOZwaLQZ0RxvMI2sUVkrc/AWgLL6AXt8/ibm8t4Uof99+kxmXolnD6PTdH/+mJ6neoyaG4rBrQbtd7lKRJWw8tmemU8tibP5FFXKzz+QwhkF8EFdGjBRfmnWS8iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7de44ba64e7so12131886a34.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 20:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778729853; x=1779334653;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pmwnxv7ny0LhusPUpjLEt5A9LrNyCQxseJB0LXTCdUU=;
        b=EL+QfFPyraNfwj1Cury0uhhzfkmj8xsYNwJNsYhvOs7DLt+yIfbzgWA4D9wcIdVekE
         kAgersHN21tIOnuXM9Wb4LZZ1bvGE2MqHXU7/55Dmw+hXnMoiBpf5PuGutDsCO8NLrnw
         3srV2UFpMbuNi5K9u5Y4zEEXR32J4DLhxIrx70XUjnWFe+CcW5ou+36JXN63OsIrSbKY
         fS10qzCXTa45LfDkqV/47ecLNZsI6l+sXt61Txs6Dm8AhG1teYpT1LnJkA5uYxN1yrcL
         fHG2Gdi8YcBJbbTGyPr60/fllSf38SZqxEQIJv/yyjMnLpI4AYtVo8a4USQs/g5xjG2F
         AEtQ==
X-Forwarded-Encrypted: i=1; AFNElJ9GijbqIzxFRIcDxFkngcAEjmtKd4fsqZdKBRCpe5KnjbqWtKj41g0QoA/mep0ITX6J7wtdNT+n+Khlslks@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyf4nb//7yc3Dmaox9ncydS60xFE4NaTpC16R/dsceHPmEWo4U
	j0fplcoImPEbx6/0urrLkxRSR8wgFeXOYf4ivmV9c1BVXpVhXrF2MSo9y7yo2mHFRtVPylYpU9n
	MwAJkE9GqRqogrg/Ku4r5DbzsvRYLACuAdIp1KjLjyEdGe2y4UwvhIN8H3Gc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2d09:b0:696:717c:bd75 with SMTP id
 006d021491bc7-69b78e5f1c2mr3563944eaf.54.1778729853534; Wed, 13 May 2026
 20:37:33 -0700 (PDT)
Date: Wed, 13 May 2026 20:37:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a05437d.170a0220.196691.0003.GAE@google.com>
Subject: [syzbot] [hfs?] WARNING in hfs_mdb_commit
From: syzbot <syzbot+c149ad75e9633be0c1ad@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1bfaee9d3351 Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f08726580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7f195f6be48c12ec
dashboard link: https://syzkaller.appspot.com/bug?extid=c149ad75e9633be0c1ad
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-1bfaee9d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/879fc4fe312e/vmlinux-1bfaee9d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9e35bd667fed/bzImage-1bfaee9d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c149ad75e9633be0c1ad@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 64
loop0: detected capacity change from 64 to 0
Buffer I/O error on dev loop0, logical block 62, lost sync page write
hfs: unable to read volume bitmap
------------[ cut here ]------------
!buffer_uptodate(bh)
WARNING: fs/buffer.c:1087 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:1087, CPU#0: syz.0.0/5321
Modules linked in:
CPU: 0 UID: 0 PID: 5321 Comm: syz.0.0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:1087
Code: 4c 89 f7 e8 b9 5c da ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 b4 63 fb ff e8 3f 91 6d ff eb 8c e8 38 91 6d ff 90 <0f> 0b 90 e9 a5 fd ff ff e8 2a 91 6d ff 90 0f 0b 90 e9 cf fd ff ff
RSP: 0018:ffffc9000ddafba8 EFLAGS: 00010283
RAX: ffffffff82584008 RBX: ffff888046e26658 RCX: 0000000000100000
RDX: ffffc9000eefa000 RSI: 0000000000001912 RDI: 0000000000001913
RBP: 1ffff11007a3ec01 R08: ffff888046e2665f R09: 1ffff11008dc4ccb
R10: dffffc0000000000 R11: ffffed1008dc4ccc R12: dffffc0000000000
R13: ffff88803d1f6628 R14: ffff888055813c0b R15: ffff888055831492
FS:  00007f2c9e9b96c0(0000) GS:ffff88808c881000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000210 CR3: 00000000133b8000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 hfs_mdb_commit+0x84b/0x1150 fs/hfs/mdb.c:328
 hfs_sync_fs+0x1d/0x30 fs/hfs/super.c:38
 sync_filesystem+0x1cf/0x230 fs/sync.c:66
 hfs_reconfigure+0x66/0x270 fs/hfs/super.c:122
 reconfigure_super+0x227/0x8a0 fs/super.c:1080
 do_remount fs/namespace.c:3400 [inline]
 path_mount+0xdc5/0x10e0 fs/namespace.c:4146
 do_mount fs/namespace.c:4167 [inline]
 __do_sys_mount fs/namespace.c:4383 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4360
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2c9db9cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2c9e9b8fe8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f2c9de15fa0 RCX: 00007f2c9db9cdd9
RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000000000000000
RBP: 00007f2c9dc32d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000c22 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2c9de16038 R14: 00007f2c9de15fa0 R15: 00007fffa4666ff8
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
