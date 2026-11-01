Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793562240;
	b=bzR7G320//uvFuvlFC33NiURPtMy/YcPYMJesZo06cxoqMhAnX/xgGHS1cPLylKoPsb/
	 FM3ncBqG/IhqCWnlyv+UYFaVG0jdBp2XdaYNzAXFypQFpL2M7InP+6TRvBQ6tEhpjZ4h+
	 72RaZFRZEVbuVJotkd4jbt6H+SQ87QGi3aYgKHZXzGMVVZcikN/1JE6xM3zzDaZhKeomw
	 24/3pcmeEUM7iPTHwdfG4cZ8yUk3C6r+GxCwIfyu9JiEK34XcQcrZkt+l5TRo98RA1MVi
	 IzhJhkrhZb8zmS12sZz6QCt3Luux8do/Opmm5R1MUOP1V5+jR1gASll1ak1UyiZY+MQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562240;
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
	bh=JBZfaNAkYx7KUh5qfoFgmAoDdZtvqrev3/lxcZX5wAQ=;
	b=DuVmyERc2FoDg0a4p4UNugqfX5s6Mk0lL+vI1u4q+Gv+3rrLcTnf+21ZTmAGGOR3x5ZT
	 xBuXExitXb6oe5ctgTCBQADIw46F15fuAa7rn6s0ZM79Hsd/TVH0SMofxlCZ2+kDRFIpf
	 2ByDNSQvRlCndbqVdOwMUF14YMc1w4XH9ZJHsxHkSw/8RXIPChsyU3Xb0g7eR3IoJ2WI+
	 KjIWfsZ9lGR7qwLR3zWRHV9LZ0tqQohniIBcMbjXpFKmXP2F9vKscAfjvoN9u2+CVVTZ5
	 4fK8UjCvMGBnKDe++Hn25Gsvp6WG4IrRu9/myni/dZuYwSu65qhmEnNZmnPwTDNxtrQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cm8ERMWJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.29
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11982606A326;
	Sun,  1 Nov 2026 19:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11982606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cm8ERMWJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGNhUyWVzqjpPFtGox3dFKrg+uulG2tGnOiAQiWMw8WmOuVEXKKYgMk30UwyEbfW1EkAddyToNBC+cDfopnpz5sJR8K++kW/aRG5rFTS/tMCWm1UtWxYDxF/iZ8q/bJSCa4U8KH8rT417B/gkSL3OJDOQ/I2QNy5XAa+cKEQYGqY2txTAux2rmpHrN9D8iWugueLgfErrYxgx/1fHqiWt+Ix6jBcX0SQNrJWy3yUjtZz40NhKUHr7o0kfYBx1+geZ7ORW0dK+kFEkGq78Zg4lfvbDLxZuMmMyVTg1FCmRDG/A5qyh/HuzBW0sMftdRWri/QbY3axwCckDEBE5cUKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBZfaNAkYx7KUh5qfoFgmAoDdZtvqrev3/lxcZX5wAQ=;
 b=B6miCoL2abzOUvhPv3HqoZjdH7ih532UQXWDNe75eeXR/7Z/hYZt6BM16UmSMj4lUBCijHf/x4IdkbvO5WqflllVu+EgEWwQbg+OXHTXHo+8PdiME98xXuzZnoBwl2redG4X8PatWAYE1S4Lou7T5YJIxjh2NPCr1iO8IrYNpzeYa078LNOtBk9v83SYMNgTebs55xlgjokrWahp+I6boe5Ue1JPdkZNYIkItbYkWn99nvxA+ni3ZVlCO9Q1Cvhh+C5lj+JJs/Qp5EHFOvMDfJn4fmwjQIaEZ1Ou6+I6mw+Y7KkKskKEvnZBrXrzigKzC/z1ZDKz2ffgm/Fac0dUAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBZfaNAkYx7KUh5qfoFgmAoDdZtvqrev3/lxcZX5wAQ=;
 b=cm8ERMWJSzzBTBWT6Ugyu8ZQRnDQ9x9bleoN6hfGDqepzk2tnqHpZLbWE0Iy3ZDIilpwukGXj1EaKkkiyNxWMBx6BgB/PveX7IxhP6dYtsJQmn05Wtqhgh0HzxWsLsXBi8mqQs2cP6ie7efyR7MWEmr73p3E/cqCB/uJT7wz3nNiK6dSvaOAd6GRM738CT4XAUohv9mVjQbYAXoPvMbAEStimsUD49lkPRkFGdYPgfzwnIt5a0PUCKkFm3ntBTKZQWyG3s7iAzngU+pecCB83MYxngDAtmc7L0KbGeEPXxv+MZPYPa7XXk6mATaJVo1/1UYUaSMl7IjZnI/6Pj+reA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 19:43:12 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.011; Sun, 1 Nov 2026
 19:43:12 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Nov 2026 14:43:10 -0500
Message-Id: <DMK4QFHLOO5K.3Q6VPFME6DE2D@nvidia.com>
Subject: Re: [PATCH 1/2] MAINTAINERS: add Johannes as the page allocator
 co-maintainer
Cc: "Harry Yoo" <harry@kernel.org>, "Hao Li" <hao.li@linux.dev>, "Christoph
 Lameter" <cl@gentwo.org>, "David Rientjes" <rientjes@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Brendan Jackman" <brendan.jackman@linux.dev>,
 "Liam R. Howlett" <liam@infradead.org>, "Lorenzo Stoakes" <ljs@kernel.org>,
 "Jann Horn" <jannh@google.com>, "Pedro Falcato" <pfalcato@suse.de>, "Mike
 Rapoport" <rppt@kernel.org>, "David Hildenbrand" <david@kernel.org>,
 "Gregory Price" <gourry@gourry.net>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261101-maint-page_alloc-update-v1-0-27e8c246b13d@kernel.org>
 <20261101-maint-page_alloc-update-v1-1-27e8c246b13d@kernel.org>
In-Reply-To: <20261101-maint-page_alloc-update-v1-1-27e8c246b13d@kernel.org>
X-ClientProxiedBy: CH2PR15CA0007.namprd15.prod.outlook.com
 (2603:10b6:610:51::17) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BY5PR12MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: 878823fa-386b-458f-ea62-08df38505d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|4143699003|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UfhFvtRf3kEvdChLHG+bw7LbO2GkACOOswLW3/CwrOvxMqNCOvDV4Btnv4k27m1PD0I1y8fC77VJDD9vPiybY4mD4VYMU1R6s+quSSFl+Y6otf7jbHG3COp0Xt9THRthWEXkLzFQBsPK8UdqjFCa5Hzws2KCo/SD0Cthiu+N//D82fP3YYlm2+mfA99QcdEm7xfasxT0gpOg8IJ+WhPsqQbZd9qL4gs1KfFRDSA23cxV5TRfWYgWyuR7W+pxxHM7JBZhMAiPgLV2qGfOiRGS2d+h912qUYuw8RVw4tUVJj1hzqSSZ+N85ZcxX/bu5d5XQteLChbOhNulrZp8/KmdP8EvNzkBQ5LP86s1S5HxtqWDldvVN6NtH+SsCBhs7lcBKCWxfKTvKR8Wo+OHKxPtWbgkhMpF6qX974s946UXQhfA/gd/gRepdwvp7HFoOHi3WMozlsoZPSLRFDYG5y2Q3wkCxKJgTjsZGvK9zwyJVuZMrOJqubCG19AJIqkMu1oM2H1SdQ7+vEbEeImwYvlxhKtw6UTGu1aK37MQ+/J+RYHG+aHy3yRhDHfN/y5hQ8EQpYfW6sx2Q19BoJtBkd+ct80hnMhqEkWFHnSXE/KD5IBEs4Ye7liNJZOq528CCnPjSliqqbx+imadbN09wj48XX/rFFa680PEATJbZUdbCWI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(4143699003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1F3SWg4Y3dzVFVOR0NFM24vaHJ2a09pTXdsM3h3elpIM2RkQitiQmk5Q2Na?=
 =?utf-8?B?MUptUUgxUjFDOEFhWWxsc2hMWng1b1Bma0FCdmEveWlYbDVsd0REd3ZRbHls?=
 =?utf-8?B?V21JQks3a1BMSi9YeTdEdS9uYkFiT0JicnRkdHNoWHhxRXkzUGxjQ1kyMmwx?=
 =?utf-8?B?d1ZpbThrd013NE8wRXpOeEdHWEs4VytUZk9Wc1MwQVZ5R3NZMGNLV25nVG5l?=
 =?utf-8?B?VFlWMSt4YnMySGZnSTRzZnV5bjYzSkZKbnllSDkrVmpQVHA2TEtMUWF0WWtZ?=
 =?utf-8?B?emhkMkJ2SFVSTndvMWN4aG1NS29SWTVoOFpUYUpJNmNzc1UrTHVJbWpoWjd6?=
 =?utf-8?B?RzRJMjk5QU8zaVNNbmw0TytZR0RHYWR3d3VQbmk2d1hhM0NMbENKQXJwZ3gv?=
 =?utf-8?B?WGlaSlB0WGM2bnRyVFhmRGhJWVNQU0dJODRTOVhKa0VJM1ZwYmFzRnVDRUM2?=
 =?utf-8?B?R29mT0xiZFZpRFcrRE02b3FDTWJ5cmMwTFRiNnhOaThuMGNNS2hGMjdTTGV0?=
 =?utf-8?B?cDNYcmRnWWlHaUdCOVkwQjliTG50RUlFZkh1WjNteVBCQjVQR1JWK0xZOWt6?=
 =?utf-8?B?bG5DUnZYajNvS05QSTFzQy9xdVBqaGhob1hVNzF3K2tsdCtHYktRNzZuNWJp?=
 =?utf-8?B?d1R0RUNkWEhNSmlXanBLNkxjWTVkdmJESjNJSUJTelBpVnhsZFdsRXdoUnMx?=
 =?utf-8?B?SEpWNklOclByVHRDK3VLbXlhanVuVkY4WFNRV2VYeTJCMlN5RUtrc1R1dkRF?=
 =?utf-8?B?MkM0Z1o0R25CZ0krSEU3RGpaRytkWVJwYUl5cEt3ZEdMeFNQQlBHM3l0Rm5x?=
 =?utf-8?B?bFJYSWxsbG1BNVRtTERaMktZelN1YWp2SFExdmtUeUp6c0wyWURKMlhRRlAz?=
 =?utf-8?B?RG1GT2tVZUt1VzhvT1ZQSnZsSWtjRThIK3VBNmZpQmI5WTN6NE5VbW9KRnly?=
 =?utf-8?B?K3FIRUtEeHhmWjFOOWk1NVZDVEtzZitEbWN6QXp1d3NnZVJYbm1rQ2Z6UStr?=
 =?utf-8?B?UTFNeWR5Qm54SFcwRWNrazI1UDhQNlZmR2hDUFQ3cUFWbEFQa2hJVXVGMzNB?=
 =?utf-8?B?QVhPZ3VGelZaYlVlSCsrcTN2TXIxdFpKLy9DYVhmRGxBaDJreTg0T1BJelpE?=
 =?utf-8?B?bDE2N1M2aE0zZnNqV1R0U1VVMCtIM2QzL0JEWXFDMHpxU3RUQ0g3UGFsTE5M?=
 =?utf-8?B?YzZ5aFVva282T0VpN1Q2d1c1L0lQbjhQNm0xWHVQcCs2VnhGdzdiRmNDejlM?=
 =?utf-8?B?cEpZM2ZnVmpmQ1BvOXIzTEJrVVpYMldLdGkvVVpCemNRVFNrbkJ1dU01ZFg1?=
 =?utf-8?B?SHEzdEhiYXdyeGhEV3BaVHRsc3RJdHd3bXcyNERaNllDZUEzeDB5ZkMrcFEy?=
 =?utf-8?B?ak1BT0dmN3VoclZVNG9mRVVFQUJ6N3VNN3BKNng2RkNyc0tYZ0FFc1h2ZTAy?=
 =?utf-8?B?bDJZS3FyS2FJQmNja0hsanYzV0sySllkOHNSTzBSNU5XRlRCRUd4VFdJSzBs?=
 =?utf-8?B?SVNIM1F2ZlBqZFpqV0I4ZFJZSU5nWHVoUUViS1hVY2pPUWZSWVM2TnRVNjJ0?=
 =?utf-8?B?N25NSFpqeFJFM3Bldm8xNWRkR1Z0TUErNHV1Q0szb05XTDgzbUdmMjBRdWFa?=
 =?utf-8?B?V2c2UTJKUGhvelgwYXEyM3lCdndISHlVUmVzZWcwbEpsVlRGZENsOFdFZnht?=
 =?utf-8?B?dTdNL3lSeENvakRMaGJVRXI1V3pvb3JWTjNOTTVwVjlqemc4MzlmZDhCRDI2?=
 =?utf-8?B?cXNMQ0lIc25ndUZTclI5OUUzTTlVcTZiclRyMStKQXhXc05ydW1pdkFSTUFD?=
 =?utf-8?B?RWg4YUNXZWRiTGFmMEhTelVpdWxxTVh3NWVkR0VRREFkZmRRZTVjbDNsRWc4?=
 =?utf-8?B?cUxyY0lMQndhMEwvcW5qbVF2dHZIYlU0VHArZG5nT0t2cnVhQ2pvY0NmZktk?=
 =?utf-8?B?Nm1TbDVGQ0p6VGlSRFp6NzNpc2xCT2JXTk54cmg4OTRHMmtQcUlzZld6TE11?=
 =?utf-8?B?SmFhRDh1dkE3bUNlRjl1SkxTcVlNOGRqMmM4b2ZDNDVEU1FFcDdIYjJQRnlq?=
 =?utf-8?B?emZRb0pnNCtINlN4cm9Ra1czaFdVQVc2NmZ1bFVuY0kwcDFLa1UzUHA5ZExY?=
 =?utf-8?B?L3lGc2Uwbzg0eEJ3UjJyZ0ZSOEkrS2Z1VjNMRkpOZTJlT3JMRWxsMElLVlAw?=
 =?utf-8?B?V2JZUytKTStvRTBBODFxdXlKZ2FndlMxZzlZUThhTm8wTTJFeENHZVpJbWF3?=
 =?utf-8?B?YlhPQ0NYaVR6emxXQWNkOXJESDNrcjdJV3NGd0ZvYmJXdGVhVEFmNHRCd2x5?=
 =?utf-8?Q?X+qRTVnpkoPvzAGb0F?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878823fa-386b-458f-ea62-08df38505d46
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 19:43:12.4623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ItOQ086rwqEUG0TW7tA+qjjopOh7Elw+gWX+NL6N/jp7nqTIY0cbjcev0TO81b/N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179

On Sun Nov 1, 2026 at 11:34 AM EST, Vlastimil Babka (SUSE) wrote:
> Johannes is a long-time expert and reviewer for the page allocator and
> has agreed to step up to a co-maintainer role, so do that. Thanks!

Thank you for the contribution.

>
> Additionally, page allocator is joining the MM transition, following the
> MM core updates from David [1].
>
> Patches will be collected in the mm/page_alloc git tree and integrated
> via the mm/linux integration tree. To signify the change from Andrew's
> mm tree, remove Andrew as M: - get_maintainers will continue CCing him
> on most patches via the catch-all MM entry. David prefers not being
> added for mail volume reasons.
>
> [1] https://lore.kernel.org/all/20261030-maintainers-v1-7-97278f8a5f54@ke=
rnel.org/
>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b68bc3626709..d7cfb28a9029 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17720,15 +17720,15 @@ F:	include/uapi/linux/oom.h
>  F:	mm/oom_kill.c
> =20
>  MEMORY MANAGEMENT - PAGE ALLOCATOR
> -M:	Andrew Morton <akpm@linux-foundation.org>
>  M:	Vlastimil Babka <vbabka@kernel.org>
> +M:	Johannes Weiner <hannes@cmpxchg.org>
>  R:	Suren Baghdasaryan <surenb@google.com>
>  R:	Michal Hocko <mhocko@suse.com>
>  R:	Brendan Jackman <brendan.jackman@linux.dev>
> -R:	Johannes Weiner <hannes@cmpxchg.org>
>  R:	Zi Yan <ziy@nvidia.com>
>  L:	linux-mm@kvack.org
>  S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mm/page_alloc.git p=
age_alloc/for-next
>  F:	include/linux/compaction.h
>  F:	include/linux/gfp.h
>  F:	include/linux/page-isolation.h

Acked-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

