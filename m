Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B844E3778
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002762; cv=fail; b=gjCQCi0pxDz7BkDcJsUQKIzjC1kWXrTpyc6tK3OhRd/P+2iTMwm8Xne/ekTK8hToyk1ZhsTx6NbQwrQESBsDE80wsZJHoS03Nv7CP0alhPewYYJCOtBEltX5ocQm5og7w4EH00dDOeq96Nle591LcTb0mmD9kDeUmGoN+mUYPqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002762; c=relaxed/simple;
	bh=iaSrW/yvZX4we7mTKcN1BQ9Wtnx06Zr9cvRlZtd6It4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oinDiCu2JtXYOZlRnBcPwetwRs4UVJnSLp/k3+FsLNXtmjLyQBBTBrRKx9xnfV5eYYVZkwAImzynLliRfFe734Cay8vkAs1OPGmwM/EWopSwJ7MQ00hpXwXKK4KbNSpKlFU3zOViz0Tplhve6WKcKeXIMypxQbBRziVmFXYCWLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JCRr40ZS; arc=fail smtp.client-ip=52.101.85.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JCRr40ZS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pokg9vn3nKFYIejrzu96vXdNHn4q+pDeLdtZoXv6wce8RlLlC/TYfULYngjEvCUcoq9EvkPpq20DX973C1rykfF4IwzombmJrkIf5b087HpjSw2WUPr+xfj6pG75YKWJzY6K8TIcs6sWY+72+80ijTDFsRf4qQYtcYkNSzaki5ZAqgME8w/kunmpl3CIi4OxE+8Z+UQYxjbAeUUOu8Q56598lqIwQ8U+1yL9SWB7B2+MXKwT4FYeKKpg7tBp5jC8AcAyuPCk1b79XEgcLeSXBFRlPvnNi2TJZiYsPasJGHRQ3ICA7iOGGT5yA6YEDnb5QFD5rBROZr7wLGtV5GIvNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQwEaIWLp8QZaE6YKjf5wRY50P0yRf1wZ1navooi/yM=;
 b=h9NKHzxu6NPjvzNlRlHYxy0Ru7AAUM1DQ1Z/6BJvVYY/U00ENVJuO3Qn1XSkCg9n2ocPR+r+r+l5oFHPCOrKH2v0ujA6oneNjkPS+N3P7DvIMz53yzdCP9w883y/lWNZs3D3Vioall4qMxmS/B4UWgHohExxnQpmm6+/Ir4jdMLalYAkUD0GTqG5qFMZPKU74EDwsbf0eGRWnN+q2F0x2tyqtWZe2+M1fYvztAOS9yLg4wtqljuzmsWVip/O6zVK+Lf9WpgSFSemvaOYFt7mSkvpy6mvpxz2YF133wv3fp1EiY9cvgm243bYgsM92sXP4eMD1exxkOQygDbx/boYbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQwEaIWLp8QZaE6YKjf5wRY50P0yRf1wZ1navooi/yM=;
 b=JCRr40ZS8QalQ+S4Ik+GCwOlazeeb09gQi6qh0LHistVeG2qa3caSJfq/GrX7O2r0wO6PLEusSMj1pWjVwAasWEHROfHhed76glk95d+g3VkeUUAx44+MGB9Lq9mZsagQcAkTuTF1p5/KtIkn4M9oYFwBkQet5+pS9NqM2tGMJQiJK73bACHDxiSTnxZESg78k61/CaTQnVfbBb1yDTUPDpXiqe3GFMQG/4nimtv4uDtT0fYY3vWMmUQ2FgWeWxcERQaeuxThkscDiQWeNSd7ZU6zQZ76o5KPqaOZZ4vs3WBhtjPLmL68bckpaQ6L/yvNhTfPqFnXYzR834/UYoRtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 2 Jul
 2026 14:32:27 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 14:32:27 +0000
From: Zi Yan <ziy@nvidia.com>
To: Jinjiang Tu <tujinjiang@huawei.com>
Cc: akpm@linux-foundation.org, david@kernel.org, luizcap@redhat.com,
 willy@infradead.org, linmiaohe@huawei.com, svetly.todorov@memverge.com,
 xu.xin16@zte.com.cn, chengming.zhou@linux.dev, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, wangkefeng.wang@huawei.com, sunnanyong@huawei.com
Subject: Re: [PATCH 1/2] stable_page_flags(): use BIT_ULL() for KPF flags
Date: Thu, 02 Jul 2026 10:32:26 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <90719075-A7FD-45E7-A1B1-1AA8C34DB435@nvidia.com>
In-Reply-To: <20260702110614.2176986-2-tujinjiang@huawei.com>
References: <20260702110614.2176986-1-tujinjiang@huawei.com>
 <20260702110614.2176986-2-tujinjiang@huawei.com>
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0135.namprd04.prod.outlook.com
 (2603:10b6:408:ed::20) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b7d9fd0-9e01-44c7-475e-08ded846bda2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J1foe6a5UJ8/xPIpiNiGZCXlEE1vJaPIDyCpk0PIIZBuSs3nUnQuHXb9aSkLmY+1CExJtF2CitGwiV5OF/adGvcUSDDPa2mqJ2mP0guKEo9vqehoOWxXOR8p1lCb8Q2ygm17qdDaP361JN8M20GXEzjqz8vIsWy4Mc9wK6pMfQSBfR+LAJeReSvM7lGOSw87XTPfRx4TwlSeJATQLA12YUKzDv/YAVH1OOOMY91r586EvFs3Lcld5fS3ggvCh8a+IZ1Mka6E4RI8qewcPUFB4ko3puaVrWxahHwJbPEz73g06pqFyT1kZm6wekKFPMy9LzfVVhgRNge2Vew8WaHmPQA4mDYiecn2X+G8Lb89BWuyQqJeY3yHu/pghi1CYPKgxtZ6B63RswNu0BHHA3nyTldwQh/xe51p3Etma0/RcPR+oNVkyQRHjA0iCbTDub+rzu5DQbkb0xe6IgeVyK/PKvEtEByc2zx4NQlgEGEMguobFE/zj7OYotAitlU9+Yuq+8OPQDlf+S4Owv2P/P4B5Fvfec/HV1rBnGVkg3GOOaA8c+65LtfLkx7crXx87bmNkp/W6/rKANET7ma57QZcAv5HaMVhVksURWYgrbzbE9aZVV/5gyTkxGSIZ+jzvRHlXEHW4PYqrc4G3bWTiznu0N1gPndP/+2c6P51DuPu1Qc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HwLVZn0+Yb2QBfU84Re4j83X0fC31gk63RHjoTv78KG6JTvPMg99AmtCFCdm?=
 =?us-ascii?Q?ABGOdgrg4C1jChqx0hEdyTl7jh8ntKHAnUncl3AdqJQ1GgI5f9+mKoNSaim/?=
 =?us-ascii?Q?pxKySXSr47q9J1AAirqV3NeOsoUBhJzFO+i9kjmsS8zj7MWA87pCGm3mLRDQ?=
 =?us-ascii?Q?+pmCcPikQhXAt7QsGmYYEuxZMAvrbP8GVtdI1p4WGDfwy5q6BEBgVTs8z0a1?=
 =?us-ascii?Q?PcntTka5m7VaPkBZ3iz4ylx4K06j3QD/NvBzQDnLtvxPbaKoKBLImRbek+WI?=
 =?us-ascii?Q?TYfc7YyJfpEk81ugBFaHissFZJwxQXACsV0Yai+Ttl/XCGnnlal+qV6eIgCk?=
 =?us-ascii?Q?qXPTvTjcIKAOCJx/F80CAfUnkBSbdAz8Qnkioutj9XpzpNjkG6JFRu9qHQNE?=
 =?us-ascii?Q?N9vSLE3lDHNjuxN51dL0r3LbalR3j4pqoxsNEOEjMcFBuf2VWOnat+LFzTW1?=
 =?us-ascii?Q?NIcv7a/88fxgleVqUtgiKtoi/REH5LLFjCqgGUfMXgWhwJCOG1Dml5PyqH53?=
 =?us-ascii?Q?a2FLDmjUEtnGH8AoRSeNUh9Dv1B+cBNw0FTgTuSsJJ/cN4BkrWAAhvMcU+09?=
 =?us-ascii?Q?vPc/pKtN1mcIyK/YS71Ikv6o7LT7gazKz9ReKgn/pfy3zv3HLEXXuhqJLmtl?=
 =?us-ascii?Q?B+8KbO1clXKkRv7Cw8WX1WQ8pshq/V1ECHsdS6vZTWt5ValhZbjdF9ayq/6E?=
 =?us-ascii?Q?L03yoUJw/axwtCzT/NvrF98aBnPvaQcZu1OwjzFVjTrnaNqBnRBNnHiOyT1M?=
 =?us-ascii?Q?aAy7PTsMu7s2ivL1R3mrZDblePhl6eUSdWYdeUKmq+6vDZLSvrOfVH7diKfp?=
 =?us-ascii?Q?1Wj5pz8PO4FLik3eGuXKf4utLw8faOI4FbRZ777r3V/XAP1N4jiTGb/qUQoZ?=
 =?us-ascii?Q?iVTgoTnrp0C3IaqgqltHuxWz9C4O/6T1TARvO/AwJCmwzLf2kWLRDDa5Q1G+?=
 =?us-ascii?Q?+JWAzybVx7RipADQXg3o894Crx5k4OFy08/Lmq0F71UcCQxOw9zZn0iUzJP8?=
 =?us-ascii?Q?R+I9av4vG11ry/M4SYvl4ZoFZs68CyxO6fSLV86JC2fvcv9VklKP7XOAkk+7?=
 =?us-ascii?Q?bqcaYofoZMj/XwQOKjNtkC+4GljIFKW4VnqBRR3iRVK2XkzxVxJ/5AlIR2If?=
 =?us-ascii?Q?zqhbkmZvV4u8EuC92jiAnEa5czzu22sIG57SquQnlQWZvW2r5mSB7rFyDmZT?=
 =?us-ascii?Q?8kwD8Gq2cwl9fybdyt1HJ28WQ0Xh3Myc9P3Rm393vy8PH+d0rSQ1tCCqE5Cl?=
 =?us-ascii?Q?DLWB92ubi4uOck1gd+tfQ1W5mL34z4cln0CHhqY3YsPBC9WfB2os6j7E3Fn2?=
 =?us-ascii?Q?pIuSfDyISWpocMXuJhUFkKQ0LIueSTQ9JBCyE8g1JCyPkf+jUAF9AJabRw2u?=
 =?us-ascii?Q?b9J9sY32sHabKtsEP4pcYeL0/HymcxSV6+/kmvuPyiGD+eNlaVuJagME885W?=
 =?us-ascii?Q?NeJrTKe3LbeLIfw3vM/dtlfZF6HD7DWBdYDp5SzV+gsZcqM14pZ+HjyMe2jc?=
 =?us-ascii?Q?+LQ1B7jexa9W0k5eaVTML/qkS/XkECcwq88ErhXI5FRzvB6A5eFOZWXPILlH?=
 =?us-ascii?Q?qnEt3R4p+VLE10xnWxtiNAaHOLqlTrUoplaJJXWlVSG27gVr7iUXumJSBG5H?=
 =?us-ascii?Q?Ok3v0b04G2F/rCJc6H4f5Wf3eLERuwn+KQLaHKjcVQamwMGc7MQxNoBiWEGv?=
 =?us-ascii?Q?SHNExdfE5PXo/cm6M88+ASY6pgS2m8aT6mnB+UlGBL+tvex2z1cCkp/ntBAc?=
 =?us-ascii?Q?GEYUwc++nw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7d9fd0-9e01-44c7-475e-08ded846bda2
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 14:32:27.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yY5o+U/OA+55QZeR4YCb/4mkvr2cgfPuIhhXWeOSw/eiwSMSxf5XL97aSwFDClLm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313

On 2 Jul 2026, at 7:06, Jinjiang Tu wrote:

> The stable_page_flags() function currently sets page flag bits using
> "1 << KPF_xxx" for various KPF_* definitions. KPF_* may be larger than 32,
> which will trigger -Wshift-count-overflow warning. All KPF_* values
> currently used in "1 << KPF_xxx" are smaller than 33, so no warning is
> triggered with current code. However, the later patch will cleanup
> stable_page_flags() and "1 << KPF_xxx" will be used for KPF_* values larger
> than 32, such as KPF_MLOCKED.
>
> Replace all occurrences of "1 << KPF_*" with the BIT_ULL() macro to
> ensure all shifts are performed on a 64-bit unsigned type. This makes
> the code robust, and safe for future extension.
>
> No functional change is intended.
>
> Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
> ---
>  fs/proc/page.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
LGTM. Thanks.

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
