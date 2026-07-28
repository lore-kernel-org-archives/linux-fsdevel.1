Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84CC10F2;
	Tue, 28 Jul 2026 01:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785203516; cv=fail; b=OzB8bAF+EqbhTB0Lh9RS+S+rPUd7ZHpwdPjAvvq9co5mgyCITDjHeA2UgOmme3ylRyjOygKpLHOEzOhskqAEajc/RUPwImwCgsX+KTzowJ9rsgm+ImeTx1no7qiec32iZTt5Vk4tir7Ox6zc2Kc0nOabkk0D0rXAKe1RYeM7VRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785203516; c=relaxed/simple;
	bh=C36iqDopywsKjxr01UBeXeQgWgfEPpmDUkHIzhn6l/E=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=e+cKAmgr/dUGSdsoyuAP+vHq+tw5AeJbJHHOGCA//fNiJoT0NRXYQD+7rXOaDvtbvhDXrJPSjWXynugcY6dKf2WeoazEDfx9Wz7AzZNteVbDojw87Xr5A3Rk2/SGFFM5O/G5cmEofWKAEG6uvvQ7JUxqtmo2tp1DoKbm2pXclKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NRJP8x80; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NRJP8x80"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kKuzQCIv/RmJm2hfmne7ddehk0s1A4w5unUwkA/nBMwSYrlO4s0X2gEqWEB0BIg+N2IxrCrf/sm0gb+gzCjY4h41VYKgE+63fEf5sYuqo7BqpmHVY00afl6KLUZHfdkfzzpHwjAvc6bmy3WPlpepZF2qLi0zBMUgnwfSaLdpXviDgEK76rBxo8fUlgzvsRJyHYck93S2UpYXiHRqZrMRk7EiIHCXYLceeLONY1Ia1HDlGMNM9fc0KzDH5j4E7d/wKFwTgGpYIzeH87qK+uM+DBA3OSdPaGQ6hxJzIKaC1ULsQA+w4Ub+eEV0biaJAI63Im0sEplD4IVjznVRu4LLuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4k5FktSjeNuaqjL9f97sPGwiu3KoU8ombyBrAct9LY=;
 b=HXh2nDF4q0B9fGdMuauY6hNmMLime8G3f58FzQ3TWBsMzavPO5s+2eR0sdMQ/0uN/NgcnV/vP6o4t1ujOeIfRatpMbYkoVHbCpADfo6nhvGvfcWZ2YQjMsfi8wbpXukThxyaDBtUt9Qkq9Y79HIcY6UhsIbeFisUZS8w4fwUja+K2rYGkf9Icr6HMshUFlMRoHJFhGHjFyBe60AVqnGLH9lx8zKlJlzjxl3EdfCsYeEisuwQKX9gSqzneakL+pKTqwkUHIMAJFOS+290jDlOHFanSja8rVxcCm421Iidc432DBldhgh6olIqRncdMJliSgK5BRS0IyN+mD3PGxEmoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4k5FktSjeNuaqjL9f97sPGwiu3KoU8ombyBrAct9LY=;
 b=NRJP8x80OnMRU+IYewfMzFUFTqIrYYVc5/nrNpqebmomNpe6kEgccN3BAE4sEC+rpCc+C/N8ru/gUGQEpwsbBcFsx7ww9KbY2x4GvIf0aMwCjT8GFKkoxh5n6I6247qk55xyKrM4PK1K3+U0I1kL+BVjG0lYRTi5XL3ot7ogw1JCkg06h11hYMuU8tYPLMoDva7JKjnh3Wg3LPj051uuR/sAZUDmghU2CjsWekmhEEvqmBbswXgY28aCh1Irwdv0xOlFYh6JabFlQ5Qc/+iVGZjLSNMWFyfCtQskP5m93Eq9L+drkDlzS5euvCtJtQyblP2OBfV6DCnVW958NaCGiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS2PR12MB9821.namprd12.prod.outlook.com (2603:10b6:8:270::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 01:51:50 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 01:51:50 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 27 Jul 2026 21:51:40 -0400
Subject: [PATCH RFC] xarray: honor XA_FLAGS_ACCOUNT in xas_split_alloc()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-add-gfp_account-to-xas_split_alloc-v1-1-9fae6bf64838@nvidia.com>
X-B4-Tracking: v=1; b=H4sIACsLaGoC/x3NQQrDIBBA0auEWXcgsaFKt4UeINsSZKImHRAVt
 SUQcvdKl2/z/wHFZXYF7t0B2X25cAwNw6UD86awOWTbDKIXt14KiWQtbmvSZEz8hIo14k5Fl+S
 5avI+GlRXGhajRrVICS2Uslt5/09eMD0fMJ/nDzSmQEZ5AAAA
X-Change-ID: 20260727-add-gfp_account-to-xas_split_alloc-83a1bc848b77
To: Johannes Weiner <hannes@cmpxchg.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Matthew Wilcox <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: BLAPR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:208:32e::31) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS2PR12MB9821:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b201d05-c7bc-4d9e-81c2-08deec4acac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mKdp92M5g4iH/sFOFPDk1lLTbdPJ/TcynzfyDcCy8T/2Xyn6zRrmWnG7eAGI+ruVEgvd3nzJ+IJhPaZn6Z+fdO0H+0808M7RmIC41ZIyNw40u5w6vm2aBKuPcbmAIZMKcl93xBrarHhL4SlHWKHU044WIivunYZDSBg+7+3Ic94tLYZNkWUrljhmauQ/ZZXbcIWdc88RpPxwYyR1G2ugOQ8m5dufoKLwN1SscLtQrO2Uob+XcJ7yjqBFuo3wLxcwZvmafM7bfYy8DXhquxdFiLNdLCGCBcy1pfKgelE5Rw6KcUnRDogC4U/kSaFgMklgXQ/PP7/8jTi1ISsKNuCv789UNXuVcrFBp6vJZVF3fSyLYPn0U7daSUE5tn8qwe9NgcWyceZb+1EpbEdFP8VEEpLCrSDsnXpYh2+rcdzFatJk76BPRXdEd6L/TQFMm9LFX9WcTFI1u8xbM/hgOWgw3xvVmaWO5qn/3KZAzHqMCVnmPGsuuOBBz7sVjM9U3G5OtP65f6xQzu6q7IOowA1Svqso4z5Z+1ZWL2yeJj7dqU6P0DMDm9wuJ3s7S4+leqoDANzf3Gyww1D8llLukzwgHNjdW54ZheUJW2EwtFFJZDLiHLTj+rmkA3HlU1p8KFC03lYQonHVN5hfaDtNjawBz3u6DpqoOjdNmNwkAia8ezs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eC9QVFNnMnBZS1Z4c0ZvSWJmUGZqTmRDVjExRXdXMnhITDFFZFVPNHcxNDdD?=
 =?utf-8?B?aEY1aXJsVU4yZkVpZnZEcVNobENuUjhiOGZ0NVMvTVRJV0R3MUFCZU9QYVd0?=
 =?utf-8?B?VzZJR3RtQ3plNjBKY2lrVm1HYWFtSXhYV29UUXY0TUJwRGwwMUpaTFpIUWlv?=
 =?utf-8?B?elJRRGE2ZDVrK0h2ZGdQYVZmM2hKLzhCQXJROERBeVNGd0U0Rk9kZkpQS1pv?=
 =?utf-8?B?MGJ6SEczeHArbndJWlJQZnhyV3NuTnUxNzI1c2dpUlEwNVhRMmtwd1lZY3JC?=
 =?utf-8?B?M2xCZCtWTll5UnVOS3pmZWY2Vi9sT3VNMHlydUliV3BjMlUyOXV5REpjcGRW?=
 =?utf-8?B?RFVERzFpUVZUYWM3YlI1VXFRV2pFMktkdDY1MnRCTndiV0htOEFkMHVnRjNW?=
 =?utf-8?B?QnVwNVVIV0tKZVAxRnZ6eFYvYUc1MGVURVFKTGFiWGx1V3AwdTg2N09JaFVh?=
 =?utf-8?B?Y0NZR3BkVzFJVFhBRlJuVXFPZkF3Qk4yZE53UFF3UW55NzhWeU4vWDlPenZN?=
 =?utf-8?B?cWpsdlBGRytMNWNaMGVqR3BySHBqQy9TMlRjR1FnYXA4Y0lnVmEyZzBJRTNu?=
 =?utf-8?B?ZitsTS9hbHp2U0IrRlNLSGx3TWIzeXJrR1AyNVB1Yzhyd0RnTnVVWjFNdlR5?=
 =?utf-8?B?clp5Q21mdWduWWZLOWFIQ3VLc0dFWUlHM2VOdEs2dEV6aFpzaE1nRkNDQnVE?=
 =?utf-8?B?SFlUVUNPYk1aelJPc1VRQmNDQmZlZ2pSd0RjSmhSWE43UUdiRG5CaVN2c3pU?=
 =?utf-8?B?M01SQytrcUR5R0pPWWVuVVc4V1FHQ3BYNTk3bitpZDcwOGpsa1V6N3BOc2Ri?=
 =?utf-8?B?L3k0K1VoQjZmYXhJZUEyOTgyNzhDc2luZWxHYzdyTkNQdXRESDZNSy9MKy8w?=
 =?utf-8?B?SStucWE2WlR1ZGpWWmsybkJPMkVsWDRDTFVLbFBSaUhvcGMyYWRHZnhKWG5G?=
 =?utf-8?B?OGh0UTR2K0crVjVFcDFCSFQxNlpCVlpUa3JsK3RYL0RTd2t2dkcvM2F4V1dE?=
 =?utf-8?B?a1lYazRRMFJtbGVYVGI2cWZJeUMxWWhRNHpqN2J1RFlXODFRQ0xTQ0RNQmYv?=
 =?utf-8?B?aWtlSDgyd1RmOHFIN1BVM0JpNkM3bDkrN244VmRsNHQyVTg3YUE5NVYxVnpz?=
 =?utf-8?B?MGt1dzV5TStQZVZHazlSNjlQbUNkUitncEpNV2hZZGxEc3lCQnNVMWZlYVBZ?=
 =?utf-8?B?UHdFV1g4OW9FN3RGNkxXeFBpdDFQaXRkRXFiRW1wcGRyRzByZ2lZRmhOTXVD?=
 =?utf-8?B?eHJ2bzZyN2JEdVZyQllyVlZUSkVnKzhKMXl2SHJkVnFuTjBVTWJFMWYxb2Z3?=
 =?utf-8?B?M2wvSXRwNWh0a2ZZUTd3NEVGeklxOVNVQ1l4UTBqOERocDRBWThVUmFtUmVs?=
 =?utf-8?B?OTdoWU1BSDl5QlNxK1Q1Y3pxemNMdXJDRXFIOVBlR0VMazYrL2ZYdURNaUJN?=
 =?utf-8?B?eHBzcFRvT2ZKOVlRb3RFQmZGV3dnQjViUDRYcXZtVG5LM2w3elhNZExhSGx6?=
 =?utf-8?B?U3JKVlluQzRsTEdhdS9DbWFFMWE2V081K1NqSGp2TUxuYVR4ZnRHQzNYL2wz?=
 =?utf-8?B?c0hCVVdsSjlocnVpcFBpTFNpZ0lzd3pHMk5BM1plRHZPSW1HYlppSDl2c2Fv?=
 =?utf-8?B?WmthRG5wRWJQVzcvVnluMGhhemtWSFdRKzBaRXNIZy9FZGdWOXZib1FxcTdT?=
 =?utf-8?B?SDJBZFlYdWVIbzRSRE95SGtUZlRUWktmamk0Q0hCUHVCMlp1alBqV0xiRnkv?=
 =?utf-8?B?UkZ0b1lubHBoTU5zTGJFTXJ3L3JhOVA4MW95YnNtYjJ4cTNscTVJa0JsN0ZD?=
 =?utf-8?B?MVdYaXhTeCtya1lDalNZMkorRGozcEQ0TmVnRTM0Z3hHZ3NvRnR3TktZTmcv?=
 =?utf-8?B?QmhCbG8rMEl4WHI3UFZEQlhVeE5ndmk0clp5RTdyYjJyeWNERFVsZDRhVFUx?=
 =?utf-8?B?RFdkOWQ5a0V5Rkk0cGJkWElub1lJZEUrTXNzNjhTZFBURzQ1N1czd2JzbzZL?=
 =?utf-8?B?Q2hMRlkzNEtjNWVWODU4ZGZQdHdlc2ZPVWdndmh1UFlLV1RveU01MVZtZXdX?=
 =?utf-8?B?TkltMDFBVXlDWURFT3h6SmxGM1lycndUc0VjczFtZkpQWmRYeEc5UUhPT1Z0?=
 =?utf-8?B?R255TUdtNEtlRGtLczkvSVBMaVNpVmlWVGF1ekl5Um5JSEJqQ0RIWU9ucU5h?=
 =?utf-8?B?ZGtDdFJWcmFEelNKR05PSDRJRFRyNE01WnpsaGV0M1ZJdkUxSFNXTCs2SkFl?=
 =?utf-8?B?NmMxNlNmTG1FUDdZNnRNd1QwYjUxUFJwMWJNTjdYRmpxUERkREsydFE2MjZ3?=
 =?utf-8?Q?Kw/QlIZlzAApXP0JCX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b201d05-c7bc-4d9e-81c2-08deec4acac5
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 01:51:50.8122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToiEESUlcEIWQ4oOsvv7SOWnyEA0TGn4gz8k0WllPuxZ1YXh/7D8N3F022thAr3S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9821

XArray operations that allocate xa_nodes, such as xas_nomem() and
xas_alloc(), add __GFP_ACCOUNT when the array has XA_FLAGS_ACCOUNT set.
This charges the allocated memory and avoids the workingset convergence
issue described by commit 7b785645e8f13 ("mm: fix page cache convergence
regression").

xas_split_alloc() does not have that flag. Add it when necessary.

Fixes: 6b24ca4a1a8d4 ("mm: Use multi-index entries in the page cache")
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
Hi Johannes,

IIUC, __GFP_ACCOUNT is needed for xarray node allocation accounting when
XA_FLAGS_ACCOUNT is set. Commit 7b785645e8f13 ("mm: fix page cache
convergence regression") fixed a workingset regression with it.
xas_split_alloc() does not have it, so I imagine xa_node allocated during
folio split would cause a similar issue. I would like to get your
opinion on this.

Thanks.

This patch, if necessary, should be applied on top of the
mapping_set_update() fix[1] to avoid causing the same issue for uniform
split path.

Link: https://lore.kernel.org/all/20260725101419.3938406-1-matt@readmodwrite.com/ [1]
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
 

---
base-commit: 34cacd0ac7c10dc9e34e1b9f28a2b78d335cb487
change-id: 20260727-add-gfp_account-to-xas_split_alloc-83a1bc848b77

Best regards,
-- 
Yan, Zi

