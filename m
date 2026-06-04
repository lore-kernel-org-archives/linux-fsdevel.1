Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B033F9296
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 08:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562512; cv=pass; b=G+wtpI0IrXOGIoKoZjTokMnz9i+MUhhwekFdRs97EsiqKFsANOjfHC7Ir6kciuiwH1xOHMZgiX0WhHnuVScqydlNggW4C4P1CjSsc7xcZN23aU4tz/UCenl02yKtjB3JXL5LeusCObCPLCiCIb8MC252w+bajtGKxe9de+ujg1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562512; c=relaxed/simple;
	bh=sKRiclSEhx5D5/EkW+K5RaUBmiFeugYQ4VM4zHB9vG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jY9ddoBP822Ks6nzQRigCNvv3Hoyif74A1nKta9D3ASLChyhZLkp9DPQSN5cYjXbc+tDacOBMaV3aGlVtFZLQrtbToG8cxi7ZoWf/zbK9A4ckkBXgx2M5PNcG9FB4uAbSn8/X6tieQZDcegIpapap8CZWb5KHkVRjNcs5nuDj4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r99INYDR; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r99INYDR"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa68d9dc18so420826e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 01:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780562503; cv=none;
        d=google.com; s=arc-20240605;
        b=HU3i67n5nHE30cK2RwKAx8VMRB/abEXu9OqqevcXsADLa8nb+Xhyga25k93m/hwMOa
         NVFSTgc0xRiKythT2arBgUMScT6U8+cbqus9ltH1Pn3U/Ytkj2KEMx2glR7DhV2zOzZf
         YY5+ke615x4VqGB5TCrBBB2zr3JU0WgC9t18FaPh/ysf112GGg1XOa6T1acIW1B6nNEB
         Echs3wKTrMCd/PVhzb5Qod2qkJdY/xNmeFJOgSp4LGMj3iRUtQ2/ZLBWCEJAdmkAA1Fj
         mQSKqitsHcIOMT/J6guzkc8pNu7HEoP4uO/Gp+JiEBK2rdo1SYzYkndB3Da0FzzM7X7y
         97cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u13QfsqknDff7yI+wqO7HoZmhYeSH58Qvn8yXLkgd7Q=;
        fh=kaC8hRN9SKI17NYxYxhVjK9Sn95SVujFQBFV8cThBmI=;
        b=aPV8oCfKUDllduUrFGdoqEhwWkzgUdo8clz2hLQxMbnemGemQYmNdohX5XBxa3hsAO
         L3hf5gl94mMoJCHt2osJ4xhsxLIEybDl0bNw3iZfCYut5TZyXK01Xo6xKnvN+AS/Iyt1
         jhpLk6tGdht/vzv8+IEbGc4hqKFXl3FChvbluSyTkdWkoNvyolOMAsNAdHTnYdjcVxp0
         Ly4GStyqptM4Vc6cQD1MvF0LpxoNxL3rc4W/AiZkMogitARSfJxNylIOTbv6++CgICJk
         fNtcCPUFesCtOr19BKBAXqn4jqgFnS+5Kz75KG+dRNRF7H0cp8wkp8sDG1hFq/6rP2n/
         n3Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780562503; x=1781167303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u13QfsqknDff7yI+wqO7HoZmhYeSH58Qvn8yXLkgd7Q=;
        b=r99INYDRDsFMB/WvpqWNAQV9zCG8W+w9dZpxxgrrhBc7TcVsQPdfKjhnTe4tiiPp17
         XCvK6bF0K0QQ3iFJn/Ohll16+JE7PQKxgYMB8lbUzEawZz6IIjHFQ81j5DazWag4Yzrt
         3i42kdS0VwVcBUEesePQiSu9VUta+v8YYzrhSj5ymHNEi/DXgox1AWQjlOp0oCxcNFuS
         HX8lZYB+iITsm1xrHutJDQeSwZBxfjQfKfuV1VcroY+r1T4rsh3Unx9+ivLHbwQSyu6d
         IsyxsVvEgPy0eov8k0/RjyNDjIjGioGqWDx1imW3zZ6TUNbB2zzoUwJ0s6OI/1Uc4zQH
         MFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780562503; x=1781167303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u13QfsqknDff7yI+wqO7HoZmhYeSH58Qvn8yXLkgd7Q=;
        b=L3y2blAUwQ7LntTW9wOYOd0cpzakffJXkq1bp/kIFdrQKkV+Bwaku/ioRW5ejUyYlj
         BJEdL5uQBxUOKELvOB2NSY+YWy+CbiZi3JAemEFKQR71ED8Sx3ktkO/VRzf1WRMFEtiA
         GgIkleGuJsQU9lAbCU2hLj6vpAi1j1oQX1VdKs72X8guoG5n02WG/RoCvIfBJ0YmtqtP
         IORVkkGq1vhsl+C85pWr/7Kxmk6Dg6znTAnjgZXZLYdvBaIYe5OuFBMtIit1/MwLTIDa
         Xn98YeHO7Ead1rDjjsXkgIJtPvPzbiqes9bi+ihwxb93joZSAoomou/DSXt4JTMCPx4z
         OWDA==
X-Forwarded-Encrypted: i=1; AFNElJ9/ILI8u0P52yfrRBpBzYSAFBQMvCmvVQAkHRHv7jBztGATWInuuGRUmPAIUKwG375RbGQzLDkNxdM7eDt5@vger.kernel.org
X-Gm-Message-State: AOJu0YwwQ6HbrP933hiSfBFZc20aJzHcK8s5Zjwv/mCMbNGArZrwAlX/
	vLQGsywCsgFaFw9cwCjFCNFMwD1lsT4VCkQAHi7N6KIL2AWrgukCCR9QJUd0oAXWcjPJE+UAFWK
	ut5OcoV+NqJlzNwUmIUTuk4ejaAU2tQL+W+KZ
X-Gm-Gg: Acq92OHi0A/bDae+BIgsAxTSizC3OkYK8C2VyFGYQEYtbNCZTKSrXAjLZsjNPn6dB3+
	czYbVwip1jsRsvo95UexYHbGE8l3adzH7+LPOf/mBY5Mpo9nqBrKFfCurXvzTXIC3UobNjEJQP2
	YrZzm4/ym4BbUxfTkSUZagqibm0SEiGtbUCtt/BlPD26a2PTnu6dNLeO9qQaetRSF5xB2LiqOK2
	+iuUkHil4ss0CKF7k4U55W+DapwjfaCcypSNH/rZTKBQ4l7SOCwq1wpM58oazaIMmG5VPgwnEOw
	xUwD9z1+N4Jjs1HEcQ==
X-Received: by 2002:a05:6512:40cd:10b0:5aa:b6b:93c3 with SMTP id
 2adb3069b0e04-5aa7c15c55cmr1623277e87.45.1780562503059; Thu, 04 Jun 2026
 01:41:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603175949.11665-1-hexlabsecurity@proton.me>
 <20260604042912.89893-1-hexlabsecurity@proton.me> <20260604042912.89893-2-hexlabsecurity@proton.me>
In-Reply-To: <20260604042912.89893-2-hexlabsecurity@proton.me>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 4 Jun 2026 17:41:31 +0900
X-Gm-Features: AVVi8CcxF9v4AjnCxP86a2cR0Cr0q_zJJfj_Ou0RwFRh52XqOtoAQ1uSGfK09so
Message-ID: <CANFS6bYMjgUok+p28WbjVfbi6E92KHnCeLcbWBQ-ryJt8Kv=HQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ntfs: bound the look-ahead attribute-list entry in ntfs_external_attr_find()
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 6=EC=9B=94 4=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 1:29, Br=
yam Vargas <hexlabsecurity@proton.me>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> When resolving an attribute lookup with a non-zero @lowest_vcn,
> ntfs_external_attr_find() peeks at the next $ATTRIBUTE_LIST entry to
> decide whether to keep searching, but bounds that not-yet-validated
> entry only with "(u8 *)next_al_entry + 6 < al_end" (which proves just
> bytes 0..6 are in range) and "(u8 *)next_al_entry + length <=3D al_end"
> with an attacker-controlled, non-8-aligned length. It then reads
> next_al_entry->lowest_vcn (an __le64 at offset 8) and the name at
> next_al_entry->name_offset, both of which can lie past al_end -- the
> exact end of the kvmalloc'd attribute-list buffer (allocated at the
> on-disk attr_list_size, no rounding). A crafted on-disk $ATTRIBUTE_LIST
> whose last entry sits a few bytes before al_end therefore yields a slab
> out-of-bounds read when the inode is read.
>
> Validate the look-ahead entry with ntfs_attr_list_entry_is_valid() (added
> in patch 1/3) before dereferencing lowest_vcn and the name, so the same
> fixed-header, length and name bounds the main attribute-list walk uses no=
w
> guard this read too.
>
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
> v3 (Hyunchul Lee review): use the extracted ntfs_attr_list_entry_is_valid=
()
>    helper (added in 1/3) instead of an open-coded bound, so the look-ahea=
d
>    gets the same fixed-header, 8-byte-aligned-length and name checks as t=
he
>    main walk.
> v2: dropped the redundant Reported-by; reproducer/KASAN splat omitted on =
the
>    public list (available to the maintainers on request).
>
> Confirmed under KASAN on the earlier revision: a slab out-of-bounds read =
of
> next_al_entry->lowest_vcn during inode read of a crafted image; a benign
> mkntfs image is KASAN-clean (control). Arch-independent (lowest_vcn at
> offset 8, fixed header offsetof(.., name) =3D=3D 26; identical geometry b=
uilt
> -m32/-m64). Please add the appropriate Fixes: tag for the commit that
> introduced ntfs_external_attr_find() in the new fs/ntfs driver (v7.1 merg=
e
> window).
>
>  fs/ntfs/attrib.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index abc0add6f0c4..e425c8d074c5 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -1185,9 +1185,8 @@ static int ntfs_external_attr_find(const __le32 typ=
e,
>                  * we have reached the right one or the search has failed=
.
>                  */
>                 if (lowest_vcn && (u8 *)next_al_entry >=3D al_start &&
> -                               (u8 *)next_al_entry + 6 < al_end &&
> -                               (u8 *)next_al_entry + le16_to_cpu(
> -                                       next_al_entry->length) <=3D al_en=
d &&
> +                               ntfs_attr_list_entry_is_valid(next_al_ent=
ry,
> +                                                             al_end) &&
>                                 le64_to_cpu(next_al_entry->lowest_vcn) <=
=3D
>                                         lowest_vcn &&
>                                 next_al_entry->type =3D=3D al_entry->type=
 &&
> --
> 2.43.0
>
>


--=20
Thanks,
Hyunchul
