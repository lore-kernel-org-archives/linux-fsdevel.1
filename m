Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DD3379EE8;
	Mon, 29 Jun 2026 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722771; cv=fail; b=f9cHasfcn9eA57LaQ1f2710n25Phz92npfIuGBzkut2n4aRZU3wX/vP8mjg/2+5vv7x8DeUJGk03TZ78MEnjpRCh1G/W6dnqv9cKFHwyiqzvNh1PtbN3R1yabST6QP6IRc9AB/efYImNSs/ATsyvNGnwv08h7QY7NoY2YdcmhLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722771; c=relaxed/simple;
	bh=lGGxIsBGp3p5gRZgvUKrKl/gGxlUaxlcmWUHO4vrB6M=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=XGM7WdSwV6qAljA3v2WlOTR1tT3e/8fMcOYMgVBxbK0QuVk5nYMyKvIrGn+1V0CB1VSo2hZ7PzgwiAlpv5feyts38lHxJkAi/qkoX7VDLtgNgvTTuIx89eB6o79+xaqyGtkjF4H3taw21Qf7H/PYoyypOBADEhoeEBdpCwT1c3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nMds04gR; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nMds04gR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782722770; x=1814258770;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=lGGxIsBGp3p5gRZgvUKrKl/gGxlUaxlcmWUHO4vrB6M=;
  b=nMds04gRTNVpx5qyY42KwEbH4wZR+67dsDXGsMxAB7D3N1DYdiqfei6L
   8nteMtsgZh5hciC9lU34ZKJEt6Y0gQg6n8r14ey1XxVMaY/WYqVuGaxpI
   szGg/LDeYv3jeYsCZ0OB+dN1MUOoL1GWVJ1wJRpBjfmmlwxp9W/2zFXEW
   ieWA0V9f3GpxvRqY+zAjQO4reAqqKCIu+HPoOXD5OBnhgHWZWugnjqxdk
   Cs/EEId7tLv4ym8EfaK0VOODykAj4zY2l1HgRETAKqfuqJr4evUNq4TWA
   mAMYquAHUQRpsd6+d+ply+C+OqM3T37CT47ygRFG26i7dvzsmgI1IN1yb
   Q==;
X-CSE-ConnectionGUID: UIV0lq99QSe4EZ5RMthTjQ==
X-CSE-MsgGUID: UAVOtsSxQBqIeij31xQztA==
X-IronPort-AV: E=McAfee;i="6800,10657,11831"; a="108946130"
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="108946130"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 01:46:09 -0700
X-CSE-ConnectionGUID: voWCFmfkTNCB/G+1KmXxbQ==
X-CSE-MsgGUID: vkVHmWHOSi2z4Z/GygY1/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,231,1774335600"; 
   d="scan'208";a="252537529"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 01:46:09 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 01:46:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 01:46:08 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.21) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 29 Jun 2026 01:46:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQSvcTGeBeMFqKpBLXmPHqvo5nyLfhZ0Hsb91WGcWak22yL+0/kLl1M3pC83W/ZU05I4ZYEs7m93Vxk3oBbBo1Qb6REiFkrDJwf8iS/qM/ss0kgO1BaejSqbQyc6tyW11m3Q8w1aThYZu+qvCPM0MKQCRjakk4ww5JvTmp0G2QRWSpyjHVNug+vXiJiPS+UHufucYTgKWj/rds3WS3eVnPiopEtTZ6evOURP05rf+rp8w+pSS3aP6BV/KTrWwogF42/q1TxLByBCviUg72Kie+f+wYx8M4mAaKhGROEzp/+4BdXcz/OcbQh0v9Peh5oxZCXaDP00PqwvW/7MD6TzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIr9goKhFWmZbiUzU5dbrzSyhrKWcWzrJihbPs/Qu5g=;
 b=E35bD1f6FIlN3ox4FV7SIuxEwXMr7AcXVjHuj0+xbiUFipl0W5musxA1eP3yR7ClrSMw2Cy6TUQF56XrEho5ikckcI5ASEVh7D5ibu7gZBgStzetUddwWPZoF9OOmuUeC2gEV9P9czIWkKJ33SHvjGUoFKhLoOKLQz+IdCB9O7emoxZzfxKWXyQ/JIEPK+ZjKO9xvemh9LFE/MaRxkF22FH0brPzJNU5IG7KbVygGQveSHt5vay0n6usYh1Wf5UPS3RvIhr0aIIkHbkX6L41MJC/SH0LibAC+TbHvmkCW+2ztVHwkzxYC0tv3a81578Q3cxfcfMR8o7KCuI6pDrzTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by SN7PR11MB7115.namprd11.prod.outlook.com (2603:10b6:806:29a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 08:46:05 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 08:46:05 +0000
Date: Mon, 29 Jun 2026 16:45:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: AnonymeMeow <anonymemeow@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <ltp@lists.linux.it>,
	<oliver.sang@intel.com>
Subject: [linus:master] [fanotify]  82c6dd2047: ltp.fanotify21.fail
Message-ID: <202606291514.594c4370-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TP0P295CA0059.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::12) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|SN7PR11MB7115:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c37ad7e-e081-4f3f-dbac-08ded5badb3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|3023799007|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7SQNVFEZEE/Oh+PIvoM3RQbDY6cyzmKU15MqSOdwOscuCsHI7dQDYTyoWjtZ0rk+iuNB3eai7c/dFirKml3hytpNZH5xbdh7m9VUMBuUlEOtUOxlHm2KKUSTHFHvhqTO1/xswQ5Pm83eJshae5s/9A5sBYfsTWmHRKiY4Lu3+K+UyOLMoYe5eHA7wHH2FC+a9PKSO+9EZ1rwYaWps9kmvFfNJPZkoZHkWec+F/PDCFENX/b8oHiFxUi7axuyTL20BGgntatzFqz0LUrS4gzcpdxDJajup0VE8jcw1pc7F+Mmdi42ds+sG6wiq5N7Mftk/lhAKxT8ThL/WTo+Kqp2qM84/7E3C6GqQt7fhLUL30Wl+y4wVwH6T11N10H0vzkS+M8v9PMZopkHZW3QXodsvYlCzobpo6lCB2atRdluIkkgguITRiUpbfxxN2mMRiIsoBTQVOMht6JpT2iXCewuWuRPmathYhBuGGIsQKrhAMF+pdhTFWDQv4HqBXsxuf6YqLaooYKaSEwaxnAEsPI4c7mTyYtCaAKfyiLpn7Vh3CCnCUA70JzqRZHkDQmibXOSmrJOTFc1pPDhHC9ZqlCVg65YTvW2UccdkUK3K7GrxKFIyTlZZzxmw3Um0MPm9nFF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(3023799007)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUEzS245QVduQnowdXJKYW1TQ0xSZE5oYkZNY2cyT2owM2hwSTB0blUrc0ll?=
 =?utf-8?B?Miswb0hGUnA2Wm5NTHhXVGJIL2tlQmlGd2V0bzdueTZDbk5HUVpUckhHTGtY?=
 =?utf-8?B?bUFWaExrZWRpUUNCL0E1eG13d3Q1Vithb0YxcW5SREk3bDRUOUphYlJPSll6?=
 =?utf-8?B?U3RMKzhsNmhLM0M4OVA0OFFjYi84WFFRQ0JuU242Y3dLVUZGWkFSY25KVmk4?=
 =?utf-8?B?MllKT0RLZGNGVEJVRmNlZkxhd1drR0s1bk5XNTRTTXkyV3VXYnZ3UDRwaXNL?=
 =?utf-8?B?YnNqa0tNdFFuMWJFVDM3VmRySUtlMWx1dXhFaS9PS1AySENXd0VKTkxkQk1F?=
 =?utf-8?B?RXFzTjhFZERaWHlDTW1pMlprMzIzV0JmcmM5aFBNSkljRWNhV2NKZUd2TUNx?=
 =?utf-8?B?eURUNmY3UjlvMVRGTmFEVHF6OVRseGt3SUhCRnZBQml5ZDdtZklSSzd3OTc2?=
 =?utf-8?B?ZGYxVDlUeUV0Yk43N2YvM1NXUTBSRjd3a1BBNVJkcU83aTJmdkhZdnNpbC83?=
 =?utf-8?B?aDlsbmNRWm5ubFNqeHJ4bjlHR2M1RHRaOW1wYXJDSEZHcjdZZTA5cjNhRDVI?=
 =?utf-8?B?QWFCOFdRVmJKVm4wRUxKeGMrSEE5OCswWFVvL0w2SVMwUWRyWXBiZUVPdHZk?=
 =?utf-8?B?WXp2VFg2a0tkMzRGcElqbXF3ZnRoZytVV2tEazZ6VVRra2FuTzIvNkx1OW1i?=
 =?utf-8?B?aVc0TzJ1MnR1RVlKNHFaN3hZQlFZcEgrWEh2NlZLQjhXWGJNalhCaXY0QWx4?=
 =?utf-8?B?OWNUb2tjSmY2WVpPZGZuQVp0SUhIdmlhTHNkc1dtbjBadndPc3VQdWFWVDMz?=
 =?utf-8?B?WEFJQ21Nd0E0aEFaNkx3RnNBVUs3ZXlQMWtzdnMxSjZCSXNNRk9HVUFMVWZT?=
 =?utf-8?B?RlpROVMvMnRydzNvNGRxb3ZuTGpLRUVwbko1a3Y2RWg1R3VNVHoxZ2ZJOUdx?=
 =?utf-8?B?dHM1U2xVRTdqSVVsVXd2cU1oT0ljTUNQQ2lSQWxZRTJSUDB6VHhJRWp0Umwv?=
 =?utf-8?B?OFNSRzU2Nm41ZGxydU1xbTE4SGJmM3RIaHlYaUVEWXpsNjRReElEOHpxVDFD?=
 =?utf-8?B?VXNVWUgwdGFjSGk1OGt4ckVCNEl6bDU0bVh0VFpEYTAwWVNia2xxZFh1eDZ2?=
 =?utf-8?B?dysrZVJrOFpnV3I4NkJyeTQrWmU3bkk4M25qYWZHbVhjTXltcFdiNnFmN0xy?=
 =?utf-8?B?RXlvdFVPdys0bDYyRHNXcDZOV2xrVUxxUUQ2YVZXeGs5TmxvUm91eFpURElo?=
 =?utf-8?B?S201cUFmS1p3SzBtNkRhRkRTMHkrUm5KM3lyaDF4ZXpHcURpa3J5cW9WbFEr?=
 =?utf-8?B?K0tIaVorZDN6VE5ES3poTHBUV21OTGRBdXJmUE1oY3FnTC93UWhMNlpJbVRC?=
 =?utf-8?B?a2ZGUGZnYzU1TnVGVFUzaUJYWUc0b0lwTnFvNFRCQ1JHeURCOHEvbHZrdHo2?=
 =?utf-8?B?YmVCaW92QkhiVHNwU3QyWndHQVFFMDdrMFQvdWUxc004bFBLQ040V21DVGV5?=
 =?utf-8?B?bGljNWY5NW5URmFUNTQ2WE5wZzcwZ1FCdjQvck9NdWpOWHBNWFdUSDIzRWZs?=
 =?utf-8?B?ZnIvNnlZTi9RMXY0eHhtUCtQODBranNYWExpTzlYTE1ieHhVb2loM0RqbW1r?=
 =?utf-8?B?RDFsckJHRkR4SjhjZHVKR3B5dWVaakF5cFpMbUlDYjk2eHBMTXFXVkJmUUQz?=
 =?utf-8?B?QVErOTJKblpaMXZlbkh6VlYxNzF4NlFuWWhMOG5WeUFuSlA4SG0waTdncitZ?=
 =?utf-8?B?NWZjOEpVMyt3Q051RXkwMktKRFZvMUZqOVVPSEROTis0VTRDcUxBQzRiSGR5?=
 =?utf-8?B?WEZiSWFXU1VreForZERKM2Fub05vT0pKdS96Y09UdjI5dHN0aWlhT01hVlc0?=
 =?utf-8?B?Qm5nNVlyMmdZekIwM0YzcVAxbUI4RyszZGFXZjF1YTVtalhnS3gzV0F6ZjFU?=
 =?utf-8?B?ZzFYUFJMd203N3hjWGtCTlZna3RrdUJtUUxzbFM2NW4zdnpsdmMxZXVLOHlW?=
 =?utf-8?B?LzZMaFNhNXl0RitxZm81ckdTVkhQcFlWZjRwSGpGWjBGYnZ5VDFFNXBGVk5n?=
 =?utf-8?B?d2E0UTUxMkhnUU9qVVJOTUc3aHJNNml5cnFQSHJrQzhwV3BtVTRMZ0NhMWdk?=
 =?utf-8?B?czA2NFB6Ri91d2xLUUpKdFpLN2xzSC9UTEpCKzFubVFpektCc3VpK3hZQVU5?=
 =?utf-8?B?Y2RidytwaTZXRk9OOEM4YjlOZmFYNEZXdjh1czRMRlpjaG8wU3h5Z1lKYWFR?=
 =?utf-8?B?cUtWQ3pIOHB3cE5zK0hsSlExTm84OFJmajFXcHZSRzhjbU5xUk1mdmJRaXN1?=
 =?utf-8?B?WkRnd2xrQzlaV04xOWhZM0RFUStKOTdiN3lWbGx2M1prMC8zRGliUT09?=
X-Exchange-RoutingPolicyChecked: KCSYIQJcFR8Sz2R/UaY5h6OuJf3CSXaOAB6BUH46NeQjXOD7aTrIbUD2tSh0fJ3n069nlMGqSToxCkDYQk9dJoDAromZPG5Gj/Z/RT0LKvhPntpHBCxJ/OcXthnnDQgmUG4WP3+ac19YKZNeNG4fF5N6chZ9TJwUls6aYcrvGJLA8mnuv67AgkEk8/St+I5R7XUalf7tTfFrV1k8F4cIMzsFwDg/waov1/uofCw/ElCKVM3e2icFBvgSnG/EhOnl/5cMYdVLGt93DKQlpgHL1/sFu1KQ3uF+8O8WL6NdvQakW1a1/hNL7SyuMfJXJYl78m9VyNbbiSnFHxY6WtAdRA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c37ad7e-e081-4f3f-dbac-08ded5badb3c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 08:46:05.3056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +G/kjv5NJhpN9Jmb3lvoEl3v6QBJYtyyt6uudUBcfi0q7XcK91NqZATN+SiMvlswvHliQY59OZ2VOynOgkzflw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7115
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "ltp.fanotify21.fail" on:

commit: 82c6dd20479bb6a9625e1d63a650c3be8865e2db ("fanotify: allow reportin=
g pidfds for reaped tasks")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      5a66900afbd6b2a063eebad35294038a654de2b0]
[test failed on linux-next/master 3d5670d672ae08b8c534b7beed6f57c8b44e7b43]

in testcase: ltp
version:=20
with following parameters:

	disk: 1HDD
	fs: xfs
	test: syscalls-00



config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (=
Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202606291514.594c4370-lkp@intel.co=
m


=1B[1;37mfanotify15: =1B[0m=1B[1;36mskip=1B[0m | =1B[1;33mtainted=1B[0m  (1=
2.585s)
=1B[1;37mfanotify21: =1B[0m=1B[1;31mfail=1B[0m | =1B[1;33mtainted=1B[0m  (2=
5.438s)    <------
=1B[1;37mioprio_set02: =1B[0m=1B[1;32mpass=1B[0m | =1B[1;33mtainted=1B[0m  =
(0.037s)


...


Execution time: 9m 29s

Disconnecting from SUT: default

Target information
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80
Kernel:   Linux 7.1.0-rc3+ #1 SMP PREEMPT_DYNAMIC Fri Jun 26 20:05:34 CST 2=
026
Cmdline:  ip=3D::::lkp-ivb-d04::dhcp
          root=3D/dev/ram0
          RESULT_ROOT=3D/result/ltp/1HDD-xfs-syscalls-00/lkp-ivb-d04/debian=
-13-x86_64-20250902.cgz/x86_64-rhel-9.4-ltp/gcc-14/82c6dd20479bb6a9625e1d63=
a650c3be8865e2db/0
          BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-9.4-ltp/gcc-14/82c6dd20479bb6=
a9625e1d63a650c3be8865e2db/vmlinuz-7.1.0-rc3+
          branch=3Dlinux-next/master
          job=3D/lkp/jobs/scheduled/lkp-ivb-d04/ltp-1HDD-xfs-syscalls-00-de=
bian-13-x86_64-20250902.cgz-82c6dd20479b-20260626-11320-p5g804-0.yaml
          user=3Dlkp
          ARCH=3Dx86_64
          kconfig=3Dx86_64-rhel-9.4-ltp
          commit=3D82c6dd20479bb6a9625e1d63a650c3be8865e2db
          intremap=3Dposted_msi
          max_uptime=3D7200
          LKP_SERVER=3Dinternal-lkp-server
          nokaslr
          selinux=3D0
          debug
          apic=3Ddebug
          sysrq_always_enabled
          rcupdate.rcu_cpu_stall_timeout=3D100
          net.ifnames=3D0
          printk.devkmsg=3Don
          panic=3D-1
          softlockup_panic=3D1
          nmi_watchdog=3Dpanic
          oops=3Dpanic
          load_ramdisk=3D2
          prompt_ramdisk=3D0
          drbd.minor_count=3D8
          systemd.log_level=3Derr
          ignore_loglevel
          console=3Dtty0
          earlyprintk=3DttyS0,115200
          console=3DttyS0,115200
          vga=3Dnormal
          rw
          keep_initrds=3D/osimage/pkg/debian-13-x86_64-20250902.cgz/ltp-x86=
_64-5ccf816f5-1_20260531.cgz
Machine:  unknown
Arch:     x86_64
RAM:      6898364 kB
Swap:     0 kB
Distro:   debian 13

=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
      TEST SUMMARY
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
Suite:   syscalls-00
Runtime: 9m 15s
Runs:    188

Results:
    Passed:   2339
    Failed:   18
    Broken:   0
    Skipped:  45
    Warnings: 0

=1B[1;31mFailures:=1B[0m
    =E2=80=A2 fanotify21

Session stopped
/tmp/kirk.root/latest is not found



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260629/202606291514.594c4370-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

