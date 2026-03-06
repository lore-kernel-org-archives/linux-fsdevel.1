Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0DF346FAE;
	Fri,  6 Mar 2026 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772828969; cv=none; b=BffdXEikgXgCUlCojJ1K/K4JnYld7zYzB+d74Y4eQCnyCQeTfpiA+HkaZXdUP3tu2z5BHu252G1RnN/uW3Q4/m2P3NDTwIrl4aMJgk5W3WUGXdMpMNXUIC4Ykjnhp5v+ld/TQVxqP6GV04jG8lWavns8sucfFAUDjwC3ZbJrLlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772828969; c=relaxed/simple;
	bh=OXdzeNVcRQHMT1HBVU1OjH4XuBlCgk4KxDj/r1PxYAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAXecARxtruUXvorlLroakSwhJFVD+VddIi+GZTpXXKrDlLXPtqZoE/OlLNMfzYG+GoBRHpvn3n4cBI9JGiUwltzjSyuQfmFN/sW21gmFKXcsBth0JxmzZI1f0xlYIs0vRgObqWFgPJ2UA4QrfQhlgS2xL/Rw1mBwM9P9rS74/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uIICaxX6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uIICaxX6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=uIn7ORTa5pQRsuZzbhbRJ8LKH8K+iKJyVv3+eYGhv2s=; b=uIICaxX6pWmkXckWCmtWXTnofe
	Jki5RrRIWkmfndzM8xQvAFEXVPSPmxrQkGvGp+VgzmOxOTn95ZO7aZJx6F6tAX6h5YvyVSDKHerty
	Mxl2Jqf9nn7S5Cl4aVr4t2wCYJflcBGcf/Ob13+xE5vQFAVz1A/0Wz/rxpZfvJl1JWk4Xo3abKDKE
	sbL/G0hqUlOqVEbsQPHQfqPN2KR6+mL6aE/38yXuUhbsYI4hgG6BcFo6r44BOqiBPV/Yjoz9zi8Qi
	zAeP8c/pGdTsnrrWsq3WYbMA7+LksBhAW2d5VDmur4Z2fkKzjeR3ZBA57vknbnQ7bzpkBhjl7t6tj
	mSB8VU1A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vybnZ-0000000HHck-25WG;
	Fri, 06 Mar 2026 20:29:25 +0000
Date: Fri, 6 Mar 2026 20:29:25 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Josh Law <hlcj1234567@gmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Josh Law <objecting@objecting.org>, Yi Liu <yi.l.liu@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] lib/idr: fix ida_find_first_range() missing IDs across
 chunk boundaries
Message-ID: <aas5JbauFQdwWVv0@casper.infradead.org>
References: <20260306200319.2819286-1-objecting@objecting.org>
 <aas14HsY7dj6jTDZ@casper.infradead.org>
 <64ea7b4d-1d55-4d9e-8fef-396613e8bc10@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64ea7b4d-1d55-4d9e-8fef-396613e8bc10@gmail.com>

On Fri, Mar 06, 2026 at 08:25:42PM +0000, Josh Law wrote:
> 6 Mar 2026 20:15:29 Matthew Wilcox <willy@infradead.org>:
> 
> > On Fri, Mar 06, 2026 at 08:03:19PM +0000, Josh Law wrote:
> >> ida_find_first_range() only examines the first XArray entry returned by
> >> xa_find(). If that entry does not contain a set bit at or above the
> >> requested offset, the function returns -ENOENT without searching
> >> subsequent entries, even though later chunks may contain allocated IDs
> >> within the requested range.
> >
> > Can I trouble you to add a test to lib/test_ida.c to demonstrate the
> > problem (and that it's fixed, and that it doesn't come back)?
> >
> > Also this needs a Fixes: line.  I suggest 7fe6b987166b is the commit
> > it's fixing.  Add Jason and Yi Liu as well as the author and committer
> > of that patch.
> 
> Okay, you mind if I put the modifications to test_ida.c on the same commit? Or would you like it on another commit

I like it as part of the same commit (as 7fe6b987166b did), but honestly
I'm just happy to get improvements to the test suite no matter how they
come.
