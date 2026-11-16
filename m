Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840117;
	b=D+AqMbuSDM2/58JjJmfq8wpUHc2VXn+3yvglAeC6EJUTNu+QlheiGJGjDNzkiK/XKDmv
	 R9GNJOOvF+rKyC5Mx9UNeAZexBzKCkXLONIK/6/deKohdRESPEsR03Kdb463OutyChULy
	 S6MLtPSyLUAUkzu82ZOMH8BA8RJNN2xZlVxcrOjC8oXLZktp3vLN1zA3tB+cEPB1yzPQW
	 IvelvFVbSAInANgzE4G5TBQhU2zG9eXKXO3nYJ/iEZvKd46r6jWx2oVMkTZY/BRj/ldyQ
	 5kOGGGGaPbRvu76opIiU5Zz4NRC75gwRnBCRmOwnb6FV5p2RVU302q58/ihOMCzUpUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840117;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=d2rB/nwDdGI8ixOlr0EOUE2EFObaBqdL/DrhKi+letk=;
	b=LllKCkzhZwf/D0hmHSzwx9iQxrXgpjoFGDZFAtIItHczATZvCBf+KcVWdttD7hwDwRQ1
	 MNhUkTflVIermMAG/qyXNnzWCZXRMGa6DwUR8D47yk17JqIzw9FOqlnRZmcCIGpJkz2rz
	 nWZXX2b6XBwICmqnHcBefXVWaamXGk9f0ZP8/UJYkjflpeWsaddbKQovI7Pc/B0L2AYSZ
	 Kver/rrd+suhQC73Ly7Yl2qONZOs2NkPWd4QGt/eZnG3JQS008HhzVuJmY7folEvniHhq
	 B4DfCQBStfV/5xjK7sRKOoTqvvOE8UhiO5P7DWactcoLGUdvAf6/QxblFoJ1AM4yHqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJTL9SJk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C8F606A31C;
	Mon, 16 Nov 2026 14:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJTL9SJk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CBD1F000C4;
	Mon, 16 Nov 2026 14:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794840117;
	bh=d2rB/nwDdGI8ixOlr0EOUE2EFObaBqdL/DrhKi+letk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XJTL9SJk+Cy08wdednhz6VQ6SSMcVaNLKQlMBd67ucoGoTl40lG4v55tbaFyENQVL
	 IP5IlAucXgH1SN08irBinexfvsJNx8ulpjPdGehXaNGAUDw3rRgTfy2lQ/blIeTUmv
	 nw7td/3MFFkpqEV9Zq7s6xMTyWiy6BaBDSMs8/I6nZ2Tk/XF5q6BjKpMEeI+6zjRXg
	 2ye3z7v4ATUn2RU9QoMSWaGiJWdNcR8h0jGtKhHwc2OpI0wsMnE3Y7Xk8NeMl7aOqn
	 Uvf/Tt+q/62nl1bK8/w95YiTDDq0AVWsV7PL/SyiS7OOA502VghnC9aqOOgcx4oJUD
	 z8HweZmET6MLw==
Date: Mon, 16 Nov 2026 14:41:45 +0000
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
Subject: Re: [PATCH 04/12] mm/migrate: keep the uffd bit when restoring a
 writable migration entry
Message-ID: <avsV68cP0rp5mWSf@gremlin>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-4-00713d368976@columbia.edu>
 <avYG7CtQ52v3I8tF@gremlin>
 <f28dc841-f664-4f97-9dd7-bffd2825115e@columbia.edu>
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
In-Reply-To: <f28dc841-f664-4f97-9dd7-bffd2825115e@columbia.edu>

On Fri, Nov 13, 2026 at 04:59:39PM -0500, Tal Zussman wrote:
> On 11/12/26 1:44 PM, Lorenzo Stoakes (ARM) wrote:
> > On Wed, Nov 11, 2026 at 12:55:12PM -0500, Tal Zussman wrote:
> >> remove_migration_pte() makes the restored PTE writable for a writable
> >> migration entry, and only looks at the uffd bit of the entry otherwise.
> >> A writable migration entry that has the uffd bit set is therefore
> >> restored as a writable PTE without the uffd bit, and the page is no
> >> longer write-protected.
> >
> > The UFFD WP bit is such a terrible, invasive, broken piece
> > of... engineering :)
> >
> > Notice, again, the hallmark of an utterly broken abstraction - every user
> > just has to happen to know to handle each of your weird edge cases every
> > single time they happen to interact with anything that touches it.
> >
> > I do hope we never merge something as bad as this again.
> >
> >>
> >> An entry with the uffd bit set must be restored write-protected, whether
> >> the entry is writable or not. remove_migration_pmd() gets this right: it
> >
> > Sigh :)
> >
> >> makes the PMD writable and sets the uffd bit as two independent steps,
> >> and pmd_mkuffd() write-protects the result. To fix it, do the same at
> >> the PTE level, where pte_mkuffd() write-protects the PTE as well.
> >>
> >> The only known path that created such entries is PAGEMAP_SCAN. Now that
> >
> > Wait what? :)
> >
> > How does a read-only scan of entries create softleaf entries?
> >
> > I think this should be explained in the commit message :)
> >
>
> Will add a sentence... unfortunately not a read-only scan...

Thanks! Yeah I realised later the true horrors of what PAGEMAP_SCAN can do
with uffd flags (ugh).

>
> >> PAGEMAP_SCAN downgrades them like change_protection() does, we should no
> >> longer see them, so this change alone should not be visible to
> >> userspace. If another path ever creates a writable migration entry with
> >> the uffd bit set, the page now stays write-protected instead of losing
> >> the uffd bit.
> >>
> >> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> >
> > This seems like a super-weird fixes target.
> >
>
> So this piece of code was added in f45ec5ff16a7, but the issue derives
> from PAGEMAP_SCAN, which is the commit above. I think 52526ca7fdb9 is
> the right target, but can change it.
>
> > BTW I've noticed you've not been cc'ing stable, is that on purpose? No
> > autosel in mm so we do need to do that on stuff intended to get backported.
> > :)
> >
>
> I added stable for patches 1 and 2, but for this one and the previous patch
> the impact is PAGEMAP_SCAN reporting a page as written when it wasn't, which
> over-reports but doesn't lose anything, so I left it off. Maybe I'm being
> too conservative though.

No that's fine, if it's sensible not to then let's not.

Was just checking to make sure it was intentional ;)

>
> >> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> >
> > The change itself seems reasonable, as cursed as the reason for it is, so
> > with the fixes target confirmed + commit message updated:
> >
> > Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> >
> >> ---
> >>  mm/migrate.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/mm/migrate.c b/mm/migrate.c
> >> index 28a8d7734735..d200f64b5f98 100644
> >> --- a/mm/migrate.c
> >> +++ b/mm/migrate.c
> >> @@ -399,7 +399,7 @@ static bool remove_migration_pte(struct folio *folio,
> >>
> >>  		if (softleaf_is_migration_write(entry))
> >>  			pte = pte_mkwrite(pte, vma);
> >> -		else if (pte_swp_uffd(old_pte))
> >> +		if (pte_swp_uffd(old_pte))
> >>  			pte = pte_mkuffd(pte);
> >>
> >>  		/* See do_swap_page(): restore PAGE_NONE for RWP */
> >>
> >> --
> >> 2.39.5
> >>
> >
> > --
> > Cheers, Lorenzo
> >
>

--
Cheers, Lorenzo
