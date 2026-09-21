Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DF53EDE63;
	Mon, 21 Sep 2026 20:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021145; cv=none; b=Jm1kTWiLeoSMPXiU2xpRkGT4qIeAD9m2IGIVteKmwBOUVg8W/MuaVfYpemZaEypd06/QKDyLpvOKLMXvRShrUDcz6Tu7OoUwovBprpp+TmuBMO+9aeU385DofEJudxpUaMjquCjTEgE/N4L/UlGnmJMjOW+HIYR1mJSXQYmMSZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021145; c=relaxed/simple;
	bh=E1nt2OiryM5Vp7yIydRMk26AIc05eQ6Dfua1DC5qCk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tUQ8dewGmkmdsJWbxq/iBY5JHmn2YkzE2hMHbZHfJBSkVCNgbBa7X1CmhvJWYDzIB9nk3ibKwJDqDsBIs2QpTiZMQ9qIBE1riJOdyfO281buGz6wE8yg0v+QrpXpKHAc1voVznygfbnRCTsReIerDh7tfCe5YG/SyECSEWnXqD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=laERZ3Kx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laERZ3Kx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777591F000FF;
	Mon, 21 Sep 2026 20:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790021144;
	bh=dJrvbjKP0uMSBOgrfNHJZVcDEbLyWTjMWbSdfBccSIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=laERZ3KxzyekBtxnWDnLIqlvZO/wuj02jHIybpTnAhK2uldNxQQ0YAD172rdWUaiB
	 r9qPrrQ2NveG1l6JBtnpCu54AsMB++aHwc2kqI20kM/0C51oqB0fKEftifaZivkKC5
	 eQ37/qrMyqXwXZw1Pa3A2+y1zfEiUmA7krVG8wRc/N0kU6cwEWLGj+CisCnk0mSBN9
	 2AD8eP0rbGOfSrx+u9XQDsKQEukcM1OWuKo76zH0lbDYLkt6pFhsW3FZj9+X2hdT9K
	 gYiUuJUQmrHm1sVRLPg5nphE7EszecXcCCsNe7EslBoBxY9TZQitBcBdRQL+2xQlPu
	 lYa1wP7z25MKQ==
Date: Mon, 21 Sep 2026 22:05:38 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Chris Mason <mason@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, io-uring@vger.kernel.org
Subject: Re: [PATCH v3 16/17] signal: enforce the user worker signal mask in
 __set_task_blocked()
Message-ID: <20260921-gehirn-gleis-wenig-27dc2bd318bb@brauner>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
 <20260921-work-coredump-fixes-v3-16-8e4adb1619e6@kernel.org>
 <arFYWLJ8yzpS325k@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arFYWLJ8yzpS325k@redhat.com>

On Mon, Sep 21, 2026 at 06:16:24PM +0200, Oleg Nesterov wrote:
> On 09/21, Christian Brauner wrote:
> >
> > The in-kernel sigprocmask() users block more signals for a critical
> > section and restore the saved mask afterwards. cifs used to do that in
> > __smb_send_rqst() and ocfs2 in ocfs2_block_signals(). Both were
> > reachable from an io-wq worker. Both only add SIGKILL and SIGSTOP to the
> > user workers's and then put the fork-time mask back.
> 
> Ooh, this reminds me... see below.
> 
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -3212,6 +3212,16 @@ long do_no_restart_syscall(struct restart_block *param)
> >
> >  static void __set_task_blocked(struct task_struct *tsk, const sigset_t *newset)
> >  {
> > +	sigset_t floor, floored;
> > +
> > +	/* A user worker never unblocks anything but SIGKILL and SIGSTOP. */
> > +	if (unlikely(tsk->flags & PF_USER_WORKER)) {
> > +		siginitsetinv(&floor, SIG_KERNEL_ONLY_MASK);
> > +		sigorsets(&floored, newset, &floor);
> > +		WARN_ON_ONCE(!sigequalsets(&floored, newset));
> > +		newset = &floored;
> > +	}
> 
> OK, Acked-by: Oleg Nesterov <oleg@redhat.com>
> 
> although to me something like a more simple version
> 
> 	/* A user worker never unblocks anything but SIGKILL and SIGSTOP. */
> 	if (unlikely(tsk->flags & PF_USER_WORKER)) {
> 		sigset_t xxx;
> 		siginitsetinv(&xxx, SIG_KERNEL_ONLY_MASK);
> 		if (WARN_ON_ONCE(has_pending_signals(&xxx, newset)))
> 			return;
> 	}

Ok, let me see and fold that in if this is workable.

> makes more sense. But this is minor.
> 
> In fact I think that __set_task_blocked() should simply do
> 
> 	if (WARN_ON_ONCE(tsk->flags & PF_USER_WORKER))
> 		return;
> 
> but yes, we can't do this right now, we have in-kernel abusers of sigprocmask().

Yes, I found the two offenders. But fwiw, I've already fixed smb with
PF_NO_NOTIFY_SIGNAL which you reviewed some time ago. It's sitting in
kernel-7.4.signal. So only ocfs2 is left.

> IMO, they should be changed to not rely on sigprocmask(). Lets look at
> ocfs2_delete_inode() for example,
> 
> 	/* We want to block signals in delete_inode as the lock and
> 	 * messaging paths may return us -ERESTARTSYS. Which would
> 	 * cause us to exit early, resulting in inodes being orphaned
> 	 * forever. */
> 	ocfs2_block_signals(&oldset);
> 
> ocfs2_block_signals() blocks everything including SIGKILL and SIGSTOP.
> I guess to protect against signal_wake_up / TIF_SIGPENDING ?

I don't know. I guess so.

> But this can only help in the single-threaded case. And PF_USER_WORKER's
> are never single-threaded.

Yes.

> Blocking SIGSTOP can't protect from SIGSTOP if another thread dequeues
> SIGSTOP or another sig_kernel_stop() signal. This another thread will do
> do_signal_stop() -> signal_wake_up().
> 
> Same for SIGKILL...

Yes.

> In short, I agree with this patch, but mostly because of WARN_ON_ONCE()
> it adds.
