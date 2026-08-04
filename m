Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7512934750F
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 06:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826018; cv=fail; b=Dp40jzL71bCwM25sudxO/s1XWr/Eq+yl1lEDOxCZNj9EbctAiPqRkeubgNXvpu36jyGmXeE3KT7v7okBavLV2NUhfoDAvK2ndZwcvLO52/ABJ9WFePKdXJm3EQkKREzGNslvat8a/DQjdOcM5aoJuNRzNx7UEEwDj+X7lsoOfBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826018; c=relaxed/simple;
	bh=s3NqkdOjWhpsHZvyhdzg26E+Yr+JrQbntOtvm1Av+E8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=Cl+PM/AMWuAast7uEVi4WENwyOEzsOUOlod+92tZ4r8pzXn1G0Yw4VUJk+LUM5qjiISCRUMfT9WSO7iKHWVQgRqndIcqNfFPwy4vLVLN+x3FrpLqaTUWfvnZriSV3Belwci70kCNu4bjyFx7f95cJKVPA8YhuQ9kICmLZ67BUek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l3KRczXC; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u2M4t0U3 reason="signature verification failed"; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l3KRczXC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u2M4t0U3"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673KrhbV2744515;
	Tue, 4 Aug 2026 06:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Rx30/0bmauQ+Q2uZjX4s7Z7s20lHuc84mvzSdc7oqKg=; b=
	l3KRczXC4t0Rn2xFDJH/jDNbSSC6UDLjAKX/1JBrFZVcDkcYJVAN6A2Qc6mtQn0D
	Tt4RtPrIxvabypyaoyw7mghpwehuWrLad9gkZmGn/EJDIflQBax03sIAEaOrfUGp
	vu/5v3WFtpLCz/srm+M2sPJ4ud6VwVyqfR67e+x+L+mieBZByqzYp9mleBkxv1SX
	YKjhhbhDsf41P8OG/km3Jt/fjQt3XzjYt+4j2SdIe34DoOP3UtOJBzxAvVpI7D/t
	MP/LAnsTbi6mohgBB3G5q6n9wWPga050b5Wp9KEBbiiK8JrYwCY4qS6s0c6IMEsp
	1jnKpWsgspLRxzxAwH9PYw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs7k3d4qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Aug 2026 06:45:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6746jefa018838;
	Tue, 4 Aug 2026 06:45:56 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78srb8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 04 Aug 2026 06:45:56 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1+C1WWdUCpy3Crs6tp651tXlEmb0oVaLCixOzJO0Wh0OwSH26AF1PKF2GpRUKbQT9VC2Scqp5jCjzkOafM+hNihJ03eyRF8ZA2uy1lBA2uPnZi8Tdzglm4LoDlWvNHxCx6FgMZB6jjHBO3qUiuCz9F5V92fp0yJANpAZqOCagkPW/xC0iLC3zKppsuFNlLRaKqBdhbwWUIMmkupAGlHCMfJTDz0rJrIdIeyHFo1ruQPwZQINcBgQqiuy1zUnO1y7tECIvyXfJixYhJ6ojIo3roQR2FIaO5EkqUGPhfr9R/xf3J+8nrCsLCEx+/wEVdDmuywawpYyTfQw9RuGM5AHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bp5uVdZa/Hf0wWE/kiTbFkUrmkZ37rU09Gq237x/ePw=;
 b=QCwVJ8IqiU6S7xYrjP2FAQmVH1o7crMeQjJ10+jzPVQOBbY/qHez6k/fUPpO1JDWfNnw5ZqtzcwRExju4iUkC7h+be5c0avGcWMaD0ozwA67qZ/c9dCB8uA3/cY5HHVhh65G8oim4ZUP46nYNEuBNPKtkmYvWoYOTId22pZbafEY993lpDnhbTriOCORolk2cpfw79WQUfib3iAJcJJd5GjWfT3T2tl17XfHtft9k3T1XaVcxBd1Fh9sClG+EyA1kvut2M/9srdOS+WX60L2aL5ovgAPkMuTyAgpJ/Mjj8ld+XGWCIg/iDoOfxx/3yXVaXLnnJaplz4qa5nuTvhf7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bp5uVdZa/Hf0wWE/kiTbFkUrmkZ37rU09Gq237x/ePw=;
 b=u2M4t0U36CdHSSOtwroqf5JPlNgw9Lfk5NSuGUhK9Swt2OM4ykEjyaBe1mgIZ547NYiJ6Orwn5wwvrCIur2nymDUb/J64hggn0V99lluMi7k1iC7ngt9a/IxsJgkJgor8Y/Hs4Gqf+XOg6J8Kwny5Yk9tzA8hsaMnXb8vozC3Cs=
Received: from IA0PR10MB7369.namprd10.prod.outlook.com (2603:10b6:208:40e::14)
 by SA1PR10MB5735.namprd10.prod.outlook.com (2603:10b6:806:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 06:44:38 +0000
Received: from IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e]) by IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 06:44:38 +0000
Message-ID: <7a72bcaa-06ed-4485-954b-2376f754eebd@oracle.com>
Date: Mon, 3 Aug 2026 23:44:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/15] kpageflags: Use is_page_hwpoison() to set
 KPF_HWPOISON
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
 <20260731200802.574821-7-willy@infradead.org>
From: jane.chu@oracle.com
In-Reply-To: <20260731200802.574821-7-willy@infradead.org>
X-ClientProxiedBy: CH3P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::13) To IA0PR10MB7369.namprd10.prod.outlook.com
 (2603:10b6:208:40e::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7369:EE_|SA1PR10MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be8f7ed-a97d-4b2b-2f9b-08def1f3dabe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|4133799003|4143699003|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	X6MPSVClkDlMUYEEz7eTI1Gxo/jgVpm5u+zIthEXH+0HQwxkIBsgxmxQu31nKSb4cmJWgAn/7t0wpxocSqD2M0iPxLKUatNLHKybRdCQHSSxzgJbp8t9Wg1CDCXc2R1SAWsvjiTiEilontzgg6mZLu+44A53+R8VSqp2yclSx49Q1PqQOVf5AV8/qoTmeWGJl/eixsAvqMaXoCimJGwaqpGOtU4Eb9vyLUlne3FVlVFpgnq010h//2VJEcoND599mc+d666ApiKUTfl2IeHAqD509JQBX6TKQEW3X6/1SH3Ah7VtDwLgXg4I13vAWr6o5J1b9vXGj/XtIyKbcqNri9j3NU87wbL9zbM6Gh3o1P0JRJi8jQ3gRkcREN4QOslZwuWINh9Nt/f7wg0Eqlu7xmF4niO4Ax6dGR9qIwLZV/jJBEUwQBEV50/BHuU4XDwpfryZz4EKZjSfz/xUhLKZ0ii5r+Y6fgNV+C3pMmJEaQpFNwK+Ya31iQRHq0WZobldR9HHnt1f9Z+UnZtio6RMge6XgJ+YjVXjlaUc+mM5TkpAzaiUfVB1Z8bwQ+Lq/NeFf9LwwIKfFbXx1TxE8AjnbTYTIjkn5xG5Sxha2VvpbwtQDxQXDef2pRYtiXuxlbBd0PiRtqHXWnL+1zbB9nzrAsmbqQzL2cUBAKElS/yO+TU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7369.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(4133799003)(4143699003)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b21wSHE2elVxbEU1MEpGNDhKbjVPdzFITTU0RXIzdWVBS1BYZ1pKb1RIbnJm?=
 =?utf-8?B?MHRCZmExWWVmZjRRU2gwd0VoTThjVFhlcFdWOWdYcm8zWkFwVXp2RXprdmZW?=
 =?utf-8?B?OW45UGt5RGs3M1lxZVU3YXBJSS9aWXJ2Mjk5U0FNbTBVRFFPRUhnei9Ld3Nw?=
 =?utf-8?B?WmZnVVhhemNBM0VFbzNoVEFHWVdHM3lVcDRsUWhmS21ySWlDTTI1ekJJbjQw?=
 =?utf-8?B?M3lVeFlGeG5uMFlrMUpWMjNXT1NqQ3dMcGF1bEJ1REtjOXN0aVd2Nk9wandx?=
 =?utf-8?B?MUN0b0pQcmlMOTdqbzlubjduRlEyVGgxTkhzSDRId2k1RDdHK1F5SVgwTlhY?=
 =?utf-8?B?OW9rZ1FDNnZiRzBscDNoYkk4RS9CZnBsb29pNHBxQXg4bTUyZ2pWcXUrY3ln?=
 =?utf-8?B?OEZzcjFOb3NueXI4UTM3anZtYlFVcHdjcXZOOXdnbHE1M1JrdjVkelYyRERP?=
 =?utf-8?B?QmpYcExFcVJXZ1dpN3p1TUEyV01LNlZMajlnNUtMVER1dVpHVXJtRXVIRi9n?=
 =?utf-8?B?YzdLd1ljaHRZVEExanlRQTBsdlpKOVd6bVZ0RU1OUzE4ejBRZk5ETEU1SEdt?=
 =?utf-8?B?RjBOVWRhYUZ4OWs4akhZUlgwdnB0TmE4M283aUZJa281QU9HOGVmN0VvTjNV?=
 =?utf-8?B?di9TQ0c4enBWOXU1VkxjTm8yOWdNSkVtNGdIczFFUjM0WllJOUNRMldkdG96?=
 =?utf-8?B?SUM0VCtCNjVGMHVNaVRZUzlrSFh3VkxMTzVkWEkyOXFqaE8wdzhKV0MyYVow?=
 =?utf-8?B?SElsRWdzdEJKRUxUc3gwckgrTEtUc2dBZE00VmVXN3VxUEtZdWh4c2VNOGQ0?=
 =?utf-8?B?QzVtL3pSditEVEg5NlNYcllKRXN6WWZkWnI1QlJNaUZJdHZpNlV5NmpJcU50?=
 =?utf-8?B?dDNvZ3RveVN5U0NNZkh6bjlJWE5RbkZDY1JiZXNya1hYMEhkT2FVTmlXZFdq?=
 =?utf-8?B?S0ZFLzBiRCszT3NFM2E5MlJidVJGNWNmTVVtWVVpcG1rK2ZOUzR2ajJmRFdh?=
 =?utf-8?B?RzNyK2dlRVNYQXpCVFhadVBBQVR5YTZkdnB2aFUrNithdFYxYmNZdEFFaEQv?=
 =?utf-8?B?dk5NaHU3TmtFekdKQmp4eFpOYVBCR2tqZVRvRnhyTEV3MWo0OGVBaFZ0NCsw?=
 =?utf-8?B?ZWFWQ1JRdlZUaG8rbm00eXhZMDBuOU9JUGo2TzNjUm10cUVkcWRZbnFKWU40?=
 =?utf-8?B?MkxlN3VXVlNpbTJ5SnpZMmFWSkFyelFzdU9ZU0YyWVpUSzNUak84NktUNWJF?=
 =?utf-8?B?UEZLRWtDcUZpcXpQV3pOcEQ3MjJHUlFtRFNTbGo1aE8wUmpRU0hvSkJQenJF?=
 =?utf-8?B?ejJubEZCbHlwaVpVcmNxeUpqWi8zTEFQc2RNbVFNeUhkbmtvNFNXNmZkU2da?=
 =?utf-8?B?TkM0czcvS0VTMWtwckRPNm9wZ1E3ZndGODMyMWdTOWN3UWFhY1VhY0RrOElw?=
 =?utf-8?B?c2NlWXVXTnhsbVJNRTM4c2tUbTBVdHBpQ0pWcC9XQnNGeldDbnEzVWdGREtC?=
 =?utf-8?B?Qk56aHRLVWdNM1lxNzIrSkc5aE1lVWJKQStCL2paREhZZjBUQlVLVkVWdWdF?=
 =?utf-8?B?a2NablZFWTBNN05Ga25POU9rQXN0VExZaDJYOFZDOFRVczhpdVArTldwU2ox?=
 =?utf-8?B?K2c1OG9rREV1N0NxdTYvdW1SUStHaDU3NXc4Z3VZcFhBTE9ta0xSV2lSa2xT?=
 =?utf-8?B?TWlQWXU5SzRqb0JQNFF3MTZNeFNTVjRRNVlOTDAvWGkrd2RyTnh1R3hKZGJK?=
 =?utf-8?B?UFZMOU9iS1BFbVhuVE1QemppTndGckM3TTNzQU9JTUNDVlZWd2pxVXNlME5Q?=
 =?utf-8?B?NTZ1cTEyb21mQkpHcW96Y2t1elhrcHhMVVJzcUdXOGJ6MGY4Njc4MkFZcnll?=
 =?utf-8?B?K0tTeEpnbDdmdEVkNVlHTWVvNktzSlRCUzhLNFBCTVdiRTZBMUVZTUZNMFpD?=
 =?utf-8?B?MkVveEhwa2ZDNStmUGNVVTY4UldzUnVUaVdLdzU5VzZITGwraSsrWkZsUlVF?=
 =?utf-8?B?c2t2ZTV2d05YN0hCOUMvS2liYkJSaUV0TkRwS0hPQ3NBblZ4SUpmU08yYVlZ?=
 =?utf-8?B?NUdhbWVwTzhqZ3l5aE11R1ZZaERBN3MwT3ZZRWNXL290OURHVWtFcWtCREVw?=
 =?utf-8?B?UW5iK2M1dDhXTWs4TTh3MjkrRGlHc0t4eURwbXhjMmRrWk5XYzJ6QzlwUDNn?=
 =?utf-8?B?U0ZFMGg4K2M0Q1NYNmxDSjlYMHU2d2Q0YitQa1IyL2FWdVdPRnl4UWd0YXQy?=
 =?utf-8?B?TktoSGltbDNVRnhaN0s2ZmZRMGYyRWllQlYvY1JPLzZGckZvcmVlbmZDVUJv?=
 =?utf-8?B?MjJZWnBubUxDN2JlNGZtRTlVY2Z6clY3MFpIanNEQUdURG5ndCtpQT09?=
X-Exchange-RoutingPolicyChecked:
	lGPVOFDPmbXWBZyYbUqG14iZWDPAlkOd4tYW50pw7AKofaJghX72DVKla5Iyn55F++D5UxEb7eh2XCGYYsizGwgEoLx7wQb4Tx4Uf0gqpuerfsByryIhBrs1usXvpFC9EHEArZvDlkxzHHnGAqbV2dvCH95rl5Cmzblt4FaIfCZCAx66cCNkWBZh6v2XjLOezyA4TB+54nAWCQ+ITsz31Fwh19UEJIqZCeQG+u3emyEOMw6LlTAFQPRalATpqO1MYxS7wLQtK4s/t+teAJkTkj2FH7nSOU+yu9H865TrUKIUra5UGf/pPwglq5Atgn/fHsF3jXxQW9Vsb0tZ7vEvqw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZKt5PtVHQx4HvIOgmuVLBfpwYrkJmcsnpjJgFzCXOzIQjhxwpCVkbtUiMeRidUgvI70Qa9pd5gM3kil45pgWDeqUOkJh2Qjpgqttj7zyC2rcicc5Dt9x/UcIxKbOBuHbKu0pgfo8Jzgt31yhWVSiqnraabhGVMip90MZNI0i69Xr+pW9GsFyClZYQZrEL9YVz4YLYSYamNPBH2hfQ9fPJ3Wfy66bWVOcQFNtJduANm1akdtFKkXMGwrcb/PfPqox7DLYDKq2wjs8a3qJznut//C7Xyt5pNC4IGjqTxY35p47NJefAA4fsp3626fEyxV3EcBhTjsk1RqO6BoZ1du9bQpy1vQICJj1Wpbqqo4g1zkWn/mn04FKPkwj5gmxfnqwvR8enOAYwWeuWFSZ8IJ1PAB1lzNPEcptewsOsGBinkZpdVDKusvdjDFu1gpC7XcA0MTT+qft2TSN/w//AX1B1X1/vyoDnRQ1Wrc0AfQrrET6MnQ+CaI8Ox0WJuyLPWF8BzZsly/kN4QggLdGZlO5W8QNA/8SlCsEzZpV3RO+mbY/B3/T4/UiSYEGiBZJhu1mXvcCWBxLEJEpsDSPxrm5TkDldmsFtFRgzcP+s1puiOA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be8f7ed-a97d-4b2b-2f9b-08def1f3dabe
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7369.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 06:44:38.4466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOlReXpqwO+w7fdj0MXWA9e+CrhO2WP5yr4yU/E7I+vtioJfcUIBLSIrJRXtnE5KsbI/vlW88BqbWMKQKqc41Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608040052
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: xA38flihsx3V8u28kyXwker6DvuS9o2c
X-Proofpoint-ORIG-GUID: xA38flihsx3V8u28kyXwker6DvuS9o2c
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1MiBTYWx0ZWRfXzRK9/6eoQsSA
 fwGq/Ve02jbPT5twNgy2GKgdTDig4Qrc9OKWgLLlu+TT142ghJsFjclHXWaE9Am2bNSqntOxtEi
 Wz0AeLNSXqi70DNdAEMfv69OArdOY05QXI/J1F7/tZS9QvHjr/cO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1MiBTYWx0ZWRfX2V5D/Ib8Lp42
 7z7g2cN4L5sSewzA+bkcWjFhAWOaBBvmUP/lGmqtTzXtdQgEKTRIrJuiumX0xL5Iurkt7OtMDP/
 uDjh87fSow7coqzabcFZax05KP/SxbR14FE/mGI/ww+5eKSh1z33d5xepMmNFX7sCKY0KE1G/+Z
 D21uyVpRDhFCq/psq5m6kjmMB8NK3OMY6BsG+5Zp2375+gf5DUJPsGdPL4rQTiPXoB3wA8uyGUi
 ljkJADfGJLz3pmVHq37JT4Clc1jqRP3UJjiHyL76GsJaz+NOHcYMxLwI4E2TMxMFBTYXiXhY1kA
 oxRs03w7q/khxpji3+2+11XYx4YOsxrGfErGDI9kFj0ojUoWNpytAQqAYs6ygakOjsy+6bI79mS
 nHc75KVohY6mZ5G0EDW2NdITD5yp3C6zSsAydsc3iyQSgXUCXh6aL2WxZ+NSwZf9wMxrq9mR+4K
 Rsx/VogP9zBRO7qJVUBRrzbUYFxD/MWcH/8sTQ8s=
X-Authority-Analysis: v=2.4 cv=Iqcutr/g c=1 sm=1 tr=0 ts=6a718aa4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=RpNjiQI2AAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=q1_TV8Iov58YoTrHkcsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101



On 7/31/2026 1:07 PM, Matthew Wilcox (Oracle) wrote:
> Instead of knowing how hugetlb handles hwpoison, just ask=20
> is_page_hwpoison(). This gives us the flexibility to change how hwpoison=
=20
> is handled without updating this function in the future. Signed-off-by:=20
> Matthew Wilcox (Oracle) <willy@=E2=80=8Ainfradead.=E2=80=8Aorg>
>=20
>=20
> Instead of knowing how hugetlb handles hwpoison, just ask
> is_page_hwpoison().  This gives us the flexibility to change how hwpoison
> is handled without updating this function in the future.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   fs/proc/page.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/fs/proc/page.c b/fs/proc/page.c
> index 7d9387143435..28c9a7b724f3 100644
> --- a/fs/proc/page.c
> +++ b/fs/proc/page.c
> @@ -233,12 +233,8 @@ u64 stable_page_flags(const struct page *page)
>   	u |=3D kpf_copy_bit(k, KPF_UNEVICTABLE,	PG_unevictable);
>   	u |=3D kpf_copy_bit(k, KPF_MLOCKED,	PG_mlocked);
>  =20
> -#ifdef CONFIG_MEMORY_FAILURE
> -	if (u & (1 << KPF_HUGE))
> -		u |=3D kpf_copy_bit(k, KPF_HWPOISON,	PG_hwpoison);
> -	else
> -		u |=3D kpf_copy_bit(ps.page_snapshot.flags.f, KPF_HWPOISON, PG_hwpoiso=
n);
> -#endif
> +	if (is_page_hwpoison(page))
> +		u |=3D KPF_HWPOISON;
>  =20
>   	u |=3D kpf_copy_bit(k, KPF_RESERVED,	PG_reserved);
>   	u |=3D kpf_copy_bit(k, KPF_OWNER_2,	PG_owner_2);
> --=20
> 2.47.3
>=20

Good idea, but agreed with Sushiko about the bit setting issue,
with that fixed,

Reviewed-by: Jane Chu <jane.chu@oracle.com>

thanks,
-jane


