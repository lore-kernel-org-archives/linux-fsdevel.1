Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CA737F8C3
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454755; cv=pass; b=rv9YO9hYyFhQ2F39jgEdfk+k84JgGKW3okVgsnzN2W3vTxabsJq2xhfToJOTIT6gByU0yIvw4q2fW6nGQsQP+sUFMfcUlU7lri+nF5LF0EhkNf71eZiYzISl0CABOY5KQRZjAY+Fz6oFLnV4x/HO6j3J0jTC4Z6pCUEVVX5YHSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454755; c=relaxed/simple;
	bh=fitumPNeVR5c90ndeIeXnj0JrsdnjExV8LeicUspVEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFDs7mjKECpJY9CM5gp6ROBEBwqZ2sMC0Qg+EoU9KiaIYC1OXxGy4lqxqsIOxXCUcYmmB35bkdbPWpPMLy+4b5Sa9CNN1bJIib/hgd+dVcvplSGg2yTX2aUo1Nuy8FJ6Y12nVd/vbxCykdiNoimpduBF0s4NCFzoCGDN2ZoSJsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZmU2s1zX; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmU2s1zX"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-65c2428c49eso440340d50.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 05:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779454753; cv=none;
        d=google.com; s=arc-20240605;
        b=XvPtVyG/l98V1sK8cJ6/n1nW9e2FstSP2lYKJWOmrPY4MyZ8Z6ZaIJufzWqBAg80Ck
         Sxkna5LZYKSYWdflK5xquc47EEjFZhtLLU3NWWfuwaa8jnPrJYqZm7vpwXWGJHKmLYIW
         7w/oaE87DS22+Y1aZvkf6ODwkrqRii9xbx4+iaJ+ZQYx0iDZb/9TwU+mSKBnfzOOzaGQ
         ZCpGahdU0MW6ZAkuEJkiOe7MLVGCCSCnku/IHeQzzoD8NcsFZgv/IEzXbidMOCGMAuPv
         BrzI0FUGcQwkYVQeOsNZ7H6qDkFBfdO3jBsqmBhekXj16xNI/0da3Tk+rUXJrZ7lHLzb
         Awew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3lEVyRKYYLDAsHKUWyzAeGTuVIfw8ALESeN4p2DNEE0=;
        fh=N7fr/d3NRGXJOWKMl5WpQQaR5QLH8sU85K4NNmYnuC8=;
        b=QECD6r4WSM35PREvKUy+7jiFEDhVVN4PQ51u/nRUMO4oLmdMnw6Qj3yQ0JgL+HoyEe
         k/04oGUm3wu8D1wpZpzga6mZKqW5w62NoKjseIxWxpQPmVp2xp/d+nYcK/AIQoqVuCkZ
         9MO+X64Xtl/wC2ySHngr2rjn2dqDxt3Rgugp1d7Iw0GFOD8GUNgFX+Fi0DBByIoLTcnd
         7XY/N2qiDPG9raoANwHWqZ6XUNsfFisbIctewXAnEFHygZN1xufE1HU/sNz593zO4UNO
         QJezGuIV9oQvHrE3vHSeFGnxp3J6FdikIaebb0ik2Vuc77yWzs8duoS21btbQUxyLfjo
         JD/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779454753; x=1780059553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3lEVyRKYYLDAsHKUWyzAeGTuVIfw8ALESeN4p2DNEE0=;
        b=ZmU2s1zX+pKgivgaJ9+NWbAAXn56bnHVRZppaKQqYR1EHQ1ZdkLGoakprRuyLLP+j6
         pT5EHIDXOTXLZXJvsiq0DqA0ynlqy987Kkpi46OLmrUAo7E/QePrO83WcwjVF/NB6nuJ
         LnXNLVJywOah+Uq7RBjT95UnvAdzbP0CwKiQuTpCD1fvcpjryY3qsbUBkN0dsg0KmnuJ
         RHlmFP5L6xJcCG0mWKhTZWKxNhe6FUw6T7ObbwJUhQ7t55YLZznR7IpI137hOsjsjJtK
         HTi7gQWHlKwYmzl5fbCjmm0VYE6QUj5KBSdqcojIqF3y6Dhr9GLo08+ldieZO1KIhsoB
         PL7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779454753; x=1780059553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3lEVyRKYYLDAsHKUWyzAeGTuVIfw8ALESeN4p2DNEE0=;
        b=ODegXzVOxfiOzo1uKnL/bDWM1mF1E6nizJVNP3VP3YFNy4Z2Kgy9zzb9Rb883+TCXd
         ho2F7SFsonImeF34LN5pe+0xPL6sRg3JuvppPmZ4q3950sAfyn+SfOMir6sUCsechbVa
         eH+X4ic3tCHVZ364o/sSCI6PDD2AWbrhs4BpK/GVOXX5TJfL0PfW4l8LJ/crQk6SrQob
         N0s+ctiQyTUlyfEmgym8ymid3R5RUtxCxN4GtPzB4gWPvoZToAhRhOqcGtHUqalUB/xW
         bDX5ba8iH44lW34GnmW1U7wqQeSTrfQaOAedTvcaMMTwFnc4iyQBZ+G0GHl1uzCb5wtQ
         afmw==
X-Forwarded-Encrypted: i=1; AFNElJ9YPp3sczxqAQ98MuuRpBXY82p+k2Yq+UvG0icTCKS7TUMh1OS+tqfFdVlRFGdEJk6J8krxG4K/LvO5wsle@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5CgOpMTEeHFFAd59W/6Jj8dR94bCNuufLMsro+VrB6d4iFLYw
	yGJsogSSjNRM6ixFNY96hruveafehJ5xt2QRM/nF7ahnaqsoLyUQyUB/V5NaH10jw/hpDB73D3h
	BVfAjyXxVcICp8y5FsS/5+y8x+BwjUcI=
X-Gm-Gg: Acq92OHK/KqHd9ye0LX5dj/Og+0KJpBoTp9WDYcS+3TM5wM2iIz86x8prIlP8QvNX1P
	cqGnTgjJgvWTs86jnd4qZJhjMCOxs4wUarixQOt6js/GUDLk8csw4hBUjWM3GSXc5650L9wcMQc
	FnJwYXbBklSkeDqKpcWo9CHAIb5onBin4Cp+BQF/y4Go09uDP4FSL995vI0vUE7fFad+2opmrgr
	S1BeBY5ulQx0Dnd9yvSfz2HUk1VqlJnnmepWEz1yvSyPpfoM/eAt9TEIWw+phv9nKcUM96YvHhF
	ioFVzKKorDY43ll8/w==
X-Received: by 2002:a05:690e:4803:b0:65e:5342:514f with SMTP id
 956f58d0204a3-65ec99730eamr1643778d50.6.1779454752690; Fri, 22 May 2026
 05:59:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522-t-fix-oob-v2-v1-0-0bea6582a361@gmail.com> <20260522-t-fix-oob-v2-v1-3-0bea6582a361@gmail.com>
In-Reply-To: <20260522-t-fix-oob-v2-v1-3-0bea6582a361@gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Fri, 22 May 2026 21:59:01 +0900
X-Gm-Features: AVHnY4KnrQr1LOckDG-60STqDdzmrjJH_JU_kCs-lMis6Ez7awUYZXVzMt6zbSY
Message-ID: <CAMrLSE4EOf8zP23Dj=A4QJze+FgHRPm9GNr_+Of=KWEMRziX_Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] ntfs: validate index entries on reading
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hyunchul.

 One small thing =E2=80=94 the guard accepts an $INDEX_ROOT shorter than a =
full struct
index_root, so &ir->index can point at a 16-byte index_header that extends
past the end of the resident value:

        u32 value_length =3D le32_to_cpu(a->data.resident.value_length);

        if (value_length < offsetof(struct index_root, index)) {
                ntfs_error(vol->sb, "$INDEX_ROOT in inode %llu is too small=
.",
                           (unsigned long long)inum);
                return -EIO;
        }

 It would be safer to compare against sizeof(struct index_root) instead, si=
nce
that guarantees the full index_header lies within the value before
ntfs_index_header_inconsistent() dereferences it:

        if (value_length < sizeof(struct index_root)) {

Thanks.
DaeMyung.

2026=EB=85=84 5=EC=9B=94 22=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 9:49, H=
yunchul Lee <hyc.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Validate index entries immediately after reading an index root or index
> block from disk. This eliminates repeated checks in lookup and readdir,
> and reduce the risk of missing checks in those paths.
>
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> ---
>  fs/ntfs/dir.c   | 28 ++---------------
>  fs/ntfs/index.c | 96 +++++++++++++++++++++++++++++++--------------------=
------
>  fs/ntfs/index.h |  8 +++--
>  fs/ntfs/inode.c |  8 +++--
>  4 files changed, 66 insertions(+), 74 deletions(-)
>
> diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
> index 6745a0e6e3e7..4b6bd5f30c65 100644
> --- a/fs/ntfs/dir.c
> +++ b/fs/ntfs/dir.c
> @@ -135,10 +135,6 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir=
_ni, const __le16 *uname,
>                 /* Key length should not be zero if it is not last entry.=
 */
>                 if (!ie->key_length)
>                         goto dir_err_out;
> -               /* Check the consistency of an index entry */
> -               if (ntfs_index_entry_inconsistent(NULL, vol, ie, COLLATIO=
N_FILE_NAME,
> -                               dir_ni->mft_no))
> -                       goto dir_err_out;
>                 /*
>                  * We perform a case sensitive comparison and if that mat=
ches
>                  * we are done and return the mft reference of the inode =
(i.e.
> @@ -351,7 +347,8 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir_=
ni, const __le16 *uname,
>         }
>         err =3D ntfs_index_block_inconsistent(vol, ia,
>                                             dir_ni->itype.index.block_siz=
e,
> -                                           vcn, dir_ni->mft_no);
> +                                           vcn, COLLATION_FILE_NAME,
> +                                           dir_ni->mft_no);
>         if (err)
>                 goto unm_err_out;
>         index_end =3D (u8 *)&ia->index + le32_to_cpu(ia->index.index_leng=
th);
> @@ -364,15 +361,6 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir=
_ni, const __le16 *uname,
>          * reach the last entry.
>          */
>         for (;; ie =3D (struct index_entry *)((u8 *)ie + le16_to_cpu(ie->=
length))) {
> -               /* Bounds checks. */
> -               if ((u8 *)ie < (u8 *)ia ||
> -                   (u8 *)ie + sizeof(struct index_entry_header) > index_=
end ||
> -                   (u8 *)ie + sizeof(struct index_entry_header) + le16_t=
o_cpu(ie->key_length) >
> -                               index_end || (u8 *)ie + le16_to_cpu(ie->l=
ength) > index_end) {
> -                       ntfs_error(sb, "Index entry out of bounds in dire=
ctory inode 0x%llx.",
> -                                       dir_ni->mft_no);
> -                       goto unm_err_out;
> -               }
>                 /*
>                  * The last entry cannot contain a name. It can however c=
ontain
>                  * a pointer to a child node in the B+tree so we just bre=
ak out.
> @@ -382,10 +370,6 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir=
_ni, const __le16 *uname,
>                 /* Key length should not be zero if it is not last entry.=
 */
>                 if (!ie->key_length)
>                         goto unm_err_out;
> -               /* Check the consistency of an index entry */
> -               if (ntfs_index_entry_inconsistent(NULL, vol, ie, COLLATIO=
N_FILE_NAME,
> -                               dir_ni->mft_no))
> -                       goto unm_err_out;
>                 /*
>                  * We perform a case sensitive comparison and if that mat=
ches
>                  * we are done and return the mft reference of the inode =
(i.e.
> @@ -868,6 +852,7 @@ static int ntfs_readdir(struct file *file, struct dir=
_context *actor)
>                 ictx->vcn_size_bits =3D vol->cluster_size_bits;
>         else
>                 ictx->vcn_size_bits =3D NTFS_BLOCK_SIZE_BITS;
> +       ictx->cr =3D ir->collation_rule;
>
>         /* The first index entry. */
>         next =3D (struct index_entry *)((u8 *)&ir->index +
> @@ -905,13 +890,6 @@ static int ntfs_readdir(struct file *file, struct di=
r_context *actor)
>                 if (!next)
>                         break;
>  nextdir:
> -               /* Check the consistency of an index entry */
> -               if (ntfs_index_entry_inconsistent(ictx, vol, next, COLLAT=
ION_FILE_NAME,
> -                                       ndir->mft_no)) {
> -                       err =3D -EIO;
> -                       goto out;
> -               }
> -
>                 if (ie_pos < actor->pos) {
>                         ie_pos +=3D le16_to_cpu(next->length);
>                         continue;
> diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
> index 91fcaa79f8ac..456e195ca5c9 100644
> --- a/fs/ntfs/index.c
> +++ b/fs/ntfs/index.c
> @@ -28,41 +28,10 @@
>   * length must have been checked beforehand to not overflow from the
>   * index record.
>   */
> -int ntfs_index_entry_inconsistent(struct ntfs_index_context *icx,
> -               struct ntfs_volume *vol, const struct index_entry *ie,
> -               __le32 collation_rule, u64 inum)
> +static int ntfs_index_entry_inconsistent(const struct ntfs_volume *vol,
> +                                        const struct index_entry *ie,
> +                                        __le32 collation_rule, u64 inum)
>  {
> -       if (icx) {
> -               struct index_header *ih;
> -               u8 *ie_start, *ie_end;
> -
> -               if (icx->is_in_root)
> -                       ih =3D &icx->ir->index;
> -               else
> -                       ih =3D &icx->ib->index;
> -
> -               if ((le32_to_cpu(ih->index_length) > le32_to_cpu(ih->allo=
cated_size)) ||
> -                               (le32_to_cpu(ih->index_length) > icx->blo=
ck_size)) {
> -                       ntfs_error(vol->sb, "%s Index entry(0x%p)'s lengt=
h is too big.",
> -                                       icx->is_in_root ? "Index root" : =
"Index block",
> -                                       (u8 *)icx->entry);
> -                       return -EINVAL;
> -               }
> -
> -               ie_start =3D (u8 *)ih + le32_to_cpu(ih->entries_offset);
> -               ie_end =3D (u8 *)ih + le32_to_cpu(ih->index_length);
> -
> -               if (ie_start > (u8 *)ie ||
> -                   ie_end <=3D (u8 *)ie + le16_to_cpu(ie->length) ||
> -                   le16_to_cpu(ie->length) > le32_to_cpu(ih->allocated_s=
ize) ||
> -                   le16_to_cpu(ie->length) > icx->block_size) {
> -                       ntfs_error(vol->sb, "Index entry(0x%p) is out of =
range from %s",
> -                                       (u8 *)icx->entry,
> -                                       icx->is_in_root ? "index root" : =
"index block");
> -                       return -EIO;
> -               }
> -       }
> -
>         if (ie->key_length &&
>             ((le16_to_cpu(ie->key_length) + offsetof(struct index_entry, =
key)) >
>              le16_to_cpu(ie->length))) {
> @@ -350,6 +319,44 @@ static int ntfs_index_header_inconsistent(struct ntf=
s_volume *vol,
>         return 0;
>  }
>
> +int ntfs_index_entries_inconsistent(const struct ntfs_volume *vol,
> +                                   const struct index_header *ih,
> +                                   __le32 collation_rule, u64 inum)
> +{
> +       struct index_entry *ie;
> +       u8 *index_end =3D (u8 *)ih + le32_to_cpu(ih->index_length);
> +
> +       for (ie =3D ntfs_ie_get_first((struct index_header *)ih);
> +             ; ie =3D ntfs_ie_get_next(ie)) {
> +               if ((u8 *)ie + sizeof(struct index_entry_header) > index_=
end ||
> +                   (u8 *)ie + le16_to_cpu(ie->length) > index_end) {
> +                       ntfs_error(vol->sb,
> +                                  "Index entry out of bounds in inode %l=
lu.",
> +                                  (unsigned long long)inum);
> +                       return -EIO;
> +               }
> +
> +               if (le16_to_cpu(ie->length) < sizeof(struct index_entry_h=
eader)) {
> +                       ntfs_error(vol->sb,
> +                                  "Index etnry too small in inode %llu."=
,
> +                                  inum);
> +                       return -EIO;
> +               }
> +
> +               if (ntfs_ie_end(ie))
> +                       break;
> +
> +               if (!ie->key_length)
> +                       return -EIO;
> +
> +               if (ntfs_index_entry_inconsistent(vol, ie,
> +                                                 collation_rule, inum))
> +                       return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
>  /*
>   *  Find the last entry in the index block
>   */
> @@ -501,7 +508,8 @@ static struct index_entry *ntfs_ie_dup_novcn(struct i=
ndex_entry *ie)
>   */
>  int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
>                                   const struct index_block *ib,
> -                                 u32 block_size, s64 vcn, u64 inum)
> +                                 u32 block_size, s64 vcn, __le32 cr,
> +                                 u64 inum)
>  {
>         u32 ib_size =3D (unsigned int)le32_to_cpu(ib->index.allocated_siz=
e) +
>                 offsetof(struct index_block, index);
> @@ -512,7 +520,7 @@ int ntfs_index_block_inconsistent(struct ntfs_volume =
*vol,
>         if (!ntfs_is_indx_record(ib->magic)) {
>                 ntfs_error(sb, "Corrupt index block signature: vcn %lld i=
node %llu\n",
>                            vcn, (unsigned long long)inum);
> -               return -1;
> +               return -EIO;
>         }
>
>         if (le64_to_cpu(ib->index_block_vcn) !=3D vcn) {
> @@ -520,22 +528,23 @@ int ntfs_index_block_inconsistent(struct ntfs_volum=
e *vol,
>                         "Corrupt index block: s64 (%lld) is different fro=
m expected s64 (%lld) in inode %llu\n",
>                         (long long)le64_to_cpu(ib->index_block_vcn),
>                         vcn, inum);
> -               return -1;
> +               return -EIO;
>         }
>
>         if (ib_size !=3D block_size) {
>                 ntfs_error(sb,
>                            "Corrupt index block : s64 (%lld) of inode %ll=
u has a size (%u) differing from the index specified size (%u)\n",
>                            vcn, inum, ib_size, block_size);
> -               return -1;
> +               return -EIO;
>         }
>
>         if (ntfs_index_header_inconsistent(vol, &ib->index,
>                                            block_size -
>                                            offsetof(struct index_block, i=
ndex),
>                                            inum))
> -               return -1;
> -
> +               return -EIO;
> +       if (ntfs_index_entries_inconsistent(vol, &ib->index, cr, inum))
> +               return -EIO;
>         return 0;
>  }
>
> @@ -720,15 +729,14 @@ static int ntfs_ib_read(struct ntfs_index_context *=
icx, s64 vcn, struct index_bl
>                 else
>                         ntfs_error(icx->idx_ni->vol->sb,
>                                 "Failed to read full index block at %lld\=
n", pos);
> -               return -1;
> +               return -EIO;
>         }
>
>         post_read_mst_fixup((struct ntfs_record *)((u8 *)dst), icx->block=
_size);
>         if (ntfs_index_block_inconsistent(icx->idx_ni->vol, dst,
> -                                         icx->block_size, vcn,
> +                                         icx->block_size, vcn, icx->cr,
>                                           icx->idx_ni->mft_no))
> -               return -1;
> -
> +               return -EIO;
>         return 0;
>  }
>
> diff --git a/fs/ntfs/index.h b/fs/ntfs/index.h
> index cad78568d8b3..9a03f53bba47 100644
> --- a/fs/ntfs/index.h
> +++ b/fs/ntfs/index.h
> @@ -94,9 +94,11 @@ int ntfs_index_root_inconsistent(struct ntfs_volume *v=
ol,
>                                  const struct index_root *ir, u64 inum);
>  int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
>                                   const struct index_block *ib,
> -                                 u32 block_size, s64 vcn, u64 inum);
> -int ntfs_index_entry_inconsistent(struct ntfs_index_context *icx, struct=
 ntfs_volume *vol,
> -               const struct index_entry *ie, __le32 collation_rule, u64 =
inum);
> +                                 u32 block_size, s64 vcn,
> +                                 __le32 cr, u64 inum);
> +int ntfs_index_entries_inconsistent(const struct ntfs_volume *vol,
> +                                   const struct index_header *ih,
> +                                   __le32 collation_rule, u64 inum);
>  struct ntfs_index_context *ntfs_index_ctx_get(struct ntfs_inode *ni, __l=
e16 *name,
>                 u32 name_len);
>  void ntfs_index_ctx_put(struct ntfs_index_context *ictx);
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index 63ee7acff4fc..9717fb5b4709 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -939,7 +939,9 @@ static int ntfs_read_locked_inode(struct inode *vi)
>                 }
>                 ir =3D (struct index_root *)((u8 *)a +
>                                 le16_to_cpu(a->data.resident.value_offset=
));
> -               if (ntfs_index_root_inconsistent(ni->vol, a, ir, ni->mft_=
no)) {
> +               if (ntfs_index_root_inconsistent(ni->vol, a, ir, ni->mft_=
no) ||
> +                   ntfs_index_entries_inconsistent(ni->vol, &ir->index,
> +                                                   ir->collation_rule, n=
i->mft_no)) {
>                         ntfs_error(vi->i_sb, "Directory index is corrupt.=
");
>                         goto unm_err_out;
>                 }
> @@ -1529,7 +1531,9 @@ static int ntfs_read_locked_index_inode(struct inod=
e *base_vi, struct inode *vi)
>         }
>
>         ir =3D (struct index_root *)((u8 *)a + le16_to_cpu(a->data.reside=
nt.value_offset));
> -       if (ntfs_index_root_inconsistent(vol, a, ir, ni->mft_no)) {
> +       if (ntfs_index_root_inconsistent(vol, a, ir, ni->mft_no) ||
> +           ntfs_index_entries_inconsistent(vol, &ir->index,
> +                                           ir->collation_rule, ni->mft_n=
o)) {
>                 ntfs_error(vi->i_sb, "Index is corrupt.");
>                 goto unm_err_out;
>         }
>
> --
> 2.43.0
>
>
