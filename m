Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DD572691
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969207; cv=none; b=q54zE9nzwv+wyG34aFPE2gahCBNPfThg3n0tYabfoWLaMM69a8/bYGCps7FIkIEz1XnhKq8cCo/7hsWmT0rJoT7+sNEyFbIzljX0oF+//ZtrNn5CcLfwJ2L5z0yAC3RoLOXDtRiixYUC17Y6ei903yrVcj+539pYw3Pziq8iISA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969207; c=relaxed/simple;
	bh=YbEP5atY/vjnzP1Prk+HS0m1ikIDUYlJP9VJzV8spvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=orUbpeTy+vMvLbAAa7WbEqKtwvIeIph2HbU/m4Pa30/80KCx15PLnYj0zDCix0h6WxcedMBWNM3KFDrZXPuIYTrYU64FJZsj6D4mAKkyqof1kqSYibFM0U6/LYxKg2ddQhKHZTvVZfKjgZzU1rK2MhGglODz7cw740UCa9kP1Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hc7yoe/Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hc7yoe/Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DB11F00A3D;
	Wed,  9 Sep 2026 15:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969206;
	bh=kQNCjIoni5fJ2LB/ehynPqmvAEYm1ho99d+U8f1jG0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Hc7yoe/YESpMafuic4Ip9psJ/8xkra3Qe4/movg6SNq3KkxWnmdS4W3bJeq4pjLfM
	 FC0ctfDHoxrp/MeN11eQM9wGgjFzDDp5/DEWNyGAiZgEwiKpq3I88CFAEve4ctsMjh
	 wewNLsXfhavbPj32NTaJs/ZB0NG7uRR60kQc1kWYR53jWCKJNcf2FXPjUBEJxxc7dc
	 dsiC8m/9Suf+TZbkaoeI41w0mqcto38SCa/aDm6CqIKugPtqhVetRcLiThE8u7iJHF
	 +n12PTQkWlnrGGuSztPGdroozJFfYDg3xEPEbAJoihZzo6wmPvUYgfRQWCo8QhibPj
	 Z/KwD7fzZZSHA==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 09 Sep 2026 17:52:53 +0200
Subject: [PATCH RFC v3 10/15] coredump: s/startup/done/g
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-work-coredump-unlock-self-v3-10-04f907687563@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2022; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YbEP5atY/vjnzP1Prk+HS0m1ikIDUYlJP9VJzV8spvw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtbLiqXr/nRXjg3OVVfneMzdf33c+Nddj2+rCLaGL7H
 N9mnntqHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZcJKR4e6kQr07rjqr09wn
 iR0Vq06oW8QZqVP544ToPf27ojv2LWf4Z/zH2y72aH5yxbyoW6HCjUGmMzr1NpffW76wiXf5Ocn
 n/AA=
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
index d45a5476b97d..1c1e280a25a1 100644
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
index 4e028f157597..affee30bcbca 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -443,7 +443,7 @@ static void coredump_task_exit(struct task_struct *tsk,
 	 * to core_state->dumper.
 	 */
 	if (atomic_dec_and_test(&core_state->nr_threads))
-		complete(&core_state->startup);
+		complete(&core_state->done);
 
 	for (;;) {
 		set_current_state(TASK_IDLE|TASK_FREEZABLE);

-- 
2.53.0

