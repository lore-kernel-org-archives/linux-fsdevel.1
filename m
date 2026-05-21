Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E4C3B1014
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360949; cv=none; b=OLSIE3GE1GTxDJRWmG4s/1dXQ1KfSWtQhUES7Wfr9kRtZZzlhlG3iXK3oehQkJFicokpctcSx9tibQr5V7oBcvUnqVGbx4COLq8oIB+KkX7gdyVzithWYLUw7ww3vyWmVNnGUp969HS7+0fbKgSmVuJ7A7p7Aej1TYEvJhts48w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360949; c=relaxed/simple;
	bh=/Pis0C74gccGwF0o4rxjKZU6DPoH5celZ5U9jMEsdX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQOPoEHLsXRmB2BxP9+YHUWuU+Pl50/pJENeTlTw5OKtxzNUy3PlzRYxYExVmZOuen8LT/PuQpQTXO9wCtqyn49cFSjAkqX7RGyueWdsG8sxhNtv28pvzx4fsRgSE4TG2zKKKw+f4Dve835wcV49LehqZ/8t0q2ioo+hWIcyXF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVCL/w8l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVCL/w8l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CCA11F000E9;
	Thu, 21 May 2026 10:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779360947;
	bh=wK2S2kGgvHRiCRxXlwKpHXFHm85IERZZyBC/UJvlMcI=;
	h=From:To:Cc:Subject:Date;
	b=DVCL/w8lHOKGA3n5xY4G2d9vTflYqYYA5O947NBfszOHsYF47YG/ObBBoB++Qbe15
	 bTW3S6MY5SOdztXoGgDv3Mq/V87ADEbLK/11Go3JY5NYRJSd4xPm6EqqP4MOlBD4GQ
	 SYcMTS7b4L5tbVDTRz48BRKi8GYNoNW0xlYciAOdoCtWqlx8CbllGuyPokAzPaGM3X
	 TIadR3m7w1IYhYCjd8xpAOmhhiAV3IZxhbyj0TXun/OTFHU8U/7dq80qf1bZs2OVC/
	 HtTxAD4EsOPu2p8godYRTcA0Aom0KyoJlksT4bdUn6bei+c+WC/e5ikVfcuYVAmj1R
	 U8P6W0IGWfupA==
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>,
	Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] selftests: openat2: port emptypath_test to kselftest harness
Date: Thu, 21 May 2026 12:55:39 +0200
Message-ID: <20260521-wettstreit-meinen-46271dede480@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3638; i=brauner@kernel.org; h=from:subject:message-id; bh=/Pis0C74gccGwF0o4rxjKZU6DPoH5celZ5U9jMEsdX4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTxPVl755z4nmVOJ7+fX2EtmPnAhe9FxNeQkjlG+/a53 Ny6nVNnRUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEXrEwMtzktHA0NPDbxrSi zLWCyWDffxt1X18Dk51Hlza9y1FeysnIMMljx+Ky4G81sY2qdd1TLnR1nd4jc/pli2qLuULq3dQ cbgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Convert the emptypath selftests to the
FIXTURE_SETUP()/FIXTURE_TEARDOWN() and the two checks become TEST_F()s.
No change in coverage.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../filesystems/openat2/emptypath_test.c      | 92 ++++++++++++-------
 1 file changed, 57 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/filesystems/openat2/emptypath_test.c b/tools/testing/selftests/filesystems/openat2/emptypath_test.c
index d75b5e998ff9..be37ccba57ec 100644
--- a/tools/testing/selftests/filesystems/openat2/emptypath_test.c
+++ b/tools/testing/selftests/filesystems/openat2/emptypath_test.c
@@ -1,55 +1,77 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#define _GNU_SOURCE
 #define __SANE_USERSPACE_TYPES__
 #include <fcntl.h>
 #include <unistd.h>
 #include <errno.h>
+#include <string.h>
+#include <sys/stat.h>
 
-#include "kselftest.h"
+#include "kselftest_harness.h"
 
 #ifndef O_EMPTYPATH
 #define O_EMPTYPATH	(1 << 26)
 #endif
 
-int main(void)
+#define EMPTYPATH_TEST_FILE "/tmp/emptypath_test"
+
+FIXTURE(emptypath) {
+	int opath_fd;
+};
+
+FIXTURE_SETUP(emptypath)
 {
-	int opath_fd, reopen_fd;
-	const char *path = "/tmp/emptypath_test";
-
-	ksft_print_header();
-	ksft_set_plan(2);
-
-	opath_fd = open(path, O_CREAT | O_WRONLY, S_IRWXU);
-	if (opath_fd < 0)
-		ksft_exit_fail_msg("create %s: %m\n", path);
-	close(opath_fd);
-
-	opath_fd = open(path, O_PATH);
-	if (opath_fd < 0)
-		ksft_exit_fail_msg("open %s O_PATH: %m\n", path);
-
-	reopen_fd = openat(opath_fd, "", O_RDONLY);
-	if (reopen_fd < 0 && errno == ENOENT)
-		ksft_test_result_pass("empty path without O_EMPTYPATH returns ENOENT\n");
-	else if (reopen_fd >= 0) {
-		ksft_test_result_fail("empty path without O_EMPTYPATH unexpectedly succeeded\n");
-		close(reopen_fd);
-	} else {
-		ksft_test_result_fail("empty path without O_EMPTYPATH: expected ENOENT, got %m\n");
+	int fd;
+
+	self->opath_fd = -1;
+
+	fd = open(EMPTYPATH_TEST_FILE, O_CREAT | O_WRONLY, S_IRWXU);
+	ASSERT_GE(fd, 0) {
+		TH_LOG("create %s: %s", EMPTYPATH_TEST_FILE, strerror(errno));
 	}
+	close(fd);
 
-	reopen_fd = openat(opath_fd, "", O_RDONLY | O_EMPTYPATH);
+	self->opath_fd = open(EMPTYPATH_TEST_FILE, O_PATH);
+	ASSERT_GE(self->opath_fd, 0) {
+		TH_LOG("open %s O_PATH: %s", EMPTYPATH_TEST_FILE, strerror(errno));
+	}
+}
 
-	if (reopen_fd < 0 && errno == EINVAL)
-		ksft_exit_skip("O_EMPTYPATH not supported\n");
+FIXTURE_TEARDOWN(emptypath)
+{
+	if (self->opath_fd >= 0)
+		close(self->opath_fd);
+	unlink(EMPTYPATH_TEST_FILE);
+}
 
-	if (reopen_fd >= 0) {
-		ksft_test_result_pass("O_EMPTYPATH reopens O_PATH fd\n");
-		close(reopen_fd);
-	} else {
-		ksft_test_result_fail("O_EMPTYPATH failed: %m\n");
+/* An empty path is rejected with ENOENT unless O_EMPTYPATH is set. */
+TEST_F(emptypath, without_flag_returns_enoent)
+{
+	int fd = openat(self->opath_fd, "", O_RDONLY);
+
+	if (fd >= 0)
+		close(fd);
+	ASSERT_LT(fd, 0) {
+		TH_LOG("empty path without O_EMPTYPATH unexpectedly succeeded");
+	}
+	EXPECT_EQ(errno, ENOENT) {
+		TH_LOG("expected ENOENT, got %s", strerror(errno));
 	}
+}
+
+/* O_EMPTYPATH reopens the O_PATH fd through an empty path. */
+TEST_F(emptypath, reopens_opath_fd)
+{
+	int fd = openat(self->opath_fd, "", O_RDONLY | O_EMPTYPATH);
+
+	if (fd < 0 && errno == EINVAL)
+		SKIP(return, "O_EMPTYPATH not supported");
 
-	unlink(path);
-	ksft_finished();
+	ASSERT_GE(fd, 0) {
+		TH_LOG("O_EMPTYPATH failed: %s", strerror(errno));
+	}
+	close(fd);
 }
+
+TEST_HARNESS_MAIN
-- 
2.47.3

