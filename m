Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E28D384250;
	Tue, 23 Jun 2026 00:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782175377; cv=fail; b=EVdkpXlbXDLx+1Oz3HsqcRa4Si5v064agl1sSkEsZJiJomfHJkKZS8Fyk69mkKWOGZn5Y+Oo2dF0bPRVFiM2e1GZQewi0sijSRDsErMlsXSJto8fTXoy1PK84/SYceZJwfPd8zNDXyZ2lQ+SoVeHg0BklZkYdiu+yzOlZhAKfPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782175377; c=relaxed/simple;
	bh=ouq83OzHbv4IolDAtfgDHfbiH/xSiVQchpd1UOURbBw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pnOvjt5hpFCOa2EfLym27og3VsIBN0ID0rS7FkP8BVA8c7yO50+JKBIQwMysikQFSvv63u+qcwUIopRM3hY0ka2Qw714RwLjPEzhCPSH1aWUviDlpvDTcERNjh+4axKlS6pOL5OBSc18gCyAe7eChHLT67ArPyv/SeqvDgKyv7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fp6IqehB; arc=fail smtp.client-ip=52.101.53.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fp6IqehB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXhPmvb+jUq/JaRuegyT3auLPc5VfKRfZPQzdIaFa1v8eL73rRWFkQnMHDEL7anRWEkG/Mrue5FyXnASIGef7BW06oC/CzQH5ndgTJ7ZTXZc1L7RkT6KR/z+iBdVKA47MbrIvjl8zln63z6pJddgu10ZmkO6X3tv2ObkkUJ5Y54QW/VJhranR6PMCLSznzBxkCnwpylcj3B3XhpD5ABWoWzASYAw/p1mi5awQk5JXA3oaXqhorNrL23P+a8UrwX3sF/bR1AyeUFGfK5dz11DRhIc4hvvaa0rf2xE0ytsAVyrjZWq56dlEKSPKWhEaoNsjvS2jyqrazQnSgf/Tyiy8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWTDZIRoU5N83BBnig2H7LvAOqlq3N6WoiIZvrsHzMY=;
 b=JUSsYkcauF6ZQvnO3QVnRtomSK+XQm/6SYpXgwFUJaO4sJyDzrc7QGtsIRf8Dlv+zcGm39sG22mcQcLtoqAfrvyf28Xr2GFP81q7mgqWKOfA60Eozhfl6dNDc6xXUAVWUzuw/fVlwQ7I2lvXZj7uzizqyVSMpv7hH5ZfhLkYBolXbe98ojaqv/Xh7dPCBdHqFGWN11RmFDFbpnTMD+QCRIHKQcAr8ezA0i8Dh+fYc09e60WYASZaZawzNU3XoNtaNXQ3QGMomv6smJIrxVEcHdOyap/J6kWatRoG13lHoxCaxh66HuQGVqs7jh6ttcFxiMsvI0ukFzWOSFzbyUlXww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWTDZIRoU5N83BBnig2H7LvAOqlq3N6WoiIZvrsHzMY=;
 b=fp6IqehB4/9ebwCGrpX7H/8dlo8gb3qy9REzYllhVwa9ilH8Uan4et3Q9OpEmn0IHw6yR5AwphR+Elzt44mhqiRC9sSRMGhOSTYxzcGfyL0roPUYM5WpPRfGlT8+zNsNqysMBm/Vk6i35owzLGQIIwMIKSdKEaSk2TqO3C9Vsxe7NIkyhzM+/JUuD5syYpzCI9Dagqsx5CeX5h6KjX3M3Be9CXXk5PzUHGjyMI0Ff0oufZzWfD0hw1e4kmHEPLNULCwYHXrH4/lHQWSbO8N55VLThnBJicocHld3G9JCl5LQZLYpvp/oHwBRK0JpZ59Daf95gEYF7sVyyF54Lmu++g==
Received: from IA4P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::7)
 by PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 00:42:50 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:208:558:cafe::23) by IA4P220CA0006.outlook.office365.com
 (2603:10b6:208:558::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 00:42:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 00:42:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 17:42:35 -0700
Received: from ubuntu.localdomain (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 17:42:34 -0700
Received: by ubuntu.localdomain (Postfix, from userid 1000)
	id EBAC9260359; Mon, 22 Jun 2026 17:42:27 -0700 (MST)
From: Jim Harris <jim.harris@nvidia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Joanne
 Koong" <joannelkoong@gmail.com>, Konrad Sztyber <ksztyber@nvidia.com>, "Max
 Gurtovoy" <mgurtovoy@nvidia.com>, Idan Zach <izach@nvidia.com>
Subject: [PATCH v2] fuse: allow larger read requests by setting bdi->io_pages
Date: Mon, 22 Jun 2026 17:42:27 -0700
Message-ID: <20260623004227.77628-1-jim.harris@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|PH8PR12MB6674:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bb5ab9c-b9fe-457e-2bf0-08ded0c05a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|18002099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	a9zipqqhJDVW2pYkrmW9jwGQ7lEu1jZXkdE446gMQmKm+M8OO3q/EKuk3zVnq+ltHw7ULMWAMI8WpIxxH3W9LxkVwhwrdCdgVzmPSEBXnqMzwlidmaRrHR4hT0HSvIiFIqX+DspAQR0h4Fwd/FiD3evMH8FlaMOlN2j8Rq7f1zxl/VBlqi3YnwiVmNGQt9ZIOd+otQJvEgz5q2XJDQguyEoU9otRXewv95pUK3AxJ90KJXSh2P8BL17wAYNEsZt1N9KvbwQ/mZYBRzPwfxdciyiVHhYdrFhAS8W54p4yTerTeWAIr1reSHbrAwg/+yrad6TbgOpegF6f4Ss6DGBdI8u/ytxvrcLP4u74iR7Du7+Xrcx9w3AzeLFKCzjKCso4FEeLbZttTlQ1dUo7OVIKyuWaM6MfSuab6tEoGMq1qwazRrrGt6X5l56CZ98MAnJcvk6qU2Lh5U+/kC1mYvVh4UAz/w0RH73PbmPqT5jE35S/MGGJrDcJtWFanXVMIPg2uIu9IeEzjb0SypDcRdtJ9AE9yHCKZ7brN9yaEuGPDjaexvJqWcUpsPTODMjkfvlLhjcR8b04Ncm2Qc7HWyWo0Xu7jdyEvI9+N9dPqQtv1M2SZfey74BUXcTCk3Ot0buM1FT8Kp7UZvAgV6dKR0eCyUV0ijONTxM73/ebunFjmbWRtUSdNWAtWfQ2NFG6FJnlTmvh80bALg3lb+3PCHQhGA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(18002099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	08R2/YXEiqTRpWvDWvwNgxMPh9/Xxk15hF+Zar/S1Gwuu2IqOOxh4Y5VtvKufBxbWAB1JhlLK3lAbErRdVxXEaZeSoF2EzNAIezYPHB7C5Z4L4OoYh99QbjJ8mC4Cs4olP+B6TbdTbUfG3X98dLslImVqswQGDFSes4tbEQvjWnE+9nxU3Cf6hb8PGBY1pC9XtTWvpUSF1lTnajUoM1WsjcuPlfLgbg99Z6tUJjjVfwFjd6bHHwtLSy6YfKUo1Vd7ps2NwhqxkjTFI90WZF1FOVroeCXF0UxNkFBDLLkMrnlMT/dKIk8HSGiL5VSiiRBIE/a5/q63xK9z3BqqCaUynjMmoAV+v8fistGk/laauHTkvDBXku9B/5GYTPmQt7DVFAPEe0goiNjtbvLeBTBMeNKrq5v53UhUuh74D2QAL8OVPmy+Po4aejfxD+W510A
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 00:42:49.8325
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bb5ab9c-b9fe-457e-2bf0-08ded0c05a48
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6674

A FUSE server that advertises a large max_pages and max_write (e.g.
max_pages=256, max_write=1MB) cannot currently obtain matching
FUSE_READ request sizes from the kernel.  Buffered sequential writes
arrive at the server at the negotiated max_write size, but a large
buffered read() is split into several smaller FUSE_READ requests.

For a buffered read, filemap_get_pages() -> page_cache_sync_ra() sizes
the read against ractl_max_pages():

	max_pages = ractl->ra->ra_pages;
	if (req_size > max_pages && bdi->io_pages > max_pages)
		max_pages = min(req_size, bdi->io_pages);

fuse leaves bdi->io_pages at the default VM_READAHEAD_PAGES (128KB), so
a 1MB read() (req_size = 256 pages) is clamped to the readahead window
(128KB, or 256KB for POSIX_FADV_SEQUENTIAL), producing four 256KB
FUSE_READ round-trips instead of one.

Set bdi->io_pages to fc->max_pages after feature negotiation.  As the
code above shows, io_pages only raises the limit when the request size
already exceeds the readahead window, so it enlarges explicitly
requested reads without enlarging the speculative readahead window.
This avoids increasing speculative page-cache readahead on behalf of
an unprivileged server.  NFS does the same, setting io_pages from
rpages while leaving ra_pages at the default.

fc->max_pages is already bounded by fc->max_pages_limit (and, for
virtio-fs, by the virtqueue descriptor count), so io_pages inherits
the same bound.

Suggested-by: Joanne Koong <joannelkoong@gmail.com>
Signed-off-by: Jim Harris <jim.harris@nvidia.com>
Assisted-by: Cursor:claude-opus-4.8
---
Changes since v1 [1]:
 - Set bdi->io_pages instead of bdi->ra_pages, per Joanne's review.
   Raising ra_pages would also enlarge the speculative readahead
   window for all workloads (including small sequential reads),
   increasing page-cache readahead on behalf of the server.  Setting
   io_pages enlarges only explicitly requested reads larger than the
   readahead window, leaving speculative readahead unchanged.

[1] https://lore.kernel.org/linux-fsdevel/20260602204430.18427-1-jim.harris@nvidia.com/

Notes on AI assistance:

  The mm/readahead analysis (confirming ractl_max_pages() consults
  io_pages only when the request exceeds the readahead window) and the
  bulk of this changelog were drafted with an AI coding assistant (see
  Assisted-by trailer).  The one-line code change was reviewed by me.
  The motivating performance observation was made by me on a real
  virtio-fs workload, and verification was performed by me.

 fs/fuse/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index deddfffb037f..c8373e537d2b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1495,6 +1495,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
+		fm->sb->s_bdi->io_pages = fc->max_pages;
 		fc->minor = arg->minor;
 		fc->max_write = arg->minor < 5 ? 4096 : arg->max_write;
 		fc->max_write = max_t(unsigned, 4096, fc->max_write);
-- 
2.43.0

