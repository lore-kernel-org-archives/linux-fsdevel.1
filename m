Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F68385524
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775805585; cv=none; b=WVmOyGwBAtPhl0qurZghMidEhdjchn/5xsIzdUt8yMayHsIOK0++Fo5tPtlB9zvnL+eaxD29lN50znYcP8WmqhL2nGlDQSLwe7+ysAqy9qDXOgWHWmjm93yQ4bYPGdxYzU4mWgBYt0eJS38r5bGZIisWJQETQXCdRWO7HdlZV+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775805585; c=relaxed/simple;
	bh=FKm4fY57ehTraJok2DjF06Qjd0t462XUR5IMDglyolI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cMZWqL7hUfySs+Gn9GkW4Vb9dK5q/4el6TfP4OOe3jXqet45rweS/GoUdTtvuqTJ9TWiVzgoAPePu1gDfibHuxb9eVMLJEyF9uktv7qN8NFFh7f6cnS0iGlx1liq3L3dOjec3uUlxVmbkcu1XzNFp1M+ejeWwJB9/GV43AaZfsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MGVJsZEu; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MGVJsZEu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q/kagYmVsXElg7lTyBHh77u9odsxBWTXsyTBAIuO6lc=; b=MGVJsZEuqUkcOnsTZIQOdFsPt7
	KvEjZq2UYGDEvkE+ajwptiwBqgEBkNGi5xUR7oVoEup2fw9EiAhu6OcD1nj8ai83nd52bSJW7zelj
	ZHTDOguDQ47pRxBaAGDrN8lH8Vs1+t/I88sBtzGmxX7mZuTNZJR9jNAGu4uNGThd8Ko0Cf0t9mPsp
	a1YD2A6ap2TbRyeD74Lg9GPVwl5OschvOEA5h+godygdpOyPHbq4iTGMDhrDLEOeu8BWHoJgDuPgJ
	T+Wg+h6VnXwgogYidWGjxBXFpIKsrVHHxbgz87/Wg97i78vsPevtl4by35Ba3zSuKJR0xKV4l6u/w
	YcXHP9og==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB69X-0000000Bj4c-432Z;
	Fri, 10 Apr 2026 07:19:43 +0000
Date: Fri, 10 Apr 2026 00:19:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <adikj3y6OXgSyObW@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I think a patch is more useful than a discussion here, that idea has been
voiced multiple times, and effecticely implemented in XFS.

Trying to lift the XFS logic into the VFS and finding other consumers
for it would be very helpful.

> 1) Filesystems will be required to mark inodes that have non-trivial
> cleanup work to do on reclaim with an inode flag I_RECLAIM_HARD (or
> whatever :)). Usually I expect this to happen on first inode modification
> or so. This will require some per-fs work but it shouldn't be that
> difficult and filesystems can be adapted one-by-one as they decide to
> address these warnings from reclaim.

I think otherwise we call this dirty :)

> 2) Inodes without I_RECLAIM_HARD will be reclaimed as usual directly from
> kswapd / direct reclaim. I'm keeping this variant of inode reclaim for
> performance reasons. I expect this to be a significant portion of inodes
> on average and in particular for some workloads which scan a lot of inodes
> (find through the whole fs or similar) the efficiency of inode reclaim is
> one of the determining factors for their performance.

Yes, in most file systems most inodes are clean.

> There's also a simpler approach to this problem but with more radical
> changes to behavior. For example getting rid of inode LRU completely -
> inodes without dentries referencing them anymore should be rare and it
> isn't very useful to cache them. So we can always drop inodes on last
> iput() (as we currently do for example for unlinked inodes). But I have a
> nagging feeling that somebody is depending on inode LRU somewhere - I'd
> like poll the collective knowledge of what could possibly go wrong here :)

I've heard this theory multiple times, but we really need to valide that
we don't need the LRU.  It also doesn't really solve the above problem,
as we still would not want to perform the expensive inode inactivation
work inline with the last dput.

So while this might be worth investigating, please keept it separate.

