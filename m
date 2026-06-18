Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF242EA481;
	Thu, 18 Jun 2026 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764620; cv=fail; b=YE6iZVJv9d9Vr5dOg100UW0EdW0A3V62xlqGddJvHCh1YbFXH1SE4CYwoS/1kVShBy/Ex9kVR5rbpgym/cPO7dc7Y4xhHZ6dRug86UEj72DK0demCYBjux8HIdYF0ZcoXXT92oMlooslY3UmQ4tn6ErsfKT/AMYRYy0giKLqEHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764620; c=relaxed/simple;
	bh=bAdgEBbJJMn5x/oYYUFdX0/dByCNqwFKQoh6qEPU3uQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=BBD5/tQLAUiOMDRyR3hDSxunVtlX7Y+Eor9c/qBF91V1yjtleL2UtBPpT1jsKtPdkIzHW/L0QhV9jkWJqiCD8m6i3P1FrRm8nup4MvDekcpXPYuNl2UtwZyxUlFrfRR2v+lXgcixpSBYuqme+hLfv+ktz1Ku60Roe1YF5qefn48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JThFIOiq; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JThFIOiq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781764618; x=1813300618;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bAdgEBbJJMn5x/oYYUFdX0/dByCNqwFKQoh6qEPU3uQ=;
  b=JThFIOiq3SRxEo1odnktguajnnI2zy3gdgvNgXamztavF4MdPTypbnQn
   fKOIMWSZ7BWHLpOaAuqWrfHsFmpP/hni/gAbl8LOV3hePM5ik6fL0cwaG
   Ks+jgYnnRBwZBNIG7lINwnVGmB0PAEZWxOywnNElKnMSyUanCHxLaq1BJ
   exH+9penXuEK6E105vww49bI9C7TwgVqLlGu6/suRR7kXEZgKL2+oaPOo
   8PUBmzwotXTB+dMebsXIh13dq/4j0mbMQ8L6bjUVYib9ApDBqNuS4Qabl
   Ev9K4fnDVw0CV3PZLEKEL5LXIjyhNoBkjgHCJMe+ITy3mnDTEwtoQG/5t
   A==;
X-CSE-ConnectionGUID: az+hiimXR2GXuB7i6u9MCw==
X-CSE-MsgGUID: lX43BCT3Sqi2gQeFZpXB8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="93964596"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="93964596"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:36:57 -0700
X-CSE-ConnectionGUID: UTcKUc4yT2yn17HIQS0pXw==
X-CSE-MsgGUID: +blSKouhSb2YduPs6aWxHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="252594221"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 23:36:57 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 23:36:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 17 Jun 2026 23:36:56 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.23) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 17 Jun 2026 23:36:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTfVLukW2jnU52ECvdLJz39IwkqRG7grEg7m77YJXUEAo8ZFf7Jyv0jix4X7pKnLWPTghhZbKR9Z7xVp2b5QGqBcwy9C6ioFGiwVGa0T55YFDf7O76GX/VxrTAFHC1n/PERvqXhSVG7GcMURXBHPlvoRzSMVKQjAmJcLAZ//f+K4ry4gFPO05jWUZJSBJmccsHmRScrc9DaCWltmy50U2i+TAZX1bHVavtaKctt/0E3J8zNORuYl1Vxto+ica3w+LxggxcnsOlFl00aSuYdQHmmiuSJ3foe03904s6BN35mb+S/IwkZ2ddDplTX+EXD+GcssBLHHR2+OI8pK4ur1eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amyLUSTG/Oil4H8eD+Sk9DMTk8IHvuAet3ILUq4B7eE=;
 b=oej/0PEPvV0D+FNlxB5LTeVL3UkpTju9euf/6GUjhyBQK8E4hvUx5eLduQqxv50Rs1yDp4KtRmlc/EkBiniospKn0D3FYZMxnN8HlwN7Q8mry4D/vE4ImUUB5UBTjQE6v6PHqM82h+dwGnLEgFgkp/eoe8JXe/oXewFAfoh6EILLKU3A4tpbT4QyVpYxbAbDaKklT9DP8MXWZpge0jch3LZuYCvJmD05QM1sRp33j6YHX2MRoSCEByd7i+p8E3g59Gn82fjsw8OejnY1efYWD91WGIvY+05jPYOyWIqG+Tc5iINVOYg/X7TWpo47wJbkwkC18fc9A32NFqgIe+NdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by PH0PR11MB5831.namprd11.prod.outlook.com (2603:10b6:510:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 06:36:52 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0113.015; Thu, 18 Jun 2026
 06:36:52 +0000
Date: Thu, 18 Jun 2026 14:36:43 +0800
From: kernel test robot <oliver.sang@intel.com>
To: "A. Sterling" <adam.sterling@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	<linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] pidfs: pin stashed dentry for pid lifetime to fix
 repeat-open regression
Message-ID: <202606180805.1b2fdd03-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KU0P306CA0061.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:23::14) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|PH0PR11MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca7278c-b96a-4724-1d5d-08decd03fbc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: Kygh7d1cFi6Hbyp7PCwoqqlnaIblD34GEmLPBhkjx35gxWr2srF5vu2H9I+sT/QwdO8dlQK1leZIAVJ5N6Qlhqbxtn1Jl/K43bW6QyWrAlWeVnhobochuq2wVAf2CFLsXhdb48+gTTbw/QzGnpcIBPuxMa9sS/B+IPNjtm5GAu5eVTJtrqlFQbSDYJTSou9pwdAPt+4iel1r5k5U129c6X250dPN1aezsgfv5cU+jBduqPfkxFXz0QD0/o4iJ9zX6fe1/3dwdez3NLAy+4drfsU5TJayN1j4eMYMmJ2N6rfyp5i4LxZ7ED91H3/MjSIk+jtxLGWzeKNZttTHwtYw4YF5Yncpk+1funhN47wNgveDvnEobVNK2i+W7VMzlU3T6gbbECorh01ax1C39vfBqwgy67+jCj+s2xedIDemTcXVYCnK4L48BVqS9e0NXRh02CBCf0kOd6vdE74O+LJ8ur61x3Li9eFvsKm0hE8dBbyqIGki5mo7AZjtPMdxIqtWVKtLlqcsR+/KPeHQYnOjSS9BkLOjPMri3sQbbaQgbvVMCi9RIP2nl8B8mqyMclCAD4cTcwUQYcGXOwoK9QNlQdazNmC/CuKztJxzxl8gh1ityZ320Y2xVQQF3WUmx5l2N6BI93/1lEYR2F4AyyEQw1mhqKiofK189LA0bh7crnqEAZ3tb4IWjRGio+j0VucS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hqJ3CJbuafn/UQKRZt0oCXdn+MyxQwXCt+mjcVH/hXOzbN5j6XwuAWWtzTIK?=
 =?us-ascii?Q?r9OX7aAvxdBlBSm5vpMltacRiv5uXp/C4XmyHjQdYyqUh0zW+u6Iwh2YVf7r?=
 =?us-ascii?Q?N+o7iL8dHZdJNlvWbjg3qSXBV7tlOD73ro7GbVOezWmWscxekB3f15W3D2w2?=
 =?us-ascii?Q?/+GvYPB6D907/KD9ya3043lXtf65fRJeAXWHdEHKLIhOC0gPt4i9EkHt1tp/?=
 =?us-ascii?Q?gMA37zbZkHz1yrMmLUT+ukYMPQoNUwpUNYSAzQDfw1HDpsz5W5gBJQeMYOSo?=
 =?us-ascii?Q?WbMVbe5wAjYu0eeH6EMlZYvtSfnRH7z0J98faK5BBO9HZCd9BpbY6YPbPOtf?=
 =?us-ascii?Q?yRgXVLkp31Fmqy2oxqZhhIXPzS0b3zDqUXm2YUyg7hbzu1IN1q+V61KlUL3u?=
 =?us-ascii?Q?/D7foZF5+Bflh0wwbsKUhMrrEd/XgUaNrPJHb+NZDQYjpn/xcjwb5KE45Z2d?=
 =?us-ascii?Q?ex1FSyOrcG0tV0Af0k2f43yS0ZCYA4fu+25MKT8xaFV0QwKa+8kLPaq01my4?=
 =?us-ascii?Q?XcBROjn8UykWSHg0hZ1v9oUXmCvnkUMzaPv1hQcjHgtn1XP1pGIy86IMxkiW?=
 =?us-ascii?Q?rzA/lp9iCci0ExFW/xN4sFz7gJNw1+ePlAH7nnv6CtZOOZWNKho1ey9YxINH?=
 =?us-ascii?Q?LXfeXxVr1tiJXJv6HTh4Bz6C3wM7ie2I8VDEBQ5pEbCXU2mD5pqF6D2H8l1F?=
 =?us-ascii?Q?xmrVHpvtggxXQJpFGuXtWHJUYAsDgoZpUQ+EGtNfWB/xg37eoPdzqstW+/Ua?=
 =?us-ascii?Q?JcaL4EnK4w5jGT6vmMc6TIYd1jRQEOHPCcgtKxo44i77CkiOSKvWUk/ItlaV?=
 =?us-ascii?Q?PJqayAVWC7+Ata68rx5GllNpN8Y7ffyNF80r6xT2kUBWzqpQB1anVx43ggEE?=
 =?us-ascii?Q?UMSE8AhGG0mNOC8skLDDOCASUtvwW+/oXni8AyByvwG/6tp57erP8JNlpSK0?=
 =?us-ascii?Q?luP9/43KHX5RIy8RSdc7+vzFbWZvOg5rtMhl9aIp0cdYbyjkur5H6EzLDsqv?=
 =?us-ascii?Q?S915LEDGUXUMYc2LOykIQAQFIVTC5PWFjUfyT4KpAns9oZxoTGNiE4ZRS23/?=
 =?us-ascii?Q?i/W1Y6X7kvQbsepRauY1d7JKC3VGQOwjpcKuuNwj95/V+YtWUEZq9eDP0kTg?=
 =?us-ascii?Q?Ajisd3Bjf1SqAx0j7132dJnnMj60DAuu0fMBf3lKUCv8jBQo+aGFl+6IZV2W?=
 =?us-ascii?Q?tahJc+cOGtUNZOB8I2U3uegeyT3/5fqj25plAMBEeRB5F2ZKjtf5tJqYU7TW?=
 =?us-ascii?Q?JgaU/PKQY0kLpFXASepZjJeYOEVS7Q+PZvWH3kEl3RDE8f64ShnR9MDugNS2?=
 =?us-ascii?Q?ysrCbDH6g38Eajg/pIrSGIymxmmXlkIWhEwdn2JJlEjA3m8uWuncdGavHtqS?=
 =?us-ascii?Q?MKUM07JtT44U/4Upr8QMw1Svpx1pviALNgS6AtzjYcDvICqDnu92lwHLjn8V?=
 =?us-ascii?Q?g95g6l5NQgcgdwnnN+2sUKIySLEUcBLm4GvJx2B6q3qsrjPGxtPk2JOtUhhl?=
 =?us-ascii?Q?wM3Zs+5170ygEk2RanjJXoKApSIT2BvnPTAmHg+YQwySDriQOI+2NnfdDUlF?=
 =?us-ascii?Q?ALzh7Yi0jc+aBCz4gLKg3SR1dDt2D5sAGXkWiwp8+XMQpm39kp4mQD0BqN3v?=
 =?us-ascii?Q?sC2Eg2sTAalnYnWdhWV6vaROYFLyjmrE8Zi+TIfOwy61s+CmFHFSPR4Khcvn?=
 =?us-ascii?Q?sVSCHVNIVc6KAfXMmAi08sh1woXiCltrV0zBgNMFmlL0R3DMPUaGlnKxEy8I?=
 =?us-ascii?Q?ZfSCYDGPyQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: r5y2f79LnTkDWiXGslqy2dZbx9kdX7PtiFANCx8KRekM2aQc8IB2A7OFnt3TXMY/bXwDeTXXZruIy9aFbqDSEDpETs28CJintU09fuyJO2HYIV7ORonsML6bmBt4nTh2ztfx8XOtez3FY+Oy8NYnZkT0W7PA8gkBjaO+wslaqxvRlCCSBxkU+k2VqalnaoWxQ3eFf2YxtTD9yQx4FYGJcZ5drJIcTQCXUwqbdYeD+h4HEQHVVVQ+dYFoON56Drj+k2g4MlUCtWOVMNSJLjEbyk2ZRSD9nRNX+44799/LQ4bz7ZT+ZNdX77zjch331ZIvunzv+miyBVUNoovwUYbZvA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca7278c-b96a-4724-1d5d-08decd03fbc0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 06:36:52.8207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+PRJNokg34qfstRdZZL7x/TGFhDGuMO+gmPyoOm9/vdEcFjnDHr9PIf5/QGgXyTaOFbObLfijZMmsSmb9LHlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5831
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_irq_lock_inversion_dependency_detected" on:

commit: 028b94b023efe53f26decb0497e3ffe5b9e16ee9 ("[PATCH] pidfs: pin stashed dentry for pid lifetime to fix repeat-open regression")
url: https://github.com/intel-lab-lkp/linux/commits/A-Sterling/pidfs-pin-stashed-dentry-for-pid-lifetime-to-fix-repeat-open-regression/20260612-190630
base: https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git vfs.all
patch link: https://lore.kernel.org/all/20260612110529.80055-1-adam.sterling@gmail.com/
patch subject: [PATCH] pidfs: pin stashed dentry for pid lifetime to fix repeat-open regression

in testcase: boot

config: x86_64-rhel-9.4-bpf
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202606180805.1b2fdd03-lkp@intel.com



[   92.416502][    C0] WARNING: possible irq lock inversion dependency detected
[   92.417060][    C0] 7.1.0-rc4+ #1 Not tainted
[   92.417436][    C0] --------------------------------------------------------
[   92.418046][    C0] sed/219 just changed the state of lock:
[   92.418527][    C0] ffff8881bbb865d8 (&sighand->siglock){-...}-{3:3}, at: lock_task_sighand (signal.c:1379 (discriminator 1))
[   92.420518][    C0] but this lock took another, HARDIRQ-unsafe lock in the past:
[   92.421115][    C0]  (&lockref->lock){+.+.}-{3:3}
[   92.421123][    C0]
[   92.421123][    C0] and interrupts could create inverse lock ordering between them.
[   92.421123][    C0]
[   92.426274][    C0]
[   92.426274][    C0] other info that might help us debug this:
[   92.430176][    C0] Chain exists of:
[   92.430176][    C0]   &sighand->siglock --> &(&sig->stats_lock)->lock --> &lockref->lock
[   92.430176][    C0]
[   92.435925][    C0]  Possible interrupt unsafe locking scenario:
[   92.435925][    C0]
[   92.439638][    C0]        CPU0                    CPU1
[   92.441400][    C0]        ----                    ----
[   92.443137][    C0]   lock(&lockref->lock);
[   92.444756][    C0]                                local_irq_disable();
[   92.446587][    C0]                                lock(&sighand->siglock);
[   92.448366][    C0]                                lock(&(&sig->stats_lock)->lock);
[   92.450174][    C0]   <Interrupt>
[   92.451642][    C0]     lock(&sighand->siglock);
[   92.453200][    C0]
[   92.453200][    C0]  *** DEADLOCK ***
[   92.453200][    C0]
[   92.457265][    C0] 2 locks held by sed/219:
[   92.458724][    C0]  #0: ffffffffb322ad60 (rcu_read_lock){....}-{1:3}, at: kill_pid_info_type (linux/rcupdate.h:300 linux/rcupdate.h:838 signal.c:1455)
[   92.460612][    C0]  #1: ffffffffb322ad60 (rcu_read_lock){....}-{1:3}, at: lock_task_sighand (linux/rcupdate.h:300 linux/rcupdate.h:838 signal.c:1362)
[   92.462494][    C0]
[   92.462494][    C0] the shortest dependencies between 2nd lock and 1st lock:
[   92.465475][    C0]     -> (&lockref->lock){+.+.}-{3:3} {
[   92.467032][    C0]        HARDIRQ-ON-W at:
[   92.468491][    C0]                             __lock_acquire (locking/lockdep.c:5191)
[   92.470147][    C0]                             lock_acquire (trace/events/lock.h:24 (discriminator 15) trace/events/lock.h:24 (discriminator 15) locking/lockdep.c:5831 (discriminator 15))
[   92.471793][    C0]                             _raw_spin_lock (linux/spinlock_api_smp.h:158 (discriminator 1) locking/spinlock.c:158 (discriminator 1))
[   92.473420][    C0]                             d_instantiate (linux/spinlock.h:342 dcache.c:2084 dcache.c:2078)
[   92.475015][    C0]                             d_make_root (dcache.c:2126)
[   92.476597][    C0]                             shmem_fill_super (shmem.c:5103)
[   92.478192][    C0]                             get_tree_nodev (super.c:1266 super.c:1285)
[   92.479724][    C0]                             vfs_get_tree (super.c:1693)
[   92.481253][    C0]                             fc_mount (namespace.c:1198)
[   92.482730][    C0]                             vfs_kern_mount (namespace.c:6298)
[   92.484296][    C0]                             kern_mount (namespace.c:6289 namespace.c:6289)
[   92.485750][    C0]                             shmem_init (shmem.c:5420)
[   92.487245][    C0]                             mnt_init (namespace.c:6271)
[   92.488676][    C0]                             vfs_caches_init (dcache.c:3418)
[   92.490238][    C0]                             start_kernel (main.c:1202)
[   92.491707][    C0]                             __pfx_clear_bss (x86/kernel/head64.c:310)
[   92.493159][    C0]                             x86_64_start_kernel (x86/kernel/head64.c:291)
[   92.494609][    C0]                             common_startup_64 (x86/kernel/head_64.S:418)
[   92.496025][    C0]        SOFTIRQ-ON-W at:
[   92.497295][    C0]                             __lock_acquire (locking/lockdep.c:5191)
[   92.498764][    C0]                             lock_acquire (trace/events/lock.h:24 (discriminator 15) trace/events/lock.h:24 (discriminator 15) locking/lockdep.c:5831 (discriminator 15))
[   92.500198][    C0]                             _raw_spin_lock (linux/spinlock_api_smp.h:158 (discriminator 1) locking/spinlock.c:158 (discriminator 1))
[   92.501576][    C0]                             d_instantiate (linux/spinlock.h:342 dcache.c:2084 dcache.c:2078)
[   92.502953][    C0]                             d_make_root (dcache.c:2126)
[   92.504319][    C0]                             shmem_fill_super (shmem.c:5103)
[   92.505708][    C0]                             get_tree_nodev (super.c:1266 super.c:1285)
[   92.507160][    C0]                             vfs_get_tree (super.c:1693)
[   92.508507][    C0]                             fc_mount (namespace.c:1198)
[   92.509809][    C0]                             vfs_kern_mount (namespace.c:6298)
[   92.511231][    C0]                             kern_mount (namespace.c:6289 namespace.c:6289)
[   92.512525][    C0]                             shmem_init (shmem.c:5420)
[   92.513817][    C0]                             mnt_init (namespace.c:6271)
[   92.516019][    C0]                             vfs_caches_init (dcache.c:3418)
[   92.517541][    C0]                             start_kernel (main.c:1202)
[   92.519055][    C0]                             __pfx_clear_bss (x86/kernel/head64.c:310)
[   92.520442][    C0]                             x86_64_start_kernel (x86/kernel/head64.c:291)
[   92.521878][    C0]                             common_startup_64 (x86/kernel/head_64.S:418)
[   92.523342][    C0]        INITIAL USE at:
[   92.524518][    C0]                            __lock_acquire (locking/lockdep.c:5191)
[   92.525930][    C0]                            lock_acquire (trace/events/lock.h:24 (discriminator 15) trace/events/lock.h:24 (discriminator 15) locking/lockdep.c:5831 (discriminator 15))
[   92.527403][    C0]                            _raw_spin_lock (linux/spinlock_api_smp.h:158 (discriminator 1) locking/spinlock.c:158 (discriminator 1))
[   92.528797][    C0]                            d_instantiate (linux/spinlock.h:342 dcache.c:2084 dcache.c:2078)
[   92.530252][    C0]                            d_make_root (dcache.c:2126)
[   92.531629][    C0]                            shmem_fill_super (shmem.c:5103)
[   92.533035][    C0]                            get_tree_nodev (super.c:1266 super.c:1285)
[   92.534518][    C0]                            vfs_get_tree (super.c:1693)
[   92.535844][    C0]                            fc_mount (namespace.c:1198)
[   92.537152][    C0]                            vfs_kern_mount (namespace.c:6298)
[   92.538524][    C0]                            kern_mount (namespace.c:6289 namespace.c:6289)
[   92.539835][    C0]                            shmem_init (shmem.c:5420)
[   92.541165][    C0]                            mnt_init (namespace.c:6271)
[   92.542506][    C0]                            vfs_caches_init (dcache.c:3418)
[   92.543881][    C0]                            start_kernel (main.c:1202)
[   92.545279][    C0]                            __pfx_clear_bss (x86/kernel/head64.c:310)
[   92.546706][    C0]                            x86_64_start_kernel (x86/kernel/head64.c:291)
[   92.548218][    C0]                            common_startup_64 (x86/kernel/head_64.S:418)
[   92.549692][    C0]      }
[   92.550763][    C0]      ... key      at: __key.4+0x0/0x40
[   92.552113][    C0]      ... acquired at:
[   92.553212][    C0]    __lock_acquire (locking/lockdep.c:5237)
[   92.554371][    C0]    lock_acquire (trace/events/lock.h:24 (discriminator 15) trace/events/lock.h:24 (discriminator 15) locking/lockdep.c:5831 (discriminator 15))
[   92.555540][    C0]    _raw_spin_lock (linux/spinlock_api_smp.h:158 (discriminator 1) locking/spinlock.c:158 (discriminator 1))
[   92.556673][    C0]    lockref_get (linux/spinlock.h:342 lockref.c:50)
[   92.557781][    C0]    pidfs_alloc_file (linux/dcache.h:365 pidfs.c:1168)
[   92.558971][    C0]    pidfd_prepare (fork.c:1918)
[   92.560119][    C0]    __x64_sys_pidfd_open (pid.c:674 pid.c:710 pid.c:695 pid.c:695)
[   92.561296][    C0]    do_syscall_64 (x86/entry/syscall_64.c:63 x86/entry/syscall_64.c:94)
[   92.562456][    C0]    entry_SYSCALL_64_after_hwframe (x86/entry/entry_64.S:121)
[   92.563689][    C0]
[   92.564649][    C0]    -> (&pid->wait_pidfd){....}-{3:3} {
[   92.565868][    C0]       INITIAL USE at:
[   92.566983][    C0]                          __lock_acquire (locking/lockdep.c:5191)
[   92.568286][    C0]                          lock_acquire (trace/events/lock.h:24 (discriminator 15) trace/events/lock.h:24 (discriminator 15) locking/lockdep.c:5831 (discriminator 15))
[   92.569603][    C0]                          _raw_spin_lock_irqsave (linux/spinlock_api_smp.h:132 (discriminator 1) locking/spinlock.c:166 (discriminator 1))
[   92.570965][    C0]                          __wake_up (sched/wait.c:124 (discriminator 1) sched/wait.c:146 (discriminator 1))
[   92.572231][    C0]                          do_notify_parent (signal.c:2156 signal.c:2184)
[   92.573541][    C0]                          exit_notify (exit.c:757)
[   92.574834][    C0]                          do_exit (exit.c:987)
[   92.576106][    C0]                          kthread (kthread.c:438)
[   92.577494][    C0]                          ret_from_fork (x86/kernel/process.c:158)
[   92.578795][    C0]                          ret_from_fork_asm (x86/entry/entry_64.S:245)
[   92.580104][    C0]     }
[   92.581115][    C0]     ... key      at: __key.3+0x0/0x40
[   92.582473][    C0]     ... acquired at:
[   92.583582][    C0]    __lock_acquire (locking/lockdep.c:5237)
[   92.584748][    C0]    lock_acquire (trace/events/lock.h:24 (discriminator 15) trace/events/lock.h:24 (discriminator 15) locking/lockdep.c:5831 (discriminator 15))
[   92.585949][    C0]    _raw_spin_lock_irqsave (linux/spinlock_api_smp.h:132 (discriminator 1) locking/spinlock.c:166 (discriminator 1))
[   92.587170][    C0]    __wake_up (sched/wait.c:124 (discriminator 1) sched/wait.c:146 (discriminator 1))
[   92.588284][    C0]    __exit_signal (exit.c:142 exit.c:212)
[   92.589434][    C0]    release_task (exit.c:265)
[   92.590586][    C0]    exit_notify (exit.c:776)
[   92.591725][    C0]    do_exit (exit.c:987)
[   92.592834][    C0]    kthread (kthread.c:438)
[   92.593966][    C0]    ret_from_fork (x86/kernel/process.c:158)
[   92.595127][    C0]    ret_from_fork_asm (x86/entry/entry_64.S:245)
[   92.596277][    C0]
[   92.597241][    C0]   -> (&____s->seqcount#3){....}-{0:0} {
[   92.598469][    C0]      INITIAL USE at:
[   92.599564][    C0]                        __lock_acquire (locking/lockdep.c:5191)
[   92.600850][    C0]                        lock_acquire (trace/events/lock.h:24 (discriminator 15) trace/events/lock.h:24 (discriminator 15) locking/lockdep.c:5831 (discriminator 15))
[   92.602201][    C0]                        __exit_signal (linux/seqlock.h:478 (discriminator 1) linux/seqlock.h:504 (discriminator 1) linux/seqlock.h:881 (discriminator 1) exit.c:199 (discriminator 1))
[   92.603491][    C0]                        release_task (exit.c:265)
[   92.604770][    C0]                        exit_notify (exit.c:776)
[   92.606066][    C0]                        do_exit (exit.c:987)
[   92.607334][    C0]                        kthread (kthread.c:438)
[   92.608581][    C0]                        ret_from_fork (x86/kernel/process.c:158)
[   92.609873][    C0]                        ret_from_fork_asm (x86/entry/entry_64.S:245)
[   92.611166][    C0]      INITIAL READ USE at:
[   92.612286][    C0]                             __lock_acquire (locking/lockdep.c:5191)
[   92.613596][    C0]                             lock_acquire (trace/events/lock.h:24 (discriminator 15) trace/events/lock.h:24 (discriminator 15) locking/lockdep.c:5831 (discriminator 15))
[   92.615780][    C0]                             thread_group_cputime (linux/seqlock.h:73 (discriminator 1) linux/seqlock.h:838 (discriminator 1) sched/cputime.c:345 (discriminator 1))
[   92.617425][    C0]                             thread_group_cputime_adjusted (sched/cputime.c:644)
[   92.619121][    C0]                             wait_task_zombie (exit.c:1234)
[   92.620533][    C0]                             __do_wait (exit.c:1646 exit.c:1681)
[   92.621885][    C0]                             do_wait (exit.c:1722)
[   92.623341][    C0]                             kernel_wait (exit.c:1898)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260618/202606180805.1b2fdd03-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

