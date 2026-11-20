Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199090;
	b=dIeHnug6Uc+XsziFAy7YMlsJu1BYfz3nj1Lh9QvDKFJGJiIIoe9t9w+c8hjKdFT6WBo7
	 VFd6qOrphAhsSWmVSWQYRxo592mANJysxMDgnrjUgoiaqNL7N/UY8RtHGA5IjtAVSS53e
	 YEa7Vas4ELEZ8CdnObrP/CICtymQXEE8nGVTNImBizxmVW5p9rLlXcVvuhDYn0cUIjMte
	 3bdsPwO/MciqLKy+mJ3AwqOzaWmvJ2+92+Vyy/WIkoGhOahbJtBB+9siqD1rNHCIpf6N0
	 0VQGVtbJrBvnnha6vfCTkbErZJU8qVXQOX0XpQ/aCCr4IgQwfI21mVSxYeSLR1d761A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199090;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PIIDtE4edU/OQY26iA1OPctXW6xqxybU2sM7rsLpJco=;
	b=AKZ9Sh+jfN1Jer4OHrW3h2bprTN0Tn9+FLBcY9cEpM1VVK5hRfFQJXyOE+STL+eTBuww
	 RdnTfrh+LOFNh7BHPeeRNVtb9r9jlghfZ7jK9VQrqXFiQbIFnuHUCAy9KM/cjrmIZzisU
	 UnJT3J80vBbCGqJ1WzHMjicLmOuPt+yPC59ejt6oHznnPaGulS416h9twavd8dgt9H7Rc
	 ovpxL7Jj3bmm7/O8yy1Qf3ALXK4PkpQdICEtKHfxKnCtZen0EevW8nD6TMOc/sbeTWn86
	 +H9ji3F1/fu9ZgChtsBLgYwja91/kjZ9WJdkkqHmu2OVHHMtsl4sWMaChvbzWIoEKZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jVhRnT7c;
	arc=none smtp.remote-ip=95.215.58.225
Received: from mta1.migadu.com (out-225.mta1.migadu.com [95.215.58.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8661C606A33B
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 18:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8661C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jVhRnT7c
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7bYe9wd7HhUkjg17+eOnOTO+gnBeFLd88cIA6k1y3Y8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795199087; v=1; x=1795803887;
 b=jVhRnT7cn5OhVwxLTsixFhnmLnXX317bGlMjMb5w2CP9Z4KQQGtg4t3yGoSIYhvdbnvYuKpa
 vlCi3X6tr4i0WPhuwegN/VAJ6Sf6ZPPuV+MjXOjay+BvNheV9AtAHDu9eGXCjYAUq30RRxz9znM
 8Cmr2t45Iblw6NEXSpVK0bq0=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 9d8f2b63d07da3cb;
	Fri, 20 Nov 2026 18:24:47 +0000
X-Mizu-Trace-ID: 9d8f2b63d07da3cb
X-Migadu-Flow: FLOW_OUT
Date: Fri, 20 Nov 2026 10:24:46 -0800
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: allocate the inode for cgroup_may_write() before
 cgroup_mutex
Message-ID: <awCLBDApSWwDsBB_@linux.dev>
References: <20261118230346.3700213-1-shakeel.butt@linux.dev>
 <b8b2c07c12f5a156e2d72ab4ee4444cc@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b2c07c12f5a156e2d72ab4ee4444cc@kernel.org>

On Fri, Nov 20, 2026 at 01:24:18AM -1000, Tejun Heo wrote:
> Hello, Shakeel.
> 
> On Wed, Nov 18, 2026 at 03:03:45PM -0800, Shakeel Butt wrote:
> > +	dst_cgrp = cgroup_kn_break_active(of->kn);
> >  	if (IS_ERR(dst_cgrp))
> >  		return PTR_ERR(dst_cgrp);
> > +	new = new_inode(of->file->f_path.dentry->d_sb);
> > +	cgroup_lock();
> 
> I don't really like new_inode() being called on every write, and twice on
> every clone3(CLONE_INTO_CGROUP). The inode is often not cached but not
> mostly. It's not a lot of overhead, but doing it the right way isn't that
> complicated either. How about peeking at the inode cache before taking the
> locks, preallocating only when the peek misses, and then looking up again
> under cgroup_mutex? If the peek turns out wrong, it can drop the locks,
> allocate and retry, so that nothing is allocated under the lock.

Thanks for taking a look and yes, this makes sense.

> Can we
> apply the same shape in other places too?

Yes, I agree, though I will do that in followup patches. More specifically I
think I can do the same approach in __kernfs_fh_to_dentry() and
kernfs_get_parent_dentry() for inode. For kernfs_setattr(), I think I can use
the same approach for iattrs. Also I am working on allocating css for new cgroup
before cgroup_mutex in mkdir wich will use similar approach.

> 
> > 	scoped_with_creds(of->file->f_cred)
> > -		ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
> > -						of->file->f_path.dentry->d_sb,
> > +		ret = cgroup_attach_permissions(src_cgrp, dst_cgrp, &new,
> > 						threadgroup, ctx->ns);
> 
> AFAICS, this changes behavior under Smack. Smack labels a new inode from the
> allocating task's creds, and the allocation used to be inside
> scoped_with_creds(). Now the inode gets the writer's label and the
> permission check runs with the opener's creds, which can fail when the two
> differ. Maybe the allocation can use the opener's creds too?

Thanks for catching this. I will make sure this remain the same in the v2.
