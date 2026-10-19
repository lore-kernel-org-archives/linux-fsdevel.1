Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792453472;
	b=MxAQYtobywdE57LRHIajNViqkP0+1nrf8fGA2Yjm/tsjTweu3QP9drIcaBS0l4Dpy7Qw
	 5QzMboQvFeQfXFSZUZpR4YmNSAb2zwkn+b16Bx7s609wvdLs2M1SEbbdm0/uwNrwlu1Np
	 Bzg0EXqcthFFEZv2/zeKh+2eJtpt0IGLC7YP6o8G780xb3/sGlHIrYmc/6bo4e7Hhsk4I
	 UbSsihG9tmrIL3MjjwdRkgb1Oi3vhd8tuPJbf8UJ8wJ9ZmWClxWFOWuSVnObiOQsVdI4i
	 oLl/+CGUJ8zXDEYWF5h/Ci9bhHQ7LBzsWO8dqdHako14/TVTNcwt/otflv02E6gtbDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792453472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=mWntw6DQeNrlbWD1i8Xw112s4y9NNfIvH523iSnGfyM=;
	b=PUYDIbsVY5Ecn67fNzQBXpvhc05ErucLoAa/z8+PPffwgqn2woe6+zK/lUUGuXt0Ad8M
	 OcHP/qd+brR0OKLtk1mk2Dk56my5MblyZkuR6LD0Ke7UsjJrWjlabkYNQxKIUh+u+Othz
	 UBq47dGJokhzYy7eywnXT/oRdMee9gwwtoA2bulT/IeZAGPV/c268pQkG2VZA6NREop87
	 rK1tLO9YymQy2EdebZRH+o8rgWNDRHweu59Q+QZVF9RtWk/F5hsF7pVB6UZ8Q1vlD6R8o
	 bvTirSqWoK6Ode3LknOzEIJPglKZni6JL7By5Uw602S7R5Ll+gDw06M7ZzVrwWhaVYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=SjAIbPFV;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5F2606A319
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 23:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F5F2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=SjAIbPFV
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67990a45e02so2396265d50.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Oct 2026 16:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792453471; x=1793058271; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mWntw6DQeNrlbWD1i8Xw112s4y9NNfIvH523iSnGfyM=;
        b=SjAIbPFVHDXQBBCHdYRh4BN3dkb2BTLRuQrsKvj/Vb93q2ai7uERlo5xeCgHjDPwS3
         20FyMwidrquE0mfTtbSiEwJsMr9oyfR3JzLh2By5MIfTNAN6AWwjN0p5Pgy9x42t7eTM
         2kuseXUA/oK9GfQS+kh+myRUqCA0VzNvDF5W8g2r8vuvjxImKKNJsB6w0CfttbdogSjQ
         Nfpz/OFmkMCRwlmsIPK1nEZLpr7cjI9YMGRhztioidxkkiwKOpGKe79v64/YLcizQKNa
         7WALIGKOUFVQobzgHEj8nHHz9AuT9iHtVTCoWx0quf9v9olae4PhcuKbJRdeeuy2zv5h
         tCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792453471; x=1793058271;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mWntw6DQeNrlbWD1i8Xw112s4y9NNfIvH523iSnGfyM=;
        b=vzYRrmG+znGPuR2VN8QETudSmYGMgpCBhFk0boRrrtBhq0tNPtydO+p0VNLRzhjMKH
         vJu9mkf23wUuTlS3Y/0HJuslqBQeFbFs5iseM4Ic6Cg3DYHVBL/vu+1NkscpDogUAjzb
         17MbyHG/HOinmQyII6Vx1XUbsUmpJseS8dck4hJFLYT7l7ssAKyhXsE4Nyl2fcVnGzcn
         Jd2abr1Af4lTb4658S3St49YMx0jjVuEyNwE8Q4NbrtBD/2alr4qE3VPWl7Idv4DNPts
         MKCkWNjtgU8XrLkm0Ws6kIer0h+x4yk91g0VocBXmsm9DzppbyF+uITfCJlGAlv7+1nn
         Th2A==
X-Gm-Message-State: AFq9FYIfFgdxmDw0Qn5jy2OTiS448MTEe3+j5ZSgmMECJ6Hrv0BuK/rl
	7Xn91h1ypfgfZ/W4Fxn2k7b39catMLgxagbZafYtamrXjr5esfyqL94ezKCNWV2UBikFNvUiAMN
	C863uiWM=
X-Gm-Gg: AYBFou3GWNlixVnVJb7yoG9wug8RjCN2hWAFjyfgP2LM0+OCt+j4vWp0bxHn1a9Cvpn
	A/PTRFHnjc3uy8iu2P7z6B3wrTPtzQnN3shzCgoR/4gYROO22wvDJ8s9HmRuBNn8/ela+HZ6ge8
	iwCHAT+v725hizyW2JYQPsGHlj7WCSeLLQJyCm+APmVn1c60YkdaU6DMHRkqs32mxR0Y2ypg6h1
	dpn/h0pvspjhBieHQv0BYtjURE82F8nPBrCqeKS1xqMXhmuHzAnJjmZWij1r/Qt7I0SdlS9is67
	fxr2QGX1DRS2Ws/GTFGIYTC0KpdwlCHZncpE5mJ5xk3j6457QZplw396BfSK8dIPX6TAEpdREcJ
	LUijkGfsCfF7zbSCvZQ/qj3nrMRN/2RC3hOoh94YqVWfb4ZrrQjdLl/k/sw0t63+W3++XPETxo5
	UT068VMfOzLqFyZIqkhTfh93EZRVnNIg2VjWl/02r+htM/g44AoBQU49ufjYR7hYb+1+Sw4X3WH
	hWGfUM1v3lI5Y5uaABa7Fv9dkpO8w8ELuX9UphcHbRr0EzL/MSyKV4oAwQPrla7J6vebNtgv4T1
	79mbIXxmYQCBrhn5X2ggEM4sldF9wi46SNweEnJWEsKRZvd0fbg7STiiSnWycA==
X-Received: by 2002:a53:e233:0:b0:679:9e0b:dc48 with SMTP id 956f58d0204a3-679ca90efcbmr2624203d50.102.1792453471015;
        Mon, 19 Oct 2026 16:44:31 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9597:5848:ae16:6bc? ([2600:1700:6476:1430:9597:5848:ae16:6bc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b11b851a13sm6483057b3.25.2026.10.19.16.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 16:44:30 -0700 (PDT)
Message-ID: <4ada1910611adbf714fe0191fdf871daed1818c5.camel@dubeyko.com>
Subject: Re: [PATCH v5] hfs: initialize B-tree inodes and validate catalog
 CNIDs
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: yangguikun <yangguikun19@qq.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2026 16:44:28 -0700
In-Reply-To: <tencent_D7C3A89AD4D46F86915EA777538028349F07@qq.com>
References: <498724fe4ae0f0bc91137f573397363f962ac73d.camel@dubeyko.com>
	 <abe509bc80fe0f4e83f49af87aaa74fb95888aff.camel@dubeyko.com>
	 <tencent_A4C2280F9FC0A89C54BDEF96112DA7245307@qq.com>
	 <88f825b8d9942f8b9a94a39f53deee5e6f5d1f4c.camel@dubeyko.com>
	 <tencent_A6CC872D2A2155E7DB68E4D889C9D42E2A05@qq.com>
	 <b154a8939a2dc819bd011a502f835d9377351a46.camel@dubeyko.com>
	 <tencent_35A04F645468AAD977F1C899D38EA945D406@qq.com>
	 <0ed462f8eb132699e04dfe458a69f28941d2069b.camel@dubeyko.com>
	 <tencent_D7C3A89AD4D46F86915EA777538028349F07@qq.com>
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
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Yangguikun,

Could you please resend the v6 patch with proper subject? Otherwise, it
looks like a mess. I see it as Re: [PATCH v5] hfs: initialize B-tree
inodes and validate catalog CNIDs (but not as v6 patch).

The patch looks good, by the way. I think I would like to run the
xfstests for the v6 patch after receiving it as proper patch. ;) And I
will need to have the second patch too for the check.

Thanks,
Slava.

On Sat, 2026-10-17 at 13:14 +0800, yangguikun wrote:
> Hi Slava,
>=20
> Thanks for the detailed review.
>=20
> On set_nlink(): I removed the explicit call, but please note that it
> was a no-op: inode_init_always_gfp() sets __i_nlink =3D 1
> (fs/inode.c:238)
> for every new inode, and the original iget_locked() path in
> hfs_btree_open() never cleared it. So the B-tree inodes have had
> i_nlink =3D=3D 1 since before this series, inode_generic_drop() returns
> false for them, and the final iput() in hfs_btree_close() already
> took
> the !drop branch with writeback. I could not construct the
> still-dirty-at-put_super scenario outside of an error in the umount
> sync; if you have a concrete case in mind, I am happy to test it. The
> redundant set_nlink() is still worth removing for clarity.
>=20
> tz_secondswest is only consumed by hfs_revalidate_dentry(), which
> runs
> from dentries; the B-tree inodes never get one, so I removed that
> initialization as well.
>=20
> I will use the WARN_ON_ONCE() form for the already-cached inode case.
>=20
> On hfs_iget(): agreed on both counts. Returning ERR_PTR() lets the
> corruption cases (-EIO) and allocation failure (-ENOMEM) stay
> distinguishable, and both callers currently guess: hfs_lookup()
> translates NULL to -EACCES and hfs_fill_super() reports -EINVAL.
> minix_iget() already works this way. In v5 I only did what the v4
> review suggested (-EIO), but the complete fix is the ERR_PTR()
> conversion, so I reverted the dir.c change and will send it as a
> separate patch with the caller updates.
>=20
> Patch v6 follows.
>=20
> Thanks,
> yangguikun
>=20
> From 014ad11799ffc5fb857c23337e26121ee571f76a Mon Sep 17 00:00:00
> 2001
> From: yangguikun <yangguikun19@qq.com>
> Date: Sat, 17 Oct 2026 01:49:17 +0800
> Subject: [PATCH v6] hfs: initialize B-tree inodes and validate
> catalog CNIDs
>=20
> hfs_btree_open() leaves the internal B-tree inodes with i_mode =3D=3D 0.
> A crafted catalog record naming CNID 3 or 4 can return one of these
> cached inodes through hfs_iget(), triggering VFS_BUG_ON_INODE() in
> may_open() with CONFIG_DEBUG_VFS=3Dy.
>=20
> Initialize the B-tree inodes with S_IFREG and their address-space
> operations before publishing them. Reject attempts to reuse an
> already-cached B-tree inode.
>=20
> Validate catalog CNIDs and record types before the inode-cache
> lookup,
> since cached inodes bypass hfs_read_inode() validation. This also
> prevents a crafted file record from aliasing the root directory
> inode.
>=20
> Found by syzkaller-style fuzzing of v7.2-rc7.
>=20
> Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Link:
> https://lore.kernel.org/linux-fsdevel/tencent_24D928451FEFA8A35482EFFA913=
2A7305307@qq.com/
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: yangguikun <yangguikun19@qq.com>
> ---
> Changes in v6:
> =C2=A0- Drop redundant set_nlink(inode, 1); the link count remains 1.
> =C2=A0- Drop tz_secondswest initialization for B-tree inodes.
> =C2=A0- Use WARN_ON_ONCE() for an already-cached B-tree inode.
> =C2=A0- Defer hfs_iget() error propagation to a separate patch.
>=20
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 41b4e8f..1891ad5 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -155,44 +155,9 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id, btree_keycmp ke
> =C2=A0	tree->cnid =3D id;
> =C2=A0	tree->keycmp =3D keycmp;
> =C2=A0
> -	tree->inode =3D iget_locked(sb, id);
> -	if (!tree->inode)
> +	tree->inode =3D hfs_system_iget(sb, id);
> +	if (IS_ERR(tree->inode))
> =C2=A0		goto free_tree;
> -	BUG_ON(!(inode_state_read_once(tree->inode) & I_NEW));
> -	{
> -	struct hfs_mdb *mdb =3D HFS_SB(sb)->mdb;
> -	HFS_I(tree->inode)->flags =3D 0;
> -	mutex_init(&HFS_I(tree->inode)->extents_lock);
> -	switch (id) {
> -	case HFS_EXT_CNID:
> -		hfs_inode_read_fork(tree->inode, mdb->drXTExtRec,
> mdb->drXTFlSize,
> -				=C2=A0=C2=A0=C2=A0 mdb->drXTFlSize,
> be32_to_cpu(mdb->drXTClpSiz));
> -		if (HFS_I(tree->inode)->alloc_blocks >
> -					HFS_I(tree->inode)-
> >first_blocks) {
> -			pr_err("invalid btree extent records\n");
> -			unlock_new_inode(tree->inode);
> -			goto free_inode;
> -		}
> -
> -		tree->inode->i_mapping->a_ops =3D &hfs_btree_aops;
> -		break;
> -	case HFS_CAT_CNID:
> -		hfs_inode_read_fork(tree->inode, mdb->drCTExtRec,
> mdb->drCTFlSize,
> -				=C2=A0=C2=A0=C2=A0 mdb->drCTFlSize,
> be32_to_cpu(mdb->drCTClpSiz));
> -
> -		if (!HFS_I(tree->inode)->first_blocks) {
> -			pr_err("invalid btree extent records (0
> size)\n");
> -			unlock_new_inode(tree->inode);
> -			goto free_inode;
> -		}
> -
> -		tree->inode->i_mapping->a_ops =3D &hfs_btree_aops;
> -		break;
> -	default:
> -		BUG();
> -	}
> -	}
> -	unlock_new_inode(tree->inode);
> =C2=A0
> =C2=A0	mapping =3D tree->inode->i_mapping;
> =C2=A0	folio =3D filemap_grab_folio(mapping, 0);
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index e250f87..8d52170 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -163,6 +163,11 @@ extern int hfs_cat_move(u32 cnid, struct inode
> *src_dir,
> =C2=A0extern void hfs_cat_build_key(struct super_block *sb, btree_key
> *key,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 parent, const struct qstr *na=
me);
> =C2=A0
> +static inline bool hfs_is_system_reserved_cnid(u32 cnid)
> +{
> +	return cnid > HFS_ROOT_CNID && cnid < HFS_FIRSTUSER_CNID;
> +}
> +
> =C2=A0/*
> =C2=A0 * Validate the CNID of a catalog record.
> =C2=A0 */
> @@ -219,6 +224,7 @@ extern void hfs_inode_read_fork(struct inode
> *inode, struct hfs_extent *ext,
> =C2=A0				u32 clump_size);
> =C2=A0extern struct inode *hfs_iget(struct super_block *sb, struct
> hfs_cat_key *key,
> =C2=A0				hfs_cat_rec *rec);
> +extern struct inode *hfs_system_iget(struct super_block *sb, u32
> cnid);
> =C2=A0extern void hfs_evict_inode(struct inode *inode);
> =C2=A0extern void hfs_delete_inode(struct inode *inode);
> =C2=A0
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 2aef3c3..a66de7b 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -421,6 +421,69 @@ static int hfs_read_inode(struct inode *inode,
> void *data)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int hfs_system_read_inode(struct inode *inode)
> +{
> +	struct hfs_sb_info *hsb =3D HFS_SB(inode->i_sb);
> +	struct hfs_mdb *mdb =3D hsb->mdb;
> +
> +	HFS_I(inode)->flags =3D 0;
> +	HFS_I(inode)->rsrc_inode =3D NULL;
> +	mutex_init(&HFS_I(inode)->extents_lock);
> +
> +	inode->i_uid =3D hsb->s_uid;
> +	inode->i_gid =3D hsb->s_gid;
> +
> +	inode->i_mode =3D S_IFREG;
> +	inode->i_mapping->a_ops =3D &hfs_btree_aops;
> +
> +	switch (inode->i_ino) {
> +	case HFS_EXT_CNID:
> +		hfs_inode_read_fork(inode, mdb->drXTExtRec, mdb-
> >drXTFlSize,
> +				=C2=A0=C2=A0=C2=A0 mdb->drXTFlSize,
> be32_to_cpu(mdb->drXTClpSiz));
> +		if (HFS_I(inode)->alloc_blocks > HFS_I(inode)-
> >first_blocks) {
> +			pr_err("invalid btree extent records\n");
> +			return -EIO;
> +		}
> +		break;
> +	case HFS_CAT_CNID:
> +		hfs_inode_read_fork(inode, mdb->drCTExtRec, mdb-
> >drCTFlSize,
> +				=C2=A0=C2=A0=C2=A0 mdb->drCTFlSize,
> be32_to_cpu(mdb->drCTClpSiz));
> +		if (!HFS_I(inode)->first_blocks) {
> +			pr_err("invalid btree extent records (0
> size)\n");
> +			return -EIO;
> +		}
> +		break;
> +	default:
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +struct inode *hfs_system_iget(struct super_block *sb, u32 cnid)
> +{
> +	struct inode *inode;
> +	int err;
> +
> +	inode =3D iget_locked(sb, cnid);
> +	if (!inode)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (WARN_ON_ONCE(!(inode_state_read_once(inode) & I_NEW))) {
> +		iput(inode);
> +		return ERR_PTR(-EEXIST);
> +	}
> +
> +	err =3D hfs_system_read_inode(inode);
> +	if (err) {
> +		iget_failed(inode);
> +		return ERR_PTR(err);
> +	}
> +
> +	unlock_new_inode(inode);
> +	return inode;
> +}
> +
> =C2=A0/*
> =C2=A0 * __hfs_iget()
> =C2=A0 *
> @@ -446,6 +509,11 @@ struct inode *hfs_iget(struct super_block *sb,
> struct hfs_cat_key *key, hfs_cat_
> =C2=A0	default:
> =C2=A0		return NULL;
> =C2=A0	}
> +
> +	if (!hfs_is_valid_cnid(cnid, rec->type) ||
> +	=C2=A0=C2=A0=C2=A0 hfs_is_system_reserved_cnid(cnid))
> +		return NULL;
> +
> =C2=A0	inode =3D iget5_locked(sb, cnid, hfs_test_inode,
> hfs_read_inode, &data);
> =C2=A0	if (inode && (inode_state_read_once(inode) & I_NEW))
> =C2=A0		unlock_new_inode(inode);
