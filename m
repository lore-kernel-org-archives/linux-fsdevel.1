Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932244;
	b=Gks3f3HTRDzMyksFIozOR441V4cohdtGidDtxnl4FKGfokfM9r3eL0xcLExHCjp++HtT
	 nmBTGwoPlKNBpXgDwNzH61V91AL8n/71hlev4yg/DnXE9JcFlnknhfwhA9FNN20juyRFc
	 kuTEC6YzUgAWEexDCfueqjfHznO++wFkHmR7dG/WzEvWgi0bBaWDlhs5iBGJ+/Z0bXzri
	 x40ZYNEVORZVoJXfBBSduEboPRnc8OGCe/0bn6phUqNP8V6JCEw9zWkFLO0wbf5gWMoPn
	 XliLgZja7PMIP74ZaoOCYSlVI0DWcFEMV6c/WcpQ4Tp1y37H3whb8ImOlStZjhNEt4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932244;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+eRx1E6OH5BWB9d5HcLPoxdra5i7n/GKknl+XwKvzvo=;
	b=K6SaBchEDJx/eyzMdwbepZ6APsaL+SE3Pbu02VeSXEuIqHGvuSwh/Aez42Q8oO/oPANc
	 xh1ecYkFitBYXHMEMNbrynA0b1vOpuFjrO3ePpyTpAMSuVSh0aeONE5S7aQ4lv3f4fM/P
	 hCaP+Uzor3ye0hOqlm39AHfT1uQDOxg3FWjOqcEvpKxbnTVKO4GlPI3yL59AJZ8Cylu/d
	 e9BjALkP2nwORLvHoAO33xvnCnHk6C2AY7ga8nP0ZAHr+Ax8ZNplKxaOmY16PMBaFoAj3
	 dlJxynfBCs4UrnKdCV+apiuUGR2VqW+frOn5G1DkOtPhYSh4sDZNjivEZnvU8087OjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Vaijihsd;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E1606A8A5;
	Tue, 17 Nov 2026 16:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E34E1606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Vaijihsd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794932242;
	bh=+eRx1E6OH5BWB9d5HcLPoxdra5i7n/GKknl+XwKvzvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VaijihsdwJaRa3EvSnvIUEnozhcyghOQX54nWMDjeOq21qx5YlTxvH7DuenVqGtMc
	 wHBqvaw3a9PNAv1zyJatMiqCvhf2hilK/B9dlbZyWYqgnN7orv7Kl0fBfhM4xIJJHc
	 hhdp/r8ArlKocaYxtSTNZn30uyVXVz+7FSrUz5L2YQORjKsHXHKWj6g4Tg8379VDsR
	 wW16RNsgg52yVWkNHPQvtfYrn4G7C5OIx+LQPa6rxFk1PmqZXiB8Nlwpq5VEFmbaTG
	 u3cniGwtTk2Uao2D8vU0ydFmfekv3KXo4SZ59j3F9QlybLCfGec+bGD112FUmvX3yC
	 4ArXra86KkKcQ==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTVHk5bqrzRmt;
	Tue, 17 Nov 2026 11:17:22 -0500 (EST)
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
Subject: [PATCH 08/17] selftests/rseq: Test the concurrency ID after the last user fails execve
Date: Tue, 17 Nov 2026 11:17:08 -0500
Message-Id: <5c5ce3c68394929160f30955037c0ba642a66d34.1794932121.git.mathieu.desnoyers@efficios.com>
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

A failed execve() leaves the mm and rejoins it. When the caller is the
only thread left, it leaves as the last user and rejoins as the first
one. The kernel must not keep state of the previous users across that.

Add a case to mm_cid_execve_test. Four threads make the mm switch to per
CPU mode on two CPUs, then exit. The remaining thread fails execve() in
a loop on one CPU while a helper process moves it to the other CPU. It
then visits both CPUs and must read mm_cid 0 on each.

The move has to land inside an execve(), so the case runs 50 times with
a different delay each time.

With two allowed CPUs, the kernel keeps per CPU mode down to one thread
only on a machine with two or three possible CPUs. Elsewhere the single
thread reads mm_cid 0 on both CPUs before the execve(), and the case is
skipped.

Without "sched/mmcid: Reset stale state when the first user joins an
mm", on guests with two and three CPUs (six runs out of six):

  single thread, mm_cid 1 on CPU 0 after a failed execve moved from CPU 0 to CPU 1
  not ok 2 mm_cid of a single thread after a failed execve on another CPU

With it (six runs out of six):

  ok 2 mm_cid of a single thread after a failed execve on another CPU

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../selftests/rseq/mm_cid_execve_test.c       | 236 +++++++++++++++---
 1 file changed, 208 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/rseq/mm_cid_execve_test.c b/tools/testing/selftests/rseq/mm_cid_execve_test.c
index 3d8b9365ce91..baf06af574bd 100644
--- a/tools/testing/selftests/rseq/mm_cid_execve_test.c
+++ b/tools/testing/selftests/rseq/mm_cid_execve_test.c
@@ -8,6 +8,15 @@
  * running and the other threads are still users. The task returns to user
  * space before any schedule in, so the join has to give it a CID.
  *
+ * A second case covers the last user. A process that is back to a single
+ * thread fails execve(2) while another process moves it to another CPU.
+ * It leaves its mm as the last user on one CPU and rejoins it as the first
+ * user on the other. A single thread must read 0 afterwards. That case
+ * needs per CPU mode to last down to one thread. With the two allowed CPUs
+ * of the test, the kernel only does that with at most three possible
+ * CPUs. The case is skipped when a single thread reads 0 on both CPUs
+ * before the execve(2).
+ *
  * Per CPU mode needs more threads than the mm has CIDs. The number of CIDs
  * follows the union of the allowed CPUs of the threads, which only grows.
  * The affinity is therefore narrowed before the fork(2) that creates the
@@ -19,6 +28,7 @@
 #include <limits.h>
 #include <pthread.h>
 #include <sched.h>
+#include <signal.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -33,6 +43,8 @@
 #define NARROW_CPUS	2
 #define THREADS		4
 #define ROUNDS		100
+#define ATTEMPTS	50
+#define MOVE_EXECS	300
 
 /* Exit status of the process under test. */
 #define CHILD_PASS	0
@@ -204,6 +216,147 @@ static int run_child(void)
 	return ret;
 }
 
+/* Run on @cpu and return the mm_cid read there. */
+static unsigned int cid_on_cpu(int cpu)
+{
+	cpu_set_t one;
+
+	CPU_ZERO(&one);
+	CPU_SET(cpu, &one);
+	if (sched_setaffinity(0, sizeof(one), &one))
+		return UINT_MAX;
+	return rseq_current_mm_cid();
+}
+
+/*
+ * The second process under test. Its threads make the mm switch to per
+ * CPU mode and exit. The last thread then fails execve(2) in a loop on the
+ * CPU @from. A helper process moves it to the CPU @to, @delay_us after the
+ * start of the loop. The thread then visits both CPUs and must read 0 on
+ * each.
+ * Return a CHILD_* status.
+ */
+static int run_child_moved(int delay_us)
+{
+	pthread_t thread[THREADS];
+	char path[PATH_MAX];
+	int cpus[NARROW_CPUS], nr = 0, cpu, i, started = 0, ret = CHILD_PASS;
+	int from, to, go[2], status;
+	unsigned int cid0, cid1;
+	cpu_set_t mask, one;
+	pid_t helper, self = getpid();
+	char c = 0;
+
+	if (sched_getaffinity(0, sizeof(mask), &mask))
+		return CHILD_ERROR;
+	for (cpu = 0; cpu < CPU_SETSIZE && nr < NARROW_CPUS; cpu++) {
+		if (CPU_ISSET(cpu, &mask))
+			cpus[nr++] = cpu;
+	}
+	if (nr < NARROW_CPUS) {
+		fprintf(stderr, "fewer than %d allowed CPUs\n", NARROW_CPUS);
+		return CHILD_SKIP;
+	}
+	if (make_unknown_format_file(path, sizeof(path))) {
+		fprintf(stderr, "no directory to run an unknown format file from\n");
+		return CHILD_SKIP;
+	}
+
+	for (i = 0; i < THREADS; i++) {
+		if (pthread_create(&thread[i], NULL, waiter, NULL))
+			break;
+		started++;
+	}
+	/* Run on both CPUs while the threads exist: each CPU takes a CID. */
+	for (i = 0; i < 2 * NARROW_CPUS; i++)
+		cid_on_cpu(cpus[i % NARROW_CPUS]);
+	RSEQ_WRITE_ONCE(stop, 1);
+	for (i = 0; i < started; i++) {
+		if (join_thread(thread[i]))
+			ret = CHILD_ERROR;
+	}
+	if (ret != CHILD_PASS || started < THREADS) {
+		ret = CHILD_ERROR;
+		goto out;
+	}
+
+	cid0 = cid_on_cpu(cpus[0]);
+	cid1 = cid_on_cpu(cpus[1]);
+	if (cid0 == UINT_MAX || cid1 == UINT_MAX) {
+		ret = CHILD_ERROR;
+		goto out;
+	}
+	/* The CPUs own the CIDs only if one of them reads above 0. */
+	if (!cid0 && !cid1) {
+		fprintf(stderr, "the mm is not in per CPU mode with a single thread\n");
+		ret = CHILD_SKIP;
+		goto out;
+	}
+	/* Leave from the CPU that does not hold CID 0, rejoin on the other. */
+	from = cid0 ? cpus[0] : cpus[1];
+	to = from == cpus[0] ? cpus[1] : cpus[0];
+	cid_on_cpu(from);
+
+	if (pipe(go)) {
+		ret = CHILD_ERROR;
+		goto out;
+	}
+	helper = fork();
+	if (helper < 0) {
+		close(go[0]);
+		close(go[1]);
+		ret = CHILD_ERROR;
+		goto out;
+	}
+	if (!helper) {
+		/* Run beside the process under test, not on its CPU. */
+		CPU_ZERO(&one);
+		CPU_SET(to, &one);
+		if (sched_setaffinity(0, sizeof(one), &one) || read(go[0], &c, 1) != 1)
+			_exit(1);
+		usleep(delay_us);
+		_exit(!!sched_setaffinity(self, sizeof(one), &one));
+	}
+	if (write(go[1], &c, 1) != 1) {
+		/* The helper waits for that byte. */
+		kill(helper, SIGKILL);
+		ret = CHILD_ERROR;
+	}
+	for (i = 0; i < MOVE_EXECS; i++) {
+		char *const av[] = { path, NULL };
+
+		if (execve(path, av, NULL) == -1 && errno != ENOEXEC) {
+			fprintf(stderr, "execve(%s): %s, expected ENOEXEC\n",
+				path, strerror(errno));
+			ret = CHILD_ERROR;
+			break;
+		}
+	}
+	if (waitpid(helper, &status, 0) != helper || !WIFEXITED(status) ||
+	    WEXITSTATUS(status))
+		ret = CHILD_ERROR;
+	close(go[0]);
+	close(go[1]);
+
+	/* The first visit lets the kernel settle, the second one is judged. */
+	for (i = 0; i < 2 * NARROW_CPUS && ret == CHILD_PASS; i++) {
+		unsigned int cid = cid_on_cpu(cpus[i % NARROW_CPUS]);
+
+		if (cid == UINT_MAX) {
+			ret = CHILD_ERROR;
+		} else if (i >= NARROW_CPUS && cid) {
+			fprintf(stderr,
+				"single thread, mm_cid %u on CPU %d after a failed execve moved from CPU %d to CPU %d\n",
+				cid, cpus[i % NARROW_CPUS], from, to);
+			ret = CHILD_FAIL;
+		}
+	}
+out:
+	if (remove_file(path) && ret == CHILD_PASS)
+		ret = CHILD_ERROR;
+	return ret;
+}
+
 /* Keep the first @nr CPUs of @src in @dst. */
 static int narrow_cpus(cpu_set_t *dst, const cpu_set_t *src, int nr)
 {
@@ -219,58 +372,85 @@ static int narrow_cpus(cpu_set_t *dst, const cpu_set_t *src, int nr)
 	return taken;
 }
 
-int main(void)
+/*
+ * Run @fn(@arg) in a new process and return its exit status. The affinity
+ * is @narrow when its mm is created. The union of allowed CPUs of an mm
+ * starts there and only grows.
+ */
+static int run_under_test(int (*fn)(int), int arg, const cpu_set_t *narrow,
+			  const cpu_set_t *allowed)
 {
-	cpu_set_t allowed, narrow;
 	int status = 0;
 	pid_t child;
 
-	ksft_print_header();
-	ksft_set_plan(1);
-
-	if (!rseq_available())
-		ksft_exit_skip("rseq is unavailable\n");
-	/* glibc before 2.35 registers no rseq area. */
-	if (rseq_register_current_thread())
-		ksft_exit_fail_msg("rseq_register_current_thread: %s\n", strerror(errno));
-	if (!rseq_mm_cid_available())
-		ksft_exit_skip("the rseq mm_cid field is unavailable\n");
-	if (sched_getaffinity(0, sizeof(allowed), &allowed))
-		ksft_exit_fail_msg("sched_getaffinity: %s\n", strerror(errno));
-	if (!narrow_cpus(&narrow, &allowed, NARROW_CPUS))
-		ksft_exit_skip("no CPU to run on\n");
-
-	/*
-	 * Narrow before the fork(2). The mm of the child starts with these
-	 * allowed CPUs, and a later narrowing does not shrink them.
-	 */
-	if (sched_setaffinity(0, sizeof(narrow), &narrow))
+	if (sched_setaffinity(0, sizeof(*narrow), narrow))
 		ksft_exit_skip("sched_setaffinity: %s\n", strerror(errno));
 	child = fork();
 	if (!child)
-		_exit(run_child());
+		_exit(fn(arg));
 	if (child < 0)
 		ksft_exit_fail_msg("fork: %s\n", strerror(errno));
-	if (sched_setaffinity(0, sizeof(allowed), &allowed))
+	if (sched_setaffinity(0, sizeof(*allowed), allowed))
 		ksft_exit_fail_msg("sched_setaffinity: %s\n", strerror(errno));
 	if (waitpid(child, &status, 0) != child)
 		ksft_exit_fail_msg("waitpid: %s\n", strerror(errno));
 	if (!WIFEXITED(status))
 		ksft_exit_fail_msg("the process under test was killed by signal %d\n",
 				   WTERMSIG(status));
+	return WEXITSTATUS(status);
+}
 
-	switch (WEXITSTATUS(status)) {
+static void report(int status, const char *name)
+{
+	switch (status) {
 	case CHILD_PASS:
-		ksft_test_result_pass("mm_cid after a failed execve\n");
+		ksft_test_result_pass("%s\n", name);
 		break;
 	case CHILD_SKIP:
-		ksft_test_result_skip("mm_cid after a failed execve\n");
+		ksft_test_result_skip("%s\n", name);
 		break;
 	case CHILD_FAIL:
-		ksft_test_result_fail("mm_cid after a failed execve\n");
+		ksft_test_result_fail("%s\n", name);
 		break;
 	default:
 		ksft_exit_fail_msg("the process under test failed to run\n");
 	}
+}
+
+static int run_child_threads(int unused)
+{
+	return run_child();
+}
+
+int main(void)
+{
+	cpu_set_t allowed, narrow;
+	int status, i;
+
+	ksft_print_header();
+	ksft_set_plan(2);
+
+	if (!rseq_available())
+		ksft_exit_skip("rseq is unavailable\n");
+	/* glibc before 2.35 registers no rseq area. */
+	if (rseq_register_current_thread())
+		ksft_exit_fail_msg("rseq_register_current_thread: %s\n", strerror(errno));
+	if (!rseq_mm_cid_available())
+		ksft_exit_skip("the rseq mm_cid field is unavailable\n");
+	if (sched_getaffinity(0, sizeof(allowed), &allowed))
+		ksft_exit_fail_msg("sched_getaffinity: %s\n", strerror(errno));
+	if (!narrow_cpus(&narrow, &allowed, NARROW_CPUS))
+		ksft_exit_skip("no CPU to run on\n");
+
+	status = run_under_test(run_child_threads, 0, &narrow, &allowed);
+	report(status, "mm_cid after a failed execve");
+
+	/* The helper's move has to land inside an execve: spread its delay. */
+	for (i = 0; i < ATTEMPTS; i++) {
+		status = run_under_test(run_child_moved, (i * 37) % 1000, &narrow, &allowed);
+		if (status != CHILD_PASS)
+			break;
+	}
+	report(status, "mm_cid of a single thread after a failed execve on another CPU");
 	ksft_finished();
 }
-- 
2.47.3

