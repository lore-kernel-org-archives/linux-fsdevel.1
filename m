Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5348533A9E1
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 06:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826136; cv=fail; b=GsctCtCm3hIjYkLO6zH/XPwZ1+Gc7NxMfiWulQUDmjkT1NQy+wNKw/xaXZ2cON3uY3c9NXOwqQOAP3MjJWQ+/gWWkkWhYCMTYoVmFsmbeVzmsbmCwbFvAF64QQF2Uq5lXJNnKe0hj2NiTcbWIYZeUEeKun9mQC1RsYhhEJZ0PhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826136; c=relaxed/simple;
	bh=BHFsKFB853n5EWaNgsUSzRneOn5dTxJwtl5lqi9T3jM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=ljWdbI42r6r8mTOsk9VadBnJnu8v2DOX/KoXpaoqhICvwVvOL3824AN6OCxpbSO3U/MTmbu5uHC+TVgrR2K8aj7CG9s0/MmxzwjFE80L2sbz2boeprG9j4Iy66fqi2pHkNHezK+gRyNEG9af6tow++3lVRWHENaHTt03+Y554w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rgamChZu; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XkeJBzds reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rgamChZu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XkeJBzds"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673KwbSE3099061;
	Tue, 4 Aug 2026 06:43:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=60SxmYVZOaJmXDzsN/Y0fxahE0yFwcAtianV7VwF7B4=; b=
	rgamChZu0FGtufVcGgkYHUXAJ0Bc77r4BP2oTh7oXidIPSPnSIC4MVjbWvDK/cwR
	ZIJZKOIQ4Df5avSjjrvam5bzOw1YYQoAwzlssSd18RLybGLApboAYUL/WCpC+5yr
	h5YG8zG34pGpPVjiOzDbg5XWq5JsLGoXGoMVb/85crxG9g8rDPyZdQYp/61TGL50
	Gbmm59WeGcIcJariXuX14l8g8nhCy6HlNZfvglgBN6v1CxDeQnVD+XNGxiNtS++N
	399JUAfg/hji4+K3wQ+6wVVJkYg693RGtIatt2IuDSqiEZ79XM366SbImB0HjpeV
	zjupijxSn95M9wAljVDEyg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs7qa5cbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Aug 2026 06:43:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6746eWB5005078;
	Tue, 4 Aug 2026 06:43:11 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78sr9dr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 04 Aug 2026 06:43:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pR3IjNM9SGC7PAiVzvE+R4Po4VOMh9NN4TOBQgOT6R2vYgJ5MvlBdbYd9gyid1sacaMNft4ThASgp3Zv6Z/ZoOSJn0DfrE3WonYIOJBGAjM4LC4u2Oz6VRNnScq+e0lj1TeyjCFQO0HjPiW7jtTKuudXIia5Zx0CqegJt1+6sRuwvn8D7ljFUI10KhJAnOqWkCB1er3ItjeFFzDwocY8GV8hwWikQgSjdTs2SW1Cyv8ZxZAyYF/eThxJx1pdgdvOPsyCk3tOnhIoqdHUUOx75vYNG6gahnasHTZiZAoIODdif57GeSG4NVhNUI/VZJpXi6X1ZCMDdgw7RFKyV5NyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+vK6BObgS64J/jKMZUB2VcHEtGD3MElRFrDmq2t1Bg=;
 b=iDcoGqUcLWXCE+Uk2rFSJlBuiwiCwa4hH/44cPdHaqKPuJQBbV4luvc/PrjhHwxPaNA2UeI0qgWILNB6FzMCF0sXbIanlFers/Zni+s136etGuM8wl04QoegEjCa2BuSsjiUYHqHLwyOidcSnb+Foijaqul979m8Ogdqv2jHUSOaH0dhYMRicUYqXfA4aYQJlbGanIqgUNFpeZVpDWQkljUEqb+trCUJKWaKc/5PmONufHs0XpSDjWGyCOL+NeZyAh4R0wdsb7TID4gnJxmX7qPxDXQzNcBEAPV3gP8uxex8ggwsmUp2HDUCgxZeh70CTwETrwlpiaRy+ENNkMM06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+vK6BObgS64J/jKMZUB2VcHEtGD3MElRFrDmq2t1Bg=;
 b=XkeJBzdsASp2/AdYW5HGvHkRz3mI+59FDXOxkJ85IFPQQ7Yjn2Z4fpJlYkimHEQZzViurRlcCuLsV7SHJHeHrndY7zzHyykz+HHK3ddoOJ5IskyuQNrKaDKdwF3lGTS/8H0H5liXG2efKdXiOtumX6cvm+vFaYx8KSEZxaE2vFM=
Received: from IA0PR10MB7369.namprd10.prod.outlook.com (2603:10b6:208:40e::14)
 by LV3PR10MB7793.namprd10.prod.outlook.com (2603:10b6:408:1b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 06:43:08 +0000
Received: from IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e]) by IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 06:43:07 +0000
Message-ID: <5e12be5d-a9b6-4a2e-8949-78f0ed1f34a0@oracle.com>
Date: Mon, 3 Aug 2026 23:42:58 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/15] guest_memfd: Use folio_has_hwpoisoned_page()
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
        Sean Christopherson <seanjc@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Gregory Price <gourry@gourry.net>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-6-willy@infradead.org>
From: jane.chu@oracle.com
In-Reply-To: <20260731200802.574821-6-willy@infradead.org>
X-ClientProxiedBy: BY3PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::18) To IA0PR10MB7369.namprd10.prod.outlook.com
 (2603:10b6:208:40e::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7369:EE_|LV3PR10MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ebd4c2e-66df-492c-08f2-08def1f3a4cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|4133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	jLePTtONzND7sc1bqCJzbI2Os1K3Q2PxaOeaOdKXm1hMJou8N8kvnS/WvxTaM0Bt+RnE+5ldb5yxj4iHRnkCu4X30ZYIUHitoutZUSvX6EmctIXbU+TWQhoWjiS63qNTfQ8ZvTYcJJzwse6DW8+dK0aVPg5mr4EqVNQRZUjpRBRaD7jq9FUQ5n1TLPPWJ+87WoQf9MEJ8KvX7HzU0wfvHYN5BcrKSSjEzElGaI68P+pr6Vs1UBCUgUdWYQxlgie/xoDZeGHUxW6j4n0o4+tK5MqY758YaMpMUGGcJrzlMx53Pq7RcCb3r+smhNSwVfE2Qdo5cLGtJVagB623eGcXaLxnDDxpyfO92TK1FqUfHGW68P1/db0Y9YId5PTZh8NvXNE0ImtGuOFpRl622ugPICdLUe/QfBwuD9XYXg5Zu5N2M0+B7oZgeqyFHgQWeyOylWjxZv2OiR6DNLxhDkTAsNGkUDHvlMhWbH6AI/Xx33ccj+9i6pZy05F2xjZWYzkTmFrMGBn1rlNSj9S+FbwGhFezwLiFcv/YkarKf5pGjs22MDcXfKi4mHJPC5yBfFhpsEVDxMm49CUWxnrbvWyGf9eJp2HMRAmxcTPxsPZ2Sn/wx1kI3WoJZ6GXZl1afH7ctWtJ5+nm35Il1YYWixXOpxmyQKgqKNA7JPULTIITrJQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7369.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(4133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG5tSDNLdWk4bzdjYVZ4QzlpK3J0QVErK0taenV2N2E2SVk2WlVwMHVzR09h?=
 =?utf-8?B?MGUvRnpEVENXNS9jM1VnZXJ1MkpnRmtWaStjSlc5RXdOUHlKSzhHMEU0c1dt?=
 =?utf-8?B?ME9CbVZPRnB2TVpWUDF4UGV6YVZJTDFJTlZhcDR0UmJNRzRWS0lrUGMwemxo?=
 =?utf-8?B?RHkrVklOMTA2enYvYlZ1SUlMVEtUMGloakl0Y2hJTUptRE56cHhTK0RPTWs4?=
 =?utf-8?B?eGdVVWRjYkk1R2V6NGRzU0M3QzVSem80aUhJVmdwakRNMVlqZmJBZ2JYMGpx?=
 =?utf-8?B?MHpYMHRkVm9yT1J1aWZTQUVlUFA3SUF3N2FTOWFsZ1Z1d1hQcGsweWRmWW82?=
 =?utf-8?B?SFN2c2theE5kTnJaWGxOSTA1NVhxQmtrdzNodVY0blpxNE9jbE0zNkdiK3pT?=
 =?utf-8?B?TEFiMWtlWThPK1Q4aGJrOHBGYVJsVWFQSkdvSlZXNnY5Z2tScG5vM2ozZ2M4?=
 =?utf-8?B?UHk5bXBPaDF6bTZuR0RqWjRYd2FMd0U1c2pBaGR6dk42aUlGY3lVQ2VvRzd4?=
 =?utf-8?B?VUs3ZmRRK0JHaDVsbkFaZlBHeThTMms0bGRWcktQQm9DUjhtcTUxbUE4RUxr?=
 =?utf-8?B?ZmJhcTdDVkpaZlR6RUs4bGo4TFpselBqMlBob1VUb2JSQWNLU3FVZHZRcC9R?=
 =?utf-8?B?RGpFVmt2cnE2YlArMlVJVnBtbDhPQ3N6a0Z6aHJ2aDFET0NJbzA1RGNSM3pP?=
 =?utf-8?B?UzROR1pKQmFIUmYzaUc3c2ttOW1zSWMzbnVaU2tMMm02ci85cVBZcS9XSUtu?=
 =?utf-8?B?a0RSczZVeE9GMjFneVZiNkNwWGV6SjVhckY2aEdvRVE3YWVTVUwyemlZV05H?=
 =?utf-8?B?NHkzSGs2QS84SVR2cDRDVmYxWW9HR0t2MXArM2plS2RnQy9MTktkS3UrZERo?=
 =?utf-8?B?dGtjNVQ3dW5xMWxoMG1sbW5vcE5iRFhWOEpQMzJpcStuWEl6aHBqSk9wK0Fn?=
 =?utf-8?B?NGNHQ0tGZisyd1JKalNRcVo2aWRSRVBLQ2hmVUdYVEZreG9kc21qclFVV0Jx?=
 =?utf-8?B?eHZ5akNjRHlQcmZSd09OWmtvNVMwNytQUkZOOGZOcGtZbVovbGFOM1R2aENz?=
 =?utf-8?B?UkxXeXZHUzArYm4weTBNdDRSeGpKdFAwQ0dnUnloL1lEN1o3alVkKzlmVFRv?=
 =?utf-8?B?T255R2pYeEx4bzkxeW5NTTlCTldCeGQ1R3k4YzkwUm4rM29yQitVcHFXWFNO?=
 =?utf-8?B?ZXNxNklZWlhsazdLWHFNU2hEY3JvRU05eGxsaHl1NUVsZ2xpb3lUQ29ndVNP?=
 =?utf-8?B?Nnd5WjlGN0RHQm45REJ0Q0tJTlUyMnlvbkNhQ3FCVkswK0RwdWFOYkFwY2Y0?=
 =?utf-8?B?NnhlUlE4c3ZHWkl2enJ2WXpwdEVGaWJvWVhlYXFLQlVJSTN6SE9ZaUhmNW9O?=
 =?utf-8?B?YWJzVW1NT1BZSmMrOUkxUncwOVJiak0zQXZEaDZWdXdmSGQyWGwxcVkyc1Z4?=
 =?utf-8?B?VkxzbVV0a2V2T3RCai9DblJxdExUQ0Z2YjJEaTRwazdsL0xhU29OcG1iOXNF?=
 =?utf-8?B?dHVHLzhuQk0rUUtMMERVeWxvTFJwcGkrL2pDeE5jZ2xHZUlXeTdORld1TFpI?=
 =?utf-8?B?cWVLUC9od2wxYjAwY25MRGt6Tlo0TVl1YnNTeWFIK01mcXc4S3RxRjRoZGM3?=
 =?utf-8?B?OFhuRWt5cVYrOTFnRCtlamhIVldlOXo4eWlJSGxWbnBkNVdqcU12WGZUdm03?=
 =?utf-8?B?aUxFQmNoVFFmM1hIUTRneTkzL2xxVEExL2VZYlk4WGpTMDU4Wkl3dytoYjl3?=
 =?utf-8?B?V2ZYS0RWYk1EUmYzTFZWd296VUd4aWU4VUxjN1VQcWJ3dEU1SCs4ejNOSkpl?=
 =?utf-8?B?MjJoM2daUjZXdDR4V1BJMmVLdHRVN0hDRnpCWTBvZXFsQ2h4NFBtTml3Yzdy?=
 =?utf-8?B?cExXMWovcEMwY0NYV0gxMVBoNE5pdFJpd1Q5ZU1vSm96dldPYU14RFBhZHph?=
 =?utf-8?B?WFdRN3UxTW9GY2NKdFp2Z1NKbzM1QUxnSmNValM1UlBzeGpxTU1NRFlkVGx0?=
 =?utf-8?B?RW5qcHRMcVJoQm9nRFkxcGlmU2RIU2NsNndUSWFHM000ME5WUG0xTmZhMFdO?=
 =?utf-8?B?dFBmSE04MWFZL0xnM2hEbEJVWVFZU2VLdXVXNGMyUVBRYUZuMWZHNnh2YTFv?=
 =?utf-8?B?OUNpYmJQWHpDL1BIRDdUMUJJcVF1OFZMeVlKc0VmQkNrOVd5all0UStYNWlG?=
 =?utf-8?B?SkZvbVdpN1hTTE9seWtSWjk4eXB1dzFnU1BEdHMzKzhJMFhSdzlOMlVIKzB2?=
 =?utf-8?B?ZW54R0l3bnp6SjVtK2ZxMDVrbmhSUGh6N3VsOE12NFFyclpDRnNCelR0VUd6?=
 =?utf-8?B?NE1FaE0wNmM3V204M0ZhM3o2TzB1WEV0SVJrcGtsQ1lXNEdLTGZ0dz09?=
X-Exchange-RoutingPolicyChecked:
	mQmS5edy5fAt9jP1rcxRjsbIJLFOj3Jv5pluqvk/0jNMVGyiYiN5HR5UpV4hT6moSauDYUfMVD7+WVIQfcYjnMFjyelBKHnyKOEG04IbHcd+TwxMmEi4nQK5R2pP+NahPr2siSVEKEBFJU419zxOEUyTNRqf+p+ghqsS46/SQCW23EdH0tbB6A1774omW1IHW9CYN4aRbhvjmKxxrC9AUR9izQJ6QE0PSzXX/cQnMjrxFPQ0nHVDehdbGGHYhMPPGrPUkDouViqxgY6C8/sDg69wfi3qCePxVbqWaQ54bRIihq10X0z/h1XpYdYnnSjSrwqyPCiOTm67+WqsGj1uUw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ekc8S6rhg/DB19Vlmf/NAb5MA2g+LPES5QthzUQGhEk1f8O2s2M/JnMZgJ+s+8QWfZjuno5eQuyyJPTaQyScP99SFf9qYekzU11hjXiXQttTyI/Q6DcxDMC52pQcB3OPJJ2cLofFQnVLxmtWjI5P7XkqEAUfxts9piNi4hQzL3gn9RIkr/NATttCZaIj7fMA/sA6zjYcOmkbMCtuT7O4mAwEPxiaKHXWC+iBl3w0yPpds79sAfW7qDZTbufTNZuJ8D29oiN404YwLJKICOtCD7hJlvApeEMSxk5jmATrMen0eB97clyK148IryFMAF6/GuL9sh7xbmyzV3orBUsPzcAuqwiQAX945zHOi51k50h1FAw2DLhjX+9WCh3jEN2sxLwh0sdNhCWacGNAC/V2KQLPSU7Ma+YIXbBXiTeeRBPHAEtp5DtVm+VX+MhORNQ8yKfJ0aM3dgEddJXci8zx2JMZP2LMq/guDz+CRx+wH4idQ6G8BNYyLtI1A+BFXaJ3ZxNB0btYR+kYsvJ10J6r7NE7LlgDXb/UjaMgUJTKVB0Qgh4ggkf3+naXTikOB+wQ74GrHGaLP8cyqEl8GAmLQMPdouvi5OsTHfH/auD0akQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ebd4c2e-66df-492c-08f2-08def1f3a4cf
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7369.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 06:43:07.8625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqN9VRKeZl8d7GzS7w3HCy4J2awzkTQnbc6/MF+KvuFetu+57Egv/j8YgscAupAaxQJF1aBiTSWIuoPYvDscvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7793
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608040051
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1MSBTYWx0ZWRfX75s1k68+yesg
 S9WKajaIGF6bKln374sosH4JRLOFOnJnngBDX8PL6Cfa2wuVHLKgaNZnkWc53AyynaWgbcbhZbD
 DB8nFwKzxah6TNfgJ7Y0LUv3abClH7g28ZXVKwSX9efBp24Rc22PxBSN3cm0sbeVszwTRHz+4xq
 DjFcbPZB17FSAkBeudOg82jL8HIterlDpIil+P0kokaX0CruS1h/Nr2JgY8B0Cfyd06a/FCv1rZ
 W+Ji36Ze5rbs+VqqtrZLMN66ydqdqRzASYqr6Mdl1WT66Lk75TLxjxTAECQqAjCrJDONPBKbJM2
 Zmbb0Zn0rXAKDceCUJBITkGDCrPTkBsHhV31C/huFrw3/SZdw3HOlA5K9X5a4NJoa8OJ7f9izza
 AtQfi52SIKN+JKzZy5gK7Gnkc99O1pkqxv5SUAz4Dlr/yFig8aFC0XpvKGF596D0/o3HUqC7Bo2
 ixBy4Gae2HgBLFDQ1CzBp9a4rKTCnQxWol7Vizu8=
X-Proofpoint-GUID: zKBTELix8CjuOe-canH4Jqv3HuYcP9sB
X-Authority-Analysis: v=2.4 cv=frDsol4f c=1 sm=1 tr=0 ts=6a718a00 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=RpNjiQI2AAAA:8
 a=JfrnYn6hAAAA:8 a=1XWaLZrsAAAA:8 a=tHa68p0SAAAA:8 a=yPCof4ZbAAAA:8
 a=uyz9oZFf2CSbAAgG19EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=ufIsyHvWW7FwcMbVRpPq:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101
X-Proofpoint-ORIG-GUID: zKBTELix8CjuOe-canH4Jqv3HuYcP9sB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1MSBTYWx0ZWRfXwkbxlcB9lHL1
 uC1OBmGsSeQy+ufcNSDA1XnC8tHDJgn29dp9qUxva+o9/kK5y1U+/iIbxCiXsSWKPhH1nNjPPvX
 fWG1o1/0jS1dHiW58KiQMTB7SNnLmOev/e6NsTpVAK9LPiaZUR2v



On 7/31/2026 1:07 PM, Matthew Wilcox (Oracle) wrote:
> folio_test_hwpoison() only works on hugetlb folios today and will give=20
> the wrong answer for other large folios. folio_has_hwpoisoned_page()=20
> works on both. Signed-off-by: Matthew Wilcox (Oracle) <willy@=E2=80=8A=20
> infradead.=E2=80=8Aorg> Acked-by: Sean Christopherson
>=20
>=20
> folio_test_hwpoison() only works on hugetlb folios today and will give
> the wrong answer for other large folios.  folio_has_hwpoisoned_page()
> works on both.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Ackerley Tng <ackerleytng@google.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> ---
>   virt/kvm/guest_memfd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index db57c5766ab6..94eedcc7f1a9 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -774,7 +774,7 @@ static struct folio *__kvm_gmem_get_pfn(struct file *=
file,
>   	if (IS_ERR(folio))
>   		return folio;
>  =20
> -	if (folio_test_hwpoison(folio)) {
> +	if (folio_has_hwpoisoned_page(folio)) {
>   		folio_unlock(folio);
>   		folio_put(folio);
>   		return ERR_PTR(-EHWPOISON);
> --=20
> 2.47.3
>=20

Reviewed-by: Jane Chu <jane.chu@oracle.com>

thanks,
-jane

