Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4A53F7AAB
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791354255; cv=none; b=kMNHDdhDmOmZyDjw/sY1aiU2DcreuRIjVbjUo2r/3ukZPLcB9K4uXgz6XWFBEN19e0NM6s/fjEgVoJN39fGIpq4albmaJl/vOU3dmAm/7LYp6AnFYGpA0EOVMVYbgTbmopoTTxHQQqm8GncUq7shZK2knjpxV7k9wKLswpILJaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791354255; c=relaxed/simple;
	bh=yKbAdIAk7lKrKeJFecFIjKC9cXzZzNASgcbnD3ik2g8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rGEtUKdCueavGdH5Ky3XHbYXVkEm0jA+6xUVxNHcRWlfW/NWhUbUUo6IutxdpRbmWDnGvByrXUrImHfu/+zw6GsNl80iZ2ybIxCUN7ZaCpnHtXdjUWu7rHIJfWlQzaGaJwAalGbc7lNuWd9RRDHTvpaUEIfHnAk3XwO142rxUeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNut9uxh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNut9uxh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e61ac64ec3so328795ad.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 23:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791354254; x=1791959054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bul8Yte339vRqTq5tYRzTAT8u64iOZDpcCOd5xkxOQM=;
        b=YNut9uxhIwSRxHcf2orrcRCHETwBpxD9CVIMdVizKZvpE451CLIO6KTrGKkUx2f718
         J4dH/PY+3h6jye98Hi73AtAzfVuurGxw1jAWX7A2zYnbrD0t9KmDoipIoXqdvW1pPdEg
         isqNsCUJuj/nU4B0NPbZ/3k/KQ9srH+vygF1ldla3FGxkzGofy9+o2sQr5SzFADZqQXh
         n0Lz4GYafkvBxRg5RlViSgyU6/Xp/uCYUdlCAbTR201TRcScwFscVxjnnhYdQumiCsmj
         OHlhXMEJUDKipQXliuuXD3uHB+fdu31sGgAQhLkVVPwU+5vGygTT471x8P0cZxnlYM99
         +vsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791354254; x=1791959054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bul8Yte339vRqTq5tYRzTAT8u64iOZDpcCOd5xkxOQM=;
        b=pU+KAzFx5/xIDNB77NR9AEfE2gQZVbBawTQ9Kjd6gi+PN3UCC08Sf+NTOdRrKVvF5e
         MOWe+fIGA2T6YBt13s/EA2hWNVoGJ4G9OZRr1zQB7m0nIJy27ED8IQYxMgbcOt6gBeYp
         RuwYAo7yoBTdrNrZ0b00KGsc3Ec+z3miS7/kkU4CR0txfd5F+0l/27gyJpvrpqqLVdfq
         eiNXXoRwdRDkOc3Zl9dboWTZp7/0Byms58tn/RBZVrTb91vtGwSssN0ve9XZfa3TzOLx
         E3DIqJc0qDrelWky1j86jTG+q6p9NmqqrXX7COqI29ljj9rUWx58hCQdauTRX3RvUYXm
         sxhQ==
X-Forwarded-Encrypted: i=1; AKwUvByEOVFYwFR5GRonYeQKHSSdMYnt+ry3BK9sDj4oVWOEQB0gfReIyGvQ2bn2C8VNU/gDwrWVVSncZAIsNptc@vger.kernel.org
X-Gm-Message-State: AFq9FYLmwyruxF98st/IXUYhSBuCwjRtlXpHnb4lGkMN1cQqbT5FCHfO
	a00T5bl3uhcSZvNIVnAhlWah8ZpcoYl1hvsGDfN2WkYAwxWr9K7XYtXq
X-Gm-Gg: AYBFou1TvKirNh/czzPTz46ORLQUrakszbS9WACsNkmKv5KPtHaLqI5VRKHqbOBvY3q
	6k1zV7fGGoVs/lUNlfzuf+q8Taolb26gQW9UHOWmekloJwbY06oFVO3IDeSFfHoQsH9BzJjtZdx
	qLCGpNjOm6vpCGilhNERDnNJNDKl3Egh8KR+GE8r3RioIvh0KBm3KIH8qhbjl6TRC6bIuR5QSla
	gHyy1ui7ylNXqtxEvmv2kQCjWW3XDVHIS+th3lxjAhKYeM0NNk4Nzcufh0NnA+FTTJKMY3aFb1P
	1CEYYnZme0EARMvggP+P1E1aJ0KigepKP55wWGSQBUyok6CcEFhsn+nj0w4+4TWoY30vmLn4E2W
	7fdMjlZpN0KdJ0QiAdbeE8suwZ+8a/+oNwnsoavABWZWQZfJmguhnsOb+bjzOG1LZ2blDgU44uv
	JCRHV+wp1+D01YmGEASGZRd3/1nTmTj6GYPBxubY2w4yG6R49+s8jGcDhBb9IcGLVOTKYRyQ==
X-Received: by 2002:a17:902:f70c:b0:2d7:107c:917b with SMTP id d9443c01a7336-2e5ff8215acmr14401515ad.0.1791354253676;
        Tue, 06 Oct 2026 23:24:13 -0700 (PDT)
Received: from [10.1.2.130] ([67.185.120.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e60482ccb3sm5303515ad.51.2026.10.06.23.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 23:24:13 -0700 (PDT)
From: Kir Kolyshkin <kolyshkin@gmail.com>
Date: Tue, 06 Oct 2026 23:23:57 -0700
Subject: [PATCH v3 2/2] selftests/filesystems: test
 OPEN_TREE_DROP_MNTNS_MOUNTS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-nsfs-prune-rfc-v3-2-adb97ea52868@gmail.com>
References: <20261006-nsfs-prune-rfc-v3-0-adb97ea52868@gmail.com>
In-Reply-To: <20261006-nsfs-prune-rfc-v3-0-adb97ea52868@gmail.com>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Aleksa Sarai <cyphar@cyphar.com>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
 "Eric W . Biederman" <ebiederm@xmission.com>, 
 David Howells <dhowells@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
 Andrei Vagin <avagin@google.com>, Shuah Khan <shuah@kernel.org>, 
 Giuseppe Scrivano <giuseppe@scrivano.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 containers@lists.linux.dev, Kir Kolyshkin <kolyshkin@gmail.com>
X-Mailer: b4 0.14.3

Pin a mount namespace below a tmpfs mount, the way snapd does under
/run/snapd/ns, and attach a recursive clone of that tmpfs inside a
younger mount namespace created with OPEN_TREE_NAMESPACE.  Without
OPEN_TREE_DROP_MNTNS_MOUNTS move_mount(2) fails with ELOOP; with it,
it succeeds.

Also check that the flag is rejected without OPEN_TREE_CLONE or
OPEN_TREE_NAMESPACE, and accepted with the latter.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Kir Kolyshkin <kolyshkin@gmail.com>
---
 .../filesystems/open_tree_ns/open_tree_ns_test.c   | 193 +++++++++++++++++++++
 1 file changed, 193 insertions(+)

diff --git a/tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_test.c b/tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_test.c
index 82f3c8c02c9a..438054ab6a6a 100644
--- a/tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_test.c
+++ b/tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_test.c
@@ -14,6 +14,7 @@
 #include <limits.h>
 #include <linux/nsfs.h>
 #include <sched.h>
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -32,6 +33,10 @@
 #define OPEN_TREE_NAMESPACE	(1 << 1)
 #endif
 
+#ifndef OPEN_TREE_DROP_MNTNS_MOUNTS
+#define OPEN_TREE_DROP_MNTNS_MOUNTS	(1 << 2)
+#endif
+
 static int get_mnt_ns_id(int fd, uint64_t *mnt_ns_id)
 {
 	if (ioctl(fd, NS_GET_MNTNS_ID, mnt_ns_id) < 0)
@@ -1004,4 +1009,192 @@ TEST_F(open_tree_ns_unbindable, recursive_skips_on_unbindable)
 	close(fd);
 }
 
+/*
+ * Pin a mount namespace at @where, the way snapd does under /run/snapd/ns.
+ * The namespace has to be younger than ours, so a child unshares and the
+ * parent binds the child's namespace file: binding one's own namespace is
+ * refused by the very check this test is about.
+ */
+static int pin_mount_namespace(const char *where)
+{
+	int pipefd[2], status, ret = -1;
+	char path[PATH_MAX];
+	pid_t pid;
+	char c;
+
+	if (pipe(pipefd))
+		return -1;
+
+	pid = fork();
+	if (pid < 0)
+		goto out;
+	if (pid == 0) {
+		close(pipefd[0]);
+		if (unshare(CLONE_NEWNS))
+			_exit(1);
+		/* Tell the parent the namespace exists, then hold it open. */
+		if (write(pipefd[1], "x", 1) != 1)
+			_exit(1);
+		pause();
+		_exit(0);
+	}
+
+	close(pipefd[1]);
+	pipefd[1] = -1;
+	if (read(pipefd[0], &c, 1) != 1)
+		goto out_kill;
+
+	snprintf(path, sizeof(path), "/proc/%d/ns/mnt", pid);
+	if (mount(path, where, NULL, MS_BIND, NULL))
+		goto out_kill;
+
+	ret = 0;
+
+out_kill:
+	kill(pid, SIGKILL);
+	waitpid(pid, &status, 0);
+out:
+	close(pipefd[0]);
+	if (pipefd[1] >= 0)
+		close(pipefd[1]);
+	return ret;
+}
+
+FIXTURE(open_tree_ns_drop_mntns)
+{
+	char dir[64];
+	char pin[PATH_MAX];
+	bool mounted;
+};
+
+FIXTURE_SETUP(open_tree_ns_drop_mntns)
+{
+	int fd, ret;
+
+	self->mounted = false;
+	snprintf(self->dir, sizeof(self->dir), "/tmp/open_tree_ns_drop_mntns.XXXXXX");
+
+	ret = sys_open_tree(-1, NULL, 0);
+	if (ret == -1 && errno == ENOSYS)
+		SKIP(return, "open_tree() syscall not supported");
+
+	/*
+	 * Work in a private mount namespace, so whatever is mounted here,
+	 * the pinned namespace included, goes away with the test process.
+	 */
+	if (unshare(CLONE_NEWNS))
+		SKIP(return, "unshare(CLONE_NEWNS) failed: %s", strerror(errno));
+	ASSERT_EQ(mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+
+	ASSERT_NE(mkdtemp(self->dir), NULL);
+	if (mount("tmpfs", self->dir, "tmpfs", 0, NULL))
+		SKIP(return, "Failed to mount tmpfs");
+	self->mounted = true;
+
+	fd = sys_open_tree(AT_FDCWD, self->dir,
+			   OPEN_TREE_CLONE | OPEN_TREE_DROP_MNTNS_MOUNTS |
+			   AT_RECURSIVE | OPEN_TREE_CLOEXEC);
+	if (fd < 0 && errno == EINVAL)
+		SKIP(return, "OPEN_TREE_DROP_MNTNS_MOUNTS not supported");
+	ASSERT_GE(fd, 0);
+	close(fd);
+
+	snprintf(self->pin, sizeof(self->pin), "%s/ns", self->dir);
+	fd = open(self->pin, O_CREAT | O_RDONLY | O_CLOEXEC, 0600);
+	ASSERT_GE(fd, 0);
+	close(fd);
+	ASSERT_EQ(pin_mount_namespace(self->pin), 0);
+}
+
+FIXTURE_TEARDOWN(open_tree_ns_drop_mntns)
+{
+	if (self->mounted)
+		umount2(self->dir, MNT_DETACH);
+	rmdir(self->dir);
+}
+
+/* Attach @clone_fd at "/" inside the namespace @ns_fd; returns errno. */
+static int move_into_namespace(int clone_fd, int ns_fd)
+{
+	pid_t pid;
+	int status;
+
+	pid = fork();
+	if (pid < 0)
+		return -1;
+	if (pid == 0) {
+		int target;
+
+		if (setns(ns_fd, CLONE_NEWNS))
+			_exit(255);
+		target = open("/", O_PATH | O_DIRECTORY | O_CLOEXEC);
+		if (target < 0)
+			_exit(255);
+		if (sys_move_mount(clone_fd, "", target, "",
+				   MOVE_MOUNT_F_EMPTY_PATH | MOVE_MOUNT_T_EMPTY_PATH))
+			_exit(errno);
+		_exit(0);
+	}
+	if (waitpid(pid, &status, 0) != pid || !WIFEXITED(status))
+		return -1;
+	return WEXITSTATUS(status);
+}
+
+TEST_F(open_tree_ns_drop_mntns, move_into_younger_namespace)
+{
+	int clone_fd, ns_fd;
+
+	ns_fd = sys_open_tree(AT_FDCWD, self->dir,
+			      OPEN_TREE_NAMESPACE | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(ns_fd, 0);
+
+	/*
+	 * Without the flag the clone carries the pinned namespace along,
+	 * and move_mount() refuses it from inside a younger namespace.
+	 */
+	clone_fd = sys_open_tree(AT_FDCWD, self->dir,
+				 OPEN_TREE_CLONE | AT_RECURSIVE | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(clone_fd, 0);
+	EXPECT_EQ(move_into_namespace(clone_fd, ns_fd), ELOOP);
+	close(clone_fd);
+
+	/* With the flag the pinned namespace is left out. */
+	clone_fd = sys_open_tree(AT_FDCWD, self->dir,
+				 OPEN_TREE_CLONE | OPEN_TREE_DROP_MNTNS_MOUNTS |
+				 AT_RECURSIVE | OPEN_TREE_CLOEXEC);
+	ASSERT_GE(clone_fd, 0);
+	EXPECT_EQ(move_into_namespace(clone_fd, ns_fd), 0);
+	close(clone_fd);
+
+	close(ns_fd);
+}
+
+TEST_F(open_tree_ns_drop_mntns, flag_combinations)
+{
+	int fd;
+
+	/* Nothing is copied, so there is nothing to drop. */
+	EXPECT_LT(sys_open_tree(AT_FDCWD, self->dir,
+				OPEN_TREE_DROP_MNTNS_MOUNTS | OPEN_TREE_CLOEXEC), 0);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* A non-recursive clone has no submounts, so there is nothing to drop. */
+	EXPECT_LT(sys_open_tree(AT_FDCWD, self->dir,
+				OPEN_TREE_CLONE | OPEN_TREE_DROP_MNTNS_MOUNTS |
+				OPEN_TREE_CLOEXEC), 0);
+	EXPECT_EQ(errno, EINVAL);
+	EXPECT_LT(sys_open_tree(AT_FDCWD, self->dir,
+				OPEN_TREE_NAMESPACE | OPEN_TREE_DROP_MNTNS_MOUNTS |
+				OPEN_TREE_CLOEXEC), 0);
+	EXPECT_EQ(errno, EINVAL);
+
+	/* OPEN_TREE_NAMESPACE never copies them; the flag is a no-op there. */
+	fd = sys_open_tree(AT_FDCWD, self->dir,
+			   OPEN_TREE_NAMESPACE | OPEN_TREE_DROP_MNTNS_MOUNTS |
+			   AT_RECURSIVE | OPEN_TREE_CLOEXEC);
+	EXPECT_GE(fd, 0);
+	if (fd >= 0)
+		close(fd);
+}
+
 TEST_HARNESS_MAIN

-- 
2.55.0

