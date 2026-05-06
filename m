Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6132A9463
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 May 2026 03:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778039350; cv=none; b=cw+dyFSO2n9O2q4mEWzvlcXgBu2+vNaXzeGo4QtW4OTAR9a0BZpKbYYx3KxsSJGIVuUDjfUb9YLQ5BBgOSfMGDZB6xhpCYfhmnPElzyTWBzqYasv6k4L6S/olzJBCWcWpNDyemZlCU2Tu+gw19oHEV32G8gRskS8VEjFtabcMiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778039350; c=relaxed/simple;
	bh=8lEAzaHWFLI3NvyEspwOV4m0Nxugw1HNlHkV7Ki4TdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/xbVZ97HAMvs0YlFImAS/d1U3/jon0Zi5URSHhEFsYk5EJc539GFrJ2klP0Zt5XpmZ5qdekcf4eek8IwMoGBlDorx3lUEGxsPaJQmA+ggFokN9ecH7rG1J+lXwPuWXTbtlIt34knkpYw6c+CgS588C08Gk8z8wDjvoIV/bEH4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3J2YP2Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3J2YP2Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F97C2BCB8;
	Wed,  6 May 2026 03:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778039349;
	bh=8lEAzaHWFLI3NvyEspwOV4m0Nxugw1HNlHkV7Ki4TdI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=d3J2YP2Zj0Wlq38udKHkEYKmEUqxYCqdiJEJ83rIw//7OltmZe3wrTlkCz6PrOALy
	 MBxs+eAUiXiaRVaOMnyhxuLDhI4vqJCSunEoGDKFX1Stc6dggjHEUXiLgDpxNzvUo9
	 rPAvg/4rz5K6vhOu5B7Mqn+wAJCkh2tuCG2inltEO47CvmaZEBGP0TK2xMbcgXSOmJ
	 gxGsVG/Uxw5OM4vTFh5bXsD45U3KOrxsw+HIjRk8IcIVj8XfrDwfw/vwHPrC+rro6s
	 aUyXuUgbsVx3A0bFv0RgfTrXcQ7Et8tGdbhZynWrUYqGDMZlVxO5y7jd5+axCkOTTj
	 6WUxnRQKigggg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 94C8DCE0A70; Tue,  5 May 2026 20:49:09 -0700 (PDT)
Date: Tue, 5 May 2026 20:49:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>, Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [RFC PATCH 20/25] d_walk(): shrink rcu_read_lock() scope
Message-ID: <ba887c23-9122-40c3-86ff-95e3a5afdc7e@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-21-viro@zeniv.linux.org.uk>
 <CAHk-=wj9WdmFn=gw4c0+mv9dLCGFsiawF60Eu3Kw3t8SfvpZsw@mail.gmail.com>
 <20260505200501.GF3518998@ZenIV>
 <afpj3FBrvHer0E6Y@pavilion.home>
 <20260505225028.GI3518998@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505225028.GI3518998@ZenIV>

On Tue, May 05, 2026 at 11:50:28PM +0100, Al Viro wrote:
> On Tue, May 05, 2026 at 11:40:44PM +0200, Frederic Weisbecker wrote:
> 
> > > FWIW, back in 2015 spin_lock() did *not* provide an RCU read-side critical
> > > area, according to https://lwn.net/Articles/652156/; would be nice to have
> > > the history mentioned in D/RCU/whatisRCU.rst - at least to the level of
> > > "once upon a time one *did* need an explicit rcu_read_lock() in addition
> > > to spin_lock() - spin_lock() or preempt_disable() alone was not enough;
> > > that has changed in <...>".
> > > 
> > > I'm not familiar enough with that code for that kind of archaeology ;-/
> > > Could somebody help with that?  Paul?
> > 
> > That's quite outdated. Now preempt disabled, IRQs disabled, and spinlocks
> > are all implicit RCU read sides. On non RT spinlocks disable preemption and
> > on RT they call rcu_read_lock() internally.
> 
> Out of curiosity, how much headache do bitlocks cause on RT?  I mean, they
> are unconditionally disabling preemption, RT or no RT...

Given the unconditional disabling of preemption, they would be about as
bad for RT as are raw spinlocks.

							Thanx, Paul
