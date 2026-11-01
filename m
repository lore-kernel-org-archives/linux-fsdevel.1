Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793554162;
	b=IwXLgwKvb72kH75JneiybbBxcCfHpVgaf5EYwno+348xsT3tpBuzZ9pphRE4O7PO4L6Q
	 2GkLoNJFt+u3MKzL++rIdHf8PxO93E55m1/1ii0OQZF7pPEWFQnaueWyR4N7L3zl9WojJ
	 AhBL/0vLj3UR7HGZE8BGpscMsHT72IpfgQ92TrEcftAXXCpR/83BI2uI8ltsZGpd1IceV
	 88PEoNJuKzfm5CPeapxEBpRnpw78KUolXJjOQMo6LODmJfrldXlowdTbiS8D248606TJF
	 A8ck6Hbni7WnlvpxpjR+qjvbgwsywVzoAN0YE6bQFkmyvHxs7dghiKaRl05AdbSpLPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=GvChd4JYy10u1btJ+yrRPy/YPHs86LB5NdY1elP5AlM=;
	b=BXs5yEhC/lgd5QELKlgkggZrnjcHzRFSc0On+Vn7Pc9I4eOhlatR42wJPVA5en6H7rKt
	 oUzhmC0lPGp8ErxFaCHtNmtZxjdkzND9PHSjoVj1ujhCVcs3+bSNhXTxeu/pM4nVpVNPS
	 fGcchUlj5UfYnPsCpNuiTBZrXPMKESph/iyDivgNhElm3bCiKJUxFl+QEvcuegzxyyCyD
	 VR+Uri6f9u16i2Yb+GerBlkn+pBD5ZYc5F8VupFtS9Az3XkkCCRenSnTnlo8hG/sVyvkz
	 SxYYU4okJIF9mrwJzzPRTkhL3FYNUBHKY8gYhqoSE5OjZgtNrZGigyPPmoazuC6hu2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sKv06dl4;
	arc=fail smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4AC606A326
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 17:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA4AC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sKv06dl4
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1aa2848d2so3175981a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 09:29:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793554160; cv=none;
        d=google.com; s=arc-20260327;
        b=KdkC+Z/HTNNqos5TU9ZHDYU4jMWmOnGC7q555wXTQJOoWRoC/93eiPmn3iZKK0Vinm
         pv9QYdpi4P24cEhJox4CR1tX1VT+s+fM8hqByUPy3WtnB+FXzV03qJxuBVLPCPGfD6Ac
         +mu0R3eRRjet7VvMUZFwG7Q1UEq9tPGk26N530wz8cdBE3UJxbEiAzcq+EMPTBNrP7sJ
         VyYAwUp/+SuPjIScHaQReI/5RGLaEpiFCoMEiHCC1yuyu4wir4FNLdZAkp7Gnoz55beA
         gOxnbL4W6Ylwje426z2ELiU5ab4O5xkYITIn/uf2y1DgSw92z6pVv4SfrYMZ2v5RrwpN
         WumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GvChd4JYy10u1btJ+yrRPy/YPHs86LB5NdY1elP5AlM=;
        fh=H+djTcwfuno69HLsHbp3IfLy3gA5DBQJQ0Tdem4K+S4=;
        b=FtbtffvYBgCYradVfW4b9xu7xArDgGrNkU8OFOZhCknPLjPcdOjHECcKr3w0x2CbxL
         1gmBIg7JaQr2YY0RG/5Q9xurL7vqvgiGHZS9Tc5rkPPGnAZaXng2jt23DAZc4rgrogXn
         ObbzAeBCX9tqc9pgpXTsk4DYB6lyVrZbuxqdgLYI5sozrAPslNXSee/dEUbi8tr+lWsn
         m+w7KWgsMYFuLIXaxQ5NYsa5rM0t9E+u/F9xUaTtHWLdsBow/02POBVnCRd+F0pht9YI
         Cw73/karPTTFyPrU2WAWPtjL/m51C+04bkhrOMmaGmTAirL+sLKrOpl0kRbO/0oiuA+/
         wXyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793554160; x=1794158960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GvChd4JYy10u1btJ+yrRPy/YPHs86LB5NdY1elP5AlM=;
        b=sKv06dl4odqaiU7BKf335nq5m5DKh3B+4gZ7v//6pb+I/cbZusHIf2IjSRSoSJN3/k
         PU3WmCMq/CSEGSo0Nx+6rvl+IU+XckVYdVdg9JEUl3xOHQtpF17jHIKC5pkDmqPXs+nF
         K9TkPj/YmDj6pqA+BDsApcRfPOSLM7q1s75XUFwOCtuWpuU0HAFhAAZ1mf8lUBiiYISi
         X8tfBcnQfUg8ligtyRwkleLPO9GHBdRMNO/HtQJHbaoKfsqikElhOKuPOUhKDoHaR2w9
         E75RVNEXUuwU3amCYW2obMMcxaqqjiCu2N2GxCHEp9aO8xFJ+1FtAWL6fftbT8jP8kte
         mv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793554160; x=1794158960;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GvChd4JYy10u1btJ+yrRPy/YPHs86LB5NdY1elP5AlM=;
        b=uoiwrFTLMO+1suZt6Cx/yDMDVx/zwkUmKeInfMYDk8mGh9aRrC/sISK5lVshLCcb+q
         Xs8keUF+yVoku3BhwKAye8EOyYwGY5/ZO9rwoA7nXMAl/JQ3TJ2DlYN/v1mSnER7ki1Q
         ad/nFSILoCDA2H/zsSWroHqvWtLJpgpRHDE1g47jqrHuvYwGKQCfwDkRvV0QbGVQz2O+
         McuHSf8s0ioHk4lMmZjpnkcJvOzUViUrmM3iFURz4ndILprRdB3QISUFKb2uL/jJhd6l
         NM5AKdaJwxHrggtzVhgt93X3KKouECDOOPk5/XM8ggyZZewX54z9qRgjJPmlNkR8O8cy
         meLA==
X-Forwarded-Encrypted: i=1; AKwUvBwupMUOpyPByA0c4zwxP8vq11tsu63KgTAUmYQtyocBc3RAV+GeMhCX7mvrFwcwxiEHM2tSXF8vCvKCOrqX@vger.kernel.org
X-Gm-Message-State: APuU4Z8izNLXzQWbPuQVIPqJ6rdVhryUx3uAnawdsGj1i5fEMwPPMrV8
	AkpXpo9gDYMnTzgMMX7g/E+2TmDtNqdnwzlmo2ALhhJR6iniMUm6ak1wdWcEV1SUm8ud8LqtJax
	esE3NGy0TsYN2PapF8wnoIxI8c3k4lkE=
X-Gm-Gg: AYBFou1MM5iEZzrq/g/HpQ7aTGhKHY/glXo8E8sPWxWtdWPq6X4IORg1V/dRSMEbUyx
	e/7uV5ivP3d1D4STLUUtzeqaIotreboBMonmR49ZAOK5sFUzonGET+M0Td5U7DIQzG8hc5SJ4Kd
	KzrNYapKkbh3Xcw2I67xo//qgxlGZe1jiKqYVp+eoIvK3EmAf1OrYp3NCbja7vpV5bKLrPQfBTC
	M+0Y2PHQrQn0KWP0lEtY3MUS/5XNqutYY+Q7Grod927JnBsXzGCl++EwlwKSMBIHNBsELssnAO5
	kjZKyinxKg99BL0HtVK9LuDMuvLhf7IR+oWWnFSA682VihWm20Iw3seKTllXA2KJ0NTdaU2NXA1
	jwyfT+Vw1kJkidZoL00AugDLqW7+89usx9lsIiZtZF2C3GY5tvuVW2MsqFIT+YnCfAkK+dUk=
X-Received: by 2002:a05:6402:90c:b0:6b4:5a9c:4e44 with SMTP id
 4fb4d7f45d1cf-6b4d5256569mr5096964a12.37.1793554159089; Sun, 01 Nov 2026
 09:29:19 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAGEkeHcg06kHshHQ=9U6Yrs_wm8W9H28o9bcC2Qh3fw3tANbWA@mail.gmail.com>
In-Reply-To: <CAGEkeHcg06kHshHQ=9U6Yrs_wm8W9H28o9bcC2Qh3fw3tANbWA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 1 Nov 2026 18:29:07 +0100
X-Gm-Features: AclHuK-VCf9zGbrZt2QDekrQdgyRUMpGY8ViftLR3gMUBXwZf10WjO1d0UfPYwY
Message-ID: <CAOQ4uxifWJHKAa51cAzYOWe5W1TBV3jftrwvrCqCgZG16Df6iQ@mail.gmail.com>
Subject: Re: [BUG] overlayfs: inconsistent d_ino in overlay/077
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 10:53=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> Hi Amir, Miklos,
>
> While testing the casefold series on arm64/QEMU with ext4 backing
> filesystems, I hit the following overlay/077 failure:
>
>   entry o100 has inconsistent d_ino (131490 !=3D 131280)
>
> This also reproduces on ovl-fixes at 1d27da7de3f7 without the
> casefold series applied, so it is not introduced by that series.
>
> The failure depends on directory ordering. I reproduced it with
> the ext4 directory hash seed 00000000-0000-0000-0000-0000000088bf.
> The upstream overlay/077 test and its helper were unchanged.
>
> It appears that ext4 returns a buffered entry after the file has
> been unlinked between getdents64() calls. The rebuilt impure cache
> no longer contains the name, so overlayfs reports the physical
> upper inode number instead of the lower-origin number.
>
> The symptom looks similar to the merge dir case fixed by commit
> 9011c2791e63 ("ovl: skip stale entries in merge dir cache iteration"),
> but this one is in the impure dir path.
>
> I don't have time to pursue this further at the moment, but wanted
> to report it here in case someone can take a look.
>

Thanks for the report!

I wasn't able to reproduce this with minimal attempts,
so I will put this on hold until you or someone else has time
to work on this and provide a reliable reproducer.

Thanks,
Amir.
