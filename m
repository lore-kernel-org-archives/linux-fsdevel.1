Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783FD346E64
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 07:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826898; cv=fail; b=Mq8ZtOA7S07dOYpX55ySylw3+PUHiXwGhodHwFng6JRqf4kIa2NObP0jdXU5q4pKLb5G2EQBlC2gN3LpIizwihv3uRnOvMd2GMCZUh0eR10Xrg3lWPePumLWX9iynMATGa4Zkwr/XPZkJ0cS537ZVroSU6VjxlKbXjtP7I4wxCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826898; c=relaxed/simple;
	bh=jRlUsekhVb29oZ7zPWYjdZtUNF902J6764ClcIZTElQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 MIME-Version:Content-Type; b=AnDZt6VU8l0Zb1Dmd6tnNnm3uxFRlDkSmRkRHcQSMonESYi3CMr4aTz6OzYdTZRKJ40PlxH+08FztIoX9cvXMjXKMUDXlHxMkr8Fe/qYSfYXtkbhnzvfeMoZE47DGberKoGcqFWE1a9YtxslBkGwZCt5sx1RmaKnF56iWYELzjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZiCJ17vV; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pc4LAQNO reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZiCJ17vV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pc4LAQNO"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673LJ8dA2712797;
	Tue, 4 Aug 2026 07:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=cVdA/crBC+w3WmksbdJATloQmbafNlwLPeGAgZYJ+xU=; b=
	ZiCJ17vV44/xFKiZ9xPpouz3P7LILP+SetaesltkSpLmurzGzTXVNyFAd5nwB9IF
	9hCWUbIdrfmSdGBSn7wGwTRt0/7/5lokowiF/kqBxI9CNJU1PPmchwt/cMCk+iAY
	geseOwpDIjEQSOisoKR55Ezr5IhV4x4f7NPKbwxuzHUPJLnGHML41OqNytPX+VhE
	bK4PFxxYNDEYetFxgT6dnLt8+Q/2dTF4gtd90/uulIoQQ5ju6GwdsYjGhkiRJjGR
	0RsgBx0p0R3Pys+fNMC8Vi1b83zicovvbJTmoUnwYRsonkng6FcQXeQsGf8A2uBR
	XdP5vqfYmD/8FIcm3drRUw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs9bt500h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Aug 2026 07:00:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67470b3B027460;
	Tue, 4 Aug 2026 07:00:54 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78tdtx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 04 Aug 2026 07:00:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iV7IpeHRqq5d0YuZFY6zETuGoeQ1HMc697yMcOskrQvTlUb41JP13Pr1vid5YEHAsKeDZCrsM2AFCFzXlIS6UrFeD657BLAixfeMX6Uo2Oi0usF9HZIrBcJtVZgZC6ExU3xROhLKSvCFwVDxESsyhjC9HW6yaopyKqE2PyvbHJPwT+XCGPMPfUEHoOSR2Ad72hXJpv62vkSR2fi4Z9uGcjZo7O9i5oIe8DmJA5qyL4d4N1+drMEaUvUL7h1THx0gBazGbYEIDkSHUetVEgcHoII3EbtL0M6AeTqOIOsDwL1iDodELdlxuNOtvcIPXzvasydwJIHvn2ixdqF0/SJ4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GiPthG5tCmMHmlawXjzpm4QOFddn394pyKG883gSqtk=;
 b=l3x5hGx1YMgpJZ2sCV9juJFbzRKo0KeLx3/19SbWOJ8tH2st6+eq23pod2k1ZQni/sDtANmTEYuUNQe6mdR46sbVTJLhfnI164Tn6uJ2OyLEGPhIzhqn3noLHAgATUUt5KLgWuE6iSTuWg6XVcfHrgTpMQUD2vDumZtx3pL77b2B33HEfjxayFyrjdDnfJceXAD5dJkAztdOIgJ1UAxsHKyK0VE1+m9WZtfOfzlfgf/BVpVhIRzCkhGrEqh4afqrdth0bBfTWb4KIVlWelVmyl/XnWBBfiUAHtRO5XWTvf9Snx/0EoGCnIHiivLNC4izEr1CjFhQ96Qhw7g/J4RXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GiPthG5tCmMHmlawXjzpm4QOFddn394pyKG883gSqtk=;
 b=pc4LAQNOAT4HwsSFcaEpW77dB15Kv1Zo//pUSVFGgezR5gO5nuIkjw2uoeKqGIsMot/13sO+Z9BRQvq8vK7x+Ps8MoNtLBR02rvpby03hPjRdFyvBdGOoUoWzYCXMaBFF8kOsT/Lqrfr7H0FMG52Dbf/iFgMxuhtpcQ5IwiDF1A=
Received: from IA0PR10MB7369.namprd10.prod.outlook.com (2603:10b6:208:40e::14)
 by DM3PPF1652C44C3.namprd10.prod.outlook.com (2603:10b6:f:fc00::c0b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 06:59:35 +0000
Received: from IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e]) by IA0PR10MB7369.namprd10.prod.outlook.com
 ([fe80::bef9:7d0a:4382:978e%6]) with mapi id 15.21.0270.016; Tue, 4 Aug 2026
 06:59:35 +0000
Message-ID: <064a328e-3a07-46b9-8daa-624a3ed75fb2@oracle.com>
Date: Mon, 3 Aug 2026 23:59:25 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 10/15] mm: Check individual hugetlb pages for poison
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
 <20260731200802.574821-11-willy@infradead.org>
From: jane.chu@oracle.com
In-Reply-To: <20260731200802.574821-11-willy@infradead.org>
X-ClientProxiedBy: BY3PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:217::16) To IA0PR10MB7369.namprd10.prod.outlook.com
 (2603:10b6:208:40e::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7369:EE_|DM3PPF1652C44C3:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e0ba36-6874-41cc-be4c-08def1f5f14c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|18002099003|22082099003|4143699003|56012099006|4133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	hgA8HOsk9clNPtH0W+6dEqHU+v6qt/iCj2byPm8qjExPn5ieRNSyx2/tQdy7aWyOHE7XxB+Y9J2b6AxAHUsHReQTf4W1fGC9DQRb8yglFCBKgctOCfcs/qnKe5AWFEAIQpVJ7A0jsAm7W9FkBzUGcMWHzbU5sYxqWPJj32ykeenc80bX7RmPqlfMaNFQGd8DgiyBVVrB30hbQfQDxdEjR6nZHavjQIrqZqbfBIg0VIKhMqe4N/iU8vxJgd4c9uYQ9sTw3I3RS8LiCmQpoN3hXKRue5B0Kc9xMWq1DJShyRg2FfvEQUWRbb772NBIzjX/4n7lbbq+uSoQ7WE1dNg5469Sq48eciR2X+elEDDZcSPPvMtGYvg79FW7t/EcnOfFYKUtLJKg0ma5EAcvpw45jEqiFTrM3D02hkIupJRwuS+lQtksFJP+N755QoGp8XZfUM4GYkA/llu8EreJ/dcFq4cbTY+gLKXzg4Le9Fumzu1B5zZbPLe0t/LQghpweOH19E9h/1nuRWd/4X1KyqsRQyHQ9sNxHGS3/in5nvZdAjbaSj+8KvHjzUWAl4fF1Z/BPB7+HuBgzAbmyM/JCyG3vm6GU3UHUjiHba61dU08ikZzsbfPj5EWD1sueJBoSO3Bw1SW0BI9grtKK7LvGD5/BnLrk4RLrQE55wcYfWHx0BY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7369.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(4133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVFJZGJmWFFKUGFndEFiRnJ5MHRCNm9hK2ZaWXAySnhxM1hVOGwxZXJTcDN2?=
 =?utf-8?B?UVhLbjM2bVlLYjJKN2c3UnlUdUN6d0pXdXl0VDBMYzljS3Z4eEVGVUZiYnN2?=
 =?utf-8?B?ZHBVVzFvL09BNERzWEdtWlFZZFVvZi92dDZrOXZ4ck1ERThpSEMzYzY2ajAz?=
 =?utf-8?B?Zi9aYlhZaG1RY1RZbU45bExHbXVyMU1JMk13dlF0dFZWL0hFNk5oWDZEVVJD?=
 =?utf-8?B?U080dUFRc1g2MTNNQkwybzRYaUtOZzVRWGVteUhJR09NOTdwRXFuYkZMWGlG?=
 =?utf-8?B?cHlkYm9yR3BhemQyT1NPQWt2RjhWeVRaYVp4TVVCTVF1Vk94SmVzU1d3bnhM?=
 =?utf-8?B?eEQ4bklOU2V2cTJnRHo3U0x1Nmx4dllTWkdwQU5iWFBqU21tVUNkSEp0Wm1i?=
 =?utf-8?B?YXk0eWlaSWs0R3hDODQ4WVhIdmhta1FIanRZczdwN0g3ZHcxMjBDK3kyclZC?=
 =?utf-8?B?VXdXcy9jVTJ6T0lyQndTSXNvci9KbkE5aGF0ejh0MkpkWHZOVmN4MnN4SXY3?=
 =?utf-8?B?Y28vVHhudVZlRUZrekJiMUxFOWlUM0pWWDZhblJNQVcyeTlzQWJJMStQb09G?=
 =?utf-8?B?dUVxUE9uNnFOTUxiTW5OTG5vS3hoTDVZclF1Z2pyMVV5WnA0T3lESkZxeUdh?=
 =?utf-8?B?ZFdXenFTNVRCU0o0dkdRTFN5TExOWE1KZDB3SlVKOFBxNTkxb0Nia2M0RnBj?=
 =?utf-8?B?QXIzUTNmQlI0WkxMTTE4WHd6Mlo0Yk82N21RZmZFeGZzVDJvVzRtbUNJdlJH?=
 =?utf-8?B?ZHVzN1NMMnRranIzaXlFWHBhSVNsTjFSRE9ybTcvZmVDcGdid0NVcnpiNU55?=
 =?utf-8?B?eFBQeG81UGhReWdzV2toeWlpS0FHcTRFZi92ZWZVWnJ0M3BrUTBWcFhIWTJ4?=
 =?utf-8?B?VzZEcUltQzhFbjJkeU1uTlRwNEl6aXpYcTF6dTFsOEMvUlV2VnpoQlZMWEp6?=
 =?utf-8?B?bENYUzJ5ZVRBYWJqMTFnQWhUKzJZeGQ0aGROM2l1ekhRZ04vWTVRSldna0FQ?=
 =?utf-8?B?UGZsc3lzTFNob3JLZlNYMEtuSTBmbkJoaVFXcFpINm1zQ29BS0xNZTNqcmdw?=
 =?utf-8?B?RUJTN3pDTTlUV3RvaGZYdVBtZ21GYm9XQTE0aXQrbzRRSWd1V3BlakR3NnU4?=
 =?utf-8?B?Z0RkYTFCZHFZa28xKzk3UDZBQWkwMFFicWFEazJxNzlzQmtCV1kvbmgzd1hQ?=
 =?utf-8?B?UVl2RUZsalJDR041cFhlNzFac1FtYUxrbDlQNUJZU3NJRjc0VlZuY3RRT0h0?=
 =?utf-8?B?d2tTM3dNTkVWN051czVnOUNVMGRWYlVZV3dab1VmL29VVDdqSGhRT3FQWkla?=
 =?utf-8?B?ZDZGVThGeHd6dEpEVzRwNXpzSjRxVklYTWNZeXU5TjlKQTJPNTVoc2xqenRy?=
 =?utf-8?B?aEFzUzFRd2drTnViU1JIWFNObFI4aFZmaXhHT1BvVWFRT1llUnJZcWdmODFj?=
 =?utf-8?B?QWprSFRpU2tybWwzNm5FMVcyNWRxSzRLTDZPbDBOV2dKMTlXeEFCM2dJWDNZ?=
 =?utf-8?B?QXh4VDNGRmJjVS8wOCt5d2xoTDBESHpVUE9KVm1MV2R5d1ExVVVXM0xTMGMx?=
 =?utf-8?B?MW1iWXVraEc3TmFYNHVTbGlURVkxYnpIUmZ4NVNHQTAvRkJ3eXd0RmxrcmI5?=
 =?utf-8?B?RGxkR3N0L1NzMXlxcGd2cUZ2Qk41NGN3S1RwMHMrYUJiNDdjWk1pb1lmRHJh?=
 =?utf-8?B?NkpCb1ZFSXZERnZPUEowWlA1VDBiMGo3U2loSGNzSUszVkhlQnEyRXpnNklX?=
 =?utf-8?B?N2ZnVXVmTmVtNWhLdE54MTF2Rzk4ODFoQmNGRDNwdlhwM21kUDllVEM5RUFa?=
 =?utf-8?B?RlFIa0NmTVRZdUFpWUROTlRGY2gvMDZrbWNVS0d4dlA1akk3R2dPdzBxc3NI?=
 =?utf-8?B?WURFODBIQjdKWkc1MUk5b0cyRzJPQWw2VkgxeDJraHVkbFZVZS9ubXlhUG9T?=
 =?utf-8?B?akVreWFta05QZUExd204cW9UZmI4emoyV2FBMEhZc1hHNE9WUGFxZGhwNDVo?=
 =?utf-8?B?VHRjdDY1eUpuazNVVmk1S2w5b3pXTWNSRzI0eWF3S0hacmxGRVhxY2tVTXBQ?=
 =?utf-8?B?R3VrbDBuaURWMTdKeVIxd1lPRlFlb0hlVXVGMjd0U2x1YXhQc2FyUU1UNVR0?=
 =?utf-8?B?N3pCSTJtM055NS9QUjZnK1h0eExPQXlUMThUelJ5YVJxbjVxajJkWkRyNXhL?=
 =?utf-8?B?dzEzL2QrZjI1UkhEL0EzS3RERC9yV2IvQmZLekI4K1lHanB4RDBXRm01TS9G?=
 =?utf-8?B?a3ArUzNiYjVGeTJ3d1hENjBXa1pXM0IzRHg1UVRVaUFGbVExSC9pL0ZWVmR4?=
 =?utf-8?B?WUhSbm1IV1QxZ0ZTZCt2VHI0TTkwTTZwRGM3TVRVVGdYWkt2OUxWZz09?=
X-Exchange-RoutingPolicyChecked:
	JeJB3okYM/eQvCDF5kmQnYTmtzv3uA5qzSCQzFP2fZitKa7uN1bW9YSqGJqNkKrEvVuIj1x3oEVMFXYtdMd/gq/Q1OQYV9UHMrf/vEzX0RvWwvYXlNnH7vWo+LXbsK1WozWIXNDuCen+tEZQCkUQ2qkHyPmbOlO3qEX7cK7/086hctMSwfBoetPab5lIUvnE4BYg+FSnwfu6vt9oyocjIaN1qDl0QSyKQaxueO74nGyukB6GCpXjy0gzn5vMJ1vn3rd3PIV41a7GItgPqrGxS5cne/6cMyer3LeLnv/7J9HSvUufbZHrEFN3rZCkmVUA1LrE8HrU1EEJo6kX6DQoig==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Agc5/HgO7C/VBxkPkVCf9SorxAOGjiWQbcQ8hs22hereMTCsve758y8FasO0jqNpPLxIAapXbtDv9Q74jhNXm+NPUz74HlHzw9Q6sojfwFtzwRBUE4VoS92uk0h4wNbKVn+aHzgN7s/K7m3UPGS+KVSEMnkisSqgzOZ4h1X+MAvOYN/RMDzSGsMZGSnFlD45JS4Y/nkr2s9AgbJqZ+j7mK8S9SuG7lPIJSmwoVwASzbPg6pS3zXX+O1EwogkHYd9viaXKvTFpF98OhZUezZcRhkrBNbDCejmdQci4e06JPHXFDhA8+b1yjAVhxpHNiQClYadv4lbLA0flGeD0jsg9JG8Ie40YmHK9lLIN+mn3eUt0zl4L10psWhIwJuxJVdfzLHjEpfkfOlo7rrelifYDbAX5h/NzjfykQ8G7nEJmqmotyeJw0FUeSuPzlMsegCN2EGEjnqN9drnvp5coGqVEQvhtIftuFAKe3xVrCzIks6GA7B6h9HpaiIvYFY4R86WomMfC/65t8JYZcHTd0Z24C1Dfq+0G0f3xPknaKWegEeXno3mSTJW2zEE0sddHW3DylTuH33UkVDdj0y8knzMkhYa6JP63Yvhc3zW2jfGKK4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e0ba36-6874-41cc-be4c-08def1f5f14c
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7369.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 06:59:35.3297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5CvclzzTI0KaEaW/I4THcGw5ZPBz8yWrDm3PFVukQh4IZOLiLTFWEIFjy9g+3kdZrUMaY0gXXiOMuTXrJimrSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1652C44C3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608040054
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NCBTYWx0ZWRfX3pleFXVyMrXf
 oz3HOARyQM2RGEVly+0v5QVSxk7SzL+xWq2m3UDgA4QbTiMzwWqcfX81u5s8N1x34D915f2tNdE
 O/Ic/y+g/5Jy+c8h2u0cBydvWt7h3EHx40iibDXO02nY2nRgaFlA3eoMwK56bmeFk+M1u/lbm0b
 +keDE2dK4PfkXq/VLk5cMoYzDlM25CbR73ZH+0YNlYfNIFsIkZl7fSzZQXx4YxUJgIDnUDgF+do
 m0Xi296hwkMem+lC5iXZZHe1zoeku3AflEbU7LZth/M+K0JSuI5Cud4PqY4PFFOa8p2Jkx6mkud
 fZD+NJ0Tb4NaWC4EAzexYnPnk/+FvPEcEChkoh4GXqgX7OnR3vlEoGEt5NEAPUGxkuftO3vQKkz
 Ait0q0x8/q5NJ9oUNlPW3MQkJlCWD98gEPeARXy6vnUaVrYgrngPBNRHuKsazHIlBOvheRVfztP
 E1+z7TgPwnDueoNOtzdMtd8+KY4xiCsJS/ye0WCE=
X-Proofpoint-ORIG-GUID: zJz0X06ukF3swChmaSrQ0NsuyS2aBuXi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NCBTYWx0ZWRfX34sxWJ07lct3
 7FdWF2/ARvCbqj8eZvJVv+ev+19UYDGHIjk45sUcnHmwlyDaiV37K7TSzv5UzYcW2w07XvyrtXr
 28resKU0ek27HHAX2Phvj+KK2sp3l6cnkP7tXiv5HtaHFBRcrfeY
X-Authority-Analysis: v=2.4 cv=ZOTnX37b c=1 sm=1 tr=0 ts=6a718e27 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22 a=RpNjiQI2AAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=PX_lDwNKtqXEm_iy6PAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12100
X-Proofpoint-GUID: zJz0X06ukF3swChmaSrQ0NsuyS2aBuXi



On 7/31/2026 1:07 PM, Matthew Wilcox (Oracle) wrote:
> So far, is_page_hwpoison() has returned true for the entire poisoned=20
> hugetlb folio, but we can usually allow access to the pages which aren't=
=20
> poisoned. It's slightly tricky due to not having a reference to the=20
> folio, but the hugetlb lock can
>=20
>=20
> So far, is_page_hwpoison() has returned true for the entire poisoned
> hugetlb folio, but we can usually allow access to the pages which
> aren't poisoned.  It's slightly tricky due to not having a reference
> to the folio, but the hugetlb lock can save us here.
>=20
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   include/linux/page-flags.h |  4 +++-
>   mm/memory-failure.c        | 43 +++++++++++++++++++++++++++++++-------
>   2 files changed, 39 insertions(+), 8 deletions(-)
>=20
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index 4fab3fbfd430..ee026ba9b0b5 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -1094,6 +1094,8 @@ static inline bool PageHuge(const struct page *page)
>   	return folio_test_hugetlb(page_folio(page));
>   }
>  =20
> +bool hugetlb_unref_page_hwpoison(const struct page *page);
> +
>   /*
>    * Check if a page is currently marked HWPoisoned.  This check is best
>    * effort only and inherently racy: there is no way to synchronize with
> @@ -1108,7 +1110,7 @@ static inline bool is_page_hwpoison(const struct pa=
ge *page)
>   		return true;
>   	folio =3D page_folio(page);
>   	if (folio_test_huge_poison(folio))
> -		return true;
> +		return hugetlb_unref_page_hwpoison(page);
>   	/* In case we raced with hugetlb transferring flags */
>   	return PageHWPoison(page);
>   }
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 437a2be6c58c..c0a402522c21 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1820,17 +1820,12 @@ struct hwp_page {
>   	struct page *page;
>   };
>  =20
> -/*
> - * Check if a given @page in a hugetlb folio is HWPOISON.
> - */
> -bool hugetlb_page_hwpoison(const struct folio *folio, const struct page =
*page)
> +static bool precise_page_poisoned(const struct folio *folio,
> +		const struct page *page)
>   {
>   	const struct hwp_page *p;
>   	unsigned long flags;
>  =20
> -	if (!folio_test_has_hwpoisoned(folio))
> -		return false;
> -
>   	spin_lock_irqsave(&hwp_page_lock, flags);
>  =20
>   	/*
> @@ -1851,6 +1846,40 @@ bool hugetlb_page_hwpoison(const struct folio *fol=
io, const struct page *page)
>   	return p !=3D NULL;
>   }
>  =20
> +/*
> + * Check if a given @page in a hugetlb folio is HWPOISON.
> + */
> +bool hugetlb_page_hwpoison(const struct folio *folio, const struct page =
*page)
> +{
> +	if (!folio_test_has_hwpoisoned(folio))
> +		return false;
> +
> +	return precise_page_poisoned(folio, page);
> +}
> +
> +/*
> + * We have no reference on the folio containing this page.
> + * The hugetlb_lock keeps hugetlb folios from being freed.
> + */
> +bool hugetlb_unref_page_hwpoison(const struct page *page)
> +{
> +	const struct folio *folio;
> +	unsigned long flags;
> +	bool ret;
> +
> +	spin_lock_irqsave(&hugetlb_lock, flags);
> +	folio =3D page_folio(page);
> +	if (!folio_test_huge_poison(folio)) {
> +		ret =3D PageHWPoison(page);
> +		goto unlock;
> +	}
> +
> +	ret =3D precise_page_poisoned(folio, page);
> +unlock:
> +	spin_unlock_irqrestore(&hugetlb_lock, flags);
> +	return ret;
> +}
> +
>   static unsigned long __folio_free_raw_hwp(struct folio *folio, bool mov=
e_flag)
>   {
>   	struct hwp_page *p, *next;
> --=20
> 2.47.3
>=20

Reviewed-by: Jane Chu <jane.chu@oracle.com>

thanks,
-jane


