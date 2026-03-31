Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40403DB624
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 13:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964658; cv=none; b=naotDjBvUmKZEZgEQE4ti+U8bSrGGlxK3EKi5aS5bEO3r4oCRXP0FXCwWMKL1YPRS/k3d60b2UmCW1Q4sjL+ac7j0lON05/hanAPvqrndE2czCNLz3TQ8H0pX7hs3ix6DUrCW4H2a3+8FjKDdmwiICcxvX1aCRG8l5vPQogvG8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964658; c=relaxed/simple;
	bh=CsfNhvq9iQUOY39Rf/H9E9ourg0Q3+Kn+GjgHyOLoVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0/wZ76P6LAojHLeYlUl4SWgS2e+/3N0i75jNum6AwzMTsSNy/JHRGVqL27p+MPctWeRJFs3oN6VHmRIeYPGtBgwNvLRLzbA0CLoV/WpBQmiDxPvHMETAO6vrCDs+Y+CZ7vsRrqlE01tgiIMJE7h072iOS299HR1JK7c+edPy7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b=GgV/xFU3; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b="GgV/xFU3"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40974bf7781so5297801fac.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 06:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20230601.gappssmtp.com; s=20230601; t=1774964649; x=1775569449; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6Ps+0kKQqKZuuy2teEmtG32Rt1+FQXMRykORYM0/0M=;
        b=GgV/xFU344TRumPwdfPaCSAXjA7uUnvblo3ZZZEFiwEJAkiLlMrGjiCAXmZUrBrpNl
         sJm5PDBd7Hvg0HrGoYW9HcGAc4ysazzHuuJ7gTnF7lsfySv0z8AqjvhR7kYfqPH4WFJd
         cMhbdiJpwewOZ1EoPuw6O0OiruLPSwcsVKgYfVP9/Odugw0z3ZrdjN7A2hm9Oe22iLPr
         NiKp7tH72kux1DoHw5YHwgaJAtc+spVoZ7u6iZ9KoYEvELCULPTEq1IN+xDihZaCEgWQ
         u5dVH8OmtzszmHH9kuD9a5nXcIFLBWy08A1COFO8b+dqPxAxRatDvXHbK1u9FMt3bL0/
         gSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774964649; x=1775569449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E6Ps+0kKQqKZuuy2teEmtG32Rt1+FQXMRykORYM0/0M=;
        b=Px1V3WsUjyy2gznIXciZrpEe5XTyapLbW58TVzstmJ/+Ccb9c4BkdV5WzxInU6IrHm
         /X8ciq0j2Tj0zfrY7tA1py4zbQAzQDv3+Vgm8iZUN5KzxvMst3Ci8q6yHIK+j5hECf8D
         jw7HFwN3m7KzmV9/LVFAic0wIffhI4H6S6GrqXZjoDSU9KCI+RIMnbClllfMiJboUHAb
         OE+yRHTJOn4OqBdaLAs0IKWS2GDYZ9l/+UftVZerxeqhUn6NsHveE6dBhA0SmJriYoQb
         bjkWiMl3p1PB1aKI/SaBPhoVZiBAUohV/Iyps5Zk/Vdv4AZmHBWdC6h7kHFya99n8Usr
         ow1g==
X-Forwarded-Encrypted: i=1; AJvYcCXlPu2lYwwy6NXeMeBSVqHf0wklp1hxCWvER6z/hjl38mXgjpBltSMJ0L7NvmK/DYnaV7aFu2wtNEnPj7V7@vger.kernel.org
X-Gm-Message-State: AOJu0YzKTN46c4KTeGzEgh3bIV/C4ji7ZLGQQM4t80oMcIZ4UiKuSilx
	jSGiF2jccEpZ3+MdP3qNwmU3KW+RKBjWwqBtxL5etPI50FQ3PfyRWjLpwa9f48n/CgXA
X-Gm-Gg: ATEYQzxdEVi4zLbkWoVNVEd5os9QXwlf2uvDvicySFRbAJDJcbX9qVMXGxoHwrAD10r
	6hHbTSWhZmTniWpN5MyspICGeTEmE/HgI9NOQT1epJ97xrm5nuDWUO4cuN7CvYSRM1MG5E394CG
	HtjdkLcGNejY82XzOTea0QLoYOhiJFggu3tsMFxihIca7Swu5NppBW7JGxQCcXWgqGCOTeKdPmu
	gadNvvjVV1G5ORiRLBkWKPTyR5nWaBwU5sFkC7EH2h4p5DxQg171irWw2hl0Z2qGCt5Xk8vPq8E
	Bd6xOwtAQAiDc4s7NszREyCr6Dv25Nk3DAz/C3/m+yldt7/lDypyutu3VARWA0PMhhZgxg48YuV
	4bVwWvtpVLzmt2mFTwbkwofBoWN3+pmMTdUnZQL+QQTqssLO5DRh574iET9+iUtA1+wXPtraKr+
	UuKgprOtOUSpyu8HrEz7i58oBdQmzPzaMreF8500oHvzb7uVTOBr1x+Xj7/BxmHbDspFCtEbO1O
	TJNElKlSodrJ853q5HiP4Li
X-Received: by 2002:a05:6870:2246:b0:41c:56c5:7ca2 with SMTP id 586e51a60fabf-422a2258372mr2054680fac.0.1774964649088;
        Tue, 31 Mar 2026 06:44:09 -0700 (PDT)
Received: from thesius.dot.cyphar.com (2403-5809-a2fc-2-a90-9fd7-aedd-d405.ip6.aussiebb.net. [2403:5809:a2fc:2:a90:9fd7:aedd:d405])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04d95bcasm7470456fac.17.2026.03.31.06.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 06:44:08 -0700 (PDT)
From: Aleksa Sarai <aleksa@amutable.com>
Date: Wed, 01 Apr 2026 00:43:33 +1100
Subject: [PATCH 3/3] selftests: openat2: migrate to kselftest harness
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-openat2-selftests-kunit-v1-3-5819ac6cadf5@amutable.com>
References: <20260401-openat2-selftests-kunit-v1-0-5819ac6cadf5@amutable.com>
In-Reply-To: <20260401-openat2-selftests-kunit-v1-0-5819ac6cadf5@amutable.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Aleksa Sarai <aleksa@amutable.com>, Aleksa Sarai <cyphar@cyphar.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=33391; i=aleksa@amutable.com;
 h=from:subject:message-id; bh=CsfNhvq9iQUOY39Rf/H9E9ourg0Q3+Kn+GjgHyOLoVo=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWSePj89pWbSRsXza0L3HP3nfOT5/Q8qLBfb9rAwmIncu
 agwb7vn+46JLAxiXAyWYoos2/w8QzfNX3wl+dNKNpg5rEwgQ6RFGhgYGBhYGPhyE/NKjXSM9Ey1
 DfUMjXSMdIwYuDgFYKp9axgZrl09rjcp9Ip0wjO3x7fvb5Gbs2r13bczxB88asnq3ztrqycjwzS
 Jvvgt046mO/a+1Xp+0WqxyaH1yccVQwVP6k+TuyGexAkA
X-Developer-Key: i=aleksa@amutable.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

These tests were written in the early days of selftests' TAP support,
the more modern kselftest harness is much easier to follow and maintain.
The actual contents of the tests are unchanged by this change. Most of
the diff involves switching from the E_* syscall wrappers we previously
used to ASSERT_EQ(fn(...), 0) in tests and helper functions.

The first pass of the migration was done using Claude, followed by a
manual rework and review.

Assisted-by: Claude:claude-4.6-opus
Signed-off-by: Aleksa Sarai <aleksa@amutable.com>
---
 tools/testing/selftests/openat2/helpers.h          |  62 +---
 tools/testing/selftests/openat2/openat2_test.c     | 217 ++++++------
 .../testing/selftests/openat2/rename_attack_test.c | 161 +++++----
 tools/testing/selftests/openat2/resolve_test.c     | 368 ++++++++++++---------
 4 files changed, 396 insertions(+), 412 deletions(-)

diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
index f56c0c6e3ad1..7ca54c718c45 100644
--- a/tools/testing/selftests/openat2/helpers.h
+++ b/tools/testing/selftests/openat2/helpers.h
@@ -15,7 +15,7 @@
 #include <limits.h>
 #include <linux/types.h>
 #include <linux/unistd.h>
-#include "kselftest.h"
+#include "kselftest_harness.h"
 
 #define BUILD_BUG_ON(e) ((void)(sizeof(struct { int:(-!!(e)); })))
 
@@ -56,36 +56,6 @@ struct open_how {
 					(similar to chroot(2)). */
 #endif /* RESOLVE_IN_ROOT */
 
-#define E_func(func, ...)						      \
-	do {								      \
-		errno = 0;						      \
-		if (func(__VA_ARGS__) < 0)				      \
-			ksft_exit_fail_msg("%s:%d %s failed - errno:%d\n",    \
-					   __FILE__, __LINE__, #func, errno); \
-	} while (0)
-
-#define E_asprintf(...)		E_func(asprintf,	__VA_ARGS__)
-#define E_chmod(...)		E_func(chmod,		__VA_ARGS__)
-#define E_dup2(...)		E_func(dup2,		__VA_ARGS__)
-#define E_fchdir(...)		E_func(fchdir,		__VA_ARGS__)
-#define E_fstatat(...)		E_func(fstatat,		__VA_ARGS__)
-#define E_kill(...)		E_func(kill,		__VA_ARGS__)
-#define E_mkdirat(...)		E_func(mkdirat,		__VA_ARGS__)
-#define E_mount(...)		E_func(mount,		__VA_ARGS__)
-#define E_prctl(...)		E_func(prctl,		__VA_ARGS__)
-#define E_readlink(...)		E_func(readlink,	__VA_ARGS__)
-#define E_setresuid(...)	E_func(setresuid,	__VA_ARGS__)
-#define E_symlinkat(...)	E_func(symlinkat,	__VA_ARGS__)
-#define E_touchat(...)		E_func(touchat,		__VA_ARGS__)
-#define E_unshare(...)		E_func(unshare,		__VA_ARGS__)
-
-#define E_assert(expr, msg, ...)					\
-	do {								\
-		if (!(expr))						\
-			ksft_exit_fail_msg("ASSERT(%s:%d) failed (%s): " msg "\n", \
-					   __FILE__, __LINE__, #expr, ##__VA_ARGS__); \
-	} while (0)
-
 __maybe_unused
 static bool needs_openat2(const struct open_how *how)
 {
@@ -135,37 +105,39 @@ static int touchat(int dfd, const char *path)
 }
 
 __maybe_unused
-static char *fdreadlink(int fd)
+static char *fdreadlink(struct __test_metadata *_metadata, int fd)
 {
 	char *target, *tmp;
 
-	E_asprintf(&tmp, "/proc/self/fd/%d", fd);
+	ASSERT_GT(asprintf(&tmp, "/proc/self/fd/%d", fd), 0);
 
 	target = malloc(PATH_MAX);
-	if (!target)
-		ksft_exit_fail_msg("fdreadlink: malloc failed\n");
+	ASSERT_NE(target, NULL);
 	memset(target, 0, PATH_MAX);
 
-	E_readlink(tmp, target, PATH_MAX);
+	ASSERT_GT(readlink(tmp, target, PATH_MAX), 0);
+
 	free(tmp);
 	return target;
 }
 
 __maybe_unused
-static bool fdequal(int fd, int dfd, const char *path)
+static bool fdequal(struct __test_metadata *_metadata, int fd,
+		    int dfd, const char *path)
 {
 	char *fdpath, *dfdpath, *other;
 	bool cmp;
 
-	fdpath = fdreadlink(fd);
-	dfdpath = fdreadlink(dfd);
+	fdpath = fdreadlink(_metadata, fd);
+	dfdpath = fdreadlink(_metadata, dfd);
 
-	if (!path)
-		E_asprintf(&other, "%s", dfdpath);
-	else if (*path == '/')
-		E_asprintf(&other, "%s", path);
-	else
-		E_asprintf(&other, "%s/%s", dfdpath, path);
+	if (!path) {
+		ASSERT_GT(asprintf(&other, "%s", dfdpath), 0);
+	} else if (*path == '/') {
+		ASSERT_GT(asprintf(&other, "%s", path), 0);
+	} else {
+		ASSERT_GT(asprintf(&other, "%s/%s", dfdpath, path), 0);
+	}
 
 	cmp = !strcmp(fdpath, other);
 
diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index c6c26652ac1b..5ea3eebb7b59 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -15,8 +15,8 @@
 #include <stdbool.h>
 #include <string.h>
 
-#include "kselftest.h"
 #include "helpers.h"
+#include "kselftest_harness.h"
 
 /*
  * O_LARGEFILE is set to 0 by glibc.
@@ -45,13 +45,29 @@ struct struct_test {
 	int err;
 };
 
-#define NUM_OPENAT2_STRUCT_TESTS 7
-#define NUM_OPENAT2_STRUCT_VARIATIONS 13
+struct flag_test {
+	const char *name;
+	struct open_how how;
+	int err;
+};
+
+FIXTURE(openat2) {};
 
-void test_openat2_struct(void)
+FIXTURE_SETUP(openat2)
 {
-	int misalignments[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 17, 87 };
+	if (!openat2_supported)
+		SKIP(return, "openat2(2) not supported");
+}
+
+FIXTURE_TEARDOWN(openat2) {}
 
+/*
+ * Verify that the struct size and misalignment handling for openat2(2) is
+ * correct, including that is_zeroed_user() works.
+ */
+TEST_F(openat2, struct_argument_sizes)
+{
+	int misalignments[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 17, 87 };
 	struct struct_test tests[] = {
 		/* Normal struct. */
 		{ .name = "normal struct",
@@ -83,26 +99,14 @@ void test_openat2_struct(void)
 		  .size = sizeof(struct open_how_ext), .err = -E2BIG },
 	};
 
-	BUILD_BUG_ON(ARRAY_SIZE(misalignments) != NUM_OPENAT2_STRUCT_VARIATIONS);
-	BUILD_BUG_ON(ARRAY_SIZE(tests) != NUM_OPENAT2_STRUCT_TESTS);
-
 	for (int i = 0; i < ARRAY_SIZE(tests); i++) {
 		struct struct_test *test = &tests[i];
 		struct open_how_ext how_ext = test->arg;
 
 		for (int j = 0; j < ARRAY_SIZE(misalignments); j++) {
 			int fd, misalign = misalignments[j];
-			char *fdpath = NULL;
-			bool failed;
-			void (*resultfn)(const char *msg, ...) = ksft_test_result_pass;
-
 			void *copy = NULL, *how_copy = &how_ext;
-
-			if (!openat2_supported) {
-				ksft_print_msg("openat2(2) unsupported\n");
-				resultfn = ksft_test_result_skip;
-				goto skip;
-			}
+			char *fdpath = NULL;
 
 			if (misalign) {
 				/*
@@ -119,50 +123,42 @@ void test_openat2_struct(void)
 			}
 
 			fd = raw_openat2(AT_FDCWD, ".", how_copy, test->size);
-			if (test->err >= 0)
-				failed = (fd < 0);
-			else
-				failed = (fd != test->err);
 			if (fd >= 0) {
-				fdpath = fdreadlink(fd);
+				fdpath = fdreadlink(_metadata, fd);
 				close(fd);
 			}
 
-			if (failed) {
-				resultfn = ksft_test_result_fail;
-
-				ksft_print_msg("openat2 unexpectedly returned ");
-				if (fdpath)
-					ksft_print_msg("%d['%s']\n", fd, fdpath);
-				else
-					ksft_print_msg("%d (%s)\n", fd, strerror(-fd));
+			if (test->err >= 0) {
+				EXPECT_GE(fd, 0) {
+					TH_LOG("openat2 with %s [misalign=%d] should succeed, got %d (%s)",
+					       test->name, misalign,
+					       fd, strerror(-fd));
+				}
+			} else {
+				EXPECT_EQ(test->err, fd) {
+					if (fdpath)
+						TH_LOG("openat2 with %s [misalign=%d] should fail with %d (%s), got %d['%s']",
+						       test->name, misalign,
+						       test->err,
+						       strerror(-test->err),
+						       fd, fdpath);
+					else
+						TH_LOG("openat2 with %s [misalign=%d] should fail with %d (%s), got %d (%s)",
+						       test->name, misalign,
+						       test->err,
+						       strerror(-test->err),
+						       fd, strerror(-fd));
+				}
 			}
 
-skip:
-			if (test->err >= 0)
-				resultfn("openat2 with %s argument [misalign=%d] succeeds\n",
-					 test->name, misalign);
-			else
-				resultfn("openat2 with %s argument [misalign=%d] fails with %d (%s)\n",
-					 test->name, misalign, test->err,
-					 strerror(-test->err));
-
 			free(copy);
 			free(fdpath);
-			fflush(stdout);
 		}
 	}
 }
 
-struct flag_test {
-	const char *name;
-	struct open_how how;
-	int err;
-};
-
-#define NUM_OPENAT2_FLAG_TESTS 25
-
-void test_openat2_flags(void)
+/* Verify openat2(2) flag and mode validation. */
+TEST_F(openat2, flag_validation)
 {
 	struct flag_test tests[] = {
 		/* O_TMPFILE is incompatible with O_PATH and O_CREAT. */
@@ -241,20 +237,10 @@ void test_openat2_flags(void)
 		  .how.resolve = 0, .err = -EINVAL },
 	};
 
-	BUILD_BUG_ON(ARRAY_SIZE(tests) != NUM_OPENAT2_FLAG_TESTS);
-
 	for (int i = 0; i < ARRAY_SIZE(tests); i++) {
 		int fd, fdflags = -1;
 		char *path, *fdpath = NULL;
-		bool failed = false;
 		struct flag_test *test = &tests[i];
-		void (*resultfn)(const char *msg, ...) = ksft_test_result_pass;
-
-		if (!openat2_supported) {
-			ksft_print_msg("openat2(2) unsupported\n");
-			resultfn = ksft_test_result_skip;
-			goto skip;
-		}
 
 		path = (test->how.flags & O_CREAT) ? "/tmp/ksft.openat2_tmpfile" : ".";
 		unlink(path);
@@ -265,74 +251,63 @@ void test_openat2_flags(void)
 			 * Skip the testcase if it failed because not supported
 			 * by FS. (e.g. a valid O_TMPFILE combination on NFS)
 			 */
-			ksft_test_result_skip("openat2 with %s fails with %d (%s)\n",
-					      test->name, fd, strerror(-fd));
-			goto next;
+			TH_LOG("openat2 with %s not supported by FS -- skipping",
+			       test->name);
+			continue;
 		}
 
-		if (test->err >= 0)
-			failed = (fd < 0);
-		else
-			failed = (fd != test->err);
-		if (fd >= 0) {
-			int otherflags;
-
-			fdpath = fdreadlink(fd);
-			fdflags = fcntl(fd, F_GETFL);
-			otherflags = fcntl(fd, F_GETFD);
-			close(fd);
-
-			E_assert(fdflags >= 0, "fcntl F_GETFL of new fd");
-			E_assert(otherflags >= 0, "fcntl F_GETFD of new fd");
-
-			/* O_CLOEXEC isn't shown in F_GETFL. */
-			if (otherflags & FD_CLOEXEC)
-				fdflags |= O_CLOEXEC;
-			/* O_CREAT is hidden from F_GETFL. */
-			if (test->how.flags & O_CREAT)
-				fdflags |= O_CREAT;
-			if (!(test->how.flags & O_LARGEFILE))
-				fdflags &= ~O_LARGEFILE;
-			failed |= (fdflags != test->how.flags);
-		}
+		if (test->err >= 0) {
+			EXPECT_GE(fd, 0) {
+				TH_LOG("openat2 with %s should succeed, got %d (%s)",
+				       test->name, fd, strerror(-fd));
+			}
+			if (fd >= 0) {
+				int otherflags;
 
-		if (failed) {
-			resultfn = ksft_test_result_fail;
+				fdpath = fdreadlink(_metadata, fd);
+				fdflags = fcntl(fd, F_GETFL);
+				otherflags = fcntl(fd, F_GETFD);
+				close(fd);
 
-			ksft_print_msg("openat2 unexpectedly returned ");
-			if (fdpath)
-				ksft_print_msg("%d['%s'] with %X (!= %llX)\n",
-					       fd, fdpath, fdflags,
-					       test->how.flags);
-			else
-				ksft_print_msg("%d (%s)\n", fd, strerror(-fd));
+				ASSERT_GE(fdflags, 0);
+				ASSERT_GE(otherflags, 0);
+
+				/* O_CLOEXEC isn't shown in F_GETFL. */
+				if (otherflags & FD_CLOEXEC)
+					fdflags |= O_CLOEXEC;
+				/* O_CREAT is hidden from F_GETFL. */
+				if (test->how.flags & O_CREAT)
+					fdflags |= O_CREAT;
+				if (!(test->how.flags & O_LARGEFILE))
+					fdflags &= ~O_LARGEFILE;
+
+				EXPECT_EQ(fdflags, (int)test->how.flags) {
+					TH_LOG("openat2 with %s: flags mismatch %X != %llX",
+					       test->name, fdflags,
+					       (unsigned long long)test->how.flags);
+				}
+			}
+		} else {
+			EXPECT_EQ(test->err, fd) {
+				if (fd >= 0) {
+					fdpath = fdreadlink(_metadata, fd);
+					TH_LOG("openat2 with %s should fail with %d (%s), got %d['%s']",
+					       test->name, test->err,
+					       strerror(-test->err),
+					       fd, fdpath);
+				} else {
+					TH_LOG("openat2 with %s should fail with %d (%s), got %d (%s)",
+					       test->name, test->err,
+					       strerror(-test->err),
+					       fd, strerror(-fd));
+				}
+			}
+			if (fd >= 0)
+				close(fd);
 		}
 
-skip:
-		if (test->err >= 0)
-			resultfn("openat2 with %s succeeds\n", test->name);
-		else
-			resultfn("openat2 with %s fails with %d (%s)\n",
-				 test->name, test->err, strerror(-test->err));
-next:
 		free(fdpath);
-		fflush(stdout);
 	}
 }
 
-#define NUM_TESTS (NUM_OPENAT2_STRUCT_VARIATIONS * NUM_OPENAT2_STRUCT_TESTS + \
-		   NUM_OPENAT2_FLAG_TESTS)
-
-int main(int argc, char **argv)
-{
-	ksft_print_header();
-	ksft_set_plan(NUM_TESTS);
-
-	test_openat2_struct();
-	test_openat2_flags();
-
-	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
-		ksft_exit_fail();
-	else
-		ksft_exit_pass();
-}
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/openat2/rename_attack_test.c b/tools/testing/selftests/openat2/rename_attack_test.c
index aa5699e45729..1f33c34f56be 100644
--- a/tools/testing/selftests/openat2/rename_attack_test.c
+++ b/tools/testing/selftests/openat2/rename_attack_test.c
@@ -22,44 +22,21 @@
 #include <limits.h>
 #include <unistd.h>
 
-#include "kselftest.h"
 #include "helpers.h"
+#include "kselftest_harness.h"
 
-/* Construct a test directory with the following structure:
- *
- * root/
- * |-- a/
- * |   `-- c/
- * `-- b/
- */
-int setup_testdir(void)
-{
-	int dfd;
-	char dirname[] = "/tmp/ksft-openat2-rename-attack.XXXXXX";
-
-	/* Make the top-level directory. */
-	if (!mkdtemp(dirname))
-		ksft_exit_fail_msg("setup_testdir: failed to create tmpdir\n");
-	dfd = open(dirname, O_PATH | O_DIRECTORY);
-	if (dfd < 0)
-		ksft_exit_fail_msg("setup_testdir: failed to open tmpdir\n");
-
-	E_mkdirat(dfd, "a", 0755);
-	E_mkdirat(dfd, "b", 0755);
-	E_mkdirat(dfd, "a/c", 0755);
-
-	return dfd;
-}
+#define ROUNDS 400000
 
 /* Swap @dirfd/@a and @dirfd/@b constantly. Parent must kill this process. */
-pid_t spawn_attack(int dirfd, char *a, char *b)
+pid_t spawn_attack(struct __test_metadata *_metadata,
+		   int dirfd, char *a, char *b)
 {
 	pid_t child = fork();
 	if (child != 0)
 		return child;
 
 	/* If the parent (the test process) dies, kill ourselves too. */
-	E_prctl(PR_SET_PDEATHSIG, SIGKILL);
+	ASSERT_EQ(prctl(PR_SET_PDEATHSIG, SIGKILL), 0);
 
 	/* Swap @a and @b. */
 	for (;;)
@@ -67,52 +44,90 @@ pid_t spawn_attack(int dirfd, char *a, char *b)
 	exit(1);
 }
 
-#define NUM_RENAME_TESTS 2
-#define ROUNDS 400000
+/*
+ * Construct a test directory with the following structure:
+ *
+ * root/
+ * |-- a/
+ * |   `-- c/
+ * `-- b/
+ */
+FIXTURE(rename_attack) {
+	int dfd;
+	int afd;
+	pid_t child;
+};
 
-const char *flagname(int resolve)
+FIXTURE_SETUP(rename_attack)
 {
-	switch (resolve) {
-	case RESOLVE_IN_ROOT:
-		return "RESOLVE_IN_ROOT";
-	case RESOLVE_BENEATH:
-		return "RESOLVE_BENEATH";
-	}
-	return "(unknown)";
+	char dirname[] = "/tmp/ksft-openat2-rename-attack.XXXXXX";
+
+	self->dfd = -1;
+	self->afd = -1;
+	self->child = 0;
+
+	/* Make the top-level directory. */
+	ASSERT_NE(mkdtemp(dirname), NULL);
+	self->dfd = open(dirname, O_PATH | O_DIRECTORY);
+	ASSERT_GE(self->dfd, 0);
+
+	ASSERT_EQ(mkdirat(self->dfd, "a", 0755), 0);
+	ASSERT_EQ(mkdirat(self->dfd, "b", 0755), 0);
+	ASSERT_EQ(mkdirat(self->dfd, "a/c", 0755), 0);
+
+	self->afd = openat(self->dfd, "a", O_PATH);
+	ASSERT_GE(self->afd, 0);
+
+	self->child = spawn_attack(_metadata, self->dfd, "a/c", "b");
+	ASSERT_GT(self->child, 0);
 }
 
-void test_rename_attack(int resolve)
+FIXTURE_TEARDOWN(rename_attack)
 {
-	int dfd, afd;
-	pid_t child;
-	void (*resultfn)(const char *msg, ...) = ksft_test_result_pass;
-	int escapes = 0, other_errs = 0, exdevs = 0, eagains = 0, successes = 0;
+	if (self->child > 0)
+		kill(self->child, SIGKILL);
+	if (self->afd >= 0)
+		close(self->afd);
+	if (self->dfd >= 0)
+		close(self->dfd);
+}
+
+FIXTURE_VARIANT(rename_attack) {
+	int resolve;
+	const char *name;
+};
 
+FIXTURE_VARIANT_ADD(rename_attack, resolve_beneath) {
+	.resolve = RESOLVE_BENEATH,
+	.name = "RESOLVE_BENEATH",
+};
+
+FIXTURE_VARIANT_ADD(rename_attack, resolve_in_root) {
+	.resolve = RESOLVE_IN_ROOT,
+	.name = "RESOLVE_IN_ROOT",
+};
+
+TEST_F_TIMEOUT(rename_attack, test, 120)
+{
+	int escapes = 0, successes = 0, other_errs = 0, exdevs = 0, eagains = 0;
+	char *victim_path = "c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../..";
 	struct open_how how = {
 		.flags = O_PATH,
-		.resolve = resolve,
+		.resolve = variant->resolve,
 	};
 
 	if (!openat2_supported) {
 		how.resolve = 0;
-		ksft_print_msg("openat2(2) unsupported -- using openat(2) instead\n");
+		TH_LOG("openat2(2) unsupported -- using openat(2) instead");
 	}
 
-	dfd = setup_testdir();
-	afd = openat(dfd, "a", O_PATH);
-	if (afd < 0)
-		ksft_exit_fail_msg("test_rename_attack: failed to open 'a'\n");
-
-	child = spawn_attack(dfd, "a/c", "b");
-
 	for (int i = 0; i < ROUNDS; i++) {
 		int fd;
-		char *victim_path = "c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../../c/../..";
 
 		if (openat2_supported)
-			fd = sys_openat2(afd, victim_path, &how);
+			fd = sys_openat2(self->afd, victim_path, &how);
 		else
-			fd = sys_openat(afd, victim_path, &how);
+			fd = sys_openat(self->afd, victim_path, &how);
 
 		if (fd < 0) {
 			if (fd == -EAGAIN)
@@ -124,37 +139,21 @@ void test_rename_attack(int resolve)
 			else
 				other_errs++; /* unexpected error */
 		} else {
-			if (fdequal(fd, afd, NULL))
+			if (fdequal(_metadata, fd, self->afd, NULL))
 				successes++;
 			else
 				escapes++; /* we got an unexpected fd */
 		}
-		close(fd);
+		if (fd >= 0)
+			close(fd);
 	}
 
-	if (escapes > 0)
-		resultfn = ksft_test_result_fail;
-	ksft_print_msg("non-escapes: EAGAIN=%d EXDEV=%d E<other>=%d success=%d\n",
-		       eagains, exdevs, other_errs, successes);
-	resultfn("rename attack with %s (%d runs, got %d escapes)\n",
-		 flagname(resolve), ROUNDS, escapes);
-
-	/* Should be killed anyway, but might as well make sure. */
-	E_kill(child, SIGKILL);
+	TH_LOG("non-escapes: EAGAIN=%d EXDEV=%d E<other>=%d success=%d",
+	       eagains, exdevs, other_errs, successes);
+	ASSERT_EQ(escapes, 0) {
+		TH_LOG("rename attack with %s (%d runs, got %d escapes)",
+		       variant->name, ROUNDS, escapes);
+	}
 }
 
-#define NUM_TESTS NUM_RENAME_TESTS
-
-int main(int argc, char **argv)
-{
-	ksft_print_header();
-	ksft_set_plan(NUM_TESTS);
-
-	test_rename_attack(RESOLVE_BENEATH);
-	test_rename_attack(RESOLVE_IN_ROOT);
-
-	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
-		ksft_exit_fail();
-	else
-		ksft_exit_pass();
-}
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/openat2/resolve_test.c
index f7acb4300641..eacde59ce158 100644
--- a/tools/testing/selftests/openat2/resolve_test.c
+++ b/tools/testing/selftests/openat2/resolve_test.c
@@ -14,8 +14,81 @@
 #include <stdbool.h>
 #include <string.h>
 
-#include "kselftest.h"
 #include "helpers.h"
+#include "kselftest_harness.h"
+
+struct resolve_test {
+	const char *name;
+	const char *dir;
+	const char *path;
+	struct open_how how;
+	bool pass;
+	union {
+		int err;
+		const char *path;
+	} out;
+};
+
+/*
+ * Verify a single resolve test case. This must be called from within a TEST_F
+ * function with _metadata in scope.
+ */
+static void verify_resolve_test(struct __test_metadata *_metadata,
+				int rootfd, int hardcoded_fd,
+				const struct resolve_test *test)
+{
+	struct open_how how = test->how;
+	int dfd, fd;
+	char *fdpath = NULL;
+
+	/* Auto-set O_PATH. */
+	if (!(how.flags & O_CREAT))
+		how.flags |= O_PATH;
+
+	if (test->dir)
+		dfd = openat(rootfd, test->dir, O_PATH | O_DIRECTORY);
+	else
+		dfd = dup(rootfd);
+	ASSERT_GE(dfd, 0) TH_LOG("failed to open dir '%s': %m", test->dir ?: ".");
+	ASSERT_EQ(dup2(dfd, hardcoded_fd), hardcoded_fd);
+
+	fd = sys_openat2(dfd, test->path, &how);
+
+	if (test->pass) {
+		EXPECT_GE(fd, 0) {
+			TH_LOG("%s: expected success, got %d (%s)",
+			       test->name, fd, strerror(-fd));
+		}
+		if (fd >= 0) {
+			EXPECT_TRUE(fdequal(_metadata, fd, rootfd, test->out.path)) {
+				fdpath = fdreadlink(_metadata, fd);
+				TH_LOG("%s: wrong path '%s', expected '%s'",
+				       test->name, fdpath,
+				       test->out.path ?: ".");
+				free(fdpath);
+			}
+		}
+	} else {
+		EXPECT_EQ(test->out.err, fd) {
+			if (fd >= 0) {
+				fdpath = fdreadlink(_metadata, fd);
+				TH_LOG("%s: expected %d (%s), got %d['%s']",
+				       test->name, test->out.err,
+				       strerror(-test->out.err), fd, fdpath);
+				free(fdpath);
+			} else {
+				TH_LOG("%s: expected %d (%s), got %d (%s)",
+				       test->name, test->out.err,
+				       strerror(-test->out.err),
+				       fd, strerror(-fd));
+			}
+		}
+	}
+
+	if (fd >= 0)
+		close(fd);
+	close(dfd);
+}
 
 /*
  * Construct a test directory with the following structure:
@@ -39,101 +112,110 @@
  *     |-- absself -> /
  *     |-- self -> ../../root/
  *     |-- garbageself -> /../../root/
- *     |-- passwd -> ../cheeky/../cheeky/../etc/../etc/passwd
- *     |-- abspasswd -> /../cheeky/../cheeky/../etc/../etc/passwd
+ *     |-- passwd -> ../cheeky/../etc/../etc/passwd
+ *     |-- abspasswd -> /../cheeky/../etc/../etc/passwd
  *     |-- dotdotlink -> ../../../../../../../../../../../../../../etc/passwd
  *     `-- garbagelink -> /../../../../../../../../../../../../../../etc/passwd
  */
-int setup_testdir(void)
+FIXTURE(openat2_resolve) {
+	int rootfd;
+	int hardcoded_fd;
+	char *hardcoded_fdpath;
+	char *procselfexe;
+};
+
+FIXTURE_SETUP(openat2_resolve)
 {
-	int dfd, tmpfd;
 	char dirname[] = "/tmp/ksft-openat2-testdir.XXXXXX";
+	int dfd, tmpfd;
+
+	self->rootfd = -1;
+	self->hardcoded_fd = -1;
+	self->hardcoded_fdpath = NULL;
+	self->procselfexe = NULL;
+
+	/* NOTE: We should be checking for CAP_SYS_ADMIN here... */
+	if (geteuid() != 0)
+		SKIP(return, "all tests require euid == 0");
+	if (!openat2_supported)
+		SKIP(return, "openat2(2) not supported");
 
 	/* Unshare and make /tmp a new directory. */
-	E_unshare(CLONE_NEWNS);
-	E_mount("", "/tmp", "", MS_PRIVATE, "");
+	ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+	ASSERT_EQ(mount("", "/tmp", "", MS_PRIVATE, ""), 0);
 
 	/* Make the top-level directory. */
-	if (!mkdtemp(dirname))
-		ksft_exit_fail_msg("setup_testdir: failed to create tmpdir\n");
+	ASSERT_NE(mkdtemp(dirname), NULL);
 	dfd = open(dirname, O_PATH | O_DIRECTORY);
-	if (dfd < 0)
-		ksft_exit_fail_msg("setup_testdir: failed to open tmpdir\n");
+	ASSERT_GE(dfd, 0);
 
 	/* A sub-directory which is actually used for tests. */
-	E_mkdirat(dfd, "root", 0755);
+	ASSERT_EQ(mkdirat(dfd, "root", 0755), 0);
 	tmpfd = openat(dfd, "root", O_PATH | O_DIRECTORY);
-	if (tmpfd < 0)
-		ksft_exit_fail_msg("setup_testdir: failed to open tmpdir\n");
+	ASSERT_GE(tmpfd, 0);
 	close(dfd);
 	dfd = tmpfd;
 
-	E_symlinkat("/proc/self/exe", dfd, "procexe");
-	E_symlinkat("/proc/self/root", dfd, "procroot");
-	E_mkdirat(dfd, "root", 0755);
+	ASSERT_EQ(symlinkat("/proc/self/exe", dfd, "procexe"), 0);
+	ASSERT_EQ(symlinkat("/proc/self/root", dfd, "procroot"), 0);
+	ASSERT_EQ(mkdirat(dfd, "root", 0755), 0);
 
 	/* There is no mountat(2), so use chdir. */
-	E_mkdirat(dfd, "mnt", 0755);
-	E_fchdir(dfd);
-	E_mount("tmpfs", "./mnt", "tmpfs", MS_NOSUID | MS_NODEV, "");
-	E_symlinkat("../mnt/", dfd, "mnt/self");
-	E_symlinkat("/mnt/", dfd, "mnt/absself");
-
-	E_mkdirat(dfd, "etc", 0755);
-	E_touchat(dfd, "etc/passwd");
-
-	E_symlinkat("/newfile3", dfd, "creatlink");
-	E_symlinkat("etc/", dfd, "reletc");
-	E_symlinkat("etc/passwd", dfd, "relsym");
-	E_symlinkat("/etc/", dfd, "absetc");
-	E_symlinkat("/etc/passwd", dfd, "abssym");
-	E_symlinkat("/cheeky", dfd, "abscheeky");
-
-	E_mkdirat(dfd, "cheeky", 0755);
-
-	E_symlinkat("/", dfd, "cheeky/absself");
-	E_symlinkat("../../root/", dfd, "cheeky/self");
-	E_symlinkat("/../../root/", dfd, "cheeky/garbageself");
-
-	E_symlinkat("../cheeky/../etc/../etc/passwd", dfd, "cheeky/passwd");
-	E_symlinkat("/../cheeky/../etc/../etc/passwd", dfd, "cheeky/abspasswd");
-
-	E_symlinkat("../../../../../../../../../../../../../../etc/passwd",
-		    dfd, "cheeky/dotdotlink");
-	E_symlinkat("/../../../../../../../../../../../../../../etc/passwd",
-		    dfd, "cheeky/garbagelink");
-
-	return dfd;
+	ASSERT_EQ(mkdirat(dfd, "mnt", 0755), 0);
+	ASSERT_EQ(fchdir(dfd), 0);
+	ASSERT_EQ(mount("tmpfs", "./mnt", "tmpfs", MS_NOSUID | MS_NODEV, ""), 0);
+	ASSERT_EQ(symlinkat("../mnt/", dfd, "mnt/self"), 0);
+	ASSERT_EQ(symlinkat("/mnt/", dfd, "mnt/absself"), 0);
+
+	ASSERT_EQ(mkdirat(dfd, "etc", 0755), 0);
+	ASSERT_GE(touchat(dfd, "etc/passwd"), 0);
+
+	ASSERT_EQ(symlinkat("/newfile3", dfd, "creatlink"), 0);
+	ASSERT_EQ(symlinkat("etc/", dfd, "reletc"), 0);
+	ASSERT_EQ(symlinkat("etc/passwd", dfd, "relsym"), 0);
+	ASSERT_EQ(symlinkat("/etc/", dfd, "absetc"), 0);
+	ASSERT_EQ(symlinkat("/etc/passwd", dfd, "abssym"), 0);
+	ASSERT_EQ(symlinkat("/cheeky", dfd, "abscheeky"), 0);
+
+	ASSERT_EQ(mkdirat(dfd, "cheeky", 0755), 0);
+
+	ASSERT_EQ(symlinkat("/", dfd, "cheeky/absself"), 0);
+	ASSERT_EQ(symlinkat("../../root/", dfd, "cheeky/self"), 0);
+	ASSERT_EQ(symlinkat("/../../root/", dfd, "cheeky/garbageself"), 0);
+
+	ASSERT_EQ(symlinkat("../cheeky/../etc/../etc/passwd",
+			    dfd, "cheeky/passwd"), 0);
+	ASSERT_EQ(symlinkat("/../cheeky/../etc/../etc/passwd",
+			    dfd, "cheeky/abspasswd"), 0);
+
+	ASSERT_EQ(symlinkat("../../../../../../../../../../../../../../etc/passwd",
+			    dfd, "cheeky/dotdotlink"), 0);
+	ASSERT_EQ(symlinkat("/../../../../../../../../../../../../../../etc/passwd",
+			    dfd, "cheeky/garbagelink"), 0);
+
+	self->rootfd = dfd;
+
+	self->hardcoded_fd = open("/dev/null", O_RDONLY);
+	ASSERT_GE(self->hardcoded_fd, 0);
+	ASSERT_GE(asprintf(&self->hardcoded_fdpath, "self/fd/%d",
+			   self->hardcoded_fd), 0);
+	ASSERT_GE(asprintf(&self->procselfexe, "/proc/%d/exe", getpid()), 0);
 }
 
-struct basic_test {
-	const char *name;
-	const char *dir;
-	const char *path;
-	struct open_how how;
-	bool pass;
-	union {
-		int err;
-		const char *path;
-	} out;
-};
-
-#define NUM_OPENAT2_OPATH_TESTS 88
-
-void test_openat2_opath_tests(void)
+FIXTURE_TEARDOWN(openat2_resolve)
 {
-	int rootfd, hardcoded_fd;
-	char *procselfexe, *hardcoded_fdpath;
-
-	E_asprintf(&procselfexe, "/proc/%d/exe", getpid());
-	rootfd = setup_testdir();
-
-	hardcoded_fd = open("/dev/null", O_RDONLY);
-	E_assert(hardcoded_fd >= 0, "open fd to hardcode");
-	E_asprintf(&hardcoded_fdpath, "self/fd/%d", hardcoded_fd);
+	free(self->procselfexe);
+	free(self->hardcoded_fdpath);
+	if (self->hardcoded_fd >= 0)
+		close(self->hardcoded_fd);
+	if (self->rootfd >= 0)
+		close(self->rootfd);
+}
 
-	struct basic_test tests[] = {
-		/** RESOLVE_BENEATH **/
+/* Attempts to cross the dirfd should be blocked with -EXDEV. */
+TEST_F(openat2_resolve, resolve_beneath)
+{
+	struct resolve_test tests[] = {
 		/* Attempts to cross dirfd should be blocked. */
 		{ .name = "[beneath] jump to /",
 		  .path = "/",			.how.resolve = RESOLVE_BENEATH,
@@ -206,9 +288,17 @@ void test_openat2_opath_tests(void)
 		{ .name = "[beneath] tricky absolute + garbage link outside $root",
 		  .path = "abscheeky/garbagelink", .how.resolve = RESOLVE_BENEATH,
 		  .out.err = -EXDEV,		.pass = false },
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(tests); i++)
+		verify_resolve_test(_metadata, self->rootfd,
+				    self->hardcoded_fd, &tests[i]);
+}
 
-		/** RESOLVE_IN_ROOT **/
-		/* All attempts to cross the dirfd will be scoped-to-root. */
+/* All attempts to cross the dirfd will be scoped-to-root. */
+TEST_F(openat2_resolve, resolve_in_root)
+{
+	struct resolve_test tests[] = {
 		{ .name = "[in_root] jump to /",
 		  .path = "/",			.how.resolve = RESOLVE_IN_ROOT,
 		  .out.path = NULL,		.pass = true },
@@ -297,8 +387,17 @@ void test_openat2_opath_tests(void)
 						.how.mode = 0700,
 						.how.resolve = RESOLVE_IN_ROOT,
 		  .out.path = "newfile3",	.pass = true },
+	};
 
-		/** RESOLVE_NO_XDEV **/
+	for (int i = 0; i < ARRAY_SIZE(tests); i++)
+		verify_resolve_test(_metadata, self->rootfd,
+				    self->hardcoded_fd, &tests[i]);
+}
+
+/* Crossing mount boundaries should be blocked. */
+TEST_F(openat2_resolve, resolve_no_xdev)
+{
+	struct resolve_test tests[] = {
 		/* Crossing *down* into a mountpoint is disallowed. */
 		{ .name = "[no_xdev] cross into $mnt",
 		  .path = "mnt",		.how.resolve = RESOLVE_NO_XDEV,
@@ -347,10 +446,19 @@ void test_openat2_opath_tests(void)
 		  .out.err = -EXDEV,			.pass = false },
 		/* Except magic-link jumps inside the same vfsmount. */
 		{ .name = "[no_xdev] jump through magic-link to same procfs",
-		  .dir = "/proc", .path = hardcoded_fdpath, .how.resolve = RESOLVE_NO_XDEV,
-		  .out.path = "/proc",			    .pass = true, },
+		  .dir = "/proc", .path = self->hardcoded_fdpath, .how.resolve = RESOLVE_NO_XDEV,
+		  .out.path = "/proc",				  .pass = true, },
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(tests); i++)
+		verify_resolve_test(_metadata, self->rootfd,
+				    self->hardcoded_fd, &tests[i]);
+}
 
-		/** RESOLVE_NO_MAGICLINKS **/
+/* Procfs-style magic-link resolution should be blocked. */
+TEST_F(openat2_resolve, resolve_no_magiclinks)
+{
+	struct resolve_test tests[] = {
 		/* Regular symlinks should work. */
 		{ .name = "[no_magiclinks] ordinary relative symlink",
 		  .path = "relsym",		.how.resolve = RESOLVE_NO_MAGICLINKS,
@@ -365,7 +473,7 @@ void test_openat2_opath_tests(void)
 		{ .name = "[no_magiclinks] normal path to magic-link with O_NOFOLLOW",
 		  .path = "/proc/self/exe",	.how.flags = O_NOFOLLOW,
 						.how.resolve = RESOLVE_NO_MAGICLINKS,
-		  .out.path = procselfexe,	.pass = true },
+		  .out.path = self->procselfexe, .pass = true },
 		{ .name = "[no_magiclinks] symlink to magic-link path component",
 		  .path = "procroot/etc",	.how.resolve = RESOLVE_NO_MAGICLINKS,
 		  .out.err = -ELOOP,		.pass = false },
@@ -376,8 +484,17 @@ void test_openat2_opath_tests(void)
 		  .path = "/proc/self/root/etc", .how.flags = O_NOFOLLOW,
 						 .how.resolve = RESOLVE_NO_MAGICLINKS,
 		  .out.err = -ELOOP,		.pass = false },
+	};
+
+	for (int i = 0; i < ARRAY_SIZE(tests); i++)
+		verify_resolve_test(_metadata, self->rootfd,
+				    self->hardcoded_fd, &tests[i]);
+}
 
-		/** RESOLVE_NO_SYMLINKS **/
+/* All symlink resolution should be blocked. */
+TEST_F(openat2_resolve, resolve_no_symlinks)
+{
+	struct resolve_test tests[] = {
 		/* Normal paths should work. */
 		{ .name = "[no_symlinks] ordinary path to '.'",
 		  .path = ".",			.how.resolve = RESOLVE_NO_SYMLINKS,
@@ -436,88 +553,9 @@ void test_openat2_opath_tests(void)
 		  .out.err = -ELOOP,		.pass = false },
 	};
 
-	BUILD_BUG_ON(ARRAY_SIZE(tests) != NUM_OPENAT2_OPATH_TESTS);
-
-	for (int i = 0; i < ARRAY_SIZE(tests); i++) {
-		int dfd, fd;
-		char *fdpath = NULL;
-		bool failed;
-		void (*resultfn)(const char *msg, ...) = ksft_test_result_pass;
-		struct basic_test *test = &tests[i];
-
-		if (!openat2_supported) {
-			ksft_print_msg("openat2(2) unsupported\n");
-			resultfn = ksft_test_result_skip;
-			goto skip;
-		}
-
-		/* Auto-set O_PATH. */
-		if (!(test->how.flags & O_CREAT))
-			test->how.flags |= O_PATH;
-
-		if (test->dir)
-			dfd = openat(rootfd, test->dir, O_PATH | O_DIRECTORY);
-		else
-			dfd = dup(rootfd);
-		E_assert(dfd, "failed to openat root '%s': %m", test->dir);
-
-		E_dup2(dfd, hardcoded_fd);
-
-		fd = sys_openat2(dfd, test->path, &test->how);
-		if (test->pass)
-			failed = (fd < 0 || !fdequal(fd, rootfd, test->out.path));
-		else
-			failed = (fd != test->out.err);
-		if (fd >= 0) {
-			fdpath = fdreadlink(fd);
-			close(fd);
-		}
-		close(dfd);
-
-		if (failed) {
-			resultfn = ksft_test_result_fail;
-
-			ksft_print_msg("openat2 unexpectedly returned ");
-			if (fdpath)
-				ksft_print_msg("%d['%s']\n", fd, fdpath);
-			else
-				ksft_print_msg("%d (%s)\n", fd, strerror(-fd));
-		}
-
-skip:
-		if (test->pass)
-			resultfn("%s gives path '%s'\n", test->name,
-				 test->out.path ?: ".");
-		else
-			resultfn("%s fails with %d (%s)\n", test->name,
-				 test->out.err, strerror(-test->out.err));
-
-		fflush(stdout);
-		free(fdpath);
-	}
-
-	free(procselfexe);
-	close(rootfd);
-
-	free(hardcoded_fdpath);
-	close(hardcoded_fd);
+	for (int i = 0; i < ARRAY_SIZE(tests); i++)
+		verify_resolve_test(_metadata, self->rootfd,
+				    self->hardcoded_fd, &tests[i]);
 }
 
-#define NUM_TESTS NUM_OPENAT2_OPATH_TESTS
-
-int main(int argc, char **argv)
-{
-	ksft_print_header();
-	ksft_set_plan(NUM_TESTS);
-
-	/* NOTE: We should be checking for CAP_SYS_ADMIN here... */
-	if (geteuid() != 0)
-		ksft_exit_skip("all tests require euid == 0\n");
-
-	test_openat2_opath_tests();
-
-	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
-		ksft_exit_fail();
-	else
-		ksft_exit_pass();
-}
+TEST_HARNESS_MAIN

-- 
2.53.0

