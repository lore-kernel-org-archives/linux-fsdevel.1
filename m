Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7ED381EA7
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790406061; cv=none; b=R4z1VUY0ikUxnbdkfRfj8kNQoDTqTYGFcBO7f93nh5XN5qIybCFa2hu0MUWque2WkrPbgs27FRQ5KZPylaZqGHwAatYjxqsyZlhzuT/11CrnF9EFBTeF/Dful0T2gGf5YHzQEaeDuwGftrtoAxgbu4+USZlT3aVyTWfrFhRBsA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790406061; c=relaxed/simple;
	bh=SBZEM4eixy9EH9qcDy5q/DL1eUZ0Z/4uyOzur4eGZro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pmKyhxijfWD759LEZz4rgH2B1PBK2wSjr77KwFcIEHomvB1JrGtAmJrYBPjgq+TE1McFqd+jGd3AnH/C70IE8v7t+ejHtlA5I1vtXydEJx+2cgebB+uoxASUm4sfNlbo+Me1bxDgQohPSECDAaP4/9XYO7IUiO2Gu+ihow0TPMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gka2SF3Y; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gka2SF3Y"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c08393b0so676101a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 00:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790406059; x=1791010859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OnL76jpHr7vBDo6mf67vFeDAqzHFwrvodH62utIq19k=;
        b=Gka2SF3Y2D1Vol3QKPz38uRrRQQbr0d6jt1DQ+a03cAgrAsIBjzGF30879xUJkjYhF
         dGy7RhHrMIU2vz3LNlN+aMSwKUsLJFDzrRL8jfMNReP+ajr0fyw3gWpsWQJhohUB1r5C
         CY7K+fti+aFYCHzyglCyBvTWsnNBLeezn6S9Uoc9P6IWqlLmlwgXEEIn0s6lWRnSz4eM
         2cwW7Vxsx2A1LS0U0EtJU63Jq8BVOze8OqPNCgUtCi3HC4S2CbJJ9nqvHiuXLzOnw1sD
         x9gpRT/hxu+6CsB74mg/jd/i3xUJpNN6fFkNHJ5/xM30Ibw1CO1soi6N/Gfzx5zat9ZW
         kRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790406059; x=1791010859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OnL76jpHr7vBDo6mf67vFeDAqzHFwrvodH62utIq19k=;
        b=WhOJQNKLHP7xplS56JOeEMyyEW3ZALyX4eSu06cp8fc2PL9IZ5rZJztb7iRC/+d3vJ
         jNsRoiCSXNqWkYt5hqzwvjpBTyzIvXWzjtLeTjKNPXtujleIfM4yKUX6SIVU1fOuXU3M
         d4gYcYF5YgiHntwPaWp+wUX7yhrCafaSjsCOU3KX6HMHRfvmfx9L2hdIjkNI88eEfIi9
         hYS11FAf7poZ4NmajSlVPAUpsmuqC7/NH3pcfo4Gg1SlEbvc0+Mol2O28etTTWuM1qh0
         m1gHVA8Q8jGvt4oCUWwV6KrdUSycZWPPU6U4ElrLuaWGIm1pe+WaojaD1O4TC0uTNnuN
         miqg==
X-Forwarded-Encrypted: i=1; AKwUvBz+seRDxGggZcDZyMkJCTs7wqJLaf3O+C2ygXZpJsoaxCXAX2zbHQgFcK0OGqWjzb+4gwn16eXb6h86T50I@vger.kernel.org
X-Gm-Message-State: AFuF++l5qdmAd9WEO8p5cCwYHkh+7M8p5awLTNfEeHCN2nTLDfVuSq8d
	fcmHgbsCKV75qN62YNSW8oAzAyh+FVA7u3yyKoigP9XlNDd1aBdsJtPHTNc5R+q9
X-Gm-Gg: AYBFou0KTsyuzj4AkUrk2xL0Jar5bpiYSeoedvV41rzYFI8sIOujjVBntlyW/L6Yd6d
	A49oaDhNZuL7bXgK2ZJkbkTRLBXBHIRCN3l5Rv1l1csC9b9B0mng6e+cbSh7ofVWK+3DCCv8eUQ
	VDjeO6965mivLAkNZSwsWYaUwTMT4Qw5zYePH///Bo2uYEZvt/MFeSuzgk8meWVEJtnxy4KT1rE
	zKKhb0jzhwqa8fJfdf/Skz1KYfz7QOKJ3ZXXNOQXiGv5goEtXhUvkfZoCptDv8NleL7t5JaEHtX
	qSAgOhCJ5TwKHQgBtHhNsD6QImSEx5VWkeNMk0zb47NTgJ6LqirxcaoS4BbkMszUBc2Sg80oTx0
	HIuBu9R0W2KeZHqdeXFqXp+9zg0tmeqHHaOju0CxkgCIv9lrgF2B1mZMUg4yuLWpRfmz/yxAif0
	5kySDD/40RNzsBb8XugTzWLZ4rbS65treQoe6ozclixDh05yHJet1gGEcvQCmzkOMlpp1cQQ==
X-Received: by 2002:a17:90b:3e4d:b0:3a0:da60:813e with SMTP id 98e67ed59e1d1-3a0da6082ffmr1187847a91.34.1790406058759;
        Sat, 26 Sep 2026 00:00:58 -0700 (PDT)
Received: from [10.1.2.130] ([67.185.120.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec5d0sm15987119a91.4.2026.09.26.00.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:00:58 -0700 (PDT)
From: Kir Kolyshkin <kolyshkin@gmail.com>
Date: Sat, 26 Sep 2026 00:00:54 -0700
Subject: [PATCH v2 2/2] selftests/filesystems: test
 OPEN_TREE_DROP_MNTNS_MOUNTS
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-nsfs-prune-rfc-v2-2-53509260e4e7@gmail.com>
References: <20260926-nsfs-prune-rfc-v2-0-53509260e4e7@gmail.com>
In-Reply-To: <20260926-nsfs-prune-rfc-v2-0-53509260e4e7@gmail.com>
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
 .../filesystems/open_tree_ns/open_tree_ns_test.c   | 183 +++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_test.c b/tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_test.c
index 82f3c8c02c9a..05d16c56ab35 100644
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
@@ -1004,4 +1009,182 @@ TEST_F(open_tree_ns_unbindable, recursive_skips_on_unbindable)
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
+			   OPEN_TREE_CLOEXEC);
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

