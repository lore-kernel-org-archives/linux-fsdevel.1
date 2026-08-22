Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42366267B89;
	Sat, 22 Aug 2026 12:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787401693; cv=fail; b=S4EuOCHrt3IaQlKeiy138bBPjM/24jOs2/yTwMMlWuF7io50JaqhGakbISAs/o0SoVmeE2F8PqfcpxCl7rdvJ9unsSG140tgL9h8QjEA05ifwxezCzOZ4Ka8fwSTluC5muG4LqXSfIoee9jlDjBzQwnAky5MvkPSlbuFJUZLBSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787401693; c=relaxed/simple;
	bh=nxQtO7D4Sz+NbZPPY0eaOLZZD6ah5GGr5IVFCTlN40M=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=Bg7MHswka7fci7q9FlF73pWyWVT4OYogX7WKTwLaMFwCp7NA6xBm+xq/vMLUS7Gpps6jughCvjAAPKQtvPGRtyNbdQdb+9C/hJhbCu/aSq0WEgc+mSZu++2o9tbrh/qXGuIDLjOtR8oNoS3UfKkiRKq+6gtDZn5TJ5qfyABgbmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ARu+gKM9; arc=fail smtp.client-ip=52.101.53.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ARu+gKM9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tb+/mjRJHUZaPTaMXWSK9cUNbC9WVQHj6g1go9cwDOTp1sr3UnTC08gLFwT+z6XcshYvz+6viEvRgh2zkQ4I1RvIEryHnncfGzgEBLJqhF/dKlGvFHB2JiF8Yj62SES2/qaZZgdY/UWMF1dWWXTpJ0lTOPWWdXcbjPwWmyPGdGpfkaCqjikoFa7PFyRcpqoQruRNCy8lekjLBHXQiknV/lBOz+E2bQrgq+FImuGmx+10BaczarA96K5PisNWAJLPXCfHcfZOG+xm8fLaoGZaRIrmwQZ7046vyBy+fz9QNxaYy4dnrzMU1IL5tksy1dTTLBzzqhpBaKdzSmUqs5NpHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHK58u6WubAcaP+k9evBI8wobQCnrso9+yZAbv6f8lo=;
 b=DN4gjmUXOg7Bu2IoM+1hBY4Xe8yxTFdeGwfu/Kesx+oRS3rMeAfPzqXOefbAoAE4fdyXD/unlCjkDqq8BcYy86v/bHEw2d9HNgPyWGpbG1hWytAPQ7eix0lfV1lvTxZ5ebwZZ60m8DkR1f8Rsa5LQP1YO7kTV9nq/68Yw9ihMBxke3IbADUIVvFM+HIq8F2NGy0v8MFqHyGHPoj5hWPN5tJ6PIQ2xiaIKPy/OUKIup4Fu3ysH9tjeqcGD1gPa0qgKFN3HmKgRBDzh6bR67jefz7Erz83oxLsYSYj3KDU6Iri5OGhBR8c5/0q53gIE7sFVxRwEjZ66h+vfwdRg+TW9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHK58u6WubAcaP+k9evBI8wobQCnrso9+yZAbv6f8lo=;
 b=ARu+gKM9fiDVsSLLx+f5gqBSOayI8aY0XTUplCE4h0T2OoQTzwQQNnY85U0XJtUB9wOTF8o8/ltCk6tYCN2Fe3BtXVQeNMCTmlouMFXQ7P32bLe0nWho5cwDkxAw7Gcwi0exYBrTMjliS3wMkRNXWGvwIcL079OZnZ15gUc3NJFv58VTuw2fMyrAMjFBE2Rgj7i50WxhCfbNStvjjuR1o5txp2Zd6U4/07zqy5PH5oGH/UErxh7A8wpP0nHsjgSue+STHD+EX757rJSU4egt6f6Ds92Wlysrxt4htTtrEQTSzAbkRdZMiWagUMq+jCoK9xSz6cuPkO4K9eKsFwlMsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 12:28:09 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 12:28:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 22 Aug 2026 08:28:07 -0400
Message-Id: <DKVH0NGOIYZP.3MGUBJ9WWUTCG@nvidia.com>
Cc: "Matthew Wilcox" <willy@infradead.org>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Karl Mehltretter" <kmehltretter@gmail.com>, "Jonathan Corbet"
 <corbet@lwn.net>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 6/7] docs: xarray: Fix xas_try_split() name
X-Mailer: aerc 0.22.0
References: <20260822121651.1559-1-kmehltretter@gmail.com>
 <20260822121651.1559-7-kmehltretter@gmail.com>
In-Reply-To: <20260822121651.1559-7-kmehltretter@gmail.com>
X-ClientProxiedBy: YQBPR0101CA0333.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::26) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ac8dbf-b228-4997-99e1-08df0048d2fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vTJSRObckMRtdlZSNV57TfnDV9+LhxB6XL1DrQUhsR4mOxoIdO5f8ruUCeXtEdJAcrrVlmKu5Gr3gv3pi43ngU/ZdmTIqm99mepehEHkZsVx3BkK8oj+E+4ND+bmQ5a06SW7ksqh4FrIBgpT2urhsW4w4xe2IHB7YVjQLU3j89x/JMJTJPmfdDjYi77/E0k7vxgA48kz6D1GS7ceMDQA/cwTbpv2a7rHi8JLqH9ywWkgy6DpFQQ2NdoYphZXqyW6iJMoTSBt8bpospVGZBqbfvBsPHhgrP6X9LnFVwhJoxA2STMLadWkfKm8wTPqX+e4TiPrX2OKS62058/kr4XFIRvTqP0eMJOwzWFMt8+xsd9OOR/woJ/gb+ctmsntjdHTncOw4EvifILbYR+4haIBUk185buaH8gDL06gWXKJYa9Km1Kog6vlM12RQVK0rUPdMiAtrXmXpZmUERuFjoI5TuCNGlchghWQ92U18+sWAoT48rlkLJldZGgPnjCzciEFuPWL8MZOv21DG9IkWDEZ1OL+6yfI2pwRkK1741ayq/LJypWxqqU2G52lLfT0PDSehFXsM6ZfStmnTnif2JLg10vBjHO5s6C9hqOYD5UmsQ1hIKfRw19gGciQOFtwyfgCTNYd6CC1FMiD9ExQY+bNcx7Zdu8o4l2OC8zzdK5XA8U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUFiZDE1MVhSZEsyV2hzUTNZbnAzMTdOb1h4OXFlb0RJOXU2WWhJMGlTb20y?=
 =?utf-8?B?M096TTVhcEhZd29WVUxHbmVBRjhhcExMbmsrYnhqZ2h3emFNZmQrTE56TUNY?=
 =?utf-8?B?NEowOGN0dmZSS3o4MGtZTHFRbGdvTmt4SnRDN3p1Y0NtNmM4eVoyWVVTRTJL?=
 =?utf-8?B?aytzOFlOcGs2TWswRDlPNThjSmRJamQ3VVk4SVlyR3VIZk9DMlZMRWlzazhx?=
 =?utf-8?B?VXJub1lDRlFwNW5iM0NocjA4ODBRNkdyZGI2Zzc3UDU5ZGlQNDhPUFdZdDBP?=
 =?utf-8?B?THcwd1lTc1VBZkwyTFdYUEhVSEhmTWlqNnJFQ2IzL2Zrc1ZraEY3VDBQZ3Jh?=
 =?utf-8?B?bWxOc01vVUtWWGltMStrSXE5a1psRTk5NklKdFowUGo4ZC9yOFl3TjZtR3pU?=
 =?utf-8?B?ZVc3MHdLY3VXd3VibTdOZ1YyNHF2VHJ4K1h0dmQycGZsL3lWWmt4ZUU5c0xp?=
 =?utf-8?B?enpFYmJGZmNYMm56QXZreG52Ylp0dVZvUmpsUGl0aTVBNml5L2tNY3FzZk5Y?=
 =?utf-8?B?VEh6SjEwcHh4U2ZhLzdjdk0yZkRaSGttZ3FTUEtsYWN3Z2JWTi8wUGVBMTRm?=
 =?utf-8?B?TGczS3k1MFpmOGwvNkN1TmUvamV3M05ZTHRlc3h6TTBMT0RXVmdiMGkrazVH?=
 =?utf-8?B?M3dPQlVCLzl1RGczcU1WRGEvUVdKemRhaWgwRlp5by9admVsK2t2YnFJQzhu?=
 =?utf-8?B?c1JBUXJ2VXl0V05YWTJsSTQ2enFLYkFrV1ZpZ2h4ZDVadFF2N3VVRElNMFFD?=
 =?utf-8?B?NEJzc2FGMEtYVzZpZFZvbnFWbVdvcHNKbFhtQUdzNUJmeVlmc2xKbXVFRlFj?=
 =?utf-8?B?ZndIcjhZOVVMUkRDSWtpMjlDUnprSEE0NGJmQ0ljUGlYVENXS2c5Y1l2VTRI?=
 =?utf-8?B?a2R5SHdCQ2cxSDVxTHFBdmNHc25ObUlEckJmRlhJMzJjUkJqL1VaRWdFV0Q0?=
 =?utf-8?B?TUE0QlAzcVoyZ1czWldxQ0p5T3pBRkRhb29QcXl0Y29PL0sxd0tla25lYXda?=
 =?utf-8?B?dXR4U1VaQ1ByYkhuQVV5VnI4dUpiUWx5UUpxMnRwWTFqbUNDRk1NOElPY29D?=
 =?utf-8?B?MkpGU3dPQnZST0VNSEpmM3B4dUZabmc3ZmxSdWNNa2YyVkc4WjBuUDJCRG5E?=
 =?utf-8?B?cFFrRHV6VlJXakVUUXdGVjhSclZIREdCbVFwN2k1UndLd0tEc0hlRHU0MDZz?=
 =?utf-8?B?UmtYclN3allvQklKY2I3Z3lUQ3JIVnV5M0JjaHRnWkFaVHEwSGxQaS9vR3lD?=
 =?utf-8?B?VjFkTjlkLzcwdHVUaDRnWXRSRkFxZnYyVW5nUUtpb3NzNXdSSVMwczNwRjdi?=
 =?utf-8?B?VUd2QzB3eDZ0MXRndlRUWDZka0F5eUQzY0JpMHFZM2hhUko4a0dGVDA2bmha?=
 =?utf-8?B?ckxKWnMzM09Ua1dsMy9TeVpiUExCUHVqVk1DUTdWSTFJTUpQVUZkQjFtSHNC?=
 =?utf-8?B?MFlGTll1NU4yVzlpQWJUQ2kwMUZYTldLdDRpWm8yMC9vYXBkM3J4RVZ6VVpt?=
 =?utf-8?B?VlA0eWgzQitjNHdmL2w3VitQRy9IR04rMWJKcVVQTDcxTlJNMXZkTEJtWXhi?=
 =?utf-8?B?U2tUYmFQREhEMG14VVpYT2c0T3EzeVg2VzMvYmRySWFGUncvWlJ4aHU2QlVO?=
 =?utf-8?B?L1ZCRmpheFdvZENMYUxSbmFGNTlWbUo3ZC9FRjR5RWYvalFOSVQ1N2xjTkxX?=
 =?utf-8?B?RFZCRUo3Z3JES1hKL3JZV2RCYWtNbndsSEFQdENUUDJ0aStpZkZrRWVCTkJq?=
 =?utf-8?B?a2tOU3FETmdibjRVN3lHU1EvMnl2bHRvL1poeFJIY0NweDA5SHZsL3oydG9h?=
 =?utf-8?B?M1N3UWl2YUVoQVVlTU1ZNnRTWG9ob1dVVlRYVzVZeXl4Tm1QK0dyVnhGUFAv?=
 =?utf-8?B?RVpiRDRMWWFhZ1VXLy9iQmVoTXBUUlNXdTk4U2Vkd2sxMmVGK3YzUFlkOUlT?=
 =?utf-8?B?M1BGc3dYaEN6cFlicVFJLzNwNHZlWjhnTTA1OW9XU0p2OCtTcWR6eXBWMVdo?=
 =?utf-8?B?eEI3OWREYWVxdGsyZ3BESCtLNGZQSFplVXZqbFRscUZFRkdvZlQ0ZFQrby9i?=
 =?utf-8?B?WGVva2NOU05sUHpEeHZrOWJ6aGFib3VMK2JxeWVmWWdXVjQ0VzlzOUx5UDcy?=
 =?utf-8?B?M1pSRGZ2Q3NoUHBjZFYyeDlkeW5Ed00yRlVWKzFKbnR3N2UxNzNVUWp0S0g4?=
 =?utf-8?B?Z1I0aC9rT2NVaEROTytPdHR3ZDhVUnhOUjB4TEQ4alVMTkc1RmNZbkJ1UmFO?=
 =?utf-8?B?V1RSamo1MnBKWWZ6cHgvTHViS1FESU1SRjhBK2RvMURjWXdIOVVIQlBUUFZX?=
 =?utf-8?Q?ONJyXnQre2UQCdBYuQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ac8dbf-b228-4997-99e1-08df0048d2fa
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 12:28:08.8220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/pC7fqoV2eCidLZMKsWhwWiutFlqMcnoebRTgWvLYN6D0GqDFmGaUoO9JxmCnfR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168

On Sat Aug 22, 2026 at 8:16 AM EDT, Karl Mehltretter wrote:
> The iterative split helper is xas_try_split(), not
> xas_try_alloc().
>
> Fixes: 3fec86f8aa8c ("xarray: add xas_try_split() to split a multi-index =
entry")
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  Documentation/core-api/xarray.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>

>
> diff --git a/Documentation/core-api/xarray.rst b/Documentation/core-api/x=
array.rst
> index c6c91cbd0c3ce..3d2b20c05a937 100644
> --- a/Documentation/core-api/xarray.rst
> +++ b/Documentation/core-api/xarray.rst
> @@ -490,7 +490,7 @@ entry at every index to ``NULL`` and dissolve the tie=
.  A multi-index
>  entry can be split into entries occupying smaller ranges by calling
>  xas_split_alloc() without the xa_lock held, followed by taking the lock
>  and calling xas_split() or calling xas_try_split() with xa_lock. The
> -difference between xas_split_alloc()+xas_split() and xas_try_alloc() is
> +difference between xas_split_alloc()+xas_split() and xas_try_split() is
>  that xas_split_alloc() + xas_split() split the entry from the original
>  order to the new order in one shot uniformly, whereas xas_try_split()
>  iteratively splits the entry containing the index non-uniformly.




--=20
Best Regards,
Yan, Zi

