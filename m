Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7A843787C;
	Mon, 20 Jul 2026 16:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566636; cv=none; b=gwlk9/001YMaWuclYjDDmWh2h+Ib2YwYmn7pO7IR3VYd5YmGije0vmXOoOikprALM87aVWJlSGcArJgMxOtIZezpVvonPkBK4q7R6kqk4rWi2LG6qg93Oh1GWJLSmHeSpRFpPskW8o6WqaKTSa/uM2IHvC0UsKH+KrhP6/1/g+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566636; c=relaxed/simple;
	bh=FgRqdur5Aq89BYIHBKmsVqb4F2JYjXW5a2Hi291ynfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOKcT6uN4svfhHJJS5ozs/fK8jYnxIa764TwWBl4W+ZAnbOrQHR6uWoQXOjLGhqN33eAjoEcqvA97tIvZEzjbDEhOyDNjU05bvddoCs+eEp7c5fiBPyq+hB4i8FtuqUfF/W5XNx8Sh8HtQLoNabN9rrTgRJzRIYvXl5VlXHIMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+0rOHtL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+0rOHtL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE211F000E9;
	Mon, 20 Jul 2026 16:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784566634;
	bh=FgRqdur5Aq89BYIHBKmsVqb4F2JYjXW5a2Hi291ynfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D+0rOHtLblFwv1vQAqZ8n4q2BZoYC269f3Dj57lfrIBGErTNJD/ZYF25Y3WWqLxGq
	 4WTUIQlDQYafI6HXCPO9JiU/4HGyisqChLYoQJ77S8gvVANMOZ4b3wIFn0ataNuU5U
	 RfUJcexBOxRvNQDvHjnu6mJPEh4j5US50wR8aAVlxvGhwOaHsvPPvhjmYNmJCmmSn3
	 //zVqCHibaaafUmFIkS127+nNOOWV9s+QAK1sQnL/vYWkcQGU2/1bHPY8WNj3cC87y
	 9x7zj/NMEU1g/vZy10JPPqjaFLijBgzW1JF7WXsIN0mHSZOruoXt7GRSj/RarAIGpS
	 UlyhA5WZmxRww==
Date: Mon, 20 Jul 2026 17:56:52 +0100
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
Message-ID: <al5Surm6fPIl4LNA@lucifer>
References: <20260720-b4-scalable-cow-virt-pgoff-v2-0-2d549757a76f@kernel.org>
 <20260720-b4-scalable-cow-virt-pgoff-v2-1-2d549757a76f@kernel.org>
 <al5CPpc7XpRX7Vbt@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al5CPpc7XpRX7Vbt@gourry-fedora-PF4VCD3F>

On Mon, Jul 20, 2026 at 11:49:00AM -0400, Gregory Price wrote:
> On Mon, Jul 20, 2026 at 03:38:27PM +0100, Lorenzo Stoakes (ARM) wrote:
> >
> > The virtual page offset of a VMA is equal to vma->vm_start >> PAGE_SHIFT if
> > they are unfaulted or were not remapped, otherwise it is equal to this
> > value at the point of first fault.
> >
>
> The latter half of this description is a bit confusing.
>
> Why would the value differ from (vma->vm_start >> PAGE_SHIFT)?
> (because it's file backed?

Because the VMA gets remapped.

If it's remapped when it's unfaulted, then virtual page offset gets updated, if
it's faulted then not.

That's because when faulted folios may reference the original offset :)

Scalable CoW will likely change this but that's a forthcoming series of many
series :P

>
> It sounds like this value can change in response to an event, which
> makes me thing a reader could see two values across two calls?

Remapping :) and no a reader cannot (locking etc. :P)

>
> Apologies if i'm fundamentally misunderstanding something.

No that's a sign that probably I'm not being clear enough! Can try to clarify on
next respin.

>
> ~Gregory

Cheers, Lorenzo
