Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6F547F3C7
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 12:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792241481; cv=none; b=h2zG24ou7XcSWIMCI07mO9lXDMo9Tl3X70j+UlgnXStOH1fe+jZ95ydoiKB3tqf7HbcJ6fZCJR+L2bbndMXLa4QANwOGJhfPuNKDNrLp4iqAxOsLAWn84CXPb58zXpAnLz3gnSyx5xMi1xGb+rjClqlQ1YLsw3AtjVD6mPTQPpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792241481; c=relaxed/simple;
	bh=upGMgUD854NKHIOpLR+aC/wxCwRgDGAkCByC7Zomsek=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TiQWQYhxluLlEVmbH+XsfcXqzSO1a2aCRIDx7iJ1mopYdlPS12h17Q+pdHJVoJhUTyi5y8bXqv3FvAbdwQl7lYpK0BvJu3/LVArUfnHmVeTMUjqTMakZt8bxoeqf2PnvoR8xj8keeKQgKTzw0hUQ4+Fta7XI1N14iIu+rWzO8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-81b50ab16edso650907a34.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Oct 2026 05:51:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792241479; x=1792846279;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KM+nHAahhhDbaZJX1oLdaM/1E55uA3vWlwfNq/9qgmw=;
        b=QIEnHmhdHQn4V3Yp2omRwFewW70G1nCon7gFbkvYPIeZ1wUbyVjhjUzuaL/GID9lBW
         wLY9xZWiSWrYB482BkP5TapraBy/x6MprjkDIC78hk+39jOW5m1F1uJDbe5B3RG0tFX/
         MY3waTkc9a7j2VsSxhOo9WaecTK3Y9hWUpmKHurq89rwgYNXZhqvT1a/usB9JsAy2DiJ
         s7cL2I2wFyUe7f5oPTCPJrTgNVZAg7H9modUBq+C0d7/wuJLY2fzCcaI/rYdTEGIJPHv
         TGMVE9rMHzThJfB+Ke5ONVB/Kc8cK18up3dItcjynR82vyGMQFcM1Dw/G1kaaB+qTnCx
         yi0g==
X-Gm-Message-State: AFq9FYJNVDyrV2VPDJkg+nF5IgHHdNDsG3piU8Q7qMnZSizezR61rfDU
	fPqspWqryFzyGz99ap20Yx2C/boAE3pjG0msb1q1EIlBfmQDCQzs3oP7ablg0rEdwuaCwW28gFW
	SpGV6bXwpgqYiSFe7d+1gB4meXkU2ZR4TIeDtmPqG3cY8/cgy3n24x7orVUs=
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1489:b0:4fb:ac9b:b076 with SMTP id
 5614622812f47-53cd39dc078mr2257398b6e.67.1792241479500; Sat, 17 Oct 2026
 05:51:19 -0700 (PDT)
Date: Sat, 17 Oct 2026 05:51:19 -0700
In-Reply-To: <6ad16e43.7514cce4.1ece07.010d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad36f47.7952420f.283480.0362.GAE@google.com>
Subject: Re: [syzbot] [fs?] WARNING in V1_minix_truncate (2)
From: syzbot <syzbot+e353ad4408c4f9fac965@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    58161ead29e5 Merge tag 'drm-fixes-2026-10-17' of https://g..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10aa0f01580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ccb65e03706547e
dashboard link: https://syzkaller.appspot.com/bug?extid=e353ad4408c4f9fac965
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16da320d580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e353ad4408c4f9fac965@syzkaller.appspotmail.com

IO error syncing minix inode [loop0:00000008]
------------[ cut here ]------------
!buffer_uptodate(bh)
WARNING: fs/buffer.c:991 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:991, CPU#0: syz.0.603/7129
Modules linked in:
CPU: 0 UID: 0 PID: 7129 Comm: syz.0.603 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:991
Code: 4c 89 f7 e8 99 d3 d7 ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 34 44 fb ff e8 4f 57 65 ff eb 8c e8 48 57 65 ff 90 <0f> 0b 90 e9 a5 fd ff ff e8 3a 57 65 ff 90 0f 0b 90 e9 cf fd ff ff
RSP: 0018:ffffc90001c3f9f0 EFLAGS: 00010293
RAX: ffffffff8262cae8 RBX: ffff8880452da7e0 RCX: ffff888034fc0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: ffffc90001c3fb01 R08: ffff8880452da7e7 R09: 1ffff11008a5b4fc
R10: dffffc0000000000 R11: ffffed1008a5b4fd R12: ffff88800bf88566
R13: ffff88800bf885f0 R14: ffff88800bf88558 R15: 0000000000000017
FS:  00007f2982d386c0(0000) GS:ffff88808b0b4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2981deb8c0 CR3: 000000004669a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 free_data fs/minix/itree_common.c:272 [inline]
 truncate fs/minix/itree_common.c:321 [inline]
 V1_minix_truncate+0x310/0x10c0 fs/minix/itree_v1.c:61
 minix_truncate fs/minix/inode.c:750 [inline]
 minix_evict_inode+0x1c9/0x260 fs/minix/inode.c:52
 evict+0x624/0xb50 fs/inode.c:822
 minix_mkdir+0xdc/0x120 fs/minix/namei.c:136
 vfs_mkdir+0x40c/0x620 fs/namei.c:5409
 filename_mkdirat+0x285/0x510 fs/namei.c:5442
 __do_sys_mkdirat fs/namei.c:5463 [inline]
 __se_sys_mkdirat+0x35/0x150 fs/namei.c:5460
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2981d9e1d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2982d38028 EFLAGS: 00000246 ORIG_RAX: 0000000000000102
RAX: ffffffffffffffda RBX: 00007f2982025fa0 RCX: 00007f2981d9e1d9
RDX: 00000000000001c0 RSI: 0000200000000700 RDI: ffffffffffffff9c
RBP: 00007f2981e35888 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f2982026038 R14: 00007f2982025fa0 R15: 00007ffda9cc0648
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
