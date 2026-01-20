Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B53423171
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 22:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768948205; cv=none; b=RSZpkqJ/cCS9tVfZVIlSEcAYYJGHesbBBvp/J/jxkSpg7Weo9rLeRUMO5lF290FTxEfX1uT4uZChtyu4THrr4T6QHJQK65RS64bQCTjpfUXm1z3QkrPS69fG30W3B35LGW+JkI3b5QuGijgHDJnwyr/tnZu/EWtLFV0LaVr6VL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768948205; c=relaxed/simple;
	bh=Rj/c0jN1cd/5SvLS9DcEb/UKs1Cg66QmZr08vzlmrfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Soggbvn+Nu57gb2+5/CnteXaUolwz66h/HujOLZdZVSfAFymhWyjj2Y/Ea3dWB6/Ad41AowmVVBhgSnCuhHw804kZPEMpRN67+3sGNKzTORwfzFyLcJm8gDKWOj7tlyv5xdvIeW32Vyxfm+HkMWLLGqyVLBU+9F2TDcOeK/RUmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htDAfYLM; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htDAfYLM"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c5e051a47ddso3808103a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 14:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768948199; x=1769552999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qi2aIzmcDbNCw7y614MiDKvrAh6Yp1kcr0zXJQZmRWc=;
        b=htDAfYLMmi+o7KHNHfRwMvKaSel5Q3kIEs6ZaZQBPJTUff/17mWQonDXiCIqFXjk4k
         WKqtFVvuNzzcpzdmV7IAe92CSj2ZR1aD6gZvNP2XdQ24z6p/R/MBCD8pjPHvuiMejmas
         4xS/pzQj4SNtb5dJCxLjju0U2scu5/INtVsryQCuac1klp2rXVGnbphuShYmfJGGvwja
         p4BbS+Wo64oCrA4Axmm/3jbZxeCKtl6er7optqzCZA3TY96a9AR4yYgWO8wkjtw1NNni
         GZYMjY3U5Y922/Xa+6hqm+VL5vgZnXw8dEkSy2wGLbDBjQv39DTtBZXY0z57cl2fLODw
         L65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768948199; x=1769552999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qi2aIzmcDbNCw7y614MiDKvrAh6Yp1kcr0zXJQZmRWc=;
        b=S/OLsnRDLCfX2vZArT6BnYN8ANgyLj3Mrd7GZYWGKCBAqrk82/2RS4opsLCghBy1R3
         yzlTgqGzORPNWmESmilG1GMHzU4QdGfdRrFvoaLuc/Et7KMJCXpZEYuAsM8hGSb9XGQq
         kmLkXOraCH1pGXsRqKG7hc68tXrQA03zvuO+IPtlhhV3tyKa9R9Y5Wl8AK4Nt3SqWIZp
         RVbOLROFZMQMEYMCiz24b9VJK+AgJNKOAxLSuSVSwM3lDRXKwzrZAzG/RNdus/J3Uu9J
         RTI7K0/9fUhsYaNVOiJ4LNfgFnDLD4A8hBu2ES1KbipoU/QgqV77ZbiqIBteZG+2mRb8
         SPBA==
X-Forwarded-Encrypted: i=1; AJvYcCU3oSKH0C1zuhEOGSb91w/Td3QqYdhF/xLVQcd+nWaf0iCn+VyEHKPlGBsTtPAEt0tJB7gkTX/un/UsVlm5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz444zyN/c9zJoRs2FIjtej6rKjNFfckEe/X+/egbQp36c/IGnl
	wxgZXRlOyDCbvmK4su+pn2eRoSTp11MBzIOA4tJ/LXk5eXXh1am8fZ4TIYdbOB6t
X-Gm-Gg: AY/fxX7azFJ95S4Cr3HQi/BqSuk+4mvAgbV7N3sn7w6bnYG9NPob/P2KJdh9PsKPl8I
	JLMpXTDNC1HT3y7X/eS+/slcAgfYlPETfn/HutgN6bKIRvlQgYb65Zb0iaq7WIwlxt6Eio0rr23
	tS9srH7YrXIHzR38xQ1nD4aUD/iW3LfafiwBVIGEQUUAz15U+sXF5CoOd+I5Oy7W7IcfKGlH3Bw
	/XBhtXF8uaAgLpRD9UOcxARAARAY34MrvvJTfcWRePG/UyCtHmwCDRnIrCDOwb6ujqMaQC3o7Kt
	4kECCcvLTU2BZQQgTdlL+O4/SD7Tctz7LwoxhE1WQL76r7BovVUjdlDWl0twuNvAuMTSNGyzQOa
	lg9+6AixzvCF7HA9Ky/GeUb01f/ApK+OibCLnGmjtOjlXB2xhFgoCAxbLDek6JmGnqhGNc4Qyod
	u2p03yw4Ee+Ukx8EPULADwi69hqgaDf8XOTZS3ATUSzZwgn5KRKAcxLhoiyUdZ/gAdLN4ZNt9La
	1V93IofvO0bA6w=
X-Received: by 2002:a05:6214:ccc:b0:888:8913:89af with SMTP id 6a1803df08f44-8942e45d08emr223107256d6.15.1768942369869;
        Tue, 20 Jan 2026 12:52:49 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6c6610sm112900286d6.40.2026.01.20.12.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:52:49 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id E41E5F40068;
	Tue, 20 Jan 2026 15:52:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 20 Jan 2026 15:52:47 -0500
X-ME-Sender: <xms:H-tvaX1kojIonb-EVRFpy3nglRT3m4AeyFq7gIGsjhlxAtE3Glai1g>
    <xme:H-tvaa_uevsm1j_nA4NTrtwklcrJfcdM4U0q6A4GEV260X5EjBnwaltr4cbZMvGn6
    KjzbhVqDrWzmPLPK60YegDkEA-bX_UG4FRaExVHfUbCwIJ6YbElIQ>
X-ME-Received: <xmr:H-tvaQcjaYTt02Yr6xj4KoQlgTn24zVa3RbwW5LW2HZzf9Kn0JJzuuiT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedugedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeftdevhfevteettdfgffeigfekieetudejgfdukeeihfffheehueevleffkeef
    vdenucffohhmrghinheplhhptgdrvghvvghnthhsnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthho
    pedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghlvhgvrhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghsrghnqdguvghvsehgohhoghhlvghgrhhouhhpshdrtghomhdp
    rhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrh
    iisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgu
    segrrhhmrdgtohhm
X-ME-Proxy: <xmx:H-tvaeGCsw5xjDM64D8SjYhhnldkREtAoHHk6fltcQp4MrUla1gBfw>
    <xmx:H-tvadDGhFi5HIGAu0qJl6c5giOIok1DS4KJaLxc8GXWSUoaLq7W9Q>
    <xmx:H-tvaZ5wWvabU4cN2ouWL4rRJ2lISLHhEX-o5ZFM64zCTWHORNKLwg>
    <xmx:H-tvaUmgw3ZWtOfh6dkJaodk5OiAevILKQNizkbEcsqYM6MmybKYTw>
    <xmx:H-tvaa5r9CTMjCLfZ_XDQgRhgYTbFp-IzPCnUePD-4VcLlCTbe87NB3X>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 15:52:47 -0500 (EST)
Date: Wed, 21 Jan 2026 04:52:45 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Marco Elver <elver@google.com>
Cc: Gary Guo <gary@garyguo.net>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: atomic: Add atomic operation helpers
 over raw pointers
Message-ID: <aW_rHVoiMm4ev0e8@tardis-2.local>
References: <20260120115207.55318-1-boqun.feng@gmail.com>
 <20260120115207.55318-3-boqun.feng@gmail.com>
 <aW-sGiEQg1mP6hHF@elver.google.com>
 <DFTKIA3DYRAV.18HDP8UCNC8NM@garyguo.net>
 <CANpmjNN=ug+TqKdeJu1qY-_-PUEeEGKW28VEMNSpChVLi8o--A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNN=ug+TqKdeJu1qY-_-PUEeEGKW28VEMNSpChVLi8o--A@mail.gmail.com>

On Tue, Jan 20, 2026 at 06:10:40PM +0100, Marco Elver wrote:
> On Tue, 20 Jan 2026 at 17:47, Gary Guo <gary@garyguo.net> wrote:
> >
[...]
> > >> +
> > >> +/// Atomic load over raw pointers.
> > >> +///
> > >> +/// This function provides a short-cut of `Atomic::from_ptr().load(..)`, and can be used to work
> > >> +/// with C side on synchronizations:
> > >> +///
> > >> +/// - `atomic_load(.., Relaxed)` maps to `READ_ONCE()` when using for inter-thread communication.
> > >> +/// - `atomic_load(.., Acquire)` maps to `smp_load_acquire()`.
> > >
> > > I'm late to the party and may have missed some discussion, but it might

Thanks for bringing this up ;-)

> > > want restating in the documentation and/or commit log:
> > >
> > > READ_ONCE is meant to be a dependency-ordering primitive, i.e. be more
> > > like memory_order_consume than it is memory_order_relaxed. This has, to
> > > the best of my knowledge, not changed; otherwise lots of kernel code
> > > would be broken.

Our C's atomic_long_read() is the same, that is it's like
memory_order_consume instead memory_order_relaxed.

> >
> > On the Rust-side documentation we mentioned that `Relaxed` always preserve
> > dependency ordering, so yes, it is closer to `consume` in the C11 model.
> 
> Alright, I missed this.
> Is this actually enforced, or like the C side's use of "volatile",
> relies on luck?
> 

I wouldn't call it luck ;-) but we rely on the same thing that C has:
implementing by using READ_ONCE().

> > > It is known to be brittle [1]. So the recommendation
> > > above is unsound; well, it's as unsound as implementing READ_ONCE with a
> > > volatile load.
> >
> > Sorry, which part of this is unsound? You mean that the dependency ordering is
> > actually lost when it's not supposed to be? Even so, it'll be only a problem on
> > specific users that uses `Relaxed` to carry ordering?
> 
> Correct.
> 
> > Users that use `Relaxed` for things that don't require any ordering would still
> > be fine?
> 
> Yes.
> 
> > > While Alice's series tried to expose READ_ONCE as-is to the Rust side
> > > (via volatile), so that Rust inherits the exact same semantics (including
> > > its implementation flaw), the recommendation above is doubling down on
> > > the unsoundness by proposing Relaxed to map to READ_ONCE.
> > >
> > > [1] https://lpc.events/event/16/contributions/1174/attachments/1108/2121/Status%20Report%20-%20Broken%20Dependency%20Orderings%20in%20the%20Linux%20Kernel.pdf
> > >
> >
> > I think this is a longstanding debate on whether we should actually depend on
> > dependency ordering or just upgrade everything needs it to acquire. But this
> > isn't really specific to Rust, and whatever is decided is global to the full
> > LKMM.
> 
> Indeed, but the implementation on the C vs. Rust side differ
> substantially, so assuming it'll work on the Rust side just because
> "volatile" works more or less on the C side is a leap I wouldn't want
> to take in my codebase.
> 

Which part of the implementation is different between C and Rust? We
implement all Relaxed atomics in Rust the same way as C: using C's
READ_ONCE() and WRITE_ONCE().

> > > Furthermore, LTO arm64 promotes READ_ONCE to an acquire (see
> > > arch/arm64/include/asm/rwonce.h):

So are our C's atomic_read() and Rust's Atomic::load().

> > >
> > >         /*
> > >          * When building with LTO, there is an increased risk of the compiler
> > >          * converting an address dependency headed by a READ_ONCE() invocation
> > >          * into a control dependency and consequently allowing for harmful
> > >          * reordering by the CPU.
> > >          *
> > >          * Ensure that such transformations are harmless by overriding the generic
> > >          * READ_ONCE() definition with one that provides RCpc acquire semantics
> > >          * when building with LTO.
> > >          */
> > >
> > > So for all intents and purposes, the only sound mapping when pairing
> > > READ_ONCE() with an atomic load on the Rust side is to use Acquire
> > > ordering.
> >
> > LLVM handles address dependency much saner than GCC does. It for example won't
> > turn address comparing equal into meaning that the pointer can be interchanged
> > (as provenance won't match). Currently only address comparision to NULL or
> > static can have effect on pointer provenance.
> >
> > Although, last time I asked if we can rely on this for address dependency, I
> > didn't get an affirmitive answer -- but I think in practice it won't be lost (as
> > currently implemented).
> 
> There is no guarantee here, and this can change with every new
> release. In most cases where it matters it works today, but the
> compiler (specifically LLVM) does break dependencies even if rarely
> [1].
> 
> > Furthermore, Rust code currently does not participate in LTO.
> 
> LTO is not the problem, aggressive compiler optimizations (as
> discussed in [1]) are. And Rust, by virtue of its strong type system,
> appears to give the compiler a lot more leeway how it optimizes code.
> So I think the Rust side is in greater danger here than the C with LTO
> side. But I'm speculating (pun intended) ...
> 
> However, given "Relaxed" for the Rust side is already defined to
> "carry dependencies" then in isolation my original comment is moot and
> does not apply to this particular patch. At face value the promised
> semantics are ok, but the implementation (just like "volatile" for C)
> probably are not. But that appears to be beyond this patch, so feel

Implementation-wise, READ_ONCE() is used the same as C for
atomic_read(), so Rust and C are on the same boat.

Regards,
Boqun

> free to ignore.
