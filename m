Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352E01DE4FB
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780413324; cv=pass; b=G8RY2Sq9bhqYORWgKVJGipebG5cYeVFVCmX8lBe4jbsZSM3iVkxlrRuvmgsHt0TZG308keTAAOZ21zL+53WNWPpY5LV/asvb1Alxn/eqRnyMRMVBN+6QUl/l2rYkLlv+fObZjWPMR9sZ2olpTgufP80EnTjr8p5QbYb6NjTKvQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780413324; c=relaxed/simple;
	bh=oZnTv2k6q+pmCPLrSNwfqDRcrYZCrauG50XeXoQaAho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNzNFx2fkSzE+AiK6I4MkF8/t5lXpWtoBO60p1q6W3NH3bRDqp7OE5xDIyrWNl56W1AzuRp+RW5qywDHIYhwqkUVRMHsRO6bMflv8GophYUjL95OYY5q3sws+cCM6OBvBS0x1NfuM2XEQ3jArVU4deTqYPAzvHA3ohom98clHHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rx5o+3Tn; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rx5o+3Tn"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa21fa024cso15728708e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 08:15:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780413321; cv=none;
        d=google.com; s=arc-20240605;
        b=Xo7vJcr/JOvNckvFk5WB4X7ZU0msWC1q9A99G5IydLc2DzamBMaFycq9gmcy+SE4Y7
         Srv+BBhfQX861x/QI7eYmIvzgEq6yxHaJbgd3KQHPqiISilNSQtPP5Nc3GuEJ4rQQXmU
         wiTCn/3VgPIMbc0I8wGpigZ2BmZ3QBepJjTiBLXbxlPU9GEumYwr77nvTEs45KYu+WUV
         zxh9eIvJ7asMh8C0voEHQvk4wV2C9CyXeNM7p6alrW//0NLFG8IhX4gKvr7jRYa4Db6p
         WiJVjgiUXqV7/5ILfJHSlHksgLWWRseVbyTatVba/oViwY6N80fg23IpgwwYppnSJ2Md
         Cf3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BqfgpGUFrkDshOLTS6AvSD8yLE8sec8JspbGjlAwCnk=;
        fh=jLPN9VoQasTu7+eMa/kjfBROMG5PfZGYk6e3UZCn52g=;
        b=Js2FQViXbHercQ8zEzvsQufaktBH6aLxijrow0RJg7JBC60XnxcuHnlAhz+SgOQfrZ
         jGXVbLubb6feJo3krVZhSmiAbItUl1uu2NyKIj3k305wgaQgVia/h29fy2p18umfxr7U
         mUIVRF2tMsU2yJGL4fWZ6n2JHrpSfaV95JTg/1fHN4oJBTc7Tpl/DWqO923JrqWmxk4K
         DGAOlfmTY2bA+vG3c5+PwL4bKvk8QSCCmjS83ZbeqHekR6Yg7z2EQ8w/YPIL0VtvKZVo
         XXT4pjtb34j1LKrF0mUgoxBYLJwrhFsXF6+1aTyHhBOifHL65dlS1wTgOQRv/XXyjb/I
         nVLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780413321; x=1781018121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqfgpGUFrkDshOLTS6AvSD8yLE8sec8JspbGjlAwCnk=;
        b=Rx5o+3Tn/Ip5AkA1eMkUX6gskxAK4mIDBMNFnbBDTPQpnuSfyss+tPI7YouRrtvV5j
         CWEzdXGKrHlpOg2aAMzcofjmCvIsOd5jlP5afeAmjZtGwcY0D45IVTry5Nngzj6cvExu
         NnS1REVtPUsyE7567q3DdA14uttXohLM1Pp2R036ob5eJjM3CsSRu4EY+p0XRWejBO7w
         ygUBUUx/bqVQ98IlmNI6J6LjAigGMdcBKwS6Wv9XP6MFf/R0hxPJwDPv/HHQ9GuFafDR
         zctsjOK2EC/mMWMPusK9RlF7MOSvWrtbxRISyKU7XOC6liJRg2ONpgVzTanTPxB0WG4j
         FdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780413321; x=1781018121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BqfgpGUFrkDshOLTS6AvSD8yLE8sec8JspbGjlAwCnk=;
        b=SQT5VaJZjRnxipwpP9pJWPfXMrsVnKIOx44R3DBWew7wPW+pyXWj/DHDrQfSpp4Hof
         +Jfi0qAn6aML/yncm5JalUaTNmsa6Wp1IMNKpULhDenxGAm5/uNSS+f6eBTFAmv/3P/3
         3WVXonOYJ9HDsRTm/8qTtvP9SGlCoMVy3h6ShpJFqndoemVQgxVrlTaKVemJOxLZPBdt
         GOSJMykVnQdvVQdOvbDneQw7INPkNCx9M6vFjCQVlJoRRYsrKuLD94HTUk0cI7dRynxq
         EnRtIMMcdqGPH011N7KHuJZV9RU8xYyTlziK3aG/IqDIeeODzaZ2WdoZ06ICxYYIGSTr
         vn/A==
X-Forwarded-Encrypted: i=1; AFNElJ/66E5EBZymNYDWWYalbpsJxcIGFk+icUon0MViDU4+0lPaNF5t7CUujL5VWQe72HOSxJOysYAm2e5aYGdS@vger.kernel.org
X-Gm-Message-State: AOJu0YzcRSCsYnncqBiwxzcwXsO2iWjZfn/UxzyituE6lEIqGcIyKlqy
	e34r1DQRGWfiWRNZFmiGGsIl3ZfarqzA/ToRszXzBJSHOGM1KiNA78ibg2fIa6zNNVBV53VOZfs
	+bb31OqC98/PviIxKz59AStsJfkBpt6c=
X-Gm-Gg: Acq92OGpF+kBHqWgHT9hqKBbpcLEFsCyeel4U6blDOAp/An3aI8kZz7HCa+iggoDjMd
	drtComHcNstksOwsH+QDWi/mnI6Ypz/kfYqDogCzPXcrfH7UwgFkNreQySVCKNZaq7rrBBJqavQ
	aAO9ZqUzQ2rj8BNZ9Gd8oeNAgKkGavtV2ZMuj2onEMIzFDRixVxvaLYmtEs/gFAssUG1sQrZZA/
	s9C4aqgga3ex3fB3wJgmQo2zwZkr3MscHm9z3bYlUk/U5QUpIbDVNVkozAeJLK51chINhTZjtQP
	INM+MIw/TXz6p9ZHkBU=
X-Received: by 2002:a05:6512:3044:b0:5aa:143e:77b7 with SMTP id
 2adb3069b0e04-5aa6091dbbcmr4175479e87.43.1780413321174; Tue, 02 Jun 2026
 08:15:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602050219.10227-1-hemparekh1596@gmail.com>
In-Reply-To: <20260602050219.10227-1-hemparekh1596@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Wed, 3 Jun 2026 00:15:09 +0900
X-Gm-Features: AVHnY4J4TjvM2X7Hjg5WI4YAyR6TyBLhDsY3eJngL_a2CcPuSU1L--IPP35OHaY
Message-ID: <CANFS6barxRqHQn2eVWyeSD=Ljwzs7VyxkhzMoYmkgpC1ZR++dg@mail.gmail.com>
Subject: Re: [PATCH] ntfs: validate index root entries_offset in ntfs_readdir()
To: Hem Parekh <hemparekh1596@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hem,

2026=EB=85=84 6=EC=9B=94 2=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 2:02, He=
m Parekh <hemparekh1596@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> ntfs_readdir() computes the first index-root entry directly from the
> on-disk entries_offset and dereferences next->flags without any bounds
> check. At inode-read time only index_length is validated against the
> attribute value; entries_offset is left unchecked. A crafted directory
> with a valid index_length but an out-of-range entries_offset therefore
> causes an out-of-bounds read, reachable via getdents64() on a mounted
> image (a read-only mount is sufficient), and can feed a bogus pointer
> into ntfs_index_walk_down().
>
> The sibling read paths already guard this: ntfs_lookup() bounds-checks
> each entry before dereferencing, and ntfs_index_block_inconsistent()
> rejects entries_offset < sizeof(index_header) for index blocks. Apply
> the equivalent check to the index-root path in ntfs_readdir().
>
> Found by code inspection; not yet reproduced at runtime under KASAN.
>
> Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
> Signed-off-by: Hem Parekh <hemparekh1596@gmail.com>
> ---
>  fs/ntfs/dir.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
> index 20f5c7074b..496e7e5966 100644
> --- a/fs/ntfs/dir.c
> +++ b/fs/ntfs/dir.c
> @@ -759,6 +759,7 @@ static int ntfs_readdir(struct file *file, struct dir=
_context *actor)
>         u8 *name;
>         struct index_root *ir;
>         struct index_entry *next =3D NULL;
> +       u8 *index_end;
>         struct ntfs_file_private *private =3D NULL;
>         int err =3D 0;
>         loff_t ie_pos =3D 2; /* initialize it with dot and dotdot size */
> @@ -893,9 +894,22 @@ static int ntfs_readdir(struct file *file, struct di=
r_context *actor)
>         else
>                 ictx->vcn_size_bits =3D NTFS_BLOCK_SIZE_BITS;
>
> -       /* The first index entry. */
> +       /*
> +        * entries_offset comes straight from the on-disk index root and =
is
> +        * not otherwise validated on this path (only index_length is che=
cked
> +        * at inode-read time).  Bound the first entry before dereferenci=
ng it,
> +        * mirroring ntfs_lookup() and ntfs_index_block_inconsistent().
> +        */
> +       index_end =3D (u8 *)&ir->index + le32_to_cpu(ir->index.index_leng=
th);
>         next =3D (struct index_entry *)((u8 *)&ir->index +
>                         le32_to_cpu(ir->index.entries_offset));
> +       if (le32_to_cpu(ir->index.entries_offset) < sizeof(struct index_h=
eader) ||
> +           (u8 *)next + sizeof(struct index_entry_header) > index_end) {
> +               ntfs_error(sb, "Corrupt index root entries_offset in inod=
e %llu",
> +                               ndir->mft_no);
> +               err =3D -EIO;
> +               goto out;
> +       }

There is a patch which validates the same thing.
https://lore.kernel.org/all/20260530143514.3083601-7-charsyam@gmail.com/

>
>         if (next->flags & INDEX_ENTRY_NODE) {
>                 ictx->ia_ni =3D ntfs_ia_open(ictx, ictx->idx_ni);
> --
> 2.34.1
>


--=20
Thanks,
Hyunchul
