Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E54D43F0BE
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jul 2026 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784412816; cv=none; b=Gb4XDwhuKaOr9KSWIoEpd5ejUm0wFZ2msWyTOT8qMgcLejzxdvt+wJymq6ovTLYdYaFVh6ypFXhjB6p0aUAlo5IuiscsRSdKO/zv+A/LbclU0ar844IEXhgI7Xbk0HlHqLh/RsgRUPcVdEJoaGNgE0T4FZUQJQ8TnFobGFSAvUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784412816; c=relaxed/simple;
	bh=NsN8S9tLKDW24zZnhPzold25ER5gDUpS58/Na1lYqdU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bKLKIyaJrfS8TKDvbfcNAEyGoWxabNU1lFi0X9R+pBjfQ1UBqQUKH1zzWIlxZGefbFj9bgu6rg1XDgN0tx8kfBU7d8b30sqs2Gh+kdTs2l9szLruHhGP4+G9lDOOquUxdaeP8TBimij+drFLE75jvWM+TAWImWYli4NNCSiqLd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=M2bfyWAs; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="M2bfyWAs"
X-KPN-MessageId: e3db5f7a-82f5-11f1-9e8e-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e3db5f7a-82f5-11f1-9e8e-005056999439;
	Sun, 19 Jul 2026 00:13:22 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id e3d9ce40-82f5-11f1-ae83-0050569981f5;
	Sun, 19 Jul 2026 00:13:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=dcMZRNF3P5sbqZLB+h8JCRYTILrn8k9x74JH6yV9920=;
	b=M2bfyWAsjlPKxvYZB8XQ67mrV+nkYmaX/EfHAERK6XSB90BWoji/rB3Enb3gk69+kFqZ/Bd53weuk
	 hEaMKpLdusyMnYRRC9MQNMbp7lUSsimShq7yi2FFW6l+PTAdHek2AUH/xsEjIGLPpsN9mZd+gMYOsH
	 BqGGt8CSXMMrNLda+3js/mZ6IuJQcdPqvHbv634+khRYwP8MV/H6jk+RGqkRBByK32f8MIlzFyKI8Y
	 iKtPmuWouT8LMolJYXJh1/n/e5kOktD7tZAX8o96McVK23iodjfsCJ4ZtZr70oF9sr6/DfEg5aZMB3
	 4YxXAmcplvVxw5r/i581RY7u+BtVleg==
X-KPN-MID: 33|IX8wGhJa3JU+ofoHyWDopscbUKu8lZ0600+lDzYsSz5uRG3h4lVDHGvHBh0BAMa
 43aQrvCHvc1ZbwxMVAPy0xw==
X-CMASSUN: 33|fECvSw8ob3K3ARLyrytQB0R0Sl8O+5z0I8Cp8vUs6s/4qNR3TD1UY82ykNAZWJ3
 G/aiFxn4TTqv5ROeFqjxzew==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id e3ce5249-82f5-11f1-916a-005056995d6c;
	Sun, 19 Jul 2026 00:13:22 +0200 (CEST)
Date: Sun, 19 Jul 2026 00:13:22 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Message-ID: <381790643.1478590.1784412802571@kpc.webmail.kpnmail.nl>
In-Reply-To: <178432915017.3371781.13946671241977454321@noble.neil.brown.name>
References: <20260714230534.776886-1-neilb@ownmail.net>
 <20260714230534.776886-4-neilb@ownmail.net>
 <21817263.1168614.1784151799976@kpc.webmail.kpnmail.nl>
 <178415489698.3371781.5121934606972521996@noble.neil.brown.name>
 <1697164687.1184851.1784159287934@kpc.webmail.kpnmail.nl>
 <178432915017.3371781.13946671241977454321@noble.neil.brown.name>
Subject: Re: [PATCH v4 3/3] VFS: add vfs_lookup_open() for nfsd
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

Comments between the lines.

> Op 18-07-2026 00:59 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> On Thu, 16 Jul 2026, Jori Koolstra wrote:
> > > Op 16-07-2026 00:34 CEST schreef NeilBrown <neilb@ownmail.net>:
> > > 
> > >  
> > > On Thu, 16 Jul 2026, Jori Koolstra wrote:
> > > > > Op 15-07-2026 01:04 CEST schreef NeilBrown <neilb@ownmail.net>:
> > > > > 
> > > > >  
> > > > > From: NeilBrown <neil@brown.name>
> > > > > 
> > > > > vfs_lookup_open() is a limited version of lookup_open() which is
> > > > > exported for nfsd to use - to replace dentry_create().
> > > > > 
> > > > > It is limited in that no filename is given (thus no auditing) and no
> > > > > LOOKUP_ flags are passed.  A few "intent" LOOKUP flags are deduced from
> > > > > the open flags.
> > > > > 
> > > > > If a non-regular file is found and appropriate error is returned and no
> > > > > file is opened.
> > > > > 
> > > > > Signed-off-by: NeilBrown <neil@brown.name>
> > > > > ---
> > > > >  fs/namei.c            | 96 +++++++++++++++++++++++++++++++++++++++++++
> > > > >  include/linux/namei.h |  3 ++
> > > > >  2 files changed, 99 insertions(+)
> > > > > 
> > > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > > index cb33a01d16eb..630f93608224 100644
> > > > > --- a/fs/namei.c
> > > > > +++ b/fs/namei.c
> > > > > @@ -4562,6 +4562,102 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> > > > >  	goto out;
> > > > >  }
> > > > >  
> > > > > +/**
> > > > > + * vfs_lookup_open - open and possibly create a regular file
> > > > > + * @parent: directory to contain file
> > > > > + * @last: final component of file name
> > > > > + * @open_flag: O_flags
> > > > > + * @mode: initial permissions for file
> > > > > + *
> > > > > + * Open a file after lookup and/or create.  This provides similar
> > > > > + * functionality open_last_lookups() for non-VFS users, particularly
> > > > > + * nfsd.
> > > > > + * It uses ->atomic_open or ->lookup / ->create / ->open as appropriate.
> > > > > + *
> > > > > + * If the fs object found is not a regular file then an error is returned.
> > > > > + * In some cases, related errors are repurposed so that the caller can
> > > > > + * determine the type of file found from the error.
> > > > > + * -EISDIR : a directory was found
> > > > > + * -ELOOP  : a symlink was found
> > > > > + * -ENODEV : a block or character device special file was found
> > > > > + * -EFTYPE : any other non-regular file was found, such as FIFO or SOCK.
> > > > > + *           or ->atomic_open responded to __O_REGULAR.
> > > > > + *
> > > > > + * Returns: the opened struct file, or an error.
> > > > > + */
> > > > > +struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
> > > > > +			     int open_flag, umode_t mode)
> > > > > +{
> > > > > +	struct file *file __free(fput) = NULL;
> > > > > +	struct nameidata nd = {};
> > > > > +	struct open_flags op = {};
> > > > > +	struct dentry *dentry;
> > > > > +	int error = 0;
> > > > > +
> > > > > +	WARN_ONCE(mode & ~S_IALLUGO, "mode must only have permission bits");
> > > > > +	WARN_ONCE(open_flag & ~(O_ACCMODE|O_CREAT|O_EXCL|O_TRUNC|__O_REGULAR),
> > > > > +		  "open_flag has unsupported flags");
> > > > > +
> > > > > +	mode |= S_IFREG;
> > > > > +	open_flag |= __O_REGULAR;
> > > > > +
> > > > > +	error = lookup_noperm_common(last, parent->dentry);
> > > > > +	if (error)
> > > > > +		return ERR_PTR(error);
> > > > > +
> > > > > +	file = alloc_empty_file(open_flag, current_cred());
> > > > > +	if (IS_ERR(file))
> > > > > +		return file;
> > > > > +
> > > > > +	nd.path = *parent;
> > > > > +	nd.last = *last;
> > > > > +	nd.flags = LOOKUP_OPEN;

I am not so familiar with the audit stuff, but you don't init nd->name here. Will
this possibly lead to a new AUDIT_TYPE_UNKNOWN type struct audit_names for every
invoke of vfs_lookup_open? See __audit_inode() function.

That is also a bit of a pain-point here in general. If ever lookup_open() was changed
to use more of nd, then you must remember to initialize the field here as well, which
makes this function quite fragile.

One way to resolve that is to pass everything as argument to lookup_open() instead
of through nd, but that is a bit ugly. What do you think?

> > > > > +	if (open_flag & O_CREAT) {
> > > > > +		nd.flags |= LOOKUP_CREATE;
> > > > > +		if (open_flag & O_EXCL)
> > > > > +			nd.flags |= LOOKUP_EXCL;
> > > > > +	}
> > > > > +	op.open_flag = open_flag;
> > > > > +	op.mode = mode;
> > > > > +	dentry = lookup_open(&nd, file, &op);
> > > > > +
> > > > > +	if (IS_ERR(dentry))
> > > > > +		return ERR_CAST(dentry);
> > > > > +
> > > > > +	if (d_really_is_negative(dentry)) {
> > > > > +		error = -ENOENT;
> > > > > +	} else if (!(file->f_mode & FMODE_CREATED) && (open_flag & O_EXCL)) {
> > > > > +		error = -EEXIST;
> > > > > +	} else if ((dentry->d_inode->i_mode & S_IFMT) != S_IFREG) {
> > > > > +		switch (dentry->d_inode->i_mode & S_IFMT) {
> > > > > +		case S_IFDIR:
> > > > > +			error = -EISDIR;
> > > > > +			break;
> > > > > +		case S_IFLNK:
> > > > > +			error = -ELOOP;
> > > > > +			break;
> > > > > +		case S_IFBLK:
> > > > > +		case S_IFCHR:
> > > > > +			error = -ENODEV;
> > > > > +			break;
> > > > > +		case S_IFIFO:
> > > > > +		case S_IFSOCK:
> > > > > +		default:
> > > > > +			error = -EFTYPE;
> > > > > +			break;
> > > > > +		}
> > > > > +	} else if (!(file->f_mode & FMODE_OPENED)) {
> > > > > +		nd.path.dentry = dentry;
> > > > > +		error = vfs_open(&nd.path, file);
> > > > > +	}
> > > > > +	dput(dentry);
> > > > > +
> > > > > +	if (error)
> > > > > +		return ERR_PTR(error);
> > > > > +	return no_free_ptr(file);
> > > > > +}
> > > > > +EXPORT_SYMBOL_FOR_MODULES(vfs_lookup_open, "nfsd");
> > > > > +
> > > > >  static inline bool trailing_slashes(struct nameidata *nd)
> > > > >  {
> > > > >  	return (bool)nd->last.name[nd->last.len];
> > > > > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > > > > index ebe6e29f7e93..86d657b24fc6 100644
> > > > > --- a/include/linux/namei.h
> > > > > +++ b/include/linux/namei.h
> > > > > @@ -97,6 +97,9 @@ struct dentry *start_creating_dentry(struct dentry *parent,
> > > > >  struct dentry *start_removing_dentry(struct dentry *parent,
> > > > >  				     struct dentry *child);
> > > > >  
> > > > > +struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
> > > > > +			     int open_flag, umode_t mode);
> > > > > +
> > > > >  /* end_creating - finish action started with start_creating
> > > > >   * @child: dentry returned by start_creating() or vfs_mkdir()
> > > > >   *
> > > > > -- 
> > > > > 2.50.0.107.gf914562f5916.dirty
> > > > 
> > > > So I am not really familiar with the nsfd backend where this function will be put
> > > > to use, but I imagine you need the fileserver to mirror operations on the client.
> > > > And since from within the kernel we don't do syscalls, we need this function to
> > > > mimic the client syscall path and call into the actual underlying fs. Is that
> > > > more-or-less correct?
> > > 
> > > more or less.
> > > 
> > > > 
> > > > So then the rights checking happens on the properly authenticated client-end? Or
> > > > does nsfd have another mechanism for that?
> > > 
> > > Both the client and server check rights.  The server because it cannot
> > > trust the client, the client so it doesn't waste time trying things that
> > > aren't permitted.
> > > 
> > > > 
> > > > I just want to ensure that using this function cannot bypass the sticky directory
> > > > semantics, as that now is the task of do_open(), which this skips of course.
> > > > If that is OK, this function LGTM :)
> > > 
> > > It appears that may_create_in_sticky() is only ever called AFTER the
> > > file has been created.  do_open() is called after open_last_lookups(),
> > > which calls lookup_open(), which calls ->create or ->atomic_open().
> > > 
> > > I wonder if anyone has tested that code. Maybe I should...
> > > 
> > 
> > Yeah, that is the correct behavior, I think. may_create_in_sticky() is a bit of
> > a misnomer, really it should be something like may_o_creat_in_sticky() or even
> > may_open_in_stick(). Afaik it's optional hardening that really should be the
> > responsibility of user space: it's to prevent file squatting whereby in, for instance,
> > /tmp an attacker predicts what file a privileged user will O_CREAT open. In that case,
> > if the user application didn't use O_EXCL, the attacker may symlink it in advance to
> > say /etc/passwd, or do other nasty things.
> 
> Ahhh - I see.  As you say it is "O_CREAT" rather than "create" that is
> relevant, and whether the calling process owns the file.
>   may_o_create_alien_in_sticky()
> is a bit long.
> 
> This functionality doesn't protect the filesystem, it protects the
> application.
> Now that I understand that I can say with some confidence that nfsd
> doesn't have any interest in it.  The NFS client is in a positive to
> protect the application, it gets this protection for free.
> 
> So nfsd doesn't need to be concerned with the stick-dir check.
> 
> > 
> > I presume there was once discussion about whether this should be kernel responsibility,
> > and that's where this line is about in link_path_walk():
> > 
> > 		nd->dir_mode = 0; // short-circuit the 'hardening' idiocy
> > 
> > Or is that not what you meant?
> 
> I think that line it to handle O_EMPTY_PATH opens where the directory
> might not have been seen.  And certainly we don't always have agreement
> about what hardening is appropriate.
> 

This line predates O_EMPTYPATH, isn't it just because root has no parent to
set the dir_mode of?

Best,
Jori.
