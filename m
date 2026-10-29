Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793271361;
	b=A3I+LyBVDlGjIkHYhtp9MC1tHYNKCdezYjR4NBeQkX8lONt+aBBrMTHcxSsXXDqRqAbc
	 J49+myhi2eEn+O3KbiZhP6Jg6m4FJZ1T1ktcfGoWpCCbjH0OMmJIfPmCx65pLzkYB+TFP
	 KtO5pcz0AP3URdL2uTY07C2rr1N3nAqQuXubfnINR6cTuMjh+mGrKkHY703yF1tIOkZ+Z
	 B3JdeOOCZQxPg0UXabj464ylxVSTxlqssowXTTdskrVtQEHl2XON2vJrGyj+yGuhsJgS4
	 3z3Y8nOb9LNBfHjce4GK5d/XMC/ltQNx9YITxOjqwIBTAtxqDaqa6i4ylvB2sYFXMpA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3fGS6loIim+Swa1mX7t46+mUdJqeixhvle4YB5lLPZ4=;
	b=SRWUobEnaqYExL7hkQNhwC53MP7AjyYfeeUt/lKsm5pve62sodd7sq7LeHmcjk6pbPz9
	 wEKEbcQtVcl0zVbmeiQHYwPvFNkx3j3aCwqS/dggAwA8GZXgtuEg+nfpj2IFVejrF2OuV
	 71mhHXR//ZNGQCTQvWeAq8s06kFn6I4+uHwf3JxitZki3cK4qbzgE3IOvPsmGwuQJmpa1
	 qD2nM5HI0OGMey3aFU5TFfknUrhErlWRlztjSXPXNfRFsGq9XHTECysIWDleW1EDGN+Dh
	 qDCNxHe6vyxf9I1xWYds/JcXC2rxNl7/0X/O3/eyDEkN6AyUg/KtcI0a3dyvbKOSnkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDa6YDIn;
	arc=fail smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A00606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1A00606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aDa6YDIn
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c40e30c26a4so114829466b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:56:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793271359; cv=none;
        d=google.com; s=arc-20260327;
        b=Ltf6qcuSB0qacEWuBz8ObNv2AyUFYLnefewcQhy8AIREH5464pd/bp5JJdBgPiTwKn
         3WpKBkyyki5ilA5cgZmFtdoJpAs+yIdRxdt8bNftiqmYrSGzVjz8Kzt3+TkNMyZWWDJ/
         UPjWN/by+XC39QDbR9ViuD1sF/dWkIMc5Fb9n+ZLpwfghQEci2TMrtWEgaKmPyF1ROif
         1cUW0Lyt2mNKIfNzuXSoayotN/an9wKnGw7dJDvbACED28Kf9kfaXHXkkJH8aXunyLx1
         8xBoE9nypiAAXqBBmV6PhEhRdi3A57eZXVsOe/N0l6ITchRqpmlw7DvBpeW2D7gFlOfV
         7dnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3fGS6loIim+Swa1mX7t46+mUdJqeixhvle4YB5lLPZ4=;
        fh=29MKqfBs7JYDEVosPcPuF9/g0pucmj+udgzD7Kee3H0=;
        b=Ck5DnKN6jozFpuUf3zFifzHgo+k6bir0kj9VGxqFQ545qqcsadr3oCH0X7Gnipryza
         WWlaxRrepuN20efy9+6Vv7Vpw9ujrYPJBIp09q7RLazqH8vPnVGlxOiCl4JILid04NNK
         gd35DY3g+1a+HGo7NeNBkesjtKf9pz5u4B6C9t8EGGmclQinrU/KhfzXU4v2dtdpdwBU
         foJnQmHBLUpOpdFr+xXg2UOowUusV9/NBQmZ7vBDItGNhUOR2dgM7vGBWOYcgN4SHGKP
         F8nyDTbOfYID2at0QL/6KgET0uK+aSBIumUWacChnj3VSPlznlB6pmyOkMzcg4f7mo2b
         KeeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793271359; x=1793876159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3fGS6loIim+Swa1mX7t46+mUdJqeixhvle4YB5lLPZ4=;
        b=aDa6YDIns00zqTqrPCKgp5NqUduDBvv/bV2D9/roX28//Qm4jLBZeNEDCJBoxLxGYQ
         3deQplSXIB4dGOBpsXUlzlSyGM8+f/V65tj2kzCO+HIFi23vUmupF/K2QwQrMt6eBNFz
         NvwDNZJi4UCAi4M0oQHbYVPmxVudV9V1fWpgW5IneFG2GZIFBXRNTcPKxhERt80v0+j9
         DBItCsZ5yudK5t35vTLzHsgO0WbzthAXGGQKmQPFzA3FhrDwQLCU+Gg0I/Icf18qQCSY
         xROhsSzumYexKJtliqcMeqogE6Zs3iKhWq58DD0amHAcIztBMpIfeCsfWWEg6e+3OZXA
         yIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793271359; x=1793876159;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3fGS6loIim+Swa1mX7t46+mUdJqeixhvle4YB5lLPZ4=;
        b=rH74I/XzfD6Rg30llX0ze6Xsi3zg/WeLpBdhDPwBxpjL987A/WFSlkfhxQsS3BvIxA
         kB+i4A7Uik76RNETazjLGvu2OdJx4ioWcamFrz4qdqHDu/tcJQRI9X+LYQBksUcwVVy/
         JnV9Pw6nycrsWEoIv5/7blda4BYQl1maboPW+tF2Ls6uTI6imnSmvWkRXbOyH+7ztjg1
         /aef5e4Cx/yG1mpz2WArm0jPUDNxWZR4cePKWn2eCUyu+zaez0F96D97rRhCjRjgxGKY
         BoALh+qiH1P5yQCNiTuQoWGYiNgHEn6e3IAoQUVILX8SU/MhRbZ0rsm66f+g8W5lS6BI
         MkJQ==
X-Forwarded-Encrypted: i=1; AKwUvBxJKvwzNtqc6p3ManopU2WLbrX3HYA8ZuJH0iGDPpcbJUv8/uRzihibMyOEThpoGL9D+iSm69zcuAxi8c9e@vger.kernel.org
X-Gm-Message-State: AFq9FYK+JbPscF30hhdupnkeZQqFgyzrIhiIL1mTl84dAIoArDC+ssLL
	3BM+ygotbQaTMj1i9GEMnCTfEkHJRyAd3jGAEXoP11OcBZEZMQxUXzvvotOChNVR18M0ZbI8i9P
	0+6AACR7ZapxaCbrNl4PwsA1aBimj2Tc=
X-Gm-Gg: AYBFou2qR4bHyFPIWcjcppxQcU5i1J2+dC+K2ti79Uc+gLaZKD2f8H+bB2QDp/umZ+G
	V66AO4dyJ43n0c3xKIz/IYCLiIIN06zciWeQld5dBNBP+QAgb2935BevtoNRJisC+EQI9IffbVj
	NnwOJtvwjqFmsB3GggEGJgZYll7Xm9sSClIMYhxbLRwqlPhsgOMs7fWUe/19JN2eOCbUrt6ZqPa
	2C41hJemrvvN96QCnOL/HvF+Df/PTnM+041dqczlvwTz9Fiv/HYtRxPV4mUA676tTJoDr499FPV
	sjLM5Nx4LP/pQhVUmtxBievEUuvR7Byp+KEcLNUAnjqvHJMQnbiWmqFSenHyT6sFDtXrq/gUyGQ
	xmgo2XPdoV9XlOlMjiHwGlHz4KsFcOczTew6Nd//iuuCfK3ieAV0Q1FHdwb7b6EwW4q62Rg==
X-Received: by 2002:a17:907:d308:b0:c2e:2275:1168 with SMTP id
 a640c23a62f3a-c49d13b7f8amr182816166b.19.1793271359214; Thu, 29 Oct 2026
 03:55:59 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028195133.86636-1-dennylin0707@gmail.com>
In-Reply-To: <20261028195133.86636-1-dennylin0707@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 29 Oct 2026 11:55:47 +0100
X-Gm-Features: AclHuK9ES-fJm4qV7qIWyYn7jHeO1ZZUKHOCjIZSlhGweuLSd8vCQZhkASRtuK0
Message-ID: <CAOQ4uxgDk-NQ3hrHLwPkLT_6T6EvM1Mxk1aOtCsz1TYgup_FNg@mail.gmail.com>
Subject: Re: [PATCH] ovl: reserve space for the casefolded name terminator
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: miklos@szeredi.hu, andrealmeid@igalia.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 8:51=E2=80=AFPM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> ovl_casefold() allocates NAME_MAX bytes and passes that capacity to
> utf8_casefold(), which also needs room for a terminating NUL. A valid
> name whose folded form is exactly NAME_MAX bytes therefore fails to
> fold, and ovl_fill_merge() falls back to comparing the original bytes.
>
> For example, when two casefolded layers contain directories named with
> 255 uppercase and lowercase ASCII letters respectively, readdir lists
> both names even though lookup treats them as the same directory. The
> same names merge correctly at 254 bytes.
>
> Reserve one additional byte in both the allocation and the folding
> capacity so that NAME_MAX-byte folded names use the canonical merge key.
>
> Fixes: ee95c5fc86dd ("ovl: Create ovl_casefold() to support casefolded st=
rncmp()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  fs/overlayfs/readdir.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
> index 7d6f7f6022eb..6113d690f8ad 100644
> --- a/fs/overlayfs/readdir.c
> +++ b/fs/overlayfs/readdir.c
> @@ -81,13 +81,13 @@ static int ovl_casefold(struct ovl_readdir_data *rdd,=
 const char *str, int len,
>             name_is_dot_dotdot(str, len))
>                 return 0;
>
> -       cf_name =3D kmalloc(NAME_MAX, GFP_KERNEL);
> +       cf_name =3D kmalloc(NAME_MAX + 1, GFP_KERNEL);
>         if (!cf_name) {
>                 rdd->err =3D -ENOMEM;
>                 return -ENOMEM;
>         }
>
> -       cf_len =3D utf8_casefold(rdd->map, &qstr, cf_name, NAME_MAX);
> +       cf_len =3D utf8_casefold(rdd->map, &qstr, cf_name, NAME_MAX + 1);
>         if (cf_len > 0)
>                 *dst =3D cf_name;
>         else
> --
> 2.43.0
>

Queued for ovl-fixes

Thanks,
Amir.
