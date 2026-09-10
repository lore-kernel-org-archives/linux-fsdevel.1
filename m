Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4B538F651
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055328; cv=none; b=i4w6iuYBSkSWK4my1wqlDTmCP/OTodb4V8NkxnedPa0t/zp170s/gIXf+bDiYaudQtub0JtN/wtadS4znpviuePnBRkMCrCL8U6ODKyhD1Hq8yuKG96fOD6jeKt9Ma3NGS+IrG1hsP/9ECF/rJAXI9/2mUralYUbKCLBFDKU2PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055328; c=relaxed/simple;
	bh=gdXobhVEDKkHf+fKMYimczQPNJanh0SsYuSSecdblrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S7WxFml8rYdDJsUMFEsyWnYz1UMMHjBYIzQtC+rmHuRFfeXCvq3dJ0wLosn4AuchJnwK5AYwctstVUPub5Pzus2fVC9T+2T5lVReAkVjvFkFbpDZpBKPdHC22XTdb4x2le0InKm0jFPLXU3zM4YKYqaRoJchqzHIAHIQi0VObUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtoE7hU6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtoE7hU6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3981F000FF;
	Thu, 10 Sep 2026 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055326;
	bh=EkOutAZRKU5r2jgi+hxMYL+7sVOcYlBC2eiUi2x5zJs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mtoE7hU6UkifxCNu5/BwBuaiEdFjowK8HgwbJ/BAjUpozalLdNSyt5gPN11Zx/JJg
	 G4kjPbtMO51RclDqFtuNBJOqMyPta9L+RN6869Ik15pGq6s9s8zmIXv27ILLLzrymN
	 9zEyzxYpMYvs98RT6yDhWghuKGtn78Pp0NehoZcGQ+4FdNmYePd3ZfZJCcyRR5FuFV
	 aNGLX9xaly91WApgYXU8ivqHHwgHtxSEoTBotN11E/hk3W9lAkrrp5GNEKBVUaieBn
	 TLAaeQjf6NeaaBbwumrORB3NPhVZDHZauvL2mPVzsxeJX1pNSa7NSAek/8goKKAQnd
	 JR6ZOgHoiTeYQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 10 Sep 2026 17:48:08 +0200
Subject: [PATCH RFC v4 10/18] coredump: drop core_state->dumper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-work-coredump-unlock-self-v4-10-a5c1800dc930@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4403; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gdXobhVEDKkHf+fKMYimczQPNJanh0SsYuSSecdblrY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtumgne/TG8fpDW4NtOje8b5owmfmkSdTExe9lX8/+e
 u++8+7rAh2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQAT+fSQ4X+8949L55KkUlW2
 TwmZF8t9vKFOSZA3bMWt08WWvF8y3sox/K+4w/A/9szp/xOskk9sv//L7VHjxwtRBkwXNSSMVG/
 NmMYLAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The core_state->dumper field isn't used anymore. Only its ->next pointer
is. The current task is always the dumping thread and the ->task pointer
is never read. Replace it with a plain pointer to the list of parked
threads.

Historically, core_state->dumper was used. Its ->task pointer was read.
by fill_note_info() started at &core_state->dumper to ensure that the
dumping thread came first in the ELF thread notes. That changed in
commit 4b0e21d64253 ("[elf][regset] simplify thread list handling in
fill_note_info()"). The first iteration was taken out of the loop. So
it's been unused ever since.

No functional changes.

Suggested-by: NeilBrown <neilb@ownmail.net>
Link: https://lore.kernel.org/178900159210.207413.8292125177519817528@noble.neil.brown.name
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/binfmt_elf.c              | 2 +-
 fs/binfmt_elf_fdpic.c        | 2 +-
 fs/coredump.c                | 7 +++----
 include/linux/sched/signal.h | 2 +-
 kernel/exit.c                | 4 ++--
 5 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 6b7ffac5d665..bf7f8f47548d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1875,7 +1875,7 @@ static int fill_note_info(struct elfhdr *elf, int phdrs,
 		return 0;
 
 	info->thread->task = dump_task;
-	for (ct = dump_task->signal->core_state->dumper.next; ct; ct = ct->next) {
+	for (ct = dump_task->signal->core_state->tasks; ct; ct = ct->next) {
 		t = kzalloc_flex(*t, notes, info->thread_notes);
 		if (unlikely(!t))
 			return 0;
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 005f0a084483..d3872169f55e 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -1504,7 +1504,7 @@ static bool elf_fdpic_core_dump(struct coredump_params *cprm)
 	if (!psinfo)
 		goto end_coredump;
 
-	for (ct = current->signal->core_state->dumper.next;
+	for (ct = current->signal->core_state->tasks;
 					ct; ct = ct->next) {
 		tmp = elf_dump_thread_status(cprm->siginfo->si_signo,
 					     ct->task, &thread_status_size);
diff --git a/fs/coredump.c b/fs/coredump.c
index 9addd2d59b7b..16d3fb54500b 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -524,8 +524,7 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 	int core_waiters = -EBUSY;
 
 	init_completion(&core_state->startup);
-	core_state->dumper.task = tsk;
-	core_state->dumper.next = NULL;
+	core_state->tasks = NULL;
 
 	core_waiters = zap_threads(tsk, core_state, exit_code);
 	if (core_waiters > 0) {
@@ -538,7 +537,7 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 		 * all the thread context (extended register state, like
 		 * fpu etc) gets copied to the memory.
 		 */
-		ptr = core_state->dumper.next;
+		ptr = core_state->tasks;
 		while (ptr != NULL) {
 			wait_task_inactive(ptr->task, TASK_ANY);
 			ptr = ptr->next;
@@ -556,7 +555,7 @@ static void coredump_finish(enum coredump_state state)
 	spin_lock_irq(&current->sighand->siglock);
 	if ((state & COREDUMP_STATE_STARTED) && !__fatal_signal_pending(current))
 		current->signal->group_exit_code |= 0x80;
-	next = current->signal->core_state->dumper.next;
+	next = current->signal->core_state->tasks;
 	current->signal->core_state = NULL;
 	spin_unlock_irq(&current->sighand->siglock);
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index d45a5476b97d..14b55d00d605 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -80,7 +80,7 @@ struct core_thread {
 
 struct core_state {
 	atomic_t nr_threads;
-	struct core_thread dumper;
+	struct core_thread *tasks;
 	struct completion startup;
 };
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 4e028f157597..3df1fffc6674 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -435,12 +435,12 @@ static void coredump_task_exit(struct task_struct *tsk,
 
 	self.task = tsk;
 	if (self.task->flags & PF_SIGNALED)
-		self.next = xchg(&core_state->dumper.next, &self);
+		self.next = xchg(&core_state->tasks, &self);
 	else
 		self.task = NULL;
 	/*
 	 * Implies mb(), the result of xchg() must be visible
-	 * to core_state->dumper.
+	 * to the dumper.
 	 */
 	if (atomic_dec_and_test(&core_state->nr_threads))
 		complete(&core_state->startup);

-- 
2.53.0

