Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941862;
	b=yWkSxgUIsRGnaZwLscmc19qz0fF8kXU6z+vi901Oqi0XfSo41F3PbK2Gz/T+pPODnRAI
	 PhD9PlhBhbZ4xBkJNI5qrkn0oqquMn3kgdT9fjzBwr0zlieQk26Wwlvf7X1nEXW2Y/RrO
	 snADLLoSgrv1OphMh6kM1cNEk4rCVU4PDwqJ9+KHtL4TkMR1WQCwUSE9VwBY3pEhq6wEB
	 FTYu3oFiXtkZyuhXx4i1fbHfXp4XpdkWpck2W+6WA+92/54Lz4yql0pRsTuuNH/l30Yi4
	 2Ba6QEI62JnEdVvPyZdS+HJ4ojn5dznwCheE+qcPlrZcJQKOvGxo9F4b9IkpozDSutA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941862;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=PFl8yq8U4u0XUZSQ74HLwemggMvH0QWu5ae/UhZRkzQ=;
	b=m5py+Dh7sKLDgR3IQYNstHhWuXQIIY35GUngc59xh8NESA2IbnWfDJvNSmp6rjtNTBJd
	 bUKr8x6TVYmtVAAe4W49FLWDTLTAs47Wqa+YKPn3M6Ae1xqwHD26fvHVH2NH4ZI8wVsfM
	 1mwtFyRmFs+Fgn5w3Ro2wujcOWCrDEEh83KRdB+SGMUJNbYXXN9J1ndSKY3Cum8F6Pkbj
	 we7Dpfot8C/xZcQ5M4wvI5jbdfVYbhiA8Tia6wdNzRNOaPE0YGoicyXDC75PgIXzAs5lH
	 pYSeKW4cmzcjK4j3UPCPhU60rI25c/dHhOG3fBmRPmRe8QpupNj3iRkLuLXA3G2vjSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eGwS1+Fx;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F00606A32A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 18:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81F00606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eGwS1+Fx
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b30ff12f84so468407b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 10:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794941861; x=1795546661; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PFl8yq8U4u0XUZSQ74HLwemggMvH0QWu5ae/UhZRkzQ=;
        b=eGwS1+Fxf/b7Y5puoVPGibRj/TjExTxXC4MOx74CgBra3GdqbKBj4/PZM5cO9u8p+u
         dcbLz4WRip5G9hcqRBMyVAuQ6vKgeySr8ZOP7QjkBJDDLmZWvBEimGD41uDfdU7TYkEi
         D7PjvQWzbBxn8jPcNL7XODpUCZnVXHbkH/UVmF0O5W1QrwXEbh1rVKvCFSbrPj1bwiAh
         spY0wEtSsFyANRtDnKiOx4JBJFbzrJvsYshIOrCfNvkA8o04BrXiXpIjMZDnmyTvqwdF
         DaWQc4mXHnrDWYoebhrCDV235L4jFd3ljRhaeD9nx7teQ/HVwP/MsvglBKXhNXwd3Mjs
         YMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941861; x=1795546661;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PFl8yq8U4u0XUZSQ74HLwemggMvH0QWu5ae/UhZRkzQ=;
        b=wAlvHC/tsRKk/yGFxZg0l0R+bisUyla5JiCmM0C2O2BVx1c3Jkov33u0M3mgyzaTmL
         8mkrtgN4j4wJxHs4EUKfMaGVRmeYEqfKRhPxWziKOGujCQ5TcefAT6c/IUaI+G5S1hmG
         F+kIq3/4rVZP48jek5yW+tU1xDuc//d6lU+MI6arH9tq2Fc71c0zp+U8G1tfG2zCYThk
         xtLwzrWpUK3uLEc47sCRHhIh/2iaIAXeBTeg3bHyDkyeJITHpw0Mo5widtZTvWBp4ZdZ
         6o4Iez2jrCRm0Gy+RxOdSy8EP9fiMhd7PcEtzg+UcZyJxoJASXVS8wvKL3xUr9TPkPum
         QKSw==
X-Gm-Message-State: APuU4Z/AtNxpMC1kCZcmosYPWPUWfPlz+yBc/x0xld/FFVsyiEog1NVU
	3f7rNfWooI57MGaNh4VBeWlVGKfnjvLLDA/bNIHz6tL1PvHDQwCtRiPEiaCcI5NvuTc=
X-Gm-Gg: AZFdTZdQg8L5w0DgjWAe2NwL+HBiPd2QKOYWtgcG6L0V4O/6cNelY3oQHXctjtcyHL0
	LxuhKF3XCuYUZKz32EclNQAqbLBjIzsmDsEjHkWOkqr+nEqIWleoYDN37Wxa2kuVJhCNoX+0tZO
	nLzBFZ75MqcpsNnez06+giRQvbSQnhON9IhWpyt4nApedMa60do+lJFr18YV3zKgaMEQQZs71gq
	jkU3dP4Mj9nbHlBapEj4mTyfeESOthXhvIzH58i0cUx2iDRb/P317hbopH5bGMHVUotIHnhAY6E
	pkJUf9iixQBLTFmeerLvfn47xCDh8nUBqR3sYV0FTEkQYSPVvGnAV5hDfTDeO5USKr0VgCk3sSC
	f7CXpHv36N//yi7cT9JTHMhpgpG1wxbsvnxol1H0eTaz9QM7ViPltetH6vtJ8rQ0x66nP4sWVd2
	vhwUMltcHXI9zVtiFUmf+8nAbvtlMEh/0YwdVxuFeyizkNjLcLY1699D2skq1IIVd8aoDQKa6wM
	vxWHyLTm6Ydvnew7mbUEIpRKrxy22fDvz/06QQY5i0OVActPiOSRoBQXC36/+LNwQVFVk092Uki
	AlccSiEPUZ2n8NNpKN06poMtUioEiSGWPX02w7HhG0oWX3tNdwF0GWUmubcip1RVrDUp+Y3QN2P
	ovJ2n8jtNxgOpIJcMaQO/ONUq4PZl3yejaLznayID3M1WMgJyJlZSInO4ndCF6WFb9WYxcB4qQG
	LOZt9luJcnjAkQaBRRcI3OwPqjB/U+GNpty5Rfj0Sa
X-Received: by 2002:a05:690c:9b0a:b0:8b3:361f:5d77 with SMTP id 00721157ae682-8b4fed4c5eamr1156317b3.26.1794941859929;
        Tue, 17 Nov 2026 10:57:39 -0800 (PST)
Received: from ?IPv6:2600:1700:6476:1430:d1c7:8722:e551:bec4? ([2600:1700:6476:1430:d1c7:8722:e551:bec4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fe0c4bbasm3650177b3.30.2026.11.17.10.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 10:57:39 -0800 (PST)
Message-ID: <1b0016e4e6003eecdcc64e7c11547b36842b4f2e.camel@dubeyko.com>
Subject: Re: [PATCH] hfs/hfsplus: validate uid and gid mount options
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Lei Qiu <750592120@qq.com>
Cc: linux-fsdevel@vger.kernel.org
Date: Tue, 17 Nov 2026 10:57:38 -0800
In-Reply-To: <tencent_5587BC2AAF0B8A78412EA72E01CD9C424D05@qq.com>
References: <tencent_5587BC2AAF0B8A78412EA72E01CD9C424D05@qq.com>
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

On Tue, 2026-11-17 at 10:44 +0800, Lei Qiu wrote:
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
> =C2=A0fs/hfs/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++--
> =C2=A0fs/hfsplus/options.c | 4 ++--
> =C2=A02 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 5e6d66ff4..4309cc23d 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -203,8 +203,8 @@ enum {
> =C2=A0};
> =C2=A0
> =C2=A0static const struct fs_parameter_spec hfs_param_spec[] =3D {
> -	fsparam_u32	("uid",		opt_uid),
> -	fsparam_u32	("gid",		opt_gid),
> +	fsparam_uid("uid", opt_uid),
> +	fsparam_gid("gid", opt_gid),

The patch makes sense to me. But you are breaking the alignment style
of the code. Could you please rework it?

Thanks,
Slava.

> =C2=A0	fsparam_u32oct	("umask",	opt_umask),
> =C2=A0	fsparam_u32oct	("file_umask",	opt_file_umask),
> =C2=A0	fsparam_u32oct	("dir_umask",	opt_dir_umask),
> diff --git a/fs/hfsplus/options.c b/fs/hfsplus/options.c
> index 9b377481f..3ec428142 100644
> --- a/fs/hfsplus/options.c
> +++ b/fs/hfsplus/options.c
> @@ -33,8 +33,8 @@ static const struct fs_parameter_spec
> hfs_param_spec[] =3D {
> =C2=A0	fsparam_string	("creator",	opt_creator),
> =C2=A0	fsparam_string	("type",	opt_type),
> =C2=A0	fsparam_u32oct	("umask",	opt_umask),
> -	fsparam_u32	("uid",		opt_uid),
> -	fsparam_u32	("gid",		opt_gid),
> +	fsparam_uid("uid", opt_uid),
> +	fsparam_gid("gid", opt_gid),
> =C2=A0	fsparam_u32	("part",	opt_part),
> =C2=A0	fsparam_u32	("session",	opt_session),
> =C2=A0	fsparam_string	("nls",		opt_nls),
>=20
> base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
