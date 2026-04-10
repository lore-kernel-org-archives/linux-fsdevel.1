Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6E7329C67
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775813011; cv=none; b=fawKCKdyEuwYCwDJsf5WAmWiiq3Ar2Ih9577dlDjn46Ey8wQ0+rRiP4ytb2hTcCLGdyWhS5xRjnw9wzGvUIcNUWJCSfYiWGM6KJ+ItRHd9IPF/Hmeq40hO3AS6HG1QFJxjM7dL4hPp1bMA6ulHGVMg9UyyeMZt9fnPriERVU5AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775813011; c=relaxed/simple;
	bh=bRS2sFDSkxDNUxdLeMiZMk1q5DPX9sCGAQGX2rFyGa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1W07j9nn04C2euMztLTcCK5fPqECsWL+isRLItGl+8ArcFdW5UIzsFftdjADI+e8nPM3493x4RFUTTRLhpvoHXRmkleytAsO1C7m3sRuHU9eRLzLptgpPK/YaeY+TxQVUVioyFQ+ugynlV8A/Wew8K2lZ2nUGNZJSyJDOPk6pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXP9WrNi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXP9WrNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5A61C19421;
	Fri, 10 Apr 2026 09:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775813011;
	bh=bRS2sFDSkxDNUxdLeMiZMk1q5DPX9sCGAQGX2rFyGa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXP9WrNis/L8hNuW4Ic6OoPesbEAjB1wAoV4JK8O4tFeM9AKY9lwNWLtfK1gj0EzO
	 O4bNbfXYyQfJgqkczpXdFRJvyWnqvfa7fkt6ZIkjvBJeXx9h9AIqfOw+JC6qfcj0BT
	 dlNLLL0wNfexikgNm/PU4lTU7NGIcu6mp7MXxmPdEJdFqqoano9zlHds5wSs84Zb0m
	 xw0uF4caQzfOaXDh1S0t5QCJZ04QkjPbNqp0Gozm++BGvD1ZcXLvTn2g2WxE6JT5O3
	 djlsiOGlGxr6B9LsxLVXYuMF5du/p7ehQMF6t3rYM0r4NxAShCMqnjf/kbJc8K0D2P
	 pvODL5A/odabA==
Date: Fri, 10 Apr 2026 11:23:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <20260410-anonym-freigaben-186946cb50e3@brauner>
References: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

I like this approach.

> 4) The work will walk s_hard_reclaim_inodes list and call evict() for each
> inode, doing the hard work.
> 
> This way, kswapd / direct reclaim doesn't wait for hard to reclaim inodes
> and they can work on freeing memory needed for freeing of hard to reclaim
> inodes. So warnings about GFP_NOFAIL allocations aren't only papered over,
> they should really be addressed.
> 
> One possible concern is that s_hard_reclaim_inodes list could grow out of
> control for some workloads (in particular because there could be multiple
> CPUs generating hard to reclaim inodes while the cleanup would be
> single-threaded). This could be addressed by tracking number of inodes in

Hm, I don't know with WQ_UNBOUND is that really a concern?

> that list and if it grows over some limit, we could start throttling
> processes when setting I_RECLAIM_HARD inode flag.
> 
> There's also a simpler approach to this problem but with more radical
> changes to behavior. For example getting rid of inode LRU completely -
> inodes without dentries referencing them anymore should be rare and it
> isn't very useful to cache them. So we can always drop inodes on last
> iput() (as we currently do for example for unlinked inodes). But I have a
> nagging feeling that somebody is depending on inode LRU somewhere - I'd
> like poll the collective knowledge of what could possibly go wrong here :)

I still think we should try this - for the reduced maintenance cost
alone. Imagine living in a world where there aren't 2 different LRUs
constantly battling for review attention..

I'm split here but depending on the size of the actual work needed to
make this happen we should at least be open to try this.
