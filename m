Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5441B43F0AA
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585324; cv=none; b=jv3PUJf6ppBWyFhJmQZQqMO4bH5sRJVmK5JQWzgh5QASbTGgU9toTo+G/R+upFEQcx7qzzPbCNiyPXjOaa2OqKoIAi+SZQ86PQ3ZuTM3bqYzJEHXRr4QC7TA0d3rAo/mIPjC/1JW5U6tIQWqSD5JKLG5qOsFcFfHezFJs3wd2zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585324; c=relaxed/simple;
	bh=zzpA5Shnl8ac/2vEQfIhHiyDJN865bmDeNXqGRKx08c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dVaYe9Z8UgYx4AQMDogbuoPWPyeAsZt2pdsv7+TmBXnRFBol4qYuywaiWf4uvu681MVqFeo7G52s9bMUz9fEqb1tt+3KA+Bj8DxXFF5ozOh5sb3rUakD4u96a2ZYpzoTz5YIlRmpBbnOgncXhdMnGsh6PO9EFZzZnmWag0QJV7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVYytX4G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVYytX4G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD05F1F00A3F;
	Mon, 24 Aug 2026 15:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787585319;
	bh=3p6fWdZx9MBYQc+GEi7m16S7QNn4j3pl6pyCjHZBrxg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VVYytX4G4pWj4fWT2p+L0hluVuLiGSICSlVjy6i2yJwnVGOmbBYsme5DDwYqR5ebI
	 pucOtzfc1kA9Yplju0Au3I8LlbwNQRwV+SS9igmVdHuIxZ5CXJEDbCU6K91qO8jqNP
	 tQxbWV7+VQkJuA6SGtXRdaha5Sa/nQRXLucspmatXmRIIiIu3mnnOJIT2dSWx5rUUh
	 gMo0CYLPtVMyzOYao31aXIdg892ll34PQ1XbUopXPi40escA+4DCSjvUJYnmtqqg+G
	 ptq++65/ox9dhyNpK+k8apPZqNqXSl71TrBhfnhlowMGctNucmmntjtc62FaO49pRl
	 3eP5vmdYUCvUw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 24 Aug 2026 17:28:18 +0200
Subject: [PATCH RFC 4/7] coredump: s/startup/done/g
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-work-coredump-unlock-self-v1-4-48fd1cca7eda@kernel.org>
References: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
In-Reply-To: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zzpA5Shnl8ac/2vEQfIhHiyDJN865bmDeNXqGRKx08c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT1JEu9VP/8J7r+xHb5YyxR7up3Nr9+MzXsfGrcvZ60d
 jYBdcbKjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInIqDMy3Dp6UvOVvm2nw1K1
 3hNPj837sVBFVinop3hQwaVUvaOalowM12bE/3so8C+rWy0oJ3eTzOGPdQKfH5n9PCpo/uola6k
 FDwA=
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
index ec9359e382ea..27d9cdc77cec 100644
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
index 2c0b1c02920f..b535bc1ed68d 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -441,7 +441,7 @@ static void coredump_task_exit(struct task_struct *tsk,
 	 * to core_state->dumper.
 	 */
 	if (atomic_dec_and_test(&core_state->nr_threads))
-		complete(&core_state->startup);
+		complete(&core_state->done);
 
 	for (;;) {
 		set_current_state(TASK_IDLE|TASK_FREEZABLE);

-- 
2.53.0

