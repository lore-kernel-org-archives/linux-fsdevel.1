Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0E835AC0B;
	Tue,  5 May 2026 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777998445; cv=none; b=WpYB3hs4Upc0gNWmXpA6hdFZUtn1elhuZFSGKBo/4hcgFvJOswqv6iONai2hKEd//RkNllbCbfjw8XEnkPv5OcXHfmedt8kxpKhCkEvT3uIJb9Q722FkTXaTe3CmcYcqKARsAhv4aZVcbRHoClNneop4GBexjCLd0R8ibl+V3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777998445; c=relaxed/simple;
	bh=Ec6mMkn2zXIg9PkBMv6BC9JSNkpZ18JeypVxaBgfaRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urXJMeziCDxn4EOqSFpPf+xrZ8KgdkLTSx4odaaQxc6q1+rBmCCb9N6nD9QMwOUlT5DTsDLA1MMspzBvxxCYLTd5DpN4Xk/+RIg6iEvCGwQMcEvyv5hzm9eNzZtUYRRwt8d6plIJ3RjKK1dcztXR7kHA4odwJ5NOkvai59ssh3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvCQO39q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvCQO39q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF1BC2BCB4;
	Tue,  5 May 2026 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777998445;
	bh=Ec6mMkn2zXIg9PkBMv6BC9JSNkpZ18JeypVxaBgfaRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvCQO39qOu42Aj9gyTmmo3i4YpFa/yFXDqsnw76u/DoiAjSUDVGHyj5uVj+aGx0mu
	 0l+TswOsU6AHMrAgIddWQL9RuvZPhBKe0HlDukK48PRBb2KJ9Ay+3mWZyJsfoibqeD
	 zGx+TT8Dh2vV0BpdNLXq96lpmfiO7K0h/BE398oNvJPhzDEzE35Ldau/mW33hGZBcB
	 abzWCGfoy8qQNPmzrqHrLIHeN1nzwPXvrca7dNNujHIMxXUwA4LqgMUNXMSf+g/ghi
	 EXNybv+P4ow5GR5V/8xZ1YX7uzvG/OyvnA31JqBKBnA1iYlVBPZPLRUmAtrCwtK+Wx
	 sW7BlbCFaPwNQ==
Date: Tue, 5 May 2026 09:27:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Subject: Re: [PATCH 1/2] libfuse: don't use SYNC_INIT unless asked for
Message-ID: <20260505162724.GA7739@frogsfrogsfrogs>
References: <177795853450.1133476.8692790530314969678.stgit@frogsfrogsfrogs>
 <177795853473.1133476.16730865173873586203.stgit@frogsfrogsfrogs>
 <b023fe55-c8a5-40ed-be37-a21e1682b509@bsbernd.com>
 <52bf2b08-49e6-4484-8222-b0ef8473b912@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52bf2b08-49e6-4484-8222-b0ef8473b912@bsbernd.com>

On Tue, May 05, 2026 at 10:17:54AM +0200, Bernd Schubert wrote:
> 
> 
> On 5/5/26 09:30, Bernd Schubert wrote:
> > 
> > 
> > On 5/5/26 07:23, Darrick J. Wong wrote:
> >> From: Darrick J. Wong <djwong@kernel.org>
> >>
> >> If we didn't ask for SYNC_INIT, don't enable it.  This is needed to
> >> maintain compatibility with older fuse servers that only support
> >> asynchronous FUSE_INIT.
> >>
> >> Fixes: 3e1101057aea57 ("fuse mount: Support synchronous FUSE_INIT (privileged daemon)")
> >> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> >> ---
> >>  lib/fuse_lowlevel.c |    6 +++---
> >>  1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >>
> >> diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> >> index 0e16845d2f14ff..0a801132590079 100644
> >> --- a/lib/fuse_lowlevel.c
> >> +++ b/lib/fuse_lowlevel.c
> >> @@ -4475,9 +4475,9 @@ static int session_start_sync_init(struct fuse_session *se, int fd)
> >>  {
> >>  	int err, res;
> >>  
> >> -	if (!se->want_sync_init &&
> >> -		(se->uring.enable && !fuse_daemonize_is_used())) {
> >> -		if (se->debug)
> >> +	if (!se->want_sync_init) {
> >> +		/* SYNC_INIT is required for io_uring(?) */
> >> +		if ((se->uring.enable && !fuse_daemonize_is_used()) || se->debug)
> >>  			fuse_log(FUSE_LOG_DEBUG,
> >>  					"fuse: sync init not enabled\n");
> >>  		return 0;
> >>
> > 
> > Hmm, but mounting is kind of a libuse internal part? If this is really
> > needed the commit message should mention the exact reason - what is the
> > issue with old fuse servers and sync init?

fuse2fs calls fuse_main, then starts threads from ->init.  It doesn't
call fuse_daemonize_early_start because I haven't ported it to use any
of the new APIs.  I don't have io_uring enabled for fuse on my dev box.

fuse_main calls fuse_session_mount calls fuse_session_mount_new_api
calls session_start_sync_init.  At the start of the function,
se->want_sync_init, se->uring.enable, and daemonize.active are all
false.  The first branch is not taken, so we call FUSE_DEV_IOC_SYNC_INIT
and enable sync_init even though the user didn't ask for that and didn't
prepare for it either.

FUSE_DEV_IOC_SYNC_INIT succeeds, so we send the synchronous FUSE_INIT
from mount, which calls fuse2fs' init() method.  That starts the
background threads and returns.  Upon return to the kernel, the mount()
now succeeds, and the next thing that fuse_main does is call
fuse_daemonize().  Since we didn't call fuse_daemonize_early_start, the
daemonize forks the process and the threads die with the parent.

Looking at that logic a little more, I /think/ you could enable sync
init for fuse servers if they've called fuse_daemonize_early_start even
if they haven't called fuse_session_want_sync_init:

	/*
	 * The fuse server didn't explicitly ask for SYNC_INIT and it
	 * didn't call fuse_daemonize_early_start.  Assume this server
	 * was written before SYNC_INIT and continue using async init.
	 */
	if (!se->want_sync_init && !fuse_daemonize_is_used()) {
		/*
		 * The io_uring backend requires SYNC_INIT because
		 * $reasons, so log a message if we're not enabling
		 * that.
		 */
		if (se->uring.enable)
			fuse_log(..., "io_uring broken with async init");
		else if (se->debug)
			fuse_log(..., "sync init not enabled");
		return 0;
	}

Since (to the extent that I'm familiar with what fuse servers really do
with libfuse) I haven't seen anything that would be a problem.  However
the more cautious thing to do would be to continue using async init
unless fuse_session_want_sync_init is called.

> One reason I can think off is if the ->init() method starts new threads.
> In that case we could still do allow the new mount API when the new
> daemonize API is used.

Yes.  The new mount api still works (modulo patch 2) even if the
SYNC_INIT stuff isn't used.

--D
