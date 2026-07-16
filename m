Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0417B3019D8;
	Thu, 16 Jul 2026 15:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216308; cv=none; b=JZ6mC2DDGhy77p1XPHAVZc3a0CEt58LLazaM3V950IT0wOT5k9AKZs2Sci50ODOjSmyHmZsOh7GhirrOTAoiLeUmDsEpKC57v4WDo+N4E0mhP1rC9p29+nV+4xisPh+EKQw000zPdTmb5njpdDpib4tfX3jFW9JMS7FoCmo3RHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216308; c=relaxed/simple;
	bh=PrG/RExUE78E0xJRyBd+tBlqJAO9abNglW7oVefXQc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iR7X3U95ZA0qMSRUv9nTjKsSC0eUe3K+rt+5qk96TV9HwBjpGEKZGPLRxBUNwIYQaWnCnTzlGAlPUxladeoFGwZnD/taFYF2kJPjwRrcI3P75JZwRur274ClLt/c2hld2fYIyT7w3z5dV1ZUmyCCmfMERbEtQ4yckE/IX05+gkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR0erwDg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR0erwDg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3469C1F000E9;
	Thu, 16 Jul 2026 15:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784216306;
	bh=a26FW5P9+YzyWC6sUoMal5XZ31S+uAd68vV2bOiyX1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lR0erwDgzrfV/VW+jOFdV1LMajh/Lxr9kj6PHtGJ2ocf8UYF7Iiev7SR8A9tEWCgQ
	 sGQtqYw2ORhpBucNtP8LdQbJ2LzOyaiGIT6GaPRxahcGCnJYvfk2zIa2QDQdELHN+q
	 LDPB97EOuYOxIXGpx3SApeYztROlPB3s165Mf1Ebdkc8MxtMhYw0Qg7ZigGsuTDNt+
	 4MaV3BwpOvKoQ8ZSXNh6PVvDFHOyQvSa42Au5ELtabRp418yDLMNKvbV2FwXbBCEHB
	 pEHEJMklR5yaZnxH7xQJ0j+dYjktwFbJkpFZQ2YSOIlpfPGyMlcDbq6rW8IO8Ibksx
	 J7LMo5ew01Djw==
Date: Thu, 16 Jul 2026 16:38:12 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/mseal: limit scope of mseal address zero to
 address zero
Message-ID: <alj1Cyt4JvbVM7tB@lucifer>
References: <20260716-mseal-fixups-v1-0-3a9609bf041b@kernel.org>
 <20260716-mseal-fixups-v1-2-3a9609bf041b@kernel.org>
 <aljyYdgzRZW1kIhs@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aljyYdgzRZW1kIhs@pedro-suse.lan>

On Thu, Jul 16, 2026 at 04:06:20PM +0100, Pedro Falcato wrote:
> On Thu, Jul 16, 2026 at 02:43:10PM +0100, Lorenzo Stoakes (ARM) wrote:
> > Commit 44f65d900698 ("binfmt_elf: mseal address zero") unconditionally
> > provided do_mseal() to any internal kernel caller in order to address a
> > corner case slated for possible removal.
> >
> > It also incorrectly attempts to mseal() without checking to see whether the
> > mapping even succeeded.
> >
> > Restrict the scope to the corner case by providing mseal_mmap_page_zero()
> > which asserts the MMAP_PAGE_ZERO personality.
> >
> > Avoid unnecessary checks in the start, end range by abstracting the actual
> > mseal()'ing to mseal() and have mseal_mmap_page_zero() call that instead.
> >
> > Only try to seal the VMA if we mapped the VMA.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  fs/binfmt_elf.c    |  7 ++-----
> >  include/linux/mm.h |  8 ++------
> >  mm/mseal.c         | 48 +++++++++++++++++++++++++++++++++++-------------
> >  3 files changed, 39 insertions(+), 24 deletions(-)
> >
> > diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> > index 16a56b6b3f6c..e3131a311995 100644
> > --- a/fs/binfmt_elf.c
> > +++ b/fs/binfmt_elf.c
> > @@ -1353,11 +1353,8 @@ static int load_elf_binary(struct linux_binprm *bprm)
> >  		   emulate the SVr4 behavior. Sigh. */
> >  		error = vm_mmap(NULL, 0, PAGE_SIZE, PROT_READ | PROT_EXEC,
> >  				MAP_FIXED | MAP_PRIVATE, 0);
>
> I think pedantically load_elf_binary() should error out on mmap error, no?
> Not that this personality is used in the big 2026 however...

I'm not sure I implied otherwise?

But yes I'm aware, the point is to not try to mseal() an unmapped range knowingly.

The fact we 'get away with it' now is irrelevant.

I can update the commit message if a respin is necessary to spell this out (I
thought it was obvious).

>
> > -
> > -		retval = do_mseal(0, PAGE_SIZE, 0);
> > -		if (retval)
> > -			pr_warn_ratelimited("pid=%d, couldn't seal address 0, ret=%d.\n",
> > -					    task_pid_nr(current), retval);
> > +		if (!error)
> > +			mseal_mmap_page_zero();
> >  	}
> >
> >  	regs = current_pt_regs();
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 550fb92957d1..87feaa5a2b78 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -5291,13 +5291,9 @@ int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *
> >  int reserve_mem_release_by_name(const char *name);
> >
> >  #ifdef CONFIG_64BIT
> > -int do_mseal(unsigned long start, size_t len_in, unsigned long flags);
> > +void mseal_mmap_page_zero(void);
> >  #else
> > -static inline int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
> > -{
> > -	/* noop on 32 bit */
> > -	return 0;
> > -}
> > +static inline void mseal_mmap_page_zero(void) {}
> >  #endif
> >
> >  /*
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index 207fea89c61e..5930551d84f2 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -32,7 +32,7 @@ static bool range_contains_unmapped(unsigned long start, unsigned long end)
> >  	return prev_end < end;
> >  }
> >
> > -static int mseal_apply(unsigned long start, unsigned long end)
> > +static int __mseal(unsigned long start, unsigned long end)
>
> Why? I think the previous name is perfectly cromulent.

Because this is what actually mseal()'s, the _apply is not really useful.

The __ is because it's unlocked.

The point here is to eliminate useless indirection, so calling the function that
mseals, 'mseal' seems sensible.

>
> >  {
> >  	struct vm_area_struct *vma, *prev;
> >  	VMA_ITERATOR(vmi, current->mm, start);
> > @@ -66,6 +66,38 @@ static int mseal_apply(unsigned long start, unsigned long end)
> >  	return 0;
> >  }
> >
> > +static int mseal(unsigned long start, unsigned long end)
>
> I don't like that you go start - end on a function called "mseal". The actual
> system call goes start - len. It just looks confusing :) So either rename it
> to mseal_range(), or make it take a start, length pair.

I'm not sure I really understand the confusion (I suppose you're equally
confused by the lack of flags parameter?),

I find it silly that we avoid function names because a system call of the same
name exists.

But I guess I can rename it to mseal_range() since I don't want the series
blocked on silly naming issues.

The reason for passing end (which was already the case) is that the syscall
already calculates it and we need it to do the actual mseal.

>
> The overall spirit of the change LGTM however.

OK.

>
> --
> Pedro

Thanks, Lorenzo
