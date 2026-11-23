Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795444852;
	b=vwTm20AugR2A8MVwL5vZYhaqH5aXlqJaQ5T9xQktz0w541iXIfFqXAqFQMBo0JeQanJ5
	 HGAEJPuXnCMlLRAIAYISNA38sTzCX9GEqodxr5Gfdh9YSzGp+aB9MmJXAAtE9K4+4Ittg
	 305nyuUb8V0RToPcN/KdM3L2kKKe4aWZywqSWY6ukZnl97UpXJCai0wZn4w1SG3cNiy/M
	 W89vdXQ4ilJaYQDFLsNZDKrk6SsGjk+C79l2TxY6m2zKaYTTwm5D6OE3rPvGp4DgPYMJi
	 NrnNyioWo5Drlid3FgTqPBaQLPSTAH2d7hM8QApXHzStoK/xrNoGPk/ffZKn3J28Iow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795444852;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=VOsTEFHih5VGh65hIOhMdFK7B8YNvZl3Iglz0jpWLso=;
	b=A/QnlplHzvhQOWh98U+xYtZTzAM/heZRJihvImz33RhmC82qQhULhmBOml+1NCTkZ3I7
	 +J4p1uw3fSqLtaIbc5RS3kr+OB+udFVdN8hneqg23Z/bMyB3D5OU3FwkriJEzqLvaGY6N
	 TC8kGxF/UGLr5AHglnOBpcH4BZNQpQ/Ds7kwcBczGL7sdnFcb36tm19XAObTUBbuqUrFM
	 AmMylw1rA+LcX67K4olBWXOZ+actacIgTLZAuVFzk02Wu/FFP0JMv8/QKRRBcZPuwPyu+
	 QyV4AQkABpGOQ0jftrseoTGOgUYBfKfnbGxCvfr4SoTRo4SXxYaex1cjjbxZTN7GNEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhQuDqUF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97828606A31A;
	Mon, 23 Nov 2026 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EhQuDqUF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD2E1F000C0;
	Mon, 23 Nov 2026 14:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795444852;
	bh=VOsTEFHih5VGh65hIOhMdFK7B8YNvZl3Iglz0jpWLso=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EhQuDqUF7DT4TxtUVj9OVj3hTI5W7/nX+vJBMGjIrlutfWt0271APj+JosrDBV2AM
	 uut6trIXiw9gA5t4IwPJueJwzj9HFtdUmkBzMc25B+WVSM98Cm2yI8DhpgxTSr78Fs
	 0vCN7pHkECxedbb55AQsjW+X27PRzf58UPb+Tqg+TSlPv/o1rl0l2NzYCEWJL+4g5/
	 Hw3Auknd7cZH4CLJjUs29SlW4cydIVH/NtK193SF09uzDfVCpDWaX2qCVqmz1rChCw
	 MLo2KazaBsVn6lCDr4eLo6ojuIsBh555XaGs58UHfZp30JcithhFCYfDtzruEDI36+
	 FuL+NMy8p6Rsw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Tamir Duberstein <tamird@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Daniel
 Almeida <daniel.almeida@collabora.com>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>,
 Matthew Wilcox
 <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Harry
 Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, Christoph
 Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, Roman
 Gushchin <roman.gushchin@linux.dev>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v6 08/12] rust: mm: add abstractions for allocating from
 a `sheaf`
In-Reply-To: <DN0YBZJNQVW4.2RY9NCR5T33HZ@kernel.org>
References: <20261120-xarray-entry-send-v6-0-1f69d7385f70@kernel.org>
 <20261120-xarray-entry-send-v6-8-1f69d7385f70@kernel.org>
 <DN0YBZJNQVW4.2RY9NCR5T33HZ@kernel.org>
Date: Mon, 23 Nov 2026 15:40:36 +0100
Message-ID: <87mrqztxuj.fsf@t14s.mail-host-address-is-not-set>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Danilo Krummrich" <dakr@kernel.org> writes:

> On Fri Nov 20, 2026 at 2:10 PM CET, Andreas Hindborg wrote:
>> +/// An owned allocation from a cache sheaf.
>> +///
>> +/// `SBox` is similar to `Box` but is backed by a slab cache allocation obtained
>> +/// through a [`Sheaf`]. It provides owned access to an initialized object and
>> +/// ensures the object is properly freed back to the cache when dropped.
>> +///
>> +/// The contained `T` is initialized when the `SBox` is returned from alloc and
>> +/// dropped when the `SBox` is dropped.
>> +///
>> +/// An `SBox` holds a reference to the [`KMemCache`] it was allocated from.
>> +/// Dropping the `SBox` may thus drop the last reference to the cache and
>> +/// destroy the cache, which may sleep. See the `# Context` section of
>> +/// [`KMemCache`].
>> +///
>> +/// # Invariants
>> +///
>> +/// - `ptr` points to a valid, initialized object of type `T`.
>> +/// - `cache` is the cache from which this object was allocated.
>> +/// - The object remains valid for the lifetime of the `SBox`.
>> +pub struct SBox<T: KMemCacheInit<T>> {
>> +    ptr: NonNull<T>,
>> +    cache: Arc<KMemCache<T>>,
>> +}
>
> I did only notice this patch just now, will take a closer look later on. But
> this all looks like it belongs into the alloc module.

Yea, could be we should move it to `alloc`.

Best regards,
Andreas Hindborg


