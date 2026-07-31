Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE63F4DEF;
	Fri, 31 Jul 2026 10:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785492735; cv=none; b=bc/Hr45wYmAtnpmmbfpcPXRSCrHy20r/D8XHSbVa9bYfHWfHNitss8y7IxH7fZjDchH+maa4ld7fgQN5s1ODH/gYreC8gfUhSAMF8CS2sqM/nZ7zfBKCyfhtdyishX7dmk+P2zIoYjJhEzXFYUZxv0qFbsLJuWS2cAi5dL1K+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785492735; c=relaxed/simple;
	bh=dAak9ph0ZsJpRV65u3jSstM7ygDOLPppGvAAr1cv5eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsiPZ4/vC+6q+h5s89uW4ErwSg9kdOppgRJ18Wx1ltIoaeRsbTFZ3eSeNttT4sEboWvOmgWOWi3ta1SFe41eERHZUcBhAz9Jr8PGIjfm+a+VUx1HJ5YYftFCOCfPyhfVpWQv/I7V0QLl8JKl28OA6NJgcFT/d9tZYR/Vwjy0TvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHu64rtH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHu64rtH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A42C1F000E9;
	Fri, 31 Jul 2026 10:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785492719;
	bh=4baV+b1ofiNT9a9DtBQyDC8ub4a1kOAsXqvpmzfq1dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XHu64rtH6tblZkEbAbY7oORup/GbfcBkBeyDLnz5Qux0vaHuxsOoiACkWJG9UnmQ6
	 b/nf6r+5ooOJsnprZFRm0/Q0kiCvoOIxQpu1Tv+ymgWPWE5Pgyo5oumggy4WMS4m2H
	 a36ZQ8tj2yeujemgkTPQ9AvVPzffzY9eoV8/rCVkXmjrjRLaSz51nGD1SlPseR7Duy
	 NILdnsFbkVkILtqfjPUs5FqVUI9sjKfe6O7SpclhuuN9yt54FJPaQXSM4Z3o9ZRLML
	 40DRFylFuJy+auJyicZdHjD4nBniZZwXYBRPRgGzbFot4Dq9rR1YSSUeLegSB+JMXb
	 PGn5WL1tU+6aQ==
Date: Fri, 31 Jul 2026 12:11:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] fs/namei.c: fix kerneldoc of atomic_open() and
 vfs_lookup_open()
Message-ID: <20260731-vormund-ermitteln-blaskapelle-ccb69c313196@brauner>
References: <20260731-work-lookup-fixes-v1-0-2412b85cf65c@kernel.org>
 <20260731-work-lookup-fixes-v1-2-2412b85cf65c@kernel.org>
 <2144344067.691627.1785489082742@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2144344067.691627.1785489082742@kpc.webmail.kpnmail.nl>

On Fri, Jul 31, 2026 at 11:11:22AM +0200, Jori Koolstra wrote:
> Hi Christian,
> 
> > Op 31-07-2026 10:36 CEST schreef Christian Brauner <brauner@kernel.org>:
> > 
> >  
> > Commit ba0e87026613 ("fs/namei.c: update kerneldoc of atomic_open()")
> > turned the comment above atomic_open() into kerneldoc, but wrote the
> > return description as running text.  kernel-doc only recognises a return
> > section introduced by "Return:" or "Returns:", so this added a warning
> > under W=1:
> > 
> >   fs/namei.c:4362 No description found for return value of 'atomic_open'
> > 
> > Give it the missing colon.  The summary line also has to stand on its
> > own line, so move the "from a negative dentry" part into the body, where
> > it can say that the caller has to hand over a negative dentry.
> > 
> > Also add the "to" missing from vfs_lookup_open()'s description.
> > 
> > Fixes: ba0e87026613 ("fs/namei.c: update kerneldoc of atomic_open()")
> > Fixes: 536227b814bd ("VFS: add vfs_lookup_open() for nfsd")
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> >  fs/namei.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 226abf613983..e31905dfeb20 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4337,8 +4337,7 @@ static int may_o_create(struct mnt_idmap *idmap,
> >  }
> >  
> >  /**
> > - * atomic_open() - attempt to atomically look up, create and open a file
> > - * from a negative dentry.
> > + * atomic_open() - atomically look up, create and open a file
> >   * @path:          parent directory path
> >   * @dentry:        child to ->atomic_open()
> >   * @file:          file to attach child to
> > @@ -4346,6 +4345,9 @@ static int may_o_create(struct mnt_idmap *idmap,
> >   * @mode:          create mode
> >   * @create_error:  return value from may_o_create()
> >   *
> > + * Attempt to look up, create and open @dentry, which must be negative, in a
> > + * single call into the filesystem.
> > + *
> >   * If a non-error dentry is returned then: when FMODE_OPENED is set,
> >   * the file will have been attached to @file by the filesystem calling
> >   * finish_open(). If FMODE_OPENED isn't set, the filesystem instead called
> > @@ -4354,8 +4356,8 @@ static int may_o_create(struct mnt_idmap *idmap,
> >   * FMODE_CREATED is set when the call to ->atomic_open() actually created
> >   * the file.
> >   *
> > - * Returns the opened/looked-up dentry on success or ERR_PTR(-E) on failure.
> > - * On error, atomic_open() consumes @dentry.
> > + * Returns: the opened or looked-up dentry, or ERR_PTR() on failure.  The
> > + * reference to @dentry is consumed in either case.
> 
> Is this true? Maybe I am confused about the semantics of "consumed." If a function
> returns a dentry (or anything else refcounted), without dput()-ing it (or whatever),
> does that count as consuming that dentry in that function?

The caller gives up ownership of reference of the dentry they passed.
Only the _return_ value can be used. On success you get the reference
for the same dentry back. On failure you get another dentry and the
reference of the dentry passed in is dropped. finish_no_open() is
documented similarly iirc. 
