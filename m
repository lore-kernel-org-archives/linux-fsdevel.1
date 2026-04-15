Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD0DFC0A
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776275119; cv=none; b=S4aJrQxBelz/2nY+OctEn0Izo53FFndSS9hVBij+QpB2Rlz+KhVKGiM88LZrQ3/3EgCqpS4WbMrZ35rnNZt9OWxZzx00X5ml0RruMU+GNOeAS0vCeW2iXQ6cNBx8OP8OitgceI0tGHNLI4v9PxVMrm34ppQdKB/H+B8d3x2GXPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776275119; c=relaxed/simple;
	bh=BfBe3zF+bUrR64vK3y/QmXyN05qfB60dgWlW0uKKIkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1SMQx1omdQ/X+FbRDF7Y1DZRjme2mGsZTvp5E2ORk+W1+KoqXXKWkcL7aM1+nq9xId0wXm/CUkfteLm24m4lTVIRQNXy64dZPrPDmWDWqBfTdgleXHF5PyupoHQfJMO+4a7RbvwrMyxPRG0Ih35qSnkO3HOUrSGU02XL0Vg9yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mlBO/mYu; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mlBO/mYu"
Date: Wed, 15 Apr 2026 10:45:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776275115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C563PKmBwu9e720CGXp4gDf43TiENk08CsMILQPkock=;
	b=mlBO/mYuSt24pu6Q9NZK+FQoFa5e4S7j8OhN8bkeo/zjADF19DoMR0UM8f5kCZ2NBTdlJn
	lhoxYey87BzLhBhHyXroPE4h1+FGjCt3U2VTLIlHGFFy+46Rmi8ZFLviVVeitkNmIJ1hHK
	5SJpHv0NShbHtCSghFl6+zFFd7imAiQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <ad_Eo7iQVT-HUkx1@linux.dev>
References: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
 <ad1QfUWEPSCDUDYv@linux.dev>
 <z6m4h2yamlckbyzh2ey2ixa7t7s6hlzg5jcle4qyebkopkvujw@pcrzrkuycg4g>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z6m4h2yamlckbyzh2ey2ixa7t7s6hlzg5jcle4qyebkopkvujw@pcrzrkuycg4g>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 14, 2026 at 11:15:48AM +0200, Jan Kara wrote:
> Hi Shakeel!
> 
[...]
> > Some of these allocations may have __GFP_ACCOUNT flag as well, right? Also are
> > these just slab allocations or can be page allocations as well? And does the
> > caller holds shared locks while performing these allocations?
> 
> Yes, some of these allocations may be __GFP_ACCOUNT - e.g. if we end up in
> fs/buffer.c: grow_dev_folio() which needs to allocate folio to load
> metadata into and allocate buffer_heads underlying that folio.
> 
> Regarding shared locks - it is fs dependent. I cannot currently remember
> where __GFP_ACCOUNT allocation would be done under some wide-scale lock but
> I cannot also completely rule that out. Definitely there are allocations
> without __GFP_ACCOUNT under fs-wide locks.

Thanks for info and this is really important i.e. allocations under fs-wide
locks.

> 
> > > I have been mulling over possible solutions since I don't think each
> > > filesystem should be inventing a complex inode lifetime management scheme
> > > as XFS has invented to solve these issues. Here's what I think we could do:
> > > 
> > > 1) Filesystems will be required to mark inodes that have non-trivial
> > > cleanup work to do on reclaim with an inode flag I_RECLAIM_HARD (or
> > > whatever :)). Usually I expect this to happen on first inode modification
> > > or so. This will require some per-fs work but it shouldn't be that
> > > difficult and filesystems can be adapted one-by-one as they decide to
> > > address these warnings from reclaim.
> > > 
> > > 2) Inodes without I_RECLAIM_HARD will be reclaimed as usual directly from
> > > kswapd / direct reclaim. I'm keeping this variant of inode reclaim for
> > > performance reasons. I expect this to be a significant portion of inodes
> > > on average and in particular for some workloads which scan a lot of inodes
> > > (find through the whole fs or similar) the efficiency of inode reclaim is
> > > one of the determining factors for their performance.
> > > 
> > > 3) Inodes with I_RECLAIM_HARD will be moved by the shrinker to a separate
> > > per-sb list s_hard_reclaim_inodes and we'll queue work (per-sb work struct)
> > > to process them.
> > 
> > This async worker is an interesting idea. I have been brain-storming for similar
> > problems and I was going towards more kswapds or async/background reclaimers and
> > such reclaimers can do more intensive cleanup work. Basically aim to avoid
> > direct reclaimers as much as possible.
> 
> So similarly as we eventually moved direct page writeback from kswapd
> reclaim, I think it makes sense to remove difficult inode reclaim from
> kswapd as well. In particular because I think such separation makes it
> clearer that while you do complex inode reclaim and allocate memory from
> there, there's still kswapd that can free some memory for you to make
> forward progress. And you better need to be sure that there's enough "easy
> to free" memory to allow for forward progress of difficult reclaim.

Another important point that we need memory guarantee for forward progress of
the difficult reclaim.

> 
> > > 4) The work will walk s_hard_reclaim_inodes list and call evict() for each
> > > inode, doing the hard work.
> > > 
> > > This way, kswapd / direct reclaim doesn't wait for hard to reclaim inodes
> > > and they can work on freeing memory needed for freeing of hard to reclaim
> > > inodes. So warnings about GFP_NOFAIL allocations aren't only papered over,
> > > they should really be addressed.
> > > 
> > > One possible concern is that s_hard_reclaim_inodes list could grow out of
> > > control for some workloads (in particular because there could be multiple
> > > CPUs generating hard to reclaim inodes while the cleanup would be
> > > single-threaded).
> > 
> > Why single-threaded? What will be the issue to have multiple such workers
> > doing independent cleanups? Also these workers will need memory
> > guarantees as well (something like PF_MEMALLOC) to not cause their
> > allocations stuck in reclaim.
> 
> Well, single-threaded isn't a requirement but in the beginning I plan to do
> it like that for simplicity similarly as currently there's only one flush
> work doing writeback (although we are just discussing moving to more for
> that). Also the inode cleanup will contend on fs-wide resources such as
> journal so although some scaling can bring you benefits it will be
> difficult to scale beyond certain limits (again heavily fs dependent).
> 

Difficult reclaim uses fs-wide resources (and locks) and thus we can not depend
on it to be effective under extreme memory pressure, right? Or do we want it to
be reliable under extreme memory pressure where we will need to provide memory
and cpu guarantees to it?

One more question, I assume it is fs-dependent but is it possible to avoid
allocations (and thus reclaim) under fs-wide locks? One challenge/issue we at
Meta are seeing is (btrfs) lock holders getting stuck in reclaim causing
isolation issues.
