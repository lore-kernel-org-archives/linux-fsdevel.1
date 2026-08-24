Received: from mail-oi1-f205.google.com (mail-oi1-f205.google.com [209.85.167.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3208D3FE66F
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565044; cv=none; b=HVYXys+o39nbZR1/32SOgGhLpei6ohw5z7F3q3efcQiiYnS/NEAuFIcpbt1yb3CZ5NbFXHpMg17V0bLHiOb/oTDfNAoFFSU2HYgif8Cp6rMBWjMoJfp9dd91FowKu9D15hC8Rk88YCcCXo3rrzXHQok+7P6hgR0HHDRcp4sEN/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565044; c=relaxed/simple;
	bh=Txjw6O7RWvrvx2BdRJn4lyWZnEK+gkLyL7TvZJOfpfg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MO4AQl4NdI6LO6ZlvGFIGTsedAlUnzmVJ6/RlxPp3MP05aDOoCQpcd8L8nVrS69RXsR7roHLaSAxGuO3xoaxe8h1NUxu8PaGtYmdwO2Gh4+1swryqah37rnBtXe0atOu4rrzouwEkNT4RUy/X6q0J0/3FVWejzChJ6BvCCbbFAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f205.google.com with SMTP id 5614622812f47-4b28d7ffab1so8028684b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 02:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787565038; x=1788169838;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DxAjgfRYxWmWgjBv31YDuU6yuFMKPeHeRDu/GK89Mlw=;
        b=VoCA2a+lN+7WT1/4DyMSdT1qwp6EKaiS8pepZxnhwZZuQWMegqovTuB8QWEgXEzfox
         1SNrCQHfqyDa57qZfu4Hlss2221GHsfPzb6XBrSywukBh+Zf0zedgUg6KuIzOLfh7pHo
         dLtnKfFjE/Tgiw7JaNuPRlM/tbAlCwdywGD8DiL2hl4GIoR2g0B3QiPftCCRu6uofDC3
         zVCnYLaHPJdWavdD7EZENhuBjTD7A6BGZ19p6MFog7CJQX23pkflcpG9mrE878Qq0YrG
         +npX62C3EfT5jkNp1NBgubiYND/nPGSYOCfU2J9RWo4lN9epAfBUCFQCQF1Z0ZzNuLtK
         8Jmw==
X-Gm-Message-State: AFuF++loJZ7QYDIy5yKm5X9VRi13R2Hqd/JMgAjqdwg4XcI7AAuZUbyR
	KH6TAi3edr6VNlgwIlmgyw+zrYYAA//Xnz3LTANMso8/ztP8N/BWM5ZMwxPl7EOd2J128bOD24/
	CbD3P2T9oPPx5aEAyL0ONQ0bHJCJcR5kuR43IuMiNOVHOu8JVL41NDyo93FCWuA==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1992:b0:4b2:8e26:bdd2 with SMTP id
 5614622812f47-4b2cde69b92mr27450524b6e.16.1787565038196; Mon, 24 Aug 2026
 02:50:38 -0700 (PDT)
Date: Mon, 24 Aug 2026 02:50:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8c13ee.91706f20.16b6e3.02d5.GAE@google.com>
Subject: [syzbot] [fs?] [trace?] WARNING in eventfs_create_events_dir
From: syzbot <syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com, 
	mhiramat@kernel.org, rostedt@goodmis.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f4cdf7ca9a1f Merge tag 'media/v7.3-1' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10d46549580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4b57019f58edf16
dashboard link: https://syzkaller.appspot.com/bug?extid=3ef80b4ed02226d04a06
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1577ba25580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/865d16295f11/disk-f4cdf7ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/71f476ad78fc/vmlinux-f4cdf7ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e19d5dbdc9b7/bzImage-f4cdf7ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ef80b4ed02226d04a06@syzkaller.appspotmail.com

Could not create tracefs 'set_event_pid' entry
Could not create tracefs 'set_event_notrace_pid' entry
------------[ cut here ]------------
!list_empty(&ei->children)
WARNING: fs/tracefs/event_inode.c:128 at free_ei fs/tracefs/event_inode.c:128 [inline], CPU#1: syz.0.20/6104
WARNING: fs/tracefs/event_inode.c:128 at cleanup_ei fs/tracefs/event_inode.c:150 [inline], CPU#1: syz.0.20/6104
WARNING: fs/tracefs/event_inode.c:128 at cleanup_ei fs/tracefs/event_inode.c:145 [inline], CPU#1: syz.0.20/6104
WARNING: fs/tracefs/event_inode.c:128 at eventfs_create_events_dir+0xa3d/0xbe0 fs/tracefs/event_inode.c:834, CPU#1: syz.0.20/6104
Modules linked in:
CPU: 1 UID: 0 PID: 6104 Comm: syz.0.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
RIP: 0010:free_ei fs/tracefs/event_inode.c:128 [inline]
RIP: 0010:cleanup_ei fs/tracefs/event_inode.c:150 [inline]
RIP: 0010:cleanup_ei fs/tracefs/event_inode.c:145 [inline]
RIP: 0010:eventfs_create_events_dir+0xa3d/0xbe0 fs/tracefs/event_inode.c:834
Code: 00 e8 57 f7 f9 00 e9 ab fb ff ff e8 2d 6d e6 fd 48 8b 7c 24 10 be 03 00 00 00 e8 3e f7 f9 00 e9 c2 fd ff ff e8 14 6d e6 fd 90 <0f> 0b 90 e9 59 fe ff ff e8 f6 0a 56 fe e9 4b f7 ff ff 48 89 44 24
RSP: 0018:ffffc90002617b88 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888077746000 RCX: 0000000000000000
RDX: ffff88802f489f40 RSI: ffffffff8424403c RDI: ffffffff8e679928
RBP: ffff88802737f210 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88802737f250
R13: 0000000000000003 R14: ffff88802737f24c R15: ffff88802737f200
FS:  00007f6c427fe6c0(0000) GS:ffff888123ccc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2cf63fff CR3: 0000000026acc000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 create_event_toplevel_files+0x12d/0x1a0 kernel/trace/trace_events.c:4593
 event_trace_add_tracer+0x72/0x260 kernel/trace/trace_events.c:4624
 trace_array_create_dir+0x8e/0x210 kernel/trace/trace.c:8548
 trace_array_create_systems+0x8b3/0xc30 kernel/trace/trace.c:8639
 trace_array_create kernel/trace/trace.c:8666 [inline]
 instance_mkdir+0xca/0x140 kernel/trace/trace.c:8681
 tracefs_syscall_mkdir+0x10e/0x180 fs/tracefs/inode.c:121
 vfs_mkdir+0x364/0x850 fs/namei.c:5410
 filename_mkdirat+0x48b/0x5e0 fs/namei.c:5443
 __do_sys_mkdirat fs/namei.c:5464 [inline]
 __se_sys_mkdirat fs/namei.c:5461 [inline]
 __x64_sys_mkdirat+0x89/0xc0 fs/namei.c:5461
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6c4319e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6c427fe028 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f6c43425fa0 RCX: 00007f6c4319e0d9
RDX: 00000000000001ff RSI: 0000200000000140 RDI: ffffffffffffff9c
RBP: 00007f6c43235024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f6c43426038 R14: 00007f6c43425fa0 R15: 00007fff53277798
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
