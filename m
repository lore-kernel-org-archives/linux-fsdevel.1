Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011044.outbound.protection.outlook.com [52.101.62.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B1841CB56;
	Mon,  3 Aug 2026 17:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779748; cv=fail; b=ko5AE/SYI8C3awjBgGREbDSMxyBe6IFADg+COkkr+w/yNICJnXFP4i1CUuNxGIQuK0wamKUHpnwzTm0xZChQUv0AeK7fDVNFqpMUIT1o+wHEJZTPmdMRayTqSS0EDsdHAs6NETU47sIWIDTy1HigJ2cTY7yjXNFKrRjEmz119bY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779748; c=relaxed/simple;
	bh=e117iEoAhcV9jixn5DCJBQv8zY1jQIVod7ZzLIcOfIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AjyUV++jB8eUGJ8DvmLrBqDJkpNJg/0RmDJJO04ASXmW5hjfaCIOTp46SeiZVj0DJKt+28eWvsMkAi8VUnVe3c20jOB/yC87B3r2VeyKHpAHswo8hvoOSA/oLVyZtk0tCZfyydkv1KOJ26U5FldHRWsSqzwVVIqecAqxlzoDjfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q6vo5242; arc=fail smtp.client-ip=52.101.62.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q6vo5242"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wg/YwywHnUfx5ROyIPbyctSh5+Q1efGSWBJZz5nfvF54tgLfbaP9ocKmt4ng0rvVP04+TweQX8sgC3ACUKwzOvaWSmcZ3jAe46tSKRUgdMQiE6gYH5Rvxq3/5dr2VzqBYDktNgKpg+BpmXZZWGsXvZQV501452pcQfuyUxOEtOPmQhKqIfHFhZ6jd/36iOp5TkK5HKHgMTGo33oxTz5zUq74ZwYfNPLuIhfFDIs+io5kHmIvQNWyK1qEI/DofVo6PirpmFSZ83V3Zaeydwj00EIIEV6t3nqHhvBD4EoYJMGZ1CW9pDXhPe78hBsjYY+LSNusiKxPPdRRLfIPqgf75g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECbeD0ihyg+EEX6ZY7MvMwOUN7Ib1i4495IFUmM0Qfk=;
 b=r6PZ5VmhPenR04cObJ/C6YD9ZIPmWcs9C+zwULY7jAFnRxL9j0g3pATA9mLXdD3JjFYFkorcR6gPYPNEFkAWyLpOmRn5ojjh+9tM6+5t78387ZeUNaFafSBfl84QoNUGH/k+R7Ji+fcwuVRZMAYb1cwW90GRZJ+hbuImlP1z9NHGlzP7z+U7UySiX+NMo+WgI3iLkl6E/BcJZ1LQkIgk3Dv+UDdI+lt97hk6tfY0DAJ9gB0YDU7iy5jhjHGQRZBXGIYbIshVCKU0rUeDrOL38MDPl5ElI+KgvMJgw8872G3cIwmLq6GZUTqb2uBBCeldBquvuCjoH9v3XWvdmw86Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECbeD0ihyg+EEX6ZY7MvMwOUN7Ib1i4495IFUmM0Qfk=;
 b=Q6vo5242YWSa0BoSfq4/qhzTmPRM5IBa6I4FqV2lKn2bISNBiw5FwbyZOzmnRKq832215PWfc70TyfLmFoKbBKVSQoUOVvJlhzyxYlIbbP3uvCmifz04FSS86pGdz1LnlNL+NB4mgsvGCkEREt9FWRXHZ8QgtVIY6mO22hZvKjKiSgR0cTW5vWlUvpvLWwWsJ/jSvEoQTQ9wpw575/96R1DvY1r1ZyE9+UEDEmSr91wI4Wyyz9iEUKly51xzkKcmqX1m9DNULgDL3LoRxTSlZO5H0BQWGbLUkNsfWONRRBkyJ2tP5hclJH4OtW5hpzOTnxFsWKNmED9lZXr/bVX+uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by MN0PR12MB6223.namprd12.prod.outlook.com (2603:10b6:208:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 17:55:41 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 17:55:41 +0000
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
Date: Mon, 03 Aug 2026 13:55:38 -0400
X-Mailer: MailMate (3.0r7024)
Message-ID: <D6EE6133-8B15-438C-8616-4639710F8973@nvidia.com>
In-Reply-To:
 <CAMgjq7CHDG8JhesSPMkn1kzG8jKb0BXO756BvxMQC_MCn2eTyA@mail.gmail.com>
References:
 <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com>
 <20260730-add-gfp_account-to-xas_split_alloc-v2-1-5a56c2361d85@nvidia.com>
 <am28pV2PEfHsi4p-@lucifer> <DKFEEI2EDS4F.1AHGKB1EL6XRG@nvidia.com>
 <anCtxQE5hDUH5N6a@lucifer> <DKFEUPDED2AF.22PKCFTWTG6G5@nvidia.com>
 <CAMgjq7CHDG8JhesSPMkn1kzG8jKb0BXO756BvxMQC_MCn2eTyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MS-Reactions: disallow
X-ClientProxiedBy: BN0PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:408:e8::21) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|MN0PR12MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: fe8dffd6-f556-4082-bef1-08def1886ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	y50MYpjHVBKFJSse2+iXkNITZb7rOleEUR95WTejh90pDoj9BM9q+t55zbzdS9VR66CmVBuHFD8GyauQi+pLJMnTT5Wt+IQ5/ckcnHAZ3CsPBnrVx9Aiek8h9mU5o7nFEgWJUtoN/2ECzQBea7S2GqZXMoXCtYrfNP/34xiB2ALrnQ/R3yJKPiZCJinlbII8+HlEwFkjvAQOr1ZbSlwGgKXJ9OnHHdDNjyUESBnqm5EeMAf7kzR3VfrVG0M9FWpbkVlS1EfGJ2QZDamDlv5DG1IdqRSSV7z+m81wq/b5/xi4sqG3O3ryPc1Sn47axjPGe//ukxgMatxz7X89oO6DsZNK9AKcVKZ6+g8eVlxX+w2/S7fF81y3RyXdkQCpKzCS7gLwq/KvZpkYBVzo8qsBN7XXBRc6vdKd7o/kgSvYRo41o3lqrD8JZCwYr66teGrBjNVwHnnjqyeN61+fuHrCliUF7xKmmd1Q/l/s8jDicdf2TveBpgNFCfcii6anlfsj8ZpnWfc90nAVf3jEnJYZkyqzc1e954iaN53QxavMQc82V2vGXXq9gQPc4MudEGXdxfSLEEfYi3+4z8zfS6PygMQ63OvdvFB6iFBUY1lh3Kz6Pm3ySEfiJ/XR+VcHIDiWk/f/IlMsflpeWC413xhDV4vMJv2nemstow2cXUnieOg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2dJR0tQWTZ2NG8rNVc0Vm1HSjJLNDUrN1lobElTbjdncWdwOGQrcVJHSzRq?=
 =?utf-8?B?YUU1cDZIejhLTThwSDZDOEpOTFArNnJkTmNhUXJ5WFd1cUJVQVhEcGdwRld3?=
 =?utf-8?B?VFZZZVBpQ1BzWlpHRVY0elJwMDFwaENJb1RCM01ZempLTVZ2ZkRoNVJVZEZQ?=
 =?utf-8?B?ckN6MlNXcVcxYWYrc3UvWHRzUDVJRGIvVFZxdEhVOXRJWmd5SkV1OW9aQk5o?=
 =?utf-8?B?eHBBbTk5Z09EdUUxYTJpdW1Ca045R2Zhc29nUDIwckFZV0ljOTNNODd6K25s?=
 =?utf-8?B?RTJpOGsyVXJBWWJnR3NnUStSRkFHT1c0ZUEwUFdRcmF2d1cxVHh5WHZnN1c4?=
 =?utf-8?B?NlVYTnh1UnJZYUFWVnlaOFNtdFBMV0lKREdDMEswdDNPdXJCMThiY05JaU94?=
 =?utf-8?B?QUtOSVJ2bkdYVFl0ZkszM3p4WEJPcVpoNlExNlpvN3I4V3lSVjNWeHhFVFpk?=
 =?utf-8?B?S09qMnZPaWpGNnIwdFk4ZUNZd2c3WHVkL2FMVXR1UnVpK21zdVpibVBuMlVP?=
 =?utf-8?B?S21mT0lmanZwS2YwMytnYjNNNnVoSk5ENDB3RDFMY0tNVFBoL0V5bG9hcnlr?=
 =?utf-8?B?YlBtUlVvSnZpZmFPOGtxNWk2UnFPZGp4TXp3TTJjazNGaFVFYmxyWTYvVkh0?=
 =?utf-8?B?RlcveG90c0pDTk5yd2pDQ1RUQzVUWit4RlZNdjRybHBRZDNsNXYyNmEwTW1i?=
 =?utf-8?B?MmVUeTBRbEt0Y09JTllGYVFZQXZvSGsxTVUxNlN0bXhBYkVzV1JmREQ0U05n?=
 =?utf-8?B?TUUwM2RRY3N6aGFnaHkvbzJ4ZThNeFpYd0p4QS9LbVlQZ3ozUS9XTU93cTJ5?=
 =?utf-8?B?MVJYbjNTVjdDd1NUdmNwQmJuUXVQR0ZYOHZGK2Q1eEg1Y3k5RG1pYU5jQWlR?=
 =?utf-8?B?eUt0QU04NURnVTE5dzM0dHJlT2dadVRUYjVRd3pPblF2YzVRN2NQMFdEcHZC?=
 =?utf-8?B?c0VJVEMrOGpUck9yZmQ3RTVqRWNUYjNQb2t3aWFtUGZ0M0FEemcxRElGRzI3?=
 =?utf-8?B?OG92NU9qek9SYjVlemx3Q0IwcEZnMHhQTlFzcmNvWlZ5MC9PRTkra3BPb0hC?=
 =?utf-8?B?QXFlYzc1S3ZucWE4aEVIL3hLcnRPdmRyL0NrSWhXOHVkNGlJZUFFaHpGV2tE?=
 =?utf-8?B?QmFId3ZZTC95UmZvcWROL1ViTmhRZ0N0bGw0K2xQcExpMzZUemk5WHM5ajRE?=
 =?utf-8?B?Z3IwREtUV2VpSU5PYWN6by9Ca2h2L0lXYmNRaEFwT3c3bEIrNkcrZlpLZFp3?=
 =?utf-8?B?d0dxUUpheGRCL2daeStucFlBT0xxbmZBc0FCKzhhbEhnRTUwZFl3MFRyUWE3?=
 =?utf-8?B?dm44emdFT2ZtOXRkRlZQUnBxcmNMR3VTUUxBV1E2eHJSN2VSUG1QdE9hVDZR?=
 =?utf-8?B?Ym9jYThhSFdwR3F1WFRHRUpKc3BIYTRDTWl6TG4rdnlpK0pHa01jVEJyTzRp?=
 =?utf-8?B?VmJkNmJVTWE4V0pmL0dPY3pVdExzdWpJWWM0MHM1RUZWU0FZMCtYVUZ5bFl0?=
 =?utf-8?B?MnpXdVdXbkNGZ0xlOUc1TW0xd2FPZENIQWZ4TTM4U3hZZm1sMjAwTDVwNEVt?=
 =?utf-8?B?Q01VWTRGNVVBVjdtNUxOU1hLSW1wMW1yR3BEUFZRWVhMa0RZQW1oYWxQbGxW?=
 =?utf-8?B?T2hNM2o0SmZvR09Zd1FTNnAyNWZiWHloTlB4Vm5zMEQwbWxIc0NPZkhKTWZm?=
 =?utf-8?B?bmo3WjhFaEdNR2RlMVVqa2JReFM1OUlnYmlCWHU5YXBBbllKU2ZpSDdOMFlY?=
 =?utf-8?B?aDI3U1BUVWpBYnoyYU9tcEN2Wm42WnJOd1Joa3JOOVA1emxxUzlrS3I2V1I1?=
 =?utf-8?B?RWtwck14a2JOY2czd1YvQzlhWC96WUVDY2lNdVZOWGt4OWlzVE8yNUtSZ2lL?=
 =?utf-8?B?c0tPYWpPa2hYTEh4WnZKZXYyOVF4V0pSYVVyWmdmK1NMVlc4RDJXaDFkWnVy?=
 =?utf-8?B?ekhRd2E2M24vWTM3SmhLS2t5bzZnZEEwSDBUQXRwZFZNRmRYYXlzOXpnOTRY?=
 =?utf-8?B?SCs3ZFlBMDdTTWF4akdndHlNOHV1ZkxTc240ZjdSOGl6L1ZHUjNIZWdDQnk2?=
 =?utf-8?B?UGNoT1V4alhyUENzVERIQ1hXZkppMHdwQ0piY2R4MklTNWNCMEF1L2l3MDQ2?=
 =?utf-8?B?R2lReFlWSTZleGhEeTlDaGpzY0JUTE95MEx5clJubVNMQ0Zsa0RyU2NqbVd6?=
 =?utf-8?B?UDg0d1VKRm5icGxkUC80a1dxakxHb0VjdWdoeVhDSkU2WEZ1VllPYkwzVHRP?=
 =?utf-8?B?MXlpRWpjUlB2am05TG9mbHNlU0pEZDZsanZpUHRkN1ZYUitBd3hnaEo5YWx5?=
 =?utf-8?Q?NZyqIBW9mZGj1YVwaC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8dffd6-f556-4082-bef1-08def1886ef5
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 17:55:41.3932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPw/4d0VKZgLJzgzUCbwM6ag/wdSlGX8k/D4IgoWy6gKX52NbP7Y5yfGbhj41X6a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6223

On 3 Aug 2026, at 13:25, Kairui Song wrote:

> On Tue, Aug 4, 2026 at 12:53 AM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On Mon Aug 3, 2026 at 11:07 AM EDT, Lorenzo Stoakes (ARM) wrote:
>>> No __folio_split().
>>>
>>> Comment about cleanup.h really was the whole pattern of goto xxx for various
>>> levels of unwinding things.
>>>
>>> But really I mean the folio splitting code in general, there's a lot of
>>> massive-complicated-functions with a million things going on at once,
>>> __folio_freeze_and_split_unmapped() is another.
>>>
>>> Feels like we should really have this stuff in something like mm/folio.c anyway
>>> too now that's renamed :)
>>>
>>
>> I agree that __folio_split() is handling multiple cases, anon, shmem,
>> pagecache, all together. Do you prefer:
>>
>> 1. split __folio_split() to handle each case in a separate function with
>> some code duplication, like xarray for pagecache and shmem,
>> freeze/unfreeze folio for all;
>
> Hi all,
>
> Do you like a __folio_freeze_split_unmap /
> __folio_freeze_split_unmap_file split? :),  I'm asking this as I'm
> currently trying to sort up the mess about swap cache in huge_memory.c
> and found it will be much cleaner if we move file related code into
> __folio_freeze_split_unmap_file, and let __folio_freeze_split_unmap
> handle anon and swap cache, and then saw the discussion here. (A bit

Sounds good to me.
Maybe s/__folio_freeze_split_unmap/__folio_freeze_split_unmap_anon/
to be specific? I assume shmem is handled in file part, since you said
below shmem in swapcache is not worth the support.

> more detail on this, I think we ca just assume we just don't need or
> want shmem swapcache split, because shmem swap cache is meant to be an
> intermediate state during IO, and shmem drops swap cache once IO
> compete, and hybrid half-tmpfs-half-swap state is really ugly and
> should be avoided competely, swap cache lookup is still fine for shmem
> just make sure the folio is not in shmem's mapping).

The reason looks good to me. Can you remove the shmem in swapcache TODO
and firmly say shmem in swapcache is not supported due to the above reason
when you split the code?

>
> LOC seems lower with the split and swap part cleaned, they really
> don't share much logic anyway, except for a for loop for putting the
> splitted folio back to filemapping / swap cache, and a folio freeze
> check.
>
> And after doing that, for swap, splitting clean swap cache and
> splitting swap cache to higher order are easily supported, a few ugly
> checks are gone, we can't do that now partly because the code there is
> really complex.

Looking forward to your patches. :)


Best Regards,
Yan, Zi
