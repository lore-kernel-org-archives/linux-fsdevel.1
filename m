Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504C73A380C;
	Tue, 28 Apr 2026 23:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419034; cv=fail; b=PnjFoSDXXROHNowbKLXBVm+eZgKyxf9SnYIk4aXQPDY+jA3lVdwlaR/QqVDNH9aErN/n6DzjLBgRyv70PJy4MU3xUd5BhmwRTLSvCZh3nNsQaVKBlxLwPlflwHKEhg7y4WQKDos5eXgM4nicwMdVch2vQxojXTMPn/GZwrJm/mU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419034; c=relaxed/simple;
	bh=U+9vyh3XDhfVkMcUI6HkBu0P6JZQqId2P6VsOdQi8sg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ergOtWAZhu/JPkJxCKHhLW3kdCeYQUJkKYKdeTPW7grD8b8ZPCBo9F00T9RJ0cDBUb5Nl6DX7UTWUhMPHF7syCffrHRuQZp1xqsX4ekGuXX8Isb+3fQiUZULXKIp9dq8Tukd+sRYAhrzmDb3CijsF5yY3gvXJtIMxwSvdcRST2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HHlBjSoE; arc=fail smtp.client-ip=40.93.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HHlBjSoE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qm5l1gsDWPGNV/PnAyT4J+plzQ4UhyI3WGBC9s8l+23n0bV04Sh3skDdT1aVCyaiDhSpoh9IH4cYEmOp+46p6ACoYckuIzZD5FB8Vf0V76WKUcwJdR/3VMmDsU74Edi599PNUByOpkn8r6hyk+/xgwoC7qfwjZysmUgQnpdQeZbH0uVCQ8zL97aMuWbKSZ9DjQy1IMJEEUkDzVl5h6hepAdq/B8Tzxi71seNHUEXVmBimtPoyFV0BIgbyas92htIDAby7/zEWS+Wzm02JRjvp1L3DLDw4QojqftnhP0DtruSAsaaIWmOEQjpe3lgTtB1eyGlBUgFXKRvdaVRpRB6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeIIEPYbWw9ezeEDuLG972M0ysO51rSAC50QxgsRKbM=;
 b=b0qQ+4E/g4QlqhUs4gJwMxFUF4abOW9Fp7wgYZP3vtxUfbO71e6HPm2rrVUOVFQcA65ro73nkzgQwdCiLq5o3mnnhivAYtmOmnPIK4GP6rhWAV/xTZABlGqPtHjhjEy/fqy0Gi1GAt9y/wGP+DR3kg+V/Z6/aARbmTohgKnoZKYLpbW+ccsK9U4Gh1NW/m2mlFc8hS8PEm+mrZXmupactea4GwQYp41IgVl4d8EBq8DLqBbVWrPRz0KAwdbfGoPQh8o+94653huRbbCExftdbbOhoK4TIgdzUpMX7cHAkKSh7zhN5FRThbjFbuhImXAM/Phy8O0P3XZZKdQc1Z+T1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeIIEPYbWw9ezeEDuLG972M0ysO51rSAC50QxgsRKbM=;
 b=HHlBjSoE+WyDCi2/1HaPJvy8RIed0shUnQtdRTaMHQ5duk6SKgORZGxAZ+ldluDJKW56jS3i2kh/sdFAIUSeXwAoFTL17NFmy2aaSPh00L+TXpy6QesHYCgQTvIXfkmL0qMotHjXk81Qm7v8FhSWgRYFUii1WPQ4Ppt/IvqH3X/8bPEXfhtyyri7iDboLXqXD2SqAZH7QqofrpJMZtWcgT4fC2UA3s0/5n2P1jXleF5BdQUbN1AA7YCyDqpawYsqdvN6gwUhf8wu5sKuBp9UOa2jt4t9LPr3AXaaR9wjHj4B1Cmglvxqvqe+7UpxLI4f0biAqAYLIgZkELI0HNjWMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB8442.namprd12.prod.outlook.com (2603:10b6:8:125::12)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 23:30:29 +0000
Received: from DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591]) by DS0PR12MB8442.namprd12.prod.outlook.com
 ([fe80::c4df:b439:571:4591%6]) with mapi id 15.20.9870.013; Tue, 28 Apr 2026
 23:30:29 +0000
From: "Matthew R. Ochs" <mochs@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] fuse: back uncached readdir buffers with pages
Date: Tue, 28 Apr 2026 16:29:38 -0700
Message-ID: <20260428233028.2747981-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.50.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0179.namprd05.prod.outlook.com
 (2603:10b6:a03:339::34) To DS0PR12MB8442.namprd12.prod.outlook.com
 (2603:10b6:8:125::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8442:EE_|CH2PR12MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: a743be60-0df3-487c-bbfa-08dea57e2237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3I5Yk3VsY9XlJLnMLkQ9LWdCjla5isDW7xzozk+Oay2+JYI27qwKiLsSX2tZRCaoRzAS5PvHAQu581rkGTFg914/XU0dLNw7H4oc91zqlnzhUZ6ndekYCBuGgJ8BaUCfdbtKq4Z+BhfkP8UoIQQqhXEu857fKv+q3kJEdvqK18FPB87ntxS2z9CI9HeTxUOKvRhnGy6vz0lWx0cmZ9zG+r/cXTXK67pD/4nlRYDFQcjDc2e45J4dECK+DWvTknhCH+/6FemzedOEu9+Ccxdm7cDfVsLACzowhJoOYLBJWl04MAn7sfcm49xV0jjSuZKLxW9guNkQSsiWGhaP32XgsQop+95kSPYDLkyIIZjs3WS++N5W8GkTH7s8Hq8rqWuIjjZUFEQKTER53PrEs5gpDYnxjy2LYRAAVXdHw6KaB6dAS+sRBy+NEE/AtfaofP7JsG0wSE55/ua4rfGgWuOour3NrOAT3oyMwHWpIOvgN0V0tuUH4lXfGiOxclJ6CJT+lyAIiqmZUTt3Nj16FL1U1fG20BlPM22+0toi8qi3MqTU1jgrmeUsdTPwEeYhjUgtoeBhij7h4xA6pGOEmw5J0n+jMKLQEysn0QxuAH1CejPNlhpxPf6xxcJIJ3UT33o4POzUatg7KOiL2LKbiC/ajvGwgMaLsp1MwPsWuGIg9RV7RWD8soBGPp+vp3Mxr0e/y1hHyPJU0as7FAwhb4uzWhc+VUT3yNIi3XiX1W4TZyfm7lpidm2Jlbhoe2VW+1HA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB8442.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N3tReMZ0vxwZtEBPyMy6Ho1fOVZ5nz27CiPKJXERnMlzqkDuhxvvM+e7tq1D?=
 =?us-ascii?Q?3AvbZGwh+iZz0FKWshA19PiXnbtbgCd1D3g7G7KgKOAm8uWcN4QL3uzj5P2f?=
 =?us-ascii?Q?TgHKZjDjXViNkIP6pRhbyQotuMsP2I+9E9mJDuRcKG32DRTMq4hdnlmQWcar?=
 =?us-ascii?Q?oY7unhjLd5fnPMFJmF1p5gyHLlxfvT/459ukkFLinzXK/3C+greNd2wyBJXT?=
 =?us-ascii?Q?B8oHv+BZjA1zvOOpgNPK6lCKRytUUAr4UClCpYhR1xcpbaUFftGm29Qty5Wu?=
 =?us-ascii?Q?kOOBHD+li6FYAE19Cu/aTQOr+s9ecuCbJrMjB6qRpDG4WV2x7Drq5USXYnjy?=
 =?us-ascii?Q?HUzbNPqtlAQIwZEfwytDwXl58WU3lGTLX0FL0tGZfBoPE/9VIQNGnMPb4ijI?=
 =?us-ascii?Q?UjQd7QIbs07+ta5KkgeUx9U/7KOnyMIrMcs7SFGtfbYkIYS1YDoMAsft0C/X?=
 =?us-ascii?Q?KM4Y+avhDVOnOZyWkZdCy6e/N/fmLDnz6AT7ILy1llW98fpt/hTcD/fuGYiW?=
 =?us-ascii?Q?cGhjbAXZMPe4QrGAGQhWrapilgBUB3I7BPGbBRrMJsuwsYXAYhyqZdIVtZmE?=
 =?us-ascii?Q?uM8PDfkEYQwiGRqwfAPi9NuM+QFSi9e9n6rPZagg9QNqwSHvEOoTgzZ0TJh3?=
 =?us-ascii?Q?O2NvmLlKwjQ9VNod22G6GSb392neOz7J8yn9DduKeKTzzrhmVvE6wzH+qbRb?=
 =?us-ascii?Q?ezIwjM9LcsPVHPZni3OvghSshqEUHhRVrX49LQ9KwKtxDVfvuoQDLL62uRs4?=
 =?us-ascii?Q?bu7sjjpZCdZTIDld+Xfj7YH0Hk83ffy/ohFPMb/oQDbvsIM6AOjER0bH2Rd2?=
 =?us-ascii?Q?WFJU/ZUAI1AG+zSBtEnRRVEGenj40o4MwagiBQImT9ryYQPUvK3WSrd2Z0lg?=
 =?us-ascii?Q?Qwv4FWtYTd+guCHZQfGq0PKq7Ar7tXN/t4pl04S1sVuf7lDf6DwVvW/GqX+t?=
 =?us-ascii?Q?qe9exGTPwksLAfvL/sqsacIpTdaEzhax0VvizKQN7Wfcl0+FCQyZ0BKAt7qM?=
 =?us-ascii?Q?m0SCER883oxZQL9HfPqXMUP4yLdwL533FTPEMVspR+fX/E4ggG7xSBrVjqlU?=
 =?us-ascii?Q?3x40eJUnXwa1jn0WsStnxG6Nr0j9ioJ1/3PveJM2HhWbGQwqXIvErw6qe4+L?=
 =?us-ascii?Q?0L+L9L979G+yQRAJjnO66UE1zkxVifp5XBPokgYtIKJeyML+UDP7fu6rG8W7?=
 =?us-ascii?Q?ZbL1Z8/VMqWifUe+ENdd5vaLhPsJHCaEbxhVsjpIZ49HyVVTybQktexqwEpa?=
 =?us-ascii?Q?kBacA3AjyT8NTQs8eNivaD8R+Aau19NdjOowEGU+ZUVpKQvpGAZpIcrTvvpB?=
 =?us-ascii?Q?8quLtEawFemZecsfHZBjRW/bHCSAUP5tcUoQQQjMWzcLZNKqZitPO8O+hbVp?=
 =?us-ascii?Q?COmwH3fErZt5BvvZ6AznikiQLbSzXVwidWbx0fCedLm+iIWxKAeORK9/xO6s?=
 =?us-ascii?Q?WfUtGT1APLFbyycmuPEskXXe9wutgkca24gsjm8XRGmBboe8Rleaifb4dBWk?=
 =?us-ascii?Q?WiW/C4CGyEJ+LmHV7Sok/K2npyb6HndyqTIDEP7lE2ZT3hn0CTfO5dFSKWc0?=
 =?us-ascii?Q?yDNcW2VhXHpCPLSyTvj6/URYkISa74f1g7STBE6lxHUNxt7Ee8cZ87ecZukh?=
 =?us-ascii?Q?6vlioy6GurVX1UE7F+mG01O/BJ2xejyolnXtxGi6komYipDTIdbZiMMoRCvc?=
 =?us-ascii?Q?JI/98k+8m5XIJHihioRLfSncWwmT/OSWWRqdtOja2p9sr5WJ23w0Gl8k8Rn7?=
 =?us-ascii?Q?bm4/3OGM6g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a743be60-0df3-487c-bbfa-08dea57e2237
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8442.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 23:30:29.4424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2xXW43aWoyl7sidvvqGBAN+XkLHxtRv+tbDdR3HCKkExxXBJ7jQaePGyYIso3A9Jc0M4/Fi/lznKdduLjYQgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328

Commit dabb90391028 ("fuse: increase readdir buffer size") changed
fuse_readdir_uncached() to size its temporary buffer from ctx->count.
That is useful for overlayfs and other in-kernel callers that use
INT_MAX to indicate an unlimited directory read.

The buffer is capped by fc->max_pages converted to bytes with PAGE_SIZE.
However, fc->max_pages is a page-count limit, while fc->max_write is the
negotiated byte-sized payload limit. Using only fc->max_pages can produce
a READDIR request larger than the server is prepared to handle, especially
when the server and client use different page sizes.

The larger buffer is also currently supplied as a kvec output argument.
For virtiofs, kvec arguments are copied through req->argbuf, which is
allocated with kmalloc(..., GFP_ATOMIC). A large readdir buffer can
therefore require a multi-megabyte contiguous atomic allocation and fail
with -ENOMEM.

This was observed with a 64K-page guest on a 4K-page host, using an
overlayfs mount whose lower directory is on virtiofs. Reading a merged
directory through overlayfs failed with:

  ls: reading directory '<path>': Cannot allocate memory

Avoid the oversized request and the large bounce-buffer allocation by
capping the requested byte size by both fc->max_pages and fc->max_write,
then backing the uncached readdir output with pages and setting out_pages.
The virtiofs transport can then pass the pages as scatter-gather entries
instead of copying the output through argbuf.

Map the pages with vm_map_ram() only while parsing the returned dirents,
so the existing parser can continue to operate on a linear kernel mapping.

Fixes: dabb90391028 ("fuse: increase readdir buffer size")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
---
v2:
- Reworked uncached readdir to use output pages and out_pages, per Miklos.
- Cap the requested byte size by both fc->max_pages and fc->max_write.
- Map pages with vm_map_ram() only while parsing returned dirents.
- Verified with --overlay-rwdir across 4K/64K host and guest page sizes.
- Link to v1: https://lore.kernel.org/all/20260428021304.2338592-1-mochs@nvidia.com/

 fs/fuse/readdir.c | 67 ++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index db5ae8ec1030..27162084a683 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -12,6 +12,7 @@
 #include <linux/posix_acl.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
+#include <linux/vmalloc.h>
 
 static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
 {
@@ -343,17 +344,45 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_io_args ia = {};
-	struct fuse_args *args = &ia.ap.args;
+	struct fuse_args_pages *ap = &ia.ap;
+	struct fuse_args *args = &ap->args;
+	struct page **pages;
 	void *buf;
-	size_t bufsize = clamp((unsigned int) ctx->count, PAGE_SIZE, fc->max_pages << PAGE_SHIFT);
+	size_t max_bufsize = min_t(size_t, (size_t)fc->max_pages << PAGE_SHIFT,
+				   fc->max_write);
+	size_t count = ctx->count > 0 ? ctx->count : PAGE_SIZE;
+	size_t bufsize = min_t(size_t, max_t(size_t, count, PAGE_SIZE),
+			       max_bufsize);
+	unsigned int nr_pages = DIV_ROUND_UP(bufsize, PAGE_SIZE);
 	u64 attr_version = 0, evict_ctr = 0;
 	bool locked;
+	unsigned int nr_alloc = 0;
+	unsigned int i;
 
-	buf = kvmalloc(bufsize, GFP_KERNEL);
-	if (!buf)
+	pages = kvcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
 		return -ENOMEM;
 
-	args->out_args[0].value = buf;
+	while (nr_alloc < nr_pages) {
+		unsigned int last = nr_alloc;
+
+		nr_alloc = alloc_pages_bulk(GFP_KERNEL, nr_pages, pages);
+		if (nr_alloc == last)
+			goto nomem;
+	}
+
+	ap->folios = fuse_folios_alloc(nr_pages, GFP_KERNEL, &ap->descs);
+	if (!ap->folios)
+		goto nomem;
+
+	for (i = 0; i < nr_pages; i++) {
+		ap->folios[i] = page_folio(pages[i]);
+		ap->descs[i].length = min_t(size_t,
+					    bufsize - (size_t)i * PAGE_SIZE,
+					    PAGE_SIZE);
+	}
+	ap->num_folios = nr_pages;
+	args->out_pages = true;
 
 	plus = fuse_use_readdirplus(inode, ctx);
 	if (plus) {
@@ -372,17 +401,35 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 
 			if (ff->open_flags & FOPEN_CACHE_DIR)
 				fuse_readdir_cache_end(file, ctx->pos);
-		} else if (plus) {
-			res = parse_dirplusfile(buf, res, file, ctx, attr_version,
-						evict_ctr);
 		} else {
-			res = parse_dirfile(buf, res, file, ctx);
+			buf = vm_map_ram(pages, nr_pages, -1);
+			if (!buf) {
+				res = -ENOMEM;
+			} else {
+				if (plus)
+					res = parse_dirplusfile(buf, res, file, ctx,
+								attr_version,
+								evict_ctr);
+				else
+					res = parse_dirfile(buf, res, file, ctx);
+
+				vm_unmap_ram(buf, nr_pages);
+			}
 		}
 	}
 
-	kvfree(buf);
 	fuse_invalidate_atime(inode);
+
+out:
+	kfree(ap->folios);
+	for (i = 0; i < nr_alloc; i++)
+		__free_page(pages[i]);
+	kvfree(pages);
 	return res;
+
+nomem:
+	res = -ENOMEM;
+	goto out;
 }
 
 enum fuse_parse_result {
-- 
2.50.1

