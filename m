Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794293554;
	b=cSNO7Oci5Ppx9bWFrxO/o3cHfu/pBnWdtAMyZyOXD/GsjigFai4IKxUIzIL146XmRx+r
	 LvnlT0zl4fyoabjId2nnG0HapUXbd4P+QVn2R3MfhtDSNmdy8Aj2Noo+QQFGrazwb59hh
	 5eMyjpc4nDcXFkR/Cq44/iP4apAlkxnHKtZ0T/P8JZBKn2VBloQgvcubhWJS5JYf0Y/zZ
	 9cUy+hQmd5zgS42ezpnTH386URnyYzijqiS6vOG1zshVEjKULwFgTUz7j+Vh0XggPt764
	 uN53Kptx10wxzj/IdtxA7Ila1IGQf2LZVQ4ULwTIzNb487fb1cIsemdRPMilcJfTmSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794293554;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4mCgXnJJdViYBZ89pDxozO9aNLrUA/pladrQpi8TT7A=;
	b=khvhNZMfx3wO9BVaCgX/uEG6ss3scUAocZN8I4iTEIl2vuikE+JDuti2KjCH7Hc2miDv
	 sbyoCiv35XS16ClEVSJr9rSHX2Q2sY2SXwfATEJlZW7vc5Nh9Fv6VF3jIeHl3s1f5ku6l
	 d70UEJq8Njgv1eZwfyYrEMbdbTNnTGedR2X1WeT4+qqRyh1886KAv1Hn5q6gK1229r6d6
	 1FXcp5nPL1o0mq0MdefYgZ4s++kiWXgYRbfnfvNhPgf5zlo8saKs0HBNsJAHSR1JPMkzY
	 0baOTJkrtv5j7xQvrLqOGQoW/wYHMgYrdS7Acj4CspIGV+CPvl0jzXmukjVw0aQ0KYw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="Cn/3x0Ur";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.68
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011068.outbound.protection.outlook.com [40.93.194.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B8606A321;
	Tue, 10 Nov 2026 06:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 030B8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Cn/3x0Ur
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqOYcHPLyxO6Th4vMrMQlKJ8FWqEqxMBAepfMN3Wvd98PWHOi05yctZKPX82OVUKM9vO2saec6XotrP4KyUFRWkhx2u+/4zS3Kqk7poVmDJfoBbYato+Ka+mw4URZFoNQQTWDNjJajY4YP1dgvxnZHVC6WnDvpwyNhkMBxF1TjmwIzoV3uf5eMcZjyHT+ZHSmtgPgRSGnEwVMsDSzP8VrbjiYrbLCh04ytbhe+nbGCtqfUDwn2SJJoJDf4BDiO3zqn6lV2Mi0MIIPvQXzfEwpKLtl/mvtAaK5BL+RbQlQk8LkMSo9JvysDu/eQ316lifSaxjrnI7J2PcK0Pz8L2saA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mCgXnJJdViYBZ89pDxozO9aNLrUA/pladrQpi8TT7A=;
 b=nO4vhFKuf1LU9NFtUwHR9j14UFwvQacudKGQlYl13XlhtJ6KSpwWgjtHHSJGeItBeLRuvcvPcCT6HvFABzK5D0fb+9VpUQsrwMnWP7X55FFgeFAe/U72GJw0Y6Rd04u9J+lHpCPNusZdIH4e8ECWh5j5TyjZUtdb05Mkc6XAJ1jIL9keI/rytz0s59UfFLZwm54KT/LWIAC+hZrvCYse9cg/ceO02sa0c7KJFRQTE98fQVlGlzHsIOzJzD1bY1vy4MZoxl+HiiwCCrdE2U2Yew3LkKhHgyv5vLPPXikpg6fmJmVXJp/4C4mQkd5byL1sjLPDFZhhBAClgOsE2yawdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mCgXnJJdViYBZ89pDxozO9aNLrUA/pladrQpi8TT7A=;
 b=Cn/3x0UrS8i/4inczXeDbEotftJHoc9KqUuPDuT0ad31w4g1sZ9LQ2tmHonuT24wDBYGJcVKW0Vx7LhRZeV+MZKEHwaHY42FGOfBai1stKagdRapAtoNzwIUcPDm07rq4BILWxHoNZvEt7kabWxZww5vdHErJEAGw9WkJ6W/4R2XJkASC1BSgfxKw8hkDRir/ioukjQLdLOZDbEQS+RTTstevjNY0BZuGxrBroNdL3AJH74PH0szHQbxEfB4MEnJIgKl5LS8aAWJrqXAc7eOMGFKWDg+y7Llzsxr624202uoq4WTXxL9Jhex70veVe2XGY1wd7AzWqZcnoAoJEo0rA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by IA1PR12MB9737.namprd12.prod.outlook.com (2603:10b6:208:465::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 06:52:31 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 06:52:31 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Quan Liu <qualiu@nvidia.com>,
	Lee Trager <ltrager@nvidia.com>,
	Seth Forshee <sforshee@nvidia.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pipe: Prefer mempolicy node for metadata allocations
Date: Tue, 10 Nov 2026 07:52:19 +0100
Message-ID: <20261110065219.894219-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0004.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::14) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|IA1PR12MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d7bf88-91d0-43b7-fbf5-08df3ef730f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|10067099003|261028144727099003|11063799006|5023799004|56012099006|261102123227099003|261022105027099003|261022075727099003|261026121527099003|261021121427099003|261021123027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	aZzbIUyTvW+SF9rr5EAy1YKk9dhBTgmU46x26LNWyeapvoj2lO0gD5+B9AePNvwCrvbU2aeP4gpblAuwqrneo7BujPBm1cseNdl5ReF8pU87bYfv4ZC8qvklYHSPpsZlfk6sLRcbs/+TDrqHFEAkYaCLt3aWGqo36Fsa97T8SXWSZSxL4nQ7lGWjY5/WyyGDfRChJy2MB8Jg9e2N2eGFqqRX2CyEieTvQ8AsNkiLvHSw2lytBh8M3xJ/bkfD6k+II2VuxN2SMwWQyPi6tDH3BG8v2b1ruHJcN4HVyvJddhlEn3c199UGmNzt7edK3gny+dWc5PTVLS6emS10luQ98bf6mBLxxRR/647UyZk9LIocdefYcEBLLcIYEEfMsvnGyDIBgrbNp2bXcFin2B+Z0CLGLAKvGOb3Q+EymyzZuCBcJbv+FDh9lhVeWTtf/EMKnSn5iDeekJOfAeO0wk2Kp2JQjnGwtbWqJiGE0CE5FR0Raddhh8snQqV+KW4yfZEittWWkIWRO9j5Dk7PvMZrMD2XQv8kI7/udXTTIMWKjBa8JZTaJvxkaJ3hj5hu8XlGnEcPDVqjqbtG+W8zFMqGxuxVs2VcTV1n4m7woaeNLh3e3jS4wwkvcKjHfrXShb5D3ANBSeBImsXMSMU4VtF7hqFLOVlp+i9jWoFUP1mLg6U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(10067099003)(261028144727099003)(11063799006)(5023799004)(56012099006)(261102123227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D4fWi5wV4F0bKDlmrHTna1jt6gmWASLau2Voe3Dfst1LZiuttP5zYz7oBf5n?=
 =?us-ascii?Q?3512MPfN6LufS4AcAduxaFi/xkgvFAslO3aCh1iONohmgnPw/EmIEzTkDW0j?=
 =?us-ascii?Q?96Hr0dMwj4sdKmyhahBfFfiFpIT9y9J+eCwc4UK9QCEpaoNtCBxVXemoIasf?=
 =?us-ascii?Q?LKO7CWVqB21tPEIX6p4N0ssBhr6mmfQht54Kx6O+PwxzPsJLYrdXlLsxp1B4?=
 =?us-ascii?Q?qThoaez13Teg17wLbQQ9dRQHfRGoAULkDl4yGs05Bd9NR80OLVhOMURqfSJu?=
 =?us-ascii?Q?GYyPfMt9cdEmZaBW5mu+4+ivlQbhQmT2pPzmkZFxHTw8WqV9tVqTI5/A3vLf?=
 =?us-ascii?Q?tDTSZWad/AeMFQZ5TzvVYnClp4sCR6RhjA23TR7K0K1bJwPjuXstdQYoGX1r?=
 =?us-ascii?Q?mGJd6qZ+i8GalulC1P8tSxTQPZYrIWUL0MtikYrojH2jlhWiqxjkGkM5wf5a?=
 =?us-ascii?Q?7gq37RvPUtyOQpIWus2D5Pttcz1qI0fgdcxtR1e5Tn34CxVOVBlXQ6VO+t3Y?=
 =?us-ascii?Q?jjfE7DUlvDQCi56ZJJyKXozfE9r8eybbAjBvc6iXXfOxZW/PV8xUPc5Sibbj?=
 =?us-ascii?Q?+Sj8PYJC8fCyOvi86pUOJEn+qcnzIJxAWtgpDPD1RDgrTueADBK6gsHBYzUs?=
 =?us-ascii?Q?pvgCS8QpHOI1oQ0SWfumr6X6n57kMmEeXoOB0ob2MvT8tsO9UZFM10+WMOiK?=
 =?us-ascii?Q?A8Kuu5nQ40ggqzIOr8WSd8jjRjNoEhjywdFG4dNXKUIeiqrQGmHupl+LOypC?=
 =?us-ascii?Q?7BkH1PfUGvUHTLhW6hGoJvS47wbsjjgFcE0oYvTfBG70OD0dS272fq71rSnu?=
 =?us-ascii?Q?NPicmwHX0YaNe/NIyEE7E+Torvs5oCzk38a4/OPIq5W4jXGp/Kr76AQIXCEw?=
 =?us-ascii?Q?3mOUhx1LmgBwlTPnhjh6KFkEBgZU7VGsSoB/pdPAndCz6FMBa86YfipGCLUu?=
 =?us-ascii?Q?jstoaPwAV73E4q9fODQWx7HH8U7gdDZ8B9Ou178vKypPe6Hb0isTKOn9Poto?=
 =?us-ascii?Q?ZX0vqniKvTp+w5c5YExjZmHHTg5nJmQ4/KwYpLwRDwkkYm7saOR4+SIowWlP?=
 =?us-ascii?Q?GkGE87rM+jFJgM9wwYQLsFnP/QHr51pePY25qX4woAPdXVYFYG/0TuBppd8J?=
 =?us-ascii?Q?u3AkOSQicnxTAaNLjbBhqrFgrP3mKeyWKfb6aYJOYaYmaYh36XM79hDa00I5?=
 =?us-ascii?Q?+MeTDZo3GbCBMJc3coOT8Nyf0Kl63xRCJxggGIe2ANucP4/CrEZqKdt/Y+t2?=
 =?us-ascii?Q?dQjdDoRp5jANlnbseToQrnElNIqz1p/nUpBU/rDFDmTPfvtMWJmXAiaws0Zk?=
 =?us-ascii?Q?nnMsP4AeNyZ914gvxjJv1o84l9I42+6ls/5niX7DP3rRNP01o/fxC+OOQWVX?=
 =?us-ascii?Q?uBwZVbdS9VGYYqvje/JHNdU3Od2QQbXAe3uKEtZdT9drR1j/MBXqOpMgD9h0?=
 =?us-ascii?Q?RYpskFhKlCOMrTu9RzPTtGgcWKoFRg1+5cYW9rRTz245d1vBb7jxew10JY4x?=
 =?us-ascii?Q?WgAbekJ5kxY+vUv9gbf+MAnMMaBwJ0vPoLPDhfw1mNU+Ng5FpwlPDkOQeEcW?=
 =?us-ascii?Q?w+wjbWAeaGengGb1qSSasUfhd3oYmkS4XaNJOlodO2pfbgiHyUTHS8A8K18w?=
 =?us-ascii?Q?FD/cfxcJ+kxFZ6Uj28cOAZthfZi3W9TvShTIc283093qy6NRgaNeAscLhUFp?=
 =?us-ascii?Q?OadOz9Iu6Qr3eUe0fC768swPscjpBVrrnrRCbrlSI8kbQlyM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d7bf88-91d0-43b7-fbf5-08df3ef730f1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 06:52:31.2294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsjaDow0lt1Ywgjq97kPwKCO0KzvHklC5HryyPK6AGN6+2yGg5ydnaGyvN8Zey450BmK92jonXsWKMltSdBMPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9737

Generic slab allocations can reuse partial slabs from another NUMA node,
even when a pipe workload is bound to one node. Pipe metadata is shared
between senders and receivers and accessed throughout the pipe lifetime.
Reusing remote metadata can therefore make an IPC workload pay remote
access and coherence costs on every exchange.

The target use case is a workload that binds its workers and memory to
one NUMA node with numactl. The policy node is then a useful placement
hint for shared pipe metadata.

Allocate pipe_inode_info and its descriptor array on the node selected
by the caller's memory policy. Apply the same preference when replacing
slab-sized descriptor arrays during ring resizing. An explicit node lets
SLUB try local allocations before reusing remote partial slabs.

For descriptor arrays larger than KMALLOC_MAX_CACHE_SIZE, pass
NUMA_NO_NODE to keep the policy-aware page allocation path. An explicit
node would otherwise lose the MPOL_BIND nodemask on fallback. Select the
policy node only for slab-sized arrays, avoiding an extra advance of an
interleave policy for large allocations.

Moving a pipe's users to another node doesn't migrate its existing
metadata, so migration can still result in remote accesses regardless of
this change. Generic allocations may reuse remote partial slabs, making
initial placement dependent on allocator state. In contrast, preferring
the policy node leverages the workload's placement hint to improve
locality when users remain on the intended node.

Testing has been performed on a dual-socket NVIDIA Vera system, covering
hackbench, pipe transfers, pipe creation and resizing, pipe_bench, and
targeted stress tests.

The primary hackbench reproducer is:

  $ numactl --physcpubind=0-87 --membind=0 \
      hackbench -P -p -g 10 -f 20 -s 100 -l 100000

Results (over 10 measured runs per case):

              avg       stdev
   before     9.811s    0.130s
   after      5.770s    0.058s

Before this change, allocations could reuse remote pipe metadata. With
this change, both pipe objects and descriptor arrays are allocated on
the requested node, improving locality and reducing hackbench runtime by
approximately 41%.

Reported-by: Quan Liu <qualiu@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 fs/pipe.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 4fa69192e6fba..2a8f9e9f70f84 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -24,6 +24,7 @@
 #include <linux/syscalls.h>
 #include <linux/fcntl.h>
 #include <linux/memcontrol.h>
+#include <linux/mempolicy.h>
 #include <linux/watch_queue.h>
 #include <linux/sysctl.h>
 #include <linux/sort.h>
@@ -874,6 +875,16 @@ bool pipe_is_unprivileged_user(void)
 	return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
 }
 
+/* Prefer the policy node over remote partial slabs, retaining fallback. */
+static int pipe_slab_node(void)
+{
+#ifdef CONFIG_NUMA
+	return mempolicy_slab_node();
+#else
+	return NUMA_NO_NODE;
+#endif
+}
+
 struct pipe_inode_info *alloc_pipe_info(void)
 {
 	struct pipe_inode_info *pipe;
@@ -881,8 +892,9 @@ struct pipe_inode_info *alloc_pipe_info(void)
 	struct user_struct *user = get_current_user();
 	unsigned long user_bufs;
 	unsigned int max_size = READ_ONCE(pipe_max_size);
+	int node = pipe_slab_node();
 
-	pipe = kzalloc_obj(struct pipe_inode_info, GFP_KERNEL_ACCOUNT);
+	pipe = kzalloc_node(sizeof(*pipe), GFP_KERNEL_ACCOUNT, node);
 	if (pipe == NULL)
 		goto out_free_uid;
 
@@ -899,8 +911,8 @@ struct pipe_inode_info *alloc_pipe_info(void)
 	if (too_many_pipe_buffers_hard(user_bufs) && pipe_is_unprivileged_user())
 		goto out_revert_acct;
 
-	pipe->bufs = kzalloc_objs(struct pipe_buffer, pipe_bufs,
-				  GFP_KERNEL_ACCOUNT);
+	pipe->bufs = kcalloc_node(pipe_bufs, sizeof(*pipe->bufs),
+				  GFP_KERNEL_ACCOUNT, node);
 
 	if (pipe->bufs) {
 		init_waitqueue_head(&pipe->rd_wait);
@@ -1375,12 +1387,18 @@ int pipe_resize_ring(struct pipe_inode_info *pipe, unsigned int nr_slots)
 {
 	struct pipe_buffer *bufs;
 	unsigned int head, tail, mask, n;
+	int node = NUMA_NO_NODE;
 
 	/* nr_slots larger than limits of pipe->{head,tail} */
 	if (unlikely(nr_slots > (pipe_index_t)-1u))
 		return -EINVAL;
 
-	bufs = kzalloc_objs(*bufs, nr_slots, GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
+	/* Keep the policy nodemask for allocations that bypass slab caches. */
+	if (nr_slots <= KMALLOC_MAX_CACHE_SIZE / sizeof(*bufs))
+		node = pipe_slab_node();
+
+	bufs = kcalloc_node(nr_slots, sizeof(*bufs),
+			    GFP_KERNEL_ACCOUNT | __GFP_NOWARN, node);
 	if (unlikely(!bufs))
 		return -ENOMEM;
 
-- 
2.56.0

