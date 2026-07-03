Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74A817C203
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 00:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783040369; cv=none; b=gjowQa8dcsMoPZKCHSbyFfnsz/TxCsAtyaASw0JR2sJ5BfnVj124PJmgTr/K+tt7wigeZG/enlB9Kw+c7TeduKpAXAsW3Vd8Qy+pW0mo+VFPPQ+GXo4Owv640U3mdM94j/ZBmMP0tiAIYiLQ7QQYODK9KM+b2iYton3PEMJzo1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783040369; c=relaxed/simple;
	bh=o4RYHInGgXGh6dvOC7ZwK3AhvRtpsXn8fwtOJ4yqTeo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GZQj7j1+QM1f65Hwrvoqjo7Bdk8Vp+rxKSx1DAJtd9d94JvtcMZ2E2CXlKDkCos8AB/YtIPZE2cy8pNDxuvkHRXSctgozW2alm7+hgOeKECRd6sP0n9fIPEzWPD1mqhv7WQFd9qdEKr+HkHb4D6dNJiR6lA5cn/mPJDS4oAiSMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-497da470d3aso3235b6e.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 17:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783040367; x=1783645167;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dcfKlMRqKsuU6sd6tH3oRNAVXTaxMiP1Kfwe4kGN8Fk=;
        b=RyPW0xGwXBgmzpcaVyR2dJErt+pjZJk5/P7msfgP6IT6n5pPO2Rs0yfZIRRIbDbRtZ
         bxAAefw9mmnTfAHYVwkyFEnhAGr/VpCLTcz+BhJGGjv1OjdFq6mvlBilu1dTvJR83gw1
         k2Fm4QGFLLNJUWLdii4yFtGjRRZDDrkpl1UO4jm8uZXwTOwqeTCsW0ENVzsZMnnD91C6
         mgtmUjrHs/d17qjXDOv+J0EibfdLVg66hC82V07c/tWtjUIMO/wHW8ewm0UOmu0u4x60
         07LTmAUXIfSFGJHT66DFj8jG2O+fBGYYG/U5YHyNHCfti8P60EJuLyLWh5+FRBNnpMSm
         rcjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Zb1pCSoDavROPFJeu0uTA+P2zz8yNZZRXVEjr9ShSMCtbJSgjYrmD01pOE9xcq6ler0PDFB4/qSX9Btlu@vger.kernel.org
X-Gm-Message-State: AOJu0Yztm14r+8Fe4vH6d0t5votfPYiBzOhXPEatmKsspCj0iIkwTfP+
	0FXOXvcLfyJmKLEFAEUvpGzfBImDDthy/ZN3AZ2nQ4h5Tiw/qcROYXCEnW0o5Xl/d9xVtcI+bDF
	xJ4tRiysAvMFiNKThdsgo+WTL2M0zOfoSr62APVj1jWZatPuTc8z9eTEHF6o=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1810:b0:495:d0dd:c6d4 with SMTP id
 5614622812f47-4962d7b5a37mr5357866b6e.13.1783040366964; Thu, 02 Jul 2026
 17:59:26 -0700 (PDT)
Date: Thu, 02 Jul 2026 17:59:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a47096e.9dc7bc9d.3d5df4.0005.GAE@google.com>
Subject: [syzbot] [fuse?] WARNING in super_dev_register
From: syzbot <syzbot+72fe3ea5814121fbc76e@syzkaller.appspotmail.com>
To: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6eb8711ece2c Add linux-next specific files for 20260702
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=144d2c0a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc069df559a09463
dashboard link: https://syzkaller.appspot.com/bug?extid=72fe3ea5814121fbc76e
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e32a6e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ebaf41580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ec0095ca90c5/disk-6eb8711e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e30096d3498c/vmlinux-6eb8711e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9855bbfe6176/bzImage-6eb8711e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72fe3ea5814121fbc76e@syzkaller.appspotmail.com

         and is ignored by this kernel. Remove the mand
         option from the mount to silence this warning.
=======================================================
------------[ cut here ]------------
!sb->s_dev
WARNING: fs/super.c:509 at super_dev_register+0xf8/0x250 fs/super.c:509, CPU#1: syz.0.17/5906
Modules linked in:
CPU: 1 UID: 0 PID: 5906 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/09/2026
RIP: 0010:super_dev_register+0xf8/0x250 fs/super.c:509
Code: 04 38 84 c0 0f 85 34 01 00 00 8b 2b 31 ff 89 ee e8 9d 2a 85 ff 85 ed 0f 85 98 00 00 00 e8 e0 25 85 ff eb 17 e8 d9 25 85 ff 90 <0f> 0b 90 48 85 db 75 c4 e8 cb 25 85 ff 90 0f 0b 90 43 0f b6 04 3c
RSP: 0018:ffffc90003f3f9d0 EFLAGS: 00010293
RAX: ffffffff82401307 RBX: ffff888032be2000 RCX: ffff88802d478000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff82401d10 R12: 1ffff11007997402
R13: dffffc0000000000 R14: ffff88803ccba010 R15: dffffc0000000000
FS:  0000555563c9e500(0000) GS:ffff888125b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000003000 CR3: 00000000505ae000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 sget_fc+0x12f6/0x1a60 fs/super.c:896
 sget_dev fs/super.c:1480 [inline]
 get_tree_bdev_flags+0x212/0x4f0 fs/super.c:1867
 fuse_get_tree+0x194/0x3b0 fs/fuse/inode.c:1877
 vfs_get_tree+0x92/0x2a0 fs/super.c:1941
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3777 [inline]
 do_new_mount+0x319/0xdc0 fs/namespace.c:3853
 do_mount fs/namespace.c:4186 [inline]
 __do_sys_mount fs/namespace.c:4402 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4379
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2ea523de59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffebb4997a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f2ea54c5fa0 RCX: 00007f2ea523de59
RDX: 0000200000000080 RSI: 00002000000000c0 RDI: 00002000000001c0
RBP: 00007f2ea52d3e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000040 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2ea54c5fac R14: 00007f2ea54c5fa0 R15: 00007f2ea54c5fa0
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
