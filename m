Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473231D90DD;
	Mon, 23 Mar 2026 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271002; cv=none; b=cs0QyYO+jhoOmQ5WEMEPuSuGar0yd5Q2ShY4+WPwsMSlMrJ/hy2oJpxMbEhcFRUiDhE2rZR3lZG+giZNt37l4Bj7OA+BiCWwzxowHn+gjW+v7pZIaAedXWwxOsyjZTCE/6SxgB8HaqhZsNjMZLRSX+M3n/IZTQ4AkCj1oYuaaTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271002; c=relaxed/simple;
	bh=+Mf0HGgtJ7jMykcdgkHKx9oOijw3i7EvWBVhBh4++cA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gjrGnw9yU/tNqZzJ+eH4fhzM0l9MmYUKiObbgAiU7iYm/rvLg+f0/WdXzVbtC+WcY7OSafsFfrr8Vr4rfpUDTZpcVMOza3djqb6udZeQXj4wMgs1PR5vN1JV7iQ9IfFPiJMwQSiRVXe83FP9l3GKUkoMph0wG4IrwptjKzZZ8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDE5014BF;
	Mon, 23 Mar 2026 06:03:13 -0700 (PDT)
Received: from NH27D9T0LF (unknown [10.57.13.32])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 689D03F885;
	Mon, 23 Mar 2026 06:03:18 -0700 (PDT)
Date: Mon, 23 Mar 2026 14:03:15 +0100
From: Emanuele Rocca <emanuele.rocca@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v5 2/2] selftests: check pidfd_info->coredump_code correctness
Message-ID: <acE6Eyuv2MM75pmk@NH27D9T0LF>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acE5fYOgyVUYahIn@NH27D9T0LF>

Extend the coredump_socket and coredump_socket_protocol selftests to verify
that the field coredump_code is set as expected in struct pidfd_info.

Signed-off-by: Emanuele Rocca <emanuele.rocca@arm.com>
---
 .../coredump/coredump_socket_protocol_test.c  | 26 +++++++++++++++
 .../selftests/coredump/coredump_socket_test.c | 32 +++++++++++++++++++
 .../coredump/coredump_test_helpers.c          |  4 +--
 tools/testing/selftests/pidfd/pidfd.h         |  5 +++
 .../testing/selftests/pidfd/pidfd_info_test.c |  1 +
 5 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
index d19b6717c53e..d9fa6239b5a9 100644
--- a/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_protocol_test.c
@@ -1004,6 +1004,8 @@ TEST_F(coredump, socket_request_invalid_size_large)
  *
  * Verify that when using socket-based coredump protocol,
  * the coredump_signal field is correctly exposed as SIGSEGV.
+ * Also check that the coredump_code field is correctly exposed
+ * as SEGV_MAPERR.
  */
 TEST_F(coredump, socket_coredump_signal_sigsegv)
 {
@@ -1079,6 +1081,18 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
 			goto out;
 		}
 
+		/* Verify coredump_code is available and correct */
+		if (!(info.mask & PIDFD_INFO_COREDUMP_CODE)) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: PIDFD_INFO_COREDUMP_CODE not set in mask\n");
+			goto out;
+		}
+
+		if (info.coredump_code != SEGV_MAPERR) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: coredump_code=%d, expected SEGV_MAPERR=%d\n",
+				info.coredump_code, SEGV_MAPERR);
+			goto out;
+		}
+
 		if (!read_coredump_req(fd_coredump, &req)) {
 			fprintf(stderr, "socket_coredump_signal_sigsegv: read_coredump_req failed\n");
 			goto out;
@@ -1128,6 +1142,8 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
 	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
 	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL));
 	ASSERT_EQ(info.coredump_signal, SIGSEGV);
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_CODE));
+	ASSERT_EQ(info.coredump_code, SEGV_MAPERR);
 
 	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 }
@@ -1137,6 +1153,8 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
  *
  * Verify that when using socket-based coredump protocol,
  * the coredump_signal field is correctly exposed as SIGABRT.
+ * Also check that the coredump_code field is correctly exposed
+ * as SI_TKILL.
  */
 TEST_F(coredump, socket_coredump_signal_sigabrt)
 {
@@ -1212,6 +1230,12 @@ TEST_F(coredump, socket_coredump_signal_sigabrt)
 			goto out;
 		}
 
+		if (info.coredump_code != SI_TKILL) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: coredump_code=%d, expected SI_TKILL=%d\n",
+				info.coredump_code, SI_TKILL);
+			goto out;
+		}
+
 		if (!read_coredump_req(fd_coredump, &req)) {
 			fprintf(stderr, "socket_coredump_signal_sigabrt: read_coredump_req failed\n");
 			goto out;
@@ -1261,6 +1285,8 @@ TEST_F(coredump, socket_coredump_signal_sigabrt)
 	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
 	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL));
 	ASSERT_EQ(info.coredump_signal, SIGABRT);
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_CODE));
+	ASSERT_EQ(info.coredump_code, SI_TKILL);
 
 	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 }
diff --git a/tools/testing/selftests/coredump/coredump_socket_test.c b/tools/testing/selftests/coredump/coredump_socket_test.c
index 7e26d4a6a15d..422728f632ca 100644
--- a/tools/testing/selftests/coredump/coredump_socket_test.c
+++ b/tools/testing/selftests/coredump/coredump_socket_test.c
@@ -435,6 +435,8 @@ TEST_F(coredump, socket_no_listener)
  *
  * Verify that when using simple socket-based coredump (@ pattern),
  * the coredump_signal field is correctly exposed as SIGSEGV.
+ * Also check that the coredump_code field is correctly exposed
+ * as SEGV_MAPERR.
  */
 TEST_F(coredump, socket_coredump_signal_sigsegv)
 {
@@ -509,6 +511,18 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
 			goto out;
 		}
 
+		/* Verify coredump_code is available and correct */
+		if (!(info.mask & PIDFD_INFO_COREDUMP_CODE)) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: PIDFD_INFO_COREDUMP_CODE not set in mask\n");
+			goto out;
+		}
+
+		if (info.coredump_code != SEGV_MAPERR) {
+			fprintf(stderr, "socket_coredump_signal_sigsegv: coredump_code=%d, expected SEGV_MAPERR=%d\n",
+				info.coredump_code, SEGV_MAPERR);
+			goto out;
+		}
+
 		fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
 		if (fd_core_file < 0) {
 			fprintf(stderr, "socket_coredump_signal_sigsegv: open_coredump_tmpfile failed: %m\n");
@@ -572,6 +586,8 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
 	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
 	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL));
 	ASSERT_EQ(info.coredump_signal, SIGSEGV);
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_CODE));
+	ASSERT_EQ(info.coredump_code, SEGV_MAPERR);
 
 	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 }
@@ -581,6 +597,8 @@ TEST_F(coredump, socket_coredump_signal_sigsegv)
  *
  * Verify that when using simple socket-based coredump (@ pattern),
  * the coredump_signal field is correctly exposed as SIGABRT.
+ * Also check that the coredump_code field is correctly exposed
+ * as SI_TKILL.
  */
 TEST_F(coredump, socket_coredump_signal_sigabrt)
 {
@@ -655,6 +673,18 @@ TEST_F(coredump, socket_coredump_signal_sigabrt)
 			goto out;
 		}
 
+		/* Verify coredump_code is available and correct */
+		if (!(info.mask & PIDFD_INFO_COREDUMP_CODE)) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: PIDFD_INFO_COREDUMP_CODE not set in mask\n");
+			goto out;
+		}
+
+		if (info.coredump_code != SI_TKILL) {
+			fprintf(stderr, "socket_coredump_signal_sigabrt: coredump_code=%d, expected SI_TKILL=%d\n",
+				info.coredump_code, SI_TKILL);
+			goto out;
+		}
+
 		fd_core_file = open_coredump_tmpfile(self->fd_tmpfs_detached);
 		if (fd_core_file < 0) {
 			fprintf(stderr, "socket_coredump_signal_sigabrt: open_coredump_tmpfile failed: %m\n");
@@ -718,6 +748,8 @@ TEST_F(coredump, socket_coredump_signal_sigabrt)
 	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP));
 	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_SIGNAL));
 	ASSERT_EQ(info.coredump_signal, SIGABRT);
+	ASSERT_TRUE(!!(info.mask & PIDFD_INFO_COREDUMP_CODE));
+	ASSERT_EQ(info.coredump_code, SI_TKILL);
 
 	wait_and_check_coredump_server(pid_coredump_server, _metadata, self);
 }
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 5c8adee63641..a284694500e8 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -148,8 +148,8 @@ bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info)
 		fprintf(stderr, "get_pidfd_info: ioctl(PIDFD_GET_INFO) failed: %m\n");
 		return false;
 	}
-	fprintf(stderr, "get_pidfd_info: mask=0x%llx, coredump_mask=0x%x, coredump_signal=%d\n",
-		(unsigned long long)info->mask, info->coredump_mask, info->coredump_signal);
+	fprintf(stderr, "get_pidfd_info: mask=0x%llx, coredump_mask=0x%x, coredump_signal=%d, coredump_code=%d\n",
+		(unsigned long long)info->mask, info->coredump_mask, info->coredump_signal, info->coredump_code);
 	return true;
 }
 
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 9085c1a3c005..5a4e78c10f43 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -156,6 +156,10 @@
 #define PIDFD_INFO_COREDUMP_SIGNAL	(1UL << 6)
 #endif
 
+#ifndef PIDFD_INFO_COREDUMP_CODE
+#define PIDFD_INFO_COREDUMP_CODE	(1UL << 7)
+#endif
+
 #ifndef PIDFD_COREDUMPED
 #define PIDFD_COREDUMPED	(1U << 0) /* Did crash and... */
 #endif
@@ -194,6 +198,7 @@ struct pidfd_info {
 	struct {
 		__u32 coredump_mask;
 		__u32 coredump_signal;
+		__u32 coredump_code;
 	};
 	__u64 supported_mask;
 };
diff --git a/tools/testing/selftests/pidfd/pidfd_info_test.c b/tools/testing/selftests/pidfd/pidfd_info_test.c
index 8bed951e06a0..597012ed195f 100644
--- a/tools/testing/selftests/pidfd/pidfd_info_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_info_test.c
@@ -724,6 +724,7 @@ TEST(supported_mask_field)
 	ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_COREDUMP));
 	ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_SUPPORTED_MASK));
 	ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_COREDUMP_SIGNAL));
+	ASSERT_TRUE(!!(info.supported_mask & PIDFD_INFO_COREDUMP_CODE));
 
 	/* Clean up */
 	sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0);
-- 
2.47.3

