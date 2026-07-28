Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEA7175A6C
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 02:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785205400; cv=fail; b=AxEZ6uy7CMxcK3YCcv/e7pqZlycKowkIXNb/OGosE6lozRgW31aMQ+xzj5e2uA2UDtRrVZ80uM8mHUuMqPVCRFLNu3QCUbmfgKI7jWFs3SGixDdOq0S9QKbawxf+/tN3oRVjSEhhR/iuTXrcsleINlb0m+anAFgQc3RTIRkol9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785205400; c=relaxed/simple;
	bh=KrM4YQyyTFh3+iTMJwae8IMG6gxcbJFDv5ows/tqf6g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ItYPnXyTP9cgo43cbihUErGQaKG6X+umOS4QMxiA5Us5U1QwJUu4m0APJQRtvsefQFJNIX5HKH5jauzRE9gdZfRgyRQkpnQHOVhbP3z8L1xNIZeSu4fAPOJzcRRQMvk7MlO02h+gUwk6ZlJzzG1Am0cb5M8g/bzwiwHxyKq2dzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SIonj9Po; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SIonj9Po"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785205399; x=1816741399;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KrM4YQyyTFh3+iTMJwae8IMG6gxcbJFDv5ows/tqf6g=;
  b=SIonj9PoHHh6ZedJXi8z/UhRcuD1RCLy0bHVwQyZ6LTKTB+Uyp7SzhTQ
   f4QiYXZlPorSxmEkefOHZJIHW0uDA0G8WmXzHoreIplr3ossNSb8bGoCJ
   HjLBM4wECb9sg/9eC7ptpojVf+JvT3dul5SXEFAI2zhC7kskBNLI5jdDl
   12lZcKzavk+whAJXsOYSlKRSiUEqPoqOAHhXifjahjHpJ/eD1pYqf5i3w
   kdGzzs8gPXFC5IJ43QgjQ30AdgWLPEseTcBr7eP0nPsd6uyTIBx9x6nS3
   5SDFSMt1jH1HI6cwRSHPYCC/TH6YgjZtzah2vJCebX7+kyNLbSprqYHiX
   A==;
X-CSE-ConnectionGUID: EYTm8GY2SLW6mRLJT/jq8w==
X-CSE-MsgGUID: ZG54QOJpQeC8XSxSUfLVJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="103324568"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="103324568"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 19:23:13 -0700
X-CSE-ConnectionGUID: 2uEWrVhUTlCcnc3Oipb/SQ==
X-CSE-MsgGUID: tWSFGdFWSbqApsB+11V7WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="284110316"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 19:23:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 19:23:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 19:23:10 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 19:23:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOuCOSQaRms1J8PYkAccrsmlqiwhLI+sTswyMh4JI3EeoG3rQcu6pFWt0mG1iRZyL/EqvwMEIsEP3p+f6yrZqNSqb9vm4Nyj86a4fD5+7a4OUzLYm2SkziB/u+k7aQJxmxMXGxwHPiGPSwVQIquE/DdjQYe5aqtlNkiESZ6zKUy0sRhw/gUtAw9pB3fRG78YVC3Hm/+rDTpRaRmG97sM5kQUVTEz0KZv1H03IbVwTy5SDEs7W69AwyMxCF60aeISAG5Sj0hNVCjCoKrbSVlXlFyXoZsoYhZyCjiEk6zddNvXjLgJCSTxyqANaGuj57bYH1FUzrTY2I2xaRtQiydGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7+L9FYtHq69D0O93ErSC0nPh6F8s0pGmtsamdXFd7U=;
 b=Zn2Cl+wcBaY2nJSzetxrs0XFkaqywoowuVrOffsNu8WIh5Yr3MjEF4oah029H+/MHh6Xc5IyJeorvVUDJ8ra0EazzGfMKdzcyrw+4Sn0m2x1Y/Jr+o3V7RkqpvT8QXhPoLAqWYbE+U4BWovWY2Y9mx9hu2eLnFzmsiOdtqcXuD6wT2Egykd4eZAF5iuhghin4h0vkQX3o3Sb2314RnZMQgbrfaw38mKf+Q1IO3/UTqIYbCvtM6lP3ByEpLfdA3ACPyo4JWduDXMy4fFW7zwrFUJcpEG+HJF6/XtQx0GWTJUEZe+pnQCxQNRyIG7UglTbZxC2/LrDSDseYLLl7G43Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by MW3PR11MB4650.namprd11.prod.outlook.com (2603:10b6:303:54::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 02:23:07 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 02:23:07 +0000
Date: Tue, 28 Jul 2026 10:22:56 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Bo Zhang <zhangbo0325@gmail.com>
CC: <jack@suse.cz>, <akpm@linux-foundation.org>, <david@kernel.org>,
	<fmayle@google.com>, <kaleshsingh@google.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>, <ljs@kernel.org>,
	<lkp@intel.com>, <oe-lkp@lists.linux.dev>, <surenb@google.com>,
	<willy@infradead.org>, <baohua@kernel.org>, "oliver.sang@intel.com Bo Zhang"
	<zhangbo56@xiaomi.com>
Subject: Re: [linux-next:master] [mm] 7b32f64bc5:
 pts.svt-av1.Preset13.Bosphorus4K.frames_per_second 45.8% regression
Message-ID: <amgSgM5FlCK7QMFB@xsang-OptiPlex-9020>
References: <ama/sQIK2O0MphL1@xsang-OptiPlex-9020>
 <20260727042022.3503727-1-zhangbo56@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260727042022.3503727-1-zhangbo56@xiaomi.com>
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|MW3PR11MB4650:EE_
X-MS-Office365-Filtering-Correlation-Id: a8db8854-2695-419a-7cc5-08deec4f2926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 990e2hBdFMV/wOLMTM2TD6JiLoNC5+4OPXq6UdpGP7rElSH4nTy1/x4J74HulZw5qxuSjBEJCBDNAZ9wUVuh6JdLA78GrQvZb2HxiOPpbkOV4yA7G1gkvur8CQ7sDoZkuaeVPGlx6DmCkHC3/Joh5HyX6vgNHGOuh8tJHO9yg/B4EjNNja20R90hJYH+K+xCcbrYewH3HGPFWVsz1BBRlBCgJFkWgHLw9ORcmg148oXoWhuZrqzS7hKdU3q8U7M/u6jJ1h6X9Y1NjkPnFKRXH7n/HPFL0fN+s2TiyUsctkiicrImjq1d7NkzeKNFQajE7WBjGPQILRH0mlAm9qhQLfRunbXIyPZ81ty7mx0S3SkY7KVgTT5UAlP5Ahi9DH2icq/zCdIUQFaND0SapPsnL9gndMd8TCVGdQA0V6ZXCbzQwvZwByGiQVxYqfcRYezgrKE4FlzShBd9gIOV+meD+8AmesmyADI9ErhShfUZKFQlAhZzK5cUAF7XS349uVJ7lyjLP+ew6ux8NZlfg2qtyk6MSt+6CGJo97+UZWoASoEjT+jemLpyJX0XQh56LCFcXkgZYF/ewF32fbbkkI3y8vEHVI+yKa86kQu5Azhgj7o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q0G64y9nY82PUCgoWyGxFnKKOD4c+uKOAwUyDWdprKlMflRNnjU3qLlzmwDy?=
 =?us-ascii?Q?FQ6tApbTPAC90JIeq9fDqH+g8ynX52/VSFBrQpeJnOF4KVPVOSxksjXxjE1g?=
 =?us-ascii?Q?YSteGdLO4l2sSr2X6zDpKyfmRM+pjGgJVwNcXtwk6kyqqOadKXIIFFpXQmhn?=
 =?us-ascii?Q?xfaXTznCD6CpRs3FdTJN2dlZXLt5//LnLWyIL2Z2518SWD9rKjpv7lsOtmL8?=
 =?us-ascii?Q?6kUpcADYVFiH7w9pzj4SmvtLJlfKegTvecVTSOWhIEigKT1JW6XgINVM1L3B?=
 =?us-ascii?Q?VKWMP1vYD8N4JBSupTKC5rlBgLIYUclMnN343nB0VjQQlrZnvmMHEHvjERJl?=
 =?us-ascii?Q?0LGuDjCGqE8HNnBvCLsH+ClaJ+SLlVUUJ55GZJX9heIJhLGW7LtuGy6p7iQF?=
 =?us-ascii?Q?633zmpjcQIbgkZzraQpQfC5baH188Q2nPpFjT+FAEiHLtBl2H7xb6Efuunao?=
 =?us-ascii?Q?KcYoTXvb+KuJOliIYj/MlsEs4mHanHeo99/TIc+ls5XXrfu2ww/jhJg/e1EJ?=
 =?us-ascii?Q?hMlLhSj5CItD2G+JjjRJEhrc+MxTpNoqtz3t7lrqOfy0HZ22M0RvByEi0XJ+?=
 =?us-ascii?Q?eFHA9RQut0RCSaOJPrDu/MQE6nbMAM++zoS9H8cxg91Rpf+IGPGtS/dFS0YI?=
 =?us-ascii?Q?BgGlU3upB+dFYhQbVZIG1Dv0hW+vULIJIWS/fbh0zXBHKm3mnBw87gtZ8Jlh?=
 =?us-ascii?Q?Yy6YdElYoNbfuLssKjX03ixeDuug4EQoGB+d/BAW+GkVMjRNl8iWdPMwyejv?=
 =?us-ascii?Q?3zDfHfitwIOByN/pNMrVJJztYFNmCaUsUlwI5CsUCfELunuIr5esbEDi+25o?=
 =?us-ascii?Q?Jw85c57GprtczSLau35zONASyX7R03r7JnPCPwLv4L4Alp7Udjg+W1srKA/8?=
 =?us-ascii?Q?lYj3gDsnVYavULl+azbe7cljnumDQz4XbFvCCW6iOThpadmVDJWZfXGbCvPL?=
 =?us-ascii?Q?JV4DrMXVKT8D3Qj/W0FlXHBMCdYs78sRecIlEn0SYYghaNPwSfe3fgp/JNir?=
 =?us-ascii?Q?HtsGW4J/KwOELWaWAcMlOR4uVCaSoGpZC4RZI5g/xSJTEKa37EKgi5U/jcRj?=
 =?us-ascii?Q?XNDtZgy7ErSN2mKUg+ndO7vdvhdoGH02qizg+THi7QhNGpRW8EAqreyWZz/R?=
 =?us-ascii?Q?2UGxmz7wGuzVqX/fYIt8yv89+oG1jZPItSRfbxMNZoDkQCI6tH58JCEnX0A0?=
 =?us-ascii?Q?cSvsky5wU1mH0ixFoFcviVbIswusv9XWBRP6N0eAsrpuaq9bCsDtXswW/tUI?=
 =?us-ascii?Q?u4ASmCoZoNe6Na6mS7sidlDlHR6yyFgnGGcM7paUGJ6sIHIfBwVPVaaspIxc?=
 =?us-ascii?Q?8RpTLYzlV/Zd6CXxwA+ky3DGMioO3dqdNQhy8pGkofon84MIH6SVDwCjXfXG?=
 =?us-ascii?Q?wrbTXIOBWftpItYwKXrZq8v9JuHkHeyCNIquq2Ijb1Si3YymKxFYm1hVBxTv?=
 =?us-ascii?Q?4AnHBsjQyM/tOUPJIJJ67Jl6ytHP6XMZx5f7vqJzKLGyjorxstNV1c8RVM2t?=
 =?us-ascii?Q?4o2JDQ9YnTy+O5TsS/l+nKe55j2rJLOW8Voj4K9BZehFJP6WYO+9cNyFLcso?=
 =?us-ascii?Q?Ao0xoSKtXWc7kr7kMWwleD58fuOJvRnKJ4U2dHBXeGb+AbPJ7apjH4uLnSbU?=
 =?us-ascii?Q?vKxRhL9xSYB877+RjgWwY914zmM7I6NW95q3GE8pGR7dXSZSQSUpoZzK1oPq?=
 =?us-ascii?Q?9r7z6saNGc9VALKQfQuxyKoYJ96RY15xPszv73+s+YQpD4KNa5JxggtDr9bN?=
 =?us-ascii?Q?jXoHdP7FAQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: HyLMNt+rT+qrAhbGbpYlCkNj4GtXG7kIDwlZJWynA2b9dd1A01u35qhEcK/LiLyuQRF/VAQekODaoOtJuhwOUwnz8z7XWqugn9VKnb+Yx+YMLlPMA3lIRPfakPhqGfT60Gi5ntBImA3p57hadouIuRil9Hu4ncOAkJByIj2hAZLDzBx8IEjwqV7H40ntKDDJunoh6EesfFTGnhILqMbPBYY9vmOfR+ElSGolDXbxvCl2c/KpjgDsgVc0k44L4QIXyRUM1F094etVbtZvNplK3oDlGpEn7q//9hIT0kbLSqaAPSisWznGJI4BT4RY2LaaPRergw09+0QMEO9uv9KHnw==
X-MS-Exchange-CrossTenant-Network-Message-Id: a8db8854-2695-419a-7cc5-08deec4f2926
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 02:23:07.1826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NQPU1nfr7uinedBLORFXIFxUkNOW6luABwU8CP1qCBQt6Di3rKeOQU5l6fcbb5Y9X39fjxH21l3eIHjlhbhEBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4650
X-OriginatorOrg: intel.com

hi, Bo,

On Mon, Jul 27, 2026 at 12:20:22PM +0800, Bo Zhang wrote:
> On Mon, Jul 27, 2026 at 10:17:21AM +0800, Oliver Sang wrote:
> > quite sorry that we lost the machine we reported this regression, and since
> > pts running need some specific settings in our test framework, we still need
> > some time to setup on other test machines, we cannot start the test soon. will
> > keep you updated.
> 
> Hi Oliver,
> 
> No worries at all, take your time.
> 
> I should mention that my patch may not fully fix the regression reported
> here. It is just based on my analysis of the code path, but I haven't been
> able to reproduce the exact SVT-AV1 workload.
> 
> To better understand the issue, would you please share some information
> about the memory access pattern of the pts.svt-av1 test case? For example:

unfortunately, we just simply integrate "Phoronix Test Suite" [1] into our
test framework, and for now we still keep on 9.4.1 version [2] since we don't
have enough bandwidth to do upgrade recently. and for svt-av1, we now use
2.11.1 version [3]. we don't have enough knowledge to dig deep for your
questions. sorry about this.

[1] http://www.phoronix-test-suite.com/
[2] http://phoronix-test-suite.com/releases/phoronix-test-suite-9.4.1.tar.gz
[3] https://github.com/phoronix-test-suite/phoronix-test-suite/tree/master/ob-cache/test-profiles/pts/svt-av1-2.11.1
> 
>   - Does SVT-AV1 mmap the input video file, or use read()?
>   - If mmap'd, are there multiple VMAs over the same file
>     (e.g., from mprotect or partial mappings)?
>   - What is the typical VMA size relative to the file size?
>   - Is the access pattern sequential, random, or a mix?
> 
> This would help us understand whether the regression comes from the
> async readahead blocking I described in my reply to Frederick, or from
> a different interaction with _max_index.
> 
> Thanks,
> Bo
