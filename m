Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0313D6CAA
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038428; cv=none; b=i/EXmgIErxP8z5arY1IhZuMnU8sVvNxswMFWUfnorwzpxHNSxCcK5gC4kD8JCyEtanRS99SJEhUWRFEihbWWybplA2d7bMRRwQfNBjxsY2uDBDrbCjzAroVCCM+DHPuc3E9ynHdR31Oo5OpbMNFZXyzxPaCPR4tYfV7Q0XpGkKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038428; c=relaxed/simple;
	bh=gEeToQeAJ/dcYncpR1YN6QmOFsq8cgbn0W8SuYnPS1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qZhK96DbaeNNTYlJKm3yxkIXtU2V0tq1rabdtVhgCFHEZ7gu7M3Rp3GqeVGB5F9v2YQQV1b+jANR6LFOpG0L78gYG6GCEYXxe6rDpkl5Pc0vvjjhchOtbg1wZ0T+YoqHXplSCD5Pxn8doLbFtEyRFX0Mjq+jX+cUz6HF0FLfQuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KO18rw4q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KO18rw4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89878C2BCB2;
	Fri, 24 Apr 2026 13:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038427;
	bh=gEeToQeAJ/dcYncpR1YN6QmOFsq8cgbn0W8SuYnPS1E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KO18rw4qNSAANepIoxvjCjhX7UjiA51pzQQTehH3DbaWDcrBLIdKkZaCdSvkfFciM
	 wWuBeKMI0shVeARYpCQgQ6ZF/LtWV2nEesXrF0M/5T4/7OfO4Tv/JWrGVd2Ypkz/AZ
	 uBWtWDJEPtnHL+WnTaajriqy8KbSottoHvP/vYCcq+Hrm2RJZ64BfA3xaWtlach1uM
	 EM3xrx/oGqPc3SkwuV4xpedlnlyp3dmBYLc0WbPWmFe1yrwWhkGBfBdXU4raC4503b
	 SRY35djbg4p/11DpykscDkLTwWTeg3YiFSSDsfqZfwxtMIg73Ij5q8+rsoKBMBnbw5
	 Eh6A5BSRBBsLw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Apr 2026 15:46:41 +0200
Subject: [PATCH 10/17] eventpoll: split ep_insert() into alloc + register
 stages
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-work-epoll-rework-v1-10-249ed00a20f3@kernel.org>
References: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
In-Reply-To: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7396; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gEeToQeAJ/dcYncpR1YN6QmOFsq8cgbn0W8SuYnPS1E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+LnFfW+/WeynW/v02vwQVJcsGjRX9tocve8WfdPdgD
 Qn/JrGqo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIzeBj+8DYsUMhfw7eu8rdk
 pS2PY3zADvHJio6ZAoIx2f/TdEQtGf6XuB+Z+fBlYMTTCRMc5fRSA2cEFFzerpubHNd68P+qlCB
 OAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

ep_insert() was 130 lines and mixed four concerns in one body: user
quota charge and epitem allocation, attach-into-file-hlist plus
rbtree insert plus target-ep locking, reverse-path + EPOLLWAKEUP +
poll-queue install with rollback, and ready-list publication.
Factor the first two concerns into named helpers so the body reduces
to orchestration.

ep_alloc_epitem() charges the user's epoll_watches quota, allocates
a fresh epitem, and initializes its fields. On failure it returns
ERR_PTR(-ENOSPC) or ERR_PTR(-ENOMEM); on success the epi is not yet
linked into anything.

ep_register_epitem() installs @epi into @tfile's f_ep hlist and
@ep's rbtree, optionally chains @tfile onto tfile_check_list for the
path check, takes the tep->mtx nested lock for the epoll-watches-
epoll case, and finally takes the ep_get() reference that pairs
with ep_remove()'s ep_put() in ep_insert()'s error paths. On failure
it frees the epi and decrements epoll_watches to match
ep_alloc_epitem().

ep_insert()'s remaining body is the rollback-via-ep_remove() chain
(reverse_path_check, EPOLLWAKEUP source creation, ep_ptable_queue_proc
allocation) and the ready-list / wake publication. Remove a few
stale comments that duplicated function-level documentation or
described obvious code.

No functional change; rollback boundaries unchanged -- every error
path after ep_register_epitem() still calls ep_remove(), preserving
the ep->refcount invariant that keeps ep_remove()'s WARN_ON_ONCE safe.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/eventpoll.c | 111 ++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 74 insertions(+), 37 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index fde2396342b6..e4a4e92d329f 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1726,68 +1726,112 @@ static int ep_attach_file(struct file *file, struct epitem *epi)
 }
 
 /*
- * Must be called with "mtx" held.
+ * Charge the user's epoll_watches quota, allocate a fresh epitem for
+ * @tfile/@fd, and initialize its fields. The returned item is not yet
+ * linked into any data structure; the caller must install it via
+ * ep_register_epitem() (which takes over on success) or kmem_cache_free()
+ * it and decrement epoll_watches on its own.
+ *
+ * Returns ERR_PTR(-ENOSPC) if the quota is exceeded, ERR_PTR(-ENOMEM)
+ * if the slab allocation fails.
  */
-static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
-		     struct file *tfile, int fd, int full_check)
+static struct epitem *ep_alloc_epitem(struct eventpoll *ep,
+				      const struct epoll_event *event,
+				      struct file *tfile, int fd)
 {
-	int error, pwake = 0;
-	__poll_t revents;
 	struct epitem *epi;
-	struct ep_pqueue epq;
-	struct eventpoll *tep = NULL;
-
-	if (is_file_epoll(tfile))
-		tep = tfile->private_data;
-
-	lockdep_assert_irqs_enabled();
 
 	if (unlikely(percpu_counter_compare(&ep->user->epoll_watches,
 					    max_user_watches) >= 0))
-		return -ENOSPC;
+		return ERR_PTR(-ENOSPC);
 	percpu_counter_inc(&ep->user->epoll_watches);
 
-	if (!(epi = kmem_cache_zalloc(epi_cache, GFP_KERNEL))) {
+	epi = kmem_cache_zalloc(epi_cache, GFP_KERNEL);
+	if (unlikely(!epi)) {
 		percpu_counter_dec(&ep->user->epoll_watches);
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	}
 
-	/* Item initialization follow here ... */
 	INIT_LIST_HEAD(&epi->rdllink);
 	epi->ep = ep;
 	ep_set_ffd(&epi->ffd, tfile, fd);
 	epi->event = *event;
 	epi->next = EP_UNACTIVE_PTR;
 
+	return epi;
+}
+
+/*
+ * Install @epi into its target file's f_ep hlist and into @ep's rbtree,
+ * taking one additional reference on @ep for the lifetime of the item.
+ *
+ * If @tep is non-NULL, the target file is itself an eventpoll; we hold
+ * tep->mtx at subclass 1 across the attach + rbtree insert to serialize
+ * with the target side. RB tree ops are protected by @ep->mtx, which
+ * the caller already holds.
+ *
+ * On failure the epi is freed and the epoll_watches counter decremented,
+ * matching ep_alloc_epitem()'s allocation. After this returns
+ * successfully, ep_insert()'s later error paths use ep_remove() for
+ * unwind; that cannot drop @ep's refcount to zero because the ep file
+ * itself still holds the original reference.
+ */
+static int ep_register_epitem(struct eventpoll *ep, struct epitem *epi,
+			      struct eventpoll *tep, int full_check)
+{
+	struct file *tfile = epi->ffd.file;
+	int error;
+
 	if (tep)
 		mutex_lock_nested(&tep->mtx, 1);
-	/* Add the current item to the list of active epoll hook for this file */
-	if (unlikely(ep_attach_file(tfile, epi) < 0)) {
+
+	error = ep_attach_file(tfile, epi);
+	if (unlikely(error)) {
 		if (tep)
 			mutex_unlock(&tep->mtx);
 		kmem_cache_free(epi_cache, epi);
 		percpu_counter_dec(&ep->user->epoll_watches);
-		return -ENOMEM;
+		return error;
 	}
 
 	if (full_check && !tep)
 		list_file(tfile);
 
-	/*
-	 * Add the current item to the RB tree. All RB tree operations are
-	 * protected by "mtx", and ep_insert() is called with "mtx" held.
-	 */
 	ep_rbtree_insert(ep, epi);
+
 	if (tep)
 		mutex_unlock(&tep->mtx);
 
-	/*
-	 * ep_remove() calls in the later error paths can't lead to
-	 * ep_free() as the ep file itself still holds an ep reference.
-	 */
 	ep_get(ep);
+	return 0;
+}
+
+/*
+ * Must be called with "mtx" held.
+ */
+static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
+		     struct file *tfile, int fd, int full_check)
+{
+	int error, pwake = 0;
+	__poll_t revents;
+	struct epitem *epi;
+	struct ep_pqueue epq;
+	struct eventpoll *tep = NULL;
+
+	if (is_file_epoll(tfile))
+		tep = tfile->private_data;
+
+	lockdep_assert_irqs_enabled();
 
-	/* now check if we've created too many backpaths */
+	epi = ep_alloc_epitem(ep, event, tfile, fd);
+	if (IS_ERR(epi))
+		return PTR_ERR(epi);
+
+	error = ep_register_epitem(ep, epi, tep, full_check);
+	if (error)
+		return error;
+
+	/* Reject the insert if the new link would create too many back-paths. */
 	if (unlikely(full_check && reverse_path_check())) {
 		ep_remove(ep, epi);
 		return -EINVAL;
@@ -1814,28 +1858,21 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	 */
 	revents = ep_item_poll(epi, &epq.pt, 1);
 
-	/*
-	 * We have to check if something went wrong during the poll wait queue
-	 * install process. Namely an allocation for a wait queue failed due
-	 * high memory pressure.
-	 */
+	/* ep_ptable_queue_proc() signals allocation failure by clearing epq.epi. */
 	if (unlikely(!epq.epi)) {
 		ep_remove(ep, epi);
 		return -ENOMEM;
 	}
 
-	/* We have to drop the new item inside our item list to keep track of it */
+	/* Drop the new item onto the ready list if it is already ready. */
 	spin_lock_irq(&ep->lock);
 
-	/* record NAPI ID of new item if present */
 	ep_set_busy_poll_napi_id(epi);
 
-	/* If the file is already "ready" we drop it inside the ready list */
 	if (revents && !ep_is_linked(epi)) {
 		list_add_tail(&epi->rdllink, &ep->rdllist);
 		ep_pm_stay_awake(epi);
 
-		/* Notify waiting tasks that events are available */
 		if (waitqueue_active(&ep->wq))
 			wake_up(&ep->wq);
 		if (waitqueue_active(&ep->poll_wait))

-- 
2.47.3

