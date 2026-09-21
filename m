Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544BF489FC2;
	Mon, 21 Sep 2026 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989616; cv=none; b=EqG1O9s7xranp5Hfk+oULJhdLu0sTmXRRNy6XXgSUffWQPA/iZfEynUgiKlU+DMWllB/V82Td+pr3Y1qQp3yJQRjwobMmVPVswBMc52vSJsIG3ajWHTg5p8QgGJ0Ui+zjtpq5LMAH7LdrAPCiJT+a4iJBwEDgWG+Ei50SlrIpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989616; c=relaxed/simple;
	bh=JE+a3ZMzDdJl5jQ/otJS5RrxcfVulQNaMMDFJuME2Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbgYImGsYsjpkPe+eoh6nN8tgNdbecknIf8ew04wlwJ4c3ilNGKnFLcnXHEgemnPwTv+ryq9+juPyy58Tw5vNEoxI99e0UiROLIEIBphLlGUsSWu0Pv2ZVHE1RVAIiyywqPHZZQdb1GMYlkWKY8pSMiLFXRxtL+aGglOQ4qAf88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4G+eyVJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4G+eyVJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39521F000FF;
	Mon, 21 Sep 2026 11:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789989614;
	bh=2kg/TXvOegdx6UJZ/kLCIs+vBCNA4Z77iTJNVCR7wKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a4G+eyVJTj1TD1yFXh40Wkj0vOwJyfJ2dJgvMdbOqEoy7IPUeeVXA2y4WnmvAAsni
	 Pq8AH9usOFsni9gXpy/Unnufp1BGPGx7zs6/EO/vakHJibOhWrChcyP3VuzN1TYA1U
	 CS7zm8uAomtHruXfTx06DLt0EiOdWmWaODscqnC5Eg3JXqBjPXDpK4w7axzRsAsEeh
	 QT0x7Ze8s1jer8ePBOvkNbfljBK0RLTixj1BljoQrSESB/HEm/FlGU3WIr0snFvqMQ
	 qkTERjAvODAyy5CSiADhF3/hgIKCmISmQLAAAvhBBGwZyX1rJFEQPoLlapT09UK+Au
	 BEfcyT/CrGpxg==
Date: Mon, 21 Sep 2026 13:20:09 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: NeilBrown <neil@brown.name>, Chris Mason <mason@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, io-uring@vger.kernel.org
Subject: Re: user workers as coredumpers [Re: [PATCH 1/6] coredump: don't
 switch a dumper that has no files] table
Message-ID: <20260921-programm-rentner-faltblatt-ec5ed7719d55@brauner>
References: <20260915-work-coredump-fixes-v1-1-f354ca41780c@kernel.org>
 <20260916194837.3732307-1-mason@kernel.org>
 <20260917-staunen-sparsam-infusion-83238c68d21f@brauner>
 <178960987412.207413.3957049392884487413@noble.neil.brown.name>
 <20260917-zahnpasta-aufweichen-flackern-1182320f5c81@brauner>
 <20260918-tonart-umgeladen-gesponnen-519fca5172bd@brauner>
 <aq_4fY6GVtK47Njq@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aq_4fY6GVtK47Njq@redhat.com>

On Sun, Sep 20, 2026 at 05:15:09PM +0200, Oleg Nesterov wrote:
> On 09/18, Christian Brauner wrote:
> >
> > So I thought a bit about this yesterday and had some brief discussions
> > bout this as well. I think we should kill this whole bug class by
> > ensuring that PF_USER_WORKERs never participate in a coredump.
> 
> Agreed,
> 
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -3021,6 +3021,21 @@ bool get_signal(struct ksignal *ksig)
> >  		 */
> >  		current->flags |= PF_SIGNALED;
> >
> > +		/*
> > +		 * PF_USER_WORKER threads will catch and exit on fatal signals
> > +		 * themselves. They have cleanup that must be performed, so we
> > +		 * cannot call do_exit() on their behalf. Note that ksig won't
> > +		 * be properly initialized, PF_USER_WORKER's shouldn't use it.
> > +		 *
> > +		 * They must not dump core either. The dumper waits for every
> > +		 * other thread in the group to exit, and a sibling's exit path
> > +		 * may in turn wait for this worker's own exit, which only runs
> > +		 * after get_signal() returns: io_sq_thread() ends up in
> > +		 * io_wq_exit_workers() and waits there for its io-wq workers.
> > +		 */
> > +		if (current->flags & PF_USER_WORKER)
> > +			goto out;
> 
> This probably makes sense anyway... but see below.
> 
> Perhaps it makes sense to change ptrace(PTRACE_SETSIGMASK) to fail if
> child->flags & PF_USER_WORKER ?

Yes, see my other mail.

> Currently get_signal() from PF_USER_WORKER can only return SIGKILL,
> I think we should keep this rule.

Yes, agreed.

> I don't think your change can fix all problems. Suppose we have a main
> thread T and a PF_USER_WORKER sub-thread W.
> 
> Some signal, say, SIGHUP has a handler. Debugger unblocks SIGHUP for W.
> 
> Now, kill(SIGHUP, T) can choose W as a target, complete_signal() can
> choose any thread if wants_signal(t) is true. W will "drop" this signal,
> its signal handler won't be called.
> 
> 
> In the longer term it would be nice to rework this logic somehow to not
> rely on ->blocked...

Agreed.
