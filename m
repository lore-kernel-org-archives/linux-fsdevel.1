Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602CD3F58CA
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591975; cv=pass; b=Ewdhu1r3iuGasvrFtO2/Cy2lYVoNCo8fcY4fzdHoy22rWvd6eXf93RWqAKqUOzW8WxHS4SifXG9PbB+NJjFfTn9skOARoFMY40B4uRR5Vg/lhFFlk0cT4fNBiXwyWOqf6cFG/M4QDPHKuQe4qlSTBd/CiHvq1LDWfaPKPS/+XI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591975; c=relaxed/simple;
	bh=9szRXNz+1rbQ1qPmMhoZClR1R6MTvny3zRZAdVoNZ9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MlirxVxLqe8MkPr0p/Pr1w5AnJolD6WnWac4Af6HUT4izCBqhnX+zcbrlz7cJw2iReoQUsseAsUl74/xp9RePYvWp0K3hKcrR1QEXEtHnKSK0gtEPzShJyG945REBdIRSyYDrA6nFgvbuNPTQ+QjmUvX3tp52d5Cb6WlcN1WqaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjWU3A/h; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjWU3A/h"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a157f90752so6368776a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 10:19:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787591971; cv=none;
        d=google.com; s=arc-20260327;
        b=bjfrPTEWReZfgyq+wQCmP3K7xoZwcc85jeauC6BpA690OO6L6KhiYkidI7blNP8Gaz
         x8Iav8wyYXEyB0lwrAUYaQTJKpsmcD6dyDGTKcwvEtI4gjro/tGvb7Y0RXqjd+wHXqsp
         aSp65Ifi2QHJMGOfj5/h2ADXgUqLr+KDmomdDorLJsxczzQXehtJJTuPsq6oNsIgqTzV
         QCcQTAFKKoDWGTiZnwdlFnkbzrCkXCwQFtMx+h5QRshhlxesaOr4dchsPuNs3y26Ee50
         PKNLmXc1sIxa8UWERZB+87tCVkz44ee27mqU8OjbhiBAJFufmJ6uAaJPjReFr6u2c3bl
         w7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hAvzxihNiFtM0K3Wr9CDqWroU4/ZmBDLBIfShjTV4Pc=;
        fh=oNnrPBpXzO1VROYiYSvyVLECjPn0ZFIf5/hUxQvsmrY=;
        b=sOS23WW65kPltOPkg2dsp+0VQ2YQDk0Czz5dSfW4Z4MdJNMcf3o9K1LosrQBgZ1GAZ
         eaKDgh8Qo3SoBdTSvLq+xgoXt6I84QAbWUKpeLi5QhY51xzHyWN2Y+VHp2AkLTE6lc7a
         sEIekOClwXaSKwlLfyxUac4fn2VDAt/pT1BeWshQb1wo/3jPaYBev9QZhb8Bq+Tqm2bP
         M7lw0tDm9SKMVGVQG3X61+tuHIpiKQ04MFuk3YmPUKsKZjOTFKgWdvtajJDFm1mNgUyU
         tWyC0YTZvRlj0CL/0lhJ5N0O+sGpJm8dj0ntXld/xPqB3pwLiElFQ6jZQX0aLjm/Uc3t
         E27A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787591971; x=1788196771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hAvzxihNiFtM0K3Wr9CDqWroU4/ZmBDLBIfShjTV4Pc=;
        b=XjWU3A/h1HLrhHE0fJyK2MiRDzpMsGWp3NL710HfYjL73Kmdpax/vm9J6Cvd6JAsPE
         sNYrbGvcGbR5nJ7eZOzdnwZ6AF7XqjSB/BJ1S/wBSJSxvzUVMVj2j6u0NKhZrX6mY9SD
         5ITO3kHgfu2U3B/6LAz3wkaJRscUHlr4q328dIaCyIDWx7BG6jN61znD8eFwrUMHmG9I
         Rezk53FSU2/gMkv8hD1OTGJru+D33imEOeT9wenjEriIc4v3La7SPvYvQE+b6M2T5JBz
         XRN3NeNBd0j3gufKoivC9AI99XtdYxg1jmP/9cfWPCXmpurp9gBDC5CJFrPoUsJl5H5r
         0Iyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787591971; x=1788196771;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hAvzxihNiFtM0K3Wr9CDqWroU4/ZmBDLBIfShjTV4Pc=;
        b=k02DzQ5w5xZqJmXo8iYknXbXOD3Xv0qGrcS/Vj65ANAFRreUDx8Vh9OQuOxv4xsbCW
         U53P73/W/eb1YUezU9gNbgxbDX2+43ioSDW7sfm50ACF5Rrct1vKH3Wv8eN2n7aoHueu
         43/kafKMCWn5FZHpZKFT+pH32XN5pb85E9vEETTjKHQwx8IKW975uwB5RbBAIbsdF/dH
         N1D5VBhudKp0NMVkT7eY3Npgv16X7Fn9vqdFdXTQB9NMNC6OW3DlIZ8DN63P/rOIp40S
         BfqYn64ITshAHG9zUCIFVLUnZfUMcXuhxOb4+pHjy3jcoNSsUB5uUL1kgdhcpIzGgfPk
         g/dw==
X-Forwarded-Encrypted: i=1; AHgh+Rp9JVn717wgTHTPwpKEik8C/7QTKOKUnG4PX4MMRIJe4aS6NsDZX7P6qdvuC7Mrwx233uiwe/gkDYV5XL2O@vger.kernel.org
X-Gm-Message-State: AFuF++l9PRRdQJVZ3qKcaEm62DE3tAgEah9YYEEftvR41w1Dxq9esDZk
	tFuhkwUoMnjwGkP1nWLwd1xWzMxioQ5ze+/fkTVO9aouEiaYE/vX/GktDXGLmWeActQPh1SAG0z
	zDiMjQnclpOLIrr0d9JjZAxqKv65OrtY=
X-Gm-Gg: AR+sD10TXCXTna9ecIQbw6p9HjMWrCeGBFuTQJRwjdTklmMiAyEdUcxWpIfAIkMk2+i
	Dk6EMEdHCUUbXB/0vktvDCfnCbEU8QQg/qN5a7Q4RIE4kd8puLZ6Q+RtsG8zlJNdRwbbQV//UO9
	CbANccPslmJjVWk3GhBOiWMyibRWY1UoKumhWgmTZVeGhgQRTgiKqxty1gAV/O4QkE23gJoxiep
	9gLfvAVrnJsu4QpUqA1xjcnxZql9EMoyhiwqV2TJEP3ZurNzJwEcGZJzDxs6RGg1CUbw/x/vc8x
	LFtJ84vfq38weCKocK//sxAL+1JL3Dtfz3MaBluSW4TTxealwPUCysAB
X-Received: by 2002:a05:6402:254f:b0:6a0:9c84:ce0e with SMTP id
 4fb4d7f45d1cf-6a5c414f08bmr300600a12.14.1787591971270; Mon, 24 Aug 2026
 10:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824161021.245575-1-cel@kernel.org>
In-Reply-To: <20260824161021.245575-1-cel@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 24 Aug 2026 19:19:19 +0200
X-Gm-Features: AcwNN1W_Jkk999mAIT6mTotVsZn7LO3MMN0Ci3O6rzFYDCFOV23BjVOjeaFyHYI
Message-ID: <CAOQ4uxgCrwDCX88uC=cDr16hQVHOkaPJBppLk740vmGpA4Ya8w@mail.gmail.com>
Subject: Re: [PATCH v1] splice: emit a single fsnotify access event per NFSD READ
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Ameer Hamza <ameer.hamza@truenas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 6:10=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
> nfsd_finish_read() calls fsnotify_access() on both NFSD read paths,
> because splice_direct_to_actor() does not emit the event itself. The
> iterator path reaches nfsd_finish_read() from vfs_iocb_iter_read(),
> which has already emitted one. A READ served without splice therefore
> emits two access events.
>
> NFSD does not use splice for the GSS integrity and privacy services, so
> a READ on a sec=3Dkrb5i or sec=3Dkrb5p mount takes the iterator. An inoti=
fy
> watch on that file sees the READ twice.
>
> Reported-by: Ameer Hamza <ameer.hamza@truenas.com>
> Closes: https://lore.kernel.org/linux-nfs/20260818225715.572140-1-ameer.h=
amza@truenas.com/
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/linux-nfs/CAOQ4uxgUOqFv6pVmdT_+4DjA0KQoQDCz=
N2Xz=3Dxm1FyumewHZXg@mail.gmail.com/
> Signed-off-by: Chuck Lever <cel@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/nfsd/vfs.c          |  7 ++----
>  fs/splice.c            | 56 +++++++++++++++++++++++++++++++-----------
>  include/linux/splice.h |  4 +--
>  3 files changed, 45 insertions(+), 22 deletions(-)
>
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index f9131827d391..c134064a1c79 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1046,7 +1046,6 @@ static __be32 nfsd_finish_read(struct svc_rqst *rqs=
tp, struct svc_fh *fhp,
>                 nfsd_stats_io_read_add(nn, fhp->fh_export, host_err);
>                 *eof =3D nfsd_eof_on_read(file, offset, host_err, *count)=
;
>                 *count =3D host_err;
> -               fsnotify_access(file);
>                 trace_nfsd_read_io_done(rqstp, fhp, offset, *count);
>                 return 0;
>         } else {
> @@ -1080,10 +1079,8 @@ __be32 nfsd_splice_read(struct svc_rqst *rqstp, st=
ruct svc_fh *fhp,
>         ssize_t host_err;
>
>         trace_nfsd_read_splice(rqstp, fhp, offset, *count);
> -       host_err =3D rw_verify_area(READ, file, &offset, *count);
> -       if (!host_err)
> -               host_err =3D splice_direct_to_actor(file, &sd,
> -                                                 nfsd_direct_splice_acto=
r);
> +       host_err =3D vfs_splice_direct_to_actor(file, &sd,
> +                                             nfsd_direct_splice_actor);
>         return nfsd_finish_read(rqstp, fhp, file, offset, count, eof, hos=
t_err);
>  }
>
> diff --git a/fs/splice.c b/fs/splice.c
> index 9d8f63e2fd1a..42ad712a0f4d 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1009,21 +1009,14 @@ ssize_t vfs_splice_read(struct file *in, loff_t *=
ppos,
>  }
>  EXPORT_SYMBOL_GPL(vfs_splice_read);
>
> -/**
> - * splice_direct_to_actor - splices data directly between two non-pipes
> - * @in:                file to splice from
> - * @sd:                actor information on where to splice to
> - * @actor:     handles the data splicing
> - *
> - * Description:
> - *    This is a special case helper to splice directly between two
> - *    points, without requiring an explicit pipe. Internally an allocate=
d
> - *    pipe is cached in the process, and reused during the lifetime of
> - *    that process.
> - *
> +/*
> + * This is a special case helper to splice directly between two
> + * points, without requiring an explicit pipe. Internally an allocated
> + * pipe is cached in the process, and reused during the lifetime of
> + * that process.
>   */
> -ssize_t splice_direct_to_actor(struct file *in, struct splice_desc *sd,
> -                              splice_direct_actor *actor)
> +static ssize_t splice_direct_to_actor(struct file *in, struct splice_des=
c *sd,
> +                                     splice_direct_actor *actor)
>  {
>         struct pipe_inode_info *pipe;
>         ssize_t ret, bytes;
> @@ -1147,7 +1140,40 @@ ssize_t splice_direct_to_actor(struct file *in, st=
ruct splice_desc *sd,
>
>         goto done;
>  }
> -EXPORT_SYMBOL(splice_direct_to_actor);
> +
> +/**
> + * vfs_splice_direct_to_actor - splice from a file through a caller's ac=
tor
> + * @in:                file to splice from; must be seekable (FMODE_LSEE=
K)
> + * @sd:                splice parameters. The caller sets @sd->pos and
> + *             @sd->total_len. @sd->pos advances as data is consumed,
> + *             and @sd->total_len is overwritten with the length of
> + *             each read.
> + * @actor:     consumes each pipe-full and returns the number of
> + *             bytes taken
> + *
> + * Description:
> + *    Splice from @in through @actor, for a caller that consumes
> + *    the data itself rather than sending it to a second file.
> + *    This helper verifies the read and emits the fsnotify access
> + *    event. do_splice_direct() leaves both to its callers.
> + *
> + * Return: The number of bytes spliced, or a negative errno.
> + */
> +ssize_t vfs_splice_direct_to_actor(struct file *in, struct splice_desc *=
sd,
> +                                  splice_direct_actor *actor)
> +{
> +       ssize_t ret;
> +
> +       ret =3D rw_verify_area(READ, in, &sd->pos, sd->total_len);
> +       if (ret < 0)
> +               return ret;
> +
> +       ret =3D splice_direct_to_actor(in, sd, actor);
> +       if (ret >=3D 0)
> +               fsnotify_access(in);
> +       return ret;
> +}
> +EXPORT_SYMBOL(vfs_splice_direct_to_actor);
>
>  static int direct_splice_actor(struct pipe_inode_info *pipe,
>                                struct splice_desc *sd)
> diff --git a/include/linux/splice.h b/include/linux/splice.h
> index 9dec4861d09f..4e91d03ed645 100644
> --- a/include/linux/splice.h
> +++ b/include/linux/splice.h
> @@ -79,8 +79,8 @@ ssize_t add_to_pipe(struct pipe_inode_info *pipe, struc=
t pipe_buffer *buf);
>  ssize_t vfs_splice_read(struct file *in, loff_t *ppos,
>                         struct pipe_inode_info *pipe, size_t len,
>                         unsigned int flags);
> -ssize_t splice_direct_to_actor(struct file *file, struct splice_desc *sd=
,
> -                              splice_direct_actor *actor);
> +ssize_t vfs_splice_direct_to_actor(struct file *file, struct splice_desc=
 *sd,
> +                                  splice_direct_actor *actor);
>  ssize_t do_splice(struct file *in, loff_t *off_in, struct file *out,
>                   loff_t *off_out, size_t len, unsigned int flags);
>  ssize_t do_splice_direct(struct file *in, loff_t *ppos, struct file *out=
,
> --
> 2.54.0
>
