Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED81435EC1;
	Mon,  3 Aug 2026 13:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785764816; cv=none; b=BUXkko5fDT5EwS3B5trqnnjLWPJfMpuVKTdwMqlFBNkpi9UfWTDZVyK/GkNObr4KUk5qLjVusPxlakKTO2W6gZrEmjYFPdysk4jNuczbX3wmrGAq6sJP0Ti0KFYT5hA93mZAjn7CXr9tEUdhDZ6czvh4mH2HkmQooJ0+duurCGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785764816; c=relaxed/simple;
	bh=+6t5hQGiaWrn5MIcT1oNxAGXwcUgLfnokquEL8Y5BLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iji4usNl7Yg4Y4ZkdXWtwJjlddz4X6HX5VwhAcfRSaqu0sSHhlwqDnyMQRUuUrwkrzmCAA8+OzpR8kw53UDZvO5DeY8aNd9PjSZ2CWQ9FFQj6m2JPbVxuCpa2ZTdpzjvbCG3UYQ7tFBMZZs38jH1MVNkbzA89CBWHw9ebQN+UaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqmNyeRu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqmNyeRu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982A51F00A3E;
	Mon,  3 Aug 2026 13:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785764814;
	bh=m2q4F0oL2477vtEU1dLCuKFUHXuEfn75EzPRR+HK7ws=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eqmNyeRu9MMThDgrJTemIAYVn5WtoRn3cu3pmch93QP5K4lX4sDg/pm0ttCpuOjLo
	 8+PXLi+w5RboMoDuuWynCLpTTszMlS13U6r8PTRN0vJrUbEXAWih1+pQyNXP/cyS6G
	 4bUXzZTjw11UMbSWC6wiNClS8+y//ZlGwijgAlT5pOP301hF9HoXXhZdJb583Zu+4m
	 IiumEe2kHNGvlWTLDFIIUXkE/WEtdAJbwtb+QHDkb6cWaw1KeSezh9SqqenYI0gPDy
	 Owyyd2AzuKyBRmgPyVYfFdYKGccjqFlh5QQ0Z03RLC/KeTPHYlhnYeNeQdDGW1g7/r
	 GIQVjwF83rCig==
Date: Mon, 3 Aug 2026 14:46:32 +0100
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
Subject: Re: [PATCH v3 06/15] mm: propagate VMA anonymous page offset on map,
 remap, split + merge
Message-ID: <anB9MWSSITYpDibA@lucifer>
References: <20260729-b4-scalable-cow-virt-pgoff-v3-0-e8ecfefea812@kernel.org>
 <20260729-b4-scalable-cow-virt-pgoff-v3-6-e8ecfefea812@kernel.org>
 <4ad4b17b-bae6-4169-8649-bff4a29e7fde@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ad4b17b-bae6-4169-8649-bff4a29e7fde@kernel.org>

On Mon, Aug 03, 2026 at 12:52:42PM +0200, David Hildenbrand (Arm) wrote:
> On 7/29/26 18:48, Lorenzo Stoakes (ARM) wrote:
> > We must correctly update VMA anonymous page offset state on all VMA
> > operations that would result in it changing, with special attention given
> > to remapping.
> >
> > We cover most cases by simply updating vma_set_range() to do so (with a new
> > anonymous page offset parameter), but also notably must update the merging
> > and mapping logic to propagate this parameter correctly.
> >
> > The remap logic remains the same - we may update the anonymous page offset
> > if the VMA is unfaulted, but now this applies to MAP_PRIVATE file-backed
> > mappings too, so we update the code to reflect this.
> >
> > Note that we use __linear_anon_page_index() upon remap as the VMA may be
> > shared, in order that we update the field consistently regardless of VMA
> > type.
> >
> > Similarly, pass through anon page offset to the merge logic, updating the
> > vma_merge_struct struct to propagate it, and also use
> > __linear_anon_page_index() to obtain the anonymous page index so it can be
> > safely used for both shared and MAP_PRIVATE file-backed mappings.
> >
> > Finally, we update insert_vm_struct() to correctly set the anonymous page
> > offset on insertion of a VMA.
> >
> > We simply ensure state is correctly propagated here, so no functional
> > changes are intended.
> >
> > Also while we're here, replace a VM_BUG_ON_VMA() with a
> > VM_WARN_ON_ONCE_VMA().
> >
> > Also update VMA userland tests to reflect this change.
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
>
> [...]
>
> >  	struct vm_area_struct *vma = *vmap;
> >  	unsigned long vma_start = vma->vm_start;
> > @@ -1919,11 +1929,14 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
> >  	VMG_VMA_STATE(vmg, &vmi, NULL, vma, addr, addr + len);
> >
> >  	/*
> > -	 * If anonymous vma has not yet been faulted, update new pgoff
> > -	 * to match new location, to increase its chance of merging.
> > +	 * If a vma has not yet been faulted, update its anonymous pgoff to
> > +	 * match the new location to increase its chance of merging.
> >  	 */
> > -	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
> > -		pgoff = addr >> PAGE_SHIFT;
> > +	if (!vma->anon_vma && !vma_test(vma, VMA_SHARED_BIT)) {
>
> Could we also use is_cow_mapping() ?

No this would be incorrect.

A read-only mapping would become unmergeable here. So this is something apart
from the rmap aspect, and it is a contract that upon move of an unfaulted
mapping (which for read-only anon would always be unfaulted) that vma->vm_pgoff
is updated.

This is later in this series extended to MAP_PRIVATE file-backed mappings also.

Also it would break the faulted_in_anon_vma logic and result in incorrect
VM_WARN_ON_ONCE() invocations below.

As for other -> is_cow_mapping() changes:

* linear_anon_page_index() - [as discussed already] - fine
* vma_anon_address() - convert to is_cow_mapping() [have to be faulted in to hit it]
* needs_adjacent_anon_pgoff() - don't convert - same merging argument as above.

>
>
> > +		anon_pgoff = addr >> PAGE_SHIFT;
> > +
> > +		if (vma_is_anonymous(vma))
> > +			pgoff = anon_pgoff;
> >  		faulted_in_anon_vma = false;
> >  	}
> >
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
