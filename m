Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC522BDC2A;
	Mon,  3 Aug 2026 09:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785750421; cv=none; b=XyNKirICpNhTzsYvuMGAJfWXhe17/2nPbmdGII2mHJyovgS7X33gidBPqYsVAJzdDYc8/0fQO0Qs7U2PCBxOFlVDrcB/i9ZniW1W7F80rtZIQqldXbp5DnhvMKUeRDmT8XOZ4pwDXaKeC6uT1lTb/4xTDhTsnngFtbt163tIEPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785750421; c=relaxed/simple;
	bh=GizZ3G8bdDPkWZ5FAux3v3wfPVWiMH5pE4NZ9pJD8RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUKaKMykNrolASIE/rdpakJQSlGIvDZz7G5d0V9MTO966En8KLEaDrVXaTI9JU3DXR/nAkVOYv287u9njVlOo33zu8ZTuktK+UbkMlBfARqrmppQUl3vIT0LJK/+k6641hqz0Ow9hal/CNfANveG+mIzh99e0+t98qIiognCilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWQLDfqW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWQLDfqW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE051F00A3A;
	Mon,  3 Aug 2026 09:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785750419;
	bh=WmTYhKzT9eCB53aTI2koOjOPsk0BfddrSlJB+6MBGwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZWQLDfqWcbka5ukiKfEue5Pje/KLYTUCEL5GxPuZMk668y5yZrrbvVfbFJWP7zA3e
	 oBjiNDQIR20BZMymwsL8s8U4CgxsV2V+oT+C9EgnHDcjtE+SwZEE6vBUCocLBJvZAZ
	 oS+OEr9lXrBDD416GfBtp+MCtpmUD8iIXcgzxEGAY37TuPudeHosUsXFDYJPtxheE2
	 cw42f7Cw+SZy7rm1DqhT7aJnyu7AT/KbfLNaDDrmKc4eFfi2oLMcOLG7Cqu8lnj76k
	 5LXlFPVySlsRPcciVBCN9LU0GKcoCT/+RFL04RwAtqQuRDE062VqX1KBz7K37udTlr
	 LgPcrK9j40tWQ==
Date: Mon, 3 Aug 2026 10:46:35 +0100
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
Subject: Re: [PATCH v3 01/15] mm/vma: introduce VMA anon page offset field
 and add helpers
Message-ID: <anBjLV4CvmpBzEiw@lucifer>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-1-e8ecfefea812@kernel.org>
 <2ac2746f-18b4-4960-8628-82e87c2140ce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ac2746f-18b4-4960-8628-82e87c2140ce@kernel.org>

On Mon, Aug 03, 2026 at 11:28:28AM +0200, David Hildenbrand (Arm) wrote:
> On 7/29/26 18:48, Lorenzo Stoakes (ARM) wrote:
> > This patch establishes fields within the vm_area_struct type to store the
> > anonymous page offset of VMAs.
>
> Nit: Avoid "This patch". Just say "Establish ..." (I was surprised to find
> that even Documentation/process/submitting-patches.rst document this)

Yeah ever since Boris nagged me I've (possibly reluctantly? :P) found that using
the active voice is a lot clearer and have been using that more so.

Will fix up on respin.

>
> >
> > The anonymous page offset of a VMA is equal to vma->vm_start >> PAGE_SHIFT
> > if they are unfaulted or were not remapped, otherwise it is equal to this
> > value at the point of first fault.
> >
> > Currently, anonymous folios belonging to CoW'd MAP_PRIVATE-mapped
> > file-backed VMAs are tracked by their file offset. By adding anonymous
> > offset as a property of VMAs, we can now track them by their anonymous page
> > offset instead.
> >
> > By tracking this, we provide the means by which to eliminate this
> > inconsistency, and more importantly lay the foundations for future work for
> > the scalable CoW anonymous rmap rework.
> >
> > This patch simply adds the fields and some simple helpers. Subsequent
> > patches will update mm code to make use of these fields correctly.
> >
> > The fields chosen are packed in the VMA such that, for 64-bit kernel
> > builds, no additional space is taken up.
> >
> > The first field is present on cacheline 0 containing key VMA fields, and
> > the second on cacheline 3, which contains file-backed reverse mapping
> > fields.
> >
> > Given the relative time spent accessing reverse mapping fields as well as
> > updating them, there shouldn't be any performance impact here from false
> > sharing.
> >
> > Update the VMA userland tests to account for this change.
> >
> > No callsites are updated yet, so no functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
>
> [...]
>
> > +static inline void __vma_set_anon_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
> > +{
> > +#ifdef CONFIG_64BIT
> > +	vma->__vm_anon_pgoff_hi = pgoff >> 32;
> > +#endif
> > +	vma->__vm_anon_pgoff_lo = pgoff & GENMASK(31, 0);
> > +}
> > +
> > +static inline void vma_set_anon_pgoff(struct vm_area_struct *vma, pgoff_t pgoff)
> > +{
> > +	vma_assert_can_modify(vma);
> > +	__vma_set_anon_pgoff(vma, pgoff);
> > +}
> > +
> >  static inline void vma_add_pgoff(struct vm_area_struct *vma, pgoff_t delta)
> >  {
> >  	vma_assert_can_modify(vma);
> > diff --git a/mm/vma_init.c b/mm/vma_init.c
> > index 715feee283f0..baa7e82f47e3 100644
> > --- a/mm/vma_init.c
> > +++ b/mm/vma_init.c
> > @@ -51,6 +51,7 @@ static void vm_area_init_from(const struct vm_area_struct *src,
> >  	dest->vm_end = src->vm_end;
> >  	dest->anon_vma = src->anon_vma;
> >  	dest->vm_pgoff = vma_start_pgoff(src);
> > +	__vma_set_anon_pgoff(dest, vma_start_anon_pgoff(src));
>
> It would be cleaner if both interfaces would either contain "start" or not contain it.
>
> The former would be better
>
> 	__vma_set_start_anon_pgoff(dest, vma_start_anon_pgoff(src));

Ack that's fair, will update it.

>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks!
>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
