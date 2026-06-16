Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B01543C063
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781610626; cv=pass; b=siZhiwU7+bbRlzRzhMzgggdyzKWd7FJ8eH24eJWLp2sJkuO5s7Zhgax44oMnxlI3car+ouMcLcavntX6MYG3Vv3EV9mO+sCJzfRBYsQ7q0FtRVI0KJ96gJprK41hYmLTw55g0pQObAIMBVt8VKZm4LiOfDdlcQwnEgOq/bI0nJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781610626; c=relaxed/simple;
	bh=QKG4i+4ZHEfwGJFf6TT9YM//DhFhI78L2GggokTL2Fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FyxEbobDtoVC6fet82L+BAYWiUp2ycmvwEJECH8m66ltR5k3lNxMF++4n2UnxJ4ABhJX+FwryzQjg6IOW4ZFcmDMtOQxWA8GmWrcvgUNoJM/s8awH2ZpK/jxw5hmHqPNpJYVoKLkJDgpqdzI83Tkk4ogg77leoOwR7dLp3oR43M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oqlCsrJ/; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqlCsrJ/"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68d232ed3f9so6900339a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 04:50:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781610624; cv=none;
        d=google.com; s=arc-20240605;
        b=DldZNHOzW7EN49HWN8T96J7sF/Wa5IHZvoaX/FM4WCeeYcK2ni9LDDNd6S7ATNUHQU
         Vi4mKZROrXtOeiRbK0+ORb7YFwZC5R4iMrageqwFj6Tht7UENN8NAqKpRLKjLtAfEy70
         WvBJNPF0VhQqvVJuchz7agYRFmvue+E8OQfAfALbDK+/wd0lAUqyoYRB1CoX2BfrXvP/
         TL5oFgxwCyfx1tntRV2C6LkQseS5/kji3PUNWwo9YMaSgEzbL/olnvyaW3mrWL7zxZfg
         6kXC+1zI/mQmLjzTfxIju8Qj4r2Oi1ZBMko6pJjQRXgHb18Mlff+Mdhkpo9zvWNS3fA3
         fpfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RpPwsbenHMVASJp6YboD7PaeEbUb4DMpuUJdrbKpUZ4=;
        fh=rirYnOE6eLi7hcXGB9Cjy46FANmZjBrPjAbjyhRvqA8=;
        b=AwrOqaARLnUVb2x1zX8ee75mPI8NXVffaUX305lsuEa7vC+og17xLSHoSh7tniUJvU
         iRRzIfR+4L0xLQtf/ff2mYz09ZKNrmMsf3acwCNQOV6//NCALdUUpoJxk4/YHdXbglZh
         JYwxyasmIxA00/m04F7K7XrEwux8PR2/2Sq6rvuQhhzfgvH3n2W5y+ITo3mU2JzlQYqP
         HyGGygAnG6+qb3ZxmMVIj2xEZOM/4aWcyb1b0I/YGXSo77Q/g+iy5RTcAR63tyUhkDCx
         GW6gLUcQzml0Yv5TShyHo7lAYxrz4ZIt3ZyUv+CC0DT5gTKjC8WflHFC8KM09YFSU+66
         B2Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781610624; x=1782215424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpPwsbenHMVASJp6YboD7PaeEbUb4DMpuUJdrbKpUZ4=;
        b=oqlCsrJ/WvhtmBqfpk8oCYpC3UBQtXmWD3Venp9hWuyyptDs3R45E2gJmX9hKqwFub
         krq8x1ZdHyJCkQ+txYnXIKItQW0IMDes2sqNLElIS49ZhxzjfkKrPLu7d/JJykD4VOfc
         OUABpcLe6zvHHrS1dcS9lmv96GzC+XFaEcCwCZvdLn4eTvzTfl3afyM+Vud8bWPPPC9Q
         H9JB7fnvHHnJvLRFj6+cJpJ55qnmIaNwt/hbvp40MHv+BCOdmoHr6psK7dSkGw3FZleD
         ptYUEirEraVZI+U/hOWAuJI71KSTzvu/68DnAbLPPjUQzpDWRjlrwVptcKKUw8vhecy5
         50Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781610624; x=1782215424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RpPwsbenHMVASJp6YboD7PaeEbUb4DMpuUJdrbKpUZ4=;
        b=R7Qd3ZdnhkmdA9cbVxvCOpWVY2bTTheMc5GpPY4zvEAhcJLMtOvU668HGllDoVm9JL
         0D4OeCOsJGqDk6jUIB+qyYdGtT1R7UFErKKXJM/WE8bcsikdqYPqunWm3FNRGu2V4ATL
         3618ptuWqR3oqMYh1GPpB1349rd062JC/E2SybotVsoqsANtcfTgT5zEUXLpChyKrPi8
         9NTxUeJkgYuKSMUn9Tnhi7EQA39c/aYtUCEUAjfm+G38q9kgdgyc3MPoz1JjfT5amAdb
         EM3xNJLpguN6izpJ1o3uxJ5huioise/hImZMKd3lwZZFUseJAw35cVeT+a/LeJp9Hmtx
         z5rw==
X-Forwarded-Encrypted: i=1; AFNElJ91tBPejGY+IhdSCw6zQVVg9YJqSvI1EYyn5Xv1K9XxjMPIINQ0rqN8NprwhQB+Wsjb9mVYkr2cSsSG3QI9@vger.kernel.org
X-Gm-Message-State: AOJu0YwY4PSJAYRdceNhZPvj4I5ZPmaW8iZwfc1YjLTNFvaNEGa38Et4
	BZTZ5GUOrsB6DNNqUXMqmh6gW9PMkUVi2Jxiw9yh60iyAbSQ0OQQhiYRylq9n0yozNrpnEAHgvn
	tz3OjgUHC9PPabPk9AqPvYFThuhkS4Ao=
X-Gm-Gg: Acq92OGk37A57f69JtPnubp2YyY8d8I1XMFLSKP9h+HQfGNc6ubz2cgmL0oMhV3CSxB
	/0yi3aJSSgwFr2/Gzcws0B+g/9hqYWetIAvz6lVinNjbA/zDwngLI8VmGqWp98ZsUFW0BKknx/o
	exmeS35i2UIz5cu/f2I1rlfp4FTURGTOb/PuQibUKlXHg3r8NawnjOvp8pxgADcgZSYOtTytS9J
	GwwsttecYgZYgEzkHUDteDGA+7DCexpmArrY4Hi2jDMHxpRfo74TjhPRx4VuDCLdmFuyz+uhXuq
	j+H0wllbw5JWXwCk5uTzFmMsd5yBAJI01Wal7gR68A==
X-Received: by 2002:a05:6402:42cf:b0:691:affa:38da with SMTP id
 4fb4d7f45d1cf-6950875976fmr1864373a12.1.1781610623821; Tue, 16 Jun 2026
 04:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529031918.7361-1-russ.fellows@gmail.com> <20260616014419.7913-1-russ.fellows@gmail.com>
 <20260616014419.7913-3-russ.fellows@gmail.com>
In-Reply-To: <20260616014419.7913-3-russ.fellows@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Jun 2026 13:50:12 +0200
X-Gm-Features: AVVi8CeOZ4TmIF70ww8MhNwGTFIWGJbtaB6gZTfHRBvvjyTFOqpaSXGuF8UoIeY
Message-ID: <CAOQ4uxioaHgn2gAevs4_GVN9z_XM8CuiBkOUzyP75Axi3Ecaww@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: allow parallel direct writes in passthrough write_iter
To: Russ Fellows <russ.fellows@gmail.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Russ Fellows <rfellows@xlrait.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 3:44=E2=80=AFAM Russ Fellows <russ.fellows@gmail.co=
m> wrote:
>
> From: Russ Fellows <rfellows@xlrait.dev>
>
> fuse_passthrough_write_iter() currently relies on the generic fuse_dio_lo=
ck() path to decide whether writes may run under a shared inode lock. That =
couples passthrough to the regular direct-IO helpers and does not make the =
passthrough-specific safety conditions explicit.
>
> Keep the decision local to passthrough.c instead. Allow shared inode lock=
ing only when all of the following are true:
>
> - the open carries FOPEN_PARALLEL_DIRECT_WRITES
> - the write is direct I/O
> - the write is not append
> - the write does not extend past EOF
>
> Buffered writes, append writes, and EOF-extending writes remain serialize=
d under the exclusive inode lock.
>
> This preserves the parallel direct-write win for safe overwrite I/O witho=
ut exporting extra helper APIs from file.c.
>
> Signed-off-by: Russ Fellows <rfellows@xlrait.dev>
> ---
>  fs/fuse/passthrough.c | 46 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
> index ee822a983..c32b35a6d 100644
> --- a/fs/fuse/passthrough.c
> +++ b/fs/fuse/passthrough.c
> @@ -25,6 +25,38 @@ static void fuse_passthrough_end_write(struct kiocb *i=
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
> +static bool fuse_passthrough_write_exclusive(struct kiocb *iocb,
> +                                            struct iov_iter *iter)
> +{
> +       struct file *file =3D iocb->ki_filp;
> +       struct fuse_file *ff =3D file->private_data;
> +
> +       if (!(ff->open_flags & FOPEN_PARALLEL_DIRECT_WRITES))
> +               return true;
> +
> +       /*
> +        * Passthrough writes do not use the regular FUSE direct-IO iomod=
e path.
> +        * Allow shared locking only for direct overwrite I/O; buffered w=
rites,
> +        * append writes, and writes that may extend EOF remain serialize=
d.
> +        */
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
>  ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *=
iter)
>  {
>         struct file *file =3D iocb->ki_filp;
> @@ -54,6 +86,7 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb,
>                                     struct iov_iter *iter)
>  {
>         struct file *file =3D iocb->ki_filp;
> +       struct inode *inode =3D file_inode(file);
>         struct fuse_file *ff =3D file->private_data;
>         struct file *backing_file =3D fuse_file_passthrough(ff);
>         size_t count =3D iov_iter_count(iter);
> @@ -70,10 +103,19 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *io=
cb,
>         if (!count)
>                 return 0;
>
> -       fuse_dio_lock(iocb, iter, &exclusive);
> +       exclusive =3D fuse_passthrough_write_exclusive(iocb, iter);
> +       if (exclusive)
> +               inode_lock(inode);
> +       else
> +               inode_lock_shared(inode);
> +

This is TOCTOU racy
You are missing this important part:

                /*
                 * This check
                 * should be performed only after taking shared inode lock.
                 * Previous past eof check was without inode lock and might
                 * have raced, so check it again.
                 */
                if (fuse_io_past_eof(iocb, from) ||

Either you duplicate fuse_dio_lock() -> fuse_passthrough_lock()
or you find a way to have the two share common helper (prefered)

>         ret =3D backing_file_write_iter(backing_file, iter, iocb, iocb->k=
i_flags,
>                                      &ctx);
> -       fuse_dio_unlock(iocb, exclusive);
> +
> +       if (exclusive)
> +               inode_unlock(inode);
> +       else
> +               inode_unlock_shared(inode);

In any case it is ugly to open code this so at least a thin wrapper
or even a scoped class would be in order (e.g. fuse_passthrough_unlock)

Thanks,
Amir.
