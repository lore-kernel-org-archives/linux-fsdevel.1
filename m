Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007327;
	b=oJS/rPMaz1KVDMbpNgWk+TDErSPQOxk39nPN5R7aF+V7YbFLsDpOEVfXQYFum15kOuTC
	 CdEX4Xhh7hJxgLFiCrJ827q+1vc0hUj79jlLd6grxwYz1PGwHlp+VeBWQlDvyC1xwEQAu
	 gNfYr4egx39i+CdoeTmYajemLCrhQlz5MqQ68bXlQzLBoD7SdXl1qyTJWoRQFu1AsSfH2
	 0UvQA3XKiUxcNkLzOlSCgFS875UoXqBplNHX8I+dbkQoCgi4bLY/PIQD1YQ61/2pP5Lv4
	 3yAYslbiUYs4mkSGjCz0UVbfdH2EXLIT8O4uFd8AJrULEL+VhXCzh4MF173R//QM17g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007327;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tKDarfxiWOcLoTCSjE7AeoaPEMMkfbEBqcBYvqId7kA=;
	b=w8OArgC++1SpiBsFHVJ5MaPizkMqauLiA6uF3ZZj7NK356S6YpordadshrwUpvBNeSFv
	 GSTF/eJ2Y+YgrRGjghdxNYLnu5SRwpIzUz3jaXgdbszwduRzt9VwB4KvNqE5iw6KND7jH
	 e8IGJ0QMkgUTENWVZXr3gXn7zoBIXSdApi8e+hv+kMxs9c7tt4yBpb8Lext8TUtwhdZfe
	 /KMwqZFuTxSfBMwj60oAQj8t38NCCGNNHS+cFGQ+vrRqP7snNXvCRgmi8hKE3BZZ0vH/R
	 irDTpHqIGRRQfTqusM7+JXifGnH5eviPZ5psE68rFoY4fvEHetxnGPU5S310m8kdQVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbKcnKh8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDE2606A320
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbKcnKh8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D27F11F000CD
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 13:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795007326;
	bh=tKDarfxiWOcLoTCSjE7AeoaPEMMkfbEBqcBYvqId7kA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bbKcnKh85P28vFyNGpKeAdp1qViEiDSgoqPdjYPR299BJgFPfL94OkecOTx6woA/9
	 L+oosXTLjnKzdNTy+6PlD9YCL0ZTvby/CoJ4TuOt3+iI8hmjM1Pv5bCglCBG5PuZu7
	 7qokjmhy/uT2UWKAu8Tng42SxTVS1nBRXm9heMStVq2ODZH6MJ6Z+WpQ6kwIu9HlZX
	 7oLchHaGmy89HszFBZVRgbAXOKcPUWkOFoT9xAMbngtlXPnKj8bHjeHWIFnqYXHthn
	 AGJkSgPHvtnMU3n84GXHnTb+8SmOHdWNaBpZU0fhhllz/4ZtipbvClGWnL+YEqQJN5
	 SVV7UvR8WUavw==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso1101080e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 05:08:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEVtFB3F6EXAhdvrrcvU3fEl/SnRTpsiM0D5qY+5HoiJqDVX73eahTRsWh2IVjuZ8eycGaaiUHVUFvXr8u6@vger.kernel.org
X-Gm-Message-State: APuU4Z9bdv0/SxiENy3+Ui7cqPcHHZ1oXg5LEjquEa5qafO/o+1L3x3N
	Og0tpEnlvOhjtRDbnj6Q9YyfuHMI0LAJ+XBssd0YUQ15e4faFAVGP04kNNjTPQ1kQfDaLgFtQ6C
	Ll88iELGgJcQ9iV8YDAaSR8Id02JED/U=
X-Received: by 2002:a05:6512:3192:b0:5c1:5a83:4285 with SMTP id
 2adb3069b0e04-5c1aa2b16ddmr1030883e87.60.1795007325480; Wed, 18 Nov 2026
 05:08:45 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116124832.662455-1-arnd@kernel.org> <20261116124832.662455-2-arnd@kernel.org>
In-Reply-To: <20261116124832.662455-2-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 18 Nov 2026 14:08:31 +0100
X-Gmail-Original-Message-ID: <CAD++jL=Ugp2MH1nvBr=+_o6a9UZ4VCU04KY7Z22pzEnGwHAWTg@mail.gmail.com>
X-Gm-Features: Aa3M54rGSDqneypUHMmdmL7dJMYPaYSAWAq3AteQhJuMu5nbQzZhIjBnrf8_3UI
Message-ID: <CAD++jL=Ugp2MH1nvBr=+_o6a9UZ4VCU04KY7Z22pzEnGwHAWTg@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] ARM: remove support for highmem on VIVT
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>, 
	Andreas Larsson <andreas@gaisler.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Malin Jonsson <malin.jonsson@est.tech>, 
	Matthew Wilcox <willy@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Michal Simek <monstr@monstr.eu>, Mike Rapoport <rppt@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, 
	Nishanth Menon <nm@ti.com>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 1:48=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> As Jason Gunthorpe noticed, supporting VIVT caches adds some complication=
s
> to highmem that can be avoided these days:
>
> While all ARMv4 and ARMv5 CPUs use virtually indexed caches, they no
> longer really need highmem because we have practically discontinued
> support for large-memory configurations already.  The only machines I
> could find anywhere for memory on ARMv5 are:
>
>  - The Intel IOP platform was used on relatively large memory
>    configurations but we dropped kernel support in 2019 and 2022,
>    respectively.
>
>  - The Marvell mv78xx0 platform was the initial user of Arm highmem,
>    with the DB-78x00-BP supporting 2GB of memory. The only remaining
>    board file is for Buffalo WLX (Terastation Duo), which has only
>    512MB and is going to be removed soon.
>
>  - The Kirkwood platform supports 2GB, and there are actually boards
>    with that configuration that can still work. However, there are
>    no known users of the OpenBlocks A7, and the Freebox V6 is already
>    using CONFIG_VMSPLIT_2G to avoid enabling highmem.
>
> Remove the Arm specific portions here, making CONFIG_HIGHMEM conditional
> on modern caches. Since the cache type is enforced by Kconfig, no
> boot time check is needed here.
>
> Link: https://lore.kernel.org/all/20251219171412.GG254720@nvidia.com/
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Good riddance I'd say. I'd choose VMSPLIT_2G over highmem
any day.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
