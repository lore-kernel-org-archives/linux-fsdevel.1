Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14011E5207
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786573957; cv=pass; b=lgl0YAtIbw6YqOItVt47gA+6MT8SWkcEPKBdQCckVpjXsJMjOm/eCrmvMwAw7oMYbYggjwzROA7V48hYA0jyz2CjoEdq+HklMn2YBm6k9lwMsHs5bi2pQKnUlaY0Wph+Bz92Lks7xnxlEya/P/fnx7d3mmcVlROcWdX6U5ajUbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786573957; c=relaxed/simple;
	bh=oSTYv2sVf1bkkoxp97HICf2yboacaRxnJk8a3OFa+/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DdR1lXgvSowclOVebSGuyGX0UETou00S63Cuy5tX2jxRj5VAJwn0lOZo1TVBi74ZaN7Psc+dXfdw1dFhTsKfk5N3MK14cwdUgK91lsELLcqEL0Om7KURn72Vk4MHHhrGpGgVU2ikNPfjlxs4mNS6VZ353yrIWEay89zlSIIYhc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8/euR1W; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8/euR1W"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6681e7911b0so2242115d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 15:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786573954; cv=none;
        d=google.com; s=arc-20260327;
        b=XITW3EjmzAXOeOIN9Ybb1SVpd9T8QyfUX6vWqmM1/G+lxMf5d/3FvCDC3SIfD8sr7S
         HT3SMa9gu+NqafFrzqdmx4VMDRSUiAmxWHirvZUcn5dlUxwe4ckmW1TcuEXR4Re+OPY7
         yqKUYJrbRS9c/nw8UO4JQycVbC9oUQRKLALo4F2LlJKN724rBWRulwKiNFxfQDmgFs7o
         6fw2nUDxm8kM57f47eU0VztSKVHxl0O9EslMOwPYFMfPqYo2TtQ0VTn6lIK9ofAtn6FL
         G7kZ/bK+LjNWsdxvBjVOpAfENf0GgCilbP889MA0u1u2GdMkPNXf38Ucog0iHngUOXPY
         yihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WCRZCWfytLSRScu4X9gBOGJQTnOOUBgQA+JvgLiaPoQ=;
        fh=ZOWd2/T9oboFtZ2pCuaERvPpt5+E15gT76/oz0+X77E=;
        b=nkcgrdg8v1XW1BNet2/O/+J88I9VYOlleqC46WFpIueWa2x2u4qCQQ92LIG7G3i2jq
         mi1otl7WuWtd2wOXRIa1Ou99rXTnckp7FIWf45Dto0ZnphojjGxwdYBOl/AqD1zhuAJZ
         a+3zT9AGOsrGO7YHGgjtFjanm+G4lia93GfXqF99YiVhFq/WHfuarIkxAhOu29fxFwgS
         t/UnlNcJNzuAfRZHyzwAwMnNXVxm0Qd4IMzjYHpPvSXkiCucaElUuIkEaoJK2wT7R+8c
         WBUR69/iH8Ae55FeZFdfLntp066Ctj0vYNA+H0lfwEfSbfk2HbZlxJMH763JVnjvSn8f
         PYeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786573954; x=1787178754; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WCRZCWfytLSRScu4X9gBOGJQTnOOUBgQA+JvgLiaPoQ=;
        b=Q8/euR1WVdXFg84WAyfC63pUk8ziOyfxHAoOjNB6ceMN6P8MSqfva0pYmDzwdv6KAN
         q2xVLx77xY7jYZtNam1ufzHPncyUIvZdL9wT1dEV2CEloN7Rt/w42FtvOi26X12KJ1AQ
         lulnOKYdP/rq219DkWznk8CT2A9l2NWBrjHwcSg1kzrYrNiHkiN5G9slr7LdZAnA3xTO
         Z/EOP9SxTbfxmbyOihv6/g9rrRgwOtFu82t9w9iN7Tsdwdma+azKB1HWuRauKvZxstF4
         xTNAgraLi9nEoleQj4KMekpwWbyvfDFJ+3Q2uVYtOWDtp1585iHShE4AW8dFAiGgEl1k
         4tjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786573954; x=1787178754;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WCRZCWfytLSRScu4X9gBOGJQTnOOUBgQA+JvgLiaPoQ=;
        b=NSZ3YJ/nSDZm7LrprbHT7ORRv6PI4QF1ddLnt2NCUCzyPUNb8NZlw2/KElt5aDM8Mu
         3q7RD6tLLoU3a1tEJwnxpdRVYLNlK76umIWMZCq2k4BRSJHp7G/Rhg76E6OpzymS8u95
         fEuzHFAcuCTs07DLv1TmKjGKu6idLrscpFZmg1AdXMZUD4uIP7R8FOzTRY78ZU6ylnFE
         QSjJiJOhUnRwYVKR7JaQy4anyfqwxE17TUofjeDAQueTORn8eoxI3Y2H+/rifuFnaWGQ
         CjFU1eGZ2m07muKXXFjwaQzp/ifGq9ix5PSzrGgYWY+gbuaekKla5c1m5wugNFx2V04f
         +few==
X-Forwarded-Encrypted: i=1; AHgh+RoHZRLln20HWKlprNvmCTljlCCCfujl0fK3pk0SqMN3+AgWRVJyesA9KUfsgt8irmjLXeLWqh/1MQiVzomJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy5gmSlxgmT5N3ZBlxXAFYsFy9lxKKVLRnvl17v9GqlEq6yspI
	L6a7qqDuuOwu+HC2bHk4HPkbeU1Ododkp5ZnARnR4cfeJiThraxmI7nf+PTedx+3GW6998j3WPb
	sx4ZFgnqs4Sj2J65KssjJn8DtF43+Cgh3Is5i
X-Gm-Gg: AR+sD13dx7+5c7Bf+UnVrepLakAEu+mkgq6lmasn05ZX6YZND9aWGa5BfSImk58RJ7+
	ONInLLtyZGcRPb+ydesTL+bFGuKK0ViHCyG0T5xnN8VZcNT681qDSQ2nqxudQ+YV4AfaBx+dOFc
	eZWJZqtQj+QHruZmS5QcChSq/yIOKSzmslH6Sjbc6L9F60TpvQBgWTlQCBzJJixyaNix0f6KRVP
	Q+ZHuWALhURPhO6Dq7BAxAD2swL9fioRvfMlYdHPdG5EeFsN/gal2+g//N/4SzvEU/NVSJgUQMQ
	rXzlpnL6Ho2gKtgVA6HOuefSzxwR6oAC4t2WWsxZkyoMAy80m/IgQBIu
X-Received: by 2002:a53:e64b:0:b0:664:ed6f:4eb1 with SMTP id
 956f58d0204a3-66c514c0eb9mr559932d50.16.1786573953678; Wed, 12 Aug 2026
 15:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812221154.1119137-1-slava@dubeyko.com> <20260812221154.1119137-2-slava@dubeyko.com>
In-Reply-To: <20260812221154.1119137-2-slava@dubeyko.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 13 Aug 2026 07:32:11 +0900
X-Gm-Features: AUfX_mya_MUmAADUdOKOT6nsLUWD2pikTmL2Uj0KJM18LgmJAZGzgjM4bdTMrm4
Message-ID: <CAKFNMokgEToO6Hm=3pVYLA6BFBJfnysK6KmxK4k0=xU1ttGGCw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] nilfs2: add iomap operations for direct I/O
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: hch@lst.de, brauner@kernel.org, linux-nilfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, lilinmao@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 7:12=E2=80=AFAM Viacheslav Dubeyko wrote:
>
> The patch adds iomap.h with declaration of iomaps
> operations and iomap.c with implementation of
> nilfs_iomap_begin(). This method is based on calling
> the nilfs_bmap_lookup_contig() method. It resolves
> the file's block-mapping to find the sequence of
> physically-contiguous blocks starting at starting
> block. Offsets at or beyond i_size are reported
> as a hole. For offsets within i_size, the requested
> length is first clamped to the block-aligned end of the file.
> Both the hole and mapped cases then report iomap->offset
> aligned to the containing block (blkoff << i_blkbits)
> rather than the raw request offset.
>
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Co-developed-by: Linmao Li <lilinmao@kylinos.cn>
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> cc: linux-nilfs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi

>  fs/nilfs2/Makefile |  2 +-
>  fs/nilfs2/iomap.c  | 72 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/nilfs2/iomap.h  | 13 +++++++++
>  3 files changed, 86 insertions(+), 1 deletion(-)
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
> index 000000000000..e130ed63abd9
> --- /dev/null
> +++ b/fs/nilfs2/iomap.c
> @@ -0,0 +1,72 @@
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
> +       loff_t iomap_offset =3D (loff_t)blkoff << inode->i_blkbits;
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
> +               iomap->offset =3D iomap_offset;
> +               iomap->length =3D i_blocksize(inode);
> +               return 0;
> +       } else if (ret < 0)
> +               return ret;
> +
> +       iomap->bdev =3D inode->i_sb->s_bdev;
> +       iomap->offset =3D iomap_offset;
> +       iomap->length =3D (loff_t)ret << inode->i_blkbits;
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
