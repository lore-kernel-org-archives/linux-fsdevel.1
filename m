Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28E4391E4E
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 05:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779427333; cv=pass; b=OWq+gbBOzQHuFzvSNBGfGWpseqXabl7f6xd0jcUiUw0I5jXjWJKVvizWmTd845xBHfkPqzNm3XlroZX/taBaxj1v5kYyDVOtRdGiUHumWCqXzBGWG2g2nkx+OXJWskDJ4z4EaANjpVvM1ROrhntUQvpcYMO7yPFX9eMIGf/4jH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779427333; c=relaxed/simple;
	bh=v258XY0gMPzYDRHk9UkF2/vUBYxp1FrfEyVvGi3c8Gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kf29PhSw808xbioEsIL6z/mE9QkUoH18f3HGszWGE+moB/1pwepON3cRU7MIB7vu0Zq5YFbYta4QNo91guUxN8Nitm2aeJ5LsGmF26zyxCORr2UxSNU5k+ixZoTzIYLS8DoRMVjreS7Ft+a4gDBjPjgTul6n2ymjLQZDERTvibk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7azaDvr; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7azaDvr"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a8d1f43432so11687718e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 22:22:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779427328; cv=none;
        d=google.com; s=arc-20240605;
        b=QXTJL6m/aFno20V8RIVVH9F7A38XME/0AlbF/4t0Z/mUT7oYbc/PernV2h1P4H/wnw
         ZP+yibcbLrdIVoqJ1CwK9QR2RSvmf40/QR1XW1DOHWWeKBkdUVy+852JIF04blaWpdfo
         N75CPLQLzP5y43aX+gZWGJPEA12aoEDnBfICtSOg6CWKGMjdzmY2cPmKHkg6YeD/ATl1
         PIsvlATWvNU92lQAVKPrl3KEGodxtSjiiknZnJK7UZQ+K+4CgyZxNN/4pY2whAtYxt8L
         P3yr7fz/Bl/DmIMlg+uAEARNb7BQRlBzjOMDj84eW666Ze7oI5VLsJTXk1estgKqgOpn
         IDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=keEncHssIC9YcgdL0Tb8aPqoqT9GovjGQYJLn0Hp+W4=;
        fh=oMJUVKD7oPG6trXfSiw7MpMlTpmHu374eo06EeJmgx0=;
        b=BWMEMlTSwx6aHWAjoQX4MO883MjICUeXhbqXxk2oWW7FE3ncT712AuzsRWytCoVVwA
         JgRQPkIyh+fR1gG61iyImUPbTqsKpeJ8GE+JMT3vSAyOFxhEZH9JRGNUcgWQ+oH6Phox
         2Vdpi133TEDsCGB3g2DiJeuyrfgDmYkmVwxQ2SQ7Yu32aNKZAkjiiuN/sblzIStv2f/k
         K2PlczC4gpF4G6tjgdfNaUC+fnaENJyK1PlkWodajxQW/aJT90hmAJUuudxduYz1eHcD
         xyjjrHji738JTaN2RV83qE9HJJrKtSnVK+gw7sRty2V9mt8c7rQneY3g28Vpa+2mA6Rg
         VX0A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779427328; x=1780032128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=keEncHssIC9YcgdL0Tb8aPqoqT9GovjGQYJLn0Hp+W4=;
        b=G7azaDvrlk1Phl5Rb/HfaH0/riLpByBEfAmAKoIa8j0gnfV4mU9OHHUZQMGo3FLVgG
         NL+cp+bI0CeA+ODtEXQpfgkMcnX2frvwhAWDud6SJJDbnYGUwB/0DBpamHv607wRwoMx
         Qay+U80mnphkYOuTXcRldgOalaGOMRWiVwBX6DJff7wDJye0aEphNu2X+3VONzTeAq5K
         jZg3SzyQg/WTTQNL0INDN3ntkHbqKlVWSYCsYzvaKu54zZlMUjlimXWNH37WXXgQ8HJO
         PXRMBTnGYs569KGa+VjXd8RXeN9xzan0P75cTDmzqevZPOi/pwPb3bB0ZHgAfMmHcVeR
         HAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779427328; x=1780032128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=keEncHssIC9YcgdL0Tb8aPqoqT9GovjGQYJLn0Hp+W4=;
        b=LAUcDisnGgGr3WXF+3lMzLomgmvdRodOwqJtXg2+9ArDnU4wohM8YlRuHCAN+vjptH
         MliTTzyC3xcF2PCaZhuFLsg8kbLgFHcCvPd5fTq1aazFtnGvjoBDHgySebYgVpApDv/G
         2EHuRbx4TnYgcEA2RqDbPpTgom1/1p9UQkrNHg/MHLAA/nwsp9bVJ3Xp7pQvz0mL+3s/
         kVlx+ccv59iFxtaIkT/FlvlJSnH2h3GaGzea51oMxNy58LCNU3ZJKWynLaFvFqu7Euzv
         yO7+44I7i3Ex0vfOUSdt0ECa++WqfmpcIvuWqWdeimKeeeBueFS7J6NLxITMUg/7ADWO
         vfbA==
X-Forwarded-Encrypted: i=1; AFNElJ8SA8cR55q2LEBDKvr5HZ190KGuNvtY6rQiGMUmqnIJZwq7kHGGgNx0ZkwFm43SAAyK5qLnrMJjmv+sTWrE@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz4wKM7wKCN713RsZjdCFSfEYQWb/mDJekOhncYXNqYqvL+DdY
	BAKnlAv71+d3YFdKmX11x6GuncZ9oX6Jrp266iRHDXCERqYke0msNYlGOFeikA7wMPleVrW7jtN
	8c2fwg7R+drM/mLjjSrAv+RCz2Ud/1Ks=
X-Gm-Gg: Acq92OEvNuno+uvzhFsjG8OoH42TRfgDgGWCoQLzyJSROj84MXArd3p0ihPoLuwCbcw
	gsI/1sXU9nL+szlm+My/8uE3MOPdMHP7aZdWouT5sMk+lQP6NFE2sNSHZ1oASBlBQi+nAl9LnkE
	PQF/uH2mRILiPBFEgbwaaqQBflgMqU+xst4wTUzFtAW3inKQJErZBq8hgIpgpjd6M8cgrsaxf9s
	MS2f4fMi7n7c5+rQDHAm708kbDsHjGVMULH6qxuCLG8LKQOga5XaWPG9/K5IiQgdifndTZc9nQ5
	wCq6lzmazd1yiKh3ow==
X-Received: by 2002:a05:6512:61a:b0:5a8:ee42:c131 with SMTP id
 2adb3069b0e04-5aa323cbd13mr340651e87.34.1779427328217; Thu, 21 May 2026
 22:22:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522-t-fix-oob-v2-v1-0-0bea6582a361@gmail.com>
 <20260522-t-fix-oob-v2-v1-1-0bea6582a361@gmail.com> <CAMrLSE6Zw4hzX_rXG3u5+1=WPj9G012ZL1XFc2ygwMGR-XpYVw@mail.gmail.com>
In-Reply-To: <CAMrLSE6Zw4hzX_rXG3u5+1=WPj9G012ZL1XFc2ygwMGR-XpYVw@mail.gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 22 May 2026 14:21:55 +0900
X-Gm-Features: AVHnY4Ltw-wgucwS3EaNbFXx54DBDfX37Nm_Uq6umDnZCm8wVHc2B_xaT4cxf5c
Message-ID: <CANFS6baLpL2uN2p05-6ZJbJDua65WCOozjH2iYZ5RvdGs0+dbA@mail.gmail.com>
Subject: Re: [PATCH 1/4] ntfs: validate index block header more strictly
To: CharSyam <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 22=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 12:16, =
CharSyam <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

>
> Hi, Hyunchul.
>
>  err =3D ntfs_index_block_inconsistent(...) now stores the helper's -1.
> Previously err was still
> 0 at this point, so the common exit path normalized corruption errors
> to -EIO via if (!err)
> err =3D -EIO;. With this patch, the -1 skips that normalization and is
> exposed to callers as
> -EPERM.
>
>  Was that intended? If not, this path should set err =3D -EIO before
> jumping to unm_err_out, or
> ntfs_index_block_inconsistent() should be converted to return real
> errno values. The latter
> may be cleaner, since ntfs_index_header_inconsistent() already returns
> -EIO but the caller
> currently collapses it back to -1.

Patch 3 changes ntfs_index_block_inconsistent() to return -EIO
on corruptions. I will move that change into this patch instead.

>
> Thanks.
> DaeMyung.
>
> 2026=EB=85=84 5=EC=9B=94 22=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 9:48,=
 Hyunchul Lee <hyc.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >
> > Modify ntfs_index_block_inconsisent() to perform stricter validation of
> > INDEX_HEADER geometry in INDX blocks, and update
> > ntfs_lookup_inode_by_name() to use that function to validate INDX
> > blocks.
> >
> > Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> > ---
> >  fs/ntfs/dir.c   | 38 +++++---------------------
> >  fs/ntfs/index.c | 85 +++++++++++++++++++++++++++++++++++++++++--------=
--------
> >  fs/ntfs/index.h |  3 ++
> >  3 files changed, 72 insertions(+), 54 deletions(-)
> >
> > diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
> > index 20f5c7074bdd..6745a0e6e3e7 100644
> > --- a/fs/ntfs/dir.c
> > +++ b/fs/ntfs/dir.c
> > @@ -342,43 +342,19 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *=
dir_ni, const __le16 *uname,
> >                         dir_ni->mft_no);
> >                 goto unm_err_out;
> >         }
> > -       /* Catch multi sector transfer fixup errors. */
> > -       if (unlikely(!ntfs_is_indx_record(ia->magic))) {
> > -               ntfs_error(sb,
> > -                       "Directory index record with vcn 0x%llx is corr=
upt.  Corrupt inode 0x%llx.  Run chkdsk.",
> > -                       vcn, dir_ni->mft_no);
> > -               goto unm_err_out;
> > -       }
> > -       if (le64_to_cpu(ia->index_block_vcn) !=3D vcn) {
> > -               ntfs_error(sb,
> > -                       "Actual VCN (0x%llx) of index buffer is differe=
nt from expected VCN (0x%llx). Directory inode 0x%llx is corrupt or driver =
bug.",
> > -                       le64_to_cpu(ia->index_block_vcn),
> > -                       vcn, dir_ni->mft_no);
> > -               goto unm_err_out;
> > -       }
> > -       if (le32_to_cpu(ia->index.allocated_size) + 0x18 !=3D
> > -                       dir_ni->itype.index.block_size) {
> > -               ntfs_error(sb,
> > -                       "Index buffer (VCN 0x%llx) of directory inode 0=
x%llx has a size (%u) differing from the directory specified size (%u). Dir=
ectory inode is corrupt or driver bug.",
> > -                       vcn, dir_ni->mft_no,
> > -                       le32_to_cpu(ia->index.allocated_size) + 0x18,
> > -                       dir_ni->itype.index.block_size);
> > -               goto unm_err_out;
> > -       }
> >         index_end =3D (u8 *)ia + dir_ni->itype.index.block_size;
> >         if (index_end > kaddr + PAGE_SIZE) {
> >                 ntfs_error(sb,
> > -                       "Index buffer (VCN 0x%llx) of directory inode 0=
x%llx crosses page boundary. Impossible! Cannot access! This is probably a =
bug in the driver.",
> > -                       vcn, dir_ni->mft_no);
> > +                          "Index buffer (VCN 0x%llx) of directory inod=
e 0x%llx crosses page boundary. Impossible! Cannot access! This is probably=
 a bug in the driver.",
> > +                          vcn, dir_ni->mft_no);
> >                 goto unm_err_out;
> >         }
> > -       index_end =3D (u8 *)&ia->index + le32_to_cpu(ia->index.index_le=
ngth);
> > -       if (index_end > (u8 *)ia + dir_ni->itype.index.block_size) {
> > -               ntfs_error(sb,
> > -                       "Size of index buffer (VCN 0x%llx) of directory=
 inode 0x%llx exceeds maximum size.",
> > -                       vcn, dir_ni->mft_no);
> > +       err =3D ntfs_index_block_inconsistent(vol, ia,
> > +                                           dir_ni->itype.index.block_s=
ize,
> > +                                           vcn, dir_ni->mft_no);
> > +       if (err)
> >                 goto unm_err_out;
> > -       }
> > +       index_end =3D (u8 *)&ia->index + le32_to_cpu(ia->index.index_le=
ngth);
> >         /* The first index entry. */
> >         ie =3D (struct index_entry *)((u8 *)&ia->index +
> >                         le32_to_cpu(ia->index.entries_offset));
> > diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
> > index 146e011c1a41..c203a5ad47b6 100644
> > --- a/fs/ntfs/index.c
> > +++ b/fs/ntfs/index.c
> > @@ -303,6 +303,53 @@ static int ntfs_ie_end(struct index_entry *ie)
> >         return ie->flags & INDEX_ENTRY_END || !ie->length;
> >  }
> >
> > +static int ntfs_index_header_inconsistent(struct ntfs_volume *vol,
> > +                                         const struct index_header *ih=
,
> > +                                         u32 bytes_available, u64 inum=
)
> > +{
> > +       u32 entries_offset =3D le32_to_cpu(ih->entries_offset);
> > +       u32 index_length =3D le32_to_cpu(ih->index_length);
> > +       u32 allocated_size =3D le32_to_cpu(ih->allocated_size);
> > +
> > +       if (bytes_available < sizeof(struct index_header)) {
> > +               ntfs_error(vol->sb,
> > +                          "index block in inode %llu is smaller than a=
n index header.",
> > +                          (unsigned long long)inum);
> > +               return -EIO;
> > +       }
> > +
> > +       if (entries_offset < sizeof(struct index_header) ||
> > +           entries_offset > bytes_available) {
> > +               ntfs_error(vol->sb,
> > +                          "Invalid index entry offset in inode %llu.",
> > +                          (unsigned long long)inum);
> > +               return -EIO;
> > +       }
> > +
> > +       if (index_length <=3D entries_offset) {
> > +               ntfs_error(vol->sb,
> > +                          "No space for index entries in inode %llu.",
> > +                          (unsigned long long)inum);
> > +               return -EIO;
> > +       }
> > +
> > +       if (allocated_size < index_length) {
> > +               ntfs_error(vol->sb,
> > +                          "Index entries overflow in inode %llu.",
> > +                          (unsigned long long)inum);
> > +               return -EIO;
> > +       }
> > +
> > +       if (allocated_size > bytes_available || index_length > bytes_av=
ailable) {
> > +               ntfs_error(vol->sb,
> > +                          "Index entries in inode %llu exceed the avai=
lable buffer.",
> > +                          (unsigned long long)inum);
> > +               return -EIO;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  /*
> >   *  Find the last entry in the index block
> >   */
> > @@ -452,20 +499,19 @@ static struct index_entry *ntfs_ie_dup_novcn(stru=
ct index_entry *ie)
> >   *
> >   * size(struct index_header) <=3D ent_offset < ind_length <=3D alloc_s=
ize < bk_size
> >   */
> > -static int ntfs_index_block_inconsistent(struct ntfs_index_context *ic=
x,
> > -               struct index_block *ib, s64 vcn)
> > +int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
> > +                                 const struct index_block *ib,
> > +                                 u32 block_size, s64 vcn, u64 inum)
> >  {
> >         u32 ib_size =3D (unsigned int)le32_to_cpu(ib->index.allocated_s=
ize) +
> >                 offsetof(struct index_block, index);
> > -       struct super_block *sb =3D icx->idx_ni->vol->sb;
> > -       unsigned long long inum =3D icx->idx_ni->mft_no;
> > +       struct super_block *sb =3D vol->sb;
> >
> >         ntfs_debug("Entering\n");
> >
> >         if (!ntfs_is_indx_record(ib->magic)) {
> > -
> >                 ntfs_error(sb, "Corrupt index block signature: vcn %lld=
 inode %llu\n",
> > -                               vcn, (unsigned long long)icx->idx_ni->m=
ft_no);
> > +                          vcn, (unsigned long long)inum);
> >                 return -1;
> >         }
> >
> > @@ -477,27 +523,18 @@ static int ntfs_index_block_inconsistent(struct n=
tfs_index_context *icx,
> >                 return -1;
> >         }
> >
> > -       if (ib_size !=3D icx->block_size) {
> > +       if (ib_size !=3D block_size) {
> >                 ntfs_error(sb,
> > -                       "Corrupt index block : s64 (%lld) of inode %llu=
 has a size (%u) differing from the index specified size (%u)\n",
> > -                       vcn, inum, ib_size, icx->block_size);
> > +                          "Corrupt index block : s64 (%lld) of inode %=
llu has a size (%u) differing from the index specified size (%u)\n",
> > +                          vcn, inum, ib_size, block_size);
> >                 return -1;
> >         }
> >
> > -       if (le32_to_cpu(ib->index.entries_offset) < sizeof(struct index=
_header)) {
> > -               ntfs_error(sb, "Invalid index entry offset in inode %ll=
d\n", inum);
> > -               return -1;
> > -       }
> > -       if (le32_to_cpu(ib->index.index_length) <=3D
> > -           le32_to_cpu(ib->index.entries_offset)) {
> > -               ntfs_error(sb, "No space for index entries in inode %ll=
d\n", inum);
> > +       if (ntfs_index_header_inconsistent(vol, &ib->index,
> > +                                          block_size -
> > +                                          offsetof(struct index_block,=
 index),
> > +                                          inum))
> >                 return -1;
> > -       }
> > -       if (le32_to_cpu(ib->index.allocated_size) <
> > -           le32_to_cpu(ib->index.index_length)) {
> > -               ntfs_error(sb, "Index entries overflow in inode %lld\n"=
, inum);
> > -               return -1;
> > -       }
> >
> >         return 0;
> >  }
> > @@ -669,7 +706,9 @@ static int ntfs_ib_read(struct ntfs_index_context *=
icx, s64 vcn, struct index_bl
> >         }
> >
> >         post_read_mst_fixup((struct ntfs_record *)((u8 *)dst), icx->blo=
ck_size);
> > -       if (ntfs_index_block_inconsistent(icx, dst, vcn))
> > +       if (ntfs_index_block_inconsistent(icx->idx_ni->vol, dst,
> > +                                         icx->block_size, vcn,
> > +                                         icx->idx_ni->mft_no))
> >                 return -1;
> >
> >         return 0;
> > diff --git a/fs/ntfs/index.h b/fs/ntfs/index.h
> > index e68d6fabaf9f..3451ec8a1c4e 100644
> > --- a/fs/ntfs/index.h
> > +++ b/fs/ntfs/index.h
> > @@ -89,6 +89,9 @@ struct ntfs_index_context {
> >         bool sync_write;
> >  };
> >
> > +int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
> > +                                 const struct index_block *ib,
> > +                                 u32 block_size, s64 vcn, u64 inum);
> >  int ntfs_index_entry_inconsistent(struct ntfs_index_context *icx, stru=
ct ntfs_volume *vol,
> >                 const struct index_entry *ie, __le32 collation_rule, u6=
4 inum);
> >  struct ntfs_index_context *ntfs_index_ctx_get(struct ntfs_inode *ni, _=
_le16 *name,
> >
> > --
> > 2.43.0
> >
> >



--
Thanks,
Hyunchul
