Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C3342CA9
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776462778; cv=pass; b=HWxqX4HOoBcAxFyUPN5C3IOU3xzuzVZxGWFF4N0UQ1/wPV9D8DryytiyQJkdatwLEIfMps8pdL63Euyu1VppN6rCdoUY4i16crr/MZYfGVcPi3NkLodbXumZD3YkCfJsy1hLoAmkf4xMEHrEBGAFuZVeA+Vz/bZOPPac0oRGdeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776462778; c=relaxed/simple;
	bh=gDhAomle2l+OSFQeZ748+yzZnfkAx6M3az/HVqXqp4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/ij6K0Uvm88gVSrml0G3emyAuXB6WNme4mRnm8W0/YTLs5SjwxUVwvgYAZGWmC04Hvd3mxBiafKHO9NqThec46fQdwKw/nZ6V90MJDFPTjgB3+1Xe6WvEPxi57vFkMOsSno3qPp0nWShlLfXA3KXs0VzdRsXYngPEfU41V1Dy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/ahTR1m; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/ahTR1m"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cfd832155so806138f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 14:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776462776; cv=none;
        d=google.com; s=arc-20240605;
        b=hfMdcXwMrru9nsc1L/Hgg+MyuD3EJvxm2L3ieByJld4fmtCAdd7qMrxM/bVhoYmglU
         9n2c1gOm44ZqIHQ3OEipAaW4xKYcvV15BpdllOlxuRNsCU2jJjwKVczSD6dVaLCcibKf
         E1YOt/ddw7rWHn2hPWHim6uxzwj9Zg2RflKX3KijO/wDYakivUF97WlLU0qgeX1/cupa
         n5UwdsqkSnYugOjWD6drXjyhAULaP2mrKZzOAqGsSUP1cK5srR2BIZSyPQ1JkrOofyOT
         q4jEHQTEhmGzWcJulyyVc4DyGR5z3+3rvP+x4COPOLY3130vw5pSTpJDP7JfrMdlIYit
         yDRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sLU/BKCA6tDfkOm9P3zBUOXG/ey2CPFE0fCKgZ58HUc=;
        fh=26Wpokz+9UWrKpuMk+6M6c1T+5WIpz578ipJhRKoYEw=;
        b=PdgvU/JyDykYjae2wQyx6MTcHduDD9sxp62DVP6P+eje9MrDXFL7ggPcpGykF9YN8L
         +JAUUYJB0glI9KaHNXSXDa+Z+kVTJTZ54DJrAo9s6Yeoq8KgSiTCenHyXFfiybrWHJ1N
         iLi9NO7jN9ovsE0ESOvDcaoYJnJ2K/vWQ8wFKnzpf3k41PrUeTJitFXZAe/AgrsnAleN
         WgpfukIcBVmPwl94ap5T11xdfw9inOovofQnlEyXQsKrNDR07b0WfkQFR+nyhCYAiiRE
         BDO8Nq+7lCx5/xlSasa0FqVru4Iqut/cv/6gLVmnpGrwRvITgxymhj6cU8qHdTRSYXUx
         iMkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776462776; x=1777067576; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLU/BKCA6tDfkOm9P3zBUOXG/ey2CPFE0fCKgZ58HUc=;
        b=D/ahTR1mYdgcSry/DDQX0I6h6RTO+hOLvS5fj9ba8kQB9UKT0MzViVD+tzs1/cJPOh
         08cZhMyrL/Ha7mYOOshnpkmhPMRwTywDRatQf861BZvHgmZRcFnaVtDq4mEP2SMMGLCO
         tVSpWYenLYntauBQa9l4n5VYUYZaSB9GZvkGsap4Qd/27ylgfPrC9SKWTL/NeRZT/OAd
         ZlswQSVsf4M0VRmhubpDD+3A5dxLx0b4cSNQkGVMVs45EaOrvro7O5cLEsTNNDz0tnbb
         t5m6IPsBiw9KYiBVjwtYPkD1wvBHauYgu+JwAzABNe5jUnX5IKV/1RPKGgKGrQDz7Bii
         kLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776462776; x=1777067576;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sLU/BKCA6tDfkOm9P3zBUOXG/ey2CPFE0fCKgZ58HUc=;
        b=JvWiq9xEf2qdD6iX7dU1It8kF6/IgbG9QdplNRtKHSmjPsdXf0dhhbZ45ZOesbcLYe
         wz7zIgv7TQmPzZdXU3zH4VIctOwV5xGZN27SASwew3W8EPP2/YMHosmDqiMUxwiNMhyj
         GNBlbWkxCpVYUpuAM/uOfF+UHSKJMQcil4dBqb8K+RGkhmidDgb+Sn45y6gkXr3YuKVh
         Xz3f7YwF2MiKjM2x37w7lLNvQiUlmGh875eqi/CaLBvyYYV5HGy3N8kAxA91ehqPba4F
         EKGMGsEmB0X6OBmiP2f5hFhj3Pcf5DeDeSZRfaSwi5pPOcUPH2Z7NPTk8V+Z494/7uw0
         A3UQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qlbnwC6wVTphyS7rbe+bQo+3WQzm9rayAq5GqDc3+1eU3vDIGe/NQcdXaRJA2kUZY94X3MtkKhZ94XjTp@vger.kernel.org
X-Gm-Message-State: AOJu0YxLW3gEjkleJ9FCjkW2FgnK/je4toLWXk8yvtftZvp510cIjEg0
	qQvFotdagZX9dm42TmE04U3M3jJJkKuv9NxGMf+J6NJMkRXKgW+X2+vPm2wfmWRtbA78wY+d37z
	oehxARkj9OMBPRPfQxVQhlCxsHpOAs9puVaaB3kw=
X-Gm-Gg: AeBDiesQEdzl9/uDkGL/WrPKWX5ayVQS5i2Sp+bvkycBY/izb9myNRuGAEh+bwG92jR
	AndV3xD1F/dYvCxn4reA6LCoRyw9vMhUzZBMEM4L/qydPLzdsqRtld0nndGec6ypnHye8dywEoQ
	mHwxG7QSmDdtVc8TUTB6HxRKI/mwH0aAtx2gMUd7pDmBXYaMVQe7VlnSYQxQUH82sERTY0UEwvG
	NR6WNZWdyCtOltjX+KDv+u3FSYyrcRsQT41Ymzers+1i+dFU+Dg/y0dRtUsLRUOadnllaDsaLvd
	FRNvlNKuVtjGZjCL
X-Received: by 2002:a5d:5f47:0:b0:43f:e262:f4b2 with SMTP id
 ffacd0b85a97d-43fe3db3773mr7161929f8f.3.1776462775377; Fri, 17 Apr 2026
 14:52:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416091658.462783-1-mszeredi@redhat.com> <20260416091658.462783-21-mszeredi@redhat.com>
In-Reply-To: <20260416091658.462783-21-mszeredi@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 17 Apr 2026 14:52:44 -0700
X-Gm-Features: AQROBzAaj2_K_sXDaygl_Ux8yPW6mhh9rfQ61UrzPVuRbd4fTGrotUVf0hs8LI8
Message-ID: <CAJnrk1Z7cgKGM6s5CaOg9t+qQ206otDop6YdzGmV1dFw9M3KSA@mail.gmail.com>
Subject: Re: [PATCH 20/32] fuse: split off fuse_args and related definitions
 into a separate header
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 2:19=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> This is going to be used by both layers (transport and filesystem)
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/args.h   | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h | 53 +--------------------------------------
>  2 files changed, 66 insertions(+), 52 deletions(-)
>  create mode 100644 fs/fuse/args.h
>
> diff --git a/fs/fuse/args.h b/fs/fuse/args.h
> new file mode 100644
> index 000000000000..ecfe51a192af
> --- /dev/null
> +++ b/fs/fuse/args.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _FS_FUSE_ARGS_H
> +#define _FS_FUSE_ARGS_H
> +
> +#include <linux/types.h>
> +
> +struct fuse_mount;
> +
> +/** One input argument of a request */
> +struct fuse_in_arg {
> +       unsigned size;
> +       const void *value;
> +};
> +
> +/** One output argument of a request */
> +struct fuse_arg {
> +       unsigned size;
> +       void *value;
> +};
> +
> +struct fuse_args {
> +       u64 nodeid;
> +       u32 opcode;
> +       u32 uid;
> +       u32 gid;
> +       u32 pid;
> +       u8 in_numargs;
> +       u8 out_numargs;
> +       u8 ext_idx;
> +       bool force:1;
> +       bool noreply:1;
> +       bool nocreds:1;
> +       bool in_pages:1;
> +       bool out_pages:1;
> +       bool user_pages:1;
> +       bool out_argvar:1;
> +       bool page_zeroing:1;
> +       bool page_replace:1;
> +       bool may_block:1;
> +       bool is_ext:1;
> +       bool is_pinned:1;
> +       bool invalidate_vmap:1;
> +       bool abort_on_kill:1;
> +       struct fuse_in_arg in_args[4];
> +       struct fuse_arg out_args[2];
> +       void (*end)(struct fuse_args *args, int error);

I think you accidentally dropped the first arg (struct fuse_mount *fm)
when moving this over?

Thanks,
Joanne

> +       /* Used for kvec iter backed by vmalloc address */
> +       void *vmap_base;
> +};
> +
> +/** FUSE folio descriptor */
> +struct fuse_folio_desc {
> +       unsigned int length;
> +       unsigned int offset;
> +};
> +
> +struct fuse_args_pages {
> +       struct fuse_args args;
> +       struct folio **folios;
> +       struct fuse_folio_desc *descs;
> +       unsigned int num_folios;
> +};
> +
> +#endif /* _FS_FUSE_ARGS_H */
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index b8655c3b48e2..22a6d58678ad 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -13,6 +13,7 @@
>  # define pr_fmt(fmt) "fuse: " fmt
>  #endif
>
> +#include "args.h"
>  #include <linux/fuse.h>
>  #include <linux/fs.h>
>  #include <linux/mount.h>
> @@ -288,58 +289,6 @@ struct fuse_file {
>         bool flock:1;
>  };
>
> -/** One input argument of a request */
> -struct fuse_in_arg {
> -       unsigned size;
> -       const void *value;
> -};
> -
> -/** One output argument of a request */
> -struct fuse_arg {
> -       unsigned size;
> -       void *value;
> -};
> -
> -/** FUSE folio descriptor */
> -struct fuse_folio_desc {
> -       unsigned int length;
> -       unsigned int offset;
> -};
> -
> -struct fuse_args {
> -       uint64_t nodeid;
> -       uint32_t opcode;
> -       uint8_t in_numargs;
> -       uint8_t out_numargs;
> -       uint8_t ext_idx;
> -       bool force:1;
> -       bool noreply:1;
> -       bool nocreds:1;
> -       bool in_pages:1;
> -       bool out_pages:1;
> -       bool user_pages:1;
> -       bool out_argvar:1;
> -       bool page_zeroing:1;
> -       bool page_replace:1;
> -       bool may_block:1;
> -       bool is_ext:1;
> -       bool is_pinned:1;
> -       bool invalidate_vmap:1;
> -       bool abort_on_kill:1;
> -       struct fuse_in_arg in_args[4];
> -       struct fuse_arg out_args[2];
> -       void (*end)(struct fuse_mount *fm, struct fuse_args *args, int er=
ror);
> -       /* Used for kvec iter backed by vmalloc address */
> -       void *vmap_base;
> -};
> -
> -struct fuse_args_pages {
> -       struct fuse_args args;
> -       struct folio **folios;
> -       struct fuse_folio_desc *descs;
> -       unsigned int num_folios;
> -};
> -
>  struct fuse_release_args {
>         struct fuse_args args;
>         struct fuse_release_in inarg;
> --
> 2.53.0
>
>
