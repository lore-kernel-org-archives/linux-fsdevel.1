Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B75B3F39E8;
	Mon, 31 Aug 2026 11:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175325; cv=none; b=j57QbVtIWLUq3w/Cp4oY2RE9pa5PvcydOzegqEk3lRgaohwrq55Xy3gf8oC1h3Sivbfnd2WBjAnU+N01pF/O80w4X1HNjGzs0aBNCR/jBXqTVGUQfWJV+WyxeaUElfSwTnTt2jld5DLMr31RxD00dM/u22TuVl3D3aWPX65TUpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175325; c=relaxed/simple;
	bh=/gLzXoWjA3OG6zZFZUdLwDoN7/YEvqPGa1o+7C0HII8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EY98I95t2e8jn9b9Gn1Jq1cOUdETJHnVHaFhYvv7YQNZdDNMhShlBj3jiqpCDQc00xMZzL2hsQPXPjodJoGyw54mFXM4FAocCfeT2KYO0qt6O/Zvuh4h41mxoW9pMQE9tT2YzvR9r07cf73H10VldOMd1zraOH4jr12HIzEyNeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZki8Ndf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZki8Ndf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90AE1F000E9;
	Mon, 31 Aug 2026 11:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788175324;
	bh=NIEk83whaboRl5hJs+zRgzVrnKeaoqMIlrMhqA/02pY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HZki8NdfPEwn3SskCfaffJOqWLTLl3BHdK/xcQeMuacl/cHeB7yRDUcW9zoTizBiD
	 is2Yv9k7jTdD5DCUCmpYhNsZcnYmIYyVTNucF3/wsIBjCOp9HDXDhAr853cJIeResg
	 i8LtlLuQ04XdfCeyupJfkvlshg4M5airlkvpd3frZs36esXbzwsjWrm5q83FTJ2UEN
	 0hCHkmZ4p7w5lX2KcsTl3540SVNz2Ps7v+aoNzxr69cTSdNVrG1nU6vDyAtuvhI8/b
	 nqiKo4WSSkDNeQmMRSLoP/OhZX62AZ6dhHSauASzdTB0fG8dL2B0UxuIjl4DAw22iV
	 bbfkX88fKvDCA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 31 Aug 2026 13:21:22 +0200
Subject: [PATCH 10/10] selftests/coredump: check the dumping thread's pidfd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-work-unix-passpidfd-v1-10-70cbfda0c7ba@kernel.org>
References: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org>
In-Reply-To: <20260831-work-unix-passpidfd-v1-0-70cbfda0c7ba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=9270; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/gLzXoWjA3OG6zZFZUdLwDoN7/YEvqPGa1o+7C0HII8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRNTd4Y16lWdLTW9PW9NwkNkpMbWl9vV+BSXfYqOOZoT
 81pyUuTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby7Q4jQ++GGQxJM9P+unD/
 2jYtY2v7ggUh71ceUUyxvHnmTILp2m0M/2OCK98cqYzemNEhJpV14U2I41PLHbdEe0z64ioWTWZ
 LZgcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Crash from a non-leader thread and verify that the pidfd from
SO_PEERPIDFD_THREAD on the coredump socket refers to that thread and
reports the coredump like the thread-group leader's pidfd does.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/coredump/coredump_socket_test.c      | 175 +++++++++++++++++++++
 tools/testing/selftests/coredump/coredump_test.h   |   2 +
 .../selftests/coredump/coredump_test_helpers.c     |  49 ++++++
 3 files changed, 226 insertions(+)

diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
index 422728f632ca..ec73bb690bbc 100644
--- a/tools/testing/selftests/coredump/coredump_socket_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_test.c
@@ -592,6 +592,181 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
 	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 }
 
+static bool check_coredump_info(const struct pidfd_info *info, const char *what)
+{
+	if (!(info->mask & PIDFD_INFO_COREDUMP)) {
+		fprintf(stderr, "%s: PIDFD_INFO_COREDUMP not set in mask\n", what);
+		return false;
+	}
+
+	if (!(info->coredump_mask & PIDFD_COREDUMPED)) {
+		fprintf(stderr, "%s: PIDFD_COREDUMPED not set in coredump_mask\n", what);
+		return false;
+	}
+
+	if (!(info->mask & PIDFD_INFO_COREDUMP_SIGNAL) || info->coredump_signal != SIGSEGV) {
+		fprintf(stderr, "%s: coredump_signal=%d, expected SIGSEGV=%d\n",
+			what, info->coredump_signal, SIGSEGV);
+		return false;
+	}
+
+	if (!(info->mask & PIDFD_INFO_COREDUMP_CODE) || info->coredump_code != SEGV_MAPERR) {
+		fprintf(stderr, "%s: coredump_code=%d, expected SEGV_MAPERR=%d\n",
+			what, info->coredump_code, SEGV_MAPERR);
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * Test: PIDFD_INFO_COREDUMP on the dumping thread's pidfd
+ *
+ * Crash from a non-leader thread and verify that the pidfd from
+ * SO_PEERPIDFD_THREAD refers to that thread and reports the coredump
+ * like the thread-group leader's pidfd from SO_PEERPIDFD does.
+ */
+TEST_F(coredump, socket_coredump_thread)
+{
+	int pidfd, ret, status;
+	pid_t pid, pid_coredump_server;
+	struct pidfd_info info = {};
+	int ipc_sockets[2];
+	char c;
+
+	ASSERT_TRUE(set_core_pattern("@/tmp/coredump.socket"));
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets);
+	ASSERT_EQ(ret, 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1;
+		int fd_thread_pidfd = -1, fd_core_file = -1;
+		struct pidfd_info thread_info = {};
+		int exit_code = EXIT_FAILURE;
+
+		close(ipc_sockets[0]);
+
+		fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+		if (fd_server < 0) {
+			fprintf(stderr, "socket_coredump_thread: listen socket failed: %m\n");
+			goto out;
+		}
+
+		if (write_nointr(ipc_sockets[1], "1", 1) < 0) {
+			fprintf(stderr, "socket_coredump_thread: ipc write failed: %m\n");
+			goto out;
+		}
+
+		close(ipc_sockets[1]);
+
+		fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+		if (fd_coredump < 0) {
+			fprintf(stderr, "socket_coredump_thread: accept4 failed: %m\n");
+			goto out;
+		}
+
+		fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+		if (fd_peer_pidfd < 0) {
+			fprintf(stderr, "socket_coredump_thread: get_peer_pidfd failed\n");
+			goto out;
+		}
+
+		fd_thread_pidfd = get_peer_pidfd_thread(fd_coredump);
+		if (fd_thread_pidfd < 0) {
+			fprintf(stderr, "socket_coredump_thread: get_peer_pidfd_thread failed\n");
+			goto out;
+		}
+
+		if (!get_pidfd_info(fd_peer_pidfd, &info) ||
+		    !get_pidfd_info(fd_thread_pidfd, &thread_info)) {
+			fprintf(stderr, "socket_coredump_thread: get_pidfd_info failed\n");
+			goto out;
+		}
+
+		/* The peer is the thread-group leader, the dumping thread is not. */
+		if (info.pid != info.tgid || thread_info.tgid != info.tgid ||
+		    thread_info.pid == thread_info.tgid) {
+			fprintf(stderr, "socket_coredump_thread: unexpected ids %d/%d and %d/%d\n",
+				info.pid, info.tgid, thread_info.pid, thread_info.tgid);
+			goto out;
+		}
+
+		if (!check_coredump_info(&info, "SO_PEERPIDFD") ||
+		    !check_coredump_info(&thread_info, "SO_PEERPIDFD_THREAD"))
+			goto out;
+
+		fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
+		if (fd_core_file < 0) {
+			fprintf(stderr, "socket_coredump_thread: core tmpfile failed: %m\n");
+			goto out;
+		}
+
+		for (;;) {
+			char buffer[4096];
+			ssize_t bytes_read, bytes_write;
+
+			bytes_read = read(fd_coredump, buffer, sizeof(buffer));
+			if (bytes_read < 0) {
+				fprintf(stderr, "socket_coredump_thread: core read failed: %m\n");
+				goto out;
+			}
+
+			if (bytes_read == 0)
+				break;
+
+			bytes_write = write(fd_core_file, buffer, bytes_read);
+			if (bytes_read != bytes_write) {
+				fprintf(stderr, "socket_coredump_thread: core write %zd/%zd: %m\n",
+					bytes_read, bytes_write);
+				goto out;
+			}
+		}
+
+		exit_code = EXIT_SUCCESS;
+		fprintf(stderr, "socket_coredump_thread: completed successfully\n");
+out:
+		if (fd_core_file >= 0)
+			close(fd_core_file);
+		if (fd_thread_pidfd >= 0)
+			close(fd_thread_pidfd);
+		if (fd_peer_pidfd >= 0)
+			close(fd_peer_pidfd);
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
+		crashing_child_thread();
+
+	pidfd = sys_pidfd_open(pid, 0);
+	ASSERT_GE(pidfd, 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_EQ(WTERMSIG(status), SIGSEGV);
+	ASSERT_TRUE(WCOREDUMP(status));
+
+	ASSERT_TRUE(get_pidfd_info(pidfd, &info));
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
+	ASSERT_TRUE(!!(info.coredump_mask & PIDFD_COREDUMPED));
+	ASSERT_EQ(info.coredump_signal, SIGSEGV);
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+}
+
 /*
  * Test: PIDFD_INFO_COREDUMP_SIGNAL via simple socket coredump with SIGABRT
  *
diff --git a/tools/testing/selftests/coredump/coredump_test.h b/tools/testing/selftests/coredump/coredump_test.h
index ed47f01fa53c..4212656e31f0 100644
--- a/tools/testing/selftests/coredump/coredump_test.h
+++ b/tools/testing/selftests/coredump/coredump_test.h
@@ -27,10 +27,12 @@ FIXTURE(coredump)
 /* Shared helper function declarations */
 void *do_nothing(void *arg);
 void crashing_child(void);
+void crashing_child_thread(void);
 int create_detached_tmpfs(void);
 int create_and_listen_unix_socket(const char *path);
 bool set_core_pattern(const char *pattern);
 int get_peer_pidfd(int fd);
+int get_peer_pidfd_thread(int fd);
 bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info);
 
 /* Inline helper that uses harness types */
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 2a20faf9cb0a..36306069f62e 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -13,6 +13,7 @@
 #include <string.h>
 #include <sys/epoll.h>
 #include <sys/ioctl.h>
+#include <sys/mman.h>
 #include <sys/socket.h>
 #include <sys/types.h>
 #include <sys/un.h>
@@ -38,6 +39,10 @@ struct _fixture_coredump_data {
 
 #define NUM_THREAD_SPAWN 128
 
+#ifndef SO_PEERPIDFD_THREAD
+#define SO_PEERPIDFD_THREAD 87
+#endif
+
 void *do_nothing(void *arg)
 {
 	(void)arg;
@@ -59,6 +64,36 @@ void crashing_child(void)
 	i = *(volatile int *)NULL;
 }
 
+static void *crashing_thread(void *arg)
+{
+	int *p;
+
+	(void)arg;
+
+	/* crash on purpose with SEGV_MAPERR */
+	p = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE,
+		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (p == MAP_FAILED)
+		return NULL;
+	munmap(p, PAGE_SIZE);
+	*p = 0;
+
+	return NULL;
+}
+
+void crashing_child_thread(void)
+{
+	pthread_t thread;
+	int i;
+
+	for (i = 0; i < NUM_THREAD_SPAWN; ++i)
+		pthread_create(&thread, NULL, do_nothing, NULL);
+
+	/* crash from a non-leader thread */
+	pthread_create(&thread, NULL, crashing_thread, NULL);
+	pause();
+}
+
 int create_detached_tmpfs(void)
 {
 	int fd_context, fd_tmpfs;
@@ -138,6 +173,20 @@ int get_peer_pidfd(int fd)
 	return fd_peer_pidfd;
 }
 
+int get_peer_pidfd_thread(int fd)
+{
+	int fd_peer_pidfd;
+	socklen_t fd_peer_pidfd_len = sizeof(fd_peer_pidfd);
+	int ret = getsockopt(fd, SOL_SOCKET, SO_PEERPIDFD_THREAD, &fd_peer_pidfd,
+			     &fd_peer_pidfd_len);
+	if (ret < 0) {
+		fprintf(stderr, "%s: getsockopt(SO_PEERPIDFD_THREAD) failed: %m\n", __func__);
+		return -1;
+	}
+	fprintf(stderr, "%s: successfully retrieved pidfd %d\n", __func__, fd_peer_pidfd);
+	return fd_peer_pidfd;
+}
+
 bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info)
 {
 	int ret;

-- 
2.53.0

