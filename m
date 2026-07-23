Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E77448B94
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784818345; cv=none; b=IrtWYuR4UChMJ54GUzT0435bNkKUXoWaVqa6vqaRQePE1rrDoqAAKtDCUu+AzRmIfwQXyKmohOaqZfpZAZeA/rz+WLa6lPwOwazgWbADxUuesRRvOcPSlRH3JaIKltHnhXzdBDbOOnG3T9mY43p6XIWhf3UkSafU/vPkEao3rUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784818345; c=relaxed/simple;
	bh=PsdGTDq4LoXxUw32NaS6Sm9FWnylJl5TGe6Vj2v9Mv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QncnTbKCLI2uIeV6NrcpAEtO4v6kteKDKiGQXWiocshS0v/M7e8bIqeHh6V2EjDyeuTQjpdxa0vr0gabQlafKadg3w1Zvt28L7qjJzCLDL/gy6mxP0ijM1RPS88JEZgt6zs2SiHoUeSEC2scKrVDDRCejygPCQ5b38P6is1WW4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3kEDBbr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3kEDBbr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784818339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=22cl+7kMK7IFo7mDuOCQs4jFf/pjSy1ijkYFFbxn/ac=;
	b=S3kEDBbriiwKhKx03wc2BQU5XGkhzXH06Rm40sJFOY8mtdpAQHGZE2GevxKeNo0EXkYE8o
	xOlzXi31IIN82l7FvZRLi9brrt/ZP35V3QqYaUIKsP7Gld1vJYO1feRvVHrNUrwjALrTyo
	RyIQiUi3CzsTjowQqtniSeJy8zMvL4M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-xJjRWzCENXy6hgSwpnGvUA-1; Thu,
 23 Jul 2026 10:52:15 -0400
X-MC-Unique: xJjRWzCENXy6hgSwpnGvUA-1
X-Mimecast-MFC-AGG-ID: xJjRWzCENXy6hgSwpnGvUA_1784818334
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8DA91956065;
	Thu, 23 Jul 2026 14:52:13 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id BECCB1956058;
	Thu, 23 Jul 2026 14:52:10 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 23 Jul 2026 16:52:13 +0200 (CEST)
Date: Thu, 23 Jul 2026 16:52:09 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Breno Leitao <leitao@debian.org>,
	Christian Brauner <brauner@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] pipe: only enable the extra wake_up(rd_wait) when epoll
 is actually used
Message-ID: <amIqmbbZx3NlzUsX@redhat.com>
References: <amIqfCo25rLtM2U0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amIqfCo25rLtM2U0@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


