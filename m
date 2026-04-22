Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023076.outbound.protection.outlook.com [52.101.72.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CCC35A399
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776849632; cv=fail; b=T1dkuNaRcr/sJbF5we93COBPC+ET5/kbDRIW8NCRICvdwqwaLO1MJNPIQBen3BYVuXCOmHPLHzTfhveFZ4Y0826wwHfaTmsM7JNJxiJMgpCuWILTtPcfN0suF6nss7hPwB1RjeYe1eD6UcO2bDf3lZ6/Ub+3kfofR/o86yKK8CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776849632; c=relaxed/simple;
	bh=NzTuWvMjDiGO071xkjO6sShYy3BrtX+cO4ng4sKeel4=;
	h=Message-ID:Date:From:Subject:To:Content-Type:MIME-Version; b=h2/y+CgcN295CR6cghREwUYEcbqQImx1DmJ0j3XdtfMpXxOlJOYQMyNWtNsLSPgzHMlzpz8u+NYINEeLiB6phz1+r8Te+RdUHX1B0kOdPL8TjxcZzQoF912LgOJTE0MwqYM3RMwGyHYNPaSJgvWUgbly2Yio90zUQwg3+FGIOa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com; spf=pass smtp.mailfrom=tuxera.com; dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b=DqVyK9iQ; arc=fail smtp.client-ip=52.101.72.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxera.com header.i=@tuxera.com header.b="DqVyK9iQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yans1KzMkONn3w5ammPViwQosqt8YYtHP8mFuFdoL6PZhsKMllILMLzmeStJoIhQAOT2cM0Foj8/Fdo6BSxMFXO3DuzBPbkKWZjcQVRvPyNK9ZbAWq4AO1GYzlhYWDOnl0fXQ70LC3E+GFFTKjdatXIQ94Mnw8X2fDTM/GjO0y0YC+6AvCUtq9FO5QTIJObkgofVKK+DU/6PAhaiMSr4fgDlIf9QNjdhCNvkjf5xAlVMUgYq/l+2P1qP0yf2aAMefs5ruPqaaoqcamXQs5uguW0UaBB+h0G/OeTL0InvGOifsXexBCy73lV9kblfyXlPnB3EEHDQVmT6MwpKYrATzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoMLhE7tVLSJVc2qQLYsDajG4UjRG3QglVCzoN05J64=;
 b=R6wAV4gKyDRbmeGxPJhiL3RVSuJPtoL1UcRTtaMhJGMQJi4DyzWvSTjaWu6LdXOD0Auu8OhipjKLH4fcu98rtFCjzmTHqGPFutFzFMAyb1sTBBmbvBBeeT+NyyIrqr+//MIHvk0gN+MG02rmpv2yVrfo+IlopPmeAdKdlKEPJazbspjCwcI49FLd7wnB8In7YZHk5JnRfkQ0cJtqJZgOhEOPqpisXBDW4/1Ig8U+KMOCNxf1709DmeE+fv/3kxi6rzmestRjal+sOOMJNj5DJ620AcRMV3M5C37tURKN0CHuKyClsQQWjsq9a77Pg1+X3arQBu1ouZFnttRuortd2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tuxera.com; dmarc=pass action=none header.from=tuxera.com;
 dkim=pass header.d=tuxera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoMLhE7tVLSJVc2qQLYsDajG4UjRG3QglVCzoN05J64=;
 b=DqVyK9iQVGxqMJzbtOSvEx7wzYVVbObQGw4DWpphGT9Xj0KSreLYPYs/6EqcmXNPg1IxkmC15JcBZy25gzINNDp2nxaq+unCsoTrutb3ryv7PoeKA1CpR3wHbACpO+/F4QPNtAr2qEicNgyhF4WPYnlhTXbpw7PGyb6fTi8pVJKq/SH6QLoWBXnL/CZ2TYt/BgRtslO6KKPPQ8IqXiyrCVQq3LJba5P/0V5hQL5mmZAS5Lh4J8zVDMOzLPUjSNDGZQei2VBbXX2pYyYL9z27q/dKHczMqQ+FtQJItcXenanDKog6dcZMY8zyRTyxb7cJqiTBckDMaPgEigQeuHFjPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=tuxera.com;
Received: from AM8PR06MB7108.eurprd06.prod.outlook.com (2603:10a6:20b:1d0::10)
 by VI0PR06MB10829.eurprd06.prod.outlook.com (2603:10a6:800:2f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Wed, 22 Apr
 2026 09:20:26 +0000
Received: from AM8PR06MB7108.eurprd06.prod.outlook.com
 ([fe80::a59c:f3ac:4097:9c5e]) by AM8PR06MB7108.eurprd06.prod.outlook.com
 ([fe80::a59c:f3ac:4097:9c5e%6]) with mapi id 15.20.9846.017; Wed, 22 Apr 2026
 09:20:25 +0000
Message-ID: <b9aa6ed5-0141-4ccb-a883-b9f0d8b95c21@tuxera.com>
Date: Wed, 22 Apr 2026 12:20:24 +0300
User-Agent: Mozilla Thunderbird
From: Erik Larsson <erik@tuxera.com>
Subject: Stable NTFS-3G + NTFSPROGS 2026.2.25 Released
To: linux-fsdevel@vger.kernel.org, ntfs-3g-devel@lists.sourceforge.net,
 ntfs-3g-news@lists.sourceforge.net
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To AM8PR06MB7108.eurprd06.prod.outlook.com
 (2603:10a6:20b:1d0::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR06MB7108:EE_|VI0PR06MB10829:EE_
X-MS-Office365-Filtering-Correlation-Id: 138a91e8-53a2-409d-5168-08dea0506359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NV4Axd0J/YFIGYwS0oxcTq7cjhyeetKgHzgM/Jqr5sHiSd1E4MJTCz2ycI4JBYfXuxfgzq1a5ZLJhIrdhPeEDW0fgiIDVZ/OBK8ww187lkQV7OeMQgu4V+hYHQNYYBbFqUKqgsGRJIvFVOyYiUVSBT1AjraXWh7DEllXB5PFc4Vv6b2OW1T4sF21zBOjvGdnDnIy59kegaExNGL4tlURNwM/hiOR6Spqc2QbJ7opIhT6sk0k0LlFpLQiDIbmiSVqp1dQ6XrQzz+pin1U7KHgV9Od/Mok3gyBMFdfdkeToGH0wxn+WesiKVFrSuX3SlYuE1gUceDO9c9eNbkxCizf4v/qnK0o9C0GPLibz8ydTU5H0vAmWLC8ploQY5FrcUsILIKRlhewSeS0VznENfSkWvmZDvzpm8fVj8OnQ7Kpt252nLxmIU0ymI1CXb44gp/QguYgkDCb1pZSjanIXfNmzseQq5EtSmt1y6uGwKiP/1HcckPICwsqCKptQKbIn+bWPcvbW/MiZXLQwrgVU7wAe4Si4r9VTEE4vyRMlvq9+svCVR2x2eWyyuVEmhur5VRMzSB26v6zkS13SPpiCzFMGG7L6xLDSjVgzOCTL1IkqSzqB0MF92O6daGj8VyweB0HUBqkwuWlsk8G5z+EAiNONElGis2bV2oRNPQ+bq/u9J/bcxuRtOWR0B2jOopPnaqt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR06MB7108.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUlLNlFNUEMvWmlqci9BVFNBdG9HbDc4NHA2QkovdFpzRXllQmRCdDhrc0sr?=
 =?utf-8?B?ekNqcEJycW5NdmlpYkhaOFlOcEozTElaY3NieUZpSnNFbDRjNnhsY0pKNTV0?=
 =?utf-8?B?ZllaUi9kZ1cyVlQxOHg2NVhjalhqamIvQ3c3bGFSUGdtaXlVa0x5N0lUdzFs?=
 =?utf-8?B?YTJsNFFxbkdLcXNwSEp2WXlZVmp1RG9tb2RIWFdtT2I4dkU2ZTQwWHNNc0NQ?=
 =?utf-8?B?NkhvK3JPSk5SU0NSYUpaZFJLdTJpbUJGazZPRFhEWVpETFZBaTBYSUlFS2Nl?=
 =?utf-8?B?bFc4ajVXenJxYzZDRm5uQlVTMGFlU3hpcDBJQWxPbU92S0p6YWxZd1JpK01S?=
 =?utf-8?B?eHhpWCt4Y1RLL1gyTUlkcVBEeEtVajJ6dnJ4ZWlMRGJmSXFpc0lERzI3U3Fm?=
 =?utf-8?B?OXVmeTV0NTZzVENvWlhFNHlLNktVNXpUY3luOFlveGJ5ZTVXbko3V0MrZ3p1?=
 =?utf-8?B?MVNjb1RueGpkM0J1TTUyUzVXNlhPYkh6NjJqL2ZMVFJvNnFXNlVJd0NNQ0xs?=
 =?utf-8?B?UCtDOWZLZ0gwaDViME1EQzJBNlcrYnRRa3p4elBXOTFuSmpka3g2WFkvM3l0?=
 =?utf-8?B?bXpLbmt1MGU4bHRwZXA1VnRIYi9hb1NjZ0l6S1BnRlpzQ3Z1a1M3NmVsSFVT?=
 =?utf-8?B?VXEwemhTQ1REbHdhT0FFMDB2Ulhka3M3WjZjQzRkSjRkY1hRcEdEWlNqaFJC?=
 =?utf-8?B?WWRSVmVCbWYyeXJFNWdYNlEzQVBGRU5Jbm1hR1NpQWhzR0o2Y2xONmNwajNJ?=
 =?utf-8?B?Si9QUUsvWXFuZUJmaHJ3a05JN08ydE1OTElXVnRIVHQxd0sxT3VONFFIOHoy?=
 =?utf-8?B?RmM2REZVOFZsN3JXSHc1UWxua0laaHpndldseXc2eXV2WXpDcS9yNTRVVVhK?=
 =?utf-8?B?S3VaeTVxWHlHTmNvYUlVMDNBSEVaKzJBc2MxMGRhZDhkODBxK3luc0IyRURy?=
 =?utf-8?B?MUVOdE5IRXZxcXhFUDN4bVc4R1E0QlpyY1FoS3p1eEtFcXdpOWF0aVRjYWFl?=
 =?utf-8?B?ZTBWRUNiN044Z1o5dUxGa3o2QmJLMGkwZktPMmp1NHJCdjhaTEtESENFUTcy?=
 =?utf-8?B?WENzd1JyVVNTZjZsRHF1Z0tPeVJmcDBSeTFzWENPU3NibmxkMUYzQnJWQy9E?=
 =?utf-8?B?OUZJM1diekNOZythNnN5MmhMRU1TNFY4ZklwNktWVFQvaiswOXd6SVdiSWV5?=
 =?utf-8?B?aEZqbjRsakUzckpyRnRuR0ZSRk11RmtxNXJza3F3K3pzOFdCOEMwYVVRUVp0?=
 =?utf-8?B?d1laamk5NTZPcWlFMGZ1RzgybDhWd3Uza3kzNmhlL3JTN1hHcURWelI0QVNM?=
 =?utf-8?B?bWp0Zzg5RVFFNHBQTzRBS0dPT1VuYTV1bGI0SjFJRDRHMk56NlJWQWRrRnd4?=
 =?utf-8?B?ekJiSytyV0RWc2kxWUhtTzdvdnFZWjh2eUIzdmtFZEF6MDNEU01ldmhsemNi?=
 =?utf-8?B?akViQzd6UXVRSlJkTzYwTk5MVFlNOEJEOHYvREc1SHFBenkzcjYxbGNsQVJs?=
 =?utf-8?B?NkNIVUVxanlBZWhLVU1mbGVVYUZNeWJZdkowV2tDdndDYVJCWGxVMHNwZFM3?=
 =?utf-8?B?cjY0NWhwMmEvNll4Z3psMEI0M21FbEZLc0xCamNoS3BWS1JlN1hGN013VGVY?=
 =?utf-8?B?cEUxN0lSVml4cjlXS3pxeVZnUThNQjN6MitWNmIyTUx1NENwV29zQWR0bHZz?=
 =?utf-8?B?QTZ3Vkxvc0tqUzZNQXFXaUNpK2FHZE1taVFVMExkbVRTM0FIR3NUTkFQY1Ns?=
 =?utf-8?B?NmFGaldycjVyOEt4cVZVbFI0M3UzRWNxUThVUXNzWnBmZEhnVjlUelhQYjBG?=
 =?utf-8?B?QXdSOElWbXllRWhrTm5iUk04SW1CUjNsYW1CTTl1ZEVQZjdEZmpCNm1hN0F4?=
 =?utf-8?B?ay9taDM4Qmc0UmNrTWRKSDJDV3JUc0FnSWs0Y1lQdlRRVERVK2d4alZoTVNG?=
 =?utf-8?B?aGE4QTVCcUZRYTB6Z3Vkb2czOXRndUdiQ3l3MSt0U09FbjBmYU02Q0YyRi9D?=
 =?utf-8?B?aDVyTS9ubzd5cktQQkVwSnFmblVIMW04M3RiMFZnZjJGWkQyK3MvbVJsK1Ex?=
 =?utf-8?B?UkZBQXgyTk5lOFhJejRzOXg2SjNUaGpKbXdGNGt2S2dJUmtaVEQ4bW1aYzFQ?=
 =?utf-8?B?RFF6MTE4UWxQenpiaTgxN3VEZ01wNEF0d01pNFBOYTRMRFE4ZTNQYkQraUhZ?=
 =?utf-8?B?aERqMS9xWHRuU0tscVNQcjBnV2x1QXQ5akRYZWJ5bUZPNzd2cUxERWRjRE1W?=
 =?utf-8?B?Q0xydUNuOElFcXFqZGtGOVphWGo4RlBLTXoyOTF2dEVkTjhENEJIVWJoNFhx?=
 =?utf-8?Q?OrwAM0D40V96QtWTVX?=
X-OriginatorOrg: tuxera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138a91e8-53a2-409d-5168-08dea0506359
X-MS-Exchange-CrossTenant-AuthSource: AM8PR06MB7108.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:20:25.8868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e7fd1de3-6111-47e9-bf5d-4c1ca2ed0b84
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YI8DIuykqKjki49bwX3y7FXokeb4M31xxoVf/mQzaz9TuxY8St/TmyB9lltKrxmD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR06MB10829

Tuxera's NTFS-3G team are happy to announce that a new stable NTFS-3G 
release is out, version 2026.2.25.

The new stable release of NTFS-3G includes important security fixes, and 
users using POSIX ACLs are urged to upgrade as soon as possible. The 
security advisory is available at:

https://github.com/tuxera/ntfs-3g/security/advisories/GHSA-4cwv-5285-63v9

This release also adds support for mounting devices with commas in the 
device name, improves precision for volume creation timestamps, allows 
adjusting the NTFS hard coded sector size when restoring ntfsclone 
images, and includes many more smaller fixes.
The full changelog is available at:

     https://github.com/tuxera/ntfs-3g/wiki/NTFS-3G-Release-History

The new release can be downloaded from:

     https://tuxera.com/opensource/ntfs-3g_ntfsprogs-2026.2.25.tgz
     SHA-256: 
7754f3b32e8baf9c472459b4e9c981e3ae0f5039107cdd8d8201aed0a949008a
     SHA-512: 
c4f537ea45a6ebb21ddf21fbf4d71ab336fdf9cb1d55a062a6376f90480cf6992b11ad93b4b2bbd8a96e26f97d7c15948d4f6cc71d713e9deb78e3a6cad7438c

The source code is available on github:

     https://github.com/tuxera/ntfs-3g/releases/tag/2026.2.25

Many thanks to Jean-Pierre André, Rakesh Pandit, Rostislav Skudnov, Eva 
Rio, Szabolcs Szakacsits and many Tuxerians for their contributions to 
this release.

We also want to add special thanks to Andrea Bocchetti for the analysis 
leading to fixing the security issue when building POSIX ACLs.

With best regards,

Erik & Tuxera's Open Source Team





























-- 
_________________________________________________________________
    | Erik Larsson
    | Senior File System Developer
    | Tuxera Inc.                           Fax:  +358-98-565-7002
    | Westendintie 1                        Email: erik@tuxera.com
    | 02160 Espoo, Finland                  https://www.tuxera.com

TUXERA - MAKE IT WORK

______________________________________________
This e-mail message, including any attachments, is confidential and may contain information which is privileged or otherwise protected against unauthorised disclosure or communication. It is also for the sole use of the intended recipient(s). If you are not the intended recipient, please notify the sender and delete all copies of the original message including any attachments without producing, distributing or retaining copies thereof.


