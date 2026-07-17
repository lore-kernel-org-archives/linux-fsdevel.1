Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC43538A72B;
	Fri, 17 Jul 2026 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285575; cv=none; b=mvgSqFFGQnMCd3H70IqLvjboclrf4EA541LXXclSE3JfReHYrxTvAupOnylPCYijCIi8hEQtUL2zv7ZZbxez1unkZdQ/nwZx0LoBIqs7ceKbH3Qq02N3XKW3Q43ZBugc62yvSfpqQEiRtNwyXl9uDDdq16O9w7k/THRmgVKZ18k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285575; c=relaxed/simple;
	bh=mkfmozy5zN59QWJ7jrFnhSc+Bn8XD1gyLi7Pe1ygMP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGa2c3+3UDYkPa7fpF9HTD4pIyijbCSc+yOP2LXlu8K5uUwiZ/sslaEbM94C1bTS9d3mV1etmZN3yhJLBiBM2KTGlQjOTQLQVXFw8EaIEQmu4YSErNSINL660PYto9gTPbtD5J5faifsX6kGuywssUh+hwNOMkK9LmcHMxSZqKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/NRdP9R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/NRdP9R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483B91F000E9;
	Fri, 17 Jul 2026 10:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784285571;
	bh=4A0+o7YCeS9ID+ESE1uLHB8mGvW15e3RYaSbw1rEE9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K/NRdP9R66ujJWEEUyGPLTl+6H0Z8QMbnmajmrCjsF4sZ1osqeU1U1m6Fi9TPbFFz
	 U+h03lyO/wtuhFHD1aVjlDhonIg3/v6kDIwLuYOf8iFmyVbwdVbc6VvzZZrzFhrxAT
	 54Cf8BlRQD98WrRkjPAeKfvBnI20EVO2IPPbNzkNsH23h5ItdCt8HN6rrpNkdqlsi4
	 ox2/EeYlC3PO/gEboUU/GzyuGPimwaVIaZs71/HoKLRC6kMypap4k79Dhyep4R4LFX
	 WAAGTJqa6TDjGtHey2GdQ5cPG2HoxKuE/fw5mVljK8MRcZewzYuNgdcMqVVXDti0nG
	 kWSTMxC5O0EIQ==
Date: Fri, 17 Jul 2026 11:52:35 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/mseal: limit scope of mseal address zero to
 address zero
Message-ID: <aloJYuQoMgg0Etz7@lucifer>
References: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>
 <20260716-mseal-fixups-v1-2-3a9609bf041b@kernel.org>
 <c1fa877e-de9d-4d85-9d2b-6971f0cbd7ff@kernel.org>
 <fad6b639-1d55-4b25-b1bb-14ae56f04a6e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fad6b639-1d55-4b25-b1bb-14ae56f04a6e@kernel.org>

On Fri, Jul 17, 2026 at 11:49:29AM +0100, David Hildenbrand (Arm) wrote:
>
> >> -static inline int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
> >> -{
> >> -	/* noop on 32 bit */
> >> -	return 0;
> >> -}
> >> +static inline void mseal_mmap_page_zero(void) {}
> >>  #endif
> >>
> >>  /*
> >> diff --git a/mm/mseal.c b/mm/mseal.c
> >> index 207fea89c61e..5930551d84f2 100644
> >> --- a/mm/mseal.c
> >> +++ b/mm/mseal.c
> >> @@ -32,7 +32,7 @@ static bool range_contains_unmapped(unsigned long start, unsigned long end)
> >>  	return prev_end < end;
> >>  }
> >>
> >> -static int mseal_apply(unsigned long start, unsigned long end)
> >> +static int __mseal(unsigned long start, unsigned long end)
> >>  {
> >>  	struct vm_area_struct *vma, *prev;
> >>  	VMA_ITERATOR(vmi, current->mm, start);
> >> @@ -66,6 +66,38 @@ static int mseal_apply(unsigned long start, unsigned long end)
> >>  	return 0;
> >>  }
> >>
> >> +static int mseal(unsigned long start, unsigned long end)
> >
> > mseal_range() could be indeed nicer. But do_mseal() is now a pure helper for
> > "SYSCALL_DEFINE3(mseal" only ...could we simply inline do_mseal into
> > SYSCALL_DEFINE3(mseal)?
> >
> > We could do that separately, ofc.

Yeah I do this in 3/3 :P

> >
>
> Forgot
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks :)

>
> --
> Cheers,
>
> David

Cheers, Lorenzo
