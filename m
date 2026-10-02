Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5594BD7BC;
	Fri,  2 Oct 2026 13:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949267; cv=none; b=H7Qd94KBm5sUQ0kBNszmjPCF8zS4Arx326aMK05C9oYLDmcgI86eA7Sun3KvBD6eF6/ckDeNYCSUW+VAJfwzGfipBR40a9zzWmwzOpAB9nwCCe8DHnKjXVLfJEEFs4kOv5sBvXh8GpOQvkZLkP0W1HGYJLfdY5gyIXIB4CZnTxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949267; c=relaxed/simple;
	bh=39qH4Qxiqg7lwy9ZN0c1IOZ55qUFWpAVl+PAyYOaB+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MmAnFoNsqB+asFJ9MmDP4Ie4E2mEAx3qHhNinaC76zMxJUTqxYMpfx3TeAqTz3QXkzXGimB/TELd617e8SXIikfyKCtaematKSb9Zm9m4Unc6a5Kj8DKpa6TgBCbimaEsB/RtwyN0Uf8ZN/q+veJK4ro2Oe7tafHP/falikKxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgcXLvgD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgcXLvgD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B518F1F000FF;
	Fri,  2 Oct 2026 13:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949266;
	bh=PS7AtoZtYOlnLuk+2alc0UUFO/f6v1NDvPSG5gs76uE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UgcXLvgDQy4oQwT5RhmGjmYrVq5e+nOdqXwCtf4PKhEnskiSOg0bUXMGHIKBwdMjs
	 NiPdbBPApR/G4hEQbMMU3x6TZZMzhxtIE5pqiUmLWsBM5YsVVm/k5HWiUaOY0cICGr
	 gt2FUh07/vmW4MZV2U8+zfTF50VIZKEFXxQtD9A9IyP0zWlGddYvdmBqc2swrJHqIA
	 jVaRv0fm2lq/hR9MAvjAKe8Sxjs8+63RsOk94zbb4U+ZBP93A+rtxHGpZm44YNm3Fr
	 QayK9iav4Oke3Cxj67L3VHHooQXm3S1Ji4iFF0jtTiUUyLQHWAlExI778bzaLwR1oB
	 lAt46pOuQhxgg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:52 +0200
Subject: [PATCH 21/21] selftests/filesystems: check that reading the root
 of an empty mount namespace stalls nobody
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-21-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3552; i=brauner@kernel.org;
 h=from:subject:message-id; bh=39qH4Qxiqg7lwy9ZN0c1IOZ55qUFWpAVl+PAyYOaB+Y=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x5t//Ci/O/ITx2ey5+VrnHoWHzKMkTEYNtF2bYrV
 klnpqRpd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykdxvDb5Y7nx72/onhnKpQ
 eeFuUFioQ/ujptLpn5UqmHbb59W+mMLw31mLIeOad6LmuooomTQLj1CrwxPyuxbqmRgXM2cteWX
 MCAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

A readdir of the root of an empty mount namespace stuck in the page
fault of its buffer must stall neither a create nor a lookup in that
directory. The test needs userfaultfd and skips without it.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 .../selftests/filesystems/empty_mntns/.gitignore   |  1 +
 .../selftests/filesystems/empty_mntns/Makefile     |  5 ++-
 .../filesystems/empty_mntns/root_readdir_test.c    | 45 ++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/empty_mntns/.gitignore b/tools/testing/selftests/filesystems/empty_mntns/.gitignore
index 8ea166068d6b..27bcbcaeb1d1 100644
--- a/tools/testing/selftests/filesystems/empty_mntns/.gitignore
+++ b/tools/testing/selftests/filesystems/empty_mntns/.gitignore
@@ -4,3 +4,4 @@ empty_mntns_test
 overmount_chroot_test
 internal_sb_reconfigure_test
 nullfs_atime_test
+root_readdir_test
diff --git a/tools/testing/selftests/filesystems/empty_mntns/Makefile b/tools/testing/selftests/filesystems/empty_mntns/Makefile
index 4b2ea6acec1c..22af2164c54e 100644
--- a/tools/testing/selftests/filesystems/empty_mntns/Makefile
+++ b/tools/testing/selftests/filesystems/empty_mntns/Makefile
@@ -4,7 +4,9 @@ CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS += -lcap
 
 TEST_GEN_PROGS := empty_mntns_test overmount_chroot_test clone3_empty_mntns_test
-TEST_GEN_PROGS += internal_sb_reconfigure_test nullfs_atime_test
+TEST_GEN_PROGS += internal_sb_reconfigure_test nullfs_atime_test root_readdir_test
+
+LOCAL_HDRS += ../readdir_hold.h
 
 include ../../lib.mk
 
@@ -12,3 +14,4 @@ $(OUTPUT)/empty_mntns_test: ../utils.c
 $(OUTPUT)/overmount_chroot_test: ../utils.c
 $(OUTPUT)/clone3_empty_mntns_test: ../utils.c
 $(OUTPUT)/internal_sb_reconfigure_test: ../utils.c
+$(OUTPUT)/root_readdir_test: LDLIBS += -pthread
diff --git a/tools/testing/selftests/filesystems/empty_mntns/root_readdir_test.c b/tools/testing/selftests/filesystems/empty_mntns/root_readdir_test.c
new file mode 100644
index 000000000000..0ff544247027
--- /dev/null
+++ b/tools/testing/selftests/filesystems/empty_mntns/root_readdir_test.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Reading the root of an empty mount namespace holds nothing that anybody
+ * else waits for: the directory never has an entry, so a readdir stuck in
+ * the page fault of its buffer stalls neither a create nor a lookup in it.
+ */
+#define _GNU_SOURCE
+#include <errno.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "../../kselftest_harness.h"
+#include "../readdir_hold.h"
+#include "empty_mntns.h"
+
+TEST(readdir_blocks_nobody)
+{
+	struct readdir_hold hold;
+	bool stalled;
+	int dfd;
+
+	if (geteuid())
+		SKIP(return, "test requires root");
+	if (readdir_hold_init(&hold))
+		SKIP(return, "test requires userfaultfd");
+	if (unshare(UNSHARE_EMPTY_MNTNS)) {
+		readdir_hold_destroy(&hold);
+		if (errno == EINVAL)
+			SKIP(return, "UNSHARE_EMPTY_MNTNS not supported");
+		ASSERT_TRUE(false)
+			TH_LOG("unshare(UNSHARE_EMPTY_MNTNS): %m");
+	}
+	dfd = open("/", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_GE(dfd, 0);
+	ASSERT_EQ(readdir_hold_check(&hold, dfd, &stalled), 0);
+	/* the lookup came back while the readdir was stuck in its fault */
+	EXPECT_FALSE(stalled);
+	close(dfd);
+	readdir_hold_destroy(&hold);
+}
+
+TEST_HARNESS_MAIN

-- 
2.53.0

