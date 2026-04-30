Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFFC336897;
	Thu, 30 Apr 2026 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777582653; cv=none; b=c9CuKPnBKDciLSUE/TVx6ISTL3io/iKMR7PMgi5X4xLKzSNWjSVlCm2YojJhr0fXJS/a1woSWFZ8z+TRG+AVDq1LV+FtrmUWhT0M16v60QZ/prICzoTPY8ArWHJ/8zwrqB41y8I+iILuC+Jb427Hsw1287mxRwF0K7XlU85TZ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777582653; c=relaxed/simple;
	bh=t9GtFBOV5pzaNCoC5lVpPdISdQHFpHZX2j4L8IQkSDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fUco+kqZxUaUXBChN859sOR201gElR+PjV7bA9VYvPF+oudeclnIuQejTWL0C3ZyXQi//1+zNGzF9suZDSbdKxKCQSW27TdYdLhuNtqK9R6ebmhRsXRmurkdd19tgeLfJVNzMVlUHzJK4xDbHcZZfGEVxXZuaLQB374V2Fq9Xsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTq28zEI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTq28zEI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5C5C2BCB3;
	Thu, 30 Apr 2026 20:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777582652;
	bh=t9GtFBOV5pzaNCoC5lVpPdISdQHFpHZX2j4L8IQkSDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GTq28zEIIpH3Qh1JqT++3AuJ5yzFY5gbiKyPheAT85NTsOv1xanN+1k351Ko7pAWK
	 5jkD0kax9VSfK6Bf8NHbc5Mg3UGxAKuxAPWRRKLECT6wEIHGHce2XU6oDKYXi1Wn3c
	 E65EDuke9zwbYAg6XZeR4ONqoZMx919+OJ1hkUGaABpbZ05EiHpntnLMDoAnE6ayrs
	 I7HKtgbDFzuALS5i3XYaYlAgc7o6cUJLigQDvexsmSil1O9ckQxKT3A+uDwj77ooZk
	 sUvGjVg2BOIuAxxDHOeS9x3VofvXEhdIGPfRx3hFY1rm+vQiOWaq8gTBBnNG91p/h/
	 UMiMrb4X0bOGQ==
Date: Thu, 30 Apr 2026 13:57:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
	bernd@bsbernd.com, fuse-devel@lists.linux.dev
Subject: Re: [PATCH 3/4] fuse: update file mode when updating acls
Message-ID: <20260430205731.GV7739@frogsfrogsfrogs>
References: <177747203969.4101397.1905820467457875817.stgit@frogsfrogsfrogs>
 <177747204051.4101397.16466232272715875212.stgit@frogsfrogsfrogs>
 <CAJnrk1bYYBf2qYBvhv=MFKvG-2VekKwHCuRS6tjva=tExw6Gdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bYYBf2qYBvhv=MFKvG-2VekKwHCuRS6tjva=tExw6Gdw@mail.gmail.com>

On Thu, Apr 30, 2026 at 02:48:29PM +0100, Joanne Koong wrote:
> On Wed, Apr 29, 2026 at 3:22 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > If someone sets ACLs on a file that can be expressed fully as Unix DAC
> > mode bits, most local filesystems will then update the mode bits and
> > drop the ACL xattr to reduce inefficiency in the file access paths.
> > Let's do that too.  Note that means that we can setacl and end up with
> > no ACL xattrs, so we also need to tolerate ENODATA returns from
> > fuse_removexattr.
> >
> > Note that here we define a "local" fuse filesystem as one that uses
> > fuseblk mode; we'll shortly add fuse servers that use iomap for the file
> > IO path to that list.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > ---
> >  fs/fuse/fuse_i.h |    2 +-
> >  fs/fuse/acl.c    |   56 +++++++++++++++++++++++++++++++++++++++++++++++-------
> >  2 files changed, 50 insertions(+), 8 deletions(-)
> >
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 4c135a7edf54ac..0bcfb42592895c 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -1050,7 +1050,7 @@ static inline struct fuse_mount *get_fuse_mount(struct inode *inode)
> >         return get_fuse_mount_super(inode->i_sb);
> >  }
> >
> > -static inline struct fuse_conn *get_fuse_conn(struct inode *inode)
> > +static inline struct fuse_conn *get_fuse_conn(const struct inode *inode)
> >  {
> >         return get_fuse_mount_super(inode->i_sb)->fc;
> >  }
> > diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
> > index cbde6ac1add35a..bee8a9a734f50a 100644
> > --- a/fs/fuse/acl.c
> > +++ b/fs/fuse/acl.c
> > @@ -11,6 +11,18 @@
> >  #include <linux/posix_acl.h>
> >  #include <linux/posix_acl_xattr.h>
> >
> > +/*
> > + * If this fuse server behaves like a local filesystem, we can implement the
> > + * kernel's optimizations for ACLs for local filesystems instead of passing
> > + * the ACL requests straight through to another server.
> 
> nit: "to the server" instead of "to another server"? another server
> sounds like there's 2 servers
> 
> > + */
> > +static inline bool fuse_inode_has_local_acls(const struct inode *inode)
> > +{
> > +       const struct fuse_conn *fc = get_fuse_conn(inode);
> > +
> > +       return fc->posix_acl && fuse_inode_is_exclusive(inode);
> > +}
> > +
> >  static struct posix_acl *__fuse_get_acl(struct fuse_conn *fc,
> >                                         struct inode *inode, int type, bool rcu)
> >  {
> > @@ -98,6 +110,8 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> >         struct inode *inode = d_inode(dentry);
> >         struct fuse_conn *fc = get_fuse_conn(inode);
> >         const char *name;
> > +       umode_t mode = inode->i_mode;
> > +       const bool local_acls = fuse_inode_has_local_acls(inode);
> >         int ret;
> >
> >         if (fuse_is_bad(inode))
> > @@ -113,14 +127,25 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> >         else
> >                 return -EINVAL;
> >
> > +       /*
> > +        * If the ACL can be represented entirely with changes to the mode
> > +        * bits, then most filesystems will update the mode bits and delete
> > +        * the ACL xattr.
> > +        */
> > +       if (acl && type == ACL_TYPE_ACCESS && local_acls) {
> > +               ret = posix_acl_update_mode(idmap, inode, &mode, &acl);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> >         if (acl) {
> >                 unsigned int extra_flags = 0;
> >                 /*
> > -                * Fuse userspace is responsible for updating access
> > -                * permissions in the inode, if needed. fuse_setxattr
> > -                * invalidates the inode attributes, which will force
> > -                * them to be refreshed the next time they are used,
> > -                * and it also updates i_ctime.
> > +                * For non-local filesystems, fuse userspace is responsible for
> > +                * updating access permissions in the inode, if needed.
> > +                * fuse_setxattr invalidates the inode attributes, which will
> > +                * force them to be refreshed the next time they are used, and
> > +                * it also updates i_ctime.
> >                  */
> >                 size_t size;
> >                 void *value;
> > @@ -137,9 +162,10 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> >                 /*
> >                  * Fuse daemons without FUSE_POSIX_ACL never changed the passed
> >                  * through POSIX ACLs. Such daemons don't expect setgid bits to
> > -                * be stripped.
> > +                * be stripped, unless they've explicitly told the kernel to
> > +                * take care of that.
> 
> nit: imo this would be clearer as its own sentence, eg "For local
> filesystems, the kernel already handled sgid stripping in
> posix_acl_update_mode() above".
> 
> >                  */
> > -               if (fc->posix_acl &&
> > +               if (fc->posix_acl && !local_acls &&
> >                     !in_group_or_capable(idmap, inode,
> >                                          i_gid_into_vfsgid(idmap, inode)))
> >                         extra_flags |= FUSE_SETXATTR_ACL_KILL_SGID;
> > @@ -148,6 +174,22 @@ int fuse_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> >                 kfree(value);
> >         } else {
> >                 ret = fuse_removexattr(inode, name);
> > +               /* If the acl didn't exist to start with that's fine. */
> > +               if (ret == -ENODATA)
> > +                       ret = 0;
> > +       }
> > +
> > +       /* If we scheduled a mode update above, push that to userspace now. */
> > +       if (!ret) {
> > +               struct iattr attr = { };
> > +
> > +               if (mode != inode->i_mode) {
> > +                       attr.ia_valid |= ATTR_MODE;
> > +                       attr.ia_mode = mode;
> > +               }
> > +
> > +               if (attr.ia_valid)
> > +                       ret = fuse_do_setattr(idmap, dentry, &attr, NULL);
> 
> maybe something like this is clearer?
> 
>     if (!ret && mode != inode->i_mode) {
>          struct iattr attr = {
>                 .ia_valid |= ATTR_MODE,
>                 .ia_mode = mode,
>           };
>          ret = fuse_do_setattr(idmap, dentry, &attr, NULL);
>     }

I know, you said that last time ;)
https://lore.kernel.org/linux-fsdevel/CAJnrk1YL3KnON-WtNjNi+2GZ+6rYvnVUnYwCk5efv0o41XkxcA@mail.gmail.com/

and my reply is the same:
https://lore.kernel.org/linux-fsdevel/20260325222308.GH6202@frogsfrogsfrogs/#t

...which is to say, does anyone think that's worth the churn?

> 
> Overall, this lgtm though.
> 
> Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks!

--D

> Thanks,
> Joanne
> 
> >         }
> >
> >         if (fc->posix_acl) {
> >
> 
