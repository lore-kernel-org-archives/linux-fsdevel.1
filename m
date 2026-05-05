Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247841F5847
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 20:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011485; cv=none; b=Iogn4+L4wlw8mMrjpmYvpSV1gs8WwtHbAo0bcaKHabshq4wsEpqkP0O+nDyJQ0Hfzb0YbKd5fzJZPiGz2XyeF3KFcHuinfCFWKqzr6S7uxAK05an8gifu6oKZgrb5s/0zsUWuxT7VvgVMvcLU+3NjJIAHaknVaDb6pWh76IG1M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011485; c=relaxed/simple;
	bh=kYpA5SnvPZssPP4bThOAEBHIJcgqaarG1iH1FKjgM2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEKDlaCNzUtOfLe9LbvIixkCFkBBQ0N1E0rx4NqchvGBZnxcUiXWofSDe+hSb3d+TtpFLokTcYEkrwk5JFMtRF3g+4Gh2UVmWFRn0TL9GyMHGla6jPfpiMu7U/UIEqLs+MgNw4ookbYXi/Q8Ap75fes2KiOuzqxnf+S1A/fzkHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bLdscyQ4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bLdscyQ4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tC6QhqO2ZeQWTQQtekDsMzmsQn5Sos5/8rSg77x6AHM=; b=bLdscyQ4y/SMc1dkyLL6jFldi7
	vGlFtvS0n8GPbEEvxp9l35DJjkN03ltJgcdIRss7hxOpr9yOoaS/5jp9veA2rzmgTX54/iahvW5Bw
	9r8YgjJytXf6ELSCW7X/0QCdpmXeQywTEGNRDykD+a0PH2qdkI8L6Sx8BM69W9hjqVvuLsE/v6q3n
	sHbX9PoBBfIyB0I6Uzzpu/3RBMlbdRsrAhaI7xMTHpb1AJVbPDkBBaGIUWoqCyUPowUAkoGR8GvhS
	uHn5Xc9WsArRufI8HkR4hIkloRvP0Y6ucdmj9eXEQ8Rl/S7zjCuo6yervZT29T6NNfgqybfTCUBB/
	HqIMuXnw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKM0r-000000083rp-1qUP;
	Tue, 05 May 2026 20:05:01 +0000
Date: Tue, 5 May 2026 21:05:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: Re: [RFC PATCH 20/25] d_walk(): shrink rcu_read_lock() scope
Message-ID: <20260505200501.GF3518998@ZenIV>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-21-viro@zeniv.linux.org.uk>
 <CAHk-=wj9WdmFn=gw4c0+mv9dLCGFsiawF60Eu3Kw3t8SfvpZsw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj9WdmFn=gw4c0+mv9dLCGFsiawF60Eu3Kw3t8SfvpZsw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, May 05, 2026 at 10:01:39AM -0700, Linus Torvalds wrote:

> If we had a function that was "transfer spinlock without dropping RCU
> read lock", and we'd use that as an _optimization_ (maybe we could
> avoid all the preemption count games and testing for whether there are
> active RCU events etc), that would make sense to me.
>
> At that point it would *all* become "we rely on the spinlock to hold
> RCU read locking", and it wouldn't mix locking models. So I think such
> an operation might make sense on its own.

Definitely; we have the same "bridge two spin_lock scopes together into
a contiguous RCU read-side critical area" elsewhere as well.  Hell,

	rcu_read_lock();
	do {
		spin_unlock(&dentry->d_lock);
		spin_lock(&inode->i_lock);
		spin_lock(&dentry->d_lock);
		if (likely(inode == dentry->d_inode))
			break;
		spin_unlock(&inode->i_lock);
		inode = dentry->d_inode;
	} while (inode);
	rcu_read_unlock();

in lock_for_kill() might be better off as

	do {
		transfer_spinlock_with_rcu(&dentry->d_lock, &inode->i_lock);
		spin_lock(&dentry->d_lock);
		if (likely(inode == dentry->d_inode))
			break;
		spin_unlock(&inode->i_lock);
		inode = dentry->d_inode;
	} while (inode);

Explicit rcu_read_lock() uses don't explain what's really going on; in this
form it's "we can't take ->i_lock under ->d_lock, but we need an unbroken
RCU read-side critical area for memory safety".  The same goes for d_walk()
use ("can't take parent's ->d_lock under child's one"), as well as in
shrink_dcache_for_umount() ("can't take ->d_lock under ->s_roots_lock")
and I wouldn't be surprised to see other instances of the same pattern.

I would really prefer to have all explicit rcu_read_lock() in fs/dcache.c
clearly documented ;-/

FWIW, back in 2015 spin_lock() did *not* provide an RCU read-side critical
area, according to https://lwn.net/Articles/652156/; would be nice to have
the history mentioned in D/RCU/whatisRCU.rst - at least to the level of
"once upon a time one *did* need an explicit rcu_read_lock() in addition
to spin_lock() - spin_lock() or preempt_disable() alone was not enough;
that has changed in <...>".

I'm not familiar enough with that code for that kind of archaeology ;-/
Could somebody help with that?  Paul?
