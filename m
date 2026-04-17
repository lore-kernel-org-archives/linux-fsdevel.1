Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C81F1537
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440190; cv=none; b=F43D+t6hGc2S9ArKp/u7Nxod8QnwNo2RE2Ugi6u099mqBcLgXuaDNKr2YLAH68uL3W+nhL7Oip5LPpDfvAltG4lCzI6l7KGnDlWwyH+nHn0MEL0lsONFgetauSfSFQwXKs8HJ2zDEAUD8t2ml7WwUk6mEnWBSoE8Y+T3L9NKZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440190; c=relaxed/simple;
	bh=5A9I9JULPps/NW0Szfg7pr6ei96FstvacdiJIklRP9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nL+SP4DlXFlk6syLcVpAMoSZOk/fUXZMs0bhxtcZzU+XjSpTZ7GIgPZjeL7Hyt8GeQCNbXHUe/cmuSzdWrGXFdxcaeJw8cR1Ggh10txXP55snBIN9RRQrdd4FdHDH6+tDjt+5UqeRH2x9ceXsHwNgEvlWhfbNVhWwuhX1yPQTIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SdnptgRj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SdnptgRj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N/68wnslnGtf3pfgXTlxWSDWKU9ySnOA/Ok7Oe+QfBM=; b=SdnptgRjDv6KIFo5m2Y9TYTG7r
	/mHSzrIt5C5wk0W6Kfc2SVTCxoqRmOXPvIyrnTyirQeu9S1kTVW57A4gaXz1uu0/ORR6y0c5avrb8
	HRZzOtOjqkKrJ1588K+BRhCYmL3/WHgvUWnzdvyEqQXeFl0mPwbd/9G+p6ACQgAcGXy+x+ez0JAJJ
	TnctQcshSbF1Jlg4ieu6z7oahzsIEqz1JW3H3Wd19/1T/p5+prz71a//SU2Xs6JbPxpQm+Dfx+l8b
	ug/jfxpavkLFW3GeKfFFKHXeW73pHsaIGg2xv5dTabRCMmAX021TvtCXDTOQUV39PgpIX7UIK9rff
	aJnPUXIg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDlF3-000000046Gg-2o8E;
	Fri, 17 Apr 2026 15:36:25 +0000
Date: Fri, 17 Apr 2026 16:36:25 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH] docs: add guidelines for submitting new filesystems
Message-ID: <aeJTecsykkHMSvNh@casper.infradead.org>
References: <20260417142503.1436446-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417142503.1436446-1-amir73il@gmail.com>


Thanks for getting this discussion started.  Some thoughts inline ...

On Fri, Apr 17, 2026 at 04:25:03PM +0200, Amir Goldstein wrote:
> +Do You Need a New In-Kernel Filesystem?
> +---------------------------------------
> +
> +Before proposing a new in-kernel filesystem, consider whether one of the
> +alternatives might be more appropriate.
> +
> + - If an existing in-kernel filesystem covers the same use case, improving it
> +   is generally preferred over adding a new implementation.  The kernel
> +   community favors incremental improvement over parallel implementations.
> +
> + - If the filesystem serves a niche audience or has a small user base, a FUSE
> +   (Filesystem in Userspace) implementation may be a better fit.  FUSE
> +   filesystems avoid the long-term kernel maintenance commitment and can be
> +   developed and released on their own schedule.
> +
> + - If kernel-level performance, reliability, or integration is genuinely
> +   required, make the case explicitly.  Explain who the users are, what the
> +   use case is, and why a FUSE implementation would not be sufficient.

It may also be worth linking to
https://en.wikipedia.org/wiki/GVfs as an alternative to writing
an in-kernel filesystem or a FUSE filesystem.  Very much depends what
one's goals are.

> +Technical Requirements
> +----------------------
> +
> +New filesystems are expected to use current kernel interfaces and practices.
> +Submitting a filesystem built on outdated APIs creates an immediate
> +maintenance debt and is likely to face pushback during review.
> +
> +Use modern VFS interfaces
> +  New filesystems should use iomap rather than buffer heads for block mapping
> +  and I/O, folios rather than raw page operations for page cache management,
> +  and the filesystem context API (``fs_context``) for the mount path.  See
> +  ``Documentation/filesystems/iomap/index.rst`` for iomap documentation and
> +  ``Documentation/filesystems/mount_api.rst`` for the mount API.
> +
> +Avoid deprecated interfaces
> +  Do not use interfaces listed in
> +  :ref:`Documentation/process/deprecated.rst <deprecated>`.  If the
> +  filesystem depends on an interface that is being phased out, plan for
> +  conversion before submission.

Maybe these are one section rather than two?

I'd add "If it's a network filesystem, consider using netfs, or be
prepared to explain why it's a bad fit for you".

Similarly if you have a block filesystem, and need functionality not
provided by iomap, be prepared to explain why adding that functionality
to iomap is infeasible.

> +Provide userspace utilities
> +  A ``mkfs`` tool is expected so that the filesystem can be created and used
> +  by testers and users.  A ``fsck`` tool is strongly recommended; while not
> +  strictly required for every filesystem type, the ability to verify
> +  consistency and repair corruption is an important part of a mature
> +  filesystem.
> +
> +Be testable
> +  The filesystem must be testable in a meaningful way.  The
> +  `fstests <https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git>`_
> +  framework (also known as xfstests) is the standard testing infrastructure
> +  for Linux filesystems and its use is highly recommended.  At a minimum,
> +  there must be a credible and documented way to test the filesystem and
> +  detect regressions.  When submitting, include a summary of test results
> +  indicating which tests pass, fail, or are not applicable.
> +
> +Provide documentation
> +  A documentation file under ``Documentation/filesystems/`` describing the
> +  filesystem, its on-disk format, mount options, and any notable design
> +  decisions is recommended.

I kind of want a section on "no weird ioctls".  Anything you want to
implement beyond ioctls already implemented by other filesystems,
you need to bring to linux-fsdevel as a separate proposal from "please
merge my filesystem".  Almost anything implemented by f2fs is a good
example here.

> +Community and Maintainership Expectations
> +-----------------------------------------
> +
> +Merging a filesystem is a long-term commitment.  The kernel community
> +needs confidence that the filesystem will be actively maintained after it
> +is merged.
> +
> +Identified maintainer
> +  The submission must include a ``MAINTAINERS`` entry with at least one
> +  maintainer (``M:``), a mailing list (``L:``), and a git tree (``T:``).
> +  The maintainer is expected to be the primary point of contact for the
> +  filesystem going forward.

Preferably two maintainers, although even that wasn't enough to save
bcachefs.

> +Submission Process
> +------------------
> +
> +Send patches to the linux-fsdevel mailing list
> +(``linux-fsdevel@vger.kernel.org``).  CC the relevant VFS maintainers as
> +listed in the ``MAINTAINERS`` file under ``FILESYSTEMS (VFS and infrastructure)``.
> +
> +Expect thorough review.  Filesystem code interacts deeply with the VFS, memory
> +management, and block layers, so reviewers will examine the code carefully.
> +Address all review feedback and be prepared for multiple revision cycles.
> +
> +It may be appropriate to mark the filesystem as experimental in its Kconfig
> +help text for the first few releases to set expectations while the code
> +stabilizes in-tree.

I'd like something here about how to structure a submission.  It's
neither acceptable to send one big patch containing your entire
filesystem, nor do we want to see the entire history of development over
the last eight years.

Instead split it up by topic.  Superblock, inode, directory handling,
address_space, ...

> +Ongoing Obligations
> +-------------------
> +
> +Merging is not the finish line.  Maintaining a filesystem in the kernel is an
> +ongoing commitment.
> +
> + - Adapt to VFS infrastructure changes.  The VFS layer evolves continuously;
> +   maintainers are expected to keep up with conversions such as folio
> +   migration, iomap adoption, and mount API updates.
> +
> + - Maintain test coverage.  As test suites evolve, the filesystem's test
> +   results should be kept current.
> +
> + - Handle security issues promptly.  Filesystems parse complex on-disk
> +   structures from potentially untrusted media and must treat security
> +   reports with urgency.
> +
> + - Filesystems that become unmaintained -- where the maintainer stops
> +   responding, infrastructure changes go unadapted, and testing becomes
> +   impossible -- are candidates for deprecation and eventual removal from
> +   the kernel.

Interact with other filesystem maintainers.  They are not your enemy
although they may compete with you for users.  There are opportunities
to share code, share approaches to fixing problems and share features.
It's inappropriate to hide away on your own filesystem list and pop up
once per kernel cycle with a set of patches that nobody's seen before.

