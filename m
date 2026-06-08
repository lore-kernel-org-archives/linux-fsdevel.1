Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87991351C3B
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 05:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895299; cv=pass; b=gM4LBgffZ7deDhL/vTZfX5O+/uPdh3v7TR/ZzwJvyd4177ZNzYGkSVatBvaQU6Win7jBg4IgMnq/vazkDNFewzV6RYUoYFCPhO2JpcBGScuPwfptfPXeUNI5GaOmGr3AIKscrmYsAxBbrKAJOl+jAh7PnFQs83kfVm2HnhSQpwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895299; c=relaxed/simple;
	bh=/JCB0ytz7h43gzLuu78Uyq85l2ziK1k/0B1owyqPzDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUxqyczrjLDVqX11XLJ4BsM/7IDnaJUF399QlU1Yr650eIJECqP2JVTWMFPK1J2+mxA6peVrgnwdLMwqYI/3o8VG5T9A5GHl7AbPG3+qrp0pSIZJtNXPauJQHAKk6jNsdpERTi4ehNLg6GGqPB/JCTEuRuoxnULroXlctNrZX8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4WPLtb8; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4WPLtb8"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa6863327fso3209814e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Jun 2026 22:08:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780895296; cv=none;
        d=google.com; s=arc-20240605;
        b=F/K6bRu80ZoclNtdH/0tnP45FGsTrlembvw3sOfT8o4NMII83HW6ea/+PrFm4UlsmE
         YYRzCcgOF3k/cqjtDI/QO5w6qw/WXwVeS/vTpvXqdvmQbYcI5IH+na3dwMmOaMwfU6z6
         QsYUmHh8ywoFT3uCwhkjIYxIrzExwL+yh4oUyEOAW1YEsMQ2WB8kFeAMdykSPws6ErBG
         EUfGdoQlcqHHnEIDyIUEzuRjtoIOSImukPpXVL2+3M2mcg4AgaS2nWg2IJoLNoiJgSMY
         b6PTIlu9nUYa/RFjMp66guktm97zVmy5Wp6BoIKoM3VpIFrOFQrUW1CYZtnLbX9l3NoO
         hFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t7iXK/pcVu+Tc1kragglkB/zLccWHIE57bsV7KkT/08=;
        fh=tr4dmskBauWPiox00TadQjBVOG460MdlE0qKzXBcZD8=;
        b=ZNsnjIz36/0EVh3+e8otEPKtHTsQgxq/sW3dmjI85u0ykmC4BgPGkJTZWDPg+F83+i
         7u5cYvbB8ghfJVRw/rVrLQSTYOl2icjXi58Bie2MTYFPHLj7+5L7DDJsP/ghrq5R0FA+
         GJKtEbtu2E+tVnYC+ayaIYTeYI88FaCHM71pHvgcOBvjdI8W2OvF1yUrDGFn0cAm9K9m
         rgtdZbByyfauAGmTU+xiDpiHzMzmi4z5gjWCJ0H3hVp8Rmw99tzyzwRchvvF4oRus8dU
         0Svg8XdAl/r8h3hjpzjrY1RKoWLd2YAV/jynrdH5WMmyGjZrJmnR7Q4agQQH5ZMrASVW
         Arjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780895296; x=1781500096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7iXK/pcVu+Tc1kragglkB/zLccWHIE57bsV7KkT/08=;
        b=J4WPLtb8n1MKDG8qxgvWGUtJWUqFfynIiqmWyivtQG5PTrd+JYMa5C1LZpdV3n9gW5
         G/0+tzPpry258xJxFxR4xIX6BjfTah77OKCNiXiXuY1a/OHIWgfsNRJfAUtM3tf400NF
         +Z2I/gaYu7wOLKDa1I+TNypnX4XpOGLTkTM7nUsVe1aABCT8LiEkD5/RIjyEbTVvHTi4
         +U3I0lLP85ChST0I5KOpdH6Mlm03l5o9GbeDIOiDYq9Aw5dImy0FplFjiumKg4aBowgL
         kaRDZWA9xsoGTAEJqUiz8kXbjnrH0KVfr4TGxssXPmN9Wne925zrV2WorrX42JEQMzsC
         BH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780895296; x=1781500096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t7iXK/pcVu+Tc1kragglkB/zLccWHIE57bsV7KkT/08=;
        b=m1y6MJ4XAHrOHWwoW2xx6fb9YACdYOTyNWirVNEkPBGHun3BE7yFAxjHfyk+CGyUOL
         v1OQbGmVMEtP3YVL0e0q8QEtpUv8P3JZ/sbG16Ze2lfgYOqGm8R2VraK6i6KgYRUpAS5
         zy+rOLdsBGmnXDfXDh7ZbFC9LLLwGZ2kduQJLxAtYikQiNCj6OEZ0W7A4lNwqQIjdIrh
         q3OQokee8QexytzlmpQllGb0cVwpPKN6GuLFMq5dmgXBxD6pxOorZ3OS46M1PNK14fKP
         XIAoOqtuonsDqjFoyQL2Df7nqK6ppg1JKuB/zYiRYpthx6xzy8Vpa8URYr0rg8+f7cCN
         CW6w==
X-Forwarded-Encrypted: i=1; AFNElJ8EOMVk8YkNB4ene9x8ySgsidmXurTNwGM3gl/2RAhrO0hWq/4TdpWFK7K9wrmI7vEFQWnT0BfY4z8pkcVR@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi/5IR0YONOhORRcIiXcttq/sTN3R6IERdlpotNBEtoKKVKJId
	5nV0lbtMxlNbOQxRnAigRxyzf6hubH3HVrdP05jBHaFckaiHYHkn1gORDs+6ycsP4y19anycMjr
	CIwgZjY1wlLm3nKL0Mja87bj55zOUH/k=
X-Gm-Gg: Acq92OG+JyxYv3qHkx4i5zBN03J2SfzNEUwM647lKNL2n8bdf1a1L/14v24ZdcrJYwm
	RDu/kkK7hA6+S72El4SV85+1WpvR66pifYErwFl89b2q8SqBJ/g1KLjQaMaJCao6TR8LPznTQVC
	ixvQlnwViFj/QmK6MTArQSaPboot43iHFRCEVYJELTMGcQzjNUMpizoFT2ftqMh95WoZ+EcWSNu
	LQmbC9goHOXKYAlBCtfBZLBN9byvmldOq43DuZty9/Ed1dnrhrNvGc4E2yHFGPbd3OC8dEJyC2k
	u32OoleV32ikygTFdw==
X-Received: by 2002:a05:6512:3051:b0:5aa:80b1:6ae0 with SMTP id
 2adb3069b0e04-5aa87a1325dmr3612364e87.0.1780895295485; Sun, 07 Jun 2026
 22:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607051723.1499833-1-charsyam@gmail.com> <20260607051723.1499833-5-charsyam@gmail.com>
In-Reply-To: <20260607051723.1499833-5-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 8 Jun 2026 14:08:02 +0900
X-Gm-Features: AVVi8Cf_PVF106kV-CVqs9X6xFHLE8vQBT-ntKsylQRhX0lR0nJDMpMu4pVE3Uo
Message-ID: <CANFS6batLwvN5KY2pLFrvmM-ZLa5+yQKUXP+kTPzJo5CqTebZw@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] ntfs: validate index root allocated_size on lookup
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daemyung,

2026=EB=85=84 6=EC=9B=94 7=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 2:17, Da=
eMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The resident $INDEX_ROOT validator already checks the index root header
> fields, but it still does not bound index_length through allocated_size o=
r
> ensure allocated_size stays within the resident index area.
>
> Callers consume index.allocated_size as the resident root capacity.
> ntfs_ie_add() uses it to decide whether an insertion can be done in place=
,
> and ntfs_ie_insert() then updates the root without re-checking the reside=
nt
> value boundary.
>
> Read allocated_size in the resident $INDEX_ROOT validator, require it to =
be
> 8-byte aligned, require index_length <=3D allocated_size, and require
> allocated_size <=3D the resident index area. Valid slack remains allowed.
>
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
> ---
>  fs/ntfs/attrib.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index cf49eade6b22..49c8f1f3b9dd 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -657,15 +657,19 @@ static bool ntfs_index_root_attr_value_is_valid(con=
st u8 *value, const u32 value

Applying this patch failed.
It seems that the patch below has not been merged yet.
https://lore.kernel.org/all/20260530143514.3083601-7-charsyam@gmail.com/

>         u32 index_size;
>         u32 entries_offset;
>         u32 index_length;
> +       u32 allocated_size;
>
>         ir =3D (const struct index_root *)value;
>         index_size =3D value_length - offsetof(struct index_root, index);
>         entries_offset =3D le32_to_cpu(ir->index.entries_offset);
>         index_length =3D le32_to_cpu(ir->index.index_length);
> +       allocated_size =3D le32_to_cpu(ir->index.allocated_size);
>
> -       if ((entries_offset | index_length) & 7 ||
> +       if ((entries_offset | index_length | allocated_size) & 7 ||
>             entries_offset < sizeof(struct index_header) ||
>             entries_offset > index_length ||
> +           index_length > allocated_size ||
> +           allocated_size > index_size ||
>             index_length - entries_offset < sizeof(struct index_entry_hea=
der))
>                 return false;
>
> --
> 2.43.0



--=20
Thanks,
Hyunchul
