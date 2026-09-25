Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02BB470122
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790375713; cv=none; b=fv141w1F8siE2s5qVKyxzLhrlfn3seSM/g56i7ONkKABUEhm1GZ4sgumMY5bmRJa1IvZchOKRHGk0rC84G9r6UrtC3r0xiGM2fX/5wGOOCzbG3VmhjH2OVRaAGO8AOAn2Nw4+NY15s+/glKpU+2Yy69z6OY8WmfIVsIkSG+9g9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790375713; c=relaxed/simple;
	bh=F3r4Pt93ZYmVG+52AqmtfaD2QoqGou95WRZ95gRBLDc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aGmIyfqpct8P5VFHxbj0/HAmdyePNqJsC9SDZ4jcWZmIIXiHqMHuhnyEpgd6uN+2RtbpSpNljqwuKsStVwH+UhzDZPmWDAMGtCiOsVW+Bd8gtO0IAJa+vQq6W4laWsopzl3xrCXX8K4ich7rUJ00a21piC3sc2JvIcWtsuQyOwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=u7x3LEBp; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="u7x3LEBp"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-67453dc240fso237047d50.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790375711; x=1790980511; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jdZOr2UDvjkI8E67XQaxA/iXClxgNNHva2zS2rI+PG8=;
        b=u7x3LEBpbgalCgKCBF7SNBK1p3sUzXs/v0JiAUZPhBUgd/+N7xLx7ZlIbxr2myUUuj
         05h8TTE3LwJo60Qwt69aq6/5B2RylQ4e4P7/pOLyZtoJIFLDq1TaofimPnRSIqvHN5Vk
         Lg67Ie4EjP/8qS0Dr1mtsccZot6JyKRGLBhl35Myyn+abjuxToRfm7J06zp9fFS6RtVF
         21kZPj9TW5MMfCh7t/ZnS1YQTQVkIAt+ONcSezDFbI2AQJszPXv1HewDf9WLHtgCgOnz
         X+PZz4CmD7a4WPaaghQD2L86vLyreUJUeSVH+2QAby9g7lz3OeMpJqCVPFQrcvudkEpz
         KGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790375711; x=1790980511;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jdZOr2UDvjkI8E67XQaxA/iXClxgNNHva2zS2rI+PG8=;
        b=dT4B3yyzTrKqwpqN4kZwouYcVY778BTStI/VeUk49k/teSQ8MXAmblM02Y0bMA+BW0
         7RttPQ+dmsqh9ZzDwurN8kugyevoMEAYW7xzrkdmGuHc2yCBhvOdt07k5fTgBbsnR9fA
         KbCfJUpvS62wpP2utKojI1g6rWfUsSkCuqybdnfCyFgZ9oswYe87a+f3Uhv1WKRLSzOl
         c2sNEmk+rOxdxJtr3hMryYiRTROVqZDlNdzMI5Y17U2n5bSXKVD7v6aEXtcbPOOQTFtT
         OqPaIbsw45fydUQv1BEfMys6IXzZnYLvoOvZ+HI2F6VlXemKQqHD7QIYXVXyoblnR1om
         TD1A==
X-Forwarded-Encrypted: i=1; AKwUvBwSbBcdEUi9tQG38ZV0eTKFBaXI+ckxwLi0po51+9BHkUIATcwpDXNUOeGt4RoV/yaE3it6pTW/6Ls6qPql@vger.kernel.org
X-Gm-Message-State: AFuF++lc+JEAXlKsvYy3X7mTCi863syAb3XiBVZh35gAfTiH/xEwgrC/
	5eWgLDhlXin6t5Vqq1CmNQajm5KJ0IuXBCDnqTlBws/wNInNo51cMcdJlCWaZyur7Hc=
X-Gm-Gg: AYBFou1BNkAldsBrKj5V4lxHnp0MZGJAXwYF/vQoHz9t1h+AWH1LxflWQRGTzuoqL95
	1AHdUSp0KsF9QV9+AbzwWsRVgc0FPzbH/oR9CqgmK6sbg9jFIThjFzw21NOq3nhKUZ2UnOOvxO5
	fRMP0E82LfngdYOsJbVvxX6lQ8vX0XFUc411L8+dzd2aRqLc4eqCDBdof/ZEmeg9rpXpeT8t52M
	Mat6AqzQ6BNW6Yxuq4txM9z1/LSUUn5lXmHCqeIPog1/juA6pkWYG2roNH1s0O77EdCImFCiaNo
	dIzHhquNb5RUUx0s7kXk1osJa6k2653Behdvu25difN8DxCz16p82t+Qw7HJBA0ABXaGZGxdDOF
	WtYsVq8+w2a1AY6uneQ7B6d4Mna+YGY4t1eaaLu4RErdWnYHos0tt+9ZcDZ/236v627+E7/sgab
	YHGvvf9R7lsWu6uRyLY99lS96CQq+UUg7VapYG3E5aUc7Bt88yxmqMYdUqlZWJYvh0nE9E0Bmkh
	fL4dnAifkiQbJTWOrnQ4UgverDN3FCX2Jyexzuk4qH1CK1QjXzVnssAXO7WJqDxX/SlGAtrhFcz
	6UXkbiPqVGEtmH+izZemjT+SfzftcZafFJb0eybbl6yA3OuZDurPh/vRvnDyNQkVtHEPDInM7Ug
	=
X-Received: by 2002:a53:ac9a:0:b0:66d:1877:121b with SMTP id 956f58d0204a3-672ed1e41a8mr3828828d50.32.1790375710785;
        Fri, 25 Sep 2026 15:35:10 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:2dbc:64a3:86d9:3cfa? ([2600:1700:6476:1430:2dbc:64a3:86d9:3cfa])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ef7f4f4sm1495367d50.16.2026.09.25.15.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 15:35:10 -0700 (PDT)
Message-ID: <2bb826db81e9d1fadb175be873623d003d7ce385.camel@dubeyko.com>
Subject: Re: [PATCH v4 7/7] hfsplus: switch address_space_operations on
 iomap-based support
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christoph Hellwig <hch@lst.de>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	vdubeyko@coreweave.com, willy@infradead.org, brauner@kernel.org,
 djwong@kernel.org
Date: Fri, 25 Sep 2026 15:35:08 -0700
In-Reply-To: <20260918135747.GA18697@lst.de>
References: <20260914233941.2966421-1-slava@dubeyko.com>
	 <20260914233941.2966421-8-slava@dubeyko.com>
	 <20260918135747.GA18697@lst.de>
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

On Fri, 2026-09-18 at 15:57 +0200, Christoph Hellwig wrote:
> On Mon, Sep 14, 2026 at 04:39:41PM -0700, Viacheslav Dubeyko wrote:
> > =C2=A0/* Compare two extents keys, returns 0 on same, pos/neg for
> > difference */
> > =C2=A0int hfsplus_ext_cmp_key(const hfsplus_btree_key *k1,
> > @@ -275,6 +276,8 @@ int hfsplus_map_extent(struct inode *inode, u32
> > ablock, int create,
> > =C2=A0		*max_blocks =3D hfsplus_ext_find_block(hip-
> > >first_extents,
> > =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 ablock,
> > =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 dblock);
> > +		if (!*max_blocks)
> > +			return -EIO;
>=20
> What is this for?=C2=A0 It feels like something that should go into a
> well-documented prep patch.
>=20
> > @@ -342,7 +348,7 @@ int hfsplus_get_block(struct inode *inode,
> > sector_t iblock,
> > =C2=A0
> > =C2=A0	if (create) {
> > =C2=A0		set_buffer_new(bh_result);
> > -		hip->phys_size +=3D sb->s_blocksize;
> > +		hip->phys_size =3D (loff_t)(iblock + 1) << sb-
> > >s_blocksize_bits;
>=20
> How is this change related to iomap?
>=20
> > =C2=A0	if (inode->i_size > hip->phys_size) {
> > -		struct address_space *mapping =3D inode->i_mapping;
> > -		struct folio *folio;
> > -		void *fsdata =3D NULL;
> > -		loff_t size =3D inode->i_size;
> > +		if (S_ISREG(inode->i_mode)) {
> > +			res =3D hfsplus_iomap_cont_expand(inode,
> > hip->phys_size,
> > +							inode-
> > >i_size);
> > +			if (res)
> > +				return;
> > +
> > +			mark_inode_dirty(inode);
> > +		} else {
> > +			struct address_space *mapping =3D inode-
> > >i_mapping;
> > +			struct folio *folio;
> > +			void *fsdata =3D NULL;
> > +
> > +			res =3D hfsplus_write_begin(NULL, mapping,
> > +						=C2=A0 inode->i_size,
> > 0,
> > +						=C2=A0 &folio,
> > &fsdata);
> > +			if (res)
> > +				return;
> > +
> > +			res =3D generic_write_end(NULL, mapping,
> > +						inode->i_size, 0,
> > 0,
> > +						folio, fsdata);
> > +			if (res < 0)
> > +				return;
> > +
> > +			mark_inode_dirty(inode);
> > +		}
>=20
> Is this for symlinks?=C2=A0 Any reason you can't pull in
>=20
> =C2=A0 iomap: add iomap_symlink_write
>=20
> that has been posted on fsdevel and use iomap for symlinks as well?

Does it landed into some branch or is it still only on fsdevel list?
Otherwise, I need to wait when this patch will be in some release.

Thanks,
Slava.
