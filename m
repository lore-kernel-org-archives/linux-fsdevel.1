Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793947269;
	b=eP9+1mleZNHQQ7F2xJssUi6FjQVkQ2ooSSpk17LegvhRHIdp2wMWhyQlWORV2ttFohpl
	 dA6f1R6dJ17qi02YcdAPjfIzswI/CWAjjXyZUXF+9Q2fKfixQHXYRp0hutcqe/19wl1aT
	 KD2wWUkjtLl7SESPC0GUjFwfwXAc3wwyKVXsN8lO2ihNXCNm+DJxVQM/CpS33NZPsyxlN
	 hSa44H2FIEAmNnCeWxgYcG2wShFfJS8uNO/6LsxgQNBqIN9Kbbo1bGB3SHWXa+YJzKhZ6
	 AXTIWiComB+/BDZBBoWlw1cRZkksd1X8wedWjye6JzSIlh1M2E8dvlC9q3goi9wNBfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793947269;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:Organization:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc;
	bh=SWx7OJ6c4j0KHDZpK4Iq/Ry2gRXjQ3QHpk/4Hk3vbUE=;
	b=xFrffK1mpUxjAR1KqNJKHAQ+/B+lxfwNBo/ntVRH7UARIpJiw5mvH6txW0GkEoKXziKe
	 LFByoQkY2v/E60320RyGqCXxWMHw1nKphOwuZ7yyME4iADsrCDat/fviAu5LagmuxcYaV
	 Pghd800l1D52T/i1tk0WgIK2HdwieSRt6KpcqSMg8dWpzYQbau2h68Rke0nN0FzDcj++2
	 i7TT96lZyv7CCvJXg7cRfeft+LoXruqh7e6jXjsfOVXyE35X4aQmzdYZPCxqjAflo8h0m
	 9ItX5Jyi8cU//QRXTiosmur6nNeyFtRciHqZSYz4mfKZ1YQ2pflG2x15RZEKM60AUIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=fOwG4UKE;
	dkim=pass header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=NtolKfKO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9E606A328;
	Fri,  6 Nov 2026 06:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FF9E606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=fOwG4UKE;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=NtolKfKO
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5NhWV12153060;
	Fri, 6 Nov 2026 06:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SWx7OJ6c4j0KHDZpK4Iq/Ry2gRXjQ3QHpk/4Hk3vbUE=; b=
	fOwG4UKEr++H+rM5iqSMLa/xQTfnxTm79RvLQFAcmqBfQAEf5nIgmLk3RArMhg6J
	f2Xv2CGJ/+ZzG2wrzpRpzuCraKZ4OC8JjhEefOqq7CTuwIPXicafulUX+SsqRN+d
	oitnwqCt26l5E7+e+vp4VsEk058iaVg/pkjaLLM02fjPfry9BwN0E24W+IkhwiyT
	Y5O74796jqcEMe1utEfnJF2Gh7rywwL+dSv2jBHWjW7JdQaT+BpU4yzPUARg46P7
	etzl/18SF0AjQhXo3L5IK3U4t6IVEkb5VXCoqldh5aMumRwnhSquzST3yUG430L7
	qmT3pLxx7ZMx3b9LziFfqQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hs3qk8a2r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 06 Nov 2026 06:41:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A64uQHt3896873;
	Fri, 6 Nov 2026 06:40:59 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011023.outbound.protection.outlook.com [40.93.194.23])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4hs8ad31r5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=FAIL);
	Fri, 06 Nov 2026 06:40:59 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNIwZZnMw8udArKUUP+MA9SuaVLdB0LLYrP5y9NZvUdZLBfBDlv77y8A8oGfTiQFw5yKKL14CBHXTgsk9w1PLTw9T2Blf/3M7ZFxvWCAK7tda4tk6aegGPZ2B5r+UGQG7mn/ojou8QO9bIbe7PR6ENctq/Os8lXPG4v2X4aNb5y+pmZPHMzePq/eZhMrZvQaLVQgRSMr6LILGHQNvQjMjaoe1pGAGfGuvJjdaKr+C3XPtf8PaZXLnUXUXEUIoNmz05M4y5jAT59tnqCRn6BXrLCENnOTjQb7FJKZMYdIlvX+F3w3KowcsT+X27KvvkbJ0p4hivjABistv5FyCG6dag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWx7OJ6c4j0KHDZpK4Iq/Ry2gRXjQ3QHpk/4Hk3vbUE=;
 b=ivk+HdjODcATwXe746sNJ4QoIYIrd6UDUTsO/flhyPsmJA2fCbcf5RKvH5p3YkOKjc1nd6VTzvDiUjPhYH4wo9ke4vVGTJ8rDhO0DW7lQn6F1TeE23BPhQWONltF1+YNe5ApgVkUDM08xiIhNkE31cYVNO8cX4dt2PSFcWs6nHgw3MFLHmVxsLhZAcGicaWTNtk0ee9MJtOf5SPhWM5sZjZSExkueeP6ia+BFof+b+wFFowlZnGIxVuhvd6GDUT0WP0UVidhMQJKp+OIey7WGAX3jsCndg3VgBldzk8JrAavbllMbBPD7Bsgh6C0iLLkqOdJNx10qW+sXqhpxPpEhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWx7OJ6c4j0KHDZpK4Iq/Ry2gRXjQ3QHpk/4Hk3vbUE=;
 b=NtolKfKOqvlHNMmqWAKIhwGRDft5zK8W/1KgQ135sGT1DGsG7OcOIhRvYSUBGBlCOoIYLYGqiQQLLXJ68h4WtLbMeFxdmB+dtpsakqPhXy+Z4GtXTPNUQU0EhvgHgRGOGNY8VRDKxlwjACW2klnTgxKYma6uM74jdr/IP9t1JHU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DS7PR10MB4990.namprd10.prod.outlook.com (2603:10b6:5:3a5::8) by
 EAYPR10MB997950.namprd10.prod.outlook.com (2603:10b6:303:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 06:40:56 +0000
Received: from DS7PR10MB4990.namprd10.prod.outlook.com
 ([fe80::48cd:32fd:985e:239e]) by DS7PR10MB4990.namprd10.prod.outlook.com
 ([fe80::48cd:32fd:985e:239e%5]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 06:40:56 +0000
Message-ID: <4ed59752-f01b-457b-81de-be1c446f18f6@oracle.com>
Date: Fri, 6 Nov 2026 12:10:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH 0/1] fsnotify: Check parent watches
 without child dentry flags
From: Partha Satapathy <partha.satapathy@oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: amir73il@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1791373689.git.partha.satapathy@oracle.com>
 <qlw6x3hyky5yoievlkd6ylz3ov432hdjlzkcyboswqktnk43il@fvccpqnil5sp>
 <9499fb1a-85f2-41da-88b7-5e7de6fdff0a@oracle.com>
 <gnntcprg4f7ag7ictugnfza24nwfdmyubkuqac7plxbwtedfrz@xgxyvks3h2uv>
 <2528e790-8913-45dc-a8d5-cc22908a441e@oracle.com>
 <f9164f65-1a99-425d-b216-326de0eaee69@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <f9164f65-1a99-425d-b216-326de0eaee69@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0683.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::13) To DS7PR10MB4990.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::8)
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
X-MS-TrafficTypeDiagnostic: DS7PR10MB4990:EE_|EAYPR10MB997950:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f050c9f-8793-4f5f-e882-08df3bd0e949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|260925022911599003|260925021911599003|260925021311599003|4143699003|56012099006|261022115727099003|261022105027099003|261021135927099003|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Wm1Z8rcojaL6z2YsWz4F7E+bQ8MsiPFWhC53ZDD041QN3VlGgl8EOCim3hxVsoyKQgk6LLDRLj8FGL8N+tFIWVsZxkjGttHcBytLFRzntqXiji/m5nM2tS8RMDxwB9LV0VwJrW/0Y52aH612VDu3xtku7YtU+oy+V9nmvkTayflTFRLfyzmpv7nwhB+zNVoxARTvL2LfVHWpVuB5Gw1b7qECd3bTTmKLiR/nrXCIAwejmCqGTQDuJBntpJeHEkd7KE1kGr5RAEywTG6bPCMmDgw1tjA+ZNKv5SGKUSN8nTeoyy5UjnOu2ivUxtDpQ9iYgjN7pbf7P0QSvKQqZ2yES3kxjOc4AZrQZ1qiYL2PhXKqtGYLc7DB0PiDmG6KDZpbP94V81fZFeQ3+F3xsXdQZBt7Ap7Kxla91FPOQ33nRRM7UcKxSn9ENV0pCM8k5GbDE/8qqPCKCsSISE75cGmfyVTYzSD/vYYAUnxMpVZ3YJLLKpjjiYrkJRtVSo1xfpNmRxe03EP7s2D0Fkfwh0kUteT7YLSwiY/0AZN5r29CLgixAfLTL6A6n4Pgw6Bq4Je6oleZU+JtO3266GhrNfzZeSZZhKVMzuZBgPfpRys5yotWiEPs9OMcnA9pSrB36Nis5YfFLwfmO/efkuEa2eJe6maNpxfqgYqrNPH/CyO84N0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4990.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(260925022911599003)(260925021911599003)(260925021311599003)(4143699003)(56012099006)(261022115727099003)(261022105027099003)(261021135927099003)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUlHTUZsQzBMMDk0WHFJbkQ1NHBXUWErRXViTVlqWjZSalFUOFpjU3FOVTZ5?=
 =?utf-8?B?djJYaTQzcWd6Q2xoWmxkZzhwN3ErYjd5cXIrTy9pZ0FyWHR5ekR5MEN5SGpx?=
 =?utf-8?B?K253czg1Ti9sN2xhNGVZdUdHUThvNWZiMjJ0QWVOWU1KN2U3Q3hzM29RbjIw?=
 =?utf-8?B?RlIzMmFockZHaERESzBKN2x3ZzloSWhlVHlsQzlNMVBCa3liekl6aTlEZ2VB?=
 =?utf-8?B?WHJhdytrdkhVWjQ3RHEyTWM5eDlZdHR4NTA0Ny8xekpGcitQSmVJYVdtT2xM?=
 =?utf-8?B?S1dDemFxb0FzcGpuamlKUWFLeXc1cThDNzFRay9hZ1JaLzdRVFdlbDRxWWpY?=
 =?utf-8?B?RzNHdkxnZS9NZUVtSldOeHBiKzdHMlpOZEt2dXYzRlJ3Z0llTzYySlg4ZFRv?=
 =?utf-8?B?UjJCTjJKQVBvQ1dQYkJzcFdkS25EcnRCNjdDVGdKZVBHUjhFYUtXWEVZM3g4?=
 =?utf-8?B?WVE1eWc2L1FCLzQ2L1BacWJGWXpHcFNaRTNlOUxiWGxncU1Id1dnVXQ5TEUz?=
 =?utf-8?B?RFBPZzZKQk5STkhOVWhVZDVoSWFEMjFNeCsrR0pwYmsrbGhRN0VOYkR6Q0Qz?=
 =?utf-8?B?M1ZaeHYrSEdhcG1vUGJmbDREejZrMDA5anBOQkFIUWVmaG1sUWtXdHdYc1FB?=
 =?utf-8?B?TjN1WHRwb0lOV2JraHcwSTVBNWNxWlNYZ1hVbEpIblA0R0JmandKQjJrbEVy?=
 =?utf-8?B?RWZxRGs0WndERkhlcWZNZ2JJeTBIUnZtMU56QXRrcFJmWmp3bkhRdmo4Qmkx?=
 =?utf-8?B?NVVtZXlCSFNaNWRLTDJNaEYzem9USEtxWWRuR2oyR256QWlseDJsend6L2Ja?=
 =?utf-8?B?YnhZeWdvUko5MWN3ZFRSaHRkMmFLTExJbFJCdXdNN3ovODZSWHlqdE1UZFY2?=
 =?utf-8?B?S3NHOVRpNTVDMHBraG1PaEw5K1lTdHFqamlQY2ZOeEFnNGhTUXZWZmdUTmVi?=
 =?utf-8?B?NXp6bHR4Tm9WU0RTOXByTWtqN2pPWmZ4TjdLMnV0ZmprVjZmL0JEYndZaEFx?=
 =?utf-8?B?SWN2VkpucHRoUlh3Q0YwWmNlM05nNlQ0c21jTFVtRmJKYWFSYitrSnhYUERI?=
 =?utf-8?B?ZlFxYnBGd0VRa3RIS0dxYzQ3S0dXY2Z2MEdlUGQySXBmZXlCU1JGVmpuQm8y?=
 =?utf-8?B?ZzhhY2tzamJZQ1krNkx2RmhFTWlzTjROU1h5T082eXRpTEYwS2VjR1daOGoy?=
 =?utf-8?B?TE5uQmlHT0crSjJEdFp1QytNZXFlZko5QlpBSVFUb3p4bHVkUlUyaE5hYmM4?=
 =?utf-8?B?MUdzMHB4MWplUzJkOWtZV1B6bzdoSkplTlUrN3laR0huMUwrK2ZlVUNxTVQ0?=
 =?utf-8?B?bnBycnpmMTZzRmVEOUpmaVRMc1Y2YmhkS3Vlb1NteGFwZjNTS2dRdzJJNTRW?=
 =?utf-8?B?SWF1c1dnS1lMaVNNZ0JLM252eDJMQ3o3TlkvSEZZbWZZUTJpQ1BBUWZ1c2xN?=
 =?utf-8?B?SXB2bEdpdUVJZFRnQ1c2MTczSVhUMU9pbFk3THRUL3lBVmZpdTZiMWJtL3pY?=
 =?utf-8?B?Rzh1bytmVUtEaGNPTmIvb1ZEWk9ObDM0MEVjVVRueUpYQzZVdnR4M2hnV3Ru?=
 =?utf-8?B?TWNyaHRKWmdadzdQaFJrQlpPaE1oTHFDSlc3RXJERkVkUHRsMERiUEdNVThp?=
 =?utf-8?B?ZTVVRnFqSDRsZ1ZITmNtRitqWTVsTnVUUEFtUDFqUk4wKzVlWGpSR3M3MGtX?=
 =?utf-8?B?WGFYZEpLRExYb3B3bnZBeG54UDlaanJPSmdWOXU1VDk1djR2eVpxU253K2Fk?=
 =?utf-8?B?M2pVK2FwcXlTVktQTlk5bGplOVZycjBGR29menJVeis2aEVYZ1Bpbk80eFhw?=
 =?utf-8?B?dEplMklzaE1SK08wVkJaQ3ptU1VOTC92U2RDNmJPVTdSejJSN1hnUGh3UTZI?=
 =?utf-8?B?bXJmM3ZibnlIN3N0MnpMVVMwRERuUDFHWGVyZzgxS0tkZWVaa3l5cGRJbjhB?=
 =?utf-8?B?L1RqOURDRElja2NtQ2QrT3BWbThSOGEzdGxjZm55MWVVZUQ4Z004eWVObWw2?=
 =?utf-8?B?eEZEQTRJK1ZRMVYvS2tmR3ZYcklZTGZOY0hDWWI4YldZOVcrM1V2TVpqczQz?=
 =?utf-8?B?Q1RUa2c2TmlpVnhjWTVXbmlRcjVFcXRDT0VxRE1TQUNNSndoMTAzK1N0eGZM?=
 =?utf-8?B?RHcvS252V1Y1amtLdG00YkM0dHFSTENPajliVFlleS9EdEk0YkV1NDNQeHV0?=
 =?utf-8?B?ek9oK01IaytLODcwUUVJS2tEdjhqaTMvMHhnWmorbUtNRGhBQzQ5QUtuME1V?=
 =?utf-8?B?N0J6V09IUHJnbEhxUS9uNEg3YjkrSmZmQUgvM0RablMyOVF3L1Z5aWRPcWZQ?=
 =?utf-8?B?NlVKdjNTVlYwRjZTVVlISzJtY3lRK3FIU1dmbkRHeDZMMjBEZjcyd0U3akt3?=
 =?utf-8?Q?qm3j8WxnBFDowJm8=3D?=
X-Exchange-RoutingPolicyChecked:
	cQ+UQ+WQgEJ0UKL/bPiusxKDDD0dB1EV9fgGehd3HMvm76Ht5aq68em67Ci7jxzRelr5rs3l9o4j6YTwaxJAwfDD2v3QAC/v/LECfSglMCMBFvFA4TUnI8PmJtkOJ/33j9KKfk9nwquF2EIGQzFl6Vtwh4yrJB3vaBkbXXonF3Pou2d9FpwBD87qLYGsZd5YyCkkMaateOHaXZe2VrS/4hQkMu2LnQZ63VKVus7aPxsVZls9HoBHoxrHEOdRmHy9ANXb2s+cXomuRu1e3sBG/ZoB6capK33C51hei4/lG+it2h9t4jSKITMiqBbVASocurg3xzuh2vGJdXkkZ5u/Lg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xmc+ZHDq0iT1XdOyic8bUeU/2EVAQpjRzFMDDls2SgWqs5y45SMT+t3ve4RKvDzJq4CLzPW5ZrdncVPYXkA/fiWRs0uzuSUm1jN1iaecw/wbKMik2xXXUd5vUNcFHh0g2+vrkfesLpUQYE7MxArZuSspE4uzRT+otdn6gNLaYafhZXXEE9FIdcjnppaR6NFRN+JoX/80fhgWptH0A90WFmPUVwwlEVimn//f2FH7zHN9Bxo7VW3bZvCZ7QHjazB1ujBFDmKfu+KYOMq+3q7Hz39TuruvtlHlHIY0NgYLMPxJRwQ9yIRabOA2f3zoH8JNuR9qUjMpD+nlnQmFbW152MJq/zL5let6yyESdKV7P9jAqQdvwZohcpfAY748aFYdHRhr8qJmKomx+KEf2hvZXkaHMtDCB4cdRO7I8NOOt/msFJ8RGVFCrYZ0jJ2oTgnyJ+0+os0FQ9g/erX8BAqkQb9yZEvvnCs9cRjPBhsMmR5ATbKTbLZjMBOqsRk3fXZISkPkAAeHW4Z+NAP1j5w+RwcEfkyDy94nQLesnLmcCoTZAVzZkZ/FkrH8H4rAXw32/K9QuaUv0ac/zwtDLeV8UA+b64lwyUSInWFOhrIDLbY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f050c9f-8793-4f5f-e882-08df3bd0e949
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4990.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 06:40:56.4578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fElyJCdU6Hp4/W4P76XN5Zoxb/kbtxo4FwnNTLZqxTRXgccdnSqxmpY3kVJWEdcyeYzE9ol43NmBr6o8BWJwHiehqq3IjmKSQl7HZ/2KKE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR10MB997950
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_01,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2611040001 definitions=main-2611060026
X-Proofpoint-ORIG-GUID: wdkNhM4hN3w86Il05THnIBKpFLwmWJY6
X-Proofpoint-GUID: wdkNhM4hN3w86Il05THnIBKpFLwmWJY6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAyNiBTYWx0ZWRfX34wVAbQXVHUX
 PE4aoAxdr7ZQMYA8p4aoSQH4mQb1iXI2tFReOGb6JMsD6LGFLDCubV9LhAAuUnVZI1zLzu8tQ4u
 5hhLG+gffU/h34KNyB04Lrv6lCa4ZyRdg28gy9aEa45s2jjjeQzG
X-Authority-Analysis: v=2.4 cv=Yqma1IYX c=1 sm=1 tr=0 ts=6aed767c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=iox4zFpeAAAA:8
 a=halVox5dOiCUx8GDnVIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=br55WurUj89AL1qEz8Q6:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13532
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAyNiBTYWx0ZWRfX1UTW5A8pEhvA
 A3WhZH6NgoXWo6t5Kvl+pFU82FvrfXrUE/3Wiq8qMZS4kfDEyrrNEZUf3VJWpQn0Cj0YgEjDXJ4
 Omx8hVxUwPCfB5sFWj0Uavql6kJKGkWFKUD1dcalskXrzZaCm7OrvU3i1khLmk33jmwUmL+EiTf
 vZ/l2t54FCLK0Req6xYeFavszMLwp0BqqoSq0bbxGTO+FsvtcqSBzwRnaUDTdabfdxU7HhlSTqP
 ctDLwPc+JryHGUON1zC3U5ccrWElefISItfHgK5zGou0BNHbltKrK6cpwD4JhcowWlJDOoDPSEq
 GJ/gRtX2MkiM+1i9Zjzs6FR700abP1UrkgVzmY5BPtfpvpH6djCgQDDgqICmtDK9rZfzoggdDI9
 jbVFqs6m6Xz4ZJpwiOLf8ux/UCQo3L+2pCPvuK/yf+JUwK949F3Dlm5W10zYoFDrR1xBAUeXqQa
 hi55uVxpdV6J24knF+mkymJ69kWlICmE4T+LJoiA=

On 22-10-2026 13:17, Partha Satapathy wrote:
> On 13-10-2026 12:08, Partha Satapathy wrote:
>> On 12-10-2026 14:10, Jan Kara wrote:
>>> On Fri 09-10-26 17:18:17, Partha Satapathy wrote:
>>>> Hi Honza,
>>>>
>>>> Thanks for suggesting this workload.
>>>> The setup and before/after timing comparisons are below.
>>>>
>>>> Architecture:                x86_64
>>>> CPU(s):                      512
>>>>   On-line CPU(s) list:       0-511
>>>>
>>>> NUMA:
>>>>   NUMA node(s):              2
>>>>   NUMA node0 CPU(s):         0-127,256-383
>>>>   NUMA node1 CPU(s):         128-255,384-511
>>>>
>>>> Testcase :
>>>> Using /dev/shm  tmpfs to create  private test directory.
>>>> Create 1,024 files each fully populated with 4kb.
>>>> Add IN_MODIFY inotify watch to the directory.
>>>> Start a listener thread to read notifications and count queue overflows.
>>>> Start X(1,2,4..1024) client threads; each opens a different file once.
>>>> Wait until every client is ready, then release them together.
>>>> Each client starts its timer and performs 1000000
>>>> one-byte pwrite() at offset0 on its own file.
>>>> Each client stops its timer and closes its file.
>>>> Wait for all clients to finish, drain remaining notifications,
>>>> and stop the listener.
>>>> Print write times, throughput, notification count, and queue-overflow count.
>>>> Close inotify and delete the test files and directory.
>>>>
>>>> Note : File creation, open, close, and cleanup are outside the timed
>>>> write loops.
>>>>
>>>> Run 1:
>>>> -------
>>>>
>>>> | Clients | Before average time | After average time | Time change |
>>>> |---:|---:|---:|---:|
>>>> | 1 | 1.392 s | 1.484 s | +6.6% |
>>>> | 2 | 2.205 s | 2.402 s | +8.9% |
>>>> | 4 | 3.969 s | 3.644 s | −8.2% |
>>>> | 8 | 5.851 s | 5.804 s | −0.8% |
>>>> | 16 | 10.607 s | 11.538 s | +8.8% |
>>>> | 32 | 21.093 s | 22.492 s | +6.6% |
>>>> | 64 | 48.698 s | 49.576 s | +1.8% |
>>>> | 128 | 100.208 s | 100.467 s | +0.3% |
>>>> | 256 | 198.773 s | 197.669 s | −0.6% |
>>>> | 512 | 400.056 s | 399.550 s | −0.1% |
>>>>
>>>>
>>>> Run2 :
>>>> --------
>>>>
>>>> | Clients | Before average time | After average time | Time change |
>>>> |---:|---:|---:|---:|
>>>> | 1 | 1.491 s | 1.484 s | −0.4% |
>>>> | 2 | 2.391 s | 2.402 s | +0.5% |
>>>> | 4 | 4.050 s | 3.644 s | −10.0% |
>>>> | 8 | 6.630 s | 5.804 s | −12.5% |
>>>> | 16 | 11.931 s | 11.538 s | −3.3% |
>>>> | 32 | 22.513 s | 22.492 s | −0.1% |
>>>> | 64 | 50.231 s | 49.576 s | −1.3% |
>>>> | 128 | 100.699 s | 100.467 s | −0.2% |
>>>> | 256 | 198.771 s | 197.669 s | −0.6% |
>>>> | 512 | 401.860 s | 399.550 s | −0.6% |
>>>> | 1,024 | 803.812 s | 806.593 s | +0.3% |
>>>>
>>>>
>>>> Positive means After Fix took longer; negative means faster.
>>>>
>>>>
>>>> The measured write performance is broadly comparable before and after
>>>> the fix, with no consistent substantial regression or progressively
>>>> worsening slowdown as concurrency increases.
>>>>
>>>> The differences vary between baseline batches: the increases at 16
>>>> and 32 clients in the first comparison disappear or reverse in the
>>>> second. At 128–1024 clients, average write times differ by approximately
>>>> 0.6% or less. These shifts are consistent with run-to-run variation;
>>>> the results do not show a persistent substantial slowdown from the fix.
>>>
>>> Thanks for running these tests. Results are very interesting. Can you
>>> please share your benchmarking program with me?  I'll check it and try to
>>> play with it on my end. Thanks!
>>>
>>> 								Honza
>>> -- 
>>> Jan Kara <jack@suse.com>
>>> SUSE Labs, CR
>>>
>>
>> $ cat run_parent_ref_scale.sh
>> #!/usr/bin/env bash
>> set -u -o pipefail
>>
>> bench=./fsnotify_parent_ref_bench
>> if [[ ! -x "$bench" ]]; then
>>         printf 'Build %s in the current directory first.\n' "$bench" >&2
>>         exit 1
>> fi
>>
>> results_dir=$(mktemp -d ./parent-ref-results-XXXXXXXX) || exit 1
>> printf
>> 'kernel=%s\nbenchmark=%s\ntmpfs=/dev/shm\nwrites_per_client=1000000\nmode=watch\n'
>> \
>>         "$(uname -r)" "$bench" > "$results_dir/run-info.txt"
>> printf 'Results: %s\n' "$results_dir"
>>
>> for i in 1 2 3 4 5; do
>> for clients in 1 2 4 8 16 32 64 128 256 512 1024; do
>>         log="$results_dir/clients-${clients}.log"
>>         printf '\n=== clients=%d ===\n' "$clients"
>>         "$bench" /dev/shm "$clients" 1000000 watch 2>&1 | tee "$log"
>>         status=${PIPESTATUS[0]}
>>         printf 'exit_status=%d\n' "$status" | tee -a "$log"
>> done
>> done
>>
>> printf '\nAll results saved in %s\n' "$results_dir"
>>
>>
>>
>> $ cat fsnotify_parent_ref_bench.c
>> #define _GNU_SOURCE
>> #include <errno.h>
>> #include <fcntl.h>
>> #include <inttypes.h>
>> #include <limits.h>
>> #include <poll.h>
>> #include <pthread.h>
>> #include <stdatomic.h>
>> #include <stdbool.h>
>> #include <stdint.h>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <string.h>
>> #include <sys/inotify.h>
>> #include <sys/stat.h>
>> #include <sys/statfs.h>
>> #include <time.h>
>> #include <unistd.h>
>> #include <linux/magic.h>
>>
>> #define FILES 1024
>> #define FILE_SIZE 4096
>> #define DEFAULT_WRITES 1000000UL
>>
>> struct gate {
>>         pthread_mutex_t mutex;
>>         pthread_cond_t cond;
>>         unsigned int ready;
>>         bool start;
>>         bool abort;
>> };
>>
>> struct worker {
>>         char path[PATH_MAX];
>>         unsigned long writes;
>>         unsigned int id;
>>         struct gate *gate;
>>         uint64_t begin_ns;
>>         uint64_t end_ns;
>>         int error;
>> };
>>
>> struct listener {
>>         int fd;
>>         atomic_bool stop;
>>         uint64_t events;
>>         uint64_t overflows;
>>         int error;
>> };
>>
>> static uint64_t now_ns(void)
>> {
>>         struct timespec ts;
>>
>>         if (clock_gettime(CLOCK_MONOTONIC_RAW, &ts)) {
>>                 perror("clock_gettime");
>>                 exit(EXIT_FAILURE);
>>         }
>>         return (uint64_t)ts.tv_sec * 1000000000ULL + ts.tv_nsec;
>> }
>>
>> static unsigned long parse_count(const char *s, const char *name)
>> {
>>         char *end;
>>         unsigned long value;
>>
>>         errno = 0;
>>         value = strtoul(s, &end, 10);
>>         if (errno || !*s || *end || !value) {
>>                 fprintf(stderr, "Invalid %s: %s\n", name, s);
>>                 exit(EXIT_FAILURE);
>>         }
>>         return value;
>> }
>>
>> static void file_path(char *out, size_t size, const char *dir, unsigned
>> int i)
>> {
>>         int n = snprintf(out, size, "%s/file-%04u", dir, i);
>>
>>         if (n < 0 || (size_t)n >= size) {
>>                 fputs("File path is too long\n", stderr);
>>                 exit(EXIT_FAILURE);
>>         }
>> }
>>
>> static void *run_worker(void *arg)
>> {
>>         struct worker *w = arg;
>>         int fd;
>>         char byte = (char)w->id;
>>         unsigned long i;
>>         bool abort;
>>
>>         fd = open(w->path, O_WRONLY | O_CLOEXEC);
>>         if (fd < 0)
>>                 w->error = errno;
>>         pthread_mutex_lock(&w->gate->mutex);
>>         w->gate->ready++;
>>         pthread_cond_broadcast(&w->gate->cond);
>>         while (!w->gate->start)
>>                 pthread_cond_wait(&w->gate->cond, &w->gate->mutex);
>>         abort = w->gate->abort;
>>         pthread_mutex_unlock(&w->gate->mutex);
>>         if (abort || w->error)
>>                 goto out;
>>
>>         w->begin_ns = now_ns();
>>         for (i = 0; i < w->writes; i++) {
>>                 if (pwrite(fd, &byte, 1, 0) != 1) {
>>                         w->error = errno ? errno : EIO;
>>                         break;
>>                 }
>>         }
>>         w->end_ns = now_ns();
>> out:
>>         if (fd >= 0 && close(fd) && !w->error)
>>                 w->error = errno;
>>         return NULL;
>> }
>>
>> static void *drain_events(void *arg)
>> {
>>         struct listener *l = arg;
>>         char buf[65536] __attribute__((aligned(8)));
>>         struct pollfd pfd = { .fd = l->fd, .events = POLLIN };
>>
>>         for (;;) {
>>                 int ready = poll(&pfd, 1, atomic_load(&l->stop) ? 0 : 50);
>>
>>                 if (ready < 0) {
>>                         if (errno == EINTR)
>>                                 continue;
>>                         l->error = errno;
>>                         break;
>>                 }
>>                 if (!ready) {
>>                         if (atomic_load(&l->stop))
>>                                 break;
>>                         continue;
>>                 }
>>                 for (;;) {
>>                         ssize_t len = read(l->fd, buf, sizeof(buf));
>>                         size_t pos = 0;
>>
>>                         if (len < 0) {
>>                                 if (errno == EINTR)
>>                                         continue;
>>                                 if (errno == EAGAIN)
>>                                         break;
>>                                 l->error = errno;
>>                                 return NULL;
>>                         }
>>                         while (pos + sizeof(struct inotify_event) <=
>> (size_t)len) {
>>                                 struct inotify_event *ev =
>>                                         (struct inotify_event *)(buf + pos);
>>                                 size_t step = sizeof(*ev) + ev->len;
>>
>>                                 if (step > (size_t)len - pos) {
>>                                         l->error = EPROTO;
>>                                         return NULL;
>>                                 }
>>                                 l->events++;
>>                                 if (ev->mask & IN_Q_OVERFLOW)
>>                                         l->overflows++;
>>                                 pos += step;
>>                         }
>>                         if (pos != (size_t)len) {
>>                                 l->error = EPROTO;
>>                                 return NULL;
>>                         }
>>                 }
>>         }
>>         return NULL;
>> }
>>
>> static void cleanup(const char *dir)
>> {
>>         char path[PATH_MAX];
>>         unsigned int i;
>>
>>         for (i = 0; i < FILES; i++) {
>>                 file_path(path, sizeof(path), dir, i);
>>                 if (unlink(path) && errno != ENOENT)
>>                         perror(path);
>>         }
>>         if (rmdir(dir))
>>                 perror(dir);
>> }
>>
>> int main(int argc, char **argv)
>> {
>>         char dir[PATH_MAX], path[PATH_MAX];
>>         unsigned long writes = DEFAULT_WRITES;
>>         unsigned long count;
>>         unsigned int clients, i, created = 0;
>>         struct statfs fs;
>>         struct gate gate = {
>>                 .mutex = PTHREAD_MUTEX_INITIALIZER,
>>                 .cond = PTHREAD_COND_INITIALIZER,
>>         };
>>         struct listener listener = { .fd = -1 };
>>         struct worker *workers;
>>         pthread_t *threads, listener_thread;
>>         bool watched = true, listener_started = false;
>>         uint64_t first = UINT64_MAX, last = 0, sum = 0;
>>         uint64_t shortest = UINT64_MAX, longest = 0;
>>         char zeroes[FILE_SIZE] = { 0 };
>>         int rc = EXIT_FAILURE, err;
>>
>>         if (argc < 3 || argc > 5) {
>>                 fprintf(stderr, "Usage: %s TMPFS_ROOT CLIENTS
>> [WRITES_PER_CLIENT] [watch|none]\n", argv[0]);
>>                 return rc;
>>         }
>>         clients = parse_count(argv[2], "clients");
>>         if (clients > FILES) {
>>                 fprintf(stderr, "Clients must be at most %d\n", FILES);
>>                 return rc;
>>         }
>>         if (argc > 3)
>>                 writes = parse_count(argv[3], "writes per client");
>>         if (writes > ULONG_MAX / clients) {
>>                 fputs("Total write count is too large\n", stderr);
>>                 return rc;
>>         }
>>         if (argc > 4) {
>>                 if (!strcmp(argv[4], "none"))
>>                         watched = false;
>>                 else if (strcmp(argv[4], "watch")) {
>>                         fputs("Mode must be watch or none\n", stderr);
>>                         return rc;
>>                 }
>>         }
>>         if (statfs(argv[1], &fs)) {
>>                 perror(argv[1]);
>>                 return rc;
>>         }
>>         if (fs.f_type != TMPFS_MAGIC) {
>>                 fprintf(stderr, "%s must be a tmpfs directory\n", argv[1]);
>>                 return rc;
>>         }
>>         if (snprintf(dir, sizeof(dir), "%s/fsnotify-parent-ref-XXXXXX",
>> argv[1]) >=
>>             (int)sizeof(dir) || !mkdtemp(dir)) {
>>                 perror("mkdtemp");
>>                 return rc;
>>         }
>>         workers = calloc(clients, sizeof(*workers));
>>         threads = calloc(clients, sizeof(*threads));
>>         if (!workers || !threads) {
>>                 fputs("Cannot allocate worker state\n", stderr);
>>                 goto out;
>>         }
>>         for (i = 0; i < FILES; i++) {
>>                 int fd;
>>
>>                 file_path(path, sizeof(path), dir, i);
>>                 fd = open(path, O_CREAT | O_EXCL | O_WRONLY | O_CLOEXEC,
>> 0600);
>>                 if (fd < 0) {
>>                         perror(path);
>>                         goto out;
>>                 }
>>                 /* Allocate the tmpfs page before the measured write
>> loop. */
>>                 if (write(fd, zeroes, sizeof(zeroes)) != sizeof(zeroes)) {
>>                         perror(path);
>>                         close(fd);
>>                         goto out;
>>                 }
>>                 if (close(fd)) {
>>                         perror(path);
>>                         goto out;
>>                 }
>>         }
>>         if (watched) {
>>                 listener.fd = inotify_init1(IN_NONBLOCK | IN_CLOEXEC);
>>                 if (listener.fd < 0 ||
>>                     inotify_add_watch(listener.fd, dir, IN_MODIFY) < 0) {
>>                         perror("inotify watch");
>>                         goto out;
>>                 }
>>                 err = pthread_create(&listener_thread, NULL,
>> drain_events, &listener);
>>                 if (err) {
>>                         errno = err;
>>                         perror("listener thread");
>>                         goto out;
>>                 }
>>                 listener_started = true;
>>         }
>>         for (i = 0; i < clients; i++) {
>>                 workers[i].id = i;
>>                 workers[i].writes = writes;
>>                 workers[i].gate = &gate;
>>                 file_path(workers[i].path, sizeof(workers[i].path), dir, i);
>>                 err = pthread_create(&threads[i], NULL, run_worker,
>> &workers[i]);
>>                 if (err) {
>>                         errno = err;
>>                         perror("worker thread");
>>                         gate.abort = true;
>>                         goto release;
>>                 }
>>                 created++;
>>         }
>>         pthread_mutex_lock(&gate.mutex);
>>         while (gate.ready < clients)
>>                 pthread_cond_wait(&gate.cond, &gate.mutex);
>>         pthread_mutex_unlock(&gate.mutex);
>>         for (i = 0; i < clients; i++) {
>>                 if (workers[i].error) {
>>                         fprintf(stderr, "Worker %u open: %s\n", i,
>>                                 strerror(workers[i].error));
>>                         gate.abort = true;
>>                         break;
>>                 }
>>         }
>>         printf("test_dir=%s files=%d file_size=%d clients=%u
>> writes_per_client=%lu mode=%s\n",
>>                dir, FILES, FILE_SIZE, clients, writes,
>>                watched ? "watch" : "none");
>>         fflush(stdout);
>> release:
>>         pthread_mutex_lock(&gate.mutex);
>>         gate.start = true;
>>         pthread_cond_broadcast(&gate.cond);
>>         pthread_mutex_unlock(&gate.mutex);
>>         for (i = 0; i < created; i++)
>>                 pthread_join(threads[i], NULL);
>>         if (listener_started) {
>>                 atomic_store(&listener.stop, true);
>>                 pthread_join(listener_thread, NULL);
>>                 printf("inotify_events=%" PRIu64 " queue_overflows=%"
>> PRIu64 "\n",
>>                        listener.events, listener.overflows);
>>                 if (listener.error)
>>                         fprintf(stderr, "Inotify listener: %s\n",
>> strerror(listener.error));
>>                 if (listener.overflows)
>>                         fputs("Inotify queue overflowed; event delivery
>> load changed during the run\n", stderr);
>>         }
>>         if (gate.abort || listener.error)
>>                 goto out;
>>         for (i = 0; i < clients; i++) {
>>                 uint64_t duration;
>>
>>                 if (workers[i].error) {
>>                         fprintf(stderr, "Worker %u write: %s\n", i,
>>                                 strerror(workers[i].error));
>>                         goto out;
>>                 }
>>                 duration = workers[i].end_ns - workers[i].begin_ns;
>>                 if (workers[i].begin_ns < first)
>>                         first = workers[i].begin_ns;
>>                 if (workers[i].end_ns > last)
>>                         last = workers[i].end_ns;
>>                 if (duration < shortest)
>>                         shortest = duration;
>>                 if (duration > longest)
>>                         longest = duration;
>>                 sum += duration;
>>         }
>>         count = (unsigned long)clients * writes;
>>         printf("total_writes=%lu wall_seconds=%.6f
>> throughput_writes_per_sec=%.0f mean_worker_ns_per_write=%.1f
>> shortest_worker_seconds=%.6f longest_worker_seconds=%.6f\n",
>>                count, (last - first) / 1e9, count * 1e9 / (last - first),
>>                (double)sum / count, shortest / 1e9, longest / 1e9);
>>         printf("result=%s\n", listener.overflows ? "QUEUE_OVERFLOW" :
>> "PASS");
>>         rc = listener.overflows ? EXIT_FAILURE : EXIT_SUCCESS;
>> out:
>>         if (listener.fd >= 0)
>>                 close(listener.fd);
>>         cleanup(dir);
>>         free(workers);
>>         free(threads);
>>         return rc;
>> }
>>
>>
>> Please compile : fsnotify_parent_ref_bench.c -o
>> fsnotify_parent_ref_bench. After that
>> run the script ./run_parent_ref_scale.sh
>>
>> Thanks
>> Partha
> 
> Hi Honza,
> 
> A gentle ping on the benchmark program, Have you had a chance to try it
> on your setup? Please let me know if any further tests or information
> would be helpful.
> 
> Thanks,
> Partha



Hi Honza,

Have you had a chance to try the benchmark on your setup? Please let me
know if you need any further tests from my side to move this patch forward.

Thanks,
Partha

