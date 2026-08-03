Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCD540756E
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761215; cv=none; b=DABcySnVkhaEvO7P/lmeQ2eN0SYP4dDK9mcrP4gSAqPuj6T4mHqz9XeVL4CmeNMclX6A5lmVbrMyfxswwpRnDVOofdX8fZL8I5N62mmXypBr+RwTln075UhN63OtG7WfKYwvNtyxZzTCaUVKu0iuj+ukLUkzXp2uISNf0qTvxhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761215; c=relaxed/simple;
	bh=5TCgU5zbyBLDg+DnZg8eCxnpYXT4Vv2vkwIQjgy7L6g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SFpHh4sg8R2LEA1sgSLICwuTtM805Bo5AMCDwqUl5zV8ej18c76PB6EgfgVocN/eJyRmpgD4CcRbZicmyjMW+PmaeIaS2FZOM8cMc4v1AlZU9EBRGuDNocT7847hxuiM4fS9VVS9OOtsdX4qa2Hi5bVL2s7WJ6Jk91z6XOFqaWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EO0Ii5p0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EO0Ii5p0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785761213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=lQ5xQ35lK31BPQRUsnqePjDzH7l92VhsEt/1x8cX/6g=;
	b=EO0Ii5p0GlO/D9wl4FTsN4Ypp44KwiyYeRSnKmC2IQJ+t52RjyNBnzI1cPRktuni6qPk1F
	zGCmuwKroD6WVd+enLSK4CvZu/0egwhH4yuJJWBJ3CH8kOonVvZxA5AVt4fSCpZl1dw+Cx
	YuQTPY41LQU6zSi1tFDl4Qquhky9hCY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-NdRnfQLPNs6h-q9o-NN78g-1; Mon,
 03 Aug 2026 08:46:34 -0400
X-MC-Unique: NdRnfQLPNs6h-q9o-NN78g-1
X-Mimecast-MFC-AGG-ID: NdRnfQLPNs6h-q9o-NN78g_1785761192
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78C74195608D;
	Mon,  3 Aug 2026 12:46:31 +0000 (UTC)
Received: from fedora (unknown [10.44.32.54])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BEDC41956087;
	Mon,  3 Aug 2026 12:46:26 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon,  3 Aug 2026 14:46:31 +0200 (CEST)
Date: Mon, 3 Aug 2026 14:46:25 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Subject: [PATCH v4] pipe: only enable the extra wake_up(rd_wait) for EPOLLET
 consumers
Message-ID: <anCNoW-x0bcB2ggg@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

pipe_poll() unconditionally sets ->poll_usage on the first call, forcing
anon_pipe_write() to wake up readers on every write even if the pipe was
not empty.

The reason is that some legacy epoll(EPOLLET) users depend on historical
per-write wakeups, see commit 3a34b13a88ca ("pipe: make pipe writes always
wake up readers").

Test-case:

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

it fails if WRITE_ONCE(poll_usage, true) is removed from pipe_poll().
However, without EPOLLET in .events, it does not need the extra wakeup
and succeeds even if write() is called only once before the main loop.

Currently io_uring without (unsupported) IORING_POLL_ADD_LEVEL always
sets EPOLLET, and in IORING_POLL_ADD_MULTI mode it depends on per-write
wakeups the same way:

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

the 2nd assert() in the main loop fails without ->poll_usage == true.

Rename ->poll_usage to ->pseudo_edgetrigger to make the purpose clearer,
update the comments, and change pipe_poll() to set ->pseudo_edgetrigger
only if wait->_key & EPOLLET is true. This check should catch both users,
and this way poll/select and epoll without EPOLLET users will not pay for
the extra wakeup.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 fs/pipe.c                 | 20 +++++++++++++-------
 include/linux/pipe_fs_i.h |  4 ++--
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 429b0714ec57..84a81db39f8a 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -686,10 +686,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	 * how (for example) the GNU make jobserver uses small writes to
 	 * wake up pending jobs
 	 *
-	 * Epoll nonsensically wants a wakeup whether the pipe
-	 * was already empty or not.
+	 * ->pseudo_edgetrigger enables per-write wakeups, see pipe_poll()
 	 */
-	if (was_empty || pipe->poll_usage)
+	if (was_empty || READ_ONCE(pipe->pseudo_edgetrigger))
 		wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN | EPOLLRDNORM);
 	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
 	if (wake_next_writer)
@@ -752,7 +751,6 @@ static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	}
 }
 
-/* No kernel lock held - fine */
 static __poll_t
 pipe_poll(struct file *filp, poll_table *wait)
 {
@@ -760,9 +758,17 @@ pipe_poll(struct file *filp, poll_table *wait)
 	struct pipe_inode_info *pipe = filp->private_data;
 	union pipe_index idx;
 
-	/* Epoll has some historical nasty semantics, this enables them */
-	if (unlikely(!READ_ONCE(pipe->poll_usage)))
-		WRITE_ONCE(pipe->poll_usage, true);
+	/*
+	 * Legacy epoll(EPOLLET) users depend on historical per-write wakeups,
+	 * see 3a34b13a88ca ("pipe: make pipe writes always wake up readers")
+	 * and the ->pseudo_edgetrigger check in anon_pipe_write().
+	 * Currently io_uring sets EPOLLET for multishot polls, so it gets the
+	 * same behaviour.
+	 */
+	if ((filp->f_mode & FMODE_READ) &&
+	    wait && (wait->_key & EPOLLET) &&
+	    unlikely(!READ_ONCE(pipe->pseudo_edgetrigger)))
+		WRITE_ONCE(pipe->pseudo_edgetrigger, true);
 
 	/*
 	 * Reading pipe state only -- no need for acquiring the semaphore.
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index 7f6a92ac9704..1acc76581af5 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -74,7 +74,7 @@ union pipe_index {
  *	@files: number of struct file referring this pipe (protected by ->i_lock)
  *	@r_counter: reader counter
  *	@w_counter: writer counter
- *	@poll_usage: is this pipe used for epoll, which has crazy wakeups?
+ *	@pseudo_edgetrigger: has an EPOLLET consumer, enable per-write wakeups
  *	@fasync_readers: reader side fasync
  *	@fasync_writers: writer side fasync
  *	@bufs: the circular array of pipe buffers
@@ -95,7 +95,7 @@ struct pipe_inode_info {
 	unsigned int files;
 	unsigned int r_counter;
 	unsigned int w_counter;
-	bool poll_usage;
+	bool pseudo_edgetrigger;
 #ifdef CONFIG_WATCH_QUEUE
 	bool note_loss;
 #endif
-- 
2.52.0


