Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB5D4AD7F0;
	Fri, 11 Sep 2026 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149390; cv=none; b=m8DJ33t8LMl3WJWXOlSja9TKIIHTnv4zv6oql8dPOoTgsKx3TA1laFmfh9xXkQT3VT+vCctTBmOJ4UI/fHGgAqJCc9asWmFV4+/iCP0PnMv07a8xKHveDT8NsKNoho2HeoyXRGiejJ4mJA2Syq4WjjGNy+WFFfc2tiZa51dg0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149390; c=relaxed/simple;
	bh=GeJlJMkDlln430lCA0QsPVEGSIjiF0LIlATFP6dym7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nb5yjNA8AzKpfxMj/sg0eBEvYCkiT+pTXRHYHdkrnzVoU1oyFq0LLX0rL1RlQRI5hgjf2i9AAWN3ySCvF7VVtQHicqFAV4DfRihf3jDNtilNib5mIgMOMlERyIzIk4954Nk+nvTQNhLS8P5hne/W8/YMeFc0SjXve4qC4ovH0vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3Q9tEOV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3Q9tEOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D965D1F00893;
	Fri, 11 Sep 2026 17:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789149388;
	bh=O7i4wFJzTZyCCl1oe/KqJK+22QuW1UsUuNg+sPszn9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I3Q9tEOVl8fd7MndOkpxilz+TNqofFh3zVFY79jYW0vSNXkJU5fDsKwzkl9AtnJcE
	 gVB6USq/PgqGOhMRc+WrV089nIscoKhC211kROVObR2aWddqyjKCw3BT4TcQ4gUZGL
	 Pg8XbQ/d4fJ8rYgFFYxcUPMhSzBYNW3lXNe9G97vo4PDhTIeMjmPV9YPeJWWd3wl5O
	 tEpjvRJ111UUjcIpcZPEVn0sZAy0ySMpK5WED+KmpLafn414pimMuz+tHTSjj77LLF
	 p4PqmW34CMPs7L33XVGSVTN1eboGXo/mYfrIXY79FIzi++GIp4BgWuxYOodIS2tCFz
	 ZRU6yBO8coIog==
Date: Fri, 11 Sep 2026 18:56:22 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	david@redhat.com, willy@infradead.org, jannh@google.com, paulmck@kernel.org, 
	pfalcato@suse.de, xueyuan.chen21@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] proc/task_mmu: clarify shmem mapping walk
 conditions in smap_gather_stats()
Message-ID: <aqQ_cPerswqY9ZPL@gremlin>
References: <20260910234737.1340642-1-surenb@google.com>
 <20260910234737.1340642-4-surenb@google.com>
 <aqQoPTTUC9M5HkYb@gremlin>
 <CAJuCfpEHeFSMamNhf=FLvFjh9D8DBwZtbKwL0zi=x-2g8B+ENw@mail.gmail.com>
 <aqQzk2AT05r6rOyT@gremlin>
 <CAJuCfpEMd=hVtwe_9Rp1kqigYJwqEUGCD+ViQmoacAZONCR6DA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEMd=hVtwe_9Rp1kqigYJwqEUGCD+ViQmoacAZONCR6DA@mail.gmail.com>

On Fri, Sep 11, 2026 at 10:39:01AM -0700, Suren Baghdasaryan wrote:
> On Fri, Sep 11, 2026 at 10:10 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >
> > On Fri, Sep 11, 2026 at 04:58:40PM +0000, Suren Baghdasaryan wrote:
> > > On Fri, Sep 11, 2026 at 4:28 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > > >
> > > > On Thu, Sep 10, 2026 at 04:47:33PM -0700, Suren Baghdasaryan wrote:
> > > > > smap_gather_stats() optimizes stats gathering by skipping the walk for
> > > > > shmem mappings in certain conditions. Update the comment to clarify
> > > > > these conditions and use vma_is_cow_mapping() for COW identification
> > > > > instead of open-coding it.
> > > > > Instead of using (start != 0) condition to identify partial walks, use
> > > > > more semantically correct (start > vma->vm_start) check.
> > > >
> > > > I don't agree what you're doing is semantically correct, it's a hack really.
> > > >
> > > > Callers are passing start=0 to indicate that the entire VMA should be
> > > > processed and that happens to fulfil your criteria but in a surprising way.
> > > >
> > > > And the start in these cases is corrupted.
> > >
> > > Well, the "other" Lorenzo does not agree with you and suggested this
> > > approach in [1]. Specifically, see the comment:
> > > ```
> > > I also don't love that 0 is taken to be 'start from vma->vm_start' and I
> > > also don't love that the code in smap_gather_stats() actually special cases
> > > this...
> >
> > I'm not sure what part of this is disagreement?
> >
> > It's saying passing 0 is a hack, which is one that is still in place and which
> > this patch makes worse, because instead of explicitly calling out the invalid
> > value, you're treating it as if it were valid.
> >
> > >
> > > How about passing last_vma_end and making smap_gather_stats() more sane? In
> > > the other invocation of smap_gather_stats() we could pass vma->vm_start
> > > here.
> >
> > Yup, well me of 3 months ago should have suggested what I suggested re: wrapper
> > (I think you cut that suggestion out of my reply).
> >
> > > ```
> > >
> > > [1] https://lore.kernel.org/all/aifO_rCurVhFRTcl@lucifer/
> >
> > >
> > > >
> > > > >
> > > > > No functional change intended.
> > > > >
> > > > > Suggested by: David Hildenbrand (Arm) <david@kernel.org>
> > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > ---
> > > > >  fs/proc/task_mmu.c | 24 ++++++++++--------------
> > > > >  1 file changed, 10 insertions(+), 14 deletions(-)
> > > > >
> > > > > diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> > > > > index cfc7af1b551d..3c40c9cbb9c9 100644
> > > > > --- a/fs/proc/task_mmu.c
> > > > > +++ b/fs/proc/task_mmu.c
> > > > > @@ -1257,6 +1257,7 @@ static void smap_gather_stats(struct proc_maps_private *priv,
> > > > >                             struct mem_size_stats *mss, unsigned long start)
> > > > >  {
> > > > >       const struct mm_walk_ops *ops = get_smaps_walk_ops(priv);
> > > > > +     const bool is_partial = start > vma->vm_start;
> > > >
> > > > Yeah not in love with this, without changing how it's called.
> > >
> > > See [1]. This is exactly how you wrote it at the end of that reply.
> >
> > Assuming you passed vma->vm_start, not 0? Passing 0 makes it really strange.
>
> Ah! Now I see the problem you are pointing out. Ok, in v2 [2] this was
> done correctly and that's the way you want it!
> Okay, I agree this split was incorrect. I think I'll move is_partial
> conversion completely into the next patch and this one will only
> update the comment and use vma_is_cow_mapping() instead of open-coding
> it.

OK, it probably makes sense to have the CoW change separate.

I replied on 4/7 about how I think that should look re: wrapper functions.

>
> [2] https://lore.kernel.org/all/20260907063918.3432401-4-surenb@google.com/

--
Cheers, Lorenzo
