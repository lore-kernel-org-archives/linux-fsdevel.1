Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793677386;
	b=gAkxS3znHnWaJzqBL9jI9m1cYuvaqGgwMJ0uxU3bs0WQxZBxoY+gV7vC/47YJNAVyNhj
	 vXU5DDdvzhu2+D3Oy7kNjB5eumT6lJxrMpPPKAA5EA7764IqNDaM8wPxHItw85ELFXBAS
	 knSBpSanGoQVzYwVm1sH15BVHe0lJYWeUzbxeBusaaM96TQdrL1ZdcK8XDlj/KTH15hx3
	 EqTVayvU20wh9An4pGG6VdOYMCS7bnieQmYQYI9m9KOKEIBCL4AisMYe6zZyyVAMkNC/j
	 S4h6Su9HyRzKfUnLDu1dC1e8ho5N85irIe0dI2lMSB7MEYFR44kXJABxXQegxbR4DPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677386;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:To:
	 From:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=44vAEVff/WToMm35bqPg5hYPPXN8DWGUk/uuo8qovH8=;
	b=WHxBkz591JsX9W+plvn8M/znR15RsD/JgbEpcp8kINO4LxmYnoYw8sSqiW6qjoFMdIrl
	 euajHMp2OHMtBYvwtRfjt4c+fJGjvhaFeJzb5id2ZXmJVKsX315Aj11QxF05ha8EvmCMm
	 cc93MXC8QtY/w5ENbUd8HqzNtCO+9w1ACEaXDJTm3Odvfi2q6J+p1fmsiIbqDsPTockr2
	 uZltgMhsWoMzCetnmkzouhkA1pPknFJdYVGTmlgeyC27kFvGmSfzJ6PHuXWCNPZHIMLwL
	 0OQZ3Ov3n1tVCp6H59hU6CKMYwaSFx5OgGYudiKq/70jEXIUd760ndi8w67CZpKuYXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oa66J79p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.23
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A292B606A324;
	Tue,  3 Nov 2026 03:43:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A292B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=oa66J79p
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvQmh/IwFJH/1dwBsaRIyJ1Y0YKAJnQM6fnCCsSCQfZoesaAgcpUy7zCfY2n8OUkcKElqyB0wqqqBQHDdY0C/s/llvnn8p3ZrY+N3bzT9MF97qkYaQcmcSkghjIk5nkNswr0k0S0M/LVwdSR5BEX1su8IPTBJYhH2yV7QEn/Zwr2tmPg/oUvib/lFSUp51VXC8VUUL9OznBn4tPQEo3oxUxYCHTAOZUztSWYohyVvUJ8sTvZvKYQWFYdZS3arBF8/0ymOlWFH/o0U7mjYnfClGka4xAkVU1cJtD4dQCHLSjlpQycnO+Bo/u4K7irhZyfqenrJfjjjPsKsBhmbaQ5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44vAEVff/WToMm35bqPg5hYPPXN8DWGUk/uuo8qovH8=;
 b=xQMGBJcpIkiZEjNSMi/jfW3Mt1fMDeemDKSgxTeEReHSy5wgDgnIFd9ac2QLDTcgng4LhfHUmiYx3s8aoYl6fkROPreUalW5gjxfItE/MqtfKuP02nJu9z67ISCLYhTl303G0xrR1Mz2R+nrL4wEklooN3AlC149Uqw/t7Lw8BSyj67698eTq6rJp8Amll3FATKc9FFOvVzhObJE3u7VYDaxt5Xx7v/5Lr77obtRQWdKKqUr9y5hA20MdGpYhhxht3Xq818cirjDscJOaswJ3lb4d2+1IPfNA5tw/2SAO4FPS1Jk7VZgslv/DATPlomykgXfQVEA+mhqzZMZT5dvpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44vAEVff/WToMm35bqPg5hYPPXN8DWGUk/uuo8qovH8=;
 b=oa66J79ppwwM+kTYBAuNSc908yrY6AhHo69J8UFrux9LBTHdlDhqMWakBV77PHe/iLhRCAEiwIC0n45aw7RtKk93e5zQM27OPGvbhR+pWDJgxx1On2fuBvwT+J7p5e1XH9/zS7sZcfesGhKYZ5PTs4OsA9UAfs+D//a2AvBAul+1wk4UNl/Il5y17zCdZlhEYalP6GPCnCpT5xrZGpAQ2SD3gzJo13sfrZu2ffUu0SXZISKefRjV1ae0nByR/GQExHz7OG9qFmEyj6+n9ZXzNnaZFM87HZSA1jljiYBM21Ah/l0T5wT31gji4hMwnue1W15aQoGqHQ7pSgi4pJj1yA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Tue, 3 Nov
 2026 03:42:56 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 03:42:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:42:53 -0500
Message-Id: <DML9K9YRKHYV.228UWG5GT8IJ9@nvidia.com>
Subject: Re: [PATCH 1/8] mm: remove wait_on_page_writeback()
Cc: <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
To: "Tal Zussman" <tz2294@columbia.edu>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, "Jan Kara" <jack@suse.cz>, "Andrew Morton"
 <akpm@linux-foundation.org>, "David Hildenbrand" <david@kernel.org>,
 "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Matthew Brost" <matthew.brost@intel.com>, "Joshua Hahn"
 <joshua.hahnjy@gmail.com>, "Byungchul Park" <byungchul@sk.com>, "Gregory
 Price" <gourry@gourry.net>, "Ying Huang" <ying.huang@linux.alibaba.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "John Hubbard" <jhubbard@nvidia.com>, "Peter Xu" <peterx@redhat.com>, "Hugh
 Dickins" <hughd@google.com>, "Baolin Wang" <baolin.wang@linux.alibaba.com>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
 <20261102-page-wrappers-v1-1-e7280bdb31f6@columbia.edu>
In-Reply-To: <20261102-page-wrappers-v1-1-e7280bdb31f6@columbia.edu>
X-ClientProxiedBy: YQZPR01CA0177.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::22) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cba3dbc-d3d8-40f5-f761-08df395c8bd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|921020|10067099003|4143699003|11063799006|261022105027099003|261021123027099003|261022075727099003|261026140227099003|261028144727099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	WKgRhAQOz2QxajOExhTfmHQjrR/xRHhQRxh7D8niQ9aNYYuRDwP0KVU0V9iI5K1K5EeRkDYQq1OIqoEpPi6J60UyisF6YmqOKIfXJzB/EwWV0qi1q+hhJtJwrr0/9OFqHmjbxLnW5kgb9yzrtIyOJGj1jRUBwsvi8TlQqLsYldY3De5MdEc+QTstu7+Am8m/TQQEs/3acubfWBxxfP8pJc0Zx1E/waRi1MXmqDSKG2hGn574w6qWotyJdOiYtGMY01bWoziJkexK8MgcUIvpd5c/rcUmOaZstSNd9onJO705s2+fZMOPmBWTGBqcxhTO+iktDG31XjUY2kqktZa4khLV5RGGOx26T77lguq8H/kWCCkvaIwUwKneMqbmQL2MRlqr6/mI2tcjL7fclZKXrHx4JDDgn2QmBGfT6qzHjaavmBWJy8w2wWwMdSfKq/ABbXGuMJXDwHwOtdd+s2dkEl3Rsz66nrBro5iyVqYSZfPBN/zH0LAuFMvT/8Dp86kYQ924kNXg+hg2/8ZIEb3sZnaXdLvqCV73CgTB0ZD5UJP4k9KTE0gpWntwVMqDRlxg4zBuA6Ogn9MZ6dsb2BE/8jB+HaPjl3WBas2du+4eZvuNsuIKdS7D3kjGpadZLO6XC4x/aBWPC06F+Z6ccDDSxY0pwamXreVtKCoBiPVKNnGArOULDR072MkP0Vkn6fCVDOE8g7U8HbZ3z3Bfoo+kvQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(921020)(10067099003)(4143699003)(11063799006)(261022105027099003)(261021123027099003)(261022075727099003)(261026140227099003)(261028144727099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S25TcTFuYXdvYm9Nc2YreE0vNjRhRVJ2WkFWSU43YktBeTdyZ1ZuWnBJZW1F?=
 =?utf-8?B?cXg5ck8wMUEwWWZtL0Y3b0JqWjlMWkFyUlR3SW82OG5RelFXRjFJUXNBRk13?=
 =?utf-8?B?VE9USEN0SHQzT0h2Rjl6VTg5Wmt4RDVVUk9JMkMxOFhET1hVU3JTRDFXWWJu?=
 =?utf-8?B?a3RHaEFHZ2YxZVNtU09kcmNoYkJRMHF6cWdLcDBmaWdkNmpTTVN6ZnFxQk9x?=
 =?utf-8?B?TjdCTUZWL1lnanVLR3kyS1NuOFFTb0dhcjdiNXk2ZG9idnZYUEhHQkRISzhl?=
 =?utf-8?B?eGpTY2kzNHFwU2U1WVJTazNXOTRLVWlkam5JWFAyemoyS1I3SzFjTXJOeEVD?=
 =?utf-8?B?eEdUT3ZMOHVKQ3diUlJDcVZ4UDZPcC9ZandpL3VYL0NKUmxVMWlkVndxeEdZ?=
 =?utf-8?B?SFoyaTU1ZFZENmgwVzc2SDZTM3I2ZnZLZkNGZ0pHaWM1cWhISEhPMUs5ODVy?=
 =?utf-8?B?Q1JQWkdWTGVuU0ZTNDhXV09qUmNrd1hmdzczOG44bEF3Q3FuZG94dHRrbzV0?=
 =?utf-8?B?aFFmZk41MjU0MTFlYXA2blkwQlZ6TlJNbHZ5dGRycWJUTHpzZkFrRjlCWStC?=
 =?utf-8?B?azF5UzdDRW5UaXp3TUZwOERNMVB6QXN0RVpSdStqZlBCeUpaWWhEODNzaE1V?=
 =?utf-8?B?cDAwMk1xS2pneUovOEFydTJiWUQ4UHVNNXBOOEJUU1RiYWZzY3NKK3NWMmVJ?=
 =?utf-8?B?VlFTM3B4ZWVSVXpkcTY5Sm1xWWwydTdXM2dMNlFpSE4zRmdjNmtkRWNndzdp?=
 =?utf-8?B?ZndQRUdmeGdNZ3ZMTFVkWFRLUmRVRG5QZ2ZabmZkczhNSWpVVUwrL3lzbGxG?=
 =?utf-8?B?ZU9yUERKczVHdnc0VlVyNkRpTDBZMEtOMGFJYVE3LzB5dUNvbXFURlRkVlFP?=
 =?utf-8?B?bzM4cVNSUEZqNUhHclZoZnQwOWQ0Z2lUOWd1TG00QnZuem5MdlhDWHdQeUVy?=
 =?utf-8?B?aWN6dk1GWUVXUmk0WStkUkpscE41TzhFZlUxTHQ1ckNocWE2WWQ0TUhaSGE2?=
 =?utf-8?B?SzkyZUxxNHlZeXMvNHcwSjhYWHBPRjVwdDFZOGJtNWNrdldVUXFzbEVOdFFJ?=
 =?utf-8?B?c2h6YUd1YnJSMmt2TDNhbVBzYTYxZUhTQmdDb3Vjc3pmK3Nza0Z2aU96TTAw?=
 =?utf-8?B?ckJzamNzWGVieFgrSndmaE55S2xpQ1ZTOE1LS3VsVE9MVC9VcUJzT1ZPelMy?=
 =?utf-8?B?anozdldxc2taODI2SE1xZEtjTUJYdHN0VVNWUmxDVUFqaGJydnN2WU1RRytn?=
 =?utf-8?B?UGtPSjNDSll3MHlVR0k2UzB3cm8vUFZWdGJpQTN1SWdVaktTOFZxMVBsL1Ra?=
 =?utf-8?B?eWhhelVpTzFwV2lRSUFSOFpFZ21iL2lCK2FjV0xjT1FKNzFYUnpwZVlOZHJ2?=
 =?utf-8?B?cGluMEJjaTdSTFErOHltV3dMK3dxeFNQSnhQY05NdVdhd0lYSC8xbVVzTFM4?=
 =?utf-8?B?R2NVNmlpQ2xXVVNhU1hlaWtSeVJIWG44c3hHUkUzNFlYRlRjTS9nNkl4aXhp?=
 =?utf-8?B?REVpWmhCUmoycWo4M2ZPSDYzZ3cwdnNYOGNiTjBpdFB4QXR4RlhMa2VTS1Qy?=
 =?utf-8?B?WVRRbi82aWwwNVpCK3E3akZIM1IvQmRwSFFaZHZHTTEwRU0rUnE1UkM0RGNu?=
 =?utf-8?B?elI1bmN3bXpBK0pnNW51MW5BOWUzdURTRklZa2xGb2J1a1Y2dWhUUmFad1Np?=
 =?utf-8?B?dkRQK2NhbUpJZTY5WVZKL3FYbWwwQWJ5R3Z6YWVLb2pXb2F0Y3paOFdlQTlF?=
 =?utf-8?B?MEFKVkR4NHpLa2JuMmZ1WXUvRzRSKzFWWEsrK3JNVzhFWXlRUVFrTUwzcmNm?=
 =?utf-8?B?Lzd1MDVlQ1JMQWVPak4rdElBT0pwZFV2cnNock1yZXVuSnJtRFYvN2VzR29m?=
 =?utf-8?B?S1hQVUpWVUVKQ1lMVmJQTDB3UFFTQk1xb1k1ZndYeXQ3VEhKZkxlL1VFY2Fv?=
 =?utf-8?B?VEN1YmNSSi9WMnpSQXp0M1J4M2lCVFZzN2FoaUdJYnczSFlhR3NsTW5sR0p1?=
 =?utf-8?B?ZmN6UHdhYnJFa2QyRnhJS2Q4WU1BZFA0VHVwTmkvY1Nsa0w4OHB2Z0ZsVUVn?=
 =?utf-8?B?R24wN0hhbUM3M1hTcGJmTzdsZ2JFZXZEcFBZWm5mcklzb1FkMWR5UzM3Y0cx?=
 =?utf-8?B?MmMzZFZJVzdYTytHMVhpREZ6R0sxWEJpRXhQdzlpLytKNnNkMjh4akkrQWRL?=
 =?utf-8?B?NDZFb2tsV3I1dlRWTlF4d3lsUVRmdzk3cEFGb0daOFJNUmhWM21TOTBQTDFN?=
 =?utf-8?B?ZjBkUWRPNy93dVQ3TWx5dDc3YUFWMkM0dmlDdmMxamdOUk1WVzlnem1zYkNS?=
 =?utf-8?Q?BLoEQabLnzz/w8kEtP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cba3dbc-d3d8-40f5-f761-08df395c8bd7
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:42:55.6950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmTRkfwmxMuTwG++9FYRyOVikUwLxbtrRJ/jOmKg6mUiPrcd73t09pjhwOOv121R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890

On Mon Nov 2, 2026 at 5:54 PM EST, Tal Zussman wrote:
> The last caller was converted to folio_wait_writeback(), so drop the
> wait_on_page_writeback() compatibility wrapper and its declaration.
>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  include/linux/pagemap.h | 1 -
>  mm/folio-compat.c       | 6 ------
>  2 files changed, 7 deletions(-)
>
Acked-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

