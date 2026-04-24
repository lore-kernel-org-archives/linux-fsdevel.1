Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C3924DCF6
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038437; cv=none; b=GmiDofz7DxWZ3cq2bxA76dxe3j941FZnvjA27tfAzeVmVo7S1QAMWRx7HYQy+yF7PKgWxOEal5TOynVOc4oMKHYSkBOCfKzCVcGzIzmlOkK3xdyvA9BqRgUZckbLjNwSX+UP5LXoBYFDR08F8hLRtr8TyboKq4nHWaxbSyO6IwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038437; c=relaxed/simple;
	bh=7pU0ANqLkyMHqzeVeOPVRvEBwuXIuu/7sglxx+nsQOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ptcF5IbOpd0RcC5SVjLY2kWxZ1hbhuy2x3/5i8N7aqMFLRh2FRDvqzWhAPcquNBvPlTsoC72ocLXSblKWYyXYSXsKTWNaDLBmqNOambPYVBMVnzQLl69EDE1XbvlFnW3WDx2XW1u/53290GFlUhtot1WeO3H4vBX6mFwycsgDX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8KCzV5o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8KCzV5o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92B4C2BCB5;
	Fri, 24 Apr 2026 13:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038437;
	bh=7pU0ANqLkyMHqzeVeOPVRvEBwuXIuu/7sglxx+nsQOY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D8KCzV5oDCIY1HWyaxFf54/q3t/pJF/66UlBtR1xmVYwStma7UH2fIBdbu484Lxg2
	 7iEyrtotSPZRDODjpGbsyZSXRxUNVfeXzYTM38ld1s1KKbdSKIEaFbd5DvT7YVvxLr
	 aaQfUlqT4/ncJgidCTx3r7uhJVhG3n/iL4O2I59mLXtbmx48nm56c5tb4LqmZ2t3tj
	 A8dVcjysYv2xj4Y7RYw5LXfvpCMT+nWJo9P5oSm+kqCa9ChCwIJj2SurjCqiYFF89g
	 tSaP0s+FIhnnSKHbCdpmlzEavnPX7crtDJtiMa3GYGvUYINLLxdPMTSgcIlqcqkkbu
	 3cP9E4gZeagYw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Apr 2026 15:46:46 +0200
Subject: [PATCH 15/17] eventpoll: rename epi->next and txlist for clarity
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-work-epoll-rework-v1-15-249ed00a20f3@kernel.org>
References: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
In-Reply-To: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9374; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7pU0ANqLkyMHqzeVeOPVRvEBwuXIuu/7sglxx+nsQOY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+LnGv2rCXW6v1r0vJI/MAHxNdp4jJjyZ/LbjB+JB9I
 dslqZjCjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkElTIydFw7lxe0caqL0ZaP
 odFlyw58PJrBHjnz3Jp3qb4CO16GTGf4wxuT7P36/+mg8iPfzG4EbN6n4bKSqWbegr552z9v7Ph
 qwwgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Two list-related names were confusing in isolation:

  struct epitem::next
    A singly-linked link slot used only when an epi is queued on
    ep->ovflist during an ep_start_scan/ep_done_scan window. The
    bare name "next" suggests a generic list link and doesn't say
    which list it belongs to.

  txlist
    The caller-local list_head used by ep_send_events() and
    __ep_eventpoll_poll() to hold the batch of items stolen from
    ep->rdllist for the current scan. "txlist" ("transmission
    list") is abbreviated and overloaded: it doesn't distinguish
    itself from ep->rdllist or ep->ovflist at a glance.

Rename for what each actually is:

  struct epitem::next   -> struct epitem::ovflist_next
  local txlist          -> scan_batch

With these in place:
  - epi->ovflist_next reads as "this is the ep->ovflist link slot",
    matching the rdllink pattern above it.
  - scan_batch reads as "the batch currently being scanned", clearly
    distinct from rdllist (canonical ready list) and ovflist
    (scan-window overflow).

ep->rdllist and ep->ovflist struct field names are preserved -- they
are long-standing interface-facing identifiers, and the new inline
helpers (ep_is_scanning, epi_on_ovflist, ...) already hide the
sentinel semantics at call sites.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/eventpoll.c | 62 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 4199ef8e42e5..7ed4b47279ff 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -142,15 +142,15 @@
  *   NULL            - scan active, no spill yet.
  *   pointer to epi  - scan active with spilled items (LIFO).
  *
- * Encoded in epi->next:
+ * Encoded in epi->ovflist_next:
  *   EP_UNACTIVE_PTR - epi is not on ovflist.
  *   otherwise       - next epi on ovflist (NULL at tail).
  *
  * ep_start_scan() flips "not scanning" to "scanning" and splices
- * rdllist into a caller-local txlist. ep_done_scan() drains ovflist
+ * rdllist into a caller-local scan_batch. ep_done_scan() drains ovflist
  * back to rdllist (list_add head-insert reverses LIFO to FIFO),
  * flips back to "not scanning", and re-splices any items the caller
- * left in txlist (e.g., level-triggered re-queues).
+ * left in scan_batch (e.g., level-triggered re-queues).
  *
  *
  * Removal paths
@@ -261,14 +261,16 @@ struct epitem {
 		struct rcu_head rcu;
 	};
 
-	/* List header used to link this structure to the eventpoll ready list */
+	/* Link on the owning eventpoll's ready list (ep->rdllist). */
 	struct list_head rdllink;
 
 	/*
-	 * Works together "struct eventpoll"->ovflist in keeping the
-	 * single linked chain of items.
+	 * Link on the owning eventpoll's scan-overflow list (ep->ovflist),
+	 * EP_UNACTIVE_PTR when not linked. See epi_on_ovflist() /
+	 * epi_clear_ovflist() and the "Ready-list state machine" section
+	 * in the top-of-file banner.
 	 */
-	struct epitem *next;
+	struct epitem *ovflist_next;
 
 	/* The file descriptor information this item refers to */
 	struct epoll_filefd ffd;
@@ -569,13 +571,13 @@ static inline void ep_exit_scan(struct eventpoll *ep)
 /* True iff @epi is currently linked on its ep's ovflist. */
 static inline bool epi_on_ovflist(const struct epitem *epi)
 {
-	return epi->next != EP_UNACTIVE_PTR;
+	return epi->ovflist_next != EP_UNACTIVE_PTR;
 }
 
 /* Mark @epi as not on any ovflist (init and post-drain). */
 static inline void epi_clear_ovflist(struct epitem *epi)
 {
-	epi->next = EP_UNACTIVE_PTR;
+	epi->ovflist_next = EP_UNACTIVE_PTR;
 }
 
 /**
@@ -933,7 +935,7 @@ static inline void ep_pm_stay_awake_rcu(struct epitem *epi)
  * ep->mutex needs to be held because we could be hit by
  * eventpoll_release_file() and epoll_ctl().
  */
-static void ep_start_scan(struct eventpoll *ep, struct list_head *txlist)
+static void ep_start_scan(struct eventpoll *ep, struct list_head *scan_batch)
 {
 	/*
 	 * Steal the ready list, and re-init the original one to the
@@ -945,13 +947,13 @@ static void ep_start_scan(struct eventpoll *ep, struct list_head *txlist)
 	 */
 	lockdep_assert_irqs_enabled();
 	spin_lock_irq(&ep->lock);
-	list_splice_init(&ep->rdllist, txlist);
+	list_splice_init(&ep->rdllist, scan_batch);
 	ep_enter_scan(ep);
 	spin_unlock_irq(&ep->lock);
 }
 
 static void ep_done_scan(struct eventpoll *ep,
-			 struct list_head *txlist)
+			 struct list_head *scan_batch)
 {
 	struct epitem *epi, *nepi;
 
@@ -962,10 +964,10 @@ static void ep_done_scan(struct eventpoll *ep,
 	 * We re-insert them inside the main ready-list here.
 	 */
 	for (nepi = READ_ONCE(ep->ovflist); (epi = nepi) != NULL; ) {
-		nepi = epi->next;
+		nepi = epi->ovflist_next;
 		epi_clear_ovflist(epi);
 		/*
-		 * Skip items that the caller already returned via @txlist
+		 * Skip items that the caller already returned via @scan_batch
 		 * -- the list_splice() below takes care of those.
 		 */
 		if (!ep_is_linked(epi)) {
@@ -981,9 +983,9 @@ static void ep_done_scan(struct eventpoll *ep,
 	ep_exit_scan(ep);
 
 	/*
-	 * Quickly re-inject items left on "txlist".
+	 * Quickly re-inject items left on "scan_batch".
 	 */
-	list_splice(txlist, &ep->rdllist);
+	list_splice(scan_batch, &ep->rdllist);
 	__pm_relax(ep->ws);
 
 	if (!list_empty(&ep->rdllist)) {
@@ -1247,7 +1249,7 @@ static __poll_t ep_item_poll(const struct epitem *epi, poll_table *pt, int depth
 static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int depth)
 {
 	struct eventpoll *ep = file->private_data;
-	LIST_HEAD(txlist);
+	LIST_HEAD(scan_batch);
 	struct epitem *epi, *tmp;
 	poll_table pt;
 	__poll_t res = 0;
@@ -1262,8 +1264,8 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
 	 * the ready list.
 	 */
 	mutex_lock_nested(&ep->mtx, depth);
-	ep_start_scan(ep, &txlist);
-	list_for_each_entry_safe(epi, tmp, &txlist, rdllink) {
+	ep_start_scan(ep, &scan_batch);
+	list_for_each_entry_safe(epi, tmp, &scan_batch, rdllink) {
 		if (ep_item_poll(epi, &pt, depth + 1)) {
 			res = EPOLLIN | EPOLLRDNORM;
 			break;
@@ -1277,7 +1279,7 @@ static __poll_t __ep_eventpoll_poll(struct file *file, poll_table *wait, int dep
 			list_del_init(&epi->rdllink);
 		}
 	}
-	ep_done_scan(ep, &txlist);
+	ep_done_scan(ep, &scan_batch);
 	mutex_unlock(&ep->mtx);
 	return res;
 }
@@ -1489,7 +1491,7 @@ static int ep_poll_callback(wait_queue_entry_t *wait, unsigned mode, int sync, v
 	 */
 	if (ep_is_scanning(ep)) {
 		if (!epi_on_ovflist(epi)) {
-			epi->next = READ_ONCE(ep->ovflist);
+			epi->ovflist_next = READ_ONCE(ep->ovflist);
 			WRITE_ONCE(ep->ovflist, epi);
 			ep_pm_stay_awake_rcu(epi);
 		}
@@ -2017,7 +2019,7 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
  * next slot), 0 if the re-poll reported no caller-requested events
  * (@epi drops out of the ready list; a future callback will re-add
  * it), or -EFAULT if copy_to_user() faulted (in which case @epi is
- * re-inserted at the head of @txlist so ep_done_scan() merges it
+ * re-inserted at the head of @scan_batch so ep_done_scan() merges it
  * back to rdllist for the next attempt).
  *
  * PM bookkeeping and level-triggered re-queue are handled here.
@@ -2026,7 +2028,7 @@ static int ep_modify(struct eventpoll *ep, struct epitem *epi,
 static int ep_deliver_event(struct eventpoll *ep, struct epitem *epi,
 			    poll_table *pt,
 			    struct epoll_event __user **uevents,
-			    struct list_head *txlist)
+			    struct list_head *scan_batch)
 {
 	struct epoll_event __user *next;
 	struct wakeup_source *ws;
@@ -2064,7 +2066,7 @@ static int ep_deliver_event(struct eventpoll *ep, struct epitem *epi,
 		 * ep_done_scan() splices it onto rdllist for the next
 		 * attempt.
 		 */
-		list_add(&epi->rdllink, txlist);
+		list_add(&epi->rdllink, scan_batch);
 		ep_pm_stay_awake(epi);
 		return -EFAULT;
 	}
@@ -2090,7 +2092,7 @@ static int ep_send_events(struct eventpoll *ep,
 			  struct epoll_event __user *events, int maxevents)
 {
 	struct epitem *epi, *tmp;
-	LIST_HEAD(txlist);
+	LIST_HEAD(scan_batch);
 	poll_table pt;
 	int res = 0;
 
@@ -2105,19 +2107,19 @@ static int ep_send_events(struct eventpoll *ep,
 	init_poll_funcptr(&pt, NULL);
 
 	mutex_lock(&ep->mtx);
-	ep_start_scan(ep, &txlist);
+	ep_start_scan(ep, &scan_batch);
 
 	/*
 	 * We can loop without lock because we are passed a task-private
-	 * txlist; items cannot vanish while we hold ep->mtx.
+	 * scan_batch; items cannot vanish while we hold ep->mtx.
 	 */
-	list_for_each_entry_safe(epi, tmp, &txlist, rdllink) {
+	list_for_each_entry_safe(epi, tmp, &scan_batch, rdllink) {
 		int delivered;
 
 		if (res >= maxevents)
 			break;
 
-		delivered = ep_deliver_event(ep, epi, &pt, &events, &txlist);
+		delivered = ep_deliver_event(ep, epi, &pt, &events, &scan_batch);
 		if (delivered < 0) {
 			if (!res)
 				res = delivered;
@@ -2126,7 +2128,7 @@ static int ep_send_events(struct eventpoll *ep,
 		res += delivered;
 	}
 
-	ep_done_scan(ep, &txlist);
+	ep_done_scan(ep, &scan_batch);
 	mutex_unlock(&ep->mtx);
 
 	return res;

-- 
2.47.3

