Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7022F616B;
	Wed, 18 Feb 2026 23:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771455972; cv=none; b=JJqKhUaA7T3O9nnbmuTS0ijr5SSpRdIDJQg2QIc3gXyOA60xcDsd5Z8lnbXvI4zu2eXbuBWrkRfeP/5g2S8aVeCYmBWyne9K9W1N3P+/kiBoAouvYLpz2iNL1xVWbyGiNFaHUY3cvfs7PsIcdKoEuI6lyr6t8XLZILau31KPMVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771455972; c=relaxed/simple;
	bh=L/EqDuiUyCzu8iD3soq+BTUUO4ibLDP7uCgLGAnr7fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rc+tM6ioZGHKdmHu5sIP+2yhQl8u+5/1/1diePKJazQvQzzeiA6gFkHz29EHPHXFHaUzFP8TMBdMBPxrSyoPl1r9qMA9dR3TpekZb1EAlC6ZigJElFV/VToInQ/D4BnmyalPfO0o4kw9awELK/2BvYX0pb/5ZMiqWXa5dNcW1UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wLQcyz7c; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wLQcyz7c"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pRfgRN4wj527drmTt4/vmNWBUZZMw1Fe+zBW8Ei04yA=; b=wLQcyz7cP7jrh+YuC4ubR87g1a
	VzU5bAntHY1j1zmdr8TconbnPtzMGG6DdIUOPttq756NudDZ6YsPvXEQMt55i3ETN362ETcPqdbJG
	rHzrZo4hm1vB8S+9YF8OLAMr3TiO05cMKLItZlVaGVUkYJLp4WLEdZ/G/3In2xUeeB02E9KsV8FK1
	z58AxmT4JjAMaBXgWwpuZxnWzm9gXFXaFF6+xfDylaYTgatJ9YgLwNDJHPsq9cTt0Vo6v/2AkwK3F
	zMSCuPAc39N5ONJkXQ5SXigeIqE4w6P5mHfH4Gxdweu3oeaTZvP3VNuZD4yZIUXZqEPPX9Bo+NKtU
	irm0H2mw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsqcP-00000006mCu-3444;
	Wed, 18 Feb 2026 23:06:05 +0000
Date: Wed, 18 Feb 2026 23:06:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Waiman Long <llong@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 1/1] rwsem: Shrink rwsem by one pointer
Message-ID: <aZZF3SYiC7pCU4r0@casper.infradead.org>
References: <20260217190835.1151964-1-willy@infradead.org>
 <20260217190835.1151964-2-willy@infradead.org>
 <1aab1afa-d23b-40c6-8e56-a6314fa728dc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aab1afa-d23b-40c6-8e56-a6314fa728dc@redhat.com>

On Wed, Feb 18, 2026 at 05:47:52PM -0500, Waiman Long wrote:
> On 2/17/26 2:08 PM, Matthew Wilcox (Oracle) wrote:
> > Instead of embedding a list_head in struct rw_semaphore, store a pointer
> > to the first waiter.  The list of waiters remains a doubly linked list
> > so we can efficiently add to the tail of the list, remove from the front
> > (or middle) of the list.
> > 
> > Some of the list manipulation becomes more complicated, but it's a
> > reasonable tradeoff on the slow paths to shrink some core data structures
> > like struct inode.
> 
> If the goal is to use only one pointer for the rwsem structure, would it
> make sense to change list_head to hlist_head for instance? At least we have
> existing helpers that can be used instead of making our own coding
> convention here.

There's no hlist_add_tail(), and obviously there can't be.

hlist_head.first = node1
node1.pprev = hlist_head.first
node1.next = node2
node2.pprev = node1
node2.next = NULL

now we want to add node3 to the tail.  there's no pointer to it, we have
to walk the entire chain to find out where to put it.

Whereas with this scheme, we can put it at ->first_waiter.prev.  If you
want to generalise this way to use list_head, be my guest, but I don't
want to do that work (and I don't want this patch to get held up behind
a "boil the ocean" approach).
