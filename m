Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023091.outbound.protection.outlook.com [52.101.72.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE2A4D2ED0
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139975; cv=fail; b=Ar58V/xW0yhTOmDbOsGHJjRgKdHp8sJzr3YP7dHlNxvbe0lcpWv3hxPwRjrfX9Nb0kQNfEoCaTgJUH/Ij7V0z6AmK/sHJjs77BQF1z7SthZnGWrWNpYTY/OGgwcykLdEmoduCg5DP2i1GmVjz/Ks8dC26Jh8jMW2POyKGrvvW8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139975; c=relaxed/simple;
	bh=0/V+UqBN9BSij34RXDcOnwQtRfqLl5Z4rlHu/Yp9hDw=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=S3Up91yNDbbiYfx8opUm6rzHoDmw2FqsqK5RdG4+y1va8oR+6nOB8A5bgO6bSf+KsMIroUMeSW96vJuIdlpRGQGbIcFZpO+0YudFyjUcl0vUZ/YlcmA9NMbfU+rWbyn5mmgXz4J0j9dz+ODz3B19nhITplZfwbBmsBvvmWBthRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com; spf=pass smtp.mailfrom=tuxera.com; dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b=gNBDJaRe; arc=fail smtp.client-ip=52.101.72.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b="gNBDJaRe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jzgRFH4N/HOb3Cs86X2HbApP7MpDXDRoBNWwz46PM1J5IVQN1NoWHjvczBm5rk1/E6suk2plU1Bt/WaU8cRx31ECWNs8EApPITyUcKGR/KLmCw+n5b1qN8CrmTYo5ByPtJZovLPfYTa5wOLyhm13OJSpbIEOcCoRSSF2vPf3LG+8PjRkp6Xu95feKC5EAT8eq08JrJj+nN4sLuok/GN+P/ubKqkThi/7WHqC+mEjG+yu+WUrvGvA7iS/c0SlRjRaDbUTYJGunjzC33u9lyxqchNSJLfr+nNv7Sc4v7gmlfiZIy/r/KnWfkfPJSO8USzWwKpA36YzKktRSgcOvnRBMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqCM1MRu0eS5ogMuvKhOslppDC78VGJtqXmaMswj3TY=;
 b=RLhZH3m+rdugJDIUICPsTNqq8GcTowXjg0Z2OU+pTlG3jKaBIbw6zxl+HR4BUBX5uDHgFmLvpsSFqWKCuLwUIWZcb+hTyHpS0Ii24uOdpowahTTFJv4OLQaUU9ukKUvyzDQm5ehzIJODeFssGaM2WdFz9pEZHqNWCca3s87UyCA1tJjl4K8JLXOrIMyljJ9ZE87c2HU3gxduBpUR+G8JUhawrcuaU00W9CKJUNMR82jWD/W/zuDOxRYtcUdH+5jmcbnadlNWwJRRu2NMLc5aVxHD9xL6ZMAc8MoFL55+CT6B4BylE1QFQgRz9aD2QgrXVa/gWRazq0vG/0izk0WkeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqCM1MRu0eS5ogMuvKhOslppDC78VGJtqXmaMswj3TY=;
 b=gNBDJaReJY5NKBP8YiaXqDz+8wzkxQvvuzezmceGTea25lHw3FQA61zrSN4op+tGjudlObcchetWa0iGtqSyv2MFlg/WAGH+mNgSra9VR+JdF/xjV7ftgXkm7Gf7Rxq1z8hexfOhmGICH1/MM8ELKzT73FF5XjXRtWCxGYcUbQ6143pq1nfe7a4nt3KjVA3zZpkTMDgT1lZEw3zNtjIfqL5werqoU6g9awLoevFGKJa/YhMyARUJgw8t0D8OTZYiWXI+SCqlqHS1kLsRPd6pCXGwLMKKo+wYtARqkQ+/M6pyBw1Z6Uta3Ze+4X6w0fartgN9oxaxaEcq+S+cgvMlfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
Received: from AM8PR06MB7108.eurprd06.prod.outlook.com (2603:10a6:20b:1d0::10)
 by PAXPR06MB7597.eurprd06.prod.outlook.com (2603:10a6:102:157::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 18:26:01 +0000
Received: from AM8PR06MB7108.eurprd06.prod.outlook.com
 ([fe80::a59c:f3ac:4097:9c5e]) by AM8PR06MB7108.eurprd06.prod.outlook.com
 ([fe80::a59c:f3ac:4097:9c5e%6]) with mapi id 15.21.0202.014; Wed, 15 Jul 2026
 18:26:01 +0000
Message-ID: <49654f37-5873-4ec8-bf88-74c1b1c6d1f5@tuxera.com>
Date: Wed, 15 Jul 2026 21:25:59 +0300
User-Agent: Mozilla Thunderbird
From: Erik Larsson <erik@tuxera.com>
Subject: Security version NTFS-3G + NTFSPROGS 2026.7.7 Released
To: linux-fsdevel@vger.kernel.org, ntfs-3g-devel@lists.sourceforge.net,
 ntfs-3g-news@lists.sourceforge.net
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF0005F6FC.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::24a) To AM8PR06MB7108.eurprd06.prod.outlook.com
 (2603:10a6:20b:1d0::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR06MB7108:EE_|PAXPR06MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: a3758764-aa3e-4c21-08d5-08dee29e85b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	2TXDL5CktfSEIZwh20HdSIBZSYRVmSBU5ffMYj/DYBxjbfrqh2UVgv9nV9pRUX3XJy5sOym2Kw35Ls+R3zyb81Ob7rkNTypRnCkm81Q+giU7DTRHf1gPJFLpwYIKXvCAxmC2ywkFXsbVwT+jZV20AzdicBd5lnOlHd64ckDficbAq1rQEvxegd9dgMXpOMkXcPbVmL3jQYmwCgRCkzKIE9gffPGuTQ9wiB9UwZE0c7rSB70wXEE1+9hSn2qEnmZBY1v1BJoevexDgppUX4OmG17GAAKpnGAvEmr0Opue3m3TnQmyYlTAVagKiMZWNyZheKbcbYOp4l+2y36y7Zqw1J5y5qbybW1AMT2OB52JDqAY2ovV0fPvReaP+2/zffyMDsUPqpyjrOVSrqJIsIxMzKemWZ76GHN8vtpbnbNe4CERvMi5ZvhpNCTkjP0oGEfoccpm7W/s6HgxZ4NRZFF14E0xNFxjyeJi12T17pFufX/MS+VuJGRWnxlb2ItiPUtqJVcgTaP+RXpjYb9xxKMOgWlghAPEDdK4mDF/3gvGpirNXvX5AHWj+RHUd78JyXzFsBgAIA7BdQrgoTsp61CMfhFJprYa5Hiebw2fPIURjJDn97MPr+pAMVG8GmLgEOLfcM4ULd9IgZ+WHJfn5R0ESv3mfE81t9uz7OOK96rBT+0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7108.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(56012099006)(18002099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGlSSEdCdGVBWkxoNzNtWVAxUW8vQ2Z6K25kU1hXWDVQbWl4dzJldTJ4Z2Vy?=
 =?utf-8?B?ekM3aG5uRk53OEpVYUM1YUE3SnZCTlJwUGlHNEVzM3U1c00yd0oxKzdKTDNh?=
 =?utf-8?B?M0w3d0xqN0RQRG9mTVAvNlZDdUpPTHlLdVd5b3JsNWZ1VHN0bm1oaEQ0OGNB?=
 =?utf-8?B?WTlQNlJYUkloUDRVcERXQXJqc3RVRDVUampFVklhVU15U3Y4akN0ekVqN3JG?=
 =?utf-8?B?aDVqRm81MW9IeXo2dGlTZFVycW5HT3BjQmU1eG1ZNXFsWkkvMUpCUkJ2bzJ3?=
 =?utf-8?B?MXFKYjRadzljd3Zmb0tkR2IzLzBKcVpvYVN1UkVmS1EyUWwybCswbkRaWjUx?=
 =?utf-8?B?N01mK1hOTVY4cnRWRmREcWdsNU9oblBLeGxZSnlNMlpQcHJtczgwbExEUnVZ?=
 =?utf-8?B?ZTQvSng5dWtmZW5BK3psVmdyWTR0SlJPT0FEcG40emsvYW5ORmFhU0dIMUFq?=
 =?utf-8?B?Tm01SzcwUGFwQzU0enJCSFZwa3ZVTzcrTEhEOWM5NFRXMGVIQlg1NVJybVVp?=
 =?utf-8?B?SWd1VmpPeXJTdWUxQm9FWURYN2tkZEdtclBxeW9vQ3VEM0RaOExHY0lxNlBs?=
 =?utf-8?B?R3dZVHIxbzVNV3R4TjgrcGRsQk1KUVZ1NkY0YlJRWUFpTHFZdDBiN01vK0Nx?=
 =?utf-8?B?aDhyS1N3SVlOZ00xL2EvRVloSmRyQUsxUDFVZkZBSHRtS3llWURLdTFub2ts?=
 =?utf-8?B?cjI4Um1ZWXpIRTlJak9SZ1BjemMrZCtTUjBuY0dNQTdJY1dUbDgyQ3gyZHZR?=
 =?utf-8?B?KzhSSWNKZk52OHRzRmRFSHh1cUp3UmZzdTRDc1FiMVdDQUJpWnFWY0kvRlc0?=
 =?utf-8?B?UTlyWnFmRlFEbUFuanVWRG90RVA0cmZFeWI0aHJZdzd0dHhYQmRwQVRNMnpp?=
 =?utf-8?B?N3EvcmJPanlIZmZLQ0grejVadE4yeHdQV3hRT3lNZnhEeXdxNnBDWHFVczlw?=
 =?utf-8?B?Z0p0VW9jYkpQN3ZuTVFia0xIOTQrRVdMWDlmcEpUaUFwdEhIbzdReDVsbExa?=
 =?utf-8?B?eTlld1FTd014am1pc3k5c1pOZmFCOUg1c1VybU9sQ215Q3B3UjlxeTJiZDc0?=
 =?utf-8?B?bE80MFI5d092ZjBtMWpOdG1WRDJWRlcrN2FOZGtQczJMdVRQSXIvRHFxSlg3?=
 =?utf-8?B?elZLNTN1NSsxMkJsN2Z0Q1BsMWw3MC9rTG96RmN3SlFuNzFsTTA4THJuVUxM?=
 =?utf-8?B?Vms0QzI5b0xnV1ZmK2lSZEs2T0FEVmh4cTV3YVdOTThZVUlNQ3JwaW5jWEJn?=
 =?utf-8?B?ejhHWlNydldSWkZIeDVBUHZ3b3JGZGIrazdsOWgxb2ZxdUp3MzNwQ3VETGFM?=
 =?utf-8?B?OGJmTkRhOU9KdUhFOVNxbVAzVExXelFQemM1blhJU0l4WkgwUDlSRXB4RUVZ?=
 =?utf-8?B?bGNwd2RoVVFzdFpsaStVVDdXV3dzQkwzbXQ5SnhMMXZEWU92bFlmK0lRRXpF?=
 =?utf-8?B?a3k2Skd6dXFUV0tMZFI1bHFCR04wcTJMR2oyZW9KOTZEZmNPMi9vb016ZDl2?=
 =?utf-8?B?K2VYUTdyeVhrZkpydEVaZCs2QkFWN0N6WlU5cEVBbkJhdkZLQk9sT25oa1h3?=
 =?utf-8?B?NXVoTWRhZHhPVThSaGNuMy9pNXFtaTh4SGFwNjcraG5zWUNuOHhScDhYZG1p?=
 =?utf-8?B?aWpWbVU2SVArOFE4MVpTZWdOZFl1K1dTL2RnS25LSjdvYk9NaC9yWHpXYUJX?=
 =?utf-8?B?N09SZTVCb29QeDIrblJrL2lhcUNvRUJYRnd1QUdtajNXVmRtVFltdkJGd3V4?=
 =?utf-8?B?YlBSRFR4ZmtBcWNMaEFTTW5rcC83RnI5TlBKOFpiek1tT1krWXFKdDZyZjln?=
 =?utf-8?B?TWh5ZVFnd20yY1hjbE02Vk9aTEtXSHJZMzJ6S1VwQmpRV244aHlaOG4wUTBo?=
 =?utf-8?B?dncyTHFRWWV2eTU3cXNKTmdqZ3ByRENpbTJrblhtVUF3eHNNNUJCZ1BCa2lk?=
 =?utf-8?B?MmRBeDFBNWg2VU1lNXNWVjNROW5IWmpaZ0htaGZmV3F5SjhVOExFWGJJVGVj?=
 =?utf-8?B?Z1d4MGd4TXVKV2l4SGhFWUhSN3I5SjhoS25sOGNsRHhvankzQ21XMXNRRnRx?=
 =?utf-8?B?NnN2MTUyRVp3bFhiVFNmMUVoNGU1WjdzYU94SXZzanA4WE1JM000MG0vOWlY?=
 =?utf-8?B?M3V5cHh4VVBBNzdQb0J4ZUxqR05OZmI4cGFwVnNnSm1zWmpRd3lRWU5kVVpq?=
 =?utf-8?B?RWdRTmNqTXFrS3pvUHRONFN1Skk5S0N5TjVpT1lWQm9CSEF1RTMrQmlqRTFH?=
 =?utf-8?B?VWtPT1ZHZ2hrMnpKK1djMFk2ZENoZ1c3WWRsa3dsRnkxOTVvL0Jva1lYa2Y5?=
 =?utf-8?Q?we7FINT9xcoTGQJihw?=
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3758764-aa3e-4c21-08d5-08dee29e85b4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7108.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:26:01.4408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4O29xSEZULdRUpLVZoM8Uzviln6wH1lavdDQTsDrBO4Iy6A1Sa8Q+4/Dvt2T2Div
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7597

Tuxera's NTFS-3G team are happy to announce that a new NTFS-3G security 
release is out, version 2026.7.7.

The new release of NTFS-3G includes important security fixes. A list of 
the fixed issues is available on the GitHub release page:

https://github.com/tuxera/ntfs-3g/releases/tag/2026.7.7

The full changelog is available at:

     https://github.com/tuxera/ntfs-3g/wiki/NTFS-3G-Release-History

The new release can be downloaded from:

     https://tuxera.com/opensource/ntfs-3g_ntfsprogs-2026.7.7.tgz
     SHA-256: 
d67b769025d32860549d35c2147e45024d172f81c540d750390ce3602c059dab
     SHA-512: 
5b0a866c3c556f97b1c712fd09b148ecfd194429620e1b45f0630f6b4dee6a087496ff9bbe36bfa1a3e7c58483c43d45bb1e03956e0386aebe8b66522d90cdc2

The source code is also available on GitHub:

     https://github.com/tuxera/ntfs-3g/tree/2026.7.7

Many thanks to Jean-Pierre André, Rakesh Pandit, Emil Thorsoe, Rostislav 
Skudnov, Eva Rio, Ashok Galla, Szabolcs Szakacsits and many Tuxerians 
for their contributions to this release.

We also want to add special thanks to Alexandro Calo' from Nozomi 
Networks Labs, Abhishek Kumar and Jurre van Bergen for reporting the 
security issues that were fixed in this release.

With best regards,

Erik & Tuxera's Open Source Team
