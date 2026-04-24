Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266F62F3C22
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038419; cv=none; b=INy512ZjxyuXcmooudWSSc8ZQ6Dutqw0RynDdEx5tUve0Rt7eypoYCmLVMJIze/Y0wrw05jWWbgCmdNdrPuTczqHkN1rKsZgOIDyKDdrXHwZ9tiqoIHMM1JqdPcfJdvI7TC7w95pL9s2GIaAKqlIZ85ePdShWICq/QwwpK+25+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038419; c=relaxed/simple;
	bh=aSzC+A3LLq5tRZjecjfpPMuRBLoIyM2YiRT7Z/7hYlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FZABu5+91zOWzdvsGpD7fTD8LXQ9zoVBkkIw91UwR67vrdDadbDASdBYhfqRUQCx50nimLP9ioyl1/0qDmlEdNuPfiIMQgOHg0GfggIWzN0q92dAjgzJ0MDp8fh3J4UXArlPevKFrRX43B/5xv9GZ6kWbRlUBTZtcqCQRh4MxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xgq/v5+I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xgq/v5+I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54248C19425;
	Fri, 24 Apr 2026 13:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038418;
	bh=aSzC+A3LLq5tRZjecjfpPMuRBLoIyM2YiRT7Z/7hYlU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Xgq/v5+IFFtWidMQ4P2zqJva2zmEkw+27x+TyhKqVtwAFPRgfgaeeydMweUr+HPqI
	 MWuhkNKaa964u8Hp7InjjDYPdnm5JQUKZ4KnbSeje7GjRpEzdXknZ08XjzTiE3I7gf
	 CLIfBU9Ib/a3ymDlRpeyuF4R0aitIW75nZc2ns2fsucjMUokI/hBz0r2A0euMJw9tT
	 rtR9EpywaZ0n6ll8m1dqii85qRVyI42GiaJBEbJ6yul1C1zXF2XJ0yDWTLa264RUQE
	 Ok5pNrGs7nzQudD538mAyyuLWViynR3wgvmvqebzuj54OOFWbfP29VHIjT7Y8NJbRY
	 wDhJKPn5drU/Q==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Apr 2026 15:46:36 +0200
Subject: [PATCH 05/17] eventpoll: document ep_clear_and_put() two-pass
 pattern
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-work-epoll-rework-v1-5-249ed00a20f3@kernel.org>
References: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
In-Reply-To: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4247; i=brauner@kernel.org;
 h=from:subject:message-id; bh=aSzC+A3LLq5tRZjecjfpPMuRBLoIyM2YiRT7Z/7hYlU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+LnF/FzPfoXK9fufFQ5UV79OuvF2z3nxt2paKXUI9S
 /dJ/8wz7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIxG6G/2mzbyj0tOtc8zQ6
 99ZPeJGbelHQY19XoxKTU1ZWK/58FWNkOPD+x43ZO+5YHT1oyfdu6WndiisOs7PF1jTu2phRwn4
 yjQkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

ep_clear_and_put() walks the rbtree twice: once to drain each epi's
pwqlist, then again to ep_remove() each entry. The split is
load-bearing -- fusing the passes into one loop would let a poll
callback still queued on some epi_i fire after epi_{i+k} has already
been freed -- but the previous comments described each pass in
isolation and did not explain the ordering invariant or the
cooperation with removal path C (eventpoll_release_file).

Add a function-level docblock that labels this as path B from the
top-of-file "Removal paths" section, names the two passes and the
ordering invariant, explains the pwqlist drain as synchronization
with in-flight ep_poll_callback() via whead->lock, describes the
C-path hand-off when epi_fget() returns NULL, and states the
ep->refcount invariant that keeps ep_remove()'s WARN_ON_ONCE safe
across the loop.

Also tighten the per-pass comments to one line each and fix the
minor grammar bug in the poll_wait release comment ("these file" ->
"poll-on-ep").

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/eventpoll.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 1039d9737ce9..b6a14c69c482 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1103,20 +1103,47 @@ static void ep_remove(struct eventpoll *ep, struct epitem *epi)
 	WARN_ON_ONCE(ep_refcount_dec_and_test(ep));
 }
 
+/*
+ * Removal path B (see "Removal paths" in the top-of-file banner):
+ * close of the epoll fd itself, reached via ep_eventpoll_release().
+ *
+ * Under ep->mtx we walk the rbtree twice:
+ *
+ *   Pass 1 drains each epi's pwqlist via ep_unregister_pollwait().
+ *          This takes each watched waitqueue head's lock and so
+ *          synchronizes with any in-flight ep_poll_callback(), so
+ *          after the pass ends no callback can still be holding or
+ *          about to dereference any epi on this ep.
+ *
+ *   Pass 2 runs ep_remove() on each epi. The per-epi pwqlist is
+ *          already empty, but the rest of ep_remove() still runs
+ *          (epi_fget() pin, f_ep clear under f_lock, rbtree erase,
+ *          rdllist unlink, kfree_rcu).
+ *
+ * Pass 1 must strictly precede Pass 2: fusing them would let a
+ * callback queued on epi_i still fire after epi_{i+k} was freed.
+ *
+ * A concurrent eventpoll_release_file() (path C) serializes against
+ * us on ep->mtx; in Pass 2, ep_remove() transparently hands off any
+ * epi whose watched file is in __fput() by bailing when epi_fget()
+ * returns NULL, and C will clean that epi up on its side.
+ *
+ * ep->refcount is held > 0 throughout by the ep file's own share;
+ * we drop that share after the walk and free the eventpoll if we
+ * were last.
+ */
 static void ep_clear_and_put(struct eventpoll *ep)
 {
 	struct rb_node *rbp, *next;
 	struct epitem *epi;
 
-	/* We need to release all tasks waiting for these file */
+	/* Release any threads blocked in poll-on-ep. */
 	if (waitqueue_active(&ep->poll_wait))
 		ep_poll_safewake(ep, NULL, 0);
 
 	mutex_lock(&ep->mtx);
 
-	/*
-	 * Walks through the whole tree by unregistering poll callbacks.
-	 */
+	/* Pass 1: drain pwqlists; synchronizes with in-flight callbacks. */
 	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = rb_next(rbp)) {
 		epi = rb_entry(rbp, struct epitem, rbn);
 
@@ -1124,14 +1151,7 @@ static void ep_clear_and_put(struct eventpoll *ep)
 		cond_resched();
 	}
 
-	/*
-	 * Walks through the whole tree and try to free each "struct epitem".
-	 * Note that ep_remove() will not remove the epitem in case of a
-	 * racing eventpoll_release_file(); the latter will do the removal.
-	 * At this point we are sure no poll callbacks will be lingering around.
-	 * Since we still own a reference to the eventpoll struct, the loop can't
-	 * dispose it.
-	 */
+	/* Pass 2: remove each epi. rb_next() is captured before erase. */
 	for (rbp = rb_first_cached(&ep->rbr); rbp; rbp = next) {
 		next = rb_next(rbp);
 		epi = rb_entry(rbp, struct epitem, rbn);

-- 
2.47.3

