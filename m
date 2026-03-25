Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C5E231A21
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Mar 2026 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456944; cv=none; b=UeUnRAAvhdW1Hb0/N+quzIRKbXMnHHcbPSFJ8LnpH7Jc5I/LzUaAN8v7N8xH8fqo5bONzwu0+P3g2behfZZbny60m5IXa7NPtXH/F4ncIUcBOqM6rweeIY0BFRv0dx2RpIyzZig0Lvfkqy3CJNO8JLcrC58f+9KeOUMnpAqMPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456944; c=relaxed/simple;
	bh=Hoy4pyLMWkA1AgAFmSyBLQcric1Hwo5CREHMZ6kXurE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kmjNP+7tBgz45agK7WS6yBeIThewPV6e+V9fFq20FKZYdAQjxsmdm1oFVIRqtHCL6qNJZ/CCsK9oy9/eh1ocXfMR44f1bt/tv3NeBJD4nbxbmC6UCni/f4XYku1MHD3mm4k2IIE9PYDW3MsnMCIdDOfuoCwTQDXVSvIWly/V0iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDQur7C+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZDQur7C+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40042C4CEF7;
	Wed, 25 Mar 2026 16:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456944;
	bh=Hoy4pyLMWkA1AgAFmSyBLQcric1Hwo5CREHMZ6kXurE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZDQur7C+jmD+hIgflzjwRNJ1PGo+ESze0TcseRIol61PEQakk7QUCLxbMKwfpm/Vx
	 aVh+DyrGwgiBdVOHcmA5AMKIY0/DRZKe939h7WxFY9U25QXKp5BbJ+GYUjw74yNoSQ
	 aqQztcT5xIlIiG6z5oX2eIIX9RsmRVKCmByrlAq3W4dkPva5TOlYgHr3UkMQabL+Yy
	 lEXoHZowYZH3a65kvF79xtRqCcuK48eXf3Nder2YrDLe+cdGIgrJ44CC6t634sMxPL
	 ngn716dDolFSE8PNJ1SIugk0sB8j7Vn/kxDSV1d20w5VJh7/Hhv2AO7hfWSjR7Iief
	 an4TXCBxFxUaA==
Date: Wed, 25 Mar 2026 09:42:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Bernd Schubert <bschubert@ddn.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>
Subject: Re: [PATCH 12/19] fuse mount: Support synchronous FUSE_INIT
 (privileged daemon)
Message-ID: <20260325164223.GE6202@frogsfrogsfrogs>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-12-a52d3040af69@bsbernd.com>
 <20260324000350.GM6202@frogsfrogsfrogs>
 <e0d7b5ee-ffef-45a4-8c39-84cd79342bae@ddn.com>
 <20260324225012.GY6202@frogsfrogsfrogs>
 <10748cf4-ac68-45d5-9d56-999f45fcf3b2@bsbernd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10748cf4-ac68-45d5-9d56-999f45fcf3b2@bsbernd.com>

On Wed, Mar 25, 2026 at 08:52:59AM +0100, Bernd Schubert wrote:
> 
> 
> On 3/24/26 23:50, Darrick J. Wong wrote:
> > On Tue, Mar 24, 2026 at 08:42:36PM +0000, Bernd Schubert wrote:
> >> On 3/24/26 01:03, Darrick J. Wong wrote:
> >>> On Mon, Mar 23, 2026 at 06:45:07PM +0100, Bernd Schubert wrote:
> >>>> From: Bernd Schubert <bschubert@ddn.com>
> >>>>
> >>>> Add synchronous FUSE_INIT processing during mount() to
> >>>> enable early daemonization with proper error reporting
> >>>> to the parent process.
> >>>>
> >>>> A new mount thread is needed that handles FUSE_INIT and
> >>>> possible other requests at mount time (like getxattr for selinux).
> >>>> The kernel sends FUSE_INIT during the mount() syscall. Without a thread
> >>>> to process it, mount() blocks forever.
> >>>>
> >>>> Mount thread lifetime:
> >>>> Created before mount() syscall in fuse_start_sync_init_worker()
> >>>> Processes requests until se->mount_finished is set (after mount() returns)
> >>>> Joined after successful mount in fuse_wait_sync_init_completion()
> >>>> Cancelled if mount fails (direct → fusermount3 fallback)
> >>>
> >>> Hrmm, so the main thread (of the child process after daemonization)
> >>> calls mount(), having started a child thread to read and process
> >>> FUSE_INIT + any other mount-related fuse requests?
> >>>
> >>> Later I see an eventfd being used to signal this background thread that
> >>> it should exit and (presumably) let the real request processing queues
> >>> take over.  I'm curious why an eventfd here when pipes were used
> >>> earlier?
> >>
> >> We cannot use eventfds for anything possibly used by BSD - which is
> > 
> > (Yeah, I was wondering about eventfd, but I don't know how quickly
> > libfuse features get ported to BSD so for all I know it could be years
> > until BSD gets SYNC_INIT.)
> > 
> >> fuse_daemonize_ and fusermount. So far sync-init is only in the new
> >> mount API - linux only. We need to switch to a pipe if BSD ever gets that.
> > 
> > I wonder, are the socket communications between fusermount-libfuse
> > considered external interface?  I'm assuming it's not, and you can
> > change it as long as you don't break the other side?
> 
> I know that fusermount3 is also used by other userspace implementations
> like https://github.com/cberner/fuser
> 
> I would need to go through that code to see how it interacts exactly
> (had looked into a few months back, but don't remember the details
> anymore - that were some readmes would be really helpful). My assumption
> is that once we have a released interface in place we cannot easily
> change it anymore.

Heh.  Right, fusermount3 is in a bin directory, so yeah, anyone can exec
it and presumably they won't be happy if it starts speaking gibberish.

With sufficient motivation we could employ the neat systemd hack of
setting xattrs on the socket to proclaim new protocol versions ;)

--D

> 
> Thanks,
> Bernd
> 
