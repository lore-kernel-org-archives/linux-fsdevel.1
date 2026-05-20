Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00276322C67;
	Wed, 20 May 2026 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310323; cv=none; b=Cycf/iPto0bqpRF+UYXsQBqUU53n7uKbTBhsXoqURLL1D8760sr5QAp3thvUuwSEeuoI1IVV8tAiw2i2m37Aha4tNhN/6AxiH5ieF/Z/aO6cGMC8FpPBTflfGkd4JSZ3PkdDnIOi5RVLjz8IFSDW4BjsJnapSBR7Q1c2BVKNpf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310323; c=relaxed/simple;
	bh=Ktm3PjlrK2/C/C4lB3NzlvPvwcg6mBCdg8yMwxVarr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ullV4TBHkvG9ej0aqTEOm1w0yEdXZ4fKbYYhNRe/l7GtrPP0OYfRX3X+X/mQfSqeLZX6kNjRU64UvzA34D6D6Jc0sX+ITzBNgMbJ2bKkTPrMgD299vJ2xmBCf6ocKadp+3DUgHfUP6sHrAqXZ3pkvlLH7BjmupZi6DXLuFo3GKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpamqJ5Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpamqJ5Y"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id AC44C1F000E9;
	Wed, 20 May 2026 20:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779310321;
	bh=PeRmVLgvfoOiwqo7yViTfze5J88cshoyVgtCGVH9bU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FpamqJ5YaOsKpkBoFQW9CoPAxh8Cu24vn/ez2noamvUrBf8tDucbx9Ed1uIIFLcuO
	 KO3w9fmUNJ5cuiQ8WX8dYWmVxAmz5Ze69dxJG8O/LTxt7hw6It322yt4saa9Yb9S8v
	 PX8eRj/vpRo9ATBRVEFk07JC9zgzb3XLl4uYIg1u5eDivE03D2sWmjHvp6ce1ItsTy
	 hHbj9XqGngQ6Jn6JjujHIFlYZgtb+lHSFuwvbJBTp3zdB40XNP4V4dD+GgB05bmsz8
	 EdeFK1CGXRUPuKeV+PjJpWI/+Xiv5UDVjZCERuWKXmJIXKd/OaVIiHji83NJ3KPPP8
	 fp6zKwbWcyEXg==
Date: Wed, 20 May 2026 13:52:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	fuse-devel <fuse-devel@lists.linux.dev>,
	linux-fsdevel@vger.kernel.org, John Groves <John@groves.net>,
	Joanne Koong <joannelkoong@gmail.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Horst Birthelmer <horst@birthelmer.de>,
	Luis Henriques <luis@igalia.com>
Subject: Re: [post LSFMM summary] where is fuse going?
Message-ID: <20260520205201.GF9531@frogsfrogsfrogs>
References: <CAJfpegvXnA1QpmfM9V+3VB470xYDNWH8FV0mBV1R1-HqvjfJ8A@mail.gmail.com>
 <20260512202336.GC9544@frogsfrogsfrogs>
 <CAJfpegsPqja+MzfmvCE5054y9pv1_cwPRH2uGmFws-wwxJmrZQ@mail.gmail.com>
 <20260519220359.GJ9568@frogsfrogsfrogs>
 <CAOQ4uxg7mkmE+Y+2rrYodwng1ZZZ6PycbwaBufATH4KLOcRnXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg7mkmE+Y+2rrYodwng1ZZZ6PycbwaBufATH4KLOcRnXw@mail.gmail.com>

On Wed, May 20, 2026 at 09:24:05PM +0200, Amir Goldstein wrote:
> On Wed, May 20, 2026 at 12:04 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Tue, May 19, 2026 at 11:01:18AM +0200, Miklos Szeredi wrote:
> > > On Tue, 12 May 2026 at 22:23, Darrick J. Wong <djwong@kernel.org> wrote:
> > >
> > > > As for fuse-iomap I'm not sure how to proceed
> > >
> > > I will try to dedicate this week to reviewing fuse-iomap, hopefully
> > > without too many distractions.
> >
> > Well gosh I had better get going on posting v9 then.
> >
> > Since 30 April I've:
> >
> > * Ripped out the BPF stuff after all the shouting
> > * Added a simplistic iomap filesystem striping mechanism
> > * Tightened some of the checking of the iomaps being given to the kernel
> > * Made it so that you can remove backing devices
> > * Actually check read/write access with the iomap bdevs
> > * Improved inline data write handling to be less flakey
> > * Amended iomap writeback so that you can run a standard ->iomap_begin
> >   to collect mappings
> > * Banned freeze except on iomap filesystems
> >
> > * Fixed some integer truncation issues
> > * Add some iomap helpers to libfuse to make it easier for fuse server
> >   authors
> >
> > > >  -- in the long run I think
> > > > it would be cleaner if each file IO path (virtiofs dax, passthrough,
> > > > writeback_cache, iomap, and whatever we call the original one) had its
> > > > own file_operations.  But that would require us to refactor the common
> > > > code chunks from each file operation function into a bunch of smaller
> > > > functions, which I think would sharply increase the review backlog.
> > >
> > > And so the plan is rather to basically start from scratch and do that
> > > form the beginning in fusex code.
> >
> > Heh.  In reading through the fuse code to figure out how I'd get that
> > done, I came to a few realizations:
> >
> > 1. It really *is* easier if the server can set FUSE_CAP_IOMAP and from
> > then on every file on the filesystem does things the iomap way.
> >
> > 2. Many of the random weird callers of fuse_inode_has_iomap() outside of
> > the regular file IO path are *actually* looking for "is this an
> > exclusive-mode inode"?  That's pretty much all of the file attribute and
> > ACL handling code.
> >
> 
> When you use the term "exclusive mode" you mean the same thing as
> "local" filesystem as opposed to "remote" (or clustered) filesystem that
> can have attribute changes on the server and needs to implement revalidate.
> Is that right?

Right.  A local filesystem driver knows it has exclusive ownership over
the disk contents, and hence the filesystem.  It doesn't have to worry
about external changes to the filesystem metadata.

> Can we maybe stick to the "local"/"remote" terminology?
> Or am I missing something subtle?
> 
> > 3. iomap and exclusive mode are mostly orthogonal concepts.  One deals
> > with plumbing, the other deals with attributes.
> >
> >    3a: iomap without exclusive: This is a clustered filesystem client.
> >    The client grabs a file layout lease from the server, and uses that
> >    to populate the iomappings.  Timestamp updates are forced out after
> >    each write, but otherwise it's the same attr cache and timeout that
> >    regular fuse uses
> >
> >    3b: iomap with exclusive: This is basically fuse4fs and all the other
> >    local filesystems.  The kernel knows that the fuse server isn't going
> >    to change the file attrs out from underneath it, so it can cache
> >    timestamp updates in the kernel and only flush them periodically.
> >
> > 4. Figure out how all the attribute handling works in fuse is really
> > really complicated.
> >
> > But there are questions here -- I'd like it if the fuse server could set
> > FUSE_CAP_IOMAP and all files are iomap.  All the weird userspace inode
> > flags setup setup code goes away.  It'd be even nicer for 3b if you
> > could declare at mount time (or FUSE_IOMAP_CONFIG time) whether you want
> > exclusive mode or not, at which point all files *also* become exclusive
> > files.
> >
> > The problem with 3a is that I don't have a client or any way to test
> > that.  If I just don't allow iomap && !exclusive, how sad would anyone
> > be?
> >
> 
> My view is that as long as you keep the design sufficiently extensible
> to support iomap && !exclusive in the future,
> let those who care enough about iomap && !exclusive step forward
> to code and review and test it if they care enough.

Heh.  Disentangling all the existing file attr and caching code is going
to take me a long time...

--D
