Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A57378806
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779455778; cv=pass; b=MEgW1CkE59XaywvMEQ9cdnFJHDpq3HLZBooRl9XU3g85CtB+cmrUQG7AF9g0XvI1DTolY7gAJMKzun4L/Ul97V2cAczIoxvrOKiVCONLil33EbWja8SanlZn3ddfWyc6KQ6bn2VeiFuoRXEmxUsHE+zKjNIZDxUVrWzJR9r4gRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779455778; c=relaxed/simple;
	bh=knEzt954MYErF5tPrQ/OSiCyrgF1H44jbhY46Ft1O3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5hrh9yx/WMWqVqGSZLy+0jTKtIb3s9YOVM7vfP4DZgZq0DkSJh9UGH1gCqQU6ClTALthEWs+Z5ZTRT0q7agD1pZI48UIHXEybCTy9i1W59DB14B0MffysvXjI0v6dgOFtYxOFi53U2scD+/Set5P4uFG+RLBkFcDWgWwOuQyrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QklRhXfH; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QklRhXfH"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6543c251311so644566d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 06:16:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779455776; cv=none;
        d=google.com; s=arc-20240605;
        b=Vq17XlpGekFnGKZaQUtuPTwGLsbTU+bdYp296gOBAYKdQ3IG0qJ/L3QVwzU8g66knY
         xnmommnv9Yq6RNgSN766RHftaV2aI9k9jWGjNdYPX1DPNRv1KraEHq49AvTm+j8iA2is
         brS07Mtpr327DvGlHHhRkdwCIBIy/wMX1aWiQnHh42OY9zoiXRfIymcgmizXOEKE7Q8j
         ArhrXsbmcACYHxxVkF7FZ6h6EZ7NsRYYeShoWcABgqK214x94Iy3CRZP3LjtvvbDZeEW
         hmX1SOoG1xnS/v33NqmFp2oFiPeAJgsK9/ns85nILyqkoYrem/pLzGWYPP4Ks2Uy8qrz
         PuMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aTSwoFAHbwK1zApsrzgPugaNKXvui0kw9dgms0Qvsq8=;
        fh=+ZCJWqWwtWwufjxYZfSmy63u551HDvxc8tQZ62tVoKs=;
        b=eNiBtrm0hBBDdTUcg8GmVJ74dc/nupfeSwtzh+xDWvMyBEYFk01c2rfTUKwLw5opZY
         cbXy8IHOTpSQUz7vsi7WL6Z6VEngj7Yo0U0/EWEQ2Sb5QskZ8H3t0+kqIKaQozt5kWOt
         +eDhG0jd1CPHODJIVxprXJjvhIm2u65LBIoM+LtPL6Aw4RmEIg5O2NFJ385DPS/pA/JN
         kF4mldbDuwGxCj2iCCwRJ9BHpDP7nAyWjt1xHxyuJwknBdiDec4hvlO7FV9x/NrT3crt
         qLoYN/aYZWHXKz3i09qIcoiWVFzpnp64Uheokf8l4UabYI5Canjp4gZZoHsup7f8E/kX
         CjaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779455775; x=1780060575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTSwoFAHbwK1zApsrzgPugaNKXvui0kw9dgms0Qvsq8=;
        b=QklRhXfH/0NoBQn5uF0R+Nz95NRkosjCXV3RmUaXBL0bvgqXAdYQUYWkj1Hy2mKgoZ
         jm4Q7cZXFPqoGvPAGqRLyuYS/cs8m6GYFgw+R0/Wk96+DlLaGgweCwiL2FDOXgWG9AaK
         cLr7YN4cQqrYHpiuvu2A3sJo1IKniYhtvnsVNh9PEsgN2bBhcoh3SPsbC7VqUmlzvNVe
         kMpJ5NKsxJ1SwaVdQWA3tdpN5ICm9OE1uBleeftRz6/IfAjOb3QweKROFJcj3amhgZL8
         s/sCSlyheXPK3uMVOhMiPiH5vFHMBQ/KLJH97x5ZLk8IKqvGW55QtL5UKPl0Q3Rm8AOa
         QJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779455776; x=1780060576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aTSwoFAHbwK1zApsrzgPugaNKXvui0kw9dgms0Qvsq8=;
        b=s3nCfZZaC4RHnE9gR/NDYRBEC1riJYrpYGd22mQvOccR3uRVxETr1R0q5GubEjMWki
         oksUmDZh5PNK/EWO7YCrhOWReJlxdGpJk2lM1ZfAh1cogw9S++0O4UBWBJKVJQ5FjOch
         BqKt5xzaZ+JGHTdmQ39s+VwCLNogAHVddxBSa9s02vW0pDsG2WDQr1DXZn9ribbsBpeL
         HbLNnyE/e+JLkArV/80oz6vwWgFSSoQWX3tgzChnpZ3TdZPQPsYfnOGMxwM8Rcpn+DFv
         sXXqF4scOr8nO2DK9Z3UTGmI+Lx1UOBB9bxSY3v7Mgggjq28EGEcgwYN1mqpg6XbKGuX
         3mmQ==
X-Forwarded-Encrypted: i=1; AFNElJ92VRwcwDMTPnXRQXcGaKTNtc0zpb4fpE/OB3IoMREA+1X9owulf8im4bW631Ng383w3Xwyl+9qUuK5YUiz@vger.kernel.org
X-Gm-Message-State: AOJu0YwakDb8fA4U9w199C9yfKidqCLYGKcyI1kOZRKzKVbVNZScYZuY
	DFGE6jkxCI0FvOKwb7XXh9PQwMqgiIhh3ORke8QqAuZ+Hhud1nTurEFWdtKjTIxomFLraQ0rwQY
	STtjOdPQPDMZe49JGGZpjggHCXZVAF8k=
X-Gm-Gg: Acq92OHIi7YOOricf/3pGjsoif5ISAe/3gfonuvbhXajasCwKKB+mZ+gCV57HbXyNYy
	vZyOGymiBzpcAD8uvTQrCmJ86XreeSroBlWL7IVPGKRU3Z/ajd8kzQTru//EeBovgufAqE2KmIW
	yaHarYg/8ywlU4i3vJrZecwplxi70OH4cPaf9+wHa+E4pjFTHzqgjp0erbcuiLYKD9yzdVjABvn
	GMvNiKDn/zEnp03bIohQTkgHl9rbNHCRYzcdi4gPUhyKch5AHhdF8TX5tqMv2/lj3b8JXv5CfWi
	aluVAEQ=
X-Received: by 2002:a05:690e:14c3:b0:654:53f3:8ceb with SMTP id
 956f58d0204a3-65ec98e0873mr2389177d50.4.1779455775172; Fri, 22 May 2026
 06:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522-t-fix-oob-v2-v1-0-0bea6582a361@gmail.com> <20260522-t-fix-oob-v2-v1-4-0bea6582a361@gmail.com>
In-Reply-To: <20260522-t-fix-oob-v2-v1-4-0bea6582a361@gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Fri, 22 May 2026 22:16:03 +0900
X-Gm-Features: AVHnY4IA6OB8H9iSKALCXj0bt_qXQ88WN-LfRLrXO4fVSNc7RlKxEkoNqdvJTr0
Message-ID: <CAMrLSE5RmLD0c7dgOmHRCRhhekV7U-2V_r0QgX2Q+MH0hy0SMA@mail.gmail.com>
Subject: Re: [PATCH 4/4] ntfs: add bounds check before accessing EA entries
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hyunchul.

 Since the new in-loop check makes the pre-loop guard a duplicate
condition, dropping it
would be cleaner:

  - ntfs_ea_lookup(): if (ea_buf_size < sizeof(struct ea_attr)) goto out;
  - ntfs_listxattr(): if (ea_info_qsize < sizeof(struct ea_attr)) {
err =3D -EIO; goto out; }

 On the first iteration offset =3D=3D 0, so the new check evaluates the
same condition and
returns the same value =E2=80=94 the pre-loop guard is now redundant. The O=
OB
read fix itself looks
good to me.

Thanks.
DaeMyung.

2026=EB=85=84 5=EC=9B=94 22=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 9:51, H=
yunchul Lee <hyc.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> in ntfs_ea_lookup and ntfs_listxattr, this verifies that there is enough
> space in the EA entry before accessing the next_entry_offset field of
> the EA entry.
>
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> ---
>  fs/ntfs/ea.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
> index c4a4a3e3e599..323caced77ea 100644
> --- a/fs/ntfs/ea.c
> +++ b/fs/ntfs/ea.c
> @@ -58,6 +58,9 @@ static int ntfs_ea_lookup(char *ea_buf, s64 ea_buf_size=
, const char *name,
>
>         offset =3D 0;
>         do {
> +               if (ea_buf_size - offset < sizeof(struct ea_attr))
> +                       break;
> +
>                 p_ea =3D (const struct ea_attr *)&ea_buf[offset];
>                 next =3D le32_to_cpu(p_ea->next_entry_offset);
>                 p_ea_size =3D next ? next : (ea_buf_size - offset);
> @@ -486,6 +489,11 @@ ssize_t ntfs_listxattr(struct dentry *dentry, char *=
buffer, size_t size)
>
>         offset =3D 0;
>         do {
> +               if (ea_info_qsize - offset < sizeof(struct ea_attr)) {
> +                       err =3D -EIO;
> +                       goto out;
> +               }
> +
>                 p_ea =3D (const struct ea_attr *)&ea_buf[offset];
>                 next =3D le32_to_cpu(p_ea->next_entry_offset);
>                 ea_size =3D next ? next : (ea_info_qsize - offset);
>
> --
> 2.43.0
>
>
