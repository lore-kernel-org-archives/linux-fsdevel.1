Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C904D3769EB
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371489; cv=pass; b=sP3bDPtZHiZ42mBXnD9CqXToyaZHn2mG7gVXGmmDavV8Hlg49okPxpSKYGJ5YN/wCbNcuwXDOYK/6QYVpUz4eQQIKnDaTNKA/zcwMdIZk22SVYjv+GgG4YrAi7GisdsYQFeh8VJ70p+bBCb9z5ApggbS3eipWkaKVTsS83n+YOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371489; c=relaxed/simple;
	bh=SECvFU05/+nxt8hAs2OeVcMqxUYhLQUpcxgdiJHfKPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1U8oG69iP3FUmvxqNHAcAZp9Hf8Lgx1V4HfJgxokOp53+XH5JMCPmzHcqkuB+wPBSXlUZ6Ahur2AaCvntlb84XmvcqqPTFJELK2vj7Gu0Lm0O2fUnO884mi+RuwkCuTk1/XXNftaZSWaPSDOSsuqoSaRmyEvENSJ7Qdy8O+YWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShsvLZ9z; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShsvLZ9z"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1670dad7a8so212677566b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 10:51:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788371486; cv=none;
        d=google.com; s=arc-20260327;
        b=I4ZKC1bvYXlajaQsImPFDCeBe9cIgKBb6CgKVaXxKC/tGUzZ+MmZenVvKPMgvn17/g
         OcuLue0qaZZmGvboCh2FX45yNeAhEg/aeonEC1giiSi9pUq9+0b20sM4jKz9OI/6JMkt
         ZxGTk+zTuK4tF97tzhrmzdZhY4dq4txdRhCzcOiqA3B+XOSx3Zq0R26sFn/pxM5nHTzW
         90JYXW1ywDeWl4AVeGu00+JvJOKbE8QaVIVSeRLMClLSs1GtmrXCl5JIk1wxGRmcKKSY
         HZP1RfewrOIQiSf+II8qQ8LsAfxmzUpGsFvl5GVZocXNzEg2Wn4W4pZuf1cTQ8w32pKG
         i0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3rn9oi1ELvXocerRD3tvFNeJc+rMH7bo8PRnvbcdULA=;
        fh=jmaaYsQdXNsKEqlbfqqX6El8jp0C4ibNf7dVQu9DElU=;
        b=FPp9yrMSE+4UzqDaj9JZtRVu4JwTY8vuFpUP6wCUnl+u/KWSmAESPgiAhcBhYiOu5y
         iGfG2EG6U7EAAqLm/B0UolVqXHdbu60VOHviLpmWE1gVhVhykZb0pIJsi2oKhPsuv71d
         YZqJuvkJ7qeoWlKQm8069A7eh8Y3c6jV4fx+s8yhzs/KMr7cwRaRZp3XezKus5OQy8tQ
         YjZK4HIuUqaeDaCDfy5tZQsVhXNftGfuMQiQMvtdp9kXeDAl9pOS+7pd/ENOyvzrBF5Y
         VRQH+0+JBywMzjZZBDTXaJFPioJuD51IURrYrxd7Xm00YEQa6BxFOMEuAblpazxS0Jua
         hrnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788371486; x=1788976286; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3rn9oi1ELvXocerRD3tvFNeJc+rMH7bo8PRnvbcdULA=;
        b=ShsvLZ9zfbBldY7sWYFWzyLZYOd3pHXdnJ2eJYVd2Wa7D3H0uZuwMy4YRcDTHA6YK5
         DsiMg4Xzj4HO20NIIhE8ZuNp/maRANNxrm7j5wB2wt90sP6snoQ5w04O0Ck3rFEHYamv
         O+3805Ijv3I/kIWHUG8iJBedL8td5hYKFGot+wn0ks1GJc/KTzt3Bpzkl90wFShYTScZ
         uyqLsjO0AAEEr3EVeGY/r1J4SryaP+1oTNG4hyAmgiTPq5VFazVPn2i9HOhN4jWFfpGq
         rybZoBR6yde403rTbP0/UW4M/HMW/86p/JRtN0PCcsxhCBdI2pM1MUaEadPESxaZq8jp
         TwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788371486; x=1788976286;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3rn9oi1ELvXocerRD3tvFNeJc+rMH7bo8PRnvbcdULA=;
        b=d/Dt3aIdvLCIJjbNW97k8WqxWY7XQsCkDue/CWyOtwnX15l/TCoMNrGNvEAsEflSeu
         4oHSbja51zl+bsxI8BiWjbmZR9VcW6liF3An8e9OoSnHqkY+dMb5yL7HaGkPBVafTAHG
         f/jZ+qSi7KWps08dk6dTvvz6dzZO+uJb5f6DIW+Cce/iVS8/PyEwmZXlVMTHdCUVOhDQ
         TfOg4hVwAi0ABfgy23coXXj6EcIX4PP5nMnh9rN38SEQtn8C16bA3woVQD06efA7gvBa
         GFrBLSZ6O1jikXcSF5pvAtzMm57l/9DjGbbnrazuyV0nSsqHyuKQQ+NMD1IixStbG4/W
         XiSA==
X-Forwarded-Encrypted: i=1; AKwUvByGiDXpsHbRxpKPA6Iulg5wQ7lU5eUepKeQW8uE3zipdeE1G3Wn9I1n7wliqSIl2U6sndtcVDAB0pC+y+NJ@vger.kernel.org
X-Gm-Message-State: AFuF++kh6eKD371n3pg0l+A/aWKsZmllmub4HV1vvwpXRI00ijkrVa7a
	P8Og5KZcms5hzHs5BhtwoMVFESYgriRjqTCHLd79OW7Z8CIljIyBHvIm8fIFv74Dj+F6jlYSrh6
	3h/T5l7AvJOEN3rai8X3IrXe4fHVRzuA=
X-Gm-Gg: AYBFou0ZE0UEnra+Sxw2oFQdWLGMsdpVkKKRXQ+IMJspa8Zv28khEwnRrTXRRzlMrxB
	Bp2ERtmFiZ6Hy+DESjJaLFQFGr/HYVjjWql0Ykdga24KNba9+XmQggguW0+zRfLanbkvm1Wom7s
	0JUM5IMEtpXJbpPuN4iNDWZKZyIYgVz1LTvHp3tFvWFVj+UgJ6ME0wo1q8d/5Dwjo5gjmmmNyNq
	KGk+3AFmOhcfAKCzr4BxRbeQkobud1HhFIDHwpOI4p56eqezZPhU5lZhFFl00Jg6lIy/FAoQML/
	/WuDi5O5I/lblZho7RiyP65i/7cIi8CQH+bHHBeVpIQ6Yg3/NZOMvJ3eGjrAd1q2oD5+fGQYf3K
	/
X-Received: by 2002:a17:907:6d16:b0:c1c:2007:298e with SMTP id
 a640c23a62f3a-c25d5711c1fmr395888766b.24.1788371485953; Wed, 02 Sep 2026
 10:51:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org> <20260902-work-coredump-unlock-self-v2-6-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-6-1bece368cbb1@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 2 Sep 2026 19:51:12 +0200
X-Gm-Features: AcwNN1USOS6nLTQeB0wVH7OhzuL1SyopZOeeizMZFJ4rxVJDV1FCTqHEpbJqFes
Message-ID: <CAGudoHE53YeY6Fqe5ovDP6FVG=1fj8d8jFDgC7L5vpT+_BK47w@mail.gmail.com>
Subject: Re: [PATCH RFC v2 06/16] fs: move unshare_fd() to fs/file.c
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 5:58=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> Move dup_fd() and switch_files_struct() where the rest of the
> descriptor table lifecycle helpers live.
>
> No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/file.c               | 18 ++++++++++++++++++
>  include/linux/fdtable.h |  1 +
>  kernel/fork.c           | 18 ------------------
>  3 files changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/fs/file.c b/fs/file.c
> index aec2adf59031..185de8deb39d 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -471,6 +471,24 @@ struct files_struct *dup_fd(struct files_struct *old=
f, struct fd_range *punch_ho
>         return newf;
>  }
>
> +/*
> + * Unshare file descriptor table if it is being shared
> + */
> +int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fd=
p)
> +{
> +       struct files_struct *fd =3D current->files;
> +
> +       if ((unshare_flags & CLONE_FILES) &&
> +           (fd && atomic_read(&fd->count) > 1)) {
> +               fd =3D dup_fd(fd, NULL);
> +               if (IS_ERR(fd))
> +                       return PTR_ERR(fd);
> +               *new_fdp =3D fd;
> +       }
> +
> +       return 0;
> +}
> +
>  static struct fdtable *close_files(struct files_struct * files)
>  {
>         /*
> diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> index 80f192412a5a..102fe4c20b7d 100644
> --- a/include/linux/fdtable.h
> +++ b/include/linux/fdtable.h
> @@ -103,6 +103,7 @@ void put_files_struct(struct files_struct *fs);
>  struct files_struct *switch_files_struct(struct task_struct *tsk,
>                                          struct files_struct *files);
>  int unshare_files(void);
> +int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fd=
p);
>  struct fd_range {
>         unsigned int from, to;
>  };
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b959191edf52..c456958c51f4 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -3207,24 +3207,6 @@ static int unshare_fs(unsigned long unshare_flags,=
 struct fs_struct **new_fsp)
>         return 0;
>  }
>
> -/*
> - * Unshare file descriptor table if it is being shared
> - */
> -static int unshare_fd(unsigned long unshare_flags, struct files_struct *=
*new_fdp)
> -{
> -       struct files_struct *fd =3D current->files;
> -
> -       if ((unshare_flags & CLONE_FILES) &&
> -           (fd && atomic_read(&fd->count) > 1)) {
> -               fd =3D dup_fd(fd, NULL);
> -               if (IS_ERR(fd))
> -                       return PTR_ERR(fd);
> -               *new_fdp =3D fd;
> -       }
> -
> -       return 0;
> -}
> -
>  /*
>   * unshare allows a process to 'unshare' part of the process
>   * context which was originally shared using clone.  copy_*
>
> --
> 2.53.0
>

Reviewed-by: Mateusz Guzik <mjguzik@gmail.com>
