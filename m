Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3567E4A13A6;
	Thu, 17 Sep 2026 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636690; cv=none; b=J6PwQ8uUFzsojXvzI11ZbPLn2tBn2h3y+Ewxd4oR29qmQeYom0Gi2lLzkzDbOb6oaOJbAVVHvbYmcijHIZvJ9/DxmASPqmgDNPuEVIWuGV9hfRSHUvd1+HY0e5dFNGXlav9DDsMCAC1zMIHMqYBTktd6MqtpB8PuNc3X9S59U5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636690; c=relaxed/simple;
	bh=sNwBchyr0+67z59O/cph18409VT+YCwXJeYiT5NbMnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AekOV0Vf6DMZbMuzkXkeLOtSbVilUuVo/RYnR7u/GuTZREGHpvBvpHoyPJ2qktv4CwqZj0fOx5obKdstMmH8WvyPjv+NaaQcPZ+tv3B7BTsmP7FuOuhOnjf9dbbv1pFHZDvRhYrrcKDX0kBvcBXdkCsOIWU/zjq67tu9KpmZ6c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APv1pnKF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APv1pnKF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200E21F00893;
	Thu, 17 Sep 2026 09:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789636688;
	bh=FUrlkvpu/Nf0o2935ZPXruW9+9ifRNjvMUcRqNTb/II=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=APv1pnKFZYBdgK6fudPlsT5VdSrVFX8DrbxLWQxaDiIhUR32H8H5z1e7kZ/e/7Z5m
	 OAD1tmaogpKO9S+d96pdQo6VJr4qNTrP1LcYu60+PuOXj3au8f6C0vrMydhjCzvrcf
	 /vCi4uhQh55JKS7anbYcHCksLgt7vILzChmjqLdn2h8PIwQo6aRJcLkG6xDBSR7Fgw
	 txEOcloSxFV2d+k0qVEuPxvLzMC73VeAg9Pzg2wHTYYX0YulYn4oHjmZ3hAx6LEMe/
	 9nTVS4QmwbXX8fv5ZUKlRLpKhOHXd68V90fBZLFh+Wr4TKDgQGVNbRG3oh7pnu+vh7
	 PI8+bPF/jdkAQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 17 Sep 2026 11:17:34 +0200
Subject: [PATCH v2 7/7] selftests/coredump: test shared signal retargeting
 during a dump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-work-coredump-fixes-v2-7-f3787fcda051@kernel.org>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
In-Reply-To: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 NeilBrown <neil@brown.name>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
 io-uring@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=8719; i=brauner@kernel.org;
 h=from:subject:message-id; bh=sNwBchyr0+67z59O/cph18409VT+YCwXJeYiT5NbMnQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSt3mAyrVN7dtS0ObXnjvz6feDI9pNB3LNlV6j2NjIu/
 mATue+iTEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEZk1l+KcxRWS5id32ks8y
 C1c9Ul737+Zvppr5ndaqP+8W8E943/OF4Z+ZY8Pr1u5XzNtMTZ/HfWG77uzD0fbuhWBZ+koBFU2
 hizwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A shared signal that is still queued when a thread crashes gets
retargeted to the dumper when a zapped sibling restores its signal mask
on the way out of sigtimedwait(). That sets TIF_SIGPENDING on the dumper
and cuts the core short at the next full pipe or socket buffer. Cover
that:

- one sibling sleeps in sigtimedwait() for SIGUSR1

- a vfork() child queues SIGUSR1 for the main thread while it sleeps
  killably and then the SIGSEGV that is dequeued first

- the coredump server holds its read back so the dumper blocks on the
  full socket buffer

Check that the core covers every segment with and without the queued
signal.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/coredump/.gitignore        |   1 +
 tools/testing/selftests/coredump/Makefile          |   4 +-
 .../selftests/coredump/coredump_signal_test.c      | 238 +++++++++++++++++++++
 3 files changed, 242 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/coredump/.gitignore b/tools/testing/selftests/coredump/.gitignore
index 097f52db0be9..c198f2ca5872 100644
--- a/tools/testing/selftests/coredump/.gitignore
+++ b/tools/testing/selftests/coredump/.gitignore
@@ -2,3 +2,4 @@
 stackdump_test
 coredump_socket_test
 coredump_socket_protocol_test
+coredump_signal_test
diff --git a/tools/testing/selftests/coredump/Makefile b/tools/testing/selftests/coredump/Makefile
index dc8489d40618..bfb53f512d8e 100644
--- a/tools/testing/selftests/coredump/Makefile
+++ b/tools/testing/selftests/coredump/Makefile
@@ -4,7 +4,8 @@ CFLAGS += -Wall -O0 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 TEST_GEN_PROGS := stackdump_test \
 		  coredump_socket_test \
 		  coredump_socket_protocol_test \
-		  coredump_close_files_test
+		  coredump_close_files_test \
+		  coredump_signal_test
 TEST_FILES := stackdump
 
 include ../lib.mk
@@ -13,3 +14,4 @@ $(OUTPUT)/stackdump_test: coredump_test_helpers.c
 $(OUTPUT)/coredump_socket_test: coredump_test_helpers.c
 $(OUTPUT)/coredump_socket_protocol_test: coredump_test_helpers.c
 $(OUTPUT)/coredump_close_files_test: coredump_test_helpers.c
+$(OUTPUT)/coredump_signal_test: coredump_test_helpers.c
diff --git a/tools/testing/selftests/coredump/coredump_signal_test.c b/tools/testing/selftests/coredump/coredump_signal_test.c
new file mode 100644
index 000000000000..fdf48b144781
--- /dev/null
+++ b/tools/testing/selftests/coredump/coredump_signal_test.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <fcntl.h>
+#include <pthread.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/un.h>
+#include <unistd.h>
+
+#include "coredump_test.h"
+
+/* Big enough to fill the socket buffer many times over. */
+#define CRASH_MAPPING_SIZE (32 * 1024 * 1024)
+
+FIXTURE_SETUP(coredump)
+{
+	FILE *file;
+	int ret;
+
+	self->pid_coredump_server = -ESRCH;
+	self->fd_tmpfs_detached = -1;
+	file = fopen("/proc/sys/kernel/core_pattern", "r");
+	ASSERT_NE(NULL, file);
+
+	ret = fread(self->original_core_pattern, 1, sizeof(self->original_core_pattern), file);
+	ASSERT_TRUE(ret || feof(file));
+	ASSERT_LT(ret, sizeof(self->original_core_pattern));
+
+	self->original_core_pattern[ret] = '\0';
+
+	ret = fclose(file);
+	ASSERT_EQ(0, ret);
+}
+
+FIXTURE_TEARDOWN(coredump)
+{
+	const char *reason;
+	FILE *file;
+	int ret, status;
+
+	if (self->pid_coredump_server > 0) {
+		kill(self->pid_coredump_server, SIGTERM);
+		waitpid(self->pid_coredump_server, &status, 0);
+	}
+	unlink("/tmp/coredump.file");
+	unlink("/tmp/coredump.socket");
+
+	file = fopen("/proc/sys/kernel/core_pattern", "w");
+	if (!file) {
+		reason = "Unable to open core_pattern";
+		goto fail;
+	}
+
+	ret = fprintf(file, "%s", self->original_core_pattern);
+	if (ret < 0) {
+		reason = "Unable to write to core_pattern";
+		goto fail;
+	}
+
+	ret = fclose(file);
+	if (ret) {
+		reason = "Unable to close core_pattern";
+		goto fail;
+	}
+
+	return;
+fail:
+	/* This should never happen */
+	fprintf(stderr, "Failed to cleanup coredump test: %s\n", reason);
+}
+
+static volatile int waiter_ready;
+
+static void usr1_handler(int sig)
+{
+}
+
+/* Sleeps in sigtimedwait() with SIGUSR1 unblocked only inside the kernel. */
+static void *sigwaiter(void *arg)
+{
+	sigset_t set;
+	siginfo_t info;
+
+	sigemptyset(&set);
+	sigaddset(&set, SIGUSR1);
+	__atomic_store_n(&waiter_ready, 1, __ATOMIC_RELEASE);
+	for (;;)
+		sigtimedwait(&set, &info, NULL);
+	return NULL;
+}
+
+/*
+ * Crash with a shared SIGUSR1 still queued for this thread. The vfork()
+ * child queues it while we sleep killably and then the SIGSEGV that is
+ * dequeued first. The zap wakes the sibling out of sigtimedwait() and its
+ * mask restore retargets SIGUSR1 to the dumper.
+ */
+static void crashing_child_retarget(bool queue_shared)
+{
+	sigset_t all, old;
+	pthread_t thread;
+	pid_t pid, tid;
+	char *p;
+
+	p = mmap(NULL, CRASH_MAPPING_SIZE, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (p == MAP_FAILED)
+		_exit(EXIT_FAILURE);
+	memset(p, 0x5a, CRASH_MAPPING_SIZE);
+
+	signal(SIGUSR1, usr1_handler);
+	sigfillset(&all);
+	pthread_sigmask(SIG_BLOCK, &all, &old);
+	/* One waiter only, retarget stops at the first thread not blocking it. */
+	if (pthread_create(&thread, NULL, sigwaiter, NULL))
+		_exit(EXIT_FAILURE);
+	pthread_sigmask(SIG_SETMASK, &old, NULL);
+	while (!__atomic_load_n(&waiter_ready, __ATOMIC_ACQUIRE))
+		usleep(1000);
+	usleep(50 * 1000);
+
+	pid = getpid();
+	tid = syscall(SYS_gettid);
+	if (vfork() == 0) {
+		if (queue_shared)
+			syscall(SYS_kill, pid, SIGUSR1);
+		syscall(SYS_tgkill, pid, tid, SIGSEGV);
+		syscall(SYS_exit, 0);
+	}
+
+	/* Not reached, the pending SIGSEGV dumps core. */
+	for (;;)
+		pause();
+}
+
+/*
+ * Dump the crashing child into /tmp/coredump.file through a server that
+ * holds the read back so the dumper blocks on the full socket buffer.
+ */
+static void run_coredump(struct __test_metadata *const _metadata,
+			 FIXTURE_DATA(coredump) *self, bool queue_shared)
+{
+	pid_t pid, pid_coredump_server;
+	int ipc_sockets[2];
+	int status;
+	char c;
+
+	unlink("/tmp/coredump.file");
+	unlink("/tmp/coredump.socket");
+	ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets), 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		int fd_server = -1, fd_coredump = -1, fd_core_file = -1;
+		int exit_code = EXIT_FAILURE;
+
+		close(ipc_sockets[0]);
+
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+		if (fd_server < 0)
+			goto out;
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
+			goto out;
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0) {
+			fprintf(stderr, "%s: accept4 failed: %m\n", __func__);
+			goto out;
+		}
+
+		/* Let the dumper run into the full socket buffer first. */
+		sleep(1);
+
+		fd_core_file = creat("/tmp/coredump.file", 0644);
+		if (fd_core_file < 0) {
+			fprintf(stderr, "%s: creat failed: %m\n", __func__);
+			goto out;
+		}
+
+		if (recv_coredump_bytes(fd_coredump, fd_core_file) < 0)
+			goto out;
+
+		exit_code = EXIT_SUCCESS;
+out:
+		if (fd_core_file >= 0)
+			close(fd_core_file);
+		if (fd_coredump >= 0)
+			close(fd_coredump);
+		if (fd_server >= 0)
+			close(fd_server);
+		_exit(exit_code);
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0)
+		crashing_child_retarget(queue_shared);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_EQ(WTERMSIG(status), SIGSEGV);
+	ASSERT_TRUE(WCOREDUMP(status));
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+}
+
+static void check_coredump_complete(struct __test_metadata *const _metadata)
+{
+	int fd;
+
+	fd = open("/tmp/coredump.file", O_RDONLY | O_CLOEXEC);
+	ASSERT_GE(fd, 0);
+	ASSERT_TRUE(check_coredump_extent(fd));
+	close(fd);
+}
+
+TEST_F(coredump, retarget_shared_pending)
+{
+	run_coredump(_metadata, self, false);
+	check_coredump_complete(_metadata);
+
+	run_coredump(_metadata, self, true);
+	check_coredump_complete(_metadata);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

