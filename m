Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C113B71B9;
	Mon, 20 Jul 2026 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784531675; cv=none; b=JUCClBqaSai7+qKVeb2KsvyQddJGrQFZBDqrfdYZe7L204xWdDfV1SOAFGTvbUryPLgSYD+qYwRObOIneY+/CSTADmEqVx3/JHZ7m6M6s0CNU3SF5q0T6+ypduUNj13uhE3iwVcOjr6CRtt2T3y/Z5qwzGXWN/lp3uYbP/iRZ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784531675; c=relaxed/simple;
	bh=HR5MaFBcIWRPfZXz+UMzDN4+c9DOvTEFHnoiRpsQf+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dqpO2hGPLrQh3Otegl265WoHWyKf6xFLJOK0qkZNqTofDpEH3YGpdyu/DnnYv2UtD844Pd2SlXT6z0NkQFNUrIpq+7BxUvZQgSPc6EPZv3lk4NVkihJXpHe/B35mnRreADdgjIsx809bEvi/w9Cfj/mze/s8nxCIoPpXevuTNqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qc2SHIfq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qc2SHIfq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0064A1F000E9;
	Mon, 20 Jul 2026 07:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784531671;
	bh=8c1NwXrdIUkx3pvI3J59TnigPzn4Ew9yA8/E48gML0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Qc2SHIfqPkpRmaLfQdPjU+4iOnjqK8iSvAn5ApPARqUjV/vl/u+KoBHUB85YlZ/FD
	 lg4Y1hWW1b7PWD0l3LwYX25F7pbuztAnDVpabiqbnovQK3zXE7TWbOZq5IXimi411r
	 5+xtIgrHltyPrAHhl0eMpHV2DcWX86lNtU0v4CUpZHM1lGJVGTqsst3Z9pKO0S+DRM
	 wAPZB1+Atkh1xsyHhVr+0sCLrtDId47LU6FkiKcsWFrXgrUebnYPtefQZYGlYksngy
	 pglpmj3RC+lXTq3HysYz+HdkRpMXS9sSKVaGsNum0/pC3WMyIBMR4wBBzWmC0xpfR1
	 iX9TdZfJMaM/g==
Date: Mon, 20 Jul 2026 08:14:08 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: xu.xin16@zte.com.cn
Cc: akpm@linux-foundation.org, david@kernel.org, liam@infradead.org, 
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com, 
	jannh@google.com, pfalcato@suse.de, willy@infradead.org, jack@suse.cz, 
	linmiaohe@huawei.com, nao.horiguchi@gmail.com, riel@surriel.com, harry@kernel.org, 
	lance.yang@linux.dev, kees@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	usama.arif@linux.dev, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, peterx@redhat.com, chengming.zhou@linux.dev, 
	arnd@arndb.de, gregkh@linuxfoundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 01/15] mm/vma: introduce VMA virtual page offset field
 and add helpers
Message-ID: <al3KlYMbmeR6iDX8@lucifer>
References: <20260717-b4-scalable-cow-virt-pgoff-v1-1-cf24910ef094@kernel.org>
 <202607191155425057lNrNOYTi44E_jmidmtkn@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202607191155425057lNrNOYTi44E_jmidmtkn@zte.com.cn>

On Sun, Jul 19, 2026 at 11:55:42AM +0800, xu.xin16@zte.com.cn wrote:
> > This patch establishes fields within the vm_area_struct type to store the
> > virtual page offset of VMAs.
> >
> > The virtual page offset of a VMA is equal to vma->vm_start >> PAGE_SHIFT if
> > they are unfaulted or were not remapped, otherwise it is equal to this
> > value at the point of first fault.
> >
> > Currently, anonymous folios belonging to CoW'd MAP_PRIVATE-mapped
> > file-backed VMAs are tracked by their file offset. By adding virtual offset
> > as a property of VMAs, we can now track them by their virtual page offset
> > instead.
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
>
> It is not necessarily true that no additional memory will be consumed, as it
> depends on whether the baseline kernel has CONFIG_PER_VMA_LOCK enabled.

We are moving to this being permanently enabled.

> Moreover, in the future evolution of mm, maintaining this benefit would
> require that the layout of struct vm_area_struct before __vm_virt_pgoff_lo
> remains unchanged, which seems impractical.

It isn't, we are very careful with this struct.

>
> My personal suggestion is: maybe we could simply add an unsigned long field,
> say vm_virt_pgoff, without worrying about the increased memory footprint for
> now. Additionally, it would be helpful to add some comments clarifying the
> difference between this new field and the existing vm_pgoff, to aid understanding.

Nope that'd add 64 bytes per VMA for a typical usage which can add up to a lot.

>
> Thanks,
> Xu Xin
>
> >
> > The first field is present on cacheline 0 containing key VMA fields, and
> > the second on cacheline 3, which contains file-backed reverse mapping
> > fields.
> >
> >
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > ---
> >  include/linux/mm.h              | 59 +++++++++++++++++++++++++++++++++++++++++
> >  include/linux/mm_types.h        |  4 +++
> >  mm/vma.h                        | 14 ++++++++++
> >  mm/vma_init.c                   |  1 +
> >  tools/testing/vma/include/dup.h | 26 ++++++++++++++++++
> >  5 files changed, 104 insertions(+)
> >
> > +static inline pgoff_t vma_last_virt_pgoff(const struct vm_area_struct *vma)
> > +{
> > +	return vma_end_virt_pgoff(vma) - 1;
> > +}
> > +
> >  static inline unsigned long vma_desc_size(const struct vm_area_desc *desc)
> >  {
> >  	return desc->end - desc->start;
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index 939b5ea8c9e0..2710628059b1 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -967,6 +967,7 @@ struct vm_area_struct {
> >  	 */
> >  	unsigned int vm_lock_seq;
> >  #endif
> > +	unsigned int __vm_virt_pgoff_lo; /* Low 32-bits of virtual pgoff. */
> >  	/*
> >  	 * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_vma
> >  	 * list, after a COW of one of the file pages.	A MAP_SHARED vma
> > @@ -1041,6 +1042,9 @@ struct vm_area_struct {
> >  #ifdef CONFIG_DEBUG_LOCK_ALLOC
> >  	struct lockdep_map vmlock_dep_map;
> >  #endif
> > +#endif
> > +#ifdef CONFIG_64BIT
> > +	unsigned int __vm_virt_pgoff_hi;  /* High 32-bits of virtual pgoff. */
> >  #endif
> >

Cheers, Lorenzo
