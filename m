Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013546;
	b=BiMZMoSj/BzcH7aIRciOhvT1dYf8fXFd2hqDGRLesjHqO4vX7lVmgpysKE36piAQKJBu
	 +yyM6D8oWxhsvOfRgmoecfwzYcr5tek1hOalTn5svXZhTqsZpbgkA4U4+hfVAACTGC+Iq
	 ChG0tcG3st3DEAgeFzVqVTpxu690XcRd72/pHi2MOaeD/UXDjTbupZliIYGLoCPQOr24u
	 RSAQU0sD6D1nOTt4ZNeYopMxT2KHriWSg3wFl5fHJnVOKlfiIhTMeulntJGvC6N68GjM6
	 Gy1Z402PhQcI8eAj/u8LFL9nCrpu3HcCHH0pFhH/3bYzW1GOcnhw/Tt64pCcYbhCa+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013546;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=u4fw6wH7cRG89Xgv9DmNPTYzRhO7v7keamB5liM55x0=;
	b=fQgBUoegVnBxTT7PUkcvTP4yKU37CnaONROlG4bu1RK/oy3IEeBCwZtds0xtZ3wVQY71
	 EYMp+L3Hsai0AnxVR4CGheQTmaY5CHSUq6HsU0VkvI/GCMCI7REf+bxtgV/+D0uw4fu4v
	 9AfGjW+x+RCYKmaJP2JpIEZzj0a8Z+7pHjdVaOXogVrkcAjOiLE/1VdQaUJc2IwfPcYsA
	 fwEqA/9iV1tHtpnB2OPYR3NJcjItCKR+1M3LY6KYhuLQYfsk5I1FWe47gDZ3Imzct0z1F
	 lzjyrSbsPGEaY+HWZdNT/8fw2ZcNNd/7U5P4ajrUjnwsIrp+NaI9BDGcH6K7G3NmvIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmMB1JqZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BED606A33B;
	Wed, 18 Nov 2026 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dmMB1JqZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35461F000C4;
	Wed, 18 Nov 2026 14:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013546;
	bh=u4fw6wH7cRG89Xgv9DmNPTYzRhO7v7keamB5liM55x0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dmMB1JqZH1zCDAONsrZJ5AXpbtBhioXa5f2XoqUI4Tl4ece9yzguQMNNy7LcKcbU/
	 SFXKxhz60iY7aZB/cKWhVkx2kI3mvr9wpdq5vhKxwcGSYKWzyPIkU95mFq6dr4X2C5
	 8tVA+8eO+zY1sJU/8a3biSSof6aItdm5RnJ++Q3LbsjRB+MXCn4VBH0ycBgldRitLK
	 TGKrEbeTSrAOAqVWJtDMKtfqbC7gQt794hyCBK6KLy4pjGdTSqKxfTn6assRS7ijQh
	 IeipmuUfsmYzdar26x9qGw0mPzJfuqLKDdQ7mu2oIcFU5WCAbmwqAccEBhhK5qzqky
	 CIG+yJLR4jpPQ==
Date: Wed, 18 Nov 2026 16:52:10 +0200
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
	linux-fsdevel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v3 8/9] mm/migrate_device: do not migrate a
 uffd-protected zero page
Message-ID: <av27miMZrEyB5egZ@kernel.org>
References: <20261117-uffd-state-fixes-v3-0-b617009d1a4a@columbia.edu>
 <20261117-uffd-state-fixes-v3-8-b617009d1a4a@columbia.edu>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261117-uffd-state-fixes-v3-8-b617009d1a4a@columbia.edu>

On Tue, Nov 17, 2026 at 11:28:48PM -0500, Tal Zussman wrote:
> Device migration replaces a PTE that maps the zero page with a new PTE
> that is built only from the VMA flags, so its userfaultfd WP or RWP
> protection is lost. The same applies to the huge zero PMD. Writes and
> accesses to the page are then no longer reported to userfaultfd.
> 
> To fix it, do not migrate a uffd-protected zero page. Skip it during
> collection, and check again under the page table lock before inserting,
> as another thread can protect the page after it was collected.
> 
> The alternative would be to carry the uffd state over to the new entry,
> but a uffd-protected zero page in a range that a driver migrates should
> be rare.
> 
> While at it, read the PMD once with pmdp_get() in
> migrate_vma_collect_huge_pmd().
> 
> Fixes: 292924b26024 ("userfaultfd: wp: apply _PAGE_UFFD_WP bit")
> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: intel-xe@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Cc: amd-gfx@lists.freedesktop.org
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/userfaultfd_k.h | 24 ++++++++++++++++++++++++
>  mm/migrate_device.c           | 34 ++++++++++++++++++++++++++--------
>  2 files changed, 50 insertions(+), 8 deletions(-)

-- 
Sincerely yours,
Mike.
