Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5F33195F9
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 07:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827221; cv=fail; b=dKjihzk0faJxtG5MXpQ+pv2s84agDTG086DFu/w7NZA7bdY6DiKjcwt9GJRCrVLuNVK7lniEog0CVTGC0Smx+rB0M3tLpOcLe0/OqzforzgUt98dDPlTQET1nNUSOlFRoaHGx/WnV/g2F5MrE4BiavDe8apFZrMm0H9Z2avskPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827221; c=relaxed/simple;
	bh=+3xjPB+T8ZRvLaClRO3QU0SPo6GDhndwqq44JkbgeKs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=hbieZf00vbOOiSEo4LdEf5c15U+mlCOUQmTCCeu/FAQ+vmWPZT5FsuWJiwmO/bRkB2Z6cSZRlc2rXHUIceUILUlg3NSwdlFigmDeEwWw6WQ67iYAw1DpteXJM1oEPCQ4tR7h0vP8b1CpRdmJJ2CxSL8adKW8xUys00lF8ouyojY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pzeokHjX; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qDYAJbhH reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pzeokHjX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qDYAJbhH"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673LF1xV2712803;
	Tue, 4 Aug 2026 07:01:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rvNv7ikzaRb7P4gyGal9zRO1tx43+C5EyrXx6KIQdU0=; b=
	pzeokHjXCpo8cP5EeGCT9J71sXDGAUa5vpT1j4Uo/qfh5QH7WeXM6q2Q4ia8Um94
	WwqiX0/5wQ6hMkf/sL/F4nalUl2YtALBMggrNP6VmqmbXC/SvgNZCvfSNG2d9fG1
	zGQsJCVkyGQhns3YJmqidQMXydHXEwWWVmaWDdWqXjXVN3t8C50f+oPApDgQ1amS
	Mw1TxODC/aSfXywDu/NpZRooZSpAT+lf6Vcaqv/USE62zxZvFknz81BOePK/6/F3
	tYVm+TuNXHMQbrM1yYDwBEw2O1RU4tFnc+LYatXn7BtlZqZYvI9KbFEHcxW8M6rY
	wJqg3RXAjaHYilvdc1KxBQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs9bt5013-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Aug 2026 07:01:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 674708ga000938;
	Tue, 4 Aug 2026 07:01:15 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ftq411284-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 04 Aug 2026 07:01:15 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsYJs0fxpkPZNghus9Gex5Ys5uO86c0H6et8n1/zYZ94Px6muj7ITIq61cu3SbxJM6Xnrf9xy2WoTiJ7wZRC5qRUzO6iYcId9ZckzeTKudxsaaqugqGVxqvjetmQSbRwgYu1THtsC0fgXZChL4iHm1Oe81vrnIeeDIkwwxzjP+1q8+jRsW6sk73k2Q6j5DzsU3nB/69S/LAwvBtQYY5jRrReLHpdDZ8rYh8kdFLc83aXqG/UYKqaAZKLPK927fVJNnvCrTvkhCDgGYRaew99El1FhI2UdPGDitUY33ywTiQdMjxgBxVYBB3xK1XUVO607AFitPfbUAaNYO/CI83YJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaVNc+hPP8qUGoStkidfgQPLWhvbjjL8Nfrjk15XTE4=;
 b=R7hAuULjOlbYtIZRw6Rfv2WzndGeb1qGS2o4IqQr8Yte72fq2vrPG3T3NmTU9VvbXlkPv9Cg8hgM7AcscQrv/BVrjteAGWMZ7/2o5ibLFT4LOIINzs2SwOiOwijPSlFfAfBzMhHpf3RQjsfnRaTO0i6py2WkNXlU0XTPEbfMqkNWkQnNmxFN/lCQeBIaTEbyTayYQVNGJR4rj/AL1cbRZqEQ6TC4VlLRJ+nlCZTIuxykNMTAOKQg+59b2fjiYILzfNXCfCaVY0znmY/ArzJhf8uPkiDWHAGl/9CwMzQFoR1ruGQKSzN+2w6HXtUciJegoEMYXpgrFI6WK3L8t6syyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaVNc+hPP8qUGoStkidfgQPLWhvbjjL8Nfrjk15XTE4=;
 b=qDYAJbhHXkuXQxu6zYeTwowFegREsWQELCyoBHTzoE4bUeoO7c6+KmdiVeAomPelKUC2NLFj/KccKX0i23qJIiDZZ9aoS/b7NlD1eaNfbRm5H5pljOl+xHyfatoyIkTi9b8sMp0uP1a7kFSDH1h3T3ELHsA/xcK0AC3iCxHeMo0=
Received: from IA0PR10MB7369.namprd10.prod.outlook.com (2603:10b6:208:40e::14)
 by DM3PPF1652C44C3.namprd10.prod.outlook.com (2603:10b6:f:fc00::c0b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 07:01:12 +0000
Received: from IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e]) by IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 07:01:11 +0000
Message-ID: <a5ea2f04-7f4b-49ba-a26d-a493ebfc67f2@oracle.com>
Date: Tue, 4 Aug 2026 00:01:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/15] filemap: Remove checks in
 mapping_set_folio_order_range()
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
 <20260731200802.574821-13-willy@infradead.org>
From: jane.chu@oracle.com
In-Reply-To: <20260731200802.574821-13-willy@infradead.org>
X-ClientProxiedBy: PH8PR07CA0030.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::16) To IA0PR10MB7369.namprd10.prod.outlook.com
 (2603:10b6:208:40e::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7369:EE_|DM3PPF1652C44C3:EE_
X-MS-Office365-Filtering-Correlation-Id: c473cc0f-a916-4a71-6883-08def1f62a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|4143699003|56012099006|4133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	rKga6W1NyF6YYGGDfsuK5MWlVZv/mcGHus5fV1/wRRDmkQc2LdhveeF1h6PGS6f68jBB0r3xowZF8hvedG3aB3Z762MGEdHIZ2brOOiCFm541If74LxPAbizavDNWN9/ExuviBQsGF9lZzLXsduutRliQWzQVcRxOjlxn1pxstDn1sfJGZ0IdiBwKQZ6dSGTDgVLLqguyAeqMVRIDgOS/X3FpDWUdpYwa7GbRlqu6A05iuHdjx2MIrPSDCcEs6NKzIr4y1GGUxUNy/+s01OS6XRN0nOBYBFxn46Sq5J5KZe5q55Ql6RAKB59rq1BKHUGFxk4/pOSWcHSQpftP7YqNdNbTwWD/ZcJz6ucBvGqEQ6E8xxfIf87AnJKdYIlEHUXtmbMvvq/mUHIQbvxvT2vhoXvoOJzxJAfzPHgvjIlqsRVy6WEhkCwj2bsJVdqmbddAu2Y0HTicUDo6DBSO0qv7K/Pc+W/nbNdNHynEYaHxe/zWtZ1Tc7MSlQWKR9tUrpu5Ez7IbnT2+WjdKQXE4eIEOXGmhf5Co51c6WoXAbfEhQ6E6Y6Ots3L/RRmkkDoEund1TDKVsYNDaKSoDPwLRYUea/Y4N5IK1bSE6OHRy7DwLSdxcPjqk21aYVVjQkGGJtX2qHaFpyX97Nea+dwSScgyhh9cYQRq0/J3Jfe/JPM5k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7369.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(4133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVBhcHRkSGc4eFdkTkFETVFBUXhUVlVjTWJHOWpkNDhKZVlUN2orY0J6aTJF?=
 =?utf-8?B?YUlzMXJsZnJXNkFMVlJUR3hjTkZET0N5cjcxU2FyZkhkZEZORVlhT1krWWMx?=
 =?utf-8?B?SGFadFVva2tvTGJBc3ZvOTlPY1V2bnp5cTZhQTJPTXJ4bm4xemNLSUFUdm1I?=
 =?utf-8?B?KzdCMnhMb1Jsb1FLWDBpRW1ZZG1TRDBJcnFyUlUvcDRIKzNzUEtTV09lQXJ0?=
 =?utf-8?B?RTZuZ2lESm9qaEpXSzFLdDV2V0tRRUZsQ29yNzFCZnRPU09OVTgyNDE0M2hI?=
 =?utf-8?B?T0lmVkdrNWhOTG5UdktyL2h3cXBxTlhRRVRTbU9sVUM2Y2xmTFdvVmtrZ2tk?=
 =?utf-8?B?N0J1cFMyOG8yRkpiZjFWcVE0dVpsRW13MnNHKzB3VnlTSGtKRHZ6OUNHWVlG?=
 =?utf-8?B?ZTIwMEl6cytvdG1XN2pNSVdVeUdoSmRCU1MzVGlSQjNHZC9MS3RaTHMzMTNG?=
 =?utf-8?B?c1BFVzVBMFBGa0RNZklkY285d3NoaXFQakkrbWtabTNjOGYzR0Rwa2VnYmJT?=
 =?utf-8?B?Y0pXN3d1K1lUMkwzdzJoa1ZhcXJETGpHaC9DMlY2WjA4bTVabFZXVGN0NGhQ?=
 =?utf-8?B?Z2g2Vk1MSytLZHVkWmVyYnp4RWt0WE1XVCtvREpIOGd2KzhHbHQ1RUNYQXF6?=
 =?utf-8?B?RENQdnMveU42TEFxdXZ5WmtRK2xhbzhZR3lHamN0aTR4cWtRQUd6UWo0TDVK?=
 =?utf-8?B?QmhGMzMxeUlzZzN3L0w3SUpmek1TQ3NBSUdvMFRhek5USzlXd1dXZXVTQTJX?=
 =?utf-8?B?eHloNVcreWJjOWM1QU43OUpxTU1pWllvempTZjZZaXN1dXRySGswZDhGb0s0?=
 =?utf-8?B?NXpPWTN2eHlXanY1Q1ZBVHM3U0ptOGxaZDVxMXBETlMycTFpZVBVSFowRit4?=
 =?utf-8?B?dHViTUp6ek56VWpWUTBrV3hLa0pzY2NTQmxnckg1VHEvR0lOTm1Tb3FMNjdS?=
 =?utf-8?B?d1lCR3Z0SlZ6c0FuVElxODRqYm9BNU1OeStNN0s5cm5HT2doM2xmOStFSHhM?=
 =?utf-8?B?TFJLYXdNSDhFaitBd1B6bzRnci9keVFoL1hyRVVBakhvZVdxWmVibXRORXIx?=
 =?utf-8?B?WXhsNFpNQWJLMzhlcGp4Y2ZqTW42VmY5U2FYcWZzS1V3bkFEeEd4OUVTVHJ6?=
 =?utf-8?B?MEU4bHAvWkNORkoxdE9wUjdDR3NIdE1rY2svd2FVeDlWdGVkN3Y4LzhSaGM5?=
 =?utf-8?B?ZFl6VThSazJNZ1cvRkxhbmJuRGRTYVpqbVdmTVV3bGk2a1RnMkhZMnE0UFZY?=
 =?utf-8?B?ZFByNyt4WWRsd2RFNkZpbmEvQjYxemg5WXJNd2ttRnV2amhNYnZLeUlBR2RN?=
 =?utf-8?B?NEI1TXVGckN1emFmM2FCSzdOMDhCVVg0RFhvV0lwZndsS2krY09JV2lPY2pp?=
 =?utf-8?B?Sjl0SEpycFZYOUhqQURzTlJ3MmpROVp6WDNWejNoaWZrZlFEUDlOUC9OV3Vt?=
 =?utf-8?B?VjRWREQ3UStZL09IZHEwUjF2cmpvZnhxdHRBWFF0OUFETkdpemROa2xsYVkz?=
 =?utf-8?B?OUs4YjdLQVJDSm9JWFp0L3pCekw3enpSN3NFQnIrVm1VOEhRWHVwNEQ3bXdZ?=
 =?utf-8?B?bFo5QTdJSVUvZjRBUkFxVHJkLzZpNnFTeTMrdjcwaWRlOVdPTkxGRmY0Um1C?=
 =?utf-8?B?YVJscTI0V1E5KzN4b1kwMjNYdFNtdUMzNnFvb083VjlEbWZpaXg2a1U1bzBU?=
 =?utf-8?B?TG1GZHRzdHMrT21JVVhDWnc3R0gxQXpEdXllTUFja041bFdhdmJGVUNuL1dE?=
 =?utf-8?B?bFBWeEdkY3BaY2czamZxUUx0U3UrZHlyQWhyOTlHTy9CT3NwWTNRQjNuRUlL?=
 =?utf-8?B?Rk13MzJDOW9sYXREeXE3a04zVDVHKzU1d2d1OC83WHMvY09LbjdsUUFDZFVU?=
 =?utf-8?B?bGFDQkh0My9rbXNoTE5hVEtaVld2Z2E1N0pBSEhtdSsydHhQNmhabTRPRm9W?=
 =?utf-8?B?bnlPUktnYTN0bTdmY2lyQ1BxNm55SkE1R3VicitIKzdtV0s1OFFYUFhYNjFa?=
 =?utf-8?B?RVJicStrcXVHZUwzN0NoNVV4WEk4Njc5MEsyOUxLMUlZNW9hL2NOTDN3dW1Q?=
 =?utf-8?B?Zi9nOGQ1SUdVZ2MrdFpaY1NSaTlkdzd5dEwvRW1mS29VcmNXb1UzaFVSanhO?=
 =?utf-8?B?THI5cXlab3dpZ1lEOW9nQW85T2l5dmpPbHlsS1gySkN1cTFJUkdMZC9lM1Ey?=
 =?utf-8?B?c2d0SnhyUDZITlRYUm82bUJtbjVQN2YwRzlJU3FKcjEralZYOVhBY0VKcjlD?=
 =?utf-8?B?SHV6VWpQNHVxRzJUNmRDYXliN3VrYVFzTTJMMm5YU1ZnQm02d3MvOTNoVk1G?=
 =?utf-8?B?bDlEMGNNM0FsV09NaEtycC8xWTdYSUZvY3FIYnFYRDlJeHBPeDU4dz09?=
X-Exchange-RoutingPolicyChecked:
	S6a/ilemxEPK4RhTH0BJL+JWE270h8kv038rtyyhu+hpkm4bhe/aHWZQqIw2czrStOce6WZb4BLNpIvRYJlJycp1Ygh1LUtPFU8e8e4MYvG872oYbwWdmf2hOdiu5b8XqZF0QzIITCcWktkEP5VAcVHxvr0Ht0K9aB5lbDNxk8W+qQ98kRV5QWnluF5fX1d4tl0zLOMxImnbM+wHvu+AFPDVbFlxx903rfNNV2EO9NrHeqnW6+NgMXDmMgKVoi/wZY3QbMl0sc2EVCXpRLSCFYOZ5+4Mky6B+vRgodn2tsDJ7JIUcMZmkPQAprhT1x2hbAp4U8C48wa2XoDE8qwbVQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NjxTnMk2PW2S0NRfB56NUUSpInngQZmxkB9kNy+kYd/3qdj8qTRYSPlc7pQ/q6l+0HjGQuULiCiJ7PPfYNHcdQ6QQEShx0nfQIjYr4F1WU00XLXmUgDgm02wUdt/5b8euUYyQRwe6e/4vBHq7Bb/kra8o8rbH3LQQWj59ayBGcbehO/wU8O8ph5/qX1xuyS82X44F+L8g/k68heBSMGsXuO4gdDmDGow53luUq9LTn339FTi2bwSPyHOFu9/nQ7yB47k6NpVXKSqSnSYD1X5tVd+nAsxIGf2RXgmNCvBgt1zOwK6pI9Ael8Q9ZrGqYeEQxQuQ9Bo3+DJ6LQPx4/kCvjD428il4eUcbO+JpRD575jbC+cyWmhRqi94vfevbKIHyqqkN3fCOOo2lLmxn6LDOlzKhA2eqX+Jpm4mimXNWOMrYDxW3iG2qJuzurs1bL7WqVQewETG+jdKOGufFrV6VtBaeXpMecWnaINUvqns/EIkSMVg68Da2kVQGbJmwf9QkV11195tqwft29WQH2E6U3ciiZx5brvpGmYqn4CfgCNl2lUYgpVztXm3bNUInAkuxyvgxd7jM3Y5sPJeGBI9dr0NzjuZfN2a5s1agah1zA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c473cc0f-a916-4a71-6883-08def1f62a68
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7369.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 07:01:11.0263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l13rjdA0njnZArsv8IXCOOi9WIAmX3s5T3XQF6uorscFdA/WAqtUdcC/4Jzg5jfHG3Iy1nfVijodh97XNfBS5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1652C44C3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608040054
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NCBTYWx0ZWRfX4/MrVY3JTJAr
 9iiWW3j/6l7emT94cqeWyo4WzcZ1+nNZmOxsUKcKhzlMWko1M83LPlWyWEYUyly7HBnRLvEMzI4
 I+CuCrmrpmwh56Z35vUfC155rgQfjnm1MM3ey/+YYkLuXRrpS7O7A1HOwWCbCdt8nFw0U9pUhGc
 dtNm9RqeAs/oGgSN5i4nGxcrZ77yr6V6zhQBG2h9+oi3XM7bDAgFD7eM/ZvshtCIkExRGLISAxD
 FaIMp+c7f5T2WyF5riLoLKwK2ymvaCMDqeckWZ35VIMXq6lJlt06fg/wYmJrWKplpCB/xkED+v8
 0LmckG6HTqHEWtM+c4XZfsz1eFPA/9n1QgnWK9s0AOXb4qCW2g4g3yxSwBSy+SUys16GwLipDTi
 hK2NBtxvZ6LA0ztdLY8CyNaq6nfijV6FLlN6+1b5XjBmgQ1NycqiTW9tfyxCL0InyZCCKDqNu34
 zSY45/adZJ6YKjYbvmw==
X-Proofpoint-ORIG-GUID: 5703W3p1JkGgfr19SIfP91GAVZNbn2tp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NCBTYWx0ZWRfX7thUctfmP5bi
 1KKmO3WehOlySkvusEaVKY3zXigvD2nGjjt8JJ26JqNjpBw6BRtfL1OIuAJZbv90cjoQYQU9vGL
 Ufb8WeB8BzhgEqM1R3FIluHS4MNZRPhSgHI1yySc6aM2wxtc4OI9
X-Authority-Analysis: v=2.4 cv=ZOTnX37b c=1 sm=1 tr=0 ts=6a718e3c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=RpNjiQI2AAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=NHKsxCec5vcYETXYWbgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: 5703W3p1JkGgfr19SIfP91GAVZNbn2tp



On 7/31/2026 1:07 PM, Matthew Wilcox (Oracle) wrote:
> These checks make it impossible to use mapping_set_folio_order_range()=20
> in hugetlb. They add very little value and can simply be removed.=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@=E2=80=8Ainfradead.=E2=80=
=8Aorg> ---=20
> include/linux/pagemap.=E2=80=8Ah | 34 ++++++++++++++--------------------
>=20
>=20
> These checks make it impossible to use mapping_set_folio_order_range()
> in hugetlb.  They add very little value and can simply be removed.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/pagemap.h | 34 ++++++++++++++--------------------
>   1 file changed, 14 insertions(+), 20 deletions(-)
>=20
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 2c3718d592d6..968b791cfd14 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -373,7 +373,7 @@ static inline void mapping_set_gfp_mask(struct addres=
s_space *m, gfp_t mask)
>    * assumptions about maximum order if THP are disabled, but 8 seems like
>    * a good order (that's 1MB if you're using 4kB pages)
>    */
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#ifdef CONFIG_LARGE_FOLIO
>   #define PREFERRED_MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
>   #else
>   #define PREFERRED_MAX_PAGECACHE_ORDER	8
> @@ -394,7 +394,7 @@ static inline void mapping_set_gfp_mask(struct addres=
s_space *m, gfp_t mask)
>    */
>   static inline size_t mapping_max_folio_size_supported(void)
>   {
> -	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +	if (IS_ENABLED(CONFIG_LARGE_FOLIO))
>   		return 1U << (PAGE_SHIFT + MAX_PAGECACHE_ORDER);
>   	return PAGE_SIZE;
>   }
> @@ -405,29 +405,23 @@ static inline size_t mapping_max_folio_size_support=
ed(void)
>    * @min: Minimum folio order (between 0-MAX_PAGECACHE_ORDER inclusive).
>    * @max: Maximum folio order (between @min-MAX_PAGECACHE_ORDER inclusiv=
e).
>    *
> - * The filesystem should call this function in its inode constructor to
> - * indicate which base size (min) and maximum size (max) of folio the VFS
> - * can use to cache the contents of the file.  This should only be used
> - * if the filesystem needs special handling of folio sizes (ie there is
> - * something the core cannot know).
> + * The filesystem should call this function in its inode constructor
> + * to indicate which size folios can be used to cache the contents of
> + * the inode.  This should only be used if the filesystem needs special
> + * handling of folio sizes (ie there is something the core cannot know).
>    * Do not tune it based on, eg, i_size.
>    *
> + * hugetlb calls this with orders larger than MAX_PAGECACHE_ORDER.
> + * Normal filesystems should not do this.
> + *
>    * Context: This should not be called while the inode is active as it
>    * is non-atomic.
>    */
>   static inline void mapping_set_folio_order_range(struct address_space *=
mapping,
> -						 unsigned int min,
> -						 unsigned int max)
> +		unsigned int min, unsigned int max)
>   {
> -	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +	if (!IS_ENABLED(CONFIG_LARGE_FOLIO))
>   		return;
> -
> -	if (min > MAX_PAGECACHE_ORDER)
> -		min =3D MAX_PAGECACHE_ORDER;
> -
> -	if (max > MAX_PAGECACHE_ORDER)
> -		max =3D MAX_PAGECACHE_ORDER;
> -
>   	if (max < min)
>   		max =3D min;
>  =20
> @@ -460,7 +454,7 @@ static inline void mapping_set_large_folios(struct ad=
dress_space *mapping)
>   static inline unsigned int
>   mapping_max_folio_order(const struct address_space *mapping)
>   {
> -	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +	if (!IS_ENABLED(CONFIG_LARGE_FOLIO))
>   		return 0;
>   	return (mapping->flags & AS_FOLIO_ORDER_MAX_MASK) >> AS_FOLIO_ORDER_MA=
X;
>   }
> @@ -468,7 +462,7 @@ mapping_max_folio_order(const struct address_space *m=
apping)
>   static inline unsigned int
>   mapping_min_folio_order(const struct address_space *mapping)
>   {
> -	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +	if (!IS_ENABLED(CONFIG_LARGE_FOLIO))
>   		return 0;
>   	return (mapping->flags & AS_FOLIO_ORDER_MIN_MASK) >> AS_FOLIO_ORDER_MI=
N;
>   }
> @@ -524,7 +518,7 @@ static inline bool mapping_large_folio_support(const =
struct address_space *mappi
>    *
>    * Return: True if PMD-sized folios are supported, otherwise false.
>    */
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +#ifdef CONFIG_LARGE_FOLIO
>   static inline bool mapping_pmd_folio_support(const struct address_space=
 *mapping)
>   {
>   	/* AS_FOLIO_ORDER is only reasonable for pagecache folios */
> --=20
> 2.47.3
>=20

Nice.
Reviewed-by: Jane Chu <jane.chu@oracle.com>

thanks,
-jane
