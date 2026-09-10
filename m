Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C54B2CBB
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055344; cv=none; b=Thd9tn7PL+q7cvwHfpOjoP0dkmiEv3Wx1HggRlhzHJ1lSMHWgD41+T/jB4F4TGSlK/TedhugTM+Fj8UBo7TOKw2wRJLdwnexvWKMV870lwQGAdPzZpWdEuz0Xt69QjXPids2r1qeveu8h4cz/E4zvQMYygMXOVZy3SYmbIBQDSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055344; c=relaxed/simple;
	bh=U0JYCUxI5fxrnr4+CzwipnG/dfqOXiGkWBQpoltd+ys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hj5+PaPYrTVVobf/Qyd6OvTCfbcBbYsoKBE3WHoTDOaI0WXhGenMtUC8995o+IjFIrtJhCyFVv2kF4ic1bt0Lgd346U2oA5pDskkmFCR9qCGt/m1k8ulekG9iLtGzV+4i1iynwExi0g+gX1Epsmtq811PVbMdkxTldmjWGyoCsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwrM3Dqi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwrM3Dqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7321F00898;
	Thu, 10 Sep 2026 15:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055340;
	bh=dVl7LtZeSzn1TG39JtuF7mV+CUht6C2bHGVmGrjvOZ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lwrM3DqiUTBHhvI9cH2/bx0o7iR/hDbsDKcicrGwqYhG21oXYIFjK4c6L7aJUvf7c
	 friOXlHXOg6IHMiOwsZu9eJ2vcJEnDiHS+KwGrLiST9Om62phcPpTMoWr0i2QTorcL
	 S6mjSdrtyMIBD6IdX5KwFQ+gYDlKUS16W2QjTwiiuAWaUn14pH9trLkNI4tWI8m+2v
	 ZExcXphdgyHpEFRK32m9rKkWDsj58yaH6OnglwUrBHug0T2Ff4ShMGdMgRXZSKcyrJ
	 r2UOS2tmakPWvXtdnG2KkPAJmwVoBajYwILmRGaWgE/f5h0RRNc7cFd23UtP6wvo8S
	 kGYOg5UQTKNwg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 10 Sep 2026 17:48:13 +0200
Subject: [PATCH RFC v4 15/18] coredump: add COREDUMP_CLOSE_FILES
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-work-coredump-unlock-self-v4-15-a5c1800dc930@kernel.org>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
In-Reply-To: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=7485; i=brauner@kernel.org;
 h=from:subject:message-id; bh=U0JYCUxI5fxrnr4+CzwipnG/dfqOXiGkWBQpoltd+ys=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtumg3+8epN915W1w+pb88F7H46r8HFmpOMf/XS4VH7
 QnMvKRq0VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR9P8M/9Tkktw2SzjIXFbc
 UvRGkHvWok3scz6pP/5e7tM7reqmSxXDH47Z3H9fuE4PWxG53YPX5rTftK/nMnWitDMaD1w5ezt
 rESMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add COREDUMP_CLOSE_FILES and allow a coredump server to request that the
thread-group closes all files before creating the coredump.

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

We switch to an empty fdtable instead of simply clearing because
io_uring_files_cancel() runs task work in do_exit() before
exit_signals() sets PF_EXITING and may reissue requests that dereference
current->files.

The files are closed like close(2) would, PF_EXITING isn't set yet so
SO_LINGER sockets linger.

Reported-by: Xin Zhao <jackzxcui1989@163.com>
Link: https://lore.kernel.org/20260618030700.2511668-1-jackzxcui1989@163.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c                 | 47 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/sched/signal.h  |  2 ++
 include/uapi/linux/coredump.h |  8 ++++++++
 kernel/exit.c                 | 11 ++++++++--
 4 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index daeca723bdae..4ffd801aca01 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -549,6 +549,40 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 	return core_waiters;
 }
 
+/*
+ * Allocate a new empty fdtable and switch the whole thread-group to it.
+ * Put all the old fdtables freeing up resources and locks before writing the
+ * coredump.
+ */
+static bool coredump_close_files(struct core_state *core_state)
+{
+	struct files_struct *files;
+	struct core_thread *ct;
+
+	files = alloc_files_struct();
+	if (!files)
+		return false;
+
+	for (ct = core_state->tasks; ct; ct = ct->next) {
+		/* Tasks without a table such as vhost workers can be skipped. */
+		if (!ct->task->files)
+			continue;
+		atomic_inc(&core_state->threads_remaining);
+		/* ct->files holds a reference until the thread switches to it. */
+		atomic_inc(&files->count);
+		/* Pairs with the acquire in coredump_task_exit(). */
+		smp_store_release(&ct->files, files);
+		wake_up_process(ct->task);
+	}
+
+	/* Use the dumper's real creds not the overridden ones. */
+	scoped_with_creds(current_real_cred())
+		switch_files_struct(current, files);
+
+	coredump_wait_inactive(core_state);
+	return true;
+}
+
 static void coredump_finish(enum coredump_state state)
 {
 	struct core_thread *curr, *next;
@@ -838,7 +872,8 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 		.mask			= COREDUMP_KERNEL | COREDUMP_USERSPACE |
 					  COREDUMP_REJECT | COREDUMP_WAIT |
 					  COREDUMP_RECORDS | COREDUMP_SPARSE |
-					  COREDUMP_MEMORY_TYPES,
+					  COREDUMP_MEMORY_TYPES |
+					  COREDUMP_CLOSE_FILES,
 		.size_ack		= sizeof(struct coredump_ack),
 		.memory_types		= cprm->memory_types,
 		.memory_types_mask	= COREDUMP_MEMORY_ALL,
@@ -906,6 +941,12 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
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
@@ -1221,6 +1262,10 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
 	if (cprm->mask & COREDUMP_REJECT)
 		return;
 
+	if ((cprm->mask & COREDUMP_CLOSE_FILES) &&
+	    !coredump_close_files(current->signal->core_state))
+		return;
+
 	if ((cprm->mask & COREDUMP_KERNEL) && !coredump_write(cprm, binfmt))
 		return;
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index e039e29cd8c5..70067ccfe2ba 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -76,6 +76,8 @@ struct multiprocess_signals {
 struct core_thread {
 	struct task_struct *task;
 	struct core_thread *next;
+	/* The empty table to switch to, published by the dumping thread. */
+	struct files_struct *files;
 };
 
 struct core_state {
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
index 55dbea3b242e..04f2c8c78879 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -26,6 +26,7 @@
 #include <linux/acct.h>
 #include <linux/tsacct_kern.h>
 #include <linux/file.h>
+#include <linux/fdtable.h>
 #include <linux/freezer.h>
 #include <linux/binfmts.h>
 #include <linux/nsproxy.h>
@@ -432,9 +433,8 @@ kill_orphaned_pgrp(struct task_struct *tsk, struct task_struct *parent)
 static void coredump_task_exit(struct task_struct *tsk,
 			       struct core_state *core_state)
 {
-	struct core_thread self;
+	struct core_thread self = { .task = tsk };
 
-	self.task = tsk;
 	if (self.task->flags & PF_SIGNALED)
 		self.next = xchg(&core_state->tasks, &self);
 	else
@@ -449,6 +449,13 @@ static void coredump_task_exit(struct task_struct *tsk,
 		set_current_state(TASK_IDLE|TASK_FREEZABLE);
 		if (!self.task) /* see coredump_finish() */
 			break;
+		/* Pairs with the release in coredump_close_files(). */
+		if (smp_load_acquire(&self.files)) {
+			__set_current_state(TASK_RUNNING);
+			switch_files_struct(tsk, no_free_ptr(self.files));
+			atomic_dec_and_wake_up(&core_state->threads_remaining);
+			continue;
+		}
 		schedule();
 	}
 	__set_current_state(TASK_RUNNING);

-- 
2.53.0

