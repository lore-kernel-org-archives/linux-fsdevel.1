Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E623139890D;
	Sun, 24 May 2026 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779633941; cv=none; b=jLa9CzZRDOZ3EQtezyeM+iCPxt0tS6cbjnSebBpj8V/YNLaRjLrpalg2bZ7mt6Jc6MwxOJRx0GqBwkerbM5SQKkEi6tJr2DLau3zr2+I6BiNGSzwIemSVTpdrd8LSlyPHV/t3n4Ug0n/nz3sIQpk/B21s2BNIQOuj1AVcGfcdtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779633941; c=relaxed/simple;
	bh=vrgPMxOumI6zrhKkRv/KGS1G1qcBT0IVwthBlUkvXsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hw4c3fGfakZiqhVLOktTX+kVjdFnK0jTT0tiwGTg9mpALGtJScdseXReDozt4pTuoelLcz9PuRL173Zr41tBZaxQN+paDg0El1rwK5Z/UBzN6S1fPLpA/DgtCQd+r2/C4CB4RkHvcqea1nX7Mp0QsNwhc+o7ectl8JlFoLV3+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=VXnTE9uS; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="VXnTE9uS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=AisOawA93lKhnrPRg87kaIuZBpJLV4Bu9j9lJhZlX0k=; b=VXnTE9uSrUN4McRRJpRPakN+Ex
	wpVvzQj9iqY4jwLSCUlc2tZ0VKgvi7m476Mh0CBVc5/v9fsnv0jLXgkfF23wH/Qz1+eY5w9C4wbMe
	+E3DmB745vZskXi88sQHq44RwR/tXUEDmdKYGX770neD9mQoI4aM21pqn7loyxPdMKezmMZ0Sv4fP
	xUUxjW3lZmx6OV3MxDWWQfzoemViIbEXuNGznX8NNHwIvCR1s5vIUHvgjYGdZNwPbiCgis/oeezDI
	qeGzZiaOsdOE51aZu4sjKK6cilCedVq558q8ZUjRJKxmuOi7AzsTN/w2At1ZDx/W7GUoEaExAncyr
	/riBpTVA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wRA53-000s6p-0w;
	Sun, 24 May 2026 14:45:29 +0000
From: Breno Leitao <leitao@debian.org>
Date: Sun, 24 May 2026 07:44:59 -0700
Subject: [PATCH v3 2/2] selftests/pipe: add pipe_bench microbenchmark
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-fix_pipe-v3-2-bb4a75d23a90@debian.org>
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
In-Reply-To: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Shuah Khan <shuah@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev, jlayton@kernel.org, 
 oleg@redhat.com, axboe@kernel.dk, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=18756; i=leitao@debian.org;
 h=from:subject:message-id; bh=vrgPMxOumI6zrhKkRv/KGS1G1qcBT0IVwthBlUkvXsI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqEw76jAJeWx5kyt2l6RmomvqTPkyY8wSvX2Igs
 wIureG0q/WJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCahMO+gAKCRA1o5Of/Hh3
 bZq+D/9N1HN6Y6nrmwLV3uGzH0/W6SGGXaHncsfFqBqQO72kCyXOBZjiU86yMJrWuj3Fesy71tJ
 bGMDqRRhuw0d+QhzcZgL0cTRgsOnNWC1jFdwCUM0j5NuXxSQ1/L6Ge3Dj6hwRqhf+mW2wBSbjgP
 RQWrQyzDxrjIFzAWmW2upp16Y3CbZWYO5dLkqHTm4FwirtNsAzjQqLw60JZe2awW3leIY8JqoVJ
 iMcHd5BLx2q19ONXCGibJKMZfMLhGUAWZpePWft2i+5JB+x/805rEwaohP4RX5D7j0uO0Z3DiDa
 FXALye/jbgU6lfhahmU2SMVLMKKRO7W9w/C7CypNOpxZqnzYR2GeZP5GpiAKsTBZoeM9uKjzw/K
 t6JxfLw1sj1Ck460DmJWn9/5Tde8mllEppqXlyH9oGQVX5parNHI1wbTMs2ZIDrNTq526L7DJvI
 UYWo34y+EwfEj+YyX3oxHWJDDBbDqm+A8wyEA3T3eSuUGDFxQKdaXiZjO7d9hPouvzfva5YLviR
 r0V17BpE19S2INA7B8nO6X4MyDM+VUWhgKYf1Esaz+bbBHw4WCPsN+pwUySaSA1JDDjfKRhy662
 scQ5wRWh1OBYR3yNCPYOfAKCW97A4mHlVQLRzvtoXR2XsR5tSSyUOSMnkuaLjOhsyLr+79T9RdQ
 42qla5zybosU/VQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Add a small selftest that stresses pipe->mutex contention by spawning N
writer threads that hammer a single pipe with multi-page writes, plus M
reader threads that drain. Each writer records its own write() latency
samples into a log2-bucketed histogram; main aggregates and prints
total writes, throughput, average and percentile (p50/p99) latencies,
and the maximum observed latency.

Pass --memory-pressure to fork stress-ng (--vm 4 --vm-bytes 80%
--vm-method all) for the duration of the run, so alloc_page() in
anon_pipe_write() routinely hits direct reclaim. The flag fails
fast if stress-ng is not on $PATH.

Program print something like the following, for different writes,
readers, msgsizes and memory pressure:

	config: writers=X readers=Y msgsize=Z duration=3 pipe_size=1048576
	memory_pressure=[no|yes]
	writes: total=54451 rate=18150/s
	throughput_MBps: 1134.40
	lat_avg_ns: 275355
	lat_p50_ns_upper: 262143
	lat_p99_ns_upper: 1048575
	lat_max_ns: 2145633

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/Makefile          |   1 +
 tools/testing/selftests/pipe/.gitignore   |   1 +
 tools/testing/selftests/pipe/Makefile     |   9 +
 tools/testing/selftests/pipe/pipe_bench.c | 616 ++++++++++++++++++++++++++++++
 4 files changed, 627 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6e59b8f63e41..bcd9db9d292c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -91,6 +91,7 @@ TARGETS += pcie_bwctrl
 TARGETS += perf_events
 TARGETS += pidfd
 TARGETS += pid_namespace
+TARGETS += pipe
 TARGETS += power_supply
 TARGETS += powerpc
 TARGETS += prctl
diff --git a/tools/testing/selftests/pipe/.gitignore b/tools/testing/selftests/pipe/.gitignore
new file mode 100644
index 000000000000..20b549361a15
--- /dev/null
+++ b/tools/testing/selftests/pipe/.gitignore
@@ -0,0 +1 @@
+pipe_bench
diff --git a/tools/testing/selftests/pipe/Makefile b/tools/testing/selftests/pipe/Makefile
new file mode 100644
index 000000000000..1810c680117b
--- /dev/null
+++ b/tools/testing/selftests/pipe/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Meta Platforms, Inc. and affiliates
+# Copyright (c) 2026 Breno Leitao <leitao@debian.org>
+
+CFLAGS += -O2 -Wall -Wextra -pthread
+
+TEST_GEN_PROGS := pipe_bench
+
+include ../lib.mk
diff --git a/tools/testing/selftests/pipe/pipe_bench.c b/tools/testing/selftests/pipe/pipe_bench.c
new file mode 100644
index 000000000000..7e96429b8fb4
--- /dev/null
+++ b/tools/testing/selftests/pipe/pipe_bench.c
@@ -0,0 +1,616 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pipe_bench - exercise concurrent pipe operation
+ *
+ * N writer threads hammer a single pipe with multi-page writes; M reader
+ * threads drain it. Each writer records its own write() latency histogram.
+ * Multi-page writes (msgsize >= PAGE_SIZE) force the loop in
+ * anon_pipe_write() to call alloc_page(GFP_HIGHUSER | __GFP_ACCOUNT) under
+ * pipe->mutex, which is the critical section the patch shrinks.
+ *
+ * By default the benchmark sweeps writers in {1, 2, 5} x readers in
+ * {1, 5, 10} and prints one block per configuration so two runs (e.g.
+ * baseline vs patched) can be diffed directly. Pass -w and -r to run a
+ * single configuration instead. Pass --memory-pressure to spawn stress-ng
+ * alongside the sweep so the per-page alloc_page() path under pipe->mutex
+ * has to dip into reclaim.
+ *
+ * Copyright (c) 2026 Meta Platforms, Inc. and affiliates
+ * Copyright (c) 2026 Breno Leitao <leitao@debian.org>
+ */
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <poll.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdatomic.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+
+#define ARRAY_SIZE(a)	(sizeof(a) / sizeof((a)[0]))
+#define HIST_BUCKETS	32
+
+static size_t g_msgsize = 16 * 4096;
+static int g_duration = 3;
+static int g_pipe_size = 1024 * 1024;
+static int g_memory_pressure;
+
+static atomic_int g_stop;
+static int g_pipe[2];
+
+struct wstats {
+	uint64_t writes;
+	uint64_t bytes;
+	uint64_t lat_sum_ns;
+	uint64_t lat_max_ns;
+	uint64_t lat_hist[HIST_BUCKETS];
+	char *buf;
+};
+
+struct rstats {
+	char *buf;
+};
+
+struct hist_totals {
+	uint64_t writes;
+	uint64_t bytes;
+	uint64_t lat_sum;
+	uint64_t lat_max;
+};
+
+static inline uint64_t now_ns(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return (uint64_t)ts.tv_sec * 1000000000ull + (uint64_t)ts.tv_nsec;
+}
+
+static inline int log2_bucket(uint64_t v)
+{
+	int b = 0;
+
+	if (!v)
+		return 0;
+	while (v >>= 1)
+		b++;
+	return b < HIST_BUCKETS ? b : HIST_BUCKETS - 1;
+}
+
+static void *writer(void *arg)
+{
+	struct wstats *s = arg;
+
+	while (!atomic_load_explicit(&g_stop, memory_order_relaxed)) {
+		uint64_t t0 = now_ns();
+		ssize_t n = write(g_pipe[1], s->buf, g_msgsize);
+		uint64_t dt = now_ns() - t0;
+
+		if (n > 0) {
+			s->writes++;
+			s->bytes += (uint64_t)n;
+			s->lat_sum_ns += dt;
+			if (dt > s->lat_max_ns)
+				s->lat_max_ns = dt;
+			s->lat_hist[log2_bucket(dt)]++;
+		} else if (n < 0 && (errno == EPIPE || errno == EBADF)) {
+			break;
+		}
+	}
+	return NULL;
+}
+
+static void *reader(void *arg)
+{
+	struct rstats *s = arg;
+
+	/*
+	 * Drain until EOF (write end closed by main). g_stop is not checked
+	 * here on purpose: writers may be blocked in write() with the pipe
+	 * full when g_stop is set, so the reader must keep draining until
+	 * main closes the write end.
+	 */
+	for (;;) {
+		ssize_t n = read(g_pipe[0], s->buf, g_msgsize);
+
+		if (n <= 0)
+			break;
+	}
+	return NULL;
+}
+
+/* Sum per-writer stats and per-bucket counts into the caller's aggregates. */
+static void aggregate_wstats(struct wstats *all, int nw,
+			     uint64_t agg[HIST_BUCKETS],
+			     struct hist_totals *t)
+{
+	memset(t, 0, sizeof(*t));
+	for (int i = 0; i < nw; i++) {
+		t->writes += all[i].writes;
+		t->bytes += all[i].bytes;
+		t->lat_sum += all[i].lat_sum_ns;
+		if (all[i].lat_max_ns > t->lat_max)
+			t->lat_max = all[i].lat_max_ns;
+		for (int b = 0; b < HIST_BUCKETS; b++)
+			agg[b] += all[i].lat_hist[b];
+	}
+}
+
+/*
+ * Walk @agg in order, returning the inclusive upper bound (in ns) of the
+ * log2 bucket where the running sum first reaches @target.
+ *
+ * A percentile is undefined with zero samples, and with very low sample
+ * counts integer truncation could make @target zero -- then "cum >= 0"
+ * would latch on the first (possibly empty) bucket. Callers must pass
+ * @target >= 1.
+ */
+static uint64_t bucket_at(const uint64_t agg[HIST_BUCKETS], uint64_t target)
+{
+	uint64_t cum = 0;
+
+	for (int b = 0; b < HIST_BUCKETS; b++) {
+		/* HIST_BUCKETS <= 63, so (b + 1) is always a safe shift. */
+		uint64_t upper = (1ULL << (b + 1)) - 1;
+
+		cum += agg[b];
+		if (cum >= target)
+			return upper;
+	}
+	return 0;
+}
+
+static void compute_p50_p99(const uint64_t agg[HIST_BUCKETS], uint64_t writes,
+			    uint64_t *p50, uint64_t *p99)
+{
+	uint64_t p50_target, p99_target;
+
+	*p50 = *p99 = 0;
+	if (!writes)
+		return;
+
+	p50_target = writes * 50 / 100;
+	p99_target = writes * 99 / 100;
+	if (!p50_target)
+		p50_target = 1;
+	if (!p99_target)
+		p99_target = 1;
+
+	*p50 = bucket_at(agg, p50_target);
+	*p99 = bucket_at(agg, p99_target);
+}
+
+static void print_summary(int nw, int nr, const struct hist_totals *t,
+			  uint64_t p50, uint64_t p99)
+{
+	double sec = g_duration;
+	uint64_t avg_ns = t->writes ? t->lat_sum / t->writes : 0;
+
+	printf("config: writers=%d readers=%d msgsize=%zu duration=%d pipe_size=%d memory_pressure=%s\n",
+	       nw, nr, g_msgsize, g_duration, g_pipe_size,
+	       g_memory_pressure ? "yes" : "no");
+	printf("writes: total=%llu rate=%.0f/s\n",
+	       (unsigned long long)t->writes, (double)t->writes / sec);
+	printf("throughput_MBps: %.2f\n",
+	       ((double)t->bytes / sec) / (1024.0 * 1024.0));
+	printf("lat_avg_ns: %llu\n", (unsigned long long)avg_ns);
+	printf("lat_p50_ns_upper: %llu\n", (unsigned long long)p50);
+	printf("lat_p99_ns_upper: %llu\n", (unsigned long long)p99);
+	printf("lat_max_ns: %llu\n", (unsigned long long)t->lat_max);
+}
+
+static void summarize(struct wstats *all, int nw, int nr)
+{
+	uint64_t agg[HIST_BUCKETS] = {0};
+	struct hist_totals t;
+	uint64_t p50, p99;
+
+	aggregate_wstats(all, nw, agg, &t);
+	compute_p50_p99(agg, t.writes, &p50, &p99);
+	print_summary(nw, nr, &t, p50, p99);
+}
+
+/*
+ * Child branch of fork(): restore SIGPIPE to default (parent ignores it),
+ * exec stress-ng, and on failure write the reason into @hs_wr before
+ * exiting. The parent observes EOF on hs_wr (closed via O_CLOEXEC) when
+ * exec succeeds.
+ */
+static void stress_ng_child(int hs_wr) __attribute__((noreturn));
+static void stress_ng_child(int hs_wr)
+{
+	char errbuf[256];
+
+	signal(SIGPIPE, SIG_DFL);
+	execlp("stress-ng", "stress-ng",
+	       "--vm", "4", "--vm-bytes", "80%",
+	       "--vm-method", "all",
+	       (char *)NULL);
+	snprintf(errbuf, sizeof(errbuf),
+		 "exec stress-ng failed: %s\n", strerror(errno));
+	(void)!write(hs_wr, errbuf, strlen(errbuf));
+	_exit(127);
+}
+
+/*
+ * Read from the O_CLOEXEC handshake pipe. Anything readable means the
+ * child wrote an error before exec; EOF (n == 0) means the write-end
+ * closed because exec succeeded. Returns 0 on exec success, -1 if the
+ * child failed and was reaped.
+ */
+static int stress_ng_wait_handshake(int hs_rd, pid_t pid)
+{
+	struct pollfd pfd = { .fd = hs_rd, .events = POLLIN };
+	char errbuf[256];
+	int status;
+	int ret;
+
+	ret = poll(&pfd, 1, 500);
+	if (ret <= 0)
+		return 0;
+
+	ssize_t n = read(hs_rd, errbuf, sizeof(errbuf) - 1);
+
+	if (n > 0) {
+		errbuf[n] = '\0';
+		fputs(errbuf, stderr);
+		waitpid(pid, &status, 0);
+		return -1;
+	}
+	return 0;
+}
+
+static pid_t spawn_stress_ng(void)
+{
+	int hs[2];
+	pid_t pid;
+
+	/*
+	 * Handshake pipe: child writes one byte and _exit()s on exec
+	 * failure. On exec success the O_CLOEXEC flag closes the write
+	 * end, which the parent observes as EOF. This makes the "is
+	 * stress-ng on $PATH?" check fail fast rather than silently.
+	 */
+	if (pipe2(hs, O_CLOEXEC) < 0) {
+		perror("pipe2");
+		return -1;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		perror("fork");
+		close(hs[0]);
+		close(hs[1]);
+		return -1;
+	}
+	if (pid == 0) {
+		close(hs[0]);
+		stress_ng_child(hs[1]);
+	}
+
+	close(hs[1]);
+	if (stress_ng_wait_handshake(hs[0], pid) < 0) {
+		close(hs[0]);
+		return -1;
+	}
+	close(hs[0]);
+
+	/* Give stress-ng a moment to map its VM regions before measuring. */
+	sleep(1);
+	return pid;
+}
+
+static void kill_stress_ng(pid_t pid)
+{
+	int status;
+
+	if (pid <= 0)
+		return;
+	kill(pid, SIGTERM);
+	for (int i = 0; i < 20; i++) {
+		if (waitpid(pid, &status, WNOHANG) > 0)
+			return;
+		usleep(100 * 1000);
+	}
+	kill(pid, SIGKILL);
+	waitpid(pid, &status, 0);
+}
+
+/*
+ * Allocate per-thread page-aligned buffers in main so a failed
+ * aligned_alloc() aborts the run before any thread starts. Workers used
+ * to allocate their own buffer and return NULL on failure, which left
+ * peers blocked in write()/read() with nobody to unblock them.
+ */
+static int alloc_thread_bufs(struct wstats *ws, int nw,
+			     struct rstats *rs, int nr)
+{
+	for (int i = 0; i < nw; i++) {
+		ws[i].buf = aligned_alloc(4096, g_msgsize);
+		if (!ws[i].buf) {
+			fprintf(stderr, "writer %d: aligned_alloc(%zu) failed\n",
+				i, g_msgsize);
+			return -1;
+		}
+		memset(ws[i].buf, 0xAA, g_msgsize);
+	}
+	for (int i = 0; i < nr; i++) {
+		rs[i].buf = aligned_alloc(4096, g_msgsize);
+		if (!rs[i].buf) {
+			fprintf(stderr, "reader %d: aligned_alloc(%zu) failed\n",
+				i, g_msgsize);
+			return -1;
+		}
+	}
+	return 0;
+}
+
+static void free_thread_bufs(struct wstats *ws, int nw,
+			     struct rstats *rs, int nr)
+{
+	if (ws)
+		for (int i = 0; i < nw; i++)
+			free(ws[i].buf);
+	if (rs)
+		for (int i = 0; i < nr; i++)
+			free(rs[i].buf);
+}
+
+static int start_readers(pthread_t *rt, struct rstats *rs, int nr,
+			 int *created)
+{
+	for (int i = 0; i < nr; i++) {
+		int err = pthread_create(&rt[i], NULL, reader, &rs[i]);
+
+		if (err) {
+			fprintf(stderr, "pthread_create reader %d: %s\n",
+				i, strerror(err));
+			return -1;
+		}
+		(*created)++;
+	}
+	return 0;
+}
+
+static int start_writers(pthread_t *wt, struct wstats *ws, int nw,
+			 int *created)
+{
+	for (int i = 0; i < nw; i++) {
+		int err = pthread_create(&wt[i], NULL, writer, &ws[i]);
+
+		if (err) {
+			fprintf(stderr, "pthread_create writer %d: %s\n",
+				i, strerror(err));
+			return -1;
+		}
+		(*created)++;
+	}
+	return 0;
+}
+
+static int open_bench_pipe(void)
+{
+	if (pipe(g_pipe) < 0) {
+		perror("pipe");
+		return -1;
+	}
+	if (fcntl(g_pipe[1], F_SETPIPE_SZ, g_pipe_size) < 0)
+		perror("F_SETPIPE_SZ (continuing)");
+	return 0;
+}
+
+/*
+ * Normal termination: g_stop tells writers to leave the loop after the
+ * current write() returns. Closing the shared write-end fd means once
+ * the in-flight writes drain, readers see EOF and exit. Writers are not
+ * unblocked by EPIPE here -- g_pipe[0] stays open so readers can keep
+ * draining.
+ *
+ * Error path: some threads may have been created and others skipped, so
+ * writers could be blocked in write() with no reader making progress.
+ * Close both ends -- closing the read end is what delivers EPIPE to a
+ * blocked writer.
+ */
+static void stop_and_join(pthread_t *wt, int nw_created,
+			  pthread_t *rt, int nr_created, int rc)
+{
+	atomic_store(&g_stop, 1);
+	close(g_pipe[1]);
+	if (rc < 0)
+		close(g_pipe[0]);
+	for (int i = 0; i < nw_created; i++)
+		pthread_join(wt[i], NULL);
+	for (int i = 0; i < nr_created; i++)
+		pthread_join(rt[i], NULL);
+	if (rc == 0)
+		close(g_pipe[0]);
+}
+
+static int run_one(int nw, int nr)
+{
+	pthread_t *wt = NULL, *rt = NULL;
+	struct wstats *ws = NULL;
+	struct rstats *rs = NULL;
+	int nw_created = 0, nr_created = 0;
+	int rc = 0;
+
+	atomic_store(&g_stop, 0);
+
+	if (open_bench_pipe() < 0)
+		return -1;
+
+	wt = calloc((size_t)nw, sizeof(*wt));
+	rt = calloc((size_t)nr, sizeof(*rt));
+	ws = calloc((size_t)nw, sizeof(*ws));
+	rs = calloc((size_t)nr, sizeof(*rs));
+	if (!wt || !rt || !ws || !rs) {
+		fprintf(stderr, "alloc failed\n");
+		rc = -1;
+		goto teardown;
+	}
+
+	if (alloc_thread_bufs(ws, nw, rs, nr) < 0) {
+		rc = -1;
+		goto teardown;
+	}
+
+	if (start_readers(rt, rs, nr, &nr_created) < 0 ||
+	    start_writers(wt, ws, nw, &nw_created) < 0) {
+		rc = -1;
+		goto teardown;
+	}
+
+	sleep((unsigned int)g_duration);
+
+teardown:
+	stop_and_join(wt, nw_created, rt, nr_created, rc);
+
+	if (rc == 0) {
+		summarize(ws, nw, nr);
+		fflush(stdout);
+	}
+
+	free_thread_bufs(ws, nw, rs, nr);
+	free(wt);
+	free(rt);
+	free(ws);
+	free(rs);
+	return rc;
+}
+
+static void usage(const char *prog)
+{
+	fprintf(stderr,
+		"usage: %s [-w writers] [-r readers] [-s msgsize] [-d secs] [-p pipe_size] [--memory-pressure]\n"
+		"  default: sweep writers={1,2,5} x readers={1,5,10}\n"
+		"  --memory-pressure: spawn stress-ng (--vm 4 --vm-bytes 80%% --vm-method all) for the run\n",
+		prog);
+}
+
+static int parse_args(int argc, char **argv,
+		      int *writers_override, int *readers_override)
+{
+	static const struct option long_opts[] = {
+		{"memory-pressure", no_argument, NULL, 'M'},
+		{0, 0, 0, 0},
+	};
+	int opt;
+
+	while ((opt = getopt_long(argc, argv, "w:r:s:d:p:",
+				  long_opts, NULL)) != -1) {
+		switch (opt) {
+		case 'w':
+			*writers_override = atoi(optarg);
+			break;
+		case 'r':
+			*readers_override = atoi(optarg);
+			break;
+		case 's':
+			g_msgsize = (size_t)atol(optarg);
+			break;
+		case 'd':
+			g_duration = atoi(optarg);
+			break;
+		case 'p':
+			g_pipe_size = atoi(optarg);
+			break;
+		case 'M':
+			g_memory_pressure = 1;
+			break;
+		default:
+			usage(argv[0]);
+			return -1;
+		}
+	}
+	return 0;
+}
+
+/*
+ * aligned_alloc(4096, size) requires size to be a multiple of the
+ * alignment (C11); glibc returns NULL otherwise, which would make
+ * writer/reader threads silently exit and the run report zero writes.
+ * Validate up front instead.
+ */
+static int validate_args(void)
+{
+	if (g_msgsize == 0 || g_msgsize % 4096 != 0) {
+		fprintf(stderr,
+			"msgsize must be a positive multiple of 4096 (got %zu)\n",
+			g_msgsize);
+		return -1;
+	}
+	if (g_duration <= 0) {
+		fprintf(stderr, "duration must be > 0 seconds (got %d)\n",
+			g_duration);
+		return -1;
+	}
+	if (g_pipe_size <= 0) {
+		fprintf(stderr, "pipe_size must be > 0 bytes (got %d)\n",
+			g_pipe_size);
+		return -1;
+	}
+	return 0;
+}
+
+static int run_sweep(void)
+{
+	static const int writers_sweep[] = {1, 2, 5};
+	static const int readers_sweep[] = {1, 5, 10};
+
+	for (size_t i = 0; i < ARRAY_SIZE(writers_sweep); i++) {
+		for (size_t j = 0; j < ARRAY_SIZE(readers_sweep); j++) {
+			printf("---\n");
+			if (run_one(writers_sweep[i], readers_sweep[j]) < 0)
+				return -1;
+		}
+	}
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	int writers_override = 0, readers_override = 0;
+	pid_t stress_pid = -1;
+	int rc = 0;
+
+	if (parse_args(argc, argv, &writers_override, &readers_override) < 0)
+		return 1;
+	if (validate_args() < 0)
+		return 1;
+
+	signal(SIGPIPE, SIG_IGN);
+	setvbuf(stdout, NULL, _IOLBF, 0);
+	setvbuf(stderr, NULL, _IOLBF, 0);
+
+	fprintf(stderr, "pid=%d\n", getpid());
+	fflush(stderr);
+
+	if (g_memory_pressure) {
+		stress_pid = spawn_stress_ng();
+		if (stress_pid < 0) {
+			fprintf(stderr,
+				"memory_pressure requested but stress-ng could not be spawned\n");
+			return 1;
+		}
+	}
+
+	if (writers_override > 0 || readers_override > 0) {
+		int nw = writers_override > 0 ? writers_override : 1;
+		int nr = readers_override > 0 ? readers_override : 1;
+
+		rc = run_one(nw, nr) < 0 ? 1 : 0;
+	} else {
+		rc = run_sweep() < 0 ? 1 : 0;
+	}
+
+	kill_stress_ng(stress_pid);
+	return rc;
+}

-- 
2.54.0

