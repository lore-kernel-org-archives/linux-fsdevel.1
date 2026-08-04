Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8ED3128D9
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826369; cv=fail; b=CWK8JX0ihRVchzcQjrGobf6BlNFDs/NPB58f37asKSfx5vOC7Cgrjy9w5tfPgP53s9ImJzuExpLpaULD03PDlHcRDgYaq9epJR1NBxcO6Ht+d4mIVPQPoPEv+7RNEp1jvH5rTAiaOEOGPrFnwMe8ykK250/lkupR40cGHlQIn+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826369; c=relaxed/simple;
	bh=MOVjidoKXZVrZ6KJscUvSgYmDrIuMsku5LQFvv80bEY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=kjQxOkg+SQjDX1G5KS/Whgd1n5k7gr/xkZn1ZX1rxpI40pjlYzh0YdPxbeaCPSYFg3gI2pdSxCWVctuu/cx6dcDkOF6PmgfIp3ZAVoqfk+ZAH5bUcucgFuu3xLiuD+r8Tp3X8uTpGx6U9VIo2l/VXDIVqmPIbTr6jUs0tUIFgww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bKH9/DYD; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KWtCEYPI reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bKH9/DYD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KWtCEYPI"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673LfkWm2955803;
	Tue, 4 Aug 2026 06:51:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/McJ/5VtfG72wmOhNVWRrMmJ8DOE4B/+64y/vcf2jgk=; b=
	bKH9/DYDH9Elp3/auGloFG6hXS/9zhvBEjFku/F6Lyp/XWdRkkmeLyzbfXIwHFQ7
	AD3ziI1V13ZavX6133VO0KA7SG54Dajj+KheYlrKGVjtD82J/6Q+AS2ct/RkPmkY
	VOq9ABqsjZ/P2XRTYbZMXpzZGnTwcFYfLxE5IT6RAXfnBbhH23LX+o8K9VwS6lD7
	gkiDRGkvkt+Q6loHTLEWYP81ThjDQKTMVBqATLm1PzOinPPOk5iS99UHLJet+NFO
	XH/CJ89MN7iyFoV5gH+VqmXjVH3XBj+8IIolKHbr/Bhl7Vb1A2iIEuJ8Or0wIl8P
	058wXbAXjqos4RwsIy8o2g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs8p951e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Aug 2026 06:51:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6746p8G2039402;
	Tue, 4 Aug 2026 06:51:56 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012013.outbound.protection.outlook.com [40.93.195.13])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78tdmsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 04 Aug 2026 06:51:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUgJAa3NFemOAx+dyKgHHeXKIHxhcDsg/LMVmZ1wxjytlME9U2CEQo0GIIy1of5CsuK/ZgbOYHz6oF4gKr7kvDLYeVShvo7gZqX+hJZfG6hdjftKb4cBPz2xKr89WFYl0m5Fw7x60FT3fLWXl8BjZXYezjTxwPq4qe/MqVBnF+A1w+sd6KFtj/RT7VWYcxDjRlDIx5HgUipn3+zTRJMKCyVhX7SqtptFx0o/+TQ+S9AQfVRG6j3t0xBFzMb+wnI05NOLlEMsS+i4lJ/Bzt6jvtw/jZqnsb01bnMM0stG5cNOjR+BHBcwzAUUqacQYOZVDBZk+/RqPdKK82wd+MhBQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9Et2oR7+Q7ZFTtHCFO4SqNqRqOxDGJkWD+SVrCfqWk=;
 b=KuGPfJmhrwkwPyYRv2ZPWt0IQhP0UZen1+B8lukxZhYdU2wZxQ4AmqSVMQFfrwy/VniZd5e58OomE3BwNzCX8jysmV4K/TM35yGO5VR5H9ha0oMUWlYmioYq386YynG8VeID1nmDZgpx6001Rw+S08MED/71PN/XQ6crSQlvP3gavuiuXtoD4r07P3N6HKFAy+6x2ijXDM/VLXdEO/VyNHf21g4cVqiT671pAN4z58aaEdow/kQkr7kHo6GWbU2zY0DaWWWn9ADzj2L2/PaFwQ3hvu8fx5xEG1vSDLngqtOGPpDPnc5i9JD3pgqKRSDVAHf4PMvb+70pvo7JVIhQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9Et2oR7+Q7ZFTtHCFO4SqNqRqOxDGJkWD+SVrCfqWk=;
 b=KWtCEYPIX2ypboOF9Ov+ZblEnEc50NXN/RZf28H3WShSkHBl5nhXvYFUxzSoqJPjpYSANAcD528hsRxul40HEjPNHzZud7AIm9NCYpGYvwiP0XlrZ3ccxzyf55R4UJqTLc3GWNNY62RnTUMeAVTY0DHT8ObyO7QJO6+8Dv/KCcE=
Received: from IA0PR10MB7369.namprd10.prod.outlook.com (2603:10b6:208:40e::14)
 by SA1PR10MB5735.namprd10.prod.outlook.com (2603:10b6:806:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 06:51:52 +0000
Received: from IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e]) by IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 06:51:51 +0000
Message-ID: <9b2cd903-7800-4c45-bc07-dca0ee40331d@oracle.com>
Date: Mon, 3 Aug 2026 23:51:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/15] hugetlb: Use the has_hwpoisoned flag
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
 <20260731200802.574821-9-willy@infradead.org>
From: jane.chu@oracle.com
In-Reply-To: <20260731200802.574821-9-willy@infradead.org>
X-ClientProxiedBy: PH8P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::29) To IA0PR10MB7369.namprd10.prod.outlook.com
 (2603:10b6:208:40e::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7369:EE_|SA1PR10MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 7645ee70-0130-49bb-3dc6-08def1f4dd0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|4133799003|4143699003|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	6QrAiBJeLZEPqkNRgYXWImgj/TK747gOR7NvK94EmUMsn+fM9ds/0di4RjVLADkkHJsWiQALFhDpJX/IkxB9usaMTNC7SeJmUZjODcOKjQkglXXXYfb+jZfzanOds4ExCjw9wmM18sRBFfTfvWXUTExYfRS/d7tfohCaWGpj+iI+4FJI/3QynS/I0Vm/qMFtknWn2LABABqJ7ATzy7q4FgW9Pas4uDYd+f370/m1e7iUKIZMdTzb+oSWIXe/XyxeYBmBt0F6P989sY/mL20SrZfYiODEEeGhBHu0eASo/YSxPj7gUGulYIJXOS7+ydmvf3Q4mTeqrHNyUdYN73DSwxqipvqAaUf6tDomsE8iT/Uhk8PNkB+H0fVF9RmdEWfXWnTlEptsNSq1rINKZ5jY76unTj4Jp36UvKqjdx3qbFCNObLgV5g2V8mMb8gDe354OjmmxTBeHsPdko0eW9ca7KEDf1BhOKENptWVKPoN48M2mgy3umRxp3oxxeu2ebHDcuybRTldNIFZ0g+nNsmW9//OC96h6k09/dL3mRKlsX+eDzJcpLcidQPy9qUBgm52n+m+9BPOGtToAAXG5B8Aq/4AIe0YslD/HQD2WpGT4Rc+nKj31Wtu/VsTP7J7wzYcYubPruiEJzlBV1T89h4TSSM1a8Jas3cCLxFNnefgWyU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7369.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(4133799003)(4143699003)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHhvV3BhNFJPSUpYTU9odFVqK0cxbTdTRlprcWowSk93WEs3K3pUYUNYUmYv?=
 =?utf-8?B?V05ya2NyWWtHT3FDV1R3YWt4SzRscnQ0aDMrbUk4TVNkNlNoZFB6aDc3WmtF?=
 =?utf-8?B?UXJlZ3BTbEh1OGJKdlpYaHhTdUdTV3p6K0swUDY0cHpoUWdsemErd1NhSEN2?=
 =?utf-8?B?S3JMZWQveC8yOU1pcndld2pqaUE4RXdhVURjZi9NbVU1R3FsQ3RCM2NybFZl?=
 =?utf-8?B?RHhlVGxNdncwZ05oUE5pd0JVeVFuOUVxQTZZeHpmOS9NdFBSSjY5UCtNN1Zs?=
 =?utf-8?B?L1pVTEdQZnlweTlvOG1hQVBxQ0VmSS9BTSt2dnQ4QTVMblRzZEpaNVNDbWZi?=
 =?utf-8?B?eFpKdUVGWlVGZFpYNzJsZjdZdklIajV6YS9TeEZRMEVadHE5UU1zTHJocEFM?=
 =?utf-8?B?d2Q2YUJ2UmxtTTJFVFdFTGRmNUVsNHhMbHB4Q1dZUWp1R2tkcWU4b3Fxc3ZF?=
 =?utf-8?B?SHRxakNjbmo1eVZqSWdWSURQRXBYTFI3WW5YR1lYN1FoT1lLdG1WOTdOYVVD?=
 =?utf-8?B?SWY0M1VPRXNzcTNnaGc1MzdYaUsxdE9vYUw2SjV0N21sV0Y4YUkvR0FBUE5T?=
 =?utf-8?B?c1dBNisrSnZxYjgzUW5PdUpOa2Y0SWhGZCthQmp3dVkzeGJoS0pIMEFheXVv?=
 =?utf-8?B?MHJiMlhISFdMVjVqdFlURTl2b1cxZFpqNmdielo3MzQ1clFjWk81eVZTRHhQ?=
 =?utf-8?B?cEFqVFY3NTZ2SVNZc1NRNHdhRTA4aGcrelFjUGdrN0NDdTFXclRnS3p3cEVS?=
 =?utf-8?B?NlBkVUpqSjlPU3pPRW5LbmpUYXRHRFVJOThHL2NtV2gzaXpNd3lnSXR5T0Uy?=
 =?utf-8?B?ZzRwK3QyYjRzVTAvOEpYbmVETE02dnVTSXNaeDNJQ2szanpDZFdCSG45QTVO?=
 =?utf-8?B?bDJNdFBmSGpvK1QyZHVmbjBvWWdGVXZUTW5BMVZuU3ZjekVaTEVQMXZ4Rjdx?=
 =?utf-8?B?cjk4UmE1WEdrNm1zNk51QkNtN3NoSm1SQXcyOGdHZmlmTzJmUlNCbDRSenc1?=
 =?utf-8?B?L2padTRKK2crcCtqK3IzUlV2M1RyWU13b0d6Ujc4N3hUVmNRVlZhR3dua3Z6?=
 =?utf-8?B?UWU5Y2dKVlFvdk1ZeDU5clJRbEtOakUzeWl5YUZQaDZSTGhic1JCUmZlTzdT?=
 =?utf-8?B?VEVBbmdnOVAvQ2RsS2E1TUN5NU0vaUZHRlZqaGliSUpDM1VNTmxSd2dzV0dp?=
 =?utf-8?B?RUpEK01QNXdLTzFnRUFRT2Vtc2F5eWQvUG1Bam5zL2EyODU5bUNTOXUyaGtl?=
 =?utf-8?B?OUJoVXNDR2hxU2dPdGttWFVvTVcyZEJUMVZLcnFQTzAranR1dnpWNlNmbGlF?=
 =?utf-8?B?dlRWZGFUUXBnOUwzYTZpdVE2a21EMFhtOTdPcXlPR2hSQkQ5OGRFNkZYcTRx?=
 =?utf-8?B?U0RvdVZWeXB1YjVzYzdYcWZXd1FVaWtQejNtaFNMaGhPNmxtaEpaTXBJYk14?=
 =?utf-8?B?aFNTWml1Ynd3WGllRFE0dWN0SVNUSnJWMUdtRk9WZW1hc3lSdUdkVFR0NTBK?=
 =?utf-8?B?MmZHYzBLSEJwZkhIWUpCcTFzSEE0QVlXNHk2NWRScmNmT3NrQUZ1MWhDN3da?=
 =?utf-8?B?M3J1dUVKVGF4L2V3Qzh5ei96M3BadEkxaW45cGVuTVVkeTB5WkZWSnhPOTZW?=
 =?utf-8?B?ZnZUeUwvbG52cXgrMW9yRlN2TW04blpyQkRmaENOS24yQWZLVXJDeHorSjNR?=
 =?utf-8?B?WUszN2piS1hsV1lkRjJrREtweHhmWENBZzRtSC9ySUNKd25tQnRMN3dYMUJk?=
 =?utf-8?B?TUlZWGJxOGRHd2E0cTJ5ZFBBVzlUTW5lSUp5U1ovZnVKWWs4eVhGZlRGSGNS?=
 =?utf-8?B?NmdaWDJwRkxicHN5MFo1YWhEbmlxWlk0em1OU2tjSzk1VVhnTGxTb1FsSmFC?=
 =?utf-8?B?VXR0VHFCUUFVK0R6N3ZYVWFwWTZ0cStuTCt6Nnk4cUV1S2xERS83OUZPTW9T?=
 =?utf-8?B?dGpjOTBwSmRham9YWUV4TklJZVI3VmpvVllyWlBQYndQSzQrVjVLRzVWbm13?=
 =?utf-8?B?UmdaUlMyQmZ1ekRkWGpMZmpGZU5mMFR0V045M0hrdVZCcVp3UVdKQnVaTHhB?=
 =?utf-8?B?WDlCNElQMGNsTmZwU0hkaEVqQUR3LzhGZ1hCcXZsb1JFME5ORmRySFk3ZGh3?=
 =?utf-8?B?aUUvVE1QM0tiWFozY3MzZEhvcERuUHYrL3RrMEREclZVM2x4eEx0MUJrMmRN?=
 =?utf-8?B?UlVqU091QTloak9nUld0WmEycUE0MWxycVliclB3Y3RldDNQQytsQ2F3aEh6?=
 =?utf-8?B?Qlp6RDczMmp3SnplRU1JL1lNV1Q5amxFcmtlaWlPZTBNT1lxcHZORGtWS1Ur?=
 =?utf-8?B?enJ3Y2lYNmNIT2dXdU1WOEtxL0dhcThBaWxhckFZK2NBUDM2OTJuZz09?=
X-Exchange-RoutingPolicyChecked:
	ACny6v+/uSBBq8uiHZ36jWf19Kx1djMEVCL36fXAMMsC7NmHt/yAkSvw0ZCltH3aifN9VI0ahXGjuy70avszvZmnA3ZDrarHb7a2o8TjYFYtkng6cgEL9PwvRq0m0Gvhj9X+G8aTd3x7Rm3RK98OY2+Ztwcj5VfbPs9A591iFgXEOZAntIyzJBdArZ5V7s6RDVMZTtL4YAbtUadbWwwdYKSP8uV5kjwoRbQqreTaE/C5mZIz9OExEVexP2Xm9s33A/g15WkL+J/VcoFIZkxUKzqyNCUKxW0YR6sPdhwf20X3Gy/k5XA1psdIs7rN4Vjhp8/hIoSudKfvRnocISoJmg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GvmHOMLrBp+DGmltMcSPP+1yFSQLYygGp+kJkDKAFTnLN9znKD+8sMWSE8MYbk6q/xHy4E8GUSxqubORjJy80vc3ovdrs1qHi9hXERJlm1UB8mxSDjzO+8cwGz5RgjPM9LyNac7VMp0pJLLb0ZVxOZPRq2JfpOyIyf0Qr6xP4VOL0ot9ndqXAeRrNELR6PP8CIAXaE+pyFL++dH0H6VueEQkmGhoF72nG3U3jlWI/BEHlfY3iHCZ21ijPOuR6QR9laB1MQfCn5xJ7nvX2sPKIBCFhL7xtkpiYi/fAz3VfdIxTF2tsiTwCbdMDhzg/whpC0fk+qdJh0V7G3omiOrfCkChoKCh7VPwQ9TRMIlMSmt7PPenJHoZsPutyY+2K2d+YL1evhtyq86TjZH3izWpxzmSLwxYpmcg9gW1xRR4/wsd1i2b5fRgyHGtXEHUc/NtshB/KM+PXlAiTGe+Btmdoveq/eKlktXtnsdge05PxpIDVj+WyA6ewaL8zpH72+v/MTnxXV8+kVyU5bs8c1ZPQa60i53O1E/ap3Po6CZkQTZdL442zr9Xm/bkYG22EuupnIcJzRK9IXE/LBSwWlJdnVAJd5nEAmhqP16Lyd9Y0ac=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7645ee70-0130-49bb-3dc6-08def1f4dd0e
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7369.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 06:51:51.8464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GScXx3yOdYXWHgevyUGHctuaqC7NwCg+PwBPipqGV06vW6HaJb19H8xU6aAUGbIApNg3vbi8firlt+AZ7+X5zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608040053
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1MiBTYWx0ZWRfXzMb+G0PMGsN1
 bpgg0Pg53WkEsQkGqTicqy8P5BXbE5CV8/eX3E6ISg9/NOvx4kI29wl6QDTi/4VAfoVpVYVUotk
 90g4HuItUBALdWnSUU5+HtstYexXItNImgSSbBNdU6aLGa+DVL9O
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a718c0e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=RpNjiQI2AAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=T_oIFs3LeonVigg7SXoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12100
X-Proofpoint-GUID: 2s-WrsusQUcEKVPILX80HvLHm4CmPgL8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1MiBTYWx0ZWRfX+JPk2aPF5jsH
 Y5HxWqPdvXcTE+Qm9F34CpX+u7c2yp3mOVB3sHVILdNfrxKHjzd/Ew5DFUGqD56bLr3wAxdDDGx
 VnZ/ygTYUw7u8wm1qHzt/vDILa1s4WT1gY7biRtp4NAPdNLE6kaxEPWkbkC0vZ+2DRZmBhvFKtD
 RKh48PrrHapgLh7E8YcQ31YElvtNK2jFB/4LklDTZCVIBydjVYhHa2ji8EefjkFYaP4Z5+BN94F
 WuWa/16lAxblx3j+R/+G7QUPymhByinjAY8+IRsax6vPaoVlyL44hKYFf4ozAJ8eseYXqyiD13A
 0dWeUqr9F7Ls1IutM/aY1agMUG55+2Oaj3s2l1pWGvMJVrzQAmfKEBFeuc8KS5n6F3sR0Q+tpjQ
 bdEtxztygVRd5z5vbtqxn7EBvbbWAflVYmpooJCp5A+K5unlPdwN3R/0b2+VXlUTMeFbinGx1kZ
 i0avtVcrIJKtEEtmWZQ0ykM40e1h7cWuONnaco4o=
X-Proofpoint-ORIG-GUID: 2s-WrsusQUcEKVPILX80HvLHm4CmPgL8



On 7/31/2026 1:07 PM, Matthew Wilcox (Oracle) wrote:
> Other large folios use the has_hwpoisoned flag. Convert hugetlb to=20
> match. This will help us use the per-page hwpoison flag in the future.=20
> Also introduce a folio_test_huge_poison(). This has exactly the same=20
> meaning as folio_test_has_hwpoisoned()
>=20
>=20
> Other large folios use the has_hwpoisoned flag.  Convert hugetlb to match.
> This will help us use the per-page hwpoison flag in the future.
>=20
> Also introduce a folio_test_huge_poison().  This has exactly the same
> meaning as folio_test_has_hwpoisoned() but can be used when we don't have
> a reference to the folio containing the page.  folio_test_has_hwpoisoned()
> can race with folio splitting / reallocation and trip the assertions
> in const_folio_flags().
>=20
> This closes a gap where a page in a previously-poisoned hugetlb folio
> could be observed to not have the hwpoison bit set.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/Kconfig                 |  2 +-
>   fs/hugetlbfs/inode.c       |  2 +-
>   include/linux/page-flags.h | 46 ++++++++++++++++++++++++------
>   mm/Kconfig                 |  6 +++-
>   mm/hugetlb.c               | 10 +++----
>   mm/memory-failure.c        | 58 +++++++++++++++++++++++++++-----------
>   mm/rmap.c                  | 43 +++++++++++++++++-----------
>   7 files changed, 119 insertions(+), 48 deletions(-)
>=20
> diff --git a/fs/Kconfig b/fs/Kconfig
> index cf6ae64776e6..eddac4ed214b 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -272,7 +272,7 @@ endif # HUGETLBFS
>  =20
>   config HUGETLB_PAGE
>   	def_bool HUGETLBFS
> -	select XARRAY_MULTI
> +	select LARGE_FOLIO
>  =20
>   config HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>   	def_bool HUGETLB_PAGE
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 216e1a0dd0b2..fbac554886c3 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -258,7 +258,7 @@ static ssize_t hugetlbfs_read_iter(struct kiocb *iocb=
, struct iov_iter *to)
>   		} else {
>   			folio_unlock(folio);
>  =20
> -			if (!folio_test_hwpoison(folio))
> +			if (!folio_test_has_hwpoisoned(folio))
>   				want =3D nr;
>   			else {
>   				/*
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 4185a03a45cf..4fab3fbfd430 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -893,14 +893,19 @@ static inline int PageTransCompound(const struct pa=
ge *page)
>   TESTPAGEFLAG_FALSE(TransCompound, transcompound)
>   #endif
>  =20
> -#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_TRANSPARENT_HUGEPAG=
E)
> +#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_LARGE_FOLIO)
>   /*
> - * PageHasHWPoisoned indicates that at least one subpage is hwpoisoned i=
n the
> - * compound page.
> + * folio_has_hwpoisoned indicates that at least one page is hwpoisoned i=
n the
> + * folio.  That page will usually also have the HWPoison flag set, but t=
his
> + * is not possible for folios which have HVO (see memory-failure for the
> + * scheme used in that case).  You probably don't want to call this dire=
ctly;
> + * use folio_has_hwpoisoned_page() instead.
>    *
>    * This flag is set by hwpoison handler.  Cleared by THP split or free =
page.
>    */
>   FOLIO_FLAG(has_hwpoisoned, FOLIO_SECOND_PAGE)
> +FOLIO_TEST_SET_FLAG(has_hwpoisoned, FOLIO_SECOND_PAGE)
> +FOLIO_TEST_CLEAR_FLAG(has_hwpoisoned, FOLIO_SECOND_PAGE)
>   #else
>   FOLIO_FLAG_FALSE(has_hwpoisoned)
>   #endif
> @@ -1041,8 +1046,29 @@ PAGE_TYPE_OPS(Slab, slab, slab)
>  =20
>   #ifdef CONFIG_HUGETLB_PAGE
>   FOLIO_TYPE_OPS(hugetlb, hugetlb)
> +
> +#ifdef CONFIG_MEMORY_FAILURE
> +static inline bool folio_test_huge_poison(const struct folio *folio)
> +{
> +	return (READ_ONCE(folio->page.page_type) >> 23) =3D=3D
> +		((PGTY_hugetlb << 1) | 1);
> +}
> +
> +static inline void folio_set_huge_poison(struct folio *folio)
> +{
> +	folio->page.page_type |=3D (1 << 23);
> +}
> +
> +static inline void folio_clear_huge_poison(struct folio *folio)
> +{
> +	folio->page.page_type &=3D ~(1 << 23);
> +}
> +#else
> +FOLIO_TEST_FLAG_FALSE(huge_poison)
> +#endif
>   #else
>   FOLIO_TEST_FLAG_FALSE(hugetlb)
> +FOLIO_TEST_FLAG_FALSE(huge_poison)
>   #endif
>  =20
>   PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
> @@ -1069,9 +1095,10 @@ static inline bool PageHuge(const struct page *pag=
e)
>   }
>  =20
>   /*
> - * Check if a page is currently marked HWPoisoned. Note that this check =
is
> - * best effort only and inherently racy: there is no way to synchronize =
with
> - * failing hardware.
> + * Check if a page is currently marked HWPoisoned.  This check is best
> + * effort only and inherently racy: there is no way to synchronize with
> + * failing hardware.  The caller may not have a refcount on the folio
> + * containing the page, so we must be careful to not trip any assertions.
>    */
>   static inline bool is_page_hwpoison(const struct page *page)
>   {
> @@ -1080,12 +1107,15 @@ static inline bool is_page_hwpoison(const struct =
page *page)
>   	if (PageHWPoison(page))
>   		return true;
>   	folio =3D page_folio(page);
> -	return folio_test_hugetlb(folio) && PageHWPoison(&folio->page);
> +	if (folio_test_huge_poison(folio))
> +		return true;
> +	/* In case we raced with hugetlb transferring flags */
> +	return PageHWPoison(page);
>   }
>  =20
>   static inline bool folio_has_hwpoisoned_page(const struct folio *folio)
>   {
> -	return folio_test_hwpoison(folio) ||
> +	return PageHWPoison(&folio->page) ||
>   	       (folio_test_large(folio) && folio_test_has_hwpoisoned(folio));
>   }
>  =20
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 9e0ca4824905..e666dd14ca0c 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -843,11 +843,15 @@ config PERSISTENT_HUGE_ZERO_FOLIO
>   config MM_ID
>   	def_bool n
>  =20
> +config LARGE_FOLIO
> +	def_bool n
> +	select XARRAY_MULTI
> +
>   menuconfig TRANSPARENT_HUGEPAGE
>   	bool "Transparent Hugepage Support"
>   	depends on HAVE_ARCH_TRANSPARENT_HUGEPAGE && !PREEMPT_RT
>   	select COMPACTION
> -	select XARRAY_MULTI
> +	select LARGE_FOLIO
>   	select MM_ID
>   	help
>   	  Transparent Hugepages allows the kernel to use huge pages and
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 47403d02be88..40ae967b9ecc 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1255,7 +1255,7 @@ static struct folio *dequeue_hugetlb_folio_node_exa=
ct(struct hstate *h,
>   		if (pin && !folio_is_longterm_pinnable(folio))
>   			continue;
>  =20
> -		if (folio_test_hwpoison(folio))
> +		if (folio_test_has_hwpoisoned(folio))
>   			continue;
>  =20
>   		if (is_migrate_isolate_page(&folio->page))
> @@ -1387,7 +1387,7 @@ static void folio_clear_hugetlb(struct folio *folio)
>   	 * Move HWPoison flag to each error page
>   	 * which makes any healthy pages reusable.
>   	 */
> -	if (unlikely(folio_test_hwpoison(folio)))
> +	if (unlikely(folio_test_has_hwpoisoned(folio)))
>   		folio_clear_hugetlb_hwpoison(folio);
>  =20
>   	__folio_clear_hugetlb(folio);
> @@ -4003,7 +4003,7 @@ long demote_pool_huge_page(struct hstate *src, node=
mask_t *nodes_allowed,
>   		struct folio *folio, *next;
>  =20
>   		list_for_each_entry_safe(folio, next, &src->hugepage_freelists[node],=
 lru) {
> -			if (folio_test_hwpoison(folio))
> +			if (folio_test_has_hwpoisoned(folio))
>   				continue;
>  =20
>   			remove_hugetlb_folio(src, folio, false);
> @@ -5814,7 +5814,7 @@ static vm_fault_t hugetlb_no_page(struct address_sp=
ace *mapping,
>   		 * don't have hwpoisoned swap entry for errored virtual address.
>   		 * So we need to block hugepage fault by PG_hwpoison bit check.
>   		 */
> -		if (unlikely(folio_test_hwpoison(folio))) {
> +		if (unlikely(folio_test_has_hwpoisoned(folio))) {
>   			ret =3D VM_FAULT_HWPOISON_LARGE |
>   				VM_FAULT_SET_HINDEX(hstate_index(h));
>   			goto backout_unlocked;
> @@ -6323,7 +6323,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>   	ptl =3D huge_pte_lock(h, dst_mm, dst_pte);
>  =20
>   	ret =3D -EIO;
> -	if (folio_test_hwpoison(folio))
> +	if (folio_test_has_hwpoisoned(folio))
>   		goto out_release_unlock;
>  =20
>   	ret =3D -EEXIST;
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 1dd0e7b99bb1..714e1b398f2c 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1829,7 +1829,7 @@ bool is_raw_hwpoison_page_in_hugepage(struct page *=
page)
>   	struct folio *folio =3D page_folio(page);
>   	bool ret =3D false;
>  =20
> -	if (!folio_test_hwpoison(folio))
> +	if (!folio_test_has_hwpoisoned(folio))
>   		return false;
>  =20
>   	if (!folio_test_hugetlb(folio))
> @@ -1881,6 +1881,24 @@ static unsigned long __folio_free_raw_hwp(struct f=
olio *folio, bool move_flag)
>   #define	MF_HUGETLB_FOLIO_PRE_POISONED	3	/* folio already poisoned */
>   #define	MF_HUGETLB_PAGE_PRE_POISONED	4	/* exact page already poisoned */
>   #define	MF_HUGETLB_RETRY		5	/* hugepage is busy, retry */
> +
> +static inline int hugetlb_set_poison(struct folio *folio)
> +{
> +	if (folio_test_set_has_hwpoisoned(folio))
> +		return MF_HUGETLB_FOLIO_PRE_POISONED;
> +	folio_set_huge_poison(folio);
> +	return 0;
> +}
> +
> +static inline int hugetlb_clear_poison(struct folio *folio)
> +{
> +	if (!folio_test_has_hwpoisoned(folio))
> +		return -EBUSY;
> +	folio_clear_huge_poison(folio);
> +	folio_clear_has_hwpoisoned(folio);
> +	return 0;
> +}
> +
>   /*
>    * Set hugetlb folio as hwpoisoned, update folio private raw hwpoison l=
ist
>    * to keep track of the poisoned pages.
> @@ -1890,12 +1908,12 @@ static int hugetlb_update_hwpoison(struct folio *=
folio, struct page *page)
>   	struct llist_head *head;
>   	struct raw_hwp_page *raw_hwp;
>   	struct raw_hwp_page *p;
> -	int ret =3D folio_test_set_hwpoison(folio) ? MF_HUGETLB_FOLIO_PRE_POISO=
NED : 0;
> +	int ret =3D hugetlb_set_poison(folio);
>  =20
>   	/*
>   	 * Once the hwpoison hugepage has lost reliable raw error info,
> -	 * there is little meaning to keep additional error info precisely,
> -	 * so skip to add additional raw error info.
> +	 * there is no point in keeping additional error info precisely,
> +	 * so skip adding additional raw error info.
>   	 */
>   	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
>   		return MF_HUGETLB_FOLIO_PRE_POISONED;
> @@ -1950,8 +1968,8 @@ void folio_clear_hugetlb_hwpoison(struct folio *fol=
io)
>   		return;
>   	if (folio_test_hugetlb_vmemmap_optimized(folio))
>   		return;
> -	folio_clear_hwpoison(folio);
>   	folio_free_raw_hwp(folio, true);
> +	folio_clear_has_hwpoisoned(folio);
>   }
>  =20
>   static int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
> @@ -2104,6 +2122,11 @@ static inline unsigned long folio_free_raw_hwp(str=
uct folio *folio, bool flag)
>   {
>   	return 0;
>   }
> +
> +static inline int hugetlb_clear_poison(struct folio *folio)
> +{
> +	return 0;
> +}
>   #endif	/* CONFIG_HUGETLB_PAGE */
>  =20
>   /* Drop the extra refcount in case we come from madvise() */
> @@ -2733,8 +2756,10 @@ int unpoison_memory(unsigned long pfn)
>   				hugetlb_unlock_irq();
>   				goto unlock_mutex;
>   			}
> +			ret =3D hugetlb_clear_poison(folio);
> +		} else {
> +			ret =3D TestClearPageHWPoison(p) ? 0 : -EBUSY;
>   		}
> -		ret =3D folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;
>   		hugetlb_unlock_irq();
>   	} else if (ghp < 0) {
>   		if (ghp =3D=3D -EHWPOISON) {
> @@ -2744,17 +2769,18 @@ int unpoison_memory(unsigned long pfn)
>   			unpoison_pr_info("%#lx: failed to grab page\n",
>   					 pfn, &unpoison_rs);
>   		}
> -	} else {
> -		if (folio_test_hugetlb(folio)) {
> -			huge =3D true;
> -			count =3D folio_free_raw_hwp(folio, false);
> -			if (count =3D=3D 0) {
> -				folio_put(folio);
> -				goto unlock_mutex;
> -			}
> -			p =3D &folio->page;
> +	} else if (folio_test_hugetlb(folio)) {
> +		huge =3D true;
> +		count =3D folio_free_raw_hwp(folio, false);
> +		if (count =3D=3D 0) {
> +			folio_put(folio);
> +			goto unlock_mutex;
>   		}
> -
> +		ret =3D hugetlb_clear_poison(folio);
> +		folio_put(folio);
> +		if (!ret)
> +			folio_put(folio);
> +	} else {
>   		folio_put(folio);
>   		if (TestClearPageHWPoison(p)) {
>   			folio_put(folio);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1c77d5dc06e9..fd19a0bfbfe7 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1978,6 +1978,22 @@ static inline unsigned int folio_unmap_pte_batch(s=
truct folio *folio,
>   				     FPB_RESPECT_WRITE | FPB_RESPECT_SOFT_DIRTY);
>   }
>  =20
> +/*
> + * Since we cannot split a hugetlb folio, we want to insert a poison
> + * entry into the page table for the whole folio even if only one page
> + * is poisoned.  Otherwise, we've split down to the PTE level and we only
> + * want to poison the precise page
> + */
> +static bool ttu_create_hwpoison(const struct folio *folio,
> +		const struct page *page, enum ttu_flags flags)
> +{
> +	if (!(flags & TTU_HWPOISON))
> +		return false;
> +	if (folio_test_hugetlb(folio))
> +		return folio_test_has_hwpoisoned(folio);
> +	return PageHWPoison(page);
> +}
> +
>   /*
>    * @arg: enum ttu_flags will be passed to this argument
>    */
> @@ -1993,7 +2009,6 @@ static bool try_to_unmap_one(struct folio *folio, s=
truct vm_area_struct *vma,
>   	enum ttu_flags flags =3D (enum ttu_flags)(long)arg;
>   	unsigned long nr_pages =3D 1, end_addr;
>   	unsigned long pfn;
> -	unsigned long hsz =3D 0;
>   	int ptes =3D 0;
>  =20
>   	/*
> @@ -2023,9 +2038,6 @@ static bool try_to_unmap_one(struct folio *folio, s=
truct vm_area_struct *vma,
>   		 */
>   		adjust_range_if_pmd_sharing_possible(vma, &range.start,
>   						     &range.end);
> -
> -		/* We need the huge page size for set_huge_pte_at() */
> -		hsz =3D huge_page_size(hstate_vma(vma));
>   	}
>   	mmu_notifier_invalidate_range_start(&range);
>  =20
> @@ -2121,7 +2133,8 @@ static bool try_to_unmap_one(struct folio *folio, s=
truct vm_area_struct *vma,
>   			 * The try_to_unmap() is only passed a hugetlb page
>   			 * in the case where the hugetlb page is poisoned.
>   			 */
> -			VM_BUG_ON_PAGE(!PageHWPoison(subpage), subpage);
> +			VM_BUG_ON_FOLIO(!folio_has_hwpoisoned_page(folio),
> +					folio);
>   			/*
>   			 * huge_pmd_unshare may unmap an entire PMD page.
>   			 * There is no way of knowing exactly which PMDs may
> @@ -2200,12 +2213,12 @@ static bool try_to_unmap_one(struct folio *folio,=
 struct vm_area_struct *vma,
>   		/* Update high watermark before we lower rss */
>   		update_hiwater_rss(mm);
>  =20
> -		if (PageHWPoison(subpage) && (flags & TTU_HWPOISON)) {
> +		if (ttu_create_hwpoison(folio, subpage, flags)) {
>   			pteval =3D swp_entry_to_pte(make_hwpoison_entry(subpage));
>   			if (folio_test_hugetlb(folio)) {
>   				hugetlb_count_sub(folio_nr_pages(folio), mm);
>   				set_huge_pte_at(mm, address, pvmw.pte, pteval,
> -						hsz);
> +						folio_size(folio));
>   			} else {
>   				dec_mm_counter(mm, mm_counter(folio));
>   				set_pte_at(mm, address, pvmw.pte, pteval);
> @@ -2423,7 +2436,6 @@ static bool try_to_migrate_one(struct folio *folio,=
 struct vm_area_struct *vma,
>   	struct mmu_notifier_range range;
>   	enum ttu_flags flags =3D (enum ttu_flags)(long)arg;
>   	unsigned long pfn;
> -	unsigned long hsz =3D 0;
>  =20
>   	/*
>   	 * When racing against e.g. zap_pte_range() on another cpu,
> @@ -2452,9 +2464,6 @@ static bool try_to_migrate_one(struct folio *folio,=
 struct vm_area_struct *vma,
>   		 */
>   		adjust_range_if_pmd_sharing_possible(vma, &range.start,
>   						     &range.end);
> -
> -		/* We need the huge page size for set_huge_pte_at() */
> -		hsz =3D huge_page_size(hstate_vma(vma));
>   	}
>   	mmu_notifier_invalidate_range_start(&range);
>  =20
> @@ -2607,14 +2616,14 @@ static bool try_to_migrate_one(struct folio *foli=
o, struct vm_area_struct *vma,
>   		/* Update high watermark before we lower rss */
>   		update_hiwater_rss(mm);
>  =20
> -		if (PageHWPoison(subpage)) {
> +		if (ttu_create_hwpoison(folio, subpage, TTU_HWPOISON)) {
>   			VM_WARN_ON_FOLIO(folio_is_device_private(folio), folio);
>  =20
>   			pteval =3D swp_entry_to_pte(make_hwpoison_entry(subpage));
>   			if (folio_test_hugetlb(folio)) {
>   				hugetlb_count_sub(folio_nr_pages(folio), mm);
>   				set_huge_pte_at(mm, address, pvmw.pte, pteval,
> -						hsz);
> +						folio_size(folio));
>   			} else {
>   				dec_mm_counter(mm, mm_counter(folio));
>   				set_pte_at(mm, address, pvmw.pte, pteval);
> @@ -2644,7 +2653,8 @@ static bool try_to_migrate_one(struct folio *folio,=
 struct vm_area_struct *vma,
>   			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
>   				if (folio_test_hugetlb(folio))
>   					set_huge_pte_at(mm, address, pvmw.pte,
> -							pteval, hsz);
> +							pteval,
> +							folio_size(folio));
>   				else
>   					set_pte_at(mm, address, pvmw.pte, pteval);
>   				ret =3D false;
> @@ -2657,7 +2667,8 @@ static bool try_to_migrate_one(struct folio *folio,=
 struct vm_area_struct *vma,
>   				if (anon_exclusive &&
>   				    hugetlb_try_share_anon_rmap(folio)) {
>   					set_huge_pte_at(mm, address, pvmw.pte,
> -							pteval, hsz);
> +							pteval,
> +							folio_size(folio));
>   					ret =3D false;
>   					page_vma_mapped_walk_done(&pvmw);
>   					break;
> @@ -2703,7 +2714,7 @@ static bool try_to_migrate_one(struct folio *folio,=
 struct vm_area_struct *vma,
>   			}
>   			if (folio_test_hugetlb(folio))
>   				set_huge_pte_at(mm, address, pvmw.pte, swp_pte,
> -						hsz);
> +						folio_size(folio));
>   			else
>   				set_pte_at(mm, address, pvmw.pte, swp_pte);
>   			trace_set_migration_pte(address, pte_val(swp_pte),
> --=20
> 2.47.3
>=20

So, we now have two sets keeping track of folio level hugetlb hwpoison=20
status: one with PG_has_hwpoison, another with (PGTY_hugetlb + bit23) in=20
the .page_type field.  I don't see a better way though.

Reviewed-by: Jane Chu <jane.chu@oracle.com>

thanks,
-jane
