Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022112.outbound.protection.outlook.com [52.101.101.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5CB28C2BF;
	Sun, 20 Sep 2026 20:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789937341; cv=fail; b=ThfnhBuqXYoAGaQj2rofzM9WUtmWtMescd6uAvEa6gRL8s4/91x5nTYP/w22wc/gtSOzwjYaz92LJtih3Nz/k2RPBlkzcRxCnRIQeQI69pcgKlHKH+xWjXS+UqZauA1c9iv/QOWN3C4Lgr+OiplfMInCf50PqwOSU0m/DT/X2Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789937341; c=relaxed/simple;
	bh=Wou/LctXAxXLmZEUn9Y3g/hwwaQSHv+vsBfrW+Q0XfI=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=V67H9mJRVR0kCB/SdoJk+F/YOXAzobkUHQ0F1AFATSjPHsmuSlHinBb5how/oosuFLLe4BdxuV0JzAABvS6/jqLO5R1f0HOZjsI3SsaWpBmdNcFOj/jvFueMJPV9sbYFpLrJucp/mY4yCLe2fC/iT3at5Lb52YqDqsmwrWog5vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=X5Nxtk0x; arc=fail smtp.client-ip=52.101.101.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="X5Nxtk0x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L7HQemByr6+fz7saOutTzsykuiy0t/WZjG/MCsXs1DUQWb1SaYnF2n7eaADgu+pBVwjndSs1sOu/GhqEVqBisn9cKocriIVzoc1vGUOkE/xN8VOZSVl8rGFe6lJV94NUGPyWeIMan8bwzdHNCmTOrB1d5BYFQEYwrP7cDGqJFvPx/EYv0PNra/hZq/GLMm0KS3THrBl+h7xni5+iXbH6i7V3FWW9aqwQ3ZKyAjN3oPFkLCbaPQUXVgFLerOZmUq3YwIWImNnTtnB+0/UzkCSmzA6ahHglI8vrBuRqXeRa5qUIfTFytJeuUuS8M9vWVdQu9B6YhuyDt0J0iUjmh88Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOg5rT3CZom4nQPK3RICU7zviSUbHNA2OvvlbvRv4nY=;
 b=J/1bca/f1/GF/oWkVYql9FYZhIP1ibSYgqJ7X0ZdpgsxM6cFXVtQFyDkW7WJXg4yq9EvEeUwQ7eUgNw6G+MPYKRSNSv7P4HEcUVLZcL5c+AQrOIp8zl++rWzGDYT67d/spLYI/Dua5maH/qckSf6XTL/Q+v1VKa0g1hYXK+Lp8YNR7uNepK85NuVG3PtTsq7JpU6GZ4p5op7vuAaK2OVkFTpieF2GISoZi0VMvfwwDSl1T7AvX8vzmZcTiGcoH8NiE7AVCgZPsiFIc0m4R9bc7NbktRgb+RRQa/yIfhawQWn97cyqczmHID/J84p1kR6SlJ7dAW1So/+L7ZpxosXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOg5rT3CZom4nQPK3RICU7zviSUbHNA2OvvlbvRv4nY=;
 b=X5Nxtk0xJeCcK9ipf2P8zhqXMOnkG2ZasTgEoJKR5wrNtrbUibWmWFRKs0aB7808ajzj3b47age6RKgfXtXGRRB5fZVnVw6kgFbrg+I6+ADWuLQ25bwGgIARGWySQU50mhYmS+cGkesHQk6bOlCoN6vUqL89BoXeOpG18z7+2BU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LO2P265MB2687.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Sun, 20 Sep
 2026 20:48:55 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0428.011; Sun, 20 Sep 2026
 20:48:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 20 Sep 2026 21:48:54 +0100
Message-Id: <DLKFTVSN56P2.2NHCFW6NIUOAH@garyguo.net>
Cc: "Jan Kara" <jack@suse.cz>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-fsdevel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: file: handle fd table teardown in file descriptor
 APIs
From: "Gary Guo" <gary@garyguo.net>
To: "Georgios Androutsopoulos" <georgeandrout13@gmail.com>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260920200154.1194983-1-georgeandrout13@gmail.com>
In-Reply-To: <20260920200154.1194983-1-georgeandrout13@gmail.com>
X-ClientProxiedBy: LO4P123CA0122.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::19) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LO2P265MB2687:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e9b3fac-250e-4ac7-e089-08df1758962c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|376014|7416014|1800799024|366016|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hmDl3mPGyyojj8pw4eKWPS5fPcGHc6rCIV+i3nnzFQLCRSQYL4duSOCM4xGOCdxTUTLvMcVqDvhik106ltJF3Xy1QzIt/DP7QUtmA2mxJMjvOcnFwtGwElFVGPHJcONQqd4rjqZqmJY41cVt0CijfJWUb5jJXMGupPV3GazgxL6oxPhyfLOoh/niMiJrTauz7HgMrhbfAtO6afkfT5bS6Fzpk/Ub0/Db61e84Dzpot3+Q7mYD/WblkHD1YFVdYoCh5yqhQbggVshvSGqRmwScDl7dKZp9lDJ0DThboCtqqnRhRB7ehS3OUTEfLjPa7AMjBSID/+OSIr541aiy1Rer4wLxwoILF7liyV5K1LjjiP56J4lyY9fXxPrLWsxTZ/WbVKYwMcAUmUQyUbd7c2qTsNcatbKiQrwWKttVec3myAPGKGK/1X84XfPRfKiQO4Q50OuCBreSiYAF96+JL0CIckWfDYvSqb5GWNNky8E6pyhziria8N6XFwHRtXf7yOa1U8+aRf0+ixivypxImsDSkz7Pmxa9Yux7EmMVHgg/54KViHXCsoT4pYgeg+o3cJa4eGMjd5Gum/n83OsTVJDCM3+3yt4wtunn/pQswRJtA9SRjSFynsKO7BUFLwdvAk6OYeGUoef7XXJXZi7mrEoS46OUgIb1qSVdJkvYhAj0Fc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHJNaUFXcDdFR21uMTR6bERoREpNQ2N4NUd0TkgzNkF6WG9GbXpSQXBqaHNV?=
 =?utf-8?B?akVLNWYycjNZK1hUU2VCeDF1ekxDT1ExZmsxMHU2SDhrUGZKYUlCN1Rzb3RE?=
 =?utf-8?B?MWdUeGJjRzYxQXEvb1NhOGo0S2pmRFZ3KzFTMnNhOWY1VmcyeUkxTmFYN0lT?=
 =?utf-8?B?VWpLSEV2L0habytTSUFqUHUrY0FoeG8yL1RJV3dleDFBaXhpZFRBTlEvU21N?=
 =?utf-8?B?S1grZU5lZStTbkk0TWkzUFFlUkxVZ3FZT3Y3LzBXa3lvVWZXTTB0TGhJb0Fz?=
 =?utf-8?B?WTZPR2hqdE1sbVRmRWFleUl1Um9SY24rV1lpbWhJaVZid1h1NEMrT0lvTDZE?=
 =?utf-8?B?YTBNYWppRE9aMFFBb3h2ajlFWS9YTFNxZThNRUNqaExUdEt2T1FPRGh0WWl2?=
 =?utf-8?B?ZXNoN0tUOSszd3hzaURsMkJFNDIrMDJ6bWFIVVFMYjdzVXFIUlVJdjdMOFdr?=
 =?utf-8?B?ZjFXd2IzQzVVSzg1dlc1Mi9kakdjS1M0ZTRLOUhZc1AyTU9JWndheDNwRzlK?=
 =?utf-8?B?aUF4NXZKZWc3WGsvb1RGTXZ3ZHF3MnpvVE5JcnJDVE9KaXhRU0tYbHExbkV4?=
 =?utf-8?B?OTBKVGYyeUF4Si93TEVISzYyQ1NNYitZTVJsbURaVEdQNDl4YnJHR1hzemN2?=
 =?utf-8?B?SnN4cUNLUFNhYmk1a1dOWkZtUmlUVHRHVHBoc0xMV25pREtGWWJwQ0Rudi84?=
 =?utf-8?B?TWxxTVRsaUtGdm5RME9KWVhOS2JoelVrN1NOUFVBTVRwZlZFR2FVSW1NTWhs?=
 =?utf-8?B?V0twV2RBTldWT3o3SzlpMzVLak9EbnA4UVQweFBUUmlta291TU0zeFJDd0dt?=
 =?utf-8?B?aGtWd2JQMkVDUDZLWkN3UHVnS0dFK0xZWDZvMjRibnNaMXdsYldJcXBJazhp?=
 =?utf-8?B?eS9iUHUzNk9TUCtaR2NXRFNXUFh4NTgrTjVEVVphUGlKY1V3YWFZN0JjSWJ2?=
 =?utf-8?B?NEMzYkRoSUpESnVxQ2czc05uQnFEbS80RnRTU0FzTCtadWFjWXN0cXkrLzJY?=
 =?utf-8?B?Mm5wUkdiUkpOUEFFZllmVTVUVEFHTGdUYTc3K0dtWW4xQnNDM1NPZTA4akpB?=
 =?utf-8?B?KzdFMTJhOG1INThxZ21zcFdMb3V4dTMxcjUxbHlxWGhLejRwYjU2bkhMWTds?=
 =?utf-8?B?RC85T2xRbXNCdlFGTDI4YWJLaktHcEs2VVVmOGowUjA2ZXFlQkcvRGpKRUt4?=
 =?utf-8?B?WTl3c3k0N0M1WDJaMjZ2N2VZVzNPYmY5U2xoUEhxcnJpbUgya0FIYXpyTkRw?=
 =?utf-8?B?QWdXaU83U1lDQU1oaVZmRHoxcVBaSjloMGhZMk5veFo1Uk85SHZNYVB1N09C?=
 =?utf-8?B?OU84aGFEdW0yTUVnalliM2gyeXlaU044RGF4R25DSzNQeU5xS0V4VlI1V1Jj?=
 =?utf-8?B?SkFrcXZpWmxsRGxvbUV1clV2UVBNazlUbjBNQkFFVGtCanNPRmM4KzVJLyty?=
 =?utf-8?B?a2Y5cVdHUkg4a0R2c0RieEgyZEdBdVBCejVSNmNBZzZFcjZhWmo4TkxKbklQ?=
 =?utf-8?B?aDZNcHlkdjdMbmRLTXJLZ1JjcUJsb052Y3dBR0VPNjRBUDJNUTRMVUt3L1hm?=
 =?utf-8?B?Und3TWlERW1tQjZydzhNZzZWSFdzMHlFQlhSdEhSYTlJR3BYeWpPS1VKNEVx?=
 =?utf-8?B?M091c0U2YVB2N2dUbmVrS2lIVHVvT0N0V1NpRWZCRXRuRFJQTmQrakJrWUhB?=
 =?utf-8?B?bjhuMTNmeTZVV0lWaGdWa084VE1ENnZkVEhXcmxuaGNyNWV0NU9LeVNlZlUv?=
 =?utf-8?B?N28xR2JjNjRpM2NORWVzS0FQenI5Sk5WT2pvR2RIUXJsTm5yTTdaRERNSDl2?=
 =?utf-8?B?eHRYTmpxNS9PR2FGZ0hTMkZDUGF3ZDRzdkdEUG9PMU43MEU0YmFiR3Zjak0z?=
 =?utf-8?B?dFJMRy9zY2cyZmNqNU5rUXFINTlUSzJqR1l5ZFBKUWl3VndhcVdac2UreEFS?=
 =?utf-8?B?dWhZZ2h6SjA4M21pcXF1RUUyOXFUQWdYdVZRTUIrTzF4SWxLa3dqWXg5anJ1?=
 =?utf-8?B?L3dGc2VaNjM2d0dubm85VkhIY0cvTVBaQ2tERW1qNWx6M3p3NHIwb0toRnlm?=
 =?utf-8?B?aTg3YUNMVnNMcGFVWnI4MXBhRGJlZ051OW5peW1lNHlTWEM0cXBJTFhVUE1h?=
 =?utf-8?B?U214QW9zNmNyZWZYeTh3TzR4U0Z5SXhNYkMreWR1SXoyLzJEYXBraGdKSkFX?=
 =?utf-8?B?RGRSSnQ2czFCWGVPOG1YUVdPWXVDYmo1WlY2ZFdwU240WVdYZjFYdXYxcEh5?=
 =?utf-8?B?dkx4M0FCWlRYVG9DMkdXdU9iNEJPTXA4VTlrQVNNZFFMZmw2ajE1UDZtNTFZ?=
 =?utf-8?B?cmlHQW9FS2FRT0k3SWhmMGg1Z2MxYUlqeTlFUnhwU1RJRG9nS2pSdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9b3fac-250e-4ac7-e089-08df1758962c
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 20:48:55.5191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8cAlKjNa+xvX2xBnxWMNAhxxRNdingh4/ya+SopYxGLhn1J5y/twjsIIs9aL9MKE3EJI+4MzybGNFBEH2gAADA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2687

On Sun Sep 20, 2026 at 9:01 PM BST, Georgios Androutsopoulos wrote:
> Several Rust file descriptor APIs rely on `current->files` being
> available. However, `exit_files()` clears it while execution may still
> continue on the same task.
>
> This affects `LocalFile::fget()` and the
> `FileDescriptorReservation` operations that call
> `get_unused_fd_flags()`, `fd_install()`, and `put_unused_fd()`.
> `FileDescriptorReservation` cannot cross task boundaries, but remaining
> on the same task does not guarantee that `current->files` is still
> available when these operations are performed.
>
> Guard the affected operations against a missing `current->files`.
> `LocalFile::fget()` returns `EBADF` and
> `FileDescriptorReservation::get_unused_fd_flags()` returns `EMFILE`.
> For the infallible `fd_install()` and drop paths, warn once and avoid
> calling the corresponding C helper when the fd table is already gone.
>
> This prevents NULL dereferences through these safe Rust APIs after
> `exit_files()`.

I suppose we could add these checks to C side instead, although perhaps one=
 may
say "its bad caller code and not worth checking"?

So having these checks on Rust side is okay to me.

>
> Fixes: 851849824bb5 ("rust: file: add Rust abstraction for `struct file`"=
)
> Fixes: 5da9857b127e ("rust: file: add `FileDescriptorReservation`")
> Closes: https://github.com/Rust-for-Linux/linux/issues/1256
> Signed-off-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
> ---
>  rust/kernel/fs/file.rs | 69 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 60 insertions(+), 9 deletions(-)
>
> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> index 23ee689bd240..559f0985b12c 100644
> --- a/rust/kernel/fs/file.rs
> +++ b/rust/kernel/fs/file.rs
> @@ -260,7 +260,17 @@ impl LocalFile {
>      /// [`assume_no_fdget_pos`]: LocalFile::assume_no_fdget_pos
>      #[inline]
>      pub fn fget(fd: u32) -> Result<ARef<LocalFile>, BadFdError> {
> -        // SAFETY: FFI call, there are no requirements on `fd`.
> +        let current =3D crate::current!();
> +
> +        // SAFETY: `current` points to the currently executing task, so =
it is
> +        // valid to read its `files` pointer. The pointer may be null du=
ring
> +        // task teardown.
> +        if unsafe { (*current.as_ptr()).files.is_null() } {
> +            return Err(BadFdError);
> +        }

I think we want to add `unlikely()` on them (which is being added by
https://lore.kernel.org/rust-for-linux/20260406095820.465994-2-ojeda@kernel=
.org/).

> +
> +        // SAFETY: There are no requirements on `fd`. We checked above t=
hat the
> +        // current task still has a file descriptor table, which `fget` =
accesses.
>          let ptr =3D ptr::NonNull::new(unsafe { bindings::fget(fd) }).ok_=
or(BadFdError)?;
> =20
>          // SAFETY: `bindings::fget` created a refcount, and we pass owne=
rship of it to the `ARef`.
> @@ -403,7 +413,18 @@ impl FileDescriptorReservation {
>      /// Creates a new file descriptor reservation.
>      #[inline]
>      pub fn get_unused_fd_flags(flags: u32) -> Result<Self> {
> -        // SAFETY: FFI call, there are no safety requirements on `flags`=
.
> +        let current =3D crate::current!();
> +
> +        // SAFETY: `current` points to the currently executing task, so =
it is
> +        // valid to read its `files` pointer. The pointer may be null du=
ring
> +        // task teardown.
> +        if unsafe { (*current.as_ptr()).files.is_null() } {
> +            return Err(EMFILE);
> +        }
> +
> +        // SAFETY: There are no safety requirements on `flags`. We check=
ed above
> +        // that the current task still has a file descriptor table, whic=
h
> +        // `get_unused_fd_flags` accesses.
>          let fd: i32 =3D unsafe { bindings::get_unused_fd_flags(flags) };
>          to_result(fd)?;
> =20
> @@ -421,13 +442,30 @@ pub fn reserved_fd(&self) -> u32 {
> =20
>      /// Commits the reservation.
>      ///
> -    /// The previously reserved file descriptor is bound to `file`. This=
 method consumes the
> -    /// [`FileDescriptorReservation`], so it will not be usable after th=
is call.
> +    /// The previously reserved file descriptor is bound to `file`. If t=
he current task no longer
> +    /// has a file descriptor table, the reservation is abandoned instea=
d. This method consumes the
> +    /// [`FileDescriptorReservation`] in either case.
>      #[inline]
>      pub fn fd_install(self, file: ARef<File>) {
> -        // SAFETY: `self.fd` was previously returned by `get_unused_fd_f=
lags`. We have not yet used
> -        // the fd, so it is still valid, and `current` still refers to t=
he same task, as this type
> -        // cannot be moved across task boundaries.
> +        let current =3D crate::current!();
> +
> +        // SAFETY: `current` points to the currently executing task, so =
it is
> +        // valid to read its `files` pointer. The pointer may be null du=
ring
> +        // task teardown.
> +        if unsafe { (*current.as_ptr()).files.is_null() } {
> +            crate::pr_warn_once!(
> +                "FileDescriptorReservation::fd_install called with curre=
nt->files =3D=3D NULL\n"
> +            );

I wonder if we should upgrade this to `WARN_ONCE`. As code being executed w=
hen
exiting are cleanup code, for this code path to be hit, it would mean that =
some
code is installing FD descriptor while being dropped -- which is likely a b=
ug.

Putting a "BTW, some Rust code is installing a FD when process is exiting" =
in
dmesg is not going to be useful to understand what's going on. We'd want a =
full
backtrace.

On the other hand, dropping a `FileDescriptorReservation` is a more realist=
ic,
so we perhaps might even want to declare it being okay (see below).

> +
> +            // `put_unused_fd` also requires `current->files` to be vali=
d, so do not run
> +            // the reservation's destructor after the current task has l=
ost its fd table.
> +            core::mem::forget(self);
> +            return;
> +        }
> +
> +        // SAFETY: `self.fd` was previously returned by `get_unused_fd_f=
lags` and has not yet been
> +        // used. This type cannot be moved across task boundaries, so `c=
urrent` still refers to the
> +        // same task, and we checked above that it still has an fd table=
.
>          //
>          // Furthermore, the file pointer is guaranteed to own a refcount=
 by its type invariants,
>          // and we take ownership of that refcount by not running the des=
tructor below.
> @@ -446,9 +484,22 @@ pub fn fd_install(self, file: ARef<File>) {
>  impl Drop for FileDescriptorReservation {
>      #[inline]
>      fn drop(&mut self) {
> +        let current =3D crate::current!();
> +
> +        // SAFETY: `current` points to the currently executing task, so =
it is
> +        // valid to read its `files` pointer. The pointer may be null du=
ring
> +        // task teardown.
> +        if unsafe { (*current.as_ptr()).files.is_null() } {
> +            crate::pr_warn_once!(
> +                "FileDescriptorReservation dropped with current->files =
=3D=3D NULL\n"
> +            );

I think we can remove this warning. Skipping put_unused_fd isn't actually
leaking anything as the files_struct is cleaned up.

Best,
Gary


> +            return;
> +        }
> +
>          // SAFETY: By the type invariants of this type, `self.fd` was pr=
eviously returned by
> -        // `get_unused_fd_flags`. We have not yet used the fd, so it is =
still valid, and `current`
> -        // still refers to the same task, as this type cannot be moved a=
cross task boundaries.
> +        // `get_unused_fd_flags` and has not yet been used. This type ca=
nnot be moved across task
> +        // boundaries, so `current` still refers to the same task, and w=
e checked above that it
> +        // still has an fd table.
>          unsafe { bindings::put_unused_fd(self.fd) };
>      }
>  }


