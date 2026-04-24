Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7A23D903A
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038430; cv=none; b=qxmYDjDwyMixTbaloxM0dvkXedF+A0fPqOnLQy+/XYzACLCH1wnS1vuQ5DOv74BQekc5A8qjFjvGcY/oghZAtftQalaMKbLKdV42LB4v6N6i6ukTmBfNCgLYn8U2xXduS5JizktmUgExp4wbDKP7V+k+Wcr56Ky+cJeHdrddfaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038430; c=relaxed/simple;
	bh=lTkLqKuFxe7xi2ys+Zu+Q7CrOnK4qjvrP2ElG9F19c8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0fDudnHaUnIJZkEFJMC1ttVqBKLSYRc+syJ787dSM+8oDOuSRoZXonK20qh9k3GEsPxSXhLYnSKnbR+qj0h/UnuRdO900Nebr0SUoqTw7nfqImBg5YhGlY16u/Lkswg88WrTkM0IKFkzP7f/m3wQBz30Eiq1jOVdnCEUEvchfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqFWQoMu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqFWQoMu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E1AC19425;
	Fri, 24 Apr 2026 13:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038429;
	bh=lTkLqKuFxe7xi2ys+Zu+Q7CrOnK4qjvrP2ElG9F19c8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iqFWQoMuREc6iHBzCcobf3VDh2Fo/ckne0BYZfFULzMqkXwncXR9bWt/z6H8oOOl4
	 zRug5AajzTnk/z25LVSyOVPW66qWBB5HKQu790yV/oNfFUYhRx3sYPCVd1BP9MZ/xI
	 3yGAKmzyzQF79QVTcRca5lAW398YF64Cc0diAEKwFbkFbrwnFaXWHjUV6HgeIxlfR+
	 eHVcvtT8c4MHb3/BjwLxDHX3byGSUf37MfaaBqn/iQfEGS2PsFcV1Lf8fyAjEXMUCj
	 YA2fw55STaJ4g0REMEY9FcCRHrlQRgC0lipySWxNZWGzsauEpJ+blydwvBxYYlvfj7
	 Q1upD7yYOhYJQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Apr 2026 15:46:42 +0200
Subject: [PATCH 11/17] eventpoll: split ep_clear_and_put() into drain
 helpers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-work-epoll-rework-v1-11-249ed00a20f3@kernel.org>
References: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
In-Reply-To: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5748; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lTkLqKuFxe7xi2ys+Zu+Q7CrOnK4qjvrP2ElG9F19c8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+LnH32JrO63/g/Z6PR5fG2O/gDl52wPxa3AcxN5tl2
 kVttQEVHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPJW8Lwv8p9M+PVFt+uV25x
 nLfnmu1Q9P4tVvSi+EX/GpXV31OishgZZtxOV6zwC9HyPF994g6n2h6WuXs4TYQeSex2WB3/wPw
 qMwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

ep_clear_and_put()'s two-pass walk is the main way an ep file close
tears down its state, and the ordering between the passes is
load-bearing (see previous commit's docblock). Give each pass its
own function so the ordering is enforced by the call sequence in
ep_clear_and_put() rather than by convention inside one body.

ep_drain_pollwaits() carries out Pass 1: walk the rbtree and
ep_unregister_pollwait() each epi. The function-level comment names
it as Pass 1 and spells out the synchronization contract with
ep_poll_callback().

ep_drain_tree() carries out Pass 2: walk the rbtree and ep_remove()
each epi, capturing rb_next() before each erase. The comment names
it as Pass 2 and documents the hand-off with a concurrent
eventpoll_release_file() (removal path C).

ep_clear_and_put() keeps the poll-on-ep wakeup, ep->mtx bracketing,
and ep_put() + conditional ep_free(), and its docblock shrinks to
the high-level summary; the per-pass detail moved into the helpers.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/eventpoll.c | 87 ++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 51 insertions(+), 36 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index e4a4e92d329f..eeddd05ba529 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1105,62 +1105,77 @@ static void ep_remove(struct eventpoll *ep, struct epitem *epi)
 }
 
 /*
- * Removal path B (see "Removal paths" in the top-of-file banner):
- * close of the epoll fd itself, reached via ep_eventpoll_release().
- *
- * Under ep->mtx we walk the rbtree twice:
- *
- *   Pass 1 drains each epi's pwqlist via ep_unregister_pollwait().
- *          This takes each watched waitqueue head's lock and so
- *          synchronizes with any in-flight ep_poll_callback(), so
- *          after the pass ends no callback can still be holding or
- *          about to dereference any epi on this ep.
- *
- *   Pass 2 runs ep_remove() on each epi. The per-epi pwqlist is
- *          already empty, but the rest of ep_remove() still runs
- *          (epi_fget() pin, f_ep clear under f_lock, rbtree erase,
- *          rdllist unlink, kfree_rcu).
- *
- * Pass 1 must strictly precede Pass 2: fusing them would let a
- * callback queued on epi_i still fire after epi_{i+k} was freed.
- *
- * A concurrent eventpoll_release_file() (path C) serializes against
- * us on ep->mtx; in Pass 2, ep_remove() transparently hands off any
- * epi whose watched file is in __fput() by bailing when epi_fget()
- * returns NULL, and C will clean that epi up on its side.
- *
- * ep->refcount is held > 0 throughout by the ep file's own share;
- * we drop that share after the walk and free the eventpoll if we
- * were last.
+ * Pass 1 of ep_clear_and_put(): drain every epi's pwqlist.
+ * ep_unregister_pollwait() takes each watched wait-queue head's lock,
+ * which synchronizes with any in-flight ep_poll_callback(); after
+ * this returns no callback can still be about to dereference an epi
+ * on this ep. Must strictly precede ep_drain_tree() -- fusing the
+ * two walks would let a callback queued on epi_i still fire after
+ * epi_{i+k} had already been freed.
  */
-static void ep_clear_and_put(struct eventpoll *ep)
+static void ep_drain_pollwaits(struct eventpoll *ep)
 {
-	struct rb_node *rbp, *next;
+	struct rb_node *rbp;
 	struct epitem *epi;
 
-	/* Release any threads blocked in poll-on-ep. */
-	if (waitqueue_active(&ep->poll_wait))
-		ep_poll_safewake(ep, NULL, 0);
-
-	mutex_lock(&ep->mtx);
+	lockdep_assert_held(&ep->mtx);
 
-	/* Pass 1: drain pwqlists; synchronizes with in-flight callbacks. */
 	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = rb_next(rbp)) {
 		epi = rb_entry(rbp, struct epitem, rbn);
 
 		ep_unregister_pollwait(ep, epi);
 		cond_resched();
 	}
+}
+
+/*
+ * Pass 2 of ep_clear_and_put(): ep_remove() every epi. The per-epi
+ * pwqlist is already empty (ep_drain_pollwaits ran), but the rest of
+ * ep_remove() still runs: epi_fget() pin, f_ep clear under f_lock,
+ * rbtree erase, rdllist unlink, kfree_rcu(epi). rb_next() is captured
+ * before each erase so the iteration is stable.
+ *
+ * A concurrent eventpoll_release_file() (removal path C) on a watched
+ * file serializes with us via ep->mtx; ep_remove() transparently
+ * hands off any epi whose file is in __fput() by bailing when
+ * epi_fget() returns NULL, and path C will clean that epi up.
+ */
+static void ep_drain_tree(struct eventpoll *ep)
+{
+	struct rb_node *rbp, *next;
+	struct epitem *epi;
+
+	lockdep_assert_held(&ep->mtx);
 
-	/* Pass 2: remove each epi. rb_next() is captured before erase. */
 	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = next) {
 		next = rb_next(rbp);
 		epi = rb_entry(rbp, struct epitem, rbn);
 		ep_remove(ep, epi);
 		cond_resched();
 	}
+}
+
+/*
+ * Removal path B (see "Removal paths" in the top-of-file banner):
+ * close of the epoll fd itself, reached via ep_eventpoll_release().
+ *
+ * Two passes under ep->mtx: first ep_drain_pollwaits() quiesces
+ * in-flight callbacks, then ep_drain_tree() frees the epis. The
+ * ep->refcount is kept > 0 across the walk by the ep file's own
+ * share, which we drop below; ep_free() runs iff we were the last
+ * holder after the tree drained.
+ */
+static void ep_clear_and_put(struct eventpoll *ep)
+{
+	/* Release any threads blocked in poll-on-ep. */
+	if (waitqueue_active(&ep->poll_wait))
+		ep_poll_safewake(ep, NULL, 0);
 
+	mutex_lock(&ep->mtx);
+	ep_drain_pollwaits(ep);
+	ep_drain_tree(ep);
 	mutex_unlock(&ep->mtx);
+
 	if (ep_put(ep))
 		ep_free(ep);
 }

-- 
2.47.3

