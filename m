Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CAB3DF008
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371419; cv=pass; b=rE8ps40hj2vq8sz553nBQAizaqamOfbd4Pmi7zxZG+SASKXMtY8576ozGhCedRQgo24nHgMSiH15Y9ZwpAEo1GxHrx/+B8Pclk3qEbvaxfqvgfhYd680Ero+0Kr1IKA2/lAl/x6JYJ389wC8MImuHJq0wkntK40DT6zhBhDeQOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371419; c=relaxed/simple;
	bh=+3lYz4Quk960sxh3hMy27EgXWzDOIe2Fp0XCiRrRk+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5uktCUhTpEsDi+JQnqMgQHlMV0R8uC4lwEiZmQUWOGjzFmWuqB++zbk/iVlstR1oAK0HgjBY2PmQzHxJHhc6AES92HmGsE7P56OpQjX4ASI/u4IG99IXXEup9sHyG8ilzSHLemKRW3BpOrkDCcjkrQ0bTYi63PF0aVcanh+UDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMrZ2txq; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMrZ2txq"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1c26d7e951so215449466b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 10:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788371415; cv=none;
        d=google.com; s=arc-20260327;
        b=hx2PmsEFx35Y5g4llcPQ5vXClKqlDYc+nDxggtuNg7JEBZ3pNi39No0KGGaiFrkYVI
         LM3dKHzc21M91HSpSJoErFgiK1uKdBFu/2pE/hCpklXBk9MwB5oRg7HlgqqutKqvw/pO
         1w3i9QMWh6wCfzX6IafqoGmvxTo2pz4bsQWm0DyY63UdPssZ5w0cKMgcZqhjuR8g0kIA
         1OhV2niClFwnVN1ORgUxpzoxt06Yg2oJcRFEZMYYLXE9i3QXl+T/gt7Dm2o3aYJ5wuhS
         J7sPzwvKLtnqNMBWOcaAZo0TxeIWjiz3h16OmVi2VfRLg1/3Ss+Um2/rJFDo4wAgbsQS
         Ta0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NB4cqS2QhmR72zw0RIFxg9R8Oz6tuoKC4Xns5VQvo38=;
        fh=xe08lcuuyHYCHzjIf56uyHqXQRqXVid9e33ZbN2DkQI=;
        b=qzMHFk6pOgKBgpIu12pNlby8v7ornntICZuuZdAMfqMxyFd6qkX+pfBkHk4EcH4lph
         CYhquLrKTzn6Twz3rXLwZcnLxJbgCrBDyJbsF4YJXDerH76JhCt+7/cMVz7Yvsu1cFGF
         Zm+Yb5cfWzHpOrAIqhSp1GYI+JJL6PQdEADvKOY0wXBER3kTUSpkPJB9uv2PEiWCM/2p
         DRvtuIwcQ3C3Bsp3f/v5C68OMEFP/qG4+con3W1YNNoo00ovnc1wuqAjTppIwsfT2Kng
         a8FLRTGfNF8+10+dVYP5Ho10QsxvG2y6cLBpcQyZ0QEMqG7hzOdbq99ivFsjWzlttG4m
         4gsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788371415; x=1788976215; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NB4cqS2QhmR72zw0RIFxg9R8Oz6tuoKC4Xns5VQvo38=;
        b=fMrZ2txq8ZeRNb8fiOnDGeciUwFYLEXIVqZO7U9b1r0vA1JeE8e7Cu64dzm877aQah
         +Wy/59nqPu1oMkavdqYfunR6w3OoP8KsHfyVr0GSXtlA9fcoUh4BVb1bL3zY73BU5YFR
         1RSLltTUTJzrcvrh2juI6l9EtQmIRccI7l3ip4GC/H2+aGuS13zImXsa9pEl8M2fN//M
         eSU5y31zacdnf5V8v1cRAH05jj2vdxomazCKZRexgRPVFCsuI9XBwrVBA6yPcJF4bR+b
         0p08GfqBj9uAKwFg1jPy/2LQSvCSJAJ/eMKGbJZQ7/tLDWQkSQXHjNfaCe0pHLlh6ZOA
         eG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788371415; x=1788976215;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NB4cqS2QhmR72zw0RIFxg9R8Oz6tuoKC4Xns5VQvo38=;
        b=hbFUa1pEQQAHWD7zc0m3KMp6a2MlwouBuLrCgrO8ULS6e+hSGP/hX9xmuhoc8i0MBq
         lHDz4E9gvrCzS8w0kIU9leX7dTlUiSmGOuRSISLyrGTyOCskzGXytUaj9V9XD608bo3A
         NL4NT40pT5y38Uh1ghxE/swxCsCvmX2ye6DbwZcHJ+E+i7zczjRiVI4cMvw0ypAraAdh
         co617LyeSzT9Nevu1sQIm1RN6SxYTn5Esnmr5Bg0epm3Jmdd3KxwMuMm1QqysgpFoxEV
         W/NLmX7AyTKZzZELGdBycYqFhIR0Qc6+M/VMrVhPL/5Ne8xWIfAWIArS2UtB2A17gTL7
         2iuA==
X-Forwarded-Encrypted: i=1; AKwUvBye/FSSx7MlhjXO0/ckyeEVAXBbrs0+SSPkeM6HTEcPgAqZfNtnJF3HTRZIljTVVqSse2yLZCyIDPFg6+XB@vger.kernel.org
X-Gm-Message-State: AFuF++l30vp2Arr9m4zfQFGmb5YduTruZJU+4poDxHx0HFy8BEnnj9gZ
	i3+Vok4sbGXeEy1B/RgkdWIhXMPPnGns/p742KPdnwOdrsI7EJ7Krc57g2SdLiHwhhTzKmeidq9
	RWqWhsQmyPikbNoksG+6CVsZV/ZTylUk=
X-Gm-Gg: AYBFou0Yv1QLcWIJOCA23o4ZmtPm0YvF3uNb9ZiMM70mjZDDaOjA47pdZlGawnAiNJC
	Qx9r6HhLqh1DMQzcbQ23YKcv3OKONlT/S3CsDWFOWPZDv6q4xW4UR6LIGtKyWk6WGrSCb99Be1c
	XZyEs2tCeoOrltEhcQEEwwuYSPhDjku6rlKmU/v5WpjqHClt2hxFjs2WaaNhABikKobDKBwwLuz
	YkYPI11LLXZOZgd2Ns4sCxIMMKLJDB77gh++me477mQou2PosYMH2LoZcqkXeb9t25D8lViNC7r
	VJRn4jZatWWC7WZ9ebg5D0738L3qDJRHxlTYCY6ZJLDfdlxHV5NyTffCIuuQfKb2/okTsq2Yoxf
	G
X-Received: by 2002:a17:907:3f92:b0:c21:7feb:4574 with SMTP id
 a640c23a62f3a-c25d52672a7mr484977866b.1.1788371415255; Wed, 02 Sep 2026
 10:50:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org> <20260902-work-coredump-unlock-self-v2-4-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-4-1bece368cbb1@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 2 Sep 2026 19:50:01 +0200
X-Gm-Features: AcwNN1WlgjJWrLmoD8V584g5Mo7DCS5DL4Mw-wefHIj4X0h7nbc7tl2ahGejx_8
Message-ID: <CAGudoHEzp1iJvdeUUpc53PWtCFoYT_JMszXAEr0RscmUXeFZLw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 04/16] fs: defer the final fput of close-on-exec
 files past the exec locks
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 5:58=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> Taks with lots of file descriptors pay a hefy price for offloading to
> task work. Port them to the fput_list() mechanism instead and waste
> files in free_binprm().
>
> Link: https://lore.kernel.org/CAGudoHGRvxd-EwwDasqoVhk5VbEvhtjjM7kCXBfFyQ=
8ykeC9CQ@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/exec.c               | 4 +++-
>  fs/file.c               | 6 ++++--
>  include/linux/binfmts.h | 4 ++++
>  include/linux/fdtable.h | 2 +-
>  4 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 92a02bce11d5..b1f449dba258 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1220,7 +1220,7 @@ int begin_new_exec(struct linux_binprm * bprm)
>          * trying to access the should-be-closed file descriptors of a pr=
ocess
>          * undergoing exec(2).
>          */
> -       close_cloexec_files(me->files);
> +       close_cloexec_files(me->files, &bprm->cloexec_files);
>
>         if (bprm->secureexec) {
>                 /* Make sure parent cannot signal privileged process. */
> @@ -1469,6 +1469,8 @@ static void free_bprm(struct linux_binprm *bprm)
>                 mutex_unlock(&current->signal->cred_guard_mutex);
>                 abort_creds(bprm->cred);
>         }
> +       /* The exec locks are out of the way now, see close_cloexec_files=
(). */
> +       fput_list(&bprm->cloexec_files);
>         /* exec swapped the mm but failed before setup_new_exec() freed i=
t */
>         if (bprm->old_mm)
>                 exec_mm_put_old(bprm->old_mm);
> diff --git a/fs/file.c b/fs/file.c
> index be06e09df41c..88ede1262b3e 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -884,7 +884,8 @@ struct file *file_close_fd(unsigned int fd)
>         return file;
>  }
>
> -void close_cloexec_files(struct files_struct *files)
> +/* The caller drains @list with fput_list() once it dropped its locks. *=
/
> +void close_cloexec_files(struct files_struct *files, struct llist_head *=
list)
>  {
>         unsigned i;
>         struct fdtable *fdt;
> @@ -911,7 +912,8 @@ void close_cloexec_files(struct files_struct *files)
>                         rcu_assign_pointer(fdt->fd[fd], NULL);
>                         __put_unused_fd(files, fd);
>                         spin_unlock(&files->file_lock);
> -                       filp_close(file, files);
> +                       filp_flush(file, files);
> +                       fput_close_list(file, list);
>                         cond_resched();
>                         spin_lock(&files->file_lock);
>                 }
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 2e87faf9a8c2..be935320f1c7 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -4,6 +4,7 @@
>
>  #include <linux/sched.h>
>  #include <linux/unistd.h>
> +#include <linux/llist.h>
>  #include <asm/exec.h>
>  #include <uapi/linux/binfmts.h>
>
> @@ -81,6 +82,9 @@ struct linux_binprm {
>         int execfd;             /* File descriptor of the executable */
>         unsigned long exec;
>
> +       /* Close-on-exec files awaiting their final __fput(), see free_bp=
rm(). */
> +       struct llist_head cloexec_files;
> +
>         struct rlimit rlim_stack; /* Saved RLIMIT_STACK used during exec.=
 */
>
>         char buf[BINPRM_BUF_SIZE];
> diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> index e6b641d9eb91..050f4a04157e 100644
> --- a/include/linux/fdtable.h
> +++ b/include/linux/fdtable.h
> @@ -105,7 +105,7 @@ struct fd_range {
>         unsigned int from, to;
>  };
>  struct files_struct *dup_fd(struct files_struct *, struct fd_range *) __=
latent_entropy;
> -void close_cloexec_files(struct files_struct *);
> +void close_cloexec_files(struct files_struct *, struct llist_head *);
>  int iterate_fd(struct files_struct *, unsigned,
>                 int (*)(const void *, struct file *, unsigned),
>                 const void *);
>
> --
> 2.53.0
>

The patch looks fine in its own right, but there is a pre-existing
deadlock reported and I think this will need adjustment to take care
of it:
https://lore.kernel.org/linux-fsdevel/f5e8166a-88be-46c5-8939-1e5227ffe4c2@=
app.fastmail.com/T/#u
* deadlock from exec_update_lock and reading procfs
