Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C644BCAA3;
	Wed, 19 Aug 2026 18:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163402; cv=fail; b=CXvJ7vDAkWuZ9f0iJHodZXT+fMdvek2TbmkLZYUY7WBlhQKRbvt0RaBYdpqD37FdCNUs1AyJ3UtdkSqJX/pDAuZeW7JcVNlORV+9XAjS9r8WmJ0nUKAN+09I7SSVRrWRr7MZuglf9/zIqgZGTriMcjTrcJLydpOTLIxNzM/PxIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163402; c=relaxed/simple;
	bh=aQDctpq6hqcqiqhA/H8qd8VUjSCqY0uhiJ/TWCBwkTQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U41vitg1OgMvEmDUHKbkCI7Rkf0+84Qey34FC+gSpa658PFN8siy8OrK6tkVXRPLKM+5uvo6/ihTUBLgWsVPK8iLiFLH1OOo+csnHVRMJrkyXqzENkf4gkgWpAEAroQcAJezMDWXX4tQK1JfgI2q3shBtfFiRyynY3wtH1l45+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=fail (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jPx+NSCJ reason="signature verification failed"; arc=fail smtp.client-ip=52.101.52.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jPx+NSCJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8CfC/co0EJWRQTKoaGPOggJwqckxpKfBfm9ARPE7CqGMpWNOBFoc2Ir4SYE5N5BNF+vGAGWynbcS1IW8FZ0NAiZZf/1phVbMkiXnHZuO4yTkkj/TfHXBf0F0N21eNNxU4q8JXzqFgEiUY6XsH7UyLBGQWHSocLwFwc9SekQzB4LUX8ElJ6JUeHpYF7tkks6W35JPc8wUi5XC8BR8+0/ttTWdvVN/z5IjRePfyO+CCrwQ9XIyUVu6CtXmJMdJiToZAtEXmchcukf7k/p6P477kXjnVqE+aF0WHiGWTO/uhEmqOziVEXD3/T2BvSk1eTTv71LVeou/AAUmtwqDzdh4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBA6cOfAnaL9vf5N0E6/R3oGIWi787j422DTstAJOVM=;
 b=PcineZuOqvURnwQOKbYn3l9aF47NGftT1cqdEohlRoLPzGBD/9GpPmBn+Guyi7xgarZssqgVV+FwXg2cOmlFMI5ZRqlJudeFQ6rYOc+u2zMkmK7K/tjkPnfdn6/BqwiTTL30TkBhfORBbjLmGzhM+N0rJ6AUYo9qXwpRbXhUMOgxhghbER3UrApmzhgahYT5Y+cpp2PAMilegzNYbJkYXvCiT4RHENM2lmNfRrCvUr3dU0R/qG1fYpNrm7OqUJGw3dS6K7q5LJOYcIoOwqWgxMFmSzH6WCsm/VPjulZg4SXXofeUpt4HKDD2PIuS/ofXGyEIzYREnDq2RrM4iS59GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=szeredi.hu smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBA6cOfAnaL9vf5N0E6/R3oGIWi787j422DTstAJOVM=;
 b=jPx+NSCJFDzfb35nS0CPRRZUWNSy9Q82Fu+vhLNDic1mdYHyHEMCRCDbYbfRsnfN4FnNLjvWdiqnsB4BzH18jpgTb8No+qTqgxZqF2VDzpKomL5Bd6zjw7Fw9izwzFPzFn7vCp1l7xGQzRbcL/9ruGW6w1XlVQbCUiuWNeKfyok=
Received: from SA0PR11CA0209.namprd11.prod.outlook.com (2603:10b6:806:1bc::34)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 18:16:35 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::e) by SA0PR11CA0209.outlook.office365.com
 (2603:10b6:806:1bc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Wed,
 19 Aug 2026 18:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 19 Aug 2026 18:16:32 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 19 Aug
 2026 13:16:32 -0500
Date: Wed, 19 Aug 2026 13:16:06 -0500
From: Michael Roth <michael.roth@amd.com>
To: "Gupta, Pankaj" <pankaj.gupta@amd.com>
CC: Tom Lendacky <thomas.lendacky@amd.com>, Miklos Szeredi
	<miklos@szeredi.hu>, Punit Salian <psalian@google.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Stefan
 Hajnoczi" <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
	<linux-coco@lists.linux.dev>, <x86@kernel.org>
Subject: Re: [PATCH] fuse: mark DAX VMA page protections as decrypted
Message-ID: <ijwjd4gc5hrowrxntq7dknbuhvotkvpuhrk3gdoorxab4kez2w@ym6mti6jmcmz>
References: <20260727210718.125872-1-psalian@google.com>
 <CAJfpegvtp3L3FuYd8v1Ox0nZ-fb632jy+_M_+YyBWpMQGJAXug@mail.gmail.com>
 <909ab2ef-b931-4a64-acfc-13096f232a07@amd.com>
 <004afd12-762d-45d6-ab75-037d58e7a359@amd.com>
 <b965c127-08d2-4e57-9396-a2c3f5cf253a@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b965c127-08d2-4e57-9396-a2c3f5cf253a@amd.com>
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: f002c6ef-03d0-4de9-15db-08defe1dff9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|13003099007|6133799003|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Z3Te0nj2STR98usJZ5XBqzCCHR2TAMJBn1+VO81kz0KMyVewLRMmkpv1iwuEmSeeFWj6mnLQd1610DO14AlFQfzjLcsCwwvYsMZFmCAnoZ8TBfBffP9iFhal6A3+OG4Zu3I6lYBZALmZdeeT8ZWkz7LVlKQs4VRoT/wms9DYPiWrvgCRj6EwSyCeQmRn6eUZuw1nCtXKqLiGgkuDj5IyhvtzSuvJGXr3hWgtBMlewlXRJ3L31LeTjSyiE31QwjzQI38qLuprzTivVtQBcFEEahzIuDixOV5m9rKKGFn+5kkyme1OA1CQEQar5eRXxV6a7yCy8zMuA4hFQQTEt+tzo9AEP8X54ufoQjFEf8GJpEWfwsQr+FHzBJyxJg4+dTlfcW0L5xyBjdhneWkfrjWqQSVajWrGaJQ1hssNiiMx0b0bKqL/UMSqE9/stxxv0wl+fJYXOagL4ZKE527Sb2eWLS1HLDrrz77J7o5THlfJpYTTjlCxFlMypv2b45gJ4XPsCLefQxRS3Wd3a+MkeIPcY8SbLQ5k7Fmxa0ezLCml03aLgU37cF5Pxdl+uQWcI2m7nWGL7ezhJ5RPGyecSTw4y5RUoOCPbl50nTkMhljDEM687AK4kILE8cZtgxqkt2G6Ek3+EaRlZEVq+M+j2mhYqL6Hxb4pq3Cu7tX+KBqX074qVvDJ4rWk32T2RzuOtQW3yhwUFWOokYhFTs4ncyrhfA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(13003099007)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JH8B2KUpVxOupUZC9wAF80jl/FXP5K4NSSXSHC3Q/zZIiPxYA2iaWyVjiCL0+/ZCktKZFy2Am3uVdC9vdSC5zQenszpEBSz6Y82Vrb8lC7HJOOSpRWFHNwyvQmCnfC03psPq91fm3Pku7na1cQy+tiHZZLnGUI0qhQ5B03IYvxIXa/dacM29GZ4SySmLzlRHshKbHi6JK8iOvZZjx+vstRgYWfDYeJHSmzeXK//gOmOb8gkja4blDF7ruHxozJ7/hY0Od/ZKMPgQF+ZtX8eIqM2vCY6dhhgSsLHZ58p646E0QhBQqp1uLxsci4CtorNPt2b073VsSkwaW9mZg7NRkjMWsWbPFQmjgERLSJ1tXB80KJkN/tqNszaq9rgwEGK53uzWiX0bPE+wloNT7Ec7RB5NXpbfXrUCmGGC7k6xagco2nXR5jziiPW3eIYH+ftp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 18:16:32.8291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f002c6ef-03d0-4de9-15db-08defe1dff9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583

On Wed, Aug 19, 2026 at 05:03:10PM +0200, Gupta, Pankaj wrote:
> Hi Punit,
> > > > > In confidential computing guest environments (such as AMD SEV-SNP or
> > > > > Intel TDX), direct memory access (DAX) mappings between the
> > > > > guest kernel
> > > > > and host-backed FUSE/virtiofs shared memory regions must be accessed
> > > > > using shared (decrypted) page protections.
> > > > > 
> > > > > Modify fuse_dax_mmap() to apply pgprot_decrypted() to
> > > > > vma->vm_page_prot
> > > > > when establishing FUSE DAX memory mappings. This ensures guest page
> > > > > table entries for shared DAX buffers are explicitly marked
> > > > > as decrypted,
> > > > > preventing memory encryption faults when accessing
> > > > > host-shared DAX memory.
> 
> 
> I started testing this on my AMD system with QEMU and am still working
> through the configuration details.
> 
> Did you happen to test this with QEMU under SEV or SEV-SNP as well? If so,
> would you mind sharing your setup steps or
> 
> the QEMU/virtio-fs configuration you used?
> 
> 
> The error I am facing is: device 'vhost-user-fs-pci' does not support
> ACCESS_PLATFORM when it is enabled.
> 
> But under SEV-SNP ACCESS_PLATFORM(iommu_platform) is globally enabled and
> when I manually disable it, guest says:
> 
> [    8.788217] virtiofs virtio0: device must provide
> VIRTIO_F_ACCESS_PLATFORM

I'm not sure what the real solution should be for this, but does this
hack for QEMU avoid the error?

  https://github.com/AMDESE/qemu/commit/63f103e35f5f3735d10f7618584bd8bb208e2c28

Thanks,

Mike

> 
> Did you observe something similar or there are additional virtiofsd settings
> i need to use?
> 
> Thanks,
> Pankaj
> 
> 
