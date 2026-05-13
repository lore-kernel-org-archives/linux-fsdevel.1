Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300C2385D66
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 02:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638501; cv=pass; b=t+pMAPf03cPXF4eT8vZbC/sjUidIyL6jx7wS4llOzRqIKXCP4RRudZ3VPWnwQcElj6JXs5r5kqB9MWp9DetVhHcEJ2VLe0lMkoBRzT8ESe4PuvmxezifDVbV8UD/zopeN2uv9FdnUnT6NovHoIXc3MUD4MYgYwKZzsvirN+c2rM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638501; c=relaxed/simple;
	bh=G3S54ZSYYy72x0IQukGpCbH2c+g/g2xMnw0bNTFx2HM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnVRe/mSnYGmrsGZtOAoh5kPGmfb2EMHnA/g1dZAOzpIAYDI7LV012hy9+i7n3FeKOqUKiLpelvvNyvvssVhlhJKTop3d5j4z27l/wEwNIRuyPUTmsW6fCHu2MCSbLwb154SAXPdiWE20u8faD9IQfdvMGFIkkvy59N60qKGn4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZTlEmCZ; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZTlEmCZ"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a86c1fe573so7068989e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 19:15:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778638498; cv=none;
        d=google.com; s=arc-20240605;
        b=Uy9f7Ei2Jl3TuX+Jo0Pm8xzJfrf6Rx+o6c66nX/TfxeakSpSJ97Ok0q1cOCAqDvFT7
         arRBLTaoCtFkP3Y14y6hbDAEXek/69awzv9upvhGTyGE9w/RvqO0ifIu1Uq4AuZEnCSh
         vwExiYRm4o6abm28Lik03TV/xNNc3KvFxJVziEzZ8vAecgjLjobPeLnd3pCyV6LTv8wZ
         tLItFwE8Xno9LjxPZ1k6vA7FgtKhlM8GW2nLrtwZiOTNejdPhm5M1IhYzMTJ+5P2Lrkj
         sBi9VNJ946LFRwBTRZ2V/IxhKRoVMWdhWdwOq7urLY4Jx9/c60qyQEeSS8vN03cj+vi/
         UUBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uHMJu6OGWquqr1ECxohAHbxdUNyroEwOsVqnr+GWwnY=;
        fh=f4ptWZrDhKBMfZvy6QsruFQ8D5jlUP1dxElyCnrl1WE=;
        b=QnzEsPI0Rw8H/Ce1LcUXz/gYyATu5ntlvO4zF2uV/i28anctnSSGHrFjuQUCuOIB97
         8Aa18kitOyZIlDKQbvCh3eM2uAKRzlrW7oSAKwSkxPCyUUPcL70RV3ewOmQ7O8dx88MO
         BeiUax8JucD+gtSwXDCrSiYUPr97Wl8Hp61GA+3MMX//duktJHRq4fyob3ojCwd6NwQn
         9BcWKyl4fBTIFmwvkH9zt6uiRvIp22lNNxdbU+1N8T3UqIrEn/NO0WBaS7pan1VgJJ4m
         aBu6D+3WVUQNsDewBs+UnnM0EiHgT0SdRUFawE8wk+wgikNsaukrZ3QrMQ2QncmrC7zJ
         5Vcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778638498; x=1779243298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHMJu6OGWquqr1ECxohAHbxdUNyroEwOsVqnr+GWwnY=;
        b=AZTlEmCZ50hnbSKXVd2rJVRWEIjPQqk+oaL3yUKMZ9kOCxCEy4ufeigeEfOd/hS+7A
         gz7c6Bv3ZffwqD9PuSWYISdHxULdr2fhFc9lX6NGo4RUA1A2bIe0a/N9ATp9RMaY7QPd
         yuJCF72pWPgjt9rvQMZEUxaMdyf6Vl8S02O/FTPKlbN+MJGpUbSUMH0JBhLrmjV1pPs5
         NXk5nxesi5kjI3mf4+j4c3r7YUoTUuoE5n6mqcFL3js/Xiz0286S9v3s2nf/QXZ1vv3y
         fQqKdhfSpTB0j9gBWp5y9GG8HGcB1bWoZmPP6+dOEeMhowzZSTOY8TEw+Ker2L+P7tcw
         uDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778638498; x=1779243298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uHMJu6OGWquqr1ECxohAHbxdUNyroEwOsVqnr+GWwnY=;
        b=hVrIcT4EcQPL30XIIF+8q8tJLbyIVcB7ZCVjViovMQKDuK7lQRLej005GIJ3cE2bVA
         Q1ZBce7KqxfvVXy3onC8BCShqa8kB+6+hM4LBQVKk4hvljKq+COOcF8dAa85ayduqSch
         3WEEvMcwEMP0qGljzLfHtE1CwqCOVWZK9g7KHNsbDwkHk1DtjcURS3DFSL8qLfubItmP
         fuz+gYhv8Rwg6OqZZKzy8watVhqcjl+JFt25Ip1ZDvUfoXALh+7GbpJB2z4lqBPAaygH
         pinJBGFuhhQ1+r5att39sk+r7c5xOZFIdjgUn7sAU8RG0o/OWKEYNXY+O+nuNXgw6ZF4
         jOgA==
X-Forwarded-Encrypted: i=1; AFNElJ8bzjKKWll/uSmXE3JIq2LuLdj4eJAFnJKrTrCXCkd7vhxrAEzCnETbd8fCucVHpTZcwciA+9KuIuZ/vJgJ@vger.kernel.org
X-Gm-Message-State: AOJu0YydO2XKEcSns3qpBcL00bPNQC4AAS3oZmNCG4B59Ys02thXCKFO
	VZg/SFZlyLwYl9vI4fYp8ukyfRS5Gq9hww9T01iv6yhDj++mwgDORbsxhDxWdxBgpePOCjFq7qH
	yDWAzbOykqt5ewR0lqOQsmNMpVpwDPqc=
X-Gm-Gg: Acq92OGnNR2tY5VpAeP8ec/J57/k5+ttqljFfx9v6vuliSTTAQRQ16EIYWvHibgBphM
	iXPh2t+d4+MZ+e0JofagAhYkI9Xamg975Qz3fZif3wWKLV1y4RCOKGuGgI5rTZBs0PVPsoIwF5u
	/SzRfdzBjcB2yyiKFZpQj8z46JzKpTm68qlxw/XvQxltRv6kRB9T4zHzaEyWfxVsclIxm2b5SCA
	58VyWLL5weZLY8LaAUJmES8bDqrw3SZtz8/s+hLmgejha0PSLLI0MyxAX8WOKHda7OgWpMkyGHw
	GolDoMM=
X-Received: by 2002:a05:6512:ba1:b0:5a8:88ab:e658 with SMTP id
 2adb3069b0e04-5a8ef9aa8b8mr408908e87.23.1778638497559; Tue, 12 May 2026
 19:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511160626.1268612-1-charsyam@gmail.com> <20260511160626.1268612-2-charsyam@gmail.com>
In-Reply-To: <20260511160626.1268612-2-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Wed, 13 May 2026 11:14:45 +0900
X-Gm-Features: AVHnY4JKq6FnpVxZ77fksNPcOfW7ouc29Vyr2AuDcYc4IYA87GfstFpgiTh_Ik0
Message-ID: <CANFS6bb1-ChANOq=_HYh_fYo5NNMMcSs2BEnF=1dY8_gxQQtTg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ntfs: return view index entry data from lookup
To: DaeMyung Kang <charsyam@gmail.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 12=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 1:06, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> ntfs_index_lookup() always exposes the matched entry key through
> icx->data.  That is correct for file name indexes, where $I30 callers
> expect the key to be a struct file_name_attr and update it in place.
>
> NTFS view indexes store a separate value in index_entry.data.vi.  For
> example, $Quota/$Q uses the owner_id as the key and stores the
> quota_control_entry in the entry value.  Returning the key makes quota co=
de
> see only the 4-byte owner_id instead of the quota control entry.
>
> Preserve the existing $FILE_NAME index behavior, but return the entry val=
ue
> for view indexes.  Use the index root type for that layout decision:
> indexes with ir->type =3D=3D AT_FILE_NAME expose the entry key, while vie=
w
> indexes have type 0 and expose the entry value through data.vi.  Validate
> the value offset and length before exposing the pointer, and clear
> icx->data when the key is not found because the context then describes an
> insertion point rather than a matched value.  Use unsigned arithmetic for
> the minimum data offset check, account for the VCN stored at the end of
> INDEX_ENTRY_NODE entries, and clear the returned context pointers before
> returning an entry-data validation error.
>
> Move the matched-entry data exposure and validation into a small helper,
> ntfs_index_lookup_set_data(), so the done label stays flat and the bounds
> check has a single return.
>
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/index.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++=
+---
>  fs/ntfs/index.h |  3 +-
>  2 files changed, 73 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
> index a547bdc..30dfcbb 100644
> --- a/fs/ntfs/index.c
> +++ b/fs/ntfs/index.c
> @@ -696,6 +696,53 @@ static int ntfs_icx_parent_dec(struct ntfs_index_con=
text *icx)
>  }
>
>  /*
> + * ntfs_index_lookup_set_data - populate icx->data for the matched entry
> + *
> + * For directory $FILE_NAME indexes the caller updates the key in place,=
 so
> + * expose the key.  For view indexes the value lives at data.vi; validat=
e
> + * its offset and length before exposing the pointer.  Return 0 on succe=
ss,
> + * or -EIO if the entry value is out of bounds.
> + */
> +static int ntfs_index_lookup_set_data(struct ntfs_index_context *icx,
> +                                     struct index_root *ir,
> +                                     struct index_entry *ie)
> +{
> +       u16 data_len, data_off, entry_len, found_key_len;
> +       unsigned int data_end, min_data_off;
> +
> +       if (ie->flags & INDEX_ENTRY_END)
> +               return -EIO;
> +
> +       found_key_len =3D le16_to_cpu(ie->key_length);
> +       if (ir->type =3D=3D AT_FILE_NAME) {
> +               icx->data =3D (u8 *)ie + offsetof(struct index_entry, key=
);
> +               icx->data_len =3D found_key_len;
> +               return 0;
> +       }
> +
> +       entry_len =3D le16_to_cpu(ie->length);
> +       data_off =3D le16_to_cpu(ie->data.vi.data_offset);
> +       data_len =3D le16_to_cpu(ie->data.vi.data_length);
> +       data_end =3D entry_len;
> +       if (ie->flags & INDEX_ENTRY_NODE) {
> +               /* The trailing child VCN is not part of the entry value.=
 */
> +               if (data_end < sizeof(s64))
> +                       return -EIO;
> +               data_end -=3D sizeof(s64);
> +       }
> +
> +       min_data_off =3D offsetof(struct index_entry, key) + found_key_le=
n;
> +       if (data_off < min_data_off || data_off > data_end)
> +               return -EIO;
> +       if (data_len > data_end - data_off)
> +               return -EIO;
> +
> +       icx->data =3D (u8 *)ie + data_off;
> +       icx->data_len =3D data_len;
> +       return 0;
> +}
> +
> +/*
>   * ntfs_index_lookup - find a key in an index and return its index entry
>   * @key:       key for which to search in the index
>   * @key_len:   length of @key in bytes
> @@ -710,7 +757,8 @@ static int ntfs_icx_parent_dec(struct ntfs_index_cont=
ext *icx)
>   * If the @key is found in the index, 0 is returned and @icx is setup to
>   * describe the index entry containing the matching @key.  @icx->entry i=
s the
>   * index entry and @icx->data and @icx->data_len are the index entry dat=
a and
> - * its length in bytes, respectively.
> + * its length in bytes, respectively.  For file name indexes @icx->data =
points
> + * to the entry key; for view indexes @icx->data points to the entry val=
ue.
>   *
>   * If the @key is not found in the index, -ENOENT is returned and
>   * @icx is setup to describe the index entry whose key collates immediat=
ely
> @@ -836,11 +884,30 @@ err_out:
>         return err;
>  done:
>         icx->entry =3D ie;
> -       icx->data =3D (u8 *)ie + offsetof(struct index_entry, key);
> -       icx->data_len =3D le16_to_cpu(ie->key_length);
> +       if (err) {
> +               /* When the key is not found, ie is an insertion point. *=
/
> +               icx->data =3D NULL;
> +               icx->data_len =3D 0;
> +               ntfs_debug("Done.\n");
> +               return err;
> +       }
> +       err =3D ntfs_index_lookup_set_data(icx, ir, ie);
> +       if (err) {
> +               ntfs_error(sb,
> +                          "Index entry data out of bounds in inode 0x%ll=
x.",
> +                          (unsigned long long)ni->mft_no);
> +               icx->entry =3D NULL;
> +               icx->data =3D NULL;
> +               icx->data_len =3D 0;
> +               if (!icx->is_in_root) {
> +                       kvfree(ib);
> +                       ib =3D NULL;
> +                       icx->ib =3D NULL;
> +               }
> +               goto err_out;
> +       }
>         ntfs_debug("Done.\n");
>         return err;
> -
>  }
>
>  static struct index_block *ntfs_ib_alloc(s64 ib_vcn, u32 ib_size,
> diff --git a/fs/ntfs/index.h b/fs/ntfs/index.h
> index e68d6fa..4b8c5c8 100644
> --- a/fs/ntfs/index.h
> +++ b/fs/ntfs/index.h
> @@ -58,7 +58,8 @@
>   * To obtain a context call ntfs_index_ctx_get().
>   *
>   * We use this context to allow ntfs_index_lookup() to return the found =
index
>   * @entry and its @data without having to allocate a buffer and copy the=
 @entry
> - * and/or its @data into it.
> + * and/or its @data into it.  For file name indexes @data points to the =
entry
> + * key; for view indexes @data points to the entry value.
>   *
>   * When finished with the @entry and its @data, call ntfs_index_ctx_put(=
) to
>   * free the context and other associated resources.
> --
> 2.43.0



--
Thanks,
Hyunchul
