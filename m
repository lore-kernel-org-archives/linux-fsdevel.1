Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601D330ACF1
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038441; cv=none; b=sL9keENfusHnMsrk5XxbjjhmUoDKgYSoqcj06nwZrzaQ5Z9mPtdhMqiNI/X/q0ymETiVUeG+Cw0FlmNRY87Mf/UppGyV+q+yYk+B6B1OpdZmghWPuoMFQFn+7wSSunSzFKIuR2TzW4CYtEsSXL4Fj+LlAVpl+UucYet0Rr50XUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038441; c=relaxed/simple;
	bh=1R8xQy1W0B0hVAFEkhocDswxkMHNNxgEZsYoNwsgNS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TlacDB1piYej4X0LCT+EeuADG7qiJ0AB0q3AYgtMqyOOVZ0b4q/plRYpOWvs7FNuE+ejd6n/GOS0lAKhc9vqoTmON1SfqOXljn5IKSIAguY7KgX3sZbyTctRq4u2NF0jHyqqxYRR8SHo0dW8ZfWqEnYWJ60MbOiqiI5NP8HQ8WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFXNsWAD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFXNsWAD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ACEC2BCB5;
	Fri, 24 Apr 2026 13:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038440;
	bh=1R8xQy1W0B0hVAFEkhocDswxkMHNNxgEZsYoNwsgNS4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RFXNsWADeuo1AQD53AHJeUwo7CQJuT15vEuatevvFCjgoMFJLKHdNMKXdlWZmHLIP
	 d+7GLikcYviklCp1wOacinTffslm90c0/3RendQCNLJQd7tBh7gTTMDZnsmmXo08w8
	 e8aD3d7BQxCIvKeWa5P45XP+yTB7xvcPgv380qyM08UfFboLPdUnEht5ASj8Tmne43
	 wvsjJyeCUwnXvMjlSRcsPHJvxe4UI2wQdJxxpEVQWj4wTMrLbKtQnAA4jdOxCKn4ph
	 SdDtS4/hg4EWaKJQ+tG4f33Q3jLc+Mj3I1AuKVVZgTnymI2dvKy5IQaFIDab6XmNSB
	 1PHTAO5H8L63g==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 24 Apr 2026 15:46:48 +0200
Subject: [PATCH 17/17] eventpoll: hoist CTL_ADD scratch state into struct
 ep_ctl_ctx
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-work-epoll-rework-v1-17-249ed00a20f3@kernel.org>
References: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
In-Reply-To: <20260424-work-epoll-rework-v1-0-249ed00a20f3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=19525; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1R8xQy1W0B0hVAFEkhocDswxkMHNNxgEZsYoNwsgNS4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS+LnF3+PW/+9WRV41lTKsshSwWyszisXEWWLHabcnrP
 q93DU8yO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZyYR0jQ7P6u03lrc8MJi2a
 kH5omVteX0viqtS1IT2Tz6+xMpqW+YThnwZPz+kdSbblshtWXvE5uy2yoqZG/8WhxLIU/dgale3
 7GAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Three globals were shared between the loop check and the path check
paths: tfile_check_list (chain of epitems_head to walk afterwards),
path_count[] (per-depth wakeup-path tally) and inserting_into
(cycle-detection sentinel). All three are scratch state used only
during a single EPOLL_CTL_ADD full_check, yet they sit at file
scope and rely on epnested_mutex for exclusion.

The area has had three bugs in the last year -- CVE-2025-38349,
f2e467a48287 ("eventpoll: Fix semi-unbounded recursion"), and
fdcfce93073d ("eventpoll: Fix integer overflow in
ep_loop_check_proc()") -- all rooted in the shared-mutable-global
pattern being hard to reason about.

Collect the three into a stack-allocated struct ep_ctl_ctx:

    struct ep_ctl_ctx {
        struct eventpoll   *inserting_into;
        struct epitems_head *tfile_check_list;
        int                 path_count[PATH_ARR_SIZE];
    };

do_epoll_ctl() zero-initializes one on its stack and plumbs it
through ep_ctl_lock() / ep_ctl_unlock() / ep_insert() /
ep_register_epitem() / list_file() / ep_loop_check() /
ep_loop_check_proc() / reverse_path_check() /
reverse_path_check_proc() / path_count_inc() / path_count_init() /
clear_tfile_check_list(). Non-nested inserts leave the ctx zeroed
and skip the machinery entirely.

With the scratch state in ctx:
  - tfile_check_list no longer has an EP_UNACTIVE_PTR sentinel --
    NULL is the obvious "empty" value and the zero-init handles it
    for free;
  - path_count[] is no longer an array global that could be touched
    in unexpected orderings;
  - inserting_into is scoped to the exact call that set it.

loop_check_gen stays as a file-scope monotonic counter, because the
stamp left on ep->gen by a completed walk must not equal the stamp
of a future walk -- something a stack-local value cannot guarantee
across calls. It remains protected by epnested_mutex for the bump
and read lockless for the "do we need a full check" trigger in
ep_ctl_lock().

Every bail-out that existed before (the ELOOP on cycle, the path
limit check, the unbounded-recursion cap, the +1 overflow guard) is
preserved verbatim; only the data they operate on moved from file
scope to the stack ctx.

No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/eventpoll.c | 206 ++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 117 insertions(+), 89 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 201e688304b3..b839cc02eb0e 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -388,32 +388,25 @@ static long max_user_watches __read_mostly;
  *      of a given length -- reverse_path_check().
  *
  * Both need a global view of the epoll topology and must be atomic
- * with the insertion, so the scratch state below is all serialized by
- * one global mutex, epnested_mutex. Non-nested inserts skip this
- * machinery entirely and take only ep->mtx.
- *
- *   epnested_mutex     Serializes the whole check; also protects every
- *                      other variable in this block plus path_count[]
- *                      (declared with the path-check code further
- *                      down).
- *   loop_check_gen     Monotonic stamp, bumped once at the start of a
- *                      check and once at the end. ep->gen caches the
- *                      value under which ep was last visited by
+ * with the insertion, so the check is serialized by epnested_mutex
+ * and carries its scratch state on a stack-allocated struct
+ * ep_ctl_ctx scoped to one do_epoll_ctl() call. Non-nested inserts
+ * skip this machinery entirely and take only ep->mtx.
+ *
+ *   epnested_mutex     Serializes the whole check.
+ *   loop_check_gen     Global monotonic stamp, bumped at the start of
+ *                      a check and again at the end. ep->gen caches
+ *                      the value under which ep was last visited by
  *                      ep_loop_check_proc() or
  *                      ep_get_upwards_depth_proc(); the post-check
  *                      bump ensures those cached stamps can no longer
  *                      equal loop_check_gen, so the
  *                      "ep->gen == loop_check_gen" trigger in
- *                      do_epoll_ctl() only fires while another check
+ *                      ep_ctl_lock() only fires while another check
  *                      is in flight.
- *   inserting_into     Outer eventpoll pointer for the lifetime of one
- *                      ep_loop_check(); ep_loop_check_proc() fails
- *                      with -ELOOP if the downward walk reaches it.
- *   tfile_check_list   Singly-linked list of epitems_head objects
- *                      collected by ep_loop_check_proc() during the
- *                      walk, consumed by reverse_path_check()
- *                      afterwards. Sentinel EP_UNACTIVE_PTR means no
- *                      check is in flight.
+ *
+ * struct ep_ctl_ctx carries the rest (inserting_into, tfile_check_list,
+ * path_count[]) through the walk; see its declaration below.
  *
  * Commits fdcfce93073d ("eventpoll: Fix integer overflow in
  * ep_loop_check_proc()") and f2e467a48287 ("eventpoll: Fix
@@ -422,7 +415,36 @@ static long max_user_watches __read_mostly;
  */
 static DEFINE_MUTEX(epnested_mutex);
 static u64 loop_check_gen = 0;
-static struct eventpoll *inserting_into;
+
+#define PATH_ARR_SIZE 5
+
+/*
+ * Per-do_epoll_ctl() scratch for the loop / path checks. Allocated on
+ * the caller's stack; populated by ep_ctl_lock() and the downward
+ * walk; consumed by reverse_path_check(); released by ep_ctl_unlock().
+ * Only valid while the caller holds epnested_mutex.
+ */
+struct ep_ctl_ctx {
+	/*
+	 * Outer eventpoll for one ep_loop_check(); if the downward walk
+	 * reaches it the insert would form a cycle.
+	 */
+	struct eventpoll *inserting_into;
+
+	/*
+	 * Singly-linked list of epitems_head objects collected during
+	 * ep_loop_check_proc(), then walked by reverse_path_check().
+	 * NULL means empty.
+	 */
+	struct epitems_head *tfile_check_list;
+
+	/*
+	 * Per-depth wakeup-path tally used by reverse_path_check_proc();
+	 * reinitialized to zero at the start of each reverse_path_check()
+	 * iteration.
+	 */
+	int path_count[PATH_ARR_SIZE];
+};
 
 /* Slab cache used to allocate "struct epitem" */
 static struct kmem_cache *epi_cache __ro_after_init;
@@ -434,13 +456,12 @@ static struct kmem_cache *pwq_cache __ro_after_init;
  * Wrapper anchor for file->f_ep when the watched file is not itself an
  * eventpoll; for the epoll-watches-epoll case, file->f_ep points at
  * &watched_ep->refs directly. The ->next field threads
- * tfile_check_list during one EPOLL_CTL_ADD path check.
+ * ctx->tfile_check_list during one EPOLL_CTL_ADD path check.
  */
 struct epitems_head {
 	struct hlist_head epitems;
 	struct epitems_head *next;
 };
-static struct epitems_head *tfile_check_list = EP_UNACTIVE_PTR;
 
 static struct kmem_cache *ephead_cache __ro_after_init;
 
@@ -450,14 +471,14 @@ static inline void free_ephead(struct epitems_head *head)
 		kmem_cache_free(ephead_cache, head);
 }
 
-static void list_file(struct file *file)
+static void list_file(struct file *file, struct ep_ctl_ctx *ctx)
 {
 	struct epitems_head *head;
 
 	head = container_of(file->f_ep, struct epitems_head, epitems);
 	if (!head->next) {
-		head->next = tfile_check_list;
-		tfile_check_list = head;
+		head->next = ctx->tfile_check_list;
+		ctx->tfile_check_list = head;
 	}
 }
 
@@ -1613,41 +1634,40 @@ static void ep_rbtree_insert(struct eventpoll *ep, struct epitem *epi)
 
 
 
-#define PATH_ARR_SIZE 5
 /*
- * These are the number paths of length 1 to 5, that we are allowing to emanate
- * from a single file of interest. For example, we allow 1000 paths of length
- * 1, to emanate from each file of interest. This essentially represents the
- * potential wakeup paths, which need to be limited in order to avoid massive
- * uncontrolled wakeup storms. The common use case should be a single ep which
- * is connected to n file sources. In this case each file source has 1 path
- * of length 1. Thus, the numbers below should be more than sufficient. These
- * path limits are enforced during an EPOLL_CTL_ADD operation, since a modify
- * and delete can't add additional paths. Protected by the epnested_mutex.
+ * Upper bound on wakeup paths emanating from any one watched file,
+ * indexed by path depth (1..PATH_ARR_SIZE). For example, we allow
+ * 1000 paths of length 1 from each watched file. These caps limit
+ * the wakeup amplification that can be built from epoll-watches-
+ * epoll topologies without rejecting reasonable usage.
+ *
+ * Enforced at EPOLL_CTL_ADD; CTL_MOD and CTL_DEL cannot add paths.
+ * The running tallies live in ctx->path_count[] and are protected by
+ * epnested_mutex.
  */
 static const int path_limits[PATH_ARR_SIZE] = { 1000, 500, 100, 50, 10 };
-static int path_count[PATH_ARR_SIZE];
 
-static int path_count_inc(int nests)
+static int path_count_inc(struct ep_ctl_ctx *ctx, int nests)
 {
 	/* Allow an arbitrary number of depth 1 paths */
 	if (nests == 0)
 		return 0;
 
-	if (++path_count[nests] > path_limits[nests])
+	if (++ctx->path_count[nests] > path_limits[nests])
 		return -1;
 	return 0;
 }
 
-static void path_count_init(void)
+static void path_count_init(struct ep_ctl_ctx *ctx)
 {
 	int i;
 
 	for (i = 0; i < PATH_ARR_SIZE; i++)
-		path_count[i] = 0;
+		ctx->path_count[i] = 0;
 }
 
-static int reverse_path_check_proc(struct hlist_head *refs, int depth)
+static int reverse_path_check_proc(struct ep_ctl_ctx *ctx,
+				   struct hlist_head *refs, int depth)
 {
 	int error = 0;
 	struct epitem *epi;
@@ -1659,9 +1679,9 @@ static int reverse_path_check_proc(struct hlist_head *refs, int depth)
 	hlist_for_each_entry_rcu(epi, refs, fllink) {
 		struct hlist_head *refs = &epi->ep->refs;
 		if (hlist_empty(refs))
-			error = path_count_inc(depth);
+			error = path_count_inc(ctx, depth);
 		else
-			error = reverse_path_check_proc(refs, depth + 1);
+			error = reverse_path_check_proc(ctx, refs, depth + 1);
 		if (error != 0)
 			break;
 	}
@@ -1669,24 +1689,23 @@ static int reverse_path_check_proc(struct hlist_head *refs, int depth)
 }
 
 /**
- * reverse_path_check - The tfile_check_list is list of epitem_head, which have
- *                      links that are proposed to be newly added. We need to
- *                      make sure that those added links don't add too many
- *                      paths such that we will spend all our time waking up
- *                      eventpoll objects.
+ * reverse_path_check - ctx->tfile_check_list is a list of epitems_head
+ *                      anchoring files with newly proposed links; make
+ *                      sure those links don't push any path-length bucket
+ *                      over its limit in path_limits[].
  *
  * Return: %zero if the proposed links don't create too many paths,
  *	    %-1 otherwise.
  */
-static int reverse_path_check(void)
+static int reverse_path_check(struct ep_ctl_ctx *ctx)
 {
 	struct epitems_head *p;
 
-	for (p = tfile_check_list; p != EP_UNACTIVE_PTR; p = p->next) {
+	for (p = ctx->tfile_check_list; p; p = p->next) {
 		int error;
-		path_count_init();
+		path_count_init(ctx);
 		rcu_read_lock();
-		error = reverse_path_check_proc(&p->epitems, 0);
+		error = reverse_path_check_proc(ctx, &p->epitems, 0);
 		rcu_read_unlock();
 		if (error)
 			return error;
@@ -1817,8 +1836,9 @@ static struct epitem *ep_alloc_epitem(struct eventpoll *ep,
  * unwind; that cannot drop @ep's refcount to zero because the ep file
  * itself still holds the original reference.
  */
-static int ep_register_epitem(struct eventpoll *ep, struct epitem *epi,
-			      struct eventpoll *tep, int full_check)
+static int ep_register_epitem(struct ep_ctl_ctx *ctx, struct eventpoll *ep,
+			      struct epitem *epi, struct eventpoll *tep,
+			      int full_check)
 {
 	struct file *tfile = epi->ffd.file;
 	int error;
@@ -1836,7 +1856,7 @@ static int ep_register_epitem(struct eventpoll *ep, struct epitem *epi,
 	}
 
 	if (full_check && !tep)
-		list_file(tfile);
+		list_file(tfile, ctx);
 
 	ep_rbtree_insert(ep, epi);
 
@@ -1850,8 +1870,9 @@ static int ep_register_epitem(struct eventpoll *ep, struct epitem *epi,
 /*
  * Must be called with "mtx" held.
  */
-static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
-		     struct file *tfile, int fd, int full_check)
+static int ep_insert(struct ep_ctl_ctx *ctx, struct eventpoll *ep,
+		     const struct epoll_event *event, struct file *tfile,
+		     int fd, int full_check)
 {
 	int error, pwake = 0;
 	__poll_t revents;
@@ -1868,12 +1889,12 @@ static int ep_insert(struct eventpoll *ep, const struct epoll_event *event,
 	if (IS_ERR(epi))
 		return PTR_ERR(epi);
 
-	error = ep_register_epitem(ep, epi, tep, full_check);
+	error = ep_register_epitem(ctx, ep, epi, tep, full_check);
 	if (error)
 		return error;
 
 	/* Reject the insert if the new link would create too many back-paths. */
-	if (unlikely(full_check && reverse_path_check())) {
+	if (unlikely(full_check && reverse_path_check(ctx))) {
 		ep_remove(ep, epi);
 		return -EINVAL;
 	}
@@ -2340,7 +2361,8 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
  * Return: depth of the subtree, or a value bigger than EP_MAX_NESTS if we found
  * a loop or went too deep.
  */
-static int ep_loop_check_proc(struct eventpoll *ep, int depth)
+static int ep_loop_check_proc(struct ep_ctl_ctx *ctx,
+			      struct eventpoll *ep, int depth)
 {
 	int result = 0;
 	struct rb_node *rbp;
@@ -2356,22 +2378,23 @@ static int ep_loop_check_proc(struct eventpoll *ep, int depth)
 		if (unlikely(is_file_epoll(epi->ffd.file))) {
 			struct eventpoll *ep_tovisit;
 			ep_tovisit = epi->ffd.file->private_data;
-			if (ep_tovisit == inserting_into || depth > EP_MAX_NESTS)
+			if (ep_tovisit == ctx->inserting_into ||
+			    depth > EP_MAX_NESTS)
 				result = EP_MAX_NESTS+1;
 			else
-				result = max(result, ep_loop_check_proc(ep_tovisit, depth + 1) + 1);
+				result = max(result,
+					     ep_loop_check_proc(ctx, ep_tovisit,
+								depth + 1) + 1);
 			if (result > EP_MAX_NESTS)
 				break;
 		} else {
 			/*
-			 * If we've reached a file that is not associated with
-			 * an ep, then we need to check if the newly added
-			 * links are going to add too many wakeup paths. We do
-			 * this by adding it to the tfile_check_list, if it's
-			 * not already there, and calling reverse_path_check()
-			 * during ep_insert().
+			 * A non-epoll leaf. Queue it for the companion
+			 * reverse_path_check() that runs after this walk so
+			 * any new links we propose don't add too many wakeup
+			 * paths.
 			 */
-			list_file(epi->ffd.file);
+			list_file(epi->ffd.file, ctx);
 		}
 	}
 	ep->loop_check_depth = result;
@@ -2400,22 +2423,24 @@ static int ep_get_upwards_depth_proc(struct eventpoll *ep, int depth)
  *                 into another epoll file (represented by @ep) does not create
  *                 closed loops or too deep chains.
  *
- * @ep: Pointer to the epoll we are inserting into.
- * @to: Pointer to the epoll to be inserted.
+ * @ctx: Per-CTL_ADD scratch context.
+ * @ep:  Pointer to the epoll we are inserting into.
+ * @to:  Pointer to the epoll to be inserted.
  *
  * Return: %zero if adding the epoll @to inside the epoll @from
  * does not violate the constraints, or %-1 otherwise.
  */
-static int ep_loop_check(struct eventpoll *ep, struct eventpoll *to)
+static int ep_loop_check(struct ep_ctl_ctx *ctx, struct eventpoll *ep,
+			 struct eventpoll *to)
 {
 	int depth, upwards_depth;
 
-	inserting_into = ep;
+	ctx->inserting_into = ep;
 	/*
 	 * Check how deep down we can get from @to, and whether it is possible
 	 * to loop up to @ep.
 	 */
-	depth = ep_loop_check_proc(to, 0);
+	depth = ep_loop_check_proc(ctx, to, 0);
 	if (depth > EP_MAX_NESTS)
 		return -1;
 	/* Check how far up we can go from @ep. */
@@ -2426,12 +2451,12 @@ static int ep_loop_check(struct eventpoll *ep, struct eventpoll *to)
 	return (depth+1+upwards_depth > EP_MAX_NESTS) ? -1 : 0;
 }
 
-static void clear_tfile_check_list(void)
+static void clear_tfile_check_list(struct ep_ctl_ctx *ctx)
 {
 	rcu_read_lock();
-	while (tfile_check_list != EP_UNACTIVE_PTR) {
-		struct epitems_head *head = tfile_check_list;
-		tfile_check_list = head->next;
+	while (ctx->tfile_check_list) {
+		struct epitems_head *head = ctx->tfile_check_list;
+		ctx->tfile_check_list = head->next;
 		unlist_file(head);
 	}
 	rcu_read_unlock();
@@ -2529,9 +2554,8 @@ static inline int epoll_mutex_lock(struct mutex *mutex, bool nonblock)
  * EPOLL_CTL_ADDs on different eps from building a cycle without
  * either walker observing it.
  */
-static int ep_ctl_lock(struct eventpoll *ep, int op,
-		       struct file *epfile, struct file *tfile,
-		       bool nonblock)
+static int ep_ctl_lock(struct ep_ctl_ctx *ctx, struct eventpoll *ep, int op,
+		       struct file *epfile, struct file *tfile, bool nonblock)
 {
 	struct eventpoll *tep;
 	int error;
@@ -2556,7 +2580,7 @@ static int ep_ctl_lock(struct eventpoll *ep, int op,
 
 	if (is_file_epoll(tfile)) {
 		tep = tfile->private_data;
-		if (ep_loop_check(ep, tep) != 0) {
+		if (ep_loop_check(ctx, ep, tep) != 0) {
 			error = -ELOOP;
 			goto err_unlock_nested;
 		}
@@ -2569,17 +2593,18 @@ static int ep_ctl_lock(struct eventpoll *ep, int op,
 	return 1;
 
 err_unlock_nested:
-	clear_tfile_check_list();
+	clear_tfile_check_list(ctx);
 	loop_check_gen++;
 	mutex_unlock(&epnested_mutex);
 	return error;
 }
 
-static void ep_ctl_unlock(struct eventpoll *ep, int full_check)
+static void ep_ctl_unlock(struct ep_ctl_ctx *ctx, struct eventpoll *ep,
+			  int full_check)
 {
 	mutex_unlock(&ep->mtx);
 	if (full_check) {
-		clear_tfile_check_list();
+		clear_tfile_check_list(ctx);
 		loop_check_gen++;
 		mutex_unlock(&epnested_mutex);
 	}
@@ -2592,6 +2617,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	int full_check;
 	struct eventpoll *ep;
 	struct epitem *epi;
+	struct ep_ctl_ctx ctx = { };
 
 	CLASS(fd, f)(epfd);
 	if (fd_empty(f))
@@ -2632,7 +2658,8 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 
 	ep = fd_file(f)->private_data;
 
-	full_check = ep_ctl_lock(ep, op, fd_file(f), fd_file(tf), nonblock);
+	full_check = ep_ctl_lock(&ctx, ep, op, fd_file(f), fd_file(tf),
+				 nonblock);
 	if (full_check < 0)
 		return full_check;
 
@@ -2647,7 +2674,8 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 	case EPOLL_CTL_ADD:
 		if (!epi) {
 			epds->events |= EPOLLERR | EPOLLHUP;
-			error = ep_insert(ep, epds, fd_file(tf), fd, full_check);
+			error = ep_insert(&ctx, ep, epds, fd_file(tf), fd,
+					  full_check);
 		} else
 			error = -EEXIST;
 		break;
@@ -2674,7 +2702,7 @@ int do_epoll_ctl(int epfd, int op, int fd, struct epoll_event *epds,
 		break;
 	}
 
-	ep_ctl_unlock(ep, full_check);
+	ep_ctl_unlock(&ctx, ep, full_check);
 	return error;
 }
 

-- 
2.47.3

