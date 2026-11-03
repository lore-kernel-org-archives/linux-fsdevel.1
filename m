Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793677464;
	b=Iyua+8ZJWgwsaLepSj0NkClEnyLd0a5O9IEX9POh6g9uK6bc2t5ZysSSSQbSASRZ8gkT
	 WowlaNoqOdk/0Q+2KP5m+jYVAq7eb+75t8p0YLpSe0sjVPxkEaAMqihu0IH/Vs7JnWCDL
	 jH/JskhOZjLOSflZ04uGrs64AORKogKK0jx/6Fli9JyzR1oS83WHHWrzIVer6KXI2rZFj
	 ow8nf4liSUzXqUui8+mOUKdPN5wPPdx8bzWCzuhBGCqBBr9m88/z3+kTrnB/6uZShk3tf
	 1f2Cho8/AOe/nXUlo3PatN8mNJmtNYugVG0Ebs5ytoxnx7Bne3fg2XacZF8dUr0+d3A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677464;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:To:From:
	 Subject:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=UkPAGNQH/q4mQDhrSuUJ+uQQQ0W3K7quLyqG8XUoRhk=;
	b=ri29Y5mwsxHm2PEdMnAvkVSQtSnue9qvECqui4WJD6UqsmBSFUVHdWuoC9co+cMShHVj
	 57uNz3vW50uSLN0ifSErt7wWV1ll+3D4OdYMkmFSC4vEJrcIhvTtV/nStGMEY/ieFRRJF
	 5GC1lIym0NJkWI1awO0GC84bCLhLf113HZDqjF4WiACdAMO6jhlvzBQJs0FWdsWuPpZdP
	 H1Ft/vuiSaXKMT8h085zvTpPYCHOzat1hHsYDRgheBTnCX7xXUKu184j6sePw8iTHb00k
	 +HaAiyBUoAbtCreq6KXQ+l38p4U12tU4PdgHQt8PKxWr7aYtyaK4z1n3uZdmwD5W48Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=o6XQyavm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.53
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5269B606A324;
	Tue,  3 Nov 2026 03:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5269B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=o6XQyavm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RteQn465l/4bESa8KEBUN/tDUsqk3JSjKYs6P65iX07tzqomz151TOu2iRMnmm4SR9xMKVCsWSBjNq5DEBei2kxacgLW6ten8alONIt1f+2wSeWFM+Y2IXpW702Pv3x+T9k7t2JhKc4U9lfw6MWbDXKhN32PTMAh7hvalmgH0zG+fgdmKRZtEdtzs8q4gWza93AdNuZk8YtBUr/1AgskBoBbF229CsA8VVfTgOYkPThSrLRMI3fJH9Z47L8Wll3ZVhmhIW/JNo4G3nfQew0vBtix/WOcwX77NKmSMEW/F7qFnZpd1spo/U6sRRnbazm46YgtUD14KVQ9gy8n05gi4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkPAGNQH/q4mQDhrSuUJ+uQQQ0W3K7quLyqG8XUoRhk=;
 b=JWNa3e7ZuJyoyLF/JOUs6hp/6qjfz88pQFWKmyNTlATFoScnpfGZoSL/0vy63lUzzAo0tGkrJNZEWkKxBiuHiMfUW3cIqKyh7f108mlmeU5F0H0QFs/zsyBMqL/rrKZBesmh/XpE7rpEMvr3JdPp0TwT+/8qZLnnn4xB62EFvp2XCfeSbIT/NX3S6n7cj7RUIbilx1oAhmJviCoz/TEirwdhuqs2grRr28yFBlpNJ2wWWf5rJnn+TEz39aujyueakR4Q6zaxcoFAqaa4k35YRGlze0i97hALNsozwI/Br9uIFknIZpO3+hvaUXEwYXnAWvZXj17DHDNgcIBnGU1PhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkPAGNQH/q4mQDhrSuUJ+uQQQ0W3K7quLyqG8XUoRhk=;
 b=o6XQyavmS4P4RQApVBVrFbDqy1s7C3LcigQJ2IGkOZi2p9PmBRbFofI8lBq/h6wsdD4Oq3p0BWyNexwNJnMJm924mCmOEjZW1qbi+ALuMsoDszTsdPyM4OsXLd7Yhc8ad+oih3BsSSQrRZ6UohuqZOVeq/W0pHhQbuIymTMbQw/c/5G/ozOSvnxs/JROXFZmoG+71FJuWEizfBVn/0T7HH06dWdL83NRqv2PKO+R3F/CEkGQlp9s0gSBxT7MjIVTPYKoc2JDp3P2pZHGora3EZlRwi5NDKyhHIxUkv3PMKHsbBmD3Ei93Bfuh9WH4AHv6/oVNYG9Hsc0GNYAYBD/Kw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Tue, 3 Nov
 2026 03:44:19 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 03:44:19 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:44:16 -0500
Message-Id: <DML9LC4YG6U9.2V84D6BT9D9IS@nvidia.com>
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
Subject: Re: [PATCH 3/8] mm: remove clear_page_dirty_for_io()
X-Mailer: aerc 0.22.0
References: <20261102-page-wrappers-v1-0-e7280bdb31f6@columbia.edu>
 <20261102-page-wrappers-v1-3-e7280bdb31f6@columbia.edu>
In-Reply-To: <20261102-page-wrappers-v1-3-e7280bdb31f6@columbia.edu>
X-ClientProxiedBy: CH2PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:610:50::36) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 2d8bbd3b-64db-4527-d8dd-08df395cbd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|18002099003|261102123227099003|22082099003|921020|10067099003|4143699003|11063799006|261021121427099003|261021123027099003|261022075727099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	9Qmhs+hnm7MaIGmd0jJyITkKMugYAPqxXS/MaBNQBIZF9KnKbDAUhtykF4ADq9oZ32Rh7P0suyxC5E4Fn8DIKRxiXfLb6Idr/pli566CZ5fyhqT/zCISDC4wDhl0L6oAxHfdiUmQW+arBJfpsMFx6Ct5DRYl+UfZQN2r5Ge9RNL40Vv7ppjPbt03u9cciAGtQV0ZHoAZ8jXzpG/qdiN4mbQ2x0ko2konAQ+SzxpLAmJ+0xE+g/755Sj4mLq798A7V53crVdYv7I3dr0RWrbrkn6rZzKs829qouAy9nUAZTr4JZmvtr8Q57QOvCyVKpzB+dsgM3lh8qVNPe0671g96hk179iqWSrc3vEgODQQ9HFs2ccCbvPhAzIYcQa6UaeUVrHnRvddCR3PHx/ptpljzDVBFI0Dkg0DPW5eL+KrEUHgiO5OXz8g1EoS8XWM/4uthnbAQo82o9re4C4bT38+4T2NpfokXTH1nw6CrSeVoqZLdcW3JmR661PaysNfPMvMQ4f2Qef9C3Io0cQ4q/+mSAhHXo4kgyxyRH6tQ9pe1VpUagaULS3KPaRGnK6MlJ6phU9TrFL/rXFNEhBCYAB6xrni3cvl974bjIozCvukUC3AUWCx0QmJmvZlf/ireGccmSSdNE1lRLsmR87JnwqOMCtHKPkofRfSckZmrG4H7XhJMWSLDC/iYQCa7l/4efvPbb/PyOdmwW+lgpj5Tw7ufQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(261102123227099003)(22082099003)(921020)(10067099003)(4143699003)(11063799006)(261021121427099003)(261021123027099003)(261022075727099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXZuUDBXZlJCWmtXOEJwbkNnVnRVN0tXdS92K1RDTkVtakIxNlR6S1Evb3BI?=
 =?utf-8?B?Z0o3VmpEaitlSTB0Yy9ieUdjMWU0T3hrWVJBYXd0MXVia2tuSldsNFk1b3JV?=
 =?utf-8?B?U2lUbDNMai9HTGhBdGxFVUtuVlIxWFl5RkxCa1hoQlJEY0x0OGlJdlc2bWo1?=
 =?utf-8?B?T2wyVm9NdVlHc1U3aGlPMUFLK1R2Yk9LV1ZvcW94UkVETWlpWFJSTGxGYnJw?=
 =?utf-8?B?QW9CUHBrbE5KNHJSbVl6ajZSK0s3K2s2L0k0dkw2SFRSRW45cWdadzdhZC8y?=
 =?utf-8?B?Ymd2NzV0WmZHZ0hVVUU4aUY1aXNMZmR2QytISzM2YXc4MVpGUDJuTFk2bEw1?=
 =?utf-8?B?dmJyZDB1Q1ZPNTZ3MHRDWkpIV0lCcVRObmc5bUxMQU4rUFc0Zys2cnd4YS9t?=
 =?utf-8?B?NmVqdHNjMDdZUnJOWmcraWdZYjhNUzRoY3o1MklKRlpIeldILyttNUxBVDFD?=
 =?utf-8?B?Y3JBU0dZb2UzS1YvaDh2WkVvMkVUMXRoS1J0NFJYS1lJS2R3bHZuSHFnMlBV?=
 =?utf-8?B?Rm9wRm1IZkFMelVEeWx5K1JBTVdVdDluSFBqN09aYkw0N0puWENzNXhEZmdo?=
 =?utf-8?B?T1JodFllV1RNT3FZdExuWGwzRjVvS0tKRWJ6NG1UK1BwL0FoMG9nVEZ1WXow?=
 =?utf-8?B?Wit6N3JyamRqRW5OOWQwblROK09DcEl2cXBvdXAzQXVWeDJkNzlpT0JPWkN6?=
 =?utf-8?B?VHZRMU14WlRNRERydGVOYVhYdUdvL0dCcHg4Q1o2QlphVjFHR2I3TzN4S0Ew?=
 =?utf-8?B?ZXVDcEMzN2gxRzQzUHBNRmRYTVMvMU95NHdveXVJNTZhZnEyZ090cEF0YUtG?=
 =?utf-8?B?Y1U1NWpXRzY1VEJ2R2s4SmNRcEIrRTFqN2lRd2w0KzlTcklLM0R0eUcvUmNp?=
 =?utf-8?B?bzVSNEtVeEhLSFdmckRYeEtWVVlHUjMvdWQ4amZSbWEwQUFEcHBobmsyTmN5?=
 =?utf-8?B?cThjUTA5eFNkUnloMXpEbVVoWlRqQ01hbFpQYjIxQVptQkJRMmJQY3Vrdnpy?=
 =?utf-8?B?NkUzekMxak1JOXhVQThjYmZIbzZ2dEdLSFlQTnB1QVZyQ3I1bEg2N1ppRXZC?=
 =?utf-8?B?QXlvQ2M4eWFiNWRTNUg3TUcrYUw5RWx3WU14eFVTZFRiVVlzNFdNNEFhRHV1?=
 =?utf-8?B?elRmNDNoVHBkOWgwQVJYTjdiZks2d2RicUFoUDBmb3ZDb0w5L0M4Zlk0VHlq?=
 =?utf-8?B?S0Rsa3piei8vNEpGanMvTEVNa2s3WU1LMHl1MmZnWjcxaHZkcDJ1azl1TFRS?=
 =?utf-8?B?bzlBU0ZwY3Riall6N1hTeVhlVksrRDRlME1nSUNPTktTQllvU0xseEtROWY1?=
 =?utf-8?B?MFo4RWt1VStSKzZ5anh0YnlkUWtnKzZaTHBkQnc0VXhma3p2SG1HUTNSNC84?=
 =?utf-8?B?dVNYRHlHTEV3TlF2MHNWOU1MVWUydExpMDFodWk0QmhJVU9nUGtjTkIzR1BI?=
 =?utf-8?B?TUl1VGJkRkVYL2FGWS80SjZKWHp2OUcrcVd4c2hmOVJqWmVkOTBrUWlNYzZ1?=
 =?utf-8?B?cFFjenNENGxDTEFrTHExeDhDbjNPT1VRckVSSTRQV2ZkOStkalE5U2VSa01G?=
 =?utf-8?B?dmF0dzNISHhqMGJzdXQvWkJBdm5aR2VkbHZEdXpHNEVSZldDeDI1d3lpUGJt?=
 =?utf-8?B?TG1iWjdoOTdqY202b2FaVTZSN2NYd3ZvZDY2UnlHcW5GTFdiaHN5RllkQks0?=
 =?utf-8?B?S3JWSnU2V01KTGZSQmNLaHo5cmUraEJKMVZQTUlvUzV2QTFyT3BVSnJycDly?=
 =?utf-8?B?byszWENqWmZXbVJmRFJVbUN3bTNVRFVqWVdrZ1QvWjlHQmZRUUNDU2sycFRo?=
 =?utf-8?B?MUdhQllwVzZZcXpIUU9Sdk9CUE9wM3dreWVJV1BkVHF3d1FmQjlGN004R1Jl?=
 =?utf-8?B?d0psRTR6eFFDbit4eVJnZzBDN21DdU9keW1sVlMreloxSEJGeElwVzlTb1ZY?=
 =?utf-8?B?ZlYvMDN5ZjZYSzhsN0dxTDEyeC9hS2FBUis2NDRlRGdkKzN0TlFObWpkbEJE?=
 =?utf-8?B?NkFPTkR6UzNGK3hrR0U1WlZSdVY2OFJPZlhWYTlsR1Eza0JiS0duYjJmMUhB?=
 =?utf-8?B?T1U0QndmVDBKWlpGQ3lrMko4aGw0dVVVWlhrcUNWRURMd3pPLzB0NXlIZmJx?=
 =?utf-8?B?SlhucEVGZm5NK3hXV0puNFFrMWYrdWZ3UkIrODZHNjA3aTBPTEtsVThFU2M3?=
 =?utf-8?B?bkZ2SjJ4UGNKbXlPWDkwcXkrdWhZUXZkZ1hJUXRReDNvaDhGVFZPTzlDU2tw?=
 =?utf-8?B?Q1BSSVM5VDY3UTFWb0FFcW0veGszdno5cTRNK1ZZK0VEcHNwUDZFNWFRWkdW?=
 =?utf-8?Q?yCgX+NSH8ZW4iSOShh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8bbd3b-64db-4527-d8dd-08df395cbd78
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:44:19.0108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kUnBBTlj/RJwY5owekyn/mkgS9qArCIOIekGfyrzTENtUz3HXKZWTDqCnwedqrm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890

On Mon Nov 2, 2026 at 5:54 PM EST, Tal Zussman wrote:
> There are no callers left. Point the comments that named it at
> folio_clear_dirty_for_io() instead.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  include/linux/pagemap.h | 1 -
>  mm/folio-compat.c       | 6 ------
>  mm/gup.c                | 6 +++---
>  mm/page-writeback.c     | 2 +-
>  4 files changed, 4 insertions(+), 11 deletions(-)
>

Thanks for the cleanup.

Acked-by: Zi Yan <ziy@nvidia.com>


--=20
Best Regards,
Yan, Zi

