Received: from outbound-ip168b.ess.barracuda.com (outbound-ip168b.ess.barracuda.com [209.222.82.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321392750ED
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 20:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777235028; cv=fail; b=oFpU9yCYDSBeqDYzWg+Z0PD7ozsG/eIc4LyhtBw435mClH+q/GQzuBiWa5rbSdq4pOdAmFS9whZcD6AmTm6XUGFfH8WK/9ABmb5a/I/JIWow+I3zpUuPAkRbzOB99b3LuKZVj/APgiK7k4s0Gj8x/jpt+5/p3QxP2zWEavz4Xpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777235028; c=relaxed/simple;
	bh=iaAWJPlycSOR0bPd+ieqgk0W17Istpj9/nPAtNF6/n8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GCMVruOS9/sX9CyUsp+pdN3RrvPiWJ0BqzwMqQMd93AK3ULHS6FGnch1tMwrf6D0d3k9cPcTQa4SJ8Smdhyyaifi/CPAAQJFQG4oYWs/KnN3bYhYJnjXEeXTiWAVvpZeSFR9+cVNOFt4wTX9WgbavC6e3zB4D0+2P0UHnPvyZUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=yR6ElNAY; arc=fail smtp.client-ip=209.222.82.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="yR6ElNAY"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020127.outbound.protection.outlook.com [52.101.61.127]) by mx-outbound-ea22-179.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Sun, 26 Apr 2026 20:23:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoJVshyuUu1obnJ14+2oHWCmxgmJcyR/IAk+E+KCtGmr42d0kewYs/fWNYv6oiNL1JYkeWHNlCkLcTv73UDHbi9k5+vC159uyVROVc8Rb+JdjIf1ocYZofKUEEaSRy0m0YhWtj9JyqtvUtUIp2hjDSWyMnfafJyL4fM5boSyn3qJLg9tLm7K0grt4TfLajtTVqSdtoOR4M1thY105TbHFvw8ZsGIOyM/1IiTG3+jT9ceWj2/XLuAHhEd1D5LAp/qOUAZ2zr6EqIhCITSxXvKzeL3wUlFao9yLi3M1gZ/Bmsb4EwDZ2Yoge6cEice21PiLlCMUzrEzq0eucHo79uCCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/nY9VvN6aO7mSkto105L18quBqoNQFpxAU/MJlGvkds=;
 b=P4cjOknMmz/SyRC1y3uonkWLPmwDAOSVo5b3FWLiFE1TbPLdMe7EegumKxkQconQJk+WGh0H/ARxInDYidBUaR3qu909l3f9TJDhym0dJQKysSyFJCIYFbBbucvCTsBTmF09YbECPONZAffC7ShRQShZ/2HoP8LVhTjiVZldtswhLgFqsOiGDLJoLv5dgVxxHr82s6PHvjz3vwCDf4qAlum2dEPue1LsNFQUtrxbOWgZOJ+Q/3bG4fgOHhKTqOwP5NHaa/+WZcho8j0s8xp4VVksEn+t9J/1xkGzLrLQHgojU4/qJ+Y5beT2iIKngW+PydNWoNj7WKWjfiRhBkQoRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nY9VvN6aO7mSkto105L18quBqoNQFpxAU/MJlGvkds=;
 b=yR6ElNAYMb9ZO3sOuUOkGz6VdsiD6Dt7izTFDFFoPWraAhtIjHTWZkQ4pRSBsCoXjVu5QNaQuGQ7ecbyxcb2i/ROGw7PHsw/7A4bzyAz+IjpHZDOY/NdT3u19Axqb1H46jP4ckCNeqkxEI2ENEbLH/VHKsl74BbxOMQ2yKSUpV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by CH9PR19MB9636.namprd19.prod.outlook.com (2603:10b6:610:2e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.25; Sun, 26 Apr
 2026 20:23:12 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::c2de:bba2:8877:3704%7]) with mapi id 15.20.9846.023; Sun, 26 Apr 2026
 20:23:12 +0000
Message-ID: <2a8936a8-fe1b-4e1c-b588-f584c4704940@ddn.com>
Date: Sun, 26 Apr 2026 22:23:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v5] libfuse: run fuse servers as a contained service
Content-Language: fr
To: Bernd Schubert <bernd@bsbernd.com>, "Darrick J. Wong" <djwong@kernel.org>
Cc: neal@gompa.dev, linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com,
 miklos@szeredi.hu, fuse-devel@lists.linux.dev
References: <20260422231518.GA7717@frogsfrogsfrogs>
 <177689988489.3820166.4979104167640003535.stgit@frogsfrogsfrogs>
 <eed525ff-8f83-4882-a5db-574d2d3a913e@bsbernd.com>
 <20260426165640.GK7765@frogsfrogsfrogs>
 <665ed148-43e2-4807-b2be-01e82a98d10a@bsbernd.com>
From: Bernd Schubert <bschubert@ddn.com>
In-Reply-To: <665ed148-43e2-4807-b2be-01e82a98d10a@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0165.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:347::15) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|CH9PR19MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c0a682-7b96-4f75-c8b0-08dea3d1a372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|19092799006|1800799024|376014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Lxvh7HnAFBfW0IQA6E6RoOsyTcq7hmN4B2Vnvkp/EuxycdiQXSU/eFD/Y8qsp3JvkvvDu4P0d9rXerwACFOHT6Fr+yJ0SAilB1LpT/zJpxKjY5UG0zejl/sLizu40CTM+DDx8ecAKpKGw9qLP0U7n/BuX4cKn4y4MRtdcfU+T3CDka2Er627ptnnxVy4Lc0+VFV46ChBeDJW/Ki/yRK62GN58bgZNJfdI42VX6jUxlMrOfYX2KW1LKdqLd8JHMbKeV2+KuDstQVwNo8F+cyh09mmRU1d53bNLWJkH1mN+QMB4dPych92UIzsjCW5R1UpzvxGJoL/4V3TkFdSsp1EbH+ULaeVhE8ZespyWM6DZ8FhAbJCtE6TDVzWXAEu1SsjHsRkDZcu1ncd1QYyJb6v91u6yUORxOC+fp4NCsdHcjBw5ZuxZ0sGbsTpVzVS3gHNKMBJj0JXlYF82vsqrIJexv/mgyBox7hXIlEnbDGn5CwtBRCSTEFyjVFMYfd0u+RtasXikit1LglN4YPJSeK16eZPHj5fg/OITaUM8lgBEkOK7yeKHmSx8nb9s61GHZ7eOsQ7BS2ijR4FEJD/YmfC6qL5U9oFDNDP7Dlj5pS/yhc6YDU6Mgl0dBybfVGr4g4mjOPpkoAMhBFUFrHHvTIjkqsz7XLtc8n7ciPgC8xThFQGdlt1Dd91eSLeYD0AQn12vSFoL1SQnc3D9ePt9UlhXDo9KIqXVMczCjzdL+/S3d6Ls5xdCtesSwdht4KAuFEl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(19092799006)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rzk1K1JuTTM5SHdKRVhnK2I3Z2hKd1pvRGZYV05QOWh3R0tKdlF3clV1RWw5?=
 =?utf-8?B?Sm13V2l6VDRzRkpzK2RkM1JORHhtaDFOWVZ4S3lHQzFneUxFZTVKcFM4T29C?=
 =?utf-8?B?UHJLYTJwYk5YSGErSVhkckQ0bFNJQ0E0N0ZQOXNjUDRvZ3Ruakd1Y1JNaHNp?=
 =?utf-8?B?eEZTdmYybGp1dmpyeU45bmNwSFJ5cGkxY3BXQTJyZE53bHppRE5sbk9aOTZ1?=
 =?utf-8?B?MFI5amF2bC9xOXBoMDByczJRNGFLa2ZFZjFoVU9Bd09hREFuRXdyZ05ocFh2?=
 =?utf-8?B?MjVNRkZxYnRwdTRNelZLQVE1UnRVT2M5WnhzVksxenJnUGlhS2syMFF3UjV2?=
 =?utf-8?B?R3ZWZVlCVCs0OEFEb1V4UnppYzZlK2R1K2Z1QTE4bTM1L3hBSGdicGVtZ0VC?=
 =?utf-8?B?NE53QXV6YmFqbXgrak16cEN2dXRJajNNZ0dMWkhja2lCQjkwdkV5aGN1WXBR?=
 =?utf-8?B?SkROeGZHQlVmeUFJRTVrS01zRXQ3by9LQU9TMGtncldRS1AzR05hSldwOUFj?=
 =?utf-8?B?M1pVZnRKT3R1NzVvZ2VlY25ST2NVZlNiWEp4VWxoeW05MVh2VHZmSHdSOERG?=
 =?utf-8?B?b2hra2dDQlg1NUw3Y0VRUGFZaFptQ2pySG5TU1pmSWd1UmxQWDFRbElEV28w?=
 =?utf-8?B?Z3ZQMGFPZlM4ZkNGRkM4U3RCMXpmajNwRXE0Tjdta0t5UFRKWEYwQlBsR2lC?=
 =?utf-8?B?dU9rczlwYTBDViswVVBmdnluYitiTWlQc2YyZGg0OEJRWDMwL0FTWkJoZW1r?=
 =?utf-8?B?OStSUjBuRUZuWmJRbyt5QlNkVGIzNVZjOW9xa0dGYXUvdDdyamVYa0QvczRH?=
 =?utf-8?B?L1N3bHRleDI4NDZ2R2VmYmtrRW5iVVZaTkJqOEZMTkMwNnFESXpDN3pZRUV6?=
 =?utf-8?B?K2hSMXZPWFoyM2tWQWFZNTJIV3Aya0tNSHJaU05xUmhxUVI5MXFLejVMRGp1?=
 =?utf-8?B?NHpVTnh4SkhxWE1PWGtSWTlnZlE2eUJNaytKNUtZeUJ2NEVLeEFCYWVoR0Z5?=
 =?utf-8?B?OE9BOTFrRjRyK1pQaWwwTE0yNjlQVUg5dUNJVTg3UW1tYVdGdTVoU25LTmlt?=
 =?utf-8?B?OVdtbmphYnpIOVpPbytUb3dDR0F4cUdRVjBCSTV2MnRHVGR1Ri9GMERRb2h5?=
 =?utf-8?B?ZWE2QWIwZVFNWDJaRmM3UEsyRVd6Qzh0VFhVYXJmYlEwWUE1U1E2NDhncjRT?=
 =?utf-8?B?Q3YwMjY4MDEybnc5d3hVM0NyNm00VTJyU0tCK1hEQ2tlcHJYMFJBMDdMTEph?=
 =?utf-8?B?RlBLUUp0K1RrRU1RM0dreU45SEsvWVVOZzBQMGZLUGRxVk9ZSFNxMWFiR1A5?=
 =?utf-8?B?TDJDa3F5NVBHWkxLd09UU3Z0dk55T2dvMVdUVGxhWEo5QXFNcXUrTlFzS1Ew?=
 =?utf-8?B?Y3hGamJKcWVVNDE5ekZ5MU5CT01IRnN5bCsraTVzb3FERjZ0M2hBdWJwSEpy?=
 =?utf-8?B?MDBDWHI5SFlkWW5PQ0x6M1poQ01iMkswK3NxV1UrckxscnFYSFUzZVhWbitZ?=
 =?utf-8?B?MFJvMUFjL2pXaFh6VlJIbExuY2gyY2ZRVzNDdzY4ZGVJdEQrNGZ0c1lSZTBU?=
 =?utf-8?B?SlpGTDhSSSsvN0lMbG9xUUtJbHBxclJtM1BlWTdHNERPUlpjeGNXQURFRHFz?=
 =?utf-8?B?d0o4WWFqWEZTNE5KSlZGaExDQ0hOSE56ZHdjY0pCb1NZZEN2L1hUZGlobEdG?=
 =?utf-8?B?ZnJYMy9odVcvR0hJWElzREQxb3hBbFZyWHhOQm45MzlKTWpuVGNzemNoYmRk?=
 =?utf-8?B?c3BtZ1FzWmNsRUFoTFNLWXB6Uy83a0RnOWNET2lCWnVtbm41RStrUGkra3h5?=
 =?utf-8?B?ckkxNHJpOFI1L1FvQWFVMko1VjBSMEE5TitlWEJjc3JwVWVzV09uaGlyTE9H?=
 =?utf-8?B?VGI4Rmh2TmF3TVJhVmFJR2xRdDdhK1JURDVLUk5BV05UcmJ4SkVOam9FS20r?=
 =?utf-8?B?K0o1MlRIbnhabTBpNlU2S0RtbUFKOXVwTlBBVVhUZ1R6ZW92ZDlRaVdpV3Vz?=
 =?utf-8?B?SnUvV1I0UVRxOStEb3AxbEVuUnZzRDVUNGFGZ1N5ZFlNaTg1dDFqeGRxSVZa?=
 =?utf-8?B?aExRWWl1MjZrQjY3WWpOWXRjTSs4UTBiSmJYTEJzU2hnVnNoTG15c3pncUVI?=
 =?utf-8?B?UnlJdVZXb2ZTdmNsdTR2MXJEbFhJYXUrYzIzaFFCL1ovR3RpSHp5TkJZOEFT?=
 =?utf-8?B?RkJMMXZJM3pucSt2b1BSbGJHdkRMRmpmeUVub1VTbXloLzlnUE5oQnEwaVNt?=
 =?utf-8?B?cmxmT2VSSjVUYk5sMnRjZFRxS1NhcGh6eVI1TytVS3BHdnI2VjRrMHJEaVQ3?=
 =?utf-8?B?Z0FkZlZBNTJxbUFiZHh5Vi9GMzJUUFpyK2ZTbTBPOHRmdHgrZytrZnpKVlVi?=
 =?utf-8?Q?JH1zbk2K+9cdndVzpMR8mRJOsa9fhEo/w5pLCAk88mfVi?=
X-MS-Exchange-AntiSpam-MessageData-1: Ymaa0/XfLh1QZw==
X-Exchange-RoutingPolicyChecked:
	hTJePWgq4S79OlBBdf+axK9cXWkyzUEUpSlN5rYfWipUD05r2f9MSuGrix0EOzdJZzYtp0yYfwO03tp3ayVG7klfkGGIsg7K6pBYjU+ueDB1KLLJya1g83xee8E4/d6RpqprvJ/WuFWM4+rlqlV6nIuH/k174K8qz1XFZh7ng72hnnn/L4i9smUZd7WX9pvTSnVvV2alrowiMeYLC56vt6/4iXtcMzovoU8yTBjYA0NSadMlWb+e7zPda8CttDwvrVXbhe1KxBNHqBF+OjUgUyPaVS/Ml7P1Jv5RZKtmNodvZ2Cxjt3FHJBLaAFdiMxNFuEpGLqJeqbQDWR5fPasMg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qZs7lkTuI2iTZ3AwOonJxk1s+p1qVq3yID6THhOy5Zo2Apb31RSikWOVgoT/SYdaCpmvnxfuG+O1VFENcdbbXWWFbjb1kyFqK59L2wrxdLpZsxCki2ViY0A9q9xnN3g7hCEkNuqU4113l9LjuecwqTmAF3fCegQ9pGkJ8zwpQW808IPw/3O42sW7qsBqJlbNaVRL9cWJgDuAbbtYH3wHIniDnC8UrGqM2/scuMVmoFVHFXk5sIKbjuksqWTOYa1RLRGK8oJyaDxjnV43vosPM3GmDJRVbEDWnA+BDXk8/wVhl0ZlEs+QSowNj6T4EuBVRWj1TJKCyPIlw7glANc55vRve9upjnFA1x2Uo59oGwVv3CREJwlRu0gqe3kHueAnOEtdMM7/xPtydB/61VBEIXNfw1Ql3ZFDc38tthjtN7/f6vDDjcwMYo/vwTBdWA/4p1yKdDUippRFxMsENfog5m7/s08BnNJNSHmk3Ros2x+Oh4SO3kxrpXp/kd2kDmWBbzZIAcCKmid07oT95QjVducwHgTzmplycyZBZ0hSJS2tYfnZvqEekY6mYIj9Tw4CqTE4wlGdaG3MNtqDfBt7zwBxfo7CUlwmJo4tYnuToJH685rcy4VBxHKErLqcmPrYNo4oMyAEVue44rexD+WTZA==
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c0a682-7b96-4f75-c8b0-08dea3d1a372
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2026 20:23:12.0758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJaxfJri5TqEJ4u34WxT+RCzfghUxQjMNp6IEc9SKqEO3mIMG401+Z48wlvSpxL6M57zZLpOWHzMLWz2QKJ9Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR19MB9636
X-BESS-ID: 1777234995-105811-9038-45993-1
X-BESS-VER: 2019.3_20260409.1625
X-BESS-Apparent-Source-IP: 52.101.61.127
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViamxqZAVgZQ0MLEzMDQ2Nw82c
	QyyczM2NQo1dQwydTANDnFPMXQyMREqTYWAGYnxRpBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.272835 [from 
	cloudscan19-245.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1



On 4/26/26 21:35, Bernd Schubert wrote:
> 
> 
> On 4/26/26 18:56, Darrick J. Wong wrote:
>> On Sun, Apr 26, 2026 at 06:35:11PM +0200, Bernd Schubert wrote:
>>>
>>>
>>> On 4/23/26 01:18, Darrick J. Wong wrote:
>>>> Hi all,
>>>>
>>>> This patchset defines the necessary communication protocols and library
>>>> code so that users can mount fuse servers that run in unprivileged
>>>> systemd service containers.  That in turn allows unprivileged untrusted
>>>> mounts, because the worst that can happen is that a malicious image
>>>> crashes the fuse server and the mount dies, instead of corrupting the
>>>> kernel's memory.
>>>>
>>>> v5: Refactor socket IO into helpers, tighten the security checks in
>>>>     mount_service.c, always set nosuid/nodev for unprivileged mounts,
>>>>     use posix_spawnp in mount.fuse, restructure sample programs and hl
>>>>     library code to avoid the need for unmounting during startup
>>>> v4.1: fix various cppcheck/codecheck complaints
>>>> v4: fix a large number of security problems that only matter when the
>>>>     mount helper is being run as a setuid program; fix protocol
>>>>     byteswapping problems; add CLOEXEC to all files being traded
>>>>     back and forth; add an umount command; and strengthen mount socket
>>>>     protocol checks.
>>>> v3: refactor the sample code to reduce duplication; fix all the
>>>>     checkpatch complaints; examples actually build standalone;
>>>>     fuservicemount handles utab now; cleaned up meson feature detection;
>>>>     handle MS_ flags that don't translate to MOUNT_ATTR_*
>>>> v2: cleaned up error code handling and logging; add some example fuse
>>>>     service; fuservicemount3 can now be a setuid program to allow
>>>>     unprivileged userspace to fire up a contained filesystem driver.
>>>>     This could be opening Pandora's box...
>>>> v1: detach from fuse-iomap series
>>>>
>>>> If you're going to start using this code, I strongly recommend pulling
>>>> from my git trees, which are linked below.
>>>>
>>>> With a bit of luck, this should all go splendidly.
>>>> Comments and questions are, as always, welcome.
>>>>
>>>> --D
>>>>
>>>> kernel git tree:
>>>> https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-service-container
>>>
>>> Hi Darrick,
>>>
>>> going to look for your previous pull request - kernel tree doesn't help
>>> me for libfuse ;)
>>
>> Urrk, that wasn't helpful of me. :(
>>
>> The following changes since commit ff7aa456d426d89eb19661da7b4c171153bac516:
>>
>> update kernel FUSE io_uring doc URL (2026-04-20 10:34:32 +0200)
>>
>> are available in the Git repository at:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/libfuse.git tags/fuse-service-container_2026-04-22
>>
>> for you to fetch changes up to 4f47bd86cd84bd511afdeb59fc18994915eb13fa:
>>
>> nullfs: support fuse systemd service mode (2026-04-22 16:08:25 -0700)
>>
>> (Sorry for the slow reply, I'm at LinuxFest this weekend.  Hopefully you
>> could construct the path to the 22 April version from the previous PR.)
> 
> 
> No worries at all. Enjoy LinuxFest! I had taken the
> "fuse-service-container" branch and HEAD points to the tag. Got
> distracted by another issue anyway. Right now I'm trying to look at the
> test failures from your branch, but github seems to be very slow.
> 

Something must have went wrong with the branch

[4/92] Compiling C object util/fusermount3.p/fuser_conf.c.o
FAILED: util/fusermount3.p/fuser_conf.c.o
clang -Iutil/fusermount3.p -Iutil -I../util -Iinclude -I../include -Ilib
-I../lib -I. -I.. -fdiagnostics-color=always
-fsanitize=address,undefined -fno-omit-frame-pointer -Wall -Winvalid-pch
-Wextra -std=gnu11 -O2 -g -D_REENTRANT -DHAVE_LIBFUSE_PRIVATE_CONFIG_H
-Wno-sign-compare -D_FILE_OFFSET_BITS=64 -Wstrict-prototypes
-Wmissing-declarations -Wwrite-strings -fno-strict-aliasing
'-DFUSE_CONF="/usr/local/etc/fuse.conf"' -MD -MQ
util/fusermount3.p/fuser_conf.c.o -MF
util/fusermount3.p/fuser_conf.c.o.d -o util/fusermount3.p/fuser_conf.c.o
-c ../util/fuser_conf.c
../util/fuser_conf.c:372:13: error: use of undeclared identifier 'MS_RDONLY'
  372 |         {"rw",      MS_RDONLY,      0, 1},
      |                     ^
../util/fuser_conf.c:373:13: error: use of undeclared identifier 'MS_RDONLY'
  373 |         {"ro",      MS_RDONLY,      1, 1},
      |                     ^
../util/fuser_conf.c:374:14: error: use of undeclared identifier 'MS_NOSUID'
  374 |         {"suid",    MS_NOSUID,      0, 0},
      |                     ^


Going to fix that now.
