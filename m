Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF8F3B19AC
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Aug 2026 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785682605; cv=none; b=To+MyM0bjpBao9RXF5MXG7mGaa74EbwmBp7wdnCn8cnrFKFZWljVGGPGbQ8OofBOuHY+S84GJFksqAfy2TEhHSjWeNG+HUfE7YEBvn7ywmpBpMGN//9usj7EwcRZC9myUyQV46ramaS6ZwyXaXLxLv6bV1Cds//YBxkFu8TC4nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785682605; c=relaxed/simple;
	bh=SsD5RD1rz4sdDznzFOM1U1xnUevkaeft3eMuj1EjcB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXXyCMlzoVJZKSHOzhutheH5TWcX5UnqpAM7CAWGZAQ5jXTb3uO54I0ups41ukotHRQq+a0YOEJUofPTRFK5NhOLtoKAhUD8za7+tuPrLW97QIJ7B9Og9bREigtjvWbge5+rPh0vYbZo6PhUiI1M5PjA7TeZBR5eAz6+niRwiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CK1XWySL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CK1XWySL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785682602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IZQ9Zme5wQew44ai4+QZxeqarSEtAPFpGoxcQklaPAk=;
	b=CK1XWySLFSQITD3eb0locRtRQSWON6hpuKTB5RCofPv8SJ654qCW3dPx34Xid/ClXM3U88
	VzdyoS1MTLmcTaSiIywZbsYeAjmO/NKVCjVUpGI2g6oJcUkQ8MOwR2ueNvJEZS+p+r84m9
	RGXLOqAdqEZXn1OUJKE72VrrWgHOUzU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-3lZ48Y3fPmGKsBWwPy8yTQ-1; Sun,
 02 Aug 2026 10:56:39 -0400
X-MC-Unique: 3lZ48Y3fPmGKsBWwPy8yTQ-1
X-Mimecast-MFC-AGG-ID: 3lZ48Y3fPmGKsBWwPy8yTQ_1785682598
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A41991800345;
	Sun,  2 Aug 2026 14:56:37 +0000 (UTC)
Received: from fedora (unknown [10.44.32.54])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 387841956044;
	Sun,  2 Aug 2026 14:56:32 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun,  2 Aug 2026 16:56:37 +0200 (CEST)
Date: Sun, 2 Aug 2026 16:56:31 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Breno Leitao <leitao@debian.org>, Mateusz Guzik <mjguzik@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [PATCH v3 0/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
Message-ID: <am9an4HWPGaxmbcK@redhat.com>
References: <amtbpwrhlNGJ9OK6@redhat.com>
 <CAHk-=wi7EccGaeo2Q5mdcvcQJ8VX7tcJWW2fHkg6vfmHGGX8AA@mail.gmail.com>
 <amueLRM-DrYbnjLn@redhat.com>
 <20260731-blechnapf-arten-blasorchester-4e05dd1b2c58@brauner>
 <amysHlZp6f6q498X@redhat.com>
 <CAHk-=wg_PtU66p4iuvzCz13P_cDCfKg2OOuV-v6wq19ua8LyvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg_PtU66p4iuvzCz13P_cDCfKg2OOuV-v6wq19ua8LyvQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 07/31, Linus Torvalds wrote:
>
> My argument is that IF we change this area, we should damn well do it
> right, and document it, and make it very very clear that the *ONLY*
> reason this exists is a user space legacy bug that took advantage of
> legacy kernel behavior, and that we are papering this over.

OK, I'll rename poll_usage/poll_et to ->pseudo_edgetrigger as Christian
suggests and update the comments as below:

struct pipe_inode_info:

	@pseudo_edgetrigger: has an EPOLLET consumer, enable per-write wakeups

pipe_poll:

	/*
	 * Legacy epoll(EPOLLET) users depend on historical per-write wakeups,
	 * see 3a34b13a88ca ("pipe: make pipe writes always wake up readers")
	 * and the ->pseudo_edgetrigger check in anon_pipe_write().
	 * Currently io_uring sets EPOLLET for multishot polls, so it gets the
	 * same behaviour.
	 */
	if ((filp->f_mode & FMODE_READ) &&
	    wait && (wait->_key & EPOLLET) &&
	    unlikely(!READ_ONCE(pipe->pseudo_edgetrigger)))
		WRITE_ONCE(pipe->pseudo_edgetrigger, true);

anon_pipe_write:

	 * ->pseudo_edgetrigger enables per-write wakeups, see pipe_poll()
	 */
	if (was_empty || READ_ONCE(pipe->pseudo_edgetrigger))
		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);

Will you agree? Or should I tweak the comments somehow to make it more clear
that the only reason is a user space legacy bug?

Oleg.

