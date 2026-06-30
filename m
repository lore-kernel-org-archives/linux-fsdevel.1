Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C8E3DDDC9;
	Tue, 30 Jun 2026 05:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782796754; cv=fail; b=t7MTDUd7rIpvuu6Jsofr3aSi02kQA7AOK4WiwpFFhRPTdCXSDomuSelFZMVF543QWuRxXoxigCyM2EvX/3oDfDU9onQaKn9alNjD7mYNHY10EdsFHQHFS/JX4wbTElgAvU45rGijdogCZXdqT+fNSMQ5ayPUOGO5ETqek/3Jpx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782796754; c=relaxed/simple;
	bh=xoZpO3Nn9Xz6NEookp+SLXEVkAGySq94mDDdZS9j5mU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S6snATEDF6C3JsnZo01lvR6rozfd8ZrKMoatEqMqx5yAIXAeYIxvEajWZLnkUTh6FcbRKYO2juI2LJqm6LkvG1a2qoh2zSUkeADmK0QHScEY1fgu+wf7dDWbXlcLEEQK/E9RmJWQktV/smLIzxBOqaYGWCChC2hwer0l21oQO5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ghx3M9xj; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ghx3M9xj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782796753; x=1814332753;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xoZpO3Nn9Xz6NEookp+SLXEVkAGySq94mDDdZS9j5mU=;
  b=Ghx3M9xjmFO0rin0j/B4i+Pw0wPLjO/a1XUn6LdR9mErTMirEj5hQ+cR
   DJ4p4uZMyMYHrlEfbTsi2RBzSYslSJJTiJLbzofEiR+Hk9UT5Rs38pe7Q
   cWwrek1riJxEOfIuso58ssOpTW2KjsYeb52PsY6afhn71Qf+8TnLVc/0S
   JbagdlCafHdQ+c7O1lIm/UEcOgfzXNy1zAiJo8q3saVazun3LDx12d4Os
   d1DQ+0va1hRFuPiV71MAsQOQ73pc/Uhsn6Lmux7LDa3cwyiPitSnLxBEy
   +jcSCDQkZYwSEJccb4P9M2pIYBLBc2hIsfBjHN0A8LqpVlAbH6foLY5QI
   Q==;
X-CSE-ConnectionGUID: vFd7swawSQSEBcqDr0pj8g==
X-CSE-MsgGUID: 54ntHgqgQ/qR3C3urSgOnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="94883748"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="94883748"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 22:19:11 -0700
X-CSE-ConnectionGUID: PXLBMhfpTUSYlrcYMLPCBQ==
X-CSE-MsgGUID: yhdxkHjMQGyLdNzlT+MuRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="252304937"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2026 22:19:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 22:19:10 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 29 Jun 2026 22:19:10 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.41) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 29 Jun 2026 22:19:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loWwHxlnluw0x0QpSSrfwlWDzNpyvQ6GMuEjOq9AZgV7qMwbf5Qowzpzu11YymvpN6fHLa2O1jO/7kcCrFknI++B6f36NdOPFHZVPOOX5K1xlwvcxw3JMNDRrU/kDrBnXl5wTVFqeqFqL4IColVpY2qJEjI6qVuxpdSIEZtrKSIG5rzn7bSRI5qOH/5pVENc7BZS9esockmYzJPX4IxQfgddRBM2g5RhuKCocs4M1TrZuCnbhB5LPi/Dt+M+UdAusMH4WMHLrXBxCEA97cWNR2AoJ/wu4VBauzch2EvN5G8hVVGw5cDDykaDB3gbGF/+oqxJOs4DKP5yGL5iXemVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieSHzdnRi3grpeGmjHj1k5KnI0IKjvLLfrGQo3EaKpw=;
 b=xnhdF4OT3/5RMzGyc9kRpq9Nsy0p8rd/4yU2eojjbcye1vka+bh8YVvy+1oxWVReNPjlBrzMeftQeOKqCQJ+McjfrsU8Qsc98Ahfq5CO+JQoyOZv6ltH2WpfM469YuBfEOwQL7Ap8p53YpOC7m47PRvEr4UHYzw9fml4E9HI6xLfm97Id3Efl8lItJAjz9Dll6LVqLr2QEww7JR/KnCkfzay10VW/mST02JAyYJ7PbWAl19oHd+0CqU+ZwBxCZKm6AytC8EQkMZjUQHDs9j02qqJMrkEAfVsE8mAGNo0ZPSkPCEd+Chjq+1puNpQnz9gZ6JVu1dylmEufaOzlcAP+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by PH0PR11MB5078.namprd11.prod.outlook.com (2603:10b6:510:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 05:19:03 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 05:19:03 +0000
Date: Tue, 30 Jun 2026 13:18:54 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Jan Kara <jack@suse.cz>
CC: AnonymeMeow <anonymemeow@gmail.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>, Christian Brauner
	<brauner@kernel.org>, <linux-fsdevel@vger.kernel.org>, <ltp@lists.linux.it>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [fanotify]  82c6dd2047: ltp.fanotify21.fail
Message-ID: <akNRvmJdCKALZbo6@xsang-OptiPlex-9020>
References: <202606291514.594c4370-lkp@intel.com>
 <qvbzvyoqab7c4g6jh2rezvdemqed7omco4qgvdq3elwbrlaffn@thrhz2uqtgqt>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <qvbzvyoqab7c4g6jh2rezvdemqed7omco4qgvdq3elwbrlaffn@thrhz2uqtgqt>
X-ClientProxiedBy: SI2P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::16) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|PH0PR11MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: f67042e4-3a55-4563-95bf-08ded66718bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: 8ubpTWR+EozEXBAL9QwcbLJwnnWiXO+bxMOuVRlUYMb83yWJ7o4+JJFf07/vVduPjeFHeB0iyOSY7ukOdkWmi+4jE3/rF2mQxqxz/mi8pG6kWn5zOuk6MP82sF7jN6mpOmSHDAZ3qBRspm8q2dSF36QRxsIj7uTUTMdlDjrrfy56Vy92lFhCGWWEseLo4TsQ62iqxV70uH9+9xNgZJf20R+PZfiR/yQkpzIAIqy0eAjxAD6NW/hZ7xnCOvgQJ7BFluzux8HXGZtWk9OrnHsQ0m7WSPK51P3OuWNcw42C2EfKxNXCQKdQnJoIzmQnx1YaYBtHFEGHpQ6It6DyOFkv35WecsavG+B1DPWYP2QGmK5zg+imDYch/8+GUlEKADTHdgVXwhk3ibaW9Ltdt173AJTZucUEXB1Uj6q/BeLzzrk3A7JVJBuPFdJlNqqrP5prEjH/xRjRr9slAGrJ7SjM2s8+qNnetVH7Lh4bZUS8857/4F1Yxg6FYdRXZxlqhD1T8A20185rJPXQ288TqBiiadvvqnJuGYY8ibIhqZu/N2IFTwPYULIkslbk5GPs0e2ziiwGP/fPHgWx+zUAqcL1k64V8biRB3tebpl/7swvYWUcRWgVtNcfcH6l5XDeSL1Bmvxj1WXKQSRrDUNV7Lu/6VWApmjGWjZ2irr9lq6yjhE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NsFE26PWJ4mayiSR+0pp4i1NZNaudzR3pMpPVIgt2Gjr/tT2VPtNtO1o0uE/?=
 =?us-ascii?Q?HnJrjnZbSHdDY2lhuw+A3yIem04K4DhIpQhT3kNoAE2hPYdJOyZRTIrNGtFu?=
 =?us-ascii?Q?/uCHLM2QAQI4WwXfe8aSSS2cDyvY94Zku2uo3gOQ+wTUfcQSDMIE34rDgWTL?=
 =?us-ascii?Q?678k+egWyY9YBqyAk+pKrn8WWfsnYESTP5wAAqXpse/NZnYQ4m2VVawE7akR?=
 =?us-ascii?Q?igX770Z3PP+fgYhXCwoMuRvN6+A1HypEO4F/gltDVdeWGSpNJUddGQJaYbhL?=
 =?us-ascii?Q?ijafMH8lAfTg3bAqS1ddE1zIGF9xZInGEo/9h+yPJs4bbSpQbO15beYXuAPY?=
 =?us-ascii?Q?IE6UeJ3TmpdKPFJXH7XGPu4kk+NwuSW32SReNOX7qsrPuLvL0IBQTb5hyqpL?=
 =?us-ascii?Q?YrFKiXTZnsDEeDsKwS7Yg4vTKgokhpDoDEf3QxyE/D547ZsmAE44HS9YOc8d?=
 =?us-ascii?Q?NmmRum1OxYc5Y7BdvjFJiqIFgviqUHd9BTxT8mVBoCxmmPNDTnRS67Zw+koC?=
 =?us-ascii?Q?9opxqa4NFgiMZFQCr6Xzg2lj5n5pgc+UPHk+sHh8dEhY57/W8SJ19aidHnuG?=
 =?us-ascii?Q?RLmpKXchbmMrSWiHoFNvuR7+v1yehICcxOvzZ+LL+h8QXrvOEHJQCimfvAnk?=
 =?us-ascii?Q?uAEUv7i3C4lp6sEG/CRMoNMbGGV0TYJKodyBOAblYWE4SR1o6MZzgNL1we9v?=
 =?us-ascii?Q?SJdMcp6sMeMdAw6aL88gix0UifxCSfDpJviGJTbIzzIVx5RbK5P/gaSijxtI?=
 =?us-ascii?Q?dYmMSWipQzDPSDr/HSCyOF0T6WrJL80IDJ0DQtU7S0B6RSXyHYSnYY/ncvhX?=
 =?us-ascii?Q?DWOW4wnqfo7+uxHjDjE41TXMf6TKYVoFf2HBbcRd5Ozefk1r3y0GeNsbAZsu?=
 =?us-ascii?Q?n3WP8AYay2q3zxIEVddJtYZy5M9TmkpXkgU9f2dxOS+Y67J+Zvug0nlthWA4?=
 =?us-ascii?Q?mnQh7p0To7EHFMxdPuXzVgQ8OFG6qB0LZHmSkc44pP1Z6yXYL+r6U57m4EeW?=
 =?us-ascii?Q?Na8VLgZtTPk8ODMqFOHc789W+MkElzKwjPQ6fCcbe9LrBKGKOQt5uCXK16Ub?=
 =?us-ascii?Q?WL7XR9c61sRXHW0FOso+iapuzvBtjRaGUUlZN/w5OHPm4V7kjE14dldJN2rF?=
 =?us-ascii?Q?ilfNohzRpWEcfY4j0dqWxI6FAWMKzMswfurCB6KFENEHk1FtnCHUALbGU9K6?=
 =?us-ascii?Q?S9EZkVcZ36cEAeUVLEd3WIJaCtJZ1swM4+oTWvf1DuYK5zy5eWDKf/UlV4U7?=
 =?us-ascii?Q?8fpsDjtuyRoaUsor8EhodzZ53Pc7fd0y8BQtMh2GDfp7lepiYfztS5VkBwN/?=
 =?us-ascii?Q?n/KGLagXRSlxAmIz12XRLNf4Dv673Kf//2VdjQyF9Zelf5GfEve0RO53xwhB?=
 =?us-ascii?Q?EeHjwl3kGsev0XpQej4O/uloTuQXD/Euplm4ijeuSwYtp8UHv+TUNtho+0xG?=
 =?us-ascii?Q?5qCKI8iHxwhQ0byXx+XJbNo20E/K50ckkj8rmPgVgGsb91KHw5DVTpHw5Tu3?=
 =?us-ascii?Q?2ySzmNlZd4twRkMfOcHqle3IOdpIqOiwLzbmr+u7XkXn/fxlPF+XE0brWKg8?=
 =?us-ascii?Q?wRWCvG66xia9ZUE5pcvTFdSaengR/K9W1JkcSsxYNZAqA/YEzUUZ5yYqhPqG?=
 =?us-ascii?Q?PIO9usIRigcVA2sqyau9HDXiyqHRpdD6XG5Pz+VCcUf4Df5lg/dGU3rQQRgB?=
 =?us-ascii?Q?Oes/DXNAo/CjKhG2deZ1lDDKqzbUBpCseUNIzeSdQXJY46jw9sTFHDWSO5jw?=
 =?us-ascii?Q?QLg3DK4CUg=3D=3D?=
X-Exchange-RoutingPolicyChecked: N1+eFOuru1N7+o5kw0UaRcJhwe33zVTL61hoGte4D15qfvzYOfFt46wy1/RCDRmE2aGg2RDYaTGmRd/Wi6YNsNCbGm7zfypRl07n3qDJVQHceeg2t5IEC/CueY2lQuu1kNp6Lo5lO28xdiWAxLsm4SBd4JLkksMi4dSrEe09cVRAeMQyHV3ULlkyZI+pE3J4QXsLP3yL9POIe/EcPZwWv5gkMcmF7JpwimsijuYL9xvMkaPoYF4/G7Ql2V5MpU2XolPBp4ub+CSZstt1ZihgWkoH+K3ERswV1zzoNieZszpAjrFyGdSfvZWddddbw4AiZWgN1CWEqx84TQYFA9u9wA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f67042e4-3a55-4563-95bf-08ded66718bc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 05:19:02.6699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wrQgcNkf7W6SB/Sc0Ac9SH2B4aobPVV+lK5JNZcSl/9A2WQNI119LyQ/EKmkW9UUpcWejJwHY6+qhdL7RAYYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5078
X-OriginatorOrg: intel.com

hi, Jan Kara,

On Mon, Jun 29, 2026 at 11:36:25AM +0200, Jan Kara wrote:
> On Mon 29-06-26 16:45:58, kernel test robot wrote:
> > kernel test robot noticed "ltp.fanotify21.fail" on:
> > 
> > commit: 82c6dd20479bb6a9625e1d63a650c3be8865e2db ("fanotify: allow reporting pidfds for reaped tasks")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> FWIW this is expected failure. Patch to fix fanotify21 to accept success
> in this test was submitted to LTP.

thanks a lot for information!

