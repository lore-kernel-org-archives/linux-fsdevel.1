Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795145417;
	b=xZHy1pxC1OdbYT4mx579TygD6VYb8ZWYb2k8AcxbD0LTaW3TAkCgLU0XyJfRzQRZxJ8a
	 G32vEcE0czpM0fyiTwmfQAVXWiC21f2rkRdEvJI0HdYUevb/UvXELovAmysjqxKZ1pEKy
	 wCk09dfofHp5NYD06SoPlElkS6jpSEeHW/402Zohn2J7KhmtSAJR9nsepyMgMHoOD5hS/
	 jgSKye9ke1CrWvP4jDv5WxuocIjLlk+fJWp8vwp4dwdX7L6GwPQTuYhj3VUKWAgziYGD7
	 89P6pTtHVmPBQaHdVXivDTMI49nmMofttehXMeZxETCqZHc7CbNb/k7pVAxwd7np14A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795145417;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gDW1MGVDIOlb1DWUR4TOUcK83wNVzFBVTR8SHHNo9iM=;
	b=InQNXYxAgZwaxlL1B1BMczMc1eyl5xpf3a8SYh6fL00w55va1NOaCALpH4Gbl0vr8CfA
	 VNBzVyYkzp/mgOdvrifMJbgYBGTIOkX4Tr8jTKjcvah/kvjb2XJw+n7cHeSshOnSCtnha
	 rhMCwmrWklfW7NqGhRt6TgjyyH+H+rEf7QH6exw3PYG8R43EO37TuQw7Ax0exuBI+T/It
	 0gESsUklo3G1v0SnYs1Koe26tRMJnn5SH55occQKV0QRE2aO2Z3pJ7aqwGqu/l/Rsiw+w
	 LQAs8RWwqUCBgUWJKYWmpPDV6MpOWDTuesXLC0+xRNWHFEcgSNV1lE5xn7r+gpjMQXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F36606A330;
	Fri, 20 Nov 2026 03:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55F36606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: af7a03a4e49211f19a56ed5b684f684d-20261120
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:1c157bf3-f4d2-4ccb-ba34-7fa6219501be,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:afea6c6527a53b11ad3bb14aac0e74de,BulkI
	D:nil,BulkQuantity:0,SF:102|850|865|898|915,TC:nil,Content:0|15|50|99,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: af7a03a4e49211f19a56ed5b684f684d-20261120
X-User: fuqingshuang@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <fuqingshuang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 650950593; Fri, 20 Nov 2026 11:30:08 +0800
From: Qingshuang Fu <fuqingshuang@kylinos.cn>
To: Andy Whitcroft <apw@canonical.com>,
	Joe Perches <joe@perches.com>,
	Shuah Khan <shuah@kernel.org>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Amin Vakil <info@aminvakil.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qingshuang Fu <fuqingshuang@kylinos.cn>
Subject: [PATCH] selftests/proc: stop depending on glibc for the mount API
Date: Fri, 20 Nov 2026 11:30:04 +0800
Message-Id: <20261120033004.1599189-1-fuqingshuang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

proc-pidns.c calls fsopen(), fsconfig() and fsmount() directly and uses
the FSOPEN_CLOEXEC, FSCONFIG_* and FSMOUNT_CLOEXEC definitions.  glibc
only grew declarations for these functions in 2.36 and does not provide
the related constants at all, so older toolchains fail to build the
test:

  proc-pidns.c:118:28: error: 'FSOPEN_CLOEXEC' undeclared
    (first use in this function)

Switch to the sys_fsopen(), sys_fsconfig() and sys_fsmount() wrappers
from filesystems/wrappers.h, the same approach already used by the
mount_setattr test.  The wrappers issue the same syscalls directly and
pull in <linux/mount.h>, which the proc Makefile already provides via
$(TOOLS_INCLUDES).

Fixes: 5554d820f71c ("selftests/proc: add tests for new pidns APIs")
Signed-off-by: Qingshuang Fu <fuqingshuang@kylinos.cn>
---
 tools/testing/selftests/proc/proc-pidns.c | 39 ++++++++++++-----------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/proc/proc-pidns.c b/tools/testing/selftests/proc/proc-pidns.c
index 6f7c10fe97b3..00ca9ccb5a83 100644
--- a/tools/testing/selftests/proc/proc-pidns.c
+++ b/tools/testing/selftests/proc/proc-pidns.c
@@ -17,6 +17,7 @@
 #include <sys/stat.h>
 #include <sys/prctl.h>
 
+#include "../filesystems/wrappers.h"
 #include "kselftest_harness.h"
 
 #define ASSERT_ERRNO(expected, _t, seen)				\
@@ -115,13 +116,13 @@ TEST_F(ns, pidns_mount_string_path)
 
 TEST_F(ns, pidns_fsconfig_string_path)
 {
-	int fsfd = fsopen("proc", FSOPEN_CLOEXEC);
+	int fsfd = sys_fsopen("proc", FSOPEN_CLOEXEC);
 	ASSERT_SUCCESS(fsfd);
 
-	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_SET_STRING, "pidns", "/tmp/dummy/pidns", 0));
-	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	ASSERT_SUCCESS(sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "pidns", "/tmp/dummy/pidns", 0));
+	ASSERT_SUCCESS(sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 
-	int mountfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	int mountfd = sys_fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
 	ASSERT_SUCCESS(mountfd);
 
 	ASSERT_ERRNO_EQ(-ENOENT, faccessat(mountfd, "1/", X_OK, 0));
@@ -133,13 +134,13 @@ TEST_F(ns, pidns_fsconfig_string_path)
 
 TEST_F(ns, pidns_fsconfig_fd)
 {
-	int fsfd = fsopen("proc", FSOPEN_CLOEXEC);
+	int fsfd = sys_fsopen("proc", FSOPEN_CLOEXEC);
 	ASSERT_SUCCESS(fsfd);
 
-	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_SET_FD, "pidns", NULL, self->dummy_pidns));
-	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	ASSERT_SUCCESS(sys_fsconfig(fsfd, FSCONFIG_SET_FD, "pidns", NULL, self->dummy_pidns));
+	ASSERT_SUCCESS(sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 
-	int mountfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	int mountfd = sys_fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
 	ASSERT_SUCCESS(mountfd);
 
 	ASSERT_ERRNO_EQ(-ENOENT, faccessat(mountfd, "1/", X_OK, 0));
@@ -165,19 +166,20 @@ TEST_F(ns, pidns_reconfigure_remount)
 
 TEST_F(ns, pidns_reconfigure_fsconfig_string_path)
 {
-	int fsfd = fsopen("proc", FSOPEN_CLOEXEC);
+	int fsfd = sys_fsopen("proc", FSOPEN_CLOEXEC);
 	ASSERT_SUCCESS(fsfd);
 
-	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	ASSERT_SUCCESS(sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 
-	int mountfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	int mountfd = sys_fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
 	ASSERT_SUCCESS(mountfd);
 
 	ASSERT_SUCCESS(faccessat(mountfd, "1/", X_OK, 0));
 	ASSERT_SUCCESS(faccessat(mountfd, "self/", X_OK, 0));
 
-	ASSERT_ERRNO_EQ(-EBUSY, fsconfig(fsfd, FSCONFIG_SET_STRING, "pidns", "/tmp/dummy/pidns", 0));
-	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0)); /* noop */
+	ASSERT_ERRNO_EQ(-EBUSY, sys_fsconfig(fsfd, FSCONFIG_SET_STRING,
+					     "pidns", "/tmp/dummy/pidns", 0));
+	ASSERT_SUCCESS(sys_fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0)); /* noop */
 
 	ASSERT_SUCCESS(faccessat(mountfd, "1/", X_OK, 0));
 	ASSERT_SUCCESS(faccessat(mountfd, "self/", X_OK, 0));
@@ -188,19 +190,20 @@ TEST_F(ns, pidns_reconfigure_fsconfig_string_path)
 
 TEST_F(ns, pidns_reconfigure_fsconfig_fd)
 {
-	int fsfd = fsopen("proc", FSOPEN_CLOEXEC);
+	int fsfd = sys_fsopen("proc", FSOPEN_CLOEXEC);
 	ASSERT_SUCCESS(fsfd);
 
-	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
+	ASSERT_SUCCESS(sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 
-	int mountfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
+	int mountfd = sys_fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
 	ASSERT_SUCCESS(mountfd);
 
 	ASSERT_SUCCESS(faccessat(mountfd, "1/", X_OK, 0));
 	ASSERT_SUCCESS(faccessat(mountfd, "self/", X_OK, 0));
 
-	ASSERT_ERRNO_EQ(-EBUSY, fsconfig(fsfd, FSCONFIG_SET_FD, "pidns", NULL, self->dummy_pidns));
-	ASSERT_SUCCESS(fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0)); /* noop */
+	ASSERT_ERRNO_EQ(-EBUSY, sys_fsconfig(fsfd, FSCONFIG_SET_FD, "pidns",
+					     NULL, self->dummy_pidns));
+	ASSERT_SUCCESS(sys_fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0)); /* noop */
 
 	ASSERT_SUCCESS(faccessat(mountfd, "1/", X_OK, 0));
 	ASSERT_SUCCESS(faccessat(mountfd, "self/", X_OK, 0));
-- 
2.25.1

