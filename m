Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47F37AA98
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 23:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787182078; cv=none; b=ePqn8sObkwt+O/n6oaWUEbLWbMtHPXBLzYR7rSTTaQ+vc1c4DfJ0NCyeCVXAs+aLOV7xTyyOwfB+9HQO1fYGtTsuRz533X2P0y+1TwAxUXJptkNocgl1UOjhE/nVY5CscPNEwx7BVdR57rUSUC4d9dXETj3cHOl06uE+wn8xE40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787182078; c=relaxed/simple;
	bh=TsY4sVigLtnV5sI49AuqByXcsSJSZRngbCrAxSk1Byk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OO9XCT2mZYKkhg+viow6+8kb9HkKbPh4kmhQrhJ2hFD6xIVMHGjLQ9M7pcNAR4eSdUypwudYDf7inU5JmzNdhwBuaH+9QiXGPkTQZSbTmIYNttSCa9t2wf1ZOXZFIuzBXMpytau3q2sNQ/HAQhelYlxI5XzN/Q/tjna9/q04a0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=rytlT79f; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="rytlT79f"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81f64e8dfbcso26680007b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 16:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1787182075; x=1787786875; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=afHyaRyvuiDM6Qle5wlZQ910BK4luSBwOwEJlgMl4no=;
        b=rytlT79fksAniLr55VB+phxgPdKPib0JlzD0OHn7JHECvu4GxDElZtgnz9BVV/rd4R
         4uevCTb+fKsqumqNHLa+KNGrCcPZNktf+BZcsFiTOv/shH1w5Fz5A6Z9mAz2jTEH1JqI
         vdzu6iQeE/QZ+nM4R+938NKLFsc/v7e9sSx3465oQnxX/NGqxDto97C7CWEHecjw/e44
         tpMC2thI1lGtaMvQBOLteFAjIDECae/LiC4Xa6UTlpIxqW95n1scrN/1rO2CeQC+i4iR
         F6hcrFjCSsCtlcwJ1OcRtXvUfcWWGDrgmwx6WUCCJIUqQct+lJ3ErILGw/5Qoi3EjH6z
         ZoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787182075; x=1787786875;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=afHyaRyvuiDM6Qle5wlZQ910BK4luSBwOwEJlgMl4no=;
        b=jW6bSMTKtWERNZrZsFidmJ1zmuZS3XZ0e79q4Pbdgvn1SLzUwmj5sOQvIeCT607904
         I5ODRH4Kfv6vI1M3EEEbNDNNVSaqtzKEYOv44LOU7OefvOvByjyaTC1StEP7adIV7HH8
         C1XHD4Eyu5zei2P8ZZka35WehSVhFurG9VvsBufdXdduxAQK/T++BNLajmAZ+ALnlGc3
         NNqULYneGv16gdYTs8y+mwmH9pw/VW9kXTCxvO9xw5bTa3wtOGXawqfoE4ZdhDDZHEuR
         jEi7FvlclDjs7KsPUCbKswuR7j4RP2eL1LLhpe8DUfg+xm4DoVO4LBeYRTWAQrZD14gv
         CSOA==
X-Forwarded-Encrypted: i=1; AHgh+Ro8ZHDFeWPKUizAJHLVv3FbTM0wY0hMQBAWOnssfSSuXXvNSMkjj1rDpQ9w+nAsTArGsy+yz5JCMVDN7Nxy@vger.kernel.org
X-Gm-Message-State: AFuF++nFOWp916r2U9ABn6vgg1iH1yZxPCCN/8ndxRcr5Ixpy0pn8Ty5
	rR7ku2fLG4Gkw3XmE/E1MxBjakzUMcRG5c07y+4RXZaWeO2Ox40Ajd/dYwFgnJJUOlw=
X-Gm-Gg: AR+sD10V12kXCqP7wLdYpoc8EWhzkr124kWaxwifzgeIRBdDEBfI8BbX0O0A86QvUy5
	ENr60lZgksCd9JJcu+ERksauX6iMWINbGbvAhFuwkE9vEg8YVRSiClQPYKbQTj67VQ+hTATv1DJ
	8MeLHDGc5tfjMFUu2o+N3H5opx8ZtYpo8A6sygVNC0CHTA/m9YDMigAJc5x8aOAAh7NgD4WTSME
	R38mZ5kxoE4qgnO/fvOYLFhY5eyLGIEU0FX7QzUNPlU73lZjsXWJUUk8cVgH+tkxA3tBqKfu1EM
	6eZT7SlxQkkbRrSlf2LLIQSq6Q8ADci1UO8m3lUXGf2pDaVWb6vJXH8MkOww658E+kexAV3MPg/
	+ZIR+Mp3CVAlAwNRHHr4RUxePGFdLmTK+oX9UxhLCPNwRB3n3RgxNVk4EpXqln2UBnYtCHFO6hv
	AKr3Ch60qDHPFbtn2RKyr8GN26aew01s2NlI35hkkqytTR0Z1oKaOCvg8Gp+xLos7BV3jyTTP86
	noR23oQl0OZdzjTWmGErzB7H+E8bm7Hp9gpUh8qjYeJZH9zJkOJywOEysm7c2wtmHgGe3eQvKtt
	1Tw53KV7nIaBKR5Phg==
X-Received: by 2002:a05:690c:e64c:20b0:81e:45a6:bd4c with SMTP id 00721157ae682-844de3bcc6dmr32543787b3.14.1787182075455;
        Wed, 19 Aug 2026 16:27:55 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:3334:da9c:9b82:ee1b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84511abc12fsm16551867b3.1.2026.08.19.16.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 16:27:54 -0700 (PDT)
Message-ID: <5fb1c7c0eb68fd882df837b7e031e3957c5f070d.camel@dubeyko.com>
Subject: Re: [PATCH 4/6] hfsplus: add iomap operations for regular file data
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Christoph Hellwig <hch@lst.de>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 19 Aug 2026 16:27:50 -0700
In-Reply-To: <20260724053229.GE4181@lst.de>
References: <20260722213759.1360225-1-slava@dubeyko.com>
	 <20260722213759.1360225-5-slava@dubeyko.com> <20260724053229.GE4181@lst.de>
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

Hi Christoph,

On Fri, 2026-07-24 at 07:32 +0200, Christoph Hellwig wrote:


>=20
> > +static int hfsplus_file_write_dio_end_io(struct kiocb *iocb,
> > ssize_t size,
> > +					 int error, unsigned int
> > flags)
> > +{
> > +	struct inode *inode =3D file_inode(iocb->ki_filp);
> > +
> > +	if (error)
> > +		return error;
> > +
> > +	if (size && i_size_read(inode) < iocb->ki_pos + size) {
> > +		i_size_write(inode, iocb->ki_pos + size);
> > +		mark_inode_dirty(inode);
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> We've have a copy of this in various places, maye add it to a header?
> Or even into the core code based on a flag so that these file systems
> don't need an end_io method?

I think I need more clarification here. :) By "various places" do you
mean HFS+ code or Linux kernel as whole?

I assume that you mean this code block:

+	if (size && i_size_read(inode) < iocb->ki_pos + size) {
+		i_size_write(inode, iocb->ki_pos + size);
+		mark_inode_dirty(inode);
+	}

Do you suggest to introduce this logic as a special method that can be
used in other file systems too? Am I right?

Thanks,
Slava.
