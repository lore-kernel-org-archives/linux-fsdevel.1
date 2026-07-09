Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04A72F8E82;
	Thu,  9 Jul 2026 02:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564177; cv=fail; b=Tbm8Pv/rFehpcJc7k3ilOncVKNk1RFVEL+fe5yrKOcM/gTlhW3gtQAr+T9Xm1IlLiu92IvDNnFSldDrWKlOdofm2R+E4tUdIELlYgLjLO3KKx+aT7qza5Fiz+fsCGrl1znu7RyMRo8DBx6bsk1UzOc0M70M7jmlzDU1TVASW68s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564177; c=relaxed/simple;
	bh=s1siLO0sxsDigOJhuCKPiU5Ms/XV7XF4vJcS7cyqb0Y=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=T4KY9TtZrz8l8K46oDxClg5Z51RGqrEpHT3xAxkmcEhPd/jBdcX7GLwj8qmDI38MStsBufIqwx+UNjUzYorMwpSWB9F7MsQXNVDiKzq8lGcBhVKqYBN2vBaLy64IHMb11nqCe4r09z51+4P76EYc40Qx94Aghc7B3KLow8bBg8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llIvduOn; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llIvduOn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783564175; x=1815100175;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=s1siLO0sxsDigOJhuCKPiU5Ms/XV7XF4vJcS7cyqb0Y=;
  b=llIvduOn1/LxIt2rSBAsL57RV00O+mXhWiNJBsAz1NhTh+uljFDaQZUm
   TgWhI5UQY2UxZkxpP2S0QkhtvM/MpYXDAUSh5Icj63THD7R161eTDEoT5
   5Awe4XLQ9sm1bgrLU+1iOrHwzSBTyiExi81N7QgjFMpYbi9g4pZKSupp1
   1+lrcktKgTpVR4D10AMk/YQFPiUas6gQ6N1hQL/KqS1cdGmQpgQc5P9V0
   UYzAoJQOfylUKjGJprCfWyRUcvscNaYN/xuZNyQEZ3OOvIqUXeXWGy+l5
   LLqIc5avtKp/g3KaB34eE0HrrslXqxlYw8RTo322UZFo28Rk7LDduS0HL
   w==;
X-CSE-ConnectionGUID: ut2ki7g7Qmm5VpyGx26kLA==
X-CSE-MsgGUID: uFe4MTLrQ6qOYB6/WbNRoQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101783005"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="101783005"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 19:29:34 -0700
X-CSE-ConnectionGUID: A5LyOr2xSsWJ/a/J/zsRjg==
X-CSE-MsgGUID: A3JWJmEbSrOccAde2k5gbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="251799662"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 19:29:30 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 19:29:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 8 Jul 2026 19:29:28 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.12) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 8 Jul 2026 19:29:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ubDZc4nzzHAy81mOGTkL1F56npPKSTqwVFNjG5VcyBjq8aDg74O/BzuBkJ37DI5bzzYtP8j2BbkpzzVZzuuo+uAyhMS/TJIUCH/BfoImdicAuNlgLP2zYzIGYpJDLIj7vjsad7x9V9EWz2hmx5PNbzdFbXFBKwg/k2OjCRW9M3xT7NzuX5nGneVZMXUl9VIA8nY24aHk1Bsl8KAjTMkVN5SITnUEzJPvU0cCPI+naxe4DCCVcx/4Yink4HKzSEGWl11Vvcleup6KDAqHGvx5xT6xG5EReMTxZmCvzsbh/WF/tIF1FX+Db6DKg+QSDvHalp+Vi/h/sbFoqwqFQGe2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vduktjoiXBTtNLJ2OWf0WlOKwAPZtAUGagTsIklXt5c=;
 b=fskEx8NoVcA3mMBwn3r/r+pqgB3mRnF1y7Zg0MZy+SJ4OLvrIZoJy+/8waOf70oneGvyz6+CACQsp2jKxIaFPrbHcKuUfUbS2fvm5YRDTTbEfrYNRpFN1sZDP5NP9A03s6lg1vXrq5LUxbhq7AoZpe9JyL0fps+pcyDsvRZBC/cvo36FI0/ttZflFQTT7j+5jWyQfkW20b2TnPVlueYjKoKnAEbumxP0g2iVnXR33Hf3eB7ukdPxEyOZHil+2hVFBH3CoTSf+x5oz8mrqt7srVPeeHWiaGEy3TyTmVRaE6xZ/CtO+esYVZ9m2jNpesMY/7TSe6UwUgZLZPQkpkpt5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CH3PR11MB8316.namprd11.prod.outlook.com (2603:10b6:610:17b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 02:29:18 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 02:29:18 +0000
Date: Thu, 9 Jul 2026 10:29:09 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Breno Leitao <leitao@debian.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [fs/pipe]  212ed884a1: lmbench3.PIPE.bandwidth.MB/sec
 29.1% improvement
Message-ID: <202607091015.c3936260-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19)
 To PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CH3PR11MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: de05d80c-7957-4d46-2990-08dedd61e05f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|13003099007|6133799003|56012099006|11063799006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Ryv9nL9+3Y1Hs00TYLkv+L/FQ7rraAAR85jsmGkv7V7SsW2++ebd02CUviaZsXz3ytrn36jaVxwNRdar9YUXcvEpTPkB7pEJ5jhsHZKJLNMMofVky0IhAcWHuKFQnC2CNsxb8gEFaQ7x2gPI/2YmKp9xUVuoyf5C1s5Xb1hD8jnXg//VkpJWnWyv1+IsZ6Yn/Mslt0Jz6JkABFYPyrrsaeZotoSzvsyXLynmR105YdtzBje48GPGTFH1O4wkn9asJ8uXcgAnbtj7eYCz9yvGoFwQoYGCQB2D1RE9uWEBUZ2zCKgxw6AOoK3zjQWIavk7DvbfJiPoxwBpPv5aDPBugP9Nuv1gwQNQ4Gz7du1qExeZLTNQ27MAX0+Wubu4vPbJxQnEGvBN2cs0LtF7UaRSjER3dPH/Ja5dNN4mcSlE+n0zS4gTkF7fa1ACn1hIDPtJjB2J9PaQ9l0oG9GIiocnyG0RYXGSHYNgWIlUMiY4eZ+CkXIun/Fy0nWQ2TuYSWaKYR2yqfZ/l7RKzGdT4JJvQfRo9fecXXrqE99+sdmX8Vr1emA4hcJT4IwwPnS9NkYjj91jWQjmomfyihEJnwd0M3J0ro1cglWYya4/wTSD3GH8P6W5XpermH0AXIiuU5Ux
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(13003099007)(6133799003)(56012099006)(11063799006)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?bH2krpN3Jnpwal61uJMAflh52R8YZlJ1Bp7Do6Yyj8yCcPJevzGPp7leF3?=
 =?iso-8859-1?Q?oZmgXNb8eqNWxVq29JN3IkVTCdz0LTwkgEm2FWwMg7naSj7u7lhJX5iWib?=
 =?iso-8859-1?Q?z7UwTEhhRUgA0ZS/5EP6Q7XyujZzZsbRJQebeuCRQfwQPaYF65JGYb1Yeb?=
 =?iso-8859-1?Q?pwQMvbmdU/GSzx60+9bgF0sucoQsSeQ1nDToWjMg3dUqPilM7WT2ApnOJb?=
 =?iso-8859-1?Q?eXjC4Xl3+Ib36q22dBdN5HICSaTscSRUhe6OLH4jRvO6jz9mUzqr46bq1C?=
 =?iso-8859-1?Q?ytmcjlpsUN4xUKuu1et7Qx6FhWJHKeEv3AgtBtItctSobeDL6dx832l+zF?=
 =?iso-8859-1?Q?Ve4nFih2PBqS2JYnRSeA+zk3ok9poELfEHUAZeDAY/+G2IYsqgRfQ15Ff1?=
 =?iso-8859-1?Q?WEj0SUWK4GFbCrIqYb7iVW6PvoxCpjaA9RcxaSRrfmiceOsCVV4bw8mJp1?=
 =?iso-8859-1?Q?L79/CceNEEKZ6faBCkFSZZFsSUGpUgE7pX5omsSWzgePZsbvbrshWkAI5W?=
 =?iso-8859-1?Q?sMBrct+GFMZ3dudNdG0ofo4Gt9omQJQYwJTduHQSPya+Fce+ElFVIhtNQZ?=
 =?iso-8859-1?Q?XONBwPB7A9eqD+/byCW2Twktxd7rSctYX1gVzgRfe70i/lsHrZjGPg4Bq3?=
 =?iso-8859-1?Q?X+iUI70SbAg1peT2YGwJjOSTAdlJTGCtwAuCPGmThO0RT7EPCtTURt/QXr?=
 =?iso-8859-1?Q?VtGgQfReAGKGl4GbmNwlaWoRY27WjcTVy1ZjfAIlw/rJJoyCDIgmIW/Gek?=
 =?iso-8859-1?Q?WmhsTlQNIp/VNS2kfjzmkfTGkXoL8oBPjFHdThuBWhqPk3WKmj+8Pbtrxa?=
 =?iso-8859-1?Q?LgtH0S/G4zdDBTPSZ1wi18TBBcYixuAwYM91xPEKaEfbwGr8ZZ1OPnGF0c?=
 =?iso-8859-1?Q?u4nvyYEDlr7dH3RkPEg9SfSb4QaK/8BLk++zejpEpG7X+PMtojkY2+9NxQ?=
 =?iso-8859-1?Q?c4766LNoKCSfxlKOvVBsjc89qfk/Ty8vvmh5tk8FZ6WOPZxHE/0gXTMl+T?=
 =?iso-8859-1?Q?i/dWhZqdxsPN2nDbKu6WgrQAccOFltXjLZkFqnfsJGzFwE2OokvPIru7T2?=
 =?iso-8859-1?Q?MEv7N5Hu/FywmHVHoOyDYDdHeyDuPn13v6k9fBuRCj3fJy2oBAT2B9hz7f?=
 =?iso-8859-1?Q?lTWZypkjgRR6yOwQRjOq0cdQREXC8AZ6URvIK5Gg5kRUMv2KS4VrmYc5ax?=
 =?iso-8859-1?Q?Y7vdOVjzkfFnUPtEITHko7KUKDL059WV4jTKlVOqRctwGdHmiuslZo9jiH?=
 =?iso-8859-1?Q?hLOOV/2lG3W98bGmWTM3nZOqktV+jJRsG3YgwI73CdrPBA07n7IyGuTT9C?=
 =?iso-8859-1?Q?WZdKmkNRiGllAS9Hj/fX7zMco7j73vCHviRl8CqLaRBaEPxm0W0C2s6CFE?=
 =?iso-8859-1?Q?X314ESZDgX7A+lc28Qs7+BwupzkpKaVJ0yPJggNQwUM8OH0tBAfVlNQ6oQ?=
 =?iso-8859-1?Q?TT8d4uPnEP/dJGgsnG7FtvdPlzdqxFrofARGLYEV/jEzzDOEAaLBXX7QsL?=
 =?iso-8859-1?Q?Vu/wWBRH1ka9MiFMW4CF1eBpcm7ABkxsdZRYk6wE4dgx0+KoWukSnZMAGO?=
 =?iso-8859-1?Q?wa05cMATUd4jHN5w4MFFsatVoGq2Ta360HLC9UMKtevBQ1qzCo6IERk2OL?=
 =?iso-8859-1?Q?Ze5U2GkY8G1JiTIYkbw1vm3MBRJbj2wO5tyCYLQ7n2e07/z0wEh1nmaXBr?=
 =?iso-8859-1?Q?Md0fxyW8gP2pIoOyjhKg6GVWNgZ5UYSzMlMYXQDdOrZpE2oLJbGHIW2BH7?=
 =?iso-8859-1?Q?u3hb7wPetqQ9enV70sTn1L7dlxm7b678+rk2nPXOGPylLc1k9BjMZ4nrSf?=
 =?iso-8859-1?Q?/wLD8HX6lQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: hC59FN9qq+Z4/P9PxW+9GbXbeZVy6BjBlaq50tIEhvbFyl++1s+JQG4MnsTj/4qcUoggELm5mbcqppApvQShK6+aW/5gO4nBtOdzXpgLzMDJnhPC0Whv7Pua2i1wPfYkRDhBSEIQoZaS1mFae02JOOJwQM0StQ/2ddjbsyuUvjRWQSKhOTOcxKLj6EP5Ut2u0uqH3FI/mobOvf+Ml3WBHOy3M1qru8yXgwb7tNJhkID68QLAp4Qzie6temZt15Rdr6LPoQFM9dXs/2tI1JRrMPhblkQz+0XvWohopgbgfjtlsG7bU4eZ5nWWisYNqVKkJdvC/AfNKXLR9HRv6oJiCA==
X-MS-Exchange-CrossTenant-Network-Message-Id: de05d80c-7957-4d46-2990-08dedd61e05f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 02:29:18.2326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtI0g8Pw9v7Roq8IdvVM/Mp8fubQuQ123qNGRpRQjxMFIKJ2XbP4esnye0SNnITyuCPgn2Lj1DOlVZ45wLI4bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8316
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 29.1% improvement of lmbench3.PIPE.bandwidth.MB/sec on:


commit: 212ed884a1aeefda22d87c270d082e4b0a95821f ("fs/pipe: pre-allocate pages outside pipe->mutex in anon_pipe_write")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: lmbench3
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
parameters:

	test_memory_size: 50%
	nr_threads: 20%
	mode: development
	test: PIPE
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260709/202607091015.c3936260-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_threads/rootfs/tbox_group/test/test_memory_size/testcase:
  gcc-14/performance/x86_64-rhel-9.4/development/20%/debian-13-x86_64-20250902.cgz/lkp-spr-2sp4/PIPE/50%/lmbench3

commit: 
  d24576fddf ("fs: retire stale comment in fget_task_next()")
  212ed884a1 ("fs/pipe: pre-allocate pages outside pipe->mutex in anon_pipe_write")

d24576fddf645a84 212ed884a1aeefda22d87c270d0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     37316           +29.1%      48191 ±  2%  lmbench3.PIPE.bandwidth.MB/sec
      5690 ±  9%    +153.5%      14426 ± 18%  lmbench3.time.involuntary_context_switches
      2190 ±  4%     +80.9%       3962 ±  8%  lmbench3.time.percent_of_cpu_this_job_got
      3153 ±  8%     +92.6%       6074 ± 17%  lmbench3.time.system_time
 3.564e+08 ±  2%     -20.5%  2.835e+08 ±  3%  lmbench3.time.voluntary_context_switches
 3.599e+08 ±  2%     -20.8%  2.851e+08 ±  3%  cpuidle..usage
    859014 ±  6%     +12.6%     966825 ±  5%  meminfo.Shmem
      0.32 ± 72%    +208.8%       0.98 ± 96%  perf-sched.sch_delay.max.ms.perf_trace_sched_switch.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0
 2.384e+08 ±  7%     +34.9%  3.215e+08 ± 26%  numa-numastat.node0.local_node
 2.399e+08 ±  7%     +34.7%  3.233e+08 ± 27%  numa-numastat.node0.numa_hit
 2.553e+08 ±  9%     +35.9%   3.47e+08 ± 15%  numa-numastat.node1.local_node
 2.568e+08 ±  9%     +35.9%  3.491e+08 ± 15%  numa-numastat.node1.numa_hit
 2.399e+08 ±  7%     +34.7%  3.233e+08 ± 27%  numa-vmstat.node0.numa_hit
 2.384e+08 ±  7%     +34.9%  3.215e+08 ± 26%  numa-vmstat.node0.numa_local
 2.568e+08 ±  9%     +35.9%  3.491e+08 ± 15%  numa-vmstat.node1.numa_hit
 2.553e+08 ±  9%     +35.9%   3.47e+08 ± 15%  numa-vmstat.node1.numa_local
   4944973 ±  2%     -21.4%    3888342 ±  6%  perf-stat.i.context-switches
    376.79           -17.1%     312.47        perf-stat.i.cpu-migrations
   4816826 ±  2%     -23.7%    3676908 ±  6%  perf-stat.ps.context-switches
    373.27           -17.4%     308.16 ±  2%  perf-stat.ps.cpu-migrations
     90.49            -8.8%      82.53        vmstat.cpu.id
     22.14 ±  3%     +79.8%      39.80 ±  8%  vmstat.procs.r
   4741221 ±  2%     -23.6%    3623691 ±  6%  vmstat.system.cs
     80532           +14.0%      91771        vmstat.system.in
     90.21            -8.0       82.22        mpstat.cpu.all.idle%
      0.07 ±  3%      +0.0        0.08 ±  4%  mpstat.cpu.all.irq%
      0.03 ±  4%      -0.0        0.02 ±  5%  mpstat.cpu.all.soft%
      9.31 ±  4%      +8.0       17.31 ±  8%  mpstat.cpu.all.sys%
    146.33 ±  3%     -21.0%     115.67        mpstat.max_utilization.seconds
     20.10           +94.4%      39.08        mpstat.max_utilization_pct
   1255045            +2.1%    1281940        proc-vmstat.nr_file_pages
    214782 ±  6%     +12.5%     241716 ±  5%  proc-vmstat.nr_shmem
      3725 ± 14%     +33.6%       4975 ±  9%  proc-vmstat.numa_hint_faults_local
 4.968e+08 ±  8%     +35.3%  6.723e+08 ± 19%  proc-vmstat.numa_hit
 4.937e+08 ±  8%     +35.4%  6.686e+08 ± 19%  proc-vmstat.numa_local
 5.028e+08 ±  8%     +35.0%  6.787e+08 ± 19%  proc-vmstat.pgalloc_normal
 5.025e+08 ±  8%     +35.0%  6.783e+08 ± 19%  proc-vmstat.pgfree
    398.67 ±  3%     +52.3%     607.33 ±  6%  turbostat.Avg_MHz
     12.58 ±  3%      +7.1       19.67 ±  6%  turbostat.Busy%
      3167            -2.5%       3087        turbostat.Bzy_MHz
      9.08 ±  4%      -7.1        2.00 ±  2%  turbostat.C1E%
     19.36 ±  3%     -57.8%       8.17 ±  3%  turbostat.CPU%c1
     57.00 ±  2%      +6.4%      60.67 ±  2%  turbostat.CoreTmp
  11901244 ±  4%     +19.5%   14217328 ±  8%  turbostat.IRQ
   1658105           +65.0%    2736250        turbostat.NMI
     57.17 ±  3%      +7.9%      61.67        turbostat.PkgTmp
    443.04            +6.4%     471.36        turbostat.PkgWatt
    172875          +216.1%     546498 ± 49%  sched_debug.cfs_rq:/.avg_vruntime.avg
    384315 ±  3%    +234.2%    1284302 ± 38%  sched_debug.cfs_rq:/.avg_vruntime.max
     63545 ±  4%    +295.8%     251542 ± 22%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.09 ±  8%     +80.7%       0.17 ± 15%  sched_debug.cfs_rq:/.h_nr_queued.avg
      0.25 ±  4%     +18.9%       0.29 ±  8%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.09 ±  8%     +81.2%       0.17 ± 15%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      0.25 ±  4%     +19.0%       0.29 ±  8%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
     28978 ±  3%     -11.9%      25542 ± 10%  sched_debug.cfs_rq:/.load_avg.max
      0.09 ±  8%     +81.7%       0.17 ± 15%  sched_debug.cfs_rq:/.nr_queued.avg
      0.25 ±  4%     +19.0%       0.29 ±  8%  sched_debug.cfs_rq:/.nr_queued.stddev
    124.05 ±  3%     +58.2%     196.23 ± 11%  sched_debug.cfs_rq:/.runnable_avg.avg
    199.58 ±  3%     +39.1%     277.61 ±  7%  sched_debug.cfs_rq:/.runnable_avg.stddev
    123.65 ±  3%     +57.7%     195.06 ± 12%  sched_debug.cfs_rq:/.util_avg.avg
    199.25 ±  3%     +38.9%     276.76 ±  7%  sched_debug.cfs_rq:/.util_avg.stddev
     45.47 ±  8%    +224.8%     147.70 ± 16%  sched_debug.cfs_rq:/.util_est.avg
    682.06 ± 13%     +22.9%     838.38 ± 13%  sched_debug.cfs_rq:/.util_est.max
    121.50 ±  6%     +80.7%     219.58 ± 11%  sched_debug.cfs_rq:/.util_est.stddev
    172875          +216.1%     546496 ± 49%  sched_debug.cfs_rq:/.zero_vruntime.avg
    384315 ±  3%    +234.2%    1284302 ± 38%  sched_debug.cfs_rq:/.zero_vruntime.max
     63545 ±  4%    +295.8%     251542 ± 22%  sched_debug.cfs_rq:/.zero_vruntime.stddev
      1064 ±  4%     +95.3%       2079 ± 15%  sched_debug.cpu.curr->pid.avg
      2660 ±  3%     +21.7%       3238 ± 10%  sched_debug.cpu.curr->pid.stddev
      0.09 ±  4%     +86.4%       0.16 ± 14%  sched_debug.cpu.nr_running.avg
      0.23 ±  3%     +19.0%       0.28 ±  8%  sched_debug.cpu.nr_running.stddev
     51512 ± 14%     -92.4%       3890 ± 77%  sched_debug.cpu.nr_switches.min
     22.76           -15.8        6.97 ±  2%  perf-profile.calltrace.cycles-pp.copy_page_to_iter.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
     22.64           -15.7        6.92 ±  2%  perf-profile.calltrace.cycles-pp._copy_to_iter.copy_page_to_iter.anon_pipe_read.vfs_read.ksys_read
     65.71           -14.8       50.87        perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     65.68           -14.8       50.85        perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     65.54           -14.7       50.81        perf-profile.calltrace.cycles-pp.anon_pipe_read.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe
     16.60 ±  2%     -10.5        6.10        perf-profile.calltrace.cycles-pp.alloc_pages_noprof.anon_pipe_write.vfs_write.ksys_write.do_syscall_64
     16.47 ±  2%     -10.4        6.04        perf-profile.calltrace.cycles-pp.alloc_pages_mpol.alloc_pages_noprof.anon_pipe_write.vfs_write.ksys_write
     16.28 ±  2%     -10.3        5.96        perf-profile.calltrace.cycles-pp.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.anon_pipe_write.vfs_write
     12.41            -8.0        4.40 ±  2%  perf-profile.calltrace.cycles-pp.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.anon_pipe_write
      7.69            -7.5        0.17 ±141%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
      7.68            -7.5        0.17 ±141%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
      7.65            -7.5        0.17 ±141%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      7.81            -7.4        0.44 ± 44%  perf-profile.calltrace.cycles-pp.common_startup_64
     35.69 ±  2%      -6.4       29.28        perf-profile.calltrace.cycles-pp.__folio_put.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
     35.62 ±  2%      -6.4       29.24        perf-profile.calltrace.cycles-pp.__mem_cgroup_uncharge.__folio_put.anon_pipe_read.vfs_read.ksys_read
     35.49 ±  2%      -6.3       29.14        perf-profile.calltrace.cycles-pp.uncharge_batch.__mem_cgroup_uncharge.__folio_put.anon_pipe_read.vfs_read
      9.66 ±  2%      -6.0        3.61 ±  2%  perf-profile.calltrace.cycles-pp.rmqueue.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof
      5.65            -5.6        0.00        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      5.13            -5.1        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     33.74 ±  2%      -5.1       28.62        perf-profile.calltrace.cycles-pp.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge.__folio_put.anon_pipe_read
      5.10            -5.1        0.00        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
      7.29 ±  2%      -4.9        2.37 ±  2%  perf-profile.calltrace.cycles-pp._raw_spin_trylock.rmqueue.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol
      3.46 ± 13%      -2.1        1.40 ±  3%  perf-profile.calltrace.cycles-pp.__memcg_kmem_charge_page.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof.anon_pipe_write
      2.49 ±  2%      -1.9        0.61 ±  9%  perf-profile.calltrace.cycles-pp.propagate_protected_usage.page_counter_uncharge.uncharge_batch.__mem_cgroup_uncharge.__folio_put
      2.78 ±  4%      -0.5        2.31 ±  5%  perf-profile.calltrace.cycles-pp.__free_frozen_pages.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      2.40 ±  4%      -0.3        2.06 ±  6%  perf-profile.calltrace.cycles-pp.free_frozen_page_commit.__free_frozen_pages.anon_pipe_read.vfs_read.ksys_read
      0.88            -0.3        0.61 ±  2%  perf-profile.calltrace.cycles-pp.anon_pipe_buf_release.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
      1.18 ±  2%      -0.2        0.98        perf-profile.calltrace.cycles-pp.try_charge_memcg.__memcg_kmem_charge_page.__alloc_frozen_pages_noprof.alloc_pages_mpol.alloc_pages_noprof
      0.62 ±  3%      -0.2        0.44 ± 44%  perf-profile.calltrace.cycles-pp.rmqueue_bulk.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_frozen_pages_noprof
      0.75 ±  2%      -0.1        0.62        perf-profile.calltrace.cycles-pp.mutex_unlock.anon_pipe_write.vfs_write.ksys_write.do_syscall_64
      0.77 ±  2%      -0.1        0.70 ±  3%  perf-profile.calltrace.cycles-pp.__rmqueue_pcplist.rmqueue.get_page_from_freelist.__alloc_frozen_pages_noprof.alloc_pages_mpol
      0.83 ±  7%      +0.3        1.10 ±  9%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irqsave.free_pcppages_bulk.free_frozen_page_commit.__free_frozen_pages.anon_pipe_read
      0.75 ±  8%      +0.3        1.07 ±  9%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.free_pcppages_bulk.free_frozen_page_commit.__free_frozen_pages
      3.81 ±  3%      +2.6        6.39 ±  3%  perf-profile.calltrace.cycles-pp._copy_from_iter.copy_page_from_iter.anon_pipe_write.vfs_write.ksys_write
      3.86 ±  3%      +2.6        6.46 ±  2%  perf-profile.calltrace.cycles-pp.copy_page_from_iter.anon_pipe_write.vfs_write.ksys_write.do_syscall_64
     91.54            +7.7       99.26        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     91.53            +7.7       99.26        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.69 ±  6%     +10.3       10.96 ±  2%  perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.anon_pipe_read.vfs_read.ksys_read
      0.70 ±  6%     +10.4       11.07 ±  2%  perf-profile.calltrace.cycles-pp.__mutex_lock.anon_pipe_read.vfs_read.ksys_read.do_syscall_64
     25.66           +22.7       48.34        perf-profile.calltrace.cycles-pp.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.63           +22.7       48.33        perf-profile.calltrace.cycles-pp.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.45           +22.8       48.29        perf-profile.calltrace.cycles-pp.anon_pipe_write.vfs_write.ksys_write.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.56 ±  6%     +32.9       34.49        perf-profile.calltrace.cycles-pp.mutex_spin_on_owner.__mutex_lock.anon_pipe_write.vfs_write.ksys_write
      1.57 ±  7%     +33.0       34.61        perf-profile.calltrace.cycles-pp.__mutex_lock.anon_pipe_write.vfs_write.ksys_write.do_syscall_64
     22.78           -15.8        6.97 ±  2%  perf-profile.children.cycles-pp.copy_page_to_iter
     22.68           -15.8        6.92 ±  2%  perf-profile.children.cycles-pp._copy_to_iter
     65.72           -14.8       50.87        perf-profile.children.cycles-pp.ksys_read
     65.69           -14.8       50.85        perf-profile.children.cycles-pp.vfs_read
     65.56           -14.7       50.82        perf-profile.children.cycles-pp.anon_pipe_read
     16.62 ±  2%     -10.5        6.10        perf-profile.children.cycles-pp.alloc_pages_noprof
     16.51 ±  2%     -10.4        6.06        perf-profile.children.cycles-pp.alloc_pages_mpol
     16.30 ±  2%     -10.3        5.97        perf-profile.children.cycles-pp.__alloc_frozen_pages_noprof
     12.44            -8.0        4.41 ±  2%  perf-profile.children.cycles-pp.get_page_from_freelist
      7.81            -7.3        0.52 ±  3%  perf-profile.children.cycles-pp.common_startup_64
      7.81            -7.3        0.52 ±  3%  perf-profile.children.cycles-pp.cpu_startup_entry
      7.79            -7.3        0.52 ±  4%  perf-profile.children.cycles-pp.do_idle
      7.69            -7.2        0.48 ±  5%  perf-profile.children.cycles-pp.start_secondary
     35.70 ±  2%      -6.4       29.29        perf-profile.children.cycles-pp.__folio_put
     35.64 ±  2%      -6.4       29.25        perf-profile.children.cycles-pp.__mem_cgroup_uncharge
     35.50 ±  2%      -6.3       29.16        perf-profile.children.cycles-pp.uncharge_batch
      9.69 ±  2%      -6.1        3.63 ±  2%  perf-profile.children.cycles-pp.rmqueue
      5.70            -5.3        0.36 ±  4%  perf-profile.children.cycles-pp.cpuidle_idle_call
     33.79 ±  2%      -5.1       28.65        perf-profile.children.cycles-pp.page_counter_uncharge
      7.58 ±  2%      -5.1        2.51 ±  2%  perf-profile.children.cycles-pp._raw_spin_trylock
      5.18            -4.8        0.33 ±  5%  perf-profile.children.cycles-pp.cpuidle_enter
      5.16            -4.8        0.33 ±  5%  perf-profile.children.cycles-pp.cpuidle_enter_state
      4.50            -4.2        0.25 ±  6%  perf-profile.children.cycles-pp.intel_idle
      2.56 ±  2%      -2.4        0.14 ±  6%  perf-profile.children.cycles-pp.__wake_up_common
      2.60 ±  2%      -2.4        0.23 ±  4%  perf-profile.children.cycles-pp.__wake_up_sync_key
      3.48 ± 13%      -2.1        1.41 ±  3%  perf-profile.children.cycles-pp.__memcg_kmem_charge_page
      2.20            -2.0        0.20 ±  4%  perf-profile.children.cycles-pp.__schedule
      2.06 ±  2%      -2.0        0.09 ±  6%  perf-profile.children.cycles-pp.autoremove_wake_function
      2.06 ±  2%      -2.0        0.09 ±  6%  perf-profile.children.cycles-pp.try_to_wake_up
      2.54 ± 37%      -1.9        0.60 ± 22%  perf-profile.children.cycles-pp.__mod_memcg_state
      2.55 ±  2%      -1.9        0.63 ±  9%  perf-profile.children.cycles-pp.propagate_protected_usage
      1.60            -1.4        0.16 ±  5%  perf-profile.children.cycles-pp.schedule
      1.07            -1.0        0.09 ±  5%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.90            -0.9        0.02 ± 99%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.80            -0.7        0.10 ±  4%  perf-profile.children.cycles-pp.__pick_next_task
      0.72 ±  2%      -0.6        0.10 ±  8%  perf-profile.children.cycles-pp.pick_next_task_fair
      0.84 ± 15%      -0.6        0.28 ± 50%  perf-profile.children.cycles-pp.css_rstat_updated
      2.81 ±  4%      -0.5        2.33 ±  5%  perf-profile.children.cycles-pp.__free_frozen_pages
      0.48 ±  2%      -0.4        0.11 ±  4%  perf-profile.children.cycles-pp.sched_balance_rq
      0.44 ±  3%      -0.4        0.08 ±  5%  perf-profile.children.cycles-pp.sched_balance_newidle
      2.42 ±  4%      -0.4        2.07 ±  6%  perf-profile.children.cycles-pp.free_frozen_page_commit
      0.42 ±  3%      -0.3        0.10 ±  3%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      0.42 ±  3%      -0.3        0.10 ±  5%  perf-profile.children.cycles-pp.update_sd_lb_stats
      0.76 ±  2%      -0.3        0.45 ±  3%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      0.39 ±  3%      -0.3        0.09 ±  4%  perf-profile.children.cycles-pp.update_sg_lb_stats
      0.89            -0.3        0.61 ±  2%  perf-profile.children.cycles-pp.anon_pipe_buf_release
      0.65            -0.3        0.39 ±  3%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      1.18 ±  2%      -0.2        0.99        perf-profile.children.cycles-pp.try_charge_memcg
      0.54 ±  3%      -0.1        0.40 ±  3%  perf-profile.children.cycles-pp.__free_one_page
      0.48            -0.1        0.35 ±  3%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.47            -0.1        0.34 ±  3%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.22 ±  2%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.handle_softirqs
      0.78            -0.1        0.67 ±  2%  perf-profile.children.cycles-pp.mutex_unlock
      0.13 ±  7%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.rest_init
      0.13 ±  7%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.start_kernel
      0.13 ±  7%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.13 ±  7%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.18 ±  5%      -0.1        0.09 ±  5%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.56 ±  3%      -0.1        0.46        perf-profile.children.cycles-pp.page_counter_try_charge
      0.13 ±  2%      -0.1        0.03 ± 70%  perf-profile.children.cycles-pp.__irq_exit_rcu
      0.63 ±  3%      -0.1        0.54 ±  4%  perf-profile.children.cycles-pp.rmqueue_bulk
      0.16 ±  3%      -0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__mod_zone_page_state
      0.14 ±  3%      -0.1        0.06 ± 19%  perf-profile.children.cycles-pp.policy_nodemask
      0.10 ±  4%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.do_softirq
      0.14 ±  3%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.78 ±  2%      -0.1        0.70 ±  3%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.17 ±  4%      -0.1        0.10 ±  8%  perf-profile.children.cycles-pp.mutex_lock
      0.28 ±  2%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.27 ±  2%      -0.0        0.24 ±  3%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.11 ±  4%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.uncharge_folio
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.task_tick_fair
      0.91 ±  7%      +0.3        1.18 ±  9%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      3.88 ±  3%      +2.6        6.47 ±  3%  perf-profile.children.cycles-pp.copy_page_from_iter
      3.82 ±  3%      +2.6        6.40 ±  3%  perf-profile.children.cycles-pp._copy_from_iter
     91.63            +7.7       99.34        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     91.62            +7.7       99.33        perf-profile.children.cycles-pp.do_syscall_64
     25.69           +22.7       48.38        perf-profile.children.cycles-pp.ksys_write
     25.66           +22.7       48.36        perf-profile.children.cycles-pp.vfs_write
     25.48           +22.8       48.30        perf-profile.children.cycles-pp.anon_pipe_write
      2.25 ±  6%     +43.2       45.46        perf-profile.children.cycles-pp.mutex_spin_on_owner
      2.26 ±  6%     +43.4       45.68        perf-profile.children.cycles-pp.__mutex_lock
     22.59           -15.7        6.89 ±  2%  perf-profile.self.cycles-pp._copy_to_iter
      7.53 ±  2%      -5.1        2.48 ±  2%  perf-profile.self.cycles-pp._raw_spin_trylock
      4.50            -4.2        0.25 ±  6%  perf-profile.self.cycles-pp.intel_idle
     31.19 ±  3%      -3.3       27.93        perf-profile.self.cycles-pp.page_counter_uncharge
      2.76 ±  2%      -2.0        0.78 ±  3%  perf-profile.self.cycles-pp.get_page_from_freelist
      2.50 ±  2%      -1.9        0.60 ±  9%  perf-profile.self.cycles-pp.propagate_protected_usage
      1.38 ± 11%      -1.1        0.26 ± 28%  perf-profile.self.cycles-pp.__memcg_kmem_charge_page
      1.58 ±  3%      -1.0        0.55 ±  3%  perf-profile.self.cycles-pp.rmqueue
      0.83 ± 15%      -0.6        0.27 ± 52%  perf-profile.self.cycles-pp.css_rstat_updated
      0.50 ±  2%      -0.4        0.05        perf-profile.self.cycles-pp.__wake_up_common
      0.64 ±  5%      -0.4        0.24 ±  5%  perf-profile.self.cycles-pp.free_frozen_page_commit
      0.88            -0.3        0.60 ±  3%  perf-profile.self.cycles-pp.anon_pipe_buf_release
      0.33 ±  4%      -0.3        0.07        perf-profile.self.cycles-pp.update_sg_lb_stats
      0.48            -0.2        0.23 ±  3%  perf-profile.self.cycles-pp.anon_pipe_read
      0.38 ±  9%      -0.2        0.15 ±  7%  perf-profile.self.cycles-pp.__alloc_frozen_pages_noprof
      0.28            -0.1        0.13 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.39 ±  2%      -0.1        0.28 ±  2%  perf-profile.self.cycles-pp.anon_pipe_write
      0.77            -0.1        0.67 ±  2%  perf-profile.self.cycles-pp.mutex_unlock
      0.46 ±  3%      -0.1        0.36 ±  4%  perf-profile.self.cycles-pp.__free_one_page
      0.18 ±  5%      -0.1        0.09 ±  5%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.61 ±  2%      -0.1        0.52        perf-profile.self.cycles-pp.try_charge_memcg
      0.14 ±  3%      -0.1        0.06 ±  8%  perf-profile.self.cycles-pp.__mod_zone_page_state
      0.31 ±  2%      -0.1        0.23 ±  2%  perf-profile.self.cycles-pp.rmqueue_bulk
      0.10 ±  4%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.policy_nodemask
      0.17 ±  4%      -0.1        0.10 ±  8%  perf-profile.self.cycles-pp.mutex_lock
      0.10 ±  3%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.alloc_pages_noprof
      0.52 ±  4%      -0.1        0.45        perf-profile.self.cycles-pp.page_counter_try_charge
      0.19            -0.1        0.13        perf-profile.self.cycles-pp.__free_frozen_pages
      0.09 ±  4%      -0.1        0.03 ± 70%  perf-profile.self.cycles-pp.copy_page_to_iter
      0.10 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.uncharge_folio
      0.08            -0.0        0.06 ±  6%  perf-profile.self.cycles-pp.uncharge_batch
      0.14 ±  4%      +0.0        0.17 ±  2%  perf-profile.self.cycles-pp.__rmqueue_pcplist
      0.00            +0.2        0.17 ±  2%  perf-profile.self.cycles-pp.__mutex_lock
      0.91 ±  7%      +0.3        1.18 ±  9%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      3.79 ±  3%      +2.6        6.37 ±  2%  perf-profile.self.cycles-pp._copy_from_iter
      2.24 ±  6%     +43.1       45.30        perf-profile.self.cycles-pp.mutex_spin_on_owner




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

