Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8360C3A7849;
	Thu, 26 Feb 2026 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113881; cv=none; b=Gvl6jubPHWCjsACv49wkDp+DlpyxGLprX2PMfP519GZcuCo4qxNX+omppeGSK6fbg3laXMkD7ZnNh4r5wBj6O7KFbSndrD8XdutGIebAlBrmXLRHQtCj8bPFcQNtQoZx0DNpuGRpLCtcJbf/dm9TmtXo92DF656sctc6Y/r2vaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113881; c=relaxed/simple;
	bh=XMWruOYLkxF4dZAR02/HIKIt+BPClxko2uWALy0QcoI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=brjaYyX6JVR+ec84EAfEcQbQv6gm5Us7jeYQ9QIUhV9GnqOzgXiJ7IhiC8TI3fHB9IjJxtbWPrlCDiZcMqmzco2JhN/nZzacc7gcqoMbjJyxz652qm6TYD36QkmWUdX0t8zpwT+XTt3WfisDqi25DnPq/EpCixWsyPXC7tbU7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZwP3f38; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZwP3f38"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED7BC116C6;
	Thu, 26 Feb 2026 13:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113881;
	bh=XMWruOYLkxF4dZAR02/HIKIt+BPClxko2uWALy0QcoI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qZwP3f38uKfGB9fq7IYo9TahVOr4ZYqbWZ3EleDaFyAIcdPKLxjizwC4CDqnxZnhO
	 /SIBVkvhQyjW8zT/LzxL4sVsmsnduB2JeLOPPUnUbDnyNkn/efD0huJjkmYQPujb+I
	 3z7vUUCIIsBxNG8m5EfjbCrTwRbI3C7m5Hvo+MeVHM7QClUoZYIrCxrbZ4ya4G+nS0
	 0EQs7/oUZZi/pI0MuSk/g1EndWylKco4Wf9Q4h41Sp8MHFNDYvK8/EqmFZoOxvweSB
	 VxQIsH5RGPAGSCCQc2jQlzVB92DsKqxraJfU6WBh+6GEGFmFn/+mVbiQ7kdtfcx+WJ
	 tYQBLQYkMFF7Q==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Feb 2026 14:51:03 +0100
Subject: [PATCH v5 5/6] selftests/pidfd: add CLONE_NNP tests
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-work-pidfs-autoreap-v5-5-d148b984a989@kernel.org>
References: <20260226-work-pidfs-autoreap-v5-0-d148b984a989@kernel.org>
In-Reply-To: <20260226-work-pidfs-autoreap-v5-0-d148b984a989@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=4306; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XMWruOYLkxF4dZAR02/HIKIt+BPClxko2uWALy0QcoI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQu8D9ddnibmWbDlzJ5Z97z+T2KOyUCArnzy1mCXFX+F
 M5WfVDQUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJFpkxkZzsrlZHq8zkgIyxN8
 vezFx9AuIfZbgSkCxvP+m9ecbrrxhOF/2fGXK/3D+V0vrDyY3hfc9mO2ia+Sx/Us0Q0a97NfTTn
 PCQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add tests for the new CLONE_NNP flag:

- nnp_sets_no_new_privs: Verify a child created with CLONE_NNP has
  no_new_privs set while the parent does not.

- nnp_rejects_thread: Verify CLONE_NNP | CLONE_THREAD is rejected
  with -EINVAL since threads share credentials.

- autoreap_no_new_privs_unset: Verify a plain CLONE_AUTOREAP child
  does not get no_new_privs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../testing/selftests/pidfd/pidfd_autoreap_test.c  | 126 +++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/tools/testing/selftests/pidfd/pidfd_autoreap_test.c b/tools/testing/selftests/pidfd/pidfd_autoreap_test.c
index e230d2fe4a64..5fb11230fb07 100644
--- a/tools/testing/selftests/pidfd/pidfd_autoreap_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_autoreap_test.c
@@ -26,6 +26,10 @@
 #define CLONE_AUTOREAP 0x400000000ULL
 #endif
 
+#ifndef CLONE_NNP
+#define CLONE_NNP 0x1000000000ULL
+#endif
+
 static pid_t create_autoreap_child(int *pidfd)
 {
 	struct __clone_args args = {
@@ -493,4 +497,126 @@ TEST(autoreap_no_inherit)
 	close(pidfd);
 }
 
+/*
+ * Test that CLONE_NNP sets no_new_privs on the child.
+ * The child checks via prctl(PR_GET_NO_NEW_PRIVS) and reports back.
+ * The parent must NOT have no_new_privs set afterwards.
+ */
+TEST(nnp_sets_no_new_privs)
+{
+	struct __clone_args args = {
+		.flags		= CLONE_PIDFD | CLONE_AUTOREAP | CLONE_NNP,
+		.exit_signal	= 0,
+	};
+	struct pidfd_info info = { .mask = PIDFD_INFO_EXIT };
+	int pidfd = -1, ret;
+	struct pollfd pfd;
+	pid_t pid;
+
+	/* Ensure parent does not already have no_new_privs. */
+	ret = prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0);
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("Parent already has no_new_privs set, cannot run test");
+	}
+
+	args.pidfd = ptr_to_u64(&pidfd);
+
+	pid = sys_clone3(&args, sizeof(args));
+	if (pid < 0 && errno == EINVAL)
+		SKIP(return, "CLONE_NNP not supported");
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/*
+		 * Child: check no_new_privs. Exit 0 if set, 1 if not.
+		 */
+		ret = prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0);
+		_exit(ret == 1 ? 0 : 1);
+	}
+
+	ASSERT_GE(pidfd, 0);
+
+	/* Parent must still NOT have no_new_privs. */
+	ret = prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0);
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("Parent got no_new_privs after creating CLONE_NNP child");
+	}
+
+	/* Wait for child to exit. */
+	pfd.fd = pidfd;
+	pfd.events = POLLIN;
+	ret = poll(&pfd, 1, 5000);
+	ASSERT_EQ(ret, 1);
+
+	/* Verify child exited with 0 (no_new_privs was set). */
+	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
+	ASSERT_EQ(ret, 0);
+	ASSERT_TRUE(info.mask & PIDFD_INFO_EXIT);
+	ASSERT_TRUE(WIFEXITED(info.exit_code));
+	ASSERT_EQ(WEXITSTATUS(info.exit_code), 0) {
+		TH_LOG("Child did not have no_new_privs set");
+	}
+
+	close(pidfd);
+}
+
+/*
+ * Test that CLONE_NNP with CLONE_THREAD fails with EINVAL.
+ */
+TEST(nnp_rejects_thread)
+{
+	struct __clone_args args = {
+		.flags		= CLONE_NNP | CLONE_THREAD |
+				  CLONE_SIGHAND | CLONE_VM,
+		.exit_signal	= 0,
+	};
+	pid_t pid;
+
+	pid = sys_clone3(&args, sizeof(args));
+	ASSERT_EQ(pid, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
+/*
+ * Test that a plain CLONE_AUTOREAP child does NOT get no_new_privs.
+ * Only CLONE_NNP should set it.
+ */
+TEST(autoreap_no_new_privs_unset)
+{
+	struct pidfd_info info = { .mask = PIDFD_INFO_EXIT };
+	int pidfd = -1, ret;
+	struct pollfd pfd;
+	pid_t pid;
+
+	pid = create_autoreap_child(&pidfd);
+	if (pid < 0 && errno == EINVAL)
+		SKIP(return, "CLONE_AUTOREAP not supported");
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		/*
+		 * Child: check no_new_privs. Exit 0 if NOT set, 1 if set.
+		 */
+		ret = prctl(PR_GET_NO_NEW_PRIVS, 0, 0, 0, 0);
+		_exit(ret == 0 ? 0 : 1);
+	}
+
+	ASSERT_GE(pidfd, 0);
+
+	pfd.fd = pidfd;
+	pfd.events = POLLIN;
+	ret = poll(&pfd, 1, 5000);
+	ASSERT_EQ(ret, 1);
+
+	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
+	ASSERT_EQ(ret, 0);
+	ASSERT_TRUE(info.mask & PIDFD_INFO_EXIT);
+	ASSERT_TRUE(WIFEXITED(info.exit_code));
+	ASSERT_EQ(WEXITSTATUS(info.exit_code), 0) {
+		TH_LOG("Plain autoreap child unexpectedly has no_new_privs");
+	}
+
+	close(pidfd);
+}
+
 TEST_HARNESS_MAIN

-- 
2.47.3

