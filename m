Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854250;
	b=dJp7YazxUFS2ksSE4/kAiEv/o/JPCv1ZAAzj+UyIT6JQxXz44URvrxVW2Mhy/T80YLva
	 1VsqofSOc8RTnfF/G000600+HlXyJU8hBEhUhM9D+xRFDv8wAoY/U3OYRti5xZxD+2zx3
	 pWf6pSnzW7Lovw5Viww1XcT3Sse9pueDHdoTRaA7NmT+enPE6zUxdkoGi7JfqrjZQEcNa
	 /g37QCauONZktPXiGoeoiN1vZJ4Z3UgE4eVPKDmbyO9tulkNRB9EaVlggvB4KeSgmm3ut
	 QiL7zA7rHPi3L6KcABvqdtd/hCQmu0iEa45c+YnDujZp/pQWisgIvrJlI2OgY/ibJhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854250;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=uI31bqOB59nepJfqf7G57PvJCgpDKr2+9y22AA7wNiI=;
	b=lH4E5A+oxR4Wfji5qmb4G1HWksbTatrkTFyrbWDpNVeG1z1lagy2fVYnVwovR8Xgv0bx
	 3wC5kP3IzeSYVkmWWWf0+WCxgHtWBXzYwCdw2owjOwuRuJbEbpjKMsEwlLA8adsOcGmda
	 h6QuGV+P5VPCaLnb7Ggn3cNjdMQR464p2gs1lynIjG9h5nbyotJKw2YC1ZKMCml+dRP3v
	 4bkvqbrC2arMWd2+JhlmJh0zvYOrILX8UqBZQm1XwNnjwODILnQtPjQXOB1DEGjqVPu58
	 gidQxN7BfXVHrEKg+be7//+vycaYO+b/Y6F5LYHc6WrV0AOax1CNncJvxe5gQ1v4qKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.161.69
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F224606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 18:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F224606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6dd1142710fso2492459eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 10:37:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854249; x=1795459049;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uI31bqOB59nepJfqf7G57PvJCgpDKr2+9y22AA7wNiI=;
        b=x5+Ftpo4x+eZ3ReGjltvNAefsAL6+rWudRgwL2inDF2F6USptVkkGcLv08gw2Ca4YL
         Tzaz/7XZ4AawIppOrokZk0KL8ZWtuQ3ovTRp+f+QlEwpou2niDWNm4exGPEtI1LtcPlp
         fhU/FJBN+mdN/S/yq/DHA2wM8W02AyAHK5u3LkTcgy4LAnmmc9GKObB4e198+q+0sXXc
         t3cEArzZtY8D22/Pcze1LJz4b2z9Vhtto+jiwsuXm+NdQ2Ijf4zASF8XmAwrjartDER+
         A1EakISBWqzxwGGT5AK7dmo8XAn33joD4Se35CVq7a1PVgQ95AIK6LtiubsqkUcTi4iX
         cmJg==
X-Forwarded-Encrypted: i=1; AL+hErE5+/TpfGwUn15p12VOBJr7GBmL97Ibklf+6iyce3diQkic8bUE2MRFuKowyYLytiRWopSnkL44YeTk+7np@vger.kernel.org
X-Gm-Message-State: APuU4Z9/Wzm35h8yHR9olRMyY+dw8cYceekFpctw4IlI3q+UuoaiBl4p
	g+qfoWaZdLVhVjDC8vCD7yiMnWVDn+kOUJJbOWvXsfw6OsTkQxt9PVsr3cXBs1Ti8FnxjtDOlZ1
	klO64MOiXcXDf9xUBpQrfYM3iWMDaouEc22NSaWdTxF1VtsHRVm0bWI0hbug=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4fe3:b0:573:2541:17fe with SMTP id
 5614622812f47-57325512cc3mr5708474b6e.25.1794854249218; Mon, 16 Nov 2026
 10:37:29 -0800 (PST)
Date: Mon, 16 Nov 2026 10:37:29 -0800
In-Reply-To: <6afb2dc7.e6a8accb.234e85.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6afb4d69.27ea6653.1a0e84.0001.GAE@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in uvcg_streaming_class_drop_link
From: syzbot <syzbot+8277294f653f005e64d8@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    aebb72744764 Linux 7.4-rc3
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10026dad580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d44b06612b68f56
dashboard link: https://syzkaller.appspot.com/bug?extid=8277294f653f005e64d8
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fd1bfd580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12026dad580000

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
syzkaller #0 Not tainted
------------------------------------------------------
syz-executor251/5652 is trying to acquire lock:
ffffffff91034be8 (gadget_subsys.su_mutex){+.+.}-{4:4}, at: uvcg_streaming_class_drop_link+0x70/0x540 drivers/usb/gadget/function/uvc_configfs.c:3502

but task is already holding lock:
ffff888071c99440 (&sb->s_type->i_mutex_key#18){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1027 [inline]
ffff888071c99440 (&sb->s_type->i_mutex_key#18){+.+.}-{4:4}, at: vfs_unlink+0xd4/0x710 fs/namei.c:5653

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&sb->s_type->i_mutex_key#18){+.+.}-{4:4}:
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
  gadget_subsys.su_mutex --> tpg_instances_lock --> &sb->s_type->i_mutex_key#18

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&sb->s_type->i_mutex_key#18);
                               lock(tpg_instances_lock);
                               lock(&sb->s_type->i_mutex_key#18);
  lock(gadget_subsys.su_mutex);

 *** DEADLOCK ***

locks held by syz-executor251/5652: 3, on CPU#0:
 #0: ffff88801eff0478 (sb_writers#8){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:531
 #1: ffff888078fe4f80 (&default_group_class[depth - 1]#7/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
 #1: ffff888078fe4f80 (&default_group_class[depth - 1]#7/1){+.+.}-{4:4}, at: __start_dirop fs/namei.c:2924 [inline]
 #1: ffff888078fe4f80 (&default_group_class[depth - 1]#7/1){+.+.}-{4:4}, at: start_dirop fs/namei.c:2948 [inline]
 #1: ffff888078fe4f80 (&default_group_class[depth - 1]#7/1){+.+.}-{4:4}, at: filename_unlinkat+0x198/0x5c0 fs/namei.c:5718
 #2: ffff888071c99440 (&sb->s_type->i_mutex_key#18){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1027 [inline]
 #2: ffff888071c99440 (&sb->s_type->i_mutex_key#18){+.+.}-{4:4}, at: vfs_unlink+0xd4/0x710 fs/namei.c:5653

stack backtrace:
CPU: 0 UID: 0 PID: 5652 Comm: syz-executor251 Not tainted syzkaller #0 PREEMPT(full) 
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
RIP: 0033:0x7fb28793a6c9
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffe9611a58 EFLAGS: 00000246 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000200000000500 RCX: 00007fb28793a6c9
RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000200000000500
RBP: 0000000000000001 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 00007fffe9611bc8
R13: 431bde82d7b634db R14: 00007fb2879cdc40 R15: 0000000000000002
 </TASK>
