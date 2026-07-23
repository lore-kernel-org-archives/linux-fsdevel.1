Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36483184
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784765652; cv=none; b=JtWc4FtrV/BzGWOWzCZVnzb6kUTjCt7zhsZYZHeC2ALNt8X+lmNTbqbBm8dOLz1EZBBBv4kF25PaL792IlgE0NHx6+PWfzAkQsgWOtYPf/peepYkadkak7HRBsRNvTJK91nkFyydZUo4Lm9XleQkK5bF5P2FtUqcWELbb2QY3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784765652; c=relaxed/simple;
	bh=2XTbTi5Zm4S9FRYT4DeBfe1YYhgQReFoUsCq0qaTcHA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=aD2O2AjgGdcMDFqHfKAECHGrAvhtzSWEfvX/61I4WDGMekIPbGK2t+pp/eCzDBhrrPeIuKquePMem7ZZvZq0CGGs2b78paZWu+9N9uBfVR0j5rELw/mUvJTaMWfwAJhQ1E1S7QKd124+NIMl9uowEl5FcCUOAyN3a3l64oXJ0k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=UuCt133+; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="UuCt133+"
X-KPN-MessageId: 6bc767c5-862b-11f1-9e8e-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 6bc767c5-862b-11f1-9e8e-005056999439;
	Thu, 23 Jul 2026 02:14:07 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 6bc66fd6-862b-11f1-9b0e-00505699693e;
	Thu, 23 Jul 2026 02:14:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=mqF9vZf5BuYWQNl7WE2qEzylxLA/m/m07puWMkcjyeQ=;
	b=UuCt133+TTVqSxXeT1UzdKje4GAC++NEZBqqRlkAA/gp1b/0MsnlKldZ0zDPvyYtyhKPBS9mOpWds
	 OHEVakB1KHzqEHEyEHscj9vPfnhJSsAYMkfDcIc7fZ8XbqN/2pI0jc79bw5SwyqncaK/X6A/sONBsZ
	 JWBWLyos/BeWCdHQNeVeWoO0fbwvzDzGqGnecXMT/VIxN4XBCGL7Q36nbgrYytqtr++4ydmpeQNyah
	 Sn3iMOg2laqA6H2083JFh43mOzI/aTeUxYW51NX3JhAyir6AYMTsq8+uO5yM1MBrqhOvCaq7XXIQLb
	 PPAypIVI2ikplh/N2TOuO5hGbqsm7LA==
X-KPN-MID: 33|qA7wXIxngIPVaX3Gphd+9uSuOa0nz2xVvbPEdeAkItTFaDXBK5+dBhKI2H5B8UU
 ChYlXYfk2F6EvviicdVkdhHT6nmSYKPbb31s/jQVfon0=
X-CMASSUN: 33|A8/+E4F2KzRYCtqGFqyS3H0M+0nkucgHCszhJUsPJcGsFgpec42+F0quBBQNTnz
 YsNYSOgvUX509UksRX6p/JQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 6bbc48fd-862b-11f1-8edb-00505699eff2;
	Thu, 23 Jul 2026 02:14:07 +0200 (CEST)
Date: Thu, 23 Jul 2026 02:14:07 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Message-ID: <1034153359.215360.1784765647437@kpc.webmail.kpnmail.nl>
In-Reply-To: <178459188006.3371781.5620319924458142615@noble.neil.brown.name>
References: <20260714230534.776886-1-neilb@ownmail.net>
 <20260714230534.776886-4-neilb@ownmail.net>
 <21817263.1168614.1784151799976@kpc.webmail.kpnmail.nl>
 <178415489698.3371781.5121934606972521996@noble.neil.brown.name>
 <1697164687.1184851.1784159287934@kpc.webmail.kpnmail.nl>
 <178432915017.3371781.13946671241977454321@noble.neil.brown.name>
 <381790643.1478590.1784412802571@kpc.webmail.kpnmail.nl>
 <178459188006.3371781.5620319924458142615@noble.neil.brown.name>
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


> Op 21-07-2026 01:58 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> On Sun, 19 Jul 2026, Jori Koolstra wrote:
> > Comments between the lines.
> > 
> > > Op 18-07-2026 00:59 CEST schreef NeilBrown <neilb@ownmail.net>:
> > > 
> > >  
> > > On Thu, 16 Jul 2026, Jori Koolstra wrote:
> > > > > Op 16-07-2026 00:34 CEST schreef NeilBrown <neilb@ownmail.net>:
> > > > > 
> > > > >  
> > > > > On Thu, 16 Jul 2026, Jori Koolstra wrote:
> > > > > > > Op 15-07-2026 01:04 CEST schreef NeilBrown <neilb@ownmail.net>:
> > > > > > > 
> > > > > > >  
> > > > > > > From: NeilBrown <neil@brown.name>
> > > > > > > 
> > > > > > > vfs_lookup_open() is a limited version of lookup_open() which is
> > > > > > > exported for nfsd to use - to replace dentry_create().
> > > > > > > 
> > > > > > > It is limited in that no filename is given (thus no auditing) and no
> > > > > > > LOOKUP_ flags are passed.  A few "intent" LOOKUP flags are deduced from
> > > > > > > the open flags.
> > > > > > > 
> > > > > > > If a non-regular file is found and appropriate error is returned and no
> > > > > > > file is opened.
> > > > > > > 
> > > > > > > Signed-off-by: NeilBrown <neil@brown.name>
> > > > > > > ---
> > > > > > >  fs/namei.c            | 96 +++++++++++++++++++++++++++++++++++++++++++
> > > > > > >  include/linux/namei.h |  3 ++
> > > > > > >  2 files changed, 99 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > > > > index cb33a01d16eb..630f93608224 100644
> > > > > > > --- a/fs/namei.c
> > > > > > > +++ b/fs/namei.c
> > > > > > > @@ -4562,6 +4562,102 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> > > > > > >  	goto out;
> > > > > > >  }
> > > > > > >  
> > > > > > > +/**
> > > > > > > + * vfs_lookup_open - open and possibly create a regular file
> > > > > > > + * @parent: directory to contain file
> > > > > > > + * @last: final component of file name
> > > > > > > + * @open_flag: O_flags
> > > > > > > + * @mode: initial permissions for file
> > > > > > > + *
> > > > > > > + * Open a file after lookup and/or create.  This provides similar
> > > > > > > + * functionality open_last_lookups() for non-VFS users, particularly
> > > > > > > + * nfsd.
> > > > > > > + * It uses ->atomic_open or ->lookup / ->create / ->open as appropriate.
> > > > > > > + *
> > > > > > > + * If the fs object found is not a regular file then an error is returned.
> > > > > > > + * In some cases, related errors are repurposed so that the caller can
> > > > > > > + * determine the type of file found from the error.
> > > > > > > + * -EISDIR : a directory was found
> > > > > > > + * -ELOOP  : a symlink was found
> > > > > > > + * -ENODEV : a block or character device special file was found
> > > > > > > + * -EFTYPE : any other non-regular file was found, such as FIFO or SOCK.
> > > > > > > + *           or ->atomic_open responded to __O_REGULAR.
> > > > > > > + *
> > > > > > > + * Returns: the opened struct file, or an error.
> > > > > > > + */
> > > > > > > +struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
> > > > > > > +			     int open_flag, umode_t mode)
> > > > > > > +{
> > > > > > > +	struct file *file __free(fput) = NULL;
> > > > > > > +	struct nameidata nd = {};
> > > > > > > +	struct open_flags op = {};
> > > > > > > +	struct dentry *dentry;
> > > > > > > +	int error = 0;
> > > > > > > +
> > > > > > > +	WARN_ONCE(mode & ~S_IALLUGO, "mode must only have permission bits");
> > > > > > > +	WARN_ONCE(open_flag & ~(O_ACCMODE|O_CREAT|O_EXCL|O_TRUNC|__O_REGULAR),
> > > > > > > +		  "open_flag has unsupported flags");
> > > > > > > +
> > > > > > > +	mode |= S_IFREG;
> > > > > > > +	open_flag |= __O_REGULAR;
> > > > > > > +
> > > > > > > +	error = lookup_noperm_common(last, parent->dentry);
> > > > > > > +	if (error)
> > > > > > > +		return ERR_PTR(error);
> > > > > > > +
> > > > > > > +	file = alloc_empty_file(open_flag, current_cred());
> > > > > > > +	if (IS_ERR(file))
> > > > > > > +		return file;
> > > > > > > +
> > > > > > > +	nd.path = *parent;
> > > > > > > +	nd.last = *last;
> > > > > > > +	nd.flags = LOOKUP_OPEN;
> > 
> > I am not so familiar with the audit stuff, but you don't init nd->name here. Will
> > this possibly lead to a new AUDIT_TYPE_UNKNOWN type struct audit_names for every
> > invoke of vfs_lookup_open? See __audit_inode() function.
> 
> I'm not familiar with it either, but I reasoned that as audit_inode()
> clear handles a name of NULL, then it is safe to pass that name.  And
> that is the best we can do from nfsd.
> 
> > 
> > That is also a bit of a pain-point here in general. If ever lookup_open() was changed
> > to use more of nd, then you must remember to initialize the field here as well, which
> > makes this function quite fragile.
> 
> All the fields that I don't explicitly initialise get initialised to
> null where nd is declared "nd = {}".  So it should be fairly safe.
> 
> > 
> > One way to resolve that is to pass everything as argument to lookup_open() instead
> > of through nd, but that is a bit ugly. What do you think?
> 
> An earlier version of my patch did exactly that but it seemed
> unnecessarily clumsy.
> I don't think it is too much to expect that when someone adds a field to
> nd, they check to make sure it is properly initialised everywhere.
> 

I thought about it a bit more, and I do think I may be too pedantic. It is
probably not too much to ask of anyone changing lookup_open() to make further
use of nd, that they look into the callers of lookup_open() and what they do
to initialize it. There are only two callers after all. So, I am OK with it.

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
