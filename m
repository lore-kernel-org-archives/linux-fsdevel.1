Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C32941A90F
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785825696; cv=fail; b=JnnViu52Ol2I+CQO0vo8cQZbUW6JGEsK2OiTa0660HPPRxisxvUwBpgYpqVkOjrm8MCBIVY9PhRPNjbnYlwOmC8wGixiWGziah2aPGW8JvTT7u0YYIlHFOiqf85ECfQUcE/k+3/9hRQmGG/3xWerDi5kZANY3DzwGUku2zJ3X3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785825696; c=relaxed/simple;
	bh=4w4xQow9AbYj6nKqPtPflML2MoZLjbG30tMLuX5/FTo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=G3jC3BTrlctAJELI8fRcFh6ktZ0x0dOaJZu9wusioJmDJbPzAj0heFToy3NeLbQggnEMWewoZ6ha9LuaYHKpDLfzCF0Kh1uciBM4c5K8bAGDHZXj5NZ6J9JMXqKJzhCulVRyGeuGwSfYTmAPA0c5ToNAwt2h9XD6ABdO3HepYKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lAhQuT8P; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k5NCJObN reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lAhQuT8P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k5NCJObN"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673LUhnC2955794;
	Tue, 4 Aug 2026 06:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Gtg/kqb9ctiBv+E3FCyLKl9L85ao12V/l2SDYhCBId4=; b=
	lAhQuT8PCzvdhGSSMeryDAX2C5oR9ElYKjxbQjONb3+fTdIX4AIfukVgIe+02Pyr
	UxVIqpF9Q6Jj1MNSefaHLUacV+ADaFW4H7FBs8WJuedz6JZVYZLVOfcbFgDQuAEt
	zOaRvWtsKgG6egXAmVarkr3oWkdo5a09KEz23E9iElcMNv3LsLNLjDrKvyY6tttT
	UWQKWAK+TR9NaUzLX/+d8glEXulBldsRHTtbvL2VKSheTFnTtxR6tVW9FnRBsiSq
	dapDtjcINezEdEyOf62rRCDC2s0u4PxriV64dWU8qa388n5z80RF0TxyXiX3Szpu
	hSiZ2sx9XOP8Z/SEZH5I8Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs8p95122-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Aug 2026 06:40:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6746e50r006848;
	Tue, 4 Aug 2026 06:40:39 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ftpyrq2gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 04 Aug 2026 06:40:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l7QKTIHblc/wa9OiNehive7jNiIjkUpHk8ThtrXzG3kXDmNZbYQ/+k+yaJnl0Ym9mNE8tA81u7C84tEWFBz4U5FiHlX0/A+snB+YSYgZ2bucIqiI8D4UWlr8R5GLCOFDZ16EhrUDGvMmXNwhYT+q90o9cDjSCQSTdHod+XV3ibraxO7Drz2BWU/0x8ZDFov7LI9150J/AqPuxxGaoj48a+8ike1oo9NEold4N3HPFdpNG7NpoL6BSNFZkZwYljEvyFLGkPoBOrWymz03nzaGn1+YMRrC59VdryQcWVFACESo2M3ErFK5ka7jZpNfVOD3wXs4tKCAocIsqXAgYLr4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSrx7K20YyFUGJLJuI63ayEiB9Mi0ioVIzgoC2fXgbo=;
 b=yee6Uz6zBQTvzPelymGb4WuJvVl71FxM9dT2RQjmuxy8wXg140B3r4b1xzsqWeVC/uFd+/AFEW1ZZDjdlYH6CF7WJc8HaHqC0We3ofd2ZvxrXaGG1PnU5gz87eIBpWm0IqfdQAcXG4DNyDq6Q2Uv0aHggLjD4ffGsg+qhLZqrqTODeYp2zcExbp2j9Ty7Py5AvSOlfuUTtv8ZKtdxtORv6coeCBZzCx/JlxIgaCPE5SXeS5VvwVp2fwPfaY2UTUdV8UOqyC0p9dwkTsotl353W+nTJfE22Ak+CXrEgfQYDvHv4tq0VaqRTF3VVHMm23TbdrZq4PL1AOX770UC4thsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSrx7K20YyFUGJLJuI63ayEiB9Mi0ioVIzgoC2fXgbo=;
 b=k5NCJObN8GLW6hWslLU68PUJWf30ZKxaUexGwEVqlo9kedSlnxP8SlOXrWi+/8dOUGXuXNQhTflwlB8y/lDGP9YnTsENXzVtQ8LBQXUkOiEBIkWIKv0fJZkm84SFjip1bSA3EXE+T13fcJv35NSIxxyc7ezFsf0MdWDMIn/dfC4=
Received: from IA0PR10MB7369.namprd10.prod.outlook.com (2603:10b6:208:40e::14)
 by LV3PR10MB7793.namprd10.prod.outlook.com (2603:10b6:408:1b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 06:40:35 +0000
Received: from IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e]) by IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 06:40:35 +0000
Message-ID: <2f5fb8e1-67bb-41ec-af8f-b4da60be4583@oracle.com>
Date: Mon, 3 Aug 2026 23:40:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/15] memory-failure: Prevent hugetlb freeing during
 unpoisoning
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Jiaqi Yan <jiaqiyan@google.com>,
        "Gregory Price (Meta)" <gourry@gourry.net>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-3-willy@infradead.org>
From: jane.chu@oracle.com
In-Reply-To: <20260731200802.574821-3-willy@infradead.org>
X-ClientProxiedBy: PH8P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::7) To IA0PR10MB7369.namprd10.prod.outlook.com
 (2603:10b6:208:40e::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7369:EE_|LV3PR10MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ea09b3-e3cf-4e17-8c3f-08def1f349c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|4133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	YyhD1UczbbMXMqrpFXAJy+AQzrdrsbd/FusOZCZGwmTGWncA1RUlxlESAY9+MXMRcaQJRBRiVBCSfV249gM2a2gCMQUOClC2Ikg9OJNLY/I2ob9wz4RaXVguLs0gLfUmPusGehRDaE5narhJ8wrxVvtLxpVP1bGM12Q6MAzFo5KmDhVnm33m6P6ct7OO6iFkpOTvygaSzi6K8fYo7zbmvuA6+5MH+/9utUI/S1BchuUBfb8+MjbzwFMjW6Dhs/EB4QEtsdGe0vBebv2wjrq72AnXcDICKQgRHcWidc7X0ClbTgN3CsG6PX06W3VBsEfQwmBUcPWjbTfRys0AhSLAAj2Bq1ttE0rme98szht6uRi/+yJQ1IeraaZ2L9ZnQl8SDa12FRVqL20TpPrrAr7OiNL/I1pgmHcYbgDb5wy0N66n7kJB6tpta2f6HiMbYIVEPpeNRdN06iRcQCpA60aLPj2ce4ZzypzQAvWP1ayI3pU17d1Wtlz7a5pFa/MBQ7EGLjY4yxbYrqkwGPUNmERQnJGh3Sx/PfBKdYRyd19nsxU5gJamZ4K0cHWH3YcgxG9uD2ij/TVZNZbSYUz7RPLhrOcJ3Af4BztvjTneHpe64wFfhlsauksfE8CkiM0//Z+F0Re7s27hVZfq9RLFibbbeyyNflFCSaJros3s8RIhP/c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7369.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(4133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFZSbGRQeGNmQXJtdmF6UUY4ZjdhRTR1emV4WThCaWlRazEzQzh1eFNHYTlu?=
 =?utf-8?B?TGlhZzdqeE5UTDVRT2diQkdFcnFQM1ExUDJCbTdyVTh3Y0xRS3FYRHZWM0lt?=
 =?utf-8?B?Mm1qVmsvbmxNQ3Y5dk5FT0dRMUNRQmZqWGI0SnVJdjNkZkFzbGdVSUdNUnow?=
 =?utf-8?B?V05acldvcGxWRFl5M1NaelNOYXV4NWxqbkFHUFpjQlhKSHVzc1FtL2NnYy9s?=
 =?utf-8?B?MlQ1a3hvbVhhWnlhTVRpcktrbjBvT21pR3Iwd2xFRFZVdUNUVytBU1RDWlM5?=
 =?utf-8?B?MFQrMXdCK2hxSXIyWlZXMUYvRGNsU3BUNHpNdnFtcyswVjN4SWdNTTgyVmhC?=
 =?utf-8?B?VmR1bVp5SDdOWTlIcTFqWDZFZzNrMjVCNGpabUYvK25Sd3ZiSlpONU9hdWEr?=
 =?utf-8?B?Y2FOdWswZFF0MW1rdjN5YldRL0F5T0RseTh3VE9jdFNMVlZ2UHR1dHRBa2Nu?=
 =?utf-8?B?bnRTdmxWeE9tQm9rUDRXMmJRK2hQaWlUR29peHNyN2phSlZwTStROFdBUGNW?=
 =?utf-8?B?SHN2QXo0eEtSUWUrUzFvQnhtMDJHOGR0U0N4S0ZsYWplemhEK2svTGE2VUpv?=
 =?utf-8?B?SWJyYUdxQlVtcmcrZTRCZHRDUi9oc1FUSnNNTU5JK21TYUpvQVZyaGhOZERD?=
 =?utf-8?B?dzUyaVpLMkxHcUN1MHBZNmZCWnFGbzZ6dEpWNU5Ga25CMkFzSlY1NDlPTmYr?=
 =?utf-8?B?NDRFYUlXNmVBWlIyM1R6UG91bldhZlNoN3BWcThNUUMvOG5vZVo1OThEcFVM?=
 =?utf-8?B?MTlyT0o3OUlkTVNTaDR2eER3d0EyTzJEZ25TcHRCOFRwSXEzSVdpOXI2dGYy?=
 =?utf-8?B?Qk1aMXhSYlFkNVZCWktFU1hFakdsUmltNFlxN3d5TmRuNktDRDJ3elFWTG9S?=
 =?utf-8?B?b2orYkRPMHhsTVFTRmI1K2ZzNm1QUDFkbkRld04rOHRib29qUUdtc2ZLNU50?=
 =?utf-8?B?UEx1cUlMaTg4ZjRIZzdaUTlWeGdtSjlwS1FRb2xRYU9saWxnWFIrb3NFOGo4?=
 =?utf-8?B?T3lLQXVOUWd4WUEydGdFTFNPR0Y4UlZjUXYraURhdndGYjNSTkkrSU5qeElM?=
 =?utf-8?B?LzhRV29yNks3TTZORW9lWXVKamFEdk04Um1RcUUySGt3RFZKQmtEUHBVQ3VV?=
 =?utf-8?B?WHlZek12VThvby9GMkZBSWFuVzRjb1RqdzdjMGVjV3BjUzhhdzE1R21LbGNX?=
 =?utf-8?B?ekR6QjhTNVlrVE9wVlFFVGlUWkViWE5YcVo1NWJHV3c2dzdCVW0rV2ZNY2h2?=
 =?utf-8?B?Q0dpQ09VWGx1R1IyM0NyOG1zKzQrV25LWXJTdkYxaE5Mcjl5R2cwZEIraUU0?=
 =?utf-8?B?TFRkTGE1MEJVd2sxYVo4TlROTllieFd0RjlYWGw2NEUyMWhlejQ0N0Q3d3A0?=
 =?utf-8?B?MWpCNTFnUmpTNFFNaXdzc0RLcGFpVlBMQ212SC9scnB2ZnBIdm10VmxqN3lO?=
 =?utf-8?B?TWNkcWFIVkpEanR5ZDFxVHVNalo5aTc0RUNvakVrMFZCbjd6cFlIbmtTd0py?=
 =?utf-8?B?TFdab0dCcEMwMDUrYkZDKzBZRnM5NUVZZldVVTJHNXJ3cUVNMmpUQ3JWRHJ3?=
 =?utf-8?B?eUNpYjdaekJVeHpuL2NwMXFrRWVGbkwzOGJNY2hHM3RCZVdHd0YxL2Qrdk1j?=
 =?utf-8?B?eUxBb2Zka3RNem5nb3hXQzl4dFlFQ0tkMWFqUGJHMjFOY3Y1MXAxMXJYV2pS?=
 =?utf-8?B?bTh0NW1rWDArRDYwdG14ZWdrS1cxdHhDY3pITk05bXVuQ3dkdmpHeGlCRDhx?=
 =?utf-8?B?OEd4TFM5d29DVTNIMHI5RjMzSjRBNWpKNCt6Z2lsRmhFb0pTZ1hpSk1sVXVh?=
 =?utf-8?B?K2ttVWR1QVJHQVF5ZkhvNFNMdnkzb0NkTjZqWVZNN3d0YlN2YWlPdFlyQnhh?=
 =?utf-8?B?QWZxTktyVm9ielZSbjFIQmh1REFnalFObFo5cm1aUHV4RWdKSXV4bFQ5Vm9u?=
 =?utf-8?B?NTI5eWFIRXNEdG5nbDNzQnJyMTBKcFNkcVRGSWQ5WEtkV2FpeXExL2F3MmEr?=
 =?utf-8?B?VHQzSklzNFFLYUFRQVVGK1ROK3pobCtOWkVhcjRWVEtkVWxNK3JKdUdzaks4?=
 =?utf-8?B?dGhUYjBGbHl6Z1lLcTlVQjNIbndCU0poSFd0elE2SUtNdUpoOFo5eEZ4K3E0?=
 =?utf-8?B?K3hMTGRDR0xxUXQrY1FKUDBTcEsrZlV1eENZZ1R5Ykloc1BxQWhGVlplVGJz?=
 =?utf-8?B?RU1Bbm01eXlHempNV013aU03ZlFqVWVIUmVRU3FnbG9DVm5GSDE0aHdqWkdV?=
 =?utf-8?B?NXJHZjVUUGNnb0NkTUh0T05KQVErVUd3NmxNSEMwNjV0V3A4anhxUUVibm1q?=
 =?utf-8?B?eUZra2VwaS9wY1lnUGpBdkhUNUh3R1FkZUd2WkpQdThpck9sQkExdz09?=
X-Exchange-RoutingPolicyChecked:
	cSHRlDYWc05sM4FGzFFlmdKIKh6Xri114gMQS399in5PPtSLas682i0E+QKXpudglQPQRNciddcGmmy2k8XaOu3kHFg7aPAjiHAbkHsb/8Od1oQ1LgN9jp0/i+aP+QUFVg3WAtHFe2YM1u9fmHqtkSsP7SLrkAsOp2VlRWx7eHokZ+zCfejeGPdSUl2OZ5zAVepjOB9SA/vVFP85vnwll6LXBqsHA5Izlg9c3IPU2dJZfObJ+Mc+kzMe9DTdsZ+9KUGeiv1TyE1lV6spZuuc1ahbKDUIzen05NVdPl8U6m6h5c9z5rp2WlwdYL86DtRZkoBSaBZs90s4oFW2hYOxDw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	135x9MWQQcRMKeshSEOOc2MwUcDr/Zvnh+foiUduyWmBBMfsjmHWMJ8HT9Uc2g10JcdXyk4HBVDFFBthdk/OC4kjwy6GuHDAo0OxWxcon7oKGEn85gRPqZsbzfGoiM2xyKAu2xye3iDvWCfC0y5nHJcpPcapsP4XEfjD8pJ4FddCqg6b1YJ1/nAPoYiwCg24CqnQXA9sjtppqzroDitJxn5M9DPQB0oX9Tlr79/OjG2hpeg/13suT5C9mXxndLgYpLMPcEC0nIYubN9GcR2Ytz8tNLD415PxANoUyygseXWawW1fD4bvG5yfzm/39b7haK3I+A3/wx4BtoerQ8ciYijf5efdat4ufBwQD/as8k20q+j/P1qZOqkXkniU8PPMzxTVdfdtEwCbZvQHCGgqxzFb9e6+54w5d7R+3jEoRnMkE4U2fvlrvBDSnMXGHmftVujJeO+5GB0xRiKuKCEasyLsLVmXOWXIhpYzFuu14gFS2w8ErSbQqmw0HFyEGc2x1mX4zd0e8kFZOvDZLhLxkmdUW1oNiGrtKPN+4qtQ07+2eFbHrYUqAHVbCJYPphIf/R9SylQNO+uTNV8Owdoas3gcjo6BtPBQ4KZSTjystNg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ea09b3-e3cf-4e17-8c3f-08def1f349c4
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7369.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 06:40:35.4056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XqvdZ3F+KA5PaSZXZvXjtef6JbfMXE2nUNJczANAH0DTSHcclAj4SLOcVROyesrqnSUUtBoEqxmj7j1pxYUX+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608040051
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1MSBTYWx0ZWRfX8VR05W5K6iZB
 Rb8pHlTMLgwInJ73rAiSkB7LP6xkP8b8Tc6WZ09gJt+AQumeaMHug2qjNlzkB+GVwkBefYImfJw
 XzCOnit/m5hyg5PCpyyuU1XNNHDv1uAwqIXyNWLVUWmXewDK9V2c
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a718967 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=RpNjiQI2AAAA:8
 a=JfrnYn6hAAAA:8 a=tHa68p0SAAAA:8 a=yPCof4ZbAAAA:8 a=vlsVJbLdAfBETsbfT04A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
 a=ufIsyHvWW7FwcMbVRpPq:22
X-Proofpoint-GUID: kU_R62zS55BfppJRRXMuzi5deu0CeKcs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1MSBTYWx0ZWRfX336vL8EdDX11
 OTRWai+Sip5nISSYDKEXeIbbl9+uRp/9YuQf+m6nCdXEC4F8LNkyRMddQ10LlyD1Nu1urt39baR
 mspyDptW1wv+0ntS3gm/G3N+m3poFx6duZImfWFBBOJes2qFid3alDEUBnExkGw/dcEAeNPtApG
 e6pAcI9v+kWNBZjGUdJOjn1PFgV8RpwdliKO6Li4f+aYtqQJbbv2HRVjMwrxNr+eKGJisgnpU+E
 aVN1o+zlYh/0VDTvfkDD4ieAfjCitSjiWx5aom/au6++Fw7+/7aXhMKnVZTVJDbOlwmcn/vdOPQ
 axGruKRzZliQrrIfkMxm9DxC/HY8l+JGnia/qLIlAn0YHXhE9+TlntI5tDxDwq5qH6wYu6x5Y9X
 FWv/CvbSsIZctwIYBgj1dPWlzGcljZah+q0ikRU0FdRScTypds5ZHmCebCZ0Q+QNNhocXGwyK0A
 iHLuPMUK5JmGMHjLSHA==
X-Proofpoint-ORIG-GUID: kU_R62zS55BfppJRRXMuzi5deu0CeKcs



On 7/31/2026 1:07 PM, Matthew Wilcox (Oracle) wrote:
> If we fail to get a reference on the hugetlb folio, then it might be=20
> freed as we operate on it. Prevent the freeing and the attendant races=20
> around manipulation of the raw_hwp list by holding the hugetlb_lock,=20
> which is also held by the hugetlb
>=20
>=20
> If we fail to get a reference on the hugetlb folio, then it might be
> freed as we operate on it.  Prevent the freeing and the attendant races
> around manipulation of the raw_hwp list by holding the hugetlb_lock,
> which is also held by the hugetlb code when freeing hugetlb folios.
>=20
> Fixes: ac5fcde0a96a ("mm, hwpoison: make unpoison aware of raw error info=
 in hwpoisoned hugepage")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>   include/linux/hugetlb.h | 19 +++++++++++++++++++
>   mm/memory-failure.c     |  6 +++++-
>   2 files changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 2abaf99321e9..50eab2c23299 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -110,6 +110,17 @@ extern struct resv_map *resv_map_alloc(void);
>   void resv_map_release(struct kref *ref);
>  =20
>   extern spinlock_t hugetlb_lock;
> +
> +static inline void hugetlb_lock_irq(void)
> +{
> +	spin_lock_irq(&hugetlb_lock);
> +}
> +
> +static inline void hugetlb_unlock_irq(void)
> +{
> +	spin_unlock_irq(&hugetlb_lock);
> +}
> +
>   extern int hugetlb_max_hstate __read_mostly;
>   #define for_each_hstate(h) \
>   	for ((h) =3D hstates; (h) < &hstates[hugetlb_max_hstate]; (h)++)
> @@ -279,6 +290,14 @@ unsigned int arch_hugetlb_cma_order(void);
>  =20
>   #else /* !CONFIG_HUGETLB_PAGE */
>  =20
> +static inline void hugetlb_lock_irq(void)
> +{
> +}
> +
> +static inline void hugetlb_unlock_irq(void)
> +{
> +}
> +
>   static inline void hugetlb_dup_vma_private(struct vm_area_struct *vma)
>   {
>   }
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 944e6e1d4971..1dd0e7b99bb1 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2725,13 +2725,17 @@ int unpoison_memory(unsigned long pfn)
>  =20
>   	ghp =3D get_hwpoison_page(p, MF_UNPOISON);
>   	if (!ghp) {
> +		hugetlb_lock_irq();
>   		if (folio_test_hugetlb(folio)) {
>   			huge =3D true;
>   			count =3D folio_free_raw_hwp(folio, false);
> -			if (count =3D=3D 0)
> +			if (count =3D=3D 0) {
> +				hugetlb_unlock_irq();
>   				goto unlock_mutex;
> +			}
>   		}
>   		ret =3D folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;
> +		hugetlb_unlock_irq();
>   	} else if (ghp < 0) {
>   		if (ghp =3D=3D -EHWPOISON) {
>   			ret =3D put_page_back_buddy(p) ? 0 : -EBUSY;
> --=20
> 2.47.3
>=20

Patch itself looks good, so Reviewed-by: Jane Chu <jane.chu@oracle.com>

That said, there is a pre-existing issue:
folio_free_raw_hwp() should check HPG_raw_hwp_unreliable, and fail the=20
act of unpoison just like what __update_and_free_hugetlb_folio() does -

static void __update_and_free_hugetlb_folio(struct hstate *h,
                                                 struct folio *folio)
{
         bool clear_flag =3D folio_test_hugetlb_vmemmap_optimized(folio);

         if (hstate_is_gigantic_no_runtime(h))
                 return;

         /*
          * If we don't know which subpages are hwpoisoned, we can't free
          * the hugepage, so it's leaked intentionally.
          */
         if (folio_test_hugetlb_raw_hwp_unreliable(folio))
                 return;


thanks,
-jane

