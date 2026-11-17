Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932246;
	b=Ozwq8iRXTQIPBuoPj19QpIm/9niczxygthiEZQxbDtl2brN+DlSABQXPXBIN8kyMq4Lg
	 rUErmWNBwpOCGNY+fVk5zOq8Khdkqzd3oo2j4HWvsZE5hl26UG6p/E6KY11f8bsd1uclH
	 6eL7EOX2qNDI3KlqL/hrKXEf0xGNyLkaYouiC/m6TwYqZO+lAqYA8V0rUUyHDmrLC82fA
	 8OPOX6zu9eh6LWa9syXJCFE9T8WxgrLElhuge7YVyilFUgxEZqqaEuWtoiTayEri/QCOZ
	 oNSn80+epvI1h4tnlVlSuACZ2nQ5auMcHdAiHr52jjnN1VOT52qBe/9rvN6avec7AcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932246;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KBBX73vanCN3RJV6WAoz27bue4rtrM6PSqgvAc6MDVc=;
	b=sGKqtS82mD9wc7VbiLBuIaqqlNZ/Z5l/lECF25fqPq3rqD2gs3w4E/J75pvmw+7nphpL
	 x2jjdPVGD3XhKNIcHDd6mjH4HVFTODqzWqrwlnFYYdnYNxY24HyrsPNHbz546aAgVj89a
	 2gncEesouETXyhTtRH/Qy6tWPWCn91zQ2V0gmrTcN2tYHbQy31dXaIZ4mgfwI8uprXjj9
	 3abi434UmhgqAVgmC8yDIqHhCP3UbwdB9RwyIHsqHF39AUPjLkFrYBN6OQth+uCmzuBqM
	 K8KItRQDKtCqyOy/TBU6ZbmKSRI+SDz+mtLoJjZz52MVm3ir4GiktKrGRSK7vQwEKeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=NG2k+6pH;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4094606A886;
	Tue, 17 Nov 2026 16:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4094606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=NG2k+6pH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794932243;
	bh=KBBX73vanCN3RJV6WAoz27bue4rtrM6PSqgvAc6MDVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NG2k+6pHGLmiJ1pROyhiRO9WtCXmNEspfqVYKoAs261FAXvbWSi4VCeVJuEmdUBAy
	 TG4PUt02A/nI8SQ8wJ0CVc7vNApcGNlUuvKAJAhBpjJCd754C6IbyWzpoD7/swECRa
	 nxhQi+wEiL8VC7dwuds1SLH/JdM30G2B+ShtwJL/4g+HVtME2yoUFd0bkuWfm7dqD3
	 7OfkMuRPZoMdTmucTQwCtTvsd6xheq1sLRrrPbFGdNDPgvwO81pyDrvm9gtVXiWN53
	 HU12V14+HItceAh8TZv0/1k1bZCZs2s1N6Adp/iNzC92pODB96DOKCLcsR2NCKS7Cq
	 FEzsGNbePradg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTVHl593zzRZZ;
	Tue, 17 Nov 2026 11:17:23 -0500 (EST)
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
Subject: [PATCH 14/17] selftests/rseq: Test the concurrency IDs after the affinity is widened
Date: Tue, 17 Nov 2026 11:17:14 -0500
Message-Id: <05781fc46cb63b548588e58b356ab08b10619aac.1794932121.git.mathieu.desnoyers@efficios.com>
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

When the allowed CPUs of an mm grow, the kernel can give the
concurrency IDs back to the tasks. Commit 7dbc307b6c72 ("sched/mmcid:
Fix affinity-triggered switch back to per-task mode") fixed a threshold
that kept the CPUs as owners. No test shows it: the tests that widen
the affinity only check that the IDs are unique and in range.

Add a case to mm_cid_bound_test. Three threads start on two CPUs, so
the CPUs own the IDs. The threads are then allowed on all CPUs and
visit each of them. The kernel aims at an mm_cid below 3 for them. That
is a target, not a bound. The case prints when the target is missed. It
fails only when an mm_cid is not below the possible CPUs. The case needs
8 CPUs: with fewer, the kernel keeps the CPUs as owners.

The target is met on guests with 8, 16 and 64 CPUs:

  3 threads widened to 64 CPUs: largest mm_cid 2 on CPU 63

A v7.1.8 kernel with 384 CPUs, which does not have the commit above,
misses it:

  3 threads widened to 384 CPUs: largest mm_cid 383 on CPU 383, above the thread count target

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../selftests/rseq/mm_cid_bound_test.c        | 88 ++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/mm_cid_bound_test.c b/tools/testing/selftests/rseq/mm_cid_bound_test.c
index 11332b9ff24b..a751d8929138 100644
--- a/tools/testing/selftests/rseq/mm_cid_bound_test.c
+++ b/tools/testing/selftests/rseq/mm_cid_bound_test.c
@@ -28,6 +28,11 @@
  * The number of IDs follows the union of the allowed CPUs of the threads,
  * which only grows. The affinity is therefore narrowed before the fork(2)
  * that creates the process under test.
+ *
+ * A last case widens the affinity. Three threads start on two CPUs, so the
+ * CPUs own the IDs. The threads are then allowed on all CPUs. The kernel
+ * aims at giving the IDs back to the tasks, so that three threads read an
+ * mm_cid below 3. That is a target too: the case prints when it is missed.
  */
 
 #define _GNU_SOURCE
@@ -46,6 +51,9 @@
 
 #define MAX_THREADS	1024
 #define MAX_STEPS	64
+#define WIDEN_THREADS	3
+#define WIDEN_MIN_CPUS	8
+#define WIDEN_SETTLE_US	20000
 
 /*
  * Exit status of the process under test: a mask of the bound and of the
@@ -67,6 +75,7 @@ struct worker {
 static struct worker workers[MAX_THREADS];
 static unsigned int epoch;
 static cpu_set_t allowed;
+static cpu_set_t all_cpus;
 static int nr_allowed;
 static int nr_possible;
 
@@ -228,6 +237,49 @@ static int run_child(const int *steps, int nr_steps)
 	return ret;
 }
 
+/*
+ * The process under test of the widening case. It starts on two CPUs.
+ * Return a mask of the OVER_* values.
+ */
+static int run_child_widen(void)
+{
+	int nr_workers = 0, ret = 0, cpu, err;
+	unsigned int cid;
+
+	if (sched_getaffinity(0, sizeof(allowed), &allowed))
+		return CHILD_ERROR;
+	nr_allowed = CPU_COUNT(&allowed);
+
+	err = set_workers(&nr_workers, WIDEN_THREADS - 1);
+	if (err)
+		return CHILD_ERROR;
+	measure(nr_workers, &cpu);
+	cid = measure(nr_workers, &cpu);
+	ksft_print_msg("%4d threads on %d CPUs: largest mm_cid %u on CPU %d\n",
+		       WIDEN_THREADS, nr_allowed, cid, cpu);
+
+	/* Each thread widens its own affinity at the end of its next tour. */
+	allowed = all_cpus;
+	nr_allowed = CPU_COUNT(&allowed);
+	if (sched_setaffinity(0, sizeof(allowed), &allowed))
+		ret |= CHILD_ERROR;
+	measure(nr_workers, &cpu);
+	/* The kernel changes the owners of the IDs from a work item. */
+	usleep(WIDEN_SETTLE_US);
+	measure(nr_workers, &cpu);
+	cid = measure(nr_workers, &cpu);
+	if (cid >= (unsigned int)nr_possible)
+		ret |= OVER_POSSIBLE;
+	if (cid >= WIDEN_THREADS)
+		ret |= OVER_STRICT;
+	ksft_print_msg("%4d threads widened to %d CPUs: largest mm_cid %u on CPU %d%s\n",
+		       WIDEN_THREADS, nr_allowed, cid, cpu,
+		       ret & OVER_STRICT ? ", above the thread count target" : "");
+	if (set_workers(&nr_workers, 0))
+		ret |= CHILD_ERROR;
+	return ret;
+}
+
 /* Keep the first @nr CPUs of @src in @dst. */
 static int narrow_cpus(cpu_set_t *dst, const cpu_set_t *src, int nr)
 {
@@ -326,13 +378,46 @@ static void test_ramp(const cpu_set_t *all, int cpus, const char *name)
 			 "%s: below the possible CPUs\n", name);
 }
 
+static void test_widen(const cpu_set_t *all)
+{
+	const char *name = "widened from 2 CPUs: below the possible CPUs";
+	cpu_set_t narrow;
+	int status = 0;
+	pid_t child;
+
+	/* With fewer CPUs the kernel keeps the CPUs as owners of the IDs. */
+	if (CPU_COUNT(all) < WIDEN_MIN_CPUS || nr_possible < WIDEN_MIN_CPUS) {
+		ksft_test_result_skip("%s: fewer than %d CPUs\n", name, WIDEN_MIN_CPUS);
+		return;
+	}
+	narrow_cpus(&narrow, all, 2);
+	all_cpus = *all;
+	if (sched_setaffinity(0, sizeof(narrow), &narrow))
+		ksft_exit_fail_msg("sched_setaffinity: %s\n", strerror(errno));
+	child = fork();
+	if (!child)
+		_exit(run_child_widen());
+	if (child < 0)
+		ksft_exit_fail_msg("fork: %s\n", strerror(errno));
+	if (sched_setaffinity(0, sizeof(*all), all))
+		ksft_exit_fail_msg("sched_setaffinity: %s\n", strerror(errno));
+	if (waitpid(child, &status, 0) != child)
+		ksft_exit_fail_msg("waitpid: %s\n", strerror(errno));
+	if (!WIFEXITED(status) || (WEXITSTATUS(status) & CHILD_ERROR))
+		ksft_exit_fail_msg("the process under test failed to run\n");
+	/* The thread count is a target. Only the bound decides the result. */
+	if (WEXITSTATUS(status) & OVER_STRICT)
+		ksft_print_msg("widened from 2 CPUs: above the thread count target\n");
+	ksft_test_result(!(WEXITSTATUS(status) & OVER_POSSIBLE), "%s\n", name);
+}
+
 int main(void)
 {
 	cpu_set_t all;
 	int nr_all;
 
 	ksft_print_header();
-	ksft_set_plan(3);
+	ksft_set_plan(4);
 
 	if (!rseq_available())
 		ksft_exit_skip("rseq is unavailable\n");
@@ -351,5 +436,6 @@ int main(void)
 	test_ramp(&all, 2, "2 CPUs");
 	test_ramp(&all, 4, "4 CPUs");
 	test_ramp(&all, nr_all, "all CPUs");
+	test_widen(&all);
 	ksft_finished();
 }
-- 
2.47.3

