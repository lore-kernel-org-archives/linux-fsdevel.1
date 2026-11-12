Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484458;
	b=ZipN+JCG6yMyz0kq7inH7dB3ktAWcPLvuIJ9gzL5/KAhdmr1yVVBaCXBASRysZnsMeiT
	 mlZAchuIvlYOUo+t+GIhuNKRrr/3ro2clXYf+CxinBwTrpHsNv/zdYglRDj72Xny1cS1b
	 iuOdgjpmGLWH7rcz1ONx8EWTskQf/K7G1o4HEniUqWp8CzpXrYLnl41OQgFE+P72ItlvY
	 PuN76pizMiNUdyYgWK/Yj0Xq0JO07DqqIxB5dRWvLQ5OndNpujbKvYdlfDsdSCGIE9788
	 S+4FgjSzPwUwsqjCRZafpCjC9/pXdf3ynueLf61yOPkq0pU/gHtGXWMDqsUyyfUtnqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484458;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AXwEBWpVcpvZcrV+jXWqjYnIWZkbHRe6QYcaP4OKLgA=;
	b=xzdiyvuz+5pC0udD0wraUj/N5UemgFfYZuZoVs+FxXB+rsUDrtBuWacmEJr356yeBS0i
	 VO9tuvJUXDaOilKTdjQYelmxvKu1Ovf4Rrgk/MOS1tTwBYVkCIBvFkOFtCjyCdgaqokqB
	 clCL40xD4FNRQbT/91TmNvmiwrnR+9GJBalsjsKiZOeXOClb2my/Lth2qqgQhCwRbawWe
	 /iWusyfDXaMDqqilwvpNLSswLhXs4MjDzHgX17O5suvEQscsdFyU6r5TWWE3wPlnbaAQm
	 OLy7kHs0aBNwkX2kEXWoDEsSlugY8w7iXbVBEgOI23HP82JVh8h2iPUXYqbeU3WoJgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JShWTYBw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB5606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JShWTYBw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A951F00A05;
	Thu, 12 Nov 2026 11:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484457;
	bh=AXwEBWpVcpvZcrV+jXWqjYnIWZkbHRe6QYcaP4OKLgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JShWTYBwz3T1m0D+gMlzyAXZUOV5lZTEdKWEmPLNzsIRW+v6wGYjzrWz/3a+qlIIh
	 uHEBwZWTzfI+8nM1pcwM53SGkhGVtDsLBHshuYSxtzNG61JCXbS2MprM5hV/RW220H
	 EL1fsA/x1UUGroAbYZBw+qSGfyZB4AOspBYFjnzgVnaVolzaeMfQXuiyzSNiu/Vp5y
	 FZk8uOr8DWU5XDcsKIwXsglFSq2MXx57+zvKA08GWuWTcIghT/EEC8a7yprTEzE1K1
	 C3sWmvVFn06QL/mupd6DGhe9ParugCE3t4qUWqqEJB1lwXJ/5dePwtcAucWejA+WvE
	 v93jIoibDc7rw==
Date: Thu, 12 Nov 2026 13:54:08 +0200
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
Subject: Re: [PATCH v2 4/6] mm: drop HIGHPTE support altogether
Message-ID: <avWo4NrAPX8BisCY@kernel.org>
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-5-arnd@kernel.org>
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
In-Reply-To: <20261112112528.1116405-5-arnd@kernel.org>

On Thu, Nov 12, 2026 at 12:25:26PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With both x86 and arm having dropped CONFIG_HIGHPTE support, no
> architecture is left using it, so remove the remnants in common code.
> 
> It is likely that further cleanups are possible in the page table
> code but those are not obvious from the config options.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/hugetlb.h | 5 +----
>  include/linux/mm.h      | 1 -
>  include/linux/pgtable.h | 9 ---------
>  3 files changed, 1 insertion(+), 14 deletions(-)

With this and arm HIGHPTE patches applied there are still a few leftovers:

$ git grep  HIGHPTE
arch/arm/configs/vt8500_v6_v7_defconfig:CONFIG_HIGHPTE=y
mm/memory.c:     * Dumping the PTE would be nice, but it's tricky with CONFIG_HIGHPTE,
mm/pgtable-generic.c: * kmapped if necessary (when CONFIG_HIGHPTE), and locked against concurrent
mm/userfaultfd.c:        * index ordering when CONFIG_HIGHPTE is enabled. We mapped dst_pte

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.
