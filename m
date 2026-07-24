Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CB7436BCD
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901515; cv=none; b=O+6SxOoLZJ3itdicN/MbszpD0+NZA1Eoz9dbVbBuNbazYkhb+htSkhUmxqbMMyFBCKSdXn8WyWDHOUrDXBf3QBPczpMkbUJ5DXQUNPCOMuEVeBNBqZs9dy93Q1TrS6ZnSKhprGqmaTmXUpBchA/a821iFJsC0IXi/pT5GtMKQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901515; c=relaxed/simple;
	bh=g35OQpXrGMTfT1WrCySJpT5m/NUeHtQUih9hCPj3Ce4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0ltfzqr0wAWexLQTZo77T97oUPx1LhBxj3pYHXAs8A7sIFTghWI7ZKZEbDCMZDi849XQYjaU77Yj+uGBMY5WlIZB1b2m1Xb0I/lBxKeHbg1MZ/6uiWUaAlb8XY9amuFa76gkBAMBe/yfqu5Va5SGXTQqDTfA84BtZxY3Cl7shs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2FIa8QY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2FIa8QY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784901509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9+22VVlVLxf/L260r7KU88FTjxNHo6A+bvRoZJVOqxw=;
	b=S2FIa8QYaJbLbfAbZvldHExxx63xrB5k3Zv+wgjD2llc7zpS6WJ3EO+Shdbuke2sNKVVEt
	QtfhYb4IEx1NMFnv8wG20Lq0q72I3T+pxE8ZGpvgGLAp7PJ4XOVYuNnnXML/E4aUklMdbw
	+AnTVleku8a/b+qtU9W1rgx2mZpytwA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-3LPWLRa8PXqyHV92D5exBQ-1; Fri,
 24 Jul 2026 09:58:25 -0400
X-MC-Unique: 3LPWLRa8PXqyHV92D5exBQ-1
X-Mimecast-MFC-AGG-ID: 3LPWLRa8PXqyHV92D5exBQ_1784901504
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FA651944DC8;
	Fri, 24 Jul 2026 13:58:23 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 719F918001CF;
	Fri, 24 Jul 2026 13:58:19 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 24 Jul 2026 15:58:23 +0200 (CEST)
Date: Fri, 24 Jul 2026 15:58:17 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
Subject: Re: [PATCH 0/1] pipe: only enable the extra wake_up(rd_wait) when
 epoll is actually used
Message-ID: <amNvebqiG2fH0W_L@redhat.com>
References: <amIqfCo25rLtM2U0@redhat.com>
 <amIu5WWgTNkdvqIz@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amIu5WWgTNkdvqIz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 07/23, Oleg Nesterov wrote:
>
> OK, sashiko has some concerns
>
> 	https://sashiko.dev/#/patchset/amIqmbbZx3NlzUsX%40redhat.com

Let me quote:

	Does skipping this wakeup for non-epoll consumers break io_uring?

	Applications polling pipes via io_uring do not attach an eventpoll context,
	so pipe->epoll_usage will be false. If a writer writes to an empty pipe,
	io_uring receives the wakeup.

	If the writer then writes a second chunk before the first is drained,
	anon_pipe_write() observes was_empty == false and
	pipe_get_epoll_usage() == false, skipping the waitqueue wakeup.

	Could this cause io_uring to miss events and hang permanently, waiting
	for a CQE that will never be emitted for the new data?

and I am starting to think sashiko is right (damn as always ;) and this
patch does affect/break io_uring.

Jens, could you confirm? If yes, we need to update the comments in pipe.c
(I've attached 1/1 at the end, so that you can see what this patch does)

I know nothing about io_uring and io_uring/poll.c is not trivial to say at
least ;) please check my understanding.

It seems that IORING_OP_POLL_ADD / IORING_POLL_ADD_MULTI is edge-triggered
by default! Like EPOLL_CTL_ADD / EPOLLET.

This means that io_uring depends on the "nasty semantics" too, io_poll_wake()
path should add the task work which calls io_req_post_cqe() every time the new
data arrives, even if the pipe was not empty.

Strange...

And. io_poll_parse_events() doesn't set EPOLLET if IORING_POLL_ADD_LEVEL, but
how is it possible to use IORING_POLL_ADD_LEVEL? io_poll_add_prep() only allows
IORING_POLL_ADD_MULTI in flags? OK, I don't understand this code anyway...

Oleg.
---

Subject: [PATCH] pipe: only enable the extra wake_up(rd_wait) when epoll is actually used

pipe_poll() unconditionally sets poll_usage on the first call, forcing
anon_pipe_write() to wake up readers on every write even if the pipe was
not empty. But this is only needed for epoll's "nasty semantics"; poll()
and select() users pay for it for no reason.

Rename it to epoll_usage, and only set it when the caller is actually
using epoll on the read side of the pipe.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/pipe.c                 | 23 +++++++++++++++++++----
 include/linux/pipe_fs_i.h |  6 ++++--
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 32140cb00d7e..b45b4b8d0b0b 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -357,6 +357,23 @@ static inline unsigned int pipe_update_tail(struct pipe_inode_info *pipe,
 	return tail;
 }
 
+static void pipe_set_epoll_usage(struct file *filp, struct pipe_inode_info *pipe)
+{
+#ifdef CONFIG_EPOLL
+	if ((filp->f_mode & FMODE_READ) && filp->f_ep &&
+	    unlikely(!READ_ONCE(pipe->epoll_usage)))
+		WRITE_ONCE(pipe->epoll_usage, true);
+#endif
+}
+
+static bool pipe_get_epoll_usage(struct pipe_inode_info *pipe)
+{
+#ifdef CONFIG_EPOLL
+	return pipe->epoll_usage;
+#endif
+	return false;
+}
+
 static ssize_t
 anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -689,7 +706,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	 * Epoll nonsensically wants a wakeup whether the pipe
 	 * was already empty or not.
 	 */
-	if (was_empty || pipe->poll_usage)
+	if (was_empty || pipe_get_epoll_usage(pipe))
 		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 	if (wake_next_writer)
@@ -761,9 +778,7 @@ pipe_poll(struct file *filp, poll_table *wait)
 	union pipe_index idx;
 
 	/* Epoll has some historical nasty semantics, this enables them */
-	if (unlikely(!READ_ONCE(pipe->poll_usage)))
-		WRITE_ONCE(pipe->poll_usage, true);
-
+	pipe_set_epoll_usage(filp, pipe);
 	/*
 	 * Reading pipe state only -- no need for acquiring the semaphore.
 	 *
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 7f6a92ac9704..d06da9bad3a8 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -74,7 +74,7 @@ union pipe_index {
  *	@files: number of struct file referring this pipe (protected by ->i_lock)
  *	@r_counter: reader counter
  *	@w_counter: writer counter
- *	@poll_usage: is this pipe used for epoll, which has crazy wakeups?
+ *	@epoll_usage: is this pipe used for epoll, which has crazy wakeups?
  *	@fasync_readers: reader side fasync
  *	@fasync_writers: writer side fasync
  *	@bufs: the circular array of pipe buffers
@@ -95,7 +95,9 @@ struct pipe_inode_info {
 	unsigned int files;
 	unsigned int r_counter;
 	unsigned int w_counter;
-	bool poll_usage;
+#ifdef CONFIG_EPOLL
+	bool epoll_usage;
+#endif
 #ifdef CONFIG_WATCH_QUEUE
 	bool note_loss;
 #endif
-- 
2.52.0


