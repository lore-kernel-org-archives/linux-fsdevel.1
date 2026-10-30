Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793375820;
	b=Q3tYQd9w9ed2rfW8U3wVcTZX46Ur6+DN1dHPDdIvElUBo8NFLzYs08W+B+617oelpU8v
	 prCXHVdtwZGTLu4H+EZg4608S1Ec5ce3IzQW26MSXoK+AmIF9RqgqhMCaGB2H8SghrZ87
	 D/fMuUDMZsjfaT3o69O9U9w1ljElATc1X57e6Q27FU6ZaeZYN5yRfD01NeadFOW5CTrfR
	 sSuITGrwRh8v8nTKv0jGqYt0T5/J2BEZ6mKSCXuBuVdz50KgVLUBy2FpxXJ4g+NQFwCtr
	 CaDDIfgWorEGLTRa7d+5TEGphpjeYcjfurS8jiJ9D5EfnktEFZnpBBT3dFURnf06+vA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9sTqkrpbygkHHAn3W77D6Qgnl/U67Hb1cA44+FTHE2g=;
	b=qmz2VWfc9nIxn8IBp2bSew8JayVtpG13q1fTzXaUNrUk3PjyXuMInnBcf0m1AjV0188/
	 XZtnk3OWHkCCpmJZg3+T1TflkbIjdiXD3EKOGgNeGHNeLYVLDIgpn12yPcfQyV6sAvTXr
	 +TB2NMQR7TE5ZwFCn0lVS7IXoGM6+p82YQmyacZ43Ew8a4LTpQJNVghNIIoViDDE4kapz
	 K0lEV2luYnFETC2rhnzETWyNygd3XmfRMbqSEjuSMIndQDZltdlj7Mc6sIFMMKyp4Hzle
	 8dMacUXAwGukK7b1J24JbMBFIurAcJzclLLqFjSkhmYQkp/nQFHLrNXSUy/FYG08lPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OjRKkLiG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2976F606A31A
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 15:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2976F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OjRKkLiG
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c247f6687dcso150305566b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 08:56:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793375818; cv=none;
        d=google.com; s=arc-20260327;
        b=lSbavEKFD4iz75I08wklgXEzlSgL3vXWCBJwd20cHxN6sP22EBa1J9VgJMUsLeWxrv
         TO3k28VAf6mtMYazVDPOVZWyrYqIvOUcfMILkg/vGNTH1Gb1e+0IKiO7QSdZDR/cizJa
         2tjyWwryyf5QrXTF5B5K+lxcEEtcsHdcn5bRYeoeVIjf/l4Jh4A9KhjiSTdqSLk4so56
         p7BuZCTWvNOMAVv6LyrfEdXbc79emidFcoX2PgCkTK7Wriq2eycPqPfSsRNJh0GWfx5D
         mas++vOO7iCHO9eE2uvvh59BGbzqH8eO7koa60Sruk7zgJuxvPe0f3J42T2//cqZytvZ
         HJtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9sTqkrpbygkHHAn3W77D6Qgnl/U67Hb1cA44+FTHE2g=;
        fh=+8KXineQXoUyF29gQgtg19MbHYY1+ygoCEH7Fg4/kV4=;
        b=rEFEcGJdfuwNPW3V2cgH6Z2j4nQVqJPk9Z+ESMwRwsf2bdC98KkkDUdN6LnPGgiyIo
         Cthkbouje4+mribDWSxeIBLhBRVwLG8Z25nVhfKeY1+wqdGVZ++xM8uWgP4m0w67pbnH
         LVXj5na0QN6W2MdIr0TXQvMr4poWELL/+PzH1S7M4beP++fRi6pYjUXReN1k5LCibz5g
         KD1BoQX/Jq1B38FllKy4R7DyPTBopVdHn8gclKzstQvUA4yl+cvIAmP+ObiJRlKZWvs3
         1HD4EVJ4kTPpSsLfkL+pr5Dn48xk7/FfIBw0XS6NLZD/CpNeMY+pYP1GT24rMVeGG9pU
         soGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793375818; x=1793980618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9sTqkrpbygkHHAn3W77D6Qgnl/U67Hb1cA44+FTHE2g=;
        b=OjRKkLiGaKyHjaravi82Hmc+5/9u4uxjeazYL0gg2S8oIES19Pa9eWEhmpCQ7NGIzT
         qiaRCa+MVFQrjlfscALM0xzpXMAIQcPusuGhEL1fZ5D/goPkNUKehujR44Ybq2iA2ws7
         JufXDxD18MKYc1W0mjsS5cJr+OwBwk6Gwki3R7nO0gUfuoEvW8DZXclS3YLLj/q8RxUV
         Bl3yBt0RH11OZ+BAzmY3BXdiLfYynilVgz7PnymBCcZAL5zlTL/rbimiKmYDIj8GilHY
         dygGELV1YAyN/hxR82zX3yOSfqX+YfkoZZknanOGo6VhAQZ38/o8QXd+xk2FwvIqZ+bs
         ml8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793375818; x=1793980618;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9sTqkrpbygkHHAn3W77D6Qgnl/U67Hb1cA44+FTHE2g=;
        b=rkMtLC+/BZBP1QKrB39Bwhxbb/UxY0jbyKlKkhsRY3pS49cyIm8Mpf92+LYRHd1X8j
         /GlTvzUr0rE8E8dY0WD0WS2SbVYY+QM7n3u+g413c9W7Qb37/ojiwPzqd5WLHHJI0oR3
         RpwyZx+D+vTsdbOZIWbLLZV+CiTIodbbv9X7WvB4AtLppnIMlmU8pFHZqoMSHm2K92bn
         1cxK008h11ImgvSZvKYhokAxGN39yLDSoatyvCpNfG67Gqs1R2mFwQphMHIDrRfi6K+F
         gD9exIVrWFOL+Unhvz1hRNTFW5kTRt4XOffEpYu3FCRdYdsp56TLH6s0WfDhWpUn7rPP
         LVVA==
X-Forwarded-Encrypted: i=1; AKwUvByNfG215YjzgCSNzuLzGV/6lKk2nqGISx9pqB+rhjXSlU15Yu0+uMe7gbZZwOPY0M/ONi8fpe/gSHE47g8b@vger.kernel.org
X-Gm-Message-State: AFq9FYKeUOufk2hHlPXzIDZan9LejBxwU2lOpiD9QFgscuRrZ6rFYl1H
	hQ/quc8UfKoT69ZQQk5MiGGUY0LfIYAXToVXYqVLkTNUOVq3V7bWeYR/DcTElgxktnAHliKVFeR
	UUtnadq5q9QZaru7kAxsX/Gu68gneJ20=
X-Gm-Gg: AYBFou3mIfoIzSybHpagUKX9oCFC/GJYJ5qjhesqQeqLRabxbP0ZLkyWsewppH4lTUO
	KNujykj37/GoLgdgeImVaeUpiPALh975PydItYf7fWSmA0Z/2DAXxcVnfoUPuA10IGywV9xAGh1
	N2JYg+Zb3Q0P5Wj6WMMM5Onc4TgmhV8xRzEmQqvF73XakDkHlttCsQ9oxvva1TZONZOa+LttSxs
	ubMDA4WORN9IDMFQm1q+3dxP2jYy2kuMMURxBTKZl3iCueO7JtEYXXdESFbLL4D8DGRSV2llT8E
	y0p2AySr+ITwhxc9Z5agCQmtCxNY1jEQ445sa2Y75CHjOaXsS9si6mfnEXjn6lOIAJhUovjNNFu
	6O0nY1Uw947NgpS02ljOpZ9b2FAbWzKloQ/Q3FB/IRNAgMsr7aQ7CYmvlTxbAnTf5W08fIA==
X-Received: by 2002:a17:907:2d25:b0:c41:6de7:7dde with SMTP id
 a640c23a62f3a-c4ca7935796mr266982566b.4.1793375818484; Fri, 30 Oct 2026
 08:56:58 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261017165103.2450042-1-amir73il@gmail.com> <20261030-pluspunkt-kreis-lawinen-274971662578@brauner>
In-Reply-To: <20261030-pluspunkt-kreis-lawinen-274971662578@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 30 Oct 2026 16:56:46 +0100
X-Gm-Features: AclHuK8ktVjbNgP72LOLPxL3i8bsMNAmY3iRRrASzvsBRvXKm994u3R-fHL5-MY
Message-ID: <CAOQ4uxhFFPq0tjbbZo=m2tGx=93Tat2hs5K3LJ_moW=Ca8o12g@mail.gmail.com>
Subject: Re: [PATCH] selftests/ovl: fix detached layer mountinfo expectations
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Disha Goel <disgoel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 4:12=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sat, 17 Oct 2026 18:51:03 +0200, Amir Goldstein wrote:
> > set_layers_via_detached_mount_fds was copied from the attached-fd test
> > and still looks for /tmp paths. Detached open_tree() layers are recorde=
d
> > by d_path() as upperdir=3D/upper, workdir=3D/work, and lowerdir+=3D/ an=
d
> > datadir+=3D/ for each cloned directory. The test has failed since it wa=
s
> > added.
> >
> >
> > [...]
>
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
>
> [1/1] selftests/ovl: fix detached layer mountinfo expectations
>       https://git.kernel.org/vfs/vfs/c/8457ca071fab
>

Sorry, I forgot to say that I already took this patch to my tree.

This patch is already on ovl-fixes in linux-next of today.

Thanks,
Amir.
