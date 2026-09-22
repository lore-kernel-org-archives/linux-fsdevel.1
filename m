Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1D2429CD7;
	Tue, 22 Sep 2026 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065853; cv=fail; b=L/G16RqrK8tUVHvccS7UoDmehWX7kZP8gzEse2Njfh5sqG5hc+lebYrF8+KPM1zfQXOxSDp31ufjyMYVCKnEDGxMBNmrINe3zVLbFyUQt9WCqCUUjxxj+Wr8ClKYmK92AonVHROrO7+qJAcjS+buFz2BrZCDZJHUJBkWFRJ9780=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065853; c=relaxed/simple;
	bh=hweQDg1xb9A6sfEjp1BSlhvTVcrjhGPAqG9KGnFO78U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mPKKflF3xO8Qkdx0lP3WGaVwzWyfVn25YnJWEypiurFV3qpmJWuLr96e5jO8On313yoYumDth06WwobJrZKEx5S+2EnlUFMAP0CNkKh6anzK3/9a0B6f579tnbkU36q8eYJE/Wb9UiRlSbF+QLJRbobmhYERgNfKoyFsgdTq3sQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UffrW9q3; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UffrW9q3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790065851; x=1821601851;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hweQDg1xb9A6sfEjp1BSlhvTVcrjhGPAqG9KGnFO78U=;
  b=UffrW9q3yAkdVOaibeIT/PNDFWkPwn3gs5PLBiB0EImUVaia5q+ZRWS0
   QQ8k1JMjv1L1UybK01VT9MZNGBFl02m+grKOfr25EaJIWVQFL2rgvlMuG
   5DsxBXD0ERN6MfhDNyfTfFAYWmrjJmRngNSRYB5082m10FiZT4c7LjZvJ
   FsJvIWi+XJJoF6auRXSUPFLJNIMTu82IQLpbjiBqZO8pi+GGERobSlfG+
   4qs1pCgAlmG7Y1lJ2UGp5ag5zbjK5N+yQcWjh/fyykRyq26No9allncyl
   9etZ5BhW7/L/w25ITa6tYR6hnuTEBAhFKdcC84SyXZudbdP7jUbn85ts8
   Q==;
X-CSE-ConnectionGUID: sTOmi58eRBKonjUZGxD7ug==
X-CSE-MsgGUID: Tf6qEluqSPynTayCsH2cPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="90664446"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="90664446"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 01:30:47 -0700
X-CSE-ConnectionGUID: lYPtLojXS0SzbyAOXF9aZA==
X-CSE-MsgGUID: zLmMUEb8SQ+xbXNgCkY/Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="4138410"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2026 01:30:46 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 01:30:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 22 Sep 2026 01:30:45 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.66) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 22 Sep 2026 01:30:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBCRzv/nEhm/3EiBo4pQX2onej6rloWCnGJH4XbbVgMWKELMAayvmZyBRCFcfzc5ZeFfuI9Vzl/My4RV1a5CpDL+DGwVsAkimiGBnkXek58CTvEz1l/y+pPp9orSJHuqVpOV6+vQnc5qdhG5AwyRz2n8VBhcZ2RWCXUSmyHS8OK9K41Js08ru2mqPwYbMAPMWwy63zw0pAHh9yGJjL14Gm1NMB2VRsi4Kvtbiu7t1oNY0CEkADQSmKhBZ+0tW0ZBBUBhf7TGlhQRvA/jKMrCXUV5MGCjmVWoAeQ7A+rZtjojrKx5DEiMRpGePl1PfUpbsIJXL02wPlun2mJ7kGDMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hweQDg1xb9A6sfEjp1BSlhvTVcrjhGPAqG9KGnFO78U=;
 b=cKTJ9glJF84iB0QbsplosNWBgThc2RX6yJKYHjT2+/TDjyMEyXPSeGcCx7JxwXuuPu3qJGTUAjo2aWFC3cefSmG8VXVSam15c0HCwKVjkro1zTHT8yTc8zgY5KfZdigks5HnieUrqwCUbziftbugY6vcshoZ8XgO1UkLRwO1P18fx3OHTpKu4/6YQJR3CA83bYJ1O3OE7iLdh/62R6YkPGZGUNlQmG8jxRaMCO5NGp1iXpKlC7gTIeX1fbRDs7r3j1j0NzBgkvRVpZ+q3TbL85UqOm1exckqjWH8HMfhcobtWyqmBxDoQMFKmdARYrduuF2IsAvJYEtSwQeS9VvmXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH0PR11MB9702.namprd11.prod.outlook.com (2603:10b6:510:396::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 08:30:43 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%3]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 08:30:43 +0000
Message-ID: <fca9c647-e8c5-4ff7-aa37-e3cc058d3161@intel.com>
Date: Tue, 22 Sep 2026 16:30:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] sched/cache: Honor migrate_llc_task semantics in
 active load balance
To: Peter Zijlstra <peterz@infradead.org>, Tim Chen
	<tim.c.chen@linux.intel.com>
CC: Ingo Molnar <mingo@redhat.com>, Lu Wang <wanglu.priv@gmail.com>, "Juri
 Lelli" <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Kees Cook <kees@kernel.org>, Christian Brauner
	<brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara
	<jack@suse.cz>, Shrikanth Hegde <sshegde@linux.ibm.com>, Qais Yousef
	<qyousef@layalina.io>, Aaron Lu <ziqianlu@bytedance.com>, Srikar Dronamraju
	<srikar@linux.ibm.com>, Vineeth Remanan Pillai <vineethr@linux.ibm.com>,
	Ricardo Neri-Calderon <ricardo.neri-calderon@linux.intel.com>, Hyunwoo Kim
	<imv4bel@gmail.com>, Zhan Xusheng <zhanxusheng@xiaomi.com>, Zhan Xusheng
	<zhanxusheng1024@gmail.com>, Yi Lai <yi1.lai@intel.com>, "Rafael J . Wysocki"
	<rafael.j.wysocki@intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, Zenghui Yu
	<zenghui.yu@linux.dev>, <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, <stable@kernel.org>
References: <cover.1790035273.git.tim.c.chen@linux.intel.com>
 <cb39f64a17fc2b76097264aaec74a2d6dfff4315.1790035273.git.tim.c.chen@linux.intel.com>
 <20260922072352.GW4121339@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Chen, Yu C" <yu.c.chen@intel.com>
In-Reply-To: <20260922072352.GW4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:196::22) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|PH0PR11MB9702:EE_
X-MS-Office365-Filtering-Correlation-Id: 58620166-a425-4d17-95ba-08df1883cad0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qfVdwgHA43+phctySezePALj5acMk49TQaOqDxliT+5aJ7yMLCwWXe3T17XSWAQ/2pEq0mfmuIhzIAS27LKpx9tzPVHVml1A/FxbXGhsS/JB17YP4haXA1hQV+TlNA79AJ0jTvHHtNI8ZNDn+PiXbyZzzyEKS1Fl93vZWDzx5khX46Q4gOv+V8As/9/qfqHNggavepjuJ+4UZKGJentHO2gWKPdUKNOHDs+J7hO5iCVV9W59Ynl/hUwxzxJM4yhISq3csQEeAJ49wAY7MsPkYVjkgq6SRM6jINN8pslH4HnOZ8Shme4aIjQR64Yu5XafISzhkR1kS5LsgmWzolPU9QndffxKYkFtotBpXSm4l9Bf0OObOPtuEWLPCKLnN77wTbR/flBgR/YgPpxgLyUS8fteTWax/wy7+0iOvCGyJhqrfSBnV4ssifo4+oAIejhCL+pN+XKh9C6PLt5rEjQkhVW4r+t/tJirRRf2lOBv/c6xWkCUua17wliwfze7Y9mBy7JeFZOeTxTZQs69FBRGK5s4q3dfzbY3TSRYFehNVOPzrh+WoICjgoy5yGDMqPG1FHMOzA2qShjfC563lkGLH7nBQI8khiYnXpPscxTdbTk+xYxKgQC/B+JrjfkeDVQMam2fRu84N3M0ODlo7gszhENYaGtAxkFucCkjwtSMWD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTNaRWJMWmZiYTUwbnpZTEdnem02VW42T0JRNXFXVGZ1SnNPTCtlNk5LbUVB?=
 =?utf-8?B?YVFkRldkaFIzVnhQK3BpYmw1NTVtZFdZS2JnNERtazQyNVRuQ1cxYUZ4bmVC?=
 =?utf-8?B?dlVpUW1HUjBRdWdLaXBVQkl0QTdGTjUwZHgzYUxEcEd4djFsNDZRRzBHUWUr?=
 =?utf-8?B?ZWxUV21vMjdxOGd5cW9LbXpvcGZvN01ycWJIcnEvYUtLWFFCVTBDR1Bhd0Fa?=
 =?utf-8?B?UUpBSUJBbWdTWDZJckpPVE9zcjV6VXQ5eDVnUy90cUFKa3E3ZnVDL2Jjank3?=
 =?utf-8?B?dVRIVmJSWE8xL1ptbmFkaElkZDRNMzh3VG00RTBLa1hYTFduVUFCS2x5Nk5o?=
 =?utf-8?B?NU16dXZ6VWpaL3ZlSHJoSWxVbjVCOW4yQ2VaWWIvQ0I2aFB2Qjd5QzRKaytH?=
 =?utf-8?B?cFFMK2ZzOXhjcTJvbjJmanhiNG1jQUJXSUpHUGc0c0xwaXRmOENPcTRKQXRS?=
 =?utf-8?B?U1M5UmdhNzJmTkJjNG9RNlZEMTlMckxoMnhWdmZ5NDh2MFI0Z3c2NUlFYU5W?=
 =?utf-8?B?cTh5L3NmYVMvN05LWVZPN2Q4RzV3NHdzbGw3aFFJRWNsOFpJY0NHT1FiTlN0?=
 =?utf-8?B?ZnRyZHRNRjJNR0dpbnZBNnNRWXZSOWpiS1hWOUhmM3VHUTlSeStiK1BSWjZv?=
 =?utf-8?B?YW1tN2VPVGUyKzQvdENseUdsZ1pHNEEzdmxsTGxWeFkvdm9LYUFBMzZNL2h0?=
 =?utf-8?B?VGdsQTNTS0xiSWlIVHdxYVgzOG1HNkwyYWtBRFNxTTlaQTZjQi9aZlBaKzRR?=
 =?utf-8?B?OWFWb1hoVkcvK2k0dGtPRDRrOXhCQ1JseVBMN0ZpZ1JDMDY4ZU1HSGFMY2x1?=
 =?utf-8?B?N0VvVWdQQ2Q5Sm5Rd1dFV3oya1o5cU1SeG1wK1FqU2Z6ZEZiRDhPSkJsK243?=
 =?utf-8?B?U2VkbHZvZ2cxS0JwZWRjQkZBNnNHSDEzTnViRU8xb2t3UzJSQytyOWM2anBu?=
 =?utf-8?B?ZCtjV3VjV2ZXYjdQZ2t0Vlo3ZmNIRzE2aGg0clltNnNCQ1NOWUJtOFF5cExM?=
 =?utf-8?B?MDgzWFdiWjhpVjRJdi9qbmZVOFh2REdjNHZndCtLTmx6VVQzYnhvYjBTZHpU?=
 =?utf-8?B?cWJ3ckZaQjg0a1hzWU5pNDhSZ2lSeTNJTjhaOTNOQVU5ci9LR28xRm9jYlZW?=
 =?utf-8?B?aDE5ZVFTTzhSbjdiRTJiakRPRnU4bldMMjVvUWtJa05lS3Q4TEd3STlpbXRq?=
 =?utf-8?B?cXJkWDdZbFB3azN3cXZ1RkFnOUJFRC9yL09hT2lOS0lZZ0cxRnFjRFNNRHpa?=
 =?utf-8?B?YkZiL2Q5Y3BlVjR6QmtwZ3daSGpxeWRwaHNrWWRtbTFzQ2xlTkNiaXU2Y1ZY?=
 =?utf-8?B?QUtBcUZnL0xKK3dTQldBTmtkVFQ5ZUVDS1E2WnNqY0dRNC9GMTY5OHBPRS9J?=
 =?utf-8?B?d0J0dURmb2NtQjkrMEpodEV2RmVtQ3JDNFdXUWRsb2l2Y2JsRVRrOWNiTWZ3?=
 =?utf-8?B?NzFONUR3SG5rMFNlaFN1ei9HVzVucTROUnlBV0grb1E2bmNrSHE0ajNPS1JW?=
 =?utf-8?B?cDlsOSt0ZVpSc3pKZmxxMjZDYUY0MDRSbU04UVVLSlYwd051d0FJZE9KK09n?=
 =?utf-8?B?dGdoS0F4ZmFYM0V2UDlIRHRXSHoveEUvZ3d5elhhYzZwK2hHK0dIbHdscC9l?=
 =?utf-8?B?U2ZHWThDU0VsWWRyc2NFMWt4cHB1MkpOeXdtRmN1S3RpbHlQTEZxS3k3bWlR?=
 =?utf-8?B?VjVNUTVMeGx6MnI5c2xrV1lxTDE2Y3lCWitDYjRCbzBDUngzSmlNdU5EY1dh?=
 =?utf-8?B?eEVER0o4dmlQVmJEZTdyejdGaDZOUUZqdFc2ajFibWxFQS9wUXhJdUthanlC?=
 =?utf-8?B?dkpQY1JxYUt6Q3YxK2liMmpCVEVnSEQ4b3UvLzNCM2tKZkdOZzZQVW5qWUNr?=
 =?utf-8?B?L3Raa2xncnk5eGJmSCtEU0FQbVpGRU0wUk5BNGkrQlRMbFVoLzFteXl1MWlV?=
 =?utf-8?B?bHQzNGl4Y2JKa3BrNmswbzJpdVBRRVFYUWdza3RIU1JPS3BwUXY0cCtLRTNJ?=
 =?utf-8?B?TE1rM0g2NjFIWGs1eUtobFI1dkVIWlhlYjZLNS93V0tWY0FJNGNCbGw3YzQy?=
 =?utf-8?B?aHB3SzdxNjVkZ1lEUEpzZk5YV1ArZVFMdDJXcjMrbkc0LzFwcFVHcldyaEJv?=
 =?utf-8?B?aTNJeVU2U0p1U3pKNDJwL1pZdkV4M3pZdGo1dWFITmMrYlNEdU04RGd0MEhK?=
 =?utf-8?B?UTJseEVXSURabDJHd2ZiMUU5aFFoZHU5czZMWEVCNDg1VGVhV3NEY0czSldV?=
 =?utf-8?B?LzdWUlV3UzNneDZaUjN0dDNyYUdaRytQcjdZZWNubnZYR284OHBPdjNld0Uv?=
 =?utf-8?B?NU1hN2JsSUxyYnVFVDNaMG4zcGgvVGdQSjdYRUI2UnhpOS9aWk50Zz09?=
X-Exchange-RoutingPolicyChecked: KLAwvQLFwJBSGCwYCuVMAJkoVkOFy9Iu8fB7rqvTGU6w2FyHs4VVrguzJJko+qrE57uIXcxqw9uBsfUyeQxtSXqk8eFPYsJj0CajBN3vVykWIkkNqCjxxxR1gYsIb4CiogIB3w7j00TT1mH6EL4xGJ5SQRkRrpPD8tDM2EF5Vl8OBEqGUfiBzdf21LpQLLujpm2rF2f3SIPa4PLLHrrMjaOHyCjrhe6fGdw6OlKWcZpbQIq8kMcBAbRNntiVkQCL+oPmqoR0ng29xDzh1d3D15QgRUfMOYggIPW0+W/yF2atSIm9dYZ8w0tL2kN3b8F0h/L7+7gWeFqI0Kh3J6CQgw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 58620166-a425-4d17-95ba-08df1883cad0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:30:43.6158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTkZVFoXbXDQDXVU09u08fhRIcAjvo+TiOfuapHaIOzXn5EQscUFx7iYEuX3lpAfrA9xYJVnE9PHHcwooMW8gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9702
X-OriginatorOrg: intel.com

On 9/22/2026 3:23 PM, Peter Zijlstra wrote:
> FWIW, every time I read this I get confused, CAS maps to
> Compare-And-Swap, aka cmpxchg on x86.

OK, we will change it to Cache-Aware-Scheduling wherever it is mentioned.

thanks,
Chenyu
