Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448643;
	b=nhqZSwS4/UFCSyquR1fZb/Sf7NTWzRAEv/0k7f4BAqvYPTngjEzuM2zI4k1Oh6B4724A
	 hS+Qawmlg/i1hdqPr88DGUgS8dgwfWo/BQV0oFtmqw2dG4hG7ROuHF/9IvohkI+aduRnT
	 Yf5bN7ptTSlQAAKeytm14GWceM0d1VLnsqRvEDsvBGVYcw4mAPw0SpCptWt3Ubhpj9qEw
	 4T5YXLUd+tHYMj9MIibxFJLeB5gLENb6V1cTDnqVnIjUyd6QYb7fXhimu27fGRnom/oYy
	 tp6AR4fy7RxdqF45XrSrmTV4wVT/j4xU0p/nYfFnd+1vt69hn6tm7MZ3rWZEzJDMmhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448643;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=o3SOCtJoKICNsA1ttJ020LJOorIPqLqxhGmSDBRPhw0=;
	b=d47ZjSPYnE2naXF9pRu14cFV9A9GsvNbAGpUKstjo0LK7a8hywt4m/M/IZgyvB1/C8X0
	 h5YaL2QnO9wLdUJ7UvZhRKid/pvBPQ9BUBwfT/qGE5VFfwF7KjFk2+rDxvvqCaf+FAU+c
	 d7wT4kHK2wICdFxesqfA4PVjdTEM0sAxPyDLfRXZcDnvP+0XBrevoz7T0w3++/Pdd9dvE
	 C2Xka5phn20P15MbNj/nrD2iZ6GXlpBxhL6U1ZGJE6DkM4dwmIHyEDhMAJE6LYnxqGeUp
	 4Gxsw1u/LVOlw0a82cFezh9eySs0GGcY2dt1x62z1U71KnmMeo0/Gussq8bSNiFkhzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Th2i2qeV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934DD606A334;
	Mon, 23 Nov 2026 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Th2i2qeV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221481F000D8;
	Mon, 23 Nov 2026 15:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795448643;
	bh=o3SOCtJoKICNsA1ttJ020LJOorIPqLqxhGmSDBRPhw0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Th2i2qeVV+3UqjBguZyjAQDAFIoyWMKuiTL1pshJSMujAM0dt1bpZ5xTHBOavBkOk
	 co26wj1mVHb+tbSpaDj+K5PYIKyN4KJ6y6PA1OoUMqE1Y72nP6Jj5KPCWASS6LIdOt
	 u0XRu7SxOWPk2gI+seKgn3UIHB17yZ7/KMGOtTD2/ZCFVMLDenoe0Vnxa40BQbXBiD
	 XOwlIVBBtTBUSBPAnP5GzwNlfZB92FmEeGSboGEOZEX7Eonc6UJRnsXBs6q0GynV3i
	 cd4p04WMsmf8iDFjqrlsdUwWrgxzqq55jhOpQdp+yQgumL6zE8NKlN46AnSKosU2QE
	 qG2RHrINsTPXQ==
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
 Daniel Gomez <da.gomez@samsung.com>, 
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>
In-Reply-To: <20261120-xarray-entry-send-v6-1-1f69d7385f70@kernel.org>
References: <20261120-xarray-entry-send-v6-1-1f69d7385f70@kernel.org>
Subject: Re: [PATCH v6 01/12] rust: xarray: minor formatting fixes
Message-Id: <179544862191.2286374.18027596474344839534.b4-ty@b4>
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


On Fri, 20 Nov 2026 14:10:12 +0100, Andreas Hindborg wrote:
> Fix formatting in xarray module to comply with kernel coding
> guidelines:
> 
> - Update use clauses to use vertical layout with each import on its
>   own line.
> - Add trailing empty comments to preserve formatting and prevent
>   rustfmt from collapsing imports.
> - Refer to the kernel crate as `kernel` rather than `crate` in use
>   clauses.
> - Break long assert_eq! statement in documentation across multiple
>   lines for better readability.
> 
> [...]

Applied, thanks!

[01/12] rust: xarray: minor formatting fixes
        commit: 62cac56c118c96bf2026275a0edc80f1b3a87375

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


