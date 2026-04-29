Received: from outbound-ip191b.ess.barracuda.com (outbound-ip191b.ess.barracuda.com [209.222.82.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6C935B136
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 16:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777480842; cv=fail; b=U+B6tu4yu9I1bUxnd+zFICJl9Ef16mvBH1nszlNbaOvpf4V2Jw32ou6uFmvHaRUqulFInOF/yNG0ufyx4AauFy/q8nj621NlOtpx2o0U3aVpPI0/ulcTfBiRe+6JsBsbNLUY2bySLYZ8Tk3yN99j8A7ljVPseeQeGh6RTHHQssg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777480842; c=relaxed/simple;
	bh=Lbk3sljK8ajyF/fCFnN2LXAk0EN/SWLvwLq7YZNIWmU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G/2uM2miWQqFbqPHpgpFKDHjz+JPrrjUoatlhCrwacVA5YE756fFbV8f7jpj/00ez9tFc+Tg/WqGEsaNAl5R2RqEWwQJvBGN8AXg8OHJET4FRqC/fQ9WRVE1OMJOkQuK3M478CoEVUSELWDDti8ECLLo61aduJs8aB6wOy6FFiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=m60PEUmM; arc=fail smtp.client-ip=209.222.82.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="m60PEUmM"
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11021111.outbound.protection.outlook.com [52.101.57.111]) by mx-outbound42-163.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 Apr 2026 16:40:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLnDLlCVeANGNoTjzKvzV6/Hw2Bm9H01SFV0ES1Y+EH/dZWNoXdXZ66QKQSQzlD4n0dg7DGM9Yf5hOmkN0vPwxuNAJi9r4Vj9gxFRZ8Jhfd+a0ToX5LwO0moMJ+B6igmig49WwgxmnLH4f8ivLnAs5/Q/VKu6cfJjoalJ82ilKlAZvYH26f2IyClYqCZpohRw6Wh1a47jyw6CIooPdpVv3pDXKQZsCXcAQd0b+3vm8EjWyjlRFpH1Go0GOvFLcj/1ZPgib0PEKAVjnCN6YS3yMajyTG2/WYcMB0SUX4ClBwyF8QYc9m9HnufHfAhxYR59bxuIMLNgNzH9B2VBYGKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EvvcVrehyd5dDXcN9lkyWSlINv97YxdI7FBqEprR00=;
 b=GRLZRDzTlI6TGynt4ztv03f13UnAo/cuvfYj66WXKcMk9Pwhqii3uC3zxWZ4lom0jZ7XSphD7QosuseDzoDrVXOKG26wn/WGxrQHJaor6VucCydDDI4iMM32VfMMkj+g4yeIIE7zGXLtWTE7xf7GouFDqtlmp+ZWPiOxlMv8Dc1ie4V1avRMMUNJJedXHzZMTl/Knz3Si6/xM1G5mxsZtyTFiMP3ryDmvRMlObtoKuEVWcpKPLZnUCkERZJPfDE6Ct/8t1w2pGXoO7FrC98wC8wYxRaXQ5+/HE9IiBxtaJ3qfej6oemOKdNGi4S5LTLdNXf2Yg8Yaz3xQq9peahi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EvvcVrehyd5dDXcN9lkyWSlINv97YxdI7FBqEprR00=;
 b=m60PEUmMHwcwxs4FqFZgJwYnCC2FaEG06sZ26rcUOoyIG7zdAU1zUEw3cl1fiXmJNd8E3d9hVEEh7zVRXNSS7ST3kImFshZKFjopKiWidqKGrJhP9PIYXTRJgFyEL4PbmmYnrw6wawKxtTUz+8iaziycmkTcvp4/TuQ8xpvHnEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by DS7PR19MB4565.namprd19.prod.outlook.com (2603:10b6:5:2cf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 16:07:06 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%7]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 16:07:06 +0000
Message-ID: <6ac13db3-9779-44e9-81c5-a2c6e76dcccf@ddn.com>
Date: Wed, 29 Apr 2026 18:07:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] fuse: Add retry attempts for numa local queues for
 load distribution
To: Joanne Koong <joannelkoong@gmail.com>, bernd@bsbernd.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
 <20260413-reduced-nr-ring-queues_3-v4-7-982b6414b723@bsbernd.com>
 <CAJnrk1ZnJ-p4aPCkk8=1v5bMFgo50GzGiixZuom9P=3p-nMTrg@mail.gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: fr
In-Reply-To: <CAJnrk1ZnJ-p4aPCkk8=1v5bMFgo50GzGiixZuom9P=3p-nMTrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0275.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:373::11) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|DS7PR19MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: 9845182f-6ba5-4231-540e-08dea6095bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|19092799006|366016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RQPodTeHvY9AVgKcYDr08ICjbM5xZE9/LGhxJBgQw3rCspBLPTtG+amLcw8jJW7slirnXl9ilvrlbojX7YLYagbsiVSMjY6Ue1x3VKl4ZdpQLGNU1qwn9pViLzNmU8lLP6AJQk//RqLqnsaI/FQ10RaSEEGeegcjWp04s4/5Spro3IE3mT9vH3gtcwAIlNVuPbwGMw6sC0wCP28CFBsvuy8rxTG/U3lQ2HZ3ljeJnJbGCuXP2jwwUwIvhxcdiJKJiSB51NSI8mZZapvFFVk//QvytS6ftl35NHs/UswpiTqO5xUx0xOpFyBv4OVfeuROnkur4619M24QyN/inVY5DXhO342PJVSTEfZLN5GxZp74pXoHIPocT6T/ACz26beLKZ+a5qX0IMj86mDgpc7SPj6CyZfFiwGvLPmPCb5tqbQQcm9snbw3Qo7/iHwxkqK9v+daL3AVCkxebWNP0hiqQiO5xqCKTQ51nSHFmlGXQTYjmRrd5V3ROG1yordqquZxzK0ox7z3LFoum1AIubdiRFopMXAy+oodd01E9oAs9UqwqaCjF2YMr+Lkv1l2A+yUyWyQQatL5T6RJmhlsYNsBLtWNEXJ5+QQYdiSw0JjKG4UTPIGDzL4gDJQk5R8mu7nwsS8AbUhmiXenunm2HM50EO/9VaTlcE4D3EXWwB30f0FJPYilf0AI9QoOXMfFlU5eRBvER+SMBRy57liQ0Hu0EHX8GaPYp5fqVCheephEO0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(19092799006)(366016)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2NSWlducDMzY2l4Nzk3K3ZPRGt3aEhhc1QxYTZBbVRqazJhU29wNWRqYnpI?=
 =?utf-8?B?bEMyUkgwdHFvZXRZRFlMMmd2Wmk1SFJSV3VaKzdCL3IwNlBKbm9UbkhhWVRR?=
 =?utf-8?B?bU5RYnlNc3BMK24rWmtWNXlaRFlsa0d0cDNBZVhxL1BCL0JvTEdnTmRlclZT?=
 =?utf-8?B?THdVZ0d0Q3VCNnlVdzI1ZkhPYm9UWmJTSXMwQitNTWYxd0orTHRxUnV2OUZJ?=
 =?utf-8?B?TDVhM2xJL2dRejZUVjlITEErZFlObU8xME5FR1VvN1V5dXg4aTBMcXVqTm5U?=
 =?utf-8?B?dFE5NmlUamxOblNQajh4ejlmVitDajExd3JLcHZ0eU5DeTdPbGd0V2g4S2Np?=
 =?utf-8?B?YUpSNFYzZ2MrRFpHMEFVQkxkMXVMUllSeFBCeTZHQUZsS3NlcDRnNCtMMUxQ?=
 =?utf-8?B?dDA2bnBzV1Jsejh0MEg4NnZUMlF5Z212TEZMRFdqRlMyWDh1MUFtZlR1WXZC?=
 =?utf-8?B?ZXgxbkhKc2lJTExMdkcwcGYra2g5UFo0MkNwdldRR2Jkc21GcktkL2RSY0JT?=
 =?utf-8?B?WWh6eWdnVGs2RHhrUzZPNnRxMGRJWlltL2VoWkFzcFNsQ0pSU0VuTmJ4cHF3?=
 =?utf-8?B?ZjFEUFBoR25IeWRWWS94d01XYUpaMEc5OHphQllrMnZ0RHJUTmMrOEFyd2M5?=
 =?utf-8?B?TTlpT0NDUVd1ZUYvWll2TDVpdFpGZ2NZQ21GWEQ0T1lYVnJsdU9Id3FPTWRi?=
 =?utf-8?B?V3JEWm43UWw3TXB0ZnFaaEdIK3J0b1llekxEbTJjWTJoZjdkWTVIVSs1S1Fy?=
 =?utf-8?B?bDlWb0puN051Smo4U01nbzQrNEFkRHBnSklrWFVMKzlmcU1NdmdBcTF4OGFJ?=
 =?utf-8?B?SkVSTHRmVFNWVlo4VTNBTlJhNWpHNDlDbHZNWWJLcEZRNHh0Mk9zUHdnL0NN?=
 =?utf-8?B?eW9zbTZKZWJ0TTBJOW9PTWs3MHVUNHZqaFJTQlpaL1B2MXRnTldrRnFwSU1T?=
 =?utf-8?B?K1djSDBMcVB3TVIrWkt2c283MGNrVTY2Zk94K082K2JydkpRajJEam9PTlRa?=
 =?utf-8?B?ck41c0JJWWRNbm1WWHBJNTFHYjR3REhVTjU1V3ROZmpNKzROTk1zYUt0blNa?=
 =?utf-8?B?WGo2U0daOVI3OE5sY0doWXhSV2xLYVV0UXgxQ3VGaklBODVaVXRTMTN1YzFn?=
 =?utf-8?B?cCtwaW9pQS9Lc3lLT2VYckc3TFpYaVUzb0c0aUp4cDV4RVVFMHU1SzBtaVUv?=
 =?utf-8?B?OThTQnBCRUZkY1F4anlxT3VZVVBIYmNsQjV4NlFBN2NjNkd6R3hzRkJMWXBB?=
 =?utf-8?B?b2lwZnRkaEczU2MybStiajBwRTRuTzg4VnVHc0J0VXF6M21BamFiUWVYRkYv?=
 =?utf-8?B?N1Y3dGZ6M3RRWkFhbFF5QmJTN3ZGSVNWOWovTWZxUlZMQWJzYVVtWFVTamVE?=
 =?utf-8?B?Tk5pVFVyZFlpa2Y3TkZYRjlLamxuNXFJQ0h4WjgyU3lrZ0ZlRzlQVm5TaGcw?=
 =?utf-8?B?TmVpTjFBTUMvQWpDWDNNZlpDYjFVR3RKWnEyR1hUSWRjMGMycGVYOXNwSTZS?=
 =?utf-8?B?U3ByTkZBUy9yQkY0eXc0YU96bm12ekI3akZvd2xYRlFYQ3NHM2xmZHVmTk92?=
 =?utf-8?B?R2QwYVJ5N0dDK0RVbUk2c1R2Q3kzVFNLVlNIbEYxZnlCbS9BU2dtZHpra21N?=
 =?utf-8?B?WmcvMDlFa2s3WFZQNXF0N3BXeHI5bnNJTWpBamgvVnVtWHhtYmxxSndtcU05?=
 =?utf-8?B?eVptMlJzYTlKOXdaTEZyZmIzUERMbE05RGQ1aTFjS1BCc1p2THBwUHUzWWxZ?=
 =?utf-8?B?UU5jY1VFaER1RlMxTUNqaVlpUzBNVU1YaDNJL2FQeVRZT1pZVHJOeklvbGZi?=
 =?utf-8?B?YnlHQW9FQVFVWStQTGVrZlcyek9qTkp4Sk9ZVzVqeGd6QXhxOGlzd0pzc2RS?=
 =?utf-8?B?OHdtUDRmNnlyZG9RSFpzajl0T0RZaXU0eUlaYisrck5HL0NSS21Pcjk1Yk5D?=
 =?utf-8?B?a0pGWEFvT0J3UWFBSlU0TXNpSmlYRmV1blRCbHVHRUpScmR4V1NSMkRYMmR0?=
 =?utf-8?B?YU9tUEpCK3lZSlNqSGdBWUlwcGRwdlhGdzB1OCtCYkVBcnBneWFTYTBLejk4?=
 =?utf-8?B?TXpYL3REclFHS0k2UHlCWFd3YldJbXJFdjBDYUthblUrZ0NWQUZTUmd2TXVU?=
 =?utf-8?B?QXhXN1AwaktqSGJ4QzF5d2VJNC92UnI3S0dPamR5MTBHTE5pdVovNFB1Uk1P?=
 =?utf-8?B?V2Z6ekFURmF5TDF3U3RUNytvaTJhVDBHSlIza3JvYzNMRGZNdjVCOGk1OVFt?=
 =?utf-8?B?V0JFb2J4L2xqRHJhTGFDZmVPSkcxMUJJQ0dMUmhvT2EwV2dveEw5NkxWbnJw?=
 =?utf-8?B?RHNmbW9pS2JaQXpEUW1WUVRFR1VyMXJJQkY4YU9icTZFcS9NS2dBajhYOU9R?=
 =?utf-8?Q?1cLGwCI9cZSyzKL7onwCloQbKh4T/0YCDy5xtvL+azIRZ?=
X-MS-Exchange-AntiSpam-MessageData-1: HWJTcw+HEYqAzA==
X-Exchange-RoutingPolicyChecked:
	T/OWQu1jVZzRQ2mJ1Vvw2mywHH3XHGf71JgxXdyaJlD+BxOZ0CXFoTw8P2axGhmjbrgbaNDIAwjf4eI0YRxi+6lKikdc4rsDgA7aPyYPJe4tognl/zVlVOFTgpvHmuXWrAnXYB7KZd9BFTU/olYuU+Mwnfn0TtKzjqZhAHuemvEUP+8ct+XJB3AvFQJq7/sC/haSZ3XkSJDZqpKg2qN+8CYnvw+PQYj+y68MRpX817Iv9NsSmSZv1WFTsZZBcl+8m4+LQ/Qmmg7I85P5tmR+GGOXTJHjSC2bH1x3wpFWk7UD2p+3q4cicLxgXXhk4PmDSP+7SBb7KPbfm5xPlXqWhw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q0NJWcluHKLfkBAG1GOoAt4Bm60DNkoeV0zUG1PPYpEpYbSZIsSu7DIw1MgTEUwxBQMEbwIdEKfps2bRXWXrfEwxqNaZy9FVVkMD8vNIKXRy3PtLD7/Lw6q5uSje2iaWondrqvOp9NAaoh+dQ6th/B+0w6nTeHFMs+7vZIaBk4RLCaAfwVk0w5TSLrhoHjVQepv71z+5dtk+zEhCSZviFmDD/zqc03l6Leiu7eW6K8j9MUOaTvRKlNU/DKq8lwLy/8tQX51NhVlWQJDxhPD6DlKetw51JYyXT7WT33VIjRVbD9tkTTjwVj67K85U/cHSEeVumCtD+J1OQcATKISzl7KeJ0mP1YSvfFNT/619OpkwkMJKjMKwjqsA1LGdIzf6eGDeUpbdie7VXDKeSgoO2di8NgoErSzIdd3nADp0v7TgYKNM64NdePToADJBBQfN9XrKGsD3bL/wT8nuTQmhg70RH8sIPpKbJpxEI+RIrGR1EX3TqM70g10Fmw7oXCmkbqpJCajhZLPVTkYq/sMAQO+3/PsLYH6c5xcuPwnIAuP9hnDYGoqxwpEYzSgKx5phkcd2m9p5Wf68Xzmcl86hDrQ2hBA+fzPfCneZ9VH7gs/YGmg5eih/KSSm5TclATwmpDrOx2xxBPnUOxSR1REyjg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9845182f-6ba5-4231-540e-08dea6095bd8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 16:07:06.0581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xR7SYxEoCUm/zjY0F2U7GgTT6GRV0kLh3c9RQ+yBVd+xxKUJ54IUasJHxZEcR5bioRLlQQkZeFqbjsrkYfJjVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4565
X-OriginatorOrg: ddn.com
X-BESS-ID: 1777480839-110915-15598-5414-1
X-BESS-VER: 2019.1_20260409.1619
X-BESS-Apparent-Source-IP: 52.101.57.111
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViaGFmZAVgZQMDXZ3DzZOCXNPN
	XSItUoNc0szcTSwDIt1TQ1xdAgLclAqTYWAL5+Z+tBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272903 [from 
	cloudscan9-110.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 4/29/26 17:03, Joanne Koong wrote:
> On Mon, Apr 13, 2026 at 10:41 AM Bernd Schubert via B4 Relay
> <devnull+bernd.bsbernd.com@kernel.org> wrote:
>>
>> From: Bernd Schubert <bschubert@ddn.com>
>>
>> This is to further improve performance.
>>
>> fio --directory=/tmp/dest --name=iops.\$jobnum --rw=randread \
>> --bs=4k --size=1G --numjobs=1 --iodepth=4 --time_based\
>> --runtime=30s --group_reporting --ioengine=io_uring\
>> --direct=1
>>
>> unpatched
>>    READ: bw=650MiB/s (682MB/s)
>> patched:
>>    READ: bw=995MiB/s (1043MB/s)
>>
>> with --iodepth=8
>>
>> unpatched
>>    READ: bw=641MiB/s (672MB/s)
>> patched
>>    READ: bw=966MiB/s (1012MB/s)
>>
>> Reason is that with --iodepth=x (x > 1) fio submits multiple async
>> requests and a single queue might become CPU limited. I.e. spreading
>> the load helps.
>> ---
>>  fs/fuse/dev_uring.c | 30 ++++++++++++++++++++++++++++--
>>  1 file changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index ed061e239b8ed70ff36deb51dd6957fe1704ec87..e06d45b161d5000e24431314b2222b66bdea58aa 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -19,6 +19,7 @@ MODULE_PARM_DESC(enable_uring,
>>
>>  #define FUSE_URING_IOV_SEGS 2 /* header and payload */
>>
>> +#define FUSE_URING_Q_THRESHOLD 2
>>
>>  bool fuse_uring_enabled(void)
>>  {
>> @@ -1310,9 +1311,10 @@ static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring,
>>                                                        bool background)
>>  {
>>         unsigned int qid;
>> -       int node;
>> +       int node, retries = 0;
>>         unsigned int nr_queues;
>>         unsigned int cpu = task_cpu(current);
>> +       struct fuse_ring_queue *queue, *primary_queue = NULL;
>>
>>         /*
>>          *  Background requests result in better performance on a different
>> @@ -1321,6 +1323,7 @@ static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring,
>>         if (background)
>>                 cpu++;
>>
>> +retry:
>>         cpu = cpu % ring->max_nr_queues;
>>
>>         /* numa local registered queue bitmap */
>> @@ -1336,12 +1339,35 @@ static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring,
>>                 qid = ring->numa_q_map[node].cpu_to_qid[cpu];
>>                 if (WARN_ON_ONCE(qid >= ring->max_nr_queues))
>>                         return NULL;
>> -               return READ_ONCE(ring->queues[qid]);
>> +               queue = READ_ONCE(ring->queues[qid]);
>> +
>> +               /* Might happen on teardown */
>> +               if (unlikely(!queue))
>> +                       return NULL;
>> +
>> +               if (queue->nr_reqs < FUSE_URING_Q_THRESHOLD)
> 
> Should this use READ_ONCE(queue->nr_reqs) since nr_reqs may be
> concurrently modified under the queue lock by other CPUs while we're
> reading it locklessly here?

Definitely makes sense, hopefully it will not disturb a hot path.

> 
>> +                       return queue;
>> +
>> +               /* Retries help for load balancing */
>> +               if (retries < FUSE_URING_Q_THRESHOLD) {
>> +                       if (!retries)
>> +                               primary_queue = queue;
>> +
>> +                       /* Increase cpu, assuming it will map to a differet qid*/
>> +                       cpu++;
> 
> Here too I think cpu++ can break numa locality. In the reduced-queue
> setup, I think cpu++ may have a solid chance at mapping back to the
> same qid.

It needs the same quirk - read node on function entry.

> 
> If we use the ring->numa_q_map[node].registered_q_mask and the
> cpumask_next_wrap() helper to find the next qid in the numa node, i
> think that will guarantee numa locality, a different qid, avoids
> having to redo the whole cpu_to_node() + nr_queues lookup on each
> retry, and will detect automatically when all queues on the node have
> been tried.
> 
> If you dont have the bandwidth to consider this change for v5, I can
> send a followup patch for it.

I should have the time on Friday, and hopefully I find a bit time to
look into the way how blk-mqueue does it before next week.


Thanks,
Bernd
