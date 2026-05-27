Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBB33B27DF
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 19:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911523; cv=none; b=k1HemYbdRpNthyleVG31TuXriD2jyuFLWRY1oQTSh4Lvns0kNeMH3do5vxvI4rFaxWcOsyngrG4Fz0CIGQHmkudCiW8h9FPajF+22VMhB51QZPq1/Cnp7fOdKsVeCRn+gzIYUrwzHKoSxOcBLMRuYBwZJ7nsx6e84CU3TlvwzA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911523; c=relaxed/simple;
	bh=NmtYua/DqzpYW2iyg1ThlUaHCNL4E7+7TbdvMk34Vj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jT3QtqhoYwlJ8x9aq9tvAYi/aVOpLlLOVxE6DDyq2Giql109WQrKCmO2+Ar32ROY60TfGxGFTSmp18l80SGJ3jrodXpU9h4r63WMbykRSTmT+k1BzPPs6RQzgIK37yVuq3a5PxQhXEVYJEAMrBOPc9yAxt2JP5htew0z6jI1XBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjMhYfvV; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjMhYfvV"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-30246cfd41aso2205323eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 12:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779911521; x=1780516321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhcW9OXdq+7RLkIQ+M+3BcJFbvc/DitU1ORfNacDclA=;
        b=TjMhYfvVDzD0EyGvDXqNJ6mfR2u7q5BnFluPMzRmNyyUPlMYy7stqb5LOXiAL0ChcL
         jG7eggsezpZlfWhJHasDDTpqcR61wFwvgOnUXuEcDz/3Q4rdEBts+rpgrCsnAUwMzQBn
         qwiQyxSYS2ASZymkDpjXNPFx6IzTMoGrgTKmbu8EUwrl2EQlufGNZAUToUhcui59WDn9
         QvUDQbRQves9HI+P2LqI6rHNhbWWBg2FNOmWmYYhPaVIqF8yXmwwHVh2KpH5/CBKX0Nb
         2RfhzpGc6drwiiI0abRZL4Q4g2a8lUQkcd2iAxpMKb/J7v34o0fE9Bf2t4JTeyJH4+ZK
         CUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779911521; x=1780516321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rhcW9OXdq+7RLkIQ+M+3BcJFbvc/DitU1ORfNacDclA=;
        b=WxOdI5ktxxA65jSQubO/p7M6LKHKsvPnFm/8BCMOHK0yZEZO3yCq7GabOwp9kifNy/
         zGgIpXGUI1v5ah7cGo+oozXpuFnuBLtjYLyKghAXvjZ7hsrQEVpcTy1CQetvZPUar31E
         VU1dm9tndCBh61RtMk2LqHW7ulIMZsA/td+8qetgZWJeKzq+vTJDLTdMjbiEsNQs2/sV
         zLmhed70yZ8z986IR50lDfUTzH7bMrQhPG972Czouvy/KfALeRy4Qb2lRyBscfvd/DKk
         NQfwrgPcmXkfHg171oqSaYVAQjzUezng0JBRnj32D4ZhgWRR364HtbNXcFZQxJn5lhj+
         AAVg==
X-Forwarded-Encrypted: i=1; AFNElJ/RhQ2T0WwyDeU6EkW2w2LH1rqrvJq8tp0MH6XXUaCcMnNKa+GqeFlDQxZbtwaRFOTZcmsRVL0+gKSouHFD@vger.kernel.org
X-Gm-Message-State: AOJu0YxCLDWEByD3l6TlO0mWPc595Mr1ItWZMoLh0gA7WbhheqX5cXpR
	JFSsdEGntYXJLDydX8bkUjc+H9+OD4+KyIxwCYSNkzYW5BpoLt+FO9Fz
X-Gm-Gg: Acq92OEeVAw6CAENu3+Fp1pU+Y/GHCKwBw2jsgGphNysQQJhDJBT9hAjUIo9Ns5HBkY
	chTt8oeXkzgE3L/rv8R4kKvhImhW5fm2xl/nSJz1nA0hxSHQPHl8kgfT2qb51Q6876ZRvx/5ZVV
	5XS40A01IDnCxXZGxTDb+MWXLn2q+X02aHZ8/+DVviHWPxPmZp91MmbvLgnYdRiPGTrS4szOcqC
	VQPKwgLbEHmdpUVASCZ/h8/bbknHlZKknNpw7uSkUfbJPeGFiidqiZ6np2OhALYIhY5GOarImUc
	WPTpcW7UNcZJ0sUtCFc6qQ9BGbez32XD+sgkNHXEAdXxq1rxqBsXuqdS8FX05pw9MHcoJqTleW9
	Lg3r7QABlwBGlro6E7Z0uob9Y9T3bucTE/MLmAi0osDXGwkFsZUnFTEaucns7dsFxoJQhFij3XX
	wVOkc5yiXdssv+Jf5tM/0SUyoQGuwbsQ==
X-Received: by 2002:a05:693c:2c86:b0:2d8:df01:d9f7 with SMTP id 5a478bee46e88-304490a9a62mr12737322eec.15.1779911520643;
        Wed, 27 May 2026 12:52:00 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451ef4719sm13705106eec.1.2026.05.27.12.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 12:52:00 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: pvorel@suse.cz
Cc: amir73il@gmail.com,
	jack@suse.cz,
	repnop@google.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ltp@lists.linux.it,
	AnonymeMeow <anonymemeow@gmail.com>
Subject: [PATCH v2 2/2] fanotify: prepare tests for thread pidfd reporting
Date: Thu, 28 May 2026 03:50:56 +0800
Message-ID: <20260527195056.337081-2-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527195056.337081-1-anonymemeow@gmail.com>
References: <20260527072312.GA231966@pevik>
 <20260527195056.337081-1-anonymemeow@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a runtime probe in fanotify20 for FAN_REPORT_PIDFD combined with
FAN_REPORT_TID, and use the probe result to decide the expected
fanotify_init() behavior. This keeps the test compatible with both kernels
that do and do not support thread pidfd reporting. Also add a test case
that combines all FAN_REPORT_* flags supported since Linux 5.15.

Add two test variants to fanotify21 that run the existing pidfd tests in
thread-pidfd mode. And add a test case that verifies pidfd reporting for
events generated by another task, either a child process or a worker
thread depending on the test variant. This test case especially ensures
that the pidfd reported by fanotify refers to the event-generating thread
when thread pidfds are enabled, rather than referring to the thread-group
leader.

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---

This patch is almost idential to the v1 patch, except that it is now based
on patch 1/2.

Link: https://lore.kernel.org/lkml/20260527064041.50443-1-anonymemeow@gmail.com/

---
 testcases/kernel/syscalls/fanotify/Makefile   |   2 +-
 .../kernel/syscalls/fanotify/fanotify20.c     |  24 +-
 .../kernel/syscalls/fanotify/fanotify21.c     | 224 +++++++++++++-----
 3 files changed, 184 insertions(+), 66 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/Makefile b/testcases/kernel/syscalls/fanotify/Makefile
index 3628094ba..b20bb50e9 100644
--- a/testcases/kernel/syscalls/fanotify/Makefile
+++ b/testcases/kernel/syscalls/fanotify/Makefile
@@ -2,7 +2,7 @@
 #  Copyright (c) Jan Kara <jack@suse.cz>, 2013
 
 top_srcdir		?= ../../../..
-fanotify11: CFLAGS+=-pthread
+fanotify11 fanotify21: CFLAGS+=-pthread
 include $(top_srcdir)/include/mk/testcases.mk
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
index b32ecf6aa..5d77b485c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify20.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
@@ -28,19 +28,27 @@
 #define FLAGS_DESC(x) .flags = x, .desc = #x
 
 static int fd;
+static int thread_pidfd_unsupported;
 
 static struct test_case_t {
 	unsigned int flags;
 	char *desc;
 	int exp_errno;
+	unsigned int needs_thread_pidfd;
 } test_cases[] = {
 	{
 		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_TID),
 		.exp_errno = EINVAL,
+		.needs_thread_pidfd = 1,
 	},
 	{
 		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_FID | FAN_REPORT_DFID_NAME),
 	},
+	{
+		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_TID | FAN_REPORT_FID | FAN_REPORT_DFID_NAME),
+		.exp_errno = EINVAL,
+		.needs_thread_pidfd = 1,
+	},
 };
 
 static void do_setup(void)
@@ -51,17 +59,29 @@ static void do_setup(void)
 	 */
 	REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(FAN_REPORT_PIDFD,
 						    MOUNT_PATH);
+
+	/*
+	 * Check whether the kernel supports FAN_REPORT_PIDFD in combination
+	 * with FAN_REPORT_TID. Test cases with the needs_thread_pidfd field
+	 * set expect different errno values depending on whether this
+	 * combination is supported.
+	 */
+	thread_pidfd_unsupported = fanotify_init_flags_supported_on_fs(
+		FAN_REPORT_PIDFD | FAN_REPORT_TID, MOUNT_PATH);
 }
 
 static void do_test(unsigned int i)
 {
 	struct test_case_t *tc = &test_cases[i];
 
-	tst_res(TINFO, "Test %s on %s", tc->exp_errno ? "fail" : "pass",
+	int exp_errno = tc->needs_thread_pidfd && !thread_pidfd_unsupported ?
+		0 : tc->exp_errno;
+
+	tst_res(TINFO, "Test %s on %s", exp_errno ? "fail" : "pass",
 		tc->desc);
 
 	TST_EXP_FD_OR_FAIL(fd = fanotify_init(tc->flags, O_RDONLY),
-			   tc->exp_errno);
+			   exp_errno);
 
 	if (fd > 0)
 		SAFE_CLOSE(fd);
diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 2e3dbd4bd..0c190ab6f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -20,9 +20,11 @@
 #include <stdlib.h>
 #include <string.h>
 #include <sys/mount.h>
+#include <pthread.h>
 #include "tst_test.h"
 #include "tst_safe_stdio.h"
 #include "tst_safe_macros.h"
+#include "tst_safe_pthread.h"
 #include "lapi/pidfd.h"
 
 #ifdef HAVE_SYS_FANOTIFY_H
@@ -42,7 +44,7 @@ struct pidfd_fdinfo_t {
 
 static struct test_case_t {
 	char *name;
-	int fork;
+	int trigger_in_child;
 	int want_pidfd_err;
 	int remount_ro;
 } test_cases[] = {
@@ -52,6 +54,12 @@ static struct test_case_t {
 		0,
 		0,
 	},
+	{
+		"return a valid pidfd for event created by child",
+		1,
+		0,
+		0,
+	},
 	{
 		"return invalid pidfd for event created by terminated child",
 		1,
@@ -68,16 +76,17 @@ static struct test_case_t {
 
 static int fanotify_fd;
 static char event_buf[BUF_SZ];
-static struct pidfd_fdinfo_t *self_pidfd_fdinfo;
+static struct pidfd_fdinfo_t expected_pidfd_fdinfo;
 
 static int fd_error_unsupported;
+static int thread_pidfd_unsupported;
+
+#define TST_VARIANT_FD_ERROR (tst_variant & 1)
+#define TST_VARIANT_PIDFD_THREAD (tst_variant & 2)
 
-static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
+static void read_pidfd_fdinfo(int pidfd, struct pidfd_fdinfo_t *pidfd_fdinfo)
 {
 	char *fdinfo_path;
-	struct pidfd_fdinfo_t *pidfd_fdinfo;
-
-	pidfd_fdinfo = SAFE_MALLOC(sizeof(struct pidfd_fdinfo_t));
 
 	SAFE_ASPRINTF(&fdinfo_path, "/proc/self/fdinfo/%d", pidfd);
 	SAFE_FILE_LINES_SCANF(fdinfo_path, "pos: %d", &pidfd_fdinfo->pos);
@@ -87,8 +96,6 @@ static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
 	SAFE_FILE_LINES_SCANF(fdinfo_path, "NSpid: %d", &pidfd_fdinfo->ns_pid);
 
 	free(fdinfo_path);
-
-	return pidfd_fdinfo;
 }
 
 static void generate_event(void)
@@ -100,30 +107,91 @@ static void generate_event(void)
 	SAFE_CLOSE(fd);
 }
 
-static void do_fork(void)
+static pid_t do_fork(int want_pidfd_err)
 {
-	int status;
+	int pidfd;
 	pid_t child;
 
 	child = SAFE_FORK();
 	if (child == 0) {
 		SAFE_CLOSE(fanotify_fd);
 		generate_event();
+		TST_CHECKPOINT_WAIT(0);
 		exit(EXIT_SUCCESS);
 	}
 
-	SAFE_WAITPID(child, &status, 0);
-	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
-		tst_brk(TBROK,
-			"child process terminated incorrectly");
+	pidfd = SAFE_PIDFD_OPEN(child, 0);
+	read_pidfd_fdinfo(pidfd, &expected_pidfd_fdinfo);
+	SAFE_CLOSE(pidfd);
+
+	if (want_pidfd_err) {
+		int status;
+		TST_CHECKPOINT_WAKE(0);
+		SAFE_WAITPID(child, &status, 0);
+		if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
+			tst_brk(TBROK, "child process terminated incorrectly");
+
+		return -1;
+	}
+
+	return child;
 }
 
-static void do_setup(void)
+static void *thread_generate_event(void *arg)
+{
+	*(int *)arg = SAFE_PIDFD_OPEN(gettid(), PIDFD_THREAD);
+	TST_CHECKPOINT_WAKE(0);
+
+	generate_event();
+	TST_CHECKPOINT_WAIT(0);
+	pthread_exit(0);
+}
+
+static pthread_t do_pthread_create(int want_pidfd_err)
 {
 	int pidfd;
+	pthread_t worker;
+
+	SAFE_PTHREAD_CREATE(&worker, NULL, thread_generate_event, &pidfd);
+
+	TST_CHECKPOINT_WAIT(0);
+	read_pidfd_fdinfo(pidfd, &expected_pidfd_fdinfo);
+
+	if (want_pidfd_err) {
+		int status;
+		struct pidfd_fdinfo_t thread_pidfd_fdinfo;
+		TST_CHECKPOINT_WAKE(0);
+		SAFE_PTHREAD_JOIN(worker, (void **)&status);
+		if (status != 0)
+			tst_brk(TBROK, "worker thread terminated incorrectly");
+
+		/*
+		 * Unlike waitpid(), pthread_join() only waits until the worker thread
+		 * has exited from the pthread point of view. The thread may still be
+		 * visible through its pidfd for a short time afterwards, and fanotify
+		 * creates the event pidfd when the event is read. Wait until the
+		 * worker pidfd fdinfo reports Pid: -1 before reading the event so
+		 * that fanotify reports ESRCH/FAN_NOPIDFD instead of a pidfd.
+		 */
+		do {
+			read_pidfd_fdinfo(pidfd, &thread_pidfd_fdinfo);
+		} while (thread_pidfd_fdinfo.pid != -1);
+
+		SAFE_CLOSE(pidfd);
+
+		return -1;
+	}
+
+	SAFE_CLOSE(pidfd);
+
+	return worker;
+}
+
+static void do_setup(void)
+{
 	int init_flags = FAN_REPORT_PIDFD;
 
-	if (tst_variant) {
+	if (TST_VARIANT_FD_ERROR) {
 		fanotify_fd = -1;
 		fd_error_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_FD_ERROR, ".");
 		if (fd_error_unsupported)
@@ -131,6 +199,15 @@ static void do_setup(void)
 		init_flags |= FAN_REPORT_FD_ERROR;
 	}
 
+	if (TST_VARIANT_PIDFD_THREAD) {
+		fanotify_fd = -1;
+		thread_pidfd_unsupported = fanotify_init_flags_supported_on_fs(
+			FAN_REPORT_PIDFD | FAN_REPORT_TID, ".");
+		if (thread_pidfd_unsupported)
+			return;
+		init_flags |= FAN_REPORT_TID;
+	}
+
 	SAFE_TOUCH(TEST_FILE, 0666, NULL);
 
 	/*
@@ -144,15 +221,6 @@ static void do_setup(void)
 	fanotify_fd = SAFE_FANOTIFY_INIT(init_flags, O_RDWR);
 	SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD, FAN_OPEN, AT_FDCWD,
 			   TEST_FILE);
-
-	pidfd = SAFE_PIDFD_OPEN(getpid(), 0);
-
-	self_pidfd_fdinfo = read_pidfd_fdinfo(pidfd);
-	if (self_pidfd_fdinfo == NULL) {
-		tst_brk(TBROK,
-			"pidfd=%d, failed to read pidfd fdinfo",
-			pidfd);
-	}
 }
 
 static void do_test(unsigned int num)
@@ -160,17 +228,29 @@ static void do_test(unsigned int num)
 	int i = 0, len;
 	struct test_case_t *tc = &test_cases[num];
 	int nopidfd_err = tc->want_pidfd_err ?
-			  (tst_variant ? -ESRCH : FAN_NOPIDFD) : 0;
-	int fd_err = (tc->remount_ro && tst_variant) ? -EROFS : 0;
+			  (TST_VARIANT_FD_ERROR ? -ESRCH : FAN_NOPIDFD) : 0;
+	int fd_err = (tc->remount_ro && TST_VARIANT_FD_ERROR) ? -EROFS : 0;
+	union {
+		pid_t pid;
+		pthread_t pthread_id;
+	} worker_id;
 
 	tst_res(TINFO, "Test #%d.%d: %s %s", num, tst_variant, tc->name,
-			tst_variant ? "(FAN_REPORT_FD_ERROR)" : "");
+		TST_VARIANT_FD_ERROR ? (TST_VARIANT_PIDFD_THREAD ?
+			"(FAN_REPORT_FD_ERROR, FAN_REPORT_TID)" : "(FAN_REPORT_FD_ERROR)") :
+			(TST_VARIANT_PIDFD_THREAD ? "(FAN_REPORT_TID)" : ""));
 
-	if (fd_error_unsupported && tst_variant) {
+	if (fd_error_unsupported && TST_VARIANT_FD_ERROR) {
 		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_FD_ERROR, fd_error_unsupported);
 		return;
 	}
 
+	if (thread_pidfd_unsupported && TST_VARIANT_PIDFD_THREAD) {
+		FANOTIFY_INIT_FLAGS_ERR_MSG(FAN_REPORT_PIDFD | FAN_REPORT_TID,
+				thread_pidfd_unsupported);
+		return;
+	}
+
 	if (tc->remount_ro) {
 		/* SAFE_MOUNT fails to remount FUSE */
 		if (mount(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
@@ -182,14 +262,30 @@ static void do_test(unsigned int num)
 	}
 
 	/*
-	 * Generate the event in either self or a child process. Event
-	 * generation in a child process is done so that the FAN_NOPIDFD case
-	 * can be verified.
+	 * Generate the event either in the current task or in another task.
+	 * When trigger_in_child is set, the event can be generated by either
+	 * a child process or a worker thread depending on the test variant.
+	 * The want_pidfd_err field determines whether the event-generating
+	 * task is still valid when the event is read.
 	 */
-	if (tc->fork)
-		do_fork();
-	else
+	if (tc->trigger_in_child) {
+		if (TST_VARIANT_PIDFD_THREAD)
+			worker_id.pthread_id = do_pthread_create(tc->want_pidfd_err);
+		else
+			worker_id.pid = do_fork(tc->want_pidfd_err);
+	} else {
+		/*
+		 * Although the expected pid and the pid reported by fanotify are
+		 * the same in this case, pidfds created with and without PIDFD_THREAD
+		 * flag have different fdinfo flags. Use PIDFD_THREAD for the expected
+		 * pidfd fdinfo so that the fdinfo can be compared bitwise.
+		 */
+		int pidfd = SAFE_PIDFD_OPEN(gettid(), TST_VARIANT_PIDFD_THREAD ? PIDFD_THREAD : 0);
+		read_pidfd_fdinfo(pidfd, &expected_pidfd_fdinfo);
+		SAFE_CLOSE(pidfd);
+
 		generate_event();
+	}
 
 	/*
 	 * Read all of the queued events into the provided event
@@ -208,7 +304,7 @@ static void do_test(unsigned int num)
 	while (i < len) {
 		struct fanotify_event_metadata *event;
 		struct fanotify_event_info_pidfd *info;
-		struct pidfd_fdinfo_t *event_pidfd_fdinfo = NULL;
+		struct pidfd_fdinfo_t event_pidfd_fdinfo;
 
 		event = (struct fanotify_event_metadata *)&event_buf[i];
 		info = (struct fanotify_event_info_pidfd *)(event + 1);
@@ -288,39 +384,32 @@ static void do_test(unsigned int num)
 		 * No pidfd errors occurred, continue with verifying pidfd
 		 * fdinfo validity.
 		 */
-		event_pidfd_fdinfo = read_pidfd_fdinfo(info->pidfd);
-		if (event_pidfd_fdinfo == NULL) {
-			tst_brk(TBROK,
-				"reading fdinfo for pidfd: %d "
-				"describing pid: %u failed",
-				info->pidfd,
-				(unsigned int)event->pid);
-			goto next_event;
-		} else if (event_pidfd_fdinfo->pid != event->pid) {
+		read_pidfd_fdinfo(info->pidfd, &event_pidfd_fdinfo);
+		if (event_pidfd_fdinfo.pid != event->pid) {
 			tst_res(TFAIL,
 				"pidfd provided for incorrect pid "
 				"(expected pidfd for pid: %u, got pidfd for "
 				"pid: %u)",
 				(unsigned int)event->pid,
-				(unsigned int)event_pidfd_fdinfo->pid);
+				(unsigned int)event_pidfd_fdinfo.pid);
 			goto next_event;
-		} else if (memcmp(event_pidfd_fdinfo, self_pidfd_fdinfo,
+		} else if (memcmp(&event_pidfd_fdinfo, &expected_pidfd_fdinfo,
 				  sizeof(struct pidfd_fdinfo_t))) {
 			tst_res(TFAIL,
 				"pidfd fdinfo values for self and event differ "
 				"(expected pos: %d, flags: %x, mnt_id: %d, "
 				"pid: %d, ns_pid: %d, got pos: %d, "
 				"flags: %x, mnt_id: %d, pid: %d, ns_pid: %d",
-				self_pidfd_fdinfo->pos,
-				self_pidfd_fdinfo->flags,
-				self_pidfd_fdinfo->mnt_id,
-				self_pidfd_fdinfo->pid,
-				self_pidfd_fdinfo->ns_pid,
-				event_pidfd_fdinfo->pos,
-				event_pidfd_fdinfo->flags,
-				event_pidfd_fdinfo->mnt_id,
-				event_pidfd_fdinfo->pid,
-				event_pidfd_fdinfo->ns_pid);
+				expected_pidfd_fdinfo.pos,
+				expected_pidfd_fdinfo.flags,
+				expected_pidfd_fdinfo.mnt_id,
+				expected_pidfd_fdinfo.pid,
+				expected_pidfd_fdinfo.ns_pid,
+				event_pidfd_fdinfo.pos,
+				event_pidfd_fdinfo.flags,
+				event_pidfd_fdinfo.mnt_id,
+				event_pidfd_fdinfo.pid,
+				event_pidfd_fdinfo.ns_pid);
 			goto next_event;
 		} else {
 			tst_res(TPASS,
@@ -342,9 +431,20 @@ next_event:
 
 		if (info && info->pidfd >= 0)
 			SAFE_CLOSE(info->pidfd);
+	}
 
-		if (event_pidfd_fdinfo)
-			free(event_pidfd_fdinfo);
+	if (tc->trigger_in_child && !tc->want_pidfd_err) {
+		int status;
+		TST_CHECKPOINT_WAKE(0);
+		if (TST_VARIANT_PIDFD_THREAD) {
+			SAFE_PTHREAD_JOIN(worker_id.pthread_id, (void **)&status);
+			if (status != 0)
+				tst_brk(TBROK, "worker thread terminated incorrectly");
+		} else {
+			SAFE_WAITPID(worker_id.pid, &status, 0);
+			if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
+				tst_brk(TBROK, "child process terminated incorrectly");
+		}
 	}
 
 restore_rw_mount:
@@ -363,19 +463,17 @@ static void do_cleanup(void)
 {
 	if (fanotify_fd >= 0)
 		SAFE_CLOSE(fanotify_fd);
-
-	if (self_pidfd_fdinfo)
-		free(self_pidfd_fdinfo);
 }
 
 static struct tst_test test = {
 	.setup = do_setup,
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(test_cases),
-	.test_variants = 2,
+	.test_variants = 4,
 	.cleanup = do_cleanup,
 	.all_filesystems = 1,
 	.needs_root = 1,
+	.needs_checkpoints = 1,
 	.mount_device = 1,
 	.mntpoint = MOUNT_PATH,
 	.forks_child = 1,
-- 
2.54.0

