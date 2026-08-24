Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF2643F081
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585327; cv=none; b=XM1sK/jOCCp+Qv9rjB/aQq0VGIedQ0odz5DNjGkHpZ4N39gy6rC9niMMyvOhvjFBN+89Kmdj2N1VY0u3X9GUTZyorMakkvuqoXPowtD4T/45ZEJtXnf/sGNvTNd5CxVI3QGfqXX+V2dS662Dh0I6LinSKKWnfEK0YbHKZRn9o1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585327; c=relaxed/simple;
	bh=zT1gJ7cviR7qBKxVdd+XmP1xYFDIdht2GipRbicL8sY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=esZkEzXby2wnoDsu8wl6+uAHulJPul6/jetra6sl4G3hjvdZgt2wnuNvi8PhMbzpn1DBqZUTGUh/OIcAUDTHvHcyJw3+CR9oAuFNeogcTBDXIrpmXLNeXql/zTdHaIw2AspNzvWfsDjb8wVEAPMxjyXhnhQZ/4hyFxUeVJbzJAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OT9NicPz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OT9NicPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FCF1F00A3A;
	Mon, 24 Aug 2026 15:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787585321;
	bh=KNOOvKBw7QxpOnXSeUBNOoMGvEHRcJ2wtMHAJ8Xhuq8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OT9NicPznjuZ0EXyXHnKzkRyifQTkEb9OitB7Ju71EZmsqXaLYojgRX7Gzgbiniye
	 sksDVnxQZ1Ws80hPnomVcvD/7lh4hDdxhmp/5MxHdgDaSt5cJ1hsqCCe2IDDGYyDhS
	 DNCJFcz02SnQ2DSffuHEkQGiAtR5PTQQhJHMi6NOxN3nE/wdnL0/bxzcgox+qvA9Bd
	 ZDEaZwUlmJgv43lWUd5i6sAGF+qsM9hecxjkMYrYUSOeHFyuycAD8mBMczBof3V5oL
	 42jQl9tOCdXliA6iPiTRFftWgrX9qyzquuUstzreG1IXE2/vUDKuAAcW7eDDFgOj+P
	 YYGMtU8u5f7zQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 24 Aug 2026 17:28:19 +0200
Subject: [PATCH RFC 5/7] coredump: add COREDUMP_CLOSE_FILES
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-work-coredump-unlock-self-v1-5-48fd1cca7eda@kernel.org>
References: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
In-Reply-To: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9526; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zT1gJ7cviR7qBKxVdd+XmP1xYFDIdht2GipRbicL8sY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT1JEslz7U9yRAcea1kDTfnlmLWn+9OrCqY8nn+cZnJ8
 o+8F2RldJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk0m6G/znxR9bXZmae+ZJ4
 T2HxC8HHd09xvfw1KzudZeHbCf8/VixjZHgnsnFltVSX7/oU/StaQR4vfFoit3+ZWix27nPFzqp
 VwowA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add COREDUMP_CLOSE_FILES extension that allows a coredump server to
request that the thread-group close all files before generating the
coredump.

There have been several attempts to let the dumping process decide
through a new fcntl() flag, a new procfs file or a new coredump_filter
bit that its descriptors go away early. That's just broken imho.

Tools like systemd-coredump walk /proc/<pid>/fd and /proc/<pid>/fdinfo
and some use pidfd_getfd() to preserve files of the crashing process.
Only the coredump server knows whether it still needs the descriptors.

So let the coredump server ask for it. Add a new COREDUMP_CLOSE_FILES
feature bit. If the coredump server raises it the kernel drops the
descriptor tables of the thread group right after the handshake and
before it generates the coredump.

COREDUMP_CLOSE_FILES doesn't work with COREDUMP_REJECT. A rejected task
exits and closes everything right away anyway.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c                 | 14 +++++++-
 fs/file.c                     | 81 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/fdtable.h       |  5 +++
 include/linux/sched/signal.h  |  4 ++-
 include/uapi/linux/coredump.h |  8 +++++
 kernel/exit.c                 |  5 +++
 6 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 27d9cdc77cec..a6e7da0bc16a 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -837,7 +837,8 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 		.mask			= COREDUMP_KERNEL | COREDUMP_USERSPACE |
 					  COREDUMP_REJECT | COREDUMP_WAIT |
 					  COREDUMP_RECORDS | COREDUMP_SPARSE |
-					  COREDUMP_MEMORY_TYPES,
+					  COREDUMP_MEMORY_TYPES |
+					  COREDUMP_CLOSE_FILES,
 		.size_ack		= sizeof(struct coredump_ack),
 		.memory_types		= cprm->memory_types,
 		.memory_types_mask	= COREDUMP_MEMORY_ALL,
@@ -905,6 +906,12 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 		return false;
 	}
 
+	/* A rejected task exits right away and closes everything anyway. */
+	if ((ack.mask & COREDUMP_CLOSE_FILES) && (ack.mask & COREDUMP_REJECT)) {
+		coredump_sock_mark(cprm->file, COREDUMP_MARK_CONFLICTING);
+		return false;
+	}
+
 	if (ack.mask & COREDUMP_MEMORY_TYPES) {
 		/* The memory types need the whole field. */
 		if (usize < COREDUMP_ACK_SIZE_VER1) {
@@ -1225,6 +1232,11 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
 	if (cprm->mask & COREDUMP_REJECT)
 		return;
 
+	if ((cprm->mask & COREDUMP_CLOSE_FILES) && !coredump_close_files()) {
+		coredump_report_failure("Failed to close files, aborting core");
+		return;
+	}
+
 	/* get us an unshared descriptor table; almost always a no-op */
 	/* The cell spufs coredump code reads the file descriptor tables */
 	if (unshare_files())
diff --git a/fs/file.c b/fs/file.c
index 391b6d4292c4..3b8fce6e3695 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -401,6 +401,19 @@ static struct files_struct *alloc_files(gfp_t gfp)
 	return newf;
 }
 
+/* An empty descriptor table with one reference. */
+static struct files_struct *alloc_files_struct(void)
+{
+	struct files_struct *newf;
+
+	newf = alloc_files(GFP_KERNEL | __GFP_ZERO);
+	if (!newf)
+		return NULL;
+
+	rcu_assign_pointer(newf->fdt, &newf->fdtab);
+	return newf;
+}
+
 /*
  * Allocate a new descriptor table and copy contents from the passed in
  * instance.  Returns a pointer to cloned table on success, ERR_PTR()
@@ -562,6 +575,74 @@ void exit_files(struct task_struct *tsk)
 	switch_files_struct(tsk, NULL);
 }
 
+/*
+ * The thread-group is waiting in coredump_task_exit(). Wake them and
+ * tell them to get rid of their files.
+ */
+bool coredump_close_files(void)
+{
+	struct core_state *core_state = current->signal->core_state;
+	struct files_struct *files;
+	struct core_thread *ct;
+	int nr = 0;
+
+	files = alloc_files_struct();
+	if (!files)
+		return false;
+
+	/* Tasks without a table, vhost workers say, sit the switch out. */
+	for (ct = core_state->dumper.next; ct; ct = ct->next)
+		if (ct->task->files)
+			nr++;
+	atomic_set(&core_state->nr_threads, nr);
+	reinit_completion(&core_state->done);
+
+	for (ct = core_state->dumper.next; ct; ct = ct->next) {
+		if (!ct->task->files)
+			continue;
+		/* Pairs with the acquire in coredump_task_close_files(). */
+		smp_store_release(&ct->files, files);
+		wake_up_process(ct->task);
+	}
+
+	/* The dumper's subjective creds are the dump's, not its own. */
+	scoped_with_creds(current_real_cred())
+		switch_files_struct(current, files);
+
+	if (nr) {
+		wait_for_completion_state(&core_state->done,
+					  TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
+		/* Back asleep before the notes read their registers. */
+		for (ct = core_state->dumper.next; ct; ct = ct->next)
+			wait_task_inactive(ct->task, TASK_ANY);
+	}
+
+	put_files_struct(files);
+	return true;
+}
+
+/*
+ * Get rid of the files and switch to the empty file descriptor table
+ * the dumping thread published in this thread's core_thread entry.
+ */
+bool coredump_task_close_files(struct core_thread *self)
+{
+	struct core_state *core_state;
+	struct files_struct *files;
+
+	/* Pairs with the release in coredump_close_files(). */
+	files = smp_load_acquire(&self->files);
+	if (!files || !current->files || current->files == files)
+		return false;
+
+	__set_current_state(TASK_RUNNING);
+	switch_files_struct(current, files);
+	core_state = current->signal->core_state;
+	if (atomic_dec_and_test(&core_state->nr_threads))
+		complete(&core_state->done);
+	return true;
+}
+
 struct files_struct init_files = {
 	.count		= ATOMIC_INIT(1),
 	.fdt		= &init_files.fdtab,
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index c45306a9f007..f0c1003da8ce 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -99,11 +99,16 @@ static inline bool close_on_exec(unsigned int fd, const struct files_struct *fil
 
 struct task_struct;
 
+struct core_thread;
+
 void put_files_struct(struct files_struct *fs);
+bool coredump_close_files(void);
+bool coredump_task_close_files(struct core_thread *self);
 int unshare_files(void);
 struct fd_range {
 	unsigned int from, to;
 };
+
 struct files_struct *dup_fd(struct files_struct *, struct fd_range *) __latent_entropy;
 void do_close_on_exec(struct files_struct *);
 int iterate_fd(struct files_struct *, unsigned,
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index ed9e2d49d166..fed02a427de3 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -76,12 +76,14 @@ struct multiprocess_signals {
 struct core_thread {
 	struct task_struct *task;
 	struct core_thread *next;
+	/* The empty table to switch to, published by the dumping thread. */
+	struct files_struct *files;
 };
 
 struct core_state {
 	atomic_t nr_threads;
 	struct core_thread dumper;
-	/* Completed by the last thread to park. */
+	/* Completed by the last thread to park, reused for the table switch. */
 	struct completion done;
 };
 
diff --git a/include/uapi/linux/coredump.h b/include/uapi/linux/coredump.h
index 6d0c53b534ea..ec09d7ab0131 100644
--- a/include/uapi/linux/coredump.h
+++ b/include/uapi/linux/coredump.h
@@ -19,6 +19,9 @@
  * @COREDUMP_MEMORY_TYPES: dump the memory types in
  *                          coredump_ack->memory_types instead of the ones
  *                          the task selected; requires COREDUMP_KERNEL
+ * @COREDUMP_CLOSE_FILES: close all file descriptors of the task before the
+ *                        coredump is generated; incompatible with
+ *                        COREDUMP_REJECT
  */
 enum {
 	COREDUMP_KERNEL		= (1ULL << 0),
@@ -28,6 +31,7 @@ enum {
 	COREDUMP_RECORDS	= (1ULL << 4),
 	COREDUMP_SPARSE		= (1ULL << 5),
 	COREDUMP_MEMORY_TYPES	= (1ULL << 6),
+	COREDUMP_CLOSE_FILES	= (1ULL << 7),
 };
 
 /**
@@ -137,6 +141,10 @@ enum {
  * Note that @memory_types must be zero if COREDUMP_MEMORY_TYPES isn't
  * raised. COREDUMP_MEMORY_TYPES requires COREDUMP_KERNEL and an ack of
  * at least COREDUMP_ACK_SIZE_VER1 bytes.
+ *
+ * If COREDUMP_CLOSE_FILES is raised in @mask the kernel closes the file
+ * descriptors of the coredumping task before it generates the coredump.
+ * The task ends up with an empty descriptor table.
  */
 struct coredump_ack {
 	__u32 size;
diff --git a/kernel/exit.c b/kernel/exit.c
index b535bc1ed68d..b651679c12e9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -25,6 +25,7 @@
 #include <linux/acct.h>
 #include <linux/tsacct_kern.h>
 #include <linux/file.h>
+#include <linux/fdtable.h>
 #include <linux/freezer.h>
 #include <linux/binfmts.h>
 #include <linux/nsproxy.h>
@@ -432,6 +433,7 @@ static void coredump_task_exit(struct task_struct *tsk,
 	struct core_thread self;
 
 	self.task = tsk;
+	self.files = NULL;
 	if (self.task->flags & PF_SIGNALED)
 		self.next = xchg(&core_state->dumper.next, &self);
 	else
@@ -447,6 +449,9 @@ static void coredump_task_exit(struct task_struct *tsk,
 		set_current_state(TASK_IDLE|TASK_FREEZABLE);
 		if (!self.task) /* see coredump_finish() */
 			break;
+		/* see coredump_close_files() */
+		if (coredump_task_close_files(&self))
+			continue;
 		schedule();
 	}
 	__set_current_state(TASK_RUNNING);

-- 
2.53.0

