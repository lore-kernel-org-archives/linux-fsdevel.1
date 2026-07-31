Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F8031691A;
	Fri, 31 Jul 2026 02:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464306; cv=fail; b=NRN0yNCb0LCHgM3dk6o3Qm6qQEXZKKD8qrleF8HyA/ZhhljW3meR2eJtv8OE6fMu6a6bSEL3ADKCkPUqQPtl78zaDgQmEHmICPgJwW/QVInSDECbYPsuAhn1kUwarr9ws0rgJ1cURyasLTSiijnnFchlgV9jjfCIPwl2wXwj16w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464306; c=relaxed/simple;
	bh=ry77rvWM9GIUxG4jvnGxQ5EDooZEs1mkI0xoyDNeMBw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=rbGq56ZI1Po9s4CBu3XmY4pa/2AKWM+Q93cF/g0oWZSEVKq+/ZXx3pVXkoDdJRHM2rDartRZRUVTVpUBcIDLkc224YO/GBxnahPzNbnLuQ9Vr/Cfq53T6+xL/eXosaN0bWXtjo3BsuRUoN1wr9vW8z8LrCumTgYlsu20tTTjRxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mZxmaR9i; arc=fail smtp.client-ip=52.101.62.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mZxmaR9i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rON6dWSzaTqBJoI2hUBhvSTMPXxbmlEsGPSpWhSjsZj3aimiWDI4R8SzXRcdM/nxXVy3a+JJI10gyKL5xvozBFRnK9jBQNIRqirBuM8mRYvGtebv2PbmhzoE5xJ37lQivgugkXLVRP5Y3Xf0MTxdnVjO1pU7zHs7aXHinNSicJQBZybbw5Ce8H0bZBJ8qxrtmqc2vlUHQkZTu7ATfey6ZexKAga5DCNikNP++TlwnToZgOJeqBAwRVVXUSmQc2BTUBvU7XLPCXyaTEnFDAVUHFY6Cps7MT/mcsMimx7kjjjR0KNQ7yKhwqDiFNEowW8l+DdJclR8LeSZ8c4NB4NJmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PphJ9NepE2VwN79ksdoDYu/VU/jNjvkCl1RnbBQrGj0=;
 b=wJ024KLCMGuXHKP8dZeb88FC5fSRJshhe6LoHoCrRZZr9MZiIgks7TAGKTQJcVpEZMck7zpktVKg/ebvdsdKnG7vCeseyemMHML4LkZzq94DDgxIFg6SZgFKq2zo99If2StzkorNM7sBEbY4ZfBbiTkP6rCLOBF7PPtiIAcvv91U6Qyqjg1xW9YgHBZs/Gn+6SjOIygXyb9jzddpW4OBwF/Pb9L7rJyR0pJPt6c4wVKOGEJETV2vEIMyDALYBfiLPOLNES7MmopO+qvLQsPYalIujJ2tXoTfUBoopfksQim7hZ2bEJEC+gG74Kz0Dq26E5l51a8ctG7GTYsCCoqauQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PphJ9NepE2VwN79ksdoDYu/VU/jNjvkCl1RnbBQrGj0=;
 b=mZxmaR9i0F3nN0yLkOkR4d7ze5YugjitGVpuJcChwgR5tUY7ALjYVLRRezNPUM2lUkoQBx4NpAiiU1FLZKOmyG1xnnr0tSg+ywgEKr7OTrSjLwnjuxUsXQNwUJU8OyYiL70nU8ClzYxJcfm9e26oTO0ZLc3OlaVqwRmGmAuyoC+RPtUJi56YHwstnOZyIgVjmXFF6ZJKfoWOc4oWU5i3kfb6CCKmAb01ZIySeUIj+XJ4jzppx/w5jvNVrIEqU2yNtgrH1D7oG+2njuKfRlBWkxZvSvxnr0Ud21VDK3PtzAgjb7b3ejTmNIIMsnSFkFGSi2eukmennj0Q72HQ9D9ybQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 02:18:17 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 02:18:17 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Thu, 30 Jul 2026 22:18:01 -0400
Subject: [PATCH v2 2/2] xarray: honor XA_FLAGS_ACCOUNT in xas_split_alloc()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-add-gfp_account-to-xas_split_alloc-v2-2-5a56c2361d85@nvidia.com>
References: <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com>
In-Reply-To: <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com>
To: Johannes Weiner <hannes@cmpxchg.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: YQZPR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::21) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 90f9c159-a488-4af4-54ce-08deeea9fbd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	wbV48SsXj7DcQ9VVCEV3FOpCpYr5BuH0puyqeF0Rm2CBPtnyJnRcv0BbnLUeeTIKvgubhMvKM2GChx7O8btJKlRVOdotg3ztn+orZRQ6iKc/SRSB3M2mm2W0xXauFt8y/bh13DwE2ci6eq1hybFEbbshFSFY1LhwWdaNUTqwts8h8rav4UpLQv2t8zpso3VEOGNyZD8+bLP6ncsboNvqkjNHH4dSshsYuvYZ3p03qgeS+9M2UPzjoNuuzURnqjkes8MJWyBDGvJS0Do98X2HVoBHFFZDLqMcOBlDdH/kGAT/eVj8/kOzpF4b7QyGqjY7N9kxu+nlrD6QuFrHYuudwqH1oyIb62EemmT3SKcypHhl/53pKxoUAKFNkTGlxJH+3jNNPleRoWw3HfcgkWNCXa/f6+0MIYT/jx5KjTXarmGtC3rk/mJ8up7mVbN8HH2vpgglN7xNbgsJyZK+VeE4TwWe6cLW9Dn4OfYPPzVy+5mktNYzJWTioRLMnpKEItIOg0ofmX42HCAUrwymNIIdnO1oSi1+W5fdY0svIikdWJ3SRLyAwkLodx557etuoNWLGGBq7X3aYHATTacrGPwuvA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0ltR09sVHk2MnFOVXlmcWh0eGlQWUtPMTdseTFEcHV2MjByM3YybExVWDlz?=
 =?utf-8?B?ZVYyRWxWSHFxcmgvdWc4a3M5SkwyeGdzb1MrR3M1ak81V3Jnckh4aE96T2xr?=
 =?utf-8?B?eVN2QUxJaUs5ZGdSK1d6UW82azlQa05MMW4xMXRROE5qbzVSMW1qK3Bpcnc5?=
 =?utf-8?B?d0pMZnR3ejdiK3lBOTNvQXhYL05pTnRqcWNhdC9aRXE0ZmxpOGFDRk1GRDVE?=
 =?utf-8?B?ZkhqOC93SU1MaEdtSmIyT0xDODc1WGVPelBFY2dmTlE5RTlnQjdsZ0JlWlVt?=
 =?utf-8?B?Tk1raUdsZzdSbUFnak45azVORm02TFlBMTNGT2JYTVVLZTBJL2ZiUzhhU0Zu?=
 =?utf-8?B?dlJxc1JsWWw4Vk9FeHZCVWRmMDlUMnhtTHFtT295V0N3UXVBNVJDWkJrNE1j?=
 =?utf-8?B?L1RvNTF4OW9nc0JtNVBxMHo4OFR0aTY4NUpmYXRXNFh5dExGL3VhZzJkMGRY?=
 =?utf-8?B?N2gxSDUvNUpCVXp2UWJwcUdVNzQxRkJqMHM2SytYWW83YU9mTUY4empJTkts?=
 =?utf-8?B?VW5qMFU2WUFoMWc5Qkx0V1JSWkFWb1dBeHBmdzNqKzlIbTgxSXBzcjFlQ0RM?=
 =?utf-8?B?SzB0WENKUXBNZ1prR2ltOElLbmE3VStVdUh3Z1JpdWR3U1FOR0JNeDNNMjMx?=
 =?utf-8?B?cnRnSk5zM0hhMjI4Q1owS2lrRGV5bFIyZ2l2bUlRMC9WRDJQT1pqU2FTaW1Z?=
 =?utf-8?B?MWNYYjJhUUZON2c3ZWdQS2haVytYcjBtWjJ3TjRNWHU1bXg3NUQ4NjY5dTNr?=
 =?utf-8?B?UHVrQ2lSWXFyV2NiZVlhUTBCMWkwQWZUVzNFdUk4clRORzFLTGcxWkZSNVRB?=
 =?utf-8?B?NXZsODNBMlUrSURaNFBLQjdtRTF1dUcvallpM0pzTVJwUnNrcnh5NlYzclQz?=
 =?utf-8?B?c1JrVHZQZTU5ZGlEakJKU0ZCQXlveFpGeld1R2dpYkZoM3hTVXNZeWVGTkRV?=
 =?utf-8?B?dk1DYllMOWs4RTZuakdqOElKaFBVaks3M2l0dllkQkZJL2dxRWJQckx1SDY0?=
 =?utf-8?B?WGwwdTZqZ1hoaFpzZlBDL3J0UEl2UVM1VjIrSUNyU2pKT0phVlQxVWswYzlt?=
 =?utf-8?B?ZGlBRnhpdFVYV3pRRkFPZlp5RjJIcmVPVmRlaXNzWUdkVzVGdlp5Z2FSeVJS?=
 =?utf-8?B?bm50MjMzem5PN3R3aW05VlVTNkhPOCtkNTlnckhzeDd1eCtYeGRxYlBrdlhj?=
 =?utf-8?B?ZlNpUnJJOTNyaGtoY3BSMnhFcGR6Z054R0NVcHZCd0JEWUZXQTNuZ2ZNMDRk?=
 =?utf-8?B?eFB3OGd4T0t4ekZpbUlLaVF2dVRkd3JnV3lrQ0ZQU1hYK0swL1RjVFVranl2?=
 =?utf-8?B?QURaNXJkK21rek52UVdjUWdkaXh6K2xLOXdQd2cxdGlsa1IrVCt6MDBPNlMr?=
 =?utf-8?B?MnhGaUN1a0thK0lrRlFsUDVkb1dDS0pVTk9kbU9jRlR1QTBqME1GcUxsamd5?=
 =?utf-8?B?eGxBbWdUK0xKUnVsenlLTWEzTnU4azlRdXJlR1FFOGNoMEVvdWJDRjhjbmgx?=
 =?utf-8?B?SHRKdTNTK20wSnZZSkVpZm1XN3FnMFQ1ZVc0ektWVEJnUllxS3h2OWxIWkJl?=
 =?utf-8?B?YmZuM1g4VnA5dG5QU1F0TnNZdDJBbmk0SkMyVFRuSmdUK3BMeG1VaEd1NFVa?=
 =?utf-8?B?QUY4SjgzSGF1N2d1bnowMEtzamhFU3RSOTEzN2l2QUEyc3NWLzZkNmxRLzQ0?=
 =?utf-8?B?c2VzQXdlS2cxL2hWL0ZwWXVzVjdhSkhhbXBOcUw5Tk1IdFFqTVljTEdIWVhl?=
 =?utf-8?B?bTE5OWorQWtPNHF0S2gwRHZiY3R1RkhHTTR1ZlZWTFVZdEJXQXk1ekdoVllt?=
 =?utf-8?B?TGt4N1I3QTJseDJUcCtBNmZLS05DNEhMZEZUTnJZMXRYMlNIT0Zpcy9iaFZp?=
 =?utf-8?B?WVFUaXRFQi9SYkVYd3I4SkJxMTdISmtZTmFjem9MbFVIQzdrODZIOWRPYnVZ?=
 =?utf-8?B?QTFmS0hrNnFRQzhtbjA0ckJ1and0K0ZyanpnNkhhTHRpR2RoS3lHNlVUb2w3?=
 =?utf-8?B?a0VvNU1hNndZbmtHeG9mdlVNb0hZKzM5YkhEK0F6WHZ5d01VZ0JZUnZIcVZH?=
 =?utf-8?B?R3dzZWFIMVlTZytvZ0trVjB0dkJPTmRwOGc3SkhKenR3cXJOcXoxVjhwMmxK?=
 =?utf-8?B?c3Vjd3kzcGpRYzRXcGxuQktVQXRTTzAxUHJ4U3dGd0RGKzBncmhXRHZza0ZC?=
 =?utf-8?B?UjNORE1KalFDOUhLV3ZxcjFJNFFHaHV5dnlkQzRHZkttVlVvWGpRdko5UFNM?=
 =?utf-8?B?Mi90ZUR4bWZpRlNkclFReVZPVWZWNlUwaHUyTmcwRXVzVml3aExkYTNOd3c2?=
 =?utf-8?Q?E1bQjPw+jxePCSw3x7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f9c159-a488-4af4-54ce-08deeea9fbd9
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 02:18:17.6283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vMjwLjSrYNMauVIcOXAXzS2w9Tk+FDjy4KMAN7vyQ+h/G4nyh8zZEh8a9MloqP0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652

XArray operations that allocate xa_nodes, such as xas_nomem() and
xas_alloc(), add __GFP_ACCOUNT when the array has XA_FLAGS_ACCOUNT set.
This charges the allocated memory and avoids the workingset convergence
issue described by commit 7b785645e8f13 ("mm: fix page cache convergence
regression").

xas_split_alloc() does not have that flag. Add it when necessary.

Fixes: 6b24ca4a1a8d4 ("mm: Use multi-index entries in the page cache")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 lib/xarray.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/xarray.c b/lib/xarray.c
index 9a8b4916540cf..bfe7bef80f34e 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1053,6 +1053,9 @@ void xas_split_alloc(struct xa_state *xas, void *entry, unsigned int order,
 	if (xas->xa_shift + XA_CHUNK_SHIFT > order)
 		return;
 
+	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
+		gfp |= __GFP_ACCOUNT;
+
 	do {
 		struct xa_node *node;
 

-- 
2.53.0

