Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840373;
	b=IT5QjnIiV1Tzsya7ZxiHGS+n51qwquCrR6m3DeWZU8PlqZ6lAhOWwcREjhbCIrlHNvHs
	 V6MHCYrCRWvMrxqPggj9cknLPkp8mjy+BBqUKJndfvSNDzUQE7PDjKxCRj4EO1wOhFZvL
	 hzDGb3oIxRaUZza7E9hGG9jWYLTAJLlCOBN3AUM2PTMVIpArQz5opK/BsoIpBGem2Mwzr
	 nkF/6KZi5ofn8zCFme23xXlx/3wYPylSVUG2mM9cCS6hBvIEhNPqxd+tTgbrEGHgSL7im
	 Pt30keJxaEk7dUcrI7TNi8Ch+0J3q1inJoNy0AASc2pDzgIA/lQviNac65CBuJZCl6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840373;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=A1TKepG6bSQCmMoOOE2pLJEk7bMmD610l+iZ3D8b1os=;
	b=4NVucMbwblCNRzgYsWxI5aAKUxh8Q8AzP03ufXQmDTcuN22YQhf3NgVKpn35BhQAUt4Y
	 tWDW+QftVokjh1cpdfsZ5zI5EuGPKefuXUR5vcsGsZhWm923Dh0+QnBECx9ddxnKJ1d2i
	 jDZHL4kE/34CRE07wfOiQSsXB2sVJaNWD6/7cfi+dfqO8c+Gv2fAYrmoB7GBdy1UfdmfM
	 o0peK4iBH84Qd6krA2IUPAxC/4pNpa4f/d+D4XWAVzuz16LlR1ivu+Zxi4pdln3AutpVO
	 OVvdX6JtWAdSR9EuX7pmbi1O/x1pq91X9M4Aw99KlWQ9og6kru5Pf8L3DrcG5MfLwfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSUWMCON;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDAF606A33D;
	Mon, 16 Nov 2026 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSUWMCON
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E20D1F000C5;
	Mon, 16 Nov 2026 14:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794840373;
	bh=A1TKepG6bSQCmMoOOE2pLJEk7bMmD610l+iZ3D8b1os=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NSUWMCONHW5TZYpCllA7NK6vndBpf9VhuU9DXiPMvvKEKZDyX90k8J/VWsGhxpo1c
	 K70AexWVc8uj7NQ+SNrbPocqq2lly3wP11icpBnvvFx7TMeAjkA2cLbvy0xYA9c8Zw
	 9PS+KEd1Li/3izSHVgf2JrXIqXGMzeK4A2BoxW6Hi2e550tHx6kJINM8SMygsFgb0Z
	 nUEMfW6TS/2TGexBtvIDgE/1eZaAxjxEsctZyXS4ndAwO6HSGxEWXyKg4cjvZfic2M
	 hHHmAD65quU/1XuCZjeqov1gxvH/ryB3oPHL91tpwuS+KzVBrb7eWRlhynZd7XKqSg
	 fwdCwywl48bkw==
Date: Mon, 16 Nov 2026 14:46:01 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: Tal Zussman <tz2294@columbia.edu>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Andrei Vagin <avagin@gmail.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Muhammad Usama Anjum <usama.anjum@arm.com>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
	Chris Down <chris@chrisdown.name>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, =?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/12] fs/proc/task_mmu: write-protect device-private
 THPs in PAGEMAP_SCAN
Message-ID: <avsWjwI6Vp3-J8F_@gremlin>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-5-00713d368976@columbia.edu>
 <avYQteUm963AKJQ7@gremlin>
 <179454650651.482102.17667443707760097412.b4-reply@b4>
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
In-Reply-To: <179454650651.482102.17667443707760097412.b4-reply@b4>

On Fri, Nov 13, 2026 at 12:08:26AM -0500, Gregory Price (Meta) wrote:
> On 2026-11-12 19:34 +0000, Lorenzo Stoakes (ARM) wrote:
> > On Wed, Nov 11, 2026 at 12:55:13PM -0500, Tal Zussman wrote:
> > > but does nothing for a device-private THP. The PMD never gets the uffd
> > > bit.
> >
> > Sigh yeah. Device-private feels like another 'just have to happen to know to
> > update X million open-coded parts of the code'.
> >
> > We really need to find a way to abstract this stuff.
> >
>
> I've poked at it a bit, but zone device creates this issue in many
> places. The core issue is really that softleaf can mean 20 things,
> and the number of things has been piled on heavily.
>
> I don't know how we solve this, it's just a rats nest of complexity
> at this point.

And you are our Jack Russell? ;)

TBH we need some generic handlers for softleaf cases. The fact it's
abstracted in a form that we can describe clearly it might be possible to
pull useful things out of that.

Like:

	softleaf_can_xxx()
	softleaf_should_yyy()

etc.

Ideally we'd have entirely shared page table code but that seems like a far
off goal esp. in the face of the schloppgeddon.

But in the meantime maybe we can use semantic helpers to at least
generalise the glue between softleaf X requires handling Y?

>
> --
> ~Gregory
>

--
Cheers, Lorenzo
