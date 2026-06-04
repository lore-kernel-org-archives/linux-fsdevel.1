Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C117F3EC2CD
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562476; cv=pass; b=Zjv6sXnTfrvx34IVGeKeiSj/Obc0PMYG9bvYW6lNn+Yk7CMxBthQvPPg9n6VXCFAl01voSTOXxf4zbiIaOskGUPZBrxZJfRvisg9CbY1DVUvekM9i1Yrbg+ywfOTmwq0Qe/bLxvSsvIDdgJQLcccU+eJUFYBadXjrFw4iNzggO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562476; c=relaxed/simple;
	bh=pgmx0v+odpk29qPyR2GrqAZWsXP9XpZ9yANYwkysBsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MAGXLseNBvmRbr5YBb057B9GzN/+b3ygA3MtG4TJ7Bgtm9UH8X/ao7zeXY5FownTJX7Sxf4xeXdaqoqfKYxrRaqJtyf7qyc6pO06eRLLZTrI9gYDE4aamctymQ4uq+DoCnTh+B7ZlyxasWUZVzP0uukRrk4A8ZUyVtkX89H4spg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jx1D746v; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jx1D746v"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa68cfc182so404570e87.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 01:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780562465; cv=none;
        d=google.com; s=arc-20240605;
        b=cjD5tYigStoRxWCIkQRfL+1zfOe3b839xO8wGH0NlljLBGl6nbEG9KlpKbGpUE7XVE
         CU8M4eUHk0cMySrchyEr15ZF4w9VIu9DnobT/Zd01FwfGSY1pLQFpPMNDcnjl1gbeFpv
         CrgQ/1BTlcvsucYxincJYvi+vv72VDr3xprbSXnGnx7o7gtz8Ao/NtPIZCse4sMgD09m
         B2tFNrL8lki577mtHfuM/qrdgKGCXNo+zHzXe1B4iJaFib4zHld2rB8/12pV/xXQiiXo
         oJSTIgnmbCKZjwsXpyIo9iWZaJJtJJc0xNf5Ff66kCVy2B8rflKb+8e6gre87VYMd5AO
         l3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QHJHdlrZdXLPBwonyAdzL1YoGeEE5jwoAU66v8GzKr4=;
        fh=DvWvp1m3MM+2FZ7f2PH1FlbB17atGvf2OC6vrhoSiTA=;
        b=G6eyvpjOVg5+h7xgT+uvPYyl+QdSI520HhkRjM/pfmSOgHK+dlo+EvcQlMEG0TLuN6
         GUHgNBlBamZRbO8BThSw41bwM8AvfDjQXTmcGk3+8fZvi154hFbI7YEGAcj609/f7yie
         WqSmNyydccqBRUuJ7Y6EigY6bc5BU/yva3RxuAsJBJakxA0hFr2k10XLxTLuK7e9Lhjn
         S/ADjY+vMbKUq+UshbT4lIPaavuNtVmxqWB96Xc92yj38fyi5iLrfjWr/PLgO+jrrVH0
         Tw/16EnFPKXO2bpuSl6cxXIBn84agsZ2GTQaJHLOxsex/n/pCJJCCKHo15DumHzDVDbI
         Ltpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780562465; x=1781167265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHJHdlrZdXLPBwonyAdzL1YoGeEE5jwoAU66v8GzKr4=;
        b=jx1D746vuCRbg6Z9aw2+hgozQ9a8qw6p13zZZ2IWwhn/JeDBSVsE1bXYht5WcvwvqJ
         45ytW94gGrtr7HNFPYmMH+pry7R+LEo5DBFIbNEOsOTm7ZLJfDSqpPOQguu0+dyuytAi
         CNWK3c8cu78L6eZQPF3lxQ2BH3SEyO49k38QjIdhyjJPHkfqXXnF7qY+MLoLdJVEf4Hl
         doJy6re54/VBgx4qs9dgC6ZFZgDKz2cdChUv4U6vmMewpTuA/x6YV09onG9edg64D+6i
         zMpi/2FRlwPsRcIXVLmzzvG1isGwFI5lSuxI/H8YvrEtQRwvnAW26c0OIBKyrM1Btn1g
         ZEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780562465; x=1781167265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QHJHdlrZdXLPBwonyAdzL1YoGeEE5jwoAU66v8GzKr4=;
        b=sYgdorpCGqKFaolagXri7PxJF/8uR3dV75En91vrYEIJ7fSfGAvddU/mMITTshese4
         iE7yxEmAOu9tSk2C90ciw0McUTEXE+C1kmY7DMzlSbXwaSFPRzsuZdpUzxOD2P9eL1s6
         TswKPYwGlAyCoUe9L/GBR1h2D0SKhEKvwDaBfPkzdCZ/ZZs7FmL+NVZb/0PL4AFwmRhO
         hYwVWe4Rwd0NE40/YeWYNmiSKRU1scepQ2lJKBESfEWhPu0RQOARFwd163fLYD9TgICZ
         29j33fHWECel5rt41vUS305382iOLjrzzbSJ3wH1Y4RKWpRAZLJiS4iqyUyaLOz0kGdP
         tYfA==
X-Forwarded-Encrypted: i=1; AFNElJ9tlropT2nmX1rCV3gtQRUFOeOQQEnKCdyh8Foe10KewlTIz1QSUTon+xXgxr6gWh/LV5GErGFd2pbrnupx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2iUepG0+D879f/pPdwJHaZy/YlE6XejPHmCU+Oerq3Pm/C099
	QrWlfX9YcftoCOx3BbglRyY8D5QwZQhXjouO/4LZzKjvm8aVt3tvV2M1+hk06Zpb9CCp1AojolN
	ReIH05LN7XibhlnMJXwvhaMxl2DNkLkA=
X-Gm-Gg: Acq92OGurXiGTgwKNGnmbchsvzkMLyNSjiGLRG5miMryto84YS2ibYDs2O15jwZ+5LL
	vUvL0vjgB2F5atZPam1Ocd3+GEMuDPpg+l6nMIvJrzq05FMDf/jiXhbWkc+uPHVPaxK0la2s0lD
	NarWkuom8sVT/ZDYBHgngCMhR1DCpBEJPJo4cYc9yJFkFc1JcwyTfdH3nlXsJzwQvAyniSo0Rdx
	GOlj6JUnGxmRyf5vdQOGkrphTaS/ica+Mkj50AULjBRpVIq2zW0fr4KeIWPws9J5v1cBOFeb1A0
	ByC0sTkM9tucz81aozCvYy33hEZp
X-Received: by 2002:a05:6512:124c:b0:5a8:f03b:a406 with SMTP id
 2adb3069b0e04-5aa7c05b93cmr2232698e87.16.1780562464388; Thu, 04 Jun 2026
 01:41:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603175949.11665-1-hexlabsecurity@proton.me> <20260604042912.89893-1-hexlabsecurity@proton.me>
In-Reply-To: <20260604042912.89893-1-hexlabsecurity@proton.me>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 4 Jun 2026 17:40:52 +0900
X-Gm-Features: AVVi8CfB1EAH34cq1TSzBOlo7L5_EeVGnSMZvbfsXjufUqKkXiileVmu4DYiSSw
Message-ID: <CANFS6bYN8GUa_0o8sncvOC0z_4XgUjTsObUr0DxBdWEhEDxGNA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ntfs: validate resident attribute lists and harden
 the validator
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 6=EC=9B=94 4=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 1:29, Br=
yam Vargas <hexlabsecurity@proton.me>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> A base inode's $ATTRIBUTE_LIST is sanity-checked by load_attribute_list()
> only on the non-resident path; ntfs_read_locked_inode() copies a *residen=
t*
> attribute list into ni->attr_list with a plain memcpy() and no validation
> at all. Every subsequent walk of ni->attr_list --
> ntfs_external_attr_find(), ntfs_inode_attach_all_extents() and
> ntfs_attrlist_need() -- then trusts the entries are well-formed and reads
> attr_list_entry fixed-header fields
> (lowest_vcn at offset 8, mft_reference at offset 16, and the name) with
> bounds that assume validation already happened. A crafted resident
> attribute list therefore reaches those walks unvalidated and can drive
> out-of-bounds reads of the attribute-list buffer.
>
> load_attribute_list() itself reads ale->name_offset (offset 7),
> ale->mft_reference (offset 16) and the name length under only an
> "al < al_start + size" bound, so its own validation loop can over-read th=
e
> fixed header of a truncated trailing entry by a few bytes.
>
> Factor the per-entry validation into ntfs_attr_list_entry_is_valid(),
> which requires each entry's fixed header (offsetof(struct
> attr_list_entry, name)) to be in range before any field is dereferenced,
> that ale->length is a multiple of 8 covering the fixed header plus the
> name, and that the entry is in use and carries a live MFT reference.
> ntfs_attr_list_is_valid() walks the buffer with it and checks the entries
> tile it exactly. Use the list validator in load_attribute_list()
> (replacing the open-coded loop, closing its own over-read) and on the
> resident path in ntfs_read_locked_inode() (which previously skipped
> validation entirely); patches 2/3 reuse the per-entry helper at the other
> two attribute-list walks.
>
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
> v3 (Hyunchul Lee review):
>  - Split the per-entry check into ntfs_attr_list_entry_is_valid() and cal=
l it
>    from the whole series (this patch's list walk, the look-ahead in 2/3 a=
nd
>    the $MFT walk in 3/3).
>  - Require ale->length to be a multiple of 8 (on-disk attribute-list entr=
ies
>    are 8-byte aligned).
> v2: dropped the redundant Reported-by; reproducer omitted on the public l=
ist
>    (available to the maintainers on request).
>
> The out-of-bounds reads were confirmed under KASAN on the earlier revisio=
n
> (crafted NTFS image, fs/ntfs built as a module): the crafted attribute li=
st
> that oopsed ntfs_external_attr_find() is now rejected at load with
> "ntfs_read_locked_inode(): Corrupt attribute list." and a benign mkntfs
> image still mounts. The validator is arch-independent -- struct
> attr_list_entry is __packed, so sizeof() =3D=3D offsetof(.., name) =3D=3D=
 26 and
> every field offset (length 4, lowest_vcn 8, mft_reference 16) is identica=
l
> built -m32 and -m64; a clean-room model of this v3 validator decides ever=
y
> benign/crafted vector the same way on both ABIs, including the new
> 8-byte-alignment rejection. checkpatch clean.
>
>  fs/ntfs/attrib.c | 78 ++++++++++++++++++++++++++++++++++++++----------
>  fs/ntfs/attrib.h |  4 +++
>  fs/ntfs/inode.c  |  6 ++++
>  3 files changed, 73 insertions(+), 15 deletions(-)
>
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 421c6cdcbb53..abc0add6f0c4 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -843,11 +843,71 @@ char *ntfs_attr_name_get(const struct ntfs_volume *=
vol, const __le16 *uname,
>         return NULL;
>  }
>
> +/*
> + * ntfs_attr_list_entry_is_valid - sanity check one $ATTRIBUTE_LIST entr=
y
> + * @ale:       the attribute-list entry to check
> + * @al_end:    end of the attribute-list buffer @ale lives in
> + *
> + * Verify that @ale is a well-formed attr_list_entry wholly contained in
> + * [.., @al_end): its fixed header must lie in range before any field is
> + * dereferenced, its length must be a multiple of 8 that covers the fixe=
d
> + * header plus the name, the name must lie within the buffer, the entry =
must
> + * be in use and carry a live MFT reference.  Return true if valid.
> + */
> +bool ntfs_attr_list_entry_is_valid(const struct attr_list_entry *ale,
> +                                  const u8 *al_end)
> +{
> +       const u8 *al =3D (const u8 *)ale;
> +       u16 ale_len;
> +
> +       /* The fixed header must be in bounds before it is parsed. */
> +       if (al + offsetof(struct attr_list_entry, name) > al_end)
> +               return false;
> +       ale_len =3D le16_to_cpu(ale->length);
> +       /* On-disk entries are 8-byte aligned (see struct attr_list_entry=
). */
> +       if (ale_len & 7)
> +               return false;
> +       if (ale->name_offset !=3D sizeof(struct attr_list_entry))
> +               return false;
> +       if ((u32)ale->name_offset +
> +           (u32)ale->name_length * sizeof(__le16) > ale_len ||
> +           al + ale_len > al_end)
> +               return false;
> +       if (ale->type =3D=3D AT_UNUSED)
> +               return false;
> +       if (MSEQNO_LE(ale->mft_reference) =3D=3D 0)
> +               return false;
> +       return true;
> +}
> +
> +/*
> + * ntfs_attr_list_is_valid - sanity check an in-memory $ATTRIBUTE_LIST
> + * @al_start:  start of the attribute list buffer
> + * @size:      length of the attribute list in bytes
> + *
> + * Verify that [@al_start, @al_start + @size) is a sequence of valid
> + * attr_list_entry records (see ntfs_attr_list_entry_is_valid()) that ti=
le the
> + * buffer exactly.  Return true if valid, false otherwise.
> + */
> +bool ntfs_attr_list_is_valid(const u8 *al_start, s64 size)
> +{
> +       const u8 *al =3D al_start;
> +       const u8 *al_end =3D al_start + size;
> +
> +       while (al < al_end) {
> +               const struct attr_list_entry *ale =3D
> +                               (const struct attr_list_entry *)al;
> +
> +               if (!ntfs_attr_list_entry_is_valid(ale, al_end))
> +                       return false;
> +               al +=3D le16_to_cpu(ale->length);
> +       }
> +       return al =3D=3D al_end;
> +}
> +
>  int load_attribute_list(struct ntfs_inode *base_ni, u8 *al_start, const =
s64 size)
>  {
>         struct inode *attr_vi =3D NULL;
> -       u8 *al;
> -       struct attr_list_entry *ale;
>
>         if (!al_start || size <=3D 0)
>                 return -EINVAL;
> @@ -869,19 +929,7 @@ int load_attribute_list(struct ntfs_inode *base_ni, =
u8 *al_start, const s64 size
>         }
>         iput(attr_vi);
>
> -       for (al =3D al_start; al < al_start + size; al +=3D le16_to_cpu(a=
le->length)) {
> -               ale =3D (struct attr_list_entry *)al;
> -               if (ale->name_offset !=3D sizeof(struct attr_list_entry))
> -                       break;
> -               if (le16_to_cpu(ale->length) <=3D ale->name_offset + ale-=
>name_length ||
> -                   al + le16_to_cpu(ale->length) > al_start + size)
> -                       break;
> -               if (ale->type =3D=3D AT_UNUSED)
> -                       break;
> -               if (MSEQNO_LE(ale->mft_reference) =3D=3D 0)
> -                       break;
> -       }
> -       if (al !=3D al_start + size) {
> +       if (!ntfs_attr_list_is_valid(al_start, size)) {
>                 ntfs_error(base_ni->vol->sb, "Corrupt attribute list, mft=
 =3D %llu",
>                            base_ni->mft_no);
>                 return -EIO;
> diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
> index f7acc7986b09..e2224fbfaabe 100644
> --- a/fs/ntfs/attrib.h
> +++ b/fs/ntfs/attrib.h
> @@ -71,6 +71,10 @@ int ntfs_attr_lookup(const __le32 type, const __le16 *=
name,
>                 const u32 name_len, const u32 ic,
>                 const s64 lowest_vcn, const u8 *val, const u32 val_len,
>                 struct ntfs_attr_search_ctx *ctx);
> +bool ntfs_attr_list_entry_is_valid(const struct attr_list_entry *ale,
> +                                  const u8 *al_end);
> +bool ntfs_attr_list_is_valid(const u8 *al_start, s64 size);
> +
>  int load_attribute_list(struct ntfs_inode *base_ni,
>                                u8 *al_start, const s64 size);
>
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index 360bebd1ee3f..a5f7400fd19d 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -848,6 +848,12 @@ static int ntfs_read_locked_inode(struct inode *vi)
>                                         a->data.resident.value_offset),
>                                         le32_to_cpu(
>                                         a->data.resident.value_length));
> +                       /* A resident list is not validated on load; chec=
k it now. */
> +                       if (!ntfs_attr_list_is_valid(ni->attr_list,
> +                                                    ni->attr_list_size))=
 {
> +                               ntfs_error(vi->i_sb, "Corrupt attribute l=
ist.");
> +                               goto unm_err_out;
> +                       }
>                 }
>         }
>  skip_attr_list_load:
> --
> 2.43.0
>
>


--=20
Thanks,
Hyunchul
