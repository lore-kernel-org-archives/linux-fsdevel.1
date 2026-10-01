Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9FD486430
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Oct 2026 21:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790890698; cv=none; b=X7E/9ZGnt0uR6/u2oINpRwAmE7wbD6aMV7LCqmyvhOWGwsZRBqCP1mBONCzai+A/mFvkVx5JfMx2Kw7CSvxLG9DH1kJtUwkWHZA6AU06aLSfXdqWRhRRg03TnUvU+Xy5qaO3tzg9Fxz4OY87UkdnK6ugpTylK5BHoeZfW5cJwqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790890698; c=relaxed/simple;
	bh=KHTm2ZAuMqDusI0/efkxx63Uc48N7w+nndf1PFY1OoI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SOx/9JLyWkdOM72udbQDVoauvUiHK0ghJTbZjcDRnDNDF0ZZXtXOHil7fzsubAEhl42rwBqWBSXO5siAdZyQYHedSsWeXY7o+kMrBGjfd0lakxtyKk6ctvBkj5BrquIv9gE4eKUQ6tmqT7wWgAVHuCUQ16KkukPm32Q/LDaGshI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=P0tMe8eR; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="P0tMe8eR"
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ab3e848918so37006277b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Oct 2026 14:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790890695; x=1791495495; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5nemF20nnCuzcbK3EaToC/EqXdWnpHwhMCzou3g/iqo=;
        b=P0tMe8eRTKVV1k8EiqdqM3+/FBZbtWDGuNZwOgbIjLqgDuJsv0ZJdSGBkGX19nnr1y
         pus9GdtQKazLr1U/sSxBx3VnnxR6/UGkbnYm83X97aY9XEFIWdvoVTDXW3zZ2X/Hw09q
         JNsg4pA/roHAv15aQsHjQGwMdiW0sbQr4vgjVJAWyQ2IqpG7x0RMOGuYxnyww/oDNIox
         RqMxlvXnPPqJCRxHr4470P39+FNCk5nPdHO2Kbs13YOzcVUymFIqfm8Ki+4dHBpB5Pwk
         HVeDWkYZuFp3zauNrlgLHqzX8sk+Dvyl1Xlf6yGzpEccLpQi4sRIstUuspKRt2+z0+e7
         yf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790890695; x=1791495495;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5nemF20nnCuzcbK3EaToC/EqXdWnpHwhMCzou3g/iqo=;
        b=hQY8oknoe1yi3qO5JdsVr3C+DCTE3dyEJh2Z46yV+YgrW8a9txRz9TESvgw9gUFMVX
         L8K4dVFQrYG7YidPS5wTuxb9XB4hTQlD7ZzPLYwIRXNncByKxbdQEjpPVTgQZfmp2ixG
         kfaBmscJIiDvaffjXic10FNzUKPphB+0wKxMqDnZKxJDVdXBvan7qu7EqIFg1xhE7S53
         OtDsAv+5uR7+bbIkQRpIQDuuUjUaSxw3qZESuTF0vPC4xx3fzbpGoPlYCyDMsz6TS33g
         /koXTqYFlv6emcgTPeWwAanMtruGJTi4l7OcsaFGILq2tY/436c0k8lx9CT0nw72u6S5
         aVoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwlmKF4gMHboR7dZ58d3h+VFz55yokayBIwM7O5G5QIN6pcz8ex6+m0Mphsrt6ROdJ3N1qz+niaFRuqMAlw@vger.kernel.org
X-Gm-Message-State: AFq9FYIZVW0SS8o6QQGQ/gLQcRQr7wIyZOExx9a54U5C6fzSyw9UGBbC
	tFUgI1QQY36jbALc0CZEq1ggLzFcp7wb4+UiEMB7ttmEZmTQsnVwp1yzcWIRKUDQ/th1qr+wMt0
	h3BrzGzk=
X-Gm-Gg: AYBFou1rpT8j7bTTfHVAFxrcfta2iVogCQFNzgkiOWrAWw8jYcnj+4KWATgYLC8MHpt
	8pcMvxTPSxiDntMDsvCqOHyJGJWCisa0KmQyHW3xxRXlWDXQsVgKDMdc3fzVQRcIVf0sPCAGHlY
	LEdy0JxamcOUxEJqCBbpTB69nWfw57vV9lkjcyrmasytG4NqbjT88DaTV1mkb99AAjAbvKmvVu4
	e+XPED9t6XqIjW2BWnfFQVyAGSeiyyu+a7hevLt5gVMtiDbZazAmbHSRVcYJOodGrciJcxtNy2p
	BlO7DPXbtSQ8sfEBu2b9yCMpdYSVSVr2YRKYFWUmixvcmib9/DWTVZCqwx20BvKMxlSDzjLDsQH
	P7D7T8Uog+aa7izR41PL5FMW/DyWVyOEMtgnXmOhIQ7dW8gU+heSznuQapjavL0pRTgUdqNceiq
	zv4audOpSVrSFGyYMsjs00AwEP4W0yIUzavkmfKAYyH5QxstdPaRtS14MgFcMWnS+9lJHqomjKO
	gPQIQBrCza46XToc+rCMebK5Ll6haJ3pbEqIPvX7HWVIYUiOif/KH6oywo9vbXLUMYZpIskUI9b
	s7ZUIthxt4B3qARSFCjoTDZQ8gbbC8HUzB3iU+sTdLGD757wxHynaAjnEIypnsVF4w==
X-Received: by 2002:a05:690e:4401:b0:674:eef:ff94 with SMTP id 956f58d0204a3-677ac0d8f0fmr200086d50.94.1790890695410;
        Thu, 01 Oct 2026 14:38:15 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:67c2:3447:e08d:9418? ([2600:1700:6476:1430:67c2:3447:e08d:9418])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae32cee6edsm2198047b3.23.2026.10.01.14.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 14:38:14 -0700 (PDT)
Message-ID: <9f8b8dacee5d24c94185bab75ff905eb51a95999.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: annotate extents_lock nesting to silence
 lockdep false positive
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Mahmut Emin Kurhan <guvenlik@noroxi.com>, linux-fsdevel@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-kernel@vger.kernel.org
Date: Thu, 01 Oct 2026 14:38:13 -0700
In-Reply-To: <20261001095208.1469344-1-guvenlik@noroxi.com>
References: <8dfb90a2751df30f76ab5130960591a57c51be4d.camel@dubeyko.com>
	 <20261001095208.1469344-1-guvenlik@noroxi.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=mQINBGgaTLYBEADaJc/WqWTeunGetXyyGJ5Za7b23M/ozuDCWCp+yWUa2GqQKH40dxRIR
 zshgOmAue7t9RQJU9lxZ4ZHWbi1Hzz85+0omefEdAKFmxTO6+CYV0g/sapU0wPJws3sC2Pbda9/eJ
 ZcvScAX2n/PlhpTnzJKf3JkHh3nM1ACO3jzSe2/muSQJvqMLG2D71ccekr1RyUh8V+OZdrPtfkDam
 V6GOT6IvyE+d+55fzmo20nJKecvbyvdikWwZvjjCENsG9qOf3TcCJ9DDYwjyYe1To8b+mQM9nHcxp
 jUsUuH074BhISFwt99/htZdSgp4csiGeXr8f9BEotRB6+kjMBHaiJ6B7BIlDmlffyR4f3oR/5hxgy
 dvIxMocqyc03xVyM6tA4ZrshKkwDgZIFEKkx37ec22ZJczNwGywKQW2TGXUTZVbdooiG4tXbRBLxe
 ga/NTZ52ZdEkSxAUGw/l0y0InTtdDIWvfUT+WXtQcEPRBE6HHhoeFehLzWL/o7w5Hog+0hXhNjqte
 fzKpI2fWmYzoIb6ueNmE/8sP9fWXo6Av9m8B5hRvF/hVWfEysr/2LSqN+xjt9NEbg8WNRMLy/Y0MS
 p5fgf9pmGF78waFiBvgZIQNuQnHrM+0BmYOhR0JKoHjt7r5wLyNiKFc8b7xXndyCDYfniO3ljbr0j
 tXWRGxx4to6FwARAQABtCZWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPokCVw
 QTAQoAQQIbAQUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBFXDC2tnzsoLQtrbBDlc2cL
 fhEB1BQJoGl5PAhkBAAoJEDlc2cLfhEB17DsP/jy/Dx19MtxWOniPqpQf2s65enkDZuMIQ94jSg7B
 F2qTKIbNR9SmsczjyjC+/J7m7WZRmcqnwFYMOyNfh12aF2WhjT7p5xEAbvfGVYwUpUrg/lcacdT0D
 Yk61GGc5ZB89OAWHLr0FJjI54bd7kn7E/JRQF4dqNsxU8qcPXQ0wLHxTHUPZu/w5Zu/cO+lQ3H0Pj
 pSEGaTAh+tBYGSvQ4YPYBcV8+qjTxzeNwkw4ARza8EjTwWKP2jWAfA/ay4VobRfqNQ2zLoo84qDtN
 Uxe0zPE2wobIXELWkbuW/6hoQFPpMlJWz+mbvVms57NAA1HO8F5c1SLFaJ6dN0AQbxrHi45/cQXla
 9hSEOJjxcEnJG/ZmcomYHFneM9K1p1K6HcGajiY2BFWkVet9vuHygkLWXVYZ0lr1paLFR52S7T+cf
 6dkxOqu1ZiRegvFoyzBUzlLh/elgp3tWUfG2VmJD3lGpB3m5ZhwQ3rFpK8A7cKzgKjwPp61Me0o9z
 HX53THoG+QG+o0nnIKK7M8+coToTSyznYoq9C3eKeM/J97x9+h9tbizaeUQvWzQOgG8myUJ5u5Dr4
 6tv9KXrOJy0iy/dcyreMYV5lwODaFfOeA4Lbnn5vRn9OjuMg1PFhCi3yMI4lA4umXFw0V2/OI5rgW
 BQELhfvW6mxkihkl6KLZX8m1zcHitCpWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29Aa
 WJtLmNvbT6JAlQEEwEKAD4WIQRVwwtrZ87KC0La2wQ5XNnC34RAdQUCaBpd7AIbAQUJA8JnAAULCQ
 gHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRA5XNnC34RAdYjFEACiWBEybMt1xjRbEgaZ3UP5i2bSway
 DwYDvgWW5EbRP7JcqOcZ2vkJwrK3gsqC3FKpjOPh7ecE0I4vrabH1Qobe2N8B2Y396z24mGnkTBbb
 16Uz3PC93nFN1BA0wuOjlr1/oOTy5gBY563vybhnXPfSEUcXRd28jI7z8tRyzXh2tL8ZLdv1u4vQ8
 E0O7lVJ55p9yGxbwgb5vXU4T2irqRKLxRvU80rZIXoEM7zLf5r7RaRxgwjTKdu6rYMUOfoyEQQZTD
 4Xg9YE/X8pZzcbYFs4IlscyK6cXU0pjwr2ssjearOLLDJ7ygvfOiOuCZL+6zHRunLwq2JH/RmwuLV
 mWWSbgosZD6c5+wu6DxV15y7zZaR3NFPOR5ErpCFUorKzBO1nA4dwOAbNym9OGkhRgLAyxwpea0V0
 ZlStfp0kfVaSZYo7PXd8Bbtyjali0niBjPpEVZdgtVUpBlPr97jBYZ+L5GF3hd6WJFbEYgj+5Af7C
 UjbX9DHweGQ/tdXWRnJHRzorxzjOS3003ddRnPtQDDN3Z/XzdAZwQAs0RqqXrTeeJrLppFUbAP+HZ
 TyOLVJcAAlVQROoq8PbM3ZKIaOygjj6Yw0emJi1D9OsN2UKjoe4W185vamFWX4Ba41jmCPrYJWAWH
 fAMjjkInIPg7RLGs8FiwxfcpkILP0YbVWHiNAabQoVmlhY2hlc2xhdiBEdWJleWtvIDx2ZHViZXlr
 b0BrZXJuZWwub3JnPokCVAQTAQoAPhYhBFXDC2tnzsoLQtrbBDlc2cLfhEB1BQJoVemuAhsBBQkDw
 mcABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEDlc2cLfhEB1GRwP/1scX5HO9Sk7dRicLD/fxo
 ipwEs+UbeA0/TM8OQfdRI4C/tFBYbQCR7lD05dfq8VsYLEyrgeLqP/iRhabLky8LTaEdwoAqPDc/O
 9HRffx/faJZqkKc1dZryjqS6b8NExhKOVWmDqN357+Cl/H4hT9wnvjCj1YEqXIxSd/2Pc8+yw/KRC
 AP7jtRzXHcc/49Lpz/NU5irScusxy2GLKa5o/13jFK3F1fWX1wsOJF8NlTx3rLtBy4GWHITwkBmu8
 zI4qcJGp7eudI0l4xmIKKQWanEhVdzBm5UnfyLIa7gQ2T48UbxJlWnMhLxMPrxgtC4Kos1G3zovEy
 Ep+fJN7D1pwN9aR36jVKvRsX7V4leIDWGzCdfw1FGWkMUfrRwgIl6i3wgqcCP6r9YSWVQYXdmwdMu
 1RFLC44iF9340S0hw9+30yGP8TWwd1mm8V/+zsdDAFAoAwisi5QLLkQnEsJSgLzJ9daAsE8KjMthv
 hUWHdpiUSjyCpigT+KPl9YunZhyrC1jZXERCDPCQVYgaPt+Xbhdjcem/ykv8UVIDAGVXjuk4OW8la
 nf8SP+uxkTTDKcPHOa5rYRaeNj7T/NClRSd4z6aV3F6pKEJnEGvv/DFMXtSHlbylhyiGKN2Amd0b4
 9jg+DW85oNN7q2UYzYuPwkHsFFq5iyF1QggiwYYTpoVXsw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-10-01 at 11:52 +0200, Mahmut Emin Kurhan wrote:
> lockdep reports possible recursive locking on HFSPLUS_I(inode)-
> >extents_lock
> when unlinking a file on a crafted image:
>=20
> =C2=A0 hfsplus_file_truncate()=C2=A0 holds inode A ->extents_lock
> =C2=A0=C2=A0 hfsplus_free_extents()
> =C2=A0=C2=A0=C2=A0 hfsplus_block_free()=C2=A0=C2=A0 reads the allocation =
bitmap file
> =C2=A0=C2=A0=C2=A0=C2=A0 block_read_full_folio()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfsplus_get_block()=C2=A0 takes inode B ->=
extents_lock
>=20
> inode A is the regular file being truncated and inode B is the
> allocation
> file (sbi->alloc_file, i_ino =3D=3D HFSPLUS_ALLOC_CNID). They are two
> different
> inodes of the same lock class, taken in a fixed order (regular file
> first,
> then the allocation/attributes/catalog file), so this is not a real
> deadlock, only a missing lock-nesting annotation.
>=20
> Mirror the existing hfsplus_btree_lock_class() approach: give the
> special
> inodes distinct extents_lock subclasses and take the lock with
> mutex_lock_nested(). Regular files keep the default subclass, so a
> genuine
> regular-vs-regular recursion would still be detected.
>=20
> Found via coverage-guided fuzzing (syzkaller + lockdep) by Noroxi.
>=20
> Signed-off-by: Mahmut Emin Kurhan <guvenlik@noroxi.com>
> ---
> =C2=A0fs/hfsplus/extents.c=C2=A0=C2=A0=C2=A0 | 12 ++++++++----
> =C2=A0fs/hfsplus/hfsplus_fs.h | 28 ++++++++++++++++++++++++++++
> =C2=A0fs/hfsplus/xattr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> =C2=A03 files changed, 38 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> index eb7c11524..54a05eaa8 100644
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -150,7 +150,8 @@ int hfsplus_ext_write_extent(struct inode *inode)
> =C2=A0{
> =C2=A0	int res;
> =C2=A0
> -	mutex_lock(&HFSPLUS_I(inode)->extents_lock);
> +	mutex_lock_nested(&HFSPLUS_I(inode)->extents_lock,
> +			=C2=A0 hfsplus_extents_lock_class(inode));
> =C2=A0	res =3D hfsplus_ext_write_extent_locked(inode);
> =C2=A0	mutex_unlock(&HFSPLUS_I(inode)->extents_lock);
> =C2=A0
> @@ -261,7 +262,8 @@ int hfsplus_get_block(struct inode *inode,
> sector_t iblock,
> =C2=A0	if (inode->i_ino =3D=3D HFSPLUS_EXT_CNID)
> =C2=A0		return -EIO;
> =C2=A0
> -	mutex_lock(&hip->extents_lock);
> +	mutex_lock_nested(&hip->extents_lock,
> +			=C2=A0 hfsplus_extents_lock_class(inode));
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * hfsplus_ext_read_extent will write out a cached extent
> into
> @@ -454,7 +456,8 @@ int hfsplus_file_extend(struct inode *inode, bool
> zeroout)
> =C2=A0		return -ENOSPC;
> =C2=A0	}
> =C2=A0
> -	mutex_lock(&hip->extents_lock);
> +	mutex_lock_nested(&hip->extents_lock,
> +			=C2=A0 hfsplus_extents_lock_class(inode));
> =C2=A0	if (hip->alloc_blocks =3D=3D hip->first_blocks)
> =C2=A0		goal =3D hfsplus_ext_lastblock(hip->first_extents);
> =C2=A0	else {
> @@ -576,7 +579,8 @@ void hfsplus_file_truncate(struct inode *inode)
> =C2=A0	blk_cnt =3D (inode->i_size + HFSPLUS_SB(sb)->alloc_blksz - 1)
> >>
> =C2=A0			HFSPLUS_SB(sb)->alloc_blksz_shift;
> =C2=A0
> -	mutex_lock(&hip->extents_lock);
> +	mutex_lock_nested(&hip->extents_lock,
> +			=C2=A0 hfsplus_extents_lock_class(inode));
> =C2=A0
> =C2=A0	alloc_cnt =3D hip->alloc_blocks;
> =C2=A0	if (blk_cnt =3D=3D alloc_cnt)
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 1e5b58e6a..2cbd8074c 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -36,6 +36,20 @@ enum hfsplus_btree_mutex_classes {
> =C2=A0	ATTR_BTREE_MUTEX,
> =C2=A0};
> =C2=A0
> +/*
> + * extents_lock nested subclasses. Special inodes (allocation,
> attributes,
> + * catalog) use the same lock class as regular files but their
> extents_lock is
> + * taken while a regular file extents_lock is already held -- e.g.
> the
> + * allocation file is read from hfsplus_block_free() during
> truncate. Give them
> + * distinct subclasses so lockdep does not report a false recursive
> locking.
> + */

Could we have more shorter and more informative comment? Currently, it
is long and pretty useless.

> +enum hfsplus_extents_mutex_classes {
> +	HFSPLUS_EXTENTS_LOCK_NORMAL,

Maybe HFSPLUS_EXTENTS_LOCK_REGULAR_FILE?

> +	HFSPLUS_EXTENTS_LOCK_ALLOC,
> +	HFSPLUS_EXTENTS_LOCK_ATTR,
> +	HFSPLUS_EXTENTS_LOCK_CATALOG,
> +};
> +
> =C2=A0/* An HFS+ BTree held in memory */
> =C2=A0struct hfs_btree {
> =C2=A0	struct super_block *sb;
> @@ -572,6 +586,20 @@ hfsplus_btree_lock_class(struct hfs_btree *tree)
> =C2=A0	return class;
> =C2=A0}
> =C2=A0
> +static inline unsigned int hfsplus_extents_lock_class(struct inode
> *inode)

Are we longer than 80 symbols? Then we need to rework it slightly, it's
too long.

> +{
> +	switch (inode->i_ino) {
> +	case HFSPLUS_ALLOC_CNID:
> +		return HFSPLUS_EXTENTS_LOCK_ALLOC;
> +	case HFSPLUS_ATTR_CNID:
> +		return HFSPLUS_EXTENTS_LOCK_ATTR;
> +	case HFSPLUS_CAT_CNID:
> +		return HFSPLUS_EXTENTS_LOCK_CATALOG;
> +	default:
> +		return HFSPLUS_EXTENTS_LOCK_NORMAL;

What about HFS_EXT_CNID? Should we process other reserved IDs too [1]?
Because, they are not regular file.

Thanks,
Slava.

> +	}
> +}
> +
> =C2=A0static inline
> =C2=A0bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
> =C2=A0{
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 21a1c196c..7bf4ba8f1 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -264,7 +264,8 @@ static int hfsplus_create_attributes_file(struct
> super_block *sb)
> =C2=A0						=C2=A0=C2=A0=C2=A0 sbi->sect_count,
> =C2=A0						=C2=A0=C2=A0=C2=A0
> HFSPLUS_ATTR_CNID);
> =C2=A0
> -	mutex_lock(&hip->extents_lock);
> +	mutex_lock_nested(&hip->extents_lock,
> +			=C2=A0 hfsplus_extents_lock_class(attr_file));
> =C2=A0	hip->clump_blocks =3D clump_size >> sbi->alloc_blksz_shift;
> =C2=A0	mutex_unlock(&hip->extents_lock);
> =C2=A0

[1]
https://elixir.bootlin.com/linux/v7.3-rc5/source/include/linux/hfs_common.h=
#L141
