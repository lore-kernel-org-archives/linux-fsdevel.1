Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E473B6340;
	Tue, 28 Jul 2026 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245846; cv=none; b=db6pYGDZIpm8Gk/BFWzUGHqZ6YViNSzJnkGDoEadEnm+QXHU0+SCOEqcSoihO6wBcGqfzCT7xBHmCRF9t6PUpOs6qr5myAbeO2bXsEZg1HPjbPhKk32pyvom7PvlwCqobfAypJUTf700vtEzXiR4Lw6YAGfZR4DVsLWnK8QlnlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245846; c=relaxed/simple;
	bh=vtP4tSKfRlD0meOimPOfNi5rswnt2zwKbzSaQ686COA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYtE+zuEf/cOdUii9wzXGJ3KLq7RluwxGcGsHtCteppezWLB15m2Mw5mk2RYPGpSNA7mT+K9HJ69epcUsRwa2h6Qx04ZV/uLf7WXKAwNsn8mvZG4SCW9nSeGJCPv3EcliSQxTkdiQnH8v+ZgvWpWcxeBHL4NQBF4RGw/2d6e/8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zgig0qhU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zgig0qhU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1405C1F000E9;
	Tue, 28 Jul 2026 13:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785245842;
	bh=KB/07Tb0FpiBzqRpvRWCeOJ77m9l+yyrAJxlJVmVIDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Zgig0qhUsUbAneqzMvmFr3n5e9cqebP2jQ5ufi0nFxACxgtgrEUfy4yLO2qb0mKzW
	 wAuMNIf0MPt42ieC9lzv80fPlfvESUFCROqoIKB4MJRHKOe9X9leYiBdJo33RzHH7M
	 rrJJYaM5PFinHPuqYwJKJ/0vfqvgxweo+Xj/tk/6NttUiwq9ys1aPczbET/fKVz/pk
	 DGlZkmr3s9kCJH6R0b4/twzdC1TibY+bXnnxZTIYnSMP+MxM//1g/wZ1+7mYGPVF+Y
	 tJ6RMFwzNU274KWcliBrbYZRCgSVN5GRIICRXaEvryC9mvlt8smf6uAZDul+7qUbNp
	 3Zo1EMhKLscuw==
Date: Tue, 28 Jul 2026 14:36:59 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Yang Shi <shy828301@gmail.com>
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
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 13/15] mm/vma: make MAP_PRIVATE-mapped /dev/zero
 mappings truly anonymous
Message-ID: <amiud-At9fd6AzTz@lucifer>
References: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
 <20260720-b4-scalable-cow-virt-pgoff-v2-13-2d549757a76f@kernel.org>
 <CAHbLzkrCjALeXSuO7dgho9=W-VZQxD-CXNS8iOva=oCCi1XV1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkrCjALeXSuO7dgho9=W-VZQxD-CXNS8iOva=oCCi1XV1A@mail.gmail.com>

On Mon, Jul 27, 2026 at 02:26:32PM -0700, Yang Shi wrote:
> On Mon, Jul 20, 2026 at 8:30 AM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >
> > When mapping /dev/zero with MAP_PRIVATE, one ends up with strange VMAs
> > originating from Linux's distant past.
> >
> > These have vma->vm_file set but NULL vma->vm_ops, meaning they satisfy
> > vma_is_anonymous() but otherwise resemble a file-backed VMA.
> >
> > The introduction of virtual page offsets and their subsequent use as
> > indexes for MAP_PRIVATE-file-backed mappings mean the rmap does the right
> > thing with these but we are left with inconsistencies.
> >
> > The vma_start_pgoff(vma) == vma_start_virt_pgoff(vma) invariant is true for
> > all other anonymous VMAs, but not these.
> >
> > These VMAs are also observable as files in /proc/<pid>/[s]maps but
> > otherwise behave like anonymous mappings.
> >
> > Therefore let's make these VMAs actually anonymous at mapping time which
> > will activate the anonymous code path for mappings.
> >
> > This means we no longer have to account for this discrepancy anywhere and
> > no longer have to think about these at all.
>
> I'm glad to see this is solved finally. But /proc/<pid>/smaps will not
> show /dev/zero anymore. It is user visible. I recalled you were
> concerned about it before.
> https://lore.kernel.org/linux-mm/c98f68c1-4bfd-4410-9b65-1eb5a1efe271@lucifer.local/

Well I mean they'll show but just as anon ranges so only disappear in that sense
which I think is what you mean of course!

But yeah I guess over time I've become less concerned about this side of it and
a lot more about the patent absurdity of this situation as-is :)

(Cringing at my facehugger analogy we all learn and develop on here don't we :)

>
> Anyway I don't think it is a big deal. It should be harmless. I would
> be surprised any real life workload would care whether the anonymous
> mapping is backed by /dev/zero or not in 2026.

Yeah exactly.

I was kinda hinting at this in the commit message with:

	The impact of this change should be low as likely very few are relying upon
	this in any case, and in using them are asking for anonymous memory, so no
	longer seeing these as file mappings in smaps should have no meaningful
	impact.

But perhaps I can be a little more explicit on respin!

>
> Thanks,
> Yang

Cheers, Lorenzo
