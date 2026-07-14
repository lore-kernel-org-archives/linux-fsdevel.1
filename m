Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE044685E
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 12:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032136; cv=none; b=nBMDhYQ4t97tFJ1hlQI79FKulku64BWfXm8nrcrmnCSpT9jOMT1nBMwSneE9HG5Mbpoi9wYc5Bv0+dBCDrw32Q/ccGGCodV3YZf5C2hTEqxQePMeRUJ+3t74AR7Nqc08Rud1DqNUd2/7SHR5L2oCDIW/A/uXHr0lk00HDeLqhzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032136; c=relaxed/simple;
	bh=B6dgKwzNx3rWaNOxXsTiZEUVr03spoOo8mp3B1ItcWY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qiZsh9FByvKdzLeLartX4jy9OwpZM4LH65o2Pht81Ic4J4PJB3t/mbO6Oz8f5Xh7b/x4XOZUtSFOKk8iABfbjVzYbxlL8mN0/l49oshH2xKyASjzlna4MjQVQoaFvZntngtFzq1ted4ATU3jKdXiBx6DpCREtp6mui5T6tAxZoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=MH/3RHCV; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="MH/3RHCV"
X-KPN-MessageId: 9032a697-7f7f-11f1-bfba-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9032a697-7f7f-11f1-bfba-00505699b430;
	Tue, 14 Jul 2026 14:28:48 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 90315c0b-7f7f-11f1-b308-0050569977a2;
	Tue, 14 Jul 2026 14:28:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=YfV4LJIsaNH2A+E4UxJEYQ+IXsQ+NBQxN2Osz3jHw40=;
	b=MH/3RHCV62gbgH9/usPjeWMQZH3UVlpw8Wlj3n+pWdbJEbv3pYAje+tRe1XMIn3Xob3dahNmNSPwX
	 VEsjlTM1YU0q5aqkYAmXqM5PjhXd7cti/zfXp/RFqo+/TK7FlhRws8akzqvcJ7wvGWVLAYqbpiWTbZ
	 9vkM7uboUNZkQGHrQnr8pwas71pdSYOQ9QlP8oKQf31pGVoBd6m1lUxqP9f3MTegonCrERXX3kwdhO
	 n1Y4g5OwcXB32NB0Ohf+v4d1XDa2dq/5cx6OUKBJfrGyRN1NXGx7UC8YCKY3Fw22l8D5whoFf7OY78
	 jPIzDo1METWCZrGZTVhrn+JYOYDMzww==
X-KPN-MID: 33|aC4INLl+JSKq5CEUueeg9E9BLYWYGiskHv9uMmmrF7fmYrIfpF2Kky0SPkv9mKQ
 qryjhMPx3yAfQF5s263G7TnnLedRDur+nHpqUf5FY4lw=
X-CMASSUN: 33|w7yIYsU5l3ylaHWNWH3fX7WznMj5zp6jZl/j1pZS3jNcFVAFKkM50dY5l+rzhij
 C/O/VCTzH3dIUw3uA7VE8Ww==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh06 (cpxoxapps-mh06.personalcloud.so.kpn.org [10.128.135.212])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 90270bad-7f7f-11f1-916a-005056995d6c;
	Tue, 14 Jul 2026 14:28:48 +0200 (CEST)
Date: Tue, 14 Jul 2026 14:28:48 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Message-ID: <2091253759.1001623.1784032128121@kpc.webmail.kpnmail.nl>
In-Reply-To: <178397971669.3371781.14361088370957076736@noble.neil.brown.name>
References: <20260713060814.2849-1-neilb@ownmail.net>
 <20260713060814.2849-4-neilb@ownmail.net>
 <1899194169.820712.1783939194879@kpc.webmail.kpnmail.nl>
 <178397971669.3371781.14361088370957076736@noble.neil.brown.name>
Subject: Re: [PATCH v3 3/3] VFS: add vfs_lookup_open() for nfsd
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


> Op 13-07-2026 23:55 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> On Mon, 13 Jul 2026, Jori Koolstra wrote:
> > > Op 13-07-2026 08:05 CEST schreef NeilBrown <neilb@ownmail.net>:
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
> > > If a non-regular file is found, an O_PATH file is returned.  This allows
> > > the caller to see what was found and to return an appropriate error
> > > code.  However if ->atomic_open was used, it may return an error rather
> > > then provide a dentry.
> > 
> > Stale commit paragraph.
> 
> Thanks :-(
> 
> > 
> > > 
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > > ---
> > >  fs/namei.c            | 89 +++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/namei.h |  3 ++
> > >  2 files changed, 92 insertions(+)
> > > 
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index cb33a01d16eb..2143f759443a 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -4562,6 +4562,95 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
> > > + * In some cases, related errors are repurposed to so that the caller can
> > > + * determine the file of file found from the error.
> > > + * -EISDIR : a directory was found
> > > + * -ELOOP  : a symlink was found
> > > + * -ENODEV : a block or character device special file was found
> > > + * -EFTYPE : any other non-regular file was found, such as FIFO or SOCK.
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
> > > +	op.mode = S_IFREG | mode;
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
> > I think it would still be sensible to check the O_ flags being allowed to
> > be passed in. I get that nsfd is not going to do weird things, but if this
> > is a helper that may be used by other code too at some point (unaware of the
> > intricacies of lookup_open()) the context could help as we didn't go through
> > all the normal checks in build_open_flags().
> 
> So we allow
> 
>  O_ACCMODE|O_CREAT|O_EXCL|O_TRUNC
> 
> and should assert __O_REGULAR.
> 
> Thanks,
> NeilBrown
> 

Yes, sounds good. Keep in mind that vfs_open() does not handle truncate, it only
happens in do_open() in the open(2) path, so you must handle the actual truncation
back in the nfsd code. You are probably very aware of this, but just in case :)

__O_REGULAR is also only handled in do_open(), so it does nothing in namei.c right
now, still seems good to include it. I don't understand why the __O_REGULAR
implementation is so convoluted, but I haven't looked into it yet. I plan to do
that sometime soon.

Thanks,
Jori.
