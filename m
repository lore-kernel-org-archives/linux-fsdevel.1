Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932247;
	b=n19Q9jlOtUlmOKoObNxlNPjjFY/NofTbD628LZqMaY/qaeKoe0omp3wKG6hNuIj9fohN
	 frdIr614Bm7j8XD1S/flHuo8/cHc8BECEyYkjLoIjLMJhCN/2isUYY6w6glvvw+qrNNc5
	 NJR5QUl1LTqfy25Chnz0bw57HVNCF5EFNq4UW58vBikjFfUSDJWFuF0KE3GyqvJ49g4ST
	 1pYPMfCIqQDtBr++cWb1rHHxK8SzhaPAPKZ9+bBIkDQkJ4ndU525kIf94tatWsCH7XBpH
	 gIyotAYaPH4a9h/3cGdCedKqculMjgp078TnKjGQmaaxb5rytzQ+trgBcDMuKKhDXFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932247;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rZOWAsmzL6zhtcaYRMPzEf7Ur2JbuXR6/JdYcTWFblQ=;
	b=Zun9yvXI+tr77jZ3mPehV+WChafGCF9rReF5WSq60tk6FEyl3UJmfweExAKACrlMu6Gl
	 S3XP2BG9rf1odwkpTlTikwfovatstoy4H4BMOUkO+kFC3x09A/Oi8QtDkOVerRF3T0N4P
	 sVvSBFTMSBe7/9P8ATRVTsY0Ex7v11+LLmRM/AXxWsWhZpqfC1qvlErC0koJlqmiXae1J
	 vzGyryyf4FAI8X+KFh+6FTaR80dvpU2z1y1AU0Fv/usz5giDxG3zYd8YuN5loLJydy4on
	 IE3dg7L137Th1kIwKqHrf9DOrprvOPA6zoqUC0vorSo5554XcmfUst7CujS/8Zs7F2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=bnfWfI4K;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D39060A3833;
	Tue, 17 Nov 2026 16:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D39060A3833
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=bnfWfI4K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794932244;
	bh=rZOWAsmzL6zhtcaYRMPzEf7Ur2JbuXR6/JdYcTWFblQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bnfWfI4K1nnyP0XjonnpC5sXE+DiltUGaQb1TBL3eTVKAoxj6enTUy4pXXgbPys6f
	 HHyajtg/qE6NCNh+8KAWjDmO+ngX0xtpYMEK3TvOTjKw+/sQ8M6hwgUqtruFwT3Fau
	 x3LN5gYyFuWrdONzdzEehRvVqpbCy000Kb9ta1imJBmxqXMklW9CMYDcPmxDg+6u72
	 zWIZ9ZBODI0a4yX3XeZh9oOTZiwlGObNBvmsjnOxDE9fV3xniUfW1o9+BSAhgvmOkN
	 Ss2MSVPpEirGuAHpYSAEb/RwxcT1ZA0ZaxKFrmBKsaVzyvOUfEwg+q1MOL9DF/fe9g
	 jN4i7UotmfgTg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTVHm0TBJzRZc;
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
Subject: [PATCH 16/17] selftests/rseq: Test affinity changes while a task replaces or drops its mm
Date: Tue, 17 Nov 2026 11:17:16 -0500
Message-Id: <ccc2a6c50429b1ad9c8d5cc45ec8e58c12df7fde.1794932121.git.mathieu.desnoyers@efficios.com>
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

sched_setaffinity() on another task updates the allowed CPUs of the mm
of the target. set_cpus_allowed_common() reads p->mm under p->pi_lock
for that. The commit "sched/mmcid: Synchronize MM teardown with affinity
updates" takes the same lock once p->mm has changed, before the old mm
is dropped.

No test runs an affinity change against such a teardown. Weiming Shi
reported the use after free with a reproducer: one process calls execve()
in a loop while other processes change its affinity.

Add mm_cid_teardown_test. Its first case follows that reproducer. One
process calls execve() on the test in a loop on its own CPU. Up to four
other processes change its affinity between one and two CPUs.

The second case drops an mm instead of replacing one. Short lived
processes exit on one CPU. Another process changes their affinity from a
second CPU. No case covers kthread_unuse_mm().

User space cannot see a read of the freed mm. Only KASAN reports it. So
both cases check that the two sides keep making progress.

The test starts processes, not threads. glibc needs futex(2) to create a
thread. In the exec case, the use after free is only reachable without
CONFIG_FUTEX. With CONFIG_FUTEX, futex_exec_done() already takes
p->pi_lock after the switch to the new mm.

Both cases pass on guests with 2 to 64 CPUs. The first case needs 3 CPUs
and is skipped below that. On the 8-CPU guest:

  # 1629 execve calls, 427211 affinity changes
  ok 1 affinity changes while a task replaces its mm
  # 2140 processes exited, 86658 affinity changes
  ok 2 affinity changes while a task drops its mm

A guest with KASAN and without CONFIG_FUTEX ran ten seconds per case on
8 CPUs. The kernel reported nothing. This kernel had that commit. The
test was not run on a kernel without it.

Suggested-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/all/20261110183809.3308868-2-bestswngs@gmail.com/
---
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../selftests/rseq/mm_cid_teardown_test.c     | 396 ++++++++++++++++++
 2 files changed, 397 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rseq/mm_cid_teardown_test.c

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index d72502fc7652..2735704f516b 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -22,7 +22,7 @@ TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test \
 		 param_test_benchmark param_test_mm_cid_benchmark \
 		 mm_cid_execve_test mm_cid_transition_test \
 		 mm_cid_bound_test mm_cid_exec_affinity_test \
-		 mm_cid_window_test
+		 mm_cid_window_test mm_cid_teardown_test
 
 TEST_GEN_PROGS_EXTENDED = librseq.so \
 	param_test \
diff --git a/tools/testing/selftests/rseq/mm_cid_teardown_test.c b/tools/testing/selftests/rseq/mm_cid_teardown_test.c
new file mode 100644
index 000000000000..f07a566901f8
--- /dev/null
+++ b/tools/testing/selftests/rseq/mm_cid_teardown_test.c
@@ -0,0 +1,396 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * Affinity changes from another task while a task replaces or drops its mm.
+ *
+ * sched_setaffinity(2) on another task updates the allowed CPUs of the mm
+ * of that task. It reads that mm under the pi_lock of the target. The
+ * target can replace its mm in execve(2), or drop it when it exits, on
+ * another CPU at the same time. The old mm is freed right after.
+ *
+ * Case 1: one process calls execve(2) on this test in a loop. Processes on
+ * the other CPUs change its affinity as fast as they can.
+ *
+ * Case 2: short lived processes exit while another process changes their
+ * affinity.
+ *
+ * A read of a freed mm stays invisible to user space. Both cases check
+ * that both sides keep making progress, and that the kernel stays alive.
+ * Under KASAN the kernel reports the read.
+ *
+ * The test uses no thread, so that it also runs on a kernel built without
+ * CONFIG_FUTEX.
+ *
+ * Each case runs for one second. The first argument sets another number of
+ * seconds.
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <poll.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/eventfd.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "rseq.h"
+#include "kselftest.h"
+
+#define MAX_CPUS		256
+#define MAX_SETTERS		4
+#define RUNTIME_S		1
+#define FIRST_EXEC_MS		5000
+#define EXIT_DELAY_STEP_US	7
+#define MAX_EXIT_DELAY_US	200
+
+#define CHILD_PASS		0
+#define CHILD_ERROR		2
+
+/* Shared with the processes that change the affinity. */
+struct shared {
+	unsigned long long	changes[MAX_SETTERS];
+	pid_t			target;		/* the process that exits */
+};
+
+static const char *exec_case = "affinity changes while a task replaces its mm";
+static const char *exit_case = "affinity changes while a task drops its mm";
+
+static int cpus[MAX_CPUS], nr_cpus;
+
+static long long now_us(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return ts.tv_sec * 1000000LL + ts.tv_nsec / 1000;
+}
+
+static void busy_wait_us(int us)
+{
+	long long end = now_us() + us;
+
+	while (now_us() < end)
+		;
+}
+
+static int pin(int cpu)
+{
+	cpu_set_t set;
+
+	CPU_ZERO(&set);
+	CPU_SET(cpu, &set);
+	return sched_setaffinity(0, sizeof(set), &set);
+}
+
+/* Set @one to the CPU @a, and @two to the CPUs @a and @b. */
+static void init_masks(cpu_set_t *one, cpu_set_t *two, int a, int b)
+{
+	CPU_ZERO(one);
+	CPU_SET(a, one);
+	CPU_ZERO(two);
+	CPU_SET(a, two);
+	CPU_SET(b, two);
+}
+
+/*
+ * Change the affinity of @pid, or of the process that exits when @pid is
+ * zero, until @deadline. The two masks alternate, so that every change
+ * reaches the mm of the target. Count the changes and exit.
+ */
+static void setter_main(struct shared *sh, int index, pid_t pid, int cpu,
+			int a, int b, long long deadline)
+{
+	unsigned long long changes = 0;
+	cpu_set_t one, two;
+	int i = 0;
+
+	if (prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0)) {
+		fprintf(stderr, "prctl(PR_SET_PDEATHSIG): %s\n", strerror(errno));
+		_exit(CHILD_ERROR);
+	}
+	init_masks(&one, &two, a, b);
+	if (pin(cpu)) {
+		fprintf(stderr, "sched_setaffinity: %s\n", strerror(errno));
+		_exit(CHILD_ERROR);
+	}
+	while (now_us() < deadline) {
+		const cpu_set_t *mask = (i++ & 1) ? &one : &two;
+		pid_t target = pid ? pid : RSEQ_READ_ONCE(sh->target);
+
+		if (!target)
+			continue;
+		if (!sched_setaffinity(target, sizeof(*mask), mask)) {
+			changes++;
+			continue;
+		}
+		/* The target can exit first: ESRCH is expected. */
+		if (errno != ESRCH) {
+			fprintf(stderr, "sched_setaffinity: %s\n", strerror(errno));
+			_exit(CHILD_ERROR);
+		}
+	}
+	sh->changes[index] = changes;
+	_exit(CHILD_PASS);
+}
+
+/* Count this instance of the process under test. Then call execve(2) again. */
+static int exec_loop_main(char **argv)
+{
+	long long end = atoll(argv[3]);
+	uint64_t one = 1;
+	int fd = atoi(argv[2]);
+
+	if (write(fd, &one, sizeof(one)) != sizeof(one))
+		return CHILD_ERROR;
+	if (now_us() >= end)
+		return CHILD_PASS;
+	execv("/proc/self/exe", argv);
+	fprintf(stderr, "execv: %s\n", strerror(errno));
+	return CHILD_ERROR;
+}
+
+/* Add the counts pending on @fd to @total. */
+static int drain(int fd, unsigned long long *total)
+{
+	for (;;) {
+		uint64_t value;
+		ssize_t ret = read(fd, &value, sizeof(value));
+
+		if (ret == sizeof(value)) {
+			*total += value;
+			continue;
+		}
+		if (ret < 0 && errno == EINTR)
+			continue;
+		if (ret < 0 && errno == EAGAIN)
+			return 0;
+		return -1;
+	}
+}
+
+/*
+ * Wait for the first instance of the process under test. Return -1 if it
+ * does not come.
+ */
+static int wait_first_exec(int fd, unsigned long long *execs)
+{
+	struct pollfd pfd = { .fd = fd, .events = POLLIN };
+	int ret;
+
+	do {
+		ret = poll(&pfd, 1, FIRST_EXEC_MS);
+	} while (ret < 0 && errno == EINTR);
+	if (ret != 1)
+		return -1;
+	if (drain(fd, execs) || !*execs)
+		return -1;
+	return 0;
+}
+
+/*
+ * Start the process under test on the CPU @cpu. It counts its instances
+ * through @fd and leaves its loop at @end. Return its pid.
+ */
+static pid_t start_exec_loop(char *name, int cpu, int fd, long long end)
+{
+	char mode[] = "exec-loop", fd_arg[16], end_arg[32];
+	char *const av[] = { name, mode, fd_arg, end_arg, NULL };
+	pid_t pid;
+
+	snprintf(fd_arg, sizeof(fd_arg), "%d", fd);
+	snprintf(end_arg, sizeof(end_arg), "%lld", end);
+	pid = fork();
+	if (pid)
+		return pid;
+	if (prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0)) {
+		fprintf(stderr, "prctl(PR_SET_PDEATHSIG): %s\n", strerror(errno));
+		_exit(CHILD_ERROR);
+	}
+	if (pin(cpu)) {
+		fprintf(stderr, "sched_setaffinity: %s\n", strerror(errno));
+		_exit(CHILD_ERROR);
+	}
+	execv("/proc/self/exe", av);
+	fprintf(stderr, "execv: %s\n", strerror(errno));
+	_exit(CHILD_ERROR);
+}
+
+/* Wait for the process @pid. Return its exit status, or -1. */
+static int wait_status(pid_t pid)
+{
+	int status;
+	pid_t ret;
+
+	do {
+		ret = waitpid(pid, &status, 0);
+	} while (ret < 0 && errno == EINTR);
+	if (ret != pid || !WIFEXITED(status))
+		return -1;
+	return WEXITSTATUS(status);
+}
+
+/* Case 1. Change the affinity of a process that calls execve(2) in a loop. */
+static void run_exec_case(char *name, int runtime_s, struct shared *sh)
+{
+	unsigned long long execs = 0, changes = 0;
+	int a = cpus[nr_cpus - 2], b = cpus[nr_cpus - 1];
+	pid_t victim, setters[MAX_SETTERS];
+	int fd, i, nset, status = 0;
+	long long deadline;
+	pid_t ret;
+
+	nset = nr_cpus - 2 < MAX_SETTERS ? nr_cpus - 2 : MAX_SETTERS;
+	fd = eventfd(0, EFD_NONBLOCK);
+	if (fd < 0)
+		ksft_exit_fail_msg("eventfd: %s\n", strerror(errno));
+	/* The process under test outlives those that change its affinity. */
+	victim = start_exec_loop(name, a, fd,
+				 now_us() + (runtime_s + 1) * 1000000LL);
+	if (victim < 0)
+		ksft_exit_fail_msg("fork: %s\n", strerror(errno));
+	if (wait_first_exec(fd, &execs))
+		ksft_exit_fail_msg("the process under test did not call execve\n");
+
+	deadline = now_us() + runtime_s * 1000000LL;
+	for (i = 0; i < nset; i++) {
+		setters[i] = fork();
+		if (!setters[i])
+			setter_main(sh, i, victim, cpus[i], a, b, deadline);
+		if (setters[i] < 0)
+			ksft_exit_fail_msg("fork: %s\n", strerror(errno));
+	}
+	for (i = 0; i < nset; i++) {
+		if (wait_status(setters[i]))
+			ksft_exit_fail_msg("a process that changes the affinity failed\n");
+		changes += sh->changes[i];
+	}
+	if (drain(fd, &execs))
+		ksft_exit_fail_msg("read the count of the execve calls: %s\n",
+				   strerror(errno));
+
+	/* The process under test must still be in its loop. */
+	ret = waitpid(victim, &status, WNOHANG);
+	if (ret < 0)
+		ksft_exit_fail_msg("waitpid: %s\n", strerror(errno));
+	if (ret) {
+		ksft_print_msg("the process under test left its loop: 0x%x\n",
+			       status);
+		ksft_test_result_fail("%s\n", exec_case);
+		if (close(fd))
+			ksft_exit_fail_msg("close: %s\n", strerror(errno));
+		return;
+	}
+	if (kill(victim, SIGKILL))
+		ksft_exit_fail_msg("kill: %s\n", strerror(errno));
+	if (waitpid(victim, &status, 0) != victim)
+		ksft_exit_fail_msg("waitpid: %s\n", strerror(errno));
+	if (close(fd))
+		ksft_exit_fail_msg("close: %s\n", strerror(errno));
+
+	ksft_print_msg("%llu execve calls, %llu affinity changes\n",
+		       execs, changes);
+	ksft_test_result(execs && changes, "%s\n", exec_case);
+}
+
+/* Case 2. Change the affinity of processes while they exit. */
+static void run_exit_case(int runtime_s, const cpu_set_t *all,
+			  struct shared *sh)
+{
+	unsigned long long children = 0;
+	int a = cpus[0], b = cpus[1];
+	int delay = 0, bad = 0;
+	long long deadline;
+	pid_t setter, pid;
+
+	deadline = now_us() + runtime_s * 1000000LL;
+	if (pin(a))
+		ksft_exit_fail_msg("sched_setaffinity: %s\n", strerror(errno));
+	setter = fork();
+	if (!setter)
+		setter_main(sh, 0, 0, b, a, b, deadline);
+	if (setter < 0)
+		ksft_exit_fail_msg("fork: %s\n", strerror(errno));
+
+	while (now_us() < deadline) {
+		pid = fork();
+		if (!pid) {
+			/* Exit while the affinity of this process changes. */
+			busy_wait_us(delay);
+			_exit(CHILD_PASS);
+		}
+		if (pid < 0)
+			ksft_exit_fail_msg("fork: %s\n", strerror(errno));
+		RSEQ_WRITE_ONCE(sh->target, pid);
+		if (wait_status(pid))
+			bad++;
+		RSEQ_WRITE_ONCE(sh->target, 0);
+		children++;
+		/* The next process exits later, relative to the changes. */
+		delay = (delay + EXIT_DELAY_STEP_US) % MAX_EXIT_DELAY_US;
+	}
+	if (wait_status(setter))
+		ksft_exit_fail_msg("the process that changes the affinity failed\n");
+	if (sched_setaffinity(0, sizeof(*all), all))
+		ksft_exit_fail_msg("sched_setaffinity: %s\n", strerror(errno));
+
+	if (bad)
+		ksft_print_msg("%d processes out of %llu did not exit cleanly\n",
+			       bad, children);
+	ksft_print_msg("%llu processes exited, %llu affinity changes\n",
+		       children, sh->changes[0]);
+	ksft_test_result(!bad && children && sh->changes[0], "%s\n", exit_case);
+}
+
+int main(int argc, char **argv)
+{
+	int runtime_s = RUNTIME_S;
+	struct shared *sh;
+	cpu_set_t all;
+	int cpu;
+
+	if (argc == 4 && !strcmp(argv[1], "exec-loop"))
+		return exec_loop_main(argv);
+	if (argc > 1 && atoi(argv[1]) > 0)
+		runtime_s = atoi(argv[1]);
+
+	ksft_print_header();
+	ksft_set_plan(2);
+
+	if (!rseq_available())
+		ksft_exit_skip("rseq is unavailable\n");
+	if (rseq_register_current_thread())
+		ksft_exit_fail_msg("rseq_register_current_thread: %s\n",
+				   strerror(errno));
+	if (!rseq_mm_cid_available())
+		ksft_exit_skip("the rseq mm_cid field is unavailable\n");
+	if (sched_getaffinity(0, sizeof(all), &all))
+		ksft_exit_fail_msg("sched_getaffinity: %s\n", strerror(errno));
+	for (cpu = 0; cpu < CPU_SETSIZE && nr_cpus < MAX_CPUS; cpu++) {
+		if (CPU_ISSET(cpu, &all))
+			cpus[nr_cpus++] = cpu;
+	}
+	sh = mmap(NULL, sizeof(*sh), PROT_READ | PROT_WRITE,
+		  MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (sh == MAP_FAILED)
+		ksft_exit_fail_msg("mmap: %s\n", strerror(errno));
+
+	/* One CPU for the tested process, one to move it to, one to run on. */
+	if (nr_cpus < 3)
+		ksft_test_result_skip("%s: fewer than 3 CPUs\n", exec_case);
+	else
+		run_exec_case(argv[0], runtime_s, sh);
+
+	if (nr_cpus < 2)
+		ksft_test_result_skip("%s: fewer than 2 CPUs\n", exit_case);
+	else
+		run_exit_case(runtime_s, &all, sh);
+
+	ksft_finished();
+}
-- 
2.47.3

