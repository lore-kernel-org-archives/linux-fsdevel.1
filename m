Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8B73EFD34;
	Tue,  2 Jun 2026 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415104; cv=none; b=tb8qvSz+cKb1Rc5pOwsYUHBbQN5a/e+xsS5I61IvEtPX/txO35ituLfosPKm33LfG8BczvTGwySRTnHNd5sNBYCF9cSOkC4HhDbWapW4548YaKReY/Rqs0X7mpj0hI/7tTsZkuG9OlB7WUS7lXjUV5Q+sNIwBe4JpZL0S6i0gb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415104; c=relaxed/simple;
	bh=Ad8ctUw19U33eZRLQv6jX6givFeCa+EQ0vxn/qE2kpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdI48R5UHuhMbJXw1+X/2SK00hdNr8Z408i039FyW5G/IQl17jeuVQiEmE+IBGDpiOwY+dLvAuVYgMfD5qem0ZYDQ07dHsklBF+jOTaavI3YuC9XBFeFasrg+q9GPzTUUfd4fbORC1nzF2x4xvaq8excqvpSZ593igraLp3vto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPLdIBp9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPLdIBp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606E21F00898;
	Tue,  2 Jun 2026 15:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780415103;
	bh=jYAfRc4w7pjvHep0fX2Kab5Txt7xYAxYZidqFmSZQ+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aPLdIBp9RoIe7Ztx/i4Jp4laOcFjyIHA0IO5eXuZCLL4tkqLGe7ugYZGW1iZGm9b9
	 kcy2lmuTPtjn4CZzWZDL96ZeoMCUnZzW3RYAYE8jLRrJ4R/5uANnAuvfeJ7KFmzMX3
	 zi988kFqAgzMrT2hA0PwKK9RDauKpSN0mB69kaKZW29ccMYxIRrty9F1nyOvYw/tsc
	 DJrBFFw0wthf/kRp+2JKP3vgHiHDuKzoUTnY+TxcZQhRAh9MrObQ4waF+BM7CkMPtz
	 BKyaNhBRkBkU2i/t5fxDAANJMKV612273AbNmPcADQAaEncYzRojO+QM0cw2XrCsvP
	 I/GaLOhTSsKyA==
Date: Tue, 2 Jun 2026 17:44:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, cmirabil@redhat.com
Subject: Re: [RFC PATCH v5 1/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <20260602-sofern-filmpreis-erfordern-63998d3af067@brauner>
References: <20260525202937.466497-1-jkoolstra@xs4all.nl>
 <20260525202937.466497-2-jkoolstra@xs4all.nl>
 <177986687451.3379282.8177801680240137022@noble.neil.brown.name>
 <1825098847.140203.1780349158954@kpc.webmail.kpnmail.nl>
 <178035470365.2923901.16027569586235650310@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <178035470365.2923901.16027569586235650310@noble.neil.brown.name>

On Tue, Jun 02, 2026 at 08:58:23AM +1000, NeilBrown wrote:
> On Tue, 02 Jun 2026, Jori Koolstra wrote:
> > > Op 27-05-2026 09:27 CEST schreef NeilBrown <neilb@ownmail.net>:
> > >
> > > > @@ -1268,6 +1269,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
> > > >  	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
> > > >  
> > > >  	if (flags & O_CREAT) {
> > > > +		if ((flags & O_DIRECTORY) && (acc_mode & MAY_WRITE))
> > > > +			return -EISDIR;
> > > 
> > > It seems odd that the MAY_WRITE test is only performed for O_CREAT.
> > > Shouldn't any open of O_DIRECTORY|O_WRONLY fail, and shouldn't the one
> > > test catch both create and non-create cases?
> > > 
> > 
> > I get your point, it does look odd. But AFAIS O_DIRECTORY|O_WRONLY is currently only blocked
> > after path resolution and final lookup. So that was the behavior I tried to keep. On the
> > other hand, right now O_DIRECTORY|O_CREAT is already blocked in build_open_flags().
> 
> I see that currently O_WRONLY for directories is only blocked in
> may_open() which happens after we have the inode for the target, so
> after any create.

Yes, that's not acceptable.

> So I agree that we need to put something in build_open_flags() which
> happens much earlier before path-walk even starts.
> I think it would be best to always block an O_WRONLY/O_RDWR combined
> with O_DIRECTORY.  It can never succeed so there is no point in even
> starting the path-walk.

Yes, I agree. This would change error codes but I don't think it
matters:

* O_WRONLY | O_DIRECTORY on non-directory -> ENOTDIR
* O_WRONLY | O_DIRECTORY on     directory -> EISDIR

I don't think that really matters and we should be able to collapse this
to ENOTDIR.

> But I too would like to know what Christian or Al think.
> 
> > 
> > But if that is true, and you have atomic_open() defined for your filesystem, then you
> > can lookup and open a directory with O_DIRECTORY|O_WRONLY, while it fails with EISDIR later
> > (if the fs atomic_open() does not error on O_DIRECTORY|O_WRONLY, which I would guess it
> > mostly does). It will then fput_close() the file, so there is no leak, but I don't think
> > that is wanted behavior.
> > 
> > @Christian, what do you think?
> > 
> > > 
> > > >  		op->intent |= LOOKUP_CREATE;
> > > >  		if (flags & O_EXCL) {
> > > >  			op->intent |= LOOKUP_EXCL;
> > > > diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
> > > > index e4295a5b55b3..ec8c54c91261 100644
> > > > --- a/fs/smb/client/dir.c
> > > > +++ b/fs/smb/client/dir.c
> > > > @@ -526,6 +526,9 @@ int cifs_atomic_open(struct inode *dir, struct dentry *direntry,
> > > >  	if (unlikely(cifs_forced_shutdown(cifs_sb)))
> > > >  		return smb_EIO(smb_eio_trace_forced_shutdown);
> > > >  
> > > > +	if ((oflags & O_MKDIR_MASK) == O_MKDIR_MASK)
> > > > +		return -EINVAL;
> > > > +
> > > >  	/*
> > > >  	 * Posix open is only called (at lookup time) for file create now. For
> > > >  	 * opens (rather than creates), because we do not know if it is a file
> > > > diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
> > > > index 42bedc4ec7af..aef5ca6730be 100644
> > > > --- a/fs/vboxsf/dir.c
> > > > +++ b/fs/vboxsf/dir.c
> > > > @@ -318,6 +318,9 @@ static int vboxsf_dir_atomic_open(struct inode *parent, struct dentry *dentry,
> > > >  	u64 handle;
> > > >  	int err;
> > > >  
> > > > +	if ((flags & O_MKDIR_MASK) == O_MKDIR_MASK)
> > > > +		return -EINVAL;
> > > > +
> > > >  	if (d_in_lookup(dentry)) {
> > > >  		struct dentry *res = vboxsf_dir_lookup(parent, dentry, 0);
> > > >  		if (res || d_really_is_positive(dentry))
> > > > diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> > > > index a332e79b3207..e31f3a57f07c 100644
> > > > --- a/include/linux/fcntl.h
> > > > +++ b/include/linux/fcntl.h
> > > > @@ -12,6 +12,8 @@
> > > >  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> > > >  	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> > > >  
> > > > +#define O_MKDIR_MASK	(O_CREAT | O_DIRECTORY)
> > > > +
> > > >  /* List of all valid flags for the how->resolve argument: */
> > > >  #define VALID_RESOLVE_FLAGS \
> > > >  	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
> > > > -- 
> > > > 2.54.0
> > > > 
> > > > 
> > > > 
> > > 
> > > Thanks,
> > > NeilBrown
> > 
> > There is another point, I maybe should have mentioned in the cover letter: I have not attempted
> > to handle dangling symlinks for O_MKDIR. Not because I think they are a great idea (as Aleksa
> > has mentioned, but I am not very familiar with the dragons it entails), but I wanted to discuss
> > what behavior we want in this case. Do we say that we never do a mkdir after following a lookup
> > last symlink? I don't think that state is even recorded right now.
> 
> I think the state might be recorded in nd->depth.  But you probably
> don't want to use that directly.  Maybe forcing LOOKUP_FOLLOW to be
> cleared if O_CREAT|O_DIRECTORY is set would be good.  But what would
> stop you opening an existing directory through a symlink....
> 
> Probably we need a clear statement of intended semantics which we can
> review, agree on, then implement.  Have you looked at preparing a patch
> for man-pages to document the change in behaviour for openat etc?

Ugh, dangling symlinks. Actually, scratch that: Ugh, symlinks. So
O_CREAT without O_NOFOLLOW allows you to create the target of a dangling
symlink iirc. I always forget that. I think this is a very subtle bug
and maybe - with both eyes closed - a feature at times.

We should straighten the behavior for O_DIRECTORY | O_CREAT and we
agreed on that during LSFMM. It would be nice if we could get away with
simply implying O_NOFOLLOW but I think you're right, Neil, that this
prevents a valid O_CREAT | O_DIRECTORY on an existing directory which we
can't do. Makes this kind of a pointless excercise.

But this shouldn't be all that crazy to do right. Using the O_CREAT as
an _example_ for what we'd need:

    fs: refuse O_CREAT through a dangling symlink

    open(O_CREAT) without O_EXCL follows a trailing symlink and, when the
    symlink target does not exist, creates it.  Refuse to create through a
    dangling symlink instead.

    In lookup_open() a negative target reached with nd->depth > 0 was
    arrived at by following a trailing symlink; since the dentry is negative
    the symlink is dangling. Set create_error to -ELOOP in that case.
    Reusing the existing create_error path strips O_CREAT for both the
    generic and ->atomic_open create paths and only reports the error when
    the target is actually negative, so opening an existing target through a
    symlink, interior symlinks, and O_EXCL (which never follows the trailing
    link) are all unaffected.

    Hastily-Cobbled-Together-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/namei.c b/fs/namei.c
index c7fac83c9a85..d20bbcc7e8d3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4468,6 +4468,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
                                                    dentry, mode);
                else
                        create_error = -EROFS;
+               /* refuse to create through a dangling (trailing) symlink */
+               if (unlikely(nd->depth) && !create_error)
+                       create_error = -ELOOP;
        }
        if (create_error)
                open_flag &= ~O_CREAT;

It can't be that easy...
