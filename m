Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DB44AB1AE
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000175; cv=none; b=b/e9+SzuUG7ha5+zD2yZZEuewL2MnuaLjjNErnMZs5nQPK3zL6MvcgtbKXFXDzFEjrtvhCjEuDTbhV+qm3rLWl+DA6NlnYkrZY1EiQGbVe7NyX6uRvHmZt4N2Us0wHnn+dMr1l8yN1SCHW9pxwpTp8mvaVHfPujZciEJON3YsMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000175; c=relaxed/simple;
	bh=veCcwByUAU83EykJ2Pn0jdM6Nbpn9bLOO6qNb3vIiQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U4ieO4wIsE3TPsiGKk2/d4PrpqtUjAsXnOJ18kNquHrJDkb/skcYZPC5v6V8VFicc4OOkDtER8lCyNynWrsT3RnEs0Kt1czr9otjxYCrPQ568eLKCtJjTBdjlhbGNDmhoab9fN5RiWYTC1nPIOl004VPToUDAw3UnMqCCgkW/MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2vYDmVF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2vYDmVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6878F1F00898;
	Mon, 21 Sep 2026 14:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790000171;
	bh=0yD1HO/xNYp1hHOm1dPZrrMVSnwzIW4wo+BRf2JXu9Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=T2vYDmVF5KoMJUib2AJ8eNK+9mch4XXaKzm4U3MsbeyAUeuiy1QuQb0dBbAosdVw4
	 Ay0mSwd6jBqGYRk37ZxYq++sqGQLeKlTxtAYi8rXT+v9/MtUClC/anhsIGe3hmvS7j
	 u/NU4xPzvEuoqIl2XG/gcYcu99GRgpDJSHfLIbOGXOSwxD2jDNTpKyE1vaZ/o+/IQA
	 D6U5MiDoFrMzXNLhBFLZHbFMx5PGE6yqHcZ9qii4akdgV5Zd/X4fVZCVO4EQNN242e
	 bQfQFVMyjnaaV1LYHl8hQd4WRJnJPWk4VfIUcya7lwQFHLP73u4ux5J78bZXwlTAtE
	 DrV7t98TYExpA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 21 Sep 2026 16:15:38 +0200
Subject: [PATCH 10/10] selftests/core: test CLOSE_RANGE_CLOEXEC_ONLY
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-work-file-close_range_except-v1-10-c20d0b49270d@kernel.org>
References: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
In-Reply-To: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
 Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Neil Brown <neil@brown.name>, Jeff Layton <jlayton@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=15291; i=brauner@kernel.org;
 h=from:subject:message-id; bh=veCcwByUAU83EykJ2Pn0jdM6Nbpn9bLOO6qNb3vIiQU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRttOFR2VDC01Edrt9xJfcg68vVMlwM8157SL0QE3x8t
 XGRvWJaRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESWfWT4n/DlZL+88uzSnWK/
 Jto/Z+LILJjJ6XP0+WrJD/8Ej1qzljD8T/s9bf051fLwB2pTb3+t1p954YXYhh52nc7/6YefaW3
 9wwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Cover closing what is marked:

- close-on-exec descriptors in the range go, the ones outside stay, and
  a range above the table closes nothing

- with CLOSE_RANGE_EXCEPT it is the other way around, and the kept ones
  keep their flag, for a window in the middle, at the top and at the
  bottom

- descriptors without close-on-exec are never touched, in or out of the
  range

- a range that cannot hold an open descriptor keeps nothing, one that
  covers everything keeps everything, in place and in a clone

- the unshare form leaves the table it was cloned from alone, with and
  without CLOSE_RANGE_EXCEPT

- the unshare form keeps the descriptors without the flag that sit in
  the range it drops from, and hands the dropped slots out again

- a kept range above the last descriptor without close-on-exec still
  comes back, so the clone is sized off the range too

Also check that asking for CLOSE_RANGE_CLOEXEC at the same time is
refused, whatever else is asked for, and that the bounds are still
checked.

The extra cases came out of the same walk with the close-on-exec mask
on top: a marked and an unmarked descriptor on each side of every window
position, and the size of the clone when only unmarked ones are left in
the range it drops from.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/core/close_range_test.c | 481 ++++++++++++++++++++++++
 1 file changed, 481 insertions(+)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index caeb2f1ea800..20ecb65e529b 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -1063,6 +1063,487 @@ TEST(close_range_except_unshare)
 		EXPECT_NE(-1, fcntl(open_fds[i], F_GETFD));
 }
 
+TEST(close_range_cloexec_only)
+{
+	int i, ret;
+	int open_fds[101];
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+		int fd;
+
+		/* Odd slots are close-on-exec, even ones are not. */
+		fd = open("/dev/null", O_RDONLY | (i % 2 ? O_CLOEXEC : 0));
+		ASSERT_GE(fd, 0) {
+			if (errno == ENOENT)
+				SKIP(return, "Skipping test since /dev/null does not exist");
+		}
+
+		open_fds[i] = fd;
+	}
+
+	ret = sys_close_range(open_fds[10], open_fds[20],
+			      CLOSE_RANGE_CLOEXEC_ONLY);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "close_range() syscall not supported");
+		if (errno == EINVAL)
+			SKIP(return, "close_range() doesn't support CLOSE_RANGE_CLOEXEC_ONLY");
+	}
+	ASSERT_EQ(0, ret);
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+		bool closed = i % 2 && i >= 10 && i <= 20;
+
+		EXPECT_EQ(!closed, fcntl(open_fds[i], F_GETFD) != -1);
+	}
+
+	/* A range above the table closes nothing. */
+	ASSERT_EQ(0, sys_close_range(UINT_MAX, UINT_MAX,
+				     CLOSE_RANGE_CLOEXEC_ONLY));
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+		bool closed = i % 2 && i >= 10 && i <= 20;
+
+		EXPECT_EQ(!closed, fcntl(open_fds[i], F_GETFD) != -1);
+	}
+
+	/* Do what an exec would do to the rest. */
+	ASSERT_EQ(0, sys_close_range(0, UINT_MAX, CLOSE_RANGE_CLOEXEC_ONLY));
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++)
+		EXPECT_EQ(!(i % 2), fcntl(open_fds[i], F_GETFD) != -1);
+}
+
+TEST(close_range_cloexec_only_except)
+{
+	int i, ret;
+	int open_fds[101];
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+		int fd;
+
+		fd = open("/dev/null", O_RDONLY | (i % 2 ? O_CLOEXEC : 0));
+		ASSERT_GE(fd, 0) {
+			if (errno == ENOENT)
+				SKIP(return, "Skipping test since /dev/null does not exist");
+		}
+
+		open_fds[i] = fd;
+	}
+
+	ret = sys_close_range(open_fds[10], open_fds[20],
+			      CLOSE_RANGE_CLOEXEC_ONLY | CLOSE_RANGE_EXCEPT);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "close_range() syscall not supported");
+		if (errno == EINVAL)
+			SKIP(return, "close_range() doesn't support CLOSE_RANGE_CLOEXEC_ONLY");
+	}
+	ASSERT_EQ(0, ret);
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+		bool kept = !(i % 2) || (i >= 10 && i <= 20);
+		int flags = i % 2 ? FD_CLOEXEC : 0;
+
+		/* The kept ones keep their flag, so exec still drops them. */
+		EXPECT_EQ(kept ? flags : -1, fcntl(open_fds[i], F_GETFD));
+	}
+
+	/* A range that cannot hold an open descriptor keeps nothing. */
+	ASSERT_EQ(0, sys_close_range(UINT_MAX, UINT_MAX,
+				     CLOSE_RANGE_CLOEXEC_ONLY |
+				     CLOSE_RANGE_EXCEPT));
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++)
+		EXPECT_EQ(!(i % 2), fcntl(open_fds[i], F_GETFD) != -1);
+}
+
+TEST(close_range_cloexec_only_except_bounds)
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
+	ret = sys_close_range(0, UINT_MAX,
+			      CLOSE_RANGE_CLOEXEC_ONLY | CLOSE_RANGE_EXCEPT);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "close_range() syscall not supported");
+		if (errno == EINVAL)
+			SKIP(return, "close_range() doesn't support CLOSE_RANGE_CLOEXEC_ONLY");
+	}
+	ASSERT_EQ(0, ret);
+
+	struct {
+		unsigned int fd, max_fd;
+	} cases[] = {
+		/* A window at the top keeps the marked ones in it. */
+		{ open_fds[80], UINT_MAX },
+		/* One at the bottom keeps the marked ones in it. */
+		{ 0, open_fds[20] },
+		/* One that cannot hold a descriptor keeps none of them. */
+		{ UINT_MAX, UINT_MAX },
+	};
+
+	for (c = 0; c < ARRAY_SIZE(cases); c++) {
+		pid = sys_clone3(&args, sizeof(args));
+		ASSERT_GE(pid, 0);
+
+		if (pid == 0) {
+			ret = sys_close_range(cases[c].fd, cases[c].max_fd,
+					      CLOSE_RANGE_CLOEXEC_ONLY |
+					      CLOSE_RANGE_EXCEPT);
+			if (ret)
+				exit(EXIT_FAILURE);
+
+			for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+				unsigned int fd = open_fds[i];
+				bool kept = !(i % 2) || (fd >= cases[c].fd &&
+							 fd <= cases[c].max_fd);
+				int flags = i % 2 ? FD_CLOEXEC : 0;
+
+				if (fcntl(fd, F_GETFD) != (kept ? flags : -1))
+					exit(EXIT_FAILURE);
+			}
+
+			/* stdio is neither marked nor gone. */
+			if (fcntl(STDERR_FILENO, F_GETFD) & FD_CLOEXEC)
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
+TEST(close_range_cloexec_only_unshare)
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
+	ret = sys_close_range(0, UINT_MAX,
+			      CLOSE_RANGE_CLOEXEC_ONLY | CLOSE_RANGE_EXCEPT);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "close_range() syscall not supported");
+		if (errno == EINVAL)
+			SKIP(return, "close_range() doesn't support CLOSE_RANGE_CLOEXEC_ONLY");
+	}
+	ASSERT_EQ(0, ret);
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++)
+		ASSERT_NE(-1, fcntl(open_fds[i], F_GETFD));
+
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = sys_close_range(open_fds[10], open_fds[20],
+				      CLOSE_RANGE_UNSHARE |
+				      CLOSE_RANGE_CLOEXEC_ONLY);
+		if (ret)
+			exit(EXIT_FAILURE);
+
+		for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+			bool closed = i % 2 && i >= 10 && i <= 20;
+
+			if (closed == (fcntl(open_fds[i], F_GETFD) != -1))
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
+	/* A range at the top keeps the descriptors without the flag in it. */
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = sys_close_range(open_fds[50], UINT_MAX,
+				      CLOSE_RANGE_UNSHARE |
+				      CLOSE_RANGE_CLOEXEC_ONLY);
+		if (ret)
+			exit(EXIT_FAILURE);
+
+		for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+			bool closed = i % 2 && i >= 50;
+
+			if (closed == (fcntl(open_fds[i], F_GETFD) != -1))
+				exit(EXIT_FAILURE);
+		}
+
+		/* The first slot left behind is the next one handed out. */
+		if (dup(0) != open_fds[51])
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
+TEST(close_range_cloexec_only_except_unshare)
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
+	ret = sys_close_range(0, UINT_MAX,
+			      CLOSE_RANGE_CLOEXEC_ONLY | CLOSE_RANGE_EXCEPT);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "close_range() syscall not supported");
+		if (errno == EINVAL)
+			SKIP(return, "close_range() doesn't support CLOSE_RANGE_CLOEXEC_ONLY");
+	}
+	ASSERT_EQ(0, ret);
+
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++)
+		ASSERT_NE(-1, fcntl(open_fds[i], F_GETFD));
+
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = sys_close_range(open_fds[10], open_fds[20],
+				      CLOSE_RANGE_UNSHARE |
+				      CLOSE_RANGE_CLOEXEC_ONLY |
+				      CLOSE_RANGE_EXCEPT);
+		if (ret)
+			exit(EXIT_FAILURE);
+
+		for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+			bool kept = !(i % 2) || (i >= 10 && i <= 20);
+			int flags = i % 2 ? FD_CLOEXEC : 0;
+
+			if (fcntl(open_fds[i], F_GETFD) != (kept ? flags : -1))
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
+	/* A window that cannot hold a descriptor keeps none of the marked. */
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = sys_close_range(UINT_MAX, UINT_MAX,
+				      CLOSE_RANGE_UNSHARE |
+				      CLOSE_RANGE_CLOEXEC_ONLY |
+				      CLOSE_RANGE_EXCEPT);
+		if (ret)
+			exit(EXIT_FAILURE);
+
+		for (i = 0; i < ARRAY_SIZE(open_fds); i++)
+			if ((i % 2) == (fcntl(open_fds[i], F_GETFD) != -1))
+				exit(EXIT_FAILURE);
+
+		if (fcntl(STDERR_FILENO, F_GETFD) == -1)
+			exit(EXIT_FAILURE);
+
+		exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+
+	/* One that covers everything keeps everything, in a clone too. */
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = sys_close_range(0, UINT_MAX,
+				      CLOSE_RANGE_UNSHARE |
+				      CLOSE_RANGE_CLOEXEC_ONLY |
+				      CLOSE_RANGE_EXCEPT);
+		if (ret)
+			exit(EXIT_FAILURE);
+
+		for (i = 0; i < ARRAY_SIZE(open_fds); i++)
+			if (fcntl(open_fds[i], F_GETFD) != (i % 2 ? FD_CLOEXEC : 0))
+				exit(EXIT_FAILURE);
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
+TEST(close_range_cloexec_only_except_unshare_sizing)
+{
+	int i, ret, status;
+	pid_t pid;
+	int open_fds[200];
+	struct __clone_args args = {
+		.flags = CLONE_FILES,
+		.exit_signal = SIGCHLD,
+	};
+
+	/* All close-on-exec, so the kept range alone sizes the clone. */
+	for (i = 0; i < ARRAY_SIZE(open_fds); i++) {
+		int fd;
+
+		fd = open("/dev/null", O_RDONLY | O_CLOEXEC);
+		ASSERT_GE(fd, 0) {
+			if (errno == ENOENT)
+				SKIP(return, "Skipping test since /dev/null does not exist");
+		}
+
+		open_fds[i] = fd;
+	}
+
+	ret = sys_close_range(0, UINT_MAX,
+			      CLOSE_RANGE_CLOEXEC_ONLY | CLOSE_RANGE_EXCEPT);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "close_range() syscall not supported");
+		if (errno == EINVAL)
+			SKIP(return, "close_range() doesn't support CLOSE_RANGE_CLOEXEC_ONLY");
+	}
+	ASSERT_EQ(0, ret);
+
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		ret = sys_close_range(open_fds[150], open_fds[160],
+				      CLOSE_RANGE_UNSHARE |
+				      CLOSE_RANGE_CLOEXEC_ONLY |
+				      CLOSE_RANGE_EXCEPT);
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
+		/* Nothing set close-on-exec on stdio. */
+		if (fcntl(STDERR_FILENO, F_GETFD) == -1)
+			exit(EXIT_FAILURE);
+
+		exit(EXIT_SUCCESS);
+	}
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+}
+
+TEST(close_range_cloexec_only_einval)
+{
+	int ret;
+
+	/* A range covering everything keeps everything, so this only probes. */
+	ret = sys_close_range(0, UINT_MAX,
+			      CLOSE_RANGE_CLOEXEC_ONLY | CLOSE_RANGE_EXCEPT);
+	if (ret < 0) {
+		if (errno == ENOSYS)
+			SKIP(return, "close_range() syscall not supported");
+		if (errno == EINVAL)
+			SKIP(return, "close_range() doesn't support CLOSE_RANGE_CLOEXEC_ONLY");
+	}
+	ASSERT_EQ(0, ret);
+
+	EXPECT_EQ(-1, sys_close_range(3, UINT_MAX, CLOSE_RANGE_CLOEXEC |
+						   CLOSE_RANGE_CLOEXEC_ONLY));
+	EXPECT_EQ(EINVAL, errno);
+
+	/* The other flags do not make the pair acceptable. */
+	EXPECT_EQ(-1, sys_close_range(3, UINT_MAX, CLOSE_RANGE_UNSHARE |
+						   CLOSE_RANGE_CLOEXEC |
+						   CLOSE_RANGE_CLOEXEC_ONLY |
+						   CLOSE_RANGE_EXCEPT));
+	EXPECT_EQ(EINVAL, errno);
+
+	/* The bounds are checked with the new flag too. */
+	EXPECT_EQ(-1, sys_close_range(4, 3, CLOSE_RANGE_CLOEXEC_ONLY |
+					    CLOSE_RANGE_EXCEPT));
+	EXPECT_EQ(EINVAL, errno);
+}
+
 TEST(close_range_bitmap_corruption)
 {
 	pid_t pid;

-- 
2.53.0

