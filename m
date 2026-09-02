Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215C14A9D42
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364752; cv=none; b=nxEoA5lnhSVUbJb/zAD6IQme7jN9NdQzWsLiiIRAnRJ9nKICo4ZCfVc43/SdmlrtrzH+AIna/H418pZshDXw1WJNULpBYqY9HRmkbVtA3qEczxpg6zVw2JSXwgXfisaqMy2vhF+Yrr/+GfSL2f/f5Q7WZz98oAPpv/igsNw6lYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364752; c=relaxed/simple;
	bh=x5O7BtPblwfNc+rl5YwX3eI4R2DkRoagneGZsol7LFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BL5JxNhRJlLWjXyHCNAoq3EuzLOtkXqOhquFLbm9HBVT8f3+ZsST348VCrA3EOC1wXPYCdurzcDqork+Dg4KNFxdVNIl11X4mfsXPp25KZGZJ6zZQhKeNk5u6usM36kHRm4XU69nBP0BlJnRnyFu8S8i/W8/oqP4STpJ1kHWt5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/k5Aupq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/k5Aupq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4BE1F000E9;
	Wed,  2 Sep 2026 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364751;
	bh=gOoD08iNaabbX4dk36O2wS/anwF5UhM4PlX1E9GLt74=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=L/k5AupqdUcu+EXu/Q/hky7GtIMaZ26KALldJy3ph3nRxDfnNTJ0oU+W1YR++5iXn
	 2HnYGmQIQdH5rcf27EoMOOz28ngPeDAH5arD658qfNxLvvNQqRm3ZzzLlO9lrfIZpA
	 QZ+T4ipKYeV31VBv55cTRuzt/N+GGruFMdn8shVZlCmaVy41FdRhLXa/9KaQszWP+t
	 r6noP5TWE9vd9A47KhVWzXWzG/1TQeRklLiSoC5Nl/2jD5exWCWHGbTdyh0YL77+sm
	 guH/YMMUzEOmPCcusFDpPvuaE/1KE/7mjKHLEBXUssR5xCgYLgJrjcSv3FNvlqdHOT
	 I57LsdTOXkYLQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 02 Sep 2026 17:58:30 +0200
Subject: [PATCH RFC v2 12/16] coredump: factor out coredump_wait_inactive()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-work-coredump-unlock-self-v2-12-1bece368cbb1@kernel.org>
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1927; i=brauner@kernel.org;
 h=from:subject:message-id; bh=x5O7BtPblwfNc+rl5YwX3eI4R2DkRoagneGZsol7LFo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNcF9xqdyaReXAjJPvFdKV395fZd+1tvHCnyNCW/Y6X
 PnG+FzjfEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEPLYxMjxc8vvCLOu9wq2l
 lk5+mcUNj9etK5l3i+H708nNNkvVUzwZ/qc/27dI60SRe86kgPa0twXBUzn3yn3oX8z0ueRX0+P
 /09kA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Factor out a new  coredump_wait_inactive() helper that
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

