Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B58395ADE
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783372834; cv=none; b=G5RPJpWH/LbWaxdjBSI6uyzQUMYvtko87JzDx6GjbdQtAlDfKEuyy3nLYWw9axaBJIwERffL8GrxBJW4pAHIN6mtQBf1Xm6WJ69lakZuP5cAO7WSzcIowAuDZMsBTG1TK9fzMS8ypVa1OkrfVAEOdIk0I0a0rELnerk9NxRydfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783372834; c=relaxed/simple;
	bh=eAVAfWh/2mt0+nY2lMgIvTpxr5QnoUNDTEORSpQyiYg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=jrQ8D817SaEtcLP9ZOl4HC3nybtuEpDbeL91m6FS68GrBELTlzPK+2/hwqoehUrwydKatu+s4Ie4JwGQg4XpQyO9dkjZNWgij8E2ipdM6jmjqCRPMabJl5SixQDwnEzFfpCY6VZqOpvvRmwr0+qPM3BH+IcxP6i8jMlkD5Dq+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=UaoRD91I; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="UaoRD91I"
X-KPN-MessageId: 808b8394-7980-11f1-8f53-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 808b8394-7980-11f1-8f53-005056992ed3;
	Mon, 06 Jul 2026 23:20:24 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 808a3d01-7980-11f1-9b0b-00505699693e;
	Mon, 06 Jul 2026 23:20:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=9SXuU2gea/i8yF0o+HcAK5Jz1OAj/hq+5gHtt7kZezo=;
	b=UaoRD91IQgBOD3AVmW/S4glZ4aV0LWCm+drVujtzfX+B/qnVty7ViGKSuk6OUXdED0OycM1xswUMe
	 rW+QrMh9cgc3DjsMZ+vmKOCPLpsOTo03DsIRl2ov01ovbrT77cfp0s4ywj398ZbCF1VWigSNAfWfy9
	 Zs8oFFpegPOW6LqivsYdC35LbniQfTaEF0ZSG2ojg/IRu3DYldmI4z0fePKaeQ8U+0lPsV3MDXMDYV
	 ZDQ94QPXsh/blNn/r6eCjxJoj3L07SDu7TDeI7BUgz6yFsTTsA9KiUtTFa8fU0Usgwc8ljMB/azrLT
	 FXCFhrt6rGHQQ/FGXb41+wjjFgXnjhg==
X-KPN-MID: 33|igo8dmA82ZvUvFW8zq0symk1s3ZWCiIcSo6YfdQ73k4A5wQD7moIiKJQVJgco1g
 qt5zDpNmSwdJ74U6+ZcTMCDu+0ldzgDZkEMTfbAcYPIo=
X-CMASSUN: 33|R/Hyih5bnEYP93vGn1pDqym/5cpFcEdIjfMUGMbabkMs+E5p/d55jyd8xgWXx7i
 ZTXGv/L+k6Z66GQFJszKBkw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 806cc57c-7980-11f1-916a-005056995d6c;
	Mon, 06 Jul 2026 23:20:24 +0200 (CEST)
Date: Mon, 6 Jul 2026 23:20:24 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <110549453.130215.1783372824255@kpc.webmail.kpnmail.nl>
In-Reply-To: <178331600416.27465.18425637255026621428@noble.neil.brown.name>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-5-jkoolstra@xs4all.nl>
 <178331600416.27465.18425637255026621428@noble.neil.brown.name>
Subject: Re: [PATCH v3 04/14] vfs: call audit_inode_child() in lookup_open()
 on failure too
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 06-07-2026 07:33 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> On Sun, 05 Jul 2026, Jori Koolstra wrote:
> > audit_inode_child() is called in may_create_dentry() so that failed
> > filesystem operations still register an audit entry. On success, the
> > entry is overwritten when, for instance, fsnotify_create() is called.
> > This is the calling convention in vfs_create() and vfs_mkdir().
> > In lookup_open(), however, when atomic_open() should have created a
> > file but didn't, no call to audit_inode_child() is made. The same is
> > true for the regular ->create() path.
> > 
> > Fix the calling of audit_inode_child() in lookup_open() to match the
> > vfs_create() path. For the ->atomic_open() filesystems this logic has
> > been pushed into atomic_open(). This function is also reordered a bit
> > to make the case distinction of the possible returns from
> > ->atomic_open() more explicit (i.e. finish_open() or finish_no_open()).
> > 
> > When retrying delegation breaking, audit_inode_child() could be called
> > more than once, but this is OK because those entries are reused.
> > 
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > ---
> >  fs/namei.c | 75 ++++++++++++++++++++++++++++++++----------------------
> >  1 file changed, 45 insertions(+), 30 deletions(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index ee47d3f5159f..956adcd14c4a 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4369,10 +4369,11 @@ static int may_o_create(struct mnt_idmap *idmap,
> >   */
> >  static struct dentry *atomic_open(const struct path *path, struct dentry *dentry,
> >  				  struct file *file,
> > -				  int open_flag, umode_t mode)
> > +				  int open_flag, umode_t mode, bool create_error)
> >  {
> >  	struct dentry *const DENTRY_NOT_SET = (void *) -1UL;
> >  	struct inode *dir =  path->dentry->d_inode;
> > +	bool failed_create = false;
> >  	int error;
> >  
> >  	file->__f_path.dentry = DENTRY_NOT_SET;
> > @@ -4382,23 +4383,33 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
> >  	d_lookup_done(dentry);
> >  	if (!error) {
> >  		if (file->f_mode & FMODE_OPENED) {
> > -			if (unlikely(dentry != file->f_path.dentry)) {
> > +			// finish_open() called
> > +			struct dentry *opened = file->f_path.dentry;
> > +			if (unlikely(opened != dentry)) {
> >  				dput(dentry);
> > -				dentry = dget(file->f_path.dentry);
> > +				dentry = dget(opened);
> >  			}
> > -		} else if (WARN_ON(file->f_path.dentry == DENTRY_NOT_SET)) {
> > -			error = -EIO;
> > -		} else {
> > -			if (file->f_path.dentry) {
> > +		} else if (likely(file->f_path.dentry != DENTRY_NOT_SET)) {
> > +			// finish_no_open() called
> > +			struct dentry *replaced = file->f_path.dentry;
> > +			if (replaced) {
> >  				dput(dentry);
> > -				dentry = file->f_path.dentry;
> > +				dentry = replaced;
> >  			}
> >  			if (unlikely(d_is_negative(dentry)))
> >  				error = -ENOENT;
> 
> I think this can now be
>    if (unlikely(d_is_negative(dentry))
>          error = create_error ?: -ENOENT;
> or something similar if people don't like "?:".
> 

create_error is a bool, and the caller still expects -ENOENT because we have

		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
			dentry = ERR_PTR(create_error);

> > +			if (error && create_error) // should have created, but errored before
> > +				failed_create = true;
> 
> Why have 'failed_create' ? Why not just put the audit_inode_child() like
> here?
> 

Because I am a doofus and didn't notice during several rewrites.

If we reach the point where you propose we move audit_inode_child() to, then error
is true and so we reach audit_inode_child(). Conversely, if we reached
audit_inode_child() then failed_create is true, and this is only set at the proposed
place to move the function to. So this is indeed equivalent.

The failed_create name is terrible anyway and it tripped Sashiko over. It was meant
to convey rather "we know for sure that we should have created a file."

Thanks a lot for taking the time to review and the helpful feedback!

Best,
Jori.

> There rest of the patch look pretty good.
> 
> Thanks,
> NeilBrown
> 
> 
> > +		} else {
> > +			const char *fsname = dentry->d_sb->s_type->name;
> > +			WARN(1, "%s: ->atomic_open() left file->f_path.dentry unset!\n", fsname);
> > +			error = -EIO;
> >  		}
> >  	}
> >  
> >  	if (error) {
> > +		if (failed_create)
> > +			audit_inode_child(dir, dentry, AUDIT_TYPE_CHILD_CREATE);
> >  		dput(dentry);
> >  		dentry = ERR_PTR(error);
> >  	} else {
> > @@ -4462,7 +4473,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> >  		dentry = NULL;
> >  	}
> >  	if (dentry->d_inode) {
> > -		/* Cached positive dentry: will open in f_op->open */
> > +		/* Cached positive dentry: will open in do_open(). */
> >  		return dentry;
> >  	}
> >  
> > @@ -4496,7 +4507,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> >  	if (dir_inode->i_op->atomic_open) {
> >  		if (nd->flags & LOOKUP_DIRECTORY)
> >  			open_flag |= O_DIRECTORY;
> > -		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
> > +		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode, create_error);
> >  		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
> >  			dentry = ERR_PTR(create_error);
> >  		return dentry;
> > @@ -4515,33 +4526,37 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> >  			dentry = res;
> >  		}
> >  	}
> > +	if (dentry->d_inode || !(op->open_flag & O_CREAT)) {
> > +		/* No need to create a file. If lookup returned a positive
> > +		 * dentry, the file will be opened in do_open(). */
> > +		return dentry;
> > +	}
> > +
> > +	/* Negative dentry with O_CREAT flag set */
> > +	audit_inode_child(dir->d_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> >  
> > -	if (unlikely(create_error) && !dentry->d_inode) {
> > +	if (unlikely(create_error)) {
> > +		/* Should have done a create, but we already errored */
> >  		error = create_error;
> >  		goto out_dput;
> >  	}
> >  
> > -	/* Negative dentry, just create the file */
> > -	if (!dentry->d_inode && (open_flag & O_CREAT)) {
> > -		/* but break the directory lease first! */
> > -		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
> > -		if (error)
> > -			goto out_dput;
> > +	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
> > +	if (error)
> > +		goto out_dput;
> >  
> > -		file->f_mode |= FMODE_CREATED;
> > -		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> > -		if (!dir_inode->i_op->create) {
> > -			error = -EACCES;
> > -			goto out_dput;
> > -		}
> > +	file->f_mode |= FMODE_CREATED;
> > +	if (!dir_inode->i_op->create) {
> > +		error = -EACCES;
> > +		goto out_dput;
> > +	}
> >  
> > -		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
> > -						mode, open_flag & O_EXCL);
> > -		if (error)
> > -			goto out_dput;
> > +	error = dir_inode->i_op->create(idmap, dir_inode, dentry,
> > +					mode, open_flag & O_EXCL);
> > +	if (error)
> > +		goto out_dput;
> >  
> > -		fsnotify_create(dir_inode, dentry);
> > -	}
> > +	fsnotify_create(dir_inode, dentry);
> >  
> >  	return dentry;
> >  
> > @@ -5071,7 +5086,7 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
> >  
> >  		/* atomic_open will dput(dentry) on error */
> >  		dget(orig_dentry);
> > -		dentry = atomic_open(path, dentry, file, flags, mode);
> > +		dentry = atomic_open(path, dentry, file, flags, mode, create_error);
> >  		error = PTR_ERR_OR_ZERO(dentry);
> >  
> >  		if (IS_ERR(dentry))
> > -- 
> > 2.55.0
> > 
> >
