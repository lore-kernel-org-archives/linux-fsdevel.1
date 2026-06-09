Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFAF35A387
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781044446; cv=pass; b=E9gbyQxlORosd95YQaVgUC7dlmbTfthQcCWtvbOmRW2W5mooIVZJvrqCVnf2UShLNgZV377bzD1+7kwb5r92EwmE1CVbiHPOcD/mIunfDTnoI2tIxQ0v+cC5RmARB11km1F0fg57ezAlNemUeFfI7prAhE3f4ISUQeasu+nbXNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781044446; c=relaxed/simple;
	bh=COTblkNy6SCSydFwwrMAdTko/6ck6W25SMup1eD2Wbo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ty53G0ZMeqYV7x+AUH4E40A3Wu+rVTxHDSTQTMOOzY/kCteFG8OEhFJhRSSrfv3jhmHKuEUdXsc/S5+Kar3DggAFX3QuHW0IshgyrPby7KX13g+HXLnE8Ao46fpIe5SEojmw8k/ECVIhlWhxmxzK9bcL8/fqmykhfjMISa8cFUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j89qkW/M; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j89qkW/M"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8ccda0ac4fcso62132816d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 15:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781044444; cv=none;
        d=google.com; s=arc-20240605;
        b=WpNZsGU91ZNbl6XuvfiPq7kplSu4mcd5UHxiXhVe//DSH3t2pjrOu2crhbr30RjkXH
         yBEbfUC80+LP+aGoktedNFpId2YtdsOcsgqqEagsqa9JxwATdKNRDttfalraTj3Yvvai
         a7mb6FUBWpbxdHtZL9eHNXEG4TyyRu7AGL/5zbIZd67RcvxA14QFdm5FqFCDKxWXqbHf
         yckQE+tFtNJXLXZEve+KIY58lOk+NDcyisAHfmnw7P03TERSRWRJ8e83WwAKm8J4VIbn
         r8NL1JHWXHmz6q9VkYhzAGxm9ORmLbR6sThYCNJbDgwD09r0N/vOXJsMwktjtzrMBXHT
         iTfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=js4tlHBiBMVYgQ7eMyaF9Sfm3F9tYvMqzzGrQuJc52E=;
        fh=gp/j5YDmcN32yH6TaDCr4ZnCQTDSeqKZ8UfkW0hbhB8=;
        b=XKSV7gXZCmYMpLq5lc/TP8sIoGYjZka/t6/3M11qC96IZlHrTgnhIXgsMFe/DRcypM
         2ygah0uRgPLaj2ghSRpoFVfvflyMe+yAHnLkBay/gUH0p8Om4NLz5Ip5t5ic4wCft/0q
         N03YqVvrPslMctKPXxFX6sYrjfcGFbhw5Mods1X1RAQU66zAKXQ45EEafbXMNNeC9lWt
         OezorpyP5ACP3Ovg/52bRg76zEm27t/sTwG3EMjM4GfaDPVlqM26qW1LoN1tgrhjTstX
         uAbXFZ0RkM7fQonEHDzCYS1tJnemizX9+wk9uR31naKbFnuzJf9p/7UaNz6wqzglEemW
         fo5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781044444; x=1781649244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=js4tlHBiBMVYgQ7eMyaF9Sfm3F9tYvMqzzGrQuJc52E=;
        b=j89qkW/Mvi2CqvnMBgC6P66rEQqW9nCkq/coxDjTcegN+8o5iqXnEwYrcUreKwd18V
         4nNCRRdcqy1h9jtNBGU2FKGYJpRfYHYUN4QZObS01xK6eGztnbCh9yvPQ0r1e11fmXan
         NeIkhe2Xb85i5xUkrqIiEZbo8nxRTT6AkkOeDw5s+yP+Y74aD8+1IrHBOtbJbFxu1jRU
         l4vMZ7B/ID4lmNdAkzmL+S95/eC70ZsHC/2/WVXg/rVVWoQIVsS6DMeaz8MxPQJiopM0
         zeBAGXLu1iD2AxVJkBRZ0vR+tTuQEoALL5xPVVMDyV0ylwhpgm1eFLuZPjJB3krvvP0F
         8sAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781044444; x=1781649244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=js4tlHBiBMVYgQ7eMyaF9Sfm3F9tYvMqzzGrQuJc52E=;
        b=JDionNIuePr7SyoR3FafJZgIT178zAXZwLQB32TVo9YPuK6ZkwpKPE66emz5M9M7pu
         tBiShw4v8jYWuNkFwpJVGfgOA/Pk0hBgN6HgQNnsZLDoVWznOagLCATnYIA/EvvjskBV
         aiktSqLu6yNAVbozPzzJlBbB3lwNa39/tIQQUz5vwkwTdr26Hg8K9Ynfj/GuAQ2s89lC
         rJCB38nU0HDBzPnYBZrHNwLXybCQql+ksANaaJ1wSRabclvUrMfcbU/anViey4ySfkRo
         dLiz9e+/6d2lgbzqNihi3JA8tMGSNE/RnZlRevTOhnwv6MRZWZdGEHRtad9VRrNBPACy
         /n/g==
X-Forwarded-Encrypted: i=1; AFNElJ9UNPK3jhwsuNaZqdJYNEjsiipI193MxaGHob8CLExJm3Oc4zpK4wj98jWaKnM2HOwAztUetR+xJbqG2F37@vger.kernel.org
X-Gm-Message-State: AOJu0YzjApyiyHpWpTLQEa/xwvGhvidQgihDn5xivMttjUq8AqNiF5hx
	BKFZj1EzgrQ3tKzyDfdKn+Hk49BDQySTQni7in3XudU1jxj+OWKBt6Atxngw3Po2ov42lDJfOew
	4sYbRhEJtR2mWQrdhL+lL0HC1MtuCUvMK+FSGWm600g==
X-Gm-Gg: Acq92OFHdkg3mKFW0apPkzELMVZ3FW4P+hofKwWyqWo7LIlTbLd9hfn9T9DlcYEBKG0
	9FNDiV+Hzz4JQQHXoT3jjgUKM4KKFH/LehWFTXxTMcGgFNNxqyAiTEoaWK8PQJSAtUL0UcNkrpu
	UrVz/rMJw/abUTgkzQxdJCt5/1asw6AtF+C1TBgUXnCW9K3R0K+OpOHVX8QA8XVR4mBwdkIdYkO
	NlKj27T+L59OMPxYlUiqmH5zljj21EeBCzT2J54BMlVUlLINnIwUdBlnF8QlfuBGz+urxtgyc3p
	CkDcrTDUOQln+Eu4
X-Received: by 2002:a05:6214:212a:b0:8cc:3546:261d with SMTP id
 6a1803df08f44-8cf1ddfbb1emr72611696d6.40.1781044444260; Tue, 09 Jun 2026
 15:34:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFmvuTWx0NUnC-q6T=SAWLJTEp-fvueRqgPQCFtULmGngUs+AQ@mail.gmail.com>
 <CAJnrk1YjZZGzzup5biMq+SFuMK0pp8O4ZLTEjji7oJGD6wJNNQ@mail.gmail.com>
In-Reply-To: <CAJnrk1YjZZGzzup5biMq+SFuMK0pp8O4ZLTEjji7oJGD6wJNNQ@mail.gmail.com>
From: =?UTF-8?B?6rmA66+87ISc?= <neck3922@gmail.com>
Date: Wed, 10 Jun 2026 07:33:51 +0900
X-Gm-Features: AVVi8Cdp2js1ij8t4qL98AIHRLWri1v0UdX9_6anIu5LvEfWfIGYIuxhVqdq9Nc
Message-ID: <CAFmvuTU4vn82Rr0XDO+ypzEBH-h_GZ76ccsuFnTJJM1s=3izvg@mail.gmail.com>
Subject: Re: [BUG] fuse: KASAN null-ptr-deref in fuse_readpages_end after
 aborted splice read reply
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	fuse-devel <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Joanne,

Thank you for the pointer, and sorry for the duplicate report.

I applied the two-patch series starting at [1] on top of my v7.1-rc7 tree
and rebuilt the kernel with the same KASAN config.

Before applying the patches, the C reproducer triggered:

  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: fuse_readpages_end+0xe5/0x650

With the patched kernel, I reran the same C reproducer as uid 1000 with a
user namespace. I did not observe KASAN/Oops/panic in the recorded runs.

Based on my testing, the patch series appears to fix my reproducer.

Thank you for taking the time to check this.

Best regards,
Minseo Kim

2026=EB=85=84 6=EC=9B=94 10=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 6:40, J=
oanne Koong <joannelkoong@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tue, Jun 9, 2026 at 2:36=E2=80=AFPM =EA=B9=80=EB=AF=BC=EC=84=9C <neck3=
922@gmail.com> wrote:
> >
> > Hello,
> >
> > I am reporting a FUSE read-reply bug reproduced on upstream v7.1-rc7
> > with KASAN enabled. The bug was found with a local syzkaller setup and
> > was also reproduced with a standalone C reproducer.
> >
> > Target files:
> >   fs/fuse/file.c
> >   fs/fuse/dev.c
> > Subsystem: FUSE
> > Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git
> > Git head: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> > Kernel release: v7.1-rc7
> >
> > Observed crash:
> >
> >   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007=
]
> >   RIP: fuse_readpages_end+0xe5/0x650
> >
> > The same reproducer may also sometimes surface later as:
> >
> >   RIP: iomap_finish_folio_read+0x163/0x230
> >
> >   Call Trace:
> >     fuse_readpages_end
> >     fuse_request_end
> >     fuse_dev_do_write
> >     fuse_dev_splice_write
> >     do_splice
> >     __do_splice
> >     __x64_sys_splice
> >     do_syscall_64
> >
> > Root cause analysis:
> >
> > The crash appears to involve the FUSE splice read reply path replacing =
a
> > page cache folio while or shortly after the corresponding FUSE request =
is
> > aborted.
> >
> > In fs/fuse/dev.c, fuse_try_move_folio() does:
> >
> >   replace_page_cache_folio(oldfolio, newfolio);
> >   ...
> >   if (test_bit(FR_ABORTED, &cs->req->flags))
> >       err =3D -ENOENT;
> >   else
> >       *foliop =3D newfolio;
> >
> > My current understanding is that replace_page_cache_folio() can detach
> > the old folio from its mapping. If FR_ABORTED is observed after that
> > replacement but before *foliop is updated, the completion path can stil=
l
> > keep the old folio in ap->folios[]. Then fs/fuse/file.c later does:
> >
> >   mapping =3D ap->folios[0]->mapping;
> >   inode =3D mapping->host;
> >
> > and faults because mapping is NULL.
> >
> > Reproducer:
> >
> > C reproducer:
> >   https://raw.githubusercontent.com/neck392/linux-kernel-bug-reports/ma=
in/fuse-readpages-end-v7.1-rc7/repro_fuse_readpages_end_rc7_userns.c
> >
> > Symbolized KASAN report:
> >   https://raw.githubusercontent.com/neck392/linux-kernel-bug-reports/ma=
in/fuse-readpages-end-v7.1-rc7/clean_c_userns_report_rc7_fuse_readpages_end=
.txt
> >
> > Kernel config:
> >   https://raw.githubusercontent.com/neck392/linux-kernel-bug-reports/ma=
in/fuse-readpages-end-v7.1-rc7/kernel-config-v7.1-rc7.config
> >
> > Key config options:
> >
> >   CONFIG_FUSE_FS=3Dy
> >   CONFIG_KASAN=3Dy
> >   CONFIG_KASAN_GENERIC=3Dy
> >   CONFIG_KASAN_VMALLOC=3Dy
> >   CONFIG_KASAN_EXTRA_INFO=3Dy
> >   CONFIG_USER_NS=3Dy
> >
> > Runtime conditions:
> >
> >   fuse.enable_uring=3D0
> >   unprivileged user namespaces enabled
> >   /dev/fuse accessible to the reproducer
> >
> > I verified the C reproducer by starting it from uid 1000; it then creat=
es a
> > user namespace before mounting FUSE.
> >
> > Brief KASAN excerpt:
> >
> >   Oops: general protection fault, probably for non-canonical address
> >   0xdffffc0000000000
> >   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007=
]
> >   CPU: 1 UID: 1000 PID: 399 Comm: repro_fuse_read Not tainted 7.1.0-rc7
> >   RIP: 0010:fuse_readpages_end+0xe5/0x650
> >
> >   Call Trace:
> >     fuse_request_end
> >     fuse_dev_do_write
> >     fuse_dev_splice_write
> >     do_splice
> >     __do_splice
> >     __x64_sys_splice
> >     do_syscall_64
> >
> > If you fix this issue, please add the following tag to the commit:
> >
> >   Reported-by: Minseo Kim <neck3922@gmail.com>
> >
> > If you need anything else, please let me know.
> >
> > Best regards,
> > Minseo Kim
> >
>
> Hi Minseo,
>
> I believe this has already been fixed by [1]. Could you verify that
> that patch fixes your issue?
>
>
> Thanks,
> Joanne
>
> [1] https://lore.kernel.org/fuse-devel/20260519052807.1924269-1-joannelko=
ong@gmail.com/
