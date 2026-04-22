Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023074.outbound.protection.outlook.com [52.101.72.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7211A6815
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 04:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776833182; cv=fail; b=LfwQcqWWfkZE41oPLSOH9bbUTj0jrZ4EYKPCn+MvyB+hcZ+4JvBWfMNazmJ/knAXFtOszMCsQlbWxY9tXpvTjt2lFF3I31dQ9uQFG+2yq0DnArUDFTfLtge7oiWUS9vv9bGjehxoMvVqT0SghXlayv2161upl0wummg9QKr/cKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776833182; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=Q0r165JcVSHdP7PmrROrNgbTQg2UlTyqVxrkaJjmjzXOXLU0bQGBFPy/Z8dSv9TTiESHZxOCtv4D3n4WOR6F4ILYpO94HIkP5lFeZvDiHxBWFBGwoFFuSFxPi/Ni0FOYvqV9LdfWKyV7CB6gXKDHkAYpFDKKk1Dd0NZahWx3EZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com; spf=pass smtp.mailfrom=tuxera.com; dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b=BB33DfBK; arc=fail smtp.client-ip=52.101.72.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b="BB33DfBK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0O9QVeRVK7fn7ucxVyi3Dbhe1ViVvnYQ7fwlSCA2H/1N+cjmhTjxHPZSbm6KVOqNI7sEkxCY7RnoJ8MXJlgqTJtmPvs94Kx0C4JoFAUAoIHw97n//SYLfmgqkj0xv2+BllcTt2WIQKDVWgy4YoPNq0+QosH1HkiZA67ZUrXaw88h7qlCbJ70ztHp43LsAHsV77/RpwdCBGKGAatah4utd4tnugJZTXBiMJ6mykhso2hOSdgIjeyvYPxGqBKpIoT4Yjj0GNK7CH6YZMPnpylVtIFDYK85xH5UXUJX6xzEjSjj0vhYum4CruDTsCZO9qedaVfYJCzw3/Ryw9kxk87sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=XYP8yR4anMcU5JB3aVb31qvDzIFMci0DD1VYGUbGqA9kWPQZ9IjjKR2CJGAFXxc9ehuizKWTUvU2FAwcl9kkFLO6AEQ4ta63wdMbiIi0cHWdDOtYIuWSsBsR7HV9Fr16bwYdrhCeyWF/kbtyEZOlOyFE280LCBM+3HW8GCkXqrRwKP0605u62xm/JPdq4fojHWc0Qa7JSl7cVPIX0aIXXHDX4ipgMS9nQHKXmTWL3dBRSUDj6yKadgz2+OveCUIYYk17KfLfzl1RhQiduju5MRuuyYhBhM42pZVpAlVKDc9vjs7DBRQNBf51ltuzczF7vAtMdjW+koaGOR7qlv7UHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 b=BB33DfBKA8OVgAqn5QpgWcEqPEPm0Q3DHwAB/8qx+DIPAe9y5nywPlkkIbORHDWhDIvSWS6Z+gdrlaQKOyij9Czl6N53O38Q4tyWuQUCDlbRWpZTEzaYAQOitvkLvZ+pM9lW0xKN6hbz4GOT8av4Y4cOrAquT0I/XTGtqgqwxSWrGmCOLOoutYZzEqWLi/ffOJyHrWRMsls9UuBT7geRxSmixacrDFL8yakOtudwDK69kny59Mq2o4baL2S/ARGnUfdjJcjFy51s0coj6CT42KS5TG9IjQAp2dNn8jynxJSVTFFIgsmISveaf5D9VjnTrASXHl8NuMXopb+36qlWrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
Received: from AM8PR06MB7108.eurprd06.prod.outlook.com (2603:10a6:20b:1d0::10)
 by PA2PR06MB9553.eurprd06.prod.outlook.com (2603:10a6:102:416::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.17; Wed, 22 Apr
 2026 04:46:18 +0000
Received: from AM8PR06MB7108.eurprd06.prod.outlook.com
 ([fe80::a59c:f3ac:4097:9c5e]) by AM8PR06MB7108.eurprd06.prod.outlook.com
 ([fe80::a59c:f3ac:4097:9c5e%6]) with mapi id 15.20.9846.017; Wed, 22 Apr 2026
 04:46:18 +0000
Message-ID: <08c13c26-30a2-4497-a8c2-6f5420dbb649@tuxera.com>
Date: Wed, 22 Apr 2026 07:46:17 +0300
User-Agent: Mozilla Thunderbird
To: linux-fsdevel@vger.kernel.org
Content-Language: en-GB
From: Erik Larsson <erik@tuxera.com>
Subject: subscribe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF0005F693.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::13c) To AM8PR06MB7108.eurprd06.prod.outlook.com
 (2603:10a6:20b:1d0::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR06MB7108:EE_|PA2PR06MB9553:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6be2c7-39c0-4bb3-5d9d-08dea02a17e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XcOQKHZl63drN6Cw1boyEWFEMeMao/goPlVWoTYrYAet2ZXdpSm2im6ddykND6yujT5ykf38chriFE1kgtandrzWSTWniCoJJqmDUvv4vrbr0WQpLxtF7do+V0+u75ZcAhRf/p7h7dQDlsG5fKSO8LnCuON8PIaQqvT92CNrfjqVqm7cDiuVs8Q8PTNzSQp708IS2Sh4ujQbpJKVXWE+PcgSE4k8XD9KytX3s2odbN5YL4DUMc4Evl7BOI6gky5n7SrCtTh2OhMLvrsgDYXZedbBn/EnsIYUyeFNj5cZCsmyPKphECNGI9GcHLk8Mz19Ytl+7UCMZlYyDag4C6XTIrROCXZebR11SyZ3R65S9Db5pl+N6jhvPcj1bqvwWtZ10Ea4+n6hrXRQSEvdOTgu1aKqZFeiVl03MGBkswqKk3q/x5yCfpBk8hkxQGD28Oiq5RyMhyHaxPO0BV6Qd9mXF8x/sKYYIf3eUbpyEt0H7X4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7108.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1RiNDNWaHdOcnBHakhRMkMvWGZGM3R4Q09tSm1BS1hySERRTWxtSmk4anJL?=
 =?utf-8?B?V0VHUlZ2S1A3YlBxZTRZZGJRSnRDZGRaZzRXT0lxTGhUSUVWN3FldUErekk1?=
 =?utf-8?B?Q0tPWVhRbVcweG9jV1c2SW9sRE5NR3VvWnliczVRT2VtMnNyQ3dtTVBtNWQ1?=
 =?utf-8?B?KzlCUi9NbEVMYmE1cWF2amx4RDlPQ0NQV0hHbVFkSEhreWlIbE96VkhTSUpU?=
 =?utf-8?B?b3ZmUU5LUWFObnNaQzM0L05TTEZldXB3enZPTW5VWFVnMHIvMkhycU9sSS9T?=
 =?utf-8?B?dy84ZklJampGK1pGaTdZTjBLY2Z6bVoxcE1xWEl4RUp0bXdXWDROSXZENTdt?=
 =?utf-8?B?TG9jYVlwdVFRWWIwWDFKVlovUDhSZG5aUjZoUFk2QldWdVBzZXoyaGNJbzZC?=
 =?utf-8?B?TGVyc1dHbzYrMFVmQStZNXNSMVNMNENpOFJBUDdORFVlNGJNb0UydDhUbWVI?=
 =?utf-8?B?SjhMR0dqcFUwcklia1gycVVRZGRqMmFsSHFiRkg5dG1hK043b1JtbnlEYTU0?=
 =?utf-8?B?R2Z2U2U1MjN0cEZLeE5xWkk4OHg4ZEVGa2ZxUStSZFVvRlVoZnorb0RjMUJV?=
 =?utf-8?B?UFQ0cW5RckU0OHorTkhJenRGeGp6VUFXTUsycjBPU3F3amRHRTFDRzJQM0li?=
 =?utf-8?B?WFE0N0ZUdVFyOXN5dEpyK2pSc3ZjdDNmcGEvU0ZmWDd4TEZOc0gyeUhKbVZv?=
 =?utf-8?B?a0JXaDFuU2R3alN4aDM2cWxQdzRyYm8yMW1ybWQ1RHZrKzBLY3ZGVFdJclBN?=
 =?utf-8?B?aERFUUpxRnl2c0tMS3l6MElHL1k0TjAwNFVITHRsZ2NxbFNLdmF4WDU4bDRC?=
 =?utf-8?B?R2FxZ0NBTUUxSUlGd2FDZDEzL29BdzI1S0NmYmhJcHd5bldEL2FBSE1TMVpu?=
 =?utf-8?B?Y2Z1NlM0Z2tpVTE4SWNNQ3hHblVWRWlJa1VZd0RxUExmTmNnQUV5TTJxNUVq?=
 =?utf-8?B?Nko1UzFkQm1IeFBrc1pieTkrZ08zQkhuaE1xMTg0Z3NDRFFiWXlDNGRnOFlP?=
 =?utf-8?B?ZlF0bVF5YWYwcE56eUZTSjdvclp6Y0JISTB5TER6SzY4RDVaUy9PbEJXYWdn?=
 =?utf-8?B?Tmk0QUZIYlV1aXoyRlJDNVF1QWtqZ25CMGhEOFdIbGtDUmt2aTBZYmh2RGFx?=
 =?utf-8?B?ZnpoN3BuSTBnMUtaT29zOTF5eHcyQm1Xbk82c1ZkL2lXT2dZckxsdzBHamM2?=
 =?utf-8?B?UVBYdHMzZHhGYU5BdVI3Z1AvVUkrUzBDdmg5b29sc3A1N1d5UXVCYnRtRm9w?=
 =?utf-8?B?RDFyV0hVeW5seUxqRzdRQnpMdGQ3WnEwcXB4aXNiMkduQytUMHpTZ1ZhZnM2?=
 =?utf-8?B?NzZBcmtNdFJiV2xJY0JzdEVaellMZXlUTjYvNEtvNStneFhJNkJXbEpWUENN?=
 =?utf-8?B?NmxXZ3lqTElHWWRJbmg2UDNxa3Zic0pYaWI2elR6b2RiQ3hKZ0FnRzM4REts?=
 =?utf-8?B?NVNZRzdINzB3MnRncXZRR3dpMXQ3NC9LYndsUEViclg4SFpYbnVxcUdCc1VN?=
 =?utf-8?B?RlpRYzRhbWZXVWZOM2N0WmxBdUd5RlRnZm5mTi9GVDdRN2VKQnhXR1QwOUFp?=
 =?utf-8?B?Mm10YVhCWHY2Y0tpWDQ5ZkFYU3hoMUttblRNQlB2ekV3ZDExMGVVc3FSbndZ?=
 =?utf-8?B?TjdBbHd3V3dpRVI1TjVhMVhuZ2FKQXRER3pSRTkrSEUvWFU5R1NSU1NlQ3Z0?=
 =?utf-8?B?NWZyenJUTndhYWZPT1B5ZWtZbDkwVXBVQmZzajh6SHhhMnloek1IOTZsWDF1?=
 =?utf-8?B?eHExUzg5SlpWajFLb2pkWmpPbTNxdTFyRU5SMmNvenI3VjBHdDNVWDFMSlhj?=
 =?utf-8?B?ODVvVTU3VHF2amdMQVBiVUF2Tm5RVnNvVS9Rbng2K2J2Um4wbjQyQ0F1ck4v?=
 =?utf-8?B?S3IxQUV2OWZqQjhhQ1ozc3ArY0NPWkwrVjJkVmdQNHFRZ2JoUjdLYStEMW1J?=
 =?utf-8?B?bG5xTHlJOVVURTlqUGp4dkg0KzluVEsvNlRmQVkxQVRqR05pSnpMa05BdGQv?=
 =?utf-8?B?R3hMVVQzTWFrVWM4eFRXUVN0U2QvMTJOdWh0MU9Gd1MzVERONVVSRWJIZ3hZ?=
 =?utf-8?B?b29oV1NIT0laVlAzK1lLUTF4NjZ2MHk2cDdBWURJdFNhc0p6TDBodXhYMms5?=
 =?utf-8?B?TThjRklWYWN5VXl5TUFKd0Yyc3FwTkU1amNYUnhHN1RkSGQ1Q3VYeGk5R2V0?=
 =?utf-8?B?WG9ScGNKMnp4cThvdmxiNU9SMW1LazZjL0dNSnhtUERGK2pNNzkveE1zalM2?=
 =?utf-8?B?R3YxN0JqdTdxU1BFNmhIZjRSNFNqQTN3ckJVUDYvVUdzeSt4UHZteUU4T0pL?=
 =?utf-8?Q?UiNYkpIYYgq9XhmrmZ?=
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6be2c7-39c0-4bb3-5d9d-08dea02a17e3
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7108.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 04:46:18.3887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3zbRfM63jqf8y1rXWvyD1Q/ssI3W7y4hnX1Zic/IHwdGrBPf7TLtE+fkA5pVXn1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR06MB9553


