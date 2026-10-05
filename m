Received: from mail-yx2-f39.google.com (mail-yx2-f39.google.com [74.125.224.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4044CDA31
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213009; cv=none; b=MtF0FlmIxL8FRq+Y85hD7N6EgtCAwRiUek0lX+yS0w0fXgAjFlGyglour26kA0egK/+yeKnfYQqaYbbNrQVTPR+SyMRevjptPyPI7ty1lfxbuNmp6dBiKwDmY4oDcNMz6CpfXQjLcotZannn8oMfWY8jjNaGvc9IGyqi7YZlpwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213009; c=relaxed/simple;
	bh=dGHrchG/abitpSpPzVzh/aTSFCY3Ku7xR5Cg+X5z2GU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XEXMAcPNDpYsIx4Kpo//ouMt4guEisk27HGJWcpZtV9GVXqySS3TW5FyrXFsGSg20RNvhARoo5DPDkvPDlIx21+HrYfXX55yJam9cDWAyoik7fyVqx+SPotfV4fbFdcCfUXwN7GX1qlOg7QIQV8mPpgaZT+eKSoa+ylwepX2P14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b=xXWy7Ciw; arc=none smtp.client-ip=74.125.224.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20251104.gappssmtp.com header.i=@amutable-com.20251104.gappssmtp.com header.b="xXWy7Ciw"
Received: by mail-yx2-f39.google.com with SMTP id 00721157ae682-8ad0c8eac08so13843657b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20251104.gappssmtp.com; s=20251104; t=1791213001; x=1791817801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dbq2DM657UXRUZrUM+7dawOTBHr08M0XClPpfaZ9skM=;
        b=xXWy7Ciw/opYYp6BnMLNv3qZCiq+H8Q9Dc/ziGvj3e5/CoD4yCbb9XyqYo0XawD10G
         QCC7InUgK0sgch9W4Rn1owlb8y2hQoruNL4sB5Ybphrj1I90jMQ9Jf5DiAXUQ+nLCa7A
         IUkaEH0j8r3iQBDGzY+dcxlJ79L8Ls7ofLZevXk+AhXD5qjBtMmsMW47ADhkkR/QE04q
         GjSOdaNtUeBEE7Pw46Ohwik7Gaq21FeMw9vlcauTFmZG3Bmc5doZmb+0ZSU5j0hXZ+Bi
         GaUbY7da4RGccbThnHVpY+8OA5Pq0u75PZ8VQ0egsQlwnhSlWep8iKgQ3d2HeGXmI7h4
         bEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791213001; x=1791817801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dbq2DM657UXRUZrUM+7dawOTBHr08M0XClPpfaZ9skM=;
        b=a6DsnB8uVZ8e6vSRLYYdTB3rQeYpttpVcgNTpv8/xhXjW/JxlWqalEuluB9f667f5d
         xkBJTa1M0HdtdHsy9sf/4FOH+wNM0uf2rb1uzRbb76FTJTT4JfWBfPpdGABDFnBqlkez
         RhBz+OmEHvRkKPC05efyvH17EgC4pzrWse9Is/NU5pbqfvxyn28tsQ275DJn4fvPsdmh
         3ebPkxWi9Gvu0cPjgxnHMqM8AL/y+7/DVZFdF2eUSwTuRKALTvk28P4r5uAvnropq8o8
         ++iEaVgWJn6pcIEoGFV7TBcI+s9WunEOkVp1lZWxjUVymK5S+d71J1nr/ipHMKllna+R
         9Yaw==
X-Forwarded-Encrypted: i=1; AKwUvBxG9WEFF8b4EdwY43WBujmlGgjqJdCBnZZJWZ+3q5B95WgrPA0h8TJdbBNAyePtGkiFnoVn5jx9VJnWpyr5@vger.kernel.org
X-Gm-Message-State: AFq9FYLda+dYowgmZJ9ZHqUEB0wliduGweMpZHviSPiWeq3NOTiwSJ/U
	fySu7LLy8ZqKij68lDShaCpDBB6ObwZAe08Kt0k173rMY6cfVn0YWhqfWl04CRz68eti
X-Gm-Gg: AYBFou2i83ucJo1VsXqsNXMF4OrVo5FLJEEXCI4ZYL4KvhompHvFvR9f/jBg18vkdhd
	8hciu/O/5UY1CGIyTj8h1/Tvh7pxL8789Io7PrjIGJOwOi/fjJ3Y6ZYza1utpCJWbCNKEo4eSV+
	O6UPfvuG4++cr2NaPeFHiimkvtjcXHlyjRwCC8dPTIcqBzThbbT0DqeyVT2oyfvDdzHXidUubI0
	Aq/wP/cFV9uCeacI9Q7faAN6cydX0+ov7/zcb5qg593fujJfTwTPfe19DUCex02HE4DGs0AxpJD
	TosCuLYCQPvGSWKhWonV+Dw3ce3wyvx66HqbILcfirhXWHjtnpa/MGm/OEMxiROTz0DQOtkIXI6
	KYxkLq0GtQQiCxei4uTkYcJ4mN3xGQNnWNq5Jg9IVfBdYxM8syVbmoClyXtCW+Wp5bKYZUnvcXa
	P54HIB+nNKSnRaoaQM/UWds77uGkDCVuDylN4pYyOawo2sa9n2+shZISPDM1Ol6cKIlbEAnN0ql
	6Yccnu/SgC0Fmk8Yp/72N2AjmBJeB6+6aWMbZDyb71XrjLn6IAFZYM=
X-Received: by 2002:a05:690c:7093:b0:8a8:8d90:a6c8 with SMTP id 00721157ae682-8ae36a07c62mr44159797b3.6.1791213001211;
        Mon, 05 Oct 2026 08:10:01 -0700 (PDT)
Received: from [192.168.1.110] (104-53-165-62.lightspeed.stlsmo.sbcglobal.net. [104.53.165.62])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae33fe81fdsm41210467b3.47.2026.10.05.08.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:10:00 -0700 (PDT)
From: Andrew Halaney <andrew@amutable.com>
Date: Mon, 05 Oct 2026 10:09:40 -0500
Subject: [PATCH v4 10/10] selftests/coredump: check the dumping thread's
 pidfd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-work-unix-passpidfd-v4-10-350183b6e02a@amutable.com>
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
 Andrew Halaney <andrew@amutable.com>, Eric Dumazet <edumazet@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.14.3

From: Christian Brauner <brauner@kernel.org>

Crash from a non-leader thread and verify that the pidfd from
SO_PEERPIDFD_THREAD on the coredump socket refers to that thread and
reports the coredump like the thread-group leader's pidfd does.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Signed-off-by: Andrew Halaney <andrew@amutable.com>
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
2.55.0

