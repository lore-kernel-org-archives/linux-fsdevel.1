Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D2375AD0
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777554927; cv=none; b=I32VJG2fNE/Q/qGHAohlj2m5XcOsG4FIl5xxL79U59PlZF8Yo/RSRSQUl8iqARBwpVuh0w+o65mc1fUzVgGwdYNH/VGEiQlGT9EmUiEwwT184IRXlXG4IG6wukfbkLFY1qfaiVoVbyrziRXpleJNqyXLmVoeAwjUtxSc0lZdJOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777554927; c=relaxed/simple;
	bh=KE/56oc/9tY8jz9+BJhTYBBOrj+jgjE04NcLxoyaFdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWgeBuJbts37RX81uphDH2TEdDBa6XSDo2MLAorFYkQqG0QzrITM+hU/2u8IuXMbWtZk20pCuTrMznNiYCfGQoH9YIRFEEdJcMzh4yYCAZGBFxk6Fjd4KjPW4FFyQRwjytz3kYlTvfZ+dvvJUtCpG2nQDPz+eOffLu7tLnGCCPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jGYIK58b; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jGYIK58b"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5OStTXxZ3sXqnVM84IClp2Y9AcAptag/K56TyWWXj3A=; b=jGYIK58bhLYx15PGi+dd/fQtRZ
	SQuzzxWWZqGg233kNQ1XAojs6Jnrkp/3L+TjH6d/BsJEAi8gBxgRI6uAWd3ZP2LFNpwqI4nR4s5ld
	FVACz28JCThhfr0VsLdZMXielmghJmnuEIeAZd3ClndZrvEr1wzzopyDeNujSSQWletH+loxtdZAK
	Vh4ue6x9fhO4TjaYxV7HrFKxiV1B3Nj1jYSdPvlA3Rc139u7hQJcw02tj5/CJ5zTBCmyR+/T3rUOh
	o8+A5YJjuxNEc7GMbVSiTHsH61mCcNwxbqck3ssRvfe4y15ruubnu6tAp5/SJB8KltE3qs7X5TRlI
	3SfAfiIw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIREe-00000007GsL-0T9w;
	Thu, 30 Apr 2026 13:15:20 +0000
Date: Thu, 30 Apr 2026 14:15:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	lsf-pc <lsf-pc@lists.linux-foundation.org>,
	Gregory Price <gourry@gourry.net>, Bharata B Rao <bharata@amd.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [LSF/MM/BPF BoF Session] Numa-Aware Placement for Page Cache
 Pages
Message-ID: <afNV5wbhsFQJLzxi@casper.infradead.org>
References: <h5ossmwe.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h5ossmwe.ritesh.list@gmail.com>

On Thu, Apr 30, 2026 at 05:03:37PM +0530, Ritesh Harjani (IBM) wrote:
> Linux already supports memory tiers and there are ongoing discussions around
> promotion of unmapped page cache pages, which lets kernel do the right thing
> for userspace page cache pages on a tiered system.

Well, you know my opinion of that idea ...

> So the question is:
> Do we need a userspace interface for the placement policy of page cache pages on a per file basis?

What do we do if two tasks both "know" the right NUMA placement for the
inode's data, and they disagree?

> 1. Is there a need for an interface that allows userspace to do per-fd page
>    placement and maybe per-fd page migration?

Ideally, no, the kernel should observe the task and get it right.

By the way, you're familiar with how filemap_alloc_folio_noprof()
works today, right?  I forget whether cpuset_do_page_mem_spread
is on or off by default.

> Let me know if people think that this discussion qualifies for a BoF discussion at LSFMM?
> Or do you think it's a bad idea altogether, if that is the case - Then
> please help me understand, why so?
> Before starting to jump on the implemention of any of this - I would
> like to gather feedback on what do others think?

I'm just concerned about what other session i'll have to miss to attend
this instead ;-)
