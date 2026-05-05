Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463554921BA;
	Tue,  5 May 2026 22:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018897; cv=none; b=k4WumB0X5GA28QLkSY4E4sKV+YpkrWFF6qbbdBg80mmT0M1VNZAABpgyoTwoPwLntIf8fQIOVI65DCCL9GUg06UQUOsV+68WAocjdGhfXzNOAtXW2nTsoe+EFOEY1+GaCCGYB3/OpP0bBte7n/kDWnfmgcH8461KWA38Eslcuqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018897; c=relaxed/simple;
	bh=G6ackGx0k2Tc1/1RLJh2MtbsUqfWKgNc3pKER+WmBJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWELyC63cOF2sb49wuwcP0xSiWruP92oVdFtgEGxMt08oGXTQduIme01Ft6d+q4ntXs2U3SkXk5ZL4nBo85I9CBdNw97p1oOdLDdNt+Ou6mqXV5Y/f4DVSinhQtmbhAashhOgtN3XRzEz9kBcL1/WPdxTA2XtsmWmCgvqPaibK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EP2griEy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP2griEy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32F0C2BCB4;
	Tue,  5 May 2026 22:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778018897;
	bh=G6ackGx0k2Tc1/1RLJh2MtbsUqfWKgNc3pKER+WmBJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EP2griEyfRbrcYEKD4CJkN46fX/ZkHkS7h6o3hIZfUjQ6m4JKFXxbMTHve7YSUreT
	 k/oBRtvzdAMKUI/75ebpHwLCO9KLXhbCABwH02iG723+SPBoZBnCWDfUSN8J86YVSp
	 V+Uh02vN98CUEdMEBPMlcM00MjF772MuZbjvZba5dFOKiLSG2tizVDuwImfJ4hIBad
	 ai7S+PrW0pKO44xYep89RA0hfuN4ia+YWwGkpgOdhuJXvbQOJJZWS8gGVj1Lpq7IAf
	 wZzgCxjFUmDaIsazcmqFWdxUQvVtHLI3IdyFbEczIJNsB4N3Vjrjd/ZeXOq7QPckXy
	 rbDdSI6NiqvMg==
Date: Tue, 5 May 2026 15:08:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
Subject: Re: [PATCH v1.1 1/2] libfuse: don't use SYNC_INIT unless asked for
Message-ID: <20260505220816.GS7765@frogsfrogsfrogs>
References: <177795853450.1133476.8692790530314969678.stgit@frogsfrogsfrogs>
 <177795853473.1133476.16730865173873586203.stgit@frogsfrogsfrogs>
 <20260505164428.GC7739@frogsfrogsfrogs>
 <0de919e0-7d90-4fad-bf93-656bfd28ad7d@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0de919e0-7d90-4fad-bf93-656bfd28ad7d@bsbernd.com>

On Tue, May 05, 2026 at 10:02:18PM +0200, Bernd Schubert wrote:
> 
> 
> On 5/5/26 18:44, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > fuse2fs calls fuse_main, then starts threads from ->init.  It doesn't
> > call fuse_daemonize_early_start because I haven't ported it to use any
> > of the new APIs.  I don't have io_uring enabled for fuse on my dev box.
> > 
> > fuse_main calls fuse_session_mount calls fuse_session_mount_new_api
> > calls session_start_sync_init.  At the start of the function,
> > se->want_sync_init, se->uring.enable, and daemonize.active are all
> > false.  The first branch is not taken, so we call FUSE_DEV_IOC_SYNC_INIT
> > and enable sync_init even though the user didn't ask for that and didn't
> > prepare for it either.
> > 
> > FUSE_DEV_IOC_SYNC_INIT succeeds, so we send the synchronous FUSE_INIT
> > from mount, which calls fuse2fs' init() method.  That starts the
> > background threads and returns.  Upon return to the kernel, the mount()
> > now succeeds, and the next thing that fuse_main does is call
> > fuse_daemonize().  Since we didn't call fuse_daemonize_early_start, the
> > daemonize forks the process and the threads die with the parent.
> > 
> > If we didn't ask for SYNC_INIT, don't enable it.  This is needed to
> > maintain compatibility with older fuse servers that only support
> > asynchronous FUSE_INIT.
> > 
> > Fixes: 3e1101057aea57 ("fuse mount: Support synchronous FUSE_INIT (privileged daemon)")
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> > v1.1: improve commit message, refine logging logic
> > ---
> >  lib/fuse_lowlevel.c |   18 +++++++++++++++---
> >  1 file changed, 15 insertions(+), 3 deletions(-)
> > 
> > diff --git a/lib/fuse_lowlevel.c b/lib/fuse_lowlevel.c
> > index 0e16845d2f14ff..83158d02bb8827 100644
> > --- a/lib/fuse_lowlevel.c
> > +++ b/lib/fuse_lowlevel.c
> > @@ -4475,9 +4475,21 @@ static int session_start_sync_init(struct fuse_session *se, int fd)
> >  {
> >  	int err, res;
> >  
> > -	if (!se->want_sync_init &&
> > -		(se->uring.enable && !fuse_daemonize_is_used())) {
> > -		if (se->debug)
> > +	if (!se->want_sync_init) {
> > +		/*
> > +		 * SYNC_INIT is required for io_uring to initialize without
> > +		 * deadlocking the kernel if the fuse server crashes.
> > +		 *
> > +		 * !fuse_daemonize_is_used implies the fuse server doesn't know
> > +		 * about any of the SYNC_INIT APIs, so we don't enable sync
> > +		 * init or generate log messages.
> > +		 */
> > +		if (se->uring.enable)
> > +			fuse_log(FUSE_LOG_DEBUG,
> > +					"fuse: io_uring broken with async init\n");
> 
> So want_sync_init is not enabled and it still logs this? Note that
> default libfuse does not have a way to set log levels.

I'm not 

> > +		else if (!fuse_daemonize_is_used())
> > +			; /* empty */
> 
> Unless I misread it, it would still go into the return 0?

Correct.

> > +		else if (se->debug)
> >  			fuse_log(FUSE_LOG_DEBUG,
> >  					"fuse: sync init not enabled\n");
> 
> And now every time a log message here.

Only if you enable debug mode.

> >  		return 0;
> 
> Why can't we change it to
> 
> if (!fuse_daemonize_is_used() && !want_sync_init)
>        return 0;

That works for me.

> If someone uses then new mount API, that someone has also tested sync
> init.

I'm confused by this statement.

In this early bailout case (fuse server did not call
fuse_daemonize_early_start or fuse_session_want_sync_init) we return 0
without actually setting SYNC_INIT, correct?

Next, fuse_session_mount_new_api calls fuse_kern_fsmount_mo and libfuse
proceeds to mount with the new mount API.  The kernel uses the old async
init code, because nobody told it to do a synchronous init.

That sequence works fine, and I can prove it by strace'ing fuse2fs
startup.  The new mount API is used, but FUSE_INIT isn't seen by fuse2fs
until after the fuse_daemonize() call and the event loop gets set up.

In other words, fuse2fs uses the new mount API and does not use sync
init.  I think the correct statement is the inverse:

    If someone uses sync_init, that someone has also tested the new
    mount API.

My understanding of where we are right now is:

1. If a fuse server starts up the new daemonize code or sets
   want_sync_init, it will get SYNC_INIT.

   (I'm not sure what it means if they set want_sync_init and try to
   use the old daemonize code)

2. If it does neither of those things, it will not get SYNC_INIT.

In both cases we try the new fsmount().  If the fsmount API fails, then
we fall back to the classic mount().

Is that correct?

> At best we could change want_sync_init to an integer so that a
> daemon could disable sync init.
> For testing I'm probably also going to add an env variable that allows
> to disable sync init.

<shrug> That sounds ok to me.

> Btw, during the meetings I had asked AI to write tests for sync init,
> looks like "ro" doesn't work yet. AI had created patch to fix that, but
> I don't apply either the test nor the fix yet, need to carefully read
> through it, but need to do something else before going to bed.

Oh, yeah, mount_flags[] needs to have:

{"rw",           MS_RDONLY,        0,  1,    MOUNT_ATTR_RDONLY},
{"ro",           MS_RDONLY,        1,  1,    MOUNT_ATTR_RDONLY},

Sorry I missed that in the review.  I also missed that mount_service.c
should be ported to use mount_flags[].

--D
