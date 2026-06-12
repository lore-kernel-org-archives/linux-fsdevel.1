Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19343E556D
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 16:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781281746; cv=pass; b=tRjousN2ym0w0XEeHkysA6c5iNvPpQkjkiensj6zfRbi4V+eTKs/DW08ENlaNHy2IxSgFB5b9cBua4las/KGo+pXAkLPTlZXjdchVaThDn/rPTODYXfOw5JTmEMR6CPpjvgX95ekH8rwheKR6QQ7ocNex9f9KFXryt+/2MTlq4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781281746; c=relaxed/simple;
	bh=J02zotRkrX9JehJDexnl9sY1KFm208BizczUeCcggp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i2gtOSpedOf/G1cg72smDYieCnZZdTw3vEQVoWgdSoLRLciegVWkCx2/6hIfsixebCjQbsPjIUWiFYZAR9jxYjlpa6nm39sMZaxOgCauZzutYF9z+Y875oftDHwkv6wPZK/GzrxgUL5Jkwrr6GI8jW0cg/4K4pX3enn6kkT/Fck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goJ/NZz5; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goJ/NZz5"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66044692319so165213d50.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2026 09:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781281744; cv=none;
        d=google.com; s=arc-20240605;
        b=AZwCyGotyo+/a5xbTWSHS4q4mzpTe5lDS3d/fcmLRXzVQsf/U9P/vkRnbCUPu6r2OY
         InIh8E0VSaJqBY94/HzKEKLGcNvg2uBLavYciHP5Q81W2Xj4q8ihx85MStXGyHyWlzsS
         iPtFv58D90x+OXOlL2T/Dj8ridd0UjbFpzK1si0fxInMVxUPHX7t4Vbh7pJkVtOFZe4h
         CS3R8wkeHxhaU2QHQTpbqsOtmhYlAxkEQH2IajSzPmvP490rRNSZiO99RKmHJQ+UpfCH
         R9b701iq5dpIFyvhU7lUFp+W99j74MY6rulyqfqY2SYfxtLr78dsdZj3fR/pn2TlLdTq
         uwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1HKjuu9o9sHKnCxEU2rDP2kxmsCm3m4lpiiTHjvScRU=;
        fh=k7UpFR9xCYTc1UKv9uqF0rrFXwewyDjyvoMhl44oYAo=;
        b=YXcRBkZDbD6t8LCTGXuQ39XoBpJlSjOWXADp08RAegjUzWDTC1rFeJjLm3riJBilqk
         Iji07Vuyii9oBIaJ4fZQrVKcH5wMSbXOLiFMzB4AiKz2lg9UB7gkX36cRI19u6tkOuRY
         YBxEkFde94L82Scvx5rOqOEY9/i1bWm9G0IDirdNnrlRSqGQdWoI5u/9UT4VLehFjwx4
         8GlPFCHrRjX4tM6lGOFX4RfvQmjKYcBPWDSWYU3APkxV0HnRGWDn3lacjEpUKpyFF1ZG
         KALfOjmk2o2zOq/Fxnk3cAlFdlOikAPCrNr/ya5fQjQNoiZq6Ujl0CwcM4KFm27JJ/S3
         L+rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781281744; x=1781886544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1HKjuu9o9sHKnCxEU2rDP2kxmsCm3m4lpiiTHjvScRU=;
        b=goJ/NZz5UfMMFDm1/IhN1uShup4mcK3bVZgkq+CHee0a04cZTSthlwY2etTbW95JUd
         hz48yFRP+BTnj/kLbrcztzbzunE9bA/NvO1YWYqzkYXhYDwrgs2ji7dLM8Of+ih4bzHd
         QgbdogzeQOdL1Mw8Hc541PwOUJIaLH/1gE6CrX7n4Yk/+dQ+MTn2Xmak/3pKHQ/oymQx
         bF9PwL3qfY//j7pjkXFUocFofOhMva/KqJj0TVyaQW4lD0TP7KLsHcuilhWRoyAyVDa7
         i4FhRJ3Q3m65HgREk3nVo0w0fOMOpkIazdEq0PRH+Kncr05YWg2maWD4jGnnDJ5e/UJW
         iOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781281744; x=1781886544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1HKjuu9o9sHKnCxEU2rDP2kxmsCm3m4lpiiTHjvScRU=;
        b=TEXqecm8/2wRkaI+6whLeWhGdQZWSMuLNoUrK8wewuiV1RaGhGu3gZSweqFxtSZlpA
         aV+3LNzWgyVRXMuh0Zd+A2FTYzh1RBXC8C2Kur5OQqr5SJ8whVlxmtdRULs22KNtjxzm
         +55TB2dXggEgEdvWQCo0X7ucinESeXREiBLpw41XURNtUNNLqdDzKqqmPbAltHDoFOHZ
         ijrtA0PambdatYz4DcCxtNNaUPbPGR9GldyzkdPrBgSS8f9WGMP2mFR3or5yqvkIMD6u
         wJ+O6AaSGb5+BfzBzTgcNomfckIXYezP6YS2Q5hpuvdVVmHpY2dFHK63Ydud/qN9hVP2
         LWrw==
X-Forwarded-Encrypted: i=1; AFNElJ89C423TbiWOtRTAbJ8Vd+pJMyE+DgLEWoJojnMDMu7DWktyrS1DiCmbaUJwugK6tgmri71g5c59i2xgvpT@vger.kernel.org
X-Gm-Message-State: AOJu0YyPDN0gJudejtqB9xFlhhI2jNi1SI9XNLveJbeXFTGhMRYGJRo3
	5kRci8gEHbeTrVR87k1Wo38sXoB4YpqXWoxQE282DeXhO2jOWbH2H1aiWWtwWtLtFHSNj8Ymnd0
	b0uS3Wh29/skPOe0Ui9Z8S/FdNP+0mpE=
X-Gm-Gg: Acq92OEfrp5WHXxaJxWtc2dg9bMoWTvJWYDHBff5SLBMKYmq8C5Zr9scCgP+1CLDImH
	ctHcdhVv3IXkoi2v16VWscWNyNFDSaHuJuomIVjHWheJRO26AzmJZbhbo47XkFtadJaGzZIyBYv
	hzmKENBgVoJzsX/nepgpD5/woQWF5UJ2y5wFqGemRqtksKAunE2TNKjhutiwpQIx5gcTTB/ZX6T
	qZIHdfQ20PhjZnKUIuysyXrbKS9LteNlo7w1/2O2FgSGJxXC2RefjqfrUcbOKQWA9kbCgUhQMwN
	pmsdd661
X-Received: by 2002:a05:690e:14ca:b0:65e:5342:514f with SMTP id
 956f58d0204a3-662783bccefmr2013587d50.6.1781281743518; Fri, 12 Jun 2026
 09:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612-topic-symlink-v1-0-cc1ebf9528e1@gmail.com> <20260612-topic-symlink-v1-6-cc1ebf9528e1@gmail.com>
In-Reply-To: <20260612-topic-symlink-v1-6-cc1ebf9528e1@gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Sat, 13 Jun 2026 01:28:52 +0900
X-Gm-Features: AVVi8CeadFzpx8IWHftVIj-4cWDCVnfOmvrePf5cMam6jZ3G2oEE43bhB9l-XA0
Message-ID: <CAMrLSE7z7GieT8zHi7LeYg=Hme=x2uS04dq7LHV8R=ZNHzZFzw@mail.gmail.com>
Subject: Re: [PATCH 6/7] ntfs: support creating Windows native symlinks
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hyunchul.

+       err =3D ntfs_set_ntfs_reparse_data(ni, (char *)reparse,
total_reparse_len);
+       if (!err) {
+               for (i =3D 0; i < target_len; i++) {
+                       if (norm_name[i] =3D=3D '\\')
+                               norm_name[i] =3D '/';
+               }
+               ni->target =3D norm_name;
+               norm_name =3D NULL;
+       }
+

This leaves newly-created native absolute symlinks inconsistent with the
same inode after remount. For `ln -s C:/foo`, readlink returns `C:/foo`
immediately after creation, but after remount it returns `./foo` in
`native_symlink=3Drel` and `/??/C:/foo` in `native_symlink=3Draw`.

The create path only updates `ni->target`; it does not populate
`ni->reparse_tag`/`ni->reparse_flags`, so `ntfs_get_link()` cannot apply
the absolute native symlink handling until the inode is reloaded from disk.

+ /* Determine if target is absolute (starts with drive letter like C:) */
+ is_absolute =3D (target_len > 1 && target[1] =3D=3D ':');

This treats `C:foo` as an absolute Windows path, but that form is
drive-relative and should remain a relative symlink target. In QEMU,
`ln -s C:foo` works before remount, but after remount readlink fails in
`native_symlink=3Drel` and raw mode exposes `/??/C:foo`.

Please only classify drive-letter targets as absolute when the colon is
followed by a path separator, e.g. `C:/foo` or `C:\foo`.

Thanks.
DaeMyung.

2026=EB=85=84 6=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 4:41, H=
yunchul Lee <hyc.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> And introduce the symlink=3D<value> mount option to configure how symboli=
c
> links are created. The option accepts "wsl" or "native", with "wsl"
> being the default.
>
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> ---
>  fs/ntfs/inode.c   |   4 ++
>  fs/ntfs/namei.c   |   5 ++-
>  fs/ntfs/reparse.c | 124 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/ntfs/reparse.h |   2 +
>  fs/ntfs/super.c   |  19 +++++++++
>  fs/ntfs/volume.h  |   2 +
>  6 files changed, 155 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index 76595f2e30ff..c2715521e562 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -2382,6 +2382,10 @@ int ntfs_show_options(struct seq_file *sf, struct =
dentry *root)
>                 seq_puts(sf, ",native_symlink=3Drel");
>         else
>                 seq_puts(sf, ",native_symlink=3Draw");
> +       if (NVolSymlinkNative(vol))
> +               seq_puts(sf, ",symlink=3Dnative");
> +       else
> +               seq_puts(sf, ",symlink=3Dwsl");
>         if (vol->sb->s_flags & SB_POSIXACL)
>                 seq_puts(sf, ",acl");
>         return 0;
> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index 88c0b05dde3b..78c159519f9c 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -608,7 +608,10 @@ static struct ntfs_inode *__ntfs_create(struct mnt_i=
dmap *idmap, struct inode *d
>                         goto err_out;
>
>                 if (S_ISLNK(mode)) {
> -                       err =3D ntfs_reparse_set_wsl_symlink(ni, target, =
target_len);
> +                       if (NVolSymlinkNative(vol))
> +                               err =3D ntfs_reparse_set_native_symlink(n=
i, target, target_len);
> +                       else
> +                               err =3D ntfs_reparse_set_wsl_symlink(ni, =
target, target_len);
>                         if (!err)
>                                 rollback_reparse =3D true;
>                 } else if (S_ISBLK(mode) || S_ISCHR(mode) || S_ISSOCK(mod=
e) ||
> diff --git a/fs/ntfs/reparse.c b/fs/ntfs/reparse.c
> index eb1e4424e50d..f5b2a853bea1 100644
> --- a/fs/ntfs/reparse.c
> +++ b/fs/ntfs/reparse.c
> @@ -786,6 +786,130 @@ int ntfs_reparse_set_wsl_symlink(struct ntfs_inode =
*ni,
>         return err;
>  }
>
> +int ntfs_reparse_set_native_symlink(struct ntfs_inode *ni,
> +                                   const char *target, int target_len)
> +{
> +       int err =3D 0;
> +       bool is_absolute;
> +       char *norm_name =3D NULL;
> +       char *sub_name =3D NULL;
> +       char *prt_name =3D NULL;
> +       __le16 *sub_name_utf16 =3D NULL;
> +       __le16 *prt_name_utf16 =3D NULL;
> +       int sub_len, prt_len;
> +       int total_data_len, total_reparse_len;
> +       struct reparse_point *reparse =3D NULL;
> +       struct symlink_reparse_data *data;
> +       int i;
> +
> +       /* Determine if target is absolute (starts with drive letter like=
 C:) */
> +       is_absolute =3D (target_len > 1 && target[1] =3D=3D ':');
> +
> +       /* Normalize and prepare NLS paths */
> +       norm_name =3D kstrdup(target, GFP_NOFS);
> +       if (!norm_name)
> +               return -ENOMEM;
> +
> +       /* Replace '/' with '\' */
> +       for (i =3D 0; i < target_len; i++) {
> +               if (norm_name[i] =3D=3D '/')
> +                       norm_name[i] =3D '\\';
> +       }
> +
> +       if (is_absolute) {
> +               prt_name =3D kstrdup(norm_name, GFP_NOFS);
> +               if (!prt_name) {
> +                       err =3D -ENOMEM;
> +                       goto out;
> +               }
> +               /* Prepend '\??\' to Substitutename */
> +               sub_name =3D kmalloc(target_len + 5, GFP_NOFS);
> +               if (!sub_name) {
> +                       err =3D -ENOMEM;
> +                       goto out;
> +               }
> +               strscpy(sub_name, "\\??\\", target_len + 5);
> +               strcat(sub_name, norm_name);
> +       } else {
> +               /* For relative symlinks (including absolute paths withou=
t drive letters),
> +                * SubstituteName and PrintName are identical.
> +                */
> +               prt_name =3D kstrdup(norm_name, GFP_NOFS);
> +               sub_name =3D kstrdup(norm_name, GFP_NOFS);
> +               if (!prt_name || !sub_name) {
> +                       err =3D -ENOMEM;
> +                       goto out;
> +               }
> +       }
> +
> +       /* Convert NLS paths to UTF-16 */
> +       sub_len =3D ntfs_nlstoucs(ni->vol, sub_name, strlen(sub_name),
> +                               &sub_name_utf16, PATH_MAX);
> +       if (sub_len < 0) {
> +               err =3D sub_len;
> +               goto out;
> +       }
> +
> +       prt_len =3D ntfs_nlstoucs(ni->vol, prt_name, strlen(prt_name),
> +                               &prt_name_utf16, PATH_MAX);
> +       if (prt_len < 0) {
> +               err =3D prt_len;
> +               goto out;
> +       }
> +
> +       /* Check for buffer size limits */
> +       total_data_len =3D sizeof(struct symlink_reparse_data) +
> +               (sub_len + prt_len) * sizeof(__le16);
> +       if (total_data_len > 16384) { /* 16KB max reparse tag size */
> +               err =3D -EFBIG;
> +               goto out;
> +       }
> +
> +       total_reparse_len =3D sizeof(struct reparse_point) + total_data_l=
en;
> +       reparse =3D kvzalloc(total_reparse_len, GFP_NOFS);
> +       if (!reparse) {
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       /* Pack fields in reparse buffer */
> +       reparse->reparse_tag =3D IO_REPARSE_TAG_SYMLINK;
> +       reparse->reparse_data_length =3D cpu_to_le16(total_data_len);
> +       reparse->reserved =3D 0;
> +
> +       data =3D (struct symlink_reparse_data *)reparse->reparse_data;
> +       data->substitute_name_offset =3D 0;
> +       data->substitute_name_length =3D cpu_to_le16(sub_len * sizeof(__l=
e16));
> +       data->print_name_offset =3D data->substitute_name_length;
> +       data->print_name_length =3D cpu_to_le16(prt_len * sizeof(__le16))=
;
> +       data->flags =3D cpu_to_le32(is_absolute ? 0 : SYMLINK_FLAG_RELATI=
VE);
> +
> +       /* Copy names to path_buffer */
> +       memcpy(data->path_buffer, sub_name_utf16, sub_len * sizeof(__le16=
));
> +       memcpy(data->path_buffer + sub_len, prt_name_utf16, prt_len * siz=
eof(__le16));
> +
> +       err =3D ntfs_set_ntfs_reparse_data(ni, (char *)reparse, total_rep=
arse_len);
> +       if (!err) {
> +               for (i =3D 0; i < target_len; i++) {
> +                       if (norm_name[i] =3D=3D '\\')
> +                               norm_name[i] =3D '/';
> +               }
> +               ni->target =3D norm_name;
> +               norm_name =3D NULL;
> +       }
> +
> +out:
> +       kfree(norm_name);
> +       kfree(sub_name);
> +       kfree(prt_name);
> +       if (sub_name_utf16)
> +               kvfree(sub_name_utf16);
> +       if (prt_name_utf16)
> +               kvfree(prt_name_utf16);
> +       kvfree(reparse);
> +       return err;
> +}
> +
>  /*
>   * Set reparse data for a WSL special file other than a symlink
>   * (socket, fifo, character or block device)
> diff --git a/fs/ntfs/reparse.h b/fs/ntfs/reparse.h
> index e36557f29677..c11a5bb7e6a5 100644
> --- a/fs/ntfs/reparse.h
> +++ b/fs/ntfs/reparse.h
> @@ -15,6 +15,8 @@ int ntfs_translate_symlink_path(struct dentry *dentry, =
const char *target,
>                                 char **translated);
>  int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *ni,
>                                  const char *target, int target_len);
> +int ntfs_reparse_set_native_symlink(struct ntfs_inode *ni,
> +                                   const char *symname, int symlen);
>  int ntfs_reparse_set_wsl_not_symlink(struct ntfs_inode *ni, mode_t mode)=
;
>  int ntfs_delete_reparse_index(struct ntfs_inode *ni);
>  int ntfs_remove_ntfs_reparse_data(struct ntfs_inode *ni);
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index e032a247455c..8abe7bee4c0d 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -54,6 +54,17 @@ static const struct constant_table ntfs_native_symlink=
_enums[] =3D {
>         {}
>  };
>
> +enum {
> +       SYMLINK_WSL,
> +       SYMLINK_NATIVE,
> +};
> +
> +static const struct constant_table ntfs_symlink_enums[] =3D {
> +       { "wsl",                SYMLINK_WSL },
> +       { "native",             SYMLINK_NATIVE },
> +       {}
> +};
> +
>  enum {
>         Opt_uid,
>         Opt_gid,
> @@ -78,6 +89,7 @@ enum {
>         Opt_discard,
>         Opt_nocase,
>         Opt_native_symlink,
> +       Opt_symlink,
>  };
>
>  static const struct fs_parameter_spec ntfs_parameters[] =3D {
> @@ -104,6 +116,7 @@ static const struct fs_parameter_spec ntfs_parameters=
[] =3D {
>         fsparam_flag("sparse",                  Opt_sparse),
>         fsparam_flag("nocase",                  Opt_nocase),
>         fsparam_enum("native_symlink",          Opt_native_symlink, ntfs_=
native_symlink_enums),
> +       fsparam_enum("symlink",                 Opt_symlink, ntfs_symlink=
_enums),
>         {}
>  };
>
> @@ -234,6 +247,12 @@ static int ntfs_parse_param(struct fs_context *fc, s=
truct fs_parameter *param)
>                 else
>                         NVolClearNativeSymlinkRel(vol);
>                 break;
> +       case Opt_symlink:
> +               if (result.uint_32 =3D=3D SYMLINK_NATIVE)
> +                       NVolSetSymlinkNative(vol);
> +               else
> +                       NVolClearSymlinkNative(vol);
> +               break;
>         case Opt_sparse:
>                 break;
>         default:
> diff --git a/fs/ntfs/volume.h b/fs/ntfs/volume.h
> index 55298689a7bb..65fd3908af26 100644
> --- a/fs/ntfs/volume.h
> +++ b/fs/ntfs/volume.h
> @@ -196,6 +196,7 @@ enum {
>         NV_Discard,
>         NV_DisableSparse,
>         NV_NativeSymlinkRel,
> +       NV_SymlinkNative,
>  };
>
>  /*
> @@ -233,6 +234,7 @@ DEFINE_NVOL_BIT_OPS(CheckWindowsNames)
>  DEFINE_NVOL_BIT_OPS(Discard)
>  DEFINE_NVOL_BIT_OPS(DisableSparse)
>  DEFINE_NVOL_BIT_OPS(NativeSymlinkRel)
> +DEFINE_NVOL_BIT_OPS(SymlinkNative)
>
>  static inline void ntfs_inc_free_clusters(struct ntfs_volume *vol, s64 n=
r)
>  {
>
> --
> 2.43.0
>
>
