Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021088.outbound.protection.outlook.com [52.101.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A1032C8B;
	Tue, 22 Sep 2026 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106922; cv=fail; b=sYRJ4hE7wzZEC9ym0omZ9fcV2Pir/rJiDtEgMQ45MxV+G/HJi+gJ+11nJAk2PRlAHGgxtQIdUcgowY0vl2opejiaXXUyFXFP3IyUZuYyV884PclTGS9S16oE3C2NgpXHZF9mKWobLzStgS7FrL0nk1Xwf5vecrfGP6wyyyLplzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106922; c=relaxed/simple;
	bh=mSfiDhcaXgwpyCg+UT8M4nh3dWCLRe73ZbFKmdJ+XCg=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=T8TZP15NF9rn1/JWdy8Nr7RcGB3vmYau7oSYvm6PhgU2vogMqOL8LFjeVLjwBVcHTwlIXDbJcJoW+uQzmc2VBeydP7c6N3QZ6TXUJlammZzQEucsDGz3GrR7iZa1CE8lFlzdLg8JpLsA7/6INOnh+itWM+6P+UVV1I1HreCcioc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=EPECTbpU; arc=fail smtp.client-ip=52.101.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="EPECTbpU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlrtILow7QFwPV3AO54Ige69Wj3NqUQMrsMx6n9m46T/SYu7eN45nQrOf9ptwFlVyXH8NnrNGXF4j2CcGcGu6VXaFgDulRbV/PJMTA1v9ooh0y/7urdOYPPSPHY6kp8n0an7Etmdc2gwIXNTmzf6PEtzmF6gbf4rSQbOZ0ctidj3l6A5brGuaWhF9K6qQvCd/XA+ALo3qRnu694+2UDW6iBJZd589OZ/wB0gf94eTPqLPj4pCaevIlyYjxArs4z+ZJlANX3cLjIOqIeAioTRjvuniIpxmx4ngj/wMKsKr28ntrc1ng/nWHMSpGetrdkMt7b/iReCcS+8mwWm4VWfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSfiDhcaXgwpyCg+UT8M4nh3dWCLRe73ZbFKmdJ+XCg=;
 b=MKOpCxwgV2Ma6O0azgk33aCMe+7lq+IBAPxA5kKdZ5n/4Y4HnC1kbI5QMtzsKOHSu5lxprZVAdOvCMfOb+jHAjXPaxEciKv7Sl1CVXWFCusYfsXvasA6QSYyRlpgRmlv0KOik9jo2pOSjlFnkmRJ4pilMu4ld9lJtOybZ8HuWMeSN7SYROrfLnZWUJ03r//dophV++4nEOhFmCPZ5X1cZFQi1Teei4QHDuTsXF1vgIFjBCq4akMtiC+cmUtrtZVdbFqSPfpWLmX59dgA95mzv4YfHKlpYgKVtARiKMWU5GR466kn4PWTDAiLFGedsn0WVcAv8BX9MayWkkYupPFfhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSfiDhcaXgwpyCg+UT8M4nh3dWCLRe73ZbFKmdJ+XCg=;
 b=EPECTbpUkUG+DuoppqhReDH0zOZV2UxI1SDRvih3bJDL0S2J1ju8FnzjPUr0kfF0dSpLIlK8qdQM7NNWios3zOeyyW+KPiAhmwBaF9ncTLakMMt6RzUD1wr40jMTBXUpW9dm1HwEr+7z97l7M8ePlZFWdgbs2lCy3xH22v8kws4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB6341.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2d0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 19:55:17 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.012; Tue, 22 Sep 2026
 19:55:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Sep 2026 20:55:16 +0100
Message-Id: <DLM3XWG7NZM6.1B4YP1MC0E3OV@garyguo.net>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Jan Kara"
 <jack@suse.cz>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <linux-fsdevel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: file: handle fd table teardown in file descriptor
 APIs
From: "Gary Guo" <gary@garyguo.net>
To: "Georgios Androutsopoulos" <georgeandrout13@gmail.com>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20260920200154.1194983-1-georgeandrout13@gmail.com>
 <DLKFTVSN56P2.2NHCFW6NIUOAH@garyguo.net>
 <CAESH5oeuKoDyr6ZcGR3Fa+_nPn+ceg9PbqBXoXjRsstaSKtJtw@mail.gmail.com>
In-Reply-To: <CAESH5oeuKoDyr6ZcGR3Fa+_nPn+ceg9PbqBXoXjRsstaSKtJtw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0533.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 18839801-93fb-4066-8469-08df18e36cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|10067099003|6133799003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cpy30xSkzr16CqyNd/AiRSKRu7Pjw4LcjHqeQGiHz00wtUbaZG6DDcmry1AtOZaBXCKyrau6senoS12q7gcb//KtYm7SU/gwmh4xafEC0GxCVYOh70bU7VHVftiMksMqBK465kOrAjfNUiftf7s7hbnVdllaE+uUBV+Nv3xCmlTkWP+rPbmdrsm4ASSfB4YEnDKcmpp61pW6n5ZDooBPx7xsna9Kc14hHV0ZF4z/JaSDAnbOGGwsC7L8jj4elysf18ioO2DQpvQz9cI61dY77wk5PrywpiUHLI6f/2Mxr3RZWNRh09ULE75sCuSzMgV2ZZpvl07S7+tnyhKavdpgppMNe9cIy/15juc9Nty5WsCRJyGP0z6uDirYCBxUNmTKpg3GwNUJ8p2cF6ubNznmDA6kMWqE1CwMmCUkHmY/P8IIi4/K2CKkd3WxlleGbu8JEe6ehV9arbhluX7bar3GVPFr8kF3hIRmGMZ4J7I/vEIS07fMttLSWnP08yBC/PThhSVol8/Cs728jrQNWSh2ypA2084tX48Y7Tdm0fFuHUt7wvH38Llz2f9nVy9MhbcGaaywYW2ZXmvkuPD3185kCsgs7NDdsDXuPtFRgBuLEr/ERoQYxAUz2Xl32pbaGgQP3mIu5ZUdR4Bnzrz6NZzUnnslvQ92Q5kIC7SohcpSbXY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10067099003)(6133799003)(56012099006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEo4TTRtVnNkTWFGWFdDTFhMT3FVb01CSk5QL3AwaTBGMlNpWVBrU1FKOHZT?=
 =?utf-8?B?ZnlSNUk2NUhsaEUzZFIrNmQ2RGwwbUg0Um1hYnpuTUNCd1ZwbGcyY3h4UUxF?=
 =?utf-8?B?YS90QnRZSWhDMlNzWGwzbWliV2tvc21UQmtyNFBlT0pVSmFUeWUweW1vbmRI?=
 =?utf-8?B?UW5IK2pQeE5ZZnlCSTlUajYvWlpOUW9PeElCZ2haejc5WmNpM09aQi9XUFJI?=
 =?utf-8?B?bU9jVE1FM3FoNlhZY0Zmd3F4ckR6ajBxNFd5Wi9SekVJR3FkNUNhakl2Y3NN?=
 =?utf-8?B?Mi96VFVUb055M0dZY3I5MFZVWkxxOW11WDl4czgrbW9CZGcwMlZvSS9rQ3A0?=
 =?utf-8?B?cEtvNzh6SHNOYXNQbk4vNWZpR1VoQkg0OUp6OVhWRE9XUUxSV25kbU5YNytj?=
 =?utf-8?B?eXh3UXVBY3Q3ZlpNS1lPSzFRRmRDRXJqYm4rMGsxRUE0QTRUcDY1dXA0RGw4?=
 =?utf-8?B?TWRlb1VqQlk3VWozNmtOc2Z4a1hETkNjbnovOUxUVzIvOXVUNXhObW5RUGJy?=
 =?utf-8?B?YXdBZE14NERDWHpHR0JjYnlaemM4a0JpOU1aREJxL3djckI1NXFaQkZrSUxV?=
 =?utf-8?B?T3VJdjFUSzJ1ckNMYm9ZV1RLVW02bWxtSFpHbnJiamxjSEFPYVRuMG0xTjFp?=
 =?utf-8?B?RVNseFpBaUM1cTBGYnNsOEN2SmdyVXhQeE82S2ZmYVRpVXhteXpiSi93NUZX?=
 =?utf-8?B?WFViZGM1cXdHVk8yUVZJaGp0K0pGblZtT2pCTDkxMmpCMjRUeGJMdEVVendi?=
 =?utf-8?B?NmwzQjg4Z3piMGsvQml0NFFhMmhIcXhrV2hWVDVCTzYydVg3S1laRDhCT3ZY?=
 =?utf-8?B?cENqVHFPUnlWajIzanpKUFdPZWJrUkZwN3hJcU5VdlBLaHJWbE5QdWdmd2FT?=
 =?utf-8?B?c0ljU2RXUndncUFQSHZSYzRrYTFMMFV6TkllVm54N25xWDJGdDFXWDd6RHdU?=
 =?utf-8?B?NzB0NU0ya2NaVy9XdEJCa0x4K2VXK3JYZjNsbXcrUlk3ZG5DNkJ6QXlsRS9r?=
 =?utf-8?B?OStvamZhL1ZvR3RQS0RzdWFnc3JHMUE1SllDQWsxZGNJYUNZV1FDajJteEJm?=
 =?utf-8?B?V1lNdVNmQm9WV1A4ZnZrZFhLZTF3Q1RXeFVPT0pmNkw1WjdoaEZXM1V0Ky9w?=
 =?utf-8?B?K1lCVDlUc25UWWpZak5ULzJvNGlVQU5UdFhJeCtweVYyenpmSEFxMk1EUUVV?=
 =?utf-8?B?M3FpSFRwMi9hVFBBdklSbDJGb05DMjBaRmR6a0hSakdmKzV1T2F2K2wwVU5a?=
 =?utf-8?B?cjZrZUV3TzJNMHhhcVhMWVdvTkNYTEdGT0plKzRJYkVZSHVLclQ0VGVJQUcw?=
 =?utf-8?B?UXJRek1WNzhQOEZLWGxKWVM2Umd3a2tUcXF4aTZlWDN1MlRRQ0w3dlJWOU1Y?=
 =?utf-8?B?Z2txclBlTUQ2cmhFU2dyV2NzL01IMkxQVCtFRUJQdS8yeGhnV3FROXhyVzBv?=
 =?utf-8?B?L21MMHpjelIxR0ZwTlFpblpKcUMxUzRqMi9wYmxnWlEva0RsUUVONndhUXpV?=
 =?utf-8?B?ZDZXNHhSWWdIUmRleGhuUEJhQ1VBNDNtbU5EN1hxa3ltTHRmeXlSTVVsRVVN?=
 =?utf-8?B?OTlsQ2FaaEdOQmEzUnloYXRqcG01TG1IbUhKVktGK0RkQlhqZWdzR28wMkti?=
 =?utf-8?B?TVZkWVo3M2JQNU5uUUhaeWZEZFZkTFVaaXA3dW9oem1KaDg3Zjg0aEEyN0Mz?=
 =?utf-8?B?WlBsc2hxS0t2UktHMTNSZG83THpZcDNMSkhtL0V6cVBCNGE0Y0d6VHhlamtR?=
 =?utf-8?B?c29NelRjdlZ3VkdXeVorbitibUFjYTE4bHBDMG9mZFJpZlVPSmV4Q0d4dXNE?=
 =?utf-8?B?MW9zNXA3SlRDK1M5WGRqQkVTTy9hQWM0dFRScmRJY2h1MlA2OG9pb2d3bGM4?=
 =?utf-8?B?WVRZODFVUEw5VmhTMjJkWFlBRFJHOVo2Z243bGtxY3Vxc2hJK09CdmI5K1dI?=
 =?utf-8?B?Mml0b2FaRXNWQXErK1Bna3pkdzAyUlFBRW16UWMvWkVld0ZiN2tRWXM2Z0I3?=
 =?utf-8?B?RXlZbVZxNTA1TWcxL0wrY3pnODkvbERrY3pMa2tuK3gxMityUm5iN3BPOU5z?=
 =?utf-8?B?d2NRVFBUZ1ZkZTZNT3VxMytiMXhnQkJPVXRRdldjMXlTb09ZeHV6YVg3RUNx?=
 =?utf-8?B?UGZROUdNd2VyNExXTmRrYUxJbnU5ZTJRc2RQUHkrMUNpS1dWczFWRTNLMFhv?=
 =?utf-8?B?dk51MUkvM09SY3B0SktidFh1WUhvc2lIUnMwNlM5cjJTTGd6ZVlPUVNrMnlZ?=
 =?utf-8?B?OVY1TUdKZXpEenQrR0xJYy9KRWRuNVpNT0YzVW5Xdjh0dHVma3ZvWnRSTmZy?=
 =?utf-8?Q?44b1o3WPXMFXUJQAHu?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 18839801-93fb-4066-8469-08df18e36cc9
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 19:55:17.2339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1Ma5NvlhLGBtix1mwNr838dvP3FN/UnyEdWwI53eXejXDgrkJGs2+0mYcYH8I3Ttxo3LVvFIOKnuovSx6/TaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB6341

On Tue Sep 22, 2026 at 7:30 PM BST, Georgios Androutsopoulos wrote:
> On Sun, Sep 20, 2026 at 4:48=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
>> I think we want to add `unlikely()` on them (which is being added by
>> https://lore.kernel.org/rust-for-linux/20260406095820.465994-2-ojeda@ker=
nel.org/).
>
> I checked current `linux-next` and `rust-next`, but this does not seem to
> have landed yet. Should I leave these as regular checks for now and add a
> `TODO:` to use `unlikely()` once it is available?

Regular checks are fine, no need for TODO either. Just bring this up to nud=
ge
Miguel to pick the patch :)

>
>> I wonder if we should upgrade this to `WARN_ONCE`. As code being execute=
d when
>> exiting are cleanup code, for this code path to be hit, it would mean th=
at some
>> code is installing FD descriptor while being dropped -- which is likely =
a bug.
>>
>> Putting a "BTW, some Rust code is installing a FD when process is exitin=
g" in
>> dmesg is not going to be useful to understand what's going on. We'd want=
 a full
>> backtrace.
>
> `WARN_ONCE` does not seem to be available on the Rust side yet either.
> `warn_on!()` is available on the current base and would give us the
> backtrace. Would you prefer using that here for now?

I would prefer `warn_on!()`.

Best,
Gary

>
>> I think we can remove this warning. Skipping put_unused_fd isn't actuall=
y
>> leaking anything as the files_struct is cleaned up.
>
> Agreed. I'll treat dropping the reservation after fd table teardown as
> normal cleanup, skip `put_unused_fd()`, and document that this can happen=
.
>
> Best,
> George


