Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7CD382F08
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 18:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790964657; cv=none; b=uiRQhpcjbTPfMchR7Oc7RuV5JyRr+OaBt4jt/K7FzH5eEwu6bKsy7LS2fVdi+NwLdswCIPaBJbhHEVWbWOr/bOD3tZkYgYJV3TiSekA81pZCBryvj5Rb6RPB9YfxA8cJ2KYXur1IVekXJWzn89v4sdD4fNUWO9PCpzLPMQ4nwq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790964657; c=relaxed/simple;
	bh=tUwU2rRuCaKGL6NDdrbDPwgHCurvpcRMFDryhDOsn9w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fzOTMeAReJfcojOLpkhPLiNoDsZm9ygiXefX4u95YaQYHmiPP0ESs8QKs43Hk2Lifiwe/FL5AD55L84ZkGXyvzjoDFN6iiPuMbV5UTFJ+Tp61oHC82hhE5GyFMSjItO1mZ7MEGAfb9EQ1BUbZ9pvM7uH2C7JD7SA86nx0WfASgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=nwDhb73y; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="nwDhb73y"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ab37e44643so7377307b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2026 11:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790964654; x=1791569454; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ngUaM2SkwBxwRDff3sSncgAHNme9iNgFpSdnM6Ua0o=;
        b=nwDhb73yNlLum9Olx3fvX/b/0PebdNEuZLSXlPlQHiagUE1L7NKDQqswiJ6LQ8uHZ0
         xOucbDfpIxvN+sq66AGcfAc3p0w/4OU0XI5b41NyJLcyZrv2Nya4wcVeg1rO9Z0D5Y82
         IMoWpdQITWo60FzgFn+zsbok6GY1eEcqLhdRulb5IMKN9Jap3ogr+Jk0AlVKKkNs4a2C
         CT+duk5oUnbpdOLc4CenH1iRh3T0OXQIITo6JMjyBPJwTtyCVeX6VLD2ghgNs5xZMnjC
         Fm1MFgpCyb1lBP18oQEzkBT8QJRGqT6Ej8BdlmLkyVycYXojsRAou8Q/SZnbKp73/IvW
         GACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790964654; x=1791569454;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0ngUaM2SkwBxwRDff3sSncgAHNme9iNgFpSdnM6Ua0o=;
        b=O8SET7o5DPmdJPJi+kNR1bwDTVBIMv+S0z7/jX9ifHKCrRXC6cI9iwqKwYKW+Ypi68
         MLGJSUHGy2F0r5IpRNWIjFMKyc47jaNf6wYpPvhiZKpU+fiNZsBEPQ9Tbf2Q4ONy8mjg
         jgtuktPyFEQNWbv1iA/P+6pLyrSDTnitPKu7VLbSXdM7qHVSwvy+tuiUIolbX5egCULw
         atL301EKJnLHzp01CAXFdl9O2DPO5yQZzft0unXu06Oj1LxkPVRiOn6UFBEN0gqILqLx
         pEeKjuYsTQz4c8MzRIl/NIs2TRICRlISi/6SdgcGEqS2jKl/It4gND2OGwyGFWSTWtEb
         Fmuw==
X-Forwarded-Encrypted: i=1; AKwUvBwF5ln0QK6vzoXZDXNucH2nm49iCZDbFOiPKCyamGnblDIsp5Z6SVeRAN5EO7noHiiORYIS4jips8AGsTbo@vger.kernel.org
X-Gm-Message-State: AFq9FYKe54XA6CzoZL/Kv773KPeoiyHubtJ8vJvg25AOSBVcdB+boYZ0
	esFMnRBISm5qI3FptrckPEUnUzadQ/kxgmZGz34Q4tEDxO7er84RSfs9EhjKx1O9Q5vXm0xi5kK
	uXhYO0PU=
X-Gm-Gg: AYBFou0DM1M2dXaLmO5mg2DoansB8KMR/qnT0XKsBN/DfTRkeh8aKMK73IEnuMfDO0r
	MIOmMxA5xd2FOpT0x75GU3rMsGkZPCU38A6LM+e/ZQXfWM2AZ4lzv7UML6Udhx0J5uYGVkWiPwq
	sfor0ix3MdM0yOYdIxfMgn9g0Wd8RJHV1ayqsigXrvHp3JkRBAQcIqCSrDU+gjt32tyuUyKHwuq
	Z/SIegjdz/bP+NMHafNnseggGv3rp7uILZt6IZFKDsMe9NSHzM+dfUUTcNmOkJ1ldb6JkEy5cJI
	vaqRkjy7ut+hfmNJWW6l95+AKXexzL2GMTt+eH3Q7yTFcliFE71dUl+bOaUvF6s7DwOgRmpEZ/Z
	PFlSq8bgHL6OqXmgzYnopXTTVjbo5emonm9WpKHVmfp7sYcC7gYl0cIOqLU0qNxXGDeAsyxqSuv
	sAEXriayAjzzHvJbBxJo7yCH4GWHiOdqtNGzRflZONWzX+55hT6M2zXWiqcKud6LteHurDBP9mR
	g+B0Dx+ENm+IZrD9A6KBuM9iufMUSXhidtESJ2bX8YkwbXGPhehhCt+u4Jqcto2J0tQnrZzPvXw
	kMmbZXxPPAX0SCYYanCLJWc2LR+qqEtN9lBcOSxs5aC3jOx9miawZwDuDdH+nu9y6jh56Q==
X-Received: by 2002:a05:690c:e3eb:b0:8a9:977a:4149 with SMTP id 00721157ae682-8ae95af34bcmr2563907b3.72.1790964654121;
        Fri, 02 Oct 2026 11:10:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:ec77:47c8:250:c58? ([2600:1700:6476:1430:ec77:47c8:250:c58])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae32ef445fsm13144787b3.28.2026.10.02.11.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 11:10:53 -0700 (PDT)
Message-ID: <bac16585adf37c9eb1d093176ab6c34c54e77de1.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfsplus: annotate extents_lock nesting to silence
 lockdep false positive
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Mahmut Emin Kurhan <guvenlik@noroxi.com>, linux-fsdevel@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 11:10:52 -0700
In-Reply-To: <20261001215304.1520907-1-guvenlik@noroxi.com>
References: <9f8b8dacee5d24c94185bab75ff905eb51a95999.camel@dubeyko.com>
	 <20261001215304.1520907-1-guvenlik@noroxi.com>
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

On Thu, 2026-10-01 at 23:53 +0200, Mahmut Emin Kurhan wrote:
> lockdep reports a possible recursive locking on HFSPLUS_I(inode)-
> >extents_lock
> when unlinking a file on a crafted image: hfsplus_file_truncate()
> holds a
> regular file's extents_lock and, while freeing blocks, reads the
> allocation
> file, whose get_block() takes that file's own extents_lock. They are
> distinct
> inodes of the same lock class taken in a fixed order, so it is not a
> real
> deadlock, only a missing nesting annotation.
>=20

As far as I can see, we have the same issue for HFS code.

> Give the special inodes (allocation, attributes, catalog) distinct
> extents_lock subclasses and take the lock with mutex_lock_nested(),
> mirroring
> hfsplus_btree_lock_class(). Regular files (CNID >=3D
> HFSPLUS_FIRSTUSER_CNID) keep
> their own subclass so a genuine regular-vs-regular recursion is still
> detected;
> the remaining reserved inodes use a separate subclass instead of
> being treated
> as regular files.
>=20
> Found via coverage-guided fuzzing (syzkaller + lockdep) by Noroxi.
>=20
> Signed-off-by: Mahmut Emin Kurhan <guvenlik@noroxi.com>
> ---
> v2:
> =C2=A0- shorten the comment (Slava Dubeyko)
> =C2=A0- rename HFSPLUS_EXTENTS_LOCK_NORMAL to _REGULAR_FILE (Slava
> Dubeyko)
> =C2=A0- use HFSPLUS_FIRSTUSER_CNID so reserved inodes are not treated as
> =C2=A0=C2=A0 regular files; add a separate _OTHER subclass (Slava Dubeyko=
)
> =C2=A0- hfsplus_extents_lock_class() signature is 74 cols (< 80)
> =C2=A0fs/hfsplus/extents.c=C2=A0=C2=A0=C2=A0 | 12 ++++++++----
> =C2=A0fs/hfsplus/hfsplus_fs.h | 26 ++++++++++++++++++++++++++
> =C2=A0fs/hfsplus/xattr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> =C2=A03 files changed, 36 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> index eb7c11524d..54a05eaa8f 100644
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
> index 916e6552e3..7e2411b8f1 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -37,6 +37,15 @@ enum hfsplus_btree_mutex_classes {
> =C2=A0	ATTR_BTREE_MUTEX,
> =C2=A0};
> =C2=A0
> +/* lockdep subclasses for extents_lock: special inodes nest under
> regular files */
> +enum hfsplus_extents_mutex_classes {
> +	HFSPLUS_EXTENTS_LOCK_REGULAR_FILE,
> +	HFSPLUS_EXTENTS_LOCK_CATALOG,
> +	HFSPLUS_EXTENTS_LOCK_ALLOC,
> +	HFSPLUS_EXTENTS_LOCK_ATTR,
> +	HFSPLUS_EXTENTS_LOCK_OTHER,
> +};

After more careful consideration, I think it looks like a duplication.
We already have:

enum hfsplus_btree_mutex_classes {
	CATALOG_BTREE_MUTEX,
	EXTENTS_BTREE_MUTEX,
	ATTR_BTREE_MUTEX,
};

static inline enum hfsplus_btree_mutex_classes
hfsplus_btree_lock_class(struct hfs_btree *tree)
{
	enum hfsplus_btree_mutex_classes class;

	switch (tree->cnid) {
	case HFSPLUS_CAT_CNID:
		class =3D CATALOG_BTREE_MUTEX;
		break;
	case HFSPLUS_EXT_CNID:
		class =3D EXTENTS_BTREE_MUTEX;
		break;
	case HFSPLUS_ATTR_CNID:
		class =3D ATTR_BTREE_MUTEX;
		break;
	default:
		BUG();
	}
	return class;
}

Why we cannot reuse this already existing logic? Suggested logic uses
the inode->i_ino. But tree->cnid and inode->i_ino should be the same.
Maybe, we simply need to rework existing logic and reuse it? What do
you think?

> +
> =C2=A0/* An HFS+ BTree held in memory */
> =C2=A0struct hfs_btree {
> =C2=A0	struct super_block *sb;
> @@ -568,6 +577,23 @@ hfsplus_btree_lock_class(struct hfs_btree *tree)
> =C2=A0	return class;
> =C2=A0}
> =C2=A0
> +static inline unsigned int hfsplus_extents_lock_class(struct inode
> *inode)
> +{
> +	if (inode->i_ino >=3D HFSPLUS_FIRSTUSER_CNID)
> +		return HFSPLUS_EXTENTS_LOCK_REGULAR_FILE;

The HFSPLUS_FIRSTUSER_CNID coudl be as file as folder. Please, take a
look into my above comments. Maybe, we don't a new function at all.

Thanks,
Slava.

> +
> +	switch (inode->i_ino) {
> +	case HFSPLUS_CAT_CNID:
> +		return HFSPLUS_EXTENTS_LOCK_CATALOG;
> +	case HFSPLUS_ALLOC_CNID:
> +		return HFSPLUS_EXTENTS_LOCK_ALLOC;
> +	case HFSPLUS_ATTR_CNID:
> +		return HFSPLUS_EXTENTS_LOCK_ATTR;
> +	default:
> +		return HFSPLUS_EXTENTS_LOCK_OTHER;
> +	}
> +}
> +
> =C2=A0static inline
> =C2=A0bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
> =C2=A0{
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 21a1c196c7..7bf4ba8f18 100644
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
