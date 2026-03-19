Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012065.outbound.protection.outlook.com [52.101.48.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40BD2E1722;
	Thu, 19 Mar 2026 19:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773947060; cv=fail; b=bpj2jxRvJ08SVutSYVR2xY01ghfGGV+/R6l5uSzoG4PrXchguWixRWEBYBRgtMc+nl6jWcsGgzM9bJRBaYzIZSrD91/rNMMngsbjYLGyYjU4WtcNN1xXa3o0Zo7gSg51kh5WqNPLFGGoWOE2waeD5QcYuTG+pl6iXla/0FkhahA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773947060; c=relaxed/simple;
	bh=LvV9fgwL/q3HAXkwzw8JVfh5oCIQDZd66NIxwtGGKMo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kY7uO+oobkwGQxTGFh7AnAdlRxDsWMv/LVRpF1aHqj+gF2sxgd0qAElv+zdBF5MpzBdndwl+la9qFTfZr+3X4M1V/iamSGPXNjnajLyPUEG4XJipfHd8GvxP/2i7xGJE1NkM9GRXSdr4Lj7ANyCooWsOHpROmCZssPvoL0Po45M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uNOjF6xI; arc=fail smtp.client-ip=52.101.48.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uNOjF6xI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naCi+iOTncOr0qIqs3CJJv0dzRdwC74mUAlIhOOaAC0RuSfBzfzTIvvzWLHt/Ct8IDwuK3Mu6522+LBAOKpO/zhsCbUrdf3IrBD3ZtEua7LM1GY0EPxKHIBM+JPXOw6WWiddnLJhGM/vkvqE6DFN0VyWaYo8osJM9EL/FGZ9AQPxXz50fau+0MXOemcGk5pLzhPEWH0NmM262JxplV+TAw3UH4dPL8bgJgwxk0QpoFar03twk/pTwBkzpysvTryFbWGZnGD8tNugeEvWFV6SquoTDEWkr242+aZANaqYF5rke18Ul3xa5EPFAz2e7tz/DmccnknfbVWO97BcbfuC+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTO8AED8vlA8ffS8MKQw9JpuJkZojHd4BL5Az0y3IKY=;
 b=cykobQ4Sk+oZ+rSzhVqEZqeaN5oYmaYESYNccejhcKNL7kfY/V6PgkZhUlPOSfOFgFs/8rlfNwycUCJ3gqLArkoIZStt2msBkdMinL1jGIp4oeGq1HN1BbRTzX2PJ6LAllXGeXcRjk2jom80NhXrQixDLfM99WztR402Lv4Mei6pOZRaBWb6c3SNKOCQLEbdkPkoaXux5itaEFm0wrgy6ykb9xznvsJRgGf0yInDzHt9HfCjehtEn9FlfZkfpN3KGlH52J6KEn7vll3e76aDSrtuUlP+HPvGNN2EGykt6BafEOxkla60c37VdrG4TToEJJTSV2n/2ncsu2RDI40CLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTO8AED8vlA8ffS8MKQw9JpuJkZojHd4BL5Az0y3IKY=;
 b=uNOjF6xInPTTjaetJxlAtF4b7HxSxQwR4pa9LgtJSuiJL8Bk9V7I1BnLuu3ClrhVoXW3n18PNVX32boxNahHuMU0RH60VXi5YbhMchtUG6wtFF7g8JdGaGtD2xZrrIv08xEnwE/MVXs2+UcQUrQ6dIh0SaTcef6TKlC803CZQKqZ/xBNi2omOtuIyZnoCQ/JKQ4ZqmQ/MSJ8peulY4G+GmWZbSLYvnyhRETBYbDnoHGfj2tYCVwff4WwyTiJZZ08ov6FjOq+7OvFCfWtNyKkVrsN9/CkqCxA9tum3EJdSEygOIXBbEu5HBVir6u6MPYSduqiEmuXFYvLT6Eq/xBIVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS7PR12MB6120.namprd12.prod.outlook.com (2603:10b6:8:98::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.9; Thu, 19 Mar 2026 19:04:11 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 19:04:11 +0000
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
Subject: [PATCH v3] selftests/mm: add folio_split() and filemap_get_entry() race test
Date: Thu, 19 Mar 2026 15:04:08 -0400
Message-ID: <20260319190409.294523-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS2PEPF00004564.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::51c) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS7PR12MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ef1eff-b765-4071-0ce5-08de85ea4e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	krDfu+3bY8SSS4elcZQsCSPQ7nvSMUiOZueGdXW39kkpzU65c9Yz+0agnQeIgpECbwyVLPcilsFTSqivKwH5F9oa3exA2jV5yW1/TheEaEugTkmdrgQBZyFMD/C2a4LwmFuxviNnowDKcbT7cdOdnie3c4CmLeUN6JmXFmmz6Jys/mKlD1q2ZXMz4usDHE+Vb4lZfBAIXbiY1CWAqJLiJc5vk9HNO04eN/tAjC2IzBoG3vR+PbFuNKtr3UM7P48ezSzs3noWaTzWoff6kQBHRHEy9EIIEgj5v2/HOvoPc2XWQIBLUYA3glURC6AmdOb1m4iwz59FK7Ajvr7SqNAm0qoQqxyDnysl8D+iuh1k/u8E3YhLbp7gso3hL4BDrelXYLyDagiDkPMQPEUQszdDP+Ovg60Mfo/CYD/y1YmGwUvqs1ZA1CUEpqVf4WugoHctoFLBSfh9yjRNzAH5OIo4Bd77u14ABC8n7nsReQbSTb+fd89ZLpkETJtYYYApeSJGrFRwR1fO5IQj42Byu20uIEHIUWJ3fi6KFfVqttdEa4QRzFfc9Ke4FUTxjTvD9UVzwfvXkYpGJzpo9uCi4/XEqzfcShMASZ6z5/L2FOFvORC2Z1M/U0VjYly54m2ZcuI5/tCUlmk8ycPISnw+ykKDI7rt8OW75JXbUTw2h9B8s7ba1p2P4WvPPiaeNfUx6NXIGfIXS0osquNh3x+iEOT+viBde2WXgLj2WhP8qJTAtZKkoxHtf6jCLkHW4ltGHbsF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GIDGbxXznsRnLnJmQ4epaAS9JF9M5xPNRUCKXHslPkbfJoAsy6zzzC60tMeE?=
 =?us-ascii?Q?D2/y/MEh9xIQMuo/rMq9dkiBi6H2En9qccesV1LR2murMHZncvn+WDucNg2j?=
 =?us-ascii?Q?Ua9VkTRumLm1wKIbZhBvBDT04hNTT20VhNPu7g36hVlSE71SosgHFL0czM5R?=
 =?us-ascii?Q?3n87AxHXwQeJlPOUqg2VrhJEsFudz5uE3Yo+uTiCzyM8ty6igE3xrgjSJZXY?=
 =?us-ascii?Q?cd/24YQ4ZWuQinIfL0LglXgL3PyLcFDxLJDetT32hM/ZObH3gCqdNehD0Nwy?=
 =?us-ascii?Q?uET6qWBn7YJ5pbHldTrB7mWmR+Efg3oAOzIPpk74t7pcilHDxe2YR/bwlwp/?=
 =?us-ascii?Q?ddrnOLDrB4giyxSZuhgl3dORE0Mc/C6ISzeSD4EMS3VsoCLwZ4EyIjo+yMF4?=
 =?us-ascii?Q?YXKBUlo8NlcDvNW7Ce5RKLOSmr6ngjpfERIyPuca3paAFh8ZQkKo+CKMET16?=
 =?us-ascii?Q?BJndWPUfYEued9xMeW/ZnZ7d6f/owIOVwas0KQFrxnBcYLCu1/+N+a0lmSCM?=
 =?us-ascii?Q?RwYseqMmRp+2S5WaMpBGMAZmGDTKhdVuKofp7jCfaGOUV3jY/Y2/W2W9KyGp?=
 =?us-ascii?Q?vU5D53JfWjsoVEeXR9yTnSq4UCY5XIPPtjEVopOx23htI5sVMF46IwNvnYC+?=
 =?us-ascii?Q?d9/0Plkn1/b9kGmpUhEHob4tjIaRDMYK7BPQBkRxyBv3+k/kD/Jzt+HRQvaF?=
 =?us-ascii?Q?/gbR3syLPGjb04HOuEnq1+Xnky5y27kr0JIJG4+fhMxMSY5+1/AAbePli5kY?=
 =?us-ascii?Q?ONsvgARtXxwNF/Y+964evP8lbVLw293M3xg8Sxlxq1KODm6f6fTPF0zos0RC?=
 =?us-ascii?Q?l7WyDcEXm3FSOdHJp8j13Y0rcnCg/HfCRXDZK/M59VMWCLBZ/R8RhAeuzXZ9?=
 =?us-ascii?Q?RVzaUM+4dHiH59s6G/YrKJfhPwO0TCBUKdhCuICg0I8pKin1H0YqC4ywVUjt?=
 =?us-ascii?Q?FYs1G/9plFLl36P6BpCVfQZBkBDLOIjsSYZF4Kcv2xxxnOYvwuwwXGEJd+D6?=
 =?us-ascii?Q?Gg9DGarx9NVq0f8HY5v5FtC2hjYKqL0N9GNYrB1M/KfHFBGJUT35JTiwd6JG?=
 =?us-ascii?Q?8/iNLYTY5byTaNI0195Pue3T7nJRadyd6MSFvbKqUGhpJfcIPBVYnCL39Pwa?=
 =?us-ascii?Q?94fV/H7tW6VYvdcO+bTW+yt1Dppfa+7NCeGeF+iWUu+Ua8o2UxtV8kRKgOUQ?=
 =?us-ascii?Q?eMLPfgPWG6Sdi5m8DL2NjJdoHXEKpFvtGKi/MMLMh5IlhM9yFe2ddwRn8dQ5?=
 =?us-ascii?Q?iSM8/r2tdg/MzPVDqs6isj12qvvcP/MXcwM31orkKjsJZ4zpnClHI//BLPGb?=
 =?us-ascii?Q?1Og8qpdvLy0TjAV+4iXr4qzLLjZTItSijruoYPb7UR9yk7urnVHY7e5LKS/l?=
 =?us-ascii?Q?eNpQtiGP16bZ9KO1CpZLipGbEmgKPYYt6dl24fU4LVjcrQA2l9egc6Vk9aX4?=
 =?us-ascii?Q?W1XPIVxm+iX2mrFLn6mhzWnzQIJM76bVWI0qd15szqA2przyzqIZYe3IgbxD?=
 =?us-ascii?Q?m5gbXzo2wDE7/V/ZF6gAApndWZFHF+k+IrwTWADWl/s2c1ifXJmr2PmfTKX/?=
 =?us-ascii?Q?ssK2JN3c5KOGPsNo5QbJcSTn5Unbg4WMVxfYyj7dKNqMCpyDPFtmCftZKn6V?=
 =?us-ascii?Q?dR4jg1b0/k44/HbrlUA6uIX1HnMC23P9ZUJRW6lvlzf9D4w/2KaZLBneWTXc?=
 =?us-ascii?Q?YwBDcMgb/mo0sMKxQ2C4i+rretg8Vz2Gr9qNHREPdALqflwL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ef1eff-b765-4071-0ce5-08de85ea4e25
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 19:04:11.5319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/n5UIkQ5CWDKbV9oyaUsfbMYt2ZwRkkx6xiQBStR5w7alFAt4fwwGAPgyb35xxJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6120

The added folio_split_race_test is a modified C port of the race condition
test from [1]. The test creates shmem huge pages, where the main thread
punches holes in the shmem to cause folio_split() in the kernel and
a set of 16 threads reads the shmem to cause filemap_get_entry() in the
kernel. filemap_get_entry() reads the folio and xarray split by
folio_split() locklessly. The original test[2] is written in rust and uses
memfd (shmem backed). This C port uses shmem directly and use a single
process.

Note: the initial rust to C conversion is done by Cursor.

Link: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/ [1]
Link: https://github.com/dfinity/thp-madv-remove-test [2]
Signed-off-by: Bas van Dijk <bas@dfinity.org>
Signed-off-by: Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
From V2:
1. simplied the program by removing fork.

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
 .../selftests/mm/folio_split_race_test.c      | 292 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   2 +
 3 files changed, 295 insertions(+)
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
index 0000000000000..efe4b631edfc4
--- /dev/null
+++ b/tools/testing/selftests/mm/folio_split_race_test.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The test creates shmem PMD huge pages, fills all pages with known patterns,
+ * then continuously verifies non-punched pages with 16 threads. Meanwhile, the
+ * main thread punches holes via MADV_REMOVE on the shmem.
+ *
+ * It tests the race condition between folio_split() and filemap_get_entry(),
+ * where the hole punches on shmem lead to folio_split() and reading the shmem
+ * lead to filemap_get_entry().
+ */
+
+#define _GNU_SOURCE
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
+#include <signal.h>
+#include <unistd.h>
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
+/* Shared control block: control reading threads and record stats */
+struct shared_ctl {
+	atomic_uint_fast32_t stop;
+	atomic_size_t reader_failures;
+	atomic_size_t reader_verified;
+};
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
+			/*
+			 * page_idx % PUNCH_INTERVAL is in [0, PUNCH_INTERVAL),
+			 * skip [0, PUNCH_SIZE_FACTOR)
+			 */
+			if (page_idx % PUNCH_INTERVAL < PUNCH_SIZE_FACTOR)
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
+static void create_readers(pthread_t *threads, struct reader_arg *args,
+			   unsigned char *base, struct shared_ctl *ctl)
+{
+	int i;
+
+	for (i = 0; i < NUM_READER_THREADS; i++) {
+		args[i].base = base;
+		args[i].ctl = ctl;
+		args[i].tid = i;
+		args[i].failures = &ctl->reader_failures;
+		args[i].verified = &ctl->reader_verified;
+		if (pthread_create(&threads[i], NULL, reader_thread,
+				   &args[i]) != 0)
+			ksft_exit_fail_msg("pthread_create failed\n");
+	}
+}
+
+/* Run a single iteration. Returns total number of corrupted pages. */
+static size_t run_iteration(void)
+{
+	size_t reader_failures, reader_verified;
+	struct reader_arg args[NUM_READER_THREADS];
+	pthread_t threads[NUM_READER_THREADS];
+	unsigned char *mmap_base;
+	struct shared_ctl ctl;
+	size_t i;
+
+	memset(&ctl, 0, sizeof(struct shared_ctl));
+
+	mmap_base = mmap(NULL, FILE_SIZE, PROT_READ | PROT_WRITE,
+			 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+
+	if (mmap_base == MAP_FAILED)
+		ksft_exit_fail_msg("mmap failed: %d\n", errno);
+
+	if (madvise(mmap_base, FILE_SIZE, MADV_HUGEPAGE) != 0)
+		ksft_exit_fail_msg("madvise(MADV_HUGEPAGE) failed: %d\n",
+				   errno);
+
+	for (i = 0; i < TOTAL_PAGES; i++)
+		fill_page(mmap_base, i);
+
+	if (!check_huge_shmem(mmap_base, NR_PMD_PAGE, pmd_pagesize))
+		ksft_exit_fail_msg("No shmem THP is allocated\n");
+
+	create_readers(threads, args, mmap_base, &ctl);
+
+	for (i = 0; i < TOTAL_PAGES; i++) {
+		if (i % PUNCH_INTERVAL != 0)
+			continue;
+		if (madvise(mmap_base + i * page_size,
+			    PUNCH_SIZE_FACTOR * page_size, MADV_REMOVE) != 0) {
+			ksft_exit_fail_msg(
+				"madvise(MADV_REMOVE) failed on page %zu: %d\n",
+				i, errno);
+		}
+
+		i += PUNCH_SIZE_FACTOR;
+	}
+
+	atomic_store_explicit(&ctl.stop, 1, memory_order_release);
+
+	for (i = 0; i < NUM_READER_THREADS; i++)
+		pthread_join(threads[i], NULL);
+
+	reader_failures = atomic_load_explicit(&ctl.reader_failures,
+					       memory_order_acquire);
+	reader_verified = atomic_load_explicit(&ctl.reader_verified,
+					       memory_order_acquire);
+	if (reader_failures)
+		ksft_print_msg("Child: %zu pages verified, %zu failures\n",
+			       reader_verified, reader_failures);
+
+	munmap(mmap_base, FILE_SIZE);
+
+	return reader_failures;
+}
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
+	struct thp_settings current_settings;
+	bool failed = false;
+	size_t failures;
+	size_t iter;
+
+	ksft_print_header();
+
+	if (!thp_is_enabled())
+		ksft_exit_skip("Transparent Hugepages not available\n");
+
+	if (geteuid() != 0)
+		ksft_exit_skip("Please run the test as root\n");
+
+	thp_save_settings();
+	/* make sure thp settings are restored */
+	if (atexit(thp_settings_cleanup) != 0)
+		ksft_exit_fail_msg("atexit failed\n");
+
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
+	ksft_print_msg("===================================================\n");
+	ksft_print_msg("Shmem size:       %zu MiB\n", FILE_SIZE / 1024 / 1024);
+	ksft_print_msg("Total pages:     %zu\n", TOTAL_PAGES);
+	ksft_print_msg("Child readers:   %d\n", NUM_READER_THREADS);
+	ksft_print_msg("Punching every %dth to %dth page\n", PUNCH_INTERVAL,
+		       PUNCH_INTERVAL + PUNCH_SIZE_FACTOR);
+	ksft_print_msg("Iterations:      %d\n", NUM_ITERATIONS);
+
+	for (iter = 1; iter <= NUM_ITERATIONS; iter++) {
+		failures = run_iteration();
+		if (failures > 0) {
+			failed = true;
+			ksft_print_msg(
+				"FAILED on iteration %zu: %zu pages corrupted by MADV_REMOVE!\n",
+				iter, failures);
+			break;
+		}
+	}
+
+	if (failed) {
+		ksft_test_result_fail("Test failed\n");
+		ksft_exit_fail();
+	} else {
+		ksft_test_result_pass("All %d iterations passed\n",
+				      NUM_ITERATIONS);
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

