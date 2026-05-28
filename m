Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF8F403EB6
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991558; cv=pass; b=DQIkvexZ6WWKt2K5zipD5aOqGYwIiFxDZY+pB5nOtNF+nQK4A8qJ2cNhXfsCGIjadrXnN9zDDX5ecV7YnkDIOrEW9ubqxuU5uPwpumxjQ+ETbfT+2A8CG21g52vgMSfcA/Cl/5nWblyEsS+JOLiMwZfmRgbLd7N6GOhHOfDGkSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991558; c=relaxed/simple;
	bh=XxaQyWrqGy8ALzKAMqk8RFHpO8ktxPpgBjNzrggPml8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=keaYOq0WbrOUOizrZS8fkEtXDP4yZCyXxdWC4XCDExT7mzrIS92cg2Vlx00LoeXzj8gatUUSrxJDLAC2vbyE/WxNMzUHMUZyP3o6vgbl7cre6sMLh8FQUGkCVxS6Yc3T//6vbDgcVBnrAhD7r7k5RNvneyRjX5Iyi5gT9I6+6o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnbVYHUR; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnbVYHUR"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67e9e343b22so17931085a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 11:05:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779991555; cv=none;
        d=google.com; s=arc-20240605;
        b=eeMjcZFzgA/gc8ZFzgaCsZ/fnjNC93yukperX1TYhFsrkyoNZ5PULg4cm210lfRRJV
         XUez0qxWkeorACiEhllxZUmzWvExEU83oF/PqDAcww69zoXAF7MxyDxWh77B8ZEqzPEO
         Rh/HYmO7Wg/qd15sCvCosAM0uKv0HaLZnDIPkuB9nD0PA83A2virlw5CdZV85RYX+vgL
         yisg45DK1QR1+OjQj9whKmFXlMWiQbkLWDbbLCscoQw1IUBFxi3H6sBeJsqYscM0F4iz
         eDVCMSQQ3Q+F4m6X4UOG8B5vTyaeoS7JWoc8FR2dJy1M+1M/73DOccHbyAB8Ktj5anym
         14Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l30nu3YKfLY2ER0SPLKJG8LovOKpPfL4wcmIkenbb4E=;
        fh=ODRa2T5+Zs/4Xe8zuNKTgJA9GsEWcY8+u06N92yFHSY=;
        b=OjaK3PS9johTiV3JkL8T5vDhZzy5OE51fgYkwlt3KxiiOLM/Z6sV82m6rzI330gGCp
         xSKHLuOpEf7XwHqeH2g6NYdcU5b1G/vIYNQN0+7RqQDHkPQ7qOKfZ+joKu4/aqnj5iky
         i/hY7SZBA5AO+TJqThw5epQr3Sxo9EYLwk4Iw3N1CCCEhw1Hwpmlaz5lF45hE+wmcDzP
         YSKPo0VI/8eP77AlK+Ya0+dry7wf3zS6n8u8z0qAThSpWAZH2rp9Re02AFDLF/4kTNuq
         8o114+h4WRe2gKxirmvpDIxEtuqHF8erx7jza0bXHFvneB/jKBujqUNiEi5IUJ8zVqUs
         R5Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779991555; x=1780596355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l30nu3YKfLY2ER0SPLKJG8LovOKpPfL4wcmIkenbb4E=;
        b=HnbVYHUR3d4uXlMkL8YUpzeDlOgCjv5WGhHDlFeSZFlNBHdlBLQemKBwTM9fN/0tr0
         aQfeGyNfBD5TU/ZgXdDHNuy1+IOccgl986H3Iy2TI8Ses79YqGx9D1gaWg7xQri/K4hB
         5+u20mydsh9lcv5wk/ta0pheZulxVDdGquuoq53yuQiR05n4e+G4Q/eOLXKsRVgtYkFT
         GwQ4tZx+nb0d1HdIcz1B79/bldPMNM+7RWlhREBJmGnFifPMoMiq/+UD+zu6E7Ho7cBk
         JY8RunzB0gFiqD76F754n7m2wzgQLPwVseEwKkan1Sx2Xn1QQ7nV/iPc9ATOj+4/Zvvf
         yu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779991555; x=1780596355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l30nu3YKfLY2ER0SPLKJG8LovOKpPfL4wcmIkenbb4E=;
        b=TYRKIqbgKzgVWj+yBonC8M1jSdff6aAiG3U40pj3A55yzNpbqmhMPGWCl45CzoHYmc
         d81XlFv3SNnhohYL7oXkdEJNd7QN2VSDuN1IMmSSEXUPbJ5CWUMTR2An/HFw1HVDZ17j
         ra/82jcOK9EMQ+VOiJHhbiqeKf0CsX8MunKu1dRl2QpljCFMsjZ9d0UrD3JPBSFbvSfs
         gQVqA41gvWJKhpZHlm1099bgMh4iYm1UKDzxffjac4Fx6x6Xuh/itS9LS+LnRPqCmK/N
         k49GRChMHxTBv3JaY16/ZtXup/QCTL1HjiMM8YMm3RT9UiAuqfYwdikA3AW/n0kw1gM/
         5R9Q==
X-Forwarded-Encrypted: i=1; AFNElJ84dIoJSi0KPNTsVXlMUVLSDWkMRXeYLge2ymACMjCmiSYkzz2/ynOtppfycWW1pB2V/amWxpWBLou54Y1C@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Y1Dk0A+vyXimEfoHuoMFe4gYSqwZOi69X72qTksVko6BjP2T
	YW5mcVLD0fl89tI6WlaUiS1VT1pdDkaRW6wYK7zMkoZ/8Kr3bymi312BMUSSA5Sf8e6ytA/ic6y
	QHuwUZ0OunWaIgiMvZbwNlEyA/hvb9Mw=
X-Gm-Gg: Acq92OFQGKXO8aqaUtGFD66wwSAKQhTQluh4jXnmMrwWytftFYiPPkr2E/xxtfyUA+4
	/C0bZWiPNb7AUibJdT4uSa5p5+si718U7lZNZZwcGCdD0vMMfL+CUTlpIlt+3vncaYjZrkbiSRi
	0KnIS9tqBC5fyUHps0NkkuWpFTrDWU4bdlP2KBHN5X/DiT4b4p6it92b/YrAtaR7DknV/iLYA0i
	zK2sXeQyqi119Fu3pzTJJndkZJbkpFi6cbi1NqfA0fiswF40pYe4DZmDRw9qYrCIekrJZzMovWt
	vY53Pd8yZPc61T8lI9VAOagjUwM0x3HJ+7uOoBtPzUsHZuVmscSA
X-Received: by 2002:a05:6402:34c4:b0:676:988e:8eb6 with SMTP id
 4fb4d7f45d1cf-6889cc61b55mr15543560a12.26.1779991554386; Thu, 28 May 2026
 11:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528175854.57626-1-jkoolstra@xs4all.nl>
In-Reply-To: <20260528175854.57626-1-jkoolstra@xs4all.nl>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 28 May 2026 20:05:41 +0200
X-Gm-Features: AVHnY4Ixq7MCxETflSNe_Em_5mMHi44xt5IEh-RxgrZvDID_Dv_0Xe_5VDbUlKY
Message-ID: <CAOQ4uxj0dcbMYha=0hoHdpo27Lzky2PzcwkyRv2rG8t=+=Uixw@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfs: make LAST_XXX private to fs/namei.c
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, NeilBrown <neil@brown.name>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SMB3 SERVER (KSMBD)" <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 7:54=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> The only user of LAST_XXX outside of fs/namei.c is fs/smb/server/vfs.c;
> ksmbd_vfs_path_lookup() calls vfs_path_parent_lookup() and expects a
> LAST_NORM last type (or it will be ENOENT). ksmbd_vfs_rename() also calls
> vfs_path_parent_lookup() but forgets the LAST_NORM check.
>
> It does not really make sense to have vfs_path_parent_lookup() expose
> the last_type because it is only needed to ensure it is LAST_NORM. So
> let's do this check in vfs_path_parent_lookup() instead and keep the
> LAST_XXX internal to fs/namei.c. This changes the ENOENT errno in
> ksmbd_vfs_path_lookup() to EINVAL, which matches better with how this is
> handled by callers of filename_parentat().
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Thanks for following up.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/namei.c            | 20 ++++++++++++++++----
>  fs/smb/server/vfs.c   | 15 +++------------
>  include/linux/namei.h |  7 +------
>  3 files changed, 20 insertions(+), 22 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index c7fac83c9a85..889792761bc2 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -129,6 +129,11 @@
>  static struct kmem_cache *__names_cache __ro_after_init;
>  #define names_cache    runtime_const_ptr(__names_cache)
>
> +/*
> + * Type of the last component on LOOKUP_PARENT
> + */
> +enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
> +
>  void __init filename_init(void)
>  {
>         __names_cache =3D kmem_cache_create_usercopy("names_cache", sizeo=
f(struct filename), 0,
> @@ -3051,15 +3056,22 @@ EXPORT_SYMBOL(kern_path);
>   * @flags: lookup flags
>   * @parent: pointer to struct path to fill
>   * @last: last component
> - * @type: type of the last component
>   * @root: pointer to struct path of the base directory
>   */
>  int vfs_path_parent_lookup(struct filename *filename, unsigned int flags=
,
> -                          struct path *parent, struct qstr *last, int *t=
ype,
> +                          struct path *parent, struct qstr *last,
>                            const struct path *root)
>  {
> -       return  __filename_parentat(AT_FDCWD, filename, flags, parent, la=
st,
> -                                   type, root);
> +       int type;
> +       int err =3D  __filename_parentat(AT_FDCWD, filename, flags, paren=
t, last,
> +                                      &type, root);
> +       if (err)
> +               return err;
> +       if (unlikely(type !=3D LAST_NORM)) {
> +               path_put(parent);
> +               return -EINVAL;
> +       }
> +       return 0;
>  }
>  EXPORT_SYMBOL(vfs_path_parent_lookup);
>
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index d08973b288e5..cd1dbca0cffb 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -19,7 +19,6 @@
>  #include <linux/vmalloc.h>
>  #include <linux/sched/xacct.h>
>  #include <linux/crc32c.h>
> -#include <linux/namei.h>
>  #include <linux/splice.h>
>
>  #include "glob.h"
> @@ -56,7 +55,7 @@ static int ksmbd_vfs_path_lookup(struct ksmbd_share_con=
fig *share_conf,
>  {
>         struct qstr last;
>         const struct path *root_share_path =3D &share_conf->vfs_path;
> -       int err, type;
> +       int err;
>         struct dentry *d;
>
>         if (pathname[0] =3D=3D '\0') {
> @@ -67,17 +66,11 @@ static int ksmbd_vfs_path_lookup(struct ksmbd_share_c=
onfig *share_conf,
>         }
>
>         CLASS(filename_kernel, filename)(pathname);
> -       err =3D vfs_path_parent_lookup(filename, flags,
> -                                    path, &last, &type,
> +       err =3D vfs_path_parent_lookup(filename, flags, path, &last,
>                                      root_share_path);
>         if (err)
>                 return err;
>
> -       if (unlikely(type !=3D LAST_NORM)) {
> -               path_put(path);
> -               return -ENOENT;
> -       }
> -
>         if (for_remove) {
>                 err =3D mnt_want_write(path->mnt);
>                 if (err) {
> @@ -668,7 +661,6 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const s=
truct path *old_path,
>         struct renamedata rd;
>         struct ksmbd_share_config *share_conf =3D work->tcon->share_conf;
>         struct ksmbd_file *parent_fp;
> -       int new_type;
>         int err, lookup_flags =3D LOOKUP_NO_SYMLINKS;
>
>         if (ksmbd_override_fsids(work))
> @@ -678,8 +670,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const s=
truct path *old_path,
>
>  retry:
>         err =3D vfs_path_parent_lookup(to, lookup_flags | LOOKUP_BENEATH,
> -                                    &new_path, &new_last, &new_type,
> -                                    &share_conf->vfs_path);
> +                                    &new_path, &new_last, &share_conf->v=
fs_path);
>         if (err)
>                 goto out1;
>
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 2ad6dd9987b9..3941b9f1dec7 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -13,11 +13,6 @@ enum { MAX_NESTED_LINKS =3D 8 };
>
>  #define MAXSYMLINKS 40
>
> -/*
> - * Type of the last component on LOOKUP_PARENT
> - */
> -enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
> -
>  /* pathwalk mode */
>  #define LOOKUP_FOLLOW          BIT(0)  /* follow links at the end */
>  #define LOOKUP_DIRECTORY       BIT(1)  /* require a directory */
> @@ -67,7 +62,7 @@ static inline void end_removing_path(const struct path =
*path , struct dentry *de
>         end_creating_path(path, dentry);
>  }
>  int vfs_path_parent_lookup(struct filename *filename, unsigned int flags=
,
> -                          struct path *parent, struct qstr *last, int *t=
ype,
> +                          struct path *parent, struct qstr *last,
>                            const struct path *root);
>  int vfs_path_lookup(struct dentry *, struct vfsmount *, const char *,
>                     unsigned int, struct path *);
> --
> 2.54.0
>
