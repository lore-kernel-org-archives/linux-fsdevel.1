Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794289749;
	b=0aO30bbfJf90jkQ/t6VXKGaCbgxusdKbV2RV16TqH9BvGXp9zXIbgMvJgp2eL2W5kS42
	 3ojgzHXCL28/Q5MFe7B/epuNTEfYnOYW7YwIHpRuFX3+riX+rg96pe4t+bnvA0CixQqum
	 TDVj7pZrWs+IfLBsgRIY1pHCiGxuPjxgXOkvD3eC7GytjdPbSig/Oo+LPpQrvY20EW0QD
	 +PYMyss0wJU1294W1PiWGo7V3pqHKIfw0s67jZXHAGlCgRpr/g5/WREy8eEui20JzIegF
	 HSAmXf4Aop0Nhx7NCmCw1HhTXlLtIUw4h6zphRhicX+jtypBECY2Vu/7OeQtYAYyOnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289749;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=AyPLIpodHMNbvUybAmAZi5srMr8R+tKvg76kiTATWH4=;
	b=W0dxIXx1+RRkxQTGf/yJCJMZ+nZuMBujIHyNUnfVn9dEGEojEBOf1KqA7Nlks36RnwJp
	 ToJBWhLOn0KFrwxgEwcOWZBM3ul6C5Hrb6ihqyo6k2cqFywEwUennm24MI44iVJN87kcj
	 d9E0HxyKdcWyN882rpcFObK73A3iSreGJbA7yTVL1tUNgkTT3g0e3R5+RH5pX8RQaAMo5
	 KDpuViFWHnIblfQ1xQPPohiZwGAZGNEz552OtCka9M1ZhWiAduqELYjZdCbV/HciVtV2l
	 NSN7SyK0aHU4LkKzyq4T7ioqnXFjQRtrkin3mCFhRRpC0OFfLiEG7QbGfuGj/O7Uomw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=manhattantech.edu;
	spf=pass smtp.mailfrom=matc.net;
	dkim=pass header.d=manhattantech.edu header.i=@manhattantech.edu header.a=rsa-sha256 header.s=selector1 header.b=S0UDEiTq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.111
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021111.outbound.protection.outlook.com [40.107.208.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BCF60A2622;
	Tue, 10 Nov 2026 05:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40BCF60A2622
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manhattantech.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matc.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=manhattantech.edu header.i=@manhattantech.edu header.a=rsa-sha256 header.s=selector1 header.b=S0UDEiTq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mdlUy1KHN+l0nvzqkAiMZByC9HiOlV7Y6zA37GzcOcS+R6XtWViXwTbJJ5N9Rom8mqD8LLHk5/Ip1cQzoCWBD1BQkLGPQXTqSO+ov+9ddWLFwa5BI7SRR9IdpzcycVPb1/dN9PieXCkgsHZOag14KlvV160YF/TREVz0s7xH0KicRxoTopLJGNITs5Ykfm6g+hHtQoeS8AWSP1XRzHutmcYU6+saqtW6ODjfx2MbKXr81iAkCkTwvIcTArx+Y9QdrsaOdnj2YJYvFJoz9Vshkn06RDep624uDRM/h2zS08ihN0DTiVYiBWcVVHcAf47bUa1zpqcKwjrVTSp3w2J+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyPLIpodHMNbvUybAmAZi5srMr8R+tKvg76kiTATWH4=;
 b=cEFJATBVQJSziQ66juAhn79ofSvAbVCCiZU0WggPGo2xjnG0BtRQ3cV1LxNF0ZqsyakCGralqsMcKhTTtYlXoklMZd4W9ZmQtRbewLBberIm88vEYFfk8LS2hfrnCPfA6lz4wyJxRATjrRAgVfPgKCCGTIR3DW2JTI13muAdCwo5WwxNgUaB4lBqkDiP4kgNG/APhKQeSsorfDam8uIiDLvRpZTCykcsNjAD/vut+MtFz/adVB4fgU9vgmgtFRGsWWvpFgj/UbAUmlFQjnz2psEtuKIDzTDa5dmHi+PIqBVpKeGY9oIyFPEWTEeSG81cNWxrH4U2S/a17dVo7SPcpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=matc.net; dmarc=pass action=none header.from=manhattantech.edu;
 dkim=pass header.d=manhattantech.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manhattantech.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyPLIpodHMNbvUybAmAZi5srMr8R+tKvg76kiTATWH4=;
 b=S0UDEiTqDRiqd0cilwdwpEiThNB6SHPMPuSEmM5esbFw+oAM4qNpHbPMxu8LuEJKq7HG8PjYFvPa6fd6iqeWxK5Cde6wrze99tzfa/n+5KflzcVZJmXHf8cXqLm2+BvrckTsIJaL7xvDJvpbtbxx3Lh9jTwP5vJioUKhF59td2MfszLSS3JwKb+hBTzv9RhpdJQWwhvWwdtu0PF4/fL3nvUeuucee8eV9HHodMrrJGdo/2ny5Lvlv3A4oaJCr6yuRya8fgUfVGqnQVoT/7LmeRM8tG//ofx/8jDsM/xgIMpMhxAFCKzBPOjCrkv4myrp6sKuyxssdMvHc3e5fgnZyQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=manhattantech.edu;
Received: from SA1PR08MB7135.namprd08.prod.outlook.com (2603:10b6:806:1a9::21)
 by MW4PR08MB8281.namprd08.prod.outlook.com (2603:10b6:303:1bc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 05:49:05 +0000
Received: from SA1PR08MB7135.namprd08.prod.outlook.com
 ([fe80::1027:36f2:d644:13a6]) by SA1PR08MB7135.namprd08.prod.outlook.com
 ([fe80::1027:36f2:d644:13a6%4]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 05:49:05 +0000
Message-ID: <9ced619f-58bd-41fa-b8fb-863bd49d5dbb@manhattantech.edu>
Date: Mon, 9 Nov 2026 23:49:03 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fat: use write_inode_now() on flush to avoid racing
 the flusher
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261029-fat-flush-isync-v1-1-69c02c258d0c@manhattantech.edu>
 <878q3gth64.fsf@mail.parknet.co.jp>
 <457c34c8-b52f-41c6-8b58-ed334b0dc483@manhattantech.edu>
 <87ik2jsp9n.fsf@mail.parknet.co.jp> <87a4nvso7w.fsf@mail.parknet.co.jp>
Content-Language: en-US
From: Bryanna Marihugh <bryannamarihugh@manhattantech.edu>
In-Reply-To: <87a4nvso7w.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0064.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::15) To SA1PR08MB7135.namprd08.prod.outlook.com
 (2603:10b6:806:1a9::21)
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
X-MS-TrafficTypeDiagnostic: SA1PR08MB7135:EE_|MW4PR08MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 5854ca1f-e992-4574-57ec-08df3eee545e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|786006|23010399003|376014|1800799024|4143699003|11063799006|56012099006|22082099003|18002099003|10067099003|261102123227099003|261022105027099003|261022075727099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	1HxHEpqLPhC+RwAPwbupB4zUr1Top/N/R7AkP0R5mt89M/QLOhVfW0OWZk1BLsiB/Pr7AenQlnQfeewW4JqhAEH5hUvv6u94K0Xv2DLfsa8EwHpiRyrVKgiaOewRzg8JwOoZi5j/x7Z9FpgaZvY7xLjw35YKe9kbYoAXRfrWzBLmYpriVIOsWByFISnRbqNJy7YPs4tsLn/+5L1GzQj+g0c4nhUngwLOcx87DWIrxryr47C9Fn5ISmcU37yxuMQ2BOm6oEg6F9gLBqybRHieQ5Bg/Q+4hR8CXbjEhT0kajb7H8GzH+0JgYa8YOuJuWbN74IPO003qEQHj37//VzO9nG5cMvwIkwjp4Rjg/KgGpib9VffV+FzgpuI2oceu+zKCRYsxBgkATLbVIb9JzkJWMbRxhP2PSKYOBH6F0GAELYWuRTYzgE9KACMsAdidcMToA9h2Y6IRGThQU3liJMa9hPjLRL+NiOZL204HLi+uyOj4lKa47RaOHtDsVKRntosqTdfUkaGss4IhhdKv5dl81zy500mRTe9m/mKWV09Vo3AAFhdFSlWJdIZ7HRYt6Gsf5QpxlprgYdr6MzGneWJV/cNP/Z53rNgy4t5ZK1/hkWLj8Aif5hmPIh74dodOnyTX52cqDD30N5cMJ+ij8qYMRxpjuF83l0suVVrf77pmTo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR08MB7135.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(786006)(23010399003)(376014)(1800799024)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXBxbG1sTEhYZXVBMDFLK2c2ekNjNDY5Mm1CeU8rMFlEaGV6VnRjc2lKRE5t?=
 =?utf-8?B?RlpOY0taSjZmSjM4R2hkVkcwbURDWVhWSkt5K08yUHJjdlZsQ21kb0diV3VD?=
 =?utf-8?B?d1FleWRFN1ZuVGtZU0lRQkk1MWxESU1MMEg1SkdFY21ieFVORTZxd1MreVNu?=
 =?utf-8?B?MGYxeUxvZVoxSkw4VndJSXV6TDdRdEhrWC9DZVBwTnp0NWo2TXlmb0VkSzJO?=
 =?utf-8?B?SXJhZm42QmtRK3M2V0lGNmFzQnNiYkxkTmwvUitaZm5RLys5Ny9NbnczamU5?=
 =?utf-8?B?eU5BcWRmNStpaUNiVTcvWWZUMTAyczgzVS9McmxIOUw1aTZXQ2xzVGNJdlQ0?=
 =?utf-8?B?SERReHNOWlFaN0g0bWsxeGFjQTVsWlloLzMzSjl5a2drVnRGYjFwM2t4THNm?=
 =?utf-8?B?dDRjQlVBdGhJbGlOU05IYTAzdXNkWFozMEFrNmF3SU15Q0xnTFk1anBvTGJZ?=
 =?utf-8?B?dE00allZSy9lVVF5SitldVVVc050UHRrQStOVDFIRVRRd3BsbTVseVFDdXpJ?=
 =?utf-8?B?N1UvdWZNRXhNUmxXZ1lkNitFbU9PY2Jsc0ZUZTAzTzg0bTJsR0EySHFUL0FD?=
 =?utf-8?B?aHlyeWNUTXB5WjdwR3lKRkNEN3VoeG51QWVjTUxtNmFDWHl6aC8yU255TndB?=
 =?utf-8?B?N1FVNkNxekorbkJqaDZVNWYrdWVhS3ZQYnBQejUwdlRIVWtTcVZFQXZVaHRq?=
 =?utf-8?B?Vm1PZWtZNkd2ZUVaWWtnMGJWK1ZtelE2bVl1dmxCckFraW0rSFRhVXAycU5U?=
 =?utf-8?B?b0JDbUQ1OW4wYW02WmZHZVpUUUlmbU9WWWkvZTl2N1QrTnYxbnVsWGcxL1dF?=
 =?utf-8?B?RE5hZHk4RXhTQ1J1NUd4L1pqdDVBNFQ1WUNTWVhoTXRyRXk5N3dRbzR3cEU1?=
 =?utf-8?B?WVF0bDlmYnhCaE9vZFpSOTdlQ2g3dy9mVGtMcWlwK1lGMWxkVTNQaUZBZmpM?=
 =?utf-8?B?bmdrbHNwcldyTFZsMnBXODNYSFlkL2VQN0hja3k4VlhQbEhFNVZBYVlyNzlv?=
 =?utf-8?B?RTRmTEsxZC84VVlDMVEzYkxUTmJkWnV6SGdrMytKek5PUC9waDZPc05kaHdV?=
 =?utf-8?B?Q3Y5RzI4MmIyTXh1VDBRMGJGRHZxc3UweWdqblpRbmFtWFYrT0ttRUo4aXY1?=
 =?utf-8?B?Y0UvQWRIbkVDSUFFTFc0TmNXbSsxZ09SamUrMUx6ZEEvMGtEbTAydjV1YUxw?=
 =?utf-8?B?WXZLcUE2bGJKYm1xNUU4bEVtKzZRTmpTZjZCQkxHSlozR2RDNXFIR1Nybkpa?=
 =?utf-8?B?bjhZdmdaZGRZdjIxT1VYbXQxVitoTmlPeVVDZEFxd0M4d0gyWkZlbUZpUlIz?=
 =?utf-8?B?U2tJNTF0dGFHNFFneUE3MXdCeDYwQzNwYk1UWFJqa2dlMmUramZpN2x2MUhD?=
 =?utf-8?B?MEp5Wk1mbHZ0akxOdDFBWXhPcHhpeWVYVUQ4L3VVaTcwSTBRUHRha1R4NHFo?=
 =?utf-8?B?NGZrY3ZHMENQdGlaS3ZpQ2R4TXdWNWkwR0d3eFF5ZkVQNnRyMjlaZ3JpRW9D?=
 =?utf-8?B?ZnRNcTNMZzlhT1gvc0psdGtaNXltbnlVNnBaZVp4MEk2L1pub2NWcjZLaXlZ?=
 =?utf-8?B?cVpadTZTbFU1eUtjRTVja0JDa28xWFlXQTBET3lJb1BtcFViMjJFc2lNb3FK?=
 =?utf-8?B?U3pOVWNJSHRndGhHRjhLY0lRbmhTbmVzOWF5RkY4Q0xYMFFVVENENXFUNDRi?=
 =?utf-8?B?NlVrNmdDcGZ0NEFXWncxektWYStGM2x0N0R2WVJCNHNrYVU4bC9ZTkJNRzh3?=
 =?utf-8?B?SEMxZFJ0WHNLYzY4WFhVMFBTaTl2UDNUMG1TL3hsNXhJeVRsdDh0bEFtYXFY?=
 =?utf-8?B?Q1pVZ0pIMENNaWkvY1AzaE5SL0hWVEtYUEJReFk2d3U4WHZPUnR5Ni95U0ox?=
 =?utf-8?B?Zk1jN0p6eXVRbGhXSHlMTXdDOVdjaDFCdjl0M1IxQmVGMlA2a1V5T1NDQTJu?=
 =?utf-8?B?a2s1RkdscDQzL3lUMC85eVZqcGRmMnFjMW9mb0xqc1VUMXFMNUxqM0dhNm53?=
 =?utf-8?B?R1BpY21CYlA4QnBqaHdjaEpHbTFBR3oxazJ5YlArRjAxTTYyd05pWEdaWVdP?=
 =?utf-8?B?WHNuTXZmVHNkbDVhaWhJZS9ORHQxRWV3OTRzMG1BSXB6L1Q3TWEydU5nYUZj?=
 =?utf-8?B?UlUxRUNSQXlkYkM4MUdJMXQwblRmdGZwVWZSTTdtUGExQlVNRTAwWTVRYWFj?=
 =?utf-8?B?ZHcvOUo2Ri9zS1A2MFM2dW1wMG9SNTJKUmMxL0VtbTFrZjVZcDl1YlFCcVVs?=
 =?utf-8?B?dGcyQytyM1JsaTNWdG0xNmRHRStUMWk2Q3B1ajZKNjVST2FBWWdmS1ViZHJH?=
 =?utf-8?B?YnBJZjNRVlg4SWZlOWhMOVRValUycWxaV2ljZUVmK3djVWdnRjMzeGd2WC85?=
 =?utf-8?Q?n6Ik6dVGMIrNHSRU=3D?=
X-OriginatorOrg: manhattantech.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5854ca1f-e992-4574-57ec-08df3eee545e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR08MB7135.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 05:49:05.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 21e8bc52-a9f4-4adc-8133-b5f395a5ced1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+s2IKPndEmQeUMTOVWfEXNLl1BWkK7LB/KPq1uqmcNYZT7S7a3gKxHUIKGnZwWqqXqFSHgk+e7HDcs+Dz/Rvg/aDiBbgB0Nhie6ijaw0H8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR08MB8281

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:

> > Bryanna Marihugh <bryannamarihugh@manhattantech.edu> writes:
> >
> >> There is some regression with small files on the uas drives from the
> >> wait.
> >
> > Is this wait=1? The flush should just be early flush, no guarantee to
> > flush completely. So I think it should be wait=0.

Everything I have posted so far is wait=1. I just wanted to provide the
benchmarks for my existing patch. I have a wait=0 one I have been
testing now. I labeled it in the benchmarks.

> > And the flush is assuming basically for removable media though, we can't
> > choose. I think we need to check the result of such HDD/SSD.

I did tests with this machine's dirty_background_ratio=5 (the kernel
default is 10), which results in a 3.4-4 GiB threshold, and with a
256 MB threshold (dirty_background_bytes=256M,
dirty_writeback_centisecs=100) to test what a more RAM constrained
device might do. I set FSINFO next_cluster before each HDD run so all
three kernels write to the same part of the disk.

WD Blue 500G 5400RPM HDD SATA
copying a 4 GiB file 3x, then sync, MB/s
(requests and average size are from the third run, which was traced)

  5% threshold
    stock:  89.4, 86.9, 87.8  (8,913 requests, avg 471 KB)
    wait=1: 97.9, 97.3, 95.2  (2,168 requests, avg 1,951 KB)
    wait=0: 96.2, 95.7, 98.7  (1,626 requests, avg 2,580 KB)

  256 MB threshold
    stock:  81.0, 88.1, 81.4  (16,291 requests, avg 258 KB)
    wait=1: 100.7, 99.7, 98.4 (2,257 requests, avg 1,859 KB)
    wait=0: 101.9, 100.5, 98.7 (1,532 requests, avg 2,738 KB)

WD Blue 500G, copying 1000 x 1 MiB files 2x, then sync, MB/s

  5% threshold
    stock:  9.44, 9.45
    wait=1: 9.34, 9.32
    wait=0: 9.55, 9.58


Samsung SSD 870 EVO SATA, copying a 4 GiB file 3x, then sync, MB/s
(requests and average size are from the third run, which was traced)

The wait=0 runs were on a different day.

  5% threshold
    stock:  338, 340, 341     (1,460 requests, avg 2,874 KB)
    wait=1: 333, 339, 339     (1,366 requests, avg 3,071 KB)
    wait=0: 313, 313, 313     (1,792 requests, avg 2,441 KB)

  256 MB threshold
    stock:  377, 378, 377     (11,476 requests, avg 366 KB)
    wait=1: 378, 378, 378     (1,675 requests, avg 2,505 KB)
    wait=0: 346, 344, 345     (2,278 requests, avg 1,938 KB)

870 EVO, copying 1000 x 1 MiB files 2x, then sync, MB/s

  5% threshold
    stock:  9.61, 9.61
    wait=1: 8.92, 8.92
    wait=0: 9.61, 9.61

PNY 32G USB 3.0 (usb-storage), copying a 3 GiB file 3x, then sync, MB/s
(requests and average size are from the third run, which was traced)

  5% threshold
    stock:  6.4, 6.9, 6.9     (12,481 requests, avg 252 KB)
    wait=1: 17.5, 17.9, 18.0  (3,720 requests, avg 846 KB)
    wait=0: 17.9, 13.7, 16.4  (3,809 requests, avg 827 KB)

  256 MB threshold
    stock:  5.8, 6.1, 6.0     (13,996 requests, avg 225 KB)
    wait=1: 17.9, 16.4, 14.7  (3,575 requests, avg 881 KB)
    wait=0: 18.0, 18.2, 17.9  (3,663 requests, avg 860 KB)


PNY 32G stick, copying 1000 x 1 MiB files 2x, then sync, MB/s

  5% threshold
    stock:  5.49, 5.62
    wait=1: 5.82, 5.62
    wait=0: 5.66, 5.65

Samsung 64G USB stick (usb-storage),
copying a 4 GiB file 3x, then sync, MB/s
(requests and average size are from the third run, which was traced)

  5% threshold
    stock:  33.0, 33.0, 33.1  (12,725 requests, avg 330 KB)
    wait=1: 33.2, 33.1, 33.2  (4,521 requests, avg 928 KB)
    wait=0: 33.1, 33.2, 33.2  (4,583 requests, avg 915 KB)

  256 MB threshold
    stock:  33.3, 33.3, 33.3  (15,757 requests, avg 266 KB)
    wait=1: 33.3, 33.5, 33.5  (4,534 requests, avg 925 KB)
    wait=0: 33.5, 33.6, 33.5  (4,645 requests, avg 903 KB)


Samsung 64G stick, copying 1000 x 1 MiB files 2x, then sync, MB/s

  5% threshold
    stock:  7.34, 7.34
    wait=1: 7.33, 7.34
    wait=0: 7.32, 7.35

I was a bit surprised by the improvement on the HDD. I will see if I
can find a high end HDD.

With the SSD the 870 EVO I did the wait=0 test on a different day.
Not sure why but it seemed to be slower on the wait=0 test, I am
blaming the run being on a different day. I think performance is
probably mostly flat with the fix.

> And maybe it needs to check unmount time (check how many dirty was
> missing to flush).

wait=0 does come with that downside. If the flusher is already writing
the file at close, wait=0 skips it and unmount has to write the rest.
At 5% the 3 GiB file on the PNY stays under the threshold, so the
flusher doesn't start until the 30 second expiry. That's why stock is
still slow there and wait=0 behaves like wait=1. The 4 GiB files go
over it.

PNY 32G stick, 3 GiB file, cp then umount right away,
average of 3 runs (5% threshold) and 5 runs (256 MB):

5% threshold   cp returns  dirty at close  umount   total
stock               485 s            3 MB   0.6 s   485 s
wait=1              184 s            3 MB   0.8 s   185 s
wait=0              180 s            3 MB   0.6 s   180 s

256 MB         cp returns  dirty at close  umount   total
stock               513 s            3 MB   0.6 s   514 s
wait=1              176 s            2 MB   0.8 s   176 s
wait=0              2.6 s        3,004 MB   172 s   174 s


WD Blue 500G 5400RPM HDD SATA, 4 GiB file, cp then umount right away,
average of 3 runs (5% threshold) and 5 runs (256 MB):

5% threshold   cp returns  dirty at close  umount   total
stock              47.4 s            3 MB   0.8 s  48.2 s
wait=1             43.5 s            3 MB   1.2 s  44.7 s
wait=0              2.2 s        4,064 MB  42.3 s  44.5 s

256 MB         cp returns  dirty at close  umount   total
stock              51.3 s            3 MB   0.8 s  52.1 s
wait=1             44.0 s            2 MB   1.3 s  45.2 s
wait=0              2.0 s        4,021 MB  43.2 s  45.2 s


870 EVO SSD (internal SATA), 4 GiB file, cp then umount right away,
average of 3 runs (5% threshold) and 5 runs (256 MB):

5% threshold   cp returns  dirty at close  in flight  umount   total
stock              11.9 s            2 MB     362 MB   1.1 s  13.0 s
wait=1             12.2 s            2 MB       0 MB   0.9 s  13.0 s
wait=0              1.5 s        4,006 MB      22 MB  12.3 s  13.8 s

256 MB         cp returns  dirty at close  in flight  umount   total
stock              11.9 s            3 MB     112 MB   1.0 s  12.9 s
wait=1             11.9 s            2 MB       0 MB   0.9 s  12.8 s
wait=0              1.7 s        3,350 MB     180 MB   9.7 s  11.4 s


I can type up an actual patch with wait=0 and removing the helper
that Matheus suggested.

Thanks,
Bryanna
