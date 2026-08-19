Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508273D3CEA;
	Wed, 19 Aug 2026 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787181030; cv=none; b=TC22k9OBgMeyFeRTYm69MyKjyzWIArqSWjrerzrxNTW12dtrV4PNeT9gvEaTHOBoajV4eEV03QLysb498Yx65ZpPFYAK1+qE24eWn/OVgj5a3KmjnzkbjKf+JiNxce8HWUmFrIMm/tGk5cDUsHQuJmUW2orhqnJZc/xC60Bw4mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787181030; c=relaxed/simple;
	bh=nsuGWse/lAGPONW5/zPiRodF4aWWrgZOlUZ3HMqmnYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t8HJr4jWjY/++Z04fxKkK5AvxH7GL9MlvVjsiIF5Gw0IjdJxm9UkNHWYzo9kHA1L6IojSXwvPWkqkoptrqDUuudn+3rRF/XodtviQQyuT9WikcCVEuAv7zxGX6BqtsNv7kSF0gzeybsjxW0O7OmXOpq8ZLLPsQ/1Imt/aeHEFKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyZeAj5g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyZeAj5g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170201F000E9;
	Wed, 19 Aug 2026 23:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787181028;
	bh=YdXiWhIfB4/T9Skkykrd3/nKKqeoThgdVH++ESCo2VU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=QyZeAj5glCUzDjsxZE4JmbH5umochvY1cH28IICIMq+PVSNqs9f6uqzC3leCeKYeB
	 rfl/IBBdVwxU7IoZVCZk5U9aoMplnYPpsIRtSkZukDs9OzsIxCLpUdPh0RvEOuVohi
	 aPrB8VGlKZcBGkxy+NdZblHbunV0YNE0LJJngP4XBwkFXWjRgVDsk++j9VDR4YCUIP
	 F3a5HrJBM/Q/lJcKDMFOf5fWOe2ji9o/OeX3mhG8bepd2E0y5DVtZ2ONC5k+5VT52i
	 MDtcev4gHFqi35z6p3F3Ciy87B0Vi5vrvLU9DBq2wPALAkbyuovP9CBjRVq7gdXamp
	 /jf8Dukonc+rA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Aug 2026 01:09:23 +0200
Subject: [PATCH v2 06/22] selftests/coredump: add a separate helper header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-work-coredump-sparse-v2-6-ba32dd718c51@kernel.org>
References: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
In-Reply-To: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Omar Sandoval <osandov@osandov.com>, 
 Jacob Lalonde <jalalonde@fb.com>, Shuah Khan <shuah@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4984; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nsuGWse/lAGPONW5/zPiRodF4aWWrgZOlUZ3HMqmnYU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS1me+7qZKzWDv62wNhQ4FbqkVrA5z2f2iLbmV44Hffz
 2jyP3O/jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInIpjAyLPfN5Nk1U+fxDK+7
 ldo5fxJlvIJ871syHZ0lp/tU/In3E0aG3SmJPrszs04dFfu1f//hXI2t9wwsN1ir/97jk/ticbE
 KLwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Right now we have coredump_test.h which pulls in the test harness.
So it can't be included in coredump_test_helpers.c and it hand-rolls a
bunch of stuff that is not needed.

Instead of this mess, split everything out into a separate
coredump_test_helpers.h header and make both coredump_test.h and
coredump_test_helpers.c include it.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tools/testing/selftests/coredump/coredump_test.h   | 30 +-----------------
 .../selftests/coredump/coredump_test_helpers.c     | 17 +---------
 .../selftests/coredump/coredump_test_helpers.h     | 37 ++++++++++++++++++++++
 3 files changed, 39 insertions(+), 45 deletions(-)

diff --git a/tools/testing/selftests/coredump/coredump_test.h b/tools/testing/selftests/coredump/coredump_test.h
index a02809145e2d..8d99b5cb2f12 100644
--- a/tools/testing/selftests/coredump/coredump_test.h
+++ b/tools/testing/selftests/coredump/coredump_test.h
@@ -3,18 +3,9 @@
 #ifndef __COREDUMP_TEST_H
 #define __COREDUMP_TEST_H
 
-#include <stdbool.h>
-#include <sys/types.h>
-#include <linux/coredump.h>
-
 #include "../kselftest_harness.h"
-#include "../pidfd/pidfd.h"
-
-#ifndef PAGE_SIZE
-#define PAGE_SIZE 4096
-#endif
 
-#define NUM_THREAD_SPAWN 128
+#include "coredump_test_helpers.h"
 
 /* Coredump fixture */
 FIXTURE(coredump)
@@ -24,15 +15,6 @@ FIXTURE(coredump)
 	int fd_tmpfs_detached;
 };
 
-/* Shared helper function declarations */
-void *do_nothing(void *arg);
-void crashing_child(void);
-int create_detached_tmpfs(void);
-int create_and_listen_unix_socket(const char *path);
-bool set_core_pattern(const char *pattern);
-int get_peer_pidfd(int fd);
-bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info);
-
 /* Inline helper that uses harness types */
 static inline void wait_and_check_coredump_server(pid_t pid_coredump_server,
 						   struct __test_metadata *const _metadata,
@@ -45,14 +27,4 @@ static inline void wait_and_check_coredump_server(pid_t pid_coredump_server,
 	ASSERT_EQ(WEXITSTATUS(status), 0);
 }
 
-/* Protocol helper function declarations */
-ssize_t recv_marker(int fd);
-bool read_marker(int fd, enum coredump_mark mark);
-bool read_coredump_req(int fd, struct coredump_req *req);
-bool send_coredump_ack(int fd, const struct coredump_req *req,
-		       __u64 mask, size_t size_ack);
-bool check_coredump_req(const struct coredump_req *req);
-int open_coredump_tmpfile(int fd_tmpfs_detached);
-void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_file);
-
 #endif /* __COREDUMP_TEST_H */
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/tools/testing/selftests/coredump/coredump_test_helpers.c
index 306711e1b24d..570fc2e005c2 100644
--- a/tools/testing/selftests/coredump/coredump_test_helpers.c
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
@@ -20,23 +20,8 @@
 #include <unistd.h>
 
 #include "../filesystems/wrappers.h"
-#include "../pidfd/pidfd.h"
 
-/* Forward declarations to avoid including harness header */
-struct __test_metadata;
-
-/* Match the fixture definition from coredump_test.h */
-struct _fixture_coredump_data {
-	char original_core_pattern[256];
-	pid_t pid_coredump_server;
-	int fd_tmpfs_detached;
-};
-
-#ifndef PAGE_SIZE
-#define PAGE_SIZE 4096
-#endif
-
-#define NUM_THREAD_SPAWN 128
+#include "coredump_test_helpers.h"
 
 void *do_nothing(void *arg)
 {
diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.h b/tools/testing/selftests/coredump/coredump_test_helpers.h
new file mode 100644
index 000000000000..45904bd177b8
--- /dev/null
+++ b/tools/testing/selftests/coredump/coredump_test_helpers.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __COREDUMP_TEST_HELPERS_H
+#define __COREDUMP_TEST_HELPERS_H
+
+#include <stdbool.h>
+#include <sys/types.h>
+#include <linux/coredump.h>
+
+#include "../pidfd/pidfd.h"
+
+#ifndef PAGE_SIZE
+#define PAGE_SIZE 4096
+#endif
+
+#define NUM_THREAD_SPAWN 128
+
+/* Shared helper function declarations */
+void *do_nothing(void *arg);
+void crashing_child(void);
+int create_detached_tmpfs(void);
+int create_and_listen_unix_socket(const char *path);
+bool set_core_pattern(const char *pattern);
+int get_peer_pidfd(int fd);
+bool get_pidfd_info(int fd_peer_pidfd, struct pidfd_info *info);
+
+/* Protocol helper function declarations */
+ssize_t recv_marker(int fd);
+bool read_marker(int fd, enum coredump_mark mark);
+bool read_coredump_req(int fd, struct coredump_req *req);
+bool send_coredump_ack(int fd, const struct coredump_req *req,
+		       __u64 mask, size_t size_ack);
+bool check_coredump_req(const struct coredump_req *req);
+int open_coredump_tmpfile(int fd_tmpfs_detached);
+void process_coredump_worker(int fd_coredump, int fd_peer_pidfd, int fd_core_file);
+
+#endif /* __COREDUMP_TEST_HELPERS_H */

-- 
2.53.0

