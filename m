Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A904EDCC5
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 13:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773304; cv=pass; b=JBhusPbRCJRrKfpfyzvBXuWD6gsU5NsmzenVYg5yndfWugT2zYApkGyRvfi26N1+8Gq9ReieF6i55U/2B4vG6wDeFdnYQua+oEWrzU7fxyckpkLNROwOFuhmLC+kxHVECo7ZZ3NrX21SiY23TCIZ67Mr6pCZyEYHT5xQkEWkyZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773304; c=relaxed/simple;
	bh=rXhD9d5fVao5sI7KtDb02mbwZKbJQRUDL1y/fHhh3rE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iBiuAdVNkkkDAPBHcQSf93L7QSglfGh/cJOIx+gsHhMTQM2K6KC3ixedjzw9GGJIn/vYgVbwL9uYl/7og1eCxiMYHLk47Unjq495+4X594Z0w1qNp18x5J8grBlIrreB3l5gD4C5ZsscAW8UGKCjQ4Kn1gf1U6+lQwxs+JZlIHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASQnDUs0; arc=pass smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASQnDUs0"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ab41af29caso17577977b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 06:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790773292; cv=none;
        d=google.com; s=arc-20260327;
        b=F23ZVt0gO9OwJOuEt/aPj3DeWycnz5kkE58PZUad4bz1fbbCWBn2D79Y9qo+52aSgn
         NaxEgZdB1LGEoPi9RLDTjmWLUt6aaoPQEH3kXgRWYlHuP9e5mMrOF3jB8d/iS5e9tO6/
         jrmhEXi0CBhD475k15XPjw2Ntqgr5TCyMnQvF5Z3GswsW1umOZiiAfkaszGlYndT0j6X
         lGLE0yLuTndUqpXwXMmrRSxMB15GKIsRHFy3AdEJrlQ5Go90xTCwokSA/v5MzpEC5gbh
         ZofjPaolF3CurjHjeDKltg5IuVHIHgibOH4maMMLmGf6thNm9FALTfaz63Knc8hPAH43
         B/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hEs0MrU+9UYEDaK1O0qQqAVkGiu5ndS/FUHo0S0MNoo=;
        fh=ni1fP3A7OPUWQTZ6o8lZzFhpmWSOypo9Y0foGIh04No=;
        b=mmuEhDrXLgt+z1CY/HRlYp4fmvjRHtk9blhgVa00B1RWNAPW1PmbOpPjzCxzmnIyrV
         QNdJHYSCPHffkiEm5bL3zwmA3IXQlJE/SNdkyNjqRw8NJzv/jWVJeTjcijGOQcsIOWe3
         T1S2V7zJrOY2iyacWaiLDhVTEGtzfr28LkOFj3FwUhdXsYdqs0wu84PeVw7w2+o3Nf9V
         /qHs+YPRv5b49BTwUKNe+N1gJJ9anIcdAfji94C6tGpsZSAZn33ijrF8JQFahGkHvR3/
         X1kpFxlMksoCvug8OQvy/oK51J/ankEqB8gGgNp4G8GDBxaUN1fwCP29OgzofsRhVLdj
         97zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790773292; x=1791378092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hEs0MrU+9UYEDaK1O0qQqAVkGiu5ndS/FUHo0S0MNoo=;
        b=ASQnDUs0RwWSUbUDZdtB7d/U5W4WjUwxnOFdDVG95TmzUatfXQLMkPgSQpqSlPJeRu
         fyFeM/NrbUqpZQPT50Qxg+Im9kKxlUcoWEU44G3vBci/0qetQQW9dyBNhV5XSO4XcJ0s
         PfYd7vV2pZ17vLxOAG5XHmr4LreJG1RLrdtOBZ8ZI/wsYlwwc6ZH+0LGJ/IrGvduM566
         0cpafe46uURBqeMvDngiZp2u2AT+/AyGvqdmvnNLtLNmFp5pgQWfna+Qx8zYQB/CsG83
         TzFTrf6YOh1ExS95MP9PwUzMdHsHyj42YvhG3pwIT/0WONJeahLBqaP8vvRHi0XRJqXx
         81Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790773292; x=1791378092;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hEs0MrU+9UYEDaK1O0qQqAVkGiu5ndS/FUHo0S0MNoo=;
        b=KUB6g+G0VLDyhGxmkBaJ1zAUxSpG/QibQlSXuHhOuJCRh9ST8mB6IEFCFEZ1SYZ8sv
         Sir4d8MeweHxlJ+SzEIzOa9WcoBD71ZbC2YznPWXbGQTDUNFWtexktMU2CEkVxhxOVDU
         DhdcwmcmPvIStMKBNWG5Hsn1o5w6flu1AXCnJrStYMjcJ1tHci8wCdW/Yd8INjA0OS8b
         5T4FOC2qR7WyoJ2mtlpNZp9OENthFssxu+/mw5//AaxWpCZGZpWQ76aGU3GMo5UKgvW+
         h/WjqWKDoB/hk22yK7c0lwPCm2hkl8evcbSmdd5mdwIrcrmveK08lV9VFsZ18+MkiBwO
         KDIA==
X-Forwarded-Encrypted: i=1; AKwUvBwl3XKeUt6tJL5U+iR0jEU7TIPtc/FmWY3KOXA4+m+0s/QHPMu0INvOI75XuZdWWv0kS60ayWsBuHROck2I@vger.kernel.org
X-Gm-Message-State: AFq9FYID/htyJeMO0/VsmDwcS1tpbreTtEQqnrh6Y3t9tvbcPsB8e19q
	nFkjaK6z5t9f33myyI0YzogfkzvWfs+TfJjhqJDjLkAPPUxBnIi5M8E1mBYXpNK/4yRkCImn8eY
	5f2Nf8qtiBbtyHF6WIvoLVdx4qAWYhY0=
X-Gm-Gg: AYBFou0M9UIJTIffptbfwlf5m9+TjaQR175tuZsAF24+kIcLTXNXNoaBk2qsbwKYj6B
	GYealCPnGBIxEA3lkTskLw+thjG4wnN4lqTzcbmpVLpwyMBMb1uTUyf4eEvg7NCB03aKyv1+/Y/
	J9pquJlaEdJIDMS54US1RN2pkstLtyJMtsGVr+veZiGUMU7y0br4NYf1VfjYUyvHcNSko9iDxr1
	AevhKUIpNNqZL7ZiKCmxT6A+OhUKGbGd4nuUzWMEo+zDHVmujLn5TWz4y10ymWWiEHhowOo9tZx
	4DuXvkAXLXOeVXAYFQM2y3JzvpIBfuc93fHo/+NPPgKpxmPxxpE3FeNSn0X5+ZE3NGHlj+/JamV
	yAlhL8I64QqZEoG513nH2ILqpfV96444fUdCnFhr/Tu7Tu2NwPMOX
X-Received: by 2002:a05:690c:6610:b0:8a4:b228:26bb with SMTP id
 00721157ae682-8ac906e7b27mr4595127b3.8.1790773291529; Wed, 30 Sep 2026
 06:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ab7dca9.80e1c6cc.1e8e5f.0046.GAE@google.com> <6ab8cfe8.dc2998a4.2261f5.0062.GAE@google.com>
In-Reply-To: <6ab8cfe8.dc2998a4.2261f5.0062.GAE@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 30 Sep 2026 14:01:15 +0100
X-Gm-Features: AclHuK8YO05yVKyNEjULn_BdKlGqv33H53JQVXMS1TyfeE6y-zBSpShkWdCLRKE
Message-ID: <CAJnrk1Y8+P5W-6ETYuVDb2xk=GkP5o0XoDyDtvEPw+sC3GA-fQ@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_iomap_writeback_range
To: syzbot <syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 27, 2026 at 9:15=E2=80=AFAM syzbot
<syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    fd179f8a05be Merge tag 'ata-7.3-rc5' of git://git.kernel.=
o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1349060558000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9d4242cb1c54c=
df7
> dashboard link: https://syzkaller.appspot.com/bug?extid=3De8200299b055697=
6e13c
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e25=
5-1~exp1~20260613092250.77), Debian LLD 22.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1523f2c9580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1438531558000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c4cebd01ff3c/dis=
k-fd179f8a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/9fd8641fa35c/vmlinu=
x-fd179f8a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c6e8e6332600/b=
zImage-fd179f8a.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> !ff
> WARNING: fs/fuse/file.c:2043 at fuse_write_file_get fs/fuse/file.c:2043 [=
inline], CPU#0: syz-executor122/5774
> WARNING: fs/fuse/file.c:2043 at fuse_iomap_writeback_range+0x7c8/0x18f0 f=
s/fuse/file.c:2227, CPU#0: syz-executor122/5774
> Modules linked in:
> CPU: 0 UID: 0 PID: 5774 Comm: syz-executor122 Not tainted syzkaller #0 PR=
EEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 07/24/2026
> RIP: 0010:fuse_write_file_get fs/fuse/file.c:2043 [inline]
> RIP: 0010:fuse_iomap_writeback_range+0x7c8/0x18f0 fs/fuse/file.c:2227
> Code: fe 48 83 3b 00 74 5b e8 e6 f0 6c fe 4c 8b 3c 24 e9 08 0b 00 00 e8 d=
8 f0 6c fe eb 5c e8 d1 f0 6c fe 4c 89 f7 e8 39 63 8e 08 90 <0f> 0b 90 48 b8=
 00 00 00 00 00 fc ff df 48 8b 4c 24 58 80 3c 01 00
> RSP: 0018:ffffc90003e172b8 EFLAGS: 00010286
> RAX: 8000000000000000 RBX: ffff88806e4ea880 RCX: ffffffff9a9ec501
> RDX: 0000000000000001 RSI: 0000000000000004 RDI: 00000000ffffffff
> RBP: 0000000000001000 R08: ffff88806e4eae63 R09: 1ffff1100dc9d5cc
> R10: dffffc0000000000 R11: ffffed100dc9d5cd R12: ffff88806e4ead08
> R13: 0000000000001000 R14: ffff88806e4eae60 R15: ffff88806e4ead08
> FS:  00007f6a3f53e6c0(0000) GS:ffff888124cc8000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000020000000b000 CR3: 0000000078090000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  iomap_writeback_range fs/iomap/buffered-io.c:1896 [inline]
>  iomap_writeback_folio+0x1526/0x2490 fs/iomap/buffered-io.c:2022
>  fuse_launder_folio+0x17b/0x240 fs/fuse/file.c:2331
>  folio_launder mm/truncate.c:612 [inline]
>  folio_unmap_invalidate+0x4cd/0x830 mm/truncate.c:634
>  invalidate_inode_pages2_range+0x629/0xb30 mm/truncate.c:726
>  fuse_open+0x5a6/0x770 fs/fuse/file.c:297
>  do_dentry_open+0x816/0x1380 fs/open.c:996
>  vfs_open+0x3b/0x340 fs/open.c:1101
>  do_open fs/namei.c:4837 [inline]
>  path_openat+0x1443/0x1d60 fs/namei.c:5000
>  do_file_open+0x23e/0x4a0 fs/namei.c:5029
>  do_sys_openat2+0x115/0x200 fs/open.c:1417
>  do_sys_open fs/open.c:1423 [inline]
>  __do_sys_openat fs/open.c:1439 [inline]
>  __se_sys_openat fs/open.c:1434 [inline]
>  __x64_sys_openat+0x138/0x170 fs/open.c:1434
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f6a3f58fae9
> Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 d0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f6a3f53e1d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 00007f6a3f644b98 RCX: 00007f6a3f58fae9
> RDX: 0000000000000040 RSI: 000020000000c380 RDI: 00000000ffffff9c
> RBP: 00007f6a3f644b90 R08: 31203a6b63617473 R09: 31203a6b63617473
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6a3f6117f4
> R13: 000020000000e3c0 R14: 00002000000062c0 R15: 00007ffe0b2d2af8
>  </TASK>
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6d707f2b3bff..0ef46f6e0267 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2351,6 +2351,9 @@ static int fuse_launder_folio(struct folio *folio)
                .wb_ctx =3D &data,
        };

+       if (fuse_is_bad(wpc.inode))
+               return -EIO;
+
        if (folio_clear_dirty_for_io(folio)) {
                err =3D iomap_writeback_folio(&wpc, folio);
                err =3D fuse_iomap_writeback_submit(&wpc, err);
