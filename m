Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BCA37E5FA
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784159296; cv=none; b=HvGm5cRdGvexwwT2kd0nmzbmTILEGkw7P7Bs9MTwBfxMRIKFLfmg0nBTKCiwBybX9fAB70tbGTAu3de0tdde4KwtMBjYkoa6mF8TN7Q/EuhQ1VgyE1Dtxdr7RT0ngCicFqCsSuMq1Wz9cRAperWPC8n3U6e7fBCdM7JmVPr2oaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784159296; c=relaxed/simple;
	bh=9DIWc8PB/3iXYEPx853SrIT5xbSyRVHeeSl/NqJj/q4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ARujFMQzoGkX3ilH3mkBnsx+MUdueh1IxIRARmOnYYEmEpI12GFBcoDdTr+OW+xJZfLhXraVDvJhXTZxCDzwoRRf67Asx3dYT92VBQuvOW3S5D1oghNzGu91LvmQRP+2SjDY+HVH333g6UqOKLKQjaarJXtgtX6bVCBZWdrPMv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=mmB+tcog; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="mmB+tcog"
X-KPN-MessageId: a15d9417-80a7-11f1-9e8e-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id a15d9417-80a7-11f1-9e8e-005056999439;
	Thu, 16 Jul 2026 01:48:08 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id a15c8b31-80a7-11f1-b309-0050569977a2;
	Thu, 16 Jul 2026 01:48:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=bU69zaPQuuK/Q876fOv+Xpllw3rt9iTm8xOXQWdwjTg=;
	b=mmB+tcogi+lozy6h9JnYk+5YAU5GtEnQjZhD0i+6ioWdP4mH3igUFEq5iRP134sCcX9JyL3CTAU9M
	 svexbGyWmlB1n9FMpR27jHMuTFoPCKrz1W9Z0NIUAcqayktmypHqQUF/hwsZN6kJ9z6tUw9DupgfMP
	 +XoD6JMAIes3v+PNkyowCq8y6o7MPNRjJnlpERON1cPeHocGvkslXiqb9UUm5HwFdOms0e38DdsC0o
	 aufqCddtM+TyqRRGsoQLZmP86OuuvWcbhQEULm68TbmuSbIsf55gM+HCnTWe5I2LZ/AnafbrHaIwQR
	 FBGn2g5OXno0lEWUxKTzJXE1SyuLA2w==
X-KPN-MID: 33|WPmC1flBxZjM3M68qbLfdyaE31oUh9GBdYmw63jnk94Yfwy+wnoGtYCwVRfFYCG
 5L1wAay+rrnae+L/4D84LhcGY7TFDyyXNbQB2kNwIu+Y=
X-CMASSUN: 33|EeWMsV3XEYaCFCO4a03flxHupLDOSVYjlwXK08Zr24WCoyPYShOfkFDDvGqdJkE
 EXhDEWPKHqaANJag64lCopg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id a14ed994-80a7-11f1-916a-005056995d6c;
	Thu, 16 Jul 2026 01:48:08 +0200 (CEST)
Date: Thu, 16 Jul 2026 01:48:07 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Message-ID: <1697164687.1184851.1784159287934@kpc.webmail.kpnmail.nl>
In-Reply-To: <178415489698.3371781.5121934606972521996@noble.neil.brown.name>
References: <20260714230534.776886-1-neilb@ownmail.net>
 <20260714230534.776886-4-neilb@ownmail.net>
 <21817263.1168614.1784151799976@kpc.webmail.kpnmail.nl>
 <178415489698.3371781.5121934606972521996@noble.neil.brown.name>
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


> Op 16-07-2026 00:34 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> On Thu, 16 Jul 2026, Jori Koolstra wrote:
> > > Op 15-07-2026 01:04 CEST schreef NeilBrown <neilb@ownmail.net>:
> > > 
> > >  
> > > From: NeilBrown <neil@brown.name>
> > > 
> > > vfs_lookup_open() is a limited version of lookup_open() which is
> > > exported for nfsd to use - to replace dentry_create().
> > > 
> > > It is limited in that no filename is given (thus no auditing) and no
> > > LOOKUP_ flags are passed.  A few "intent" LOOKUP flags are deduced from
> > > the open flags.
> > > 
> > > If a non-regular file is found and appropriate error is returned and no
> > > file is opened.
> > > 
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/namei.c            | 96 +++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/namei.h |  3 ++
> > >  2 files changed, 99 insertions(+)
> > > 
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index cb33a01d16eb..630f93608224 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -4562,6 +4562,102 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> > >  	goto out;
> > >  }
> > >  
> > > +/**
> > > + * vfs_lookup_open - open and possibly create a regular file
> > > + * @parent: directory to contain file
> > > + * @last: final component of file name
> > > + * @open_flag: O_flags
> > > + * @mode: initial permissions for file
> > > + *
> > > + * Open a file after lookup and/or create.  This provides similar
> > > + * functionality open_last_lookups() for non-VFS users, particularly
> > > + * nfsd.
> > > + * It uses ->atomic_open or ->lookup / ->create / ->open as appropriate.
> > > + *
> > > + * If the fs object found is not a regular file then an error is returned.
> > > + * In some cases, related errors are repurposed so that the caller can
> > > + * determine the type of file found from the error.
> > > + * -EISDIR : a directory was found
> > > + * -ELOOP  : a symlink was found
> > > + * -ENODEV : a block or character device special file was found
> > > + * -EFTYPE : any other non-regular file was found, such as FIFO or SOCK.
> > > + *           or ->atomic_open responded to __O_REGULAR.
> > > + *
> > > + * Returns: the opened struct file, or an error.
> > > + */
> > > +struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
> > > +			     int open_flag, umode_t mode)
> > > +{
> > > +	struct file *file __free(fput) = NULL;
> > > +	struct nameidata nd = {};
> > > +	struct open_flags op = {};
> > > +	struct dentry *dentry;
> > > +	int error = 0;
> > > +
> > > +	WARN_ONCE(mode & ~S_IALLUGO, "mode must only have permission bits");
> > > +	WARN_ONCE(open_flag & ~(O_ACCMODE|O_CREAT|O_EXCL|O_TRUNC|__O_REGULAR),
> > > +		  "open_flag has unsupported flags");
> > > +
> > > +	mode |= S_IFREG;
> > > +	open_flag |= __O_REGULAR;
> > > +
> > > +	error = lookup_noperm_common(last, parent->dentry);
> > > +	if (error)
> > > +		return ERR_PTR(error);
> > > +
> > > +	file = alloc_empty_file(open_flag, current_cred());
> > > +	if (IS_ERR(file))
> > > +		return file;
> > > +
> > > +	nd.path = *parent;
> > > +	nd.last = *last;
> > > +	nd.flags = LOOKUP_OPEN;
> > > +	if (open_flag & O_CREAT) {
> > > +		nd.flags |= LOOKUP_CREATE;
> > > +		if (open_flag & O_EXCL)
> > > +			nd.flags |= LOOKUP_EXCL;
> > > +	}
> > > +	op.open_flag = open_flag;
> > > +	op.mode = mode;
> > > +	dentry = lookup_open(&nd, file, &op);
> > > +
> > > +	if (IS_ERR(dentry))
> > > +		return ERR_CAST(dentry);
> > > +
> > > +	if (d_really_is_negative(dentry)) {
> > > +		error = -ENOENT;
> > > +	} else if (!(file->f_mode & FMODE_CREATED) && (open_flag & O_EXCL)) {
> > > +		error = -EEXIST;
> > > +	} else if ((dentry->d_inode->i_mode & S_IFMT) != S_IFREG) {
> > > +		switch (dentry->d_inode->i_mode & S_IFMT) {
> > > +		case S_IFDIR:
> > > +			error = -EISDIR;
> > > +			break;
> > > +		case S_IFLNK:
> > > +			error = -ELOOP;
> > > +			break;
> > > +		case S_IFBLK:
> > > +		case S_IFCHR:
> > > +			error = -ENODEV;
> > > +			break;
> > > +		case S_IFIFO:
> > > +		case S_IFSOCK:
> > > +		default:
> > > +			error = -EFTYPE;
> > > +			break;
> > > +		}
> > > +	} else if (!(file->f_mode & FMODE_OPENED)) {
> > > +		nd.path.dentry = dentry;
> > > +		error = vfs_open(&nd.path, file);
> > > +	}
> > > +	dput(dentry);
> > > +
> > > +	if (error)
> > > +		return ERR_PTR(error);
> > > +	return no_free_ptr(file);
> > > +}
> > > +EXPORT_SYMBOL_FOR_MODULES(vfs_lookup_open, "nfsd");
> > > +
> > >  static inline bool trailing_slashes(struct nameidata *nd)
> > >  {
> > >  	return (bool)nd->last.name[nd->last.len];
> > > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > > index ebe6e29f7e93..86d657b24fc6 100644
> > > --- a/include/linux/namei.h
> > > +++ b/include/linux/namei.h
> > > @@ -97,6 +97,9 @@ struct dentry *start_creating_dentry(struct dentry *parent,
> > >  struct dentry *start_removing_dentry(struct dentry *parent,
> > >  				     struct dentry *child);
> > >  
> > > +struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
> > > +			     int open_flag, umode_t mode);
> > > +
> > >  /* end_creating - finish action started with start_creating
> > >   * @child: dentry returned by start_creating() or vfs_mkdir()
> > >   *
> > > -- 
> > > 2.50.0.107.gf914562f5916.dirty
> > 
> > So I am not really familiar with the nsfd backend where this function will be put
> > to use, but I imagine you need the fileserver to mirror operations on the client.
> > And since from within the kernel we don't do syscalls, we need this function to
> > mimic the client syscall path and call into the actual underlying fs. Is that
> > more-or-less correct?
> 
> more or less.
> 
> > 
> > So then the rights checking happens on the properly authenticated client-end? Or
> > does nsfd have another mechanism for that?
> 
> Both the client and server check rights.  The server because it cannot
> trust the client, the client so it doesn't waste time trying things that
> aren't permitted.
> 
> > 
> > I just want to ensure that using this function cannot bypass the sticky directory
> > semantics, as that now is the task of do_open(), which this skips of course.
> > If that is OK, this function LGTM :)
> 
> It appears that may_create_in_sticky() is only ever called AFTER the
> file has been created.  do_open() is called after open_last_lookups(),
> which calls lookup_open(), which calls ->create or ->atomic_open().
> 
> I wonder if anyone has tested that code. Maybe I should...
> 

Yeah, that is the correct behavior, I think. may_create_in_sticky() is a bit of
a misnomer, really it should be something like may_o_creat_in_sticky() or even
may_open_in_stick(). Afaik it's optional hardening that really should be the
responsibility of user space: it's to prevent file squatting whereby in, for instance,
/tmp an attacker predicts what file a privileged user will O_CREAT open. In that case,
if the user application didn't use O_EXCL, the attacker may symlink it in advance to
say /etc/passwd, or do other nasty things.

I presume there was once discussion about whether this should be kernel responsibility,
and that's where this line is about in link_path_walk():

		nd->dir_mode = 0; // short-circuit the 'hardening' idiocy

Or is that not what you meant?

> Thanks for spotting that.  It doesn't change the validity if this
> present patch series though, it is a separate pre-existing issue.
> 

Right. I was just curious how that behavior is handled in the nfsd path, but you
are right that any issue there is pre-existing as dentry_create() also does not
do anything special for sticky dirs there.

I'll review the patch tomorrow, it's 2AM here :)

Best,
Jori.
