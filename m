Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C8637D12A
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776467695; cv=none; b=T+SaZYpWlt6eSO7RDQQvsnS0zH69//gSAFeySW3rY8PfCmQvN74zMAORDnlffDvyqUGyLOsRZaKzsA3/pcQBjuqOBacbN0uB2Yoy6WUITn8rUwv6wbwC6zw1NrfAykTndwObH1q/sOZq4mzX4cLyfhQvNInJKbYr/ucTii6pnpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776467695; c=relaxed/simple;
	bh=o3/sc3fmSxgrcumhQ0M4Qkc7iqVRmzPA8JnuQL541Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqHRByhtlLlM7Sh8e8m0LHQqmQX/lIW1IOtnnqrG22Z4UUgbhiu9aJ5/K4cLeHsBqJ9KR8/8b/uBbO6c8quC/h4JdKJFaGkfYMOY0XE6Fe4G+07+zS3xExwOWiozz9DDHUA/6fc12zJeL80n9dYduRE9msKP2q4DQTg8XLikhyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a9l8y6zK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a9l8y6zK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3wFdco1Ipo++Om9fQ34nLKqA5r9nO//VrtgBnQNq8aE=; b=a9l8y6zK+Kevdi3BKW+LMpqWLY
	lvj6ncQ7RinG6Db0lSWBD3ZQhO1Fqg87SPrWpo0OR6nJPvO/nUj4ds72oMqj+rVztHtbqxiqr1FYP
	8Qp3LVS7uN8dqMGXS15jeSWxPz+bgQIhodsonVMDMZHcd8nyhQz9c4hI/DTxxoB20RIoJ8d3VGhGa
	OAGCvqiiDvUupi9WpD6KuPIFeqUBhLncWV9TQKPHfGw/UdvQGp71onMgsraooIaVUgudM0iUhcmQS
	n3HcxYOqeveqTgABdVZfT5K2BElO815ZDUZ/D9cQKqhI4OHtI10V9353KPjlBWW+9uW7WsP3Bvopw
	h/bBj50g==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDsOe-00000004YO2-0uVr;
	Fri, 17 Apr 2026 23:14:48 +0000
Date: Fri, 17 Apr 2026 19:14:45 -0400
From: "Liam R. Howlett" <liam@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>, 
	David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>, Ryan Roberts <ryan.roberts@arm.com>, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Page cache tracking with the Maple Tree
Message-ID: <sdpiedmwabh5l6r7vmyscxadftwsmq7dteolarlfvca7ks4d3m@e7f5fnrw25dz>
References: <biynsvpcamct5fva5nxxdvc3q43dqi72jotpyasvrk3pumdz2w@7okprmuwznlo>
 <aeKO6bKupHa2bgWt@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeKO6bKupHa2bgWt@casper.infradead.org>

On 26/04/17 08:50PM, Matthew Wilcox wrote:
> On Tue, Feb 24, 2026 at 12:10:26PM -0500, Liam R. Howlett wrote:
> > The Maple Tree needs some enhancements:
> >  - Support for purging shadow entries from the page cache
> 
> Liam and I hd some preliminary discussions yesterday around this
> and we'd like some feedback if anyone has time before LSFMM.
> 
> For those who aren't aware, when a folio falls off the end of the
> LRU list, we store a shadow entry in the page cache in its place
> so that if we access that page again, we know where to put its folio in
> the LRU list.
> 
> But this creates a problem (documented in mm/workingset.c) where
> we can fill up memory with shadow entries.  Currently, we embed a
> list_head in xa_node and add nodes which contain only shadow entries
> to a list which can be walked by a shrinker when we're low on memory.
> Ideally we wouldn't do that with the maple tree.  There are a few
> options.
> 
> The first question we have is whether it's best to keep nodes around to
> wait for a shrinker to kick in.  Was any experimentation done to
> see whether eagerly freeing a node that contains only shadow entries
> has a bad effect on performance?
> 
> The second idea we talked about is that the maple tree is much more
> flexible than the radix tree.  Having even a single folio in a node pins
> the entire node, so it's "free" to keep the shadow entries in that node
> around.  But with the maple tree, we can be much more granular and
> delete shadow entries in arbitrary positions.  So we could (for example)
> keep track of inodes which contain shadow entries and purge shadow
> entries when they reach, say, 10% of the number of pages.  Or 1000
> entries, or some other threshold.
> 
> The third idea is that instead of having an injected list_head that we
> keep a tree pointing to inodes (or even just maple tree nodes which
> contain a lot of shadow entries).  That's not how list_lru works today,
> so a certain amount of development work would need to be done.
> 
> Liam, anything I missed?

The only thing is that order 6 trick can be removed and we can support
any order folio.

Besides that, there are some ideas on implementing the different paths.
