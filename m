Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472112773CA
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776455410; cv=none; b=ssSSxZRXHXyEvBn7ptbaDSJNyTN+KDySBMugE/Cz0qIpk7tCi1wFPcoPJCErgjwlkwlJhBNLfQjc9etmLeSi795CTP8iJ04jmL+0995zmBVA2GmYBbwnnVKRhLrCpzxoJUfxz/9yySsDUBCKn5Bx0I2TxooUdwI6Fn0AVSA8TB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776455410; c=relaxed/simple;
	bh=JtmFWutanxDQX+2TSPmu4T5jDw9ElrpmmTiGCJwKCx8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e4j53GEihgV/GeFakoeVyzGl4gFA3EFwB8C3gajipVlAXQ/kIIDRibrwbuWLfyd2rf2g++YjusV6e6JY28ZqR0tr7Z4c7l0Gx3uOxQsb6bhDiOyMkXOH5O7U4KKJd3VWv5kHuHMN8/LEBPiYGyfJ1GHqOCGd/8zM5Q5vdC9THCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ScI8EGGS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ScI8EGGS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ccgT2l/PPKbrEGp7q7C3uXUssUZuYa5x+/Ij72Wpdp0=; b=ScI8EGGSUQ5qO7AafegmuaTcqp
	VYEiZVnQ8ucQEnaVcuByYS/1BqSEehANP0lBzsJg1KEm+GVKaK7GpjMCSOM2pYlDluFXnySsChWMO
	wWBRiILAFbzbFKFnOK8IvDtJ29faPl+6RSMrLAF7LZNERxURwlqdxoXZJA97ubK5wqqMN2+yC3I2U
	zM8A3khZSfoAXc4VkkZmVQEvMqmiSMPFM0aY/eT0ZNDLfKtjQ9BPqFCdmE0rlvHlLVM9mnWI1vj1O
	PstZGJCCtE1WF/si7PwK12yN9Xih0h9h1zE3twBcPd90MJGlt8i36MZkOtAyp1N5mOu6gjRrsLrwM
	pjofP2Mw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDpCU-00000004Mws-0vWV;
	Fri, 17 Apr 2026 19:50:02 +0000
Date: Fri, 17 Apr 2026 20:50:01 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Liam R. Howlett" <liam@infradead.org>,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Page cache tracking with the Maple Tree
Message-ID: <aeKO6bKupHa2bgWt@casper.infradead.org>
References: <biynsvpcamct5fva5nxxdvc3q43dqi72jotpyasvrk3pumdz2w@7okprmuwznlo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <biynsvpcamct5fva5nxxdvc3q43dqi72jotpyasvrk3pumdz2w@7okprmuwznlo>

On Tue, Feb 24, 2026 at 12:10:26PM -0500, Liam R. Howlett wrote:
> The Maple Tree needs some enhancements:
>  - Support for purging shadow entries from the page cache

Liam and I hd some preliminary discussions yesterday around this
and we'd like some feedback if anyone has time before LSFMM.

For those who aren't aware, when a folio falls off the end of the
LRU list, we store a shadow entry in the page cache in its place
so that if we access that page again, we know where to put its folio in
the LRU list.

But this creates a problem (documented in mm/workingset.c) where
we can fill up memory with shadow entries.  Currently, we embed a
list_head in xa_node and add nodes which contain only shadow entries
to a list which can be walked by a shrinker when we're low on memory.
Ideally we wouldn't do that with the maple tree.  There are a few
options.

The first question we have is whether it's best to keep nodes around to
wait for a shrinker to kick in.  Was any experimentation done to
see whether eagerly freeing a node that contains only shadow entries
has a bad effect on performance?

The second idea we talked about is that the maple tree is much more
flexible than the radix tree.  Having even a single folio in a node pins
the entire node, so it's "free" to keep the shadow entries in that node
around.  But with the maple tree, we can be much more granular and
delete shadow entries in arbitrary positions.  So we could (for example)
keep track of inodes which contain shadow entries and purge shadow
entries when they reach, say, 10% of the number of pages.  Or 1000
entries, or some other threshold.

The third idea is that instead of having an injected list_head that we
keep a tree pointing to inodes (or even just maple tree nodes which
contain a lot of shadow entries).  That's not how list_lru works today,
so a certain amount of development work would need to be done.

Liam, anything I missed?
