Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5CB340DAB;
	Thu, 19 Mar 2026 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773886922; cv=fail; b=WqK4zUpRDQpTlag4zJGs9hkT0nvXZl5tbZvUZEdxxvuzkU/BAO0IcJUX+R+ovSo5QuiGUvsWBhFIalqOXDDsiH95tojwsOS1QL/oW5yfx6eGHdCDzS3sTo3jqb+UMKE8UWNoYQouQCgwv97ahGvaM4BQoxz2oJRVJEWu/Ph2TgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773886922; c=relaxed/simple;
	bh=uGwby4ifxu6nndeGSJOXcKK13RMy977MTlcJaza95jo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L1tmhIp1bG9caJW2NnfHOw9gcKqYyxocW1BxmqiBuUdoYVV8iQsnCazA5xLqk+AXzJzUXVSQFpoVpCPKKoUq4E3wZaEOyOd/h6QY5RcGomfYIE6Fhi0B14lj9CUAOvgBlPh8/QHoi1hEUy3SasGHSOZ14bHlkNBubRu8udgINGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eXiL7LAq; arc=fail smtp.client-ip=52.101.48.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eXiL7LAq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CClgQ6Esu8KEpRVRVowBQUeqTaa0hCOXUHzwCd5OXAbkh5LFfjeY8xLgOlw+VMgWd3LrTf07YkkgM7iT+9cej3YYp0ZhTUCAi9aAfUCKQyUzfMeW1zF5i9UH/6rMCGdijzp0LsNUs1s14RSvhyQKQSSKYF89Hl16gzz00d62whEMbXzFc6WF0qalQD0hw+/uxJkdNVGYwdHMB842vk9SqMeE8Lola+6romY0OcuM2D0iLrPQEO/9Vv3GMbxwsE9k9EER5lSumPrRfTPWASKFTW5mT5evVX46V1X7jLFSHcUuRVy7TfM1Mgx4dCyphDI7o0l9+kYXzo4lVNlTh/PQwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgfBHtHpf6YPOyylRv5Tr13pE8yc0FjQMXVd7skA7Yc=;
 b=BxpfITFGYSIesNV57c69LdiPbQQ3n0sJ+kiIDAhEGyXb+znnzGUb12bMMGqW25z0v+EPZD1qvumeR6SIa4JiIhhiCvn2Gea3NobQFDtLnmP1paIbbbgJMspNS6piQM/Ga7omZwpT7y3qdA6B6dbsztcImkTG4jYRzI/+mOGr9FCCFsuy2mQb3yT/PmQWZiL5KPZv3FRZ2OlemNLNoV68trux8DsyyDeTqJOhhvPuKD/XeuUCFlSPkSSwPra2y75ngR4+MCtJqlUQowqyhrIx3adCnxh8VYMwblqB+CLoaVGlP4cLUSMtE/pRuot+ldrYEa2z16rdZUiB1MfRUF0rkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WgfBHtHpf6YPOyylRv5Tr13pE8yc0FjQMXVd7skA7Yc=;
 b=eXiL7LAqwr7wrAHaJkpTPWw/gZmlO/XgOEFaAid2DwgtKSjecCwkbhabAISdGGDZLAilFjB05ru7yKj1C4va5PSnIQA0I5KY6BxnoYKcA/HduYqoQr7qfXFt/KPeOoUG3S9WRo1b/Bzcj7wSq2fg2imr981kOUIjcdc81YiLajrHPVgCoEOYlP3WOVk7PHR+5cRx3Rf5nD61CJKU8oruGeMU12FJ0DkdpQGChPppNkwW0CTrgZWA9GKekXucDFLI60hhtUT42FIbKYH8LHtLrj5qrM6/P/klWshm4UA06Xe3okXogiWS1ThRfQPANkAELhS5QL9PmJgwp9zMxXeduw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB7889.namprd12.prod.outlook.com (2603:10b6:510:27f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 02:21:54 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 02:21:54 +0000
From: Zi Yan <ziy@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Bas van Dijk <bas@dfinity.org>,
	Eero Kelly <eero.kelly@dfinity.org>,
	Andrew Battat <andrew.battat@dfinity.org>,
	Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] selftests/mm: add folio_split() and filemap_get_entry() race test
Date: Wed, 18 Mar 2026 22:21:42 -0400
Message-ID: <20260319022142.277161-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:208:32f::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 49bcc263-394a-4933-a9db-08de855e4976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	7Es+ZeFQuoNea3n7ZhzgLEqMVuKTgL3Z8hPz4Ctv56HYlQdEkLh+ef+yFo6XWPRWYMGRTzJfhvXxx9zXU/PaYyHW+JQDOqmKG4Qm4zB9qa6Lm7VzXTKfFpSIrUlfhnn4F3XfBLYVSxBqLxRiyWpDMwfH0ElgqZveCRahcx6Wxf1JczHjCXKSPdORe7mGWb6nkIZYEsQ0UejF56N6SgmIn0yBA542H0SXEFK1X5hP8Je7q38AmM35YqxvFb0vsyB3UXud3am2m4gACtfK5PCKzTeGl25iPIRBoOagMwdleVuSSQ6mLK5cbUo26C9PKIdnTtdryEdXWWklt+iPoAUd3+FzmZL08sip9XDs8il2I/EJwHF85nJhxY/GFtfGhk2CLKbCjxl/fhCEqYllOpW3pcYqQXEJSYb7Qgtgr9r2SkdZ99g8dO1H7RjrJgvw2Nzicg71YfgZ9g6pl1Yex6y/88ncsklL3ARCG32zrfsjmHkFWY/D2niv+9Ibzvbm6HaV0LM9ClYXqoMtp4yVeYTApeXI6YVPfKe1X+BPH95JS7tsLFRzjAKKwheuuQtpTx39kadOrSzo1Q/GqCAb3qmU+aIbgGM0AV2mo1EaNdzsThx3Xi9mcoAEpkkosz92WvaNGruhRVSDiXu05RHkIg62U/5Qb8n8eMTX4HhXHIEy1Ahz8DgtpLhR6Bsr2asm5AKBAU0UYSHIPC9ev5ikOvipoPahW+pKahKF5g/2/XRHMGqnw+JG4fb26l6GUORmyvQF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yp7KyYj4Uf82a+5q8fNhvfee03M51N+KM3xwm4sCr20CkxKZuqrgfKZ7KHZE?=
 =?us-ascii?Q?lp1mrde2nBGsP4UZ9mT2KAtga2s3nIxJsqR93hqs3X3+l1XftMS0dbZwgQse?=
 =?us-ascii?Q?JBUoqalJBGkA4CJbpF6djsEbUE8NhYxoOgoIvDwTY4UOJFMTO3Y6+qc/2FJZ?=
 =?us-ascii?Q?Y4W+BqjD0Cri272vfawNU1el0OGNoMeEfHJ8S2R3mUr/N21du+On5gU4rC2H?=
 =?us-ascii?Q?cTo5NAn07mTmRnJZGiqAMEYM4aO3ET7vzIyuCE7cnArah3a1jCyhmY3YpXja?=
 =?us-ascii?Q?53h1ZKXZOhYaznkycsRAeu1uWU9NfMwFYT36yaTnlLS3MYvU1HGDxBABvj0K?=
 =?us-ascii?Q?jPyoIfOSiSjF1jzwPnZRFSmY2HumFDq+AvaemE+FrimJ67AS9vwUv1emOl9j?=
 =?us-ascii?Q?OpuXA0pf4DQ/XMAWXivfYG3uG6IAsxBqPWt5nVrrI+QyW5VegMH++fBdgwlE?=
 =?us-ascii?Q?MuaDaZf277D+G6VC7WHf8mkA9p2Af7IbqGzqLplEMZG9gIi6h2fQTK9zOz7z?=
 =?us-ascii?Q?uIe+JFTeRMsWrlf8slpp3Rkt1yV+lf66OhzkDX9kIAG7sk6bSV0uLeNWLELb?=
 =?us-ascii?Q?6KDXFjD2tq9COZpG0mmW+UYVOy/uADtl8ksdMAPxWz7Bizej68iG/vXu15w7?=
 =?us-ascii?Q?Ry11hDQ/J9IPlwkTuovTDDol+Phvtud50HOxC02gpQm/jA6Rm4/zzuRJZc3X?=
 =?us-ascii?Q?vjHVJNH76dbmNsAskIr8A8sfryseTouU64F2OniKqxvJmeoLMUDnGLlfea/3?=
 =?us-ascii?Q?h+Gt2n5BwxCpMBaEayAZGYdri3NabSYNabKGc6PFjSos4ZYopxDe99PgJMPk?=
 =?us-ascii?Q?edw9i5XY0zydRTmT4Dla60lY8cAPP/XD2+5PsfACptN21tMis2IhYqCHdc0W?=
 =?us-ascii?Q?MbUIodngR7QvgOMI30mU65LdY0Xn/1erVjDwKmfzeZzvs5G+ULNPnpOXQh/g?=
 =?us-ascii?Q?btHpSNAwVMwoetgf6iGaQqzsRoE+GXl28Qfrkr20wFIEbS0Hz5OjNGomtLd0?=
 =?us-ascii?Q?cwrBMh5wHbSfgqAhML4gR23CmsnOFNivxrtVnTqVV57+z/aZDTPZ3Z0EFWdj?=
 =?us-ascii?Q?Da2ltu8YllTtJVppYKyCHqhIqnJKTif+7963rWv6pnNAgZyfbfbW6COTGkOt?=
 =?us-ascii?Q?4wxqBpiE2HPq9XgNg6DPQ4Lpob/Wleb4W//jU4WSKfjzho57i8hprOArlaLn?=
 =?us-ascii?Q?VDc9ez0WoTtT4i6rIbVhfbgElOif3lFnIOMAtpqekuqCNQzAHqJaRHVTFbPl?=
 =?us-ascii?Q?T3z/0K2809qeKE8bgs9u8/DBCcoL/COB7QKNqBt7O5VVpFpxq+qDcfGPTAYZ?=
 =?us-ascii?Q?cZ1cSzB9Dka/7uBjA2iNGKoBhzyoUdLgUL8Bflm4A0iWeaYjXfuZUeNTl3xF?=
 =?us-ascii?Q?0VsnA9dvuGyVqESED/8DkYQ96J7AoTQlOcQgiNFDCByU6G21Z1BUkYWlh0lu?=
 =?us-ascii?Q?fnBC7SQ0JxfdpLxjXdLjykE9QxYSVC20YUxNrcq7cfqD3VV6f4Few1yK2Riv?=
 =?us-ascii?Q?4U+6/YKTdMuTssIIMuPCxl4WKPdAWIbqy7BVummKaqqX/wT78ow9rztsGqne?=
 =?us-ascii?Q?bpnPHLn5BFV9/EqLVPqBoanaztegfrq/GsoigmCce8J7g/lxO/Ir+UHpa+DP?=
 =?us-ascii?Q?TKBwcmgWvhxjvq1J0O65OwygX5wWCu6+tQgmVbD+h48PmWjiOgj3QNbLHfPq?=
 =?us-ascii?Q?4lLHQFk1/M7j26Upv72cMw6rZJtqfcBHk3H/WRNoaFSU1cps?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bcc263-394a-4933-a9db-08de855e4976
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 02:21:54.0515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tI80hGJxIrtcrJLV9Pup1mwdluuAEXbcTT8utAlhL/D4sH+7Ha6dipAofD+i3lrr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7889

The added folio_split_race_test is a modified C port of the race condition
test from [1]. The test creates shmem huge pages shared by both a parent
and a child processes, where the parent process punches holes in the shmem
to cause folio_split() in the kernel and the child process reads the shmem
in 16 threads to cause filemap_get_entry() in the kernel.
filemap_get_entry() reads the folio and xarray split by folio_split()
locklessly. The original test[2] is written in rust and uses memfd (shmem
backed). This C port uses shmem directly.

Note: the initial rust to C conversion is done by Cursor.

Link: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/ [1]
Link: https://github.com/dfinity/thp-madv-remove-test [2]
Signed-off-by: Bas van Dijk <bas@dfinity.org>
Signed-off-by: Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
From V1:
1. added prctl(PR_SET_PDEATHSIG, SIGTERM) to avoid child looping
   forever.
2. removed page_idx % PUNCH_INTERVAL >= 0, since it is a nop. Added a
   comment.
3. added a child process status check to prevent parent looping forever
   and record that as a failure.
4. used ksft_exit_skip() instead of ksft_finished() when the program is
   not running as root.
5. restored THP settings properly when the program exits abnormally.

 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/folio_split_race_test.c      | 431 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   2 +
 3 files changed, 434 insertions(+)
 create mode 100644 tools/testing/selftests/mm/folio_split_race_test.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 7a5de4e9bf520..cd24596cdd27e 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -105,6 +105,7 @@ TEST_GEN_FILES += droppable
 TEST_GEN_FILES += guard-regions
 TEST_GEN_FILES += merge
 TEST_GEN_FILES += rmap
+TEST_GEN_FILES += folio_split_race_test
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_FILES += soft-dirty
diff --git a/tools/testing/selftests/mm/folio_split_race_test.c b/tools/testing/selftests/mm/folio_split_race_test.c
new file mode 100644
index 0000000000000..bf2a4159777d0
--- /dev/null
+++ b/tools/testing/selftests/mm/folio_split_race_test.c
@@ -0,0 +1,431 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The parent process creates a shmem and forks. The child creates a THP on the
+ * mapping, fills all pages with known patterns, and then continuously verifies
+ * non-punched pages. The parent punches holes via MADV_REMOVE on the shmem
+ * while the child reads.
+ *
+ * It tests the race condition between folio_split() and filemap_get_entry(),
+ * where the hole punches on shmem lead to folio_split() and reading the shmem
+ * lead to filemap_get_entry().
+ */
+
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <linux/mman.h>
+#include <pthread.h>
+#include <stdatomic.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <signal.h>
+#include <unistd.h>
+#include <sys/prctl.h>
+#include "vm_util.h"
+#include "kselftest.h"
+#include "thp_settings.h"
+
+uint64_t page_size;
+uint64_t pmd_pagesize;
+#define NR_PMD_PAGE 5
+#define FILE_SIZE (pmd_pagesize * NR_PMD_PAGE)
+#define TOTAL_PAGES (FILE_SIZE / page_size)
+
+/* Every N-th to N+M-th pages are punched; not aligned with huge page boundaries. */
+#define PUNCH_INTERVAL 50 /* N */
+#define PUNCH_SIZE_FACTOR 3 /* M */
+
+#define NUM_READER_THREADS 16
+#define FILL_BYTE 0xAF
+#define NUM_ITERATIONS 100
+
+#define CHILD_READY 1
+#define CHILD_FAILED 2
+/* Shared control block: MAP_SHARED anonymous so parent and child see same values. */
+struct shared_ctl {
+	atomic_uint_fast32_t ready;
+	atomic_uint_fast32_t stop;
+	atomic_size_t child_failures;
+	atomic_size_t child_verified;
+};
+
+static int get_errno(void)
+{
+	return errno;
+}
+
+static void fill_page(unsigned char *base, size_t page_idx)
+{
+	unsigned char *page_ptr = base + page_idx * page_size;
+	uint64_t idx = (uint64_t)page_idx;
+
+	memset(page_ptr, FILL_BYTE, page_size);
+	memcpy(page_ptr, &idx, sizeof(idx));
+}
+
+/* Returns true if valid, false if corrupted. */
+static bool check_page(unsigned char *base, size_t page_idx)
+{
+	unsigned char *page_ptr = base + page_idx * page_size;
+	uint64_t expected_idx = (uint64_t)page_idx;
+	uint64_t got_idx;
+
+	memcpy(&got_idx, page_ptr, 8);
+
+	if (got_idx != expected_idx) {
+		size_t off;
+		int all_zero = 1;
+
+		for (off = 0; off < page_size; off++) {
+			if (page_ptr[off] != 0) {
+				all_zero = 0;
+				break;
+			}
+		}
+		if (all_zero) {
+			ksft_print_msg(
+				"CORRUPTED: page %zu (huge page %zu) is ALL ZEROS\n",
+				page_idx,
+				(page_idx * page_size) / pmd_pagesize);
+		} else {
+			ksft_print_msg(
+				"CORRUPTED: page %zu (huge page %zu): expected idx %zu, got %lu\n",
+				page_idx, (page_idx * page_size) / pmd_pagesize,
+				page_idx, (unsigned long)got_idx);
+		}
+		return false;
+	}
+	return true;
+}
+
+struct reader_arg {
+	unsigned char *base;
+	struct shared_ctl *ctl;
+	int tid;
+	atomic_size_t *failures;
+	atomic_size_t *verified;
+};
+
+static void *reader_thread(void *arg)
+{
+	struct reader_arg *ra = (struct reader_arg *)arg;
+	unsigned char *base = ra->base;
+	struct shared_ctl *ctl = ra->ctl;
+	int tid = ra->tid;
+	atomic_size_t *failures = ra->failures;
+	atomic_size_t *verified = ra->verified;
+	size_t page_idx;
+
+	while (atomic_load_explicit(&ctl->stop, memory_order_acquire) == 0) {
+		for (page_idx = (size_t)tid; page_idx < TOTAL_PAGES;
+		     page_idx += NUM_READER_THREADS) {
+			if (page_idx % PUNCH_INTERVAL >= 0 &&
+			    page_idx % PUNCH_INTERVAL < PUNCH_SIZE_FACTOR)
+				continue;
+			if (check_page(base, page_idx))
+				atomic_fetch_add_explicit(verified, 1,
+							  memory_order_relaxed);
+			else
+				atomic_fetch_add_explicit(failures, 1,
+							  memory_order_relaxed);
+		}
+		if (atomic_load_explicit(failures, memory_order_relaxed) > 0)
+			break;
+	}
+
+	return NULL;
+}
+
+static void child_reader_loop(unsigned char *base, struct shared_ctl *ctl)
+{
+	pthread_t threads[NUM_READER_THREADS];
+	struct reader_arg args[NUM_READER_THREADS];
+	atomic_size_t failures = 0;
+	atomic_size_t verified = 0;
+	size_t page_idx;
+	size_t recheck = 0;
+	int i;
+
+	for (i = 0; i < NUM_READER_THREADS; i++) {
+		args[i].base = base;
+		args[i].ctl = ctl;
+		args[i].tid = i;
+		args[i].failures = &failures;
+		args[i].verified = &verified;
+		if (pthread_create(&threads[i], NULL, reader_thread,
+				   &args[i]) != 0)
+			ksft_exit_fail_msg("pthread_create failed\n");
+	}
+
+	for (i = 0; i < NUM_READER_THREADS; i++)
+		pthread_join(threads[i], NULL);
+
+	/* Post-sleep recheck */
+	usleep(1000); /* 1 ms */
+
+	for (page_idx = 0; page_idx < TOTAL_PAGES; page_idx++) {
+		if (page_idx % PUNCH_INTERVAL >= 0 &&
+		    page_idx % PUNCH_INTERVAL < PUNCH_SIZE_FACTOR)
+			continue;
+		if (!check_page(base, page_idx))
+			recheck++;
+	}
+	if (recheck)
+		ksft_print_msg("post-sleep failures: %zu\n", recheck);
+
+	atomic_store_explicit(&ctl->child_failures,
+			      atomic_load_explicit(&failures,
+						   memory_order_relaxed),
+			      memory_order_release);
+	atomic_store_explicit(&ctl->child_verified,
+			      atomic_load_explicit(&verified,
+						   memory_order_relaxed),
+			      memory_order_release);
+}
+
+/* Returns number of corrupted pages. */
+static size_t verify_pages(unsigned char *base, const bool *is_punched)
+{
+	size_t failures = 0;
+	size_t page_idx;
+	size_t non_punched = 0;
+
+	for (page_idx = 0; page_idx < TOTAL_PAGES; page_idx++) {
+		if (is_punched[page_idx])
+			continue;
+		if (!check_page(base, page_idx)) {
+			failures++;
+			if (failures >= 100)
+				return failures;
+		}
+		non_punched++;
+	}
+	if (failures)
+		ksft_print_msg("  %zu non-punched pages are corrupted!\n",
+			failures);
+	return failures;
+}
+
+/* Run a single iteration. Returns total number of corrupted pages. */
+static size_t run_iteration(void)
+{
+	struct shared_ctl *ctl;
+	pid_t pid;
+	unsigned char *parent_base;
+	bool *is_punched;
+	size_t i;
+	size_t child_failures, child_verified, parent_failures;
+	size_t child_status_failures = 0;
+	int status;
+	size_t n_punched = 0;
+
+	ctl = (struct shared_ctl *)mmap(NULL, sizeof(struct shared_ctl), PROT_READ | PROT_WRITE,
+				MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (ctl == MAP_FAILED)
+		ksft_exit_fail_msg("mmap ctl failed: %d\n", get_errno());
+
+	memset(ctl, 0, sizeof(struct shared_ctl));
+
+	parent_base = mmap(NULL, FILE_SIZE, PROT_READ | PROT_WRITE,
+			   MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	if (parent_base == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed: %d\n", get_errno());
+
+	pid = fork();
+	if (pid < 0)
+		ksft_exit_fail_msg("fork failed: %d\n", get_errno());
+
+	if (pid == 0) {
+		/* ---- Child process ---- */
+		unsigned char *child_base = parent_base;
+
+		/* in case parent exit abnormally, reader_thread() loop forever */
+		if (prctl(PR_SET_PDEATHSIG, SIGTERM))
+			ksft_exit_fail_msg("prctl(PR_SET_PDEATHSIG) failed: %d\n", get_errno());
+
+		if (madvise(child_base, FILE_SIZE, MADV_HUGEPAGE) != 0)
+			ksft_exit_fail_msg("madvise(MADV_HUGEPAGE) failed: %d\n",
+				get_errno());
+
+		for (i = 0; i < TOTAL_PAGES; i++)
+			fill_page(child_base, i);
+
+		if (!check_huge_shmem(child_base, NR_PMD_PAGE, pmd_pagesize)) {
+			atomic_store_explicit(&ctl->ready, CHILD_FAILED, memory_order_release);
+			ksft_print_msg("No shmem THP is allocated\n");
+			_exit(0);
+		}
+
+		atomic_store_explicit(&ctl->ready, CHILD_READY, memory_order_release);
+		child_reader_loop(child_base, ctl);
+
+		munmap(child_base, FILE_SIZE);
+		_exit(0);
+	}
+
+	/* ---- Parent process ---- */
+	while (atomic_load_explicit(&ctl->ready, memory_order_acquire) == 0) {
+		if (waitpid(pid, &status, WNOHANG) == pid) {
+			ksft_print_msg(
+				"Child terminated unexpectedly before ready\n");
+			/* Force the ready flag to break loop and fail. */
+			atomic_store_explicit(&ctl->ready, CHILD_FAILED,
+					      memory_order_release);
+			break;
+		}
+		usleep(1000);
+	}
+
+	if (ctl->ready == CHILD_FAILED)
+		ksft_exit_fail_msg("Child process error\n");
+
+	is_punched = calloc(TOTAL_PAGES, sizeof(bool));
+	if (!is_punched)
+		ksft_exit_fail_msg("calloc is_punched failed\n");
+
+	for (i = 0; i < TOTAL_PAGES; i++) {
+		int j;
+
+		if (i % PUNCH_INTERVAL != 0)
+			continue;
+		if (madvise(parent_base + i * page_size,
+			    PUNCH_SIZE_FACTOR * page_size, MADV_REMOVE) != 0) {
+			ksft_exit_fail_msg(
+				"madvise(MADV_REMOVE) failed on page %zu: %d\n",
+				i, get_errno());
+		}
+		for (j = 0; j < PUNCH_SIZE_FACTOR && i + j < TOTAL_PAGES; j++)
+			is_punched[i + j] = true;
+
+		i += PUNCH_SIZE_FACTOR;
+
+		n_punched += PUNCH_SIZE_FACTOR;
+	}
+
+	atomic_store_explicit(&ctl->stop, 1, memory_order_release);
+
+	if (waitpid(pid, &status, 0) != pid)
+		ksft_exit_fail_msg("waitpid failed\n");
+
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0) {
+		child_status_failures = 1;
+		if (WIFEXITED(status)) {
+			ksft_print_msg("Child exited with non-zero status: %d\n",
+				       WEXITSTATUS(status));
+		} else if (WIFSIGNALED(status)) {
+			ksft_print_msg("Child terminated by signal: %s (%d)\n",
+				       strsignal(WTERMSIG(status)),
+				       WTERMSIG(status));
+		} else {
+			ksft_print_msg("Child exited with unknown status: 0x%x\n",
+				       status);
+		}
+	}
+
+	child_failures = atomic_load_explicit(&ctl->child_failures,
+					      memory_order_acquire);
+	child_verified = atomic_load_explicit(&ctl->child_verified,
+					      memory_order_acquire);
+	if (child_failures)
+		ksft_print_msg("Child: %zu pages verified, %zu failures\n",
+			child_verified, child_failures);
+
+	parent_failures = verify_pages(parent_base, is_punched);
+	if (parent_failures)
+		ksft_print_msg("Parent verification failures: %zu\n",
+			parent_failures);
+
+	munmap(parent_base, FILE_SIZE);
+	munmap(ctl, sizeof(struct shared_ctl));
+	free(is_punched);
+
+	(void)n_punched;
+	return child_failures + parent_failures + child_status_failures;
+}
+
+
+static void thp_cleanup_handler(int signum)
+{
+	thp_restore_settings();
+	/*
+	 * Restore default handler and re-raise the signal to exit.
+	 * This is to ensure the test process exits with the correct
+	 * status code corresponding to the signal.
+	 */
+	signal(signum, SIG_DFL);
+	raise(signum);
+}
+
+static void thp_settings_cleanup(void)
+{
+	thp_restore_settings();
+}
+
+int main(void)
+{
+	size_t iter;
+	size_t failures;
+	struct thp_settings current_settings;
+	bool failed = false;
+
+	ksft_print_header();
+
+	if (!thp_is_enabled())
+		ksft_exit_skip("Transparent Hugepages not available\n");
+
+	if (geteuid() != 0)
+		ksft_exit_skip("Please run the benchmark as root\n");
+
+	thp_save_settings();
+	/* make sure thp settings are restored */
+	if (atexit(thp_settings_cleanup) != 0)
+		ksft_exit_fail_msg("atexit failed\n");
+	signal(SIGINT, thp_cleanup_handler);
+	signal(SIGTERM, thp_cleanup_handler);
+
+	thp_read_settings(&current_settings);
+	current_settings.shmem_enabled = SHMEM_ADVISE;
+	thp_write_settings(&current_settings);
+
+	ksft_set_plan(1);
+
+	page_size = getpagesize();
+	pmd_pagesize = read_pmd_pagesize();
+
+	ksft_print_msg("folio split race test\n");
+	ksft_print_msg("=======================================================\n");
+	ksft_print_msg("Shmem size:       %zu MiB\n", FILE_SIZE / 1024 / 1024);
+	ksft_print_msg("Total pages:     %zu\n", TOTAL_PAGES);
+	ksft_print_msg("Child readers:   %d\n", NUM_READER_THREADS);
+	ksft_print_msg("Punching every %dth to %dth page\n", PUNCH_INTERVAL,
+	       PUNCH_INTERVAL + PUNCH_SIZE_FACTOR);
+	ksft_print_msg("Iterations:      %d\n", NUM_ITERATIONS);
+
+	for (iter = 1; iter <= NUM_ITERATIONS; iter++) {
+		failures = run_iteration();
+		if (failures > 0) {
+			failed = true;
+			ksft_print_msg(
+				"FAILED on iteration %zu: %zu pages corrupted by cross-process MADV_REMOVE!\n",
+				iter, failures);
+			break;
+		}
+	}
+
+	if (failed) {
+		ksft_test_result_fail("Test failed\n");
+		ksft_exit_fail();
+	} else {
+		ksft_test_result_pass("All %d iterations passed\n", NUM_ITERATIONS);
+		ksft_exit_pass();
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 606558cc3b098..530980fdf3227 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -553,6 +553,8 @@ if [ -n "${MOUNTED_XFS}" ]; then
     rm -f ${XFS_IMG}
 fi
 
+CATEGORY="thp" run_test ./folio_split_race_test
+
 CATEGORY="migration" run_test ./migration
 
 CATEGORY="mkdirty" run_test ./mkdirty
-- 
2.51.0

