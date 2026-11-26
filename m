Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699677;
	b=rfkgcrKCcW9Nts88O4+GpdxfZXkADGMBmoCN2gjSGxuriGw71x8k0AiYuxRCBwF00pUl
	 Glphz+Z8S8niJCPOmTYSZnujBrj7T43I0pW8CA4ugCM4CM14M5U9ZLxLTAC14VtqTkY/F
	 okixa/vdu2a393N/28AiW/lm5Cu7otVOfuMsBX4zFJM8aXi/9NqA//AkFBW0nzBUrQOU6
	 BIsb6d06y+FMKIBXn1a33WU3GcnPT8RnQl5MyktVyindyrSSh0I/jIPTMAi2h0S8qSnKf
	 pOE0rUdZhK7mrkKymzwscX/OzzgNZD0SgTkMzT/PY1RSrFyKQTcAEhgILN/feDzST4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699677;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0SuygBFJgQJDPEHL8vg5eLv9glUvVL4TbpwchKTOKc8=;
	b=SG5Mu4Tcy9TMZYmCBZ1gP/9c0hmMUvVbSTtKqVAwroqvPmCxAh6KDBvuv3pa4Jz9L7sI
	 FBIdXlLkUdW2KldmqD6SK0cJF4KPaLTpyF8ChmHEUHVlSjsEmCq+YHtOmy/BYDnS/KFSL
	 xHpBUhFatYOsG4YiiPYc2cBB9XIvNe+zYnWPCmqUnjaOVBObBAa5sF8tNrVaboBwZfqzT
	 MYkX80LlXvNSvOl5rHHEGlJTN2PNe9Pe5MJydIuOyEITHzZ3mmmhmow41mFakIJM1O7ZK
	 G+/wBWEvDCwHEEa3TIaFdOgkiFCLeYhD/vgFX+9G89D2oQbV5eG4en3P7dFQZAGcd0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPHU4bh1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E1C606A31E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 13:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EPHU4bh1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EAA1F00AE3
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 13:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795699676;
	bh=0SuygBFJgQJDPEHL8vg5eLv9glUvVL4TbpwchKTOKc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=EPHU4bh1rQUynF67I/BLiAYnpMItWNnTQ9AParYyhIyJ+y6H3njJ4HyIE0s6Jx202
	 xCNzY4EbdFEUvhIGV7u89sr9xvmTk/hzD3usLMoUVQo7zRS1mVOEOGXKaU7srd0lqN
	 QJ8zgMkZSbzwDG6k/Q8gKHxK2xOwoNZh0rfmPcgTWzKzVzQoVxEJRXus9AvWUL1U2G
	 poRlMVnD4ZVArgDu1nm8eFgis+FkVYb/7yrTihelucyhtlDiutnGbPYYQd1IeXPRF1
	 uMR3MT3fEDrUV6O3qWBar39ZOF0tAC8l88Y7GgJIURjBmPo17gy3FHsqx2yCKI3NPh
	 QpwxgY4N6hLRw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c1479a959aso5286676e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 05:27:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEsbf6Qb57EYJFmIKSkjTuK53qP1r///vUMJsgbYTYOciByZy9zBKKpeJqDJlrQiBD8ajXlDPj9cE8o6hQp@vger.kernel.org
X-Gm-Message-State: APuU4Z/TyaCbC7n0movzn/HzmjQcVtqXQF33mWT5dovucv0NAna25f1o
	c7BsYmfFEMput1H6FXjiw4YEA7GOxbxDM7hSdmkTs2N4MvGxKuAAG963Ak6Ah3azkNBLpJDmXzG
	HRHwtNNDGDDBevuFnM+TinJl3bW7KW44=
X-Received: by 2002:a05:6512:36d9:b0:5c1:5976:1d30 with SMTP id
 2adb3069b0e04-5c1bc8206cdmr4300123e87.57.1795699675392; Thu, 26 Nov 2026
 05:27:55 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116124832.662455-1-arnd@kernel.org> <20261116124832.662455-6-arnd@kernel.org>
In-Reply-To: <20261116124832.662455-6-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Nov 2026 14:27:42 +0100
X-Gmail-Original-Message-ID: <CAD++jL=ZyHZcJRUTpVghs3xYH0OGOKauKVWTF8tiPpHPjuad+g@mail.gmail.com>
X-Gm-Features: Aa3M54pIH7xhTLEiVGxFItiuCxGTTC1f9B6RJQ9R1KEb9x9xI611Qqdum1NmRD8
Message-ID: <CAD++jL=ZyHZcJRUTpVghs3xYH0OGOKauKVWTF8tiPpHPjuad+g@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] ARM: add CONFIG_VMSPLIT_2G_OPT option
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
> Unlike x86 and powerpc, there is currently no option to use exactly 2GiB
> of lowmem on Arm. Since 2GiB is still a relatively common configuration
> on embedded systems, it makes sense to allow this to be used in
> non-highmem builds.
>
> Add the Kconfig option and make this the default for non-LPAE builds
> with highmem enabled instead of CONFIG_VMSPLIT_2G.  LPAE still requires
> the vmsplit to be on a gigabyte boundary, so this is only available for
> classic pagetables at the moment, same as CONFIG_VMSPLIT_3G_OPT.
> Keep ARCH_MMAP_RND_BITS_MAX at 15 for this.
>
> Tested in qemu -M virt, both with and without HIGHMEM enabled.
>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
