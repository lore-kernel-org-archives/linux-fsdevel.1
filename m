Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610819;
	b=0kImpMyGoFAhIGt6gfBPdt7XjOmzcnil7/VwCvclykMs2p1d4pbcaXv2G506Ky17OxCT
	 Po/S/YwXlYmWWrXWDoHZF1bSHALXv2QWMyqLP1RsnuZV2Xyozrrqd9AQVyod5LfB5+GQ7
	 4TPkHHLaR9qmwiXO+iuc3Qcphrv2GUV7PAlpUL5J50M2jhcyagkFrjQhevogWToOE3aFi
	 TEO66f06UgexLgYH3UmObbpHwdvOBcmsnraJMV4J9OctJK16qyNrSgVC/uXzDZwfBJxrz
	 Yt2eAj/HjMx4anZ2SFaeZiAzKK68Jg3BQrNdXyNyXmBDt/BL9IuYePAv3xKNukbP3iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610819;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-ID:
	 X-MBO-RS-META;
	bh=T3MOwzx9XuXBLF1Dj/6JoALu/Hn/CMkytQ7thbURciM=;
	b=ES8IO5oGYGQK4qiwWOn0moB86bNwJif75RLpT1Oy/OzzV4h+EuuAKZvFtzrNJqsOwfzJ
	 D+XbtXueR3lMhvRR1dtU0AQNfCITqxS3ze28XPZpCCNmifsereRGtiyzE6+eh0clq7dwj
	 lsOxWoPZ6JZe4YKUbLsnkE1WKQ1kzg6DwMVa2nkFUiyZio2cgqj1TRwdZa8I46nXTiuXm
	 LYXQkgtYpV5SAv269HBJaf/r3Dg/iyTSlD7DnUe6Jt4Qzqbz0AY9ktoxFekVLpFhLZUDv
	 92EJUImOL7DTnTrtEhob9koWi78FjWxw9qwRPcGNG1bneWk9TPtCPw1neOQhaJFgqug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=nnB1IeP5;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0694606A31E;
	Wed, 25 Nov 2026 12:46:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0694606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=nnB1IeP5
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jZKF606zHzKmSh;
	Wed, 25 Nov 2026 13:46:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1795610810; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3MOwzx9XuXBLF1Dj/6JoALu/Hn/CMkytQ7thbURciM=;
	b=nnB1IeP5yjj9ODqIsOpsLIKLZGhjixC8mZZ8P6Pbd4JOz7OCHCf8y8Cxx5uqGFs3mTej4g
	lnCPNfU0kgGQsm4vt2wZKbCI2gQ8oomYEn9KDtInhmY+LMuWVmv64regr2GUW2OdViCx0+
	dlM+SmMzKiMR0AYBXicyIDWEE/BtVnDiKWdX3JxwEWDxiWxwKebFZlbrdbz+ipMw5oGenK
	i6B/BLiUbNqBkCUYMZEV7ghI+uLMHv9v8IiR4zPRTBrt5aiypfIGh2fW/OBesI39Ksbgpd
	3gkCb8qtiQaBbJ9NkCCuSdjAPToBXdDizAkT0aYucntdq/f51divrZwalsinfg==
Message-ID: <a6110f748b76b8773e0b5c9cb449a3bed0b19f36.camel@mailbox.org>
Subject: Re: [PATCH v6 00/12] rust: xarray: add entry API with preloading
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
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, Daniel Gomez	
 <da.gomez@samsung.com>, "Mukesh Kumar Chaurasiya (IBM)"
 <mkchauras@gmail.com>,  Sashiko <sashiko-bot@kernel.org>
Date: Wed, 25 Nov 2026 13:46:44 +0100
In-Reply-To: <20261120-xarray-entry-send-v6-0-1f69d7385f70@kernel.org>
References: <20261120-xarray-entry-send-v6-0-1f69d7385f70@kernel.org>
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
X-MBO-RS-ID: 4eed8370bf969ed1124
X-MBO-RS-META: ssgee3yfec9ykzuo1a3ycdtcq3w1izm3

On Fri, 2026-11-20 at 14:10 +0100, Andreas Hindborg wrote:
> =C2=A0- Patches 8-9 add support for sheaf-based object caches.
>=20
> =C2=A0- Patch 10 enables sheaf support for the xarray kmem_cache.
>=20
> =C2=A0- Patch 11 adds preloading to the new entry API.

Sorry for my ignorance, I was out of the loop here. What's actually the
purpose of this series? What's your user, and what is it going to do?


P.
