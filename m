Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E51D2DB78C;
	Fri, 16 Oct 2026 05:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129901; cv=fail; b=GVn9vMbnuD+QVa1XniEU2ngB5zYowqfP2gMEAumq4ND7nOt8L/zVWFA+ZBAkegv9Y6q++iXC5NqzQFyLR2rkMj5g9Hib7O2HjiqUrpqjqGxv+DmSlXs6vgBY0Nq2ow9qGBtR9RQTwwC9EOEzq2wUNWdJTiTWAbdZFYqfMgo51Mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129901; c=relaxed/simple;
	bh=/UwhBHgPZUHC5SOBVgw2Ul6Ky0b8hYofUDAt6iQKca8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P5Zls0orrB1xrbUkR1/cHa3ZET8TtHR39gOYN3bLjNaXXw1+PqR+gWHXEo3UHZFAAQBQQZ8Z0FJKkIdVj8+e5Yf7QEgUFdyswrqMQvGPjIv+jYjFSq9+qKumGwqf1P1l3Ttaa+Ov5Eg1kffhMf8MV/pj4WCRzUk3JxI3JfudEbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P7weNVVc; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P7weNVVc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792129900; x=1823665900;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/UwhBHgPZUHC5SOBVgw2Ul6Ky0b8hYofUDAt6iQKca8=;
  b=P7weNVVcTmp30hV2vjsYT1tHTFH9OVZNGnxCOjJ1ov/H/97+6dvB0J0t
   GCwEh65lBDQTtB/y9Ez+ySNm7HUllmCxNnAW1N5HwbVI3mc23Ov9mtYoQ
   GM7MkexgFnOoo9X5qsdd0ras2a/Wk3W4ysDOYr+HFpsRYpWlkCFl+p73m
   zV2CV5HJLNB6khYl2H13wc4LCnRdvhVJTX5ug+iWFpWbotJjsxabQ/YQ5
   kcNpBsV2yhTzcQejf8ma/LrBC1sCY1gqHlOJXPtlZupwsBacs2HkxXXx3
   ZWiVRsOadrdUXYdYylawc1o4SFu4qK8msPLLONTHXRDgYE849h59Oy5FI
   g==;
X-CSE-ConnectionGUID: fcQyk23cRhORlBoeX3jayQ==
X-CSE-MsgGUID: 0FvhZSSOTcSBBywEYWhlBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="808276"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="808276"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 22:51:36 -0700
X-CSE-ConnectionGUID: i9Q5WlTPT/+JwGKZz+6mfQ==
X-CSE-MsgGUID: DWxhupqHQZqtNQCH7nIh+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="1762354"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 22:51:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 22:51:35 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 22:51:35 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.69) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 22:51:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbPCzTHVcgbShv9DK248GFjaZqNlYdch+RAjFWxm8wLBvqOQWudFHrLTxMRlz6iAEfE4CaDyxTefHkOYN9ROzJlcfR/4m5UUwci84snKi3J3LmqUnB2u41WLzAYG9aoYi7iftZkcxQzzEfQezwOswfR8FQFJV4Q3IJtPnF+l0qLuxw/v+wiTB4SM0BuZP13TBFXE6R8l0vH60X0J4fqx24e5pgIYTAV7P5j2gZ960Xk0etLLJ5MMQXMDSABED0sS04LPPW8o/csJvH9H3rbdNMMECkA2C9mlaKxK6yOjFy0DS+tjqUrtgWSLNCLNLwhmU7B54tLwYRMaCaGPABc+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i7JGxJ0sXsSYAcZ6Jrn6kBQZh/611G73umxUGVPUYug=;
 b=i9/WHEOesjkGFDVUCSHFandDvfsVhrDmPcQu2zAwEDLIOAvrQbW6JId1Xso9JF32uyjSiH+naAldui+B5+5fVo7caUvtVRLyDfCYglEqKjguWFYMUehv6JNNAr+qhfnnpjgqSjzbxD0om5QSZCwMl7eQoKcOLBjMHflqM8HW2kdA+zXflnI+oVhL4CbF02obpC8UBAx9CCQoYJ95TJRj1fgna8IaJg6RC6BZ7RMZvOlyXyBdn03VYX9WbPQOtsJ+xNh41Jcp1vaMH+B8M0CwRIu+6xTloYEDICIlZ4etReby0e4JTrVJZUd6uh70eEpwjn8Zg9pU9jvuytlAJM3PJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 CHAPR11MB9678.namprd11.prod.outlook.com (2603:10b6:610:2ff::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 05:51:32 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::3058:1480:e4ac:5765%3]) with mapi id 15.21.0496.021; Fri, 16 Oct 2026
 05:51:32 +0000
Date: Fri, 16 Oct 2026 13:38:29 +0800
From: Chen Yu <yu.c.chen@intel.com>
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
Subject: Re: [PATCH 0/4] sched/numa: Add per-process automatic NUMA balancing
 control
Message-ID: <atG4VXk4t-m8VubY@chenyu-dev>
References: <20260908122446.56708-1-lizhe.67@bytedance.com>
 <as3gQ8jfa_6eBf15@chenyu-dev>
 <CALOAHbBssx9ZHGwebGZCvzT4d_soyjNfZRj4L6gnxHRXtc7eMA@mail.gmail.com>
 <807eb0e80c76c3ccb85024b360bd47ace201931b.camel@linux.intel.com>
 <CALOAHbCt+iGGWMxzjrcRamdSqD48_v+V685-qi7_Qy7UL8bxxQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbCt+iGGWMxzjrcRamdSqD48_v+V685-qi7_Qy7UL8bxxQ@mail.gmail.com>
X-ClientProxiedBy: PUZP153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:301:c2::10) To DM4PR11MB6020.namprd11.prod.outlook.com
 (2603:10b6:8:61::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6020:EE_|CHAPR11MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: 812a0eda-f6fe-479d-e7b5-08df2b4987ba
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|6133799003|22082099003|18002099003|3023799007|10067099003|261009223027099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Jz5b/gG7TJWSD3eHlcjq05RD9NCzjIePluIaCenwukwn3zxppF5d3JsaTLCPtVE1wQOaeRjrPgaPU+tE1Q9SnXxGUbi126i4UqzJUn3S36McMWgJmqyfTH1IUtL5ee6S7r0zAJVOC9OhXwYIrCtYxUH6kpHVXRxxRCS84yrxDB2MnnJgz4wLHXllfUie6r85HZcUBw8EKyPzzYbLh40TNDsVsdtELEHbIE0NNyy7cVk/vMR7qM3wqImpshbLeXZXxDT+r41HcR+jmVLqyTyubpdiBZq504whYvgS5dwOT6qdg/ANWjwRWTRai7NFcRUezZXtB15l8ZhMOur/hT0nX+pMckrlPjC9pX09AA8d/lprIZRjSuykDAIErC8eQtt/9uN3C8QWaQtbOwf844wWIKrvW3TP5SjDgscTmdLAOFrL3Cm5YRh5TrdCDJ/GpkR1XEaqAiUtPNA95pJWkUdjxVW911AVXHjRZN0bd+Xs4JUcwjjTrrMsBknM8XFYsgpSmtWPaaVGfGm/9eQ5HjLZLZJkj24PJlEEO0pvPEMyKaAmBqGlnXhSKKgmTTqF2QLbjIX4/z8AXi7GEw9KjdPiciBjJh1NSk3BOuoL/4yXxB/KRkYrBvVoEGjQ+1le8OKHCb1gCF0QpnYILxXcXFXUjS+K6XTyZ//3NTV1RSISu6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(261009223027099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODhKaUkvQWdZNEsrUXZXbWNTaUFjQzlqOEZGVmh4aFFlOWd0SlgzN1VBeFFn?=
 =?utf-8?B?SjNDMjMvclE3WE5kcklsVzdIdXd2UnYvM0VaM1JrRCtySGRmUXRuUmM2Wk54?=
 =?utf-8?B?aSs5K2tKdjNEVHE5Z2ZZUGFPTWpQQWZhWW9iVUt6U3VQNmFYdFB5d2xDRmV0?=
 =?utf-8?B?RXBRTUdIYlc4OHBOdFRwcSszRmRtYWJGNW9MeitWSncxUmRTOG5WTVBoS25C?=
 =?utf-8?B?d3NmUUIyMnRRZ2VVdkt5NmdZZ21MVDlEaEZidisxNU8zYk8zanhHTW1XN2Mz?=
 =?utf-8?B?eWJSUWsrWTRwNDJvdTNoTmE1dkE5Z1RrK0tIK2toRUJ6QmlJTk9CNElTWFVw?=
 =?utf-8?B?ckk5ZXB1bjBmbFRyRkJiZFNHNGo2RjhqbnJPdE9lbFpObjg4V1pjUFZ2SVBo?=
 =?utf-8?B?SWxnakdmSXluVlVJT05tUGZTZUM5MDladWUveTdLWmFrNy85RzJ5K05RY003?=
 =?utf-8?B?L1EyaElWYTFXbGIzQlVybDZNdCtRSUQyNThrUkRUWXJIVkNLTVhOdHZpZjBh?=
 =?utf-8?B?OHc1VU8zdG80WEZQYUZrbDNIWHVRaHpJYXZ2c2orSlh1ZEU0SVVGbEZWdVBY?=
 =?utf-8?B?dzQ1NzZvRDFqWjU0cVJrazNJQko5RmlJYk83ZUI2Ti9wVzRZNEJjdHB4ZGx1?=
 =?utf-8?B?MC9YNmNzSXlrRG9DVkRibTFGKzNlc0VUaEZyWUlMTFdrQ0ZmOTUwaG8rMXNv?=
 =?utf-8?B?c3hQN1cwZXVBdDN4Y1FNc1FhZFVhTm9vRERuelFJa0RVTVFRRzEwcnlFRXJy?=
 =?utf-8?B?bnBtNGpNT0hZRkxoVWU3M0R4YWpWTmhuMXJDclc3S251ZC8vbDFCdmVSaDFN?=
 =?utf-8?B?K2RaeUs1WVUydTBISm5BK0VOTW44N3ZaQVhUSGJZdEptc0hoKzVIQW5QSjMz?=
 =?utf-8?B?YVhwb2lIa3UwOFBabHZPUU0vUVpMVWJZQ2NDR3gyeUpJdGpUQVJwdVIyQWFu?=
 =?utf-8?B?YnVCekNWVGhsT29PY2Y2SG1TT2QxK1pESWdCaytUSXdYZStCQ09yY2lvZyt4?=
 =?utf-8?B?MHI5S09YelFTTnhadW5zOHJhaHFVZjlYNE5DN2lnWm5MZHR3b3p6R1FiOWIv?=
 =?utf-8?B?SHNuWUI2bUxHV1FtT1ZlNXdMYUo1QjNiaEJvbnQ3V1VDeENOSi9ZcUpwVmNu?=
 =?utf-8?B?NUlYYUNkcmFLMGNsZ1J2eHMxd3dNMFBNeUpwOEUvWm9IcnpqU3lGMG1iU1Vy?=
 =?utf-8?B?QWhoV2NxRFdLSXYyT2o2bWRWZkNRQk9vQ0V6eVdxbmkrWC91N1kvRGY2RkJZ?=
 =?utf-8?B?cXlxZ0VNWCtyM3VTOVhDT25JNWZUYnVBdlNWQTMzalM4bUlWUXRBY0h1WUdB?=
 =?utf-8?B?RHA3eWx6aG5nZDFUTTQ3eWxTNTZvWERoYVdBMWdMd3IwUnlYc0dGVkZCcUpL?=
 =?utf-8?B?V2xHWjQ4QjNmMW1iT1FzTVQyVWFHOUwyQUpIaU5ya3VpNDJCTkNqV3RxZU9H?=
 =?utf-8?B?YnpqTmxUaWpkbTJ0Sjl3V1J4ZHFTd0ZLdUluVVZ1NHV0Y2QyTVN6aS9obkN2?=
 =?utf-8?B?NGxFUmZ4RmpxS2FoV21FK3o4RmF0RTJoT0hnamEycGtGRk9BVC80TFRsNVV2?=
 =?utf-8?B?cU1aT3dRUDYzaEJTekw5Q1RxNGYyTnZUWWZjZ0lrY1hJSkpZUkIzeWZUV29C?=
 =?utf-8?B?dXV4LzVWOXpFcjg3cGNSMTJzZFp6TGxRUm5ZaTdtTUNENmUyZUpPMEhUTWJT?=
 =?utf-8?B?VXNEb0NEK2tWVC9EWjZyZ29FcU1RTEdWTC94TFZhcTlZUmQySGVTUzlyWmRD?=
 =?utf-8?B?YlU5WFlHNkQ1RGFGQ1dUVnowTnBPYUNHWFRlaDRxOCs1aVFaYjd2cjBJL2hq?=
 =?utf-8?B?T25hZ1M2a2d2NmRQakQyYVhFYkh5aGJaZk1XcWtIOGFDZnd6OCtkNkZpNmZC?=
 =?utf-8?B?SHJ4bm5ycUdZaWRZaURVMXlpZXBRZEZqTnIvZkpBMUg2dmlNSFFpdVFJNmlK?=
 =?utf-8?B?NmJTT0ZCbjNXRDZucHZPSmx5Wm9GMXhTb056U0YxR05KWkw3U1l1akJUM0Jz?=
 =?utf-8?B?dHRERjB3MVFTKyswVGxmOUI3dG01ckN4Y3JUREphckN1WFRia1p1alVwL2My?=
 =?utf-8?B?Vlk4KzE0STk0R0E2bklmenkvdWVQdWJUeUZESTRKZmRkN3BXRmhUV1lPbDZV?=
 =?utf-8?B?WVZJZFJMTWNRQitQbkVtTXU2eWdPbjZVdEJVQ3laVnhoalBPNDZKZU5TSldG?=
 =?utf-8?B?SHVwYmo1Szdtc2JjRllxY3BlZlhQcnh3WDl1M0djYkl5VkpEWUVlcEhRcDZN?=
 =?utf-8?B?emdCand5QUhHNStIL0wrSytON2g0dEY3c3IremZwdk5nVnFEQ0Nua3hXTldV?=
 =?utf-8?B?NmJCWEJjeTk2Z1lIK0ZLUG1jbDdCcUtMZ0JoNjVSSHdkMHJnSkdpdz09?=
X-Exchange-RoutingPolicyChecked: cCPbQEiMtDH+JT2XVZtt6fp5yrP21vnMobe9jN8uMiKf0HE+LKdhoo1JKv8ccPV1AqI3B+HAXtBmcYsC5cOka5kdwLO7F2omm+8lo/dhUn9HkzRnwAH77opzMt1VqkC9EUnk+RBY9McKkhS+rXE229hrGNjzA+1na1GeSKlAmQJlBDNORB1HMrCnZyjIoSgroKACRjM/fpbVMFO5wh/Ivc5VxZBXFYmJ1YNsecAvpdni+aq5j8cp+31IGnzQeVWqaK/Fgr3Kme/PNDDEHUqpNPbgAtTkfG1JBbmiSW80bDb7ih9nwS2ZUyExmNzhivHtCS+FYmIto5GJ4Fz5pE6JpA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 812a0eda-f6fe-479d-e7b5-08df2b4987ba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 05:51:32.1990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PzUgBu4O2ORb5HLXhZ4rbzoPDTzva06N+vrXz2RAKt8cVh5Z4rDDcwC/oRgXufORP1UkU4PhYZfX0AeQKnUheA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR11MB9678
X-OriginatorOrg: intel.com

On Fri, Oct 16, 2026 at 10:53:43AM +0800, Yafang Shao wrote:
> On Fri, Oct 16, 2026 at 3:58 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> >
> > On Tue, 2026-10-13 at 17:31 +0800, Yafang Shao wrote:
> > > On Tue, Oct 13, 2026 at 3:52 PM Chen Yu <yu.c.chen@intel.com> wrote:
> > > >
> > > > On Tue, Sep 08, 2026 at 08:24:42PM +0800, Li Zhe wrote:
> > > > > Automatic NUMA balancing is controlled globally through the
> > > > > kernel.numa_balancing sysctl and can be influenced indirectly through
> > > > > memory policy. That works well as a system default, but it is too coarse
> > > > > for workloads where a launcher wants most processes to use the default
> > > > > policy while a selected process opts out because it already manages NUMA
> > > > > placement or cannot afford the sampling overhead.
> > > > >
> > > > > A recent per-cgroup proposal tried to address this by adding a
> > > > > cgroup-local enable knob plus a NUMA_BALANCING_CGROUP mode where
> > > > > balancing was disabled by default and then enabled for selected cgroups
> > > > > [1]. The discussion also noted that automatic NUMA balancing already
> > > > > operates at task/process granularity, that the knob is not a resource
> > > > > control attribute, and that task/process controls such as sched_setattr()
> > > > > or prctl() may be a better fit while cgroups and cpusets continue to
> > > > > describe workload grouping and placement domains.
> > > > >
> > > > > There is also prior art from 2023 prctl() proposals [2][3]. Those
> > > > > versions used a per-mm mode with disabled/enabled/default states, added
> > > > > NumaB_mode to /proc/<pid>/status, and changed the global static key
> > > > > handling so a per-process enable could override the global sysctl.
> > > > >
> > > > > This series takes a more conservative variant to preserve existing
> > > > > administrator and workload expectations. Keeping the global sysctl as a
> > > > > hard off switch means an administrator can still disable all automatic
> > > > > NUMA balancing activity with one knob. Using a weak two-state
> > > > > per-process opt-out/allow ABI avoids exposing a "default" state whose
> > > > > meaning depends on global policy and is therefore easy to misinterpret.
> > > > > Storing the configured mode in signal_struct gives the control explicit
> > > > > thread-group semantics and avoids making unrelated non-thread CLONE_VM
> > > > > users share the policy merely because they share an mm.
> > > > >
> > > > > The series implements a per-process interface: a thread group may use
> > > > > prctl() to set or get its configured automatic NUMA balancing mode. A
> > > > > process can opt out of new periodic NUMA scan scheduling and NUMA
> > > > > scheduler accounting, or opt back in. Existing hinting faults and queued
> > > > > work are allowed to drain naturally as the disabled state takes effect.
> > > > > When kernel.numa_balancing is 0, a process-local enable request does not
> > > > > override it.
> > > > >
> > > > > A separate task_struct scheduler snapshot is used by enqueue/dequeue
> > > > > accounting so the scheduler can consistently account the state that was
> > > > > in effect when a task entered the runqueue. This avoids changing
> > > > > historical task accounting while still allowing a process mode change to
> > > > > take effect through the normal dequeue/update/enqueue path.
> > > > >
> > > > > The series also exposes the process NUMA balancing mode in
> > > > > /proc/<pid>/status and documents the new prctl() ABI and its interaction
> > > > > with the global sysctl.
> > > > >
> > > >
> > > > Can the global key be extended to tri-state, like the THP settings?
> > >
> > > IIUC, a BPF-based THP policy is yet to be developed as prctl() doesn't
> > > fit some use cases, especially mTHP.
> > >
> > > > To keep it backward-compatible, echoing 0 and 1 remains the same effect.
> > > > The user can also echo always, advise, or never to it.
> > > > We have a similar proposal here for cache-aware scheduling[1]
> > >
> > > We are also experimenting with the LLC-aware scheduler on production
> > > servers, and we want to enable it per cgroup rather than globally
> > > there as well.  Given the lessons we have learned from THP, what
> > > about implementing it as a BPF-based feature from the beginning, so
> > > that the semantics can still change when new use cases show up?
> >
> > Some questions about per-cgroup based cache aware scheduling:
> >
> > 1) What should be done if you want to group specific processes in different cgroups?
> > It may not be desirable to put them together in the same cgroup for other reasons
> > like IO or memory resource policies.
> 
> Do you mean a multi-container pod? The policy can be applied at either
> the pod level or the container level.
> 
>               Pod            <- policy applied at the pod level
>           /              \
>   containerA  containerB   <- or at the container level
> 
> This is essentially a cgroup hierarchy: the pod is the parent cgroup
> and each container is a child cgroup, so policies (IO/memory) can be
> enforced at either level.
>

My understanding is that Tim was talking about a case where A and B do
not belong to the same parent (arbitrary hierarchy). Say, process T1, T2:
T1 belongs to cgroup A, T2 belongs to cgroup B, T1 has threads t1.1, t1.2,
T2 has threads t2.1, t2.2, and t1.1 and t2.1 want to be aggregated together
because they have shared data.

A more complex scenario is when cgroup A and cgroup B become threaded domains:

                         root
                        /    \
                       X      Y
                       |      |
                       A      B          A, B: threaded domains (thread roots)
                      / \    / \         separate memory.max / io.max
                    A1   A2 B1  B2       threaded cgroups
                    ^        ^
                    |        |
                    +--------+
                  want to share one cache group

In the above case, we might need to change the deployed cgroup hierarchy.

Suppose threads in A1 and threads in A2 belong to the same process Pa,
this reminds me of the cgroup bpf NUMA balancing case: after enabling
NUMA balancing for A1 but not setting it for A2, what would be the final
NUMA balancing decision for process Pa, is it enabled or disabled?
The NUMA balancing scan/invalid seems to be per process, so if we change
the setting of its threads, the whole process will be impacted. Or maybe
we should not enable NUMA balancing for threaded cgroups? Anyway I haven't
digged into your cgroup bpf patch set yet, let me try to look at it.

> >
> > 2) What is the inheritance rule for cache grouping of tasks in a cgroup
> > with child cgroups?
> > There may be too many tasks in parent to try to fit them all in a LLC when
> > there are only certain subset of tasks sharing data that should be grouped
> > together cache wise.
> 
> Generally, a cgroup contains only a single main process in most use
> cases. If multiple tasks have to share a cgroup, they are either
> identical tasks or tasks with different priorities — in which case you
> only need to focus on the high-priority ones. That's how it works in
> practice.
>

IIUC, what Tim mentioned is about the inheritance relationship: if cgroup A
has cache-aware enabled, will all its child cgroups enable cache-aware
recursively? (I think the answer is yes, while for NUMA balancing it depends.)

> >
> > With prctl, we can be precise in grouping only tasks that we truly
> > want to be together.  If we want to bunch tasks in a cgroup cache wise,
> > it is easy to write a daemon to put tasks in a cgroup into the same
> > cache group.
> 
> I'm not a big fan of the prctl() approach in practice. Deploying a
> policy that way requires coordinating with other teams, and the policy
> may well need to be adjusted later — every adjustment would mean
> asking another team to make changes, which is a painful round-trip.
> With BPF, on the other hand, all the work stays within the kernel
> team, and it's completely transparent to users.
>

I agree that prctl has limitations, but it provides fine-grained control
per task/thread. Besides, there might also be other users that do not
deploy cgroups, so in such use cases, per-task settings like prctl or
sched_setattr() could be another choice. For example, the schedqos tool
in Google's usecase, and DeepSeek's reinforcement learning infra[1], have
leveraged prctl to deploy core-scheduling to avoid noisy neighbours. That
is to say, I don't think the cgroup-based BPF interface and prctl/sched_setattr
are mutually exclusive, they can be complementary to each other, IMO.

thanks,
Chenyu
