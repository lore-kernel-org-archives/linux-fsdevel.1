Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229D3A9013
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783375828; cv=none; b=RfHcJNfdMa+Ll4uZSZhk2i4Bg/m4nDVvwK3rAAo7pDLD7Cg+ioxMDoIwCk5bO1C5xSfpYQlaOYB6gVF+WHPKk+Gi0M4DDTFy5kMQ78yQDqOU4XAth8a2sqkAqQDomXGumgwrwYpbdscyAKMn39eD7FacdsKQCyAbWcaBnwmxZ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783375828; c=relaxed/simple;
	bh=bWal4tda9gP/2bfQfOevnJOENyFr15IVRN3Qf4Dzz3g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ZCyjastvto46IYsOcd7605JHXclylb02p9tWY8tzBpTqSakpOjh16nBCZm8tlP3702+bqkMH3ojndu0UdQ/v+S7ttb4GU+h6VqwpbxYRJSUHWkQFT+94ps7DPWPcVF4XG1mey32lkgwx8ls0nXlj+QSW4dUwtq/Dz+mayoAyQWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=NVIMNSqf; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="NVIMNSqf"
X-KPN-MessageId: 78bb1a12-7987-11f1-bfba-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 78bb1a12-7987-11f1-bfba-00505699b430;
	Tue, 07 Jul 2026 00:10:17 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 78ba2283-7987-11f1-b2fe-0050569977a2;
	Tue, 07 Jul 2026 00:10:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=UNQ8WJpi2ryzyBfIjlBVgT3cvMuDODARX54BM6UC+Z4=;
	b=NVIMNSqfL0egWMQKf+vmVxFaJMmg0+H6t8HBI3K6amVRvXnYLnW55tFQTt2GWaz721BueeS8V4WOQ
	 rJiqOjXTBsNJ//JOlkDVl6zB8sGggHM7+ItvgKW1R0BJ1hw5ccjTOz9Qa7Y5TGd+USgn3FAv198ebr
	 hdGYPjH1Hh+20h/OjL/SjieRs2mk0ZrPMVyXG4XWxyh8M/qlZrBuyWlekVqApO6CS6tfOi9x8FFAUQ
	 8rIZpRRntRudd3LwL3Y/69zeo8THLh4dSIiMwtZfRsjZ41LBeUUpjtX+EJNfJuaYXjWdEZRFaYIj9k
	 FDuNewyPjm0/XMVa88Y+BHuw61ZRf2Q==
X-KPN-MID: 33|nQGKXVHvONsZbAvoljBKhjz9A3taWBjzyuUhD+jTC7XlFwEvHx6ngmV/pa1vpiC
 0JRIKLXRErqPmoUSuD3lIfmr3YHTjoUxUN0XY9hmtv1A=
X-CMASSUN: 33|Jf8sE3uqAWNopZGHM5My1ZuLWUdGem7SqhJ5Ek92vve9XVAdPA6viALyuOUrfUr
 VfbdFpgAnOccUo4YyDYT6ZQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 78b4a1c8-7987-11f1-916a-005056995d6c;
	Tue, 07 Jul 2026 00:10:17 +0200 (CEST)
Date: Tue, 7 Jul 2026 00:10:17 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Message-ID: <1991496397.134753.1783375817781@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260706-steril-fragil-worunter-f48995ef1b29@brauner>
References: <20260705235447.1322365-1-neilb@ownmail.net>
 <20260705235447.1322365-4-neilb@ownmail.net>
 <20260706-steril-fragil-worunter-f48995ef1b29@brauner>
Subject: Re: [PATCH v2 3/3] VFS: add vfs_lookup_open() for nfsd
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


> Op 06-07-2026 15:33 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
>  
> > vfs_lookup_open() is a limited version of lookup_open() which is
> > exported for nfsd to use - to replace dentry_create().
> > 
> > It is limited in that no filename is given (thus no auditing) and no
> > LOOKUP_ flags are passed.  A few "intent" LOOKUP flags are deduced from
> > the open flags.
> > 
> > If a non-regular file is found, an O_PATH file is returned.  This allows
> > the caller to see what was found and to return an appropriate error
> > code.  However if ->atomic_open was used, it may return an error rather
> > then provide a dentry.
> > 
> > Signed-off-by: NeilBrown <neil@brown.name>
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 1ca738401afa..002ffae7083d 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4568,6 +4568,76 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> >  	goto out;
> >  }
> >  
> > +/**
> > + * vfs_lookup_open - open and possibly create a regular file
> > + * @parent: directory to contain file
> > + * @last: final component of file name
> > + * @open_flag: O_flags
> > + * @mode: initial permissions for file
> > + *
> > + * Open a file after lookup and/or create.  This provides similar
> > + * functionality open_last_lookups() for in-kernel users, particularly
> > + * nfsd.
> > + * It uses ->atomic_open or ->lookup / ->create / ->open as appropriate.
> > + *
> > + * Returns: the opened struct file, or an error.
> > + *     Caller should check that the file opened is regular,
> > + *     if something else was found, an O_PATH file is provided.
> > + *     Caller should validate FMODE_CREATED if O_EXCL was requested.
> > + */
> > +struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
> > +			     int open_flag, umode_t mode)
> > +{
> > +	struct file *file __free(fput) = NULL;
> > +	struct nameidata nd = {};
> > +	struct open_flags op = {};
> > +	struct dentry *dentry;
> > +	int error = 0;
> > +
> > +	WARN_ONCE(mode & !S_IALLUGO, "mode must only have permission bits");

Typo here.

> > +	error = lookup_noperm_common(last, parent->dentry);
> > +	if (error)
> > +		return ERR_PTR(error);
> > +
> > +	file = alloc_empty_file(open_flag, current_cred());
> > +	if (IS_ERR(file))
> > +		return file;
> > +
> > +	nd.path = *parent;
> > +	nd.last = *last;
> > +	nd.flags = LOOKUP_OPEN;
> > +	if (open_flag & O_CREAT) {
> > +		nd.flags |= LOOKUP_CREATE;
> > +		if (open_flag & O_EXCL)
> > +			nd.flags |= LOOKUP_EXCL;
> > +	}
> > +	op.open_flag = open_flag;
> > +	op.mode = S_IFREG | mode;
> > +	dentry = lookup_open(&nd, file, &op);
> > +
> > +	if (IS_ERR(dentry))
> > +		return ERR_CAST(dentry);
> > +
> > +	if (d_really_is_negative(dentry)) {
> > +		error = -ENOENT;
> > +	} else if (!(file->f_mode & FMODE_OPENED)) {
> > +		nd.path.dentry = dentry;
> > +		if (!d_is_reg(dentry))
> > +			/*
> > +			 * allow caller to see dentry and choose
> > +			 * correct error code
> > +			 */
> > +			file->f_flags |= O_PATH;
> > +		error = vfs_open(&nd.path, file);
> 
> Imho, that really throws a wrench into this function. I'd rather just
> fail with well-known error codes in that case:
> 
> /* directory */ -> EISDIR
> /* device */    -> ENODEV
> 
> Also, why does the caller need to know details here? Because of the
> O_DIRECTORY work? But even so, EFTYPE would be enough afaict, I think?
> 

If that is the reason it would be easier to just ban O_DIRECTORY from the
start here, if vfs_lookup_open() is meant to only ever open/create regular
files.

Is that the case, Neil?

Now that I think about it, I think you also want to restrict the O_* flags.
lookup_open() normally does not get passed __O_TMPFILE or O_PATH afaik, and
it would probably a bad idea to start passing it these flags. Maybe also don't
want to allow O_TRUNC.

> -- 
> Christian Brauner <brauner@kernel.org>
