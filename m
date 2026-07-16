Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DE33BFAEA
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784240788; cv=pass; b=RSEjRuTG7lKD8YDtvRAKx1GkPaVHrwB++vOwXOiusCggOaLoPvKtifXlgvuTpDkL6eJH5RnLRnwnSOyN2t9sm44ySyQUvftLGdOC+W7Px6EQE/fUbBu9VscqOshw+m7kWGnMM+AzWsa2iv6eupv+ncY4J84NIYWPliY0NoBX5DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784240788; c=relaxed/simple;
	bh=NbAF+ugPNPrv2W5iMy7iKfqjo/Rxt2EpPULg2ghKD70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s8Anbtz3f3AJrOMVHT9SonSMD+VwDIo9kJWu8fgah7zOxxH6JqQGniif7QALYLtVeQ1gIav3kF5pFgTSK6R9u8SEnAkw/fq6iRFQFvxQlWc9f6EwbV8A2ACw1tjuHSzOP/kbN6aIEFfKfbpuSmmz18N1OCSYAq8GrbmUR8R9/uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/yVU7nI; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/yVU7nI"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5b013aa02b2so856896e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 15:26:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784240785; cv=none;
        d=google.com; s=arc-20260327;
        b=hAZfWJ+ajf6HZUnPJurMlW+k8OWr/CHhWy4djyeBdnb/J8+XDcGCJBQ91zAtfCwu6D
         ov3cLkfQqlWlCdn7jk6WlbP7Eu7a7U93GL/a0F6T3zIEwOlAJZlsO4gHcpfeQsATiLSf
         ix26pZzL/epK6RYq8ralvlCMc+8QdByOfXGeNx9bMOovjOGKLC7iiSMJNTb2NxuGtjMo
         17ZdjhMQ3q0W6fGqLaq9p91WmokZkTxsgvoe8HSQ45tY4lvlxESz692UjIKst1wdiAhW
         YyTvoNDs7yjYS/E13r83wBpNVkvK9ZKn+5VgQ/DCMTYxVMS2dxP7ycsYFebm2wgNEWo2
         Zr1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cqmQWaXE3DdDxs1rhJWy0b1hUegH/J+k8O5Dv43azUk=;
        fh=aeFkgB2j+mnUxqyUejnb9U5XF7T2tBqA3C2w51WXiGo=;
        b=T3yFGKK0IQ6xo0JcZCzKEqHtZK7dIG53sAWoUBG+LcgTjpy337d36mvG9h6yOcsy9d
         G/OmdwMVvZpPWCMFz4zY+j63eWKg0LkVSGZUt7nSQOllaVkb51kcF6w2ue8KDx1Ecv0W
         TKuLKirEH7MSNqPWgUC53hU6dOH2M/QZOIcPkoajTRbwzNC5fdSwJlsaKD3l7C7Ox9hA
         yqPyS+F7y9sJeynMHDu1sbPIYMM9ZDQM0rvtNExatehp8MQwS/33VT9g1QBSYi0B2j+E
         tgNfZB/zRoHGXMjjd3EQZm5CnN5AIsj28t/JUId1p7kwEg8gKVDoHWPSK6h2E2MJZyfb
         ps/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784240785; x=1784845585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cqmQWaXE3DdDxs1rhJWy0b1hUegH/J+k8O5Dv43azUk=;
        b=k/yVU7nIPi4zYd4TTC2AYD64fpBKKXuXgvQzcfTnVH8yZMCnYQjHPJw4RWtO/CUgJ4
         K0lze6Rvx66INkoBNzj8badi7qmb9px8PYUwN1KVF1rmZZKBJO06v8OaZkXUPCRut+Ul
         fR9aGiMZVgox/I4WTRoWVMCsUjCRgRpkUw160DPzfneOdiyVWSj6le2Wat/G38oXGzj5
         LJHT8GztWP9EPW+9bOlp+HPO+7xtycAoznVp2TK91aXMisGAW9KQ26zYR4BfU7mO2Crl
         36lsRZsXiCx4gqBwCZYAZDLDx7sh/8S5fw7aYpDsHc80LqRHV5qcsE1cfrhZ43MrL0Vw
         uwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784240785; x=1784845585;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cqmQWaXE3DdDxs1rhJWy0b1hUegH/J+k8O5Dv43azUk=;
        b=dh57hbC+mZKqZBno25nlKqkcnBUjTtq5x9b2dMj4OTndyC1WaLacI9A77+XSGM1QBA
         AeleF+fNQNa0R61dbsf/vaAqZI6o8qDcBtxuVRq1rKGPsC3sgfzn4E5h2ER5aXkvF+Od
         cFpuvarD6ENixwt/tpMhx/Na5O/TQA6mtRSc8rhBhVz4M+YAZR+OL3Hu4FfDpT3Iotcm
         adtwot1yxWvdphUaL+ew5klQ3JKx1YFONVKS02dUM65aJOFTtAl5IbiReFY8zvBLTBY7
         rDF/+iRgmXTKmOXW9BOsRiorf3lkjlFSpmcQ0kA+53Lqs1p4dHa32N5TPeYDjeteVrIT
         6jqw==
X-Forwarded-Encrypted: i=1; AHgh+Rq3Orfg+/Es/fwvdFOKCkEOFm3jFaYd7V8adnUUVdFu5Exer11pNayE9bngz2V1etbMV7s8lJSXfz3LNgE+@vger.kernel.org
X-Gm-Message-State: AOJu0YxtdpA9JJKuBqSqJnXkRbe4EZQwC447768Ghg6JEypbtI+4LF7u
	hUqspQflZTxCZ98SbilsAwjushKCvIBuoX4jASEpI2Ik5cRhKdqGIkz2AYbUJYViPSOnqpO/9lf
	x5yOw9FKIIyNuIALgA4NSoA2UNxhKa7U=
X-Gm-Gg: AfdE7cloWdt21NuJ5qBWHA3d31QpvgxKzbRJHP9LYJl08+t1HJ8THzs1Tjz8J9UHHwi
	VfZmmB+epf9Udbj2GxWPSonZWipUPf6EJKEJVH2jPyrgpcwUUum8FFQiDIJp53ycrS/SSosJYSx
	rOdVjmrLs6ApGAPEEEgeLwt6A0IWsVa3uTLRJdNJHurU5Q697t31Y49bmrzB9Y7V192IT11d7pa
	WrFCHvnaQemtmcIMn5N+BX37HvbMFpOi9lEzuAGAiqgupn0Y5WdwlxzP7qpwQM=
X-Received: by 2002:a05:6512:3d22:b0:5ae:c542:3416 with SMTP id
 2adb3069b0e04-5b28fe214admr4597e87.0.1784240784864; Thu, 16 Jul 2026 15:26:24
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716024640.13396-1-linkinjeon@kernel.org>
In-Reply-To: <20260716024640.13396-1-linkinjeon@kernel.org>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 17 Jul 2026 07:26:13 +0900
X-Gm-Features: AUfX_myh6ejj2KN6f5hvYQZhdAxIrN_1znb5dOyW_QTT8N99EVX3PcgWlRddpZ4
Message-ID: <CANFS6baPdhk9yVyOJtH03eMmeBZ9vQsC7DmsE5i0XHpZqx5UqA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: validate final EA attribute size
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 16=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 11:47, =
Namjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> A replacement first removes the existing EA record, then adds the
> replacement. Check the size of that final $EA stream before mutating
> the current stream.
>
> This avoids committing the shortened $EA stream or $EA_INFORMATION before
> discovering that the replacement exceeds the AttrDef size limit.
>
> Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>


> ---
>  fs/ntfs/ea.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
> index 0cd192752b7c..0eba3f41c7bb 100644
> --- a/fs/ntfs/ea.c
> +++ b/fs/ntfs/ea.c
> @@ -250,6 +250,14 @@ static int ntfs_set_ea(struct inode *inode, const ch=
ar *name, size_t name_len,
>                         goto out;
>                 }
>
> +               /* Check the final $EA size before removing the old entry=
. */
> +               if (val_size &&
> +                   ntfs_attr_size_bounds_check(ni->vol, AT_EA,
> +                                       ea_info_qsize - ea_size + new_ea_=
size)) {
> +                       err =3D -EFBIG;
> +                       goto out;
> +               }
> +
>                 p_ea =3D (struct ea_attr *)(ea_buf + ea_off);
>
>                 if (val_size &&
> @@ -285,6 +293,12 @@ static int ntfs_set_ea(struct inode *inode, const ch=
ar *name, size_t name_len,
>                         err =3D -ENODATA;
>                         goto out;
>                 }
> +
> +               if (ntfs_attr_size_bounds_check(ni->vol, AT_EA,
> +                                       ea_info_qsize + new_ea_size)) {
> +                       err =3D -EFBIG;
> +                       goto out;
> +               }
>         }
>         kvfree(ea_buf);
>
> @@ -312,8 +326,7 @@ static int ntfs_set_ea(struct inode *inode, const cha=
r *name, size_t name_len,
>         p_ea_info->ea_length =3D cpu_to_le16(ea_packed);
>         p_ea_info->ea_query_length =3D cpu_to_le32(ea_info_qsize + new_ea=
_size);
>
> -       if (ea_packed > 0xffff ||
> -           ntfs_attr_size_bounds_check(ni->vol, AT_EA, new_ea_size)) {
> +       if (ea_packed > 0xffff) {
>                 err =3D -EFBIG;
>                 goto out;
>         }
> --
> 2.25.1
>


--
Thanks,
Hyunchul
