Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF9E34750F
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826679; cv=fail; b=CmzR/wiQ+yEoWVqBm7fGLoAx81HAOAdDBOQp8PxBQTqCni9ZOpAAOFC/6hMUMc6Bd9jFVoNOyCIHExEk9PpJAD7fN5zljlNqv4sOuniyiAplB8NZSBsDDl1N1BX/rfsnXTw2tTo2oILMQFOmiyynQs1QL6lghgkHYIjeTQFfRno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826679; c=relaxed/simple;
	bh=mR1Hij45m0WytHldXHxdowZ2DMygvo4sIsX+SCwf+TA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=GCp5n+966Yu7ki8DGtMwKsNp3wFGtPejOZemdhWfNQMCJWI3Z8IcMVA57BMqiE3hSHeLCywVdnf6a2SqcTjuHWoVV5DpLuxZNw291VDyfP/u25cqLx34ksHHe3G5QtD9KTowrfmu96n1rQ57KMunmAoZa7xiFcFUanhBdxhSXHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h40TMRXB; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0VXl+l+U reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h40TMRXB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0VXl+l+U"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673KXqq72754130;
	Tue, 4 Aug 2026 06:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Vr6V1s+TkcoNSD0i7+XLulQlVoWXjE25lQnhnq5P4FQ=; b=
	h40TMRXBJRtmQZ3wscYxluG8+36ncgcv+7pbweACCy27Crl+CpB4lkz37FsR8L0F
	WKU4dUX2PgqgISPovW9nl6goFfuBnpvnnowZ+SEDI358aMHyFq5S+9Yi2IduZ0bp
	We1fMHMWJ/KJdRnj5LmeBpQAX/YMEex7F6YX4S83wsQkbH61YXJhQ4KbgYKHTQ+k
	Vi88XZR9g54nM8AfsxEb6ClyZjmr/NGkkI//nVB/zY+Lda0m1MKq03hOYut2nTdl
	A60edxNP2JodNw0LvY3CWyOqIolypquH1FyQ3siWXpJdj4iMb0+Z2FaWC3fg8h9o
	eTL9ZWTeLc5El82bC2XKIw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs7cy5dmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Aug 2026 06:57:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6746pDof039864;
	Tue, 4 Aug 2026 06:57:10 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011010.outbound.protection.outlook.com [40.93.194.10])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78tdrwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 04 Aug 2026 06:57:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laE3e9POgiRQn42C2GgvQD8gT4Tb+V4n8zRO9HAkj4PROcNg6zzKNgXbWdMcNwg34ryBLWXnq3PAxYJUqfJp3CwG/PA9nY0l6/4hKSr7mWYadX3Ghi6aPs4DozoyAAhOy83x6ASkKTszTlMFvaIZsfNCya3nbRtb0ghGOnQiAFlBG9NSGbjq/MovRqn2rhh0HXLZ17CUzxgDlwnZxVznvOM4u9rft6zY+T+Or+mUYTp+6NGuZnbKHT0hzKkE4/fx/gvGhW4/AcSsdk33pnfh/5DatrS055JpvAnDimGfcNZgKt61QK8kTP2lZyvfrvqZVmP5J6waaIlD2icVBWVq+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gv5Wbf00Cee+MtHZz8LET+PXYjWcLmxfGddh/6QD54Q=;
 b=PuuTGaoR7WUs8y1Rui5LNrrHBGLmKSn38BtzCujr5ZBdUcIoH9jo+aPKoogfQV9RoLHAYRTxRVP/GMFboYo5xj714hO0phHu6z5Lsm2AJCE/LKUuWedkXKikqOCRYYjXKNUShLpch4F2IVx0/31jR6XD4cU0ZUxG5eISoAIrdIqAAzgfhDfq5yIJfl3F4cNyhtZH5B0OWaQbrYmcAIFZInLHIFyg02k7yb/+LtoRQwBzvE/+OJV4cco7V2UQvUdou9ZNyaiU53QTRW2vapqHiCpXJvUSSivBZG1vESp48Xf3dgSqexBPnW30RVZKS1g2OTMJCR8a2QI6BI3Q12WVMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gv5Wbf00Cee+MtHZz8LET+PXYjWcLmxfGddh/6QD54Q=;
 b=0VXl+l+UYMaaq9Rd8cBU4yS8PTQ3B00kS0jZOBcbYKbz5G4uBdq68VvUv3QolLbBlZSP4p8IA++HacltLraJo7bjPRIuQdPg41gDp8UfTEqudho6gnQLzIp9fQBhGJAFb/2vo9kY1qCB9vTPWKhDtJqyhGcOh8LC+eUMcvLRjus=
Received: from IA0PR10MB7369.namprd10.prod.outlook.com (2603:10b6:208:40e::14)
 by DM3PPF1652C44C3.namprd10.prod.outlook.com (2603:10b6:f:fc00::c0b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 06:57:07 +0000
Received: from IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e]) by IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 06:57:07 +0000
Message-ID: <e22baa98-0856-4025-8500-1c7d90cf460e@oracle.com>
Date: Mon, 3 Aug 2026 23:56:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 09/15] mm: Remove locking mf_mutex in
 is_raw_hwpoison_page_in_hugepage()
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Jiaqi Yan <jiaqiyan@google.com>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-10-willy@infradead.org>
From: jane.chu@oracle.com
In-Reply-To: <20260731200802.574821-10-willy@infradead.org>
X-ClientProxiedBy: PH8PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::23) To IA0PR10MB7369.namprd10.prod.outlook.com
 (2603:10b6:208:40e::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7369:EE_|DM3PPF1652C44C3:EE_
X-MS-Office365-Filtering-Correlation-Id: 1277b7c5-42f8-492a-8f2d-08def1f5990d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|4143699003|56012099006|4133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	634xKPuQ53HajUHkJfVpPeYCeAQfpktNbznBnBEv/jLWNSEj0wOxLqCprpcemqFyabG9J2pGr1hfnYJ9P7teUwvRHLncMdMswJ1spkw1XAGHp3hDq/cNPpoYGtojYZoGV0qXhAbx9ngRcaDmBOBBzn2Kr2GfQ0AytEscjUVrUA6ISb7DPfOPaGrZpSLvH1v5fJV1KvITglhI3s019V68a5Pkl/0SJdoLV0Gpl/SJA/5QFLrHOWIk9GAW3Iua6W+vroTl2HznZ482tekq7Q5DEXz5nW+bgdURYLKO0BP3/8RQtRL713/05GFIAERd8lQqujQ1y/1Lv1joKVLeYC1ajM9+YuCOURPqcyGlm32kPV0DtRCbevGZIW36uCsfI4suZhjQ8lB14IFYRz98ztwsnU2c7lXXTSoXtJStJcUZrVHWFEELzkM3pf87bOF0RfSkj53UIZ9RtB6jRA/1umRx4mYS5BYfcaq7Ih0Dr/olN4KpVNZtRy4ke2wkaUJS9Q9BLCNHoCXWeQj7ADFlafIOpe749CR7c72+kjduZwrzE6A9Cg/8tim1tAFlGgGVVlFMg5Lxkmk9nlGJDaXKqhIYV+gQaercpcii5A/DuuHozeOBRgYmuPjIMwJd7V6O6TGpRNQstOhRtExD6W0JehmmKPd/TzuSGDJrrYJ4lxlD7RA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7369.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(4133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWhRVjU2WFMreHdrMkJ5TU9OVmRBR3dObm85OURSOWRuN29nRUd3K3dzOVpO?=
 =?utf-8?B?bmUxY3IwazNJOVJXVFc5TFg4M1BiVzVKOVlzZFJMdEN3NmlwckZ0TWl2eW5B?=
 =?utf-8?B?b2RXU1JkeDRBbThmT2V1ell1dW1hM2dGTkdzKzFUSmV4YVJCQnNCWTdrTnJR?=
 =?utf-8?B?a1JKdEs4RHRjRFFlZ1dyUzlva2x1MlYwOVVXM3UyV25rRTBOSGp0RlA5aWk0?=
 =?utf-8?B?ZEVOVzlMZWUzeHA3bnFpOC9yYnRvQTJVRWFjN0ZLd1ZxWnJDRnZXNUJGTVVH?=
 =?utf-8?B?a1dicnNEZkU5WllSbnM5MXMyQThGNE9Fay8rRjB6b24xL1piQkNBc3ZNSEdj?=
 =?utf-8?B?L1REb0FWbC9hZzB0R3JzWXFTbkVUWnhrRUplRE9hZmNaeWRXRzV4Mkw2Mkds?=
 =?utf-8?B?MTFuWS91S0Q1MTdKNE53eUg5Q0NkV2g2MkluL3dMcEtjUlBENnVJSFFrVzFL?=
 =?utf-8?B?ZVdlN1JaZmxQV05DYjVvZTRtRTVnd09nSEJ4RnRxSitQRktsNDFrSXNmeURN?=
 =?utf-8?B?YXpHbWFGOTZoMTBhcEpsWThHZWI1MUV2MTJTZzJNYU5EOU90V0UrYjdvN2h2?=
 =?utf-8?B?N1dRTXoyNVRqSlBPenI1NGpta2RIMThURGNWQTI5VnF2Nlp5TzlNWjdBSk9V?=
 =?utf-8?B?ZUc1QWVjNXdJaFBjZm1xS1Z6TU8rQWhSSWRYeVZrOXFVQ2w5VFNYVXpmTEQz?=
 =?utf-8?B?SnVCck44YmYwT0FtWjhhNUpKOXhqTmh2UDkvSk8raGtFREw2R0RJdnlxa0I3?=
 =?utf-8?B?cGI3VE1hSUlDU2k3Q216dDlUdXorbDN3d0cwTWI0M0VTN09JNTdEemdGZVRJ?=
 =?utf-8?B?VFdqVWd1b2xtamVzRjhIWU5DaGcydTFVZzg2UlhYa2s2WkdmQmtGTGs2Y0lm?=
 =?utf-8?B?d3BWQ24yUU96T2RQcUcraW81SmIxUDBkbzlBQ2l3RHg0OXl3aHFIQnhDeHFt?=
 =?utf-8?B?NmpmaTlaVmc3MURBbHF0VjhPTU9nVTZobTdmdGV4Y1ZOWlBUWFUyZDllSEZ6?=
 =?utf-8?B?bU5URVNnRFE2MVBHNk5ESEhZZHFiVkdDTEpJRXFma1h6ZVBHS3Y5UitJMi9X?=
 =?utf-8?B?T2JISk9aenVsVFVCOTdnNEVsc1JMTFZDamg0N1FIcm8xbGRndCt3TEpoSVNK?=
 =?utf-8?B?Ym91MDlYSnAvTnhQNlJBK28veU9yME9hUDdHRkxHWkxUTTAydFpGWFdaOUJ6?=
 =?utf-8?B?b2JXMWN0NHV1ZVArQUV0L2dEbFJSbjZIRnd3UWtJb3dvOXJQcWZqVVM2aW10?=
 =?utf-8?B?YlFjNU56c0lWcmJ3UTZSYkUvQkZteWJoUXhYK0hVRXhtbEp3bUI2VWxxb1pM?=
 =?utf-8?B?ZE1OcnBFWEZyYVV0bnhLaEdkVkZQcVNRTW9QUy81NVpmRUlaK3IyUUtNQ2hV?=
 =?utf-8?B?bDJyWis2VTRTYXNzb3lMSktkNkhCZWJyNURmc2g0bTRoYWtldFBtTjArRlFx?=
 =?utf-8?B?NXdRK3NZNXVac0tsMVlWS2JMT3kxRTJZRndQUDZEczdTbzVvOVIxNGpFc05w?=
 =?utf-8?B?WVltTVNrWFVxZjBFWG81clNCaXlJMHRaRUpWZ2k5bS9SSnd5YzV4Zm5oSWFI?=
 =?utf-8?B?Z2hjZnl6OW9wRE8vMTF5VWNYd2xuYW5BTzBtbHJ6YkptZHM2RHhRVDltTWkz?=
 =?utf-8?B?ZThDdnBqUHlWM3NRYmFhTk5uUXBNdHBPTktjcTNUTWhuQXJJZFJlN1hocVhH?=
 =?utf-8?B?VDFZcDZjQXlFbVJUVld2b2R4UVJzejlRS0pOUDhwK2Jkclc3a0R6Y1VEc1BT?=
 =?utf-8?B?d1IzNS8rVjNnSWtiZE1QM3QybjZDSm5CZlEyN25QOUxmQnZ5M3NZZFYwa0xC?=
 =?utf-8?B?U0ZnTWxKYW5jVCtDRWxJaUlpaXlDL01meEZQZklFVzhuVFViZzN1U21HQ3FZ?=
 =?utf-8?B?SkljMmFSTWpYSzIxK3JOQzdaa1d1S3JCWXRKUVV0blFKbmsvbzBhRTMwK1ho?=
 =?utf-8?B?NUFNSUExU2dYNm5RQWhFTzUvLyt2bWlUcFpLb3Jhb3lVODc1S1Fyd3QzeGo4?=
 =?utf-8?B?Y2U0a2pDdUlOOUtuSmV3cm04bDNaVC9sQ24xV2lrU3VGaWY5cjRnS0VDVDdv?=
 =?utf-8?B?WFpsSnozYktPMHlrRXN4VERkRXAzeWhrMlkwaUtWeDNBR2MwV3NZSzVsdjlD?=
 =?utf-8?B?cWd6cTVOdVJWWWl6QVhOZjJHRm9mQytjUW9aenBWMHZlU2xHQVpJTjlKRzBF?=
 =?utf-8?B?L0s1UXUxbFZwWkxNOUI5ajFIOTE4MlUyZ00rTnA5eHcyNmFxR2xjcTh6WVpP?=
 =?utf-8?B?VkhiYTd4dDRtbWVzN2JnL1RQME5hb284T3JOWk5KL1BHRThxVmdjNTUxNENq?=
 =?utf-8?B?eUhnODdaOU1ObWxoZ29PTzdRWkEvTGptcHYwcTJvcnFhZEZ3YStiZz09?=
X-Exchange-RoutingPolicyChecked:
	aOg+xY9m7EKDLtA5UwON5Da2LzUd1R5Qlntw9OHAk35aUSZ0+qymT0X6i4Ut9/N9QKV9t7u6GP4vZ2kAQDCJh+tRbL5128/Qtug8uq2RI+ndRhjUe66pvPC4JmrATp4PAEECdKLj84zfToGFiF6ovBB3cYimqSzqh4wtLY6pCKx6NOdW3fS1M5Z1sB5DAeVqPu2zw2+6ov+QtkTxcWgwWVlShY7eG2yb8TOw7AVdjlWG35ON2pG9A9ShvHv7Xsc/+Illkd2V9uHuqzk9CXOmYph3Icet6CpVB6aYdCLtS7+JWG1D30TlOGDbN2sVte/IUwWKYNVGtHsFgSDVi1Oe3g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TkaHQ82Py48MYAuU/BUniw114ugTINILoxoDZuSCOevQXq8NB8uAE++aLitHoAhjlFMbboKpyJxUidXODrgVYCvrcyx9RhUFtcdH+jUfmusPtyPgRsqSdBtm0l/iWHINdg+7NQTWzuMfOZWzVYrxj6wTTCpaKfJNje7SWgGuWrX5NTuOqVe7eRb/hTSrkNYQgjmZej2QAwF6/nLT3eDeDUI0Licxtfo/o50tMLp+Px5cIdhxBaf3Y9LIL1GMCoS/ft80ZHqbd0hll12QFaCB/UYRbo7UScy+NQCOnjcA6QXlUQTWiDwc0bi2xBKNsXXwyIYw08DDshy+OF/OxNClgJGr6/MrGCXM6f5JZ8nHk/nLha5Z60+TnkIuCMWnCbzs0THb/o2CXNZnU6l3BzBIVbJcQxbdeT7zMTZ9jb14BrK9y+szWpQXsogFfP5r0wxuJteuKZQ7aq8pGC8WFN3fnMrdp/UwrOsVhspnyjfU0HLZp2YBB0zuzgFQwYNPfW62xwbZGqHam3N37gOVTRzWaBBB8Xj+vrDZ7qczabOjReWODGJp0kDWv5YINzi9RRpGw+sA2fKakU7hS4oOVXu+goufIfBkDaoNCben85TEy4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1277b7c5-42f8-492a-8f2d-08def1f5990d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7369.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 06:57:07.1801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQy5WINkNGx4SAppAo8ZEnAtGEj193FgbNTZUwg47vuK4CppfgQ8ZkyiRSGqk0haVx47gqcMyD7XR7TART0Tnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1652C44C3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608040053
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1MyBTYWx0ZWRfX87cn2AuGrnlp
 KymaGscMjBC4SerIf3rzEPQXUHKcV6CzzbFFl986/W/3geZsXvmfcPZC9Le8Mes6kR/RRKh3sVJ
 pxmNOMGiBo/DSUaGL3I44H3n08OTyUTSgSIjTbaJaYwWmId/lJsR
X-Proofpoint-ORIG-GUID: C8TPrugqSFmKjRyHmG-c68DcwHdF1LMH
X-Proofpoint-GUID: C8TPrugqSFmKjRyHmG-c68DcwHdF1LMH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1MyBTYWx0ZWRfXwupWdVEWRhNA
 ABYRBG1zMB3DdiQb4gvMK8UYDooLrfqh8Vy9Q7aMyjmOtB4/Cd1g1jMEsbKVBgweDEpwAcKZtOA
 0PfWgeZypN7u+8tjWce9xMWO84Osbi07+rKwW+DEvXTUVJ2z5PBkfqCmKRdQFkTBBcy1egmwfqj
 G+xa4y+fZrSM+IsZ+jiu2mNOmu7wKmwjJHW1pe16NrW7RFZnAM+FG5iv1XKwesch7gyxdHESWhj
 3zRPm6gJhaIerPyhHrPg0nztgvpLtdck8DItOdmtZsidRIJtoJLOgWEXSmqyb/8h/Hu677qPZ2h
 LN/r5Y/dvXrpznVdy4w3NxCxoliSofC4SdpomJ+xUDFTCsCoFJVBn3fBiNmZrVeK6PeHFq5RVoW
 YYVETJDS/IpF4Wgr+orcTbivB0zYa6ZEyld6F/s9TaeFfFpOsUq7a4ABSsa8Hsye6DRSNkpsBy+
 VwuIdJiXm/dFSfyV44p3zSvr2zKGowRBYaLbXYD0=
X-Authority-Analysis: v=2.4 cv=TsPWQjXh c=1 sm=1 tr=0 ts=6a718d47 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=RpNjiQI2AAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=9S-2c10q2wA38bYD7b8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12100



On 7/31/2026 1:07 PM, Matthew Wilcox (Oracle) wrote:
> Sleeping in this kind of predicate is unexpected. Add a new spinlock to=20
> protect access to the list, and turn it into a normal singly linked list=
=20
> now that it doesn't need to be a lockless list. Rename=20
> is_raw_hwpoison_page_in_hugepage() to hugetlb_page_hwpoison()
>=20
>=20
> Sleeping in this kind of predicate is unexpected.  Add a new spinlock
> to protect access to the list, and turn it into a normal singly linked
> list now that it doesn't need to be a lockless list.
>=20
> Rename is_raw_hwpoison_page_in_hugepage() to hugetlb_page_hwpoison()
> and make it take the folio (since the callers naturally have the folio).
> Also remove the handling of non-hugetlb folios and make the arguments
> const.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/hugetlbfs/inode.c     |   4 +-
>   include/linux/hugetlb.h  |   5 +-
>   include/linux/mm_types.h |   4 +-
>   mm/memory-failure.c      | 101 ++++++++++++++++++++++-----------------
>   4 files changed, 61 insertions(+), 53 deletions(-)
>=20
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index fbac554886c3..dbca3f713bbf 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -198,7 +198,7 @@ static size_t adjust_range_hwpoison(struct folio *fol=
io, size_t offset,
>   	struct page *page =3D folio_page(folio, offset / PAGE_SIZE);
>   	size_t safe_bytes;
>  =20
> -	if (is_raw_hwpoison_page_in_hugepage(page))
> +	if (hugetlb_page_hwpoison(folio, page))
>   		return 0;
>   	/* Safe to read the remaining bytes in this page. */
>   	safe_bytes =3D PAGE_SIZE - (offset % PAGE_SIZE);
> @@ -206,7 +206,7 @@ static size_t adjust_range_hwpoison(struct folio *fol=
io, size_t offset,
>  =20
>   	/* Check each remaining page as long as we are not done yet. */
>   	for (; safe_bytes < bytes; safe_bytes +=3D PAGE_SIZE, page++)
> -		if (is_raw_hwpoison_page_in_hugepage(page))
> +		if (hugetlb_page_hwpoison(folio, page))
>   			break;
>  =20
>   	return min(safe_bytes, bytes);
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index e200c93088bc..ec604cee8d22 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1088,10 +1088,7 @@ void hugetlb_register_node(struct node *node);
>   void hugetlb_unregister_node(struct node *node);
>   #endif
>  =20
> -/*
> - * Check if a given raw @page in a hugepage is HWPOISON.
> - */
> -bool is_raw_hwpoison_page_in_hugepage(struct page *page);
> +bool hugetlb_page_hwpoison(const struct folio *folio, const struct page =
*page);
>  =20
>   static inline unsigned long huge_page_mask_align(struct file *file)
>   {
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index b18c2b2e7d2c..86a2d0fee557 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -387,7 +387,7 @@ typedef unsigned short mm_id_t;
>    * @_hugetlb_subpool: Do not use directly, use accessor in hugetlb.h.
>    * @_hugetlb_cgroup: Do not use directly, use accessor in hugetlb_cgrou=
p.h.
>    * @_hugetlb_cgroup_rsvd: Do not use directly, use accessor in hugetlb_=
cgroup.h.
> - * @_hugetlb_hwpoison: Do not use directly, call raw_hwp_list_head().
> + * @hugetlb_hwpoison: List of pages with hwpoison.
>    * @_deferred_list: Folios to be split under memory pressure.
>    * @_unused_slab_obj_exts: Placeholder to match obj_exts in struct slab.
>    *
> @@ -499,7 +499,7 @@ struct folio {
>   			void *_hugetlb_subpool;
>   			void *_hugetlb_cgroup;
>   			void *_hugetlb_cgroup_rsvd;
> -			void *_hugetlb_hwpoison;
> +			struct hwp_page *hugetlb_hwpoison;
>   	/* private: the union with struct page is transitional */
>   		};
>   		struct page __page_3;
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 714e1b398f2c..437a2be6c58c 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1808,63 +1808,60 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
>  =20
>   #ifdef CONFIG_HUGETLB_PAGE
>  =20
> +/* Protects all lists of hwp_pages */
> +static DEFINE_SPINLOCK(hwp_page_lock);
> +
>   /*
> - * Struct raw_hwp_page represents information about "raw error page",
> - * constructing singly linked list from ->_hugetlb_hwpoison field of fol=
io.
> + * hwp_page represents information about "error page",
> + * constructing singly linked list from folio->hugetlb_hwpoison field.
>    */
> -struct raw_hwp_page {
> -	struct llist_node node;
> +struct hwp_page {
> +	struct hwp_page *next;
>   	struct page *page;
>   };
>  =20
> -static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
> -{
> -	return (struct llist_head *)&folio->_hugetlb_hwpoison;
> -}
> -
> -bool is_raw_hwpoison_page_in_hugepage(struct page *page)
> +/*
> + * Check if a given @page in a hugetlb folio is HWPOISON.
> + */
> +bool hugetlb_page_hwpoison(const struct folio *folio, const struct page =
*page)
>   {
> -	struct llist_head *raw_hwp_head;
> -	struct raw_hwp_page *p;
> -	struct folio *folio =3D page_folio(page);
> -	bool ret =3D false;
> +	const struct hwp_page *p;
> +	unsigned long flags;
>  =20
>   	if (!folio_test_has_hwpoisoned(folio))
>   		return false;
>  =20
> -	if (!folio_test_hugetlb(folio))
> -		return PageHWPoison(page);
> +	spin_lock_irqsave(&hwp_page_lock, flags);
>  =20
>   	/*
> -	 * When RawHwpUnreliable is set, kernel lost track of which subpages
> -	 * are HWPOISON. So return as if ALL subpages are HWPOISONed.
> +	 * When RawHwpUnreliable is set, kernel lost track of which pages
> +	 * are HWPOISON. So return as if ALL pages are HWPOISONed.
>   	 */
> -	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
> +	if (folio_test_hugetlb_raw_hwp_unreliable(folio)) {
> +		spin_unlock_irqrestore(&hwp_page_lock, flags);
>   		return true;
> +	}
>  =20
> -	mutex_lock(&mf_mutex);
> -
> -	raw_hwp_head =3D raw_hwp_list_head(folio);
> -	llist_for_each_entry(p, raw_hwp_head->first, node) {
> -		if (page =3D=3D p->page) {
> -			ret =3D true;
> +	for (p =3D folio->hugetlb_hwpoison; p; p =3D p->next) {
> +		if (page =3D=3D p->page)
>   			break;
> -		}
>   	}
> +	spin_unlock_irqrestore(&hwp_page_lock, flags);
>  =20
> -	mutex_unlock(&mf_mutex);
> -
> -	return ret;
> +	return p !=3D NULL;
>   }
>  =20
>   static unsigned long __folio_free_raw_hwp(struct folio *folio, bool mov=
e_flag)
>   {
> -	struct llist_node *head;
> -	struct raw_hwp_page *p, *next;
> +	struct hwp_page *p, *next;
>   	unsigned long count =3D 0;
>  =20
> -	head =3D llist_del_all(raw_hwp_list_head(folio));
> -	llist_for_each_entry_safe(p, next, head, node) {
> +	next =3D folio->hugetlb_hwpoison;
> +	folio->hugetlb_hwpoison =3D NULL;
> +
> +	while (next) {
> +		p =3D next;
> +		next =3D p->next;
>   		if (move_flag)
>   			SetPageHWPoison(p->page);
>   		else
> @@ -1905,9 +1902,8 @@ static inline int hugetlb_clear_poison(struct folio=
 *folio)
>    */
>   static int hugetlb_update_hwpoison(struct folio *folio, struct page *pa=
ge)
>   {
> -	struct llist_head *head;
> -	struct raw_hwp_page *raw_hwp;
> -	struct raw_hwp_page *p;
> +	struct hwp_page *p;
> +	unsigned long flags;
>   	int ret =3D hugetlb_set_poison(folio);
>  =20
>   	/*
> @@ -1917,16 +1913,23 @@ static int hugetlb_update_hwpoison(struct folio *=
folio, struct page *page)
>   	 */
>   	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
>   		return MF_HUGETLB_FOLIO_PRE_POISONED;
> -	head =3D raw_hwp_list_head(folio);
> -	llist_for_each_entry(p, head->first, node) {
> +
> +	spin_lock_irqsave(&hwp_page_lock, flags);
> +	for (p =3D folio->hugetlb_hwpoison; p; p =3D p->next) {
>   		if (p->page =3D=3D page)
> -			return MF_HUGETLB_PAGE_PRE_POISONED;
> +			break;
>   	}
>  =20
> -	raw_hwp =3D kmalloc_obj(struct raw_hwp_page, GFP_ATOMIC);
> -	if (raw_hwp) {
> -		raw_hwp->page =3D page;
> -		llist_add(&raw_hwp->node, head);
> +	if (p) {
> +		spin_unlock_irqrestore(&hwp_page_lock, flags);
> +		return MF_HUGETLB_PAGE_PRE_POISONED;
> +	}
> +
> +	p =3D kmalloc_obj(*p, GFP_ATOMIC);
> +	if (p) {
> +		p->page =3D page;
> +		p->next =3D folio->hugetlb_hwpoison;
> +		folio->hugetlb_hwpoison =3D p;
>   	} else {
>   		/*
>   		 * Failed to save raw error info.  We no longer trace all
> @@ -1935,16 +1938,20 @@ static int hugetlb_update_hwpoison(struct folio *=
folio, struct page *page)
>   		 */
>   		folio_set_hugetlb_raw_hwp_unreliable(folio);
>   		/*
> -		 * Once hugetlb_raw_hwp_unreliable is set, raw_hwp_page is not
> +		 * Once hugetlb_raw_hwp_unreliable is set, hwp_page is not
>   		 * used any more, so free it.
>   		 */
>   		__folio_free_raw_hwp(folio, false);
>   	}
> +	spin_unlock_irqrestore(&hwp_page_lock, flags);
>   	return ret;
>   }
>  =20
>   static unsigned long folio_free_raw_hwp(struct folio *folio, bool move_=
flag)
>   {
> +	unsigned long count;
> +	unsigned long flags;
> +
>   	/*
>   	 * hugetlb_vmemmap_optimized hugepages can't be freed because struct
>   	 * pages for tail pages are required but they don't exist.
> @@ -1959,7 +1966,11 @@ static unsigned long folio_free_raw_hwp(struct fol=
io *folio, bool move_flag)
>   	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
>   		return 0;
>  =20
> -	return __folio_free_raw_hwp(folio, move_flag);
> +	spin_lock_irqsave(&hwp_page_lock, flags);
> +	count =3D __folio_free_raw_hwp(folio, move_flag);
> +	spin_unlock_irqrestore(&hwp_page_lock, flags);
> +
> +	return count;
>   }
>  =20
>   void folio_clear_hugetlb_hwpoison(struct folio *folio)
> --=20
> 2.47.3
>=20

Reviewed-by: Jane Chu <jane.chu@oracle.com>

thanks,
-jane
