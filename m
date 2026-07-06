Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6431919ABD8
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 00:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783298248; cv=pass; b=Zu1ZAstE8rZ1aDBVi+ksVuxMU5w5hjl15rvge5hYNWkaeb7Q10q4SCokqOeTFBek6d6yq1oxfvTOBpA6h02uAohjYBOYRS+gL/hp/LhA5hKFC+QdgKr17XryestB3I6FAdtReKUuxFlO/+cBcarlfctv4O+m1Q+zPVv0WHATFVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783298248; c=relaxed/simple;
	bh=a1sNFlemSnst5DRwn6HVfhGLDjDBTrBHz7XyuMQ5Jz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uBVXq94iZul0jtHVzjkWhdIwWmT0cO7gNkh74K62G8iwM27Tt+lM5HP51Ck4cY1SVSLI2uU39w/kTqvIkJ4r9sUesECkmjg3La9S9oInA6VG8HmOEi6dIVofNem0eVb+bM5Iu2unDyQIG72oO/7ZrXKBX7DIcRaZw3YSeSJJuk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZMjikGj; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZMjikGj"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so2325471e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jul 2026 17:37:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783298246; cv=none;
        d=google.com; s=arc-20260327;
        b=DOg/1GjL/LqKuSfU7/REV6omEsm93huPfxgYjP7S+Bx18WSIh8iTVrxQNS30FnPcgH
         /l9rHKNK4H5UokKdsmDO/9nsFSaX0mFAyu1Ead8/O8F808jSH+0WTdXhJVXRtNO4C7Qy
         lj6tiYH7Yl3hFdQgnJk70qDyr7Mzz2TsYgC3b3NGTaXm7+SoidsKsBML9jV3itKJUl/D
         PAF2EXPE+VwuRoz2YEB0zEjrkjEoBwZzZjGwUbR1d8JQ5hTuWYXDG1mEZCsmVe8gB1T1
         2EouLdlbOBA1pPK5GpfJPyStAec5xi+v38WjOAeKknIam3TdlQNya/KBG7OYZMY+SYwC
         IENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UWAKyDynv8RXTv9tuUKB2vZhyQ2pIsxntV6zpFRP4JA=;
        fh=AzCbImhbNTmsogTqfUT90Zpd5y0N0i5+tRpZmADxAHk=;
        b=dKNRwt7fvyKe1xwkFefFq53NTvbVvPxtnLkJ7/WoFviwOPE20QXtlPEh0lbkH4FRRS
         CLRL/NUB1lBJHnfVV7A26be7Cz+W2QCsyprQBBFTDBwBt0ryoRn1qphB9PTfZjL/g1Jv
         ndY9tw52vTMCeu0HH5HVgAnmakDj2l065dfnN9Zpo/N+kEmvmgeBAo+ZfH7r29AXqZh+
         gJ8JyH6oKHGZTQEKNk6vCV9MbIHIx/dOpsWMTTPzjzbMNFsMcLjamdNK/xRXOlRh9lrZ
         gtopRm4NvrrwolDfnwN8jgTgYaxgldiGvAkg0TfLBf33oESQH9oN4sgLwtaVl4XKGnRv
         D8gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783298246; x=1783903046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWAKyDynv8RXTv9tuUKB2vZhyQ2pIsxntV6zpFRP4JA=;
        b=gZMjikGjnMOd/ACfXbM9WVzQ37fcDFX3F71GzTDM05J1hR/xFg2rLsdbPstmaPt7R4
         Rl3yIXERvME/Yw+r4/406wMOEzfD/Zz4mjI/cnwuSCPb32NZquDGPKJAzal+5VlOCCWv
         ebBt2/d3U7b/gHBi/LhOb+W3xExDU1pHsXGd9JdnGm6qxRlVQIjvAEqQu9uAlSMYWvEc
         eBShiFzBSbciB6Uv7KFChVSpKJI8dYWIEjJ2L9Qa1/6HuAZA+373UVgGGDiy2VdM9mhp
         yvEv+XpNddA86t4j2GBqcBrrSzrH1Nn09/DZGqFW4lWm+GEFv3TfyNG1ETr86eylXiy7
         vEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783298246; x=1783903046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UWAKyDynv8RXTv9tuUKB2vZhyQ2pIsxntV6zpFRP4JA=;
        b=WF5Jd0uby7ncLHdZYan3L0jqXureFGMnwHYAqV4cBIUIq/55qmRjQFRL5uy3s6ogXz
         7sCBmwDqcdrJ272le7vslLHvMS5/yBIi43fYXCF2brR+UdufmNpnteUwQOjfkywNZ8lm
         fLa1R+Be+jZliVuQuqMTUIK16NAWXEDPcw9MhojxqYJqRc/5uB8MXl5sFQ8DXIf0iuH2
         HHnptzbxus8tImU5hzql2yFMIl6SjK93GAFH0q9V9mhXxWibGWhuCoVjR88REnaXdVhO
         nKI9Gd1uOcl/tuCJeKjgjpVQ3nwQG26KXYCTB9vxP6G/rvs/i4f3VG4YouOx9YCKcVQX
         0ENQ==
X-Forwarded-Encrypted: i=1; AHgh+Roj5gpPEaPGRWmtU9UFcUiBcTVoJu2WA+PWHN2Mzv8T6MBYhgMjWKbRnmQsLP8y2NCFqjivzivLF0RahcNY@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn6Cb4JB8aV7tvOyDJ8uGtYF0JQQyQHuhrXrr8ztdgAwhCYxcg
	850DUNVJ9WSiJbi2wK+GIJZJwZCeaGMMuhi9Kig+RNPJHlTObaFopRa514euQ/SHD4Q01HaDni2
	Oq/HsSop11epylxJnf4/l/KBuGcqnqokpkA==
X-Gm-Gg: AfdE7cl73rVENoRGcayt8VwTK01C6T8wclUcs+UFJX5rAQxZHaOVxxEdpbdro0WO5B9
	YEu0SwoR6gmozhrnaorsBsUt51oeE69wKoAtF3XEmP9xQNL2UVYyRf6HsipKnk6L81pUec2NW3d
	s4cTgjWUcs48I4p5b7QMG3iWPAUePLh2kdBaHP8idDRdXZcj0fgjSnD6verLKFpl4cYSYgxzL22
	hsTiw5wNGjAfMltgYzqXxWnGMBWDkUHB5s/ID4pnT2wgHHjVTARXkQ8QL1aPZZ47s76+HOv
X-Received: by 2002:a05:6512:2252:b0:5ae:ae6f:1f20 with SMTP id
 2adb3069b0e04-5aed50c73d1mr1547894e87.54.1783298245674; Sun, 05 Jul 2026
 17:37:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704144654.126437-1-mdshahid03@gmail.com>
In-Reply-To: <20260704144654.126437-1-mdshahid03@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 6 Jul 2026 09:37:14 +0900
X-Gm-Features: AVVi8CdFYBKDrHLkOdQQ2z7lU6f1iyvGvE6jFuOLv15ZZVflC6Wf3Vr7n_kR3B4
Message-ID: <CANFS6ba=oS28Le1sPEamAzmz9mUwFWacukRJztwE2UTB6DPaBg@mail.gmail.com>
Subject: Re: [PATCH] ntfs: dir: use kmemdup() instead of kmalloc() and memcpy()
To: mdshahid03@gmail.com
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 4=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 11:47, <=
mdshahid03@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Mohammad Shahid <mdshahid03@gmail.com>
>
> Use kmemdup() instead of a separate kmalloc() and memcpy()
> pair, simplifying the code while preserving the existing
> behavior.
>
> This issue was reported by memdup.cocci.
>
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/dir.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
> index 4b6bd5f30c65..df94603ec102 100644
> --- a/fs/ntfs/dir.c
> +++ b/fs/ntfs/dir.c
> @@ -959,13 +959,14 @@ static int ntfs_readdir(struct file *file, struct d=
ir_context *actor)
>                          */
>                         private =3D file->private_data;
>                         kfree(private->key);
> -                       private->key =3D kmalloc(le16_to_cpu(next->key_le=
ngth), GFP_KERNEL);
> +                       private->key =3D kmemdup(&next->key.file_name,
> +                                       le16_to_cpu(next->key_length),
> +                                       GFP_KERNEL);
>                         if (!private->key) {
>                                 err =3D -ENOMEM;
>                                 goto out;
>                         }
>
> -                       memcpy(private->key, &next->key.file_name, le16_t=
o_cpu(next->key_length));
>                         private->key_length =3D next->key_length;
>                         break;
>                 }
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
