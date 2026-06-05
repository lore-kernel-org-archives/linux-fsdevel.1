Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C947ECF1;
	Fri,  5 Jun 2026 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780646047; cv=none; b=RY+SJ3zMebYCLcQaW58/41nTtgkX4q7cM8IiIR7+jfeEOKBbWagDKtsyHny9ZdlIiLb1nmTg6SAwkMwmDU4Q+EcvOmSD1qCstfV8Vk93jtLSLwYJN7JrmOBwtb54nGRlbw1RHLo+ZKBq3d9mWt/g4HaHD0AUgg66SG5VsZP5OxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780646047; c=relaxed/simple;
	bh=bRCP5Hk67pGY5n4l3HlC7gXQ3/SvGdWxcbrtRyUL23k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4DJXDWFhxG4o1iO/v2rCmI7+kCZR4eAzCzWyOYVmeEtpgxCXVyINJJ5DubWfr9e5YjzECyrry6Y0cADtzKqK3sxVNDFpRwojuf1KyWl2hkKWSO6kN4guwIomoOkkPwn8EkG0jYjNVdkM7QxAiWgPgHtuUTi/m++zl1I/mHLYxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qd6puHiR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qd6puHiR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031D71F00898;
	Fri,  5 Jun 2026 07:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780646045;
	bh=dBHdZJAsi8sqfH5KBHEKNYc5EsMFpdfHefv5XfiSqyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qd6puHiRJKs7fXqsiAxnAZMC0vQ3Kebwf4Ne3cyc6sidKowYhBn9B+wn+TfeGbcPc
	 mkkG70u6biGHrR/IDdzYtfywYCP5foeydpfi31P8MUE5JMV3uTPbzuMBU8T4yIOgUd
	 ZzF5YP9CIp5ejA53ztNvvEqh3RlVm12OTxPLoQ5uruTFesNtoqacShZ4byU3diaYFt
	 gJK2CjZ45fHdlJponEYAegAIWMHd3YmIFvkceTJ6+5LPf2CRutTEp6u6NqOxXJmR/j
	 /ojnF0M6NdEw3dgM5oYFYIz8fFdLclCO9Yw0Hz20tx/OHDS2GC6NuGvWSaL9V3IYdZ
	 qTvTlBk4d3A0g==
Date: Fri, 5 Jun 2026 09:54:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: AnonymeMeow <anonymemeow@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] fanotify: allow reporting pidfds for reaped tasks
Message-ID: <20260605-inwiefern-flugbereit-reintreten-9ff8d18b642d@brauner>
References: <20260603001516.26234-3-anonymemeow@gmail.com>
 <20260603031117.20950-1-anonymemeow@gmail.com>
 <CAOQ4uxgudh_W2Gcs5qqGce8yO6503yjrGzEwbjTKkT+DLAqufA@mail.gmail.com>
 <20260603-schindel-drehzahl-planlos-e334e6899cd5@brauner>
 <CAOQ4uxgEnD6aN4HTh14=SPzU25_2xOXxfnY+60udOqNp3nnm4w@mail.gmail.com>
 <20260603-mehrsprachig-altlasten-unverantwortlich-4fcd029306b0@brauner>
 <178060498710.12657.15047020114378440191.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178060498710.12657.15047020114378440191.b4-reply@b4>

On Fri, Jun 05, 2026 at 04:29:47AM +0800, AnonymeMeow wrote:
> On 2026-06-03 13:25 +0200, Christian Brauner wrote:
> > On Wed, Jun 03, 2026 at 12:58:09PM +0200, Amir Goldstein wrote:
> > > On Wed, Jun 3, 2026 at 12:28 PM Christian Brauner <brauner@kernel.org> wrote:
> > > >
> > > > On Wed, Jun 03, 2026 at 12:00:42PM +0200, Amir Goldstein wrote:
> > > > > On Wed, Jun 3, 2026 at 5:11 AM AnonymeMeow <anonymemeow@gmail.com> wrote:
> > > > > >
> > > > > > Sashiko said that pidfs_register_pid() can fail under memory pressure,
> > > > > > since it allocates memory using GFP_KERNEL without a way to pass in
> > > > > > __GFP_NOFAIL. This can cause fanotify_alloc_event() to silently drop
> > > > > > the event even when the group has an unlimited queue length.
> > > > > >
> > > > > > Should we make pidfs registration best-effort instead and still return
> > > > > > the allocated event if pidfs_register_pid() fails? But IMO this will
> > > > > > make the API semantically ambiguous. If the kernel guarantees that the
> > > > > > event pid is registered with pidfs when pidfd reporting is requested,
> > > > > > then a later FAN_NOPIDFD or -ESRCH can only be caused by the task being
> > > > > > invisible within the reader's pid namespace. But if we allow best-effort
> > > > > > registration, the event may still carry a pinned struct pid, but pidfs
> > > > > > registration may have failed due to memory pressure. If userspace reads
> > > > > > the event after the task has been reaped, it still gets a FAN_NOPIDFD
> > > > > > or -ESRCH due to failed pidfs registration caused by memory pressure,
> > > > > > IMO this should be reported as a -ENOMEM instead of -ESRCH. But
> > > > > > currently it seems we don't have a good way to register the pid with
> > > > > > __GFP_NOFAIL or __GFP_RETRY_MAYFAIL, so what would be the preferred
> > > > > > approach to handle this situation?
> > > > >
> > > > > Thanks for noticing the oddity and explaining the options.
> > > > >
> > > > > We could fail the event in case on ENOMEM because the system
> > > > > is likely is a bad shape anyway and other events are likely to fail
> > > > > allocation themselves, so I am not objecting to your patch as is,
> > > > >
> > > > > but I am slightly leaning towards the semantically ambiguous API.
> > > >
> > > > As usual, I think a semantically ambiguous api should be avoided.
> > > >
> > > > > I don't think that we are going to change the man page to say that
> > > > > FAN_REPORT_PIDFD is guaranteed to return a pidfd, maybe we just
> > > > > add a NOTE about increased likelihood of getting a pidfd since kernel XXX
> > > > > and mention the known cases of pid namespace and ENOMEM.
> > > >
> > > > The pid namespace shouldn't matter.
> > > 
> > > DO you mean that the event reader inside a pidns always gets a pidfd but
> > > it will not be able to query the pid of the process outside the pidns
> > > or do you mean something else?
> > 
> > So they will always get a pidfd since fanotify is correctly using
> > pidfd_prepare() directly. But when the reader tries to resolve the pidfd
> > to say a pid or retrieve info via the pidfd info ioctl they would fail
> > to do so (well, the pid will resolve to 0 which is the global indicator
> > for "can't be resolved in your pidns").
> > 
> 
> Before pidfd_prepare(), fanotify checks whether metadata.pid is
> non-zero, i.e. whether the event pid is visible in the reader's pidns.
> If it's not visible, fanotify will not create a valid pidfd and return a
> FAN_NOPIDFD. This is the existing behavior, and my patches do not change
> it.

We can hand that out. That's another change we should consider. The
pidfd works even if the pid namespace is outside the caller's hierarchy.
