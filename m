Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EE4283FDD
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780962990; cv=pass; b=lGT5wNpeNV6sry0xrKBhoOkbvNBQd8YR0zLSLsfOEi+XZjeS1mchSIOx0I5onQGukbBWHfo+ycG+/OM4sOB7Tycfv4IeFtL71OagdaEGWduwvPl2NrGgAQPuxaWWPKaeH26wknuKrxrAITdsIVpPoViuGzOzGtbS/qm5tivs+kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780962990; c=relaxed/simple;
	bh=pCJQPM6Z3jSNFUm2VZf0AQQhHTRdW7bLx9AdNaalDjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r43qetVv8EnhJkX+7WIgIb6LPR3Kh3nsL1XCTs5AWRxlkfZmJyUxxlNYK76yfWvJqimWvywskQlY3AE7xOF+tnu+Ov6MZAJV6rnts+HyziMZ7DpeArvykr1VLK0sgIHDqEx3+eO8gccW6qBnpclq+XfnZaYXUgkN65CxCxPEPUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcODLJ4n; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcODLJ4n"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-396779b9a7fso41101201fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 16:56:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780962986; cv=none;
        d=google.com; s=arc-20240605;
        b=Rzog1XBAUvBC+VAyfrk2Wdh+c/OALqdhBr6gNeBXKIk0+PjsM+EFcm2eZM4LE276Mv
         lZ3KAPgW3a54BNPH8ULIZc3psQzUOTW50sR2snxhx9Qbm7Tyy0uUzK4SrFJGhLe+iC8+
         VZhAHYTe4602TryfJiKX0VQ2m0ww3pM+uIC+St4BUAAsFeBMNB1lMEx6HKVdBuRx69Ze
         giv1eqswtdz5UTGEdjNcR+Y3P08G7RM4jyCBTp+HxR7+zQUY/EXqEiGj5h9Cm2+xOjJd
         nKjvoOVQNLVDJBapBGWWt0SleJlxOj6CFQq+UsVa4pJMpJBFOojcUItF96ZgF4Y97bDX
         ItKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e1L+DCYV3sJ/CVVZZLPcy7NP9eE2AhDyBq3m7+98/sw=;
        fh=B2lfkTjkEdBmRtSGWbIEUTePFolqii7JWBYhFBn8InE=;
        b=RwwH4IdOiPGYpjzgaEoWoj0JTSr/6t2cup7kYKOrCnFrPNSZkgSOXaQb6ORvcdGgZC
         ndA1o0HWPsJNArT+nZ9Y8DX+u49ybinZFQxctTSgwsHOt3ZKXPffuk0wIf2x0Wufs7Vo
         XfiUG6bscZrjA/v1yUbRgvmaGlqU/6Xe3L1971j1QWko3YO9idyJ6yfCgpRU0H2xAeGb
         OKB6fiDFcimpUGNRHHhoke5xx8pT/zB8PekA4xr1BKnc3tDWFoLim1JbY/Vp5IIXHMv7
         DappBZh8dryw2WQ4mM6G/FCA2ELut22f7a8IwtypImkYxt3k9MMobnvdaro79SEuRK0m
         Tt1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780962986; x=1781567786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1L+DCYV3sJ/CVVZZLPcy7NP9eE2AhDyBq3m7+98/sw=;
        b=hcODLJ4no81cfvDzXcA1A/H7bjPflp4pn4o3Gh4RA4RGYx/PyW9l07cpNzkWS5yNzj
         GQEdQcO4WnjvbQL7Jn1dcnFIJcvmzPSlIGOCT3Ld7vkBc4q826Wdvk/9RI1RMg46sFZ6
         ns+bBxd0s2nqsLeSMjZz4qTmApGrWMWwNJ4rxkQLrSxY514VeWDicIn6ZeICDGu9C1Vq
         fedWR815eCQCzvlQtny8OewDsq9KPaOj7C4K5VYSzF9k+cGs6EmeMPLhvweCp5WOH1jX
         ntDOgRET90p+wXFOnu8ZDupAaVyYV16uLC7nZPyEmZQlTCAzxW3QufyL3WLe7HnIUwxW
         QTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780962986; x=1781567786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e1L+DCYV3sJ/CVVZZLPcy7NP9eE2AhDyBq3m7+98/sw=;
        b=od/a+hN+uomU1sIVFU7J7OkIPJOSEgRHHWyxsfCxOQL7ng7VyYq+JOj9+v3k7YetUM
         u7W5aCp8jV4BTW6jIr+q3O2LIQE0LAs9pN/hNXaZCt66rrAqqQ6mmAIehjRAvk/myVSM
         yxYNR23A1z9Af6QWMZOcjmW0qS6I/MIHZUxhWTvqivaIXUvV0qWMfIS+q8rEUPMUY5DD
         xtfFGtIMMu5mqA2rYlOeFzVkFOYIJVLDLS+/wqtOr6VPbQO6szVcTU1He6Ty2+JIlP6N
         ekVjIAcGBqRPQqtvhW5nISCRtWqcpPhbaxSDvpQK58TrusGWQbhMRcWyf3sTHNYeWIvH
         ihzg==
X-Forwarded-Encrypted: i=1; AFNElJ9xyLTpl+ZhF1e4UcCMgZ3pPcsZqp1R4Wp5y/luMJoMgBiubNDrL8ADOGL8C28LfxFEr/habcbauzLXc/+a@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp353XL51kPFddbKw4MpVSc2SUV8fn1GZtXpYhGMZ9LEJc+TBA
	zs2Vys+G87ef5WSBxJAHx8s/dCK/VlSn4+7Fdn9y/e+P3fc3tr8+QydD+fQalY0AdviTkpKYqoK
	noo9JnEm7r7PoIT5u8tRrVh/2a8kEImqaMg==
X-Gm-Gg: Acq92OHYZvkw2o5opORWuC0xZAFAcYC/O3awSq8jnF3Qqhe0p4saX66UiSquD5NQXGr
	OUKxjOgIX/Wq23+VT9FDX1NNgJHOyWNpm1CqVNAIG+8Ix3yOS6MP1qnKFY4idTKnFHKZ39g/1gF
	tKhQiUS6D/EA+vIulX2jGuvLu359A7kg7TNKsuMnZFwy7zuF0xlI88i/9L7klUZHt7oZnp7Uebx
	khhH06aA5NdJ0oqnjNLz95l+DJmAlTehgmKHkjKzLlm8K2Ew5xSfyaybQ64fD+deEttFBS8ATCY
	asi+UEY2h5YIqkmu8g==
X-Received: by 2002:a2e:b8c5:0:b0:396:72fe:2a33 with SMTP id
 38308e7fff4ca-396d0897bc6mr48724191fa.9.1780962986266; Mon, 08 Jun 2026
 16:56:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608154917.2703739-1-charsyam@gmail.com> <20260608154917.2703739-2-charsyam@gmail.com>
In-Reply-To: <20260608154917.2703739-2-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Tue, 9 Jun 2026 08:56:14 +0900
X-Gm-Features: AVVi8CdKNt2zwsmRnEoWAp-YkDRctt394KZTFzSWCcjPtQ_7-eFoyquFb0BMoI8
Message-ID: <CANFS6banysDYOTLBYWQ5-uj39uhAKFb19NMk0unhHbCoy7VG4A@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] ntfs: reject non-resident records for
 resident-only attributes
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 12:49, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The shared lookup-time attribute validator rejects non-resident
> $FILE_NAME and $VOLUME_NAME records because their formats require
> resident values and callers handle returned records as resident
> attributes. Other resident-only attribute types still pass through the
> generic non-resident mapping-pairs checks.
>
> That leaves real resident/non-resident union confusion paths. Inode load
> looks up $STANDARD_INFORMATION and then reads data.resident.value_offset
> without checking a->non_resident. ntfs_inode_sync_standard_information()
> does the same when updating the standard information value.
> ntfs_write_volume_flags() also looks up $VOLUME_INFORMATION and reads
> data.resident.value_offset directly. $INDEX_ROOT callers in dir.c and
> index.c depend on the same lookup contract before consuming the resident
> index root value.
>
> Reject non-resident records for all resident-only attribute types in the
> shared validator. Keep the existing $FILE_NAME and $VOLUME_NAME behavior,
> but factor it through a helper and extend it to
> $STANDARD_INFORMATION, $OBJECT_ID, $VOLUME_INFORMATION, $INDEX_ROOT, and
> $EA_INFORMATION. For $OBJECT_ID and $EA_INFORMATION this is contract
> hardening for resident-only formats; this patch only rejects the
> non-resident form and does not add new resident value validation for
> those types.
>
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/attrib.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 5e1ad1cd0118..1254fbe7666e 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -596,6 +596,22 @@ static u32 ntfs_resident_attr_min_value_length(const=
 __le32 type)
>         }
>  }
>
> +static bool ntfs_attr_type_is_resident_only(const __le32 type)
> +{
> +       switch (type) {
> +       case AT_STANDARD_INFORMATION:
> +       case AT_FILE_NAME:
> +       case AT_OBJECT_ID:
> +       case AT_VOLUME_NAME:
> +       case AT_VOLUME_INFORMATION:
> +       case AT_INDEX_ROOT:
> +       case AT_EA_INFORMATION:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  static bool ntfs_file_name_attr_value_is_valid(const u8 *value, const u3=
2 value_length)
>  {
>         const struct file_name_attr *fn;
> @@ -666,7 +682,7 @@ static bool ntfs_attr_value_is_valid(struct ntfs_volu=
me *vol,
>         u32 min_len;
>
>         if (a->non_resident) {
> -               if (a->type =3D=3D AT_FILE_NAME || a->type =3D=3D AT_VOLU=
ME_NAME)
> +               if (ntfs_attr_type_is_resident_only(a->type))
>                         goto corrupt;
>                 if (!ntfs_non_resident_attr_value_is_valid(a))
>                         goto corrupt;
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
