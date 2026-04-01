Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C6A3AEF36
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775032169; cv=pass; b=Uc+IpaADSRXyvTKUtYXJs5g0lvZZXBR5OK5+wup1B22WbtRIw8xZuTA+Yz7BFtqhtGEtiNFtFikEqzENt+/0Jqq4Ed52G4FqLMX5NluGzs+2h6ov+t/PHLmIHr85IS7O2LPkBYM5J8f3NihNKrRMS0zo6/DM9vf5jqp1qcoIfIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775032169; c=relaxed/simple;
	bh=sq8T8wpZu85SLcwsYc/bOEv+PexNoL6zfJtAoxzKJZo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odZ+j5DIJlqdB6diXzHr5TdDpGM5BcD4AsaiwBIW8/6ixu/w781TR/z9vGtO+LiGHVdD5UNCD2GqzLBlFPgOTkGiPr9KDjqdlpwFAEfoPVaQdj8AbQKsJlhFLTYOd09SBL6i+5JWfAH2RAFolyCNmyKRRI8dsz1IgxxZ6EVQomg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awgHXDs4; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awgHXDs4"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66a33f61d80so10959289a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 01:29:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775032166; cv=none;
        d=google.com; s=arc-20240605;
        b=X3kzEhDyoizLPj17DV4j5wur8WkqSuXEf6kxPY0HkRgACUpbXsJJW3hkEil50s1ejy
         PuQDo5DyoEsDKRxitEDXWkrdrCU7omHy5MV5QrAqiOn4Fdjaz9l0ipqnSl9/XbS3PB6t
         b/B6DbY5M0pndt5ldCkw7eL/fdTMlxZ2+wynq0Yrs5l6V4oQXuyMNXIwJim73ZT10Wdr
         4dvlwaRTbC5xiN0d7JyJxJhBY6Iu9WIh1zT8m8Ri14pWgPoD2KS10b8gyxyS/eVpkvBA
         SiSs3VDG7Mc2gA/KEvtI+X/7wo7l9b6gAQmHskObvanihX0PWleZQ8vZUgtT9zMGBhFY
         Hg7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J4Y5VX6k0Il8+xtqOdQDKv55jjj8VEioN5/aPjeiBqg=;
        fh=x93xCXSPpbL9Hbe/OM8+Z6ZtrMtSL1ZoHHc5CZ5Fz68=;
        b=NEkgTfZeLWIMrkyeJpERo33kPa6d3tTDjHqScQ0dEc3S4uCzifjiriq5ooQ/bwTmmR
         xckEe0s9d/VdjFVsa5obOz7lp2QcbGwWehA1YLV5pQu/BeoKchA66GGutsrUiXjmTeuw
         YW8IIRXuryOb1MJIrqf8iCMothbfPodNdoF3uuZ/zjMLdcJJniRLtKvLujfMd7ticDHC
         XnzZFP08McChEqdE+nvrmTkOSfnFrGvf87ax+jipMfXVCQBdwdmDwd7qLhUyAMTRwVCb
         RAxgHYf7ps/FHt+Vimu/gKYyEgVYbR6VU9eXVnbqZS4jax1v9zO1imXaeBcUntmhfNLI
         cbDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775032166; x=1775636966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J4Y5VX6k0Il8+xtqOdQDKv55jjj8VEioN5/aPjeiBqg=;
        b=awgHXDs4zoIKpFietFWYOO00br7lC4ShFrxSD9aVqEu3vHiefVZ60YRIZsQRfZaGKx
         HK+6ibaZZhar4yVAAHYkRpJgfw92WYCV+Nlt2dWem96ph+QtFA7t1JWPw0FPfhi7XirK
         /v9ihsfZ3fxOCqzAuELMQb+wqW112VKj/1Qn4eJiN4t10lSIeMcmQjQnpaZeQOpynWkD
         x1PYfDLFz2eagurwQK5dxHPzKafl2Cb+BKdHrxGEmfGsI+mOcydPrVPm9UauSN/64ZgQ
         TeIWt7oEVGBTpbVfLU7eikzjf7nLEDGWcehUQ2NWU6uxcRgKzAjKvnq1Qx88olZRR7NV
         xigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775032166; x=1775636966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J4Y5VX6k0Il8+xtqOdQDKv55jjj8VEioN5/aPjeiBqg=;
        b=sLc4nJjvbHr50tyZAG98jI5/tDg1DW4K40jjG+jSbllZJGhOY5PScj2ryZT63iDG6g
         m2lp95X6s9eAb7M3d8h4fj0E54RrolVl2hfL1OEK1NmnnMUQ7zg2nTmrzuVlREi7L+5M
         F+Sv0CpZxLpup8K54uukHRETJiARG35SMfks7D8NXT1u974lxVYzFEjl0Xt5kX+N9U4S
         33Hg5yXk34SeSQda7pCEhcXcCccSDOlXx1HQalhHkioAhQOorwOljYFXRVItQMZm5URP
         AEMJCVfihK6la/j04J9kvplW2Rq5m2m1VzKMYrCo/81c4tOTf/bKa39Wpu4uFFNSBpaW
         +ghw==
X-Forwarded-Encrypted: i=1; AJvYcCUwAVLBEsy2JWyyjkWv/aOlUoXxCv8QziWGLZJ1N7M2R5wZqOTw0qTJlpwGRDVAWZIKt2l13GXxlnoMhyzk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1GrQh5aopNvbTvUZsAJpajZSNnvvkGpAi2zhwiX7w49OaaHnV
	fp+0ohFC6h9I9U5Hxk7RSaBVNmO3ukzrIfU4ok2XmgvwSjxIkssMPQvj8wL061NzopltCKzoW4l
	8+zqOQHrqwead/ZcaCKGsI5AJfb2DzUA=
X-Gm-Gg: ATEYQzxIlyBgC9s+S7hi09i9dBSTfVsPlH38R1lMUeLjTMAT/laprWRmZjKargzZDMx
	s93mmUJcMRRESYdh3I5Wt+UjCt1OIDBCA9OjfF12DHSssXFZN+vR7IxRE/Fcd94r56N8Y1paK8n
	TKpJLwVpBz/52++yZijMuNPN/mifbl2Z1jUyo1u3AqZ7+qAgryVD4314Z9JRVFZQHbS2opMDOGo
	1kKq9BAqsTcLJiWRQgTlBkQhQ3lJmZ7ERUoQTdAV10MvAy/vnCK/1SXzlAiFMbHEGJxy7iluXJJ
	GKALVgxWpQhkMWgBw5recJIlUQSrZx9pXeJK4av3iw==
X-Received: by 2002:a05:6402:44d9:b0:66b:b6e2:66dc with SMTP id
 4fb4d7f45d1cf-66db01a8f95mr1297097a12.11.1775032166079; Wed, 01 Apr 2026
 01:29:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331173726.3517440-1-jkoolstra@xs4all.nl>
In-Reply-To: <20260331173726.3517440-1-jkoolstra@xs4all.nl>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 1 Apr 2026 10:29:15 +0200
X-Gm-Features: AQROBzADogCQmeqgKMpdMHDC_UV8fd3Ii0QKyMybehc3EfUorrZtTdooVdjitd0
Message-ID: <CAOQ4uxj_sH3Owh2_UEHXGY81B3yoZzLF0DWZm9OPCPOiLrzL9A@mail.gmail.com>
Subject: Re: [PATCH] vfs: replace ints with enum component_type for LAST_XXX
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: gregkh@linuxfoundation.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Jeff Layton <jlayton@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 31, 2026 at 7:37=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> Several functions in namei.c take an "int *type" parameter, such as
> filename_parentat(). To know what values this can take you have to find
> the anonymous struct that defines the LAST_XXX values. I would argue
> that the readability of the code is improved by making this an explicit
> type. Also, when we have this "enum component_type" is does not really
> make sense anymore to talk about LAST_XXX, but we should just use XXX,
> as there is nothing specific about the component type showing up at the
> end of a path.
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c            | 75 ++++++++++++++++++++++---------------------
>  include/linux/namei.h |  4 +--
>  2 files changed, 41 insertions(+), 38 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 9e5500dad14f..1eb9db055292 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -721,15 +721,15 @@ EXPORT_SYMBOL(path_put);
>
>  #define EMBEDDED_LEVELS 2
>  struct nameidata {
> -       struct path     path;
> -       struct qstr     last;
> -       struct path     root;
> -       struct inode    *inode; /* path.dentry.d_inode */
> -       unsigned int    flags, state;
> -       unsigned        seq, next_seq, m_seq, r_seq;
> -       int             last_type;
> -       unsigned        depth;
> -       int             total_link_count;
> +       struct path             path;
> +       struct qstr             last;
> +       struct path             root;
> +       struct inode            *inode; /* path.dentry.d_inode */
> +       unsigned int            flags, state;
> +       unsigned                seq, next_seq, m_seq, r_seq;
> +       enum component_type     last_type;
> +       unsigned                depth;
> +       int                     total_link_count;
>         struct saved {
>                 struct path link;
>                 struct delayed_call done;
> @@ -2221,9 +2221,9 @@ static struct dentry *follow_dotdot(struct nameidat=
a *nd)
>         return dget(nd->path.dentry);
>  }
>
> -static const char *handle_dots(struct nameidata *nd, int type)
> +static const char *handle_dots(struct nameidata *nd, enum component_type=
 type)
>  {
> -       if (type =3D=3D LAST_DOTDOT) {
> +       if (type =3D=3D DOTDOT) {
>                 const char *error =3D NULL;
>                 struct dentry *parent;
>
> @@ -2267,7 +2267,7 @@ static __always_inline const char *walk_component(s=
truct nameidata *nd, int flag
>          * to be able to know about the current root directory and
>          * parent relationships.
>          */
> -       if (unlikely(nd->last_type !=3D LAST_NORM)) {
> +       if (unlikely(nd->last_type !=3D NORMAL)) {
>                 if (unlikely(nd->depth) && !(flags & WALK_MORE))
>                         put_link(nd);
>                 return handle_dots(nd, nd->last_type);
> @@ -2577,7 +2577,7 @@ static int link_path_walk(const char *name, struct =
nameidata *nd)
>         int depth =3D 0; // depth <=3D nd->depth
>         int err;
>
> -       nd->last_type =3D LAST_ROOT;
> +       nd->last_type =3D ROOT;
>         nd->flags |=3D LOOKUP_PARENT;
>         if (IS_ERR(name))
>                 return PTR_ERR(name);
> @@ -2607,16 +2607,16 @@ static int link_path_walk(const char *name, struc=
t nameidata *nd)
>
>                 switch(lastword) {
>                 case LAST_WORD_IS_DOTDOT:
> -                       nd->last_type =3D LAST_DOTDOT;
> +                       nd->last_type =3D DOTDOT;
>                         nd->state |=3D ND_JUMPED;
>                         break;
>
>                 case LAST_WORD_IS_DOT:
> -                       nd->last_type =3D LAST_DOT;
> +                       nd->last_type =3D DOT;
>                         break;
>
>                 default:
> -                       nd->last_type =3D LAST_NORM;
> +                       nd->last_type =3D NORMAL;
>                         nd->state &=3D ~ND_JUMPED;
>
>                         struct dentry *parent =3D nd->path.dentry;
> @@ -2780,7 +2780,7 @@ static const char *path_init(struct nameidata *nd, =
unsigned flags)
>
>  static inline const char *lookup_last(struct nameidata *nd)
>  {
> -       if (nd->last_type =3D=3D LAST_NORM && nd->last.name[nd->last.len]=
)
> +       if (nd->last_type =3D=3D NORMAL && nd->last.name[nd->last.len])
>                 nd->flags |=3D LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
>
>         return walk_component(nd, WALK_TRAILING);
> @@ -2869,7 +2869,7 @@ static int path_parentat(struct nameidata *nd, unsi=
gned flags,
>  /* Note: this does not consume "name" */
>  static int __filename_parentat(int dfd, struct filename *name,
>                                unsigned int flags, struct path *parent,
> -                              struct qstr *last, int *type,
> +                              struct qstr *last, enum component_type *ty=
pe,
>                                const struct path *root)
>  {
>         int retval;
> @@ -2894,7 +2894,7 @@ static int __filename_parentat(int dfd, struct file=
name *name,
>
>  static int filename_parentat(int dfd, struct filename *name,
>                              unsigned int flags, struct path *parent,
> -                            struct qstr *last, int *type)
> +                            struct qstr *last, enum component_type *type=
)
>  {
>         return __filename_parentat(dfd, name, flags, parent, last, type, =
NULL);
>  }
> @@ -2963,12 +2963,13 @@ static struct dentry *__start_removing_path(int d=
fd, struct filename *name,
>         struct path parent_path __free(path_put) =3D {};
>         struct dentry *d;
>         struct qstr last;
> -       int type, error;
> +       enum component_type type;
> +       int error;
>
>         error =3D filename_parentat(dfd, name, 0, &parent_path, &last, &t=
ype);
>         if (error)
>                 return ERR_PTR(error);
> -       if (unlikely(type !=3D LAST_NORM))
> +       if (unlikely(type !=3D NORMAL))
>                 return ERR_PTR(-EINVAL);
>         /* don't fail immediately if it's r/o, at least try to report oth=
er errors */
>         error =3D mnt_want_write(parent_path.mnt);
> @@ -3009,12 +3010,13 @@ struct dentry *kern_path_parent(const char *name,=
 struct path *path)
>         CLASS(filename_kernel, filename)(name);
>         struct dentry *d;
>         struct qstr last;
> -       int type, error;
> +        enum component_type type;
> +       int error;
>
>         error =3D filename_parentat(AT_FDCWD, filename, 0, &parent_path, =
&last, &type);
>         if (error)
>                 return ERR_PTR(error);
> -       if (unlikely(type !=3D LAST_NORM))
> +       if (unlikely(type !=3D NORMAL))
>                 return ERR_PTR(-EINVAL);
>
>         d =3D lookup_noperm_unlocked(&last, parent_path.dentry);
> @@ -3057,7 +3059,7 @@ EXPORT_SYMBOL(kern_path);
>   * @root: pointer to struct path of the base directory
>   */
>  int vfs_path_parent_lookup(struct filename *filename, unsigned int flags=
,
> -                          struct path *parent, struct qstr *last, int *t=
ype,
> +                          struct path *parent, struct qstr *last, enum c=
omponent_type *type,
>                            const struct path *root)
>  {
>         return  __filename_parentat(AT_FDCWD, filename, flags, parent, la=
st,
> @@ -4550,7 +4552,7 @@ static const char *open_last_lookups(struct nameida=
ta *nd,
>
>         nd->flags |=3D op->intent;
>
> -       if (nd->last_type !=3D LAST_NORM) {
> +       if (nd->last_type !=3D NORMAL) {
>                 if (nd->depth)
>                         put_link(nd);
>                 return handle_dots(nd, nd->last_type);
> @@ -4903,7 +4905,7 @@ static struct dentry *filename_create(int dfd, stru=
ct filename *name,
>         bool want_dir =3D lookup_flags & LOOKUP_DIRECTORY;
>         unsigned int reval_flag =3D lookup_flags & LOOKUP_REVAL;
>         unsigned int create_flags =3D LOOKUP_CREATE | LOOKUP_EXCL;
> -       int type;
> +       enum component_type type;
>         int error;
>
>         error =3D filename_parentat(dfd, name, reval_flag, path, &last, &=
type);
> @@ -4914,7 +4916,7 @@ static struct dentry *filename_create(int dfd, stru=
ct filename *name,
>          * Yucky last component or no last component at all?
>          * (foo/., foo/.., /////)
>          */
> -       if (unlikely(type !=3D LAST_NORM))
> +       if (unlikely(type !=3D NORMAL))
>                 goto out;
>
>         /* don't fail immediately if it's r/o, at least try to report oth=
er errors */
> @@ -5365,7 +5367,7 @@ int filename_rmdir(int dfd, struct filename *name)
>         struct dentry *dentry;
>         struct path path;
>         struct qstr last;
> -       int type;
> +       enum component_type type;
>         unsigned int lookup_flags =3D 0;
>         struct delegated_inode delegated_inode =3D { };
>  retry:
> @@ -5374,15 +5376,16 @@ int filename_rmdir(int dfd, struct filename *name=
)
>                 return error;
>
>         switch (type) {
> -       case LAST_DOTDOT:
> +       case DOTDOT:
>                 error =3D -ENOTEMPTY;
>                 goto exit2;
> -       case LAST_DOT:
> +       case DOT:
>                 error =3D -EINVAL;
>                 goto exit2;
> -       case LAST_ROOT:
> +       case ROOT:
>                 error =3D -EBUSY;
>                 goto exit2;
> +       case NORMAL: ; // OK
>         }
>
>         error =3D mnt_want_write(path.mnt);
> @@ -5507,7 +5510,7 @@ int filename_unlinkat(int dfd, struct filename *nam=
e)
>         struct dentry *dentry;
>         struct path path;
>         struct qstr last;
> -       int type;
> +       enum component_type type;
>         struct inode *inode;
>         struct delegated_inode delegated_inode =3D { };
>         unsigned int lookup_flags =3D 0;
> @@ -5517,7 +5520,7 @@ int filename_unlinkat(int dfd, struct filename *nam=
e)
>                 return error;
>
>         error =3D -EISDIR;
> -       if (type !=3D LAST_NORM)
> +       if (type !=3D NORMAL)
>                 goto exit_path_put;
>
>         error =3D mnt_want_write(path.mnt);
> @@ -6074,7 +6077,7 @@ int filename_renameat2(int olddfd, struct filename =
*from,
>         struct renamedata rd;
>         struct path old_path, new_path;
>         struct qstr old_last, new_last;
> -       int old_type, new_type;
> +       enum component_type old_type, new_type;
>         struct delegated_inode delegated_inode =3D { };
>         unsigned int lookup_flags =3D 0;
>         bool should_retry =3D false;
> @@ -6103,12 +6106,12 @@ int filename_renameat2(int olddfd, struct filenam=
e *from,
>                 goto exit2;
>
>         error =3D -EBUSY;
> -       if (old_type !=3D LAST_NORM)
> +       if (old_type !=3D NORMAL)
>                 goto exit2;
>
>         if (flags & RENAME_NOREPLACE)
>                 error =3D -EEXIST;
> -       if (new_type !=3D LAST_NORM)
> +       if (new_type !=3D NORMAL)
>                 goto exit2;
>
>         error =3D mnt_want_write(old_path.mnt);
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 58600cf234bc..e79ff97063e9 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -16,7 +16,7 @@ enum { MAX_NESTED_LINKS =3D 8 };
>  /*
>   * Type of the last component on LOOKUP_PARENT
>   */
> -enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
> +enum component_type {NORMAL, ROOT, DOT, DOTDOT};
>

Nah, I don't think it is a good idea to poluate the global namespace
with constant as generic as NORMAL, ROOT

At the very least this needs a namespace prefix such as
NDT_ (nameidata type)

But then I don't think it is worth the churn to rename LAST_ to NDT_
so I would drop the constants name change altogether.

Thanks,
Amir.
