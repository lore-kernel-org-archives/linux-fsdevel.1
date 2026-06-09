Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF45362154
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 21:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041245; cv=pass; b=Zd8xnXpiMuBAbbAIAXUvseJVoywDSwis1eUf22FZDV3v/5Ax76qGvTFhKpgnX/QzreKrrmzyoe97HjNx3PuW3jALQc/tKVrffnVwjQlYazj9guXYWL43UPBI0QOAQ0sYTp/KziFRuTwuz7un4gmKYBCILg0w/CJbTq1MqCaEhDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041245; c=relaxed/simple;
	bh=LxJbphFnFSLK7hr9bXSOnnqXmI0nFTzhEiHyDOBnbpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJOtsBT6VwTmUojtnjwCX83UkZRnbAy0VpDaBwvuIrjqXF4lJOeSdTGV18gM3gonjkMbP9kJuiOisou90SoS8vSGW06qv9ZwpA8X8rTngQ18S3E3wtEDuSpWn0vsG7yM6E1qZ+Oub1p6i8RGrwwZyPVxHmD5XTz5Lx+78N4H5qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN26/dWi; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN26/dWi"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-490ac357c55so65456875e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 14:40:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781041240; cv=none;
        d=google.com; s=arc-20240605;
        b=gGHDLdU/hpofwRcftVXMsVfz3Y51KDNWVsj/4C+VTf8GeBUR74vau4Kc07fHhXU7eg
         l0w18BdlPyn+Q1dwe2yr6iWWgVUcGLBjpssWiiSwmsFRkM4IRFfpGBGWY2h94kX14L2f
         DF9T6LHbSGQH74lqeU1rG/i2GqT1NKCcPxO6JW/f1c4UfEuBcZYGAVIFTnh6moYW2hHj
         MwUZCOCisZCo5y7IRo6nVn5iUOTKddyVt4fboMeLo7627jDN0HRyRNJYajScJ9gqtU02
         tuqywWcj9kkiRvrMFO9gRv6FwAHV7/SbdNTL0DV5gsnPZ5Y44Q+6o3QU19xkNkuNYErt
         P8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=axEo+SQlIOyn631n7kh9nc9Xdviab4sY310qjizLdPY=;
        fh=xzyWZZlZMsU2/LmlfFvlkY6/cxK4SmFyDMY4cYQ1sxg=;
        b=loq3geqikTe5zPrthn/+qXNipIVT1+KZEfJf2Eg1aNryVAMmjOWE/p1OHr+hMO6MXg
         gnwIcnWeo80r9jGu3LAAGHnYEPdl+6tlEVhYCcwH9k774kCo0B3pCzRpoSysvKRVA0E4
         n3wWKDwEoxddKz3l9KAZVn9bXYN2tQrkKnTGyIbjH36HenxWVhRp65kSUpoe6cEqPwhJ
         2xjqXWmXFQi3hkGnypwlu+hfUFLC7YEQS0QbVkxU5xsOPW81S7N2c7HnKPJopT+J7z5b
         5gzUVtKqgYzXB6qI9FsIsnHzz1hJs2qMXuHcWDOS2tsmZAPITvC9oftFvKJ9HV89FoQc
         uW/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781041240; x=1781646040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axEo+SQlIOyn631n7kh9nc9Xdviab4sY310qjizLdPY=;
        b=QN26/dWiS7Pb5a3p457wpprDja1FB3xQ2jbYYzzB71CrbRZknTVTsgGuNVgf/lBKJa
         QuEd0iOvLAV7XBs9SO8zk7NDnpU/sHTYoIDWZJ84rNdllSKinK6riYI/nQrtYqCJFYDC
         SUapgv7VM3o6FyGWz9c0zFLRh32ap3lnTfA9cu4D1TSXg+EfpWRRXvgAyurkkuBpJ/12
         +zrIx7Av17dNS1EE48Ts8sVCg1AP/RuLK1Csu4UJ1ur8NlqNt1f7J1dNLeX2KX8G8Xjz
         A53ruqVsUrSJoyhZGecbZHG+Fqqy0CwhMBmEn7PA0zSMWvl4xJ41/ykG1ZxwsX0dy3Ji
         x/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781041240; x=1781646040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=axEo+SQlIOyn631n7kh9nc9Xdviab4sY310qjizLdPY=;
        b=Xv+ByZ6TsN2yyrnPBQOGnxJ0DxUbeUKrjtMFoZjEYs0rmlViUhGf4HjuSEAsFNtI3V
         Th6/b1lRivKIsQ9Ht7GNrq8YBRdsQ/fXxbw+mYemosZqGphezKTFGipSOqy2gyS4B2kk
         Lq2SVIrA5LVLPgIC5H/LmQmFCAKycMpjBBWNXxc6qEOb/m+CKHmnZ6wTIFyo7ZNNNltn
         SL2FEeDCekiUWx/10C4PolFiFa1lrc+j9JfWtRFmwSB1gd94s2zAVYums5Tk12ZGxP9y
         ZaTYMudRO5j5BVBfhgT92hV0soFCqtJ+a/fZB35y88cjhv/tPQxEXZEATZ42ZrFIIupy
         zEWg==
X-Forwarded-Encrypted: i=1; AFNElJ/cCHUxP1UOJ6TUzQ6ugSyLNuRCFIlk5iVfXN5YtozpWKGeCPLkPQqeagZnM07QymhiRpsrmPTpOxe9LKNz@vger.kernel.org
X-Gm-Message-State: AOJu0YyA3TP9cc7q+nXw8pt+/O6eSipYHGiZZuLnKQB57ERt4kMl43jd
	/TWRadiC7neUlynXlVxhyT59kMNL2TheLgMh7IcZM2R+GKPvp9z7gTsQTzoyunsqfG/FQJxb6zC
	AJ4AAfJ3oONPw9bTTGdxsBIxTfCjv/EQ=
X-Gm-Gg: Acq92OECawzMpScB4YbDbYnHhbVKUK5TouBZPXP5W8fCbFxejqZMe4GfSm0mRugjSR7
	m7fYmTgtPG+xzNtYIHvh1WGWGJFCT0d45iwGXiBtVnrSxWV6H3GWplWA32KyqsA5ZXm0PYngCYM
	U+HpPYXfoEqA+bHLMXl6kCOZSVaievmYAqoRQ+GEDXLPwE6/mSJtAEfpFCP+ejTu2i6fF4YX3pG
	O+GFFr99PtKieUj1xNhNCz4l5LPuufo2eGE5Z8u7qZWQjDdJBTRS0Lewi0991Ny/EIoGTeufZir
	Gg6CZyBqOG/0c9tQdGvEanYKAGqTzS+4HLw1xNzinC0AhklQjmCrrJjOXraCSqSHF1yqhmzhIA=
	=
X-Received: by 2002:a05:600c:c493:b0:490:ae52:499c with SMTP id
 5b1f17b1804b1-490c25f1ab6mr380457125e9.21.1781041239953; Tue, 09 Jun 2026
 14:40:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFmvuTWx0NUnC-q6T=SAWLJTEp-fvueRqgPQCFtULmGngUs+AQ@mail.gmail.com>
In-Reply-To: <CAFmvuTWx0NUnC-q6T=SAWLJTEp-fvueRqgPQCFtULmGngUs+AQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 9 Jun 2026 14:40:27 -0700
X-Gm-Features: AVVi8CeB_SmQM9KraIx1CKihkd6E4Tq2Ga_Y3W0uUXXUkxC5i3wvibEMRiwOkHg
Message-ID: <CAJnrk1YjZZGzzup5biMq+SFuMK0pp8O4ZLTEjji7oJGD6wJNNQ@mail.gmail.com>
Subject: Re: [BUG] fuse: KASAN null-ptr-deref in fuse_readpages_end after
 aborted splice read reply
To: =?UTF-8?B?6rmA66+87ISc?= <neck3922@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	fuse-devel <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 2:36=E2=80=AFPM =EA=B9=80=EB=AF=BC=EC=84=9C <neck392=
2@gmail.com> wrote:
>
> Hello,
>
> I am reporting a FUSE read-reply bug reproduced on upstream v7.1-rc7
> with KASAN enabled. The bug was found with a local syzkaller setup and
> was also reproduced with a standalone C reproducer.
>
> Target files:
>   fs/fuse/file.c
>   fs/fuse/dev.c
> Subsystem: FUSE
> Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git
> Git head: 4549871118cf616eecdd2d939f78e3b9e1dddc48
> Kernel release: v7.1-rc7
>
> Observed crash:
>
>   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>   RIP: fuse_readpages_end+0xe5/0x650
>
> The same reproducer may also sometimes surface later as:
>
>   RIP: iomap_finish_folio_read+0x163/0x230
>
>   Call Trace:
>     fuse_readpages_end
>     fuse_request_end
>     fuse_dev_do_write
>     fuse_dev_splice_write
>     do_splice
>     __do_splice
>     __x64_sys_splice
>     do_syscall_64
>
> Root cause analysis:
>
> The crash appears to involve the FUSE splice read reply path replacing a
> page cache folio while or shortly after the corresponding FUSE request is
> aborted.
>
> In fs/fuse/dev.c, fuse_try_move_folio() does:
>
>   replace_page_cache_folio(oldfolio, newfolio);
>   ...
>   if (test_bit(FR_ABORTED, &cs->req->flags))
>       err =3D -ENOENT;
>   else
>       *foliop =3D newfolio;
>
> My current understanding is that replace_page_cache_folio() can detach
> the old folio from its mapping. If FR_ABORTED is observed after that
> replacement but before *foliop is updated, the completion path can still
> keep the old folio in ap->folios[]. Then fs/fuse/file.c later does:
>
>   mapping =3D ap->folios[0]->mapping;
>   inode =3D mapping->host;
>
> and faults because mapping is NULL.
>
> Reproducer:
>
> C reproducer:
>   https://raw.githubusercontent.com/neck392/linux-kernel-bug-reports/main=
/fuse-readpages-end-v7.1-rc7/repro_fuse_readpages_end_rc7_userns.c
>
> Symbolized KASAN report:
>   https://raw.githubusercontent.com/neck392/linux-kernel-bug-reports/main=
/fuse-readpages-end-v7.1-rc7/clean_c_userns_report_rc7_fuse_readpages_end.t=
xt
>
> Kernel config:
>   https://raw.githubusercontent.com/neck392/linux-kernel-bug-reports/main=
/fuse-readpages-end-v7.1-rc7/kernel-config-v7.1-rc7.config
>
> Key config options:
>
>   CONFIG_FUSE_FS=3Dy
>   CONFIG_KASAN=3Dy
>   CONFIG_KASAN_GENERIC=3Dy
>   CONFIG_KASAN_VMALLOC=3Dy
>   CONFIG_KASAN_EXTRA_INFO=3Dy
>   CONFIG_USER_NS=3Dy
>
> Runtime conditions:
>
>   fuse.enable_uring=3D0
>   unprivileged user namespaces enabled
>   /dev/fuse accessible to the reproducer
>
> I verified the C reproducer by starting it from uid 1000; it then creates=
 a
> user namespace before mounting FUSE.
>
> Brief KASAN excerpt:
>
>   Oops: general protection fault, probably for non-canonical address
>   0xdffffc0000000000
>   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
>   CPU: 1 UID: 1000 PID: 399 Comm: repro_fuse_read Not tainted 7.1.0-rc7
>   RIP: 0010:fuse_readpages_end+0xe5/0x650
>
>   Call Trace:
>     fuse_request_end
>     fuse_dev_do_write
>     fuse_dev_splice_write
>     do_splice
>     __do_splice
>     __x64_sys_splice
>     do_syscall_64
>
> If you fix this issue, please add the following tag to the commit:
>
>   Reported-by: Minseo Kim <neck3922@gmail.com>
>
> If you need anything else, please let me know.
>
> Best regards,
> Minseo Kim
>

Hi Minseo,

I believe this has already been fixed by [1]. Could you verify that
that patch fixes your issue?


Thanks,
Joanne

[1] https://lore.kernel.org/fuse-devel/20260519052807.1924269-1-joannelkoon=
g@gmail.com/
