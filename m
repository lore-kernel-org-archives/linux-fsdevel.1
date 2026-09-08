Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69703859C3
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851307; cv=none; b=ajY+20xIuuzSq3NP13vCsftSJQHq0wxp7vSygrOliHk6v/rYisBXT1tawPN1dIfNuCdlxKeTw70YXYeiVeN1f95D0mvW+SKqadITcmTwO3k9oNJXlPAuJAm0HTzixy653/7qaPHRvZSUNI2KLnSv8J2Ts+SpSMK/QObsDbdMxd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851307; c=relaxed/simple;
	bh=VjjRAi7oBGcBtLljLBiLc+MTVU7w3NBnfN+wIzcEqfo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fWB9nNd/g4UeWU92sDBzBTJlek5ANAOrCmCwM209RtLgUqpza+5+3FOwicgamSSTZiG52KIgpCx9Byyi8SHIa/OQbEZR8yeMCwJ7d3O9TE5E1czaxG9axUQowFp9tyJSl+Io15saZ/7x8Uc3avTgFyqR9kdFmDAw7QRVrWo8wKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-448a12ddfb4so2015634fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 00:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788851305; x=1789456105;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SRv6I7fY9tO4zDn70XoEsC2tkr/GJjwF3CkkS/r/sac=;
        b=VJ8pTTkke81b+fe0c7RMshpHudGQgEdNjKTbaxFUqVRd6+x+qPtwhwHDCZMQ+EyeVt
         nlY1DRT+HFpECXZpdS+uK8gCCWWs3sVmvbZSF1/7h9YVPWVkg62fMSYI55zKW8qsgSKz
         D1DOYvcWo+Pm0lPQenxvdalD53QsUaOzb1N71ZGLB7SAk/6E5DQrxbodSfSqDj+45lJr
         YmV/Yxv9LZg9TOG1UX+oJzhM4OT7sP3xkDSZyQTje758c1tOtJutkwvinKCGVzgJXJof
         irvUYR1w0IHyf13ufS+x4IgbPtprRZXSczf9QyvjX8krOrteq2Siel10MkMtiMDWxHJ2
         vvlw==
X-Forwarded-Encrypted: i=1; AKwUvBzS5J+/ig/egL3DWO1V8pRu6tonvYAU+92Fk/iHTO8gXisD/JYylfVKuBVJ8f2xGLzyg0LrO3U3kLg2P9zu@vger.kernel.org
X-Gm-Message-State: AFuF++kEtngb7ite4mzhJfXaYHkTBleASiWI+kMvdY/xY5CRjlaC19aY
	ULoFiGAx96qZ2lT0MGqW+Ae4CYSEE9Spse1jatjYK7K5ZLHIZfLNr+yuMlrpapg/SaLwEjaUuWZ
	L8XJ2nG9Pk+Rc7r7hhOtUfANdsmsahP7E3/crw4GpceibfTb3jmzWOYDTYZA=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e909:0:b0:6b1:9f9d:7a00 with SMTP id
 006d021491bc7-6b6fbdc70efmr27895020eaf.5.1788851304811; Tue, 08 Sep 2026
 00:08:24 -0700 (PDT)
Date: Tue, 08 Sep 2026 00:08:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9fb468.6e6c5f9e.28f11f.000a.GAE@google.com>
Subject: [syzbot] [fs?] general protection fault in configfs_depend_item_unlocked
From: syzbot <syzbot+a9efa71b884a23e74153@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1fc5a74b108f Merge tag 'kmalloc_obj-v7.3-rc2' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17299b49580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=a9efa71b884a23e74153
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/90e25e7ccbef/disk-1fc5a74b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4e7b78b56aee/vmlinux-1fc5a74b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c2f010471672/bzImage-1fc5a74b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a9efa71b884a23e74153@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000c: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
CPU: 1 UID: 0 PID: 6141 Comm: syz.3.68 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:configfs_depend_item_unlocked+0x96/0x420 fs/configfs/dir.c:1246
Code: df e8 1e 88 00 00 89 c5 31 ff 89 c6 e8 13 58 56 ff 85 ed 74 0a e8 fa 52 56 ff 4d 89 fd eb 6c 48 8d 7b 60 48 89 f8 48 c1 e8 03 <42> 80 3c 30 00 74 05 e8 ee 0f c2 ff 4c 8b 6b 60 48 89 df e8 e2 87
RSP: 0018:ffffc90005477ad8 EFLAGS: 00010206
RAX: 000000000000000c RBX: 0000000000000000 RCX: ffff888026a51f40
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000060
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1f63c30 R12: ffffffff8ecb12e0
R13: 1ffff92000a8ef6c R14: dffffc0000000000 R15: ffff888061ee3c00
FS:  00007ff7e9de66c0(0000) GS:ffff888125cd4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000016c0 CR3: 000000005eb6a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 usbg_make_tpg+0x1e0/0x550 drivers/usb/gadget/function/f_tcm.c:1692
 target_fabric_make_tpg+0xa8/0x6d0 drivers/target/target_core_fabric_configfs.c:947
 configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1360
 vfs_mkdir+0x408/0x620 fs/namei.c:5410
 filename_mkdirat+0x289/0x520 fs/namei.c:5443
 __do_sys_mkdir fs/namei.c:5470 [inline]
 __se_sys_mkdir+0x34/0x150 fs/namei.c:5467
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff7ebb8e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff7e9de6028 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007ff7ebe15fa0 RCX: 00007ff7ebb8e159
RDX: 0000000000000000 RSI: 00000000000001ff RDI: 0000200000000600
RBP: 00007ff7ebc25024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff7ebe16038 R14: 00007ff7ebe15fa0 R15: 00007ffc34b91458
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:configfs_depend_item_unlocked+0x96/0x420 fs/configfs/dir.c:1246
Code: df e8 1e 88 00 00 89 c5 31 ff 89 c6 e8 13 58 56 ff 85 ed 74 0a e8 fa 52 56 ff 4d 89 fd eb 6c 48 8d 7b 60 48 89 f8 48 c1 e8 03 <42> 80 3c 30 00 74 05 e8 ee 0f c2 ff 4c 8b 6b 60 48 89 df e8 e2 87
RSP: 0018:ffffc90005477ad8 EFLAGS: 00010206
RAX: 000000000000000c RBX: 0000000000000000 RCX: ffff888026a51f40
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000060
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1f63c30 R12: ffffffff8ecb12e0
R13: 1ffff92000a8ef6c R14: dffffc0000000000 R15: ffff888061ee3c00
FS:  00007ff7e9de66c0(0000) GS:ffff888125cd4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005650aabe2588 CR3: 000000005eb6a000 CR4: 00000000003526f0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	e8 1e 88 00 00       	call   0x8823
   5:	89 c5                	mov    %eax,%ebp
   7:	31 ff                	xor    %edi,%edi
   9:	89 c6                	mov    %eax,%esi
   b:	e8 13 58 56 ff       	call   0xff565823
  10:	85 ed                	test   %ebp,%ebp
  12:	74 0a                	je     0x1e
  14:	e8 fa 52 56 ff       	call   0xff565313
  19:	4d 89 fd             	mov    %r15,%r13
  1c:	eb 6c                	jmp    0x8a
  1e:	48 8d 7b 60          	lea    0x60(%rbx),%rdi
  22:	48 89 f8             	mov    %rdi,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2e:	74 05                	je     0x35
  30:	e8 ee 0f c2 ff       	call   0xffc21023
  35:	4c 8b 6b 60          	mov    0x60(%rbx),%r13
  39:	48 89 df             	mov    %rbx,%rdi
  3c:	e8                   	.byte 0xe8
  3d:	e2 87                	loop   0xffffffc6


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
