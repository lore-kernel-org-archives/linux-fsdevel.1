Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012029.outbound.protection.outlook.com [52.101.53.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DDD3BED29;
	Mon, 23 Mar 2026 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283886; cv=fail; b=UisUIl/IERa0tC0yxTHxpVXBBgasBusHwHoVw/6n33efH/N9Vrkx5xDg2u+STihKq4+PoZyYLhRCwoGuKhxrEK4dpRIsX/daL75ohi2WnigYM+B5+pI2a9Y+Vy/nlA0sis5b4eG3Uz7ZNDc6glrCf/lim2IPfjpHEjVIPEefMVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283886; c=relaxed/simple;
	bh=FPNcS6lgjDTg/9eYJ9nt6mV+I1M3LMJBP/a1yM7Nxxs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZRWY2CIYxZ+qYT0RIIFHmu6BL2tHe7S7rLLS/U+Z64M0ayONmq9RMI7D5i+cISUaqK/UJjZhqhLkRhxSMhbd8SrgfB9QwO26DYTO65TQ8dyqzB1LiLEd2dio5PcloCf9tCfOqac89ZsA7lQ7dJdczhOt7fr5SU3B7vYEAdrdwHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PD7YBCll; arc=fail smtp.client-ip=52.101.53.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PD7YBCll"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYk17fscVtZlDDDU7BQMHxKYKg3lsuHLtx7s5jL2j8oCHrARouN4CqGC3Wu7KiBVVs9bvPtyI8TAoujjWJCuytgho75PmpsokCx3kN2x4Rl4KkgMJFhi+OVMdeIogH3mokGABGt5jRKTDCu/L2iiKzjeOnwPsca6fjp+hVagSCZs9+IUzUAYpSZY4DmZk+qFnUJV7B9ykaLTHvruzRfz5f/H4Nf55wnCm29UHMiPiNZR061cucaf544UjusfEgsSLXkh3RPnr1lXk3qolw43FVzhIt5DvXE4tef1sn5xt8M/gaALd7et3693egfRRwl5plJO3yYSZWsYPOILQM3hzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjB50ssHCWkcla6JdIyoqx8YLFaZP68Y0CNcG8ojUhs=;
 b=A2FwZCBZdHGO9rGpSNf6aPpiCgWp22KHhR7L9jRVF717g5nfG59ualCf8zmdV7f0KbARoaQ+s9QQ70q210mN3NTi7KlVQnUVJSSqAjemlcrezNfMgIi4O/qY9t+K6LiEw+ufLQOGoMOk9nycIkFO8LbjUsQVeUbs0yjJbOVD9Xy2jTOwAZc9oekEI3UthseGReE0XG9EeB77eFW5AY/VJ7xVn7+3mheqvTj6L+Q9IBaQiEtXydCsznzppyYCt6jci9CIeXXD90e/vIaS9ocI4A7l8oGK7BWMsEDQ/7P9u7bqa502cMoj0PZjtgM5goLBmllJbBPmOLTkCUrKoLZzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjB50ssHCWkcla6JdIyoqx8YLFaZP68Y0CNcG8ojUhs=;
 b=PD7YBCllIZOVnIzQYGGBtz+NBBcZTZvyhNiJEk1lqIMyqnbi/nfIT0kQpeH/+mtaAx3dN5EfXc1UdrgP8csRFGYstkWf/NcFj5BKvrdMscKsqHU67m3AwdG76gelY9ER7XdTvlsm9E8Nj+15iOxG7Yxdv0RiXGUNAQSS5ZWAFCmA34fmJeZO/7Q8NXts8ZvBPEkDlzp8hTo+eogISP+TBw/suSx2ilKS4LGtQQvM2iX0L7sM4BiK/KEvEkyy5AbmlmhRoAV9HkgIIrOBcapyqXhYJaJWO3lR5NIs3M/0Ed5lj4Biora/MilA5kFlTVjHK5A0F1BsCqS6E2JCmuBvwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB7830.namprd12.prod.outlook.com (2603:10b6:806:315::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 16:37:57 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9745.007; Mon, 23 Mar 2026
 16:37:57 +0000
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
Subject: [PATCH v5] selftests/mm: add folio_split() and filemap_get_entry() race test
Date: Mon, 23 Mar 2026 12:37:17 -0400
Message-ID: <20260323163717.184107-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR18CA0050.namprd18.prod.outlook.com
 (2603:10b6:610:55::30) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 8837a241-bb94-48dc-f78b-08de88fa8a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kRfD8Zq2E6CqgtDuUot01G9QwXe1Le+SRyd4dephBF4ui4wrHqo2M04M8NuJmXSNopr52350tjt3YiqeqqqlRMn0XHEFD3HeFOJNSKUYjoz64JyJTYCazv52cajc1gI66uvrelAdnKf3Mt+RZCx4PIhG4UZqX+TkHw6Ug4dsbk0BAOqLY+37TDLkBYiO3ByvUOL+LvNn3OG1oa+ocWbzuthXXE3DzoPkgtRUcwpum9k54ryndOXZHoZFAWJ2gyJUGWO23WKP3mnHq/NtVwitc3SGD+gZJaMIwRjsubNHZ5XfYPI/1O3LapybaDl/DQNoIHY/VI7M9qGuzCh2MKUy64XT4AeKGFzGb9KTuOHjd3iq5UaTvONaM42SSRtm/3OtSt2zT5pZFlSnV2KIV3FcBFEKrJC05BCJbaJhaDG6mZcNHN6lZPnuwKfQFN6fQ4Qm/ymSMj0Q/Bpgtjix4m4dxg1uBRgzJlPPGBLEpEuWXqr6Bo+AhOHCquXs9ngy4sYI5Ys/ukiC5Ow3bXznHQFvYh8aTlexpcGAeBMHLM1U7RsLunj/UqHUSeUPa07IhFLUawCfb7OcEFcms6YxZPqXP9cVIlCJBwunhiRjsEQaieGjvqxgMdNNd8H1XsEne4nsG3qLkd/ctJbfNENoFEI6GWfbTuA4lpj9t6aOmiR0jN6hxCo2LSovCdXbbJ8YoykXKFZ7/OOsVbxhU5lVig0fMpyrNz1zolQmgGGsfQ/HgLI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1c+6I8NtSu1ErrPP8ji2YMv9y6VY2fjWXV2EO2YL1omRPyWMooHCSpIj2NJ5?=
 =?us-ascii?Q?eIeADPvsQVoZlZ0ze2TPnr2hbKMkrYirk8NrILBSocsqAgyBWq3ECFVBO37q?=
 =?us-ascii?Q?jruLYYd2zIQrQXsjJVDWUev2+SYzuejz4V67gRgwLyWB2Eze7ptViglgiVX7?=
 =?us-ascii?Q?G884n6vjF/PvfYwrg6+B54LH6O7TXygM09kmGVE3kIv12Ml4Nwe66SzbqsmJ?=
 =?us-ascii?Q?N4U86Dzoi3WnIP/BlNIn2gjCf1yOaVvPC8XKMvwxPmaW1u3L8WFRnasi9lh/?=
 =?us-ascii?Q?TaJqan6j428bjCC9dY85i1M49n5QfVeiaxKb70GyH0sIUnSyBM+L85/FL4q2?=
 =?us-ascii?Q?tGr/6l1Tf+RlFxStOeFYpZzQ3oRgFZdEe1htIF8Nd07i10NrxO2Ml9pmJ1Pz?=
 =?us-ascii?Q?euCkgT3Xj6/a0Qi5GoDlePUSgMzVqifJTUXlfAVF0MGSmiCKusUlBcaw9i1n?=
 =?us-ascii?Q?50zbGHjHyxh2y5Kci+gLFzeSfPL6i9f+nxPspUnHAgQJ3wXPXE330Qf6mDju?=
 =?us-ascii?Q?i3OuiCgNAQwYNvEICC/dpBKjF1mVSsGValNFju+qBsruawtgfxgar06JQfN7?=
 =?us-ascii?Q?9khK3E8naTbzJbs91T7U7ghVCsT6Dm6eWuSt4AWETLj3ujfm90Orwkxk0Zwg?=
 =?us-ascii?Q?zGH+9TqmxLSjBEoP6R1IWKf312hkMJDE2slk4/G52Q8ERt4Pc77/fHNNwVpd?=
 =?us-ascii?Q?z5hs3kCgLczQQmnFSYSdvv+cZHK1ok1fDzWu9VJ48y5riCQ365wmDLrEvujD?=
 =?us-ascii?Q?MxvMO1rRtMfPKo0dG3JZ3yx5x46acXvbwSsbPYgFXf0RZOqsikNaIn0klK1t?=
 =?us-ascii?Q?jz0Dv5UdujNjanvmHIJ2YZEDLmvJDYI/UsmNv9X3Ix07/oxZTu2P5WrP2J6j?=
 =?us-ascii?Q?hcgnQcX4DNy8HRYCeEpVu1yEsldSjh523C9PWMo2uugqUiOXBBHEoaPidACC?=
 =?us-ascii?Q?BxTgBlcKeeamdQDG2YRaOYDaQf6nfOB4CS2EydgpBaKP7egsQLSWrAUU2tfa?=
 =?us-ascii?Q?0lNdmvVdr6sl9Q5YSRFxleWd6pTZQ2ddN8+yhPPnyLAx5o9KbnvRXmOnh8Il?=
 =?us-ascii?Q?d/MrzGmeR2RpncD7E+L0SC3cp3Fnlqd/zjJmoFKTxhSyzkBJDdBCY/beszZ5?=
 =?us-ascii?Q?Ap2kYOV2jbTLzgBrjEEqeb8o6PqzmLh8a4wiqhP1OoeqW/Y39Mlde1Gt5QTm?=
 =?us-ascii?Q?6lP2i3Mhf7kDysRIA6m//bzMNm5+XIpAuEb1tlQ0vR8WoAhwAQvhltctUy7r?=
 =?us-ascii?Q?vEAOlM6zCXkKIavAWVfS2gYY86WzAyTxm3woRt82FTD6lNEc2LGjzblEjnfy?=
 =?us-ascii?Q?Na7Fr1z8jpfTY9fWs8g8Pge7Las392o9NYOPNgteBw+oL/hCt0y2Cq2RG0Oo?=
 =?us-ascii?Q?z9hgmVncGBo7L7l4M/AJ1NWuJ6MFsu5jLM9xJuo23AuS0Nof16pzy18J6w69?=
 =?us-ascii?Q?qlpj4+H+D2EblcH0ZBOMT5v52w/SS4iYaKiZe/eAWwUcI2Zv3vEJzAbV1Q3q?=
 =?us-ascii?Q?sCIXpJW/x6zXviCzY6RIA8mRUJ5euxXFLKzcfjkgZEJJVXtDrW2nGjStSozp?=
 =?us-ascii?Q?wgqbO14nTfwY4/YipXaFF3dl7GpcTJRVtDKJmqg2GEkUuD1r+QsZzgMMQmfV?=
 =?us-ascii?Q?xJvjA6XYPWsW9kb0/TAi8UP+lx6AxKkejXYL1gEiGHF5IQ7fO4X2m83rZnc7?=
 =?us-ascii?Q?WRC5wh/EzoWAStxOt5ERBd4n5q8PFI9cscsKUcrxNXJ+eEO5wmnLMgcMqqZ9?=
 =?us-ascii?Q?C5yqI1tLhlDf9kBs6IORcIxhPhn6QJNyGgE3lXk+y5vX1+0LhINi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8837a241-bb94-48dc-f78b-08de88fa8a1a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 16:37:57.4932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4eT/E61t3onWoLMv2VGWhxRA2EkA+Pb0tvJ7pKQjxiBh0UHZRfmFvY5oYGhfjK6R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7830

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
Co-developed-by: Bas van Dijk <bas@dfinity.org>
Signed-off-by: Bas van Dijk <bas@dfinity.org>
Co-developed-by: Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>
Signed-off-by: Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
From V4:
1. added missing .gitignore entry.
2. used PRIu64 for all uint64_t.
3. added pthread_barrier_t to ensure main thread starts to punch holes when
   all reader threads are spawned.
4. converted size_t to uint64_t.
5. used thp_availabe() instead of thp_is_enabled().
6. added a check on read_pmd_pagesize() to skip the test if pmd_pagesize
   is 0.
7. removed static test information.
8. started iter from 0 instead of 1.
9. simplified test failure checking code.
10. added missing Co-developed-by.

From V3:
1. fixed for loop stepping issue
2. used PRIu64 instead of %zu for uint64_t.

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

 tools/testing/selftests/mm/.gitignore         |   1 +
 tools/testing/selftests/mm/Makefile           |   1 +
 .../selftests/mm/folio_split_race_test.c      | 297 ++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh     |   2 +
 4 files changed, 301 insertions(+)
 create mode 100644 tools/testing/selftests/mm/folio_split_race_test.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index 83ad9454dd9d1..b0c30c5ee9e30 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -61,3 +61,4 @@ guard-regions
 merge
 prctl_thp_disable
 rmap
+folio_split_race_test
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
index 0000000000000..ff026f183ac7e
--- /dev/null
+++ b/tools/testing/selftests/mm/folio_split_race_test.c
@@ -0,0 +1,297 @@
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
+#include <inttypes.h>
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
+	atomic_uint_fast64_t reader_failures;
+	atomic_uint_fast64_t reader_verified;
+	pthread_barrier_t barrier;
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
+static bool check_page(unsigned char *base, uint64_t page_idx)
+{
+	unsigned char *page_ptr = base + page_idx * page_size;
+	uint64_t expected_idx = (uint64_t)page_idx;
+	uint64_t got_idx;
+
+	memcpy(&got_idx, page_ptr, 8);
+
+	if (got_idx != expected_idx) {
+		uint64_t off;
+		int all_zero = 1;
+
+		for (off = 0; off < page_size; off++) {
+			if (page_ptr[off] != 0) {
+				all_zero = 0;
+				break;
+			}
+		}
+		if (all_zero) {
+			ksft_print_msg("CORRUPTED: page %" PRIu64
+				       " (huge page %" PRIu64
+				       ") is ALL ZEROS\n",
+				       page_idx,
+				       (page_idx * page_size) / pmd_pagesize);
+		} else {
+			ksft_print_msg("CORRUPTED: page %" PRIu64
+				       " (huge page %" PRIu64
+				       "): expected idx %" PRIu64
+				       ", got %" PRIu64 "\n",
+				       page_idx,
+				       (page_idx * page_size) / pmd_pagesize,
+				       page_idx, got_idx);
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
+	atomic_uint_fast64_t *failures;
+	atomic_uint_fast64_t *verified;
+};
+
+static void *reader_thread(void *arg)
+{
+	struct reader_arg *ra = (struct reader_arg *)arg;
+	unsigned char *base = ra->base;
+	struct shared_ctl *ctl = ra->ctl;
+	int tid = ra->tid;
+	atomic_uint_fast64_t *failures = ra->failures;
+	atomic_uint_fast64_t *verified = ra->verified;
+	uint64_t page_idx;
+
+	pthread_barrier_wait(&ctl->barrier);
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
+static uint64_t run_iteration(void)
+{
+	uint64_t reader_failures, reader_verified;
+	struct reader_arg args[NUM_READER_THREADS];
+	pthread_t threads[NUM_READER_THREADS];
+	unsigned char *mmap_base;
+	struct shared_ctl ctl;
+	uint64_t i;
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
+	if (pthread_barrier_init(&ctl.barrier, NULL, NUM_READER_THREADS + 1) != 0)
+		ksft_exit_fail_msg("pthread_barrier_init failed\n");
+
+	create_readers(threads, args, mmap_base, &ctl);
+
+	/* Wait for all reader threads to be ready before punching holes. */
+	pthread_barrier_wait(&ctl.barrier);
+
+	for (i = 0; i < TOTAL_PAGES; i++) {
+		if (i % PUNCH_INTERVAL != 0)
+			continue;
+		if (madvise(mmap_base + i * page_size,
+			    PUNCH_SIZE_FACTOR * page_size, MADV_REMOVE) != 0) {
+			ksft_exit_fail_msg(
+				"madvise(MADV_REMOVE) failed on page %" PRIu64 ": %d\n",
+				i, errno);
+		}
+
+		i += PUNCH_SIZE_FACTOR - 1;
+	}
+
+	atomic_store_explicit(&ctl.stop, 1, memory_order_release);
+
+	for (i = 0; i < NUM_READER_THREADS; i++)
+		pthread_join(threads[i], NULL);
+
+	pthread_barrier_destroy(&ctl.barrier);
+
+	reader_failures = atomic_load_explicit(&ctl.reader_failures,
+					       memory_order_acquire);
+	reader_verified = atomic_load_explicit(&ctl.reader_verified,
+					       memory_order_acquire);
+	if (reader_failures)
+		ksft_print_msg("Child: %" PRIu64 " pages verified, %" PRIu64 " failures\n",
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
+	uint64_t corrupted_pages;
+	uint64_t iter;
+
+	ksft_print_header();
+
+	page_size = getpagesize();
+	pmd_pagesize = read_pmd_pagesize();
+
+	if (!thp_available() || !pmd_pagesize)
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
+	ksft_print_msg("folio split race test\n");
+
+	for (iter = 0; iter < NUM_ITERATIONS; iter++) {
+		corrupted_pages = run_iteration();
+		if (corrupted_pages > 0)
+			break;
+	}
+
+	if (iter < NUM_ITERATIONS)
+		ksft_test_result_fail("FAILED on iteration %" PRIu64
+				      ": %" PRIu64
+				      " pages corrupted by MADV_REMOVE!\n",
+				      iter, corrupted_pages);
+	else
+		ksft_test_result_pass("All %d iterations passed\n",
+				      NUM_ITERATIONS);
+
+	ksft_exit(iter == NUM_ITERATIONS);
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
2.53.0

