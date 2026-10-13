Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF67391517;
	Tue, 13 Oct 2026 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877979; cv=fail; b=HJLQDr4GwkzcOd55SnLxxHAhs1DlPXezCduKyEHskz28h6iMUFYGco1aJi1QtxZH7+4dInXeJx+Fsi/L+fF4RCtyi2Xrjd/QssoH13+gIE5LHmBAdaHkB0r0CW6+ke3A26M9b9emS14EdDjQQFBm0jllRW2bUxEVjQ/ero1SJu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877979; c=relaxed/simple;
	bh=dreqVBQf760MDy+hEHuLx3EoIrajH9TdQgCJ2Ly2HOQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BwtRis5yYc7Jy06v8c0tU4GPSnve4NOaywtxcdriCjNEqz7f28yeseJEki0TTg6NyfZbvWvpB3wp+ee3yxFs4ol5mBkjRaSF2uMtqZQdsUFgZZkY8dgbFnREa8xajlvzYqGbN+50BbsynKIjgiAW9eBA5QSvNX3D3ULl1rQdEIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WjsTQ5cm; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WjsTQ5cm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791877978; x=1823413978;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dreqVBQf760MDy+hEHuLx3EoIrajH9TdQgCJ2Ly2HOQ=;
  b=WjsTQ5cmHTE3ZbXqsz0z+SbEZ284q0dZuub/Q9r3VDMuZFD9oHSbKQVN
   vanLJt9ySIp6ywgE8kMMOtoWec3OEzOa3TyrSCAHjk7tMlWvR6ht/OImv
   8+7rchpKXe3my7Nmn3sYimg2suj40il0oeXrTQS0noOAezZmSS3WO96tC
   l2DBsVn2NwaNFdcl/ZOYPsm0YXI/0wIjcxg7oI8O0TlCTgi1K36XHje8B
   60vm18NNr+mMQlpwE/cayXcUoltAf34ou4EdGfAAmagVV+yQCNXFKwQj/
   j9THw86BY8A5ZYIMIEk7Y+Z8NpqK5WPiqdgX7fLr9MfQnHSdBTX8r5DWE
   w==;
X-CSE-ConnectionGUID: yneHmMBmSkS6yzKA7X8ifQ==
X-CSE-MsgGUID: LGuDnL9uSJ+0yS8ZARJwGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="578958"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="578958"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 00:52:57 -0700
X-CSE-ConnectionGUID: MMv47SrZQd+T0+F4yuTM2g==
X-CSE-MsgGUID: vYdVbNSwR+ant39zsFc4nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="2859991"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 00:52:57 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 00:52:56 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 00:52:56 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.67) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 00:52:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aA/PqCQDXw9DbT8bZKVZj1TeQ/ghXMjsEJsrDaMYCdUSi0NHW8oXFZj62kMPZupRTRUBOJvYU5lqoPoMY5bPBKLZ/Br1UOonMy4du/OHE4T1BHwv+lSP576aoebevKZJt1T8oIbCtIdii/jwrblxxhkeBYqxIYmIQuUUCkazMLvOYAPfbtRqRB4VslX58FQ6EI8l24ysxFMsZ2h/TcSEfEqzx6pkfQF4cY1SVVptl4MFsArOddweslZmpAWQ/11lTNdUESJHV4zHwe88fJ3uVFrW1QvQZfR//ASO4tJMRNbVAC/6ju4aYQ/Hc/86RMbb+GmaxknTRz2Pxgoo5fNv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eysvfIafey48tpJWYc7qiGSFM726FJIEuLlCCuGfzA=;
 b=og9sn2exB0mtGsNFRd/5eQFYXi+xkn2M3RIb/LFR3300o6BtEAyTn3GmyhZNVai0XeONLT0KFSE9/kz5wLPILS+NESSmh/6zM65Y7TPEqodPE9xV+ytpHfN/f5xTILQTqj7JGeVZlxCgjhcPKR3IVBS8Jf4j/g4BINkjD6zyXXxFDmNY2K8MfuGy5PY5ssXGzoRykcYyR/LRXe8LnzRlD4aQx0aiY80q7Zp7lpI/A/N/wT9PTYKkD8Q9zQ8khn45+zKyBa8CiqBtqnWKVuKiSCzvVbuDGUOlfL57++5zuo7UeD3uWLeWBqBjGFNizkN4QJ00NkapIxGVxgEWnAdMrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 DS0PR11MB876909.namprd11.prod.outlook.com (2603:10b6:8:3de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 07:52:54 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%3]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 07:52:53 +0000
Date: Tue, 13 Oct 2026 15:39:47 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Li Zhe <lizhe.67@bytedance.com>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kprateek.nayak@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <laoar.shao@gmail.com>, <tim.c.chen@intel.com>,
	<mkoutny@suse.com>, <david@kernel.org>, <tj@kernel.org>
Subject: Re: [PATCH 0/4] sched/numa: Add per-process automatic NUMA balancing
 control
Message-ID: <as3gQ8jfa_6eBf15@chenyu-dev>
References: <20260908122446.56708-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908122446.56708-1-lizhe.67@bytedance.com>
X-ClientProxiedBy: JH0PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:990:76::22) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|DS0PR11MB876909:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e37e706-45a7-42ed-0ff6-08df28fefc84
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|56012099006|11063799006|261009223027099003|260925022911599003|260925021911599003|260925021311599003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Q2IMvD1U/SACy7Ujy/KPTguA2VntHlStIFeFNlK8uR8xUbEh9Wfh/2zO/NlABAK5QuzbXzSuys/TNcEX2pagsErByvKw5nkvtz4MuwhuVfAnffh1kobKDC9PEKxeoju8HBlZeOiwJsaZSfUO7UeEInj0JNbZHJYnkkSJ2JzWjCdKBEXV9fqktqDeVfi0arp3fCcibbe4s3d3gG7nIUK9gXeEax7rvHATtX6T59Qy4TgfwZfPhWaFb7i+lSmXm4ae9MGtFZy4Ks4ENlJzyH1lBemyZ9UC4M3q6O3V/B33es4EVKZzOfqKLm2Di0k2CHYlAVTjQ8goMi5AjDXuwT5vZxPwPZRZJ9BwP4ahFweGio+39N5DEmOWw5TToO0QUSDhNYAKWqEoaeIfU45c6xe1WT/9sOyK/018SPtSxa/fbuor3tlxAZ8dh388WvfKHIK2k1zsPsAtqOJrAuNguQoaaOJeTFMflXx8NZHpimI2UD9ZB0i8lSabgtful9NpqgAMUA4Ck/2qnO3fk4WHf07QdcA3T7D7oBzusuEQ0aXWTWOscW4GuDZDmJ7q6jLD+ocsp9HfWkFEbZ9UXcumw0N1NxtJYn02lL8T0s6woyTFzWAyF1lVrFgvqNWZ2K/Jb7V4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(56012099006)(11063799006)(261009223027099003)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kRXu/NGeJAkmt4/H0Dppw/9EOck/1T1dPXTvE8ul1R+eZEWrkCe4bXdaKqkN?=
 =?us-ascii?Q?WmeEMMjc+Af3B42LV0D03/Dr6hHnL5B6U83+E3gFKcW0qlfIRp9wv0PENyku?=
 =?us-ascii?Q?BoXCgVjXxW0zeOTFUlENbjrb+T+8CwwdczX7V73Y8dvCqsg5HESN8Lzydg9b?=
 =?us-ascii?Q?JNjvpY+5JhG18URzR2SvSH9KpVBlLVam1XNs/EYiUe5PUcqX7poQcsS0V1Us?=
 =?us-ascii?Q?zI1K8H1fP7OZ50PNiYtQciAbAqvVF3isJss0iLwXxlcs68EWTRu/oOw4t3dD?=
 =?us-ascii?Q?bxWutxgH0EgqVZ8gYVZGlPsBzfMsMiVB2R8zaOFontGriJ8AdTC1gru5dIBu?=
 =?us-ascii?Q?PON/b8LfgDx4F5zvd7DiF7r3P4pu+Ce0oksSNcEyV3taIObeQPOZwJFlBXp4?=
 =?us-ascii?Q?u5rW+pnvZH5atMHPthZnNWX1dFEYjs9+ynVL7tS3Q10vtCyM/N3aKPP2cRLq?=
 =?us-ascii?Q?9o9H0G0iDWW6u9O/h5KT/Zr1YvV+mOzzHYuwXzA5BMV/gphaNKhmBtc7g6jE?=
 =?us-ascii?Q?76QHplSkQiXS6GKyjPp62H3uv53ekWVl4jspr6j/v6UneexXCPAqpxzP7wPl?=
 =?us-ascii?Q?yPaBcR9d44pUi2lm3+O18qZqEslci3OOB8BpUOBU4gt8xvGp2Pr28BH38uGQ?=
 =?us-ascii?Q?PggPCLXtDHv6oHUbdoFkJPNtH/WWHGRbrYCUsXLfpQedWRiXlNkOX8HWY+A+?=
 =?us-ascii?Q?iA9D8sJT7CV/K/gofOEqsd6eGFvbGfIBoaobNNSvoJ15Lbv4ElLFwGSTZp14?=
 =?us-ascii?Q?IiGlNTtwUpPbeaElEU+amX/YXWZqKzCe7H2V9NyMhD8gWHymf7nAOH2L0bjl?=
 =?us-ascii?Q?3cNkR7RU6UJh/w+t/6XNy6FQCBumVklxaLiwiyTnEbITgDGlOZOp+fD0Gpw/?=
 =?us-ascii?Q?IlcarWpnhTPWU+YSKSQhJWj2UFApPBcn/2ePbvIe/Rco29f3j6azutzYyiK8?=
 =?us-ascii?Q?D0nvTPwF4FccQZEv/eE9fQ4MX9zBZ6yTu/iHTIvS0W6GVBrP/fSH8zyGu94N?=
 =?us-ascii?Q?Rf8Zjfxv0NBwvUpWOrryZ2PsPYmLfHRsveTLKrTZa+dzSzRo0tVJzBhj1c+A?=
 =?us-ascii?Q?zTVioKyD3YyMaBtReAGG9vYIw4668Q5jyUn3f+M6+RsFwIqqj+I454aJiwj+?=
 =?us-ascii?Q?rzIOMzGIVdwgJc30rvrqS6S/D51YK2PDJFyqaqye7mxKOEnsNZH2GAibTv8O?=
 =?us-ascii?Q?3Rgc5OsoSMOznkxtsvTvLQL8lL66Grg2eiDwj7Wj2gdjb0RcQzJVzZURcy20?=
 =?us-ascii?Q?/EzS+kHaYXN4ebbaTek7PIGsc0WLYrg9tsSXlVdbRAWVO5601IJm7SbOxQo2?=
 =?us-ascii?Q?c/+dlxMbkgUQ5sZKRrEyMMI3RJQ6KtZmI7z9Zr+QF1tUO6q6WZ3pWeWgtqjC?=
 =?us-ascii?Q?Q+SY0teVMiac8aBXpYQ2fr4202UENGuWbaBVICPBeWIUWd9CHsxzc2C8eus5?=
 =?us-ascii?Q?DgwJHTtAplh0ZrnMx3Qpp2ZELpjYfa0jglObz0qWPt0BajoKNqjKWxbsurLK?=
 =?us-ascii?Q?Fe+NtCY7ZoI06WYWTv3Las17/vewG+j0DWlRhvMLKV1k84nHUDgmkvDiY+Gz?=
 =?us-ascii?Q?J9wosBlTPyKi4gOwfhqKE91cCG8j257Wg/TQmSk15g2J0uDypofKyGA+T8YZ?=
 =?us-ascii?Q?c6EGYwU1QFMxnssuVp2hetdtJ/xChbCsHh7Fh5sK5vJJ3lp5FJRNyKwvV4Tq?=
 =?us-ascii?Q?simQols9JqtibSktSNYeNYbT10RkyvF57vy7NOkzCGti8g2XerMjxcv28kse?=
 =?us-ascii?Q?IAXqZ0JXsA=3D=3D?=
X-Exchange-RoutingPolicyChecked: ejLOsC20FQCQljiKR/1VHehM72DiBzJwzOssSMWGIrgbzCt16FrFQgd7v721m2DHkch+9yoehulrzLhQYD0MLE0SHEyg1ygJ7i2IPe0J5/dp/sn3uUpR14rKRkhcK122wIHE/HyYwCe8d1jPET9qxdMcC3EA/lnTLAVTEijjFMxGCSp4US0BlywVeMxFQA2cICT/86ibftDJOCO5kvEVTqYbUylqyij3mfON+TdZLtuXvmnjGuB+iQvt7aJgf4u4aFm+sbZhukL/BjPo222iv779oCooRIFdXi7rMcwbB29NXp6Z5lXh3Q8e8SlPjpdw/L25wx1TdVI/SnBBpjjxJw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e37e706-45a7-42ed-0ff6-08df28fefc84
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 07:52:53.5583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GWC9AGR2k2pX3KYlEJPIpOnomokVfaOwm3nB6fbQKtgVTgjejtY4CYvVHpAi6oUQuRN05hVuaCd7U/RDW51o+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB876909
X-OriginatorOrg: intel.com

On Tue, Sep 08, 2026 at 08:24:42PM +0800, Li Zhe wrote:
> Automatic NUMA balancing is controlled globally through the
> kernel.numa_balancing sysctl and can be influenced indirectly through
> memory policy. That works well as a system default, but it is too coarse
> for workloads where a launcher wants most processes to use the default
> policy while a selected process opts out because it already manages NUMA
> placement or cannot afford the sampling overhead.
> 
> A recent per-cgroup proposal tried to address this by adding a
> cgroup-local enable knob plus a NUMA_BALANCING_CGROUP mode where
> balancing was disabled by default and then enabled for selected cgroups
> [1]. The discussion also noted that automatic NUMA balancing already
> operates at task/process granularity, that the knob is not a resource
> control attribute, and that task/process controls such as sched_setattr()
> or prctl() may be a better fit while cgroups and cpusets continue to
> describe workload grouping and placement domains.
> 
> There is also prior art from 2023 prctl() proposals [2][3]. Those
> versions used a per-mm mode with disabled/enabled/default states, added
> NumaB_mode to /proc/<pid>/status, and changed the global static key
> handling so a per-process enable could override the global sysctl.
> 
> This series takes a more conservative variant to preserve existing
> administrator and workload expectations. Keeping the global sysctl as a
> hard off switch means an administrator can still disable all automatic
> NUMA balancing activity with one knob. Using a weak two-state
> per-process opt-out/allow ABI avoids exposing a "default" state whose
> meaning depends on global policy and is therefore easy to misinterpret.
> Storing the configured mode in signal_struct gives the control explicit
> thread-group semantics and avoids making unrelated non-thread CLONE_VM
> users share the policy merely because they share an mm.
> 
> The series implements a per-process interface: a thread group may use
> prctl() to set or get its configured automatic NUMA balancing mode. A
> process can opt out of new periodic NUMA scan scheduling and NUMA
> scheduler accounting, or opt back in. Existing hinting faults and queued
> work are allowed to drain naturally as the disabled state takes effect.
> When kernel.numa_balancing is 0, a process-local enable request does not
> override it.
> 
> A separate task_struct scheduler snapshot is used by enqueue/dequeue
> accounting so the scheduler can consistently account the state that was
> in effect when a task entered the runqueue. This avoids changing
> historical task accounting while still allowing a process mode change to
> take effect through the normal dequeue/update/enqueue path.
> 
> The series also exposes the process NUMA balancing mode in
> /proc/<pid>/status and documents the new prctl() ABI and its interaction
> with the global sysctl.
>

Can the global key be extended to tri-state, like the THP settings?
To keep it backward-compatible, echoing 0 and 1 remains the same effect.
The user can also echo always, advise, or never to it.
We have a similar proposal here for cache-aware scheduling[1]
In this way, the user does not have to disable NUMA balancing one by one
across the whole system.

Yafang Shao has a bpf-cgroup based NUMA balancing proposal[2].
Overall I support fine-grained control of NUMA balancing, and I'm curious
what the possible setting would be in the production environment, would
something like Kubernetes be responsible for setting the NUMA
balancing attribute via prctl, or as Yafang proposed, leverage cgroup
interface?

[1] https://lore.kernel.org/lkml/fd341106e7e6cbd2f047656650f43ee87c6633c1.1787955777.git.tim.c.chen@linux.intel.com/
[2] https://lore.kernel.org/lkml/20261012120438.52849-1-laoar.shao@gmail.com/

thanks,
Chenyu

> [1]: https://lore.kernel.org/all/20250625102337.3128193-1-yu.c.chen@intel.com/
> [2]: https://lore.kernel.org/all/20230412140701.58337-1-ligang.bdlg@bytedance.com/
> [3]: https://lore.kernel.org/all/20230412141127.59741-1-ligang.bdlg@bytedance.com/
> 
> Li Zhe (4):
>   sched/numa: Track per-process automatic NUMA balancing mode
>   sched/numa: Add prctl controls for process mode
>   proc: Report process NUMA balancing mode
>   Documentation: Describe per-process NUMA balancing control
> 
>  Documentation/admin-guide/sysctl/kernel.rst | 16 ++++++++
>  Documentation/filesystems/proc.rst          |  6 +++
>  fs/proc/array.c                             | 16 ++++++++
>  include/linux/sched.h                       |  6 +++
>  include/linux/sched/numa_balancing.h        | 42 +++++++++++++++++++++
>  include/linux/sched/signal.h                |  8 ++++
>  include/uapi/linux/prctl.h                  |  6 +++
>  init/init_task.c                            |  4 ++
>  kernel/fork.c                               |  8 ++++
>  kernel/sched/core.c                         | 39 +++++++++++++++++++
>  kernel/sched/fair.c                         | 36 ++++++++++++++++--
>  kernel/sys.c                                | 18 +++++++++
>  12 files changed, 201 insertions(+), 4 deletions(-)
> 
> -- 
> 2.20.1
