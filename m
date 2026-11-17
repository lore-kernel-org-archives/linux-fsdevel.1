Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929435;
	b=zb19D+Ya/V1tMDTRcIeNsLfCuEFcGaLuqTycof2R7HqkrR3fKh/vIuxFi3gMK6clE/RZ
	 0SVVv0yus44MnBteTMu5I28WVVWGhUo+8aq2n6ekqsLnJmR9sUKkY5TsXhid9ra307iTb
	 eAtZwcEhqtgJTS4TTO2Qvg01+r7kqVZvcu/VuEfVMBbN6z3ML5zVtua+P5q3ieMWLrjI3
	 0O3BxPvf5sYSvgEhTw+CHCYWVJDv24P8gIuMQkdKwdcdKZhHRi41ZcJCBMUOtmVz2mEDw
	 gR0eT6SnfHVhllFeZrebTpCkFPw3vzYMPYe94d1U3Vm9PyvZW6aSSqwPYN8/ZXRkvOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929435;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=5lOKQnYpBQXP/LqZtNZmh3g/ieWlMy/xv2FIvUgYpFI=;
	b=BudgMMyDEz95H0K4nohMIz2OoabDNfTa4kYf5KiUgiqftKlEw9CVeQ+MxK4K7Vk3L14Z
	 a21YuPfDYBf6hg4mcv9igIx/IoJ5kLPbExfXDRi7Da85dU14m4HGwVs+UubXpK1WPUst+
	 3pcaAjru1Mn/5jFLFc7jyr19Yn+P6lOyObiePf4lizfF4W3kpMA7rQgCBZfHfF8uvbcZN
	 FJFL3xhTv0EhShwYzlnnZTAp073cyJcgp9KNgFCwr1XZzkP1ugcnvvMS72EbbSN7X51Y/
	 CF7dWy9t+/uRron4jTrXJHUtURU0qmgoEJzasLdYQZL4FU2gkmnL345apDq3h9vwZNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mI+RtFAE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A132F606A31C;
	Tue, 17 Nov 2026 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mI+RtFAE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990FC1F000C7;
	Tue, 17 Nov 2026 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929435;
	bh=5lOKQnYpBQXP/LqZtNZmh3g/ieWlMy/xv2FIvUgYpFI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mI+RtFAEcn5Hw4odFPChttgaFUbLfFiiepqhcIBr06gsDMBTbdBynxPb3I8iXZBgx
	 sZxgiqxDSL0Mzj1HbRf6jRrhO4MbbW9cHIccSv6WE7yNQobUCJxwwTmGpSAyj2XyUT
	 d7A1xyt7UPtnKkuKUVN5aQvH5WQjq+umbf5mAxdkiaGiiNOOVafTh0uiDePubNjp/L
	 vzKR6ZI0CUblCj/yx5GF5M5wR6N+KpQsW4skpTahWlgB6MED0JbDdRi8HYlHxucdUn
	 6gQUad3fBIQKidPyNLFQ6q0s5wHrkNbZ0NaI/4R5XoO5fb3ZYoPOKGKDbeWZxy7ICh
	 HMpqNNYoPwYqw==
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
Subject: Re: [PATCH v5 08/12] rust: mm: add abstractions for allocating from
 a `sheaf`
In-Reply-To: <8a73da1c-0167-4aa5-a62c-4190327685cd@kernel.org>
References: <20260902-xarray-entry-send-v5-0-d18adae40708@kernel.org>
 <20260902-xarray-entry-send-v5-8-d18adae40708@kernel.org>
 <8a73da1c-0167-4aa5-a62c-4190327685cd@kernel.org>
Date: Tue, 17 Nov 2026 16:30:20 +0100
Message-ID: <87cxs3v5kj.fsf@t14s.mail-host-address-is-not-set>
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
>> Add Rust APIs for allocating objects from a `sheaf`.
>> 
>> Introduce a reduced abstraction `KMemCacheInit` for `struct kmem_cache` to
>> support management of the `Sheaf`s.
>> 
>> Initialize objects using in-place initialization when objects are allocated
>> from a `Sheaf`. This is different from C which tends to do some
>> initialization when the cache is filled. This approach is chosen because
>> there is no destructor/drop capability in `struct kmem_cache` that can be
>> invoked when the cache is dropped.
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
>
> Note that currently all caches have sheaves (except CONFIG_SLUB_TINY or
> slab_debug enabled), and sheaf_capacity on creation is treated as a minimum,
> which the automated sizing calculation can make larger - in case you want to
> reflect this detail in some of the description comments.

Thanks, I will update the documentation sections!


Best regards,
Andreas Hindborg


