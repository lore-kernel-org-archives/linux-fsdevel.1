Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708304AA01E
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790843439; cv=pass; b=TwgAw8vuEr89/ZsEhoeHj7HjvFJKBZ6VLZOs2VlSUidHYmVWZL7aJ/RWJmoOqZ9mE5JL9BN5xkGjkJpX9MBJid3CmRJyKRydjkhuKZ8lEnDLUwXoHF5T6JZilqtGJXnJ+3SJaxBvtCLHw9ALXUW7k/35Ycc8qVQc9Catlq1Em+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790843439; c=relaxed/simple;
	bh=f/QYvaCRJtIDNV62Q+0YxWNu5SfxT8Rcvr9ifUxU690=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcZNmoQnQ09z5S5Ff1ldN46TyrWwxReBspQfEHN/yAUl+OKaWGwSvgL1suoFcNOfaNYrWXwNmCxyBytIkPS+CqjL1dIIpBcWsO98BtSin3T5mZQcxLjdYPWu5m1h+Rk44S63foj89ClmRFqpSC3UZPTHqR0JrPF7akKzRb2w8GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L39CP0Wl; arc=pass smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L39CP0Wl"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48aff58e6abso937683f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 01:30:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790843436; cv=none;
        d=google.com; s=arc-20260327;
        b=svqmsjcwCoSPUCSP+5Wt8U9F5e2iRllrf22ZZ/mNajZJ/DTTSJRChriRieulbqsy5a
         aZHA4HrWi4IIeLg4DmDYYSGbbe6o8gxCUxWEDQZ0I4nGLRbeDUxDYUGHY+nd012UO0+R
         4nOb6BJoFwZb3tJL+DPP//ep6dXCOetNv7CueWA1DsOBvWuGy+TehU/op7mmws/c3Mbn
         bp0SIyQRCIbZybGb34/WcJ8EpklX+NBu6l7SwaXs1pZebmGN1jTHU0PoGF1/FTfJYDZN
         UDBX1eKnoW9k+51ayBdrB974uSrIu+ZNSwMxTmtOQBrmdxkxCoOTSAEW43CwvVKjd/Uy
         dBmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ZYv6il2HdcwUZ9E5tG2pbf5ctdWL/nyovqOfI473uU=;
        fh=irACIjzj+WjMwke3LrPsZosnZD8psE6afZdHtiQjLZI=;
        b=iqrO83EiqIsZdwXHrYrOmgIZsmZQmfa5wr3H6B95QR9G2/S1HIlrK9ppn5DXeMKMZc
         CSI/H8cX0j4c0Nf5DaV0IdZM+U3ZOeV3MbcoxUl4wkWY6NsrZhl2EBqjKlQbINUlnEkw
         jd+2mQuoHIOCIisJCHVSV5f4F9axUkNKn37V6h5vuzD3A3fzywkof7WwJv7eecl4nGPM
         Azxu3BeksubQJ6L/JyPSH+HxnNyrUltoh9qbX8yrxJUokBkqOkJZUwvitKbkpAWR3hbX
         k3X1G4nPpDDa/VU5Cqa+MzpzjNOa4jSFe1TAMDcNjoYO6kw70wH+oJ72/u9OaYKFfKVH
         akBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790843436; x=1791448236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5ZYv6il2HdcwUZ9E5tG2pbf5ctdWL/nyovqOfI473uU=;
        b=L39CP0WlJt+t6U4yIe3NBaTqin78ceeTKeG2aYqsUhTYCsxjZ5GxdN6TdDgQXz45LJ
         6cibJhJ5Dy9VCa9eeAiO1hdTOryN3wayq8GzUUCtQQ/60D/VROP9geH7vnwNZ2P0WxOv
         D4C1XAAGgIu/nKVoBtaPOXpfn+MiUPV8xk3sOg6WDydYp+02plP3mEFc/VL2TcX6NpYP
         +l83cZIaf0naK1GCo0mHIxjbbQcMM1aogGkEwS1h1dg81FfNuP+hDsLrybtjO48ppTCq
         0n3qv1Yr5iZQq7KUwXzG/RUV3KkeBmJY0350OT8rOIEdaT5jhsdWJ56tmUiUD3xvvtDE
         nm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790843436; x=1791448236;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ZYv6il2HdcwUZ9E5tG2pbf5ctdWL/nyovqOfI473uU=;
        b=OkdtlydyHVj0QXsQbADr+wUJ01bABf6ASVATbw5Rntpw4ZqOiiuhGN5OY8QWJzo3E3
         XjPEyvHKPIe611uwq1SPFB7NFRIwa9KuAcZ0ROCHYYQNVHd9Z1BNZfL3utRQKRSlyxk4
         BCQXuc4cv3a8M/Ib7HqRYiyIn3KXi/zxvx5Dkq7bOje2BBFLT5tQMChGEVOrO1s7Ztes
         VJSm2bUbclChGXgXs5mrQyjqxkls7I9A+kQH79THlz0//wGv0k3xcLH7kAaMAZB4MsMg
         LDrfrmI2jq+bLAplNuwlTFqgR4WH9xZwDmCyDix1I8hLrCwQJJAW8jgUSIGVpjicXgmN
         3i9Q==
X-Forwarded-Encrypted: i=1; AKwUvBy0qXqjRLVtqaPnmBw6FZJyPHG6gUIaTn73kCfp4sP62jwT86su6l4P093mNVaqwxYd32bGij9611Wonh+r@vger.kernel.org
X-Gm-Message-State: AFq9FYIMmw7sGuUeMpTiRsye09Rubh1ABm6pZASiEGJIxeoxznsi4+6b
	yDPI6AOawyqFb5EVsF7kZ7A75KwggBRt8Au22adSE5KINhjI+wNUMHbcKYU62jo1kIdvRhTIzGZ
	nYo80C8EaYOuHEfWb5+aDV/Gi9qrbI2A=
X-Gm-Gg: AYBFou02BBX07f99VLPRCojoWwhr/QZ1JkS8a0Xdb/gI1b62hRDEZPnwrx5+K75hb02
	Srdj22FeeJyvTJzGgmIu6w/H/OJkW5Z6oTWALTJbvPH7bzNu1HlbSg0YqQqMN4/7NliEpWG7PzF
	GVC1m/J6JZPVLlPUd3nNyGlW/KC3aTi+7bQICltDoliEtBd9xPcGxYMISaf3YnX7K8blxZPIZZc
	oECyr+kyH5PnJY4ck8nOCaJNTeLVKwpc5OVjhrGu1/mL5nY6eH87s9UpLHe55FPCl8O1Kt5wFGl
	QeC4sKlDf/02xhVCaXzz1d/MLmZI3rcbk/PLs0pAZGOALveIUS++BhyskjDIY4rzUtrosP075dN
	oxs30LpWvaynvfyshY5knOtwwf1G9OULfhdEXvvx+egmeSnYXdcdV
X-Received: by 2002:adf:e18f:0:b0:488:7b80:f2d0 with SMTP id
 ffacd0b85a97d-48b0254cb62mr6486309f8f.52.1790843435449; Thu, 01 Oct 2026
 01:30:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6ab7dca9.80e1c6cc.1e8e5f.0046.GAE@google.com> <6ab8cfe8.dc2998a4.2261f5.0062.GAE@google.com>
 <CAJnrk1Y8+P5W-6ETYuVDb2xk=GkP5o0XoDyDtvEPw+sC3GA-fQ@mail.gmail.com>
In-Reply-To: <CAJnrk1Y8+P5W-6ETYuVDb2xk=GkP5o0XoDyDtvEPw+sC3GA-fQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 1 Oct 2026 09:30:22 +0100
X-Gm-Features: AclHuK83_ifVqqKZGZgWksTmrstL8fLSiCbSWwvwncfkRTOgE6x5W7i6vQNHWDY
Message-ID: <CAJnrk1YFKdQfKC6YCsFF17ydjSP076r2K2PYPQiqkceJtn6Yew@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_iomap_writeback_range
To: syzbot <syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:01=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Sun, Sep 27, 2026 at 9:15=E2=80=AFAM syzbot
> <syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has found a reproducer for the following issue on:
> >
> > HEAD commit:    fd179f8a05be Merge tag 'ata-7.3-rc5' of git://git.kerne=
l.o..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D13490605580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9d4242cb1c5=
4cdf7
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3De8200299b0556=
976e13c
> > compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e=
255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1523f2c95=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14385315580=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/c4cebd01ff3c/d=
isk-fd179f8a.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/9fd8641fa35c/vmli=
nux-fd179f8a.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/c6e8e6332600=
/bzImage-fd179f8a.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+e8200299b0556976e13c@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > !ff
> > WARNING: fs/fuse/file.c:2043 at fuse_write_file_get fs/fuse/file.c:2043=
 [inline], CPU#0: syz-executor122/5774
> > WARNING: fs/fuse/file.c:2043 at fuse_iomap_writeback_range+0x7c8/0x18f0=
 fs/fuse/file.c:2227, CPU#0: syz-executor122/5774
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5774 Comm: syz-executor122 Not tainted syzkaller #0 =
PREEMPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 07/24/2026
> > RIP: 0010:fuse_write_file_get fs/fuse/file.c:2043 [inline]
> > RIP: 0010:fuse_iomap_writeback_range+0x7c8/0x18f0 fs/fuse/file.c:2227
> > Code: fe 48 83 3b 00 74 5b e8 e6 f0 6c fe 4c 8b 3c 24 e9 08 0b 00 00 e8=
 d8 f0 6c fe eb 5c e8 d1 f0 6c fe 4c 89 f7 e8 39 63 8e 08 90 <0f> 0b 90 48 =
b8 00 00 00 00 00 fc ff df 48 8b 4c 24 58 80 3c 01 00
> > RSP: 0018:ffffc90003e172b8 EFLAGS: 00010286
> > RAX: 8000000000000000 RBX: ffff88806e4ea880 RCX: ffffffff9a9ec501
> > RDX: 0000000000000001 RSI: 0000000000000004 RDI: 00000000ffffffff
> > RBP: 0000000000001000 R08: ffff88806e4eae63 R09: 1ffff1100dc9d5cc
> > R10: dffffc0000000000 R11: ffffed100dc9d5cd R12: ffff88806e4ead08
> > R13: 0000000000001000 R14: ffff88806e4eae60 R15: ffff88806e4ead08
> > FS:  00007f6a3f53e6c0(0000) GS:ffff888124cc8000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000020000000b000 CR3: 0000000078090000 CR4: 00000000003526f0
> > Call Trace:
> >  <TASK>
> >  iomap_writeback_range fs/iomap/buffered-io.c:1896 [inline]
> >  iomap_writeback_folio+0x1526/0x2490 fs/iomap/buffered-io.c:2022
> >  fuse_launder_folio+0x17b/0x240 fs/fuse/file.c:2331
> >  folio_launder mm/truncate.c:612 [inline]
> >  folio_unmap_invalidate+0x4cd/0x830 mm/truncate.c:634
> >  invalidate_inode_pages2_range+0x629/0xb30 mm/truncate.c:726
> >  fuse_open+0x5a6/0x770 fs/fuse/file.c:297
> >  do_dentry_open+0x816/0x1380 fs/open.c:996
> >  vfs_open+0x3b/0x340 fs/open.c:1101
> >  do_open fs/namei.c:4837 [inline]
> >  path_openat+0x1443/0x1d60 fs/namei.c:5000
> >  do_file_open+0x23e/0x4a0 fs/namei.c:5029
> >  do_sys_openat2+0x115/0x200 fs/open.c:1417
> >  do_sys_open fs/open.c:1423 [inline]
> >  __do_sys_openat fs/open.c:1439 [inline]
> >  __se_sys_openat fs/open.c:1434 [inline]
> >  __x64_sys_openat+0x138/0x170 fs/open.c:1434
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
> >  do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f6a3f58fae9
> > Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 d0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f6a3f53e1d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > RAX: ffffffffffffffda RBX: 00007f6a3f644b98 RCX: 00007f6a3f58fae9
> > RDX: 0000000000000040 RSI: 000020000000c380 RDI: 00000000ffffff9c
> > RBP: 00007f6a3f644b90 R08: 31203a6b63617473 R09: 31203a6b63617473
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6a3f6117f4
> > R13: 000020000000e3c0 R14: 00002000000062c0 R15: 00007ffe0b2d2af8
> >  </TASK>
> >
> >
> > ---
> > If you want syzbot to run the reproducer, reply with:
> > #syz test: git://repo/address.git branch-or-commit-hash
> > If you attach or paste a git patch, syzbot will apply it before testing=
.
> >
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 6d707f2b3bff..0ef46f6e0267 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2351,6 +2351,9 @@ static int fuse_launder_folio(struct folio *folio)
>                 .wb_ctx =3D &data,
>         };
>
> +       if (fuse_is_bad(wpc.inode))
> +               return -EIO;
> +
>         if (folio_clear_dirty_for_io(folio)) {
>                 err =3D iomap_writeback_folio(&wpc, folio);
>                 err =3D fuse_iomap_writeback_submit(&wpc, err);

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
for-next

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
