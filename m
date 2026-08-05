Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AC73EFFC5
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785969881; cv=none; b=EyWgc7+6oo7MiyoqONGT1ic9I0uflToR/Kwqt5FjgI/QvB3otHLwV1WpTr1VrOC/mbwI6B51c6CuMaGBsoZMZayopGA1Xy5NFR87sghU9frLP6n3ro5az8H3SlZSQ/WHl84z/m+6V9YGPcJRgB4zYNjIX5Aw6BDP7wVg7fNsJz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785969881; c=relaxed/simple;
	bh=BXq9eLgRbq3/mFHirZkafLkNLXLC42B72XKxX47VZtY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DEtptCrX7qhrfXDlvUsqN8iz7C/nA3WNz7pWNmNG8WbwxFiBlkVcAgMM6ChO3xs6O8Iy/jP+jwjt/+gVR6YW8ktUcsMdOY1bRH1OHYxrJmMpLDHLUxeVRAa3NP35byI3FEL3xIlawq5Tt3xw09vI23j3/f3ML84ps8avKL3yF9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7f1ddcd241aso2016081a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2026 15:44:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785969877; x=1786574677;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OTHiT311A/996Jd3jk5u3HWyM+X+VUF6IwJeUZUpP8k=;
        b=nU47RngSkyNco1oKSHA4CemKKrLVm6hETO4sI36K0pV7lgczaR3SPMgJB35GjwJRlt
         YJHHf9qbZX9fCmWG0UD6bZiby2gxdgiEjuu/loo9CFncgKyW0rZIXxY0AQZ28VeRC512
         NuvY6wJ3+0ePdlgEdF4zgh7uxwl2hyyTI1biYE8cioXdNo4F/SYo1JZvPhkVuIBbKV+5
         p0MVsiI1SWrhtUEdlhEgKAURrtK/tmt9WEGsmNJxz7Tf5Qvp2eVW/EOax40mH4kGYfyx
         0SbEY3fsWX3SERjaK87uCfDddmFK1nMlpyM9ZnttbHZim8COJrZvbXxfhE2GaFb2npr3
         gulg==
X-Forwarded-Encrypted: i=1; AHgh+RoaYGFXZW9enOMlOkbL9sunSd1BDOBbNT4+RuVwRRdP1ovOsWdphh9g9M4Iz036XsLoC40ntjy5cVDXdHO4@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/2Xzz4iu2EVDUiMpzcdaMJKaPMpWX7LaYDj+VNQKGk8btLasb
	0Utu0t+ctvxl6iQTUqejrpTyeoyx+s5SE3bDGEf0ERaNSkpqgKbZ+oDt1Cn5jHbQgghM6rGPgcW
	XgEeDGVYgws+aYI59ITnk+i90CW1v/juamnCK/dC890S3MV25a49udbh6gbM=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:e917:0:b0:6aa:e1f6:32dc with SMTP id
 006d021491bc7-6ae96e83488mr5641828eaf.22.1785969877572; Wed, 05 Aug 2026
 15:44:37 -0700 (PDT)
Date: Wed, 05 Aug 2026 15:44:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a73bcd5.01d0871a.3a0d52.0004.GAE@google.com>
Subject: [syzbot] [fs?] general protection fault in do_getname_kernel
From: syzbot <syzbot+2f6a3b7dc3b442ef515c@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    848acc8ffe1b Merge tag 'fsverity-for-linus' of git://git.k..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13154bb9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb17729fb04b1e3a
dashboard link: https://syzkaller.appspot.com/bug?extid=2f6a3b7dc3b442ef515c
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169bacc6580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1305fc9e580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/375d27e96ecb/disk-848acc8f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4ba19a656b9d/vmlinux-848acc8f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7c2a17aaee7c/bzImage-848acc8f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2f6a3b7dc3b442ef515c@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 5608 Comm: syz-executor162 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:strlen+0x29/0x70 lib/string.c:402
Code: 90 f3 0f 1e fa 41 57 41 56 41 54 53 48 c7 c0 ff ff ff ff 49 be 00 00 00 00 00 fc ff df 48 89 fb 49 89 c7 48 89 d8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 75 11 48 ff c3 49 8d 47 01 42 80 7c 3f 01 00
RSP: 0018:ffffc900043ef978 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88803cd4dd00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900043efab8 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1f5f467 R12: 1ffff9200087df40
R13: dffffc0000000000 R14: dffffc0000000000 R15: ffffffffffffffff
FS:  0000555563612400(0000) GS:ffff888125d3e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563591bce000 CR3: 0000000046a98000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __fortify_strlen include/linux/fortify-string.h:218 [inline]
 do_getname_kernel+0x1d/0x230 fs/namei.c:260
 class_filename_kernel_constructor include/linux/fs.h:2565 [inline]
 filp_open+0x87/0x1d0 fs/open.c:1342
 nvmet_file_ns_enable+0x74/0x360 drivers/nvme/target/io-cmd-file.c:41
 nvmet_ns_enable+0xaa/0x780 drivers/nvme/target/core.c:596
 nvmet_ns_enable_store+0xd7/0x170 drivers/nvme/target/configfs.c:735
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x33a/0x430 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x61e/0xbb0 fs/read_write.c:687
 ksys_write+0x156/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb41977f689
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe221a7f98 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000200000000000 RCX: 00007fb41977f689
RDX: 0000000000000001 RSI: 0000200000000580 RDI: 0000000000000004
RBP: 6769666e6f632f2e R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 00007ffe221a8108
R13: 0000200000000008 R14: 00007fb419812c40 R15: 0000000000000002
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strlen+0x29/0x70 lib/string.c:402
Code: 90 f3 0f 1e fa 41 57 41 56 41 54 53 48 c7 c0 ff ff ff ff 49 be 00 00 00 00 00 fc ff df 48 89 fb 49 89 c7 48 89 d8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 75 11 48 ff c3 49 8d 47 01 42 80 7c 3f 01 00
RSP: 0018:ffffc900043ef978 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88803cd4dd00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900043efab8 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1f5f467 R12: 1ffff9200087df40
R13: dffffc0000000000 R14: dffffc0000000000 R15: ffffffffffffffff
FS:  0000555563612400(0000) GS:ffff888125d3e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563591bce000 CR3: 0000000046a98000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	f3 0f 1e fa          	endbr64
   5:	41 57                	push   %r15
   7:	41 56                	push   %r14
   9:	41 54                	push   %r12
   b:	53                   	push   %rbx
   c:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  13:	49 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%r14
  1a:	fc ff df
  1d:	48 89 fb             	mov    %rdi,%rbx
  20:	49 89 c7             	mov    %rax,%r15
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	75 11                	jne    0x44
  33:	48 ff c3             	inc    %rbx
  36:	49 8d 47 01          	lea    0x1(%r15),%rax
  3a:	42 80 7c 3f 01 00    	cmpb   $0x0,0x1(%rdi,%r15,1)


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
