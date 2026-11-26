Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699725;
	b=gZyxb5xq7rVF/Asoa9YZHdco02fJ+ES90CD7h6WuMFJGI7wH07SBTbgBlrABqKpDSF6F
	 4OXtimCLtxHxM0g0S8GDvC8p74ioQvfmQSJnNdz4k4KVYWL4UqJtCQMuStiGBGDqgVdVV
	 NgcRpza8ckpwtxnJT542zUD1TsY4uKceMsTrSg9dZwF9ax6jYOMzPKoUuqji2eeIGqs0m
	 MsASEAusqoNQx8/rV6l/EZCqcz9IShhBHYyDBlyd4WEPiW2s5ouLoQJmzN3K3u1kbIko1
	 aqMs7PwEBNcqX6ThwpQkNKTe3kJumUXp6PIjyuI2YevRMur9p+/XEbT/Fb9BgPlm/zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699725;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cjfeIB7Jh9Ac/AfayNnL1Yf0x7S27z/ryKSokFRvmis=;
	b=oo5hpBNqBgI/lZznUmRrFCkEn0gF4jRRElmlxO9b6pH0ctt8vfAdJ6Tv+cRJsiw9RL1L
	 ML7N+Fe4mtVTVXycjziKzq/GfCgp/3GshvD2GPvJjqt9iHDNE4TgVWoI+Yup39GhMDV15
	 nZURgxtiFZAlkEmvL0B6jEEj07/AqeWE9iJ38gEfhmoQ1F9P1PfZhAKOutqn0v105H1fA
	 7AHtp58Sp2Gtmts9uTsRVVCfC+6VRgkAmYpiostGBI/QZQGLdkrkr8MkUOeeoYV3//3Kb
	 XAhID4fidoRLCJKVdsgxpSw7x5RpQaZGEbEmvp6bsdJt5g0zUX1cu0CyTDq5LqrZeQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKjmQFPo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3831E606A32D
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OKjmQFPo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B77A1F000F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 13:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699724;
	bh=cjfeIB7Jh9Ac/AfayNnL1Yf0x7S27z/ryKSokFRvmis=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OKjmQFPo1M75NXkW1bHMDWybQdIuae5BfdUB+xGnCd8WnZUl/pDfDcBO7rB3WwRBS
	 /Ob1mY//DhcXEHQ/uv6PMdV+zDPkCmw026DdqzRidvVfO57zNsZ5lx19VY8mEJEfRI
	 NbQBvzhp+gPFFwQBIh98wVGgz0sVb5J2qhuKj3w2sLjZLC+2Jz3xd/iXOMiHZuSFhu
	 VXk/8CCos/vN9KGdGMsSfxA8Ueh0PcXCmFe3AY2A44UJ4PQrSBxPd/ZTi4mfET6X/v
	 ExJt6R9GcDL0CkqyBHW7iQlwm4AKk2/6tvRSIaioKBzEDyuHPX6sX/aLjG/Prito3n
	 cJnEjZgWJdwjA==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ae85add4ceso50029901fa.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 05:28:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGdvQG540XwRv5azwYbk4G132FuC35KKFY3GD0gOG33tYuXc6WcL97Vz2gDd6mXODV/qvZ8osRsNG8z4HFD@vger.kernel.org
X-Gm-Message-State: APuU4Z/YW/SHOE1Vpo7mLMtHQHzZGZz70vNMXvkufC/LbCjxBLMFbtCs
	ImU0Xihvx+RLy5SX4T16AKYrhoCmtSE2Nj0YHSU5Aayg8HQb3jgD6asclnl6w0aNyh/+ApbbAR+
	LWyxBtV7FG+LSoThErczLMR5C0fIdbiE=
X-Received: by 2002:a05:6512:124d:b0:5c1:56f2:fda4 with SMTP id
 2adb3069b0e04-5c1bc89530fmr5518571e87.49.1795699723141; Thu, 26 Nov 2026
 05:28:43 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116124832.662455-1-arnd@kernel.org> <20261116124832.662455-8-arnd@kernel.org>
In-Reply-To: <20261116124832.662455-8-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Nov 2026 14:28:30 +0100
X-Gmail-Original-Message-ID: <CAD++jLmT3dgWNhwXnxBbMWT4FPtM85j7pGqphVhofVDn6bgq4w@mail.gmail.com>
X-Gm-Features: Aa3M54qt87pVcinKxHwHL_cdEyu5uWkoYM1H8TRwnc8234Hd9kxa6PUDkX4jAZc
Message-ID: <CAD++jLmT3dgWNhwXnxBbMWT4FPtM85j7pGqphVhofVDn6bgq4w@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] ARM: defconfig: turn off highmem in favor of CONFIG_VMSPLIT_2G_OPT
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

On Mon, Nov 16, 2026 at 1:49=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The multi_v7_defconfig and omap2plus_defconfig attempt to support a
> broad range of hardware. This is at odds with the setting for highmem
> being slowly phased out on the one hand but still enabled by means of
> CONFIG_ARCH_OMAP2PLUS_TYPICAL, leading to a default CONFIG_VMSPLIT_2G_OPT
> split.
>
> None of the upstream OMAP2+ DTS files actually list more than 2GiB
> of RAM, so it seems fine to just turn off highmem by default and use
> CONFIG_VMSPLIT_2G_OPT from the defconfig to still support the same
> hardware but not require highmem.
>
> This also changes multi_v7_defconfig, which currently supports all sorts
> of ARMv7 systems except those that require LPAE.
>
> The best comprimise I can think of again is to use VMSPLIT_2G_OPT in
> place of highmem. Compared to highmem configurations, this should be
> an improvement on most machines with 2GiB of installed memory for the
> lower overhead and complexity, but it does degrade machines that rely
> on highmem to access all memory, as well as reduce the available user
> address space (1.75GiB instead of the traditional 3GiB).
>
> For aspeed_g5_defconfig, the decision is trivial, as there are no
> 4GiB configurations we need to support, but g6 is known to use
> up to 2GiB.
>
> If you run into problems on production machines with the new default,
> with the absence of highmem, or the smaller user area, please complain.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
