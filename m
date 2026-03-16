Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE461E5702;
	Mon, 16 Mar 2026 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773696052; cv=fail; b=dP24UVXkLPDgTUJXXEyo9oBFuf+1j8tWMszX4K6KoxYUSQ2w6qedhEJOGsedb/u6wTs4kCgM4GVF4f3naup0Zz6nzB8i/HEXn/DsnK+qc5PsRr8AeR8NH4o6nOn/TfXCM64+XNRg8+0hMmHURGaLlcph5tS/iIt9RLMuLulTbqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773696052; c=relaxed/simple;
	bh=JKj7CodRjyUmXl/dmVOq3G1H+pIZ+ZLWPmjq69rMOsA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l/4RLPSQqxBi4a+kJhZMDyP8NCPpsxXhqEzY6uC8odvZBBkeVjYTXmAi6hkktyqIXrO13fXadm17z4zi8hmWzs9E1q9V+cPWrODWK+YNzxpbiZHcHL9e5RCbUbZ1RiNA9aPbq0rru+k9ZMvgRyLVNgchWFMGNikhltQAWXq/+rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CZKr7My8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lPvykDJ7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CZKr7My8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lPvykDJ7"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GD7koo1579256;
	Mon, 16 Mar 2026 21:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Ak57KxBNjU1ywTT+E0YR0wwFQ85ex7XhT0squ8R/PsU=; b=
	CZKr7My8/r6JbImLqK55jznYxbRP5rsMFEClhsBMyOAEtyqWODwHSGz90VsN/ZzZ
	hKTML3PUk5guSk4Zd3Bh/mWCe1nitsCSIE5F8NZ5cDeuhyY+QE7d1/7PpPPi9v9A
	t8eC+vo2O2a2+vP6GavnwM6sZ238PHDX5e+qVZzlS2le7tih/aB/P6EwYfI5Y0Mb
	N7iIbXN6YoueND/dqn5bo882LqTyFHlXVg3CCAxlhk1jCuQ7W7UT1pcTikrq0kOq
	rKibyXfnR22zEHigK5kAAJnM9F3fnt0z0Pt97IRsVObCtBlqDOtKlrcola4LPih/
	qIxeCKDIFTYgj2id/LbJ1Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvxf433q1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 21:20:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62GJFWJJ017825;
	Mon, 16 Mar 2026 21:20:40 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011051.outbound.protection.outlook.com [40.107.208.51])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4kpsbj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 21:20:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GjDLcRgkaeYfmt0mAT4qS9P5CP8Ive/RmNeeIJc/dwcJOOr4VIKo3oG+fuQkNBiS+cKg2B6qz7FZE0tSbEwh+0zCYQGpKq0U0p+wZlbOSoIOrpZ4lTXdn500X8CtYuHRxRwlbS7J+n70MwmmUuxb+0HGJ8lGk+ztg+MewUMFI0s8WRU7UNqfQLb6tja8SAGZHcHJyV9xNwmjtTZForQ5Quuv74LYpWWT16o9B0uZn52VYpm59JFlarRneE2oXR2HvMdGQTeDPhRYcWas0OhAkbwU7HKUMja25ABf6yw+3/BaPVRhRzEzxsPlbOPNWhk5dku7+o5gz5XiEGjSKbuFwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ak57KxBNjU1ywTT+E0YR0wwFQ85ex7XhT0squ8R/PsU=;
 b=DewNQcHntlSPTnkjaSg/+TcIO4Lb+jD6Y1aE3DGK5KLXyiFboFNktzgUKwX0MW4vrqIkguh3JB73ln3vPw2b9tatiPDhniYPho9H0Ljj2zd3dJJRzryPCFc5cWkDO3ACXF5miNB3GTVlY0Q5ig1Z6ECvO5pG5gpGHUfDxHq+NzMR6aflIh/RX6hf+fa6NzJELTUxD9NfMDnfr0Pl8NJ00vEyBaoDTWKE7x22ES+yqfpIBe01/mtxQRHOfep8FR4SPGKuW+7uXxlV2vNHi9rGCq8oD3veiOY0ezIHUL1qJ2ru6Nz9r8bekg/0ALbSa8zfRDyn2PZydRGNyFit13yNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ak57KxBNjU1ywTT+E0YR0wwFQ85ex7XhT0squ8R/PsU=;
 b=lPvykDJ7fYAjmQFfSlytWqb2+Jv8MyvdJYItHMwn6lPH3+C2/kDlxIbpTot+u8R4LSdLHLnI4o7AVfILKeGWgkxh9/wbewC+ZEropLpjqM1nl61trdWHYOuiszAaFyKmBFzqiHLqXQFyD1s/15ZSfHHGYpWfHtAbuduD3Adn6Fk=
Received: from IA1PR10MB8212.namprd10.prod.outlook.com (2603:10b6:208:463::20)
 by BN0PR10MB4920.namprd10.prod.outlook.com (2603:10b6:408:128::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Mon, 16 Mar
 2026 21:20:37 +0000
Received: from IA1PR10MB8212.namprd10.prod.outlook.com
 ([fe80::ee8a:bd21:f1cb:c79a]) by IA1PR10MB8212.namprd10.prod.outlook.com
 ([fe80::ee8a:bd21:f1cb:c79a%6]) with mapi id 15.20.9700.013; Mon, 16 Mar 2026
 21:20:37 +0000
Message-ID: <68c4f607-dfe9-4f39-9bfb-a6397831a9b1@oracle.com>
Date: Mon, 16 Mar 2026 16:20:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: hold LOG_LOCK on umount to avoid null-ptr-deref
To: Helen Koike <koike@igalia.com>, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com
References: <20260227181150.736848-1-koike@igalia.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20260227181150.736848-1-koike@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0412.namprd03.prod.outlook.com
 (2603:10b6:610:11b::24) To IA1PR10MB8212.namprd10.prod.outlook.com
 (2603:10b6:208:463::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB8212:EE_|BN0PR10MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d07b61-c415-46cc-657c-08de83a1de4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Dgv8+T6ebDf7eMxoKbELM9v8jQEXeNL9mhryMF+SY+tiF3k8YcLG2b5lF+i3Zyg0qVly4wfac4iGvH7+loCg8ZYGfi2Ce6icxtM15BsqjxaXAfaNnd+6clRCQ0ZPilKldllGoM+Kzjw82TIMHF3Vn44dmR8hTfdvxgfo+WqAfQas4EQYYRMFfc7JJtiFBKJ8KFK33ciy3aJM1XruG5MRzqvU+zoILR1VzJI9GVgKPCSeIejULXbPLwjq8gKvdRrn+ejyZjv324QJyBoPdEw4LMnl/Nw8zGShON4goGvA6nL5Ec9R+NBFTWEJvmJgD2sjNNkulW3IavTYS6sHc+WlCDLZmaKVsrvY1BmmqNeFGazmxWeD9IWLdLbLHkwW2LApZELctWYwkhEFaAdgSptcw8NEPHtq0N2bZZr34jGrNgJCiVA9CILS2haJhfVnoDZWe5kv6H/2e2RDBJtFN07AMuHNhmfUcPhOk68ylphRMpeIAIQTc7L49qs/dqJhGQIX/6dmfNrA0W2oy8fVf7r4AJnMYOQQR+62Crs34kOBdFJI89cnC6T29H2QtTdhSZn0f4tubXUcCvo5xQZbzMF3ExXIOCg4n6w/JTAPXna5RdW02CzrliHAo7mmtZj82zb2uxMBEoSU5KSCtCKLbOod9WSMd2eom0Zt8YpDs31Mvyk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB8212.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUNGY0ErNjM3eTBLRnhNTm50d3F6ZzgrSGhvMG12VGNrK0NoallOQTRaOGhp?=
 =?utf-8?B?eGRwcGpjY0gxU0s2VGJQUmREclFhZlVHUEdHZW1tNGU3TWlmNEo4TnlrMjJC?=
 =?utf-8?B?M2hmOHV5K2hPZ1pUWGtXeG5Ud0MzcTRtR0IzaUZNZjU5YUFuV2l2UG90OGxT?=
 =?utf-8?B?U0FPV1dBSnZjYWI4YS84OTQ1OXB0UVJuUGlEbjhKN3RuZVlIZFRpdk1LL041?=
 =?utf-8?B?VTdiVHlPMWFYVDI1eWVRN05pSjU1d0h0VGgveTBabUwzdjFBQjBYR1Jzajhp?=
 =?utf-8?B?MThzUUlhaGlzZTVEUnZsNlFVbThJQ3F0MEhHYm1nZ0h6cis2Um1QQXZhOGpZ?=
 =?utf-8?B?aVh3UUdiNE1rLzNCR3Y1Q013L0JWRjd0c3luNXJwaU5GY1NsRExHNDQ3cVdZ?=
 =?utf-8?B?R3I4ZjZvMGFkNlZWUGx6a0ZneElXY1l3bEdCWlFXWkUrN2tkeThXdFJCeTVJ?=
 =?utf-8?B?YnNzNmdsZlVacjZWUXVqYmdvSXZQVC9aKy84TFFIMDNXTmVXK21aWnFuZjMr?=
 =?utf-8?B?VWdMMFVHMnFBVkM4M28xWnlmNG9NZ1krUGRkM0tDT3VhTHMxMTJkRzFKTmlF?=
 =?utf-8?B?RUxCbm9NV0VKM0JETGZ1ei9zN3hOQTJuSlJSUHlvdklaM1dtWHhKN3lZRkFP?=
 =?utf-8?B?UFB2bzdoZkJQZ1p4c2NjdS9qVGNXcWRCSG4yWUpsRDROMS9rOGpybnBHaWt0?=
 =?utf-8?B?OVJoMTVMVFpsdlN0VEdjZzNLdmE1ZDZxZW5kcG5jVTBOeERVMk90dlFXOStx?=
 =?utf-8?B?WFVqa2tSVFhFejJSODJ0blJWTFoxVXVYb1IwcFJQaHZMK3NYN1BTcERYb1BO?=
 =?utf-8?B?Q2tqU0xLQzh3KzBjTkRaRUJ0VW1kRExYcmx1a0VXZHB3WTZxL3hTQnlpbzBT?=
 =?utf-8?B?Vzh0czVGdnRDUXhmZENvWFJlNnVCUFNtNENTMmFHSXZPWEZmenY1M09yN2hE?=
 =?utf-8?B?QTFvSlVtUHRmWFhxelVTT295Vy9UQ3BwZmRWbllGQzRNNnlpMm40bkFTczhY?=
 =?utf-8?B?TGpSUy9LbmUwK3ZwdVlPV0FyY2tVR3UwOW4wclNOZUZzZnB0bG9FcWdqTjgx?=
 =?utf-8?B?Mm9yTC95bGIrdm5ZOTcxaHJGRlJqZ0xybFVUR0l5cWxrK0VkSy81Q1lwbEtO?=
 =?utf-8?B?VHhyWHhtbkpaM3daMXlma3lGZ0RSNmVOMThkQ3FsaVo5TzNwUGVVZXNxMHg4?=
 =?utf-8?B?bWpOVWJxR3R0ZzVpMjQxVVd4VkszUVZGNGlOdjcza3I3d0tRc05MeHBCdG1D?=
 =?utf-8?B?d0lUNVBzZnB6WUsxdmREUG9VYzVVQThsMytBMFU4dVZFUXlvbGJtZi9sVHdN?=
 =?utf-8?B?U2wvR3Y5TjJkQlUxVXV6WnhuNm1nRzZWSTRrUFNsTXJtR2JjNFhHLzJSZ1pj?=
 =?utf-8?B?aG5aL0xUQVlCb2ZtV1VmLy9VUllEc2dBMlM2Q1JUT0t2Mlp1TklMcG1RM2pv?=
 =?utf-8?B?Zy9ZYWx4czVJRDFHK1pVd25KY3FTOGcyekJDTk5ZZVdRSldBVFQ2SHgxNXN4?=
 =?utf-8?B?WUQ0NHM5NUY0cXNEeWx3cDJydHdmY2JEOTZhcG9nVUpWSUJPaTdkMGswWHdC?=
 =?utf-8?B?dkdrMGZ4Mmp3VTBXU1dvb1c0bXR5YnF2OVVMYTVsY0ZXS0RYdVdnekxJRTRx?=
 =?utf-8?B?TDJZVnNxaExXVDlSRUovM1hBMHdiWWV4L0lwcjMwd0dpejNRSGZiOXBiTHNI?=
 =?utf-8?B?aXFuZys0Mm42dDFCbTQxTVU2UjdvQktadmNkbUZveUZCaVdSZGVUSGpDQlYr?=
 =?utf-8?B?b0RSK3RhZkYyYmRkS2NmVUJzTEdSN1U2UmY1YVp6bStVaW1aUklDTDJ1V1A0?=
 =?utf-8?B?WDFMK0d6a01mRWRJUUxGV2xNZm03NDRWT2ZWUlhuc2cwSkI4Szd1WXJ0a2JJ?=
 =?utf-8?B?ZXk0enFXTFVrWEtiN1ZWeGt1VWpETzRkVGwyWEVTWnY0OFZXQVpzSFBaVjBz?=
 =?utf-8?B?UHZRSG54SzFiaVJBZGtBNjgwcUhDbVNaN3lKU3U5R1BTaDZaekRCZGZBenph?=
 =?utf-8?B?MnZETExieTVtK1dXeXNZSFluSW5nKzg5QTcxWjU2UXUvL3lheTlTSkRNZkkx?=
 =?utf-8?B?YVh6bTlUczF0U0VDbFJUTnlhVGJTU0hhZ3UzWXJpOFBuTlh3dDVYNTBCTEFJ?=
 =?utf-8?B?WllwRGVmSjF2SHpHZERTeFJiTGhCWTdnYlBBZ1FNL1UwZkJReGlrNFJlL1V3?=
 =?utf-8?B?bFNaRHhvQ0tTR20rbEVhRXlLTG03SVJ5ckszd0Jwelo2S1YzcXVIck1Od25I?=
 =?utf-8?B?Nk8vdVdsWUdMcVU1QUEwaVJ3WVJyZFpqMHdhZXdTZXY4MEEwSmRDbUx3YWJv?=
 =?utf-8?B?VjVNcE83Y2FveWJuU005cTVsSDNTTndaay9WNHA4VTl1MDI2dTBLQ0lvZTkz?=
 =?utf-8?Q?rJydiia4ggJpLUkY=3D?=
X-Exchange-RoutingPolicyChecked:
	i8rsGRg3nt1ftmY/HFO3yiuA14XH5mRWK8Mh+ucKdrYRcOYxYnGtQkdGuLgQDxDQoj7lg1fkl1jZG8OO7j5R1MSdqOz7V+orCVLFtl1IrNC5XQg8gEfBkDGsHECFtyeE1jOTJ3V0dH/gGaITcFZaMq9ighFyf6sNBI1nIPxKL6qopjBHTTyx6KePLtnumzJ7/p+p1KXcje+fSrBP72ftJ/Y4CWTLkPCgF93c77tZTnRrq+TR+PvN30YPM92ut2pqcxcRb7cCDaxwgR/ODikzQvHla5izXXQf7kH6BLcwezf/X9x0B/YDSp1CLEq1wCUCk3s6fIwSu2ZisrEuf40A/w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2o6BFhP2jFx3IheSe+tFyti+dabqAXrp2ZoFG1PJ6hhKrRE58S6kMvnju1HYnDwF8UyJZxmJ0J5Haj8OwbdbWbVguP70co8aCRWFeSJnCbCixPc+RDOgZiPC9JEuxcEUDVugOZn7Uunaa2ZPpQXaz+g4Rc8rELPWzD1Zi8hlg6+RsVuuUezJAdScg17MW+yWMbenOn4gJWAeXedv9JPiHdpLXTtKQJfEskrCZI8LUxCnJfApRmXD35fcyHx7wca/22yqdr8YYpN5tf3haBNeU6bQRxKMqfIz8Qjg0KrygJxvZFDDEq3tuSJu9rS7hBJ6EBctpJrpBHG954G0uoFVDBvfim3DPukFXU9LnY4AQiH/UdPesLYr0ysicRj3SVOH/bHBn+pL1MqtOBhOM9Ecwgcf59xxQjRwsfTJnjgXkKwhNiq7i82MRdYLFveWAhipA5A03LRxd9jBa2MMMdEMwqdO30/Sm7ucRzQb/iHs0UNnyHVAaDM5pgJq34AAuN4B/CCmDSTKv9pFJFvRm4Ezme7v+9ee5nZ5voYqhAPITTUuV54tB3c/xIHEdPN1bHsoyNjvKoE7d62RcTiVR2gYDuWje0REopkulMdvqRzm5Tk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d07b61-c415-46cc-657c-08de83a1de4a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB8212.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 21:20:37.6472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/w6jUOW2/+QyQfX5J9z6jyuxkTNxh+tqsPsL6xtJHRCnk1ggZ6m520WtZ4C76fPKhbxoYSnfk0uirc6NZMDGmTWqWVeL3BAcxUSKet2e/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4920
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603160174
X-Authority-Analysis: v=2.4 cv=ftrRpV4f c=1 sm=1 tr=0 ts=69b87429 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=edf1wS77AAAA:8
 a=hSkVLCK3AAAA:8 a=V2sgnzSHAAAA:8 a=jbLZzuwi7hTS3Kcc_r4A:9 a=QEXdDO2ut3YA:10
 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22 a=Z31ocT7rh6aUJxSkT1EX:22
 cc=ntf awl=host:12272
X-Proofpoint-GUID: 0rlF8EpcQGKlKRYMp6kkBoyKdSbt8BbY
X-Proofpoint-ORIG-GUID: 0rlF8EpcQGKlKRYMp6kkBoyKdSbt8BbY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE3NCBTYWx0ZWRfXyTHR4KSIWuu7
 ZZLCeNeFfiVl0JnH8yqUEHsQrPrDQGn1jSmUgsSpUL+NCf+2Hzeue9NMuBMG2abl4JZDcD10web
 wogFVOGBq6SY9L1B5ZLEZpXu0FVCVojCjIXsQwyfmOlI39v9EHgInhSoHJozEpbLGmQLDGaHTfW
 /GF0f530wd3Y/kEUlHBbBJAFCt5fx0yaQBN7UMMm4eagMQ093VNAfmK+toRV1N7IQ5e43BScqTS
 naOhx9Kq+sCMg5MotpmMip8FmRGdnPZc1EhR3dJ2vrv8/sdyUGmv/ymbbJAS5zyNzlBTKstStCG
 P4ajoGG0cavjd4YY8zXcArV6XzOB122dPePnWxXxxU7lk6fT+RB46mVhMHYPALkP/9gpeW5AXgN
 9U2p7cKZ49atObBhjioiwP50tBASb2gkMZGNYhPGz4nJ0itQyElm0gO8olA3r5UTqWLrJwoWajG
 BGsPFz4JqNPR1dIBsfM7qAJGumMysjiCJRtfDIfM=

On 2/27/26 12:11PM, Helen Koike wrote:
> write_special_inodes() function iterate through the log->sb_list and
> access the sbi fields, which can be set to NULL concurrently by umount.
> 
> Fix concurrency issue by holding LOG_LOCK and checking for NULL.
> 
> Reported-by: syzbot+e14b1036481911ae4d77@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
> Signed-off-by: Helen Koike <koike@igalia.com>

Applied to jfs-next.

Thanks!
Shaggy

> ---
>   fs/jfs/jfs_logmgr.c | 16 +++++++---------
>   fs/jfs/jfs_logmgr.h |  7 +++++++
>   fs/jfs/jfs_umount.c | 10 ++++++++++
>   3 files changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
> index 5b1c5da04163..59f94c28007d 100644
> --- a/fs/jfs/jfs_logmgr.c
> +++ b/fs/jfs/jfs_logmgr.c
> @@ -74,12 +74,6 @@ static struct lbuf *log_redrive_list;
>   static DEFINE_SPINLOCK(log_redrive_lock);
>   
>   
> -/*
> - *	log read/write serialization (per log)
> - */
> -#define LOG_LOCK_INIT(log)	mutex_init(&(log)->loglock)
> -#define LOG_LOCK(log)		mutex_lock(&((log)->loglock))
> -#define LOG_UNLOCK(log)		mutex_unlock(&((log)->loglock))
>   
>   
>   /*
> @@ -204,9 +198,13 @@ static void write_special_inodes(struct jfs_log *log,
>   	struct jfs_sb_info *sbi;
>   
>   	list_for_each_entry(sbi, &log->sb_list, log_list) {
> -		writer(sbi->ipbmap->i_mapping);
> -		writer(sbi->ipimap->i_mapping);
> -		writer(sbi->direct_inode->i_mapping);
> +		/* These pointers can be NULL before list_del during umount */
> +		if (sbi->ipbmap)
> +			writer(sbi->ipbmap->i_mapping);
> +		if (sbi->ipimap)
> +			writer(sbi->ipimap->i_mapping);
> +		if (sbi->direct_inode)
> +			writer(sbi->direct_inode->i_mapping);
>   	}
>   }
>   
> diff --git a/fs/jfs/jfs_logmgr.h b/fs/jfs/jfs_logmgr.h
> index 8b8994e48cd0..09e0ef6aecce 100644
> --- a/fs/jfs/jfs_logmgr.h
> +++ b/fs/jfs/jfs_logmgr.h
> @@ -402,6 +402,13 @@ struct jfs_log {
>   	int no_integrity;	/* 3: flag to disable journaling to disk */
>   };
>   
> +/*
> + * log read/write serialization (per log)
> + */
> +#define LOG_LOCK_INIT(log)	mutex_init(&(log)->loglock)
> +#define LOG_LOCK(log)		mutex_lock(&((log)->loglock))
> +#define LOG_UNLOCK(log)		mutex_unlock(&((log)->loglock))
> +
>   /*
>    * Log flag
>    */
> diff --git a/fs/jfs/jfs_umount.c b/fs/jfs/jfs_umount.c
> index 8ec43f53f686..18569f1eaabd 100644
> --- a/fs/jfs/jfs_umount.c
> +++ b/fs/jfs/jfs_umount.c
> @@ -20,6 +20,7 @@
>   #include "jfs_superblock.h"
>   #include "jfs_dmap.h"
>   #include "jfs_imap.h"
> +#include "jfs_logmgr.h"
>   #include "jfs_metapage.h"
>   #include "jfs_debug.h"
>   
> @@ -57,6 +58,12 @@ int jfs_umount(struct super_block *sb)
>   		 */
>   		jfs_flush_journal(log, 2);
>   
> +	/*
> +	 * Hold log lock so write_special_inodes (lmLogSync) cannot see
> +	 * this sbi with a NULL inode pointer while iterating log->sb_list.
> +	 */
> +	if (log)
> +		LOG_LOCK(log);
>   	/*
>   	 * close fileset inode allocation map (aka fileset inode)
>   	 */
> @@ -95,6 +102,9 @@ int jfs_umount(struct super_block *sb)
>   	 */
>   	filemap_write_and_wait(sbi->direct_inode->i_mapping);
>   
> +	if (log)
> +		LOG_UNLOCK(log);
> +
>   	/*
>   	 * ensure all file system file pages are propagated to their
>   	 * home blocks on disk (and their in-memory buffer pages are

