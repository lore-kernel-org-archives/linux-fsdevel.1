Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD632D77E9
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 11:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633918; cv=pass; b=SkHMqkKkcv1OW77hG8p4r3mpgEUfxv+ugB634inwbqwCMzYz+rm+eKaA/cQ7hLfwZU06LHEUYPsInD7AThZAYf3PUoYUEHFamw4XMEKxMcmB9/iF/yMJziMvNqCxPC4yMhbTvSePC9UgipiO9TrLwPdpMAWhI5XiOZjofXrraqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633918; c=relaxed/simple;
	bh=vhvhFwIgAMpFptgGZJxRebsTjnV1/o/3K32OshbRHsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1yd9MFsF+ib+aLX92e3FczjTYPlg0VQ+BkXv+h97ItAJisFGFJ9ywO9CPxVR0DWVjEQ1mjgYxOBdUIkIyPvfHHSojVorMkogQkefDzOwmBIqEfN5fm3Zl2cS+sxNqrr2hHXNEEb95dWXhmkZoPhduionnwnzRZ5Dpzb95q07do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nibpkvK4; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nibpkvK4"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-441209fb77eso1061636f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2026 04:11:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777633915; cv=none;
        d=google.com; s=arc-20240605;
        b=L+bRNbikX9ctzX4K5JrChPQvy9fqk1jg6UxtCBusZWmKdiaOMY1tZ1U96pDpBXd5sg
         MWrdr+887ru+1um0gjgedk0U4b4qwyE8salMhhXc24t6jPw1f3/iWR6OKB32ZaXvI9m0
         +XOWT3tYG11mcYLK0aHZCJ5KqERexSl1tV7LJRFd5zny3YKpQL56QK2+Oxl9jOG13cpv
         xm8Y2unkpJE2f3W1zigPpgZAQ/sh0YYvX3q2uXhlbWiYUhUzuPs3ydKcrW7pqoHTAl8F
         mdvxdww1f4jrsKVIt2A4TdJ4tJ1K55gLs2TQSxr51QdHWeNIc4qFFt2UEeqMAWasyBiL
         t0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6crPqSjGWW4YV5i1pdZqXQA+U4qE5uxj4ZTGjL4Qets=;
        fh=fdzzXcHX2sHHLbOP+q6GRwGVqs/1nbHtT1mfzZNb+YQ=;
        b=cM+td37iWCH9qN2xo9zkAhtOQCKIeosYgYY6lPo+iXqoc5yQqj8Jm/AaRoLB0kFUww
         AOFU4eaSMvz8roWJOpvWHxmac0Qzpd6HOrkne3pHa+PrUJq6QOYYfKveyUS0/Tu55YfZ
         F7Uo4o7i+F2q0lvl0/P9GnSOD3mOS3fEUCBYkuuuX7hp1fcmOZomTDTthMDhWbJRQc4M
         S5D4y3bin7thYa7RJ596hoinpp5WjZJHQQh2lCsiWlUEN3/XIF86g9kmfqCdkikL+0oo
         02Xd+GAA5SHIk2jr+Kc5iSMFcZKkTb7mfT6wBiMb6pctBibwgm6Ree7Vhb6P9s4TAraq
         OPZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777633915; x=1778238715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6crPqSjGWW4YV5i1pdZqXQA+U4qE5uxj4ZTGjL4Qets=;
        b=nibpkvK4/jpvhmkgPaVBuKTboS4AyVwjEpxVo7s7jA/c0AUp4MGQyI3RAO4q9Q6Uwp
         A6jNRRenxp97Fnvrh5Hd+7Pzm5YRwX2EWyBQHHXGYlQDCt3WAoyNtGVGKbvjfg7fi+oJ
         HiRW8V2S83uSnfPrZC2trcUWsiJ8f46EHya/EnJSd7UWAocrgDdzhjIlOTOMMaLevpRp
         Rb39YurgoG+ILi1PYr4lkdxFVz916QRpwr+4vYwDXzyH9ZJpE7xNVJcs18SStKiZrpkQ
         ajB/cfy7BVmOsgCDhceGdco/qlMVqkohlhYcpW7Go/rvrTaEMCfhRDkZxPdwIWFoJZyS
         S/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777633915; x=1778238715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6crPqSjGWW4YV5i1pdZqXQA+U4qE5uxj4ZTGjL4Qets=;
        b=GVhj/91UyaRmQVjdI05FxS5K9+z7k4HtVuxVgT62U/m1ckg89RVkMVPs7N4ykOkYnN
         SaoBf6jHwrucuvwOqn45qz6Pt5Q/EXrPKqIDtmqj79Lru/8iE1DJT7C3c9QEzZ/YPcF9
         0m+kOMQcIoi3sF0vo2h5z+cN0F2RZcX9WP00933UzFnHG7HX5QYoe3nbZsPoCAtVt7Ra
         Hd7PlfNjMVlGi0HQAuuAGDuGc5GIwHtA2US6kEtOzv53zvCJyMZdqLcnBydAi4KRlUVV
         37UqPxCSjH+FRNX3USwbk3jA7FZKn/BA4Xn4Guv2HTmL893G066lszWg546A3f6Dp81o
         Ef5g==
X-Forwarded-Encrypted: i=1; AFNElJ9hCnoTu1sVnOBRdSq5mBbY/zIL3DAN1EK/m9EBoVmQLGscQhR0+CLqbKkTiiljZcK1bMWf/TSDNCMg9XjQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwfYnU9lqUSuPJeiE2xiRsRffbT1r4XqJMsrwjxEgPBRxVl2Asn
	lStVQOB+eGXI1Qa2Q+TCZtpnW73OHXzClxkI34Yvb4hBD/eTxXmW/210Fnr9c5+Fn7j4HNKeKxC
	eDrLIVNjMxwubTnlsDTyCoTamU6Dx1rU=
X-Gm-Gg: AeBDievkBxTHXJk8/MOezoCYxMLZPF8PlNtD9AiEma12O/O4rbu6ItGZyHkT/9guyCx
	sZ8KN871zvE0FkkaRu6m1akjrZRq9QAHKBwmIsJSC+Ft08rTmEjXRFLsNgujoyZqH8MHLVNUdsJ
	ALmf/3kmeXTyG+dzvIb8LMSrQWal4k2WtQeTaS8bGsKjRBJLFf75XS9a5BkQPEgblnaM+xVvUOe
	GpCgh/l1Suio2gXJFpZVk5KPqhBcRYcEuyZVYzHek39Lvcr/QcmMnsHwjEq0IviatFJstRuECUY
	GhP9YIxUOg5oH96pWJI=
X-Received: by 2002:a05:6000:610:b0:43e:aa88:f1a8 with SMTP id
 ffacd0b85a97d-4494e30ec53mr11127907f8f.6.1777633914475; Fri, 01 May 2026
 04:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177747203969.4101397.1905820467457875817.stgit@frogsfrogsfrogs> <177747204072.4101397.7905459296598969749.stgit@frogsfrogsfrogs>
In-Reply-To: <177747204072.4101397.7905459296598969749.stgit@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 1 May 2026 12:11:42 +0100
X-Gm-Features: AVHnY4Ky6Ck3asKKc05QM1ODlxJpM2MRv1XGBjYn9j1My3lKh0RPuXXGB76ug70
Message-ID: <CAJnrk1Z72rCb_MQLhx5HiQRNk7LGuUNVcTeCpLFD-+Xr7_MHNA@mail.gmail.com>
Subject: Re: [PATCH 4/4] fuse: propagate default and file acls on creation
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org, 
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 3:22=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> For local filesystems, propagate the default and file access ACLs to new
> children when creating them, just like the other in-kernel local
> filesystems.
>
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  fs/fuse/fuse_i.h |    4 ++
>  fs/fuse/acl.c    |   62 +++++++++++++++++++++++++++++++++
>  fs/fuse/dir.c    |  101 +++++++++++++++++++++++++++++++++++++++++-------=
------
>  3 files changed, 142 insertions(+), 25 deletions(-)
>
>
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 0bcfb42592895c..0b9c617ee3e5be 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1530,6 +1530,10 @@ struct posix_acl *fuse_get_acl(struct mnt_idmap *i=
dmap,
>                                struct dentry *dentry, int type);
>  int fuse_set_acl(struct mnt_idmap *, struct dentry *dentry,
>                  struct posix_acl *acl, int type);
> +int fuse_acl_create(struct inode *dir, umode_t *mode,
> +                   struct posix_acl **default_acl, struct posix_acl **ac=
l);
> +int fuse_init_acls(struct inode *inode, const struct posix_acl *default_=
acl,
> +                  const struct posix_acl *acl);
>
>  /* readdir.c */
>  int fuse_readdir(struct file *file, struct dir_context *ctx);
> diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
> index bee8a9a734f50a..9619ac84a85886 100644
> --- a/fs/fuse/acl.c
> +++ b/fs/fuse/acl.c
> @@ -10,6 +10,7 @@
>
>  #include <linux/posix_acl.h>
>  #include <linux/posix_acl_xattr.h>
> +#include <linux/fs_struct.h>
>
>  /*
>   * If this fuse server behaves like a local filesystem, we can implement=
 the
> @@ -203,3 +204,64 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct den=
try *dentry,
>
>         return ret;
>  }
> +
> +int fuse_acl_create(struct inode *dir, umode_t *mode,
> +                   struct posix_acl **default_acl, struct posix_acl **ac=
l)
> +{
> +       struct fuse_conn *fc =3D get_fuse_conn(dir);
> +
> +       if (fuse_is_bad(dir))
> +               return -EIO;
> +
> +       if (IS_POSIXACL(dir) && fuse_inode_has_local_acls(dir))
> +               return posix_acl_create(dir, mode, default_acl, acl);
> +
> +       if (!fc->dont_mask)
> +               *mode &=3D ~current_umask();
> +
> +       *default_acl =3D NULL;
> +       *acl =3D NULL;
> +       return 0;
> +}
> +
> +static int __fuse_set_acl(struct inode *inode, const char *name,

Should this function just be named something like
"fuse_set_posix_acl()"? imo that seems clearer

> +                         const struct posix_acl *acl)
> +{
> +       struct fuse_conn *fc =3D get_fuse_conn(inode);
> +       size_t size;
> +       void *value =3D posix_acl_to_xattr(fc->user_ns, acl, &size, GFP_K=
ERNEL);

nit: imo this would be cleaner separated out to its own line after the
variable declarations. Also, I think there's that __free(kfree)
annotation that automatically does the freeing for you after you're
done with it? Maybe that could be useful here

> +       int ret;
> +
> +       if (!value)
> +               return -ENOMEM;
> +
> +       if (size > PAGE_SIZE) {
> +               kfree(value);
> +               return -E2BIG;
> +       }
> +
> +       ret =3D fuse_setxattr(inode, name, value, size, 0, 0);
> +       kfree(value);
> +       return ret;
> +}
> +
> +int fuse_init_acls(struct inode *inode, const struct posix_acl *default_=
acl,
> +                  const struct posix_acl *acl)
> +{
> +       int ret;
> +
> +       if (default_acl) {
> +               ret =3D __fuse_set_acl(inode, XATTR_NAME_POSIX_ACL_DEFAUL=
T,
> +                                    default_acl);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       if (acl) {
> +               ret =3D __fuse_set_acl(inode, XATTR_NAME_POSIX_ACL_ACCESS=
, acl);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 5d9466c7fd464e..c5c97065984557 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -825,26 +825,28 @@ static int fuse_create_open(struct mnt_idmap *idmap=
, struct inode *dir,
>         struct fuse_entry_out outentry;
>         struct fuse_inode *fi;
>         struct fuse_file *ff;
> +       struct posix_acl *default_acl =3D NULL, *acl =3D NULL;

nit: Do these need to be null-initialized as fuse_acl_create() will
already do that? the other call sites (fuse_mknod(), fuse_mkdir())
don't set to null, so might be nicer to have it be consistent

>         int epoch, err;
>         bool trunc =3D flags & O_TRUNC;
>
>         /* Userspace expects S_IFREG in create mode */
>         BUG_ON((mode & S_IFMT) !=3D S_IFREG);
>
> +       err =3D fuse_acl_create(dir, &mode, &default_acl, &acl);
> +       if (err)
> +               return err;
> +
>         epoch =3D atomic_read(&fm->fc->epoch);
>         forget =3D fuse_alloc_forget();
>         err =3D -ENOMEM;
>         if (!forget)
> -               goto out_err;
> +               goto out_acl_release;
>
>         err =3D -ENOMEM;
>         ff =3D fuse_file_alloc(fm, true);
>         if (!ff)
>                 goto out_put_forget_req;
>
> -       if (!fm->fc->dont_mask)
> -               mode &=3D ~current_umask();
> -
>         flags &=3D ~O_NOCTTY;
>         memset(&inarg, 0, sizeof(inarg));
>         memset(&outentry, 0, sizeof(outentry));
> @@ -896,12 +898,17 @@ static int fuse_create_open(struct mnt_idmap *idmap=
, struct inode *dir,
>                 fuse_sync_release(NULL, ff, flags);
>                 fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
>                 err =3D -ENOMEM;
> -               goto out_err;
> +               goto out_acl_release;
>         }
>         kfree(forget);
>         d_instantiate(entry, inode);
>         entry->d_time =3D epoch;
>         fuse_change_entry_timeout(entry, &outentry);
> +
> +       err =3D fuse_init_acls(inode, default_acl, acl);
> +       if (err)
> +               goto out_acl_release;

I think this will leak the allocated fuse_file.  I think there needs
to be a FUSE_RELEASE sent to the server as well so the server can
release state.

> +
>         fuse_dir_changed(dir);
>         err =3D generic_file_open(inode, file);
>         if (!err) {
> @@ -917,13 +924,17 @@ static int fuse_create_open(struct mnt_idmap *idmap=
, struct inode *dir,
>                 else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
>                         invalidate_inode_pages2(inode->i_mapping);
>         }
> +       posix_acl_release(default_acl);
> +       posix_acl_release(acl);
>         return err;
>
>  out_free_ff:
>         fuse_file_free(ff);
>  out_put_forget_req:
>         kfree(forget);
> -out_err:
> +out_acl_release:
> +       posix_acl_release(default_acl);
> +       posix_acl_release(acl);
>         return err;
>  }
>
> @@ -975,7 +986,9 @@ static int fuse_atomic_open(struct inode *dir, struct=
 dentry *entry,
>   */
>  static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct f=
use_mount *fm,
>                                        struct fuse_args *args, struct ino=
de *dir,
> -                                      struct dentry *entry, umode_t mode=
)
> +                                      struct dentry *entry, umode_t mode=
,
> +                                      struct posix_acl *default_acl,
> +                                      struct posix_acl *acl)

imo it would be cleaner to do the acl logic in the callers instead of
threading it through create_new_entry() and create_new_nondir(),
especially since the acl creation logic gets called directly in the
caller function.

>  {
>         struct fuse_entry_out outarg;
>         struct inode *inode;
> @@ -983,14 +996,18 @@ static struct dentry *create_new_entry(struct mnt_i=
dmap *idmap, struct fuse_moun
>         struct fuse_forget_link *forget;
>         int epoch, err;
>
> -       if (fuse_is_bad(dir))
> -               return ERR_PTR(-EIO);
> +       if (fuse_is_bad(dir)) {
> +               err =3D -EIO;
> +               goto out_acl_release;
> +       }
>         epoch =3D atomic_read(&fm->fc->epoch);
>
>         forget =3D fuse_alloc_forget();
> -       if (!forget)
> -               return ERR_PTR(-ENOMEM);
> +       if (!forget) {
> +               err =3D -ENOMEM;
> +               goto out_acl_release;
> +       }
>
>         memset(&outarg, 0, sizeof(outarg));
>         args->nodeid =3D get_node_id(dir);
> @@ -1020,14 +1037,17 @@ static struct dentry *create_new_entry(struct mnt=
_idmap *idmap, struct fuse_moun
>                           &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0);
>         if (!inode) {
>                 fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
> -               return ERR_PTR(-ENOMEM);
> +               err =3D -ENOMEM;
> +               goto out_acl_release;
>         }
>         kfree(forget);
>
>         d_drop(entry);
>         d =3D d_splice_alias(inode, entry);
> -       if (IS_ERR(d))
> -               return d;
> +       if (IS_ERR(d)) {
> +               err =3D PTR_ERR(d);
> +               goto out_acl_release;
> +       }
>
>         if (d) {
>                 d->d_time =3D epoch;
> @@ -1036,19 +1056,31 @@ static struct dentry *create_new_entry(struct mnt=
_idmap *idmap, struct fuse_moun
>                 entry->d_time =3D epoch;
>                 fuse_change_entry_timeout(entry, &outarg);
>         }
> +
> +       err =3D fuse_init_acls(inode, default_acl, acl);
> +       if (err)
> +               goto out_acl_release;

Do we probably need a dput() here? afaict from the logic in
d_splice_alias_ops() [1], it looks like there's a refcount obtained if
the spliced dentry was non-null

[1] https://elixir.bootlin.com/linux/v7.0/source/fs/dcache.c#L3097

>         fuse_dir_changed(dir);
> +
> +       posix_acl_release(default_acl);
> +       posix_acl_release(acl);
>         return d;
>
>   out_put_forget_req:
>         if (err =3D=3D -EEXIST)
>                 fuse_invalidate_entry(entry);
>         kfree(forget);
> + out_acl_release:
> +       posix_acl_release(default_acl);
> +       posix_acl_release(acl);
>         return ERR_PTR(err);
>  }
>
>  static int create_new_nondir(struct mnt_idmap *idmap, struct fuse_mount =
*fm,
>                              struct fuse_args *args, struct inode *dir,
> -                            struct dentry *entry, umode_t mode)
> +                            struct dentry *entry, umode_t mode,
> +                            struct posix_acl *default_acl,
> +                            struct posix_acl *acl)
>  {
>         /*
>          * Note that when creating anything other than a directory we
> @@ -1059,7 +1091,8 @@ static int create_new_nondir(struct mnt_idmap *idma=
p, struct fuse_mount *fm,
>          */
>         WARN_ON_ONCE(S_ISDIR(mode));
>
> -       return PTR_ERR(create_new_entry(idmap, fm, args, dir, entry, mode=
));
> +       return PTR_ERR(create_new_entry(idmap, fm, args, dir, entry, mode=
,
> +                                       default_acl, acl));
>  }
>
>  static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
> @@ -1067,10 +1100,13 @@ static int fuse_mknod(struct mnt_idmap *idmap, st=
ruct inode *dir,
>  {
>         struct fuse_mknod_in inarg;
>         struct fuse_mount *fm =3D get_fuse_mount(dir);
> +       struct posix_acl *default_acl, *acl;
>         FUSE_ARGS(args);
> +       int err;
>
> -       if (!fm->fc->dont_mask)
> -               mode &=3D ~current_umask();
> +       err =3D fuse_acl_create(dir, &mode, &default_acl, &acl);
> +       if (err)
> +               return err;
>
>         memset(&inarg, 0, sizeof(inarg));
>         inarg.mode =3D mode;
> @@ -1082,7 +1118,8 @@ static int fuse_mknod(struct mnt_idmap *idmap, stru=
ct inode *dir,
>         args.in_args[0].value =3D &inarg;
>         args.in_args[1].size =3D entry->d_name.len + 1;
>         args.in_args[1].value =3D entry->d_name.name;
> -       return create_new_nondir(idmap, fm, &args, dir, entry, mode);
> +       return create_new_nondir(idmap, fm, &args, dir, entry, mode,
> +                                default_acl, acl);
>  }
>
>  static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
> @@ -1114,13 +1151,17 @@ static struct dentry *fuse_mkdir(struct mnt_idmap=
 *idmap, struct inode *dir,
>  {
>         struct fuse_mkdir_in inarg;
>         struct fuse_mount *fm =3D get_fuse_mount(dir);
> +       struct posix_acl *default_acl, *acl;
>         FUSE_ARGS(args);
> +       int err;
>
> -       if (!fm->fc->dont_mask)
> -               mode &=3D ~current_umask();
> +       mode |=3D S_IFDIR;        /* vfs doesn't set S_IFDIR for us */
> +       err =3D fuse_acl_create(dir, &mode, &default_acl, &acl);
> +       if (err)
> +               return ERR_PTR(err);
>
>         memset(&inarg, 0, sizeof(inarg));
> -       inarg.mode =3D mode;
> +       inarg.mode =3D mode & ~S_IFDIR;
>         inarg.umask =3D current_umask();
>         args.opcode =3D FUSE_MKDIR;
>         args.in_numargs =3D 2;
> @@ -1128,7 +1169,8 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *=
idmap, struct inode *dir,
>         args.in_args[0].value =3D &inarg;
>         args.in_args[1].size =3D entry->d_name.len + 1;
>         args.in_args[1].value =3D entry->d_name.name;
> -       return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
> +       return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR,
> +                               default_acl, acl);
>  }
>
>  static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
> @@ -1136,7 +1178,14 @@ static int fuse_symlink(struct mnt_idmap *idmap, s=
truct inode *dir,
>  {
>         struct fuse_mount *fm =3D get_fuse_mount(dir);
>         unsigned len =3D strlen(link) + 1;
> +       struct posix_acl *default_acl, *acl;
> +       umode_t mode =3D S_IFLNK | 0777;
>         FUSE_ARGS(args);
> +       int err;
> +
> +       err =3D fuse_acl_create(dir, &mode, &default_acl, &acl);
> +       if (err)
> +               return err;

I think we could skip the acl stuff for symlinks, it looks like
posix_acl_create() is a no-op for S_IFLNK mode [2]

[2] https://elixir.bootlin.com/linux/v7.0.1/source/fs/posix_acl.c#L643

Thanks,
Joanne

>
>         args.opcode =3D FUSE_SYMLINK;
>         args.in_numargs =3D 3;
> @@ -1145,7 +1194,8 @@ static int fuse_symlink(struct mnt_idmap *idmap, st=
ruct inode *dir,
>         args.in_args[1].value =3D entry->d_name.name;
>         args.in_args[2].size =3D len;
>         args.in_args[2].value =3D link;
> -       return create_new_nondir(idmap, fm, &args, dir, entry, S_IFLNK);
> +       return create_new_nondir(idmap, fm, &args, dir, entry, S_IFLNK,
> +                                default_acl, acl);
>  }
>
>  void fuse_flush_time_update(struct inode *inode)
> @@ -1345,7 +1395,8 @@ static int fuse_link(struct dentry *entry, struct i=
node *newdir,
>         args.in_args[0].value =3D &inarg;
>         args.in_args[1].size =3D newent->d_name.len + 1;
>         args.in_args[1].value =3D newent->d_name.name;
> -       err =3D create_new_nondir(&invalid_mnt_idmap, fm, &args, newdir, =
newent, inode->i_mode);
> +       err =3D create_new_nondir(&invalid_mnt_idmap, fm, &args, newdir, =
newent,
> +                               inode->i_mode, NULL, NULL);
>         if (!err)
>                 fuse_update_ctime_in_cache(inode);
>         else if (err =3D=3D -EINTR)
>
