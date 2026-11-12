Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794484824;
	b=VxCiW3Q9anBLa6iYLATDVqGEEdbjCX4b9/6mjkGHmhk1PTRENcv+H8mraMftUQdiZsh4
	 7OHmixLzghEiYmkdbYwkwDOI4tu46C5eu/h/lInEaikrEjYzM6LipX8BHtL/y3Vy763h2
	 6ygh7+qIS+0El8JAIZq6CKuJxXZDlGFoYQWhUxw7oJDKgmQk2GGBTPNDLPg2f8CvIAZOh
	 Dy61pe2F8Z8OmanfeE7y1Wet+9CWIrEC+c9JbZ8VU359p6ZR9HZuZkqCuN5uXfZYAUMdq
	 TqhEpa7DKUndSnqUAaG/6O/DBUnbs4inEa47X/KgcImdtxV48teg/Quu/vUqqfvOJUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794484824;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=wTN3UxTT/XXw7NH/F07ZSE1+SznsV7bVJZdXlw3Sm0E=;
	b=OxCQMxZEc4jp1JRQgsfHEPgWWd4+2dJf48yOeyqhUj7YIjSsmtvhKS+pc8IFHCoR5/L8
	 7nOCtmNgOTc84/XZw5aSUAVU8EsDwfvV0kr1BYY3Sm8Q1VjUeZZsUwszKK6isrA4fmr2N
	 +NE7FSa5SYgPEG3ZiK7lmF+MVQainmDKFZ3OECxbUQ+eNNWjXA1DRdPth6n7kCF54pIss
	 AoabH2jm4HUHot8wLRWv8zuItzRj/31Cow3cQGdQ3PNlyejLnDm5HWe4PimCFXWlif4Br
	 slMn8KaWW4YrWABI0VoECao1JotfG9sMUopLTqt/ysVbSh5S2IE7BbbjHN6YIEaSjJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mykMNeh5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24688606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 12:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mykMNeh5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869391F00A05;
	Thu, 12 Nov 2026 12:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794484823;
	bh=wTN3UxTT/XXw7NH/F07ZSE1+SznsV7bVJZdXlw3Sm0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mykMNeh5BtXxUerEKT1YuKhyGYJ7QWD8IG5KpF4NuP4taMISSoglro4vnkkgm5jw7
	 WQS/4vwRcKImTEfxhMYZ5wbg4cf0zsqSfNSCuEwHpTxLLpdEiTkzuh28KNZeLAVJNg
	 ZfCkbQmePV1CQjWwx2EMjuLDIhpJighraQGEfBeHC2UHTK/MwHz7f2oBCj4SrVNuE8
	 h5IIE+hXfIdS625oF8CuXci5blOoZ0531mmkrv2ibJ2+zxzA7PXsQSYWh5mHmJWrB0
	 v/bWt32FVQ52/8TNJggbPdO6bVuM9pAUdH6G57AlDfNOf/PKeeT3jQZcm5rv//GblC
	 jWyGILzZ6HoIw==
Date: Thu, 12 Nov 2026 14:00:11 +0200
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
	linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michal Simek <monstr@monstr.eu>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nishanth Menon <nm@ti.com>,
	Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH v2 5/6] arch/*: increase lowmem size to avoid highmem use
Message-ID: <avWqSw2YrUmfAX62@kernel.org>
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-6-arnd@kernel.org>
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
In-Reply-To: <20261112112528.1116405-6-arnd@kernel.org>

On Thu, Nov 12, 2026 at 12:25:27PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Most of the common 32-bit architectures (x86, arm, powerpc) all use the
> default virtual memory layout that was already in place for i386 systems
> in the 1990s, using exactly 3GiB of user TASK_SIZE, with the upper 1GiB
> of addresses split between (at most 896MiB) lowmem and vmalloc.

...

> Based on the above observations and the discussion at the kernel summit,
> change the defaults to the most appropriate values: use 1GiB of lowmem on
> non-highmem configurations, and either 2GiB or 1.75GiB of lowmem on highmem
> builds, depending on what is available on the architecture.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  arch/arm/Kconfig                            |  5 ++++-
>  arch/arm/configs/aspeed_g5_defconfig        |  1 -
>  arch/arm/configs/u8500_defconfig            |  1 -
>  arch/arm/configs/vt8500_v6_v7_defconfig     |  2 --
>  arch/arm/mach-omap2/Kconfig                 |  1 -
>  arch/microblaze/Kconfig                     |  9 ++++++---
>  arch/microblaze/configs/mmu_defconfig       |  1 -
>  arch/powerpc/Kconfig                        | 14 +++++++++-----
>  arch/powerpc/configs/44x/akebono_defconfig  |  1 -
>  arch/powerpc/configs/85xx/ksi8560_defconfig |  1 -
>  arch/powerpc/configs/85xx/stx_gp3_defconfig |  1 -
>  arch/x86/Kconfig                            |  4 +++-
>  12 files changed, 22 insertions(+), 19 deletions(-)

-- 
Sincerely yours,
Mike.
