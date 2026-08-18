Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9903A873A
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 07:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787039192; cv=pass; b=VKj6Gb/Eo2QtNoYGB3qNjWRaApRP7Jsl2zFjHXOTaADMFNWKyz7y1ruhbs2rU5Xg6YUp1O9Iv0XYnvVMDr+AACoWlg0TKvSBetwFDx78mBjTrokdjSiavDD4/GRhR/XVV8g0umA4TfmDkSjG/e2Hvm86mnJJa3ckKNDrlZoVLvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787039192; c=relaxed/simple;
	bh=Iyw6y8GgBXDjN9CuEQFxNiglFvZTaCRhTltRhy4bz0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pyau8DmA2PGZbyQCTPpp+6oclezBnooj1a6fuQYXKmTI9ukrd/GZdXTxzgrAvAnKiIJS2qpALw/DL+OHh2CISVwYT5E1fI5rMKhj19gMNzt+u5yLQmegZ+B3+29iVfi3Xqf3Z0DukV27s3ZuMzC66Od/FfWXiFx+Os1pYuDled4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dy6UyCD8; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy6UyCD8"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b0f19bea2fso4249117e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2026 00:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787039184; cv=none;
        d=google.com; s=arc-20260327;
        b=MIz9JkT0SeSJahKfbYSVYm1liawywK4bdjy7clc4o2KJRIeHv31TFqkfyUaHYRWFRk
         FLxxSZdcXukX1ygxEQnIMBdiIHp/fwDuMDi48bld2nsTWnaNnL96gI/Gkpw59Non6Wfh
         w9rFR4wC6L8OeY8l9YdCmTfb7xfGPRlgj+E/V4gYsxp791LA6Ac1ECLOArJDLu3Yx23f
         PZag06pVuuZfiGUAJ892amhn7rRyWFmx/skokmaomQHEfR3GpU9ep+2FUsHILG1MrBEJ
         HNCXaAXDiVRMM4I4yeLGHjkYyUHlvnxRUgo0RX+Uo/l8VtbvpOu5lF/02Dt0Q9dRM74U
         n0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EiS90L7vK+7I2/yv75rMDbimmlLQanheBZK4XWNWWxs=;
        fh=/UAWdCRZ0Kj2WwSgir8vhRQr7DXffCTFh5ATzAZOM7U=;
        b=fnYMQJ3+Da0C4G3DAdaGTeCdWPNa4XxWn7nLbVqXtkkv13loekJqV3PJ30nmF0uXAi
         pBEnhcZwVIlcWBw5x9zDhhxZZ0LZuDsOnr6THgtIwXTK2m6mlQGPpSeSXQpfWIMdm71U
         VZAVxGLdgyki7rl9yCUSMAQf6DrmDW3Tl/0o9+Zq5lNAWgB9RXWLDte6Fu94tfc83WD7
         CJSm/12wEpYOKW671mhSsWZorcA+48+5k+SjRkO/3ynwEpegL41bOJX9kOns0M8Xd68B
         7ytsuw23vDDmVilebIJ5u4zzBWEeTQGDU3zzfpSCXAs6fWvVh0mHuZD56CigV41BscQx
         Okyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787039184; x=1787643984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EiS90L7vK+7I2/yv75rMDbimmlLQanheBZK4XWNWWxs=;
        b=Dy6UyCD8S3gVTvmy3teQWKLOzy/2KEA5ZrewwP2HvW9+xDc7HlSyU4VV/6FrkxBZPB
         PyqM0Ugq5LOdtGsRBgNhbzSKMv1QIArfk8Dm3m/OoR2oRYAZlge/sUndF49GTiGXxWTE
         yXRwOwMZOhPBg7VLG2kTWrxDa2coH+SF+zodsnx4rt15nmDyLHWhSPiTcDgGDYHRrdpr
         K7iPOcuWPFwZUHtkEVGLwxEQWd9v1tyxyqxNcHTi4lwHY3eqb3893Y7EPlJUpm8pZKxu
         1CIoVXwQks/Sr0mAoyjujof7TKqIIt4ZL+JP6oL0M63MiThf34ZSEhLAUZ2SR6jPNoFG
         VoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787039184; x=1787643984;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EiS90L7vK+7I2/yv75rMDbimmlLQanheBZK4XWNWWxs=;
        b=fXcxLLvdLuvNL7R1L6vjr1YZ/QOgUil7PshJR5JnGV12qyAcAW1AWKnbgfcjJwDDv6
         1FdrUWTnEPLcMEu1NTMoFVBVawPmjmmrQxyZuEPyznN4cpqhsZzB98z7S0r4ZKlXw6vP
         N4DEEhlkOUlW/A25IJQjvhUchm7uu3vmrzvIp1WPlI0UYkkuM/kvCmIubZ3/pLecf/ts
         9LoeoaB/7exnmIvdLME6T2VOfDoNtiOIZANXSGRIDCqie7eteRHx1rTcgAgyd9UGTgsh
         p751Ob0fFZCvD5boQlcMo5oaSZ4PlOcmmcUEHiOzfwHP+2Og1gyy8p1xquGqDq7TSTnw
         Iskw==
X-Forwarded-Encrypted: i=1; AHgh+RpIiWaXZog2fehe8oSyYeEfW2FJlqlHCGl7jX1++gSoLw85+xIzCdaHt/rUEnrEeiv85nZlky+7LpjeBrI8@vger.kernel.org
X-Gm-Message-State: AOJu0YyoMc3dGbgVJMndki3jz4jGH9It5xkte5/b1PUk1hVHQOxpH5F3
	9mx8Edu67LmFYhySmLulD3UjCpopC1d15qUu9QRRfZvYDrBA0lrx8qu/sHhMpxabD7i0DiUaKmj
	EF4fDI//P2ov+rRU+gBwdUub79E8t/HU=
X-Gm-Gg: AR+sD13GQ8R1Jx9JzM4/VaAvCbwz8pJOVjfpRZqTGx0XIi9TqLbyi8AMEFOl3k2OrlM
	24QOm9I5DuDpIzGHQUu3CCvpOSNb+KDQ6xzjWSEhu1nrI3iEdqzJT5ttYqmlw2FshHj83DID1qu
	SFNl28KbZ4gjqsFqpEl/soJTz0qIFuCSfoUFsVN8N0fIGDwfKV6Tt0GCUFg6PKrGKAWJhvVc9wF
	x8yU4zPDCSMx6vUb/c+oxyM8E6AswoU6qHuMUaboJLQ8lBCKx80+LlTsqiBlYB/86/FZBSIo6lD
	sqsAZqO+RKCftRx0rV2tPlX0Iss/zBkNgKOrt5Z+JpTJ
X-Received: by 2002:a05:6512:a92:b0:5b0:c96:cc8c with SMTP id
 2adb3069b0e04-5b45915bd7fmr4975289e87.12.1787039183729; Tue, 18 Aug 2026
 00:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <49b4a00a-351b-4eae-8466-feadb1851156@gmail.com>
In-Reply-To: <49b4a00a-351b-4eae-8466-feadb1851156@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Tue, 18 Aug 2026 16:46:12 +0900
X-Gm-Features: AcwNN1XMihYWo1KnHTXUWGkqtl0LW-bqqkFJ-zkHFXgu3otCcfllx8EwrDhpw0w
Message-ID: <CANFS6bb7QQy6jbhu6Ny5uHXg2YaJbzfxgbvaXAboL6JXagXRmA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: validate usa_ofs before preserving the update
 sequence number
To: Dennis Tighe <dennis.tighe@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 8=EC=9B=94 18=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 3:05, D=
ennis Tighe <dennis.tighe@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> When ntfs_mft_record_alloc() reuses a free mft record it reads the old
> update sequence number straight from the on-disk record:
>
>      usn =3D *(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs));
>
> Here m points into the raw $MFT page-cache folio, which still holds
> unvalidated, MST-protected bytes: the folio is read by a plain
> iomap_read_folio() and neither post_read_mst_fixup() nor
> ntfs_mft_record_check() has run on it (both work on private copies).
> m->usa_ofs is therefore an untrusted u16, and a corrupted record can put
> it past the end of the record so the two-byte read lands outside the
> folio.  Reading such a record while creating a file gives, under KASAN:
>
>    BUG: KASAN: use-after-free in ntfs_mft_record_alloc+...
>    Read of size 2 at addr ...
>     ntfs_mft_record_alloc -> __ntfs_create -> ntfs_create -> path_openat
>
> Only preserve the old update sequence number when usa_ofs is even and in
> range, mirroring the check ntfs_mft_record_check() already applies;
> otherwise leave usn zero, which the existing restore below skips.
>
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Dennis Tighe <dennis.tighe@gmail.com>
> ---
>
> Reached by creating a file on a mounted image whose $MFT holds a
> corrupted free record.  This seems like a fairly low-impact one, but
> given that
> it fires KASAN, it felt worth submitting a patch for.
>
> The KASAN error that I received on 7.1.7 is listed above. On a RW mount
> this is a
> one-shot per image and only trips KASAN when the next page happens to be
> poisoned.
>
> A reproducer is available if you'd like (just reach out privately).
>
> Found and fixed with AI assistance.
>
>   fs/ntfs/mft.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index fd20d7a..271a265 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -2333,7 +2333,17 @@ int ntfs_mft_record_alloc(struct ntfs_volume
> *vol, const int mode,
>            * wrong with the previous mft record.
>            */
>           seq_no =3D m->sequence_number;
> -        usn =3D *(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs));
> +        /*
> +         * The mft record still holds unvalidated, MST-protected on-disk
> +         * bytes, so m->usa_ofs is untrusted here.  Only preserve the ol=
d
> +         * update sequence number if that offset is in bounds; otherwise
> +         * leave usn zero so it is not restored below.
> +         */

Could you remove the above comment?
Also, as I mentioned in the previous mail,
I could not apply this patch.

> +        if (!(le16_to_cpu(m->usa_ofs) & 1) &&
> +            le16_to_cpu(m->usa_ofs) + sizeof(usn) <=3D vol->mft_record_s=
ize)
> +            usn =3D *(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs));
> +        else
> +            usn =3D 0;
>           err =3D ntfs_mft_record_layout(vol, bit, m);
>           if (unlikely(err)) {
>               ntfs_error(vol->sb, "Failed to layout allocated mft record
> 0x%llx.",
> --
> 2.47.3
>


--=20
Thanks,
Hyunchul
