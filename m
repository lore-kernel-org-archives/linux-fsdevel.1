Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C063A43F4C5
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783460653; cv=none; b=SWuMLUdpahdFp3ddm1bfXI3i3kTDUWlxPhNaBqWI0Lo0BiZeAJaf34YdG2eLidjCpwhVsTnWhh8BtY3dMGGFEJKlY3t7OlOE+PK2qQmpOY25uF0f7Z360CyWd3NAyALBqcxhhrSBigeUkdQx8MqrT3C3y0niQHCjnjEsHP4jacE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783460653; c=relaxed/simple;
	bh=RmpfMvoIyq/2VP5kr7Ce9V5mCdRG4NHrE+nx61kgPic=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j47Okn8MhyfBWkuNYP6gv+n1FrVbppMIKNBPe6NeTK0fd7wr7p+fMFcgABHEzDWq499M/dd4yXtvSFFUawsVtoLbgrvd1my1lIgWxvmVojKbFNIMI2mhxCn2tCCuwcY7TMJNmLCtB4cABv4krBZr1SpZb3iqHbSZLV5rsBWKKFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=eCVQEPo6; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="eCVQEPo6"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-809b19a7f25so751197b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 14:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783460651; x=1784065451; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RmpfMvoIyq/2VP5kr7Ce9V5mCdRG4NHrE+nx61kgPic=;
        b=eCVQEPo641SH3zF7wF4NdfBzB9jcwkQc2fwB2KBPvS7mv9Vio9gkSQ6NbB/Uh+ybQX
         n9NAdb3bQ720SiM92O+vIsEEJxIItiQBUdRqjo/InGTQI3ChyxH5KhZhC96dYhba31+e
         M2NpUIbYUJe90kCbRwsLu1bYHck8kzqeP4/JU4U+EOcd9Vj6ASWGiGSGkoPyLCbeTYqM
         QJ+6j/eIlBbxAkUxIjzS9oGNfnmKT3Ogm8w552Zqk7TuFU7RqZlTCi5asM3mkJl2kXPy
         /cKlKSu9qvjhQicX54SVNGN7g6H2SHPATRZ+4EFr8s3VYXohRRL07/QU0GNn9hmikNjH
         MYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783460651; x=1784065451;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RmpfMvoIyq/2VP5kr7Ce9V5mCdRG4NHrE+nx61kgPic=;
        b=OObb9VVm0/a83TiqnYJE8rSNGxDtvV+l3EwrO8n/9P2csUnAY4nP47Cs2Nj4ig8WmP
         ltDFhjBaImEHhQuTFH+B4jsAMpxDXdQECaYS5mRT9DLdn5wz2ijbhiUDOmxJnQyWAY1A
         oy8jOtFX0QgxyQFJ+dp/G+vcocqcNOJ47E7r7ohpy7izEyD4fHEyEP8Tbn8u8zpHS6Cr
         nTseFI+KQB6dIR3n4pl7so2GFjQSrWIX73wWXKThRMW+Gk/jPUqi5PAozS2uv8yPgcgH
         MKkhUpv006cahXfF1vhLGiLELphJdc4k/mBmWK/BpxajeC3qLf/ZP65vIX0bENHfdUEd
         8aQA==
X-Forwarded-Encrypted: i=1; AHgh+RokB8yVgk6alCZBgPDqkkpWB+C0okknothwbRCfRMQ1GRcnOO6WRNuWYIT26qydu8VdW8zOYohOqLwo8vR4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7wiBcPfh+6ByGhL5znKjuVSw2bYg/19k6wOuhy6ab6pZOsS0n
	9j14tCU8rxBstPa9z5DXtxxND4P0Xkm+zU22nkmTSUlb22TFlNXpqvjEaRHfijVLV6w=
X-Gm-Gg: AfdE7cmTIJjvHFUOuepbq1RZewRKEkwiXFIeyz0qFEjNfpbauh52mUGRgCB6IHSclyT
	tpng+riH0doIFnA4NDPJoCs7S8v7ZXWGfbvrisvq1Y07qBhGsDU5P06SZL/GDuEnxulaAit+rvm
	XdIC127muGcGbESOw8ACmcJEYAMCyoXkR1SgAk4caVZbHYJKAaSmVed0idfgejfvUzUjlCo3gdI
	n+vrPyAjc1hk8b1dZ2ASlJ8nvqKTs2V72R0QK5WMfIDsLskC22Us7S7M4IazRgOH9J/mGlhTPyC
	meZXERQPsja4KSNEvPXnqtSIDf/UJl98LwEVN6c9bHfKpD1Lr3DnQhTyzA79O+UDRRmI+nicb/z
	7ERNVCua8kU00Ew+dEAEjMK2n9UQ6fhp+3Rcew1D3Qb7FRJOpFYYKWYkaJMES23+Qogouyi0A0s
	idvj20WxEsRz6YTk8OoXZj/N8yaKeteg7AuQ4gAt0UysdR9GAPFq7ROjLAqyiYIpseB2P9mNWg4
	F5LaSwYr539yurYsHJ09eR1fEj/cc5AM4t6dIBHOXP1cA==
X-Received: by 2002:a05:690c:6b0f:b0:80c:85e5:8737 with SMTP id 00721157ae682-81be36a8fd6mr57115477b3.69.1783460650753;
        Tue, 07 Jul 2026 14:44:10 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:daa5:7e29:8095:10b2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144b049939sm74112137b3.32.2026.07.07.14.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 14:44:10 -0700 (PDT)
Message-ID: <1743f03aa76fe7af4114688725e650410fcc4897.camel@dubeyko.com>
Subject: Re: [PATCH v3 RESEND] hfs: validate catalog CNIDs before
 instantiating inodes
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: dave mad maxXx <davemadmaxxx@gmail.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, George Anthony Vernon	
 <contact@gvernon.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Date: Tue, 07 Jul 2026 14:44:08 -0700
In-Reply-To: <CADy8qZgo3rKwUiPr60tzPhaisMy7R71vjTtPi7+jEXgcarihRw@mail.gmail.com>
References: <20260702183800.1119202-1-davemadmaxxx@gmail.com>
	 <20260706095943.258065-1-davemadmaxxx@gmail.com>
	 <7f700f4bc68de5daf4d5d28e574a486a04806fb9.camel@dubeyko.com>
	 <CADy8qZgo3rKwUiPr60tzPhaisMy7R71vjTtPi7+jEXgcarihRw@mail.gmail.com>
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

On Tue, 2026-07-07 at 18:31 -0300, dave mad maxXx wrote:
> Hi Slava,
> Thank you for the review.
> Yes, I agree that the initial length validation can be simplified to:
> rec_len =3D fd->entrylength;
> if (rec_len <=3D 0 || rec_len > sizeof(rec))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -EIO;
>=20
> I also agree that, for the fixed-size file and directory catalog
> records, the checks should require the exact record size:
> rec_len !=3D sizeof(struct hfs_cat_file)
>=20
> and:
> rec_len !=3D sizeof(struct hfs_cat_dir)
>=20
> Regarding hfs_write_inode(), I intentionally left it unchanged
> because the patch was trying to reject invalid CNIDs at the catalog
> lookup and inode-instantiation boundaries, before a corrupted inode
> could reach writeback.
> However, I agree that an additional validation there may be useful as
> defense in depth. Would you prefer hfs_is_valid_cnid() to be checked
> in hfs_write_inode() as well, and should that check precede the
> existing BUG path while otherwise leaving its behavior unchanged?
> I will prepare the next revision after your guidance on that point.

Let's leave hfs_write_inode() untouched. I don't see a valid point in
this modification.

Thanks,
Slava.
