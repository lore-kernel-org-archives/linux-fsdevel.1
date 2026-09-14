Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3594477E4;
	Mon, 14 Sep 2026 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789397276; cv=fail; b=pqafucEC1ezAahfuETR+ZRR33PBsdmeTtv0qEux1BsdW9mnFMPavq2O+RFe4AYpcGlnh7QD1hkhT6hIVmhmz69mXM72b33QIAWC82LdVKK1hseWQA1Ank8tXNLKZvp2SvXuMwX1bqKEkEzbCE3ghW4bkXDZtqJ/LAu4Dei+pNLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789397276; c=relaxed/simple;
	bh=s8V1b/hUX9i1QBTSPWrk2yufvN4B2PUyrp8FM8DIlOI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kFsMBJ2trLi0AkeBcTQV+NN7IIfEYmopkndOQ01E+g0UeEIPIFxutMJByW+9jxubflShgO04hGTcVWDq9T58dJzFPoAprQFN1KgDDnk2YGTYUiHFQCuDirifGimlXVdeLk4jbJ6CA0SHW4Nm2JN7sAso6bFnsnjT0LTIp41oPBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZ3ZGy3B; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZ3ZGy3B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789397272; x=1820933272;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s8V1b/hUX9i1QBTSPWrk2yufvN4B2PUyrp8FM8DIlOI=;
  b=dZ3ZGy3BKLdTnkQ01yJrhLL8h0DjgjAFLZe7jpbT0ybA76InKFDTGl0P
   pm1iYM9dDpUNIJf7ev6KyFkOL98JVH3HuZTwiQx35gdcnaencSqAfcz3i
   FEXH3z0AploaeqgqHQgOHe2EqfvYT/EWNoaU0flpUCzNJTScWRBVRbGVH
   7YArYCBaOyziOb74cOxRg0Gcew2Lx0HyUiZHESBPTThB8JZAbGGXC/ti2
   YAhkXkGuMLqfEb0bfvJnUlqp7ZSH7ZVAmKIP5iv79iODYpuZI7pg8VYhd
   1qbWilbLYx9XibbnsLRn/hohN4OKrSi9bEB2Mcww1Q5cC9MxGy2Jp5E6/
   g==;
X-CSE-ConnectionGUID: qJVqU4KhTlG9M5CjME+ryQ==
X-CSE-MsgGUID: /EQHpkr5TwybI9e2yCfDeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="101267189"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="101267189"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 07:47:50 -0700
X-CSE-ConnectionGUID: dpsoJ0XIT9qRHUxmUki+rQ==
X-CSE-MsgGUID: xolMcJFySg2RqDHk5C5D1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270032004"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 07:47:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:47:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 07:47:48 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 07:47:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d0EIMaeLRrzxH7a9sdFb+pUXJepbgwfHGhEAtq8QvbURbL3owCwofRTEamGajhRf125Imn4SD+RLbD9q4ztRMUUs8z59XqegBR3cRUWRmY1V2BebGcNszaaCJF7oK+ll9sDPDABNBFYQ2WGndsXIOcd9F5Mqhn5d2nUam56jHvksh4vsBZxsjvhLDzzQjhs4cEDSn4Kg45YKe/yDWwf5nyPiGdrZiFYtjElYbNejEHUCxLyMfQKvDLa9/GayrYWuAOPw30jy0rHkU2PZ8M1mgCf+VfVrQkuSgKZ7WB2g/D14/eWYi1FwQzYlgDzgZIo9ZH9i42RmSkCGfbkOxy1FSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLJZyZuxLmH5xg4U8Zu2bhbfeQ9iXNdFvKmIT5Uvklw=;
 b=Lk8agDADgnU4RBI5Yy71YhKWbf8i6fEARCokCA8cyiWEPhPr4rwILk6VKkPmcR6RytDwrIe8rrbJV9iqCb1JguwIGt4pD8A0ncTnnTe1I2Y0clZXtGPaFqxB5hQGzOiQfkiPYMl2bYeOIMZg7FaPuH41KbtyCfrYOtrbVrBV3q2Oj6nlNHW0PwYAGhcSLWZeQYzwRp76kkskLWeSGtLWrF5mmOA7y4G/JvjbFQfX4FiUq0wTB9CZIGU39NJqa6scXBLMiLnJzbBZ5sJlxSRGO8tMV2oNziY9YGAvcU2mWxGe5onHYC+zOl7iXBmKuSGKvumHz7DpYIl8lE5/ZH+L8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CH0PR11MB5266.namprd11.prod.outlook.com (2603:10b6:610:e1::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.12; Mon, 14 Sep 2026 14:47:45 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%4]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 14:47:45 +0000
Date: Mon, 14 Sep 2026 22:34:20 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Tim Chen <tim.c.chen@linux.intel.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Kees Cook
	<kees@kernel.org>, Christian Brauner <brauner@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, Qais Yousef <qyousef@layalina.io>, Aaron Lu
	<ziqianlu@bytedance.com>, Srikar Dronamraju <srikar@linux.ibm.com>, "Vineeth
 Remanan Pillai" <vineethr@linux.ibm.com>, Ricardo Neri-Calderon
	<ricardo.neri-calderon@linux.intel.com>, Lu Wang <wanglu.priv@gmail.com>,
	Hyunwoo Kim <imv4bel@gmail.com>, Zhan Xusheng <zhanxusheng@xiaomi.com>, "Zhan
 Xusheng" <zhanxusheng1024@gmail.com>, Yi Lai <yi1.lai@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/cache: Introduce task_struct->sched_cache_grp
Message-ID: <aqgF7JHKxQaE0W4b@chenyu-dev>
References: <cover.1789061845.git.tim.c.chen@linux.intel.com>
 <4532ec4fd5beb829bccb85822a19360fa4191fe6.1789061845.git.tim.c.chen@linux.intel.com>
 <20260910191901.GW776954@noisy.programming.kicks-ass.net>
 <72bd9014ee83d5833bc1c78379ead84458045867.camel@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <72bd9014ee83d5833bc1c78379ead84458045867.camel@linux.intel.com>
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CH0PR11MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fcf6317-e225-4843-42a7-08df126f2348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 1zx5DzVQnDuc5bY6DMUEr/I8+CbllqyzZ+EZvryHBi2CrTGoe/ZshHyF856ueN4AVUyaFd9TIaiWzRemdHNc+8YkJQ34caq+O6gkmdprl5NXlA4dBhfgE8+iT3trJ8bVzxPOf++rrr2cRJeJE8tFmjYOUku4R2xCqdt/MByNxOpbZzQ8p3ON37MCTjeJB0+eq/qjDOnApxwkk2OgSdLTTWhIylUiUEJavRGya+c0QunJrAZaQ37NqcI0hjkUVpgmdx3tesCZtIhwwbywIkyW75EH3tHxuuuP4tPq2VFUoGWBMdnI8CxY6R5cfLDncU3+O1kPL1WR88bcmzSNBxqZ6OyBdd81DY3wULnHuts3Pew69sYhnsIpvWwGwBYju67qe/zFwNP7fW9XWRg7jUDyV/z79jsSGiavzREhYEssLaZcrDGou+7QGwwDxOXgz3mNxhbdt7Uk3bZUAfemGtUSMuISwaHTgkewJKt0QdpIkwRN0wHICnNEuFmzcCT/D3wC2eLAMjg470wtZdbtPA4A3Bp/UiypYkceib4pzN1eEr+DOzBIAOOi1hxFnVJ1TletoIqDLUCevFmXkDZlwlna/iG2yd9Xt0xtgg9FV35pBQvmQZtc0cWZIsiT7tl5o95ijnr6SLBPl/u+bz9RZRlNqZkJN6hRlXXc7ZxZmJDzt08=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pfod/p9Uliri+dLt0Hf2AyLEY7z1ZSyQlygntdCxaIXAiCQd5f7TAwqfX2k/?=
 =?us-ascii?Q?oWAHQt0pz8PLiLysCNsh4RPAAKj+UJxZ8lXxeNrFA4YewpQGPJ/pYHzpdhoZ?=
 =?us-ascii?Q?jgQFKkn5fxfoOMpr9tFF7GBeo+wey/brGJjHDyVFwJx6+qowBDSmX5ihFu8w?=
 =?us-ascii?Q?iTFn06wxbK1nK/CSnl3o3cr3ELBOZmEnCQbhWxYyEGQ7FP8ualsPQkxAqShT?=
 =?us-ascii?Q?IwDQjWv3u/UiXh4HkEczNAPm7U5QgAq3SnMKuCt/VsXhH/0U7Fyft2Lajiyn?=
 =?us-ascii?Q?CZtm+Eb6q3JUltnAeRN0YmyVNs4nsWFi18M5FBqz7QM5lHU/neDBxH1BCo6v?=
 =?us-ascii?Q?4VNi2j5erVX6ADJxmENd0aqvMIJepqgWHGe7PE3j7uZ8fXWDD9F2u/FkgoVC?=
 =?us-ascii?Q?iROj1EAGD3IIFVgQc4rbO/yKmL1UjuP3wPYRDfeLMuzI0OEsUv+11QXMpDel?=
 =?us-ascii?Q?n3xg0YkhByp0AjH9w/ka2yGpy7ZSVHH5oXh3nTRQh98+GQAbk/J7pjg0tvJ8?=
 =?us-ascii?Q?f9HgWrwxhFbFO8RGjfUE/WlKPrpAtqS4fMJz+Dx2p0fRAjPkXmb/yQKWTkWn?=
 =?us-ascii?Q?dK9PHfUUaY6/PU0TQkr1MdlmOapsuxwZUa5zHr7CnpT8JTyEQdDrIvQfyJM2?=
 =?us-ascii?Q?6mP98wHiNQ99cR1A1jsjn+L4rpRDzfb47igngeayaFa+2dgTyZ4qB8BezGNF?=
 =?us-ascii?Q?e3U7vmY3J7mRM1OoEU3eWLSsn+EU+x8pnJ5QVK2bcCJvqb7Ewv2ioNF3IGZ4?=
 =?us-ascii?Q?/cevcaqm00rAaDN8AkDdGPBS78FmFTZQm/eqWtRQjQNg8Sm096Cq7xoH9/gd?=
 =?us-ascii?Q?LEFRvOw4B93zJSSFkqgCrnSjJa9lyWiodHDqpH9DWgARwhqsT+eiRztP9y3R?=
 =?us-ascii?Q?CIj/urfw9stIdZ6pNX0I8e9PPiVuhu1uFDHCNOaS1E9s6/9nJ9da0Y1Fd0dT?=
 =?us-ascii?Q?EziV4N6eDzDibjkH43AFvRJMatymYrRrBsqGmCLMg+q0rFQqnBDvIuhzKXTd?=
 =?us-ascii?Q?4nV57hiM5WV2iysER/9siFow4coyHXOJbzDQ8JzOtYSyO6xWbQTN36Vpb2ln?=
 =?us-ascii?Q?luWahsYlHASUJXGwWoNJ7QVVGR8risessIU9oTqdm37OOqi1XmfO7qlhXz54?=
 =?us-ascii?Q?GrHjoB5ge6ncFsvxokKPxFwLkp3uMqdIj+TLX+3nySEvZkrYO0wVD+UmgMHu?=
 =?us-ascii?Q?0hQdM8DrXCC6GFpvPmr+QVgeZinaIQEjbJBEQsZJGNUtX77VQMIzfpwPiv1C?=
 =?us-ascii?Q?qslfYoPinPv9ss3hG+SPVV+3RSits0CkGhod5Pl1X/ZPN9yrPsQltBI5jsx1?=
 =?us-ascii?Q?vrv/vAVnvJlNDQrl4S75axy+Tr28Vx2DIs1d078aRKow6/qOAh+syKEQ3A5D?=
 =?us-ascii?Q?d2ZxUOSVD1dh6fYrFv8WKoqxiW6iS2HlTniqwGq4TJf+wVLytoIceS6rTcfp?=
 =?us-ascii?Q?7fsMXZjlq0Y6wNKJa46MXKDx3H9QHkWGESzjzJijQ09dS4N7C4HcBkqZfGnb?=
 =?us-ascii?Q?FeoZaulVJn8OGnjEEW5RU1+GLsewpvWOEsrYP9Ak2iKhg1XgydchZKZK5ive?=
 =?us-ascii?Q?Y6bhYV69TSIp//PFIobIVGlzro63BXhF8nm0O5jSItZ6jfkIkp3dLAKi1ny+?=
 =?us-ascii?Q?2I/vTvFuXU4ZxW4d8B16kr49zZUvXrwgDtwb0X3vgO7dVE4wjQh6soRGRyLk?=
 =?us-ascii?Q?wENMsZFwqRpwm1tRQUmayBL+LCg5tYHvqDed0OOB4BDihS6YsXD9Zqubcgj4?=
 =?us-ascii?Q?+2Gsj7sC7g=3D=3D?=
X-Exchange-RoutingPolicyChecked: p9a/JzOJkqs2jz7Y/KVJxAt0RnsHrQy2oYkZQy16tGs75IMko2Wl59N1A8PPNlv8Ox6ceKrSptBsKf+bsP++bife6Vi/+vaVbFN/UDPxm2a8SM8WfmGZxDDFhac0CJ+bf4nNJ/LOSeQhtx70seHzeyZhBbceu7fbf6A8C8rrs29Sm6caiMk2ObMJOv176M46tqrTCepQDymgYB6cYvsI/sR4HZM592q2tcbzmYZxpz8Az15WWSBWtS+wSah4oIA3PfWGOdBaPOarSVgb5uhvFyOnR3Y1H+LybObFFuJDDgqhG91QWRVn9zPblvEu0k6ZvGExlSnm7wjI/GoxlR3OWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcf6317-e225-4843-42a7-08df126f2348
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 14:47:45.4134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raeI3PrjPuGlh8FQMWzFK8wcFM5lk8MbKznPuPyBzul9WU63+LZgedhCreCOZOE+YmRem13bwDzpTxEd0DPw+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5266
X-OriginatorOrg: intel.com

On Thu, Sep 10, 2026 at 03:50:56PM -0700, Tim Chen wrote:
> On Thu, 2026-09-10 at 21:19 +0200, Peter Zijlstra wrote:
> > On Thu, Sep 10, 2026 at 10:46:12AM -0700, Tim Chen wrote:
> > > @@ -882,6 +882,20 @@ static int exec_mmap(struct linux_binprm *bprm)
> > > +
> > > +		old_grp = rcu_dereference_protected(tsk->sched_cache_grp, true);
> > > +
> > 
> > Also: rcu_dereference_protected(.c = true) is another offence, that's
> > just wrong.

Got it, will fix it.
If I understand correctly, the "c" should never pass an explicit const value?
The original idea was that, in exec_mmap(), the current running task is the only
writer to change tsk->sched_cache_grp, so the condition is true,

To fix it, it might be turned into the following for now:
rcu_dereference_protected(tsk->sched_cache_grp, tsk == current);
like deref_curr_numa_group().

In the future if task tagging is supported, the race condition of multiple
updates would require a pi_lock for this task, and it will become:
rcu_dereference_protected(tsk->sched_cache_grp, lockdep_is_held(&p->pi_lock));
like what we have done in the prctl based cache aware scheduling patch set:
https://lore.kernel.org/lkml/50fe2db1a62ea2376a87d0c14778b1ff456d11ec.1787955777.git.tim.c.chen@linux.intel.com/

thanks,
Chenyu
