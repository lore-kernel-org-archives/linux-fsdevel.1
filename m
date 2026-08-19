Received: from mail-pz2-f9.google.com (mail-pz2-f9.google.com [74.125.228.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8090A431A55
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787130918; cv=none; b=JXP1+zX0RYkj2sm245B6Kwm8sNC/LbJrcI5KNZ+287ZNEMHbMZtgBVlBTSb1erktbRAEHUeKkNLcMklPNccCxQj+qW93FMC7281OaTM9/ahmXFaudswXmZVvHuS7dxESrA7G7vzpsNzQ5Po/w/1lmRenik7alQRX9pxUtQzBqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787130918; c=relaxed/simple;
	bh=gnF986okVh0Ca6Epmk06H19lpWBkHyfiiPqLqeiSQbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfaKv3Av3gm+7AzRGLybgjicVNXr7F/YreEehw88Jdhx73WLlKcPvjiaynd8IcrIipqhATBaCWrkO6eC28E6TS06mOhhdBelKJVNX2Tle+LMas1i6KQ4OUfN7Pah1ZQB3+VHBcOc2JYllGXjSAzlKoNWdxiSFP7XUeTdq0xduWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUN9ZMay; arc=none smtp.client-ip=74.125.228.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUN9ZMay"
Received: by mail-pz2-f9.google.com with SMTP id 41be03b00d2f7-cbec619cd2cso181773a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 02:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787130911; x=1787735711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JPqYiA3RKzrqvqwgzAS3BUvxOhZnKEBVLQLALJPs0HI=;
        b=ZUN9ZMayUyVOQvgZBgnsAYuLSKv6hPOcoUNC6m1uEm4d7sTG85DUdXZOpk2bcFVz1g
         F4S8/U6ghm+Zx4uvhClxL1ggbSn8Shm1LzjmM41tVxdqtGLHmTDtkFTraYgC/eUcmGkb
         iiddZJd4sFP4DBytZDy8qm1V4iI+EC5k3IP4+8T7cj1Mb81g/uoX5iGkl1GeUM2NBNjs
         y+0bSzGVQkSDf98cRv7blg+qykvrKxIzifeC6zzDVEg6oEXPa7jPU9p3RjHVK2qCffQx
         NX8SE3Mob1NvvYg67a3L4Hl5GZd9cQUAYitLBIl2rCoUZ9XcIMvBVoogCVxPTwBNsM2Y
         wRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787130911; x=1787735711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JPqYiA3RKzrqvqwgzAS3BUvxOhZnKEBVLQLALJPs0HI=;
        b=SB09Pvgye0nqpnMIeFxbZp2Tz8SjGZ8hg6u//RZRiUKotJq2IlBxy9aJKyVnkmjcg1
         dZLUN/v/nwncQfhJ1joViNHW6JsNRYPzRT11rspvlVn1m5y3W0uY7OzsxIPqeNoFxvSt
         rlUqipyCyUJ+1TztEfbMen3teFrmXUwuaCTjTfWXGf9TvWn+R5BYzSIZnX+qnBwRnEXe
         C9Ia84SdYZz26sqdfQlAshWQ2/e0kmrAliq/2BMHTUVUM+KyHWimKEqB5hlXHBRYZovB
         4er4rxllpFNLcolrHzSgugTXPBp1WKFVOxyXK++zHjk+vPrQnz/4g4Kp/dyNnTO4+fmb
         88uQ==
X-Forwarded-Encrypted: i=1; AHgh+RpKxH7l27B7UDMNqomYSzEM7m1rmpieS/LBy0x+x7L5oAK93xBlNOMmV0JxjG5WaDdENcVv0H2REBsqb7uB@vger.kernel.org
X-Gm-Message-State: AOJu0YwOvmOiplDnRMdviJz1g6EvFhFCvLZKsI7ssuFMp6hjCAvy69mA
	HaJ6NtPZip9MFiXLyBVxYW2iw03juMQF1w4eSXPXn97EcKC0EoMNNkS2
X-Gm-Gg: AR+sD13EnYwMaz0NCfMC89A25bsVGeoPCmBVyVVVYXfQPSNuzkpgiV6N8jzHmwCUEeC
	lxYQ7hDCceeL30ReLc60A4a7czBelIdPUD5jYP5g8WbwFKsWBLT2UH+aLaJjtPH1Ec+L/pCMyl9
	uNvoZr08EX3kA1tPE7v/lOD8V26PDndyH9K+N5j403KTMXFaguaIYrZjOYwCRLqgaBEcAiVaDeo
	9nJOf2ec4ox8R9cFAb0YGE/8Z1kxVMe+STYz1NM+RfmUed7nKudLdtCv08PSazhOSd+UsMUcuE5
	0WLHNfIRxn4CqqDQAO+3zHNSTCsBUtrXX5KEeSDa1McxU+7BDYNYJ4Un4qU+1bjFD1EruUykQ8G
	l/dPQMEVJUeQrJbaCPr9Vv3d0n6MnToihZQDGzuU9Fly8nfNcQt/BkDjcb4KCcPUfnkCiAdzsV1
	n6nlU0TrDm6jifHdpoU+cPMG0d6H17ntPADr4Xi8f5GdyZXNsiL5HPp5LP/IiWTu90yiDqfa2sL
	E90
X-Received: by 2002:a05:6a00:368f:b0:84e:f90e:492f with SMTP id d2e1a72fcca58-851d382f530mr5371908b3a.7.1787130911266;
        Wed, 19 Aug 2026 02:15:11 -0700 (PDT)
Received: from otkcomputer.localdomain ([111.68.15.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d36a2ef0sm393956b3a.61.2026.08.19.02.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 02:15:10 -0700 (PDT)
From: syhuang.nju@gmail.com
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
Subject: [RFC PATCH v2] eventpoll: add lockless fast-path for eventpoll
Date: Wed, 19 Aug 2026 17:15:01 +0800
Message-ID: <20260819091501.3935-1-syhuang.nju@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812-zitat-neueinstellung-ruckartig-727e55f45cc1@brauner>
References: <20260812-zitat-neueinstellung-ruckartig-727e55f45cc1@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siyuan Huang <syhuang.nju@gmail.com>

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
 fs/eventpoll.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index eed8cecd94e3..2c29f5d0039f 100644
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
@@ -1992,7 +2078,8 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 	 * otherwise we might miss an event that happens between the
 	 * f_op->poll() call and the new event set registering.
 	 */
-	epi->event.events = event->events; /* need barrier below */
+	WRITE_ONCE(epi->event.events, event->events); /* need barrier below */
 	epi->event.data = event->data; /* protected by mtx */
 	if (epi->event.events & EPOLLWAKEUP) {
 		if (!ep_has_wakeup_source(epi))
@@ -2031,6 +2118,7 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 		spin_lock_irq(&ep->lock);
 		if (!ep_is_linked(epi)) {
 			list_add_tail(&epi->rdllink, &ep->rdllist);
+			ep_set_ready_accounted(epi);
 			ep_pm_stay_awake(epi);
 
 			/* Notify waiting tasks that events are available */
@@ -2084,6 +2172,7 @@ static int ep_deliver_event(struct eventpoll *ep, struct epitem *epi,
 		__pm_relax(ws);
 	}
 
+	ep_prepare_repoll(epi);
 	list_del_init(&epi->rdllink);
 
 	/*
@@ -2104,13 +2193,15 @@ static int ep_deliver_event(struct eventpoll *ep, struct epitem *epi,
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
@@ -2120,6 +2211,7 @@ static int ep_deliver_event(struct eventpoll *ep, struct epitem *epi,
 		 * during scans.
 		 */
 		list_add_tail(&epi->rdllink, &ep->rdllist);
+		ep_set_ready_accounted(epi);
 		ep_pm_stay_awake(epi);
 	}
 	return 1;
@@ -2288,6 +2380,11 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
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

