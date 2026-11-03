Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.58
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793677519;
	b=mVacGg2e2HQD30C/FsInGu7pplly2vXFt5DgqzJMwg0zxuexft/ESG0rkwzvH+ibAPeO
	 tl096uD/YEeaIux5za7OsD6s5xvjd6Z2BOPKbZRJznc8Qn3y035ZYKmSBhNUv0AMpU33V
	 M9Kl+hkfnybAkJONOU9h9bPPnd4tJEG3Wb8j3PzLwDLnc+rS7LRpPL9cXKJEkAuyzvgNe
	 z8B4+BHDp2QSaCEHdlrqHpoF81P9aCssCOTO38I0Q2DelLe7ljGIObFaI41b0pdmIbUwT
	 ZaNxDMmW88txvtpAZqi/SC9f6yYwPbeM9smY2XHhVkhasn/rqLjyr6oryETOPoUtG5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677519;
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
	bh=vyGB45prwHE+IqhIs2DAboNFGgxXM965eELk7LfDYFo=;
	b=M8WIWge8qP44N1rkx8TVCqzRNpWwsy4sXuvqUl3QFET6YVFk/Hw5k85XRKw/vMIe21DN
	 NZxPpWMu3q5xj0w2kogiuM4S348JAkp6rTs2YzWme2vDrr3h8LW7QvD9nz9VIYOSipF3S
	 RaUE9v5CKkZjY5HcKdfv3jlYMuJzwOIEM29T/2z4+Qe5PXP9/GFPfDcIX71G78h/4nqUs
	 Ssmd2gLt/9Fo4hR2wJUJGehuAScJ4F5/D2nA6yn0ppLhVJ+dZ7Zy+5k2l3dKqHBdGOXuE
	 rFfghF9zMXAIt3L20Yx/oCix1hbSpQxzNwXAfqRFOaBqt/zEAE7cO0BY5xNygVOVPaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Z3s3HzrU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.58
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A78606A329;
	Tue,  3 Nov 2026 03:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93A78606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Z3s3HzrU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUZ11TZTCulOswkfYEEomB/Rn1ElNYhQJKAB8F4fc+YFb/8rXEi5ITCzTZlk5z/iCwytRWg2EOegtQSlmBz7Eagcpr1usInpDmcjyNtSChlbL5Uw5HmX3yTvucM6maO8Jgn7jP6vzI/9PZAdgoCrXY1ZyJCs7d4CE1R6vH5imnDQNqjTOi1e1pU0cPTVtpLXgoSPw/r2736zXlhd95uj8CWLHr88t+qHUiSa3JN4t5cY8OLFuPEtnO1kTSOffmKvPux49ipLUlEVsVcuhot3O/BySbm/8Yy25nEi+BmJMpZs0QiiQXKr8ERRQGp1+InYUCsUUhURBzPeMCVeyyu8nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vyGB45prwHE+IqhIs2DAboNFGgxXM965eELk7LfDYFo=;
 b=HKx8FG4IvAaoUcMGHxqIRJ3Jgj3bs5K47fT80ndr9oqcbmnCEL5iCgzMwyCGgeWPnMIOXepBTAW8znuP+sjEPTvYrQK/xsFJ+PliwiMZKWL/VXYbHaDCQ1NcMxx+bDwnxZKLRM43Vfl78xeIxCSrHUsrfH8gTguA02/SOcx+/Jjm5hcRXd/VTVVvtR0yXoNRgI1lQvt7AmBbCJvCYL6QU9K+4DgscgnhPrn3+7DlgKIAI6AZLbNoAqNiMW4Be/y0EFHBfPVElmQPPEUqQ8ppGzp6C/Z7L9KDMXc6xqNF35p9cDg0QGPBITHd5IzsE5k3D+l5OzWTUX2Dn0RwU3G/Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vyGB45prwHE+IqhIs2DAboNFGgxXM965eELk7LfDYFo=;
 b=Z3s3HzrUH0mINae4fFhyYIDcZ9Kaw6EreAvkmzgKWedLx7cmS3PACuf0K/yRPSj+QdezXstylDERcZlsMvCbAnEcUP3cbvHCAoZ3pEzVt+ueExnctOH3Ayfxj/LA8PH/cikr45ZACYU5kQjwsCuCjL4sdBM1IKS9mSK3qlCCMlLQCxT6kVRazb3mlFR+uVM3IGmMSV5bn20waOMzHVYhUYhPTF4ev8Du3ZapT9MDh+3dllAhVyQ0KMH2lXIFKYnbxLHHWySSdVNfEXYJT4qCAOLgayJKt0o9lVgeyCmZbh/13fc6hwH2JgC5SciMBW9iX1nXlLf0fm87lNtX2884kQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Tue, 3 Nov
 2026 03:45:13 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 03:45:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Nov 2026 22:45:10 -0500
Message-Id: <DML9M0YCK0WK.1TEXBKALZLTRB@nvidia.com>
Subject: Re: [PATCH 5/8] mm: remove find_get_page_flags()
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
 <20261102-page-wrappers-v1-5-e7280bdb31f6@columbia.edu>
In-Reply-To: <20261102-page-wrappers-v1-5-e7280bdb31f6@columbia.edu>
X-ClientProxiedBy: YQBPR0101CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::19) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: f866791a-ed1a-4241-4fc4-08df395cddc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|18002099003|22082099003|921020|10067099003|4143699003|11063799006|261022075727099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	D/O+hz0E0JlCldWhEV+qVe0AW5El1Wc/WMKIfDOSL7REwz2tZ/9JXhVA7ofFKtJRgDkKtpVxjOWqQLfx+EAOfN/o08b3h7VrJ3yO6hlGhYWjNFpkOHraxjPfdQ/X7WHX4/hGvpd5q78SezEm7EUGm1nuESlorhLeYDXuNoEnv/BpvlxA2CgswccpW4Yoqw0LNJb+Ak8Wi5SvyusTZqCDZT4OoEUTudb0v0sNbd+IsszaAnQDD7PLeq4Gbw8/XxbiniKPvA6PfmrHz5p/mxQrE4hMjg47znMzEAQkOh2eElACPIz/RcMGQgNeK0rQHEawl5tlhPjmEPn1hyTLot00UXKkdKE6742BgnikQXhf4l1BHBpxaI9ZiQO7Gk95DELPiEURXaCfXjUgeNVRdm9QVNepe5jr0f0QKPbBYaVuQOnq5ee0hFY//IjOxZQusL3BbJ9bvMxzRXX7HBQpOaPYktaNld+sGrgmjcbN0yOrjSqEJQrJxW5cp5V7Ld214LfyqUDNdihfoGaB2g4GJuk4OL6L2Tme4J0r54kDQivc4ynPe5ixq+S49aHLzFsiIT83aWw9SpstcpCfilJpbNm5eC5P+Yz+306a5EAKLzYXalN5CNRTwI0/Ujpd8YEdVIvHIMl28SUpvczz5g1Bh3upZxN0PtaTSoVexGcEl69QZPlJfHfRG95vsetQNWguASLHe1pnp3ZsUccaoDk2uQbAyg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(921020)(10067099003)(4143699003)(11063799006)(261022075727099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVZzbTMzUjZSeVppdGVEc282TWVjeUwrZ251TEw2cU9PbS9WYnlLT0RrRHBa?=
 =?utf-8?B?MTNpc01DYkJqOGdya1l4b1dpaGtMVFlSZ2ErRW42aE9JRG0zUFcvQ0dlekFx?=
 =?utf-8?B?OURiZWNvUDV6K29LMmlnOW1rWmRNeXRXaE5uQ0tPTlRCVDk5ZlFGTHdTY3JG?=
 =?utf-8?B?Qk0waEl4TmV5NCt5bTkxeGdsTUpQekRLVUpLNGR5R2FpSlU5WTA5bnhRdUZQ?=
 =?utf-8?B?c1VRRkhUaGFOTFk3TmE3akxHQXpvM1E4d2N0YUd0cldRWFBJSktWU2s4S2ZL?=
 =?utf-8?B?TWN1TkJ6dHMrNnh6aUpSUk5GUTdCc2J4Qy8wYVBOQ0wya2diTmVGSkF1ZCsw?=
 =?utf-8?B?Y3Y5eEhsa2hQWWZkQ0hvK2cydXdzNzJNaGNUWFRXZFRPL3R1VmZSS3d2ejd6?=
 =?utf-8?B?MGt3aTUyTkRjTTJNN2M1a09xT1p1Vkg3MFdRSTBwNy9GRVJXRFFqWGJiWnNq?=
 =?utf-8?B?NENhWlVwNllaQzg2RVJSOCtzRDU2OHEvT2lXclR3VmFOUkplQmhvWExYbm5W?=
 =?utf-8?B?ZkNsSDRyOXA4SEpPRWg4MTEyOWtJWXRhbWtrZGZmaGxqUWVKMXhnZWVwOFVa?=
 =?utf-8?B?WGViZFJac05FYlpGNFRFSkVNTUppcFJ6RXhYQjc1SVFROG50Vit2RzYzOU5V?=
 =?utf-8?B?SG9ZLzVQQXRxekN4TnpRWlI5WFhJRGRRVE9DOWRDSkFPdm43UEpkSGRncGVw?=
 =?utf-8?B?WjhXV3UrZkNLNHltbnVpekVGNEpwNUJUeU1EeGFKK29JTmk1TngzTUp0R0N2?=
 =?utf-8?B?Q3FjS1RDcTM3dXRjYmM1ZGpqVEd1VjVBakVhZTg2bitMK2IrNDNnRElmU3Ry?=
 =?utf-8?B?eVppYWNyUmo2ZjJyV0IycjhwRjQxcWFWYmR2eXhJT0NGZGJWOXJmWWVLd1Zm?=
 =?utf-8?B?c3ZNVjcvTWtoUlNwb0RGWWFLWUhQV0o3V1lIblEzMWd0cHRNMlN0enN2cnRp?=
 =?utf-8?B?Rkt6SXBkU2pkaXZ1alZiV2N2SFU0YmZwNjNxckVIM1RqcGRuSkY3dnBLRHhR?=
 =?utf-8?B?ZnlTWlZjdHA1VjhGQ3hhY1ZRSU4rVTgxZ1lkV0xHbnk0clNNM2hmeVJ4cGZh?=
 =?utf-8?B?ZklqQ1VPVGZNQ2ZEaU4ydUJpWi9VcnlWNmxQRGdYUWpKL1BwSGw3Vng5U3Yz?=
 =?utf-8?B?d3hOSHM4V3JmTFdvNWVlNnZvTDljeERoVlhGVElVb0pSVkFvSDk4NEx4dFcv?=
 =?utf-8?B?OGZJZXZEZzJhL1JvUitmbTZtS21hMFdCeWduUFkvVzRLNWtHYkx6RzE5d2gv?=
 =?utf-8?B?QU8xNUZQaXp0b0ZlVCt0aHRhTFQ1b1puYlJCN1kwemltTkJ3dEhaWDVibFRp?=
 =?utf-8?B?TGlWaSt0ZFNtYkVlOHdlSTZ5elRtaW5rM2I5RndZVnB1Z0dPT09GWWdLckFx?=
 =?utf-8?B?VHRGS2Vjc1B2dnRuZGtvU25UVnJvV1Z5a2xWTHhhV0Y1NGViaG1TZm5YQWNO?=
 =?utf-8?B?eTZjUjRwb3lCUXRlWk1uN1cxRmtaRXViVlRIUGhkQ25UVVRXWmNHYitWc1d3?=
 =?utf-8?B?Ny9ickRVYTl2WnU0UCtIRHdnQlgzKzdPSVJTMk5vQkNEMzY3cHAzT0M1OFFB?=
 =?utf-8?B?ZjgvQUR5TWdwZVY3RWIwd3RzOEU3T0kyVXppTkVrRWJZK3VBWVNXZVJYQ2Iw?=
 =?utf-8?B?a1gzZGNoSHA5NkhnKzdEWklpOENmd2FBTGgyZlFRVjdNbzk1emRPanV6OEg0?=
 =?utf-8?B?VStHZ3o1K3JieFdJd1QxdDFqZ1dhZWpTb0EyUkNsVXdhTy9YeDVDa0M2QVY1?=
 =?utf-8?B?cDRDdDE1dkNwSG9reWFrYXVqSkJXZDFVSGcxK0g0QjJnZ1VzOUc0Vkk2SEhj?=
 =?utf-8?B?V1ptdXdjd1dqZzdzNlhlZk1Bb25iOTNMUzEwbkNyRzFGS0R1dVZBSDBBRHBh?=
 =?utf-8?B?YjEyVFhuQ3ZlU3ZnbVhHQ1dGNWhodm5xNEFEKzkvYzZ5dWdDOWJhdWJGTEpS?=
 =?utf-8?B?MW04b2JSYytzUWI4eVU1dkd6ZU53bnNkNXNtSlJyMm9RTjJneDNrd2JPYkQ2?=
 =?utf-8?B?bVo2aktIay9FTVlIUGdENlNqQzUrWW9XejMyL2dFNzlTdlRzWjZRaDBWRk82?=
 =?utf-8?B?SWZ4YmhXS1ZsYmtFM2VvTC9KQmhrMkpGemJSeWVRdTJKS09UVTBQT3liL2k2?=
 =?utf-8?B?VHhRQ1lVdWpVZE16QVZGbXhSL1AwUmhRdThkTHJHRDlEajlENFlhTG1XOG1s?=
 =?utf-8?B?KzA5a2R0UGt3alBrMXdUMlRqZUFaVkNYeW1nV0RUMWJldEdhY3dWV3hmN0lR?=
 =?utf-8?B?SHJhWVBPODYrcGQrTDNZZUN6YjZUREg3TDRCRlJxT291MkY1OVBQMkc5c1dp?=
 =?utf-8?Q?NgxJ1zW1FLd6cBFFIr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f866791a-ed1a-4241-4fc4-08df395cddc9
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:45:13.3617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/qIB+MSZbSHgdejHC2XoD4f+s9wh84U1UCOuPkYeNXknMRB9Qx1DjlcGjcq0SNn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890

On Mon Nov 2, 2026 at 5:54 PM EST, Tal Zussman wrote:
> There are no callers left. Remove it.
>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Acked-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

