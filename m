Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CDE2AD0C;
	Wed, 29 Apr 2026 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777454974; cv=fail; b=F6R9fMeQTj7sX09YZqB2OIEm0kXAezLKnhy2De6zJZ1DVWAEScg5kfULUdgAzyIi3qS8FJFAwWtOWwnn7fNVOsTLmk7vawaMrylxk/2fpGPsPo8r//Ku/pDxRdaey21RdXwktV4Nzp9kq73acMiVDZWbXcQYK+mLFQaBVZBeYwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777454974; c=relaxed/simple;
	bh=JC39OQMHGpEMlc/TX1iP52Ph97szR99xFHUJ+mJR+KU=;
	h=Content-Type:Message-ID:Date:Subject:To:Cc:References:From:
	 In-Reply-To:MIME-Version; b=rrSxA1fN9q9zc5W6qNT776d0E9Hgk9D+fKnsSFl3+i4NIkALeNeAaBP7mP6cKjxp8SldZQ17xbWoTt8Ro3KZ3+mTR5hDuZCkjJuocBUAc8dErcaIdvjz6tmU6xWk+F9uAY+8wLwM2U9wFHhFtpGJnR5oVZBcZ5qUDQ/7htraNH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=hwmcN7uz; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="hwmcN7uz"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022099.outbound.protection.outlook.com [52.101.53.99]) by mx-outbound44-15.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 Apr 2026 09:29:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbU81oNgYJZc9AF/MoQgxxLybrpBA+wpkj/RkqpB3SLQzj7zr1M1oLo0wsv5qLvQFHN+FODKv9gtfZSbasWO/vQQrI0y1nEbe8VN+Xt59LL8XdbIXv2nkkV/krzsJHI619gU32wxPXpAU+/sNtvO0waYYU+wVnvrcfDLE8mtqA6DRWhvnKuI21ySLlaMNXcik6b8B6yZWFRkZKgWzRSDNy8rKG5DjUIBqwktgL9kFrPe8HM7Zjxw4aSqmnKD2nTbk2DJEGNF5Du8tyovANEOhBhXo9haBdAAwO2HR5t6kQW2cwg+GBQ8+vPo5JHYLRkvl8WjEwQ2zKLzbGsxL0koLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6j4NhRKgiTn9kjx6fjY4rvk95pErmEgNbtKoQyHkRVE=;
 b=v0j6lKq8EiqcH31k3qZ5aQWOAosvaDmkrzlwMB0+mfKuQ2uqChF+Sw6pa1yoRP6qyCRDKBkk9zDsFWcAFTOTFZIu8HZBiZDTWY7/hwQBGpKw8OOkkrqXzPvjIG74wuwZPJ39p8OIkRBeZdJf/BoZKFHgTHVcZHTJAhGJVkaoS+mzNAI/74mIRjKUDl4g6Pns7aUYgotGonkp0+g3UCuwy/Wcp7OZKGvPWfHxEqSrocf0TIZXemmKY+zzbfIKxabjxOPfVaFxlB8wW3mJusta5kllRytplUmNbsdV6ws0gpVjNBBz2dBULLNtmcAjfGI4PuV2mBdCqgNCDBZwB75yzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6j4NhRKgiTn9kjx6fjY4rvk95pErmEgNbtKoQyHkRVE=;
 b=hwmcN7uz2Wfj55wk9HsyEZPqz0QggcfFJ1J6wprbUx4DNuI5N+yHE+k5sbQcCAwLsG3bJHfL8PQpDt8vvUW/f75IuzmqOi/6DfKchMoOeSuIw1jy4KhUP8bUA2pVTc2/cNGer9L99rPvPtISV5K6QgvtsCXjr5/z0/djJNAevNQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by SA0PR19MB4603.namprd19.prod.outlook.com (2603:10b6:806:b3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 09:29:07 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%7]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 09:29:06 +0000
Content-Type: multipart/mixed; boundary="------------FQ1Ag4DgjhlatumaKPQue1wl"
Message-ID: <3e889026-de19-4238-ad5a-6d7b31845603@ddn.com>
Date: Wed, 29 Apr 2026 11:29:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: back uncached readdir buffers with pages
To: "Matthew R. Ochs" <mochs@nvidia.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Joanne Koong <joannelkoong@gmail.com>
References: <20260428233028.2747981-1-mochs@nvidia.com>
From: Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <20260428233028.2747981-1-mochs@nvidia.com>
X-ClientProxiedBy: PA7P264CA0030.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2df::18) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|SA0PR19MB4603:EE_
X-MS-Office365-Filtering-Correlation-Id: a35ccf82-cfcc-44e5-8455-08dea5d1c270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|6049299003|10070799003|19092799006|366016|376014|4013099003|4053099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	S5Z8cOX3sUk0uoOyazv3KGo0A9TaIIEDECYVX0wv2phsJag4ikJ5FeYPIwsxcFWg66sWSftMlwiJ9uK95kA+Rnxr62kGMOCRT44qQglPOz9QJht7JWjIhOrLoNr2moBGiTaTm08doNRAjcjhqK/sJnXhyDK+ITDDko74awrfpXC1KKhpe0rMsJnBIFpCHSjV178xdtW3MdfZ53e7IoN05vTrZXWcdv3XnvnvC3+k0Zkl3RBbpsPvZKop1+Ycnf+2VVnMj2CuKfAlbpBg/aguflgikQKv6a1jVnvBUF6uiwf25YBZBUyIgHj+kyqwcdzwZuyokgUxtxi5iTRaswbBKSZipHYGwprzVMuwCKgOKsKa/VZmF9F19ao7YVHRq+Kvl64EoQqbuZGVWXCscZFDoES00h6yWODZLt5fhnWMP2Uf5+2VfEyYNZ6zs8T+cqIIBzuIvWwjHvzV3lu2nkNq3QfqWCXE2tqF1k6umXl090IbKzd98WwSiCVNe+NZlUkb4weRGOuH2fxgTJqplSADpCcOeIMDMStcjPAaS1yzHG/uXDtdPQnL935QMOhANmhDe/3LKSx096DHCAJ7SVA5dB5ISBzePhNa7Uz0vS45UW+qa37GApadGACTSKnB/rSiknSy9Da0vibc48DmRY+iYR5/H/dGzSVH/BuWhVaWKudOxlFDYnTPQPMS4tW+dU+BVM9h9hJ3KDookMilSYJ513ZLhsVMmPOVMd49BjAIYWBRp85PTQK8wZNtB+rhLy4z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(6049299003)(10070799003)(19092799006)(366016)(376014)(4013099003)(4053099003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFNkYUZ1dW9iQ0p4RjhCRVlUcllMMjRzRmxXY2JwOWpRejFTTXdwWHJRVHhD?=
 =?utf-8?B?cy9iV0hUTHg0SUF2TkhIYmpKWkJzbFBwRzVuZm5BVWRBSDZ6REhsWDg4VHVU?=
 =?utf-8?B?S05XY2RIRWgwclpCOGdZM0t5RmQwRFBXYVNEaXBOT0RaUW9zc3I3R0Nsdjlq?=
 =?utf-8?B?dmV3RnVDbVQ1L3dhR1JJTDA0NVNhcUZRYkd5THNqdmRZMUsyV1ZpaFQ5cnpY?=
 =?utf-8?B?ZmJrU0ROanAyTjU2QlBjcnl4Q21ieE1zZm1VSW5LZnFwb0NtMWUvYVhFNnFG?=
 =?utf-8?B?NGtSNUp3ZGVDWWpKTDJEeXdrbk9sSkRNQ1BaV1ZWQ0R6aTRnakEwTXpFakhC?=
 =?utf-8?B?TGZjQzJQY0g0Um1FZnlNdGEvdGxDVExoZ29OZ0RIU3V2QmZvdkpTTDdGUlYw?=
 =?utf-8?B?VWM4Z0VLQlZnbmNFNTBScWpBZ2lkTFVOMzBSMGs2Ujh6Y0J5Y0tKaHBhS0Vq?=
 =?utf-8?B?T1pmYUtNVHIrYlluckNhSlYvOE94SzRIVC95UkJUSFVjUWJnMHBKbzJhMHU4?=
 =?utf-8?B?VjhxR2M4bGVuM004VU01cld4bkF1aitOcElaVkpITlBRUjNHaWRiWWhPcUtL?=
 =?utf-8?B?MDlJRktLZFQvQ0IrVCt0eGhzT3R2d1VFZlpiV1o0TVkzRlB1bWN0bG1KUGVn?=
 =?utf-8?B?ck8zY1BZNnNwdEhwZlhIamRVbGIzVW9jYjhRUHNXQzFoTTFxbURENklLUm9s?=
 =?utf-8?B?RHg3cjhvaGoySy9laHpaOWFrcDR5UEI4dmo0R3duTHN2S2hhUDF5VVZ1bGVO?=
 =?utf-8?B?RzQ0emFFemU1UnFIK1F4bWx2VHpraWMrNWUrN01TK1JaUHhhY3Q3M25yd0Ft?=
 =?utf-8?B?emhrTUo0a0FSdGY0ZTNlS09NU2ZrYXZhSXhrbWV4R1VjRnd3WWIzdkhtZit1?=
 =?utf-8?B?QTdiQ2REM0RsaGUycjFQTVhPK1dULzdkZFV4c1JvL0kyT0JoUXBYTXFWMmZo?=
 =?utf-8?B?cFU3R2lrVHhHbVg0dndTeHQ5VVFCN2c3K0NYM0djY2ZNaVBWOUZneFRxbjQ0?=
 =?utf-8?B?S1NXYUlCeXIvcXpTb09BeWhJaFNWbTVlODhLNVhuN2dGUVN3RzlpejNMeXZq?=
 =?utf-8?B?R3JpWHVwOGtNWSt6VjFJaVVxN3pOU1dqMUl5b0pXdi9ZSjRjdjFFWkNVTEZV?=
 =?utf-8?B?d1RRVytwTnlhNTRuUDlCUUMyenRzQUpwdWVSSGhabWFJTnJIWXFvU0dwSWZG?=
 =?utf-8?B?Z203Mm5WWERNeXpQeGtZSDhzRnlkdGRDKzNJNGRYYU5IRHUrakdUWXMrRGZx?=
 =?utf-8?B?KzJ4Z3NJUGFoZjE1NUtrUk1nYlB4ZlpnczV5UUNhdHRnRTFiQ2tBMWN2L0xJ?=
 =?utf-8?B?UkFTaFNrMmE3SnY5T2lSRXlFQ2ZpODdGL0pHeklxNXBMaXVUSEFMM0huWnNQ?=
 =?utf-8?B?b09Tb1pjWjZONy9wa280SDkvcVpHM2tRbnh5WkFXbXY3YmVZWFA3cVFsVE5Z?=
 =?utf-8?B?aS9FVTZFUXkzS2RrM1l5Ylg2eENHQU9oVGlzZmFrenZGUHdXVzZWZ3dnbkoz?=
 =?utf-8?B?aDJJQTh0N2Jqc29DYVY2VlBVWkFkNnowUlZkeG5pV29wM3dvYnNyQy9zejdP?=
 =?utf-8?B?MFc0bnFlWFQ2UFpuVWZuQmg1c2ZTYi9NTW5YUUgzbFRvdDR0dzFSWlZpZ0Y5?=
 =?utf-8?B?RjhkeTZFdVhzb1VLUGhDdDlIUHFXWVB3L2lycWFyNzYzRVRSVnlzNnpnUEp6?=
 =?utf-8?B?OGRkY1VEZFhOeHVseVBkUnJ1R3VrUk9FWktiRmlFb1FkdVlZa05Yeks3UGZV?=
 =?utf-8?B?bitZK0xWVENWK3pDMXJBdXhtZ2RYR1RacFRabTdYMzcybWlUN013bElCK0Va?=
 =?utf-8?B?bHJjc2NYdURSZ0VqQ2NNeFdmb1h3UkxweUFEYUVyVUJ1TG5td2w3anFYS2Qw?=
 =?utf-8?B?YWJ2TWlZQ2hJUWlueWFJMkRrQzdUZzZETG9xWjFiZ1FvaU9Ld0xOWTFGc2pS?=
 =?utf-8?B?RDhrTEM3Mm92cEN5OXBISEdLeFZ5Zk9oT2R3TUllSTN0OU9DbGpsT1N3RnNi?=
 =?utf-8?B?eTlhS1RjVmMxUmZTSGVWU016bGM5QmVUWTZ3WUJtQjNMVzlMcW5hV1ZVNEJR?=
 =?utf-8?B?VVNqcmpEbHFhYUwwK2cvL3BGMnloKzZwWmNJRm9KOWhMaXN0a09PYllrQU1y?=
 =?utf-8?B?OVBuSkcrbkZtdDlnUXAvN0Vzck1jZ04zTGY2UzlyalVuNlNoR0w0ZkdYdW1u?=
 =?utf-8?B?YlZCSUhCZ3NyZmxkWkoxZWovK1VuaUYrdFQ2WUh6OXBXUTQ1ZWdmRXpZNXZi?=
 =?utf-8?B?VGhuSzhxVm5POEFIQ3kreVpBcTJibGtFRTA4WCtNY1BRWnRldUlWWlNpbXdY?=
 =?utf-8?B?RWEvOHhzakMweHkybHV0THRkR3FJbXRWdVJySnl4Ujg3ak1LNVBhU0Z4dEZl?=
 =?utf-8?Q?cf/yPZ0A4TeO+6+scejFzIu8IbYax/En/3VgsW4pB/pao?=
X-MS-Exchange-AntiSpam-MessageData-1: lxsgC83Q009qDg==
X-Exchange-RoutingPolicyChecked:
	fKJ8UgLBNRCZb2lUREY8c3BAZ3VwoAssBiZ+Kn5gnoCBbbY0gQ2FTPjXSEkUotUemXoYGsqI9Rnt8vO3q7yGVZGN+xcy2ujIvI9hdTPyC4CACzK8bfr50I20l/yL73DPi8et6uzwa5mQXO7CgAStLtxP6lHKpDsDI5SZlEnH9HXT740WwyBk0GtvnVN+9nH4VAdEgEnMSlM8vbf849AOpojFeCCaiwnHF32uFe6dm1HhGoLsDo3nVW27YWay6KGvAG2A+Z1VaAAcLXN0EYwMi+QFbjkx3sG0NAZk2SFwFBS+HOkTlvwX3t9W9bypvRLQfZFfc2dgj0Kz+76Ftnvdmg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hjjU1+G5rdFY1hUZJAbseN1FGmII5wDR5dJpFFB9Q38Fz/xb4lH5lbsaZeUYkilJ3jrAtijHBFe6UeJUcehD/nMuuTJ1Yrf8c+Db6aH8LcUwg71Q3qi2xGdDG+BZfZMXuudisKTILVLsrLbbH10imUE9VnnnyK6KDX/d24zxPvrtTtlPCnYk9Dd1uLEf6Bk1XPAOJDCDY7841FEfFdZd5bzYMnWwRBkntpRfPDcZN8PyAeJQGgKBm6qWxEiq9ipyMrdDbjOVgLQxHIzRYlLYZ04YpcU+hXsQ74ffSwsZaEfmW4hQQdF1vznHPJlT3POrhevD1wHwG+3B9YJiMmWs5DKO75A8uDZxz15Eg6cCBrkAjviiTihxpEZWRTFHlNhpJc6rQ/MV5rB/7smzH7J1tywey7KgMM5r04f8pfyjilEHF+gbD7MfgjPHAxVL0zYed5EnbVJ4/e/wXjHGfyggz81ZRWvcT3ym36rj6xvfD8Gx3Uh7ZYIE47ge1lhtIpQ/YMW6/NJ4hfVukEMfibkK/0LAKWU3FAjMyF96nz+nQey4Da3x8ZAbTY3JPHIQYuQYI9U2Gzo5OmLzW68/+MHaRWAe2jA6/7OarnHkEDt9qQTy+rP44EGhpe16q/PnjKwNiCFbuqHHSVAafp2Q1/uRNQ==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a35ccf82-cfcc-44e5-8455-08dea5d1c270
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 09:29:06.3820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8r0SB5wJnMK1L2ppxzI3q3EZkpvmmXoYBEdlbb2z4AroYP82lxQOvT4U8HmQLE4r1oC3nFgwjoEWOKIIRb/RJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4603
X-BESS-ID: 1777454950-111279-26207-31699-1
X-BESS-VER: 2019.1_20260409.1619
X-BESS-Apparent-Source-IP: 52.101.53.99
X-BESS-Parts: H4sIAAAAAAACA2XLMQ4CMQxE0bu43mLWSexkr4Io7MQRHQVbIKG9OynoaEZfI7
	3bh+J90kHn2o2eLzoUklY91jlisLQcPCrQAa3SEkK4O2vA6Nr+fUXSn++z2ILFm/jep4
	vnLFphuk82K3Tdvz60PmeBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272896 [from 
	cloudscan17-8.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

--------------FQ1Ag4DgjhlatumaKPQue1wl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/26 01:29, Matthew R. Ochs wrote:
> [You don't often get email from mochs@nvidia.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Commit dabb90391028 ("fuse: increase readdir buffer size") changed
> fuse_readdir_uncached() to size its temporary buffer from ctx->count.
> That is useful for overlayfs and other in-kernel callers that use
> INT_MAX to indicate an unlimited directory read.
> 
> The buffer is capped by fc->max_pages converted to bytes with PAGE_SIZE.
> However, fc->max_pages is a page-count limit, while fc->max_write is the
> negotiated byte-sized payload limit. Using only fc->max_pages can produce
> a READDIR request larger than the server is prepared to handle, especially
> when the server and client use different page sizes.
> 
> The larger buffer is also currently supplied as a kvec output argument.
> For virtiofs, kvec arguments are copied through req->argbuf, which is
> allocated with kmalloc(..., GFP_ATOMIC). A large readdir buffer can
> therefore require a multi-megabyte contiguous atomic allocation and fail
> with -ENOMEM.
> 
> This was observed with a 64K-page guest on a 4K-page host, using an
> overlayfs mount whose lower directory is on virtiofs. Reading a merged
> directory through overlayfs failed with:
> 
>   ls: reading directory '<path>': Cannot allocate memory
> 
> Avoid the oversized request and the large bounce-buffer allocation by
> capping the requested byte size by both fc->max_pages and fc->max_write,
> then backing the uncached readdir output with pages and setting out_pages.
> The virtiofs transport can then pass the pages as scatter-gather entries
> instead of copying the output through argbuf.
> 
> Map the pages with vm_map_ram() only while parsing the returned dirents,
> so the existing parser can continue to operate on a linear kernel mapping.
> 
> Fixes: dabb90391028 ("fuse: increase readdir buffer size")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew R. Ochs <mochs@nvidia.com>

Josef and Joanne had spent quite some time to allow to use large folios
- maybe we should make use of it? Attached is a totally untested patch
and that ignores all of Miklos' comments for now. Also cannot be that
easily back ported

Thanks,
Bernd


> ---
> v2:
> - Reworked uncached readdir to use output pages and out_pages, per Miklos.
> - Cap the requested byte size by both fc->max_pages and fc->max_write.
> - Map pages with vm_map_ram() only while parsing returned dirents.
> - Verified with --overlay-rwdir across 4K/64K host and guest page sizes.
> - Link to v1: https://lore.kernel.org/all/20260428021304.2338592-1-mochs@nvidia.com/
> 
>  fs/fuse/readdir.c | 67 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 57 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index db5ae8ec1030..27162084a683 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -12,6 +12,7 @@
>  #include <linux/posix_acl.h>
>  #include <linux/pagemap.h>
>  #include <linux/highmem.h>
> +#include <linux/vmalloc.h>
> 
>  static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
>  {
> @@ -343,17 +344,45 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
>         struct fuse_mount *fm = get_fuse_mount(inode);
>         struct fuse_conn *fc = fm->fc;
>         struct fuse_io_args ia = {};
> -       struct fuse_args *args = &ia.ap.args;
> +       struct fuse_args_pages *ap = &ia.ap;
> +       struct fuse_args *args = &ap->args;
> +       struct page **pages;
>         void *buf;
> -       size_t bufsize = clamp((unsigned int) ctx->count, PAGE_SIZE, fc->max_pages << PAGE_SHIFT);
> +       size_t max_bufsize = min_t(size_t, (size_t)fc->max_pages << PAGE_SHIFT,
> +                                  fc->max_write);
> +       size_t count = ctx->count > 0 ? ctx->count : PAGE_SIZE;
> +       size_t bufsize = min_t(size_t, max_t(size_t, count, PAGE_SIZE),
> +                              max_bufsize);
> +       unsigned int nr_pages = DIV_ROUND_UP(bufsize, PAGE_SIZE);
>         u64 attr_version = 0, evict_ctr = 0;
>         bool locked;
> +       unsigned int nr_alloc = 0;
> +       unsigned int i;
> 
> -       buf = kvmalloc(bufsize, GFP_KERNEL);
> -       if (!buf)
> +       pages = kvcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> +       if (!pages)
>                 return -ENOMEM;
> 
> -       args->out_args[0].value = buf;
> +       while (nr_alloc < nr_pages) {
> +               unsigned int last = nr_alloc;
> +
> +               nr_alloc = alloc_pages_bulk(GFP_KERNEL, nr_pages, pages);
> +               if (nr_alloc == last)
> +                       goto nomem;
> +       }
> +
> +       ap->folios = fuse_folios_alloc(nr_pages, GFP_KERNEL, &ap->descs);
> +       if (!ap->folios)
> +               goto nomem;
> +
> +       for (i = 0; i < nr_pages; i++) {
> +               ap->folios[i] = page_folio(pages[i]);
> +               ap->descs[i].length = min_t(size_t,
> +                                           bufsize - (size_t)i * PAGE_SIZE,
> +                                           PAGE_SIZE);
> +       }
> +       ap->num_folios = nr_pages;
> +       args->out_pages = true;
> 
>         plus = fuse_use_readdirplus(inode, ctx);
>         if (plus) {
> @@ -372,17 +401,35 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
> 
>                         if (ff->open_flags & FOPEN_CACHE_DIR)
>                                 fuse_readdir_cache_end(file, ctx->pos);
> -               } else if (plus) {
> -                       res = parse_dirplusfile(buf, res, file, ctx, attr_version,
> -                                               evict_ctr);
>                 } else {
> -                       res = parse_dirfile(buf, res, file, ctx);
> +                       buf = vm_map_ram(pages, nr_pages, -1);
> +                       if (!buf) {
> +                               res = -ENOMEM;
> +                       } else {
> +                               if (plus)
> +                                       res = parse_dirplusfile(buf, res, file, ctx,
> +                                                               attr_version,
> +                                                               evict_ctr);
> +                               else
> +                                       res = parse_dirfile(buf, res, file, ctx);
> +
> +                               vm_unmap_ram(buf, nr_pages);
> +                       }
>                 }
>         }
> 
> -       kvfree(buf);
>         fuse_invalidate_atime(inode);
> +
> +out:
> +       kfree(ap->folios);
> +       for (i = 0; i < nr_alloc; i++)
> +               __free_page(pages[i]);
> +       kvfree(pages);
>         return res;
> +
> +nomem:
> +       res = -ENOMEM;
> +       goto out;
>  }
> 
>  enum fuse_parse_result {
> --
> 2.50.1
> 

--------------FQ1Ag4DgjhlatumaKPQue1wl
Content-Type: text/x-patch; charset=UTF-8;
 name="readir-use-large-folios.patch"
Content-Disposition: attachment; filename="readir-use-large-folios.patch"
Content-Transfer-Encoding: base64

ZnVzZTogcmVmYWN0b3IgcmVhZGRpciB0byBzdXBwb3J0IGxhcmdlIGZvbGlvcwoKRnJvbTogQmVy
bmQgU2NodWJlcnQgPGJlcm5kQGJzYmVybmQuY29tPgoKVGhlIGN1cnJlbnQgaW1wbGVtZW50YXRp
b24gaW4gZnVzZV9yZWFkZGlyX3VuY2FjaGVkKCkgYWxsb2NhdGVzIGluZGl2aWR1YWwKcGFnZXMg
YW5kIGNvbnZlcnRzIHRoZW0gdG8gZm9saW9zLCB3aGljaCBwcmV2ZW50cyB0aGUgdXNlIG9mIGxh
cmdlIGZvbGlvcwphbmQgbWFrZXMgdGhlIGNvZGUgbGVzcyBlZmZpY2llbnQsIGVzcGVjaWFsbHkg
b24gc3lzdGVtcyB3aXRoIGxhcmdlIGJhc2UKcGFnZSBzaXplcy4KClRoaXMgcGF0Y2ggcmVmYWN0
b3JzIHRoZSBhbGxvY2F0aW9uIHRvIGRpcmVjdGx5IGFsbG9jYXRlIGZvbGlvcyB3aXRoCm9wcG9y
dHVuaXN0aWMgbGFyZ2UgZm9saW8gc3VwcG9ydCwgc2ltaWxhciB0byBuZXRmcy4gVGhlIGtleSBj
aGFuZ2VzOgoKMS4gTmV3IGhlbHBlciBmdW5jdGlvbiBmdXNlX3JlYWRkaXJfYWxsb2NfZm9saW9z
KCkgdGhhdCBhbGxvY2F0ZXMgZm9saW9zCiAgIGRpcmVjdGx5IGluc3RlYWQgb2YgYWxsb2NhdGlu
ZyBwYWdlcyBhbmQgY29udmVydGluZyB0aGVtCjIuIFRyaWVzIHRvIGFsbG9jYXRlIGxhcmdlIGZv
bGlvcyAodXAgdG8gTUFYX1BBR0VDQUNIRV9PUkRFUikgZmlyc3QgYW5kCiAgIGZhbGxzIGJhY2sg
dG8gb3JkZXItMCBmb2xpb3Mgb24gZmFpbHVyZQozLiBDYWxjdWxhdGVzIGRlc2NyaXB0b3IgbGVu
Z3RocyBiYXNlZCBvbiBhY3R1YWwgZm9saW8gc2l6ZXMgcmF0aGVyIHRoYW4KICAgaGFyZGNvZGVk
IFBBR0VfU0laRQo0LiBVcGRhdGVzIHZtX21hcF9yYW0oKSBoYW5kbGluZyB0byBleHRyYWN0IHBh
Z2VzIGZyb20gdmFyaWFibGUtc2l6ZWQKICAgZm9saW9zCgpCZW5lZml0cyBpbmNsdWRlOgotIFJl
ZHVjZWQgVExCIHByZXNzdXJlIHRocm91Z2ggdXNlIG9mIGxhcmdlIGZvbGlvcyB3aGVuIHBvc3Np
YmxlCi0gQmV0dGVyIG1lbW9yeSBlZmZpY2llbmN5IGFuZCBjYWNoZSBsb2NhbGl0eQotIEltcHJv
dmVkIGNyb3NzLXBsYXRmb3JtIHN1cHBvcnQgKGUuZy4sIDY0SyBwYWdlIHN5c3RlbXMpCi0gTm8g
cmVncmVzc2lvbjogZmFsbHMgYmFjayB0byBvcmRlci0wIGZvbGlvcyB1bmRlciBtZW1vcnkgcHJl
c3N1cmUKLSBGdXR1cmUtcHJvb2YgYXJjaGl0ZWN0dXJlIGFsaWduZWQgd2l0aCBrZXJuZWwgZGly
ZWN0aW9uCgpUaGUgaW1wbGVtZW50YXRpb24gaXMgc2ltaWxhciB0byB0aGUgYXBwcm9hY2ggdXNl
ZCBpbiBuZXRmcwooZnMvbmV0ZnMvbWlzYy5jKSBhbmQgZW5zdXJlcyBiYWNrd2FyZCBjb21wYXRp
YmlsaXR5IGJ5IGdyYWNlZnVsbHkKZmFsbGluZyBiYWNrIHRvIHNpbmdsZS1wYWdlIGZvbGlvcyB3
aGVuIGxhcmdlIGFsbG9jYXRpb25zIGZhaWwuCgpTaWduZWQtb2ZmLWJ5OiBCZXJuZCBTY2h1YmVy
dCA8YmVybmRAYnNiZXJuZC5jb20+Ci0tLQogZnMvZnVzZS9yZWFkZGlyLmMgfCAgMTg3ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgMTMzIGluc2VydGlvbnMoKyksIDU0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2ZzL2Z1c2UvcmVhZGRpci5jIGIvZnMvZnVzZS9yZWFkZGlyLmMKaW5kZXggNjg3MGJmZTczZGEx
Li5hZDU1NTEzNjVjZGYgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvcmVhZGRpci5jCisrKyBiL2ZzL2Z1
c2UvcmVhZGRpci5jCkBAIC0xNCw2ICsxNCwxMyBAQAogI2luY2x1ZGUgPGxpbnV4L2hpZ2htZW0u
aD4KICNpbmNsdWRlIDxsaW51eC92bWFsbG9jLmg+CiAKKy8qIEZvcndhcmQgZGVjbGFyYXRpb25z
ICovCitzdGF0aWMgaW50IHBhcnNlX2RpcmZpbGUoY2hhciAqYnVmLCBzaXplX3QgbmJ5dGVzLCBz
dHJ1Y3QgZmlsZSAqZmlsZSwKKwkJCSBzdHJ1Y3QgZGlyX2NvbnRleHQgKmN0eCk7CitzdGF0aWMg
aW50IHBhcnNlX2RpcnBsdXNmaWxlKGNoYXIgKmJ1Ziwgc2l6ZV90IG5ieXRlcywgc3RydWN0IGZp
bGUgKmZpbGUsCisJCQkgICAgIHN0cnVjdCBkaXJfY29udGV4dCAqY3R4LCB1NjQgYXR0cl92ZXJz
aW9uLAorCQkJICAgICB1NjQgZXZpY3RfY3RyKTsKKwogc3RhdGljIGJvb2wgZnVzZV91c2VfcmVh
ZGRpcnBsdXMoc3RydWN0IGlub2RlICpkaXIsIHN0cnVjdCBkaXJfY29udGV4dCAqY3R4KQogewog
CXN0cnVjdCBmdXNlX2Nvbm4gKmZjID0gZ2V0X2Z1c2VfY29ubihkaXIpOwpAQCAtMzMyLDYgKzMz
OSwxMTQgQEAgc3RhdGljIGludCBwYXJzZV9kaXJwbHVzZmlsZShjaGFyICpidWYsIHNpemVfdCBu
Ynl0ZXMsIHN0cnVjdCBmaWxlICpmaWxlLAogCXJldHVybiAwOwogfQogCisvKgorICogQWxsb2Nh
dGUgZm9saW9zIGZvciBmdXNlX2FyZ3NfcGFnZXMsIHByZWZlcnJpbmcgbGFyZ2UgZm9saW9zIHdo
ZW4gcG9zc2libGUuCisgKgorICogTm90ZTogVGhlc2UgYXJlIHRlbXBvcmFyeSBmb2xpb3MgZm9y
IGJ1ZmZlcmluZyBJL08gZGF0YSBmcm9tIHRoZSBzZXJ2ZXIsCisgKiBub3QgcGFnZWNhY2hlIGZv
bGlvcy4gVGhleSBhcmUgYWxsb2NhdGVkIHdpdGggZm9saW9fYWxsb2MoKSBhbmQgZnJlZWQKKyAq
IGltbWVkaWF0ZWx5IGFmdGVyIHVzZS4gVGhpcyBpcyBzaW1pbGFyIHRvIGhvdyBuZXRmcyBhbGxv
Y2F0ZXMgdGVtcG9yYXJ5CisgKiBidWZmZXJzIChzZWUgZnMvbmV0ZnMvbWlzYy5jKS4KKyAqLwor
c3RhdGljIGludCBmdXNlX2FwX2FsbG9jX2ZvbGlvcyhzdHJ1Y3QgZnVzZV9hcmdzX3BhZ2VzICph
cCwgc2l6ZV90IGJ1ZnNpemUsCisJCQkJdW5zaWduZWQgaW50IG1heF9mb2xpb3MpCit7CisJc2l6
ZV90IHJlbWFpbmluZyA9IGJ1ZnNpemU7CisJdW5zaWduZWQgaW50IG51bV9mb2xpb3MgPSAwOwor
CisJYXAtPmZvbGlvcyA9IGZ1c2VfZm9saW9zX2FsbG9jKG1heF9mb2xpb3MsIEdGUF9LRVJORUws
ICZhcC0+ZGVzY3MpOworCWlmICghYXAtPmZvbGlvcykKKwkJcmV0dXJuIC1FTk9NRU07CisKKwl3
aGlsZSAocmVtYWluaW5nID4gMCAmJiBudW1fZm9saW9zIDwgbWF4X2ZvbGlvcykgeworCQlzdHJ1
Y3QgZm9saW8gKmZvbGlvOworCQl1bnNpZ25lZCBpbnQgb3JkZXIgPSAwOworCQlzaXplX3QgZm9s
aW9fYnl0ZXM7CisKKwkJLyoKKwkJICogVHJ5IHRvIGFsbG9jYXRlIGxhcmdlciBmb2xpb3MgZm9y
IGJldHRlciBlZmZpY2llbmN5LgorCQkgKiBDYWxjdWxhdGUgb3JkZXIgYmFzZWQgb24gcmVtYWlu
aW5nIHNpemUuCisJCSAqLworCQlpZiAocmVtYWluaW5nID4gUEFHRV9TSVpFKSB7CisJCQlvcmRl
ciA9IG1pbl90KHVuc2lnbmVkIGludCwKKwkJCQkgICAgICBpbG9nMihyZW1haW5pbmcpIC0gUEFH
RV9TSElGVCwKKwkJCQkgICAgICBNQVhfUEFHRUNBQ0hFX09SREVSKTsKKwkJfQorCisJCS8qIFRy
eSB3aXRoIGRlc2lyZWQgb3JkZXIsIGZhbGwgYmFjayB0byBvcmRlci0wIG9uIGZhaWx1cmUgKi8K
KwkJZm9saW8gPSBmb2xpb19hbGxvYyhHRlBfS0VSTkVMLCBvcmRlcik7CisJCWlmICghZm9saW8g
JiYgb3JkZXIgPiAwKQorCQkJZm9saW8gPSBmb2xpb19hbGxvYyhHRlBfS0VSTkVMLCAwKTsKKwkJ
aWYgKCFmb2xpbykKKwkJCWdvdG8gbm9tZW07CisKKwkJZm9saW9fYnl0ZXMgPSBmb2xpb19zaXpl
KGZvbGlvKTsKKwkJYXAtPmZvbGlvc1tudW1fZm9saW9zXSA9IGZvbGlvOworCQlhcC0+ZGVzY3Nb
bnVtX2ZvbGlvc10ub2Zmc2V0ID0gMDsKKwkJYXAtPmRlc2NzW251bV9mb2xpb3NdLmxlbmd0aCA9
CisJCQltaW5fdChzaXplX3QsIHJlbWFpbmluZywgZm9saW9fYnl0ZXMpOworCisJCXJlbWFpbmlu
ZyAtPSBhcC0+ZGVzY3NbbnVtX2ZvbGlvc10ubGVuZ3RoOworCQludW1fZm9saW9zKys7CisJfQor
CisJYXAtPm51bV9mb2xpb3MgPSBudW1fZm9saW9zOworCXJldHVybiAwOworCitub21lbToKKwkv
KiBGcmVlIGFueSBmb2xpb3Mgd2UgbWFuYWdlZCB0byBhbGxvY2F0ZSAqLworCXdoaWxlIChudW1f
Zm9saW9zID4gMCkKKwkJZm9saW9fcHV0KGFwLT5mb2xpb3NbLS1udW1fZm9saW9zXSk7CisJa2Zy
ZWUoYXAtPmZvbGlvcyk7CisJYXAtPmZvbGlvcyA9IE5VTEw7CisJcmV0dXJuIC1FTk9NRU07Cit9
CisKK3N0YXRpYyBpbnQgZnVzZV9wYXJzZV9yZWFkZGlyKHN0cnVjdCBmdXNlX2FyZ3NfcGFnZXMg
KmFwLCBzaXplX3QgbmJ5dGVzLAorCQkJICAgICAgc3RydWN0IGZpbGUgKmZpbGUsIHN0cnVjdCBk
aXJfY29udGV4dCAqY3R4LAorCQkJICAgICAgYm9vbCBwbHVzLCB1NjQgYXR0cl92ZXJzaW9uLCB1
NjQgZXZpY3RfY3RyKQoreworCXN0cnVjdCBwYWdlICoqcGFnZXMgPSBOVUxMOworCXVuc2lnbmVk
IGludCBucl9wYWdlcyA9IDA7CisJdW5zaWduZWQgaW50IGk7CisJdm9pZCAqYnVmOworCWludCBy
ZXM7CisKKwkvKgorCSAqIEJ1aWxkIHBhZ2UgYXJyYXkgZnJvbSBmb2xpb3MgZm9yIHZtX21hcF9y
YW0oKS4KKwkgKiBUT0RPOiBPbmNlIHZtYXBfcmFuZ2VfZm9saW9zKCkgb3Igc2ltaWxhciBsYW5k
cyBpbiB0aGUga2VybmVsLAorCSAqIHdlIGNhbiBtYXAgZm9saW9zIGRpcmVjdGx5IHdpdGhvdXQg
ZXh0cmFjdGluZyBwYWdlcy4KKwkgKi8KKwlmb3IgKGkgPSAwOyBpIDwgYXAtPm51bV9mb2xpb3M7
IGkrKykKKwkJbnJfcGFnZXMgKz0gZm9saW9fbnJfcGFnZXMoYXAtPmZvbGlvc1tpXSk7CisKKwlw
YWdlcyA9IGt2bWFsbG9jX2FycmF5KG5yX3BhZ2VzLCBzaXplb2YoKnBhZ2VzKSwgR0ZQX0tFUk5F
TCk7CisJaWYgKCFwYWdlcykKKwkJcmV0dXJuIC1FTk9NRU07CisKKwlucl9wYWdlcyA9IDA7CisJ
Zm9yIChpID0gMDsgaSA8IGFwLT5udW1fZm9saW9zOyBpKyspIHsKKwkJdW5zaWduZWQgaW50IG5y
ID0gZm9saW9fbnJfcGFnZXMoYXAtPmZvbGlvc1tpXSk7CisJCXVuc2lnbmVkIGludCBqOworCisJ
CWZvciAoaiA9IDA7IGogPCBucjsgaisrKQorCQkJcGFnZXNbbnJfcGFnZXMrK10gPSBmb2xpb19w
YWdlKGFwLT5mb2xpb3NbaV0sIGopOworCX0KKworCWJ1ZiA9IHZtX21hcF9yYW0ocGFnZXMsIG5y
X3BhZ2VzLCAtMSk7CisJa3ZmcmVlKHBhZ2VzKTsKKwlpZiAoIWJ1ZikKKwkJcmV0dXJuIC1FTk9N
RU07CisKKwlpZiAocGx1cykKKwkJcmVzID0gcGFyc2VfZGlycGx1c2ZpbGUoYnVmLCBuYnl0ZXMs
IGZpbGUsIGN0eCwgYXR0cl92ZXJzaW9uLAorCQkJCQlldmljdF9jdHIpOworCWVsc2UKKwkJcmVz
ID0gcGFyc2VfZGlyZmlsZShidWYsIG5ieXRlcywgZmlsZSwgY3R4KTsKKworCXZtX3VubWFwX3Jh
bShidWYsIG5yX3BhZ2VzKTsKKwlyZXR1cm4gcmVzOworfQorCiBzdGF0aWMgaW50IGZ1c2VfcmVh
ZGRpcl91bmNhY2hlZChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgp
CiB7CiAJaW50IHBsdXM7CkBAIC0zNDIsNDIgKzQ1NywyMCBAQCBzdGF0aWMgaW50IGZ1c2VfcmVh
ZGRpcl91bmNhY2hlZChzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgp
CiAJc3RydWN0IGZ1c2VfaW9fYXJncyBpYSA9IHt9OwogCXN0cnVjdCBmdXNlX2FyZ3NfcGFnZXMg
KmFwID0gJmlhLmFwOwogCXN0cnVjdCBmdXNlX2FyZ3MgKmFyZ3MgPSAmYXAtPmFyZ3M7Ci0Jc3Ry
dWN0IHBhZ2UgKipwYWdlczsKLQl2b2lkICpidWY7CiAJc2l6ZV90IG1heF9idWZzaXplID0gbWlu
X3Qoc2l6ZV90LCAoc2l6ZV90KWZjLT5tYXhfcGFnZXMgPDwgUEFHRV9TSElGVCwKIAkJCQkgICBm
Yy0+bWF4X3dyaXRlKTsKIAlzaXplX3QgY291bnQgPSBjdHgtPmNvdW50ID4gMCA/IGN0eC0+Y291
bnQgOiBQQUdFX1NJWkU7CiAJc2l6ZV90IGJ1ZnNpemUgPSBtaW5fdChzaXplX3QsIG1heF90KHNp
emVfdCwgY291bnQsIFBBR0VfU0laRSksCiAJCQkgICAgICAgbWF4X2J1ZnNpemUpOwotCXVuc2ln
bmVkIGludCBucl9wYWdlcyA9IERJVl9ST1VORF9VUChidWZzaXplLCBQQUdFX1NJWkUpOworCXVu
c2lnbmVkIGludCBtYXhfZm9saW9zID0gRElWX1JPVU5EX1VQKGJ1ZnNpemUsIFBBR0VfU0laRSk7
CiAJdTY0IGF0dHJfdmVyc2lvbiA9IDAsIGV2aWN0X2N0ciA9IDA7CiAJYm9vbCBsb2NrZWQ7Ci0J
dW5zaWduZWQgaW50IG5yX2FsbG9jID0gMDsKIAl1bnNpZ25lZCBpbnQgaTsKIAotCXBhZ2VzID0g
a3ZjYWxsb2MobnJfcGFnZXMsIHNpemVvZigqcGFnZXMpLCBHRlBfS0VSTkVMKTsKLQlpZiAoIXBh
Z2VzKQotCQlyZXR1cm4gLUVOT01FTTsKKwlyZXMgPSBmdXNlX2FwX2FsbG9jX2ZvbGlvcyhhcCwg
YnVmc2l6ZSwgbWF4X2ZvbGlvcyk7CisJaWYgKHJlcykKKwkJcmV0dXJuIHJlczsKIAotCXdoaWxl
IChucl9hbGxvYyA8IG5yX3BhZ2VzKSB7Ci0JCXVuc2lnbmVkIGludCBsYXN0ID0gbnJfYWxsb2M7
Ci0KLQkJbnJfYWxsb2MgPSBhbGxvY19wYWdlc19idWxrKEdGUF9LRVJORUwsIG5yX3BhZ2VzLCBw
YWdlcyk7Ci0JCWlmIChucl9hbGxvYyA9PSBsYXN0KQotCQkJZ290byBub21lbTsKLQl9Ci0KLQlh
cC0+Zm9saW9zID0gZnVzZV9mb2xpb3NfYWxsb2MobnJfcGFnZXMsIEdGUF9LRVJORUwsICZhcC0+
ZGVzY3MpOwotCWlmICghYXAtPmZvbGlvcykKLQkJZ290byBub21lbTsKLQotCWZvciAoaSA9IDA7
IGkgPCBucl9wYWdlczsgaSsrKSB7Ci0JCWFwLT5mb2xpb3NbaV0gPSBwYWdlX2ZvbGlvKHBhZ2Vz
W2ldKTsKLQkJYXAtPmRlc2NzW2ldLmxlbmd0aCA9IG1pbl90KHNpemVfdCwKLQkJCQkJICAgIGJ1
ZnNpemUgLSAoc2l6ZV90KWkgKiBQQUdFX1NJWkUsCi0JCQkJCSAgICBQQUdFX1NJWkUpOwotCX0K
LQlhcC0+bnVtX2ZvbGlvcyA9IG5yX3BhZ2VzOwogCWFyZ3MtPm91dF9wYWdlcyA9IHRydWU7CiAK
IAlwbHVzID0gZnVzZV91c2VfcmVhZGRpcnBsdXMoaW5vZGUsIGN0eCk7CkBAIC0zOTEsNDEgKzQ4
NCwyNyBAQCBzdGF0aWMgaW50IGZ1c2VfcmVhZGRpcl91bmNhY2hlZChzdHJ1Y3QgZmlsZSAqZmls
ZSwgc3RydWN0IGRpcl9jb250ZXh0ICpjdHgpCiAJbG9ja2VkID0gZnVzZV9sb2NrX2lub2RlKGlu
b2RlKTsKIAlyZXMgPSBmdXNlX3NpbXBsZV9yZXF1ZXN0KGZtLCBhcmdzKTsKIAlmdXNlX3VubG9j
a19pbm9kZShpbm9kZSwgbG9ja2VkKTsKLQlpZiAocmVzID49IDApIHsKLQkJaWYgKCFyZXMpIHsK
LQkJCXN0cnVjdCBmdXNlX2ZpbGUgKmZmID0gZmlsZS0+cHJpdmF0ZV9kYXRhOwotCi0JCQlpZiAo
ZmYtPm9wZW5fZmxhZ3MgJiBGT1BFTl9DQUNIRV9ESVIpCi0JCQkJZnVzZV9yZWFkZGlyX2NhY2hl
X2VuZChmaWxlLCBjdHgtPnBvcyk7Ci0JCX0gZWxzZSB7Ci0JCQlidWYgPSB2bV9tYXBfcmFtKHBh
Z2VzLCBucl9wYWdlcywgLTEpOwotCQkJaWYgKCFidWYpIHsKLQkJCQlyZXMgPSAtRU5PTUVNOwot
CQkJfSBlbHNlIHsKLQkJCQlpZiAocGx1cykKLQkJCQkJcmVzID0gcGFyc2VfZGlycGx1c2ZpbGUo
YnVmLCByZXMsIGZpbGUsIGN0eCwKLQkJCQkJCQkJYXR0cl92ZXJzaW9uLAotCQkJCQkJCQlldmlj
dF9jdHIpOwotCQkJCWVsc2UKLQkJCQkJcmVzID0gcGFyc2VfZGlyZmlsZShidWYsIHJlcywgZmls
ZSwgY3R4KTsKLQotCQkJCXZtX3VubWFwX3JhbShidWYsIG5yX3BhZ2VzKTsKLQkJCX0KLQkJfQor
CWlmIChyZXMgPCAwKQorCQlnb3RvIG91dDsKKworCWlmICghcmVzKSB7CisJCXN0cnVjdCBmdXNl
X2ZpbGUgKmZmID0gZmlsZS0+cHJpdmF0ZV9kYXRhOworCisJCWlmIChmZi0+b3Blbl9mbGFncyAm
IEZPUEVOX0NBQ0hFX0RJUikKKwkJCWZ1c2VfcmVhZGRpcl9jYWNoZV9lbmQoZmlsZSwgY3R4LT5w
b3MpOworCX0gZWxzZSB7CisJCXJlcyA9IGZ1c2VfcGFyc2VfcmVhZGRpcihhcCwgcmVzLCBmaWxl
LCBjdHgsIHBsdXMsCisJCQkJCSBhdHRyX3ZlcnNpb24sIGV2aWN0X2N0cik7CiAJfQogCiAJZnVz
ZV9pbnZhbGlkYXRlX2F0aW1lKGlub2RlKTsKIAogb3V0OgorCisJZm9yIChpID0gMDsgaSA8IGFw
LT5udW1fZm9saW9zOyBpKyspCisJCWZvbGlvX3B1dChhcC0+Zm9saW9zW2ldKTsKIAlrZnJlZShh
cC0+Zm9saW9zKTsKLQlmb3IgKGkgPSAwOyBpIDwgbnJfYWxsb2M7IGkrKykKLQkJX19mcmVlX3Bh
Z2UocGFnZXNbaV0pOwotCWt2ZnJlZShwYWdlcyk7CiAJcmV0dXJuIHJlczsKLQotbm9tZW06Ci0J
cmVzID0gLUVOT01FTTsKLQlnb3RvIG91dDsKIH0KIAogZW51bSBmdXNlX3BhcnNlX3Jlc3VsdCB7
Cg==

--------------FQ1Ag4DgjhlatumaKPQue1wl--
