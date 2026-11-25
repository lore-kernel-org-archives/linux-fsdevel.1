Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609662;
	b=cIvUFAvKQ0sL0XrEKuajYQDZ+1FUmsvG48FOLP1Y9GWw8oRinnIQb3K/k8W+ZwYl6TnS
	 1trozqDfhv45mggZDyWJ6W+uyCzMdOx8OBgGU8dbtp8PGAyD/jFt1mvDLgPtxAVYmPiIO
	 GkoPpmtsf/LZ1LSfe/2oIVMOmCm0kioWwqd6gdYXb7IJx3qclIY9POVFZdnfvs/ixnANu
	 N4Nn68uwKAFDvO4raQsoNIwUVZLs3cHSnve9PrMfQ7sdNPvu2m7r3MdxrV1Ls+768WNkZ
	 fdwKyRo4Za4irOhkr26sGxH2prNvrmolakI2bxcCsXwa7ixj9aUXCY+BlU+zilyrKdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609662;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-ID:
	 X-MBO-RS-META;
	bh=lJfkmXEGgWlf5jvEyn1umHHyxSpxElVlkFA7f2v9XCQ=;
	b=X9OtX9QX/jLEDQsKIRbIR6wdJctrhN23xlsxzIECi0VZDdgrWjYOvHiG5Y5SuxTACwEM
	 rsZK143/zcPQ9i24OZnJo/66KT814GNfBEsK/V5C9lCO4J7fP8FBfgJjgi+0DG6UjcJNL
	 Tb0jXXSmI7qXd9ngzHyVk1Q5nAeHFMGQpYD3n1J2Hz9l0F6ljVKhhfeJ2nAalsWXCGzGO
	 jf/yJJZrqQHIDseo6ZhZskJpi30SagzR/5/2jxdnr/VwyAz3BsbT/mNx51+C72zNnJjMe
	 hfn6XIWeSE/MktlQlA7RoyoN/3Jray7QL18c84nfOYYvSbFfQ2yl0BuTSLB2AOk23pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Pmk5lpnV;
	arc=none smtp.remote-ip=80.241.56.172
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD56B606A321;
	Wed, 25 Nov 2026 12:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD56B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Pmk5lpnV
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jZJpy681zzMkyB;
	Wed, 25 Nov 2026 13:27:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795609658; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lJfkmXEGgWlf5jvEyn1umHHyxSpxElVlkFA7f2v9XCQ=;
	b=Pmk5lpnVtSVS5KU/tqDa4sbjTFfwzYoxGv2RNZvhaFs5SwXW5I883wOvib3tSwb4oUSeZH
	HNcvEgKY8W+OxHB7VqeVjnhrM+T98Q0UsR0u6TeGTiBoemvNhLfL6wrqtupDgciSXzR1Vz
	Zvta/C9slVOa4vZcQk8cnQ3ghz+SJGnfVRlr24vZFV/Oi+hYxjuSb8rubA/FX3GeyEi0XJ
	Isuwsm5RFnFqJAST/CsVvsEiyE1UjP5f8k112jDuLoTlKcKuVglgjSHB5V7doWNZkHHlq5
	cAwrJ1EJkSyeETPpMyXfuIQDG3+7CIOnjyhpsNvqOorjiBnZTe2RYABih6j6Tw==
Message-ID: <1b9bd865e29501ce03c9800eac57fba201a59453.camel@mailbox.org>
Subject: Re: [PATCH v6 03/12] xarray: move xas_result() and
 xa_zero_to_null() to the header
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Andreas Hindborg <a.hindborg@kernel.org>, Tamir Duberstein	
 <tamird@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng	
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Alice Ryhl	 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich	 <dakr@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?ISO-8859-1?Q?=D6zkan?= <work@onurozkan.dev>, Matthew Wilcox	
 <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Lorenzo
 Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil
 Babka	 <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, Hao Li
 <hao.li@linux.dev>,  Christoph Lameter	 <cl@gentwo.org>, David Rientjes
 <rientjes@google.com>, Roman Gushchin	 <roman.gushchin@linux.dev>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Date: Wed, 25 Nov 2026 13:27:33 +0100
In-Reply-To: <20261120-xarray-entry-send-v6-3-1f69d7385f70@kernel.org>
References: <20261120-xarray-entry-send-v6-0-1f69d7385f70@kernel.org>
	 <20261120-xarray-entry-send-v6-3-1f69d7385f70@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MBO-RS-ID: c2d8928b0c20ba3349d
X-MBO-RS-META: 5e8fjf3t8zfir3d7ux8zr8gc3j8uwr8w

On Fri, 2026-11-20 at 14:10 +0100, Andreas Hindborg wrote:
> The functions xas_result() and xa_zero_to_null() are static in
> lib/xarray.c. Upcoming Rust XArray changes need to call them from
> Rust helper functions. Move them to include/linux/xarray.h as static
> inline functions, following the approach of commit 79ada2ae6615
> ("xarray: extract helper from __xa_{insert,cmpxchg}").
>=20
> No functional change.
>=20
> Suggested-by: Tamir Duberstein <tamird@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Philipp Stanner <phasta@kernel.org>
