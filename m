Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793677495;
	b=Bm9cqY6ep8D7h1xToBVNW9yz6ZLJHWpXn+na4kpqE1M0ME6zGBs9/M6GAL09kUjQsKI9
	 FdFxtGnqptbjBi1kNePF1RT6zYK0fO0bldh3tfR06UFOl3K3OQ76XToKlfjSjkKrNuiqU
	 ZuJHUfPqQQYmnnNWQAQAr0kZh2i2Q72ShJGLTQ+oLEHzPZyY8ayFXASlZC8rRS40jSExz
	 3seY1EwLkfcNIcmqhWk44SoiO+MNfW98ILI484EZosqYSqhUUZGTAckPukgdV3mTmaLmz
	 VarQKRIhZSHaTHZPlSHdMvfPE6b6j8G5IBTJt0FbaQv7JdyP6c3vKnExaNLdjysSVQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677495;
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
	bh=MYiLWDQqWBIeJt74rCt1ZoHlrBNw9kmuRtqwIBxpr0o=;
	b=b8sK50w5C0h0POLKM35tW0N3louBoFIZE5NWUrIEN9qL0KKUscfUR27dFcBNpN75rAzE
	 WxssvVJpHfffJs10bh5Cv2VSUlMhu+ptRbyYg46g6NXYERkBssYSWBZB/poG+1QOHznZ3
	 e6pxBYEukjn1JFCQTtzQUH0Pmi8QYUTM9ZRmjmkWm876O5PFQtOoNlxjOEvAfCyc5WkCn
	 7pVpZOv/YpCJZvq8+TkVz6YbB7McM1CbGukMzY+zQBU7f0uODPH69k+J9FRdM8Q7Rite/
	 4KPUkVz832txsBKmlkYY1YJjLp8xf7poNYcPGHvj/0vRbXMgpp15v4A9m08mVj3tEhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=L69GN3Dj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.45
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19157606A324;
	Tue,  3 Nov 2026 03:44:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19157606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=L69GN3Dj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbR9NGJguvgjvHsp/HAqujqlgOtlA75cFs4EUCp0s1Bwx48Io+T1HH5J0K45BJ5KAoffjFygneIQnqGxh5BMiNFDdUrqFIsk6Td+TgLKrBS1rfWqfndsf58EgdHj7ajhSnf0qzxCDKpg5hV2qWDRfPPiiVD0WG2rYjEX4acgH98V/U9fteY+x302F0DbyWuMr1UI4ZHhAbHxZ16gssGUgkn/Q6WIRVKantC197jDQLb7Af0bAngutGp7Rq8Nb/c6GOavTxvrEx4R3sRpVpcuiL6oI5oeRsfhZtoHrDPrZYu/Ec+4TAXgKIWRxDXilyvps0mX0dKt07xK935fhtvTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYiLWDQqWBIeJt74rCt1ZoHlrBNw9kmuRtqwIBxpr0o=;
 b=AVP7AVpjmtSDo0oFtkCQlrz+peb3xhGujkty46IhVmdbwCZ2FDeCHTqOqIWwwtE7YMXFSLhe/16tlS1b4q9RXfRVnchIaFn4t2iHWBxo8NpDajMUNjcZW+h/NhHkAgOZ7MPMD3aU2otExnWLsvyBL/1BP45oP16s4Q42JNVDKMhw4eVPmFyiXmJOPULvcorWceTFj2HmWHJqMLE+1D2WnlRs4p1cVUu45hfH7RGfF+04jCWbxlgE8JHh8A8jb2+PTBPcd+/JwbRnNW8NaxcMmY46rYdMdbYNQFSHyjybJTFU2SXPzSe9e8ywWbJIkhyiEVdXQNCtSwzS0elqOdQYOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYiLWDQqWBIeJt74rCt1ZoHlrBNw9kmuRtqwIBxpr0o=;
 b=L69GN3DjZvOijPJHx+kU4LG09zeYoYTmr0v9cEVx9mIg5lWDWuMY1UoIPrTdiI2zj9YawIMy2RQAZDvcyOsSXxnJ/9gxLf0l598MG6SL8q5lv2TbRS+20RqAmdzqPZMUDJoT+wWMDSnBXEURRcHkUWjboCn6lOBTun4Hm2eMppo9/zFJ5wqvMZ6W/UAtTZtTsScXzaBmJOziUXC0l647MsJsE5EID24kUXGMXmn2RKEYdj2SCqUkuN30M6OXgBuHnn8zafqIcRoy8I/oJHV0Z+iMSXhCpsiUPCoyD9COg70hYfGPWHoYEKnPB5f4G4XVB+mBJ13HIOaKDJ+KNsP/Zw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Tue, 3 Nov
 2026 03:44:50 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 03:44:49 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:44:47 -0500
Message-Id: <DML9LQ35B7ZO.4GGNV42WNFPW@nvidia.com>
Subject: Re: [PATCH 4/8] mm: remove attach_page_private() and
 detach_page_private()
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
 <20261102-page-wrappers-v1-4-e7280bdb31f6@columbia.edu>
In-Reply-To: <20261102-page-wrappers-v1-4-e7280bdb31f6@columbia.edu>
X-ClientProxiedBy: CH2PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:610:52::28) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 1aebf8b1-8cc8-4e3a-014f-08df395ccfcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|921020|10067099003|4143699003|11063799006|261021123027099003|261022075727099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	C642E0Pov6kEBEFR9VeClRF4VXLPf9fLCsc2yAa7FEOanSwN+puGT2P/FWEpsUOCrjdpdmwska5HfIvxAWBh3NSspVOyQ/OzTLyjjDBGH08h17iaO+vfVf6L+3N3mIanNZCskcO9NKUV3L6zhHzUvACOsY0Tq7RcHTHutYZQgCnvnfkM9Gr1yTTjxUxfaaHKo/LLcSf6gG7oIj8ZNTqydHkwDAMo0rn0Y8fjr2N/Tg4VeclsBv28p7cQOqx8nd9i/IVLzI6R5duHOX4YdGx5KHUM/W1ZgGD/CNw63sjuYCExkW2hwh1srIIcn7HbXMWtaxq5Zf91a4+QreYE/2gG1RfCdzuXMMA5MXuhMrrhzwZnLnpK1b7LVvMyBoCE0/C1ckJMmHMQ4qUq15orkByLROPSqfNoj61drx6YlfTcD0NLsXWT/7WwzhA5L9HhplPVw3FZ99YMBHZLocyHvKLQ9Lu6XIOvSyAUe+evvVZtRR9EBzVjFW2Md5ZWvfNBXpyM6Res9BAr6RsDxsqiwFzOS9pQryZkVuT28fwv2Ro/jkVI+ByB04xurPe25qcbmMCGVKwG9UzL3MpXXG68an2Yna6CfusjtbttWi+8/ZBilNLQr+t8g9p55ZicNMydqVZX6sNULVgOnipz8XLj/NKYDbrV2XnHK3ssVV6h2aTa4LnzQ7MjqZ7Z32w6jNaTATZZGS/61Ogolj/Eqln3pHllnw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(921020)(10067099003)(4143699003)(11063799006)(261021123027099003)(261022075727099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVowUy9zemVTbXBoc2oxbTJGSG45SHFQdkw5SjFucEpWZldsbUtjRHN4bDBy?=
 =?utf-8?B?emxqWEtyZ1dCRkNGS1FJVlJ4cTZibXBMYUd0Zk9LZFZmd0tuZ2c0cW9wbFlN?=
 =?utf-8?B?azRrK0E2MjB1VHNIOWhGbFRIWm5IeWNXNHg4WFlBTEdHdXIrK2ZMUjkzK1Ux?=
 =?utf-8?B?aVVGWlpEbVFaY1Nscml4aXowSkJESkdtSDBJVGkwNE85V2tvaG5yRTczSVlI?=
 =?utf-8?B?eWtnUVRUeVROYVVLa1ZHNVNyVjArRi81aU5aeEtPQWlpZkJGT050bFlEckFG?=
 =?utf-8?B?M1p0enlJcE43M1dHWmEreHY4cExpZUc3YnA3UE5iT212Z1psNTVGSXY0QlI5?=
 =?utf-8?B?RDdqemFkRW5rL0JNR3FGd1c4S2RJMkJiYTNmTm9YN1lXaXNTbHd0QzV4SU9Q?=
 =?utf-8?B?RzU1bkptNXNTbmxhY3gxUEdCbCtXUGYzT3BDUDhuN2RCSVpFbGs1QXVWSFBV?=
 =?utf-8?B?L1A3L0djaFBDZHdmUVZJR2ZaRjY0Y2lnTCszYjd3dEZzSHAxUkpjZXJjekVH?=
 =?utf-8?B?dGxvM1dFZVpqdVBzRFRBWVh0RGFDc0NBNEpDWHJkL1N4akZ2d0haaEtMMm92?=
 =?utf-8?B?VkF2eDZZR1kyNWpjMDV0U0xRMEo1OHUrbG51UWlMU0k3NUNqeGg5VFpVNWRj?=
 =?utf-8?B?bEZ1ZmNiTWJBbXp2TXd3UDRhc29LOGU4YUpOakJUV0JFbndNY1Z2WlMwUWp6?=
 =?utf-8?B?NEVCdUVHcWZmRzhraHRvNmkyMFdsRWZrVUN0ZU1kWHg5cVhIMTV4a2pQQUNp?=
 =?utf-8?B?ZjhhdDFJNjNmcXduT0xnSnRmWU1WdUd0WTAyNVZaQTF4aVlQZnpZcWM4Yy8x?=
 =?utf-8?B?cWdFajZ1bWVOV2x2WU5aMDJvOVpvUzBvcnUvV1dXTnJNYVQvaWdYVUtOVFpS?=
 =?utf-8?B?UVhSQlhlK1FXTnEwOEJrVkxUUjJocDFtSENTT1NmU1FPMGdvQXJmWmVENW5C?=
 =?utf-8?B?eTM2Sk1Tb1lOenBudGhTVVo4YlVMcGtQcFdnTEUvaCswa0pkSVAyK3Azc05p?=
 =?utf-8?B?T3BoVm1JZHFGakZmbHR1ZzlTNCtIMnpFMk9nWGhSY1NsTTJ3ZS9VY0M4ZUcx?=
 =?utf-8?B?alBCS3lEMnY2ak1ib3E1N2oxVGx2OWcxaTZHQysweDVHOGRkMEdEKzVCUzFX?=
 =?utf-8?B?ejNDOUhtc1VKbWJ5cmtER1ZmQmtFaHlYbjdkSC9iSHVxTlhLTHcwRGZyZmhC?=
 =?utf-8?B?dW5ZVWpybnpRTGZyczlPZHlwOXVQNGZzOTVvR3Bkb1kwSEs4eGNiL1g4K1pW?=
 =?utf-8?B?OUpRR2NtcVU2d01wQ0F3ZEJaTkx3V2x4a2VkS3hHcWhQRTNVK3huZnR2ajRv?=
 =?utf-8?B?c2JiclU1c0l0RVU0akJ1SEY5RHo3VmphSTVnb09ZL1RnWFJoaVMyT2oySm5j?=
 =?utf-8?B?M3h3MCtvWXRXc0VTbWhEM3NSY01XVVJybXdQdEZaRk5xZ1dzdTNlaUkxTTJF?=
 =?utf-8?B?WFRQZWZlOVNCNVlCbnlkdHJPU2lGc2p3aEM3ckovaGNOVDBkczlON3A0WWk2?=
 =?utf-8?B?U1NTOWxTdHNYZG5hWFZwN00vT0xmY1NHcm01V28wcGNJNW5aajBCOVhweG5z?=
 =?utf-8?B?c0VDNE9XSkhlSkgweFcyVW1SYVhsWFRySmxRU0tnaGZYVDdNMy9SLzRGVjVX?=
 =?utf-8?B?dmM3TXpRTEFhMWJodGMyS2dFZ1NyQlpVZEliN2ppRVRTUWI3M2QwbVY3SG9y?=
 =?utf-8?B?VC9QVm03YlNkd21rakdiQ3NZNDQ0bURxQ25aQjNsczNxMzQ3OEVQalIzV04z?=
 =?utf-8?B?U1Z4N05jNWZlUDZqWi9YMzB6Qi8xY0o0bUtmMFVseXVlQmg4NDV5bHpReklj?=
 =?utf-8?B?T21sOUp4SCtOOUNGNytwYndjWnlZQ29hNEpwV1lKeXBpV0V5N2krN0dwRURR?=
 =?utf-8?B?YnFzS2VJTnJHNEJodjhzaWUrQitSdGFQOTBFeDZxZ05KbWFwVDFMaEx2UjZt?=
 =?utf-8?B?eVp4ZDlhQStDUEZzNGlseHFteDIwRXFyOHpEMzYxcVZ5VEpNK24rUU5VeGIr?=
 =?utf-8?B?YWdYV094NGRXTlo5WFRLT1UyWXhXR0d5VkhRS2wxV3AwZEVGY1d1azB3UVk4?=
 =?utf-8?B?Ry8vem05eHdIUXRNQjVpUWRPOE4yamFKby9TVFZIUVh1dXhweXl2ODMzdDZJ?=
 =?utf-8?B?UW10UG01ZlVrUmoreVFkVGlRbmVkSnp3QjBiSUszQ2prajg0LzV3ODBQclZp?=
 =?utf-8?B?bzU5aEVzUnl0elNqWHh0MGs0SmdzdjZNZEVZdUJCNE1oK1N4MGlxSUVHYk5I?=
 =?utf-8?B?dlpWSmc3TE5kVmJqOHpNMTFtS012aHN3Ti9FbXJMaGlhNExVUTZTcmtpeHY3?=
 =?utf-8?Q?Lda7pab0K8u4akwC9f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aebf8b1-8cc8-4e3a-014f-08df395ccfcc
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:44:49.7522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCNg6KDHMXI80cDR6A1SxmBs/FQb9s4336Y2sDfAPMen4bo5UQFeLWKubiTOtbHo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890

On Mon Nov 2, 2026 at 5:54 PM EST, Tal Zussman wrote:
> There are no callers left of either wrapper. Remove them.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  include/linux/pagemap.h | 10 ----------
>  1 file changed, 10 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

