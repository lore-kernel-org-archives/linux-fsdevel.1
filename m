Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2384A64C6;
	Mon, 21 Sep 2026 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998334; cv=none; b=R/c830gUTU6ZVt3iLHNtEN99iikJh08N4PBAtite8g1w3jnFED8twfkYJvv4TEfJvGeJBDrE0zHi5A24unOUiORzQ7OF+34w+BF0Q/5wN6Jkw8deIpPrzYAEDp7iW0ZcoG7iqSAAy96XVq+wiFerWYrwk3JF7QSg0XBVHgwsyH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998334; c=relaxed/simple;
	bh=ewDsuLMI5Aha0m3J9gayD6hgJ7X0BeQSbg3MKkl5wZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e0SyTNi2k9MZnAUwvBjTLDVyPkxmlmhp2jLG4Ib0w4f8WLM4qOijGTvUGtVvyECMLb3tSWPBDU2e2rqvJEAbFchQWuEJfCI8uRSzZpDi84U5lhzu0y6zVw0wZddDShLDc5tXrgFHSleABRBHAxZ+D9REYRhfwLAdsNArJVtN6Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pmfck5Q1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pmfck5Q1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D23C1F00898;
	Mon, 21 Sep 2026 13:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998332;
	bh=/1BanrR0bEaNM0ANpLadkWf2SynUvHsGYYo3gSkKut8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Pmfck5Q1hr/Yx7jfVeDnT8LVpiwSzMf7eFW7nK93xNMWhIoB5/tzeCrLYo5iu7XAH
	 89bzw9T7RxA9xAAw0JQjKsvsLeorLNG4KUl3kJRIDmGDFRwloHcDlf/Z1sHk+qmRsj
	 IVhrkt/cFEZuWKGJSGkQ7HTHY7Gs6B58EhjuzYraL7ITnpC2axmVCX9elZ3S4gTSVJ
	 WDbFh5WZdGWNLx+fIZjwamtKYPc1zlH58KlYQV/VowhjiG/OIVAlWQbbI3nHCq9DOj
	 L2lzdtm8snI0OfqWquIVbZV5oy/4xqtz9m15I2WgzsIeSrvLECj91POQTee1+KKCkO
	 rIiO1AoJHW0RA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:44:56 +0200
Subject: [PATCH v3 07/17] fork: release the files of a failed fork after
 sched_cancel_fork()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-coredump-fixes-v3-7-8e4adb1619e6@kernel.org>
References: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
In-Reply-To: <20260921-work-coredump-fixes-v3-0-8e4adb1619e6@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Chris Mason <mason@kernel.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-mm@kvack.org, io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2806; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ewDsuLMI5Aha0m3J9gayD6hgJ7X0BeQSbg3MKkl5wZg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtNLlz44ymZcCmDuNsnYhpUV1ZKqHe0Xd5dySxvcmU9
 Hf5H7u8o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKcHAz/DPb4mFvPdHux9MOf
 zxpzH69pFt/Fls5wT/PZjuRVxh8uvmZk6HhyfUpd8L/PR88an+TZ1vaiXrU1w/qNkozMlP1OwsF
 PWAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Reorder copy_process() cleanup so sched_fork() taking scx_fork_rwsem
scx_pre_fork() is safe and isn't held around exiting files. Right now, a
fork that fails while another thread closed the bpf link fd will
deadlock against its own read side. It also blocks every fork on the
system:

    copy_process()                  holds scx_fork_rwsem for read
      exit_files()
        close_files()
          filp_close_sync()
            bpf_scx_unreg()
              kthread_flush_work()  waits for the disable work
                scx_root_disable()
                  percpu_down_write(&scx_fork_rwsem)

Simply release the child's files after sched_cancel_fork() dropped the
lock. The task starts out as a copy of its parent so p->files points to
the parent's table until copy_files() replaces it. exit_files() must not
run for a fork that failed before that. Clear p->files up front so
exit_files() is a no-op for those and make copy_files() set it
explicitly for CLONE_FILES.

Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/fork.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 10be4a0ecb3f..50f5b3e2ca87 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1676,6 +1676,7 @@ static int copy_files(u64 clone_flags, struct task_struct *tsk,
 
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
+		tsk->files = oldf;
 		return 0;
 	}
 
@@ -2199,6 +2200,8 @@ __latent_entropy struct task_struct *copy_process(
 	INIT_LIST_HEAD(&p->sibling);
 	rcu_copy_process(p);
 	p->vfork_done = NULL;
+	/* Set by copy_files(), exit_files() on the error path skips NULL. */
+	p->files = NULL;
 	spin_lock_init(&p->alloc_lock);
 
 	init_sigpending(&p->pending);
@@ -2300,7 +2303,7 @@ __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p, args->umh);
 	if (retval)
-		goto bad_fork_cleanup_files;
+		goto bad_fork_cleanup_semundo;
 	retval = copy_sighand(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_fs;
@@ -2613,8 +2616,6 @@ __latent_entropy struct task_struct *copy_process(
 	__cleanup_sighand(p->sighand);
 bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */
-bad_fork_cleanup_files:
-	exit_files(p); /* blocking */
 bad_fork_cleanup_semundo:
 	exit_sem(p);
 bad_fork_cleanup_security:
@@ -2625,6 +2626,8 @@ __latent_entropy struct task_struct *copy_process(
 	perf_event_free_task(p);
 bad_fork_sched_cancel_fork:
 	sched_cancel_fork(p);
+	/* ->release() of a file may need scx_fork_rwsem for write. */
+	exit_files(p); /* blocking */
 bad_fork_cleanup_policy:
 	lockdep_free_task(p);
 #ifdef CONFIG_NUMA

-- 
2.53.0

