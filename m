Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D9483A14;
	Wed, 15 Apr 2026 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265173; cv=none; b=N9nITKxRROMJD+Ep42WBlGX6wZpv2RAzWovr1+6Yd62+57DnD3hlF2XvupSdMjgmj+CYztkgcGqjHDcHjBNz1nTHaNJXpVyISb+vNzXfvJEzSxoBncaFs+vMPNj+u9W0x7CDQD28ohyGxafJImdHguf5pM5t1z3AQGWFVpZ1qXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265173; c=relaxed/simple;
	bh=uhAFc7QGnoRSa3fZEfmuv3irlx2cjUi20du2M7soL0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlKUXDgIoL0l72Yvf4quw2Ys5RXzCyFdgcSoNqI1zzLMXg7XqF29UUejF5FAf/07JK6bp04Tvb1YPNvlfNdoK5umKS2KJ4Iy1MjGupHzcgo5pINpIrcCtyBGm7HsKGKNMqKX9e5tZo4HSXF2AulD/hi0CBzSr2qnc6n9RL2AzY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSEXkKd7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSEXkKd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31233C19424;
	Wed, 15 Apr 2026 14:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776265173;
	bh=uhAFc7QGnoRSa3fZEfmuv3irlx2cjUi20du2M7soL0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fSEXkKd7QW9EWjYNcqSYApsXnW1xtcqQiUSL3Y2yKYnR0JIQ3ySvC+6l2JJeMnQPR
	 r0QntQNtOg37UPVeMulv3nkBMxJFp0UlhggE2tknKN6UShDDCdcn4YyGBNOCun/Q7P
	 afp0awUAKGnAmZK0fL9fNbCNSiGjMGKHZXl/Yk9W0qmfWQ8skxdBLJ/iVZwrMCimvS
	 Kfq4o2qnU3OTylG3/0RVrYkcT+3K8hpxcu+xNYzUWHK/zpvKyYn+VdfpcSMP43Rwn0
	 YLF4I4HOSaQNtNfs0AfPfxRqWfi3lIjHI/feQdyreSrtJR9GHWXao39oP9aocBM2KZ
	 kC6+HYFTeZT0Q==
Date: Wed, 15 Apr 2026 07:59:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Jeff Layton <jlayton@kernel.org>, lsf-pc@lists.linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-m68k <linux-m68k@vger.kernel.org>,
	linux-sh <linux-sh@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Should we make inode->i_ino a u64?
Message-ID: <20260415145932.GA114184@frogsfrogsfrogs>
References: <08f8444c7237566ffb4ba8c9eb0ab4b4a5f14440.camel@kernel.org>
 <1b340c4e635dcab3bed8c52d6381b4c341c0741a.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b340c4e635dcab3bed8c52d6381b4c341c0741a.camel@physik.fu-berlin.de>

On Wed, Apr 15, 2026 at 11:11:32AM +0200, John Paul Adrian Glaubitz wrote:
> Hello,
> 
> On Wed, 2026-02-18 at 10:36 -0500, Jeff Layton wrote:
> > For historical reasons, the inode->i_ino field is an unsigned long.
> > Because it's only 32 bits on 32-bit CPUs, this has caused a lot of fs-
> > specific hacks on filesystems that have native 64-bit inode numbers
> > when running a 32-bit arch.
> > 
> > It would be a lot simpler if we just converted i_ino to be 64-bits and
> > dealt with the conversion at the kernel's edges. This would be a non-
> > event for the most part on 64-bit arches since unsigned long is already
> > 64 bits there.
> > 
> > The kernel itself doesn't deal much with i_ino, so the internal changes
> > look fairly straightforward. The bulk of the patches will be to format
> > strings and to tracepoints.
> > 
> > I think that the biggest problem will be that this will grow struct
> > inode on 32-bit arches by at least 4 bytes. That may have cacheline
> > alignment and slab sizing implications. We're actively talking about
> > deprecating 32-bit arches in the future however, so maybe we can
> > rationalize that away.
> > 
> > FWIW, I had Claude spin up a plan to do this (attached). It's not bad.
> > I'm tempted to tell it generate patches for this, since this is mostly
> > a mechanical change, but I'm curious whether anyone else might have
> > reasons that we shouldn't go ahead and do it.
> 
> So, this went just over Phoronix [1] and as someone who is still invested
> in 32-bit architectures, I'm only notified about the performance impact on
> these systems now as the pull request has already been sent to Linus.
> 
> I'm frustrated by this poor communication style. If your change affects certain
> users negatively, it should be openly communicated to them on the appropriate
> mailing lists

You're a filesystem maintainer.  Part of that work involves watching
fsdevel for VFS changes that affect the filesystems that you maintain.
From MAINTAINERS:

FILESYSTEMS (VFS and infrastructure)
L:      linux-fsdevel@vger.kernel.org

Demanding that everyone remember to cc you personally on every single
change to the VFS is not going to work.  That's why mailing lists exist.

> so that they at least get to raise concerns. Disclosing these
> news to a limited set of mailing lists only is not okay.

"Limited", e.g. the very list that people are supposed to use for
the two filesystems that you maintain?

HFS FILESYSTEM
L:      linux-fsdevel@vger.kernel.org

HFSPLUS FILESYSTEM
L:      linux-fsdevel@vger.kernel.org

IDGI.

--D
