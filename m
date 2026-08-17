Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5B13B42E4;
	Mon, 17 Aug 2026 06:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949462; cv=none; b=mxQy2qhWB3ssRSxlcT+kPk03woIaDLz8A3nRPeL6Xh0RajdnmTITzf5xfraHfBKtIG6rRxMXED59w5jFAKF/9JMB0rfqqzbn5NT8hjhVpbpwoRvnYgtRTg55JwfBoUcBLCyb8W0AqISR/aDJrwb5ox6831qLKT9Uv1v29SOOlcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949462; c=relaxed/simple;
	bh=53ioWQD8Nj6W2+Rlv2XGWmKk1WDx8BWfqLTqpbInbe8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KAfNOz8hDSN9Y6EuuhntGJrZuABSmEVSKuk//69o5oyF8AWpGDRL4WBCIp3ryGMre22kglDKk+WE8rIzxcrJT4NP53SgqzlXQ4+wSGQoHpR0/+JW3Ru1Vp4BPFZlti2dOOb59ChbQsbNQt9LRNCilyROUmkyiq1fW/VGjNydyWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=jv/OWo1l; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=UG42lHq9; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="jv/OWo1l";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="UG42lHq9"
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 4BB0426F7696;
	Mon, 17 Aug 2026 15:50:55 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1786949455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diCS6E/HGSdIhQ1xmvM8jwLpmywn+U3lB9gBgzjc9vA=;
	b=jv/OWo1lmR3N48PYuO1uzoIDrxz7E+rqR9GnmRUCGF1rgDODh/GgWGb8gqHo3DqH+Sgl31
	fGUzz4rEbX5ZE/ShELffOe/eiZoNVyVWGsORu8FH78h1hQCAD7rFaO33sHtfffoIFs4G6z
	dUfb2GGnaZQfNLTVvCkBycWMp4qD5Zv2sG53xuexeKN2mvvDFv0PeMk4qilaYUFjgMBnuD
	0uQ4qHlW7CdqQ2nEwC+CQbcS2u1N9LNzlMDztXmxLJjjRRQSZUsEnOPR4y+hlY6IoZvNw3
	KQthXS+HaweulLjdseCAHA4mTzKhAguzQvCZQC3b8ESRKMhmZ6ay3WvYeJmnPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1786949455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=diCS6E/HGSdIhQ1xmvM8jwLpmywn+U3lB9gBgzjc9vA=;
	b=UG42lHq9ANYXaiMX4waPvmE4WVWxUuvbAOVvgmXLZ7hUFhXDGfs3nIXz1BuFv1JV3BQKoC
	0Gp7+6khbuJ0ZFDw==
Received: from devron.myhome.or.jp (devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (Postfix) with ESMTPS id 81917E000DB;
	Mon, 17 Aug 2026 15:50:54 +0900 (JST)
Received: by devron.myhome.or.jp (Postfix, from userid 1000)
	id 7698222000A1; Mon, 17 Aug 2026 15:50:54 +0900 (JST)
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yemu Lu <prcups@krgm.moe>, Ren Wei <n05ec@lzu.edu.cn>, syzbot
 <syzbot+e64c6472a3d96a75172a@syzkaller.appspotmail.com>,
 linkinjeon@kernel.org,  linux-fsdevel@vger.kernel.org,
  linux-kernel@vger.kernel.org,  sj1557.seo@samsung.com,
  syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] WARNING in fat12_ent_put
In-Reply-To: <6a826ec2.dbb3a75c.20434b.003e.GAE@google.com>
References: <6a826ec2.dbb3a75c.20434b.003e.GAE@google.com>
Date: Mon, 17 Aug 2026 15:50:54 +0900
Message-ID: <874igti6k1.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

syzbot <syzbot+e64c6472a3d96a75172a@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    28d012efb432 Add linux-next specific files for 20260812
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=104eec79580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5a13c7bc480b5c3f
> dashboard link: https://syzkaller.appspot.com/bug?extid=e64c6472a3d96a75172a
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/de882be6df4b/disk-28d012ef.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/412cb9fb7e2d/vmlinux-28d012ef.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9d7096c27f1b/bzImage-28d012ef.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e64c6472a3d96a75172a@syzkaller.appspotmail.com

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/fs/fat/misc.c?h=mm-nonmm-unstable&id=64d9183203eebe33de6188b70a8c1e91f52885db (fat: restore original value when fat_ent_write failed)

This commit was missing to consider about the path of error by sync
write.  Since current bh write clears uptodate flag if got I/O error, so
this patch doesn't work for now with wait==true.

Please drop this patch at least until stop clearing the uptodate by bh
sync write and buffer is reusable after the error.

Thanks.

> Buffer I/O error on dev loop0, logical block 1, lost sync page write
> ------------[ cut here ]------------
> !buffer_uptodate(bh)
> WARNING: fs/buffer.c:991 at mark_buffer_dirty+0x299/0x410 fs/buffer.c:991, CPU#1: syz.0.824/10458
> Modules linked in:
> CPU: 1 UID: 0 PID: 10458 Comm: syz.0.824 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> RIP: 0010:mark_buffer_dirty+0x299/0x410 fs/buffer.c:991
> Code: 4c 89 f7 e8 49 11 d8 ff 49 8b 3e be 40 00 00 00 5b 41 5c 41 5e 41 5f 5d e9 34 53 fb ff e8 9f a3 69 ff eb 8c e8 98 a3 69 ff 90 <0f> 0b 90 e9 a5 fd ff ff e8 8a a3 69 ff 90 0f 0b 90 e9 cf fd ff ff
> RSP: 0018:ffffc900065273f8 EFLAGS: 00010287
> RAX: ffffffff825e07c8 RBX: ffff888056e9e460 RCX: 0000000000080000
> RDX: ffffc90003f49000 RSI: 0000000000001234 RDI: 0000000000001235
> RBP: dffffc0000000001 R08: ffff888056e9e467 R09: 1ffff1100add3c8c
> R10: dffffc0000000000 R11: ffffed100add3c8d R12: dffffc0000000000
> R13: 1ffff92000ca4eb6 R14: ffffc900065275b0 R15: ffff888050e4ccf8
> FS:  00007fe3dc5436c0(0000) GS:ffff888124dfc000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2e6edff8 CR3: 000000007c12c000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  mmb_mark_buffer_dirty+0x2c/0x1f0 fs/buffer.c:624
>  fat12_ent_put+0x1b7/0x2f0 fs/fat/fatent.c:173
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
>  generic_cont_expand_simple+0x146/0x210 fs/buffer.c:2397
>  fat_cont_expand+0x61/0x1f0 fs/fat/file.c:226
>  fat_fallocate+0x22f/0x2f0 fs/fat/file.c:304
>  vfs_fallocate+0x65a/0x7e0 fs/open.c:338
>  ksys_fallocate fs/open.c:362 [inline]
>  __do_sys_fallocate fs/open.c:367 [inline]
>  __se_sys_fallocate fs/open.c:365 [inline]
>  __x64_sys_fallocate+0xbf/0x110 fs/open.c:365
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fe3db59e0d9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fe3dc543028 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
> RAX: ffffffffffffffda RBX: 00007fe3db825fa0 RCX: 00007fe3db59e0d9
> RDX: 0000000000000009 RSI: 0000000000000000 RDI: 0000000000000004
> RBP: 00007fe3db635024 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000010001 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fe3db826038 R14: 00007fe3db825fa0 R15: 00007fffaef17d98
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
