Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B398D4D9F7A;
	Fri,  9 Oct 2026 11:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546530; cv=fail; b=RQzLLvtOdcFzTzpJ0yNmzC7UHS5UblhuBtjk4ryO7gm5kTZ8T04+e5c8bYCIYG2CGI7aI7zduN5jhVq9VS/6I039FiurtH6BVEl7G83QvzcRuihqJd/FYVfDM42aCR/VrFSJ0IBhAu+iE5gKLWWr66+WFt+Zrm64p9pDtSR6/Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546530; c=relaxed/simple;
	bh=nHYzBQVYT9lQjjfxKZWvr+Xg4zKDUNaCHBRzqkqrfZc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZxqqBMUnE5dtd8rMRxradkhhKNspC5MsoKHMdzDB1vqnFu5AHBk/WX6XB5eg3UCxjPRdwL68hdNFmcfy2g7GSjpoo6lq5mjaT76YLqqdCKiJd921iRYgovSKbNXwZ/kKvBEDoTN8WrIeFFXb3tLjkqsWBn/k44sNyY9+4m7pWlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jgXp9QdN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m6kSKD1d; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jgXp9QdN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m6kSKD1d"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698KA70O3904669;
	Fri, 9 Oct 2026 11:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VnbWYjCrNjIoY8IIqFkLjq/06lQEjVGGCQNowUQhyoI=; b=
	jgXp9QdN7fZp+JMkyxH7g/yfNykbrOL4hUEp/cD8NG5mqOXs0osxyMDvr0VnMBmX
	DSiL5Zne55v2ea1jpFxvRewTbAvJWjWpcc1bcLRLpW9BGca2pf1Rt8wOJeerLFZ9
	E0KCH0wTsSJOjJI1nLeIsoHrUqV/vdj2O70JIsh3iPRhsYUA+Mhm42pCfGu6b+vn
	XRsSDW1ul9PAcNjxCEhMa66fpTKfBoOz0CUhw4l2TzSacsnQFagr3rv09PCo0Nb9
	OnjMNHC/yYhj6UCAY6qxBE1caITYRRHqs8MXNr/xx5IDYfnZYdVynxhEq0ra7p7F
	60vO81fk1cR6L84KlnBQWw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h5xegjyun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Oct 2026 11:48:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 699BaKfw001526;
	Fri, 9 Oct 2026 11:48:28 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012044.outbound.protection.outlook.com [52.101.48.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4h5xkq56y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 09 Oct 2026 11:48:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfhusKIm3K3ZF/YSWV1hB7behv3voPA/y/XThW7MGgt2Wu5wVqzWFO7aDxUkvUykpmCd3SNtvV+jf3NAVvHmZNxoBVg+MZ1egUnDq+u3Y9pZydoQtYAVwhrKQ5uQArsOLzhOvlEaZ43kNeUR47r4iKBIym9bG2zdW4j1PTqddfJqCCvOSg/lpZeOvai2tttmRgWzQSa5kxwBjB4JOSjKG4qoRpxxO7NeMq/UpwxWmElyy1n6x228DMh1JiWjtzbC2E58rpp3wRFMkytqDYJpL8IcMKVOOLWmjolVZaAs44UXEJ1DtyyUW72U/0fOxsmajKICPUdAvZZxKk9lqI6pXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnbWYjCrNjIoY8IIqFkLjq/06lQEjVGGCQNowUQhyoI=;
 b=e9hcdBpJlEfVi8RHsozAw4m17Hf4kfY/F2Syu3dNwX5DvlG9PTtBMYtw4q9fT/8vyS8h+FThOY8R+nviMASaX0FuUyXcEdn44LfwNX8j71LRyX0nonrX4/0l3nbGgDZe2/gE045x39ythEE3jJGI3FtPFZDfZ9GZk62FT+AlMAARx33gUps+FBNy6zECGFQiKPopyEhkX/nhNiGk3dj180kY/ms9f7tL0i/cebYkT3WwrV8pGGyQ5QnK35Q/Wn92zpsSglCCDlw8gzeNKW3JnmnabanHS8RS4dHHWbuNPcloPT5l8qBgqyor/joHznH1GYHyIFuZhKsXmSrocLnRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnbWYjCrNjIoY8IIqFkLjq/06lQEjVGGCQNowUQhyoI=;
 b=m6kSKD1dHLJp2a3B7PykaRuspecidBwZccZTl0i3XMv6GWXSMbqGkv7UrIIDxB2s+Ai6y7denYB3yEO6yVy69yGYS4IcyMfDSeeyaV3F/vCEG9fMlquYupDi825ynwZd0jL9u8lokxNXY7PunIJj3bVz71xubBkqZmB5IZSW3cI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oracle.com;
Received: from DS7PR10MB4990.namprd10.prod.outlook.com (2603:10b6:5:3a5::8) by
 PH7PR10MB6627.namprd10.prod.outlook.com (2603:10b6:510:20a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Fri, 9 Oct
 2026 11:48:23 +0000
Received: from DS7PR10MB4990.namprd10.prod.outlook.com
 ([fe80::48cd:32fd:985e:239e]) by DS7PR10MB4990.namprd10.prod.outlook.com
 ([fe80::48cd:32fd:985e:239e%5]) with mapi id 15.21.0522.002; Fri, 9 Oct 2026
 11:48:23 +0000
Message-ID: <9499fb1a-85f2-41da-88b7-5e7de6fdff0a@oracle.com>
Date: Fri, 9 Oct 2026 17:18:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH 0/1] fsnotify: Check parent watches
 without child dentry flags
To: Jan Kara <jack@suse.cz>
Cc: amir73il@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1791373689.git.partha.satapathy@oracle.com>
 <qlw6x3hyky5yoievlkd6ylz3ov432hdjlzkcyboswqktnk43il@fvccpqnil5sp>
Content-Language: en-US
From: Partha Satapathy <partha.satapathy@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <qlw6x3hyky5yoievlkd6ylz3ov432hdjlzkcyboswqktnk43il@fvccpqnil5sp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0497.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::22) To DS7PR10MB4990.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4990:EE_|PH7PR10MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cf76989-5e8b-4d66-3d44-08df25fb3904
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|22082099003|18002099003|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	9K/mkTblIoCxEAHUmScabTEizEd0w7EnajX6QY5LHRpNtqDuKOFtKy+LoELJtLNpARDANy+BbFD60tqienpeVSoKd/k1K8dmH+Tq4Hwr387E2/e+TJkhauslCoFtGWGDFO6c+9tymYZO9A+tkgXYhIwcOiuILiZeNjdFIQrJnB7PS2RCmfx0mOl0p2pWFkpR7l4qHbhqvhG0O5gfCxnC0PQxczHVwNYjSNsstEov5Ll6YkFupwQdXh9XRqzbuv5Vq4bRYYTdk6j0zijtIjy2R7iFC31vXuswW24UTXoHi2VWWBML1x4EFSWQsQ//bZm33F/uLTA0+KxXA10Zukz4Vhku0MLDygsUz13U3o47jllPSTz+kkDXht3VVlVmU1RBhUskE/qKFxce21/gP5MAcbeGKtlxZjDH+Fc1rFlPMp/lII3qYWtzgcP9oFjZfa5eqFmFCFA6gZtb2XZiURhgSu0g1wYvIBUPJHVz07lioBC1T7xJvMYoz3Hv6L7FmZa6JrZeWeU+ZhSYR/wQQZh3sYfL31Ls4PhGfbeyJOt0n2Iv8YAIBgeGxjiKdDMbvl0Dl5t/XO7m83nkt2D6Heg0O8XSIBwM/vQWkB5H004Q0tdXFIPnGJzAwQ4LoH0h5ynSJl3B7FhH+yjiYmpoMGPRXFGcEeEN67nkqi8pLkZDSaw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4990.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3ZuVlQrMit6dzREckhBMlMyNCtpTnpkMWFKRnNSa1lzRS84ayt5VStFSTFW?=
 =?utf-8?B?SzVwUXpBb21kSUdjb3h3RGhIUVhKdE5kUEN6UFBDcFh0VW1xQUFYMGlpVUhL?=
 =?utf-8?B?TEwycWp3ckpvVFQwRXFjQmFvNkE4cG1YWnhtLzdLRyt1R2MwQWN3WlFZenBv?=
 =?utf-8?B?bHJ4Z0NGRmNSbUp5VUdwZFFBSkJpVkM3QjhyODhJcW9VSkViQUl4UW1UQnlY?=
 =?utf-8?B?aDcwVnZZeHRhTDF3UjBEMnBlQnJ4TU1GSmF3S3cwQXpjOEwyNlRuVHdCa3JR?=
 =?utf-8?B?bXA1a2ZQT3ZzWmtXdTdFeWpLajB6Qy9ySEZHUVlGYkxBQjZHQTRoUEhMMWlL?=
 =?utf-8?B?SHplQ1lLVUdyUnI0TzhKdVM1bnlxeCtmQmYvc29LdHFCSXp4alh2TmhEUWEr?=
 =?utf-8?B?T1dSc0QvYlVIc0xkMENHSjk3MHE4UGNxN3FLc0xxQ2g2US94OC9xZXdxajNn?=
 =?utf-8?B?Z0dKNG5DbjNCMHlhMkZJQUdSSU04RW5qcDVhZWprakhFa09BMFpPMkU3VEZr?=
 =?utf-8?B?Sy8yd0tpaUlsc0NqQWVaQ0NDRWt5a3lBaUVPakFhdGlrVXp3SmgzOGZXbjBC?=
 =?utf-8?B?VVh5NGl6Y3BET2xFN0RqYmtEd2Z0dU90OEdXUUdURG9wY043VGhGYTJVNCsw?=
 =?utf-8?B?eDh1SHhtS1lCTm5Qd2c4VVIrQXQ3VEFQUHdNTHUzaGhDWEw2V3Y0WHZOZVZU?=
 =?utf-8?B?T2gzNVVFL3BvM2g2ZGlnMHNMZ2FZbnU5VFYwSThFcGRrQ2N3OTlwZ0xuUnpR?=
 =?utf-8?B?aEErTmFXQWdLOGRaS0hkRTJJVFJWM0pnaHd5WlVZUDZhVmU5cDdUS3RDU2oz?=
 =?utf-8?B?aHVNQVhDakhTbTNSakFickxkNHZlV1dOVUVVWVcwRmIwUE8xL2cyQmpVWU5h?=
 =?utf-8?B?MWFmQm1GaDJkTUtPK3RnL2trVGN2OG1aQUhvRWtZMTJFMFRNa3k1UC95RVE1?=
 =?utf-8?B?Q1VuYm5XS08vaWVJVG9GRzliUlA1L0FqN0F4Qk5VZWpPV216RWJjazhQYzBz?=
 =?utf-8?B?c25jRHcvTlZMQW5zM2gzMVVid0ZtYmVTREJtMEp2VTM2RVIxbnhtOGZ6aWdi?=
 =?utf-8?B?cCtaak1JdFZlYkVPdEtkck9WOVJMNkFzWjF5ZWdqTkpPNUtoNXNkNkFSR2E2?=
 =?utf-8?B?Z0tVTXNLeVl5Y0szYnVaRE9KTmhNMkM1Mlh1YmZ6N0VPUGRJZXdZOUVLbmhJ?=
 =?utf-8?B?bUxBVGJOcUV2aG5zb2xnQjZGL2V3aVM1N09peWF4NjlZaC9keHNVQmVFNU5r?=
 =?utf-8?B?RUVEY2FQck1seTN3MGpsZEVmQ1c0cmVLZ0FJTG4xNzNaZXV2RVc3andPN3N0?=
 =?utf-8?B?UzFoeHJpOHFrYVlwZGFBdWFjTVA4WGtacGJaQlorOHBmdFpIZUloZkowb2Vt?=
 =?utf-8?B?NVZRMFpxLzR1bWd0V0U2TmZES0FQMThwc1hEd0xIWWQvZUJ0ZWlMTzlNbHpR?=
 =?utf-8?B?elpHZ08zVkQvc3l5Z21BSDl3UXkrcVFhS0g0eUsycFhRcWJ5MzN0ZVhYOW8v?=
 =?utf-8?B?QjRvbUowQ2hMbzcxdDJVNFhkK0xOeng1TWlmRnNpWXRNb3JVbnhWZ01qdStl?=
 =?utf-8?B?RTdTTmFRY0dWdi9QK3BqZitMUFZ5RU9uaTh5SWdadkpxSkNBZTUyeDVpZHVN?=
 =?utf-8?B?QmhPOGkwbzRPV2QweDJTaldxNnA4cHNLM25FWUdMdmN5N1dISWNoVklacFVU?=
 =?utf-8?B?OWpaaUFYeEo3RnRaekdPTjFwdlZxeGZha1A2Ri9jcno3WkZGN0I5WHlRdjFl?=
 =?utf-8?B?TGl3VkJ5d2JyTzVMVURRaStxQko4b2VKVGZKaE1xZ1JKNWJVb2Vidk5iNkEv?=
 =?utf-8?B?UVhGcjB2UnMvcEJ0R1IxVGFZcSt6UkVqNVhSckZlUVdDc2xaa2lGWEJsY0Ft?=
 =?utf-8?B?bE1sZERQcVpvQ0ZPK2JCSHNoK0pSemIvNWU5aXc3ZWNCYVQvd0JMZmFudTIy?=
 =?utf-8?B?QTBBaE5SRDR1Y3hDRmRaekhDRktKWjBtckFRZWx5TGl3OEVlOGpqVmt3amRw?=
 =?utf-8?B?d2MxOWJOWVNzb1FQRFdnY1YySHFyVm5NNXdhSERNOFF1eSt3MkxhZDc4L3BS?=
 =?utf-8?B?dVVpdDZLZlB0MVBZcDdoWGdhbjEwOEhZM0NDekl3ckRYNXF3bVFZSU5RbDl3?=
 =?utf-8?B?cm54OUJTd2dtZktKOGt4MzdwMk1zZThXVkowZXg2NktZdVNidzUrakFZZWZ4?=
 =?utf-8?B?TE85TWhQUnd6bTdhR01sc3VvWmxUOXduUmxpZzRpaUlia3kvNHRxQTVOVk1Z?=
 =?utf-8?B?NjJvMkFKZTdnN0tkOW9DL2hYaC9pTmxZeHQ4cjM1TTJEazg4Q2ZLR2FEeGlZ?=
 =?utf-8?B?cWRBYkhDc2h5ak1jMUQ5QnNGSXRaNmlXOXBCZG9SSDc3YzNIZVVPa24yK3Jr?=
 =?utf-8?Q?stF+IE/A3C61+Q80=3D?=
X-Exchange-RoutingPolicyChecked:
	yrr+K5doCdRAuyJOF1CazR99Hs64mzm3hnazBMOvQU2UkgGryF2Ye6CkehscNQ/cSmyqJAU3Dz5K7dnh3mJGjIRvmE+bZYO1oQXDW8Ey6fuii0cr+2DsDl6zvYqFUKSdx4aNrwwTXS7gYKmw/9rVXTwVvH1ZIFLdtHkVgB1lRuOympip6ihRyG8AQKSqyM95yyerkR+cmbYx2Ow3S7UfGyYG51jKheW83VMA0m/7ikS/EjAwErxxkS4YMbsEhssZU5lZr0UI9yyO5wsUiEtP94bQTsA36DyO4EqOFjbjM/PluUTNASCkBBL3qjgMm1Q1R/7S66R5w6wrW11wMugpoQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vZUj4J5mjMJNxWjkEXd0peACr4GbX2FkpxNm1GnOENBRRwMaWtNo3IUEz4jhVJBB5K1Uq08QMVn2n4uz8QPk75/e11SIJpU6NBxQkYIN5lZsE8DVoYKVvJsdZLy4VAdkH5aW53AC+JwiqIRk4eK9dvc52jFvrxeZySo7+C4rzSkc65dd5J3jkSBe6mdgfEvW3n+6NmzZJ/mz7EFf0ByDsLvbFJH/7/RUsNUdxSjV4U90Ixoolm4DQfUA1Jg0rJ1lKtZmDzFl0MinFE5fTrshqsDoeGNDqnkM8I+4j5+ngL5xlefrbUIHTCUBLmNs4FPR1Cb03X2MD8M61vRgegNGoHHy5v4pqDkRUafltPd67Hr5+PDUfh05L2qqauujLZ5vlqXIMcSqSQMd7UnPwrX7LxWkk4MB3Z71AP/4Gz2M6etz89rEj7JnprWB3Cumo+rHZTs5lsKfuhCnk0NVjR6STumJ6e8tPsJyNX4Q+jnxDmOyrbBsLaCVS8tGcFuhFRLMr18LvU6KsF5MAsB2B6pn7AUwX29ker1Sko7EDWLXmf/ZGy2MeChzCd6AbBzNe/42fovqupuJzl4IVCdFSxmJ49hY4Nm/rGZFVqtkBdnT/HI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cf76989-5e8b-4d66-3d44-08df25fb3904
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4990.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 11:48:23.6315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23AXkkahpOc6YLDeV5IeXWE6miXHjal5mEE9Sd+9gHX37D98AMzCVnT5ifve1B+mGeQhBbNcRxRUZ9vyZfO3C8+xQ90HfF82XB2gMdgmK/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610090046
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfXx25LOYwv6TES
 H1gNsNw8mp4dFMlr0Ab/8zaD+VRW4zV7qgrRRgjYJ6CEG5IS7M4lpQVYm9zWgIIye3qj9UhQ8SW
 tuyZoSt/+alaXIL9BELXNZ+C3oN62YAwHnlziC/wOO+7UtT/AAcI
X-Authority-Analysis: v=2.4 cv=Zp54uN7G c=1 sm=1 tr=0 ts=6ac8d48d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=iox4zFpeAAAA:8
 a=5bfPlIujDJQnKFhtjpAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: qpbD0mZr4OBmFW7LeNd29ErOmhPGXp7Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0NiBTYWx0ZWRfX/klV72P1G+uK
 qI+kCu1EZObzudkqWnr6MIQoqbVmjLQZIw1tYxEYYbxj1xw2jxWDD1BZ/418KGiEKFkVRjzNkI8
 wqnoAtqlxTYiXJ514LFtMoBKRTka7zk2XjXxaZgpQ0q05C+QV/BqSXdshyPuqaGN1Ys3fL1adFy
 ls4EMKCCyFtK/ssXh+V3cAqUxUloN8xkVyH0iFYVdwgi5RfwJgKu+v5Y/qOKv1Qf3EMDkkYKzU1
 ZRDwUTHQRvWI1xf31q+AAyz5WZ+nlla34TQzMAzXRP+gLIz5OY1wM6W9KPvH+IJ9YNB0lJX+EAf
 LyY/JcUEfMwCtclsuSY0Gg1aD9ieVdxyNsBZjX0SXCrbNCO3DTQRO+n6TOCBYMkMbugUSKAYg02
 wLO8J7XZDUEFcYIBHj+uxHG+fVQC+lg2XXQGp0vpkVxW6ddiff8F/heFtffOYiFZbwN59PutgDH
 bCHcSwdPPWvsST/7ONg==
X-Proofpoint-ORIG-GUID: qpbD0mZr4OBmFW7LeNd29ErOmhPGXp7Q

On 08-10-2026 15:12, Jan Kara wrote:
> On Wed 07-10-26 15:20:50, Partha Sarathi Satapathy wrote:
>> This patch removes the cached-child dentry walk performed when a directory
>> first starts watching child events. Instead, the event path takes a reference
>> to the parent dentry and checks its child-watch mask. It also removes the
>> DCACHE_FSNOTIFY_PARENT_WATCHED flag and its update sites.
> 
> If we can get rid of it, it would be a nice simplification but I have
> doubts this is feasible.
> 
>> On the test host, 12 million files were populated and their positive dentries
>> were warmed before each run. With eight concurrent unlink/recreate workers
>> and 100 sole-watch add/close cycles, inotify_add_watch() measured:
>> 
>>                          Before                After
>>   run 1 average           107.420 ms            0.004 ms
>>   run 2 average           125.433 ms            0.004 ms
>>   run 1 maximum           122.811 ms            0.113 ms
>>   run 2 maximum           141.198 ms            0.095 ms
>> 
>> The displayed 0.004 ms averages are rounded to three decimal places.
>> Maximum unlink/recreate latency was 777.852 and 770.569 ms before, versus
>> 8.525 and 15.624 ms after. Those mutation maxima are supporting observations:
>> workers ran only during the watch-add loops, so the pre-change and post-change
>> mutation measurement windows had very different lengths.
> 
> This looks good and is kind of expected. We don't have to traverse the huge
> children list.
> 
>> One 100,000-iteration, single-worker open/close event-path run per mode gave:
>> 
>>                          Before                After
>>   none:   p50/p99 ns      9564 / 15703          9684 / 15023
>>           throughput      102221 ops/s          101432 ops/s
>>   other:  p50/p99 ns      9554 / 15573          9684 / 14962
>>           throughput       99442 ops/s          101497 ops/s
>>   parent: p50/p99 ns     12529 / 19179         12499 / 17716
>>           throughput       78196 ops/s           78655 ops/s
>> 
>> The 'other' mode watches a different directory on the same filesystem, so it
>> exercises the superblock watcher path without target-file event delivery.
>> These are single runs; they do not establish a small event-path cost or its
>> absence. No open/close regression is apparent at this measurement resolution.
>> The test used worker CPU 2 and listener CPU 4 on kernels
>> 6.19.0-rc8.V_fsn0.el9.omm0.x86_64 and 6.19.0-rc8.fsn3.el9.omm3.x86_64,
>> respectively. The test host reported XFS for its working directory.
>> 
>> The inotify correctness test and broader fsnotify functional test passed on
>> both kernels. The fanotify permission subtest skipped with EPERM in both runs,
>> so FAN_OPEN_PERM remains unvalidated by these results.
> 
> This isn't a load for which the DCACHE_FSNOTIFY_PARENT_WATCHED optimization
> is that interesting. Try the following:
> 
> Create a directory on tmpfs with say 1024 files, each 4k large.
> Place IN_MODIFY inotify watch on the directory.
> Start X clients (where X can be 1,2,4,8,...,1024 to see the scaling)
>   The client will open the file based on its number (so different clients
>   work on different file)
>   Do 1000000 writes of 1 byte at offset 0 to the file => measure time for
>     this
>   Close the file
> 
> I would bet you would see the difference already at 1 client and as the
> number of clients grows and the cacheline contention on the parent's
> refcount increases, it will get progressively worse. In particular if you
> try on a NUMA machine where the cacheline will ping-pong across NUMA nodes.
> 
> We've got performance regression reports for similar loads already when we
> added one cacheline load to fsnotify_parent(). Doing the "grab parent
> refcount" dance is much more expensive than that.
> 
> 								Honza
> 

Hi Honza,

Thanks for suggesting this workload.
The setup and before/after timing comparisons are below.

Architecture:                x86_64
CPU(s):                      512
  On-line CPU(s) list:       0-511

NUMA:
  NUMA node(s):              2
  NUMA node0 CPU(s):         0-127,256-383
  NUMA node1 CPU(s):         128-255,384-511


Testcase :
Using /dev/shm  tmpfs to create  private test directory.
Create 1,024 files each fully populated with 4kb.
Add IN_MODIFY inotify watch to the directory.
Start a listener thread to read notifications and count queue overflows.
Start X(1,2,4..1024) client threads; each opens a different file once.
Wait until every client is ready, then release them together.
Each client starts its timer and performs 1000000
one-byte pwrite() at offset0 on its own file.
Each client stops its timer and closes its file.
Wait for all clients to finish, drain remaining notifications,
and stop the listener.
Print write times, throughput, notification count, and queue-overflow count.
Close inotify and delete the test files and directory.

Note : File creation, open, close, and cleanup are outside the timed
write loops.

Run 1:
-------

| Clients | Before average time | After average time | Time change |
|---:|---:|---:|---:|
| 1 | 1.392 s | 1.484 s | +6.6% |
| 2 | 2.205 s | 2.402 s | +8.9% |
| 4 | 3.969 s | 3.644 s | −8.2% |
| 8 | 5.851 s | 5.804 s | −0.8% |
| 16 | 10.607 s | 11.538 s | +8.8% |
| 32 | 21.093 s | 22.492 s | +6.6% |
| 64 | 48.698 s | 49.576 s | +1.8% |
| 128 | 100.208 s | 100.467 s | +0.3% |
| 256 | 198.773 s | 197.669 s | −0.6% |
| 512 | 400.056 s | 399.550 s | −0.1% |


Run2 :
--------

| Clients | Before average time | After average time | Time change |
|---:|---:|---:|---:|
| 1 | 1.491 s | 1.484 s | −0.4% |
| 2 | 2.391 s | 2.402 s | +0.5% |
| 4 | 4.050 s | 3.644 s | −10.0% |
| 8 | 6.630 s | 5.804 s | −12.5% |
| 16 | 11.931 s | 11.538 s | −3.3% |
| 32 | 22.513 s | 22.492 s | −0.1% |
| 64 | 50.231 s | 49.576 s | −1.3% |
| 128 | 100.699 s | 100.467 s | −0.2% |
| 256 | 198.771 s | 197.669 s | −0.6% |
| 512 | 401.860 s | 399.550 s | −0.6% |
| 1,024 | 803.812 s | 806.593 s | +0.3% |


Positive means After Fix took longer; negative means faster.


The measured write performance is broadly comparable before and after
the fix, with no consistent substantial regression or progressively
worsening slowdown as concurrency increases.

The differences vary between baseline batches: the increases at 16
and 32 clients in the first comparison disappear or reverse in the
second. At 128–1024 clients, average write times differ by approximately
0.6% or less. These shifts are consistent with run-to-run variation;
the results do not show a persistent substantial slowdown from the fix.

Thanks,
Partha

>> 
>> Partha Sarathi Satapathy (1):
>>   fsnotify: Check parent watches without child dentry flags
>> 
>>  fs/dcache.c                      |  4 --
>>  fs/notify/fsnotify.c             | 99 ++++++++------------------------
>>  fs/notify/fsnotify.h             |  6 --
>>  fs/notify/mark.c                 | 35 -----------
>>  include/linux/dcache.h           |  1 -
>>  include/linux/fsnotify.h         |  7 +--
>>  include/linux/fsnotify_backend.h | 29 ++--------
>>  7 files changed, 29 insertions(+), 152 deletions(-)
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

