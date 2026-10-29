Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793289851;
	b=hn4hDv48NsJPCR2U4JMPatxgrJseE+hE7Eu1TgQgyj4YjgGPwlZygIloXD3pxVG/mVkH
	 ndN5weBCBHW18zIZ7UlNqd12+EGPR/vYTKC3CrX35uWEqRNX8apSU6PbNwqc7l8ZuJdRt
	 OtwWxRFZL1PIoMkcHK3FKtEFSBo4vyGFmZan4IP2Iaft2kgzbsXtkZ6ziScZEuqPr5Mw+
	 KXvY3ajkukjpNIsyqE2yHhQlypBaP5UZ+TlPslmrA0JU9gDWLRJYIGVjstgUKw8IDz/Nh
	 alrC5YglYl81IyRfjxiXukTXZxlM4UFBX0KP+2fjT5IynhBH8OLei9Tm6zRroBbAMfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289851;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ZEImV1bsETTOjzgBZOnqxSCBynlGZZgQGJAOsTFWdvs=;
	b=PK01/5ZHWmXL95tGimJKaQ+dnk9b1JZDoKqpuIiRyzdfC2WYQcuazhqkCtqflGvGQV5n
	 781qFZaQ/ps+uaxG1cS+/4ZEAkgc9a9CRDy5MqwUqUp6QD9ZPt2RmhcrEsrz1THbi9yoO
	 9UeJjswX+q9Cn83CXVmqFlAQVv405z5OY5qpDE27NSp7P6sH0rxmPM6Dzv7ou4F/aJJDd
	 fFg6epbDxswfAMffjr3u00l29ZljabIbQhKHzUrxmAvEKSIwTT+VOrIODefJhWJenxpuy
	 3bbnJ2i9d+5Ealu2Biotku5thFsUzzV/4LbwQ359dQDb2WE9k2D1hSOAqcljE8SLZzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jnxrPTFL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C3A606A31A;
	Thu, 29 Oct 2026 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jnxrPTFL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F661F01825;
	Thu, 29 Oct 2026 16:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793289850;
	bh=ZEImV1bsETTOjzgBZOnqxSCBynlGZZgQGJAOsTFWdvs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jnxrPTFLrMh7lS0axSQZJeIw1zTZvkrB4+S47jC9dT5x4umfdVJ3i2j1TvejMOR6x
	 BJFAR5YKZQTHT3iLU2Tu5VK1VvJqRcy843wlOLG3Z1fBBUbb+Sb8OMOJ+sy17ax7qM
	 NltRB2210GdZxxK0PGcyACJf8fhMJz8/pycGtt04vTFUb3zOAGoHRlL2YNYLZjat8o
	 RQUIJrXMYd9hIkqrD0WWaKEMa4sLwnU2MY8440CDdUO06TgWx+Z/Zb40mTeygYUuB7
	 NPOO2yTNeL9ft5Z4lwHjTq9qykadh8pqrJ2e11rfB5l5aNCofsTVrL4FvwZVVsdt8S
	 vJsiCYCtj++fA==
Date: Thu, 29 Oct 2026 16:04:06 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xarray: clear the new head's parent before freeing
 the old head
Message-ID: <auNtjKLHZOo1awG1@gremlin>
References: <attzI4sj2Pagmvkd@casper.infradead.org>
 <20261027192014.844878-1-nickolai@csail.mit.edu>
 <auNdNjH4zo7OYbe-@gremlin>
 <CADGQE7EtDGs=g7p5=_m2LieLcEj-k4LyupOFWt96Aw9py-gYaw@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADGQE7EtDGs=g7p5=_m2LieLcEj-k4LyupOFWt96Aw9py-gYaw@mail.gmail.com>

On Thu, Oct 29, 2026 at 11:50:37AM -0400, Nickolai Zeldovich wrote:
> Hi Lorenzo,
>
> On Thu, Oct 29, 2026 at 11:03 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > It's pretty 101, but please don't send new revisions in-reply-to older
> > revisions or feedback [0].
>
> Understood, will do.  (I was thinking that applied more to
> multi-series patches, which indeed gets unwieldy.)

In general in mm and mm-adjacent we prefer not. I think this might vary by
subsystem, but it gets buried easily in even single patches, so best to default
to not I think.

>
> > Also, if somebody replies to you, reply back. You, not your LLM.
>
> Indeed, I've been replying personally, though in a few cases I sent
> the response in the notes of the v2 patch, in an attempt to send less
> mail to lkml.

OK appreciated!

>
> For context, I use an LLM to write Lean proofs of correctness, which
> seems useful for cases where the patch is non-trivial (e.g., [2]).

Ack, this seems to be a trend. And obviously we're not against LLM usage, as I'm
sure you're aware, this is about rate-limiting that's all.

Also use of lean seems like a nice way of bounding LLMs in a way that makes them
less likely to go awry, I didn't know people were already using that for the
kernel, so that's interesting!

>
> > Also, you are flooding the kernel with patches, 5 series across 5
> > subsystems over 2 hrs:
> >
> > https://lore.kernel.org/all/?q=f%3Anickolai%40csail.mit.edu
> >
> > I already asked you once to stop doing this [1]. You've carried on.
> > [...]
> > I'm sure you're acting in good faith, so can I please ask you to engage
> > with maintainers instead of ignoring us and treating our time as valueless?
>
> Sorry about that.  I'm happy to send bug reports with clear userspace
> reproducers, instead of patches, for any bugs that seem particularly
> significant.  I'll also get in touch with the relevant maintainers to
> see what, if anything, might be useful to them, rather than sending
> individual issues/patches.

In general the bug reports are welcome, just space them out a bit, or if you
have a bunch for a subsystem, contact maintainers ahead of time.

I know you've generally only sent a few-per-subsystem, but in general this is
about managing workload.

Right now the biggest issue with AI submissions is volume-of-submission
vs. review resource. The former can grow exponentially, the latter very much not
:)

>
> Nickolai.
>
> [2] https://lore.kernel.org/lkml/20261027125210.843589-1-nickolai@csail.mit.edu/

--
Cheers, Lorenzo
