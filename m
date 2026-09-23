Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021132.outbound.protection.outlook.com [52.101.65.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747903AC0DD
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 15:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176171; cv=fail; b=kUADN3Rml7EBK81B8MHgWsjTu99jsV3qi5ZN7c7RmpEDXHntBv/lOLNWe2tAIOFqJYkpFC2nVzbgmiA9RMLFfyubUTlGJA4SExGcgoITqipday7/TLyJIkQaPDZVr6th03bIk5nHF88mpSRlLDmi8YGiwRVk9hDbHLh+sSyaloY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176171; c=relaxed/simple;
	bh=7nz3XBClDZv76qqsj/D81n1Rsw2wSlXlhHl/DbPxtSI=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=uHAraEMd9mGVX8uvuTMEilmK1uvsjPVwCqXMFv5qAEljlgZLPdJYrm7XObskl9WI9spLvt+nO96XDEAjW0o4GkRzFLME6pvf62qx3cdMiELZwUmYJO5GzbTKZYa/cbuzg3BnJT3TEDn0RYH5a2QmGolqQbfdxlrVX/X0LAVGWp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com; spf=pass smtp.mailfrom=tuxera.com; dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b=RP6PNTv+; arc=fail smtp.client-ip=52.101.65.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b="RP6PNTv+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+IfDEUvYbpDC7fVe61EMdmC/iYIlej7glPInHFgbUIFKAs7ca1jQ//b0RjoBdcMaKvS4HQBT5Jjsc6pke5YLOb5L8bsTgNtGZlEclLDne7yMmQ8PZAYI9fN+gH4PT/xXXoRCmLl80TDbFUyEJzwFV2EcluF9Wf9S7TBxySwWlA6Bl19s5hjDSV9fu6sXXTYUdHoKXKBNsZiya8X+46BNXp605tSOnb5hIKARPPkgvmmn+jJASzg958fMR4A3A2dnF+f4uTLyrZehCpEzgOY4NDamLsGDMLf4xs6G67NNSN/p1TxThGEPEnZG0+iJpgf0dUPnyIcg5kMuxdQU0KYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yUwHDacAhVz2pTKqfndfZoUva+OQNe6wvo6C+3Pq5k=;
 b=UPZykJu53JufpwgANY0ivfKlkXdAd5zz/ps0UWcvKT7pfn4xKKoO5iZ1jkdOFEaE9kI7jwCKwe65ebeXOZpHKCys43DxquXrSgBF4cB9oeHgSvEnNwdzRfyJVNFKX2/SfCj8l4L6ryvZ5eGLJL4I3DQzBYLWH9vGLCKF2qgAs1K+/vvIRncAqxDLGJx+FpXC4+aaFXD+7T72++xXlYATdMLBMiwhKxexonAIBIojyYTedMjO0ryTnirRgRp7z1PvnXZccSYY2wMGAYKS8+ZhgoalG8ZUxIcfyIIdvISxCl/Aa1c6+2GeVziDsEIJOU79alXIm1QQrXkXiyEwoJUo6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0yUwHDacAhVz2pTKqfndfZoUva+OQNe6wvo6C+3Pq5k=;
 b=RP6PNTv+JeJb8cgPyzm3e/bt/iBJf93MouDv8X6UUGb2JffGth3y/h01v/NlLoly1BFrb6fcjPY0KHelJwUOmMVOF9hwWXi+XS8UgehbqZGwR1e+P7FGVNjoqfzbdWdLGNfHI3x8f0EkLaDO76dqOEBtG1d/s7U/WPgRXuZCWcEKpOBVZjvD0v/4IquJAZ2HW3sflRv0e7OlWOPb916PGWw+17fx69LTMbzc7k2kTLqrlTu+63aILHsWMZZv2Lb7N6zL5Y8bOLO4OgjfU5UFXf6Q3+qZ+9N6rJmhHv+gh1Q29DjxpE36zaJh1k03+PPgNxjJsZDIi7hpEcU3vv5oCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
Received: from MI7PR06MB643805.eurprd06.prod.outlook.com
 (2603:10a6:290:103::6) by DU4PR06MB10573.eurprd06.prod.outlook.com
 (2603:10a6:10:640::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 15:09:28 +0000
Received: from MI7PR06MB643805.eurprd06.prod.outlook.com
 ([fe80::c71b:903f:aa3:f0b4]) by MI7PR06MB643805.eurprd06.prod.outlook.com
 ([fe80::c71b:903f:aa3:f0b4%3]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 15:09:28 +0000
Message-ID: <948018b4-63d2-4127-b20a-5c8d81408093@tuxera.com>
Date: Wed, 23 Sep 2026 18:09:26 +0300
User-Agent: Mozilla Thunderbird
From: Erik Larsson <erik@tuxera.com>
Subject: Security version NTFS-3G + NTFSPROGS 2026.9.18 Released
To: linux-fsdevel@vger.kernel.org, ntfs-3g-devel@lists.sourceforge.net,
 ntfs-3g-news@lists.sourceforge.net
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0087.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::10) To MI7PR06MB643805.eurprd06.prod.outlook.com
 (2603:10a6:290:103::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI7PR06MB643805:EE_|DU4PR06MB10573:EE_
X-MS-Office365-Filtering-Correlation-Id: 954a4cb4-d00c-446f-b66e-08df1984a960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	hAQN709kU+YC+TQxaKpfY58KjwR+Yhos+CK7zdqMmOSimVU4f7XPBD5e5Tolass12w4PkzmEtiT+OI7HJP7C6WQFo/IlwhoHrk7nIWyPtGjhLdFRWmb09T49kdQLK0wn5Vh3hGpjHX//Bn6xiYQmyQBHfureolCi0OmqqGOk+1m4+xsGvKRPhSsIXxF8kSzaZ0Iq6rsu0t7ejGD8TfdZ5vDLwI8XubV9F9cHth0dh248H4iGRsre2IoxESI6vD/SsSt3CPsbTJekPVaE7EJMJfoyLFfiz7aKMYnUQ2Qvnhk/jVO+6Yl4dJ4vMsfMFEjBlclxyQx6L0do1/tCPA/Bp3UyPLEHMmRwxikYd52XvX3QvMUoDUXVIUnKx+iTWN8YK6wODSSkKnnuWw2dOPvuLmGaHkPe9r3tdgbqxsEthUYV5SukVu32iPXd6tlpErectYmOWaBXQPbHjZ4Y/1HlbaxnypglMX5TmPAo0SGtJYwhckGmY5IYK0iHfjUyYMRvZdUSygPYtDQX9B67l5cgiAP3Y1UDOJmJkmM0eBAOx+6n8dSgGQAY0EKzvW0CPOq8o1QelLZILv8RijFWCvkJ1/8L9k+ar0V6UngmxVREd2ljR984qYskbmKDW+InwBGU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI7PR06MB643805.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2UwWCtsaW0wZjh6cWd3UXp6MWt5dFNiVTVSSTFhUWVJS2dRMk5ydGQyclF4?=
 =?utf-8?B?TjBoZWVuUTIyc0RKVVZma3Zidkd6RzgrMkdWdUpQRmFZQlY4U2RkczZQbHp5?=
 =?utf-8?B?UFdpakY0SXI3WFRmUzRpUkFBaU04bDNpMXBwc0hRN25SQWNtRlFrUloydzNX?=
 =?utf-8?B?VkNhRUxKcGpNVUJkdlFCM1VNV1RoSnBKSTcrN1piTlBHZTBUd1AxSFR1SEdD?=
 =?utf-8?B?bXRCZG91OHk4YXkwdUY3Z2U4QTh3M3hsd2xESVQ3WlptSXljcXQyUWF4WUxC?=
 =?utf-8?B?cUYybDA4c0h1TUp1ZGgwVTZuYkhORUI2NGYvMC90Y3UvRkJtanYrbnFTV2ZK?=
 =?utf-8?B?cmY5aG54b3JmckptRGpldXJ0T092ZGFmN09wUU1mdDcydEhVOW1iZ280anMv?=
 =?utf-8?B?UnI5azI1MFJjOVJIZ0lYUlh4dk1ZRGczTG9TOXJNMytoQ09IQmUrdlMyYlda?=
 =?utf-8?B?WjNwdHdYdExWOVhCMlV1OFB2YjB4NHdYVHVpT2VzeitzYzRjTEwxNHhIeG9O?=
 =?utf-8?B?Q0NsVDZmMHZsZkc1ajZ2L3UxSGowcEFSbUdscFlFSzBpSUsxRFAzVGJCVXdv?=
 =?utf-8?B?Z0tPNVBVTEdyVWdmM2ZMbUFVYTZka3dFWkdOV2grNmx6bDY5OFUrZWZ3bGRn?=
 =?utf-8?B?KzZRb29uNkRoc0Y4MjZRbHpvbTluMVh5Qi9yZDJtVTg3Z1I3emkvc1BWdmpQ?=
 =?utf-8?B?eVpiaUlIeXF6am81NDUxUTdQZzE0RDJaY0JuZWdIbk5BK0hLaG1oRUFMek1P?=
 =?utf-8?B?VGg5V3J3MUtpUVlhNVdmQ2RWcTVBWHFzUHpYQ0djbDFyd3FTZFZyVThYUTRy?=
 =?utf-8?B?eDZLYnRGKzI5MWEyb0ZETU9ORmxaNGZwb29xM1JjMXJQVy9HUHZRS1RRYmJH?=
 =?utf-8?B?WFR2ZFdsaFdRaUpUQmtoWU56c25rSGRIMmkxcGRWMkVWeWpscm45SmZoWkVS?=
 =?utf-8?B?akk3T0tLYklmMWhLdlJ1TWRlZGdsaEZyUERFdmhsQ1pINk9KcXBldXFDK1Ju?=
 =?utf-8?B?OEdUNVFjdjhVV1B0eWdMMXcvSGZvcUFvZktUOXN5YlVvWnAyVHVwdWI2MWJ4?=
 =?utf-8?B?a2ZJT0l3N3dTS0JVS29ueTFnTjVsYWV3NEt5cGFpWFdSZmlZbDJGR015Tncr?=
 =?utf-8?B?NG1maGJkWm1Dc3ZZVGpyL21lU3drQVFNN20vaXI4Z3ZORkk1c3FpZ1F0aWdQ?=
 =?utf-8?B?TXZnQWNJQVVvMlRZT08rTU1MRVNKcGFIV0JZc0JyMjlJRy9XU2V4V0lSVmhL?=
 =?utf-8?B?YnUxekgrVkJ0Z0pGVDZ0L3VWemlQY1VJaGFURzZadHF4dXhpN2RFTFdmOEx3?=
 =?utf-8?B?YU5VSmF1blJ3QVhsNUxIdE5MbDZjZWZVTHZmKzFkbFdiajJPL1diS1UyU3cz?=
 =?utf-8?B?OTErVHhsK3JqUjRJK3Vac1dmTGdlRlFIcGNTQ1FSaTk0MURISXVpSzBvMkRt?=
 =?utf-8?B?YUFkTjZ2NW1adUREc3NvYTNaNjFtY0JQSTRmeDgxZDNuSkZhOUxsMmJBWjI5?=
 =?utf-8?B?NGtuTDJrM21hR3NuVVdFUmVnZ0pHZVFtd2V6VTFubEgwOElnQUtGaDlNZ2tN?=
 =?utf-8?B?NEZiYVJMUW1VRFBKV2FGeE1vUjBKZ2IycXJOL213aHk0a3h2MW5hZXc4NjRN?=
 =?utf-8?B?YlV5bC9nWk9WUWI5WTMzWVdSTExyOE5rV0ErMWtXbTd4YTdEVXQzam8xdG5q?=
 =?utf-8?B?N3V5aFFNa3RRVlIwRFpZaXV2aTVSU1p4S0o5UFRFZGxONG9kU2FQbXM5dGND?=
 =?utf-8?B?U1ZvZVNQc0J0b2JaOXYwaEwwTGtVWHVjeDFPL0oySmlGbm5FMks3ZE9nL25p?=
 =?utf-8?B?SnRXL3F0WkZobjF6U2dtVEpReTJTeUVyb2FCaFFnOTMrc1dZVUJxaHFVelFH?=
 =?utf-8?B?UFZtTWgxZjJMcHlwNHpCd0pqOGViVGM3Y0N1YjB0T3crdEd4OUtOWkw3b3pp?=
 =?utf-8?B?bmZLaVh1RklJYTVxNFRrMDdWTlZoMEgwbUJ1TTVnQ0hqcElMQUR1RWkwc0Uy?=
 =?utf-8?B?MUdoNjhETkFiYVhRTXFlZDFrZit4QnFMVXMyQVlJd1VyZ1c3RmIyQkZYUzlB?=
 =?utf-8?B?UXdhNndpTUFyYTg0Z2RHUU43aW1jT0EwWDNvNks5dVFWZEVoaWFDSkxjRkJM?=
 =?utf-8?B?elBteVZLQTRoMjVZTE82NEgwSDU0KzRFdktiNCsraDlZQm9YNnJERzlXcEhE?=
 =?utf-8?B?czVnOVdPaGZyb09hN3FvR1IrMGFYYnlGUGZXcVBsZk5FNHhNSzMyYXJFNGZR?=
 =?utf-8?B?czlzWlNteXZYcVVseGc0bldQQVJCRnQ3dGMvK3BqZ0x4RXFOVVFTWXFFUEto?=
 =?utf-8?Q?2P1+hTgPupn+OqFYFF?=
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954a4cb4-d00c-446f-b66e-08df1984a960
X-MS-Exchange-CrossTenant-AuthSource: MI7PR06MB643805.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:09:27.8930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTjLKOA2mgHaN/b5WQAJ8R83Oje2di1H865xmOmRl7UNwyvilXFDASVf401AJicK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10573

Tuxera's NTFS-3G team are happy to announce that a new NTFS-3G security 
release is out, version 2026.9.18.

The new release of NTFS-3G includes important security fixes. A list of 
the fixed issues is available on the GitHub release page:

https://github.com/tuxera/ntfs-3g/releases/tag/2026.9.18

The full changelog is available at:

     https://github.com/tuxera/ntfs-3g/wiki/NTFS-3G-Release-History

The new release can be downloaded from:

     https://tuxera.com/opensource/ntfs-3g_ntfsprogs-2026.9.18.tgz
     SHA-256: 
bcf3cf301a79e42d330128ffb52d4cf615bd1d30c10a92d9d8d14f2bb4fcd9bf
     SHA-512: 
2c31e346dcfe1448ee829e4d66d27a8703304dd107cd18e1902708703f83fa2448d9d816406ef17d37157cddbb5685546455d56f432627292239e0dbf63c9dde

The source code is also available on GitHub:

     https://github.com/tuxera/ntfs-3g/tree/2026.9.18

Many thanks to Jean-Pierre André, Rakesh Pandit, Emil Thorsoe, Rostislav 
Skudnov, Eva Rio, Ashok Galla, Szabolcs Szakacsits and many Tuxerians 
for their contributions to this release.

We also want to add special thanks to Jurre van Bergen and France's 
Cybersecurity Agency (ANSSI) for reporting the security issues that were 
fixed in this release.

With best regards,

Erik & Tuxera's Open Source Team
