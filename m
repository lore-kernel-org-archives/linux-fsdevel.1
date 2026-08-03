Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010022.outbound.protection.outlook.com [52.101.85.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BCA414DC9;
	Mon,  3 Aug 2026 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770627; cv=fail; b=GqZwEWq4nkhHzMulcO1WQ3h+m0qPHV1BcgwISpPzQot7zrP9f/FcxVcU9Hzhc4WWZ15ZBzjU4fRy0vAfn0wm7XeVUeOjPj4C4I9oqyhgKyhgi5vjwfcUdA22QMVroDaz3VOMjKYQ5Z+z9ztLX8sorK2TdWp0X7laSBHaZ7C+aDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770627; c=relaxed/simple;
	bh=W215VdyERs0rVVlGc5BXV9oJ6UeajoL/Tseb4mFNqBA=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=jkWfYSa4Y6z9S1qPeRabTnW97paUVfLOWfyc9A3a5G+/TZLSrFn8AEeAanVxy7hmjJiYmkM8FP6/lEyAqTv51zJ6JCGFH0nJyjHCQFlKP11e+xdIl3jCDJYbr9sbFOBfNGRMefINOTu+wiP0yJaZ9tlk0kXNnJHSIY6fpBYS5Ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KdfBipdT; arc=fail smtp.client-ip=52.101.85.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KdfBipdT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5Zk7ylLurT7Zdse+wdoytwB5sa7k3it9cidgxup6m1sfUirxxcJh05hii/jJ2VFEwglHEoaVN6P8wjuaX8QkPOm02xsAxMM9WSAcnZS2eODjy6VG1ICUp1N4tExy+VQMOagynTgiUup57L9G0cNmAo1iYqps7ptJ4iq3qwGAMpbl5VRnAnZytgDJnwyJarDQ+SBpM/yfh6YGyE0nTLiBZLPmsxCLMqwVtQYfQB22whBzJsCb4Xe1KOQg09OzFEccYFMBgGNhMxfVwOC6zPo/75qpDVEgHjHd31bEb3cNHVgIaoTG6LXFDNIPKJeG0jIgoRp0IVTw5dXqLbQwz0ELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fe9MWB2iOkBPPdY26HXHoncpc7Uv5dmhrYMOC/i7px4=;
 b=kEzVH5m1IY8r3yor2Sd7CzG95bUooc0egmSgxLzAXlo2LK0zPkbHJBA4RYs1e2d267TILhyxqCmz9l6kJUHBJhhowrDS8XPIZXMNRZf7KatLq4x+Phg6Vn8CdaCDngQME96GaOAG7itrbi0tflxl9tDekV3Gw8liQXdsnOggYf22ZeCtyLoCwHAf5LXANT17B9WwQhWBlyWJrTgTx38hNp4GohAn7NdCboJfTl7UPZyCPT17Ja5X7j4fEJ4NvK1BfsVRMoAGZJxzMuqSG5bZ+5da/XmkuoqfjbkzNJzC+PbNhvGT6uU57Gm02Z/NZj2DRmvbDNkh2uxpFXjWd9zwnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fe9MWB2iOkBPPdY26HXHoncpc7Uv5dmhrYMOC/i7px4=;
 b=KdfBipdT/SvTrKaUbnUeaFarPjJLpOWilE6gluWQy4pYlciLzWvqcbIc+ryKnSmaqxE/g0wY2TdB0MVHmSOhQ05Ks38v4ngRqoRvn9XASnoyFCFwmmAgRg0eeo4O6rmjWw7Y2dE1CZVDU0OsAiCVlvFRA0UU9aPkPvJ2dXKiM0YZO+vT4//Aat6VrCSB9v2f3GPD1RhGZfikU833w7iYaKIjP1zB8ISSJn8NWf4Hgq04pVgzCqDPK/JSGsAgislp4ob1gAjHXaE/6VJJftR5X4OgOHdMexPxpdK0aZ54ITjAuh8GgF1bYNuRFTfjc6EpdqewW1N0hSM2I8AXRpsp1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BL4PR12MB9484.namprd12.prod.outlook.com (2603:10b6:208:58e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 15:23:41 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 15:23:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 11:23:39 -0400
Message-Id: <DKFEUPDED2AF.22PKCFTWTG6G5@nvidia.com>
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
Subject: Re: [PATCH v2 1/2] mm/huge_memory: use folio's memcg inside
 __folio_split()
X-Mailer: aerc 0.21.0
References: <20260730-add-gfp_account-to-xas_split_alloc-v2-0-5a56c2361d85@nvidia.com> <20260730-add-gfp_account-to-xas_split_alloc-v2-1-5a56c2361d85@nvidia.com> <am28pV2PEfHsi4p-@lucifer> <DKFEEI2EDS4F.1AHGKB1EL6XRG@nvidia.com> <anCtxQE5hDUH5N6a@lucifer>
In-Reply-To: <anCtxQE5hDUH5N6a@lucifer>
X-ClientProxiedBy: BLAPR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:208:36e::17) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BL4PR12MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2250a7-4c63-42f6-2280-08def17332bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|11063799006|56012099006|4143699003|5023799004|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	P6AgpCJMPAbiWqDaV0zzgZXyXnoCbNKMk9G313amcjwdVMB3+YLq26bfepSqB5CsocZAJZDRN+3TzB2QLSas/yrdIo7KrQh80eu9cW+ZVw4MwarXbamBB1tC2nfGvBljmJlj422bjDKdkwUoLBC4snZwphWVKQcJ9pv57DvGP8W5d6T2EBbSk349HZKlQRdkbHFQ4hNL9GRbA/hUkpMTxsqeHDDABgZJ4PNeXBjlCNOOE4jXlBv1yICX3ANgJ3Joh5QcVJLg4hwlInf7i1+HCVqGAyHWu3U1ylmgMEFJ8EHfhv6+BvQyHfUWLhaQS7gNQq76RrCX39j8o42XwUWTsC0lZkT5M7Q3Rw1GmvSUi7/WEuaMUjIhE0MlwUYArMhToAkxnekK+W6Zuyi8LLxnjYFRZaFPT0e4inAo8NbKszFu95M/zrdSo/SBQ/IwQkfAYP3nQGO3VgocVr/S9L0g1ZVWX6z0QZW6rYGUhSwiK8Tk3nN2rm+rVrBP8une4bJMC+vislKJ2bYa9WzLUYWFuyjxQMuQxTw2pWe3wwb1H1l/KP+cB7hVSfjXtsXLLLq+ipilciFt2MNEqtXCKlBj47BNjMzkyrp+bvuMLjwM2hZ33+vdFo62ZJH+wYut3u47kIiw8fvJxrfwAOObA+YzBk0YgerXR0nMoDIGEvk7DLs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(11063799006)(56012099006)(4143699003)(5023799004)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2RBSUpmVkV3QXJmRjRFL0kvcGlHOG5YQ1k4WkswSW5qY1lPQi9SamNxdWE2?=
 =?utf-8?B?Z0QvdlllTUd0aUNsd2NHYXBNa3k0N0J6RjBuYS92RXFMM0NzQlQxTkhVZ2lk?=
 =?utf-8?B?OE1PcnA5M0doV0lmV2prUzZPT216S01rNjRHak1zNjEzQlZ1b1NIT00ycDJU?=
 =?utf-8?B?azBKM0JIenVXYXg2YUNScWM3Nk0vRTdZYTZMbjVpdmpQaWRPYXNCMXBsaGpR?=
 =?utf-8?B?b2huK2M5YmhjbDVGejA4R212a2lZYlhaeWoyS050TEQvOEpidGhSZGRuRUxF?=
 =?utf-8?B?WCt4S1k1cE1tQXRyT21CQjlvTjg0aitXMGhkYXRHb2xDNjJSSmZlMmsxNDBw?=
 =?utf-8?B?U2VxMGhuZ2ZrOFRqK2JjZHZnejNzdGJ1ODdsODIxUmEza0hVUGF3UGgzVjJy?=
 =?utf-8?B?V3RyeTYvZXh2SzFZVVN4U0VPUnFlcEYyU0IzS21LK0R4SGJOK2ZYQ011ZUVm?=
 =?utf-8?B?b1RmQ1lFenk0YldPSk93VExSRVZiMXJwMndZUUd5RXUwajJOMzJzc1Y4dkNW?=
 =?utf-8?B?WTdDbi9MTkJGTUhPNFhPYWVOMFdieGVEODBhWUQvZnFxVEcrZVhtc3o2WGdQ?=
 =?utf-8?B?TG02a0pZcncwbTYrK2lOZjBxenVyZElDc0VXREREN09WamttQ3dhZE9zZWgr?=
 =?utf-8?B?Mjh4MTVIY1V0VVdwSnlmc245Q3VFaTBMWlpoMys0cVNIMS9oL3dINHh1ZUxK?=
 =?utf-8?B?ZjFGNWs3Kzl3dTlvVnd3ZTJXdmJFRjB0emxqckFIcW5wRjRXSThCYURQTVFK?=
 =?utf-8?B?d3diM3BnSE5vdGpTL3hETWt2VkpvaWJVc01teFdHVGJxQ0pvK0FoQkptbXVx?=
 =?utf-8?B?cXRHMVBxTlBRc2hsRXJrL05VWllGVUY5VWFZRjljSHJZMGlsUTlqd3JyaEZk?=
 =?utf-8?B?cGRYcVA4NGIwNlFQczFMWGVtYVVRQW9BaE5WWEVtN1UrencrUDZQOUxvSnRS?=
 =?utf-8?B?YUlyeU5TTEVQOVZNOGJTRlllL2VReCt3T3lVa1BNYy9GQS80TjY5R3lwOGt5?=
 =?utf-8?B?Y3dEMnJoWVQrSmFkZDhXWjc0WjBjbDNCc1h0eUdISENuMEh2OTR3RjlwOTU0?=
 =?utf-8?B?NnZmWm42VWpqZWt2b3ljMWp3MVFOU09Xb0pyVEoybGpYdWhwMGNjdWNwZ1Zn?=
 =?utf-8?B?Rks5aVB1Zk5KNzB2cUU1MnBRQk9NcnA5UlF6cmNaVjNPZ3RGS3MwWE80bzJZ?=
 =?utf-8?B?VFB5VUFEUitOWENaRkRlTmFoQkF6WFEybWF3aDZuY1Q1TGZwdTlOVjgyaWxU?=
 =?utf-8?B?WE0vTCs4UFViVGpDbEVZaVBOWG4yV01Pb3ZUcnV0eWRiUWZycVRyMjhma3BI?=
 =?utf-8?B?ZGtjUmNkaXVIeVYyNXN5cWN5OG1pakRMaE5zbG5rM2puV21vYW5yTkNmQ1Vt?=
 =?utf-8?B?TW51MkdiWE01VWlVcXNlb0FkbDNnY1I4bjFaNTROYkZ0L21SeENTaEMzWEF3?=
 =?utf-8?B?NzVWdUJSNmM3QXRyUVFHTk5ZQ2lzUjZ0bG1QOUt1M29kWXNLdDlDYjIrSGgw?=
 =?utf-8?B?LzBIZG9HU1lzdkJ6QldlZWpOOERMcTdSWE1KV0VQVXFlb0RQZzBON0JhTGs0?=
 =?utf-8?B?ZVI5akNPR2tURXFMWDlleGdBSHF5R0N0WWJ4QTlVS2RaNnNXQnpTbFk2YWVM?=
 =?utf-8?B?S1ZzVzFQd21QK0VtZ1ZYVDdjcld3KzBCcTVuU0Z6Ry9aZGRVSktIT1FCd214?=
 =?utf-8?B?TFgxTFJvTWJWRWdHemJIQVpvQ1RONDZwRWlYNWhmWnJBNTNGQWcyUFRubXZp?=
 =?utf-8?B?VE5pWXFuVlVEdzRHMDVROE1DakVqTzFFMUx2Wm4zcDB4UTd0NW51QzZBbVc2?=
 =?utf-8?B?WHVzMDZyZnVHNFQweHhuamZPT2lNejdaRnJUSkNvNVVDV3VjSFo3cFdiNnc4?=
 =?utf-8?B?UXJsYjZKZkRwSW5oY1hMYk8yMWFGVWNTOC9kVFR4NXVyZ2Nvb1cvMElGakVR?=
 =?utf-8?B?dWdFOU8waWl4QWxLYU1IbWVIRnU1bXlueDZCbkU0T1BBcGxYTTVIUXVRWC9U?=
 =?utf-8?B?d2dJMUZsTzFacThWekYwYjcxRmxxZis3QXRZb3RUMFVia243T1VrbTREWko0?=
 =?utf-8?B?M3ZTNTdTTVhISEhMQzJ0WkkzUDhJWFd4SFZSNFVOS2wreTN4cGNTZlJGUFJW?=
 =?utf-8?B?aHZtVVcyQ2JDRU1KRTVnMHhDY0ZCVy9jOFBacTZqMER2NnJpd0djdmJjQnhH?=
 =?utf-8?B?dUVBT01hVFFOUHJlaWlyQ2VRMGZyc1dBbHV2VlAwSjFhWHAwMVpYUFY3R2sv?=
 =?utf-8?B?QkxIY0ZBam1odVIyd1pjZklPbkdpcFQyNHNkUDhLSDd6ZW05Zy83SXZjSmF3?=
 =?utf-8?Q?00vyxPQu09t0101YLu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2250a7-4c63-42f6-2280-08def17332bd
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 15:23:40.9263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRucwq84gN583raEUk/N/L9jO1Z5P2soT+J4Oho5/IrgAb58iD5RU1olirsDSWux
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9484

On Mon Aug 3, 2026 at 11:07 AM EDT, Lorenzo Stoakes (ARM) wrote:
> On Mon, Aug 03, 2026 at 11:02:30AM -0400, Zi Yan wrote:
>> On Sat Aug 1, 2026 at 5:36 AM EDT, Lorenzo Stoakes (ARM) wrote:
>> > On Thu, Jul 30, 2026 at 10:18:00PM -0400, Zi Yan wrote:
>> >> During a pagecache folio split, an xarray node allocation can happen =
and
>> >> needs to charge at folio's memcg instead of folio split invoker's mem=
cg,
>> >> because for example folio split can happen during reclaim and reclaim=
's
>> >> active memcg might not be folio's memcg. Switch to folio's memcg at t=
he
>> >> beginning and switch back afterwards.
>> >
>> > I assume this is the only allocation? I guess in general it makes sens=
e to have
>> > the folio's memcg be active here regardless.
>> >
>> >>
>> >> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>> >> Fixes: 6b24ca4a1a8d4 ("mm: Use multi-index entries in the page cache"=
)
>> >
>> > Cc: stable?
>>
>> Like you said above, only xas_split_alloc() is affected. And we have not
>> seen related workingset regression report (like what Johannes reported
>> in commit 7b785645e8f13 ("mm: fix page cache convergence regression")).
>> It might be OK to not backport.
>>
>> Johannes, what is your take on this?
>>
>> >
>> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> >
>> > Change seems reasonable overall.
>> >
>> > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>> >
>> >> ---
>> >>  mm/huge_memory.c | 20 ++++++++++++++++----
>> >>  1 file changed, 16 insertions(+), 4 deletions(-)
>> >>
>> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> >> index 04e8a6b553435..b9c2d8908e564 100644
>> >> --- a/mm/huge_memory.c
>> >> +++ b/mm/huge_memory.c
>> >> @@ -4063,34 +4063,42 @@ static int __folio_split(struct folio *folio,=
 unsigned int new_order,
>> >>  	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
>> >>  	struct folio *end_folio =3D folio_next(folio);
>> >>  	bool is_anon =3D folio_test_anon(folio);
>> >> +	struct mem_cgroup *memcg, *old_memcg;
>> >>  	struct address_space *mapping =3D NULL;
>> >>  	struct anon_vma *anon_vma =3D NULL;
>> >>  	int old_order =3D folio_order(folio);
>> >>  	struct folio *new_folio, *next;
>> >>  	int nr_shmem_dropped =3D 0;
>> >>  	enum ttu_flags ttu_flags =3D 0;
>> >> -	int ret;
>> >>  	pgoff_t end =3D 0;
>> >> +	int ret;
>> >>
>> >>  	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
>> >>  	VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);
>> >>
>> >>  	if (folio !=3D page_folio(split_at) || folio !=3D page_folio(lock_a=
t)) {
>> >>  		ret =3D -EINVAL;
>> >> -		goto out;
>> >> +		goto out_no_memcg;
>> >>  	}
>> >>
>> >>  	if (new_order >=3D old_order) {
>> >>  		ret =3D -EINVAL;
>> >> -		goto out;
>> >> +		goto out_no_memcg;
>> >>  	}
>> >>
>> >>  	ret =3D folio_check_splittable(folio, new_order, split_type);
>> >>  	if (ret) {
>> >>  		VM_WARN_ONCE(ret =3D=3D -EINVAL, "Tried to split an unsplittable f=
olio");
>> >> -		goto out;
>> >> +		goto out_no_memcg;
>> >
>> > This function really badly needs splitting up and probably some cleanu=
p.h work :)
>>
>> You mean folio_check_splittable()? You want to move -EINVAL checks a
>> separate one?
>
> No __folio_split().
>
> Comment about cleanup.h really was the whole pattern of goto xxx for vari=
ous
> levels of unwinding things.
>
> But really I mean the folio splitting code in general, there's a lot of
> massive-complicated-functions with a million things going on at once,
> __folio_freeze_and_split_unmapped() is another.
>
> Feels like we should really have this stuff in something like mm/folio.c =
anyway
> too now that's renamed :)
>

I agree that __folio_split() is handling multiple cases, anon, shmem,
pagecache, all together. Do you prefer:

1. split __folio_split() to handle each case in a separate function with
some code duplication, like xarray for pagecache and shmem,
freeze/unfreeze folio for all;=20

or

2. encapulate per-case code in small functions, like
if (is_anon)
    split_prepare_anon();
else
    split_prepare_file_backed();

__folio_freeze_and_split_unmapped();

if (is_anon)
    post_split_anon();
else
    post_split_file_backed();


--=20
Best Regards,
Yan, Zi

