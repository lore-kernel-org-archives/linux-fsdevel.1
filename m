Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2273E9592
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774964644; cv=none; b=XKO4LCEidtCRYq+eCoVW/JHJD18KfWPmygDM7Tw7KrLHOlrbeh/k0W7Q+0uKdccrCQirXX4IzVfYiqxFbCgMlC2LUVR/Ee4R1wDxBMNbvLb2Xbjs+jyMYTmCA+XC2JSU+oBcjqChpSkaqxwkqRoXGxZzj22mE0VpuQDTucEAxqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774964644; c=relaxed/simple;
	bh=C/blpW9mkcp1Sm/ES0cZwHxL+COPvcIEw6kZngLfqx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=crVDi1a/Tzgpgtd6qxdYPxIvO1MMmSOeJtjtWzoh+IsocIlI3D9hSWdN+N2rOkk72GASUE63o8hD5ysMz2VbzDaHrCOFvWyBwKjvUDyn5TxU5BWC+gwB9Yvb9ZVpZONQrqImF6NdJd5v0luypZ0ERUZUPNgnTyzVnubjMNoYBVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com; spf=pass smtp.mailfrom=amutable.com; dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b=JPycP/Sy; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20230601.gappssmtp.com header.i=@amutable-com.20230601.gappssmtp.com header.b="JPycP/Sy"
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-7d7d4ebccf7so4833127a34.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 06:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20230601.gappssmtp.com; s=20230601; t=1774964639; x=1775569439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6D8X781T+RNnC32u5GL3wA0wuV/pMcGCJFnR7jmmuRI=;
        b=JPycP/SygYIkkzodBKPQQ3hovsTx/HakK7cwGVPBNkFZbIdpFbqL6jwIdGIstIemFZ
         gImPPNZXhjnET2XHeRgelxakXh9SaFQ3AXI3T7y7PQOvqQqOMGep+ILMX38rJn2gSTop
         MrBw9McHZUrR9Nh+obrQt9Sm2TWPKlEkcxKg/grarKZh2qNNSHrE5EUNa/VsBgrovSUC
         yXp5Sx0O6nKh0d+jCh+d+QG+du+DScKQOeuGPQNhBAfmju5B8h+jBAGwx9H/33lb8ubn
         KMHZ+iY0ONINsPDl2oVfSIkbj68olwl37LOCHHNEO1ZcJYFWBkRg0A46/FVi0Vf9GpBk
         VzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774964639; x=1775569439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6D8X781T+RNnC32u5GL3wA0wuV/pMcGCJFnR7jmmuRI=;
        b=Mja5f94wJ7QBaQ9mnQRFJzCmZycSg3uQwEAdIYSDaZ6A6Rp9drVTUkq3CgjEocts4X
         j6ybzy2WQkBCFpEldWd8IROb2JpxAGIInIQ1AdNVU8Hv6Ghc1/uE1aiQNqvfoUbA13Xr
         WpGksqk+MbfRiA78M4udzX+QmHcNF0W/Ec0pSK5kBCdDUoy+PUW8FiG9pCTKvcfz3JMb
         fsK/B+0xzF9XU9xtAiwRSwi86S9cSJ1OyNguGGC7weJKOP1G7pjF2/s0tifZOp7Db945
         /xP/XwrbUgS7cvqdavtT0za5HOxqwTiHeodL7sITOeg36JAwNNEtVXXYv20sZ9f0N1jQ
         3J1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzp4jZXkHaHjUHTz3RhQq/sAPVVzvzvevkwbslMYjICZntY8ddsDKdK0hjXA4zvaIQBFzpLrVvOOxjmNpD@vger.kernel.org
X-Gm-Message-State: AOJu0YyoVwCzavBzO28r+h/DXcPMsHE8PAWfRtlAQJdyhj/AQNuF521u
	FQjigIxhjwdkQhhqD1IN0wkNm4UG29rkZW0o/eHjddhNA1vTwCOXV35OWYnq3tcrbk9/
X-Gm-Gg: ATEYQzyxhCpbRm8ZtyNfSngwfZUoehSLh01Lhni56seSG1gIpyjaQgZi80IxyF9rIYt
	CJvs+y9avBWbCf8pwezPrT+xy0Rl8hDseGpMVLmMt21oGeV2Y90i4LtDB7laCbKYARcEyHZ+dHP
	6J1wVlcBm/Iy2ciaUxfmCojO0cBQfnK9iGyQ5ECvDWXLmocKYduSpRNcdlU7l2nVD/80DQDPS2v
	Uzriyqt/6nxGyfJTiT3EGqrIneexHcf55pqRCirhqpgMtagUzGNLdyuI0USEHmqNwwqRH7w/9ms
	ERYyWr59Qaf+McrmlUyuFnYMpN4m9lwPzeD6/A048p+j+fRAuilGwPvBcmOmNuPTFEOs5ksIYx1
	ig4E4r8sAUn6YTyf7mvpliwfQDpncoVRJaD88Ue9/cjrgRVmXpDFuZ/z9Nn7DJdordzJNwCmD/k
	iCmHGP7unSaYMNCkxRXxrwDqDDTG7N8UFM13QawGnu68Fu1b/zLZVlQ90UAKZcFgnhJCduV6gwR
	QfaVcnEk1uJOBmZNi/0w+ez
X-Received: by 2002:a05:6820:2212:b0:67b:ab68:b5e2 with SMTP id 006d021491bc7-67e1863b1b2mr9465431eaf.18.1774964639205;
        Tue, 31 Mar 2026 06:43:59 -0700 (PDT)
Received: from thesius.dot.cyphar.com (2403-5809-a2fc-2-a90-9fd7-aedd-d405.ip6.aussiebb.net. [2403:5809:a2fc:2:a90:9fd7:aedd:d405])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04d95bcasm7470456fac.17.2026.03.31.06.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 06:43:58 -0700 (PDT)
From: Aleksa Sarai <aleksa@amutable.com>
Date: Wed, 01 Apr 2026 00:43:31 +1100
Subject: [PATCH 1/3] selftests: openat2: move helpers to header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-openat2-selftests-kunit-v1-1-5819ac6cadf5@amutable.com>
References: <20260401-openat2-selftests-kunit-v1-0-5819ac6cadf5@amutable.com>
In-Reply-To: <20260401-openat2-selftests-kunit-v1-0-5819ac6cadf5@amutable.com>
To: Shuah Khan <shuah@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Aleksa Sarai <aleksa@amutable.com>, Aleksa Sarai <cyphar@cyphar.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8040; i=aleksa@amutable.com;
 h=from:subject:message-id; bh=C/blpW9mkcp1Sm/ES0cZwHxL+COPvcIEw6kZngLfqx4=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWSePj9dVi1TgenQtMdf7J9/j2Pyd1o542XCigOhkW8fF
 RQs9vFl65jIwiDGxWAppsiyzc8zdNP8xVeSP61kg5nDygQyRFqkgYGBgYGFgS83Ma/USMdIz1Tb
 UM/QSMdIx4iBi1MApvrWM4a/whvc9i/6qBUjeN+s+0/NqgeOcz5snHyir8D9yePkY5F3zRj+Jxx
 99/DEPSebDYZcW/cteq6l/epTZM7x4Ldfu6teB5/hZQMA
X-Developer-Key: i=aleksa@amutable.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

This is a bit ugly, but in the next patch we will move to using
kselftest_harness.h -- which doesn't play well with being included in
multiple compilation units due to duplicate function definitions.

Not including kselftest_harness.h would let us avoid this patch, but the
helpers will need include kselftest_harness.h in order to switch to
TH_LOG.

Signed-off-by: Aleksa Sarai <aleksa@amutable.com>
---
 tools/testing/selftests/openat2/Makefile  |   2 -
 tools/testing/selftests/openat2/helpers.c | 109 --------------------------
 tools/testing/selftests/openat2/helpers.h | 125 +++++++++++++++++++++++++-----
 3 files changed, 107 insertions(+), 129 deletions(-)

diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
index 185dc76ebb5f..3100b4d8d1b2 100644
--- a/tools/testing/selftests/openat2/Makefile
+++ b/tools/testing/selftests/openat2/Makefile
@@ -14,5 +14,3 @@ endif
 LOCAL_HDRS += helpers.h
 
 include ../lib.mk
-
-$(TEST_GEN_PROGS): helpers.c
diff --git a/tools/testing/selftests/openat2/helpers.c b/tools/testing/selftests/openat2/helpers.c
deleted file mode 100644
index 5074681ffdc9..000000000000
--- a/tools/testing/selftests/openat2/helpers.c
+++ /dev/null
@@ -1,109 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Author: Aleksa Sarai <cyphar@cyphar.com>
- * Copyright (C) 2018-2019 SUSE LLC.
- */
-
-#define _GNU_SOURCE
-#include <errno.h>
-#include <fcntl.h>
-#include <stdbool.h>
-#include <string.h>
-#include <syscall.h>
-#include <limits.h>
-
-#include "helpers.h"
-
-bool needs_openat2(const struct open_how *how)
-{
-	return how->resolve != 0;
-}
-
-int raw_openat2(int dfd, const char *path, void *how, size_t size)
-{
-	int ret = syscall(__NR_openat2, dfd, path, how, size);
-	return ret >= 0 ? ret : -errno;
-}
-
-int sys_openat2(int dfd, const char *path, struct open_how *how)
-{
-	return raw_openat2(dfd, path, how, sizeof(*how));
-}
-
-int sys_openat(int dfd, const char *path, struct open_how *how)
-{
-	int ret = openat(dfd, path, how->flags, how->mode);
-	return ret >= 0 ? ret : -errno;
-}
-
-int sys_renameat2(int olddirfd, const char *oldpath,
-		  int newdirfd, const char *newpath, unsigned int flags)
-{
-	int ret = syscall(__NR_renameat2, olddirfd, oldpath,
-					  newdirfd, newpath, flags);
-	return ret >= 0 ? ret : -errno;
-}
-
-int touchat(int dfd, const char *path)
-{
-	int fd = openat(dfd, path, O_CREAT, 0700);
-	if (fd >= 0)
-		close(fd);
-	return fd;
-}
-
-char *fdreadlink(int fd)
-{
-	char *target, *tmp;
-
-	E_asprintf(&tmp, "/proc/self/fd/%d", fd);
-
-	target = malloc(PATH_MAX);
-	if (!target)
-		ksft_exit_fail_msg("fdreadlink: malloc failed\n");
-	memset(target, 0, PATH_MAX);
-
-	E_readlink(tmp, target, PATH_MAX);
-	free(tmp);
-	return target;
-}
-
-bool fdequal(int fd, int dfd, const char *path)
-{
-	char *fdpath, *dfdpath, *other;
-	bool cmp;
-
-	fdpath = fdreadlink(fd);
-	dfdpath = fdreadlink(dfd);
-
-	if (!path)
-		E_asprintf(&other, "%s", dfdpath);
-	else if (*path == '/')
-		E_asprintf(&other, "%s", path);
-	else
-		E_asprintf(&other, "%s/%s", dfdpath, path);
-
-	cmp = !strcmp(fdpath, other);
-
-	free(fdpath);
-	free(dfdpath);
-	free(other);
-	return cmp;
-}
-
-bool openat2_supported = false;
-
-void __attribute__((constructor)) init(void)
-{
-	struct open_how how = {};
-	int fd;
-
-	BUILD_BUG_ON(sizeof(struct open_how) != OPEN_HOW_SIZE_VER0);
-
-	/* Check openat2(2) support. */
-	fd = sys_openat2(AT_FDCWD, ".", &how);
-	openat2_supported = (fd >= 0);
-
-	if (fd >= 0)
-		close(fd);
-}
diff --git a/tools/testing/selftests/openat2/helpers.h b/tools/testing/selftests/openat2/helpers.h
index 510e60602511..975de513af86 100644
--- a/tools/testing/selftests/openat2/helpers.h
+++ b/tools/testing/selftests/openat2/helpers.h
@@ -2,6 +2,7 @@
 /*
  * Author: Aleksa Sarai <cyphar@cyphar.com>
  * Copyright (C) 2018-2019 SUSE LLC.
+ * Copyright (C) 2026 Amutable GmbH
  */
 
 #ifndef __RESOLVEAT_H__
@@ -11,19 +12,14 @@
 #include <stdint.h>
 #include <stdbool.h>
 #include <errno.h>
+#include <limits.h>
 #include <linux/types.h>
+#include <linux/unistd.h>
 #include "kselftest.h"
 
 #define ARRAY_LEN(X) (sizeof (X) / sizeof (*(X)))
 #define BUILD_BUG_ON(e) ((void)(sizeof(struct { int:(-!!(e)); })))
 
-#ifndef SYS_openat2
-#ifndef __NR_openat2
-#define __NR_openat2 437
-#endif /* __NR_openat2 */
-#define SYS_openat2 __NR_openat2
-#endif /* SYS_openat2 */
-
 /*
  * Arguments for how openat2(2) should open the target path. If @resolve is
  * zero, then openat2(2) operates very similarly to openat(2).
@@ -45,8 +41,6 @@ struct open_how {
 #define OPEN_HOW_SIZE_VER0	24 /* sizeof first published struct */
 #define OPEN_HOW_SIZE_LATEST	OPEN_HOW_SIZE_VER0
 
-bool needs_openat2(const struct open_how *how);
-
 #ifndef RESOLVE_IN_ROOT
 /* how->resolve flags for openat2(2). */
 #define RESOLVE_NO_XDEV		0x01 /* Block mount-point crossings
@@ -93,16 +87,111 @@ bool needs_openat2(const struct open_how *how);
 					   __FILE__, __LINE__, #expr, ##__VA_ARGS__); \
 	} while (0)
 
-int raw_openat2(int dfd, const char *path, void *how, size_t size);
-int sys_openat2(int dfd, const char *path, struct open_how *how);
-int sys_openat(int dfd, const char *path, struct open_how *how);
-int sys_renameat2(int olddirfd, const char *oldpath,
-		  int newdirfd, const char *newpath, unsigned int flags);
+__maybe_unused
+static bool needs_openat2(const struct open_how *how)
+{
+	return how->resolve != 0;
+}
+
+__maybe_unused
+static int raw_openat2(int dfd, const char *path, void *how, size_t size)
+{
+	int ret = syscall(__NR_openat2, dfd, path, how, size);
+
+	return ret >= 0 ? ret : -errno;
+}
+
+__maybe_unused
+static int sys_openat2(int dfd, const char *path, struct open_how *how)
+{
+	return raw_openat2(dfd, path, how, sizeof(*how));
+}
+
+__maybe_unused
+static int sys_openat(int dfd, const char *path, struct open_how *how)
+{
+	int ret = openat(dfd, path, how->flags, how->mode);
+
+	return ret >= 0 ? ret : -errno;
+}
+
+__maybe_unused
+static int sys_renameat2(int olddirfd, const char *oldpath,
+			 int newdirfd, const char *newpath, unsigned int flags)
+{
+	int ret = syscall(__NR_renameat2, olddirfd, oldpath,
+					  newdirfd, newpath, flags);
+
+	return ret >= 0 ? ret : -errno;
+}
+
+__maybe_unused
+static int touchat(int dfd, const char *path)
+{
+	int fd = openat(dfd, path, O_CREAT, 0700);
+
+	if (fd >= 0)
+		close(fd);
+	return fd;
+}
+
+__maybe_unused
+static char *fdreadlink(int fd)
+{
+	char *target, *tmp;
+
+	E_asprintf(&tmp, "/proc/self/fd/%d", fd);
+
+	target = malloc(PATH_MAX);
+	if (!target)
+		ksft_exit_fail_msg("fdreadlink: malloc failed\n");
+	memset(target, 0, PATH_MAX);
+
+	E_readlink(tmp, target, PATH_MAX);
+	free(tmp);
+	return target;
+}
+
+__maybe_unused
+static bool fdequal(int fd, int dfd, const char *path)
+{
+	char *fdpath, *dfdpath, *other;
+	bool cmp;
+
+	fdpath = fdreadlink(fd);
+	dfdpath = fdreadlink(dfd);
+
+	if (!path)
+		E_asprintf(&other, "%s", dfdpath);
+	else if (*path == '/')
+		E_asprintf(&other, "%s", path);
+	else
+		E_asprintf(&other, "%s/%s", dfdpath, path);
+
+	cmp = !strcmp(fdpath, other);
+
+	free(fdpath);
+	free(dfdpath);
+	free(other);
+	return cmp;
+}
+
+static bool openat2_supported = false;
+
+__attribute__((constructor))
+static void __detect_openat2_supported(void)
+{
+	struct open_how how = {};
+	int fd;
+
+	BUILD_BUG_ON(sizeof(struct open_how) != OPEN_HOW_SIZE_VER0);
 
-int touchat(int dfd, const char *path);
-char *fdreadlink(int fd);
-bool fdequal(int fd, int dfd, const char *path);
+	/* Check openat2(2) support. */
+	fd = sys_openat2(AT_FDCWD, ".", &how);
+	openat2_supported = (fd >= 0);
 
-extern bool openat2_supported;
+	if (fd >= 0)
+		close(fd);
+}
 
 #endif /* __RESOLVEAT_H__ */

-- 
2.53.0

