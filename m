Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34F53CCFD8;
	Wed,  1 Apr 2026 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051624; cv=fail; b=plSvnd121RcMF5tcEi9wiSOQEueBpdpVSrxRXZ8xLE7VQJRLlPunTORvyFk/nTV/VYiExS/4NNq4VA4Thw/itNKk34153pJcWVUp7/Y5pkZNf93khJLJDaA/psw4QyJtIAmI8ZgqALVlSPXUS69yTbksG7FU9pfZPdbkJbkFioE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051624; c=relaxed/simple;
	bh=s4jj+ETLd5ZbjrEMOG8ZqTkuROeoMSrxmNLxxM5VMVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bZFHKNLygqtXCxzZhW5Mhm3CIOR3ZBxATKlPe/1TFkpGzbxsSCNxzo/blJxS97F2VBKbyAW+nh7xdzOaDRFv3iof5+7l+esJqs7Ct8tbErtWfYCzvVNX8vpzPrlN47dHW2tzyFdiSROCnUhHmqKC0pbEmG51hbV5LIu7vZm6MFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VzZemszy; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VzZemszy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Grc7PQl8KhgaHqhJTyojQZrq7GiHlu8N4iCANpTz8nEvV2/k1/Ax09f4civrK4B3MmkaZqQhVUfzFZ17n+megiTowDPpYl6VXCEQd3jzFk9lu5DZHiefT6j40D8egVNkal5kBb2eEdL5y5PQGyKM/h7EhNIW6iqAyB0ktacAJz6diC5yVbJLB7Qp2veiMqNCCWtrhs45Sww1iMQPzi/ZN8t5RGuEEO9EL3Vo1SDtjbXoe4t7B3gNwtnCVabpgd9gWmiSRWCF8UmVLGHAGzoTNdmLZzfs/yzqylsN8Wtc+9u+z3r++PhxxOQvRtFfqpqbSyHtAA9pUj9+17rfquvLiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hyqzfmqw+dAicH+66h4KudrRgu5Fv7ulLTjFAcD0J60=;
 b=cqfLz6wh1sSWFcWyPuculQCWfHK/NNrUEtozaYYz7wLQw/XOM7YS4iqL/m52akkj2ttI/xTnigSROiOnzcfFiyrkFuEHQV5NH8dnfflh0xt74SwE4d1idtG0oRfK8YeUqTnQ0Pp+0Z+UmMXyXb6KSHtNC+KhO/kW26WNBkT1uT6rljbuXFQLnFeshJspp8Pp+EYkOstwNbuaND2pTf9+MAWdpfVW65Tu8z+4kxJ6ImiuRWxlBrgzhvq5UkliEBLY34owHZmKB2cff4ga9W29ka88Evgzak7Xk1xrVSPrJCZd1EG85zMprPbvH4vThuOwE1BDssbPK8rI3bYGzXH+uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hyqzfmqw+dAicH+66h4KudrRgu5Fv7ulLTjFAcD0J60=;
 b=VzZemszyPZwbaO/HEBSp8liwv46M+VRWZHZKhbGb3HXmZyiySMEy0RfJzGIdhPhy17mC6LUjFi02JDgkWyTSYNYUaVjT4ZuiZcboEDB0KFbod6K92wvl3akNkkL7yeVSxvweGd+pitp5RO6P6byybP+B4W+FWa4gQxOtePNJNu/ZjWqTOB7p9WZ3NM00bCEDMCEGVINUaG06CiPf6vZT0ziTjfb1KJI1XZFOtcX/BpWx42rYKXbkvWvRkqcUGpEXU7IW9ukKR1GPuHFf6rQPlhiqx+Afc047rxGzKdPyH+Dvhw95rYZwmMwnpqgizmKe/14gvVMuZEKniQeitKJ6zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS7PR12MB6335.namprd12.prod.outlook.com (2603:10b6:8:94::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.15; Wed, 1 Apr 2026 13:53:35 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 13:53:34 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Ackerley Tng <ackerleytng@google.com>, willy@infradead.org,
 akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, michael.roth@amd.com, dev.jain@arm.com,
 vannapurve@google.com
Subject: Re: [RFC PATCH v3 0/2] Fix storing in XArray check_split tests
Date: Wed, 01 Apr 2026 09:53:30 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <79ED6AAE-96A0-4934-9A24-BB12F3D45F90@nvidia.com>
In-Reply-To: <e1431688-17ba-4881-9536-b598383ed2d8@kernel.org>
References: <cover.1771831836.git.ackerleytng@google.com>
 <6ada27e1-8f85-4b85-8c25-bc9207b2624d@kernel.org>
 <87FD20AF-55B6-4129-9AED-E2E854593883@nvidia.com>
 <e1431688-17ba-4881-9536-b598383ed2d8@kernel.org>
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0188.namprd13.prod.outlook.com
 (2603:10b6:208:2be::13) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS7PR12MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe70b95-987d-480c-40a2-08de8ff6112a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	3jcfkrUM6/iukJtz+e15kMhUx/uln+rl5j/z8ewuu68XAdpeHXbFWVIgKGYe7jqoxZ1HvhUNXUYEZQfNmagxUkrEiCppgJfsDzjcOFCA313apR/LFP0WHdeHoD4gAwLKRmxq9mpljLfYA6q5kPPjFD5I8QHpiT5S9K6BoWpeEOWmBwdtYBc9MLaDkziDMGFMAL2yquiDHt1EiJ+wrNxBAh400wp2vUBpFZSnSZ11/PW911UX8NjaNl5pFx2dxoXEadNRfJOti5p3ZK+2qt6uMkm7CMX2OJSapBHRJk5za8XMvcPFjstePC0/tgyxSJkE8P/04bGqgIrYa7Fqc/WXbtwgU+M9TNIqalGH2Rt9JJlK/ovTej0zTbX2kLcolcVhQ/Yz2pl/bbVbpAgk6RyelBi4wuyr7OEm/qjXl440/+vqjG9+cVkVVA3GAs2qiMbDouBG2vKHtyX+TudvjR/jk7JcLTQx6ngutoGYC/gujdSAbTuxHihGnJum8O6r6G3SX6Zb6ii7utixr+xjojAU0FDizx4g9GAYk0xuVPdoezmqWXqOtk2BZPpwWuZ1AVZ1IBf3yG0KXvk6593tyTg7AE/akn8Mtu+D7yCS9jBDP6sEv1+97TLso8Rrb3oL3q9VmlOU3aCSLUH4uHjF3RlXYnMa8PhS1YVdaHzbdsya2AikrHPCkG+lO4PCjwnCOkwDSmdH62ZMoZrTMU6EnYHVZRR6Z6LY2W5oWdPb2zUND5o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KlDLKxKMfqm5yYyYdJnLOQKctLw9pDvYecNY2LiJ1fsZDl8Et2iM/0fyYHX8?=
 =?us-ascii?Q?O/DIzIZZxDbiHASROg489+9xHEl76hELS3n/qNqd77G57UM2al4fWeaumh01?=
 =?us-ascii?Q?CiSDeE1hLIsRiL4F/5ti/I4ABGcOyJmjQYDBv8nn1wvgUDTCUWR9YXNap5mF?=
 =?us-ascii?Q?hB0ifNK/MiO8zLpKeB7r8TSI0LxIOg4r7/hkqVOqkdNaS2zzVCJ7lyCDvTmt?=
 =?us-ascii?Q?2PS7GH+pgpJEoQfRuklU3CmZIKoq+LaPKhz2blm0hiNBaKqB5qawgFsYxzsK?=
 =?us-ascii?Q?dLpD6p0gVL5LP8wbSk36t95lm5yfl/5IUoq0X8DpA9ZMiG/020AtnB6J0qB4?=
 =?us-ascii?Q?sltWjcnu5ANJvonPOqTjYMeihv8+e3vR7BpwkZdYv0TNXKHeC167BqY6drsU?=
 =?us-ascii?Q?KsMnhqy1dWZJp2e9HMeKRXU4w6iKQRP8Q0HUZOVVJiQfhS12TgDDOKIfVSDU?=
 =?us-ascii?Q?Z3Bu/aBu5IQMqXcWIfCIGSnDq20IGNEWflH4QrLwrnQKNfCgONHKODvFLmuz?=
 =?us-ascii?Q?JGzb2KazrE783lEOKcZDGg/VRdNxk8MItPbPstCvWh16luXLUCfcfHrNbGug?=
 =?us-ascii?Q?b7OOKW8/Qu4qVdwgyXhCAdd8cWzj9E/7xWWwfF3MdXyZTyBKIA6dtHq5A+KH?=
 =?us-ascii?Q?UZ2QZ1niW6o44ufi3tUHlU3Ep1w53Xp7tjkrW6BINqR3fk1XLTAyJACWRyA9?=
 =?us-ascii?Q?39VseC5WNogHDAVD4wQvTmN/s4FSM+kDAmupILNyXy+VWPWBpzgUPThY+Ano?=
 =?us-ascii?Q?oDq0ETtmdR6Q8u+A0Xn4LZ3HUmllZqiQIRGT9t7JywKQtxwX0upPdOcO5+uH?=
 =?us-ascii?Q?tk/DWkWNTb3lJdVaiPurI+UYkObiNghKncohN2SrxZdq4I0NeuZWjtWWnaWd?=
 =?us-ascii?Q?LXFFFbePVuxBzihY26hIPeWAJq+Ugcess31svqiJt168khUrURW+OsAbs0Fm?=
 =?us-ascii?Q?pTQNdWANS7Trz7BH7t3w6Yr1CR/zOnlcUMl9jTAAJ2sci3Vf+a19DjbHOQnQ?=
 =?us-ascii?Q?9cBWJuXZ0tfulMECp6fy6V7o7pw2wEjZbDwSTWOSEIt9MkLJ/+PkFrgRmruG?=
 =?us-ascii?Q?bwD/HdSQ0qyiHqaetcflyr3SeoRbqBUCd5COtPSHWACx9Ikypzcjlncu/2ne?=
 =?us-ascii?Q?vH2yCLZtHYbJwZPQT5QINYLJPRTSHu9zNXes6aLfjC+Fx9lPnJkJLa8WPsPU?=
 =?us-ascii?Q?/IP0byqCGs6G6phbKSnl9bNIXds/VBYJfDHqAh3lJxdzMaIfABvft1uUJPWr?=
 =?us-ascii?Q?k2dDdszgT0SW3gHLVHWsZTUTjb9QByevFUdvjU2c3j3N93ImlaeVGchbHpl3?=
 =?us-ascii?Q?hA3pCGBW/bYJXJEZ7lvNOZt8IitDyrtYGlwfO+FOiM/Vr3U2hN3m0l1Oht9G?=
 =?us-ascii?Q?tqipxBQyo5J7bVt3ANoD+q2dmIy44slsoxWTe/jOusC1FmDridvWdC/F0IiC?=
 =?us-ascii?Q?Gf4lp6QwzqsZv4ChPWltZPsxWgEO0jaeAWUAzNy1V2qFWcf06gx318d54nWL?=
 =?us-ascii?Q?n5AcK3ciBe0D+H6lgqDthT9GDbpNS+GvaW1wDkVpfAvKTMKs8NiWs8/IoM3y?=
 =?us-ascii?Q?a4lHpnC4519Q4K8ior1NE0Fl38cYFUTSrnpaM2zVe8EgQOd7uZlGUDcwqEij?=
 =?us-ascii?Q?N2zMhapLzR7t1+LU2ILLB7+ugKRYO0w1aP6byFwKJkqZTgnpPsfqg+n2YYV9?=
 =?us-ascii?Q?D1jWyrLPjprkm5EjCyTaLsg8YGJZ5HjXR589+QiXDL2rnddI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe70b95-987d-480c-40a2-08de8ff6112a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 13:53:34.7026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBCWoGJm2+sAlCB2AJRJlAFJ1GU/xGqtZ1UvZuFapARENOzFUnpgOphPwPPKUzrJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335

On 1 Apr 2026, at 3:32, David Hildenbrand (Arm) wrote:

> On 3/16/26 17:49, Zi Yan wrote:
>> On 16 Mar 2026, at 12:23, David Hildenbrand (Arm) wrote:
>>
>>> On 2/23/26 08:34, Ackerley Tng wrote:
>>>> Hi,
>>>>
>>>> I hit an assertion while making some modifications to
>>>> lib/test_xarray.c [1] and I believe this is the fix.
>>>>
>>>> In check_split, the tests split the XArray node and then store values
>>>> after the split to verify that splitting worked. While storing and
>>>> retrieval works as expected, the node's metadata, specifically
>>>> node->nr_values, is not updated correctly.
>>>>
>>>> This led to the assertion being hit in [1], since the storing process
>>>> did not increment node->nr_values sufficiently, while the erasing
>>>> process assumed the fully-incremented node->nr_values state.
>>>>
>>>> Would like to check my understanding on these:
>>>>
>>>> 1. In the multi-index xarray world, is node->nr_values definitely the
>>>>    total number of values *and siblings* in the node?
>>>>
>>>> 2. IIUC xas_store() has significantly different behavior when entry is
>>>>    NULL vs non-NULL: when entry is NULL, xas_store() does not make
>>>>    assumptions on the number of siblings and erases all the way till
>>>>    the next non-sibling entry. This sounds fair to me, but it's also
>>>>    kind of surprising that it is differently handled when entry is
>>>>    non-NULL, where xas_store() respects xas->xa_sibs.
>>>>
>>>> 3. If xas_store() is dependent on its caller to set up xas correctly
>>>>    (also sounds fair), then there are places where xas_store() is
>>>>    used, like replace_page_cache_folio() or
>>>>    migrate_huge_page_move_mapping(), where xas is set up assuming 0
>>>>    order pages. Are those buggy?
>>>
>>> Zi, do you have any familiarity with that code and could help?
>>
>> Not much. But I used lib/test_xarray.c to did a test:
>>
>> 1. initialize an xarray with order 6 and set entry to 0,
>>
>> 2. add a new xas like XA_STATE(xas0, xa, 0);
>> 3. xas_store(&xas0, xa_mk_value(32));
>>
>> 4. add a new xas like XA_STATE(xas0, xa, 16);
>> 5. xas_store(&xas0, xa_mk_value(48));
>>
>> The outcome is that xas_store() does not change xarray structure,
>> namely the orders are preserved. No issue is present.
>>
>> After 2 and 3, the xarray is still order 6, but its 0-63 entries (all order-6)
>> are changed from 0 to 32.
>> After 4 and 5, the xarray is still order 6, but its 0-63 entries
>> are changed from 32 to 48.
>>
>> I will need to dig into the code more to explain how xas_store() works.
>
> Zi,
>
> we discussed this topic with Willy in the THP cabal call. I did not get
> all the details, do you remember our conclusion?

The conclusion is that if user wants to erase (or xas_store(NULL)) an index
that is in the middle of a multi-index entry, they need to split that
multi-index first then do the erase (or xas_store(NULL)). Because it is
documented in xa_erase() (or xas_store(NULL)) that it erases all indices
of a multi-index entry[1] and requiring xa_erase() (or xas_store(NULL))
to split a multi-index entry and erase the specified index only is
too much due to potential memory allocations during multi-index
entry split process.


[1] https://elixir.bootlin.com/linux/v6.19.10/source/lib/xarray.c#L1640
>
> (I can try getting access to the recording)


Best Regards,
Yan, Zi
