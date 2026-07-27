Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9AC409289
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155341; cv=none; b=Set2TsPJy741wDAZFtLBK6gOLrX9e4XF+GQIba1C9oACV7jm95AqKQTcDPvFGVgMQulmGqbtJh9pMV0xpxYzIjyUPtin79tIaOLX38nKs3jWFNkGtnEssAm+zsTJv42VagcxxjLJBH8lAJWldvV0a4El/e7yM6qcXKwQKSnMMdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155341; c=relaxed/simple;
	bh=OnTHACUZXcWkKTlSXJLOAiN+Golk6o+k+/xUm4QrnrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nasig2tMpXxFwaSJy1ITEoObC7haj2X60O1q/2bCaS9H1bn2hXbfIKg7n/3atHfvwFmK0V2uyfPt2o4ilicAiYjznI2EiPO3WUyQ6KkaV864SQMt33fKvevPp4yIjoJDodYURXmfhWMXDC4GPIBpbXaW29apL9eB2IDCAPsD8kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NsdGDD95; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NsdGDD95"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785155339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rFEBD3z/Lvl32+XITyTlZUIkkoCNEcsPSxA81f9O8xw=;
	b=NsdGDD95cvNj5P8eKeNHu+RK0oztL/pj3Xx7oprpOweR+8ODuEqAc5dCWz4X5nrhYs0lR3
	gIMqBfLcfjik5rzWzVT9iNNz+Ev/nHAuaoqND4NFFwB4v9A/MlsWuaTIYHFTGcZ9LfdvFt
	gKC7G1UuhGYPQNykJssKxCF6Qb55pVc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-OqLUHRt-MPmvvoAhWpe13w-1; Mon,
 27 Jul 2026 08:28:55 -0400
X-MC-Unique: OqLUHRt-MPmvvoAhWpe13w-1
X-Mimecast-MFC-AGG-ID: OqLUHRt-MPmvvoAhWpe13w_1785155334
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2940C195DE24;
	Mon, 27 Jul 2026 12:28:54 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 701D8180034F;
	Mon, 27 Jul 2026 12:28:50 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 27 Jul 2026 14:28:53 +0200 (CEST)
Date: Mon, 27 Jul 2026 14:28:48 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Subject: [RFC PATCH v2 1/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
Message-ID: <amdPACI3kw8PobPx@redhat.com>
References: <amdNxsTODR4MCl3R@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amdNxsTODR4MCl3R@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

pipe_poll() unconditionally sets poll_usage on the first call, forcing
anon_pipe_write() to wake up readers on every write even if the pipe was
not empty. But this is only needed for edge-triggered consumers: epoll
with EPOLLET and io_uring without (unsupported) IORING_POLL_ADD_LEVEL.
poll() and select() users pay for it for no reason.

Change pipe_poll() to set ->pipe_usage only if wait->_key & EPOLLET is
true, this check should catch both users.

While at it, add READ_ONCE() in anon_pipe_write() to pair with WRITE_ONCE()
in pipe_poll().

Test-case for epoll:

	#include <unistd.h>
	#include <sys/epoll.h>
	#include <assert.h>

	int main(void)
	{
		int pfd[2], efd;
		struct epoll_event evt = { .events = EPOLLIN | EPOLLET };

		pipe(pfd);
		efd = epoll_create1(0);
		epoll_ctl(efd, EPOLL_CTL_ADD, pfd[0], &evt);

		for (int i = 0; i < 2; ++i) {
			write(pfd[1], "", 1);
			assert(epoll_wait(efd, &evt, 1, 0) == 1);
		}

		return 0;
	}

Test-case for io_uring:

	#include <unistd.h>
	#include <sys/mman.h>
	#include <sys/epoll.h>
	#include <sys/syscall.h>
	#include <linux/io_uring.h>
	#include <assert.h>

	int main(void)
	{
		struct io_uring_params p = {};
		int fd, pfd[2];

		pipe(pfd);

		fd = syscall(SYS_io_uring_setup, 2, &p);
		assert(fd >= 0);

		void *ring = mmap(0, p.cq_off.cqes + p.cq_entries * sizeof(struct io_uring_cqe),
				  PROT_READ | PROT_WRITE, MAP_SHARED, fd, IORING_OFF_SQ_RING);
		assert(ring != MAP_FAILED);
		*(unsigned *)(ring + p.sq_off.tail) = 1;

		struct io_uring_sqe *sqes = mmap(0, p.sq_entries * sizeof(*sqes),
				  PROT_READ | PROT_WRITE, MAP_SHARED, fd, IORING_OFF_SQES);
		assert(sqes != MAP_FAILED);
		sqes[0].opcode = IORING_OP_POLL_ADD;
		sqes[0].fd = pfd[0];
		sqes[0].len = IORING_POLL_ADD_MULTI;
		sqes[0].poll32_events = EPOLLIN;

		syscall(SYS_io_uring_enter, fd, 1, 0, 0, 0, 0);

		unsigned *cq_head = ring + p.cq_off.head;
		unsigned *cq_tail = ring + p.cq_off.tail;
		for (int i = 0; i < 2; ++i) {
			write(pfd[1], "", 1);
			syscall(SYS_io_uring_enter, fd, 0, 0, IORING_ENTER_GETEVENTS, 0, 0);
			assert(*cq_tail == ++*cq_head);
		}

		return 0;
	}

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/pipe.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 429b0714ec57..98b1e2385103 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -689,7 +689,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	 * Epoll nonsensically wants a wakeup whether the pipe
 	 * was already empty or not.
 	 */
-	if (was_empty || pipe->poll_usage)
+	if (was_empty || READ_ONCE(pipe->poll_usage))
 		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 	if (wake_next_writer)
@@ -752,7 +752,6 @@ static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	}
 }
 
-/* No kernel lock held - fine */
 static __poll_t
 pipe_poll(struct file *filp, poll_table *wait)
 {
@@ -761,7 +760,9 @@ pipe_poll(struct file *filp, poll_table *wait)
 	union pipe_index idx;
 
 	/* Epoll has some historical nasty semantics, this enables them */
-	if (unlikely(!READ_ONCE(pipe->poll_usage)))
+	if ((filp->f_mode & FMODE_READ) &&
+	    wait && (wait->_key & EPOLLET) &&
+	    unlikely(!READ_ONCE(pipe->poll_usage)))
 		WRITE_ONCE(pipe->poll_usage, true);
 
 	/*
-- 
2.52.0


