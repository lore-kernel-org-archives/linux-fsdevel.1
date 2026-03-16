Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012064.outbound.protection.outlook.com [40.93.195.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C388462
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 00:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773706662; cv=fail; b=i+xwLWwCucNZPe3qTE1NOdiRwb4pleaKXWhAEGxLcbB8FLbPwZQTTnVnVmHhBS6uDIYnUo41OF/p7TUKNSW1H0iaDFK/bM/bDLZsMUA7a5aa0uk4Rf/FKpFQO2PWufHLHd5UyAwUESMPuPJ0l3dbqfbd6wYkgBdb4cRz9DFla9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773706662; c=relaxed/simple;
	bh=5uYskm5LXnla1TOBHa9UHehSUEXfIojJ0L14uqZYmS8=;
	h=From:Subject:Content-Type:To:CC:Message-ID:Date:MIME-Version; b=NaR2kSjBeJMwQH/F37CzDFyH/ars1b2dDiiDdjk5py14rgLvGSknqmnNC2WlI0/W439IFFIiPNTqjxKQLjTQ7H7w4Aup0hhxrXVc2ag8z1GeB0ARP2lrEkSLehaYqKWYVbM7ZwWIrZdJ8sn37MeW5M7pctYfhXFfFXinmdN53Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kHNHm8cX; arc=fail smtp.client-ip=40.93.195.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kHNHm8cX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YvVB2Ttz2TqZOFognPjpOZdu0YTwNulH4QVp3njhi1optc3+h0AE+u9Cz9altHOFJSsFWPZodPrUVxfXQNCLlIl2oV1L7pDX9FVzLRI19vtzq2HErxaEfLNwnFlZU0Dwi8bxgcmrxJ05VWBeYLJ1+vTWCK0xoCkuKf3hHHMKwIowvevnT5XMLfN65ECLHDJCRC7SHq5vynPdZ/R7mS5ntO5Wqu0qVvNgj79aQXqLiNKFry93Jzb45djg7r8+iKk7IWhHLSWLGGv9ayXMy5dNZ8J5WJqluqfvOwP/VgesvuknZsXLTUmI1MWjEmS7J0qT/wpSRHSHi83TuG2S0Z4jJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXYwiSZMCkrsw+QY+vx5x0Zdo0nF9pCr8otLO0dwGJw=;
 b=nHytQZZgrZycg6t+h5usU1tVbw8RbM7ILw2BK+/pMPmojTIzGvGf9LadQvMOTIoA4rA66uqVbKwIUcjLm6kqktw98GZOxKNhwVmxk7XnC6EHWP3mmDnP8zYTZp7gJ+oAOFmBMcsxF3eQyybpMFK7HNdlHpNv0TBctAg2YgIwZZqWAX/zQi/Q4Y9xQ2bapnczcvHPoJlrVzUO4RaKUoIydbRRPdBPLqZCoUHzuulgcisBZ0q8Ab3Iz7ijWrWcX38nC4dKk5m33ncVy+wlpI3HRdnMUBDZHDgsohF2Xtwso6C/Dm83qrXmhrvaB7mPjUR0tXO/BAgzem6uOf3pXtvAxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXYwiSZMCkrsw+QY+vx5x0Zdo0nF9pCr8otLO0dwGJw=;
 b=kHNHm8cX1Kgd1f0lgLZbYN+UGuEDMMFcoxQbTj8RwEANo4486e1jZbZC6iOqOo+td+O/h5pTvDHguzQqW/URyszMvSKgNZLfiPJ+rV7laNBXoE0vkQAyaHw2UICulP0FJwblextD6XGBcC4v7iG2tzz+ik+dNXwIjXQyV6oCri6F8Uo4hoPtJqb1al9SkG3eNIqtU65+/+gyf4kWAtjvv6I+aGxbPeISdfopZdojat7GqBInWSM3+etYV2HpnMexu4XXewraMPD0XL4Rr/Eau9FAwdcG43Z7kDEgjtC2KdwKlIBe/VmggLpSrBEdZVoiMnwItlEkBHsMCYI9n72tUA==
Received: from SA0PR11CA0194.namprd11.prod.outlook.com (2603:10b6:806:1bc::19)
 by CY5PR12MB6648.namprd12.prod.outlook.com (2603:10b6:930:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 00:17:37 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:806:1bc:cafe::d5) by SA0PR11CA0194.outlook.office365.com
 (2603:10b6:806:1bc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 00:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 00:17:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 17:17:21 -0700
Received: from ubuntu.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Mar
 2026 17:17:21 -0700
Received: by ubuntu.localdomain (Postfix, from userid 1000)
	id BA2542605C3; Mon, 16 Mar 2026 07:54:35 -0700 (MST)
From: <jim.harris@nvidia.com>
Subject: fuse: buffered reads limited to 256KB regardless of negotiated max_pages
Content-Type: text/plain; charset="UTF-8"
To: <linux-fsdevel@vger.kernel.org>
CC: Miklos Szeredi <miklos@szeredi.hu>, Stefan Hajnoczi <stefanha@redhat.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>, Idan Zach <izach@nvidia.com>, "Konrad
 Sztyber" <ksztyber@nvidia.com>
Message-ID: <20260316145435.BA2542605C3@ubuntu.localdomain>
Date: Mon, 16 Mar 2026 07:54:35 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|CY5PR12MB6648:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c8de91-d05d-47e0-6823-08de83ba987b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	85M88DFNCrarWGBxxE77SoFueivsjmBbKIQ660PIUOd2/erCG/MX9TLAwuJ+Y6BsX3WP4oH+dpBYIykZ/mP9qqDF7LkJNz5mjrdiOVe1yFUqTTStJrhCl/jc5DHSaubIB/eC9kgZuAyM0rLdfSCwdZCreZw52f0EIM7CLPAj9fvmRp/qVt4Y4/sueQDShQEbIdnHq+XNSsEOs4eb7UzSCmUtx/DNdHWC3bdDUXnUFM6Wn01Dc5bJv6wy4mvhTasPNhrnSasu6beHLnDscz6Lnq4vo3ip0gWF6pYB2gg7NLIpVMDLDt/FfUyIUrZP+EcBHGSlzNz2X8HjWS/b/QrpLx98M3uRRkkVtMaQlnsHmChEnpGk05nL05dEaFFLXVJMRViP9fjxfIZnK9kjSyXDa7osUSnDKkmqZmDnap4yFP44hO65pHxwKYMO/qK1DDhH//ayLa3wuGE324iq27tIvwd8XYePu0GSQje5Si5y9vNsg66piK4ZQn3EGMOaDpSFKBSajtK9lgNZFGoF3eGlftGY1B7bXgHJnhLwI/NVnQWU89aHVWBGyYMlpkzaenXoFwLDmY5+YdZYdEpyRwOT1SghMoHXK1DOWm7FQ2+X1GajmgDsc8pAafn2fwEZXjJOl/vFrj4Ob19APm8aEhEF8gF+LYnWiiApDHecdbOyj0uQfN8p3yBeY5yE2BtY0wVMVpIFKxpvzy/AE0RqaEyqIx6Tx12U8AranyleUwOUqqlBH3ibBGc08VYVIVWCB8lwf0+cdda18m4+QalRl7KHPg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sIXsFgRggzQqjim1YeIQuu3pGQh7wI+t8ISF5EoZkw6O+r3pbPK9V5k45QgX+jp0pd+ly2yEXJ4WsbhO0t2TZ5i2OHqLdUV4tuej+6Io2FZbCGmFYmdTO56jZOwlMzqYSYQguSC/90dKpe3TiqNWFNyaDd8+b2K7AToQYWT9lAqRBh5FGahvear+35oo4KB109W5WFofCmIFsbMQ+BCWTfo2CGQAJeZcke8p+64ceP4iAuCn79A7/BgeO5GbY+ifqN4oZpNeZqqRY3fLOkQ6Ol8FRIyMoRm6SG0vdK8mFVtO91OzJWJ0Yd41LnXuecOm7k/U5vcXJ+p/V2W5L5DmdGoZWomuR+SWvyiPUWqLIkB4sbW37DIREPZoZsGMUw3lefafFlFTyZFUDhNlq99eHS9lUc34TWNlrg76Zz0/Ib4Oi8zi2/ac9v1wvy+LoYYq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 00:17:37.7049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c8de91-d05d-47e0-6823-08de83ba987b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6648

Hi all,

We have a FUSE server that advertises max_write=1MB and max_pages=256
in the FUSE_INIT response. Buffered sequential writes arrive at the
server at the full 1MB as expected. However, buffered sequential reads
are capped at 256KB per FUSE READ request.

The cap comes from the BDI readahead window. bdi->ra_pages defaults to
VM_READAHEAD_PAGES (32 pages / 128KB). For sequential access (e.g. cp),
posix_fadvise(POSIX_FADV_SEQUENTIAL) doubles the per-file readahead
window to 2 * bdi->ra_pages (256KB), producing the observed 256KB
limit. A 1MB application read() results in four sequential 256KB
round trips to the FUSE server instead of one.

In process_init_reply(), the kernel processes the
server's max_readahead response like this:

    ra_pages = arg->max_readahead / PAGE_SIZE;
    fm->sb->s_bdi->ra_pages = min(fm->sb->s_bdi->ra_pages, ra_pages);

Since bdi->ra_pages starts at VM_READAHEAD_PAGES (128KB), and the
kernel sends this value as init_in->max_readahead, the server can only
decrease readahead -- never increase it. Even if the server responds
with max_readahead=1MB, the min() clamps it back to 128KB.

Other filesystems set ra_pages or io_pages based on server/device
capabilities:

  - SMB/CIFS sets ra_pages directly (2 * rsize, or from mount option)
  - Ceph sets ra_pages directly from mount option
  - 9P sets both ra_pages and io_pages from maxdata
  - NFS sets io_pages from rsize

I see two possible approaches and would like feedback:

Option A: Fix the max_readahead negotiation

Replace the current:

    fm->sb->s_bdi->ra_pages = min(fm->sb->s_bdi->ra_pages, ra_pages);

with:

    fm->sb->s_bdi->ra_pages = min(ra_pages, fc->max_pages);

This uses the server's max_readahead response directly, capped by
fc->max_pages for safety. I think this is backward compatible:
existing servers that echo the kernel's 128KB value get the same
result. Servers that return a lower value still reduce it. Only
servers that return a higher value see changed behavior.

FUSE servers can opt in by advertising a larger max_readahead in the
FUSE_INIT response.

Option B: Set io_pages from max_pages

Set bdi->io_pages after FUSE_INIT negotiation:

    fm->sb->s_bdi->io_pages = fc->max_pages;

This matches what NFS does (setting io_pages from rsize). The
readahead code uses max(bdi->io_pages, ra->ra_pages) to determine
the maximum readahead size, so a large io_pages would allow larger
readahead submissions.

This is simpler since no server-side change is needed. However, it
bypasses the max_readahead protocol field, making max_readahead
effectively meaningless for any device with large max_pages.

In both cases, fc->max_pages is already clamped by
fc->max_pages_limit, which for virtio-fs accounts for the virtqueue
descriptor count.

Thoughts?

Thanks,
Jim
