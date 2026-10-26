Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793048049;
	b=R7Lh8mNfMZb6fT6ul8M7oueE+0FukF85Z2b26zFqcFSKGmGaMX0/RJMMm8fuXfubBfeM
	 ZlY4YS5dO8zXJrqd1o8Jv6Le3/tFw6l9KzfFu/UmBo794PCFo4aEcBnhLWUFgI2HyTOce
	 +thXxOSpCBlZuVAmUQYuI0H5iCBQoOzOjJVYiTuRNzcgOZ9zZVHFy3/QyoJ4vMo9PNybo
	 U/JUfbp9U66Q7n/erAwZ3eDoScuttiKlC5BF5Kf7xfhOLzcicbYw+vqWVr2iEQScFiKWc
	 kZkF/bf4RhzPyjnp5JjbNV9M+CcB7hoqXsKPchOKeeVmxDSaL6ZDDrApbPyvY1FX5fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793048049;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=bMnT/4trapZ7pJUm3w1Qwlc7Feo2DJc90apJ/xjlYRs=;
	b=I4hakiTAS9ZhuvylqOd862dScdL4BLFxqHaudBM+lYXt74QDqq1MVwketmXC0x/Q7sNk
	 BiymgP9S04lUC77FVblhnIA9ZycACdPJZrGlN0ofGR2dePBgwrps+4JoygB3gDjY+rU7s
	 feqIme43jxPXPihZO1feneqcz1AKIewo8dobXuBt8S3ItVYV4LfJRPRVArtkqgCAOqPeh
	 SiXfC8PzzbN1e27U7Liwhlo2nclpXg9KccBz1th+REgIRGrl6UWX8jB5U0MYRKIzJoWnS
	 90pDKlMP0M1l1bbfk1BbCFQ4jRtR/10GG981LXKvV/9gfaOKYlrNSjwHlLi8Kx0i/Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPb67244;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FFB606A31D;
	Mon, 26 Oct 2026 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XPb67244
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBC61F01829;
	Mon, 26 Oct 2026 20:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793048048;
	bh=bMnT/4trapZ7pJUm3w1Qwlc7Feo2DJc90apJ/xjlYRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XPb67244qTZDbAZwCKsjKX7Wa43nK9Yl31/j58LBJZCBq1c61pQCUJCUnj1+RkLuz
	 KCa2wz280Wxv+llBXjpmtki+bWqrp/LxirJXr6cmYGNJd6ECSUNMCKwwXY1RpuYs9e
	 bJB6A7vT9iez9Cqx1124jczOaQac9gqrMtwb427/MIYaC/ZlFXk2q0YY8uNf30KfCt
	 xBByToK7cwWUPVtzPT9WdpVyt7QbNMzKxO1hRf5OfwcIMhNdK5/K2WV6tsNSIXACy5
	 gIyIsh0BR6sAbzh8f9RhgdPZnzQCk94hUiYki3hqJaUb/9YJppO1B7XXqVRCmKIyGS
	 wM29CWwVkcFcQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 26 Oct 2026 21:53:30 +0100
Subject: [PATCH 2/2] selftests/exec: check that user namespaces keep the
 exec securebits
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261026-work-securebits-userns-v1-2-b35473fa1a34@kernel.org>
References: <20261026-work-securebits-userns-v1-0-b35473fa1a34@kernel.org>
In-Reply-To: <20261026-work-securebits-userns-v1-0-b35473fa1a34@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3798; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nECyytmiEdouw3xcpnbysOjPPBsO49O6sByTJMX2B9o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTd3/si/8v/bbE/rqxrm8J9h9dyM4d8+sG9j31/as0M2
 zupTibuXkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEXoQzMtxSY3BOvzR9j14m
 p4rLmem74+TF0950hax6ue3H1Fe6yh0M/0tr7FNP1J3WFqhbPEE9k3PhIZetqod+77taYufnprD
 xMzcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Check that the exec securebits survive creating a user namespace with
unshare(CLONE_NEWUSER) and joining one with setns():

- both bits with their locks, which can't be changed in there
- both bits without their locks, which can still be cleared in there
- only the locks, which keep the bits from being set in there

The other securebits are reset as before.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/exec/check-exec.c | 83 +++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tools/testing/selftests/exec/check-exec.c b/tools/testing/selftests/exec/check-exec.c
index f2397e75aa7c..5753c657808e 100644
--- a/tools/testing/selftests/exec/check-exec.c
+++ b/tools/testing/selftests/exec/check-exec.c
@@ -10,11 +10,13 @@
  * Author: Mickaël Salaün <mic@digikod.net>
  */
 
+#define _GNU_SOURCE
 #include <asm-generic/unistd.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/prctl.h>
 #include <linux/securebits.h>
+#include <sched.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/capability.h>
@@ -24,6 +26,7 @@
 #include <sys/stat.h>
 #include <sys/syscall.h>
 #include <sys/sysmacros.h>
+#include <sys/wait.h>
 #include <unistd.h>
 
 /* Defines AT_EXECVE_CHECK without type conflicts. */
@@ -460,4 +463,84 @@ TEST_F(secbits, restrict_locked_unset)
 	CHILD(EXPECT_EQ(EPERM, test_secbits_set(0)));
 }
 
+static const unsigned int exec_bits = SECBIT_EXEC_RESTRICT_FILE |
+				       SECBIT_EXEC_DENY_INTERACTIVE;
+static const unsigned int exec_locks = SECBIT_EXEC_RESTRICT_FILE_LOCKED |
+					SECBIT_EXEC_DENY_INTERACTIVE_LOCKED;
+
+/*
+ * Checks that the exec securebits in @exec survive creating and joining a user
+ * namespace, and that in there they can be changed exactly when they are not
+ * locked.
+ */
+static void test_userns(struct __test_metadata *const _metadata,
+			const unsigned int exec)
+{
+	const int error = (exec & exec_locks) ? EPERM : 0;
+	int ready[2], done[2], userns_fd, status;
+	char path[64], c = 0;
+	pid_t pid;
+
+	/* A user namespace owned by us to join later. */
+	ASSERT_EQ(0, pipe(ready));
+	ASSERT_EQ(0, pipe(done));
+	pid = fork();
+	ASSERT_LE(0, pid);
+	if (pid == 0) {
+		close(ready[0]);
+		close(done[1]);
+		if (unshare(CLONE_NEWUSER))
+			_exit(1);
+		if (write(ready[1], &c, 1) != 1)
+			_exit(1);
+		if (read(done[0], &c, 1) < 0)
+			_exit(1);
+		_exit(0);
+	}
+	close(ready[1]);
+	close(done[0]);
+	if (read(ready[0], &c, 1) != 1) {
+		waitpid(pid, &status, 0);
+		SKIP(return, "Cannot create a user namespace");
+	}
+
+	snprintf(path, sizeof(path), "/proc/%d/ns/user", pid);
+	userns_fd = open(path, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, userns_fd);
+
+	EXPECT_EQ(0, test_secbits_set(prctl(PR_GET_SECUREBITS) | exec));
+
+	/* Creating a user namespace keeps them... */
+	CHILD(EXPECT_EQ(0, unshare(CLONE_NEWUSER));
+	      EXPECT_EQ(exec, prctl(PR_GET_SECUREBITS));
+	      EXPECT_EQ(error, test_secbits_set(exec ^ exec_bits));
+	      EXPECT_EQ(error, test_secbits_set(0)));
+
+	/* ...and so does joining one. */
+	CHILD(EXPECT_EQ(0, setns(userns_fd, CLONE_NEWUSER));
+	      EXPECT_EQ(exec, prctl(PR_GET_SECUREBITS));
+	      EXPECT_EQ(error, test_secbits_set(exec ^ exec_bits));
+	      EXPECT_EQ(error, test_secbits_set(0)));
+
+	close(userns_fd);
+	close(done[1]);
+	EXPECT_EQ(pid, waitpid(pid, &status, 0));
+	close(ready[0]);
+}
+
+TEST_F(secbits, userns_locked)
+{
+	test_userns(_metadata, exec_bits | exec_locks);
+}
+
+TEST_F(secbits, userns_unlocked)
+{
+	test_userns(_metadata, exec_bits);
+}
+
+TEST_F(secbits, userns_lock_only)
+{
+	test_userns(_metadata, exec_locks);
+}
+
 TEST_HARNESS_MAIN

-- 
2.53.0

