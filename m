Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795270657;
	b=dFTco9ZGNWfTG46SUQbf7gLvrDMTJJGX/DXQSgielITS8WkS/ddd+QXiDUqL/S/xEEy4
	 jZ22dWbN5TU2TPB5BgtPiOJPkQn2N1nE1ETwWN9OldL+m+BiNbxciXUM1MnZtvj7llsEH
	 eGPueEw0UqUQ34QlKOnmzxZkGH+0c+Hk9d53/xtxGlExn24az5Njt+x/B5AtJdBUZRl/0
	 RPMm/Uh7ZBLSttsnIiYi+Yy7CvZxlNL7Hn/sCkBJpbv42SAfldBla5PtsGftpf3N3KYzn
	 LKMgATt7s5zaa+QuejqBRLhbknCXb5dPMZ9qlRUfcF3ikaz2kOLHlPJ7gEM8Qz/mH+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795270657;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=sFlfbs6Vr7PfYCSMBHpJ9X6tKrWXkYKKM8XUMpezu9Q=;
	b=0SsHklJQnlwJYcH3cQbdtOT0i6+GaV3dZbMeHSeazce/Tkhy6EbjfXTWh3hZ7VB6LoQl
	 dHOfrDE5NCQlEmSQZ5W0n8CkMeXngSW5KXFBrmeLG0Pw5BiaBfasYBbbTJXlVgYZUbmDu
	 IPPP2ZQnvKNLOFB41fMxVYAFrGy7Jyh8eHBDVB7r8RFH+8Gvx0T8xIMvhQvfTsBHq1S04
	 6TuG4WEsKo3VChrO1y/htToA9YbDNkWB4x+gTuxmS+XWBb1B1gWzxXsfjhKWa9mEYpCga
	 12Nt64EiTtNLE4vgFbUEr1vWdsFMfPelcJbh9NQu36SPZ3a/9FjdnAalfhH2ikTZxPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pv6YhcGt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA76606A320;
	Sat, 21 Nov 2026 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pv6YhcGt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE35C1F000C6;
	Sat, 21 Nov 2026 14:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795270657;
	bh=sFlfbs6Vr7PfYCSMBHpJ9X6tKrWXkYKKM8XUMpezu9Q=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=Pv6YhcGtJpVO6kd28ZFcMwlrc8lsqKYza9hNXQKHFQ6N2rbBtcqDEoZGbPLhWVFNg
	 wIVnjyiJpVrC2NhF8tOLVohtKE615nlWNmmmiaFXzlBwImS0Qd7t+3WHOMgGFBvC3r
	 GzsUGVFPAj6Yn14fbr1zuN11Wl5mFzFh4mkvL3fWKZ3qf9eX64bcSgXMW5dC/T8VVW
	 +if4hvG3Yzx/NgkLADbX3NpF4QpUjUSCpnVMgNpw3N5rS9WChOHpiVGyQ7hfTKfHCN
	 PC51U3nPevE+XKEzkslP1KRGQkrmqBJSFOJGqKPtdiVpQQzcVMIRpDtTesm+55o66V
	 KA9zrGzh/IEEQ==
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Nov 2026 15:17:31 +0100
Message-Id: <DN0YBZJNQVW4.2RY9NCR5T33HZ@kernel.org>
Subject: Re: [PATCH v6 08/12] rust: mm: add abstractions for allocating from
 a `sheaf`
Cc: "Tamir Duberstein" <tamird@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Matthew Wilcox" <willy@infradead.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, "Vlastimil Babka" <vbabka@kernel.org>,
 "Harry Yoo" <harry@kernel.org>, "Hao Li" <hao.li@linux.dev>, "Christoph
 Lameter" <cl@gentwo.org>, "David Rientjes" <rientjes@google.com>, "Roman
 Gushchin" <roman.gushchin@linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261120-xarray-entry-send-v6-0-1f69d7385f70@kernel.org>
 <20261120-xarray-entry-send-v6-8-1f69d7385f70@kernel.org>
In-Reply-To: <20261120-xarray-entry-send-v6-8-1f69d7385f70@kernel.org>

On Fri Nov 20, 2026 at 2:10 PM CET, Andreas Hindborg wrote:
> +/// An owned allocation from a cache sheaf.
> +///
> +/// `SBox` is similar to `Box` but is backed by a slab cache allocation =
obtained
> +/// through a [`Sheaf`]. It provides owned access to an initialized obje=
ct and
> +/// ensures the object is properly freed back to the cache when dropped.
> +///
> +/// The contained `T` is initialized when the `SBox` is returned from al=
loc and
> +/// dropped when the `SBox` is dropped.
> +///
> +/// An `SBox` holds a reference to the [`KMemCache`] it was allocated fr=
om.
> +/// Dropping the `SBox` may thus drop the last reference to the cache an=
d
> +/// destroy the cache, which may sleep. See the `# Context` section of
> +/// [`KMemCache`].
> +///
> +/// # Invariants
> +///
> +/// - `ptr` points to a valid, initialized object of type `T`.
> +/// - `cache` is the cache from which this object was allocated.
> +/// - The object remains valid for the lifetime of the `SBox`.
> +pub struct SBox<T: KMemCacheInit<T>> {
> +    ptr: NonNull<T>,
> +    cache: Arc<KMemCache<T>>,
> +}

I did only notice this patch just now, will take a closer look later on. Bu=
t
this all looks like it belongs into the alloc module.

Thanks,
Danilo
