Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352008;
	b=tRFxfGUKfBtwDU+5CaIaEKgnva3253oI5UFQs0TjvWP5BJF6FQC9K0t5Hbj1ciGtgi35
	 q0dOTFgA+aieKSRV9wu3TtwWiMTmLZtsVvB6c0MSnUTj/jUaeXXKE8OLPsoh/qtVFlfG9
	 U2fa+Qo6Iu8nyyd47mzqkC7rTxj2ukcsJfWtYWq7ZzsUcRaCCrEeBN3CIMtK/zfnfoAcA
	 lCy21yV1lPqJCXom7Ev2bXYx7Fr4iBxqXfhzs1kwrEP3aEGodxCP3b7XrZ0EvFWspHpvV
	 1q2bIreL34kN9sLkkalZ9skEldOS7ZGd4jA5XyO5c1YJjaLhUScpA0dlaEE25MxQvFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352008;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer;
	bh=uyCrS3trZJ5YkE9uiv746PMfpKl6S+0MjX103j94QEY=;
	b=GL+GMOQhUAurHEIc1cdxCfkemtwaxp6bNoX8mqIi+f3amldiL4stWGIz/nQZHKFDGggk
	 EkC++I0U+q23YklNChH8ex79QwNVSnLjDR0ipdMrbvpD1C2OvzPmSWZQGXoE0hO4Il7r+
	 Ml7OslWM7oAu6UwIDy/eb4pl6w/lZGLk0/omllnQz/d3ex97zbs/7GgqjfIhpZXYpvYdi
	 9EpVsEr1Y1I0sG0BjLqq/a8o7yYNKvwzUwkzrO/cx4w5/QcsWxUoTEmgrLL1QY6NR1h5m
	 OXESzATqLSh4uti+GrwxxvD5GeReWXm6UYxfvIz7NYUN2lRbAEDaTJEVjwUs8iC2heA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiovnmKr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF9F606A329;
	Fri, 30 Oct 2026 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZiovnmKr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650CA1F00A02;
	Fri, 30 Oct 2026 09:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793352008;
	bh=uyCrS3trZJ5YkE9uiv746PMfpKl6S+0MjX103j94QEY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZiovnmKrsbRP2VmxkyKnd/smnpW9g2XeHW0OgwBRw81hFTmlrAmSSvb3ln6dSEnpS
	 ELLxvhCk2YPWZNnGj1a2svlnm2Na5/RJ4FOkfREQuyZ9aNduDaW4TwX4bbf+HFDNvO
	 ZOW3cwjUdvtUc0MBnsN2cT+qrQ1MNpIwWR3+JWrcj0gXh2ZJxhXcFodPEAbFHB7QxH
	 vL5+HmXsf1mA2ITlitEbSNIr5z0W/a1kRfCOwKoMcla/Q5jot2XcbOaq0qvs6pxPJ3
	 8WimzQ7l1rfc5b8a6lGS5lMdHJT3JFOW+bs53Ca2UPZtIQ/R8n/v/3EtJUJ0JpQrNo
	 k/2vTfw6psolw==
Date: Fri, 30 Oct 2026 10:19:27 +0100
From: Daniel Gomez <da.gomez@kernel.org>
To: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, Björn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Onur Özkan <work@onurozkan.dev>, Andrew Morton <akpm@linux-foundation.org>, Julia Lawall <Julia.Lawall@inria.fr>, Corinn Tiffany <corinn.tiffany@inria.fr>, Liam R. Howlett <liam@infradead.org>, Philipp Stanner <pstanner@redhat.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Samsung GOST <gost.dev@samsung.com>, Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [GIT PULL] Rust XArray for v7.4
Message-ID: <20261030101626.0-da.gomez@kernel.org>
In-Reply-To: <20261012115028.73246-1-da.gomez@kernel.org>
References: <20261012115028.73246-1-da.gomez@kernel.org>
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
X-Mailer: lorebird

On 2026-10-12T13:50:26+02:00, Daniel Gomez <da.gomez@kernel.org> wrote:
> Hi Matthew,
>
> I'm sending the Rust XArray for the current v7.4 cycle, although it is
> probably too late for it. Just let me know if you need me to resend it
> later, rebased or under a different tag.

This missed the v7.4 merge window, so please drop it.

I'll send a new one for v7.5 based on rc2. I'm also asking Mark Brown
to add rxarray-next to linux-next. Let me know if you'd prefer something
else.

Could you confirm by v7.4-rc5 that you can take it?

