Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90A6379EDF;
	Wed,  6 May 2026 07:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778052206; cv=fail; b=nH9lXcxG7rKH8PEV4jkuZHTbgG00k8vOtwLXFlqfYOrMx/XrZjS+2Cc+y05fmj4KRBbicI+Jc9PFSLZVFTg7+CIVAeyStvdSNLKrGmf74fOudxkmiQ/WvWAWD+q/VwQy1wnQYc9PZL+KKDRc0r9KQUPVChesh3Fg8UymW1PubyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778052206; c=relaxed/simple;
	bh=AWQ4k+e6JgFh100W4mqGRrm9TyvkDf0oXNdv69rA3x8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=iL4vYsKVvO6mr40T76B+HA5GlmxbKtvFfK7rffPhyQQ/Nzq/nWJlk7lp8A3ulQSzdz4Vbay1HM0xabmiXjDzoDHmtQupOqDYk1CneHq28rgJD7B/lWLt/dTCiBMYoMo5BJHJVpQj1pb4ZH1UDB386VlAPUp6BqrMzqJa4/ozxiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eKPPSqIv; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eKPPSqIv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778052202; x=1809588202;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=AWQ4k+e6JgFh100W4mqGRrm9TyvkDf0oXNdv69rA3x8=;
  b=eKPPSqIvqvWSP7ofHoJmZimjRLEJg9tCuPierQJVUOlcRGA0c/w6/sV9
   CDiDtHe/TLk2WpFL8435JW2HNu7TGixMeajSV6kBH80OWLTPUY5jbxgBF
   bZBIsQHc7utAEwOPp+R0Kyge6aY58O+4GT1aB7cUf84pWkeMvfM/55kUp
   5PxJpQ9csKi3iu9P9PyMMvXJhgVsLKn1c6Fbj21xW/IR8e4NOtgRRIEBB
   6rYgSb8GDUW72LPrB9CMN7ISv0LwFugchzvCu23BsK7XZtBHyD3BD9DvE
   clF3ikT9M1AVUJfwIBjQZjgO2SYLge2ScDvl2Fk9g14owXwWZBR2e9ZTn
   w==;
X-CSE-ConnectionGUID: 7m9jFITcQJKhylvJoCltKw==
X-CSE-MsgGUID: 9iJpptibTAGCsy8Exm/5GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="96545447"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="96545447"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:23:21 -0700
X-CSE-ConnectionGUID: uwPB9c27TTqTBMUU6QYmRQ==
X-CSE-MsgGUID: hE2HQ9NSSmO83E1O7/bfWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="259753928"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:23:20 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 00:23:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 6 May 2026 00:23:19 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 6 May 2026 00:23:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bro9MZNrKMFD2mZxobQUcUGodWl2Y6tI1aXpAlnWdUDE3JRmr7a+TJ8nkaV079f5ZxpBjI+/KVHvSrQradhSMzqJy51lupK4jNfR52an1+X4x1bj3rgq6RFeFwm/B69WOeKwzhHXNYc8FhrxqNOibT45OKLSHBHjm6Zkx3RPBXeV8gVtF9IQaOnSQ1h6CiMl2rNW02dnj5KivP3PLQtWd1SdN3sOAb6kyTHBtJI02N8jBLjwUiuyCeLypuKbtzbkXOodtZJe1VrnCqG0APufXTvnAmVT9/C4rhlzIDnU3jRvoiYTDu2Zx3gLUtvfeM80aiISSOxth23HxYIyRLsVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4qnUA1X4lV3vay6ZsPOg8wCvOcmHb7Q/V2vQLRbVIA=;
 b=YmAzFZ3+U4nuNVgsY+tRr6JWE91szofgkJzWCkF4Aj1raTh0k4/gNhUlqv70L8oQEDOmMEp6DVIGA0V5d5RK1bnXR0ucce0oYh4FOqo3kqCp8TLvqysUQpxl31zspzI0jlzuw38c3qm6y/nGuNGTczFybNhdi/cz9V8CvkG0pakPif+D2JjupaNTpPOGQEmoWN8M9D1kxn8Bm2D6/hgOlC5nTEKOz1v1okbYCGmA2adnw67Ix+KQWNwaTicDbfF8ic0mSneKWx6Tebh57HGjuWE8J1sKVLDgEdfj4wsdYvqzzZeatR0e6zjkitdKjd/kAkXtVZrVsgnRGBGAsYdbbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by DS3PR11MB9794.namprd11.prod.outlook.com (2603:10b6:8:363::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 07:23:15 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 07:23:15 +0000
Date: Wed, 6 May 2026 15:23:06 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christian Brauner <brauner@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
	<linux-fsdevel@vger.kernel.org>, <ltp@lists.linux.it>,
	<oliver.sang@intel.com>
Subject: [linus:master] [xattr]  dc0876b984: ltp.fsetxattr02.fail
Message-ID: <202605061511.8611e3df-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|DS3PR11MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: c31894a8-4755-4980-0945-08deab4056bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: cwmw2t9lPvvHSxjxGReBfKB4ZdTcnN0btq131dj1pgBIuevsayX5BM0VSuHZ3fKA41VUc8hxNhPJFo5T1sgvx7NXubczofV4Soy4U4rx8i9IiYyrdpeFe64oTY23BGUBx/yuUXhSipLMDArgac5fMklC2NHtiMp8Xnxdjwpw7NmE9JclLydbI/8JSBT52YoX4DsL3KE8R5HUGsiGK74LUq35zGmaPwWq94+KZOM+iYeeZ9JgQV1EhVXZA5fbYdV4blKNGGf+Jwohpw6m6y1RKreei+THpbQE1KJXGh54mEDyh89sALa0lkGBNppd+ByUgZEMTvua5vydinHf2jzHPn6bBZXJV47SCqFCtjJU0VnQ45OcEHzjdVz4yEA87+8JLhtGKNxmwGx4fkHooQ7+A6XZZVvMrC2Zt6iWOXrmVHk6+ZgcxHryr0VIaMMO8EgSWWAi24Aqp+RHuXQDebMUH80WzY1FjtVzXb4vVcTAUNYRiM0Tu66f61CanV9rdZfnR0ZdbR8UH/JXNlCDNU5IwKpIyuquGbLIjcCaHXyIhQrlTx4IUiq2EIbfwechvRHnnfJWBTtP7AN+0xOajAl1aAmvW/HIjBJADHxqpuicfA+nWTbCBu/+XuFpbsMeFD8+iKBgFeJG7aJij8O0OHU2Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aTJZeEQ0aWlWN0FqVmt0ZTZFTkY5dU9WYjN6NFBSM1pNNEgxVFhDWDNzMzho?=
 =?utf-8?B?akcyZWJkaFZUaTdTcURna3orK1lNUEsxMmNiN1NWbExDemJVQmZ5RkR2MkdI?=
 =?utf-8?B?YThiMXZWeUc5L0NWRUdzMGhybkhxNkRPdk5zem1BeXhXTlY1aWMwV0dBVS9q?=
 =?utf-8?B?dXN3NDBIcDlwaGlSZy81Q0lyWmhGTWsyZExkQmhEVnBxM0tialFjbU5mb2pT?=
 =?utf-8?B?anFhcHJZZ25IQXFjVmlTSVpHeG5xZTh5WGNHejBFZUg3QlY5c3daY1d0aWRI?=
 =?utf-8?B?dWtLZmhsTWE4RlhvSTYwaE05YnFCQ2NMME5HSnNGZERkWnh1SngzRFE5RXUr?=
 =?utf-8?B?NE9OSGRpTDhLamRnNVV2eForWXVpdHVqWnBVL0E5NTBWSXNZMkpuRDJrM25l?=
 =?utf-8?B?WloydWxtWFhBVG1jeGF3S2wvK25iRzFZazB3Nml3c2FrVnp0eTN3TE5waGRp?=
 =?utf-8?B?OWhzZTFqc0V0T2lQRG9mQ0IybGUrS094d1ZFRnAzcStnTlVpV2xqUUlzOE8z?=
 =?utf-8?B?RG90N3huRUtXdDNzUmFYc2V0STBZcEgybGlrbzNsbTRVdlQ2MnpMditHSDRk?=
 =?utf-8?B?TlBqNFZ6emRVLzBSSW56aE9HREJGdGhuMUU5N0hCazRhaDlvNWhqVUxOTFBF?=
 =?utf-8?B?SEcwZ2YvSEsrSDlJTUI4VkZuNkFDL25vWFZMWkE4cVFDNSsyN0pQTFllTFN1?=
 =?utf-8?B?cnQ5bkJ6M1crbXVNME16ZnlxaTBZa2ovSEhvK1YrSi9wYVJSbTlkUFlYSFd1?=
 =?utf-8?B?S3JHTlVQNExKczR3anpjWmxSZk1hUUIxU2ZDUklSbUxyVUk2a2d1NURpV0c4?=
 =?utf-8?B?bzR1Q3pIdmVjMmNDajlheGVsNTNBMTg2WjZ1MGhsS0dhTnJMMkRudmFxL2dK?=
 =?utf-8?B?N21iNW50bEQyd2E5L3FaSVk5VGVvRlVrQTI5a21VM3I5NGxvbGtMMStwakpy?=
 =?utf-8?B?U3hOTVhoY09kTHpSSEtzK3VWY3RZTVJHd1gzTlNRYktSdU1qSkE0eXhQRjRr?=
 =?utf-8?B?N3djcjBva3dMVUQ0N0pTei83eUg5M1hsY0wwYUN4YUVXblFaTGpzajJLUUNi?=
 =?utf-8?B?bXpQTFdkMTl4Y3kvMHZXVTRYcDU3MHMxcGVHclJwZFdCT2ZjNTlNWmZRdmZw?=
 =?utf-8?B?bS9nWW1Rc3VNbGQ3T0lHODU2WVRpVWlzNUg0N3ZIZjdPeWxaMWVYZng1eXpW?=
 =?utf-8?B?OUVUN3hIa2E4OUQ1UE5ZcU4rOG5HcDEveGxDMkZDdGtlYUV3b3p5OWs1cnBv?=
 =?utf-8?B?aTMzUGxDdHB4MlNGcGptTXJ5WUJpTVkwZ0RqRmhUd0hvRzdzVU1pbUZpZG5Q?=
 =?utf-8?B?dnVnUlNWVzNwc1pXY2gzaThyOVJjNmhaTjN3MWMydXhTZkRLWHh1eGE1alRm?=
 =?utf-8?B?WVN4NWx0Yk5CQ0FiajBoQU9uZ0dkTlpaam1vTWd6bTJPUUlMK0svSFNScjdZ?=
 =?utf-8?B?ZlNEVkNjeWpnNUc3cCtpaVQyTExtbmN5c08zSEs1M0duakFxMllGcHE2Q0FQ?=
 =?utf-8?B?MkZDZjVud2tUU2JJOVJuOG14bVpUMW9makRLcnNNc1hlYnNRVWROMVpEdTJL?=
 =?utf-8?B?WFY1ZW85dlRJS2RsVHpVNVVqM2NHM0tjV2xKSHRXZjAzcnpOT2Y1M21reXVx?=
 =?utf-8?B?ZFdCOVlTTmZXcFpYK1FIY09zN0twR01Lazhid01wWlA0blJBMk5YTHJHc0p2?=
 =?utf-8?B?dllFbTZnMEx2bG14bVdiMVI2amhJeDY2RGMwVjNjT25LLzBIZjhvMXNwUlY4?=
 =?utf-8?B?VGdNZkg1RzhKZk1YdXJYb0JSVHdlWGQ1KzBEc3pqVTAvMmJIblZzbkl1NkZj?=
 =?utf-8?B?bWxKeGtVYUFTcHFtWUhBbHdRNHB4QUI2UkZWSkxHTUhuOFVQdmNqbm1CRDFP?=
 =?utf-8?B?RndVM1hTN0VQVktmSTZIdDlsTDdhcGZ6UmRNT0lqbTBoMnozVCtzeGJUeGVv?=
 =?utf-8?B?d2U3clJVNkNockVTUmo0MTNqS04vbTZWRGtyaEJTaENBRzBZbS9MVHFHNG9l?=
 =?utf-8?B?RHFwV2Y0dFlBRHVBK0tacTdsR3NrUmw4VHMxdGprSlJmMlROLzFiTlZldnMv?=
 =?utf-8?B?WWFiOXZ5ZHJlQTFhWWRoOTFKcnR5a01hb3B2YkZ5WlU5ZmJheDNRald6c1Fv?=
 =?utf-8?B?aDdGMUdXcVMrVTd5a1dLVXZCaG56a2xWZ2JxUFhBV2xrcUMwaVdlcytseDJQ?=
 =?utf-8?B?K3poY05YV2hNcXZEaitQTG5BdGtLbTdrcEFPeTViMXdtckx3WCtLOFlXUUZi?=
 =?utf-8?B?RWpqRzRsZnAxMS9iMDliT2tuN0luNFA4MXlOY05qMS91cVkwM3dpeWlzcCt1?=
 =?utf-8?B?dXRLRURHMWFOT2grUWE3ZmVIWDdJeis1L3VCUmNnTXliOGhUQTNKdz09?=
X-Exchange-RoutingPolicyChecked: jlngVgkFR0NqXfsph4VGRC7bohyTx3NMDMNW8ynOKQHWMprk2zCP7MWNkdbIsWqgcFyM3aIP8oHeqw0kQcMQr2ZE7g9eBe0MtT6PUMvjgGFy3nfqVzZegET1uJHUmCeSjFASQu8L4LJFafxo6415gByjJcTjTq+yuFgP/KhtTa28iFzZ3IoiV5+6U0LlFcvyZewKuYw7V2Fn9jv7Kf4viUudsZidYfNYwEkqKkGsNvQuqvQxMNUD2K5B9wg4wVuFMKHUcyG1SAmUQoNcfDNuKcYeIlP8Mdvj5P1SkoPJw+jpRTvDQ/VRBtP1+dFWFet42ez/9SAPrFU7naKKfPaZkQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: c31894a8-4755-4980-0945-08deab4056bf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:23:15.6032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFH6ZWIlDSjB9cw5OAOapVV1cXhBnQjeEt4VryNgjyg2hlwXwlymtsZybCZTL0lBsOvmtcWERpG3g6BkDv1BGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9794
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "ltp.fsetxattr02.fail" on:

commit: dc0876b9846d3d48bb8528332106d1b051578a02 ("xattr: support extended =
attributes on sockets")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      f1a5e78a55ebf2b05777fd5eb738038ddae609d6]
[test failed on linux-next/master b9303e6bff706758c167af686b5315ad00233bf8]

in testcase: ltp
version:=20
with following parameters:

	disk: 1HDD
	fs: btrfs
	test: syscalls-07/fsetxattr02


config: x86_64-rhel-9.4-ltp
compiler: gcc-14
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (=
Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605061511.8611e3df-lkp@intel.co=
m


2026-05-02 02:19:39 export LTP_RUNTIME_MUL=3D2
2026-05-02 02:19:39 export LTPROOT=3D/lkp/benchmarks/ltp
2026-05-02 02:19:39 kirk -f temp_single_test --tmp-dir /fs/sda2/tmpdir
Host information
	Hostname:   lkp-ivb-d04
	Python:     3.13.5 (main, Jun 25 2025, 18:55:22) [GCC 14.2.0]
	Directory:  /fs/sda2/tmpdir/kirk.root/tmpcaoemso4

Connecting to SUT: default

Suite: temp_single_test
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
=1B[1;37mfsetxattr02: =1B[0m=1B[1;31mfail=1B[0m | =1B[1;33mtainted=1B[0m  (=
0.085s)

Execution time: 0.378s

Disconnecting from SUT: default

Target information
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80
Kernel:   Linux 7.0.0-rc1+ #1 SMP PREEMPT_DYNAMIC Thu Apr 30 21:16:48 CST 2=
026
Cmdline:  ip=3D::::lkp-ivb-d04::dhcp
          root=3D/dev/ram0
          RESULT_ROOT=3D/result/ltp/1HDD-btrfs-syscalls-07_fsetxattr02/lkp-=
ivb-d04/debian-13-x86_64-20250902.cgz/x86_64-rhel-9.4-ltp/gcc-14/dc0876b984=
6d3d48bb8528332106d1b051578a02/0
          BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-9.4-ltp/gcc-14/dc0876b9846d3d=
48bb8528332106d1b051578a02/vmlinuz-7.0.0-rc1+
          branch=3Dinternal-tdx-kvm-upstream/ci/next-20260424-7080e32d3f09d=
-2026-04-24
          job=3D/lkp/jobs/scheduled/lkp-ivb-d04/ltp-1HDD-btrfs-syscalls-07_=
fsetxattr02-debian-13-x86_64-20250902.cgz-dc0876b9846d-20260502-17404-1wyqy=
yu-1.yaml
          user=3Dlkp
          ARCH=3Dx86_64
          kconfig=3Dx86_64-rhel-9.4-ltp
          commit=3Ddc0876b9846d3d48bb8528332106d1b051578a02
          intremap=3Dposted_msi
          max_uptime=3D14400
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
_64-92ea0639e-1_20260301.cgz
Machine:  unknown
Arch:     x86_64
RAM:      6899188 kB
Swap:     0 kB
Distro:   debian 13

=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
      TEST SUMMARY
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
Suite:   temp_single_test
Runtime: 0.085s
Runs:    1

Results:
    Passed:   6
    Failed:   1
    Broken:   0
    Skipped:  0
    Warnings: 0

=1B[1;31mFailures:=1B[0m
    =E2=80=A2 fsetxattr02

Session stopped



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260506/202605061511.8611e3df-lkp@=
intel.com



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

