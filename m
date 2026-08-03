Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7740DB2F;
	Mon,  3 Aug 2026 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785769947; cv=fail; b=bHMiLWnva4DXV1JIooPU1pUSLMbH3axv+ycFMWQ2whTY8HwXHGzWofv/F6ujpTIqFZn4dHtA3G0rFwDDEBrS/p7atmm5C8ZC6ZDL20CjK0j4pprLqz9WZf0zGsaOIX6wWTLCkY1nVBGWCvgNcHkIM5hWnEvhz+HVOURQuhr2NiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785769947; c=relaxed/simple;
	bh=QZd4JUgkMhKJlRR/SF2f3wldeyEguo3jVqNFBzvIZkA=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=PyxlQsSUmjV0cwQwngHk+mwJlh9ch0qFE4UmV/MqQF/Q6BG7qcDTVUj6MXIxO0OJzt3+Ny9RxQsDn3ElRkTqQkea4tQJhoN6FenuD2rVo+QPY1V7ZDEaEs0610C/OTvPw7riDEZxhOAhpDgGl56waE3QjyzqiZn+UXvLOqFS9bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pMsnPlZU; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pMsnPlZU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5vuR1jJUn/gaVAf2xxYvwnBGJvM7ERIyTOLsMOiMUGz1SRRnP+knRyqWSoVDeWgxMFZ5somk056jkfQVsQNc75+SKWvK4f9U37xmSd1X2+GLSq9ilahutViwev1GK/H08aFsX/MV8NqUXhmqZeJzUF0u7tMKWQNDTaNuwuGrrpB3nqR4kGTna/OpAHahgNBwNRuKoZDnnRCR/tzS+EW/SquOeqPKmpax7nMAmyfnbeJHjoc9n0gWtLoU5+7PvuhLBTAQ6e1bFG1nswwCI8f6GEuSe3PLsvdk2KJM6UXCdw3AxLrSprM3fuuF5oFKEIhEqbwAlpOr+Y63F0gL86N5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APxF5AxL9bzAk2/0y3lcoCL5UH9KpeBUg+hdha/6jLc=;
 b=lbp7vfzgA91ost2RbUtsxGKiCtVMCPKp1KGshZd39/V66Sy0XMfy3fIlb661+Ks9ZugKvjZ3l18mMPsVoE4/yQwNXQTHSVieYSpSzoSI8wWiBU3mtWKxpG+dOFWwtS9ED5ePOoYL/QYWDOcCfO+wOTT1xcaBzSlSnimPInMekXCyOkjlijX8mvh8pZ1LytAvmwKapQkgyk7KnIXaj8HL27eYy6/vrBt3X6Qj8U80b9p3o8HcStyZi+5ifpQTSru/wgGNpJlsfyFaYiQ92okcDrKr5stIJK0B2qXxYdEHmowlzW3Ez3Jx/cVEMREi9LCa2yDQMKyRWJ/Z5MWQnyqIdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APxF5AxL9bzAk2/0y3lcoCL5UH9KpeBUg+hdha/6jLc=;
 b=pMsnPlZUR74h/vu8NovvxAFZ55sYhH1UMjaRL31qwkW0WbOEIf0Jwm8qkrONGhR5JnRlrpiubobnjyIH9pOlDyj+NAAO8v4ZJniNBoc46OmGKzAjbUIxjtet/zPgONgiKNDmTLFspKGh4I/tCyMoGrlxDDK+D1mdO0eQPjgG+tinypv3AcFu30N9W0HB5fcLWMMJxXJ7b1HyRrG8FED4AsCX8qY5dDNT1eNenS8IhF+BrEp/HRFrNkZ/cuOp1781+tXccrIQuH6eeZImPFIUy4VZ/3MM8H+pjm2At0PLjm61edGrvfKwrYjynV5HUt8AiJ7ZttMbHRtlm6SUbPczGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CH3PR12MB9147.namprd12.prod.outlook.com (2603:10b6:610:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 15:12:14 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 15:12:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 11:12:10 -0400
Message-Id: <DKFELWPHSJNO.3GGVW270HENEG@nvidia.com>
Cc: "Johannes Weiner" <hannes@cmpxchg.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Matthew Wilcox" <willy@infradead.org>,
 "William Kucharski" <william.kucharski@oracle.com>, "David Hildenbrand"
 <david@kernel.org>, "Baolin Wang" <baolin.wang@linux.alibaba.com>, "Liam R.
 Howlett" <liam@infradead.org>, "Nico Pache" <nico.pache@linux.dev>, "Ryan
 Roberts" <ryan.roberts@arm.com>, "Dev Jain" <dev.jain@arm.com>, "Barry
 Song" <baohua@kernel.org>, "Lance Yang" <lance.yang@linux.dev>, "Usama
 Arif" <usama.arif@linux.dev>, <linux-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v2 2/2] xarray: honor XA_FLAGS_ACCOUNT in
 xas_split_alloc()
X-Mailer: aerc 0.21.0
References: <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com> <20260730-add-gfp_account-to-xas_split_alloc-v2-2-5a56c2361d85@nvidia.com> <am2-HmShC6VXP_-G@lucifer>
In-Reply-To: <am2-HmShC6VXP_-G@lucifer>
X-ClientProxiedBy: CY5PR18CA0026.namprd18.prod.outlook.com
 (2603:10b6:930:5::35) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CH3PR12MB9147:EE_
X-MS-Office365-Filtering-Correlation-Id: b574c18f-e2e2-4f4e-ffe0-08def171993c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	y/gXA73WyImIa9rVYpWgJgyYmsfdYtDLRaISl4u2vQQnmBbVFISZYxsIiqgswqXHwZtez8TfRo65xwRFYdvGjCZ9w2usIOf30iv+2J5OgAEnOrLPGR8/0tE4VAlEKAV2bGMmCEk+fqsmtB4q/t+RRQZWedrNkk7xWN8p0IxD350Er1SdGo20pAAaG/vgaFpbqshXhP5sQqJZ0ADRAKkefo9OyNHvsQZp5v7ZbPW4pEUv1ibSgcaYl5Bav3zT2FkFNYHko4U8BtmHrAIsapH0iCS2KP3hqeNwZCG4YWS4KXXEGtw06CM/TWmFKnqckVQd+x9KCXicdREiUuDd+B51PO2A2tSzYbSmPtVeC2tp0f5adgJjSpi/SkgeW5cHkhBtU0Kfanjz+0A5J/PxOUH+9ymZf9cywwb926LXjjR/1Ie2UPBbav0qHVUH5IxJRW58048fznMazV1eKowg3yoaOFu28nMww/zSkU+QyxZyQV/EHFeALk0PAbGFUGyU9nj4h503o3xNStX58aackGgUeqk7LplTtdDw9grd2/k5XmvddF8hXhWkITrFP5UANVXwqXA4DcZmL3O8DfeacChwihW1AeQNZzBbqZj9dxbjeyZnvdDwXgbkzHYcxY43O6M4XnY8pwCDYy1btghJ7WDyC3mQF4Ul/bLVbzUS+2XqMOE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmNkeHM0OGJ1QzFjaGQ4T2hBR1V6eTR5VHNhTlVxbDN1bEFDT09SNDB6WnlS?=
 =?utf-8?B?aXJEdW5JT0dGOWhUM1N1Z1A1NjhlNGlTbE5ISGhkTmxDdGhJK3NEcGpPenJV?=
 =?utf-8?B?OHpzZUFtWDMreGtXWVRrSk1hUHN0OUlaWlV1SlVMLzRTMm5Sd2lpWTdiTXMy?=
 =?utf-8?B?VCtSdFhyZHVOMktpQngreG1PVFBpTXJaQzlpd3hNTWNrQW1hRzZzdXVyOWI1?=
 =?utf-8?B?RzE4RUx3V2VhU0p4NGpXVEliNDlBeWNKblFJZVBlTzlzL2Fxck1hcHpaOFFn?=
 =?utf-8?B?azVCSnd0SkdmZFJmMVhHVjlqZnc2b0s4M2VBd3BROFBBeDE2d3ZFS0ZzU3NH?=
 =?utf-8?B?YXJJU2owc0grUmlzOG1tcElZYU5nN01TYVUyWkRlL0NZL2RjK2s3MS9YRGxS?=
 =?utf-8?B?akxISHo2bDNIcm1BZkpYL0gxWHRJQ0VCa28yWlZGQVJ5ckNad2tyaThxUXUw?=
 =?utf-8?B?cndmV1BJWTB0ajJGajFubTh0MjZaMXNtNXo3WTJCWVoxT01MZWpFajBuaWhN?=
 =?utf-8?B?UThoTkx1cUh1V2RCNTJ2aDdibStXNU1wK09kMkQvNGo5VTZHcCtkU0VoTHNp?=
 =?utf-8?B?WnhnOE81a0taRkhTZUZWNm1ZVXZDY2pCamIvN0dwUGxKMDJtbDYycE5QV1RN?=
 =?utf-8?B?WTFZODVzVlR5TklRU2dOZFRVWjdFU2J3NHF0ZGxFc0V0T3NTOUZxZ0JMUmxq?=
 =?utf-8?B?b2lVbU9RVXVCSnFIZFdaUTd0a2pIWGJsaVhHQVBhTE1nLzRSOHVZZGkzREY0?=
 =?utf-8?B?WVNRT3drSHVSWkpFQVNaamVKaTFaajBHSmF3R2kycVc0RVBWenZzeW9xNFRx?=
 =?utf-8?B?WTIxR3ZwdDc4Z2NZNGFMdndMVGw0ejV5aVBPeElMRlYwLytzSkg1RnI2OXp5?=
 =?utf-8?B?K2hTaDJpbC9VSW5rQTVBL1o0Z2ZPcWFyTG91ejZENHpDbHJyaWhIbjBUMW5j?=
 =?utf-8?B?MjV2SHdMODI1dXo0S0loODBjNW5WeHFzMXpVK0hXdVpVbGdjRFNwMnJhT2o1?=
 =?utf-8?B?ZVByT3Z6N0h3SndIbSsraGFwVERXU2phWVlsUlpzQVEvNmJ2WkpTRXNoWU5P?=
 =?utf-8?B?MUJucWtwSVBybVV3RFJQSmNLdDl6WHhDNnR1MllHVzErSTRrQkNqU3JGWStG?=
 =?utf-8?B?L3hReXdKbEw1ZlRaSVN2S0hmdlRFOVJabUZydHo2NmVsOS9taGdPMWdtQ1RB?=
 =?utf-8?B?UkVIV3V4NHhxd0ZlM1VnSzRSeTBoWUV1b0pIL3hmanNPWGRBL0hJUzFIbnVy?=
 =?utf-8?B?RW1pSEJtK3BBeHRFSzRyVmRNeFE0NmhWQTMzdEd1RWlhTmcxODc5T1A1TWdi?=
 =?utf-8?B?WkNKUW1leFlpVmZHRC9FK0NOaTY0Mk9CNndnTTF4NXQwVHBNSHNZYk5LdE5w?=
 =?utf-8?B?UmtQcnZMVEVLVnR2NnlKVlVJOW5MNkpYUjVHQ1pldkUrSjZGME91VE9ZcE9q?=
 =?utf-8?B?VkxHUjdHMXVyV0NDa2RQVmR6N1Jic290bjBQZmhxbzdsbDFDTE92RDdvaEpE?=
 =?utf-8?B?Nlp6Z1ByMFZHYTlqNE1FT2FEZVNDUUdPTWswZ1B3cE9iMjFsb0pialIrUzZE?=
 =?utf-8?B?MDhTQVhvTWZ4TURvMTJVQmxYWjU4Ti9kcCt3YVlqZEFkNXhNVlhJOE5yOUow?=
 =?utf-8?B?TExBaTZyQmZLYWhldlN5SnFiYlVYeE80dmdkTW05cGFObHR6UEJLWFEzQzBK?=
 =?utf-8?B?OCswZ09rVWJENFZ3R2VmNDA0K0F5cjlraVByR3FCQ3pwY280NVZiUW1QUkhk?=
 =?utf-8?B?YllDbEdrVVdVK2h5ditGQWVINmtXdndoSjduT0pZYjlQall6QXVaQzR0cXU1?=
 =?utf-8?B?UFd0QmdhY3I4VnlEbCtFQzVZaGdlT05SRDVoMFJISzNIeGdLUVJxemVneWdi?=
 =?utf-8?B?ajlDNWQwemVkaW9YY1A5L0xuNUprQUFuMXlydEYva2grS1h2UE9NMEEyTE9E?=
 =?utf-8?B?NUQ4enB6UXJvMFNkSzlXSitGSjM0b25mTFBTQUQvcGhIeWF5N3paaFV4eURk?=
 =?utf-8?B?OFk5c2Q4dG5ueVNZOHhpRjVjZVJXZ05PSWUrODJRV25laUFzNllSOGRUMks4?=
 =?utf-8?B?amR0eEp0UW1HVm13MUpOQkplUm1BbVN2UjRZbXM2YzBBSURFeXhGV3VDdXRv?=
 =?utf-8?B?T3lWSUpOSER1eHBqRHozakRxVngrRUs4RjBMWktWWGdWa0RoZHU3bExvN25q?=
 =?utf-8?B?SEpoNm1yaXdxMzZTRnRVdUZwNnZYQ0NZT1RtaVBPcTlaMzFVcFRWdHA5TjVv?=
 =?utf-8?B?ZHplSmI1U3BGVkx4WTh4eTVmS1k4N1dEa2lJZ3N6TVNHSG9DclhTYUcwRUJl?=
 =?utf-8?Q?PnxDfNpRXFJJOabh/n?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b574c18f-e2e2-4f4e-ffe0-08def171993c
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 15:12:13.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qq6SHnCJPZ0jNul+DJwJBDxyylX1RzStpscqh0sOPH7YSkXbLQ+41jCWsZxFlDEx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9147

On Sat Aug 1, 2026 at 5:38 AM EDT, Lorenzo Stoakes (ARM) wrote:
> On Thu, Jul 30, 2026 at 10:18:01PM -0400, Zi Yan wrote:
>> XArray operations that allocate xa_nodes, such as xas_nomem() and
>> xas_alloc(), add __GFP_ACCOUNT when the array has XA_FLAGS_ACCOUNT set.
>> This charges the allocated memory and avoids the workingset convergence
>> issue described by commit 7b785645e8f13 ("mm: fix page cache convergence
>> regression").
>>
>> xas_split_alloc() does not have that flag. Add it when necessary.
>
> Nit but maybe 'split' rather than 'have'?

Yeah, the sentence is pretty vague. How about?

xas_split_alloc() does not add _GFP_ACCOUNT when XA_FLAGS_ACCOUNT is
present. Add code to do it.

>
>>
>> Fixes: 6b24ca4a1a8d4 ("mm: Use multi-index entries in the page cache")
>
> Cc: stable?

This should go along with Patch 1. So if we decided to backport Patch 1,
I will Cc: stable for this as well.

>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> Makes sense to me so:
>
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
>> ---
>>  lib/xarray.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/lib/xarray.c b/lib/xarray.c
>> index 9a8b4916540cf..bfe7bef80f34e 100644
>> --- a/lib/xarray.c
>> +++ b/lib/xarray.c
>> @@ -1053,6 +1053,9 @@ void xas_split_alloc(struct xa_state *xas, void *e=
ntry, unsigned int order,
>>  	if (xas->xa_shift + XA_CHUNK_SHIFT > order)
>>  		return;
>>
>> +	if (xas->xa->xa_flags & XA_FLAGS_ACCOUNT)
>> +		gfp |=3D __GFP_ACCOUNT;
>> +
>
> This is some confluence of flags :) I wonder if there are other places we=
've
> missed setting this for?

I did check the whole lib/xarray.c. xas_nomem(), __xas_nomem(),
xas_alloc(), xas_try_split(), and xas_split_alloc() are the ones using
gfp to allocate memory. Only xas_split_alloc() does not add
__GFP_ACCOUNT for XA_FLAGS_ACCOUNT.

--=20
Best Regards,
Yan, Zi

