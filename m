Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794909696;
	b=bhnGGtpKLO1H1L/HgGWfrWrsvqmu3fMA1vDpTGeac4onE3Ua+6J4OVMGuVYlYCgLxnw+
	 OHup8eaTRbsPCMzKt2KEg9QFw4jJRh/z+zp57YWo/wHa9YTIA5PxuVs2eP6XFMd/qJ3K4
	 7nmVbQ/RKsdj+yzVG5t0l4BsWscVvU+zM0saAegwC/w8x+gucyfPi0C9fB9TMQPc2XnB5
	 CAFRNWHm4GqJ2oZdQ2PBQYciwl1CVE1UROUuxJgktmBWaM/bTZDMBBNlFjahZ1ShnJ6G5
	 pxM74mGv5VxuHImV00ZzItPRLp1O2D5qiCU+zzxc/7/5LWUiOj/QzXJuxgt6QWC3Hjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794909696;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5oABWPCQflLUdKTbaIQUUOlSS1RGm0erDPyxm9dVT7E=;
	b=z1wmKrOQkXOm+3tS5Kee5+mDejzioENV/uQdZxJBqx4aVCYQqdgY+lRCNOvqFDTKWOIz
	 D8rR+aCx24L4qzRp7V/InviaKxr3/xzVWKyhCouYd9VyDr+oSMfe5e/poy4v+zPsF2XPd
	 ZxFr+LNGRoECpltRMQB0nsVvg8lRu10RIL7COHXGWu+kb8n1G9C0eLFBsksYTVC/gTx0Y
	 5X9/ZK2YE7gCodUkE/1Mp4X42/sbcB/VAq/QXoYpbxb2U3F/CeVkQNvgmwrvJahXJLo9M
	 gb7EDrkkMlcrilCZCFu5EZh09TMke8EZkNPA8Cxwuth+ezU+WDuPp80l9HrmzuAlHjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPjlXGFn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AABB606A31C
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dPjlXGFn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4D01F0092A
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 10:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794909695;
	bh=5oABWPCQflLUdKTbaIQUUOlSS1RGm0erDPyxm9dVT7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=dPjlXGFn5f1uNLVj3maDK+PGwOiHUTLKPCiWcOPWQuNfUhLUbp6oxT6soenc0wGQV
	 oWgyb5J4i1Kg0rmJgW2eNt4MpdQ3b4Ahn+Fef0DGpgxVCZLfZsdUw8k4vSie8EbdAe
	 iK+lK9TP8Zd9NvOkly3FuyUY9E4YyrHjK2JgeLI7aENbnoUQglZA9fM48fgqtKTIMA
	 NUhvwDSr5V6Y3tHT9bbaJlSCsu85TLKRmIZjwZVraiNDn+i8Rj+ADMP/fvBx8fjeF8
	 gWcTc91iOVB4TFYWYiQdGhKEIvsdtGUK/w2BVfR9OCuJI7o7iHEc0rTkW14emkxjMV
	 CgqySzLCi3lnw==
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7cc0e865dd1so1358452137.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Nov 2026 02:01:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGTTi1u43y3Fvr2j7oLNjIX1vu2g1wjVV2A6c1kK9SBLcaNSjOxVWEokUuXTwG6KGs1NwBD11GgWOeSPGQg@vger.kernel.org
X-Gm-Message-State: APuU4Z/dcS3fkBuk2Zh/Z/jnnhG4QHlmh8m+YYfOg/Z/714sFfZR7fF2
	KGfl8afN3lqGbLBHJlk85VM6Ah+zjRxuXVWdgor3QrlpWMyu3D5MNWwuzQrDvm7mZlm98Bokn2m
	i1PIWcVA/ui0Q3hT/lvjsV8LtU1fA6/4=
X-Received: by 2002:a05:6102:3eca:b0:7c3:6466:3155 with SMTP id
 ada2fe7eead31-7d64d8da06cmr3888168137.33.1794909694939; Tue, 17 Nov 2026
 02:01:34 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-unused-sym-mm-v2-0-2f845e94dd50@amd.com> <20261117-unused-sym-mm-v2-1-2f845e94dd50@amd.com>
In-Reply-To: <20261117-unused-sym-mm-v2-1-2f845e94dd50@amd.com>
From: Barry Song <baohua@kernel.org>
Date: Tue, 17 Nov 2026 18:01:22 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yteXmuK=UUyBjKFSkKsX=+pOJxRXcCoxf=Xeq8EgCEkw@mail.gmail.com>
X-Gm-Features: Aa3M54p76ruRPy5nC_e2T_VRxviAo5UTb8trf4PyX1lbTffANmrCzu4bfZBZpDk
Message-ID: <CAGsJ_4yteXmuK=UUyBjKFSkKsX=+pOJxRXcCoxf=Xeq8EgCEkw@mail.gmail.com>
Subject: Re: [PATCH mm-new v2 1/5] mm: remove unused helpers from pagemap.h
To: Shivank Garg <shivankg@amd.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
	Youngjun Park <youngjun.park@lge.com>, Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 3:17=E2=80=AFPM Shivank Garg <shivankg@amd.com> wro=
te:
>
> invalidate_remote_inode() lost its last user in commit d73065e60dcc
> ("afs: Use alternative invalidation to using launder_folio").
> mapping_clear_release_always() has no callers.
>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>
