Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A05369D74;
	Mon, 24 Aug 2026 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787563902; cv=none; b=KQDeaspHlpn4ADc4ln+AJ5SOxYV91dEi7HWN9bHuv1ChBfIMF3rz4bzElhjZbRp3MWN+wqT/p2WxCPwKZ9fHNPW7o65s5gd9nYPtx561PA++GHZTchDAqU22bAVTMKBarpWkF9KHnaS6eoMRCsjj9MrACA8fOrCZDpZ+c/VwsL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787563902; c=relaxed/simple;
	bh=xNNoyyzorQwzXZswV/S9IsKwLv1PWe1gfb87d67l/aU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ym3fgqqgLOMq/2sgjmbZUbMT8Ty1fsIpo8+NEOu5UAjxj5XhGVxcPcnulecQL7avDVqxDA6mXIlXbWd0/Eqr22DASb2SKiXKVr8wlKJUau76oPhJPdwvs/a2LHU0/x0qO0hoFbrcrnEvAHkNLO+KbbW7NVbiPGiqnDCC7yyecJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=dg/vEm5+; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=e3LRWN1g; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="dg/vEm5+";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="e3LRWN1g"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 7866526F765F;
	Mon, 24 Aug 2026 18:31:30 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1787563890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VjOFKDBaeWfHcp8XWnUq9Necguz8vdzoJtC88sHQZFQ=;
	b=dg/vEm5+wKcLObk7RCAauvWr8ovCMh6sG4jeXjHg4cNSqdViN8wrLFUGzeY9O+3HSO49bd
	f0r0e9A/6GX0Hq2Ozrtjjgfk3ekgw0Lro1dO6E7k7WZMQeEjDgWnd8zTNjcCh3A5uaJBz0
	/FPA9vk/oDOnfYgbvUCbqNDucIWAJBHAcG4wi6sH0/LiIpkDPS8wz3vpQDHcw2b3fcCZSe
	kfLou8ZWMzkWBwp3etYkGgGmEnEdpfo7SXCYshNvHRZYgE9QLqXeKj5zNssLRdym0FYPs3
	WBeMqQ+x6/7hyCX0w/vWv1K9dLjM+DXAj3tEL83IS2PAOwLUvaH8GS2JeKbQ4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1787563890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VjOFKDBaeWfHcp8XWnUq9Necguz8vdzoJtC88sHQZFQ=;
	b=e3LRWN1gINigFK24Q515uRVlHHZdZ1osrpT8htEM6T6GyV58mYN6gVcvRRUGCXDJHgZ+FV
	Bgw8eGce1qco1cBQ==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id F3412E001BC;
	Mon, 24 Aug 2026 18:31:29 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id E961A22000D2; Mon, 24 Aug 2026 18:31:29 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linkinjeon@kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  sj1557.seo@samsung.com,
  syzkaller-bugs@googlegroups.com
Subject: Re: Please drop 64d9183203eeb in mm-nonmm-unstable ([syzbot]
 [exfat?] WARNING in fat_ent_write)
In-Reply-To: <6a8bf715.dbb3a75c.13dd47.0065.GAE@google.com>
References: <6a8bf715.dbb3a75c.13dd47.0065.GAE@google.com>
Date: Mon, 24 Aug 2026 18:31:29 +0900
Message-ID: <875x0z6f0u.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/fs/fat/misc.c?h=mm-nonmm-unstable&id=64d9183203eebe33de6188b70a8c1e91f52885db (fat: restore original value when fat_ent_write failed)

This commit was missing to consider about the path of error by sync
write.  Since current bh write clears uptodate flag if got I/O error, so
this patch doesn't work for now with wait==true.

Please drop this patch at least until stop clearing the uptodate by bh
sync write and buffer is reusable after the error.

Thanks.

syzbot <syzbot+26461e903494e689c24f@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    6a746cd265ae Add linux-next specific files for 20260819
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13cdee79580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4a1369648c551bbe
> dashboard link: https://syzkaller.appspot.com/bug?extid=26461e903494e689c24f
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17760e79580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/32d71a199871/disk-6a746cd2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7bfb88f0043e/vmlinux-6a746cd2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4bc2ab35db01/bzImage-6a746cd2.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/500a74ccb5d4/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17e3d679580000)
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+26461e903494e689c24f@syzkaller.appspotmail.com
>
>          and is ignored by this kernel. Remove the mand
>          option from the mount to silence this warning.
> =======================================================
> Buffer I/O error on dev loop0, logical block 1, lost sync page write
> ------------[ cut here ]------------
> !buffer_uptodate(bh)
> WARNING: fs/buffer.c:991 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:991, CPU#1: syz.0.17/5854
> Modules linked in:
> CPU: 1 UID: 0 PID: 5854 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:991
> Code: 4c 89 f7 e8 09 0a d8 ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 74 52 fb ff e8 4f 40 68 ff eb 8c e8 48 40 68 ff 90 <0f> 0b 90 e9 a5 fd ff ff e8 3a 40 68 ff 90 0f 0b 90 e9 cf fd ff ff
> RSP: 0018:ffffc9000345f2d0 EFLAGS: 00010293
> RAX: ffffffff825f7f28 RBX: ffff8880714019a0 RCX: ffff8880317c5dc0
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
> RBP: dffffc0000000001 R08: ffff8880714019a7 R09: 1ffff1100e280334
> R10: dffffc0000000000 R11: ffffed100e280335 R12: ffffffff8c288c60
> R13: ffff888032a9c248 R14: dffffc0000000000 R15: ffff8880717c46a8
> FS:  00007fc05a3146c0(0000) GS:ffff888124dda000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9293991000 CR3: 000000007992c000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  mmb_mark_buffer_dirty+0x2c/0x1f0 fs/buffer.c:624
>  fat_ent_write+0xb8/0x190 fs/fat/fatent.c:422
>  fat_chain_add+0x409/0x8e0 fs/fat/misc.c:140
>  fat_add_cluster fs/fat/inode.c:113 [inline]
>  __fat_get_block fs/fat/inode.c:155 [inline]
>  fat_get_block+0x768/0xae0 fs/fat/inode.c:190
>  __block_write_begin_int+0x6c2/0x1900 fs/buffer.c:2030
>  block_write_begin fs/buffer.c:2144 [inline]
>  cont_write_begin+0x71b/0xac0 fs/buffer.c:2506
>  fat_write_begin+0x7a/0x150 fs/fat/inode.c:230
>  cont_expand_zero fs/buffer.c:2434 [inline]
>  cont_write_begin+0x2d6/0xac0 fs/buffer.c:2496
>  fat_write_begin+0x7a/0x150 fs/fat/inode.c:230
>  generic_perform_write+0x2d5/0x8f0 mm/filemap.c:4374
>  generic_file_write_iter+0xae/0x330 mm/filemap.c:4517
>  new_sync_write fs/read_write.c:595 [inline]
>  vfs_write+0x612/0xba0 fs/read_write.c:687
>  ksys_pwrite64 fs/read_write.c:794 [inline]
>  __do_sys_pwrite64 fs/read_write.c:802 [inline]
>  __se_sys_pwrite64 fs/read_write.c:799 [inline]
>  __x64_sys_pwrite64+0x196/0x220 fs/read_write.c:799
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc05939e0d9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc05a314028 EFLAGS: 00000246 ORIG_RAX: 0000000000000012
> RAX: ffffffffffffffda RBX: 00007fc059625fa0 RCX: 00007fc05939e0d9
> RDX: 000000000000fdef RSI: 0000200000000140 RDI: 0000000000000004
> RBP: 00007fc059435024 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000000000fecc R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fc059626038 R14: 00007fc059625fa0 R15: 00007fff03653f68
>  </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
