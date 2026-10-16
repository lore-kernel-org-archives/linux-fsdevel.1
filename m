Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E1A3E3D9E
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 07:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136069; cv=none; b=nrjtuD3VdjLlhjr3NuFD47vgmMK7a1OX0Bmg4+qHspCDlROAJlleFgyO3UK9NMDqVpP9ci87SgkvMl6YXUfdGJ2y1uwQe1zh7DPR7wx2m5tf6gWrTRJRhhdRkjhOJxT1BPXBe4sgKdHWAWIAByiVVTt71auzCi9Ikx8hS0zCPuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136069; c=relaxed/simple;
	bh=q5iUIWYW60cM0WPc202uqylYv2vTuJJuuMZPkex0ZoE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kf/UXGwwPZNrPbnd3nBSE6/knQR3l+ATawmTO0G72kKGI7FdWmTHnLS1R0VjsgRs1eEV4bPTd7xKabLlV1qumUcU8rrjlTOJeRELyrh2pU214jEmZbduLLhxTFp+CMwsqOqdJiBTRQEi5MuVis8xelbFBlq36JLzmtJZyWpLhK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4c467e19391so3720985b6e.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 00:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792136066; x=1792740866;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vM8+w6Df5oEiHBh7R/MMipDoTjRKtXIVMaP7vz7w6E4=;
        b=TqKZATommq5lpRzBzi/gOwskw41dGbE/dRkks2uef7Nge7E1YvQHpxw2Bokuj8OY/6
         awL4Ekg+7sDEzw6UVQaig09HdZKKYzWwSbSBVnsZijB3SapRg4NiqW3qjWTyQhQXNLhR
         N+DCW+SJXfTsJzyaIO9abotWkCbG38pOJsLJUq5+EK158nmPA4QMJnqm8OSOsxOUK0Wq
         27NJChkWbhTKrTsKUZvBWdoc5Osaea1ulO95EAP+VIiVo9TQ7HfySPVgIwMOaGZgg4v7
         0pJstJcrAw7NfPDY5JzA161meMFWjRHq7AN+fse13WgWEu9sK+gNUJE7XjkgAnmlpdoo
         grZQ==
X-Forwarded-Encrypted: i=1; AKwUvBwojR1DssU+v4LG8CVQsDrTSBMt7Vk2xywPblgbKkC93HThxgz7Vnm5NSDgCmmtEjF9ShD1+oJU9UbHhluz@vger.kernel.org
X-Gm-Message-State: AFq9FYLKlMKCYJqnC5qsXNaY7plua3qbL73MMlfYH9HfUoLGIYT4IztV
	LejM85qpo13UoGltcPyWfYMlPJj6gCriTF5ZRg8xKCvpXg6SzCiPLsTUWhB7a/AaO5mCS13xI6G
	8/obJm+JHvc6OtM7KPyyW16ukTGhRmVifUQC4dBd3fS6K/X5ad5pvK+ON6xc=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:198c:b0:4e6:cc78:edc1 with SMTP id
 5614622812f47-50c57b6e78bmr19127706b6e.42.1792136066417; Fri, 16 Oct 2026
 00:34:26 -0700 (PDT)
Date: Fri, 16 Oct 2026 00:34:26 -0700
In-Reply-To: <6a83a769.4d75e56a.c9a88.0007.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad1d382.7952420f.283480.021e.GAE@google.com>
Subject: Re: [syzbot] [fs?] possible deadlock in uvcg_extension_bm_controls_store
From: syzbot <syzbot+300213c2b5b55c0244f4@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, leitao@debian.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2f2f7eeef8b0 Merge tag 'soc-fixes-7.3-3' of git://git.kern..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17d6dfd1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4b098695335c89f
dashboard link: https://syzkaller.appspot.com/bug?extid=300213c2b5b55c0244f4
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1394be8e580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+300213c2b5b55c0244f4@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz-executor184/5998 is trying to acquire lock:
ffffffff90c14b28 (gadget_subsys.su_mutex){+.+.}-{4:4}, at: uvcg_extension_bm_controls_store+0xe4/0xb00 drivers/usb/gadget/function/uvc_configfs.c:1125

but task is already holding lock:
ffff888028accd70 (&p->frag_sem){++++}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
ffff888028accd70 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x238/0x430 fs/configfs/file.c:229

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&p->frag_sem){++++}-{4:4}:
       down_write_killable+0xa6/0x240 kernel/locking/rwsem.c:1643
       configfs_rmdir+0x3b0/0x950 fs/configfs/dir.c:1543
       vfs_rmdir+0x3e6/0x6a0 fs/namei.c:5544
       filename_rmdir+0x292/0x520 fs/namei.c:5601
       __do_sys_rmdir fs/namei.c:5624 [inline]
       __se_sys_rmdir+0x2e/0x140 fs/namei.c:5621
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&sb->s_type->i_mutex_key#25){++++}-{4:4}:
       down_write+0x96/0x200 kernel/locking/rwsem.c:1631
       inode_lock include/linux/fs.h:1024 [inline]
       configfs_depend_item_unlocked+0x153/0x420 fs/configfs/dir.c:1268
       usbg_make_tpg+0x1e0/0x550 drivers/usb/gadget/function/f_tcm.c:1692
       target_fabric_make_tpg+0xa8/0x6d0 drivers/target/target_core_fabric_configfs.c:947
       configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1369
       vfs_mkdir+0x40c/0x620 fs/namei.c:5439
       filename_mkdirat+0x285/0x510 fs/namei.c:5472
       __do_sys_mkdir fs/namei.c:5499 [inline]
       __se_sys_mkdir+0x34/0x150 fs/namei.c:5496
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (tpg_instances_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       tcm_alloc_inst+0x65/0x1a0 drivers/usb/gadget/function/f_tcm.c:2687
       try_get_usb_function_instance drivers/usb/gadget/functions.c:28 [inline]
       usb_get_function_instance+0xe3/0x2f0 drivers/usb/gadget/functions.c:44
       function_make+0x127/0x360 drivers/usb/gadget/configfs.c:626
       configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1369
       vfs_mkdir+0x40c/0x620 fs/namei.c:5439
       filename_mkdirat+0x285/0x510 fs/namei.c:5472
       __do_sys_mkdir fs/namei.c:5499 [inline]
       __se_sys_mkdir+0x34/0x150 fs/namei.c:5496
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (func_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       try_get_usb_function_instance drivers/usb/gadget/functions.c:18 [inline]
       usb_get_function_instance+0x2e/0x2f0 drivers/usb/gadget/functions.c:44
       function_make+0x127/0x360 drivers/usb/gadget/configfs.c:626
       configfs_mkdir+0x4f6/0x9e0 fs/configfs/dir.c:1369
       vfs_mkdir+0x40c/0x620 fs/namei.c:5439
       filename_mkdirat+0x285/0x510 fs/namei.c:5472
       __do_sys_mkdir fs/namei.c:5499 [inline]
       __se_sys_mkdir+0x34/0x150 fs/namei.c:5496
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (gadget_subsys.su_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3209 [inline]
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
       __mutex_lock_common kernel/locking/mutex.c:646 [inline]
       __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
       uvcg_extension_bm_controls_store+0xe4/0xb00 drivers/usb/gadget/function/uvc_configfs.c:1125
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x337/0x430 fs/configfs/file.c:229
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x612/0xba0 fs/read_write.c:687
       ksys_write+0x150/0x270 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  gadget_subsys.su_mutex --> &sb->s_type->i_mutex_key#25 --> &p->frag_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&p->frag_sem);
                               lock(&sb->s_type->i_mutex_key#25);
                               lock(&p->frag_sem);
  lock(gadget_subsys.su_mutex);

 *** DEADLOCK ***

locks held by syz-executor184/5998: 3, last CPU#1:
 #0: ffff88801e7d8460 (sb_writers#12){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2756 [inline]
 #0: ffff88801e7d8460 (sb_writers#12){.+.+}-{0:0}, at: vfs_write+0x22b/0xba0 fs/read_write.c:683
 #1: ffff888070770c80 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x7e/0x430 fs/configfs/file.c:226
 #2: ffff888028accd70 (&p->frag_sem){++++}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
 #2: ffff888028accd70 (&p->frag_sem){++++}-{4:4}, at: configfs_write_iter+0x238/0x430 fs/configfs/file.c:229

stack backtrace:
CPU: 1 UID: 0 PID: 5998 Comm: syz-executor184 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
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
 __mutex_lock+0x19d/0x1550 kernel/locking/mutex.c:821
 uvcg_extension_bm_controls_store+0xe4/0xb00 drivers/usb/gadget/function/uvc_configfs.c:1125
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x337/0x430 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa3e20116b7
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffcaf360150 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000055558f99e400 RCX: 00007fa3e20116b7
RDX: 0000000000000002 RSI: 00007fa3e204d174 RDI: 0000000000000003
RBP: 00007fa3e204fc38 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffcaf360230
R13: 000055558f99fdb0 R14: 000055558f99e3d8 R15: 000055558f9a7e4b
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
