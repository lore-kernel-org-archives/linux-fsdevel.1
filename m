Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7DA365A00
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162934; cv=fail; b=UFMpEpn3D4pY87svG4pM72D+QFKr8yzqdDC1x0eBkxpk8d6u2/B/8WcRqyacidhnSWxRuFuX9qrwCw6CocUBxhDJjLoUnAN/lH/Ux23pXdeGYbZCKZHzVlbk0m1H2v4ByiEA+MsRHKAM+6w70NZUncnqZN0kruQCsWaW9XSfDjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162934; c=relaxed/simple;
	bh=Uz+BXReznIKFf+sH766qqazFwqyJMTeuDku/Y01DxZc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=IUpatxthJRqblB2QK20JQaBFieCdzM3O2J0IXo/bi0l6EMohoBuyTBZwaKE59Gn+RZmIB2IA/CiQOO1+bEQYjdEU2wqV1/AqSOyoBkBkhD6l+qZneqaJ2Sj1ISERxj0c2SrIMoeA9VPDG5lhuEZn5Nj/ATFVIuJupFhZAMp4pKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fXjuwaSb; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fXjuwaSb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781162932; x=1812698932;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Uz+BXReznIKFf+sH766qqazFwqyJMTeuDku/Y01DxZc=;
  b=fXjuwaSbon9Pdd+eOnq6N85OkGJ46hstqzQhNmjYpDGg5YSPq1kgkZLL
   IkdSXZM/si6E33m240sP8AJjGl76Av1Y8k1ifsBV7mEhD/7gQpWPiGyrS
   6VyY86kg9HZGR53UehukNDiqOsQlJnTK/NJKPzbwsY8pAb/aZZkfhs+lB
   PSXVPckM6lGoRdXhaJt7U+WVJRWtS6TTD1HEfnQHZc3ccHnUOgnciThLp
   0hwA6epllcEJ5O5jdjV0LGdP8nGFn0FXHl2v3NNVIylWDLDtaFJzDYfD4
   nFeM6ZaKuIy/k4a+BYuiEXiO8EAp34F7k3F4f73hN1k4PQQG0lStV98hG
   A==;
X-CSE-ConnectionGUID: KaxrLBogRGWdd0O5iTGaLA==
X-CSE-MsgGUID: fC/Qxi7iTlOjvTBIQmVmqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="99546738"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="99546738"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:28:51 -0700
X-CSE-ConnectionGUID: k9k2vU4/RtW1A4wQakeTxw==
X-CSE-MsgGUID: HAb3QC7RRUa+66/J2Ni3Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="240060198"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:28:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 00:28:46 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 00:28:46 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.16) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 00:28:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1Fcx1hmeQMpD+SUdim1JFWCDBufnY0D4rzVePP1m1LkQcsvajdc1Hj3JRRyYb2gZkzn+9dF045Gg041tfJ3om9T+w1xkdf5VwJ7Sjeud+oZ5PGLMUBB2pzlxRqfQSvwHDS0ipqhjJbARQ87VHVrdpJQ10Jb3/qtcz29vLA/EaeRCA9fCnhlliPSCyvW3FIGFE34VteyhEOIIvnOUXPw9UxPoic7DyOiSe//DzQPS2PIcJWtVeAewyrWrN4BduCBdJQuiG0h0yveFkVa95Elb5KEwZok2V7yJb5UMHI06WvEgVyotos8EOOeJekA7qaG4SPedBUfuYnTicHbsVwnsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWZT221l0fYUsPVpQZXuO4F7ThFsHf3VWKxyP3f313Y=;
 b=CmkEwnx2iaNqtuVpnmyCHMOqazP7V5js14/zohG5eT61gSaue1rNLI/F5EDe5mUiqcaEJReEaHLUdvtMWKFSpDdCWTpWeho5sF/oqbR9pXy6wn6CFhkWkH8ZYjd1OjeGzjrlIrJoKZgJuuTZYKdCPNNvWj4pZN4ZlpPTDpVOq4QMmmWWL+O8Ly4YtNfwEDmC/QARe6aWRg4WXz+V6ln25hUpkcv1BJkHebC5EcXObisxiJoqM03sTOC2IX4JC2xsIsZu+FT3ETftGDteqIfG3MOQIxkRwRFYJweNCaizhEajHT3hXGS+PJNI3lOj+aPNImrHQfBx0U+v9GiIfui89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by LV3PR11MB8728.namprd11.prod.outlook.com (2603:10b6:408:218::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 07:28:44 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0092.011; Thu, 11 Jun 2026
 07:28:43 +0000
Date: Thu, 11 Jun 2026 15:28:35 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Namjae Jeon <linkinjeon@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<ltp@lists.linux.it>, <oliver.sang@intel.com>
Subject: [linux-next:master] [exfat]  07d67f3e90:
 invoked_oom-killer:gfp_mask=0x
Message-ID: <202606110923.2d2a1a13-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|LV3PR11MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e9b3b6-f75a-4a49-8d86-08dec78b113a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|5023799004|11063799006|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: W/ysRbY0A0sSdzCk+NzFrjS4/FvyVLYCQzVqRBqDGG2Anb6ti+TIWAMSChNNb76mbm/UNCwnBSZySEqeiCUSH0kIusUCCHY8a8oIDr/D0PetgHU598oH3lTP8tZfkn6JViObxb4pGDW+dpE5C335oZB/+21q1/lei6PMonqLSJnvegB/Np6IyktWETCHSpnITTbITIkWmlf+xEm8heGzFPi9UHqxfwBBsZaPQGQZcFF259IZ+xLK5WbI5GpDj3ShwOGjUzao3xoJ+O0JbbdIRhX3YBvEBsu6Hum1j0exkL04M5tMkpM+hBH3X+PE/c3MYFSKzyNVLXyhVZjxs6NXuPVZOrlA29ijg6FGVMQwF9TeK8MzuHPZ5qsE8J6G1MKKL0uSpq0CcyeheZINQutOQseUvjlx/RlUB7BsMpIPtDD02XPC7bdpJao9jx9srWDboke9nm2rQPQfh+RRJJerHUbeBKhoPUux5LloxBvPQJVjBLIR6SMv+OnrF8cyVs0MJGX/+n0zI9n7auzhCEsgJC4zQVKBKMmaAx5Jq0RUH39kgpfTSv2kvYeTmS0bWYz++4nuVFTFYPAVP9EYTG0QPAPjQxADhjHe+3n94w5Hb4RLZZgVj78TxZWo5jD5hgnyjxxbJkeEaBb9FROzxQ+UMuWrgmst6SXIWbKQtHewt7skmtvYu5AIF9yiaRjBPjiV0nltdftBb6i8Fphbgm38Gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(5023799004)(11063799006)(3023799007)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h1AFtTe47K1ob2GT/4X9h+sIATEOW5eyPj7Zkok9g8J2U369SLWlXfzeKOgw?=
 =?us-ascii?Q?gthpAgVolgJwE8Tbw8fy10HSqfVGz1n2gWD/9OsfUq7LPy6AP8gqjqzSRo/z?=
 =?us-ascii?Q?KZkfEL5KTm6B3HlcWJnDefdeMAw3ij/JCUlxU4Nx6LO9CiwVTydPQYro2/xH?=
 =?us-ascii?Q?Z1F7XHDWmIv9dhCF2hV7cWT9F8xsTmC5xTmN/YVWK0LuW8JppMNHGDEtfv+A?=
 =?us-ascii?Q?6hIMHbCV3XXKYaVgL0jbB/XNXNwpeUReTJRTzc3eWWkNR8B9Z9at5uTqaJv5?=
 =?us-ascii?Q?q0lq0bkrERuOE0LWW8flv/ohC98qW4ad/FZsVyX6MMNuF6PQkhh1NlQyuO11?=
 =?us-ascii?Q?ogBPSqdvGK8LyoWXKyfLeeBiZkPjnLIWLqh+XI54U/sUiCdHjiAxh7ViuUiS?=
 =?us-ascii?Q?DYjD+HP5WYGAgbTJuXT9BNyP4v8aE5l7DVUalBl+jfP2dfHfLbkxadp3MaQa?=
 =?us-ascii?Q?TjPkkCpD5Wg3G1gDzb6reg7GqbKujhBOoYg2ytOgTmltU7S+pZgWcA1zkXQg?=
 =?us-ascii?Q?oyhJpJDK4s/eFLew1tEcp4Tly8QE9GyjMjDm1iK12tnod//uI4s5tqycxnWf?=
 =?us-ascii?Q?qW5ROGlY3z5OCmTEbUuD8POi5YdSFnk9b8WFbpnwpgeNM0YOHh5CvMqJuCw/?=
 =?us-ascii?Q?+U6NMBlVYXsptrFYlp9bmaMsRFNtmaHwiFgFBiduwQWyybechMYm18QmrHPq?=
 =?us-ascii?Q?Ogkv9qTTkS+RFs8u53T+Zf9yVr0Hpgv7ew6N9vgsUzeNWqfHVpDqZHYE1Zs5?=
 =?us-ascii?Q?4Mi511gZYHCuxBPO/vux3oGo7xXIED5PQP7pYIp9roVus8H2aoh1xkAe3tLz?=
 =?us-ascii?Q?2O9JY8WymQ+SjP6ViqCeLG9cJdXP9/mdcCST6n28Uk/CA1pf/lV1NoDbjFZN?=
 =?us-ascii?Q?xK007JG/hBh4+jmE3CFlNcevRtjo/MiG//09Zrwq53eBv+HiiUa8uJ20nFoS?=
 =?us-ascii?Q?XfSxlfWvSrgOiAuBkLW+L65HMUHAYZ4BnZ9V/GF+WwWvRPRPH4VPbDznC8+Z?=
 =?us-ascii?Q?sdT6eAMxWDHQQ0mvBU4CN4RQSsmdRWLMcEETsYqEJQ1i+t118D8VBMzrU8Aq?=
 =?us-ascii?Q?OIKS2D/SAg0fMKm6l0c6cllR9AMpcYnE7ztlM6SE4t8rtmnkKoVh43E8yDAM?=
 =?us-ascii?Q?tSZPVprUZXLEzOwV3hDtJB1SCHyKUg6PsWEA5NmrqJQH7oGgVipwgnSmW0J3?=
 =?us-ascii?Q?qrX3dhQOec8PkgJDoDcieU7bTq/JK+6cXMqUGR27YsDShEFNky5R4Hv6GtV1?=
 =?us-ascii?Q?skKcAL49kdPbRH7ykmyuvg8VWyFvA8e+QYsEekAjP4epKY5zqlhJIn7ua1W8?=
 =?us-ascii?Q?BP2D4eSf0maZA4RWKi2JvbjpOemw8naCrcE0ie52WZ8ziz3rLoN2DlyUZ4+I?=
 =?us-ascii?Q?XOU5V/p+L34QojqkDo6HdZ2M1Oq+2y0020cz+VMtsbA36nk2IvskH5XsBmGu?=
 =?us-ascii?Q?DUYy9jsGX9oSVaGya1Vwmdw1X9UYgt9t2ApvrWiNRkXiqGzfkeQedctU2v0y?=
 =?us-ascii?Q?ucxHx5H7WLLh9Hcq1BCZ4UIP0vJfKyZsbcVD5cR6kOHzurZ3uRUsg0ZUr3o3?=
 =?us-ascii?Q?aFPmKOprUKCKTZp6EUOROaX1XRO6LB2GQ0eh5q5mZaMmCDAzuKzqITxgSkui?=
 =?us-ascii?Q?Dr4BKA0CMlkM3AeYX+n55AjpfaAA8hKe88FjgCd5ERJEW4QRAMU0Jg238+LK?=
 =?us-ascii?Q?Y+xe/9HCuXpso2gIKu4kE0SScYbrUaVG7juF5PhvG9VCXUbDoLZUy88HC/sw?=
 =?us-ascii?Q?fcc5uby+/w=3D=3D?=
X-Exchange-RoutingPolicyChecked: W0si5jW4++pGqOpy2IbYG1F9WkJNUcAtn5Zim9CySs5oD25I+Es4otMxLp5n/9v2BwnxHXZmbCUJHwDktzzuK/ORJs3Px3beYUBH5tSj3rKmQExC87TvdeM/8TPSYesn7Kj+oau7syNtnoY5WTqJ30xgrHyz+W6CUF/LkmRkUxI/aQ1T2GLTuHq7oYDw/SKY0esISuL+SjXtKR9Q2HE/P1MOf6vt7OTJnUwkgbtNXgVsvm4ON0lkJSKWgvKgUxW+0/pDbmVwpuHrTMhSnZQdrSpPzrfaV0yqCtaWiasrT9NEevp4yikm1WcTskdiy5z3ZEIsDPuLw6/7v72EQ97N+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e9b3b6-f75a-4a49-8d86-08dec78b113a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 07:28:43.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOWtSwVBujfhipm5nJb6DhU8OHB9LTCl8k04cwLho4hHnu7n9XyZTzCtUp9VZ2JhEqYaXD+DOFO2QVX6tqZAPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8728
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "invoked_oom-killer:gfp_mask=0x" on:

commit: 07d67f3e9083bc976b34d5d9183f87f0afc7deed ("exfat: add iomap buffered I/O support")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master a87737435cfa134f9cdcc696ba3080759d04cf72]

in testcase: ltp
version: 
with following parameters:

	disk: 1SSD
	fs: ext4
	test: syscalls-06



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 16G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202606110923.2d2a1a13-lkp@intel.com




kern  :info  : [  465.291318] [  T10063] BTRFS info (device loop0): last unmount of filesystem 4c3cfb15-a618-4082-907b-517e4751b46d
kern  :info  : [  465.335911] [  T10157] Adding 1020k swap on mntpoint/swapfile01.  Priority:-1 extents:1 across:1020k SS
kern  :info  : [  466.585441] [  T10157] Adding 131068k swap on mntpoint/swapfile01.  Priority:-1 extents:1 across:131068k SS
kern  :err   : [  467.591291] [  T10170] swapon: swapfile has holes
kern  :err   : [  467.608966] [  T10170] swapon: swapfile has holes
kern  :warn  : [  467.703015] [  T10170] swapon01 invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
kern  :warn  : [  467.712815] [  T10170] CPU: 1 UID: 0 PID: 10170 Comm: swapon01 Tainted: G           OE       7.1.0-rc4+ #1 PREEMPT(lazy)
kern  :warn  : [  467.712821] [  T10170] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
kern  :warn  : [  467.712822] [  T10170] Hardware name: System manufacturer System Product Name/Z170I PRO GAMING, BIOS 3805 05/16/2018
kern  :warn  : [  467.712824] [  T10170] Call Trace:
kern  :warn  : [  467.712826] [  T10170]  <TASK>
kern  :warn  : [  467.712827] [  T10170]  dump_stack_lvl (kbuild/src/lib/dump_stack.c:94 kbuild/src/lib/dump_stack.c:120)
kern  :warn  : [  467.712833] [  T10170]  dump_header (kbuild/src/mm/oom_kill.c:464)
kern  :warn  : [  467.712836] [  T10170]  oom_kill_process.cold (kbuild/src/mm/oom_kill.c:1031)
kern  :warn  : [  467.712839] [  T10170]  out_of_memory (kbuild/src/mm/oom_kill.c:1169 (discriminator 4))


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260611/202606110923.2d2a1a13-lkp@intel.com


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

