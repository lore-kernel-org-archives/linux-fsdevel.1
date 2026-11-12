Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484147;
	b=KipmdyuVLf0yCVO24WPxKa75sFfRJA4VYQ6GNgDjDDxYC81K6cEkGOOO1+CJThk37Htq
	 ymi7pygT1T76hfYvUq0YL40JpWfn3pDnFF4Ph6mk/KPBECx9UL5pOJcXIGJDjZqKIkTti
	 YEflQuZGekHS+5rZ10wkblR5obGfclqWQzcYsAZksYSO/KUeLXfV7ke4VYKX5/B3WnCep
	 zTSOBS0aDOJNbYEpC+SEt6iz3TWFnKP2uxsab8QLF0OmOiHqOZohSBpLXhf6lHSfUY6P9
	 GDalN/7CPPvswEXlWOaAJYv/a44f15EaDrif+Uonnv+0AL60bICCHQ+MFOajsEvQVCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484147;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MKcG3X7dsKXAw4NNVjEt7ZV1vzPfMBBW0q4ysZTtxpk=;
	b=1C2fH9izsP9+q4c8EKjxSfRGWLZQFUiDMEnRHZeodigSUOo2QCf3rhJjFA6zApBZ4LjC
	 f4shaPhyRnpb1svBp7ChhwWolRf8tPt7xH4vQDtNytDhdUTKPWwx2tkk5IK5YS7ei6RD/
	 5yZRBDhDQeCWcjpqdtnONw/faT5Hm/FXEeZqR7Pxc1n4n/VxMZdzWe/iamZ3vrRQP8a3d
	 9c9/OzJFiasqSUx1kcXypiC17g6JUtZDrn1hNZNljnuNkC7v4Ox0Ey+1oOJGFM6IYxTgt
	 /GyJkP3FJZ+6WVv50keG4CVzSNPw4BkmJgU+cNG9h+JUSJNgO6OB256N4zyKRRjcKEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiDyh9CS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B0606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiDyh9CS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07851F00A05;
	Thu, 12 Nov 2026 11:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484147;
	bh=MKcG3X7dsKXAw4NNVjEt7ZV1vzPfMBBW0q4ysZTtxpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NiDyh9CSMf4fnMa1aXCvHZxu1XNPZLF0/Dl9XempRO4DnG2Rnv4Cg3GohFO4EBFz5
	 81EpjF4nYwMtW7DcmV9HhlhPBEuZxpj9uyD4iv4l+EKqjYt1CyiVf+ASqrTv29jCn3
	 vw7Cq+OEghXqj50p1/echU8vAtiEFP2pHx3+Q4f2zoGs8RITGhiQpBM9qNWaKvF/t9
	 ziJmXqbPJb/qA9zZhB4bk4YCtqBFzsbaLaPIXeFmU1UPyBqijY4Klvc2TZ7W6n9eeT
	 xG4p1Q4rF39lKl8yaiQimmWpvUVrLuHhJOiY8tpsIULS66Q4FRARKhqorLxL8+DzQm
	 tq7vXZ+PENnMA==
Date: Thu, 12 Nov 2026 13:48:58 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 2/6] mm: remove ARCH_NEEDS_KMAP_HIGH_GET
Message-ID: <avWnqt1E9ssKQDWt@kernel.org>
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-3-arnd@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112112528.1116405-3-arnd@kernel.org>

On Thu, Nov 12, 2026 at 12:25:24PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Arm has stopped setting ARCH_NEEDS_KMAP_HIGH_GET, so this
> is handled using the same wrappers across all architectures
> now, which leaves room for simplification.
> 
> Replace lock_kmap()/unlock_kmap() with open-coded spinlocks
> and drop the now empty arch_kmap_local_high_get() and
> kmap_high_unmap_local() helpers.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/highmem.c | 100 ++++++---------------------------------------------
>  1 file changed, 10 insertions(+), 90 deletions(-)

Nice :)

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>


-- 
Sincerely yours,
Mike.
