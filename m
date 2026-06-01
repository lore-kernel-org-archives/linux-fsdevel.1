Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C285357CF5
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 18:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780339587; cv=none; b=CL1JmaGrXXYsJx/omcK8wRYLIn0QIzDeL3MS/Cmxqe3HDY/jen/7zu30kTLTbbeJQCkgLcIo5vf7yqsekI/UHojgclcNbGSWxEQxndQJaHlHX8791r21Xnf/IFfbnpZhibuYlRhE93tv1ofGK9LPQ6ADKffX+UfGk1cpuZlyPZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780339587; c=relaxed/simple;
	bh=SnUHdCfLeqaGaOeVJSiiv4JQLkr0R88zLmY5KT51nR8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cGdrB4HExvNTmJ/5EwemAOiE+NcoPwlXrPCXZjZ3a0b9cRiC6TI1eRlnwVnWUfK6V4STYDjFYrPtFmuQSyQi/Q0HI8+jN/HR3Xny+7BL8pkRUZeck237O4QcUWy9XOsD0Rh5AacOg18YvCXoHW9gPCSj3MpJijXgkHsbKoFe6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Dy91H4Kh; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Dy91H4Kh"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-69dead44101so3305169eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1780339581; x=1780944381; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1k8yy/GW4LqCDVQdbfkM2cPRaWsax58bbgNq4tbQQd4=;
        b=Dy91H4KhQsDMaYQkepnZUnGg8SUuYFf2cnimOUqyJrTZDmIf3XG38Isi+iWSg7FiPQ
         kuKNYXhyI2kRN8OvQteOZ/VR2unEAenh3F/0fytgUIcZtqK8JlNJgw162mb1gtszCD+S
         8gijLDCXEr7ZUVJdSd7Oopcgcc0xq5xfVP/qYJVBkNe0fJPH8kGMnFkiDTYvm7ICnH/J
         S8/Fxwgxca03ForWLic54iXic/to57OLZtTvs9/L+YckYKLaZWTRigiIjGe+WRrPVZSD
         epc2v6fM8APJTGvd0TnTesRwKK3n19YNQwZm4rC9hs/KPJQp6Xccre6MOfXbe+k5CoHq
         n+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780339581; x=1780944381;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1k8yy/GW4LqCDVQdbfkM2cPRaWsax58bbgNq4tbQQd4=;
        b=YwjMUtreEjWnExu9fN4V5LN/IbdjuKIMGJ4X9v0vh70TUBUhOU0dZoRW+MdUhsxHOb
         G14P/vcSTwW1wI4/g6QbjeEiuAp0gMcBVO3s4m5aDgTT85R/7M8HCIK0uSoJJ7jm77hd
         a6bTXPmosRr7QQk/bq8MgMJkHtOJ+qIevmODU/a5ooue+8f/URh4VLJ4rBzG5UEcyhHF
         9pa0GaIteuiMIzFfjeHfzH2i1zL8oZqzK/1K7NXYpIoxK94IztgtGQj5lOWrvIFAEXlq
         e8jg2tx0P/AJtt0H+Eq62asBOE7jz/IeZnasKT4MSzUIxEvm+KOykvJ4sfL9Zet2kO4L
         uWbA==
X-Forwarded-Encrypted: i=1; AFNElJ/EyDIPteAWhbmtI1uxtXPvirLmkV1Be0nzQXZSvEvyw2OcowzSlOFeyxSlu3s57hRxb3LM2SrxMD1Nkmru@vger.kernel.org
X-Gm-Message-State: AOJu0YypKlO0/XElgmnlakzVzxoYtCzgvqj4UrTLPT8JpAr3yx07Uxju
	oq6BP+v/Izvt0cbkczhw7QRZrIRSTnYjf3hSV6mDS2zaGzmSprs14HbISQLEH+f9xHQ=
X-Gm-Gg: Acq92OHghQ7/LCpd28VvMwplqnr27NFCEuagrblH6ZLjHZ3lbyOFJt6OJp7leJxHBWr
	7raPWuWknNnIXwMQu13vdcCr++UkM1ybU1LmveJoavbLlWufHQVwBTuqPPSn2d/Oqx4lxtOShmR
	N92Nb2fK3B/BMuQrDtVRJKdGAlqXtuUUy8WwGOWR1DMKrAkDJllgqlKzfd7U3YB3MLGW5mZi31N
	HOeAxCOxFw+C4md1uDje6k+/E9mjBjsTn7gUmbbK1cUF6iIw0vR/6RWLcj+VSqOfn76zsUpgJRj
	eX288NaIfGr5mwAbOQqK6XnkewYdngN1y7ZLiW/3fzCrbXSAwUzDvdjfhLEY1SgSVOl/1xI/cnp
	p+t2WyVBxN4I9p+0nQnyvrkBgcCB4Yb1RkLYFYWXAPCnRGHmmRybUrqHlygLqB7s7m/ztuHCMqP
	+4QfTXEn1EdPv/0+WXuaCMFAU8NxZPCX0TATWSxO2vvh3lCiyOjOP5y07G1TU9dNwTP8l+mDz3p
	AXA+2QVGk5yuVnZZyMRtdCcAO0XhVvv1beflql6dhOByJwPQmHUQAiaZOMH00shYJOzrxY=
X-Received: by 2002:a05:6820:338a:20b0:69e:2523:2f3c with SMTP id 006d021491bc7-69e2523366cmr2608468eaf.18.1780339580761;
        Mon, 01 Jun 2026 11:46:20 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:7a3e:ac53:80f8:78b4? ([2600:1700:6476:1430:7a3e:ac53:80f8:78b4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e06813130sm6457641eaf.7.2026.06.01.11.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 11:46:19 -0700 (PDT)
Message-ID: <61ad2475a5c156f69697d46a0278982878624421.camel@dubeyko.com>
Subject: Re: [EXTERNAL] Re: [PATCH v2] hfs: prevent MDB and bitmap
 buffer_head aliasing
From: slava@dubeyko.com
To: Sam Sun <samsun1006219@gmail.com>, Viacheslav Dubeyko
 <vdubeyko@redhat.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 01 Jun 2026 11:46:18 -0700
In-Reply-To: <CAEkJfYMoOOgRibSC4UB+1mU35NTP2MZB2_+eSDzrs+VKLpPL5A@mail.gmail.com>
References: <1d26872db999da42b2d8452ace8a98b79e569cc8.camel@dubeyko.com>
	 <20260529103428.99099-1-samsun1006219@gmail.com>
	 <09c2bf1e91f7ddabc24240379cd7dd0b4e15dd8d.camel@redhat.com>
	 <1924119775624adb4ce3fd7f3d936eaa2fea3c16.camel@redhat.com>
	 <CAEkJfYMoOOgRibSC4UB+1mU35NTP2MZB2_+eSDzrs+VKLpPL5A@mail.gmail.com>
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

On Mon, 2026-06-01 at 22:01 +0800, Sam Sun wrote:
> On Sat, May 30, 2026 at 7:23=E2=80=AFAM Viacheslav Dubeyko
> <vdubeyko@redhat.com> wrote:
> >=20
> > On Fri, 2026-05-29 at 14:29 -0700, Viacheslav Dubeyko wrote:
> > > On Fri, 2026-05-29 at 18:34 +0800, Yue Sun wrote:
> > > > hfs_mdb_commit() writes the volume bitmap while HFS_SB(sb)-
> > > > >mdb_bh is
> > > > locked. A crafted image can set drVBMSt so that the bitmap
> > > > block resolves
> > > > to the same buffer_head as the MDB. When writeback later calls
> > > > lock_buffer() for that bitmap block, the task tries to lock
> > > > mdb_bh again
> > > > and self-deadlocks in __lock_buffer().
> > > >=20
> > > > Reject images whose volume bitmap starts at or before the MDB
> > > > during
> > > > mount. Also guard the bitmap writeback path itself: if the
> > > > bitmap block
> > > > would resolve to mdb_bh, force the filesystem read-only and
> > > > stop bitmap
> > > > writeback before taking the buffer lock. This keeps the
> > > > deadlock fix in
> > > > the MDB commit path and reuses the existing bitmap
> > > > size/writeback logic.
> > > >=20
> > > > Reported-by: Yue Sun <samsun1006219@gmail.com>
> > > > Closes:
> > > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.=
org_all_CAEkJfYMB47v1yOWHB8q2dc8kf-3Duj-2DrLO-3D-2ByMyudwPguJ8Kd3jA-40mail.=
gmail.com_&d=3DDwIFaQ&c=3DBSDicqBQBDjDI9RkVyTcHQ&r=3Dq5bIm4AXMzc8NJu1_RGmnQ=
2fMWKq4Y4RAkElvUgSs00&m=3D2ATrdgpvRdYnJfz2T53Ih3iQv6Y9wogU2Ba19prTYgchh1mh4=
KI7lo9TYLQnlu3X&s=3DS8XdWVW0SpxB05CfctrqCJtJEXqtWDfLNdtzPHIZAY8&e=3D
> > > > Signed-off-by: Yue Sun <samsun1006219@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > > - Add a commit-time guard before locking bitmap buffer_heads.
> > > > - Replace the mount-time byte-range check with a simple drVBMSt
> > > > check.
> > > > - Reuse the existing bitmap writeback size calculation.
> > > >=20
> > > > =C2=A0fs/hfs/mdb.c | 10 ++++++++++
> > > > =C2=A01 file changed, 10 insertions(+)
> > > >=20
> > > > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > > > index a97cea35ca2e..53cd137892b5 100644
> > > > --- a/fs/hfs/mdb.c
> > > > +++ b/fs/hfs/mdb.c
> > > > @@ -185,6 +185,11 @@ int hfs_mdb_get(struct super_block *sb)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
sb->s_flags |=3D SB_RDONLY;
> > > > =C2=A0=C2=A0=C2=A0 }
> > > >=20
> > > > +=C2=A0=C2=A0 if (be16_to_cpu(mdb->drVBMSt) <=3D HFS_MDB_BLK) {
> > >=20
> > > Technically speaking, if we are trying to check the overlapping
> > > of volume bitmap
> > > with the main MDB record, then we need to check the overlapping
> > > with alternative
> > > MDB record, and with Catalog File and Extents Overflow File.
> > > However, it sounds
> > > like we are trying to add some FSCK logic here. :)
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_er=
r("volume bitmap overlaps MDB\n");
> > >=20
> > > This situation means volume corruption. It makes sense to
> > > recommend to run FSCK.
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n -EIO;
> > >=20
> > > This code error is wrong because the read operation was OK. But
> > > we have
> > > corrupted volume. Even if we have overlapping of volume bitmap
> > > with MDB record,
> > > then we cannot reject mount operation. We must mount in READ-ONLY
> > > mode because,
> > > potentially, the rest of metadata could be completely OK. We
> > > simply cannot mount
> > > in RW mode.
> > >=20
> > > > +=C2=A0=C2=A0 }
> > > > +
> > > > =C2=A0=C2=A0=C2=A0 /* TRY to get the alternate (backup) MDB. */
> > > > =C2=A0=C2=A0=C2=A0 sect =3D part_start + part_size - 2;
> > > > =C2=A0=C2=A0=C2=A0 bh =3D sb_bread512(sb, sect, mdb2);
> > > > @@ -341,6 +346,11 @@ void hfs_mdb_commit(struct super_block
> > > > *sb)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
size =3D (HFS_SB(sb)->fs_ablocks + 7) / 8;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
ptr =3D (u8 *)HFS_SB(sb)->bitmap;
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
while (size) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(block =3D=3D HFS_SB=
(sb)->mdb_bh-
> > > > >b_blocknr)) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 pr_err("volume bitmap overlaps MDB,
> > > > forcing read-only\n");
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sb->s_flags |=3D SB_RDONLY;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > >=20
> > > At this point, we already wrote main MDB and alternative MDB to
> > > the volume.
> > > Theoretically, it is possible to imagine that if size of volume
> > > bitmap is big
> > > enough, then we could partially process the bitmap too. Probably,
> > > we need to
> > > check the overlapping at the beginning of the method and reject
> > > the whole
> > > superblock commit.
> > >=20
> > > Initial issue was the deadlock. Could we implement some check
> > > that buffer_heads
> > > don't overlap before trying to lock? Does it make sense to you?
> > >=20
> >=20
> > By the way, I can see the deadlock in hfs_mdb_commit() even for
> > completely valid
> > HFS volume during generic/013 test run. This issue takes place
> > because folio
> > lock related issue. I remember that somebody has sent the patch
> > related to this
> > issue but we haven't finished the discussion with some reasonable
> > solution. I
> > think we need to rework the locking scheme:
> >=20
> > diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> > index 97e8d1f96d6d..919798eda0f8 100644
> > --- a/fs/hfs/hfs_fs.h
> > +++ b/fs/hfs/hfs_fs.h
> > @@ -64,6 +64,7 @@ struct hfs_inode_info {
> > =C2=A0 * The HFS-specific part of a Linux (struct super_block)
> > =C2=A0 */
> > =C2=A0struct hfs_sb_info {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mutex mdb_lock;=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* MDB operations
> > lock */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct buffer_head *mdb_bh;=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*=
 The hfs_buffer
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 holding the real
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 superblock (aka
> > VIB
> > diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
> > index a97cea35ca2e..94497c155d29 100644
> > --- a/fs/hfs/mdb.c
> > +++ b/fs/hfs/mdb.c
> > @@ -291,9 +291,9 @@ void hfs_mdb_commit(struct super_block *sb)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (sb_rdonly(sb))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lock_buffer(HFS_SB(sb)->mdb_bh);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test_and_clear_bit(HFS_F=
LG_MDB_DIRTY, &HFS_SB(sb)-
> > >flags)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* These parameters may have been modified, so
> > write them back
> > */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 lock_buffer(HFS_SB(sb)->mdb_bh);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mdb->drLsMod =3D hfs_mtime();
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mdb->drFreeBks =3D cpu_to_be16(HFS_SB(sb)-
> > >free_ablocks);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mdb->drNxtCNID =3D
> > @@ -304,6 +304,7 @@ void hfs_mdb_commit(struct super_block *sb)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_t=
o_be32((u32)atomic64_read(&HFS_SB(sb)-
> > > file_count));
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mdb->drDirCnt =3D
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_t=
o_be32((u32)atomic64_read(&HFS_SB(sb)-
> > > folder_count));
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 unlock_buffer(HFS_SB(sb)->mdb_bh);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* write MDB to disk */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 mark_buffer_dirty(HFS_SB(sb)->mdb_bh);
> > @@ -360,7 +361,6 @@ void hfs_mdb_commit(struct super_block *sb)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =
-=3D len;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlock_buffer(HFS_SB(sb)->mdb_bh)=
;
> > =C2=A0}
> >=20
> > =C2=A0void hfs_mdb_close(struct super_block *sb)
> > diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> > index a466c401f6bb..5d4caf3ddda6 100644
> > --- a/fs/hfs/super.c
> > +++ b/fs/hfs/super.c
> > @@ -35,7 +35,11 @@ MODULE_LICENSE("GPL");
> > =C2=A0static int hfs_sync_fs(struct super_block *sb, int wait)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_hfs_cnid_counts_valid(sb)=
;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&HFS_SB(sb)->mdb_lock)=
;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_mdb_commit(sb);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&HFS_SB(sb)->mdb_loc=
k);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > =C2=A0}
> >=20
> > @@ -68,7 +72,9 @@ static void flush_mdb(struct work_struct *work)
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is_hfs_cnid_counts_valid(sb)=
;
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&sbi->mdb_lock);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_mdb_commit(sb);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&sbi->mdb_lock);
> > =C2=A0}
> >=20
> > =C2=A0void hfs_mark_mdb_dirty(struct super_block *sb)
> > @@ -339,9 +345,13 @@ static int hfs_fill_super(struct super_block
> > *sb, struct
> > fs_context *fc)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sb->s_op =3D &hfs_super_oper=
ations;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sb->s_xattr =3D hfs_xattr_ha=
ndlers;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sb->s_flags |=3D SB_NOATIME =
| SB_NODIRATIME;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_init(&sbi->mdb_lock);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_init(&sbi->bitmap_lock=
);
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&sbi->mdb_lock);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D hfs_mdb_get(sb);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&sbi->mdb_lock);
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (res) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (!silent)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_wa=
rn("can't find a HFS filesystem on dev
> > %s\n",
> >=20
> > What do you think?
> >=20
> > Thanks,
> > Slava.
> >=20
>=20
> Thanks for the detailed comments. I agree that my patch was too
> narrow. It only handled the corrupted-layout case without fixing the
> more general locking problem in hfs_mdb_commit(), including the case
> you mentioned where a valid HFS volume can still deadlock during
> xfstests.
>=20
> I also agree with your main direction that the MDB buffer lock should
> not be used as a transaction lock for the whole MDB commit. However,
> one detail in the locking sketch worries me, though. After narrowing
> the mdb_bh lock, the HFS_FLG_ALT_MDB_DIRTY path still modifies the
> primary MDB buffer through hfs_inode_write_fork():
> hfs_inode_write_fork(..., mdb->drXTExtRec, &mdb->drXTFlSize, NULL);
> hfs_inode_write_fork(..., mdb->drCTExtRec, &mdb->drCTFlSize, NULL);
>=20
> hfs_inode_write_fork() writes to the extent record and size pointers
> that
> are passed to it, so these are still direct writes into mdb_bh-
> >b_data.
> The new HFS-level mdb_lock serializes HFS MDB commits, but generic
> buffer writeback does not take that filesystem-private mutex. It only
> synchronizes with the buffer_head lock. So I think these primary MDB
> updates still need to be covered by lock_buffer(mdb_bh), even if
> HFS_FLG_MDB_DIRTY itself is not set.

I don't quite follow what you mean here. If you take a look into the
hfs_inode_write_fork():

void hfs_inode_write_fork(struct inode *inode, struct hfs_extent *ext,
			  __be32 *log_size, __be32 *phys_size)
{
	memcpy(ext, HFS_I(inode)->first_extents,
sizeof(hfs_extent_rec));

	if (log_size)
		*log_size =3D cpu_to_be32(inode->i_size);
	if (phys_size)
		*phys_size =3D cpu_to_be32(HFS_I(inode)->alloc_blocks *
					 HFS_SB(inode->i_sb)-
>alloc_blksz);
}

You can see that it is simply extracting values into buffers and
nothing more. No mdb_bh->b_data operations are involved.

>=20
> The approach I am considering is to split the fix into two parts:
>=20
> 1. Rework the locking in hfs_mdb_commit().
> =C2=A0=C2=A0 Add an HFS-level mdb_lock and take it inside hfs_mdb_commit(=
), so
> all
> =C2=A0=C2=A0 MDB commits are serialized at the HFS layer. Then narrow the
> mdb_bh
> =C2=A0=C2=A0 buffer lock so it only covers direct updates of the primary =
MDB
> =C2=A0=C2=A0 buffer, including the hfs_inode_write_fork() calls from the
> =C2=A0=C2=A0 HFS_FLG_ALT_MDB_DIRTY path. mark_buffer_dirty(mdb_bh) is don=
e in
> that
> =C2=A0=C2=A0 short critical section. The alternate MDB sync and bitmap
> writeback
> =C2=A0=C2=A0 happen after mdb_bh has been unlocked.
>=20
> 2. Handle the corrupted volume-bitmap layout separately.
> =C2=A0=C2=A0 Instead of trying to do broader fsck-style validation, only =
check
> the
> =C2=A0=C2=A0 condition relevant to this report: whether the volume bitmap=
's HFS
> =C2=A0=C2=A0 512-byte sector range overlaps the main MDB sector. If this =
is
> found
> =C2=A0=C2=A0 during mount, warn and keep the filesystem read-only, rather=
 than
> =C2=A0=C2=A0 returning -EIO. In hfs_mdb_commit(), check the same conditio=
n
> before
> =C2=A0=C2=A0 clearing dirty bits or doing any writeback, force read-only,=
 and
> =C2=A0=C2=A0 return. I also keep a flag for this condition so a later rem=
ount-
> rw
> =C2=A0=C2=A0 attempt leaves the filesystem read-only as well.
>=20
> Draft patches are attached to this email. What do you think?
>=20
>=20

I don't know how to review attachments. If you would like to share some
code for review, then, please, include the diff into the body of email.

Thanks,
Slava.
