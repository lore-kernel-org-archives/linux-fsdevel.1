Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795455242;
	b=kpCxZJtmQHtLGW7+3cRRrxZeSRotZnLplVKWZToIny1gBBpjWk00em36O/SXESBx13Tf
	 3TTe3vu5cd9I3quS3WibJNqRaZKzw/gRrVwLvPWlKBNMTzMiUpvkcM2i3xfoszKNf7JpT
	 ADaeA8iibDWXC6xbHWIufQxlJH1jgJIQvewO2fjeyVB4C2FCKyAn7tW7aNuJ9t1RCsY3d
	 ex7cp4oh4yLz2NRXO1/b9yufmZrn4QC3vLEG72x6WGsUNl3RpLat40D32jN7TW9lbcwws
	 o3gG2hkKQiOYgzTwNhsBT4T7HRRx4npQRs+jyYPQMuS+ltt0kqJImLQRNNql7JryR4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455242;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Message-ID:In-Reply-To:References:Content-Type:
	 X-MS-Reactions:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=32ZbtV+0Y05rKT2mVG5RzLg9mrWrgSP0r8A+lptjy94=;
	b=jZg+W28ZUmfrHV2nDeymUJradHU82VRoiRRCyG26tpgs/Q2LZ5WwIrkCl+GL8Oww0r6i
	 EQzVkNWy6bTff7KURt4kCP7tdp+E8GiDwbuP+/Sc4TTwbMkWzv1Hfqy+aiscrDMce8Xp/
	 X/mENlhLYIxfwPJ62/AtmTizh4WAaQ+nLnCzNUhf1fmyQM+THCOE5AFiuKkj2waPP2l79
	 601a/M5FL+GUd3Xk1s82zHJyGKHe+pd4BPbWnNulGpe4GVlk6+lvXb/QfjbX3kxPeD6z8
	 vsOOv4KHVcahZEdwWTIl0YslNGSNSBVVuJWs+pBTYZS+3Vp2NVe7iKJvNqoSRuqy9wg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=A4PDlRCy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.9
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF22606A31A;
	Mon, 23 Nov 2026 17:34:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCF22606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=A4PDlRCy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTcG51FD0Fqhsl/QgVBHtGGyhe0Bn5+D5CMFIcESDKJK95ERnLsfRbBbyqv2hU0zV07JV6G6CV9Kl6hxLrPw8s0cM5lO+XBusQOwZaaEWvNrYYElqi51S8x1+L/xkSX0r5yap+/WTD61cUQQGbqVNbebhlMML2jH6jagUm9b4aoYyrwwn+Onbr167aQH0MO7WZTzZhNmI/kku/bpCDPuS23F8IBCBQuBgwQQVCsRh1ZcJG8hthLnTL2drbtkB2OEY/wDIHu5puKVjpZFSkf2K1HJ1mcAGuMZo7+TFgVbV2mVvmStgEgcX9GBekPg8TTl3hZqzZh4ZGStCMAwuSD9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32ZbtV+0Y05rKT2mVG5RzLg9mrWrgSP0r8A+lptjy94=;
 b=oYnXSnMQVpsYzWyeyl8fYF4dMSZUlfEkUAOKU/99u8JQQVGJRszZOUKXPoZxBNfvvRAuNv+jayp8A579AYq+vhx/6ZOiawxU6csBA5PuDRToOV5UNV4VkXxVJf20F97Aw4ScsChMfh/SBZ5wKL5I8Ok7XU1c4SvNRIl4j+qTml+oaooJjVCfWo+ZeamhDlCKDxr/nh6poQtLxuTZS3D1sRHoeNGVM2NaJpxWRPYLO0gdpYO1Ml4wZY4blN6VKzsLMswRLRUcM1P7LqNA6BZmYViIzX2+aiCz3FJmOTbiHoRMoN0IUxKj6WzkvNZ3EPNfLmLn/rb+ySHyMaqvrOg1/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32ZbtV+0Y05rKT2mVG5RzLg9mrWrgSP0r8A+lptjy94=;
 b=A4PDlRCydA3SWJG9KsdtkIdLOc7kpxOg0/d9vOthlflXNAOW9KeuiMXm7TrXha859tOl5DW5jhfr8aIm6sEv3RhDZa4gOyApW8kDma5II/CiX2UvRk/zVeCBX98x7ZAgQ8Op3/obwtQcBKMxYgcsFxBOTcxorlVoS7vG5HS9PgdwBr60GQ8NGXE18gf2D8noY1oYv5GDlbLHLziRsbudmHOKmANS98+Wwy2ESUZL0BulhxfUJQVT57nSrO0CSOKs5AV3UUKsVXVoqr2drYiT1UZyPG7BVILJ5gLs3wBr2jHFer/XE1/ubf6X4RY+s1h08qsJodOBCxAXqAMU04Ff4Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 17:33:56 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 17:33:55 +0000
From: Zi Yan <ziy@nvidia.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
 byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com,
 joshua.hahnjy@gmail.com, liam@infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org,
 matthew.brost@intel.com, mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org,
 surenb@google.com, vbabka@kernel.org, ying.huang@linux.alibaba.com,
 kas@kernel.org, hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 kernel-team@meta.com, baolin.wang@linux.alibaba.com,
 Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, dev.jain@arm.com,
 baohua@kernel.org, lance.yang@linux.dev
Subject: Re: [PATCH v3 3/5] fs/proc/task_mmu: read the PMD once in
 smaps_pmd_entry()
Date: Mon, 23 Nov 2026 12:33:53 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <DEFCBDD1-3E3F-44AC-8746-9B65779AECD5@nvidia.com>
In-Reply-To: <20261123163301.1568240-4-usama.arif@linux.dev>
References: <20261123163301.1568240-1-usama.arif@linux.dev>
 <20261123163301.1568240-4-usama.arif@linux.dev>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: MN2PR01CA0057.prod.exchangelabs.com (2603:10b6:208:23f::26)
 To IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CYXPR12MB9386:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3913a9-41a1-42dc-a2ef-08df4987f2fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|261021123027099003|261021121427099003|261026121527099003|261102123227099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	87qik0Mvzub5flElP9oUx3h774/8alwWz8B1iZhRBOJTolvp3HAx6xSOpugHJjFQdD8sWi6vab4scoPCcXeB3ZIlfSLE7ePflN1o9BQycULRcMj5S3Y9XzOSKRmffZcWjU2b/6/1ElxVIFeQ4KDcQWo1sIB582uf8BjpuoY2NGWvmPdMb00AjM8e3OtOMW+/ZCttz4h1TSEFJtfhW/oaWrHaHktunIVQBm8mS2q/viqx6czC/luGbgf4lpaCiUZ1tctLOO6QDTWiBpVKdY7pDsB8xgF6rSQUE5Id49isILdMmFGTizgIC1y9ciVfERaIWYsoqqq1fycO1eMNtVDBZp9zvAfASIlHlXwS2n2Dq4zcDIBsZ9FFwJGpPeeTo1tV4nv3dA+QClvFI9AI1fLoWbK6sZ9UazDZNKWE/R2t2/jtY64DoYlqW44vY1Up1f4AbcbAdGlGReSHY43Z9bvq7US670V6/LjXW6u69xJk1cUtCHQXd8n8lHYI3v0pQLWW4cHKTFAtmnwF1LazGO/JH5AcQ2qKhV+dZ7ldzZxi14YtBP/01iCRimiBGU7aNYKK6KXh/LnFyZ+ZOSx38AVub5ktfXQ4QSgPNTSnT88fUC3QRt8mpoGsih11w7K0kZR0jdGoRvkADEt+T9GI9ZYaxF/if/6qnsecQuAoRS254QA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(261021123027099003)(261021121427099003)(261026121527099003)(261102123227099003)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wDo//NHhKmNmg2gIxDE/nsYM1/g0fTxFVOW8N2lDXf3efY+0Xhjpe5CiRi/o?=
 =?us-ascii?Q?VwhW6/EYeOJrS9pK5sx8uxSGvCMRd4yQ9D+XYy+BKu61ZwxXdIidm+KVYfdq?=
 =?us-ascii?Q?MHawgiwM1xuNUr+cqqFjZNPLG7g9OuVhWLBb2GD3/t+tvbWCEF5bT8oiXDqI?=
 =?us-ascii?Q?6ywr2bxkj8o6Jb64tsj3uFc+WGhL9vSHUjLiqZeo+X1a8xm2c36ncJ7q0ROK?=
 =?us-ascii?Q?nDSF8k5xOOwIt9FWnMdg8z0R29Y8vOCtMAurxvfVW3rTc0vXI8jA6sx1ffEO?=
 =?us-ascii?Q?YCGIV7J5Fuu+eqsiNEUKPxeKWVHDnntPvxPofrjVQ01K5CqN8lLSZhhP7hZA?=
 =?us-ascii?Q?ZsTWEzkmfB0QASUXV41Vi9fPeBLoLWChXuUcUlbCTWjcqga0HBzEPpHOD4aV?=
 =?us-ascii?Q?16WXHv/NXeYZ76h3HP2iglhvsA2ELMAqvoCixJzQZ77NI4j4LHo8PX3ZJlkq?=
 =?us-ascii?Q?DPiysrrSco5NT+afCVLuFFk4Tfim86fQg07giUuSDZFAUMCUhUzMMBIL330w?=
 =?us-ascii?Q?NmmDDO9+wseRJxpVIcOBJOVMQUhK3SZ67jn3Y0jVQyLUPINysn6wDULhueqB?=
 =?us-ascii?Q?InXLxF944fd7ruEBlW0D+xFKDBnQvfjzrsCNsJeY1mTKNOShQHXGgF1IERPX?=
 =?us-ascii?Q?XcNTOHY8+LPQeA+r5RZgO1yHbfe5TMjHMnMQX/g/7o1ywU5/30B9+k8WBabl?=
 =?us-ascii?Q?7kfgbteB13rbNq0pBlMW5Cd/Rd3ysJCe5o9X/CBELHqG9X4rfUKNHUFPiSxw?=
 =?us-ascii?Q?2jGcG0+k7HnYHlbYFOdEVv7fA1YbWqORoIskVTlF3WZnCn8vmDqfPggidGus?=
 =?us-ascii?Q?xwg0t40jDid5+3rqKoZX7GAiFPQjnCFH3Qh/X/fPNyvarbrElIgk78HrcBcT?=
 =?us-ascii?Q?rW7/iC76zk15ZqA/nnELdy9GVERVYWZBwL2kPWB0ne4tQ3SCRdCj0g/aXf5D?=
 =?us-ascii?Q?PVn914BdiGhdao6pWSQylDSOQmi6tg6M75hGxrqwqSnPVNcBSpw3RwypUI8C?=
 =?us-ascii?Q?AW5poBqFHKc3HTokg6tXBMJZzjWdjw03jWPl6bUqyK14ijD/Ab26ltxIzZIU?=
 =?us-ascii?Q?Z7GtWJ65ZD2pu4nB/vOE3HUeFS8PURdhTXtjNO0GGIS5JCDdsS8zyzynQ5JH?=
 =?us-ascii?Q?4K5US5t9KHA08mPLghrlX2RWFGOeXVwllaXKg6DYRr9B2nf8HP8sjlyQ+ycr?=
 =?us-ascii?Q?I20hnw1KhPC/ydXzWaVUBzjeYqTRgmJBk+FYZ+wxioytYAAsjYr4OVlvtc8T?=
 =?us-ascii?Q?Gog+59bR3cxWEzjC867GJXfEK9rWhgLeqnvcubFZyVnYT10ake6E02Av0/JK?=
 =?us-ascii?Q?iXspQclHYMSbjHiKfb4fdPpUL/CSkNxZ43Os1gZqU7m4GakYCigjQQF4i7Lo?=
 =?us-ascii?Q?UYtGbZ5HnocBIrIKQvi+BCrBiW4H0CUwxbxVq3B6k+h1e7t20WGklrvpKaBS?=
 =?us-ascii?Q?0MYLUpdB4NadN6GPEO3JC+dL3Re+tfr3zfE4pp1MavZUGcLuICiBdoK1T/3R?=
 =?us-ascii?Q?PnU8NWlQOlCU2ZcdLLXL/Xe/WaUbiESTRXPm8kGPTeap5k6rgCjxe5LnCgZz?=
 =?us-ascii?Q?Rgm7xRCtK3oW7uXBfhoQV60YcFejAchW0Xo0OcbKMFqVTV8uvJX5MEW/Fbqt?=
 =?us-ascii?Q?XX9f9FYCb92t7MBFG4foJTgeuXOIr6iWKC/PAfOE9rRVkirLbmmIfPkH4RbK?=
 =?us-ascii?Q?xIG83vNanxWFHDW4dA0+WPD+/vSM6ANfYaRtOISC+JxWIf0E?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3913a9-41a1-42dc-a2ef-08df4987f2fd
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 17:33:55.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYK/yBrc1HV3BVuv/CRZtbiMkqI4o8nMFXnojy/jzKIvdyysdKFwmx6PZpry6GF5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9386

On 23 Nov 2026, at 11:32, Usama Arif wrote:

> smaps_pmd_entry() dereferences the pmd pointer six times. Read it once
> into a local with pmdp_get(), the way smaps_pte_entry() already does
> with ptep_get(), so that every test sees the same value.
>
> No functional change intended.
>
> Suggested-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  fs/proc/task_mmu.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
Makes sense.

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
