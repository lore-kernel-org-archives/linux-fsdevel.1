Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE82E92BA
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 23:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963096; cv=pass; b=Kx7AAmQFFTtJuhoz+PlK7dfwZSC9RJRglKvTJGcMem/QL0uQ+UrT4bXPeFpnOQjGQQ/3syXquBnvGG7btcI5jxMT3kRdWB/xp4fBjaEC7OSNKZjTfSp53laCfgXhf+ZrivNI9XN8qfhGx0gF4HN0rFVbmf13XCzxmxiBR+q61mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963096; c=relaxed/simple;
	bh=liM7/fYMnngobQ8glGNsAiLh778C8+WnIWvqmDpziLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uboGik9xOPz96AbiGRHI9iOmnPDOb87qaTPKJmtjFLFIrTvI0QVHRg5syne4O5bDRY2fL/zhg6T43NQMnrkByjccsO6xMz+h6MYJuFfSGV6hJMH0erPJN9hMGUWnzDgNbxtoM7mn3FY96Sft5YIKHS8MhXn4ld6JqAy5bnhBiv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUSeSTUP; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUSeSTUP"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa68d65d24so5281526e87.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 16:58:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780963093; cv=none;
        d=google.com; s=arc-20240605;
        b=gEGikp3Q3VIc8UIV7+tFpSdYk+ZvSGbwfIeAgmpADfOjKqBwSIimy+PMandrcglPJe
         keOZSK4R5pdXunag50OBf/t43Mx4GJGI51Qz9mm//rP1hxHBXQUhLvmjCYrRzIHGRS9e
         0lAjLWGiPrloPVQ4JHLhQWBUMH8QMvJiwHOMTqcqJmHJlgz1251Js83dFBmCXKGmWtlo
         6abCVEKI5s7S4UeqL0M6CoS+kTLGrFmgrQuWEHT46icdHCTmWIzlwV8PKn/mszZB8B6U
         gEVn3v95N/TfoXa2rze67vmZdWzBoCnH8QTr+RTTfTXBq3tCLuVfKE/8gUSoipIvzykC
         priQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YgmCjSYgLUsp0ycoeyQeAi9uotP7CKwjvuwDZmC15R0=;
        fh=KVY7eZ4oZjBgyG+PyEpF+/oLddYTs3qbmEG3yIa1sas=;
        b=FO5aVR0pEa3OdZZYkbtPJTqBlCGRFN+GveyUanoYYP15cpPv18NUfsGOUALnNtmZbe
         EFhvSNG/QdJEEvNxCGpLrU1wNqgPsnLxZtFKcMMLno6lLGyiRzHeQKBPgAVdRUPWVsps
         fzvOxrlIrgLdiQ9alkudHQtsywNtPOPmcqCkTebf+lk/14cTZ5mKklc2XOEaZIPwN9ku
         LPDmTevoPBFL6IyEFhoPnysdpY0pDjbif+SZl8hBJo3Qg/TKiNYkpJLuqiFgLnExffzl
         /h8ySCYuM0/CWEz2ajwIgGcx0vHatSEHkPoozrA8kbFdADk+EQgOr2GND5seciaFJj2x
         7uMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780963093; x=1781567893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgmCjSYgLUsp0ycoeyQeAi9uotP7CKwjvuwDZmC15R0=;
        b=YUSeSTUPXtFeSWQPRvisp07Vl4/pIhwB5rc3mm6X+Us+7w0yiXl/wEdvo+1IV4kR8K
         bJrtFJPhMCS93pyvmNVsrz+vdmZW66drKfkyeDkcAemDKfS/dFX8vBLEfxVo5ikmSBi5
         0xkYHiW6eq3N+iXoxzAASNaVShJBaZ2226KXDhNArZhMUg8iYWs7F3trxRrEI0u85SXG
         Qucx3LTiUycZA7gfNaXSQ/zorHz5JjopI2Vy/LTSQb8+BHpnj7dtuJ6sHx4bGSxZP18E
         7OdySKrAb6VP9N9ABUqNLIN8UXMQbxV2pOb4LDVszcLxn4TzrTr9UKktYtDSepgdTZC5
         JeTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780963093; x=1781567893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YgmCjSYgLUsp0ycoeyQeAi9uotP7CKwjvuwDZmC15R0=;
        b=VC/sm2u0UTNeY4wTEY9TX6NLWN1s054hbh1/lcv1/X8IGS5oZRlCuTuagSWQqCIJ9+
         WGXMdpAuQwkR1KLL91jwlS/VlYgF65+3ooexeRPbuWrd1jVlqJkPOx/VSY0njkNBg3vz
         KO4IftiEEOLzDAaZrmczeGNE5R9TH+Q85j+oKZzJ6BM7GppQxkq2biO/ggutc7e3Rk9z
         67UjOpZxFnGUU8RWw8mv6EiIT+Ns1/d/GGkpuFYR6+zYlpM59XT6FP0k85sa2yj7lLxM
         CTUTl9yCEY9w09UkK42YEfQGtoXrfB9/5upOVMjzWh6b2AgvdIJX3tANIpbcNmvoPOcr
         B56g==
X-Forwarded-Encrypted: i=1; AFNElJ++P6oZoMpaeOz9CRozNOehvR75N7TmMvhNOSQg+UfS1HngLSxi8XhfycKlnT1bg5HoHYhlr/NsxB6vLT0e@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg6YHns//GuH2GTtcbtHOzLJi/tYSLzHpM20T2MSoxKKzTpddc
	kvjtC3+ahKYMLfA1dUSwZTWKKJYYgto9//LZwnsgTNHSoZnMYEDCCUY7+hWQQBWNfGXrcJu5foG
	W4ZFoPhT1pnV70BkFRJO98kpEMXBuX2E=
X-Gm-Gg: Acq92OEVWaShmF7wa2PPHllXkbCLXWuMx9klLnQRZh88XTdEBDeihAuipMnSJiw97u+
	XoFmZb7rHbj+Yg3n53/8Kuo/1XE/fRbaMEwlY/nBwSJTCRgQ+LIX+zYIgTUAmONBkf/+wBWtbh/
	q3DtaSMJQZ/bi7OxOGEuUP7IdsluXbHvex7U0NROLpJOqRnrM46EwMDQY6egYh0jL0X7EA0i4vw
	EnPdJO+VDh77ul7GTbh/u+oE1/8+/qGoHJlrl+AmKMTnP9BxluNauUTOlHL7pxr2xQ7d8svsdL+
	cSOGeVmxrl0Md8Gn1Q==
X-Received: by 2002:a05:6512:3b9a:b0:5aa:6e86:55e5 with SMTP id
 2adb3069b0e04-5acf6be8927mr26394e87.13.1780963093269; Mon, 08 Jun 2026
 16:58:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608154917.2703739-1-charsyam@gmail.com> <20260608154917.2703739-5-charsyam@gmail.com>
In-Reply-To: <20260608154917.2703739-5-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Tue, 9 Jun 2026 08:58:01 +0900
X-Gm-Features: AVVi8CeHIw5HaAKpdXBCuzD6bnWvEluvbrAMS2ncz-IqZwp52xyoQBrgBr3BUqY
Message-ID: <CANFS6bY2FV+Bw-dDtnntJ4oyeJvXUBv9fDz7dU39LOO0tEOhBw@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] ntfs: validate resident index root values on lookup
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 12:49, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Resident $INDEX_ROOT values carry index header fields that callers
> consume after lookup. Some callers already validate parts of the layout
> before walking entries, but those checks are scattered and do not cover
> all root header invariants, such as entries_offset alignment and lower
> bound, index_length, and allocated_size consistency.
>
> The resident root resize paths now keep these header fields consistent
> while the value size changes: ntfs_ir_truncate() lowers
> index.allocated_size before shrinking the resident value, and
> ntfs_ir_reparent() grows the resident value before publishing a larger
> root header. Lookup-time validation can therefore cover these invariants
> without tripping over the driver's own resize paths.
>
> Add $INDEX_ROOT to the minimum resident value size table and validate the
> resident index header fields before returning the attribute from lookup.
> Require 8-byte aligned index header fields, a sane entries_offset, an
> index_length within allocated_size, allocated_size within the resident
> value, and enough entry space for at least an index entry header.
>
> The shared validator already rejects non-resident records for
> resident-only attribute types, including $INDEX_ROOT.
>
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/attrib.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 1254fbe7666e..8f10688a17df 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -589,6 +589,8 @@ static u32 ntfs_resident_attr_min_value_length(const =
__le32 type)
>                         sizeof(__le16) * 1;
>         case AT_VOLUME_INFORMATION:
>                 return sizeof(struct volume_information);
> +       case AT_INDEX_ROOT:
> +               return sizeof(struct index_root);
>         case AT_EA_INFORMATION:
>                 return sizeof(struct ea_information);
>         default:
> @@ -632,6 +634,31 @@ static bool ntfs_volume_name_attr_value_is_valid(con=
st u32 value_length)
>         return value_length <=3D NTFS_MAX_LABEL_LEN * sizeof(__le16);
>  }
>
> +static bool ntfs_index_root_attr_value_is_valid(const u8 *value, const u=
32 value_length)
> +{
> +       const struct index_root *ir;
> +       u32 index_size;
> +       u32 entries_offset;
> +       u32 index_length;
> +       u32 allocated_size;
> +
> +       ir =3D (const struct index_root *)value;
> +       index_size =3D value_length - offsetof(struct index_root, index);
> +       entries_offset =3D le32_to_cpu(ir->index.entries_offset);
> +       index_length =3D le32_to_cpu(ir->index.index_length);
> +       allocated_size =3D le32_to_cpu(ir->index.allocated_size);
> +
> +       if ((entries_offset | index_length | allocated_size) & 7 ||
> +           entries_offset < sizeof(struct index_header) ||
> +           entries_offset > index_length ||
> +           index_length > allocated_size ||
> +           allocated_size > index_size ||
> +           index_length - entries_offset < sizeof(struct index_entry_hea=
der))
> +               return false;
> +
> +       return true;
> +}
> +
>  struct ntfs_resident_attr_value {
>         const u8 *data;
>         u32 len;
> @@ -705,6 +732,10 @@ static bool ntfs_attr_value_is_valid(struct ntfs_vol=
ume *vol,
>                 if (!ntfs_volume_name_attr_value_is_valid(value.len))
>                         goto corrupt;
>                 break;
> +       case AT_INDEX_ROOT:
> +               if (!ntfs_index_root_attr_value_is_valid(value.data, valu=
e.len))
> +                       goto corrupt;
> +               break;
>         }
>         return true;
>
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
