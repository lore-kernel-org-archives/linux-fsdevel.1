Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8345F2571DD
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 03:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778209935; cv=none; b=OMM0DGfDbF/p6wkkEfZyikjinCA0FyV2s1gwZ8tTvitOldWtBff0cUTvcVBuUeKlV+ZyTsEKT1ORY7+G4o1t7+b4wmD36+niQFhAkbuayZjuVSpbeAu9L1rQbjF/QpTzulf5ktguXdQ3NJh7PN+1nJ/9l8LR4DON/K/wbQeQ1BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778209935; c=relaxed/simple;
	bh=GrA136KEcBq2LatWywHzgCuqFmzO7fbzNxJq82uUlMY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGzUbSts88k5utgFlPLJ9SfRdz4TzFaU0yso8iAwamRzlKiQJGk4fT7ydhYcV+/7dp8IclDuL+Snb0Qu5nhj6DsyZE6jF9ergn469dep7wQloYqBWqc1Ilv5yoh1gT7yjot2NlSdGa2Owb8X5JR+wCi2XmFH6aR3sKlv/KWYfOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=heYyQ5yE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="heYyQ5yE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4I6X+5idr01+rC02vSFwofOXQJc8hynOvy5IrPFYeD4=; b=heYyQ5yEvlkdnB1Y3TJfgs+9Oj
	aaqv/ErbfT1wj7ccQS5PNg2Ggyaldukns/7YUrjqWDKvAeqsV4LjN/LgL8f2C9SyUXyVn77t7U5Bi
	Q4ooCODs7h5VghhUzpE1chmtWMQYYVS/fpKgpYLPylaVKO4ZeImPwshM8dmHxqrMY5S5kthttAcBP
	Y8t7svYTRDCerVZpaHl8RtVCbDhTuFAmMkRDHtqX9irhCVfeKK2nbr9AMniNBOWlJb7SUMT88Yxc0
	hyYi7uR6lWi8o3XBAkLaV+KvD/q/vHyY0VYBynM72n/LpFuFxjWTGZ7CKZ/VexknKLmChQ7d384u5
	V+gsPMYg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLBdj-0000000B6Uf-44Tw;
	Fri, 08 May 2026 03:12:36 +0000
Date: Fri, 8 May 2026 04:12:35 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Jori Koolstra <jkoolstra@xs4all.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: Re: [RFC PATCH 21/25] shrinking rcu_read_lock() scope in
 d_alloc_parallel()
Message-ID: <20260508031235.GA2636677@ZenIV>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-22-viro@zeniv.linux.org.uk>
 <af0F6BwrJRxMMKMT@lt-jori.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af0F6BwrJRxMMKMT@lt-jori.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 07, 2026 at 11:52:21PM +0200, Jori Koolstra wrote:
> > 	If no match is found, we proceed to lock the hash chain of
> > in-lookup hash and scan that for a match.  If we find a match, we want
> > to grab it and wait for lookup in progress to finish.  Since the bitlock
> > we use for these hash chains has to nest inside ->d_lock, we need to
> > unlock the chain first and use lockref_get_not_dead() on the match.
> 
> Just curious, reading this code as someone fairly new to the kernel,
> how can I know what is the agreed-upon lock order between these hash
> chains and the d_locks of the dentries they contain?

Either wait for documentation to get there, or look at the places where
we deal with those locks; in particular, the removal from the in-lookup
hash chain comes in __d_lookup_unhash():
        hlist_bl_lock(b);
	dentry->d_flags &= ~DCACHE_PAR_LOOKUP;
	__hlist_bl_del(&dentry->d_in_lookup_hash);
	hlist_bl_unlock(b);
with callers of that thing all done under ->d_lock.  And yes, we *do*
need to document that shite - no arguments here.

> > 	That makes the entire thing easier to follow and the purpose
> > of those rcu_read_lock() calls easier to describe - the first scope is
> > for __d_lookup_rcu() + lockref_get_not_dead(), the second one bridges
> > over from the bitlock scope to the ->d_lock scope on the match found in
> > in-lookup hash.
> 
> Because the dentry could be freed after the hash chain unlock and before
> grabbing the d_lock?

Yes.  It's a bit more complicated - the missing bit is "and dentry we might
find in the in-lookup hash is not going to be NORCU, so freeing is guaranteed
to be RCU-delayed".

> I do think the hlist_bl_for_each_entry loop would read clearer if we
> pull the code after having found the initial match out of it, since we
> always exit the loop afterwards.

Umm...  Not sure - we'd need to distinguish between "no match found" and "got
a match, stopped looking" cases.  Would have to be something like
	if (!pos)
		insert into hash
	ele
		dentry is a match, deal with it
which is more reliant upon the details of hlist_bl_for_each_entry than I'd like...
