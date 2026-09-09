Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A60568FD9
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969210; cv=none; b=GKU2DxnZIcWFmMYyu7DAvE/zTBB0LeEa2JPIikjuiK/MfbivsUANCQjeSENzOF0XQYyBG0q2yLiU16D1RvUhWUuN18rseT4J7PFth6sNWqpiB/DOezY6Bl8M/LAJrrcVhmYqPDKIHX6nOYu1UCxAkI8a61xipZDq5WyHsQ20pKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969210; c=relaxed/simple;
	bh=KgCdqazHLOHkdl9/IpNnCC2CDcHyQBonguIO92EalpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HzmOpctFIHym/P8tlx2I3IXgCCIfKlQ/XC1wPLgCdOB7DwtvtIMvkY7ZMUh6IXvP4UQ4cicDLKBouNqBnyjmx3haPljwYaIkJ0KDFTwNwL9yCLqb3pcRQJaZwIB+2HbB1/CTaNbfBdYtOdS9CaTls/+QTzzuxfRMZouElGRHMcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQR+abYj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQR+abYj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06F61F00A3A;
	Wed,  9 Sep 2026 15:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969209;
	bh=gOoD08iNaabbX4dk36O2wS/anwF5UhM4PlX1E9GLt74=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KQR+abYjXl8g/5pVQK1GYrQ+JjMWaazfSNnn0ttTMBObqBuLyySeAIJDj+VGTGw5B
	 4jSBDn2O9FXZFV6uTYnLlpz1gdyhXrOB2xrX7CvE3SKyoUIc/cduj5clHQkTi7zl8f
	 f5GeUra/Y6TSEBGfh+dES9b0jGTy9xy/KE6/TRjLSgwOvqrUrRxHco0c2dbJPW4uwA
	 HL54wfEzKh7t7a2vjnRPEZATrFkZsSG4lsSsaRz3CQrfkP3ZnQBztEXpd79i+VGWlw
	 yXGwBXBQI5+6OJhTPFOvNwo8Ylkum7XJhsb2U8DWAu8RCUAdqPfMclikEbX0O/zDoy
	 iM7FOZOwtcH5Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 09 Sep 2026 17:52:54 +0200
Subject: [PATCH RFC v3 11/15] coredump: factor out coredump_wait_inactive()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-work-coredump-unlock-self-v3-11-04f907687563@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KgCdqazHLOHkdl9/IpNnCC2CDcHyQBonguIO92EalpI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtbLjKltSWejd00lK1Sy1vVtUFrLzdsYIl59+BbNXf5
 55P3WJ+uqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi51QYGVbXdHPw9pbm2Mj3
 rZSfuujVYhXrBeeEuD+dzRNc39Ite4zhf5a0lAOf9eZHbjNU1na475HPP//ZeqHic9GEjw73NF2
 E2QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Factor out a new coredump_wait_inactive() helper that
COREDUMP_CLOSE_FILES can consume in a bit.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 545a6df48ea8..d0796536e03f 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -518,6 +518,24 @@ static int zap_threads(struct task_struct *tsk,
 	return nr;
 }
 
+static void coredump_wait_inactive(struct core_state *core_state)
+{
+	struct core_thread *ptr;
+
+	wait_for_completion_state(&core_state->done,
+				  TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
+	/*
+	 * Wait for all the threads to become inactive, so that
+	 * all the thread context (extended register state, like
+	 * fpu etc) gets copied to the memory.
+	 */
+	ptr = core_state->dumper.next;
+	while (ptr != NULL) {
+		wait_task_inactive(ptr->task, TASK_ANY);
+		ptr = ptr->next;
+	}
+}
+
 static int coredump_wait(int exit_code, struct core_state *core_state)
 {
 	struct task_struct *tsk = current;
@@ -528,22 +546,8 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 	core_state->dumper.next = NULL;
 
 	core_waiters = zap_threads(tsk, core_state, exit_code);
-	if (core_waiters > 0) {
-		struct core_thread *ptr;
-
-		wait_for_completion_state(&core_state->done,
-					  TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
-		/*
-		 * Wait for all the threads to become inactive, so that
-		 * all the thread context (extended register state, like
-		 * fpu etc) gets copied to the memory.
-		 */
-		ptr = core_state->dumper.next;
-		while (ptr != NULL) {
-			wait_task_inactive(ptr->task, TASK_ANY);
-			ptr = ptr->next;
-		}
-	}
+	if (core_waiters > 0)
+		coredump_wait_inactive(core_state);
 
 	return core_waiters;
 }

-- 
2.53.0

