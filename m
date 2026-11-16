Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794834026;
	b=bZjXqs7UaRsmbeV/1m7EIGsa4BR6mufyvlbVAEOFctl58p5cz8f+Asrq4QTEDOdt4Y6c
	 qDs2iRLdBwh3zE9cDzqCogYQl2TCnbeKzjGIRz6UW2RqTBHorgEYXK2eJJWCASjH3WP7N
	 Yt+ap9+QuXKZCpNk4xp93m6VyEtY6w3gjq5cq6qVsm+p3nRVrzTeLZTfla/j3h7Et6GVX
	 apFcx5p0vCXl+sUgSkbZhGTuDp+l/fGD7GgI7vcDGJ2K2bExMn9NdQcbL1XaFqGQ00+GR
	 GOftVEoIfMLg27a5YlByYrduAyBqbCu4P7jhK7MLXF/C95+29shyokbRbyEwGEIoTww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794834026;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=y5R7blodr4KyIr57H0lgE0jfeLfnu8xOhBhiMifpgVk=;
	b=sQv/o3wVJslOmFTXIux80k8PV77aIMDIDqVscIzuRsOblh61O8SWT2H2HsNnX+yVGH8V
	 9Oa53v8xzDY4eZDJJGTdvY9Pa3qJS9TYgNhjqwkM97y0/C8zsYo51stT9pYnMN9pZLNuc
	 fvaSKHi6baKnN01Fw2/MbEyiSHh3gCRyAmfbMCYX+vzQHTpghF/8RW6PEe6feuiCpUXvq
	 z5snwkTpyfuviMOmRTbakadG9KDsE21W0/OG6BbOtAJ435nhWfC5vImnurW4uXQ1A64vQ
	 1Lt+fWxuRZ8BuaW0hRc76R8tl/SsaKr7iXp6geppB7NGcJ6XH/zxldWQL4DxKo7GBCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tn81L3WM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB46606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tn81L3WM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373501F000C4;
	Mon, 16 Nov 2026 13:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794834026;
	bh=y5R7blodr4KyIr57H0lgE0jfeLfnu8xOhBhiMifpgVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tn81L3WMTmVSVrFkStoUKS1eJlHCrwqf92DxGJzeE2QnNqJMBbbVy0Xjxt/pr1NlT
	 CC8inPJD0LToR+NrQVsp4zf7dInOG6i2QM2boXgjJrRapJHocK3+y96JvGlfrph2/w
	 VXKZJNkxdWHXEYeGBcIoe7vawFNBAvw9sSR3HQWmuqHqve768kdXbPrsGZA0puqQ/U
	 yuS8sDgebbsOqC3RdflJEQf0pctSVBEO2uDerS+IZULL8JNTLEPvROidufB+eCHmzL
	 yMXMkEn0k8odvkMvxrOrO/2iUiNR4AFj1hQ8PmnBp98gNt5wQCNSqKvRpPec6xzXUA
	 Lqp/ok8GxpgoA==
Date: Mon, 16 Nov 2026 15:00:14 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Linus Walleij <linusw@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Lucas Stach <l.stach@pengutronix.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Malin Jonsson <malin.jonsson@est.tech>,
	Matthew Wilcox <willy@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Nicholas Piggin <npiggin@gmail.com>, Nishanth Menon <nm@ti.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v3 10/10] mm: print pte in __print_bad_page_map_pgtable()
Message-ID: <avr-Xjdqrb8Ja1E1@kernel.org>
References: <20261116124832.662455-1-arnd@kernel.org>
 <20261116124832.662455-11-arnd@kernel.org>
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
In-Reply-To: <20261116124832.662455-11-arnd@kernel.org>

On Mon, Nov 16, 2026 at 01:48:32PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> HIGHPTE support is gone now, so it's easy enough to print the
> PTE here along with the upper level entries.
> 
> Acked-by: "David Hildenbrand (Arm)" <david@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/memory.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)

-- 
Sincerely yours,
Mike.
