Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C82B3546C3
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 02:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787538234; cv=none; b=jGv3MdBTj7MVaeb9jSNmPRnJfAnyTdBxL11WPKfUR4ARW4VicwpmPxX7152xz3Sxupk/D2zvDKXACJYR+NY9zwC13joOIIuJrHgr2CONfOfgqCSrI1m3N1Q71DHRbdDXyVz+n6IiSKDYaizaustLo1PlJ03C299wEAn8rznTikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787538234; c=relaxed/simple;
	bh=MzLaTMOX2W/9XxA9mrd3BM6sRvMVb+cw21E/L2mWEyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEz4g/+d9TCaPSzFNjLqkMuTszISQGgIUdt83zW1PkLPOdKY6gPd5BT+CjsHUHULJhmILDLqGJbUT/Jom42k8/VooemIfJQSrW7CB7+ODk889iOnrk5ecgvk/0+pcj9Dy7I+R9AAsIqqWAO2b5B88RzB+WnsXjofzHwijFQYV8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ez20qbwD; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ez20qbwD"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc2c6e0688so16770785ad.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 19:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787538232; x=1788143032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GD+gkPvevKE2jGn3hOb2d6t8C53QDyGi/jWaOzEiJoo=;
        b=ez20qbwD1B2zvzqFLR3SfIDEXXyFxBNNDymyh8d+86qN6PJFGVsP/RPpyNjHdb0jkl
         QQls7k4kTfOFZOQZVsSk2+YLWs6V+f+y3FH+HytfTtiYxNnmMQGzI6Xks97IIP4MWQRV
         pfeVkurs9U3L7KK0/y1otNQBmcx0npW1XTNieaVLrycapHiok0Qfi0eXovjnoZEjOFHi
         j2zQJFTwLB1yfDgDUCAY74aLLAuOos1XvRrxz+6hWI2DNsBbe4VbO1oQVA8NqmLsErr/
         MnQYFoLvRs5Jz3sazRfOv5O2d4PbDz5SSDw5OaaBy3chOTorKfEHkk3pAOpsrp5SQyx5
         YbSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787538232; x=1788143032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GD+gkPvevKE2jGn3hOb2d6t8C53QDyGi/jWaOzEiJoo=;
        b=J9Uz5v+HI4ccGC8jatYtb9hSyQHfOspXtPjIIEbtW9w6Cy/HViGJlwFeIAeKRiYhTx
         EpHnhIaKP0fb5Izm3YnATp6UU93LDF1zer5AeVuaCaeRyEpgXgo3AtGCgihIS+TCM7ca
         p3TwCHiMIgCeXBzypqx2vPcVsf993xgd5rCZDXqQS7eJQCRQ8zD5Kfhjn7Nt4LfoT7PP
         xgqQ0GB7jOQABt6JtLEDpdtkdHiMyl/qCkko3G3qLnV1oXP9t39gEzxM8iT3UVESazWX
         F4k0zQ7acRHv5KCUHTvCPJgBBhHDwbMTwn114LtgBwsLvnSiIWQQrV+YAxvNvZ0WxPAr
         2Crw==
X-Forwarded-Encrypted: i=1; AHgh+RrqyAbad9vBuqHQXfB8jbsbq5mA8Ppgfa/vLQX+lBFi7LZfSX2JZv4AEfC3nQJQma9OfNDe8m7Bs/BwXvem@vger.kernel.org
X-Gm-Message-State: AFuF++lUvUgCeTNHiygmzrRxxipdAYm2CsvkIGPGTrFCsQ7koWNvM4wi
	FZzaLeOuK8GO3LxVhLVQGOuQAhwysS72GBRH1/5LxbPL0MJGLkUZl8vV
X-Gm-Gg: AR+sD131Xoi0hNa3Gk0k0cwiWKBVa9X4S3k+SATkMyOhOErSauSqYCzgNg/x6f0vz+a
	Uk0c74k5Majcvr1WsxspSINVq6S3AMuSe6Mh1/SiBkarralSfFx7MNIPhEZyN3mYC612A8JOd3Y
	F1ZrsbQOrh1Mqk8maMCiso/UqTD64mKQTGDQGEUfdScUutSFwSIMxsa4q1hB7IHnYOU9wpjNuhp
	u9oVJpk19A5Gv2kvEVb2xvbrQXuJbIeiUmahjZ+jLYf5mqJl7agbaaPalxPsgRw3AIeqT9xb1Zo
	j6yTmxEuXrmHV6iWUxdlA7xwDuYeUtcPaqTaMXroGsVyYGpqkIKtAxDhhVlMEIMBo4cg/e2pQ/H
	F4IpDhDI6f1zlt99bMjeO0GdjcOqFLVhtfX3vJ+fQTVzO8t64LHW79d9WC3mXvZDSNF6x5FuZwP
	hwetE14uVE/nbUzA/frnP0wjgYwy0S0h7Uy2LHTb7IgE8pkyXrr25eAbjWRoyjeoxHrQhTtPi9N
	8pCWfMgXwO83bbMDE1Ncps=
X-Received: by 2002:a17:903:287:b0:2d6:3c22:99bf with SMTP id d9443c01a7336-2d64afe9df4mr116378095ad.9.1787538231656;
        Sun, 23 Aug 2026 19:23:51 -0700 (PDT)
Received: from localhost.localdomain ([124.70.231.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6767a614asm12176815ad.31.2026.08.23.19.23.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Aug 2026 19:23:51 -0700 (PDT)
From: Siyuan Huang <syhuang.nju@gmail.com>
To: brauner@kernel.org
Cc: aliceryhl@google.com,
	dianders@chromium.org,
	gary@garyguo.net,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux.amoon@gmail.com,
	nathan@kernel.org,
	nsc@kernel.org,
	ojeda@kernel.org,
	syhuang.nju@gmail.com,
	tglx@kernel.org,
	thomas.weissschuh@linutronix.de,
	viro@zeniv.linux.org.uk
Subject: [RFC PATCH v3] eventpoll: add lockless fast-path for eventpoll
Date: Mon, 24 Aug 2026 10:23:27 +0800
Message-ID: <20260824022327.9867-1-syhuang.nju@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260812-zitat-neueinstellung-ruckartig-727e55f45cc1@brauner>
References: <20260812-zitat-neueinstellung-ruckartig-727e55f45cc1@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I think this is misguided. Not just the special-casing of eventfd but
> also letting file operations opt-in how locking is done in another
> subystem. That's almost guaranteed to wreak havoc... and sashiko is
> already proving this.

Thanks for the feedback. I agree that the fast-path logic should not be
connected to other subsystems. I have reworked the proposal so that the
optimization is entirely local to eventpoll. I removed the special-casing
of eventfd and the opt-in bit in FOP.

The new version tracks two bits in each epitem:

  - FAST marks an item that is eligible for the lockless callback path.
    Nested epoll and interests using EPOLLEXCLUSIVE, EPOLLET,
    EPOLLONESHOT, or EPOLLWAKEUP do not use the fast path.

  - ACCOUNTED means that the ready-processing path already owns the item:
    it is on rdllist, in the current scan batch, or queued on ovflist,
	the same as the 'notified' before.

As for the question sashiko raised about the fatal branch, I do not modify
the flag in the branch any more. Instead, I deliver the wakeup directly to
avoid list traversal race.

---
 fs/eventpoll.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index e0c4bf88a838..600d3d2d4763 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -243,6 +243,14 @@ struct eppoll_entry {
 	wait_queue_head_t *whead;
 };
 
+/*
+ * FAST is set for eligible items at insertion. ACCOUNTED tracks FAST items
+ * while the ready path owns them and is cleared immediately before re-poll.
+ */
+enum {
+	EP_STATE_ACCOUNTED	= BIT(0),
+	EP_STATE_FAST		= BIT(1),
+};
 /*
  * Each file descriptor added to the eventpoll interface will
  * have an entry of this type linked to the "rbr" RB tree.
@@ -271,6 +279,9 @@ struct epitem {
 	/* The file descriptor information this item refers to */
 	struct epoll_key ffd;
 
+	/* Atomic state bits, see the EP_STATE_* enum above. */
+	atomic_t state;
+
 	/* List containing poll wait queues */
 	struct eppoll_entry *pwqlist;
 
@@ -620,6 +631,65 @@ static inline bool ep_events_available(struct eventpoll *ep)
 		read_seqcount_retry(&ep->seq, seq);
 }
 
+/*
+ * Let A be ACCOUNTED and B be file readiness. Fully ordered atomic RMWs
+ * pair W(A=0) before R(B) with W(B) before R(A), so a scanner cannot miss
+ * B while its callback skips an accounted item. ep_done_scan() and the
+ * fatal-signal handoff pass queued events between exclusive waiters.
+ * poll_wait users, private modes and special callbacks take the slow path.
+ */
+static inline bool ep_state_test(const struct epitem *epi, unsigned int bit)
+{
+	return atomic_read(&epi->state) & bit;
+}
+
+static inline bool ep_ready_fast_enabled(const struct epitem *epi)
+{
+	return ep_state_test(epi, EP_STATE_FAST);
+}
+
+static inline void ep_set_ready_accounted(struct epitem *epi)
+{
+	if (ep_ready_fast_enabled(epi))
+		atomic_or(EP_STATE_ACCOUNTED, &epi->state);
+}
+
+static inline void ep_prepare_repoll(struct epitem *epi)
+{
+	if (ep_ready_fast_enabled(epi))
+		atomic_fetch_andnot(EP_STATE_ACCOUNTED, &epi->state);
+}
+
+static bool ep_callback_can_skip(struct epitem *epi, __poll_t pollflags)
+{
+	__poll_t events;
+
+	events = READ_ONCE(epi->event.events);
+	
+	/* Only insertion-time candidates may use the lockless path. */
+	if (!ep_ready_fast_enabled(epi))
+		return false;
+	
+	/* ep_modify() can select a private mode that requires the slow path. */
+	if (events & EP_PRIVATE_BITS)
+		return false;
+
+	/* poll_wait users must be woken by this callback. */
+	if (waitqueue_active(&epi->ep->poll_wait))
+		return false;
+
+	/* POLLFREE tears down wait entries; URING_WAKE must propagate. */
+	if (pollflags & (POLLFREE | EPOLL_URING_WAKE))
+		return false;
+
+	/* Unmatched wake keys retain the slow-path callback semantics. */
+	if (pollflags && !(pollflags & events))
+		return false;
+
+	/* Fully ordered RMW pairs the B update with the scanner's A clear. */
+	return atomic_fetch_or(0, &epi->state) & EP_STATE_ACCOUNTED;
+}
+
 #ifdef CONFIG_NET_RX_BUSY_POLL
 /**
  * busy_loop_ep_timeout - check if busy poll has timed out. The timeout value
@@ -1007,6 +1077,7 @@ static void ep_done_scan(struct eventpoll *ep,
 			 * reverses the iteration order into FIFO.
 			 */
 			list_add(&epi->rdllink, &ep->rdllist);
+			ep_set_ready_accounted(epi);
 			ep_pm_stay_awake(epi);
 		}
 	}
@@ -1303,8 +1374,10 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
 	mutex_lock_nested(&ep->mtx, depth);
 	ep_start_scan(ep, &scan_batch);
 	list_for_each_entry_safe(epi, tmp, &scan_batch, rdllink) {
+		ep_prepare_repoll(epi);
 		if (ep_item_poll(epi, &pt, depth + 1)) {
 			res = EPOLLIN | EPOLLRDNORM;
+			ep_set_ready_accounted(epi);
 			break;
 		} else {
 			/*
@@ -1497,6 +1570,9 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	unsigned long flags;
 	int ewake = 0;
 
+	if (ep_callback_can_skip(epi, pollflags))
+		return 1;
+
 	spin_lock_irqsave(&ep->lock, flags);
 
 	ep_set_busy_poll_napi_id(epi);
@@ -1529,11 +1605,13 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 		if (!epi_on_ovflist(epi)) {
 			epi->ovflist_next = READ_ONCE(ep->ovflist);
 			WRITE_ONCE(ep->ovflist, epi);
+			ep_set_ready_accounted(epi);
 			ep_pm_stay_awake_rcu(epi);
 		}
 	} else if (!ep_is_linked(epi)) {
 		/* In the usual case, add event to ready list. */
 		list_add_tail(&epi->rdllink, &ep->rdllist);
+		ep_set_ready_accounted(epi);
 		ep_pm_stay_awake_rcu(epi);
 	}
 
@@ -1912,6 +1990,13 @@ static int ep_insert(struct ep_ctl_ctx *ctx, struct eventpoll *ep,
 	if (IS_ERR(epi))
 		return PTR_ERR(epi);
 
+	/*
+	 * Lockless candidates are plain level-triggered interests;
+	 * private modes and nested epoll change the callback contract.
+	 */
+	if (!tep && !(event->events & EP_PRIVATE_BITS))
+		atomic_set(&epi->state, EP_STATE_FAST);
+
 	error = ep_register_epitem(ctx, ep, epi, tep, full_check);
 	if (error)
 		return error;
@@ -1956,6 +2041,7 @@ static int ep_insert(struct ep_ctl_ctx *ctx, struct eventpoll *ep,
 
 	if (revents && !ep_is_linked(epi)) {
 		list_add_tail(&epi->rdllink, &ep->rdllist);
+		ep_set_ready_accounted(epi);
 		ep_pm_stay_awake(epi);
 
 		if (waitqueue_active(&ep->wq))
@@ -1992,7 +2078,7 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 	 * otherwise we might miss an event that happens between the
 	 * f_op->poll() call and the new event set registering.
 	 */
-	epi->event.events = event->events; /* need barrier below */
+	WRITE_ONCE(epi->event.events, event->events); /* need barrier below */
 	epi->event.data = event->data; /* protected by mtx */
 	if (epi->event.events & EPOLLWAKEUP) {
 		if (!ep_has_wakeup_source(epi))
@@ -2031,6 +2117,7 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 		spin_lock_irq(&ep->lock);
 		if (!ep_is_linked(epi)) {
 			list_add_tail(&epi->rdllink, &ep->rdllist);
+			ep_set_ready_accounted(epi);
 			ep_pm_stay_awake(epi);
 
 			/* Notify waiting tasks that events are available */
@@ -2084,6 +2171,7 @@ static int ep_deliver_event(struct eventpoll *ep, struct epitem *epi,
 		__pm_relax(ws);
 	}
 
+	ep_prepare_repoll(epi);
 	list_del_init(&epi->rdllink);
 
 	/*
@@ -2104,13 +2192,15 @@ static int ep_deliver_event(struct eventpoll *ep, struct epitem *epi,
 		 * attempt.
 		 */
 		list_add(&epi->rdllink, scan_batch);
+		ep_set_ready_accounted(epi);
 		ep_pm_stay_awake(epi);
 		return -EFAULT;
 	}
 	*uevents = next;
 
 	if (epi->event.events & EPOLLONESHOT) {
-		epi->event.events &= EP_PRIVATE_BITS;
+		WRITE_ONCE(epi->event.events,
+			   READ_ONCE(epi->event.events) & EP_PRIVATE_BITS);
 	} else if (!(epi->event.events & EPOLLET)) {
 		/*
 		 * Level-triggered: re-queue so the next epoll_wait()
@@ -2120,6 +2210,7 @@ static int ep_deliver_event(struct eventpoll *ep, struct epitem *epi,
 		 * during scans.
 		 */
 		list_add_tail(&epi->rdllink, &ep->rdllist);
+		ep_set_ready_accounted(epi);
 		ep_pm_stay_awake(epi);
 	}
 	return 1;
@@ -2287,6 +2378,11 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
 	while (1) {
 		if (eavail) {
 			res = ep_try_send_events(ep, events, maxevents);
+			if (res == -EINTR) {
+				spin_lock_irq(&ep->lock);
+				wake_up(&ep->wq);
+				spin_unlock_irq(&ep->lock);
+			}
 			if (res)
 				return res;
 		}
-- 
2.43.0

