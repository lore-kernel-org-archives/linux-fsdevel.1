Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012031.outbound.protection.outlook.com [40.107.200.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E9530C14F;
	Tue, 26 May 2026 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808829; cv=fail; b=oV39sny1kZM1ALx98jt7J2I1XoVm2wUePno5D49fBbV8ESOkxv6b/bSM+AClIdEYcrnMINSYOmMa28OhXr+Kr+ldDgEeZtCk/i1mMtus0fL1T/6EvrICiqvVzDz2FJ7p7Z5QlXrAo1+U3wNPcWDCL5JLCyOf5d99qKKYdwyTvR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808829; c=relaxed/simple;
	bh=529ZFgr07RA3sA9OcbUzc/tp0DRezLMCXu3wkWGnnLs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KWjFRJjzt0A0ioEwyfl1LyaOhwgesSdYc2AHFShzlV54y+ye0+w5o2vaXYV3U6KyDZfuvK5Yclj3bkHnTXvzJRo/7mEe6U5REg2X7dODElEgf9h6n+OqLpXFoBr6p6ptklR8QMJSto0kYeUXVPTQWJxMa03MVbVnl/hzrLvA+N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=faFvK/LS; arc=fail smtp.client-ip=40.107.200.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="faFvK/LS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVvnHyOwIT86YUORbJgYE877xvzLOHsjzZbN0td6moySTJUyW/VXY3kXxfCfloVd4n84g9tinV/apMg+L8dZvhujaD7QldSeYnepPXaIq8ZOGmJp8aKkC2GbdIve0vAXUk99bugOVJsjSzSImB2SI2bK3bjz1BsppbyLtJMMYv674Oq4NeKaWor3CeU08BCTbDA0x9kB5MjVGyCIB5H9apsozle3kTCdxwm5OBjiPy/KSTDVfOiww/1RuRpShS4M6AhlW6u5Ugww4ldVl4MZRW+B4Pf2LfTacJAu/fyDz8T5MtJbsKQmHpMVnfdSouJBXSv5A+wcFGC85dVGDbyoyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PKWbowDlgXr7FnYNo6XM1ddWeNs1O/BvNUCKS/NRV64=;
 b=iSx9+/lau4HRFAL0eJ6fNGJwDqz4HMTCUXFDn3MUdVA9yBRhExCTsORya/7Lt8ph8ILIeMSYK3bdoVyw7oLPnAKE3N+GI43hL675wEXlWYq77KiyH0pWizX+15IdRPmGlWtdVL+L5WUpeyVhd72lYxTy+2/ilD/sHiYprlLUon8OROjjAb3j+6ZIWagyWYUQpMkvMEdhoyl45ht19o9dI92RZFmBhVyqf4kk31QiUQPNwLTnaZAABwRrPZ3pmGoQ+QWeByb5ESj4Q70GOPC84K68iLKCHZ33F3MFoj7mnnmTvY2vZcuccH6050vaiKiPStexIQreJ5Kjk9kumfUNIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKWbowDlgXr7FnYNo6XM1ddWeNs1O/BvNUCKS/NRV64=;
 b=faFvK/LSO9I6bCj5gnfBSa0zmUGAoI4ZMJi427V8Q8B+yW3DGuyFwEgQv1+xUFc5MhSnvrLSksj006Mud3snz0azZfVFowjHUu1y3kKPPK0Io0WZGYAK6lkyE6ZWuRcc2B7wN7FC8BiRcRsf8Xvmu2+qy2aeRwf/m4ZScrB6o3/pmskdsGTayES4nPFPfTHoYYfs8v4qfHq8UVzZ2RABVpdaoLdwkwr1kM0h/aVDZ7fDg3ltLf12RO8Co6Bn6FFLo2Ev15cKk8sPEWz6Gy59CPXEQZUJ2jJWbc3eylihz0RepZ1Wdsw14wLqsJX+AzwgLMF3rCklXxo8mG5M80nALA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB8438.namprd12.prod.outlook.com (2603:10b6:806:2f6::21)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 15:20:22 +0000
Received: from SA3PR12MB8438.namprd12.prod.outlook.com
 ([fe80::2cf3:76da:d2cd:4453]) by SA3PR12MB8438.namprd12.prod.outlook.com
 ([fe80::2cf3:76da:d2cd:4453%3]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 15:20:22 +0000
From: "Matthew R. Ochs" <mochs@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bschubert@ddn.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] fuse: back uncached readdir buffers with pages
Date: Tue, 26 May 2026 08:20:21 -0700
Message-ID: <20260526152021.891412-1-mochs@nvidia.com>
X-Mailer: git-send-email 2.50.1
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0161.namprd03.prod.outlook.com
 (2603:10b6:a03:338::16) To SA3PR12MB8438.namprd12.prod.outlook.com
 (2603:10b6:806:2f6::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB8438:EE_|CH3PR12MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: 1939f023-046b-4428-fd9f-08debb3a4dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	tc1Ht6PXMNmNnrjtK9Hkq8OeRJ9tatgqmakCf2gLo9mZW1DyGJxcZIbgyzdxY9l6o6lw1HRjw4O4ofiP36ORLkwTA9M8ZVSsAUWRSqgMFtWynI/T8xU40LCIXAVBibb0NgacsYdvq8fSwJcWiJJgAe9ptOJQMaZ9voDoSvh9/I0HbUu8OnVmWVzcydpbfK2O2d/UELErDqjjnKE+1HZe2iVK/kN+eUK5dxgkqMkEERlnS9hh9sXN1/ypiuBwaQTKwykKUIcc3dYECnUsNUYVSd6zjSVJGg7Cw75NHlxwZ1P9K9z8Q4lx9p/NDJTQ9dwuEZDDVghBHcvhWo5PduMz5lRDHQ+hWeJhvPWyI9C9117VzchX42iSGhfcTZZoM0yyVOdfCHKxrqUqc5OvzAD/e+xKI+nW2pct4aNN/QdRuplpcrtUDidbLqh27DvP9BWnvm4RH7kDU2LNW8BZhz4aESU31UtNfEnCPzjvfa6wxJbKPvvNbB16w+qBgvV4AP2656YsdIA02qI0vwTcd7N4jufFZ+zMCnDRAartMLbX0hdlHIwDQcxNNKdwWIb0O1tLRwOhHHVVZBk2Mmqw4xc1hRQaStYI4AK6DTJ6AEko/kj3urLpDj5Rk+iRqg/2ROJstNw8/sANw6la4KDDDTb9u0Ncx2XvLUyvicyVoEDaHGbAch7Ij4nVztglXCCKoofYSg6rBNrHphVrAq4omwIzkA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB8438.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2/a1A6yGzZbrfv4+uu7ZrRNmHwR39IvNdrH1ELLSj3F2vyawqoJsb1zhfysx?=
 =?us-ascii?Q?5IJG7Jm8i3LfP7XiqtCfCVVYakYlvdz8fNN/44zpgBOVOPLG9dAhogSF/uXr?=
 =?us-ascii?Q?Ri7qQRejYZegbl8NEFzSE4Kp2xb3mPDSQgDlB5rSwNlBjnHIaECqxZjiVYhO?=
 =?us-ascii?Q?j5PI1p06Od81rIOuP9aCkjNabYF9mZuy7vVRPvsxdN+IOIYp+ZCb6wWGjb99?=
 =?us-ascii?Q?/UPz/qJEhL71kXzC8WmulsPAt1mrli+DpRlEzE/dUIYNCn+g7mwWxh5HMXjA?=
 =?us-ascii?Q?Om9dFXrNUXfRLLKIKeT3G/6mCxIc6IpiVVu2WxXtKmqOYOR1ZXCNbM/hbYzp?=
 =?us-ascii?Q?0RmW5N7jwI8Rf3RBwbrsR4WJlN8Vy8ClACHTY9gf8ikDCapVp9gyKlQ8ahyy?=
 =?us-ascii?Q?iWBN6UYGu55Om9zP20wa9NdyrbLxtJtMTdtgr/79NxIRGGuceeQfpkSyE8Je?=
 =?us-ascii?Q?dgjGDGMIxg/Frvjm6VTu5skNFZ+vEY/epUoOMOrXTtIxnM3v/jUYwxVuPHJV?=
 =?us-ascii?Q?j+/5AaNc1L2+WvzdZ75bCI7cNzZT4CtVmRktuLFCbPDFB07f1xxfSBZZbXic?=
 =?us-ascii?Q?+pVlZgwl8b9qyU8lP/RacnzsgxEsPK7sD4WW6an4USoQM3uVHuGIsbcbelMZ?=
 =?us-ascii?Q?/J5iFsxI4KyRY/LCKqYnMxWBRtXP758XDuFUBgTeX8yidP8TIGZmW97bKWYx?=
 =?us-ascii?Q?fRQeyPePWCueF0MYhHtvVK091duv9g5yd+smPFdAI352VnWuT+6n0wpkCjFA?=
 =?us-ascii?Q?7hQi8MZCPw1AhWD2LKFKOdbT8NLgUA6fasEbVzs+5QDVouryjubIcJY0rkKr?=
 =?us-ascii?Q?0+wPU9li5lGQkTBE9OROUFS/K6/1tVBQJYg8W6OYOT2Zh5uASEPvwAZYo9oZ?=
 =?us-ascii?Q?f9shDhWPZHEr8UdNjE0UcMmXusifnOsz7s40ZLF2RpfzRbT1837oZmREAn1O?=
 =?us-ascii?Q?I9CziPigH/kZZ2mSicB2m6XOR38buVSsafeErdPUCewxdbp31546bgvligqE?=
 =?us-ascii?Q?uamSqZB37CQ3go9yVIL6pjGUJpaGXa7vwr4b1r66L39387mNCa0lSA9zaE4T?=
 =?us-ascii?Q?rPmLCv13GSvg4lv9VJEZm6y73CVa5g/bLHd/GA8lyUHp6QTNfoq1Tw0Ldu9j?=
 =?us-ascii?Q?E742QxhjdFFppBq/bbCbaSVmR71GMKFq+F3AOym8Bfy8d6mE6p415S7VDCg5?=
 =?us-ascii?Q?pLxv60cPk96b/EkS8ZjGyquB6t8iKv85CA4zsuNkfenec7kYWZO3L81e7hGG?=
 =?us-ascii?Q?LTVy7+nPL7186nlLqVbsQqmK1YPG4KAmUbM2oVzIk+y64PMh18X4NwaHD1Do?=
 =?us-ascii?Q?+f1Fwx+AicEo6O66cE1KGVq9V2/DC+0ghMQvoCY2wGVHwAHk5NHipk+KKiAV?=
 =?us-ascii?Q?1I6Y+HaHSz808cSKSgnO4zZoAZC3Z3e7Wt4+4NTD0O0Ay1PbkplqqACKWiu4?=
 =?us-ascii?Q?CljOQ9q6+a9vsYoAyt1hSpe8+/xCuso/2FErPUizF54W2ELLob51dUb6tW+6?=
 =?us-ascii?Q?q9wFCCb9UWHBIkGtjqD4Bomuxdrvv/Xr+HusvK6+ki+EjzfNVdrzfyU6xsEr?=
 =?us-ascii?Q?tWuZAEerKkr5KxNWSUPcLfuIgp7PSPAiO9WLvvV9b5GO8BEhnbTZIue0brKk?=
 =?us-ascii?Q?hM47p1cbX3kFcilQOHNSNH4yweZ4RdrG3MOUOIgVqnIIKpMJflMKv9VMmQpk?=
 =?us-ascii?Q?HZKk8simt4aVgrFJfRi/L+fSPGgHLScEsYrwzQCACSmeiUK9OYWL+X/XfVlC?=
 =?us-ascii?Q?hkKoC2gbrQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1939f023-046b-4428-fd9f-08debb3a4dea
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB8438.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 15:20:22.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZN0TtISbdzcmSrO3vr6un9OfogMdlUW7Zgy0PlOdPKMJrX/1oGo7vqiymCVsNpMzPwp4kzWlAyElVGm7sSAADg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429

Commit dabb90391028 ("fuse: increase readdir buffer size") changed
fuse_readdir_uncached() to size its temporary buffer from ctx->count.
This is useful for overlayfs and other in-kernel callers that use
INT_MAX to indicate an unlimited directory read.

The larger buffer is currently supplied as a kvec output argument. For
virtiofs, kvec arguments are copied through req->argbuf, which is
allocated with kmalloc(..., GFP_ATOMIC). A large uncached readdir buffer
can therefore require a multi-megabyte contiguous atomic allocation
before the request is queued.

Avoid the large bounce-buffer allocation by backing uncached readdir
output with pages and setting out_pages. Transports such as virtiofs can
then pass the pages as scatter-gather entries instead of copying the
output through argbuf.

Map the pages with vm_map_ram() only while parsing the returned dirents.
The existing parser can then continue to use a linear kernel mapping.

Fixes: dabb90391028 ("fuse: increase readdir buffer size")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>
---
v4:
- Drop the fc->max_read/fc->max_write request-size cap.
- Keep the existing uncached readdir buffer sizing logic unchanged.
- Limit this patch to backing uncached readdir output with pages.
- Update the commit message to describe only the kernel-side argbuf fix.
- The remaining 4K-host/64K-guest ENOMEM was traced to virtiofsd rejecting
  READDIR sizes larger than its MAX_BUFFER_SIZE; a virtiofsd fix is being
  handled separately.
- Link to v3: https://lore.kernel.org/all/20260519004746.3203156-1-mochs@nvidia.com/

v3:
- Cap the requested byte size by fc->max_read in addition to fc->max_pages
  and fc->max_write.
- Use clamp_t(size_t, ...) for the readdir buffer size calculation.
- Use __free(kvfree) for the temporary page pointer array.
- Use release_pages() for pages allocated by alloc_pages_bulk().
- Handle partial alloc_pages_bulk() success by shrinking the request size.
- Verified with --overlay-rwdir across 4K/64K host and guest page sizes.
- Link to v2: https://lore.kernel.org/all/20260428233028.2747981-1-mochs@nvidia.com/

v2:
- Reworked uncached readdir to use output pages and out_pages, per Miklos.
- Cap the requested byte size by both fc->max_pages and fc->max_write.
- Map pages with vm_map_ram() only while parsing returned dirents.
- Verified with --overlay-rwdir across 4K/64K host and guest page sizes.
- Link to v1: https://lore.kernel.org/all/20260428021304.2338592-1-mochs@nvidia.com/

 fs/fuse/readdir.c | 59 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index db5ae8ec1030..48b5e7682e47 100644
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
+	struct page **pages __free(kvfree) = NULL;
 	void *buf;
 	size_t bufsize = clamp((unsigned int) ctx->count, PAGE_SIZE, fc->max_pages << PAGE_SHIFT);
+	unsigned int nr_pages = DIV_ROUND_UP(bufsize, PAGE_SIZE);
 	u64 attr_version = 0, evict_ctr = 0;
 	bool locked;
+	unsigned int nr_alloc;
+	unsigned int i;
 
-	buf = kvmalloc(bufsize, GFP_KERNEL);
-	if (!buf)
+	pages = kvcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
 		return -ENOMEM;
 
-	args->out_args[0].value = buf;
+	nr_alloc = alloc_pages_bulk(GFP_KERNEL, nr_pages, pages);
+	if (!nr_alloc) {
+		res = -ENOMEM;
+		goto out;
+	}
+	if (nr_alloc < nr_pages) {
+		nr_pages = nr_alloc;
+		bufsize = (size_t)nr_pages << PAGE_SHIFT;
+	}
+
+	ap->folios = fuse_folios_alloc(nr_pages, GFP_KERNEL, &ap->descs);
+	if (!ap->folios) {
+		res = -ENOMEM;
+		goto out;
+	}
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
@@ -372,16 +401,28 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 
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
+	release_pages(pages, nr_alloc);
 	return res;
 }
 
-- 
2.50.1

