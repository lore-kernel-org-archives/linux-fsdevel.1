Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADFB36E467
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777480774; cv=fail; b=b91njWLoZQXanG6uWoqFmJPlKVIeuOFhrxCnVPHvltBiVvhRwC/P2m+lRPD/xaJBl5uwV1UabgoK3tgD07PptvJy7ISt84v6VPIHrgLnc79cw9s6WA9HuoELoA+jITd5/1HiHBO9+UxLOEb5vgCNFXQG718C61+YWBYMlFfpOIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777480774; c=relaxed/simple;
	bh=1j/CB8TgtA3MIRBx3X54/tyyeXOY6JHI4Ela21wSjfs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sDDyv/cLLDzihO/aIfUXPGdP02+PpnQTH4UKr8RV0/YlsfgJqOjoG+uIO/q2aHgue/4Q4nIZRpm2MHpgKOUHY9xUb2zdvtg4qpXBCnVyg+BTE6C9JRMzcExKSUPdS5mC+y8StcOcA++iLup0u7NJLt2RTeFbbIZc6vR8LK9U+cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=j7JxRVDa; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="j7JxRVDa"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022076.outbound.protection.outlook.com [40.107.209.76]) by mx-outbound17-11.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Wed, 29 Apr 2026 16:39:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/j7GVlGTIqeduC5Vfr0cVYUXpBaxAEXYaovBM21SwWG8yBgq/lluMZfMhzCxjHFSJlUiK9E838KVE9Kk3WroAHHKALeiN89igVy+kCXHbpw2/QzU8D/N8mUokBmOZ8DuFMtfmSJei8MYdOTlc6tvYuF3PXFrXOWY00UcA2R4c0rbsPCPy0+CtiyzKeQQDcJEGgF2F22fG1JaIreVlcuxJF0mJGwaEEBCwda1m9jT4/T4aVR0UkEBQRgC6nmoLgK5ZriXHl3CYPgfiak/CDI2b97CKVcjtzrFmzxakYS4514FmF8JGNBn46oxUWR1ci/9Tde79eM3kVXZ8wjDeJzow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQ81OSrb86ejlXYIqdw213qUFV7MyMGaYQUcuI20ZMk=;
 b=bGjNBimGZYS4/ChnRsSz+SdVSYeiL2LQT22xb56WgAmOUkRjhngNs+7ymEifIYJxUcpWPkwCKW9kNFmtDkR1pCcF8TZhBdVwD4NPgF1VxnTHWXvqFkPPDVJr0+53GHfVZGDkwjBO7yZlB73aZON15y4o8zaA7pWT8raPupNii95cvR/KAjmHUo71//A2iQHJ3KbLvRrMiJBNWjy2az8OLf5xAVOroXNKnMFKip3tm8pFk+uFhNmIXojfqj7BxNdWsObH1eyoZKUrJn3nQIcR71OOL2PCIa7sGtGj8Jvbw3l7UKvw4fEguWqp2qNq/NSl7RQtYQIYILsvCc49f1KvlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQ81OSrb86ejlXYIqdw213qUFV7MyMGaYQUcuI20ZMk=;
 b=j7JxRVDar7goYyqLQZaf69oN4RDqMH7+YZtyzVlAWj5uG2wfYlwUP12BbahQ7I6v19ELWNKLjt8SNmydIIYxAu9QhntL24t5qgjqzip2klH8MOSbTL/zYVHQXAjzY+iXF3CapcTX5KSxuR5fxWM0ERLnXlakYEX7N0nq7xOUghg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by SJ0PR19MB4415.namprd19.prod.outlook.com (2603:10b6:a03:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 16:24:14 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%7]) with mapi id 15.20.9870.016; Wed, 29 Apr 2026
 16:24:14 +0000
Message-ID: <0a56969c-7fe6-428a-8eb5-6df5e61ff03f@ddn.com>
Date: Wed, 29 Apr 2026 18:24:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] fuse: {io-uring} Allow reduced number of ring
 queues
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "bernd@bsbernd.com" <bernd@bsbernd.com>,
 Miklos Szeredi <miklos@szeredi.hu>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>,
 "Darrick J. Wong" <djwong@kernel.org>
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
 <20260413-reduced-nr-ring-queues_3-v4-5-982b6414b723@bsbernd.com>
 <CAJnrk1aYYSVU-AdxRoqC5H8xk+4rt9Tf=3BPphsw4vvNxjpEyA@mail.gmail.com>
 <b7e93b2a-7096-4957-bf75-38e096a9dd3e@ddn.com>
 <CAJnrk1by9O1JBH5W9jvkgYcBZK_t7nxzeSsmxm65jb4=wv-ikQ@mail.gmail.com>
From: Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <CAJnrk1by9O1JBH5W9jvkgYcBZK_t7nxzeSsmxm65jb4=wv-ikQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0160.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:347::20) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|SJ0PR19MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: cab1ff03-ad2c-4694-fa6a-08dea60bc08e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|19092799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
 R3l37o084qhLvIxSlQIvCTrUrotiDkOqPhBFaQQv6I0Y5OYabqDKLKW1O4GpCbhkYVNuU1ZNpNjcq38MxBj68/SmkprHAm/X/CnaFJzqveP4WHH10XMUyDrytpqjNtZN1OOTR31GEsLt0nVlEUnRci9wCxfn+5N8rck8Xqk1OxnlVFcGUkS0BDv/CLaQvgyO4WqEnJrWdHnsdeI7/K55WHpXyYHp1skaR8Sz782wvToRIlIPg/FspBE5s0Ie/Ix+d94HHo3yx/lq4mS+e/Q1XEet4q8bgMbLyzWb/Gns3UrORMp92d9VjZqpuri/eL3ALPgMakZjDeS88LFGFaLwXOoIoS4bAYGldSHGQtc0SWSEB3zgN8tjUbpuPobk7BG8TKml62Bxp7nPjPZIpYxRGD9+jTA/GdLNe6BY4/BBZNhQvMszIao3ZDoFyvqHWvWuUjA/JiIsT7Ne+e5bxkltlCxxl0NkIQ4KR7anM2W5crlkhQSr8t8DvBuxAJA6QRhdnuT8o30k5HS1djvgqkk6XrS2SzLD+jcc+8VxmBtffhvOorbPUyDfYtbkcGPpAyOMOHx0CUbxa867F4QQtK5zf6z1C1yvh0TY6daS7IPhiPJzpbLehJjYJ5v2EWawxzprDpVEbRe4IvI7vOMhzVXeQ2gorJknb/ueH25hJqa0FMLnZAxumvgmm73WPHy6QOi2Xfo1LvsKvqtlxRzXhs/WNpHgokgM6vLhbzAm/A8V5rU=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(19092799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SE1FcHFPeGk3bE5mKy9XKzRXQzE1c0dES2tyYyt0U0w4Tk5iSVBFcS9SOE5N?=
 =?utf-8?B?NnpIdU1MZ3U5NXBQbTFBamtvekZ1OGUxZHQ3MjNXYnZTMlhSSkZldGtYUUxj?=
 =?utf-8?B?enZ0d0lEa0VMVnRDNG5mTWJMbVJyUTIrcVRwTE9wT0doaksvbmxKUmJJUVFh?=
 =?utf-8?B?Sng2ZWNXQmlMNHNOMmRjNUszMXhxQWlpeFJLaWNLRlNmSCtwbkpNT2xUTDJ3?=
 =?utf-8?B?alBybEIvNVl1c3NaR2R3ZGN1VVdUa3ZJbzBtNnZHcUhhUUNUZ0RSWEFoTnV3?=
 =?utf-8?B?ODhKUDkzbXVHN29oZ2V3MmZxZEZMSHVmeDV2TWZOR3V2KzR2ckxZWFA3TjBS?=
 =?utf-8?B?eW9HQ1EwaHIyRWxoZ21Da3dpY3IycEEwNVduZjl2M2VoUjdwUDQxcUM5OWpF?=
 =?utf-8?B?S3I4RmpON2RkbEE0WnVDL085WUdGcWtBZnllcjEvZC9tRzZLZzJDUHlZL0JK?=
 =?utf-8?B?N1VPMmlYelJQTzZnc3NKeE1SYVVHUVIvbG50djFpOHM3TVRBM3Z4NWhLN2w2?=
 =?utf-8?B?MHlYQ2RIUWNVeURZMWZlYTVMdHpJUVg3OXl5c1Nqb0d2WHNRMWlGenMwNWU5?=
 =?utf-8?B?ZDJkQVQwZlFSSzJ3TGI3b25kOTRTaEZRWG16UHlkL1NuZmpiTm15NlU0bEZr?=
 =?utf-8?B?ckl4cjg5WjJSRnpVM3EzSEtDOUNQZE5qNEljV042ZXBocFV6UFhtcUx1Z0Iy?=
 =?utf-8?B?UmdNYXVWTzhKcWdPeVRsT0szQURUU3B5WFU0d245TzFhUmNyZkR1UHAwbjFw?=
 =?utf-8?B?RGRhU1BxbHFycGRpMzE4UnhyTGhTQyt2R0V6bk5CcWZaMytDR0lUMTk1eUNF?=
 =?utf-8?B?U0tiZkNVcVl2S0xUUU00eUNub3cvTUEzKzFkOVNFemludmRDYnlESm1ZNjZR?=
 =?utf-8?B?cDVZakd5Z2t2NVc1OExKK1BUaVB5eWJjcmRXaGxQUCtjNm9sekdjSFZIYmpa?=
 =?utf-8?B?MmgwUk1KV0FSRUpldlhUemNQN1NjTGJzVC9jZlNTWDlLemV0S2ViRk9pd2oz?=
 =?utf-8?B?VXFrY1ZhNGhaTVZEN2g5MTgvV0V1TEFmcjEyYzRaYVNoTVZRczRsMEhTeXVo?=
 =?utf-8?B?c3BjcmU2RXhXNU9LWlFsWWtNU2VqaVgzaXd6M0dhaSt1MElScDJmcGhWRUxR?=
 =?utf-8?B?YSsvSE1GNHNWb2FQNU9CZHhzcTI1TlhmN2hOVWJYMWR5V1h6QkxOSXBUaTFT?=
 =?utf-8?B?OHZQVERZSEl4eVo5VFQ2SG04QXFUb3Q5K1ZxelE5RGRybHdjajRnTnk5S0JD?=
 =?utf-8?B?WjdqQW5wam9MWmpsSUJPQTRYa2RqeE1DSmxMUDlURmpJQWdEQzFFa25ObDBZ?=
 =?utf-8?B?YmhuWS9SVVpBb1piZGpBNE5UUjgzeER0VmhkWTQwQUphTE9TcEw0NW55Y2Rm?=
 =?utf-8?B?azJ6U2hxa0pWd1c2SGVYNy9seXVla0hSUkczajNQTEY2d0o3V3BxcXh6TlI2?=
 =?utf-8?B?TWUxMTlTQWMxY1d5UC9ZM2ptVlVaNzlCUXVZTlBlN2VIWTkrMU16RHltUEEz?=
 =?utf-8?B?R2F4S3NMS01nRHMxZ3RxZi9NUmhTcUFzT25PU0hRL2FDSDFIYWJ1TDg5U01E?=
 =?utf-8?B?bEV3TmEvTi9lMWJ2N0kzSTFiMzl6ckNTMVYxZ0t6Y0RTK3ZWTklsWUtkcHha?=
 =?utf-8?B?Qjdxc1JSb0ZHNElSbEJDbXk1QjZyR0VvdHUwdXQ3bmdLcWxYOUNPbHVNUHBQ?=
 =?utf-8?B?ZjY1VFZyYmtDWE1KV2FpYzZNT2FTRVdsT1AvcUoza0dhNno5OVJEV1A3QmJj?=
 =?utf-8?B?S1FNbzZNS0VyQythWnZaVUlTckxqY0xnbUtNdHpYRGtCTysrVWVoNXJDaXVJ?=
 =?utf-8?B?L3BCUVExbWwvUWJmYnhTWEo3bG5qYXRIR3ZqL1BpdVRlNW1HSzcyZ3ZmN2Ni?=
 =?utf-8?B?OWlXR09DZG13RE96VWNSWmVEY3hOYzZaa0J4ZkxvUlhtenFDRzhibnNyN1JF?=
 =?utf-8?B?amtVaHZCS0Q1RnFMYTFlZ2puM0k1UU83dUIwdEhKU3AreUJsdUphbkRXa1N1?=
 =?utf-8?B?NWk5aU0xSkc5OEh2VTFrQmlxRHpYZVVvd2c4YnB1cjd3alliNlZSbGN0blFL?=
 =?utf-8?B?cE5TcTl6L0hkV1IySE9MaXBOclBiWU95ZEtsV0svVXMwRXhiWVpRSkhBdXR2?=
 =?utf-8?B?eHZhT0IrcE9xZ0I0U3BYcUorbjR5dWNHZzlpektMQk9MUXRaS2xuWFltT1o2?=
 =?utf-8?B?eTFiaFlhSWVxalFzVk5KUEpwQ3ZkRS9KWTE1a0tVWk5OUkNGNS9sb3FuQk5j?=
 =?utf-8?B?Rks4MzMwWXV6NGI5ZlhydkVqR1pwbEJENGtCQW8rR3Z1R2UrZUxIV01qdGdw?=
 =?utf-8?B?ZUMzYXVUYkZlTncvUk92L3l2M3ZuV0JNemZ0K2F5ZUd1MTNVOWxDUHdWKzNQ?=
 =?utf-8?Q?Pp9+mxhBxxleYSW+YPNFJ1ZnaObrq7xFGjv9jJhfc+hJy?=
X-MS-Exchange-AntiSpam-MessageData-1: u1VW+OFFrVSxYQ==
X-Exchange-RoutingPolicyChecked:
 enG/FtXYtc8uceb0jBhBpcolL/NDIj4TaQHMJVIhdtH9KRn3JEbMa4W6E8HIBMtmz9M66itwO+XoDwqSZM7PR5U5fJJnB2u8iY6/9i4osJnaBfkrCCB4ik0urJxbSypm/jyQF4HPj2CGNFTtLv8rgGmogSFg+S+T3MD71bfguyv/p1PNJxUD8FD5pErGFyIVfsqDxgSJ1rFgTyjI6slmr36vLhNWl7iG48muMzdVMPAEL221KvfC41Uh0SEk8ypiO6g8FBTQL1LGfcLa1MsQEAKd3lJfrYBCpzXaCwZYED/sjZ9gKR0rQwpumL8fTzjwIpZpM+mJ8QAJeAYkb6GDdw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 UXDxLwj1oCi2NfDReUNcWdk9a766Ksay62XlKvbhYvHYY2cwhgyzUDLt1TFCVv6bj0UwaG9ho5jCnwSCfAXe/aTdTQlALjZ6VFOMc+3PDN0/3NetIZijtq5PjiIlhdCK88P2neO384Wgr3PQHFsLnmgLjm+d2fUIq83Cq0aGQFJYGz7uj6PBfcse8szii+SZwHZkL57K83+bdygAo7JjqJfAFS7TrBlSq32MlGKoh3vz9ovBNo/rICRM5VgRv6tU3IdvC4ekXfnECGYwNrgkGZ+TtSIekYitA4+s/nyktSCPkmtPwUTrZb59FEQsSkizRGrMy2MXyMNZs4pTdxM2ZiqhZoB1ATIkQUf3qIoQUSII+i4XaBBeQA/9rclEruHadG4ifXK5H/ekn/3xQ8iH2LHOwCdBwQ9lMp0D3ZnHH+Hko4cr+i5DkDEwnaZKge3vMWGVCCtAatF+1pr2Q4HttmmLq3Ljo9VGpdaf+jZvnTx/q0Tr9wMSmtlcE1XCUMIO7k1WxtL8NS/FLqeTL3eWY5WtT15kmpGz7iXsuFMZrYpNP3rdwmXQG5InE0mPuHleEr7g5AlRkOGNrGEpLlw4KKU5x0D9ZK5PPcM3j/BZ3dQ+auHclNmF79r8bWl2XOwtn7arQRiwnMUtxV0KbJ/5vg==
X-MS-Exchange-CrossTenant-Network-Message-Id: cab1ff03-ad2c-4694-fa6a-08dea60bc08e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 16:24:13.9583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDDnL/AC6XWJ1N3Wyl1SMVbAczBKxt5aDJ1WX9ePUWUoX/Uqj8GVDDaUVDJTRWNZlFVNcSn2lWdgov2bmvl9iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR19MB4415
X-OriginatorOrg: ddn.com
X-BESS-ID: 1777480770-104363-15767-7682-1
X-BESS-VER: 2019.1_20260409.1619
X-BESS-Apparent-Source-IP: 40.107.209.76
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVuYGJiZAVgZQ0NTI0CIx0TTFwt
	gw1dzSNNnUzDLNNNnENDUxJSnR0sREqTYWAAEC18FBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272903 [from 
	cloudscan23-87.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 4/29/26 18:10, Joanne Koong wrote:
> On Fri, Apr 24, 2026 at 11:01 PM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> On 4/24/26 20:28, Joanne Koong wrote:
>>> On Mon, Apr 13, 2026 at 2:41 AM Bernd Schubert via B4 Relay
>>> <devnull+bernd.bsbernd.com@kernel.org> wrote:
>>>>
>>>> From: Bernd Schubert <bschubert@ddn.com>
>>>>
>>>> Queues selection (fuse_uring_get_queue) can handle reduced number
>>>> queues - using io-uring is possible now even with a single
>>>> queue and entry.
>>>>
>>>> The FUSE_URING_REDUCED_Q flag is being introduce tell fuse server that
>>>> reduced queues are possible, i.e. if the flag is set, fuse server
>>>> is free to reduce number queues.
>>>>
>>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>>> ---
>>>>  fs/fuse/dev_uring.c       | 160 ++++++++++++++++++++++++----------------------
>>>>  fs/fuse/inode.c           |   2 +-
>>>>  include/uapi/linux/fuse.h |   3 +
>>>>  3 files changed, 88 insertions(+), 77 deletions(-)
>>>>
>>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>>> index 9dcbc39531f0e019e5abf58a29cdf6c75fafdca1..e68089babaf89fb81741e4a5e605c6e36a137f9e 100644
>>>> --- a/fs/fuse/dev_uring.c
>>>> +++ b/fs/fuse/dev_uring.c
>>>>
>>>> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
>>>> +static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring)
>>>>  {
>>>>         unsigned int qid;
>>>> -       struct fuse_ring_queue *queue;
>>>> +       int node;
>>>> +       unsigned int nr_queues;
>>>> +       unsigned int cpu = task_cpu(current);
>>>>
>>>> -       qid = task_cpu(current);
>>>> +       cpu = cpu % ring->max_nr_queues;
>>>>
>>>> -       if (WARN_ONCE(qid >= ring->max_nr_queues,
>>>> -                     "Core number (%u) exceeds nr queues (%zu)\n", qid,
>>>> -                     ring->max_nr_queues))
>>>> -               qid = 0;
>>>> +       /* numa local registered queue bitmap */
>>>> +       node = cpu_to_node(cpu);
>>>> +       if (WARN_ONCE(node >= ring->nr_numa_nodes,
>>>> +                     "Node number (%d) exceeds nr nodes (%d)\n",
>>>> +                     node, ring->nr_numa_nodes)) {
>>>> +               node = 0;
>>>> +       }
>>>>
>>>> -       queue = ring->queues[qid];
>>>> -       WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
>>>> +       nr_queues = READ_ONCE(ring->numa_q_map[node].nr_queues);
>>>> +       if (nr_queues) {
>>>> +               qid = ring->numa_q_map[node].cpu_to_qid[cpu];
>>>> +               if (WARN_ON_ONCE(qid >= ring->max_nr_queues))
>>>> +                       return NULL;
>>>> +               return READ_ONCE(ring->queues[qid]);
>>>> +       }
>>>
>>> Hi Bernd,
>>>
>>> Thanks for making the changes on this - I really like how much simpler
>>> the logic is now.
>>>
>>> I'm looking through how the block multiqueue code works
>>> (block/blk-mq.c and block/blk-mq-cpumap.c) because I think they
>>> basically have to do the same thing with figuring out which cpu to
>>> dispatch a request to.
>>>
>>> It looks like what they do is use group_cpus_evenly(), which as I
>>> understand it, will partition CPUs taking into account numa nodes (as
>>> well as clustering and SMT siblings). I think if we use this for fuse
>>> io-uring, it will make things a lot simpler and we could get rid of
>>> the per-numa state tracking (eg numa_q_map, registered_q_mask,
>>> nr_numa_nodes)  and simplify queue selection where now that can just
>>> be a cpu to qid lookup instead of a two-level
>>> numa-then-global-fallback lookup.
>>>
>>> Do you think something like this makes sense?
>>
>> Maybe, I need to check that code. However, does this really need to be
>> done right now? This cannot be updated later? For me it looks a bit like
>> we are going to replace one code by another, without a clear advantage.
>> I can look into group_cpus_evenly(), but I cannot promise you when that
>> will happen.
>> My personal preference would be to work on real issue, like getting rid
>> of two locks (queue->lock and bg->lock) and distribute max_bg accross
>> queues. And that probably requires the distribution across queues, which
>> you didn't like in the previous series. Anway, already finding the time
>> for that is hard.
>>
>> My personal opinion is that queue selection needs to return the qid, so
>> that the function can be overriden with eBPF. I didn't have time yet to
>> try that out.
>>
>>>
>>> Additionally, as I understand it, in this series, the ring->q_map
>>> mapping has to get rebuilt every time a new queue gets created. What
>>> do you think about just having the server declare the total queue
>>> count upfront and then the mapping can just get established at ring
>>> creation time? group_cpus_evenly() would only need to be called once,
>>> the cpu_to_qid map would only have to be built once, and we could
>>> avoid the rebuild-on-each-queue-creation complexity entirely. Do you
>>> think something like this makes sense?
>>
>> That is why I said in another mail that a config SQE would make to some
>> extend sense. However, the part where I disagree is that we could make
>> it all entirely dynamic with the current approach.
>> Only the logic for that in libfuse is missing. I.e. it _could_ start
>> with a single queue or one queue per numa and one ring entry. Basically
>> no memory usage then.
>> And now libfuse could add logic - many small requests - set up ring
>> entries with smaller payload size (or smaller pBuf). Many large requests
>> - add more requests with larger payload size. And with the current
>> approach queues can be added dynamically.
> 
> Bernd, looking through this series some more, I still think it would
> be preferable if userspace passed in the number of queues upfront at
> registration time and requests are gated until all those queues have
> completed set up. I think this makes races a lot simpler. Even without
> configurable queues, there are already tricky races to reason about in
> the dispatch and abort/teardown paths, and with configurable queues
> that can now handle/submit requests while other queues are not yet set
> up, there are now races against both request submission and
> potentially concurrent queue registration, as well as races with
> mappings that can reference queues in any state. I think it'd be
> preferable to try to keep things as simple as possible, and have
> dynamic queue addition added/supported later through a new uring cmd
> if needed.
> 
> What are your thoughts on this?

Can we defer this to v6? I.e. v5 goes out on Friday with minimal fix
changes and then we discuss with Miklos about it next week? In the end I
had all these things initially entirely static and had an io-uring
config ioctl. In the mean time I see a good reason to have it dynamic,
mainly to keep memory usage low, but I also see the possible races, of
course (although I hope that I didn't introduce new ones).

In principle we would need at least monthly meeting to synchronize and
agree on design choices. If I understand Darrick right ext4 has that.

Thanks,
Bernd
