Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9FE4A4829
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 15:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364750; cv=none; b=fF/wwVr53/1N9WFG963VFUlxJagW3dMyut7kUnPdBfxMXIRyVgtyp/QFtJDBKBV5H7/60Hnk/klDCm10mdrddyjxEAxDnX55Zlin757BYQ+mBzo+GVsFcJcoycWjHxBv8W5mZagQw85LzGYNEa2YP5jC5shNdY2YPdJbYgScYXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364750; c=relaxed/simple;
	bh=q5fv3xXfMwIS7NIb+RDtHK9T1wBd+dUjDqoKFQqCgiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o4Nr+doDoik3hS1kGOBYBTNP6KwbF3RpnSmevaQKxM3pe8/EZ1jFd7CZTxqdjO2oBj3O1IiU0QVRZxWmpELOyreM8v2QngAKQN70GiqBkp03X49VX1BE6zkJhC8R6fF/C2za87r59O1tDhE88EDyyTQSuSQvf1L6F8jSpVToWwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knur4eYZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knur4eYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C831F00A3A;
	Wed,  2 Sep 2026 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364748;
	bh=gkozlQ97FOXIHzmKRRpGFQ9TYyV+8utx+rqNwOCLl3k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=knur4eYZsu0qvHjPSCquqT25Ifn6BR2Kl+Epez/zlkx0z5uC9yypLETPCizsRARC7
	 WhjMTnvp+PmlAV2BRLaTxb4sagUmIOaUkhEWXhb3t8pwyArCL8/n73bEe/w8OIWfvR
	 BCD2kEZGsyncVowzRmOcOjxiUKndQFjMfqyjWuI3EZvKWngbx/lndnzH93iCvXvVRy
	 fEVX70OvfjWYAwlmd1FKqCua8TnHw5MCn/ntrpsvlgmt9XeQeQZTIK9c6/yiGeaNsM
	 nZUUVutwV0U/ZiAoFfiR5DHUJXE+LlHnV1eBWBYQ4cWisscgsZYR4KoaPJJzEoaSjj
	 8k9ToYsIDir0A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 02 Sep 2026 17:58:29 +0200
Subject: [PATCH RFC v2 11/16] coredump: s/startup/done/g
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-work-coredump-unlock-self-v2-11-1bece368cbb1@kernel.org>
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=brauner@kernel.org;
 h=from:subject:message-id; bh=q5fv3xXfMwIS7NIb+RDtHK9T1wBd+dUjDqoKFQqCgiA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNcF9xyKPw+jkWe/sVficuedX8/FN62bf9Q4TLLenUW
 e7sxzymd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk+Awjw7fLMybV7Na+f1Y0
 4Uzb9M1nCzkX3XFkipt64Wr7As0c1gRGhnPVkts7vOZL1Ce8k42r4k+Sl+TVkVj+8+s6hpsO3Y7
 pHAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We're going to use that in a bit. Rename it to something easier to
understand.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c                | 4 ++--
 include/linux/sched/signal.h | 3 ++-
 kernel/exit.c                | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 9addd2d59b7b..545a6df48ea8 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -523,7 +523,7 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 	struct task_struct *tsk = current;
 	int core_waiters = -EBUSY;
 
-	init_completion(&core_state->startup);
+	init_completion(&core_state->done);
 	core_state->dumper.task = tsk;
 	core_state->dumper.next = NULL;
 
@@ -531,7 +531,7 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 	if (core_waiters > 0) {
 		struct core_thread *ptr;
 
-		wait_for_completion_state(&core_state->startup,
+		wait_for_completion_state(&core_state->done,
 					  TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
 		/*
 		 * Wait for all the threads to become inactive, so that
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 584ae88b435e..ed9e2d49d166 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -81,7 +81,8 @@ struct core_thread {
 struct core_state {
 	atomic_t nr_threads;
 	struct core_thread dumper;
-	struct completion startup;
+	/* Completed by the last thread to park. */
+	struct completion done;
 };
 
 /*
diff --git a/kernel/exit.c b/kernel/exit.c
index 97686af89501..8702e3ead7dd 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -440,7 +440,7 @@ static void coredump_task_exit(struct task_struct *tsk,
 	 * to core_state->dumper.
 	 */
 	if (atomic_dec_and_test(&core_state->nr_threads))
-		complete(&core_state->startup);
+		complete(&core_state->done);
 
 	for (;;) {
 		set_current_state(TASK_IDLE|TASK_FREEZABLE);

-- 
2.53.0

