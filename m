Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020078.outbound.protection.outlook.com [52.101.196.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1421D191;
	Sat, 16 May 2026 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778960080; cv=fail; b=E5SRnNmAHty44yp6UrycFZunbDOCgDiaHuWHPz8lYbttv2wnwVLEUbhwETv/njlpY3MndeO1tPSQa661sZgSRmx3Gg0kf4r2i4KOpCFYcfKdWQ25FIINg2Yq+w81kGF5LwiV6ke4K867yPxYk0Roh6vuQnMoDGn2EwcLTcXKN6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778960080; c=relaxed/simple;
	bh=vnWK89vtVrIrI9Bvke/63xME//6HVdJg0tFFoIP0ik4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ekfqY+c2TokDCrDYusk3acoL44N9jNuJirYV9u/BBQshfmRtXGreR2kEeadWbDF1/zL1SItQseosr3njU6Cv5qm9NVzerB17YjufgoxZowe2w9cjH4uUT0yGCABpXHD4QMr7k53oAXOCepWy6U0vMj+RseytPuuf8Ma2EvxvN5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=BObS1Gnq; arc=fail smtp.client-ip=52.101.196.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="BObS1Gnq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jm2ce6x77TtQoEP16nEhJ96Oyailcc4bHeRdllQwSl8NWz9ovJYN0HASF9KqjzMWHEK4DU+mmRVCmwi6njseHAk4Omdw3y/ugdmknas6QxX9B7zie/xkQe0Id4l6YYiO63kEdlVSU32K4Y13p5VZXcPR+sDho55I2PO2G/+N1uHbpc5omZJT8ET0nGH4+8D+tjvoFPo7l8OqOToNKjhviqN9uVgwOu0nHLvfsUEIwe4zRwQF81tIq6gzMOqF/Pc7aClAgCDa8jVwGy2Y+ib2oL29bhL5Q4d4q0JoFm2uErJyVA7wZDtBYHLRObfCk9fP6DiT130DEeqjyZjvoZP2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnWK89vtVrIrI9Bvke/63xME//6HVdJg0tFFoIP0ik4=;
 b=ZKUgpwui7x3QTAtbfMvAfx4y6Mqe9SbBrHtmeL7AlsOwiG3DskcRlYIRXF2IOZi0G4b+j8/ncOdUmGvEOJ2CZLun5KL3K4ShNb35Cc5v9qsw9LVAQvSsj79y4yTiUrm25btGzIgURRHCe2PAphNwUpSyGLM/cW94YJgnkfCGrZ1ixDs51Ep932JRaI7xMgiMQzm64S63Z8zaHmEIJW2Y4KR3izEU2G26UhlObhj2B3/Eqh6vwunMRprXYAYqTT65xt1PolE6jBdjiqWJob4ZPcrWKm6Mc3lX+XWBuLtDOKu0wgq/5D24uEU+av9NBwnsDHIkizssMlR446LPEhu50w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnWK89vtVrIrI9Bvke/63xME//6HVdJg0tFFoIP0ik4=;
 b=BObS1Gnq+I5LASoD2tSXuvMOBoMw2t09xXQZUMsQYsqRaFm2PVSZJGrTL3JqPdZu7Nbn7ZOKXJsQe9QAz4XrAUQrkHh5BlUl7xSNv38LtGryRSWY2B/1aF2X2k7dUeOPLt2YpTEHpvysDEBM2zA/s0cOym5u2ASKhzeWE7ev4wg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO3P265MB2347.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Sat, 16 May
 2026 19:34:35 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9913.009; Sat, 16 May 2026
 19:34:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 16 May 2026 20:34:34 +0100
Message-Id: <DIKCPS55DEZB.EITY48PJ1UO2@garyguo.net>
Cc: <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <bjorn3_gh@protonmail.com>, <boqun@kernel.org>, <brauner@kernel.org>,
 <dakr@kernel.org>, <gary@garyguo.net>, <jack@suse.cz>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <lossin@kernel.org>, <ojeda@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <tmgross@umich.edu>, <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] rust: seq_file: route seq_print! directly to
 seq_write
From: "Gary Guo" <gary@garyguo.net>
To: "Yifei Yao" <donplat@barrensea.org>
X-Mailer: aerc 0.21.0
References: <20260514053724.178321-1-donplat@barrensea.org>
 <20260516040812.477347-1-donplat@barrensea.org>
In-Reply-To: <20260516040812.477347-1-donplat@barrensea.org>
X-ClientProxiedBy: LO4P123CA0447.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO3P265MB2347:EE_
X-MS-Office365-Filtering-Correlation-Id: 6711ef80-1834-45d0-6e7a-08deb3822923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|7416014|1800799024|366016|4143699003|18002099003|22082099003|3023799003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jKUEiLXHy+LwTV1DK8tXlaEufSwIu1aiupDywp3yO1zea0+vIH131J3mG8MprBTL/V4Pkzzw2zv0cCcIRRxNyySP4Xv34qnjYjkuH8bJsiANawoZaocVtPN36wfapXAHaxcNgIo3/8wSnBzpNrzF6Tu+bDEQTIom/Bm/No7dIoIRmrOax/TQDHrVokSLtn+BTQ2VtONGCA1Ckk5/2iqYiJM2LxBsQrQYdd4gclY2KQNEpbpUtPmW3kv1vjBkHVPBFllewt0ODLWmIJJcTtqhJMk/1Sr1KhWlGhxOfdbeCzz0ob8p2JL0PbCP0rNdwJcJZH7Y48kWwwQohp1Oi2l35pwWRU8JzuUwnHWlzRBFFbZlCH2J3xiRv5rj6c6KoOlhoWLDyCTmguonr7LHPUbntzyq0WU3znuCNPBk29ACgPN/oW5msLhzUke5H7ZDxgRXH6rEpZule4Ml0msEklxUNlLMxFbq/0fCC3dcgqVV6Kq63T9QFT1BhaE5vv12PCLbxL+7LsT879cCwK6TemGZLpMTmtrZGezRK0bN6Mo4k2Xog3SrFslwmKbS+huh6nZ7k1hlUaHUXz7clVCZ6gR0M6iIeXFwhVijYT836eEtQ2/l3FFy3rZItxD/6YQE7mXtf+F4dNDeGb7zljuI9v6K7FXZ+DQyOhCVYTWtm4fubWhyUIi3N4Yml0jnjtrsjGpS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(7416014)(1800799024)(366016)(4143699003)(18002099003)(22082099003)(3023799003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTdxTG44SDVLblM1VGZhbW5HTU1BWVJjVmpGQnBJTy9Cd210T21TMzZmQ3ZY?=
 =?utf-8?B?RDRCbXVKWFdqa3pUZzF2ZXJhdlJWZjc4ekNKelhhWitIQUUxWURiZzNaSXpM?=
 =?utf-8?B?YXFPNzRYWU1ZVDJLdlFGSXlkZUw3MkM5TGd5QjZLalRvL0lCcVI3bkRkL2hF?=
 =?utf-8?B?TzFmMkxFM1FKTkJZNU1aREkzK3ZKbFNjSVFJaFlZbGU4ZU5ORXdMRFhXZnNy?=
 =?utf-8?B?TTN6TDJ3N0pYLzVpVm1VcFNSYmYwZytPV2M5YWY3UDRrOFlJYTdaeEdEVitI?=
 =?utf-8?B?RnRTS3IzeHdNYzM4NEx1OXdOc052VE1sT1hyRytkN2dRa2VFWmkvdm5EZG14?=
 =?utf-8?B?SDliUmladG1sSHNKRnRJbVJSaHJjckdmaXZWd0tDTVpYN0s1WU5pVyszS3BD?=
 =?utf-8?B?Y1RnWkdidWE2UnNyL1RqVVZoNjIxY1AxZjI5bXZTTVdLZVBqKzU5TW5DMUhl?=
 =?utf-8?B?UTBRcDVmcWZCTWt4UEhndWE1bHFhenEwN29HRXlWNURkRVpjZ3lLaEpHWWVX?=
 =?utf-8?B?UnZ2R1BkRTlOTy81WHNVZEx6b0xPUG9sVUdCNlhIUHRIaEhCZjF2YnFjdU8v?=
 =?utf-8?B?REtPLzFDdCtRSnkwUzJnZEQxNnowNGdXTTVrOUYwZ0V4MHlWMDFzQTJhUkVP?=
 =?utf-8?B?VThMbjIrNHlycU9UdzZOSVF3YzdxYVpGZFdrWHhiNnlONm83d1pNWkIxOTZY?=
 =?utf-8?B?eEV1cmc5L0xTTHpobTVxQ2NwdGl1RmV0Y0NuQTRpNDJHd3RITWFKTjd4Qmdo?=
 =?utf-8?B?Y0Z5RXFudnRxWGV0ZDBYem5xdDVvd2pIdjFsTGRWUVBsUmlOQ3krV3Qwdnky?=
 =?utf-8?B?Z0Vpa0duc3JiVEtLVjNhRlVBNEQ5dWtXQmluQ1ZwVGVLckFvWUNrL0U1clZj?=
 =?utf-8?B?emFMRXdBU2NQN0ZOZE16YlhDbVYzaW1yaVdSVWt5aGt4a2VVMThBb1BRamd1?=
 =?utf-8?B?cTNqdzRQbmJJZ2dJY0IwT2dYWXBTUGpEK0d6OE43NTNhTDlmQ0IxYkVzc3pC?=
 =?utf-8?B?U1hGTkRqNUZKdlJtbWg2di9JUitvdmt3S3lJNkRrM0Evdy8zVVZXcG1Kc1V1?=
 =?utf-8?B?YXBDeHMxYXNkNExjWWFZTlgxcER4cE5hWXpsUmlDYUtPODJGaFVFVkdjcEpv?=
 =?utf-8?B?dzhzZHFleFNDVHJ1MUlUdTQ4QnRFRXVqQUt0UFdWd3VFUC9pYWR6MnQycHdw?=
 =?utf-8?B?WkJreHNheHpSQmdJVmxSbUNXa0JOZjA4SlZ1ZStWUkhHalV6QTU4QTR5cXVv?=
 =?utf-8?B?N1J2dFR0WHF4K2ZmVm5zQ0ljYmVTU3lsbStPdVVDUmFQSCtGU1draUsxNXJz?=
 =?utf-8?B?MnR3a2t0MjhRZ2tkU3h4V1FSZytEN0RJRVdGM1RoeEFnbkFrTFU2eC9vZ3Z0?=
 =?utf-8?B?NWFuVmVuc3lMY0QvSGw2elpFb01CU0JyK09CZS9LL2IyMVMranFCRk9YcVBN?=
 =?utf-8?B?cEJBeGJLblNvUDJQVzVrbmxWMUVlVHoyUkhYSE1EMm1Ya2RWQkpEUmJweVhN?=
 =?utf-8?B?UXJlT2x1V0xuZVlGRytFRlhCZWxiVDNZNURRMUd0WStmd3o4dGZPc1cwV25G?=
 =?utf-8?B?MUJGbGM3UFQ0S2gvK0ZMLzl5a1BnYUl1anArVzJidzV4UC9iMUVidVZMRUZy?=
 =?utf-8?B?c1ZnQnJMMEx2RzdCeXVKTEtyWExTcDdaeEVHRFhUQU45cXV1NlFLc0hIU2pP?=
 =?utf-8?B?TDcxa2lnNDJpYnh6ajRmK0dsaEhGMnFaQnl2TjlHK3FiQUdqR2d4T1ZPZ1ox?=
 =?utf-8?B?cUtIZXhtb3orWTRxY0pqWjR6NkhvL2hYQUxocm00aXVDUjNXU2phZ0c3SlBM?=
 =?utf-8?B?TWk1Rm5SMnMrZ1RWYmRybFRoUm9wbVdhSmhZUGx4QSt4aWEzejlGSnU4MEpZ?=
 =?utf-8?B?eWlFN21XWUYyek43S09XZUFGV00xdXpTSW1zemNUbE54VUVHcXVDbHZNTkRP?=
 =?utf-8?B?alBOcm9zdlNPdGxuVng5TnJ2a2FjM1pwZWIybXh2S1NrZW8zaXo0YktZNVEx?=
 =?utf-8?B?Mm5SRU1JK1I1R3V1VTFUZnNTMTZidW00alpCekVhNit1K3htQkJjM0NRUTZW?=
 =?utf-8?B?bWFPdGpGUFVzemhhWUNBdTlScnZyQkZRNVZNZDRkQ1RoQzJCSG4rRHdSamV5?=
 =?utf-8?B?UDZxZHdMTm5mK0hzcHYxUldZTzREcFlUbGRJaHcvL1o1eWQ5VythTGdYNkNo?=
 =?utf-8?B?YW1paU84T3paYTRCQkpENzdYb2NscFJzejMzWUtZSllLQW54VVNNaHZYNTVx?=
 =?utf-8?B?MnFXdkNUa2t4aExtaXZJaW53YTV3TUVxWWJSNkNzOHZTOExxb1A2UHlDRzk3?=
 =?utf-8?B?S2V0UFVSbWhBcWxRdEVnN0V2TTd1YmVFSG53UnlMS1FoV0c2Z0paZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6711ef80-1834-45d0-6e7a-08deb3822923
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2026 19:34:35.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pni/ufFV9FatX3Ct2V0sm1tCJSPBRTbLtarstfSAhuv1f4htpluA+Q+M18I1xdyx06JQdLUyDFTIJ/ZhIoKDdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB2347

On Sat May 16, 2026 at 5:08 AM BST, Yifei Yao wrote:
> Currently, the `seq_print!` macro formats output by passing a Rust
> `fmt::Arguments` object to the C `seq_printf` function using the `%pA`.
> This involves crossing the FFI boundary, parsing the
> format string in C via `vsnprintf`, and triggering a callback back
> into Rust to perform the actual buffer write.
>
> This patch implements `core::fmt::Write` for `&SeqFile` and updates
> `call_printf` to use it, routing Rust's formatting directly to
> `bindings::seq_write`. This approach leverages the bounded string
> slices naturally produced by the Rust formatting machinery and copies
> them directly into the `seq_file` buffer.
>
> By mapping to `seq_write`, we bypass the C string parsing state machine
> and the `%pA` FFI callback, streamlining the execution path. Since
> `seq_write` uses a bounded `memcpy` relying on the explicitly passed
> length, it perfectly matches Rust's `&str` semantics and operates
> safely without requiring null-termination.
>
> Note that `fmt::Write` chunks the output into multiple `seq_write` calls.
> If an overflow occurs during a partial write, `seq_write` sets the
> overflow flag. The `seq_file` subsystem inherently handles this by
> discarding the current record and retrying with a larger buffer.
> Therefore, this optimization introduces no observable semantic change
> to user-space.

Seems that this description is AI-generated. If you used them this must be
disclosed per kernel policy:
https://docs.kernel.org/process/coding-assistants.html.

What's the benefit of this change? Given a single "%pA" string vsnprintf do=
esn't
do much before passing it back to the Rust formatting machinery. `seq_print=
f`
just formats directly into its internal buffer, so it's not like there's an=
y
additional copy being optimized out with this change.

This also changes the behaviour when write does overflow, where the previou=
s
code would write as much as possible to the buffer and the new one would no=
t
write anything if the last chunk being written would cause overflow.

Best,
Gary
