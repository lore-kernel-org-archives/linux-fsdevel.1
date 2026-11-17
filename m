Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932244;
	b=Ge+owszyrpoiYd6UstwWcYEicZgQAKOPFlQDmcL5vlarYsSfmnRBHpYRvqQ2bWMVby9y
	 FhHmmZB/GyUepCPsTY9wKsPf+pSreOD1Y3Q34PPra5mSfnyAiQp98jqkULzUUDll3JQV9
	 CDAEItJkv3IaCWZ49A8VsEBYxv4WLujoLGzw4j1B4sNZTJfCTpcrmL4ETDzo6MQ978Zwo
	 uQ4/q4uPNKhuYj0LsJoWL80BxdzYjw0L9o2QdtmnpwcBDVM/LzM06IHiFHjSlQf1tplZE
	 QbTLbsRFv3UZd8hMd68Tn9GCvfiNKwqp4fafhcemldFmO4fcHHYinLQ6zoeiOMSFwEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932244;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RJ76wTh0nV/KNDIqsdDhRhZTY6RdEm7WDdLDbxCKA1Q=;
	b=R9ktMqpLWdh7LIkR68S9mutqG42mMr2blxS5c318+a5mgb1UkMKAkznwKJkPR9EcEIfK
	 ZmlpXnmZptUMYsm+H0dKFpw/1K4YVNNyShDdz1I9yJJEt6rUy1bj5XC27V1rrJ5aA1nGO
	 hT2GnqjbPupNLOSGIYA89Ya7SRsn3MOxKBJcMjymv6z9fWw4AfKey8zwH0vpTw4XdpswD
	 Kmesz5P1GBPVFZD/9UPLleyvpbSfkTdvLUm6vKKeurSzVlPdjatWSCR0O4pNNNPcTjvmu
	 3apbHKLW9mXL3Zn+pp2sTg+qrezJ2oaTLgp2lffg8EynkHE6EEJ826xtO6oz9DCVc4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=EuwAcriO;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563F160A2602;
	Tue, 17 Nov 2026 16:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 563F160A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=EuwAcriO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794932243;
	bh=RJ76wTh0nV/KNDIqsdDhRhZTY6RdEm7WDdLDbxCKA1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EuwAcriO1rqDQcG9xsHqdsGXc2nmiOZyqsiHdXZI4N7kJLZXp8czY0rz+lElXiQAO
	 rSoNgxC3m2Mr3iXRSsNVVrIzo28cxH40DP4Xqctd1KknC7dAaie7HdIRqGLgYI/F2Z
	 OaGkG7s0LbesOi7BKWFbBC9bgQX6EDBgYHeHMpE9wUJuqko6BxpD3yEudh8Gdw7llB
	 fAYAKxK51P6vdFi2f3YuI0y3SkefSYZWREwBpWTMDFok5AlkXCo0EtzFsvLiu/Q92W
	 4zn7EbZNMene/Nj6tbupmx6xpzLTWMWHlyRMEBAhK+sbt1B+wyVnL/c2PPaY4Gu0W4
	 KBVvy5A+DpHog==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTVHl1nqhzRZX;
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
Subject: [PATCH 11/17] selftests/rseq: Test affinity changes made by another process
Date: Tue, 17 Nov 2026 11:17:11 -0500
Message-Id: <926187ef9c1ed8c1b197cb7fa854339c01ee5e6b.1794932121.git.mathieu.desnoyers@efficios.com>
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

The mm_cid tests change the affinity of a thread from inside its own
process. Another process can change it too, with sched_setaffinity() on
a thread ID. The kernel then updates the allowed CPUs of an mm that is
not the mm of the caller. The threads of that mm can exit or call
vfork() at the same time, and the whole process can exit. No test
covers this.

Add a case to mm_cid_transition_test. A process starts on two CPUs with
three counting threads. Another process narrows and widens the affinity
of each of these threads in a loop. It goes on while the process under
test exits. The case runs 100 times, and the changes start after a
different delay each time.

The case passes on guests with 2 to 64 CPUs. It adds coverage: it
found no bug.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 .../selftests/rseq/mm_cid_transition_test.c   | 69 ++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/mm_cid_transition_test.c b/tools/testing/selftests/rseq/mm_cid_transition_test.c
index 7c80c222bd96..fa26be14950c 100644
--- a/tools/testing/selftests/rseq/mm_cid_transition_test.c
+++ b/tools/testing/selftests/rseq/mm_cid_transition_test.c
@@ -20,21 +20,28 @@
  * A second case starts on two CPUs and widens the affinity of a thread
  * while the others count.
  *
+ * A third case leaves the affinity changes to another process. It narrows
+ * and widens every thread in a loop, while the threads count, call
+ * vfork(2) and then exit with their process.
+ *
  * The test fails when counts are lost, or when an mm_cid is not below the
  * number of possible CPUs. A kernel that loops looking for a free ID
  * shows as a timeout.
  */
 
 #define _GNU_SOURCE
+#include <dirent.h>
 #include <errno.h>
 #include <limits.h>
 #include <pthread.h>
 #include <sched.h>
+#include <signal.h>
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/prctl.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
 #include <unistd.h>
@@ -266,6 +273,59 @@ static int run_child_widen(int delay_us)
 	return check_counts("affinity change");
 }
 
+/*
+ * Narrow and widen the affinity of every thread of @pid in a loop, from
+ * another process. Start after @delay_us and run until @pid exits.
+ */
+static void remote_setter(pid_t pid, int delay_us, const cpu_set_t *narrow)
+{
+	bool widen = true;
+	char path[64];
+
+	/* Die with the process under test, not before its exit. */
+	prctl(PR_SET_PDEATHSIG, SIGKILL);
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
+			if (tid > 0)
+				sched_setaffinity(tid, sizeof(all_cpus),
+						  widen ? &all_cpus : narrow);
+		}
+		closedir(dir);
+		widen = !widen;
+	}
+	_exit(0);
+}
+
+/* Run one round while another process changes the affinity of the threads. */
+static int run_child_remote(int delay_us)
+{
+	pid_t self = getpid(), setter;
+	cpu_set_t narrow;
+
+	if (sched_getaffinity(0, sizeof(narrow), &narrow))
+		return CHILD_ERROR;
+	init_workers();
+	setter = fork();
+	if (setter < 0)
+		return CHILD_ERROR;
+	if (!setter)
+		remote_setter(self, delay_us, &narrow);
+	if (run_round(3, -1))
+		return CHILD_ERROR;
+	/* The setter keeps running while this process exits. */
+	return check_counts("affinity change by another process");
+}
+
 static int read_nr_possible(void)
 {
 	int first, last, total = 0;
@@ -343,7 +403,7 @@ int main(void)
 	int status, i;
 
 	ksft_print_header();
-	ksft_set_plan(3);
+	ksft_set_plan(4);
 
 	if (!rseq_available())
 		ksft_exit_skip("rseq is unavailable\n");
@@ -371,5 +431,12 @@ int main(void)
 			break;
 	}
 	ksft_test_result(status == CHILD_PASS, "affinity change widens the allowed CPUs\n");
+
+	for (i = 0; i < WIDEN_RUNS; i++) {
+		status = run_under_test(run_child_remote, (i * 13) % ROUND_US, &narrow);
+		if (status != CHILD_PASS)
+			break;
+	}
+	ksft_test_result(status == CHILD_PASS, "affinity changed by another process\n");
 	ksft_finished();
 }
-- 
2.47.3

