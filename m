Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F8837FF51
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776680969; cv=pass; b=Jbw59LNqRBPhOw0QT6h56SY0oLS41bSGIp9IJW3I2i3AvfpeMuk5d05bNGUrbWQDYfF+2YzD7Snfr70eCD9ux7N1bwL944Hgh/8kmOb8IKl9lX1iYMBo5aXwrY5T5bcbREpBU0HJaF1/mUPR7/YdJUqEh3zCdrj4GESc+VI9x6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776680969; c=relaxed/simple;
	bh=b1r7vji9w89PWRc9XU2AkOZofoPvtW87U/mgamZN7Z8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtAzkHWEnag0HKukgo3DsOq1zDE6ypH9Yd6pS+/AE4JGS2PJ5ufr8lC3VLW0lSnfVQDEy4ASV2zdVlmKQj1Htxg4WR7p6hxgKpcZJQRatTWwv8jVgeN4YHqR6ZHbvcqdF5IBjd9eQcuA1WvtgHOU6woKHEaj/0XgqBotJXAsNUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dW1b51ak; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dW1b51ak"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9358dd7f79so508245466b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 03:29:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776680965; cv=none;
        d=google.com; s=arc-20240605;
        b=DfLkumSRwKpIv77bX0QxQXVaExL202ZREQQXEYWlv6Lh+hDMdSzR6a8JUwRh3Ms5gY
         vXx9asva16nY0t06GUOgvnd8g8tUIFptl2ySB40O104gXDDRnJkJKSI7xgZItYzVZ5ro
         s5c0sPG9G0KLP1lPS07DB+rl1UVdJlW6r9TlAM9LRxJU6MxVbA+IRBl8Iz6RTUalueRs
         n3uUkOQZi1+joG9IUu0oiaK0LJKICMJL+27PCiTPepw0zB+IhmUSWiE6D23j5Q1yEGKy
         jVD4AgCMgp4MQvmQ+QZJkjQ8wA38iGJM4BJQj+5kdEtzJR/hrK42D+olLu4sgsBkP8zx
         wqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w63l8zrtQNZhZJyil++3JdFvDsRqKJ7vTTWckv8Wa/g=;
        fh=3ImQDEJZHIGXCtU6mPi0qzubG5iHMFMJ3+LpoXnB+pQ=;
        b=QEnpQ1EXEgu9wovcssLMMpQKySqZDBRwAUc427Nv1FiOWqf4TxWtrVKOLBiWLsMzG2
         6o7rvZ4HKuRgCzgK9ws+Uo9sTfVaqhUEpCpH5ElS834ylGchmrhukKiTykpF/iQT7zZf
         ZsXFWWwvqdLIOQxlTU2Bzi7dh4jn2MQKD/VGmYA9tggf/YTNFhPOVYlxQqjpOn86p2Jh
         IM89GjGuRZj9TxNekN5EiQNzBbO7nolnxIfaVWDPFrjEuFned34fwfiUjNVlgoOnCb1B
         dA2o+n+RT/akjbbU5AWBkwekiCyYPxptm3mX+awMDuDQGln/SdRmI4dkpcE36uv4BPmQ
         5qdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776680965; x=1777285765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w63l8zrtQNZhZJyil++3JdFvDsRqKJ7vTTWckv8Wa/g=;
        b=dW1b51akAJ8lGCQr06LM3d7UsI1+mRdo5pQulQyadmKSAA6O3vhxDT+xrSCOUjvr7c
         XCrdDB0U1gArrQkts6yjXG5D7Yz3VizSYQ6bzfGhzB1PofmblbThC/H50KvwxwmWaKE3
         /kyrJc05izHiPsg93ak8oNuf9Wwnk33Jtkvwq/aqCtLX5hQqE8dZGIHOeO9lKlHh2XL6
         EcYT4PTrJclQjZ1ojxtbNXHSWNPmx5gyJsyGValdFG0cpV+YE7sMJ99kUpFyFnTLzIUU
         ncx3Xti8DAoRawd9FgM+vKyQEptPWYnJL5IWOZDgm9Iozu4rrbKIV1Ya7wqX280/tO6K
         Cqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776680965; x=1777285765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w63l8zrtQNZhZJyil++3JdFvDsRqKJ7vTTWckv8Wa/g=;
        b=ilSKr2qaPMXhHSIx6HH9aPnOPtbdY+oRdTOJ2gRh+TyaxYtNc3GkZh4cNBpkFNAyCx
         uJTcW8UNJfXzExbgvDnNVQ/a3s7Lc7akoJE5BkT2mAYPHabV6WSQCDSibUNbVVS96J1/
         MgVtLPr4Sb7v45lELUm5t94WQ2FWDGzch6uqK037t+LcNf6GHS37DBS2S34W276JwP+N
         RQUn6qp9qAUFHqv8Aj4C7egrRkRb3HC79huihLR/uC1r+0FQJ9pDTzNShhXT4L6o2HUy
         YF5KXRqbAly36jpch/IT4B8fkEEMcGwtNjtAVx54aFiU3aaKcT11gEHoUh8vIjn1ra64
         UqXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/kERMe5cMQmvyKYxvDMdqrJ2UoVzbxwe868rkIu4J2fqN80cftYBQI2I66TSqsLf8Z7IMyo/zZMTLprHtT@vger.kernel.org
X-Gm-Message-State: AOJu0YzxyhjfKr5HkmUjuxmg/86SmnF/aO2ZkZGNpNqkeMV1a7s9cCln
	GF0e8uxJDOZVqlgugtippctJ6WL5yAkE7wPyBytUIWJ5rhNtaTEZ7HFiw4JXEdMpKZ3Yg8F1te8
	ymWgVySnOo5W3XntDr65CN1BSvFXApLE=
X-Gm-Gg: AeBDieu/A2/CqlDqtNL2Me3k9rESNGPZa6A618W89L7rzzLLTOmnToSv5WWhzILz1B4
	DyILS37B4d/8Qk2risRrlhGq0V1Drr6nZ5+NGKX32oOOHqmnK/IJUbX9l0GncmSopo9duoKoVsj
	ZeQeW/AxUS/r1QMPsK8Dad2uoNobidCL/Q5LUInLkhNJA6YV+vs/nfW98epwzMfvl7+KL/5e03G
	e27lf9qNrou3S4tFhgq9RrY8fFbHrcKIH9KupcfWkopwBzRph0J1M+LNwA4I8pZpv/B6Wn+Ke+z
	7FOY05Qo9hOnNKzrDr7h8uya2uQv6Da6jYIdcRCqcmI7Ht1wCtca
X-Received: by 2002:a17:907:e84b:b0:ba3:8a04:7688 with SMTP id
 a640c23a62f3a-ba41b5d28acmr626277266b.36.1776680965266; Mon, 20 Apr 2026
 03:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419161620.564854-1-jkoolstra@xs4all.nl>
In-Reply-To: <20260419161620.564854-1-jkoolstra@xs4all.nl>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 Apr 2026 12:29:12 +0200
X-Gm-Features: AQROBzC40fUp9j6jgAwRhk99puzFCqWY_c5zsC-v2pmMmssjl54h3VngfWz6pUk
Message-ID: <CAOQ4uxhh1kGnuY7sKTqti12tjFD4t1vCJ0qQrGngU2+0idXtpQ@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: replace ints with enum component_type for LAST_XXX
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Namjae Jeon <linkinjeon@kernel.org>, Steve French <smfrench@gmail.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, NeilBrown <neil@brown.name>, 
	Jeff Layton <jlayton@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SMB3 SERVER (KSMBD)" <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 19, 2026 at 6:16=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> Several functions in namei.c take an "int *type" parameter, such as
> filename_parentat(). To know what values this can take you have to find
> the anonymous struct that defines the LAST_XXX values. I would argue
> that the readability of the code is improved by making this an explicit
> type.
>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> ---
>
> v2: move back to LAST_XXX and change int to component_type in
> fs/smb/server/vfs.c.
>
> ---
>  fs/namei.c            | 41 ++++++++++++++++++++++-------------------
>  fs/smb/server/vfs.c   |  5 +++--
>  include/linux/namei.h |  4 ++--
>  3 files changed, 27 insertions(+), 23 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 9e5500dad14f..a880454a6415 100644
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

Please update documentation entry for last_type in
Documentation/filesystems/path-lookup.rst

> -       unsigned        depth;
> -       int             total_link_count;
> +       struct path             path;
> +       struct qstr             last;
> +       struct path             root;
> +       struct inode            *inode; /* path.dentry.d_inode */
> +       unsigned int            flags, state;
> +       unsigned                seq, next_seq, m_seq, r_seq;
> +       enum component_type     last_type;

I really dislike all this white space churn just because the enum name
is so long. If it was long for a good reason - increasing readability -
I may have conceded, but I don't think that is the case.

I do not think that 'component_type' is more clear than 'last_type'
for a developer passing by reading the code.
If anything, the opposite, because 'last_type' or 'type' variables always
appear in the same function with 'last' variable, so it is more clear WHICH
object the type is referring to and matches the LAST_ enum prefix.

> +       unsigned                depth;
> +       int                     total_link_count;
>         struct saved {
>                 struct path link;
>                 struct delayed_call done;
> @@ -2221,7 +2221,7 @@ static struct dentry *follow_dotdot(struct nameidat=
a *nd)
>         return dget(nd->path.dentry);
>  }
>
> -static const char *handle_dots(struct nameidata *nd, int type)
> +static const char *handle_dots(struct nameidata *nd, enum component_type=
 type)
>  {
>         if (type =3D=3D LAST_DOTDOT) {
>                 const char *error =3D NULL;
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
> @@ -2963,7 +2963,8 @@ static struct dentry *__start_removing_path(int dfd=
, struct filename *name,
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
> @@ -3009,7 +3010,8 @@ struct dentry *kern_path_parent(const char *name, s=
truct path *path)
>         CLASS(filename_kernel, filename)(name);
>         struct dentry *d;
>         struct qstr last;
> -       int type, error;
> +       enum component_type type;
> +       int error;
>
>         error =3D filename_parentat(AT_FDCWD, filename, 0, &parent_path, =
&last, &type);
>         if (error)
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
> @@ -5365,7 +5367,7 @@ int filename_rmdir(int dfd, struct filename *name)
>         struct dentry *dentry;
>         struct path path;
>         struct qstr last;
> -       int type;
> +       enum component_type type;
>         unsigned int lookup_flags =3D 0;
>         struct delegated_inode delegated_inode =3D { };
>  retry:
> @@ -5383,6 +5385,7 @@ int filename_rmdir(int dfd, struct filename *name)
>         case LAST_ROOT:
>                 error =3D -EBUSY;
>                 goto exit2;
> +       case LAST_NORM: ; // OK

I was not aware that the compiler warns about missing cases for enums -
cool feature.
but that needs to be a break; rather than fallthough the end
and as a matter of taste, I would put the valid case first - not critical.

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
> diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
> index d08973b288e5..b12d481f5ba9 100644
> --- a/fs/smb/server/vfs.c
> +++ b/fs/smb/server/vfs.c
> @@ -56,7 +56,8 @@ static int ksmbd_vfs_path_lookup(struct ksmbd_share_con=
fig *share_conf,
>  {
>         struct qstr last;
>         const struct path *root_share_path =3D &share_conf->vfs_path;
> -       int err, type;
> +       int err;
> +       enum component_type type;
>         struct dentry *d;
>
>         if (pathname[0] =3D=3D '\0') {
> @@ -668,7 +669,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const s=
truct path *old_path,
>         struct renamedata rd;
>         struct ksmbd_share_config *share_conf =3D work->tcon->share_conf;
>         struct ksmbd_file *parent_fp;
> -       int new_type;
> +       enum component_type new_type;
>         int err, lookup_flags =3D LOOKUP_NO_SYMLINKS;
>
>         if (ksmbd_override_fsids(work))
> diff --git a/include/linux/namei.h b/include/linux/namei.h
> index 58600cf234bc..fa3ae87762b7 100644
> --- a/include/linux/namei.h
> +++ b/include/linux/namei.h
> @@ -16,7 +16,7 @@ enum { MAX_NESTED_LINKS =3D 8 };
>  /*
>   * Type of the last component on LOOKUP_PARENT
>   */
> -enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};
> +enum component_type {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT};

Please use last_type to match the LAST_ prefix.

TBH, the thing that bothers me most is why is this enum exposed
outside of namei.c
in the first place?

>
>  /* pathwalk mode */
>  #define LOOKUP_FOLLOW          BIT(0)  /* follow links at the end */
> @@ -70,7 +70,7 @@ static inline void end_removing_path(const struct path =
*path , struct dentry *de
>         end_creating_path(path, dentry);
>  }
>  int vfs_path_parent_lookup(struct filename *filename, unsigned int flags=
,
> -                          struct path *parent, struct qstr *last, int *t=
ype,
> +                          struct path *parent, struct qstr *last, enum c=
omponent_type *type,
>                            const struct path *root);

As your patch demonstrates, the only use of enum last_type outside of namei=
.c is
in ksmbd calls to vfs_path_parent_lookup().

This is an "internal" lookup helper that was exposed by commit
74d7970febf7e ("ksmbd: fix racy issue from using ->d_parent and ->d_name")

This commit appears to be using the helper inconsistently in
its two call sites, because ksmbd_vfs_rename(), is not checking the
unlikely(type !=3D LAST_NORM) case.

Perhaps it would be wiser not to expose enum last_type at all and move
the unlikely(type !=3D LAST_NORM) check into the helper itself in namei.c.

WDYT?

Thanks,
Amir.
