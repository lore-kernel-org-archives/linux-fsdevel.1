Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448636;
	b=w7oUvmjCzmIPW9+iJ6xXp2TiJpkN3xhbl4+G7gOS+aplHs+FOlAi3SfNvixLI79XPA8B
	 1W69SHTk+r9IKzhuhRINsFCIUBn2UnVc+U/gUKN1j4BG6ItMWxc4pLC7qQYAYT+X3RB60
	 NK6PK0Cdh2AWX/PWcflahfR35RdB7Mcx3mm3hflb0EaRje1yWcgsxS/kJqZg4q/L4YSPc
	 b7gFH+YT8q4KWHm/a6QV+7r/cosmz+uB+JksN1u5BRPVL6lKHXXQvHDp+vNlpHjc24Ugl
	 TiMXyuytU0n/jKbAdKGe8KKxPxsqs/j1qi9fJwWUOZzzIzY+57cEU5sgUtLHLUWQHvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448636;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=hBPO8PLZh/UMuGqLsh8NXe6Y8zhuf+A17Ivj1B29j0w=;
	b=ud6sQ72ELWgYjtXAnktU17SsqmM9/Dw1Ge17BQCqW1E8o5k3cxh+cne3K37aogwsVlbZ
	 aqdgmbG4Fi99Tr4DuTBczGypks4icJyQTW/ZcMyoCZjQj115I8Nh5QaJI79tFgzpNrDx9
	 ged7hQZXEqmpVu5lvJBQtX73syb7b0k734U4CaT1rwkGE7a1I3/OPZicpPpwP4JjGo8GA
	 WHn5Up83gmLtRzyOh7iba25j+7Ptujugs1wz+2yEKEKvU+yuxfXPQaGYJoIi9u7SlKule
	 G6aAqjG2j8gLET9cIDECaTtoBaqg0Jf31dRBWh1D4IjtzRY+Pr5OwRXZuUiNn/BUh9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iyOa9O5u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758A2606A31A;
	Mon, 23 Nov 2026 15:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iyOa9O5u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB5C1F000C4;
	Mon, 23 Nov 2026 15:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795448636;
	bh=hBPO8PLZh/UMuGqLsh8NXe6Y8zhuf+A17Ivj1B29j0w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=iyOa9O5u1hxkBN1iYeKSim3KOhj5jcUJNMQDYXDnqEGOmkJAMGeQLrzTFh+WHpntx
	 K9OOvxxzjl/Gl0PvdxP/UjAT1CWNjcoq2ZOneGSusAJrVZ9VP/fOoxIf10b+nHAYzi
	 StubXUlwEjKuzg/YW4RhCym6lkQYF6qrDRTz1IUVXl59jzKgZtfboNav3YeXY+qk26
	 7gsSgU/EiYkcQqCoTPiyu9qpfqAtnXhK//EFtHDaVs4anY3dcqWJ3IrAtLkVRYaQpf
	 HRNLIEihnz/7iJkFyCWrAs3j0Rwg0E7Rwdyz+szoCV774CKQb9TDQcTW0R3qTCQhrC
	 Z1ycA4RAGW+PQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Tamir Duberstein <tamird@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Matthew Wilcox <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>, 
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Andreas Hindborg <a.hindborg@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
 Daniel Gomez <da.gomez@samsung.com>, Tamir Duberstein <tamird@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>
In-Reply-To: <20261120-xarray-entry-send-v6-2-1f69d7385f70@kernel.org>
References: <20261120-xarray-entry-send-v6-2-1f69d7385f70@kernel.org>
Subject: Re: [PATCH v6 02/12] rust: xarray: add debug format for
 `StoreError`
Message-Id: <179544862193.2286374.1413505668892113541.b4-ty@b4>
Date: Mon, 23 Nov 2026 16:43:41 +0100
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Fri, 20 Nov 2026 14:10:13 +0100, Andreas Hindborg wrote:
> Add a `Debug` implementation for `StoreError<T>` to enable better error
> reporting and debugging. The implementation only displays the `error`
> field and omits the `value` field, as `T` may not implement `Debug`.

Applied, thanks!

[02/12] rust: xarray: add debug format for `StoreError`
        commit: fe0612239662b50da2fb7b95409be1f3aa7a2f1f

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


