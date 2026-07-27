Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022097.outbound.protection.outlook.com [52.101.96.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932203E63A2;
	Mon, 27 Jul 2026 12:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153733; cv=fail; b=NbT4XuXk3SFipRXgFpPQCITByGK6BVmRMO7mlm0eSM03cNAjqfWIg8Hs5Qw/xTdlqhvU8CxzliOUaulhxoE6/Hd93y+5o0nfae47gw1WVRbuRCiuj/6158len+f7fA8R7EqQ01RlSXyxap0Lso0mb04zS6scupXvNSjdOno9vOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153733; c=relaxed/simple;
	bh=uvJxGBCTaYmkHsnZhIKKXcSHztuupf/Hz0XjDSS3loM=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=tVDgUt3qiSQShDKFacAS+nLUnvBvFRPR8R1WaF/xOBkr7mdWJteXqjXubo8jU3mqSPNhM8dDWRljtx7slBQAyX2fySTDOz8DekibUr2YrZMzoK6LrywPpQgZCiYSVAegz4eJBNRRCe3jxfrhe0YHaa8xwzuMunz8tJQJVVBUwVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Fbx/DdMt; arc=fail smtp.client-ip=52.101.96.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Fbx/DdMt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diZ6uZNfXZforY20b8z8wdqJDQVoejkKbAAPHtGEUhUsIdq4YblESdDXSGfXXc3usUIF5g6BymoW5EDlACAkJpwSAJpd4i3gwKgcxu914s9KVuhTbHq86dVhFO7xqiqRH7Y7vQZfoaM3ArVr9uT9Wor/ewAEQEDl2VF0ZHGzVCWVRuhNNKUEBwSwwKNgIVnNdByQ5pcB6Lobjb8CxaLhOkoQVA8Ve8UaItkLVHWknH6EE4iGGj5+yXu8epdRY7cR+QM0UpD+vGBmidUoPkqHcw7CEdFETY9xpDDgMwpqgyZUGqFgk+lkjAHpjSICNtOe3brnxRJ/TifBOuuElbcP1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMKYPrUuu/ERb1O4WWMSwAOyqwA6j60lhBsPkj75l7w=;
 b=rDXhfnhA8AvnCuGHO872Gd2J7zb2u6KmB+jZCmjepqkKTUCx8Mh8lUvik8/tlj1IcPKTbph9+F4NJCrYzPySYDbetHRkA9wgdbXuxEcCZVXMvgvw96s7SlWzDWBqLi3Ey335MP3JBX9e2Q5CbgvbsGviHHxzLTMN8GNqA25PDodSRz7rRia80HvnT3AHY+hosO8bXW0qKF+9Z4ytGbmpylZJdGkKCFtfxXxacvE/n5B6UUHaTbQtErcTECr5Qbzn4wpnhsEZcBCNjA/uhdAETyQfjPwJcro9lt7MVuWmz/WN4ET4PoDMTMkZD3mDGZT2q9cyBzuyRVeuhpQQJv7PvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMKYPrUuu/ERb1O4WWMSwAOyqwA6j60lhBsPkj75l7w=;
 b=Fbx/DdMtilFEmDoam56FtSflTC1niWxiKfKmrKO5VyXB3Lm1ObhBlC2V4wJjUI1g9jxuXnYRUWfJnTUhZNp1+5UuNPgiBG862diBtI1deZL6cuaA6bWiK3PafmzXCMnDEtb6wxCG7mOB75/pxm1nHhPP/QvDWsLxgXBoZLtOO00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB7339.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 12:02:07 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%2]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 12:02:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 13:02:06 +0100
Message-Id: <DK9C6KISAMX3.H10297T645RT@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 3/5] rust: sync: add WaitQueue infrastructure
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <arve@android.com>, <tkjos@android.com>, <brauner@kernel.org>,
 <cmllamas@google.com>, <aliceryhl@google.com>, <boqun@kernel.org>,
 <gary@garyguo.net>, <lyude@redhat.com>, <daniel.almeida@collabora.com>,
 <work@onurozkan.dev>, <juri.lelli@redhat.com>,
 <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
 <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
 <vschneid@redhat.com>, <kprateek.nayak@amd.com>, <ojeda@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
 <longman@redhat.com>, <viro@zeniv.linux.org.uk>, <jack@suse.cz>,
 <tj@kernel.org>, <jiangshanlai@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260726223613.1242940-1-dakr@kernel.org>
 <20260726223613.1242940-4-dakr@kernel.org>
In-Reply-To: <20260726223613.1242940-4-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0325.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 8455595b-6312-44c7-9bbd-08deebd6e179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|23010399003|1800799024|921020|6133799003|4143699003|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	S6ARLq5psvrLUcrqkxb6WXplx97oCh9NSI1h1KW24CFACGdTIkMPh3fRJnDcT66n+WfrM9DmXnzaB/ek7zJPfo34hYY5XozpfOjci+j0KzZtndr/GsPSZNbAahmjpfZVof1C8E3Cq64l5elwf77nbODZJ5jr++cwjnCZVmrGh0/knXHdrDmofH7UPWjXf8R5JTq8RDiPV+orjcoFp3p9ZLvZpvHMyYv8YY9dadJFBQ8o1NwXOXpSeH44/jFkKLZqsqhhYjzHcY91fc7nIyP2OF1qHwzC1r3xpm2UEJeH8+H5cMIq2KCRt94RCu7oyxyQJbabetrIbhzN29cltbmFLWSFokArHVzd1vQl25ES+HQjImPxiV5xXr36m/Fo7sEtE6irNyFnwU6gGSvDJVSd0tTtdOiC2Q3Luyjqt0Yw4tffpE7HaCfAx6KR0iRM+4UxFQeqoFH7ZiTGSo/99Pah6Uj+GakNY1vP+VNKnXegwdkc4bDSt0YJMlJT6K+KppxS1/HP7BRo7tmW7jMx0te8sQwbz0JL6kNItRu1Rk7YWxx1my0o8r9HoJtdI3USuB5ui47oVokGgtA4FD46CAclAj14UjxK5476WDgaorTVC8GAmQBC/EsVakVMu2wwL8HeuCVCxauT8XonNRT4h9izz5RAb+v1oH9tA8cSR0d3AeHSbB4aixr6m4mOW7mSG1yhCxiAhzQaDySyHYGK0I2aUQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(23010399003)(1800799024)(921020)(6133799003)(4143699003)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTl5NkxCWHZ5NHV3Z2dUaTZINDA4aU00aHprSEtXTzZNd0NZekg3Vy8xYTFX?=
 =?utf-8?B?bW43WThya1cwaTJXTC9WUzE0ekpCbHZlSmJLbzRIcDgvaFljc2pmeXFua2tr?=
 =?utf-8?B?bzBDSXhEVi9zUVNGZXFOczJ2ekZET1NyMHpNV0xSZUR4Vk9zYzN6NVZDUnBO?=
 =?utf-8?B?cGdKVmtWcG1wUThpRzhjRnh5Q2pOcVJXaE5za2hTN1lpZkkrUk9STmM1TFp5?=
 =?utf-8?B?L1JhWXFxeXYxa1ZnRXdjM0hVNDhvR25EQ1hHMm5wZUYwWnJTK0J4NWhyck81?=
 =?utf-8?B?dHROcWlwVS9iR1RGRUxXZ2RMZmxMVGN3SmRkUGZla0pJbkw2U291MXU0a2xS?=
 =?utf-8?B?SDE2bXVUR05ta0N4RlZRcmthektYc2VjY2dQdlVIZm4zeXl5NE43OWl3UkF5?=
 =?utf-8?B?N3Z2eUlwZk9rR3VDcXAyM1o1czNHdUV0VGR4d0gyb0xqZERrU0x4clJtTklV?=
 =?utf-8?B?SlhKbUt4S01sSGVwOUFMMGZVblA0dURia0hKQWthdFhtLzYzTFhobEN5WXlL?=
 =?utf-8?B?N0k4ZjJocTBTNG5mWkxuMnA4OXlIcXRVZTA3cEVFZTlzVVVkWVNWTmxDUDJp?=
 =?utf-8?B?WEMxQ3RoMHBpN0pzZWsxN1MwOEZRclI0Znpud05xNTVPMERxY1haOWdYakFH?=
 =?utf-8?B?SmhDVDlsSkpmN2lhYlFjL0IwOGVoTWsvcER5YzVYeUNybll6MjhGTHlEVlZL?=
 =?utf-8?B?RW4wVjNlaDhqaGV0Uk80cHM2YmtLTWM0VzFoZGxIQkNvUlhpVFc0UFJ6ekxO?=
 =?utf-8?B?T1MzY0NjNktTZmdhOEJWRnBPb3NPSk4vZElDak9Kd05xY1l0ZTVRcFMzcVhQ?=
 =?utf-8?B?K2YySjhyYm5Nc0hoUGhaaXNzay9ZWHZsREVxTHh0YWFUWmMvOE9lb1BqcnBO?=
 =?utf-8?B?cHkwZk9IWG13T0pLeGRjalZSMUtxUzlzV3RZVDVyZVFXeFBlUWxwMjQwVGQ2?=
 =?utf-8?B?eUc1d2RVcXpiMnBKNEErMTkxVTYxZC9QaC9HS2w0dUpvTmszaWxqcDFld0tY?=
 =?utf-8?B?L0tRNUR4NFFtNFBPQ2pZY3cyV0ZSNlZvTml6MnZwVit2V0t1UC9BS0ZxMitR?=
 =?utf-8?B?SVVseDArNkFSVmNBbGFvSndOZHQ3VmMxTkhjS3hhc0NwSytla2RVZU5DaXph?=
 =?utf-8?B?clA1c1NoK09Vd25idkowOUpoQlVZZ21tbTdtVzh4aHlPOERuaVdMUEhtTm1s?=
 =?utf-8?B?cXNYRVgrVkxESktES2N1YTB5YXptYlk5MTFtUUhndEgwLzZTMUh2TCtoTTQz?=
 =?utf-8?B?OXlnNzAraGs0VWxwRDcvZk4zZm1uTXZDS2U5S29zUzl3RnZlNXVVQnUzTlJB?=
 =?utf-8?B?N2d2N21LV0I2OTBBTjc3WFZuNVVYQkd6ZkpBQi82UDZLSHRCNExJa052MHVK?=
 =?utf-8?B?ayswOXhBdTJ6cVNNTTdaNHRBTnU4Y2RnR1lpVXBIYStxaDV0V0k0aEQ5aUNF?=
 =?utf-8?B?UGU2OVlPUnFzQ2NXcnF0RGlHL3V5NEVYaTFlYlhPb0ZleUlKU3Q1M0p5Z1FU?=
 =?utf-8?B?aTd1ZHMrUUg3eUUxbSt6Z29RMzBpTk91UUxsUE8rc0VHWC9BS2lpdTE1V0Jx?=
 =?utf-8?B?MVZpWGVCWVdGREhTSFloWlRQYm4xSVRVYmkwclo4aTNycWtnMFAvUlRiVjJ3?=
 =?utf-8?B?dzFSUGR0elZqZ0dSWHh2dkxkM1JyYTNwT05Ra0U1QlFQN2YxcktmTzRSMWlN?=
 =?utf-8?B?dXNrNms0d1pXa2J4OGFKd1V6TjZMamRvKzdmWDhVZmpQdk1id2p2QmdTeW9o?=
 =?utf-8?B?WjFXTkpPR0cvQ3hQaGZSN21rRjZ1NjVPQnFoV2JlSWcyZTJYSXAybSt0Z2ZX?=
 =?utf-8?B?N21mOGcySHhMNVQ4ZXJHSXBOdG9ZWkZSNFdaZUE3enY2Vkh4T2tTUHZybzhU?=
 =?utf-8?B?czZGaHpKYmJjc3FNWk1MUXBtYWlZYVhDVFplOUlFWDRrS2k2S3cvdkV3V2xU?=
 =?utf-8?B?TVV6NFBqS3I1MzJ0UjIxNUZYUWVocWo3VkdjYzlSaGx0WGRqMjNOR2FqaFBu?=
 =?utf-8?B?ZjhmU2ZxS0ZQemxQV2tJSDIrZytuOVQvcnc1NmVINk9qd1JVb1ExM1ZXV0Vw?=
 =?utf-8?B?SkVVaUpRRWFtazJjdk9VK01NVEhsYURvTHRFa1UvZGdRVW9LRlM5TGdmMmtG?=
 =?utf-8?B?VDJpTml5dWdYZzdXWkxnbFBSMFJDQ1ZUeEp3dnRZaFNSS0cwN1FDRFZSWkhk?=
 =?utf-8?B?R1EwdG00M0R5SEVhRzNEVGZSa1R5bmg3VnFZTmh2Yy9CMWFGVng0Ni9UaU9B?=
 =?utf-8?B?TFZETEpQaUwvVkRnRll0eTd0MGdjUWdMM3F6UEg3MkRPVjFMYW1XWmtGNEdZ?=
 =?utf-8?B?YjM4Q1VuV0RkUUpOSit5WS9iWmc3VmV2aG0wSnI4WFNxUmVEc1NKQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8455595b-6312-44c7-9bbd-08deebd6e179
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 12:02:07.2244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTWEozLXdGqkWcVwwVD6zadguGKwopL+YFgKELdENjZHHOMsUlePLhMRpAZsnYRLokLPdSDLhEq8NNiOSQufbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7339

On Sun Jul 26, 2026 at 11:36 PM BST, Danilo Krummrich wrote:
> Implement a wait queue wrapping the kernel's struct wait_queue_head,
> with wait_event()-style methods that take a condition closure directly.
>
> The API mirrors the C wait_event() family:
>
>   - wait_event()
>   - wait_event_interruptible()
>   - wait_event_timeout()
>   - wait_event_interruptible_timeout()
>   - wake_up() / wake_up_all() / wake_up_sync()
>
> Interruptible and timeout variants return Result<(), WaitError>, where
> WaitError maps to ERESTARTSYS (signal) or ETIMEDOUT (timeout).
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/sync.rs      |   6 +
>  rust/kernel/sync/wait.rs | 388 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 394 insertions(+)
>  create mode 100644 rust/kernel/sync/wait.rs
>
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index df4f2604ff9b..31f0999e5747 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -21,6 +21,7 @@
>  pub mod rcu;
>  mod refcount;
>  mod set_once;
> +mod wait;
> =20
>  pub use arc::{Arc, ArcBorrow, UniqueArc};
>  pub use completion::Completion;
> @@ -38,6 +39,11 @@
>  pub use locked_by::LockedBy;
>  pub use refcount::Refcount;
>  pub use set_once::SetOnce;
> +pub use wait::{
> +    new_waitqueue,
> +    WaitError,
> +    WaitQueue, //
> +};
> =20
>  /// Represents a lockdep class.
>  ///
> diff --git a/rust/kernel/sync/wait.rs b/rust/kernel/sync/wait.rs
> new file mode 100644
> index 000000000000..ba4ee0f8d4d4
> --- /dev/null
> +++ b/rust/kernel/sync/wait.rs
> @@ -0,0 +1,388 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Wait queue.
> +//!
> +//! C header: [`include/linux/wait.h`](srctree/include/linux/wait.h)
> +
> +use super::LockClassKey;
> +use crate::{
> +    prelude::*,
> +    str::CStr,
> +    task::{
> +        self,
> +        TASK_INTERRUPTIBLE,
> +        TASK_NORMAL,
> +        TASK_UNINTERRUPTIBLE, //

Hmm, I am not sure why we are exposing these as constants from kernel::task=
.
Regardless, Given that you're using them for bindings, you should probably =
get
them from bindings::TASK_* instead.

> +    },
> +    time::Jiffies,
> +    types::Opaque,
> +};
> +
> +use core::{
> +    pin::Pin,
> +    ptr, //
> +};
> +
> +/// Creates a [`WaitQueue`] initialiser with the given name and a newly-=
created lock class.
> +#[macro_export]
> +macro_rules! new_waitqueue {
> +    ($($name:literal)?) =3D> {
> +        $crate::sync::WaitQueue::new(
> +            $crate::optional_name!($($name)?),
> +            $crate::static_lock_class!(),
> +        )
> +    };
> +}
> +pub use new_waitqueue;
> +
> +/// Exposes the kernel's [`struct wait_queue_head`] as a Rust wait queue=
.
> +///
> +/// A `WaitQueue` allows a thread to sleep until a caller-supplied condi=
tion becomes true,
> +/// re-checking the condition on each wake-up. This matches the C `wait_=
event()` family of macros.
> +///
> +/// For waiting with a lock guard (the condition variable pattern), use =
[`CondVar`](super::CondVar)
> +/// instead.
> +///
> +/// Instances of `WaitQueue` need a lock class and to be pinned. The rec=
ommended way to create such
> +/// instances is with the [`pin_init!`] and [`new_waitqueue!`] macros.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::sync::{
> +///     atomic::{
> +///         Atomic,
> +///         Relaxed,
> +///     },
> +///     new_waitqueue,
> +///     WaitQueue,
> +/// };
> +///
> +/// #[pin_data]
> +/// pub struct Example {
> +///     value: Atomic<i32>,
> +///     #[pin]
> +///     queue: WaitQueue,
> +/// }
> +///
> +/// fn wait_for_value(e: &Example, v: i32) {
> +///     e.queue.wait_event(|| e.value.load(Relaxed) =3D=3D v);
> +/// }
> +///
> +/// fn set_value(e: &Example, v: i32) {
> +///     e.value.store(v, Relaxed);
> +///     e.queue.wake_up();
> +/// }
> +/// ```
> +///
> +/// [`struct wait_queue_head`]: srctree/include/linux/wait.h
> +#[pin_data]
> +pub struct WaitQueue {
> +    #[pin]
> +    wait_queue_head: Opaque<bindings::wait_queue_head>,
> +}
> +
> +// SAFETY: `WaitQueue` only uses a `struct wait_queue_head`, which is sa=
fe to use on any thread.
> +unsafe impl Send for WaitQueue {}
> +
> +// SAFETY: `WaitQueue` only uses a `struct wait_queue_head`, which is sa=
fe to use on multiple
> +// threads concurrently.
> +unsafe impl Sync for WaitQueue {}
>
> [snip]
>
> +
> +/// Error returned by [`WaitQueue`] wait functions.
> +#[derive(Debug, PartialEq)]
> +pub enum WaitError {
> +    /// Interrupted by a signal.
> +    Signal,
> +    /// The timeout elapsed without the condition being met.
> +    Timeout,
> +}

Do we want

    /// Interrupted by a signal
    pub struct Interrupted;

    /// Timed out
    pub struct TimedOut;

    pub enum WaitError { ... }

    impl From<Interrupted> for WaitError { ... }
    impl From<TimedOut> for WaitError { ... }

so that the user of wait_event_interruptible won't need to handle
`WaitError::Timeout` and vice versa?

(I'd say that both these "error" types are quite commonly special handled s=
o
they probably do deserve there own error type)

Best,
Gary


> +
> +impl From<WaitError> for Error {
> +    #[inline]
> +    fn from(e: WaitError) -> Error {
> +        match e {
> +            WaitError::Signal =3D> ERESTARTSYS,
> +            WaitError::Timeout =3D> ETIMEDOUT,
> +        }
> +    }
> +}

