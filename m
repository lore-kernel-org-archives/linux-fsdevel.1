Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CB377559
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 17:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788370898; cv=pass; b=Pvqgy+Vjs1fSvCsvsWYmLpynW9dI1LqpHYqTJRvMrfDB/njMEFmPXRwRBsRzELmwCHHfF4HBODZuCJqZZGJ9/AWfeOLKdUny9cYGUIYQvQLFUP9DTOeT19BfNGuYGQtxzXjdBtPo1qZpU5sCk5ffU5+KGsvU63KdQ7cy6hIHKKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788370898; c=relaxed/simple;
	bh=P/fNdgveyvIOffDnyPB8ThAy80mPRYRzk/GxDd1IfhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1A0499/ek+eRrTOH9n+6C8GSUdu1+x1/MgCvkVaAUqfyO/LkE1sxRLDC5PfXoJUyHlkEgqi2yYcEHSKlRvqqth7tfrzHIdXzXcKPKHmPGHbaNstWYxogIafcRg6NUoKLDYnucxtlDDGBgIm+vQzDNEkImM17dWD1ycCu4TIy34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJcpIUFE; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJcpIUFE"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso2213382a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 10:41:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788370895; cv=none;
        d=google.com; s=arc-20260327;
        b=UtXUktjtQOtDmIIRXh7AIaw1MpFsNgciPOTMNFn5lzPJspZo/oi0pLGk8PxLS1uBVK
         lbH8xbnSESbKwn2HnehuOp3/jPdOW6GANRIO6bHK7Lzmjng4kdK7Kbt+KVG04DuChJkn
         iJciAq4m6G4x+Pl8qVZgyKuBsi1blOf7j+xYhtUWOqAOqnbE4HU7PulJkz2WgGAm3D5Z
         x8xxxwr5cYhhmbyH0WcctE1WOCqTkMBBMkCdLYLbhskmlB15/W8rGXDPVOh9ScFuZYE5
         WuDlHWIbS7yDPXcI8PExPZ33WGW63FHs9iXE9QxezoXzWKUtLDe45TWUafQnK34sF8fL
         rWTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nZjXP6C71JJBY6HlaGHQ/xBAtkI8kIb3Fn9SPQ9rTAc=;
        fh=XB3KFTZD/kEKQS10j09Ce+4CzSYOsD3Ot4mqFlxMPY4=;
        b=Zxq6iwtmCz2xJK95x/k5xqBwQ4EmwnwOzs2oVheEiu8c6r0PvXf4G6DuAM15FErT2O
         uJvP8KAX2L9vV6+s7GEfR7wBrf6QxxvQUy/YqO+fnZ3AX+92aVJaH97JjRskS1dLMHDX
         Uxe7n97zuGGV3uvXTZsag1fb9f8Y6jdwUvGuta+7YWybrF/7CdDoNXWripw6JC/gvMBR
         0Vgsvfv9Jjwh/enYmYSAX070jZiKmeoodEh9Um6it+j0en8ho4tmcIrDFOoxPdAGx9eW
         ze3NAPottmAbG+qVZsaGd4P4zPqFquuuYMOicVNzMwPhHZjicCiVLgc9TyEPIBUDfZbD
         3WyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788370895; x=1788975695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nZjXP6C71JJBY6HlaGHQ/xBAtkI8kIb3Fn9SPQ9rTAc=;
        b=CJcpIUFE2ZF6ci+35t9tKXqrqypZ3F8kHGyoGw2blI58QJZkNXrYuEZ4XmahvMBnsy
         3khElra/kMpwLO3/+9GQDRSf5dMjCekbQbnStuLkr1PaIYSfJXRdQjcaS0K5ywhUbEjf
         GCV5dM/O1vRxnH7TFsK3s2mqC4Y/kbCJMeVEK9Xr2SM0NwWW7pZ3A6C7Erm3ZQMkO3P0
         swL44W4NQbmWUp94q1ulRQKg8ljqmZLyOSLL6nzSN/hgNASfWXl/TiGF6f978k2NdoFA
         m3jdQBRi5mmbyv3uc1trgJSE5vi/sFZd+Xz/+rs+QyI1LrD15yv8oMwKf9ZzDwllb6It
         i+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788370895; x=1788975695;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nZjXP6C71JJBY6HlaGHQ/xBAtkI8kIb3Fn9SPQ9rTAc=;
        b=c/snwjEsUDkEy8uVBLdTvYodvtwF0CXG5V765KFy6dvkpXc8NVFajO+vKuIqBs5efH
         OpW2/HeG+d94B8tzAk5yZhWH0Mv+F/M3tj6cdBFJUIH2r4gj2HPFqeLgn67kVBbVSOSR
         E2idy8jy+O5BJ1MIWLV/q5GJQWzuN7fRwsjYb2ZraDmaU1okApq5aEsYSgq/y3vwXTUe
         3VAZC2GB++bwybW5t/m1K5YzEhOF4mv8l3m+Zy/uigwt1QWcTH7jO9EXxL78uuiHiDW4
         FhDzPZfPTsz/jdNHs6sjP/wbVhUDRV4oGt0tgPjUDrlV8wP97YnBJZfsP2hvu6/DwELy
         zV3w==
X-Forwarded-Encrypted: i=1; AKwUvBwf+9ujMdXh5TAKSwakEOESCtyVM08NBr7i9j+CMijeX4DuA7JfQzDDiIyx6/U6RCFJ8Iin3/I5K+oQ0QiS@vger.kernel.org
X-Gm-Message-State: AFuF++mQ9de3aOLd5hXcxWL4jW3TuhI59kjpbg+gLdOVTnUqpavX+4Ax
	HSm0MGv4xLr77ZYCHVTZgC8gzGJBY1O/nETkpmW7chTHRhF6qcxUif68JoSbuKEzMv8OArmo6Hg
	urHsnALoipTiLu9jXydHTl/cY9421R98IJMZf
X-Gm-Gg: AYBFou2KpnAJeHvChYeFc7HxLZEaW+GBf+sYQkRIUSG7D/kBkXKVyIucgVzDvgBTh+j
	kcWPLVx9ssKsXlxEaw4T+wYjWAMSEDHOKlJzYj5NfvFjl3vzcOS1GWOQoCUL/NcehE1ICiYSmi7
	jFvxWgIw7cL+mNgkuOzEdjrhulgsF3jsQMgLdg1cWrPgybTdFpveP0SbOqdwfxEcUzo9n44p3oj
	UU8IsG7624WEoC3/0AgXjzqeirgjJS/j3a2ZAXugYk/tnGgO5ga7qvpsHwLAjBKob83xSsOmRKq
	A5AK/spf/F8zS48BUfjWBLn7/2i0n6GTZhZxC5FfauaJltoYBoMPe54/sg0D0aLMOny2hRSZqhJ
	R
X-Received: by 2002:a05:6402:3789:b0:6a1:f95b:8cff with SMTP id
 4fb4d7f45d1cf-6a682566dd2mr4834635a12.1.1788370894352; Wed, 02 Sep 2026
 10:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org> <20260902-work-coredump-unlock-self-v2-2-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-2-1bece368cbb1@kernel.org>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 2 Sep 2026 19:41:21 +0200
X-Gm-Features: AcwNN1W723cIKgj1FKYaHNK8eqqlYCrj2hfqzGbuf6pr00AYM9PVAr7OI00jMzQ
Message-ID: <CAGudoHGQ=eTQjzY1cV6ZUa+CmTrTF0=au6r+_98CqEGnY+ZfxA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 02/16] fs: add fput_close_list() and fput_list()
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 5:58=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> Add helpers for paths that close many files in one go. They collect the
> last references during the walk and drain them right after
>
> fput_list() runs the final __fput() for everything on the list.
> delayed_fput() shares that loop.

nit: I think fput_list is a highly misleading name here, suggesting it
grabs a list of files to unref.

I don't have a proposal for a name I'm happy with and I'm not going to
argue about this, but to throw some ideas: filp_close_list,
fput_finish_list or similar

Regardless of what happens with the above:
Reviewed-by: Mateusz Guzik <mjguzik@gmail.com>

>
> We'll use that in the next patches.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/file_table.c | 25 +++++++++++++++++++++----
>  fs/internal.h   |  3 +++
>  fs/open.c       |  2 +-
>  3 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/fs/file_table.c b/fs/file_table.c
> index c68b8c0a4097..617912ca4e0a 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -528,11 +528,10 @@ static void __fput(struct file *file)
>  static LLIST_HEAD(delayed_fput_list);
>  static void delayed_fput(struct work_struct *unused)
>  {
> -       struct llist_node *node =3D llist_del_all(&delayed_fput_list);
> -       struct file *f, *t;
> +       /* Detach the shared list once, then drain it like a private one.=
 */
> +       struct llist_head list =3D { .first =3D llist_del_all(&delayed_fp=
ut_list) };
>
> -       llist_for_each_entry_safe(f, t, node, f_llist)
> -               __fput(f);
> +       fput_list(&list);
>  }
>
>  static void ____fput(struct callback_head *work)
> @@ -629,6 +628,24 @@ void fput_close(struct file *file)
>                 __fput_deferred(file);
>  }
>
> +/* Like fput_close(), but the last reference goes on the caller's @list.=
 */
> +void fput_close_list(struct file *file, struct llist_head *list)
> +{
> +       if (file_ref_put_close(&file->f_ref))
> +               __llist_add(&file->f_llist, list);
> +}
> +
> +/* Run the final __fput() for everything on the private @list, right her=
e. */
> +void fput_list(struct llist_head *list)
> +{
> +       struct file *f, *t;
> +
> +       llist_for_each_entry_safe(f, t, __llist_del_all(list), f_llist) {
> +               __fput(f);
> +               cond_resched();
> +       }
> +}
> +
>  void __init files_init(void)
>  {
>         struct kmem_cache_args args =3D {
> diff --git a/fs/internal.h b/fs/internal.h
> index c658c8a5ebd5..619eaeb23fd9 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -129,6 +129,8 @@ static inline void put_file_access(struct file *file)
>
>  void fput_close_sync(struct file *);
>  void fput_close(struct file *);
> +void fput_close_list(struct file *file, struct llist_head *list);
> +void fput_list(struct llist_head *list);
>
>  /*
>   * super.c
> @@ -198,6 +200,7 @@ extern struct file *do_file_open_root(const struct pa=
th *,
>  extern struct open_how build_open_how(int flags, umode_t mode);
>  extern int build_open_flags(const struct open_how *how, struct open_flag=
s *op);
>  struct file *file_close_fd_locked(struct files_struct *files, unsigned f=
d);
> +int filp_flush(struct file *filp, fl_owner_t id);
>
>  int do_ftruncate(struct file *file, loff_t length, unsigned int flags);
>  int chmod_common(const struct path *path, umode_t mode);
> diff --git a/fs/open.c b/fs/open.c
> index 6b1c14e684a9..7181665c3af5 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1506,7 +1506,7 @@ SYSCALL_DEFINE2(creat, const char __user *, pathnam=
e, umode_t, mode)
>   * "id" is the POSIX thread ID. We use the
>   * files pointer for this..
>   */
> -static int filp_flush(struct file *filp, fl_owner_t id)
> +int filp_flush(struct file *filp, fl_owner_t id)
>  {
>         int retval =3D 0;
>
>
> --
> 2.53.0
>
