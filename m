Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011038.outbound.protection.outlook.com [52.101.57.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DDA260566;
	Thu,  2 Apr 2026 00:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775091393; cv=fail; b=g3ToW2JuFfw7rL6AtARev9LisLCn2jK9ojdJxyy+y0OvFYXMJ38MLHt0eGZdefHbOXtI3Yp3n44nL+PAoUaMa5bUpMokDNFQcVLEWAY3FMa3/gmufmrKr5+sGcTLWmRiW1yKVSOrbbQ7jHh+eLJVPEclh7a4Z1VysU8Fc/O2xlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775091393; c=relaxed/simple;
	bh=e/MPd1khS2CQHIm1P+RAogWZcR2SBEZml6ziHp3dHhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L04Gjy+El8RwvbcxZX/ivaHu2IHXZRvIlF8DTM8dFrIcPn6b04XpzjO1vMD/Ebwvi9beFbZEGFY/yKECHH0x397B2jodY1DOaaTijBJN9xST/DV4oz5HBj16Co2Ezs7wP+ZB+uXQueywd9N85rKPcNsBx9CdAgQuJ/qU8Mie4fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CbWu5yTM; arc=fail smtp.client-ip=52.101.57.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CbWu5yTM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ql8Jq7Z4AFrJ2Tia0U4h6rGCAYIJrLIMkiChR0C/bjJTeCZQ+E7eeSF1AIvVG14H0H9gkKJD9HseV7FoKT8dAWwLSwK2n1Ja7Sr2AI4WRD3kYEre1QqZhc7PAnN/ZOzR/3PtUQR7VLIviGkSc8Wt9zPScVoAggJmO6RRN/GkgZL1xokRoF0RLt1J7hdraBBEb/6tspkm0GdhnEgmzyEABtPYU4coOS3sWh5RQz339tavqRa+JxXDesCX0+g2gqSNxI6zdD5tXuVySCsAotegAWJP4wGmCSggP5lUvBoLtjlar7kZDtm1SewHs1hGXLz/aQTLCBLURZm2MYb9/ItPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cvznxaEunHDEWd3dBbsuoxpDFJj/XkRe5syIJfah4w=;
 b=FtfSsnI+HWwGevSEAe8cTSVdYqjS5ieLJnplXGDpwNRxfp3LzNWVAdHTsJslLr9UKhs+y6SdD2acFbq1/vnxXQVe5x6m/Ei7eI4wAHvl8aL+hO+ETrZN1f4eRMMhWMZtiPI3Km6tk+kkQ1qC+OhobWwjLsZxcGq5Ljy6HBH+P8PU1qNt9ko1HOGO9xPVNNatAX6xb8BidIgulRvvMNX/QkKHGeVW5rI3wZPLPzxotFMgcWaLYH7Hd4YiZ28j0g8PZ7I+iIlPXU4thqJ0x0Ci46S/Uey/MkVS9tGaa7kVOALiZTapoWZrmMRTVZXQFV8SVhig3oKm+tKaCa2TVgvlDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cvznxaEunHDEWd3dBbsuoxpDFJj/XkRe5syIJfah4w=;
 b=CbWu5yTMDNPHINP/stZhuOMtaxqXkJckufuNZ0Yrem0W0SIeKFVVRfksae3U4k8HPs2D90/ZMjRu+pGj8Cff4jCuU6/xZ8Zu0EaBdArm/HYKHngNnU/BXdVV4j6dvVGsPhhf2zqveiBRut5JwjmjEvKzO95dURlDIP2/NeGZhQibQxVJ/LS1XUEheTz9EhOpDQ8/03sUR+rvLl1OfyzPfsq1Y2/+ReUsXJuqBodvUF076iM6Rv9cIC68GusWHJWBO0gPsc9BICsjVPkodHbYiNuZ/3pMkGp2Q89Wg39aDX102s0NIS6IK/U5d90H5gVtXJRGEAuA4iukC/jWuI2RSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 00:56:27 +0000
Received: from CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9]) by CY8PR12MB7171.namprd12.prod.outlook.com
 ([fe80::4487:395f:3abf:ad9%4]) with mapi id 15.20.9769.011; Thu, 2 Apr 2026
 00:56:27 +0000
Date: Wed, 1 Apr 2026 20:56:24 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] vfs: require verified birth date for file creation
Message-ID: <ac2-qW1wBz3-2eic@yury>
References: <20260401-i-hope-someone-believes-this-is-real-04f24e03944e@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-i-hope-someone-believes-this-is-real-04f24e03944e@brauner>
X-ClientProxiedBy: BN0PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:408:e8::11) To CY8PR12MB7171.namprd12.prod.outlook.com
 (2603:10b6:930:5c::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB7171:EE_|LV3PR12MB9354:EE_
X-MS-Office365-Filtering-Correlation-Id: f48bc35e-2e75-471f-b648-08de9052ab3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0lMDe14QO+/roMWu10ldjul/XU4+izBuppvH+9hMoauh4F3nl+Di49gtS9mRZRgnko9cRpoGBkRsnRRtxoREN42f6x1xs0n/Q7TqO7SQffiDfoknaJp+4kkJdWboOxou3PvhICFAF14aypAbe42/lGbxzF/JICJD5iPgtlRyp4s/zZIITheeBF1PPwBIO6WcZULjWvCxV9lTeT/iUK8rfUHTpeDPVVNEWhtNZ9GyKlKYtlVENB1dSI/rN+VnvalveJyewAJSIdON5Q+NkLQFIfKjuR0yF18dUbqVVW+hixBOKTTEWcGnX7rlsDHTWpNdpcegY5sm7yyImlDFhQBaURNZD6w4qk/eoIZLWY8gWzLPACRYFwAkrxV8M+EbiONvUiE9tlIxTK4ogRjcqKoGKyov0rM175aUGSgkzKC0zzopM/nzn3LyYDb7lPgBEvRfHrghPTNV3jY8novVKoMzGmrVIlJT5EINXzgNj8dJhx5BOLlGf+p7O0cCFfpEHuMP47+JncPg61UVfN9elgF2qzyoGV5HsNuKe83d142GqAS9IyzW+sHWMyl+bgkKSIR2VZDD7vqjHAF5wwv9hinuuhNOuzqIB3Yi1GUJDg0kVk6vbNZ6hqelxwt3HYa8oaE6/I5dPt6IqFfdt/GFfz+IRc5sXpIBJAQujcrn18/Rd05seUno3hmWOxFVC1xnOF9phwRO9rT0YGPr8R+bDU7MqTmgpvC2Dn7R/ZZC2CKL4FY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Ver2JSaJW8E4xK/TjZWJOvymW0ToapVN/ljHw18pLl7x67Amtw63aJ+CWfq?=
 =?us-ascii?Q?hrEaO70wczmS/qKEZvrAWc46pLCZO1psdQ8S2cbx4cW7A0imjNmDEvR3muAr?=
 =?us-ascii?Q?TifTSdLRNQKx5dQwhdPPbXitEgnJXhpo6IcdLlRrNZe1MRvbLvBGIvlJ8AO1?=
 =?us-ascii?Q?edJUwI45k/wg6zaXNrMvsJO3wSWOLdjr6s6YzsMKKsbMFb4ukffIYUSA27Xo?=
 =?us-ascii?Q?jxynfepNC15Lp3uOGt7427kVBG2L9zR4e+PO00uvbVOASR4pLVwGufSelBtT?=
 =?us-ascii?Q?W1l2W3TITUiIUrIGqqy5DYUgjOz2ejVTYjIEitdyMhba+mz+9jIVc+LV/Up4?=
 =?us-ascii?Q?GUQS2gabjtqYPGK/MktTsY5gN0z1wHWByjEtgXJLbGRpyn44dyfKg1+oPIdA?=
 =?us-ascii?Q?yDGALfbYFM4ALyc41K66DmQkdLB8100NkEheNRw3tXT+DSSYGTb+xgTto5rD?=
 =?us-ascii?Q?pnmNiu7+YOMFecXeLSkSrWVTBtjnDm0CejN7ZgUVStLjh1BBGh25f9XrGBn/?=
 =?us-ascii?Q?a2iI4Z+ZmaBzL4EaJA3xbXpA+HV22rz4IK4ja+hiBraGhRsanDemYC8Wtexu?=
 =?us-ascii?Q?082gEiX89h4jMWhSpkg8skdQtc1DCnvfn3jH7beJRS3vXXS59o7aNAB8GsKS?=
 =?us-ascii?Q?LJtbZ6OOyB7zhZ9PNjJjGaejzK0OEoE1ipIqcIKBGDe11PDmFm5BWX/1zkAU?=
 =?us-ascii?Q?yzkdzEqwMjfmKTdMWVdInR21WqPEJWEf+JvIAu5M4r7V9h0kbg11dkKjpnou?=
 =?us-ascii?Q?CtrH3gg1d9TSaV1e+a6NxUp4i8Z5xMpY0Fn+wJuDpSdug+jtm6KR5xiTRsda?=
 =?us-ascii?Q?PCBGpSvuKQUH48zhgkqOeVmHZxAkCaVsRpQkWy9D7I5KrByrmKQR+VRIA3eA?=
 =?us-ascii?Q?I781nhFcaMeWueVHFodEAlDfUJInoP+X6VvrungIpMvW1/65HTlTV4AUXYfX?=
 =?us-ascii?Q?lMkQTNBsr9+V6PVUY0RWhTzoASAA6ryMatWyfQthqDTWsDbHcV4X+7k/CzR9?=
 =?us-ascii?Q?cNLrCvFloCWHlE4wwZv1/6ry4nh5iP/ssY5/v9k7rc7MJj4OaXt+PD+kGyP7?=
 =?us-ascii?Q?awgo4Z0b8PLjpNOJ5yT0omnsipgCjV3hcxoctZ260ui4/W3OpBedThBmDiyo?=
 =?us-ascii?Q?IPcAdVgHptS9/zwguBYbd5WNnXKZAxduB9FVcxksIN8KEzhNxLqeQUdJhVSd?=
 =?us-ascii?Q?bhLnEdCQHjguFADFK49VMXajhChAcJWepee5I3O4SwX9lJ0jMov1J0udhchk?=
 =?us-ascii?Q?IpOsrkIb9rREaGzpsh6tp9K5BxcVMs4BZnPbb384B1s/WhWhJ0K2l4E4cSUz?=
 =?us-ascii?Q?rZmKb9Fb1njXdgV9D2j7gZB2q4wtInooZXOlxLvEnukFUGOeJYElHufskom6?=
 =?us-ascii?Q?dGLEIdtTXl3EUrNQm1SQpABjxua+1uG1Bd4x9dZ03q8ylfknbBXObfsMcULM?=
 =?us-ascii?Q?DCLmKLj4PrJzX9p77K5L+u9O7BZRPytUk4KBZJ3AAD3E083CWzLQl8F+LMNu?=
 =?us-ascii?Q?iDWMHdkp/k7KHgkZLrX+1tzJC2vwatj38Qc00vhDFPo6wRLNihdonEzhU7Zq?=
 =?us-ascii?Q?dqVtrkCwkfZ60ThEvlZ76yIXVTy5zTGVuaJk8KZBytDuqqCNN27qyOD4pfjw?=
 =?us-ascii?Q?HVCGaSYAbewGfT05DNfZAjorBEfL7+uS2aAejOK4cTe00ni50eq+BK5jkUqd?=
 =?us-ascii?Q?L4l4ps6gpxAGztvF82ipZg1wL9uDOW1FSKLPiXaaujF+wxNoCemrLHKB5+pQ?=
 =?us-ascii?Q?eI3a6i4aEGZXX7MBlDMBg9x+qdKrlTQDYEtLSytXymUcYNHx04A+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48bc35e-2e75-471f-b648-08de9052ab3b
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 00:56:27.0931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqKcsORhaqIfrprRvtJi0Ms3zuGJGQ0tP7F27/4IR9XsIzyg5XADVe4tlYEIyqU/A9Zz89Xjn4K88HKmwbfZkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354

On Wed, Apr 01, 2026 at 02:43:21PM +0200, Christian Brauner wrote:
> New regulation mandates that all digital content
> creation operations must be performed by verified adults. As file
> creation is the most fundamental content creation primitive in any
> operating system, the kernel must enforce age verification at the VFS
> layer.
> 
> This patch introduces CONFIG_VFS_AGE_VERIFICATION which, when enabled,
> requires every process to register a valid birth date via
> prctl(PR_SET_BIRTHDATE) before being permitted to create files. The
> birth date is stored in struct task_struct and inherited across fork().
> 
> File creation will fail with the new ETOOYOUNG error code if:
>   (a) no birth date has been registered, or
>   (b) the registered birth date indicates the user is under 18 years
>       of age.
> 
> A new errno, ETOOYOUNG (134), has been added. Userspace is expected to

ECHILD is already there, and it would look better her IMO.

> handle this error by displaying a calming message and suggesting the
> user ask a parent or guardian to create the file on their behalf.
> 
> The birth date is deliberately NOT cleared across execve() to avoid
> the obvious loophole of spawning a new shell to bypass verification.
> Some may argue this violates the principle of least privilege. Those
> people are probably too young to create files anyway.
> 
> Note: setting a birth date that makes the caller appear older than 150
> years is rejected with EINVAL, as the kernel does not support vampires
  
Same here. EINVAL is too generic. Can you consider EOWNERDEAD?

> or other immortal entities at this time. Patches to add undead process
> support are welcome but will require a separate Kconfig option.
> 
> Tested-by: Someone's nephew/niece (confirmed they cannot create files)
> Signed-off-by: Christian Brauner <brauner@kernel.org>

What about adding an exception for sandboxes?

Thanks,
Yury

> ---
>  fs/Kconfig                        |  17 ++++++++
>  fs/namei.c                        |  45 +++++++++++++++++++++
>  include/linux/sched.h             |   8 ++++
>  include/uapi/asm-generic/errno.h  |   2 +
>  include/uapi/linux/prctl.h        |   4 ++
>  kernel/sys.c                      |  42 ++++++++++++++++++++
>  6 files changed, 118 insertions(+)
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 1c2036..424242 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -42,6 +42,23 @@ source "fs/crypto/Kconfig"
>  source "fs/verity/Kconfig"
>  source "fs/notify/Kconfig"
> 
> +config VFS_AGE_VERIFICATION
> +	bool "Require birth date verification for file creation"
> +	default y
> +	help
> +	  When enabled, every process must register a valid birth date via
> +	  prctl(PR_SET_BIRTHDATE, day, month, year) before being allowed to
> +	  create files. Processes that have not registered a birth date or
> +	  whose registered birth date indicates they are under 18 years of
> +	  age will receive -ETOOYOUNG on any file creation attempt.
> +
> +	  If unsure, say Y. Failure to comply may result in stern letters
> +	  from lawyers. You don't want that. Trust us. Say Y.
> +
>  source "fs/quota/Kconfig"
> 
>  source "fs/autofs/Kconfig"
> diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generic/errno.h
> index 1..2 100644
> --- a/include/uapi/asm-generic/errno.h
> +++ b/include/uapi/asm-generic/errno.h
> @@ -20,4 +20,6 @@
> 
>  #define EHWPOISON	133	/* Memory page has hardware error */
> 
> +#define ETOOYOUNG	134	/* Process too young to create content */
> +
>  #endif
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 3..4 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -328,4 +328,8 @@
> 
>  #define PR_LOCK_INDIR_BR_LP_STATUS      82
> 
> +/* age verification for file creation */
> +#define PR_SET_BIRTHDATE		83
> +#define PR_GET_BIRTHDATE		84
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 5..6 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1215,6 +1215,14 @@ struct task_struct {
>  #endif
>  	struct seccomp			seccomp;
>  	struct syscall_user_dispatch	syscall_dispatch;
> +
> +#ifdef CONFIG_VFS_AGE_VERIFICATION
> +	/* compliance - birth date for age verification */
> +	u8				birthdate_day;
> +	u8				birthdate_month;
> +	u16				birthdate_year;
> +	bool				birthdate_verified;
> +#endif
> 
>  	/* Thread group tracking: */
>  	u64				parent_exec_id;
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 7..8 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2345,6 +2345,48 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  		break;
> +
> +#ifdef CONFIG_VFS_AGE_VERIFICATION
> +	case PR_SET_BIRTHDATE:
> +	{
> +		u8 day = (u8)arg2;
> +		u8 month = (u8)arg3;
> +		u16 year = (u16)arg4;
> +		struct tm now;
> +		int age;
> +
> +		/* Basic date validation */
> +		if (month < 1 || month > 12)
> +			return -EINVAL;
> +		if (day < 1 || day > 31)
> +			return -EINVAL;
> +		if (year < 1900)
> +			return -EINVAL;
> +
> +		time64_to_tm(ktime_get_real_seconds(), 0, &now);
> +
> +		/* The kernel does not support vampires or immortal entities */
> +		if ((now.tm_year + 1900) - year > 150)
> +			return -EINVAL;
> +
> +		/* No time travelers either */
> +		if (year > (now.tm_year + 1900))
> +			return -EINVAL;
> +
> +		me->birthdate_day = day;
> +		me->birthdate_month = month;
> +		me->birthdate_year = year;
> +		me->birthdate_verified = true;
> +
> +		age = (now.tm_year + 1900) - year;
> +		if (now.tm_mon + 1 < month ||
> +		    (now.tm_mon + 1 == month && now.tm_mday < day))
> +			age--;
> +
> +		if (age < 18)
> +			pr_info_ratelimited("Process %d (comm: %s) registered as minor (age %d). "
> +				"File creation will be denied. Please ask a "
> +				"parent or guardian for assistance.\n",
> +				task_pid_nr(me), me->comm, age);
> +		break;
> +	}
> +	case PR_GET_BIRTHDATE:
> +		if (!me->birthdate_verified)
> +			return -EINVAL;
> +		if (put_user(me->birthdate_day, (u8 __user *)arg2) ||
> +		    put_user(me->birthdate_month, (u8 __user *)arg3) ||
> +		    put_user(me->birthdate_year, (u16 __user *)arg4))
> +			return -EFAULT;
> +		break;
> +#endif /* CONFIG_VFS_AGE_VERIFICATION */
> +
>  	default:
>  		error = -EINVAL;
>  		break;
> diff --git a/fs/namei.c b/fs/namei.c
> index 9..10 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4148,6 +4148,45 @@ static int vfs_mknodat(struct mnt_idmap *idmap, struct dentry *dentry,
>  		       umode_t mode, dev_t dev);
> 
> +#ifdef CONFIG_VFS_AGE_VERIFICATION
> +/**
> + * check_age_verification - verify the calling process has registered a valid
> + *                          birth date and is old enough to create files.
> + *
> + * Returns 0 if the caller is verified as an adult (>= 18 years old).
> + * Returns -ETOOYOUNG if the caller is a minor or has not registered a
> + * birth date.
> + *
> + * This function exists because the fundamental UNIX
> + * principle of "everything is a file" was insufficiently regulated.
> + */
> +static int check_age_verification(void)
> +{
> +	struct task_struct *tsk = current;
> +	struct tm now;
> +	int age;
> +
> +	if (!tsk->birthdate_verified) {
> +		pr_warn_ratelimited(
> +			"Process %d (comm: %s) attempted to create a file "
> +			"without age verification. Set birth date via "
> +			"prctl(PR_SET_BIRTHDATE, day, month, year).\n",
> +			task_pid_nr(tsk), tsk->comm);
> +		return -ETOOYOUNG;
> +	}
> +
> +	time64_to_tm(ktime_get_real_seconds(), 0, &now);
> +
> +	age = (now.tm_year + 1900) - tsk->birthdate_year;
> +	if (now.tm_mon + 1 < tsk->birthdate_month ||
> +	    (now.tm_mon + 1 == tsk->birthdate_month &&
> +	     now.tm_mday < tsk->birthdate_day))
> +		age--;
> +
> +	if (age < 18) {
> +		pr_warn_ratelimited(
> +			"Process %d (comm: %s) is only %d years old. "
> +			"Must be 18 or older to create files. "
> +			"Ask a parent or guardian for help.\n",
> +			task_pid_nr(tsk), tsk->comm, age);
> +		return -ETOOYOUNG;
> +	}
> +
> +	return 0;
> +}
> +#endif /* CONFIG_VFS_AGE_VERIFICATION */
> +
>  /**
>   * vfs_create - create new file
>   * @idmap:	idmap of the mount the inode was found from
> @@ -4170,6 +4209,12 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
>  	if (error)
>  		return error;
> 
> +#ifdef CONFIG_VFS_AGE_VERIFICATION
> +	error = check_age_verification();
> +	if (error)
> +		return error;
> +#endif
> +
>  	if (!dir->i_op->create)
>  		return -EACCES;	/* shouldn't it be ENOSYS? */
> 
> --
> 2.49.0
