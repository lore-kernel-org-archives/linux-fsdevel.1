Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF94F30ACF1
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038435; cv=none; b=l21y/tWosaxVzaAIlp4gNAMF+AyD99FJw0boPbUzs7bpQqvdSJgtVH/SLzobyRwqrM93YIFPzwSwH+/b9PoJfLO+DsPnJHY9cCsOSBSZE1zoJTTHnqFqs7GWKKiP1Cn95PFGA5z5GR4xY1WVfH/r9GxaA6KmftYoTQPrU3IRnv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038435; c=relaxed/simple;
	bh=QvnPh5L68AzzIytjFtvLu70zrXmvoWRCrpDoSsWj3ns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qbN3rFn0o6Wi4G9l46XLcLPdUL4YQqj5WudihD6eGIts3SxmJ0M8xL3BpTf27oCl7fuN+LH6ZGjUd3/SgNK2cM+Xl5rSwy0Lhn5xPFsJsz3lyf2X+IOedC89Z3qsfjORheEwdSNOYWLDFAsM9jAicyA607/MWmQRw4dKrGItyNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFGTs64P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFGTs64P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01990C19425;
	Fri, 24 Apr 2026 13:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038435;
	bh=QvnPh5L68AzzIytjFtvLu70zrXmvoWRCrpDoSsWj3ns=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DFGTs64PmkdRVxYwAFjRGaev7BDCMxO4XxB+E+poqgHPRaECmsubrqBjXvFRjNY9p
	 AqjFjS3ITmKec59hHhpVrJI2sc9rgPfIvAseS5wy0ED0dJ+usUSuULX2TwVaOYFAGS
	 HnowVfmU8JqpS5ck7lg77NnTGAMFUsgSyYzxCbZmpurxoZTne32IeVo953s11LwYjc
	 Gw2hkqHPOnhr2JxHLME31eDUzXZWewyA9qLXsLDiP3WkH/wj9VXayglVpO5Petluxl
	 clZGR1s95WnTGHuu0aZ1ZWiuz0bis3xn8KqFEFYHFr4FAgDbKPT2Hf2DaloYOfM2ky
	 vZLcFGCl82thA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Apr 2026 15:46:45 +0200
Subject: [PATCH 14/17] eventpoll: wrap EP_UNACTIVE_PTR in typed sentinel
 helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-work-epoll-rework-v1-14-249ed00a20f3@kernel.org>
References: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
In-Reply-To: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6649; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QvnPh5L68AzzIytjFtvLu70zrXmvoWRCrpDoSsWj3ns=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+LnH/vfO/9KmHreFvZTy5ZJdtPjrzWmlIzQ2FgteXb
 rNlmM750FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRug+MDHf1UjgnPmks8V+1
 8ljZIcuq6duenVz9YdGTAo6TwR2vWzkYGS5/mbKu8XmEyg3daXfnvaqc4n3zgZhiG8PilpUbWi7
 t6mEEAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

ep->ovflist and epi->next both use EP_UNACTIVE_PTR (a cast to
(void *)-1) as a sentinel, with distinct meanings at each site:

  ep->ovflist == EP_UNACTIVE_PTR         no scan in progress
  epi->next   == EP_UNACTIVE_PTR         epi not on ovflist

Call sites had to know the sentinel's value and, by convention, what
it meant in each context. Hide both behind inline helpers:

  ep_is_scanning(ep)       predicate for "scan in progress"
  ep_enter_scan(ep)        WRITE_ONCE flip to NULL (scan start)
  ep_exit_scan(ep)         WRITE_ONCE flip to sentinel (scan end)
  epi_on_ovflist(epi)      predicate for "epi is on ovflist"
  epi_clear_ovflist(epi)   clear epi's ovflist link slot

Convert ep_events_available(), ep_start_scan(), ep_done_scan(),
ep_poll_callback(), and ep_alloc_epitem() to use the wrappers. The
ovflist state-machine transitions are now named, not encoded in
sentinel comparisons, and the top-of-file "Ready-list state machine"
section is the single place that spells out the sentinel's meaning.

ep_alloc() keeps the raw "ep->ovflist = EP_UNACTIVE_PTR" init (no
concurrent access at that point) with an inline "not scanning"
comment, and the tfile_check_list sentinel is left alone -- it will
disappear entirely when the loop-check globals move into a
stack-allocated ep_ctl_ctx in a later commit.

Also rework ep_done_scan()'s for-loop: the combined initializer +
update clause that advanced nepi AND cleared epi->next in one step
was clever but hard to read; splitting the update into two
statements inside the body makes the epi_clear_ovflist() call
visible.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/eventpoll.c | 73 +++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 21 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index d49457dc8c7f..4199ef8e42e5 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -541,6 +541,43 @@ static inline struct epitem *ep_item_from_wait(wait_queue_entry_t *p)
 	return container_of(p, struct eppoll_entry, wait)->base;
 }
 
+/*
+ * Ready-list / ovflist state (see "Ready-list state machine" in the
+ * top-of-file banner for the full state machine). EP_UNACTIVE_PTR is
+ * the sentinel; these wrappers name each transition and each test so
+ * call sites do not need to know the sentinel's value.
+ */
+
+/* True iff @ep is between ep_enter_scan() and ep_exit_scan(). */
+static inline bool ep_is_scanning(struct eventpoll *ep)
+{
+	return READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR;
+}
+
+/* Called by ep_start_scan(): divert ep_poll_callback() to ovflist. */
+static inline void ep_enter_scan(struct eventpoll *ep)
+{
+	WRITE_ONCE(ep->ovflist, NULL);
+}
+
+/* Called by ep_done_scan(): redirect ep_poll_callback() back to rdllist. */
+static inline void ep_exit_scan(struct eventpoll *ep)
+{
+	WRITE_ONCE(ep->ovflist, EP_UNACTIVE_PTR);
+}
+
+/* True iff @epi is currently linked on its ep's ovflist. */
+static inline bool epi_on_ovflist(const struct epitem *epi)
+{
+	return epi->next != EP_UNACTIVE_PTR;
+}
+
+/* Mark @epi as not on any ovflist (init and post-drain). */
+static inline void epi_clear_ovflist(struct epitem *epi)
+{
+	epi->next = EP_UNACTIVE_PTR;
+}
+
 /**
  * ep_events_available - Checks if ready events might be available.
  *
@@ -551,8 +588,7 @@ static inline struct epitem *ep_item_from_wait(wait_queue_entry_t *p)
  */
 static inline int ep_events_available(struct eventpoll *ep)
 {
-	return !list_empty_careful(&ep->rdllist) ||
-		READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR;
+	return !list_empty_careful(&ep->rdllist) || ep_is_scanning(ep);
 }
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
@@ -910,7 +946,7 @@ static void ep_start_scan(struct eventpoll *ep, struct list_head *txlist)
 	lockdep_assert_irqs_enabled();
 	spin_lock_irq(&ep->lock);
 	list_splice_init(&ep->rdllist, txlist);
-	WRITE_ONCE(ep->ovflist, NULL);
+	ep_enter_scan(ep);
 	spin_unlock_irq(&ep->lock);
 }
 
@@ -925,29 +961,24 @@ static void ep_done_scan(struct eventpoll *ep,
 	 * other events might have been queued by the poll callback.
 	 * We re-insert them inside the main ready-list here.
 	 */
-	for (nepi = READ_ONCE(ep->ovflist); (epi = nepi) != NULL;
-	     nepi = epi->next, epi->next = EP_UNACTIVE_PTR) {
+	for (nepi = READ_ONCE(ep->ovflist); (epi = nepi) != NULL; ) {
+		nepi = epi->next;
+		epi_clear_ovflist(epi);
 		/*
-		 * We need to check if the item is already in the list.
-		 * During the "sproc" callback execution time, items are
-		 * queued into ->ovflist but the "txlist" might already
-		 * contain them, and the list_splice() below takes care of them.
+		 * Skip items that the caller already returned via @txlist
+		 * -- the list_splice() below takes care of those.
 		 */
 		if (!ep_is_linked(epi)) {
 			/*
-			 * ->ovflist is LIFO, so we have to reverse it in order
-			 * to keep in FIFO.
+			 * ovflist is LIFO; list_add() head-insert here
+			 * reverses the iteration order into FIFO.
 			 */
 			list_add(&epi->rdllink, &ep->rdllist);
 			ep_pm_stay_awake(epi);
 		}
 	}
-	/*
-	 * We need to set back ep->ovflist to EP_UNACTIVE_PTR, so that after
-	 * releasing the lock, events will be queued in the normal way inside
-	 * ep->rdllist.
-	 */
-	WRITE_ONCE(ep->ovflist, EP_UNACTIVE_PTR);
+	/* Back out of scan mode; callbacks target ep->rdllist again. */
+	ep_exit_scan(ep);
 
 	/*
 	 * Quickly re-inject items left on "txlist".
@@ -1376,7 +1407,7 @@ static int ep_alloc(struct eventpoll **pep)
 	init_waitqueue_head(&ep->poll_wait);
 	INIT_LIST_HEAD(&ep->rdllist);
 	ep->rbr = RB_ROOT_CACHED;
-	ep->ovflist = EP_UNACTIVE_PTR;
+	ep->ovflist = EP_UNACTIVE_PTR;	/* not scanning */
 	ep->user = get_current_user();
 	refcount_set(&ep->refcount, 1);
 
@@ -1456,8 +1487,8 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	 * semantics). All the events that happen during that period of time are
 	 * chained in ep->ovflist and requeued later on.
 	 */
-	if (READ_ONCE(ep->ovflist) != EP_UNACTIVE_PTR) {
-		if (epi->next == EP_UNACTIVE_PTR) {
+	if (ep_is_scanning(ep)) {
+		if (!epi_on_ovflist(epi)) {
 			epi->next = READ_ONCE(ep->ovflist);
 			WRITE_ONCE(ep->ovflist, epi);
 			ep_pm_stay_awake_rcu(epi);
@@ -1771,7 +1802,7 @@ static struct epitem *ep_alloc_epitem(struct eventpoll *ep,
 	epi->ep = ep;
 	ep_set_ffd(&epi->ffd, tfile, fd);
 	epi->event = *event;
-	epi->next = EP_UNACTIVE_PTR;
+	epi_clear_ovflist(epi);
 
 	return epi;
 }

-- 
2.47.3

