Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A260213AD26;
	Mon,  9 Mar 2026 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773046939; cv=none; b=ITn/g/obIU1Mhzs0Yu2aZ8c7p2Gj8FNCyf8bktfRG+dMEqmjClBrqoExlL5cnkFvcfINC2wQaW1uwg51sVDw7XlCYAJ/xcW0QGWDraywRM+VTEJr6/XHhB+cqZreZ4bQ8vPPXGXYa0trJ5X8v+FasevrQo/rxvBz2vlWylaZUXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773046939; c=relaxed/simple;
	bh=huHmMPsiK2tmnV5nlCb8w8EnheoLdiyHJjmoVYa9oM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQYQ1Wg2Ya0W0sMVJfIReTKMJgjZV9SbON+QDFyCmCaVvf8nWeP1ATkiOrERP4EZ8ApyTTd2CSx6lqq9bUOVK+rInNMUSBlWFx8hj7/0gzi0sHXSXqEyiBEd+thTunSoG8aCo/wK1RXRVxrbQCtjEn/Uk9deTqQMDDjShREejNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpQK7id/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpQK7id/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90558C4CEF7;
	Mon,  9 Mar 2026 09:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773046939;
	bh=huHmMPsiK2tmnV5nlCb8w8EnheoLdiyHJjmoVYa9oM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UpQK7id/GjB6JIFTYZFUjMDuChbz1i4hRPJ7Zb6ABexFPEE3HjmazGCSb++eDkQJR
	 5/Xy3LhWBFXr4tosu7Oa923QM1VSk7v8B/gvwOkqsEojaEe4r6xG33C7HzNXHhVkgY
	 oCvgrmlq6+8k5eRL24o2TTF5enL2tGqSbi6f37DzxaQSvFvgfvC203yqoLcCy9F5zD
	 +9PIqsIyPx2L2k5m0ajXQRF3tItmtcj/y+9olfzH7nfoqg9cCzYqeP4R7FpUw3hMxg
	 LhJ+KmYETsssGYy+HNhPpxszvGuObl618if/SZhguA2KzFaJ36BrMZMf2Z59T/A7sX
	 PgzJKUgIbx8WA==
Date: Mon, 9 Mar 2026 10:02:15 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: remove externs from fs.h on functions modified by
 i_ino widening
Message-ID: <20260309-bartlos-ozonschicht-5416b30686bb@brauner>
References: <20260306-iino-u64-v1-1-116b53b5ca42@kernel.org>
 <aau4LBhdBfnDJAsl@casper.infradead.org>
 <20260307061053.GU13829@frogsfrogsfrogs>
 <3d940ceb8026cff3ce8fc14ed7aa7be8ae677190.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3d940ceb8026cff3ce8fc14ed7aa7be8ae677190.camel@kernel.org>

On Sat, Mar 07, 2026 at 01:00:15PM -0500, Jeff Layton wrote:
> On Fri, 2026-03-06 at 22:10 -0800, Darrick J. Wong wrote:
> > On Sat, Mar 07, 2026 at 05:31:24AM +0000, Matthew Wilcox wrote:
> > > On Fri, Mar 06, 2026 at 08:27:01AM -0500, Jeff Layton wrote:
> > > > @@ -2951,26 +2951,26 @@ struct inode *iget5_locked(struct super_block *, u64,
> > > >  struct inode *iget5_locked_rcu(struct super_block *, u64,
> > > >  			       int (*test)(struct inode *, void *),
> > > >  			       int (*set)(struct inode *, void *), void *);
> > > > -extern struct inode *iget_locked(struct super_block *, u64);
> > > > +struct inode *iget_locked(struct super_block *, u64);
> > > 
> > > I think plain 'u64' deserves a name.  I know some people get very
> > > upset when they see any unnamed parameter, but I don't think that you
> > > need to put "sb" in the first parameter.  A u64 is non-obvious though;
> > > is it i_ino?  Or hashval?
> > > 
> > > > -extern struct inode *find_inode_nowait(struct super_block *,
> > > > +struct inode *find_inode_nowait(struct super_block *,
> > > >  				       u64,
> > > >  				       int (*match)(struct inode *,
> > > >  						    u64, void *),
> > > >  				       void *data);
> > > 
> > > I think these need to be reflowed.  Before they were aligned with the
> > > open bracket, and this demonstrates why that's a stupid convention.
> > > And the u64 needs a name.
> > 
> > I think inode numbers ought to be their own typedef to make it *really
> > obvious* when you're dealing with one, and was pretty sad to see "vfs:
> > remove kino_t typedef and PRIino format macro" so soon after one was
> > added.  But our really excellent checkpatch tool says "do not add new
> > typedefs" so instead everyone else has to be really smart about what
> > "u64" represents when they see one, particularly because arithmetic is
> > meaningless for this particular "u64".
> > 
> > Yay.
> > 
> 
> My take on typedefs is that they are mostly useful when you have a
> variable type that needs to be accessed in a particular way. For
> instance, I added a typedef for errseq_t since it's not just a plain
> integer (there are fields within it), and you need to use the correct
> functions to work with it.
> 
> In this case though, it really is just a write-once read-many times
> bog-standard u64. I sort of wonder if we ought to label it const since
> inode numbers really shouldn't ever change after being established, but
> I didn't go that far.

I would be very interested in seeing any filesystem that changes inode
numbers...
