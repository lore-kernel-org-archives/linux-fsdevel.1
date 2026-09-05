Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B453C2D
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Sep 2026 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788603631; cv=none; b=nfzCjHe5hzAhGpmT1cnIXxoObUlv4RAOPNUPOf9G8bDNqcE5WiLI5hxZZunSdGXN1zB9yb76BIoAJxsM6mnx8km+vYf41zS8m7fqCiERmsxxHZpCf3BvRsBOSRdSMUtPZ4+Nw3edDqouwDTk6hC98fE5yr583Fvlne1XKA9L2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788603631; c=relaxed/simple;
	bh=Idlkh55hRaoETuuycgLnH7GVDVp/axxy3xzNgdKbXv8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ljrjgFmDWRaG3WCAh+V61bvuCZHGEG8+2W7lx1amlbobrgyURB1CSL/fh2fNPU6XJl8qKJtu6qtgnirNyOMtq+KMM89Q+uUYHk7uhiH+AwMvlPcWO20EALgT4hC/sIKbqG+qvg1nHDBd9xnU9Ogjxbyc8XqFqad1E2Mq7hto/Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo2-f7.google.com with SMTP id 006d021491bc7-6b1bebb3ae8so494795eaf.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Sep 2026 03:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788603629; x=1789208429;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jTlvTJJ4fA8El4tFO6YJiCOtiTrCeymc5pubKYwelis=;
        b=kpxhS8u9qjiJzA1+98neq0Q3pPpAVRwHtuJvAAu0hNhzHUGn+LVayGeZ4olItG8JoV
         OL9lw0r4T/Bcm8f6xqJD3IDHBrHcXXy+x6F4bg4m0WH6vSAK+ExoP1S43pOFtVen6NLg
         1BeR88qs8b6MxiXfvESiPnLUEBekwa7dPaYyVSBXu/avIXTGT8bx+x9pSHnin0KFlqV8
         qpKcbyhM9xDD04IYBOd04bjVBM3Ymk7UjSILarhB4JRAoKWNHbdvCM9a6uLM21Gp/v7i
         s5/2qggHHS1Nw8EV7nmyxsE0ViZw+EHvsV251jZwxsCNnQsgyQJzbSG+XYXjsO9dqxR7
         HS4w==
X-Forwarded-Encrypted: i=1; AKwUvBy5TpZfisl+wRTqMurl6hRHPtTitVeZPYYAxlmdHzYFu7foIkDn6Teg30sx34zGWklPfe73Mk1lM3mcpAwx@vger.kernel.org
X-Gm-Message-State: AFuF++nQQjAq+XIKCnb5VeWHoEfe4FlNypqVX7ijv8A+XxZpEi1lTpR0
	MVabLnIkfaMwLNSM0QFbM7EkdwdoUHVIe5KRKZFQdO3/ch1XuNY+vvCYKsuMgg9lQx6pIw+C2L7
	XsYhW40fvWee349RvPDSJahtifiZ1eqzVsIwH1+EiZqIWtN8NDJsTWb+bZuw=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:168f:b0:6b0:4199:3cc4 with SMTP id
 006d021491bc7-6b6fea84e5dmr9121676eaf.27.1788603629283; Sat, 05 Sep 2026
 03:20:29 -0700 (PDT)
Date: Sat, 05 Sep 2026 03:20:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9beced.a5e650b3.26d8a.000b.GAE@google.com>
Subject: [syzbot] [fs?] WARNING in do_new_mount (6)
From: syzbot <syzbot+2a13ad6914e6fcec716c@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    654ae5d73c05 Merge tag 'drm-fixes-2026-09-05' of https://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=143968f9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=2a13ad6914e6fcec716c
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/49c1a99f815b/disk-654ae5d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6fcecf1b8c8d/vmlinux-654ae5d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fa54b23691ca/bzImage-654ae5d7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a13ad6914e6fcec716c@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current)
WARNING: kernel/locking/rtmutex_common.h:193 at debug_rt_mutex_unlock kernel/locking/rtmutex_common.h:193 [inline], CPU#0: syz.5.471/9806
WARNING: kernel/locking/rtmutex_common.h:193 at rt_mutex_slowunlock+0x734/0xa30 kernel/locking/rtmutex.c:1432, CPU#0: syz.5.471/9806
Modules linked in:
CPU: 0 UID: 0 PID: 9806 Comm: syz.5.471 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:debug_rt_mutex_unlock kernel/locking/rtmutex_common.h:193 [inline]
RIP: 0010:rt_mutex_slowunlock+0x73b/0xa30 kernel/locking/rtmutex.c:1432
Code: b1 8f 48 c1 e8 03 42 0f b6 04 20 84 c0 0f 85 cf 02 00 00 83 3d 39 5d 5a 04 00 75 13 48 8d 3d 5c 4f 5d 04 48 c7 c6 20 28 6d 8b <67> 48 0f b9 3a 90 e9 cf f9 ff ff 48 8d 3d 53 4f 5d 04 67 48 0f b9
RSP: 0018:ffffc9000620fbc0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff888061d9a9f8 RCX: 0000000000080000
RDX: ffffc9000ddd9000 RSI: ffffffff8b6d2820 RDI: ffffffff8fb4e1f0
RBP: ffffc9000620fcb0 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1f63df9 R12: dffffc0000000000
R13: 1ffff92000c41f80 R14: ffff888061d9a9a8 R15: 0000000000000246
FS:  00007fc0841446c0(0000) GS:ffff888125bd4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd88506f52 CR3: 000000003a478000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 inode_unlock include/linux/fs.h:1034 [inline]
 __unlock_mount fs/namespace.c:2808 [inline]
 unlock_mount fs/namespace.c:2818 [inline]
 do_new_mount_fc fs/namespace.c:3795 [inline]
 do_new_mount+0x82d/0xdc0 fs/namespace.c:3848
 do_mount fs/namespace.c:4181 [inline]
 __do_sys_mount fs/namespace.c:4397 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4374
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc085f2e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc084144028 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007fc0861b6180 RCX: 00007fc085f2e159
RDX: 0000200000000080 RSI: 0000200000000040 RDI: 0000000000000000
RBP: 00007fc085fc5024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc0861b6218 R14: 00007fc0861b6180 R15: 00007ffc1374c1d8
 </TASK>
----------------
Code disassembly (best guess):
   0:	b1 8f                	mov    $0x8f,%cl
   2:	48 c1 e8 03          	shr    $0x3,%rax
   6:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax
   b:	84 c0                	test   %al,%al
   d:	0f 85 cf 02 00 00    	jne    0x2e2
  13:	83 3d 39 5d 5a 04 00 	cmpl   $0x0,0x45a5d39(%rip)        # 0x45a5d53
  1a:	75 13                	jne    0x2f
  1c:	48 8d 3d 5c 4f 5d 04 	lea    0x45d4f5c(%rip),%rdi        # 0x45d4f7f
  23:	48 c7 c6 20 28 6d 8b 	mov    $0xffffffff8b6d2820,%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	90                   	nop
  30:	e9 cf f9 ff ff       	jmp    0xfffffa04
  35:	48 8d 3d 53 4f 5d 04 	lea    0x45d4f53(%rip),%rdi        # 0x45d4f8f
  3c:	67                   	addr32
  3d:	48                   	rex.W
  3e:	0f                   	.byte 0xf
  3f:	b9                   	.byte 0xb9


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
