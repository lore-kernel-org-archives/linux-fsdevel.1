Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68882E7635;
	Thu,  9 Apr 2026 02:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775703073; cv=none; b=eZIQf+9LKAT+kkmemv9t0qlnuqXB7qoNyEwXC/h89vPSanUt75hw9Rz7WxVSnoIRA4+vbanTC1lr94FP7HxUTHGsAkir2STF54JhwYl5BrcFrf6v5dVtr9uMjjpKf2sxCaNdPMAi7Z/ccDq0CNVc5zxmZF4PPTi+vxhrYLtYRHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775703073; c=relaxed/simple;
	bh=pb4X9hM5ZH85eVRwGPqpDeJTNycAfQb6SOBqEFeQrp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUWVzKdd2JXHQiq6TZVVj/E1uqqR/wQFoEt8zSLUsXiA/4ez0hUoi7S1v5nDNSsyMSrH56OCXXFLtbIaSIrjetlvXdttiWCF0mm09aufY90HPexhgRWU2V0itxqc1lM/78PDN28wloxoqfsM1HomC+FpRNeKUS3PyXqUM617Qvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deUUMGAv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deUUMGAv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2024C2BC9E;
	Thu,  9 Apr 2026 02:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775703073;
	bh=pb4X9hM5ZH85eVRwGPqpDeJTNycAfQb6SOBqEFeQrp0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=deUUMGAvKvkM3fUmHPRPbOH6ZJijZNulPZc1F7z2KcYxRxBw5VGezZ16h9X2E7Agd
	 Y2dx6IUIy5wn0L+z629ro6P7co/O9zEeC4E/EvBZsIXp+xVaIi+HElzyCiYRB+MSbR
	 wzGxaWsu0XlDs0IbhEwXZDfqw3nA3X4j7/AUJRo9LtPDAsQ8p4mGTP1Olt7Cy5F0dN
	 k+TduRW6aBiIl2Bbwedrkmgo+ygxIERs7FxilUjXPaDcYfMC4ytGe9ZZ943JsdAHNC
	 5aMGaadR8VUSsYzZwhbExZ5gBxnHxvNYREI+Rgtbb3Z7i/ALXlK++B10IxcWod0Lb2
	 /LZp0OShknESQ==
Date: Thu, 9 Apr 2026 11:51:11 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: "Denis M. Karpov" <komlomal@gmail.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>, rppt@kernel.org,
	akpm@linux-foundation.org, Liam.Howlett@oracle.com, ljs@kernel.org,
	vbabka@kernel.org, jannh@google.com, peterx@redhat.com,
	pfalcato@suse.de, brauner@kernel.org, viro@zeniv.linux.org.uk,
	jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] userfaultfd: allow registration of ranges below
 mmap_min_addr
Message-ID: <adcUHx27oZLftSjS@hyeyoo>
References: <20260407081442.6256-1-komlomal@gmail.com>
 <adXJop1d0QdH2Mwm@hyeyoo>
 <CADtiZd3AcY2LwPfCkb782TaY1h50dTPpEzhfLSyMeQeXG6VXfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADtiZd3AcY2LwPfCkb782TaY1h50dTPpEzhfLSyMeQeXG6VXfA@mail.gmail.com>

On Wed, Apr 08, 2026 at 11:09:00AM +0300, Denis M. Karpov wrote:
> > Hmm but it looks bit strange to check capability for address that is
> > already mapped by mmap(). Why is this required?
>
> Actually, it's not obvious to me either, but I may miss something.
> My intent was to replace the current restrictive check with a more flexible one.

Technically, it's less restrictive only if start < mmap_min_addr
(setting aside the discussion of whether this is an appropriate check).

Otherwise (start >= mmap_min_addr) it's more restrictive? (now, the process
should have the capability when registering an existing VMA to userfaultfd)

> I think performing this check here allows us to deny invalid requests early,
> before locks or VMA lookups occur.

But we're not trying to optimize it and we shouldn't add checks without
a proper explanation for the sake of optimization.

> Removing this check entirely would also allow using UFFD in cases where a task
> drops privileges after the initial mmap(). This seems reasonable because the
> VMA already exists, i.e. kernel already allowed this mapping.

Yeah, that seems reasonable to me.

IOW, I don't think "creating a VMA on a specific address (w/ proper
capabilities) is okay but once it is registered to userfaultfd,
it becomes a security hole" is a valid argument.

And we don't unmap those mappings when the process loses the capability
to map them anyway.

> In the [BUG] thread discussion

Was it a private discussion? I can't find Andrea's emails on the thread.

> Andrea Arcangeli also suggested adding a check for
> FIRST_USER_ADDRESS to handle architectural constraints.

Again, what's the point of checking this on the VMA that is already created?
*checks why FIRST_USER_ADDRESS was introduced*

commit e2cdef8c847b480529b7e26991926aab4be008e6
Author: Hugh Dickins <hugh@veritas.com>
Date:   Tue Apr 19 13:29:19 2005 -0700

    [PATCH] freepgt: free_pgtables from FIRST_USER_ADDRESS

    The patches to free_pgtables by vma left problems on any architectures which
    leave some user address page table entries unencapsulated by vma.  Andi has
    fixed the 32-bit vDSO on x86_64 to use a vma.  Now fix arm (and arm26), whose
    first PAGE_SIZE is reserved (perhaps) for machine vectors.

    Our calls to free_pgtables must not touch that area, and exit_mmap's
    BUG_ON(nr_ptes) must allow that arm's get_pgd_slow may (or may not) have
    allocated an extra page table, which its free_pgd_slow would free later.

    FIRST_USER_PGD_NR has misled me and others: until all the arches define
    FIRST_USER_ADDRESS instead, a hack in mmap.c to derive one from t'other.  This
    patch fixes the bugs, the remaining patches just clean it up.

    Signed-off-by: Hugh Dickins <hugh@veritas.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

Oh, ok. there might be a raw mapping without VMA below FIRST_USER_ADDRESS.

Adding such a check wouldn't hurt... but if there is no VMA, you can't
register the range to userfaultfd anyway?

> Andrea, could you please comment on this? Specifically, would a
> check against FIRST_USER_ADDRESS sufficient here, or do we still
> need to check caps?
> 
> On Wed, Apr 8, 2026 at 6:21 AM Harry Yoo (Oracle) <harry@kernel.org> wrote:
> >
> > On Tue, Apr 07, 2026 at 11:14:42AM +0300, Denis M. Karpov wrote:
> > > The current implementation of validate_range() in fs/userfaultfd.c
> > > performs a hard check against mmap_min_addr without considering
> > > capabilities, but the mmap() syscall uses security_mmap_addr()
> > > which allows privileged processes (with CAP_SYS_RAWIO) to map below
> > > mmap_min_addr. Furthermore, security_mmap_addr()->cap_mmap_addr() uses
> > > dac_mmap_min_addr variable which can be changed with
> > > /proc/sys/vm/mmap_min_addr.
> > >
> > > Because userfaultfd uses a different check, UFFDIO_REGISTER may fail
> > > with -EINVAL for valid memory areas that were successfully mapped
> > > below mmap_min_addr even with appropriate capabilities.
> > >
> > > This prevents apps like binary compilers from using UFFD for valid memory
> > > regions mapped by application.
> > >
> > > Replace the rigid mmap_min_addr check with security_mmap_addr() to align
> > > userfaultfd with the standard kernel memory mapping security policy.
> >
> > Perhaps worth adding
> >
> > Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> >
> > > Signed-off-by: Denis M. Karpov <komlomal@gmail.com>
> > >
> > > ---
> > >  fs/userfaultfd.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > > index bdc84e521..dbfe5b2a0 100644
> > > --- a/fs/userfaultfd.c
> > > +++ b/fs/userfaultfd.c
> > > @@ -1238,15 +1238,13 @@ static __always_inline int validate_unaligned_range(
> > >               return -EINVAL;
> > >       if (!len)
> > >               return -EINVAL;
> > > -     if (start < mmap_min_addr)
> > > -             return -EINVAL;
> > >       if (start >= task_size)
> > >               return -EINVAL;
> > >       if (len > task_size - start)
> > >               return -EINVAL;
> > >       if (start + len <= start)
> > >               return -EINVAL;
> > > -     return 0;
> > > +     return security_mmap_addr(start);
> >
> > Hmm but it looks bit strange to check capability for address that is
> > already mapped by mmap(). Why is this required?

-- 
Cheers,
Harry / Hyeonggon
