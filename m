Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C014C2268
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212997; cv=none; b=dj+2fBx2VHfVcpTm0CorQTA22uRZW1h/3qE80w/i/a+qI+9okLXNeIrPLY6Yj4C0ExUjUvU82H5Anb78CQNBEPivjYRYnBa8vIdGQySF+LaCtC2kqvDFixxu7TZQa3STdLRU7Htf+USdLSnWVqk7qZfvuGr/PdWJHG35B6UaO3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212997; c=relaxed/simple;
	bh=7mSftb3K030ZtkrO+63JNw1TXJ8oEeQFD9OXz/Xqi8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ViEAhfsboNPPDpw1EQJOWqnNaGMQN0nND1+pGbPfHpfTTD2xOZ24XRCiazzhe0OM4JGv72Z8dax0qhb5ZtDwd9fAam3ev1Ux7718DLSn3uEM5lf6cfXSYhPXm4K6X9SNdVh5JbPN1PqE4vP1oI+dsfb3ygVBPWZBE7pppCBdh8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=FPtdbEVX; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="FPtdbEVX"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6774639a8a4so1654249d50.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791212992; x=1791817792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oVMXbuVLzRkHKwyCnYzPqseRsKhFA0Bvhk621b9R62c=;
        b=FPtdbEVXTtsFmqwWX7V7JT8RLaLHlHO5wt0H3OTZ+wAxpm0R13z69p7qlHgrA6ooS4
         C7Txu2PhDjxyoHQ17MV6nzBkP2vtfrYdrqm7mTgy/O6wG1QLg7Pj6SwaIOafXx8M5WE0
         Le8Sv7YfXcjTn33Q86keNOEMQVS7F2jHkJfrPQyJug3vt8ryIcS1H94CTmwqA9FVhn0a
         qhELE0NNIRLMyLQX1d/bgsXd/wVaXZcWocr0dZtW4EZjdrkqfnJ8IvWnsnGwEZJ2vVOa
         x7V7fTZRf+SnnIMgm/YKeBpzCd7GM/G+P3PsqW/k6aIF9K01jlwtythgyzxaOqvhmG9G
         rFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791212992; x=1791817792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oVMXbuVLzRkHKwyCnYzPqseRsKhFA0Bvhk621b9R62c=;
        b=TBhXs6mXIJ7Nt0s1H/3EJhc9ZdrxGbIslnSP0l4200RicEMxGYNE4Z/NOyvwc/+MD6
         cOMx+4VUSOd/E2fU6+yWTBtxyYLaDZ7vgZkLW81j1g2tcvd4ndtYFYWLEaljKoPPJyHc
         Il48olyKb+ASTaLbb7oX2Uvtb/uNSEBAQVFByCwo0l8u+/01IHYrIoj64ndmalMJseqs
         BQY6f93mIKGvIJgjRnhp4pXvUY4ikqtbZmGA752evbxIH+RpCUYTsSM1m65WJww2/jNr
         P5fGFOGhsJ+XiuR0wCljxtzVnfZRBSioBfGw+nAlw4cssIgS2uAm7qsySDGgx7yy2ZcG
         8piQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWUePs0zHxircjtQtZtT7VIdJYKbSF7XkNtJ1WCBWcOGwuxQWSScY3Yk40yZ7bevFDuWxzjUsz8LNHiPF1@vger.kernel.org
X-Gm-Message-State: AFq9FYLYGFMSEgQ6ZWswIfBH3qVOw4E6et96qoylxTV0w2olumXu+ono
	dh5Gvc2NnObEfvmq/NhosvgoOuE4hlJtthXLQ5fBMXLPF9do2nyyirY32tx3DmVu/d22
X-Gm-Gg: AYBFou0BTr0UOZaW51tu15hKgvLiMRuMi6tTDYFxCILfrUJaFZjTXmIsj1GCqM3+NF+
	+IhlH32hAXYB+MOAq6W47BaMtCZp0n4m3K7LfV/Q/UUO6HAjh51L8ZqYb4m+KftEHVL2L6WnwIN
	YzlPgdzgeKZQyNq+i14BBf30Cjrezjglk14wRyZLbwIVtd8Xnb+/8wVBQ00vj20Et5fZoUniyn8
	NJDv7D35mnPaB4xovR9Mjpec9s1MzqzkSxG3oihuzN3YgPnIDuz1q+kLro2GugP18/M2MTp1dbC
	hwQsAT0Hg0RSUocVKkWhxrxGTPFxU3QmKgI2cA5in58A1nQfO6T42vv4fi7y+UrMYa7f+cCvT3E
	zCi5RCW7WM3arosqhfXPGpXCYwfkJd41gOuAUV6ZRrC4NaPt91ymGI6WFHRxIp4Ew0YuOEzdIO9
	PsMSc+mvTvTnjyIU+gtK2Zk6XoIYO2HoY6WLWvfdvfz1QlYOnr4VKV/1O9eyOAI3IUe7KvblzZZ
	A1lSTPidV0eGtDcPHblBzT2zu5SCSXm/JoPGdRDeGtOu6afwhn1g7U=
X-Received: by 2002:a05:690c:84:b0:8ab:56b2:8101 with SMTP id 00721157ae682-8ae951f4577mr23758897b3.17.1791212991676;
        Mon, 05 Oct 2026 08:09:51 -0700 (PDT)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe81fdsm41210467b3.47.2026.10.05.08.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:09:51 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 05 Oct 2026 10:09:34 -0500
Subject: [PATCH v4 04/10] selftests/net: SO_PASSPIDFD_THREAD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-work-unix-passpidfd-v4-4-350183b6e02a@amutable.com>
References: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
In-Reply-To: <20261005-work-unix-passpidfd-v4-0-350183b6e02a@amutable.com>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, Eric Dumazet <edumazet@kernel.org>
X-Mailer: b4 0.14.3

From: Christian Brauner <brauner@kernel.org>

Extend the af_unix scm_pidfd selftest with SO_PASSPIDFD_THREAD tests.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Co-developed-by: Andrew Halaney <andrew@amutable.com>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
---
 tools/testing/selftests/net/af_unix/Makefile    |   2 +
 tools/testing/selftests/net/af_unix/scm_pidfd.c | 505 ++++++++++++++++++++++++
 2 files changed, 507 insertions(+)

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
index 2c18b92a2603..d73ae9d27a48 100644
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
@@ -27,6 +28,14 @@
 #define SCM_PIDFD 0x04
 #endif
 
+#ifndef SCM_PIDFD_THREAD
+#define SCM_PIDFD_THREAD 0x05
+#endif
+
+#ifndef SO_PASSPIDFD_THREAD
+#define SO_PASSPIDFD_THREAD 86
+#endif
+
 #define CHILD_EXIT_CODE_OK 123
 
 static void child_die()
@@ -553,4 +562,500 @@ TEST_F(scm_pidfd, test)
 	close(pfd);
 }
 
+struct thread_ids {
+	pid_t pid;
+	pid_t tid;
+};
+
+#define MAX_WRITERS 2
+
+/* Used by writers to signal they've written, so we can sequence multiple writers */
+static int seq_pipe[2];
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
+	/* let the client start the next writer, so the queue order is known */
+	if (write(seq_pipe[1], "1", 1) != 1)
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
+	/* signal we've written our info */
+	if (write(seq_pipe[1], "1", 1) != 1)
+		return (void *)1;
+
+	/* stay alive until the receiver has looked at our pidfd */
+	if (read(fd, &sync, 1) != 1)
+		return (void *)1;
+
+	return NULL;
+}
+
+/*
+ * Runs @nwriters copies of @sender, each in its own non-leader thread, one
+ * at a time so the queue order is known, then tells the parent on @ackfd
+ * that everything is queued.
+ */
+static void thread_client(int fd, int syncfd, int ackfd,
+			  void *(*sender)(void *), int nwriters)
+{
+	pthread_t writers[MAX_WRITERS];
+	void *ret;
+	char sync;
+	int i;
+
+	/* wait until the receiver enabled the options it wants */
+	if (read(syncfd, &sync, 1) != 1)
+		child_die();
+
+	for (i = 0; i < nwriters; i++) {
+		if (pthread_create(&writers[i], NULL, sender, &fd))
+			child_die();
+
+		if (read(seq_pipe[0], &sync, 1) != 1)
+			child_die();
+	}
+
+	if (write(ackfd, "1", 1) != 1)
+		child_die();
+
+	for (i = 0; i < nwriters; i++)
+		if (pthread_join(writers[i], &ret) || ret)
+			child_die();
+
+	exit(0);
+}
+
+struct pidfd_msg {
+	ssize_t len;
+	struct thread_ids ids;
+	struct pidfd_info tgid_info;
+	struct pidfd_info thread_info;
+	int tgid_flags;
+	int thread_flags;
+	bool have_tgid;
+	bool have_thread;
+};
+
+static int get_pidfd_info(int pidfd, struct pidfd_info *info)
+{
+	info->mask = PIDFD_INFO_PID;
+	if (ioctl(pidfd, PIDFD_GET_INFO, info)) {
+		log_err("ioctl(PIDFD_GET_INFO)");
+		return -1;
+	}
+
+	return 0;
+}
+
+/* One recvmsg(), reporting how many bytes came back and what the pidfd
+ * cmsgs that came with them say.
+ */
+static int read_pidfd_msg(int fd, struct pidfd_msg *out)
+{
+	char control[CMSG_SPACE(sizeof(int)) * 2] = { 0 };
+	int tgid_pidfd = -1, thread_pidfd = -1;
+	struct thread_ids buf[2] = { 0 };
+	struct msghdr msg = { 0 };
+	struct cmsghdr *cmsg;
+	struct iovec iov;
+
+	iov.iov_base = buf;
+	iov.iov_len = sizeof(buf);
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = control;
+	msg.msg_controllen = sizeof(control);
+
+	out->len = recvmsg(fd, &msg, 0);
+	if (out->len < 0) {
+		log_err("recvmsg");
+		return -1;
+	}
+
+	if (msg.msg_flags & MSG_CTRUNC) {
+		log_err("recvmsg: control truncated");
+		return -1;
+	}
+
+	out->ids = buf[0];
+
+	for (cmsg = CMSG_FIRSTHDR(&msg); cmsg != NULL;
+	     cmsg = CMSG_NXTHDR(&msg, cmsg)) {
+		if (cmsg->cmsg_level != SOL_SOCKET)
+			continue;
+
+		if (cmsg->cmsg_type == SCM_PIDFD)
+			memcpy(&tgid_pidfd, CMSG_DATA(cmsg), sizeof(tgid_pidfd));
+		else if (cmsg->cmsg_type == SCM_PIDFD_THREAD)
+			memcpy(&thread_pidfd, CMSG_DATA(cmsg), sizeof(thread_pidfd));
+	}
+
+	out->have_tgid = tgid_pidfd >= 0;
+	out->have_thread = thread_pidfd >= 0;
+
+	if (out->have_tgid) {
+		if (get_pidfd_info(tgid_pidfd, &out->tgid_info))
+			return -1;
+		out->tgid_flags = fcntl(tgid_pidfd, F_GETFL);
+		close(tgid_pidfd);
+	}
+
+	if (out->have_thread) {
+		if (get_pidfd_info(thread_pidfd, &out->thread_info))
+			return -1;
+		out->thread_flags = fcntl(thread_pidfd, F_GETFL);
+		close(thread_pidfd);
+	}
+
+	return 0;
+}
+
+/*
+ * Runs @nwriters threads of one child process against a SOCK_STREAM pair,
+ * all of them queued before the parent reads. SO_PASSPIDFD is set when
+ * @want_tgid is given, SO_PASSPIDFD_THREAD when @want_thread is. @nread
+ * reads are returned in @out.
+ */
+static int pidfd_flow(void *(*sender)(void *), int nwriters, bool want_tgid,
+		      bool want_thread, struct pidfd_msg *out, int nread)
+{
+	int child_status = 0;
+	int syncpipe[2];
+	int ackpipe[2];
+	int sk[2];
+	int on = 1;
+	char sync;
+	pid_t child;
+	int i;
+
+	if (nwriters > MAX_WRITERS)
+		return -1;
+
+	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sk))
+		return -1;
+	if (pipe(syncpipe) || pipe(ackpipe) || pipe(seq_pipe))
+		return -1;
+
+	child = fork();
+	if (child < 0)
+		return -1;
+
+	if (child == 0) {
+		close(sk[0]);
+		close(syncpipe[1]);
+		close(ackpipe[0]);
+		thread_client(sk[1], syncpipe[0], ackpipe[1], sender, nwriters);
+	}
+	close(sk[1]);
+	close(syncpipe[0]);
+	close(ackpipe[1]);
+	close(seq_pipe[0]);
+	close(seq_pipe[1]);
+
+	if (want_tgid &&
+	    setsockopt(sk[0], SOL_SOCKET, SO_PASSPIDFD, &on, sizeof(on))) {
+		log_err("Failed to set SO_PASSPIDFD");
+		return -1;
+	}
+
+	if (want_thread &&
+	    setsockopt(sk[0], SOL_SOCKET, SO_PASSPIDFD_THREAD, &on, sizeof(on))) {
+		log_err("Failed to set SO_PASSPIDFD_THREAD");
+		return -1;
+	}
+
+	/* let the child know the options are set, it can write now */
+	if (write(syncpipe[1], "1", 1) != 1)
+		return -1;
+	close(syncpipe[1]);
+
+	/* wait until every writer has queued its message */
+	if (read(ackpipe[0], &sync, 1) != 1)
+		return -1;
+	close(ackpipe[0]);
+
+	for (i = 0; i < nread; i++)
+		if (read_pidfd_msg(sk[0], &out[i]))
+			return -1;
+
+	/* release the writers */
+	for (i = 0; i < nwriters; i++)
+		if (write(sk[0], "x", 1) != 1)
+			return -1;
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
+	/* Verify that the options are truly set independently */
+	ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSPIDFD_THREAD, 1));
+	ASSERT_EQ(1, sockopt_get(sk[0], SO_PASSPIDFD_THREAD));
+	ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSPIDFD));
+
+	ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSPIDFD, 1));
+	ASSERT_EQ(1, sockopt_get(sk[0], SO_PASSPIDFD));
+	ASSERT_EQ(1, sockopt_get(sk[0], SO_PASSPIDFD_THREAD));
+
+	/* Verify that the options are truly cleared independently */
+	ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSPIDFD, 0));
+	ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSPIDFD));
+	ASSERT_EQ(1, sockopt_get(sk[0], SO_PASSPIDFD_THREAD));
+
+	ASSERT_EQ(0, sockopt_set(sk[0], SO_PASSPIDFD_THREAD, 0));
+	ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSPIDFD_THREAD));
+	ASSERT_EQ(0, sockopt_get(sk[0], SO_PASSPIDFD));
+
+	close(sk[0]);
+	close(sk[1]);
+}
+
+/* A receiver that only asked about the process cannot tell the two
+ * threads apart, so their writes are glued into one read.
+ */
+TEST(scm_pidfd_stream_glues_threads)
+{
+	struct pidfd_msg msg[1] = { 0 };
+
+	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 2, true, false, msg, 1));
+	EXPECT_EQ(sizeof(struct thread_ids) * 2, msg[0].len);
+
+	EXPECT_TRUE(msg[0].have_tgid);
+	EXPECT_FALSE(msg[0].have_thread);
+	EXPECT_EQ(msg[0].ids.pid, msg[0].tgid_info.pid);
+	EXPECT_EQ(msg[0].ids.pid, msg[0].tgid_info.tgid);
+}
+
+/* A receiver asking for both thread and process pidfd should get a unique
+ * msg for each thread writing
+ */
+TEST(scm_pidfd_thread_stream_splits_on_threads)
+{
+	struct pidfd_msg msg[2] = { 0 };
+	int i;
+
+	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 2, true, true, msg, 2));
+
+	for (i = 0; i < 2; i++) {
+		EXPECT_EQ(sizeof(struct thread_ids), msg[i].len);
+		EXPECT_TRUE(msg[i].have_tgid);
+		EXPECT_TRUE(msg[i].have_thread);
+
+		/* Make sure the info makes sense for the pidfd type */
+		EXPECT_EQ(msg[i].ids.pid, msg[i].tgid_info.pid);
+		EXPECT_EQ(msg[i].ids.pid, msg[i].tgid_info.tgid);
+		EXPECT_EQ(msg[i].ids.tid, msg[i].thread_info.pid);
+		EXPECT_EQ(msg[i].ids.pid, msg[i].thread_info.tgid);
+		EXPECT_NE(msg[i].ids.pid, msg[i].ids.tid);
+	}
+
+	/* Make sure we really got unique threads per message */
+	EXPECT_NE(msg[0].ids.tid, msg[1].ids.tid);
+	EXPECT_EQ(msg[0].ids.pid, msg[1].ids.pid);
+	EXPECT_EQ(msg[0].tgid_info.pid, msg[1].tgid_info.pid);
+	EXPECT_NE(msg[0].thread_info.pid, msg[1].thread_info.pid);
+}
+
+/* Sends from the thread-group leader */
+static int leader_flow(bool want_thread, struct pidfd_msg *out)
+{
+	struct thread_ids ids = {
+		.pid = getpid(),
+		.tid = gettid(),
+	};
+	int sk[2];
+	int on = 1;
+	int ret;
+
+	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sk))
+		return -1;
+
+	if (setsockopt(sk[0], SOL_SOCKET, SO_PASSPIDFD, &on, sizeof(on))) {
+		log_err("Failed to set SO_PASSPIDFD");
+		return -1;
+	}
+
+	if (want_thread &&
+	    setsockopt(sk[0], SOL_SOCKET, SO_PASSPIDFD_THREAD, &on, sizeof(on))) {
+		log_err("Failed to set SO_PASSPIDFD_THREAD");
+		return -1;
+	}
+
+	if (send(sk[1], &ids, sizeof(ids), 0) != sizeof(ids)) {
+		log_err("send");
+		return -1;
+	}
+
+	ret = read_pidfd_msg(sk[0], out);
+
+	close(sk[0]);
+	close(sk[1]);
+
+	return ret;
+}
+
+TEST(scm_pidfd_leader_sender)
+{
+	struct pidfd_msg msg = { 0 };
+
+	ASSERT_EQ(getpid(), gettid());
+
+	ASSERT_EQ(0, leader_flow(false, &msg));
+	ASSERT_TRUE(msg.have_tgid);
+	EXPECT_FALSE(msg.have_thread);
+
+	EXPECT_EQ(getpid(), msg.tgid_info.pid);
+	EXPECT_EQ(getpid(), msg.tgid_info.tgid);
+	EXPECT_FALSE(msg.tgid_flags & O_EXCL);
+}
+
+TEST(scm_pidfd_thread_leader_sender)
+{
+	struct pidfd_msg msg = { 0 };
+
+	ASSERT_EQ(getpid(), gettid());
+
+	ASSERT_EQ(0, leader_flow(true, &msg));
+	ASSERT_TRUE(msg.have_tgid);
+	ASSERT_TRUE(msg.have_thread);
+
+	EXPECT_EQ(getpid(), msg.tgid_info.pid);
+	EXPECT_EQ(getpid(), msg.tgid_info.tgid);
+	EXPECT_EQ(getpid(), msg.thread_info.pid);
+	EXPECT_EQ(getpid(), msg.thread_info.tgid);
+
+	EXPECT_FALSE(msg.tgid_flags & O_EXCL);
+	EXPECT_TRUE(msg.thread_flags & O_EXCL);
+}
+
+TEST(scm_pidfd_thread_and_group)
+{
+	struct pidfd_msg msg = { 0 };
+
+	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 1, true, true, &msg, 1));
+	ASSERT_NE(msg.ids.pid, msg.ids.tid);
+	ASSERT_TRUE(msg.have_tgid);
+	ASSERT_TRUE(msg.have_thread);
+
+	EXPECT_EQ(msg.ids.pid, msg.tgid_info.pid);
+	EXPECT_EQ(msg.ids.pid, msg.tgid_info.tgid);
+
+	EXPECT_EQ(msg.ids.tid, msg.thread_info.pid);
+	EXPECT_EQ(msg.ids.pid, msg.thread_info.tgid);
+}
+
+TEST(scm_pidfd_thread)
+{
+	struct pidfd_msg msg = { 0 };
+
+	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 1, false, true, &msg, 1));
+	ASSERT_NE(msg.ids.pid, msg.ids.tid);
+	ASSERT_TRUE(msg.have_thread);
+	EXPECT_FALSE(msg.have_tgid);
+	EXPECT_EQ(msg.ids.tid, msg.thread_info.pid);
+	EXPECT_EQ(msg.ids.pid, msg.thread_info.tgid);
+}
+
+TEST(scm_pidfd_thread_group)
+{
+	struct pidfd_msg msg = { 0 };
+
+	ASSERT_EQ(0, pidfd_flow(send_ids_thread, 1, true, false, &msg, 1));
+	ASSERT_NE(msg.ids.pid, msg.ids.tid);
+	ASSERT_TRUE(msg.have_tgid);
+	EXPECT_FALSE(msg.have_thread);
+	EXPECT_EQ(msg.ids.pid, msg.tgid_info.pid);
+	EXPECT_EQ(msg.ids.pid, msg.tgid_info.tgid);
+}
+
+TEST(scm_pidfd_thread_creds)
+{
+	struct pidfd_msg msg = { 0 };
+
+	ASSERT_EQ(0, pidfd_flow(send_ids_creds_thread, 1, true, true, &msg, 1));
+	ASSERT_NE(msg.ids.pid, msg.ids.tid);
+	ASSERT_TRUE(msg.have_tgid);
+	ASSERT_TRUE(msg.have_thread);
+	EXPECT_EQ(msg.ids.pid, msg.tgid_info.pid);
+	EXPECT_EQ(msg.ids.pid, msg.tgid_info.tgid);
+	EXPECT_EQ(msg.ids.tid, msg.thread_info.pid);
+	EXPECT_EQ(msg.ids.pid, msg.thread_info.tgid);
+}
+
 TEST_HARNESS_MAIN

-- 
2.55.0

