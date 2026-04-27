Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FA83537FF
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326327; cv=none; b=PphI7CC0zc8rLDCfClQ7ZgBLv0jO+IUGrKnFbOh43MtLuv8e/wCqIXLbYqUi8rWiCvcwRE5Q3c3yO5kJ7db9nCjDgcyrww8tvLaIkq0WNEUp/fXtjtPQB9GdBb8muqvuxe4cpztZzK9he0mJcuG5TrGlWi1mzihas9pG1dOQuCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326327; c=relaxed/simple;
	bh=i/k46YQbNxc6jmDhpSrBTZQploRe2hY24KQV/uGHVj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mp8hfjXrA50Kg2QMn3d4BOHTFr7geGYIkQPkA0Ivimqr3jRk0V8NJWYO6HdXTHqjOZcyA26n6ADLRPezRHvq5ca/Af6WOSSYBPehlUTnvy7bUYN3NpG5dK1JkPiAF9jPmY6qc86njUzB3KYPaO3OOJM/dQROSVVmojLtP39PTfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PU4P791G; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PU4P791G"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8f97c626aaso849387066b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 14:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777326324; x=1777931124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=PU4P791GVmxInFDdnWyF07mbS4dSuamQe9U1QkjtnM+Yy1xs3QoZmDzllDpm2LHfcr
         fhpdObzK4oFiECfbzAFS2Fz8a0bd69boxd3H+ndr6wp+BopMwXEmUsXPxD1+0QJqVOOj
         aqlEp/HcxtCLt2zZ0Hrpc7BITZhmvjUV6EU28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326324; x=1777931124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=IVAlXc+w+Y7Cexh21rXX193eeVbRczJiFIaznf1yo+iIlp7k7qUA6cTtMa8KRQj1CZ
         wNcyWDkGLoe3n30THw4elPsFul+YvXE2OiiGbCGmZfWovntC36DTXerYvKuJ2WMgH8gq
         0hAaRazZ4FlLccAKKOFqmeKe1P/IKJrsdXaELNYl4+VDGzoBXURlARtPn/Zoe+R7INTe
         Ng8nqigEvqo+1t+7qApKeaqneXyazIS/TOk93NApa6JWss9wZMkiZKrQpGBYN4NKL7uN
         EFHB3nVsP4plXWjC69aDH128BreNQNimnuLdUJZKVlRd1Z0+ROIyRtltmeBXFjLP5Kf2
         ozWQ==
X-Forwarded-Encrypted: i=1; AFNElJ9k7+6VC0FcYb96E57X864flU8YK/AeJl6G2KnfYJDLJfEUjaMb6+SYtIdGnTaAaSWIIiVsB39l6eh+4SEG@vger.kernel.org
X-Gm-Message-State: AOJu0YwLUyYk6kBjY/2HUfPK7dIeejgBpQLBBFNf/mvta9MZfEZaUAL8
	3jcbzmYaWUAykRt/NJ3WngQWA1O2CvnYEtEOsdHGTuNl/n4rDkTLPni8J0GRAUWtysQvR27sxuB
	WZon4ubBmeQ==
X-Gm-Gg: AeBDieuQhXISkZg8sNJIC/K/dbg9qV/63NlGrN0gms8ajEY0ic7mGFlkJ6cWDdtQ4sx
	qUMaCudPFvVPOpCyxLsjrhy6zF8zP22/L3l6NRGIOBKzXuiS8aqniLvjPjn1f0N9IE5ykbo0oSl
	nFQqRC+08D3Pram0SO90CgblsEC6ebp82uVuPq5Zb6DWfZKBzOml4zsyOhB0jLG2DxI8RUpLL3t
	pXivfWIPw/2TKpPFebwHTuPm6quO5oVWSg52ltwobdJQdUEDFt6kuUTRiSqyf9Y2C++RFS9sdKN
	a5L6xfbEpGqCzjuAOiBfLhFn7PBgJKT6O/5/vERszC7GWfVep3oeBBuNjbBR51m6AEsAhuN860X
	dBudsD7Di7fEbiSVKxrSEIKm7j/zLDAwFGTYgSl9HKYj0iU/ZnA7tGqI5h0ou8m4YUl/19xsMGa
	A3lVhFCooChlmFe0LH/+/0TsnzKDWShKcj/WpXcvxOdANpdww1aDEKOw9qsxrjYACgxze5ZlvJ9
	/WFbMtU0sI=
X-Received: by 2002:a17:906:ba89:b0:bad:a28:e09 with SMTP id a640c23a62f3a-bb804d28002mr29771466b.41.1777326324033;
        Mon, 27 Apr 2026 14:45:24 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80bd91f49sm9528866b.51.2026.04.27.14.45.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:45:23 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-678adefbd26so5632196a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 14:45:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+5R+ZPY6eRS7zZW9UgRdhakaCzrd/8RgNnjGCP61OfNueyvITKGv3OKrurfD1/j+3hZjkCQLeUFd9ZEnS9@vger.kernel.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus
