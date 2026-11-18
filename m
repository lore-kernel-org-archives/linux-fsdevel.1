Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.98
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794998984;
	b=t8P5S0SdSvgkNHwA++mGSrZj5AE5EQL2IqUzHlROy0fgh3PwSCrjM7/oP1Ua0UC+7x4w
	 xL66nG9vvd0ZBMaAh0ZOfg28ScYPP3AUhP+YlCZG+XhFL4biq9M3eqpX9r7Z9zYW9RXxg
	 tm4EB8hYdeai+cYtal0Amc83Wd3zzQ9BvPEcQ+22EHnzcGIZvedoZ9dZK08kqnlybNjZG
	 L7VfIecdtynSnTcwIHS3dzjwmWUaQdRcsJe/MNWtREWVlL0Uu+lQI4VydS5IiNyyQV1au
	 9dVjHButDgvAgZ7+QncqH8kkPXb3eN02ldddboUEM3LrlA6NvQ68RA+WUzjfIHY3wIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998984;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=0N0VCk6qGseQDYOD1nFyF4R8YC8T03HFFPgyQHBAtgU=;
	b=R4FHj8akwK5RAdaTLJ13qBl9cWz/b3TjMMGoN1yNEhx+arfnOyK5F2rvy3mJRkT6lfvo
	 +11gu7hEwHwIiMIN+Zu8a/5ebTwcsYxz6qCXYYe6X3sBxW03B4KJtKiAt6IyCX1szl6iM
	 ggr41+kjYquS52kPJL5bWSGbBvahE/8EJoUMD5z3iX7oGeDbmqs7ZwyY3GQhxh8d9/eRm
	 CRY/bKcRy/aSxq04jwh72ORH+lkrjvLTqjmJG5a+hSjvEIDk2TrAVi0zqzcXXZRjaHUm9
	 BtXFfSKqZ/O503ByfC4nkcpvRWzuqkdQy7RKklDocEb+13PlakodqtIr+w4fPdfwQgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=YM5nRmQo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.98
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021098.outbound.protection.outlook.com [52.101.100.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507AA606A31C;
	Wed, 18 Nov 2026 10:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 507AA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=YM5nRmQo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVjeXIRRGgoa122cTohl75Rc+GVaUpqrYiKak3e0QHPpK3ZzeiMyWJMkWot/MsIqBKBewN3wAObkt4UJgnKucl/lebHiLgGrS9vDFYcjiJ+uSqT5G8Fa2ZtWQBRE12mosgzPbjRiUPiD48YE1HcSq8LQQjjanBbww/sFcpwgRMvZqe60sdIY/YqN2rbheNuxhUGM3tfg1439Y/jrM2wlwfDVXSd5CmXLRMwWiAVK/b+kToczKMWeHGB2vqZiBsVRtaR5Fs+h+7snExe6HLpuNzZBeBuJp13tCtJg14YT7ozrdzF4EsnmZlkfNIOFuFNib7dWkefRByCXDL4FeCN8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0N0VCk6qGseQDYOD1nFyF4R8YC8T03HFFPgyQHBAtgU=;
 b=GeRuuiOWEvFTpD1pHEQ9lBsxpZGx/zKbTt2rjv6stKJbit8rhjgcjBeJhp1sOPt4TZARrayToaWtp7wN5zoY/0JfReDQJcMtMSDz90LEHMqz7GYv1XsJ32RTTXJOL0mko0uVlYkV+dXGamQhXKEtVwUALZjSTXvstdMtVg4cIIXomOgmHW3O0R89YdSuSPdP3MaQeOl7bPNuJNozl4UIJFXUibCSpp7jJpJLxHTndZLR5+5ZAdTrKy5dhrE+xn0dISpVCangmuk/IeeVrtf8f0nScAsOlGfcmG/WIM7x/PjmxAytGSpj9yyZkZRsbXJWr25o/BNN8zcIVtBWcjaPdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0N0VCk6qGseQDYOD1nFyF4R8YC8T03HFFPgyQHBAtgU=;
 b=YM5nRmQoOADo0gqBdKK2Dag6W33wSMVp4grWByO/yIo3oo8rfNQyhrXHPmw9VW1ceNSSthXpWpFHfigzHANebT9buQKakSmVok81C6Ix5fQDSTxakvCg7VZds2gTK+Jsdcyk9nbyW3B3uqzExYR3rdvJmf1uM2lRpQH/WS0Y3d4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO0P265MB9132.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:49f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 10:49:41 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 10:49:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Nov 2026 10:49:41 +0000
Message-Id: <DMYA181VNBAH.MD09J2MY28RP@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] rust: sync: condvar: add non-exclusive freezable
 waiting
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <aliceryhl@google.com>, <lyude@redhat.com>,
 <daniel.almeida@collabora.com>, <work@onurozkan.dev>, <ojeda@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>
X-Mailer: aerc 0.22.0
References: <20261117001507.1611984-1-dakr@kernel.org>
 <20261117001507.1611984-6-dakr@kernel.org>
In-Reply-To: <20261117001507.1611984-6-dakr@kernel.org>
X-ClientProxiedBy: LO3P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::14) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO0P265MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 489991c3-e535-47b1-ec86-08df4561a686
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|261009223027099003|18002099003|22082099003|261026121527099003|261021123027099003|261021121427099003|921020|261022105027099003|261028144727099003|261102123227099003|56012099006|4143699003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	4zRwqBIf18I3Pq18A1c6wqHXbJNQiWfMnvhsiqYJUnbf7088gpvuwahJirkMgw7lS+nyNe5J3vWLeHCAXe7FBQbQaA1fSld5WMZf0mlQbtYUEYohd3ThWed3kj0oBrdILXUJ24z8HvOxYj4IHfzO7pHtxiTvsb3PZlHDjVt3auq7ekaN+YGv9O1lK3qbVrGIrAydN7gT/cAHN4LTCVzqXxAitftjr2dZZjJDsNBgfTKDXdvDDpsGQrXT3sw8VCF66te/Wzu5ABmAzFNlm5W24tk77ESvuU8jAFBzZOlcHU3oAS+OHs1lkdJV4p8zbs9QNBVlTzVEK6afJgB/iaN8lxdly0S7dyi2J9K6efel3CHSYPm4HZ2VM6uWRKd5TSeYctYEn4vfYbSQGjyl2OctoIKMq7ZdvRWovo8adyVgGaXsh0V9A7Oh9X6rjMwX3O8bcROW7hkovg/5Yc1MBYKZMvRVRGQghp6hEK8JztS65XOM/RPfxH2X5c6Qdc8A2y/sCzhFi6d2Fw6cFZNfDSHPuI+5+COKITB1jz2J0f+faqgPC7bRGl56jt6rLlorz5chsaJ82lPV0oYfzITnuv4NGeu1XlJAe8D76AMrb9Db2n0T/MfQsL4EhXlvyEUXjl7DkIaj+ucBSfUECA2BuQBDsVKlORrtJKofmuvueRgO00GXQm+ybqP7YzkQKSYQ3JqgGvyGbGyQOcEk/jVhR35y2Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(261009223027099003)(18002099003)(22082099003)(261026121527099003)(261021123027099003)(261021121427099003)(921020)(261022105027099003)(261028144727099003)(261102123227099003)(56012099006)(4143699003)(261026140227099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVJmbmxtRFkrWUV0aTQ1T0U0WU1NZEJoZHZtYVovcmRlS1BDQkJSNi8yaCt2?=
 =?utf-8?B?Q3VZSWtmODNnNndwZjNkMHk3cHIxNHNUWndvUmpRUGM0WjUreCtYSUZ2R2Jq?=
 =?utf-8?B?N3R3OGR4eTJ3WjhFQTZneXkrTERzSnNWQnBqMFlubnZ0c1VRR2VkRFROa0pq?=
 =?utf-8?B?Wk9PSldLUjl4VUdNVC9NZGNGU09URnp3eHRQNXVOTUplQ1phNGtwSEs5QTND?=
 =?utf-8?B?RVVFRDlyUEhjKzVBWXVNSjBKSkRSSkZldzQvL3VDUVVyVkZRYU4rRWdLRTdq?=
 =?utf-8?B?NjVWdXhNNXRUQVBEclZJekVhejJ0RThQYnh1VUdrUllXMkgzUGptWUhEaVh1?=
 =?utf-8?B?cHE0U1ZNTERFbHVmOXh0cXhmR1E5YnJyeDV5VERkNXBTU2c5Uk5FNG1XSytz?=
 =?utf-8?B?b0QvOTZ6SFp1QitBajFLTEg4WWtDenVpTklnRE8rWmo3RlNxSCt1RlVkYnAy?=
 =?utf-8?B?dS8vbFg0QVNGOUpVL2krTmJwVWRKOVkybGRHVWNBaGx2ZCsxdjllL1VhMTlU?=
 =?utf-8?B?bVNSd0ZlRnhkaVMrQ2RpVjcyT1EvUEhBQVdQZXJ3NDNwMG5udXJ3VlExMktT?=
 =?utf-8?B?MnQxa2dwNjhIUkkrT3VYZ2hhazBURzdVcmVuaUtJWU1SVllMeXNMZ096RmpC?=
 =?utf-8?B?UFdHaW15ckpCZWRiUVZKcHdDSFNCZzNMRHJweGZQWFo5eXFlOWFGWktjRC9v?=
 =?utf-8?B?NkV4UE1FR2Y0VnAwVW9KSENOWnRPQStwclkvV2k4V2xPWmdLMkJHU1V0clhp?=
 =?utf-8?B?YmlzQzlWSGc0bGxKK2RkZTNpWHB2QUNOUmVrRnlBK29ra2p6eFI5M1dXWWZk?=
 =?utf-8?B?ZnlYRnN4VTcxdFhCcDBQTUZGVGd5cFpiVU5ZZ2tjSHlwaVVUbHhxdkQrN09J?=
 =?utf-8?B?TDEzZFQ3ZE9pV1BSWFo1QkprTkVIT3RKUEJiUXpPcHlON2U2RFU4YVZhdDJC?=
 =?utf-8?B?b0hoeXVtVzBMdXRWQ3d1ZklMMnNzUGpZTWFBQWJ1aVJoMTZTanJBZW9nYmdm?=
 =?utf-8?B?ZWZmcy9GSVFoVmtSQ2l1dldNaFMrSW9wYzkzeUREV3c4WWsxZGpXeVhRanM5?=
 =?utf-8?B?RVRQckRHaHk1U0tBRDhISi8xc3M0Wlc0V3JaYWM1YlVwRlFNRVNDT1pHUlFZ?=
 =?utf-8?B?NE5WWnk1MllGZ3dDbmRMTU9pbHJrdFFtQWR2UXREMlI5ZGtVVHg1cjRlU0hD?=
 =?utf-8?B?N0wyZEg5SDBsTDdMQzRaK0FHeFlicUlOV1llTHFOVmc0OGYvNExtR2tNWXpN?=
 =?utf-8?B?T0R6SUFWdWN3MjJPMlg4UlIrWjQ5eXlvZGk4cGgydXhaN3pPbjZNRlRQUTJi?=
 =?utf-8?B?bUE2K1lEMjZnclBzeTRQR1FVM3MyT1JHZkUwTEZKWWVkNlJXdmw2djYzemZG?=
 =?utf-8?B?VDE3b0NCU3BhcUo2ZlNQaDZQQk1YOTlyeEcvRlY4Q3hSUlJBMEZ4NWgwWmRO?=
 =?utf-8?B?ZFgyb0lScFVybTBSQjZJamQrUGVpWEZNdnBRNHJPc3dTSERZc2tVWk0yMlFz?=
 =?utf-8?B?Q0RYclAvMitvR2V0L1NXdHcralJOc1RuWGlZem9MMHZFbW1qY3Nmd2NoY3Av?=
 =?utf-8?B?cVdqMUNkaG1rNmpicGJNOGhlaGpYUjFFckJEQk90OG90V1Y2cnZOMmZsN01k?=
 =?utf-8?B?dnhOS3FmRytCcW5KWTE2VGlBOG1hM2RzNElmM0hqWTFJelRIRlRyS3BXWUpE?=
 =?utf-8?B?c2FJcjJyN2tnSHVoSUtRNWNQVTkrV1NsZ3JSaC9zT0lieGJUUVp0WGhYdWFB?=
 =?utf-8?B?SEtTb1lZa2g3UnJPbFdhUk1kSFI4N2NweC9GRnZZNHMyeWl3ZWVMczNMVXRt?=
 =?utf-8?B?TUJISjdBNnAvRTcyajlCdTZISitPQUZnbllVUVl0andhVlFNRDJLMlJ5Vllp?=
 =?utf-8?B?MmxxNWNzT0NtSE4zR1hFVG42MnRkcTNNU3Y4bm44VktOYnJhSGRjMkRDS2dY?=
 =?utf-8?B?bnh1T3c5dXM3R3NaY2dNcTVKK1lIV2tQOVUzcVdHZGVNUkM4akV4YUlGckQ0?=
 =?utf-8?B?ckhuMVNIZ040YmVETkRhVSsyZlZDWFNoWUUvTmxad2dSQXp6RndIM3R4S1hY?=
 =?utf-8?B?REFnOWgzaGxwZmR4Y3V0RjRxUFpadUVaTHo5ZHUyaDFXT1NsYnFRSmhHeGFu?=
 =?utf-8?B?c3VlbFBnTjh3c3IyM09Db0xMMDl2SlIvR2xsbS9obVJKS1hyZU5teGgrTmxz?=
 =?utf-8?B?QVBQckNZN0NuM055cXo5TVVXemNQTjhZS1NBSk1KZGtNeVMzV1hFWVYwVkZ6?=
 =?utf-8?B?MllZbkZMejBKUE93U3pmUXRJdU9YQnAxOVJnVW9pOXY4d29rcW5PaEFtZ1Bp?=
 =?utf-8?B?OURsdzc3Yjg5OFI2VTBaL0hGcHRodTR0ZHdNYVQxV1JwL2l5d0U0UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 489991c3-e535-47b1-ec86-08df4561a686
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 10:49:41.8969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WrXfBNvAXQZxf97qiEvYdJVQ+EAVXU9poyB61gjQ4EM3muZWi2T9ppAtdOYl8X+EfWfv6UNJbet1Mqfqrs9vMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB9132

On Tue Nov 17, 2026 at 12:14 AM GMT, Danilo Krummrich wrote:
> CondVar currently registers all sleeping tasks as exclusive waiters.
> Add wait_interruptible_freezable_nonexclusive() for callers that need
> non-exclusive waits, using WaitQueue::wait_once().
>=20
> Document that notify_one() and notify_sync() also wake all non-exclusive
> waiters.
>=20
> This provides non-exclusive waiting support for a subsequent Binder
> conversion.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/sync/condvar.rs | 29 +++++++++++++++++++++++++++--
>  rust/kernel/sync/wait.rs    |  1 -
>  2 files changed, 27 insertions(+), 3 deletions(-)

