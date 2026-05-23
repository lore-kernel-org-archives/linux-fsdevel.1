Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0D930C606
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 May 2026 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779502291; cv=pass; b=VFp2kaW2IpNeS2cht7OFWoZam/l4rQcZGv7o45Qi3TPJK47EqqDw7NLGLzdgfjVo0QOB8ebnLfQYXg67UFg75AK4P8MdnxkgKsxyeYVgsbBzRmZAQ6h5rptZRxN8DRhdtYF72Qo/BX6iYlHa9dlaBa4Fw5HHihxDfzfo/phL6Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779502291; c=relaxed/simple;
	bh=2BusQ1p8q+/+AZA9nobsKbyZbvkqwFkC21hDvjIfExs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IgrHc4JGJehEPKpMEB8pdsZxkVBQ2YTV86abh6VCi6OYLBacDRkj3d+1kZgtlXbs81Xu8P2VGsivEMqxxhiZJ+clCO6g4nalTWclALWJIHQaupfWggqEOE18b3YZgab7aoXhZRbKyge61wDEnN3x77WMCR+rr+G+BM1e1fCapPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYY1DZsX; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYY1DZsX"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38e97e73234so69578671fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 19:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779502281; cv=none;
        d=google.com; s=arc-20240605;
        b=OOqRAyWWgerAqRAKEWwOewJoiADj7fGIWTdDYnfgP+6iUv7FOyQkqpWgppeRZz3ItW
         ZDtf6v+yzHBwLIHhb3ScHFS5O+0HIAKeSKlBb4tVQAlr62vPLZv6HNMaG1le6P9ybh5f
         y/CKro/PLZJue9m4wwPOBdaJ6wdiafPgbjxkX0vyDCK3Egd4uQ2k94z1dgb+O43JEuvp
         6S2A8sWtXHv+HzKiSqaJJvAJAxnLWsxysRc5DRSABZ+0/g9ZZJFSuQZx0WH99Dsn7gUP
         jYESWMoM9jOXlo/5SDLUcjQBK9qsXJYtmQ6EmzUSpRSPWkumsoF5ZfThoCT103Xwl7+j
         4S3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bS6MUbHIrr2Vda9jmMyx+5TcqvB8/lXXIl3GCma118Q=;
        fh=k8o9iRa2hqAkW+NRC/9pPMiY7W3wJ8BeQYQIvT9A+GY=;
        b=OzZahQruF7tc6KvayFjx/K91gro7N/Y9LYLPOztUW/vigrEOj78QlaP5iwaA79MF6t
         4KGpWZJzC5HKT1O9yAxln3PxgkdME2NNsFg5RyrcykCS6j8CdbSg038syCrbQxX2j+PX
         5LFENAfEeuxYMxeQ3cnP1U9y/mzjmVpYb9loSjJJtWskZ7x/fN2iZBD0lh8taUVK78pP
         Ylf75PU/4NR13lD3JrAf9g2TAIRAW7yqIP/UkQjGQUKqSZ8FJay+JtKION/EO0AvIOlt
         VGuRGUKDlMJhaemALn538AVcwhsF/ff2a5hEFMIQTzDGlRjhI4RJfsRv02OZmMYplGv2
         UhYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779502281; x=1780107081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS6MUbHIrr2Vda9jmMyx+5TcqvB8/lXXIl3GCma118Q=;
        b=TYY1DZsXZUsry79s05PdgHZyhanw9zu+66ORZ/NpvRlOdITUMaA1RX4X9K19747axO
         a3vQtJ+j6T0MEW545fcnaImVfJcPE1eMrJedpTwtV5lxAWu46s0XSUMPJRYJwMzTHX7K
         FADUMsfCSPWHHiuEq6n30rQECkfIJFAjTsPeQMIn1/efw+uzdgWpamnRXG1HuV2ka4Bd
         tMeMmoNfhWWrcfBeuXFDXtXzv6U48BZqqMEnDinJoQJBKHG38jSxHN/oZGQUVUBJwxeF
         NIPNnf/EXbda9jdTTITrtxTMlwE93OA9SG7i8I0hu5yymlBaEMCybwpN2RdSJE28nkvE
         VoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779502281; x=1780107081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bS6MUbHIrr2Vda9jmMyx+5TcqvB8/lXXIl3GCma118Q=;
        b=ILpFKLnC5ItZK1YWIeyMDm3Yh6vR8MVHQyUqcHj7mvgcuZ241aTtknjl76ieSLzELI
         plmDwqwUR4cGsPXpFCOcQFUY9V5UdxmQD9Zrk6yax18b3c8gNndu559VzDDYjkBhBxHS
         qhmIdDgrok6nmcgQ73d4GxZDdtEhE6KOcyxGKq1xT382sWaJbayVG28efeKbXNpeWWoe
         iKq62iB/h0X7mj5edFCVWOentzZxzc+VF4Pl7pWzuOn9OrVv3RKnIwGBfPMpHg/dlYaM
         MWtKaV+1OxJZgwkrNDTkxCBJp0Q+ocGeakQhL4VPETMjX3LIX9gjhNzbN8WXWNnvfIZN
         baOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8hhhbuYzpAlpeXE8i2GXY47aGsQ6yJ/1voY+LXyY9DOamYJSaNEwaWYtsdn1ZK6LJTtoAte3BXQZ17TzlG@vger.kernel.org
X-Gm-Message-State: AOJu0YxHfqLQZiIpO7tCfr6tz0nj7sNmZiBF0RLpZ3D0heVauDQOAsmx
	LWaKm9T5LxWLEh22ItkCfm1C8UVywLNiPFkm+WRvoRWYxa1lOX41QPwuDiVRJIDAk411jZPYq/2
	5sv2PejdXMeR9iP3zwtHVJIVqrkca39M=
X-Gm-Gg: Acq92OFzipvFr+ukTbLBy8CNV0znbpIC+a80CLcK5jFEOi6HrpKVwuAMMnFaI7CdDam
	95hn77+aY2Y8BxCCHtyqu9zh3DKQvhDJcmMqDD7o5sQ5PF51vcrSvHs6kZLSPDHDsh8I/6RBIDR
	NVm3HC8p9AuuZVdb67ZNKjY9LAG4q2trSpCJVFWHD/bfiqCbyS3NhDDBZNHOUfnkmuIxrkRwOFr
	Zue/3s7rWoKU2uuidvcz16o47E1AaQSCRzBSaHj4pxMwheWL/5w7bqSYwsGOpXIZg1mr6Ja1t1E
	O8wb0g2h8w==
X-Received: by 2002:a05:6512:66c6:20b0:5a8:fbe0:bc59 with SMTP id
 2adb3069b0e04-5aa323713femr1340424e87.26.1779502281145; Fri, 22 May 2026
 19:11:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522-t-fix-oob-v2-v1-0-0bea6582a361@gmail.com>
 <20260522-t-fix-oob-v2-v1-3-0bea6582a361@gmail.com> <CAMrLSE4EOf8zP23Dj=A4QJze+FgHRPm9GNr_+Of=KWEMRziX_Q@mail.gmail.com>
In-Reply-To: <CAMrLSE4EOf8zP23Dj=A4QJze+FgHRPm9GNr_+Of=KWEMRziX_Q@mail.gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Sat, 23 May 2026 11:11:09 +0900
X-Gm-Features: AVHnY4JkJwEkvA8K8QvCeAiMPgcP0ter4VwTwKKBqPrl8tskthG1Bca3uJapso8
Message-ID: <CANFS6bYhNG8YvBJds4wsmrwM-TZZ2dqkhU7HhtovQwqsunUB7w@mail.gmail.com>
Subject: Re: [PATCH 3/4] ntfs: validate index entries on reading
To: CharSyam <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 22=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 9:59, C=
harSyam <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi, Hyunchul.
>
>  One small thing =E2=80=94 the guard accepts an $INDEX_ROOT shorter than =
a full struct
> index_


root, so &ir->index can point at a 16-byte index_header that extends
> past the end of the resident value:
>
>         u32 value_length =3D le32_to_cpu(a->data.resident.value_length);
>
>         if (value_length < offsetof(struct index_root, index)) {
>                 ntfs_error(vol->sb, "$INDEX_ROOT in inode %llu is too sma=
ll.",
>                            (unsigned long long)inum);
>                 return -EIO;
>         }
>
>  It would be safer to compare against sizeof(struct index_root) instead, =
since
> that guarantees the full index_header lies within the value before
> ntfs_index_header_inconsistent() dereferences it:
>
>         if (value_length < sizeof(struct index_root)) {
>

The original intent was for ntfs_index_header_inconsistent() to validate th=
at
space is available before referencing index_header. However the current
accesses index_header fields before the validation. I will update the funct=
ion
to check the remaining space first as originally intended.

> Thanks.
> DaeMyung.
>
> 2026=EB=85=84 5=EC=9B=94 22=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 9:49,=
 Hyunchul Lee <hyc.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > Validate index entries immediately after reading an index root or index
> > block from disk. This eliminates repeated checks in lookup and readdir,
> > and reduce the risk of missing checks in those paths.
> >
> > Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> > ---
> >  fs/ntfs/dir.c   | 28 ++---------------
> >  fs/ntfs/index.c | 96 +++++++++++++++++++++++++++++++------------------=
--------
> >  fs/ntfs/index.h |  8 +++--
> >  fs/ntfs/inode.c |  8 +++--
> >  4 files changed, 66 insertions(+), 74 deletions(-)
> >
> > diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
> > index 6745a0e6e3e7..4b6bd5f30c65 100644
> > --- a/fs/ntfs/dir.c
> > +++ b/fs/ntfs/dir.c
> > @@ -135,10 +135,6 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *d=
ir_ni, const __le16 *uname,
> >                 /* Key length should not be zero if it is not last entr=
y. */
> >                 if (!ie->key_length)
> >                         goto dir_err_out;
> > -               /* Check the consistency of an index entry */
> > -               if (ntfs_index_entry_inconsistent(NULL, vol, ie, COLLAT=
ION_FILE_NAME,
> > -                               dir_ni->mft_no))
> > -                       goto dir_err_out;
> >                 /*
> >                  * We perform a case sensitive comparison and if that m=
atches
> >                  * we are done and return the mft reference of the inod=
e (i.e.
> > @@ -351,7 +347,8 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *di=
r_ni, const __le16 *uname,
> >         }
> >         err =3D ntfs_index_block_inconsistent(vol, ia,
> >                                             dir_ni->itype.index.block_s=
ize,
> > -                                           vcn, dir_ni->mft_no);
> > +                                           vcn, COLLATION_FILE_NAME,
> > +                                           dir_ni->mft_no);
> >         if (err)
> >                 goto unm_err_out;
> >         index_end =3D (u8 *)&ia->index + le32_to_cpu(ia->index.index_le=
ngth);
> > @@ -364,15 +361,6 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *d=
ir_ni, const __le16 *uname,
> >          * reach the last entry.
> >          */
> >         for (;; ie =3D (struct index_entry *)((u8 *)ie + le16_to_cpu(ie=
->length))) {
> > -               /* Bounds checks. */
> > -               if ((u8 *)ie < (u8 *)ia ||
> > -                   (u8 *)ie + sizeof(struct index_entry_header) > inde=
x_end ||
> > -                   (u8 *)ie + sizeof(struct index_entry_header) + le16=
_to_cpu(ie->key_length) >
> > -                               index_end || (u8 *)ie + le16_to_cpu(ie-=
>length) > index_end) {
> > -                       ntfs_error(sb, "Index entry out of bounds in di=
rectory inode 0x%llx.",
> > -                                       dir_ni->mft_no);
> > -                       goto unm_err_out;
> > -               }
> >                 /*
> >                  * The last entry cannot contain a name. It can however=
 contain
> >                  * a pointer to a child node in the B+tree so we just b=
reak out.
> > @@ -382,10 +370,6 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *d=
ir_ni, const __le16 *uname,
> >                 /* Key length should not be zero if it is not last entr=
y. */
> >                 if (!ie->key_length)
> >                         goto unm_err_out;
> > -               /* Check the consistency of an index entry */
> > -               if (ntfs_index_entry_inconsistent(NULL, vol, ie, COLLAT=
ION_FILE_NAME,
> > -                               dir_ni->mft_no))
> > -                       goto unm_err_out;
> >                 /*
> >                  * We perform a case sensitive comparison and if that m=
atches
> >                  * we are done and return the mft reference of the inod=
e (i.e.
> > @@ -868,6 +852,7 @@ static int ntfs_readdir(struct file *file, struct d=
ir_context *actor)
> >                 ictx->vcn_size_bits =3D vol->cluster_size_bits;
> >         else
> >                 ictx->vcn_size_bits =3D NTFS_BLOCK_SIZE_BITS;
> > +       ictx->cr =3D ir->collation_rule;
> >
> >         /* The first index entry. */
> >         next =3D (struct index_entry *)((u8 *)&ir->index +
> > @@ -905,13 +890,6 @@ static int ntfs_readdir(struct file *file, struct =
dir_context *actor)
> >                 if (!next)
> >                         break;
> >  nextdir:
> > -               /* Check the consistency of an index entry */
> > -               if (ntfs_index_entry_inconsistent(ictx, vol, next, COLL=
ATION_FILE_NAME,
> > -                                       ndir->mft_no)) {
> > -                       err =3D -EIO;
> > -                       goto out;
> > -               }
> > -
> >                 if (ie_pos < actor->pos) {
> >                         ie_pos +=3D le16_to_cpu(next->length);
> >                         continue;
> > diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
> > index 91fcaa79f8ac..456e195ca5c9 100644
> > --- a/fs/ntfs/index.c
> > +++ b/fs/ntfs/index.c
> > @@ -28,41 +28,10 @@
> >   * length must have been checked beforehand to not overflow from the
> >   * index record.
> >   */
> > -int ntfs_index_entry_inconsistent(struct ntfs_index_context *icx,
> > -               struct ntfs_volume *vol, const struct index_entry *ie,
> > -               __le32 collation_rule, u64 inum)
> > +static int ntfs_index_entry_inconsistent(const struct ntfs_volume *vol=
,
> > +                                        const struct index_entry *ie,
> > +                                        __le32 collation_rule, u64 inu=
m)
> >  {
> > -       if (icx) {
> > -               struct index_header *ih;
> > -               u8 *ie_start, *ie_end;
> > -
> > -               if (icx->is_in_root)
> > -                       ih =3D &icx->ir->index;
> > -               else
> > -                       ih =3D &icx->ib->index;
> > -
> > -               if ((le32_to_cpu(ih->index_length) > le32_to_cpu(ih->al=
located_size)) ||
> > -                               (le32_to_cpu(ih->index_length) > icx->b=
lock_size)) {
> > -                       ntfs_error(vol->sb, "%s Index entry(0x%p)'s len=
gth is too big.",
> > -                                       icx->is_in_root ? "Index root" =
: "Index block",
> > -                                       (u8 *)icx->entry);
> > -                       return -EINVAL;
> > -               }
> > -
> > -               ie_start =3D (u8 *)ih + le32_to_cpu(ih->entries_offset)=
;
> > -               ie_end =3D (u8 *)ih + le32_to_cpu(ih->index_length);
> > -
> > -               if (ie_start > (u8 *)ie ||
> > -                   ie_end <=3D (u8 *)ie + le16_to_cpu(ie->length) ||
> > -                   le16_to_cpu(ie->length) > le32_to_cpu(ih->allocated=
_size) ||
> > -                   le16_to_cpu(ie->length) > icx->block_size) {
> > -                       ntfs_error(vol->sb, "Index entry(0x%p) is out o=
f range from %s",
> > -                                       (u8 *)icx->entry,
> > -                                       icx->is_in_root ? "index root" =
: "index block");
> > -                       return -EIO;
> > -               }
> > -       }
> > -
> >         if (ie->key_length &&
> >             ((le16_to_cpu(ie->key_length) + offsetof(struct index_entry=
, key)) >
> >              le16_to_cpu(ie->length))) {
> > @@ -350,6 +319,44 @@ static int ntfs_index_header_inconsistent(struct n=
tfs_volume *vol,
> >         return 0;
> >  }
> >
> > +int ntfs_index_entries_inconsistent(const struct ntfs_volume *vol,
> > +                                   const struct index_header *ih,
> > +                                   __le32 collation_rule, u64 inum)
> > +{
> > +       struct index_entry *ie;
> > +       u8 *index_end =3D (u8 *)ih + le32_to_cpu(ih->index_length);
> > +
> > +       for (ie =3D ntfs_ie_get_first((struct index_header *)ih);
> > +             ; ie =3D ntfs_ie_get_next(ie)) {
> > +               if ((u8 *)ie + sizeof(struct index_entry_header) > inde=
x_end ||
> > +                   (u8 *)ie + le16_to_cpu(ie->length) > index_end) {
> > +                       ntfs_error(vol->sb,
> > +                                  "Index entry out of bounds in inode =
%llu.",
> > +                                  (unsigned long long)inum);
> > +                       return -EIO;
> > +               }
> > +
> > +               if (le16_to_cpu(ie->length) < sizeof(struct index_entry=
_header)) {
> > +                       ntfs_error(vol->sb,
> > +                                  "Index etnry too small in inode %llu=
.",
> > +                                  inum);
> > +                       return -EIO;
> > +               }
> > +
> > +               if (ntfs_ie_end(ie))
> > +                       break;
> > +
> > +               if (!ie->key_length)
> > +                       return -EIO;
> > +
> > +               if (ntfs_index_entry_inconsistent(vol, ie,
> > +                                                 collation_rule, inum)=
)
> > +                       return -EIO;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  /*
> >   *  Find the last entry in the index block
> >   */
> > @@ -501,7 +508,8 @@ static struct index_entry *ntfs_ie_dup_novcn(struct=
 index_entry *ie)
> >   */
> >  int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
> >                                   const struct index_block *ib,
> > -                                 u32 block_size, s64 vcn, u64 inum)
> > +                                 u32 block_size, s64 vcn, __le32 cr,
> > +                                 u64 inum)
> >  {
> >         u32 ib_size =3D (unsigned int)le32_to_cpu(ib->index.allocated_s=
ize) +
> >                 offsetof(struct index_block, index);
> > @@ -512,7 +520,7 @@ int ntfs_index_block_inconsistent(struct ntfs_volum=
e *vol,
> >         if (!ntfs_is_indx_record(ib->magic)) {
> >                 ntfs_error(sb, "Corrupt index block signature: vcn %lld=
 inode %llu\n",
> >                            vcn, (unsigned long long)inum);
> > -               return -1;
> > +               return -EIO;
> >         }
> >
> >         if (le64_to_cpu(ib->index_block_vcn) !=3D vcn) {
> > @@ -520,22 +528,23 @@ int ntfs_index_block_inconsistent(struct ntfs_vol=
ume *vol,
> >                         "Corrupt index block: s64 (%lld) is different f=
rom expected s64 (%lld) in inode %llu\n",
> >                         (long long)le64_to_cpu(ib->index_block_vcn),
> >                         vcn, inum);
> > -               return -1;
> > +               return -EIO;
> >         }
> >
> >         if (ib_size !=3D block_size) {
> >                 ntfs_error(sb,
> >                            "Corrupt index block : s64 (%lld) of inode %=
llu has a size (%u) differing from the index specified size (%u)\n",
> >                            vcn, inum, ib_size, block_size);
> > -               return -1;
> > +               return -EIO;
> >         }
> >
> >         if (ntfs_index_header_inconsistent(vol, &ib->index,
> >                                            block_size -
> >                                            offsetof(struct index_block,=
 index),
> >                                            inum))
> > -               return -1;
> > -
> > +               return -EIO;
> > +       if (ntfs_index_entries_inconsistent(vol, &ib->index, cr, inum))
> > +               return -EIO;
> >         return 0;
> >  }
> >
> > @@ -720,15 +729,14 @@ static int ntfs_ib_read(struct ntfs_index_context=
 *icx, s64 vcn, struct index_bl
> >                 else
> >                         ntfs_error(icx->idx_ni->vol->sb,
> >                                 "Failed to read full index block at %ll=
d\n", pos);
> > -               return -1;
> > +               return -EIO;
> >         }
> >
> >         post_read_mst_fixup((struct ntfs_record *)((u8 *)dst), icx->blo=
ck_size);
> >         if (ntfs_index_block_inconsistent(icx->idx_ni->vol, dst,
> > -                                         icx->block_size, vcn,
> > +                                         icx->block_size, vcn, icx->cr=
,
> >                                           icx->idx_ni->mft_no))
> > -               return -1;
> > -
> > +               return -EIO;
> >         return 0;
> >  }
> >
> > diff --git a/fs/ntfs/index.h b/fs/ntfs/index.h
> > index cad78568d8b3..9a03f53bba47 100644
> > --- a/fs/ntfs/index.h
> > +++ b/fs/ntfs/index.h
> > @@ -94,9 +94,11 @@ int ntfs_index_root_inconsistent(struct ntfs_volume =
*vol,
> >                                  const struct index_root *ir, u64 inum)=
;
> >  int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
> >                                   const struct index_block *ib,
> > -                                 u32 block_size, s64 vcn, u64 inum);
> > -int ntfs_index_entry_inconsistent(struct ntfs_index_context *icx, stru=
ct ntfs_volume *vol,
> > -               const struct index_entry *ie, __le32 collation_rule, u6=
4 inum);
> > +                                 u32 block_size, s64 vcn,
> > +                                 __le32 cr, u64 inum);
> > +int ntfs_index_entries_inconsistent(const struct ntfs_volume *vol,
> > +                                   const struct index_header *ih,
> > +                                   __le32 collation_rule, u64 inum);
> >  struct ntfs_index_context *ntfs_index_ctx_get(struct ntfs_inode *ni, _=
_le16 *name,
> >                 u32 name_len);
> >  void ntfs_index_ctx_put(struct ntfs_index_context *ictx);
> > diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> > index 63ee7acff4fc..9717fb5b4709 100644
> > --- a/fs/ntfs/inode.c
> > +++ b/fs/ntfs/inode.c
> > @@ -939,7 +939,9 @@ static int ntfs_read_locked_inode(struct inode *vi)
> >                 }
> >                 ir =3D (struct index_root *)((u8 *)a +
> >                                 le16_to_cpu(a->data.resident.value_offs=
et));
> > -               if (ntfs_index_root_inconsistent(ni->vol, a, ir, ni->mf=
t_no)) {
> > +               if (ntfs_index_root_inconsistent(ni->vol, a, ir, ni->mf=
t_no) ||
> > +                   ntfs_index_entries_inconsistent(ni->vol, &ir->index=
,
> > +                                                   ir->collation_rule,=
 ni->mft_no)) {
> >                         ntfs_error(vi->i_sb, "Directory index is corrup=
t.");
> >                         goto unm_err_out;
> >                 }
> > @@ -1529,7 +1531,9 @@ static int ntfs_read_locked_index_inode(struct in=
ode *base_vi, struct inode *vi)
> >         }
> >
> >         ir =3D (struct index_root *)((u8 *)a + le16_to_cpu(a->data.resi=
dent.value_offset));
> > -       if (ntfs_index_root_inconsistent(vol, a, ir, ni->mft_no)) {
> > +       if (ntfs_index_root_inconsistent(vol, a, ir, ni->mft_no) ||
> > +           ntfs_index_entries_inconsistent(vol, &ir->index,
> > +                                           ir->collation_rule, ni->mft=
_no)) {
> >                 ntfs_error(vi->i_sb, "Index is corrupt.");
> >                 goto unm_err_out;
> >         }
> >
> > --
> > 2.43.0
> >
> >



--
Thanks,
Hyunchul
