Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A5D3EA66
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785020426; cv=pass; b=sp74i4XGBJGPmIJ8QCbLkI47tqnZQtnw1iajPm2WVLGGbqUSq3yKIylIFbDlZyVV6SnWUfzYr6gq5DJdwTSgydlwci7TMJLfw26oy21RgUDk9BLaMqg5th5fLk0Xz94VAUe9/frsVrTfGJzSBQyA2NoaMe/DlVJhH9io9Ut51lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785020426; c=relaxed/simple;
	bh=bDOet23ok2i+Vku4msUzUVIAH9gBfszWU+26BrATbeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIL3JGjyzicMQmzXIyhE0czsW18iazJgHI0aRaBvpSEVuM9UKmztv2A2KNcfQLo3P+AsKanPabEp0PuiCibDMjpZP2ekbH8NHX2QTepTbNVePRyA5RD5M0sbVz83AhKzfKwvLVB6yCcKgPRoWGPLy4ozMqoJONmQoPObpWq8O9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wg4DyVVB; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wg4DyVVB"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39c8ee87f7eso13732961fa.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 16:00:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785020423; cv=none;
        d=google.com; s=arc-20260327;
        b=ZtrxkJ0CQqjXgrc3WxCEv5krWWAD50k2ib05NRzeYF3qeImFGaMtC4WRXMVWxz1FsE
         XPB9DLxD+4zRb4hw5ryvK4buJLzIxF9SKsqGHoVzkutrKspc9cLCn7OJE2j1SryAcM6p
         +mdJuYSn6dBeTk2LvvRS7hmA+Ryz4EwULxUeJWVXJiiMqa8mrY2Bhm8qNBxW1XQis/t+
         VditZbhNle6nRdUTOOFwGX43gZ0pECQ4Bl7SsCp9FqL6vImioG6LDQP46AjKsOxZVkZy
         e2d2ng2lROVt5HAITxapc+u0h6cPKLnNNKbFwkIzzK/NV4eavBz4SIUhD61pX7tuUvaj
         +bAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4CrQ9yNHEvzBk4bKw+4QRIhsoZN6DsfehlXDZKDdCG4=;
        fh=62cqvQcfpk4FhdFg9FeG50ADBfJj2dpFsIw6CcixK2U=;
        b=PcYyHAfjyEldkwKmRb8blpsiwglepXKfZYhzK3ytOE1HN9GaNJahI3RqyBQPhLNwHa
         BaZ2BODo9oZSzWDf+qMzY+WdtQAHUqYlXq9GBiZmIzZbLezNiSA83USWkOkf0eht1Wi8
         jBU+PkVgqku823r656vpWE17rBzgVn4SI1Eeqoze/dznblMI7yQSg4SHX/JSS62EWBwq
         4NKl2np+FzH2eKc6OefdqYnjevjr8J7m0MhZMhxg2DcJP/6wLgPDmyLn+t/A/v2ZhkML
         vyfih8uX84x7m84V7T3VUG4R/O0E28y9KX46PuoDfX2iI9c4wzapE4iwvyHIWwwzKPgn
         Hm1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785020423; x=1785625223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4CrQ9yNHEvzBk4bKw+4QRIhsoZN6DsfehlXDZKDdCG4=;
        b=Wg4DyVVBwFaeWp2vTr2q/EpvwOrBLw7GDmXq2JH7pDt0aLYnHs0BDhiWxnpG4ALNX9
         8iG5c/u9mm+jC9zo2GkKZtizvxsLBTHQduxjSfm3Y+FrL+f0uxzVhSoMYi2J6wVDOw/h
         5VfcZV5TgbcNWcs4zoET5Ge1AhBNzMXTl8oZAhVxi3xUb4OjyeKprMcg+zn7HxV6qLe6
         v6XUNfFFywYkTCWxIdLw/duZPiz2oziDMQewxjU5ozfU4XgDlOCnMejoqhivFbhizvwE
         ZcQq9Mmpn/z4Kn/Scg9eksRgmDARG5D/4Wr6DV6tWoe8lBKzsEjMCVRpgjT78KnS1uLB
         JxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785020423; x=1785625223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4CrQ9yNHEvzBk4bKw+4QRIhsoZN6DsfehlXDZKDdCG4=;
        b=r5NaVm2iD5lDe+Lo7gOqNEfuX9ot7TYAxoRMjHpNJL8b36yLfP0elEKpSzBoXdFLHu
         UMUSPlQmeGl1oy0QEsvDE4mhWqWUt0v7c2CdiayxDntsSvfkU3dxlagl9uNf3MDq5qNB
         YzHghaXtlsXte/mjjIlFHtK+zakcESWBt63H4Ai/DHZGTRLW9X4LtqVNZCNgE1giZHsm
         fPS6uPDp0LxFfN9dnJvlyU3Lrl2lE2YqgbFCZC3FSi2itZpkMqK5Zum8es2491DA8QtW
         vlhtmjsN6btkTj2KDn9ph+vkDBKnq7Dao2LkFagXCanE+oODShwMUX9bm/PbKN3ZaVLe
         gRJg==
X-Forwarded-Encrypted: i=1; AHgh+RpeorPYDqIZLmV8zdScItLscNaC6ZqYPM9HQoSLpZn3lmWYNwZqvZgjrqPIq5lOfBB35mn6HqDZo+YkQAiq@vger.kernel.org
X-Gm-Message-State: AOJu0Yxax9GaSrZvS8VPIL4gcPHDKqmhgqbT82NyAZJKZYfmsmSAj9vi
	aciLS2w5zsnz7D0oDfo3c9Q0LBe+l1sgY5bp3xQr0uJq6jEnPXXBH8cZsPbOiVGrpgAUDcYSVOf
	CGewVdNbu/CrEa/aqzNWHRY7qhZZZEiA3nicF
X-Gm-Gg: AR+sD13vfhx2DLcg3ehuzw570A8NJypkkXr8yVc2bs5/ZL+hrrKvTWwI0D7nEhgY9zh
	MdqC7zzmH4DvnxGdat4HElRW7QWNcICOTuuizFX+0hf74iX8v8eK29WPVgYJSGdQTiDM3znUnXk
	k4x6yVczqorBxLtc8vWjTp//o2qwHRfuGrBPdol0Bu4THMMltwRMztlLOQglAz8KiE9RaXAJ6BT
	0EHDUGjqLU+Eol/2ZjIN4hhQHUXe9rJJu0Z1HVfeaQk9eIdF2h31Q3ws1u2Kzw=
X-Received: by 2002:a05:6512:31cf:b0:5a8:88f8:9ed4 with SMTP id
 2adb3069b0e04-5b2c1b26f68mr667769e87.30.1785020422785; Sat, 25 Jul 2026
 16:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724222745.2107464-1-slava@dubeyko.com> <20260724222745.2107464-3-slava@dubeyko.com>
In-Reply-To: <20260724222745.2107464-3-slava@dubeyko.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sun, 26 Jul 2026 08:00:06 +0900
X-Gm-Features: AUfX_my3LXNIIx8rJnvq6M3TCwzbE49wvR2sRFr4oq_7dYhXZc8uM16YisFCH9c
Message-ID: <CAKFNMokcPu6DC4hnF=--diBtWzDhU2rROCT-rDGcuoobNzb8xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] nilfs2: switch O_DIRECT reads to iomap
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: hch@lst.de, linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 7:28=E2=80=AFAM Viacheslav Dubeyko  wrote:
>
> Wire the read-only nilfs_iomap_ops added in the previous patch into
> the O_DIRECT read path, and eliminate blockdev_direct_IO() from
> nilfs2 entirely:
>
>  - nilfs_file_open() now sets FMODE_CAN_ODIRECT explicitly, since
>    permission to open the file O_DIRECT was previously implied by
>    aops->direct_IO being non-NULL.
>  - nilfs_file_read_iter() dispatches O_DIRECT reads to iomap_dio_rw()
>    using nilfs_iomap_ops; everything else still goes through
>    generic_file_read_iter() as before.
>  - nilfs_file_write_iter() strips IOCB_DIRECT and falls through to
>    generic_file_write_iter()'s ordinary buffered path. NILFS2 cannot
>    perform true direct I/O writes: new blocks are delay-allocated and
>    only given a real disk address by the segment constructor, which
>    works on buffer_head lists, not iomap. This reproduces today's
>    actual behavior: the old nilfs_direct_IO() already just returned 0
>    for WRITE.
>  - nilfs_direct_IO() and the .direct_IO callback on nilfs_aops are
>    removed.
>  - drop the unnecessary "select LEGACY_DIRECT_IO" from Kconfig
>    in favor of "select FS_IOMAP".
>
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> cc: linux-nilfs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/nilfs2/Kconfig |  2 +-
>  fs/nilfs2/file.c  | 40 +++++++++++++++++++++++++++++++++++++---
>  fs/nilfs2/inode.c | 13 -------------
>  3 files changed, 38 insertions(+), 17 deletions(-)
>
> diff --git a/fs/nilfs2/Kconfig b/fs/nilfs2/Kconfig
> index 7dae168e346e..0a5ace60e6ab 100644
> --- a/fs/nilfs2/Kconfig
> +++ b/fs/nilfs2/Kconfig
> @@ -3,7 +3,7 @@ config NILFS2_FS
>         tristate "NILFS2 file system support"
>         select BUFFER_HEAD
>         select CRC32
> -       select LEGACY_DIRECT_IO
> +       select FS_IOMAP
>         help
>           NILFS2 is a log-structured file system (LFS) supporting continu=
ous
>           snapshotting.  In addition to versioning capability of the enti=
re
> diff --git a/fs/nilfs2/file.c b/fs/nilfs2/file.c
> index f93b68c4877c..ad2e87c049c9 100644
> --- a/fs/nilfs2/file.c
> +++ b/fs/nilfs2/file.c
> @@ -10,9 +10,12 @@
>  #include <linux/fs.h>
>  #include <linux/filelock.h>
>  #include <linux/mm.h>
> +#include <linux/uio.h>
> +#include <linux/iomap.h>
>  #include <linux/writeback.h>
>  #include "nilfs.h"
>  #include "segment.h"
> +#include "iomap.h"
>
>  int nilfs_sync_file(struct file *file, loff_t start, loff_t end, int dat=
async)
>  {
> @@ -133,20 +136,51 @@ static int nilfs_file_mmap_prepare(struct vm_area_d=
esc *desc)
>         return 0;
>  }
>
> +static int nilfs_file_open(struct inode *inode, struct file *file)
> +{
> +       file->f_mode |=3D FMODE_CAN_ODIRECT;
> +       return generic_file_open(inode, file);
> +}
> +
> +static ssize_t nilfs_file_read_iter(struct kiocb *iocb, struct iov_iter =
*to)
> +{
> +       if (iocb->ki_flags & IOCB_DIRECT) {
> +               return iomap_dio_rw(iocb, to, &nilfs_iomap_ops,
> +                                   NULL, 0, NULL, 0);
> +       } else
> +               return generic_file_read_iter(iocb, to);
> +}
> +
> +static ssize_t nilfs_file_write_iter(struct kiocb *iocb, struct iov_iter=
 *from)
> +{
> +       /*
> +        * NILFS2 cannot perform true direct I/O writes: new blocks are
> +        * delay-allocated and are only given a real disk address when
> +        * the segment constructor writes them out as part of a log,
> +        * which works directly on buffer_head lists rather than
> +        * through iomap. Fall back to the ordinary buffered write path
> +        * for O_DIRECT writes.
> +        */
> +       if (iocb->ki_flags & IOCB_DIRECT)
> +               iocb->ki_flags &=3D ~IOCB_DIRECT;
> +
> +       return generic_file_write_iter(iocb, from);
> +}
> +
>  /*
>   * We have mostly NULL's here: the current defaults are ok for
>   * the nilfs filesystem.
>   */
>  const struct file_operations nilfs_file_operations =3D {
>         .llseek         =3D generic_file_llseek,
> -       .read_iter      =3D generic_file_read_iter,
> -       .write_iter     =3D generic_file_write_iter,
> +       .read_iter      =3D nilfs_file_read_iter,
> +       .write_iter     =3D nilfs_file_write_iter,
>         .unlocked_ioctl =3D nilfs_ioctl,
>  #ifdef CONFIG_COMPAT
>         .compat_ioctl   =3D nilfs_compat_ioctl,
>  #endif /* CONFIG_COMPAT */
>         .mmap_prepare   =3D nilfs_file_mmap_prepare,
> -       .open           =3D generic_file_open,
> +       .open           =3D nilfs_file_open,
>         /* .release     =3D nilfs_release_file, */
>         .fsync          =3D nilfs_sync_file,
>         .splice_read    =3D filemap_splice_read,
> diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
> index 51f7e125a311..f4a9d9ea9c3f 100644
> --- a/fs/nilfs2/inode.c
> +++ b/fs/nilfs2/inode.c
> @@ -257,18 +257,6 @@ static int nilfs_write_end(const struct kiocb *iocb,
>         return err ? : copied;
>  }
>
> -static ssize_t
> -nilfs_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
> -{
> -       struct inode *inode =3D file_inode(iocb->ki_filp);
> -
> -       if (iov_iter_rw(iter) =3D=3D WRITE)
> -               return 0;
> -
> -       /* Needs synchronization with the cleaner */
> -       return blockdev_direct_IO(iocb, inode, iter, nilfs_get_block);
> -}
> -
>  const struct address_space_operations nilfs_aops =3D {
>         .read_folio             =3D nilfs_read_folio,
>         .writepages             =3D nilfs_writepages,
> @@ -277,7 +265,6 @@ const struct address_space_operations nilfs_aops =3D =
{
>         .write_begin            =3D nilfs_write_begin,
>         .write_end              =3D nilfs_write_end,
>         .invalidate_folio       =3D block_invalidate_folio,
> -       .direct_IO              =3D nilfs_direct_IO,
>         .migrate_folio          =3D buffer_migrate_folio_norefs,
>         .is_partially_uptodate  =3D block_is_partially_uptodate,
>  };
> --
> 2.43.0

The conversion looks good to me.
(Note: I haven't exhaustively checked for any iomap-specific caveats.)

I verified the build and basic operations in several local
environments, and the changes have been working without any critical
issues so far.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi
