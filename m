Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A153F9F42;
	Thu, 26 Mar 2026 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774536131; cv=none; b=jMwhspc4okzWIbnRkZSz5xasSfXCKOig9QyIZpVdGm2GOI+panQhf2YKh3iIXFgNkP0Py1rCfAX7JSaSnnqed+D1D+gl1avy4LVXmILg+1y1aFqKxa2nx0dAbaqDyLgrzNlbnUMSdyAYZSj0LtTzxn/UlNdG9SA9wQ2De0GYai4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774536131; c=relaxed/simple;
	bh=cjHKI5KfvI2JCI8xPtf9BRxhPAS3EmmfXSVaOQPum3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVNqPeEuiKeAkyo7QOF74xwXAFxF92dim6jq501ODEmkKa/7R4q2PCntSQFVmDGZhfuFMY7og0qggYfbQPa+AygRMWUbGoPsOw3URVvR2uYV/MWtp1XRhWW69dfu3L2zIyqCxS8EH3jR+IYHb74BtYuzqZlotmbCsOvGMvtMmOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTcjvNNA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTcjvNNA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB2DCC19423;
	Thu, 26 Mar 2026 14:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774536131;
	bh=cjHKI5KfvI2JCI8xPtf9BRxhPAS3EmmfXSVaOQPum3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTcjvNNAdLJAoahFvJ5LUejw2Tcgc0eH6Afyqffoo/xUhiuu6SUwlq9km8o7rk/dg
	 3jQKJJrwXMa9IX/ucCA/TcJCWnvM+mFl1HLnOWixV/Nak9gtWbyTDEJY4u+XPJR6l/
	 uqJL98gwTvLdjxrrtp9htW61+p8/RnQKygnrjAN9rh+5/sXDKaWAeWTQZLg+X3vsRU
	 khFGMDjAryF1ZeyuwksmqC/RYJmAi11lC1bShn4/g/afq4WpUDITz/yjuH3N8DeWLu
	 cSNf65CzXF51mDvv9Qjf0hd5t6tClB5hYCTmjI/k7nrFwJ/Y8VkEMAmxWEtjeiwE/b
	 kC07EmYpCstrg==
Date: Thu, 26 Mar 2026 15:42:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: David Francis <David.Francis@amd.com>, linux-kernel@vger.kernel.org, 
	Alexander.Deucher@amd.com, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH] fdinfo: Option for public fdinfo
Message-ID: <20260326-enten-hauen-36402c54073b@brauner>
References: <20260316183828.3354343-1-David.Francis@amd.com>
 <20260323-neugierig-meerschwein-31b6daaa1db9@brauner>
 <10ac8ef6-56b4-4a0f-b970-18b3ce012ceb@amd.com>
 <20260324-mitmachen-wirst-65daea421642@brauner>
 <b8e8ea43-4c1c-41da-99a8-267010e1b9de@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b8e8ea43-4c1c-41da-99a8-267010e1b9de@amd.com>

On Tue, Mar 24, 2026 at 10:30:26AM +0100, Christian König wrote:
> On 3/24/26 09:53, Christian Brauner wrote:
> > On Mon, Mar 23, 2026 at 02:16:59PM +0100, Christian König wrote:
> >> On 3/23/26 13:13, Christian Brauner wrote:
> >>> On Mon, Mar 16, 2026 at 02:38:28PM -0400, David Francis wrote:
> >>>> We want some GPU information to be publicly available to all
> >>>> processes for basic system-wide profiling (think GPU versions
> >>>> of top).
> >>>>
> >>>> This information is available in fdinfo and not easily exposed
> >>>> by other interfaces.
> >>>>
> >>>> Add fd_op flag FOP_PUBLIC_FDINFO, which, if set, makes the fdinfo
> >>>> for that file available to read for processes without ptrace
> >>>> permissions.
> >>>>
> >>>> Note that this makes public how many files each process has open,
> >>>> and what their fds are.
> >>>>
> >>>> Signed-off-by: David Francis <David.Francis@amd.com>
> >>>> ---
> >>>
> >>> Eew, please let's not. Add an ioctl if you need to be able to retrieve
> >>> that info.
> >>
> >> Yeah the problem is an IOCTL is even worse from the security pov.
> >>
> >> This is for an tool which doesn't have access to the file descriptor which provides that information.
> >>
> >> So using pidfd_getfd() or similar to get the FD and then call an IOCTL on it would be a security violation.
> >>
> >> The real question is how should we make this information public available in the system?
> > 
> > Don't you have a way to make this info available in sysfs? Just like
> > networking exposes info about network devices in there that may come and
> > go?
> 
> Yeah that was already tried as well and Greg summarized it as "sometimes you don't know how horrible something is until you tried it".
> 
> So the memory accounting parts for DMA-buf files in sysfs were deprecated and removed again just a few weeks ago. And that was basically just a subset of what David tries to do here.
> 
> The requirement is that you want to be able to access the stats for accelerators/GPUs drivers similar to how tools like "top" or "htop" work. E.g. everybody can access /proc/*/stat as well, it's just that some security related information are left out.
> 
> As far as I can see we have only a couple of different options to fulfill that requirement and lowering the security for fdinfo like David's patch here suggests still looks like the most defensive one to me.

It's not acceptable to make /proc/<pid>/fdinfo accessible just to carve
out an exception for you. You can look at implementing something like
taskstats based on netlink transpart if you want to.
