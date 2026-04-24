Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F20B3E1205
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050321; cv=none; b=Jlt/Bu0PVC7HVvHPYQUMKkWCv0qSVC9DYgviF2j/6LDsWJdkBRLCXs+g38EvMzSnox167l8r4Tn4PkkHK8An1pvM30p79FnNxN6kQOn02R/SCMOaG88rj2UD4u/HwirBV9Au8RnqPFgSJ7FZYHXPqeY0wRs1UOGcLGBKIRB0/1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050321; c=relaxed/simple;
	bh=Aj7BP9YMRna5TOGCW52uXq+qBnc/66j8jvCPCR28wSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZF7x3cWEnsvy82PHBLeCRbJAcWEZ8TTLRTm/QKfBN7Eztd5MOI7HPk8iKwrpHTXHGlU4lsK+VBnirseHuosvHUUSUJdq4Isksluh8yIjL9oOYHvhdw1M3eRpWyjL4fvDZpf813Zm+YfClHthwHqWgYUQCSghcWjZWmEzeoJzius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVqnEas+; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVqnEas+"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-678adefbd26so1189337a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 10:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777050318; x=1777655118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFAM/NZXZSjzutoirDVHbjRsSPZTVksem8A+5NzY+/0=;
        b=DVqnEas+7rTEZHxcEvF3/zuZ2b23EvCok+SBCPdulkELQ0F/3K6KBifrIhiDV9RDwW
         Zr5gwsizpWTKQ0vjBml+M77Ufg91U96qkfcx5yvzL8LSOp1oUsCvqkiBZ0m6zckyBuX1
         18npfGZdGBeTqcIJuvn+ftmho7E/fxzQYNxsNeUjRYp+rf90ksdo4syiNk5d+ntgofWT
         k+1aGAG1b9Yxl9IYFc1DfFsDs4JDMLBliW6/kxhJdD6ZaABMVydwxSX88h9d1dNRKMgX
         okqe5EE6hrEAsCanAL0LHFv7PLRmWnR3KeQwAmdCnlL302fz7lf7/UpUM1a2a7y9mg9s
         d9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050318; x=1777655118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cFAM/NZXZSjzutoirDVHbjRsSPZTVksem8A+5NzY+/0=;
        b=Tc+HG2zwVweR35pOzEF8KUasDxXKOZgyjI0Q9v2zGtKuNHv6OWGQQLstooCm5LX/WZ
         3fWwkqjxOx+TUJEivJPCY5ylux+pgnlSyLxeraUgqXdNkP7lb0kyXbvTv0qsO4DbqTQN
         phz1phStL11ZE6OKEuRfNnofstpNOC+0qhgYGVwE1G3BkHA5wOaKqie4Tyuu+oIYbJWZ
         3SulXk99f/jq3/0iKin+Sz2Fudm6MreqAJCaqLptayGzh/c3FBftGR2aEbQ1Z8AWtiXK
         odUZRJ6p0meoifhsC5OzXO3L595dzv8ywOmPCevjlyC3wQVL5dYYTgwiOUPC5vI4khYh
         PGFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9DcREZxqcLS3xltLqdfQDXskq/DC63vO80mP3PbYfSmvF4XsHjXyq0j/Hsu1pYLlBREiWu1Wz4YgFnrP7d@vger.kernel.org
X-Gm-Message-State: AOJu0YyZuBQ9V5dpihNgIbtQAHw3tytX5Yp1JSU3hg2dPpR7bx36rk0I
	PBdZN613li80vvyDVPsMkdxd+t0tCIdH5DOsEGE4WWj2vJ+Wpk6rxP+p
X-Gm-Gg: AeBDieuijCncbxYOneeor0LD9nSbNL5/4A5GtPKami3UmeL3hUO07mn1lIU6W/eodxg
	9BnLzlRi9D7IIN12EXwfDqLOEMW/A9HH0XfFFhs42n9bDBp/u0vFkFXQmoqCrbc266b+jtQ7YIc
	UQnzEVuVcXpTwJJJBtbv7xsp/hSsADD2DOzFDQfywFjhrfyo3uvsBc2ahROD3jrkSsH1M3D6VZx
	pVLx3akNeCyba3OuI48vg31deI5be3AAEOofoPF523Q4l1nHgwfQi1SBfhuuoojX4Vcb9ATkB1W
	cL8bPmvzY5jxdfHPGMqTUk6UPUt7s2PkKDRYRfmc1LmNo1/3+Q7MT2OYH6WI6lYT0CwBNyKfKna
	rQwuh3P71bh5RKOHpv+B9CUU7+dDA5fp9rfH/x0SMpSAWE5BqhFv5IJ4BiOBFL1A+uTNIP+rZe2
	R+VaDkjPuCYfqzLuxe0oaPnTpQg5EZoSGodsSHaJu6cMtkgwck/bFwip1w0YrFF891S8kAY9O8B
	hPVpB6zD6BBV/v7NFAFXWyJJozCUsYdfIeoq0E=
X-Received: by 2002:a05:6402:46da:b0:674:b1b1:d039 with SMTP id 4fb4d7f45d1cf-674b1b1d10dmr9666620a12.11.1777050317483;
        Fri, 24 Apr 2026 10:05:17 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-4aab-734a-1928-df3f.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:4aab:734a:1928:df3f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67325fcad48sm4924370a12.17.2026.04.24.10.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 10:05:16 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 10/10] selftests/filesystems: add fanotify namespace notifications test
Date: Fri, 24 Apr 2026 19:05:03 +0200
Message-ID: <20260424170503.2096847-11-amir73il@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260424170503.2096847-1-amir73il@gmail.com>
References: <20260424170503.2096847-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test create and delete events for nsfs:
- For init userns and child userns
- Verify delete event is created regardless of vfs inode access
- Verify required ns capabilities

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tools/include/uapi/linux/fanotify.h           |  37 +-
 .../selftests/filesystems/fanotify/Makefile   |   3 +-
 .../filesystems/fanotify/ns-notify_test.c     | 330 ++++++++++++++++++
 3 files changed, 362 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/fanotify/ns-notify_test.c

diff --git a/tools/include/uapi/linux/fanotify.h b/tools/include/uapi/linux/fanotify.h
index e710967c7c263..8a12db80f9d80 100644
--- a/tools/include/uapi/linux/fanotify.h
+++ b/tools/include/uapi/linux/fanotify.h
@@ -4,7 +4,9 @@
 
 #include <linux/types.h>
 
-/* the following events that user-space can register for */
+/*
+ * Events that user-space can request when watching filesystems
+ */
 #define FAN_ACCESS		0x00000001	/* File was accessed */
 #define FAN_MODIFY		0x00000002	/* File was modified */
 #define FAN_ATTRIB		0x00000004	/* Metadata changed */
@@ -28,19 +30,31 @@
 /* #define FAN_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
 #define FAN_PRE_ACCESS		0x00100000	/* Pre-content access hook */
-#define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
-#define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
-
-#define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
 #define FAN_RENAME		0x10000000	/* File was renamed */
 
-#define FAN_ONDIR		0x40000000	/* Event occurred against dir */
-
 /* helper events */
 #define FAN_CLOSE		(FAN_CLOSE_WRITE | FAN_CLOSE_NOWRITE) /* close */
 #define FAN_MOVE		(FAN_MOVED_FROM | FAN_MOVED_TO) /* moves */
 
+/*
+ * Filter flags for watching filesystems
+ */
+#define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
+#define FAN_ONDIR		0x40000000	/* Event occurred against dir */
+
+/*
+ * Events that user-space can request when watching namespaces
+ *
+ * NOTE: These values may overload filesystem events, but not event flags
+ */
+#define FAN_NS_CREATE		0x00000100	/* Sub namespace was created */
+#define FAN_NS_DELETE		0x00000200	/* Sub namespace was deleted */
+
+#define FAN_MNT_ATTACH		0x01000000	/* Mount was attached */
+#define FAN_MNT_DETACH		0x02000000	/* Mount was detached */
+
+
 /* flags used for fanotify_init() */
 #define FAN_CLOEXEC		0x00000001
 #define FAN_NONBLOCK		0x00000002
@@ -67,6 +81,7 @@
 #define FAN_REPORT_TARGET_FID	0x00001000	/* Report dirent target id  */
 #define FAN_REPORT_FD_ERROR	0x00002000	/* event->fd can report error */
 #define FAN_REPORT_MNT		0x00004000	/* Report mount events */
+#define FAN_REPORT_NSID		0x00008000	/* Report namespace events */
 
 /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
 #define FAN_REPORT_DFID_NAME	(FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
@@ -98,6 +113,7 @@
 #define FAN_MARK_MOUNT		0x00000010
 #define FAN_MARK_FILESYSTEM	0x00000100
 #define FAN_MARK_MNTNS		0x00000110
+#define FAN_MARK_USERNS		0x00001000
 
 /*
  * Convenience macro - FAN_MARK_IGNORE requires FAN_MARK_IGNORED_SURV_MODIFY
@@ -152,6 +168,7 @@ struct fanotify_event_metadata {
 #define FAN_EVENT_INFO_TYPE_ERROR	5
 #define FAN_EVENT_INFO_TYPE_RANGE	6
 #define FAN_EVENT_INFO_TYPE_MNT		7
+#define FAN_EVENT_INFO_TYPE_NS		8
 
 /* Special info types for FAN_RENAME */
 #define FAN_EVENT_INFO_TYPE_OLD_DFID_NAME	10
@@ -210,6 +227,12 @@ struct fanotify_event_info_mnt {
 	__u64 mnt_id;
 };
 
+struct fanotify_event_info_ns {
+	struct fanotify_event_info_header hdr;
+	__u64 self_nsid;	/* ns_id of the namespace */
+	__u64 owner_nsid;	/* ns_id of its owning user namespace */
+};
+
 /*
  * User space may need to record additional information about its decision.
  * The extra information type records what kind of information is included.
diff --git a/tools/testing/selftests/filesystems/fanotify/Makefile b/tools/testing/selftests/filesystems/fanotify/Makefile
index 836a4eb7be062..d251249630985 100644
--- a/tools/testing/selftests/filesystems/fanotify/Makefile
+++ b/tools/testing/selftests/filesystems/fanotify/Makefile
@@ -3,9 +3,10 @@
 CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS += -lcap
 
-TEST_GEN_PROGS := mount-notify_test mount-notify_test_ns
+TEST_GEN_PROGS := mount-notify_test mount-notify_test_ns ns-notify_test
 
 include ../../lib.mk
 
 $(OUTPUT)/mount-notify_test: ../utils.c
 $(OUTPUT)/mount-notify_test_ns: ../utils.c
+$(OUTPUT)/ns-notify_test: ../utils.c
diff --git a/tools/testing/selftests/filesystems/fanotify/ns-notify_test.c b/tools/testing/selftests/filesystems/fanotify/ns-notify_test.c
new file mode 100644
index 0000000000000..012a62c92ee4a
--- /dev/null
+++ b/tools/testing/selftests/filesystems/fanotify/ns-notify_test.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025
+
+#define _GNU_SOURCE
+
+// Needed for linux/fanotify.h
+typedef struct {
+	int	val[2];
+} __kernel_fsid_t;
+#define __kernel_fsid_t __kernel_fsid_t
+
+#include <fcntl.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/fanotify.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+#include "kselftest_harness.h"
+#include "../utils.h"
+
+#include <linux/fanotify.h>
+
+/*
+ * Retrieve the ns_id of a namespace fd via name_to_handle_at().
+ * nsfs encodes { ns_id(u64), ns_type(u32), ns_inum(u32) } in f_handle.
+ */
+static uint64_t get_ns_id(int fd)
+{
+	struct {
+		struct file_handle fh;
+		uint64_t ns_id;
+		uint32_t ns_type;
+		uint32_t ns_inum;
+	} h = { .fh.handle_bytes = sizeof(uint64_t) + sizeof(uint32_t) * 2 };
+	int mnt_id;
+
+	if (name_to_handle_at(fd, "", &h.fh, &mnt_id, AT_EMPTY_PATH))
+		return 0;
+	return h.ns_id;
+}
+
+static void read_ns_event_fd(struct __test_metadata *const _metadata,
+			     int fd, char *buf, size_t buf_size,
+			     uint64_t expect_mask,
+			     uint64_t *self_nsid_out, uint64_t *owner_nsid_out)
+{
+	struct fanotify_event_metadata *meta;
+	struct fanotify_event_info_ns *info;
+	ssize_t len;
+
+	len = read(fd, buf, buf_size);
+	ASSERT_GT(len, 0);
+
+	meta = (struct fanotify_event_metadata *)buf;
+	ASSERT_TRUE(FAN_EVENT_OK(meta, len));
+	ASSERT_EQ(meta->mask, expect_mask);
+	ASSERT_EQ(meta->fd, FAN_NOFD);
+	ASSERT_EQ(meta->event_len,
+		  sizeof(*meta) + sizeof(struct fanotify_event_info_ns));
+
+	info = (struct fanotify_event_info_ns *)(meta + 1);
+	ASSERT_EQ(info->hdr.info_type, FAN_EVENT_INFO_TYPE_NS);
+	ASSERT_EQ(info->hdr.len, sizeof(*info));
+
+	*self_nsid_out  = info->self_nsid;
+	*owner_nsid_out = info->owner_nsid;
+}
+
+/* =========================================================================
+ * Outer tests: watch init_user_ns from root context (no setup_userns).
+ * ========================================================================= */
+
+/*
+ * Root-only: watch init_user_ns, fork a child that creates a user namespace
+ * owned by init_user_ns, verify FAN_CREATE, let the child exit, verify
+ * FAN_DELETE.  The watched namespace is created and destroyed entirely within
+ * the test body so both events are observable.
+ */
+TEST(outer_create_delete_userns)
+{
+	int fan_fd, ns_fd;
+	int pipefd[2];
+	pid_t pid;
+	uint64_t ns_nsid, create_self, create_owner;
+	uint64_t delete_self, delete_owner;
+	char buf[256];
+	char c;
+
+	if (geteuid() != 0)
+		SKIP(return, "requires root");
+
+	ns_fd = open("/proc/self/ns/user", O_RDONLY);
+	ASSERT_GE(ns_fd, 0);
+
+	ns_nsid = get_ns_id(ns_fd);
+	ASSERT_NE(ns_nsid, 0);
+
+	fan_fd = fanotify_init(FAN_REPORT_NSID, 0);
+	ASSERT_GE(fan_fd, 0);
+
+	errno = 0;
+	ASSERT_EQ(fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_USERNS,
+				FAN_NS_CREATE | FAN_NS_DELETE, ns_fd, NULL), 0)
+		TH_LOG("fanotify_mark errno=%d (%s)", errno, strerror(errno));
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(pipefd[0]);
+		if (unshare(CLONE_NEWUSER))
+			_exit(1);
+		if (write(pipefd[1], "r", 1) < 0)
+			_exit(1);
+		close(pipefd[1]);
+		pause();
+		_exit(0);
+	}
+
+	close(pipefd[1]);
+	ASSERT_EQ(read(pipefd[0], &c, 1), 1);
+	close(pipefd[0]);
+
+	/* --- FAN_NS_CREATE: new user namespace owned by init_user_ns --- */
+	read_ns_event_fd(_metadata, fan_fd, buf, sizeof(buf),
+			 FAN_NS_CREATE, &create_self, &create_owner);
+	ASSERT_NE(create_self, 0);
+	ASSERT_EQ(create_owner, ns_nsid);
+
+	/* Let child exit, deactivating its user namespace */
+	kill(pid, SIGTERM);
+	waitpid(pid, NULL, 0);
+
+	/* --- FAN_NS_DELETE --- */
+	read_ns_event_fd(_metadata, fan_fd, buf, sizeof(buf),
+			 FAN_NS_DELETE, &delete_self, &delete_owner);
+	ASSERT_EQ(delete_self, create_self);
+	ASSERT_EQ(delete_owner, ns_nsid);
+
+	close(fan_fd);
+	close(ns_fd);
+}
+
+/* =========================================================================
+ * Inner tests: watch a child userns from within it (via setup_userns).
+ * ========================================================================= */
+
+FIXTURE(userns_notify) {
+	int fan_fd;
+	int userns_fd;
+	int outer_ns_fd;	/* init_user_ns fd, captured before setup_userns() */
+	uint64_t userns_nsid;
+	char buf[256];
+};
+
+FIXTURE_SETUP(userns_notify)
+{
+	int ret;
+
+	/* Capture the outer user namespace fd before setup_userns() */
+	self->outer_ns_fd = open("/proc/self/ns/user", O_RDONLY);
+	ASSERT_GE(self->outer_ns_fd, 0);
+
+	ret = setup_userns();
+	ASSERT_EQ(ret, 0);
+
+	self->userns_fd = open("/proc/self/ns/user", O_RDONLY);
+	ASSERT_GE(self->userns_fd, 0);
+
+	self->userns_nsid = get_ns_id(self->userns_fd);
+	ASSERT_NE(self->userns_nsid, 0);
+
+	self->fan_fd = fanotify_init(FAN_REPORT_NSID, 0);
+	ASSERT_GE(self->fan_fd, 0);
+
+	errno = 0;
+	ret = fanotify_mark(self->fan_fd, FAN_MARK_ADD | FAN_MARK_USERNS,
+			    FAN_NS_CREATE | FAN_NS_DELETE,
+			    self->userns_fd, NULL);
+	ASSERT_EQ(ret, 0)
+		TH_LOG("fanotify_mark errno=%d (%s)", errno, strerror(errno));
+}
+
+FIXTURE_TEARDOWN(userns_notify)
+{
+	close(self->fan_fd);
+	close(self->userns_fd);
+	close(self->outer_ns_fd);
+}
+
+static void read_ns_event(struct __test_metadata *const _metadata,
+			  FIXTURE_DATA(userns_notify) *self,
+			  uint64_t expect_mask,
+			  uint64_t *self_nsid_out, uint64_t *owner_nsid_out)
+{
+	read_ns_event_fd(_metadata, self->fan_fd, self->buf, sizeof(self->buf),
+			 expect_mask, self_nsid_out, owner_nsid_out);
+}
+
+/*
+ * Create a UTS namespace inside the watched user namespace, verify
+ * FAN_CREATE, then let the child exit and verify FAN_DELETE.
+ * Cross-check self_nsid against the actual ns_id obtained via
+ * name_to_handle_at() on the child's /proc/pid/ns/uts.
+ */
+TEST_F(userns_notify, inner_create_delete_uts)
+{
+	int pipefd[2];
+	pid_t pid;
+	uint64_t create_self, create_owner;
+	uint64_t delete_self, delete_owner;
+	char c;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(pipefd[0]);
+		if (unshare(CLONE_NEWUTS))
+			_exit(1);
+		if (write(pipefd[1], "r", 1) < 0)
+			_exit(1);
+		close(pipefd[1]);
+		pause();
+		_exit(0);
+	}
+
+	close(pipefd[1]);
+	ASSERT_EQ(read(pipefd[0], &c, 1), 1);
+	close(pipefd[0]);
+
+	/* --- FAN_NS_CREATE --- */
+	read_ns_event(_metadata, self, FAN_NS_CREATE, &create_self, &create_owner);
+	ASSERT_NE(create_self, 0);
+	ASSERT_EQ(create_owner, self->userns_nsid);
+
+	/* Cross-check self_nsid against the child's actual UTS ns_id */
+	char path[64];
+	int ns_fd;
+	uint64_t uts_nsid;
+
+	snprintf(path, sizeof(path), "/proc/%d/ns/uts", pid);
+	ns_fd = open(path, O_RDONLY);
+	ASSERT_GE(ns_fd, 0);
+	uts_nsid = get_ns_id(ns_fd);
+	close(ns_fd);
+	ASSERT_EQ(uts_nsid, create_self);
+
+	kill(pid, SIGTERM);
+	waitpid(pid, NULL, 0);
+
+	/* --- FAN_NS_DELETE --- */
+	read_ns_event(_metadata, self, FAN_NS_DELETE, &delete_self, &delete_owner);
+	ASSERT_EQ(delete_self, create_self);
+	ASSERT_EQ(delete_owner, self->userns_nsid);
+}
+
+/*
+ * Same as inner_create_delete_uts but the namespace fd is never opened, so
+ * the stashed nsfs dentry/inode is never populated.  Verifies that FAN_CREATE
+ * and FAN_DELETE are still delivered and carry a consistent self_nsid.
+ */
+TEST_F(userns_notify, inner_create_delete_uts_no_open)
+{
+	int pipefd[2];
+	pid_t pid;
+	uint64_t create_self, create_owner;
+	uint64_t delete_self, delete_owner;
+	char c;
+
+	ASSERT_EQ(pipe(pipefd), 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(pipefd[0]);
+		if (unshare(CLONE_NEWUTS))
+			_exit(1);
+		if (write(pipefd[1], "r", 1) < 0)
+			_exit(1);
+		close(pipefd[1]);
+		pause();
+		_exit(0);
+	}
+
+	close(pipefd[1]);
+	ASSERT_EQ(read(pipefd[0], &c, 1), 1);
+	close(pipefd[0]);
+
+	/* --- FAN_NS_CREATE (no open of /proc/pid/ns/uts) --- */
+	read_ns_event(_metadata, self, FAN_NS_CREATE, &create_self, &create_owner);
+	ASSERT_NE(create_self, 0);
+	ASSERT_EQ(create_owner, self->userns_nsid);
+
+	kill(pid, SIGTERM);
+	waitpid(pid, NULL, 0);
+
+	/* --- FAN_NS_DELETE --- */
+	read_ns_event(_metadata, self, FAN_NS_DELETE, &delete_self, &delete_owner);
+	ASSERT_EQ(delete_self, create_self);
+	ASSERT_EQ(delete_owner, self->userns_nsid);
+}
+
+/*
+ * Attempt to set a FAN_MARK_USERNS watch on the initial user namespace.
+ * Requires CAP_SYS_ADMIN in init_user_ns.  Since FIXTURE_SETUP calls
+ * setup_userns(), the process lives in a child user namespace and cannot
+ * hold capabilities in init_user_ns, so the call must fail with EPERM
+ * regardless of the outer uid.
+ */
+TEST_F(userns_notify, inner_mark_init_userns_eperm)
+{
+	int ret;
+
+	ret = fanotify_mark(self->fan_fd, FAN_MARK_ADD | FAN_MARK_USERNS,
+			    FAN_NS_CREATE | FAN_NS_DELETE,
+			    self->outer_ns_fd, NULL);
+	EXPECT_EQ(ret, -1);
+	EXPECT_EQ(errno, EPERM);
+}
+
+TEST_HARNESS_MAIN
-- 
2.54.0

