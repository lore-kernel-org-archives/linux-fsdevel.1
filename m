Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB174175A99
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 23:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778196088; cv=none; b=RB5+6e5lT/G8KKhftpjMgBkhxG/+MH2sE1go6URhg8oMEtdQ0K/xKUrxvh+SPXGXDtgjChFt8Dun2aD+0HslsWco0YCapOVQGydhLgK2jbAvKDCiincTHJ8ufCP9plCq4C4ofKxPimKrzsc6ERbMuvEc1XvFk7Ss+3w6GRBArq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778196088; c=relaxed/simple;
	bh=PVm6Bwh5CE0jbjUT1QLnnVPYrj1kvQDNHUhOmYOx1LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEpSnkkn1Hyuq79vd9cyJyfrYAGCDNQSD6LpKxkpJlJAba31k134gUyz4kNxyN2onIGryO2CnvJyRetULTeKhCJpTogdlWRlzX3VQwwhIhQCdGiWP2c0wnCc0w8qRTfto5trO/ldRMwUrKIqtT6NhPgUkQhFEYvG4axrGCCkTV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYdNDi+m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYdNDi+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 647FEC2BCB2;
	Thu,  7 May 2026 23:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778196088;
	bh=PVm6Bwh5CE0jbjUT1QLnnVPYrj1kvQDNHUhOmYOx1LI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=kYdNDi+mN4xA8EhlZXW0Q6uL/C8yME51qteLhUjwuip7uwHdzZZHDu6SGMvXD4Vd8
	 kz/Olxhkl1872e1I3b4JJJwK12ihy1hFkowiDuuAiUB6S4+FnPQ1ZYMxEEzhEUkU7N
	 VeTppg+DxnwlQTz14J4eE1E+MPybOph9JKkYMBGIM/DkpQ4YR38UCCLOUVQPIpZwq5
	 DPC+vslfC4HinLxK/LaBZmFw8o/t7B8Fc7iC3I9sZ3irJWn0YRppICtPBOaP2pwqgR
	 WFrSOGqRRi/8/c4D1ZT+Yuv2iuH6Ta+Zb7AI3LwA8w8GINjnZ/D6IFWWocuEAsSD8z
	 +FyFFoFo7wHZQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 06758CE0FF9; Thu,  7 May 2026 16:21:28 -0700 (PDT)
Date: Thu, 7 May 2026 16:21:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Frederic Weisbecker <frederic@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [RFC PATCH 20/25] d_walk(): shrink rcu_read_lock() scope
Message-ID: <586a6402-ae1a-47c5-b054-f02cbd457928@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-21-viro@zeniv.linux.org.uk>
 <CAHk-=wj9WdmFn=gw4c0+mv9dLCGFsiawF60Eu3Kw3t8SfvpZsw@mail.gmail.com>
 <20260505200501.GF3518998@ZenIV>
 <afpj3FBrvHer0E6Y@pavilion.home>
 <20260505225028.GI3518998@ZenIV>
 <ba887c23-9122-40c3-86ff-95e3a5afdc7e@paulmck-laptop>
 <177819357555.1474915.12171087837586376086@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177819357555.1474915.12171087837586376086@noble.neil.brown.name>

On Fri, May 08, 2026 at 08:39:35AM +1000, NeilBrown wrote:
> On Wed, 06 May 2026, paulmck@kernel.org wrote:
> > On Tue, May 05, 2026 at 11:50:28PM +0100, Al Viro wrote:
> > > On Tue, May 05, 2026 at 11:40:44PM +0200, Frederic Weisbecker wrote:
> > > 
> > > > > FWIW, back in 2015 spin_lock() did *not* provide an RCU read-side critical
> > > > > area, according to https://lwn.net/Articles/652156/; would be nice to have
> > > > > the history mentioned in D/RCU/whatisRCU.rst - at least to the level of
> > > > > "once upon a time one *did* need an explicit rcu_read_lock() in addition
> > > > > to spin_lock() - spin_lock() or preempt_disable() alone was not enough;
> > > > > that has changed in <...>".
> > > > > 
> > > > > I'm not familiar enough with that code for that kind of archaeology ;-/
> > > > > Could somebody help with that?  Paul?
> > > > 
> > > > That's quite outdated. Now preempt disabled, IRQs disabled, and spinlocks
> > > > are all implicit RCU read sides. On non RT spinlocks disable preemption and
> > > > on RT they call rcu_read_lock() internally.
> > > 
> > > Out of curiosity, how much headache do bitlocks cause on RT?  I mean, they
> > > are unconditionally disabling preemption, RT or no RT...
> > 
> > Given the unconditional disabling of preemption, they would be about as
> > bad for RT as are raw spinlocks.
> 
> But presumably if they ever became a measurable problem, someone could
> create an RT-bitlock implementation I assume ?

Alternatively, if the bitlock acquisition is always a trylock-style
operation with no tight loop around the trylock, it should not be
necessary to disable preemption.  (Give or take the expectations of the
code in the critical section, of course!)

							Thanx, Paul
