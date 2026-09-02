Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45B9372EEA
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371546; cv=pass; b=sjogIN5AWt++erMLF3gahJzLXl31D3ewg11Xbd3QGRre3Dg/mH64/HgUtYzEY001J1wLYICrlAVHq9LOXotF3HLuVwK7LMSO/RsZAk/akgmB6BDM1wIQNeYCTXgID39zLxwkZgZNtxHUGNjs8e5CNM3UryQknM1CjDcHRuq1KwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371546; c=relaxed/simple;
	bh=sX7GyKaY1XFw+RCfiNGYj6TOEXZrqH0bIWkYEIadsHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gyjog41dksyq0+TSS79zVyVO14DDyGJquGAK61/++0QstcyKvlk1KZLkPQkV0AJMxO1WE8t7IADYWmLS0xMvCqYpmBrE1Afo02JTKTIajuWqhf3zEPo+9wI0UrlkOKTe3Sf7u5L9OtTCi23XNC9RXXU8pwLocbJFZR3UB9j/Qi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sIf4LydP; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sIf4LydP"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c255c58156bso231824466b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 10:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788371543; cv=none;
        d=google.com; s=arc-20260327;
        b=RnzeB8rKi+m2Dyy+46KqxETwdoRMjIs9nGYhh1eXc1upDPG/3MnyWV/E3d/0/AsGyX
         uCSLJqhgh0iJ2CTjg0cIpIWT4G0Rn4H1vzVz2oBG0FYx40rtmj8h5yDxSv54H1LDh/wp
         V6AZKypkzXICaU+pHyuv3CZkhKx9hCgMuZ3eIxky4MFazyb/LByC+fbcOL+p1OzpyHsX
         uCStJp5SaOA7ZEs6SNZWGNactIAThlN+secUikrG+Fa/A21l1wIOriDzqGD1NAjvXEDo
         Sq7d6BAI3GP28a0+sxD3vEe61lI87+YZ7ZCw9dMKflMRJDpWAjpm0HUMVh9oSz2sCI6i
         zMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C9DKhoVZvQI0psDIbllqpTLzf5VuwDcYtAVfzRfKSoA=;
        fh=9JxawEhJAYChAyaScrDKRwxHK1Nj7BNIg+8B9f/rRgQ=;
        b=bSTXiO7tRdXY1IAuJIHwzHa4ByLNP8UB8ajuwVW9PBHX7EI2FA/wjCOfQnkaCzJiSz
         u/gKvv9+HGKEnNEi6BoQyzHJA6LFmZRl6bdbvQiv4T8JCmyAPCF9aFhp0EfeaBQzXNQV
         B0RW+gtKZmga/X5sUh07Y38nQE98Sn/twGTCyUOGxJlmxGqI07qlH3d5Io2954gHOkas
         LmaAZeXebFK8Kd+fa8po6CRvMIBGMeSYuVjNPrlBpIREbrdK5Hf3c2Z1zDLKwshc5XXD
         EFo/W/wGcE31BJYhmOWhBbK0ivLOPIv6HWhPHjJOH9tYB9KZloJmIOEZx5S8zN0BzY1+
         xzqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788371543; x=1788976343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C9DKhoVZvQI0psDIbllqpTLzf5VuwDcYtAVfzRfKSoA=;
        b=sIf4LydPLcG2n4hODHtqVerNZ4AUKKikWHaWfdawyiZ+SZ0MaNn10/fnEpKKuq7wOL
         LO/7ARf8GUsv1oto/tGCY21/NfBha2gjJuiY5tlsOZ0IToHjZg6iTC7UgSgFjnfA3Y/p
         6cPbCpGPuXIkB0CaOESWQOB2RhX5yqa/ncAme4OE5wbtkiZzxHnP/ZI9Qvjur2nGzWRT
         sIWgAVk8HTk9sjp0wxPCY979xKnTz5VPmLCWgeKJWRT56t/Eu5yHWJL85pzyTUZIvCCQ
         rglnVZlGnEvzo8Hwzm4UmgrHyakbgG04eQj8kADfwn294aQskbMTSLbApW9JdmOS6YzW
         cMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788371543; x=1788976343;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C9DKhoVZvQI0psDIbllqpTLzf5VuwDcYtAVfzRfKSoA=;
        b=IN2iA3LSwSoIMG68URPgM+TEvcxvTM/FelqM4+ByZ4UTkQ5UKhJjUBTXnggrLhX6d7
         hRpUTnhvgZV1Q7uIou/1+FUBjNeG34nj9jtCDZ9eZZU7uCVV+HqfnMcdCF6DnYQvA7N1
         VPCHIjZo++lF0UIIM3E9BDRzXIa3UigUrzhHtmetQ4Y0IC3kVEVd5ZwbE1a+sqFNVHCl
         64oI1NH4G25mhJf1e8WTOIPT5MuKBjiQR/TSX0ReFscmg0jnT5DqhpbzQuxI8XQWDMv7
         SvYRu9d5snYpb98lPM8/RWZaDy0bhhXBLhUSpYtwIcruxRICj8FTGGO83Mg2FuA11Idi
         Rj/g==
X-Forwarded-Encrypted: i=1; AKwUvBzQX4GSPYBvxZ/eWRx20P8RigbVEQefPDcYTPK+SB88KGPe1jgreNYLrYjuGj+tdG9/Tm/WRmyyM5A69WQi@vger.kernel.org
X-Gm-Message-State: AFuF++lrMngYlmb7/aHiTsMreYRetDww+9Z/QZIISNqp5WPkD5zpEfu4
	3HEQQliOR0M0BwT9kcR18+KnqvPnkFvvUtcCLW5kpURjJnk9H74VOkftZkVjnosZoDlNmn618Sc
	xlwUmbYN5IrrfwaXAbIuxdhFVsJ1YDhQ=
X-Gm-Gg: AYBFou3u36Ahs54DoG/faNn/VR/P2dAyxbMANq4Zdv8890OtpIdjrjfVhVtf5PEdQ4t
	Ux9MGfiWCru0N+gBABG6QOd12pNWu/6JhkYE1594WbalgS/KcLR+dE5naVBjPAXHfOPAN+WdUGj
	hem7OvC9DT7SEO8zOX8uaKeOfk7xmFPIC14IilV50C9JJdPr17COzYNGYiDky4s47QPOtmnJvik
	/CBus3WTSIK0KhtOSOkABSvnIscre0hYJ+XtHDbRmFltu9HZMjNfbp5BcuSDWffn4nNZBYEC1uw
	gkNshW+BfxF9VV8DWF0ivmln/cw+PFW4wXrmbXg2976UymQCnwxnDYuu2aDXgBK/PDOoIjAyJaP
	5N/6bGl9D44Q=
X-Received: by 2002:a17:907:94c9:b0:c25:64ea:4d70 with SMTP id
 a640c23a62f3a-c25d544ec3fmr431141366b.1.1788371542889; Wed, 02 Sep 2026
 10:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org> <20260902-work-coredump-unlock-self-v2-7-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-7-1bece368cbb1@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 2 Sep 2026 19:52:09 +0200
X-Gm-Features: AcwNN1WhIGkhS7tGjbWWZM_U-IjARV9zTUpZdIvhiojepVOJgTz-l6h04Ueszps
Message-ID: <CAGudoHHRx8R5W0cGqiHt4K6m0K8XyzzYzE+zi_XDxwvOax8phw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 07/16] fs: remove unshare_files()
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 5:58=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> exec is the only caller left since commit 433967cab51e ("coredump: stop
> unsharing the file descriptor table"). All it does is call unshare_fd()
> with CLONE_FILES and install the copy. Kill the pointless helper and
> open-code it.
>
> No functional changes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/exec.c               |  5 ++++-
>  include/linux/fdtable.h |  1 -
>  kernel/fork.c           | 24 ------------------------
>  3 files changed, 4 insertions(+), 26 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index b1f449dba258..713819244d23 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1124,6 +1124,7 @@ static struct file *bprm_identity_file(const struct=
 linux_binprm *bprm)
>  int begin_new_exec(struct linux_binprm * bprm)
>  {
>         struct task_struct *me =3D current;
> +       struct files_struct *files =3D NULL;
>         int retval;
>
>         /* A pending PT_INTERP substitution this format cannot consume. *=
/
> @@ -1160,9 +1161,11 @@ int begin_new_exec(struct linux_binprm * bprm)
>         io_uring_task_cancel();
>
>         /* Ensure the files table is not shared. */
> -       retval =3D unshare_files();
> +       retval =3D unshare_fd(CLONE_FILES, &files);
>         if (retval)
>                 goto out;
> +       if (files)
> +               put_files_struct(switch_files_struct(me, files));
>
>         /*
>          * Must be called _before_ exec_mmap() as bprm->mm is
> diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
> index 102fe4c20b7d..15ee6292e0e3 100644
> --- a/include/linux/fdtable.h
> +++ b/include/linux/fdtable.h
> @@ -102,7 +102,6 @@ struct task_struct;
>  void put_files_struct(struct files_struct *fs);
>  struct files_struct *switch_files_struct(struct task_struct *tsk,
>                                          struct files_struct *files);
> -int unshare_files(void);
>  int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fd=
p);
>  struct fd_range {
>         unsigned int from, to;
> diff --git a/kernel/fork.c b/kernel/fork.c
> index c456958c51f4..ba74705ca191 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -3336,30 +3336,6 @@ SYSCALL_DEFINE1(unshare, unsigned long, unshare_fl=
ags)
>         return ksys_unshare(unshare_flags);
>  }
>
> -/*
> - *     Helper to unshare the files of the current task.
> - *     We don't want to expose copy_files internals to
> - *     the exec layer of the kernel.
> - */
> -
> -int unshare_files(void)
> -{
> -       struct task_struct *task =3D current;
> -       struct files_struct *old, *copy =3D NULL;
> -       int error;
> -
> -       error =3D unshare_fd(CLONE_FILES, &copy);
> -       if (error || !copy)
> -               return error;
> -
> -       old =3D task->files;
> -       task_lock(task);
> -       task->files =3D copy;
> -       task_unlock(task);
> -       put_files_struct(old);
> -       return 0;
> -}
> -
>  static int sysctl_max_threads(const struct ctl_table *table, int write,
>                        void *buffer, size_t *lenp, loff_t *ppos)
>  {
>
> --
> 2.53.0
>

Reviewed-by: Mateusz Guzik <mjguzik@gmail.com>
