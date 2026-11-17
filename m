Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932245;
	b=KXU/k7YsXHmEEa+O8usLwnryC5ZKg0uh6Tg5ZVLUjE+XptrbIOdAU59wAgVxnLaTLhI9
	 Pi1i5RQEU7LrB5vG6NmhE+ODaA9kc8pCBVPe6FkFgH9ibpPlBXsLqGhlLbzsOj3pDfxwT
	 484eRQ94woBJV6/h59JC0sG7/iXtjXUur+2OrL2m4h6eTpndZEPgzPT5EUIWkTUY3I+ob
	 t71KdYOf3h4F5WuIMsNMBfpM36P2qE+3pH2ZVf1vApQghC5JnelRNlRYMMxFwNn3Q7s6s
	 mZ8hUBdvtatUhVmFibM1EfX4ggaReVQoUXH1uvsR5JGqDAxMYnnspkA/H64gc5bK50g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932245;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CREz4BtGzSVwVl79tOXEQVEzt5xSqBMaf51OCNp4CUM=;
	b=iVqbIp32D9je0IKEUZLVyu1TQCfq3lKxQAvLIrIy1EDgoScTU7Udjdhu08tUfnZ4AzN/
	 PUYouIWGsZMH8VWNPPZdIjbAtGyBLBXIr9RGDSB1ze85RPidKd3dek6RryzkMx+Za/i6u
	 WtXJDzd07HGbH/BLYWv3Aq97YfJITDG/CbXmTdS/MvTMU6jhFVxemWbqbaj2uVArJradX
	 rBDibH1d8NB5mvGz1svEr+ww1dMmIiIoeBsut1wbUSTsmPwOlwqopqlW57j4nD8+9CPtO
	 sMruC8Wm3TUxnO8bgyoBc7VDyIq1WxKQwrwZFzobcCz2QKh9q+aeQl7Z0OAUNl0hH6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=NqsimjG6;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3216960A2628;
	Tue, 17 Nov 2026 16:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3216960A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=NqsimjG6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794932243;
	bh=CREz4BtGzSVwVl79tOXEQVEzt5xSqBMaf51OCNp4CUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NqsimjG61T+sm2k+Y1EiM9ElrNotuEK/OHtpkgl6wJ9AhbVWGIaWDAqJ19Kpio0Kk
	 bZJfWcKrlWIZi4j+55TKBzifg9AH6Em1dkx2vEJ/uvVqdq4PgfOmr0espdZC0cxB29
	 jQjZ7IKUmn3GE8qexAty4x148dgdi1daPk6O6Qoi9lpA/Wh2sQiYzq0NdGKgRM5N8M
	 ITKjNdJJBqovEsBV0voY5RY99fj+YndVtORVvbc0zUGTATrKaoXLZuwu2P2SJN9rZC
	 oaEnuVKXtesTsNxuhsOTpbpdrIE20a/lQU3x4lIBrqlzsS3hWVRWfmBRSX4vg63y+b
	 OkMlmAel3a+Tg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTVHl3zkzzRZY;
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
Subject: [PATCH 13/17] selftests/rseq: Test concurrent thread creation and forced migration
Date: Tue, 17 Nov 2026 11:17:13 -0500
Message-Id: <d4aabd0faed808d6acd1a2a59e88ec98546a17f8.1794932121.git.mathieu.desnoyers@efficios.com>
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

Two fixes that followed the rework of the concurrency IDs point at cases
no test covers:

  - commit b2e48c429ec5 ("sched/mmcid: Prevent CID stalls due to
    concurrent forks") fixed two tasks that join an mm at the same
    time;
  - commit 4327fb13fa47 ("sched/mmcid: Prevent live lock on task to CPU
    mode transition") fixed a task that migrates while the mm switches
    to per CPU mode.

In mm_cid_transition_test only the main thread creates threads, and no
thread is moved to another CPU while the thread count changes.

Add two cases. Both repeat the rounds of 1 to 16 threads on at most
four CPUs:

  - In the first one, most threads create a thread of their own when
    they start. Several threads then join the mm at the same time.
  - In the second one, another process pins every thread to one CPU
    after another in a loop. The threads migrate while the mode
    switches in both directions.

Both cases pass on guests with 2 to 64 CPUs, with and without the
previous fixes.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../selftests/rseq/mm_cid_transition_test.c   | 173 ++++++++++++------
 1 file changed, 121 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/rseq/mm_cid_transition_test.c b/tools/testing/selftests/rseq/mm_cid_transition_test.c
index fa26be14950c..ccedec71fd6d 100644
--- a/tools/testing/selftests/rseq/mm_cid_transition_test.c
+++ b/tools/testing/selftests/rseq/mm_cid_transition_test.c
@@ -24,6 +24,11 @@
  * and widens every thread in a loop, while the threads count, call
  * vfork(2) and then exit with their process.
  *
+ * Two more cases repeat the rounds. In one, most threads create a thread
+ * of their own, so that several threads join the mm at the same time. In
+ * the other, another process moves every thread from CPU to CPU, so that
+ * threads migrate while the mode switches.
+ *
  * The test fails when counts are lost, or when an mm_cid is not below the
  * number of possible CPUs. A kernel that loops looking for a free ID
  * shows as a timeout.
@@ -55,6 +60,7 @@
 #define WIDEN_RUNS	100
 #define ROUND_US	500
 #define MAX_TRIES	1000000
+#define MAX_SETS	4
 
 #define CHILD_PASS	0
 #define CHILD_FAIL	1
@@ -66,10 +72,16 @@ struct worker {
 	unsigned int	bad_cid;
 	bool		execs;
 	bool		vforks;
+	struct worker	*buddy;
 };
 
+/* run_child_rounds() flags */
+#define NESTED		1
+#define MIGRATED	2
+
 static intptr_t counts[MAX_CIDS];
-static struct worker workers[MAX_WORKERS];
+static struct worker workers[2 * MAX_WORKERS];
+static bool nested;
 static int stop;
 static int nr_possible;
 static cpu_set_t all_cpus;
@@ -115,14 +127,34 @@ static int remove_file(const char *path)
 	return 0;
 }
 
+static void *worker_fn(void *arg);
+
+/* Start the thread of @w. Return 0 or an error number. */
+static int create_worker(struct worker *w)
+{
+	int err, tries = 0;
+
+	/* clone(CLONE_FS) fails with EAGAIN while a thread is in execve. */
+	do {
+		err = pthread_create(&w->thread, NULL, worker_fn, w);
+		if (err == EAGAIN)
+			sched_yield();
+	} while (err == EAGAIN && ++tries < MAX_TRIES);
+	return err;
+}
+
 static void *worker_fn(void *arg)
 {
 	struct worker *w = arg;
 	char *const av[] = { exec_path, NULL };
+	bool has_buddy = false;
 	int i;
 
 	if (rseq_register_current_thread())
 		abort();
+	/* Other workers do the same now: several threads join at once. */
+	if (w->buddy)
+		has_buddy = !create_worker(w->buddy);
 	while (!RSEQ_READ_ONCE(stop) && w->bad_cid == UINT_MAX) {
 		for (i = 0; i < 100; i++)
 			count_one(w);
@@ -141,6 +173,8 @@ static void *worker_fn(void *arg)
 			}
 		}
 	}
+	if (has_buddy)
+		join_thread(w->buddy->thread);
 	rseq_unregister_current_thread();
 	return NULL;
 }
@@ -152,17 +186,11 @@ static int run_round(int nr, int widen_us)
 
 	RSEQ_WRITE_ONCE(stop, 0);
 	for (i = 0; i < nr; i++) {
-		int err, tries = 0;
-
 		workers[i].execs = i == 0 && exec_path[0];
 		workers[i].vforks = i == 1;
-		/* clone(CLONE_FS) fails with EAGAIN while a thread is in execve. */
-		do {
-			err = pthread_create(&workers[i].thread, NULL, worker_fn, &workers[i]);
-			if (err == EAGAIN)
-				sched_yield();
-		} while (err == EAGAIN && ++tries < MAX_TRIES);
-		if (err)
+		/* The two workers above keep to their own loop. */
+		workers[i].buddy = nested && i > 1 ? &workers[MAX_WORKERS + i] : NULL;
+		if (create_worker(&workers[i]))
 			break;
 		started++;
 	}
@@ -187,7 +215,7 @@ static int check_counts(const char *what)
 	intptr_t counted = 0, total = 0;
 	int i, ret = CHILD_PASS;
 
-	for (i = 0; i < MAX_WORKERS; i++) {
+	for (i = 0; i < 2 * MAX_WORKERS; i++) {
 		counted += workers[i].counted;
 		if (workers[i].bad_cid != UINT_MAX) {
 			fprintf(stderr, "%s: mm_cid %u (0x%x), %d possible CPUs\n",
@@ -209,7 +237,7 @@ static void init_workers(void)
 {
 	int i;
 
-	for (i = 0; i < MAX_WORKERS; i++)
+	for (i = 0; i < 2 * MAX_WORKERS; i++)
 		workers[i].bad_cid = UINT_MAX;
 }
 
@@ -242,12 +270,76 @@ static int make_unknown_format_file(const char *dir)
 	return -1;
 }
 
-/* Rounds of 1 to MAX_WORKERS threads: the count crosses both thresholds. */
-static int run_child_rounds(int unused)
+/*
+ * Change the affinity of every thread of @pid in a loop, from another
+ * process. Each change takes the next of the @nr_sets CPU sets in @sets.
+ * Start after @delay_us and run until @pid exits.
+ */
+static void remote_setter(pid_t pid, int delay_us, const cpu_set_t *sets, int nr_sets)
 {
-	int round, ret;
+	unsigned int next = 0;
+	char path[64];
+
+	/* Die with the process under test, not before its exit. */
+	if (prctl(PR_SET_PDEATHSIG, SIGKILL)) {
+		fprintf(stderr, "prctl(PR_SET_PDEATHSIG): %s\n", strerror(errno));
+		_exit(1);
+	}
+	snprintf(path, sizeof(path), "/proc/%d/task", pid);
+	usleep(delay_us);
+	while (getppid() == pid) {
+		DIR *dir = opendir(path);
+		struct dirent *de;
+
+		if (!dir)
+			break;
+		while ((de = readdir(dir))) {
+			pid_t tid = atoi(de->d_name);
+
+			/* A thread can exit first: ESRCH is expected. */
+			if (tid > 0 &&
+			    sched_setaffinity(tid, sizeof(sets[0]),
+					      &sets[next++ % nr_sets]) &&
+			    errno != ESRCH) {
+				fprintf(stderr, "sched_setaffinity: %s\n", strerror(errno));
+				_exit(1);
+			}
+		}
+		closedir(dir);
+	}
+	_exit(0);
+}
+
+/*
+ * Rounds of 1 to MAX_WORKERS threads: the count crosses both thresholds.
+ * With NESTED in @flags, most threads create one more thread. With
+ * MIGRATED, another process moves the threads between the allowed CPUs.
+ */
+static int run_child_rounds(int flags)
+{
+	static cpu_set_t sets[MAX_SETS];
+	int round, ret, cpu, nr_sets = 0;
+	pid_t self = getpid(), setter;
+	cpu_set_t allowed;
 
 	init_workers();
+	nested = flags & NESTED;
+	if (flags & MIGRATED) {
+		if (sched_getaffinity(0, sizeof(allowed), &allowed))
+			return CHILD_ERROR;
+		/* One set per allowed CPU: the allowed CPUs of the mm stay. */
+		for (cpu = 0; cpu < CPU_SETSIZE && nr_sets < MAX_SETS; cpu++) {
+			if (!CPU_ISSET(cpu, &allowed))
+				continue;
+			CPU_ZERO(&sets[nr_sets]);
+			CPU_SET(cpu, &sets[nr_sets++]);
+		}
+		setter = fork();
+		if (setter < 0)
+			return CHILD_ERROR;
+		if (!setter)
+			remote_setter(self, 0, sets, nr_sets);
+	}
 	/* Without the file the rounds run with no execve. */
 	if (make_unknown_format_file("/tmp") && make_unknown_format_file("."))
 		fprintf(stderr, "no unknown format file: the rounds run without execve\n");
@@ -273,53 +365,23 @@ static int run_child_widen(int delay_us)
 	return check_counts("affinity change");
 }
 
-/*
- * Narrow and widen the affinity of every thread of @pid in a loop, from
- * another process. Start after @delay_us and run until @pid exits.
- */
-static void remote_setter(pid_t pid, int delay_us, const cpu_set_t *narrow)
-{
-	bool widen = true;
-	char path[64];
-
-	/* Die with the process under test, not before its exit. */
-	prctl(PR_SET_PDEATHSIG, SIGKILL);
-	snprintf(path, sizeof(path), "/proc/%d/task", pid);
-	usleep(delay_us);
-	while (getppid() == pid) {
-		DIR *dir = opendir(path);
-		struct dirent *de;
-
-		if (!dir)
-			break;
-		while ((de = readdir(dir))) {
-			pid_t tid = atoi(de->d_name);
-
-			/* A thread can exit first: ESRCH is expected. */
-			if (tid > 0)
-				sched_setaffinity(tid, sizeof(all_cpus),
-						  widen ? &all_cpus : narrow);
-		}
-		closedir(dir);
-		widen = !widen;
-	}
-	_exit(0);
-}
-
 /* Run one round while another process changes the affinity of the threads. */
 static int run_child_remote(int delay_us)
 {
 	pid_t self = getpid(), setter;
-	cpu_set_t narrow;
+	cpu_set_t sets[3];
 
-	if (sched_getaffinity(0, sizeof(narrow), &narrow))
+	/* Two wide changes for a narrow one, so that each thread gets both. */
+	if (sched_getaffinity(0, sizeof(sets[0]), &sets[0]))
 		return CHILD_ERROR;
+	sets[1] = all_cpus;
+	sets[2] = all_cpus;
 	init_workers();
 	setter = fork();
 	if (setter < 0)
 		return CHILD_ERROR;
 	if (!setter)
-		remote_setter(self, delay_us, &narrow);
+		remote_setter(self, delay_us, sets, 3);
 	if (run_round(3, -1))
 		return CHILD_ERROR;
 	/* The setter keeps running while this process exits. */
@@ -403,7 +465,7 @@ int main(void)
 	int status, i;
 
 	ksft_print_header();
-	ksft_set_plan(4);
+	ksft_set_plan(6);
 
 	if (!rseq_available())
 		ksft_exit_skip("rseq is unavailable\n");
@@ -438,5 +500,12 @@ int main(void)
 			break;
 	}
 	ksft_test_result(status == CHILD_PASS, "affinity changed by another process\n");
+
+	narrow_cpus(&narrow, &all_cpus, MAX_SETS);
+	status = run_under_test(run_child_rounds, NESTED, &narrow);
+	ksft_test_result(status == CHILD_PASS, "threads created by several threads at once\n");
+
+	status = run_under_test(run_child_rounds, MIGRATED, &narrow);
+	ksft_test_result(status == CHILD_PASS, "threads migrated by another process\n");
 	ksft_finished();
 }
-- 
2.47.3

