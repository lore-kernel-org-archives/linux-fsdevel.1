Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8B39769A;
	Tue,  2 Jun 2026 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780434892; cv=fail; b=Sjls24gHQAxWc3zCJRD6Km1Wn8tYFrH4awdMzXn/zoGCpxtK/echms22ABSFsdtM4MY82nDZDXKk9q+zSYfypvfsH9Ip1UsXy1ByEMDq+g5ooPYl34yS2SA1ewDp3rAjCoJSXop71zirRqX7mFNtPoSIhzJiiNb1qar/9nSRc0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780434892; c=relaxed/simple;
	bh=LKLk5gso8F8HuUX3osFvJL/PVnaJ6WGPuhLNce0dwes=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qlSOjUqqWQH7ysLgvcqW3CuRitxLLd4HWdVsrrE7jep+5gl7GbXfLAR2Fv8fggrS1/os1KAs0q0Rv+Js8MTgMCbDNm9WIUT5QYBMKoHf6KXotcmnOtMMkhwiCiiLWTY6TKOErgOWjMjiLj/b/w0s82MG/TTcsBqnbWJTJX5y/00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qwpwguMF; arc=fail smtp.client-ip=52.101.57.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qwpwguMF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsiHwEmhCqycYSPHF8MvT5JLzW1pmJIbOe2Pd97tRWJfMnS3/4iCPJhJLbYyInnfzDANCYprv6sRAMT7SFJcZ6gh+TLLI1kH4PY1HBdiHnTcH9SbKfgsRlY4EOwJDuqlYtW71rrrOBwqv3klAzv+uvoY83Yk1OQxIcdkboQALfZmhPBw3nKg6xGzpVPmPMc4fTMaf5I+vXKsz+eA61V2AyKQ6MkEJs9tVGQZduGl1COEuwucN0bWbogsts9goqz1XagW+AMYlRGC0k7KjgQlcpRNxG/W7rC0SUXzogmzmHKCJZMiY//rzQ6qoj63GZPSd5tIyC/mi/wFoJBApPZyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W23rvh8hqRG7wLm4UtOly8lUymhLCB1/imn/Bq2poRU=;
 b=YtbdP37rLrrR8Q2H5veF1anU3Xz6VeEwX8XsVMZletUpZs7LSQ8CNKSARSLxG+crbLL5vwFXSkfUYPH5U8B1AUYY6aBT9Mg92f+hLhnW6AE2o7srk1nIK4pdS0HWvkKxoXxjDv/WrePMMKATZdffNhPzv3dhyyV/3aOmQDUkRGiYp76558QoJ21a8w1Kfma67FKvL6TfxVZo8SOjjDcqzzQFZkAiZg4LlIEYzmBPTNPzi/dtFPCl7WnZ7F7wrh59gE9jBUKL9dZRZWTBc0j/lfSjvEH0q+QSST2IJtMPmnaiNe8A5N1u5Vu+Ec44jyhLuRPkPuNn9LVcGohgiY5uIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=szeredi.hu smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W23rvh8hqRG7wLm4UtOly8lUymhLCB1/imn/Bq2poRU=;
 b=qwpwguMF+hqHj8J710pNVWxkqvkbUXAp2v/b7PWAYbuJBKJijUUOKq4+ncm2Ij6rMU5Xelz7+C1z5WPLH7MjVJvPF8tngpIQvIHUJ9bsHHz4Uv4RyECqbl0rfGXqzg2VrKiBzhYaHM3wUlaxtF5F3KmCzaBl/OmmpXO09+JC94EBjyS5LxYRQF3tDHjx60A7KLhrLHBeeq2U6qQg06blWG1vmet/BD0q1RmsIJz5/iK42Vr1xlfDUcKCwDyVMP+8nEH75dfqa2Eh2Ira1wIAWy3cbsqED47ptlFdvi+qqjdZY09XVuSqxnc+2KibKwcFEwrRxOYSC9XomBaQgYvVpA==
Received: from BY3PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:39a::6)
 by SJ5PPFC41ACEE7B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 2 Jun 2026
 21:14:46 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::4e) by BY3PR03CA0001.outlook.office365.com
 (2603:10b6:a03:39a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Tue, 2
 Jun 2026 21:14:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 21:14:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 14:14:25 -0700
Received: from ubuntu.localdomain (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Jun
 2026 14:14:25 -0700
Received: by ubuntu.localdomain (Postfix, from userid 1000)
	id 143E72606B9; Tue,  2 Jun 2026 13:44:30 -0700 (MST)
From: Jim Harris <jim.harris@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Konrad
 Sztyber" <ksztyber@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Idan
 Zach <izach@nvidia.com>
Subject: [PATCH] fuse: allow server to increase max_readahead via FUSE_INIT reply
Date: Tue, 2 Jun 2026 13:44:30 -0700
Message-ID: <20260602204430.18427-1-jim.harris@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|SJ5PPFC41ACEE7B:EE_
X-MS-Office365-Filtering-Correlation-Id: 81232ccb-c049-47b4-ec21-08dec0ebf8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|3023799007|11063799006|5023799004|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Q3eJO2sW6t4kHd7LGUw7HqMrP2Xgjg0Ofn4LVr4DRPgL+tyDhVmuivK8igtmXQmpPenysHACxJlySJ+drunBE6hjqISbgZRiWrg26JFEpQM+6cblmAJ56pF8KI/KzUTGHqYt4AODpcRkPus32ifCY58MtOrwFo7c/RmYhgimxwl3kIqdmn2TFIOR3sEWk2pqEZstHgVh4cQK6McEuc74PI8BGRJMD1Q/UBK22E06Nd9Alh0v/JIfgMTyBGe3CM3Mt0lCY2qZpWZKwDpRfnUShTP2TyUAnlnhBRttRv+qNRegr8L02Ya+xgxpeNXU8L7vAZ0ZDRLY+Z06ftkPNBzyhbTuchJURi/4OyFoQXVBcvDSU3IdF+lbWd9sCyLgaTRvo9NCIvY7uLo6EdJI6OCSMSDfY9H6Sb35jYTHaswAfep0JKS447env6ekHDLjifgr5aCTuRFNY3Uzrn1yDm4tpeUrorihEHwYI4ax2WIdWQ0o1VFR4eBL+TQshtZ3vFMlvk2pKsMsJv4b1JvVBQ454kYv+ByCWpoYt8w0nlIpzCxpfUFoMJFRNX0zYm2xFXTxaxk9sBxjAh4lWrlEmXHIRJPAg4MF92TN7UwFFS6SFK98vFeiNUJA3VvfuAT+xBYqoWWqVz5+eX+Ndx6Lu2pLGy0oKIga/AtOUiBxayT7oTXn/43AWw0BME1kKjj+vzSUIvAvVx+BgpYYIBQYHwd1RtQfgAoQ/l/8svWQH+keSZo=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(3023799007)(11063799006)(5023799004)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	K8L71XRWA5cXf3Nqp9rOcI1lBGHfkqo2kN81K1ftK+xTkNGNrXxvLQascBTgOBEurR2SLxTjKc2wq0EzuYZNGAEN9EIxQZAo23anqlwaArv6Wnh1UK+KuhKSvK3nnppXaB0aNx3ALb9iAJKbHPp8sRK9tQ2CG40UaZsQ0kzbUvG/VAj1rYJy51v/kh/RICfQEyJgAEC+AypkoVOoP/J+ov7aqtzIx53B56b8PvaNwNN/sS0Uy09rYhMb2eMTOjjJKioyzO5o5sOeOC/zO5QXnJBrPxnw/Ycw9ouc/tZij7GmPfV84GDrv3sIf+yCA1L6vb9AXRfpX3aAjJ/T7WB1Oa17J+e1oiBjffpn62Sd3XIMpMiWu0uhCOGMxdChYeMQRq5OqI3wxd5cyZmHKK8aq8dx4J7bZkIl/qDRCov8Y+KU63wRu2DsHMYghyZZqBgM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 21:14:45.9173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81232ccb-c049-47b4-ec21-08dec0ebf8f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC41ACEE7B

A FUSE server that advertises a large max_pages and max_write (e.g.
max_pages=256, max_write=1MB) cannot currently obtain matching
FUSE_READ request sizes from the kernel.  Buffered sequential writes
arrive at the server at the negotiated max_write size, but buffered
sequential reads remain capped at the kernel's default readahead
window (VM_READAHEAD_PAGES, 128KB; doubled to 256KB for files marked
POSIX_FADV_SEQUENTIAL).  A 1MB application read() therefore turns
into four sequential 256KB FUSE_READ round-trips instead of one.

This is because process_init_reply() processes the server's
max_readahead response as:

	ra_pages = arg->max_readahead / PAGE_SIZE;
	fm->sb->s_bdi->ra_pages = min(fm->sb->s_bdi->ra_pages, ra_pages);

Since the kernel sends its current bdi->ra_pages as
init_in->max_readahead, and bdi->ra_pages is the default
VM_READAHEAD_PAGES at this point, the server can only ever decrease
the readahead window -- never increase it.  Even if the server
replies with max_readahead=1MB, the min() clamps it back to 128KB.

This clamp dates to commit 9cd684551124 ("[PATCH] fuse: fix async
read for legacy filesystems"), which introduced max_readahead at FUSE
protocol 7.6 and used min() to preserve legacy (<7.6) filesystem
behaviour.  Modern filesystems that explicitly advertise a larger
max_readahead are silently overridden.

Other filesystems set ra_pages or io_pages directly from negotiated
server/device capabilities: cifs sets ra_pages from rsize/rasize,
ceph from rasize/rsize mount options, 9p from maxdata, and nfs sets
io_pages from rpages.

Use the server's max_readahead response directly, bounded by
fc->max_pages (which is itself bounded by fc->max_pages_limit and,
for virtio-fs, by the virtqueue descriptor count):

	fm->sb->s_bdi->ra_pages = min_t(unsigned int, ra_pages,
					fc->max_pages);

This is backward compatible:

 - Servers that echo init_in->max_readahead back unchanged see the
   same effective readahead as today.
 - Servers that reply with a smaller value still reduce ra_pages.
 - Servers that do not negotiate FUSE_MAX_PAGES see no change, since
   fc->max_pages defaults to FUSE_DEFAULT_MAX_PAGES_PER_REQ (32),
   matching VM_READAHEAD_PAGES.
 - Only servers that both negotiate FUSE_MAX_PAGES and advertise a
   larger max_readahead see the new behaviour, and in that case
   fc->max_pages already gates per-request data size.

Signed-off-by: Jim Harris <jim.harris@nvidia.com>
Assisted-by: Cursor:claude-opus-4.7
---
Notes on AI assistance:

  The code analysis (tracing the readahead negotiation in
  process_init_reply(), confirming the behaviour of ractl_max_pages()
  in mm/readahead.c, and surveying how other filesystems set
  ra_pages/io_pages) and the bulk of this changelog were drafted with
  an AI coding assistant (see Assisted-by trailer).  The one-line code
  change was reviewed by me.  The motivating performance observation
  (a 1MB application read producing four 256KB FUSE_READ requests
  against a server advertising max_pages=256 and max_write=1MB) was
  observed by me on a real virtio-fs workload prior to any AI
  involvement, and verification of patched and unpatched behaviour
  was performed by me.

 fs/fuse/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index deddfffb037f..272026f11a34 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1494,7 +1494,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 		init_server_timeout(fc, timeout);
 
 		fm->sb->s_bdi->ra_pages =
-				min(fm->sb->s_bdi->ra_pages, ra_pages);
+				min_t(unsigned int, ra_pages, fc->max_pages);
 		fc->minor = arg->minor;
 		fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;
 		fc->max_write = max_t(unsigned, 4096, fc->max_write);
-- 
2.43.0

