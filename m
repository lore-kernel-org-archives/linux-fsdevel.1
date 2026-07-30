Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426C42CCB9
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420760; cv=none; b=AUZ5Jy4+sZlXwK6/T44vg/oD33ivOAn2UREi5g1QhUnuMJjGnizSMLoEq3dZnGJT0EnYOaFq7KMonboZlFz0c2aG+iLrV4Ze52QtIntuM3IJS0J+zO7USjvKgPg2ri/0JT5plHCU3ksm9MabwTtyIcY1RXdtNVzvu5E7bBptXsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420760; c=relaxed/simple;
	bh=ZTRFUYc79uSakqXJUBggqKXRIS+Z66Y9Wf1mY4FoEeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwX3Tu+mVCb004OjGSfdOTNrRft01A40x8aqyhFqzQi5wWE/uQP4pZdyDv+KcegmBleOXGUN3gHr/s39kBQtwkhI0FrdqcT+kNj3EKJTt0Xu+aBYu4ExYGd/FwrOg4I+aYtxep4Pv2Le2YR9W0yTotan9W+ZI1L2d4mJmyYTxC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fts5+fhf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fts5+fhf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785420758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rXwY+0k3qHROXew/KOPFcfPD7nWu4k0zlwz4+9HXhvM=;
	b=fts5+fhfrJW2Ck3sCRtpG5JdzUfrvjiYmR1o+M7rjqBo9mrnqYwSc0kjWuxqIoQcSpajbS
	b+h3F96z6I4pgak+KhJ+dTFoN10Vn5WDofd5+sDl5cJUzPjDgvLc5s9oFSf07kGXvIlfbs
	q2Blpq94s5jLK6BRGmfuH34OfDT9Kp8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-pXRZXenlN8GhZADRKFo3Yw-1; Thu,
 30 Jul 2026 10:12:34 -0400
X-MC-Unique: pXRZXenlN8GhZADRKFo3Yw-1
X-Mimecast-MFC-AGG-ID: pXRZXenlN8GhZADRKFo3Yw_1785420749
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A0FF81800617;
	Thu, 30 Jul 2026 14:12:28 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C71201956089;
	Thu, 30 Jul 2026 14:12:23 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 30 Jul 2026 16:12:28 +0200 (CEST)
Date: Thu, 30 Jul 2026 16:12:22 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Alexey Gladkov <legion@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org
Subject: [PATCH v3 1/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
Message-ID: <amtbxpqJ3pZwyT8D@redhat.com>
References: <amtbpwrhlNGJ9OK6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amtbpwrhlNGJ9OK6@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

pipe_poll() unconditionally sets poll_usage on the first call, forcing
anon_pipe_write() to wake up readers on every write even if the pipe was
not empty. But this is only needed for edge-triggered consumers: epoll
with EPOLLET and io_uring without (unsupported) IORING_POLL_ADD_LEVEL.
poll() and select() users pay for it for no reason.

Rename ->poll_usage to ->poll_et to make the purpose clearer, update the
comments to explain that io_uring depends on the "nasty semantics" too,
and change pipe_poll() to set ->poll_et only if wait->_key & EPOLLET is
true; this check should catch both users.

Also, add READ_ONCE() in anon_pipe_write() to pair with WRITE_ONCE() in
pipe_poll().

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
 fs/pipe.c                 | 15 ++++++++-------
 include/linux/pipe_fs_i.h |  4 ++--
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 429b0714ec57..e009772d860b 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -686,10 +686,10 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	 * how (for example) the GNU make jobserver uses small writes to
 	 * wake up pending jobs
 	 *
-	 * Epoll nonsensically wants a wakeup whether the pipe
-	 * was already empty or not.
+	 * If poll_et is set, edge-triggered consumers need a wakeup
+	 * on every write regardless of was_empty.
 	 */
-	if (was_empty || pipe->poll_usage)
+	if (was_empty || READ_ONCE(pipe->poll_et))
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
@@ -760,9 +759,11 @@ pipe_poll(struct file *filp, poll_table *wait)
 	struct pipe_inode_info *pipe = filp->private_data;
 	union pipe_index idx;
 
-	/* Epoll has some historical nasty semantics, this enables them */
-	if (unlikely(!READ_ONCE(pipe->poll_usage)))
-		WRITE_ONCE(pipe->poll_usage, true);
+	/* Enable edge-triggered (epoll, io_uring) per-write wakeups */
+	if ((filp->f_mode & FMODE_READ) &&
+	    wait && (wait->_key & EPOLLET) &&
+	    unlikely(!READ_ONCE(pipe->poll_et)))
+		WRITE_ONCE(pipe->poll_et, true);
 
 	/*
 	 * Reading pipe state only -- no need for acquiring the semaphore.
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 7f6a92ac9704..322661d2a0c8 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -74,7 +74,7 @@ union pipe_index {
  *	@files: number of struct file referring this pipe (protected by ->i_lock)
  *	@r_counter: reader counter
  *	@w_counter: writer counter
- *	@poll_usage: is this pipe used for epoll, which has crazy wakeups?
+ *	@poll_et: has an edge-triggered (epoll, io_uring) consumer
  *	@fasync_readers: reader side fasync
  *	@fasync_writers: writer side fasync
  *	@bufs: the circular array of pipe buffers
@@ -95,7 +95,7 @@ struct pipe_inode_info {
 	unsigned int files;
 	unsigned int r_counter;
 	unsigned int w_counter;
-	bool poll_usage;
+	bool poll_et;
 #ifdef CONFIG_WATCH_QUEUE
 	bool note_loss;
 #endif
-- 
2.52.0


