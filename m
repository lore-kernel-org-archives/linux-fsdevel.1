Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C70194C96
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277791; cv=none; b=d6TjRmk+gHKMxEa8p4VvvOCCDf/FNFJX/0fTdewz2uJZqtTkX5KXErlOWQdnf6J6mKWYk8e+Z90XjTlCFW/ETmeShABe94IxgcwET4NW9CLk3z1oWNYhQSUNJTmwFx7D3OrPdpYXHEGKcCVIHQZFK07Nj8k20rkydMi85YvJOYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277791; c=relaxed/simple;
	bh=on4QCFh4nx50dZCMdrGO63S4E59DWi+ZZvLQlDK/p8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0JfZ89crF7Zgk4AY7EXJsCKd94vZlTtheB9uUbD51BtvBtv/m8Tdb3dNQjgSEIvEiYH1lHecbA9RXfFQSSvACweRiiPvcSEbA1Cn1a6O4tBrMETJ4x2t7T+MScUWzxgxce9AY8CSeFYB5Snqg9ZRfROjcDX4e3/iLbn11tz3dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STP2oThD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STP2oThD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A424C2BCB0;
	Fri,  8 May 2026 22:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778277791;
	bh=on4QCFh4nx50dZCMdrGO63S4E59DWi+ZZvLQlDK/p8I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=STP2oThDX4+Y7aryhVEkTDCXf+RTKz9WMkIaxCrcuKsKxv7s3DFJ7vFHR4n7bXyIA
	 /JPS6Hz16MfXQLZMFloHwF1W+8efPoXFi87erdJdMEZeJk01tysSqWqb04UMAxaR1K
	 jFbOD3At/ll2gjbHJOUnu/b+F7zPHywfF/Q6mP1rOp2dWZYwWCHOYgLH49SXgipdae
	 o3d6DMZfTNnwmCby3evI45x4Q0ChrD41xeMqRM8ogdxpQIRCjDfuGZGUGuSYYnES51
	 tWP+2rA4A7WW02VPNyMxXvykU94pJSwcIhvAw2WDRPDRsc3LTo5T2MZCVUerzTZULT
	 IJjtsGv5CqDww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D94D7CE08B6; Fri,  8 May 2026 15:03:10 -0700 (PDT)
Date: Fri, 8 May 2026 15:03:10 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neil@brown.name>, Frederic Weisbecker <frederic@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Boqun Feng <boqun@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [RFC PATCH 20/25] d_walk(): shrink rcu_read_lock() scope
Message-ID: <9b90dd3d-e6a0-41a9-8d2d-4faebba6bfad@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260505055412.1261144-21-viro@zeniv.linux.org.uk>
 <CAHk-=wj9WdmFn=gw4c0+mv9dLCGFsiawF60Eu3Kw3t8SfvpZsw@mail.gmail.com>
 <20260505200501.GF3518998@ZenIV>
 <afpj3FBrvHer0E6Y@pavilion.home>
 <20260505225028.GI3518998@ZenIV>
 <ba887c23-9122-40c3-86ff-95e3a5afdc7e@paulmck-laptop>
 <177819357555.1474915.12171087837586376086@noble.neil.brown.name>
 <586a6402-ae1a-47c5-b054-f02cbd457928@paulmck-laptop>
 <20260508144754.GB2636677@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508144754.GB2636677@ZenIV>

On Fri, May 08, 2026 at 03:47:54PM +0100, Al Viro wrote:
> On Thu, May 07, 2026 at 04:21:28PM -0700, Paul E. McKenney wrote:
> 
> > Alternatively, if the bitlock acquisition is always a trylock-style
> > operation with no tight loop around the trylock, it should not be
> > necessary to disable preemption.  (Give or take the expectations of the
> > code in the critical section, of course!)
> 
> In dcache we have two of those - hash chains in the main dentry hash
> (insertion and removal only; RCU for traversals) and, more unpleasantly,
> hash chains in the in-lookup hash.  Those have search-and-insert-new
> and removal, the former with full traversal of the chain under the
> lock.
> 
> The entries are there for duration of ->lookup(), so it stuffing a lot
> of them in there might be feasible with a bunch of lookups for different
> names on a stuck network filesystem (each with a separate thread blocked
> waiting for server to reply)...

On the other hand, one penalty of permitting preemption of tasks holding
bitlocks is that if some task is preempted holding such a bitlock,
all attempts to acquire that bitlock will fail until that task gets to
run again.  And bitlocks don't do anything to identify who is holding
them, making debugging a bit more challenging.  :-/

							Thanx, Paul
