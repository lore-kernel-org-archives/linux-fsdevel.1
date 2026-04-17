Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86ED355F2B
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 17:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776446452; cv=none; b=KZ2sNYtdy/nBvxub84BZPJNy6+e7oersa2acScw6vVuNyUIFNN4TP+esV9hB1ALY9SW1L+Q+e9iYe31ZqrTEBzL4eANCU8Vnk2IdB02Gd+KGQ+xGl/GLWwi+aYyF6Cvclqp9GyY1jld45PvDOAlD5hSOsNxVDZJHNSDaHyIAdjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776446452; c=relaxed/simple;
	bh=Y68bzh3ru9RJOLNTZFL/m/31kOJyNutXT8R7zBnAuGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiD9MLptA5kkiJSfWN4xYZsKN1Bkd3HyuLHLWq35RsCxEXepRtoCAQPgiho8E9Bba9XX7EwEjj+9lJSk6hanRq3RafruAGUOixpVp3sBCVujF7WLntzuawL4tG8FG+MGSXTLAV5CYXpz6QguC52G12/cVqYSoI1BLt+DMLDH3+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4gVhVT8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4gVhVT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEF8C19425;
	Fri, 17 Apr 2026 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776446451;
	bh=Y68bzh3ru9RJOLNTZFL/m/31kOJyNutXT8R7zBnAuGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4gVhVT8RJ4pZJ0cvRPB0YhJP0zveOLziviUn3TEULZQqGZTQSiybbeo/yo9gAMOt
	 Tkguott30mVE0PhVRUQEmoLkPlhUs0KxMXvlIPK1oeo3Ed9oHYpP0CxgrZWOsIX3t+
	 qkX0leSNuElXi12jCeJdUVoyvcRdU/1FmUKvzvlToQKLYAMrbgaOG6CgUa+w0CDEIG
	 eNK+0u1arlOXzSkLhMU7FlKJPPT+4z8yVnlpxGX8RCTjHz9HmNCgFThgm+uw/YCqd6
	 oUkrG1TriklAQmm0Z78GTXGUo3C85onuJ0Vitn9NQDzQvUr+4PEkkQ+oIhrtd1xc6k
	 nFPOSpmiy89bA==
Date: Fri, 17 Apr 2026 17:20:49 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
Message-ID: <aeJr8Wq3qmpGk6m9@google.com>
References: <20260417142503.1436446-1-amir73il@gmail.com>
 <aeJTecsykkHMSvNh@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeJTecsykkHMSvNh@casper.infradead.org>

On 04/17, Matthew Wilcox wrote:
> 
> Thanks for getting this discussion started.  Some thoughts inline ...
> 
> On Fri, Apr 17, 2026 at 04:25:03PM +0200, Amir Goldstein wrote:
> > +Do You Need a New In-Kernel Filesystem?
> > +---------------------------------------
> > +
> > +Before proposing a new in-kernel filesystem, consider whether one of the
> > +alternatives might be more appropriate.
> > +
> > + - If an existing in-kernel filesystem covers the same use case, improving it
> > +   is generally preferred over adding a new implementation.  The kernel
> > +   community favors incremental improvement over parallel implementations.
> > +
> > + - If the filesystem serves a niche audience or has a small user base, a FUSE
> > +   (Filesystem in Userspace) implementation may be a better fit.  FUSE
> > +   filesystems avoid the long-term kernel maintenance commitment and can be
> > +   developed and released on their own schedule.
> > +
> > + - If kernel-level performance, reliability, or integration is genuinely
> > +   required, make the case explicitly.  Explain who the users are, what the
> > +   use case is, and why a FUSE implementation would not be sufficient.
> 
> It may also be worth linking to
> https://en.wikipedia.org/wiki/GVfs as an alternative to writing
> an in-kernel filesystem or a FUSE filesystem.  Very much depends what
> one's goals are.
> 
> > +Technical Requirements
> > +----------------------
> > +
> > +New filesystems are expected to use current kernel interfaces and practices.
> > +Submitting a filesystem built on outdated APIs creates an immediate
> > +maintenance debt and is likely to face pushback during review.
> > +
> > +Use modern VFS interfaces
> > +  New filesystems should use iomap rather than buffer heads for block mapping
> > +  and I/O, folios rather than raw page operations for page cache management,
> > +  and the filesystem context API (``fs_context``) for the mount path.  See
> > +  ``Documentation/filesystems/iomap/index.rst`` for iomap documentation and
> > +  ``Documentation/filesystems/mount_api.rst`` for the mount API.
> > +
> > +Avoid deprecated interfaces
> > +  Do not use interfaces listed in
> > +  :ref:`Documentation/process/deprecated.rst <deprecated>`.  If the
> > +  filesystem depends on an interface that is being phased out, plan for
> > +  conversion before submission.
> 
> Maybe these are one section rather than two?
> 
> I'd add "If it's a network filesystem, consider using netfs, or be
> prepared to explain why it's a bad fit for you".
> 
> Similarly if you have a block filesystem, and need functionality not
> provided by iomap, be prepared to explain why adding that functionality
> to iomap is infeasible.
> 
> > +Provide userspace utilities
> > +  A ``mkfs`` tool is expected so that the filesystem can be created and used
> > +  by testers and users.  A ``fsck`` tool is strongly recommended; while not
> > +  strictly required for every filesystem type, the ability to verify
> > +  consistency and repair corruption is an important part of a mature
> > +  filesystem.
> > +
> > +Be testable
> > +  The filesystem must be testable in a meaningful way.  The
> > +  `fstests <https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git>`_
> > +  framework (also known as xfstests) is the standard testing infrastructure
> > +  for Linux filesystems and its use is highly recommended.  At a minimum,
> > +  there must be a credible and documented way to test the filesystem and
> > +  detect regressions.  When submitting, include a summary of test results
> > +  indicating which tests pass, fail, or are not applicable.
> > +
> > +Provide documentation
> > +  A documentation file under ``Documentation/filesystems/`` describing the
> > +  filesystem, its on-disk format, mount options, and any notable design
> > +  decisions is recommended.
> 
> I kind of want a section on "no weird ioctls".  Anything you want to
> implement beyond ioctls already implemented by other filesystems,
> you need to bring to linux-fsdevel as a separate proposal from "please
> merge my filesystem".  Almost anything implemented by f2fs is a good
> example here.

I disagree to this. As a filesystem developer, I belive ioctl provides a way
to tune the filesystem-specific features which are not supported by all the
other filesystems.

> 
> > +Community and Maintainership Expectations
> > +-----------------------------------------
> > +
> > +Merging a filesystem is a long-term commitment.  The kernel community
> > +needs confidence that the filesystem will be actively maintained after it
> > +is merged.
> > +
> > +Identified maintainer
> > +  The submission must include a ``MAINTAINERS`` entry with at least one
> > +  maintainer (``M:``), a mailing list (``L:``), and a git tree (``T:``).
> > +  The maintainer is expected to be the primary point of contact for the
> > +  filesystem going forward.
> 
> Preferably two maintainers, although even that wasn't enough to save
> bcachefs.
> 
> > +Submission Process
> > +------------------
> > +
> > +Send patches to the linux-fsdevel mailing list
> > +(``linux-fsdevel@vger.kernel.org``).  CC the relevant VFS maintainers as
> > +listed in the ``MAINTAINERS`` file under ``FILESYSTEMS (VFS and infrastructure)``.
> > +
> > +Expect thorough review.  Filesystem code interacts deeply with the VFS, memory
> > +management, and block layers, so reviewers will examine the code carefully.
> > +Address all review feedback and be prepared for multiple revision cycles.
> > +
> > +It may be appropriate to mark the filesystem as experimental in its Kconfig
> > +help text for the first few releases to set expectations while the code
> > +stabilizes in-tree.
> 
> I'd like something here about how to structure a submission.  It's
> neither acceptable to send one big patch containing your entire
> filesystem, nor do we want to see the entire history of development over
> the last eight years.
> 
> Instead split it up by topic.  Superblock, inode, directory handling,
> address_space, ...
> 
> > +Ongoing Obligations
> > +-------------------
> > +
> > +Merging is not the finish line.  Maintaining a filesystem in the kernel is an
> > +ongoing commitment.
> > +
> > + - Adapt to VFS infrastructure changes.  The VFS layer evolves continuously;
> > +   maintainers are expected to keep up with conversions such as folio
> > +   migration, iomap adoption, and mount API updates.
> > +
> > + - Maintain test coverage.  As test suites evolve, the filesystem's test
> > +   results should be kept current.
> > +
> > + - Handle security issues promptly.  Filesystems parse complex on-disk
> > +   structures from potentially untrusted media and must treat security
> > +   reports with urgency.
> > +
> > + - Filesystems that become unmaintained -- where the maintainer stops
> > +   responding, infrastructure changes go unadapted, and testing becomes
> > +   impossible -- are candidates for deprecation and eventual removal from
> > +   the kernel.
> 
> Interact with other filesystem maintainers.  They are not your enemy
> although they may compete with you for users.  There are opportunities
> to share code, share approaches to fixing problems and share features.
> It's inappropriate to hide away on your own filesystem list and pop up
> once per kernel cycle with a set of patches that nobody's seen before.
> 
