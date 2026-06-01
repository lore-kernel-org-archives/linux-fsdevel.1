Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E6333DEE9
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 08:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302719; cv=pass; b=VsZ6tUlL/6NOIQID/W75GETqLuXEc/Uli4+lC/zBMFTCIvq/jPTVvIfMOFX1fEQJFBuToKhvc76rU87aP4opUrp91aJATFTKIziJcsrZj93K/MzLD/pdrTn6WQkqdH9HngTpbiGlehRPCiAy3p6gEPONmNnXsKBKsy0BGIhg+V8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302719; c=relaxed/simple;
	bh=QOVrh1FbwZicINPjAxgtLi4dWQT7CNzOI6a3e85aE/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBvxl5j2FZPTTXW9VL9ez5fzWNvguq3fA2HGmXQ1X+ulaMykpEVbr32gbFHuMevbQUpIbrrckrBzRUZBBNBw22D0FwKU6czd8fYvbkrBOjMYbNTbrwX54V+4OKUyZ/46kWLpWxP0SghSgg+yZsvmkOsOCUy9NDEmjtj0MAzzO14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=H8Ff6BX2; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="H8Ff6BX2"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51758478240so2323171cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 01:31:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780302716; cv=none;
        d=google.com; s=arc-20240605;
        b=Gz2lZRrtbcxZpW4hNJczkVEJyCLJp5zlw3oh9tKcSwnltaCh3p2jHPX9V1/QTVKNXB
         kCc+wRXH+LzYZRRBY+wjQF7Z+gDSIxF5z4X44INaxtGgqBPjgswbeg6SMrmYOlKE2gy4
         bzD/zLWw9tB+Zew3HxQF78PEukT4gIZSBX6vEu2yv5wsoqf/zK+O/6cjwhGhf+/XLG3D
         CGiNE7uweFhz15l73MhFasUFebUgVb/koDkz5Po5LRNN2yOxLSIINRIxgxr4n/avFO75
         XWLYMpvHSNQs6kyFwbBIBBKBK09v/pXrpsfU4ueGM+Q27Nh4ejIvpIR3EQgYVo5HKZ70
         LpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9zCuIe74ELqugw1lXwosD6GadoLnKPFUrjvsZt3Tyts=;
        fh=3zUFdfv/MtTyplvB3Emo5MvCOcEm5E40VULZ0CQ6I3M=;
        b=CwavktbaZUDQ8Ht+t9aav4Rr8ZVK0exSY13QYJojZzfzYnsr/Kj5Qq7eUb87udXLdF
         5u7ZsvtxmDJMz8EdCT066+4tA2NIqb6JC7AUhpuexCxx6dWCZmBfZH8+gEew5+QIJfWL
         zHTWHr0j/uHo7S1EEBn5EN+8YsGYXdEkF+89t9rLb1SU5KJq6nrHzL3XH2lHTHyqeZfq
         u+0fE9Q5koOyMgtuV8cX1KSBwOOO4U6SHpiv4UdO3hNN1jrLQ1zIasqIbHFl8eWf9XWq
         CcR6nfkn40XA6usUUJ3JcNfgxMqsT1gboOR/IjaS1QkFV5CXbmqPrp/ovk0wXG+bEQkH
         wm+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780302716; x=1780907516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zCuIe74ELqugw1lXwosD6GadoLnKPFUrjvsZt3Tyts=;
        b=H8Ff6BX2N8q4W0B6ogje2SGU3CrxGzrecioLhwIaOxEvW/EIzjG0+rFKxkmG0/VMJJ
         E1AV1867Rp8oAkiee9taSAP+QzBgMp3rZjB0AtOQxUb6fJDYWNVWDdIpURMg1BE4Stlt
         9BN1wML+sObW8gK8OPvhjIOFYKJTVqV/GE2ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780302716; x=1780907516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9zCuIe74ELqugw1lXwosD6GadoLnKPFUrjvsZt3Tyts=;
        b=VIvi32SBWB5ll+mthlteKSLSzL28Ry4E2YImkXlkYiRjaZJ2Kz9xN9JWPzLz/KGJiF
         Ur3lhpGMmr95yb+qRETKasfiZZzj3j9gWNRbQEF0y/ml2h5j/P1Bo7gJ+rOJapzh2H7n
         hp/w8TxKnvcyQCz3Ho7LfT3DlrC7VAzbVgsT7e4MA3lvAq5zPZJHW2WVGPTmIQ0IkJds
         IUAqik4ErtK+5RCwPOw1VWdqHJWHp/5mKaU9HPYE9xGmzTAOWb9JAsXEn/PaXSG9i7WI
         8PIWG/h78hmQkoG3qt1WK8m+lHSk5bSXPbiHndYB16pS2Kk21dcpmNa/9akPHKY8pGNn
         9MIw==
X-Forwarded-Encrypted: i=1; AFNElJ/X5ToPX3FG1am2rQOI2JH/PPbQlmo1LSN+UucO0WQDwYFbizBcAbCt/IlN7n12A/ZHFdKfRvXw2spXB2xT@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjy7fFpFo6LQJSzPUvNYNxO/VkoNOAJvJ3X6PVM/tfSfh/f3Qk
	SYLG1yHQYWE7uTIOqRwGQOBIN9y/Uxi7nK/+ZBgz/j9fNMOBeZJzC4tJCEsxWPtvxGyvPwlSyac
	je65pK2qn+LS0TpkZn0pH19Lrc9LPC5zq7Ip5tdtZ9A==
X-Gm-Gg: Acq92OFbNYIpuWYdzB/iGMgMZ2H4tKOkq/B2NWarVetvfJkLsQDAzQSJOe8vt+jUhQF
	zdiqRLAXkZjoIuL2PSliLamR9e8Q/nbt/GCwNLAwydUkzE1Tss2PnnpIn2c7egdbAzHCc0UoJR4
	HsN6Txhjq2ru8EqVUIzWmJlnKTHFtIEeDPNRSqmEyFxPFW4WCAY00QETPsvVcBGE+93QSYiC/1i
	PDclUH/8r9BUri3RwZ7f3r8UzDyiGKhapez/IDMETpOpml++DlBBsaL3CucEgsYeZzFFbcxpSLy
	sBNiRouZM/Fz5acxUGZS98irvFPkSxIcRLbyZ038TaS4AdCZFQ==
X-Received: by 2002:a05:622a:1e85:b0:50d:83a4:2995 with SMTP id
 d75a77b69052e-5173a734ea3mr136021221cf.21.1780302716350; Mon, 01 Jun 2026
 01:31:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFbF8N7++zopZuEcsKRxBV_sgOGCbzCY0hOyMw1SiGAtuzGhyQ@mail.gmail.com>
In-Reply-To: <CAFbF8N7++zopZuEcsKRxBV_sgOGCbzCY0hOyMw1SiGAtuzGhyQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 1 Jun 2026 10:31:44 +0200
X-Gm-Features: AVHnY4LE7eOT2gpMeRX9HfjuDk28txdWMk79He47NTx4XuEv3dO-iZ4wnJqEPwU
Message-ID: <CAJfpegsCJnMfn_BzzTK7m9ndCGVsnPit8ZsT0fzAhYoY+yOsKQ@mail.gmail.com>
Subject: Re: PROBLEM: FUSE_NOTIFY_INVAL_ENTRY leaves stale negative dentry
 after c9ba789dad15
To: NeilBrown <neil@brown.name>
Cc: =?UTF-8?B?0JDRgNGC0LXQvCDQm9Cw0LHQsNC30L7Qsg==?= <123321artyom@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Cc: Neil]

On Sun, 31 May 2026 at 03:12, =D0=90=D1=80=D1=82=D0=B5=D0=BC =D0=9B=D0=B0=
=D0=B1=D0=B0=D0=B7=D0=BE=D0=B2 <123321artyom@gmail.com> wrote:
>
> Hi,
>
> I am reporting a FUSE/VFS regression introduced by:
>
>   c9ba789dad15ba65662bba17595c0aeaa0cfcf1c
>   VFS: introduce start_creating_noperm() and start_removing_noperm()
>
> After a FUSE filesystem returns a cached negative lookup for a name, then
> later makes that name visible and sends FUSE_NOTIFY_INVAL_ENTRY for it,
> readdir() can list the entry while stat()/open() on the same path still
> returns ENOENT.
>
> Bisect result:
>
>   good: v6.17
>   bad:  v6.19
>
>   first bad commit:
>     c9ba789dad15ba65662bba17595c0aeaa0cfcf1c
>     VFS: introduce start_creating_noperm() and start_removing_noperm()
>
> Adjacent commits:
>
>   bd6ede8a06e89ca5a94a8b51cea792705d1b8ca2 GOOD
>   c9ba789dad15ba65662bba17595c0aeaa0cfcf1c BAD
>
> The bad commit changes fs/fuse/dir.c:fuse_reverse_inval_entry() to use
> start_removing_noperm().
>
> I attached a minimal libfuse3 reproducer. It does:
>
>   1. lookup("config") returns ino=3D0 with non-zero entry_timeout, causin=
g
>      the kernel to cache a negative dentry.
>   2. The filesystem makes "config" visible.
>   3. It calls fuse_lowlevel_notify_inval_entry(root, "config").
>   4. The test checks whether readdir lists "config" and stat("config")
>      succeeds.

Yeah, issue is that start_removing_* all work on a POSITIVE dentry.

FUSE_NOTIFY_INVAL_ENTRY works on both positive and negative dentries,
doesn't care about the inode (or lack of it) at all.

I've not dug myself into this work, so not sure what the concept here
is, or how this should be fixed, but this is definitely not (just) a
removal op.

Thanks,
Miklos


>
> Build:
>
>   cc -O2 -Wall -Wextra repro.c -o repro $(pkg-config --cflags --libs
> fuse3) -lpthread
>
> Run:
>
>   mkdir -p mnt
>   ./repro ./mnt
>
> Observed results:
>
>   Linux 6.17.0:
>     notify_inval_entry rc=3D0
>     listed=3D1 stat=3DOK
>     GOOD
>     exit code 0
>
>   Linux 6.19.0:
>     notify_inval_entry rc=3D-2
>     listed=3D1 stat=3DNo such file or directory
>     BAD
>     exit code 1
>
>   Linux 7.1.0-rc5-00426-g670b77dfebe7:
>     notify_inval_entry rc=3D-2
>     listed=3D1 stat=3DNo such file or directory
>     BAD
>     exit code 1
>
> #regzbot introduced: c9ba789dad15ba65662bba17595c0aeaa0cfcf1c
>
> Assisted-by: OpenCode:openai/gpt-5.5
>
> Thanks,
> Artem
