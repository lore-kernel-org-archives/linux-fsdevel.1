Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176772192FA;
	Thu,  9 Apr 2026 07:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775721540; cv=none; b=Ca47LIyTHSh1EpmlLnKXi/ePGwzBErkuigBeFlYDnrYEzSQwpZyuusgV+xJVT4DeLKgoxH5Hlsq+JKj0C4oQVGRH1pFrCXi+W2LRaTpLsLzJQLM4GPxZ43wfHUOl0khFSHGPAu1Utx2hT9YVQSzV//1k2B/ckOloyH8qcB24/ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775721540; c=relaxed/simple;
	bh=vWlsbBNlV4qxxJh+mktKzb+dE9BzzFofWF3ur8Ob5iM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFyo/50b6yE82WTCQBc5V5FpGmLUjt1unbjEj1mtw9x0jBO16lM+s5e8aj9JT6rVI3L2b5qVLiO2ZECpZdHqyuuftt2iGxdXAqhhPQQAbggq/3cZZMsomLJL9W8TCTVotX5RD2i8shfvJ6zZeD16et12D+NohNr3Pfwwyw5AvG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5C3Nu4w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5C3Nu4w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C7AC4CEF7;
	Thu,  9 Apr 2026 07:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775721539;
	bh=vWlsbBNlV4qxxJh+mktKzb+dE9BzzFofWF3ur8Ob5iM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y5C3Nu4w/fCBUkGKprgozESwjJS2l94AULTHqMmwU6SJoUNQDRtJDsLEwRobzzi4z
	 dMFUXS8mGNN4q6a2djyCGMWuNIB30YAfU34um99BNH928/q4kVBmFQJUM73ou7ZABi
	 K6GWcorGWf0WTlaFMoTcrwhWfGOMGqdmEgZWwdQp9xGGJiUlT50QqndTBEVnE93MPP
	 iz5f1T1ZqbMbfTHPobvw9rE1AzXoyuulPMyFFwKIhjgNMDPpBwYc67TdzDGXbulj7o
	 uTftzrY7E+0TzoL4uQ2oDMe2RsNIjr75HKWklfIfgOhXi7mw4l6GhKKWXInNJ76BJj
	 5EtRQ2+Jukm+A==
Date: Thu, 9 Apr 2026 08:58:53 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: "Denis M. Karpov" <komlomal@gmail.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, rppt@kernel.org, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, vbabka@kernel.org, jannh@google.com, peterx@redhat.com, 
	pfalcato@suse.de, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] userfaultfd: allow registration of ranges below
 mmap_min_addr
Message-ID: <addXVDMjY89-cJ4A@lucifer>
References: <20260407081442.6256-1-komlomal@gmail.com>
 <adXJop1d0QdH2Mwm@hyeyoo>
 <CADtiZd3AcY2LwPfCkb782TaY1h50dTPpEzhfLSyMeQeXG6VXfA@mail.gmail.com>
 <adcUHx27oZLftSjS@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adcUHx27oZLftSjS@hyeyoo>

On Thu, Apr 09, 2026 at 11:51:11AM +0900, Harry Yoo (Oracle) wrote:
> On Wed, Apr 08, 2026 at 11:09:00AM +0300, Denis M. Karpov wrote:
> > > Hmm but it looks bit strange to check capability for address that is
> > > already mapped by mmap(). Why is this required?
> >
> > Actually, it's not obvious to me either, but I may miss something.
> > My intent was to replace the current restrictive check with a more flexible one.
>
> Technically, it's less restrictive only if start < mmap_min_addr
> (setting aside the discussion of whether this is an appropriate check).
>
> Otherwise (start >= mmap_min_addr) it's more restrictive? (now, the process
> should have the capability when registering an existing VMA to userfaultfd)
>
> > I think performing this check here allows us to deny invalid requests early,
> > before locks or VMA lookups occur.
>
> But we're not trying to optimize it and we shouldn't add checks without
> a proper explanation for the sake of optimization.

Duplicating this kind of logic in the already horribly duplicative (and more
generally, horrible) UFFD implementation is actively buggy and incorrect IMO.

I also find it extremely odd that we are validating that a... source
address... is... mapped that way (in userfaultfd_copy(), we validate
uffdio_copy.src using validate_unaligned_range(), as well as the destination via
validate_range()).

It just makes no sense to me at all.

Let's get rid of it.

>
> > Removing this check entirely would also allow using UFFD in cases where a task
> > drops privileges after the initial mmap(). This seems reasonable because the
> > VMA already exists, i.e. kernel already allowed this mapping.
>
> Yeah, that seems reasonable to me.
>
> IOW, I don't think "creating a VMA on a specific address (w/ proper
> capabilities) is okay but once it is registered to userfaultfd,
> it becomes a security hole" is a valid argument.

Yes.

>
> And we don't unmap those mappings when the process loses the capability
> to map them anyway.

Once it's mapped it's mapped...?

>
> > In the [BUG] thread discussion
>
> Was it a private discussion? I can't find Andrea's emails on the thread.
>
> > Andrea Arcangeli also suggested adding a check for
> > FIRST_USER_ADDRESS to handle architectural constraints.
>
> Again, what's the point of checking this on the VMA that is already created?
> *checks why FIRST_USER_ADDRESS was introduced*

Yeah this is just the exact same thing with a different thing to compare
against no?

copy_from_user() will handle this in mfill_copy_folio_locked(), returning an
error if a user tried to copy from somewhere they shouldn't have (the same way
as if the user tried to copy from somewhere else they shouldn't have).

Let's not block on off-list sidebars.

>
> commit e2cdef8c847b480529b7e26991926aab4be008e6
> Author: Hugh Dickins <hugh@veritas.com>
> Date:   Tue Apr 19 13:29:19 2005 -0700
>
>     [PATCH] freepgt: free_pgtables from FIRST_USER_ADDRESS
>
>     The patches to free_pgtables by vma left problems on any architectures which
>     leave some user address page table entries unencapsulated by vma.  Andi has
>     fixed the 32-bit vDSO on x86_64 to use a vma.  Now fix arm (and arm26), whose
>     first PAGE_SIZE is reserved (perhaps) for machine vectors.
>
>     Our calls to free_pgtables must not touch that area, and exit_mmap's
>     BUG_ON(nr_ptes) must allow that arm's get_pgd_slow may (or may not) have
>     allocated an extra page table, which its free_pgd_slow would free later.
>
>     FIRST_USER_PGD_NR has misled me and others: until all the arches define
>     FIRST_USER_ADDRESS instead, a hack in mmap.c to derive one from t'other.  This
>     patch fixes the bugs, the remaining patches just clean it up.
>
>     Signed-off-by: Hugh Dickins <hugh@veritas.com>
>     Signed-off-by: Andrew Morton <akpm@osdl.org>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>
> Oh, ok. there might be a raw mapping without VMA below FIRST_USER_ADDRESS.
>
> Adding such a check wouldn't hurt... but if there is no VMA, you can't
> register the range to userfaultfd anyway?

Exactly... and I don't want to see us randomly do checks that already happened
previously.

Putting duplicated bitrot-baiting code in what is one of the worst areas of
mm is not something I want us to do, and would like us to actively remove
anything that already exists like this.

And the fact that this is in an fs/ file is even more annoying to me. Really I
don't think _any_ meaningful uffd logic belongs there. Especially since we have
a bunch of other uffd crap in mm/userfaultfd.c.

The fs/userfaultfd.c file should be a bare-bones thing that handles the fs side
of uffd _only_.

Cheers, Lorenzo
