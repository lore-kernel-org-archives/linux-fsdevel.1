Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407C93264DD
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785825773; cv=fail; b=rYDpvoZSXlEOYhIn4MwaSKCk+Nq1vcSZ/yj7QJMuROc5LhKCk2tqCzSjWcoky2Bu1kOyk/Rzw+ZgZ/TOYVJBTiX26xOZX8V8wwzSqcc/KxyR2DbTaMwBJsa1pJ/I3hX8a7hoY86ELI7vi0OCdpKNaDEnf6JpwkdmZEE+D9f9N70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785825773; c=relaxed/simple;
	bh=z4zl+TryEkneaIu5QRIPvXT6rQboNgMCjiuSKDK2VG8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=G8YCU7sg9q4NnDAMAOyOLHRqFmWopwANpg1bFKXqdgu6qACzy24X9spPJCch3n/9yoAtlXqM18RqFH/aRxLaqGWfwn/LqoQc3hqFOA3pgj0B/YkEJj+vGqMB/Fv5bCPPZbf6mWRLOAzZwXQ/3Ce1OPKSsdiS8od+vlEKFZmIGPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hnzjNJLP; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pLfsS4f2 reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hnzjNJLP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pLfsS4f2"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673LUhnM2955794;
	Tue, 4 Aug 2026 06:42:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ULm/b9+6HSvXgzmlBhblfzB0vIjpkKmB2TVA+DIkFk4=; b=
	hnzjNJLPOPL31/qOEj+8r2VvkSSKXKvgkL22u5KpVlDNXVjZ/jjnl1HRh4WHJaY5
	402X/r3WoqtsQvqPY2myKyi5PEroRHCCJLbEl3+2ijjThPL044pUFZCk2YPG80gR
	RyV1HxT8X1mXdYAIVt+0fqmQ5Y4UBGnJHcWQZf2iaCoRieQM6ZWvMwDWB7S+/OLB
	5KWv4b6DkgJ3qr//9AAUGOMWtQkVMyZl1LKp+1yF1UK2iWX1CMbhA8PDcQhM71ts
	fvI0XEF2nvd6sGcikLQpsjZnVujknmQdVlTPmWPnahqHuARkSqJYwoHV2sxDto3L
	tD22xn39fOdta05/cs1BvQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs8p95142-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Aug 2026 06:42:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6746eXro005116;
	Tue, 4 Aug 2026 06:42:05 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78sr8p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 04 Aug 2026 06:42:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLcRoBJY80EbiihKVAxrWii+B9fZW5biuM3oBjvZCPZEXht9zMSRug5uByTJ7CLPyXGFBdEkCWGS6lw3YBjJShYT+2cwAO211KQHnl6ZwldpTxllWvPDpOXgg9brcD/yeER+i9Rgr1a6yIJ7QXbt1HmHHQvyB3U8tXSO3qO7f5zhoqjM6A26vnIAQyg86ywd/tLM0oQ3l3I7zbWyYQnjsczrnHMgH9edeRMIRVgTeAKJhmoDti9oZFtMnk/4qsoPOQKScqHm7ufB/SURH6dh0zuergEjwIvNjDibJNfX339ehGBiGRvSehS5y7ngGlyHFfvbDRrZw40vEt2I1/hNrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeWM3yCr+A3c+cMiLHs3409++vi1CTQn+ioJoUbPMBw=;
 b=ERMSPjAn2KZQYunN0HgSIs448K2hKyMUc8Qajs9O7z4Ic7t6brvV2/LeOELo6WoyOXDjNDQkslXN9UWeodJi+z9nfNPzTqUpGvokOyXoUaLrwkW2nbWY0G3Yu01prtFX5Tz1cIHdP3/xcnlXKqi6MfWWEssxv7z/0pQ5yi9fgmghOomoyNqUaSOPmuFa6D5AiRErIWRmGFDsSz0hqkUrhzLK0nKBtGLTNPdAoI+16Qfpk11uiky6nqhXYRODPcUVEeSY4IQ/L9fxqyKKXOLapr7bCTiCD8aEaVFBj9OnMOKhItblUvy6REwMkhfLp9zCoxP7EELs8JpH5gG5IAUt8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zeWM3yCr+A3c+cMiLHs3409++vi1CTQn+ioJoUbPMBw=;
 b=pLfsS4f2Yomx5FxI8fGUZeCXVIGbQPqr5Gx5d+cNoYmCMKm2qIoOJls2Mzi5nMaUllHbR/k1npLc3yVUidkdDzg0JCDdM2Go+D2xTrtQbB+JWdY4L2SDHS5XcKTa0jzLjozAT4PtSmb4ED7EhxxxtGTfm5DDMESA7KXUAaXkMiI=
Received: from IA0PR10MB7369.namprd10.prod.outlook.com (2603:10b6:208:40e::14)
 by LV3PR10MB7793.namprd10.prod.outlook.com (2603:10b6:408:1b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 06:42:02 +0000
Received: from IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e]) by IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 06:42:02 +0000
Message-ID: <92dfd4be-e25f-439e-a9cc-258e338f4d12@oracle.com>
Date: Mon, 3 Aug 2026 23:41:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/15] hugetlb: Mark some function arguments as const
Content-Language: en-US
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Jiaqi Yan <jiaqiyan@google.com>, Usama Arif <usama.arif@linux.dev>,
        Gregory Price <gourry@gourry.net>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-5-willy@infradead.org>
From: jane.chu@oracle.com
In-Reply-To: <20260731200802.574821-5-willy@infradead.org>
X-ClientProxiedBy: CH0PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:610:b1::34) To IA0PR10MB7369.namprd10.prod.outlook.com
 (2603:10b6:208:40e::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7369:EE_|LV3PR10MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: a9df51cd-8b21-4672-faab-08def1f37da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|4133799003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	aE+SSt80ymYFwJn2PnMe/4QdVJnlXQuEOAo4BgniojXLnzs9HeP4dSyqfmAZy4gpLGmREwJeFsfdwjsyRPVYE4txPsoqN5PRn4Am1klElvX8CbAgcUGOUC5DL3Y9h9j4PGsydrzvQtuygN/fi+y6jKvekdx/zTCqZHc0Kja7GqgKXYpdqcJJjTQg/jZ5djWidMx8VJ08zEw5aOacioxPMgbzo6YG7wBQOISnaZAl7urkeWB0CyH+ZUd/S05gurbaa5v2ZaYgPl7CDMnfno9xyki5LOwioQVrjsQuMvR3s6+qq+bruz3UvzVwvutvwaipp4kyQje/Z4hlTp93NIupCJcbTUGITVrX3AVcgPPuX/cUJCF4VtJSWhXu6PyZdPJcUEPfgPiydyV/J3+FFjyY53/gNBIeoCu/SLzadmQSFm6aDOEHkIIZXh94TSO53A8wOMbGbKmduAEjP43hXN+SSfNsthX3Vd5xQrS6QQF3tux8w6IRzOyV3sAPnCZyeZxcGUwjUg/xHELKnM4vxzIMbZNTucI2QLSXc9SkfaWREmVCdUyeMwZMUq2BB0Q7OIeP4+p3rnUjM/5cgGcUb+tCV5i+IoG64HBsFLJUrwNDKRlXQ5iriu7S3nMfiWK+mkbPUbTWcPMEhxJ67Sk2L74WBzftg/NJ/3K73stXZPFlFIU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7369.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(4133799003)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VExqdklnb05QczFpM01idE9EQUt0TTBlRjJ0SnNBZ2hEc08zeGd2bmhsQ05W?=
 =?utf-8?B?WncxN2haQTdySWNCeWpoblJaTFVsN1ljRWFCK1BBZStYclJ2SHQ3MTd0M3o2?=
 =?utf-8?B?T1hBVUlxbldXSFJCV1o0ZXhJKzFXMWlocGlkb01raDZzV0RyaXk2aHZ3dkdR?=
 =?utf-8?B?ZS9yZmpEQW1oWElJTWZNd25QQldjZWpPYlk3K1E1Y1NYVDduRUxsOXR0bXNx?=
 =?utf-8?B?M3FtR3BrMTNIS2laeTlSR3lkZm1IWDRoWjlLTVZKRmpac3g5cDRlZHA0ME4z?=
 =?utf-8?B?dHZ6VVg1cXpsSlBiZzRtTmF6alYvYk9KbU43Z1dqVGllTGpNTUJkd2ovTitB?=
 =?utf-8?B?ckx2U1JGRjlVai9zZEZoUUtCUHV1dlRJUHRhQVFWZ2cyTEZROW0zeWhkcmJx?=
 =?utf-8?B?ODBYYUpxS24zMkpVbFdzb2F6TXBub3hrUnNudlRUemJybTFlZEpaWlNua1ZH?=
 =?utf-8?B?NlRBeUJpVmxlYW5BMXh0ZzR5aWZpMlJWLzZOYmZtR2VmdWcrQmdtQ0J4M0lx?=
 =?utf-8?B?UmJLQTdQSExzT29lRDBQS1JVWEFOVzl4UkV6Q0NPS2lLbHl3OTdSZlcxbTRp?=
 =?utf-8?B?QXZuZmZBdnpDOFRWcENrcEhrbVhYZ0ZtU0NpWHNRQ1pJSGY0SGZSczIyZTFV?=
 =?utf-8?B?NVdjTVlWVmhkaWo0ODBBcmdieDBEV1drSUlMVmxVWStCZTY5S2JPaHFoK3JW?=
 =?utf-8?B?WkZoMU8xcW9HTjZ3ek02TnJjUkpBS09VQUpQSmRlQmtKdzFpUy9CazZVUFll?=
 =?utf-8?B?aEQ4UlJIOFJ1bjl3ZVlKR1ZXaVViblpmc01yQ3pFTG5OYVlrU1dlOVd6UHlY?=
 =?utf-8?B?K21DUEZFWitxQnpDQzFHK1Z4WjJiYTJBRXNWWGRTZU1zdERyS3g2T3BYWmdj?=
 =?utf-8?B?RkNEVTlWWFVyQVF2OGZDRXJONU0rOEczTGwrL1ErNjUyaUZZSWJKdkVYVmlP?=
 =?utf-8?B?VXU0SVYxdkMrc3NTSDVFU2J6ejNPdlBGQlVRN0RONGprVm13K3pCUndLeTJs?=
 =?utf-8?B?MU05c0NFUnVvTWY5NHpZbWFyRC9vVWdZeXJ1elJoVko0dEZtWkVqY20xQSt2?=
 =?utf-8?B?VnFpYmQvaTNlU0V5Z3ZFWTN6bkoweG5hc0ExaDdsMDBjOGRoT2d0OEdCb2FM?=
 =?utf-8?B?SFZ0NkxUdHlkdHduTFpHUFFBeXdtd3lPOUc4ZkhCVE5YL2dpSjQ3dGdDMUc2?=
 =?utf-8?B?K1hZV0tlZC9BaVkxSGwrdUNuU0VJL3FBaVBIeXY1TEd0dVkvMlVQMGVPdVVB?=
 =?utf-8?B?eHM5UmVIbUx1SjJiZ05NeHVCMDNEWnpSS1RaQVV3WlY0Z0hPK3BSZE5HL0tX?=
 =?utf-8?B?MVgwK1B5UW5zaVVMVmt0WWY4ZUNDc01KTnMwTUQxeEpZa1FMNTZJVEF3OE1a?=
 =?utf-8?B?eWthcmJ5UnJqWDk3VzhzZnZzeWd0cnJzQ3M2Sk0yS0xpWGdIUWFlOS9VVmZE?=
 =?utf-8?B?b1JCTnQ1cFY4OVBnMG0xR1ZkWG01RmlQWkNONk1hN1h2eHlLYk9DY3RYNXlS?=
 =?utf-8?B?aHk3RWl0MXZ1dUc0b3BnbnVQcDVTaHRDUEtucnY3NVAxdFpRRGNMTnZncVJZ?=
 =?utf-8?B?bnRRZGRnQ25lQTRtNm1wZWR3M3U1Y2p2Q1FuSklsVFk3TWhLWXNnWk5rTDZS?=
 =?utf-8?B?RkJuZGxyaS8zOWFMT2F6SXlVZm4vY1F3VEowQ20wRTlTT1dVdTZhQlZkb1pZ?=
 =?utf-8?B?Q0FyeWNVVitiTVlVVjdDRGFyaW1ZY0dSTThaNll0K0VrVlJHVjUyaU9EL3ZI?=
 =?utf-8?B?eS8yVFN0anFtTVN6NjhvZEhPVGphWkg3QVdCSWJwazB5Q3MzYUFzcjZnb21E?=
 =?utf-8?B?VHRHcHdhRGxqOE94V0FFTDBqU1lkZ2ZZcVBlRVhrQnowY2ZDYkRZdFFMUjVr?=
 =?utf-8?B?WGNQRjBjWGlZTXBSYi9rZXNoaXpwdXE1WWxsWklBa1pCMmZxSnFvd0hFeVpi?=
 =?utf-8?B?ZTdTbTJXVWNzSkdwNHViMGdGQ0VYb2pKY1VRWlozaFpNZUJpdDh0cXhQQ0F0?=
 =?utf-8?B?R0pOaWo5TU5iUG9CSEpSSVJreWtxVE1keG9jQXBYYzRMRk54eXJ4QkxEWW5Q?=
 =?utf-8?B?czlzaHlwZkxtTkpqTnNxRDlTVW5NWFA0eEcyMnhRSE5pVHVaKzJpcm1Dd0tR?=
 =?utf-8?B?WmxCemJ4NmVJUDdFSjZSSXAyU3hoUDZnVUJ3S3hmUWVmU0E3bS8yYlJrbHI0?=
 =?utf-8?B?OWNxWUtUbTZ1MDhadFJUSkdpc0pmMGlXM0ZlTm1NNU1QMzY3dzNKbUx4aDJI?=
 =?utf-8?B?QnkxaEt4aHd1bktRME5scW1mK2ZRQ000c1hMS1Nsd3dyL0hjSHpzZjFLVDNJ?=
 =?utf-8?B?U1FSRmlySmRzaUFWTGRjOGFpdUhwY1l2L2pqbDUxQXZnUEZ2ZzVkZz09?=
X-Exchange-RoutingPolicyChecked:
	QRqFmGQkJYC4ps/53k6v8ils+Vepux2J+xTMsfxiVqSZVElzN6rlCss2hZoM/jFSqkTCCM9O7d88Ya2YQ0QWeQGbWDS8ZD9tYVzq3wmF+rWVkHOcv0lw6ID6Gpxv7MaJ50N+o6FzCsbHVJ1NJB/Up7T3bYce6AFjX9iHlzLJRr8UxgHQl9NfbwDJjLlYgYXCTMh4smMzp/oW9xaj3rGT66c/j1fo0OaYcJboNZt5acVSE9cKIy8wRPDN1MHToLtuYDfwMyfexpGea2RACqapBxcuv2ib5RmbwzqtArbvQM7R0je0uFKonSNtt01mj3Bvt9HPXQBbzHXv1iOUHfnwfA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ILWd8hrIU77WIku6uYHvB6Wz6TJkCTodsKgKcMl4uyZ3+otJXw9kWakRjNlWPuYHzrg+yy3h04Aw+WT+aoLYKCcInEu0AUAAEBWlFLNNFau+Z1SJDqn3njWAhw4WRItTKJEu3M3vqTw44eUB+Aq42Z1H/x5RHcGuPXkWeInQxT9YIbuK4M9/Q6837nmAcUUpePMivStwYf6X/c1aGm89k1zqUtc5eAnqmov+sSrmmU6RbQRIcS3aaZjq0JupeqhY2rWmPTdmk1f8BiKvXxk2+mISobaXG7/y2ISr9nwS7I3Jf4rR47rvLkLC8y6kk12bYIGp6u6Xxu3I0303zFzfBnuc/2HuAfovmQ1GYYxE6LQPY2hKDStuGeBREWXHXWxT7KAlEVVlC86ivhqVzBmuAhoq9BWhCgXNQrZ1XEKoTZWAXuKlj3HjHvgULBFPZHpPG5oFZpv9xNZVI0A4TulMK5lfZr3USW0Ugqm/tWXBkShXv8mEnLB9jRs7UOud1X1tullxoaHxTMDGxHkBavUOX9BdrMBvG+4qn7GWxLJsFYBspZ7UniQ635vggEoopCBjK2G+ZxhnQSImkxV0wJwYZP9/l+YsnXIAuq7TvGODhFs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9df51cd-8b21-4672-faab-08def1f37da6
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7369.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 06:42:02.2503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTURT0MlJi+YIXbSVNiOy6XuMF5gCW/NZKUQSnS4EETc7SJcNctRbAaIp9SBr1loeZ9iZuU1v/D4D5vbwNwr2g==
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1MSBTYWx0ZWRfXxZJzbwG3hbzI
 UkC2m7pKwL8pwNolNR6LvIwuB4diPlm15dXUPp+xkoBmEbZvQZ3ZSIg5mrstA4KO+UWQWYs1ew9
 MIaKi1K95wCKomanCQE6unFUDOkR+3sIH1iWcdZiZDQLR8GAN6SI
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a7189bf b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=RpNjiQI2AAAA:8
 a=JfrnYn6hAAAA:8 a=tHa68p0SAAAA:8 a=i0EeH86SAAAA:8 a=yPCof4ZbAAAA:8
 a=s899zSLG9N48ppA-G0kA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=ufIsyHvWW7FwcMbVRpPq:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12101
X-Proofpoint-GUID: -FEzvcJRQp-eK8ZgmJRnMGpVSHdpsgpp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1MSBTYWx0ZWRfX6ErymaW0J4U1
 qCAyxErDuNMuyon0Y2x6Pl228gy0Qlobqzm8yB4pqQ8A3N1gaeYW6EuVDtXRV0uH5CzkxZ1L2oD
 csuKjWbcj8L+L1IvFuLqVOgdTgjnk+2XBfJFPw6gLpzOlmy3Vd8a75Jv22PZCr37LeG3klbCUdd
 owDfW4itT+ZFMkpNykbBw+O7GsupZckBdGmnwC8cl7HcpnFemUZQ93d6BbpqlBq3+k5ivIb3is8
 S6vN1uso0vgF6xZzLB+2llmNmG+L5BobPc7IlfvmtnE7WONCJ41D6VgN0B6wnqok74TdGr8bNkT
 xbjGiZQ9tKC059vqez9CyFERjYUjSY/EYg26sTw2FRBYsvKzbKhRCM7WBZrCA589OOL1pAfphnr
 RWY+wcY60ukb+V5IPV5yoJdEmviNrTqRXIFzc3kZQ3jxvphVWyiFFycnDeoqpWRHgBoN+NhkMJR
 XZvg/k1eCJG9pGX0qVh0+d/1xbPkzAZODcEONee4=
X-Proofpoint-ORIG-GUID: -FEzvcJRQp-eK8ZgmJRnMGpVSHdpsgpp



On 7/31/2026 1:07 PM, Matthew Wilcox (Oracle) wrote:
> These functions do not modify their folio argument, so we can mark them=20
> as being const which will allow for some minor optimisations and let us=20
> mark other function arguments as being const in the future. Signed-off-=20
> by: Matthew Wilcox (Oracle)
>=20
>=20
> These functions do not modify their folio argument, so we can mark them
> as being const which will allow for some minor optimisations and let us
> mark other function arguments as being const in the future.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Usama Arif <usama.arif@linux.dev>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>   include/linux/hugetlb.h | 19 +++++++++----------
>   mm/hugetlb.c            |  2 +-
>   2 files changed, 10 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 50eab2c23299..e200c93088bc 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -176,7 +176,7 @@ bool hugetlbfs_pagecache_present(struct hstate *h,
>   				 struct vm_area_struct *vma,
>   				 unsigned long address);
>  =20
> -struct address_space *hugetlb_folio_mapping_lock_write(struct folio *fol=
io);
> +struct address_space *hugetlb_folio_mapping_lock_write(const struct foli=
o *folio);
>  =20
>   extern int movable_gigantic_pages __read_mostly;
>   extern int sysctl_hugetlb_shm_group __read_mostly;
> @@ -311,8 +311,7 @@ static inline unsigned long hugetlb_total_pages(void)
>   	return 0;
>   }
>  =20
> -static inline struct address_space *hugetlb_folio_mapping_lock_write(
> -							struct folio *folio)
> +static inline struct address_space *hugetlb_folio_mapping_lock_write(con=
st struct folio *folio)
>   {
>   	return NULL;
>   }
> @@ -614,8 +613,8 @@ enum hugetlb_page_flags {
>   #ifdef CONFIG_HUGETLB_PAGE
>   #define TESTHPAGEFLAG(uname, flname)				\
>   static __always_inline						\
> -bool folio_test_hugetlb_##flname(struct folio *folio)		\
> -	{	void *private =3D &folio->private;		\
> +bool folio_test_hugetlb_##flname(const struct folio *folio)	\
> +	{	const void *private =3D &folio->private;		\
>   		return test_bit(HPG_##flname, private);		\
>   	}
>  =20
> @@ -635,7 +634,7 @@ void folio_clear_hugetlb_##flname(struct folio *folio=
)		\
>   #else
>   #define TESTHPAGEFLAG(uname, flname)				\
>   static inline bool						\
> -folio_test_hugetlb_##flname(struct folio *folio)		\
> +folio_test_hugetlb_##flname(const struct folio *folio)		\
>   	{ return 0; }
>  =20
>   #define SETHPAGEFLAG(uname, flname)				\
> @@ -746,7 +745,7 @@ static inline struct hugepage_subpool *subpool_inode(=
struct inode *inode)
>   	return HUGETLBFS_SB(inode->i_sb)->spool;
>   }
>  =20
> -static inline struct hugepage_subpool *hugetlb_folio_subpool(struct foli=
o *folio)
> +static inline struct hugepage_subpool *hugetlb_folio_subpool(const struc=
t folio *folio)
>   {
>   	return folio->_hugetlb_subpool;
>   }
> @@ -876,7 +875,7 @@ static inline bool arch_has_huge_bootmem_alloc(void)
>   }
>   #endif
>  =20
> -static inline struct hstate *folio_hstate(struct folio *folio)
> +static inline struct hstate *folio_hstate(const struct folio *folio)
>   {
>   	VM_BUG_ON_FOLIO(!folio_test_hugetlb(folio), folio);
>   	return size_to_hstate(folio_size(folio));
> @@ -1107,7 +1106,7 @@ static inline unsigned long huge_page_mask_align(st=
ruct file *file)
>   	return 0;
>   }
>  =20
> -static inline struct hugepage_subpool *hugetlb_folio_subpool(struct foli=
o *folio)
> +static inline struct hugepage_subpool *hugetlb_folio_subpool(const struc=
t folio *folio)
>   {
>   	return NULL;
>   }
> @@ -1176,7 +1175,7 @@ static inline struct hstate *hstate_vma(struct vm_a=
rea_struct *vma)
>   	return NULL;
>   }
>  =20
> -static inline struct hstate *folio_hstate(struct folio *folio)
> +static inline struct hstate *folio_hstate(const struct folio *folio)
>   {
>   	return NULL;
>   }
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 571212b80835..cc8d98399913 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1775,7 +1775,7 @@ void init_new_hugetlb_folio(struct folio *folio)
>    * stable.  Due to locking order, we can only trylock_write.  If we can
>    * not get the lock, simply return NULL to caller.
>    */
> -struct address_space *hugetlb_folio_mapping_lock_write(struct folio *fol=
io)
> +struct address_space *hugetlb_folio_mapping_lock_write(const struct foli=
o *folio)
>   {
>   	struct address_space *mapping =3D folio_mapping(folio);
>  =20
> --=20
> 2.47.3
>=20

Reviewed-by: Jane Chu <jane.chu@oracle.com>

thanks,
-jane
