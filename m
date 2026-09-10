Received: from mta0.migadu.com (out-74.mta0.migadu.com [91.218.175.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8152DF144
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 00:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789000646; cv=none; b=iaSed4C4z8eiaro2Q/QrxjhWNlBqWGqbFHTutjf8gwlii6XFFQwjuCU1jFA18g1wvtn/sIrComCIRQoa3JZpn3i7UIGr5ZOy9ajLF1CMNxC97vXw9kcMNyWrZaE+tfet9OOl3ZPDZRM3GHxseTE5Igr9JBPdOX6Sh+3eW+SVTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789000646; c=relaxed/simple;
	bh=zzpjwUswTpyP7wYlZgMyj5G/NFUunoQdPWTRIzTl6y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDqgmCpTl3W2yBqZaqAZDaasutpykcBcT82Ihu72QMgDPpR4XFv5Knyrq4w956gDT7MIewcvg1H9/iicVjgENKB5eFRRrfvQmVUJFzqUT3gOb4BvwTNn0+rszh62l0Iii3X7qJG/qNS2UMhcr7YL2YKF83Gml212ZwX8aGokpSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=coBrfMfo; arc=none smtp.client-ip=91.218.175.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="coBrfMfo"
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zzpjwUswTpyP7wYlZgMyj5G/NFUunoQdPWTRIzTl6y4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789000642; v=1; x=1789605442;
 b=coBrfMfoZqFV+JnTschN94anQXzG2OClqhI4DP7TwgUu6ew7MYIqMQIpe0xjzhb4Mi4OC+1u
 kC/nG0XZplE6TNdFo7k+iA3UA8AQceobUPKZbR44RJcBlJouGHzfGCPPfmjGbNZKInuqworTNBE
 cCReVHEeU6Zn1Htbpn2cSKv8=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a5b9adec7da825de;
	Thu, 10 Sep 2026 00:37:22 +0000
X-Mizu-Trace-ID: a5b9adec7da825de
X-Migadu-Flow: FLOW_OUT
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Christian Brauner <christian@brauner.io>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Meta kernel team <kernel-team@meta.com>,
	linux-fsdevel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] selftests: cover readdir resuming at a removed entry
Date: Wed,  9 Sep 2026 17:36:50 -0700
Message-ID: <20260910003650.1680854-4-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910003650.1680854-1-shakeel.butt@linux.dev>
References: <20260910003650.1680854-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernfs tests list only directories that do not change, so nothing
covers the entry a listing stopped on being gone when it comes back.

readdir_resume_at_removed_entry takes a telldir(3) cookie for every
entry, then removes each entry in turn, seeks to its cookie and reads
the rest; nothing reported before it may come back.  This is a resume
between two getdents(2) calls, and it fails without "kernfs: don't
repeat or skip an entry when readdir resumes".

readdir_resume_vs_internal_remove is a resume inside one call, which
"kernfs: don't hold kernfs_rwsem across dir_emit()" opens.  It churns
cgroup.subtree_control rather than calling rmdir(2), which cannot reach
that window because iterate_dir() holds the listed directory's i_rwsem
for the whole listing.  It is a stress test, has not been seen to catch
the ordering bug, and keeps the window busy for lockdep and KASAN.  It
fails if the churn died and skips if the listings never overlapped it,
so it cannot pass having listed a static directory.

Assisted-by: LLM
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 .../selftests/filesystems/kernfs_test.c       | 200 ++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/tools/testing/selftests/filesystems/kernfs_test.c b/tools/testing/selftests/filesystems/kernfs_test.c
index 6e74da91ebca..01cd58e5e41e 100644
--- a/tools/testing/selftests/filesystems/kernfs_test.c
+++ b/tools/testing/selftests/filesystems/kernfs_test.c
@@ -8,6 +8,7 @@
 #include <limits.h>
 #include <net/if.h>
 #include <sched.h>
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -17,6 +18,7 @@
 #include <sys/mount.h>
 #include <sys/socket.h>
 #include <sys/stat.h>
+#include <sys/syscall.h>
 #include <sys/xattr.h>
 
 #include "kselftest_harness.h"
@@ -472,6 +474,204 @@ TEST_F(kernfs_cgroup, readdir_no_duplicates)
 			EXPECT_STRNE(names[i], names[j]);
 }
 
+#define RESUME_DIRS	24
+
+/*
+ * Resuming at an entry that has gone must carry on after it, never before.
+ * Take a cookie for every entry, then remove each one, seek to its cookie
+ * and read the rest; nothing already reported may come back.
+ */
+TEST_F(kernfs_cgroup, readdir_resume_at_removed_entry)
+{
+	/* The cgroup's own control files are listed alongside ours. */
+	char names[128][NAME_MAX + 1];
+	long pos[128];
+	char path[PATH_MAX];
+	struct dirent *de;
+	int n = 0, i, j;
+	DIR *d;
+
+	for (i = 0; i < RESUME_DIRS; i++) {
+		snprintf(path, sizeof(path), "%s/e%02d", self->scratch, i);
+		ASSERT_EQ(mkdir(path, 0755), 0);
+	}
+
+	/* Record the cookie before reading each entry, with its name. */
+	d = opendir(self->scratch);
+	ASSERT_NE(d, NULL);
+	while (1) {
+		long here = telldir(d);
+
+		de = readdir(d);
+		if (!de)
+			break;
+		if (!strcmp(de->d_name, ".") || !strcmp(de->d_name, ".."))
+			continue;
+		ASSERT_LT(n, (int)ARRAY_SIZE(pos));
+		pos[n] = here;
+		strncpy(names[n], de->d_name, NAME_MAX);
+		names[n][NAME_MAX] = '\0';
+		n++;
+	}
+	closedir(d);
+	ASSERT_GT(n, 1);
+
+	for (i = 0; i < n; i++) {
+		/* Only the directories we made can be removed and put back. */
+		if (strncmp(names[i], "e", 1))
+			continue;
+
+		snprintf(path, sizeof(path), "%s/%s", self->scratch, names[i]);
+		ASSERT_EQ(rmdir(path), 0);
+
+		/* Reopen so the seek has to reach the kernel. */
+		d = opendir(self->scratch);
+		ASSERT_NE(d, NULL);
+		seekdir(d, pos[i]);
+		while ((de = readdir(d))) {
+			if (!strcmp(de->d_name, ".") || !strcmp(de->d_name, ".."))
+				continue;
+			for (j = 0; j < i; j++)
+				ASSERT_STRNE(de->d_name, names[j])
+					TH_LOG("resuming at %s (gone) went back to %s",
+					       names[i], names[j]);
+		}
+		closedir(d);
+
+		ASSERT_EQ(mkdir(path, 0755), 0);
+	}
+
+	for (i = 0; i < RESUME_DIRS; i++) {
+		snprintf(path, sizeof(path), "%s/e%02d", self->scratch, i);
+		EXPECT_EQ(rmdir(path), 0);
+	}
+}
+
+#define CHURN_ROUNDS	400
+#define CHURN_BUFSZ	512	/* small, so a listing takes several calls */
+
+/*
+ * The files appear at the end of the enabling write and go at the start of
+ * the disabling one, so the window where they exist is the short one.
+ */
+#define CHURN_DWELL_ON	2000
+#define CHURN_DWELL_OFF	200
+
+struct kernfs_dirent64 {
+	unsigned long long	d_ino;
+	long long		d_off;
+	unsigned short		d_reclen;
+	unsigned char		d_type;
+	char			d_name[];
+};
+
+/*
+ * The same resume, but inside one getdents(2) call.  rmdir(2) cannot reach
+ * that window because iterate_dir() holds the listed directory's i_rwsem
+ * for the whole listing; cgroup.subtree_control can, having no VFS
+ * operation on the names it adds and removes.  The files that are not the
+ * controller's stay throughout, so each must appear exactly once.
+ *
+ * A stress test: it has not been seen to catch the ordering bug, and is
+ * here to keep the unlocked window under load for lockdep and KASAN.
+ */
+TEST_F(kernfs_cgroup, readdir_resume_vs_internal_remove)
+{
+	char buf[CHURN_BUFSZ] __attribute__((aligned(8)));
+	char stable[128][NAME_MAX + 1];
+	int nstable = 0, i, r;
+	int withctl = 0, without = 0;
+	int seen[128], status;
+	pid_t churner;
+	DIR *d;
+
+	/* With the controller off, whatever is left is what must persist. */
+	ASSERT_EQ(write_file(self->scratch_sc, self->disable), 0);
+	d = opendir(self->child);
+	ASSERT_NE(d, NULL);
+	for (;;) {
+		struct dirent *de = readdir(d);
+
+		if (!de)
+			break;
+		if (!strcmp(de->d_name, ".") || !strcmp(de->d_name, ".."))
+			continue;
+		ASSERT_LT(nstable, (int)ARRAY_SIZE(stable));
+		strncpy(stable[nstable], de->d_name, NAME_MAX);
+		stable[nstable][NAME_MAX] = '\0';
+		nstable++;
+	}
+	closedir(d);
+	ASSERT_GT(nstable, 0);
+
+	churner = fork();
+	ASSERT_GE(churner, 0);
+	if (churner == 0) {
+		for (;;) {
+			if (write_file(self->scratch_sc, self->enable))
+				_exit(10);
+			usleep(CHURN_DWELL_ON);
+			if (write_file(self->scratch_sc, self->disable))
+				_exit(11);
+			usleep(CHURN_DWELL_OFF);
+		}
+	}
+
+	for (r = 0; r < CHURN_ROUNDS; r++) {
+		int fd = open(self->child, O_RDONLY | O_DIRECTORY);
+		int extra = 0;
+		int n;
+
+		ASSERT_GE(fd, 0);
+		memset(seen, 0, sizeof(seen));
+
+		while ((n = syscall(SYS_getdents64, fd, buf, sizeof(buf))) > 0) {
+			int off = 0;
+
+			while (off < n) {
+				struct kernfs_dirent64 *de = (void *)(buf + off);
+				bool known = false;
+
+				off += de->d_reclen;
+				for (i = 0; i < nstable; i++)
+					if (!strcmp(de->d_name, stable[i])) {
+						seen[i]++;
+						known = true;
+					}
+				if (!known && strcmp(de->d_name, ".") &&
+				    strcmp(de->d_name, ".."))
+					extra++;
+			}
+		}
+		ASSERT_GE(n, 0);
+		EXPECT_EQ(close(fd), 0);
+
+		if (extra)
+			withctl++;
+		else
+			without++;
+
+		for (i = 0; i < nstable; i++)
+			ASSERT_EQ(seen[i], 1)
+				TH_LOG("round %d: %s seen %d times",
+				       r, stable[i], seen[i]);
+	}
+
+	/* The churn must have been running, or the listings prove nothing. */
+	EXPECT_EQ(kill(churner, SIGKILL), 0);
+	ASSERT_EQ(waitpid(churner, &status, 0), churner);
+	ASSERT_TRUE(WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL)
+		TH_LOG("churner exited on its own: status %d", status);
+
+	/*
+	 * They also have to have overlapped it.  How much depends on the
+	 * machine, so say the race could not be arranged rather than fail.
+	 */
+	if (!withctl || !without)
+		SKIP(return, "listings did not span the churn: %d with, %d without",
+		     withctl, without);
+}
+
 /*
  * A telldir() cookie must resolve back to the same entry after seekdir().
  * kernfs encodes the cookie as the node's name hash, so this covers
-- 
2.53.0-Meta

