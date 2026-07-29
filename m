Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5919432570D
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 04:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785299190; cv=none; b=DeQcfpD8nNS2Af+m5Sz29NlRvrw6ZkVjVh9QYf/7rhwyKjVKvrFxeujxa1G1hZmGREIfVFdnATvSI7ALBll7ORSiLH4BIsm1bZXhzC1fwQs/BJJxNL/dUMYCaPo0gw3+SiV9g5VRkx8BZiqjr1Z6CBoEwoaP1T5MIlAa89LwtNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785299190; c=relaxed/simple;
	bh=CtOwH0bZoAyZkXDm7Fy/9LOKd5ZbKYnMzaN9n0WbAsc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n8zWDBjiTm86PeCJEH5m078UrnsF6DLmt0wbvaK6Wuaj1mzdn7KgDOtKM6LX/z5VNVYs1MBMq6zyeaF0QAtz0qX/w3WIodws2ELmyuc/CbH3/SLdFUrsEooGS/V6T7C8eB2vVevap+AHN71Y+6bkK/4xetUswYATiOCreBRsLis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-4959c49e054so285813b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 21:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785299186; x=1785903986;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HRKNZz+bzuEsUhZi18nlQKIKLFzgMHjmxoSZsbVcxJ4=;
        b=bBwLbBo2vrXxHzNTRJwMn2cU6a8UhtpAjDprtz2y9qJoT16LXMUIA62Rx4r18C80ZL
         4xwoA1BUEX/LYsdQ+B3PSiIyQt0CnqF/qN8ijLyGAjYCmvhhs0abBd596j/4fQ8NqDMu
         YEF7V7UIYTOE1nt1h1ccFUakbtmTLqm9PUXZrybaZKRD3tYBHQjGjPWt/2ZVcMslR/84
         FECecYH0Xk04Gao/l/FGgEO3prN0NWRPx4U2bUlUc6GuU4a1Of0BtNRTjBt+KY0DViwB
         rxjA1kHfzocc09y8999vbzUHwPtw1i+HhDoUypk4aOZS+F5tGpoXBuexFCRfMbGi9wpA
         jVKg==
X-Forwarded-Encrypted: i=1; AHgh+RrPoCxXesyOYlaJIsn4RzfaVo3JAwmtv5wgS5vtx8nf80iE+AsAVEta9H9C5Eh222+6SvkKaC74J1G60ZGD@vger.kernel.org
X-Gm-Message-State: AOJu0YwuIX5Ca7J8JZezRG6zq24I+n4WKr0ye4DEDU+QQfZ8BS645lsN
	DQ0wPhbDJO28oFjOj/4CNeHsC/KgT325XMs7kGN0mh1lLKDgfJwb5OEFBVwroqNJ1wdW5AUdR9Z
	tGbOyFIQNySzzeep0GGNyG+DYAhETor0+G/++SS4f9ge4lZVOOovLWhlvFMQ=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:bd1:b0:495:e251:945d with SMTP id
 5614622812f47-4ad5bd282ddmr2946572b6e.43.1785299186160; Tue, 28 Jul 2026
 21:26:26 -0700 (PDT)
Date: Tue, 28 Jul 2026 21:26:26 -0700
In-Reply-To: <6a697545.6bd615f2.c0aa.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a6980f2.d9e86bb5.297b12.0050.GAE@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in path_openat (5)
From: syzbot <syzbot+4c9318af45f0bf2af153@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3b5f4b83c4ab Merge tag 'for-7.2-rc5-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14a659b9580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=145fa60d73086782
dashboard link: https://syzkaller.appspot.com/bug?extid=4c9318af45f0bf2af153
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14bca49e580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117d51b9580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-3b5f4b83.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ed6d6b480fd7/vmlinux-3b5f4b83.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d5a591a74024/bzImage-3b5f4b83.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c9318af45f0bf2af153@syzkaller.appspotmail.com

Mass Storage Function, version: 2009/09/11
LUN: removable file: (no medium)
============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.0.17/5931 is trying to acquire lock:
ffff888022ef8450 (sb_writers#13){.+.+}-{0:0}, at: open_last_lookups fs/namei.c:4597 [inline]
ffff888022ef8450 (sb_writers#13){.+.+}-{0:0}, at: path_openat+0xad9/0x4280 fs/namei.c:4860

but task is already holding lock:
ffff888022ef8450 (sb_writers#13){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(sb_writers#13);
  lock(sb_writers#13);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by syz.0.17/5931:
 #0: ffff888022ef8450 (sb_writers#13){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:739
 #1: ffff88803c6e8480 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x76/0x4e0 fs/configfs/file.c:226
 #2: ffff888022ac4670 (&p->frag_sem){.+.+}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
 #2: ffff888022ac4670 (&p->frag_sem){.+.+}-{4:4}, at: configfs_write_iter+0x218/0x4e0 fs/configfs/file.c:229
 #3: ffff888026567120 (&common->filesem){+.+.}-{4:4}, at: fsg_store_file+0x193/0x450 drivers/usb/gadget/function/storage_common.c:452

stack backtrace:
CPU: 2 UID: 0 PID: 5931 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_deadlock_bug.cold+0xbd/0xca kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x1256/0x1a40 kernel/locking/lockdep.c:5237
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
RIP: 0033:0x7f4dab39de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcc2fe5d18 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f4dab625fa0 RCX: 00007f4dab39de99
RDX: 0000000000000002 RSI: 0000200000000f00 RDI: 0000000000000003
RBP: 00007f4dab433eaf R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f4dab625fac R14: 00007f4dab625fa0 R15: 00007f4dab625fa0
 </TASK>
mass_storage.usb0/lun.0: unable to open backing file: fi


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
