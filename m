Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010044.outbound.protection.outlook.com [40.93.198.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CD4395AE3;
	Wed,  5 Aug 2026 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940627; cv=fail; b=dGWyZAXea/cjVzRnRPUowhXWB3xVqyzQheT9p8bfIrhbKhvghNEPSThnRIsX8YXVxt3WiOxwFlOxA0un+er3JOne90hFHQpPY3F0JeGf2gzVgWq5ojQsJ1ZEA4Pt7Ez89WUXD8gg20Z1tcmc06xXmqdYVvXNbMaBFPR3dBjisqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940627; c=relaxed/simple;
	bh=tdMsGujsjP2Alj1M78ZCJgeRu4G3ByOauNBPgDOLq/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I/8zmtRwUJPHR8bO8dRF1gZrq9o079aGfcEojRf9FFG9QnVHG7sCcQdN6e+kHltiBav1cDYTiPiD8RP/Q+rrPI7GB3+Wo/7s653W+pNd+bb5WX6UjQZD5Q2zCMIrc2ElWDMmeGLsjI1KjqLuvSX2EfqfpNbpxtMVOGNJ0M9bIV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GWGZjoIZ; arc=fail smtp.client-ip=40.93.198.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GWGZjoIZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3bjPvrxVS2YlrBgCm1IlHWFrn4owrc5jERBZ6NzjOWRyos0vx6pPu8xxzvuL1VXQDo4zhzHHNGIQcGD1GrKtPoMRri5oUTCXeoQcjaI9A726vE4RBvgGB8uBNELM4Wza01qB5k+ozbNUmkZTqJNkO2kDa0pR91pi1XbJ1x4qC3dSJMkpKfyIyu/2LgwRiuYJ00TqDVV1Q+kkiD2YnThruQEzEOk9W6bYpTJl69I07iVuAvBKnRZRL5eYK6k8sl5WE0P4dqSshuYPEarY7qWAIOce76qlgnr4Wv5dgPB8PZMpf9EWPTI2Kt5jVRRJvJUFMgr3vsBnTk9Xh/nUt0KEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2X2hxVUgU2vznBaDtCNhE6Y+M2nTwHn+mauUtt/7EtQ=;
 b=g+tFqNsr/BVgEs3I0CnRGgM+lGwpFvuOJPWUTlPOjMIRZrSizfVRTABoK8++w6CvZPhELcc6T9J9ylHntpi0REJO6XY0vRXyQM13NVSR6DdyqGsZsUt38xOcZdUWuDJ1B/rGn0d/mT9GExGdaDCjiD6MB2g8F4Rc2EItWAxy3Ie2qv4kpZ0o/vy8yUSTrZt6Md7aMeFqYQc0NVC4BbZ06q4O0SxjoZZI5etn/sH7MfwHL9AKLfv5mxY8KploZdflc63Ke8QWDYFx0uRauKdrSZZ8pGLWdFUpkfl3+kWHVzFEToNEGi6mPuTsibHFR0IqP9Az3ZsnStrndDuNz/ptVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2X2hxVUgU2vznBaDtCNhE6Y+M2nTwHn+mauUtt/7EtQ=;
 b=GWGZjoIZ3BmmMU2CFgt5Os+vP4RwFCpNfhDQFLZQTp6cyZpcZoMMJ06jpol2GHRiAnm82WzDXkOVOipVbvHqYugvQww+bVb7tQsUHGM4ptyFXcSo+bGSgG99MxBPvoYSvWEXLlmo17OADbCKSM4s8kLySdXQCPDYCrsnLOx/bKm/4HDOpzo4SBXiunJ2Kyd3aI7P7p29u6O6mWWHD/TtPJJRsvZRhcR9oke98qC+KwQ4JXPunPs+1+2E0BkjrTQrS/h5/09LPBYMeMTEV8oYb1d/kljbJ7Dpzvegt+X1FBsb0ZSkbD3/n4Fr69dGv8F6Qcr5BIv5oq6Ks6zshmYfVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CYYPR12MB8870.namprd12.prod.outlook.com (2603:10b6:930:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 14:36:53 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 14:36:53 +0000
From: Zi Yan <ziy@nvidia.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 William Kucharski <william.kucharski@oracle.com>,
 David Hildenbrand <david@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/2] mm/huge_memory: use folio's memcg inside
 __folio_split()
Date: Wed, 05 Aug 2026 10:36:51 -0400
X-Mailer: MailMate (3.0r7024)
Message-ID: <636BC960-7781-41D9-8F0E-C9E9078A5C73@nvidia.com>
In-Reply-To:
 <CAMgjq7DjCVxLLXU15ue6MVrqvWqW6goED_0QZLQ=USNJm9c4TA@mail.gmail.com>
References:
 <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com>
 <20260730-add-gfp_account-to-xas_split_alloc-v2-1-5a56c2361d85@nvidia.com>
 <am28pV2PEfHsi4p-@lucifer> <DKFEEI2EDS4F.1AHGKB1EL6XRG@nvidia.com>
 <anCtxQE5hDUH5N6a@lucifer> <DKFEUPDED2AF.22PKCFTWTG6G5@nvidia.com>
 <CAMgjq7CHDG8JhesSPMkn1kzG8jKb0BXO756BvxMQC_MCn2eTyA@mail.gmail.com>
 <D6EE6133-8B15-438C-8616-4639710F8973@nvidia.com>
 <CAMgjq7DjCVxLLXU15ue6MVrqvWqW6goED_0QZLQ=USNJm9c4TA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MS-Reactions: disallow
X-ClientProxiedBy: MN0PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:208:52d::7) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CYYPR12MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: c31702ff-5730-4aaf-30a9-08def2fefe23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pH18MisPNCq12Zn53z+HOkr721nXdjlwmTW6TiFnPtYD7ghX3XBzUjrodsEOQ7ftrW3/Ut8pnC9LPMT2umCLwJCZlReed6FsWwoN/zUuMzeTFbHoxVSmiE2zd6pqfQOtq376WxZ437dkJqxx4IM+ZjXpN97XiQMw1cnt04B8Y9x/f2ZZEe03nNsOgudHzfUzmXp3VtRA4wYDzPJ40xrO15akSReXAhiYQd9ynmNEop0fJSXJkbkLiAnEpJD58V3JtjaKEniRfgrY7EiRz0DCkmIf2DK6xXNXJfFaSk/A10SEesLvn7RVvZPZMc327pbXfiVoXes/PAYYSXz3HPPt1qJczz81t1Nn0EHUb39nQCe7c1ol/cHYJpoB3frqVnVlLBzOIF3N96nM2tsB0Bhf1PrSpx4RodnmtfIlSykftPX8eroSqodxcunkf+R5phBIopj9SX5J92Wx5jHs9ew7MNx+v03Rjlkl7TIEnjaHgMV0filM7k7ndD0BwYIUeNdNSyJkZENJdfNanz0eoA261KTczESnokdveStQPuvO9SiSPWUQpd1WTWK+qdaW9cPIamSKLlEYa2aBmR/CU9dSWWDO2G5rG7cqbnb0AOU0+bYHvA/tot4lyh3b+YhaCI5vR9jm5AUO1qcKLLnLDxAuw3FOHpHAjQI8EXUnSd8UYTU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azlFcnJlLzhMUFIzTHFJejRHaUxFMlBoN29WWXcwTW9lR2ZmWDM2RGlsZ3Zk?=
 =?utf-8?B?dXo0UXl1OGlyM2xUR3ZtVG5PZnBvUDU1QmVQa1JjZ1Q3UU5LeS9nZ2NJcDdY?=
 =?utf-8?B?TEszb1cyV3Z0NG5CVjhpcFNodm0xci93Tm5FOG04Y3A3ZHFFbEFLdXVsREhu?=
 =?utf-8?B?VWhhaUpnMkY2VlZGUzlnV3FmZFc4TXJxZWZwSWZacE0zWU5NanEwT1ZZRlZp?=
 =?utf-8?B?cUFtN3VsSkh2V3VvV05RZE9TbEEvVVFHTWVkRFJWQXBGNlVzemRkMEthMDll?=
 =?utf-8?B?YnM4bi9FUkNlTkhCY2kwWEQ5UUM5ZDVpS2h6Q2t5aUZOTCticTVZZmo5NURR?=
 =?utf-8?B?T2NTWmpPWnpab21sejRXWEU2TWd0RzFxUWtEcTAyckVMQ0ozczRFUHFqbWMv?=
 =?utf-8?B?cG15eHZ0S3RLeGRIZWNrMStBbjFCZU81NjhFQ3Uxam9GNldOR0QwMlJOL1d6?=
 =?utf-8?B?YXVXa1ZGNWlxNlhFRlNaZW0rTkZVT0d2VUdJZWsxK1A1QXQwTjdCK1BSdUZx?=
 =?utf-8?B?ZjYvMEFnSkZ1RzhoYTcrVlh1QWZCSFI0M1pZZUdHTXpQVVY4SW0wdmFOYUwx?=
 =?utf-8?B?b2k5R2pHQlIxbzRmL09VNzBvdUhQNEJtakhwZkF5ajIwV1FnVFM4M016ODZK?=
 =?utf-8?B?QmFtZjd4QXd6RkVhMEdQdjZxQUZGUWVEV0txUmhWWnY3Z2NFU0V0bWtwZVZG?=
 =?utf-8?B?T24zV0pSbTRUc0gzYXI1T2FNU3ZWTWcyT09yY1I4dStWZVpNVkVINS9zd2hU?=
 =?utf-8?B?elZjbEhwak9aNHN0WU9yUDcxbFV6bkNnNHhLQk9YTWJUUXNVSDYxQ09Ca1Bn?=
 =?utf-8?B?NmJDVmM4dnoyUU0xUmtFSVB1Mm9hR3NGWGtLeVdZbXJTMmN2UkF2L3hkRVJu?=
 =?utf-8?B?L1A2c0hScXZWTTBVSGgzRGdqS3RQYk5hVko4WDVhNGt6eG45VGRZbGxKdDg2?=
 =?utf-8?B?MnVSQ0dUdGdBcHhEalJRd2NORkhhMHpFZ2lUTDRhampzR1FWb3FZSENabVAr?=
 =?utf-8?B?RnovQW5HNTNDNXo2bzROUTQ0bW5QbGNwSjRyVjNhS1NIU2FUZmxKNDhsczFJ?=
 =?utf-8?B?alViNUpxZkJBV3JzbkkyQjhQcUlzN1JMT05ibXRWRUFCaHhmZFl1eTFYU0w3?=
 =?utf-8?B?RUtuRkwvb242MnlVUmdYcm9jOEkzTGQvMExodjRsbU1Dc1JaWFdZVi9pNEZO?=
 =?utf-8?B?YUFsUFNpSHhQV2cwdWFpeVhid3J4bmJxWDc3dWkrZ2lBNjZPc3E2aU5xckR0?=
 =?utf-8?B?OGx5U1lyVURtV2R5WDZWZ2F1aGo4alNrR0ROS01BVWIybmxNVjZycXlsQVNL?=
 =?utf-8?B?THBOMWM0a01oYmgrVGs3UU52bHBCbG0xMHpTc0tPWmgvY1NiUVh3WW1VUThP?=
 =?utf-8?B?RExLSzNLYkNhWUxiVVE4RnRGcmt0K0RnaHpIdHlkN3NZR1dVTVdzSElvaStG?=
 =?utf-8?B?K1dHbU1pWTFaVU1POFNKaWxTK1MxZXdpR0xQNmdYZkNRNFNsdTZtb0k2ajBk?=
 =?utf-8?B?UWxoemhETk9KT25ETTBXNTZudm9Wall2YmJZaXB1UVliOTdnMkV4dmlWbmht?=
 =?utf-8?B?Z1M1QnFSSERzcTNuUXVkbDJWUmd3bmgxNWdCcG9GRjc1L1JZS1JBeWFUU0dx?=
 =?utf-8?B?OHlJTHRmRklVU1F3L1orN2JvT1crSjRTTW1BS0dHR3JFQkk3enhVRHlzaFBq?=
 =?utf-8?B?YUprOUxxd3hnNTNLOUJwSXVwYWdGM0ZQYzRkTUZXWHZOaHh5NjNFWnB6Mk5P?=
 =?utf-8?B?S2VKejBvNTBBN1h0MFljWkNKMWlQVks2d3BXT042UUN2SU55OWFkZW52N3VE?=
 =?utf-8?B?QVROSUdNL04vK3Byc1JWV0RBWFJvYTFKa1hBSTEvMEpaeVdHWm02anQ5M3dw?=
 =?utf-8?B?UXRtRHpvMFdQUzd3UHEzcnVybTZRYnFCQys0OFd5V0xnQlNaaGRZQmVqZzVG?=
 =?utf-8?B?UmwzSWt0NEdmbmw5TEJScjU3RjRibmI3Um93WW1DUVNXa1B4cUhpMy8zdHV6?=
 =?utf-8?B?VU9iVDZ5eldKaFFUelpNYjdzNzYxajRMQU9leHdUUHQwUE96dFNRbUxGMm5t?=
 =?utf-8?B?ZmM3ZWh1K0h2MW9IbXQwUytMR1I5Zk5xWkEwR3NkYjM5U29TQmF2MFFsR1A0?=
 =?utf-8?B?Y1gyVXJUdTNPR2h3WTZjdHJzZTlYb2NoNEtCQ0tuOVNBQ20vRkF2Qk1aazE2?=
 =?utf-8?B?VnVJYzZOdlZjcFJaTFVXZUczQXRQQXJBK2pLUmlDRmFsN1ZBUkUwN1ErRG1l?=
 =?utf-8?B?VnNFYXNCN2xFUWF6MmYzTjduaGJKRjloOVFwL2QzVk9pay9pa2c1OS9DeklF?=
 =?utf-8?B?T0hmR24rRDUyRDY1SU1vTHVPbWtXYUZCendPTEdHTzhhazl4UHVUUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31702ff-5730-4aaf-30a9-08def2fefe23
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 14:36:53.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wph8Xu/TyewCi1SZJgP0ySNQHUqOVAxgruTvU99I9RNJkYTMrCabrDXo/6+ll9XZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8870

On 3 Aug 2026, at 23:09, Kairui Song wrote:

> On Tue, Aug 4, 2026 at 1:55 AM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 3 Aug 2026, at 13:25, Kairui Song wrote:
>>
>>> On Tue, Aug 4, 2026 at 12:53 AM Zi Yan <ziy@nvidia.com> wrote:
>>>>
>>>> On Mon Aug 3, 2026 at 11:07 AM EDT, Lorenzo Stoakes (ARM) wrote:
>>>>> No __folio_split().
>>>>>
>>>>> Comment about cleanup.h really was the whole pattern of goto xxx for various
>>>>> levels of unwinding things.
>>>>>
>>>>> But really I mean the folio splitting code in general, there's a lot of
>>>>> massive-complicated-functions with a million things going on at once,
>>>>> __folio_freeze_and_split_unmapped() is another.
>>>>>
>>>>> Feels like we should really have this stuff in something like mm/folio.c anyway
>>>>> too now that's renamed :)
>>>>>
>>>>
>>>> I agree that __folio_split() is handling multiple cases, anon, shmem,
>>>> pagecache, all together. Do you prefer:
>>>>
>>>> 1. split __folio_split() to handle each case in a separate function with
>>>> some code duplication, like xarray for pagecache and shmem,
>>>> freeze/unfreeze folio for all;
>>>
>>> Hi all,
>>>
>>> Do you like a __folio_freeze_split_unmap /
>>> __folio_freeze_split_unmap_file split? :),  I'm asking this as I'm
>>> currently trying to sort up the mess about swap cache in huge_memory.c
>>> and found it will be much cleaner if we move file related code into
>>> __folio_freeze_split_unmap_file, and let __folio_freeze_split_unmap
>>> handle anon and swap cache, and then saw the discussion here. (A bit
>>
>> Sounds good to me.
>> Maybe s/__folio_freeze_split_unmap/__folio_freeze_split_unmap_anon/
>> to be specific?
>
> We will have to deal with clean (not yet added to anon) swap cache;
> I'm not sure if that counts as anon? I'm fine either way about naming
> though.

Pick the name you think makes most of sense. Naming is hard, we can always
discuss about it when your patch comes. :)


Best Regards,
Yan, Zi
