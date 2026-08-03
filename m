Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94EE2F7EF6
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Aug 2026 01:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785721971; cv=none; b=OeI4IKOfjQK4RWYdAgUB0WPhOl0pnfWwjTYt5zf+4VwumjKcki1BIpkLwsmMSOCMDqyOWffxmEej7t1uyGGqktEs5QWOFePbCSnE60mJTZPSGbrtSC3VAq/JVsSFIZoC+xbxbysvZ0tysVrtclCGwiO1EV+kAGVsjiZtfGr4Upk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785721971; c=relaxed/simple;
	bh=ojZo+ucS5/6Fu7SmbfQ0tXli7zb2FizATZBNFnUJLRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JVTptWkUHxV0O1HbjRvU9zi46/zYwCdcHUc5/fFs4CdBtfe67aitmsvDZ9ZaX3RV829UWRqehBd9WtmEfe4/mOV3FLUZKEg0562DOw7LGfOYIetkE6vYL7Rov8xThqqcQ3zDDX7sLGgslQnW+Otf8Ww+DMP1ddQuIJk2mUPhVYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDUvm62Q; arc=none smtp.client-ip=74.125.227.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDUvm62Q"
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2ccc2e84048so16769155ad.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Aug 2026 18:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785721969; x=1786326769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DwmWQ5odQKMOsUvL/8xF5uR8hh2sroQZB6agvNlfobk=;
        b=cDUvm62QWqLuioWXRvnHuSENPQ3kmWKBcsI/EAlchy7zp+ebUAUOwNbQKGwsNtpAa1
         RQTANz/q/2zA8eAdqsZLmX8Qw3+bx4WUzC9tKez1j/Xtaw08MAafMVEi7b4jBtjhiB60
         yQgo3AU2IsB58XQ8pNduV5mLgRsMaeFS2wbdtbUMhnJHc5JVyu5BO8LL42LULMYkYyWq
         Cp9JLd4piPosg9xMhSRw3v+ClQNOMPix00e2a6AxfchkVIganO5hoec80ENXeNCg8rvy
         a4r9HG6B2D174TQj26vaNWyDbSZPYw6OTHflIpkWKUHtjC7DnHERNML74GMV0yz8wB/0
         Pkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785721969; x=1786326769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DwmWQ5odQKMOsUvL/8xF5uR8hh2sroQZB6agvNlfobk=;
        b=Mgh/AjYhJIl+ZSN6QTlQ8gGFqWW8RJqUaDJlwo8cWmUibNqpeS68i5zTP6EuI7zvMO
         j7U4Z386V4Y0yyz+RbZ0Lj8p2zxpHWR91nEbY4RqlS5CIcYPZy4gIAO1WwAjZlV5YX/6
         xtz6Mo5Bkh2ukv9aGi7xTOpuZALqUiIS0sIJmELtutvL/BY6RW4ls//iATejjryo4/Yf
         00/3zEl5yLFPkSgxRyEn6evF8LuRTlgAnWxyCELt6tg5Lf3g7KqxhvCW6x3SvHX+JifC
         qcsI/MiXUTjg4+YIn+q6exOgnMTT4MNSuG9ce1o7/ahtElZXw/L68CVqC+nCvBUTY+Hg
         NbYg==
X-Forwarded-Encrypted: i=1; AHgh+RpcfB8EMb3OTbBlazWX9aT4ebQrR33mJYtlV7KtNrk4a2FCeswh+RhlBbDNMqlGaX/EWKggFtWB8Qtu/KDJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyGATiuJ3KBv1X6OUJwkdbP4NdO5boK59BsvPApiMxwSMkStpXa
	Jp7UwoXcSnhU4WbXihb9t02U85+65fzYYZ39bVZ9cif3Q+j8NGR088QD
X-Gm-Gg: AR+sD12rUTzS9kf/iB4YQ7HR5J4ZcX1flFIV6eeAZU9Oe5B42mYbvtWHGtFXH8YnrUK
	LJs4n58GxKfkhdu0c0GvnjZ3hssThm1ydq8LsSq0qS9iv9K/gjYUSsi98pfTp3tUyUJK328liVk
	BNylOhTc9Q7LMKLFsXeKU07xUzPFokvKmHiZRRBrDEvac1L8zyTsDa45tnvWo+zOPeEiBPm+hfF
	imWp7+yGnhSFXcrQJPoA6P/1AQImPxqzbL+stOCS026Lw63XRMWsBKjqpZa9ZS+Feebg/u4LbXd
	NpHR1G6WjtokbGuzOkXqPRVHBWwbp9+Xsxg4/GOcgDhLnZdmXiE/vTEeVD2jyVRNS5ThfMQbtwl
	0z2qV86bpY1SPEa1KhLbM42tErG30kNxu/PjK1RSvQivbCJZAal0+nVFdgoAIAChogiaf2NHJAy
	nEgeg840bRLLu34WGf1anJ1B+l/Qm1a2L7lTbCC1Dht/2WOdkIaHi0Qc3zvmCZpijI2An8b25Vk
	2E=
X-Received: by 2002:a17:902:ce8b:b0:2ce:9b49:d4a0 with SMTP id d9443c01a7336-2d0524939c7mr83300325ad.35.1785721968961;
        Sun, 02 Aug 2026 18:52:48 -0700 (PDT)
Received: from localhost.localdomain ([106.14.251.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b1222easm30240015ad.68.2026.08.02.18.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 18:52:48 -0700 (PDT)
From: --global <syhuang.nju@gmail.com>
To: brauner@kernel.org
Cc: jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH RESEND] eventpoll: add lockless fast-path for eventfd
Date: Mon,  3 Aug 2026 01:52:42 +0000
Message-ID: <20260803015242.1810867-1-syhuang.nju@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siyuan Huang <syhuang.nju@gmail.com>

This PATCH introduces a lockless fast-path in ep_poll_callback() that
avoids acquiring ep->lock when the target epitem is already queued on
the ready list.  The optimization is specific to eventfd-backed epitems
because eventfd provides the simple, deterministic readiness semantics
needed for a correct lockless check.

== Problem ==

Concurrent eventfd writers can cause substantial contention on
eventpoll's ep->lock. Each eventfd wakeup invokes ep_poll_callback(),
which acquires ep->lock even when the epitem is already owned by the
ready-processing path and no additional ready-list insertion is
required.

== Solution ==

Add an eventfd-specific fast path that allows ep_poll_callback() to
return before taking ep->lock when the epitem already has a ready
processing owner.

The optimization uses two variables:

  A = epi->notified
  B = eventfd count-derived readiness

The scanner executes:

  W(A = false) -> smp_mb() -> dequeue -> R(B)

An eventfd readiness transition executes:

  W(B) -> smp_mb() -> R(A)

The full barriers prohibit the store-buffering outcome in which the
scanner reads the old readiness state while the callback reads the old
A == true state.

Consequently:

  - If the callback reads A == false, no ready-processing owner is
	registered; take the slow path to establish one (either through
	rdllist or ovflist, depending on whether a scan is in progress).

  - If the callback reads A == true, the epitem is already under
	scanner ownership. Whether the scanner has dequeued it yet or not,
	the scanner will either re-poll it (observing the new B) or has
	already found it on the ready list. Either way, the event is not lost.

notified is cleared before an epitem is removed from the scanner's
batch and is set after it is inserted into rdllist, ovflist, or the
scanner batch. A true value represents ready-processing
responsibility; it is not intended to be an exact lockless view of
list membership.

Skipping the callback wakeup is safe because the transition that first
establishes ready-processing responsibility still performs the
original wakeup. ep_done_scan() also wakes epoll waiters when rdllist
remains non-empty, and a new epoll_wait() caller rechecks the persistent
ready condition before sleeping. For the non-exclusive items accepted
by the fast path, returning 1 also preserves the callback's original
return value.

The fast path is restricted to directly monitored, level-triggered
eventfds. EPOLLET, EPOLLONESHOT, EPOLLEXCLUSIVE and POLLFREE continue
to use the original callback path.

The implementation is currently guarded by CONFIG_EVENTFD_OPT and
disabled by default while the cost of the additional full barriers is
evaluated on more architectures and non-epoll eventfd workloads.

== Performance ==

On a Kunpeng-950 system, one 5-second benchmark run produced the
following successful-read throughput changes:

                         same NUMA       cross NUMA
  1 writer / 1 reader      +5.8%           +47.2%
  8 writers / 8 readers  +129.5%          +131.5%

Mean ping-pong latency changed by -1.7% on the same NUMA node and
-0.5% across NUMA nodes.

Resending with linux-kernel@vger.kernel.org copied.
No code changes.

---
 fs/eventfd.c            | 45 ++++++++++++++++----
 fs/eventpoll.c          | 92 +++++++++++++++++++++++++++++++++++++++++
 include/linux/eventfd.h | 11 +++++
 init/Kconfig            | 12 ++++++
 4 files changed, 152 insertions(+), 8 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 9d33a02757d5..3d34cd652ac7 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -43,6 +43,29 @@ struct eventfd_ctx {
 	int id;
 };
 
+static inline void eventfd_wake_up_locked_poll(struct eventfd_ctx *ctx,
+					       __poll_t mask)
+{
+	lockdep_assert_held(&ctx->wqh.lock);
+
+	/* Protected by ctx->wqh.lock. */
+	if (!waitqueue_active(&ctx->wqh))
+		return;
+
+#ifdef CONFIG_EVENTFD_OPT
+	/*
+	 * Eventfd context of the two-variable protocol:
+	 *
+	 * W(B) updates ctx->count in the caller, then the callback performs
+	 * R(A) on epitem->notified.
+	 *
+	 * W(B) -> smp_mb() -> R(A)
+	 */
+	smp_mb();
+#endif
+	wake_up_locked_poll(&ctx->wqh, mask);
+}
+
 /**
  * eventfd_signal_mask - Increment the event counter
  * @ctx: [in] Pointer to the eventfd context.
@@ -72,8 +95,7 @@ void eventfd_signal_mask(struct eventfd_ctx *ctx, __poll_t mask)
 	current->in_eventfd = 1;
 	if (ctx->count < ULLONG_MAX)
 		ctx->count++;
-	if (waitqueue_active(&ctx->wqh))
-		wake_up_locked_poll(&ctx->wqh, EPOLLIN | mask);
+	eventfd_wake_up_locked_poll(ctx, EPOLLIN | mask);
 	current->in_eventfd = 0;
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
 }
@@ -203,8 +225,8 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *w
 	spin_lock_irqsave(&ctx->wqh.lock, flags);
 	eventfd_ctx_do_read(ctx, cnt);
 	__remove_wait_queue(&ctx->wqh, wait);
-	if (*cnt != 0 && waitqueue_active(&ctx->wqh))
-		wake_up_locked_poll(&ctx->wqh, EPOLLOUT);
+	if (*cnt != 0)
+		eventfd_wake_up_locked_poll(ctx, EPOLLOUT);
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
 
 	return *cnt != 0 ? 0 : -EAGAIN;
@@ -234,8 +256,7 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 	}
 	eventfd_ctx_do_read(ctx, &ucnt);
 	current->in_eventfd = 1;
-	if (waitqueue_active(&ctx->wqh))
-		wake_up_locked_poll(&ctx->wqh, EPOLLOUT);
+	eventfd_wake_up_locked_poll(ctx, EPOLLOUT);
 	current->in_eventfd = 0;
 	spin_unlock_irq(&ctx->wqh.lock);
 	if (unlikely(copy_to_iter(&ucnt, sizeof(ucnt), to) != sizeof(ucnt)))
@@ -270,8 +291,7 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 	if (likely(res > 0)) {
 		ctx->count += ucnt;
 		current->in_eventfd = 1;
-		if (waitqueue_active(&ctx->wqh))
-			wake_up_locked_poll(&ctx->wqh, EPOLLIN);
+		eventfd_wake_up_locked_poll(ctx, EPOLLIN);
 		current->in_eventfd = 0;
 	}
 	spin_unlock_irq(&ctx->wqh.lock);
@@ -310,6 +330,15 @@ static const struct file_operations eventfd_fops = {
 	.llseek		= noop_llseek,
 };
 
+#ifdef CONFIG_EVENTFD_OPT
+bool is_eventfd_file(struct file *file)
+{
+	return file->f_op == &eventfd_fops;
+}
+EXPORT_SYMBOL_GPL(is_eventfd_file);
+
+#endif
+
 /**
  * eventfd_fget - Acquire a reference of an eventfd file descriptor.
  * @fd: [in] Eventfd file descriptor.
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index eed8cecd94e3..09e9239ce2d5 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -39,6 +39,9 @@
 #include <linux/rculist.h>
 #include <linux/capability.h>
 #include <linux/seqlock.h>
+#ifdef CONFIG_EVENTFD_OPT
+#include <linux/eventfd.h>
+#endif
 #include <net/busy_poll.h>
 
 /*
@@ -285,6 +288,14 @@ struct epitem {
 
 	/* The structure that describe the interested events and the source fd */
 	struct epoll_event event;
+
+#ifdef CONFIG_EVENTFD_OPT
+	/* Set after queueing, cleared before dequeueing from the ready path. */
+	bool notified;
+
+	/* True if the monitored file is an eventfd. */
+	bool is_eventfd;
+#endif
 };
 
 /*
@@ -620,6 +631,65 @@ static inline bool ep_events_available(struct eventpoll *ep)
 		read_seqcount_retry(&ep->seq, seq);
 }
 
+#ifdef CONFIG_EVENTFD_OPT
+/*
+ * Eventfd/epoll two-variable communication:
+ *
+ *   A = epi->notified
+ *   B = eventfd count/readiness
+ *
+ *   scanner context: W(A = false) -> smp_mb() -> dequeue -> R(B)
+ *   eventfd context: W(B)         -> smp_mb() -> R(A)
+ *
+ * Therefore R(B) == old and R(A) == true cannot both occur.
+ */
+static inline void ep_set_notified(struct epitem *epi)
+{
+	if (epi->is_eventfd)
+		WRITE_ONCE(epi->notified, true);
+}
+
+static inline void ep_eventfd_prepare_repoll(struct epitem *epi)
+{
+	if (!epi->is_eventfd)
+		return;
+
+	/*
+	 * Stop callbacks from skipping before the scanner drops its ready-list
+	 * ownership. Keep the full barrier between W(A = false) and R(B); the
+	 * actual dequeue may happen between the barrier and the readiness read.
+	 */
+	WRITE_ONCE(epi->notified, false);
+	/* Scanner context: W(A = false) -> smp_mb() -> R(B). */
+	smp_mb();
+}
+
+static inline bool ep_eventfd_callback_can_skip(struct epitem *epi,
+						__poll_t pollflags)
+{
+	if (!epi->is_eventfd)
+		return false;
+
+	if (READ_ONCE(epi->event.events) &
+	    (EPOLLEXCLUSIVE | EPOLLET | EPOLLONESHOT))
+		return false;
+
+	if (pollflags & POLLFREE)
+		return false;
+
+	/* Eventfd context: W(B) -> smp_mb() -> R(A). */
+	return READ_ONCE(epi->notified);
+}
+#else
+static inline void ep_set_notified(struct epitem *epi) { }
+static inline void ep_eventfd_prepare_repoll(struct epitem *epi) { }
+static inline bool ep_eventfd_callback_can_skip(struct epitem *epi,
+						__poll_t pollflags)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_NET_RX_BUSY_POLL
 /**
  * busy_loop_ep_timeout - check if busy poll has timed out. The timeout value
@@ -1007,6 +1077,7 @@ static void ep_done_scan(struct eventpoll *ep,
 			 * reverses the iteration order into FIFO.
 			 */
 			list_add(&epi->rdllink, &ep->rdllist);
+			ep_set_notified(epi);
 			ep_pm_stay_awake(epi);
 		}
 	}
@@ -1303,8 +1374,11 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
 	mutex_lock_nested(&ep->mtx, depth);
 	ep_start_scan(ep, &scan_batch);
 	list_for_each_entry_safe(epi, tmp, &scan_batch, rdllink) {
+		/* Clear notified before a possible removal from txlist. */
+		ep_eventfd_prepare_repoll(epi);
 		if (ep_item_poll(epi, &pt, depth + 1)) {
 			res = EPOLLIN | EPOLLRDNORM;
+			ep_set_notified(epi);
 			break;
 		} else {
 			/*
@@ -1497,6 +1571,9 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	unsigned long flags;
 	int ewake = 0;
 
+	if (ep_eventfd_callback_can_skip(epi, pollflags))
+		return 1;
+
 	spin_lock_irqsave(&ep->lock, flags);
 
 	ep_set_busy_poll_napi_id(epi);
@@ -1529,11 +1606,13 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 		if (!epi_on_ovflist(epi)) {
 			epi->ovflist_next = READ_ONCE(ep->ovflist);
 			WRITE_ONCE(ep->ovflist, epi);
+			ep_set_notified(epi);
 			ep_pm_stay_awake_rcu(epi);
 		}
 	} else if (!ep_is_linked(epi)) {
 		/* In the usual case, add event to ready list. */
 		list_add_tail(&epi->rdllink, &ep->rdllist);
+		ep_set_notified(epi);
 		ep_pm_stay_awake_rcu(epi);
 	}
 
@@ -1840,6 +1919,9 @@ static struct epitem *ep_alloc_epitem(struct eventpoll *ep,
 	epi->ffd = *tf;
 	epi->event = *event;
 	epi_clear_ovflist(epi);
+#ifdef CONFIG_EVENTFD_OPT
+	epi->is_eventfd = is_eventfd_file(tfile);
+#endif
 
 	return epi;
 }
@@ -1956,6 +2038,7 @@ static int ep_insert(struct ep_ctl_ctx *ctx, struct eventpoll *ep,
 
 	if (revents && !ep_is_linked(epi)) {
 		list_add_tail(&epi->rdllink, &ep->rdllist);
+		ep_set_notified(epi);
 		ep_pm_stay_awake(epi);
 
 		if (waitqueue_active(&ep->wq))
@@ -2031,6 +2114,7 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 		spin_lock_irq(&ep->lock);
 		if (!ep_is_linked(epi)) {
 			list_add_tail(&epi->rdllink, &ep->rdllist);
+			ep_set_notified(epi);
 			ep_pm_stay_awake(epi);
 
 			/* Notify waiting tasks that events are available */
@@ -2084,6 +2168,12 @@ static int ep_deliver_event(struct eventpoll *ep, struct epitem *epi,
 		__pm_relax(ws);
 	}
 
+	/*
+	 * Clear notified while epi is still on txlist. A callback that
+	 * races with the following dequeue must take the slow path and
+	 * publish the event through ovflist.
+	 */
+	ep_eventfd_prepare_repoll(epi);
 	list_del_init(&epi->rdllink);
 
 	/*
@@ -2104,6 +2194,7 @@ static int ep_deliver_event(struct eventpoll *ep, struct epitem *epi,
 		 * attempt.
 		 */
 		list_add(&epi->rdllink, scan_batch);
+		ep_set_notified(epi);
 		ep_pm_stay_awake(epi);
 		return -EFAULT;
 	}
@@ -2120,6 +2211,7 @@ static int ep_deliver_event(struct eventpoll *ep, struct epitem *epi,
 		 * during scans.
 		 */
 		list_add_tail(&epi->rdllink, &ep->rdllist);
+		ep_set_notified(epi);
 		ep_pm_stay_awake(epi);
 	}
 	return 1;
diff --git a/include/linux/eventfd.h b/include/linux/eventfd.h
index e32bee4345fb..0f5d0f589d92 100644
--- a/include/linux/eventfd.h
+++ b/include/linux/eventfd.h
@@ -40,6 +40,10 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *w
 				  __u64 *cnt);
 void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
 
+#ifdef CONFIG_EVENTFD_OPT
+bool is_eventfd_file(struct file *file);
+#endif
+
 static inline bool eventfd_signal_allowed(void)
 {
 	return !current->in_eventfd;
@@ -82,6 +86,13 @@ static inline void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
 
 }
 
+#ifdef CONFIG_EVENTFD_OPT
+static inline bool is_eventfd_file(struct file *file)
+{
+	return false;
+}
+#endif
+
 #endif
 
 static inline void eventfd_signal(struct eventfd_ctx *ctx)
diff --git a/init/Kconfig b/init/Kconfig
index 10f2013b5321..c734dfe3490c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1896,6 +1896,18 @@ config EVENTFD
 
 	  If unsure, say Y.
 
+config EVENTFD_OPT
+	bool "Optimize eventfd/epoll interaction" if EXPERT
+	depends on EVENTFD && EPOLL
+	default n
+	help
+	  Enables a lockless fast-path in ep_poll_callback for eventfd
+	  files, reducing ep->lock contention under concurrent workloads.
+	  Full memory barriers prevent lost wakeups when eventfd updates
+	  race with epoll re-polling.
+
+	  If unsure, say N.
+
 config SHMEM
 	bool "Use full shmem filesystem" if EXPERT
 	default y
-- 
2.43.0

