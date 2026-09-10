Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2009429CE8;
	Thu, 10 Sep 2026 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074757; cv=none; b=UXSOgoTTshXG3nlrDQ8G/8BagvXlUTrDZ/1gmbmqAgfiIfAHm+b2GoMhOrS5z4LXby+l5WsLBQfmrxCJv5AGFVNqlUk1U7QJFwDW1DzvMiAk2xdl/95W2hVWejc6kS3CCa7L2u2HTyar1hcQ9sg/MySi7lv7Drh7qbW6Iz9B1cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074757; c=relaxed/simple;
	bh=guLM49YgNyVFb9uZfhXIehQg/5R97Nz9UbY8pbHQJBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tb1OnlBqDzIZ3Vp331yIdIxu9+Jg1jeni3K4YQFNc9/n1cRKDzFqdfZAnZh6f03EVZRe/dkO2n9i+hyu8Wf2i5yJl+/bneDVfm+hR1mTf2ziUpnCB107pEHw8y0+VFohiMKnZ2LKd01rtXqePigsmb7MTq2gLApQB5CpzEiFTTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYOiTSC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYOiTSC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC091F000FF;
	Thu, 10 Sep 2026 21:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789074743;
	bh=MCGkKlQ8M0AsOqyjrZvFPwfseu14cQ6jl3sxq1qsu5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MYOiTSC0JmzJcB8xgUbyhKTmzwLz5Ufnt/u0n81P8iPUb9zUbM91Cjqpn8ZytueFC
	 tPFJvLAIAmIsfl7XWL6Wn8XY7iIIhPZb6Up/u7p/mRdss47JVzreNh1ZZ/ar1Uc759
	 U2tnUj/z9UMMi6NDzr0oo3SCoJJnNuIXtv5MTXmzuNsJEgnknPpxdJ8z5mgg+zNgca
	 VJzNF+QFKEDJqNeq+ygl7BM69QaL8z8ns2LE6OrrZjiAW308UhuhRZKnf2G9KEcQDT
	 +uPDPvgsn+KNVmvV9TignjF2IycDQhJs8lMhyAJIlIAZ9qbJI959DofyCm4X1lmiME
	 tqOq+MNEaK80w==
Date: Thu, 10 Sep 2026 11:12:22 -1000
From: Tejun Heo <tj@kernel.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <christian@brauner.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: don't hold kernfs_rwsem across notification
 delivery
Message-ID: <aqMdNoXA0LIYFpQW@slm.duckdns.org>
References: <20260910045406.485295-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910045406.485295-1-shakeel.butt@linux.dev>

On Wed, Sep 09, 2026 at 09:54:06PM -0700, Shakeel Butt wrote:
> Recently at Meta we noticed that on multi-tenant systems, a workload
> under extreme memory pressure negatively impacts unrelated workloads and
> system daemons like below [1] and fb-oomd [2]. Mainly we observed that
> system daemons were stuck on kernfs_rwsem in cgroup-related interfaces
> for long periods of time.
> 
> On further inspection, we found that the workload under pressure had
> registered inotify watches on its memory.events and was continuously
> receiving limit-hitting notifications. The cgroup notification is done in
> kernfs_notify_workfn(), which holds kernfs_supers_rwsem and kernfs_rwsem
> and calls fsnotify(), which allocates the event with
> kmalloc(GFP_KERNEL_ACCOUNT|__GFP_RETRY_MAYFAIL) charged to the watching
> cgroup, which is already under memory pressure. So the notify worker
> ended up in memory reclaim of a cgroup already under pressure, and itself
> kept triggering the limit notifications.
> 
> This notification path takes the locks in read mode, but a waiting writer
> blocks all future readers. That is exactly what is happening in the Meta
> fleet, and it leaves daemons that are critical to the reliability of the
> system stuck for long periods of time.
> 
> Commit 400188ae361a ("kernfs: Acquire kernfs_rwsem in
> kernfs_notify_workfn().") added kernfs_rwsem just to safely read
> kernfs_node::name.  Let's sample the name once before the loop and drop
> the lock.  kernfs_supers_rwsem still covers the list, and the removal
> paths take that one for reading too, so a stalled worker can still hold
> a removal up once a mount or unmount is queued behind it.
> 
> Two things change for a watcher.  A name longer than NAME_MAX now gives
> an event with no name, where before it gave one with the full name;
> fsnotify() takes the name as optional, so the event still arrives.  And
> the name and the parent are no longer sampled under one lock, so a rename
> between the two would name a file against the directory it moved to.
> That cannot happen today: kernfs_notify() rejects anything that is not a
> file, and no caller of kernfs_rename_ns() renames one.
> 
> [1] https://github.com/facebookincubator/below
> [2] https://github.com/facebookincubator/oomd
> 
> Fixes: 400188ae361a ("kernfs: Acquire kernfs_rwsem in kernfs_notify_workfn().")
> Assisted-by: LLM
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
