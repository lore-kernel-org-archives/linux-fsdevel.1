Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E5931326F
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 05:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785302852; cv=none; b=LCYOQtJnPT5Q5ViIeX9pX9tiBwqxdaOhWTvrdLCFZAqt5Dok3NH6nGH2nEvIEj9/tBuKJv5z7k4KWh927CfZDvv6grQ3ANcBh6PK+c/UvtAth3O6bx5JiUEVf7sWcZR6N6HlZ/H3uYFWWkKC2B4AqS9FEhCbHiE/P/yrlz0dC34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785302852; c=relaxed/simple;
	bh=i9jEe0P2sE9IW8SXt73vwdCcYhMgdpeG6EXSa7wQ14g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=d3weVkLeX7olIzWtUhsBw0BDl0S2rh3OmtRZ2MyL0IeOmcMFvKbocNIrte0hzV4zF0Qy6dg4rzvOBWnJW4Lm+C966B+hcDlKjC6vg0TqEL94JNMFRFl/GA7iAqMlkWbxjNcfNHWE7ffvRsLP65e/eAFJ7Pwv9YpWrOwfHM3iO6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-451ff8b9acbso1479314fac.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 22:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785302849; x=1785907649;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rIn/LBI9JBxDR42/aRTpRVXPaJbvrdIj7QtaG6wYi/E=;
        b=rM1Nr5L6aCJSOF9tC6GXa9vOrnIQjUvUEpeHmZ/2bJCXU6VeO81KtG7kq4ev7e/RXj
         OT4pgyHiRJRRDf8paR0Ju/bQjTSJMQU3hC+rTNfdSZhNRFhVuV7+HI7DyhL8H4aGARGg
         mxmG7NVoPTxg5tUuRsbPaOZuaSa0lImY72ceR+Xkem+61os1klh5JyJS5UIYR/YX3KVD
         Z1u/7UlXKJNJ1SkttHAF38i8yqp6NV7PMcyuHtP0NunugC8+23OYL1pRgVwoSCbUNVig
         o7P2OH37VdV71V2s6VfKhWDnENro/ejSUDQ7lL9tssAvny8PCMuS2zSu48voS1YofU7H
         9RsA==
X-Forwarded-Encrypted: i=1; AHgh+Rqc266VZLgrSkmvPugRJzQtn+r+KZP9z44pRIVm+r3pMTcOxyTGB9Kr1bZvVPLN2slYNE8N42wpDvcDpO4p@vger.kernel.org
X-Gm-Message-State: AOJu0YxonPwQ2+53K0TTX5BOoZPobp1EpqqaEMxTr55u5VxcYLa0R+HT
	uHcGXBbn+zpGXLmGfRnmdYNS4m0Ov6Kta/bIpqbqrthwjMHd9x2Z5OKyzJqM0GSYvIJW0GP6b5O
	FMmwFx5YOnUnGa9cwtt8dd0IUHCIFO38V9IeuvMEO+jTunEPpNnKr1nZ2J2A=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1646:b0:49a:7714:ed25 with SMTP id
 5614622812f47-4ad730d1443mr438633b6e.3.1785302849472; Tue, 28 Jul 2026
 22:27:29 -0700 (PDT)
Date: Tue, 28 Jul 2026 22:27:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a698f41.d9e86bb5.297b12.0052.GAE@google.com>
Subject: [syzbot] [fs?] possible deadlock in configfs_read_iter
From: syzbot <syzbot+d2085ac2d653b9e383e2@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f5098b6bae76 Linux 7.2-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137026b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=d2085ac2d653b9e383e2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2113dcf433f6/disk-f5098b6b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/413e673b7de4/vmlinux-f5098b6b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fc40c1b83e80/bzImage-f5098b6b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d2085ac2d653b9e383e2@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.3.4908/17817 is trying to acquire lock:
ffff88807ab9cc80 (&buffer->mutex){+.+.}-{4:4}, at: configfs_read_iter+0x79/0x6f0 fs/configfs/file.c:86

but task is already holding lock:
ffff8880741349a8 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: process_measurement+0x5ab/0x2350 security/integrity/ima/ima_main.c:319

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #6 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       process_measurement+0x5ab/0x2350 security/integrity/ima/ima_main.c:319
       ima_file_check+0xc3/0x110 security/integrity/ima/ima_main.c:685
       security_file_post_open+0xc4/0x210 security/security.c:2755
       do_open fs/namei.c:4702 [inline]
       path_openat+0x985/0x4280 fs/namei.c:4863
       do_file_open_root+0x2f6/0x5a0 fs/namei.c:4916
       file_open_root+0x1c6/0x3f0 fs/open.c:1355
       kernel_read_file_from_path_initns+0x189/0x260 fs/kernel_read_file.c:163
       fw_get_filesystem_firmware drivers/base/firmware_loader/main.c:549 [inline]
       _request_firmware+0x733/0x13c0 drivers/base/firmware_loader/main.c:873
       request_firmware+0x35/0x50 drivers/base/firmware_loader/main.c:948
       reg_reload_regdb+0x85/0x460 net/wireless/reg.c:1067
       genl_family_rcv_msg_doit+0x214/0x300 net/netlink/genetlink.c:1114
       genl_family_rcv_msg net/netlink/genetlink.c:1194 [inline]
       genl_rcv_msg+0x560/0x800 net/netlink/genetlink.c:1209
       netlink_rcv_skb+0x159/0x420 net/netlink/af_netlink.c:2556
       genl_rcv+0x28/0x40 net/netlink/genetlink.c:1218
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1900
       sock_sendmsg_nosec net/socket.c:775 [inline]
       __sock_sendmsg net/socket.c:790 [inline]
       ____sys_sendmsg+0xa4d/0xbe0 net/socket.c:2684
       ___sys_sendmsg+0x190/0x1e0 net/socket.c:2738
       __sys_sendmsg+0x160/0x210 net/socket.c:2770
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #5 (cb_lock){++++}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
       genl_rcv+0x19/0x40 net/netlink/genetlink.c:1217
       netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
       netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1345
       netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1900
       sock_sendmsg_nosec net/socket.c:775 [inline]
       __sock_sendmsg net/socket.c:790 [inline]
       sock_sendmsg+0x394/0x410 net/socket.c:813
       splice_to_socket+0xb3c/0x11a0 fs/splice.c:884
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0x109c/0x1f90 fs/splice.c:1349
       __do_splice+0x33b/0x370 fs/splice.c:1431
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice fs/splice.c:1616 [inline]
       __x64_sys_splice+0x187/0x250 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #4 (&pipe->mutex){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       pipe_lock fs/pipe.c:91 [inline]
       pipe_lock+0x69/0x80 fs/pipe.c:88
       iter_file_splice_write+0x1fd/0x10b0 fs/splice.c:682
       do_splice_from fs/splice.c:936 [inline]
       do_splice+0x109c/0x1f90 fs/splice.c:1349
       __do_splice+0x33b/0x370 fs/splice.c:1431
       __do_sys_splice fs/splice.c:1634 [inline]
       __se_sys_splice fs/splice.c:1616 [inline]
       __x64_sys_splice+0x187/0x250 fs/splice.c:1616
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (sb_writers#6){.+.+}-{0:0}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       percpu_down_read_internal include/linux/percpu-rwsem.h:53 [inline]
       percpu_down_read_freezable include/linux/percpu-rwsem.h:83 [inline]
       __sb_start_write include/linux/fs/super.h:19 [inline]
       sb_start_write include/linux/fs/super.h:125 [inline]
       mnt_want_write+0x6f/0x410 fs/namespace.c:494
       open_last_lookups fs/namei.c:4597 [inline]
       path_openat+0xad9/0x4280 fs/namei.c:4860
       do_file_open+0x20e/0x430 fs/namei.c:4892
       file_open_name+0x1c3/0x3e0 fs/open.c:1326
       filp_open+0x2e/0x50 fs/open.c:1343
       fsg_lun_open+0x6b/0x7b0 drivers/usb/gadget/function/storage_common.c:194
       fsg_store_file+0x1e7/0x450 drivers/usb/gadget/function/storage_common.c:455
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&common->filesem){+.+.}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       down_write+0x8b/0x1f0 kernel/locking/rwsem.c:1631
       fsg_store_file+0x193/0x450 drivers/usb/gadget/function/storage_common.c:452
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x302/0x4e0 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&p->frag_sem){.+.+}-{4:4}:
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       down_read+0x99/0x4c0 kernel/locking/rwsem.c:1574
       flush_write_buffer fs/configfs/file.c:205 [inline]
       configfs_write_iter+0x218/0x4e0 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x6ac/0x1050 fs/read_write.c:687
       ksys_write+0x12a/0x250 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&buffer->mutex){+.+.}-{4:4}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
       check_prevs_add kernel/locking/lockdep.c:3284 [inline]
       validate_chain kernel/locking/lockdep.c:3908 [inline]
       __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
       lock_acquire kernel/locking/lockdep.c:5868 [inline]
       lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
       configfs_read_iter+0x79/0x6f0 fs/configfs/file.c:86
       __kernel_read+0x397/0xad0 fs/read_write.c:532
       integrity_kernel_read+0x7e/0xb0 security/integrity/iint.c:28
       ima_calc_file_hash_tfm+0x25e/0x350 security/integrity/ima/ima_crypto.c:222
       ima_calc_file_hash+0x1e3/0x380 security/integrity/ima/ima_crypto.c:280
       ima_collect_measurement+0x94f/0xb30 security/integrity/ima/ima_api.c:300
       process_measurement+0xdfe/0x2350 security/integrity/ima/ima_main.c:425
       ima_file_check+0xc3/0x110 security/integrity/ima/ima_main.c:685
       security_file_post_open+0xc4/0x210 security/security.c:2755
       do_open fs/namei.c:4702 [inline]
       path_openat+0x985/0x4280 fs/namei.c:4863
       do_file_open+0x20e/0x430 fs/namei.c:4892
       do_sys_openat2+0x10f/0x1e0 fs/open.c:1368
       do_sys_open fs/open.c:1374 [inline]
       __do_sys_openat fs/open.c:1390 [inline]
       __se_sys_openat fs/open.c:1385 [inline]
       __x64_sys_openat+0x12d/0x210 fs/open.c:1385
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &buffer->mutex --> cb_lock --> &ima_iint_mutex_key[depth]

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ima_iint_mutex_key[depth]);
                               lock(cb_lock);
                               lock(&ima_iint_mutex_key[depth]);
  lock(&buffer->mutex);

 *** DEADLOCK ***

1 lock held by syz.3.4908/17817:
 #0: ffff8880741349a8 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: process_measurement+0x5ab/0x2350 security/integrity/ima/ima_main.c:319

stack backtrace:
CPU: 0 UID: 0 PID: 17817 Comm: syz.3.4908 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/16/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1c7 kernel/locking/lockdep.c:2043
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2175
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3165
 check_prevs_add kernel/locking/lockdep.c:3284 [inline]
 validate_chain kernel/locking/lockdep.c:3908 [inline]
 __lock_acquire+0x136c/0x1a40 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x1b9/0x370 kernel/locking/lockdep.c:5825
 __mutex_lock_common kernel/locking/mutex.c:646 [inline]
 __mutex_lock+0x1a4/0x1bd0 kernel/locking/mutex.c:821
 configfs_read_iter+0x79/0x6f0 fs/configfs/file.c:86
 __kernel_read+0x397/0xad0 fs/read_write.c:532
 integrity_kernel_read+0x7e/0xb0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm+0x25e/0x350 security/integrity/ima/ima_crypto.c:222
 ima_calc_file_hash+0x1e3/0x380 security/integrity/ima/ima_crypto.c:280
 ima_collect_measurement+0x94f/0xb30 security/integrity/ima/ima_api.c:300
 process_measurement+0xdfe/0x2350 security/integrity/ima/ima_main.c:425
 ima_file_check+0xc3/0x110 security/integrity/ima/ima_main.c:685
 security_file_post_open+0xc4/0x210 security/security.c:2755
 do_open fs/namei.c:4702 [inline]
 path_openat+0x985/0x4280 fs/namei.c:4863
 do_file_open+0x20e/0x430 fs/namei.c:4892
 do_sys_openat2+0x10f/0x1e0 fs/open.c:1368
 do_sys_open fs/open.c:1374 [inline]
 __do_sys_openat fs/open.c:1390 [inline]
 __se_sys_openat fs/open.c:1385 [inline]
 __x64_sys_openat+0x12d/0x210 fs/open.c:1385
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x115/0x870 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3adaf9de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3adbf33028 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f3adb225fa0 RCX: 00007f3adaf9de99
RDX: 0000000000000000 RSI: 0000200000000640 RDI: ffffffffffffff9c
RBP: 00007f3adb033eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f3adb226038 R14: 00007f3adb225fa0 R15: 00007ffd05bb3858
 </TASK>
syz_tun (unregistering): left allmulticast mode


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
