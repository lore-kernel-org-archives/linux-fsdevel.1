Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04AD37AA9C;
	Mon, 16 Mar 2026 23:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773704982; cv=fail; b=YJyAxaFN1VCglL17iqRcGclecbmL3w6j+zTRVLjBTOZQd+1Z5J9+RyXr7TV5EbxX9nm1EZJez1b9sYLNIxBQsiE6esY0Y9rPykpKj0W+CBsy4On0RuAbfo7MrkTNXee2h/b8QHl3UWlRztsJKS42iqiIR4EzIdLrWmX9Al+HNro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773704982; c=relaxed/simple;
	bh=5QGmqCnVPO0pIbzgOoSjNb94EYgUgX4qonTEQNNeTmA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RJhMyTFvFg5pEUOYOBSNnLbSBiPF46niLa5zNxfzr9UCWG/ZzatZ0FTA49o4BFSa0Ir4eVzMaF0qd1wE+4UNa18YR5cYhyqhVr/3ZG1zJwoQMZM44ryX73mBzn0TQ4h+UanDNi7s8GBrjjpaAT3KXu86ST4B9bKLfbpo44/Yk5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EYFa3RRz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ul8AxWc0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EYFa3RRz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ul8AxWc0"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GMGtpf690711;
	Mon, 16 Mar 2026 23:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=fUH/UAT1YMbbGftVBgHLbJ4u99aurcPAu1ElpQBcvlI=; b=
	EYFa3RRzJDnmbqG3IHhrKeW2ixoEvJOpUe8nLr+69ikUColeUcqMW2EEmG0CxnAi
	ErjoHXCCztFDbdI1oQWePu4/XMYaDf/ixUbtnhne440DFoTBXvclb0FILessVm8f
	9reDQuNNy7Fyf9xPElOe+NYTR9zpZxafuQ7Mzh+8+3pbwV4mgTNRQ8I+7mC6aczd
	ooBnCX6KiowZazDZnai6NSiR/Bz3/MOIftDqL8IkowIoovCl58sP8FMXiZEd1LQu
	s8N/4xa3mR3R9iWeBaG4C4sQRMw2rEj1WH9pmStNiMiayxlsVsBEdc5nR0tqDz+E
	BJWrKdS81dz6eMChR+3WQg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyj638nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 23:49:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62GMdH3E013988;
	Mon, 16 Mar 2026 23:49:37 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011048.outbound.protection.outlook.com [52.101.57.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx49a1tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 23:49:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pgFTYEq4KLjPzdJXC3YuG9GkrTBRy1qrCk3q5fspVoeu7Vws9Allcz+/A3nuKhsM1J2qaSqEbuBbljyaQ9kgFe54smDIFZfZtHf9JA5NlgcYrEo3iHzoYku3qh+6xpbk/jigDlg6i1vMZ8+BY0nkN2ah0BJ4CQ3HJuygdBRmIzbP5jSwmwMPwDGTREFIWFEXvB0TgJAki3VXedt1yAyN638cs0Qg7HFcAXEJpHunPAC2nDosIuF8zag3pdBMtmiXbSnfkmqsNdK4UWuq7lCUX82vF9LDqx/u63xXOuatZvOQcDDRRPOmM49xjffCgfPhXmEItXy8I9+mq3xeu4yfwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUH/UAT1YMbbGftVBgHLbJ4u99aurcPAu1ElpQBcvlI=;
 b=JEm0IcMykjbHGMNVAlvuTTZxDjPAniQPkplIFcc4fKJOXaz5+TDXjl5ghz8OyG3RTb1dlpebj9ouFVrbilJS7jvqq1JtwEgVaKB6E7URxkSMgcqrVGF8eojknP7AWuJI4sscXbYmLHXFnTGzTvW8yS3n+iO+Vlqz62GdGzG5TBIq3JOaR55OamjiITFfLqe+2a0dDZvb6FkbqZ1T94wmDDc5QtptpG4BT3NXp1bFBATXorTJfwqXo0Zr6f2+zXjo27BpZyUBSnMYwXCRFGJ4cdcaz29zU/ybrEHweP6U/2YrwZKTbBBLlJOf9RB4U6N9fspI7P8VGaUZ6gvycLE5kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUH/UAT1YMbbGftVBgHLbJ4u99aurcPAu1ElpQBcvlI=;
 b=Ul8AxWc07P47DWhV0mov8WRKJyPkPV0ypYkvnVQjoXvk6Is49pWAki+XT0CLvIqxsgNxpZIiBQ4ktzskQJxLy/olXkHZ/s6Wzx6y4M7+tz3v9Nwvtprwu71g4UbwrEbmXfl/q/ZbRaB4h4dtvfZkr7b35GQmEnd3WCf9pBZ6KQ0=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by PH0PR10MB4805.namprd10.prod.outlook.com (2603:10b6:510:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 23:49:34 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307%6]) with mapi id 15.20.9700.025; Mon, 16 Mar 2026
 23:49:34 +0000
Message-ID: <4096f2e2-124a-4976-baf6-505b22ef0296@oracle.com>
Date: Mon, 16 Mar 2026 19:49:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH] unicode: mkutf8data: fix comment typo
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316184232.161045-1-joseph.salisbury@oracle.com>
Content-Language: en-US, en-AG
In-Reply-To: <20260316184232.161045-1-joseph.salisbury@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7P223CA0003.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::34) To CH0PR10MB5131.namprd10.prod.outlook.com
 (2603:10b6:610:c6::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5131:EE_|PH0PR10MB4805:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3123ed-c6a2-43db-6edc-08de83b6ad3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aSW6FIYiUJcQPa9mUwGbfHZfKV/JsA4YXiiygULR1eMJwfwCaBFi3JaKPYY3SJcAz+fGzjAy12I31o1beHj2oJ6Wytzb910GpVzBgvbpaT3nsxnCzXfH3F0DgdA/8NyAzEiRV/Ba9hLkv4Rxx7hOtg9g1jxPlk/NF8lQkJY91dc4bb1ZTPIDoO9nlLW67WGMm1pSBXyVDrTxvJD8JJQDGPK2+inzB1eZUJbXwJUBLEu1lgJWb50CJUlPC4n89c0UHvI7s4B7VlpTjgVRFiuzM2fgR9I33kXiwA1Yx4e5QuvgKWvfyVMWAFRbGkNac5CnMyAJmsf1wXaL+n7rACv3icnoAzTWCzahxWjq/nx7TdXMgNMS1OIehyCFsWuCsMGFIwg/C0+tAZPnioDcJQyiRb3B2/b8tCg7gPjtPS7c7w9P1egPD8XYQ+dn5KlE/mYymuMdqmyTeejbr5CSIVna+/K8gQ8alFWnDqiLCbPpUQKr0OMSNpH2NS87g1ekJDl7Dd3b71BzbGnw+A+6txdx/PGtH1OIF6JlUIYyJTWw+PuuDp8ZMT2nqIcZazAPF3Yq2V4D2vcq+dvWR+eVwo92oH8lbwDs4WY+wObEaxeWpr85ROeeoiKgsSeJ9+YmOCo4OU0j9Ix9oyImwmmdz62/VGrUz0pfJY+u/hzz4AM2ih5KefYBiY5uhIDW+sAoeScAIzKnrwAXz/y3MVpsauF9OlmsNPZ1Ehv8ZTbxj1yUFa0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2lxdXlBTzg4U3FiQVU3S0k2dVEwdUdTSTJabUtPSnA5a0R6R2IrVTAyT0dv?=
 =?utf-8?B?eDBXSkNNeGpONlBaV1AyT25DNHFGaVhwb1FYRlRSVjN4YlZMOHk0SjdROHhn?=
 =?utf-8?B?QnVkd0pYVy9CVEhlZ25ZMVZCbGllVVIrVXc2R08vc2haL0IrZTdrRE93STRQ?=
 =?utf-8?B?cmk1bUtLTDdBL2t2YnppaUxrZzBpeE5wU2JKZUthbFJtaGdoSnM2cks0UlFq?=
 =?utf-8?B?MThKd2w3L1V5cHdkaitTTkxYZW80UmkwM0NQYnJOYVVnMUg4RDhjN3QxTTdC?=
 =?utf-8?B?clBhRGRBYjNhMk1kL3MwaG9LUmxzSmRhQkNLbktFRURIT2Y3bW1icEtqcUly?=
 =?utf-8?B?cGpMbkVSbm1NNGlSd255ZXY1VFI1SnZxOVM4cDNWRVhxem44dUJ0cWVZRlR3?=
 =?utf-8?B?aEd0Ykc3K01oeXNwbWtzVGdiZ3paUU1ZM29KcHB6TjFWM0k1RkxUR093VXBn?=
 =?utf-8?B?SVJTaFV5WWlNRzAvRVpXYnVKSU80VHBDbVFLTkhuWnIvaEJiM0l3WGFWLzBy?=
 =?utf-8?B?cTA5cEZ3ZUNzOHlrMElnU1RTbUEyREVnbnZZbHJnU3V5UkkraHY3b0RUeU5i?=
 =?utf-8?B?QUhBV1l3OFpXVjlxQ2dHZGlSSzRMM0djczNKeU1pcU5sS0oxVHpjVE1wWHR5?=
 =?utf-8?B?RGVlbFF6RUc5TUU0K3hVK0FZZWZEM3Z1aDVHTEJISWxDYUZlYzRpT0JiUVBv?=
 =?utf-8?B?ZzJ5YUtiRW8ybUlvQmpPaWNYNTdUVk5TYlBpeVFOdVEyV1BBcE9hQWNDK3Z2?=
 =?utf-8?B?cnB4RDh2ajMrRVhxV2JEZ1RHR2hZVFdLQ0sxUm1SNFRZa0pRa0hRVXRtMnhJ?=
 =?utf-8?B?bUM4NkVKM2plRXBGb0NXM1pST21vaHR3dDNlL0tZYWRKSVpSc2JMd3dRMVAw?=
 =?utf-8?B?KzcyTHdmdVlhTUZwVHJNYWVwYnBlTk9ZQnIvUU4xa2ZweUJ5Y3RDZkVGaHpF?=
 =?utf-8?B?emJZTzdnSm5iYk1iTDh1RjdZQ3BKMXJsZExsZTFFdWxVMkYwbWdxb3NMMnow?=
 =?utf-8?B?ZGxzcFRRRjJpSjdLUEFVSENEWU43cnR1L01wNWxnemQ5R2tmOC8zZTdHUmNK?=
 =?utf-8?B?ckYyWG9ZNlpKTmRCSENYL3M2VURpSG5wekgxbHVDR3VQajN0czFpQlRNbmYv?=
 =?utf-8?B?NVBkTWNJdTRuSTBUUFJmQ0tGS3pMQWQ2ZkhLa1M3VHd3dWdlTklPWGZDd1hP?=
 =?utf-8?B?U3Z1LzFEdmZ6K0pVTEk2ZUZFYWYrdEJmaVUzR21Semh1VXpFbHhkeGxiNW0w?=
 =?utf-8?B?WGxZVnJuMktPc051Z1QxVlJsUktadlZLc05zOG0rYlJNK2lFMFZjb0VGSm5p?=
 =?utf-8?B?ZW5zVlZCQ2NRNUlHUUs0S3RZY09IbnVmRFpqbGdKRU9sbjl5SDRyT1NtZUJT?=
 =?utf-8?B?T05FZThSVXV2a0FrbHlmSWMvNFF3UTRiOGpDa2M4RjVqMVhYSVhuVG45V3hC?=
 =?utf-8?B?ZlFRbFBlT3ZQd2hudGU1K04wUUt2UHBqL2RUVm4zaGw5TUJZckxRSk01RHVh?=
 =?utf-8?B?ZUhwd1VuTkc2SnhTMjgzQWdwdklsRXZoY0gyZXdmNjdjanJDdzZBM2EvQzFi?=
 =?utf-8?B?Sko0YU43ZHMxUitHU09FbzJuRDBla29qUXFqSGlXdmtKTTRFV3RzTFlKTUY3?=
 =?utf-8?B?UDhPYnR5ZVlQVXFwSURaakdRaUxDSS8wbjdGQzBLMnVkSzB6T3hCNUEyUkhD?=
 =?utf-8?B?U2VtSEljWG92QXVUTW5SbDRxeVpWU05iUGFaV0FYNTRuREI2V2xZRzhlem4z?=
 =?utf-8?B?NUJhekF4c2d6YzZ3RG1TWWxadGdpTnh4dDJZMHdKdFBMdFJyYTQzR2dlb0Rj?=
 =?utf-8?B?WDIzTUpKZDRVQUpYUnM2Q0FEVFZ4YU03MzIwZjlNS0lpdWIvMmVOWFdSVml3?=
 =?utf-8?B?NmhJRXFHVHNDRmFGcm9hSUZhL2dKcU9iZ0ZjaG9tdTBIcGJtUER1bGVRejdM?=
 =?utf-8?B?c25ta3BKVlh6SG04OXlHaVJ3cmVaWXlJWTJML0l1dDhneTFGZWY3VTBrMEhN?=
 =?utf-8?B?UHVpMmNhQkNWM0lBSTJ2Y2dYS1BCRmNITWpPcktXNFQ5alZLeE9vMDl3NjFz?=
 =?utf-8?B?SGowY29Hb2tvbTg1UkliellRUEpYQjh0U212R2NVY1ptUzdseGt4YWg1N1ZJ?=
 =?utf-8?B?NGpQc0ZxS04vUkpqRjJXVFhqMHU0Q2Q4RVRTSlh0Y1gyWkxPWTdvTnQwcnVt?=
 =?utf-8?B?VFZ3OHc1bWE2cnkvUEFLMWMxVUduc0ZxUHV0VDcvQ0d1VWlzNHdDYjVtV2kr?=
 =?utf-8?B?b0xoVmxvczFzYWM0eG1OK0NQVHlTemNXaXo5aFl5dG14WklXWm44cmhSM1N2?=
 =?utf-8?B?aWtiZlg0U08vL2FzcU5ObHpxQjUxMmEvNWZFL0orcTFIS0Nqc2xkc2RtV2tj?=
 =?utf-8?Q?El47BjqIN/FrDRrg=3D?=
X-Exchange-RoutingPolicyChecked:
	Ol06mrySyTY7VUdZMRwLxGD8HXzTBzq4s3kXWzvHFY0jFsdznfHVi9o8hQ5RnAPiMqHmoyLLLkp+U6Rbyke0Rq5xqc1A6fKtd4B2LlYb9B3Fga6/JdfnL9vhGmk490sTcYq8S3TZJ/h9vRI9fyW45ITTPCk564uF4aXWUgeIsGqhP9YMU+uleecx0fuoDAqBaTM9MLAvBRSur5PZTOpYJOgB2EC0T2RiUFZUc8okn5YQOvkmXB3rzI7YmZnFGxpqekv+l4LzXlc2O6itiR3DfPMfbmPZgoR4ccKrb4ierF+YBx9M43wdh3/aDMSog4wmcBkimMylGgGNWhESGyLp1g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qFYFewdVEs7yCRdo/Sbs5keo+XZfTE0QEFAghjajAAk/b+TrKXoQZwspNEap4SssxuZ0LZww+Z4oDyb1XkbI5diTzs87ZkSLodAD8XM6WDoJLy+ALd8ZE8i9vBWa6yn7BCNbQT6Me3pEaxCrqcp2o8GdsdVkt9dX78uql2mM0oCj1qhEZabBDEtK/pp2RiGps3gRP260Aur37PO2Nd7spdTVoJdiUGOPmIhf1qQtjaEQahhuX6oRwbjP3MpiyHCZM57IvvA42b+ag8IVZK5nsQ5SHqfy7G9JYYc3c8IaCE5bCzIG31Hxh3n1pfFpz0cE3FmU8giKRrOn0ifM103O02/nCbzOa9GOSPVgWSJwSWf47bY/GS9e8j/wm/d+UaNFWFSEiusxabqvjYsnAbgpRxBUF4VuVSKWVXhHiQW+b1l/INc+e/t/DOxCAEj+Lsl+Ug4YdfntX/FR2o24YKGQeGdO1m4CV8+RdVSRhoauNkWRkU5uGgrc/iHs0KbR7C/kYveJ7Md0vwF6XbNzUUpaPv6jP+hHjSJZ/FfsveKvR6eApVpbzUQYLNjXO1BlZIGf6TN9e6sXG5CnLuuMtUQ+BbQOb97GM10lKi+lyVgAYLk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3123ed-c6a2-43db-6edc-08de83b6ad3f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 23:49:34.8475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCi+1NJIl4w8ttRk35aV5R3kTGCCVtjbiijBPOga1kbRCEmEaRtSMdhBsp4G0mAcktgEV36hK5nUc38M1xWzNidd9kyvNKqo4P6WQIUbpGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2603050001
 definitions=main-2603160197
X-Authority-Analysis: v=2.4 cv=LKFrgZW9 c=1 sm=1 tr=0 ts=69b89712 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=4EuQdLICr3JgQ-1d--wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE5NyBTYWx0ZWRfX+VlcUnFf01EH
 XUvLOjgw8yYRrvW99vHdWL0JnQcOWtlO7qnRG8zmBxzCnGBys85usORVRDnlsj4TNeBH9UyF+fQ
 Im5CvBp6mzpMo91WUSEsJvNsmM6xrXDkhx2AhjUXjHZz4TsOJsjUtImxxEeX6vP1mHIrVbXkj11
 q8UIPKAW98H4Ac3SbPLucg7s/LmzgxROcVPGiEzeZlsWsTl1inEj5doIBJU93jXGW5Ka8J3S08M
 yVIsBd/x561gRPgJ5M6IlPDX/VATgFBL4xNsf6zpdaaWRbJTaf6/qkScCmhCCzwMGprH4Hikq1R
 cl+rC08pBh7a1XTeWMLDTPDQECMotuViq1S7Ja/+5OfXhkvQjxgoKZP92KU0H8tfl0UGRcxLnYS
 8xmeXAN0PsKvwEdK/JtwtPhF0LS8wlK3XG3S9p8wtpJZHCypmKUF5JCY0COhtWiVZeJpPMoaneu
 oxUglySfVea2akwk61Q==
X-Proofpoint-GUID: ojHuRH21ulDoBDjAv6jK0Dwl8NkeHlti
X-Proofpoint-ORIG-GUID: ojHuRH21ulDoBDjAv6jK0Dwl8NkeHlti



On 3/16/26 2:42 PM, Joseph Salisbury wrote:
> The file contains a spelling error in a source comment (succes).
>
> Typos in comments reduce readability and make text searches less reliable
> for developers and maintainers.
>
> Replace 'succes' with 'success' in the affected comment. This is a
> comment-only cleanup and does not change behavior.
>
> Fixes: 955405d1174e ("unicode: introduce UTF-8 character database")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
> ---
>   fs/unicode/mkutf8data.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
> index 401f5d3aeb0c..1c0069661a83 100644
> --- a/fs/unicode/mkutf8data.c
> +++ b/fs/unicode/mkutf8data.c
> @@ -3030,7 +3030,7 @@ int utf8cursor(struct utf8cursor *u8c, struct tree *tree, const char *s)
>   /*
>    * Get one byte from the normalized form of the string described by u8c.
>    *
> - * Returns the byte cast to an unsigned char on succes, and -1 on failure.
> + * Returns the byte cast to an unsigned char on success, and -1 on failure.
>    *
>    * The cursor keeps track of the location in the string in u8c->s.
>    * When a character is decomposed, the current location is stored in
I inadvertently added Fixes: and Cc: stable tags.  If possible, please 
remove them as they are not appropriate for fixes to misspellings in 
code comments.  If it's not possible to remove them, I can send a v2.
