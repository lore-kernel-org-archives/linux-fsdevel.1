Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6517B43C7B6;
	Tue,  4 Aug 2026 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848650; cv=none; b=L2b3E8UfJe7NtQDIqNJ/eVierVMjt5rS6wE2byGZrqtiWouTs5K8Gi1mrmv4OOs8KSztOJxcmctIDKIWLFjX/KHIvBP1adDb/67mnR/9RKo7sOSrev6KscxrTkqHlvL5nzxxXyIAQhYIxvqW5bakRp8ddw9xjy3+rAfJS9t7nyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848650; c=relaxed/simple;
	bh=7WVi0zd6LcUoDLabZYLULWttoR4Wlz1WJNokp6HKtFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhaCSp4iwQlX97OhzyJ9BAlPBDmLRgsEQ6Mn+RIgnT2lrMxYFiQOUdNKtMgosizOR8GvOEbLGhQSmcPk/0YJiyLw/6qsdH38ybV3EqRTmPuvIpu0PX5zM+T6fEbxtg9EUAMcaeTwLrEN8JjAPZAbMkzOuZ5C+aA9eqUtDTQtS8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZ8xZk5P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZ8xZk5P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DAB1F00A3D;
	Tue,  4 Aug 2026 13:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785848649;
	bh=7WVi0zd6LcUoDLabZYLULWttoR4Wlz1WJNokp6HKtFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aZ8xZk5PzuGz/b2moWBb4VVtz0n3Ung2XSO7gIhRagGOIZjNIMkuzHy6jFMeVHTWF
	 nA1BvJi/iE2VrsC4XD17lCgxplfi63Afoif31Yj2W0EGlxUQiKtKFRwnI+14Z77Zm/
	 wyREeQLepUuHknwIHKHs5MtSxkyB6+MmQecXZ+aqfDSvp48OtiFS+A/zUg63hoVMix
	 vyCQNYITywtcPJ3HpjO2neSJHyvnHkv687QC8xcOOIa/gki5DxBEwggQe/7XGb0akN
	 nzWsq0j8rO5RTc990ehdmT0keE1zCMZ4cmTlxK1aOc4jA6KVyjsh2uKeL8OyzltUDm
	 Jyzl0tvAyFYNw==
Date: Tue, 4 Aug 2026 14:03:47 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	John David Anglin <dave.anglin@bell.net>
Subject: Re: [PATCH v2 2/6] parisc: Drop own implementations for ptep_get()
 and ptep_test_and_clear_young()
Message-ID: <anHi9n3_8bLjAsxy@lucifer>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-3-pfalcato@suse.de>
 <anHHyiHqYf3yLf2K@lucifer>
 <anHcJZYyz9Zrshdm@pedro-suse>
 <anHd7ho3daZFZ-4r@lucifer>
 <e7ac6f83-72ff-43c0-b67b-6b17caed995e@gmx.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7ac6f83-72ff-43c0-b67b-6b17caed995e@gmx.de>

On Tue, Aug 04, 2026 at 03:00:43PM +0200, Helge Deller wrote:
> On 8/4/26 14:42, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Aug 04, 2026 at 01:34:41PM +0100, Pedro Falcato wrote:
> > > On Tue, Aug 04, 2026 at 12:11:08PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > > On Mon, Aug 03, 2026 at 05:43:56PM +0100, Pedro Falcato wrote:
> > > > > From: Helge Deller <deller@gmx.de>
> > > > >
> > > > > Switch to the generic implementations, which are identical.
> > > >
> > > > You sure do like succinct commit messages :)
> > >
> > > I didn't even write this one! See the From: :))
> >
> > Lol well then feedback addressed to Helge ;)
>
> Noted :-)
>
> > > > Maybe worth saying by dropping the __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG and
> > > > ptep_get defines you get the generic versions from include/pgtable.h which are
> > > > functionally identical.
>
> Isn't that basically the same as:
> "Switch to the generic implementations, which are identical."
> ;-)

I am being _exceedingly_, possibly outrageously pedantic here :>)

>
> > > I can touch it up though, if you insist.
> >
> > Yeah, I'm being pedantic here it's not vital to have this change :) but be nice
> > if you could, I'm sure Helge probably wouldn't mind too much? :)
>
> Yes, I'm fine with any cleanup/rephrasing of the commit message.

Thanks :)

> Thanks!
> Helge
>
> > > > (Being pedantic, they're not quite strictly identical as the
> > > > ptep_test_and_clear_young() generic function does some weird unnecessary
> > > > indirection with a local variable and the single {} is dropped etc.)

--
Cheers, Lorenzo
