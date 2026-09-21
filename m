Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9294AA58F
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000171; cv=none; b=lRgPY7OLmbEyO27mVY6c27Wa6P6TeVRMcVDWKWII58U96U4e9IzZcsQ35KlRHpCpfyWVXwhCQIa7To6QlAHDaQ1G2nMDq1pemVCiwU9EaWyEybyvpYTzcB1j8xvUCDJgv1/BFOuJLbZwScEGtsgdFRVphhucs3mjDoIcV0yLZ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000171; c=relaxed/simple;
	bh=Q8Ei3emeuVwdmlqETiMWLQTAGwVOqwiqOenl2RuxOXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H6iuRIARxiE8AGEA342k6IcYOe1eXT6Rngtms9THLR17BU8SZH5q5obU4QmhtGuGQEJVZb2LDeOnuY4IHhtMn2jDyQr6BKzRx8UhCMkl6z6+jjQDwbPy+FMHThxaVe3KxdPwLY5hPD+cO1l0qg8WogtdTwJhryMrqcqP3c8TJmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdZKABhC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdZKABhC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742311F000FF;
	Mon, 21 Sep 2026 14:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000163;
	bh=/9M38gPNgDlsV8y5DA/xKg+YUM9pHYDdXO0r092DOm0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KdZKABhCDrF4RwPc1lL01xwwha+cqiYyz6DSCBdQ5/dj+3uDexgeesyl4NeeYyLde
	 96ekNbLFudm2TLm2lHHSC035aZXZjcYkz38oORcGZge33J0oSds9xYDNcfskY1VgBd
	 Fdpf8fjM6dGbzETuP+J0HwAQzhQiLRhbcqtCMo+Lcg6hkimONIZgRXjZo6sNbt2aoV
	 CkgLpIxGvEni0OiDkMhmynmOsJAV6ZWqPwz9pG86drcnbMfSW96WJDNJ6YNg/1Pr0+
	 DsXC8vJDvUTu/J31eMfc5AR0Hpub4AYtHyDEdNK8wz5C/pgX2jvF+3hmaTYUq7pFyE
	 TZdsUT9rLdUlw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 16:15:35 +0200
Subject: [PATCH 07/10] selftests/core: test CLOSE_RANGE_EXCEPT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-file-close_range_except-v1-7-c20d0b49270d@kernel.org>
References: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
In-Reply-To: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
 Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Neil Brown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=13987; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Q8Ei3emeuVwdmlqETiMWLQTAGwVOqwiqOenl2RuxOXk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRttOFhE9rnavsg/pbfC+1MrUn1nP1iVeHXWR4JOl4w5
 J28VulXRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER0VzL8dzYPLTNjcizx27DC
 1PyW6wTt6Vtjbr7yPy747/MhSV7lZYwMH+8yH+6cxZAw+/6jy9X59+Ve6Sa+idw3/UH3hN0BJhk
 vWAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Cover the inverted range:

- with plain close the window stays and everything outside of it goes,
  stdio included

- a window at the top, one that cannot hold a descriptor and one of a
  single descriptor keep just what they name, and so does the unshare
  form on a table that is not shared

- with CLOSE_RANGE_CLOEXEC everything outside of the window is marked
  and the window is not, in place and in a clone, for a
  window in the middle, at the bottom, at the top and above the table

- with CLOSE_RANGE_UNSHARE the table the child cloned from is untouched,
  a window near the top of the table comes back whole, one at the bottom
  keeps stdio, one that cannot hold a descriptor keeps nothing, and the
  slots left behind are handed out again from the bottom

- the bounds are checked before the range is turned around

The extra cases came out of walking the window positions that
__range_close(), __range_cloexec() and dup_fd() tell apart: at the
bottom, in the middle, at the top, above the table, a single descriptor
and none, on a shared and on a private table.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/core/close_range_test.c | 426 ++++++++++++++++++++++++
 1 file changed, 426 insertions(+)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index afae3462502d..caeb2f1ea800 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -36,6 +36,14 @@ static inline int sys_close_range(unsigned int fd, unsigned int max_fd,
 	return syscall(__NR_close_range, fd, max_fd, flags);
 }
 
+static void clear_cloexec(const int *fds, size_t n)
+{
+	size_t i;
+
+	for (i = 0; i < n; i++)
+		fcntl(fds[i], F_SETFD, 0);
+}
+
 TEST(core_close_range)
 {
 	int i, ret;
@@ -637,6 +645,424 @@ TEST(close_range_cloexec_unshare_syzbot)
 	EXPECT_EQ(close(fd3), 0);
 }
 
+TEST(close_range_except)
+{
+	int i, ret, status;
+	pid_t pid;
+	int open_fds[101];
+	struct __clone_args args = {
+		.exit_signal = SIGCHLD,
+	};
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+		int fd;
+
+		fd = open("/dev/null", O_RDONLY);
+		ASSERT_GE(fd, 0) {
+			if (errno == ENOENT)
+				SKIP(return, "Skipping test since /dev/null does not exist");
+		}
+
+		open_fds[i] = fd;
+	}
+
+	/* A range covering everything keeps everything. */
+	ret = sys_close_range(0, UINT_MAX, CLOSE_RANGE_EXCEPT);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "close_range() syscall not supported");
+		if (errno == EINVAL)
+			SKIP(return, "close_range() doesn't support CLOSE_RANGE_EXCEPT");
+	}
+	ASSERT_EQ(0, ret);
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++)
+		EXPECT_NE(-1, fcntl(open_fds[i], F_GETFD));
+
+	/* The bounds are checked before the range is turned around. */
+	EXPECT_EQ(-1, sys_close_range(open_fds[20], open_fds[10],
+				      CLOSE_RANGE_EXCEPT));
+	EXPECT_EQ(EINVAL, errno);
+
+	/* Everything above open_fds[50] goes. */
+	ASSERT_EQ(0, sys_close_range(0, open_fds[50], CLOSE_RANGE_EXCEPT));
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++)
+		EXPECT_EQ(i <= 50, fcntl(open_fds[i], F_GETFD) != -1);
+
+	/* A window in the middle takes stdio with it, so do that in a fork. */
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = sys_close_range(open_fds[10], open_fds[20],
+				      CLOSE_RANGE_EXCEPT);
+		if (ret)
+			exit(EXIT_FAILURE);
+
+		for (i = 0; i <= 50; i++) {
+			bool kept = i >= 10 && i <= 20;
+
+			if (kept != (fcntl(open_fds[i], F_GETFD) != -1))
+				exit(EXIT_FAILURE);
+		}
+
+		if (fcntl(STDERR_FILENO, F_GETFD) != -1)
+			exit(EXIT_FAILURE);
+
+		exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	/* The fork had a table of its own. */
+	for (i = 0; i <= 50; i++)
+		EXPECT_NE(-1, fcntl(open_fds[i], F_GETFD));
+}
+
+TEST(close_range_except_cloexec)
+{
+	int i, ret;
+	int open_fds[101];
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+		int fd;
+
+		fd = open("/dev/null", O_RDONLY);
+		ASSERT_GE(fd, 0) {
+			if (errno == ENOENT)
+				SKIP(return, "Skipping test since /dev/null does not exist");
+		}
+
+		open_fds[i] = fd;
+	}
+
+	ret = sys_close_range(open_fds[10], open_fds[20],
+			      CLOSE_RANGE_CLOEXEC | CLOSE_RANGE_EXCEPT);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "close_range() syscall not supported");
+		if (errno == EINVAL)
+			SKIP(return, "close_range() doesn't support CLOSE_RANGE_EXCEPT");
+	}
+	ASSERT_EQ(0, ret);
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+		bool inside = i >= 10 && i <= 20;
+		int flags = fcntl(open_fds[i], F_GETFD);
+
+		EXPECT_NE(-1, flags);
+		EXPECT_EQ(inside ? 0 : FD_CLOEXEC, flags & FD_CLOEXEC);
+	}
+
+	/* stdio sits outside of the window too. */
+	EXPECT_EQ(FD_CLOEXEC, fcntl(STDERR_FILENO, F_GETFD) & FD_CLOEXEC);
+
+	/* A window that starts at 0 marks only what lies above it. */
+	clear_cloexec(open_fds, ARRAY_SIZE(open_fds));
+	ASSERT_EQ(0, fcntl(STDERR_FILENO, F_SETFD, 0));
+	ASSERT_EQ(0, sys_close_range(0, open_fds[20],
+				     CLOSE_RANGE_CLOEXEC | CLOSE_RANGE_EXCEPT));
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++)
+		EXPECT_EQ(i <= 20 ? 0 : FD_CLOEXEC,
+			  fcntl(open_fds[i], F_GETFD) & FD_CLOEXEC);
+	EXPECT_EQ(0, fcntl(STDERR_FILENO, F_GETFD) & FD_CLOEXEC);
+
+	/* One at the top marks only what lies below it, stdio included. */
+	clear_cloexec(open_fds, ARRAY_SIZE(open_fds));
+	ASSERT_EQ(0, sys_close_range(open_fds[80], UINT_MAX,
+				     CLOSE_RANGE_CLOEXEC | CLOSE_RANGE_EXCEPT));
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++)
+		EXPECT_EQ(i < 80 ? FD_CLOEXEC : 0,
+			  fcntl(open_fds[i], F_GETFD) & FD_CLOEXEC);
+	EXPECT_EQ(FD_CLOEXEC, fcntl(STDERR_FILENO, F_GETFD) & FD_CLOEXEC);
+
+	/* One that cannot hold a descriptor marks everything. */
+	clear_cloexec(open_fds, ARRAY_SIZE(open_fds));
+	ASSERT_EQ(0, fcntl(STDERR_FILENO, F_SETFD, 0));
+	ASSERT_EQ(0, sys_close_range(UINT_MAX, UINT_MAX,
+				     CLOSE_RANGE_CLOEXEC | CLOSE_RANGE_EXCEPT));
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++)
+		EXPECT_EQ(FD_CLOEXEC, fcntl(open_fds[i], F_GETFD) & FD_CLOEXEC);
+	EXPECT_EQ(FD_CLOEXEC, fcntl(STDERR_FILENO, F_GETFD) & FD_CLOEXEC);
+}
+
+TEST(close_range_except_cloexec_unshare)
+{
+	int i, ret, status;
+	pid_t pid;
+	int open_fds[101];
+	struct __clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+		int fd;
+
+		fd = open("/dev/null", O_RDONLY);
+		ASSERT_GE(fd, 0) {
+			if (errno == ENOENT)
+				SKIP(return, "Skipping test since /dev/null does not exist");
+		}
+
+		open_fds[i] = fd;
+	}
+
+	/* A range covering everything marks nothing. */
+	ret = sys_close_range(0, UINT_MAX,
+			      CLOSE_RANGE_CLOEXEC | CLOSE_RANGE_EXCEPT);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "close_range() syscall not supported");
+		if (errno == EINVAL)
+			SKIP(return, "close_range() doesn't support CLOSE_RANGE_EXCEPT");
+	}
+	ASSERT_EQ(0, ret);
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++)
+		EXPECT_EQ(0, fcntl(open_fds[i], F_GETFD) & FD_CLOEXEC);
+
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = sys_close_range(open_fds[10], open_fds[20],
+				      CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC |
+				      CLOSE_RANGE_EXCEPT);
+		if (ret)
+			exit(EXIT_FAILURE);
+
+		for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+			bool inside = i >= 10 && i <= 20;
+			int flags = fcntl(open_fds[i], F_GETFD);
+
+			if (flags == -1)
+				exit(EXIT_FAILURE);
+			if ((flags & FD_CLOEXEC) != (inside ? 0 : FD_CLOEXEC))
+				exit(EXIT_FAILURE);
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	/* The shared table the child unshared from is untouched. */
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++)
+		EXPECT_EQ(0, fcntl(open_fds[i], F_GETFD) & FD_CLOEXEC);
+}
+
+TEST(close_range_except_bounds)
+{
+	int i, c, ret, status;
+	pid_t pid;
+	int open_fds[101];
+	struct __clone_args args = {
+		.exit_signal = SIGCHLD,
+	};
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+		int fd;
+
+		fd = open("/dev/null", O_RDONLY);
+		ASSERT_GE(fd, 0) {
+			if (errno == ENOENT)
+				SKIP(return, "Skipping test since /dev/null does not exist");
+		}
+
+		open_fds[i] = fd;
+	}
+
+	/* A range covering everything keeps everything. */
+	ret = sys_close_range(0, UINT_MAX, CLOSE_RANGE_EXCEPT);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "close_range() syscall not supported");
+		if (errno == EINVAL)
+			SKIP(return, "close_range() doesn't support CLOSE_RANGE_EXCEPT");
+	}
+	ASSERT_EQ(0, ret);
+
+	struct {
+		unsigned int fd, max_fd, flags;
+	} cases[] = {
+		/* A window at the top drops everything below it. */
+		{ open_fds[50], UINT_MAX, CLOSE_RANGE_EXCEPT },
+		/* One that cannot hold a descriptor keeps nothing. */
+		{ UINT_MAX, UINT_MAX, CLOSE_RANGE_EXCEPT },
+		/* One of a single descriptor keeps just that. */
+		{ open_fds[30], open_fds[30], CLOSE_RANGE_EXCEPT },
+		/* The unshare form on a table that is not shared acts in place. */
+		{ open_fds[10], open_fds[20],
+		  CLOSE_RANGE_UNSHARE | CLOSE_RANGE_EXCEPT },
+	};
+
+	/* Each of them takes stdio with it, so do that in a fork. */
+	for (c = 0; c < ARRAY_SIZE(cases); c++) {
+		pid = sys_clone3(&args, sizeof(args));
+		ASSERT_GE(pid, 0);
+
+		if (pid == 0) {
+			ret = sys_close_range(cases[c].fd, cases[c].max_fd,
+					      cases[c].flags);
+			if (ret)
+				exit(EXIT_FAILURE);
+
+			for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+				unsigned int fd = open_fds[i];
+				bool kept = fd >= cases[c].fd &&
+					    fd <= cases[c].max_fd;
+
+				if (kept != (fcntl(fd, F_GETFD) != -1))
+					exit(EXIT_FAILURE);
+			}
+
+			if (fcntl(STDERR_FILENO, F_GETFD) != -1)
+				exit(EXIT_FAILURE);
+
+			exit(EXIT_SUCCESS);
+		}
+
+		EXPECT_EQ(waitpid(pid, &status, 0), pid);
+		EXPECT_EQ(true, WIFEXITED(status));
+		EXPECT_EQ(0, WEXITSTATUS(status));
+	}
+
+	/* Each fork had a table of its own. */
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++)
+		EXPECT_NE(-1, fcntl(open_fds[i], F_GETFD));
+}
+
+TEST(close_range_except_unshare)
+{
+	int i, ret, status;
+	pid_t pid;
+	int open_fds[200];
+	struct __clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+		int fd;
+
+		/* Odd slots are close-on-exec, which makes no difference here. */
+		fd = open("/dev/null", O_RDONLY | (i % 2 ? O_CLOEXEC : 0));
+		ASSERT_GE(fd, 0) {
+			if (errno == ENOENT)
+				SKIP(return, "Skipping test since /dev/null does not exist");
+		}
+
+		open_fds[i] = fd;
+	}
+
+	/* A range covering everything keeps everything. */
+	ret = sys_close_range(0, UINT_MAX, CLOSE_RANGE_EXCEPT);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "close_range() syscall not supported");
+		if (errno == EINVAL)
+			SKIP(return, "close_range() doesn't support CLOSE_RANGE_EXCEPT");
+	}
+	ASSERT_EQ(0, ret);
+
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/* The window sits near the top, so the clone is sized off its end. */
+		ret = sys_close_range(open_fds[150], open_fds[160],
+				      CLOSE_RANGE_UNSHARE | CLOSE_RANGE_EXCEPT);
+		if (ret)
+			exit(EXIT_FAILURE);
+
+		for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+			bool kept = i >= 150 && i <= 160;
+
+			if (kept != (fcntl(open_fds[i], F_GETFD) != -1))
+				exit(EXIT_FAILURE);
+		}
+
+		if (fcntl(STDERR_FILENO, F_GETFD) != -1)
+			exit(EXIT_FAILURE);
+
+		/* What was left behind is handed out again, from the bottom. */
+		if (dup(open_fds[150]) != 0)
+			exit(EXIT_FAILURE);
+
+		exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	/* A window at the bottom keeps just that, stdio included. */
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = sys_close_range(0, open_fds[10],
+				      CLOSE_RANGE_UNSHARE | CLOSE_RANGE_EXCEPT);
+		if (ret)
+			exit(EXIT_FAILURE);
+
+		for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+			if ((i <= 10) != (fcntl(open_fds[i], F_GETFD) != -1))
+				exit(EXIT_FAILURE);
+		}
+
+		if (fcntl(STDERR_FILENO, F_GETFD) == -1)
+			exit(EXIT_FAILURE);
+
+		/* The first slot left behind is the next one handed out. */
+		if (dup(0) != open_fds[10] + 1)
+			exit(EXIT_FAILURE);
+
+		exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	/* A window that cannot hold a descriptor keeps nothing. */
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = sys_close_range(UINT_MAX, UINT_MAX,
+				      CLOSE_RANGE_UNSHARE | CLOSE_RANGE_EXCEPT);
+		if (ret)
+			exit(EXIT_FAILURE);
+
+		for (i = 0; i < ARRAY_SIZE(open_fds); i++)
+			if (fcntl(open_fds[i], F_GETFD) != -1)
+				exit(EXIT_FAILURE);
+
+		if (fcntl(STDERR_FILENO, F_GETFD) != -1)
+			exit(EXIT_FAILURE);
+
+		exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	/* The shared table the child unshared from is untouched. */
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++)
+		EXPECT_NE(-1, fcntl(open_fds[i], F_GETFD));
+}
+
 TEST(close_range_bitmap_corruption)
 {
 	pid_t pid;

-- 
2.53.0

