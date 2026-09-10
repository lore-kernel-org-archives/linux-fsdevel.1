Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6083B4AB1B8
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055333; cv=none; b=ddQq4RSjt5YojE5D691kaqGosJBjk9Xvpb91D36MP3SJlfsKe1KgmvhGWC1tupZ91s85JkzLZfjiYe8Zvt62T431y2WF/KNu13nSs2MDAOyKSMlNRUC0qxFKA2PaRdkbukjnv18NCrOqSR33qLfpfpbx0GGdmQNNqenqO3yBD7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055333; c=relaxed/simple;
	bh=HrHy8izOfLJ5Jed/wHU00vWuP/P/1gkKhU2KYgxfVEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RR9rjqZsWAHiLSFvb0VMgctR2o2XOC8N4XRHPCnFWNj0Q/A1S9yWS8RcKchxfJnx19rbCUTokKNHPC80bB4HHapjSl4ejlKjxqlZtz51MUGtf3J7AqCb8+Ks9GLEW8q5tpA2AqmuBi2wHy+1ScMF0yOwRpkVtDLIHN/SUjUTJqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ro0Ko+KO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ro0Ko+KO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD961F000FF;
	Thu, 10 Sep 2026 15:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055332;
	bh=wMFQLmYNmllLIQdcCiltC7X8q4jJ/4wnlqRpZP+uBqk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ro0Ko+KOt5kUw9p9eJlXhiP+85Mz5OSziB/Eq2UY1OaOxV4wKffzv29cjV3M6FMxx
	 hpyVaUuHQp0EgwutdZavjT2JsY8p8fapNXGGztxC7PoqkfBrq7+HsKTgsel3WTPtFa
	 YZDaItTETuPe9chOqTzrcSr6N9GjP6vAfqhQFslQCPdYHusXiDbOfEJ2hjzoyq7Kkj
	 Rg2INttq/DQ+bCKA+8x9Dm29FmGmYo09wSj0P5x16LESOoHhPCbHN36tiZmsQu2tup
	 SP/fl8jsN6ifU69xSTi6Imq6ofulZhmWpAsxYPFHbgqAHR/Kouthp9TaxsZbsxTwO1
	 n+RFGK1+zuHlA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 10 Sep 2026 17:48:10 +0200
Subject: [PATCH RFC v4 12/18] coredump: replace the startup completion with
 a thread count
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-work-coredump-unlock-self-v4-12-a5c1800dc930@kernel.org>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
In-Reply-To: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 NeilBrown <neilb@ownmail.net>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4047; i=brauner@kernel.org;
 h=from:subject:message-id; bh=HrHy8izOfLJ5Jed/wHU00vWuP/P/1gkKhU2KYgxfVEo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtumi3+dqc1sqFB3ZJPfD+yPpx9cOHh5akFj3etpxPw
 nHZDrmFpztKWRjEuBhkxRRZHNpNwuWW81RsNsrUgJnDygQyhIGLUwAm4rOEkWFCaV60rKria9G0
 rZnTbJsM/eQFugSEdY2cr7YX5DjUiDAy/AusiWmYp/a1JuXvMcNpqzZ+sjyxbYbDod7cbL6cR9r
 crAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

coredump_wait() sets core_state->nr_threads to the number of tasks
killed and waits for the last thread to enter coredump_task_exit() to
signal completion. Let's just wait on the count directly. The exiting
tasks can use atomic_dec_and_wake_up() and the dumping task sleeps in
wait_var_event_state().

The dumping task must remain freezable since commit f5d39b020809
("freezer,sched: Rewrite core freezer logic"). So keep the wait
TASK_UNINTERRUPTIBLE|TASK_FREEZABLE.

Drop the completion and rename nr_threads to threads_remaining.

No functional changes.

Suggested-by: NeilBrown <neilb@ownmail.net>
Link: https://lore.kernel.org/178899497961.207413.10554121774377911612@noble.neil.brown.name
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c                | 9 +++++----
 include/linux/sched/signal.h | 4 ++--
 kernel/exit.c                | 6 +++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 16d3fb54500b..2e2005c14d93 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -39,6 +39,7 @@
 #include <linux/oom.h>
 #include <linux/compat.h>
 #include <linux/fs.h>
+#include <linux/wait_bit.h>
 #include <linux/path.h>
 #include <linux/timekeeping.h>
 #include <linux/sysctl.h>
@@ -512,7 +513,7 @@ static int zap_threads(struct task_struct *tsk,
 		nr = zap_process(signal, exit_code);
 		clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
 		tsk->flags |= PF_DUMPCORE;
-		atomic_set(&core_state->nr_threads, nr);
+		atomic_set(&core_state->threads_remaining, nr);
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
 	return nr;
@@ -523,15 +524,15 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 	struct task_struct *tsk = current;
 	int core_waiters = -EBUSY;
 
-	init_completion(&core_state->startup);
 	core_state->tasks = NULL;
 
 	core_waiters = zap_threads(tsk, core_state, exit_code);
 	if (core_waiters > 0) {
 		struct core_thread *ptr;
 
-		wait_for_completion_state(&core_state->startup,
-					  TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
+		wait_var_event_state(&core_state->threads_remaining,
+				     !atomic_read_acquire(&core_state->threads_remaining),
+				     TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
 		/*
 		 * Wait for all the threads to become inactive, so that
 		 * all the thread context (extended register state, like
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 14b55d00d605..e039e29cd8c5 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -79,9 +79,9 @@ struct core_thread {
 };
 
 struct core_state {
-	atomic_t nr_threads;
+	/* Threads the dumper still waits for. */
+	atomic_t threads_remaining;
 	struct core_thread *tasks;
-	struct completion startup;
 };
 
 /*
diff --git a/kernel/exit.c b/kernel/exit.c
index 3df1fffc6674..55dbea3b242e 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/capability.h>
 #include <linux/completion.h>
+#include <linux/wait_bit.h>
 #include <linux/personality.h>
 #include <linux/tty.h>
 #include <linux/iocontext.h>
@@ -442,8 +443,7 @@ static void coredump_task_exit(struct task_struct *tsk,
 	 * Implies mb(), the result of xchg() must be visible
 	 * to the dumper.
 	 */
-	if (atomic_dec_and_test(&core_state->nr_threads))
-		complete(&core_state->startup);
+	atomic_dec_and_wake_up(&core_state->threads_remaining);
 
 	for (;;) {
 		set_current_state(TASK_IDLE|TASK_FREEZABLE);
@@ -917,7 +917,7 @@ static void synchronize_group_exit(struct task_struct *tsk, long code)
 	 * Serialize with any possible pending coredump.
 	 * We must hold siglock around checking core_state
 	 * and setting PF_POSTCOREDUMP.  The core-inducing thread
-	 * will increment ->nr_threads for each thread in the
+	 * will increment ->threads_remaining for each thread in the
 	 * group without PF_POSTCOREDUMP set.
 	 */
 	tsk->flags |= PF_POSTCOREDUMP;

-- 
2.53.0

