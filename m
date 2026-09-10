Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9434AB1DC
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055335; cv=none; b=FpKcBJzo2XhUOFZ3ksCFlmx64cpf8XBEjSnAelJ29bUYudFRwCEurFbW/4iPoTLXSBXBJPiShcM+jszFFBYPRp2y5936sqTI/UxyUyGQqoqPomzxPUx5lmiEMqwVEoYxVZDzWFYPSZ2OuDowCZntMU1DsRlsH3+Li0zrTUu5NFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055335; c=relaxed/simple;
	bh=MnBTnGtInkzx+zx01p2rrw2AYNqwC1tc4LezeOcWmsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dpwPYgap8fgcvjz8IATAgOjK9EDnRsDJD/D3hVczvRh4BpXLDCU5i8LEVNLcC9BneOIJTDF2hcdz6n+mFff0wxRRo9VVT/QI71aLZy314mspGYRXHkpbt+xwp9ZTeJDqNI09rEEmFdnjW8ysQUCa9KM7s5aOE+dRdamHSKN9OWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsDjae9F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsDjae9F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2331F00893;
	Thu, 10 Sep 2026 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055334;
	bh=p2sUDxw4y+c568ZNaDnuhtt3J2TYWKynyVGu6+s3R1s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OsDjae9FXbojZzS8fN04t5rTYQwTQ+mX4g/12/3ZwFrdGLU/FVrb+J8Gety7pu4PE
	 8FfPMuYV2cT9KtN/XJ4x/vIalgvH9biidTgkD7hhrZs6YlY78chsBwYraovku5m596
	 WWJPxFvxsVzBgQHkW75KwP8OMXauW+/H/gOInmlenhh3AjG0W1UzzMexBQQwAb3TDX
	 vGZEf6gHaPX+JRyO2pKdvcJBIBTdNNibZs2gY4GKfpf0ADp2zMjmUiN9SoN5S52LFJ
	 j63SFY1yeaj0vm9FXqma4U7zCg6P3BhY3K7R99n+JX2k5B+2UwKXlcm7Cy4lDbagpm
	 FsTPKLKjmHjWQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 10 Sep 2026 17:48:11 +0200
Subject: [PATCH RFC v4 13/18] coredump: factor out coredump_wait_inactive()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-work-coredump-unlock-self-v4-13-a5c1800dc930@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2034; i=brauner@kernel.org;
 h=from:subject:message-id; bh=MnBTnGtInkzx+zx01p2rrw2AYNqwC1tc4LezeOcWmsY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtuminz8eQf0nD9MhfQauTinKt4tNXd9habNv/dhr7m
 /mLWPZN6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiIvTLD/6LO6zccbmg1rSuU
 bP2wpaC2cK+PWpTyC9tpDkynTZUXnWNkuJwomiaRktC84tuBCrtU7SXmaq+u6/OsLd+nW2tgLnq
 cHQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Factor out a new coredump_wait_inactive() helper that
COREDUMP_CLOSE_FILES can consume in a bit.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/coredump.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 2e2005c14d93..daeca723bdae 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -519,6 +519,22 @@ static int zap_threads(struct task_struct *tsk,
 	return nr;
 }
 
+static void coredump_wait_inactive(struct core_state *core_state)
+{
+	struct core_thread *ptr;
+
+	wait_var_event_state(&core_state->threads_remaining,
+			     !atomic_read_acquire(&core_state->threads_remaining),
+			     TASK_UNINTERRUPTIBLE | TASK_FREEZABLE);
+	/*
+	 * Wait for all the threads to become inactive, so that
+	 * all the thread context (extended register state, like
+	 * fpu etc) gets copied to the memory.
+	 */
+	for (ptr = core_state->tasks; ptr; ptr = ptr->next)
+		wait_task_inactive(ptr->task, TASK_ANY);
+}
+
 static int coredump_wait(int exit_code, struct core_state *core_state)
 {
 	struct task_struct *tsk = current;
@@ -527,23 +543,8 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 	core_state->tasks = NULL;
 
 	core_waiters = zap_threads(tsk, core_state, exit_code);
-	if (core_waiters > 0) {
-		struct core_thread *ptr;
-
-		wait_var_event_state(&core_state->threads_remaining,
-				     !atomic_read_acquire(&core_state->threads_remaining),
-				     TASK_UNINTERRUPTIBLE|TASK_FREEZABLE);
-		/*
-		 * Wait for all the threads to become inactive, so that
-		 * all the thread context (extended register state, like
-		 * fpu etc) gets copied to the memory.
-		 */
-		ptr = core_state->tasks;
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

