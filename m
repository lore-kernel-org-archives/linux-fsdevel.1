Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2821D3B7753;
	Fri,  5 Jun 2026 08:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647604; cv=none; b=ZdLL5nBs3vY7qeiO3aw2yC2zgTkOoXug4LMQiqA0Obv/7NsTKumVa6u8dMDwJoHBzYyCbTSUuiP9HKiqgguIXkTJSs96yX3ooryYCSTa7t7F2AWVRwiXJ1n7XFGQxoiCO/yivND8IP0dRSlH96Qhtj7UGa+jhbS1VQhGgJuvc/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647604; c=relaxed/simple;
	bh=udEnDd2TxCkjbxafiad+Cutw1d/QFoe/LtHku96SFvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YE6RYiQ0GlvlO8Y2hQps2IEkCYLhgVOiKC24gMJAnE2bVjmNrIZ7pFcUj+uMR5LooOYFI7ZXhn/YgMllQpjitEY/RqvlxSzLPArFRAnUAJ7Jzt7l+iTE2nhgWMKPLwekZVxiX1CT7GXq7e/Jwq8qXAKIZVg/S7gcdWDULPubGHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8/Pr5dV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8/Pr5dV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4253F1F00893;
	Fri,  5 Jun 2026 08:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780647602;
	bh=wSWKY+01hapbGmwPZdKAB/aPIUmCQZd+niy0ELYeyRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l8/Pr5dVik7ehAz1yP+YcYTr55QKwnrlgwjf4LuKjQ25MAFTOtVK1R7f8IL7qpSa/
	 8IV4bJbH0P2PrcSdfp8OvMFTI+nwTrg7/Rl2vYgfMuVbHlekWzGVSVLF32ADUuDWR5
	 gAoISn6jiG9bh03XnAqwUVZ9+tHlCWiWSTDBSLp7PnX/zoSuyI/T/mcYcxyn77DrUV
	 ZY4NWCqCTIqIizuVmSjl8jRC/f91rXnf+uZMasdX3UHTadWu2g97AetSUQxjmBoH5h
	 xEASciam7ghDDD/wHqBKVL8CDLImuwByY8F3MTlHUe9yxwx23eDiOVjw//fZ049s7e
	 ntnjrHmXKHVqg==
Date: Fri, 5 Jun 2026 10:19:58 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: AnonymeMeow <anonymemeow@gmail.com>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] fanotify: allow reporting pidfds for reaped tasks
Message-ID: <20260605-trasse-begangen-geerntet-ccafe6a018d0@brauner>
References: <20260603001516.26234-3-anonymemeow@gmail.com>
 <20260603031117.20950-1-anonymemeow@gmail.com>
 <CAOQ4uxgudh_W2Gcs5qqGce8yO6503yjrGzEwbjTKkT+DLAqufA@mail.gmail.com>
 <20260603-schindel-drehzahl-planlos-e334e6899cd5@brauner>
 <CAOQ4uxgEnD6aN4HTh14=SPzU25_2xOXxfnY+60udOqNp3nnm4w@mail.gmail.com>
 <20260603-mehrsprachig-altlasten-unverantwortlich-4fcd029306b0@brauner>
 <178060498710.12657.15047020114378440191.b4-reply@b4>
 <20260605-inwiefern-flugbereit-reintreten-9ff8d18b642d@brauner>
 <CAOQ4uxgQt8y-KfCrnbgnqsFYxE-7zzmaBYFTh03ZjfHqs2FRZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgQt8y-KfCrnbgnqsFYxE-7zzmaBYFTh03ZjfHqs2FRZA@mail.gmail.com>

On Fri, Jun 05, 2026 at 10:15:32AM +0200, Amir Goldstein wrote:
> On Fri, Jun 5, 2026 at 9:54 AM Christian Brauner <brauner@kernel.org> wrote:
> >
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
> 
> I don't get the idea of allowing any insight for things outside of a process
> namespace to be exposed by fanotify, apart from the information that something
> happened on the watched filesystem object.

If you only hand out the pid it's useless. If you have a pidfd you have
reliable identity. You can use the pidfd-id (aka the 64-bit inode
number) as an index into a hashtable for example and have a table of
event generating tasks. If the task is dead the pidfd tells you that and
you can delete it from the table. Or if you already hold a pidfd for the
task and have e.g., isolated yourself in another pid namespace you can
still figure out what task generated the event.

Don't necessarily discount the ability to have a stable handle with a
unique identifier per event. :)
