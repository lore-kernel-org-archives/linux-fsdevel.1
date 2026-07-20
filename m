Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765A630595B;
	Mon, 20 Jul 2026 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555275; cv=none; b=mp3Ph5rcvSjTyBq7g8HbU5Z+34dpNAVagByHOq9anF/qXJqIX0cWmQz6NsDn9JD0TZITGjaawssIsUHvpakt8AzDmu+9leDV4wZe4RZORyUEUt6nKMk+Z4lSpIzwcKcXWsrOt+rDcXiijVMo05r6Zetdir6P46f31SC+nloVcR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555275; c=relaxed/simple;
	bh=kXooEgSoXcuhNAbJx8Sd5T6Eee8JvBtnWFh2Q/Q0dVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2gahOQv7aWoiqMW8FPDpyPz7E6BOC130fDSAwvDYJ7ebjrFzitKSuoHxC7WTCO+VFK+T0Z1GLeJbvRGToAsSVretCzvxw4LDHvuV1ARMl9ne3yphb3dS+3iYA6cx6sPkwc9QJEWKBV53hmlyMW5jzhkstI3hCaMoDCKqu4JjN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTJI3wmK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTJI3wmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D25C1F000E9;
	Mon, 20 Jul 2026 13:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784555274;
	bh=kXooEgSoXcuhNAbJx8Sd5T6Eee8JvBtnWFh2Q/Q0dVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aTJI3wmKsPlHpTouI7l29PN4C4s4RZ+I5yGc8W83xTfsJtodi0R0ImMV0oLJIoZgm
	 siOfGlvOp2zFChQK0n7QRqtnCvmcwFnkarmxWHPry4aVIrZELkbuoIE1qh21SPhrYp
	 gGljkzvVqei284ThFY+J18FddOczIFDkKYmV6GpUfl65FaMlJ6/zNkAabS1/UtpqKB
	 NJrY1+VNuNSRzghb9QhVKv7205sDQpnSkJ+GnFEUFekMrqnJRpVRIBDMwQp8s+V5Kr
	 Dq6Ck/s0mlACaBBvomypCXFQdqfQX0fUGOw0buAJGqkdG+p9w9dsA+g9ovLKqCdHDe
	 /HCaDv+eDpa9Q==
Date: Mon, 20 Jul 2026 14:47:31 +0100
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
Message-ID: <al4mxWe6hKxyTtHO@lucifer>
References: <al3KlYMbmeR6iDX8@lucifer>
 <20260720153816171RRd991pToocX8jt6806EG@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720153816171RRd991pToocX8jt6806EG@zte.com.cn>

On Mon, Jul 20, 2026 at 03:38:16PM +0800, xu.xin16@zte.com.cn wrote:
> > > > This patch establishes fields within the vm_area_struct type to store the
> > > > virtual page offset of VMAs.
> > > >
> > > > The virtual page offset of a VMA is equal to vma->vm_start >> PAGE_SHIFT if
> > > > they are unfaulted or were not remapped, otherwise it is equal to this
> > > > value at the point of first fault.
> > > >
> > > > Currently, anonymous folios belonging to CoW'd MAP_PRIVATE-mapped
> > > > file-backed VMAs are tracked by their file offset. By adding virtual offset
> > > > as a property of VMAs, we can now track them by their virtual page offset
> > > > instead.
> > > >
> > > > By tracking this, we provide the means by which to eliminate this
> > > > inconsistency, and more importantly lay the foundations for future work for
> > > > the scalable CoW anonymous rmap rework.
> > > >
> > > > This patch simply adds the fields and some simple helpers. Subsequent
> > > > patches will update mm code to make use of these fields correctly.
> > > >
> > > > The fields chosen are packed in the VMA such that, for 64-bit kernel
> > > > builds, no additional space is taken up.
> > >
> > > It is not necessarily true that no additional memory will be consumed, as it
> > > depends on whether the baseline kernel has CONFIG_PER_VMA_LOCK enabled.
> >
> > We are moving to this being permanently enabled.
> >
> > > Moreover, in the future evolution of mm, maintaining this benefit would
> > > require that the layout of struct vm_area_struct before __vm_virt_pgoff_lo
> > > remains unchanged, which seems impractical.
> >
> > It isn't, we are very careful with this struct.
>
> Ok, That will be nice.
>
> >
> > >
> > > My personal suggestion is: maybe we could simply add an unsigned long field,
> > > say vm_virt_pgoff, without worrying about the increased memory footprint for
> > > now. Additionally, it would be helpful to add some comments clarifying the
> > > difference between this new field and the existing vm_pgoff, to aid understanding.
> >
> > Nope that'd add 64 bytes per VMA for a typical usage which can add up to a lot.
>
> Okay, but I hope at least we could be a bit more verbose in the comments, because
> __vm_virt_pgoff_lo and __vm_virt_pgoff_hi are located somewhat far apart from each
> other, which might cause considerable confusion for others seeing these two
> variables for the first time, and clarify difference between this new field and the
> existing vm_pgoff, to aid understanding.

OK, I've added comments, these ultimately refer to the vma_start_virt_pgoff()
comment which gives further details.

>
> Thanks.

Cheers, Lorenzo
