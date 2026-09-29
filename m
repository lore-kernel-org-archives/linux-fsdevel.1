Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020075.outbound.protection.outlook.com [52.101.195.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBE05218B2;
	Tue, 29 Sep 2026 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684706; cv=fail; b=OJxUaV56lbpf0t5TDzA5wMP1SCjv3sTlUoCH3aYRxmV6KY2Q1aPpkBZLq9Ppb+8nHSHnyGXextZNz1SghiNhMuXK+vYbHpupr9W07NGXGQbj3JzQEIZgqNo/5WIdI8iyiK+B76UWyNnlEiLZ1tN5Fi+g3vAQMl0hX0acpbEINbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684706; c=relaxed/simple;
	bh=8q1hyOviadi2CGcfJ2YziIyBAn+/KGbdD25KimJg5Q4=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=KJOopyWwFRm82ddOYLYvTWBHRhqAjUPOmsWl0Vwx9HigIugTFsOrJq4ccCMeglK8KIzVV2X6oUrPq0ttYBN4xjwCQt3udNGn3y2+JkE5Z9dQ2wZleRfBJjLtmPbph8K5zIKiZNXJl6ev3RTXFkCB6RLZbrAmDlwX48I1OfH3jiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=xu41qmqd; arc=fail smtp.client-ip=52.101.195.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="xu41qmqd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyOEXdfCBp3T8Rq05QNSBOxAczkbWDOGeq80/PoSEzN0Y+ZWn4dVtSUYKPcO6JT6B37GFCDyXVlfjp0ldFUMRgBadOgTNzbcoMnUnQP/qDg8UDUEbQlaN24bPMm3D/iVLnDoDlVZ0ihzTJ6r1a3oiRe4zQh1jYZ3qBOQY7gf53q6p+da9R3kfgnZwD3zUsFD5mUuUyFHwWcbY43cRElIvl+SmcqMukzqd793ytkjyJYdvZJjSN2zfbjm/se6NV+Nzt9/VnxJldn2pkK+zAowljDklK0wksE7VbCQj2/jeEWqwfPEfmKPf/uOVlRKz283K+UBl4SBA5OpYhPXKpmBjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X98e94RtKJNgHJqdimhJnpAzy/32rRdTwUupsIcXaMA=;
 b=uZ8jsztceU7Cl+M09pu2GmPs6JHzukYVU7J7qI1PhZhsd8PPro2OUFDI265BHAjTezOvN9o3bn56bA0wJc2MYy4uIyweKRtHFIDZjOLSJjFE6Yu64u/05scKDb/qtSIT7d/lzvHRPrya9+KqybkSN+skPjQpGXYZ0CftVGMgHGp2FBVM2DycE6rbWWBMS0RfJgW1H7y/fS+WEvG04tz4VD+3rwjSONz3yeR8cMvv82qxlKzY6HegpS6bXvYbo6R//o2vkJ48HQC5LxPWNFYEUnXqvcT1vtLQuGppLtGxIT7AAS/H9D8HxXWE5yWVXVIwfMCH69FAEmQRF4m6GjxJtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X98e94RtKJNgHJqdimhJnpAzy/32rRdTwUupsIcXaMA=;
 b=xu41qmqdlec3ajdMM3+gvHo3/d8X0hZt30Fnw65dFxnLrGicSNP8xk3ulgQylO+nKkuzo8ZFT2IahMMiL/EAcSeP533j8nFNvIkCnF+ofaB7wBqB/6YD1KiVgBWNqULwwRpGTmYWLaOnC58AdMEVVJlNqFffsbTR/JR89cJEj+0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO7P265MB918778.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:607::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 12:24:46 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.024; Tue, 29 Sep 2026
 12:24:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 13:24:45 +0100
Message-Id: <DLRSQRUVOGT2.10ZY01VEJVHCE@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Georgios Androutsopoulos"
 <georgeandrout13@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Jan Kara"
 <jack@suse.cz>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <linux-fsdevel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Al Viro"
 <viro@ftp.linux.org.uk>
Subject: Re: [PATCH v2] rust: file: handle fd table teardown in file
 descriptor APIs
From: "Gary Guo" <gary@garyguo.net>
To: "Al Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260923022339.3340694-1-georgeandrout13@gmail.com>
 <arThye_219ruNbM2@google.com>
 <20260925-stellen-brummen-festrede-266af0305ac7@brauner>
 <20260929044843.GA3909609@ZenIV>
In-Reply-To: <20260929044843.GA3909609@ZenIV>
X-ClientProxiedBy: LO4P265CA0136.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::12) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO7P265MB918778:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dfb44db-9cd9-41f8-33bb-08df1e24a5c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|23010399003|6133799003|4143699003|10067099003|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	693TTLaBEzVECKj8sxGgEDa4xAuH67U9cg2riKDC4lQbZSL+mPGKW5W5kaQVP8XdDU1YKztT7/prkRRFTKRRmAPWgg0wUdy73JKoMR3uHAa1yRVmKihcZCpuydjrRaaV7nrsOJ4PMEmDK6bBpz3G+U/Wr2X0YaZpWoIF14B1UhSybyNcL9qff6WRp1O2l7yw89q4HwpkDEcaMG1aJSX25r3n02ixnTxyu7MAVegSG6e8Ijbzh9lhFxHNg+6S8i3pnW+A4RAZkEIkFylsJfPKl5+1O9/dZTvHQzbPrhlLXNedSDUCyQR59uV3t9620QfgKvOIf2asLPIPbj+8qEbridDv5s8QGqpE1QsWxikvE0UgVkzhF7lrDSLkdmkva2GN1hf4E9U/c79ve7H4UPGMJs4U+NQPI7r6f3ZbWE9xeNU5iCV6VPoFxUk5Ukl6+Fe/VvqAn7C+A7TjJXKK9cShv7ZKvyUF8kb1DTzzacoBua1UvqVkoep8zM9r+k4DMCQ3p9KQ/Qz7mafka8qkGzz5hBH3e1hpcoVtvGeBmPs3RXcB7sh51WioePLFtTJ4CBPibK9t9nHsxjqmP43sRwOFdYkPxOuYXHitFxuB8x2YQpXukN+Aw682fI7OnUnWCWkTWCqkk6A5RIsTBqoXtlMS0EqmqHrXzLBwlTJu91048j4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(23010399003)(6133799003)(4143699003)(10067099003)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkJ0MzNGaENpWWNMRzBFbkk4K2wrektFR09sajk0T3BoQU1DVlhxRTE2YlZD?=
 =?utf-8?B?anJ1clJRUys5aGpJS3Q0djdWaHIxaEJQbDcxbEdMQ29XZW12amhvWiszTlVr?=
 =?utf-8?B?KzUxR2NDeEN4eldteWJkRHdrenlvM2dSeEJ2WXBONzQxNEZON0tSWEkyQkpN?=
 =?utf-8?B?NnFoVHVETFg1M21aUU1PcS8wb0dqVEV0UFpLMGpXa3JqY3EyYk5iUGtWekJr?=
 =?utf-8?B?Sys5eGhTU3J6M0JRQ3NyTWwxVWpoUndUVmsyU2dBbFJMbHRTQlBRSFRlc1Ur?=
 =?utf-8?B?RnBHZ2tkaXlKNG1TNWIzanoyRnpyT1BTRTFlR0FUMGIzV2l5MnJvTHRUdXN6?=
 =?utf-8?B?VVo2dTE3d0lJQnNIQTAyR1RJNlV0a0EveVRGTlVETm03UjlwYmtURi9DVlQ3?=
 =?utf-8?B?ZEhXd2l1R25aQVI2b1I0ZG5tQ3prcy9lOXNEZ2RWRUExL2dMVXdtMzBLUVk4?=
 =?utf-8?B?ZEp5S1dOOVJ1Mmd5SWIzRjl3MkZZV1B4dUwxTzZBSnFoOUFwVVZ1VDBGd2RM?=
 =?utf-8?B?YWtUNCtxbWt4Tng5RjJZNFFxazJ1TlhiQnYyekRYNW5OZ1B0VmNram1XU0JY?=
 =?utf-8?B?TmdkYlVTQURNQWZMcUszU0daWGhWdDNtVVd1c3JpZHhnQWhMZGdRWWxoUDkr?=
 =?utf-8?B?YVpPVnp4a3d3eXlEVjZyOHJLaVp5anppaThLSHJmS2NmVnNWTkFvQ1MxQitX?=
 =?utf-8?B?SU1NZG9VYVRJNXBpQXROSkZvS0dqUDltY2ZKcFlaMm41NUkxZ2dML3Q4bnJp?=
 =?utf-8?B?RVdMbGFRM1B2eVN1dFc4ZXV0Y0I0OWZhM1p4ZytyRGpmRXVCZUE0dllJWEN6?=
 =?utf-8?B?clF4a3hqV3pTYjVoMXplODREL3NEQ2VDWStubXRpYWJETmRtN21vV1NyYTZY?=
 =?utf-8?B?NFErdmYzdGMwVE9KTnhZMCsvMHlOSkx3aXIrY1pOYVc4UEIrMEI0Qy9YS1pL?=
 =?utf-8?B?MklOR2xDSDErdndQMnVidDR2d0pBWllSY2p2R0tFYkNTK2pzU1MrSXJVbUt5?=
 =?utf-8?B?SHY0Y20yd1pJMm5DZHhpUFNaMk52cDZTb1FUcjJFL1J3TmZtczNjREYzVHRC?=
 =?utf-8?B?Z0N6bHpOVnZubk9KdUc5TkdGQno5a3dUNFd1U3J3YW9JWnNYT0UrSStUWktY?=
 =?utf-8?B?MFlxSWFLSVgxMStSQWlGN0FhR3JiL0xIY3NFbGtOVkcrRUxZckVnL1NrUVRy?=
 =?utf-8?B?Q0hBL0VHZ0N5ajhmV0pQdUhKMk5ZNTBqbnovamkwZUNWQ0F3b1JJajdFRGxB?=
 =?utf-8?B?QnV5T0JDb0ZlNFIrV0h6UGYrcGI5cXMzYjlXckxjU3VhdjI4R0h4L01qRER6?=
 =?utf-8?B?aGkrS0pKOTA3UnRkNlZtVFY5Q1p2TkJGU1N1ZzlnbFlRR0xFUGtSYjdvYlVr?=
 =?utf-8?B?TVI0aExTVE5kTGw4emExQTc2WktCQk1MMy9JRnFHeDVNckc2SGJhRDhscE85?=
 =?utf-8?B?aHlwc2dEdGhCMWJ1eVBNazM0dG1MSVA5NHNXRm80VzZYZ09td0F1VXJKeFB1?=
 =?utf-8?B?djVKRWxKcmxaZDNONHlWZTl2RDV6Wks0WGlvMnJ6eG9hMklDclpTdTllQ1lN?=
 =?utf-8?B?SHZ2ZHB1VE1CZVcvR3R3b2pBQWp0OW1EVG4vZ29DU1N6VDVYU3NLV0tSaWtN?=
 =?utf-8?B?R3djV0toczFFS2hrdFYyNmd5OVNjZk9mMmVWbHgyaDZocFFOQ281bFYxR1hl?=
 =?utf-8?B?TDM0cU42T1d4KzVNVHJ1VGtvRTdiK3VrakpyaGswTjNrZ2lFUlFkakhnQ2c5?=
 =?utf-8?B?bVo0SzhTNUNxQ2FKU1NYVzNlN1E4eHJTeGxqSGVhYittRnhaU2d6WGMxNCtz?=
 =?utf-8?B?YlFMd3BIUXpjU2J1U3g1T2pVellMWlF2RHJDMitSN2JXWE5TZDFmYkdNaWhI?=
 =?utf-8?B?T24yUjdnR29TNk9ETlZGWVFlWWZiUmZVVjA4QWFyNFJVVU9NUk1aOTd4VjFL?=
 =?utf-8?B?VXJKM2h4cVMxcDJQMndOMkNVOWsxdlNqRENEUitnMDFidkw2UUV5azZrV2pN?=
 =?utf-8?B?WkEvVEVwYWNITWlMQ09vMWxQZ0hid05FSVR2R1NlTHpPRjBKNHVqUmk3NURx?=
 =?utf-8?B?SG5RNjJnbG1GTk4vZDBwdk45djJ0Ti90TXhqbE5zb3piTlpHay82Nlk1RGFt?=
 =?utf-8?B?dHRtdzZTZmMxTjF2aTBsUjBJelBRVk44b3A1eVRTY1FwendYdnZ4SEpTQm1h?=
 =?utf-8?B?WnJCOHZxQ2xsVDBtVm9Yc01MYmdYRXVNYS9aajdyQVNUV09Ldlp2Ty9nSnkv?=
 =?utf-8?B?RGVDUW9CdXBIZEJRTzVra1cxWmJKdjRlZFN1OS9DUzNMb3pJU3FHQlczRThz?=
 =?utf-8?B?a0lJb1NLSlhVcUE3eEZoU0Z4OTVKb1U3b3UrZjJnN0JCS1htZ3RlQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfb44db-9cd9-41f8-33bb-08df1e24a5c9
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 12:24:46.0052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g12fkrzC4U9uVS6uah8QPsFdoLcjmhZ090VXRYevxkWt1ZC0bN+u6bsKzlyBGVe8wzAxvdgMnSuVuiHParPKkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB918778

On Tue Sep 29, 2026 at 5:48 AM BST, Al Viro wrote:
> On Fri, Sep 25, 2026 at 06:00:42PM +0200, Christian Brauner wrote:
>> On Thu, Sep 24, 2026 at 08:39:37AM +0000, Alice Ryhl wrote:
>
>> > This looks like it should ideally be on the C side instead.
>>=20
>> Where is this godforsaken broken code, that tries to fd_install() after
>> exit_files(). It is _a bug in the program_ that is not something the
>> apis need to work around.
>
> 	More to the point, papering over that at runtime is wrong, and not
> just for modifying descriptor tables - fdget() is just as wrong in anythi=
ng
> that can be called from tail of do_exit().
>
> 	It's exactly the same as with "what if it gets called from an
> rcu callback?" - it's a bug, that's what.  Don't use these primitives
> in such context.
>
> 	In particular, ->release() mentioned upthread should not be allowed
> to access _anything_ hanging off current, not just descriptor table.  Not=
e
> that the last reference to an opened file might be sitting in an SCM_RIGH=
TS
> datagram pruned by AF_UNIX garbage collector; as far as the method is con=
cerned,
> it might be called from random thread.

This part is protected -- we mark FileDescriptionReservation as `!Send` whi=
ch
prevents it being moved to another task. We also take care to make sure tha=
t
the task returned `current!()` is not allowed to be used outside the curren=
t
task.

> 	If it tries to access (let alone modify) the current descriptor table,
> you have no memory safety whatsoever and checking if current->files happe=
ns
> to be NULL is nowhere near enough to resolve that.

So at least for this part, I think checking for `current->files` would be a
sufficient protection for Rust code. If we don't want to add these checks t=
o the
C implementation, I think adding these checks to Rust wrappers would be ide=
al
until we figure out how to check things statically.

Calling fget/get_unused_fd_flags is still broken code -- so we could still
`WARN` on them.

>
> 	I don't know how to express that gracefully in terms of typechecking -
> sure, we could pass an empty token to each syscall, have fdget() et.al.
> require that as an argument and propagate the damn thing to all such call=
sites,
> but that would cause an insane amount of churn - if nothing else, ->ioctl=
()
> signature would have to be changed and there's a _lot_ of instances out t=
here.
> And then there's the joy of dealing with ->sendmsg() and ->recvmsg(),
> thanks to SCM_RIGHTS datagrams, again (reading descriptor table on sendms=
g()
> side, inserting into it on recvmsg()), especially when you consider the
> fact that ->sendmsg() and ->recvmsg() *are* callable from contexts where
> one shouldn't be allowed to access descriptor tables.  None of such
> call chains is going to trigger descriptor table access (e.g. knbd is
> not going to try and send SCM_RIGHTS datagrams, etc.), so it should be
> safe, but having compiler prove that without inflicting overhead on
> the code paths where it really wouldn't be welcome is not going to be tri=
vial.

I think for the simpler case, it is possible to check it statically by decl=
aring
some functions to be only callable from "syscall context" and define ->rele=
ase
to be not of that context.

Best,
Gary
