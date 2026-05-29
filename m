Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D43346BE;
	Fri, 29 May 2026 07:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040402; cv=none; b=OUlPDFwxzYkqJx7wInHVDGjpferX3/xdAr6PkFk0odBN3qz51dlQ5a7k+F7ZNkMw68KFZqvrM0qdZpWfbv+FCrDNRomUH7dHM6QNQJoqybdCuktQtignmGvsH9+vdpfqysld38ES09NB0znOHFfnVJGfyWjgxn/ZKcx3GRbe+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040402; c=relaxed/simple;
	bh=SdyNDk0QVIef642X+y0ojXpFzOj5+60meKP311KiSKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mj2u9U/eN5w/N1D2ADMjMc6R61HRc/61koPhgA0/pzIGgH90j4Ip6LZdMxFzYsEnV875ba9lCOSaq4A23sOLGY29g+/vaiBDcxrAUbvio8TKegGKqlX3F3CAjaf2Hy9WzbcFcxRYQXhZ3wGOehiciu+vVr/LRw8dn3xtH6yoO2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyygE+hu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyygE+hu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B10B1F00893;
	Fri, 29 May 2026 07:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780040400;
	bh=wsgW5pklYB3v5Lh2NhvHLEU9oB9Hvi7bSJL8uahQSvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UyygE+huGikptUixKLmI860LLw9E8N+97QiRes497tsU8P/xYl+s0BR0/TQnyeADF
	 sBpzPAT7IIVV43sNaCmh8TGnaLChTKJyICuiBvppF9y2TuNjmkrKr2SbAb3rJoLGdH
	 ky8sBp+UgD4wA+svTt0NVZKKV6jWB9qe4+0M5LhzZ1rpAuh8FNdlOZ8U4Z7BQHe2hO
	 1vCT+aJSV6Le3NgNyZQxcC8f17BzmKFXkXM5jc1IoSiCprO1nPr12qlgoNi94Pbpmj
	 isbdGaKUVMuWxinB9hkSdAJWnSHkMkzRKxuKf18QE9Oe1uSfN0xRJ2CCIjwhO9FHzC
	 tuGlZWJsyRCCw==
Date: Fri, 29 May 2026 09:39:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: AnonymeMeow <anonymemeow@gmail.com>, jack@suse.cz, repnop@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fanotify: report thread pidfds for FAN_REPORT_TID
Message-ID: <20260529-erdig-eckig-querulant-439a4ba4317d@brauner>
References: <20260528-schmuckvoll-heilen-garen-be77b4208671@brauner>
 <20260529020035.17477-1-anonymemeow@gmail.com>
 <CAOQ4uxiGr7i=_H4XttS3kWKni1nT75BjnVNZM-0j2JnAHLY7cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiGr7i=_H4XttS3kWKni1nT75BjnVNZM-0j2JnAHLY7cA@mail.gmail.com>

On Fri, May 29, 2026 at 09:21:55AM +0200, Amir Goldstein wrote:
> On Fri, May 29, 2026 at 4:01 AM AnonymeMeow <anonymemeow@gmail.com> wrote:
> >
> > The FAN_REPORT_PIDFD and FAN_REPORT_TID flags used to be mutually
> > exclusive because by the time the pidfd support was introduced to
> > fanotify, pidfds could only be created for thread group leaders. Now
> > that the pidfd API supports thread-specific pidfds via PIDFD_THREAD,
> > this restriction can be lifted.
> >
> > Also drop the pid_has_task() check to allow pidfds to be reported for
> > reaped tasks as well.
> 
> I am not objecting to this change, but as a rule of thumb, almost
> every time that
> a commit message says "Also" it means that it should have been a separate
> commit.
> 
> This is not an exception to the rule and even worse -
> This change PIDFD_STALE is an independent change of behavior
> (as observed by breakage of fanotify21) that could (maybe unlikely)
> surprise real users.

I don't think so. It's the same as when we enabled PIDFD_STALE for
AF_UNIX sockets: it strictly expanded the usability of the interface as
you could now reliably get a pidfd for all events and get stronger
guarantees.

> We have few options:
> 1. Make it opt-in with yet another fanotify_init flag
> 2. Enable it implicitly together (and in the same patch) with FAN_REPORT_TID
> 3. Enable it without opt-in (as you did) but as separate patch
>     that will be reverted if someone complains on "real world"
>     (i.e. not test) breakage
> 
> IMO, the path of least resistance is option 2.
> If users want to get the pidfd of tgid I suppose there should be no
> problem to get it from the pidfd of the thread. Right?
> So what FAN_REPORT_TID really means is give me a richer pidfd
> with more information about the actor than without FAN_REPORT_TID.
> 
> I'd like to get Jan's input on those UAPI choices.
> 
> >
> > Link: https://lore.kernel.org/lkml/20260528-schmuckvoll-heilen-garen-be77b4208671@brauner/
> > Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
> > ---
> >
> > On 2026-05-28 13:51 +0200, Christian Brauner wrote:
> > > For quite a while the kernel refused to hand out pidfds for reaped
> > > processes even if the struct pid was pinned like in this case.
> > >
> > > But that makes various APIs - including this one - way less powerful
> > > than they can be. Nowadays the socket layer already hands out pidfds for
> > > reaped processes. It also stashed the struct pid. Let's do the same
> > > here.
> > >
> > > Drop the pid_has_task() change and then:
> > >
> > > pidfd = pidfd_prepare(event->pid, pidfd_flags | PIDFD_STALE, &pidfd_file);
> > >
> > > which instructs pidfs to and out a pidfd even if the task has already
> > > been reaped. Reaped pidfds can still be queried for various types of
> > > information that is kept around even if the task is long gone.
> >
> > Thanks for the review. I've updated this in v2 as you suggested.
> >
> > Also, the LTP fanotify21 test currently explicitly expects ESRCH or
> > FAN_NOPIDFD for exited processes. I will update that test case accordingly.
> 
> This sentence highlights the problematic aspect of this change.
> How would you update the test expectation?
> The test must be able to run on upstream as well as stable kernels.
> Would you test for support in FAN_REPORT_TID
> and according to the result determine the expected behavior of the
> test cases (variants) without FAN_REPORT_TID?
> Very ugly IMO.
> 
> OTH, if you take the suggestion that PIDFD_STALE is implied only
> for FAN_REPORT_TID, you can change the expectation for the
> "terminated child" test case only for TST_VARIANT_PIDFD_THREAD.

I think this is just not worth it. It brings users no value if they get
slightly different semantics for effectively the same API. I don't see
what the problem is with just enabling it and fixing the LTP tests.
We've done that so many times before when APIs get extended.

Worst-case someone comes back and tells us that they were relying on
that specific behavior then you just revert. So I would propose to add a
separate patch on top of PIDFD_THREAD that enables PIDFD_STALE
unconditionally. If this leads to non-test regressions revert the patch.
