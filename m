Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041FB18A93F
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778200273; cv=pass; b=Uf3+ZDZ0O1XbG5CsDI/lZACLUcHN8/N/GOyzeQ5WCPIp8Aqh7+kmB9sc6IoVCLcRZ5WwnQ3oSU3GdhSrjLDpbTA5l2CSWT61A3wtf+TazLMB/tjzUSbloLhPM2mboUpAPFuzaf9M0G0h+TTGAP8ByhmBr4tUyM++d5Uyll1VZFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778200273; c=relaxed/simple;
	bh=LlL1/ro7S8nL5c/p8mN3lHQAaNc5BiPpVpkpRj32Tls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhPUCQs23pT5PslstxpbRaCjRmVq6L1kCkpfcaGuuGOQeiI++9aUlr+eIYT5cEWMPgFFNaJNkU+a4BDifmppsllM6to/I/9eM3CiXGMMWLZpeVz6Tqsu1KFxPOUrB0WJds9MwLl4i8YJtdFjrqKKTEN7J0LjlCjanYiPaAZo3Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nu9vwGdH; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu9vwGdH"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a88db610ccso1606413e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 17:31:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778200270; cv=none;
        d=google.com; s=arc-20240605;
        b=Sndfmgzyu6Uf3RGS4PHQKvjNqizD8pC/NvSGNgwDikuljXwmL6SxobcMUcWO/W+8JQ
         R59J+6VWD31krEPuK+uT42vB/PdKb2S+xjn7fMhOLYhDr1Tvl8xg3VDYqrZdRCujkG8L
         qMKvu6+rbZZ/JbED0vdM57ILOpBjvKJE0tzTHaWmTmYCHakesuyqO5W1R/lhnIcyIbMU
         OlpgXHwj14E2zyZIZcPHytDYndcjkK3EeUuFrqgCFqwovnKugsgUlLNlpQ/5FxeUM433
         fFTRLPiLkqD9e2aZOMEPZxcgxbQbYa6NClfKJ3K1sdajTk8O9G+3RG31ohMDi9XfiRBt
         nS6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+EKyRuLv//x0zo8B+W43mYmFlm4jovWH8O/Ncaf2dos=;
        fh=xei5GGG5/lTLtw99aIE2mZ1od39UG0KuChtaSuaegmo=;
        b=BgJZRpNsqawRJLmeyq70D3VLhgtqkCFo4wiO4PXwjThMJjyFk2ljHLlon2zhO2XFq6
         Vhc3tCEHOtDfQXWmVcTIJUhojUPLB41J4qA/m/pqYw+8C7+0Hmv6fVDQ4/cHinKOgFor
         e70C0CKmtKhRFTu+O1pkTc5Hjwinx2OXirA5+xFXxUkzfxfuUd0nxXA2eoroTDDGyaaa
         3j6RkktWxprAEl3s3XHpzX36MNLQclLAcHZysmYVGDWkudTaLN7tl0TA7x7E9ziqRhF3
         Qo7yGXwuLqTg6+YDuNFttDT9YF06ZBaqwzQtsKf6Nytof+S8M3CwPeUqvV8Xu1B4Pi3a
         cmdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778200270; x=1778805070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+EKyRuLv//x0zo8B+W43mYmFlm4jovWH8O/Ncaf2dos=;
        b=Nu9vwGdHG/SPSkwNx0HBk+a8Po7dtI1xneaZixPNgK6sK+yDZ7A339WmGCLNxOsKek
         xbkTGmDUoXpAkOJ/enkTBS7bFX+U85qAXCIFgHlanIXfF6L67gGVal+0ymCmlerJsnE0
         sFCWXugCeejqvN9YUyubSMrrQ8JW1uR2IjDPYwDDLVoc411UOwUP/peRCBol3+OKv/xk
         DwbowFMC6KKCRgrX6k5hjU8z/A9d81AZwbFLUjdNDHkJQnVah5Sg5LKWSEz+f7OkAZMa
         ImwXrb5qMhcdkZxjz9wqPnk2sxqDlWvjD+axxODBlKnNsq/XgfB1cV7XCC1DEJM3ifkh
         6RGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778200270; x=1778805070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+EKyRuLv//x0zo8B+W43mYmFlm4jovWH8O/Ncaf2dos=;
        b=Yu4b0bBSBZBEK78A0zu1BU0BjO3KIamwBKEfPFVDsWE57/3EVG+vlmzDZOt1QccpxP
         WEaJJVB6oiNJeCCGKQ/A9VWNwcL+yeYHVn0ZkBQveKrit71RvzwZm4kkHcvCQv8YHYGb
         gXPpc51BiLVehtYBiT5jcAPbxTVyj34gAA2a6H2Z9SbHMULYjh+nc8NymestF36C7HvP
         Urfr0sZ/ZsuC+AQrJn4l21Q8lUM1Gz3nsIx6CbtBGHajn9c+DTLEcsaM/FGf7L46F4jz
         1xftzKohsqhlO5R7WBlF6qnTAPotO3rRs9l3QL8akL1myBqY6ds1T45nzH75W7WYo+mL
         WYiA==
X-Forwarded-Encrypted: i=1; AFNElJ88W/qRoux5eA71d4nhNMMWtrTA1NfWveNtCnXBvaBmUbsB3AjH2ylvht70ePksWpRTnWnUSDMZONtDgjdR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0X1sJ7fZA7hfIlRFkTylCrs4vJ7NLdnw7sy+jhdlmcLNOFFG+
	swedRVnxUdu19DZBJhophdPMvSgcir1Rnw9DECSedsce3V7U31qb9yzXS7SZiUM5S5PvXP4bmHf
	GXo3MWSLkDKm86lBU3UBvOap0YfoC6J4=
X-Gm-Gg: AeBDietq09iohUmfuIQAyIm7Hlptt4CH9OrkFrnaM7praApkooEfROuy6sK3TpvA+8U
	M9Yn0UT7NeS5Yy87lGnnhBTv4LvPXBQfr13Sk17Zmm3WjMgB0FCSBYeFFd6IvQlbvChXfhlZ2jI
	DcYeYK4/j1IVQl8q9QKEJN6ViKHg1isPBuN2vM2/lu0ZHs05iTNUpJGJLyZ+akyu+iGwCaTiYTk
	T5P6zirbeQ4bswFznlUqEFxHZalnidFvannh8ESjdd1ZY+3y0LZM4f0vjuugI2VNFICcR9sOfUW
	fANMZpU=
X-Received: by 2002:a05:6512:318b:b0:5a8:8de0:4576 with SMTP id
 2adb3069b0e04-5a88de0467fmr2731429e87.25.1778200269880; Thu, 07 May 2026
 17:31:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507154852.1721710-1-charsyam@gmail.com>
In-Reply-To: <20260507154852.1721710-1-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 8 May 2026 09:30:58 +0900
X-Gm-Features: AVHnY4KnZp9XRWawHb7b6nF-0wisPHXUNyBazJFK7uBClS30pO_0L7nwxZilLMI
Message-ID: <CANFS6bZph882haUk6t17PxaKSv5HzhZHxn9Jpy0An91g8KODzQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: avoid leaking uninitialised bytes in new security descriptors
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 8=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 12:48, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> ntfs_sd_add_everyone() builds the on-disk security descriptor for a
> newly created file by kmalloc()'ing a buffer and then partially
> filling it in:
>
>         sd =3D kmalloc(sd_len, GFP_NOFS);
>         ...
>         sd->revision =3D 1;
>         sd->control =3D SE_DACL_PRESENT | SE_SELF_RELATIVE;
>         ...
>
> The buffer is then handed to ntfs_attr_add() and persisted as the
> SECURITY_DESCRIPTOR attribute of the new MFT record.  The descriptor
> covers a relative security descriptor header, two SIDs (owner and
> group), an ACL header, and a single ACE, but several fields inside
> those structures are never written before the buffer is committed
> to disk:
>
>   - struct security_descriptor_relative
>         @alignment              (1 byte)
>         @sacl                   (4 bytes; SE_SACL_PRESENT is not set
>                                  but the offset still reaches disk)
>
>   - struct ntfs_sid (3 instances: owner, group, ACE.sid)
>         identifier_authority.value[0..4] (5 bytes per SID, 15 total
>                                           - only value[5] is set)
>
>   - struct ntfs_acl
>         @alignment1             (1 byte)
>         @alignment2             (2 bytes)
>
> That is 23 bytes of uninitialised slab memory persisted to disk for
> every new file or directory the legacy ntfs driver creates.  The
> "+ 4" trailing accounting in sd_len holds ace->sid.sub_authority[0],
> which the existing code does explicitly write to zero, so it is
> not part of the leak.
>
> Anything later able to read the SECURITY_DESCRIPTOR attribute - the
> same NTFS volume mounted on Windows or by another NTFS reader, an
> offline forensics tool, an unprivileged user that ends up with read
> access to the volume - can recover those bytes.  The leak persists
> for the lifetime of the file on disk, not just the lifetime of the
> kernel that wrote it.
>
> Switch the allocation to kzalloc() so every byte the on-disk
> descriptor covers is zero before the explicit initialisations run.
> While there, replace the bare "return -1" allocation-failure path
> with a proper -ENOMEM so the error reaches userspace as a meaningful
> errno instead of an unrelated -EPERM.
>
> Found by inspection while auditing fs/ntfs new-inode paths.
>
> Fixes: af0db57d4293 ("ntfs: update inode operations")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/namei.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index dc786270afe5..aad928ebb7bd 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -355,9 +355,9 @@ static int ntfs_sd_add_everyone(struct ntfs_inode *ni=
)
>         sd_len =3D sizeof(struct security_descriptor_relative) + 2 *
>                 (sizeof(struct ntfs_sid) + 8) + sizeof(struct ntfs_acl) +
>                 sizeof(struct ntfs_ace) + 4;
> -       sd =3D kmalloc(sd_len, GFP_NOFS);
> +       sd =3D kzalloc(sd_len, GFP_NOFS);
>         if (!sd)
> -               return -1;
> +               return -ENOMEM;
>
>         sd->revision =3D 1;
>         sd->control =3D SE_DACL_PRESENT | SE_SELF_RELATIVE;
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
