Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3342587A
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jul 2026 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494764; cv=none; b=ocwV62HySzfA+gq5Qp6iVjFb8oczY5RcNjkGj87HJrI6uZkvw6dhH+FGngjCKnnLzi8dULe2s5At8mnPssX7iJnqqJ7/y3pDycQCfSOsgnvemmL0bd3yIQJqQ6raop7opFE+TQx1zOVRCvHre2C1LD5ve4Tn7GhfxtMnz5jIlEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494764; c=relaxed/simple;
	bh=nu+v+fg0O7PasvUxheTQ92ovuzEqDQ6RYfa/FFVZA0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFZbkvpgH5gbwb/VoIHFm9rwLJ1ZSRhZcFGZhuAxvH0wpbQr8CP5AXxVes0eUBjptejeMZ5ORvB4HB1jUWT7yW6a3nbvbD8ttqFUyRyFd3J7MOUAvuuVs1jhaFJK5c3+JrL9RKKwFf5AMaQmGxHcXFpwUEFHSZ7aYQgs/Jp2Hkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MI/bXF4t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MI/bXF4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785494754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJcoyrlWeeHqo03zhEZPXLU7wTbomcszf4vJrnfwd6k=;
	b=MI/bXF4tsxqwIOwQTXyLEOzkQXPcAwlTq57VAhQyN+bBXEi82i/qpVXZz/lKxS4dYytH+q
	Ng8gYDoFAyiVVVY/njfzdmLTVdjbNtYPBXRLHmV5DeQjAbxxh9q/7ekQa8HvzMpaLN3gC9
	52BSfWnmtWmHzdZGLxGKnmGjqoMvvdY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-CaNOMdTePBGH8_ja9_UpIA-1; Fri,
 31 Jul 2026 06:45:49 -0400
X-MC-Unique: CaNOMdTePBGH8_ja9_UpIA-1
X-Mimecast-MFC-AGG-ID: CaNOMdTePBGH8_ja9_UpIA_1785494747
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C6E7F180036E;
	Fri, 31 Jul 2026 10:45:46 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 11FD341C;
	Fri, 31 Jul 2026 10:45:41 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 31 Jul 2026 12:45:46 +0200 (CEST)
Date: Fri, 31 Jul 2026 12:45:40 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mateusz Guzik <mjguzik@gmail.com>, Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH v3 1/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
Message-ID: <amx81MSmqiWfagRY@redhat.com>
References: <amtbpwrhlNGJ9OK6@redhat.com>
 <amtbxpqJ3pZwyT8D@redhat.com>
 <amteY30qxRuPzFh3@gmail.com>
 <amth6owVUdVOmyAL@redhat.com>
 <CAGudoHE=GjMRKGbip8nRUm34VUud_YSqGZJrfr+Vz6Qu22Mdaw@mail.gmail.com>
 <amu1i8rzQ3hZ-vAu@redhat.com>
 <CAHk-=wiUWQdiHbH9s4XKnYZwRs5vR1Azq83V4scN+N-w-VFRng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiUWQdiHbH9s4XKnYZwRs5vR1Azq83V4scN+N-w-VFRng@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 07/30, Linus Torvalds wrote:
>
> On Thu, 30 Jul 2026 at 13:35, Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Again, contrary to the current comments this is not Epoll-only...
>
> Sure it is. As far as we know, only epoll has ever *cared*.
>
> Yes, you can show the semantics with io_uring, but do you have a user
> application that actually cares?

No. But I know nothing about io_uring, this is the question for Pavel
and Jens.

io_uring claims itself edge-triggered (whatever that means). It has
IORING_POLL_ADD_LEVEL, but this mode was disabled by d59bd748db0a9
("io_uring/poll: disable level triggered poll").

I don't understand io_uring/poll.c even remotely, but it seems that
without IORING_POLL_ADD_LEVEL io_uring expects that the io_poll_wake()
callback should be called on every write.

Same for epoll(EPOLLET)... I mean, I have no idea why anyone would
need this behavior. But from the commit 3a34b13a88caeb28 ("pipe: make
pipe writes always wake up readers") we know that such users exist.

> The only reason that ugly hack exists is because we did have that
> break user space. If we can get rid of th eugly hack for io_uring,
> that would only be a good thing.
>
> So this literally *should* be about only epoll unless you have a
> report that io_uring users are equally broken and use that
> shit-for-brains notion of edges that aren't edges that nobody sane
> should ever use.

In the 1st version I did:

	static void pipe_set_epoll_usage(struct file *filp, struct pipe_inode_info *pipe)
	{
	#ifdef CONFIG_EPOLL
		if ((filp->f_mode & FMODE_READ) && filp->f_ep &&
		   unlikely(!READ_ONCE(pipe->epoll_usage)))
		       WRITE_ONCE(pipe->epoll_usage, true);
	#endif
	}

but sashiko didn't like it, let me quote:

	Does skipping this wakeup for non-epoll consumers break io_uring?

        Applications polling pipes via io_uring do not attach an eventpoll context,
        so pipe->epoll_usage will be false. If a writer writes to an empty pipe,
        io_uring receives the wakeup.

        If the writer then writes a second chunk before the first is drained,
        anon_pipe_write() observes was_empty == false and
        pipe_get_epoll_usage() == false, skipping the waitqueue wakeup.

        Could this cause io_uring to miss events and hang permanently, waiting
        for a CQE that will never be emitted for the new data?

See https://lore.kernel.org/all/amIu5WWgTNkdvqIz@redhat.com/ for details.

So I wrote that "Test-case for io_uring" to a) check that sashiko was right,
and b) to ensure that V2 doesn't change the current behaviour of io_uring.

I won't argue with "nobody sane should ever use", but IMO the same is true
for epoll with EPOLLET.

--------------------------------------------------------------------------
So, let me ask. Apart from the comments and naming, do you agree with this
patch?

I like the new version more, even if we forget about io_uring. Note that
this way epoll_ctl() without EPOLLET in .events will not set ->poll_usage,
and hopefully "nobody sane" use this flag...

What do you think?

Oleg.

