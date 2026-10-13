Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DCA2BD09;
	Tue, 13 Oct 2026 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886081; cv=fail; b=m9TmvtKWhYScT7/Rh2F2UPGlEZ3au2mtoRjI3Iu2Zqe0ozKhzHqWDXMM+6Ax9C+O0N7QjQDzBNEJfoo6jxKXs/7YS/gaMs4p22UuwMjrpFyy8C/QAqX41ZyTiSSMnWAh1lV2v89Bvvcv1oqVOSHMyrbbVnay73Y84rorYQgglp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886081; c=relaxed/simple;
	bh=t9/9hFbp76rW/eOGOYFuoECnpmf5Cha6EgSCXKMV+ng=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yizdf3O4dOKAopTTECsJHGXoe2RPI0PptgpnFrYzICkm4H3Vbm3EqV66G/EQJfj4pNNwRm6KlegJjIWqFbg+GcDB93/R85+D9wj8PuEqw3KrT5YKRWimdBj3VzmO3F9oYqyHcwbXp+0VZ3KNwVbGcT/ENwU5zVBYG7RURDpq/x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OLGNK402; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OLGNK402"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791886080; x=1823422080;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=t9/9hFbp76rW/eOGOYFuoECnpmf5Cha6EgSCXKMV+ng=;
  b=OLGNK402fxhxQqNPTLzuctyOWEI9Qedu2yPCloX3c5OT9Pp/GhX4qewy
   Nfjgh7KIHkmXLQ66mrrOSUQl6Rh6puyB0/kJj/kHrZUn34WIZreXy+sFC
   D2fF31GJCT+wUaH9GfemoX0q8UNeNVz+pTczIanjB+oJUaDPMTrMaVzcx
   mu+Tk4GakPQMAV4PDNADOQo9qWT0crgFCj11/DN4u+4i3CK+ypdOdgL2a
   zZHJXBl7+XxqNAoE5TPXgSexqFxXQmRruBTuUDuSc+WLN48AA1bOpJ+BX
   5ak1b5sGW1on71YJ6ZQ60QBp4ozG0lpOxzyxBBdVSJfjMsAm+3a7vgDyt
   g==;
X-CSE-ConnectionGUID: oxI4B0cdSQyIn2SKMAOFFA==
X-CSE-MsgGUID: dO0lQGk2Rq+UfeixKqhcmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="504986"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="504986"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 03:07:59 -0700
X-CSE-ConnectionGUID: hyuINJIDS4eggnS+AlFNig==
X-CSE-MsgGUID: ZdpY2wNCRD6kd6NZxVo0JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1456662"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 03:07:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 03:07:58 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 13 Oct 2026 03:07:58 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.38)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 13 Oct 2026 03:07:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lz1kOmjHkrjvjDogbljSaCkW+p5zSCED9xBuqNNAL2NAw/gRIhhh+krulrp4Sz+kwfgTzWd1sufoIznoOdK3FQ57Ztu96ZsPs6Mvdg4JlOlsPKJEkEoouKo5GwfOIjPO584WOQmSTGoknW697APhnLp2Ca2kQkUdtg2CK3t4IQYwN1N2AtIT4h+GA2hMAcC85jMZoYE53CXDT93s5xaV3uoiOAmIhJfWFOJlP22US3hmweH4nNJdzMx5B4NljmUgbu7jHKVLDdqEhXG2qCpqlWzYXWWcUW4u4QRv4wRwZeNzms7tmBgBSli+3lLJN8OkhPYgxVn8+29ypyxbv2KOqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQFXf0+JFYE0HwuB7Ng9K5SDmctaOCYy1jdkEQJQTWk=;
 b=E2tcMXZpgNit2HKfPrS6/mfNPsGC2PRMpFV0OzTAEdGv/BTU1H8VJcFo2ulaFXrzl0Cbmc3NcUP7Hxp7udoj5SYaUSfKibrBmag+dQ9L3ZiuKj3mTh/dDjsva/ZJKZ6bchIpm7Gc0MFo8u3tDv3GvPxBZ/7QZhJ2EwEAD2BoSHrsBHXE1z+BxzYne1QZOEjUOUELd9zcMFDxbbSYJsmOVsXxWLmJfIEp96yzayf/V/MPdfp0tTevZpRZ6Cvib/ulxG4S9pjSbhdzj1IscP9kSB/T2foogh188uwEboaKXjZSByyjRKfAXI1OJxedSew/yb+Vf7EOY97nvQgjKnDaug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH8PR11MB7118.namprd11.prod.outlook.com (2603:10b6:510:216::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.23; Tue, 13 Oct 2026 10:07:53 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%3]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 10:07:53 +0000
Date: Tue, 13 Oct 2026 17:54:49 +0800
From: Chen Yu <yu.c.chen@intel.com>
To: Li Zhe <lizhe.67@bytedance.com>
CC: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kprateek.nayak@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/4] sched/numa: Track per-process automatic NUMA
 balancing mode
Message-ID: <as3_6bNoAMkf61uw@chenyu-dev>
References: <20260908122446.56708-1-lizhe.67@bytedance.com>
 <20260908122446.56708-2-lizhe.67@bytedance.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908122446.56708-2-lizhe.67@bytedance.com>
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH8PR11MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: bd00fd91-4fe1-4cf1-3ab6-08df2911d86a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: WSCehTqTRthtVaenZV1Yj9LBHSmdOOTq3OBzB1Qu6Pmz5w0oKenIulUTofVsp1ET584StxXzgsNePoMigr1KAMMf7KzjzWFgHUS24q2b9ChfmHpJkLNUk96yRCFX0ixfr+E93w98Zc3Rk7DF+vr7rJvqHbVyXL408Rt27XZQtREHJwOJz5Hc+OWCIeyEGLufFAPXCy+Oa2ompfCgx7ZtD/UAxf5D4dD7RldTOXCITWpvSToOach2cWhfSqnwtSKYyRRkEVLzTpOW2bs0u6sr4RWLytMklVMhFa90FCVYixNLlNtT76vI39H6OttjBiDveIAd5xP7zf7WRtjGpr59DOTocDgxTu0pPPcLIWMmTIU5V3ZqKNwq3vjVt5rwItMvMzknRir+0WyTFNSwhdOQjKYESdUHdHa1dHITfgx2jdmIBqA7AV3tL0RKm+6gk8DAr9j3sFMlPsekFf4eHH4I7XozYDCKrvUAEeMWE7rYV7kZlmoBe1RfC5OyztP0f33SfEKJnEnyHqC1/zxlWn8SuOkmCbiWLokwpn5hBSLBmsxT3bs4PG+KDJ8GDzs2+V0QX7hU2ehbWnSEKJeTCc5PUlEGTLKXtgfqxilh4bOroQuxfj55I/EtLCbeFu108ZLehL/r9j+xGCS5Ct1Gzt/EK75/bD29W/28upAjTL0RuQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O5yWOEfNuCIShYOw0Pk0w2t9uPRITEchqv7ZL+9HgiLA/tt5DQHjz8jlGttC?=
 =?us-ascii?Q?ygfJpzf0QI36CX/Qh+UX2uSFxoL7ZO0bASq5enWMhnCJf0n0N0SFX/OAz+iH?=
 =?us-ascii?Q?PhSZwpEl8CRh5qLfCycOa9HiONsS9rXvoo0sUS+sQbR16GbggIgsipQO2J5v?=
 =?us-ascii?Q?zPDEDdZhzh0sWANzQmFnvdq39S5zy8j83sSOZP5LlgMq7IAsl1eO6mtZ5jQR?=
 =?us-ascii?Q?dDYOYGThJfePDGHuqMl2UBbJtm7hSFLTsWiWLDY68VZ0c1+SCM8CYDOZRuqw?=
 =?us-ascii?Q?jv9+QNofG//dqIdBS3u4qf2Q1RRNZwe3sGl0ODkVPdxiLn4XvZi2oQRFC4PB?=
 =?us-ascii?Q?vyTuvFXRBpJVU1pO1Q+XSP2CZKujpnytXVVUyUx/JGIJXYXc9m2vP9rx0f1s?=
 =?us-ascii?Q?IbmgUnwuZWfgN4gEep9tBS1cTW5oQTjAA8lqAE2IadpDQ6ViOllBZk8SXX80?=
 =?us-ascii?Q?RFwV4wQ0xG37VMRtqjmXfyKwACOWRd0XARdqTETs15x6yrW0GBkRnc1hqAIL?=
 =?us-ascii?Q?wzPql/0lsnyVyN4oAJWbpQ2LmSuGqRcZ/g0squxw6xJAl9F5FFOA1A8I7Zr2?=
 =?us-ascii?Q?pu+jJXhCaSgOPKYBCZyzi1nzMqbwhftCPZNYeHAqJhucTLDJ5vUXvgD5fvkT?=
 =?us-ascii?Q?laF6pIbMd0m8oMRS6DbqZ17VoNTKLbiGFZrM//quPh83eRjYV5SaumUaFrIW?=
 =?us-ascii?Q?IwxYslnz0T7eQ3za0UBFQnVNbbym78+xOXrOP0jTWafgWFG2NjmWP/QCzKV9?=
 =?us-ascii?Q?3Dwd2t4gdJZy4wue5oLJzN3KIvAeflUQxhjVmw55e8FuzNlJ0FWnlUn58r+N?=
 =?us-ascii?Q?/4W0nvubf8H0t6TIjJwyu9vwL7gaxKbfHEhHpebGI2wpzSO1JQ4DSnBgJNsC?=
 =?us-ascii?Q?k2AzAT06NnWX9wXdOJyvJ8OpkOUjpA42ED1ph3ZuxQzWam1HeHuTnkJfZLZP?=
 =?us-ascii?Q?pWeXPS8uP/j1h5QDtbnnf8Lu6dCbNdCwNF1xKb/5apcuDdR3O5EmxtahNoId?=
 =?us-ascii?Q?DVDT5978LInzyqmkJz3cV85DyMMtKVO8KtOv4Q2RgJwgL/MrQ0WharqTV1vo?=
 =?us-ascii?Q?qe78KmDEiKx/FRCvW4JnU88+JrwDzCSk/cuxOkZ0DXoOSh/zdTuzm08pyA4b?=
 =?us-ascii?Q?Qaz9dnC+SAJNstQ96LP4OwXpMz2Z4QtL5yQCp09a8LqsOEWtnIs5FXxiClKA?=
 =?us-ascii?Q?2M+glOQee4Evu3m/mPve7qzb8sEtm/aS0KyVRUOVhWeQQ4ISCuGfOGiWcO4d?=
 =?us-ascii?Q?iew6FXZ06i2FfSqH5/DrE0aoJXYHr8jOed+2DrmLCDQFpiGW3SBuSBCxrza4?=
 =?us-ascii?Q?znBHf3PUrQ3pab1MT+Ko3+3TIjnvzL13STfnre90puPK79QvspNX+3dDxjLL?=
 =?us-ascii?Q?qRKPG4wvA9MViwRSyZhFw61Kw5ct2R7Epv7kIRs0GIIborGuYAuQVMqY1Xy2?=
 =?us-ascii?Q?+esMAWuMbOqvYEW7XFR6ElrcD6cbQ7L3FmedUhHFiSS8sgO6pLhkDRf5hCf9?=
 =?us-ascii?Q?Zg02KpnuGIc+Eu2aZj0ZQUJEiVb8vuRAfarmE+xlI992py+3uDBA4QNdwX9s?=
 =?us-ascii?Q?TvbrwSW2bdt39zyyEShU7RJAaPqDmJlXfwWWNUKVyM+KQmpOPNNHCEbIwJ9o?=
 =?us-ascii?Q?LnB2Aviu7VOjiW6eHScgco/kGQVsjP7PwubHyObxJa9PSZ8Qnlokd/xTi8Ty?=
 =?us-ascii?Q?JMHnLMfqa3ZbtGgmAuNLByXcuJoKHllrRB5gT1cQ8rA+RcuphJpJW6IRHvhR?=
 =?us-ascii?Q?oXPJIABvQA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 3veaLkYh7h8JwQgUTGjFM4Oz7Q5XS0b+HzsKPOAecDQVHtWKLmfVS2ZzV7nEsQdfyagsubOmTYFYVsIuSj1BItgnhvTkZ5zoOXuHyIOBLeUYhuw/N6nBe2KwGRojC9Aj2TiIcDgMg+xq+gV4RHfCR9/BFNR/ucbYjxDdcNt0SZdikDadaZwpqvBE3s2piELNFjstQkLBvTCmNpn9dS7kmttl4d6pBu5Yxrgo/2+kgRdLmLFcYBFJnxH8xDsjdw4vGTTfzmdJAb1oToZJAVtzL5YUglbrVx5mDbMXHoO21deAf1iQr5ijvkpI78uBY6F7qSTI4TpGI6ug6WilLpfCaA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bd00fd91-4fe1-4cf1-3ab6-08df2911d86a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 10:07:53.3385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSXrXWRoiVAYrTSOpY1pW9MUR6CoiTeQFKe1aVUvNKq3ZxqlmNRv6aAShIsEPZD8XTvIRzxk6UqhWJRo4sqoiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7118
X-OriginatorOrg: intel.com

On Tue, Sep 08, 2026 at 08:24:43PM +0800, Li Zhe wrote:

[ snip ]

> +int task_numa_balancing_set_current(bool enabled)
> +{
> +	static DEFINE_MUTEX(task_numa_balancing_mutex);
> +	struct task_struct *t;
> +	unsigned long flags;
> +	bool old_enabled;
> +
> +	guard(mutex)(&task_numa_balancing_mutex);
> +
> +	if (WARN_ON_ONCE(!lock_task_sighand(current, &flags)))
> +		return -ESRCH;
> +
> +	old_enabled = current->signal->numa_balancing_enabled;
> +	if (old_enabled != enabled)
> +		WRITE_ONCE(current->signal->numa_balancing_enabled, enabled);
> +
> +	unlock_task_sighand(current, &flags);
> +
> +	if (old_enabled != enabled) {
> +		sched_numa_balancing_change_task(current, enabled);
> +		read_lock(&tasklist_lock);

I wonder if we can use the RCU read lock instead to avoid being blocked by
/blocking the fork && exec, which grabs the write lock of tasklock_lock.
Agents do frequent fork/exec, so we may want to avoid interfering with them?

thanks,
Chenyu
