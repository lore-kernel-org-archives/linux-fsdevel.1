Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84DA360EF7
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859924; cv=pass; b=BD1okJ1GA3hTpX+NnhSeYhkzvy2ULfqerGn/zN0vRg+Pg26jji6VwhSJhQ12U4lGbVuqQtZ6rIeuhl44uYtRrdytitmtYs9eSbMfXMYUsOQy3PDtc528nOEqW6F7SnmnZciv8aS2rsCIldrd/YDnsXW4qd9hLeHFq2GpdWEdXek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859924; c=relaxed/simple;
	bh=FnIPtG5OabVipvjF3sZhiQCaqdXHbGk91kIUiXzybIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icXkxy2PRC3EN9EexiiOS+oqTqKEICGhncS9JuGLP2Mh5g7Xg44WcOW7U6QN94N2Z3EY2bQdc2ksj38AUHTTZoSCYPobp0FxNBy6ao0SrExglhEDXB+EWjyMWIFezFXERgoZoba+SWs9UIut/N0DnI2etwzLQzb8l1ePC2vOSiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RrK/FBB/; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrK/FBB/"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68bfcf11050so3315091a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jun 2026 02:05:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781859921; cv=none;
        d=google.com; s=arc-20240605;
        b=lAp6MhoYobG7MkB0Ov0a6B63tGwZProPJN1zzu7y8ZcMDi546TP4K2WFYYXqxiE40x
         lFheS5ab4z2qjWmllzXfa8YoqmwLNwvVdMhJWtIEd5jqE3vWyPurASxKjBPcxX0Kln4j
         VPqY5XvHHbYvUsiJxm7QP/gMxZwz4i2k7B3PDhQ1c1psN7/AP/HqS1MOBecik4/f7DCk
         9z/ckVKMuPyw1KfzZeUO5Oe1FE7VzHFd7T1RtljL5ro72ZIChLu/XGI8GsgOQuQN7XF9
         CHOJvanICUrgGBXin4b8AJu77BGOEREmIW2jbdmZYs+m3YW5NQpmskBZF5yeGITXi4GS
         zt/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hp+W/XPor9MTnkpUu8oMu3rvTE/+NmzEH6ACiUnm3pU=;
        fh=KPw0LP3TJKB48835lrV8HGIj27xTaomB15F3/9O4QGc=;
        b=EXc6rK5Kr3mhq1/9iqyjJAITearbtpBgxLLY60HLhlmXmJb9UI5A9ZqG3miDy/bdiA
         oAZDam9WyuGlXLoN0PU+xWbYLTeJ0NbcXBP5FTNbOmDj7mf9BRLKoosYeFIFusfQYebq
         fLt2d4qTconwZB36ueVhlv+tR9HQeBTJMZx+VLp133KuSC5OTzmlmXIsugU+kZy92d7G
         cVYB4ZW3GlqdPxrGfLQ9M9uyoXUOn3hh3aKo6JPyBDS8Y3zb4MJkPJczODOyAhAlasmN
         6Rhdc2wbnAlAMZQ8Uc2lm5DZb9KXNBMt0tj93d7JLKAy8hRstuWBPPpQ12MD1uZJ2DJ3
         a7sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781859921; x=1782464721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hp+W/XPor9MTnkpUu8oMu3rvTE/+NmzEH6ACiUnm3pU=;
        b=RrK/FBB/evsfY1amCmAXngIXMScDw3TMKagOEXojQjV6y/O0n2Kmf18W+P0F6zmGyv
         FGUY4XDz1ZbN4B2cQ5Zg2V9540ojES3D+z4iXI8S30JDPvLBP0E+iHEEhyXNjWZp3s30
         6j5GRSg3lBlELIEiIqFrk7nPQarAYyIrM2laD7MWYSVWukXgq8DKyImtPZWzqisSMT0E
         6Scv9WOVFvukev+nTk9sYUoFrGHVM0ZPylxRmgd/KHIlFvPk0REVTcD38qavJRIuG9rv
         9urHPQUWn+uSe9oOZZH+wJnktEsfTQd1bNFsb6sTKn8S5CcX//8Mn0S03lYwGxrJCJXG
         1LTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781859921; x=1782464721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hp+W/XPor9MTnkpUu8oMu3rvTE/+NmzEH6ACiUnm3pU=;
        b=JfS8cpcaRhDM4ZhBfEbPdXHXxdSrX9Uw48DJ1Z5m2TFgtEcAK2JNeZjUC+S8YSlR/8
         2XtGsdAmsL9BslKBbIVqPoA5haYkgA2MzL4qUBRif3h3TiZ1CYA3W9MV68VT9z1J/JcK
         xHXSiczHTuPzYDVIrs68zUR5YUNia1V3Wz3w5xAA5PjzHnMnC2nmpcotYl6VMCpLk2s+
         XM/v7tzNXgLwhVXuO0gDTDUuFkQx/3aQPgTRwp/R5WPIALtlrmw2+Tpim2Vizbl7KABU
         ltQLdVVSsz0it+/t+J7xQKZPy1tj0nkdlo5VlyJT3tCD3hOK9uzyFoCCUX5NN0UUb7BR
         5uDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/FLdKKwoNCEBt2Il0vdZWRJeFzVDeubVYRipeVnnmtdqFE17hwc7ZzkaWDHKzVrlDBRSnN17sUtF7kseVK@vger.kernel.org
X-Gm-Message-State: AOJu0YzcaVI8MuVXmUrRXfxsTTBodlewZBShhXby4B33Y/bMFHOpGV5j
	bp9bV49ugfvzKsocLJp2R/f9SJoMVSDAPA+O3NQUhGmfyPNwseKqIoDGCStLqnm5ZpyPBeBG1rL
	+rGOEjubgjPwcUjPKT2nlG0rvUvSRYNA7U7HqCOc=
X-Gm-Gg: AfdE7cnhqeR40o5Ots88I7Ndqzzfe9/i93CkpPF8T0EZ8pC9BbiZ//61VcZCx73i5xM
	geVo6u7ZNcvTrDIDbLq/i1rpq782H36OXbBYD3usD+h78h8QIeilFG55EobqomyZ5v8NvtpS1RF
	V/kT0x6eO2W6pvMVid5RSaRjydZGxuCypnAmwGgHW+jkgGMAY+GwZKFsW0HfOnknW0ADtme+ZxK
	OsCNjepe+jNDOUFhXLLbUfEMyLH6b238VagvXoxzuva+5mInY2XkU+8V2a3yoffbrJpmhVe2NMQ
	3yZBJx+IIqzZ6pR0ZRZkX4zPnHIKVLA=
X-Received: by 2002:a05:6402:2685:b0:695:a5a0:2738 with SMTP id
 4fb4d7f45d1cf-696e52043ddmr1390771a12.10.1781859920417; Fri, 19 Jun 2026
 02:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616231325.16788-1-russ.fellows@gmail.com> <20260616231325.16788-3-russ.fellows@gmail.com>
In-Reply-To: <20260616231325.16788-3-russ.fellows@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 19 Jun 2026 11:05:08 +0200
X-Gm-Features: AVVi8CfhFZ6f1r7vNALaOcFPTso1MsNgaUBwUZKGqTk8yrlAxmc_e_4dR3znZdU
Message-ID: <CAOQ4uxhk6-JZg7-Kq80D=czewTCoOwhtFUT7nS6yEi855ucQEA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fuse: allow parallel direct writes in passthrough write_iter
To: Russ Fellows <russ.fellows@gmail.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 1:13=E2=80=AFAM Russ Fellows <russ.fellows@gmail.co=
m> wrote:
>
> fuse_passthrough_write_iter() unconditionally called fuse_dio_lock()
> from file.c, which required those helpers to be exported.  That coupling
> is unnecessary and the exported symbols are undesirable.
>
> Replace the fuse_dio_lock()/fuse_dio_unlock() calls with a
> passthrough-specific pair, fuse_passthrough_lock() and
> fuse_passthrough_unlock(), that is self-contained in passthrough.c.
>
> The new fuse_passthrough_lock() allows shared inode locking only when
> all of the following are true:
>
>   - the open carries FOPEN_PARALLEL_DIRECT_WRITES
>   - the write is direct I/O (IOCB_DIRECT)
>   - the write is not append (IOCB_APPEND absent)
>   - the write does not extend past EOF
>
> The past-EOF check is made once before the lock is taken (fast path
> to choose lock type), and then re-checked after taking the shared lock.
> This re-check closes the TOCTOU window: a concurrent writer could extend
> EOF between the initial check and the lock acquisition; without the
> re-check a shared-lock writer could concurrently update i_size.
>
> Passthrough files are always in uncached iomode (established at open
> time via fuse_file_uncached_io_open()), so the fuse_inode_uncached_io_sta=
rt()
> guard from fuse_dio_lock() is not needed here.
>
> Restore fuse_dio_lock() and fuse_dio_unlock() to file-private (static).
> Remove their declarations from fuse_i.h.
>
> Signed-off-by: Russ Fellows <russ.fellows@gmail.com>
> ---
>  fs/fuse/file.c        |  6 ++--
>  fs/fuse/fuse_i.h      |  2 --
>  fs/fuse/passthrough.c | 74 +++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 75 insertions(+), 7 deletions(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 7cba331d0..f8651a195 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1366,8 +1366,8 @@ static bool fuse_dio_wr_exclusive_lock(struct kiocb=
 *iocb, struct iov_iter *from
>         return false;
>  }
>
> -void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
> -                  bool *exclusive)
> +static void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
> +                         bool *exclusive)
>  {
>         struct inode *inode =3D file_inode(iocb->ki_filp);
>         struct fuse_inode *fi =3D get_fuse_inode(inode);
> @@ -1393,7 +1393,7 @@ void fuse_dio_lock(struct kiocb *iocb, struct iov_i=
ter *from,
>         }
>  }
>
> -void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
> +static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
>  {
>         struct inode *inode =3D file_inode(iocb->ki_filp);
>         struct fuse_inode *fi =3D get_fuse_inode(inode);
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 8d05c7c52..cc428d04b 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1507,8 +1507,6 @@ int fuse_file_io_open(struct file *file, struct ino=
de *inode);
>  void fuse_file_io_release(struct fuse_file *ff, struct inode *inode);
>
>  /* file.c */
> -void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from, bool *excl=
usive);
> -void fuse_dio_unlock(struct kiocb *iocb, bool exclusive);
>  struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
>                                  unsigned int open_flags, bool isdir);
>  void fuse_file_release(struct inode *inode, struct fuse_file *ff,
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index ee822a983..11c16de4d 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -25,6 +25,76 @@ static void fuse_passthrough_end_write(struct kiocb *i=
ocb, ssize_t ret)
>         fuse_write_update_attr(inode, iocb->ki_pos, ret);
>  }
>
> +static bool fuse_passthrough_io_past_eof(struct kiocb *iocb,
> +                                        struct iov_iter *iter)
> +{
> +       struct inode *inode =3D file_inode(iocb->ki_filp);
> +
> +       return iocb->ki_pos + iov_iter_count(iter) > i_size_read(inode);
> +}
> +
> +/*
> + * Decide whether an exclusive inode lock is required for a passthrough =
write
> + * before the lock is taken.  Returns true (exclusive needed) unless all=
 of:
> + *   - server advertised FOPEN_PARALLEL_DIRECT_WRITES
> + *   - write is direct I/O (not buffered)
> + *   - write is not append
> + *   - write does not appear to extend past EOF (re-checked after lock b=
elow)
> + */
> +static bool fuse_passthrough_write_needs_exclusive(struct kiocb *iocb,
> +                                                  struct iov_iter *iter)
> +{
> +       struct fuse_file *ff =3D iocb->ki_filp->private_data;
> +
> +       if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
> +               return true;
> +
> +       if (!(iocb->ki_flags & IOCB_DIRECT))
> +               return true;
> +       if (iocb->ki_flags & IOCB_APPEND)
> +               return true;
> +       if (fuse_passthrough_io_past_eof(iocb, iter))
> +               return true;
> +
> +       return false;
> +}
> +
> +static void fuse_passthrough_lock(struct kiocb *iocb, struct iov_iter *i=
ter,
> +                                 bool *exclusive)
> +{
> +       struct inode *inode =3D file_inode(iocb->ki_filp);
> +
> +       *exclusive =3D fuse_passthrough_write_needs_exclusive(iocb, iter)=
;
> +       if (*exclusive) {
> +               inode_lock(inode);
> +       } else {
> +               inode_lock_shared(inode);
> +               /*
> +                * The past-EOF check in fuse_passthrough_write_needs_exc=
lusive()
> +                * was made without holding the inode lock and may have r=
aced
> +                * with a concurrent EOF-extending write.  Re-check under=
 the
> +                * shared lock and upgrade to exclusive if the write now =
reaches
> +                * past EOF, to ensure i_size is never updated without ex=
clusive
> +                * serialisation.
> +                */
> +               if (fuse_passthrough_io_past_eof(iocb, iter)) {
> +                       inode_unlock_shared(inode);
> +                       inode_lock(inode);
> +                       *exclusive =3D true;
> +               }
> +       }
> +}
> +
> +static void fuse_passthrough_unlock(struct kiocb *iocb, bool exclusive)
> +{
> +       struct inode *inode =3D file_inode(iocb->ki_filp);
> +
> +       if (exclusive)
> +               inode_unlock(inode);
> +       else
> +               inode_unlock_shared(inode);
> +}
> +

I'll take the blame for phrasing my review comment
"Either you duplicate fuse_dio_lock() -> fuse_passthrough_lock()
or you find a way to have the two share common helper (prefered)"

I should have phrased it stronger.
Unless there is a very good reason not to share a common helper
we need to use a common helper and not duplicate 99% identical code.

See my untested patch trying to do that below.

Thanks,
Amir.

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f94f3dc082c6b..6909b4bbba685 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1397,19 +1397,24 @@ static bool fuse_io_past_eof(struct kiocb
*iocb, struct iov_iter *iter)
 }

 /*
- * @return true if an exclusive lock for direct IO writes is needed
+ * @return true if an exclusive lock for direct IO or passthrough
writes is needed
  */
-static bool fuse_dio_wr_exclusive_lock(struct kiocb *iocb, struct
iov_iter *from)
+static bool fuse_io_wr_exclusive_lock(struct kiocb *iocb, struct
iov_iter *from)
 {
        struct file *file =3D iocb->ki_filp;
        struct fuse_file *ff =3D file->private_data;
        struct inode *inode =3D file_inode(iocb->ki_filp);
        struct fuse_inode *fi =3D get_fuse_inode(inode);
+       bool fopen_direct_io =3D ff->open_flags & FOPEN_DIRECT_IO;

        /* Server side has to advise that it supports parallel dio writes. =
*/
        if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
                return true;

+       /* Passthrough mode supports parallel IOCB_DIRECT writes */
+       if (!fopen_direct_io && !(iocb->ki_flags & IOCB_DIRECT))
+               return true;
+
        /*
         * Append will need to know the eventual EOF - always needs an
         * exclusive lock.
@@ -1428,13 +1433,33 @@ static bool fuse_dio_wr_exclusive_lock(struct
kiocb *iocb, struct iov_iter *from
        return false;
 }

 static void fuse_dio_lock(struct kiocb *iocb, struct iov_iter *from,
-                         bool *exclusive)
+static int fuse_parallel_dio_start(struct fuse_file *ff, struct fuse_inode=
 *fi)
+{
+       /* Permanent uncached mode from passthrough open */
+       if (ff->iomode =3D=3D IOM_UNCACHED)
+               return 0;
+
+       return fuse_inode_uncached_io_start(fi, NULL);
+}
+
+static void fuse_parallel_dio_end(struct fuse_file *ff, struct fuse_inode =
*fi)
+{
+       /* Permanent uncached mode from passthrough open */
+       if (ff->iomode =3D=3D IOM_UNCACHED)
+               return;
+
+       /* Allow opens in caching mode after last parallel dio end */
+       fuse_inode_uncached_io_end(fi);
+}
+
+/* Take shared/exclusive lock for direct IO or passthrough write */
+void fuse_io_wr_lock(struct kiocb *iocb, struct iov_iter *from, bool
*exclusive)
 {
+       struct fuse_file *ff =3D iocb->ki_filp->private_data;
        struct inode *inode =3D file_inode(iocb->ki_filp);
        struct fuse_inode *fi =3D get_fuse_inode(inode);

-       *exclusive =3D fuse_dio_wr_exclusive_lock(iocb, from);
+       *exclusive =3D fuse_io_wr_exclusive_lock(iocb, from);
        if (*exclusive) {
                inode_lock(inode);
        } else {
@@ -1447,7 +1472,7 @@ static void fuse_dio_lock(struct kiocb *iocb,
struct iov_iter *from,
                 * have raced, so check it again.
                 */
                if (fuse_io_past_eof(iocb, from) ||
-                   fuse_inode_uncached_io_start(fi, NULL) !=3D 0) {
+                   fuse_parallel_dio_start(ff, fi) !=3D 0) {
                        inode_unlock_shared(inode);
                        inode_lock(inode);
                        *exclusive =3D true;
@@ -1455,16 +1480,17 @@ static void fuse_dio_lock(struct kiocb *iocb,
struct iov_iter *from,
        }
 }

-static void fuse_dio_unlock(struct kiocb *iocb, bool exclusive)
+/* Release shared/exclusive lock taken for direct IO or passthrough write =
*/
+void fuse_io_wr_unlock(struct kiocb *iocb, bool exclusive)
 {
+       struct fuse_file *ff =3D iocb->ki_filp->private_data;
        struct inode *inode =3D file_inode(iocb->ki_filp);
        struct fuse_inode *fi =3D get_fuse_inode(inode);

        if (exclusive) {
                inode_unlock(inode);
        } else {
-               /* Allow opens in caching mode after last parallel dio end =
*/
-               fuse_inode_uncached_io_end(fi);
+               fuse_parallel_dio_end(ff, fi);
                inode_unlock_shared(inode);
        }
 }
@@ -1793,7 +1819,7 @@ static ssize_t fuse_direct_write_iter(struct
kiocb *iocb, struct iov_iter *from)
        ssize_t res;
        bool exclusive;

-       fuse_dio_lock(iocb, from, &exclusive);
+       fuse_io_wr_lock(iocb, from, &exclusive);
        res =3D generic_write_checks(iocb, from);
        if (res > 0) {
                task_io_account_write(res);
@@ -1807,7 +1833,7 @@ static ssize_t fuse_direct_write_iter(struct
kiocb *iocb, struct iov_iter *from)
                        fuse_write_update_attr(inode, iocb->ki_pos, res);
                }
        }
-       fuse_dio_unlock(iocb, exclusive);
+       fuse_io_wr_unlock(iocb, exclusive);

        return res;
 }
