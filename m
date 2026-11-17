Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929310;
	b=5W58SnkD7rr5TaRJbC0SkVP8d+OKdwJPYF0+82kl/WXUYrFVaY7hzvU/XpyMQzUhD8Si
	 P9NI3AGSNmFPfvSXQUPjfOe2HkfxnsdWTj8OXr0Fu1t7D+TWfH2Q7GZh+wxQGSRI51f8N
	 hy5WGNT96+FqJupTtsAlGVrhgPnuePgSqPo+EbI+34x903Ul6zpkKFgUleFc1WXQ7kpNr
	 grPupR3uhe4pshUMLKRrzjkF60BezCPD0Qo6HkrQpOngb9209ny5VN7DKWflKj+a4zqja
	 3fe42qdeyBN52RGicrO3fIg6ze7OzEr5Q2OPeXWeN3MPLBolEsDGqIXh8AS5Lbs2YLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929310;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=eabcSSyR8dinR+klZl3/g1Fw10Duq9Lg/6T5SwUMuWY=;
	b=N2WsTFXVPBHoltKNn9jfrW5tnk8M1t4L2gqUpEV0lP0Mv9ojxCY3S9e2i+lP1G1WskY/
	 5eUO0vM2U/howQjTnyw3y3tDssVWk2kDs6lGsvkP5yyD6KP0COXbxsMoMb6/9XtNN52jK
	 EAoR7F65yO9HSdB1mb4kyXY/wXlhWXPMyyOrq/5cLShp3/bdutfppvxcb33yAkbKYuI89
	 V4NjNG0TzoD8Zk8sQAWgtbxyDqE1/qpJYVBGgZTcUJZ1Ub8XwKpex4FEXLSnaIwxFEgK2
	 JtUBXft5yURC1xvZcqA39ca/clj7p3Gb658hb78EneYmfkH5+v1pTeDlD+p0aBNqIQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SptBZ+49;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B167B606A31C;
	Tue, 17 Nov 2026 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SptBZ+49
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44711F000C4;
	Tue, 17 Nov 2026 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929310;
	bh=eabcSSyR8dinR+klZl3/g1Fw10Duq9Lg/6T5SwUMuWY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=SptBZ+49ZOIkxFB04dM1CXWSnEFLFmyyRgTzudB0TYtbzjO6UjAk1s/fFk1zbwel+
	 OC5NmWdNbTUVbBGwLAiA5GBxSwadyrnVZ43vzoIeUK/HM1zRS+C9n40vSwEcL3RJnA
	 qRNMQvUCkt05yw5Ta6Tn8gusgAPRy8TDhbEPdmWMWUqxYByTM6dLKi0LWS6doxMDlb
	 tH5Wr+iYFybXMvmsChF+zvDtui/7y/ZZzv7+VFj8oqKZQwen7LdUDaUtkUDGZG9zY5
	 yJBV/PaeEOfBPYg5aaDU/vTD1tSMUhEi/H9Xvhk/ZutbqDLWIdIEiIRRYSsUrLiXNs
	 l5qQuBZ8z6F4g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Tamir Duberstein
 <tamird@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?=
 <work@onurozkan.dev>,
 Matthew Wilcox <willy@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Harry Yoo <harry@kernel.org>, Hao Li
 <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes
 <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 09/12] rust: mm: sheaf: allow use of C initialized
 static caches
In-Reply-To: <0082d06b-381d-4001-9ea6-cd3217e437dd@kernel.org>
References: <20260902-xarray-entry-send-v5-0-d18adae40708@kernel.org>
 <20260902-xarray-entry-send-v5-9-d18adae40708@kernel.org>
 <0082d06b-381d-4001-9ea6-cd3217e437dd@kernel.org>
Date: Tue, 17 Nov 2026 16:28:15 +0100
Message-ID: <87fqwzv5o0.fsf@t14s.mail-host-address-is-not-set>
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

"Vlastimil Babka (SUSE)" <vbabka@kernel.org> writes:

> On 9/2/26 15:26, Andreas Hindborg wrote:
>> Extend the sheaf abstraction to support caches initialized by C at kernel
>> boot time, in addition to dynamically created Rust caches.
>
> Nit: in C code caches can be also dynamically created :)

Right. But the Rust abstractions do not support interacting with those. Only
dynamic caches created through the Rust API or static ones created in C
are supported.

>
>> Introduce `KMemCache<T>` as a transparent wrapper around `kmem_cache` for
>> static caches with `'static` lifetime. Rename the previous `KMemCache<T>`
>> to `KMemCacheHandle<T>` to represent dynamically created, reference-counted
>> caches.
>> 
>> Add `Static` and `Dynamic` marker types along with `StaticSheaf` and
>> `DynamicSheaf` type aliases to distinguish sheaves from each cache type.
>> The `Sheaf` type now carries lifetime and allocation mode type parameters.
>> 
>> Add `SBox::into_ptr()` and `SBox::static_from_ptr()` methods for passing
>> allocations through C code via raw pointers.
>> 
>> Add `KMemCache::from_raw()` for wrapping C-initialized static caches and
>> `Sheaf::refill()` for replenishing a sheaf to a minimum size.
>> 
>> Export `kmem_cache_prefill_sheaf`, `kmem_cache_return_sheaf`,
>> `kmem_cache_refill_sheaf`, and `kmem_cache_alloc_from_sheaf_noprof` to
>> allow Rust module code to use the sheaf API.
>> 
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: linux-mm@kvack.org
>> Assisted-by: LLM
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Thanks!

Best regards,
Andreas Hindborg


