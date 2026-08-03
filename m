Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D857034027B;
	Mon,  3 Aug 2026 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785751831; cv=none; b=Z1vpTbCM/07KYYAyYSRDytFBd9zSS+j3Ea+F5FP6xt8jVFJ7SmS42WLLcjMiCMzWfx7L8SdJtDENFR1viFpAch90ZCjs3ufzBXM8ccoqrbkd/jAffI2lmppyH1uUzeM59g0IveCbzKF7mBNQLaaXjHu6I7LCjQgmxYoxNIEo5yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785751831; c=relaxed/simple;
	bh=jsOc1LhMMI68dHKyRff8kzwbydAXGqckpk1RvqLCDBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b72FfeIJIXs/XX3tCBhlqb0s7z9lvErSxjL8PbdjzPt0qNUaerxSBShk1cx30KAxxwRqsDlHcgEp9bjjunIdkoBU9ypF003eFd3ZgHi8EeWYya1Uppi29hQ9oRYFJ2mbkfS1mzuPmaSpRzOTHcXKAdTz6OqEWuSko3PHFF40cEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4KAjlow; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4KAjlow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B021F000E9;
	Mon,  3 Aug 2026 10:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785751829;
	bh=fjlIv21Q+SMsBUXeo/sr5CkfyUQlee11htxhdsArwXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N4KAjlowkT0Supz/wF3ihdY5gmItZNr8z7m1lWpOOZKUPgLLDHGutU3CIAFhyLOF9
	 afYQvWCWNEpHQbDZP5FmwKG5Nysf2o9WeKBt5xwYZYx/wjdQuh1NrkxMD7juN5DbHy
	 yQeHe/yMXJ0fMfmwK3QQk1AAmOwe7zYndDN3Jp/pwgWLy5zOR+x6Otq4mVMIhCp7a+
	 TTkpWOdBvKYwvOw5uRMhehVKa2KL5Go6mwkeTN41/aHKayW63sEen2j1MYqVTMMwgQ
	 NCNdW2ohFW3QCl04dH/z2DCdHcukjvZSDi4NGW6fEq0MYv/std1fDvXwQYcmIC36S8
	 k4GAr+Fnlf9+w==
Date: Mon, 3 Aug 2026 11:10:07 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 02/15] mm: introduce linear_anon_page_index()
Message-ID: <anBjpdMicqaGADr-@lucifer>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-2-e8ecfefea812@kernel.org>
 <e01ad01e-715c-486d-9a26-1126c666947f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e01ad01e-715c-486d-9a26-1126c666947f@kernel.org>

On Mon, Aug 03, 2026 at 11:34:32AM +0200, David Hildenbrand (Arm) wrote:
> On 7/29/26 18:48, Lorenzo Stoakes (ARM) wrote:
> > This function provides the anonymous equivalent of linear_page_index(),
> > instead offsetting based on the anonymous page offset of the VMA.
> >
> > It is valid only for anonymous or MAP_PRIVATE file-backed mappings. It must
> > not be called for shared file-backed mappings.
> >
> > For pure anon VMAs, this will be equal to linear_page_index().
> >
> > Assert that both of these invariants are true In linear_anon_page_index()
> > and implement the algorithm in __linear_anon_page_index().
> >
> > Note that MAP_PRIVATE-/dev/zero mappings will satisfy vma_is_anonymous()
> > but not fulfill this invariant, so when asserting this we check
> > vma->vm_file to account for this.
> >
> > We do not update callsites yet, so no functional change intended.
> >
> > Also const-ify vma_is_anonymous() to make it compatible with the
> > const-ified linear_anon_page_index().
> >
> > VMA userland tests are also updated accordingly.
>
> In general looks good, some comments below.
>
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  include/linux/mm.h              |  2 +-
> >  include/linux/pagemap.h         | 42 +++++++++++++++++++++++++++++++++++++++++
> >  tools/testing/vma/include/dup.h | 25 +++++++++++++++++++++++-
> >  3 files changed, 67 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index df78847f5f07..64214191e7c6 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -1556,7 +1556,7 @@ static inline void vma_desc_set_anonymous(struct vm_area_desc *desc)
> >  	desc->vm_ops = NULL;
> >  }
> >
> > -static inline bool vma_is_anonymous(struct vm_area_struct *vma)
> > +static inline bool vma_is_anonymous(const struct vm_area_struct *vma)
> >  {
> >  	return !vma->vm_ops;
> >  }
> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index c6fc783aaee5..259177544b03 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -1101,6 +1101,48 @@ static inline pgoff_t linear_page_index(const struct vm_area_struct *vma,
> >  	return pgoff;
> >  }
> >
> > +static inline pgoff_t __linear_anon_page_index(const struct vm_area_struct *vma,
> > +					       const unsigned long address)
>
> Nit Usual "two tab" comment (same below) :)

Ack will change.

>
> > +{
> > +	pgoff_t pgoff;
> > +
> > +	pgoff = linear_page_delta(vma, address);
> > +	pgoff += vma_start_anon_pgoff(vma);
>
>
> I'd simply do
>
> 	return vma_start_anon_pgoff(vma) + linear_page_delta(vma, address);

This was just to mimic the existing thing linear_page_index() did (which in turn
was based on what the original implementation of linear_page_index()
did), will change.

>
> > +	return pgoff;
> > +}
> > +
> > +/**
> > + * linear_anon_page_index() - Determine the absolute anonymous page offset of
> > + * @address within @vma.
> > + * @vma: An anonymous or MAP_PRIVATE file-backed VMA in which @address resides.
> > + * @address: The address whose absolute page offset is required.
> > + *
> > + * This returns the anonymous page offset of @address, which is the page offset
> > + * the address possessed at the time the VMA was first faulted.
> > + *
> > + * For anonymous mappings, this returns the same value as linear_page_index().
> > + *
> > + * For MAP_PRIVATE file-backed mappings, this returns the anonymous page offset
> > + * of @address, which is the page offset the address possessed at the time the
> > + * VMA was first faulted.
> > + *
> > + * It is not valid to call this function for shared file-backed mappings.
> > + *
> > + * Returns: The absolute anonymous page offset of @address within @vma.
> > + */
> > +static inline pgoff_t linear_anon_page_index(const struct vm_area_struct *vma,
> > +					     const unsigned long address)
>
> Dito.

Ack.

>
> > +{
> > +	const pgoff_t pgoff = __linear_anon_page_index(vma, address);
> > +
> > +	VM_WARN_ON_ONCE(vma_test(vma, VMA_SHARED_BIT));
>
> Could we test or COW mappings instead?
>
> VM_WARN_ON_ONCE(!is_cow_mapping(vma));
>
> Because we must never have anon folios is non-cow mappings.

(guessing is -> in?)

is_cow_mapping() == !VMA_SHARED_BIT && VMA_MAYWRITE_BIT

!is_cow_mapping() == VMA_SHARED_BIT || !VMA_MAYWRITE_BIT (by De Morgan's law)

So the delta here would be this being called on !VMA_MAYWRITE_BIT anon mappings.

This is called from:

* linear_folio_page_index() - tests folio is anon first so must be CoW
* __folio_set_anon() - must be CoW
* __page_check_anon_rmap() - must be CoW
* try_to_merge_with_ksm_page(), ksm_might_need_to_copy() - must be CoW

So yeah this is fine, will change!

>
> [...]
>
> > +static inline pgoff_t __linear_anon_page_index(const struct vm_area_struct *vma,
> > +					       const unsigned long address)
> > +{
> > +	pgoff_t pgoff;
> > +
> > +	pgoff = linear_page_delta(vma, address);
> > +	pgoff += vma_start_anon_pgoff(vma);
> > +	return pgoff;
> > +}
>
> Same comment as above.

Ack, will change.

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
