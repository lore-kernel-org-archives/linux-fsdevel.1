Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B706740A920
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342863; cv=none; b=pMTW/OYoQVAPlU17BpVONH98kU7QXPeqXqUhb721Fr1rShwLLbTNrEmIuOOIOxwpADdh/OvLXYr+CggoIGV51RnqzSxZaT8fwjtYo6BdJUkTJyLOSWt+B//JdJVCeP9sX2MmaYTBKI/JFREWMuF/V67y8az7HurtAWFXMOvlaXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342863; c=relaxed/simple;
	bh=sl6VDuh8BdF3MsVCBWByEbX0zXPllscUOwwlG1LlN9o=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=TeMBEC1b58qjejhwJhQQ3zWgekDpTI7JRgFTbq1v7kCvc18l0KwIRhjU09D+4FLkHO4r7Qhy4bamqozuhur0H9c2lY6pm2zmlh4pTAYAp3g4FJ3EKZe/xNVT70dFwjEVsXlwJOzlZzzSKseq3MWtfSNnz0koLKjMQJXLbxfDGO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e+73hHXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+73hHXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601E41F000E9;
	Mon,  6 Jul 2026 13:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342862;
	bh=4iNODe3qqirR5UcQ4gyY2lBKedzdJ3wQqWhjcni3rXw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=e+73hHXoLpLg5FlvAO5f12ljR22ztwLiwz+mL0cqu/c0ik8XSPu9uvxCmamY/JWpK
	 ElkeJ2Ov6PWTusr8nTe6eK+ZX+l95m5JypxR37TnYexF9mtZTq9ShpjiOhFBc9Jwz6
	 zQDOyhEUvTtNrXlkmINe1KGmkMxXcokD98C81DV+TLi0j5yBth5qf45an6NV4tSUs1
	 ArnPR29ji6E9AHYak7ryHOG4t16mqelsYZFQcO/nOPiSSUWHy0U3WTuiB95vcSxBXU
	 VUF++Hk+uIZG6Me2XdIguN2oFzFIYK+K3AzB+mbRafGYY7WzGDzbLnI8MB0Mu34Dw5
	 1KMbMz8HqZJag==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/3] VFS: add vfs_lookup_open()
From: Christian Brauner <brauner@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 Jori Koolstra <jkoolstra@xs4all.nl>
In-Reply-To: <20260703-sololauf-erheiterung-resozialisieren-5f2d4f5b791f@brauner>
References: <[PATCH 0/3] VFS: replace dentry_create>
 <20260702111529.3559835-1-neilb@ownmail.net>
 <20260702111529.3559835-4-neilb@ownmail.net>
 <20260703-sololauf-erheiterung-resozialisieren-5f2d4f5b791f@brauner>
Date: Mon, 06 Jul 2026 15:00:58 +0200
Message-Id: <20260706-campieren-denken-fanatiker-bc2867728dee@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3070; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sl6VDuh8BdF3MsVCBWByEbX0zXPllscUOwwlG1LlN9o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR5L+fet/fhvpNX4wVKf4jw/JOu/KbaIzQv8+PE95vXC
 8dFfOF60VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRZRaMDPey3Fhu3Zn8TFc2
 fevrg9tvZWeFn9gTtzjd4oIJs3lF7DuGv8Jb9t/0v9apkT6nZlEN/7KvpYVnu/ZP/tx7WuDRuyT
 BucwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-03 11:48 +0200, Christian Brauner wrote:
> > vfs_lookup_open() is a limited version of lookup_open() which is
> > exported for nfsd to use - to replace dentry_create().
> > 
> > It is limited in that no filename is given (thus no auditing) and no
> > LOOKUP_ flags are passed.  A few "intent" LOOKUP flags are deduced from
> > the open flags.
> > 
> > Signed-off-by: NeilBrown <neil@brown.name>
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index cb33a01d16eb..737c4b2422dc 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4562,6 +4562,65 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
> 
> You should assert that either mode_t mode doesn't container S_IFMT or
> that it contains S_IFREG. WARN_ON_ONCE() would be appropriate here since
> it's not really a fast path.
> 
> > +	dentry = lookup_open(&nd, file, &op);
> > +
> > +	if (IS_ERR(dentry))
> > +		return ERR_CAST(dentry);
> > +
> > +	if (d_really_is_negative(dentry)) {
> > +		error = -ENOENT;
> > +	} else if (!(file->f_mode & FMODE_OPENED)) {
> > +		nd.path.dentry = dentry;
> > +		error = vfs_open(&nd.path, file);
> > +	}
> > +	dput(dentry);
> > +
> > +	if (error)
> > +		return ERR_PTR(error);
> > +	return no_free_ptr(file);
> > +}
> 
> Afaict nfs is compilable as a module so this needs a symbol export.
> Since this is for consumption by nfs only it would be prudent to use:
> 
> EXPORT_SYMBOL_FOR_MODULES(vfs_lookup_open, "WHATEVER_THE_MODULE_THING_IS");
> 
> so it can only be consumed by nfs.

I'm marking this as expecting a new revision btw. Just so that we don't
get our wires crossed.

