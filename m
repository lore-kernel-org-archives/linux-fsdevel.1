Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A765357D10
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783423619; cv=none; b=Sz3etHJn6F/sW/iVS36PpwtywXDMM/a5wXQKsorsLprc6uhRpzF58EJJ3NQ9ARF3hC1JfC0rUgh9ZCRys5WVtsb56vgAF6BlxhhoBGpGg41P5tROf/kXvXz7VjeX+/IKIUvzFvazOBr39P1Mb5VlV8aHQ3nyO/tRwq386kqngCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783423619; c=relaxed/simple;
	bh=0hG5KmJW7gTj64FLw23Xmo1PpbEoDq4btppErXGHpDw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=niT8DT3nupe/UV0EMG4GdekoHOe3VrvjpAK1tKu/TzfpfhasnZwF/YSinOqLi5KOCOAGMiu+ipUQeTn9yycNDLFTdg5+fuVVJf1xPr1bBvKmRL2YlWWoPuPOHN8DLEsPtFIO54lq7OTb4rUIoF2z52hVovoufb8br787beFH0PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3zC9plk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3zC9plk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A841F000E9;
	Tue,  7 Jul 2026 11:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783423617;
	bh=Q1xAiFCwUpSQ4gYCqn7Qy1LgkfQCD8xtZPeH/VFu1Vk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=d3zC9plkBKqJ1vh7qQmhmqe+cDBL1CKeDxmQZs3A16LWjhUp1SEmgd2ksrNTyLd81
	 Qo9EVNbO5gd8jNpxdkFqsyFDsEhLvYjuaScjJnW6JLzsas8x96nFkhJoTn8BFbKE4a
	 i+mGRF85oVgAv3LQkrZ065hSGP6qP+QZ/6yxYvqa0H0lbpHXRcXiEoyUIT5bjvOYbm
	 EaRLHgh0v+Fs36FTcXXNMAAsy+s50SV9913Nn98HIWEthtyYwftiYUQf9zT0JQmc39
	 v07AlRGtOGsmgDYkjVCcDDRyDKi7WO/Q7uxXM+jhwDC8ghzdbXT7/A5FBjN9gmZq9W
	 kFpGOZo3Fpsow==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/3] VFS: add vfs_lookup_open() for nfsd
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jori Koolstra <jkoolstra@xs4all.nl>
In-Reply-To: <178337717986.27465.590457544263750759@noble.neil.brown.name>
References: <20260705235447.1322365-1-neilb@ownmail.net>
 <20260705235447.1322365-4-neilb@ownmail.net>
 <20260706-steril-fragil-worunter-f48995ef1b29@brauner>
 <178337717986.27465.590457544263750759@noble.neil.brown.name>
Date: Tue, 07 Jul 2026 13:26:54 +0200
Message-Id: <20260707-efeubewachsen-sukzessiv-innig-290e94d05ca8@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4638; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0hG5KmJW7gTj64FLw23Xmo1PpbEoDq4btppErXGHpDw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT5PGroqGn84pT7qkRXsrdVujukmrFIttm5aj8DQwnjG
 +bll+I6SlkYxLgYZMUUWRzaTcLllvNUbDbK1ICZw8oEMoSBi1MAJtKuyPC/rN9gx7mHf75eZD35
 91n3E0neKYa7jhUsubfltf3Pe2yVigz/bE6aXVvlc8z+oZZrUm9uUZ5JyAw3tVcTfv5ZVG/w9YI
 3KwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-07 08:32 +1000, NeilBrown wrote:
> On Mon, 06 Jul 2026, Christian Brauner wrote:
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
> > > 
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > >
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 1ca738401afa..002ffae7083d 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -4568,6 +4568,76 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
> > > + * functionality open_last_lookups() for in-kernel users, particularly
> > > + * nfsd.
> > > + * It uses ->atomic_open or ->lookup / ->create / ->open as appropriate.
> > > + *
> > > + * Returns: the opened struct file, or an error.
> > > + *     Caller should check that the file opened is regular,
> > > + *     if something else was found, an O_PATH file is provided.
> > > + *     Caller should validate FMODE_CREATED if O_EXCL was requested.
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
> > > +	WARN_ONCE(mode & !S_IALLUGO, "mode must only have permission bits");
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
> > > +	} else if (!(file->f_mode & FMODE_OPENED)) {
> > > +		nd.path.dentry = dentry;
> > > +		if (!d_is_reg(dentry))
> > > +			/*
> > > +			 * allow caller to see dentry and choose
> > > +			 * correct error code
> > > +			 */
> > > +			file->f_flags |= O_PATH;
> > > +		error = vfs_open(&nd.path, file);
> > 
> > Imho, that really throws a wrench into this function. I'd rather just
> > fail with well-known error codes in that case:
> > 
> > /* directory */ -> EISDIR
> > /* device */    -> ENODEV
> 
> What if the dentry is a symlink?  May ELOOP could be used?

Sure.

> > 
> > Also, why does the caller need to know details here? Because of the
> > O_DIRECTORY work? But even so, EFTYPE would be enough afaict, I think?
> 
> fs/nfsd/nfs4proc.c:
> 
> 
> 	if (S_ISREG(mode))
> 		return nfs_ok;
> 	if (S_ISDIR(mode))
> 		return nfserr_isdir;
> 	if (S_ISLNK(mode))
> 		return nfserr_symlink;
> 
> 	/* RFC 7530 - 16.16.6 */
> 	if (minor_version == 0)
> 		return nfserr_symlink;
> 	else
> 		return nfserr_wrong_type;
> 
> The spec requires specific errors which are different between versions
> and S_ISLNK seemed problematic.  I thought that keeping the VFS
> completely out of that issue seemed best: simply return the dentry found
> and let the caller handle it.  But if you are OK with ELOOP for symlinks
> (and EFTYPE for sockets and named pipes), or can suggest an alternate
> error code, I'm happy to work with that.

I think ELOOP and EFTYPE is fine. I just don't really like that we open
something that is of the wrong type - even with O_PATH. That seems ripe
for accidental bugs imho.

