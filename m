Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79ECD385D66
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225446; cv=none; b=AJVbm+Y+7S6a1vtwoXJl1i4wEp62wMWX/esi+7ECjEZlc9AYta/ZR+37d/U4k+weFJecd87fj0qDUlahkPi31wCwU9cTYct9ZGu3dNo5xi+C0Tisq9e9ZTbz26CSBNSYtGKzYtI4GMD9rNyJB1X3zNe8+iR+zFqCBirGsjMa9ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225446; c=relaxed/simple;
	bh=kG7WwYql12A3u53CMKE8vxiNlPK40OIiDoSe+WXllqI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=G7V7Xiw15rNEMc+KvEydY82+gy3XvboqRYYmL7otSxGU5wB15tKJCqqE0RzIoPFCiN7y3PSli5RdNB9Eufs3JX+inYoM2ZKurQeoZBS6ImLkR9triP6/HqJaZfhQ/eDAnQTMYHJQ7gUL9EB01gfw4z3JKhYu/a2v2+j5xLOM+os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-48b61eabb4cso6985847b6e.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 07:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782225444; x=1782830244;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BHZcvnSPzHj34ZJ/mcgVfc5dMIdapQHiQfyHhonThY=;
        b=hhlTL1W1X5XOGcax/VbEelBIciWrcRATKPpC9rpzxFvry9y61Pvg9zrqB9bDQapaLe
         +jxQwoS0dV+Gm/Ja66KgynReEMWMZpjqK5WSm/gpqjFvrYy08Hj9xZZpfBbLutJoNE8W
         N4xKvGU9+LCHbr0XdV0plTCIdY4ojS4x1uWY7j4lMT9hjp6+rvfZTc/q6sgJlNbjzZF/
         GLxHerNJapT+y5O8VYr3xu3jKvK4svOdxzkyxtBSeCLNm1kSl6+27DyhZ0uHlaA1npwd
         +v0fcL54N6+Wi65QhvppzmVk1f8Jo2VG5HgCLoG0crA4IzwVKUClG+ni3wFA2IdOb89N
         zIug==
X-Forwarded-Encrypted: i=1; AFNElJ/RZMKhhmoC7ZdQ908DWxpV8tZmBrECNtmetjTy34yoRajmeHT4DxMmFoyJkS29p/bB9YL6BuNNgiMJy6GM@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkwzBsH96EGI18fCh2nrzia9yFk/XpU1lrA3QWHj/pBwK7A7g
	PijrxV/zc1wJ7Y3gItlHO5xiS6ryMf6A5UYPH77C2wEk+Rx3GPxm2jQ4bkv9hD91sRsb2PimgCl
	BKHgQ9nhWwAozc4xXFUlxkhqnJKzyFNWHe+bAEA6haQiQYn3ZQThVp482BX0=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3508:b0:48b:f341:113c with SMTP id
 5614622812f47-48f62c2d046mr1564778b6e.37.1782225444266; Tue, 23 Jun 2026
 07:37:24 -0700 (PDT)
Date: Tue, 23 Jun 2026 07:37:24 -0700
In-Reply-To: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a3a9a24.ac26f6c2.9a9c4.0005.GAE@google.com>
Subject: [syzbot ci] Re: namespace-aware configfs
From: syzbot ci <syzbot+ciba837a74ccbd374c@syzkaller.appspotmail.com>
To: a.hindborg@kernel.org, brauner@kernel.org, hare@kernel.org, hch@lst.de, 
	jack@suse.cz, kch@nvidia.com, leitao@debian.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, sagi@grimberg.me, viro@zeniv.linux.org.uk
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v3] namespace-aware configfs
https://lore.kernel.org/all/20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org
* [PATCH RFC v3 01/12] fs/configfs: rework configfs_is_root()
* [PATCH RFC v3 02/12] fs/configfs: dynamically allocate super_info
* [PATCH RFC v3 03/12] fs/configfs: separate out configfs_{link,unlink}_root()
* [PATCH RFC v3 04/12] fs/configfs: add superblock as attribute to configfs_pin_fs()
* [PATCH RFC v3 05/12] fs/configfs: add 'fill_subsystem' and 'clear_subsystem' callbacks
* [PATCH RFC v3 06/12] fs/namespace: implement mnt_clone_direct()
* [PATCH RFC v3 07/12] fs/configfs: switch to get_tree_keyed()
* [PATCH RFC v3 08/12] fs/configfs: open-code simple_pin_fs()
* [PATCH RFC v3 09/12] nvmet: make discovery subsystem dynamic
* [PATCH RFC v3 10/12] nvmet: per net-namespace port list
* [PATCH RFC v3 11/12] nvmet: make configfs setup namespace aware
* [PATCH RFC v3 12/12] nvmet: enable transports for net namespaces

and found the following issue:
BUG: sleeping function called from invalid context in configfs_get_super_info

Full report is available here:
https://ci.syzbot.org/series/f460be5a-d520-4bc1-9cfb-6492f841629b

***

BUG: sleeping function called from invalid context in configfs_get_super_info

tree:      bpf-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git
base:      66affa37cfac0aec061cc4bcf4a065b0c52f7e19
arch:      amd64
compiler:  Debian clang version 22.1.6 (++20260514074242+fc4aad7b5db3-1~exp1~20260514074407.73), Debian LLD 22.1.6
config:    https://ci.syzbot.org/builds/73803fa0-5ba4-4d03-976f-f9962ee982c8/config
syz repro: https://ci.syzbot.org/findings/4102267c-e678-4ffc-9ac0-4fb2dcbe5c0d/syz_repro

BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:323
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5856, name: syz.0.17
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 UID: 0 PID: 5856 Comm: syz.0.17 Tainted: G        W           syzkaller #0 PREEMPT(full) 
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x378/0x4d0 kernel/sched/core.c:9193
 might_alloc include/linux/sched/mm.h:323 [inline]
 slab_pre_alloc_hook mm/slub.c:4559 [inline]
 slab_alloc_node mm/slub.c:4916 [inline]
 __kmalloc_cache_noprof+0x74/0x660 mm/slub.c:5446
 _kmalloc_noprof include/linux/slab.h:969 [inline]
 _kzalloc_noprof include/linux/slab.h:1286 [inline]
 configfs_get_super_info+0x218/0x5e0 fs/configfs/mount.c:91
 configfs_get_tree+0x41/0xd0 fs/configfs/mount.c:170
 vfs_get_tree+0x92/0x2a0 fs/super.c:1694
 vfs_cmd_create+0xa2/0x200 fs/fsopen.c:231
 __do_sys_fsconfig fs/fsopen.c:463 [inline]
 __se_sys_fsconfig+0x6b9/0x810 fs/fsopen.c:350
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5c9db9ce59
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5c9ea71028 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 00007f5c9de15fa0 RCX: 00007f5c9db9ce59
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
RBP: 00007f5c9dc32e6f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5c9de16038 R14: 00007f5c9de15fa0 R15: 00007ffe63465d98
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

To test a patch for this bug, please reply with `#syz test`
(should be on a separate line).

The patch should be attached to the email.
Note: arguments like custom git repos and branches are not supported.
