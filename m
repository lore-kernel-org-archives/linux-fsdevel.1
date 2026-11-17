Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932247;
	b=FI/HVTZvkC9iIY+MuXD5PpJkkrGhuzvVnEUQl63w9z4+/iw4HiOrqo1p7hkhd3B16PRS
	 x8/whnxIO/SRHyXimya6BzshtySyReVyFYM/bIK1+IqHYQ8RiSJnCEQgdiIdV1emYmnON
	 tI+9iUgD2W2j7KVyMYZLYeBlDDyIFIeZvVCqo4qyL2h74aPOBpzJaViMT+zPEY97ibQ23
	 MRR/I8Qmat3h/QmE8jr0KnMgnmejyStXc5OwQbVAF7GvYxk0aYUQKRLUC1V68+buHuMHK
	 U5LHnX+pFFqXs/9Dln1fAEsVJfKGlTm096lyIq7RSRRgKXH1GtBH/HIA6mLaalQu7Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932247;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VMaH7ncXgUaF/SAZyIEJ09F0d1AAXdXj0Fwfw45wOkw=;
	b=Eu+hlgknwfk0QX+eJRJTRyX3l09Er+Ky3Cp6ODy/8xutrHasVan7dHqPRlVpmEudPexi
	 nCdoicSL9sBUUefZ2olF8msFaRU6FZ4F4DeKn2tLe+7A3k5a+B5cdmr6xJ9BJDvwVWCga
	 DJ9qubWCt/XFhj5R8ZpmRfnO90c+16tPwzMSZ1oXAEH7W/yX3EX23E7Xr08nc8f73EKlR
	 SNwG9DSEkJGgXsZXYM6ag5Wh62i8xM3IDLZi+40ifSWKp7L1382bnI99eCXOvhMhNDoN5
	 AxvKP/gqSwyvQvBdI2Q0DcN18mm7INW2XRpz/FHEMNNCvVLwMSAQ482og1XtSYak4+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Ld6kYFGN;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCCE60A383F;
	Tue, 17 Nov 2026 16:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDCCE60A383F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Ld6kYFGN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794932244;
	bh=VMaH7ncXgUaF/SAZyIEJ09F0d1AAXdXj0Fwfw45wOkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ld6kYFGN8+9i+Ta9EVeDmC2GfyAhOREeF712IrrqiO3lTzxC6eXf3cw9nW3GqA6NI
	 rsCZefon6yKn1y9b9gFON1Zavzgc7i1q2+ULlexCyFB2iyrgx3Yg0BO4gPO+FXwzej
	 3dKHvpD/QRwtqAAU75rp8Tfpi9lk6VkcT6bRgDZOoqq02Pr7LROXoamlCkIZsfV06T
	 YBSeSV0Q5mlQrloHyA/t2RJNtbpN5PFbZPZC40rjErEUxv5WvY/Zvua0Ggkrk44tkY
	 OL+FCjJecOJeUgGThZLs36opaONu3AYFeLYfbZQDYxhYZxZsQVmrqtbj4zPMwYxQJy
	 OklliLYXiEhVg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTVHm1gcmzQvX;
	Tue, 17 Nov 2026 11:17:24 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: tglx@kernel.org,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	paulmck@kernel.org,
	boqun@kernel.org,
	shuah@kernel.org,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	oleg@redhat.com,
	bestswngs@gmail.com,
	xmei5@asu.edu,
	xujiakai24@mails.ucas.ac.cn,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 17/17] selftests/rseq: Test the last user after an affinity change during execve
Date: Tue, 17 Nov 2026 11:17:17 -0500
Message-Id: <860cb09b164607f1be056ef688f5cec80eea3782.1794932121.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794932121.git.mathieu.desnoyers@efficios.com>
References: <cover.1794932121.git.mathieu.desnoyers@efficios.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last user case of mm_cid_execve_test needs per CPU mode to last down
to one thread. With two allowed CPUs, the kernel only does that with two
or three possible CPUs. The case is skipped on larger machines.

The kernel also keeps per CPU mode down to one thread when the mm counts
one allowed CPU, on any machine. Only one CPU then owns a CID, unless
the thread runs on a CPU that the mm does not count. That happens when
another process changes its affinity during an execve(): the mm has no
user then, and mm_update_cpus_allowed() ignores it.

Add a case that builds this state and then fails execve() as the last
user on one CPU, to rejoin on another. The comment above
run_child_widened() has the sequence as a diagram. The single thread
must read mm_cid 0 on both CPUs at the end.

Without "sched/mmcid: Reset stale state when the first user joins an
mm", on guests with 4, 8 and 64 CPUs:

  single thread, mm_cid 1 on CPU 0 after a move from CPU 1 to CPU 0
  not ok 3 mm_cid of a single thread after its affinity was widened during execve

The thread still reads 1 one second later. With that commit, the case
passes on guests with 2 to 64 CPUs.

The failing kernel also lacked "sched/mmcid: Take the allowed CPUs of
the first user when it joins". That commit records the affinity change
when the task rejoins, so the state is not reached with it. With that
commit and without the reset, the case passes on guests with 2 to 64
CPUs.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../selftests/rseq/mm_cid_execve_test.c       | 235 +++++++++++++++++-
 1 file changed, 232 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rseq/mm_cid_execve_test.c b/tools/testing/selftests/rseq/mm_cid_execve_test.c
index baf06af574bd..8e357d255747 100644
--- a/tools/testing/selftests/rseq/mm_cid_execve_test.c
+++ b/tools/testing/selftests/rseq/mm_cid_execve_test.c
@@ -17,6 +17,11 @@
  * CPUs. The case is skipped when a single thread reads 0 on both CPUs
  * before the execve(2).
  *
+ * A third case covers the last user on a machine of any size. The kernel
+ * also keeps per CPU mode down to one thread when the mm counts one
+ * allowed CPU. The case makes such a thread run on a second CPU. The
+ * diagram above run_child_widened() has the sequence.
+ *
  * Per CPU mode needs more threads than the mm has CIDs. The number of CIDs
  * follows the union of the allowed CPUs of the threads, which only grows.
  * The affinity is therefore narrowed before the fork(2) that creates the
@@ -33,8 +38,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
+#include <time.h>
 #include <unistd.h>
 
 #include "rseq.h"
@@ -357,6 +364,209 @@ static int run_child_moved(int delay_us)
 	return ret;
 }
 
+/* What the process under test and its helper share in run_child_widened(). */
+struct widen_shared {
+	int phase;
+	int widened;
+};
+
+static int widen_cpu[NARROW_CPUS];
+
+static uint64_t now_ms(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return (uint64_t)ts.tv_sec * 1000 + ts.tv_nsec / 1000000;
+}
+
+/* Spin until @sh->phase reaches @phase. Return false after two seconds. */
+static bool widen_wait(struct widen_shared *sh, int phase)
+{
+	uint64_t end = now_ms() + 2000;
+
+	while (RSEQ_READ_ONCE(sh->phase) < phase) {
+		if (now_ms() > end)
+			return false;
+	}
+	return true;
+}
+
+/*
+ * The helper of run_child_widened(). @pid is the process under test, which
+ * starts on the CPU @a.
+ * - Phase 1: widen the affinity of @pid to @a and @b, @delay_us after the
+ *   start of its first execve(2) loop.
+ * - Phase 2: keep the CPU @a busy, so that the scheduler moves @pid to @b.
+ * - Phase 3: move @pid back to @a, @delay_us after the start of its second
+ *   execve(2) loop.
+ * Return the exit status of the helper.
+ */
+static int widen_helper(struct widen_shared *sh, pid_t pid, int a, int b, int delay_us)
+{
+	cpu_set_t set;
+
+	/* Run beside the process under test, not on its CPU. */
+	CPU_ZERO(&set);
+	CPU_SET(b, &set);
+	if (sched_setaffinity(0, sizeof(set), &set) || !widen_wait(sh, 1))
+		return 1;
+	usleep(delay_us);
+	CPU_SET(a, &set);
+	if (sched_setaffinity(pid, sizeof(set), &set))
+		return 1;
+	RSEQ_WRITE_ONCE(sh->widened, 1);
+
+	if (!widen_wait(sh, 2))
+		return 1;
+	CPU_ZERO(&set);
+	CPU_SET(a, &set);
+	if (sched_setaffinity(0, sizeof(set), &set) || !widen_wait(sh, 3))
+		return 1;
+	usleep(delay_us);
+	return !!sched_setaffinity(pid, sizeof(set), &set);
+}
+
+/*
+ * Fail execve(2) on @path MOVE_EXECS times. Return 0, or -1 after reporting
+ * an error other than ENOEXEC.
+ */
+static int fail_execs(char *path)
+{
+	int i;
+
+	for (i = 0; i < MOVE_EXECS; i++) {
+		char *const av[] = { path, NULL };
+
+		if (execve(path, av, NULL) == -1 && errno != ENOEXEC) {
+			fprintf(stderr, "execve(%s): %s, expected ENOEXEC\n",
+				path, strerror(errno));
+			return -1;
+		}
+	}
+	return 0;
+}
+
+/*
+ * The third process under test, P. A and B are two CPUs. P starts with A
+ * as its only allowed CPU. H is a helper process. It makes the affinity
+ * changes: a change made by P itself would reach the mm.
+ *
+ *   P                                     H
+ *
+ *   execve() fails, in a loop
+ *     leaves the mm: no user left
+ *                                         sched_setaffinity(P, {A, B})
+ *                                           the mm has no user: its count
+ *                                           of allowed CPUs stays 1
+ *     rejoins the mm
+ *   creates a thread
+ *     the mm switches to per CPU mode
+ *   joins the thread
+ *     one user left, still per CPU mode
+ *                                         keeps A busy
+ *   is moved to B by the scheduler
+ *     A and B each own a CID
+ *   execve() fails, in a loop
+ *     leaves the mm on B: no user left
+ *                                         sched_setaffinity(P, {A})
+ *     rejoins the mm on A
+ *   visits A and B
+ *
+ * P must read 0 on both CPUs at the end. Each change of H has to land
+ * while P is inside an execve(), so the case runs many times with a
+ * different delay.
+ * Return a CHILD_* status.
+ */
+static int run_child_widened(int delay_us)
+{
+	int a = widen_cpu[0], b = widen_cpu[1], i, status, ret = CHILD_PASS;
+	struct widen_shared *sh;
+	pid_t helper, self = getpid();
+	char path[PATH_MAX];
+	pthread_t thread;
+	uint64_t end;
+
+	sh = mmap(NULL, sizeof(*sh), PROT_READ | PROT_WRITE,
+		  MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (sh == MAP_FAILED)
+		return CHILD_ERROR;
+	if (make_unknown_format_file(path, sizeof(path))) {
+		fprintf(stderr, "no directory to run an unknown format file from\n");
+		return CHILD_SKIP;
+	}
+	helper = fork();
+	if (helper < 0) {
+		remove_file(path);
+		return CHILD_ERROR;
+	}
+	if (!helper)
+		_exit(widen_helper(sh, self, a, b, delay_us));
+
+	RSEQ_WRITE_ONCE(sh->phase, 1);
+	if (fail_execs(path)) {
+		ret = CHILD_ERROR;
+		goto out;
+	}
+	end = now_ms() + 2000;
+	while (!RSEQ_READ_ONCE(sh->widened) && now_ms() < end)
+		;
+	if (!RSEQ_READ_ONCE(sh->widened)) {
+		ret = CHILD_ERROR;
+		goto out;
+	}
+
+	if (pthread_create(&thread, NULL, waiter, NULL)) {
+		ret = CHILD_ERROR;
+		goto out;
+	}
+	RSEQ_WRITE_ONCE(stop, 1);
+	if (join_thread(thread)) {
+		ret = CHILD_ERROR;
+		goto out;
+	}
+
+	/* No affinity change by this process: it would reach the mm. */
+	RSEQ_WRITE_ONCE(sh->phase, 2);
+	end = now_ms() + 2000;
+	while (sched_getcpu() != b && now_ms() < end)
+		;
+	if (sched_getcpu() != b) {
+		fprintf(stderr, "the scheduler did not move the process to CPU %d\n", b);
+		ret = CHILD_SKIP;
+		goto out;
+	}
+
+	RSEQ_WRITE_ONCE(sh->phase, 3);
+	if (fail_execs(path)) {
+		ret = CHILD_ERROR;
+		goto out;
+	}
+out:
+	if (ret != CHILD_PASS)
+		kill(helper, SIGKILL);
+	if (waitpid(helper, &status, 0) != helper ||
+	    (ret == CHILD_PASS && (!WIFEXITED(status) || WEXITSTATUS(status))))
+		ret = CHILD_ERROR;
+	if (remove_file(path) && ret == CHILD_PASS)
+		ret = CHILD_ERROR;
+
+	/* The first visit lets the kernel settle, the second one is judged. */
+	for (i = 0; i < 2 * NARROW_CPUS && ret == CHILD_PASS; i++) {
+		unsigned int cid = cid_on_cpu(widen_cpu[i % NARROW_CPUS]);
+
+		if (cid == UINT_MAX) {
+			ret = CHILD_ERROR;
+		} else if (i >= NARROW_CPUS && cid) {
+			fprintf(stderr,
+				"single thread, mm_cid %u on CPU %d after a move from CPU %d to CPU %d\n",
+				cid, widen_cpu[i % NARROW_CPUS], b, a);
+			ret = CHILD_FAIL;
+		}
+	}
+	return ret;
+}
+
 /* Keep the first @nr CPUs of @src in @dst. */
 static int narrow_cpus(cpu_set_t *dst, const cpu_set_t *src, int nr)
 {
@@ -424,11 +634,13 @@ static int run_child_threads(int unused)
 
 int main(void)
 {
-	cpu_set_t allowed, narrow;
-	int status, i;
+	static const char widened[] =
+		"mm_cid of a single thread after its affinity was widened during execve";
+	cpu_set_t allowed, narrow, one;
+	int status, i, cpu, nr = 0;
 
 	ksft_print_header();
-	ksft_set_plan(2);
+	ksft_set_plan(3);
 
 	if (!rseq_available())
 		ksft_exit_skip("rseq is unavailable\n");
@@ -452,5 +664,22 @@ int main(void)
 			break;
 	}
 	report(status, "mm_cid of a single thread after a failed execve on another CPU");
+
+	for (cpu = 0; cpu < CPU_SETSIZE && nr < NARROW_CPUS; cpu++) {
+		if (CPU_ISSET(cpu, &narrow))
+			widen_cpu[nr++] = cpu;
+	}
+	if (nr < NARROW_CPUS) {
+		ksft_test_result_skip("%s: fewer than %d CPUs\n", widened, NARROW_CPUS);
+		ksft_finished();
+	}
+	narrow_cpus(&one, &allowed, 1);
+	/* Both changes of the helper have to land inside an execve. */
+	for (i = 0; i < 2 * ATTEMPTS; i++) {
+		status = run_under_test(run_child_widened, (i * 37) % 1000, &one, &allowed);
+		if (status != CHILD_PASS)
+			break;
+	}
+	report(status, widened);
 	ksft_finished();
 }
-- 
2.47.3

