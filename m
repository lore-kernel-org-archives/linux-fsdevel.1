Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597625;
	b=41cmYCLkL253GWHAS7wafXo30Gyw41ZRrKHujnOq5/cQiZH8G7D8BFD2s+DKu3MsZSl9
	 8FxqwIamPHpVu33/40/ED2ZOx17NkL5tEFEwL0hrsCaRsymJz4vIFmTzKeC7XshmtDvoM
	 XWATYEdph9czO9gLRug4ryTKYGNGvFenceWmgIrEJDI168Ud9MxT3KNz3sdZNF0Iw47VD
	 pwIPJf/Qj8N+bVRZ+bc/FpzJks3EKjOuJMihvNfgO0DZyXeaU8LwrTIrh45cw8lbDlhX9
	 Qa7JrRk7M/F/a1NIWE09Y9XHG50KzcEsoina+nbyjx+k+LQV+TuZYKfjAKRU1h1uwQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597625;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Yme8xVrfiJB9JtUWZsCWQb4f6bpQ8C2lB7x46RDJgew=;
	b=fnsjcFzJrZ1hh4SGbe3r3/SHDGjSC8IYTkJJ9HoCVvq97Q31MhgWa0VGRXul4fKmQ2j5
	 r1d1UQceLwanF/yjbodX0HU56TfIogMS5UKc6DKXzkHxutww54OReCRYuXNNtJA9Uy/kb
	 1G9vUvlBjID/lSauMZJlCZ3hvufggqW3mL5bZLjp8qaYnW09eIWXysL9nlCYO3PGnMrgL
	 izanzes4QznL66Tgqhje96v936pK9wU5twkGDlLxB24LCEbGIDvyvsIOq07wm3wHgnhcA
	 Z+Umo9z5MT7WsYqWmKsAQdNcYA6mmhRrvYCYHOWZZC/bXPOSGCAEYn28H0wsAjiw3kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6dxepis;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAE0606A336
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6dxepis
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40361F000C4;
	Fri, 13 Nov 2026 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597624;
	bh=Yme8xVrfiJB9JtUWZsCWQb4f6bpQ8C2lB7x46RDJgew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W6dxepisHpNNsxivi81mY2JUyom8vDvbtSJGZ79fX/VnHuW46WgDlfEp5w7M4L57I
	 LCYDzH5U0zSkM86UX6S5jGE9QpxapZ2vXxyGRwBFCxzwa1hnqIs2B5C1sd9o1Obgcp
	 MFZVnbFcDAFxRX01z+kkFJPV818yQD1kIbDRb8w1KLadEiSWsjM6L69B0/DeYUaKKJ
	 JnHV9Zjv20wthE9X+dPxf1pxS/GCxyevGUDxAU7fMzVkPg2hHRB2S01RE3gZ9BRIKm
	 zBYjPZQY9VUggt4Lrn/MTj4XrA5pKIELlXIqABDX1noeaFuneVjKllspDykcclkRE9
	 OuumQ6HJ3hVhQ==
Date: Fri, 13 Nov 2026 19:20:17 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Andreas Larsson <andreas@gaisler.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Matthew Wilcox <willy@infradead.org>, 
	Malin Jonsson <malin.jonsson@est.tech>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 6/6] ARM: add CONFIG_VMSPLIT_2G_OPT option
Message-ID: <avdfH-r5kDSrPUI4@gremlin>
References: <20261112112528.1116405-1-arnd@kernel.org>
 <20261112112528.1116405-7-arnd@kernel.org>
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
In-Reply-To: <20261112112528.1116405-7-arnd@kernel.org>

On Thu, Nov 12, 2026 at 12:25:28PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Unlike x86 and powerpc, there is currently no option to use exactly 2GiB
> of lowmem on Arm. Since 2GiB is still a relatively common configuration
> on embedded systems, it makes sense to allow this to be used in
> non-highmem builds.
>
> Add the Kconfig option and make this the default for non-LPAE builds
> with highmem enabled instead of CONFIG_VMSPLIT_2G.  LPAE still requires
> the vmsplit to be on a gigabyte boundary, so this is only available for
> classic pagetables at the moment, same as CONFIG_VMSPLIT_3G_OPT.
>
> Tested in qemu -M virt, both with and without HIGHMEM enabled.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

With sashiko fix, LGTM and:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  arch/arm/Kconfig | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 797705a94b28..8992fedfdf37 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1025,7 +1025,8 @@ config BL_SWITCHER_DUMMY_IF
>  choice
>  	prompt "Memory split"
>  	depends on MMU
> -	default VMSPLIT_2G if HIGHMEM || ARM_LPAE
> +	default VMSPLIT_2G if ARM_LPAE
> +	default VMSPLIT_2G_OPT if HIGHMEM
>  	default VMSPLIT_3G_OPT
>  	help
>  	  Select the desired split between kernel and user memory.
> @@ -1042,6 +1043,9 @@ choice
>  		bool "3G/1G user/kernel split (for full 1G low memory)"
>  	config VMSPLIT_2G
>  		bool "2G/2G user/kernel split"
> +	config VMSPLIT_2G_OPT
> +		depends on !ARM_LPAE
> +		bool "2G/2G user/kernel split (for full 2G low memory)"
>  	config VMSPLIT_1G
>  		bool "1G/3G user/kernel split"
>  endchoice
> @@ -1050,6 +1054,7 @@ config PAGE_OFFSET
>  	hex
>  	default PHYS_OFFSET if !MMU
>  	default 0x40000000 if VMSPLIT_1G
> +	default 0x70000000 if VMSPLIT_2G_OPT
>  	default 0x80000000 if VMSPLIT_2G
>  	default 0xB0000000 if VMSPLIT_3G_OPT
>  	default 0xC0000000
> @@ -1058,6 +1063,7 @@ config KASAN_SHADOW_OFFSET
>  	hex
>  	depends on KASAN
>  	default 0x1f000000 if PAGE_OFFSET=0x40000000
> +	default 0x4f000000 if PAGE_OFFSET=0x70000000
>  	default 0x5f000000 if PAGE_OFFSET=0x80000000
>  	default 0x9f000000 if PAGE_OFFSET=0xC0000000
>  	default 0x8f000000 if PAGE_OFFSET=0xB0000000
> --
> 2.53.0
>

--
Cheers, Lorenzo
