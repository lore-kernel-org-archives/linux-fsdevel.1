Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114403E8C77;
	Fri,  1 May 2026 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777654645; cv=none; b=LIKciZNKehHRWoeqHIRaHkvI4A9e/dAM30jEAXIZ/fPwMxqkbxinvFHifB+xIVs1Q5CKX6f0gmw4vDpievoAKWaCvXeq3ta6V5RMMYIHLXQTrJfDqczOjmWlA3KDnCUHDWFQfUeH8Q53sOdGyEq6D+zis8NjECbkjSLkYZfwRIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777654645; c=relaxed/simple;
	bh=Kn2xN0gxTLpfkxD9tmgiok0R5gqgulG5x9B2yKCc9XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdNNE/qYtRtzY4VgPcsonbv+YcVozeyqK89292jPOW/DVkbvqzxgcprr2DOlK63rKhvFwL/QeKslQsFEEq6jN+Vh2ClVEK/RNMq2yIAQdtQHLKx6zsq6fqqOccKEqzQsuYNl3CaWHJ/QN1M7dw4OSVq0b0drLCHslW5Za7joyCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJ5ie3Qk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJ5ie3Qk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63799C2BCB4;
	Fri,  1 May 2026 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777654644;
	bh=Kn2xN0gxTLpfkxD9tmgiok0R5gqgulG5x9B2yKCc9XU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qJ5ie3QkNekV1SFUmzzDZpod8zXhAkEPA0Ve6tJNNXEGiTaup171q4MU/lXEdI6b5
	 YsI4hx+J1+j2pe90nGCHAZM9PEx4k3yNEga2H8ixGf8fIZG52iWFqXB2j37wJAlxAl
	 q44hQF+qGYMPCBA4dfQbyaN9WrBmPryGJKG6vv1QDe6G8qRmQtNHR2jUHbjeHZ7WIp
	 PdL6NmiHO6gSujfg327m0llGWvPHxoH/TOSgcCbP1EaVFSOLuNhDjIObQcEQE3O6B7
	 JrMdQwzWtNkghx9n8Bhgv/+TbKtAs2jmkc0GGEN9G2IFYajYknF0TRb6ErqIGVOrPz
	 tTZ3NQzVyjvpA==
Date: Fri, 1 May 2026 09:57:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 4/4] fuse: propagate default and file acls on creation
Message-ID: <20260501165723.GX7739@frogsfrogsfrogs>
References: <177747203969.4101397.1905820467457875817.stgit@frogsfrogsfrogs>
 <177747204072.4101397.7905459296598969749.stgit@frogsfrogsfrogs>
 <CAJnrk1Z72rCb_MQLhx5HiQRNk7LGuUNVcTeCpLFD-+Xr7_MHNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z72rCb_MQLhx5HiQRNk7LGuUNVcTeCpLFD-+Xr7_MHNA@mail.gmail.com>

On Fri, May 01, 2026 at 12:11:42PM +0100, Joanne Koong wrote:
> On Wed, Apr 29, 2026 at 3:22 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > For local filesystems, propagate the default and file access ACLs to new
> > children when creating them, just like the other in-kernel local
> > filesystems.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_i.h |    4 ++
> >  fs/fuse/acl.c    |   62 +++++++++++++++++++++++++++++++++
> >  fs/fuse/dir.c    |  101 +++++++++++++++++++++++++++++++++++++++++-------------
> >  3 files changed, 142 insertions(+), 25 deletions(-)
> >
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 0bcfb42592895c..0b9c617ee3e5be 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -1530,6 +1530,10 @@ struct posix_acl *fuse_get_acl(struct mnt_idmap *idmap,
> >                                struct dentry *dentry, int type);
> >  int fuse_set_acl(struct mnt_idmap *, struct dentry *dentry,
> >                  struct posix_acl *acl, int type);
> > +int fuse_acl_create(struct inode *dir, umode_t *mode,
> > +                   struct posix_acl **default_acl, struct posix_acl **acl);
> > +int fuse_init_acls(struct inode *inode, const struct posix_acl *default_acl,
> > +                  const struct posix_acl *acl);
> >
> >  /* readdir.c */
> >  int fuse_readdir(struct file *file, struct dir_context *ctx);
> > diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
> > index bee8a9a734f50a..9619ac84a85886 100644
> > --- a/fs/fuse/acl.c
> > +++ b/fs/fuse/acl.c
> > @@ -10,6 +10,7 @@
> >
> >  #include <linux/posix_acl.h>
> >  #include <linux/posix_acl_xattr.h>
> > +#include <linux/fs_struct.h>
> >
> >  /*
> >   * If this fuse server behaves like a local filesystem, we can implement the
> > @@ -203,3 +204,64 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> >
> >         return ret;
> >  }
> > +
> > +int fuse_acl_create(struct inode *dir, umode_t *mode,
> > +                   struct posix_acl **default_acl, struct posix_acl **acl)
> > +{
> > +       struct fuse_conn *fc = get_fuse_conn(dir);
> > +
> > +       if (fuse_is_bad(dir))
> > +               return -EIO;
> > +
> > +       if (IS_POSIXACL(dir) && fuse_inode_has_local_acls(dir))
> > +               return posix_acl_create(dir, mode, default_acl, acl);
> > +
> > +       if (!fc->dont_mask)
> > +               *mode &= ~current_umask();
> > +
> > +       *default_acl = NULL;
> > +       *acl = NULL;
> > +       return 0;
> > +}
> > +
> > +static int __fuse_set_acl(struct inode *inode, const char *name,
> 
> Should this function just be named something like
> "fuse_set_posix_acl()"? imo that seems clearer

Will do.

> > +                         const struct posix_acl *acl)
> > +{
> > +       struct fuse_conn *fc = get_fuse_conn(inode);
> > +       size_t size;
> > +       void *value = posix_acl_to_xattr(fc->user_ns, acl, &size, GFP_KERNEL);
> 
> nit: imo this would be cleaner separated out to its own line after the
> variable declarations. Also, I think there's that __free(kfree)
> annotation that automatically does the freeing for you after you're
> done with it? Maybe that could be useful here

I'm not a big fan of these weird new macros, but I'll change it:

	struct fuse_conn *fc = get_fuse_conn(inode);
	void *value __free(kfree) = NULL;
	size_t size;

	value = posix_acl_to_xattr(fc->user_ns, acl, &size, GFP_KERNEL);
	if (!value)
		return -ENOMEM;

	if (size > PAGE_SIZE)
		return -E2BIG;

	return fuse_setxattr(inode, name, value, size, 0, 0);


> > +       int ret;
> > +
> > +       if (!value)
> > +               return -ENOMEM;
> > +
> > +       if (size > PAGE_SIZE) {
> > +               kfree(value);
> > +               return -E2BIG;
> > +       }
> > +
> > +       ret = fuse_setxattr(inode, name, value, size, 0, 0);
> > +       kfree(value);
> > +       return ret;
> > +}
> > +
> > +int fuse_init_acls(struct inode *inode, const struct posix_acl *default_acl,
> > +                  const struct posix_acl *acl)
> > +{
> > +       int ret;
> > +
> > +       if (default_acl) {
> > +               ret = __fuse_set_acl(inode, XATTR_NAME_POSIX_ACL_DEFAULT,
> > +                                    default_acl);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       if (acl) {
> > +               ret = __fuse_set_acl(inode, XATTR_NAME_POSIX_ACL_ACCESS, acl);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       return 0;
> > +}
> > diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> > index 5d9466c7fd464e..c5c97065984557 100644
> > --- a/fs/fuse/dir.c
> > +++ b/fs/fuse/dir.c
> > @@ -825,26 +825,28 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
> >         struct fuse_entry_out outentry;
> >         struct fuse_inode *fi;
> >         struct fuse_file *ff;
> > +       struct posix_acl *default_acl = NULL, *acl = NULL;
> 
> nit: Do these need to be null-initialized as fuse_acl_create() will
> already do that? the other call sites (fuse_mknod(), fuse_mkdir())
> don't set to null, so might be nicer to have it be consistent

They're not strictly required because (AFAICT) fuse_acl_create either
returns an errno or sets default_acl/acl.

But I'm really really sick and tired of playing the game where some
static checkers can't dig deep enough into the code to figure that out
and complain based on their incomplete scans.  But I'm probably screwed
anyway because other checkers that can dig that deep will whine about
the unnecessary store.

Meh.  I don't know.  I don't care.  I want to focus on getting the logic
right, not micro-optimizing C local variable initialization.

> >         int epoch, err;
> >         bool trunc = flags & O_TRUNC;
> >
> >         /* Userspace expects S_IFREG in create mode */
> >         BUG_ON((mode & S_IFMT) != S_IFREG);
> >
> > +       err = fuse_acl_create(dir, &mode, &default_acl, &acl);
> > +       if (err)
> > +               return err;
> > +
> >         epoch = atomic_read(&fm->fc->epoch);
> >         forget = fuse_alloc_forget();
> >         err = -ENOMEM;
> >         if (!forget)
> > -               goto out_err;
> > +               goto out_acl_release;
> >
> >         err = -ENOMEM;
> >         ff = fuse_file_alloc(fm, true);
> >         if (!ff)
> >                 goto out_put_forget_req;
> >
> > -       if (!fm->fc->dont_mask)
> > -               mode &= ~current_umask();
> > -
> >         flags &= ~O_NOCTTY;
> >         memset(&inarg, 0, sizeof(inarg));
> >         memset(&outentry, 0, sizeof(outentry));
> > @@ -896,12 +898,17 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
> >                 fuse_sync_release(NULL, ff, flags);
> >                 fuse_queue_forget(fm->fc, forget, outentry.nodeid, 1);
> >                 err = -ENOMEM;
> > -               goto out_err;
> > +               goto out_acl_release;
> >         }
> >         kfree(forget);
> >         d_instantiate(entry, inode);
> >         entry->d_time = epoch;
> >         fuse_change_entry_timeout(entry, &outentry);
> > +
> > +       err = fuse_init_acls(inode, default_acl, acl);
> > +       if (err)
> > +               goto out_acl_release;
> 
> I think this will leak the allocated fuse_file.  I think there needs
> to be a FUSE_RELEASE sent to the server as well so the server can
> release state.

I think you're right.  This needs to do the same cleanups as the failure
case for fuse_iget above, correct?  I think in that case it makes sense
to move the fuse_init_acls call up:

	inode = fuse_iget(dir->i_sb, outentry.nodeid, outentry.generation,
			  &outentry.attr, ATTR_TIMEOUT(&outentry), 0, 0);
	if (!inode) {
		err = -ENOMEM;
		goto out_release;
	}

	err = fuse_init_acls(inode, default_acl, acl);
	if (err)
		goto out_release;

wherein out_release calls fuse_sync_release and fuse_queue_forget.

> > +
> >         fuse_dir_changed(dir);
> >         err = generic_file_open(inode, file);
> >         if (!err) {
> > @@ -917,13 +924,17 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
> >                 else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
> >                         invalidate_inode_pages2(inode->i_mapping);
> >         }
> > +       posix_acl_release(default_acl);
> > +       posix_acl_release(acl);
> >         return err;
> >
> >  out_free_ff:
> >         fuse_file_free(ff);
> >  out_put_forget_req:
> >         kfree(forget);
> > -out_err:
> > +out_acl_release:
> > +       posix_acl_release(default_acl);
> > +       posix_acl_release(acl);
> >         return err;
> >  }
> >
> > @@ -975,7 +986,9 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
> >   */
> >  static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_mount *fm,
> >                                        struct fuse_args *args, struct inode *dir,
> > -                                      struct dentry *entry, umode_t mode)
> > +                                      struct dentry *entry, umode_t mode,
> > +                                      struct posix_acl *default_acl,
> > +                                      struct posix_acl *acl)
> 
> imo it would be cleaner to do the acl logic in the callers instead of
> threading it through create_new_entry() and create_new_nondir(),
> especially since the acl creation logic gets called directly in the
> caller function.

I'll change the code so that create_new_entry no longer consumes
acl/default_acl.

> 
> >  {
> >         struct fuse_entry_out outarg;
> >         struct inode *inode;
> > @@ -983,14 +996,18 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
> >         struct fuse_forget_link *forget;
> >         int epoch, err;
> >
> > -       if (fuse_is_bad(dir))
> > -               return ERR_PTR(-EIO);
> > +       if (fuse_is_bad(dir)) {
> > +               err = -EIO;
> > +               goto out_acl_release;
> > +       }
> >         epoch = atomic_read(&fm->fc->epoch);
> >
> >         forget = fuse_alloc_forget();
> > -       if (!forget)
> > -               return ERR_PTR(-ENOMEM);
> > +       if (!forget) {
> > +               err = -ENOMEM;
> > +               goto out_acl_release;
> > +       }
> >
> >         memset(&outarg, 0, sizeof(outarg));
> >         args->nodeid = get_node_id(dir);
> > @@ -1020,14 +1037,17 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
> >                           &outarg.attr, ATTR_TIMEOUT(&outarg), 0, 0);
> >         if (!inode) {
> >                 fuse_queue_forget(fm->fc, forget, outarg.nodeid, 1);
> > -               return ERR_PTR(-ENOMEM);
> > +               err = -ENOMEM;
> > +               goto out_acl_release;
> >         }
> >         kfree(forget);
> >
> >         d_drop(entry);
> >         d = d_splice_alias(inode, entry);
> > -       if (IS_ERR(d))
> > -               return d;
> > +       if (IS_ERR(d)) {
> > +               err = PTR_ERR(d);
> > +               goto out_acl_release;
> > +       }
> >
> >         if (d) {
> >                 d->d_time = epoch;
> > @@ -1036,19 +1056,31 @@ static struct dentry *create_new_entry(struct mnt_idmap *idmap, struct fuse_moun
> >                 entry->d_time = epoch;
> >                 fuse_change_entry_timeout(entry, &outarg);
> >         }
> > +
> > +       err = fuse_init_acls(inode, default_acl, acl);
> > +       if (err)
> > +               goto out_acl_release;
> 
> Do we probably need a dput() here? afaict from the logic in
> d_splice_alias_ops() [1], it looks like there's a refcount obtained if
> the spliced dentry was non-null
> 
> [1] https://elixir.bootlin.com/linux/v7.0/source/fs/dcache.c#L3097

I think this code hunk should move to immediately after the fuse_iget,
same as the last one.

> >         fuse_dir_changed(dir);
> > +
> > +       posix_acl_release(default_acl);
> > +       posix_acl_release(acl);
> >         return d;
> >
> >   out_put_forget_req:
> >         if (err == -EEXIST)
> >                 fuse_invalidate_entry(entry);
> >         kfree(forget);
> > + out_acl_release:
> > +       posix_acl_release(default_acl);
> > +       posix_acl_release(acl);
> >         return ERR_PTR(err);
> >  }
> >
> >  static int create_new_nondir(struct mnt_idmap *idmap, struct fuse_mount *fm,
> >                              struct fuse_args *args, struct inode *dir,
> > -                            struct dentry *entry, umode_t mode)
> > +                            struct dentry *entry, umode_t mode,
> > +                            struct posix_acl *default_acl,
> > +                            struct posix_acl *acl)
> >  {
> >         /*
> >          * Note that when creating anything other than a directory we
> > @@ -1059,7 +1091,8 @@ static int create_new_nondir(struct mnt_idmap *idmap, struct fuse_mount *fm,
> >          */
> >         WARN_ON_ONCE(S_ISDIR(mode));
> >
> > -       return PTR_ERR(create_new_entry(idmap, fm, args, dir, entry, mode));
> > +       return PTR_ERR(create_new_entry(idmap, fm, args, dir, entry, mode,
> > +                                       default_acl, acl));
> >  }
> >
> >  static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
> > @@ -1067,10 +1100,13 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
> >  {
> >         struct fuse_mknod_in inarg;
> >         struct fuse_mount *fm = get_fuse_mount(dir);
> > +       struct posix_acl *default_acl, *acl;
> >         FUSE_ARGS(args);
> > +       int err;
> >
> > -       if (!fm->fc->dont_mask)
> > -               mode &= ~current_umask();
> > +       err = fuse_acl_create(dir, &mode, &default_acl, &acl);
> > +       if (err)
> > +               return err;
> >
> >         memset(&inarg, 0, sizeof(inarg));
> >         inarg.mode = mode;
> > @@ -1082,7 +1118,8 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
> >         args.in_args[0].value = &inarg;
> >         args.in_args[1].size = entry->d_name.len + 1;
> >         args.in_args[1].value = entry->d_name.name;
> > -       return create_new_nondir(idmap, fm, &args, dir, entry, mode);
> > +       return create_new_nondir(idmap, fm, &args, dir, entry, mode,
> > +                                default_acl, acl);
> >  }
> >
> >  static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
> > @@ -1114,13 +1151,17 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> >  {
> >         struct fuse_mkdir_in inarg;
> >         struct fuse_mount *fm = get_fuse_mount(dir);
> > +       struct posix_acl *default_acl, *acl;
> >         FUSE_ARGS(args);
> > +       int err;
> >
> > -       if (!fm->fc->dont_mask)
> > -               mode &= ~current_umask();
> > +       mode |= S_IFDIR;        /* vfs doesn't set S_IFDIR for us */
> > +       err = fuse_acl_create(dir, &mode, &default_acl, &acl);
> > +       if (err)
> > +               return ERR_PTR(err);
> >
> >         memset(&inarg, 0, sizeof(inarg));
> > -       inarg.mode = mode;
> > +       inarg.mode = mode & ~S_IFDIR;
> >         inarg.umask = current_umask();
> >         args.opcode = FUSE_MKDIR;
> >         args.in_numargs = 2;
> > @@ -1128,7 +1169,8 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> >         args.in_args[0].value = &inarg;
> >         args.in_args[1].size = entry->d_name.len + 1;
> >         args.in_args[1].value = entry->d_name.name;
> > -       return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR);
> > +       return create_new_entry(idmap, fm, &args, dir, entry, S_IFDIR,
> > +                               default_acl, acl);
> >  }
> >
> >  static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
> > @@ -1136,7 +1178,14 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
> >  {
> >         struct fuse_mount *fm = get_fuse_mount(dir);
> >         unsigned len = strlen(link) + 1;
> > +       struct posix_acl *default_acl, *acl;
> > +       umode_t mode = S_IFLNK | 0777;
> >         FUSE_ARGS(args);
> > +       int err;
> > +
> > +       err = fuse_acl_create(dir, &mode, &default_acl, &acl);
> > +       if (err)
> > +               return err;
> 
> I think we could skip the acl stuff for symlinks, it looks like
> posix_acl_create() is a no-op for S_IFLNK mode [2]
> 
> [2] https://elixir.bootlin.com/linux/v7.0.1/source/fs/posix_acl.c#L643

You're right that posix_acl_create does nothing for symlinks, but
skipping the call here encodes that implementation detail in fuse.  That
leaves a logic bomb for anyone who might modify posix_acl_create to do
more with symlinks, because the major filesystems (ext4/btrfs/xfs) call
posix_acl_create from their generic inode creation functions, which
means they call it even for symlinks.  That increases the chance that
the author making that change will fail to notice fuse.

--D

> Thanks,
> Joanne
> 
> >
> >         args.opcode = FUSE_SYMLINK;
> >         args.in_numargs = 3;
> > @@ -1145,7 +1194,8 @@ static int fuse_symlink(struct mnt_idmap *idmap, struct inode *dir,
> >         args.in_args[1].value = entry->d_name.name;
> >         args.in_args[2].size = len;
> >         args.in_args[2].value = link;
> > -       return create_new_nondir(idmap, fm, &args, dir, entry, S_IFLNK);
> > +       return create_new_nondir(idmap, fm, &args, dir, entry, S_IFLNK,
> > +                                default_acl, acl);
> >  }
> >
> >  void fuse_flush_time_update(struct inode *inode)
> > @@ -1345,7 +1395,8 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
> >         args.in_args[0].value = &inarg;
> >         args.in_args[1].size = newent->d_name.len + 1;
> >         args.in_args[1].value = newent->d_name.name;
> > -       err = create_new_nondir(&invalid_mnt_idmap, fm, &args, newdir, newent, inode->i_mode);
> > +       err = create_new_nondir(&invalid_mnt_idmap, fm, &args, newdir, newent,
> > +                               inode->i_mode, NULL, NULL);
> >         if (!err)
> >                 fuse_update_ctime_in_cache(inode);
> >         else if (err == -EINTR)
> >
> 
