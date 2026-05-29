Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1923B27E9
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045185; cv=fail; b=IHnPRmJ/SS88xmUyV4zh1s/oITBNsxuWu5hVUivP9CCzARmNIQWn8NqOtziJ4tbd8Dvcpci9/Xs9pJt8ZUjGUQuJfsb71dMfv5Adlcd15mS+VFSr8MzB8XpSLLSQfQI1evNCnpeoh4Gw4XicBQ+CRWsRqkkUQuJCAVBEGJdUpgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045185; c=relaxed/simple;
	bh=mc9WVmXoWix1uDHbzi0RpIukiYHjtFNhPIlXuHBZ9iI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=VpkuoWZQZjkixvwcxveYmnDpAvgnMyDKXj7vxM53uiBYacMSIdNBzLcdhka65EEbfSfeefxd9Ljg7y/Hl/ifaE/H/PBEhQQCjPn11Qb1fUX0V2SIOdUI9GkCdaiMDo/zOPBSDEz/qldJ0jqF3mFohrZZ55b6mD0MSBKdsk0DJRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuUn6jIJ; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuUn6jIJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780045184; x=1811581184;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mc9WVmXoWix1uDHbzi0RpIukiYHjtFNhPIlXuHBZ9iI=;
  b=OuUn6jIJneEpRpp1kVLikAUVXs6qPZxHq4tc+T2qox39SS6REnJwe+eK
   UmsabdQgJf3cEOTa0R0udpPPp9VsrYi+RrOCY7kxZxgtXk87lGIdrMHB7
   QedmOR/r/jbPRrHpNIEdykU3/Lp9gRZuHTC9+HbvXeHV+rZoUZJ6WcErQ
   9EDY5ITvrVqIZ/RwHZSvtFHCOKBg9p+890NS2IdhwSG2vh4JDTRm4klDk
   2yrLh3FoykgcDwPcWt5/pz2Mlr/3jFkCIBveUMdUh8x6P3mfjZRj8xUjq
   8ohDlZ1aEypEDoHw+qVbEKjp1bGcaY+TkpoCtncTGGZDYfLqqJV5o9ge6
   g==;
X-CSE-ConnectionGUID: KbsdOMFMQCGcCOQp7M1ekA==
X-CSE-MsgGUID: GljKPJTfTf6N23NIWIZZJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="92006593"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="92006593"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:59:44 -0700
X-CSE-ConnectionGUID: nf1KjuW9Tmq5DufUR6nN4Q==
X-CSE-MsgGUID: /9QJJvvyRWqtoDL9164F1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="236446180"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:59:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 01:59:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 01:59:42 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 01:59:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPllvazVmo14r5AjTHnvMyySSLB6o/uN5NeTNUCPHdKYYx+Jl0kbdcEEeeieFIxT3rFtah2qdkmR9yruNXS9z1ltGd/6pCYqN+AGtaQoEk34dBt6isjkjbW+i11xKg4dT4xsuxwWn1ZQ88eFVy7ht+YeKQA5e8aA42xCaXYrl2FcZoyvYpzxHvnIrSFHA2t0AFozDjI4csFyZBn0PPJIERvOcfTNC4l3B5e1XSJEcvXJOtp6Y//14sHTXDXNDTn+m83ehsz1kmGkH6qj1Ti+AleyKqfZ1ZSboULAXFWb72u1nXELykxEi8/g+YefIXgy+/5+eqr4NeeRFnXM02IT6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16NAA5rYFC5eZpy1LtAmZ6pMyhw8cJg7p/zNCYTnquU=;
 b=UR7mAvjrJb4RISiwHsI0L8uny2N2qI0KinLDX7R8nRCQGgECQCmFz4zlu2bJLT3oSeFrNbdzzyMKDPjsS2jainMhAp1Dp+/NKkDWQkk3AlDBlWtaeHTswF12bVY1PsXIxcUd4J5yGSzVj+V/nGRdQPSd1XBDMp+2IkfjHnXueZ0hWgv2DLAmI4HGldU1TYvkT/kIl16xRBu/OoEvMK+/ZLtbY7QFRQeVdAL+drykd2Kq3a1ZnO2EkRRS7C+lPDDe3KSk8wZXvn1ubwOZ9EVlWHZ32XXDcbXwW3vehRDl2sTYw7OioIQUGdakn5Lwp4+3VEX8HsiuPt+i2HkRIxbbjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by PH0PR11MB4997.namprd11.prod.outlook.com (2603:10b6:510:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 08:59:39 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.21.0048.019; Fri, 29 May 2026
 08:59:39 +0000
Date: Fri, 29 May 2026 16:59:32 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Hannes Reinecke <hare@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [hare-scsi-devel:configfs-ns.v5] [fs/configfs]  7aae6b1018:
 Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN_PTI
Message-ID: <202605291631.40385aeb-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TPYP295CA0004.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::13) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|PH0PR11MB4997:EE_
X-MS-Office365-Filtering-Correlation-Id: 83cd5725-8141-4726-49ba-08debd609d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|18002099003|56012099006|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: 1A78HzLElegYsGCrrJQDfI6I39uUswJbq+c1a/pFBe2ss5sce3Nxbh6u0LM/w0ZbYPKZonSzJ8P9HY4VWhtnhGbkPgoSN2dwucrk9mNrfje9TMniyp4mjbJ70urulYXkY6Ohr/8PCbDbp/81hQgV6hYjnDpcX3JDHMQKPACMp/ToaiBe9wOuiZKitAdPmIeVz5ZyrsDp9zC9iW6R8LnShbYGY/jcInbMPKgNU8irULbTQZXfvcVHWm5g7tCUp+uX2AKqfk7gFCNiF0Bdn0BzMGIq5koA7GOj2GQhEXcIocIZjUj6yeOSe8cpMu61H0Yeiy/THP9t/1/zhtnFp9mFQib2shvrddjCPYtkd2UggdkWAC242SFDlYeyvTwzPzBBIem7IzGz+I8QdpkADd91ap7rq+PWVCSAnHC4bdFIdnwkZo4qqBxSs/zGPCi00ap0WFTi7mzzgBMZTLWxJRQUAidNxdOefWs+bY46zer6vn7sxfxxRAGOGN6XbcaA24ybQ6MtlpUTobHH1L9JTBls1T+Rv1BS8Tt5pYHF15DWKEllP/NP4rZ9kQPaIBI8s9eprzExug18b9C/Tj23RQ5VprHksLOjjgu0uJ7ZLEsXPBxaArdfy+sxruVnd92sok7QxH4oKNUZ61HIoXRAJe8eIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(56012099006)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rM5mSxUCRfGWixvKYIAhA3IzlOWHattBmQpJ3ho/9IYtIGjavMQg3mYFjhuj?=
 =?us-ascii?Q?8bhcfWNbfXWr8rrFqfrMLaz55ZHeMZ1ceATzqVt50TkwYQToQEFYqRSjomdg?=
 =?us-ascii?Q?T8YDl3lLaQkIktDg3qZgXDOa2IU4F9FayZcwiz3FukGr19C23+NcGqhaPeNY?=
 =?us-ascii?Q?xTZsrT3hkqVb2g2F3D6vip9uzKUWKB2n3upe6DMdPFBKKEBdYBdtyrXWvQXz?=
 =?us-ascii?Q?+Nj5zTfkn3XXW7sX9fn0drR+AP4BXXW5zH4y3kl0D2o9tuZhrKecqt4MNCia?=
 =?us-ascii?Q?aHymKP642gjVeiXAtEXPSWNyVTgixAN/7DIO+qLnzrzAR75BRC/IBbBM8jrz?=
 =?us-ascii?Q?AM2De7wTnKcx1iWQszAmyWdt76KUWRfClkzTQDT/kYmmlr22WmKNhddJmsbo?=
 =?us-ascii?Q?eOHlhFumsvqrdG16JkPaSxtCz6LLjJtNdrWKUgn1nlKtniRF50fUXDbQPE0W?=
 =?us-ascii?Q?VK+MYrsDBy8GTvgZuctYMyGEZYKZgzY4IXTqjk2S2Y19VQWVU0XozcQWXDOO?=
 =?us-ascii?Q?Rt6aBU/jX20aAQMSbvpv+tuS5/DXzMnGzBPKWftVD+AUpAZoCSyk8gWx7aWB?=
 =?us-ascii?Q?cw5dxZ/GRuBijn4xVK8q9oCXLt3VDJOKl3r2niFsVjTb606CdVfFx/IxBjwB?=
 =?us-ascii?Q?Z0UK1V3iRrPOhXvJ3Oi1+ZpkDJlCxw8kO22WGZzTjEDrt0/reVlSUskfhrUM?=
 =?us-ascii?Q?wgFi3rdt5ZmPnGlSY9M8aKWWbA6IaH9ypd+WQ7TvMTfjhhOb5cEBPZ38WqyF?=
 =?us-ascii?Q?bzggbb7rlBzDL91NGyVDT4bbBNjJgb3oUlXY0rV+s+WuGohRrtm9zvJDV1Uk?=
 =?us-ascii?Q?Kp9v4QLige9xwY6RLhOGugy8qQT/tqBu5EB3+BQkSObS5IMC/ox0aZ4knhHu?=
 =?us-ascii?Q?H9ulisUC1EzF/JQkYpzVi3PucjNhstHLWyUAH4mM/SA6YVTX39X0gzWfof2s?=
 =?us-ascii?Q?1qT5NlUC5QOlcbcai0B6TMGY3BnaBHAMdv2HHAjdmCx0vL2MhhGjAw8EC3n/?=
 =?us-ascii?Q?qpeBp+1oJ4tt+IiwlzeK3U07J6l3NyZEIcdjFi7UHrxmzfUfBvSjIsZ22CeI?=
 =?us-ascii?Q?1OwBD0Gv2Son9DfBJb4RJeBVDpi9B3LTm4eq3HuhHWeWK8NdM2MkwYTytcXp?=
 =?us-ascii?Q?vNpEIYBSwChM403UmCdDu44MaNM/01bdge0qyRSOallzDZh1WbP4qXVOHawI?=
 =?us-ascii?Q?CN19aiDg8Qvifp+/1f24MJlAOB4VDQYJU2hmg9InDqMRX420fhdl6FYRiZtc?=
 =?us-ascii?Q?NvVpmAhp4k08MW2Rs2uxk5UOluNIHWXd9AKx+dYQh4QBaJ6Jxjk7ZocztgSM?=
 =?us-ascii?Q?b6b/ZxeNN2qY4c/VvVy9Ixl6lKms3mMDe/NshWOD/IDbuBKUEaKSzH6uckf7?=
 =?us-ascii?Q?yfFJg9miHL+GZF65LIBn7Bl6+9Ty9paKBjRWxUfwM+wdXdUpp10vznDAr5xJ?=
 =?us-ascii?Q?MANQUO7s40EjlS3CvOopG5rs7dxQG7NgEIkGJNp0Mk2AtRGP4eOBTCQedj7n?=
 =?us-ascii?Q?fQ4WqVJ2UYgMB8FNSFJwiCPBHNCGDqR0hV3lnSlkf/2LDz5P43Y7gmafuy72?=
 =?us-ascii?Q?OG1o5ALLIxxSoxbaSkm3UddOXTC6nXGwYyJULq+YiBUFbcK++bV0baQ81siR?=
 =?us-ascii?Q?th54aGvQFnV9Ni+MtS0vSZV2WuQnhRAbTrPnL3TVj7ly7DTJM4FQUlI3NZPY?=
 =?us-ascii?Q?yiQAswK8xZ5+2A3pScVOSVOIz2JVjwUb0lO3LJdQsPP47HsWReIpDLdzwLJk?=
 =?us-ascii?Q?MCk6kBCNxQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: JH3Aa4GUzga4lHJu+u/gzmiKyuNblysITCulTM4u1ZwXJjcbf7ui9/f+C6yfs++jCmcgnpQKDGaxfwVqPZNnPXl6Vknsr0ylgL8xTbHiYsOTFoELKNEsoHJWjrmbHgkjgCMQdQTdhLnSynC3ioNTWLPCMv+HK6MbFmPPIWpwE01GS+RJ+q6WV61avI8ogjtOWNOinwOvKKJ4zjgxSAUmLblGoOLL6mXHOjCO59aElbV6YjGprOaDR/bB1akJhDVnQCoSoa3q0vQf6dyj1F+UUy4RnPtPEclsGExT6EJwX1SB19ZTjCXl0BKdf7nMvfoC/NMexhFOgdiuWTbqXnEYvw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cd5725-8141-4726-49ba-08debd609d7c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 08:59:39.1283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 04iEbsEwWx5BE5FPDwe/kBgaKWSzavmmF5TbOyiPqZHjsuove4pyZO9s3vGPHb4AIXdHO7o3NhZxPlkVK6ELVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4997
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP_KASAN_PTI" on:

commit: 7aae6b1018fb4655e80345c84a0c000ef5c4a7fe ("fs/configfs: separate out configfs_{link,unlink}_root()")
https://git.kernel.org/cgit/linux/kernel/git/hare/scsi-devel.git configfs-ns.v5

in testcase: boot

config: x86_64-randconfig-001-20260529
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605291631.40385aeb-lkp@intel.com



[   17.291164][    T1] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
[   17.292114][    T1] KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
[   17.292114][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.1.0-rc2-00032-g7aae6b1018fb #1 PREEMPT(full)
[   17.302193][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   17.302193][    T1] RIP: configfs_unlink_root+0x204/0x580
[   17.302193][    T1] Code: ff df 48 c1 ea 03 80 3c 02 00 0f 85 09 03 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 68 49 8d 7c 24 04 48 89 fa 48 c1 ea 03 <0f> b6 14 02 48 89 f8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 51
All code
========
   0:	ff                   	lcall  (bad)
   1:	df 48 c1             	fisttps -0x3f(%rax)
   4:	ea                   	(bad)
   5:	03 80 3c 02 00 0f    	add    0xf00023c(%rax),%eax
   b:	85 09                	test   %ecx,(%rcx)
   d:	03 00                	add    (%rax),%eax
   f:	00 48 b8             	add    %cl,-0x48(%rax)
  12:	00 00                	add    %al,(%rax)
  14:	00 00                	add    %al,(%rax)
  16:	00 fc                	add    %bh,%ah
  18:	ff                   	lcall  (bad)
  19:	df 4c 8b 63          	fisttps 0x63(%rbx,%rcx,4)
  1d:	68 49 8d 7c 24       	push   $0x247c8d49
  22:	04 48                	add    $0x48,%al
  24:	89 fa                	mov    %edi,%edx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx		<-- trapping instruction
  2e:	48 89 f8             	mov    %rdi,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 03             	add    $0x3,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 08                	jl     0x43
  3b:	84 d2                	test   %dl,%dl
  3d:	0f                   	.byte 0xf
  3e:	85                   	.byte 0x85
  3f:	51                   	push   %rcx

Code starting with the faulting instruction
===========================================
   0:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
   4:	48 89 f8             	mov    %rdi,%rax
   7:	83 e0 07             	and    $0x7,%eax
   a:	83 c0 03             	add    $0x3,%eax
   d:	38 d0                	cmp    %dl,%al
   f:	7c 08                	jl     0x19
  11:	84 d2                	test   %dl,%dl
  13:	0f                   	.byte 0xf
  14:	85                   	.byte 0x85
  15:	51                   	push   %rcx
[   17.302193][    T1] RSP: 0000:ffffc9000001fcc0 EFLAGS: 00010247
[   17.302193][    T1] RAX: dffffc0000000000 RBX: ffff8881005f0eb0 RCX: ffffc9000001fbb4
[   17.302193][    T1] RDX: 0000000000000000 RSI: ffffffff8516f240 RDI: 0000000000000004
[   17.302193][    T1] RBP: ffffc9000001fd00 R08: 0000000000000001 R09: ffffed10200bd765
[   17.302193][    T1] R10: ffff8881005ebb2b R11: 0000000000000000 R12: 0000000000000000
[   17.302193][    T1] R13: ffff8881005eba70 R14: ffff8881005f0f18 R15: ffff8881005ebad8
[   17.302193][    T1] FS:  0000000000000000(0000) GS:ffff888799493000(0000) knlGS:0000000000000000
[   17.302193][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   17.302193][    T1] CR2: 0000000000000000 CR3: 0000000004ce4000 CR4: 00000000000406b0
[   17.302193][    T1] Call Trace:
[   17.302193][    T1]  <TASK>
[   17.302193][    T1]  configfs_unregister_subsystem (kbuild/src/fs/configfs/dir.c:1957)
[   17.302193][    T1]  ? nvl_gpio_driver_init (gpio-novalake-events.c:?)
[   17.302193][    T1]  gpio_virtuser_init (kbuild/src/drivers/gpio/gpio-virtuser.c:1789)
[   17.302193][    T1]  do_one_initcall (kbuild/src/init/main.c:1392)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260529/202605291631.40385aeb-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

