Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E06B20E702
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 01:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779067715; cv=none; b=P14OgSEabez89vbc+F+yxTgpMOIL7ZDYl/6//wLZduMToGo/xHrkiuHcTv0gThOcGD+KFDGo8n2QD7aPMc31orffA3hiZgQbDY8AyYnv2kojCorVdrpTPwa+twfm1YqXCP+pC3I4HEUWj95JWZC76MQ4L7jGsTfDkKqcnbBdv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779067715; c=relaxed/simple;
	bh=OJPuwcTgG0qAlldJeYbBllV1dKuQNHf7HRiNCFCOTkY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=b9+Qb62lC/SfeOk0Ncth8+F9SfadnLZrgLZaV3bNJgjtvSCuwTAvfm0g7f5S1cGOvnnalfpoxmnRmGlSwQpngdaWWJ/qrqu8ac/T2HTWNrvT7rnefpXDCmZ7RipLcGC7rwOJHpNkzxbVTJcvSf6YzLBghq1RgFErQDvXfl7HiLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-696133ef271so3837342eaf.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 18:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779067713; x=1779672513;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hZ26CcwKUUZ84CsaR3cg2pmuvgRNhJILqLKOjL1O+s=;
        b=r22eLJkC6SVcrB3y5AzN0l2unGoTkLb3Mbwr9Odwlvo739OH2BblSkfE1QKXip2YGv
         ShCTBXH9RqCRpLRZVh94ePzmv31C2iJI8r2myDLpgXoAdwE7WBefaY/YKil+1LfFAFKK
         I3M3DG/VaVGx6RHfJIlEv/WswUj7nC9gEgxvyu6VXV72yszG4lTsWEKurtcoSjBtEsGV
         +aT/7VYzf3YGuj3VnIMLn++DtBCHXqsQhFORq3vnslT81kvtrC0pUYtalw4jZVWtCEHD
         bonYjePCiMvHce7N4iPHBxEWcfMwi/vfayyhZKXfopyQR0xARAFHLxr+SWGUfauK8U5L
         PTCg==
X-Forwarded-Encrypted: i=1; AFNElJ+KYBLpb7hv+d400VRgAgKbfZ8LDOZLHTzQ8BcB89r5xCWLj5Ukbu2+bLltFl1P5EM6lbf4xicGj7NVXXPt@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Sc7tH78N4O5/Ap9kWKReoY0Givg9hxcXDl7aedMP66yfeXV0
	uiYvOUeP0ck6r/k6z676xR8q9Kh66dbzRt6OKWCpi5UicLjfuVXeNfNckWiM9mJxK6sZYU4eyGx
	nstJ1NSKZJCDFWL9saJBZ4d0b4/1VO7QIRe+Y0JDa8FuFaP+RnJNSnPyEif4=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:221e:b0:694:8428:dfd8 with SMTP id
 006d021491bc7-69c9436b0c7mr7811374eaf.34.1779067713392; Sun, 17 May 2026
 18:28:33 -0700 (PDT)
Date: Sun, 17 May 2026 18:28:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0a6b41.170a0220.1ad1c0.0018.GAE@google.com>
Subject: [syzbot] [hfs?] WARNING in hfs_put_super
From: syzbot <syzbot+bd88150de9bd90c582c9@syzkaller.appspotmail.com>
To: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	slava@dubeyko.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e1914add2799 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100d20c8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4caf64b1ee83dac0
dashboard link: https://syzkaller.appspot.com/bug?extid=bd88150de9bd90c582c9
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/42f74029c2c3/disk-e1914add.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecb718a7baa5/vmlinux-e1914add.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7727a995a7ce/bzImage-e1914add.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bd88150de9bd90c582c9@syzkaller.appspotmail.com

------------[ cut here ]------------
!buffer_uptodate(bh)
WARNING: fs/buffer.c:1087 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:1087, CPU#1: syz-executor/17308
Modules linked in:
CPU: 1 UID: 0 PID: 17308 Comm: syz-executor Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:1087
Code: 4c 89 f7 e8 b9 5c da ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 b4 63 fb ff e8 ff 1e 6f ff eb 8c e8 f8 1e 6f ff 90 <0f> 0b 90 e9 a5 fd ff ff e8 ea 1e 6f ff 90 0f 0b 90 e9 cf fd ff ff
RSP: 0018:ffffc900056d7b48 EFLAGS: 00010293
RAX: ffffffff8256a2d8 RBX: ffff88807795ebc8 RCX: ffff88802633bd80
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 1ffff1100b807c01 R08: ffff88807795ebcf R09: 1ffff1100ef2bd79
R10: dffffc0000000000 R11: ffffed100ef2bd7a R12: 0000000000000000
R13: dffffc0000000000 R14: ffffffff82b1d2b0 R15: ffff88805c03e768
FS:  0000000000000000(0000) GS:ffff88812538d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7130976286 CR3: 000000009e053000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 hfs_put_super+0x49/0x60 fs/hfs/super.c:52
 generic_shutdown_super+0x13d/0x2d0 fs/super.c:646
 kill_block_super+0x44/0x90 fs/super.c:1725
 hfs_kill_super+0x41/0x50 fs/hfs/super.c:441
 deactivate_locked_super+0xbc/0x130 fs/super.c:476
 cleanup_mnt+0x437/0x4d0 fs/namespace.c:1312
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0x70f/0x22c0 kernel/exit.c:975
 do_group_exit+0x21b/0x2d0 kernel/exit.c:1118
 __do_sys_exit_group kernel/exit.c:1129 [inline]
 __se_sys_exit_group kernel/exit.c:1127 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1127
 x64_sys_call+0x221a/0x2240 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f62bb79ce59
Code: Unable to access opcode bytes at 0x7f62bb79ce2f.
RSP: 002b:00007fff29fe0d28 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f62bb83222a RCX: 00007f62bb79ce59
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000001
RBP: 0000000000000002 R08: 0000000000000000 R09: 00007f62bb8321ca
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff29fe1fe0
R13: 00007f62bb8321ca R14: 0000555575c494e8 R15: 00007fff29fe30b0
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
