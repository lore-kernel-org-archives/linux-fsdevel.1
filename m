Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C4C365A03
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785875617; cv=fail; b=Ee03naly6ioeZQ9kNgfuEHhTyt7a81Pbx/sqG2dMMQJ2yPSj4PNk77fyM88c0EvEJHhTZowrQ5R31TmyQ0P0qlC4iCviwniGEMer/SQhAyeLZpAIxQCTMAOiUZQit8vdvjA561Miwwjqx7zd3LoNlFxVVn1nXtOeo+VObhG3cFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785875617; c=relaxed/simple;
	bh=WyZM0q5/snfVWmFKniZ0OMEDIRTmoHH88unX7PwFdhE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=bSbIfp8ft2rQbE4arqpcKjI4q3HZTZYFlxj8jRKQOsI6lb9tCn8v2w6tth4l/VAXx6di1muLt/6cCWZWRlb55EhI0QAHl/QJNmkDzAp0RRpBhPfL10a1qGPrlRjhG8AbP5sLIDakm0Pf94zBOj6WLYb6EsTwXwFey7f0HtMhy7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iyEFTJHO; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=joNkd+Fs reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iyEFTJHO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="joNkd+Fs"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Fu4mt1438546;
	Tue, 4 Aug 2026 20:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9lbk2ZA5tYdLtGMsBDDqEV7jSLOivqI+fS1Ct8ejNtM=; b=
	iyEFTJHOXL5vLoV1zG2FxhoDPlbJSxXtwuaD0mx4f/nchh3Vu9pVTmGiWyHxpBYk
	2qf6UI+idLk0iSZ5StMxBI8vBFsyemITx0FFch3zEsq4844875jJwrUPuCDxVj3V
	rdjiDRgdQgmbu5m7KZ0tf79B07DXtwDz9fCIaEcZIzFJKEsHzpfLive9TBbGtQ+W
	IaC+nmJWwoqLpqsmqymR4SerYSgPSvpzA2HO3UGOFL0TtxQcd1dEc8T5R8QxHxFE
	K56riLYEDLPQGbTitL6S7SkyfO2UT8VRVe/yWV7Qm2zmASExnPtp7p/0j+wf4aHV
	Ng7YtN7UFynr7MU+1uJGgA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs7k3ehms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Aug 2026 20:32:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 674KPUqv006329;
	Tue, 4 Aug 2026 20:32:54 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010008.outbound.protection.outlook.com [40.93.198.8])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78uej0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 04 Aug 2026 20:32:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCsgN2dy3kJZ8LD9PwX1LZwMIXVsU4QG8wHm/roSre+mM/JhFTMpeFzGEPlOOldNGj8tVBoWpPFIp2tVxwcbp1idqZnlAlrmifESwHr3K9pPyt8QVGDQ6j7fwO7Nti038ZrOF8RmRazrGtsRgZJ+jtSBxNe6p7zT9obeIxt/zItzpNxPgh4lVH8daCidjLJb7gQnIhxhklGg4lWuE3fFXyTXhGnEwIa4LPiwAzHaIetwjELPbGaanFht+AYC+sOdXpZmycMyf4YkAZ4BK+qJJsHAA93a7WOM1fjWfQOjNu3oXtlzk1JbpEbK83krAh1YP/Bqbk32BFPWsiof2WNuFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saShUNgSegor7GmYouMRAGrwA4s6nXOPjX3n0ZdPvcU=;
 b=w06TOjsUSVS9RnVovrnxOHFcBqEfBEVRPKSpCp9hRy2Gi63KdPjZpL1oZTJiQ1YFNOMw0WwOA3t6kfYc30CQ3xtu0WZGX5ER5QaknJtpwg05Sqlh858V+brUWMq8dmBY7SekJ5l8goJdQ5d1U3BVjHTB3fmbKJFl45XKtOXlFHQiY3ctzGYQpRetIVh3KJOAAoLRFH2VBd4pcwH8SK4hcy7t4ufYXYwWVBZF5p/Jnlcbrggy1O2daGh/1gHXqh+56PX8Qpnnr2xOSrCz/0vEbXQrmlfz3FfH9Cftb5E/BxTUMjx7zRe5c7l3PuZZeQhlgzPPC9QeBdz9i77RLywHTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saShUNgSegor7GmYouMRAGrwA4s6nXOPjX3n0ZdPvcU=;
 b=joNkd+FsjhCtqT9TFIO42XLbPdeXaQ203WlEcXaRUcVduqqLnLIeO2JvDC5JvH2Usj07wtGZa9mGWRWT2rtoQEQ6r4YQToHXwsZQ2g89aYMOA8wL/sB4g0T9GIX42T/bl9vGKfHlDDnke17v90VnmqdMkBZsDAVE6RY7C8s+JWE=
Received: from DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) by
 PH0PR10MB4567.namprd10.prod.outlook.com (2603:10b6:510:33::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.15; Tue, 4 Aug 2026 20:32:51 +0000
Received: from DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f]) by DS0PR10MB7364.namprd10.prod.outlook.com
 ([fe80::a4df:c903:e1aa:322f%5]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 20:32:50 +0000
Message-ID: <17f28eb8-64ee-4fb4-99aa-ffc157e3006a@oracle.com>
Date: Tue, 4 Aug 2026 13:32:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/15] mm: Remove locking mf_mutex in
 is_raw_hwpoison_page_in_hugepage()
To: Matthew Wilcox <willy@infradead.org>, Gregory Price <gourry@gourry.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Jiaqi Yan <jiaqiyan@google.com>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-10-willy@infradead.org>
 <anIUe_Zq8bFX0-Dk@gourry-fedora-PF4VCD3F>
 <anIaMs7XtXp631QU@casper.infradead.org>
Content-Language: en-US
From: jane.chu@oracle.com
In-Reply-To: <anIaMs7XtXp631QU@casper.infradead.org>
X-ClientProxiedBy: PH0P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::14) To DS0PR10MB7364.namprd10.prod.outlook.com
 (2603:10b6:8:fe::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7364:EE_|PH0PR10MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af1daf6-4a02-4264-1550-08def2678dca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|10067099003|56012099006|4143699003|18002099003|22082099003|4133799003;
X-Microsoft-Antispam-Message-Info:
	oYoOn8ytD07Bz25YIJ+CUZAKyjJO5Z9EzCq1yTHW2bvLrXTaS++oaxDppjQjYslNnPdMmgMifhw/1t5o9M8AHwUxNlaEuDpsIkWEg4XmqXvLaEoHQTi41UtyYdu+rkSzMizh5VF+DM3thKFvDd7LdeM4uTtKRmcw8tpstTknHXtpgwQInYrCApEoayDZC+d2H0PcJpNykrsfTZAQsvzF2H1Of5n+58RfwRzyevGNVbgUnBQvpYPahpfsv+E3uom0qoQDeungMzSGnKzCMlpAkomniT0/wV2eiuN3XQwDis6BLgnb1VTfhMwLvW2IVHiC6hV2gLBDo17i5a8hYZXpfKrsAuI1O9ngz9cq4qh0lvnwONuBS8MD36TXQZ+P+z+uktXY5YWdNNO4dSi6Zy71BGLqGFpOW3kPLnY0rnngu2dY0JkiXRKW1H4N9NN9dt31ZGTCGbCRmh+wIYStnvNj+MveK4iOUb+LdMcsvTly2oep00AQ+/yNSfpsABsVbBlyDv+mLt675JcxN6yAFENkGu6wLo42dgzWJB9lTSdE0cE0gBaySogZtsmY9Nx1VQlKNvA0HdSs+yZwSGfs0yroy4D9YT1x2iAamfSDPgGQbdlnr9C6A0Hbru/OjC9Kq+Cz2+5Spoo7v2HgYX2FWzf97++R7ZOhcSKKkuKCQTwI8WA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7364.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(4133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TndMbktQM3JPMFhMNDRHMExuMGxaYmE3amsyczF3WDFDNHArMnk1T0tKN2ls?=
 =?utf-8?B?R21TVC9NalZaOFEzOXpUZExkbGhaQzZ0YjNKTWEwaEo2aTBCV1ZsRTZjVFg1?=
 =?utf-8?B?bFhCS3ZIYUw1UlJHakVlU1grWFh3cTJPYUdYcTFrSDRSTEpMNURHbWxNczV4?=
 =?utf-8?B?UFJuOGVMQ2FWR3Nzbld4TEJwd28zNjVoSzAvVWx1YWNVZHliSE5wMlE1cG42?=
 =?utf-8?B?aTIvdUlXTFlUVThmTlVMYjJSWTUzTDVTMDFveExuSTNpR3c1cWZsWCs5MXZy?=
 =?utf-8?B?VU96TkwzNmhiR1JoNGRBK3hxOFVjQ0FTLys3aTRiWWI2OUN0U3lhbEFkN1Zo?=
 =?utf-8?B?TTZyemxDV2NkYi9nNWE4QWNJbU5NU0hoNm1tWlgwdlZ1dmlMSUIrNzdPNUZU?=
 =?utf-8?B?emRTMndrZTFvVFUrT0M5akEyS1NsY090Y2ErS0grQ0JTb20ybm5XMmpQbFcx?=
 =?utf-8?B?cnJYUzFOMmZrdDZ4eUNINGxDd0Y3anh6dUo2RnMyVkZtcy9nSXlyY1Z4UmFJ?=
 =?utf-8?B?aUZCZDYzY09Yc0JmWGRtdW5XS1FvaWhXMWhvdHNPZExEK3hBN2N6WEZUbUFM?=
 =?utf-8?B?ZTBtdnM5bko1N2swaklVTEJ4Ujg3eWlET1orRXNBVEdoaDBibDI3bzNUMStK?=
 =?utf-8?B?dmhYamRsSHUxeU40am1sUWZyQkhtM2JySHRHL0VPWmdhYjJpREMxWnd2N2Y1?=
 =?utf-8?B?WjFLMTBqQTB4TG9pc2w1clFBOFc3d2FzUWxacDRZbmlwUUtNeDVXVm9XalF6?=
 =?utf-8?B?ekpieTMxcjRyRGd1UVhiV1FyTHRrMksxUnd6UkJtNFA4YUpHd0RKeC9COXJv?=
 =?utf-8?B?QXhwREx4Y3piMWxaMXdTSDNFeTIxV1EzcUFZR2ZwY3k0bTh2Y1o0Y1RGUmE2?=
 =?utf-8?B?T3NMd2ozeUZWUDlyVHp4c2hPdE9BTjV6NWRlOUVkczBFZXhsUUM3SU12U2Rt?=
 =?utf-8?B?VmdHQnZEMW82Tk1HbXlYbGUyS0xudEFGVEpVNmF2RFZ1Tm9ic3J3YjJBOVVJ?=
 =?utf-8?B?cllmSkh5QnU0dXkyZ0dsbklYVXlqRHJsRTVGblplTkR0SlhqaGFGamdNY1RP?=
 =?utf-8?B?THVqblZBWFIzUy9sOGQ3c0k2aThUNExRRGxZQ2Q2UkdZbWFmbjN2N3pId0di?=
 =?utf-8?B?eDNxaTkwbS9ybHFNTDhna2k0bThSUjFtRURhOXRmSHVNbEZTcnZLWThjejhm?=
 =?utf-8?B?WklPRmxOU2VrUXVZc01sMUlDR1MrMzdPS21tdHp1S05vSGhQZWlIQU14YXNE?=
 =?utf-8?B?QkNBMVVRb2EvNUkxN1lWRGxqbTYyQVVkMjJuNnJuK0RmT2hQdytBY0pteWsw?=
 =?utf-8?B?eFkyRlZva3JjRGFzQ1hsdFI3a2JWRFBBMkZyVGhYb0kva3FLSW5vOHJ1ZHpB?=
 =?utf-8?B?akFXNVR3TzZLeTZXbTR2UWZWN2NBbVFvZGZFcDJqbHRDTEdmWkNuN3NucHY1?=
 =?utf-8?B?WUMwM0F6R3RtU0xWRkF2ZkpiQ0dpQWIwYkZwM21sazVrMW5jVmc2dEttOWxQ?=
 =?utf-8?B?cmZQUzlhZC8rakZvZzNZTmRkTlZRQU5QdzB0NFlyWVlZSUxpZm4ySVkvdEpJ?=
 =?utf-8?B?N0NZalB4bXVDTFJ1RzNwRjFSci9ZWjBHQm5PK1VYZElnNTEySDdScE16ZE1J?=
 =?utf-8?B?bk9GbFI5c2o3MktFc1dpMXdWazE0ZGhmaFVFSkp2eEZlV1haZy8vZ2xCN1pR?=
 =?utf-8?B?Q2hrcWlkenJNUVlRTU85cXI1RE96QStVZE84THp5NWY1ZHVhS1BDZU9hc1hr?=
 =?utf-8?B?MGtxeGhUQy9RaVI1ZG1VVi9SSWlxR1B6WTZ2K3NSVG1EY3RYS0EzOU4xZDlH?=
 =?utf-8?B?MUtFQVdRaXJhRzgwa0RKOFlkcmtQa29VK0pQcmpLWFA3emJtMDBIUTZrSkFV?=
 =?utf-8?B?dmE5ODNoRVQ5OFAwNElURXVEdEZ6b082cGYvN0Zwb1FJVW9oamx3RkRFVFZH?=
 =?utf-8?B?bXIreTcrMHRnSUM2VmR4K3BZSWpuUXJtR1cxT0xLMEtWdDlNMWFma25QYnJi?=
 =?utf-8?B?TXFOUmVCQzRqdmVYYkpPK2RaSTlHdEpzQnFRVmlqYlhrbWkxUkQrWXpudHNx?=
 =?utf-8?B?L1JuR0lobXNXcHRwSTkrdFo1Q1pJSDM3YnBJMEcvcDhZQlZsUWZKc2hiT0di?=
 =?utf-8?B?UTY1SzBVeUFVOWNseWc5MHR2UEp2aTlydEY3SzlWc3ZEeW9PN1JNZzhrTzkx?=
 =?utf-8?B?MDZlcHlaK29pNXN3Q2hFaFBrMURnVDU0a04wRW1EcXdqM3czRG9wUi95eTFF?=
 =?utf-8?B?ZnlMMC9KeitXRVhkZmp0WVZOQksvMnMxK3B5N1lHeU9ZVERGSUtKWXhMY2Fq?=
 =?utf-8?B?V2VpNEI4ZSt1M0NmbThXUTJjMGFjRFA1bUpneU96MlR3ZWlIZGdnZz09?=
X-Exchange-RoutingPolicyChecked:
	Vr1zPmrmRiD91VCFjwI/HU5t8Rk0Y6pbXyrNpjOKynDTYrjzYJzayVpavOc1dY0glbaHx20sbZx4ptxcWsb61qJcK2pdTAmx87ksYqLmIeIaDnFM8vXwxSzhR6kAN4oCZ1Gvr7KlxMEW8NmkO5t08qWpb7LHVJ/QssAO6PI55WT3a379Nnndv9naEjE1iwVyA8st1AoqATFFG5FiYpACllmVGPotpR71AAsjph1oSg4hD+yB08/7dveYROETsXR0cJGizXNbHlHxH9I7NpxdLoP7fUa+ww+7F+ERNV7baK5dqwtVEMlbIc2jm0bZsmf1u7KapBXxrh2p0UbsqZp/Sg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P9KervTdZ7A7Q3g8n7KYiPAYedbs1hlDS2BIoV36rZ9hxU8F+qQdEIA7CLea2+D7mugWpce28nW4n9Zr+sl2KTHLOxvCzhdcCrbrs/tBbCI8oDKbAt0m8ZODzsrHazJSsIc2WU0oN8wb0RwBXkAxRpAww2jIzS9YMZvxymmvJ+zspvxEY6S2A3NyA2grcjmPooRj1nRU5XsKhoLbai4H7QbiJTy69v/NLIu70mbel7Cu2xk9HBRekRuqdNIuXpRYFAqXOwh8Zm6vKM6l9TYfNg6Uaj/SmeJjdZ/v7ajtRzejKQGEckUW9nJVKP0M5E5DyLl1WlnOjpd9m7P9d7lvQm3nu1uxDNVzT0xjpu4rJyECYNkD1EGjsQs2NYPVl9PMQwKNDzmM9GSIE7KVde4HBOpHbSfhJ3gGpnCeCDXmT7YixKVKkUNPPwDlFhTJh2fej2Oc74M1w1VuIX1m3PHyfbhO9sJiDfOuNRtLoTj9uGrH/VwWQY4Q7Jbfn71bgBlSUK97N/zgyCEyR7LJ/1+BVwuqYstw04ueaumwasGGv71lkbSENhinuXOohBgY//mucqv90kYq2AybSbRQqgP02cicmHLrQoVfafH1NTZixVk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af1daf6-4a02-4264-1550-08def2678dca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7364.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 20:32:50.8659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qe2N6WVLLHAHyU91koqVZjKjw8IN8zL5zAjfEHd5HldtgOdRsQ8pibJxOI43uvEtY1ErdDryRi7lYkhX+95scA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608040165
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: uygIQCU7wY0BEA3dvbtWu8aiIaKirH3p
X-Proofpoint-ORIG-GUID: uygIQCU7wY0BEA3dvbtWu8aiIaKirH3p
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE2NSBTYWx0ZWRfX5qKpLDMwKpAH
 HAP8Yl76t2X46YMGCEXyn73wc2dixQBr11nT+foDN3jv3b2lOdkRvg8sW8+FEnJlPP9BKdcYn2B
 HLP+Qg0vkYxKZ5uQ7gm3fuLWZVc2QC9OpOaKYjGu2LW6CwmBpZOs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE2NSBTYWx0ZWRfXyBi0Bhds/kWD
 UG3Mqg9Zy7uzlsIq7+0TD4uX4rTbiJB/IGwr6CTl96Tsq7wC3kjYz1YeZfevbhYm2YhkzFnyDBO
 a/Iz8V9zAVwXuFhOgaRZ+/gJidu38RebClbsiDP60Enfp/TUoMgwhCG1O5J7qRazZAudkIQ1paE
 VRxMyETkn/iFkxGtTNUl+g5sBKurU3wzbLj2MAO1kXLOWNQ5GbYBiyKQ9HLW6/roqKAhYQkYZUl
 X2GThCKBdpMO8FAyOl355NOjswmrCb98L1XFCB0URo00RlEUtPT9V6dwhyEYiHSEDdvAduxdeVR
 i9HxEuJq19J3xmfL2kDP8HHBGQDTjvnr40sZOhmNAZRQbvkfIVbfWCdbIwIJkxStbVhP5fHnsfc
 wchcGSjwbDQMAO/5Ex8nW55FgeDT/I8yHb9vxWN/+w8ffMucEc6Fh/Oxq50g4HUm5UpKMzS9HnX
 m44zy7m+ImouQF3SXVdJ5K/yn3pzmL+NSOfMrwgA=
X-Authority-Analysis: v=2.4 cv=Iqcutr/g c=1 sm=1 tr=0 ts=6a724c77 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=RpNjiQI2AAAA:8
 a=PX_lDwNKtqXEm_iy6PAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12100



On 8/4/2026 9:58 AM, Matthew Wilcox wrote:
> On Tue, Aug 04, 2026 at 12:=E2=80=8A36:=E2=80=8A00PM -0400, Gregory Price=
 wrote: > On=20
> Fri, Jul 31, 2026 at 09:=E2=80=8A07:=E2=80=8A54PM +0100, Matthew Wilcox (=
Oracle) wrote:=20
>  > > Sleeping in this kind of predicate is unexpected. Add a new=20
> spinlock > > to protect
>=20
>=20
> On Tue, Aug 04, 2026 at 12:36:00PM -0400, Gregory Price wrote:
>> On Fri, Jul 31, 2026 at 09:07:54PM +0100, Matthew Wilcox (Oracle) wrote:
>> > Sleeping in this kind of predicate is unexpected.  Add a new spinlock
>> > to protect access to the list, and turn it into a normal singly linked
>> > list now that it doesn't need to be a lockless list.
>>=20
>> Out of curiosity, wouldn't sleeping in this context not just be
>> unexpected but theoretically cause issues? (mid-poison, sleep, scheduled
>> process generates more poison on the same page...) - at a minimum this
>> takes a thread out of the future potential poison-generating pool?
>=20
> A reasonable question.  We don't try to handle races terribly well --
> hwpoison can be generated asynchronously by patrol scrub, so it's always
> going to be possible for a thread to hit poison on something that the
> kernel didn't know about.
>=20
> What we're trying to do is avoid touching memory which we already knew
> to be poisoned, while also permitting touching memory which we haven't
> been told is poison.
>=20
> I see the locking in here as preventing list corruption and UAF rather
> than preventing races.  I'm also considering that we're now exposing this
> mutex fairly directly to userspace -- before it was only being touched
> through some fairly weird mechanisms like reading kcore.  With this
> patch series, every call to read() potentially touches this mutex.
> And that could hold off recording any hwpoison for some time, not to
> mention serialising all other calls to read() on a given folio.
>=20
> So we have all manner of protections that prevent us from taking this mut=
ex
> -- the folio must have a hwpoison page in it and must be hugetlb, but at
> the end of the day, one can still be preempted while holding a mutex and
> we never know when we might want to call this from a non-sleepable contex=
t.
>=20
> I'd be open to arguments that this should be an rwlock rather than
> a spinlock.  Or figure out a way to shard the lock per folio (lockdep
> etc make it very hard to embed a spinlock in struct folio).  I think
> it'd also be profitable to change how we record poison for hugetlb to
> not need locking or memory allocation.
>=20
> But this is all a very long way from where I want to be working -- cleani=
ng
> up the page fault path.  I think I've made a reasonable set of improvemen=
ts
> here, and somebody else can come along later to make the code even better.
>=20

We don't go down the path examining the raw_hwp_list unless the hugetlb=20
folio is poisoned which is a rare event, given that, I felt the lock is=20
fine.

thanks,
-jane

