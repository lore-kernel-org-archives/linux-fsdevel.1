Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795850495;
	b=Bq/+4mcXHwyYyqCtjKMf04tsJQzkcxwwsfyC6GixHdj35PkwGWt4RWrWs3LRRW039EMm
	 K/tFEPKD+REIenFCfdjxcwMt7i7g/Jn7UlA0YWzDQhMOn4hBEhf06MYHxuFZW3kC7gZMo
	 mDlzd9+M6iK6a1H1cHBUmOHs2z3/iiBexAG0YOqJHvU+z1/bTyN/Dh1NKTqbyZKBJKifY
	 9PYw2Dw2tRjpsFisg6+eYR+JRZRnPgScMnh42F2K0HxiY0qJv9qDihBP9Sv9DkAPDfeCs
	 TVjXd588b9cHOJq3pgjjcB9y6MvO4GLlp53xfJqbKG/wEbHk5HM6Xs5mYBJaNMI7mwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795850495;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=u3YnEfSpBa8GXAsmJOqVgSfPCQe9iVa1OjCJNB3v9Ls=;
	b=MvJVmgjOOb9ZKZZehFWLCA/QiJHnDP2mr1GtOYG11tVGJa3jk1b5dPHnzIoIFFY+qKWE
	 6StZlQHdk8NK34Rx72xK/ik4QpB0n2+9V0GXOZxNqQN63RR3b3MhDUEkI+dQX1t/1aOXG
	 LYO6WYr73Kze5VXoMlhn8bDoROWA1wtY1IrjLElaWV8NEHQ8MKLgUXLVVjE10yWlb4tao
	 Pfb60EzSaTGnTdxn6LpyhIRjTu+C3LbnxLY3GHTRdScDkGouIxvH8fUGf0aX5ljDRqFu0
	 ibR84sRUb33gNw5ZpkPu6DfA9P3SH3OwQHs3ZSHyy3OyuLz+lDVpqtne5SNcyISLIkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.160.69
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFDD606A31F
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Nov 2026 07:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EFDD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-45e6091d8a1so6153013fac.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 23:21:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795850494; x=1796455294;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u3YnEfSpBa8GXAsmJOqVgSfPCQe9iVa1OjCJNB3v9Ls=;
        b=apmREgtIYb4NYm+1ZnkZH0xkYGr0/wDBZ6UM4iPAFmH8KtXycP8joVVA7OC5yhmnV3
         8s1lk0Iz34QSysssJXY+JWly1ak3A9PlpvG8yIC6q+DksQ8arymifNstQ9wFK9j32vSw
         BbH7eYLuJdPjpkHaNWvlpwEUBIAoWCJSBciejmZOtMSAafET0V67wseNzaSZOXjMd2iY
         g7h7G1C3MVbpKTszV3PuSqpwEoYLfS1LV0KIpTBEjci48aIx1bLnmaF2J68q+8xy4dXV
         7hRo47d4huvDLvzNj9VhmKoaVfeSI4dRpcCEsO5913xhTM4JwE4Xb0npYWp/Z4mnyCFa
         OQqA==
X-Forwarded-Encrypted: i=1; AL+hErEMg/JW0uNLPOQRHRZSeE7NO7So2JjitsiZiERW+h75vJPYzqGQjqCYcmlWWIVfDMa+8lYKKcmXj20aL3In@vger.kernel.org
X-Gm-Message-State: APuU4Z/XfHcyA4hmnmSqpM5ZSYdM2ATVVAsuAYNoGWne6xrbw/PdCQnf
	YROzA8wiBmUDMenO81G1o2wc091gTTtQSNd19qRZa2EXlDXtoS0QaIW1RSM5QzhazFSUlQp+xo1
	ZoKY5KnKj8tsqoMPFSAestQwWNXda0cfUOCGEYaTwS2qWnDHRVo2+RbVUydM=
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:30a7:b0:4f7:a3f2:d8b4 with SMTP id
 5614622812f47-57a0caddaedmr28732716b6e.65.1795850494592; Fri, 27 Nov 2026
 23:21:34 -0800 (PST)
Date: Fri, 27 Nov 2026 23:21:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b0a80fe.8ccee5ca.1045fd.028c.GAE@google.com>
Subject: [syzbot] [fs?] KCSAN: data-race in proc_invalidate_siblings_dcache / proc_pid_evict_inode
From: syzbot <syzbot+c477bc599c896b5de237@syzkaller.appspotmail.com>
To: adobriyan@gmail.com, akpm@linux-foundation.org, brauner@kernel.org, 
	jack@suse.cz, jannh@google.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sforshee@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9437ee8b6cf6 Merge tag 'net-7.4-rc5' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13557865580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dc99102739636b09
dashboard link: https://syzkaller.appspot.com/bug?extid=c477bc599c896b5de237
compiler:       Debian clang version 22.1.8 (1~deb13u5), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a18388c9db19/disk-9437ee8b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a8415136a96e/vmlinux-9437ee8b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/594b09b51c9a/bzImage-9437ee8b.xz

AI-generated root cause summary:
proc_invalidate_siblings_dcache() in fs/proc/inode.c reads the RCU-protected
hlist head using hlist_first_rcu(inodes) directly without wrapping it in
rcu_dereference() (or holding the list spinlock). Because hlist_first_rcu() is a
plain pointer dereference rather than an atomic/RCU load, this creates an
unmarked read on pid->inodes.first that races with marked writes
(WRITE_ONCE(*pprev, next)) in __hlist_del() when proc_pid_evict_inode() unlinks
a sibling inode under pid->lock.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=c477bc599c896b5de237

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c477bc599c896b5de237@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in proc_invalidate_siblings_dcache / proc_pid_evict_inode

write (marked) to 0xffff8881048a01d0 of 8 bytes by task 6951 on cpu 0:
 __hlist_del include/linux/list.h:1045 [inline]
 hlist_del_init_rcu include/linux/rculist.h:238 [inline]
 proc_pid_evict_inode+0x7c/0xd0 fs/proc/base.c:1918
 proc_evict_inode+0x45/0xa0 fs/proc/inode.c:41
 evict+0x301/0x570 fs/inode.c:829
 iput_final fs/inode.c:2036 [inline]
 iput+0x44f/0x5d0 fs/inode.c:2085
 dentry_unlink_inode+0x29a/0x2b0 fs/dcache.c:510
 dentry_kill+0x135/0x4f0 fs/dcache.c:857
 finish_dput+0x9f/0x1d0 fs/dcache.c:1032
 dput+0x43/0x50 fs/dcache.c:1073
 proc_invalidate_siblings_dcache+0x1e6/0x2c0 fs/proc/inode.c:143
 proc_flush_pid+0x1d/0x30 fs/proc/base.c:3457
 release_task+0xa0c/0xba0 kernel/exit.c:292
 exit_notify kernel/exit.c:781 [inline]
 do_exit+0xd64/0x1530 kernel/exit.c:992
 do_group_exit+0xfe/0x140 kernel/exit.c:1123
 get_signal+0xc49/0xd30 kernel/signal.c:3113
 arch_do_signal_or_restart+0x96/0x480 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:66 [inline]
 exit_to_user_mode_loop+0x161/0x940 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
 do_syscall_64+0x23b/0x3a0 arch/x86/entry/syscall_64.c:107
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

read to 0xffff8881048a01d0 of 8 bytes by task 5112 on cpu 1:
 proc_invalidate_siblings_dcache+0x2a/0x2c0 fs/proc/inode.c:114
 proc_flush_pid+0x1d/0x30 fs/proc/base.c:3457
 release_task+0xa0c/0xba0 kernel/exit.c:292
 wait_task_zombie kernel/exit.c:1285 [inline]
 wait_consider_task+0x1131/0x1630 kernel/exit.c:1512
 do_wait_thread kernel/exit.c:1575 [inline]
 __do_wait+0xf1/0x500 kernel/exit.c:1693
 do_wait+0xc9/0x2c0 kernel/exit.c:1727
 kernel_wait4+0x19f/0x210 kernel/exit.c:1886
 __do_sys_wait4 kernel/exit.c:1914 [inline]
 __se_sys_wait4 kernel/exit.c:1910 [inline]
 __x64_sys_wait4+0x91/0x120 kernel/exit.c:1910
 x64_sys_call+0x108f/0x2550 arch/x86/include/generated/asm/syscalls_64.h:62
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x11e/0x3a0 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffff8881071611b0 -> 0xffff88810718e530

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 5112 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(lazy) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
==================================================================


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
