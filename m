Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4344444CF34;
	Fri, 15 May 2026 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840948; cv=none; b=qir24mP0IlQ7+4s4ntt2c4tTIyzXnPLsSTj6NmEwWentMCT53DQGeWBbjLkmr+FYgrZpm4k9dyYxRXU9BsuLLPCqgyJRJvSjarJbCEKKBDMzTHqVF28/2h6W8+7U32AezJlvwkNN+mOiLG6YqipGBN1ifwp/MQiIEjLIIv/1lXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840948; c=relaxed/simple;
	bh=m4i7PFdLlUnqCYqxMfa+Q5xPbTjCIMkbcSCwB3xnLgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KAvdfRlXr0WpTBrmHvWXB7dFmy5OFp0k2wQ3vh5330lAxO+PcIdwwaybtI18GRDlqz5gklCcP2zvHqL21EwpNQonNenxOgYmBKr52TEhOXSxqFeo+tyOiwQtus1eM1G5gzElOYoBHvb4rrXsiEpEGkkT3hlSer7+4yRzZ+JP8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=RUAEB/1f; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="RUAEB/1f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=g6M0G7xa3gkyrDAsFQTV6ZevphthtWis3w+qpXkc1IE=; b=RUAEB/1fZjMSkc2KRP+ThU1sG9
	uuAQvbsY5m11jJThtmok+wCoXXGAPxAEmkLhUU8qCzfKiOaI0rXfhC4+kAg+IeTwYtfPs9r6dPAZp
	jL08HfwnvkPs8MNkm3jZsWOFjbXoZm3yePSqROgQRuB32dekBL/N8ZeMR/d6vXfjD4qXYV6J3xoGf
	Xrk28yWTygy3dnx2Ep+0qHuv6mRXRKIhO9AtOMzWEJR3cAgek7pV3j0e+HMuyfTVsHXSy+lURC3V9
	3QLzDW3czqPGXJzNZ6SaOJKh1e5lfeL8jCxNyV7CNU/znD91X4DWf5tUfXHb6oTveYtkX1r02Pbes
	gHmXyKRg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wNpmx-004fTy-1W;
	Fri, 15 May 2026 10:29:03 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 15 May 2026 03:28:45 -0700
Subject: [PATCH 2/2] selftests/pipe: add pipe_bench microbenchmark
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-fix_pipe-v1-2-b14c840c7555@debian.org>
References: <20260515-fix_pipe-v1-0-b14c840c7555@debian.org>
In-Reply-To: <20260515-fix_pipe-v1-0-b14c840c7555@debian.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 usama.arif@linux.dev, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=12094; i=leitao@debian.org;
 h=from:subject:message-id; bh=m4i7PFdLlUnqCYqxMfa+Q5xPbTjCIMkbcSCwB3xnLgI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqBvVi7rSMMc7Rtye391f+acYxLNVd4aoYM1gVw
 lDiO8C+HY2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCagb1YgAKCRA1o5Of/Hh3
 bYTNEACZLi7GN6mwm0UMF2ed5AwXhzuIMGmB+ylEzE6y3kpGEKnp+XPTyXxP3dBOozSWrWL4y+n
 JVJWDmtyUrqbZlCCG4Ykr2Ms8PA59ZNvVoaznb+frMkekOPguUHTJtOdsNicBsuZPgoFigVRQM6
 4sSwhlEkxcigLQeohtB4zktlYxb7qCQQBBt0/4Lx3StOHDm8ErIwo0Slk9IaeMR30o09DfxO1pF
 SMPDPLRqhbJQHGaJ3mE0RILRWT1rufE/ackS9kJs7/qGwQhJ3hVyCKeBn+npf+Fru4sJKLMmfp+
 S5tq877Xsm2wRJ7ic/1UIFqNLAwysYU/DBbM+OGIrv8oi/prDMfmXWZFsJFkhlarzScvjazixwr
 pneDXe9ss3adctUFN35/z1xidrhTKXAIzyd6PbKpjS8Iz6pinEJkSfeV0aQROsM8Q5KlQdK13vU
 1QG8qlTKL20rAYFD1zadgtq7RkTOPzpkkbpdDctHH3Qer3lsh8u5ISvSC70HpIPQxcSQD5gkUfM
 kHNFiUDh9lXA7QOd8UtBGkp9TywTpl0C/6SN8xdPykwXjqQr+u+wyrOrlzRBhXy+H44CVvhPeRS
 KyI5PRcGKFLrd6QraQd6lOrd8RmPgDWExkwXD7VccuMYnuQPZdMHha31dAijTSZNNqiDetS7mkK
 wTLf4R6jlsQy2lw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Add a small selftest that stresses pipe->mutex contention by spawning N
writer threads that hammer a single pipe with multi-page writes, plus M
reader threads that drain. Each writer records its own write() latency
samples into a log2-bucketed histogram; main aggregates and prints
total writes, throughput, average and percentile (p50/p99/p99.9)
latencies, and the maximum observed latency.

This was used to validate "fs/pipe: bulk pre-allocate pages outside
pipe->mutex in anon_pipe_write". By default it sweeps over
writers={1,2,5} x readers={1,5,10} using 64KB writes for 3s on a 1 MB
pipe (~27s total); -w/-r switch to a single configuration and -s/-d/-p
tune msgsize/duration/pipe size. Output is one-line-per-metric with a
"---" separator between configurations so two runs (e.g. baseline vs
patched) can be diffed directly.

Pass --memory-pressure to fork stress-ng (--vm 4 --vm-bytes 80%
--vm-method all) for the duration of the run, so alloc_page() in
anon_pipe_write() routinely hits direct reclaim. The flag fails
fast if stress-ng is not on $PATH.

The program exits 0 on a clean run and reports its results to stdout,
so it integrates with the kselftest framework via TEST_GEN_PROGS.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/Makefile          |   1 +
 tools/testing/selftests/pipe/.gitignore   |   1 +
 tools/testing/selftests/pipe/Makefile     |   9 +
 tools/testing/selftests/pipe/pipe_bench.c | 351 ++++++++++++++++++++++++++++++
 4 files changed, 362 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6e59b8f63e416..bcd9db9d292ca 100644
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
index 0000000000000..20b549361a152
--- /dev/null
+++ b/tools/testing/selftests/pipe/.gitignore
@@ -0,0 +1 @@
+pipe_bench
diff --git a/tools/testing/selftests/pipe/Makefile b/tools/testing/selftests/pipe/Makefile
new file mode 100644
index 0000000000000..1810c680117b3
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
index 0000000000000..4b4ee6c8c0ced
--- /dev/null
+++ b/tools/testing/selftests/pipe/pipe_bench.c
@@ -0,0 +1,351 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pipe_bench - exercise pipe->mutex contention under concurrent writers.
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
+};
+
+static inline uint64_t now_ns(void)
+{
+	struct timespec ts;
+
+	clock_gettime(CLOCK_MONOTONIC, &ts);
+	return (uint64_t)ts.tv_sec * 1000000000ull + ts.tv_nsec;
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
+	char *buf = aligned_alloc(4096, g_msgsize);
+
+	if (!buf)
+		return NULL;
+	memset(buf, 0xAA, g_msgsize);
+
+	while (!atomic_load_explicit(&g_stop, memory_order_relaxed)) {
+		uint64_t t0 = now_ns();
+		ssize_t n = write(g_pipe[1], buf, g_msgsize);
+		uint64_t dt = now_ns() - t0;
+
+		if (n > 0) {
+			s->writes++;
+			s->bytes += n;
+			s->lat_sum_ns += dt;
+			if (dt > s->lat_max_ns)
+				s->lat_max_ns = dt;
+			s->lat_hist[log2_bucket(dt)]++;
+		} else if (n < 0 && errno == EPIPE) {
+			break;
+		}
+	}
+	free(buf);
+	return NULL;
+}
+
+static void *reader(void *arg)
+{
+	char *buf = aligned_alloc(4096, g_msgsize);
+
+	(void)arg;
+	if (!buf)
+		return NULL;
+	/*
+	 * Drain until EOF (write end closed by main). g_stop is not checked
+	 * here on purpose: writers may be blocked in write() with the pipe
+	 * full when g_stop is set, so the reader must keep draining until
+	 * main closes the write end.
+	 */
+	for (;;) {
+		ssize_t n = read(g_pipe[0], buf, g_msgsize);
+
+		if (n <= 0)
+			break;
+	}
+	free(buf);
+	return NULL;
+}
+
+static void summarize(struct wstats *all, int nw, int nr)
+{
+	uint64_t total_writes = 0, total_bytes = 0, total_lat = 0;
+	uint64_t max_lat = 0;
+	uint64_t agg[HIST_BUCKETS] = {0};
+	uint64_t p50_target, p99_target, p999_target;
+	uint64_t cum = 0, p50 = 0, p99 = 0, p999 = 0;
+	uint64_t avg_ns;
+	double sec;
+
+	for (int i = 0; i < nw; i++) {
+		total_writes += all[i].writes;
+		total_bytes += all[i].bytes;
+		total_lat += all[i].lat_sum_ns;
+		if (all[i].lat_max_ns > max_lat)
+			max_lat = all[i].lat_max_ns;
+		for (int b = 0; b < HIST_BUCKETS; b++)
+			agg[b] += all[i].lat_hist[b];
+	}
+
+	p50_target = total_writes * 50 / 100;
+	p99_target = total_writes * 99 / 100;
+	p999_target = total_writes * 999 / 1000;
+
+	for (int b = 0; b < HIST_BUCKETS; b++) {
+		cum += agg[b];
+		if (!p50 && cum >= p50_target)
+			p50 = 1ULL << b;
+		if (!p99 && cum >= p99_target)
+			p99 = 1ULL << b;
+		if (!p999 && cum >= p999_target)
+			p999 = 1ULL << b;
+	}
+
+	sec = g_duration;
+	avg_ns = total_writes ? total_lat / total_writes : 0;
+
+	printf("config: writers=%d readers=%d msgsize=%zu duration=%d pipe_size=%d memory_pressure=%s\n",
+	       nw, nr, g_msgsize, g_duration, g_pipe_size,
+	       g_memory_pressure ? "yes" : "no");
+	printf("writes: total=%llu rate=%.0f/s\n",
+	       (unsigned long long)total_writes, total_writes / sec);
+	printf("throughput_MBps: %.2f\n",
+	       (total_bytes / sec) / (1024.0 * 1024.0));
+	printf("lat_avg_ns: %llu\n", (unsigned long long)avg_ns);
+	printf("lat_p50_ns_upper: %llu\n", (unsigned long long)p50);
+	printf("lat_p99_ns_upper: %llu\n", (unsigned long long)p99);
+	printf("lat_p999_ns_upper: %llu\n", (unsigned long long)p999);
+	printf("lat_max_ns: %llu\n", (unsigned long long)max_lat);
+}
+
+static pid_t spawn_stress_ng(void)
+{
+	pid_t pid = fork();
+
+	if (pid < 0) {
+		perror("fork");
+		return -1;
+	}
+	if (pid == 0) {
+		execlp("stress-ng", "stress-ng",
+		       "--vm", "4", "--vm-bytes", "80%",
+		       "--vm-method", "all",
+		       (char *)NULL);
+		fprintf(stderr, "exec stress-ng failed: %s\n",
+			strerror(errno));
+		_exit(127);
+	}
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
+static int run_one(int nw, int nr)
+{
+	pthread_t *wt, *rt;
+	struct wstats *ws;
+
+	atomic_store(&g_stop, 0);
+
+	if (pipe(g_pipe) < 0) {
+		perror("pipe");
+		return -1;
+	}
+	if (fcntl(g_pipe[1], F_SETPIPE_SZ, g_pipe_size) < 0)
+		perror("F_SETPIPE_SZ (continuing)");
+
+	wt = calloc(nw, sizeof(*wt));
+	rt = calloc(nr, sizeof(*rt));
+	ws = calloc(nw, sizeof(*ws));
+
+	if (!wt || !rt || !ws) {
+		fprintf(stderr, "alloc failed\n");
+		free(wt);
+		free(rt);
+		free(ws);
+		close(g_pipe[0]);
+		close(g_pipe[1]);
+		return -1;
+	}
+
+	for (int i = 0; i < nr; i++)
+		pthread_create(&rt[i], NULL, reader, NULL);
+	for (int i = 0; i < nw; i++)
+		pthread_create(&wt[i], NULL, writer, &ws[i]);
+
+	sleep(g_duration);
+	atomic_store(&g_stop, 1);
+
+	/*
+	 * Close write end first so any writer blocked in write() gets EPIPE
+	 * and exits, and so the readers see EOF after draining.
+	 */
+	close(g_pipe[1]);
+	for (int i = 0; i < nw; i++)
+		pthread_join(wt[i], NULL);
+	for (int i = 0; i < nr; i++)
+		pthread_join(rt[i], NULL);
+	close(g_pipe[0]);
+
+	summarize(ws, nw, nr);
+	fflush(stdout);
+
+	free(wt);
+	free(rt);
+	free(ws);
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	static const int writers_sweep[] = {1, 2, 5};
+	static const int readers_sweep[] = {1, 5, 10};
+	static const struct option long_opts[] = {
+		{"memory-pressure", no_argument, NULL, 'M'},
+		{0, 0, 0, 0},
+	};
+	int writers_override = 0, readers_override = 0;
+	pid_t stress_pid = -1;
+	int rc = 0, opt;
+
+	while ((opt = getopt_long(argc, argv, "w:r:s:d:p:",
+				  long_opts, NULL)) != -1) {
+		switch (opt) {
+		case 'w':
+			writers_override = atoi(optarg);
+			break;
+		case 'r':
+			readers_override = atoi(optarg);
+			break;
+		case 's':
+			g_msgsize = atol(optarg);
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
+			fprintf(stderr,
+				"usage: %s [-w writers] [-r readers] [-s msgsize] [-d secs] [-p pipe_size] [--memory-pressure]\n"
+				"  default: sweep writers={1,2,5} x readers={1,5,10}\n"
+				"  --memory-pressure: spawn stress-ng (--vm 4 --vm-bytes 80%% --vm-method all) for the run\n",
+				argv[0]);
+			return 1;
+		}
+	}
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
+		goto out;
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(writers_sweep); i++) {
+		for (size_t j = 0; j < ARRAY_SIZE(readers_sweep); j++) {
+			printf("---\n");
+			if (run_one(writers_sweep[i], readers_sweep[j]) < 0) {
+				rc = 1;
+				goto out;
+			}
+		}
+	}
+out:
+	kill_stress_ng(stress_pid);
+	return rc;
+}

-- 
2.53.0-Meta

