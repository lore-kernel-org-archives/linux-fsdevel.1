Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794245409;
	b=37FvDr0zXG4z69Yt41wP3p7kIkWMhTWyHMSIfSSofGINkkSWO4PQiqzlEBdS+mSY0QBe
	 KdnmC6yhOUYalQS8S2qT6J95we+hk0w0fZ6JVzh/48FIF/sMekVtzLbTepXXHypqAY8c0
	 NJ66x4y+pLQYbp/8YMEVcXUkAAoCArGDjfLB1dx7R4mAs/7CvKqi9Nxo6XiIWoi4ptG84
	 D60pRm46P7jAkAAz2bRMDGGTziWZ7L6X9cxwGcGSqAPPmPx4DNFfPg2R2htbzox8+1m03
	 RSXbkqnnqgDTrriW7GEAfx9YC6+7nikkGuDg+MlIS1WsBHzQaeNUvxGtUvuhvGOs5uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794245409;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8ZMtATJ/UU7bDo4o1x8DtF/SV0R6ntQW02njcbLrqVg=;
	b=xsKRPAj2VUHYhBdAHp5BKuFV8KgbGFNSkuTwPPZMqVeQaB5LzPQzEsysoE6jmwqWmAgg
	 XP0nkskM3f8C+0ORaCmSDQ3KW97gjv4X3p6noZr3vUV1Eqibzqcq+NYbI4QNeXEM6aY+A
	 CGGO92wLzPU0vTkHRwks3mFNs0Q6WvejX6fkeZQWLE52m+S5HAQkiDeln3BcZU7PhYRvk
	 C7EM426r2xsBOjjB7fLe/rbW9Rp7ADEnyrAl2MZOEF5Ajx2ViwECAQeC7WeuHAJ9cMOEv
	 RAl34mEy8tCtR0VWsqI+eidXvV4yzseblbxI9f4t80pcT4Uwi02zzvdB8nDaHWBsJxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+p2wwv4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0251E606A31C;
	Mon,  9 Nov 2026 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+p2wwv4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B38E1F0089F;
	Mon,  9 Nov 2026 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794245408;
	bh=8ZMtATJ/UU7bDo4o1x8DtF/SV0R6ntQW02njcbLrqVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U+p2wwv4C+kQrVcwZvssLOeRpnAgXsEULsPEgNyaaaIxvwy/8/VtD7V4xk8S90u/q
	 LOzpzC2I2lypdwvarPxFoXZ7SYIzpf7KZZhW/8vXrIgqI+IgENJqFXQU1wqLD0ZOJt
	 ad9lrl+xLEN7TPiZR3cdsFR1ipJLh+td95pCLRukwR/oOEuLFRXdiRI4ocrMdAlKbR
	 oe6DlyKpJmPXb+qNL3Tk1lYBmV8tdok1UwWiuymyAA+cpLqFduKw2owvoWvPHPaF/3
	 o+VT27eAshKjqwOUMveGvqJzOJSm4cz5J+3aog8pZOgcSCH8Hr8iwXzAwL8qFGDu3a
	 zpuGkCZ3Ayn/A==
Date: Mon, 9 Nov 2026 17:30:02 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/2] mm/memory: recheck PG_uptodate after
 ->page_mkwrite()
Message-ID: <avICl6pdLiWvO3X1@gremlin>
References: <20261109120403.82361-1-kas@kernel.org>
 <20261109120403.82361-2-kas@kernel.org>
 <avHWhZzXE-ge6nU6@gremlin>
 <avH3L4ZbQC6fIt5s@thinkstation>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avH3L4ZbQC6fIt5s@thinkstation>

On Mon, Nov 09, 2026 at 05:17:03PM +0000, Kiryl Shutsemau wrote:
> On Mon, Nov 09, 2026 at 04:11:40PM +0000, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Nov 09, 2026 at 12:04:01PM +0000, Kiryl Shutsemau (Meta) wrote:
> > > do_shared_fault() unlocks the folio around ->page_mkwrite(). Writeback
> > > can lock it in that window, fail, and clear PG_uptodate with the folio
> > > left in the page cache. ecryptfs_writepages() does this when encryption
> > > fails. filemap_page_mkwrite() relocks the folio and checks only
> > > ->mapping, so the fault maps a folio that is not uptodate:
> > >
> > >     CPU0                            CPU1
> > >     do_shared_fault()
> > >       folio_unlock()
> > >                                     ecryptfs_writepages()
> > >                                       folio_clear_uptodate()
> > >       filemap_page_mkwrite()
> > >         folio_lock()
> > >       finish_fault()
> > >
> > > The next read(2) or fault on the folio reads it in again from the file,
> > > over anything stored through the mapping in the meantime. Those stores
> > > are lost.
> > >
> > > Recheck PG_uptodate once ->page_mkwrite() returns with the folio locked,
> > > and retry the fault if it is clear, the same way filemap_fault() retries
> > > on a cached folio that lost PG_uptodate. Skip folios outside the page
> > > cache: driver pages from ->fault() never get PG_uptodate and would
> > > retry forever.
> > >
> > > The check stays out of do_page_mkwrite(): wp_page_shared() calls it on
> > > a folio that is still mapped, and a retry there would fault on the same
> > > PTE forever.
> > >
> > > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > > Closes: https://lore.kernel.org/sashiko-outbox-202966@kernel.org/
> >
> > No Fixes? Sorry I may have missed context from v1 here :)
>
> The window is from 2007, when __do_fault() started to drop the folio
> lock around ->page_mkwrite():
>
> Fixes: 6967614761fd ("ocfs2: release page lock before calling ->page_mkwrite")

Yeah not insisting!

>
> Not sure how useful such Fixes is. It predates any possible stable tree.
>
> > > ---
> > >  mm/memory.c | 22 ++++++++++++++++++++++
> > >  1 file changed, 22 insertions(+)
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index fe72e66c9c2e..cc1d0b7d15c7 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -5613,6 +5613,18 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
> > >  	return VM_FAULT_OOM;
> > >  }
> > >
> > > +/*
> > > + * A page cache folio that is not uptodate holds data that was never read in
> > > + * or cleared, and mapping it leaks stale memory to userspace.
> > > + */
> > > +static bool file_folio_not_uptodate(struct folio *folio)
> > > +{
> > > +	if (likely(folio_test_uptodate(folio)))
> > > +		return false;
> > > +	/* Driver pages from ->fault() never get PG_uptodate */
> >
> > I guess you mean drivers that return non-page cache folios from ->fault()?
>
> Yes. How about:
>
>         /*
>          * ->fault() can also return driver memory that is not in the page
>          * cache. It never gets PG_uptodate.
>          */
>
> I would rather avoid "rmappable". These folios do get
> folio_add_file_rmap_ptes() in set_pte_range(), and the word reads like
> PG_large_rmappable. As you said, DAX never reaches the check, so "page
> cache" is accurate.

OK, though my concern is you're making an assumption based on where this is
called from, somebody else could use the function somewhere else and... :)

But this is nitpicking really, that's fine!

>
> > > +	return !folio_test_anon(folio) && folio->mapping;
> >
> > Technically folio_test_anon() can never return true based on where this is
> > called from right? Could this just be a:
> >
> > 	VM_WARN_ON_ONCE(folio_test_anon(folio));
> > 	/* ... comment */
> > 	return folio->mapping;
> >
> > Instead?
>
> Right, all callers pass a file folio.
>
> I will make it an assert, but at the top of the helper, so it checks
> every call and not only the rare !uptodate one.

Thanks!

>
> > > @@ -6163,6 +6175,16 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
> > >  			folio_put(folio);
> > >  			return tmp;
> > >  		}
> > > +
> > > +		/*
> > > +		 * The folio was unlocked for ->page_mkwrite(). If it lost
> > > +		 * PG_uptodate meanwhile, retry the fault to read it in again.
> > > +		 */
> > > +		if (unlikely(file_folio_not_uptodate(folio))) {
> >
> > As Pedro said, I think this unlikely() is probably unnecessary given the true
> > return case is implicitly unlikely.
>
> As I told Pedro, I prefer it at the call site. That is where the reader
> needs to see that the retry is the rare path. But if you insist...

You could also remove the likely() in the function itself ;)

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

--
Cheers, Lorenzo
