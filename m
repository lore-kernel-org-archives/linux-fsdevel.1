Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676864A260E;
	Mon, 21 Sep 2026 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998365; cv=none; b=rkS5yOZP7M/hk4JIMmnablm5rNVVkLeUD8XEyVa5BlIdz1GDSbWQmcvILmM8Me9g5hJHNqR4QXzt9u1p/Syz14H84E3ZIJ5aBym02PxR8Judy3Iu1B1IX80WC6FCuYiiTvtjeMySk1AoSANt+NESxLzEcvikCBp+ILQtnWDpwyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998365; c=relaxed/simple;
	bh=N9+t6kg9G5schzNoEgToZQtBo5+eN+aMw/ZqCZtP+xs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EnaHulnTDevZStlRWanpwEGOoy3kHochdbgNeDEkN6w9cvUj/WrXfDYVtKYmtLC1OO3wgKik0OgRqfnIifZR+GW8PXvpaZvI55axexJxVC1tBRTaUJzD8mnEdH0spVFvPhqA4decHCLbVwa4gm3fErjO779xVYPtZYtKqt/n2MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj1MZ6b0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj1MZ6b0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC801F00893;
	Mon, 21 Sep 2026 13:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789998363;
	bh=XK+vFPcoNOWpEsInXI2i4g3mZjN5dJruLtFC6744UCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Aj1MZ6b0DckcbN8ZWhMcy3sQmM5nKsMEjWSoa3mKzl4IzTTdqYMEkUXOnPbs/V8z1
	 Mx4jZ9zAiATVYJt5FPaI8JLIJKQrvVpq0b+xhEky4JsfoHwxRqlljaIeQYJlALdHJy
	 4gXFul/htFtIbwAHHvJ7UFvWrIEfQwsVShk8nfiSPeJTeyzDDh2P/QlvKGFh9Fg9ys
	 ho6lcgL2qG881lUJPTANEunTFLV+Mi6Z+65BhopjaMu7+eyZY4ncZAu/A8vkwRE017
	 Jdsab31+dou4Pm1UlIjSVp5JFnPRrUoXRpUiIkO2yuS/6kDm+mP4AdzUBBPFat3VVz
	 sLGUqsBTeskMA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 15:45:05 +0200
Subject: [PATCH v3 16/17] signal: enforce the user worker signal mask in
 __set_task_blocked()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-coredump-fixes-v3-16-8e4adb1619e6@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2674; i=brauner@kernel.org;
 h=from:subject:message-id; bh=N9+t6kg9G5schzNoEgToZQtBo5+eN+aMw/ZqCZtP+xs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtNLm7ceqfa/vOperqasXWKHp+9/O/vtt16TmBg9pyW
 /pKTn9h7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIUQnD/xy1itCSJL+A5vvr
 bc6IHL/CpDexIOn7wa2JkpYVJu8LNjH801vYraC/epZrb8Lti8vr70eH/N73ct8GxiZ2sbvaHq3
 X+AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

User workers block every signal except for SIGKILL and SIGSTOP in
copy_process(). So complete_signal() never picks a thread that blocks
the signal and get_signal() never dequeues such a thread. Net effect is
that user workers only exit on SIGKILL or stop on SIGSTOP.

Before we fixed it a tracer could unblock a signal. For example, by
unblocking SIGHUP a installing a handler complete_signal() could end up
picking a user worker for a process-directed SIGHUP. Which effectively
means the handler never runs.

After blocking PTRACE_SETSIGMASK what remains is the in-kernel
sigprocmask() and force_sig_info_to_task() changes.

The in-kernel sigprocmask() users block more signals for a critical
section and restore the saved mask afterwards. cifs used to do that in
__smb_send_rqst() and ocfs2 in ocfs2_block_signals(). Both were
reachable from an io-wq worker. Both only add SIGKILL and SIGSTOP to the
user workers's and then put the fork-time mask back.

force_sig_info_to_task() unblocks a signal so a target can't hide from
the signal. A synchronous signal forced onto a user worker is accepted
currently so let's leave that alone.

Make it a rule that a user worker's signal mask can never drop below
the copy_process() deafult. SIGKILL and SIGSTOP have the same rule in
the other direction. rt_sigprocmask(), set_current_blocked() and
PTRACE_SETSIGMASK strip them from whatever mask userspace asks for.

Do the same for user worker mask in __set_task_blocked(). Add the
fork-time mask back into the new set for a user worker and warn if that
changed anything. Warn when a caller unblocks a signal for a user worker.

No functional changes.

Link: https://lore.kernel.org/r/aq_4fY6GVtK47Njq@redhat.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/signal.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index c3bad983dd37..137002445b0d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3212,6 +3212,16 @@ long do_no_restart_syscall(struct restart_block *param)
 
 static void __set_task_blocked(struct task_struct *tsk, const sigset_t *newset)
 {
+	sigset_t floor, floored;
+
+	/* A user worker never unblocks anything but SIGKILL and SIGSTOP. */
+	if (unlikely(tsk->flags & PF_USER_WORKER)) {
+		siginitsetinv(&floor, SIG_KERNEL_ONLY_MASK);
+		sigorsets(&floored, newset, &floor);
+		WARN_ON_ONCE(!sigequalsets(&floored, newset));
+		newset = &floored;
+	}
+
 	if (task_sigpending(tsk) && !thread_group_empty(tsk)) {
 		sigset_t newblocked;
 		/* A set of now blocked but previously unblocked signals. */

-- 
2.53.0

