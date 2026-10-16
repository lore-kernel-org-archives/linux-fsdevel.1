Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A4F30CD89;
	Fri, 16 Oct 2026 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137712; cv=fail; b=JnjTTbBgNVroQuQCJVD+5HXnw7YYGdYHmsOtFGpbdSwMlAG9t5oPbKm/vm/gtboHUvO8Fo5MbcDiKZIbFADoz016iuXOC8MKKikIghCxRJapLV5OycPWNj183UkBWCrrgCJ2UndpIMmzrH2YtP+kvO3HdHfYjRk/ZgW8/7WwzZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137712; c=relaxed/simple;
	bh=QofXWMwd3zcHcoH8c5HGZsqBXg7OaUZC/6qYuRZbJpI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X7Jo03VrCiow2VMPChkfbFDHF7GRlwLbt7EmmbIr2DR0wx9nM/WksQ3rL7Wsw0f3xw93Os0ct7pGLvYqJuwQHqU2q0u7hQyu3VAR0ANoVvO4+uN5X0e5z7EszrfiqLlyxnX1ufoD5uVMm8q4jQPAjASQhVKrjatZSJTUXUbrXco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GfnCyFFv; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GfnCyFFv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792137710; x=1823673710;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QofXWMwd3zcHcoH8c5HGZsqBXg7OaUZC/6qYuRZbJpI=;
  b=GfnCyFFvz7bv/9+JKY+warEbH2zye5p9vukOugloeNDoS1dZc2I9ixY9
   BOr0emGihpwdibOldG2s26YdyfwtX0GxbpiDS9t5VwVEbWqA5v48fvOy8
   F/E1O74/ff4FUCIShqw0jk5Wv12jUfxWQvEBqs1uLQ9J+yFPtW9lkgfb0
   oHum7/1NJHp3ezF78yWXptrzOvuKhePwizW8Vp6qxweg4AxAwhE5f0Q6V
   pmSaXUblRMJz0dr/ei4eSukshBl8XFQo5t500MGnfgHeqWu9ceTmd1jVy
   Dje7cPOY98QskXIYnOzoM3k7RmcfPQSY+hU8tML3u1O7YUC59feBe9PYD
   g==;
X-CSE-ConnectionGUID: ga5ZnvvATAWL+XOHkt4qKw==
X-CSE-MsgGUID: itUp75P1T26RO8bg6wNkrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="796737"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="796737"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 01:01:49 -0700
X-CSE-ConnectionGUID: lUd+FwhgSa6cBjnpzKONlw==
X-CSE-MsgGUID: oS7h+jL0TOSTBuemJPoC0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1958972"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 01:01:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 01:01:48 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 01:01:48 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 01:01:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BxkPhLI8JaUj+hD4q61plZERvQ020ciGvTfJVnDMLKVzzyfYjhGH2SD2T/k3rHCl2kHEhx6tO8zwC+sGX991UEQQJGfH4K3xUAJOWtGF1PUJCHJXCwyLM1lbFw98fTTZTm9XrSXY2jDUwfoGF3mYVK0ryXHOt54XhMM3/y9vghCBmbe6fhs58wczOKR7hpUusMs4T/rAaGBqDwzhcqkGMt010d43ieDbF4DCtpch6PyyllacXWVTtfJnIlW1tPX1kGb/tVEriE0Q5tPSG7q5Z1CYxG+ZxEG579gGrqxyhz76hbjFwU3oknTS0j5yWCdZY20PGfHGAExwHn9U0aFzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CD8bN/B4jLTz2bL3EGQviwBV+uX856d9UT0+mktOmuI=;
 b=HM2A/JnEF55bClaPXLAlhEfSzU66134uBv0fyfoc78gkVA99IrvOfS2uPPQgKmdhascRHFx07peF9yvBrjoPOso/RZK/TkaqulBaMBYqaaiXP3N8LleKtuaoYgy18UAL7ty9UG/ak/x2feFuqGrc0c83gm+g8rlOO+Czn7S7BgoNhky49RireyBmsMGFQfnfhe50TnErjLekMuwML+0QuZbxT5XFS1dgRPNrgXdHuixvmVT6xtpe1ulbwaQsVyHi9xG+y4F8U9XPaSb/pG7WZfO2KyumY7jfQikskTUF6r7XYNU1ae6hHX4KWefv0dB3Oo6YnRAzOrWpqJ4MffsRtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 SA3PR11MB722019.namprd11.prod.outlook.com (2603:10b6:806:531::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 08:01:45 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%3]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 08:01:45 +0000
Message-ID: <bcabbe25-5b2c-464a-a22d-5375a342f938@intel.com>
Date: Fri, 16 Oct 2026 16:01:33 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] sched/numa: Add per-process automatic NUMA balancing
 control
To: Yafang Shao <laoar.shao@gmail.com>
CC: Tim Chen <tim.c.chen@linux.intel.com>, "David Hildenbrand (Red Hat)"
	<david@kernel.org>, <ljs@kernel.org>, Li Zhe <lizhe.67@bytedance.com>,
	<mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <kprateek.nayak@amd.com>,
	<linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <tim.c.chen@intel.com>, <mkoutny@suse.com>,
	<tj@kernel.org>, <chen.yu@linux.dev>
References: <20260908122446.56708-1-lizhe.67@bytedance.com>
 <as3gQ8jfa_6eBf15@chenyu-dev>
 <CALOAHbBssx9ZHGwebGZCvzT4d_soyjNfZRj4L6gnxHRXtc7eMA@mail.gmail.com>
 <807eb0e80c76c3ccb85024b360bd47ace201931b.camel@linux.intel.com>
 <CALOAHbCt+iGGWMxzjrcRamdSqD48_v+V685-qi7_Qy7UL8bxxQ@mail.gmail.com>
 <atG4VXk4t-m8VubY@chenyu-dev>
 <CALOAHbDY6zLcEc4kGhC9GSFsOsREadkWN7Q4CmZuR_m_BMHAyg@mail.gmail.com>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <CALOAHbDY6zLcEc4kGhC9GSFsOsREadkWN7Q4CmZuR_m_BMHAyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|SA3PR11MB722019:EE_
X-MS-Office365-Filtering-Correlation-Id: 259dff7d-b31a-45b3-48a8-08df2b5bb8d7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|23010399003|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OjYq3HjwkXOmQE0LHA15HF8BXJ4ncuT+w44186unXlFIBEU2mdOUk3bNUa7MmrlnnsCPDTCmVw3zua7ySigcC8JlmyixRE1eEdbrUTZQZyMcPhPN+LKSXJzhAUEwuUVtuNrcgpNDYxa47g6DobobW3dE2O8eaqOsJNweIOQ28KGtlq18FBz09W+hGCmsfdLjI1GtDYLyk0as2NuSYdQPoZvTOltahZvcMPzmLJZwE+obW84oNzzxjJ8wNLsC95Kot81ixzW+oPTpw3JIWUigXTX57rb9C61G2WX0J7etgE/Tz82upNc1saD0L0QsVmr3pCn7Zi2eVwh3c0DPAGqRzDvVPH8wTKfMmK93e9YW3iKxDUILQ6Oli+eZbiVd79GJEgNGyImoDIbDStlPJX12pDpkomL+0dnJn7nbc1b0m223tDLFXfBU2hoyADMIzwVwK3bKyJOSiMRAnDcI1rC3zMmJ4UqPB8UzQGhRCm+LIxgPGtgNDLxm2OfG1tlY1h4IE17UBJRTWoUJMpyKu3H05XH46DGSIjFQEX1/nQyYuW+iWRhp5tdgamcpNVPvfHq5fg1z8+l8fEEJqCpHjbOMR59a3iiZwX7KPgdEGKhabapB3vN7wzYvmCevy4aclUr4oJlkoNZP3z9KzJzKQ1gnDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anl0YjczeGtKZTh0VlBaWk9CYmRVRFgvbDBldGNFSENZZmFpdEM5VjBZUmJa?=
 =?utf-8?B?cmlrUVdZeGUzUTgzMWNyVmdnby9mVG9ya3hmZXBXVlFCanR6U3VYU0MvMElJ?=
 =?utf-8?B?WFpEb0JSdllGUy9xNERNTFh1dTVJTkc0SkRrUzhpbXFYZ0hZdFFNZ0JxTDVZ?=
 =?utf-8?B?Qy9NaXl4R3VGTlpkVTVHZ045NFdqRm9uWWE0WVBqK1RtU2x2c3kxcU5HMzJz?=
 =?utf-8?B?bFdTV0M3YVpCdURsY1VYMWtDT09vTnh1WC9RRUY0MjRDOXlYOXJ2UXBIVmZq?=
 =?utf-8?B?cUo4VlJwZmNPVWo0UUY0bXcxZ2I3dExTY0tVd0srZVZsVi82NHlpWTRFL0tY?=
 =?utf-8?B?MUJxci9sTDk2SVJESUtNc3JXTDRva01wcU9peFNWdXpqSXdyOW42d0hweFhV?=
 =?utf-8?B?U0MrWkRxSi9DYjBmM094YzhOLzVTV3RUM2V5RmJZMGZmRjBMWjJXMkNGazkv?=
 =?utf-8?B?Rm1veVRBazZaNndHZS9LMUhLb3NNWjNZTTdROU1DYlhlbi9YcHRCcTR3RTNM?=
 =?utf-8?B?VmMvc0oreFVsdkZ1cE5LQ3NvYk5QbktZWFIzaVRpbmxlUkJ1NytjUTBEMW4x?=
 =?utf-8?B?K0R2WkhEVENySzVuazQvYnVFUnBnOGlYK1M3MGJMWU0xMTJlNzBvck5kZDh3?=
 =?utf-8?B?VGJ4N1RRK0dNUnNuOTA4WGtFTitRWjZzTkRUYTg0ejk5QlRjL2h4YTFVTi9E?=
 =?utf-8?B?TkJSUEtOQWRXMnkwbzE4UUd0QUphSklhWk1NOG9PTVI0WGpVdmI2WmRZKzFS?=
 =?utf-8?B?YnJZazA4YTRJWVQ1YWFvK1NPTHcxUE5pU1VEbEtUK2lMajRyUm5laDQwMC91?=
 =?utf-8?B?Yy80TnE5bDZpRGZnRUJ0Q3k1UVlRSWRtRFZzS2U0UGtRTytQdUxvUFpKclVK?=
 =?utf-8?B?Ky9HdFRMYmNmNDRyVktQYVl3V1BNbUNLeFhQVmFVcWs2cXRONjVnejArWWdS?=
 =?utf-8?B?ZjkrVzk2UUNxMFkyNjRRUjgyVU9DWms2Yk5xRlhKVEtRcGErR2l4V3VPQlEx?=
 =?utf-8?B?NmR4MjQydHRsVTY0NEpHYXNXSHRlL0dPL2dqNG8zbU4vWjFScUNMYjhDRUs1?=
 =?utf-8?B?SWNDTzQyOGtJYTJJejQ1Tk5LY0lFcTVPaVY3RWtUcDhWTHQrMEVFam5UdXp2?=
 =?utf-8?B?N1RlU1pEWEh0M2x1bDZLNUFudzJrQldzRzRyek4vbnRCV0hSN2Z2SHJSTnR3?=
 =?utf-8?B?aks2U3JUL3BjRW1JbkJJbXo2cmpIUUZhNUt3b0IvMXlKSUJDZHBOK1lsdzB3?=
 =?utf-8?B?eWtkajlRUVpaR2h6Z2V5VXpsQzlqUmhGUlJVaHMwdkRudWh5MkpyZUxDSUkr?=
 =?utf-8?B?b1diN1hzT2hRRXAzSWZQbEltNnRzNCtQaXQ3azVTM2lNeUNyZU9pdU5wL0dR?=
 =?utf-8?B?RXZPTitDY2JKUjRHdm4wTEkyZmZnYnZ4ait5Y1pPQmF4ZU9mS2lDajExNGwr?=
 =?utf-8?B?OXZJQWVZN1pTVTFJTXpSREIxSXhjVmZkMm1sRUxURWlMMjFreUhXQ2RMY3dl?=
 =?utf-8?B?eFBCUjFvSWtaU1F3MTRHRC84UTBnQUFRNTFLck9IaUZ3SFQwbHZ4KzBDMzJG?=
 =?utf-8?B?QkZib1UzU3ZGbytiemV3YUx6QmR5ejRpbG9pS2JZVWthZ3BqenNsSkVHNkY0?=
 =?utf-8?B?aC9QLzdRUDdrZDdJeGlyN1hGb2JTQmU0YSt4WmEyVXR5ekNZbGZhdmlQbmJv?=
 =?utf-8?B?UXJ6ZG0rWENZSnNHbmlRNHJoSFAyc05RSDgwQTNHRExlazRvZWxkcjBRbnAv?=
 =?utf-8?B?d2RmWDc1RHRUL3NuQUhhWGhIRHZFZlYwM01HS2ZXQThQclZuZ0FsSmgrUjE4?=
 =?utf-8?B?WXVoSG1PTHp5U1lPMVZzVzB2OTBBc3RRTUFvWlJVWFVhN0ZKWElRVTZzQnFl?=
 =?utf-8?B?RC9xdjNGZm1mSUsrV1lXeFhIcEdqTmhQQzFFb0JHR2xYekhLdzZCWmpPT2J3?=
 =?utf-8?B?RkEzdUpnU2tCVnZIbzBoTU5qdDgvSGxQRkZKV1cwT1VSYnFvcEpadkpvN3Z0?=
 =?utf-8?B?dmxYVnRLOUVqSWI1L1hDZkxXMERBSkhpK0xxTXB0STJhdWNSSG9iS1pCeVM0?=
 =?utf-8?B?NjBFQnF5T0JOUk9FZEx0MmFlczZZQk5JaDlneGNwV0lDV3VZTkVIQWhGc0Qz?=
 =?utf-8?B?b1BXR0lOKzhsa3V3dUhCV2xxeEppMDNwc3NyUFdPVU4yL1liWk0xd0ZxTjZt?=
 =?utf-8?B?YmNaNnBrUmQyRFc3SzZlNFo3U0ozYXFORnl3SC9sRStYRUplRjhxSXYrV3lC?=
 =?utf-8?B?Yy9sdW1Uemk5Z0RGS3BodzRtZzFYaDBTdkkrSFRzaStuZCtEa0h5NzAwbzdu?=
 =?utf-8?B?ZElOYWFCeXYrS2dRY1lRaHNOb1IzOTJtQnBWNHhyaExlMmRxUHdLQT09?=
X-Exchange-RoutingPolicyChecked: bvKRatJyEG1bzpHn+0RF+PF8gqIPKNWJFCoSwPXPYOdMhC6g27F/8Mkl/VDLu/k+vqP7iIqT3k/uSUlnEf3xIoskHTzfM46bMsHwAMdFvN+sX0CMnsWsR4YCBJSEPXl+mQCbJKgG6qPv90QliHSetPEDAmPSJMvhkS2h+4qqFBRGMy309gTBIsF+ygdS8USPOgMO91gpr5UB5MRD/SeC6AHgP0EWXn/RcKZCXdz1v3CvyRmqBjQcTocY6MFZ90WdOhIaibJf+mJm/nzjPQjfE7J9WQxFtg++noTWdNBxkfIbhSNX0rnCWO17RFdC2HeSFkX/3L1YmT0xK/m9boeW7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 259dff7d-b31a-45b3-48a8-08df2b5bb8d7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 08:01:45.5051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BmV6NwMjN2wqMcYRf1DQlXCz5fTlPhpFM8Dl8ujDe00ivUOrS9ns1wLocN4GyB7/YHq0UpPCIJJ13nhlBr7nkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB722019
X-OriginatorOrg: intel.com

On 10/16/2026 3:38 PM, Yafang Shao wrote:
> On Fri, Oct 16, 2026 at 1:51 PM Chen Yu <yu.c.chen@intel.com> wrote:
>> A more complex scenario is when cgroup A and cgroup B become threaded domains:
>>
>>                           root
>>                          /    \
>>                         X      Y
>>                         |      |
>>                         A      B          A, B: threaded domains (thread roots)
>>                        / \    / \         separate memory.max / io.max
>>                      A1   A2 B1  B2       threaded cgroups
>>                      ^        ^
>>                      |        |
>>                      +--------+
>>                    want to share one cache group
>>
>> In the above case, we might need to change the deployed cgroup hierarchy.
> 
> I think we can enable LLC-aware scheduling for both A1 and A2 — does
> that sound right?
> 

Here A1 wants to share data with B1, but A2 does not want to share data
with B2 nor B1 nor A1. Enabling cache-aware for A1 and A2 might not help
in this case.

>>
>> Suppose threads in A1 and threads in A2 belong to the same process Pa,
>> this reminds me of the cgroup bpf NUMA balancing case: after enabling
>> NUMA balancing for A1 but not setting it for A2, what would be the final
>> NUMA balancing decision for process Pa, is it enabled or disabled?
>> The NUMA balancing scan/invalid seems to be per process, so if we change
>> the setting of its threads, the whole process will be impacted. Or maybe
>> we should not enable NUMA balancing for threaded cgroups? Anyway I haven't
>> digged into your cgroup bpf patch set yet, let me try to look at it.
> 
> cgroup NUMAB works the same way: the setting is per cgroup and opt-in.
> For Pa in your example, since its threads spread across A1 and A2, you
> would enable it on both — enabling it on only one of them is not
> meaningful.
> 

I see. I haven't yet digged into your code, is there a per cgroup flag
cgroup.numab.enabled? Would there be a logic in the kernel, when 
A1.numab.enabled
is written to true, the kernel detects all the other cgroups {X} that 
contains threads
share the same mm_struct as A1's threads/tasks, and then update {X}'s 
numab.enabled
to the same value as A1, to keep consistency? In summary, if threads are 
spread
cross different cgroups, when you set the enable flag for 1 cgroup, will the
kernel iterates all the other cgroups to update their flags as well? Or
leverage userspace to do that?

thanks,
Chenyu
