Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116532;
	b=IusZohdKPHlyrfWtXp0X2geHAbXlijpqPtBIVzjeTXvDnIcCwDAyi4Nnw80OV3fwXPhB
	 jSJOCJ1wdk00uUXwNxHoFJYlUPruHaVNVOuAv0UzU6ZTaNlOtG30tx4RcP1jUaCHMr/oT
	 mLYedks5SGYhebkteQAx8Swb0mdNYjbrqWlC1kdtSbfp5seTuGwZNtsbkAdI1DzCgkGfm
	 DY+1AYTSyQz1T+XaJm+o1AQ+KjW6bVnvahdvcL/akmarOROuVoz/ySQLB3J4Wm6jdzMcb
	 5dlqh+eDEU9Gr9dOA7odbLs2643ayVymlZbLRHoiNOGuqhcDhMmtgSFocxbSblOhINg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=xppnKgi4kFZOZh7Zfae1BSLo1JzIIBwXzu5v89JWnQE=;
	b=PK9TISKKIzFJEJCs1/l+ScCPU2xd5bsVqPeqbuDD9SPNsxPuP8pUQO2PFCB4RhtKj1d6
	 dnlOreyJUS9PTOIDCd10IMrNpRotLiGPBrlVJZf38J0LSh2FFw0FLR44qv+RQrzUx+EBt
	 soq76DYBmUSZ3l6NFxI+UaA+UraauTLoX8G2whw8m7D/Y9CEbUtMK//fY8QEe1ZdXg8p9
	 dIdOmLEVM7rTDhWWrqp53gY93Pnwas/LrJYzmu1a+Csq5rsKDAnjy6w6HIwfh0WQ3JTx+
	 ofwX6+/MPS5xlpV1Mxbb1F80/nco0z4MKJTt84zxcLzk7DKv6DaW3SPpOJi21RPLfgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CDzOpn2B;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BEF606A320
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 19:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76BEF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=CDzOpn2B
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b4e2fcc300so981917b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 11:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795116530; x=1795721330; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xppnKgi4kFZOZh7Zfae1BSLo1JzIIBwXzu5v89JWnQE=;
        b=CDzOpn2BSz2DPVuAkxIEXR32DFgENFSPDIb/LGpEr8Tl9NAZMcsC2JwCNkAtLLbt5s
         lecVGzC93DjbRnbySp81+vXN8koWfUd31K++3Saa5pOhDY4iFFPEglhYwg2KXGvTk5d7
         VQXUcxK/TgUKGtwhe4umw9tyVdeM9zFO/atsepk/2WJ0pHN8ma14iTgnJkLGIQ4rrMA+
         eVA6XNNMxHJjA2sVzhD42iDwbh6ZexsHLcYGcjxDGFlzbFq1BgqPJior8dz2xMje/VSG
         JkLmxa7ZdoRKLoVoOWFsaX6IoBbRj2I2QNS8KuVQPB0DMvP2aL2KRaa0Dq5It66f5dSF
         fBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116530; x=1795721330;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xppnKgi4kFZOZh7Zfae1BSLo1JzIIBwXzu5v89JWnQE=;
        b=Ktpgr49TtNvC5ersXvUVVjlGTQVvW6ysNgw8IrAWN/wO/iKZf+VXrDunNgW22YOgvV
         6mAlSU79N/ZNQdInWjqelWUBhrjQtdnKNO2ZvEqd6BKw5Q7pEDb1axUK+2m/hj6akiLT
         AonoJqJucDmoLDusinCgIC97vWEg7Wwqlevj0FOC7GKmutmGy8619Bou8ke3dgl1u+9a
         km6jhYfCdGXUixp0vUAyvKiAsVyMgF9F21lOldGaRuQ8nRDC2wUKcNJ9Umh75Xbf+GSg
         ZFHO7HOrH5djcPpYWQHSqgr18el91i+cqOdimfdCbfU04nBdholbIeSmWR4D5a3UWkGk
         SgCg==
X-Gm-Message-State: APuU4Z+YbSTidm1KC4IXrCV2TP+8967J6dEc97aSLdBqOASTcfUTveIg
	6TvEDKu8PjGaV+mBzKqC+1Kb2/MdOvOFGkibeclWyxiNX5+kd2WEm529tKh9SS4OyL4=
X-Gm-Gg: AZFdTZdtQEALjPcmq0phJDH0onmOHAQBm2bmPaEJUPWgw634pwRtpbGgbxEFe8wgv6S
	aRX3Fi+kkEtEpFnnwH8Nq9dLG27bzPP7hMzQQcTD5y5Tw4OGdaNgxL6jvKxe1meLf/DN9foywAr
	kL3RzK3u6zPMhSMAUTe+zv+qht5GkN7weR8dXr/ubNN82JF6KnwjrJeY/nI7Yy1ix5YY/kgTLi5
	kSueGzSBSC2dLq/5Y8ZMQ5c5Gn4WhnbDS8J4nIvCJvn05GGl/WMvGNxKyDGzoYsxC2VIPeTjhcD
	oBBqbxdzMh+xXEvtvO9GcyHahGff0IFNZwRkJijCbfjPyyGBJq5yh8fSImkj/KviZDTksf77i3D
	DXwuPlVUoKflFuW3+0lLdURzbJosXrQwQK9/yeYhKCR7WMCvY1Nc5iISe9Jr0h/Vv/PuLxRfZP+
	Gjtok2+n6Zt+CgSR8XuHZHk7t2rvdnstgkW6kh+uS+rBqnUwcpeDHczZJ0KlISbTUUKxVBBA3+P
	jrnStLVOWaxMGuYgp23ZdEwdF9Yp4edRgH1NwTB+1VKVGaYkOc2xBlADzsl5Nb55LO0BVdFpgnu
	HrE3WFuHsYAha+PCyF5cTvg9woid8awyh8PzGhJS1ToSBNrU7Dzmoi/MN60g8WKtHgaYTxLZixy
	/BkIohd+bRrJrY4OtGgd+M0ANFczvaubBNBGAG1HLE2rvZo5Si3I16lhTslDaD/RAQG0Ey96IWm
	x0/Mjw6sNyKwRIRbt4
X-Received: by 2002:a05:690c:29b:b0:8b3:38f3:8644 with SMTP id 00721157ae682-8b52032afb0mr3569157b3.11.1795116530384;
        Thu, 19 Nov 2026 11:28:50 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:1932:ad09:1827:11fb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b520354770sm4225287b3.42.2026.11.19.11.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:28:49 -0800 (PST)
Message-ID: <2bdd75a116a2b4c355b24d54f119c2de8f574035.camel@dubeyko.com>
Subject: Re: [PATCH v3] hfs/hfsplus: validate uid and gid mount options
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Lei Qiu <750592120@qq.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 19 Nov 2026 11:28:48 -0800
In-Reply-To: <tencent_F0BECCFBD52CC861F260A0F6169273C41209@qq.com>
References: <85c26064db32f34da57b313a2e5d505f60ad1df4.camel@dubeyko.com>
	 <tencent_F0BECCFBD52CC861F260A0F6169273C41209@qq.com>
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
 tXWRGxx4to6FwARAQABtCpWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29AaWJtLmNvbT
 6JAlQEEwEKAD4WIQRVwwtrZ87KC0La2wQ5XNnC34RAdQUCaBpd7AIbAQUJA8JnAAULCQgHAgYVCgk
 ICwIEFgIDAQIeAQIXgAAKCRA5XNnC34RAdYjFEACiWBEybMt1xjRbEgaZ3UP5i2bSwayDwYDvgWW5
 EbRP7JcqOcZ2vkJwrK3gsqC3FKpjOPh7ecE0I4vrabH1Qobe2N8B2Y396z24mGnkTBbb16Uz3PC93
 nFN1BA0wuOjlr1/oOTy5gBY563vybhnXPfSEUcXRd28jI7z8tRyzXh2tL8ZLdv1u4vQ8E0O7lVJ55
 p9yGxbwgb5vXU4T2irqRKLxRvU80rZIXoEM7zLf5r7RaRxgwjTKdu6rYMUOfoyEQQZTD4Xg9YE/X8
 pZzcbYFs4IlscyK6cXU0pjwr2ssjearOLLDJ7ygvfOiOuCZL+6zHRunLwq2JH/RmwuLVmWWSbgosZ
 D6c5+wu6DxV15y7zZaR3NFPOR5ErpCFUorKzBO1nA4dwOAbNym9OGkhRgLAyxwpea0V0ZlStfp0kf
 VaSZYo7PXd8Bbtyjali0niBjPpEVZdgtVUpBlPr97jBYZ+L5GF3hd6WJFbEYgj+5Af7CUjbX9DHwe
 GQ/tdXWRnJHRzorxzjOS3003ddRnPtQDDN3Z/XzdAZwQAs0RqqXrTeeJrLppFUbAP+HZTyOLVJcAA
 lVQROoq8PbM3ZKIaOygjj6Yw0emJi1D9OsN2UKjoe4W185vamFWX4Ba41jmCPrYJWAWHfAMjjkInI
 Pg7RLGs8FiwxfcpkILP0YbVWHiNAabQmVmlhY2hlc2xhdiBEdWJleWtvIDxzbGF2YUBkdWJleWtvL
 mNvbT6JAlcEEwEKAEECGwEFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQRVwwtrZ87KC0
 La2wQ5XNnC34RAdQUCaBpeTwIZAQAKCRA5XNnC34RAdew7D/48vw8dfTLcVjp4j6qUH9rOuXp5A2b
 jCEPeI0oOwRdqkyiGzUfUprHM48owvvye5u1mUZnKp8BWDDsjX4ddmhdloY0+6ecRAG73xlWMFKVK
 4P5XGnHU9A2JOtRhnOWQfPTgFhy69BSYyOeG3e5J+xPyUUBeHajbMVPKnD10NMCx8Ux1D2bv8OWbv
 3DvpUNx9D46UhBmkwIfrQWBkr0OGD2AXFfPqo08c3jcJMOAEc2vBI08Fij9o1gHwP2suFaG0X6jUN
 sy6KPOKg7TVMXtMzxNsKGyFxC1pG7lv+oaEBT6TJSVs/pm71ZrOezQANRzvBeXNUixWienTdAEG8a
 x4uOf3EF5WvYUhDiY8XBJyRv2ZnKJmBxZ3jPStadSuh3Bmo4mNgRVpFXrfb7h8oJC1l1WGdJa9aWi
 xUedku0/nH+nZMTqrtWYkXoLxaMswVM5S4f3pYKd7VlHxtlZiQ95RqQd5uWYcEN6xaSvAO3Cs4Co8
 D6etTHtKPcx1+d0x6BvkBvqNJ5yCiuzPPnKE6E0ss52KKvQt3injPyfe8ffofbW4s2nlEL1s0DoBv
 JslCebuQ6+Orb/Sl6zictIsv3XMq3jGFeZcDg2hXzngOC255+b0Z/To7jINTxYQot8jCOJQOLplxc
 NFdvziOa4FgUBC4X71upsZIoZJeii2V/Jtc3B4g==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-11-19 at 08:54 +0800, Lei Qiu wrote:
> The conversions to the new mount API declare uid and gid as
> fsparam_u32
> but consume result.uid and result.gid. This bypasses make_kuid() and
> make_kgid() as well as the validity checks in the old parsers. As a
> result, both filesystems accept the invalid ID 4294967295, and IDs
> supplied through fsconfig() in a non-initial user namespace are
> treated
> as raw kernel IDs instead of being translated through that namespace.
>=20
> Use fsparam_uid and fsparam_gid so the shared parser translates the
> IDs
> and rejects invalid or unmapped values before storing the typed
> result.
>=20
> Verify both modules with W=3D1 builds and a before/after QEMU test
> covering
> fsconfig(), legacy mounts, and a filesystem context configured from a
> user namespace mapping ID 0 to ID 1000. The fix rejects invalid IDs
> with
> EINVAL and preserves the mapped ownership and valid mount options.
>=20
> OpenAI Codex assisted with identifying the issue, implementing the
> fix
> and reproducer, and running the validation.
>=20
> Fixes: ffcd06b6d13b ("hfs: convert hfs to use the new mount api")
> Fixes: 432f7c78cb00 ("hfsplus: convert hfsplus to use the new mount
> api")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lei Qiu <750592120@qq.com>
> ---
> Changes since v2: drop the build.log artifact that was accidentally
> included in the patch; no functional change.
> Changes since v1: realigned the new fsparam_uid/gid entries with the
> existing column style in both option tables (no functional change).
> ---
> =C2=A0fs/hfs/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0fs/hfsplus/options.c | 4 ++--
> =C2=A02 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 5e6d66ff4..5ff04a7c4 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -203,8 +203,8 @@ enum {
> =C2=A0};
> =C2=A0
> =C2=A0static const struct fs_parameter_spec hfs_param_spec[] =3D {
> -	fsparam_u32	("uid",		opt_uid),
> -	fsparam_u32	("gid",		opt_gid),
> +	fsparam_uid	("uid",		opt_uid),
> +	fsparam_gid	("gid",		opt_gid),
> =C2=A0	fsparam_u32oct	("umask",	opt_umask),
> =C2=A0	fsparam_u32oct	("file_umask",	opt_file_umask),
> =C2=A0	fsparam_u32oct	("dir_umask",	opt_dir_umask),
> diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
> index 9b377481f..28717b6c7 100644
> --- a/fs/hfsplus/options.c
> +++ b/fs/hfsplus/options.c
> @@ -33,8 +33,8 @@ static const struct fs_parameter_spec
> hfs_param_spec[] =3D {
> =C2=A0	fsparam_string	("creator",	opt_creator),
> =C2=A0	fsparam_string	("type",	opt_type),
> =C2=A0	fsparam_u32oct	("umask",	opt_umask),
> -	fsparam_u32	("uid",		opt_uid),
> -	fsparam_u32	("gid",		opt_gid),
> +	fsparam_uid	("uid",		opt_uid),
> +	fsparam_gid	("gid",		opt_gid),
> =C2=A0	fsparam_u32	("part",	opt_part),
> =C2=A0	fsparam_u32	("session",	opt_session),
> =C2=A0	fsparam_string	("nls",		opt_nls),

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.
