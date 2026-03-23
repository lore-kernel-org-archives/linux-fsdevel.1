Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63D630FF30
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291501; cv=none; b=jYpqRsbYT3FMsgOtDnHsR325Wl2a84gRNT/EYVak9CJ1bpR+fT6249HLqBDzyv3Zek36M7/feFuaBBw+bZpmSaqnl0byJFE+gPpElq2LTrOmCjqgYYoB059s2/bZLhBVtq1gEfzGdv/tMZAUVEIA8wxEnmnCEjDXJERwlIFCcag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291501; c=relaxed/simple;
	bh=9TgfKq8euOwy5rWqMXQH1vG9vjV4GH6u4Q0pi61y4yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiWmCVyCV/F/1CSS0FcWAV3h1b3Eq30YnYW8ENY5VUIjv5Q8kM/EVjg8IB7w+1hnma4IQWekAnZukgblmHTol7KnsurH+efB3ozn6R5LsK0ZjOho9wfd7vL3RKNJ9ZRrcu8od/9OmrX2o3cLr9jZnrDtPHDvy70gCkYTAZ3ymCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh+9k1z0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh+9k1z0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E022C4CEF7;
	Mon, 23 Mar 2026 18:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774291501;
	bh=9TgfKq8euOwy5rWqMXQH1vG9vjV4GH6u4Q0pi61y4yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jh+9k1z0JgCF3RnvgSSreinrXsRpYIDRPY2wUdJjJNRr17W/m5rjDub4D4aN30VC/
	 6WU36JN3Qlx54UduqC/lnvKo5hF5InCuetgdShiUIY9u1GeVEqbvQ5dnPEyXznpsd2
	 UTsTwCD7bMcF8SIgxWOvLnbh9s8vLAxjlwkaUM6nvHNYF3D3oI4M7oaWJHcCSCClnJ
	 vwlG8gEplcc2WEDDYy+vgmn5n1yIuwFvtYnGNamvmeOxl8ncSorJIC7m3NE97QtV66
	 2uWZ6grPeyKIlt1WSrAjRdCJyqCk1ok42UhFGnMSExxOidIt7XW9iyncWzlODb9wl4
	 PgVijh+yoizNQ==
Date: Mon, 23 Mar 2026 11:45:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] fuse: alloc pqueue before installing fc
Message-ID: <20260323184500.GD6202@frogsfrogsfrogs>
References: <20260316165320.3245526-1-mszeredi@redhat.com>
 <20260316165320.3245526-7-mszeredi@redhat.com>
 <20260323182249.GC6202@frogsfrogsfrogs>
 <a32528a5-0717-43ea-bfc3-ab61eba9dae8@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a32528a5-0717-43ea-bfc3-ab61eba9dae8@bsbernd.com>

On Mon, Mar 23, 2026 at 07:33:10PM +0100, Bernd Schubert wrote:
> 
> 
> On 3/23/26 19:22, Darrick J. Wong wrote:
> > On Mon, Mar 16, 2026 at 05:53:17PM +0100, Miklos Szeredi wrote:
> >> Prior to this patchset, fuse_dev (containing fuse_pqueue) was allocated on
> >> mount.  But now fuse_dev is allocated when opening /dev/fuse, even though
> >> the queues are not needed at that time.
> >>
> >> Delay allocation of the pqueue (4k worth of list_head) just before mounting
> >> or cloning a device.
> >>
> >> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > 
> > I wonder if this is worth the extra complexity to defer a memory
> > allocation?  If the fuse server actually mount()s then we need the
> > pqueues, right?  How common is it for a fuse server to open the
> > /dev/fuse when the kernel is so low on memory that the open() would fail
> > with ENOMEM on account of the pqueue allocation?  And is it likely that
> > a lot of memory would be freed up by the time we get to mount/clone?
> > 
> > I suppose if you had a very slow mounting fuse server this could happen,
> > but now everyone has to understand that fud->pq.processing can be NULL.
> 
> I guess the issue is that people might abuse it and open /dev/fuse for fun?

Ah, right, I forget that /dev/fuse is world-writable now.  Yeah, we
shouldn't let any idiot pin a bunch of kernel memory. :)

I think the commit message should include that:

"Prior to this patchset, fuse_dev (containing fuse_pqueue) was allocated
on mount.  But now fuse_dev is allocated when opening /dev/fuse, even
though the queues are not needed at that time.

"Delay allocation of the pqueue (4k worth of list_head) just before
mounting or cloning a device.

"Various distributions (e.g. Debian/Fedora) configure /dev/fuse as world
writable, so the pqueue allocation should be deferred to a privileged
operation (mount) to prevent unprivileged userspace from consuming
pinned kernel memory."

With that justification,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D
