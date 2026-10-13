Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410947CC89;
	Tue, 13 Oct 2026 06:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873555; cv=fail; b=ci4v+y4Dz3plbmtbCzf0eg8Fx6KGvsYUfgCW5O/nk/K2HZUwBIZLOIk7Xz4yULgE3eHxDhadNVRwRNg+Ml6KDxtwL/rX0HKZfeMD+D71slDN1lZESbZmpNkm96nYvXPdd7S5ULEb4mxViXDCKo5ZkV6InTKJ6Zw0xW0oTwVLIZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873555; c=relaxed/simple;
	bh=3H1LTlJic76AuunSkdQy7nQFQhPnUD+aiPoZBAnXYMg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iYxDZmM05nlYNxP+aNgSr4eN3WOc3GUTT77e3EXbc4ZP55oY0ifJ6EQSpgfUjTOFDue+fzvLp1RG3JGEcj6xn47zHyhK3kXa9NM7Eseh4gqPSe4BtsfW3Rvq8sKxglNdXy32mAfCLOvkaMrZHCUSATLPpW/m0YlU8cB15dnzPWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QTYprFvp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JlCYtsEn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QTYprFvp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JlCYtsEn"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2BvGM3110102;
	Tue, 13 Oct 2026 06:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yphCUHCcf/snYLSjQNpOeiNNAZoDtIU+apotEWkbLEA=; b=
	QTYprFvpqqexR0tTyR1kMNaMS3tKYp6UH4cIH7+qBjvZ1ofhh7ob4DQhfDKDXTxs
	yYMzMfj6+W4W4jx1k3LcJkR6suhbaziWG8J/LGkx3ZaO48aGa9YUgN+3iiDOf3s2
	caECR7Bdrj3JKOPmmMcBfZXMTG9Vq/ubfnR5lFQR+T0UkGkTLJ9bBFofoBGqvXTK
	ARDKCYoJvr5avsI6NrT6l9zRB9fFCvpaCKMSKxvvq1gHCc95m02I+uKbtYV3gDKY
	I/gq7g4G22wGX2iXF6tpHPdiPnuAAV2mgBHdGTYBQD1EXYYkg1YoTVPbQQ6dXVFL
	Vwc/+CzpwftqW3MGjHjBng==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7ddgkghk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 06:39:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69D6aiLS018652;
	Tue, 13 Oct 2026 06:39:04 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btjppca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 13 Oct 2026 06:39:04 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cIeJEQSCbKqQ7l9JmOpkoSYSURs/ykDJIPytnDMAnOXS3koOCi4apTDuGS/PmkSSzZQgD8zat4/BGHEfoDUxo4uPdBflL7PhzPoF3grWmrgsbog2UHa8sOxiWzrUAfBBIgoOzTNdRQtBScVevM2unvvQYxwCTs3xrvCoLgSqd8hXj9aUiyGfLzH7kKpbK3/04lKNgg87HA/bCcqU1vqHmm4iKh1i7xPaBqq3PHuWNMgABKsBNWW+KeWbPGRvKnXvr57oJdpSOYKcthogTygnMeCDW4zq5fzgMGUcb77cIcKbVRl1wy+koEW0NmdLET0R0ic2StWYOfsQZasdiydmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yphCUHCcf/snYLSjQNpOeiNNAZoDtIU+apotEWkbLEA=;
 b=ykdiWQ9QCAbrljMUGoMJ46LBaIfc8Hs+sgiM8DWtW4XyA28l9apEdUtLQksrSlWJtoAOINgb1EDQYfnm1iXdUMzq4GC01c19R5ZIi64joubeY+QEZoTDuBC3H/VKdzt59RPcjGT1/Wti7CZzRKvPxRbgpT8lDzwkR0Wlis6TVfExae5xtmk9q92HLahvJcZQ709S7szlWG+WMksU70+JOYVLEy2eS/px5iyFX8szglhQr4RGOXZYSAEGE5Nj9qV1Y2XjrDJ4ynxPYix6CYyODn6WoK2KaU70XW9heguEXsPPp8tmwigrI8v2msrbTs/oTYDfDVgkA4f5wEEEV1aBxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yphCUHCcf/snYLSjQNpOeiNNAZoDtIU+apotEWkbLEA=;
 b=JlCYtsEnH0Xe35DBe1lZk1H32nH7/nDgplgqxV3ohN3GAzMf3Jts0UzcSkwXY7FhXDsCzBopdU2shFq2JHdMHohbeL4GKmGn/iRbtBiKrd8pEVW+sOi3gLgh310IuDpK3YMlzPMTYdDgtlpMcTYfuxQzcLTyl8TA372AEbtX61g=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DS7PR10MB4990.namprd10.prod.outlook.com (2603:10b6:5:3a5::8) by
 IA3PR10MB573361.namprd10.prod.outlook.com (2603:10b6:208:703::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 06:39:00 +0000
Received: from DS7PR10MB4990.namprd10.prod.outlook.com
 ([fe80::48cd:32fd:985e:239e]) by DS7PR10MB4990.namprd10.prod.outlook.com
 ([fe80::48cd:32fd:985e:239e%5]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 06:39:00 +0000
Message-ID: <2528e790-8913-45dc-a8d5-cc22908a441e@oracle.com>
Date: Tue, 13 Oct 2026 12:08:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH 0/1] fsnotify: Check parent watches
 without child dentry flags
To: Jan Kara <jack@suse.cz>
Cc: amir73il@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1791373689.git.partha.satapathy@oracle.com>
 <qlw6x3hyky5yoievlkd6ylz3ov432hdjlzkcyboswqktnk43il@fvccpqnil5sp>
 <9499fb1a-85f2-41da-88b7-5e7de6fdff0a@oracle.com>
 <gnntcprg4f7ag7ictugnfza24nwfdmyubkuqac7plxbwtedfrz@xgxyvks3h2uv>
Content-Language: en-US
From: Partha Satapathy <partha.satapathy@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <gnntcprg4f7ag7ictugnfza24nwfdmyubkuqac7plxbwtedfrz@xgxyvks3h2uv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN5PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:264::13) To DS7PR10MB4990.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4990:EE_|IA3PR10MB573361:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b2a7a50-2bdb-40b4-9040-08df28f4aa1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|4143699003|56012099006|18002099003|22082099003|260925021911599003|260925022911599003|260925021311599003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	bvnpgdUz+5iqufQdzRmbsPOrx5m8AQrK0V/mHvtOQZAC3+yBSUvlxvG2XnzzQG5r1KsPjrJvxY8MbccYw6dIiM4oNI7VcsqnCFxShAFXI6B7N2EyJYwHvmqcDMqYfGeFJzeVTJSf0725lLuXARTu5D+kPk7W6sfhj4xyrBThkmXoE0xd6ENeq+/iNjSpSEIjov+F2V1YJzovAtQuG0/Ptn6S7YrOwju/dplL3lEVwIcfx/c3+75GqG+6j1bTrcETohFgTERN/UY98IoxiUxY0BYRxzqggcoG5gnXA2eJGU9o82ityvqaXmWX8lYiABg50XsILFgKwyJqV6jY+36xib4XbrRFs9jGX2sigkL+BGkRFYmaM0QRaRaHT27VlujeXBAj9StXthK4b8KckPxVQU/j9TO2iP1uDVTgs/J+OYnL5j0afxh7IwTrDC+NZ7iOR4kga5seO7F6Grnv0r9Zo41UbSAz+nODqC5d9cl3GK6LEYOszb4xzoTtek/8GB7jpxRuAWtte9p77ksAyv5O2hQDNqQPUHdpr3zH8kpoGst5RT0QepaThSsjGL35LsCVDMhuz5TsaXVhYABJJm/W4bOKKE48AZMIfHrrT0SBQO9liZ7UXv5FA5ZWew3doEwVWzeK6QRy9zE8yqVMy1BNi1znPt1iIo3SE0j1FzzGH1s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4990.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(4143699003)(56012099006)(18002099003)(22082099003)(260925021911599003)(260925022911599003)(260925021311599003)(10067099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGY0Q1U1b2Rvb1NDbUQ1Q3dBNTRCZ3cvbldIaDdlRWFQajJmelZnY0s1SDNz?=
 =?utf-8?B?T3pjUmxuMENNMFZabDlNUy91eFkyTUxCNDJLckI3NWFqWW95WEIwWGVoRnQ1?=
 =?utf-8?B?cFptSEtsY2xDOWQ2UzFyRERqVjhlTjNHUCtpdjVaalVlcExrWmZ6d0RJUERE?=
 =?utf-8?B?aDEwbk13VCtDQ2RBbG9sZ1d0SEdhYVhnTDJ6enZFVWNBSHFMelFmSU52QXZz?=
 =?utf-8?B?cWR3L3p5YWtJOGJkNG5OMFFYVzM2KzhYR1NlWi9LK3B5VkdEYVM2ZkdPb0RU?=
 =?utf-8?B?OVZUeWt0bm5wUWJTdFhsUWRmWWdTdXRZZVFNbmhINmpDTGRBWlUzQlI0dFFw?=
 =?utf-8?B?cHg4OFRWa3NXQ29FbHVpTzh3bW9McUhFRmJ4UzFuVkwyUW1WbXFXbHZxMytF?=
 =?utf-8?B?UEl0bWV1NzJlQ0pOcDkzKzliNzl0UUZROEE0UVg0eFl0a1VhRnlhSDBDa2ZV?=
 =?utf-8?B?cmZKZkdKcGlBS0gyTDlsMnBEQ0R5T0h5R1F2b2JzUU5ISzVGeDVSM1FpMHRY?=
 =?utf-8?B?VmxzZEZEeEZZSlc4L01abVBxN3daMkxRK1ZTeGlxYTVKRUVONVl1WVdNdXR2?=
 =?utf-8?B?MlFkakVJSkJxNGtteHR3dVIzRzdFZEtsQk9RNVVDcXpmc1NpcS9VdHNIUCtp?=
 =?utf-8?B?bFJJNFR5R0xIM2ZzNXRaeTYzaysxZXk1MGVOZFpwRmlNZUNhekJGTlRCSEFm?=
 =?utf-8?B?eHQwQXhCODlKdUtjYkpuU24wS0lSanJpeFJKSTBVRnMxS0ozY0JzaHJjc0dw?=
 =?utf-8?B?NUVJWmNab3FtZVBUZ0Rab0w3LzBKczE1YXpQdHdkY3Nwd1JYeWtrVHZEWURO?=
 =?utf-8?B?M3BEOEExeFhQZXBLQkNYUzVjSlErNC91QVdMQlYzVGVrY04vZ2h1QWVZeWQy?=
 =?utf-8?B?a3RTRi9GOSsrc0lMa2VyREV5eFJNTVMrdGd1OEF4emp1OVFDS1NLWVFkTXdY?=
 =?utf-8?B?ek1rMDkrdnBweGV2blVvd2FzNG5NVU9PNHJTZ3phZ1JFajlCRGNnN0lDU2hy?=
 =?utf-8?B?TGZlWWZ1cnJWNjJJSFpzb1orTElZbENpZ05uMnhWT3oySThtSFdDeEx3aTB2?=
 =?utf-8?B?ZmRqWC9TNWJCd2xnQ3dROTAycExiRmQ2RlJDdHg3SEZVQVBpb0ZLYVlaTzlO?=
 =?utf-8?B?SHlnaWpWR212QlF4cThJSC9ZSjd1aXFwTzM4MndmcGJINXFZUHBVVGxpSVRX?=
 =?utf-8?B?UWpWNlF1aGN0ZDB3NjdQZUE4RUNQcWlkWW50UktBRkVWUVBrNTNkd1BTVVpk?=
 =?utf-8?B?SlhoWkJsK0dlNStuaW85bGpjSVNrSW1CM2UvYXhhM2d6eFQ2OEdHclN6N2Z4?=
 =?utf-8?B?bW5UMmZNNEV4cWtXQzlBWjl2OVF4dE1oSEtaY2VCb1lqdWtYVGN2Q3FBM1Zm?=
 =?utf-8?B?cmNjVkVXK2NmSFNVeFg2cVpMQWZoTzlvYjF2RUZjL01mYVdZbDVjL2VaeW9a?=
 =?utf-8?B?Y2R5bGpobDBuaDZ3OSt1aU0xMHc0c2U4M2hBYWxzSHgxNzdJMWhLSmgvUlVR?=
 =?utf-8?B?TzYyUjY3ZkVsd1NCTjV4eGRLTXowam0ya1MzWTVSZW4yYXIxdzFzOW5QK0Y3?=
 =?utf-8?B?cm5BdVFnZ3orazdXeUFMU3J2aHhTcnFMNUQ4bWc0TmRBSmNZd0tuMnM0R2ZF?=
 =?utf-8?B?aTFBSDNYTU1LeW9mcFAyR1Z1UzE2VDUxNmlITHRPckpTLzE4aUZ3OXZvOE9k?=
 =?utf-8?B?Y0xQYjd1WE9uQTg1TG9BWmFoQW1sMVZobDhseHQ5WGErRUsveVZxN0NnOUZx?=
 =?utf-8?B?VFpmMGtYUnZzL2lHZzBCN1lGUWlLaWo1TU0rbitPZFQ1dnZ5NDhjZkl2ZlRU?=
 =?utf-8?B?bnY5NEFlSUNFeGZiZC91ak1xVWkzVndaUTRWaWNZUXRsT1NzNFlWeEtQc3Vu?=
 =?utf-8?B?aG1TSEdrY1pHeU5BNXEwSjlJcWxRcWhlZlFuZUpvNmc5bnp5Qkl0bml3ZEJ6?=
 =?utf-8?B?K1Q0MVVLUS9yb3BqQ2QzR29Yc2tCaG5ETEozVmR1WXJPUG92TEJETEErRUgx?=
 =?utf-8?B?NnF3TGpEeEFrZUNHdU5FUFNoa1B5NzIxZ2JGUUJRdjFkSi9RTE1kTkxaYTl2?=
 =?utf-8?B?ZHBRSnRWdVRtMFBtVUtRbVVndmJQUmRXdE9QT1dsZkN1MzlCU1ZaNE8vRlpH?=
 =?utf-8?B?a2ZMdmRSZ0tmLzE3ckM3LzBlVmFieVl5RlR0RTdrSUx1Y2JjbXNycTF6cFdP?=
 =?utf-8?B?TmVXVzJ5OTlWL0RtL3BuVTlTbStXTlViTnZnWnRjeG1DSEZQbk9oWllCdnMz?=
 =?utf-8?B?aEdIVmlyU2dHeFRoM0taYitMTU9jRytvVFM5QWh6c1NTNEY0akJ3UFBTRXpr?=
 =?utf-8?B?MGlJajkvdVVuMTdiWFhGQXZIeHVIMWtsWGlCd0luSjZVTlh4K3RuY3hTc2VB?=
 =?utf-8?Q?R2l6MTHvuZt259Cc=3D?=
X-Exchange-RoutingPolicyChecked:
	Cm3cCVigWw9Knu6dwjklFikC9qIB/3nW2IQd2oMe4r+oOg31pfC13xmma1/Ylr544D9Pth4C/4t13hJY4CkMd0f6SI5uuK0tErYkRjtxCK8KpMHZ3t6f/DFLkwHUmzwGeq5CKQhFFiU6K8DZQ6Xz3IdcCtqoVW6EQNR1D9AhKjcgbrUxnLiQ/5igIUVirnFCBnsw1E95yZfWTo/CO+piSdybzmPeGbFBEbVDT9gi57l6dSejDkNTWxBOcf+HwHNrPzq7XyYEiV+5kEb98OVLum4+nuF1EqS/lLJbKsLDmT4sojLDcVNsuZMeAqf0AUfUVHLgank7ykhtY85GxvhsLA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jBj82EjuZjBwHLxquLGXM+tvb5uSnXp3p/a8fDdpL4+ngz5aoqsLlFRXthXvLwIPVGQtLJtwsv4WxERWGrdD6mlYWpjRwi37nxcklqX9coJGsAgCeA9YW1IHJbS0qCkiME7H8Tm9aJpLzu7BXzyCz/v8SSvyhvYBmDIcu8rRf+TmuU6zWcSKQ30EdX8CMUJrbtULT96ewGqKdx7QHta2gsNarsgZGl3VIPDwEBAMerZ+DqO0UuE9qFMS3264U5yQOJL2BR/fBy2y1QV9TaCAzTaJBdbpAhQVhaIFdCJr8Bh4dD6Xo7egLyuguONjarFxLF+RP/JDJWyy2uLEEBDjktKwF37pwf9duyMfw6AhbOEH1eqXgKvPQJ0bsmwBJSZnfgm01Gha8L0ZLCoihMiNw7M5jV4FiWmDa8PCjOv+J2G7ri9O7aisKTuVoKDXHXfZdycVq0gYU0jDDqrXMIotRGVFnzCpw1r9/2w4WX2+3/K5Li3WfjVfHB8S0RSbCcL7hEgGmi06lK7+Fhn0BHCBkFx4Ykc36+DhCs1JrLZHilmyQgujefN8vBR/YUjNlPzVv8ZxkRTfXyFnJEmvJR0L9R+G6uBwbcRCpJIPH2YJSa0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2a7a50-2bdb-40b4-9040-08df28f4aa1f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4990.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 06:39:00.3332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0A9XXwsV5ob8d3TWe2knAng+iies/9q0AHVAv1+vGiRtZlNLD86kLEgcNbztC4swKsAs2GDVJOGs+FgWBcdoplbuO/R4ik513ERDgyaZykk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB573361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610130026
X-Authority-Analysis: v=2.4 cv=EeZd0/mC c=1 sm=1 tr=0 ts=6acdd209 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=iox4zFpeAAAA:8
 a=Zi5tq2B4Fq9Gr9tLVZEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22 a=br55WurUj89AL1qEz8Q6:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12108
X-Proofpoint-ORIG-GUID: VPY64N_gd74bAssq_KMGOLLhwzHS_zIb
X-Proofpoint-GUID: VPY64N_gd74bAssq_KMGOLLhwzHS_zIb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAyNiBTYWx0ZWRfX0qMOdb7Qn6Jw
 yMAWLn3A3Y24bzWIKxsN0ljVI0DAQWN53t+/cpj64QwlkDYIQsUkDBuYB04FE3lFThD3hdVN1lb
 Sc41LO4uIhjiRD7MI3bH6KKdtsWutTFONjhCNI8S+4yEJIOBKXJo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAyNiBTYWx0ZWRfX1sgo8KBwUZbU
 nkWlNOt6kwSsK+E8b+clm5VzkHRZHSjdNkrqgobah0SxwKZvrTt3s+Ntklx3xzSkV+/dodJDV7A
 kVToyvKhia70T9mAmC2qbxNnQUQ9syAOQAZZuYfZVZnP54e25jw/2GSFNbJhVqwhK6+qxtltEab
 biEVf/Jgu+ldMCAOTSpEljsgmYlP5dfNh5QoeVmesptq8fOaTm5TGqM6/41KThegN/S/0V3+HgH
 AqaiDitPc85L+kX1/t1NqRiiqZL60Wz+I4871+jvwgTz2B6wk0W9WS5r9ztETd0+JPh7Ra8x1Ko
 vEvBSzCRjJuxxmTF3w3kGDu9vY2lOKm4ZsJHengzbu0CxZx9uRBRZXHEMlQ52vXVA9xMMVC6UAQ
 osBStsCzvNzJpnY3/Z2XAkSD+xz535CG6eI04Zzf9PLp0XCEofirR4wUQ2NlJcOgrrTp/tfUMjk
 Fnkx9I71y0hpwEI2DxDZLfrOdN9IX4PfPHE+kC4E=

On 12-10-2026 14:10, Jan Kara wrote:
> On Fri 09-10-26 17:18:17, Partha Satapathy wrote:
>> Hi Honza,
>> 
>> Thanks for suggesting this workload.
>> The setup and before/after timing comparisons are below.
>> 
>> Architecture:                x86_64
>> CPU(s):                      512
>>   On-line CPU(s) list:       0-511
>> 
>> NUMA:
>>   NUMA node(s):              2
>>   NUMA node0 CPU(s):         0-127,256-383
>>   NUMA node1 CPU(s):         128-255,384-511
>> 
>> Testcase :
>> Using /dev/shm  tmpfs to create  private test directory.
>> Create 1,024 files each fully populated with 4kb.
>> Add IN_MODIFY inotify watch to the directory.
>> Start a listener thread to read notifications and count queue overflows.
>> Start X(1,2,4..1024) client threads; each opens a different file once.
>> Wait until every client is ready, then release them together.
>> Each client starts its timer and performs 1000000
>> one-byte pwrite() at offset0 on its own file.
>> Each client stops its timer and closes its file.
>> Wait for all clients to finish, drain remaining notifications,
>> and stop the listener.
>> Print write times, throughput, notification count, and queue-overflow count.
>> Close inotify and delete the test files and directory.
>> 
>> Note : File creation, open, close, and cleanup are outside the timed
>> write loops.
>> 
>> Run 1:
>> -------
>> 
>> | Clients | Before average time | After average time | Time change |
>> |---:|---:|---:|---:|
>> | 1 | 1.392 s | 1.484 s | +6.6% |
>> | 2 | 2.205 s | 2.402 s | +8.9% |
>> | 4 | 3.969 s | 3.644 s | −8.2% |
>> | 8 | 5.851 s | 5.804 s | −0.8% |
>> | 16 | 10.607 s | 11.538 s | +8.8% |
>> | 32 | 21.093 s | 22.492 s | +6.6% |
>> | 64 | 48.698 s | 49.576 s | +1.8% |
>> | 128 | 100.208 s | 100.467 s | +0.3% |
>> | 256 | 198.773 s | 197.669 s | −0.6% |
>> | 512 | 400.056 s | 399.550 s | −0.1% |
>> 
>> 
>> Run2 :
>> --------
>> 
>> | Clients | Before average time | After average time | Time change |
>> |---:|---:|---:|---:|
>> | 1 | 1.491 s | 1.484 s | −0.4% |
>> | 2 | 2.391 s | 2.402 s | +0.5% |
>> | 4 | 4.050 s | 3.644 s | −10.0% |
>> | 8 | 6.630 s | 5.804 s | −12.5% |
>> | 16 | 11.931 s | 11.538 s | −3.3% |
>> | 32 | 22.513 s | 22.492 s | −0.1% |
>> | 64 | 50.231 s | 49.576 s | −1.3% |
>> | 128 | 100.699 s | 100.467 s | −0.2% |
>> | 256 | 198.771 s | 197.669 s | −0.6% |
>> | 512 | 401.860 s | 399.550 s | −0.6% |
>> | 1,024 | 803.812 s | 806.593 s | +0.3% |
>> 
>> 
>> Positive means After Fix took longer; negative means faster.
>> 
>> 
>> The measured write performance is broadly comparable before and after
>> the fix, with no consistent substantial regression or progressively
>> worsening slowdown as concurrency increases.
>> 
>> The differences vary between baseline batches: the increases at 16
>> and 32 clients in the first comparison disappear or reverse in the
>> second. At 128–1024 clients, average write times differ by approximately
>> 0.6% or less. These shifts are consistent with run-to-run variation;
>> the results do not show a persistent substantial slowdown from the fix.
> 
> Thanks for running these tests. Results are very interesting. Can you
> please share your benchmarking program with me?  I'll check it and try to
> play with it on my end. Thanks!
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

$ cat run_parent_ref_scale.sh
#!/usr/bin/env bash
set -u -o pipefail

bench=./fsnotify_parent_ref_bench
if [[ ! -x "$bench" ]]; then
        printf 'Build %s in the current directory first.\n' "$bench" >&2
        exit 1
fi

results_dir=$(mktemp -d ./parent-ref-results-XXXXXXXX) || exit 1
printf
'kernel=%s\nbenchmark=%s\ntmpfs=/dev/shm\nwrites_per_client=1000000\nmode=watch\n'
\
        "$(uname -r)" "$bench" > "$results_dir/run-info.txt"
printf 'Results: %s\n' "$results_dir"

for i in 1 2 3 4 5; do
for clients in 1 2 4 8 16 32 64 128 256 512 1024; do
        log="$results_dir/clients-${clients}.log"
        printf '\n=== clients=%d ===\n' "$clients"
        "$bench" /dev/shm "$clients" 1000000 watch 2>&1 | tee "$log"
        status=${PIPESTATUS[0]}
        printf 'exit_status=%d\n' "$status" | tee -a "$log"
done
done

printf '\nAll results saved in %s\n' "$results_dir"



$ cat fsnotify_parent_ref_bench.c
#define _GNU_SOURCE
#include <errno.h>
#include <fcntl.h>
#include <inttypes.h>
#include <limits.h>
#include <poll.h>
#include <pthread.h>
#include <stdatomic.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/inotify.h>
#include <sys/stat.h>
#include <sys/statfs.h>
#include <time.h>
#include <unistd.h>
#include <linux/magic.h>

#define FILES 1024
#define FILE_SIZE 4096
#define DEFAULT_WRITES 1000000UL

struct gate {
        pthread_mutex_t mutex;
        pthread_cond_t cond;
        unsigned int ready;
        bool start;
        bool abort;
};

struct worker {
        char path[PATH_MAX];
        unsigned long writes;
        unsigned int id;
        struct gate *gate;
        uint64_t begin_ns;
        uint64_t end_ns;
        int error;
};

struct listener {
        int fd;
        atomic_bool stop;
        uint64_t events;
        uint64_t overflows;
        int error;
};

static uint64_t now_ns(void)
{
        struct timespec ts;

        if (clock_gettime(CLOCK_MONOTONIC_RAW, &ts)) {
                perror("clock_gettime");
                exit(EXIT_FAILURE);
        }
        return (uint64_t)ts.tv_sec * 1000000000ULL + ts.tv_nsec;
}

static unsigned long parse_count(const char *s, const char *name)
{
        char *end;
        unsigned long value;

        errno = 0;
        value = strtoul(s, &end, 10);
        if (errno || !*s || *end || !value) {
                fprintf(stderr, "Invalid %s: %s\n", name, s);
                exit(EXIT_FAILURE);
        }
        return value;
}

static void file_path(char *out, size_t size, const char *dir, unsigned
int i)
{
        int n = snprintf(out, size, "%s/file-%04u", dir, i);

        if (n < 0 || (size_t)n >= size) {
                fputs("File path is too long\n", stderr);
                exit(EXIT_FAILURE);
        }
}

static void *run_worker(void *arg)
{
        struct worker *w = arg;
        int fd;
        char byte = (char)w->id;
        unsigned long i;
        bool abort;

        fd = open(w->path, O_WRONLY | O_CLOEXEC);
        if (fd < 0)
                w->error = errno;
        pthread_mutex_lock(&w->gate->mutex);
        w->gate->ready++;
        pthread_cond_broadcast(&w->gate->cond);
        while (!w->gate->start)
                pthread_cond_wait(&w->gate->cond, &w->gate->mutex);
        abort = w->gate->abort;
        pthread_mutex_unlock(&w->gate->mutex);
        if (abort || w->error)
                goto out;

        w->begin_ns = now_ns();
        for (i = 0; i < w->writes; i++) {
                if (pwrite(fd, &byte, 1, 0) != 1) {
                        w->error = errno ? errno : EIO;
                        break;
                }
        }
        w->end_ns = now_ns();
out:
        if (fd >= 0 && close(fd) && !w->error)
                w->error = errno;
        return NULL;
}

static void *drain_events(void *arg)
{
        struct listener *l = arg;
        char buf[65536] __attribute__((aligned(8)));
        struct pollfd pfd = { .fd = l->fd, .events = POLLIN };

        for (;;) {
                int ready = poll(&pfd, 1, atomic_load(&l->stop) ? 0 : 50);

                if (ready < 0) {
                        if (errno == EINTR)
                                continue;
                        l->error = errno;
                        break;
                }
                if (!ready) {
                        if (atomic_load(&l->stop))
                                break;
                        continue;
                }
                for (;;) {
                        ssize_t len = read(l->fd, buf, sizeof(buf));
                        size_t pos = 0;

                        if (len < 0) {
                                if (errno == EINTR)
                                        continue;
                                if (errno == EAGAIN)
                                        break;
                                l->error = errno;
                                return NULL;
                        }
                        while (pos + sizeof(struct inotify_event) <=
(size_t)len) {
                                struct inotify_event *ev =
                                        (struct inotify_event *)(buf + pos);
                                size_t step = sizeof(*ev) + ev->len;

                                if (step > (size_t)len - pos) {
                                        l->error = EPROTO;
                                        return NULL;
                                }
                                l->events++;
                                if (ev->mask & IN_Q_OVERFLOW)
                                        l->overflows++;
                                pos += step;
                        }
                        if (pos != (size_t)len) {
                                l->error = EPROTO;
                                return NULL;
                        }
                }
        }
        return NULL;
}

static void cleanup(const char *dir)
{
        char path[PATH_MAX];
        unsigned int i;

        for (i = 0; i < FILES; i++) {
                file_path(path, sizeof(path), dir, i);
                if (unlink(path) && errno != ENOENT)
                        perror(path);
        }
        if (rmdir(dir))
                perror(dir);
}

int main(int argc, char **argv)
{
        char dir[PATH_MAX], path[PATH_MAX];
        unsigned long writes = DEFAULT_WRITES;
        unsigned long count;
        unsigned int clients, i, created = 0;
        struct statfs fs;
        struct gate gate = {
                .mutex = PTHREAD_MUTEX_INITIALIZER,
                .cond = PTHREAD_COND_INITIALIZER,
        };
        struct listener listener = { .fd = -1 };
        struct worker *workers;
        pthread_t *threads, listener_thread;
        bool watched = true, listener_started = false;
        uint64_t first = UINT64_MAX, last = 0, sum = 0;
        uint64_t shortest = UINT64_MAX, longest = 0;
        char zeroes[FILE_SIZE] = { 0 };
        int rc = EXIT_FAILURE, err;

        if (argc < 3 || argc > 5) {
                fprintf(stderr, "Usage: %s TMPFS_ROOT CLIENTS
[WRITES_PER_CLIENT] [watch|none]\n", argv[0]);
                return rc;
        }
        clients = parse_count(argv[2], "clients");
        if (clients > FILES) {
                fprintf(stderr, "Clients must be at most %d\n", FILES);
                return rc;
        }
        if (argc > 3)
                writes = parse_count(argv[3], "writes per client");
        if (writes > ULONG_MAX / clients) {
                fputs("Total write count is too large\n", stderr);
                return rc;
        }
        if (argc > 4) {
                if (!strcmp(argv[4], "none"))
                        watched = false;
                else if (strcmp(argv[4], "watch")) {
                        fputs("Mode must be watch or none\n", stderr);
                        return rc;
                }
        }
        if (statfs(argv[1], &fs)) {
                perror(argv[1]);
                return rc;
        }
        if (fs.f_type != TMPFS_MAGIC) {
                fprintf(stderr, "%s must be a tmpfs directory\n", argv[1]);
                return rc;
        }
        if (snprintf(dir, sizeof(dir), "%s/fsnotify-parent-ref-XXXXXX",
argv[1]) >=
            (int)sizeof(dir) || !mkdtemp(dir)) {
                perror("mkdtemp");
                return rc;
        }
        workers = calloc(clients, sizeof(*workers));
        threads = calloc(clients, sizeof(*threads));
        if (!workers || !threads) {
                fputs("Cannot allocate worker state\n", stderr);
                goto out;
        }
        for (i = 0; i < FILES; i++) {
                int fd;

                file_path(path, sizeof(path), dir, i);
                fd = open(path, O_CREAT | O_EXCL | O_WRONLY | O_CLOEXEC,
0600);
                if (fd < 0) {
                        perror(path);
                        goto out;
                }
                /* Allocate the tmpfs page before the measured write
loop. */
                if (write(fd, zeroes, sizeof(zeroes)) != sizeof(zeroes)) {
                        perror(path);
                        close(fd);
                        goto out;
                }
                if (close(fd)) {
                        perror(path);
                        goto out;
                }
        }
        if (watched) {
                listener.fd = inotify_init1(IN_NONBLOCK | IN_CLOEXEC);
                if (listener.fd < 0 ||
                    inotify_add_watch(listener.fd, dir, IN_MODIFY) < 0) {
                        perror("inotify watch");
                        goto out;
                }
                err = pthread_create(&listener_thread, NULL,
drain_events, &listener);
                if (err) {
                        errno = err;
                        perror("listener thread");
                        goto out;
                }
                listener_started = true;
        }
        for (i = 0; i < clients; i++) {
                workers[i].id = i;
                workers[i].writes = writes;
                workers[i].gate = &gate;
                file_path(workers[i].path, sizeof(workers[i].path), dir, i);
                err = pthread_create(&threads[i], NULL, run_worker,
&workers[i]);
                if (err) {
                        errno = err;
                        perror("worker thread");
                        gate.abort = true;
                        goto release;
                }
                created++;
        }
        pthread_mutex_lock(&gate.mutex);
        while (gate.ready < clients)
                pthread_cond_wait(&gate.cond, &gate.mutex);
        pthread_mutex_unlock(&gate.mutex);
        for (i = 0; i < clients; i++) {
                if (workers[i].error) {
                        fprintf(stderr, "Worker %u open: %s\n", i,
                                strerror(workers[i].error));
                        gate.abort = true;
                        break;
                }
        }
        printf("test_dir=%s files=%d file_size=%d clients=%u
writes_per_client=%lu mode=%s\n",
               dir, FILES, FILE_SIZE, clients, writes,
               watched ? "watch" : "none");
        fflush(stdout);
release:
        pthread_mutex_lock(&gate.mutex);
        gate.start = true;
        pthread_cond_broadcast(&gate.cond);
        pthread_mutex_unlock(&gate.mutex);
        for (i = 0; i < created; i++)
                pthread_join(threads[i], NULL);
        if (listener_started) {
                atomic_store(&listener.stop, true);
                pthread_join(listener_thread, NULL);
                printf("inotify_events=%" PRIu64 " queue_overflows=%"
PRIu64 "\n",
                       listener.events, listener.overflows);
                if (listener.error)
                        fprintf(stderr, "Inotify listener: %s\n",
strerror(listener.error));
                if (listener.overflows)
                        fputs("Inotify queue overflowed; event delivery
load changed during the run\n", stderr);
        }
        if (gate.abort || listener.error)
                goto out;
        for (i = 0; i < clients; i++) {
                uint64_t duration;

                if (workers[i].error) {
                        fprintf(stderr, "Worker %u write: %s\n", i,
                                strerror(workers[i].error));
                        goto out;
                }
                duration = workers[i].end_ns - workers[i].begin_ns;
                if (workers[i].begin_ns < first)
                        first = workers[i].begin_ns;
                if (workers[i].end_ns > last)
                        last = workers[i].end_ns;
                if (duration < shortest)
                        shortest = duration;
                if (duration > longest)
                        longest = duration;
                sum += duration;
        }
        count = (unsigned long)clients * writes;
        printf("total_writes=%lu wall_seconds=%.6f
throughput_writes_per_sec=%.0f mean_worker_ns_per_write=%.1f
shortest_worker_seconds=%.6f longest_worker_seconds=%.6f\n",
               count, (last - first) / 1e9, count * 1e9 / (last - first),
               (double)sum / count, shortest / 1e9, longest / 1e9);
        printf("result=%s\n", listener.overflows ? "QUEUE_OVERFLOW" :
"PASS");
        rc = listener.overflows ? EXIT_FAILURE : EXIT_SUCCESS;
out:
        if (listener.fd >= 0)
                close(listener.fd);
        cleanup(dir);
        free(workers);
        free(threads);
        return rc;
}


Please compile : fsnotify_parent_ref_bench.c -o
fsnotify_parent_ref_bench. After that
run the script ./run_parent_ref_scale.sh

Thanks
Partha
