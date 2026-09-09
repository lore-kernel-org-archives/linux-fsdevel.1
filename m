Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE9847F78C
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 15:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969216; cv=none; b=dFS6/LKHDp3lvjR7utdOD2cHIyK9CN7aomV2M9OUC+h9YYELWAY4XXrXSDnYgXsa9ZM5roroHNxy7KxtfAu7ExRwe97N3LTU1vZ1muuufnDnHJrfi0Z2oeo15eGdDA74wfDGs50aLDHzhkrMg+MhlNn0rCL9v1bDMcUn9u6djtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969216; c=relaxed/simple;
	bh=I6IKMoycfiACzesB5L1tfIbwaiwsq2A/cMQrUAWd88U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AhbY1yVcdmTQVPSVdG/yVZaLhfbCmlUEZgHfI28nckQhwJaj98kzQIphyUK7evZFHxsoQCCcrO4aaFBuLrmYrVmvaziyXGCTFNnIgKFkOuAW79cIEtqVWY2V0SQWcBSqPU7EL5elgugupN2uqxAKn0ntvDq7ZoVWyaP+Yj06CTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFAwSENu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFAwSENu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA831F00A3A;
	Wed,  9 Sep 2026 15:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969214;
	bh=wxoW926qfLvVUGOu565kQbjh0sBCyBi3ebheUCCSHRQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OFAwSENuLxA/gdqlLGEqaetnpuXK7TxzXWb5FFGDhKollFQoZY7v3cDwrc0HMdC3H
	 K8Vq9/J96mSlFFM52YuyXddbt84fWoQWJTJrvkJwvBLSgnfOEcAYpbLIJwymVHoZD5
	 89UOP3L7j0rgXyDcS+7wOI5G+kR5I5vtJ5gHrdu1Lxp87H8lBJHQ8ZPu/QvubdsRLn
	 ESJbdRbghXggCRkPKdWCGrEl22KAukH4AHbKHY50/KBKujHsqc3x0SuXfm+1xVSyOt
	 Xmzc6650HOovRaOp0EU/TVkTRd1mLw6qM+xEuBINa3PrDCF1t1SdZ+oG/bVSBlM7qV
	 ds4LihVsZQt3A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 09 Sep 2026 17:52:56 +0200
Subject: [PATCH RFC v3 13/15] coredump: add COREDUMP_CLOSE_FILES
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-work-coredump-unlock-self-v3-13-04f907687563@kernel.org>
References: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
In-Reply-To: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=7871; i=brauner@kernel.org;
 h=from:subject:message-id; bh=I6IKMoycfiACzesB5L1tfIbwaiwsq2A/cMQrUAWd88U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtbLhqm/m0fML2vdz7AqekxDE5ny9jfX50jpSSkNK/P
 f2GX3dN6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIQC/DXwn/8JA623OPH/HJ
 3F89ca+WnLZD66x0ReV/zb9mXL7O6c3wP1RuWdP/XQrC2y3u7fi+I22W9JoXU5SCvpRuWmEgtOj
 xG0YA
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

Reported-by: Xin Zhao <jackzxcui1989@163.com>
Link: https://lore.kernel.org/20260618030700.2511668-1-jackzxcui1989@163.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c                 | 55 ++++++++++++++++++++++++++++++++++++++++++-
 include/linux/sched/signal.h  |  4 +++-
 include/uapi/linux/coredump.h |  8 +++++++
 kernel/exit.c                 | 13 ++++++++++
 4 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index d0796536e03f..506410132e30 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -552,6 +552,48 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
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
+	int nr = 0;
+
+	files = alloc_files_struct();
+	if (!files)
+		return false;
+
+	/* Tasks without a table such as vhost workers can be skipped. */
+	for (ct = core_state->dumper.next; ct; ct = ct->next)
+		if (ct->task->files)
+			nr++;
+	atomic_set(&core_state->nr_threads, nr);
+	reinit_completion(&core_state->done);
+
+	for (ct = core_state->dumper.next; ct; ct = ct->next) {
+		if (!ct->task->files)
+			continue;
+		/* ct->files holds a reference until the thread switches to it. */
+		atomic_inc(&files->count);
+		/* Pairs with the acquire in coredump_task_exit(). */
+		smp_store_release(&ct->files, files);
+		wake_up_process(ct->task);
+	}
+
+	/* Use the dumper's real creds not the overriden ones. */
+	scoped_with_creds(current_real_cred())
+		put_files_struct(switch_files_struct(current, files));
+
+	if (nr)
+		coredump_wait_inactive(core_state);
+
+	return true;
+}
+
 static void coredump_finish(enum coredump_state state)
 {
 	struct core_thread *curr, *next;
@@ -841,7 +883,8 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
 		.mask			= COREDUMP_KERNEL | COREDUMP_USERSPACE |
 					  COREDUMP_REJECT | COREDUMP_WAIT |
 					  COREDUMP_RECORDS | COREDUMP_SPARSE |
-					  COREDUMP_MEMORY_TYPES,
+					  COREDUMP_MEMORY_TYPES |
+					  COREDUMP_CLOSE_FILES,
 		.size_ack		= sizeof(struct coredump_ack),
 		.memory_types		= cprm->memory_types,
 		.memory_types_mask	= COREDUMP_MEMORY_ALL,
@@ -909,6 +952,12 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
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
@@ -1224,6 +1273,10 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
 	if (cprm->mask & COREDUMP_REJECT)
 		return;
 
+	if ((cprm->mask & COREDUMP_CLOSE_FILES) &&
+	    !coredump_close_files(current->signal->core_state))
+		return;
+
 	if ((cprm->mask & COREDUMP_KERNEL) && !coredump_write(cprm, binfmt))
 		return;
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 1c1e280a25a1..23bd841d7742 100644
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
index affee30bcbca..52e282df9e60 100644
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
@@ -431,9 +432,11 @@ kill_orphaned_pgrp(struct task_struct *tsk, struct task_struct *parent)
 static void coredump_task_exit(struct task_struct *tsk,
 			       struct core_state *core_state)
 {
+	struct files_struct *files;
 	struct core_thread self;
 
 	self.task = tsk;
+	self.files = NULL;
 	if (self.task->flags & PF_SIGNALED)
 		self.next = xchg(&core_state->dumper.next, &self);
 	else
@@ -449,6 +452,16 @@ static void coredump_task_exit(struct task_struct *tsk,
 		set_current_state(TASK_IDLE|TASK_FREEZABLE);
 		if (!self.task) /* see coredump_finish() */
 			break;
+		/* Pairs with the release in coredump_close_files(). */
+		files = smp_load_acquire(&self.files);
+		if (files) {
+			__set_current_state(TASK_RUNNING);
+			self.files = NULL;
+			put_files_struct(switch_files_struct(tsk, files));
+			if (atomic_dec_and_test(&core_state->nr_threads))
+				complete(&core_state->done);
+			continue;
+		}
 		schedule();
 	}
 	__set_current_state(TASK_RUNNING);

-- 
2.53.0

