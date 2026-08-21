Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B4247F771;
	Fri, 21 Aug 2026 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310204; cv=none; b=kSUIt+nxplCWAF/OXt8KCby+hWHBSK9kxAORXD29w66xVgH9siSCms9TlD0GcICAjjbUnmX5YpOIHi6rqs4vZ3kAiJd/mpzemYASpe3yXjHTm10a3t9yuMp/OUFOTH4TyLDe4XYoudYo4seTPFhxdO1skoPgMoLNS2J3uzV/vU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310204; c=relaxed/simple;
	bh=MsNsLMCJonNE7cU5looYNRkB89p6xz88kx/87/IJPf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eE0MmghIcEXFYdKTwDNULLisa5pBuG6EP+6wk5HgHe81X1F39bCL3EJCuzsiam8zI46y3qhwjYtc0RB1tO4KdWTTT7tAUaygahmrgJwrBY3ukR8bdnXgV37UJLF8Qz+RYLfo9loMtg6ua+rlIx5ok1Dd2jHxPNzVwKe6eEqkMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eHW02rPT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eHW02rPT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xpQjT28tzzX3gaMhZatoiTxe4JPXBO9hKYwXGrXb2VA=; b=eHW02rPT9ZE5BxuhJ0nPcfMJ+4
	rwN2PM5QnN4CV8YsOb1NVV82TR/ptXsu4+luBJ+eCQbm50M7lUvVZaHQiNvFbQj0UmOupARK4bFly
	jGodyMjyILd/InA3AzSqGm5OcTYD82iVjJLOVOZs38ROUiPi8bEJz5WsKmbdUtBPHXeEPnrq76MO7
	6X/4MOoUwDSgH563t1elSrlKcR7SlcRXr1YsnhTSYwB6k724ApdP1NCQqZYvbEJPkY/YzsbEAcdd0
	gd2FAUZb3SfNaiu0ImUNnfKnSz472UoCC8PdIVywNYwIIndCVe1TLhc8/DVPD9jQqUe3Ln9CeInlk
	EaekfOqA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxN1n-0000000HH3L-1itP;
	Fri, 21 Aug 2026 11:03:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 331473006FA; Fri, 21 Aug 2026 13:03:14 +0200 (CEST)
Date: Fri, 21 Aug 2026 13:03:14 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: permit freezing while waiting for request answer
Message-ID: <20260821110314.GK788244@noisy.programming.kicks-ass.net>
References: <CAJfpegu2wOG85R6KSvCwHOuxe2fWczA1KbrFcCZz=ofUch4K=w@mail.gmail.com>
 <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
 <aobDGgivy43cz7xQ@google.com>
 <20260820091018.GA4120091@noisy.programming.kicks-ass.net>
 <aobGRjc7SE1rwIHu@google.com>
 <20260820093402.GB1837346@noisy.programming.kicks-ass.net>
 <aobKfyGHkdMcleoc@google.com>
 <20260820104111.GC1837346@noisy.programming.kicks-ass.net>
 <CAJfpegsSzOqs1zkhB9GZxsT5HT1zXDbHsZNEbA7P7mxe0w2dng@mail.gmail.com>
 <20260821083000.GF687043@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821083000.GF687043@noisy.programming.kicks-ass.net>

On Fri, Aug 21, 2026 at 10:30:00AM +0200, Peter Zijlstra wrote:

> Another approach might be to have each task have a list of tasks that
> needs to be done later, and have this relation be counted in the
> destination task.
> 
> Then, on freeze, create a list of all tasks and start iteration, for
> each task that has a non-zero count of prior tasks, move it to the tail.
> This relies on freeze points being a location where a task has no
> relations. Such that when a task is frozen, it has no dependencies.
> 
> Then, again assuming it was a non-cyclic graph, it will always finish
> the freeze in an order that resolves the dependencies.
> 
> This might be a little more tricky to implement, but should be doable.
> 
> In both scenarios the tracking of the actual dependencies is of course
> going to be key.
> 
> One way would be for each file op to be wrapped like 'link-$op-unlink'
> such that the client (the task doing the file op) gets linked to the
> server (the task responsible for satisfying the request) before it can
> block, and unlinked once its done.
> 
> Link/unlink could be a simple as:
> 
> 	struct task_struct *client, *server;
> 
> link;
> 	atomic_inc(&server->freezer_count);
> 	client->freezer_link = server;
> 
> unlink:
> 
> 	atomic_dec(&client->freezer_link->freezer_count);
> 	client->freezer_link = NULL;
> 
> And the freezer should assert: !task->freezer_link, to ensure you
> cannot be frozen while still having a link out, since this would keep
> the link target's count elevated and inhibit freezer forever more.
> 
> This also deals with the server being a client of yet another fuse
> filesystem. Creating cycles in fuse mounts would already be a recipe
> for disaster today, without all this, so I'm assuming this all just
> 'works'.

Something like so; this is a very rough draft and only supports a single
dependent task -- if you need more (eg. threaded fuse server where there
isn't a convenient 1:1 relation) it needs a little more.

But I'm hoping the idea is clear.

---
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 193a4a4dcc27..5c0cf42b4827 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1670,6 +1670,12 @@ struct task_struct {
 	struct unwind_task_info		unwind_info;
 #endif
 
+#ifdef CONFIG_FREEZER
+	struct list_head		freezer_node;
+	struct task_struct		*freezer_link;
+	atomic_t			freezer_count;
+#endif
+
 	/* CPU-specific state of this task: */
 	struct thread_struct		thread;
 
@@ -1693,6 +1699,35 @@ static inline bool sched_proxy_exec(void)
 }
 #endif
 
+#ifdef CONFIG_FREEZER
+extern struct task_struct init_task;
+static inline void init_task_freezer_link(struct task_struct *p)
+{
+	list_add_tail(&p->freezer_node, &init_task.freezer_node);
+}
+static inline void init_task_freezer_unlink(struct task_struct *p)
+{
+	list_del(&p->freezer_node);
+}
+static inline void freezer_link(struct task_struct *server)
+{
+	WARN_ON_ONCE(current->freezer_link);
+	current->freezer_link = server;
+	atomic_inc(&server->freezer_count);
+}
+static inline void freezer_unlink(struct task_struct *server)
+{
+	WARN_ON_ONCE(current->freezer_link != server);
+	current->freezer_link = NULL;
+	atomic_dec(&server->freezer_count);
+}
+#else
+static inline void init_task_freezer_link(struct task_struct *p) { }
+static inline void init_task_freezer_unlink(struct task_struct *p) { }
+static inline void freezer_link(struct task_struct *server) { }
+static inline void freezer_unlink(struct task_struct *server) { }
+#endif
+
 #define TASK_REPORT_IDLE	(TASK_REPORT + 1)
 #define TASK_REPORT_MAX		(TASK_REPORT_IDLE << 1)
 
diff --git a/init/init_task.c b/init/init_task.c
index ba5c2523f7e0..643598217335 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -266,6 +266,9 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 #ifdef CONFIG_SCHED_MM_CID
 	.mm_cid		= { .cid = MM_CID_UNSET, },
 #endif
+#ifdef CONFIG_FREEZER
+	.freezer_node	= LIST_HEAD_INIT(init_task.freezer_node),
+#endif
 };
 EXPORT_SYMBOL(init_task);
 
diff --git a/kernel/exit.c b/kernel/exit.c
index e9f902be4ea6..22d9800656f1 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -291,6 +291,8 @@ void release_task(struct task_struct *p)
 			leader->exit_state = EXIT_DEAD;
 	}
 
+	init_task_freezer_unlink(p);
+
 	write_unlock_irq(&tasklist_lock);
 	/* @thread_pid can't go away until free_pids() below */
 	proc_flush_pid(thread_pid);
diff --git a/kernel/fork.c b/kernel/fork.c
index e645675dd727..86b4f30c9370 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2506,6 +2506,7 @@ __latent_entropy struct task_struct *copy_process(
 		task_set_no_new_privs(p);
 
 	init_task_pid_links(p);
+	init_task_freezer_link(p);
 	if (likely(p->pid)) {
 		ptrace_init_task(p, (clone_flags & CLONE_PTRACE) || trace);
 
diff --git a/kernel/freezer.c b/kernel/freezer.c
index a76bf957fb32..46838be512f1 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -135,8 +135,10 @@ static int __set_task_frozen(struct task_struct *p, void *arg)
 	/*
 	 * It's dangerous to freeze with locks held; there be dragons there.
 	 */
-	if (!(state & __TASK_FREEZABLE_UNSAFE))
+	if (!(state & __TASK_FREEZABLE_UNSAFE)) {
 		WARN_ON_ONCE(debug_locks && p->lockdep_depth);
+		WARN_ON_ONCE(p->freezer_link);
+	}
 #endif
 
 	p->saved_state = p->__state;
diff --git a/kernel/power/process.c b/kernel/power/process.c
index dc0dfc349f22..454b02f00ec8 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -29,7 +29,7 @@ static int try_to_freeze_tasks(bool user_only)
 {
 	const char *what = user_only ? "user space processes" :
 					"remaining freezable tasks";
-	struct task_struct *g, *p;
+	struct task_struct *g, *p, *stop;
 	unsigned long end_time;
 	unsigned int todo;
 	bool wq_busy = false;
@@ -49,9 +49,52 @@ static int try_to_freeze_tasks(bool user_only)
 
 	while (true) {
 		todo = 0;
+		stop = NULL;
 		read_lock(&tasklist_lock);
-		for_each_process_thread(g, p) {
-			if (p == current || !freeze_task(p))
+		list_for_each_entry_safe(p, g, &init_task.freezer_node, freezer_node) {
+			/*
+			 * The head of the list will be the already frozen
+			 * tasks, skip those.
+			 */
+			if (p == current || frozen(p))
+				continue;
+
+			/*
+			 * If the task has dependencies; move it to the tail.
+			 * This is safe under read-tasklist_lock, because that
+			 * excludes clone/exit and is otherwise serialized by
+			 * the freezer -- you can't have multiple freezer
+			 * instances.
+			 */
+			if (atomic_read(&p->freezer_count)) {
+				/*
+				 * @stop tracks the 'first' task with
+				 * dependencies that is moved to the tail; if
+				 * we encounter it again while also having
+				 * failed to freeze previous tasks, we must
+				 * stop.
+				 */
+				if (p == stop && todo)
+					break;
+
+				if (!stop)
+					stop = p;
+
+				list_move_tail(&p->freezer_node, &init_task.freezer_node);
+				continue;
+			}
+
+			/*
+			 * The @stop task was previously observed to have
+			 * non-zero freezer_count, however all its
+			 * dependencies went away (got frozen) and it can be
+			 * frozen now. Clear it as a stop marker such that a
+			 * new marker can be picked.
+			 */
+			if (p == stop)
+				stop = NULL;
+
+			if (!freeze_task(p))
 				continue;
 
 			todo++;
