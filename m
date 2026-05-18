Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B350A38655E
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 18:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779130781; cv=pass; b=WrWdpbSHEQ2IOwjVFULVhXfca3M+lriSRSqmB7lXViQkymVJVMYSvkkNdV1BIQgVuLej9Bf63qnRjh+8p6XvO5q4LqPZD8Nln5WmVCExrNC+QIzRjSNceCwB51rGogiPbOh/z513cAcNG4wkFmrLZgTxraMzljGy3kkAxQYkvgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779130781; c=relaxed/simple;
	bh=b2lAhot6ng6eL4rkK5xrSXS0ftQrEDhNh78ErOvf5zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGV5pRoXXfOhwO1CUXghfIbvsvCqVCnR+KXdRLk4i2J+Q9nn41Qp2qt9Sftjan2y/6+x2exu5wyEp3p97bj9Zqaodu9l65XzAABD+9u1eWx1DP0ab0MucazPx09a30SSUMZHbFMCxr+einW1gZ4oU9KwTO1GTP4qTqVPaWcnAMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WdVPexYt; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdVPexYt"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a877510541so3172506e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 11:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779130778; cv=none;
        d=google.com; s=arc-20240605;
        b=Bx7/DAjIyB53wAgqr56Eq1y/pOw27d3vw09fzlhVZd2LTeyo1sUETy/7OjVT6Yfz/U
         siGbWZW9spAL6EVWX2vjrw3OQuWP5J+miXZl2psODlIrPIsDTnZA6POYLHFpCkZNFbVc
         n4eb39z40LBdh+as08lmYi72h2+30JtCcgzh12e6Yb6Xz+aQC5j3MbsYhwBgkLIEBM55
         BfRIZJ8KIQrZZLxstCl3Cpf7nHCGawLi1F6GRcyPW3AindapwB4lI10Cd0vSzBrRBQdE
         /3xT41AYszNuqiAOPD2B2lKbek8onBZKLlu7RRowffaogihicsJ2kpEcMhRWqbm+CKIP
         1ZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KKuUgjXLowe+5VjKlz0MyLmtkzK1hn0UjWkThF9nJd8=;
        fh=BOmBODs/6VeD6Dpow2dAK0rtQrlA3hs3w7uBaOQbEf4=;
        b=Tt6Y6YbSEEjblDKQ2dZcW00Ey0UtNsAbeJ1zc9q7J+n4Itd2zfQql7a7wWX6ZxmU0b
         0f09Zghv3pN8iAQJyfxO4Bx/uUEWHPAGRGgkAjyRx3n02g84Jys50obP/QIMUK7V0mRo
         IKzG73LZ4Q95x+IpZjNJAS8Nal9RbOwSoeuN2cl/mZ8YezusTbJ4SKOzsxm6qFFqbrsv
         3LOpuIjZZIwTmzdS93PUTU714AvcPCPsR4SUqGYa1zNPfWmJPoyaRA/R/ukLflyXG05G
         Bk+jvfYHg7xdDWx8jvmBF0f+KJdeuR8uwwAWtyBHtBPm1XbPpmGlKsI6o/rMV9npzqlU
         9+BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779130778; x=1779735578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KKuUgjXLowe+5VjKlz0MyLmtkzK1hn0UjWkThF9nJd8=;
        b=WdVPexYtWB8Mh78IfGt52P+2e4MEbPeCqlxoa2h4Us/wT/mFWPRbUipBS+DrBNujHp
         PUoMD69auPbjnBpaYNS+FQzychDA0RlBULR3TyDBp/tD0/yJfIHBVCGdb6ahUlXy+08V
         i/ZZuNOJa7hmefkye7XrRVQeBvMIEpc9CQolrlp2dKrEadHMnaHRT2qmS21xoXtleseI
         AoFgJeQ352jgmge/n4ADrlLWjQInShgwMYSzLDMNyqbgFUxiXrc7TCA65482IAu6OTHQ
         29eWzImj0vmucblS3BuoqgztHPHw0N4fcZvdwbLEO+/t6H7Kp8/W4Hu9sDgtYj+oSian
         xQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779130778; x=1779735578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKuUgjXLowe+5VjKlz0MyLmtkzK1hn0UjWkThF9nJd8=;
        b=i3WGiejCJrKEFTqjkbgqlwH62En7eR3qupmZ6Ank0USYwmDG8qi7gkwM8NpyhYO4GO
         1kvpb08D9qK5HsDawqxkiJvtxeTOZSfSFkgpuh+Tc4AiU9OyT022zF6ZlE4KuoWXyIZ1
         iE1xU2V0Ei7xT1Ka6WSiuMWfD2+eM/KlaoBnb6VuIuSE9JIsoQHPaYIpmvJer1SZQpoo
         XVGe+YbLssxppvtbkv4qgYb0D4K7w0d2haM5xJ+S5WAJ60eQHY+Ge7BpDMarzCKfCHtJ
         5FAOznDQtzKOIMZ7qYfu4uraXReK2+SOR0qCQhMikrr8iTG3gfLspPJZzhP6yvQgD1PH
         Eg9g==
X-Forwarded-Encrypted: i=1; AFNElJ/1m5RdLyrI3OX5v2phaV9d5wpYeF4RZxhqWIieKuZchoV6zigYFbHfRxQeUc+DbRb6E8UVDkPOoygNv/vp@vger.kernel.org
X-Gm-Message-State: AOJu0YylIpVwnG27y0zP5ig6j5syZ4YeF6q/NIdS/jG81IqyA6pzbPnU
	ckaAfX9Ohye8JrxMCZ36X4N600xqcUm0SPGMg4IO6XTzKdiMHf6cg9FmzHhn7ms804Wp+ZAB4nO
	UyyYrM3bOCs4K6/HrQaWic+EktW+AtUFVr95Pgl5M
X-Gm-Gg: Acq92OG0aCcT7n8aaeBcVaicxy0h1BYNMx+k2gB48VyGpOPI/YEM9QhKYWva/LWmwzI
	rVEQt7afOXMvbNjGcUyDWWhPE53swh5CCJ/LtafoFNwlCiFwfOC9WpL+LNA9INYu9WSiq5Pb8FM
	eTtuiPsmKFCNHxsbR2FxZncvwGXcskghIe39C/NsIoQrHCTSOoUCYpOYviGIMyEbiVYkudOiK6C
	/kw7JdYl5s2UFI3JNcaEQdg5XAIRDx6CZySSPEgqgEZfGZWr1Gt+0exUiA+KRg5JEbhQhdeLnjv
	5t7GuWFXd4TAuMWqHCOMirsfqTJntX3rHvpnfGiG3qpgd6FoopxwlJn5Ua4doOg=
X-Received: by 2002:a05:6512:1053:b0:5a3:ffed:8440 with SMTP id
 2adb3069b0e04-5aa0e73d549mr5438053e87.12.1779130777398; Mon, 18 May 2026
 11:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69651808.050a0220.eaf7.00b3.GAE@google.com> <87tswqdcy0.fsf@mail.parknet.co.jp>
In-Reply-To: <87tswqdcy0.fsf@mail.parknet.co.jp>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 18 May 2026 20:59:25 +0200
X-Gm-Features: AVHnY4IDLuWLmgZN4sps707aUGubEtzx-7PtxmKdipxvdROLpXYcGmiRtXvWDhA
Message-ID: <CACT4Y+ZHqYe24iTsPNCJ2CUwNJKbdc=c50v674B8_DLfKf64Zg@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] WARNING in msdos_rmdir
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: syzbot <syzbot+66d24939ab3817bd81d0@syzkaller.appspotmail.com>, 
	linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Jan 2026 at 17:15, OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
>
> syzbot <syzbot+66d24939ab3817bd81d0@syzkaller.appspotmail.com> writes:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    9c7ef209cd0f Merge tag 'char-misc-6.19-rc5' of git://git.k..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13cfec3a580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7b058fb1d7dbe6b1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=66d24939ab3817bd81d0
> > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d50052580000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16efd9fc580000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/4fb19edb55d0/disk-9c7ef209.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/9b4c89c27788/vmlinux-9c7ef209.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/a728d410d528/bzImage-9c7ef209.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/83e4f46f8575/mount_0.gz
> >   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17550052580000)
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+66d24939ab3817bd81d0@syzkaller.appspotmail.com
>
> This should be fixed by following patch.
>
> https://lore.kernel.org/all/20260101111148.1437-1-zhiyuzhang999@gmail.com/

Let's tell syzbot:

#syz fix: fat: avoid parent link count underflow in rmdir

> > ------------[ cut here ]------------
> > WARNING: fs/inode.c:417 at drop_nlink+0xc5/0x110 fs/inode.c:417, CPU#1: syz-executor/5973
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 5973 Comm: syz-executor Not tainted syzkaller #0 PREEMPT_{RT,(full)}
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> > RIP: 0010:drop_nlink+0xc5/0x110 fs/inode.c:417
> > Code: c0 08 00 00 be 08 00 00 00 e8 67 f9 eb ff f0 48 ff 83 c0 08 00 00 5b 41 5c 41 5e 41 5f 5d e9 42 90 9f 08 cc e8 1c bd 89 ff 90 <0f> 0b 90 eb 81 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 5b ff ff ff
> > RSP: 0018:ffffc90004877bf0 EFLAGS: 00010293
> > RAX: ffffffff8235efa4 RBX: ffff8880589f9d30 RCX: ffff8880274f3c80
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> > R10: dffffc0000000000 R11: fffffbfff1db66cf R12: 1ffff1100b13f3af
> > R13: ffff8880589f9d30 R14: ffff8880589f9d78 R15: dffffc0000000000
> > FS:  000055559129d500(0000) GS:ffff888126dee000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00005555912d86c8 CR3: 0000000038956000 CR4: 00000000003526f0
> > Call Trace:
> >  <TASK>
> >  msdos_rmdir+0x3ca/0x4e0 fs/fat/namei_msdos.c:328
> >  vfs_rmdir+0x51b/0x670 fs/namei.c:5245
> >  do_rmdir+0x27f/0x4a0 fs/namei.c:5300
> >  __do_sys_unlinkat fs/namei.c:5477 [inline]
> >  __se_sys_unlinkat fs/namei.c:5471 [inline]
> >  __x64_sys_unlinkat+0xc2/0xf0 fs/namei.c:5471
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f0f8e67ed27
> > Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 07 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fff98601628 EFLAGS: 00000207 ORIG_RAX: 0000000000000107
> > RAX: ffffffffffffffda RBX: 0000000000000065 RCX: 00007f0f8e67ed27
> > RDX: 0000000000000200 RSI: 00007fff986027d0 RDI: 00000000ffffff9c
> > RBP: 00007f0f8e703d7d R08: 00005555912c86ab R09: 0000000000000000
> > R10: 0000000000001000 R11: 0000000000000207 R12: 00007fff986027d0
> > R13: 00007f0f8e703d7d R14: 000000000001a887 R15: 00007fff98605a80
> >  </TASK>
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing.
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
