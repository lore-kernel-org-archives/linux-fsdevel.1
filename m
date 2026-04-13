Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F57191F94;
	Mon, 13 Apr 2026 00:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776039953; cv=none; b=EN0LtIbg3tZ7EkObyfPzPNEMfinCnGkasVuGmy9WKOluXlKhSYlacisY20/uQ3rpwuzK14kK/cKfNFyuLZPSw+f7n70zJo9W2yz1Y5gOEFi3xp2wSr6ZGNsukqO33jCmPM5Rwabd59dw+upFeV1JRSYOgweyFgXMFYlm9/bOdtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776039953; c=relaxed/simple;
	bh=Xz+5ABBEkvPpZXJJ0GhpSj73Nbo4umcxINA/Symb7ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbeX7/cUVPw1U2e9jgCoQtJV+WIYCsjcBiuvJiJfnb9HiEuAM7p1vKeRSHD5dH4XtYHChLq6h3tSiHMXp+nV3yueHKyDlPt/GpQPSTujgMmDK3E0nb5G4+2kHnbIEBnKnMmG0QxPgwESPs0LE4QGM4rIu4C+L7p0qeS7h8HA4ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FCSYRg92; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FCSYRg92"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4ZnKnuscF3WXodakqZEgLOFnc1q2GEDZoVm+7zLPDsg=; b=FCSYRg928O2aNRlcb+WJb52AFo
	KVI/HwkKoi95aRQxA7HIaCeRbNUnO/50WG0UBNLTvZFbGCwKbrYAg8oZ0U7VhtpWmbgLHIJ/T/aJw
	zTPW0IseDXeRo7vjd7DJPj2NHWJAlNGRqkJRZcZiRiSEV5wty6k5ylmUXVqGgwSbs2AK/VCS8+nGx
	fl7RDJJbfkhskH97F9eVWDhLJjbcwxWZB3reGstGBch5Y02M5j9mGDcOpsvUYdt/WryeD2UC9QGRg
	w2e0uPxxRa6OB8rC+aeTmR+TgQFxFcKnwnSunEF4pQYEsV+tpaZQ62RWFxnsQxYj8mU4i4g6AewqA
	d3lgVNOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wC5BM-0000000C2gt-3nHa;
	Mon, 13 Apr 2026 00:29:41 +0000
Date: Mon, 13 Apr 2026 01:29:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] fuse update for 6.19
Message-ID: <20260413002940.GA2846532@ZenIV>
References: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
 <CAHk-=wht097GMgEuH870PU4dMfBCinZ5_qvxpqK2Q9PP=QRdTA@mail.gmail.com>
 <20251206014242.GO1712166@ZenIV>
 <CAHk-=wg8KJbcPuoRBFmD9c42awaeb4anXsC4evEOj0_QVKg0QQ@mail.gmail.com>
 <20251206022826.GP1712166@ZenIV>
 <CAHk-=wgBU3MQniRBmbKi2yj0fRrWQjViViNvNJ6sqjEB-3r4XA@mail.gmail.com>
 <20251206035403.GR1712166@ZenIV>
 <20251206042242.GS1712166@ZenIV>
 <CAJfpegtsDZW7v=YDhs+gPq25G+QOh-5mjiaXT04DDW=iU+R75A@mail.gmail.com>
 <20260412061644.GA2485189@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412061644.GA2485189@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Apr 12, 2026 at 07:16:45AM +0100, Al Viro wrote:

> 	Looking at that thing again, I really hate how subtle it is ;-/
> Consider the lockless case in your ->d_release() and try to write down
> the reasons why it's safe.  Among the other things, kfree_rcu() is there
> to protect RCU callers of ->d_revalidate(); fair enough, but it quietly
> doubles as delaying that freeing past the scope of dentry_hash[].lock in
> which you'd done RB_CLEAR_NODE(&fd->node) that had pushed ->d_release()
> to lockless path.  Another side of that fun is the proof that if
> fuse_dentry_tree_work() sees a dentry, it won't get freed under us.
> Locked case of ->d_release() is easy; proving that the lockless one
> is OK without explict barriers is more interesting.  Basically, all
> insertions are ordered wrt ->d_release() (on ->d_lock), so if the value
> we are observing in RB_EMPTY_NODE() has come from those we will hit the
> locked case.  If the value we observe has come from RB_CLEAR_NODE() in
> earlier fuse_dentry_tree_work() (these are ordered on dentry_hash[].lock,
> wrt each other and insertions), there mustn't have been any subsequent
> insertions, or ->d_release() would've observed the effect of those.
> If the value has come from the _same_ fuse_dentry_tree_work(), the
> implicit barrier in spin_lock() would've ordered that store wrt beginning
> of the scope, and since dentry_free() is ordered wrt ->d_release()
> the callback of call_rcu() in there wouldn't run until the the end of
> the scope in question.  So I think it's OK, but having it done without
> a single comment either on barriers or on memory safety...  Ouch.
> 
> 	Note that we *can* run into a dentry getting killed just after
> RB_CLEAR_NODE() in there; it's just that store to ->d_flags of dying
> or killed dentry is safe under ->d_lock and d_dispose_if_unused() is
> a no-op for dying and killed ones - it's not just "If dentry has no
> external references, move it to shrink list" as your comment in
> fs/dcache.c says.  And in your case it very much does have an
> external reference - it's just that it's an equivalent of RCU one,
> with all the joy that inflicts upon the user.

FWIW, here's what I've ended up with yesterday:

	/*
	 * ->d_release() is ordered (on ->d_lock) after everything done
	 * while holding counting references, including all calls of
	 * fuse_dentry_add_tree_node().  Freeing a dentry is RCU-delayed
	 * and scheduling it is ordered after ->d_release().
	 *
	 * In ->d_release() we see the initialization and all stores done by
	 * fuse_dentry_add_tree_node(); since fuse_dentry_tree_work() is
	 * ordered wrt fuse_dentry_add_tree_node() (on dentry_hash[].lock)
	 * we also see all stores from fuse_dentry_tree_work() except possibly
	 * the last one.
	 *
	 * If the value fuse_dentry_release() observes in
	 *	if (!RB_EMPTY_NODE(&fd->node))
	 * has come from initialization, the node had never been inserted
	 * into rbtree and fuse_dentry_tree_work() won't see it at all.
	 *
	 * If the value we observe there comes from the last store in
	 * fuse_dentry_add_tree_node(), RB_EMPTY_NODE(&fd->node) will be
	 * false and we are going to enter a dentry_hash[].lock scope,
	 * providing an ordering wrt fuse_dentry_tree_work() which either
	 * won't find fd in rbtree, or will complete before we
	 * get to even scheduling dentry freeing.
	 * 
	 * If the value we observe comes from fuse_dentry_tree_work(), we will
	 * be ordered past the beginning of dentry_hash[].lock scope that store
	 * had happened in.  Since call_rcu() that schedules freeing the dentry
	 * is ordered past the return from ->d_release(), freeing won't happen
	 * until the end of that scope.  Since there can be no subsequent calls
	 * of fuse_dentry_add_tree_node(), any subsequent calls of
	 * fuse_dentry_tree_work() won't see the node at all.
	 *
	 * Either way, if fuse_dentry_tree_work() sees a node, we are
	 * guaranteed that node->dentry won't get freed under it.
	 *
	 * Freeing the node itself is also RCU-delayed and scheduled in the
	 * very end of FUSE ->d_release(); similar considerations shows that
	 * if fuse_dentry_tree_work() sees a node, we are guaranteed that
	 * the node won't get freed under us either.
	 *
	 * While it is possible to run into a dying (or killed) dentry in
	 * fuse_dentry_tree_work(), d_dispose_if_unused() is safe to be
	 * used for those - it's a no-op in such case.
	 */

Is the above sane?  If it is, something similar would be worth having
written down somewhere in fs/fuse - it's not trivial and it's not hard
to break accidentally...

As for the primitive itself...

/**
 * __move_to_shrink_list - try to place a dentry into a shrink list
 * @dentry:	dentry to try putting into shrink list
 * @list:	the list to put @dentry into.
 * Returns:	true @dentry had been placed into @list, false otherwise
 *
 * If @dentry is idle and not already include into a shrink list, move
 * it into @list and return %true; otherwise do nothing and return %false.
 *
 * Caller must be holding @dentry->d_lock.  There must have been no calls of
 * dentry_free(@dentry) prior to the beginning of the RCU read-side critical
 * area in which __move_to_shrink_list(@dentry, @list) is called.
 *
 * @list should be thread-private and eventually emptied by passing it to
 * shrink_dentry_list().
 */
bool __move_to_shrink_list(struct dentry *dentry, struct list_head *list)
__must_hold(&dentry->d_lock)
{
        if (likely(!dentry->d_lockref.count &&
	    !(dentry->d_flags & DCACHE_SHRINK_LIST))) {
		if (dentry->d_flags & DCACHE_LRU_LIST)
			d_lru_del(dentry);
		d_shrink_add(dentry, list);
		return true;
	}
	return false;
}
EXPORT_SYMBOL(__move_to_shrink_list);

With something like
	spin_lock(&fd->dentry->d_lock);
	/* If dentry is still referenced, let next dput release it */
	fd->dentry->d_flags |= DCACHE_OP_DELETE;
	__move_to_shrink_list(fd->dentry, &dispose);
	spin_unlock(&fd->dentry->d_lock);
in fuse_dentry_tree_work() (along with the explanations of memory safety,
that is)

Comments?
