Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D033C4174
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789068034; cv=none; b=RqlX2LFNXI2bRf6oNXAV0bVCo4JmeiRI0Xc+hpF9GtX1TBbXar8TsjOp5bv/EazeFKEzyehv71BC9D7sPoERwK33hAJ1gBchoBTlEq+46Zb01IjYBeuDgoVs8r4L3wtRJ45VacLje1GSRoz0APwwoZiMc66NIB2oiS7RCTxa+Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789068034; c=relaxed/simple;
	bh=SjcURmQWgAMd+mRxUmrYPdw5KEONS/MYNy0rNK63HEI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GW/yj48TGnVyPJMAS52ytgqwPRGzwgZnE3QpnbJcGZWI9JxRaq3mYMiqm+Da8/qO9AiY86OKUsQEBtyhJA2HTZ/EpV4eeSb16hotDxhF1Nrako38Fk3vonY6L4lmHDAMEgR/6js85/xMbWLUgb44/qRfUB3l8IR7LexvOaKC/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=gWwjN0ln; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="gWwjN0ln"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66de7e0bc85so62062d50.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 12:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789068032; x=1789672832; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=X/zU3lnLiID8sHodUav7gZ12JSNFK6s/Et+PCJYnR28=;
        b=gWwjN0ln++DPTFnAYUyfugZu5c7yFFafOCofOaxupJiw5Ro3OfpxrmIMzFM5QPevyS
         f9ONCfw7IaKMFK2Z77Z/kIOtB6ySIOXRpU5DGyYc1Fg5eBfIjAcTHhrS4bC0+4qHNhO1
         MpebpRhotP8zFyCsklkRlGO1nPOOUeQH0uxbtD5Fe2nlffi47xbFljXdPY4EsYsqZ+Vp
         B82pKLAdGLezrZIlJVs/lUDv48nCqwfTbQYrZ1rcw35hfxGOFol34+b+N2vr1qeNe6Bh
         wp5CciII4nJHgVE/nd9cJikXmKB6o7lPMw5+k+5NBLwpZw6u3CZnaUuXquywt2TN6tHJ
         oGjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789068032; x=1789672832;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X/zU3lnLiID8sHodUav7gZ12JSNFK6s/Et+PCJYnR28=;
        b=NCvYB7lq4HrM0AGMt1CYFr10pHt0rowRPVLTvrVbAb5xnbbcxcizBE3e8/8oDllecT
         Aftgl6D3BqFy73nnFj9GB2GP4xkYC6YxM9rFmKd1UlE6gN/Sl/yhjAkbyTIxEk7YRmTb
         rr1cxleywFTa8ZZpS7duS7rmEOyLKYcHGUUn/LF9q235Ivj1V+rw+6jiW+esR18ZDSrc
         07F5QKjQ26jQkSkXgCUSrbR95VC4HgI+dNJvdaq74Wy8jrWCjGXX0Q7y8P4rZVmmYY/z
         DMjS9ep8e1F0gW9y1KdJIRBCHKWKgmDeZfv013rGkTJoZd+PyCCCT4+6JpCuL24Dxzw8
         H3JA==
X-Forwarded-Encrypted: i=1; AKwUvBw66FFG9YjAazfJqLJSM3WwqOe6FL+DuKIairnVMg2SkVaH1QtzqyOS8v0KKb3ax5uEL5DqZSNiaslLedv9@vger.kernel.org
X-Gm-Message-State: AFuF++nmyrHg5Ur0Nn3KAse7BMUhNDao0deYZ3jchVuhGgjrIIE5IxLe
	1ZLp0mp+iPynIUXrzKgcpTXyQ/WjpabT2MOr0Gd8sW5kyiwKlGhF2bVJB+aY61gRYng=
X-Gm-Gg: AYBFou0Mj0g1mej+io+dYLRDB64gYPO62jjfrY5/3Bzo0eEdXbC74W2Vwga9I9WxPZe
	vGkzA0cFJqDOzG9veCOXcfGzfkOaB3iuhtQyeUWfIp5paZN1/NyvGWcVJU0UgyYIPuLm67wh4og
	EZvjHBYwTyE0GFQOELFAVwklmINBFERmjA+skjuWeGCRRtMTVEAH0m1iEoC1g2f9l/8bMOK3RBM
	PF9YGa7lRb3o/iIVfip1vXT6PoEA5hqJ/1Nz24+jQdcmWcYIBderLVj1aDRlQY9AWhCECBDtL87
	A6ZXXII7lQsCxXGf7w12y8mhrYCtlacz0RvXE3NL8chKmeinK5DOqadi49KQD9PH2Cxd3bOFT7v
	tj4mX5vPRqO7VTnJejgSJV6VuK3y0ZXtYeCYZ1JcF6zBJ6B4p2wyQQPAy9+t4IhDvVxpHJiKSmM
	iEfrMlITxuZbvudFdgC6Y9Vbr3m1BkkxDF/+UamMnjJxaJlvRxdX576WNRk2Fax7x/l7gnFl8Qy
	adyceXVpjFCqHJ0XTvGQpSnZbIFucboJDxHpgzvDFX+XEUmvejf8R9XKMmRjFK7dqWjlrtsOfdF
	GnlzYAWdccYjUsCTpb9FoGjdtz4L
X-Received: by 2002:a05:690e:428a:10b0:670:f6e8:1f8c with SMTP id 956f58d0204a3-6712474b3ccmr413647d50.84.1789068031917;
        Thu, 10 Sep 2026 12:20:31 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:2670:dacd:b84e:82bb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125b8bf2asm55160d50.1.2026.09.10.12.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 12:20:31 -0700 (PDT)
Message-ID: <28f33649277ca654e66c36aea1bd4f2bfd6abbf6.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: fix recursive tree_lock in
 hfsplus_file_extend()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Date: Thu, 10 Sep 2026 12:20:29 -0700
In-Reply-To: <20260910160133.27143-1-ngocthang2710.1999@gmail.com>
References: <73cc2e394cc0269a62e2e6503aac5fef2a3ac65a.camel@dubeyko.com>
	 <20260910160133.27143-1-ngocthang2710.1999@gmail.com>
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

On Thu, 2026-09-10 at 23:01 +0700, Nguyen Ngoc Thang wrote:
> Hi Slava,
>=20
> > Probably, hfs_bmap_reserve() is the proper place for checking
> > capability of growing Extents Overflow file. But it needs to take
> > into account that if fork has empty extents, then we can grow the
> > b-tree. We have -ENOSPC situation only if we already used all
> > extents in the fork.
>=20
> Right, and it turns out the existing control flow already computes
> exactly that, so I kept the check in extents.c rather than
> duplicating
> fork-layout knowledge in hfs_bmap_reserve(): hfsplus_add_extent()
> returns -ENOSPC only when it has walked all eight slots and the last
> one can't be extended contiguously (the ++i >=3D 8 case). If there's an
> empty slot, or the last extent can be grown in place, it consumes
> that
> and returns 0 -- hfsplus_file_extend() never reaches the
> "insert_extent" label in that case. So arriving at insert_extent
> already means the fork is exhausted; no slot scan needed there.
>=20
> v2, two hunks in the same function:
>=20
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -458,6 +458,15 @@ int hfsplus_file_extend(struct inode *inode,
> bool zeroout)
> =C2=A0	if (hip->alloc_blocks =3D=3D hip->first_blocks)
> =C2=A0		goal =3D hfsplus_ext_lastblock(hip->first_extents);
> =C2=A0	else {
> +		/*
> +		 * The fork already claims more blocks than its
> eight extents
> +		 * describe (a corrupt on-disk fork): looking up the
> rest
> +		 * would re-enter hfs_find_init() on the extents
> tree, whose
> +		 * tree_lock is already held here.
> +		 */
> +		if (inode->i_ino =3D=3D HFSPLUS_EXT_CNID) {
> +			res =3D -ENOSPC;
> +			goto out;
> +		}
> =C2=A0		res =3D hfsplus_ext_read_extent(inode, hip-
> >alloc_blocks);

I think your logic here that if we try to read the extent from the
Extents Overflow file's content for the file itself, then something is
going wrong. In this case, we need to place this check into
hfsplus_ext_read_extent(). But I still don't see how we will check the
fork itself because it could be corrupted even without be completely
full? And how could we check the forks of other b-trees?=20

> =C2=A0		if (res)
> =C2=A0			goto out;
> @@ -534,6 +543,15 @@ int hfsplus_file_extend(struct inode *inode,
> bool zeroout)
> =C2=A0	return res;
>=20
> =C2=A0insert_extent:
> +	/*
> +	 * Getting here means the fork's eight extents are exhausted
> (see
> +	 * hfsplus_add_extent()). The extents overflow file can't
> record
> +	 * an overflow extent of its own, so it cannot grow any
> further.
> +	 */
> +	if (inode->i_ino =3D=3D HFSPLUS_EXT_CNID) {
> +		res =3D -ENOSPC;
> +		goto out;
> +	}
> +

I assume that if we are here, then we already allocated the blocks for
the extent. And if we simply return the error here, then we've lost
these allocated blocks from the free space. Am I right? I think we need
to prevent the blocks allocation, then.

Thanks,
Slava.

> =C2=A0	hfs_dbg("insert new extent\n");
> =C2=A0	res =3D hfsplus_ext_write_extent_locked(inode);
> =C2=A0	if (res)
>=20
> First hunk: fork was already inconsistent when read from disk at
> mount. Second hunk: fork was consistent but genuinely ran out of the
> eight slots during this call -- your ENOSPC case. Both land on the
> same tree_lock recursion, so both need the guard.
>=20
> On the severity split you described (consistent first extent +
> garbage
> elsewhere -> construct + flag inconsistent + read-only; unusable
> first
> extent -> hard error, mount fails): agreed, and that's the direction
> I'll take the fork-validator follow-up once this one's in, applying
> it
> to all three trees as you asked.
>=20
> Both hunks build cleanly here.
>=20
> Thanks,
> Thang
