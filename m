Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046D44C6F02;
	Thu,  4 Jun 2026 17:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594600; cv=fail; b=Nv2hFLCML9hoCGX6NOgmBm+FG2QxZg5on3+SVj3rJWg2Ve993YZwMi6QshWhEvQ9uNWHLgGD26E/4LRBtM3eJtUIxL3+V2N4xBgi17sdVXSaSZa+2U55UIM9kaxBV2MPhxgEBmCEqUJCq86uJ9ejWfu3O0WX0Kh5fqDeRCYjc/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594600; c=relaxed/simple;
	bh=WO6EjMhwxoX7kZo5C0fdOZhgIS7AHDzISyNxKNPc5YQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YnpFesDz0LWO7ya3JLYwtlGUt2c6MvLCve3wNNFOgZxCohRXLsJs7FYpntBaqO8xjeVp/GPkH+YwsQ6paaaoH0X4le6pWxtl+YsXTgXma99ifGF8ed1UsHY6F4dEyVcptF1d/nHJCfZvdx7tFiRzPQn1sSC+xrY7j02LltrYvMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=0UbMc6AJ; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="0UbMc6AJ"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11020107.outbound.protection.outlook.com [52.101.201.107]) by mx-outbound9-64.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 04 Jun 2026 17:36:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1m1J9+jkZLVsqtHhDajWumvm5rqtCk4NlNU2TMVM6fNHx3U8xNM93GjuNLIAGa+2VfPqs37C3CsnewDYY83fq3c69nl2UvETEB2TVcyBG72gw64Dfkj7JE0TQY45xJsEkn/HG8QrOy6xr9H0iybdIw3ofHq+YgJpmJv+6/pT7CMp2YAlXpNmzjio3JE80uzZd2xSCXdNsT4i4jZMHmhGqxrdiX6ZYjbSQIw6g49by/05FOGPwKplSo7dp71Lj97NzpGe7CK+2wdKaNkBD5GA2IZraTOoRzz+277uSJmjhBQtMu+57+Tp7Kt6Mdib+Ry2lE6yPLPA7JTPLkfI7QP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iY2g1OdbsxSItmRIpCG+Av2CWTKZ2z7py+AVknAwfoA=;
 b=Lg7QdiQDdqZLH0yVkC75wYG+jAXHZQkoZMsL1loNJmgjulTPL3A2jMtAuUL6H1ScIuzmXeysJfTGlIiUu7KjjPIcddTaoIwyrgPaErzVE36TdrqfWV5BGRmo9jQL4KiuDl/lHGnZd9Eo3C7UfH+nJkE5Q4KMW0Ff/QbSnN5rNHKV5u0yKB9aqTZZXOZyerDGNqtGJzFRktTGaUSbtQlxWa7mQeBMAQjyzcNe5yZz92OD8sLYxIPh8fmnhvNdL4Gh9CPWSukikYeqXjsD3JZuKMZP0QUQ3bKwY0WP9K9VXqMPtxVOH2s1QaN+GLNU1vX9JAMKpVoolDiVkyVVHTWNQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iY2g1OdbsxSItmRIpCG+Av2CWTKZ2z7py+AVknAwfoA=;
 b=0UbMc6AJWxKB+5mTov5sBBAR2rIMcM85OEnLgjpOz2Hy4hr4koPEfGmOMaZijTr323oZXhTp2oGtD8duwvjB/s1FeYrx84rr6ASQoeFNWZ1slxlrBiQMSz6mTd18JewZQkDAYNTCuAmY/eNNiicQpQBp9bBlYjgVzJUWq+pDv2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by DS7PR19MB5880.namprd19.prod.outlook.com (2603:10b6:8:7f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Thu, 4 Jun 2026 17:36:20 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%7]) with mapi id 15.21.0071.011; Thu, 4 Jun 2026
 17:36:20 +0000
Message-ID: <d486fde6-c78d-4a78-8dbd-43b8afaa90cd@ddn.com>
Date: Thu, 4 Jun 2026 19:36:15 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: {io-uring} use request cleanup helper on commit
 setup failure
To: Joanne Koong <joannelkoong@gmail.com>,
 Shuvam Pandey <shuvampandey1@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, fuse-devel <fuse-devel@lists.linux.dev>,
 Zhenghang Xiao <kipreyyy@gmail.com>, Berkant Koc <me@berkoc.com>
References: <178059213410.15421.10567268398539539875@gmail.com>
 <CAJnrk1YH_SC9doHp60Vuajc-mzQiopPExMPQVVDtFHzB8vTM6Q@mail.gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <CAJnrk1YH_SC9doHp60Vuajc-mzQiopPExMPQVVDtFHzB8vTM6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PAZP264CA0032.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:122::19) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|DS7PR19MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: dcec7ba4-7c6a-4bca-81c6-08dec25fc968
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|19092799006|366016|376014|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	5TmEfyOsF/VF4QjhIT9OZg4kKE17ujly9QL/Olg2BWq0vSkndGO7XrCdVzOHCnTjzk+rXbrG3bdG9TA0Hgn1mHbK/KQYI9+ljv67qkaSTAknV+S+MjxEhzKGAGU3Xw+hRGjq0PERuqDpMPRGK5kWJaQodXY9TMqhsuZc4HePELHnglbOMwM8US6gK8HDs7ZF4ZeSUPFqTZf2U18pv+0PyjF3WlugOL0C0gk1YBulpXE/FFLUaMe9NCQ+cOo2mMS9KsIbfibkM5CaBn4usNJ3w7IVXnu5UgQ7U5uUQGN2Sua//PaNO2RRRce3PcqFEXv394/1pMYdKQK7ftuOB1RiSWiNcRpPIS4ll8J6Vv56kje0kEtn/txs6QH8p/JUQdIjHXI5WxJtkIGqQBjMscouJTsRFTZV0VafmEZj7G1jGEeEHQTMjmyS8nSY+EnvLNT07QOh/Ozl4QQpuv1KPcNbpAPE6gUgFRCwjbEceMUHRffv0veGPcqn/dKJ0W0wUTdwhkuiPP7Pg6DlQCAwUMAHw/rsz73f7nt3lTyxba/IjkTMRE3p0TQMJr9zbddUusSVE0+xGYb7LVvzTdsxt6BGszEbCE4jhUzlGI11Z31MxcYhn/c7S3YdH+gTsnKpbtFV/q9/6qsZKwDIGMCNgMiWUDu4f4Hac3fEEP02jQvCL+odPNReeNxqGwh7LyUaP2F+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(19092799006)(366016)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGpmNWxWcTkvWWR0Q015NVNZSERrZC9seSs0WUhaN2hvcEc3MjlBSUF5VTJp?=
 =?utf-8?B?bUJCSlk4MHJEMzFqTDJ4VEkyU3pUUGtxQTFLVDYycWYweWRYWWRzbExBZjNR?=
 =?utf-8?B?RGVTMXNhdGxTYW11UnU0d2J5dG1EeFAwMHg3NTN2Mm9WWXkyVjFEMjZuOG85?=
 =?utf-8?B?VEVoaW5iUkJtSHNRSEw5NXRhS0U3VFFnZCtRTGJBSTJhQ0QweGNyWVBPZ1Zu?=
 =?utf-8?B?RmpWcGJsTjQ4cTZUNW9ZcjJrYzhmaXU2UHBlQmNwN3pTaU9WSGZ2L20rd2dT?=
 =?utf-8?B?V1h3emF4b2ZEWktsN0F2UlF5MFQxV1JmSmI1WkJiUVl1R1JGQVdnT3UvUEJi?=
 =?utf-8?B?VnlCNTRUVEt6a3BDUVhwbGhpVHlNeFJVYlkvN3FPRDRBclpIMHNYMXByang3?=
 =?utf-8?B?ek5udENOYVlxUlVELzZzNC9reUxic2ZEbUlZaXk5bUZhNmpvamliS3pLQnY4?=
 =?utf-8?B?K3hzV054QmJxNzFWNlFwMkhJd21wODBmc2o2NXBlaWxsenpQVXQ2elpyQjR5?=
 =?utf-8?B?SDQ3Qk5rbkJLSHdSZUkvL09YWDV2WXk0TVREdHc2dCs1bE1xaHJ1OUJERURL?=
 =?utf-8?B?RDZhQmJhdVNmRTlCcGU4Y1BCempWVTNIQko0Umh6N2FCZDlUVmw0eWxPSE9s?=
 =?utf-8?B?ZUc0NHZUeDVETFowVDNnc01tSEtoaUtRZnhYdGlHUXhHU3QvV1Rnc21WbWdH?=
 =?utf-8?B?ZFE5aEpZa1UzQk1JN1FYVjlvU1hMS21qcjJCNHBVMmFseWNrUEFsb252RDhs?=
 =?utf-8?B?NnBEVDI3ZmJwU0NkY1ZkSlREWWUvNnYybzd1SytRaVVCckNvUXBDOGtxK0E4?=
 =?utf-8?B?RzVjZXJESkZTNVY5VlFMNFBFOVY3Qmh6OVZxSmtQdHFENWRuUitPMFpZcjJK?=
 =?utf-8?B?dWdKeWxBYUJ3SUI4Z1VROTVZQjh6WW41N3IxTkdjWFlSWlRjQW5qOE9CQSsr?=
 =?utf-8?B?ODUrZnhISElVRGIwdUVqQSs1YWVDQjBqcXRrWXkwb3EyL2tXZEVZQ0lzODV3?=
 =?utf-8?B?em9lcWNOZjh0TEErN210MkNMNnJtUnN0VWFPbHBMM0l6QW1ETDJZeEdmTDRr?=
 =?utf-8?B?azVCWGVncHoxRFM3NzlHWUp3M3BFZHZLREVmYVR5Um9QKzRZWVRFU0xOQ3NE?=
 =?utf-8?B?YlFKN2RwbHNCSFhsYlNLdEdNRE5EbXZWcXgybHVyNmQ5QU90Ykc4d1pZbzVy?=
 =?utf-8?B?WDRLZXFrVXVmSlRGRVJHVkxsWklRT2JFallxZk1mcUNDTnJDR0Rxc25BNk96?=
 =?utf-8?B?bGNHZDRqQmRHdi9ZZ0FjMEQzcERGdGd2a2lDeVFpckF2VktTdlRVVmpHSDNR?=
 =?utf-8?B?TXpKRG9sbzNONndtSHY5Q01FOHAzcjhLNmZNcGNDeTgzVmk3aVorcGpvV1N1?=
 =?utf-8?B?L3crMEdoOEExYkxOc2hMNUFpWjJia0U0RmdnR0RLQUV5QnowRjRXcytjZU1N?=
 =?utf-8?B?U3IwU0xzUGVaYk5wbUwveVRyZzg3OGttNW0xdzhaQmNnbHhVOTY5eXRNT3pw?=
 =?utf-8?B?emMyRHZoeTRoMHZsV0YrT3l6SkVnZjhYbUloMm12Q3lLcjE3dC9oZjRXNXhh?=
 =?utf-8?B?WFA0ZEoxWUs5cW9DSjdEVmFncjRmWENZR0tkaENGWnhQTzFmRjMzREFPKzZk?=
 =?utf-8?B?ZkFKK3BXK2NhSG5MTDVpZzZkdHJpS0hiSVBuZisrN29jTmhUWGVpa1o0UWNH?=
 =?utf-8?B?b0hDT3FjcEZnQWdEb2Z0eUhITVJOaXVYOUd6eWhmeDZNdGo4cjN5Wkw4QmY2?=
 =?utf-8?B?Z1FvKzNwM3pxVGJqZmJwbndhQkhkaE9WSi8weVpvdVVDMlIvZXVNbFE2ankx?=
 =?utf-8?B?Q0RPYkg5d0FpTVY0NytTUEVtbndob3k0L1dIbStpeEpRdU52dUo5L2wzNFBR?=
 =?utf-8?B?ZkhkeXp2NGM5TnNPSmk4ZHVQakpGV0VyTFhxYUY0TDkyUXFra3ZwVE84MGo1?=
 =?utf-8?B?T3hFVzNYdDVBOTdVajVNRUZEYzdxODIzWWU3UkRUS1h2Q1pJcWM0dlo4UVNO?=
 =?utf-8?B?c3BjSXBHa3FCSmFDK1B4SjlCNitHTkN5ZTlxZlF2UjJ3L1doZGJQUkdzd1VL?=
 =?utf-8?B?NmE1SFVGbzdhMlYvYndhT2JCN3ByRW1lOWxFWDN4Um9oUUt4Q3hTWlpnakUv?=
 =?utf-8?B?THVmWGMwMjVtbUhycFhiRHVKOEFMUUdXZmI1VlBmZGlzZjNIV2ZDOFBIYUlt?=
 =?utf-8?B?SElaRWR2Qk1yRyt0eFFraHVYaHp1ZlJyR0pTQXltaU04OUFuQVZWbTRVelk2?=
 =?utf-8?B?eFVEY1JmWnRyYTNLVStrRThuMk9rUmlzZ0QzeUtzM3J1SDViakdvQVlmS2xX?=
 =?utf-8?B?ODBBeStXOVIzVmNyUTFodW1DZlZuQ08xNlZ1NFRFM2ZQM0RWMngrM3doWTBx?=
 =?utf-8?Q?6b+qz3MPNS211i8eSb2ml49hoQy8m0MBffc3ZutLgnaa0?=
X-MS-Exchange-AntiSpam-MessageData-1: naVfLGquvG3feA==
X-Exchange-RoutingPolicyChecked:
	Fq3mNGV2Tw6AiBQApmHDVNCVKBcJ7V3Zw3Yftx6Pj55gAHB4jCW1SQEuA3tDYPq/xj13xqSXP7P+NRunx0QVRe3bhBDwT4VYYB50eyulw9OqmLKoilAiSZdSZOvWxrZf1rpxchUl5jGl2wXoc256z+lsAcMyW2HKYI1CqO8+jqQmcetVd7qGkUXPzTDeN6xD3i752yLicBB1YkWtnjRAH0nGuaaqm/00uBmyTQaqoo2x4T8JtH7Kg66juv/uAmk/tRgTYLXT5sp/4LDNgCkSeWAea1b+Wmxh/jD8YkSxrOb6joCEMsXzOa89Q2M1KeSuDeGn2q4iAeJ0EOkPQBNFbQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	blkJBQrxlvH7pDo4jakSXDYtmWBPaSp/LaE4vD3oEK+3K7c8AUF44fkBQv5aMiDag1orXiBUaywJVJAZzbaeIspkSUoGHyG/D/5qVAj6xWkmbhY3kmvjVkEPptzKNl/yngAMtG+wj8uOqP3VutFaN50zDNXlwpNvWsO97TNtQV5jDtlwLRnj/ORae/jzRsnkYWQlGvtwfH/YDoqeETrGrsLdfwUCX/u57sTcprt/6V/OwHZuTkcuvBebbLDx0jFK1IxMvZWew+EBlKm2dnV5U/MWpc908UuplXYuXN1bvVld6O+7Ok5OxUGUY/yTQ2rGmZ09k/7pURMEm2dntf/80/ZCNNGzZnc3ePT8rUoeHjG3GCbH4aH1qY/V71+Jx6gHHgCfITE9QICP5abJ+TY2BAcc4TdMVwe9w2Lb4fYqkvZ7nAYbfN/S2IGRgxcPWx2VSoibXf+HZLzL8q02XWKzwLOSfU+hWGHm6lyOKJ9+rEVfSsrZexrtNwSa5htAuWUW8tZE4THrIr4B4MeDP+vR70llv8CsKWvvwqa53Djuzd9NXJx8Io1P+0Ax2J0xadwduEUHnm8Buc2tRTA/nErDZ/Q2XDN5yKhXIzXdqUT5EbhYG9yqsRciY/GnSA0C/QGfKOBnZYAiybHLj5DuIfBx/A==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcec7ba4-7c6a-4bca-81c6-08dec25fc968
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 17:36:19.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTGw0r1Cm4ssFhATNAHvlyIST7ilGNJhuphCopm3eJG8Ri/xFO/aQou1uUIY86U+DM7l2uDkT9mXahPec6cQvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB5880
X-BESS-ID: 1780594583-102368-7726-13380-1
X-BESS-VER: 2019.1_20260519.1529
X-BESS-Apparent-Source-IP: 52.101.201.107
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaG5kZAVgZQMCUlycTSxMDEwD
	QRyLC0NDNPNTFPMjczTjWxSEo0NFGqjQUA7idmS0EAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.273685 [from 
	cloudscan14-143.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 6/4/26 19:33, Joanne Koong wrote:
> On Thu, Jun 4, 2026 at 10:09 AM Shuvam Pandey <shuvampandey1@gmail.com> wrote:
>>
>> fuse_uring_commit_fetch() removes the request from the processing
>> list and clears req->ring_entry before moving the ring entry to the
>> commit state. If fuse_ring_ent_set_commit() fails, the request is
>> currently ended directly with fuse_request_end().
>>
>> That bypasses fuse_uring_req_end(), leaving ent->fuse_req pointing at
>> the ended request. A later ring entry teardown can observe the stale
>> pointer and try to end the same request again.
>>
>> Use fuse_uring_req_end() for this error path as well. The helper clears
>> ent->fuse_req under the queue lock before ending the request, matching
>> the other io_uring request cleanup paths.
>>
>> Fixes: c090c8abae4b ("fuse: Add io-uring sqe commit and fetch support")
>> Cc: stable@vger.kernel.org # v6.14
>> Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
>> ---
>>  fs/fuse/dev_uring.c | 4 +---
>>  1 file changed, 1 insertion(+), 3 deletions(-)
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index 7b9822e88..7523569ff 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -924,9 +924,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
>>                 pr_info_ratelimited("qid=%d commit_id %llu state %d",
>>                                     queue->qid, commit_id, ent->state);
>>                 spin_unlock(&queue->lock);
>> -               req->out.h.error = err;
>> -               clear_bit(FR_SENT, &req->flags);
>> -               fuse_request_end(req);
>> +               fuse_uring_req_end(ent, req, err);
>>                 return err;
>>         }
>>
> 
> Hi Shuvam,
> 
> There was a similar fix for this submitted a few weeks ago by
> Zhenghang that was sent offlist to security@kernel.org (which I think
> was before the announcement came out to cc the public mailing lists
> when sending fixes to security@). Berkant submitted this fix offlist a
> few days after that as well. Sorry for the duplicate work.

Out of interest, did you see the entire series I had submitted?

Thanks,
Bernd
