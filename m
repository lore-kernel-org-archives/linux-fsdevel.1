Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB90B37AA96;
	Mon, 16 Mar 2026 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773704996; cv=fail; b=ID48ozcALseVSIFenCvTG9K6/QcPZmsrV1Pp+br+Qh1CBeaB2yGay21h3O8pfYjfLXU1xOFghhR22G4ofTLsTNgW/wnUksRI4JPPx4AaTaKCrYMo716YOpjDwuEJjZtc258cCTgQhKcBcnAcyHdivLBQ2856lq5xO4QXPFRDp5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773704996; c=relaxed/simple;
	bh=Xm8kNB7WE75BDWXzPO2UOPaPQAlimYH8KsOGtdG+SZs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ispaTrid91N5OFulT0c3Y/yVO0L1EOBK+fbUyGRT57WW1fvEsSSz0uHveQ/lsF5Muqw4QIR6y2O6o914w4Q/z+TokDV9sjHN02644Lc4BUgyLfXWt5HPDsynjy/+ZXj7Dil6KGmMaVs0c2twA9PFI4k01KkvwQzssXj3djuxSYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cwXHCncz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GgXigAvq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cwXHCncz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GgXigAvq"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GECDgJ476528;
	Mon, 16 Mar 2026 23:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Y/CNl1UMCFO9p1ghuYHjXACRzey5g6bETNx/4y+vSqw=; b=
	cwXHCnczOtaWSpckaQ3oat1qepoimqpTzaKtH4u7dNefJmyrxNAPqO1enlfuGPH7
	NhOBmAZabflPyjnxNM/UMKP5J06sGNSJySTFWDSmpkQBVWJmQtzRZfWj2QFzz0Gk
	4AFOsifgxEpCx9WiGA7AhOpfh3NuyLbgLPQaaosFWjcMgEsk+BzgoLuRCfrHbfUl
	Dty3IFTorQPz5+mfsPAXAFFRAt9XNVZ45geH/nMyZ2oLBt2o/jeZaN5pk5Gux5WP
	Ppwg6hxhnZQoHytPsUJ6wRbgdoK9nmfE1Ahx9zTTji7ktsUKnXWjzan2SKxZPytV
	3RC9xOPRzkQEX/e4dya/sQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvx8x3axa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 23:49:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62GN5W1H021277;
	Mon, 16 Mar 2026 23:49:50 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4mk97j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 23:49:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Reouv+NWbh3P3VUM0+er5WLa0R1Ir78SrShDNB6D7GEPFFWWP+aZhS7N010wDHh5mPtKEX60w2NXfhpebNMBF5a5hyJqMwpEAkKOiMveUPdlnnXN32/CTFkXh6zKxaQGOaNsNCeQkrTCR7fYOkWjPX3EA0tyZ4X3lOu4XrLN9rrXTG/RApLTCX6JIl5ozIFXqvardBbzeWImBSleass+NOVQizpq4L17RUWx9lGWxSQOJurLaRKpGQ3unCNJQ7vRn34XF65OscPHivXSPCpaqkWtOuvihe5AchfKbq4iIlEcHTj8qe1kxj1C/lstafC5rVNqFcGBUuMINIoUARoqkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/CNl1UMCFO9p1ghuYHjXACRzey5g6bETNx/4y+vSqw=;
 b=B5+9iTu2NEwCut1oix1OFlaOG1xOOWce7P+nm0RAlKwS5zXXLJKXNp8+4Rjo5Ubs9h6EZqXut/gdRSFT4vF+Nqg5979+HQTZAdnPm6CDkKsh4QVWX/NWPFuxrJHb19WxEEE6FdpUQ4ixdByPIbrG74fVHGsaujAO1jJ3iSiFKChdE5FnUYCZvIiDKOZOHm85wPreU4xC6+0sI2ac50qlv5oBB+4xTd17qQT2OoOHaKRpxtAAbWoO4LDMvC/dGOj6YgR0vw4owjKZHLDVYG4PVK6cSpTLC8aDLijm8VxKKMdoyhjJCgvNcm4su48l2RmjOqBKIg9GnuTzWYCiQL/Pfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/CNl1UMCFO9p1ghuYHjXACRzey5g6bETNx/4y+vSqw=;
 b=GgXigAvqmx8fgl5RepTNpkl/oTw9iKAeUZzh3f/R2gNxF0EycMoY1FelDEg+HD7Q6diIt14+z8d14svr5wX30bZs7PlU3KZDl8d4kfClrz/B0SJc0zK3wf0oprK9WDIdzqe9i9y5pXKfwDRRRFj+A95XEhL5iQsTgx8qlyjXzjI=
Received: from CH0PR10MB5131.namprd10.prod.outlook.com (2603:10b6:610:c6::24)
 by PH0PR10MB4805.namprd10.prod.outlook.com (2603:10b6:510:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 23:49:47 +0000
Received: from CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307]) by CH0PR10MB5131.namprd10.prod.outlook.com
 ([fe80::ab76:24ce:816a:8307%6]) with mapi id 15.20.9700.025; Mon, 16 Mar 2026
 23:49:47 +0000
Message-ID: <d84b2950-2e75-4342-b345-38071a5e2b74@oracle.com>
Date: Mon, 16 Mar 2026 19:49:46 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH] unicode: utf8-norm: fix comment typo
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316184935.163597-1-joseph.salisbury@oracle.com>
Content-Language: en-US, en-AG
In-Reply-To: <20260316184935.163597-1-joseph.salisbury@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR18CA0034.namprd18.prod.outlook.com
 (2603:10b6:930:13::7) To CH0PR10MB5131.namprd10.prod.outlook.com
 (2603:10b6:610:c6::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5131:EE_|PH0PR10MB4805:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff148cb-cdaa-4372-543a-08de83b6b4fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TvtYkSGYP0B4M2RmmNFiNqrymxPXyeChMSQjzGgyFsMVxyC+k+2yNO/fgwezbEt7YLG6eKFHDyYN4ukuMgtSHoC4wfM49v3XNRHXnJOq6ca7lFu8dMvW2C4GuDtmxk8zndMBOaRB2oFhU9MOQ9uedP/rX8aowDUCXFtJujKiYK6Fu6GrHaHlB5z1s2vI+EVh9C9tuk4oi4zzNieAM+HufnY9w/d7haNSJHwVRLrL9aF6MaZchJt2pwrFeo4BdMriaY2RW7KpH21Yb+f5RyyJCe/OPyxGr8s9g4RyvqASBGpGW/lI06GB6Bcqpv0zss/IKuPaHBXphpPQLLsWjFNvxMcahEItCfSSRzm77QoSSmVbZt/SrTKB+DbZ6vISaE5aPkmL0EJBSwAxBk/BLHNuO84OYuPtwoJuQU/D/yNnnkfXHucJ0mnq0laEfxWNOOV5ws1iL05T8MsO5hhtGyersclSPokXsC2BE1Q7fP13tacqWFfDKNlz5Al/xdnxCgG5oY233UKR9iPY2YApf3udVycfkk93YsJIt5lSXAGmALycib9NSxOKDOa8cAb5Ns4I/zZlCKx2cm65sCvSqh8mKu1Dw43krjfP0yJZGSn7DN8BfGYWY1+QYx2P/F9ErO3hTCW0gqdYJzZ06KAlAQtgIN3t4yCdkktRwq+FLkyIAj/q8DxihomL5E5n76eTKzdOBsfN54iKDCJoYmdC25Je1XbIwdJwNLwQqjeU7FB/ZL8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5131.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGV6NVdBTkc4aXhhVjVsdXRLS0RJVWx1YXdaelFVWjNnRm1EUW1uOUFIVVBB?=
 =?utf-8?B?U2JwK2FhQ3AyZHhkV2NCNHl2YmVQUUQ5SE9jMVVUckRHaGVLeFhNbmNVc0lo?=
 =?utf-8?B?WHZOWCtrOXZGOEk5SCtsU1ZFTlVRcUhma04zTUpLY3k1UTFsTjlCaERCWWt0?=
 =?utf-8?B?emsxVUtvTVFUVVUyUVBFamx0TjBaaXpEWkdNSkU2OXNFcmVPRWNGdTB2dnNo?=
 =?utf-8?B?M0YwT3p4ZHNabVZPd002ZjY2U1huSnpYTmJrM3YzVTFKU21EdG9DeEQ4dmhC?=
 =?utf-8?B?VCtMSDJmR1lodW1XcG1JSlpERVUydnZCMnd0RlRqVEw1WmFzNHZvRk5ycytq?=
 =?utf-8?B?NEhZMnlHMi9OTXd6QVlxNW9PNnNRdFZVQU9XQmltcWR1U042QjBIVzdMUm90?=
 =?utf-8?B?NVQ2OXZwRzNHOGE0S215NXdGeU8xbVE1RFdmdEdvTTFjUFplczVzcStCSDV4?=
 =?utf-8?B?aGRJMHBmS2ZidXhyN1dwc3o3eER0dnRTenRub1ExVW9WNDNGQnBUNEVFTXNU?=
 =?utf-8?B?VHZvR0k2L0tzYm5taTBUUFdOdVNFOGF1cnJ0eElKSG10WWNYQ1ZodTJpU1dq?=
 =?utf-8?B?N0dHcCtocDIydkR6dnhQUUcyeVI1R0lQdVJRbnVGRW14dlEyb3JPYmM1dDFB?=
 =?utf-8?B?RWl5OUtqQkVDVmxNWHdxR2F6TlpqQy8xSFF5NWlqNWl3eUQwbmJKQUxuTHB5?=
 =?utf-8?B?SXg0OVBWWGN5UEpHRGQwUFhjZWxveTlYUVdIUUpESUVocUtLOTJqa29yN2c4?=
 =?utf-8?B?cXdGdWJFajZMQTQ3VjhzY0g4MGJ3aldTZUxHeHNSampQL1pjdXpyUlJSN3k2?=
 =?utf-8?B?cThUS2gzWUxyRi9HZ0xhaWVabVZHWWQ4TUFDWDd5cU1ZRXVuMWVreWw1NE4z?=
 =?utf-8?B?VEVTVjIxN3ZuTHcwWVFBWEdhWEc4d0RDRzhDT1ZqVHVtLzFFa3lKT2wvNyto?=
 =?utf-8?B?S2VxMEpQNEs0RGszaWxBOGtwcDQ4bmRWWElEZ0dCbklyTGVheW52UDltNis4?=
 =?utf-8?B?L0xBZ1VCTElvb2Y2RmlrTFpGQ25KakpuWGpsdFQrVVQ5cGI5TU90MDhxZzNq?=
 =?utf-8?B?akxMOXNsZ0o3Z0Jpb01QKzVrNFJVNC8vK0VPdXdGbEp0TE9IVVJ2dDJnbVhT?=
 =?utf-8?B?RmRzU1kzcEhKRjFaM3BhYXkvRW9lQWhDRjQ1a1BHU2F3Wk9EeGdWeTVuM2pJ?=
 =?utf-8?B?d3RsUEl0OWNnNDVuTnFrR01Jb1RNQnEzMmhDVWdTNTZTYXZUVTNaZnUwRUdz?=
 =?utf-8?B?eXd4ZWtDMXBNS3VOMkcvN1M2QTZaV1lrVStCejhWUnVCNkhyUVU4bmMzRnZO?=
 =?utf-8?B?enMrL0hKbEFqbkhpaGZwclJMUXVVUDliMitGYmpvTkhpV0s3VUVpNW9yaDlY?=
 =?utf-8?B?ZEN6bGRRQXdNL0Fpd1FpVE94anQwaks0WkpqVGV5aDBTNXNKTmV0MjFhZjBh?=
 =?utf-8?B?Y2Zhd3NjMUZ5OHhrNGVGMnVuRVdqNVJXQktibHdZdGJjNUhUVC9DK0tWbjQ0?=
 =?utf-8?B?a0lMS2hQeUgwSlNIV2lCZUg5dmoyV3Y4MWJWMlA3N2hlbFJaMjN4WDROME13?=
 =?utf-8?B?T1BDbGRxcjZ4Q0N0WXlpMkpDYWxxeXNnbEcxZW9PSXZRcUpXSVpCV2d3enl6?=
 =?utf-8?B?R3k1QVBiZEhyYWV1aU9IckF2T0I0ZVhRYURYdVRraHlVVzVScGkzSWZiV2ho?=
 =?utf-8?B?RVptbEFhczIweW5ZdGdXRFlScGpITHhqZDgyLzROellZaU9XWTJVaHV4dnpN?=
 =?utf-8?B?ME96NmJYZnFoT08wNk02cVdYR09XSjJMb2htMGt4M21UUmJkWFF2cUI1b2hi?=
 =?utf-8?B?UkE3ajlGc2xnLzRoamNEb0x1eEdwRDV6WDhOejZaRGRDQmFTRlhNazUvM2Ny?=
 =?utf-8?B?R0IwQ1M2U2dOejVITUxGVUttb2JvM3p5MTk5cC8wRGtHZldWaHRiSUxZZGRx?=
 =?utf-8?B?ZFlVb3N4TDJpRndBOGRoTVlZWXZkUENGR1YrV0hWRzZhcjRIdERLaC9aTUJX?=
 =?utf-8?B?M3ZVNktVLzh1NHMwUGYrS2Y1V0hINEJMYklEMGdOUUdhMC9UV0NmckNzWE41?=
 =?utf-8?B?U1N5RnlaQlVNMFBWRkpmSFZWbTR1MmZWMkpvajBramhTeFVUSWNXeUNhcGFa?=
 =?utf-8?B?U3lvdTd6UFg2UExHd0ordnVhekk0aURaSittdGZHMVpTTC9OdmxjV2JZdnJN?=
 =?utf-8?B?Q00zSG1PanliKzhEZEFrVUIzdVhtaUVrUmMvZGpDWkU1NFN3a1dLOXlIZFJY?=
 =?utf-8?B?S2tMY3ZDV0VSQ2lsazRvcGQyRStoK3M3bk9KWnJlQkMvdm1oemdWUzErd1NF?=
 =?utf-8?B?dWpPcHlXU0sycGNubGpEK1pSTTM5UkZoWmZHdGM3NEErVmJjT3F4UDFPL1JQ?=
 =?utf-8?Q?ylddvG1mrK4R9pT0=3D?=
X-Exchange-RoutingPolicyChecked:
	v5rRF4Q9AutUB6FPDAl1OW6xbs0yZwLcApIAEGDU/IDDMusiwyO1d18Tco4TEALuRrqv5eG3z8z0Jb0DjgM0QeXf5VEUUyfbCMwICQ7V4+ZVDXdiVaUgsKa/2qRwSH+uprD9EH0gUiLpQk6luOJ8FNxLBCAma+jpHG8xok3YChn7iLuyzzYqoZdt3IMgnRaL2HFnIFJFVrspVdT3zA0iFZT68RlQXO4lw+9IjBfVrvyXoyg4D8OzO7KO0Gn9e6zBYkmwwzJ+J4VCCnLeaLmT6pev6iLjhdJL/ieaM1sf6Ffb+ryYY7m0Yk8hKh5ocOmweUHIHWl/YrsWxkN87RloTw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4RHT29+nSfC8LneWtGC1LLmUZ+0Eg8tAz4d6i5hnhB+uY6wekRJxbDlHRM77RQwIQ3PRqItytfeP/E3MaD1EhqG5kvjOr18hbgHOeAlbYVRrtDU6JUVZgFfQ7n5UMDezKJb4FMOtw7kwqJ2yw74mmoiQK4TPHq+pM9g9T/tcrHEscFX/QWQYz7q4FawIU1dfdsYNJ/hOx1GX4RrGyG6GDF7vJfQIFIhXCGv0XT/Bx9cCVL7/ExdTH2vATGH//eQ7V+6w0yrIt29KiHqCuh7rYWaWXdRymetBZjk0kDeJf6npPWeabWOedigeWbFChXaeWaraX/QbLvs1wOo9X2WgH0GbNa44LukQdedudiEeoKCeaTkkT/AFEh3TzySWhrgWKGoM1YXoy1pGN8fpF68PUZgfSxyaLMjOQhipZ5OoTMwNGBkyqn4w95FbVc0Gy2tWIzei+pzf7IxBT2aRewAccOJO6x7o6jxXYT0DUfOvnqK0oxCYxVqMUaqHv0ld2aPlwKXQP+FuQWYnsNSVff3cXnyUkar5/KEiMmxkJcS3UAG/Qp8AdSV5SyUg8SB/E/+g8kUCWf691dsYWr5RCvlII25hGEup41tEFu6SAF8Rcn8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff148cb-cdaa-4372-543a-08de83b6b4fd
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5131.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 23:49:47.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4KuRNuzPHa3pMSROsJEo1X/Jfy7OQDd4i5jLb6NIypSYikqewIGoveoOWO36Hl8L0nVA3p8FWjJnYeiVfyzYNeT0Hm1BC2t+/5oo/vVQ4UM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_06,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603160197
X-Proofpoint-GUID: EyfLmcOyfVN_x0Ca_wYqyACcpefaHdIA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE5NyBTYWx0ZWRfXz0H/qzy6YDlR
 CAAAst/HuOKreUruGQ37fHvlr5lgvl+iJuyNtj5xJ+kiLztU3y2pcOXrx5yZmjsv4ZIf6K0hi3i
 NoPpcMtY75BKOPsTNDp7kNK24Vaidk6umR59e3Vh9tp9lCKM8ODGjdd9AvlTUo0if1Vdm1nfsyV
 I2fpDfaQXYkv9LIfbiABokLZXwGa3HU9uKUWurY8QFzxZbM1UaT87sn178Lc8bOdU9dDuCSn/Ix
 qummg4QmSutSuBLwVbxAU4gIcCZll2LO+qbItNJJE7bqvPsqk/o+PJQlJF5iUMXAkC86YR7n4LU
 E0sqGrv1osNWgIjQkeWU9B2NFXQeAjVCisJfe6xpWNeueUWOtemtUT25fnt4IazV7d3/9WItrnI
 Z7J3vm1SoOHzrkkGcuGfVnS45oluvIvLnUuJM1D/8M/DGeCdpG7n5HmLDTsCWHqe++yUsqNjllC
 jTX4FsfJK8BAK4IwCfkem+e+hD2NzlIvWE2pxGME=
X-Authority-Analysis: v=2.4 cv=dJmrWeZb c=1 sm=1 tr=0 ts=69b8971f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=4EuQdLICr3JgQ-1d--wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13824
X-Proofpoint-ORIG-GUID: EyfLmcOyfVN_x0Ca_wYqyACcpefaHdIA



On 3/16/26 2:49 PM, Joseph Salisbury wrote:
> The file contains a spelling error in a source comment (succes).
>
> Typos in comments reduce readability and make text searches less reliable
> for developers and maintainers.
>
> Replace 'succes' with 'success' in the affected comment. This is a
> comment-only cleanup and does not change behavior.
>
> Fixes: 44594c2fbf42 ("unicode: introduce code for UTF-8 normalization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
> ---
>   fs/unicode/utf8-norm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
> index 7b998c99c88d..41e884569dbe 100644
> --- a/fs/unicode/utf8-norm.c
> +++ b/fs/unicode/utf8-norm.c
> @@ -444,7 +444,7 @@ int utf8ncursor(struct utf8cursor *u8c, const struct unicode_map *um,
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
