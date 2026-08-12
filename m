Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071E4480357
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786574152; cv=pass; b=hXf/jOPK1LAdIOWEUCjIMYfTLVWg0lA/5kmdfDyf4mt3m8u2Y4STpvMQH0uIkjNLrikJ7KYKIW7c5KkfGYOYEp1iO1vlOPlaMatkVDrAQwDolhnkspk56wIn7ifhCpKHqhz8jT8/D/Ng9IYBxZPT9iaugsl1qxZn+deqU3ZruPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786574152; c=relaxed/simple;
	bh=XBtfCUZM4Z9MokOc0RnrVmWkdPYRIPype7rhWltePJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NK9MjJsUlYx4NYHEVCxLIuyK2jkyuuG7RISbbmMcV6ft4gfYofvQQ8SzLgFOPxrE6oMI2mboAQTE4Pgg8gEIZMJdd9ZCLqhQeNnBEXiyTf9sYCfiA7Bkn1+tCINa6QDEU++ZMFUBBBsknKoJlMOOZ8dgKPF1Qn1mB1xNBlbns/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DR/5KBhb; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DR/5KBhb"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6679d88abdcso2446786d50.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 15:35:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786574150; cv=none;
        d=google.com; s=arc-20260327;
        b=XsbZD7X0far7SZ/ei6fP1PCnYCALSYOmnG2XBA7qUuV5T1TLvnEttYtjUK1pb/ry3C
         z/CuyzJbQ57ozfUXgCDPJ/iMTiFjeAeltRS57wfyttdO6WvkmUFjZgg03RNQbmD641XW
         GN/om6dHW6+zEm7h/4gRhnAWsmD6HI0uVv1iCKjmxYktyLtQhz8weq0/fGqvkb8nn1fm
         DHR/LLUzcj9Juce002+mwgL77bsyU0RCvQI6fjjxkx2TC1gbkv9hYdZ14gc/tHqm9X0/
         9kQ7QltqOpZK8oWo2+c8o3R8ed0oM3aocTivGTQC+voc4FZHQS4+sWzecJQlVA88T4Px
         yg4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xPFhYpYz44bCMeCCXzJP9sZEpYNf9oMMJbpv0EJdICY=;
        fh=Lt0TUabF7zasTKosO+nLvQkK33s/X3AqaaulgQ4CmR8=;
        b=ALDq0MwkKeUW0qYotqVPoxaTuz3Bw/W3NsEbH7TcvCvBvP8pIb61fry+zwXM2OMPtI
         n1qnwSMEvJ3IC5VD8HeSKrli7AX2561EIF4MnHcjmsqvnv2XbbgEztSDJw8E8TrQmqwN
         nVgSMt9YOoRb7bXfmFoabBp0nc7pETOwPrszmifIV5BLKz1Q3X44sWeOJvVgM/V6iZG0
         Zoj0Tp+E0Y1hrvB3+3qeq/Ui1bV0TuwHJwy2artiR4s2TUi9tC9GkEas7d3m8oisyJXm
         6TmnQt2ftuKVdRSEWJoHessWSbZBZruTElBzsJ3NYHxQbXVmQi/i2Qdvam1zl5ane8y1
         9Jaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786574150; x=1787178950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xPFhYpYz44bCMeCCXzJP9sZEpYNf9oMMJbpv0EJdICY=;
        b=DR/5KBhbUGFSmkzYvUKru1hxAHW2vgVDiMENMrwcfAgY1xBCxjbgKYE0gyfHUsOLrR
         lo7X99aElbY7l3wcgJAnhCrNFKRPg8K2oTwYV/0Ne1QsP4np+QDyKPHm8E98xWRhiGww
         NaQHXXBNm8GGd7klpbSZlu4rTXlcaFYK4dFmyMsxuWPD+2OI0jEixKX2UJiT9mtDd1FT
         kLgsNu2i52hlcHjXP7Ef2hsWd3rkFmr7BuRcwqQvhD+VlUSbOPYER6UaB9iQyg7fQn6B
         JumUYLM3bCLGBqtY/WGYzGoKzWYTDFvGV89+qgGdVISfC9D/aimj9IGJEeCQ4eEVW83Y
         L27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786574150; x=1787178950;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xPFhYpYz44bCMeCCXzJP9sZEpYNf9oMMJbpv0EJdICY=;
        b=AEKE1PRNrZut3A3cuvt0g/uObi14iY3A8qdnNigjVcHhPhyaVp8HVRVjBi/b3yCk4S
         QEQ5Ys8pj25F1w1adfTzqwXIQCfKbJZppq4qEMjvwhVNMmN+dSd7nrOEXx2r8sH50DSa
         bW917GNKtzzJDugfamXz9mkmcDEIxlTlF5laOodAJ2+bAEhs097KSgVWv8aPtRDhG7pB
         xaLZuLGPbynWgS15Vcglhli5ssa/6xuk1zV4drbCVASrV9U+wWGDbO2ijhJh2AeGO0Z6
         9xahHGKhu+vrylAv2bwuJCKM1UiGpEDVncIThTazHieJ0CEp1pFNUxeRweyiPo3btoZc
         fbSA==
X-Forwarded-Encrypted: i=1; AHgh+RrMCJ5d+IELzd1TpL1TcrUqBs+ruEx9jSG3uE9fbbBYRUjNivcRmFOJFzFHz5oYvIM2srTVRVIkzUe7yjkw@vger.kernel.org
X-Gm-Message-State: AOJu0YyT0Eki/uBYLZgSIxbyqohB+nPpv3pn5j/KhVA69GEQwxGE/7rU
	y6CEMacgXTLaxR4fMvt2dAAnDCuK6zq1XgcOeFKZVsq+AlHtBgM2sHYrtfCMihfdKpbQSm8Zh3C
	OzYd19dpifc2wZY+nIdCqDVHrHA8ME88=
X-Gm-Gg: AR+sD13/3aTbmub0tj5x1qyU49QS0ONkLhL4IB4B9aEi0CcauHMbB3pYawLipkqogdO
	0zA80A6ZRuomkKFMtPa2BHrVsf3gSPAUBQsiHU2AEvtA7EE/6DrWDQddRzewAAMVQUagmVME1fo
	ShE2cBCBdrNiiEeU8XnaSqm9SM2GRly8EY4HXETAdwYz7d2e5+OJPei9/lMrV6G0U8W3vewjkfA
	qGifkaBc1Vrqj4DI+tSR2CJHAm/xCnPkkabfLBKcNoNmRZI+5wqfB8lLNI+uaxXHW431jX7g8kb
	/rrmSB3REQFJh+5om02x2C+jXbAQIccVy9EJ6Dxpel2W557W7PxrG84hSM/oqUzgYQ==
X-Received: by 2002:a53:e199:0:b0:667:ae8a:5207 with SMTP id
 956f58d0204a3-66c515c3b7amr607866d50.26.1786574149231; Wed, 12 Aug 2026
 15:35:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812221154.1119137-1-slava@dubeyko.com> <20260812221154.1119137-3-slava@dubeyko.com>
In-Reply-To: <20260812221154.1119137-3-slava@dubeyko.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 13 Aug 2026 07:35:30 +0900
X-Gm-Features: AUfX_mww-8m1GsEa6bytF5cXbgG39r3jREMYVtIcsdtM96z0eg3fGRZ0tVpLnow
Message-ID: <CAKFNMokYNKF3-gQ1SctOqNJ6YfQAG=7khKRZGLYOpCmY63j2Rw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] nilfs2: switch O_DIRECT to iomap based operations
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: hch@lst.de, brauner@kernel.org, linux-nilfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, lilinmao@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 7:12=E2=80=AFAM Viacheslav Dubeyko wrote:
>
> The patch eliminates blockdev_direct_IO() from
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

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi

>  fs/nilfs2/Kconfig |  2 +-
>  fs/nilfs2/file.c  | 42 +++++++++++++++++++++++++++++++++++++++---
>  fs/nilfs2/inode.c | 13 -------------
>  3 files changed, 40 insertions(+), 17 deletions(-)
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
> index f93b68c4877c..30dd8e5ebe5b 100644
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
> @@ -133,20 +136,53 @@ static int nilfs_file_mmap_prepare(struct vm_area_d=
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
> +       struct inode *inode =3D file_inode(iocb->ki_filp);
> +       ssize_t ret;
> +
> +       if (iocb->ki_flags & IOCB_DIRECT) {
> +               inode_lock_shared(inode);
> +               ret =3D iomap_dio_rw(iocb, to, &nilfs_iomap_ops,
> +                                  NULL, 0, NULL, 0);
> +               inode_unlock_shared(inode);
> +       } else
> +               ret =3D generic_file_read_iter(iocb, to);
> +
> +       return ret;
> +}
> +
> +static ssize_t nilfs_file_write_iter(struct kiocb *iocb, struct iov_iter=
 *from)
> +{
> +       /*
> +        * NILFS2 lacks direct I/O write support: fall back to buffered w=
rites.
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
> index 34e6096069ad..cbe9658ae065 100644
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
>
