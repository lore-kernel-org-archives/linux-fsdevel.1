Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481610;
	b=k+y0U94yDwqFtTN5NtdYB8heHqzeY13oyHdKyY/cXpnzQ/5NfOS0BIgCGFKSVnhab40H
	 6u+YdSs9L/1bCL2pvi9LzYq7e5iM0hgJFRKnDKpBU0ht6RDxFODI3feQHcgljk+cUNKlN
	 if1AAVKaYETSUReRJ3gK0e98z+/Zt+pku+eKWiZAVJaEN9rdFYHaAd9/OGqRvnuL9AtLG
	 1sPZWh/fWURxJnpruHGBASAxm+GzrLrHfL8iu6ENFB5xNVnaIwlkXvwF8kW4ctmBWCnJC
	 uGAAKjWDW9bSnfh5Jm5b5WeSiNBM2LU/gP6A+FThyJJYJhqAedSP1NKCFetV/xYGx/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481610;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vSq1qT4UA/SFFJR/GJu5ROIhm9ZxkHbbkGrHiDg+96o=;
	b=IO5P5OD5xQJZhtFM+ZW01ToFGe3IMRHsnmXSSPOJ+PDlQPU1OKPA3fUdnl6j21Yx5f8V
	 CIZtZ+DXgzGgo30V+hFtNjCzxdrbTg/KUgMi+iiZtCqP6EMLhPkoYpSx/GGzxRWvFlqZh
	 iJ+eUdy3W0W5TmBNvzWn3xR0Y7zUsyKwwNX8IjNsEMfgfKfaX3CH6HngpEpEa1zXyHrFr
	 Bcli+mq7fVzYMuc89u1JMoHzAzeN7gI8wQNR3WeTW7arnC9//8k30i93vsERRlRb2XDJ1
	 tvyHPqkKcE5A8b4pNYe7ZLVfdIe8yOL2fHAJk7y7iGxPlct8gTvu6FFGXOtADoS4OfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CgL6tMTt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CBB606A321;
	Thu, 12 Nov 2026 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CgL6tMTt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007A81F00A05;
	Thu, 12 Nov 2026 11:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794481610;
	bh=vSq1qT4UA/SFFJR/GJu5ROIhm9ZxkHbbkGrHiDg+96o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CgL6tMTtg/S8q8yyQ/zzYtg9kJGnRqNf4TdTF0m8ZeWqRXWL2/Oi+iirLh3VdN7KX
	 /0rI4Xhikgv+80DYB8hHzH+HE7Xd9l/cKADhJoww7yeq2yT0f8VkH7WvzEaS01VtF0
	 0/yy+UxDZIbqt1F516bbUZckJ69oh7MkXOYItH/jk6t+E+yJ3BOZlGS0lSAubIMpYk
	 YpVBtER2Ihm5gyMIDsO72fULol91zd9fILGJjGhutuKzecoleh+Rg2ePnBFDYcI6OQ
	 aDRCDVlVxM9EnkeradPkM0L/mqk6J/1bSht5CcFMsbZPb3GgmQ4bFfavYVN9z5mRQM
	 eixxs/EhIbtRQ==
Date: Thu, 12 Nov 2026 11:06:38 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Mike Rapoport <rppt@kernel.org>, Peter Xu <peterx@redhat.com>, 
	James Houghton <jthoughton@google.com>, Andrea Arcangeli <aarcange@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Balbir Singh <balbirs@nvidia.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Andrei Vagin <avagin@gmail.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Muhammad Usama Anjum <usama.anjum@arm.com>, David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Chris Down <chris@chrisdown.name>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/12] mm/madvise: send UFFD_EVENT_REMOVE when installing
 guard regions
Message-ID: <avWdmdtniATARDTX@gremlin>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-11-00713d368976@columbia.edu>
 <avWW5t1BiD7pbzIZ@gremlin>
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
In-Reply-To: <avWW5t1BiD7pbzIZ@gremlin>

On Thu, Nov 12, 2026 at 11:03:29AM +0000, Lorenzo Stoakes (ARM) wrote:
> > Fixes: 662df3e5c376 ("mm: madvise: implement lightweight guard page mechanism")
> > Closes: https://lore.kernel.org/linux-mm/3f4b0d1b.bbf84.1a1c55cb666.Coremail.18670333770@163.com/
>
> This report was super-synthetic AI slop
>

Oops, let me finish this thought... it was super-synthetic AI slop to the point
that I am not sure it's even worth referencing.

--
Cheers, Lorenzo
