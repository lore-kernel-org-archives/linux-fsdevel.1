Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7339C4746BD;
	Fri, 16 Oct 2026 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145726; cv=none; b=lXyo7GwoSnqjk+4mDRHzwh2UXOUtB0eptG0zCICIOV9cMsrcusnwQLnLXKyXU2grWHSA0c9VaxM2d0CHgUWKdKG9Hjf24/yDFPqMVRlr49wxMuFGzUoL0mHE1Cyl4/x36i2jk1q2sKT5A4f4oDHmdFXcUpaLC1T4JPUklsPdCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145726; c=relaxed/simple;
	bh=gr2SAyuSoKp+gmPGzAmknKWYhLAqbIgxgoGVxFA816I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jppmmRtO7pk3GJuQEDLm3K0Y5OKlm1fDuzpmOeE998Elg9V5x/jWVsGywwEUH/BdP77To51gWC+7/OpesqqH53pHvm9zPJpMTKw26TjjtqZtUN2ar5eJv3cUXtqkUMyF/w2StbJSbifAxDiBJnfvTWtII3V3cjP29QnzqmlB+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRhirOVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRhirOVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A2F1F000C4;
	Fri, 16 Oct 2026 10:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145725;
	bh=EWoSt2vnkwCds2EzgO8UlEcp7hd5z6kwQM5kM48UwUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gRhirOVNocs2O/ciKx+YyF4F62QOv3JCV78cdXI/l2PyH4P9T7S5+QRX79xml8NQk
	 NbZeGCce5RvJGvWliSBTOzPHOAX4i9ViDBPwj0cT5wHC4SZnWNph7wkSrYWioZIbs2
	 qKDuh1U0XEpA2p179w+VkX+nEJS2KVvMMxz6MVRPMyOlacNNJ3XiiLy90ryzDKEZsI
	 aRT9i2Bs/S6XDokL+8cdDJQhAZ1Nx3ALAKe+Px5C9az+EFQLu/EYJ+O7lFnZDt7pV7
	 GYLwjOK1sE/15P4AStb+VlnbrTnKs16Od6aOjXPPvxVUlicbjZSyMPNhxEh3wSVmp0
	 HJ5lETD17yPAg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 02/19 for v7.4] kernel signal
Date: Fri, 16 Oct 2026 12:15:01 +0200
Message-ID: <20261016-kernel-7.4-rc1.signal-3dbe927d2fe3@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9825; i=brauner@kernel.org; h=from:subject:message-id; bh=gr2SAyuSoKp+gmPGzAmknKWYhLAqbIgxgoGVxFA816I=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/Kl3henXnG3JzLrbKw+Wxt5gezb1vc23Kp49XbdDH fNUdRsPd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyksp6RoafCmeH5p90tlwpe Z5ZfmjNjwcuEHbfe32MLrq7f/Sf42BxGhrv7Zl2utFoiNuOokuRq5Zrqnr8eku6hDI8On/3W4TR 1LTMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This stops TIF_NOTIFY_SIGNAL from interrupting work that can't be
restarted and fixes a bunch of coredump and signal bugs.

TIF_NOTIFY_SIGNAL kicks a task out of an uninterruptible sleep so it
returns to userspace, runs its task work and goes back to sleep. That
breaks coredumps. dump_interrupted() only lets fatal signals interrupt
a dump and writes to a regular file ignore TIF_NOTIFY_SIGNAL. But the
pipe and the socket paths check signal_pending() deep down in code that
is shared with regular syscalls and bail. So a crashing process with
io_uring requests in flight loses most of its coredump. In the selftest
an unfixed kernel delivers 357324 of at least 5111808 bytes. And
io_uring isn't the only source. klp_send_signals(),
bpf_task_work_schedule_signal(), landlock's tsync, kthread_stop() and
the printk kunit test raise the bit as well, some of them from irq
context against any task. So this can't be fixed per subsystem and the
state has to be per-task and ambient.

Add PF_NO_NOTIFY_SIGNAL and no_notify_signal_save()/restore() helpers
modelled on memalloc_nofs_save(). Inside such a section
signal_pending() ignores TIF_NOTIFY_SIGNAL. Coredumps, the smb send
path, which hand-rolled its own version of this, and the pid namespace
reaper, which busy-looped when the bit kept getting raised, are
converted.

The second part is a set of fixes that fell out of looking at the
coredump code with kres and modelling it in TLA+:

- coredump_finish() woke the parked threads without holding rcu. A
  parked thread can exit on a spurious wakeup and be freed before
  wake_up_process() takes its pi_lock.

- Only SIGKILL and the freezers interrupt a dump now and the three
  freezers agree. Power management and cgroup v1 freezing aborted a
  dump while a cgroup v2 freeze either waited for the dump or cut it
  short depending on where the core went.

- io-wq set its exit bit without a barrier against the task work that
  creates workers. On weakly ordered architectures exit could hang on
  worker_done.

- retarget_shared_pending() slingshotted a shared signal to the dumper
  when a zapped sibling restored its signal mask. That set
  TIF_SIGPENDING on the dumper and truncated the core.

- A tracer could clear the signal mask of a user worker with
  PTRACE_SETSIGMASK and inject a coredump signal. An io-wq worker of an
  SQPOLL ring dumping core deadlocks the whole group. PTRACE_SETSIGMASK
  is refused for user workers now and __set_task_blocked() enforces the
  fork-time mask.

- exec cancels io_uring requests before de_thread() so a worker
  creation queued as task work can't add a thread to a thread group
  that de_thread() just took down.

- No io threads are created from a PF_SIGNALED or PF_POSTCOREDUMP
  creator anymore. Such a worker was invisible to zap_process() but
  still decremented threads_remaining on exit so the dumper could leave
  coredump_wait_inactive() early.

Also included are a comment that do_each_pid_task() needs
tasklist_lock, a READ_ONCE() in pid_alive() and a regression test for
fork() into a pid namespace whose ancestor lost its init.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

This conflicts with the cifs tree in fs/smb/client/transport.c between
commit 80f49404968d6 ("smb: client: fast fail sends if need to
reconnect") from the cifs tree and commit d0ae35565f5d5 ("smb: prevent
TIF_NOTIFY_SIGNAL from interrupting") from this tree. The cifs tree
bails out early after sock_sendmsg() when a reconnect is needed and
this tree wraps the call in a no_notify_signal guard and drops the
EINTR special case below it:

diff --cc fs/smb/client/transport.c
index cf11af490b0d,93ff6a4dbb35..60699d2799fb
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@@ -171,26 -170,11 +170,22 @@@ smb_send_kvec(struct TCP_Server_Info *s
  		 * after the retries we will kill the socket and
  		 * reconnect which may clear the network problem.
  		 *
- 		 * Even if regular signals are masked, EINTR might be
- 		 * propagated from sk_stream_wait_memory() to here when
- 		 * TIF_NOTIFY_SIGNAL is used for task work. For example,
- 		 * certain io_uring completions will use that. Treat
- 		 * having EINTR with pending task work the same as EAGAIN
- 		 * to avoid unnecessary reconnects.
+ 		 * Task work must not abort the send, see signal_pending().
  		 */
- 		rc = sock_sendmsg(ssocket, smb_msg);
+ 		scoped_guard(no_notify_signal)
+ 			rc = sock_sendmsg(ssocket, smb_msg);
 +
 +		/*
 +		 * If need to reconnect, blame it for any non-interrupt error
 +		 * and bail out early, even if -EAGAIN;  reconnect will never
 +		 * happen in parallel as cifs_reconnect() needs server mutex
 +		 * (which we're already holding), so it's pointless to retry.
 +		 */
 +		if (unlikely(rc <= 0 && !is_interrupt_error(rc) &&
 +			     READ_ONCE(server->tcpStatus) == CifsNeedReconnect))
 +			return -ECONNRESET;
 +
- 		if (rc == -EAGAIN || unlikely(rc == -EINTR && task_work_pending(current))) {
+ 		if (rc == -EAGAIN) {
  			retries++;
  			if (retries >= 14 ||
  			    (!server->noblocksnd && (retries > 2))) {

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/kernel-7.4-rc1.signal

for you to fetch changes up to 12e19bba68ba4ef222033ff9a3b63df07b7fad38:

  pid: use READ_ONCE() in pid_alive() (2026-10-12 11:13:01 +0200)

----------------------------------------------------------------
kernel-7.4-rc1.signal

Please consider pulling these changes from the signed kernel-7.4-rc1.signal tag.

Thanks!
Christian

----------------------------------------------------------------
Babanpreet Singh (1):
      pid: use READ_ONCE() in pid_alive()

Christian Brauner (20):
      signal: allow taks to temporarily block TIF_NOTIFY_SIGNAL
      coredump: prevent TIF_NOTIFY_SIGNAL from interrupting coredumps
      selftests/coredump: test that TIF_NOTIFY_SIGNAL doesn't truncate a coredump
      smb: prevent TIF_NOTIFY_SIGNAL from interrupting
      pid_namespace: prevent TIF_NOTIFY_SIGNAL from interrupting the reaper
      Merge patch series "Stop TIF_NOTIFY_SIGNAL from interrupting work that can't be restarted"
      coredump: hold RCU while releasing parked threads
      io-wq: order the exit bit against worker creation task work
      signal: don't retarget shared signals in a dying thread group
      signal: only SIGKILL and the freezers interrupt a coredumping task
      selftests/coredump: test shared signal retargeting during a dump
      ptrace: refuse to change the signal mask of a user worker
      selftests/coredump: test a user worker as the coredumping thread
      selftests/coredump: expect PTRACE_SETSIGMASK to be refused on a user worker
      exec: cancel io_uring requests before de_thread()
      fork: move the coredump and exec checks into create_io_thread()
      fork: don't create io threads once PF_POSTCOREDUMP is set
      fork: use SIG_KERNEL_ONLY_MASK for the user worker signal mask
      signal: enforce the user worker signal mask in __set_task_blocked()
      Merge patch series "coredump & signals: an impossible affair"

Oleg Nesterov (1):
      pid: document that do_each_pid_task() needs tasklist_lock

Sahaj Chaudhari (1):
      selftests: pid_namespace: test fork with dead ancestor

 fs/coredump.c                                      |  18 +-
 fs/exec.c                                          |  11 +-
 fs/smb/client/transport.c                          |  13 +-
 include/linux/pid.h                                |  11 +-
 include/linux/sched.h                              |   2 +-
 include/linux/sched/signal.h                       |  27 +-
 io_uring/io-wq.c                                   |   2 +
 kernel/fork.c                                      |  11 +-
 kernel/pid.c                                       |   2 +-
 kernel/pid_namespace.c                             |   3 +-
 kernel/ptrace.c                                    |   6 +
 kernel/signal.c                                    |  14 +
 tools/testing/selftests/coredump/.gitignore        |   2 +
 tools/testing/selftests/coredump/Makefile          |  11 +-
 .../selftests/coredump/coredump_notify_signal.h    |  29 ++
 .../coredump/coredump_notify_signal_helper.c       |  46 +++
 .../coredump/coredump_notify_signal_test.c         | 245 +++++++++++
 .../selftests/coredump/coredump_signal_test.c      | 238 +++++++++++
 tools/testing/selftests/coredump/coredump_test.h   |   1 +
 .../selftests/coredump/coredump_test_helpers.c     | 311 ++++++++++++++
 .../selftests/coredump/coredump_worker_test.c      | 447 +++++++++++++++++++++
 tools/testing/selftests/pid_namespace/.gitignore   |   1 +
 tools/testing/selftests/pid_namespace/Makefile     |   2 +-
 .../selftests/pid_namespace/pidns_dead_ancestor.c  | 174 ++++++++
 24 files changed, 1593 insertions(+), 34 deletions(-)
 create mode 100644 tools/testing/selftests/coredump/coredump_notify_signal.h
 create mode 100644 tools/testing/selftests/coredump/coredump_notify_signal_helper.c
 create mode 100644 tools/testing/selftests/coredump/coredump_notify_signal_test.c
 create mode 100644 tools/testing/selftests/coredump/coredump_signal_test.c
 create mode 100644 tools/testing/selftests/coredump/coredump_worker_test.c
 create mode 100644 tools/testing/selftests/pid_namespace/pidns_dead_ancestor.c
