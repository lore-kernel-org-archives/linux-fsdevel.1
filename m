Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E5423D291
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873045; cv=none; b=tYZssCY4mo1OSxziUsrErUwYC+zFscmkVbbu/tmdxypVDe5ETP81u2fR1VxiN0lf6QwsJhIyggXJriYa/qdJwlNCt3+vX2R/ErVQFIJMoTW5Q2kCkTkosoyxaPDcSuWsSHdIFFRvPgWi8gmQMSiH8oZgncl0d7LfbjabTctQbog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873045; c=relaxed/simple;
	bh=u5tQApB1Z3DHRYx08elGKPxdniTD7pYoDfe+wNVJWdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly+y1ZP3d9Xyg98y+MinXuwlnhJPjnAPF9kGGyF8mFIx6bXxgTkIuLyfuwgp6+bb0DEcfNmXdTCpYCgXs8it3ZjtFtoj6s6agPqmRRsajfsQPV+qxEbs4KHB/N5drriX3LDocyp7WKr/+v67BrbIl57qTGzbFoI4C9fZHwH1pgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V14+dRPy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V14+dRPy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFCDC2BCAF;
	Wed, 22 Apr 2026 15:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776873044;
	bh=u5tQApB1Z3DHRYx08elGKPxdniTD7pYoDfe+wNVJWdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V14+dRPyGzu1M7nNjtNLf7RzAyEizRp4hGGb8UplqGzHR8Q2RebE4RRBwQFJfa+FT
	 7W3q2eXLMGT/slfJNqz/G/+QgeNnO2u3MndykUeXqNYnzekIPetG01ufoKZN6BEt2H
	 o1q6AyavxEOCgrVMxDxlyHoG/J5Dh5ZCPJKaVXcY/IY9ic75bnpkO3KnJYo6dvgOJ/
	 2/gf3oDQjOjJMDrD796ZPHK06psCRsj+9NgaTOTpuEfBWYz81Kg8JdB1wi+9zmQ08P
	 AixZmyQZJ8GkyTLb/8mMU5Qq12GucwWxi4SG0LfQBp9XAtlNwEwnfS3/KL27RqmsgA
	 0kQGtfbuzw26Q==
Date: Wed, 22 Apr 2026 08:50:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
Message-ID: <20260422155044.GS7727@frogsfrogsfrogs>
References: <CAOQ4uxj1guVDXNrSmWUVS+6_meYPGBe8kBSDjfe8PkopTd79fA@mail.gmail.com>
 <5zc4j4nrfvxr56rvtgazaxojbpnd54ok2bx46xvhe3swn5g7dv@lzbnm44acpbn>
 <CAOQ4uxhUU0D89P_ZfOyDPpvGD5wy8VoU-o2i8iBjU-HmJyWuDA@mail.gmail.com>
 <fe5uzacwrsuabvxp7xrsz3biiellrebtbmkoeus57xottgp5c7@wssdohk22lvr>
 <20260421181026.GG7765@frogsfrogsfrogs>
 <CAOQ4uxhq4J+t+6-qhGOoaZn0Fdh9Q05RkX-CRYm+huJSPUJHjw@mail.gmail.com>
 <20260421201502.GH7765@frogsfrogsfrogs>
 <CAOQ4uxg4S=1jBGusNSHDH20+AHdFucFfWie9wqBU9V=LUWqwUg@mail.gmail.com>
 <20260422140923.GA11127@macsyma-wired.lan>
 <CAOQ4uxgaKsFqZYemhS_iKzOAK2ZKJ623FUm5ysFiTvK3idnG6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgaKsFqZYemhS_iKzOAK2ZKJ623FUm5ysFiTvK3idnG6Q@mail.gmail.com>

On Wed, Apr 22, 2026 at 04:35:15PM +0200, Amir Goldstein wrote:
> On Wed, Apr 22, 2026 at 4:10 PM Theodore Tso <tytso@mit.edu> wrote:
> >
> > > > >  - Handle security issues and regression promptly.  Both those reported
> > > > >    by ordinary users and those reported by test bots and fuzzing tools.
> > > > >    The filesystem must handle corrupted input gracefully without hanging
> > > > >    or crashing the kernel.
> > > >
> > > > How about
> > > > "...without corrupting memory, hanging, or crashing the kernel."
> >
> > I will note that security@kernel.org does not consider maliciously
> > fuzzed file systems as a security issue.  And a long-standing position
> > by both ext4 and xfs has been that distributions configuring
> > automounters to blindly mount USB sticks dropped in the parking lot by
> > the KGB, MSS, or NSA is a Bad Idea.
> >
> > I'm a bit nervous about stating this as an expectation, especially
> > given denial of service attacks on maintainer time with a large number
> > of random academics which fork syzkaller, and send security reports
> > that mostly duplicate upstream syzkaller reports and don't support the
> > web site allowing developers to test syzkaller exports which don't
> > reproduce locally.
> >
> > It's certainly an ideal, but I'm not sure it's one we can expect or
> > guarantee.  It's also certainly not the case on most file systems
> > in-tree today, to a varying degrees, but outside of the most highly
> > maintained file systems, if we were to state this, (a) I'd be
> > concerned that we would be setting expectations that will disappoint
> > Linux users, or worse, class-action lawyers (well, they would be
> > rubbing their hands with glee), and (b) if we actually enforced it,
> > would probably result in 90% of the current in-tree file systems
> > getting removed.

Is that such a bad thing?  Reducing the kernel attack surface by that
much would be a blessing, because any missteps in the kernel means it's
game over for the entire running system.

It's also a blessing for anyone trying to do core code changes ala
willy's folio conversion project.

> This is a sentence that I removed and Darrick asked me to
> add it back, because "Not screwing over a running system is
> important, The guidelines ought to make that explicit."
> 
> "The filesystem must handle corrupted input gracefully
>  without corrupting memory, hanging or crashing the kernel."
> 
> Please suggest a variant which you are comfortable with and
> captures the sentiment that Darrick wished to express.

I'm willing to relax on the "not hanging" part since it /is/ difficult
to detect inter-fsblock loops, and the solution that I thought I had
found (attach xfs_bufs to empty xfs transaction, look for obvious
clues in xfs_buf) is apparently no longer viewed favorably by dchinner.

https://lore.kernel.org/linux-xfs/Zw8ulrPaeXw8bUnd@dread.disaster.area/

Implementing a full-on cycle detector in xfs_btree *would* be a fun
project for someone who really wants to dig in to btrees, however.

--D
