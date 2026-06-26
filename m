Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF692F6560
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782482925; cv=fail; b=dWcJSglm+dd49HlWR+MtpJ4w7ui+HMoowwnAXkx4PDmZxhAWeLW+eYrQ786DUO4PfyfTGOi5RT+xZW0b+pcmkpL0em/tvZfptkQoM9T+T49QprPePhACsGsLd+kxdYchcChJxc2b9McLtlzJdsLak8r5xxnkwmzRNKCQ3X0Q60A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782482925; c=relaxed/simple;
	bh=COyNFvxh+Gs1KoZPChPhX9eP2aIssOFfVP+78V31zb0=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=EaDNCA3tKUCfOc1X6r2GnHQrcRzSH4vAiUlR0mSBjDQWmZDalyPnIFigDNRF2CfHIfccpxpETndyO/Ur4o9NKHQGZz6vGvCnD4zG7wkO3pPi2by00ca8qqeO7VzztxBew3kFXzFKTZY8ULFOsCK8LJchoM9tj3gK9MPAyO6XSw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cjocfrLG; arc=fail smtp.client-ip=52.101.48.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cjocfrLG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NkTK5H9rR02XSitStMnoI0JMMNgO15Lg/W/bavQukAoYOMzy0zRAgugk0TAmjtkrqI2iEGS3u5PZsRZbykziETYPnOHFUkxbdASbz/ekBXjTHnRVjFA+ZEVpja+LwF6m8gMhN/qgJ8h1rfaT+cTF3uQG5lfUICQZn/10YT9/z8jkowRXfxppXa1lEmTNc566fbx54v47XAAPk2LAsUvneTSTNJry8dSbSqIfLjQwzjaGdazJrcr+4FEXGVXNKFGNgl8Wnqhz7/MV6CeWHQ9L81wlQdS8vnYfNoQrDpMdOdeaoH2jOF9nlow2VsajRWjdZI2nU4L525CDZFYDZbMgvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UENPahxVswqzuZ7m0i50Mb5wwqzkMw+6H2onMLyuCuE=;
 b=gZKWOUx2g8+ZrIv+VtG4B/aazzE9f7pDPAM2Y/c2sDGfjC3VU2LVf2CzXJg1z1aY3YggYSQaIlZhmIKVQMoO0IGW3GjqFSOs2WddknTdDUo/Y+Cfb4Jp7Rrun2tQTSNgOfFkRIQ10ksu+hawv2E6dl0XJ1+G1drAg65QIbCJY2W5OFhLS6QsNSZjVRK7srN3bOm/9sZaTVPvhrtYB+Hy3wL8pGnZnkFgaeGKchXJryKJ+fmx6Mze0mhzGzbxy2rdyKUqw6JTZF0NfVsGSwXxzDGTHsJTrhJcGM8wTsNfSAGNohzO1sDVapXP5YPWPIc1oxHRjH0e+N1f8NOzBjsWTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UENPahxVswqzuZ7m0i50Mb5wwqzkMw+6H2onMLyuCuE=;
 b=cjocfrLGKYfDPUnkarasU0jDAYyOiXYXrbgYG9K4er+I5euPje/vESHiUKxUM3HWOahnTPnS5vy1EQ+LhZl4RaFDh0zMbXwy0yx+wBc7Io4jf6vi5xh+L8zNGBfUFGSpxF4ezDUyGx2I+W1gpBU9jymK8UqoWN6fOJL8eghHshXNOPafLlnLZtELhIwunGxw2lbaFN3SE7vz4m2t0b8NYsCp9N9HSH9nmvF5m6ItP8SaU2jcDAv1BbKtGGt0rU1jmRR4HKTBl55JPjQZk2l/JcgpVnYkA5KMdX3g9UTw9a9B6UjDjQA8GsXw9NlzTEhmOavjPOBwdpj2A/L6xKqfvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 14:08:36 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 14:08:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 26 Jun 2026 10:08:34 -0400
Message-Id: <DJJ1GI9R9KYX.VRUNK0PHFG85@nvidia.com>
Subject: Re: [PATCH v2] fs/proc: fix KPF_KSM reported for all anonymous
 pages
Cc: <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
To: "Jinjiang Tu" <tujinjiang@huawei.com>, <akpm@linux-foundation.org>,
 <david@kernel.org>, <luizcap@redhat.com>, <willy@infradead.org>,
 <linmiaohe@huawei.com>, <svetly.todorov@memverge.com>,
 <xu.xin16@zte.com.cn>, <chengming.zhou@linux.dev>,
 <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260626013252.2846774-1-tujinjiang@huawei.com>
In-Reply-To: <20260626013252.2846774-1-tujinjiang@huawei.com>
X-ClientProxiedBy: BN9PR03CA0214.namprd03.prod.outlook.com
 (2603:10b6:408:f8::9) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|MN0PR12MB5953:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cca92ce-c581-4920-f2f3-08ded38c6a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|921020|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	UmBgSJLp9L5AtPgIsAOuopFJ4twzZiCQ6/EgnJz1MYI/ZX3pKXQ485hNToc3BFu84iuTOf6uchSu/Mw3J7BRBq1YAhS8CEDOcxNnxnL4jYX3FJM2yn4Mey6tVhf7ew7U6WMFq3uMkXgBFcrQnr89BLuJOXurG7STcIw7mzY2RSIJ9i/fGrThWGkS7PEeZ3XTFu1KzOGO89kJH0IxmC+kkq3NQ75V4LaTiNg+9bnQC8viC3LcncvG15CpOtsI2T9eIesKKMlVnCJjQLCjuSfMvs9Eovau7i4A9Z/1yAFGAK5X5Kk2AlzPUkcQlC+e9Cqy2eKH24UlH5O46iZOXKU6A7BOPlDYDv1YcqRbaL5kriWREZ/QUa5PEdCegO8PHMOIyapy1NTh9Qco7qftc8rR75UvUSBCuCWnOJEK/wnFJ+m1TG7f4jHS+jJ2Zg2blMa6Q+7dZEFW2WYvcW5qDEcmObTM5ZnkFjBGsfCpDrmRK/pFARupJPoovSaba30BcksWSyfESQ+gLIipPg/0KO9qDRNb0YO6hYSqsSYsXlwzNbntpQ0sPG9AoIQxcsnpDKmTuMD/T9sl1y1a/w3v9svgBrzjGTeUTviE2mCFDwPXSGE8gFwiC2JVHSkUooD+mD2dTUDjcGsKEILSJ1GsZGvmAJOgsGeEBzjyiquwUYcGMH4YtJ2QNcqq9pxw+WFOIotqdPw6rqWE123UPy8UgR2xrw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(921020)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emRLeW5YZTdUTFNueEM5Tm1LRTUvZEFmaEE4TWdaNGF6TDJYdEk2UGR3NTds?=
 =?utf-8?B?YUdaaWhob1pocUgzQlUzeTlVYjJvSmJkOS9VVmhQbW9FY0owdzRnOEhWWEdW?=
 =?utf-8?B?dmRWUDl2eVJVQmkzQU82ektuT0VDeks4bDVpcW85cng1c2wyUWVHbmZXTEln?=
 =?utf-8?B?Y3JlR08vZ0lpTXNXNTVWQS91RVpVR0RUakxUSnljb1NiT3JoZm1Xd0tTb3JX?=
 =?utf-8?B?RU9adFIvenYvL0VxOS84TjF0RU5iR2NINnpGZVlYdHdGUlM2WEwxZkowbmhv?=
 =?utf-8?B?NStZakNORU40d2x2NDlKdlQ0OGhUQTFvQ1Iya1hrdFFtcFJ5R2ZiTEdzSjZ0?=
 =?utf-8?B?b3hqRUorNE1LcFd4cTNib281ZDlUM3pSVkdHd1hkbXg4dW1LOGJ2OVhHYUFz?=
 =?utf-8?B?amJ0RThkOUJHZ1FqMFpvOWtPbFpERHdsdXpqSFhJRXRJTkdlWEdyTnBIZTQ4?=
 =?utf-8?B?NGJzMDVydjBmTE1OajAxL0J4cCt5Q2p6a0xUamFndUxtODlZV3NSQ1RvcnUy?=
 =?utf-8?B?RnhYMndlcnZJcXdMYm9NY01rTVBEVGVIcWsyQUJ1ZVRPdVpYdXhUU0pQa0tE?=
 =?utf-8?B?ZTJZT0w3S1loSWs1VFpLOElhR2FlQndUc0NNNHRUVjFGeFlKajk4S0lxU3VN?=
 =?utf-8?B?S0lUT0w2eCtOOTM1bjNnSTR2cmQrNHprS0gyajc2bzRQcjdkQjJkWWlZL2tQ?=
 =?utf-8?B?WE9MUy9FdDMvOGxldWxMbGJnbDQwVUx1ejJQRmhoNFlrY3p4QW92WkZCdEtl?=
 =?utf-8?B?WkUyVFIvbHJKQmY5dTlvNmk1RnFyZjRROFF4VkNlNU5ZWUZSd0ozL05DTWxm?=
 =?utf-8?B?MkZJTnhDOGw4S2huZmN1dzlmcGRsRXM4c1E4bVcrK25XRkE0aTQ1cENwKzNh?=
 =?utf-8?B?Y2tlbURmR3o2NnBHY3BtOUhYUVZyMlgrSFIyTTFCSHlvRGhaaldSREhYc1d2?=
 =?utf-8?B?cnZhcnY3VEF3TkZpUXhQaUx3VWdjdnlneFk0K2oyNnMxYjEydGZDaGNhQUgv?=
 =?utf-8?B?WjRLbnlUZEZtTHpKbFlYaklSYjMrdnRscklSLy9KTjJtMjZyQ2xyUmhDUnhn?=
 =?utf-8?B?UVhOT0dxcmI0aVkrNUFnZDZwWmRVRDl1UnM5akZhZnZkTUJ0cjF4Ni9QWG8x?=
 =?utf-8?B?VCtqdlNyZWd2ZjlwN0JleWFRWGhnaDlJWi8vTlNVV0ZEWVpFczE1K3BENEJF?=
 =?utf-8?B?Skg5ZVhUOUE0QjZLQnd5SkhVMUR0NGNZMEtPVW51WHBFb1J0b1lObXVGaW1E?=
 =?utf-8?B?T0JBSEhPMG15V1djV0Vja2gvMHY5bzBZbkZ0TTVNSjAvTnc3SU14MjJLclE4?=
 =?utf-8?B?L2RSVXZYQTFpdFZKNGtKbGkxWFd4RXpaNGxSbWZqcjFER0FzdEg5aldhT0p1?=
 =?utf-8?B?K3p0OUlOQWhmWlZDUFJsQ1NNb21VR1dnSUFtV2FTb24xT1ZkYWxSY2txVHBE?=
 =?utf-8?B?aUl2SnNHdSt2RUdnNXNGTUpubzZ1TDVIaDg0dEFlQ01lV25ycUpsMUp5cEdm?=
 =?utf-8?B?bW5WUXY2allIZmRWWUEwOTBFUG1WS05Ca0c4OE40d0xCR051SkJ6NjBieURW?=
 =?utf-8?B?bEhzUHp1bHc1T0l2VzViYXRneWtETVREYVVHcGlvV1JxZDJINXFmSkNRbTk3?=
 =?utf-8?B?R2lidU9UcGZVbU5ZK0hZOTcxOVRiUkdMN29tdk5MUmc5R1dnam5xZ0lVK3lw?=
 =?utf-8?B?UGdLVHFmbVFzY1duSVJkOXRTdXFFSFI1clRvOVZNaGxrbFRLTkEyOWVyWnFq?=
 =?utf-8?B?Q1l3cFdJMWFQWWI4cFZjTmZFUGRsbHdrcW9BYmhwbkwydEIvT0oveTZvVGh2?=
 =?utf-8?B?b2NWL3dWZExpdU44SnFQQWxPL0xnRGJBUmtpOFNqb1VtYWkrWjNVRUJCUEFz?=
 =?utf-8?B?VE5XanNzcDdYSVQ4ZlErZXd2UUxtSjVUejZERmdMNFRVaU9kZ3lCWjlGL2lU?=
 =?utf-8?B?bHpTY1ozaCtuckl3NE5TQytabTgyTE9mOWZzK2dsdXkwZVlnRGNtSk1HcnVy?=
 =?utf-8?B?anJUbytXdHZ1UitDZDZzZy9JU1ZMTUpDdUVLYnVNTWhhM0J1NGdkUklBNGY4?=
 =?utf-8?B?ZTZ3NVRiZ3ZBWEZ6MzlhOTM2RmE2b1VKRW1ON0Qzb0pGa1Q2QjQxTkwzUDJZ?=
 =?utf-8?B?emxNcVJmdDFCSGErN0JQYVBRNzNwTzVOQjQ4UmJuOHdNQjJ6S1U3dUlYbGQz?=
 =?utf-8?B?TEdaVXdZUEsyZlh3cjNobFgxUmMwWCtZbERTd3ZrSlFjb2RrQ1VsQTVxU0xl?=
 =?utf-8?B?RUdhcmt2MkczQm1LME5WM2Vnb2NWNENkbXhQQkQyQXY1N2prOTgzQmdhZXJW?=
 =?utf-8?Q?Wz7beMnO4uYBBoy9iR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cca92ce-c581-4920-f2f3-08ded38c6a22
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 14:08:36.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HBndanGQh2GZjnJaKufDN1apj9sTFKYpbKtJERYk1gdL4sB2V7Yr+gGQVZhyMB2t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5953

On Thu Jun 25, 2026 at 9:32 PM EDT, Jinjiang Tu wrote:
> Reading /proc/kpageflags for any anonymous page returns KPF_KSM set, even
> when KSM is not in use. As a result, tools misclassify all anonymous page=
s
> as KSM merged.
>
> In stable_page_flags(), if the page is anonymous, then use (mapping &
> FOLIO_MAPPING_KSM) check to identify if the anonymous page is KSM page.
> However, FOLIO_MAPPING_KSM is FOLIO_MAPPING_ANON | FOLIO_MAPPING_ANON_KSM=
,
> (mapping & FOLIO_MAPPING_KSM) check returns true for all nonymous pages.
>
> To fix it, use FOLIO_MAPPING_ANON_KSM instead.
>
> Fixes: dee3d0bef2b0 ("proc: rewrite stable_page_flags()")
> Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
> ---
> Changelog in v2:
>  * use FOLIO_MAPPING_KSM to match explictly instead of use FOLIO_MAPPING_=
ANON_KSM
> only.
>
>  fs/proc/page.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

LGTM. Thanks.

Acked-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

