Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365491;
	b=tutDaB3YJaTsH5IOONgo+BQ5EuabvQJQu7x/lzv9DE3p5AuG0dK1msuqrE6rQ4I1MyEo
	 ypvYgArB1v/pDaW+bQ6M1MYNINhMlZ+bZDq8sLzNA8pPH9sjBzoOzGggqsAD9hRrVXLIv
	 VRpxhisaqK+qyXDxVWBgGOPnVdwTTyZ/y2b15KtSsXAYrSggJ/3oF97hSgqtG/cj7vqI8
	 YqZH9lUOOS01lYB8+bmde1+Og7HxcJZGQMXm5Z3RLQ4TSQGc/uoo6kifIdRDyrRO95UOu
	 AnNtPK0hP/rcVZFICIozFmyaS8bcRpMf+wHM6s+g4BZhocMhHR75RpFpocAlfbatAWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365491;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hLSoF/jSVLnP5RZ4FnsMXDqk3Ur2yT2WiqJo5ImIUCM=;
	b=oYQ2N5YfV9tl47FVdkk4nDu8sNa2aHI0LW9UfDLqjSu0CPzRaDCaRB73VjW/z26jX19U
	 dAll9VRPG11MGet17piDC3aaf02m08DiOyoP19DTH+GQFQczihJ9EurxZDtgy5tM81fh7
	 YpOIvHjxU9V9tUvhnDuawRz/kcJEsrT4HMeJjKZ9vScGfx0BscnKrSvy01YToB/wfyI+r
	 W2IJBXt3uhmmw3+fYiHFi895mQrBm22rRLvXThCB38uecOJR14cJm1ZL5rBBPEljlqjbG
	 4j9vFifxfYqyXdkrz/ST1LAihEgL1Z6zxqIM/jof1+Db1kN5/STYZ+O/YeFzLmx9hzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BdvvUATQ;
	arc=none smtp.remote-ip=91.218.175.111
Received: from mta0.migadu.com (out-111.mta0.migadu.com [91.218.175.111])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA830606A321
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 13:04:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA830606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BdvvUATQ
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=w4liDf6luR4Gg/CY/9UI5s7gxko/Ht+YqOSQM1/d6c0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793365489; v=1; x=1793970289;
 b=BdvvUATQNEZXU+zgax9FidAtLXHBg5zEwb9+8BJ2vel3hmCqJl/sylz6iwWJXsK4RHXeHUIc
 XVU+KP9AjBBJ69emnXmHxiqTdEnoYJ6+RFlHjDXLOvi6rD4gYAXszaUMO0Fixm9VWe/gj1GX1Yp
 xX7BJCzqavHkFgZPf9II38kc=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b2b57f7cf25638ec;
	Fri, 30 Oct 2026 13:04:49 +0000
X-Mizu-Trace-ID: b2b57f7cf25638ec
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tycho Andersen <tycho@tycho.pizza>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Andrei Vagin <avagin@gmail.com>,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 2/2] selftests/namespaces: test nsfs pid-translation access gate
Date: Fri, 30 Oct 2026 21:04:22 +0800
Message-ID: <20261030130422.738277-3-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030130422.738277-1-cui.tao@linux.dev>
References: <20261030130422.738277-1-cui.tao@linux.dev>
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

From: Tao Cui <cuitao@kylinos.cn>

Add a selftest for the nsfs pid translation ioctls: a privileged
holder of a pidns fd must still be able to translate, an
unprivileged receiver of the fd must get -EACCES on all four ioctls
in both translation directions, and same-task translation must keep
working.

Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/testing/selftests/namespaces/.gitignore |   1 +
 tools/testing/selftests/namespaces/Makefile   |   1 +
 .../namespaces/nsfs_pid_translation_test.c    | 399 ++++++++++++++++++
 3 files changed, 401 insertions(+)
 create mode 100644 tools/testing/selftests/namespaces/nsfs_pid_translation_test.c

diff --git a/tools/testing/selftests/namespaces/.gitignore b/tools/testing/selftests/namespaces/.gitignore
index 995b082357fa..5c522d2f06a6 100644
--- a/tools/testing/selftests/namespaces/.gitignore
+++ b/tools/testing/selftests/namespaces/.gitignore
@@ -11,3 +11,4 @@ stress_test
 listns_pagination_bug
 regression_pidfd_setns_test
 uid_map_range_test
+nsfs_pid_translation_test
diff --git a/tools/testing/selftests/namespaces/Makefile b/tools/testing/selftests/namespaces/Makefile
index 9b22d12708e1..8333aa694ad6 100644
--- a/tools/testing/selftests/namespaces/Makefile
+++ b/tools/testing/selftests/namespaces/Makefile
@@ -3,6 +3,7 @@ CFLAGS += -Wall -O0 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS += -lcap
 
 TEST_GEN_PROGS := nsid_test \
+		  nsfs_pid_translation_test \
 		  file_handle_test \
 		  init_ino_test \
 		  ns_active_ref_test \
diff --git a/tools/testing/selftests/namespaces/nsfs_pid_translation_test.c b/tools/testing/selftests/namespaces/nsfs_pid_translation_test.c
new file mode 100644
index 000000000000..e3a19318be5c
--- /dev/null
+++ b/tools/testing/selftests/namespaces/nsfs_pid_translation_test.c
@@ -0,0 +1,399 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test that the nsfs pid translation ioctls enforce ptrace read
+ * access on the task whose pid they translate: a "container" task
+ * tree in a new pid namespace passes its pidns fd over SCM_RIGHTS to
+ * an unprivileged attacker, who must not be able to use it as a pid
+ * oracle, while a privileged holder of the same fd still can.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/prctl.h>
+#include <unistd.h>
+#include <linux/nsfs.h>
+#include <sys/ioctl.h>
+#include <sys/socket.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "../kselftest.h"
+
+/* fall back when the build host's uapi headers predate the ioctls */
+#ifndef NS_GET_PID_FROM_PIDNS
+#define NS_GET_PID_FROM_PIDNS	_IOR(NSIO, 0x6, int)
+#endif
+#ifndef NS_GET_TGID_FROM_PIDNS
+#define NS_GET_TGID_FROM_PIDNS	_IOR(NSIO, 0x7, int)
+#endif
+#ifndef NS_GET_PID_IN_PIDNS
+#define NS_GET_PID_IN_PIDNS	_IOR(NSIO, 0x8, int)
+#endif
+#ifndef NS_GET_TGID_IN_PIDNS
+#define NS_GET_TGID_IN_PIDNS	_IOR(NSIO, 0x9, int)
+#endif
+
+#define ATTACKER_UID	65534
+#define PROBE_PIDS	8
+
+#define ATTACK_PASS	0
+#define ATTACK_LEAK	1	/* ioctl succeeded for an unseen task */
+#define ATTACK_ERRNO	2	/* rejected but errno != EACCES */
+#define ATTACK_SETUP	3	/* could not drop privileges */
+
+/* container-side setup exit codes, reported through the container fork */
+#define CONT_EXIT_UNSHARE	10
+#define CONT_EXIT_FORK		11
+#define CONT_EXIT_HANDSHAKE	12
+
+/* watchdog: a hang kills the test instead of blocking kselftest */
+#define TEST_TIMEOUT	60
+
+static void send_fd(int sock, int fd, int payload)
+{
+	struct msghdr msg = {};
+	struct iovec iov = { &payload, sizeof(payload) };
+	union {
+		struct cmsghdr cm;
+		char buf[CMSG_SPACE(sizeof(int))];
+	} u;
+	struct cmsghdr *cm;
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = u.buf;
+	msg.msg_controllen = sizeof(u.buf);
+	cm = CMSG_FIRSTHDR(&msg);
+	cm->cmsg_level = SOL_SOCKET;
+	cm->cmsg_type = SCM_RIGHTS;
+	cm->cmsg_len = CMSG_LEN(sizeof(fd));
+	memcpy(CMSG_DATA(cm), &fd, sizeof(fd));
+	if (sendmsg(sock, &msg, 0) < 0)
+		perror("sendmsg");
+}
+
+static int recv_fd(int sock, int *payload)
+{
+	int fd = -1;
+	struct msghdr msg = {};
+	struct iovec iov = { payload, sizeof(*payload) };
+	union {
+		struct cmsghdr cm;
+		char buf[CMSG_SPACE(sizeof(int))];
+	} u;
+	struct cmsghdr *cm;
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = u.buf;
+	msg.msg_controllen = sizeof(u.buf);
+	if (recvmsg(sock, &msg, 0) < 0)
+		return -1;
+	cm = CMSG_FIRSTHDR(&msg);
+	if (!cm)
+		return -1;
+	memcpy(&fd, CMSG_DATA(cm), sizeof(fd));
+	return fd;
+}
+
+/*
+ * Child: drop all privileges, receive the container pidns fd and try
+ * to use it as a translation oracle for container pids 1..PROBE_PIDS
+ * and, in the reverse direction, our own pid and the container init's
+ * initial-namespace pid.  EPERM is tolerated defensively alongside
+ * EACCES.
+ */
+static int attacker(int sock)
+{
+	int fd;
+	int i;
+	int leaked = 0;
+	int bad_errno = 0;
+	int init_host_pid;
+	long ret;
+
+	if (setresgid(ATTACKER_UID, ATTACKER_UID, ATTACKER_UID) ||
+	    setresuid(ATTACKER_UID, ATTACKER_UID, ATTACKER_UID))
+		return ATTACK_SETUP;
+
+	fd = recv_fd(sock, &init_host_pid);
+	if (fd < 0)
+		return ATTACK_SETUP;
+
+	for (i = 1; i <= PROBE_PIDS; i++) {
+		ret = ioctl(fd, NS_GET_PID_FROM_PIDNS, i);
+		if (ret >= 1)
+			leaked++;
+		else if (ret < 0 && errno != EACCES && errno != EPERM &&
+			 errno != ESRCH)
+			bad_errno++;
+
+		ret = ioctl(fd, NS_GET_TGID_FROM_PIDNS, i);
+		if (ret >= 1)
+			leaked++;
+		else if (ret < 0 && errno != EACCES && errno != EPERM &&
+			 errno != ESRCH)
+			bad_errno++;
+	}
+
+	/* reverse probe 1: translating ourselves - any result is a leak */
+	ret = ioctl(fd, NS_GET_PID_IN_PIDNS, getpid());
+	if (ret >= 1)
+		leaked++;
+	else if (ret < 0 && errno != EACCES && errno != EPERM && errno != ESRCH)
+		bad_errno++;
+
+	ret = ioctl(fd, NS_GET_TGID_IN_PIDNS, getpid());
+	if (ret >= 1)
+		leaked++;
+	else if (ret < 0 && errno != EACCES && errno != EPERM && errno != ESRCH)
+		bad_errno++;
+
+	/* reverse probe 2: the container init addressed by its
+	 * initial-namespace pid - a gate pasted into only one branch still
+	 * translates here and must be caught as a leak
+	 */
+	ret = ioctl(fd, NS_GET_PID_IN_PIDNS, init_host_pid);
+	if (ret >= 1)
+		leaked++;
+	else if (ret < 0 && errno != EACCES && errno != EPERM && errno != ESRCH)
+		bad_errno++;
+
+	ret = ioctl(fd, NS_GET_TGID_IN_PIDNS, init_host_pid);
+	if (ret >= 1)
+		leaked++;
+	else if (ret < 0 && errno != EACCES && errno != EPERM && errno != ESRCH)
+		bad_errno++;
+
+	close(fd);
+
+	if (leaked)
+		return ATTACK_LEAK;
+	if (bad_errno)
+		return ATTACK_ERRNO;
+	return ATTACK_PASS;
+}
+
+int main(void)
+{
+	int syncsock[2];
+	int sk[2];
+	int nsfd = -1;
+	int st;
+	pid_t cont = -1;
+	pid_t att;
+	char path[64];
+	const char *bail_msg = NULL;
+
+	ksft_print_header();
+	ksft_set_plan(4);
+
+	if (geteuid())
+		ksft_exit_skip("test requires root, run with -C or as root\n");
+
+	alarm(TEST_TIMEOUT);
+
+	if (socketpair(AF_UNIX, SOCK_STREAM, 0, syncsock)) {
+		ksft_print_msg("socketpair(sync) failed: %s\n",
+			       strerror(errno));
+		bail_msg = "socketpair(sync) failed";
+		goto out;
+	}
+
+	/* "container": task tree in a new pidns; stays alive */
+	cont = fork();
+	if (cont < 0) {
+		ksft_print_msg("fork(container) failed: %s\n",
+			       strerror(errno));
+		bail_msg = "fork(container) failed";
+		goto out;
+	}
+	if (cont == 0) {
+		pid_t inner;
+
+		/* die with the test: no orphaned pause() children */
+		prctl(PR_SET_PDEATHSIG, SIGKILL);
+
+		close(syncsock[0]);
+		if (unshare(CLONE_NEWPID)) {
+			perror("unshare(CLONE_NEWPID)");
+			_exit(CONT_EXIT_UNSHARE);
+		}
+		inner = fork();		/* container init */
+		if (inner < 0)
+			_exit(CONT_EXIT_FORK);
+		if (inner == 0) {
+			int j;
+
+			prctl(PR_SET_PDEATHSIG, SIGKILL);
+			/* two more tasks so the 1..8 probe range
+			 * covers several live tasks plus free slots
+			 */
+			for (j = 0; j < 2; j++) {
+				pid_t sub = fork();
+
+				if (sub < 0)
+					break;
+				if (sub == 0) {
+					prctl(PR_SET_PDEATHSIG, SIGKILL);
+					pause();
+				}
+			}
+			pause();
+		}
+		{
+			/* initial-namespace pid of the container init,
+			 * sent as a native pid_t
+			 */
+			if (write(syncsock[1], &inner, sizeof(inner)) !=
+			    (ssize_t)sizeof(inner))
+				_exit(CONT_EXIT_HANDSHAKE);
+		}
+		pause();
+		_exit(0);
+	}
+	close(syncsock[1]);
+	{
+		if (read(syncsock[0], &cont, sizeof(cont)) != (ssize_t)sizeof(cont)) {
+			/* a rejected unshare(CLONE_NEWPID) (no
+			 * CAP_SYS_ADMIN, common in CI) is an environment
+			 * limitation, not a test failure
+			 */
+			int cst;
+
+			kill(cont, SIGKILL);
+			waitpid(cont, &cst, 0);
+			if (WIFEXITED(cst) &&
+			    WEXITSTATUS(cst) == CONT_EXIT_UNSHARE)
+				ksft_exit_skip("unshare(CLONE_NEWPID) not permitted\n");
+			ksft_print_msg("container setup failed: exit %d\n",
+				       WIFEXITED(cst) ? WEXITSTATUS(cst) : -1);
+			bail_msg = "container setup failed";
+			goto out;
+		}
+	}
+	close(syncsock[0]);
+
+	/* cont is the container init: its /proc/<pid>/ns/pid is the
+	 * container pidns (the unshare() caller stays in the parent ns)
+	 */
+	snprintf(path, sizeof(path), "/proc/%d/ns/pid", cont);
+	nsfd = open(path, O_RDONLY);
+	if (nsfd < 0) {
+		ksft_print_msg("open(%s) failed: %s\n", path, strerror(errno));
+		bail_msg = "open(container pidns) failed";
+		goto out;
+	}
+
+	/* 1. privileged holder of the fd can still translate pid 1 */
+	{
+		long ret = ioctl(nsfd, NS_GET_PID_FROM_PIDNS, 1);
+		long tgid = ioctl(nsfd, NS_GET_TGID_FROM_PIDNS, 1);
+
+		if (ret >= 1 && tgid >= 1)
+			ksft_test_result_pass("root translation of container init\n");
+		else
+			ksft_test_result_fail("root translation of init failed: %ld %ld %d\n",
+					      ret, tgid, errno);
+	}
+
+	/* 2. unprivileged receiver of the fd is denied everywhere */
+	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sk)) {
+		ksft_print_msg("socketpair(attacker) failed: %s\n",
+			       strerror(errno));
+		bail_msg = "socketpair(attacker) failed";
+		goto out;
+	}
+
+	att = fork();
+	if (att < 0) {
+		ksft_print_msg("fork(attacker) failed: %s\n",
+			       strerror(errno));
+		bail_msg = "fork(attacker) failed";
+		goto out;
+	}
+	if (att == 0) {
+		int rc;
+
+		close(sk[0]);
+		close(nsfd);
+		rc = attacker(sk[1]);
+		close(sk[1]);
+		_exit(rc);
+	}
+	close(sk[1]);
+	/* cont = container init's host pid, passed for the IN_PIDNS
+	 * probes on a task the attacker must not see
+	 */
+	send_fd(sk[0], nsfd, cont);
+	close(sk[0]);
+	waitpid(att, &st, 0);
+
+	switch (WIFEXITED(st) ? WEXITSTATUS(st) : -1) {
+	case ATTACK_PASS:
+		ksft_test_result_pass("unprivileged translation denied with EACCES\n");
+		break;
+	case ATTACK_LEAK:
+		ksft_test_result_fail("unprivileged translation succeeded (info leak)\n");
+		break;
+	case ATTACK_ERRNO:
+		ksft_test_result_fail("translation denied with unexpected errno\n");
+		break;
+	case ATTACK_SETUP:
+	default:
+		ksft_test_result_skip("attacker setup failed (no uid %d?)\n",
+				      ATTACKER_UID);
+		break;
+	}
+
+	/* root-side re-check: rules out a false "denied" PASS when the
+	 * container init died early during the attacker run
+	 */
+	{
+		long ret = ioctl(nsfd, NS_GET_PID_FROM_PIDNS, 1);
+
+		if (ret >= 1)
+			ksft_test_result_pass("container init alive after attacker run\n");
+		else
+			ksft_test_result_fail("container init gone: %ld %d\n",
+					      ret, errno);
+	}
+
+	close(nsfd);
+	nsfd = -1;
+	kill(cont, SIGKILL);
+	waitpid(cont, &st, 0);
+
+	/* 4. same-task query still works after the gate (sanity) */
+	{
+		int self_ns = open("/proc/self/ns/pid", O_RDONLY);
+		long ret;
+
+		if (self_ns < 0) {
+			ksft_test_result_skip("open(/proc/self/ns/pid) failed\n");
+		} else {
+			ret = ioctl(self_ns, NS_GET_PID_FROM_PIDNS, getpid());
+			if (ret == getpid())
+				ksft_test_result_pass("self translation still allowed\n");
+			else
+				ksft_test_result_fail("self translation: ret=%ld errno=%d (%s)\n",
+						      ret, errno, strerror(errno));
+			close(self_ns);
+		}
+	}
+
+	ksft_finished();
+	return 0;
+
+out:
+	if (nsfd >= 0)
+		close(nsfd);
+	if (cont > 0)
+		kill(cont, SIGKILL);
+	ksft_exit_fail_msg("%s\n", bail_msg ? bail_msg : "unexpected failure");
+}
-- 
2.43.0

