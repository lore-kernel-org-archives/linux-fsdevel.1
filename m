Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167FB1B6CE9
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 16:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049152; cv=none; b=QLfWZGoH2rj+avhPsh/Kdt4w5NNoJypccBB0hVBbF6DBCbGgWXkCATc/tO4NFkqcwasctcdV5AT2yT7+59KmmEpMvxXcOhA+qVV7MrOK0b3RJEit1kntdeYfYd/+IUzD9LR6so7fRWBvsspjlzHWET3cWb1XzKm2fq/kl8AEQ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049152; c=relaxed/simple;
	bh=Y8AHqu6a4Yb3YgxGWRJLwqQMJXLTiHTWCk7CQwDT0dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCOB+94rKwC8EZf4rJskPD445DmzZSRlShfus4njsleqA/gZa3EoFBWpYzFitLcAwendjoKcaDv4+dkyQOwC4Lpt1BWbCkDLYrIHM/aMYDDLmgDo4rFNVUEeRpCGO9Q0YHJP4TEIw1iyGjg9phZnrlyppIriiFxTeAeN64iPROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JIWAhgVJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JIWAhgVJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6MuIhTKn81QH0/FznwtFyEBRCGi6RLudX/kQq6UY2bI=; b=JIWAhgVJoTGgF90npbxq2/cgHu
	bq4/mViVjxtLFxXB4EYuCD23xBVkNFN+87L+NhL7/n1LhEjcZEjh8cQn6oPfv4XaneT3X0KX7SPIZ
	XyfWL+Vgqhxr799qOpfDwagohch91PzE49v7rQFd7ProqwXXwti9g7HwZ4EA7iRWoU7jvx7fwV/Wk
	d69Q/ENZoGIA7KCwgp25vZqr/PjbmR3uQ7ToDHdLCTzgZy4xMZ+Gg693EKUYBLR97VZam/opyuSX3
	3ePKpH17x4xNeRTyyiGI9mfdqg3HUAY64eV6ZW+DOOqJ0UjEDGGZ7oO5sU89wZWsHlKtQGW30BJPU
	4GZVdjnA==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGJet-0000000DT0j-0FcI;
	Fri, 24 Apr 2026 16:45:39 +0000
Date: Fri, 24 Apr 2026 12:45:32 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>, Ryan Roberts <ryan.roberts@arm.com>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Page cache tracking with the Maple Tree
Message-ID: <oi2kit3a2qulr53c7j3h4g3cjjgbss4kd2djdqota2sriiaaov@7uewnraaq4gk>
References: <biynsvpcamct5fva5nxxdvc3q43dqi72jotpyasvrk3pumdz2w@7okprmuwznlo>
 <aeKO6bKupHa2bgWt@casper.infradead.org>
 <aeaKAxrAUtfwM9ns@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeaKAxrAUtfwM9ns@cmpxchg.org>

On 26/04/20 04:18PM, Johannes Weiner wrote:
> On Fri, Apr 17, 2026 at 08:50:01PM +0100, Matthew Wilcox wrote:
> > On Tue, Feb 24, 2026 at 12:10:26PM -0500, Liam R. Howlett wrote:
> > > The Maple Tree needs some enhancements:
> > >  - Support for purging shadow entries from the page cache
> > 
> > Liam and I hd some preliminary discussions yesterday around this
> > and we'd like some feedback if anyone has time before LSFMM.
> > 
> > For those who aren't aware, when a folio falls off the end of the
> > LRU list, we store a shadow entry in the page cache in its place
> > so that if we access that page again, we know where to put its folio in
> > the LRU list.
> > 
> > But this creates a problem (documented in mm/workingset.c) where
> > we can fill up memory with shadow entries.  Currently, we embed a
> > list_head in xa_node and add nodes which contain only shadow entries
> > to a list which can be walked by a shrinker when we're low on memory.
> > Ideally we wouldn't do that with the maple tree.  There are a few
> > options.
> > 
> > The first question we have is whether it's best to keep nodes around to
> > wait for a shrinker to kick in.  Was any experimentation done to
> > see whether eagerly freeing a node that contains only shadow entries
> > has a bad effect on performance?
> 
> Hm, I'm not sure how that could work.
> 
> The LRU order created by readahead makes it highly likely that all the
> folios in a cache node are reclaimed/made non-resident at once. Going
> this route would destroy a large part of the non-resident cache the
> moment it is created.

Not the moment it is created, but the moment the entire node only has
NULLs or shadow entries.  Meaning it's removed the moment the last
entry becomes a shadow entry.

Still much sooner, but not as extreme as just dropping them immediately.

> 
> The goal is to garbage-collect the oldest shadow entries whose
> distances are too long to be actionable at this point. Specifically,
> their distance to lruvec->nonresident_age (per-cgroup, per-node).
> 
> In the current scheme, we just go in the order in which nodes became
> all-shadow - oldest first. And we only do so lazily when the
> non-resident cache is far into that territory (cache set vastly larger
> than available memory). That gives us confidence that we're mostly
> dropping very old entries without having to look at them one by one.
> 
> We don't have to stick with that design, but whatever replaces it
> should meet the goal, or approximate it well enough.

The goal of garbage collecting the oldest shadow entries based on the
nonresident_age.  That's a broad target, which I think is made more
specific within the implementation to 'groupings of 64 shadow entries',
which I bring up later.

Besides the locking improvements that we can bring, is there anything
that you have found doesn't work optimal in the current solution that
may be nice to fix?

> 
> > The second idea we talked about is that the maple tree is much more
> > flexible than the radix tree.  Having even a single folio in a node pins
> > the entire node, so it's "free" to keep the shadow entries in that node
> > around.  But with the maple tree, we can be much more granular and
> > delete shadow entries in arbitrary positions.  So we could (for example)
> > keep track of inodes which contain shadow entries and purge shadow
> > entries when they reach, say, 10% of the number of pages.  Or 1000
> > entries, or some other threshold.
> 
> It's not the volume or the concentration of shadows, it's their age
> that makes them good candidates for garbage collection.

Maybe I'm reading this wrong but it seems workingset_update_node() adds
nodes to the list that is composed of all shadow entries (or removes it
if we have changed one to resident).

Doesn't that mean there is a concentration of shadow entries since the
entries in the tree are in order?

That is, reclaim is at node level granularity, and the nodes are sorted
sets.  I think, sibling entries aside, it's fair to call that a grouping
of 64 shadow entries?

This also means that with today's code we are keeping older entries over
newer entries because the node has at least one resident entry.  But
that's fine, because we can't gain anything by removing them today.

So, we can change this behaviour to something new if we want, if 64
shadow entries are too many to accumulate before removal, or too small.

> 
> Searching the tree for all-shadow nodes should be possible, but you'd
> still have to filter for age. Naively, that would be unpack_shadow()
> -> workingset_test_recent() for each one, but that's likely too heavy.
> 
> What might work is a monotonic ID counter for each node that becomes
> all-shadow, then search the trees with quick comparisons for any IDs
> below a certain cutoff?
> 
> > The third idea is that instead of having an injected list_head that we
> > keep a tree pointing to inodes (or even just maple tree nodes which
> > contain a lot of shadow entries).  That's not how list_lru works today,
> > so a certain amount of development work would need to be done.
> 
> Ah, so you don't need storage inside the inode or maple tree node.
> 
> That could work well with the monotonic ID counter, you'd just scan
> and reclaim through that tree, oldest node first.

I think this would end up looking like a linked list with a few extra
metadata points.  Basically a linked list, node pointer, min of the
node, maybe a size if we support multiple node types.,

I'm not sure the node pointer will do us much good, considering how the
maple tree node allocation needs to track the tree status on walking to
minimize allocations.  In fact, if we do a write that rebalances the
tree, we may have stale pointers.  I don't expect this to happen under
any normal circumstance - the node would need to be altered, but maybe
the node type changes..

It might be better to just track ranges and the largest (thus newest to
become a shadow) monotonic ID counter.

There's many ways to do this, but it'd probably be best to decide on a
size that makes sense (I say size because of the siblings..).  On that
note, the siblings stuff will go away with the maple tree as well.

Thanks,
Liam
