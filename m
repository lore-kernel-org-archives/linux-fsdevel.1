Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD28A3128D7;
	Wed, 15 Jul 2026 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784098379; cv=fail; b=bVKaJioqM3CHeYUp6tAOWaWvnrOdcfEYOwsfX5o2uX5BwvrGyUgP5wlwwsUwCOoA+cDuM9xEpr0CevcX2nQMG+Z9vNxghZyV0x5RkRs0wNsAzb6jgtGzPAI+8pKEGij345m/asyWKElBdUNVTXVDRHqIWSs0ZNSTr3zlpeWAu80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784098379; c=relaxed/simple;
	bh=g4fBG+5uWsKSDM8zlhS/EVm8JdffV9qKPzrB41qULMo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=sqTg8AoXwhZCHPupAs+9Iu/knrj8dnfBfELS3t204x/N+8GEgQ9z6nBdoLaXzAq+izU1Gp9K0RDzAA6HUdfCQZEx6bjpLde3wu4gF7Np9BaRJDpeBJneNRPZ1j99NtMtfOxrOnEkm1HgPz7b5X6KBOepsEyIfizdeBUyCv9CQ6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kX58nf/F; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kX58nf/F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784098378; x=1815634378;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g4fBG+5uWsKSDM8zlhS/EVm8JdffV9qKPzrB41qULMo=;
  b=kX58nf/FLTPtOUCesUNBkaXQFl8FLQbtqK8X0f5ADg/ICC+P5cJt0B3c
   O7a1B/fGGe82xHz3rC6irZxbRPItn2CBkqkNZ91OZgXEnSPRek0NpXQhq
   vbB0wst9zhNYA6130GtBEjVfZ7wKR2W5h2aPiasaNPnARMXNRQ5n1WWZ/
   n8SbzXIJrolTiotcXvt1bc/5082FjS79zEf/gO0ab9U3f1pjC7rsDK3/I
   v1tic65ul69H73d2TEanW+NQHkMtfb2QLKn6F64H0/jAxuOYorRWTX8GS
   uNP1vQCmPwzykwuwDQEGj3SFyDiu294B6hgiQVGAzaaiyvqW2vMOVczEq
   g==;
X-CSE-ConnectionGUID: BSwIPridSFaOSSCI/CXfdw==
X-CSE-MsgGUID: 5mE7ZbM0RAKLkQIZF+hu0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84769399"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84769399"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:52:57 -0700
X-CSE-ConnectionGUID: 5phQFSCuR2i1PYM4TLcA1g==
X-CSE-MsgGUID: rymeAVeKTC644IpYT44ehQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="253467135"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:52:57 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 23:52:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 23:52:56 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 23:52:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKon3trbZ2PuU7ZQiE4IMF/IpeCQaT5ijPMSgFrEWBULnlX0ELiT/1q8mZR5LPA1I4hml2NF/DgO+7MrdcGOYD9Dqt8C8+yd0dEgecpjciID7ujZdbi4MfGfhB9T+iKxUP4HHEKCzRkZOycfpcjz9x/7t0D88cJcZE4OQFOk2R6jlDDKDXM0p631dEpyULPazzxZ7eUdzyqm7cFMtEmjMRmFi/fJezXFhQ57azUa16T90vn3VB0NP+sQaLoeVijKccM9WX8SKskj0btiPwgqb7k5d8J0HI0QYorTCuSvtEk81W3U/8ymubem1t0RHp8rTAVw+QashUICGNvkKvZSpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG7fm6CV5Om1YV8Rp6+Fbl+PshzdnOCIr6Tnq0w0FDI=;
 b=Xh6eEWZMY6PlxvQtAzU1jGQzpXJroq+ORqPBnSimU842EjlZWIEqhL2RP4X9Tgis+DBhWmun6Z9d40fEv9O3gWv2ek3ytaZddCaEVyNnu20tDFY688q3hm1kJT7d4co91nScgQ0lvvkJ5J4G7y1OZ1ngoJD8WrhwjnPcKjXmKnfsgmXow/H71lTV2yMmbRBe4HFh4JU7TQP9AQHfgHtjZ2yuoCoT5eg4pxbWeoXbO/+Nr09l1ka0I4TK9wXYasJN/doYKZVAMpFKn9diYcHhfxC5Suw+wU32sk/PlDJfgGWe2Xtiwv6koh/hgIPqPvPG3KsuUT6+UMZeth8WELfm7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by DM6PR11MB4705.namprd11.prod.outlook.com (2603:10b6:5:2a9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 06:52:48 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 06:52:48 +0000
Date: Wed, 15 Jul 2026 14:52:41 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [fs]  539dce1144: xfstests.generic.697.fail
Message-ID: <202607151456.6ce3f0bd-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TPYP295CA0003.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::14) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|DM6PR11MB4705:EE_
X-MS-Office365-Filtering-Correlation-Id: ab611e4e-6183-4dc2-2a02-08dee23dae7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: nwuK7VzbKJIraivWS8Pu4R1ftZt8LGlCFgLEMRA7g9FHfglVDanCW3wwipcT1g5mhbGFyOtzmeO70KTJFlH3o7cdgq+Ne6OsDBHKCOwjiIATJA50jLfy5AMEDPHutrA1c/3bEXSvk7wEIzBsfTJre68hjD5xD2ULXf8BHMOu1OrSIiaPjrS8wNNha67TIC6MK3dLFNggPEcp59JXrxSiATlCqEheki7FrXYjpykdqfWpi/Ucrun9lwOL7Xj+TQ/HUUn4sYnpEahW/1N0R+5DDkwXEANm3+HITMRhJ/7250tP2VXOg+hErok5Ky+wgHet/16LmpNMWHAoTlVdIqAWZ1+sol+F+NgJf1yW3E8ssH65bUH8Yn4sROdFQTO2GJ0Ac3udJmb5b1aYDWbjNx2dgw1YfNGJh13gwgpAOV7/Xu4SCDUFcIyKojI9MYVn6YoPvSsIcbCbdi+4WLEDqvoImP1RvbzRsVYPRZSn1dnVmxjf0JB4LbsVYT7oF7ZBvRZm3A50QaQi0BKuNNwaaR66iC7jrP0lj8r+pw9yqOpdw8A/DgaITh+H84+khFo6MxmMm+v26AWOsZBr4T2q1xy7S98X3trQ8/IkEp/NHc4ZglJ7YXF4pD0HfyZtVLgFazOm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P5hNarvVrgG0st5l792cV+b3BEHIVyarSr1CfyKBpnq9WoEVsGxLPRIgxRgP?=
 =?us-ascii?Q?APktFyhvjc5PqVjJTVqy8x2TR4lIEkMgQN/ugItLnRLICvPFLrDZOmVCPpSO?=
 =?us-ascii?Q?qLDoVl95Sx5Ra9poSgWrJBVlMJr2G6S6HNz/qMRSY5t7UA9R3lBoohhGTgy7?=
 =?us-ascii?Q?TmrCnXaC3vDCnvEDphnPlk4Mb+jTPZ+pufGCEUoBgOFzjYlV8vw4Z70q+kbl?=
 =?us-ascii?Q?+3mGKv+GLaMLDBLPcuEsPuABNRyUX3Z/quDdTBe6oiT99atu44hr5WNp0A3W?=
 =?us-ascii?Q?kxDca/1jmoJ519Rm6WNnRDf1FG3WYgzu9GBTx4ZDGXANql8fVFZZjsIQPFx1?=
 =?us-ascii?Q?p+nKo7Jw4fCkNHwwoHa+fNyNPkHwJPVyLuw2Yw4jSBPzx4gSGFgoAX+8yBax?=
 =?us-ascii?Q?R9WynxoOBVTyuszhblN52BkQfIsUAShNG04rMfoyFA922v65PPazjRwi/xW4?=
 =?us-ascii?Q?N0kJMja63lKPyWf6QPW00a915pNECEewFz/EB+g7oEsAsuL/uJU35gWGb8ed?=
 =?us-ascii?Q?aCZDW8NKsC1enydhJTOBwFlsI94PQj/bOl/xN17vNpz63lpZ6PZbwfi9Ek1l?=
 =?us-ascii?Q?2cYU1DVAadndsweFlcnJdjAXiBdUjmWexFEwHX/5LZkw2QLGDN2hCvEHYSo0?=
 =?us-ascii?Q?OWQiAWjWwHA8EET/1olLy5JqK9Q8ZXCwevKW+p7F9r4nUoINy07wp9CPtlTs?=
 =?us-ascii?Q?QUaonGGyE7B3dDHKJ39NwuAWQfnFyfZgqDA3v1+6R9nf879bgsoSMpJf9zy5?=
 =?us-ascii?Q?KMXBjwSp3IdnOeymWNhw+30qK2kya22unOZztLl5qOo8wB05b5yNBdUzDPOA?=
 =?us-ascii?Q?jzZvKrcl4Ox9JBho0oHjA33hu+LH8+4ySoEbyJkOVrTexskG3XDWpag+i0uS?=
 =?us-ascii?Q?eoNWyqEIaqoloQRjyAzBIVIUOmurLXvvVZM5elcNaLMQrGA/tln/N3HVlWG5?=
 =?us-ascii?Q?ScPylDgpPXpvr/hFqUnMNOk+28EG9JBrFHlwEVmnpXyIDNO8uXQZ7Ibi+XCu?=
 =?us-ascii?Q?TtJmz1PqsXPhIcQbwc2sk3hxwZBn5t7V9WO3DISolDxlr1ejiacKlv6m9a5H?=
 =?us-ascii?Q?vL4QyvoEN4iWJt1gd1G8u++kH5ym1blzBhm/kNr5K0NWl2i+APGij0rKa/DX?=
 =?us-ascii?Q?ivEqEm9OWSTDISkO0TBCLZlDVbaK/hyQtN0BN7pGAiWMMpWS2bxSGJW92cXx?=
 =?us-ascii?Q?x+hXrQHGCpMtJAArsLmZ4s2UeTfrzwH3vqLooIEv/bigA3NxvcsjJscBbPJR?=
 =?us-ascii?Q?HjhBPxx8zDOwRSxYRIpQfNyGpxSEQa0+4DwzvylsSe3jjZKz5G+rxa6vAnGu?=
 =?us-ascii?Q?MCzPbBpai6slIHm+sUgmVDw/FTSWC0qTl1EazHT2jZqyVyWZ3La3OASZ0stP?=
 =?us-ascii?Q?jr3PEfvboHMxhqiurk9uiSAM3alejEnH5YF9tC2J5VJEik+3H+TVj1Ey1PWM?=
 =?us-ascii?Q?7vgV08P9GuW+syV1+wfrJ/naKGmwGRu4pnjbbamBtsUEZDnaenL9D0pt3OeB?=
 =?us-ascii?Q?Bd9xEXYoTDSM2s08vFe4mO83dGJKagpWpAUjs56zP+/AGqUIc5QaTyZEZX2s?=
 =?us-ascii?Q?teBhg1aeJjMFv74p2dvd3X0nl0IjVNQQIOQyVoY2ATV0hu5eXR8I22/rrB2c?=
 =?us-ascii?Q?Dd565mUO1xNNDEqqBxXLwGoyUIDOBOsrGttludqZdchKWtNk06toVw3srSH8?=
 =?us-ascii?Q?63L+uscWKC3TCjgLyfr6ob+3R+zaWsUuHE5ws98nK8PYfZb/iYPCMfcFmwrd?=
 =?us-ascii?Q?rKItl5HSjA=3D=3D?=
X-Exchange-RoutingPolicyChecked: G40YosmrYwCh94NTiuFJSkFjM73btrABaKkb0i3cxOzaXy40L7l9AEZCAr3Vb/UfGEGqNuaMy6/nHG6QZt8M6g/wVtP7q1XJ1Gmm9Elbzs4YAT5+d56sGXaSX8aK61r/AsoG7j+h7mrdqBI4gCFweihR5v/2zkNvDLI8UGb96Hhwd3XW6AYH+Swx3bIAYebUx8mEW1nuZAsvfYSsSNtaEvPqy5WKHSfzBQJ84Nb34xbeXgVrFn5Ml/kfxgpRHvyBu4244z9CmjjDnCzMMqishnBwntBivLNzsjm/tVkK23zlS1xWKSVW9z1UOOESgj6M2iCEm+u7+fw3awtA/ufOEg==
X-MS-Exchange-CrossTenant-Network-Message-Id: ab611e4e-6183-4dc2-2a02-08dee23dae7f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 06:52:48.3130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4FP4AM5VxSjTlJGJ8+Gm49OJTTmIe+2oei2vq/trmO/XuVjgRd3CF2dZOFIlO1m0IXKpUkoJO+stFLYDU9wowA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4705
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.697.fail" on:

commit: 539dce1144651f7976fa418e618b0b574bf15eeb ("fs: refuse O_TMPFILE creation with an unmapped fsuid or fsgid")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      0e35b9b6ec0ffcc5e23cbdec09f5c622ad532b53]
[test failed on linux-next/master b9810cd75b9fb56a3425d391cba3f608502bd474]

in testcase: xfstests
version: xfstests-x86_64-ffc8bad1-1_20260702
with following parameters:

	disk: 4HDD
	fs: xfs
	test: generic-acls



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202607151456.6ce3f0bd-lkp@intel.com


2026-07-09 09:34:52 cd /lkp/benchmarks/xfstests
2026-07-09 09:34:52 export TEST_DIR=/fs/sda1
2026-07-09 09:34:52 export TEST_DEV=/dev/sda1
2026-07-09 09:34:52 export FSTYP=xfs
2026-07-09 09:34:52 export SCRATCH_MNT=/fs/scratch
2026-07-09 09:34:52 mkdir /fs/scratch -p
2026-07-09 09:34:52 export SCRATCH_DEV=/dev/sda4
2026-07-09 09:34:52 export SCRATCH_LOGDEV=/dev/sda2
2026-07-09 09:34:52 sed "s:^:generic/:" /lkp/benchmarks/xfstests/tests/generic-acls
2026-07-09 09:34:52 ./check generic/053 generic/077 generic/099 generic/105 generic/237 generic/307 generic/318 generic/319 generic/375 generic/389 generic/444 generic/529 generic/697
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 lkp-skl-d03 7.2.0-rc1+ #1 SMP PREEMPT_DYNAMIC Thu Jul  9 17:18:41 CST 2026
MKFS_OPTIONS  -- -f /dev/sda4
MOUNT_OPTIONS -- /dev/sda4 /fs/scratch

generic/053         5s
generic/077         8s
generic/099         3s
generic/105         4s
generic/237         2s
generic/307         5s
generic/318         3s
generic/319         3s
generic/375         3s
generic/389         2s
generic/444         2s
generic/529         4s
generic/697        - output mismatch (see /lkp/benchmarks/xfstests/results//generic/697.out.bad)
    --- tests/generic/697.out	2026-07-02 05:27:11.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/697.out.bad	2026-07-09 09:35:42.782573498 +0000
    @@ -1,2 +1,4 @@
     QA output created by 697
    +utils.c: 948: openat_tmpfile_supported - Value too large for defined data type - failure: create
    +utils.c: 948: openat_tmpfile_supported - Value too large for defined data type - failure: create
     Silence is golden
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/697.out /lkp/benchmarks/xfstests/results//generic/697.out.bad'  to see the entire diff)

HINT: You _MAY_ be missing kernel fix:
      1639a49ccdce fs: move S_ISGID stripping into the vfs_*() helpers

Ran: generic/053 generic/077 generic/099 generic/105 generic/237 generic/307 generic/318 generic/319 generic/375 generic/389 generic/444 generic/529 generic/697
Failures: generic/697
Failed 1 of 13 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260715/202607151456.6ce3f0bd-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

