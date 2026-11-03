Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793677567;
	b=O3aXk3yJFPv99Q+w03Bw7Mj87sMrdQ7zKD7Re7rT5KSFAag/4Jh8uzk2vg83IHv4tpXH
	 to7Zpx9NOdPdgIDstUZKkIXwvls7uC/S+1neV6IzATm/FyBH6rK15lQTjqGxoi7yOpmr1
	 2SSuHLyC8zR4a0ENGZGlQflOGQAyCZJWiGnKgOdhGUCfjS50ZYLCjN66Akdwvp/6d3McG
	 /N4oMip0n1KOfxKNYMNTZwL9O2/PJtkkY2tXqbtY/BrFPYvnJyog0QC82lLN7JuoMzSNp
	 4VeUybF7ayRS0yOeaXzyzsG3bx1sugpBn5dQJaCQgDSP+2xLcer/L991O6h/hUHJRhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677567;
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
	bh=eq+0RKs9TRA0PZKy8ir59viWzstZo7XmtITAeoqG1wg=;
	b=NxgjNqMnvy/kVEaQW+rJTz4UxVTfEJKqin2O2hODICxFIEPwIHzPNeKxiHCByKvRThI1
	 vH88Y9jqB8205NcCKkDtwzigYZPzz/TQRU3eg8t7/ZPZgBinmzqMamJCiz31O1jCfGylk
	 LJoUNp7IN39sAqE3ts/P6boGWK3lC2L3YL3BBaWLkh+Dv9zeOTd5TH1Y//mkR/hlyGEKp
	 xBSgsYLYgKyLYjbpPBdQyoZyVYGoeZlr8sx4nG70XNLSEqJtKiPpaDFruw+GDY42RVdFs
	 KQWfAJIE7AeeOvpFLZE6WoLV1/0OxbKOC8hErlGoAVXr5JYRjluulMVbznKx0G1DBWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TC4yCZsW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.46
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A497606A329;
	Tue,  3 Nov 2026 03:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A497606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=TC4yCZsW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tOli3Q6yQBxH1UpBTgCOBDbvdkas8MGfXE7zgHdxWZ0gGjDfMm2+7YxzU7qEBQfUAtsOd9oXGwvBR8QaldtztJzM4RRuHRdQ/viU+1tB0l3YaK/NSNsZksF6DREUkxtnhX4K7Rqqpt0Fa0y/fD6wg38gwa1LFuNMi3H4VwxwelZls3x8Xwxt2P7q18eizG7jG/0jVoK58M+9ZGK+qEdfTbx8O9xj34CRZhAZND9Xzuk2XpPoioFeU0pYRWBRoOty/vjNnUZM67IZpLF9l+KO2CUS6avaY/5hLyC4/ZAw2ZI0cXW0i2Ai4mecKM1Pn5mWI7HHsAxtLCE9NqOXvsN9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eq+0RKs9TRA0PZKy8ir59viWzstZo7XmtITAeoqG1wg=;
 b=nVPD5TJJxvDDssAUvKXd9U4o/lUJGvAy5aC9JCWPFakgLzGUo0WH+kM3NBwxEzlXiGxFotVHcTL30eN7l3jCkDAOoqBOGpSkACxFEBg6Ki4VWzlQ8X1W/bW1AmChezlWmXIJ6gvYVWLshGXwbrlSDbHyH/FijNR1O1svvO+lG/RL44KcgZpFa3Y9LB5TdAN9zX4nap5WxtJRQ25y0ibyDCPHWBsXQ/cFRJd+URtuC9GWilGT4CS+eu8FIfhmJLc8N36jWdNm8Y6AUM8TycK6e/NdP+mzbmNHMEB8q/Duswu91KLaUh2q76kRuNxgjP54kFnBmEgcQ0TMCIyYf8VQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq+0RKs9TRA0PZKy8ir59viWzstZo7XmtITAeoqG1wg=;
 b=TC4yCZsW0NGfJal3r6oMazw3vysi0StAbyjifgshkATggeq+Z6I/qCLKwdaNQjCJdNm4fGzoYJbY7JKlfetrCZDfewR+RVHW4lRS5bzVGiNZ24URFZ84Alj8f6y4FamKfoY70N8YtW7REiXDc/QP6zcy/DtSEjFNHnNkxa1zZVMaNZW9HzKEYfzk8hhFME4J40kpQXL/Vevv6DbhUC+E1pCZMg8ov5zw+4pMP66ugc8I6liIVw9OGWKn9d2Qzb7vODH9eR7/AO3/xV+stF8evsXU5p9UDWo4S8rc7d6pBv5Q43zaxJ81O2Psz/DVUJzCanUkqiVKPHrVn1pvWTBpQQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Tue, 3 Nov
 2026 03:46:02 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 03:46:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:46:00 -0500
Message-Id: <DML9MNSRX2O8.2WLE8SRPQMQNZ@nvidia.com>
Subject: Re: [PATCH 6/8] mm: remove find_lock_page()
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
 <20261102-page-wrappers-v1-6-e7280bdb31f6@columbia.edu>
In-Reply-To: <20261102-page-wrappers-v1-6-e7280bdb31f6@columbia.edu>
X-ClientProxiedBy: YQBP288CA0040.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::24) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: f29a7dc5-86f5-4574-a74e-08df395cfb33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|18002099003|261102123227099003|22082099003|921020|3023799007|10067099003|4143699003|11063799006|261021121427099003|261021123027099003|261022075727099003|261026121527099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	DOSqRHnO1gOtHX59cwxrHz1y6xawGum6ib3j1vxGKvAuud1H/JApvzC6IFzoc5L6uZKQiooeH0nrL5ulxyMeWG7mBLaHoJ+vLSzagMWdn7By8CNkSCgItwXomSjq+5HUOTRac1PmLdYjZ/+pD6HHmv83uI+oZmgvhMPeAiOhs7cxf+DB7JD61FizI2qaxzyWblZdcT4F+Lo2vv9aIZ/cqqL2AMc8QoJgPdGYBq3Mbuchr7fXYGCY/HCfOcO1LXtoOvyFlDsKKWjIw3s5Kox19ZBiLFXBKpDy0POzEBBtbpN6EXJjnuHQuKcsUgqgsK6HphCQtpomYRdReREcMAv6fyAsvgptLWfdqaWMoJnrBvV3AU2ZCQwvYdcNqHjtfDVDPYkLi341hPWGNe/S6HsXGBlQhlm+a5xUPn6qRy8pFzm0yk9KNJGDRb23vxPqJSnIymWaQFM/944pI2V5n/WfJQV+x34jcx6XsZabtou07BhbP37gvhsrO/FcgsGZxoH+XkmfG+FkK+J//22uT+TTTbDIB6Hu0GzZ+ieMoQJ3plpzfGURgtnZd41zXAIbpy4HMhH3450dpBYLqyJ6EQg6YcVpMbX3+EK5jd619nSzw+4oskw23hXaF5o+4JAXCEGhKqpEj857KikQ9y2D0fJlK4oHCt204w99fgCLEPaWzxMwgcHcr4K3l8u7CX7khwXz50RDI2vulAZO/ixndwcQLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(261102123227099003)(22082099003)(921020)(3023799007)(10067099003)(4143699003)(11063799006)(261021121427099003)(261021123027099003)(261022075727099003)(261026121527099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHVKa3FReGtpUXJabGJsMVpQTkMvYmtUZm1rM3BKd1J6REVSZHlVTGR0eXF5?=
 =?utf-8?B?Q3NWaVdGWkNkTnVveE5tNEtMNno1Q1lCNUl3TmthUHpJMlVRU0FtdGExalJy?=
 =?utf-8?B?S2IvY1dIZjNacG5QeGdWeGlFOFBVTGk5b21EalRMWUJCM205d0FteWQvMHZt?=
 =?utf-8?B?MFlvSVJjdWFCQm9zZmhlTW4wOVo2K0RXNzdqcHkxL29oZ25OV2ZoWUJZRWZT?=
 =?utf-8?B?aStuZ1NLS3JQRmZ1Y05GRFlMc2RNRVpsRzV6eGFBQTY5MUE0c0V0Kzl6YXJK?=
 =?utf-8?B?bEF3Skd4dTdKY05YMkZ0ZmVMenc1eVZudFhUS2JWa0F2bWI2TFo4OXNBM1N1?=
 =?utf-8?B?UTNsNHlzVndlcjlHSWtidTVOUi9pZFptYzBEdDZVKzJzd3J3Y2pFYzJoYlhY?=
 =?utf-8?B?WjdwY1VieWh0SkxBRWc0NHJMTjAvTGlSbG9QR3AyaVpOS05udXZYQUhDei9H?=
 =?utf-8?B?UnJBZE9ER3M0U3BHUVZMeUNydHo3S2RiSlZXbXhPS1hMTEhQeU56cEJOOUlL?=
 =?utf-8?B?eUtkUlREM0xOR3MweEJQdFNDVWphSzVqd2E0eWFEdXljUEYyWExTZGhrc3Nk?=
 =?utf-8?B?Q2hvOUNBK1J6UkM2VzA2V0lFc2thakU3R1ZRcEFPQnl4U0ljM1FnVkw1WjYv?=
 =?utf-8?B?WUc5MWJTSjN6UnB1bVdmK1hpeS9zVmNjbkFKby8xN09WeGJMVndreXNnMGZ5?=
 =?utf-8?B?NThDUUx3NHBFSm5LTFROQ0NUWjlRaGRXQjhYOFBxQm5sZEFzWWFySU5Bd0Qx?=
 =?utf-8?B?Q0oyaGlnZ2NwRWRsOG5DNkJ0NmRWeE9sNEhiNlNlU2FFVnhNZThnaWJkR2Yz?=
 =?utf-8?B?NHkwditSSG15ZE9HODBDYnlCb2VOM1hLdVVucGErRXVNNGpveVlxWnJ1SEtE?=
 =?utf-8?B?ZGRHdGVBQUpPelhGOGZRUHVTOW9ZWTNGclVRUFNzbDhRMUpHSGZpTFp1OWYv?=
 =?utf-8?B?dXFMY3ltMk9JejUwUTcrK0Nza095a1cxTVBSZkJmRWljWEszaFUxY1VWbEFv?=
 =?utf-8?B?S0xkenVRdWRDY2tKSHRhZjJpMXBGK2ZyR2lYSlJmYTBBRXlLZm1iYUNkZ0tN?=
 =?utf-8?B?eExWOG9IK1N5MjNtTnZhRWFQYzExSGtTWDB1bEJvNVNoSU5BeWxRcThxSmdj?=
 =?utf-8?B?YTVvWFZURVIydWozR0xjT3A0a2FvMHhqdGRLZDdBOUh3YmVwSERESjRVSWVs?=
 =?utf-8?B?SVEyT1JobjFuZHJPQkFiTStIRk9INjVwWmUvT3pXLzIyZE9ZWEJLYmNmQ1BQ?=
 =?utf-8?B?WExhbENnQzRtV29XZmdLTXhMdG45bXZ1L2lWZ2JaNVdZN09BVm5KWGFpNkhO?=
 =?utf-8?B?VWgxbWNtMkd3S3BsOG5ZeVdsVFlTd3BYenFBajJrRW5UTy8vZitLS1JCbzV2?=
 =?utf-8?B?RlhRVWMwWi9rVTFkdWRBeXY5Y2xSNmJVWHpxaG55d2owdEh3aFlSY3FCbXJJ?=
 =?utf-8?B?YWlheVBSYjVKSmJDaS8wTnF2b3h1aFZrdlVPRUJRdVJobFc2bW9nWDM2U3hB?=
 =?utf-8?B?bDg0SGNZVzh3cUZvczdvSFNKaC84MnZIaFEwWWdKUEUxYXJyMHVhN25kT2hE?=
 =?utf-8?B?ZkxpUzNYOW1IRzRvU2s1WWRZWjY0TzhkNTVkRkNLYjdhRkdwSmxLdzNudFRO?=
 =?utf-8?B?Y3RnQ2tuM2dodnI2WlhvTDhhbk41UXdFSDc0ZE9LQ2FvS3VFTTlzdXkvUS9P?=
 =?utf-8?B?bEVzSmxITlMvdFFKN2dNK3BSUlVqWnpjL2xSamtaWlBER1owQkpqNks4Njcz?=
 =?utf-8?B?eHR0cDgxbDZ2UTBvajB0cGJoTGxVU2xTanF3blpaeXVVUDNZZERkWHBZS2lH?=
 =?utf-8?B?RDdMQXZ1WHFHVXdnalRFaXN0M0k4NlZOWTV2SkFMVm1WM2hpcWR3ejBJcXI3?=
 =?utf-8?B?eGg2MjhMTWgrNE9MR0VTN2JERUxDYzd2YUpNMDcyQ3o2VnRRSFRkN25mdjhP?=
 =?utf-8?B?NndBcTBXc2oxV29Kck1oV1ltenF2bmVzWU80VVY5VFFOTmtqNGhWdlUzOG1W?=
 =?utf-8?B?akx1Zk4rRmMrS1F5eEJVeEdwSG1ya1NMejNUUUIwMkZLWDdyVzEzZm1DRXZD?=
 =?utf-8?B?NjBKSTRTZGpuaThvY294NFhqSm1vaG9lOXJTcXV6VitteTZyNEdYdVdPcWRB?=
 =?utf-8?B?Z1lvWjNTQlVUa084dVlJNkxNR2ZPUUUrVnJpMW5PQTBpQXllMzBJb2ZOM3hD?=
 =?utf-8?B?Nk1ILzBUR1gyRkdIWS9xOHViSWJoMndSRytRVm5LZDgyMWdaV1VHRVNyMGUz?=
 =?utf-8?B?dmp4N1ZSZkZma0VCYThaN3g2MFA5TE5rWGJvZFVpMnJQQThNTjNZajVUUHdN?=
 =?utf-8?Q?5v+27mY0jP2M1huewG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29a7dc5-86f5-4574-a74e-08df395cfb33
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:46:02.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBuKAz8WTck2NhLpodW4vGeTde/Wx1ZO4hKjC15e8KG7TCzv+mjm60hy59c98clC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890

On Mon Nov 2, 2026 at 5:54 PM EST, Tal Zussman wrote:
> There are no callers left. Remove it. The name still appears in a
> sample function graph trace in Documentation/trace/ftrace.rst, which
> is recorded output and is left as it is.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  include/linux/pagemap.h | 19 -------------------
>  1 file changed, 19 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>



--=20
Best Regards,
Yan, Zi

