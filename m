Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B483921E7
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778615907; cv=pass; b=aF7kNle5yvwf0qX63jDb5PK21Lq/HnRn9tgXiVFIVVNzWghwRaD1KGztBUks5BAO32kJhNyJTpcxpJvfIjtiXCn1p9HV1VsOjo4jCZKO8Pee294RARQ5ps7qjYi85ctRk4OEHezbakF+PKF6GWIUgO4qGyEZa2Cz/y1dIlFkaaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778615907; c=relaxed/simple;
	bh=eZsRUpE9uaSHV1uum4040r8ySWYWpKIbXVa7LjQd64U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BBC2ROCRc2LiuI/voIdK4G+wgbXHm0HgZrb0iUnIy51B7KNYcrt+sRqbyeTaEWSbmwWXldB2jBXS2xvHzmqqCFTftjBBYZqxIbralSpHGO3QwApt8G3h1K8DW7WNJ0m048Bx5EsEFN3j40W5hqWjJlRRvPBKnvS09XKo08K1OCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rd3R2xvo; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rd3R2xvo"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48d146705b4so72444995e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 12:58:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778615903; cv=none;
        d=google.com; s=arc-20240605;
        b=kksZVUFlhAs+rUg4PbVTUxiv7FImzR7qmIA1pmOr9ehVzpm64Cy7JQ7grfkrXq8AXo
         AJRKd3XJa2/MO2i+Ii2FcTUSNFJfkcwVAoPzY3+rZw9roLsBNupEAI8+5XyK4jbnW8d5
         WrguSOkxCXfgGT2XxCCkGPCLRxtCjkZUkA5+76jt7fgxdySZvc6VJtZvyXR72r0Djjtp
         HbjlO2e/4LlRFnsm5KMXHOGZyCisFhTcE/dA0GKMGtjYTr3LfauhKj6G8K41IIEVgOk+
         2/bcLzrDigR+bvtRNafnEJM7oHU4SzTcR9y+7qWb14dmbkTp6/+Y0T6gLFl7X4DuE+SM
         0Zkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4dM7/PWHGvTbERh3DskzLzhIjjwPZXY9C2s5LLQFNG4=;
        fh=72Ca35JEoJAe5rVbUZdNRZdsQDgxX4QMhCrTJl79nQI=;
        b=fHmHHaWmL6t5aywe4nsH61KwdD6TyrIuAjzYS7gTHo7aUCmPOrYMx90c6fCvIs9ohC
         dUXPofpg5bZjBMCYIJoIfQUFuhpSyUwAA6KP+f5IeoZspZJCxVqosjdnLDl36AOxykmR
         kQH4I6W0zov1bazispKgZyklpy5Bwn2aztddzGpkPyFY+hvngKbSN5zAmtzn8ZoN5cp8
         mTLV9R/581OKbJroH4Ar088ufv8pkLdyZa1cgnISM3Dn/GkqLG3whtFQy5jsbikNP4lo
         JXzLcPEuvhAT9/VabowxNsI5DAOC39iBapYyk0wbXMC1Ami0P1ASgKYZkSb+3/hOfdvB
         Anmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778615903; x=1779220703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4dM7/PWHGvTbERh3DskzLzhIjjwPZXY9C2s5LLQFNG4=;
        b=rd3R2xvonYNABNODW2wL8+mDXqnosfdBtktK7RcpHr21FOYzUOofIVoZGJqE6tBZqm
         H/hxktAEOFfceFmT2Ht5n8Stc6sF+eI0A1IXJtGZZgNBkeSERN9AX9fMaeRBq+ceiDmM
         CBMxHzYb29Ri6YXI0CzU4fTzjc8PRH/XyT0D3YRP+FcbkQiD+I1IhdpjgshifMzNxVeC
         xkwTT9HmXUNtMgd4HevHQxxKjI9YdKbDfsC2O5C2AHoMS+Gd77ErLqVBfi13FDE5gper
         JztV4lWRgRJFicY2/g79jQAZ564v9WUNm53bMQNwTBkbqrE2ey5YKJ3KSK/Id5NpPw9X
         76Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778615903; x=1779220703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4dM7/PWHGvTbERh3DskzLzhIjjwPZXY9C2s5LLQFNG4=;
        b=kUwjFqSvuq8IEzRZGY18pEmjv1wL67asYKQMynAEB/rnwQLbf+Esj0Wjb9NYoWbi4q
         Pq7wfonZSLrqMYcnG2sHRT15+mwQSr7lpEmZVox7D0TDdguraW4z5DNBgNLRab5E9H4v
         JbG7SGX8uSzfxt53LMYBWC7+BtoLn15mQ3JZGzmVHWmhspQyGA0AAa2k29EooPL7umAb
         HLp5mfUkFZwRMhuswfABmHLUXGx1afsQcMeqiadmlYMslLH233SRHhTQ7snHiqIxixkp
         YL40ZmUCRWbo0njgBTdKVdM09bGFnrCUUlgY2thG5htkR3EE7/HkZA8wkq7J/0+D7S1J
         26Fw==
X-Forwarded-Encrypted: i=1; AFNElJ++XSbuaHPAB+NrLrr2K0T0okqPLj7C5kRLn41qV6uG+Thj+EaepYTLDZbyxmY4AtayiDd8cXLHHVbB/nNo@vger.kernel.org
X-Gm-Message-State: AOJu0Yym34nbdEFjUfB4DUjcAB/Iq41P0NPtaB++3v3xGAK3tf2Uauwo
	3oSGTSRJVNSAo8fV8sb4BqwqZZ7k8o1QnrRVraS6mbmVke/tGX1wqnNFT6+YHDjua+TnWrzwKyG
	9yC2Tazo8rI5WSvzsAxmlQOzrKc9ZgMM=
X-Gm-Gg: Acq92OE7HpBtwYFvMQs+vFnL9G/gRzq08Ut30xPv13ZuKC5rIVpGFmv0Via2ME3wKUh
	ntnxyxhXZk3AxeVEmahRVyQned4Vg0gX2u+uPbWlx132rPTckF/CKW3iDG1YkCp0A/ANs6pQ9bl
	cpDAoq/XYEQ16bxqsKwuWjxauAcdHMb4agNEuZZRjZbO4m7P6q6xOV+McQFGoQokVtVnHd80zGi
	2vl2p4/5wVfwyot+rQdEqDZTusOmMCl6qmldnmtNoc2x3AHl5+Q1L+hrzjLf8ESJUv+zEfmNT3v
	mDucyA==
X-Received: by 2002:a05:600c:6303:b0:48a:592c:e632 with SMTP id
 5b1f17b1804b1-48fc9a2b921mr4023765e9.16.1778615903001; Tue, 12 May 2026
 12:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331223927.763741-1-quark@lihdd.net>
In-Reply-To: <20260331223927.763741-1-quark@lihdd.net>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 12 May 2026 12:58:10 -0700
X-Gm-Features: AVHnY4Lf4J2P_HObmqP54f52npnAl1v41NlBsMeQRJU1pBGsrfA8cJB17r6iYX8
Message-ID: <CAJnrk1YOzwNRS+qA74rLMFmx=JgE3VVueu9o7-pghsa4bPzYBw@mail.gmail.com>
Subject: Re: [PATCH] fuse: invalidate readdir cache on epoch bump
To: Jun Wu <quark@lihdd.net>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, Jun Wu <quark@meta.com>, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 3:40=E2=80=AFPM Jun Wu <quark@lihdd.net> wrote:
>
> From: Jun Wu <quark@meta.com>
>
> FUSE_NOTIFY_INC_EPOCH invalidates dentries, but does not invalidate cache=
d
> readdir results. A process with cwd inside a FUSE mount can therefore
> observe stale readdir(".") output after an epoch bump.
>
> Fix this by recording epoch in the readdir cache and checking it on reuse=
.
>
> Add FUSE_EPOCH_READDIR init flag so userspace can detect this change.

imo this is more of a fix than a new feature, so I don't think the
changes for adding the FUSE_EPOCH_READDIR init flag is necessary. I
think the Fixes: 2396356a945b ("fuse: add more control over cache
invalidation behaviour") tag fits here.

Other than that, this change makes sense to me.

Thanks,
Joanne

>
> Minimal reproducer:
>
> - mount a tiny FUSE fs with an empty root directory
> - on opendir, enable fi->cache_readdir and fi->keep_cache
> - chdir into the mount and call readdir(".") to populate readdir cache
> - make the FUSE server report one file in the root directory
> - send only FUSE_NOTIFY_INC_EPOCH
> - call readdir(".") again; before this change it stays stale, after this
>   change it sees the new file
>
> Signed-off-by: Jun Wu <quark@meta.com>
> ---
>  fs/fuse/dev.c             | 6 +++---
>  fs/fuse/fuse_i.h          | 3 +++
>  fs/fuse/inode.c           | 2 +-
>  fs/fuse/readdir.c         | 5 ++++-
>  include/uapi/linux/fuse.h | 3 +++
>  5 files changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 0b0241f47170..595f90f44772 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2039,9 +2039,9 @@ static int fuse_notify_resend(struct fuse_conn *fc)
>  }
>
>  /*
> - * Increments the fuse connection epoch.  This will result of dentries f=
rom
> - * previous epochs to be invalidated.  Additionally, if inval_wq is set,=
 a work
> - * queue is scheduled to trigger the invalidation.
> + * Increments the fuse connection epoch.  This will cause dentries and
> + * readdir caches from previous epochs to be invalidated.  Additionally,
> + * if inval_wq is set, a work queue is scheduled to trigger the invalida=
tion.
>   */
>  static int fuse_notify_inc_epoch(struct fuse_conn *fc)
>  {
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 7f16049387d1..9b479f597938 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -191,6 +191,9 @@ struct fuse_inode {
>                         /* iversion of directory when cache was started *=
/
>                         u64 iversion;
>
> +                       /* epoch of fc when cache was started */
> +                       int epoch;
> +
>                         /* protects above fields */
>                         spinlock_t lock;
>                 } rdc;
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index c795abe47a4f..5685e696ee2f 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1506,7 +1506,7 @@ static struct fuse_init_args *fuse_new_init(struct =
fuse_mount *fm)
>                 FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
>                 FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
>                 FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDM=
AP |
> -               FUSE_REQUEST_TIMEOUT;
> +               FUSE_REQUEST_TIMEOUT | FUSE_EPOCH_READDIR;
>  #ifdef CONFIG_FUSE_DAX
>         if (fm->fc->dax)
>                 flags |=3D FUSE_MAP_ALIGNMENT;
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index c2aae2eef086..240b0e993780 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -438,6 +438,7 @@ static void fuse_rdc_reset(struct inode *inode)
>         fi->rdc.version++;
>         fi->rdc.size =3D 0;
>         fi->rdc.pos =3D 0;
> +       fi->rdc.epoch =3D 0;
>  }
>
>  #define UNCACHED 1
> @@ -479,6 +480,7 @@ static int fuse_readdir_cached(struct file *file, str=
uct dir_context *ctx)
>                 if (!ctx->pos && !fi->rdc.size) {
>                         fi->rdc.mtime =3D inode_get_mtime(inode);
>                         fi->rdc.iversion =3D inode_query_iversion(inode);
> +                       fi->rdc.epoch =3D atomic_read(&fc->epoch);
>                 }
>                 spin_unlock(&fi->rdc.lock);
>                 return UNCACHED;
> @@ -492,7 +494,8 @@ static int fuse_readdir_cached(struct file *file, str=
uct dir_context *ctx)
>                 struct timespec64 mtime =3D inode_get_mtime(inode);
>
>                 if (inode_peek_iversion(inode) !=3D fi->rdc.iversion ||
> -                   !timespec64_equal(&fi->rdc.mtime, &mtime)) {
> +                   !timespec64_equal(&fi->rdc.mtime, &mtime) ||
> +                   fi->rdc.epoch !=3D atomic_read(&fc->epoch)) {
>                         fuse_rdc_reset(inode);
>                         goto retry_locked;
>                 }
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index c13e1f9a2f12..b0bd96ac1e84 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -240,6 +240,7 @@
>   *  - add FUSE_COPY_FILE_RANGE_64
>   *  - add struct fuse_copy_file_range_out
>   *  - add FUSE_NOTIFY_PRUNE
> + *  - add FUSE_EPOCH_READDIR
>   */
>
>  #ifndef _LINUX_FUSE_H
> @@ -448,6 +449,7 @@ struct fuse_file_lock {
>   * FUSE_OVER_IO_URING: Indicate that client supports io-uring
>   * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
>   *                      init_out.request_timeout contains the timeout (i=
n secs)
> + * FUSE_EPOCH_READDIR: epoch bump also invalidates readdir caches
>   */
>  #define FUSE_ASYNC_READ                (1 << 0)
>  #define FUSE_POSIX_LOCKS       (1 << 1)
> @@ -495,6 +497,7 @@ struct fuse_file_lock {
>  #define FUSE_ALLOW_IDMAP       (1ULL << 40)
>  #define FUSE_OVER_IO_URING     (1ULL << 41)
>  #define FUSE_REQUEST_TIMEOUT   (1ULL << 42)
> +#define FUSE_EPOCH_READDIR     (1ULL << 43)
>
>  /**
>   * CUSE INIT request/reply flags
> --
> 2.53.0
>
>
