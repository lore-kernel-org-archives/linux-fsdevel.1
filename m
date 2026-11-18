Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795012648;
	b=lwxEdbEbuExBrpAc9oBL4O/i7DQJrDCZV9Go0y9RlafJbYC3RA9eNQywhJnGd5r56QQ9
	 MmVkdSOiX9Fx06kXdF0eP0KjBl8KN8Fc5UUqBz6pbvSqPWxvtpKZsnJiWBQD8spZiNVT3
	 cs27pi6538DLw/4D7ByQop5aTUoLcIjkpMLfSVDFTud9Tbeh04fzdrTtWubacxzqAsY14
	 cul84spgcHpo2HuWJtRI5Q8uu83Nq+OXEBBrCEZyIweq8wKFMGKKtEWEAb5mgZFsYdITZ
	 3y2ljDEFrO16ffAstCwS3kXvlkiYXTgrU1zurH235gF8d7qVDs/QDkW/7XJpQSBLVAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795012648;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hfq1+ahcbxyZo7gBB7LdlV/ONz7fUZdNHYr+ADwNbZA=;
	b=esrJK+IrTR3kqmvEFOBh4xhU1mATAcjgt4rMSrzxt7Tzpl2ByfX87z3rQYO816sidrho
	 Ul7SAiTqGKbv1KWsf1XXGvB3QEK5KmZYxCyrJamQ3b93JIVpepGMLfO0Z6ve7BHz24SUm
	 JtfKYdbeQJCO7jPvEROixikR3C0FgMpYsSRTZQ8T6D49BKel/tvuTu/jaaHG/7kKNB68F
	 J2ikdQzh9FpmXrgwWyNUiY2iO8Atmgtl2i2gKyOSyGvupB9wOvqEm6JfPELEg2fhY01AZ
	 0AEO1rPvexYUtgPXFWku3dQL1tOle142ZBvDKPDxLk08t3JNwXtL/SClgRRwO9Cz4wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GUbAtBQj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A7F606A32C;
	Wed, 18 Nov 2026 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GUbAtBQj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6BE1F000C4;
	Wed, 18 Nov 2026 14:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795012647;
	bh=hfq1+ahcbxyZo7gBB7LdlV/ONz7fUZdNHYr+ADwNbZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GUbAtBQjbUK7eKEZptuCukI88BYQ6a2zlpxE8dOVumCTZcFxTXDYvE8WqxvMAxlF5
	 kMD5yj3pvpdnpQ7FehKmw/lGCsXkT1vwpoq3WcL1z+XXWPq0iHcvo1ilFwMg77g0v0
	 mAcn8uYSgZcHds62mbCV/INwzR8XxrMpygqEUqzMTMjKcmr2gNLoEbROzQ8izHHkSU
	 oowwOEXgkWcktcuAqazPIX0GhD61EiI6HuF2kjgVKNpx5N4JXDEnZfsnqS0F07vN23
	 2UppeXCANLXKYLWswD9+GPSMGav81pPL1bYroFnKETvyHZKRvQ66P5nlTqmGmPXxNJ
	 R7LaGUWyE4PDw==
Date: Wed, 18 Nov 2026 16:37:13 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	James Houghton <jthoughton@google.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Balbir Singh <balbirs@nvidia.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Andrei Vagin <avagin@gmail.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	=?utf-8?Q?Miko=C5=82aj?= Lenczewski <miko.lenczewski@arm.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 4/9] mm/migrate: warn on a writable migration entry
 with the uffd bit set
Message-ID: <av24Gep_wmm8fib7@kernel.org>
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
 <20261117-uffd-state-fixes-v3-4-b617009d1a4a@columbia.edu>
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
In-Reply-To: <20261117-uffd-state-fixes-v3-4-b617009d1a4a@columbia.edu>

On Tue, Nov 17, 2026 at 11:28:44PM -0500, Tal Zussman wrote:
> A writable migration entry must not have the uffd bit set. Every path
> that sets the bit on a migration entry makes the entry read-only first.
> PAGEMAP_SCAN was the one path that did not, and it now does as well.
> 
> remove_migration_pte() restores such an entry writable and drops the
> uffd bit, while remove_migration_pmd() sets the bit and write-protects
> the PMD.
> 
> Warn in both paths on a writable entry with the uffd bit set. Also make
> the PMD path only set the uffd bit for a read-only entry, like the PTE
> path, so that the two behave the same, as this should never happen.
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/huge_memory.c | 7 +++++--
>  mm/migrate.c     | 7 +++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)

-- 
Sincerely yours,
Mike.
