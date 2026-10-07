Received: from mail-yx2-f37.google.com (mail-yx2-f37.google.com [74.125.224.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7639F3B6BF1
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.165
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791344332; cv=pass; b=lt4KWe7XZGypgZHIuYi4WnIL8fJf+GBK543ODDbsBFqow2PjNWfp3yp+1/21YSPQ89VoSgfl36Q2uOF5iBYNpYWFGIUPrDlzLFU6/bYavb8zFz+nGb7/1ohIAFn5pKldNeSPTrITTP5z80D5Gwv84klKpX+zYnT5NzKU/e/F93A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791344332; c=relaxed/simple;
	bh=pLI2rqT/QL6WRF2QczxuaoY888P07c9K5uGI5OgS0HQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCjWNzqFQO8mJRc1qbneOcoUJoMgsjQXLPVh5KJVNbbHY9tJeD+y2nePkAota2pROeRVYEx5znsQe5yLPi9iZmzfcs7zUlbKtg6aS17Zu0WJ7LpIEngCP5brknFUhuBHuqQvFKVtujruY8bWDA2xBDwleUB+13TygGL+UkmNYPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0BLxhtM; arc=pass smtp.client-ip=74.125.224.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0BLxhtM"
Received: by mail-yx2-f37.google.com with SMTP id 00721157ae682-8ae76122241so3094707b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 20:38:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791344327; cv=none;
        d=google.com; s=arc-20260327;
        b=bkYKnexdE7h/IZir7ftAnzNQagn2R4bzF4p3f7uh1FgiTeHueVSa4KdvyO1uaY+WxG
         FJrzP0oT7MsqFGBvI5Z0/G1BOsbmO5LRzycYsYD9R3LQ5LsS37KIbA+M/lxk2sVJPTuL
         vgnYkmByUxrlDz31a94bDAA0K01OJOninUu3HhwFqGhbM84GVQgtjFfqA60lzMtZTJWP
         ZuP/uuPP2BtYD2TLxjyZbzs9DJ0973i5lxv/gjFDVF0UNgbn6r+lxdzUjbq64fQn0V6U
         XrkraktH068eTJA2gVbIz7jVGyZ2Q3vcxDXM3wdugRGiwT5nf/qFxEsD1E5IC5jqcBv0
         zebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kbBy/dDbuWfZVnyOrNkJSKLzRIoLk8enN/spiqsNliM=;
        fh=XQr/5KfBYxa0ETHPjugEW605s2E4nteZthwcljKw2BQ=;
        b=DZCANbqOUmt6BOL+1h5csBtNuTsXpGgvPVl+WxN1c/RrQa60yshoiXWjbmVpu7VowX
         E7mWT0EqZplRJicbrPh1n5mTyB9ENEr43MS+fv9xyTTSvCrFRnrIbgRfxiRrmfzanua6
         8RFUw4nuvmHu0vgZv+1SBpKZfDzgzpQtWh6Qpo/nc+gPzOZvWAESysiUSSlrfjyK1zP6
         SB2PHxLR3oM5MRi+ZQDvA/4P6NIVhsnKUNdeHE3LksIOVvhHIQLTOSSb6ssoP7n2vBls
         Ftwo5tiVlogBRAelhYi/70eMDTyqHV4GzJHPaWtToB9cVYLa4+2DH0Mur0LKBPPXWwE4
         /knQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791344327; x=1791949127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kbBy/dDbuWfZVnyOrNkJSKLzRIoLk8enN/spiqsNliM=;
        b=H0BLxhtM8f/30VpuLb4zYWnlRt8omydGmWL60KzDkVxDqz9YRW6ZijrUIGh0dqqGvU
         VvD/xs22RbBtcMUFU54E2yY5WohzjzS+uEc8/agzInA7v6QajucLpkabzUN0amsHeuuA
         y215hASUyYQcRWXHhgRPLVrxwMkAd4okqzfHuhxNNnVMwEMa64xJRpxy+hf9GGTtvLNn
         Mh6UcUadlE6PntRVccxfrvkw1iABZFwWM7SrFnOLqgneGBbaTf8JY2eQFD96Hz3DwaA0
         grDF9JpKu3LBzv8pgmand+2g+Kuv9Uwquekuc8URJ3MYsAS3xmkj8LMt6ebVba2fJO+O
         TUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791344327; x=1791949127;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kbBy/dDbuWfZVnyOrNkJSKLzRIoLk8enN/spiqsNliM=;
        b=r+G6jzugN04AWveESiQmE6W29Ku4jE/tsigAnoK0OSwrcgG+QbzTU5WjzB1sqGSuPS
         TqpRl+DayOzMr1kkMPbJ2zZpVIrrR+nLCdRNKNx8eKqMMmqGA0qFuVGUscjtt/YLnAMm
         HjwnBUND/0RAW2l5Gm7m0syYhoaHrXVYyZWz7VHFyRQPTIMCUFsd1DHpTYJtTFmLMwkN
         qHb8yT/AGGAtA5w2gLOwdQIiKuwvZh+cxxoKO8ZbA62f6SEFNvaTJ4Bg5g0dweQZg4E4
         ePHZhuobu66YZeROeunTumQw7xPo2B1vzu6LT/0XkpOG5wLYA2Re8oV9SJdBMwJTjAXu
         o1+g==
X-Forwarded-Encrypted: i=1; AKwUvBylyFGc5mpDfafPjfbUg1CTOBtBFblAMQOz87ESVax2pop67lOEy9df51LCnNgKWkA5PTAGNlCvlkcfzmOr@vger.kernel.org
X-Gm-Message-State: AFq9FYIkqDQVkpGT65A1roeynINLmEVoiqs4p4k/SvsmcLTkR9mX22SS
	PYaumAzOpyivGSR4enMCLWT/BaSrHou7RNNTd3BxlgmZ+k4XP5LPVEZe6kUN+5EfAO56iHPlbh5
	R7VgvHubDlTQrGk3KWh1Ki5b397gFY5Q=
X-Gm-Gg: AYBFou33/bvVaFAdL9EoQU46KyAxyDOjP/XlyWKehqnFwIpmASHOXZRqF2C8hieXRGM
	FDKjLwWP36ptSI/xtISlXxo9KwtD+XI0IbkbEf/n5CBQopPhoBboAdgvpp4mmPCkIj4kqZcGhWH
	BsMNwC/ocpJL0xCzH6X3WyM4w3K2wKbONJ5kna5t9lvsQDFvtalbut+7u/+Deo1dD5wUg/JbzmZ
	LPpSrbbVU+fFvIFRaAy23c2Oozh9YHTmabxMTrBLhBJuEYQC80zRNdO+r1W8pQIEr/gM5PCT1vL
	RYunWPU7iOlIQFWcAIrjwljWq4t/JbbygssyLlKd6fc6Enbgo2kANf3hOg==
X-Received: by 2002:a05:690c:4d02:b0:8ab:4cb0:ab47 with SMTP id
 00721157ae682-8b05ae72ec6mr19935747b3.3.1791344326804; Tue, 06 Oct 2026
 20:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006224024.14535-1-linkinjeon@kernel.org> <20261006224024.14535-3-linkinjeon@kernel.org>
In-Reply-To: <20261006224024.14535-3-linkinjeon@kernel.org>
From: CharSyam <charsyam@gmail.com>
Date: Wed, 7 Oct 2026 12:38:33 +0900
X-Gm-Features: AclHuK891mpIpgKXX3E8Nxo7tTUiXNPJ8_Z79Q5Z8avgJ8MgmE4rIM74IAlushU
Message-ID: <CAMrLSE73h6xvZXfQRDF7W9QrnAAjCJr8qyQ9P2MxCQno+5Uokw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] ntfs: add pathname access for named streams
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sebastian.n.feld@gmail.com, 
	cedric.blancher@gmail.com, Lionelcons1972@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namjae,

I built the patches and tested the pathname interface on an NTFS image
in QEMU. I found two issues:

1. **A named stream can be deleted from a read-only base file.**

   I created a file and a named stream, then changed the file to mode
0444. The NTFS `READONLY` attribute was present on disk. As an
unprivileged user, opening the base file for writing failed with
`EACCES`, but `unlink("base:secret")` succeeded and the stream
disappeared.

   The new `ntfs_unlink_named_stream()` path calls
`ntfs_remove_named_stream()` directly. Unlike the ioctl path, it does
not require a writable base-file descriptor. The shared removal helper
checks append-only and immutable flags but does not check the NTFS
`READONLY` attribute. I suggest rejecting removal of a stream from a
`READONLY` base file in the shared helper, and defining the
authorization rule for pathname stream deletion explicitly. This is a
deletion-semantics issue; the test does not establish a privilege
escalation, since the parent directory was writable. The MS-FSA
`FileDispositionInformation` rules also reject deletion when the file
has `FILE_ATTRIBUTE_READONLY`.
2. **Repeated reads update the base file's atime under `relatime`.**

   I read the same named stream twice, two seconds apart. Both reads
changed the base file's atime. A regular file used as a control
changed atime only on the first read; with `noatime`, neither stream
read changed it.

   VFS checks the stream inode's atime before calling `->update_time`.
In `ntfs_stream_update_time_common()`, validation copies the _old_
base atime to the stream inode, then `generic_update_time(base_vi,
...)` updates only the base inode. The stream inode remains stale, so
the next read triggers another update. I suggest refreshing the stream
inode after a successful base update:

   ```
   err =3D ntfs_stream_inode_validate(inode);
   if (!err) {
           err =3D generic_update_time(base_vi, type, flags);
           if (!err)
                   ntfs_stream_inode_refresh(inode);
   }
   ```

   I built and tested this change in QEMU. After the first read, the
second read no longer changed atime. This avoids unnecessary metadata
updates; the test does not imply that every read caused a physical
disk write.

Thanks,
DaeMyung

2026=EB=85=84 10=EC=9B=94 7=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 7:48, N=
amjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Add an optional Windows-style pathname interface for named $DATA streams,
> enabled with streams_interface=3Dwindows. The option defaults to none, an=
d
> the named-stream ioctls remain available regardless of this setting.
>
> Support lookup, creation, and removal of named streams for existing regul=
ar
> files and directories. A stream is opened as a regular file through the
> base-name and stream-name form in the final path component. A stream can =
be
> created only for an existing file or directory. The pathname interface
> accepts a base file name and stream name only. It rejects paths that also
> specify an NTFS attribute type such as $DATA. In windows mode, ordinary
> filenames containing a colon are hidden from directory listings and canno=
t
> be accessed through the pathname interface.
>
> Match stream names case-insensitively. Streams and their base objects
> report the same inode number. Removing the base object while a stream is
> open detaches the stream from the namespace. Since NTFS has no orphan-str=
eam
> list, a crash can leave the stream data unreachable on disk.
>
> Expose named streams as regular file descriptors for the file operations
> requested by Wine, including read, write, fsync, fdatasync,
> sync_file_range, file locking, mmap, futimes, fstat, ftruncate, SEEK_DATA=
,
> SEEK_HOLE, fallocate, and pathname unlink. Stream timestamps are shared
> with the base file. fstat reports the base metadata and inode number with
> the stream's own size and allocation.
>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/ntfs/attrib.c       |  40 +-
>  fs/ntfs/attrib.h       |   2 +-
>  fs/ntfs/dir.c          |   7 +-
>  fs/ntfs/ea.c           |  21 +-
>  fs/ntfs/file.c         | 117 ++++--
>  fs/ntfs/inode.c        |  18 +-
>  fs/ntfs/iomap.c        |  62 +--
>  fs/ntfs/named_stream.c | 897 +++++++++++++++++++++++++++++++++++++++++
>  fs/ntfs/namei.c        | 132 +++++-
>  fs/ntfs/stream.h       |  38 ++
>  fs/ntfs/super.c        |  23 ++
>  fs/ntfs/volume.h       |   3 +
>  fs/ntfs/wof.c          |   6 +-
>  13 files changed, 1280 insertions(+), 86 deletions(-)
>
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 3266415470a7..e94e6714b9a1 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -5485,34 +5485,46 @@ int ntfs_attr_exist(struct ntfs_inode *ni, const =
__le32 type, __le16 *name,
>         return !ret;
>  }
>
> +/*
> + * If @attr_vi is non-NULL, the attribute inode reference is returned to=
 the
> + * caller, which must release it after dropping ni->mrec_lock.
> + */
>  int ntfs_attr_remove(struct ntfs_inode *ni, const __le32 type, __le16 *n=
ame,
> -               u32 name_len)
> +               u32 name_len, struct inode **attr_vi)
>  {
>         int err;
> -       struct inode *attr_vi;
> +       struct inode *vi;
>         struct ntfs_inode *attr_ni;
>
>         ntfs_debug("Entering\n");
>
> +       if (attr_vi)
> +               *attr_vi =3D NULL;
>         if (!ni)
>                 return -EINVAL;
>
> -       attr_vi =3D ntfs_attr_iget(VFS_I(ni), type, name, name_len);
> -       if (IS_ERR(attr_vi)) {
> -               err =3D PTR_ERR(attr_vi);
> -               ntfs_error(ni->vol->sb,
> -                       "Failed to open attribute 0x%02x of inode 0x%llx"=
,
> -                       type, (unsigned long long)ni->mft_no);
> +       vi =3D ntfs_attr_iget(VFS_I(ni), type, name, name_len);
> +       if (IS_ERR(vi)) {
> +               err =3D PTR_ERR(vi);
> +               ntfs_error(ni->vol->sb, "Failed to open attribute 0x%02x =
of inode 0x%llx",
> +                               type, (unsigned long long)ni->mft_no);
>                 return err;
>         }
> -       attr_ni =3D NTFS_I(attr_vi);
> +       attr_ni =3D NTFS_I(vi);
>
>         err =3D ntfs_attr_rm(attr_ni);
> -       if (err)
> -               ntfs_error(ni->vol->sb,
> -                       "Failed to remove attribute 0x%02x of inode 0x%ll=
x",
> -                       type, (unsigned long long)ni->mft_no);
> -       iput(attr_vi);
> +       if (err) {
> +               ntfs_error(ni->vol->sb, "Failed to remove attribute 0x%02=
x of inode 0x%llx",
> +                               type, (unsigned long long)ni->mft_no);
> +       } else {
> +               NInoClearDirty(attr_ni);
> +               clear_nlink(vi);
> +               remove_inode_hash(vi);
> +       }
> +       if (attr_vi)
> +               *attr_vi =3D vi;
> +       else
> +               iput(vi);
>         return err;
>  }
>
> diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
> index 6b4fa9f57640..bee91c9f6f81 100644
> --- a/fs/ntfs/attrib.h
> +++ b/fs/ntfs/attrib.h
> @@ -124,7 +124,7 @@ int ntfs_attr_rm(struct ntfs_inode *ni);
>  int ntfs_attr_exist(struct ntfs_inode *ni, const __le32 type, __le16 *na=
me,
>                 u32 name_len);
>  int ntfs_attr_remove(struct ntfs_inode *ni, const __le32 type, __le16 *n=
ame,
> -               u32 name_len);
> +               u32 name_len, struct inode **attr_vi);
>  int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx);
>  int ntfs_attr_record_move_to(struct ntfs_attr_search_ctx *ctx, struct nt=
fs_inode *ni);
>  int ntfs_attr_add(struct ntfs_inode *ni, __le32 type,
> diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
> index b95173f068cb..5a0e21e7c283 100644
> --- a/fs/ntfs/dir.c
> +++ b/fs/ntfs/dir.c
> @@ -8,6 +8,7 @@
>   */
>
>  #include <linux/blkdev.h>
> +#include <linux/string.h>
>
>  #include "dir.h"
>  #include "mft.h"
> @@ -624,7 +625,6 @@ static inline int ntfs_filldir(struct ntfs_volume *vo=
l,
>                 ntfs_debug("Skipping hidden file.");
>                 return 0;
>         }
> -
>         name_len =3D ntfs_ucstonls(vol, (__le16 *)&ie->key.file_name.file=
_name,
>                         ie->key.file_name.file_name_length, &name,
>                         NTFS_MAX_NAME_LEN * NLS_MAX_CHARSET_SIZE + 1);
> @@ -633,7 +633,10 @@ static inline int ntfs_filldir(struct ntfs_volume *v=
ol,
>                                 (long long)MREF_LE(ie->data.dir.indexed_f=
ile));
>                 return 0;
>         }
> -
> +       if (NVolStreamsWindows(vol) && strchr((char *)name, ':')) {
> +               ntfs_debug("Skipping file name containing a stream separa=
tor.");
> +               return 0;
> +       }
>         mref =3D MREF_LE(ie->data.dir.indexed_file);
>         if (ie->key.file_name.file_attributes & FILE_ATTR_REPARSE_POINT)
>                 dt_type =3D ntfs_reparse_tag_dt_types(vol, mref);
> diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
> index b4fcfbe2da4c..c6845bc8a675 100644
> --- a/fs/ntfs/ea.c
> +++ b/fs/ntfs/ea.c
> @@ -246,7 +246,7 @@ static int ntfs_set_ea(struct inode *inode, const cha=
r *name, size_t name_len,
>                         goto out;
>
>                 if (ntfs_attr_exist(ni, AT_EA, AT_UNNAMED, 0)) {
> -                       err =3D ntfs_attr_remove(ni, AT_EA, AT_UNNAMED, 0=
);
> +                       err =3D ntfs_attr_remove(ni, AT_EA, AT_UNNAMED, 0=
, NULL);
>                         if (err)
>                                 goto out;
>                 }
> @@ -301,11 +301,12 @@ static int ntfs_set_ea(struct inode *inode, const c=
har *name, size_t name_len,
>                 p_ea_info->ea_query_length =3D cpu_to_le32(ea_info_qsize)=
;
>
>                 if ((flags & XATTR_REPLACE) && !val_size && !ea_info_qsiz=
e) {
> -                       err =3D ntfs_attr_remove(ni, AT_EA, AT_UNNAMED, 0=
);
> +                       err =3D ntfs_attr_remove(ni, AT_EA, AT_UNNAMED, 0=
, NULL);
>                         if (err)
>                                 goto out;
>
> -                       err =3D ntfs_attr_remove(ni, AT_EA_INFORMATION, A=
T_UNNAMED, 0);
> +                       err =3D ntfs_attr_remove(ni, AT_EA_INFORMATION, A=
T_UNNAMED,
> +                                       0, NULL);
>                         if (err) {
>                                 /* Restore the original $EA if $EA_INFORM=
ATION removal failed. */
>                                 ntfs_attr_add(ni, AT_EA, AT_UNNAMED, 0, o=
ld_ea_buf,
> @@ -610,6 +611,14 @@ static int ntfs_getxattr(const struct xattr_handler =
*handler,
>         struct ntfs_inode *ni =3D NTFS_I(inode);
>         int err;
>
> +       /*
> +        * Stream permissions and privileges belong to the base inode. Th=
is
> +        * also lets VFS killpriv helpers find the base security attribut=
es.
> +        */
> +       if (ntfs_inode_is_named_stream(ni)) {
> +               ni =3D ni->ext.base_ntfs_ino;
> +               inode =3D VFS_I(ni);
> +       }
>         if (NVolShutdown(ni->vol))
>                 return -EIO;
>
> @@ -716,8 +725,8 @@ static int ntfs_new_attr_flags(struct ntfs_inode *ni,=
 __le32 fattr)
>                         goto err_out;
>
>                 ntfs_attr_reinit_search_ctx(ctx);
> -               err =3D ntfs_attr_lookup(ni->type, ni->name,
> -                               ni->name_len, CASE_SENSITIVE,
> +               err =3D ntfs_attr_lookup(ni->type, ni->name, ni->name_len=
,
> +                               CASE_SENSITIVE,
>                                 0, NULL, 0, ctx);
>                 if (err) {
>                         err =3D -EINVAL;
> @@ -883,6 +892,8 @@ static int ntfs_setxattr(const struct xattr_handler *=
handler,
>         int err;
>         __le32 fattr;
>
> +       if (ntfs_inode_is_named_stream(ni))
> +               return -EOPNOTSUPP;
>         if (NVolShutdown(ni->vol))
>                 return -EIO;
>
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 7818d88b2133..a2e843cf947c 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -17,8 +17,10 @@
>  #include <linux/falloc.h>
>  #include <linux/file.h>
>  #include <linux/filelock.h>
> +#include <linux/list.h>
>  #include <linux/overflow.h>
>  #include <linux/security.h>
> +#include <linux/slab.h>
>  #include <uapi/linux/ntfs.h>
>
>  #include "lcnalloc.h"
> @@ -142,6 +144,11 @@ int ntfs_file_release(struct inode *vi, struct file =
*filp)
>         return 0;
>  }
>
> +struct ntfs_fsync_attr {
> +       struct list_head list;
> +       struct inode *inode;
> +};
> +
>  /*
>   * ntfs_file_fsync - sync a file to disk
>   * @filp:      file to be synced
> @@ -171,6 +178,8 @@ int ntfs_file_fsync(struct file *filp, loff_t start, =
loff_t end,
>         int err, ret =3D 0;
>         struct inode *parent_vi, *ia_vi;
>         struct ntfs_attr_search_ctx *ctx;
> +       struct ntfs_fsync_attr *attr, *next;
> +       LIST_HEAD(attrs);
>         bool non_resident, stream;
>
>         ntfs_debug("Entering for inode 0x%llx.", ni->mft_no);
> @@ -195,8 +204,7 @@ int ntfs_file_fsync(struct file *filp, loff_t start, =
loff_t end,
>
>         /*
>          * file_write_and_wait_range() already flushed this stream mappin=
g.
> -        * Do not walk sibling attribute mappings while holding the base =
MFT
> -        * lock; ordinary file fsync retains its existing behavior below.
> +        * A stream fsync does not need to flush sibling attribute mappin=
gs.
>          */
>         if (stream)
>                 goto sync_volume;
> @@ -232,22 +240,53 @@ int ntfs_file_fsync(struct file *filp, loff_t start=
, loff_t end,
>                         name =3D (__le16 *)((u8 *)ctx->attr + le16_to_cpu=
(ctx->attr->name_offset));
>                         if (ctx->attr->type =3D=3D AT_DATA && ctx->attr->=
name_length =3D=3D 0)
>                                 continue;
> +                       if (ctx->attr->type =3D=3D AT_DATA &&
> +                           ntfs_stream_unlinked(ni, name, ctx->attr->nam=
e_length))
> +                               continue;
>
> +                       attr =3D kmalloc_obj(*attr, GFP_NOFS);
> +                       if (!attr) {
> +                               err =3D -ENOMEM;
> +                               break;
> +                       }
>                         attr_vi =3D ntfs_attr_iget(vi, ctx->attr->type,
>                                                  name, ctx->attr->name_le=
ngth);
> -                       if (IS_ERR(attr_vi))
> +                       if (IS_ERR(attr_vi)) {
> +                               kfree(attr);
>                                 continue;
> -                       spin_lock(&attr_vi->i_lock);
> -                       if (inode_state_read_once(attr_vi) & I_DIRTY_PAGE=
S) {
> -                               spin_unlock(&attr_vi->i_lock);
> -                               filemap_write_and_wait(attr_vi->i_mapping=
);
> -                       } else
> -                               spin_unlock(&attr_vi->i_lock);
> -                       iput(attr_vi);
> +                       }
> +                       if (ntfs_inode_is_named_stream(NTFS_I(attr_vi)))
> +                               atomic_inc(&NTFS_I(attr_vi)->stream_open_=
count);
> +                       attr->inode =3D attr_vi;
> +                       list_add_tail(&attr->list, &attrs);
>                 }
>         }
>         mutex_unlock(&ni->mrec_lock);
>         ntfs_attr_put_search_ctx(ctx);
> +       if (err !=3D -ENOENT && !ret)
> +               ret =3D err;
> +
> +       /* Attribute writeback takes the base inode's MFT record lock. */
> +       list_for_each_entry_safe(attr, next, &attrs, list) {
> +               struct inode *attr_vi =3D attr->inode;
> +
> +               err =3D filemap_write_and_wait(attr_vi->i_mapping);
> +               if (err && !ret)
> +                       ret =3D err;
> +               if (ntfs_inode_is_named_stream(NTFS_I(attr_vi))) {
> +                       err =3D ntfs_stream_put(attr_vi);
> +                       if (err && !ret)
> +                               ret =3D err;
> +               }
> +               iput(attr_vi);
> +               list_del(&attr->list);
> +               kfree(attr);
> +       }
> +
> +       /* Attribute writeback may have updated the base mapping pairs. *=
/
> +       err =3D write_inode_now(vi, 1);
> +       if (err && !ret)
> +               ret =3D err;
>
>  sync_volume:
>         write_inode_now(vol->mftbmp_ino, 1);
> @@ -295,7 +334,6 @@ int ntfs_setattr_size(struct inode *vi, struct iattr =
*attr)
>  {
>         struct ntfs_inode *ni =3D NTFS_I(vi);
>         struct ntfs_inode *base_ni =3D ntfs_base_inode(ni);
> -       struct inode *time_vi =3D vi;
>         bool stream =3D ntfs_inode_is_named_stream(ni);
>         int err;
>         loff_t old_size =3D vi->i_size;
> @@ -333,7 +371,6 @@ int ntfs_setattr_size(struct inode *vi, struct iattr =
*attr)
>                 mutex_unlock(&base_ni->mrec_lock);
>                 if (err)
>                         goto out_unlock_mapping;
> -               time_vi =3D VFS_I(base_ni);
>         } else {
>                 filemap_invalidate_lock(vi->i_mapping);
>         }
> @@ -361,14 +398,10 @@ int ntfs_setattr_size(struct inode *vi, struct iatt=
r *attr)
>                 goto out_unlock_mapping;
>         }
>
> -       if (stream) {
> -               inode_set_mtime_to_ts(time_vi,
> -                               inode_set_ctime_current(time_vi));
> -               mark_inode_dirty(time_vi);
> -       }
> -
>  out_unlock_mapping:
>         filemap_invalidate_unlock(vi->i_mapping);
> +       if (!err && stream)
> +               ntfs_stream_update_base_time(base_ni);
>
>         return err;
>  }
> @@ -500,6 +533,24 @@ int ntfs_getattr(struct mnt_idmap *idmap, const stru=
ct path *path,
>         return 0;
>  }
>
> +/*
> + * Validate a stream before VFS write handling removes privileges or upd=
ates
> + * timestamps on its base inode.
> + */
> +static int ntfs_file_modified(struct kiocb *iocb)
> +{
> +       struct inode *inode =3D file_inode(iocb->ki_filp);
> +       int err;
> +
> +       if (ntfs_inode_is_named_stream(NTFS_I(inode))) {
> +               err =3D ntfs_stream_validate_for_mutation(inode,
> +                               iocb->ki_flags & IOCB_NOWAIT);
> +               if (err)
> +                       return err;
> +       }
> +       return kiocb_modified(iocb);
> +}
> +
>  loff_t ntfs_file_llseek(struct file *file, loff_t offset, int whence)
>  {
>         struct inode *inode =3D file->f_mapping->host;
> @@ -710,7 +761,7 @@ ssize_t ntfs_file_write_iter(struct kiocb *iocb, stru=
ct iov_iter *from)
>         if (ret <=3D 0)
>                 goto out_lock;
>
> -       err =3D file_modified(iocb->ki_filp);
> +       err =3D ntfs_file_modified(iocb);
>         if (err) {
>                 ret =3D err;
>                 goto out_lock;
> @@ -788,13 +839,24 @@ static vm_fault_t ntfs_filemap_page_mkwrite(struct =
vm_fault *vmf)
>  {
>         struct inode *inode =3D file_inode(vmf->vma->vm_file);
>         struct address_space *mapping =3D inode->i_mapping;
> +       bool stream =3D ntfs_inode_is_named_stream(NTFS_I(inode));
> +       int err;
>         vm_fault_t ret;
>
>         if (NInoWofCompressed(NTFS_I(inode)))
>                 return VM_FAULT_SIGBUS;
>
>         sb_start_pagefault(inode->i_sb);
> -       file_update_time(vmf->vma->vm_file);
> +       if (stream) {
> +               err =3D ntfs_stream_validate_for_mutation(inode, false);
> +               if (err)
> +                       goto out_error;
> +               err =3D file_update_time(vmf->vma->vm_file);
> +               if (err)
> +                       goto out_error;
> +       } else {
> +               file_update_time(vmf->vma->vm_file);
> +       }
>
>         /*
>          * Serialize against truncate/fallocate which hold the lock
> @@ -805,6 +867,10 @@ static vm_fault_t ntfs_filemap_page_mkwrite(struct v=
m_fault *vmf)
>         filemap_invalidate_unlock_shared(mapping);
>         sb_end_pagefault(inode->i_sb);
>         return ret;
> +
> +out_error:
> +       sb_end_pagefault(inode->i_sb);
> +       return vmf_error(err);
>  }
>
>  static const struct vm_operations_struct ntfs_file_vm_ops =3D {
> @@ -1281,6 +1347,13 @@ long ntfs_fallocate(struct file *file, int mode, l=
off_t offset, loff_t len)
>                 inode_unlock(vi);
>                 return -EOPNOTSUPP;
>         }
> +       if (stream) {
> +               err =3D ntfs_stream_validate_for_mutation(vi, false);
> +               if (err) {
> +                       inode_unlock(vi);
> +                       return err;
> +               }
> +       }
>         old_size =3D i_size_read(vi);
>
>         inode_dio_wait(vi);
> @@ -1322,9 +1395,7 @@ long ntfs_fallocate(struct file *file, int mode, lo=
ff_t offset, loff_t len)
>
>         if (!err) {
>                 if (stream) {
> -                       inode_set_mtime_to_ts(VFS_I(base_ni),
> -                                       inode_set_ctime_current(VFS_I(bas=
e_ni)));
> -                       mark_inode_dirty(VFS_I(base_ni));
> +                       ntfs_stream_update_base_time(base_ni);
>                 } else {
>                         NInoSetFileNameDirty(ni);
>                         inode_set_mtime_to_ts(vi, inode_set_ctime_current=
(vi));
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index ed2cb7e9e5bb..9d7bb55edfc4 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -1546,6 +1546,10 @@ static int ntfs_read_locked_attr_inode(struct inod=
e *base_vi, struct inode *vi)
>                 vi->i_blocks =3D ni->itype.compressed.size >> 9;
>         else
>                 vi->i_blocks =3D ni->allocated_size >> 9;
> +       if (ni->type =3D=3D AT_DATA && ni->name_len) {
> +               vi->i_op =3D &ntfs_stream_inode_ops;
> +               vi->i_fop =3D &ntfs_stream_file_ops;
> +       }
>         /*
>          * Make sure the base inode does not go away and attach it to the
>          * attribute inode.
> @@ -2536,6 +2540,10 @@ int ntfs_show_options(struct seq_file *sf, struct =
dentry *root)
>                 seq_puts(sf, ",symlink=3Dnative");
>         else
>                 seq_puts(sf, ",symlink=3Dwsl");
> +       if (NVolStreamsWindows(vol))
> +               seq_puts(sf, ",streams_interface=3Dwindows");
> +       else
> +               seq_puts(sf, ",streams_interface=3Dnone");
>         if (vol->sb->s_flags & SB_POSIXACL)
>                 seq_puts(sf, ",acl");
>         return 0;
> @@ -2584,15 +2592,19 @@ int ntfs_extend_initialized_size(struct inode *vi=
, const loff_t offset,
>  int ntfs_truncate_vfs(struct inode *vi, loff_t new_size, loff_t i_size)
>  {
>         struct ntfs_inode *ni =3D NTFS_I(vi);
> +       struct ntfs_inode *mrec_ni =3D ntfs_base_inode(ni);
>         int err;
>
> -       mutex_lock(&ni->mrec_lock);
> +       mutex_lock(&mrec_ni->mrec_lock);
>         err =3D __ntfs_attr_truncate_vfs(ni, new_size, i_size);
> -       mutex_unlock(&ni->mrec_lock);
> +       mutex_unlock(&mrec_ni->mrec_lock);
>         if (err < 0)
>                 return err;
>
> -       inode_set_mtime_to_ts(vi, inode_set_ctime_current(vi));
> +       if (ntfs_inode_is_named_stream(ni))
> +               ntfs_stream_update_base_time(mrec_ni);
> +       else
> +               inode_set_mtime_to_ts(vi, inode_set_ctime_current(vi));
>         return 0;
>  }
>
> diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
> index b4475963e57a..cfc42d82e41b 100644
> --- a/fs/ntfs/iomap.c
> +++ b/fs/ntfs/iomap.c
> @@ -90,11 +90,7 @@ static int ntfs_read_iomap_begin_resident(struct inode=
 *inode, loff_t offset, lo
>         int err =3D 0;
>         char *kattr;
>
> -       if (NInoAttr(ni))
> -               base_ni =3D ni->ext.base_ntfs_ino;
> -       else
> -               base_ni =3D ni;
> -
> +       base_ni =3D ntfs_base_inode(ni);
>         mutex_lock(&base_ni->mrec_lock);
>
>         ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL);
> @@ -140,7 +136,8 @@ static int ntfs_read_iomap_begin_resident(struct inod=
e *inode, loff_t offset, lo
>         if (ctx)
>                 ntfs_attr_put_search_ctx(ctx);
>
> -       if (!err && keep_mrec_lock && iomap->type =3D=3D IOMAP_INLINE) {
> +       if (!err && keep_mrec_lock &&
> +           iomap->type =3D=3D IOMAP_INLINE) {
>                 iomap->private =3D base_ni;
>                 return 0;
>         }
> @@ -390,6 +387,8 @@ static int ntfs_write_simple_iomap_begin_non_resident=
(struct inode *inode, loff_
>                                                       loff_t length, stru=
ct iomap *iomap)
>  {
>         struct ntfs_inode *ni =3D NTFS_I(inode);
> +       struct ntfs_inode *mrec_ni =3D ntfs_inode_is_named_stream(ni) ?
> +                       ntfs_base_inode(ni) : ni;
>         struct ntfs_volume *vol =3D ni->vol;
>         loff_t vcn_ofs, rl_length;
>         struct runlist_element *rl, *rlc;
> @@ -408,7 +407,7 @@ static int ntfs_write_simple_iomap_begin_non_resident=
(struct inode *inode, loff_
>                 up_read(&ni->runlist.lock);
>                 err =3D ntfs_map_runlist(ni, vcn);
>                 if (err) {
> -                       mutex_unlock(&ni->mrec_lock);
> +                       mutex_unlock(&mrec_ni->mrec_lock);
>                         return -ENOENT;
>                 }
>                 down_read(&ni->runlist.lock);
> @@ -422,7 +421,7 @@ static int ntfs_write_simple_iomap_begin_non_resident=
(struct inode *inode, loff_
>         rl =3D __ntfs_attr_find_vcn_nolock(&ni->runlist, vcn);
>         if (IS_ERR(rl)) {
>                 up_write(&ni->runlist.lock);
> -               mutex_unlock(&ni->mrec_lock);
> +               mutex_unlock(&mrec_ni->mrec_lock);
>                 return -EIO;
>         }
>         lcn =3D ntfs_rl_vcn_to_lcn(rl, vcn);
> @@ -453,7 +452,7 @@ static int ntfs_write_simple_iomap_begin_non_resident=
(struct inode *inode, loff_
>                                 "runlist(vcn : %lld, length : %lld) is co=
rrupted\n",
>                                 rl->vcn, rl->length);
>                 up_write(&ni->runlist.lock);
> -               mutex_unlock(&ni->mrec_lock);
> +               mutex_unlock(&mrec_ni->mrec_lock);
>                 return -EIO;
>         }
>
> @@ -467,7 +466,7 @@ static int ntfs_write_simple_iomap_begin_non_resident=
(struct inode *inode, loff_
>                         if (max_clu_count < 0) {
>                                 err =3D max_clu_count;
>                                 up_write(&ni->runlist.lock);
> -                               mutex_unlock(&ni->mrec_lock);
> +                               mutex_unlock(&mrec_ni->mrec_lock);
>                                 return err;
>                         }
>                 }
> @@ -482,7 +481,7 @@ static int ntfs_write_simple_iomap_begin_non_resident=
(struct inode *inode, loff_
>                                         GFP_NOFS);
>                         if (!rlc) {
>                                 up_write(&ni->runlist.lock);
> -                               mutex_unlock(&ni->mrec_lock);
> +                               mutex_unlock(&mrec_ni->mrec_lock);
>                                 return -ENOMEM;
>                         }
>
> @@ -499,7 +498,7 @@ static int ntfs_write_simple_iomap_begin_non_resident=
(struct inode *inode, loff_
>                         if (IS_ERR(rl)) {
>                                 ntfs_error(vol->sb, "Failed to merge runl=
ists");
>                                 up_write(&ni->runlist.lock);
> -                               mutex_unlock(&ni->mrec_lock);
> +                               mutex_unlock(&mrec_ni->mrec_lock);
>                                 kvfree(rlc);
>                                 return PTR_ERR(rl);
>                         }
> @@ -509,7 +508,7 @@ static int ntfs_write_simple_iomap_begin_non_resident=
(struct inode *inode, loff_
>                         ni->i_dealloc_clusters +=3D max_clu_count;
>                 }
>                 up_write(&ni->runlist.lock);
> -               mutex_unlock(&ni->mrec_lock);
> +               mutex_unlock(&mrec_ni->mrec_lock);
>
>                 if (lcn < LCN_DELALLOC)
>                         ntfs_hold_dirty_clusters(vol, max_clu_count);
> @@ -561,7 +560,7 @@ static int ntfs_write_simple_iomap_begin_non_resident=
(struct inode *inode, loff_
>                 }
>         } else {
>                 up_write(&ni->runlist.lock);
> -               mutex_unlock(&ni->mrec_lock);
> +               mutex_unlock(&mrec_ni->mrec_lock);
>
>                 iomap->type =3D IOMAP_MAPPED;
>                 iomap->addr =3D ntfs_cluster_to_bytes(vol, lcn) + vcn_ofs=
;
> @@ -586,6 +585,8 @@ static int ntfs_write_da_iomap_begin_non_resident(str=
uct inode *inode,
>                 struct iomap *iomap, int ntfs_iomap_flags)
>  {
>         struct ntfs_inode *ni =3D NTFS_I(inode);
> +       struct ntfs_inode *mrec_ni =3D ntfs_inode_is_named_stream(ni) ?
> +                       ntfs_base_inode(ni) : ni;
>         struct ntfs_volume *vol =3D ni->vol;
>         loff_t vcn_ofs, rl_length;
>         s64 vcn, start_lcn, lcn_count;
> @@ -604,7 +605,7 @@ static int ntfs_write_da_iomap_begin_non_resident(str=
uct inode *inode,
>                         max_clu_count, &balloc, update_mp,
>                         ntfs_iomap_flags & NTFS_IOMAP_FLAGS_WRITEBACK);
>         up_write(&ni->runlist.lock);
> -       mutex_unlock(&ni->mrec_lock);
> +       mutex_unlock(&mrec_ni->mrec_lock);
>         if (err) {
>                 ni->i_dealloc_clusters =3D 0;
>                 return err;
> @@ -658,8 +659,8 @@ static int ntfs_write_da_iomap_begin_non_resident(str=
uct inode *inode,
>
>         if (ntfs_iomap_flags & NTFS_IOMAP_FLAGS_MKWRITE &&
>             iomap->offset + iomap->length > ni->initialized_size) {
> -               err =3D ntfs_attr_set_initialized_size(ni, iomap->offset =
+
> -                               iomap->length);
> +               err =3D ntfs_attr_set_initialized_size(ni,
> +                               iomap->offset + iomap->length);
>         }
>
>         return err;
> @@ -669,13 +670,15 @@ static int ntfs_write_iomap_begin_resident(struct i=
node *inode, loff_t offset,
>                 struct iomap *iomap)
>  {
>         struct ntfs_inode *ni =3D NTFS_I(inode);
> +       struct ntfs_inode *mrec_ni =3D ntfs_inode_is_named_stream(ni) ?
> +                       ntfs_base_inode(ni) : ni;
>         struct attr_record *a;
> -       struct ntfs_attr_search_ctx *ctx;
> +       struct ntfs_attr_search_ctx *ctx =3D NULL;
>         u32 attr_len;
>         int err =3D 0;
>         char *kattr;
>
> -       ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> +       ctx =3D ntfs_attr_get_search_ctx(mrec_ni, NULL);
>         if (!ctx) {
>                 err =3D -ENOMEM;
>                 goto out;
> @@ -698,13 +701,14 @@ static int ntfs_write_iomap_begin_resident(struct i=
node *inode, loff_t offset,
>         iomap->inline_data =3D kattr;
>         iomap->offset =3D 0;
>         iomap->length =3D attr_len;
> +       iomap->private =3D mrec_ni;
>
>  out:
>         if (ctx)
>                 ntfs_attr_put_search_ctx(ctx);
>
>         if (err)
> -               mutex_unlock(&ni->mrec_lock);
> +               mutex_unlock(&mrec_ni->mrec_lock);
>
>         return err;
>  }
> @@ -713,7 +717,12 @@ static int ntfs_write_iomap_begin_non_resident(struc=
t inode *inode, loff_t offse
>                                                loff_t length, unsigned in=
t flags,
>                                                struct iomap *iomap, int n=
tfs_iomap_flags)
>  {
> -       mutex_lock(&NTFS_I(inode)->mrec_lock);
> +       struct ntfs_inode *ni =3D NTFS_I(inode);
> +       struct ntfs_inode *mrec_ni =3D ntfs_inode_is_named_stream(ni) ?
> +                       ntfs_base_inode(ni) : ni;
> +
> +       mutex_lock(&mrec_ni->mrec_lock);
> +
>         if (ntfs_iomap_flags & NTFS_IOMAP_FLAGS_BEGIN)
>                 return  ntfs_write_simple_iomap_begin_non_resident(inode,=
 offset,
>                                                                    length=
, iomap);
> @@ -729,12 +738,15 @@ static int __ntfs_write_iomap_begin(struct inode *i=
node, loff_t offset,
>                                     struct iomap *iomap, int ntfs_iomap_f=
lags)
>  {
>         struct ntfs_inode *ni =3D NTFS_I(inode);
> +       struct ntfs_inode *mrec_ni;
>
>         if (NVolShutdown(ni->vol))
>                 return -EIO;
>
>         if (!NInoNonResident(ni)) {
> -               mutex_lock(&ni->mrec_lock);
> +               mrec_ni =3D ntfs_inode_is_named_stream(ni) ?
> +                               ntfs_base_inode(ni) : ni;
> +               mutex_lock(&mrec_ni->mrec_lock);
>                 return ntfs_write_iomap_begin_resident(inode, offset, iom=
ap);
>         }
>         return  ntfs_write_iomap_begin_non_resident(inode, offset, length=
, flags,
> @@ -753,10 +765,10 @@ static int ntfs_write_iomap_end_resident(struct ino=
de *inode, loff_t pos,
>                                          loff_t length, ssize_t written,
>                                          unsigned int flags, struct iomap=
 *iomap)
>  {
> -       struct ntfs_inode *ni =3D NTFS_I(inode);
> +       struct ntfs_inode *base_ni =3D iomap->private;
>
> -       mark_mft_record_dirty(ni);
> -       mutex_unlock(&ni->mrec_lock);
> +       mark_mft_record_dirty(base_ni);
> +       mutex_unlock(&base_ni->mrec_lock);
>         return written;
>  }
>
> diff --git a/fs/ntfs/named_stream.c b/fs/ntfs/named_stream.c
> index f18312db9859..0c547a35cf2d 100644
> --- a/fs/ntfs/named_stream.c
> +++ b/fs/ntfs/named_stream.c
> @@ -6,6 +6,7 @@
>   */
>
>  #include <linux/file.h>
> +#include <linux/namei.h>
>  #include <linux/overflow.h>
>
>  #include <uapi/linux/ntfs.h>
> @@ -176,6 +177,594 @@ bool ntfs_stream_unlinked(struct ntfs_inode *base_n=
i,
>         return unlinked;
>  }
>
> +/*
> + * ntfs_stream_path_parse() - Split a pathname stream component
> + * @vol: NTFS volume
> + * @qname: final pathname component
> + * @path: receives slices of @qname on success
> + *
> + * Parse the ``file:stream`` form when the Windows pathname interface is
> + * enabled. This does not convert or validate the component names.
> + *
> + * Return: 1 if stream syntax was parsed, 0 if streams are disabled or n=
o
> + * stream separator is present, or -EINVAL for malformed syntax.
> + */
> +int ntfs_stream_path_parse(struct ntfs_volume *vol,
> +               const struct qstr *qname, struct ntfs_stream_path *path)
> +{
> +       const unsigned char *colon;
> +
> +       if (!NVolStreamsWindows(vol))
> +               return 0;
> +
> +       colon =3D memchr(qname->name, ':', qname->len);
> +       if (!colon)
> +               return 0;
> +       if (colon =3D=3D qname->name || colon + 1 =3D=3D qname->name + qn=
ame->len)
> +               return -EINVAL;
> +       if (memchr(colon + 1, ':', qname->name + qname->len - colon - 1))
> +               return -EINVAL;
> +
> +       path->base_name =3D (const char *)qname->name;
> +       path->base_len =3D colon - qname->name;
> +       path->stream_name =3D (const char *)colon + 1;
> +       path->stream_len =3D qname->name + qname->len - colon - 1;
> +       return 1;
> +}
> +
> +/*
> + * ntfs_stream_path_has_colon() - Check for a pathname stream separator
> + * @vol: NTFS volume
> + * @qname: final pathname component
> + *
> + * Return: true if the Windows pathname interface is enabled and @qname
> + * contains a colon, or false otherwise.
> + */
> +bool ntfs_stream_path_has_colon(struct ntfs_volume *vol,
> +               const struct qstr *qname)
> +{
> +       return NVolStreamsWindows(vol) &&
> +               memchr(qname->name, ':', qname->len);
> +}
> +
> +/*
> + * ntfs_stream_path_check() - Reject stream syntax for unsupported opera=
tions
> + * @vol: NTFS volume
> + * @qname: final pathname component
> + *
> + * Return: 0 for an ordinary name or when streams are disabled,
> + * -EOPNOTSUPP for parsed stream syntax, or -EINVAL for malformed syntax=
.
> + */
> +int ntfs_stream_path_check(struct ntfs_volume *vol,
> +               const struct qstr *qname)
> +{
> +       struct ntfs_stream_path path;
> +       int ret;
> +
> +       ret =3D ntfs_stream_path_parse(vol, qname, &path);
> +       if (ret < 0)
> +               return ret;
> +       return ret ? -EOPNOTSUPP : 0;
> +}
> +
> +/*
> + * ntfs_stream_lookup_inode_by_name() - Look up a base inode by name
> + * @dir_ino: directory containing the base file or directory
> + * @uname: UTF-16LE base name
> + * @uname_len: Length of @uname in UTF-16 code units
> + *
> + * Resolve the directory entry and verify its MFT reference before retur=
ning
> + * the inode.
> + *
> + * Return: Referenced inode on success, or ERR_PTR() on failure.
> + */
> +struct inode *ntfs_stream_lookup_inode_by_name(struct inode *dir_ino,
> +               __le16 *uname, int uname_len)
> +{
> +       struct ntfs_volume *vol =3D NTFS_SB(dir_ino->i_sb);
> +       struct ntfs_name *name =3D NULL;
> +       struct inode *inode;
> +       u64 mref;
> +
> +       mutex_lock(&NTFS_I(dir_ino)->mrec_lock);
> +       mref =3D ntfs_lookup_inode_by_name(NTFS_I(dir_ino), uname, uname_=
len,
> +                       &name);
> +       mutex_unlock(&NTFS_I(dir_ino)->mrec_lock);
> +       kfree(name);
> +
> +       if (IS_ERR_MREF(mref))
> +               return ERR_PTR(MREF_ERR(mref));
> +
> +       inode =3D ntfs_iget(vol->sb, MREF(mref));
> +       if (IS_ERR(inode))
> +               return inode;
> +       if (MSEQNO(mref) !=3D NTFS_I(inode)->seq_no &&
> +           MREF(mref) !=3D FILE_MFT) {
> +               iput(inode);
> +               return ERR_PTR(-EIO);
> +       }
> +       return inode;
> +}
> +
> +/*
> + * Recheck that a stream dentry still names the same base inode and DATA
> + * attribute.
> + */
> +static int ntfs_stream_d_revalidate(struct inode *dir,
> +               const struct qstr *qname, struct dentry *dentry,
> +               unsigned int flags)
> +{
> +       struct inode *inode =3D d_inode(dentry);
> +       struct ntfs_inode *ni;
> +       struct ntfs_stream_path path;
> +       struct inode *base_vi;
> +       __le16 *base_name =3D NULL, *stream_name =3D NULL;
> +       int base_len, stream_len, err, ret =3D 0;
> +
> +       if (flags & LOOKUP_RCU)
> +               return -ECHILD;
> +       if (!inode)
> +               return 0;
> +       if (!inode->i_nlink)
> +               return 0;
> +       if (NVolShutdown(NTFS_SB(dir->i_sb)))
> +               return 0;
> +
> +       ni =3D NTFS_I(inode);
> +       if (!ntfs_inode_is_named_stream(ni))
> +               return 0;
> +
> +       err =3D ntfs_stream_path_parse(NTFS_SB(dir->i_sb), qname, &path);
> +       if (err <=3D 0)
> +               return 0;
> +       base_len =3D ntfs_nlstoucs(NTFS_SB(dir->i_sb), path.base_name,
> +                       path.base_len, &base_name, NTFS_MAX_NAME_LEN);
> +       if (base_len < 0)
> +               goto out;
> +       stream_len =3D ntfs_nlstoucs(NTFS_SB(dir->i_sb), path.stream_name=
,
> +                       path.stream_len, &stream_name, NTFS_MAX_NAME_LEN)=
;
> +       if (stream_len < 0)
> +               goto out;
> +       if (ntfs_check_stream_name(stream_name, stream_len))
> +               goto out;
> +       if (stream_len !=3D ni->name_len ||
> +           !ntfs_names_are_equal(stream_name, stream_len, ni->name,
> +                       ni->name_len, IGNORE_CASE, ni->vol->upcase,
> +                       ni->vol->upcase_len))
> +               goto out;
> +
> +       base_vi =3D ntfs_stream_lookup_inode_by_name(dir, base_name, base=
_len);
> +       if (IS_ERR(base_vi))
> +               goto out;
> +       if (NTFS_I(base_vi) !=3D ni->ext.base_ntfs_ino) {
> +               iput(base_vi);
> +               goto out;
> +       }
> +
> +       mutex_lock(&NTFS_I(base_vi)->mrec_lock);
> +       err =3D ntfs_stream_inode_validate(inode);
> +       mutex_unlock(&NTFS_I(base_vi)->mrec_lock);
> +       iput(base_vi);
> +       if (!err)
> +               ret =3D 1;
> +out:
> +       if (stream_name)
> +               kmem_cache_free(ntfs_name_cache, stream_name);
> +       if (base_name)
> +               kmem_cache_free(ntfs_name_cache, base_name);
> +       return ret;
> +}
> +
> +/* Revalidate stream paths while leaving ordinary NTFS dentries cacheabl=
e. */
> +static int ntfs_dentry_revalidate(struct inode *dir,
> +               const struct qstr *qname, struct dentry *dentry,
> +               unsigned int flags)
> +{
> +       struct inode *inode =3D d_inode(dentry);
> +       struct ntfs_volume *vol =3D NTFS_SB(dir->i_sb);
> +
> +       if (ntfs_stream_path_has_colon(vol, qname))
> +               return ntfs_stream_d_revalidate(dir, qname, dentry, flags=
);
> +       if (inode && ntfs_inode_is_named_stream(NTFS_I(inode)))
> +               return 0;
> +       return 1;
> +}
> +
> +/* Drop stream-path aliases so future lookups recheck their backing attr=
ibute. */
> +static int ntfs_dentry_delete(const struct dentry *dentry)
> +{
> +       struct inode *inode =3D d_inode(dentry);
> +       struct ntfs_volume *vol =3D NTFS_SB(dentry->d_sb);
> +
> +       if (ntfs_stream_path_has_colon(vol, &dentry->d_name) ||
> +           (inode && ntfs_inode_is_named_stream(NTFS_I(inode))))
> +               return always_delete_dentry(dentry);
> +       return 0;
> +}
> +
> +static const struct dentry_operations ntfs_dentry_ops =3D {
> +       .d_revalidate   =3D ntfs_dentry_revalidate,
> +       .d_delete               =3D ntfs_dentry_delete,
> +};
> +
> +/*
> + * ntfs_set_default_dentry_ops() - Install stream-aware dentry operation=
s
> + * @sb: superblock on which to install the operations
> + *
> + * Ensure pathname stream dentries are revalidated and not kept as stale
> + * aliases.
> + */
> +void ntfs_set_default_dentry_ops(struct super_block *sb)
> +{
> +       set_default_d_op(sb, &ntfs_dentry_ops);
> +}
> +
> +/*
> + * ntfs_lookup_stream() - Look up a named stream by pathname
> + * @dir_ino: directory containing the base file or directory
> + * @dent: dentry for the pathname component
> + * @path: parsed base and stream name slices
> + *
> + * Find the existing base inode and its named DATA attribute, then splic=
e the
> + * stream inode into @dent.
> + *
> + * Return: NULL if @dent was instantiated, an alternate dentry if a
> + * disconnected alias was spliced, or ERR_PTR() on failure.
> + */
> +struct dentry *ntfs_lookup_stream(struct inode *dir_ino,
> +               struct dentry *dent, const struct ntfs_stream_path *path)
> +{
> +       struct ntfs_volume *vol =3D NTFS_SB(dir_ino->i_sb);
> +       struct inode *base_vi, *stream_vi;
> +       __le16 *base_uname =3D NULL, *stream_uname =3D NULL;
> +       int base_len, stream_len, err;
> +
> +       if (NVolShutdown(vol))
> +               return ERR_PTR(-EIO);
> +
> +       base_len =3D ntfs_nlstoucs(vol, path->base_name, path->base_len,
> +                       &base_uname, NTFS_MAX_NAME_LEN);
> +       if (base_len < 0)
> +               return ERR_PTR(base_len);
> +
> +       stream_len =3D ntfs_nlstoucs(vol, path->stream_name, path->stream=
_len,
> +                       &stream_uname, NTFS_MAX_NAME_LEN);
> +       if (stream_len < 0) {
> +               kmem_cache_free(ntfs_name_cache, base_uname);
> +               return ERR_PTR(stream_len);
> +       }
> +       err =3D ntfs_check_stream_name(stream_uname, stream_len);
> +       if (err) {
> +               kmem_cache_free(ntfs_name_cache, base_uname);
> +               kmem_cache_free(ntfs_name_cache, stream_uname);
> +               return ERR_PTR(err);
> +       }
> +
> +       base_vi =3D ntfs_stream_lookup_inode_by_name(dir_ino, base_uname,
> +                       base_len);
> +       kmem_cache_free(ntfs_name_cache, base_uname);
> +       if (IS_ERR(base_vi)) {
> +               err =3D PTR_ERR(base_vi);
> +               kmem_cache_free(ntfs_name_cache, stream_uname);
> +               if (err =3D=3D -ENOENT)
> +                       return d_splice_alias(NULL, dent);
> +               return ERR_PTR(err);
> +       }
> +
> +       if (!S_ISREG(base_vi->i_mode) && !S_ISDIR(base_vi->i_mode)) {
> +               iput(base_vi);
> +               kmem_cache_free(ntfs_name_cache, stream_uname);
> +               return ERR_PTR(-ENOTDIR);
> +       }
> +
> +       mutex_lock(&NTFS_I(base_vi)->mrec_lock);
> +       stream_vi =3D ntfs_attr_iget(base_vi, AT_DATA, stream_uname, stre=
am_len);
> +       if (!IS_ERR(stream_vi)) {
> +               if (NInoStreamUnlinked(NTFS_I(stream_vi)))
> +                       err =3D -ENOENT;
> +               else
> +                       err =3D ntfs_stream_inode_validate(stream_vi);
> +       }
> +       mutex_unlock(&NTFS_I(base_vi)->mrec_lock);
> +       if (!IS_ERR(stream_vi) && err) {
> +               iput(stream_vi);
> +               stream_vi =3D ERR_PTR(err);
> +       }
> +       iput(base_vi);
> +       kmem_cache_free(ntfs_name_cache, stream_uname);
> +
> +       if (IS_ERR(stream_vi)) {
> +               err =3D PTR_ERR(stream_vi);
> +               if (err =3D=3D -ENOENT || err =3D=3D -ESTALE)
> +                       return d_splice_alias(NULL, dent);
> +               return ERR_PTR(err);
> +       }
> +
> +       return d_splice_alias(stream_vi, dent);
> +}
> +
> +/*
> + * ntfs_stream_path_names() - Convert and validate pathname stream names
> + * @vol: NTFS volume
> + * @qname: final pathname component
> + * @base_name: receives the allocated UTF-16LE base name
> + * @base_len: receives the base name length in UTF-16 code units
> + * @stream_name: receives the allocated UTF-16LE stream name
> + * @stream_len: receives the stream name length in UTF-16 code units
> + *
> + * Return: 1 if stream names were produced, 0 if @qname has no stream sy=
ntax,
> + * or a negative errno. The caller owns both name buffers on success.
> + */
> +int ntfs_stream_path_names(struct ntfs_volume *vol,
> +               const struct qstr *qname, __le16 **base_name, int *base_l=
en,
> +               __le16 **stream_name, int *stream_len)
> +{
> +       struct ntfs_stream_path path;
> +       int err;
> +
> +       *base_name =3D NULL;
> +       *stream_name =3D NULL;
> +       err =3D ntfs_stream_path_parse(vol, qname, &path);
> +       if (err <=3D 0)
> +               return err;
> +
> +       *base_len =3D ntfs_nlstoucs(vol, path.base_name, path.base_len,
> +                       base_name, NTFS_MAX_NAME_LEN);
> +       if (*base_len < 0)
> +               return *base_len;
> +
> +       *stream_len =3D ntfs_nlstoucs(vol, path.stream_name, path.stream_=
len,
> +                       stream_name, NTFS_MAX_NAME_LEN);
> +       if (*stream_len < 0) {
> +               kmem_cache_free(ntfs_name_cache, *base_name);
> +               *base_name =3D NULL;
> +               return *stream_len;
> +       }
> +
> +       err =3D ntfs_check_bad_windows_name(vol, *base_name, *base_len);
> +       if (err)
> +               goto out_free;
> +       err =3D ntfs_check_stream_name(*stream_name, *stream_len);
> +       if (err)
> +               goto out_free;
> +       err =3D ntfs_check_bad_windows_name(vol, *stream_name, *stream_le=
n);
> +       if (err)
> +               goto out_free;
> +       return 1;
> +
> +out_free:
> +       kmem_cache_free(ntfs_name_cache, *stream_name);
> +       kmem_cache_free(ntfs_name_cache, *base_name);
> +       *stream_name =3D NULL;
> +       *base_name =3D NULL;
> +       return err;
> +}
> +
> +/*
> + * ntfs_create_named_stream() - Create a named DATA stream
> + * @idmap: mount idmap used for permission checks
> + * @dir: directory containing the base object
> + * @base_name: UTF-16LE base name
> + * @base_len: length of @base_name in UTF-16 code units
> + * @stream_name: UTF-16LE stream name
> + * @stream_len: length of @stream_name in UTF-16 code units
> + *
> + * Create the stream on an existing regular file or directory.
> + *
> + * Return: Referenced stream inode on success, or ERR_PTR() on failure.
> + */
> +struct inode *ntfs_create_named_stream(struct mnt_idmap *idmap,
> +               struct inode *dir, __le16 *base_name, int base_len,
> +               __le16 *stream_name, int stream_len)
> +{
> +       struct ntfs_inode *base_ni;
> +       struct inode *base_vi, *stream_vi;
> +       struct inode *rollback_vi =3D NULL;
> +       struct ntfs_attr_search_ctx *ctx;
> +       bool stream_created =3D false;
> +       int err, rollback_err;
> +
> +       base_vi =3D ntfs_stream_lookup_inode_by_name(dir, base_name, base=
_len);
> +       if (IS_ERR(base_vi))
> +               return base_vi;
> +       if (!S_ISREG(base_vi->i_mode) && !S_ISDIR(base_vi->i_mode)) {
> +               iput(base_vi);
> +               return ERR_PTR(-ENOTDIR);
> +       }
> +       err =3D inode_permission(idmap, base_vi, MAY_OPEN | MAY_WRITE);
> +       if (err)
> +               goto out_iput;
> +       if (IS_APPEND(base_vi) || IS_IMMUTABLE(base_vi)) {
> +               err =3D -EPERM;
> +               goto out_iput;
> +       }
> +       if (!(NTFS_SB(base_vi->i_sb)->vol_flags & VOLUME_IS_DIRTY)) {
> +               err =3D ntfs_set_volume_flags(NTFS_SB(base_vi->i_sb),
> +                               VOLUME_IS_DIRTY);
> +               if (err)
> +                       goto out_iput;
> +       }
> +
> +       base_ni =3D NTFS_I(base_vi);
> +       mutex_lock(&base_ni->mrec_lock);
> +       if (NVolShutdown(base_ni->vol)) {
> +               err =3D -EIO;
> +               goto out_unlock;
> +       }
> +       if (NInoBeingDeleted(base_ni) || !base_vi->i_nlink) {
> +               err =3D -ENOENT;
> +               goto out_unlock;
> +       }
> +       if (IS_APPEND(base_vi) || IS_IMMUTABLE(base_vi)) {
> +               err =3D -EPERM;
> +               goto out_unlock;
> +       }
> +       ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL);
> +       if (!ctx) {
> +               err =3D -ENOMEM;
> +               goto out_unlock;
> +       }
> +
> +       err =3D ntfs_attr_lookup(AT_DATA, stream_name, stream_len,
> +                       IGNORE_CASE, 0, NULL, 0, ctx);
> +       if (!err) {
> +               if (ntfs_stream_unlinked(base_ni, stream_name, stream_len=
))
> +                       err =3D -EBUSY;
> +               else
> +                       err =3D -EEXIST;
> +       } else if (err =3D=3D -ENOENT) {
> +               if (NVolShutdown(base_ni->vol)) {
> +                       err =3D -EIO;
> +                       goto out_put_ctx;
> +               }
> +               err =3D ntfs_attr_add(base_ni, AT_DATA, stream_name, stre=
am_len,
> +                               NULL, 0);
> +               if (!err) {
> +                       stream_created =3D true;
> +                       mark_mft_record_dirty(base_ni);
> +               }
> +       }
> +       ntfs_attr_put_search_ctx(ctx);
> +       if (err)
> +               goto out_unlock;
> +
> +       stream_vi =3D ntfs_attr_iget(base_vi, AT_DATA, stream_name, strea=
m_len);
> +       if (!IS_ERR(stream_vi))
> +               err =3D ntfs_stream_inode_validate(stream_vi);
> +       else
> +               err =3D PTR_ERR(stream_vi);
> +       if (err) {
> +               if (stream_created) {
> +                       rollback_err =3D ntfs_attr_remove(base_ni, AT_DAT=
A,
> +                                       stream_name, stream_len, &rollbac=
k_vi);
> +                       if (rollback_err) {
> +                               ntfs_error(base_ni->vol->sb,
> +                                       "Failed to roll back named stream=
 creation.\n");
> +                               if (rollback_err =3D=3D -ENOMEM ||
> +                                   rollback_err =3D=3D -EINTR ||
> +                                   rollback_err =3D=3D -ERESTARTSYS) {
> +                                       err =3D rollback_err;
> +                               } else {
> +                                       NVolSetErrors(base_ni->vol);
> +                                       NVolSetShutdown(base_ni->vol);
> +                                       err =3D -EIO;
> +                               }
> +                       }
> +               }
> +               mutex_unlock(&base_ni->mrec_lock);
> +               if (stream_created)
> +                       ntfs_stream_update_base_time(base_ni);
> +               if (!IS_ERR(stream_vi))
> +                       iput(stream_vi);
> +               if (rollback_vi)
> +                       iput(rollback_vi);
> +               iput(base_vi);
> +               return ERR_PTR(err);
> +       }
> +       mutex_unlock(&base_ni->mrec_lock);
> +       if (stream_created)
> +               ntfs_stream_update_base_time(base_ni);
> +       iput(base_vi);
> +       return stream_vi;
> +
> +out_put_ctx:
> +       ntfs_attr_put_search_ctx(ctx);
> +out_unlock:
> +       mutex_unlock(&base_ni->mrec_lock);
> +out_iput:
> +       iput(base_vi);
> +       return ERR_PTR(err);
> +}
> +
> +/*
> + * ntfs_unlink_named_stream() - Remove a pathname named stream
> + * @dir: directory containing the base object
> + * @dentry: dentry for the named stream
> + *
> + * Return: 0 on success, or a negative errno.
> + */
> +int ntfs_unlink_named_stream(struct inode *dir, struct dentry *dentry)
> +{
> +       struct ntfs_volume *vol =3D NTFS_SB(dir->i_sb);
> +       struct inode *base_vi;
> +       __le16 *base_name =3D NULL, *stream_name =3D NULL;
> +       int base_len, stream_len, path_result, err;
> +
> +       path_result =3D ntfs_stream_path_names(vol, &dentry->d_name, &bas=
e_name,
> +                       &base_len, &stream_name, &stream_len);
> +       if (path_result < 0)
> +               return path_result;
> +       if (!path_result)
> +               return -EINVAL;
> +
> +       base_vi =3D ntfs_stream_lookup_inode_by_name(dir, base_name, base=
_len);
> +       if (IS_ERR(base_vi)) {
> +               err =3D PTR_ERR(base_vi);
> +               goto out_free;
> +       }
> +       if (!S_ISREG(base_vi->i_mode) && !S_ISDIR(base_vi->i_mode)) {
> +               err =3D -ENOTDIR;
> +               goto out_iput;
> +       }
> +       if (!ntfs_inode_is_named_stream(NTFS_I(dentry->d_inode))) {
> +               err =3D -ESTALE;
> +               goto out_iput;
> +       }
> +       if (NTFS_I(dentry->d_inode)->ext.base_ntfs_ino !=3D NTFS_I(base_v=
i)) {
> +               err =3D -ESTALE;
> +               goto out_iput;
> +       }
> +
> +       err =3D ntfs_remove_named_stream(NTFS_I(base_vi), stream_name,
> +                       stream_len, dentry->d_inode);
> +
> +out_iput:
> +       iput(base_vi);
> +out_free:
> +       kmem_cache_free(ntfs_name_cache, stream_name);
> +       kmem_cache_free(ntfs_name_cache, base_name);
> +       return err;
> +}
> +
> +/* Obtain a dentry for the base inode behind a stream inode. */
> +static struct dentry *ntfs_stream_base_dentry(struct inode *inode)
> +{
> +       struct inode *base_vi =3D
> +               VFS_I(NTFS_I(inode)->ext.base_ntfs_ino);
> +       struct dentry *dentry;
> +
> +       dentry =3D d_find_alias(base_vi);
> +       if (dentry)
> +               return dentry;
> +       if (!igrab(base_vi))
> +               return ERR_PTR(-ESTALE);
> +       return d_obtain_alias(base_vi);
> +}
> +
> +/*
> + * ntfs_stream_validate_for_mutation() - Validate a stream before mutati=
on
> + * @inode: stream inode to validate
> + * @nowait: do not wait for the base MFT-record lock
> + *
> + * Return: 0 if the backing DATA attribute is valid, -EAGAIN if a nonblo=
cking
> + * lock attempt fails, or another negative errno.
> + */
> +int ntfs_stream_validate_for_mutation(struct inode *inode, bool nowait)
> +{
> +       struct ntfs_inode *base_ni =3D NTFS_I(inode)->ext.base_ntfs_ino;
> +       int err;
> +
> +       if (nowait) {
> +               if (!mutex_trylock(&base_ni->mrec_lock))
> +                       return -EAGAIN;
> +       } else {
> +               mutex_lock(&base_ni->mrec_lock);
> +       }
> +       err =3D ntfs_stream_inode_validate(inode);
> +       mutex_unlock(&base_ni->mrec_lock);
> +       return err;
> +}
> +
>  /*
>   * Hold a temporary stream reference so unlink cannot remove its attribu=
te
>   * while an operation is using it.
> @@ -201,6 +790,210 @@ static int ntfs_stream_claim(struct inode *inode)
>         return err;
>  }
>
> +/* Stream permission checks use the base inode's permissions. */
> +static int ntfs_stream_permission(struct mnt_idmap *idmap,
> +               struct inode *inode, int mask)
> +{
> +       return inode_permission(idmap,
> +                       VFS_I(NTFS_I(inode)->ext.base_ntfs_ino), mask);
> +}
> +
> +/* Report base metadata with the stream's own size and allocation. */
> +static int ntfs_stream_getattr(struct mnt_idmap *idmap,
> +               const struct path *path, struct kstat *stat,
> +               unsigned int request_mask, unsigned int query_flags)
> +{
> +       struct inode *inode =3D d_backing_inode(path->dentry);
> +       struct ntfs_inode *ni =3D NTFS_I(inode);
> +       struct inode *base_vi =3D VFS_I(ni->ext.base_ntfs_ino);
> +
> +       generic_fillattr(idmap, request_mask, base_vi, stat);
> +       stat->size =3D i_size_read(inode);
> +       stat->blocks =3D (((u64)ni->i_dealloc_clusters <<
> +                       NTFS_SB(inode->i_sb)->cluster_size_bits) >> 9) +
> +                       inode->i_blocks;
> +       stat->blksize =3D NTFS_SB(inode->i_sb)->cluster_size;
> +       stat->result_mask |=3D STATX_BTIME;
> +       stat->btime =3D NTFS_I(base_vi)->i_crtime;
> +
> +       if (NInoCompressed(ni))
> +               stat->attributes |=3D STATX_ATTR_COMPRESSED;
> +       if (NInoEncrypted(ni))
> +               stat->attributes |=3D STATX_ATTR_ENCRYPTED;
> +       if (base_vi->i_flags & S_IMMUTABLE)
> +               stat->attributes |=3D STATX_ATTR_IMMUTABLE;
> +       if (base_vi->i_flags & S_APPEND)
> +               stat->attributes |=3D STATX_ATTR_APPEND;
> +       stat->attributes_mask |=3D STATX_ATTR_COMPRESSED | STATX_ATTR_ENC=
RYPTED |
> +                       STATX_ATTR_IMMUTABLE | STATX_ATTR_APPEND;
> +       stat->mode =3D (stat->mode & ~S_IFMT) | S_IFREG;
> +
> +       if (request_mask & STATX_DIOALIGN) {
> +               unsigned int align =3D
> +                       bdev_logical_block_size(inode->i_sb->s_bdev);
> +
> +               stat->result_mask |=3D STATX_DIOALIGN;
> +               if (!NInoCompressed(ni) && !NInoEncrypted(ni)) {
> +                       stat->dio_mem_align =3D align;
> +                       stat->dio_offset_align =3D align;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +/*
> + * Apply size changes to the stream and route shared inode metadata chan=
ges to
> + * its base inode.
> + */
> +static int ntfs_stream_setattr_common(struct mnt_idmap *idmap,
> +               struct inode *inode, struct iattr *attr)
> +{
> +       struct ntfs_inode *ni =3D NTFS_I(inode);
> +       struct inode *base_vi =3D VFS_I(ni->ext.base_ntfs_ino);
> +       struct dentry *base_dentry =3D NULL;
> +       struct iattr base_attr =3D *attr;
> +       int err;
> +
> +       base_attr.ia_valid &=3D ~ATTR_FILE;
> +       base_attr.ia_file =3D NULL;
> +       if (base_attr.ia_valid & (ATTR_KILL_SUID | ATTR_KILL_SGID))
> +               base_attr.ia_valid &=3D ~ATTR_MODE;
> +       else if (base_attr.ia_valid & ATTR_MODE)
> +               base_attr.ia_mode =3D (base_attr.ia_mode & ~S_IFMT) |
> +                               (base_vi->i_mode & S_IFMT);
> +
> +       if (attr->ia_valid & ATTR_SIZE) {
> +               err =3D inode_permission(idmap, base_vi, MAY_WRITE);
> +               if (err)
> +                       goto out;
> +               if (IS_APPEND(base_vi) || IS_IMMUTABLE(base_vi)) {
> +                       err =3D -EPERM;
> +                       goto out;
> +               }
> +               if (!(ni->vol->vol_flags & VOLUME_IS_DIRTY)) {
> +                       err =3D ntfs_set_volume_flags(ni->vol, VOLUME_IS_=
DIRTY);
> +                       if (err)
> +                               goto out;
> +               }
> +               base_attr.ia_valid &=3D ~ATTR_SIZE;
> +       }
> +
> +       if ((attr->ia_valid & ATTR_SIZE) || base_attr.ia_valid) {
> +               base_dentry =3D ntfs_stream_base_dentry(inode);
> +               if (IS_ERR(base_dentry)) {
> +                       err =3D PTR_ERR(base_dentry);
> +                       base_dentry =3D NULL;
> +                       goto out;
> +               }
> +               inode_lock_nested(base_vi, I_MUTEX_PARENT);
> +               err =3D ntfs_stream_validate_for_mutation(inode, false);
> +               if (err) {
> +                       inode_unlock(base_vi);
> +                       goto out;
> +               }
> +               if (base_attr.ia_valid)
> +                       err =3D notify_change(idmap, base_dentry, &base_a=
ttr,
> +                                       NULL);
> +               else
> +                       err =3D 0;
> +               if (!err)
> +                       ntfs_stream_inode_refresh(inode);
> +               inode_unlock(base_vi);
> +               if (err)
> +                       goto out;
> +       }
> +
> +       if (attr->ia_valid & ATTR_SIZE)
> +               err =3D ntfs_setattr_size(inode, attr);
> +       else
> +               err =3D 0;
> +out:
> +       dput(base_dentry);
> +       return err;
> +}
> +
> +/* Hold the stream against unlink while applying VFS setattr operations.=
 */
> +static int ntfs_stream_setattr(struct mnt_idmap *idmap,
> +               struct dentry *dentry, struct iattr *attr)
> +{
> +       struct inode *inode =3D d_inode(dentry);
> +       struct ntfs_inode *ni =3D NTFS_I(inode);
> +       bool claimed =3D false;
> +       int err;
> +
> +       if (NVolShutdown(ni->vol))
> +               return -EIO;
> +
> +       if (!(attr->ia_valid & ATTR_FILE)) {
> +               err =3D ntfs_stream_claim(inode);
> +               if (err)
> +                       return err;
> +               claimed =3D true;
> +       }
> +
> +       err =3D ntfs_stream_setattr_common(idmap, inode, attr);
> +       if (claimed)
> +               ntfs_stream_put(inode);
> +       return err;
> +}
> +
> +/*
> + * Apply stream timestamp updates to the base inode after validating the
> + * backing attribute under its MFT-record lock. Nonblocking callers get
> + * -EAGAIN.
> + */
> +static int ntfs_stream_update_time_common(struct inode *inode,
> +               enum fs_update_time type, unsigned int flags)
> +{
> +       struct ntfs_inode *base_ni =3D NTFS_I(inode)->ext.base_ntfs_ino;
> +       struct inode *base_vi =3D VFS_I(base_ni);
> +       int err;
> +
> +       if (NVolShutdown(base_ni->vol))
> +               return -EIO;
> +       if (flags & IOCB_NOWAIT)
> +               return -EAGAIN;
> +
> +       mutex_lock(&base_ni->mrec_lock);
> +       if (NVolShutdown(base_ni->vol)) {
> +               err =3D -EIO;
> +               goto out_mrec;
> +       }
> +       err =3D ntfs_stream_inode_validate(inode);
> +       if (!err)
> +               err =3D generic_update_time(base_vi, type, flags);
> +out_mrec:
> +       mutex_unlock(&base_ni->mrec_lock);
> +       return err;
> +}
> +
> +static int ntfs_stream_update_time(struct inode *inode,
> +               enum fs_update_time type, unsigned int flags)
> +{
> +       return ntfs_stream_update_time_common(inode, type, flags);
> +}
> +
> +static ssize_t ntfs_stream_listxattr(struct dentry *dentry, char *buffer=
,
> +               size_t size)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +#ifdef CONFIG_NTFS_FS_POSIX_ACL
> +static struct posix_acl *ntfs_stream_get_acl(struct mnt_idmap *idmap,
> +               struct dentry *dentry, int type)
> +{
> +       return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static int ntfs_stream_set_acl(struct mnt_idmap *idmap,
> +               struct dentry *dentry, struct posix_acl *acl, int type)
> +{
> +       return -EOPNOTSUPP;
> +}
> +#endif
> +
>  /*
>   * Remove an unlinked stream's DATA attribute after its final active ref=
erence
>   * is released. Base-inode deletion handles the attribute when the base =
is
> @@ -348,6 +1141,80 @@ int ntfs_remove_named_stream(struct ntfs_inode *ni,=
 __le16 *uname,
>         return err;
>  }
>
> +/*
> + * Validate access against the base inode and hold the stream against un=
link
> + * until the file is released.
> + */
> +static int ntfs_stream_file_open(struct inode *inode, struct file *file)
> +{
> +       struct ntfs_inode *ni =3D NTFS_I(inode);
> +       struct ntfs_inode *base_ni =3D ni->ext.base_ntfs_ino;
> +       struct inode *base_vi =3D VFS_I(base_ni);
> +       int mask =3D MAY_OPEN;
> +       int err;
> +
> +       if (file->f_mode & FMODE_READ)
> +               mask |=3D MAY_READ;
> +       if (file->f_mode & FMODE_WRITE)
> +               mask |=3D MAY_WRITE;
> +       err =3D inode_permission(file_mnt_idmap(file), base_vi, mask);
> +       if (err)
> +               return err;
> +
> +       mutex_lock(&base_ni->mrec_lock);
> +       if (NInoStreamUnlinked(ni))
> +               err =3D -ENOENT;
> +       else
> +               err =3D ntfs_stream_inode_validate(inode);
> +       if (err)
> +               goto out_unlock;
> +       if ((file->f_mode & FMODE_WRITE) &&
> +           (IS_IMMUTABLE(base_vi) ||
> +            (IS_APPEND(base_vi) && !(file->f_flags & O_APPEND)))) {
> +               err =3D -EPERM;
> +               goto out_unlock;
> +       }
> +       if ((file->f_flags & O_TRUNC) && IS_APPEND(base_vi)) {
> +               err =3D -EPERM;
> +               goto out_unlock;
> +       }
> +       if ((file->f_flags & O_NOATIME) &&
> +           !inode_owner_or_capable(file_mnt_idmap(file), base_vi)) {
> +               err =3D -EPERM;
> +               goto out_unlock;
> +       }
> +       err =3D ntfs_file_open(inode, file);
> +       if (err)
> +               goto out_unlock;
> +       if (file->f_mode & FMODE_WRITE) {
> +               err =3D get_write_access(base_vi);
> +               if (err)
> +                       goto out_unlock;
> +               file->private_data =3D base_vi;
> +       }
> +
> +       atomic_inc(&ni->stream_open_count);
> +out_unlock:
> +       mutex_unlock(&base_ni->mrec_lock);
> +       return err;
> +}
> +
> +/* Drop open-time references and complete any deferred stream unlink. */
> +static int ntfs_stream_file_release(struct inode *inode, struct file *fi=
le)
> +{
> +       int err, remove_err;
> +
> +       err =3D ntfs_file_release(inode, file);
> +       if (file->private_data) {
> +               put_write_access(file->private_data);
> +               file->private_data =3D NULL;
> +       }
> +       remove_err =3D ntfs_stream_put(inode);
> +       if (!err)
> +               err =3D remove_err;
> +       return err;
> +}
> +
>  enum ntfs_stream_ioctl_op {
>         NTFS_STREAM_IOCTL_READ,
>         NTFS_STREAM_IOCTL_WRITE,
> @@ -617,6 +1484,9 @@ static long ntfs_ioctl_stream(struct file *filp, uns=
igned long arg,
>                         file_accessed(filp);
>         } else {
>                 inode_lock(stream_vi);
> +               inode_dio_wait(stream_vi);
> +               /* Exclude faults before taking MFT record and folio lock=
s. */
> +               filemap_invalidate_lock(stream_vi->i_mapping);
>                 err =3D inode_newsize_ok(stream_vi, pos + data_size);
>                 if (!err) {
>                         ret =3D ntfs_inode_attr_pwrite(stream_vi, pos, da=
ta_size,
> @@ -626,6 +1496,7 @@ static long ntfs_ioctl_stream(struct file *filp, uns=
igned long arg,
>                         else
>                                 req->bytes_returned =3D ret;
>                 }
> +               filemap_invalidate_unlock(stream_vi->i_mapping);
>                 inode_unlock(stream_vi);
>         }
>         if (claimed) {
> @@ -913,3 +1784,29 @@ int ntfs_ioctl_list_streams(struct file *filp, unsi=
gned long arg)
>         kvfree(kbuf);
>         return ret;
>  }
> +
> +const struct file_operations ntfs_stream_file_ops =3D {
> +       .llseek         =3D ntfs_file_llseek,
> +       .read_iter      =3D ntfs_file_read_iter,
> +       .write_iter     =3D ntfs_file_write_iter,
> +       .fsync          =3D ntfs_file_fsync,
> +       .fallocate      =3D ntfs_fallocate,
> +       .mmap_prepare   =3D ntfs_file_mmap_prepare,
> +       .open           =3D ntfs_stream_file_open,
> +       .release        =3D ntfs_stream_file_release,
> +       .splice_read    =3D ntfs_file_splice_read,
> +       .splice_write   =3D iter_file_splice_write,
> +};
> +
> +const struct inode_operations ntfs_stream_inode_ops =3D {
> +       .permission     =3D ntfs_stream_permission,
> +       .setattr        =3D ntfs_stream_setattr,
> +       .getattr        =3D ntfs_stream_getattr,
> +       .listxattr      =3D ntfs_stream_listxattr,
> +#ifdef CONFIG_NTFS_FS_POSIX_ACL
> +       .get_acl        =3D ntfs_stream_get_acl,
> +       .set_acl        =3D ntfs_stream_set_acl,
> +#endif
> +       .update_time    =3D ntfs_stream_update_time,
> +       .fiemap         =3D ntfs_fiemap,
> +};
> diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> index 3cf58befd77f..9251951a76fb 100644
> --- a/fs/ntfs/namei.c
> +++ b/fs/ntfs/namei.c
> @@ -8,6 +8,7 @@
>
>  #include <linux/exportfs.h>
>  #include <linux/iversion.h>
> +#include <linux/namei.h>
>
>  #include "ntfs.h"
>  #include "time.h"
> @@ -15,6 +16,7 @@
>  #include "reparse.h"
>  #include "object_id.h"
>  #include "ea.h"
> +#include "stream.h"
>
>  static const __le16 aux_name_le[3] =3D {
>         cpu_to_le16('A'), cpu_to_le16('U'), cpu_to_le16('X')
> @@ -57,7 +59,18 @@ static inline int ntfs_check_bad_char(const __le16 *wc=
, unsigned int wc_len)
>         return 0;
>  }
>
> -static int ntfs_check_bad_windows_name(struct ntfs_volume *vol,
> +/*
> + * ntfs_check_bad_windows_name() - Validate a name against Windows rules
> + * @vol: NTFS volume
> + * @wc: UTF-16LE name
> + * @wc_len: length of @wc in UTF-16 code units
> + *
> + * When Windows-name checks are enabled, reject disallowed characters,
> + * trailing spaces or dots, and reserved DOS device names.
> + *
> + * Return: 0 if valid, or -EINVAL otherwise.
> + */
> +int ntfs_check_bad_windows_name(struct ntfs_volume *vol,
>                                        const __le16 *wc,
>                                        unsigned int wc_len)
>  {
> @@ -167,19 +180,29 @@ static int ntfs_check_bad_windows_name(struct ntfs_=
volume *vol,
>   *
>   * Locking: Caller must hold i_mutex on the directory.
>   */
> +
>  static struct dentry *ntfs_lookup(struct inode *dir_ino, struct dentry *=
dent,
>                 unsigned int flags)
>  {
>         struct ntfs_volume *vol =3D NTFS_SB(dir_ino->i_sb);
> +       struct ntfs_stream_path stream_path;
>         struct inode *dent_inode;
>         __le16 *uname;
>         struct ntfs_name *name =3D NULL;
>         u64 mref;
>         unsigned long dent_ino;
>         int uname_len;
> +       int stream_path_len;
>
>         ntfs_debug("Looking up %pd in directory inode 0x%llx.",
>                         dent, NTFS_I(dir_ino)->mft_no);
> +       stream_path_len =3D ntfs_stream_path_parse(vol, &dent->d_name,
> +                       &stream_path);
> +       if (stream_path_len < 0)
> +               return ERR_PTR(stream_path_len);
> +       if (stream_path_len)
> +               return ntfs_lookup_stream(dir_ino, dent, &stream_path);
> +
>         /* Convert the name of the dentry to Unicode. */
>         uname_len =3D ntfs_nlstoucs(vol, dent->d_name.name, dent->d_name.=
len,
>                                   &uname, NTFS_MAX_NAME_LEN);
> @@ -405,6 +428,7 @@ static struct ntfs_inode *__ntfs_create(struct mnt_id=
map *idmap, struct inode *d
>         struct inode *vi;
>         struct mft_record *ni_mrec, *dni_mrec;
>         struct super_block *sb =3D dir_ni->vol->sb;
> +       struct inode *rollback_data_vi =3D NULL, *rollback_sd_vi =3D NULL=
;
>         __le64 parent_mft_ref;
>         u64 child_mft_ref;
>         __le16 ea_size;
> @@ -694,11 +718,25 @@ static struct ntfs_inode *__ntfs_create(struct mnt_=
idmap *idmap, struct inode *d
>         return ni;
>
>  err_out:
> -       if (rollback_sd)
> -               ntfs_attr_remove(ni, AT_SECURITY_DESCRIPTOR, AT_UNNAMED, =
0);
> +       if (rollback_sd) {
> +               int rollback_err;
>
> -       if (rollback_data)
> -               ntfs_attr_remove(ni, AT_DATA, AT_UNNAMED, 0);
> +               rollback_err =3D ntfs_attr_remove(ni,
> +                               AT_SECURITY_DESCRIPTOR, AT_UNNAMED, 0,
> +                               &rollback_sd_vi);
> +               if (rollback_err)
> +                       ntfs_error(sb,
> +                               "Failed to roll back security descriptor.=
\n");
> +       }
> +
> +       if (rollback_data) {
> +               int rollback_err;
> +
> +               rollback_err =3D ntfs_attr_remove(ni, AT_DATA, AT_UNNAMED=
,
> +                               0, &rollback_data_vi);
> +               if (rollback_err)
> +                       ntfs_error(sb, "Failed to roll back DATA attribut=
e.\n");
> +       }
>
>         if (rollback_reparse)
>                 ntfs_delete_reparse_index(ni);
> @@ -726,6 +764,10 @@ static struct ntfs_inode *__ntfs_create(struct mnt_i=
dmap *idmap, struct inode *d
>         mutex_unlock(&dir_ni->mrec_lock);
>         mutex_unlock(&ni->mrec_lock);
>
> +       if (rollback_data_vi)
> +               iput(rollback_data_vi);
> +       if (rollback_sd_vi)
> +               iput(rollback_sd_vi);
>         remove_inode_hash(vi);
>         discard_new_inode(vi);
>         return ERR_PTR(err);
> @@ -736,12 +778,35 @@ static int ntfs_create(struct mnt_idmap *idmap, str=
uct inode *dir,
>  {
>         struct ntfs_volume *vol =3D NTFS_SB(dir->i_sb);
>         struct ntfs_inode *ni;
> -       __le16 *uname;
> -       int uname_len, err;
> +       struct inode *stream_vi =3D NULL;
> +       __le16 *uname, *base_name =3D NULL, *stream_name =3D NULL;
> +       int uname_len, stream_len, path_result, err;
>
>         if (NVolShutdown(vol))
>                 return -EIO;
>
> +       path_result =3D ntfs_stream_path_names(vol, &dentry->d_name, &bas=
e_name,
> +                       &uname_len, &stream_name, &stream_len);
> +       if (path_result) {
> +               if (path_result < 0)
> +                       return path_result;
> +               stream_vi =3D ntfs_create_named_stream(idmap, dir, base_n=
ame,
> +                               uname_len, stream_name, stream_len);
> +               if (IS_ERR(stream_vi)) {
> +                       err =3D PTR_ERR(stream_vi);
> +                       goto out_free_stream_names;
> +               }
> +               kmem_cache_free(ntfs_name_cache, stream_name);
> +               kmem_cache_free(ntfs_name_cache, base_name);
> +               d_instantiate(dentry, stream_vi);
> +               return 0;
> +
> +out_free_stream_names:
> +               kmem_cache_free(ntfs_name_cache, stream_name);
> +               kmem_cache_free(ntfs_name_cache, base_name);
> +               return err;
> +       }
> +
>         uname_len =3D ntfs_nlstoucs(vol, dentry->d_name.name, dentry->d_n=
ame.len,
>                                   &uname, NTFS_MAX_NAME_LEN);
>         if (uname_len < 0) {
> @@ -758,7 +823,8 @@ static int ntfs_create(struct mnt_idmap *idmap, struc=
t inode *dir,
>
>         ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
>
> -       ni =3D __ntfs_create(idmap, dir, uname, uname_len, S_IFREG | mode=
, 0, NULL, 0);
> +       ni =3D __ntfs_create(idmap, dir, uname, uname_len, S_IFREG | mode=
, 0,
> +                       NULL, 0);
>         kmem_cache_free(ntfs_name_cache, uname);
>         if (IS_ERR(ni))
>                 return PTR_ERR(ni);
> @@ -850,10 +916,10 @@ static int ntfs_delete(struct ntfs_inode *ni, struc=
t ntfs_inode *dir_ni,
>         struct file_name_attr *fn =3D NULL;
>         bool looking_for_dos_name =3D false, looking_for_win32_name =3D f=
alse;
>         bool case_sensitive_match =3D true;
> +       bool link_count_zero =3D false;
>         int err =3D 0;
>         struct mft_record *ni_mrec;
>         struct super_block *sb;
> -       bool link_count_zero =3D false;
>
>         ntfs_debug("Entering.\n");
>
> @@ -1025,6 +1091,11 @@ static int ntfs_unlink(struct inode *dir, struct d=
entry *dentry)
>         if (NVolShutdown(vol))
>                 return -EIO;
>
> +       if (ntfs_stream_path_has_colon(vol, &dentry->d_name))
> +               return ntfs_unlink_named_stream(dir, dentry);
> +       if (NInoAttr(ni))
> +               return -EOPNOTSUPP;
> +
>         uname_len =3D ntfs_nlstoucs(vol, dentry->d_name.name, dentry->d_n=
ame.len,
>                                   &uname, NTFS_MAX_NAME_LEN);
>         if (uname_len < 0) {
> @@ -1068,6 +1139,10 @@ static struct dentry *ntfs_mkdir(struct mnt_idmap =
*idmap, struct inode *dir,
>         if (NVolShutdown(vol))
>                 return ERR_PTR(-EIO);
>
> +       err =3D ntfs_stream_path_check(vol, &dentry->d_name);
> +       if (err)
> +               return ERR_PTR(err);
> +
>         uname_len =3D ntfs_nlstoucs(vol, dentry->d_name.name, dentry->d_n=
ame.len,
>                                   &uname, NTFS_MAX_NAME_LEN);
>         if (uname_len < 0) {
> @@ -1084,7 +1159,8 @@ static struct dentry *ntfs_mkdir(struct mnt_idmap *=
idmap, struct inode *dir,
>
>         ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
>
> -       ni =3D __ntfs_create(idmap, dir, uname, uname_len, mode, 0, NULL,=
 0);
> +       ni =3D __ntfs_create(idmap, dir, uname, uname_len, mode, 0,
> +                       NULL, 0);
>         kmem_cache_free(ntfs_name_cache, uname);
>         if (IS_ERR(ni)) {
>                 err =3D PTR_ERR(ni);
> @@ -1108,6 +1184,10 @@ static int ntfs_rmdir(struct inode *dir, struct de=
ntry *dentry)
>         if (NVolShutdown(vol))
>                 return -EIO;
>
> +       err =3D ntfs_stream_path_check(vol, &dentry->d_name);
> +       if (err)
> +               return err;
> +
>         ni =3D NTFS_I(vi);
>         uname_len =3D ntfs_nlstoucs(vol, dentry->d_name.name, dentry->d_n=
ame.len,
>                                   &uname, NTFS_MAX_NAME_LEN);
> @@ -1272,6 +1352,13 @@ static int ntfs_rename(struct mnt_idmap *idmap, st=
ruct inode *old_dir,
>         if (NVolShutdown(old_dir_ni->vol))
>                 return -EIO;
>
> +       err =3D ntfs_stream_path_check(vol, &old_dentry->d_name);
> +       if (err)
> +               return err;
> +       err =3D ntfs_stream_path_check(vol, &new_dentry->d_name);
> +       if (err)
> +               return err;
> +
>         if (flags & (RENAME_EXCHANGE | RENAME_WHITEOUT))
>                 return -EINVAL;
>
> @@ -1419,6 +1506,10 @@ static int ntfs_symlink(struct mnt_idmap *idmap, s=
truct inode *dir,
>         if (NVolShutdown(vol))
>                 return -EIO;
>
> +       err =3D ntfs_stream_path_check(vol, &dentry->d_name);
> +       if (err)
> +               return err;
> +
>         usrc_len =3D ntfs_nlstoucs(vol, dentry->d_name.name,
>                                  dentry->d_name.len, &usrc, NTFS_MAX_NAME=
_LEN);
>         if (usrc_len < 0) {
> @@ -1464,6 +1555,10 @@ static int ntfs_mknod(struct mnt_idmap *idmap, str=
uct inode *dir,
>         if (NVolShutdown(vol))
>                 return -EIO;
>
> +       err =3D ntfs_stream_path_check(vol, &dentry->d_name);
> +       if (err)
> +               return err;
> +
>         uname_len =3D ntfs_nlstoucs(vol, dentry->d_name.name,
>                         dentry->d_name.len, &uname, NTFS_MAX_NAME_LEN);
>         if (uname_len < 0) {
> @@ -1516,6 +1611,13 @@ static int ntfs_link(struct dentry *old_dentry, st=
ruct inode *dir,
>         if (NVolShutdown(vol))
>                 return -EIO;
>
> +       if (NInoAttr(ni))
> +               return -EOPNOTSUPP;
> +
> +       err =3D ntfs_stream_path_check(vol, &dentry->d_name);
> +       if (err)
> +               return err;
> +
>         uname_len =3D ntfs_nlstoucs(vol, dentry->d_name.name,
>                         dentry->d_name.len, &uname, NTFS_MAX_NAME_LEN);
>         if (uname_len < 0) {
> @@ -1669,11 +1771,19 @@ static struct dentry *ntfs_fh_to_parent(struct su=
per_block *sb, struct fid *fid,
>                                     ntfs_nfs_get_inode);
>  }
>
> +static int ntfs_encode_fh(struct inode *inode, u32 *fh, int *max_len,
> +               struct inode *parent)
> +{
> +       if (ntfs_inode_is_named_stream(NTFS_I(inode)))
> +               return -EOPNOTSUPP;
> +       return generic_encode_ino32_fh(inode, fh, max_len, parent);
> +}
> +
>  /*
>   * Export operations allowing NFS exporting of mounted NTFS partitions.
>   */
>  const struct export_operations ntfs_export_ops =3D {
> -       .encode_fh =3D generic_encode_ino32_fh,
> +       .encode_fh      =3D ntfs_encode_fh,
>         .get_parent     =3D ntfs_get_parent,      /* Find the parent of a=
 given directory. */
>         .fh_to_dentry   =3D ntfs_fh_to_dentry,
>         .fh_to_parent   =3D ntfs_fh_to_parent,
> diff --git a/fs/ntfs/stream.h b/fs/ntfs/stream.h
> index da0096d2b751..5cbf6e8f6b68 100644
> --- a/fs/ntfs/stream.h
> +++ b/fs/ntfs/stream.h
> @@ -7,8 +7,38 @@
>  struct ntfs_inode;
>  struct ntfs_volume;
>
> +struct ntfs_stream_path {
> +       const char *base_name;
> +       unsigned int base_len;
> +       const char *stream_name;
> +       unsigned int stream_len;
> +};
> +
> +int ntfs_check_bad_windows_name(struct ntfs_volume *vol,
> +               const __le16 *name, unsigned int name_len);
>  int ntfs_check_stream_name(const __le16 *name, unsigned int name_len);
>
> +int ntfs_stream_path_parse(struct ntfs_volume *vol,
> +               const struct qstr *qname, struct ntfs_stream_path *path);
> +bool ntfs_stream_path_has_colon(struct ntfs_volume *vol,
> +               const struct qstr *qname);
> +int ntfs_stream_path_check(struct ntfs_volume *vol,
> +               const struct qstr *qname);
> +int ntfs_stream_path_names(struct ntfs_volume *vol,
> +               const struct qstr *qname, __le16 **base_name, int *base_l=
en,
> +               __le16 **stream_name, int *stream_len);
> +
> +struct inode *ntfs_stream_lookup_inode_by_name(struct inode *dir,
> +               __le16 *name, int name_len);
> +struct dentry *ntfs_lookup_stream(struct inode *dir, struct dentry *dent=
ry,
> +               const struct ntfs_stream_path *path);
> +struct inode *ntfs_create_named_stream(struct mnt_idmap *idmap,
> +               struct inode *dir, __le16 *base_name, int base_len,
> +               __le16 *stream_name, int stream_len);
> +int ntfs_unlink_named_stream(struct inode *dir, struct dentry *dentry);
> +
> +void ntfs_set_default_dentry_ops(struct super_block *sb);
> +
>  void ntfs_stream_inode_refresh(struct inode *inode);
>  int ntfs_stream_inode_validate(struct inode *inode);
>  void ntfs_stream_update_base_time(struct ntfs_inode *base_ni);
> @@ -18,11 +48,19 @@ int ntfs_stream_put(struct inode *inode);
>  int ntfs_remove_named_stream(struct ntfs_inode *ni, __le16 *name,
>                 u32 name_len, struct inode *expected_inode);
>
> +int ntfs_stream_validate_for_mutation(struct inode *inode, bool nowait);
>  long ntfs_ioctl_stream_read(struct file *file, unsigned long arg);
>  long ntfs_ioctl_stream_write(struct file *file, unsigned long arg);
>  long ntfs_ioctl_stream_remove(struct file *file, unsigned long arg);
>  int ntfs_ioctl_list_streams(struct file *file, unsigned long arg);
>
> +extern const struct file_operations ntfs_stream_file_ops;
> +extern const struct inode_operations ntfs_stream_inode_ops;
> +
> +/*
> + * Common file operations used by both ordinary files and named streams.
> + * Their implementations remain in file.c.
> + */
>  int ntfs_file_open(struct inode *inode, struct file *file);
>  int ntfs_file_release(struct inode *inode, struct file *file);
>  int ntfs_file_fsync(struct file *file, loff_t start, loff_t end,
> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> index 2c6685342999..a88fb935aa9c 100644
> --- a/fs/ntfs/super.c
> +++ b/fs/ntfs/super.c
> @@ -22,6 +22,7 @@
>  #include "ntfs.h"
>  #include "ea.h"
>  #include "volume.h"
> +#include "stream.h"
>
>  /* A global default upcase table and a corresponding reference count. */
>  static __le16 *default_upcase;
> @@ -66,6 +67,17 @@ static const struct constant_table ntfs_symlink_enums[=
] =3D {
>         {}
>  };
>
> +enum {
> +       STREAMS_INTERFACE_NONE,
> +       STREAMS_INTERFACE_WINDOWS,
> +};
> +
> +static const struct constant_table ntfs_streams_interface_enums[] =3D {
> +       { "none",       STREAMS_INTERFACE_NONE },
> +       { "windows",    STREAMS_INTERFACE_WINDOWS },
> +       {}
> +};
> +
>  enum {
>         Opt_uid,
>         Opt_gid,
> @@ -91,6 +103,7 @@ enum {
>         Opt_nocase,
>         Opt_native_symlink,
>         Opt_symlink,
> +       Opt_streams_interface,
>  };
>
>  static const struct fs_parameter_spec ntfs_parameters[] =3D {
> @@ -118,6 +131,8 @@ static const struct fs_parameter_spec ntfs_parameters=
[] =3D {
>         fsparam_flag("nocase",                  Opt_nocase),
>         fsparam_enum("native_symlink",          Opt_native_symlink, ntfs_=
native_symlink_enums),
>         fsparam_enum("symlink",                 Opt_symlink, ntfs_symlink=
_enums),
> +       fsparam_enum("streams_interface",       Opt_streams_interface,
> +                    ntfs_streams_interface_enums),
>         {}
>  };
>
> @@ -254,6 +269,12 @@ static int ntfs_parse_param(struct fs_context *fc, s=
truct fs_parameter *param)
>                 else
>                         NVolClearSymlinkNative(vol);
>                 break;
> +       case Opt_streams_interface:
> +               if (result.uint_32 =3D=3D STREAMS_INTERFACE_WINDOWS)
> +                       NVolSetStreamsWindows(vol);
> +               else
> +                       NVolClearStreamsWindows(vol);
> +               break;
>         case Opt_sparse:
>                 break;
>         default:
> @@ -2586,6 +2607,8 @@ static int ntfs_fill_super(struct super_block *sb, =
struct fs_context *fc)
>          * operations and associated address space operations to function=
.
>          */
>         sb->s_op =3D &ntfs_sops;
> +       if (NVolStreamsWindows(vol))
> +               ntfs_set_default_dentry_ops(sb);
>         tmp_ino =3D new_inode(sb);
>         if (!tmp_ino) {
>                 if (!silent)
> diff --git a/fs/ntfs/volume.h b/fs/ntfs/volume.h
> index 0473b602084c..8ee2a904a96e 100644
> --- a/fs/ntfs/volume.h
> +++ b/fs/ntfs/volume.h
> @@ -195,6 +195,7 @@ struct ntfs_volume {
>   * NV_DisableSparse            Disable creation of sparse regions.
>   * NV_NativeSymlinkRel         Translate absolute Windows reparse target=
s (native_symlink=3Drel).
>   * NV_MftBootstrap             Mount is still assembling $MFT's own runl=
ist.
> + * NV_StreamsWindows           Interpret the final path component as fil=
e:stream.
>   */
>  enum {
>         NV_Errors,
> @@ -216,6 +217,7 @@ enum {
>         NV_NativeSymlinkRel,
>         NV_SymlinkNative,
>         NV_MftBootstrap,
> +       NV_StreamsWindows,
>  };
>
>  /*
> @@ -256,6 +258,7 @@ DEFINE_NVOL_BIT_OPS(DisableSparse)
>  DEFINE_NVOL_BIT_OPS(NativeSymlinkRel)
>  DEFINE_NVOL_BIT_OPS(SymlinkNative)
>  DEFINE_NVOL_BIT_OPS(MftBootstrap)
> +DEFINE_NVOL_BIT_OPS(StreamsWindows)
>
>  static inline void ntfs_inc_free_clusters(struct ntfs_volume *vol, s64 n=
r)
>  {
> diff --git a/fs/ntfs/wof.c b/fs/ntfs/wof.c
> index 9847259e5b1a..294dbe5d711f 100644
> --- a/fs/ntfs/wof.c
> +++ b/fs/ntfs/wof.c
> @@ -311,7 +311,8 @@ static int parse_wof_chunk_table(struct ntfs_inode *b=
ase_ni,
>                         goto out_unlock_mrec;
>                 }
>                 ret =3D ntfs_attr_lookup(ni->type, ni->name, ni->name_len=
,
> -                                      CASE_SENSITIVE, 0, NULL, 0, ctx);
> +                                      CASE_SENSITIVE,
> +                                      0, NULL, 0, ctx);
>                 if (ret)
>                         goto out_put_ctx;
>
> @@ -399,7 +400,8 @@ static int ntfs_read_wof_chunk(struct ntfs_volume *vo=
l,
>         }
>
>         err =3D ntfs_attr_lookup(wof_ni->type, wof_ni->name, wof_ni->name=
_len,
> -                              CASE_SENSITIVE, 0, NULL, 0, ctx);
> +                              CASE_SENSITIVE,
> +                              0, NULL, 0, ctx);
>         if (err)
>                 goto out_put_ctx;
>
> --
> 2.25.1
>
>
