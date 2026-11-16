Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846152;
	b=Xo/r1ngoCD8x3ZuEQSt4Hq9HBumLu8pEilXjz3WbizKt7bxj+KySIJH02RMrzHrmQwVS
	 siVd4T3cbEqile5QSmUSzudy7S539oPUORNGo74Ji69985N3EOB6+rV6WId29/6iJlm/2
	 +QGcZ9zStfsn9jNQ6dVRuxSRQMsjcxV1fIdbMgNMcnPPUai/IRWwskHgtHCF5NIiFGRvB
	 JsN4DlDsEIDhBPiT2V1FwWOCDhRu2jvMVkFTEUjfLDXlyeciJCdLHJPUK7a2/8ZXonrVa
	 flcwf3TvFE05tNSE/PhJSz1zGSW/klCmVFds6vfZlZ9bzoVWgdcvo3wPrVR9mYp9p4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846152;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=7Kn4T3ctf7NTxl0xkb9PpPBFyo9KEzknD6SG3l/Na9k=;
	b=QLrPy7O6QFUOcotThaIcudgT2vm4k5cmDqK5a656OilreADsxqy1sG5Gs5V18622WthJ
	 Wa61Ke+53tY2ShRnCG9biYH5CBTYYwrQVsikEQ4OrkyUkxZEKV+cfZp0seDtosOgAjZGC
	 E1QAF405I1V9M4JNO2syZSP01pJmQyHw0SDeuKWEHeATXHAUZuNuiK8h30lmHqBDd+2d0
	 ljMxtHXlO3yOEHprGEp2lAwdSK+2gtmSajHWx6qEFGtA2haK3aGbIo75PRrX6xUZpsr8F
	 WeQl7qodmjC+uADm21Plls4MRdeBZIV0ipdphp/6UKG6ft09XBngsOxTOBjjFlj9BBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B37606A330
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 16:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56B37606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4b597558c4cso4104919b6e.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 08:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794846151; x=1795450951;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Kn4T3ctf7NTxl0xkb9PpPBFyo9KEzknD6SG3l/Na9k=;
        b=I12x5fct4VTCp2vbGgKPFGujcPmKhvkM68eUabLuddk2aslM97cRlWk8k46FN/rxcU
         uTs7U5PPfrRSRQyXoR8ciwuq6e35nB545VBMbyqggFgI3XoCo9A6+COqavdt//XrPJQD
         iS3sRyIuIfPA7gsB4nw/UycqOMZr+xopNYglyb4mkLJJMyxGBy7wrWtPCugh9fqrQl/2
         P8wV3LFzMizAAhqrVT2z4FRTO78DSMLU9fSSDQhvabJFanyTWlckPFSQinnxcJlf7eBs
         yzLHuKfqMdEh5GezfVP8E1udNRYYPIT8X3Io9TO63laI7775RVVRDw9rfd3yJh44GMti
         ArMQ==
X-Forwarded-Encrypted: i=1; AL+hErH7YFf7vgridEVjfs8UZzEe89zd9Fi8cvHFPB5pD0wGMC6FISdDpPHQPmeAW6SqVMu7SeQRZSQRBmnl63fS@vger.kernel.org
X-Gm-Message-State: APuU4Z8LHRbTrqD1Oxkpm5tZvbybKuTVUy+6LZbrxRYnZrvC4Z7/IOUZ
	L6Q+OTVej6VbTeR3nMu9mYqvz2q+D4LkVzLog+9EovaNhy8gAhh//yiGXVqko3qTNyNlpnoPolY
	5l2wuvhHjePXWXWlZy5sKSzUXjOfNqQz/CzTUQ5p5nEj34F6/75ey8GZxF3s=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c3f3:b0:531:7f68:842e with SMTP id
 5614622812f47-56e605b52c5mr8812460b6e.8.1794846151349; Mon, 16 Nov 2026
 08:22:31 -0800 (PST)
Date: Mon, 16 Nov 2026 08:22:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6afb2dc7.e6a8accb.234e85.0002.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in uvcg_streaming_class_drop_link
From: syzbot <syzbot+8277294f653f005e64d8@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aebb72744764 Linux 7.4-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139f3e4d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d44b06612b68f56
dashboard link: https://syzkaller.appspot.com/bug?extid=8277294f653f005e64d8
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b41932060b28/disk-aebb7274.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8cebe8ee66ec/vmlinux-aebb7274.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5547adc1d9da/bzImage-aebb7274.xz

AI-generated root cause summary:
A circular locking dependency warning is triggered between
gadget_subsys.su_mutex, tpg_instances_lock, and the VFS inode mutex
(&sb->s_type->i_mutex_key). During TCM portal group creation, usbg_make_tpg()
calls configfs_depend_item_unlocked() while holding tpg_instances_lock
(previously acquired under gadget_subsys.su_mutex), which acquires the configfs
root directory inode lock. When subsequently unlinking a UVC streaming class
symlink, vfs_unlink() holds the symlink's inode lock and invokes
uvcg_streaming_class_drop_link(), which acquires gadget_subsys.su_mutex for
hierarchy navigation. Because configfs symlink inodes and the configfs root
directory inode both share the default superblock inode lockdep class
(&sb->s_type->i_mutex_key), lockdep detects a circular dependency (su_mutex ->
tpg_instances_lock -> i_mutex_key -> su_mutex).

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=8277294f653f005e64d8

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8277294f653f005e64d8@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.6.5184/29156 is trying to acquire lock:
ffffffff91034be8 (gadget_subsys.su_mutex){+.+.}-{4:4}, at: uvcg_streaming_class_drop_link+0x70/0x540 drivers/usb/gadget/function/uvc_configfs.c:3502

but task is already holding lock:
ffff88807a66d900 (&sb->s_type->i_mutex_key#46){++++}-{4:4}, at: inode_lock include/linux/fs.h:1027 [inline]
ffff88807a66d900 (&sb->s_type->i_mutex_key#46){++++}-{4:4}, at: vfs_unlink+0xd4/0x710 fs/namei.c:5653

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&sb->s_type->i_mutex_key#46){++++}-{4:4}:
       down_write+0x91/0x200 kernel/locking/rwsem.c:1631
       inode_lock include/linux/fs.h:1027 [inline]
       configfs_depend_item_unlocked+0x153/0x420 fs/configfs/dir.c:1268
       usbg_make_tpg+0x1e0/0x550 drivers/usb/gadget/function/f_tcm.c:1692
       target_fabric_make_tpg+0xa8/0x6d0 drivers/target/target_core_fabric_configfs.c:947
       configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1369
       vfs_mkdir+0x411/0x660 fs/namei.c:5428
       filename_mkdirat+0x284/0x550 fs/namei.c:5461
       __do_sys_mkdirat fs/namei.c:5482 [inline]
       __se_sys_mkdirat+0x35/0x150 fs/namei.c:5479
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (tpg_instances_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       tcm_alloc_inst+0x65/0x1a0 drivers/usb/gadget/function/f_tcm.c:2687
       try_get_usb_function_instance drivers/usb/gadget/functions.c:28 [inline]
       usb_get_function_instance+0xe3/0x2f0 drivers/usb/gadget/functions.c:44
       function_make+0x127/0x360 drivers/usb/gadget/configfs.c:626
       configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1369
       vfs_mkdir+0x411/0x660 fs/namei.c:5428
       filename_mkdirat+0x284/0x550 fs/namei.c:5461
       __do_sys_mkdirat fs/namei.c:5482 [inline]
       __se_sys_mkdirat+0x35/0x150 fs/namei.c:5479
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (func_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       try_get_usb_function_instance drivers/usb/gadget/functions.c:18 [inline]
       usb_get_function_instance+0x2e/0x2f0 drivers/usb/gadget/functions.c:44
       function_make+0x127/0x360 drivers/usb/gadget/configfs.c:626
       configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1369
       vfs_mkdir+0x411/0x660 fs/namei.c:5428
       filename_mkdirat+0x284/0x550 fs/namei.c:5461
       __do_sys_mkdirat fs/namei.c:5482 [inline]
       __se_sys_mkdirat+0x35/0x150 fs/namei.c:5479
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (gadget_subsys.su_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3209 [inline]
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
       uvcg_streaming_class_drop_link+0x70/0x540 drivers/usb/gadget/function/uvc_configfs.c:3502
       configfs_unlink+0x44f/0x6b0 fs/configfs/symlink.c:258
       vfs_unlink+0x279/0x710 fs/namei.c:5667
       filename_unlinkat+0x297/0x5c0 fs/namei.c:5737
       __do_sys_unlink fs/namei.c:5772 [inline]
       __se_sys_unlink+0x2e/0x140 fs/namei.c:5769
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  gadget_subsys.su_mutex --> tpg_instances_lock --> &sb->s_type->i_mutex_key#46

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#46);
                               lock(tpg_instances_lock);
                               lock(&sb->s_type->i_mutex_key#46);
  lock(gadget_subsys.su_mutex);

 *** DEADLOCK ***

locks held by syz.6.5184/29156: 3, on CPU#0:
 #0: ffff88801f3d6478 (sb_writers#34){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:531
 #1: ffff88804f754f80 (&default_group_class[depth - 1]#9/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff88804f754f80 (&default_group_class[depth - 1]#9/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2924 [inline]
 #1: ffff88804f754f80 (&default_group_class[depth - 1]#9/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2948 [inline]
 #1: ffff88804f754f80 (&default_group_class[depth - 1]#9/1){+.+.}-{4:4}, at: filename_unlinkat+0x198/0x5c0 fs/namei.c:5718
 #2: ffff88807a66d900 (&sb->s_type->i_mutex_key#46){++++}-{4:4}, at: inode_lock include/linux/fs.h:1027 [inline]
 #2: ffff88807a66d900 (&sb->s_type->i_mutex_key#46){++++}-{4:4}, at: vfs_unlink+0xd4/0x710 fs/namei.c:5653

stack backtrace:
CPU: 0 UID: 0 PID: 29156 Comm: syz.6.5184 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2087
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2219
 check_prev_add kernel/locking/lockdep.c:3209 [inline]
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x197/0x15a0 kernel/locking/mutex.c:821
 uvcg_streaming_class_drop_link+0x70/0x540 drivers/usb/gadget/function/uvc_configfs.c:3502
 configfs_unlink+0x44f/0x6b0 fs/configfs/symlink.c:258
 vfs_unlink+0x279/0x710 fs/namei.c:5667
 filename_unlinkat+0x297/0x5c0 fs/namei.c:5737
 __do_sys_unlink fs/namei.c:5772 [inline]
 __se_sys_unlink+0x2e/0x140 fs/namei.c:5769
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x171/0x540 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe49e9a94d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe49f7d3028 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 00007fe49ec25fa0 RCX: 00007fe49e9a94d9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000500
RBP: 00007fe49ea3804e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe49ec26038 R14: 00007fe49ec25fa0 R15: 00007ffd463b1d98
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
