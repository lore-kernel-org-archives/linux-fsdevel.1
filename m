Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1E53B5304
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Apr 2026 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775751179; cv=none; b=SJWjxUA/qwcS3zlncmEk1JzHtJWOr1XPa5eLqHB6XItJjk9bimS93/43RWZy5zPe+MWvzZRWEPZcoU/WbDJBz6CYWhF8YsDtpNjAMfsRTjDG7GRvgOZ0pf8K/MD/C1C+IOU625rVxv5jNhNpp2g4mL2yYQkYseqrAUt2ZN2RxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775751179; c=relaxed/simple;
	bh=f4fYl1Bgw3X/qBz85lGZ8DoKbiAtjXnT8GvKt8TU8dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcHLGpNT2XZnu/B1QE2w+Co7gS/MNh5A97Y7pc+fL99KnqD9GAX34EqIAAGAv5h0YXa/w0MQuA0DeS+BHvyy5xOZ+RVj4Tk2eLFoyLcF7cC3RqF5wUZffnO4X98GDw24HaMSHZ+noTh4kAsPrX1Gmnn2zALRzuslaQv+avCsDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L95Rovtd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L95Rovtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0AC3C4CEF7;
	Thu,  9 Apr 2026 16:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775751178;
	bh=f4fYl1Bgw3X/qBz85lGZ8DoKbiAtjXnT8GvKt8TU8dQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L95RovtdTY6ZH7BEOl0PSFriOj2XL6j4oBWoN6g7RlBWEAOsu3DpN0hd6VQd6GgbL
	 A6eRlIH9Sq1DyjbvN0tRKofTpdAaS05EJ+8QSbfth6aW2O+IUeIg5A2c7j0SlXmRn6
	 CEsBqh4isVK62rqshknzXbXBEtGPvtEnr0MJ6Qc4j9mhFoyV29Gkv0ldiAvz6I6T9U
	 QNjW/ypcMsze+dzIVbPbqzPl5JMuQojwd0XlxFd00ULmA7bResEVf1C+8JO7FjPU4U
	 gPrGKL/4AqkvsUZjDVd0aVo3B9g7hoO8JGJ73DS/KxRlNfeLwvxLBdhJcF6O7wnKY0
	 9/qKHO3F1LIuw==
Date: Thu, 9 Apr 2026 09:12:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <20260409161258.GU6202@frogsfrogsfrogs>
References: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>

On Thu, Apr 09, 2026 at 11:16:44AM +0200, Jan Kara wrote:
> Hello!
> 
> This is a recurring topic Matthew has been kicking forward for the last
> year so let me maybe offer a fs-person point of view on the problem and
> possible solutions. The problem is very simple: When a filesystem (ext4,
> btrfs, vfat) is about to reclaim an inode, it sometimes needs to perform a
> complex cleanup - like trimming of preallocated blocks beyond end of file,
> making sure journalling machinery is done with the inode, etc.. This may
> require reading metadata into memory which requires memory allocations and
> as inode eviction cannot fail, these are effectively GFP_NOFAIL
> allocations (and there are other reasons why it would be very difficult to
> make some of these required allocations in the filesystems failable).
> 
> GFP_NOFAIL allocation from reclaim context (be it kswapd or direct reclaim)
> trigger warnings - and for a good reason as forward progress isn't
> guaranteed. Also it leaves a bad taste that we are performing sometimes
> rather long running operations blocking on IO from reclaim context thus
> stalling reclaim for substantial amount of time to free 1k worth of slab
> cache.
> 
> I have been mulling over possible solutions since I don't think each
> filesystem should be inventing a complex inode lifetime management scheme
> as XFS has invented to solve these issues. Here's what I think we could do:
> 
> 1) Filesystems will be required to mark inodes that have non-trivial
> cleanup work to do on reclaim with an inode flag I_RECLAIM_HARD (or
> whatever :)). Usually I expect this to happen on first inode modification
> or so. This will require some per-fs work but it shouldn't be that
> difficult and filesystems can be adapted one-by-one as they decide to
> address these warnings from reclaim.
> 
> 2) Inodes without I_RECLAIM_HARD will be reclaimed as usual directly from
> kswapd / direct reclaim. I'm keeping this variant of inode reclaim for
> performance reasons. I expect this to be a significant portion of inodes
> on average and in particular for some workloads which scan a lot of inodes
> (find through the whole fs or similar) the efficiency of inode reclaim is
> one of the determining factors for their performance.
> 
> 3) Inodes with I_RECLAIM_HARD will be moved by the shrinker to a separate
> per-sb list s_hard_reclaim_inodes and we'll queue work (per-sb work struct)
> to process them.
> 
> 4) The work will walk s_hard_reclaim_inodes list and call evict() for each
> inode, doing the hard work.
> 
> This way, kswapd / direct reclaim doesn't wait for hard to reclaim inodes
> and they can work on freeing memory needed for freeing of hard to reclaim
> inodes. So warnings about GFP_NOFAIL allocations aren't only papered over,
> they should really be addressed.

This more or less sounds fine to me.

> One possible concern is that s_hard_reclaim_inodes list could grow out of
> control for some workloads (in particular because there could be multiple
> CPUs generating hard to reclaim inodes while the cleanup would be
> single-threaded). This could be addressed by tracking number of inodes in
> that list and if it grows over some limit, we could start throttling
> processes when setting I_RECLAIM_HARD inode flag.

<nod> XFS does that, see xfs_inodegc_want_flush_work in
xfs_inodegc_queue.

> There's also a simpler approach to this problem but with more radical
> changes to behavior. For example getting rid of inode LRU completely -
> inodes without dentries referencing them anymore should be rare and it
> isn't very useful to cache them. So we can always drop inodes on last
> iput() (as we currently do for example for unlinked inodes). But I have a
> nagging feeling that somebody is depending on inode LRU somewhere - I'd
> like poll the collective knowledge of what could possibly go wrong here :)

NFS, possibly? ;)

--D

> In the session I'd like to discuss if people see some problems with these
> approaches, what they'd prefer etc.
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 
