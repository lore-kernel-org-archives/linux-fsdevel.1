Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A213FE667
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638762; cv=fail; b=X5bjHSTNT4xijGtg8EOzmBQFPTHmxW7Gg1ea74pntZHAuqTasgq69SQjiw/48USboirsOHoL1DzOeWPhE30xHZgAuXfQey/l4N/50JYMG6PmIFiDQGFJA1tKw3JwjPNEb6aSVlkXGHxLyHdOBfTYMXGszYBkBEOmIfc6L71M2LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638762; c=relaxed/simple;
	bh=Vwh9bHVStZUFhJR+ZAA96wKOFJlR/S0PaFlnHVc/PN8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=VZAXVDXUmRMpGhDKi00jjHoOqVbpxR279bvwBET636/XyHTqUeLfvHrawITpKfqAYSBOJ6v2uigPihULe6BHA5G0sLGfjgA0ABaQ9+3lk0xUDod+eL3iC3LKoxi80sBkuoZ+lEcArlEFwfBYdtWQAi+5tGu7D0N81gRfZDqg6qA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UTrt0cH1; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UTrt0cH1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780638761; x=1812174761;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vwh9bHVStZUFhJR+ZAA96wKOFJlR/S0PaFlnHVc/PN8=;
  b=UTrt0cH1+yGeaSsXh5ZPBzgBl4jakbaYsr9jNTEsKSgf/H5l9Q47/J++
   fU08cuMHn2PU8M31bqwUqomDVcyF+/xBOjIjuvx9Li3kBM5hHxZwZGSE/
   v5jvX7XfFXbxCLxaGP2V9cjTpCQxKGLB7r0+7pPkUGxr3XyciYR9IMDx9
   Ay1WOZS503iZv1ghmSiAFeuO3L6d7KVY8HTPvA0O/Zn+fm4uuu6Bv7i2h
   eLNuJo14BDkqa+S1xOmlxOEpOn/8gWmIT+GBnVme47yXeW6N6mSaGAO7+
   olzNtktRrTBNe+JOLiMdzUzgsHmS0PKmiaQVdDlJwRSUqm+nP9FsMu+6T
   A==;
X-CSE-ConnectionGUID: C9PiwN7NQe6iz8TKbCcKDw==
X-CSE-MsgGUID: 2UWdQhtqSpa7uN0+Rc4dLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81656930"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="81656930"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 22:52:40 -0700
X-CSE-ConnectionGUID: dko5h7iiTc2Aq//28IIGHw==
X-CSE-MsgGUID: fnc9W89BSDaarTuCdUGKIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="274999532"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 22:52:40 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 22:52:39 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 22:52:39 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.43) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 22:52:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjeuFXcMPEVyXmPc0QnmHZsxozXhiC93ts60UnCReYEkY1q56FLPiP+qpOgHNmsbOETwLtsvPnjdNh0Y3jtSY0LumGj0G3AGV0u9nwU+MRG/AIYCJl8M3ggZWLGSvrCTFj2+cqRRPy/5FB704lHxjqb3/f6LguqXNs3ieku3iNC68/W7VGMzx27rUWOAzPaeoGpBhII2Sc70JQCWeb0F2KPeWVmqSVJbOzXZDAzaxnwqz+2hkXRqlfI5qCQghuNEsPq1ZyvHYWh3eQ+NqJkMVu/PVECvqcSH0B569ADQY9uK+w6McGAnxg7B5RqElWcZcEcjYRypPT26BXXZqPOJVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3Osl5eGF9E9zveV7IMrFaiwxn3dtP70Z2uYSL6UvLU=;
 b=EY7/dh034H5Ynh3iwyxKLMdIXGgcyImxZC2WbxrutTH/4VTk9CZwQFoy6ySu6q3cMPq+y784aZ1Zq7oDNb3p76qZT4DDamXDfA2eaoVniPgtIjGI3qJRlz1nvxEArvD1mp8/xkuIMUvQW1pHjt+m0s6a3fEYn0/UEn/TqNENN/Qp3PGt6rLNECqevtmz6noITNRjkfKWj7CSrjyFtW/579otQAtjFj1v7CAY9v7pDlxE8dXqA0eoVyLc82/7Clqh5YSLfQCojHIMj9wmQrs/lJdVTZvlwr76CGsUtqzFssCBWuJ2Bq8cpxmbZEGUjygQXm4ZuX8bIexrOw48Toy3fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by BL1PR11MB6004.namprd11.prod.outlook.com (2603:10b6:208:390::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 05:52:36 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 05:52:35 +0000
Date: Fri, 5 Jun 2026 13:52:28 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Al Viro <viro@zeniv.linux.org.uk>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [viro-vfs:more.configfs] [configfs]  2bbdcd7eab:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <202606051115.319be2bc-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::8)
 To PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|BL1PR11MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 904a5d1b-32d9-41cf-c5c1-08dec2c6a4a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|3023799007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: W22auzA3Z19aAVnvDhn5mJc5S+Pz+lJHw13YLZLF8EdcglOFgMt6UAgG2YGz5miQEe8zoA1ZylA3Zi/n/BhH85r/Rj9yq7V0Pi/6BYiXy0rH4IaiIAuvTo9ZyWGBKI1Lf9FKHPFMYEvV3zU16qtS2bPPk9v1KlwddKJYMGLmD8d6ngUOJQ9HsKYJqpne3y3dySJZ1my1RqD4Wryiqaa67Hej23tWZ1ydp5sTSz8wOgK8t9CQPiQJou7qg5DludYG9/PI3S89yKHOzu3QX95xjkH0lmMoQa38JyaMHupnd4k0r0NorQBrtZFly8TvOt2S1bG5M0NjtpXIxmCQ1YZXDBibmVjEWLZLFwXzFQl6JhCZgKNcHlredCNssPCgus6ju4yi2bW2R5gdeCgTmK64Yg+M443SeFsTTdOrefA3XSCwNFMomhDQUzHpf6FFHje9A7cNsmKKCVcEzviviX7x5iDOig8c1NqYSu6zE5RyZwA+hzA3N+C2huOgrrwIrMy1O7bU9dTwBX8kney2NVm7+pE7i2jMnT2HQZlN5E5NT9Sg+ktEeDTSwqw3Lq1Y2IO463aGl+S8JWJWr8JD6/1IA2QwdsAvgjhC/vxoJa/q5hxgA/vnW2NWsRh1SYBeL5gppMsqSyP147b0RtORRqtljvj5dFjSBD58rgGuBWKECIhNi4NUXwm+Su5Tt5tkDmRZj/0a4uqViVhftTImP5aaJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(3023799007)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sofanEqJuSMkX7nQbndgbDBbblQY4ak1bbe8iOa+ZSr8wAYbp7Jalb/UJ8V4?=
 =?us-ascii?Q?Szu6TEV/GhNM4G1etp76RfOpy69qC8sMaHh5pVhqZ+pmSr1K2I8kC58mQmF+?=
 =?us-ascii?Q?x0IzVjDNlDSvEfezqJj7wYef4Ew9G1vwunrhQ1gZTf8ht+AdCBsyAVuVXQ4K?=
 =?us-ascii?Q?K73dkSyE8VhEjKWXmCnXStHUfEO8urTbXueICtJ7dbD3J0W8V8ZEpi5N9+Iz?=
 =?us-ascii?Q?XNuY6mNDtgcU6dOqTnsGYYxDC0qCEkbfmER40GHgbms/eORez917migTRhHm?=
 =?us-ascii?Q?F3/hzHgAwobY895bho0SE3qPedIohyO6Q5zMy6VlJKRzF7SQob9gC9onM7FY?=
 =?us-ascii?Q?hLKjAqqZBnuCawWP6RBJ+zyxX4iwrwXnuCD1uyOc7jmra9sZrntfmidwRidI?=
 =?us-ascii?Q?apKUZXqaVYXUqOUszIlhTVP5jlTlpJh8vOVK+MNesayB7B2lgoCeRvyguo7J?=
 =?us-ascii?Q?6xU1TetU2VySgZ1uc2UGID2UGbM6zycTrg4FqEZSo7S+wgWDeDp63wjpx3cT?=
 =?us-ascii?Q?A5Sub3bGm4DKBg3/p1R4EAlejpmeBn2xHPBffKxs6NidxHWA1rYNMn3KyX9J?=
 =?us-ascii?Q?Iy8C6IS+/356xFwPbXwcSUu5Nbq6+XO7AJe3V+NYwmMhDa9hy2JvWfTwbw6F?=
 =?us-ascii?Q?KJJGwURhMfNHh0hYA43+tamHXA52MfOG1L4hAzunR79jnM0lk5B8EbKKmJzc?=
 =?us-ascii?Q?UMsv/gDdPkASGFBGtzzi5Y03p3OsVfjl9TgfqsuUnIcj0Y64EmMRFRE9suzh?=
 =?us-ascii?Q?864Uq6OMx3KpArigzau2oHcgf73FKWjHDX6don2TQ3R6Vw5GT4/Z1KAfPY7g?=
 =?us-ascii?Q?6q56mITpWg5isavrxyv1STtW9La0QTswbAho27rKDiDdPLjl5fC6OcjvOUgC?=
 =?us-ascii?Q?CNkdUkxs5mfWgxl/LIkEIiVp1WKgXxnf48Kj3pc5lUKDKINq6tsaKctZn21o?=
 =?us-ascii?Q?avy4kJOjCOBEu9PJA5QuavRvSZDiy3HiUxkNYKG3qfv7gjhZgYNVjpUl+jfg?=
 =?us-ascii?Q?vkXF9HFZkmGu8ICcUb4a7n/h+blDXQ9uebOkWLRetxl8NQy0V+vMxCn8k8f4?=
 =?us-ascii?Q?DL6u4ZVAn+9XmIVFxNDbj0ZUwCXiOtga408utoCbccP6e7SO+HnfQzSxTu+N?=
 =?us-ascii?Q?uicX0KSZofFQz4CPJrWZfaYXszDjsMamgwKHiPTUV7BEp7xfpydmKDGY9N5X?=
 =?us-ascii?Q?Brb/02Z7C372zE2Z+DdwtZxi6VaPcAiTCPCPm35B4uC0PyCEtfTiB4kBKwIj?=
 =?us-ascii?Q?W5ij6udi7kiTO6f7MH2dg+UhpbzhHrTbjV2vLqXUHtFI7sqyDgR970DcF2Ai?=
 =?us-ascii?Q?xL35YjYUmRp+CJokBYZh0Y0rMp0al3gm4kORAfiFx8VY97IX+zAxAx0k5hCh?=
 =?us-ascii?Q?ZvN8xg0RadecsBsCxuxJsyv9lyn3L3rfahyA1EvXvNOWzO6xu7qPHLzQa73c?=
 =?us-ascii?Q?zNdGmy7xtE+/QV5ezAJbmsn0hoIHJV6sQuinb31zPf6WoKhposPGqpfAM6/H?=
 =?us-ascii?Q?28WxrHBImT9LgBCFOF8dBKOOGeXSVr1hKgXdQfHcx39JWunsxOkUf0NlMXXw?=
 =?us-ascii?Q?2wKTekBxaCkk8FH9Oy4UmzavWZBPOUofyF92BY7VO0+Q1yBk3DnEF4a3Q4Gs?=
 =?us-ascii?Q?DlaSKY8IR7RVJWFurBdiwt/qJI189FPZpu2HWv5t680oZvKalSKiI2zSXmQJ?=
 =?us-ascii?Q?Z1V7drSqzRtMQEZn9EoWACmNp6duQQIv5LyLQmpfJvt51w5ain4eJyXoV1gA?=
 =?us-ascii?Q?THiN3GwRzw=3D=3D?=
X-Exchange-RoutingPolicyChecked: a+LUvDKHUx8upNRLAuBzvmTuXdQQAOEevixohy9XbXowijoB+fbDqQf3t89FjBbBUgBi4NcMJDYReDdlih1ZtnRLURmR4NnXKdilOc0mZrHzZziFa4vAF0OV2Vj8vnF+ZsmrAKd7vSHBsQGiXZHEKEh3CvfBrPsyZwh/dbEeIlZVaL9kCCTQIydIFP9iXozbvSfM8L1jGBgAqdeHXjb2QjqKfTj4XwXz3FXUDf5g06awGdvSkPX/yWjYDlkXhpIIJZRECw2y8U7wA9RtXJkkzu5K9NfqIvIBg5JjmlwwlAssl8m8eI5V4D3oxwDHxKe+A+c5yUngZ+wEXVBa3YaMOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 904a5d1b-32d9-41cf-c5c1-08dec2c6a4a6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 05:52:35.8216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4epZJ9AC/rkvqyEH6arkSRI7WcYcpU7n7ZhlRtApKwQjuUpfTNWWC5pxb3cu5f5xT5AT3CCUl49vC/D8Wsmywg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6004
X-OriginatorOrg: intel.com




Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 2bbdcd7eabfcd3a5bd2614ab75ece19323d5f4c2 ("configfs: attach the subtree only when it's completely built")
https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git more.configfs

in testcase: boot

config: i386-randconfig-013-20260604
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202606051115.319be2bc-lkp@intel.com



[    6.464570][    T1] BUG: kernel NULL pointer dereference, address: 00000020
[    6.465555][    T1] #PF: supervisor write access in kernel mode
[    6.465555][    T1] #PF: error_code(0x0002) - not-present page
[    6.465555][    T1] *pde = 00000000
[    6.465555][    T1] Oops: Oops: 0002 [#1] SMP
[    6.465555][    T1] CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T   7.1.0-rc6-00030-g2bbdcd7eabfc #1 PREEMPT
[    6.465555][    T1] Tainted: [T]=RANDSTRUCT
[    6.465555][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    6.465555][    T1] EIP: configfs_register_group (configfs/dir.c:1607)
[    6.465555][    T1] Code: 89 13 e8 ca 76 fb ff 89 c1 3d 00 f0 ff ff 77 2e 57 31 d2 89 45 ec 89 d8 e8 c8 fe ff ff 8b 4d ec 89 c6 58 85 f6 75 0a 8b 41 74 <81> 48 20 80 00 00 00 89 c8 e8 e1 76 fb ff 85 f6 75 04 eb 1b 89 c6
All code
========
   0:	89 13                	mov    %edx,(%rbx)
   2:	e8 ca 76 fb ff       	call   0xfffffffffffb76d1
   7:	89 c1                	mov    %eax,%ecx
   9:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
   e:	77 2e                	ja     0x3e
  10:	57                   	push   %rdi
  11:	31 d2                	xor    %edx,%edx
  13:	89 45 ec             	mov    %eax,-0x14(%rbp)
  16:	89 d8                	mov    %ebx,%eax
  18:	e8 c8 fe ff ff       	call   0xfffffffffffffee5
  1d:	8b 4d ec             	mov    -0x14(%rbp),%ecx
  20:	89 c6                	mov    %eax,%esi
  22:	58                   	pop    %rax
  23:	85 f6                	test   %esi,%esi
  25:	75 0a                	jne    0x31
  27:	8b 41 74             	mov    0x74(%rcx),%eax
  2a:*	81 48 20 80 00 00 00 	orl    $0x80,0x20(%rax)		<-- trapping instruction
  31:	89 c8                	mov    %ecx,%eax
  33:	e8 e1 76 fb ff       	call   0xfffffffffffb7719
  38:	85 f6                	test   %esi,%esi
  3a:	75 04                	jne    0x40
  3c:	eb 1b                	jmp    0x59
  3e:	89 c6                	mov    %eax,%esi

Code starting with the faulting instruction
===========================================
   0:	81 48 20 80 00 00 00 	orl    $0x80,0x20(%rax)
   7:	89 c8                	mov    %ecx,%eax
   9:	e8 e1 76 fb ff       	call   0xfffffffffffb76ef
   e:	85 f6                	test   %esi,%esi
  10:	75 04                	jne    0x16
  12:	eb 1b                	jmp    0x2f
  14:	89 c6                	mov    %eax,%esi
[    6.465555][    T1] EAX: 00000000 EBX: b1832180 ECX: b3afc7d0 EDX: 00000000
[    6.465555][    T1] ESI: 00000000 EDI: b183a180 EBP: b1149ec0 ESP: b1149eac
[    6.465555][    T1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
[    6.465555][    T1] CR0: 80050033 CR2: 00000020 CR3: 1720f000 CR4: 000406d0
[    6.465555][    T1] Call Trace:
[    6.465555][    T1]  configfs_register_default_group (configfs/dir.c:1683)
[    6.465555][    T1]  iio_sw_device_init (iio/industrialio-sw-device.c:164)
[    6.465555][    T1]  do_one_initcall (main.c:1392)
[    6.465555][    T1]  ? iio_configfs_init (industrialio-configfs.c:?)
[    6.465555][    T1]  do_initcalls (main.c:1454 (discriminator 1) main.c:1470 (discriminator 1))
[    6.465555][    T1]  kernel_init_freeable (main.c:1490 main.c:1703)
[    6.465555][    T1]  ? rest_init (main.c:762)
[    6.465555][    T1]  kernel_init (main.c:1593)
[    6.465555][    T1]  ret_from_fork (x86/kernel/process.c:158)
[    6.465555][    T1]  ? rest_init (main.c:762)
[    6.465555][    T1]  ret_from_fork_asm (x86/entry/entry_32.S:736)
[    6.465555][    T1]  entry_INT80_32 (x86/entry/entry_32.S:940)
[    6.465555][    T1] Modules linked in:
[    6.465555][    T1] CR2: 0000000000000020
[    6.465555][    T1] ---[ end trace 0000000000000000 ]---
[    6.465555][    T1] EIP: configfs_register_group (configfs/dir.c:1607)
[    6.465555][    T1] Code: 89 13 e8 ca 76 fb ff 89 c1 3d 00 f0 ff ff 77 2e 57 31 d2 89 45 ec 89 d8 e8 c8 fe ff ff 8b 4d ec 89 c6 58 85 f6 75 0a 8b 41 74 <81> 48 20 80 00 00 00 89 c8 e8 e1 76 fb ff 85 f6 75 04 eb 1b 89 c6
All code
========
   0:	89 13                	mov    %edx,(%rbx)
   2:	e8 ca 76 fb ff       	call   0xfffffffffffb76d1
   7:	89 c1                	mov    %eax,%ecx
   9:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
   e:	77 2e                	ja     0x3e
  10:	57                   	push   %rdi
  11:	31 d2                	xor    %edx,%edx
  13:	89 45 ec             	mov    %eax,-0x14(%rbp)
  16:	89 d8                	mov    %ebx,%eax
  18:	e8 c8 fe ff ff       	call   0xfffffffffffffee5
  1d:	8b 4d ec             	mov    -0x14(%rbp),%ecx
  20:	89 c6                	mov    %eax,%esi
  22:	58                   	pop    %rax
  23:	85 f6                	test   %esi,%esi
  25:	75 0a                	jne    0x31
  27:	8b 41 74             	mov    0x74(%rcx),%eax
  2a:*	81 48 20 80 00 00 00 	orl    $0x80,0x20(%rax)		<-- trapping instruction
  31:	89 c8                	mov    %ecx,%eax
  33:	e8 e1 76 fb ff       	call   0xfffffffffffb7719
  38:	85 f6                	test   %esi,%esi
  3a:	75 04                	jne    0x40
  3c:	eb 1b                	jmp    0x59
  3e:	89 c6                	mov    %eax,%esi

Code starting with the faulting instruction
===========================================
   0:	81 48 20 80 00 00 00 	orl    $0x80,0x20(%rax)
   7:	89 c8                	mov    %ecx,%eax
   9:	e8 e1 76 fb ff       	call   0xfffffffffffb76ef
   e:	85 f6                	test   %esi,%esi
  10:	75 04                	jne    0x16
  12:	eb 1b                	jmp    0x2f
  14:	89 c6                	mov    %eax,%esi


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260605/202606051115.319be2bc-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

