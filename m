Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376751;
	b=Sn5Rt411+RYITQfbbZiq/FPwrjNAiHaK8IV2AfTKhzdJa7pyi8H6BFnAkLdKmzM9gLcY
	 nCuj8i8Dqy783BYAs7TAMHeQw78lPOlqcmCqmA+wBVtSope8K5eriaMkJABEjmCb7xDvh
	 0BVVJi9+sSzjgkP5FDd84X1RQ0CI+QpfdT0c2o5GfJhKxs2g38tSO5RrZSnrQ8ma1/Men
	 nRuW5O6wJNyPqQmQqGMSe5BE+rfJ/inkJMKWk/xGQabejF9Z9MNeCJfFiA0FRQVoGUuD4
	 4vseCgPYkngqYijfk4HXJOoj/O4ajpc6KthuLeY9Tzq/L5BVsDmhUmdb+xVXNyqTOlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376751;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5sic9TNuR3kGzKnEdqX4FJc9Jv5CBJ4xQLsn1NfnAv8=;
	b=idM8l9zVOPdFDMdX0b/NyLRJPG0CtI2k5+lTa1cCLSjGzj0L6omWhgfrfDFSp9wsGUjS
	 /QNiMOUYc6ruCkgtLhm3dxW+os3sJ2DlE7nihUJ1iCgi+p8xQ9R0mFcjj31K8ObSdemAp
	 JEbxZiHygSe4NtuD5GF7Y9FL7aGrjoBQ5lqqPftGel5ja0y2P5fh4STso7YXKjSqWv9Bj
	 cTSfDOXcYDMMPwAYmnejbjvtdnHo4ydxRL6QKIdUui7AsstJPN3do42us7cRFJYDjyeUj
	 ZWC0G/iT3gHZa/LlkSIUGgBOXyVzumnu99eib+MQNgfa5aK/IZ/cyg44F+uKB4HWBaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZTyrsH5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A3E606A31D
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZTyrsH5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077271F0093A;
	Fri, 30 Oct 2026 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793376750;
	bh=5sic9TNuR3kGzKnEdqX4FJc9Jv5CBJ4xQLsn1NfnAv8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MZTyrsH5cnGYJ2EOo3Dv6dGBrwt0gsZVvgwH/pYe0fzB12qXGCqxze/Hk/IxqmK2Y
	 P89+mYoAw6/XU2S6XBWLQqjEPVwFWOf6A6q8kb8nudtR+HNf8ai7gFYF5sEOoopFDC
	 OTR+42hHx0ltZEyYCSCiVNj0HoxcCfmspT3q7US+y2/yxICfMygcfdEuzsTJbv7XVb
	 Adr1dcH4QCz2x2ZMopBj2maMd7oKVzqhYDG7pDD6O7C55aWQeLEtP05Wtcxl+hU50U
	 O78WBS+ws4czOtt2g1aXg0Cd6saX587kFEWNBxHm/+36tUuWZkEUJZbWwLFHxb0D3G
	 6NqsGIZwIzcsQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Oct 2026 17:11:59 +0100
Subject: [PATCH 7/7] selftests/proc: check /proc/<pid> files across a
 set-user-ID exec
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-work-procfs-ai-fixes-v1-7-772392d3ccfd@kernel.org>
References: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org>
In-Reply-To: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org>
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=16939; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BZuQavGPE9jGv4k4Wh6HfRTf9q0pBiKZGCP1ow6penI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9OXi3ZW7G5yvZEv9mVL08Z8Zsw1UZXqU5/QVPzzvZB
 37v9hTod5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkUjkjw7rUhE9xOrl+M+yq
 T8nOCvBu5pv58a2xYdYOeQ9JVTtNBkaGebF2Xo8dU6RX/NgikceyRuz44dWf7Qy6Yy7s3ttxs/M
 FIwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Open fdinfo/<fd>, ksm_stat, fd/ and fdinfo/ of a task and fd/ with
O_PATH, let the task execute a set-user-ID program and use them:

- an unprivileged opener is refused

- also when a privileged process does the reading

- also when the new program itself reads the ksm_stat its predecessor
  opened

- a privileged opener isn't, except for lookups below fd/

- nothing changes for a program that isn't set-user-ID

- getdents() of fd/ that sleeps in its first copy to userspace while
  the task executes doesn't list the new program's descriptors

The test copies itself to a tmpfs, once with the set-user-ID bit, and
runs that copy as the new program.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/proc/.gitignore            |   1 +
 tools/testing/selftests/proc/Makefile              |   1 +
 tools/testing/selftests/proc/config                |   2 +
 .../testing/selftests/proc/proc-pid-setuid-exec.c  | 546 +++++++++++++++++++++
 4 files changed, 550 insertions(+)

diff --git a/tools/testing/selftests/proc/.gitignore b/tools/testing/selftests/proc/.gitignore
index 9c9735570abf..4a5c33b40552 100644
--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -9,6 +9,7 @@
 /proc-multiple-procfs
 /proc-net-dev-lseek
 /proc-empty-vm
+/proc-pid-setuid-exec
 /proc-pid-vm
 /proc-self-map-files-001
 /proc-self-map-files-002
diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index a7de2bb6d8be..2fc4c4117eee 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -30,5 +30,6 @@ TEST_GEN_PROGS += thread-self
 TEST_GEN_PROGS += proc-multiple-procfs
 TEST_GEN_PROGS += proc-fsconfig-hidepid
 TEST_GEN_PROGS += proc-pidns
+TEST_GEN_PROGS += proc-pid-setuid-exec
 
 include ../lib.mk
diff --git a/tools/testing/selftests/proc/config b/tools/testing/selftests/proc/config
index 68fbd2b35884..249cd78908da 100644
--- a/tools/testing/selftests/proc/config
+++ b/tools/testing/selftests/proc/config
@@ -1 +1,3 @@
 CONFIG_PROC_FS=y
+CONFIG_KSM=y
+CONFIG_USERFAULTFD=y
diff --git a/tools/testing/selftests/proc/proc-pid-setuid-exec.c b/tools/testing/selftests/proc/proc-pid-setuid-exec.c
new file mode 100644
index 000000000000..f1b3115043aa
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-pid-setuid-exec.c
@@ -0,0 +1,546 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Files in /proc/<pid> that were opened before the task executed a set-user-ID
+ * program must stop working if their opener has no access to the new program,
+ * no matter who reads them.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <grp.h>
+#include <limits.h>
+#include <linux/userfaultfd.h>
+#include <poll.h>
+#include <pthread.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <sys/prctl.h>
+#include <sys/sendfile.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#define TEST_UID	65534
+#define TARGET_FD	100	/* open before and after the exec */
+#define NEW_FD		101	/* only opened by the new program */
+#define SELF_KSM_FD	102	/* ksm_stat, read by the new program */
+#define HELPER_ARG	"helper"
+#define BIN_DIR		"/tmp"
+#define SUID_BIN	BIN_DIR "/suid"
+#define PLAIN_BIN	BIN_DIR "/plain"
+#define LISTED_NEW_FD	10	/* getdents_overtaken() saw NEW_FD */
+#define OPEN_AS_ROOT	(1U << 0)
+#define READ_AS_ROOT	(1U << 1)
+
+enum probe {
+	PROBE_FD_LOOKUP,
+	PROBE_FDINFO,
+	PROBE_KSM,
+	PROBE_FD_DIR,
+	PROBE_FDINFO_DIR,
+	PROBE_KSM_SELF,		/* read by the new program itself, keep last */
+	NR_PROBES,
+};
+
+static const char *const probe_name[NR_PROBES] = {
+	[PROBE_FD_LOOKUP]	= "fstatat() below fd/ opened with O_PATH",
+	[PROBE_FDINFO]		= "read() of fdinfo/<fd>",
+	[PROBE_KSM]		= "read() of ksm_stat",
+	[PROBE_FD_DIR]		= "getdents64() of fd/",
+	[PROBE_FDINFO_DIR]	= "getdents64() of fdinfo/",
+	[PROBE_KSM_SELF]	= "read() of ksm_stat by the new program",
+};
+
+enum result {
+	WORKS,
+	DENIED,
+	FAILED,		/* any other error */
+	MISSING,	/* couldn't be opened */
+};
+
+#define RES_SIZE	(sizeof(enum result) * NR_PROBES)
+
+struct target {
+	pid_t pid;
+	int go;
+	int ready;
+	enum result ksm_self;	/* what the new program read from SELF_KSM_FD */
+};
+
+struct linux_dirent64 {
+	uint64_t d_ino;
+	int64_t d_off;
+	unsigned short d_reclen;
+	unsigned char d_type;
+	char d_name[];
+};
+
+static enum result result_of(ssize_t ret)
+{
+	if (ret >= 0)
+		return WORKS;
+	return errno == EACCES ? DENIED : FAILED;
+}
+
+/* The new program reads the ksm_stat its predecessor opened. */
+static enum result read_self_ksm(void)
+{
+	char buf[256];
+	ssize_t ret;
+
+	ret = read(SELF_KSM_FD, buf, sizeof(buf));
+	if (ret < 0 && errno == EBADF)
+		return MISSING;
+	return result_of(ret);
+}
+
+/* Runs as the new program: open a file of its own and wait to be killed. */
+static int helper(void)
+{
+	char res = read_self_ksm();
+	int fd = open("/dev/null", O_RDONLY);
+
+	if (fd < 0 || dup2(fd, NEW_FD) < 0 || write(TARGET_FD, &res, 1) != 1)
+		return 1;
+	pause();
+	return 0;
+}
+
+static int copy_self(const char *path, mode_t mode)
+{
+	int in, out, ret = -1;
+	ssize_t n;
+
+	in = open("/proc/self/exe", O_RDONLY | O_CLOEXEC);
+	if (in < 0)
+		return -1;
+	out = open(path, O_WRONLY | O_CREAT | O_EXCL | O_CLOEXEC, 0700);
+	if (out >= 0) {
+		while ((n = sendfile(out, in, NULL, INT_MAX)) > 0)
+			;
+		if (!n && !fchmod(out, mode))
+			ret = 0;
+		close(out);
+	}
+	close(in);
+	return ret;
+}
+
+static int drop_privileges(void)
+{
+	if (setgroups(0, NULL) ||
+	    setresgid(TEST_UID, TEST_UID, TEST_UID) ||
+	    setresuid(TEST_UID, TEST_UID, TEST_UID))
+		return -1;
+	return 0;
+}
+
+/* Starts out as TEST_UID and executes @bin when told to. */
+static int start_target(struct target *t, const char *bin)
+{
+	int go[2], ready[2];
+	char c;
+
+	if (pipe2(go, O_CLOEXEC) || pipe2(ready, O_CLOEXEC))
+		return -1;
+
+	t->pid = fork();
+	if (t->pid < 0)
+		return -1;
+	if (!t->pid) {
+		int fd;
+
+		/* Dropping privileges made it undumpable. */
+		if (drop_privileges() || prctl(PR_SET_DUMPABLE, 1))
+			_exit(1);
+		/* TARGET_FD survives the exec, the new program reports on it. */
+		if (dup2(ready[1], TARGET_FD) < 0)
+			_exit(1);
+		/* So does SELF_KSM_FD, the new program reads it. */
+		fd = open("/proc/self/ksm_stat", O_RDONLY);
+		if (fd >= 0 && (dup2(fd, SELF_KSM_FD) < 0 || close(fd)))
+			_exit(1);
+		if (write(TARGET_FD, "a", 1) != 1 || read(go[0], &c, 1) != 1)
+			_exit(1);
+		execl(bin, bin, HELPER_ARG, NULL);
+		_exit(1);
+	}
+	close(go[0]);
+	close(ready[1]);
+	t->go = go[1];
+	t->ready = ready[0];
+	return read(t->ready, &c, 1) == 1 ? 0 : -1;
+}
+
+/* Lets the target exec and collects the new program's SELF_KSM_FD result. */
+static int exec_target(struct target *t)
+{
+	char c;
+
+	if (write(t->go, "x", 1) != 1 || read(t->ready, &c, 1) != 1)
+		return -1;
+	t->ksm_self = c;
+	return 0;
+}
+
+static void stop_target(struct target *t)
+{
+	kill(t->pid, SIGKILL);
+	waitpid(t->pid, NULL, 0);
+	close(t->go);
+	close(t->ready);
+}
+
+static void open_probes(pid_t pid, int fds[NR_PROBES])
+{
+	char path[64];
+
+	snprintf(path, sizeof(path), "/proc/%d/fd", pid);
+	fds[PROBE_FD_LOOKUP] = open(path, O_PATH | O_DIRECTORY | O_CLOEXEC);
+	fds[PROBE_FD_DIR] = open(path, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	snprintf(path, sizeof(path), "/proc/%d/fdinfo/%d", pid, TARGET_FD);
+	fds[PROBE_FDINFO] = open(path, O_RDONLY | O_CLOEXEC);
+	snprintf(path, sizeof(path), "/proc/%d/fdinfo", pid);
+	fds[PROBE_FDINFO_DIR] = open(path, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	snprintf(path, sizeof(path), "/proc/%d/ksm_stat", pid);
+	fds[PROBE_KSM] = open(path, O_RDONLY | O_CLOEXEC);
+	/* The target did that one itself. */
+	fds[PROBE_KSM_SELF] = -1;
+}
+
+/* Open the probes as TEST_UID and hand them over. */
+static int open_probes_unprivileged(pid_t pid, int fds[NR_PROBES])
+{
+	char cbuf[CMSG_SPACE(sizeof(int) * NR_PROBES)] = {};
+	int present[NR_PROBES], sk[2], i, n = 0, status;
+	struct iovec iov = { present, sizeof(present) };
+	struct msghdr msg = { .msg_iov = &iov, .msg_iovlen = 1,
+			      .msg_control = cbuf };
+	struct cmsghdr *cmsg;
+	int *rights;
+	pid_t child;
+
+	if (socketpair(AF_UNIX, SOCK_STREAM | SOCK_CLOEXEC, 0, sk))
+		return -1;
+
+	child = fork();
+	if (child < 0)
+		return -1;
+	if (!child) {
+		int mine[NR_PROBES];
+
+		close(sk[0]);
+		if (drop_privileges())
+			_exit(1);
+		open_probes(pid, mine);
+		cmsg = (struct cmsghdr *)cbuf;
+		rights = (int *)CMSG_DATA(cmsg);
+		for (i = 0; i < NR_PROBES; i++) {
+			present[i] = mine[i] >= 0;
+			if (present[i])
+				rights[n++] = mine[i];
+		}
+		cmsg->cmsg_level = SOL_SOCKET;
+		cmsg->cmsg_type = SCM_RIGHTS;
+		cmsg->cmsg_len = CMSG_LEN(sizeof(int) * n);
+		msg.msg_controllen = n ? CMSG_SPACE(sizeof(int) * n) : 0;
+		if (!n)
+			msg.msg_control = NULL;
+		_exit(sendmsg(sk[1], &msg, 0) != sizeof(present));
+	}
+
+	close(sk[1]);
+	msg.msg_controllen = sizeof(cbuf);
+	if (recvmsg(sk[0], &msg, 0) != sizeof(present) ||
+	    waitpid(child, &status, 0) != child || status)
+		return -1;
+	cmsg = CMSG_FIRSTHDR(&msg);
+	rights = cmsg ? (int *)CMSG_DATA(cmsg) : NULL;
+	for (i = 0; i < NR_PROBES; i++)
+		fds[i] = present[i] && rights ? rights[n++] : -1;
+	close(sk[0]);
+	return 0;
+}
+
+static enum result probe(enum probe p, int fd)
+{
+	char buf[4096], name[16];
+	struct stat st;
+	ssize_t ret;
+
+	if (fd < 0)
+		return MISSING;
+
+	switch (p) {
+	case PROBE_FD_LOOKUP:
+		snprintf(name, sizeof(name), "%d", TARGET_FD);
+		ret = fstatat(fd, name, &st, AT_SYMLINK_NOFOLLOW);
+		break;
+	case PROBE_FDINFO:
+	case PROBE_KSM:
+		ret = read(fd, buf, sizeof(buf));
+		break;
+	case PROBE_FD_DIR:
+	case PROBE_FDINFO_DIR:
+		/* The dots may come before the error. */
+		while ((ret = syscall(SYS_getdents64, fd, buf, sizeof(buf))) > 0)
+			;
+		break;
+	default:
+		return FAILED;
+	}
+	return result_of(ret);
+}
+
+/* The fd/ lookup goes first, nothing may look fd/ up by name before it. */
+static void probe_after_exec(struct target *t, int fds[NR_PROBES],
+			     enum result res[NR_PROBES])
+{
+	int i;
+
+	if (exec_target(t)) {
+		for (i = 0; i < NR_PROBES; i++)
+			res[i] = FAILED;
+		return;
+	}
+	for (i = 0; i < NR_PROBES; i++)
+		res[i] = i == PROBE_KSM_SELF ? t->ksm_self : probe(i, fds[i]);
+}
+
+/*
+ * Open the probes as TEST_UID or as root, let the target execute @bin and use
+ * them as TEST_UID or as root.
+ */
+static int run(const char *bin, unsigned int flags, enum result res[NR_PROBES])
+{
+	int fds[NR_PROBES], i, ret = -1, status, pipefd[2];
+	struct target t;
+	pid_t child;
+
+	if (start_target(&t, bin))
+		return -1;
+
+	if (flags & OPEN_AS_ROOT)
+		open_probes(t.pid, fds);
+	else if (open_probes_unprivileged(t.pid, fds))
+		goto out;
+
+	if (flags & READ_AS_ROOT) {
+		probe_after_exec(&t, fds, res);
+		ret = 0;
+		goto out_close;
+	}
+
+	if (pipe2(pipefd, O_CLOEXEC))
+		goto out_close;
+	child = fork();
+	if (!child) {
+		if (drop_privileges())
+			_exit(1);
+		probe_after_exec(&t, fds, res);
+		_exit(write(pipefd[1], res, RES_SIZE) != RES_SIZE);
+	}
+	close(pipefd[1]);
+	if (child > 0) {
+		bool got = read(pipefd[0], res, RES_SIZE) == RES_SIZE;
+
+		if (waitpid(child, &status, 0) == child && !status && got)
+			ret = 0;
+	}
+	close(pipefd[0]);
+out_close:
+	for (i = 0; i < NR_PROBES; i++)
+		if (fds[i] >= 0)
+			close(fds[i]);
+out:
+	stop_target(&t);
+	return ret;
+}
+
+FIXTURE(setuid_exec) {};
+
+FIXTURE_SETUP(setuid_exec)
+{
+	if (geteuid())
+		SKIP(return, "must run as root");
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+	/* BIN_DIR may well be nosuid. */
+	ASSERT_EQ(mount("tmpfs", BIN_DIR, "tmpfs", 0, "mode=0755"), 0);
+	ASSERT_EQ(copy_self(SUID_BIN, 04755), 0);
+	ASSERT_EQ(copy_self(PLAIN_BIN, 0755), 0);
+}
+
+FIXTURE_TEARDOWN(setuid_exec)
+{
+}
+
+/* KSM may not be built in. */
+#define EXPECT_PROBE(res, p, want)					\
+	do {								\
+		if (((p) == PROBE_KSM || (p) == PROBE_KSM_SELF) &&	\
+		    (res)[p] == MISSING)				\
+			break;						\
+		EXPECT_EQ((res)[p], want) {				\
+			TH_LOG("%s", probe_name[p]);			\
+		}							\
+	} while (0)
+
+TEST_F(setuid_exec, unprivileged_opener)
+{
+	enum result res[NR_PROBES];
+	int i;
+
+	ASSERT_EQ(run(SUID_BIN, 0, res), 0);
+	for (i = 0; i < NR_PROBES; i++)
+		EXPECT_PROBE(res, i, DENIED);
+}
+
+TEST_F(setuid_exec, privileged_reader)
+{
+	enum result res[NR_PROBES];
+	int i;
+
+	ASSERT_EQ(run(SUID_BIN, READ_AS_ROOT, res), 0);
+	/* Root may look up fd/ itself. */
+	for (i = PROBE_FDINFO; i < NR_PROBES; i++)
+		EXPECT_PROBE(res, i, DENIED);
+}
+
+TEST_F(setuid_exec, privileged_opener)
+{
+	enum result res[NR_PROBES];
+	int i;
+
+	ASSERT_EQ(run(SUID_BIN, OPEN_AS_ROOT, res), 0);
+	/* Lookups go by the caller, SELF_KSM_FD was opened by the target. */
+	EXPECT_PROBE(res, PROBE_FD_LOOKUP, DENIED);
+	EXPECT_PROBE(res, PROBE_KSM_SELF, DENIED);
+	for (i = PROBE_FDINFO; i < PROBE_KSM_SELF; i++)
+		EXPECT_PROBE(res, i, WORKS);
+}
+
+TEST_F(setuid_exec, no_setuid)
+{
+	enum result res[NR_PROBES];
+	int i;
+
+	ASSERT_EQ(run(PLAIN_BIN, 0, res), 0);
+	for (i = 0; i < NR_PROBES; i++)
+		EXPECT_PROBE(res, i, WORKS);
+}
+
+struct getdents_args {
+	int fd;
+	char *buf;
+	size_t len;
+	ssize_t ret;
+};
+
+static void *getdents_thread(void *arg)
+{
+	struct getdents_args *g = arg;
+
+	g->ret = syscall(SYS_getdents64, g->fd, g->buf, g->len);
+	return NULL;
+}
+
+/*
+ * getdents() of fd/ sleeps in its first copy to userspace while the target
+ * executes the set-user-ID program. It must not go on to list the new
+ * program's descriptors.
+ */
+static int getdents_overtaken(struct target *t)
+{
+	struct uffdio_api api = { .api = UFFD_API };
+	struct uffdio_register reg = {};
+	struct uffdio_zeropage zero = {};
+	long psz = sysconf(_SC_PAGESIZE);
+	struct getdents_args g = {};
+	struct linux_dirent64 *d;
+	struct uffd_msg msg;
+	struct pollfd pfd;
+	char path[64], new_fd[16];
+	pthread_t thread;
+	int uffd;
+
+	/* Created with privileges, it catches the kernel's faults. */
+	uffd = syscall(SYS_userfaultfd, O_CLOEXEC);
+	if (uffd < 0)
+		return KSFT_SKIP;
+	g.buf = mmap(NULL, psz, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (g.buf == MAP_FAILED)
+		return KSFT_FAIL;
+	reg.range.start = (unsigned long)g.buf;
+	reg.range.len = psz;
+	reg.mode = UFFDIO_REGISTER_MODE_MISSING;
+	if (ioctl(uffd, UFFDIO_API, &api) || ioctl(uffd, UFFDIO_REGISTER, &reg))
+		return KSFT_FAIL;
+
+	if (drop_privileges())
+		return KSFT_FAIL;
+	snprintf(path, sizeof(path), "/proc/%d/fd", t->pid);
+	g.fd = open(path, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	g.len = psz;
+	if (g.fd < 0 || pthread_create(&thread, NULL, getdents_thread, &g))
+		return KSFT_FAIL;
+
+	pfd = (struct pollfd){ .fd = uffd, .events = POLLIN };
+	if (poll(&pfd, 1, -1) != 1 || read(uffd, &msg, sizeof(msg)) != sizeof(msg))
+		return KSFT_FAIL;
+	if (exec_target(t))
+		return KSFT_FAIL;
+	zero.range = reg.range;
+	if (ioctl(uffd, UFFDIO_ZEROPAGE, &zero) || pthread_join(thread, NULL))
+		return KSFT_FAIL;
+
+	snprintf(new_fd, sizeof(new_fd), "%d", NEW_FD);
+	for (long off = 0; off < g.ret; off += d->d_reclen) {
+		d = (struct linux_dirent64 *)(g.buf + off);
+		if (!strcmp(d->d_name, new_fd))
+			return LISTED_NEW_FD;
+	}
+	return KSFT_PASS;
+}
+
+TEST_F(setuid_exec, getdents_overtaken)
+{
+	struct target t;
+	int status;
+	pid_t child;
+
+	ASSERT_EQ(start_target(&t, SUID_BIN), 0);
+	child = fork();
+	ASSERT_GE(child, 0);
+	if (!child)
+		_exit(getdents_overtaken(&t));
+	ASSERT_EQ(waitpid(child, &status, 0), child);
+	stop_target(&t);
+	ASSERT_TRUE(WIFEXITED(status));
+	if (WEXITSTATUS(status) == KSFT_SKIP)
+		SKIP(return, "no userfaultfd");
+	ASSERT_NE(WEXITSTATUS(status), KSFT_FAIL);
+	EXPECT_EQ(WEXITSTATUS(status), KSFT_PASS) {
+		TH_LOG("getdents() listed a descriptor of the new program");
+	}
+}
+
+int main(int argc, char **argv)
+{
+	if (argc == 2 && !strcmp(argv[1], HELPER_ARG))
+		return helper();
+	return test_harness_run(argc, argv);
+}

-- 
2.53.0

