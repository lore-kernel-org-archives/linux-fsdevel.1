Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573E443F8D6
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 15:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585332; cv=none; b=I3nr07QpJ+MPBIbTKadJgbYubMyUh6+aNNF8sZNuCTTQzgfRbAaMGPPTbf/R2hJ6dmm8ycCpA0lvqIgisntyzWWBX1LOYQlnASBudztF8JnOxpJnqNuuKTxX5h8CEI6fYZorayT6Ih558VQ5roDDGGh7dIm6WacgdKbp4CzvjxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585332; c=relaxed/simple;
	bh=x43/T0wiB+UjD93g/JIAqunVjhrjiFeEfm+zi3VZJWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RYCeoHakQHAncEkMxq46DEzWO8Ekfug17GTcH1npszLcVJew0+MuvVJfsvCgL67lMRDIYyxgbz0f1uWK6VbkrVIXAfpHZ+PMB4d8JvY4OBXRZzY64r+gHteRvwvRbYOKU5HcwU508CIR/8reenv7m7iU9uB2zkxM5gVlTiMOQjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=df3m65Lk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="df3m65Lk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C4431F00A3E;
	Mon, 24 Aug 2026 15:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787585326;
	bh=dBA3XTtcbi3WQwS1DXCcTnrYq9tTDZBDed2x/oziNtc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=df3m65LkRKF65XEFDOE6ePS9pmljoY2049HrAVpGSl7r9AurOjAgZ55/n4k/rEa+H
	 ywDoPs4RYfOzomNv41GPG7PlDfMpTOlWPbXJxLxIGcc94qs6fKkcI1bIlM5ZkvldY4
	 yL+7oZY6f9m1rDYhox9QZ+3n7WfXqQPUnfrE54xW00zeHOhRetulV6UNtjtU9U3hk0
	 V7usYM9D9pcWIYMj9lFF1hERIjus6AsmwHrW53EG1djGemBwEz1qQAJWm9YOaA9Ozl
	 cVpjJdUH9bEtTbUPD3OAtiWQWcJLkRI8EVSlrCvZimBSx5fMZNv2XSxM4oll2PkYGX
	 nVS3tDDxUU3FQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 24 Aug 2026 17:28:21 +0200
Subject: [PATCH RFC 7/7] selftests/coredump: test COREDUMP_CLOSE_FILES
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-work-coredump-unlock-self-v1-7-48fd1cca7eda@kernel.org>
References: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
In-Reply-To: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=17961; i=brauner@kernel.org;
 h=from:subject:message-id; bh=x43/T0wiB+UjD93g/JIAqunVjhrjiFeEfm+zi3VZJWg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT1JEt1VT42OmHHu+arhcYc8zubAvKT7zJUMdnNf5Dms
 0xZ9sPzjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk8/8nIcGjbJaW4VJ6UauO8
 5uZD9vGVlhmz3FfeMTnd+mOLWf/sqYwMPyvv2lzbuu/k7I/brKVqN9d8tpSOOKacVFn0yTgkNKq
 ZFQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Test COREDUMP_CLOSE_FILES.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/coredump/Makefile          |   4 +-
 .../selftests/coredump/coredump_close_files_test.c | 592 +++++++++++++++++++++
 .../coredump/coredump_socket_protocol_test.c       |   6 +
 .../selftests/coredump/coredump_test_helpers.c     |   3 +-
 4 files changed, 603 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/coredump/Makefile b/tools/testing/selftests/coredump/Makefile
index dece1a31d561..dc8489d40618 100644
--- a/tools/testing/selftests/coredump/Makefile
+++ b/tools/testing/selftests/coredump/Makefile
@@ -3,7 +3,8 @@ CFLAGS += -Wall -O0 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 
 TEST_GEN_PROGS := stackdump_test \
 		  coredump_socket_test \
-		  coredump_socket_protocol_test
+		  coredump_socket_protocol_test \
+		  coredump_close_files_test
 TEST_FILES := stackdump
 
 include ../lib.mk
@@ -11,3 +12,4 @@ include ../lib.mk
 $(OUTPUT)/stackdump_test: coredump_test_helpers.c
 $(OUTPUT)/coredump_socket_test: coredump_test_helpers.c
 $(OUTPUT)/coredump_socket_protocol_test: coredump_test_helpers.c
+$(OUTPUT)/coredump_close_files_test: coredump_test_helpers.c
diff --git a/tools/testing/selftests/coredump/coredump_close_files_test.c b/tools/testing/selftests/coredump/coredump_close_files_test.c
new file mode 100644
index 000000000000..7a41906b4695
--- /dev/null
+++ b/tools/testing/selftests/coredump/coredump_close_files_test.c
@@ -0,0 +1,592 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dirent.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <sys/file.h>
+#include <sys/stat.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include "coredump_test.h"
+
+#define LOCK_FILE "/tmp/coredump.lock"
+
+/* Idle threads the multi-threaded crashing child spawns. */
+#define NUM_CLOSE_THREADS 4
+
+/* How the crashing child locks LOCK_FILE. */
+enum lock_kind {
+	LOCK_KIND_POSIX,
+	LOCK_KIND_OFD,
+	LOCK_KIND_FLOCK,
+};
+
+/* Who else has a handle on the lock when the child crashes. */
+enum lock_share {
+	LOCK_SHARE_NONE,
+	LOCK_SHARE_DUP,		/* a second slot in the child's own table */
+	LOCK_SHARE_FORK,	/* a forked process keeps the fd open */
+	LOCK_SHARE_FILES,	/* a CLONE_FILES process shares the table */
+};
+
+struct close_test {
+	enum lock_kind kind;
+	enum lock_share share;
+	bool threads;
+	bool close;		/* ack with COREDUMP_CLOSE_FILES */
+	bool userspace;		/* COREDUMP_USERSPACE instead of COREDUMP_KERNEL */
+	bool released;		/* the lock is gone once the kernel is past the close */
+};
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
+	self->fd_tmpfs_detached = create_detached_tmpfs();
+	ASSERT_GE(self->fd_tmpfs_detached, 0);
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
+	unlink(LOCK_FILE);
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
+	if (self->fd_tmpfs_detached >= 0) {
+		ret = close(self->fd_tmpfs_detached);
+		if (ret < 0) {
+			reason = "Unable to close detached tmpfs";
+			goto fail;
+		}
+		self->fd_tmpfs_detached = -1;
+	}
+
+	return;
+fail:
+	/* This should never happen */
+	fprintf(stderr, "Failed to cleanup coredump test: %s\n", reason);
+}
+
+/* Write-lock @fd the way @kind says. */
+static int take_lock(int fd, enum lock_kind kind)
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+	};
+
+	switch (kind) {
+	case LOCK_KIND_POSIX:
+		return fcntl(fd, F_SETLK, &fl);
+	case LOCK_KIND_OFD:
+		return fcntl(fd, F_OFD_SETLK, &fl);
+	case LOCK_KIND_FLOCK:
+		return flock(fd, LOCK_EX);
+	}
+
+	return -1;
+}
+
+/* Does anyone else hold a write lock on @fd? 1 if so, 0 if not, -1 on error. */
+static int lock_held(int fd, enum lock_kind kind)
+{
+	struct flock fl = {
+		.l_type = F_WRLCK,
+		.l_whence = SEEK_SET,
+	};
+
+	if (kind == LOCK_KIND_FLOCK) {
+		if (flock(fd, LOCK_EX | LOCK_NB) == 0) {
+			flock(fd, LOCK_UN);
+			return 0;
+		}
+		return errno == EWOULDBLOCK ? 1 : -1;
+	}
+
+	/* F_GETLK reports conflicting OFD locks too. */
+	if (fcntl(fd, F_GETLK, &fl) < 0)
+		return -1;
+	return fl.l_type != F_UNLCK;
+}
+
+/* Number of entries in /proc/@pid/fd, the lowest one in @first. */
+static int count_fds(pid_t pid, int *first)
+{
+	char path[64];
+	struct dirent *de;
+	DIR *dir;
+	int nr = 0;
+
+	snprintf(path, sizeof(path), "/proc/%d/fd", pid);
+	dir = opendir(path);
+	if (!dir)
+		return -1;
+
+	*first = -1;
+	while ((de = readdir(dir))) {
+		int fd;
+
+		if (de->d_name[0] == '.')
+			continue;
+		fd = atoi(de->d_name);
+		if (*first < 0 || fd < *first)
+			*first = fd;
+		nr++;
+	}
+	closedir(dir);
+	return nr;
+}
+
+/*
+ * Block until the test hangs up @fd_release, keeping every inherited fd
+ * open, then report through @fd_result whether @fd is still open.
+ */
+static void hold_until_released(int fd, int fd_release, int fd_result)
+{
+	char c;
+
+	read_nointr(fd_release, &c, 1);
+	c = fcntl(fd, F_GETFD) < 0 ? 'C' : 'O';
+	write_nointr(fd_result, &c, 1);
+	_exit(EXIT_SUCCESS);
+}
+
+/* Lock LOCK_FILE, share it as requested, then crash. */
+static void crashing_child_locked(const struct close_test *t, int fd_release,
+				  int fd_result)
+{
+	pthread_t thread;
+	int fd, pidfd, i;
+	pid_t pid;
+
+	fd = open(LOCK_FILE, O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		_exit(EXIT_FAILURE);
+
+	if (take_lock(fd, t->kind))
+		_exit(EXIT_FAILURE);
+
+	switch (t->share) {
+	case LOCK_SHARE_NONE:
+		break;
+	case LOCK_SHARE_DUP:
+		if (dup(fd) < 0)
+			_exit(EXIT_FAILURE);
+		break;
+	case LOCK_SHARE_FORK:
+		pid = fork();
+		if (pid < 0)
+			_exit(EXIT_FAILURE);
+		if (pid == 0)
+			hold_until_released(fd, fd_release, fd_result);
+		break;
+	case LOCK_SHARE_FILES:
+		pid = create_child(&pidfd, CLONE_FILES);
+		if (pid < 0)
+			_exit(EXIT_FAILURE);
+		if (pid == 0)
+			hold_until_released(fd, fd_release, fd_result);
+		break;
+	}
+
+	if (t->threads)
+		for (i = 0; i < NUM_CLOSE_THREADS; i++)
+			pthread_create(&thread, NULL, do_nothing, NULL);
+
+	/* crash on purpose */
+	*(volatile int *)NULL = 0;
+}
+
+/*
+ * Serve one coredump and look at the task on the way. Before the ack the
+ * lock is held and the descriptors are there. Once the kernel is past the
+ * point where it closes them, which is before the first byte of the dump
+ * or before the hangup in userspace mode, they are gone if we asked for
+ * it and the lock is in the expected state.
+ */
+static int close_server(const struct close_test *t, int fd_ipc)
+{
+	struct coredump_req req = {};
+	struct pidfd_info info = {};
+	int fd_server = -1, fd_coredump = -1, fd_peer_pidfd = -1, fd_lock = -1;
+	int exit_code = EXIT_FAILURE;
+	int fd, first_fd, nr_fds;
+	__u64 mask;
+	ssize_t bytes;
+	char c;
+
+	fd_lock = open(LOCK_FILE, O_RDWR | O_CLOEXEC);
+	if (fd_lock < 0) {
+		fprintf(stderr, "%s: open lock file failed: %m\n", __func__);
+		goto out;
+	}
+
+	fd_server = create_and_listen_unix_socket("/tmp/coredump.socket");
+	if (fd_server < 0) {
+		fprintf(stderr, "%s: create_and_listen_unix_socket failed: %m\n", __func__);
+		goto out;
+	}
+
+	if (write_nointr(fd_ipc, "1", 1) < 0) {
+		fprintf(stderr, "%s: write_nointr to ipc socket failed: %m\n", __func__);
+		goto out;
+	}
+	close(fd_ipc);
+
+	fd_coredump = accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
+	if (fd_coredump < 0) {
+		fprintf(stderr, "%s: accept4 failed: %m\n", __func__);
+		goto out;
+	}
+
+	fd_peer_pidfd = get_peer_pidfd(fd_coredump);
+	if (fd_peer_pidfd < 0) {
+		fprintf(stderr, "%s: get_peer_pidfd failed\n", __func__);
+		goto out;
+	}
+
+	if (!get_pidfd_info(fd_peer_pidfd, &info)) {
+		fprintf(stderr, "%s: get_pidfd_info failed\n", __func__);
+		goto out;
+	}
+
+	if (!read_coredump_req(fd_coredump, &req)) {
+		fprintf(stderr, "%s: read_coredump_req failed\n", __func__);
+		goto out;
+	}
+
+	if (!check_coredump_req(&req)) {
+		fprintf(stderr, "%s: check_coredump_req failed\n", __func__);
+		goto out;
+	}
+
+	/* The task waits for our answer with everything still in place. */
+	if (lock_held(fd_lock, t->kind) != 1) {
+		fprintf(stderr, "%s: lock not held during the handshake\n", __func__);
+		goto out;
+	}
+
+	nr_fds = count_fds(info.pid, &first_fd);
+	if (nr_fds <= 0) {
+		fprintf(stderr, "%s: no descriptors during the handshake\n", __func__);
+		goto out;
+	}
+
+	fd = sys_pidfd_getfd(fd_peer_pidfd, first_fd, 0);
+	if (fd < 0) {
+		fprintf(stderr, "%s: pidfd_getfd during the handshake failed: %m\n", __func__);
+		goto out;
+	}
+	close(fd);
+
+	mask = COREDUMP_WAIT;
+	mask |= t->userspace ? COREDUMP_USERSPACE : COREDUMP_KERNEL;
+	if (t->close)
+		mask |= COREDUMP_CLOSE_FILES;
+
+	if (!send_coredump_ack(fd_coredump, &req, mask, 0)) {
+		fprintf(stderr, "%s: send_coredump_ack failed\n", __func__);
+		goto out;
+	}
+
+	if (!read_marker(fd_coredump, COREDUMP_MARK_REQACK)) {
+		fprintf(stderr, "%s: read_marker COREDUMP_MARK_REQACK failed\n", __func__);
+		goto out;
+	}
+
+	bytes = read_nointr(fd_coredump, &c, 1);
+	if (bytes != (t->userspace ? 0 : 1)) {
+		fprintf(stderr, "%s: read after the ack returned %zd: %m\n", __func__, bytes);
+		goto out;
+	}
+
+	if (lock_held(fd_lock, t->kind) != !t->released) {
+		fprintf(stderr, "%s: lock %s while the coredump is generated\n",
+			__func__, t->released ? "still held" : "released");
+		goto out;
+	}
+
+	nr_fds = count_fds(info.pid, &first_fd);
+	if (nr_fds < 0 || !nr_fds != t->close) {
+		fprintf(stderr, "%s: %d descriptors while the coredump is generated\n",
+			__func__, nr_fds);
+		goto out;
+	}
+
+	fd = sys_pidfd_getfd(fd_peer_pidfd, first_fd, 0);
+	if (t->close) {
+		if (fd >= 0 || errno != EBADF) {
+			fprintf(stderr, "%s: pidfd_getfd after the close returned %d: %m\n",
+				__func__, fd);
+			goto out;
+		}
+	} else {
+		if (fd < 0) {
+			fprintf(stderr, "%s: pidfd_getfd during the coredump failed: %m\n",
+				__func__);
+			goto out;
+		}
+		close(fd);
+	}
+
+	/* COREDUMP_WAIT keeps the task around until we hang up. */
+	if (!get_pidfd_info(fd_peer_pidfd, &info)) {
+		fprintf(stderr, "%s: get_pidfd_info failed\n", __func__);
+		goto out;
+	}
+
+	if (info.mask & PIDFD_INFO_EXIT) {
+		fprintf(stderr, "%s: task exited before the coredump finished\n", __func__);
+		goto out;
+	}
+
+	for (;;) {
+		char buffer[4096];
+
+		bytes = read_nointr(fd_coredump, buffer, sizeof(buffer));
+		if (bytes < 0) {
+			fprintf(stderr, "%s: read from coredump socket failed: %m\n", __func__);
+			goto out;
+		}
+
+		if (bytes == 0)
+			break;
+	}
+
+	exit_code = EXIT_SUCCESS;
+out:
+	if (fd_lock >= 0)
+		close(fd_lock);
+	if (fd_peer_pidfd >= 0)
+		close(fd_peer_pidfd);
+	if (fd_coredump >= 0)
+		close(fd_coredump);
+	if (fd_server >= 0)
+		close(fd_server);
+	return exit_code;
+}
+
+static void run_close_test(struct __test_metadata *const _metadata,
+			   FIXTURE_DATA(coredump) *self,
+			   const struct close_test *t)
+{
+	int fd, status, ipc_sockets[2], release_pipe[2], result_pipe[2];
+	pid_t pid, pid_coredump_server;
+	char c;
+
+	ASSERT_TRUE(set_core_pattern("@@/tmp/coredump.socket"));
+
+	fd = open(LOCK_FILE, O_RDWR | O_CREAT | O_TRUNC | O_CLOEXEC, 0644);
+	ASSERT_GE(fd, 0);
+	EXPECT_EQ(close(fd), 0);
+
+	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, ipc_sockets), 0);
+
+	pid_coredump_server = fork();
+	ASSERT_GE(pid_coredump_server, 0);
+	if (pid_coredump_server == 0) {
+		close(ipc_sockets[0]);
+		_exit(close_server(t, ipc_sockets[1]));
+	}
+	self->pid_coredump_server = pid_coredump_server;
+
+	EXPECT_EQ(close(ipc_sockets[1]), 0);
+	ASSERT_EQ(read_nointr(ipc_sockets[0], &c, 1), 1);
+	EXPECT_EQ(close(ipc_sockets[0]), 0);
+
+	/* Only the crashing child and what it spawns see these pipes. */
+	ASSERT_EQ(pipe2(release_pipe, O_CLOEXEC), 0);
+	ASSERT_EQ(pipe2(result_pipe, O_CLOEXEC), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+	if (pid == 0) {
+		close(release_pipe[1]);
+		close(result_pipe[0]);
+		crashing_child_locked(t, release_pipe[0], result_pipe[1]);
+	}
+	EXPECT_EQ(close(release_pipe[0]), 0);
+	EXPECT_EQ(close(result_pipe[1]), 0);
+
+	waitpid(pid, &status, 0);
+	ASSERT_TRUE(WIFSIGNALED(status));
+	ASSERT_TRUE(WCOREDUMP(status));
+
+	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
+
+	/* Let the process holding the shared lock go. */
+	EXPECT_EQ(close(release_pipe[1]), 0);
+
+	/* The crashing child is gone but what it shared with is untouched. */
+	if (t->share == LOCK_SHARE_FORK || t->share == LOCK_SHARE_FILES) {
+		ASSERT_EQ(read_nointr(result_pipe[0], &c, 1), 1);
+		ASSERT_EQ(c, 'O');
+	}
+	EXPECT_EQ(close(result_pipe[0]), 0);
+}
+
+TEST_F(coredump, close_files_posix)
+{
+	const struct close_test t = {
+		.kind = LOCK_KIND_POSIX,
+		.share = LOCK_SHARE_NONE,
+		.threads = true,
+		.close = true,
+		.released = true,
+	};
+
+	run_close_test(_metadata, self, &t);
+}
+
+TEST_F(coredump, close_files_ofd)
+{
+	const struct close_test t = {
+		.kind = LOCK_KIND_OFD,
+		.share = LOCK_SHARE_NONE,
+		.close = true,
+		.released = true,
+	};
+
+	run_close_test(_metadata, self, &t);
+}
+
+TEST_F(coredump, close_files_flock)
+{
+	const struct close_test t = {
+		.kind = LOCK_KIND_FLOCK,
+		.share = LOCK_SHARE_NONE,
+		.threads = true,
+		.close = true,
+		.released = true,
+	};
+
+	run_close_test(_metadata, self, &t);
+}
+
+TEST_F(coredump, close_files_flock_dup)
+{
+	const struct close_test t = {
+		.kind = LOCK_KIND_FLOCK,
+		.share = LOCK_SHARE_DUP,
+		.close = true,
+		.released = true,
+	};
+
+	run_close_test(_metadata, self, &t);
+}
+
+TEST_F(coredump, close_files_posix_fork)
+{
+	const struct close_test t = {
+		.kind = LOCK_KIND_POSIX,
+		.share = LOCK_SHARE_FORK,
+		.close = true,
+		.released = true,
+	};
+
+	run_close_test(_metadata, self, &t);
+}
+
+TEST_F(coredump, close_files_flock_fork)
+{
+	const struct close_test t = {
+		.kind = LOCK_KIND_FLOCK,
+		.share = LOCK_SHARE_FORK,
+		.close = true,
+		.released = false,
+	};
+
+	run_close_test(_metadata, self, &t);
+}
+
+TEST_F(coredump, close_files_ofd_fork)
+{
+	const struct close_test t = {
+		.kind = LOCK_KIND_OFD,
+		.share = LOCK_SHARE_FORK,
+		.close = true,
+		.released = false,
+	};
+
+	run_close_test(_metadata, self, &t);
+}
+
+TEST_F(coredump, close_files_posix_shared_table)
+{
+	const struct close_test t = {
+		.kind = LOCK_KIND_POSIX,
+		.share = LOCK_SHARE_FILES,
+		.close = true,
+		.released = false,
+	};
+
+	run_close_test(_metadata, self, &t);
+}
+
+TEST_F(coredump, close_files_userspace)
+{
+	const struct close_test t = {
+		.kind = LOCK_KIND_FLOCK,
+		.share = LOCK_SHARE_NONE,
+		.close = true,
+		.userspace = true,
+		.released = true,
+	};
+
+	run_close_test(_metadata, self, &t);
+}
+
+TEST_F(coredump, close_files_not_requested)
+{
+	const struct close_test t = {
+		.kind = LOCK_KIND_FLOCK,
+		.share = LOCK_SHARE_NONE,
+		.threads = true,
+		.close = false,
+		.released = false,
+	};
+
+	run_close_test(_metadata, self, &t);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
index f5c9bad87546..beb167698cfd 100644
--- a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
@@ -2377,6 +2377,12 @@ TEST_F(coredump, socket_request_memory_types_without_kernel)
 	check_conflicting_ack(_metadata, self, COREDUMP_USERSPACE | COREDUMP_MEMORY_TYPES);
 }
 
+/* A rejected task closes everything on its way out anyway. */
+TEST_F(coredump, socket_request_close_files_reject)
+{
+	check_conflicting_ack(_metadata, self, COREDUMP_REJECT | COREDUMP_CLOSE_FILES);
+}
+
 /*
  * A server built with the first structs reads the request it knows,
  * discards the rest and acks with the ack it knows. It raises nothing
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 4e36e3e4fb78..65132a0deced 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -1612,7 +1612,8 @@ bool send_coredump_ack(int fd, const struct coredump_req *req,
 #define TEST_REQ_MASK_ALL					\
 	(COREDUMP_KERNEL | COREDUMP_USERSPACE |			\
 	 COREDUMP_REJECT | COREDUMP_WAIT |			\
-	 COREDUMP_RECORDS | COREDUMP_SPARSE | COREDUMP_MEMORY_TYPES)
+	 COREDUMP_RECORDS | COREDUMP_SPARSE | COREDUMP_MEMORY_TYPES | \
+	 COREDUMP_CLOSE_FILES)
 
 bool check_coredump_req(const struct coredump_req *req)
 {

-- 
2.53.0

