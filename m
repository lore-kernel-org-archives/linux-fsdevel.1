Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F3B52D2C4;
	Wed,  9 Sep 2026 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950608; cv=none; b=Qd2fi5+vUAVMEPkurQx+jRFqB0URNM08PPeo48riVlghD0jn0UTypvEJl9/e2QRm3Nt/S71ZHmugx7h5KA5fngBgI1cMrTAFqn8E1hvQujcRPtcCEnMndt+Nk6JpnIHUteyIFjU982UbuHUsKVgtyy/Xw6glWEBXHiIGa5tpz0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950608; c=relaxed/simple;
	bh=2YnxsfrAF7HQBfWzTLMa2O/I/q1GmiD7jT9cB0DlWWk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AvTu9Ov/xgamCuHd8sSa9n2XgYwWiOiVjwcze4UM/Sr8z0mdVTBjCmnfxK4kR/XLjMMgIS1ypzxTmK9UQTcHRW2lniiE/kK9C6/OkEKIVYw1quetbJMJ8POYAWYGjE383PLwYXsL9ps5KyKHCdzQt9gJaZS9eXohyfKG5LU3GNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLpzQOge; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLpzQOge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AE81F00A3D;
	Wed,  9 Sep 2026 10:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950607;
	bh=2QGYk5eR/9VO1k3tAFlZXnTVM66BZOkvZZisq9g5IQA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=oLpzQOgefLCEmc5Kzk35bB4HXYq9vemi5qlqr8+SBZaXZb3YDpYbNNbHtj2qVYuLy
	 6amkiQnF2NyBOZWoaTXH+yXEXykGYZL5VhFNm5HJF4l1LH2R6JOnT5yzXYiUxYiBB0
	 HORQi7yWzu5BNZHz/2l1/Fm63vXtMkCtHupkA6MBosQGWocfdq0lQVvNgTEHy5uN5Q
	 t+4E+vXL7XCzdXl/8uLdbuebVzCSdn26n/DR6QwC2eZiv/InkaYacMwu2Ii4hbqqTt
	 NDS+zKpqa3psoktkoZvjNz2N+oarQPO7IaqVWXBOMDIQB1Id2m3sx/PrwGjB++J/Op
	 MVkZt8YS6sIlQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 09 Sep 2026 12:43:03 +0200
Subject: [PATCH v2 04/10] selftests/net: SO_PASSPIDFD_THREAD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-work-unix-passpidfd-v2-4-7bd342abb2d1@kernel.org>
References: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
In-Reply-To: <20260909-work-unix-passpidfd-v2-0-7bd342abb2d1@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7771; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2YnxsfrAF7HQBfWzTLMa2O/I/q1GmiD7jT9cB0DlWWk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQttLA+v/XnxLD2SOmre1jOmN45Zn9u47zszPt9LxkyV
 h+X2/n3UkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEjq5m+B9kbOR0ILvSVJjh
 11f/rdqieteV9poJv9qkzH6DMdxryipGhoX656cd+mrOdWoJq9dqgabtVvfTJZUqCkscNCpfvFr
 +mAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Extend the af_unix scm_pidfd selftest with SO_PASSPIDFD_THREAD tests.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/net/af_unix/Makefile    |   2 +
 tools/testing/selftests/net/af_unix/scm_pidfd.c | 269 ++++++++++++++++++++++++
 2 files changed, 271 insertions(+)

diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index a66f10fb0c23..45b841758f1b 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -23,6 +23,8 @@ TEST_GEN_FILES := scm_rights_denial_lsm.bpf.o
 include ../../lib.mk
 include ../bpf.mk
 
+$(OUTPUT)/scm_pidfd: CFLAGS += -pthread
+
 $(OUTPUT)/scm_rights_denial_lsm: $(BPFOBJ)
 $(OUTPUT)/scm_rights_denial_lsm: CFLAGS += -I$(SCRATCH_DIR)/include
 $(OUTPUT)/scm_rights_denial_lsm: LDLIBS += -lelf -lz
diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testing/selftests/net/af_unix/scm_pidfd.c
index 2c18b92a2603..019c48e1cdcd 100644
--- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
+++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
@@ -10,6 +10,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <errno.h>
+#include <pthread.h>
 #include <sys/un.h>
 #include <sys/signal.h>
 #include <sys/types.h>
@@ -27,6 +28,10 @@
 #define SCM_PIDFD 0x04
 #endif
 
+#ifndef SO_PASSPIDFD_THREAD
+#define SO_PASSPIDFD_THREAD 86
+#endif
+
 #define CHILD_EXIT_CODE_OK 123
 
 static void child_die()
@@ -553,4 +558,268 @@ TEST_F(scm_pidfd, test)
 	close(pfd);
 }
 
+struct thread_ids {
+	pid_t pid;
+	pid_t tid;
+};
+
+static void *send_ids_thread(void *arg)
+{
+	int fd = *(int *)arg;
+	struct thread_ids ids = {
+		.pid = getpid(),
+		.tid = gettid(),
+	};
+	char sync;
+
+	if (send(fd, &ids, sizeof(ids), 0) != sizeof(ids))
+		return (void *)1;
+
+	/* stay alive until the receiver has looked at our pidfd */
+	if (read(fd, &sync, 1) != 1)
+		return (void *)1;
+
+	return NULL;
+}
+
+static void *send_ids_creds_thread(void *arg)
+{
+	int fd = *(int *)arg;
+	struct thread_ids ids = {
+		.pid = getpid(),
+		.tid = gettid(),
+	};
+	struct ucred ucred = {
+		.pid = getpid(),
+		.uid = getuid(),
+		.gid = getgid(),
+	};
+	char control[CMSG_SPACE(sizeof(ucred))] = { 0 };
+	struct iovec iov;
+	struct msghdr msg = { 0 };
+	struct cmsghdr *cmsg;
+	char sync;
+
+	iov.iov_base = &ids;
+	iov.iov_len = sizeof(ids);
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = control;
+	msg.msg_controllen = sizeof(control);
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_CREDENTIALS;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(ucred));
+	memcpy(CMSG_DATA(cmsg), &ucred, sizeof(ucred));
+
+	if (sendmsg(fd, &msg, 0) != sizeof(ids))
+		return (void *)1;
+
+	if (read(fd, &sync, 1) != 1)
+		return (void *)1;
+
+	return NULL;
+}
+
+static void thread_client(int fd, int syncfd, void *(*sender)(void *))
+{
+	pthread_t thread;
+	void *ret;
+	char sync;
+
+	/* wait until the receiver enabled SO_PASSPIDFD */
+	if (read(syncfd, &sync, 1) != 1)
+		child_die();
+
+	if (pthread_create(&thread, NULL, sender, &fd))
+		child_die();
+
+	if (pthread_join(thread, &ret) || ret)
+		child_die();
+
+	exit(0);
+}
+
+static int recv_pidfd(int fd, struct thread_ids *ids)
+{
+	char control[CMSG_SPACE(sizeof(int))] = { 0 };
+	struct iovec iov;
+	struct msghdr msg = { 0 };
+	struct cmsghdr *cmsg;
+	int pidfd = -1;
+
+	iov.iov_base = ids;
+	iov.iov_len = sizeof(*ids);
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = control;
+	msg.msg_controllen = sizeof(control);
+
+	if (recvmsg(fd, &msg, 0) != sizeof(*ids)) {
+		log_err("recvmsg");
+		return -1;
+	}
+
+	if (msg.msg_flags & (MSG_TRUNC | MSG_CTRUNC)) {
+		log_err("recvmsg: truncated");
+		return -1;
+	}
+
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL;
+	     cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		if (cmsg->cmsg_level == SOL_SOCKET &&
+		    cmsg->cmsg_type == SCM_PIDFD)
+			memcpy(&pidfd, CMSG_DATA(cmsg), sizeof(pidfd));
+	}
+
+	return pidfd;
+}
+
+static int thread_pidfd_flow(void *(*sender)(void *), int optname,
+			     struct thread_ids *ids, struct pidfd_info *info)
+{
+	int sk[2];
+	int syncpipe[2];
+	int pidfd;
+	int child_status = 0;
+	pid_t child;
+
+	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sk))
+		return -1;
+
+	if (pipe(syncpipe))
+		return -1;
+
+	child = fork();
+	if (child < 0)
+		return -1;
+
+	if (child == 0) {
+		close(sk[0]);
+		close(syncpipe[1]);
+		thread_client(sk[1], syncpipe[0], sender);
+	}
+	close(sk[1]);
+	close(syncpipe[0]);
+
+	int on = 1;
+
+	if (setsockopt(sk[0], SOL_SOCKET, optname, &on, sizeof(on))) {
+		log_err("Failed to set pidfd passing option");
+		return -1;
+	}
+
+	if (write(syncpipe[1], "1", 1) != 1)
+		return -1;
+	close(syncpipe[1]);
+
+	pidfd = recv_pidfd(sk[0], ids);
+	if (pidfd < 0)
+		return -1;
+
+	info->mask = PIDFD_INFO_PID;
+	if (ioctl(pidfd, PIDFD_GET_INFO, info)) {
+		log_err("ioctl(PIDFD_GET_INFO)");
+		close(pidfd);
+		return -1;
+	}
+	close(pidfd);
+
+	/* release the sending thread */
+	if (write(sk[0], "x", 1) != 1)
+		return -1;
+	close(sk[0]);
+
+	waitpid(child, &child_status, 0);
+	if (!WIFEXITED(child_status) || WEXITSTATUS(child_status))
+		return -1;
+
+	return 0;
+}
+
+static int sockopt_set(int fd, int optname, int val)
+{
+	return setsockopt(fd, SOL_SOCKET, optname, &val, sizeof(val));
+}
+
+static int sockopt_get(int fd, int optname)
+{
+	socklen_t len = sizeof(int);
+	int val = -1;
+
+	if (getsockopt(fd, SOL_SOCKET, optname, &val, &len))
+		return -1;
+
+	return val;
+}
+
+TEST(scm_pidfd_setsockopt_values)
+{
+	int sk[2];
+
+	ASSERT_EQ(0, socketpair(AF_UNIX, SOCK_STREAM, 0, sk));
+
+	ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSPIDFD_THREAD, 1));
+	ASSERT_EQ(1, sockopt_get(sk[0], SO_PASSPIDFD_THREAD));
+	ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSPIDFD));
+
+	/* The option set last wins. */
+	ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSPIDFD, 1));
+	ASSERT_EQ(1, sockopt_get(sk[0], SO_PASSPIDFD));
+	ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSPIDFD_THREAD));
+
+	ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSPIDFD_THREAD, 1));
+	ASSERT_EQ(1, sockopt_get(sk[0], SO_PASSPIDFD_THREAD));
+	ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSPIDFD));
+
+	/* Disabling one option leaves the other alone. */
+	ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSPIDFD, 0));
+	ASSERT_EQ(1, sockopt_get(sk[0], SO_PASSPIDFD_THREAD));
+	ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSPIDFD_THREAD, 0));
+	ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSPIDFD));
+	ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSPIDFD_THREAD));
+
+	close(sk[0]);
+	close(sk[1]);
+}
+
+TEST(scm_pidfd_thread)
+{
+	struct thread_ids ids;
+	struct pidfd_info info;
+
+	ASSERT_EQ(0, thread_pidfd_flow(send_ids_thread, SO_PASSPIDFD_THREAD,
+				       &ids, &info));
+	ASSERT_NE(ids.pid, ids.tid);
+	EXPECT_EQ(ids.tid, info.pid);
+	EXPECT_EQ(ids.pid, info.tgid);
+}
+
+TEST(scm_pidfd_thread_group)
+{
+	struct thread_ids ids;
+	struct pidfd_info info;
+
+	ASSERT_EQ(0, thread_pidfd_flow(send_ids_thread, SO_PASSPIDFD,
+				       &ids, &info));
+	ASSERT_NE(ids.pid, ids.tid);
+	EXPECT_EQ(ids.pid, info.pid);
+	EXPECT_EQ(ids.pid, info.tgid);
+}
+
+TEST(scm_pidfd_thread_creds)
+{
+	struct thread_ids ids;
+	struct pidfd_info info;
+
+	ASSERT_EQ(0, thread_pidfd_flow(send_ids_creds_thread, SO_PASSPIDFD_THREAD,
+				       &ids, &info));
+	ASSERT_NE(ids.pid, ids.tid);
+	EXPECT_EQ(ids.tid, info.pid);
+	EXPECT_EQ(ids.pid, info.tgid);
+}
+
 TEST_HARNESS_MAIN

-- 
2.53.0

