Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3891139EF1B
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 23:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773790754; cv=none; b=ZYyjSntIBOE+FLpl8O3XOoh7rYP2wAwEshzC4hu544MQYwB3oh+oWRKgpvqappsTpfqOGjhc4nohwNbLWidOctPSo/G2OpejtIgiE15Nzr8AbjEncPhQlwnTTpHxjlw6Do61xQF+vFZ059au/WlZ/rdbZ2vhSzJql+F3aiGkAaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773790754; c=relaxed/simple;
	bh=lkyUTbJoWEj/Nzma1bCxbYz0B2qo+wHC0Q6R/TNONMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3Dz4dziv96gPlHIOFTU5t3Aj9MppAupVNhzNtYl2l8oIqwYwY9aVEGiBBvbf4Mxx8PJxqrpPrrNAMZ1hlxXY4mZ72S+EpsTsX5M1GFp/+UpY/W/ShJnhr7ulmFXZyGREArlEPAqV2YL3wyrsD8VpPxF7J4A30M1/mePhWlHilk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GC+ViieW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GC+ViieW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11685C4CEF7;
	Tue, 17 Mar 2026 23:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773790754;
	bh=lkyUTbJoWEj/Nzma1bCxbYz0B2qo+wHC0Q6R/TNONMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GC+ViieWZxTCAV+48t6kegVDlN2vrhA4L4yo59SN0SxZd1rzWweZMsL4zpWs1zHGU
	 bNen6WV9djfvuEgnsOqvrBLFDhdRr6udHilDOnWv8q3OjVprHGqh5kMGIirO2Zq8Pv
	 /ZKz5F/nNhFT7Fpi0CPiAh5dzltEqXQvLHkEju+6Pze9UQ47mg/2yuXPrMPvOBDUy8
	 7rpE69UnSFBL0Ws6Uo6w28koZUi8d9b7q7GagdtqvxPer52ObtDpWiz1fTzg5G7DVk
	 17pzaQKiZl7xjQ+NQI6aiXrB0pm6dGiyGgx7fmptEOMF+V41KveoJHq3jDaVs9s8vh
	 SnlHrXX4PI4zQ==
Date: Tue, 17 Mar 2026 16:39:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bernd@bsbernd.com>
Subject: Re: [PATCH v2 3/6] fuse: don't require /dev/fuse fd to be kept open
 during mount
Message-ID: <20260317233913.GS6069@frogsfrogsfrogs>
References: <20260312194019.3077902-1-mszeredi@redhat.com>
 <20260312194019.3077902-4-mszeredi@redhat.com>
 <20260313230934.GG1742010@frogsfrogsfrogs>
 <CAJfpeguqNU_Q62vDS6nL_w3wBtGU8osE4d9pRFKFMVq-ATRFMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguqNU_Q62vDS6nL_w3wBtGU8osE4d9pRFKFMVq-ATRFMw@mail.gmail.com>

On Mon, Mar 16, 2026 at 12:29:53PM +0100, Miklos Szeredi wrote:
> On Sat, 14 Mar 2026 at 00:09, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > Hrmm, is this https://github.com/libfuse/libfuse/pull/1367 ?
> 
> Right.
> 
> > Which syscall causes the synchronous FUSE_INIT to be sent?  Is it
> > FSCONFIG_CMD_CREATE?
> 
> Yes.
> 
> > > The reason is that while all other threads will exit, the mounting
> > > thread (or process) will keep the device fd open, which will prevent
> > > an abort from happening.
> >
> > So I guess what's happening here is that the main thread calls
> > FSCONFIG_CMD_CREATE, which sends the synchronous FUSE_INIT to the worker
> > pool.  One of the worker threads starts working on the FUSE_INIT reply
> > and crashes.  All the *workers* terminate and close the fuse dev fd,
> > leaving just the main thread.
> >
> > AFAICT, the main thread is stuck in fsconfig() here:
> >
> >         /* Any signal may interrupt this */
> >                 err = wait_event_interruptible(req->waitq,
> >                                 test_bit(FR_FINISHED, &req->flags))
> >
> > so there's still an open ref to the fuse dev fd, which prevents anyone
> > from aborting the FUSE_INIT request so that FR_FINISH gets set?
> 
> Yes.
> 
> >  And now
> > we're just hosed?  Wouldn't the SIGCHLD interrupt the wait?  Or are we
> > stuck someplace else?
> 
> The FUSE_INIT request is in FR_SENT state, and fuse doesn't allow
> interrupting such requests without the cooperation of the server.
> 
> We could special case FUSE_INIT (and probably a number of other
> request types) that are safe to kill without the server's consent.
> Will look into this.

I wonder if there's a way to have a wait_event_killable that will wake
up if the process exits without being killed by a signal?  Or does it
already do that...

> >
> > > This is a regression from the async mount case, where the mount was done
> > > first, and the FUSE_INIT processing afterwards, in which case there's no
> > > such recursive syscall keeping the fd open.
> >
> > Is this hang possible if you're using mount(2) with synchronous
> > FUSE_INIT?
> 
> Yes.

Yikes.  I guess at least there's the echo > .../abort solution below.

> > > The solution is twofold:
> > >
> > >  a) use unshare(CLONE_FILES) in the mounting thread
> >
> > Is this after starting up the worker threads?  I guess that means the
> > worker threads retain their fuse dev fds even though...
> >
> > >     and close the device fd
> > >     after fsconfig(fs_fd, FSCONFIG_SET_STRING, "fd", ...)
> >
> > ...the main thread closes the fuse dev fd before FSCONFIG_CMD_CREATE.
> > What if that main thread needs to use the fuse dev fd after this point?
> > Or, what if userspace doesn't cooperate and unshare()/close()?  Can this
> > hang be broken by kill -9, at least?
> 
> No, only
> 
>   echo > /sys/fs/fuse/connections/NN/abort
> 
> >
> > >  b) only reference the fuse_dev from fs_context not the device file itself
> >
> > Can you set an abort timeout on the FUSE_INIT request?
> 
> I don't like timeouts, but yes, we could.

<nod> Or *some* means of figuring out that one of the other threads has
crashed the process, so we might as well cancel the wait_event?

> >
> > Perhaps my broader question is, what /does/ happen if a fuse server
> > thread starts processing a request and crashes out before replying?  I
> > guess that means the request is never completed, but in the case of
> > !(synchronous FUSE_INIT) we'd just see the whole server terminate, which
> > would then release the fuse dev fd?
> 
> Right.

(I forget, what was the purpose of synchronous FUSE_INIT?)

--D

> Thanks,
> Miklos
