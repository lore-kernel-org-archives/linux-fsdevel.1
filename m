Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793339018;
	b=ktfMQeSRCR9LFP9Wb7nTNi5OCTVWzME61FnQ5Ko+lS5pniHyXQbxxWBG9dq0d2ZXR8ry
	 UWSA16j9NvQ9QiAtCbZ9Zouzn/i22hKB8mhOvp6idPXxCCgsWmN1N8c6xrHZRV8PDP9LT
	 jTe737qX5gxKzR4pi370Mxnx42R9f697ZAZ4h0Y5CDVL2X7N+Feav63BlAaB+51zFX9iA
	 EaI/EiA1YvpIfLVqcfWoI/WwikBIf7harQG639gX/MgNMtxwsHdpsAb7hJseAlHgIM+Wi
	 x2u2qoJPnEq4unZX3M7XPVEqta6oHb8DOiNUVVKHnnOUUbvxIu4p6D+kHwA9sG5O0UQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793339018;
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
	bh=ezLL814UQXwHn4zAusWCY/QfZeSin5TrwtAJl0exof4=;
	b=18OgwttVoyeBRGwoGU+A8OAUGRY7fFzYIlzPhfzinVQ4oUDnFxNhngGsTQIAhnlKdsNt
	 dwHWiJLR/D2jDtASvfya9IGU/wDJC2rSsNgrygOJNv+cUYalaV1kGnzoL80cggFFE//7u
	 vJNSbqmEqYCMEcZmhzYSX9/XkEUVk2r1Zk85gB+QnQQMurgebamkkTvdXBHi4RW0QWp/1
	 iq+DPGbZPClfOu9zq3+CQApc06Ce3wYJR14mNeTvfjX4oFhWUaogt557AzYIqLGBZYQek
	 ILJZxj+n08wtgjCfOtbaxIyj0VtOGtcGnipTuv6gFzBUedlXBldiwkN/S7plSlSKjQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=manhattantech.edu;
	spf=pass smtp.mailfrom=matc.net;
	dkim=pass header.d=manhattantech.edu header.i=@manhattantech.edu header.a=rsa-sha256 header.s=selector1 header.b=EHa7YV3J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.83
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021083.outbound.protection.outlook.com [40.107.208.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F9606A331;
	Fri, 30 Oct 2026 05:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A64F9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manhattantech.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matc.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=manhattantech.edu header.i=@manhattantech.edu header.a=rsa-sha256 header.s=selector1 header.b=EHa7YV3J
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMPvFwrMbolmoaJL/J0+A2YS8xRiy/fs7Hk3fRYQsw73/oV8qFFe17R0EQMuYbLpJjCl4RomG0Wkm+h9ebulOVJjBFmy+UZ1dNm5CUFxS5vGvdSfo2HC8vjoSvgpcWxUtT73ZVN/CdbfBxTP5HhlHvgOIN5UaLtfMa/FooDsi2JNl0sigGUBmvTljSBs/cPzLdQxvihxJXrvSd3fPnxlPnTQ8b9R0kviVaLtJUcs14j9cdyfz9G/NnaJfZoWZXQEt+VCSXoDYQ1osO7HFoeIMRum6UpaaQktIBdwc2k84pDC0LM4aksp+tsU05rYF/EoeoICe+/3nkcaKmTrgoojoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezLL814UQXwHn4zAusWCY/QfZeSin5TrwtAJl0exof4=;
 b=HDKJoWL/Y6g51WCQSgEY+/RHzFtTimXWDqwe/EQ44WRMcE5Gv2QQ/oQICj4zEDZ0+FHnqlqt1hmOlVS5qpASMOuPHW2pzoH3ZbNh0OdVFn3Veuul5P3M8K+bB1SupSNjlBJPuQDSTCiLfJQnmDsZpIGjSZW5MsW2IHaYsvLp1xWhUKgpCFzVEfRpeVBcYuhGPTE4iCeQLRW91ZQlvAR+IcLouwTDHUyXnvtZSCcVbu4tLxuVGMP708bv9ATiwaZMLVBF+A1A4uT6xB8BkL9x/FIclvUmnUwY3Oh5g6tkcFYkpHJSJ/fvl2X96b1lDP2Oce0Vl6dax2MGgCYoxC+B2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=matc.net; dmarc=pass action=none header.from=manhattantech.edu;
 dkim=pass header.d=manhattantech.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manhattantech.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezLL814UQXwHn4zAusWCY/QfZeSin5TrwtAJl0exof4=;
 b=EHa7YV3Je+OCDrB+R4BZ2hWqjWRAgJNKg0eoV8HMa1hog4pequLQlwvEN/TeUZaMy8MSN+Jwxec1zA18gykGUcQzGrJjSKy+UwYs1U1fHiGX+3DF68fQV2+XrCH1hTaT+Z2z76sFG04/OfX/Lti4i2qqZrnIfeHGilccQg60BGyzk1Hjc2qIzSVLWSVF/FOzeVP8gJtJPTJEkV6a/CGGjixJTGo/dfCGBcrVPEzaPCG7ZDcrjK7KGb/DClU/wblUGJReP6sQZIQ7Y/2aCTeul75UcmhF1r0k2Sn8U5lx/Jge3WVHIrOl+c6a3XvCcwJUSCvK+FW2flQcHp2fu6yxNQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=manhattantech.edu;
Received: from CO1PR08MB7126.namprd08.prod.outlook.com (2603:10b6:303:f2::17)
 by SAEPR08MB063959.namprd08.prod.outlook.com (2603:10b6:802:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 05:43:32 +0000
Received: from CO1PR08MB7126.namprd08.prod.outlook.com
 ([fe80::16ad:fc7c:329b:19eb]) by CO1PR08MB7126.namprd08.prod.outlook.com
 ([fe80::16ad:fc7c:329b:19eb%4]) with mapi id 15.21.0546.017; Fri, 30 Oct 2026
 05:43:32 +0000
Message-ID: <9fdf5771-4a7c-4d9f-93a8-caa77611a0f2@manhattantech.edu>
Date: Fri, 30 Oct 2026 00:43:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fat: use write_inode_now() on flush to avoid racing
 the flusher
To: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261029-fat-flush-isync-v1-1-69c02c258d0c@manhattantech.edu>
 <auOlUam8nXqdTZu0@DESKTOP-PJTTJ93.localdomain>
Content-Language: en-US
From: Bryanna Marihugh <bryannamarihugh@manhattantech.edu>
In-Reply-To: <auOlUam8nXqdTZu0@DESKTOP-PJTTJ93.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::7) To CO1PR08MB7126.namprd08.prod.outlook.com
 (2603:10b6:303:f2::17)
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
X-MS-TrafficTypeDiagnostic: CO1PR08MB7126:EE_|SAEPR08MB063959:EE_
X-MS-Office365-Filtering-Correlation-Id: e6cd2948-6857-4a7f-1a72-08df3648bb37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|786006|1800799024|366016|376014|23010399003|4143699003|56012099006|261009223027099003|261026140227099003|261022075727099003|261021121427099003|261028144727099003|261022105027099003|11063799006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	cisd6m9Myv9smGflywB3FWGDRLIOme2T3ERMWHr1mPINRQpDd8quCQzSlz+YDMBSi5CspkO88MItvI7SQQbc/0ZaMfkEvYyYvKAexfHA3BEUR8Xb82Np8ztLgP2C0SC0BCK38GQR1Dk+pD855Zh2D3ran+jXmJyjJQ1YGYXvs2dq3cZAerut5HHHAeeyXgjh1cT0n+VQJYatFMdXum2316YI0jxJEo5e/99ncNjPCUeM024qZr9nFaS/UstSBonBee8FWiS1OMnWpZJawQJSgjDLnXlzHuiTbeFEFoggj6fo8rl/18NBVWUkF6c19ZubkV2y918aSRBTcazKH5zwVWmXXQGX7hc38+nh12F4vRiWD+eJdA14q4pUv8ijKORR9WNWFJxJIXZ3Qo5Kd3SAdQ4sa11ug9RMhSfhyUl9Jzek8bWePtLuzQzcWzGc+0SD55PpyOvA8nlm6D9QtDe056g5ZCZ9HH1g+lIqPubkSaYMKIVGoq5Vb0+tbk3mUGNO7ERg7pFPggt30sKpaaPmSzFrGw5EIy3BVqd3njmiokkKBxWckoZGEhWgHSIrDkQYgpgfwOW4YMtkQAMuFQ+UgLkJ6SFy7DorZ/xrBuoz4Dp7soDhN7zOJ3WiSebpjz7P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR08MB7126.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(786006)(1800799024)(366016)(376014)(23010399003)(4143699003)(56012099006)(261009223027099003)(261026140227099003)(261022075727099003)(261021121427099003)(261028144727099003)(261022105027099003)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0JXcWpYQ3hLZW9CYmJsdjBoVnkwbGNNRHMyQXE3bTJhSTJudUJOM1BUK2NT?=
 =?utf-8?B?aEFzTkdMeHJWekVZTVlPRXZ0WmFkbDVOaFZucnJFSXJCTFJhYTlZNVRVdVFr?=
 =?utf-8?B?b1BZVjFoVW9JM1Z4TktCdUhveGhsamp0MkxCZE5YNUhHTjgvZlpEcEFtS294?=
 =?utf-8?B?aUJiL2wyNU5iQ0p3dExpUUpNcnB3NW9PK1VZWml3elI4MXdtVUdPVGpOOG5D?=
 =?utf-8?B?ZUY4cnhMd29xenp0MzcyTDNNQmlrcXdHbjVWOFhPNFo0UUIxUFVCVFlneUI4?=
 =?utf-8?B?dTcvdlNmc1dxdjZwZ050K3hYNDk1RUpna2xjSENDak1aWitPbUVqdlptVUh6?=
 =?utf-8?B?dkQ1Q3YwTE9vYnB6TjdxemJOSWNhNmtoa1J0V0dqbHdReFQ3T1FZOUw1aUEy?=
 =?utf-8?B?TUo1ZGdUSFhjajFZcjNQeFpFNWtNSmVnbzBtL0JtSmQ0Y21XSFFRcTN3Ukcy?=
 =?utf-8?B?TC9xWk53MGs2eC9DLzFoUXpiRDgxVFcyc0VZR25VRWRGVGpPK2dvS2QrU2hF?=
 =?utf-8?B?Zm5EME8zaXNTdXZ2L3JKWDZybTd2Y3R0NUhmZERVQUlnbDh3aC96bGFnVm9n?=
 =?utf-8?B?MWV6UCtxNnRKNDF6Njc0ZlVpdjRsQ2YxWEVuU0FxQTR1ajFqUllYZTdCeHI0?=
 =?utf-8?B?MFVaenVYbi9SOE9GMi9yRlZYejB1RFowNWJpZnpWTDEzRFRXL3VudG1Lcmt6?=
 =?utf-8?B?MUFKZ2VTUDZsbmpYTTBGOGhrNW1KSmZFR2VOdktmVHBBZnBoSHBWbnVBVmFU?=
 =?utf-8?B?RkRyYmpwaDVkSk5ZQVlieTd5SzhpaUNReHdOT3lBZkd6OVJ5U3NVd21yU0w2?=
 =?utf-8?B?ako0YVVsTUp3TEVSMkpxbUFYamZ5K1FGcE8ycFdrSmx1UTNpUkc4dmJYSE9m?=
 =?utf-8?B?eFhlSnEwb0phVkdsSERqemVKYURHdTJaOXlsaUt6Rk5LT1JUWmZXaDZlV1Fz?=
 =?utf-8?B?T1BoRitjODJ4c0NMU1pjTHE0ZzBaUDZBY2hiV3RBRHhGZTR3MEtJQkRTVUFv?=
 =?utf-8?B?eGV5RkhCV0lPTzMvR2pvSFVFUENIellHTEUvZGRMMzJ1Z1FLZTEwNkFaQkov?=
 =?utf-8?B?Ui9lTkU1STFIZElueVc1UmY2TXljcG9WTTg0V1piTXZmRk1EMVYwMEtzWllT?=
 =?utf-8?B?ZEVTb0tWcStPMXdQV3M2OHhsd1p0aSswbVdiLzFMMldqb1dxK3puam9tTmM1?=
 =?utf-8?B?SHRLeHh4ODRNWjAyaFBFMnR0VHRhMEdIQmhQSXY0cG9KeW1yMTlaeHlGYmM5?=
 =?utf-8?B?WHlpS2FtNVhuYngrOWYwVHNZT25lQk12NnVuMVExTUpjaVVIVkZIc1I3Yk9C?=
 =?utf-8?B?Rk9BVVBGb3FxWVpXQzJyNnE2OEVZRjcrdnUxK3lMTUNzaXlQUVY2U1pTQjgz?=
 =?utf-8?B?aXYxOEhzYUdNd0M3b3pLd1pRaVlsTHpZQlNWc29sUTgwOUQzVmpBMjZ1WmdK?=
 =?utf-8?B?Wm5CZWZ0NUQ2YUJOQ2lRYnBTa2pXOTJKc3BrNlA4dVlMNHNOVHZlMUFTNHlR?=
 =?utf-8?B?Q3F0TXlheUJqVGhhdW1QdWhMT05jUDZiK1RTWXJTSkhaU0NPT0tnUVVsSUo2?=
 =?utf-8?B?WXJmdGh5N3QwSzJxemZFdy9LV1AxeVZhUzJlOW41VmJORjljYWxwb0huR2tr?=
 =?utf-8?B?bndidHdxQU4wTXd0NlFTb3dpSXQvZ2ZJSENTRmVOL3EwK2VBL0IvQXlWNHoy?=
 =?utf-8?B?eFdodnM4QU5BUTd3S3lGZjhTSXVnT0hQeERWcCtERGdneldmVXZWaUJodHVM?=
 =?utf-8?B?emxtam0zbUtFY3o1c1ljTlZ5ZG0vS3VhR1VBdHRsV3dGbmVMOVltVXBXZjRh?=
 =?utf-8?B?emFFSFd6dnkrUzRtY0RMcm91clRlZ1NscU5rckZsZDMyODhqZGlrTS9YRXV2?=
 =?utf-8?B?TEFHMHRKNDVsL0tSU1ZLM0lqM1IybFJwVjd2MThseDV3REhYWW1KaVJqRk12?=
 =?utf-8?B?aEZLb1F0eUl2aTl0YjJhT0VVZ1lGVHFxbS8xcE5RTWhqdWc3UTd1bXZ0cHBn?=
 =?utf-8?B?U25pUjVBYnBkK1FOUGJyNGNocUFMcXhxdHc3OXpVSkNiQWd1NVZDK05JbUpW?=
 =?utf-8?B?Wmd4Zjl3ODJwWnhZZHd4bDZyOGNmUzFLQmRnYm9SNVdUeVgzOVRKc3VobHdU?=
 =?utf-8?B?MmYrRkZPYWxQRlZmT0lZaUFrVi90U2hlRkhidzJsNFBLWXEzRDJBNHNjaEsy?=
 =?utf-8?B?NmY3bklLeElLQ0R6ekJ3ZEIwMitKd1NlK2dRODRuK3dnYWh1Y1RFSFlHcFZ5?=
 =?utf-8?B?cHRVRUhaU1Y1eUxzbDYvTXJBVXp5Q2V2ZmhaQXB5MFRNWnJoN1JKYUJoUGdG?=
 =?utf-8?B?VFI1eWhoZkNtQ3JDdWphTW5LY0N1ZzlITE1tK05mYWhEQXhibWVYZz09?=
X-OriginatorOrg: manhattantech.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cd2948-6857-4a7f-1a72-08df3648bb37
X-MS-Exchange-CrossTenant-AuthSource: CO1PR08MB7126.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 05:43:32.3866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 21e8bc52-a9f4-4adc-8133-b5f395a5ced1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYjjXAWLUT5UKT6Eq3ebTSv/FocchEm2683bfUm0IICCDk0ZiSCn8wAa3acFQeMh+NHgdR3SJyjRWsXg2ReIRoRyMiVijn21YWROVT+41O0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAEPR08MB063959

On 10/29/26 3:11 PM, Matheus Alves de Almeida wrote:
> I Agree with OGAWA.
>
> Also, since writeback_inode() will just be a call to
> write_inode_now(), couldn't this helper be removed and instead
> write_inode_now() be called directly?

I answered OGAWA with numbers from more drives and offered to drop
the wait in v2:
https://lore.kernel.org/lkml/457c34c8-b52f-41c6-8b58-ed334b0dc483@manhattantech.edu/

I have not contributed before, so I was being cautious and went for a
1 line edit, as I was not sure of the protocol on removing functions.
I will remove writeback_inode() and call write_inode_now() directly in
fat_flush_inodes() in v2, once there is a decision on the wait.

Thanks,
Bryanna
