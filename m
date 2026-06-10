Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521F2FA0C4;
	Wed, 10 Jun 2026 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781077361; cv=none; b=tk/Xbdv/wOj03uKZAq5AeBaYLM5dY31PRw8al6R3aAFttckOhBp1Lh2GONdSoNcj6+vn2sk/DUlXH/+NPcgRcBmVF3u3cGFbCwTIWN96hZBE/cLIGeIT8eT0O9FZGtAP+Dg4vdGRI6AQ+UexUYgLdSVkimgaWzgMwYV/FX07DK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781077361; c=relaxed/simple;
	bh=PxapGUF+fOB6HF2S78srW5afgxUUVWs8X+7iHb+X9Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvjSa24LQ0JcskeiBWcbMwbZjzf41tumB0ky0vGbH9G3pa5eV04TX3Hlq7OnJSx8AENmpzIpEk74o99M5RzsdEcYAAEGIQWo7OO1TjGOwQxPDCj8FjJEYMgZsYThqx+ntZ4ggFxWMMZ+xSDZ6pMSXxcF3QzG7UzXktVTvHwe/28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiH25KKZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiH25KKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B982A1F00893;
	Wed, 10 Jun 2026 07:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781077360;
	bh=jaJgoo+cDEiobXw+ESpX37VShdFq4S0TMyH/1TtptvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kiH25KKZtsHIHZWq8OiO4SE2LrEgpx0iwUgmNzpw9N/mnE8L0NvpOkpUa3aHI0+iL
	 EVAHzf7tUXTbWktTCL6yrIN8lj4E7mC5dhguU0nWGx6CuVunNcH+uvjgr9FIw7163z
	 mHZe2XJ+diUkcSqfukvnI8iWp10DP+TNG3MzDk6p2AEtu57d/jFs+VZI4/0nQVCO5l
	 lJra4A6V7PQxwvsWrPbNjD10hcorjHyPHVUegH0f9ipn11bvWwT1WFJSblDTuuDNcV
	 E+Q7F3jwmJjT2Tm1Bh0y68pxRKWm/ca5Bx9kRW0BDGcWwsrKpECUbHOVfqmDMCIJFe
	 PoG+mhldMM3kg==
Date: Wed, 10 Jun 2026 09:42:36 +0200
From: Christian Brauner <brauner@kernel.org>
To: AnonymeMeow <anonymemeow@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] fanotify: allow reporting pidfds for reaped tasks
Message-ID: <20260610-extrem-fachpersonal-restriktionen-dc4a0c73ac1a@brauner>
References: <20260603001516.26234-3-anonymemeow@gmail.com>
 <20260603031117.20950-1-anonymemeow@gmail.com>
 <CAOQ4uxgudh_W2Gcs5qqGce8yO6503yjrGzEwbjTKkT+DLAqufA@mail.gmail.com>
 <20260603-schindel-drehzahl-planlos-e334e6899cd5@brauner>
 <CAOQ4uxgEnD6aN4HTh14=SPzU25_2xOXxfnY+60udOqNp3nnm4w@mail.gmail.com>
 <20260603-mehrsprachig-altlasten-unverantwortlich-4fcd029306b0@brauner>
 <178060498710.12657.15047020114378440191.b4-reply@b4>
 <20260605-inwiefern-flugbereit-reintreten-9ff8d18b642d@brauner>
 <178078952175.93110.16695082677701348131.b4-reply@b4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178078952175.93110.16695082677701348131.b4-reply@b4>

On Sun, Jun 07, 2026 at 07:45:21AM +0800, AnonymeMeow wrote:
> On 2026-06-05 09:54 +0200, Christian Brauner wrote:
> > On Fri, Jun 05, 2026 at 04:29:47AM +0800, AnonymeMeow wrote:
> > > On 2026-06-03 13:25 +0200, Christian Brauner wrote:
> > > > On Wed, Jun 03, 2026 at 12:58:09PM +0200, Amir Goldstein wrote:
> > > > > On Wed, Jun 3, 2026 at 12:28 PM Christian Brauner <brauner@kernel.org> wrote:
> > > > > >
> > > > > > On Wed, Jun 03, 2026 at 12:00:42PM +0200, Amir Goldstein wrote:
> > > > > > > On Wed, Jun 3, 2026 at 5:11 AM AnonymeMeow <anonymemeow@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Sashiko said that pidfs_register_pid() can fail under memory pressure,
> > > > > > > > since it allocates memory using GFP_KERNEL without a way to pass in
> > > > > > > > __GFP_NOFAIL. This can cause fanotify_alloc_event() to silently drop
> > > > > > > > the event even when the group has an unlimited queue length.
> > > > > > > >
> > > > > > > > Should we make pidfs registration best-effort instead and still return
> > > > > > > > the allocated event if pidfs_register_pid() fails? But IMO this will
> > > > > > > > make the API semantically ambiguous. If the kernel guarantees that the
> > > > > > > > event pid is registered with pidfs when pidfd reporting is requested,
> > > > > > > > then a later FAN_NOPIDFD or -ESRCH can only be caused by the task being
> > > > > > > > invisible within the reader's pid namespace. But if we allow best-effort
> > > > > > > > registration, the event may still carry a pinned struct pid, but pidfs
> > > > > > > > registration may have failed due to memory pressure. If userspace reads
> > > > > > > > the event after the task has been reaped, it still gets a FAN_NOPIDFD
> > > > > > > > or -ESRCH due to failed pidfs registration caused by memory pressure,
> > > > > > > > IMO this should be reported as a -ENOMEM instead of -ESRCH. But
> > > > > > > > currently it seems we don't have a good way to register the pid with
> > > > > > > > __GFP_NOFAIL or __GFP_RETRY_MAYFAIL, so what would be the preferred
> > > > > > > > approach to handle this situation?
> > > > > > >
> > > > > > > Thanks for noticing the oddity and explaining the options.
> > > > > > >
> > > > > > > We could fail the event in case on ENOMEM because the system
> > > > > > > is likely is a bad shape anyway and other events are likely to fail
> > > > > > > allocation themselves, so I am not objecting to your patch as is,
> > > > > > >
> > > > > > > but I am slightly leaning towards the semantically ambiguous API.
> > > > > >
> > > > > > As usual, I think a semantically ambiguous api should be avoided.
> > > > > >
> > > > > > > I don't think that we are going to change the man page to say that
> > > > > > > FAN_REPORT_PIDFD is guaranteed to return a pidfd, maybe we just
> > > > > > > add a NOTE about increased likelihood of getting a pidfd since kernel XXX
> > > > > > > and mention the known cases of pid namespace and ENOMEM.
> > > > > >
> > > > > > The pid namespace shouldn't matter.
> > > > > 
> > > > > DO you mean that the event reader inside a pidns always gets a pidfd but
> > > > > it will not be able to query the pid of the process outside the pidns
> > > > > or do you mean something else?
> > > > 
> > > > So they will always get a pidfd since fanotify is correctly using
> > > > pidfd_prepare() directly. But when the reader tries to resolve the pidfd
> > > > to say a pid or retrieve info via the pidfd info ioctl they would fail
> > > > to do so (well, the pid will resolve to 0 which is the global indicator
> > > > for "can't be resolved in your pidns").
> > > > 
> > > 
> > > Before pidfd_prepare(), fanotify checks whether metadata.pid is
> > > non-zero, i.e. whether the event pid is visible in the reader's pidns.
> > > If it's not visible, fanotify will not create a valid pidfd and return a
> > > FAN_NOPIDFD. This is the existing behavior, and my patches do not change
> > > it.
> > 
> > We can hand that out. That's another change we should consider. The
> > pidfd works even if the pid namespace is outside the caller's hierarchy.
> > 
> 
> I may be missing something, but I am concerned that lifting this
> restriction could have security implications... Because it could weaken
> the isolation provided by pidns. In the usual case, a task inside a
> pidns cannot actively obtain a reference to tasks outside of that ns. If
> fanotify is allowed to hand out pidfds across pidns boundaries, a task
> inside the ns may be able to obtain access to resources that were
> supposed to be isolated from it, such as other tasks' namespaces.
> 
> One possible attack surface I can think of is container escape. I wrote
> a small toy PoC which escapes from a podman container using this
> mechanism. Admittedly, the PoC requires sudo as well as SYS_ADMIN and
> SYS_PTRACE caps, so it is not practical by itself. However, I am worried
> that in other circumstances this could become a real attack surface.
> 
> I'm no expert in this area, so I do not think I am in a good position to
> make that call myself... For now, I'm not planning to include removal of
> this restriction in my patch set.

You would need ptrace_may_access() rights to the process for that to work.
If this is a real concern we should simply scope to the hierarchy
independent of the fanotify changes. Thanks for looking into this
closely. I appreciate it.
