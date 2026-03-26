Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7F8324B31
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 22:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774564420; cv=none; b=ThjIYNo8uw4/RbsbZHRNu/Zv06imEJTWIv54r9DwYR+isOF+ZYMOaI7RS5joyep305SOFdF3ZX5U3w+/XHqxelCMzCrNe45TjzPVLuw8LzN5MjIMbYrf5Sl8GQf6mIxpmXC0zeLP0kaNfHRMO3/q2OoCKf85W1/OK8nwiEzS4F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774564420; c=relaxed/simple;
	bh=C+3Y7JW83WkyCE2HcoUwZdvcZTenbTyn36DJJ/n7vJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcVfJq+eO4+PPAkVZli40gCOsI+cM8AL/pBd/BN+QhPZm7devtTtFqJ/faH/1gvKYVh2sOVXyG8v5SFdOGQh3LZWJ5904DpFZa9mQruskvUy3supEd0Jnuvi7ZqLgecFyR7O0wa5iu4amhjxU7a2QwV4Ko3TPvT7u1f+oSfDLBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgnPQHFv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgnPQHFv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29C9DC116C6;
	Thu, 26 Mar 2026 22:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774564420;
	bh=C+3Y7JW83WkyCE2HcoUwZdvcZTenbTyn36DJJ/n7vJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OgnPQHFv6Jl6DSwQ5bjECExGcQh5tGJIuXe0Q5Hhjs+oV3E/hUPYE2OqJjHnA8jK8
	 8e+PbtEezpIJKgq0tbNm4lR2Fs660zIQTXn/LJ/xcEoAK2yTDTxj2zgKmISKdaOny8
	 qTEqyio2obqkTqjF23Tcqptf/XukadTeHJMGUyROt39l/5GSqsXSxZ1LvLvI2Irscj
	 uHctpwHeyUgG6KOZXeZpguocW3SUmIS3I7mKMwEaL6wZFx6yomsp6V/j7CSMu8hvlP
	 OwdQ+BQviUOkWBF25/q08dmIGZrCwYHrQR0u9NaFSyGpE6ffT/pYmRUufCfnwwAhBY
	 NGDio15MBCJ0Q==
Date: Thu, 26 Mar 2026 15:33:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Bernd Schubert <bernd@bsbernd.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>
Subject: Re: [PATCH 12/19] fuse mount: Support synchronous FUSE_INIT
 (privileged daemon)
Message-ID: <20260326223339.GE6254@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-12-a52d3040af69@bsbernd.com>
 <20260324000350.GM6202@frogsfrogsfrogs>
 <e0d7b5ee-ffef-45a4-8c39-84cd79342bae@ddn.com>
 <20260324225012.GY6202@frogsfrogsfrogs>
 <4fd3c5e8-89e0-4356-ab50-4aa7544a142f@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fd3c5e8-89e0-4356-ab50-4aa7544a142f@ddn.com>

On Thu, Mar 26, 2026 at 08:32:23PM +0100, Bernd Schubert wrote:
> 
> 
> On 3/24/26 23:50, Darrick J. Wong wrote:
> > On Tue, Mar 24, 2026 at 08:42:36PM +0000, Bernd Schubert wrote:
> >> On 3/24/26 01:03, Darrick J. Wong wrote:
> >> Next on my list is to look into the fuse-io-uring issues that Kevin also
> >> reports with this patch series.
> > 
> > Heh, well, at least it isn't pthread_cancel anymore :)
> 
> 
> So the ugly part here is that one needs to call fuse_daemonize_success()
> success twice. Once from ->init() and once after fuse_session_mount().
> fuse_daemonize_success() will then check itself if this is sync-init or
> async init. Making it conditional in the daemon code itself would be
> possible, but it would need two different api calls. ->init() gets
> fuse_conn_info and main() or whatever created the session has 'struct
> fuse_session'.
> Issue here was that I had fuse_daemonize_success() in ->init (sfs_init)
> and it signaled the parent that the mount was completed before it was
> actually complete with sync init. With io-uring another 300ms delay to
> create the rings - enough to make xfstests to fail.

Huh.  What failure did you get?  Is this the kernel trying to send
commands and failing because fuse_uring_wake_ring_threads hasn't been
done yet?

I see you've posted your new patchset so I'll go hunt through there.

--D

> With that change of behavior I'm not even sure anymore if we can make
> sync init a default.
> 
> Currently have xfstests running (also testing the reduced queue patches
> with that) and will sent out new patches one that completes.
> 
> Cheers,
> Bernd
