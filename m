Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C20C292B4B
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785018814; cv=pass; b=ebdFF9DAPfFPK3YRlF511rrwQIlMHcV+UFA2L1F4Ipf78a8uTao3LHR8GV8cSEwFZPZBsAXifVI+CG8GPUAKGe1XnMbMmvHzS0TPCrTZLJR8ojd9Ti47vbAZQEX55S4XD3+aJwBquMp73wT28erIYexhk1zcZh5KTF7g6y/+P7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785018814; c=relaxed/simple;
	bh=hrX/GHPtSW8MahqWAwnwi59WaV6gzxfxpmaCWpKubtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPWhWLuBEw55y99Cze+0VfXKt/ARzVjmAp4HRE61cUZBWL4yBvSerrRvRRbbGm1ltATPqq7OVl9siFa819eRHELPH7DRQ7QrtOl0rMHGT2EFu5JLW9kShtFQFN0dHpBhu/yTu5oPbyDNJrN59DZfj8uR0hV7h25I4VYTLUvnWG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oft5Ozh2; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oft5Ozh2"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5b29599b81cso1550636e87.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 15:33:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785018811; cv=none;
        d=google.com; s=arc-20260327;
        b=SSzWAPP9Qjlc2eBUtKSHCYm25H9q2d1tBH9A/VnqsAXcTXeYY95JLOtRTIJHkzKvMw
         QMoc95KXri08pR+8c/Zcl46opWopVP5Q60ozY1RKViaugeJXUK320NOkWj+FHETCTCRE
         3ZIKThU7APFb8Sn0y1vlRdWtcnodcNQu+79z51dqRqDWHCFuYkG22n3mNsNIxDjoyrOF
         Urrpn+WAM//KXfE6+cbmHC8yg2uHCrteiVwnQwcNWFdCp2waZnimYdXwUHkkbrpKx/mh
         ha1JoZTvh7neLYmo9hJergevmj2vujcAscWutJtcCXeU0WzUWmDoalB+zc9/kwALspw/
         o8Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FP8dtM0nBvg/LgTgo8RSUeOidpO9ilyWEJOaeWPTvWo=;
        fh=KdXXe5+H5NPOw6MEx59lvCV//j8DxOfNUmJcP9JyEnw=;
        b=U6IkVZ4/mZY+fPUnwm2JxnIMc+EhO6mmOUOYddcnWAXawt0h/ESJDn71T+MzMj4WFK
         kTolfp0VB1xu6jQ1dCto5uPuEC4o1LsdV6sJjRooU+xATdmTj4ymO7NZEtkMdgPSbqP6
         oazDCRxPAMj4nXONLsTWoBUwTzi1zc28pYXWK3F6a+hOWIPU5qjyxYFawLGg0irlFNph
         ha/kgioUPffNMaoFvEfO4dUy0v5iHXrlJlSIcq8Y4zDyDQ1foQjOmNjqk/CulAlpJuAc
         3QT4nxHucG/iVKmEI2d+N5Xc+hG9b+KnUNXKXN1r6bGdwXknR0wXUc52ZCqN00SororL
         XzVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785018811; x=1785623611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FP8dtM0nBvg/LgTgo8RSUeOidpO9ilyWEJOaeWPTvWo=;
        b=Oft5Ozh2acPEBEAjUVltuEq5b7MkHVvzWA+4k+3kqkKaWrjfGny+a7x0wXGDe32BxB
         zMOdI1sAGGo3v0c8k3Sb/WeKbn1PfkCH1yk3/X4SEGaEEaJDyQerqflOhMzZSdpV4C+Q
         /1F5InVq5LGAXXCbhskk7YwK9Jg/nGYaFnL0AceJaCH2PL8OVP7TYLXEoEJZXcm5qRnL
         Ppo5rTPnKLFEB3G3HHBrNpqlIkbqNYxMlBqPB9+zzM2ZLGjy2UuO2dEnjJbRIQ2LW3Xy
         FUUVrWGpkuuBGCK8rjz77SW5aIT43yjxUQ8IvN2voaaCDIbk1SQPmwaAxlVJq4xd2reT
         1NRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785018811; x=1785623611;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FP8dtM0nBvg/LgTgo8RSUeOidpO9ilyWEJOaeWPTvWo=;
        b=Tp5C8Z69qHwpVxahGwhWPh0hB0qCgMorU0AaIyr9FLONWgkZUzM1F9KRg4JL8JLi7b
         XAkXglRxRw8B8/pYp9tlSmTK1C0wD0+J3lPII0WF3KaxmsvSwU8aqOa1r2rZ7xVd6zXX
         z3aoTVO9wD5oxCQUSpGAjil3nx264sUKQlJ4GKIjjV6TlU2kMj1BUSIfYAP7XfzYHhwE
         idjA4aTImk9HNUWQqQlNdZaYoYQ/aVhE9EamJ8Baat7NKhLwiQeof0FK0Q4svuNPItZX
         es8zub2PZQeCsl4pdJIHWU20e6x8tiH0Md+oD7L9oaNq0TDVeSpyk8TzyNB/y34LlEEP
         5BOw==
X-Forwarded-Encrypted: i=1; AHgh+RpK1A2M+xO2shWudE+VCMEt3uIynn/cNvz5lpIyH9DMYANuPU3hDjP4jFWgrkdfKL0E2YRT2R3sRdgQF4X0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6rKFz5zkjOLn56rvJ3HgLbcoZV8vQJsHAMY5FZilNU3yqHQ/V
	ZB4SYYplkqvN0jRawdWp8IK9ylukzZe9SmtHnkepyHYk/pqZI8JVrDWbUWurYOPnOKfFJ9zj7cf
	x8lNE/SzP4SIEyleL1N1zWZBseIwrv0c=
X-Gm-Gg: AR+sD10opZ1KnTnX4/J4LJf6vq3YSYEm2TFzIcdw2Q2DJVnGPjAiIiblUib/agcczrW
	LsfzGeSjOdN268ABMmudRvRIEEm7jt/Lrv3aloie7d3Ay7/xdHO6G/n+WyXLU1bmG64y8mYHaXf
	ucWsTMKMWugc/A08KC1xhzwQ1xjv7Dxe6rlkHf2w7COU2Wkm4ucRC140TLa6sTxwAHYJzauY+RK
	tARg37vftnUF/9Y9tDQnxkPbBrCSUdu3DPmhq5huo+L4hXbVuVJMRtUFDABd0w=
X-Received: by 2002:a05:6512:1243:b0:5aa:6f0e:8404 with SMTP id
 2adb3069b0e04-5b2c1b2d3d4mr681704e87.21.1785018810460; Sat, 25 Jul 2026
 15:33:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724222745.2107464-1-slava@dubeyko.com> <20260724222745.2107464-2-slava@dubeyko.com>
In-Reply-To: <20260724222745.2107464-2-slava@dubeyko.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sun, 26 Jul 2026 07:33:08 +0900
X-Gm-Features: AUfX_mzIPrNobk7Go-ZnbDpswNyGJpyERIxr2hvGlO8G1sA6x_EZWM8CLTWHH3g
Message-ID: <CAKFNMok2Op3dAAU8zGWLNPLeh8wj42MgQZbEdP1wSj8jnsO_+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] nilfs2: add iomap operations for direct I/O reads
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: hch@lst.de, linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Viacheslav,

On Sat, Jul 25, 2026 at 7:28=E2=80=AFAM Viacheslav Dubeyko wrote:
>
> Add iomap.c and iomap.h with a read-only nilfs_iomap_ops,
> wrapping the existing nilfs_bmap_lookup_contig() lookup
> to report a mapped range, a real hole, or an EOF-clamped
> range to iomap core.
>
> NILFS2 is a log-structured, copy-on-write filesystem:
> newly allocated blocks are only given a real disk address
> when the segment constructor writes them out as part of a log,
> which walks buffer_head lists directly and is not integrated
> with the generic address_space writeback path. Because of that,
> only the read-only side of the mapping is added - buffered writes,
> writeback, and mmap's ->page_mkwrite() will stay on the existing
> buffer_head based path (nilfs_get_block(), nilfs_write_begin/end(),
> nilfs_writepages(), nilfs_dirty_folio(), block_page_mkwrite()).
>
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> cc: linux-nilfs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/nilfs2/Makefile |  2 +-
>  fs/nilfs2/iomap.c  | 71 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nilfs2/iomap.h  | 13 +++++++++
>  3 files changed, 85 insertions(+), 1 deletion(-)
>  create mode 100644 fs/nilfs2/iomap.c
>  create mode 100644 fs/nilfs2/iomap.h
>
> diff --git a/fs/nilfs2/Makefile b/fs/nilfs2/Makefile
> index 43b60b8a4d07..516e6b85a03c 100644
> --- a/fs/nilfs2/Makefile
> +++ b/fs/nilfs2/Makefile
> @@ -3,4 +3,4 @@ obj-$(CONFIG_NILFS2_FS) +=3D nilfs2.o
>  nilfs2-y :=3D inode.o file.o dir.o super.o namei.o page.o mdt.o \
>         btnode.o bmap.o btree.o direct.o dat.o recovery.o \
>         the_nilfs.o segbuf.o segment.o cpfile.o sufile.o \
> -       ifile.o alloc.o gcinode.o ioctl.o sysfs.o
> +       ifile.o alloc.o gcinode.o ioctl.o sysfs.o iomap.o
> diff --git a/fs/nilfs2/iomap.c b/fs/nilfs2/iomap.c
> new file mode 100644
> index 000000000000..3ae3bf6ed368
> --- /dev/null
> +++ b/fs/nilfs2/iomap.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * NILFS iomap support implementation.
> + *
> + * Written by Viacheslav Dubeyko.
> + */
> +
> +#include <linux/iomap.h>
> +#include <linux/pagemap.h>
> +#include "nilfs.h"
> +#include "mdt.h"
> +#include "iomap.h"
> +
> +static int nilfs_iomap_begin(struct inode *inode, loff_t offset,
> +                            loff_t length, unsigned int flags,
> +                            struct iomap *iomap, struct iomap *srcmap)
> +{
> +       struct the_nilfs *nilfs =3D inode->i_sb->s_fs_info;
> +       struct nilfs_inode_info *ii =3D NILFS_I(inode);
> +       sector_t blkoff =3D offset >> inode->i_blkbits;
> +       unsigned int maxblocks;
> +       __u64 blknum =3D 0;
> +       int ret;
> +
> +       /* Completely beyond EOF. Treat as hole */
> +       if (i_size_read(inode) <=3D offset) {
> +               iomap->type =3D IOMAP_HOLE;
> +               iomap->addr =3D IOMAP_NULL_ADDR;
> +               iomap->offset =3D offset;
> +               iomap->length =3D length;
> +               return 0;
> +       }
> +
> +       /* Clamp length if the requested range goes beyond i_size */
> +       if (offset + length > i_size_read(inode)) {
> +               loff_t i_size =3D i_size_read(inode);
> +               unsigned int blocksize =3D i_blocksize(inode);
> +
> +               length =3D round_up(i_size, blocksize) - offset;
> +       }
> +
> +       maxblocks =3D min_t(loff_t, length >> inode->i_blkbits, INT_MAX);
> +       if (maxblocks =3D=3D 0)
> +               maxblocks =3D 1;
> +
> +       down_read(&NILFS_MDT(nilfs->ns_dat)->mi_sem);
> +       ret =3D nilfs_bmap_lookup_contig(ii->i_bmap, blkoff, &blknum, max=
blocks);
> +       up_read(&NILFS_MDT(nilfs->ns_dat)->mi_sem);
> +
> +       if (ret =3D=3D -ENOENT) {
> +               iomap->type =3D IOMAP_HOLE;
> +               iomap->addr =3D IOMAP_NULL_ADDR;
> +               iomap->offset =3D offset;
> +               iomap->length =3D min_t(loff_t, length, i_blocksize(inode=
));

After encountering a hole, I think we should use nilfs_bmap_seek_key()
-- as nilfs_mdt_find_block() does for metadata files -- to efficiently
determine its length.

However, if you are short on time, I am fine with the current approach as w=
ell.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi

> +               return 0;
> +       } else if (ret < 0)
> +               return ret;
> +
> +       iomap->bdev =3D inode->i_sb->s_bdev;
> +       iomap->offset =3D offset;
> +       iomap->length =3D min_t(loff_t, length, (loff_t)ret << inode->i_b=
lkbits);
> +       iomap->addr =3D (loff_t)blknum << inode->i_blkbits;
> +       iomap->type =3D IOMAP_MAPPED;
> +       iomap->flags =3D IOMAP_F_MERGED;
> +
> +       return 0;
> +}
> +
> +const struct iomap_ops nilfs_iomap_ops =3D {
> +       .iomap_begin =3D nilfs_iomap_begin,
> +};
> diff --git a/fs/nilfs2/iomap.h b/fs/nilfs2/iomap.h
> new file mode 100644
> index 000000000000..adef3e22346d
> --- /dev/null
> +++ b/fs/nilfs2/iomap.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * NILFS iomap support declarations.
> + *
> + * Written by Viacheslav Dubeyko.
> + */
> +
> +#ifndef _NILFS_IOMAP_H
> +#define _NILFS_IOMAP_H
> +
> +extern const struct iomap_ops nilfs_iomap_ops;
> +
> +#endif /* _NILFS_IOMAP_H */
> --
> 2.43.0
>
