Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11543DE427
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281263; cv=pass; b=jtd8I41W1f/PO6pbSS4DakYB6DuGZWmtsC3hhDWA/kl+ReOQcIvzOEL2/l8kiVR8oXSXPJT2xdEpmdTWw7yJXV7UHyp3PLRKuk8x5sgWZWrUn/Slog4OdQK2prorJL1Ie6eWhzmuYZb2kqeok86B7zT2h6CxeS22O8TfKliOe/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281263; c=relaxed/simple;
	bh=WwHWav8QEt5RzKAHTyj/zpxUi4aXxwNmkU3aATTKlxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4R2QDiBwm+RvgMwScuIA4IO40UFQ72yRZX/ZycHNV4voQp9OThGqw4IV30dQHEtQClx4wHczfxLfuIjMflQLjwf+36LfU2Ys1qaAeQ4zGZkjBle+yq1F1iMjeFmgz1DvnDoaGI8YcFkHTJK1cEQgfWf7bxLyIjfoh8/yDWykNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAbV8PrM; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAbV8PrM"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66095de1c10so52116d50.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 09:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781281258; cv=none;
        d=google.com; s=arc-20240605;
        b=OWR/9IDG60oywOGu1FnSkLvqZblNF7tgE68X1gsP3VnsqHP7amfBhh0RxZgu13bShj
         PJvXnj6c8ZfkSRuksXJwyfd1mPi55Msf9BWjvyI10WZxVQk32PBesBD0xNWLdMNIirQu
         mRB44wp6saW9FdaQTBZDLtt7gbctvTGlwwSTGw84CH2O3it+H2N3023w0XhXxogqgBoQ
         pUwfGQ+3smjNk5/TcaLhrqvZ4NpnFsWErwVCxYuoXJbAKmfndNHicTv8D3Di3xyUzXZ6
         B1lfhaDtM3TIB/7hY2IrgkGrqKvZ0F0dwW3ifJsyQWQos4MnfSYXgCowwkhP6lT0V6aU
         XhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VH+nm7AmHxKJ1C/Iq1YCeeX6eNUsRC6XXNemLxXT9PU=;
        fh=Hf80jvAaJzVcTD8tTQU3rjdR+xEcrjTpy9t9t/76/pU=;
        b=IJL3INNJ4VSzQ3vjnIdYODe8TMxq7m6DxFaHgfVSIPzgG083Nk12Tqq6OOG4esd31G
         Q7efj3fKYt61UfrRBVulcHfXywLogbg8gaG76hxNzBcqRNkQJYAFqYClAojxCWXqXNy0
         gGBQd3KYxImPdyhtKp0WyoftzvycAf7TgoJx8l9pbmFKNQLO8yRt7zXDAa/4ouOma/vB
         4ROo+QfsAVhtHUfS/PVmke2b/4dkKy3DJE66inv4YUMQKZABH5/t7Vlx+LToYlbZNDyP
         uNrmpPkMyPT2RmEZIJUiS9r3BsGZ0TlgdZfmHdAPBzWODaxMuL0Mx/ld35etcwd6VGYQ
         EWLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781281258; x=1781886058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VH+nm7AmHxKJ1C/Iq1YCeeX6eNUsRC6XXNemLxXT9PU=;
        b=mAbV8PrM9GsVB2yFOykOmcMbeC8gb805dhhov3gGzUo3lCSSp8+v2tw2qvLaMr+6ZC
         7EEWzYlzg+Qk5LwMumEwOFqlb8qoVe+JBxg9as3e1Tr1OU60d1MzPRMkuRM6ESSFuMki
         4ZRFWSBO8RLwlPnOIyP2DmtDWxKMniKnQ6rLdDXngtWd9A8DdKDSQqZRtd3nPQrsynXX
         f0xwaxcmPC3646Fz2QLKvqw0aIqMEu/f9H458geTLWZWq36Mzl4pHDlOE7mgNN5azj7L
         6I/bJEo6V+eMrA4Tc/WEOALkwjGXXuFKQeLpxxGde0Rr23FhZsjGN7Ydo7aW3f9zU6JS
         vuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781281258; x=1781886058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VH+nm7AmHxKJ1C/Iq1YCeeX6eNUsRC6XXNemLxXT9PU=;
        b=itYC4QmtrO/GoP6geihL/flxVpchF7eYKXjE6WHHwipcHGdyYiIsfo7Bym3RCArK2/
         NYrcTFrmUnmRBc1yuKp2Ovq9XrZfiosuV6u5SW7+nRUVQEgaZJkWIJanP7fU8ujlhG2x
         f2c4sK/k1wTNw6ekzWZrJkY5tuCBWcBjwbLTRRYHUOp8vxfYOBcyZpFqGIL76tm+iE/9
         qu7cfKvJ4upTmC8niti12JWnN6wur+sb5GXigYZ/vzkC5947RJQFDK/zUmUSxxfBi4Ea
         BPPAhAVUNnI2fobFx/U5zldKx0g7CfQrZ5Cs74iGl/OP7RhZjYVHC6WhlBwW3C3umhPk
         xoIA==
X-Forwarded-Encrypted: i=1; AFNElJ/OeXj0MDz9Oa/sTkxFXs8JZtW2nJqtR1AqEEz13CvJv5RAgyh2X0t8+FxCII1hRpTOnYnvVVLPDXF1ROm+@vger.kernel.org
X-Gm-Message-State: AOJu0YxFKFfRbhHFMiAUYV0ebBHUWDoXrDB44xmzWjCv8aDIq+Lhga96
	zQmSr9TfvGCXxgmFCrrja5n6CClh1OH6YZEW2ZEt4/RzvLjInNBcvJKV4auaeSeajkOHS2Fmbb1
	KLtGgtIuyKyNZaEfYO1pcfreqiiKKEKQFdsJNGgs=
X-Gm-Gg: Acq92OF2wBcqF4Gy0hOMDh7P3PgaQI2srPYbeQq/bOgvAIVwOWKagr2tosvH2wfNU13
	nwz0xsjMYpe4AU50iL7za0GN1Weo7X+6xUyMJjbE3CswL6w2vWWBeFGUMatYgyREKw/t3XJBdax
	RjhIenf579pjD/P4OZ628wgQEsySa7BxIAQpRML+Twv5DC/gSEJOQjDVJ4kmN4PVlCUwoyvoSb4
	CnKjPAr1sQT4boXQllB/LWrxGTLCAT8l88HE8qimUUFN2Dvgk4P+G9kwwaZS9RUVRHOn2OHENGz
	ehA429K2
X-Received: by 2002:a05:690e:b88:b0:661:4f99:5837 with SMTP id
 956f58d0204a3-662782cf998mr1714148d50.3.1781281258332; Fri, 12 Jun 2026
 09:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-topic-symlink-v1-0-cc1ebf9528e1@gmail.com> <20260612-topic-symlink-v1-2-cc1ebf9528e1@gmail.com>
In-Reply-To: <20260612-topic-symlink-v1-2-cc1ebf9528e1@gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Sat, 13 Jun 2026 01:20:47 +0900
X-Gm-Features: AVVi8Cefq8hhNqxJp7NMR7DFkCSolfHFY6UF_6fEFtuqppnY1QU39OJfh3amz6c
Message-ID: <CAMrLSE4eb15J3YBfSdTWX3eRhKpRs=GeNrLqJYnMHbr16mrqjg@mail.gmail.com>
Subject: Re: [PATCH 2/7] ntfs: support following Windows native symlink with
 relative paths
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hyunchul.

Can we validate `attr_size >=3D sizeof(struct reparse_point)` before this
switch? I can reproduce a KASAN slab-out-of-bounds by setting a resident
`$REPARSE_POINT` value length to 1 byte. `ntfs_attr_readall()` allocates a
1-byte buffer, then this line reads 4 bytes from `reparse_tag` before
`valid_reparse_buffer()` rejects the malformed attribute. The same guard is
also needed in `ntfs_reparse_tag_dt_types()`, which KASAN hits via
`ls -> getdents64 -> ntfs_readdir()`.

Thanks.
DaeMyung.

2026=EB=85=84 6=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 4:37, H=
yunchul Lee <hyc.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Make ntfs_make_symlink() parse native Windows symbolic link reparse
> payloads when the SYMLINK_FLAG_RELATIVE bit is set.
> Implement the following changes:
>  * Add a dedicated on-disk layout definition for symbolic link reparse
>    data.
>  * validate the UTF-16 name ranges before decoding them.
>  * convert the substitute name into the mount's NLS and normalize path
>    separators.
>
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> ---
>  fs/ntfs/inode.c   |  36 +++++++++-------
>  fs/ntfs/layout.h  |  11 +++++
>  fs/ntfs/reparse.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  3 files changed, 143 insertions(+), 26 deletions(-)
>
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index efb34a5e94d9..8894f33b46ca 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -863,8 +863,26 @@ static int ntfs_read_locked_inode(struct inode *vi)
>                 ntfs_ea_get_wsl_inode(vi, &dev, flags);
>         }
>
> -       if (m->flags & MFT_RECORD_IS_DIRECTORY) {
> +       if (ni->flags & FILE_ATTR_REPARSE_POINT) {
> +               unsigned int mode;
> +
> +               mode =3D ntfs_make_symlink(ni);
> +               if (mode)
> +                       vi->i_mode |=3D mode;
> +               else {
> +                       vi->i_mode &=3D ~S_IFLNK;
> +                       if (m->flags & MFT_RECORD_IS_DIRECTORY)
> +                               vi->i_mode |=3D S_IFDIR;
> +                       else
> +                               vi->i_mode |=3D S_IFREG;
> +               }
> +       } else if (m->flags & MFT_RECORD_IS_DIRECTORY) {
>                 vi->i_mode |=3D S_IFDIR;
> +       } else {
> +               vi->i_mode |=3D S_IFREG;
> +       }
> +
> +       if (S_ISDIR(vi->i_mode)) {
>                 /*
>                  * Apply the directory permissions mask set in the mount
>                  * options.
> @@ -874,18 +892,6 @@ static int ntfs_read_locked_inode(struct inode *vi)
>                 if (vi->i_nlink > 1)
>                         set_nlink(vi, 1);
>         } else {
> -               if (ni->flags & FILE_ATTR_REPARSE_POINT) {
> -                       unsigned int mode;
> -
> -                       mode =3D ntfs_make_symlink(ni);
> -                       if (mode)
> -                               vi->i_mode |=3D mode;
> -                       else {
> -                               vi->i_mode &=3D ~S_IFLNK;
> -                               vi->i_mode |=3D S_IFREG;
> -                       }
> -               } else
> -                       vi->i_mode |=3D S_IFREG;
>                 /* Apply the file permissions mask set in the mount optio=
ns. */
>                 vi->i_mode &=3D ~vol->fmask;
>         }
> @@ -894,7 +900,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
>          * If an attribute list is present we now have the attribute list=
 value
>          * in ntfs_ino->attr_list and it is ntfs_ino->attr_list_size byte=
s.
>          */
> -       if (S_ISDIR(vi->i_mode)) {
> +       if (m->flags & MFT_RECORD_IS_DIRECTORY) {
>                 struct index_root *ir;
>
>  view_index_meta:
> @@ -1018,7 +1024,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
>                 m =3D NULL;
>                 ctx =3D NULL;
>                 /* Setup the operations for this inode. */
> -               ntfs_set_vfs_operations(vi, S_IFDIR, 0);
> +               ntfs_set_vfs_operations(vi, vi->i_mode, 0);
>                 if (ir->index.flags & LARGE_INDEX)
>                         NInoSetIndexAllocPresent(ni);
>         } else {
> diff --git a/fs/ntfs/layout.h b/fs/ntfs/layout.h
> index d94f914e830f..94af6efa04af 100644
> --- a/fs/ntfs/layout.h
> +++ b/fs/ntfs/layout.h
> @@ -2267,6 +2267,8 @@ enum {
>         IO_REPARSE_PLUGIN_SELECT        =3D cpu_to_le32(0xffff0fff),
>  };
>
> +#define SYMLINK_FLAG_RELATIVE          1
> +
>  /*
>   * struct reparse_point - $REPARSE_POINT attribute content (0xc0)\
>   *
> @@ -2287,6 +2289,15 @@ struct reparse_point {
>         u8 reparse_data[];
>  } __packed;
>
> +struct symlink_reparse_data {
> +       __le16 substitute_name_offset;
> +       __le16 substitute_name_length;
> +       __le16 print_name_offset;
> +       __le16 print_name_length;
> +       __le32 flags;
> +       __le16 path_buffer[];
> +} __packed;
> +
>  /*
>   * struct ea_information - $EA_INFORMATION attribute content (0xd0)
>   *
> diff --git a/fs/ntfs/reparse.c b/fs/ntfs/reparse.c
> index 74713716813f..4cc37f1c9c90 100644
> --- a/fs/ntfs/reparse.c
> +++ b/fs/ntfs/reparse.c
> @@ -24,6 +24,47 @@ struct wsl_link_reparse_data {
>         char    link[];
>  };
>
> +static bool reparse_name_is_valid(size_t size, size_t name_off, u16 len)
> +{
> +       if ((name_off | len) & 1)
> +               return false;
> +
> +       return name_off + len <=3D size;
> +}
> +
> +/*
> + * Windows-native reparse payloads store pathnames as UTF-16 strings wit=
h '\\'
> + * separators. Convert the on-disk UTF-16 target into the mount's NLS an=
d
> + * normalize path separators.
> + */
> +static int ntfs_reparse_target_to_nls(struct ntfs_volume *vol,
> +                                     const __le16 *uname, u16 ulen,
> +                                     char **target)
> +{
> +       int err, i;
> +
> +       *target =3D NULL;
> +       ulen >>=3D 1;
> +       if (!ulen)
> +               return -EINVAL;
> +
> +       if (!uname[ulen - 1])
> +               ulen--;
> +
> +       err =3D ntfs_ucstonls(vol, uname, ulen, (unsigned char **)target,=
 0);
> +       if (err < 0) {
> +               ntfs_attr_name_free((unsigned char **)target);
> +               return err;
> +       }
> +
> +       for (i =3D 0; i < err; i++) {
> +               if ((*target)[i] =3D=3D '\\')
> +                       (*target)[i] =3D '/';
> +       }
> +
> +       return 0;
> +}
> +
>  /* Index entry in $Extend/$Reparse */
>  struct reparse_index {
>         struct index_entry_header header;
> @@ -38,8 +79,10 @@ __le16 reparse_index_name[] =3D {cpu_to_le16('$'), cpu=
_to_le16('R'), 0};
>   * Check if the reparse point attribute buffer is valid.
>   * Returns true if valid, false otherwise.
>   */
> -static bool ntfs_is_valid_reparse_buffer(struct ntfs_inode *ni,
> -               const struct reparse_point *reparse_attr, size_t size)
> +static bool valid_reparse_buffer(struct ntfs_inode *ni,
> +                                const struct reparse_point *reparse_attr=
,
> +                                size_t size,
> +                                size_t payload_min_len)
>  {
>         size_t expected;
>
> @@ -50,6 +93,11 @@ static bool ntfs_is_valid_reparse_buffer(struct ntfs_i=
node *ni,
>         if (size < sizeof(struct reparse_point))
>                 return false;
>
> +       /* The payload must contain the fixed fields for the current tag.=
 */
> +       if (payload_min_len &&
> +           le16_to_cpu(reparse_attr->reparse_data_length) < payload_min_=
len)
> +               return false;
> +
>         /* Reserved zero tag is invalid */
>         if (reparse_attr->reparse_tag =3D=3D IO_REPARSE_TAG_RESERVED_ZERO=
)
>                 return false;
> @@ -79,24 +127,54 @@ static bool ntfs_is_valid_reparse_buffer(struct ntfs=
_inode *ni,
>  static bool valid_reparse_data(struct ntfs_inode *ni,
>                 const struct reparse_point *reparse_attr, size_t size)
>  {
> -       const struct wsl_link_reparse_data *wsl_reparse_data =3D
> -               (const struct wsl_link_reparse_data *)reparse_attr->repar=
se_data;
> -       unsigned int data_len =3D le16_to_cpu(reparse_attr->reparse_data_=
length);
> +       switch (reparse_attr->reparse_tag) {
> +       case IO_REPARSE_TAG_SYMLINK:
> +       {
> +               struct symlink_reparse_data *data;
> +               size_t data_offs;
>
> -       if (ntfs_is_valid_reparse_buffer(ni, reparse_attr, size) =3D=3D f=
alse)
> -               return false;
> +               if (!valid_reparse_buffer(ni, reparse_attr, size,
> +                                         sizeof(*data)))
> +                       return false;
>
> -       switch (reparse_attr->reparse_tag) {
> +               data =3D (struct symlink_reparse_data *)reparse_attr->rep=
arse_data;
> +               data_offs =3D offsetof(struct reparse_point, reparse_data=
) +
> +                       offsetof(struct symlink_reparse_data, path_buffer=
);
> +
> +               if (!reparse_name_is_valid(size,
> +                                          data_offs +
> +                                          le16_to_cpu(data->substitute_n=
ame_offset),
> +                                          le16_to_cpu(data->substitute_n=
ame_length)) ||
> +                   !reparse_name_is_valid(size,
> +                                          data_offs +
> +                                          le16_to_cpu(data->print_name_o=
ffset),
> +                                          le16_to_cpu(data->print_name_l=
ength)))
> +                       return false;
> +               break;
> +       }
>         case IO_REPARSE_TAG_LX_SYMLINK:
> -               if (data_len <=3D sizeof(wsl_reparse_data->type) ||
> -                   wsl_reparse_data->type !=3D cpu_to_le32(2))
> +       {
> +               struct wsl_link_reparse_data *data;
> +
> +               if (!valid_reparse_buffer(ni, reparse_attr, size,
> +                                         sizeof(*data)))
> +                       return false;
> +
> +               data =3D (struct wsl_link_reparse_data *)reparse_attr->re=
parse_data;
> +
> +               if (le16_to_cpu(reparse_attr->reparse_data_length) <=3D s=
izeof(data->type) ||
> +                   data->type !=3D cpu_to_le32(2))
>                         return false;
>                 break;
> +       }
>         case IO_REPARSE_TAG_AF_UNIX:
>         case IO_REPARSE_TAG_LX_FIFO:
>         case IO_REPARSE_TAG_LX_CHR:
>         case IO_REPARSE_TAG_LX_BLK:
> -               if (data_len || !(ni->flags & FILE_ATTRIBUTE_RECALL_ON_OP=
EN))
> +               if (!valid_reparse_buffer(ni, reparse_attr, size, 0))
> +                       return false;
> +               if (le16_to_cpu(reparse_attr->reparse_data_length) ||
> +                   !(ni->flags & FILE_ATTRIBUTE_RECALL_ON_OPEN))
>                         return false;
>         }
>
> @@ -134,16 +212,38 @@ static unsigned int ntfs_reparse_tag_mode(struct re=
parse_point *reparse_attr)
>  unsigned int ntfs_make_symlink(struct ntfs_inode *ni)
>  {
>         s64 attr_size =3D 0;
> +       int err;
>         unsigned int lth;
>         struct reparse_point *reparse_attr;
>         struct wsl_link_reparse_data *wsl_link_data;
>         unsigned int mode =3D 0;
>
> +       kvfree(ni->target);
> +       ni->target =3D NULL;
> +
>         reparse_attr =3D ntfs_attr_readall(ni, AT_REPARSE_POINT, NULL, 0,
>                                          &attr_size);
>         if (reparse_attr && attr_size &&
>             valid_reparse_data(ni, reparse_attr, attr_size)) {
>                 switch (reparse_attr->reparse_tag) {
> +               case IO_REPARSE_TAG_SYMLINK:
> +               {
> +                       struct symlink_reparse_data *data =3D
> +                               (struct symlink_reparse_data *)reparse_at=
tr->reparse_data;
> +                       const __le16 *name =3D (const __le16 *)((u8 *)dat=
a->path_buffer +
> +                                                       le16_to_cpu(data-=
>substitute_name_offset));
> +
> +                       mode =3D ntfs_reparse_tag_mode(reparse_attr);
> +                       if (!(data->flags & cpu_to_le32(SYMLINK_FLAG_RELA=
TIVE)))
> +                               break;
> +
> +                       err =3D ntfs_reparse_target_to_nls(ni->vol, name,
> +                                                        le16_to_cpu(data=
->substitute_name_length),
> +                                                        &ni->target);
> +                       if (err < 0)
> +                               mode =3D 0;
> +                       break;
> +               }
>                 case IO_REPARSE_TAG_LX_SYMLINK:
>                         wsl_link_data =3D
>                                 (struct wsl_link_reparse_data *)reparse_a=
ttr->reparse_data;
>
> --
> 2.43.0
>
>
