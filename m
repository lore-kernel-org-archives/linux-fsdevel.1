Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8328337C904
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776115405; cv=none; b=BVBWTaiqC1aGRzsp6kignzfgh1UVprdSKmnmLMvIpgsn77YgHjluf1akBwZJFnhE5+3IvfDDcbLReVdulQq4Cr2l13JwP9bIvVTsDAms1qOSuL+XvIlaLbVfwaP+PJ34juQAum+5tMuHtFbftZRKBhBk5PgcrttuIiqxN4DdpgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776115405; c=relaxed/simple;
	bh=RHw7hafdFcVpHLvN82G8YNIhid3gDr0Hsz6V+vipYdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYIHGcxTlOYdLu/W6x/MctCGlgIO5MdS/TaPusaRY+TfPEKSh0qIegpQHW1Lx8swFD7sRh4sGp7nKwovCaxb4tJe90ZfGi8bJy0IeCpLVcr36OTMccmCSSOKNbxYRBxaI7fTdd1Yri8NHPsufa681+onoVufOZs9dXd2x1e4ja0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D7QKdTHF; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D7QKdTHF"
Date: Mon, 13 Apr 2026 14:23:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776115401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yI8J2cXzEwopatsEgqidYN8N2g5P4kB/2yo2GpS+P7U=;
	b=D7QKdTHFaq/RjbXd8/DvRJ2OQdNFnKdNdh2OdyaDhsWmNEdF82Ktq6ob3qr/AZT/qFI8nk
	gMagaeWYpzzRPvATfta9l+8Q6ZjMmhCrM76idR/FgeQdR6MO9cdPQFuirZAoZOdWzvE1WA
	f0Zjkmnykf46SsHhAa6ViP9mA+IgCkc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <ad1QfUWEPSCDUDYv@linux.dev>
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
X-Migadu-Flow: FLOW_OUT

Hi Jan,

Thanks for looking into this issue. I have couple of questions.

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

Some of these allocations may have __GFP_ACCOUNT flag as well, right? Also are
these just slab allocations or can be page allocations as well? And does the
caller holds shared locks while performing these allocations?

> as inode eviction cannot fail, these are effectively GFP_NOFAIL
> allocations (and there are other reasons why it would be very difficult to
> make some of these required allocations in the filesystems failable).
> 
> GFP_NOFAIL allocation from reclaim context (be it kswapd or direct reclaim)
> trigger warnings 

I assume these are the PF_MEMALLOC + GFP_NOFAIL warnings, right?

> - and for a good reason as forward progress isn't
> guaranteed. Also it leaves a bad taste that we are performing sometimes
> rather long running operations blocking on IO from reclaim context thus
> stalling reclaim for substantial amount of time to free 1k worth of slab
> cache.

Agreed, particularly in the multi-tenant and overcommitted environments where
unrelated direct reclaimers have to spend their CPU time to cleaup/freeup
memory from others.

BTW I think kswapd doing such hard work is fine.

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

This async worker is an interesting idea. I have been brain-storming for similar
problems and I was going towards more kswapds or async/background reclaimers and
such reclaimers can do more intensive cleanup work. Basically aim to avoid
direct reclaimers as much as possible.

> 
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
> single-threaded).

Why single-threaded? What will be the issue to have multiple such workers doing
independent cleanups? Also these workers will need memory guarantees as well
(something like PF_MEMALLOC) to not cause their allocations stuck in reclaim.

> This could be addressed by tracking number of inodes in
> that list and if it grows over some limit, we could start throttling
> processes when setting I_RECLAIM_HARD inode flag.

I assume you are thinking of this specific limit as similar to the dirty memory
limits we already have, right?

