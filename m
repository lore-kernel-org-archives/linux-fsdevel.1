Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2640823909F
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 03:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786418149; cv=none; b=h03Hnr6TKgzCaghtIhxORXoMKjZmnQuRdVv24h35NbjQyP6xEvdlIwiP/n5XxFdVsKcyt2f6NSaMxmTi1syzmpGhQCaDqmIa4GO3/6cU8H7tSwW43JAR+FPy40R3j4w925ct1+t3y5W7Rqe2FMC43/ySLNWOAlE7RCG26+PAciw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786418149; c=relaxed/simple;
	bh=NdHAWJ9HWkQiyuuihDT0erRRiYEkL+dOLisdhAaV8Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pY+04i8AGVl2eFrYhxirilzggqH74y+L0uQxp0mVFYfju+qpeTrffav+tuUns8D41O0xZIv8sO8yqpB9tnhgXON2eXuGBhKvxaPk0nu6ipEf/rNnr/Xkh/FzCpS6X03pH/gi9MSJZcUBv/oE+xhseKgbgK9NF0MPTCexCtZwoVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rUzQ5zJb; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rUzQ5zJb"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cac634f921so7194995ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 20:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786418145; x=1787022945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7j6CiuGFhNHSn6V6fxUO1j5z2xVe2x2u8FnBdv4tDW4=;
        b=rUzQ5zJbU2qDtAma+IELvD9ka4UfP35DSI4HYJtMMsS0YtTijAl83NVXEq+qSIOpTA
         znWjL9yvttqqOrG/LJ5IPecLoCJtPmnXaMAD82sSXZegAJBL11XU1wgmdcqqJj5f3E96
         Uca+vLEFVlD9y9AWBdbcQmfOW93JJ5M2saGP1qQn7szIs8j3jlq8aUtK5owK/Zd6B5ov
         gefHmd8UYCWvzfJbzXh9cka54pjS7jL/fIOffd7jOZGN75KvR+ttRDYv5ZpQikRwraIx
         NgzKhXsBdMW/xuw/c4SD1QFsfC68WEzT0eORp2donmcPVHI5v9D5ydUARwpja6S8DwLc
         u1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786418145; x=1787022945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7j6CiuGFhNHSn6V6fxUO1j5z2xVe2x2u8FnBdv4tDW4=;
        b=EHyDf6XcB7jxDMcsIFPyj9a1BhcGmK9ftzHvnDw5FmQR2goJg5PQrGEGDBUKgA7vWs
         jCQlpn78Idcek7EgL4a88E7iq0cFx5fWREgSRlYrvuRMVk7wMSSot0RDQsOdYUrrLPCK
         ZW8L7pSLypZdbKbmsaNAZWA26Z+RSUfUtaTTA6G9PpaNo+giQFLYH1o+gfgBLJuBkNZz
         vhXLqat5aGM6/zd0k33sF8G84rGnJUvHNTj8XTRD1KzvS8jggGTsHMBnWyUxCTgThcy3
         opjyBMcy7rNQJ4Z5ZwgEcV8C/01QfNF0hlcTJwBRrBnKcEFa+Soq368li8jafZv9/D7A
         ohiA==
X-Forwarded-Encrypted: i=1; AHgh+RpSiO5qaD+vw+mkY7/+Vo53Xqf72YW8Xj6j1YU4+QzWe0KE/r4pmwc6GHaUwdvz3whxnYdYELNsPNYGHx0m@vger.kernel.org
X-Gm-Message-State: AOJu0Yy649Ae3RXHeQbazyltcquoz97rKQNyblJHEo/T97bqRk9q82qe
	iUGLOiwmvtrYhbrEXnG0Naj37eqKuxfWy9NDDLuEBhK8je0uX3+sEHSi1ByQmxKMb93DYw==
X-Gm-Gg: AR+sD108wfOp9vaw/1Ncv+kMNpM/FK0I7rDb4Jm3b2sK4tTPPLBNUD/+WgByi8/AQsv
	AjlAqNaUSMvKNvNOCWDNjnXi1k66l9InqIK1OY0wdpLtEYIQcUAoS6BK3dz7IEV3ppJg7y7MA3b
	BAGrws35J5YlruIdtVA3grIIfXeGwpZZX8Z+fyC7hO2TzESY3ORP5elfE1mESsglTxSSaI7MFwb
	1RDtbbYTXHJejQ8gBkpYhuTW/5yO0svYDQpLR2dXT+tqu3YDt4Xi14X2XKp3HO+dazcQSpGZNmW
	Nm0IKvLYX2B9L1EJdzXPv2aA6179ywsUA4Z5Q4dhzsxW9IKhx+vshA5BOjXg7On+H420kQa57RB
	M5EBdaSazZVsR6FhikO6DazhSX+bsOHiW2+xBUtMcEvalrU6tR+fcR5iPMxgksy6c/PYiBL68Je
	7+yePpKJ3UESjLE6WYpp/5mGzO7530/VaiYxBEwfrciie5Z+BQtXnEtsX0mxlkUf+m7PRmv7VHZ
	DE=
X-Received: by 2002:a17:903:32c7:b0:2ca:ecf6:9104 with SMTP id d9443c01a7336-2d317775e6cmr4126695ad.4.1786418145324;
        Mon, 10 Aug 2026 20:15:45 -0700 (PDT)
Received: from localhost.localdomain ([106.14.251.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d31623163bsm597495ad.79.2026.08.10.20.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 20:15:44 -0700 (PDT)
From: Siyuan Huang <syhuang.nju@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jack@suse.cz,
	nathan@kernel.org,
	ojeda@kernel.org,
	nsc@kernel.org,
	gary@garyguo.net,
	tglx@kernel.org,
	thomas.weissschuh@linutronix.de,
	aliceryhl@google.com,
	dianders@chromium.org,
	linux.amoon@gmail.com
Subject: [RFC PATCH RESEND] eventpoll: add lockless fast-path for eventfd
Date: Tue, 11 Aug 2026 03:15:38 +0000
Message-ID: <20260811031538.2782906-1-syhuang.nju@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This PATCH introduces a lockless fast-path in ep_poll_callback() that
avoids acquiring ep->lock when the target epitem is already owned by the
ready-processing path (on rdllist or in a scan batch). The optimization
is applied to eventfd-backed epitems only currently, but the mechanism
is general and could be applied to other level-triggered files that opt
in by setting FOP_EPOLL_LOCKLESS.

== Problem ==

Concurrent eventfd writers can cause substantial contention on
eventpoll's ep->lock. Each eventfd wakeup invokes ep_poll_callback(),
which acquires ep->lock even when the epitem is already owned by the
ready-processing path and no additional ready-list insertion is
required.

== Solution ==

Add a fast path that allows ep_poll_callback() to return before taking
ep->lock when the epitem already has a ready processing owner.

The optimization uses two variables:

  A = epi->notified   -- is this item already applied to the ready list
  B = file readiness  -- e.g. the eventfd counter

  scanner:  W(A = false) -> smp_mb() -> dequeue -> R(B)
  writer:   W(B)         -> smp_mb() -> R(A)

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
batch and is set after it is inserted into any list or the scanner
batch. A true value represents ready-processing responsibility; it
is not intended to be an exact lockless view of list membership.

Skipping the callback wakeup is safe because the transition that first
establishes ready-processing responsibility still performs the
original wakeup. ep_done_scan() also wakes epoll waiters when rdllist
remains non-empty, and a new epoll_wait() caller rechecks the persistent
ready condition before sleeping. For the non-exclusive items accepted
by the fast path, returning 1 is harmless and the wake will be performed
by the scanner or the next epoll_wait() caller.

The fast path is restricted to level-triggered, non-ONESHOT, non-ET,
non-EXCLUSIVE items only. No waiters on ep->poll_wait is also a requirement,
because nested epoll relies on the callback's pwake/ep_poll_safewake() path,
which the scan never runs. POLLFREE always takes the slow path so the release
handshake runs.

The implementation is currently guarded by CONFIG_EPOLL_LOCKLESS and
disabled by default, while the cost of the additional full barriers is
evaluated on more architectures and non-epoll eventfd workloads.

== Performance ==

average 5-second throughput benchmark (8 writers 8 readers) run
produced the following successful-read throughput changes:

		same NUMA	cross NUMA
  arm	+129%		+131%
  x86	+25%		+115%

Signed-off-by: Siyuan Huang <syhuang.nju@gmail.com>

---
 fs/eventfd.c       |  30 +++++++++--
 fs/eventpoll.c     | 122 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/fs.h |   4 ++
 init/Kconfig       |  11 ++++
 4 files changed, 160 insertions(+), 7 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 9d33a02757d5..9aa2b59cfad0 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -43,6 +43,25 @@ struct eventfd_ctx {
 	int id;
 };
 
+static inline void eventfd_wake_up_locked_poll(struct wait_queue_head *wqh,
+					       __poll_t mask)
+{
+	lockdep_assert_held(&wqh->lock);
+
+#ifdef CONFIG_EPOLL_LOCKLESS
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
+	wake_up_locked_poll(wqh, mask);
+}
+
 /**
  * eventfd_signal_mask - Increment the event counter
  * @ctx: [in] Pointer to the eventfd context.
@@ -73,7 +92,7 @@ void eventfd_signal_mask(struct eventfd_ctx *ctx, __poll_t mask)
 	if (ctx->count < ULLONG_MAX)
 		ctx->count++;
 	if (waitqueue_active(&ctx->wqh))
-		wake_up_locked_poll(&ctx->wqh, EPOLLIN | mask);
+		eventfd_wake_up_locked_poll(&ctx->wqh, EPOLLIN | mask);
 	current->in_eventfd = 0;
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
 }
@@ -204,7 +223,7 @@ int eventfd_ctx_remove_wait_queue(struct eventfd_ctx *ctx, wait_queue_entry_t *w
 	eventfd_ctx_do_read(ctx, cnt);
 	__remove_wait_queue(&ctx->wqh, wait);
 	if (*cnt != 0 && waitqueue_active(&ctx->wqh))
-		wake_up_locked_poll(&ctx->wqh, EPOLLOUT);
+		eventfd_wake_up_locked_poll(&ctx->wqh, EPOLLOUT);
 	spin_unlock_irqrestore(&ctx->wqh.lock, flags);
 
 	return *cnt != 0 ? 0 : -EAGAIN;
@@ -235,7 +254,7 @@ static ssize_t eventfd_read(struct kiocb *iocb, struct iov_iter *to)
 	eventfd_ctx_do_read(ctx, &ucnt);
 	current->in_eventfd = 1;
 	if (waitqueue_active(&ctx->wqh))
-		wake_up_locked_poll(&ctx->wqh, EPOLLOUT);
+		eventfd_wake_up_locked_poll(&ctx->wqh, EPOLLOUT);
 	current->in_eventfd = 0;
 	spin_unlock_irq(&ctx->wqh.lock);
 	if (unlikely(copy_to_iter(&ucnt, sizeof(ucnt), to) != sizeof(ucnt)))
@@ -271,7 +290,7 @@ static ssize_t eventfd_write(struct file *file, const char __user *buf, size_t c
 		ctx->count += ucnt;
 		current->in_eventfd = 1;
 		if (waitqueue_active(&ctx->wqh))
-			wake_up_locked_poll(&ctx->wqh, EPOLLIN);
+			eventfd_wake_up_locked_poll(&ctx->wqh, EPOLLIN);
 		current->in_eventfd = 0;
 	}
 	spin_unlock_irq(&ctx->wqh.lock);
@@ -308,6 +327,9 @@ static const struct file_operations eventfd_fops = {
 	.read_iter	= eventfd_read,
 	.write		= eventfd_write,
 	.llseek		= noop_llseek,
+#ifdef CONFIG_EPOLL_LOCKLESS
+	.fop_flags	= FOP_EPOLL_LOCKLESS,
+#endif
 };
 
 /**
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index eed8cecd94e3..99558ed5c9a1 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -285,6 +285,14 @@ struct epitem {
 
 	/* The structure that describe the interested events and the source fd */
 	struct epoll_event event;
+
+#ifdef CONFIG_EPOLL_LOCKLESS
+	/* Set after queueing, cleared before dequeueing from the ready path. */
+	bool notified;
+
+	/* True if the file opts into the lockless wakeup fast path. */
+	bool lockless_wake;
+#endif
 };
 
 /*
@@ -620,6 +628,82 @@ static inline bool ep_events_available(struct eventpoll *ep)
 		read_seqcount_retry(&ep->seq, seq);
 }
 
+#ifdef CONFIG_EPOLL_LOCKLESS
+/*
+ * Eventpoll lockless callback fast-path: two-variable communication.
+ * Files opt in by setting FOP_EPOLL_LOCKLESS, declaring that their
+ * wakeup orders W(B) before the callback's R(A) with a full barrier and
+ * that their ->poll() is a pure level read.
+ *
+ *   A = epi->notified
+ *   B = file readiness (e.g. eventfd count)
+ *
+ *   scanner context: W(A = false) -> smp_mb() -> dequeue -> R(B)
+ *   writer  context: W(B)         -> smp_mb() -> R(A)
+ *
+ * Therefore R(B) == old and R(A) == true cannot both occur.
+ */
+static inline void ep_set_notified(struct epitem *epi)
+{
+	if (epi->lockless_wake)
+		WRITE_ONCE(epi->notified, true);
+}
+
+static inline void ep_prepare_repoll(struct epitem *epi)
+{
+	if (!epi->lockless_wake)
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
+static inline bool ep_callback_can_skip(struct epitem *epi, __poll_t pollflags)
+{
+	__poll_t events;
+
+	if (!epi->lockless_wake)
+		return false;
+
+	/* 
+	 * poll_wait waiters woken by this callback, so they must take slow path.
+	 */
+	if (waitqueue_active(&epi->ep->poll_wait))
+		return false;
+
+	events = READ_ONCE(epi->event.events);
+	if (events & (EPOLLEXCLUSIVE | EPOLLET | EPOLLONESHOT))
+		return false;
+
+	if (pollflags & POLLFREE)
+		return false;
+
+	if (pollflags && !(pollflags & events))
+		return false;
+
+	/*
+	 * Writer context: W(B) -> smp_mb() -> R(A).
+	 *
+	 * Once notified, the scanner's ep_done_scan() wakes ep->wq, so epoll_wait()
+	 * callers are covered and we can skip ep->lock.
+	 */
+	return READ_ONCE(epi->notified);
+}
+#else
+static inline void ep_set_notified(struct epitem *epi) { }
+static inline void ep_prepare_repoll(struct epitem *epi) { }
+static inline bool ep_callback_can_skip(struct epitem *epi, __poll_t pollflags)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_NET_RX_BUSY_POLL
 /**
  * busy_loop_ep_timeout - check if busy poll has timed out. The timeout value
@@ -1007,6 +1091,7 @@ static void ep_done_scan(struct eventpoll *ep,
 			 * reverses the iteration order into FIFO.
 			 */
 			list_add(&epi->rdllink, &ep->rdllist);
+			ep_set_notified(epi);
 			ep_pm_stay_awake(epi);
 		}
 	}
@@ -1303,8 +1388,11 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
 	mutex_lock_nested(&ep->mtx, depth);
 	ep_start_scan(ep, &scan_batch);
 	list_for_each_entry_safe(epi, tmp, &scan_batch, rdllink) {
+		/* Clear notified before a possible removal from txlist. */
+		ep_prepare_repoll(epi);
 		if (ep_item_poll(epi, &pt, depth + 1)) {
 			res = EPOLLIN | EPOLLRDNORM;
+			ep_set_notified(epi);
 			break;
 		} else {
 			/*
@@ -1497,6 +1585,9 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	unsigned long flags;
 	int ewake = 0;
 
+	if (ep_callback_can_skip(epi, pollflags))
+		return 1;
+
 	spin_lock_irqsave(&ep->lock, flags);
 
 	ep_set_busy_poll_napi_id(epi);
@@ -1529,11 +1620,13 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
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
 
@@ -1840,6 +1933,10 @@ static struct epitem *ep_alloc_epitem(struct eventpoll *ep,
 	epi->ffd = *tf;
 	epi->event = *event;
 	epi_clear_ovflist(epi);
+#ifdef CONFIG_EPOLL_LOCKLESS
+	epi->lockless_wake =
+		(tf->file->f_op->fop_flags & FOP_EPOLL_LOCKLESS) != 0;
+#endif
 
 	return epi;
 }
@@ -1956,6 +2053,7 @@ static int ep_insert(struct ep_ctl_ctx *ctx, struct eventpoll *ep,
 
 	if (revents && !ep_is_linked(epi)) {
 		list_add_tail(&epi->rdllink, &ep->rdllist);
+		ep_set_notified(epi);
 		ep_pm_stay_awake(epi);
 
 		if (waitqueue_active(&ep->wq))
@@ -1992,7 +2090,7 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 	 * otherwise we might miss an event that happens between the
 	 * f_op->poll() call and the new event set registering.
 	 */
-	epi->event.events = event->events; /* need barrier below */
+	WRITE_ONCE(epi->event.events, event->events); /* need barrier below */
 	epi->event.data = event->data; /* protected by mtx */
 	if (epi->event.events & EPOLLWAKEUP) {
 		if (!ep_has_wakeup_source(epi))
@@ -2031,6 +2129,7 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 		spin_lock_irq(&ep->lock);
 		if (!ep_is_linked(epi)) {
 			list_add_tail(&epi->rdllink, &ep->rdllist);
+			ep_set_notified(epi);
 			ep_pm_stay_awake(epi);
 
 			/* Notify waiting tasks that events are available */
@@ -2084,6 +2183,12 @@ static int ep_deliver_event(struct eventpoll *ep, struct epitem *epi,
 		__pm_relax(ws);
 	}
 
+	/*
+	 * Clear notified while epi is still on txlist. A callback that
+	 * races with the following dequeue must take the slow path and
+	 * publish the event through ovflist.
+	 */
+	ep_prepare_repoll(epi);
 	list_del_init(&epi->rdllink);
 
 	/*
@@ -2104,13 +2209,15 @@ static int ep_deliver_event(struct eventpoll *ep, struct epitem *epi,
 		 * attempt.
 		 */
 		list_add(&epi->rdllink, scan_batch);
+		ep_set_notified(epi);
 		ep_pm_stay_awake(epi);
 		return -EFAULT;
 	}
 	*uevents = next;
 
 	if (epi->event.events & EPOLLONESHOT) {
-		epi->event.events &= EP_PRIVATE_BITS;
+		WRITE_ONCE(epi->event.events,
+				READ_ONCE(epi->event.events) & EP_PRIVATE_BITS);
 	} else if (!(epi->event.events & EPOLLET)) {
 		/*
 		 * Level-triggered: re-queue so the next epoll_wait()
@@ -2120,6 +2227,7 @@ static int ep_deliver_event(struct eventpoll *ep, struct epitem *epi,
 		 * during scans.
 		 */
 		list_add_tail(&epi->rdllink, &ep->rdllist);
+		ep_set_notified(epi);
 		ep_pm_stay_awake(epi);
 	}
 	return 1;
@@ -2138,8 +2246,16 @@ static int ep_send_events(struct eventpoll *ep,
 	 * timely exit without the chance of finding more events available and
 	 * fetching repeatedly.
 	 */
-	if (fatal_signal_pending(current))
+	if (fatal_signal_pending(current)) {
+#ifdef CONFIG_EPOLL_LOCKLESS
+		spin_lock_irq(&ep->lock);
+		list_for_each_entry(epi, &ep->rdllist, rdllink)
+			if (epi->lockless_wake)
+				WRITE_ONCE(epi->notified, false);
+		spin_unlock_irq(&ep->lock);
+#endif
 		return -EINTR;
+	}
 
 	init_poll_funcptr(&pt, NULL);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 50ce731a2b78..6f5c30bd21dd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1980,6 +1980,10 @@ struct file_operations {
 #define FOP_ASYNC_LOCK		((__force fop_flags_t)(1 << 6))
 /* File system supports uncached read/write buffered IO */
 #define FOP_DONTCACHE		((__force fop_flags_t)(1 << 7))
+#ifdef CONFIG_EPOLL_LOCKLESS
+/* File opts into epoll's lockless callback fast path */
+#define FOP_EPOLL_LOCKLESS	((__force fop_flags_t)(1 << 8))
+#endif
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
diff --git a/init/Kconfig b/init/Kconfig
index 10f2013b5321..d758adc590e9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1896,6 +1896,17 @@ config EVENTFD
 
 	  If unsure, say Y.
 
+config EPOLL_LOCKLESS
+	bool "Optimize epoll wakeup fast-path" if EXPERT
+	depends on EVENTFD && EPOLL
+	default n
+	help
+	  Enables a lockless fast-path in ep_poll_callback for files that
+	  declare FOP_EPOLL_LOCKLESS (currently only eventfd), reducing
+	  ep->lock contention under concurrent workloads.
+
+	  If unsure, say N.
+
 config SHMEM
 	bool "Use full shmem filesystem" if EXPERT
 	default y
-- 
2.43.0

