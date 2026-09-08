Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D10E3F5BD6;
	Tue,  8 Sep 2026 08:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857199; cv=none; b=sr92hcfOB2rRdk05sYHaP6NytDzzqwLWAHHvJp9ngJ56LcaCuF/LSiEbZ0sh7Lv6+ynTto7EjSQKIm3HLqypBOuCV1+kmfOEMsImBl3B9hMFzH4Pi1ROu8W0gQlsBmK3upbdbqptFjYsHFgntqW0j1Yarprii4MzbQBhbbyvICU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857199; c=relaxed/simple;
	bh=g6pzjrfdtvDH5v6W1HOkv6l/ndJmKaxF6TDrQNpBWHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otgnj7s/dPgRcyT+StiSYBk3DQatioKWKiCyPOHlRyZmzJzkgNgkWTEGfyLJoinr1beS8HTySMepLEA1ldn9c0EaeuLDTb/dcAe7F3sMRt3sCWrS031zWgEc4EvC69LaPGzkWRj8tH1OLA/f+zZWIO+crj7Sko+O8shtEP413Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFVEN8Jg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFVEN8Jg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865B01F00A3A;
	Tue,  8 Sep 2026 08:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857197;
	bh=pi6DH3h9BVaC49RRQjlI0O6aYCIlCAFAZNGWG1WvFkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PFVEN8JgyzdpOjdG910dp2qyUJAFTPtXr0iNqWNr5MagH+H0QrDfVOBmEq6qipxbZ
	 ++krRlOTWT+r0W+aWIpso/p7i548JDpWtUPeoJ33EH1oE/mskhWZ/+AqLSPidspNYi
	 Dkv//LMEhgIc1fNBR0aGJJlJPMvUIAZR5n69gc2lMfZBqn8PFIqfVk0MjJvjjM2kwP
	 tHcZLmXVCGfVFqK07+qnTf1iKO93NehQ/JPShF2pvFi+2TDN4voi2YR/aZhtQVRz6F
	 FRfIzr2sG6JwXZHfdvK6GP+pqy0lc6TPJtcNCiQI143SWohY2E+jlZWsZWNmiOZXvr
	 l1DDLcjvqttJA==
Date: Tue, 8 Sep 2026 09:46:30 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/6] mm/vma: only permit MAP_PRIVATE /dev/zero to be
 mapped anonymous
Message-ID: <ap_LD6lE6JTYouGr@gremlin>
References: <20260902-map-private-dev-zero-v1-0-a578c730cec7@kernel.org>
 <20260902-map-private-dev-zero-v1-3-a578c730cec7@kernel.org>
 <d6dc52e3-b27d-4663-848c-a2f270fb4c5d@kernel.org>
 <ap71GOPAeKHfHp5J@gremlin>
 <8f797f01-e958-404e-bcdf-283da960e95c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f797f01-e958-404e-bcdf-283da960e95c@kernel.org>

On Mon, Sep 07, 2026 at 09:54:04PM +0200, David Hildenbrand (Arm) wrote:
> Yes, but my point is that the comment
>
> "cannot mark themselves anonymous"
>
> will not really be correct after the next patch, no?

Ah ok ack I get your point. I will update this comment in the next patch.

> >>>  		set_vma_user_defined_fields(vma, &map);
> >>
> >> Ah, we have mmap_zero_prepare() for handling the shmem_zero_setup_desc(). I was
> >> just about to ask whether we can just get rid of this here.
> >>
> >>
> >> But, hold on, do we now even need that? Could core-mm now take care of that as
> >> well, and we could just remove mmap_zero_prepare() entirely?
> >>
> >> That is, we'd make shmem_zero_setup() in __mmap_new_vma() take care of this?
> >> Then we might not even need shmem_zero_setup_desc() anymore.
> >>
> >> Maybe harder than it sounds at first.
> >
> > I think I'd rather that be a follow up :) this series is about eliminiating the
> > one last (I hope?) corner case for anon VMAs.
> Right; having to deal with anonymous mappings that have mmap_prepare is rather
> suboptimal. Ideally we'd just handle the odd dev-zero special-casing early in
> the mmap path also for MAP_SHARED, and avoid messing with mmap_prepare entirely.
>
> So agreed that this can be done separately.

Yeah, really life will be easier once the mmap path is gone in general :)

>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
