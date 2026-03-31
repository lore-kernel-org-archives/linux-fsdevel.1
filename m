Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCDD28FC
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 03:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774928131; cv=fail; b=gNeA1idBvmAyD8T/tZVm0EPMquQqb9V18hsI/VdOx90irWJTGI9//cI6+2PegTYHkvgqFyc8xiENrz82Ad+48whHKj9WGba3wJzoEn2NiCGWNCa2htGXNjCOOiLypJyPFge88o2AMPBzDmSlQl/FR+7g9mNu5XjsmUGz5pzRQJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774928131; c=relaxed/simple;
	bh=wdCTmatkIMqNnan6YI3+/usoxd6MBNCqngseH9DXPeQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fZ2x/zmqTNS1XvR5KQvlYSKnIuuwbv4q8kQjD1jmvEyOOIImbnCQ3v1cOAWSSwNSavpr4Kil8BtwBmCEx/voS5+MaHgfdiX1/HXSJIKR3PEx95uakH0s4WBwkp2YNQbc/PUJjUq06JZiDvTlKGUM3MYIMRIbn3Kc2vJhPr5NYlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQN5Nibm; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQN5Nibm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774928130; x=1806464130;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=wdCTmatkIMqNnan6YI3+/usoxd6MBNCqngseH9DXPeQ=;
  b=QQN5NibmlZRADZqTIogTOUjxa/ZLJ2tRw0NfdpqIPGEg6vCNs/doHi+N
   rQGxz/HWS/PPSlUq/W+kF1/8beSP66RbkOkyPdAdXEV5KD1KMeHg7Q/nV
   uNwiSMwn/Uj4eY+1IT+mydJt+UEivrgb4aAzSz3HeBd4frzaZuWFKBOzH
   fsVcPhTPoE0+bGgKWW6JNrlFfN0ETWLjUBeG+bYrjmkWABntiPT3k7f+u
   9A4TJwBU28X8J4j3JOy6CNBMMeO+1NUZvYQXpiVo68p5uFBMdRS9o4mUg
   JvvY5pDzHfSgSc/VXQMkADkLxRK4WEhUaAwkqKXwfXz2heIATWPhgiV/L
   Q==;
X-CSE-ConnectionGUID: gHYII4eRRCCLSfBVh85E3Q==
X-CSE-MsgGUID: afot7RZcQSWPQzzl1YkmlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="74962060"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="74962060"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 20:35:29 -0700
X-CSE-ConnectionGUID: uZmKZ0NHSYOZzf1yfq9O9A==
X-CSE-MsgGUID: 9Ij3+76iTu+4JdO6PY8iFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="230303136"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 20:35:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 20:35:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 30 Mar 2026 20:35:29 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 20:35:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MEbMHmLeoPWoLLKSR5YTQBRxwzfANjdnDc6GTdWNJmtcy1NMKbJKpQt/TNyQU960cljs5rysn3RgX7dgYrHSYk/1A8dBTOZ9ek8LD2a1WYGBglwUJgBWthF8eMHH8eZQxioywZ1JfWC66y/6v32oTN2CoXWG9wYC5bo25Rh2I7KWxS24/YpJ2DxgCvl/GV+uVZyOoP0VUxfrfgJ+KFG/vh5AJR9uLgf+RNeFWqDPxKOo03e6vYVQS4t5klrI0ykolNhUMFcCYVkWvXaTqEpq1JD8VtP8a9pL+ea/DLUvzLTi3qvDDlQcRGgEU2G8IANtZGVAPk8+qk1ypB1vN/+FFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keuv9RAbNUQfpkE+a9tvlTaWtQlr61psAni47uVf3ZE=;
 b=I3fyu1P6O8dyEk/3b0RS59qQnMumJtHnZLRYRZIzcZ7rzXouboVw0GP0VH+EiOIXrakwgbaR2kZpthbOwu2vTNiyaJ0P34OeatE3OHNsS4Erq6dF9KD08msW47cP39qzI30yoGFQBAOhDqCX9X3SlIvf+ISF70/aMkn9QFUVy1Hwsb+JclJWQiwp2shXdcgetXnObhGDc6oLw7dLqIbhkLqq6hMr8YUstZLuVBBBNAuxDOL/Yaf2EYPTJZJmCP80er3XXHddWfGewcRia1HXjqkqyijR5RLK9tuxliNsJtL4G80yqqMGk1EVCW2D/OomMTqynE+FzYcEk+mu+RbFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB2808.namprd11.prod.outlook.com (2603:10b6:a02:c8::26)
 by DM3PR11MB8715.namprd11.prod.outlook.com (2603:10b6:0:1e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Tue, 31 Mar 2026 03:35:27 +0000
Received: from BYAPR11MB2808.namprd11.prod.outlook.com
 ([fe80::defa:788:da96:2f9a]) by BYAPR11MB2808.namprd11.prod.outlook.com
 ([fe80::defa:788:da96:2f9a%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 03:35:27 +0000
Date: Tue, 31 Mar 2026 11:35:18 +0800
From: Philip Li <philip.li@intel.com>
To: Joanne Koong <joannelkoong@gmail.com>
CC: kernel test robot <lkp@intel.com>, <axboe@kernel.dk>,
	<llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>, <miklos@szeredi.hu>,
	<bschubert@ddn.com>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v1 8/9] fuse: add zero-copy over io-uring
Message-ID: <actA9on+WCPxpTXe@rli9-mobl>
References: <20260324224532.3733468-9-joannelkoong@gmail.com>
 <202603281401.HP3uX5G1-lkp@intel.com>
 <CAJnrk1Z=yMy3FSt7wvCDgGCr-NQD4M=na2sAGsRM=KoTH2Nazw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Z=yMy3FSt7wvCDgGCr-NQD4M=na2sAGsRM=KoTH2Nazw@mail.gmail.com>
X-ClientProxiedBy: SG2PR04CA0165.apcprd04.prod.outlook.com (2603:1096:4::27)
 To BYAPR11MB2808.namprd11.prod.outlook.com (2603:10b6:a02:c8::26)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2808:EE_|DM3PR11MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 78782fb6-2618-4a01-429a-08de8ed68cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: xpwM0sS1QvBLV3p7mNSxeucvjghEHNFN2/WVvRm/6FZtVL+My2ZBDw+7ulId5Ir7mLEc/nKFQu2PyT4tgcPbm838gFXp01/+17aQXpd1CmKhz5t3KyVRj9INGJbzVyAlJCYMvIFqs4czAgKs4GLXgh4IkKPbwIF1xHnnXH1c7AU/khjMdnU598NBRHRkmTN2+PY31OIQXWQYgn09ZQp6rOh4WJWkdujU7EVuodHajtlBy56+Agor2UhIPbw0xO+LUiN84iNJap/3UpfJD/HVmZ0RzIecy9v1sMN9za5Q+WjjVlysbMUxawCgQc8piGfPQZwoFKI8oR88Aqgopy6C4G399ZEEI51o9nz5E+Q2ZeAcsKXsRSYjzpmvho1NuDILXcxKMHkn4cD5CcMh0qBcYWgZgDk0Mn2jEM3WdTdeAumfwwTKWFfvuSC7GNlA++pBC7h7pSWizpd213YmOEwxphEk/0jlIYRR8c7+WjhlzkeC03g7KhApgmwK1rGV7fSzFfITBKqO1NZNka8PYalDV8idmHTaOtp/1G7BXeQmVHWiCFLHfGyvmREFpzUt+tJwLdk4C3vedq2YQjrXb1deuamJPC5rh4O9NTXV+ArhA5/uDRKBmaMgqHWXFUnHNknHibl6sB0rDIF1kchXieBjUzpJkCohPKUSySz7iijqVZqaxcSxFasvfemvuNIFgeKlhmC62KTBQFAGke9p3UdzZ2s6hEvGi3L6BX782i++J4o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2808.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXBSMEtsQy85VSthZ2hYVEJBUkNIbVd2SXkycGIzUjYwNmwxWk55ZTIwMGFt?=
 =?utf-8?B?eGR3SDBlZUlMUmEvSUd6K2crRDNVdmh6WHhycHNVVjhhWUU3aFpKakFBOHR4?=
 =?utf-8?B?cE0zVkRlWHV6RHF4anB2T3U2c1RYSGtFcGg3YkhrT013ZVpzQk5uQWlMWWxl?=
 =?utf-8?B?V0lWdGlmcVNObHRyazYyUUxLVVhQZVdlbU5tTmhSY3VqZHRFT3pqekw3aHND?=
 =?utf-8?B?WVNsd3FXbENweWh2Q1NBeVNVYnNYNVlyeDlTZ0thNktsSHN1bktNd1FVMnRa?=
 =?utf-8?B?d0JJdUcxTzZoWUlXT1YxVWxsVTJGcXd1Tkppd05TcnlROVNKN0UxRVFZS21F?=
 =?utf-8?B?WmVPNEttdHE0NWorTzJDemdXamhybmFXbUxFZFYxTFVkZXdWdWM1Z3pvM29E?=
 =?utf-8?B?ajNRZlkwbkV4bCtwK3pQTThhZGdTVXd1ODhoWGVsMFQ3aWNaYVcxVXdFbjBV?=
 =?utf-8?B?UXdFcmcwc1BLTlowMUFnUWNDVlVCVlowS1RReHdqa2hONmQxQUo2OE11LzNu?=
 =?utf-8?B?SG93UWhUWDR1MzFKcXREVU52TmJ6RnJKeVhMM013cERiNFlNWXd3Ni9VS3RD?=
 =?utf-8?B?Z21xcFZMNFhnblBxU1d0UVR6TFpNYXgrRjJPSWNlL0dBT213UVdDMHd2TXRQ?=
 =?utf-8?B?d2hNaXJvVzl0dUhaSmxaR09STEdlY0M4UEpzb2gvQkxScDgrSk1JL3N0V3dY?=
 =?utf-8?B?a3lRZkluNlU2RlBSTFpHc1QzKzVCY1dSRGM3ZVZqSlEwc1RPL21DOVBUTk9y?=
 =?utf-8?B?V2NwbHhiYklMK1k0VnRVR012TkhaZDRWRVF2ZFA5eGR2Z1RDakV5YjEyVEJZ?=
 =?utf-8?B?dUxnTDhGeEZuQ1REZjdnLzdCZUF2S1d2SnVISzUxdTRDWG5vUEo1R0RNTCta?=
 =?utf-8?B?azg3eWNVNjBWcHhyY0ptcU1uKzZZQWNyamNmME9NSWFsTC9nbk1jcDkzNVVQ?=
 =?utf-8?B?ZGxId1FPRXV2VU1wY3h3MmxmaWZ5QmtIdGtzUUd6VlFRREhBc1NOZXUzK0k2?=
 =?utf-8?B?STMzaDJTZ01KK2k3UFJDVlZHWDlNZEJxcUwwUVJMNWpyN3JUekVWeVB4ek9q?=
 =?utf-8?B?NFhmcEF1eHNESmZnQW9MdEVPREdTQ2RKc2tNVUN1Q0E3NnBpQjFjbkhzcUZ5?=
 =?utf-8?B?NGowNVR1RmZta0FrekZFR21LSGg3SitWWkRKRUpDWVlsM2JKNmN0YXdMNHV6?=
 =?utf-8?B?c0VJclYzNTdBSG5iMDhwKzA5SzIydkx6eTdsUC9IeVFyUjZmUmQyQWozc0xh?=
 =?utf-8?B?c1hOdEdXNWlIaGZxMDBPdlRFY2JSaFUzQXJCRGFZNFYzeUdGTkVmN3llZVdq?=
 =?utf-8?B?M1NkeVM0WVFsUXRnY2RITU5YOUhZcEFPMEJYMUU1Q3FtbmZsZ2llVm9vQ3JI?=
 =?utf-8?B?NmFhM2hkM254M1djSlRaV3RDUXdVeUNSZDU1Tk5sd2sxZm84Rm0yTVBGWGl2?=
 =?utf-8?B?ZCtQd3lDQ2MrK2dnOVVudXErWmo0SkVMcjlJQUFUZWxzL3NxejVQQXY1R1U1?=
 =?utf-8?B?VFU0VU44VmRmY0ZUbC9jcm1CanJ1c0h2bzlpaHlDMTVibGVPSjJLOE1pTi9r?=
 =?utf-8?B?b2NjWFQ0N3pFWk9BbFAvd1ZlUFlTNU9ZMDhRRUZ3YVg1cU1DZW5tbWNPSlNL?=
 =?utf-8?B?TmZ4SEdQbnJNeXBOSFM2M2syTmFqbkhOaDNkNUtJNDJ6a0NuSWgxQXd5M0Uy?=
 =?utf-8?B?a1RyRlB6VDJDYXBxcTk1UVhzTldDUXRadGc2L0VhMFpGcnArekJIUVZLRzBS?=
 =?utf-8?B?eldQWjNka1R1ZFFad3ZHTGtRLzFPMUo2emVPOVpuaDNRM2JxZGJHYURPVCtD?=
 =?utf-8?B?cFBOQlMwbTdaYi9vZ1Z1MDNRVXVqRXgzcDRNQ0lURlhldHNIb3pYYnpzazBU?=
 =?utf-8?B?UDJzd0I3Ny9Ob3JZdjV1Vzc2amZtbjcvcmI4akZrcDdueU5RdXgwT3ZYUWQ2?=
 =?utf-8?B?SnBMSVZ1UExSVjZ3U0U5YkVpalgrVm8yeEEyL1NYYzBWZHhIODk2Q3ZWMmF6?=
 =?utf-8?B?bkxCKzdvK3N4Y2ZqUXhlaERrVXNoZm9sV2x1Vm1YVjAvaWVYZkVwN2puTXdX?=
 =?utf-8?B?WjFYOGoyaDVuVDRWYU1RVDZYS2k5VUxpTmlrZ05wRlQrOWZwNGQ4MVkxVU5P?=
 =?utf-8?B?VEFNVGpXcEJNcXVJVDRSamVwMWtoYWhNRGxkQktRLy9TVTF2cFBPSVRsQ25z?=
 =?utf-8?B?UXZISHMrS3lPQjJ2MmsrMG9jMHgzWmVMMXhUbXZSY2k2d0dEalVBQXpPL0pU?=
 =?utf-8?B?SWJSd2wwRTBXemltVGdnc2FWUkovNXc1S1lsUmJtM1VvbFJyWTMrR1F2SVZ1?=
 =?utf-8?B?ZGZmZnZsaE1GSW5oazZpK0VEYlBHa2k4cVNBNUg1eWtNT2tGcG5SZz09?=
X-Exchange-RoutingPolicyChecked: Hbya12lKUAwiVYXj8Gfo48jTbB1GVKLpY1+vEeD7Pbjm8aiqHc7Blobhmanw1QJ2pGdwGi4z1xjrRCfwMBJre429HDnysDmI5Eg73eiKsY/E29acw2iSBRCdKsi5kK/+CjYX3PNBzB8sQZ3xBskgQChwIyD84eLQ+WBYs8sp1ehZL3kbkmaEw+geouz3BjOQyRARsO6KjlzIWqZZfrE3fK3JXTeoftSGMXbT3Nm8Ox7mgvxpqnLyrvTWlgxZkjM+8rfGzREmEO4NhU2TGg/aLDvJ5LuYjc81NgKPP9eWXDCN5JNoz1ao1bKt+swItnoOFAAEJa0IIKrqqk41p8Re1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78782fb6-2618-4a01-429a-08de8ed68cc2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2808.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 03:35:27.0171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wty6HLGxJyFJjri7LkXnTMlt+owWiye79Yl9Ao7RHoDqUUdeqduIZ76DUKGiPBeSJvs9STfGh/EqJ++SvUhVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8715
X-OriginatorOrg: intel.com

On Mon, Mar 30, 2026 at 08:43:16AM -0700, Joanne Koong wrote:
> On Sat, Mar 28, 2026 at 6:54 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Joanne,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on mszeredi-fuse/for-next]
> > [also build test ERROR on linus/master v7.0-rc5 next-20260327]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> 
> As noted in the cover letter, this series has a dependency on two
> prior patchsets submitted to the io-uring tree. This series is for the
> io-uring tree, not the fuse tree.

Thanks for the info, I will further check to see how to improve the bot as
so far, the bot can't accurately analyze the dependency from cover letter.

Sorry about the false positive.

> 
> Thanks,
> Joanne
> 
