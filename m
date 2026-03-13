Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FFC308F03
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Mar 2026 03:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773371312; cv=none; b=Xd26RWqjqpYvYP6UKRndbjO/WcsprAz+aKePqpTAMAA9VzMKnKkSSrjajdu9Y2K/wXTGIMInhUbjg7/8Mlma5kLVzdPT4eDCcHoINp8fhh01pmSoQPHt87GbG3DdlUSG2GlzVdsYUVpS4C0rfXuxR52SvIG7Jhq6KC7YK0cp2tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773371312; c=relaxed/simple;
	bh=7fDbngeUSGS25hbHPC8hPrXp6oQjW3wAGqQQxk12RKc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AVyQl5TXThN5eN0KRdjEk6vTKH6PbefKtUZqorW+dsYM/aDCOuGCFcJrRMCwBD7ccxkBfIwDCqN3PT5y8WsXjNsh/a1AuIjF0o6niDJN/U8k241mTt3rJX7VezIGZhkDHuhsNs+lSbyUhv2PFT9XrurvauH8ErkkzssQDR3fPsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d74ab502b0so2895875a34.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 20:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773371310; x=1773976110;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BajvsZ5rg++uya2g3fXSvHMVBZ9OX63gVQicvg9r6Xo=;
        b=a5s7QHb2boG+kQRJJ13hweRGSuvj68kLhWJRr2TKdo6Hh+2Ad+C0CBTVM5pcNR0kP4
         Zt0Y9iFhZYz5qFbQ9aGVYobU+taTGT0kctJA4eeAJ4qdJzNb/VBqWOul4Un0VBsNQ65c
         CgnfLxpQmbnt+3K4BXe7iBPhwgf9DxurRvzvbQDxeFYtJAqAChSTqxBwQCsLhReYYPbB
         DyBuRBFinJ9bejq5h+KY/WuluBRE6oYejY7DdZDixzil8AVBaTBRbytn1MHzzRwClDVH
         afjLur2Xz9K6usor93CaxdoU5/WLTCnZN0HEUGyzJK5jV3hHnxrOf6jczzlHdV1Jw0gR
         flaw==
X-Forwarded-Encrypted: i=1; AJvYcCWHyfbs2ikIFLFA6I4cV9GEatGV9JDl4svHaNMG/pnw07XjCwiMhmmmydwrjzrBrRwMqFhrQ+WRSI7KNMOa@vger.kernel.org
X-Gm-Message-State: AOJu0YzWIs/gr+TY1InbqllZ5rF2Wo5+0gnw+Shw58vtxx3Q8BUOoJJD
	z4EZab3+aWP/XZoqv8j8CwYctKcrZZ7dvKLxyri7zJ5EflIxhjLVRF76pCUlxljlTF0HDqjNIUN
	RG6ew/ZEhsn8IWz5ZcdNiixBXk5/SGU7TkRaxaPzfRWflmpRRc+QBk/XOnnw=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4d4b:10b0:67b:deec:1435 with SMTP id
 006d021491bc7-67bdeec178emr50666eaf.21.1773371309960; Thu, 12 Mar 2026
 20:08:29 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:08:29 -0700
In-Reply-To: <000000000000dd477c0600d6d815@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b37fad.a00a0220.3b25d1.0005.GAE@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in lookup_slow (3)
From: syzbot <syzbot+65459fd3b61877d717a3@syzkaller.appspotmail.com>
To: driver-core@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot has found a reproducer for the following issue on:

HEAD commit:    8004279c41ad Merge tag 'nfs-for-7.0-2' of git://git.linux-.=
.
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=3D12f9775a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D294595c42a927f5=
5
dashboard link: https://syzkaller.appspot.com/bug?extid=3D65459fd3b61877d71=
7a3
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1429cd5258000=
0
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D162eff5a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d1ce7fc684d/disk-=
8004279c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9d97f0127a44/vmlinux-=
8004279c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f36219283bb9/bzI=
mage-8004279c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+65459fd3b61877d717a3@syzkaller.appspotmail.com

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz.0.17/6008 is trying to acquire lock:
ffff88807982dab8 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: inode_lock_sha=
red include/linux/fs.h:1043 [inline]
ffff88807982dab8 (&type->i_mutex_dir_key#6){++++}-{4:4}, at: lookup_slow+0x=
42/0x70 fs/namei.c:1932

but task is already holding lock:
ffffffff8e69df08 (param_lock){+.+.}-{4:4}, at: kernel_param_lock kernel/par=
ams.c:602 [inline]
ffffffff8e69df08 (param_lock){+.+.}-{4:4}, at: param_attr_store+0xec/0x300 =
kernel/params.c:587

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (param_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       ieee80211_rate_control_ops_get net/mac80211/rate.c:223 [inline]
       rate_control_alloc net/mac80211/rate.c:269 [inline]
       ieee80211_init_rate_ctrl_alg+0x1df/0x3b0 net/mac80211/rate.c:1016
       ieee80211_register_hw+0x2950/0x4140 net/mac80211/main.c:1544
       mac80211_hwsim_new_radio+0x2847/0x57d0 drivers/net/wireless/virtual/=
mac80211_hwsim.c:5810
       init_mac80211_hwsim+0x6db/0x7f0 drivers/net/wireless/virtual/mac8021=
1_hwsim.c:7173
       do_one_initcall+0x11d/0x760 init/main.c:1382
       do_initcall_level init/main.c:1444 [inline]
       do_initcalls init/main.c:1460 [inline]
       do_basic_setup init/main.c:1479 [inline]
       kernel_init_freeable+0x6e5/0x7a0 init/main.c:1692
       kernel_init+0x1f/0x1e0 init/main.c:1582
       ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (rtnl_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       cgrp_css_online+0xa1/0x1f0 net/core/netprio_cgroup.c:157
       online_css+0xb2/0x350 kernel/cgroup/cgroup.c:5732
       css_create kernel/cgroup/cgroup.c:5820 [inline]
       cgroup_apply_control_enable+0x8bd/0xbd0 kernel/cgroup/cgroup.c:3389
       cgroup_mkdir+0x57f/0x1330 kernel/cgroup/cgroup.c:6021
       kernfs_iop_mkdir+0x111/0x190 fs/kernfs/dir.c:1273
       vfs_mkdir+0x361/0x850 fs/namei.c:5233
       filename_mkdirat+0x48b/0x5e0 fs/namei.c:5266
       __do_sys_mkdirat fs/namei.c:5287 [inline]
       __se_sys_mkdirat fs/namei.c:5284 [inline]
       __x64_sys_mkdirat+0x89/0xc0 fs/namei.c:5284
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (cgroup_mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:614 [inline]
       __mutex_lock+0x1a2/0x1b90 kernel/locking/mutex.c:776
       cgroup_lock include/linux/cgroup.h:394 [inline]
       cgroup_kn_lock_live+0x116/0x520 kernel/cgroup/cgroup.c:1732
       cgroup_rmdir+0x22/0x2e0 kernel/cgroup/cgroup.c:6226
       kernfs_iop_rmdir+0x106/0x170 fs/kernfs/dir.c:1291
       vfs_rmdir fs/namei.c:5338 [inline]
       vfs_rmdir+0x328/0x8a0 fs/namei.c:5311
       filename_rmdir+0x31a/0x5c0 fs/namei.c:5393
       __do_sys_rmdir fs/namei.c:5416 [inline]
       __se_sys_rmdir fs/namei.c:5413 [inline]
       __x64_sys_rmdir+0x46/0x70 fs/namei.c:5413
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&type->i_mutex_dir_key#6){++++}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3165 [inline]
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x14b8/0x2630 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1cf/0x380 kernel/locking/lockdep.c:5825
       down_read+0x99/0x460 kernel/locking/rwsem.c:1537
       inode_lock_shared include/linux/fs.h:1043 [inline]
       lookup_slow+0x42/0x70 fs/namei.c:1932
       walk_component fs/namei.c:2279 [inline]
       lookup_last fs/namei.c:2780 [inline]
       path_lookupat+0x5e8/0xc40 fs/namei.c:2804
       filename_lookup+0x202/0x590 fs/namei.c:2833
       kern_path+0x37/0x50 fs/namei.c:3040
       lookup_bdev+0xd8/0x280 block/bdev.c:1221
       bdev_file_open_by_path+0x82/0x330 block/bdev.c:1094
       add_device drivers/mtd/devices/block2mtd.c:279 [inline]
       block2mtd_setup2.isra.0+0x2ee/0xc70 drivers/mtd/devices/block2mtd.c:=
459
       block2mtd_setup+0xbd/0xd0 drivers/mtd/devices/block2mtd.c:476
       param_attr_store+0x199/0x300 kernel/params.c:589
       module_attr_store+0x58/0x80 kernel/params.c:913
       sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
       kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:352
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1070 fs/read_write.c:688
       ksys_write+0x12a/0x250 fs/read_write.c:740
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &type->i_mutex_dir_key#6 --> rtnl_mutex --> param_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(param_lock);
                               lock(rtnl_mutex);
                               lock(param_lock);
  rlock(&type->i_mutex_dir_key#6);

 *** DEADLOCK ***

4 locks held by syz.0.17/6008:
 #0: ffff888037100420 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x25=
0 fs/read_write.c:740
 #1: ffff888063a41488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0=
x2c2/0x5f0 fs/kernfs/file.c:343
 #2: ffff88803515ee18 (kn->active#4){.+.+}-{0:0}, at: kernfs_get_active_of =
fs/kernfs/file.c:80 [inline]
 #2: ffff88803515ee18 (kn->active#4){.+.+}-{0:0}, at: kernfs_fop_write_iter=
+0x332/0x5f0 fs/kernfs/file.c:344
 #3: ffffffff8e69df08 (param_lock){+.+.}-{4:4}, at: kernel_param_lock kerne=
l/params.c:602 [inline]
 #3: ffffffff8e69df08 (param_lock){+.+.}-{4:4}, at: param_attr_store+0xec/0=
x300 kernel/params.c:587

stack backtrace:
CPU: 1 UID: 0 PID: 6008 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(ful=
l)=20
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 02/27/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1c7 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3165 [inline]
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x14b8/0x2630 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1cf/0x380 kernel/locking/lockdep.c:5825
 down_read+0x99/0x460 kernel/locking/rwsem.c:1537
 inode_lock_shared include/linux/fs.h:1043 [inline]
 lookup_slow+0x42/0x70 fs/namei.c:1932
 walk_component fs/namei.c:2279 [inline]
 lookup_last fs/namei.c:2780 [inline]
 path_lookupat+0x5e8/0xc40 fs/namei.c:2804
 filename_lookup+0x202/0x590 fs/namei.c:2833
 kern_path+0x37/0x50 fs/namei.c:3040
 lookup_bdev+0xd8/0x280 block/bdev.c:1221
 bdev_file_open_by_path+0x82/0x330 block/bdev.c:1094
 add_device drivers/mtd/devices/block2mtd.c:279 [inline]
 block2mtd_setup2.isra.0+0x2ee/0xc70 drivers/mtd/devices/block2mtd.c:459
 block2mtd_setup+0xbd/0xd0 drivers/mtd/devices/block2mtd.c:476
 param_attr_store+0x199/0x300 kernel/params.c:589
 module_attr_store+0x58/0x80 kernel/params.c:913
 sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
 kernfs_fop_write_iter+0x3e0/0x5f0 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x6ac/0x1070 fs/read_write.c:688
 ksys_write+0x12a/0x250 fs/read_write.c:740
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7faeae79c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 =
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff f=
f 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd3b6d7408 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007faeaea15fa0 RCX: 00007faeae79c799
RDX: 0000000000000025 RSI: 0000200000000000 RDI: 0000000000000004
RBP: 00007faeae832c99 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007faeaea15fac R14: 00007faeaea15fa0 R15: 00007faeaea15fa0
 </TASK>
block2mtd: error: cannot open device =EF=BF=BDinX=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=14=C2=B1=EF=BF=BD=EF=BF=BDjFB=EF=BF=BD=1EB>U=EF=BF=BD=
;=DF=B8=0F=EF=BF=BDIlk=EF=BF=BD


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
