Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FE2336ECF
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863435; cv=pass; b=dmTZbOpdnwYHMAJqUUC5P/S1NND9JjoWOguk09JXDj+4SilMAf8DjxmKyvInKWdKlXsgoChB+XvVrmWrUR/glxWcHIODu5HvY/bREK8CJnh2t2hCUBB3RQh/O9+5Z+tiv5VyuntKRA7LZRDuwgjknSV6AAzz2vtUb0eHqUxyGb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863435; c=relaxed/simple;
	bh=Os0BCB17opKvNzfWaWmy35HOKb/otcD9H0RdbQOsd18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zjeky4aIDjuha2jjiTNf6Ja15+xEgiD3Jd0IIGYvnKy8Los2bk0yqSY8Me0kg+ocNaFb5uscwhfc3blTlxd2WpkZwdR2ii7aB1z0jXamIEWPy47D/YWlV9EFcRtVJpGz4lftx63ylOFduVgW8xBsnG8t9nY0WsS3jwbF/PtnXkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JfCFDHpd; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfCFDHpd"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a3d42263e4so2613104e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 16:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775863432; cv=none;
        d=google.com; s=arc-20240605;
        b=G4VjNueVZPwu29RiyGNVvlw7wdgQeLh+vQMPxoID/OvKNeHTN8nOoxOK/S8Ho3B4Cp
         wOj+71deotecKpI9HOAV6iGvGiOAm+4U9tyXx32yvyT3csjlEGJbwZ6YRuHUpN89LS1V
         jG0HlSwLlMKrCs9ZTiStks1XgExHUYOVMW2dSy64Yda0HzA+vr14K573x0Rwltwn68oW
         kCLUwdfk9EKvO1S8hMsWsK7Svi9pXiPN4jpar9or13Q1e9kHvV1hAeV9+g3B+4qDpDHX
         rXwWkvZ60Ge0roA1Ccr/cTMCpqP7z4l3Rio9htQ2FKBliA2XGCWy8EmWKp3LhEcWa15I
         Pw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DMaw5i2hxWOm6x4SzpF4gNjjqFipmF5/iEGGBkTmhWU=;
        fh=BhTIidZt1KbQH8Ti4IuuF65duIRJW8/xSNQaaFb0h8w=;
        b=bI9cJP+FV1hYwOkRwlr/MoNAQkx1hhN3142dCGl2YHKAzohLRM2CSMhvp9OfD9ITfi
         DTezMH1pdJQRRVZGtFUfXbeESW6FIj4Ty7ccDnwYt1x873HcuxH1eCNxZg1GrK+3RIlx
         RJ7XZXQEGL1ZtVwaWQlOvsOwfIpNKGLOYrlYfwl1hGk7rb2rh1IECvwTYUyPDWRo1eGV
         7W36KSs2pGHxXQVNr49rgM+c2u08bTSSI7bhmnUGZuc7G7K04HSuxc93lq3OJ0FwOLl3
         vkDxLLwjWrdYmY8ge2W74HYLLaO9T8mM5KfGQ5YuyuZ7t1Sl7DFEp6a/7xt6iSJzsS09
         WvSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775863432; x=1776468232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DMaw5i2hxWOm6x4SzpF4gNjjqFipmF5/iEGGBkTmhWU=;
        b=JfCFDHpdNtOa6lKi27dBIwIh76EnDNFUP1k2d5UqehdXUMnP8cZR0+0+p8Ttjl0O08
         GdelU64ur11Q7FuNGpWnJKUcUOmKvWF+mdpPKyvc9feSnwLEir3FTXsH/CU2IiIp6Rxz
         oY9DBikqHLLqbJPkhKyDLd76eTgDIemLC5hxvWu/6bai+g9tG7oqam72IbP8FKbnAo0r
         2KtG+/eQ0Ty1Nd/+tase6Yr7KkrRbNyXNk5ZOHbPU04coVxSaXGDXcJFnbKGuvnuyeaw
         LZKHdbQnKBiEGyrTSBwjEJuOoJFjWYMJxaFgrLMWPKcwEcl8hGYXbquqZaE5wUCo3IVy
         u6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775863432; x=1776468232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DMaw5i2hxWOm6x4SzpF4gNjjqFipmF5/iEGGBkTmhWU=;
        b=bsla94q2jzR9EqbroutoGXP5+pl7k7Jzh6sdhJikoIKSLrlrLIPU00Z0qmcWsogOb2
         +dFFdwUwXJ8phOdWtL3zprpPzrnLOSLXpW6pHIDjinePbv0GIZbv5jReuHSs0sugH6Mx
         pvaIQRlZIPWzkJwvEPnLrHrdLXrK/bit/uZoRFoNhWh3gMcYpzZLI/qnUvtHp8b3Mg0Q
         PbpyyjVmS64RfftNJSBNKzauhmhIOADtgK8ng7Wda+sSHFPa4PRAtxXAu9OUw8ecgieJ
         d+dpExINYJjaXzu1TjugM4ixF4uNwS+c7c4PcMvo/Dx8iiVnKXqRxiOCpAk9iX76V0J2
         u0bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV26f2S3zxgAQB5LeYmL574p/klxTfWvWq0ZmY///PAXpucNjJR6ezCtBqFUbOMYgoRTPJOhW2B+aBTm6b@vger.kernel.org
X-Gm-Message-State: AOJu0YwBjy9tKFcQsh6eu3hKl4gntkHI6WAk0sJ085poCLazVHlq9wXz
	+PS9XW6N8rjJMzy3we2VtXMLYdgP8h0qd05vdkels/5rC0J/3sk4xao5PCPPE7k6FiFUJLPridZ
	Z54oJet4+ZMunWbKjxVSNs/igfte3Rym0tUTg
X-Gm-Gg: AeBDievvPwYnj4O7f+VS1yHTN+tAGDRzhWtPZllzEy4PB3eTfV2Arf7jxcC24ZWOTtm
	h37wP/Bld5qYoylG+KMsNji7l+Fn6tC5xxj+BDRvub1rxKTIuWtIVPAfKFssbb1GyeOAfkXmiM1
	5HV+BAcVKqPyJvaFODWKXtkNx6LqfoYTlKvIYS64D29LMeFdVVVMgOzBZLL9dOz/OwVAgCkKozs
	qUqwX+89l9ar9z+T9kUwEMwphD5x2hhlB0QZ1SUCG5u1TK8DnQc90B+CkpzFhdJjBXm1Cl61gja
	fPUaHXyq4g==
X-Received: by 2002:a05:6512:1285:b0:5a1:885:1dfa with SMTP id
 2adb3069b0e04-5a3ef90436dmr1879326e87.13.1775863431596; Fri, 10 Apr 2026
 16:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adic_St-SP3UONMV@stanley.mountain>
In-Reply-To: <adic_St-SP3UONMV@stanley.mountain>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Sat, 11 Apr 2026 08:23:39 +0900
X-Gm-Features: AQROBzBhLpZG-I1c_Bu4YQMcsFFScuG3SLWCs6sXVpoZNk1o0cnTBlZ7Klt6YCE
Message-ID: <CANFS6bY_9YtCSpATnhEqzZKv48g86Sk4Cf36cVvLgZm3gQ8Bcw@mail.gmail.com>
Subject: Re: [PATCH next] ntfs: add missing error code in ntfs_mft_record_alloc()
To: Dan Carpenter <error27@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 4=EC=9B=94 10=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 3:47, D=
an Carpenter <error27@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Return -ENOMEM if the kmalloc() fails.  Don't return success.
>
> Fixes: 115380f9a2f9 ("ntfs: update mft operations")
> Signed-off-by: Dan Carpenter <error27@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
> This email is a free service from the Smatch-CI project [smatch.sf.net].
>
> I have wanted to avoid sending patches but it was easier to fix it than
> explain the warning.  :P
>
>     fs/ntfs/namei.c:677 __ntfs_create() error: uninitialized symbol 'ni_m=
rec'.
>
>  fs/ntfs/mft.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index bf028c1aea26..0c545fd08b66 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -2503,6 +2503,7 @@ int ntfs_mft_record_alloc(struct ntfs_volume *vol, =
const int mode,
>                         folio_unlock(folio);
>                         kunmap_local(m);
>                         folio_put(folio);
> +                       err =3D -ENOMEM;
>                         goto undo_mftbmp_alloc;
>                 }
>
> --
> 2.53.0
>


--=20
Thanks,
Hyunchul
