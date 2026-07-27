Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021076.outbound.protection.outlook.com [52.101.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D8F414DF5;
	Mon, 27 Jul 2026 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158490; cv=fail; b=XGacYC5slrDDWFEJUo6gz3LluxrqBwqDLfRJKdVAVpJungyFN+Ya0BhFCDN+hY6pwBoPSnGdecP4ToPnjqaS9zBlTcztxNPLS7gr8J9k+BzPlxHYcEMHGoJCO7U2XLnzU5o3w9vl1wQR+zOMGbyW+7JwU4u3Wynzc2sBFVmZxpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158490; c=relaxed/simple;
	bh=VpxpvrH7D74nSuPHHYGyaNUOhg7/n0vP6UbM7bGUAoc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=RacCDIa3Ta4pczsQtj5sU2+pmssLMLLouLWKZKuMQfzlFQf/wonSBg/Udl5y48FFl27BEU2DSJIeN7Nur9af2jHEDyVVg8BOkt3otGxYDjbcrdykXTT29kHWqQezjG/9uwispZEfYM3XuLPx5YquZ6s0xbfH2V948J0cgcXfgCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=J+sZSF6Q; arc=fail smtp.client-ip=52.101.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="J+sZSF6Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdluPiZAFwdFEDZ6sVTgJzn2b47v5ow7P2qv8w8dezL3IA7Qk4AEAazNRO23ENEGat5v1AE4RkHc68AZNAFFrWmf7OnPLjIIFKHIYcZT9B+dEtBEHzleIj33q/YntA+aAw3LCmAbtVbjOcc8/K35Uj/fsfDqk2IIEnSSgeCAz/FvRJxPTTBEuyQyrTCoLMosPSGZpLqoU3qUPC83IXcoSmWQ6hCEguFw3FLD/damockmVnJzh2/989SEb4J4RkqVckxBXU236fwkDOUCkdRoOhdQXRf484w44+MBZWyPkl3I97RZuaj8puJsjmO/SAeD0clUOp4FaKDOLcU4SjreRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0dX5OLL0qh5zDK6LMLPlusl1on4T0gBqHQBsLUhUeI=;
 b=GmHuV0hcVAks/z6UxCe8O2oc2GOf/Ht7RL5e52Y/shqYmR+SNvbDTkRgudNItXxH24bb//Ft/0sijKZCBrArUqLKzTP7Lxz6WwedjYXrjm9EEfF6OPCSCLN9Yiugx+5Vi4uOzLWx2TYZ1LRqjvTS0lVGnFOsBgSRVM/ZT6U3PG1zn45UcDSMg8MBi4BI3dIx5ycJoFPeB5vPO/B2eoer0jUtFFvQnM7TZNFOwDS/l209KvTtcYBb8xWK5pLFPIulaiTQhD8XrZgvmieLuhU8fxiFHAuMFruQLjWdaxTOC5nITm+Y2xIDU0tTseh5f9x06qkPUuV32Ml0tsiuClKwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0dX5OLL0qh5zDK6LMLPlusl1on4T0gBqHQBsLUhUeI=;
 b=J+sZSF6Q+ysiwGjwK5AWElrQzd8eiKaL8GoEXp9PMDFmsztUNlJp78Rrxu8vVpM1M3PccZ5a0HDwr5DZrPDEzxU/mkgytElsYsxG7grgMpS7buoU4Ka0cxr9xfhhUyu8elg9tPhlYeZpG1Dw9bWhiWxNJER7AlBEFhBjCvC5M4s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO8P265MB7796.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:21:25 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%2]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 13:21:24 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 14:21:24 +0100
Message-Id: <DK9DVA538I9P.3AWAGJ93EZ3CV@garyguo.net>
Cc: <gregkh@linuxfoundation.org>, <arve@android.com>, <tkjos@android.com>,
 <brauner@kernel.org>, <cmllamas@google.com>, <aliceryhl@google.com>,
 <boqun@kernel.org>, <lyude@redhat.com>, <daniel.almeida@collabora.com>,
 <work@onurozkan.dev>, <juri.lelli@redhat.com>,
 <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
 <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
 <vschneid@redhat.com>, <kprateek.nayak@amd.com>, <ojeda@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
 <longman@redhat.com>, <viro@zeniv.linux.org.uk>, <jack@suse.cz>,
 <tj@kernel.org>, <jiangshanlai@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/5] rust: sync: add WaitQueue infrastructure
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260726223613.1242940-1-dakr@kernel.org>
 <20260726223613.1242940-4-dakr@kernel.org>
 <DK9C6KISAMX3.H10297T645RT@garyguo.net>
 <DK9D4LAND3I8.1CXI8473PG88M@kernel.org>
In-Reply-To: <DK9D4LAND3I8.1CXI8473PG88M@kernel.org>
X-ClientProxiedBy: LO0P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO8P265MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: e77a1553-6d35-4b1a-24e2-08deebe1f541
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|10070799003|1800799024|366016|56012099006|4143699003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Lq5cBME/8IH2qUj32m3FAlkjmYMptGyY9VDgocW1xhNDEBUKGgDjBwXbOljLv9NTBiDplpWZX0aoK+5tbTbg4qwgwQ6F6qykgWWM1nHOr+tFbu2CX6vOYo6p0oiAaysdNsnBI8iou8nIKABXd0RZzrh3SYBcZciGCVwN/w/CLbyxsWI7IJ1KB/XzhtHTuGWPgRQwDMy7TrkhD07xszil6r1T0wNfghzbh/sdzw2ZnBG0774TqU1WEMZxCHiRZRjm2Z3OkNi3X7KzRat2cC3bqtr720L4WJcj/FzcTL8Gk7YGGAHtWYDiJJjQCJkprgFR50qEs+evHX9SA6P5ziCOTNAERTHk/KD/eQgLVBxigF2whyiy1tEpZyjDq0O8MFSqf5ciEw35O31OL13QRshM21PMuiovyvcWJf1Vce92aEPBKvslrh81ekjxRFPk+LofLx8upQ7rb4M71VV3x3877ahzBTPS2XPcq7csgpwRFoWU1bDj76tGYLAjH+I9V9/3xlxHP73Lgs65c2jNhgfLsyDZgWQmszTUFVrpkffdNL5mGoqzBgvIHXcVCdoFaHsjQU1xT7HPJ/GFP49YE1q19FGpXDdNAeroXR9mo97xV9WpMLWwmbUL7SF3nTD1JU0M5TVUhWuwfvIl7QYmTNrCEEB8EgTaJWdoQ+RzdahQ9/A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(10070799003)(1800799024)(366016)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk04TThiUlNscnZLdVptOUQxZTBvUmJzaS9ZNnVGV2xIMjNSZS80S2hsUU9n?=
 =?utf-8?B?WTRKNkJWelR0U1NtVS84ZWxPNEZtMmJVeExxV05wQlZxYVVlVFlxckpDL0d1?=
 =?utf-8?B?Y3I3WHdOcTlwSXQ0MDhWS1h3Z09ieWI2ZGFNcjdYY2hma2ExK3lMMnhweTlE?=
 =?utf-8?B?OUhmbTJwaHJTMHhJMk5SYVRqUFcvamRMa3VoQVVOaHIwQjcxSE0zcE95ei80?=
 =?utf-8?B?S3VvRWlNT25kVDFNTlZ3Wklmck8zY21jcnRQNjM1b1p5c01oajJTazh6Zzg0?=
 =?utf-8?B?enI5VVN6UkVKSDlLMlJCZmhxTkRtbTE2N09sRzgrNE52ZUYzVVVGWmorNFo0?=
 =?utf-8?B?ODFwU2RsanF6TU1BZTlVTjl0ZjMvZlFVSW1CQVl3Q2daWStjdExtMnRvQlN4?=
 =?utf-8?B?Y2pFSitmNXc4b3pBWTZ1NVRJeUFCQ1NsNmVETXVZNjlycWI0SUFzSFJubHJH?=
 =?utf-8?B?YzM1c0RBUUQ4U2NQcTFheFgvYWdYVU9mNXRMc3RNc0ZzRVc2L3NEbDN4RkFJ?=
 =?utf-8?B?MW44WkVXRXB1L1puVjBhaklFVFQ2YnNUVFRSbitFeGpxWGZ5ME9XZUxRVFAv?=
 =?utf-8?B?KzZGQnUxeWZOTkJ0WmJMNEtVWUlWbFN5RFNibitpd01WTVBLNzBweWtzNmxi?=
 =?utf-8?B?VGEweEFEMEYzdHJSSmVlWHpwa0VlazY1Q2JBbGFEemZCVjZ2ZVl5V1pVZURY?=
 =?utf-8?B?K2pjZFU5Mnp3UVl4eVFDU2tSMUZXMVZHNGpqSnViSWxrbGkwTnVPcG1qWFhy?=
 =?utf-8?B?TUVwTktHZ3VBT0pENXdrR2dPS0dhMzlhY2RaVEZZbGJyb1F5UW5rRTFJVWE2?=
 =?utf-8?B?dlhDQXhhWnV2NGdoSy9WalYrNXpYelRWOCtRZEtqbUx4YUhpU01wb2Fncll1?=
 =?utf-8?B?SlRYQ2pHR2Y2YzZvTDJlTEs2RzJwZHVMdnU5TWpvVTh5M05sQ1NScGtzcW9I?=
 =?utf-8?B?M2VxWTNKRVV1bjlHVFRxZm1tQUQveEZVMThCQ1NscTdBUkF6QXFFMzFHaWM4?=
 =?utf-8?B?bTB0aHBnR3haV3dsbmc5aGtmSzJzckZPcTAzL3NFbnJUTWliQlpFeVd1bTUx?=
 =?utf-8?B?eUtGak9HbG9tV1pPMFJyVUFBS1NHTFhPOFBpanBEb3F3TXh5bk1zci9RdlJw?=
 =?utf-8?B?RG5UOW1GeDVUdkxPeVJKRGZJQStsYkRhSlVSd1BrUFErallSUmJMVC8zTEFn?=
 =?utf-8?B?NklwWW1vck9VT1ZHbU5yN0Raemk3d1FsQ0prd0pqVTBYTnJYNUNYb2p4a3pE?=
 =?utf-8?B?NVBCanhncVB2MEFMNC9mNzh6dmJLSytnWkNyajgxTm82dHZDdHF0NTVZL0VE?=
 =?utf-8?B?U0hWcUNBNE5wWG8zcjhaOGpRZjAyTjRKMHM4R1RLaXZITU14a1BrMkt1SDR6?=
 =?utf-8?B?YWhYWVI0TjBKVzhhZDlHZTMraTBSTTFBYXN6WHU4U3N6d2VpR29YUVA1bmoz?=
 =?utf-8?B?WDVOejdmNWpZTjF5Nmhwd25FbkZJcUN0clFrTUlyRjFRTjFjajlOZU8zYWNP?=
 =?utf-8?B?RFBTRExrejhaa3EvZWRXMVJybk9BVlFmNXVEQ3ovbWNrZ2Fwa1dOcGhzS1Ur?=
 =?utf-8?B?Z1U1YlJHRDBzdjd4RUdLZWZXNDVZamtpa2NGR0JUVm4yMHpJYUkyajB2OXZ2?=
 =?utf-8?B?YUVCREJKaGNrdHpuRFB3Nm1BUk55M0taMHJMRmRRUmdqNEMzdjFRa1lwK1Nl?=
 =?utf-8?B?VWVLVVVHaGs2OEx1TTJrbERza0RldzREYzVGM2ZtSzJpSlBrMEp2QTJvc1BO?=
 =?utf-8?B?aDJkS0tEbGtaSjJvaHJETVdpUWU0VTQ3aXBUMGk4VnZPNnQrQlo4WlFQNWxM?=
 =?utf-8?B?NVJnSXZJVm5IOHA0Ny8zdkJSczU1aXRpS3ZBYnZIYjBJaVoyM2U3bFA4cmZr?=
 =?utf-8?B?Q2dpNTVaMUVzeG9WNlM0aDRRekJjaldwVkg2UVBDbHNhMWplQThScUdvazV5?=
 =?utf-8?B?emhJN21QMnkvenNMRENBSWY4THdmcmdJVi9LTTAzNWx0elBPUkZNYVNmZkxm?=
 =?utf-8?B?R012YUNRUEJtS09UWTdrQlBJUGlpQ3BoOWtXaWN2NVRJSjBrcEtRN0x3ZTNH?=
 =?utf-8?B?NUZkQm96QW1BMTh6Ulp5b2ljdWZNTWwwL1NEM0RGV1U5V2hlYVlUWWlCVmRu?=
 =?utf-8?B?UktRWGFXaGErMFFTWWJYaS95Vy9KQzVDaGlHSXBRZkpCdXA0RlRReFVWRTlk?=
 =?utf-8?B?em4vNGxKVkdselNZZVJ2T2R1M1YxOVJ3cHc2Yzh5NXpXRDE0UWlXd2JvdG84?=
 =?utf-8?B?TE9Nbm50cis0dUs4NzNzQnVRdzdCMzMwSEtWdUJQSTlvbmJoNGdDZGJQanN6?=
 =?utf-8?B?TThFdGQyMHpxQnBGbVZ6dFRKYnJPcTczN2ZnUjFHdC9Wa3NyNitpZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e77a1553-6d35-4b1a-24e2-08deebe1f541
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:21:24.9002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TY8KDKFog8TlZfzFepOkGCxjmHZZSv/E17O1bIFxJn560oUzQasGQmqkEnQCh4nlIdrYVOcLcp+NDMm/nlB3gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P265MB7796

On Mon Jul 27, 2026 at 1:46 PM BST, Danilo Krummrich wrote:
> On Mon Jul 27, 2026 at 2:02 PM CEST, Gary Guo wrote:
>>> @@ -0,0 +1,388 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! Wait queue.
>>> +//!
>>> +//! C header: [`include/linux/wait.h`](srctree/include/linux/wait.h)
>>> +
>>> +use super::LockClassKey;
>>> +use crate::{
>>> +    prelude::*,
>>> +    str::CStr,
>>> +    task::{
>>> +        self,
>>> +        TASK_INTERRUPTIBLE,
>>> +        TASK_NORMAL,
>>> +        TASK_UNINTERRUPTIBLE, //
>>
>> Hmm, I am not sure why we are exposing these as constants from kernel::t=
ask.
>> Regardless, Given that you're using them for bindings, you should probab=
ly get
>> them from bindings::TASK_* instead.
>
> See commit f090f0d0eea9 ("rust: sync: update integer types in CondVar");
> personally I don't mind either way.

We should probably find a way to do type casting in bindings crate for thes=
e
instead.

I suppose the C API is also being inconsistent there, given that `__state` =
is
`unsigned int`, while `prepare_to_wait_event` and friends use `int`. Not re=
ally
an issue because TASK_ANY is 0xFFFF. But it does feel to me that we should
actually be using `unsigned int` here.

Best,
Gary
