Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679533;
	b=hCpvyNbVHI8F7ITWfNv8D3gZEAhslKEjlembd3KtjSoasv7fSJKdvRJfBxzKb/UcviNs
	 LTb9G95iJx6TaBdkZZvliEFYIgIjqMKGpulnlskERvBeVDUtH1ue6c2LLsUpXExMnKmhK
	 PB68kyhAJwly+4SBNVbA9tlp2k/umZKpbp/kDC6f3IRp72sOc8MIWyiYBEQczcyxd3+80
	 so0MaqFWzNyPeh6ZYeWEKctZ9wAUvjXzl6Dd6V4sD60f54OUKCJ4ukprdGbIf9cTmoOaz
	 BSqWVC74A+A9p6DzAgaFyDZr/Lgl0oFEfpBcw1TodH8edFud2OKb1ot3hKxed38KHQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679533;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sjgDRX59u2rhrH/aBYJ1iEOZp9hLuFc1LePhclHXlTc=;
	b=poTKUPeUdsq1HV0WE/NAFimJ8TybYkqQNF6+bB5s+28mcxhdXhkaiOxoTv69AsWYmtjB
	 h6T8sXDRMlD4nGvBBkQrrv4DktEENodHUaXKEX6k3PBV7e+pURyhpE4Jzn/aVHXNJAvCn
	 K3g3c+mLrC2KaivrxYwaiZ7D+GLlxkRYsbZ29IJMnXn4JtB8YvjoikI12bfAh4tLmXX1G
	 TfwvI4vs02qFxcL5ekr86LmxEhzGBeJSwhVVx92OLRC+vI64+u9UUD7bIvkzjwPZUqzDu
	 OY40j3htHAi4Iz5X0R/G3NLJHFrIg47EyCP4qTdlnTmvSWcyi0TPn2qZY3XS5K6WhYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fadt6nw5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29805606A31E;
	Thu, 26 Nov 2026 07:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fadt6nw5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1875D1F000CA;
	Thu, 26 Nov 2026 07:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795679532;
	bh=sjgDRX59u2rhrH/aBYJ1iEOZp9hLuFc1LePhclHXlTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fadt6nw5f9NwgOoSQr2Y2gIX72DaChYa9vbQkh82kHAorFqTVRcmtU8m/Tn9PCOM5
	 vQE2vWQ8ZmNE7u1ZQIyRLTarwXLI77JJ1MO+hA2x0YtQ4MUhgQuFa++CeOLaQgsHRR
	 mFs7oQPPhIcfc5e7r7mJaXLl5+3Y2Wf8moaxjjqeBjF8Aa5Qm8iTFqXLeK0ASeBQv0
	 oA/tU3UHb+mQxBnYUs2FzOjwGlHZgtMBJl6NEIuGMjIkJ023VmWJOxWzaxumMywRwV
	 hpZBEgo9bieA5T6j999O3EEcF4cA4q5p+87Mu1c5Xy6Xm8yUTCSZossQkYPpBIaGC0
	 s/cgt2h+cCKxw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: phasta@kernel.org, Tamir Duberstein <tamird@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>, Matthew Wilcox
 <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil
 Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, Hao Li
 <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes
 <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Daniel Gomez
 <da.gomez@samsung.com>, "Mukesh Kumar Chaurasiya (IBM)"
 <mkchauras@gmail.com>, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v6 00/12] rust: xarray: add entry API with preloading
In-Reply-To: <a6110f748b76b8773e0b5c9cb449a3bed0b19f36.camel@mailbox.org>
References: <20261120-xarray-entry-send-v6-0-1f69d7385f70@kernel.org>
 <a6110f748b76b8773e0b5c9cb449a3bed0b19f36.camel@mailbox.org>
Date: Thu, 26 Nov 2026 08:51:57 +0100
Message-ID: <875wxkuj1e.fsf@t14s.mail-host-address-is-not-set>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Philipp Stanner <phasta@mailbox.org> writes:

> On Fri, 2026-11-20 at 14:10 +0100, Andreas Hindborg wrote:
>> =C2=A0- Patches 8-9 add support for sheaf-based object caches.
>>=20
>> =C2=A0- Patch 10 enables sheaf support for the xarray kmem_cache.
>>=20
>> =C2=A0- Patch 11 adds preloading to the new entry API.
>
> Sorry for my ignorance, I was out of the loop here. What's actually the
> purpose of this series? What's your user, and what is it going to do?

As by the cover letter

  The feature additions in this series are dependencies for the rust null
  block driver, most of which is still downstream.

Specifically, we are inserting to into the XArray while holding a
`SpinLock` [1]. If the path of the inserted key has not yet been
allocated, the XArray must acquire some memory to build the path.

Best regards,
Andreas Hindborg


[1] https://github.com/metaspace/linux/blob/9c0fceca4feed5f1056f55abe9c7c70=
731402776/drivers/block/rnull/disk_storage.rs#L185

