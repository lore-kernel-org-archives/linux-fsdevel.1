Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509070;
	b=YwrFkcBxBc8kT3IaxsiK7QirzYuA3ZNlaKizS4vXRF2s3YXGuJwvaV6OU12JhSLfi0OQ
	 Bv/RRXtu8BlQzB8io5PvWwJrq3y1LSXBMP25wNv2zQHh2zk8u9h/I8k39Ibge53vshges
	 9xTaYY8xW9ikAtlxg4H920p+yPTSAhyrMYDEc9nxF0BTk21ChrH1bT0FXWB7/Iyj8ID5/
	 B1oqz1F+ButMnqC6Yz8eLQJYJY41+pDxK2iXJM7X9VtE3AKuk95bMpNvnlpRaxcmZFIqT
	 5fI6z0OtgiEkzGgQKhG2aEsQjVOlVVlCI37sjIVqqZpvQ0hHTb8UqDUolY6DI/AKxlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509070;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RVyxm9yaGZWP8LbX6unRU3C9T3kyos1eNHeAHWcUH10=;
	b=Kuz4LicAkiziVX0a/6Y1AhEcojy6HFVeMIKTMveZcd18AR/TSjle8B9LLvTUZXGzxkQQ
	 ho6HAm3HXh/3lLXYROKv4qRuEGuBZUUyZbLfABJcf2EulUOa9AySVgwxxiQSjl1gvcX0T
	 IqbbcK4CjGtBruKkEkkhEYkX+rpzs8RqBKY04NqbQ5pjvzIqm6TDyxDObF3I4X0t8+tZP
	 QSwnjGxe+OEQDXQgDqu5O3cYPa8UCb1TlzUCKJVJxxPfH7TeGPduE3pNHWmZ8gYIYjIBo
	 UHT9b5ySu11JQrMWot3DrPOpEzDhdTGK2NgOGuiyPppHvLmJbSQbvTuZEttddj3rUkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IfekWsu3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83BB606A31C;
	Thu, 12 Nov 2026 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IfekWsu3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290661F000C4;
	Thu, 12 Nov 2026 18:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794509070;
	bh=RVyxm9yaGZWP8LbX6unRU3C9T3kyos1eNHeAHWcUH10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IfekWsu39i1JQlysaLelamEDce3mX/T7a+MM6jLQ23+ntbG4nbY0G5S/Lv4HVkhb8
	 hANWWpY4XTjPFEj3opi/JbeRPS5SEAFmg8zTDptkYUJq7aeaOULxWSvaTxhnsRlm90
	 CMO4SkFhguxwYJTQvhELQzwZHqcDrOpHeBHrkfNaeNu2KlfTNfW5VbPkUPn9tovxzp
	 it55e/HuR5X/w88jMgBdYZjxKr2A16hdeczwJeF+FGxBsmewlBwKwhwpP8JzCTzWuo
	 MVVy99BtjxSiUbQyAdl0bEID+QtaMXFY55LZHLd30/BnwjGy+QubFLS5yOIjpH7RI7
	 eHg0AiNXWaZUg==
Date: Thu, 12 Nov 2026 18:44:18 +0000
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
Message-ID: <avYG7CtQ52v3I8tF@gremlin>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-4-00713d368976@columbia.edu>
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
In-Reply-To: <20261111-uffd-state-fixes-v1-4-00713d368976@columbia.edu>

On Wed, Nov 11, 2026 at 12:55:12PM -0500, Tal Zussman wrote:
> remove_migration_pte() makes the restored PTE writable for a writable
> migration entry, and only looks at the uffd bit of the entry otherwise.
> A writable migration entry that has the uffd bit set is therefore
> restored as a writable PTE without the uffd bit, and the page is no
> longer write-protected.

The UFFD WP bit is such a terrible, invasive, broken piece
of... engineering :)

Notice, again, the hallmark of an utterly broken abstraction - every user
just has to happen to know to handle each of your weird edge cases every
single time they happen to interact with anything that touches it.

I do hope we never merge something as bad as this again.

>
> An entry with the uffd bit set must be restored write-protected, whether
> the entry is writable or not. remove_migration_pmd() gets this right: it

Sigh :)

> makes the PMD writable and sets the uffd bit as two independent steps,
> and pmd_mkuffd() write-protects the result. To fix it, do the same at
> the PTE level, where pte_mkuffd() write-protects the PTE as well.
>
> The only known path that created such entries is PAGEMAP_SCAN. Now that

Wait what? :)

How does a read-only scan of entries create softleaf entries?

I think this should be explained in the commit message :)

> PAGEMAP_SCAN downgrades them like change_protection() does, we should no
> longer see them, so this change alone should not be visible to
> userspace. If another path ever creates a writable migration entry with
> the uffd bit set, the page now stays write-protected instead of losing
> the uffd bit.
>
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")

This seems like a super-weird fixes target.

BTW I've noticed you've not been cc'ing stable, is that on purpose? No
autosel in mm so we do need to do that on stuff intended to get backported.
:)

> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

The change itself seems reasonable, as cursed as the reason for it is, so
with the fixes target confirmed + commit message updated:

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 28a8d7734735..d200f64b5f98 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -399,7 +399,7 @@ static bool remove_migration_pte(struct folio *folio,
>
>  		if (softleaf_is_migration_write(entry))
>  			pte = pte_mkwrite(pte, vma);
> -		else if (pte_swp_uffd(old_pte))
> +		if (pte_swp_uffd(old_pte))
>  			pte = pte_mkuffd(pte);
>
>  		/* See do_swap_page(): restore PAGE_NONE for RWP */
>
> --
> 2.39.5
>

--
Cheers, Lorenzo
