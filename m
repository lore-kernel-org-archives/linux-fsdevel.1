Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBF31619C
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 05:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779947826; cv=pass; b=IR3/GFPD/iQ58ayviUUaTCYp6yhMYkHYyxdRnOQ7oWjDqlLGtKLBNBTCR9EzKS+75Hp53gbb7pBT5oKdyqheoHRTpR8Zj+uCx8RfFH1jKV1tLpDq7EKGebR92efvxmp3JHsTHUxuKSWEB0z0fs4ys5J5io97+lSuGhDDaHzNr1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779947826; c=relaxed/simple;
	bh=drZ4J2NKbMu21e4Y7UgW8Es8D22uZUxnve+iz5kC0fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Iv5QEDGIevABnYvwLNWcsVaf8XtOP+yjOCERG37jXNpBaZ995IGHPA6g5PGv3KIhCKmO98o6q5T6u4hcT0SmmLE4XjpvRZV+VCWSN/GmJDfR02n1FCNshbEQUsVyMbuhz2+qKzTr00RdaNGJfShZFg8GjBGm0vBkItlJfIbeUDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ipv3TEhu; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ipv3TEhu"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a87782588cso6450977e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 22:57:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779947822; cv=none;
        d=google.com; s=arc-20240605;
        b=QiOSZRtSoVPQVrUUFR4IliaBsxssWxEbv1B0vAD5srQGUBzrQWNFB7MpwgPgfg2HQz
         bOcByZsb4PFXTNCxlZckpO5BucQHjGXL0yhcbzVrxMqblrGJpurE/lUZ4r+Ejea6FT8O
         CaRXgXwJCKWRy/InzCa6YxGDwWNEs2Eb0V8MAqytL9sJCtkOQFiVAcLHnXaRWMeqGjAF
         0THkz9dxPdI2WaPFEunFsxfIQ6naP/xiSpl+E8Tou2jOU4vGiGej85a1/xzGVOEzwTaf
         mqczjx+lBwuFoWmG9dFV1EXh4MskNEatfthNwrLf29XBGjGntlj5qwU89xdIkldtW2qG
         U8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5eTaAmGOOeuiOyzWitu2haijmjqzErRBrxsF+dH8SLU=;
        fh=2ng0R/4K3az1fLup+wWTZ7iRtNNAfT1YhjjrXQSwtFM=;
        b=QMFGr7LUeW0eL4NhJCHMc6cA60Uk9BLoDteEO4s0nGeSS4HqJLMYWCA+wvi5dmluRG
         wsId0iLjt3NCkYUggka5tObKeq3HxGfPRMqp6eRdhb8PXjJvFMT1r7Zo/Cqx4aETGxWM
         IHIvqhYDJCDRZHrNPoUQLmVoVy+/hHua80RE0oClk5NpQUtLK7t2sxTrvmh8rbgjuG7k
         YNdDBYEkI0TyJHqzQQvjtAiFZXOn2zwQfLvkyN0LjUcnESoV7GI9EORsAPG2VBrn95Vp
         x0A23NJHBwK1CDow3LeDbWQ+QbnHnrEEZP02D9WsnCWJJUWBg7d1kT8a1gi2zEdTb2iI
         9SeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779947822; x=1780552622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eTaAmGOOeuiOyzWitu2haijmjqzErRBrxsF+dH8SLU=;
        b=Ipv3TEhux3fWddqxIgqfttnazBTTZlmZJ4OKkAV4kipINHa7Xx9BJrRY51Gnq7A7Ac
         D9GFiIm6dQdaBa2OniA3y6b/2+upGv6z+RcWl6tPnza3WOHqFrqXzFbaxcuikkEv02Zy
         Rp3ijRyApP877yLl+J2Mv2kt1hadyJv08maYhKlZtPdTpJQMDql1rYIr+JzDHLVWoMqi
         qHxzkTW8zxMOkX9oEKAHzHJZ/7RyXPDuRYKspkwigR3nrpN1w2anikI5jtRidfWRCUlN
         Q2ftYEEd+cf6j8wnNimN4HYwJT8jq4d9hNlFNUh3uefOSCFxcig4Eic/d2wiwPS2tkj3
         mulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779947822; x=1780552622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5eTaAmGOOeuiOyzWitu2haijmjqzErRBrxsF+dH8SLU=;
        b=Xil437KxRgNww0pVrH3ih3GxJ4RRiyEq8mlFkKcRApArWW1UHU0Cyam0oeIM8Wvx5e
         Xvm09rz0oMSNIV0J6Mv/Dng0DmVyalnUgYv5rERkQns+cQ2uWVcGlRplYvvTfxyhLxWX
         zzPpL0Ba74FqThx3p9fRUbQylunTTBA2FvYfDGNdRVNVj9uoCp2B2NmitHa7rg8YcVvj
         f3knEZwDB/Km+Hfqt+VcBTgP5AuMnPsPCTDxQQ2I9dcuJGWGzFBQBcO0XeXm42BzjJHS
         /Lw/C4AXhwjtGdYWAiCKxG78/TF2dYZzFnf8hmSryhhFpsrqDH3+y6jZvOgBLWkYwrNQ
         lfMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DPxfnozdOghs7jvIq7kxZT5rwXq8XZdhFvmsI8/CxtXh/o/1yLJBZVWF0u3yOGpO1xw6jdaOnBI8TXUIV@vger.kernel.org
X-Gm-Message-State: AOJu0YyLgv+wdnySB73UbVjJYtoJZSdz1gePp348q6HS9b3vaAeJkBFH
	WSLFR3ccM5UEf/yOQhxbnxcmA1NWnmptWmhnBjTF2LdTbcoWipK064zLG0qIrnK29exPh6VTgaL
	UklkesDzDqT5pbYkRWC8GMA/bwJuX2b8=
X-Gm-Gg: Acq92OE8/bd+4ANSZkheKDf3OCLzU6kajnApriuV8f2LcJPdzfOw+YVXqtwmKfmXA+y
	I69aZTxQj6p/9PQuQ4IqNVW8io55xX+GllrBwcntdYp780wfOKH2n3Qw8g74n3BZKe0qfLIPAPX
	7rdT1HWox1QYhSBZhJ4KC/e6eK3gJi4T8GQ7t6H0+MSEP9usPR7Zv8IoEDnAFGzRICBn912BvE0
	4E3iYgWLWZkLKSmPltXa9g0cCIcZlDwzl6oynr1heJN3iXcQed4MDm7RA9jV1LUhDVr5gkQKNEF
	yHM6v7JVzQJVwBvsUQ==
X-Received: by 2002:ac2:4942:0:b0:5a8:7395:182a with SMTP id
 2adb3069b0e04-5aa3232c41cmr5564342e87.8.1779947822077; Wed, 27 May 2026
 22:57:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMrLSE5izyWrP=t3_7UWjKJTd296fBrdoHZBW3DMMCzwPY9v-Q@mail.gmail.com>
 <20260526133152.1205929-1-charsyam@gmail.com>
In-Reply-To: <20260526133152.1205929-1-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 28 May 2026 14:56:50 +0900
X-Gm-Features: AVHnY4KPjdePqUXXTkzhV3UprTAmrpl19e7cO-kP6GCVeHzEO-mcMnGQxyj541Q
Message-ID: <CANFS6bbC2Rce0Cq-L-eye0JkiV_Runtd2zziGfscCWVXZ7YkqQ@mail.gmail.com>
Subject: Re: [PATCH v3] ntfs: validate resident attribute values on lookup
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi DaeMyung,

2026=EB=85=84 5=EC=9B=94 26=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 10:31, =
DaeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> ntfs_attr_find() and ntfs_external_attr_find() check that generic
> resident attribute values fit in their attribute records and that
> fixed-size resident values are large enough. For variable-length resident
> formats, however, the fixed part is not enough: embedded length fields
> can still point callers past the resident value.
>
> A crafted image can set a small resident $FILE_NAME value_length while
> leaving file_name_length large. Callers then trust file_name_length and
> read past the resident value when converting or comparing the name. This
> was reproduced with a crafted image under KASAN as a slab-out-of-bounds
> read from the kmalloc-1k MFT record copy. The stack included
> ntfs_lookup(), ntfs_iget(), ntfs_read_locked_inode(), ntfs_attr_name_get(=
),
> ntfs_ucstonls(), and utf16s_to_utf8s().
>
> Add a shared resident attribute value validator and use it before a
> lookup path can return an attribute, including the AT_UNUSED enumeration
> case where callers inspect returned attributes directly. The helper
> validates resident value bounds, minimum value sizes, and the
> variable-length $FILE_NAME field, while preserving the fixed-size checks
> for attributes such as $VOLUME_INFORMATION and $EA_INFORMATION. Log
> corruption at the rejection point with the attribute name where known.
>
> Reject non-resident $FILE_NAME records too: the format requires
> $FILE_NAME to be resident and callers treat returned records as
> resident.
>
> Type-specific format validation for $VOLUME_NAME is intentionally not
> added to this helper, even though $VOLUME_NAME is a variable-length
> resident attribute. Existing callers such as ntfs_write_volume_label()
> treat a failed AT_VOLUME_NAME lookup as an absent label and
> unconditionally add a new record afterwards. If the helper rejected
> odd-length labels at lookup time, the corrupt record would stay in
> place and the caller would append a new record next to it, producing
> two $VOLUME_NAME attributes on disk. Caller-side cleanup must precede
> any lookup-time rejection of malformed $VOLUME_NAME payloads, so the
> type-specific check is left for a follow-up patch. The generic resident
> bounds checks (value_offset / value_length / attr_len) still apply to
> $VOLUME_NAME, and its entry in the type-name table is kept so that
> those failures log with the attribute name.
>
> Do not add $INDEX_ROOT-specific value validation in this change. Testing
> with stricter checks showed an existing ntfs_ir_truncate() shrink
> ordering bug: the resident value_length is shrunk before the root index
> allocated_size is updated, so a relookup can observe allocated_size
> beyond the now-smaller resident value and fail. Fix that ordering before
> adding the $INDEX_ROOT-specific minimum-size and structural checks.
>
> Fixes: 6ceb4cc81ef3 ("ntfs: add bound checking to ntfs_attr_find")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
> ---
> Patch 1/2 of the previous series ("ntfs: free link name from
> ntfs_name_cache") has been applied to ntfs-next; this v3 contains only
> the remaining patch, with the resident attribute validation reworked per
> review feedback.
>
> Changes since v2:
> - Drop $INDEX_ROOT-specific validation from this patch, including both
>   the minimum-size table entry and the structural checks. QEMU testing
>   with xfstests generic/001 showed that those checks expose an existing
>   ntfs_ir_truncate() shrink ordering bug, where value_length is reduced
>   before allocated_size is synchronized. The same test passes when
>   allocated_size is lowered before shrinking value_length, with the
>   $INDEX_ROOT-specific validation enabled. That ordering issue will be
>   fixed in a separate patch, after which the $INDEX_ROOT-specific
>   validation can be reintroduced in a follow-up.
>
> Changes since v1:
> - Refactor resident attribute validation into a shared helper
>   ntfs_attr_value_is_valid() used by both ntfs_attr_find() and
>   ntfs_external_attr_find(), and remove the duplicated inline check
>   from ntfs_external_attr_find().
> - Split out resident header/value bounds extraction into
>   ntfs_resident_attr_value_get(), returning a small view struct so the
>   top-level orchestration reads as: get view -> common min check ->
>   per-type format check.
> - Validate before the AT_UNUSED enumeration path in ntfs_attr_find()
>   can return the attribute to callers that inspect it directly.
> - Reject non-resident $FILE_NAME records: the format requires
>   $FILE_NAME to be resident and callers treat returned records as
>   resident.
> - Type-specific format validation for $VOLUME_NAME is intentionally
>   not added; see the commit message for the caller-side reason.
>   Generic resident bounds checks still apply, and the $VOLUME_NAME
>   entry in the type-name table is kept so that those failures log
>   with a readable attribute name.
> - Log corruption at the rejection point with the attribute type name
>   via a new ntfs_attr_type_name() helper, matching the existing
>   attribute-name corruption message in ntfs_attr_find().
>
>  fs/ntfs/attrib.c | 148 +++++++++++++++++++++++++++++++++++++++++++------=
------
>  1 file changed, 117 insertions(+), 31 deletions(-)
>
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 421c6cdcbb53..382d1b6e877e 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -595,6 +595,112 @@ static u32 ntfs_resident_attr_min_value_length(cons=
t __le32 type)
>         }
>  }
>
> +static const char *ntfs_attr_type_name(const __le32 type)
> +{
> +       switch (type) {
> +       case AT_STANDARD_INFORMATION:
> +               return "$STANDARD_INFORMATION";
> +       case AT_FILE_NAME:
> +               return "$FILE_NAME";
> +       case AT_VOLUME_NAME:
> +               return "$VOLUME_NAME";
> +       case AT_VOLUME_INFORMATION:
> +               return "$VOLUME_INFORMATION";
> +       case AT_INDEX_ROOT:
> +               return "$INDEX_ROOT";
> +       case AT_EA_INFORMATION:
> +               return "$EA_INFORMATION";
> +       default:
> +               return NULL;
> +       }
> +}
> +
> +static bool ntfs_file_name_attr_value_is_valid(const u8 *value, const u3=
2 value_length)
> +{
> +       const struct file_name_attr *fn;
> +       u32 file_name_size;
> +
> +       if (value_length < ntfs_resident_attr_min_value_length(AT_FILE_NA=
ME))
> +               return false;
> +
> +       fn =3D (const struct file_name_attr *)value;
> +       file_name_size =3D fn->file_name_length * sizeof(__le16);
> +
> +       return file_name_size <=3D
> +                       value_length - offsetof(struct file_name_attr, fi=
le_name);
> +}
> +
> +struct ntfs_resident_attr_value {
> +       const u8 *data;
> +       u32 len;
> +};
> +
> +static bool ntfs_resident_attr_value_get(const struct attr_record *a,
> +                                        struct ntfs_resident_attr_value =
*value)
> +{
> +       u32 attr_len;
> +       u16 value_offset;
> +
> +       attr_len =3D le32_to_cpu(a->length);
> +       if (attr_len < offsetof(struct attr_record, data.resident.reserve=
d) +
> +                       sizeof(a->data.resident.reserved))
> +               return false;
> +
> +       value->len =3D le32_to_cpu(a->data.resident.value_length);
> +       value_offset =3D le16_to_cpu(a->data.resident.value_offset);
> +
> +       if (value->len > attr_len || value_offset > attr_len - value->len=
)
> +               return false;
> +
> +       value->data =3D (const u8 *)a + value_offset;
> +       return true;
> +}
> +
> +static bool ntfs_attr_value_is_valid(struct ntfs_volume *vol,
> +                                    const struct attr_record *a,
> +                                    const u64 mft_no)
> +{
> +       struct ntfs_resident_attr_value value;
> +       const char *type_name;
> +       u32 min_len;
> +
> +       if (a->non_resident) {
> +               if (a->type !=3D AT_FILE_NAME)
> +                       return true;
> +               ntfs_error(vol->sb,
> +                          "Corrupt non-resident $FILE_NAME attribute in =
MFT record %llu\n",
> +                          mft_no);
> +               return false;
> +       }
> +
> +       if (!ntfs_resident_attr_value_get(a, &value))
> +               goto corrupt;
> +
> +       min_len =3D ntfs_resident_attr_min_value_length(a->type);
> +       if (min_len && value.len < min_len)
> +               goto corrupt;
> +
> +       switch (a->type) {
> +       case AT_FILE_NAME:
> +               if (!ntfs_file_name_attr_value_is_valid(value.data, value=
.len))
> +                       goto corrupt;
> +               break;
> +       }
> +       return true;
> +
> +corrupt:
> +       type_name =3D ntfs_attr_type_name(a->type);
> +       if (type_name)
> +               ntfs_error(vol->sb,
> +                          "Corrupt resident %s attribute in MFT record %=
llu\n",
> +                          type_name, mft_no);
> +       else
> +               ntfs_error(vol->sb,
> +                          "Corrupt resident %#x attribute in MFT record =
%llu\n",
> +                          le32_to_cpu(a->type), mft_no);
> +       return false;
> +}
> +
>  /*
>   * ntfs_attr_find - find (next) attribute in mft record
>   * @type:      attribute type to find
> @@ -705,8 +811,11 @@ static int ntfs_attr_find(const __le32 type, const _=
_le16 *name,
>                         }
>                 }
>
> -               if (type =3D=3D AT_UNUSED)
> +               if (type =3D=3D AT_UNUSED) {
> +                       if (!ntfs_attr_value_is_valid(vol, a, ctx->ntfs_i=
no->mft_no))
> +                               break;
>                         return 0;
> +               }
>                 if (a->type !=3D type)
>                         continue;
>                 /*
> @@ -747,24 +856,11 @@ static int ntfs_attr_find(const __le32 type, const =
__le16 *name,
>                         }
>                 }
>
> -                /* Validate attribute's value offset/length */
> -               if (!a->non_resident) {
> -                       u32 min_len;
> -                       u32 value_length =3D le32_to_cpu(a->data.resident=
.value_length);
> -                       u16 value_offset =3D le16_to_cpu(a->data.resident=
.value_offset);
> -
> -                       if (value_length > le32_to_cpu(a->length) ||
> -                           value_offset > le32_to_cpu(a->length) - value=
_length)
> -                               break;
> +               if (!ntfs_attr_value_is_valid(vol, a, ctx->ntfs_ino->mft_=
no))
> +                       break;
>
> -                       min_len =3D ntfs_resident_attr_min_value_length(a=
->type);
> -                       if (min_len && value_length < min_len) {
> -                               ntfs_error(vol->sb,
> -                                          "Too small %#x resident attrib=
ute value in MFT record %lld\n",
> -                                          le32_to_cpu(a->type), (long lo=
ng)ctx->ntfs_ino->mft_no);
> -                               break;
> -                       }
> -               } else {
> +               /* Validate non-resident mapping-pairs fields. */
> +               if (a->non_resident) {

How about moving this validation into ntfs_attr_value_is_valid() as
well? The function name
suggests that it validates both resident and non-resident attributes,
and since the same
validation logic also exists in ntfs_attr_external_find(), moving it
would help prevent
duplication.


>                         u32 min_len;
>                         u16 mp_offset;
>
> @@ -1252,6 +1348,9 @@ static int ntfs_external_attr_find(const __le32 typ=
e,
>
>                 ctx->attr =3D a;
>
> +               if (!ntfs_attr_value_is_valid(vol, a, ctx->ntfs_ino->mft_=
no))
> +                       break;
> +
>                 if (a->non_resident) {
>                         u32 min_len;
>                         u16 mp_offset;
> @@ -1279,19 +1378,6 @@ static int ntfs_external_attr_find(const __le32 ty=
pe,
>                         u32 value_length =3D le32_to_cpu(a->data.resident=
.value_length);
>                         u16 value_offset =3D le16_to_cpu(a->data.resident=
.value_offset);
>
> -                       if (attr_len < offsetof(struct attr_record, data.=
resident.reserved) +
> -                                       sizeof(a->data.resident.reserved)=
)
> -                               break;
> -                       if (value_length > attr_len || value_offset > att=
r_len - value_length)
> -                               break;
> -
> -                       value_length =3D ntfs_resident_attr_min_value_len=
gth(a->type);
> -                       if (value_length && le32_to_cpu(a->data.resident.=
value_length) <
> -                           value_length) {
> -                               pr_err("Too small resident attribute valu=
e in MFT record %lld, type %#x\n",
> -                                      (long long)ctx->ntfs_ino->mft_no, =
a->type);
> -                               break;
> -                       }
>                         if (value_length =3D=3D val_len &&
>                             !memcmp((u8 *)a + value_offset, val, val_len)=
) {
>  attr_found:
> --
> 2.43.0



--=20
Thanks,
Hyunchul
