Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952443FADE0;
	Mon, 27 Jul 2026 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153841; cv=none; b=pZFCL1F2qq1z8/+KXQD0ynX4jYTVT0w2nC3oFK01qGUFvi618hhwTvYjg+pLgUtOTaopurSQrQSF8I2w3x5b9Smhg/8PyrurQJ7fM5zBr3HAKv21xAVt9hlDvxY16RJIP9wNEBp6kIMvaa7D9Dvvj3DAhV5j+7xTXWu8CZ9iUcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153841; c=relaxed/simple;
	bh=D2aJdor0Hpg/4jj2tv4oBgjyWI0Kytt4Ww5CPykH9Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcW2Pj4OcB/GW/07+e6UZIj8ZSgQ8nSqmYwAQfpsz/MSyZXWk90M/CBttf2L3P73MxQO0DAdAHuVnBMb3QHuLFP2sRIBpNfM2aKPIeY6nBrr4iWOQsoUfp6t7NLBO5lueXQ/TIOak2zVdbV4dxMUI2jlz6yS/2kFKk9F+tVRIrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXWaNyRr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXWaNyRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 316601F000E9;
	Mon, 27 Jul 2026 12:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785153840;
	bh=D2aJdor0Hpg/4jj2tv4oBgjyWI0Kytt4Ww5CPykH9Pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AXWaNyRrrKMWJ1IJNk5RXToC/2L4hiE1iNCbYl8psZB8Glfv0hWK7Oez2SFNvZ3FY
	 1/QbnH/o5rOsHxOr3kZErOTxDUYZ6lqoJMSUdQ0EmsPjNIStps7ipAAwAXKH/m3NFs
	 MITHDis7uQbUkp3Z9jabBs2A4H1gTqHCPmCV468Hxr7i/ZMNrfEuK+9GXs86LuT0gZ
	 BNRA9lMNA6Cvvl4V8D0gYUrNdAveWnRNjUeD+aBxIqjN0Ll18daIR7Cnw1SX29XuTG
	 dErEnkU7cyxLLddSK6WletbqXXvmomBknPSxugnmXwR4XZ5NdhKsWik6ZNFEnrMWih
	 m05vdEyriPRdA==
Date: Mon, 27 Jul 2026 13:03:38 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>, 
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 01/15] mm/vma: introduce VMA virtual page offset field
 and add helpers
Message-ID: <amdJEz-Sl8LRB_5l@lucifer>
References: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
 <20260720-b4-scalable-cow-virt-pgoff-v2-1-2d549757a76f@kernel.org>
 <al5CPpc7XpRX7Vbt@gourry-fedora-PF4VCD3F>
 <al5Surm6fPIl4LNA@lucifer>
 <al5ZPYH-0T6IPXox@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al5ZPYH-0T6IPXox@gourry-fedora-PF4VCD3F>

On Mon, Jul 20, 2026 at 01:26:09PM -0400, Gregory Price wrote:
> On Mon, Jul 20, 2026 at 05:56:52PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Mon, Jul 20, 2026 at 11:49:00AM -0400, Gregory Price wrote:
> > > On Mon, Jul 20, 2026 at 03:38:27PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > >
> > > > The virtual page offset of a VMA is equal to vma->vm_start >> PAGE_SHIFT if
> > > > they are unfaulted or were not remapped, otherwise it is equal to this
> > > > value at the point of first fault.
> > > >
> > >
> > > The latter half of this description is a bit confusing.
> > >
> > > Why would the value differ from (vma->vm_start >> PAGE_SHIFT)?
> > > (because it's file backed?
> >
> > Because the VMA gets remapped.
> >
> > If it's remapped when it's unfaulted, then virtual page offset gets updated, if
> > it's faulted then not.
> >
>
> ahhhhh the wording is just wonky then
>
> when faulted or remapped, x is...
> when unfaulted or unremapped, x is...
>
> instead of
>
> x is ... if unfaulted or were not remapped, otherwise...
>
> Sort of a complex combination of 3 negatives there.
>
> ~Gregory
>

Ack, will improve wording!

Cheers, Lorenzo
