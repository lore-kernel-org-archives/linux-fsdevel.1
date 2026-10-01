Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD79331ED0;
	Thu,  1 Oct 2026 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790837861; cv=none; b=H1Z7GA/AAa1Az+lKUZQbwKrWTwBwG2ptX/d+e+y4zLf8FTcHg17flUpGkd7boNrU7YCH5o8cftFzJF7r59yy7HdcHqeZa8ru7QpJFB6Mg+KNZcr4pF6G/Rl2m6L7oIF0vyp7jSoWe3HmARirFee9DUbLiZe+t1W0rcF5+I7eov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790837861; c=relaxed/simple;
	bh=knj1/QwjgxK+Js/aA4lalZiDyzZB5ToCrLnOCaDmx60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFH4Du+rW6aL9SK/xJaJ/rvNLr1xE2KOtmC9i8J6dXJS0egD1fCgYQdnO+CNlq/WNZW+oVE/3ve0jUAGK2di6S2x43E/0B4xILLpCIiMv/GB9OtiY/rLrPuWXjcrayzQF9QxCKzkToGBu9RvASTVBvuTLL0MWD1RPJ/+Np4PoGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CGyrauEn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CGyrauEn"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69145cpZ3678977;
	Thu, 1 Oct 2026 06:57:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ziaTfx1aXsXmlTmInIvB+yu/gQZ/7XNSzAB3CSzlZ
	k4=; b=CGyrauEn2SRZ92ojJMIo+43D5giDslwGHegowA4Y76kO42S8tkxGJLyqh
	ot/RLmuG3/Cf6Zlqwhjv7oVlbyS6xMz+ggBDLMlZ0weOeHUFoMuA2TRmOGdA6pPP
	72C1S8U0nLfkD4fmVW/QI9NikyS5dkUNH2shfH1H/4UbYbsnqj66JjEAw3YhKx2r
	0z3rbB8u3dYkT7Q4XMQQaU4Vz9BrlDdVtpLzUjenDdJq6nfr1EhrlRk36FFagUOo
	Lk5zJZXYm/HHrPA//iV0yHH595hmmyXMTCSVL9uPb4bn1Kgr7+0aqLj6+kZSjPo6
	6ksF3DUfr7y4IAtpYi3LnYrJpYxrQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fegjq3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 06:57:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6913ljqM3246006;
	Thu, 1 Oct 2026 06:57:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pe694-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 06:57:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6916vYDN40894960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 06:57:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5976620043;
	Thu,  1 Oct 2026 06:57:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A691920040;
	Thu,  1 Oct 2026 06:57:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.119])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 06:57:32 +0000 (GMT)
From: Disha Goel <disgoel@linux.ibm.com>
To: brauner@kernel.org, shuah@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Disha Goel <disgoel@linux.ibm.com>
Subject: [PATCH 1/2] selftests/empty_mntns: fix header conflicts and remove TOOLS_INCLUDES
Date: Thu,  1 Oct 2026 12:27:27 +0530
Message-ID: <20261001065728.90239-1-disgoel@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abe0461 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=aVn8jr3HOu2W0GN4xw8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAyNiBTYWx0ZWRfXzy9jAo0SHzzn
 xsXcuVJCEs31Vf+xdLchzJFxd/mRY9NjLreow+v+XB3emcOf614oeDoJCzAW8Jk/aMSv+qdaTHj
 kqW75kVBNCRS2fFhoK1TrBVn2BMYIzw=
X-Proofpoint-ORIG-GUID: mjNus_jGLg6CBHJMiHarjqru0iRR41N3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAyNiBTYWx0ZWRfX1G8gaw91iEOT
 dF3kyxKzwfu+YOp0ZAW6g1eIW5EK8nrgwH6pdY3NST1bwbOFnPtnlPZtO7c9g7zo5b92t8kzgl0
 3DFj6rhHghsTQ86urEscNvw76fqJlJMjL0HEs+ATtJywa6Z51j44UR1VNa1i3Q3o6ekc5Vxk/X2
 Mp1iObb10d7bbW0rI0TWYbW22A6UaE3Y9lVDP/dW7k0tm3qjcxwdjyb6KZlh0QTX/eOa24EPYCh
 Axf0ry9J85H19zwGbofGMQd/qalNoMICnsGqj6nmWvLPjgOoRO2ozMh5zwlSLlkT7C4N3qTDif1
 7TI649aLSz85vbf2DcCoPO67s4rDRO4S4WnIa7jsNotGyjYC3PCv+82boU1gyKdVUWrXdvIOkqn
 EbqGL8/bFRkLNMiy8Mrb/npCCRKzioC7xXCfNLe0ny+ZSRvUQpx7YCOdlTurmRTXLeuJ1O1sUKQ
 T3kEO2MQxLFsUhFE1fg==
X-Proofpoint-GUID: mjNus_jGLg6CBHJMiHarjqru0iRR41N3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010026

Including <linux/mount.h> alongside <sys/mount.h> in empty_mntns test
files leads to compilation errors with glibc due to conflicting enum
definitions of MS_RDONLY and other mount flags.

Additionally, passing $(TOOLS_INCLUDES) (-isystem tools/include/uapi)
causes tools/include/uapi/linux/types.h to be included, forcing
int-ll64.h definitions on architectures like PowerPC (ppc64le) that
use int-l64.h, resulting in type collisions with system headers.

Fix this by:
- Dropping <linux/mount.h> from the test sources in favor of
  <sys/mount.h> (with <linux/stat.h> included after system headers).
- Removing $(TOOLS_INCLUDES) from the Makefile since standard UAPI
  headers are already supplied via $(KHDR_INCLUDES).

Fixes: 32f54f2bbccf ("selftests/filesystems: add tests for empty mount namespaces")
Fixes: 5b8ffd63fbd9 ("selftests/filesystems: add clone3 tests for empty mount namespaces")
Signed-off-by: Disha Goel <disgoel@linux.ibm.com>
---
 tools/testing/selftests/filesystems/empty_mntns/Makefile       | 2 +-
 .../filesystems/empty_mntns/clone3_empty_mntns_test.c          | 3 +--
 .../selftests/filesystems/empty_mntns/empty_mntns_test.c       | 3 +--
 .../selftests/filesystems/empty_mntns/overmount_chroot_test.c  | 3 +--
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/filesystems/empty_mntns/Makefile b/tools/testing/selftests/filesystems/empty_mntns/Makefile
index 22e3fb915e81..8d2cb46668fc 100644
--- a/tools/testing/selftests/filesystems/empty_mntns/Makefile
+++ b/tools/testing/selftests/filesystems/empty_mntns/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+CFLAGS += -Wall -O2 -g $(KHDR_INCLUDES)
 LDLIBS += -lcap
 
 TEST_GEN_PROGS := empty_mntns_test overmount_chroot_test clone3_empty_mntns_test
diff --git a/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c b/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c
index 6370086f886d..de0cbd1a5ee0 100644
--- a/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c
+++ b/tools/testing/selftests/filesystems/empty_mntns/clone3_empty_mntns_test.c
@@ -15,14 +15,13 @@
 
 #define _GNU_SOURCE
 #include <fcntl.h>
-#include <linux/mount.h>
-#include <linux/stat.h>
 #include <stdio.h>
 #include <string.h>
 #include <sys/mount.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
+#include <linux/stat.h>
 
 #include "../utils.h"
 #include "../wrappers.h"
diff --git a/tools/testing/selftests/filesystems/empty_mntns/empty_mntns_test.c b/tools/testing/selftests/filesystems/empty_mntns/empty_mntns_test.c
index 43e296b97d84..a6a90d0b6ff9 100644
--- a/tools/testing/selftests/filesystems/empty_mntns/empty_mntns_test.c
+++ b/tools/testing/selftests/filesystems/empty_mntns/empty_mntns_test.c
@@ -7,8 +7,6 @@
 
 #define _GNU_SOURCE
 #include <fcntl.h>
-#include <linux/mount.h>
-#include <linux/stat.h>
 #include <sched.h>
 #include <stdio.h>
 #include <string.h>
@@ -17,6 +15,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <linux/stat.h>
 
 #include "../utils.h"
 #include "../wrappers.h"
diff --git a/tools/testing/selftests/filesystems/empty_mntns/overmount_chroot_test.c b/tools/testing/selftests/filesystems/empty_mntns/overmount_chroot_test.c
index 6e21c58258c3..574c03311245 100644
--- a/tools/testing/selftests/filesystems/empty_mntns/overmount_chroot_test.c
+++ b/tools/testing/selftests/filesystems/empty_mntns/overmount_chroot_test.c
@@ -18,8 +18,6 @@
 
 #define _GNU_SOURCE
 #include <fcntl.h>
-#include <linux/mount.h>
-#include <linux/stat.h>
 #include <sched.h>
 #include <stdio.h>
 #include <string.h>
@@ -29,6 +27,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <linux/stat.h>
 
 #include "../utils.h"
 #include "empty_mntns.h"
-- 
2.45.1

