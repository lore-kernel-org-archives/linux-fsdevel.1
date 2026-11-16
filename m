Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840633;
	b=l/8s0/J5A4WW54jEK/TUg8UtKGbeactSZDE5gQe8aqElwLjF7XWf1/JfkroUvd8znrdS
	 FxvS3DaaAQBNNltXcX3PUIhklcDjqufL577AvY9SPK4UacB+Uteg7vL/wkM+whXgOU35g
	 cSONlwbzpQF7aD0rQOb0ZX3btQ0qdKMVMggunVOnXNNBAlClJNOWcFXUukemBqkqnlLiM
	 CxPYyY7Iy9Q8K0+IEhn10MSfz4xcXcev2BX32SOHKri0m4aEHbHpEZ9xgTHiYE+TS7Hkv
	 iGLNTGBB6gQHfGGkojwhXQ2Yjx5osaYdr+8GuKK1MpEjHEKmgrWqh1BGYitlIMdLxMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840633;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nESxvsGwuM07nY0gJtiknNvC5SRahIhddedMqxw1kZQ=;
	b=1xsNz9u5SQ3UM/RkGpBQM/9pQR1FE9R3Bf6+EksEFkNPSGVEqioEzem+mb5puph6MIyV
	 t+gn6DT8CRCM3KwyJsErXSFlZ83+SGtjfj7vT6JrlDC/5UusbfDLmbSDoLFsoCXkiwdYQ
	 +dH075CkS/S0vJiMnlrybvZ8g1sKM6b0UpcT3cFqdlnrYQ3DU9EzEqu/asRJWnJN/sDTd
	 oJtoY9IGnPL8I3WHEgJ2BOfaJ5pEJikT9VsoFv82Ucp4wgZMvvMEjSBolsGeVu0r2kJpr
	 WU7pGbK/CUJinY/2aPUcCNe9xVOCNf0WelvU4NFOUn2wZNllsDRBEjODsJGfMlhlPPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVmSrkjP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5E3606A335;
	Mon, 16 Nov 2026 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVmSrkjP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11BB1F000C4;
	Mon, 16 Nov 2026 14:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794840632;
	bh=nESxvsGwuM07nY0gJtiknNvC5SRahIhddedMqxw1kZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XVmSrkjP+tZBIejf9BoWO0O44niMRaaaCPoGxtSO0r2kmzA2fVeJRTvbLkshCygzd
	 0LIoDCdA8bRIfQQ2UpcgH7yZxn63vEBJQ6JemMLQrrn2e8qNRHVPlTQXBEziTjvg+o
	 MQzn7PWO6NecUrvhDHeL6823sm8FvzbCQIodtHxBaWmax8EaKlv4edUttHyP5U8ore
	 fsLtU+pS2tbAcvcup1BYpQtYOUEfdovQLbIcWmRCaLE5c233SmWj/5qsU3FQPAueKI
	 hSGoV9Rf5AXtGXjWcg93yexuIIZZslnQZoc1gx3b5Ty9aFvUS2ZAxg0Z1cad+j5BA3
	 QqiBPywTCnvGA==
Date: Mon, 16 Nov 2026 14:50:21 +0000
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
Subject: Re: [PATCH 05/12] fs/proc/task_mmu: write-protect device-private
 THPs in PAGEMAP_SCAN
Message-ID: <avsXRXKh5Lj967FH@gremlin>
References: <20261111-uffd-state-fixes-v1-0-00713d368976@columbia.edu>
 <20261111-uffd-state-fixes-v1-5-00713d368976@columbia.edu>
 <avYQteUm963AKJQ7@gremlin>
 <e4b60f0b-ccb4-4a7e-83e0-81fa1fd0c88d@columbia.edu>
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
In-Reply-To: <e4b60f0b-ccb4-4a7e-83e0-81fa1fd0c88d@columbia.edu>

On Fri, Nov 13, 2026 at 05:16:32PM -0500, Tal Zussman wrote:
> On 11/12/26 2:34 PM, Lorenzo Stoakes (ARM) wrote:
> > On Wed, Nov 11, 2026 at 12:55:13PM -0500, Tal Zussman wrote:
> >> PAGEMAP_SCAN with PM_SCAN_WP_MATCHING write-protects a huge PMD through
> >> make_uffd_wp_pmd(), which handles a present THP and a migration entry
> >
> > It's crazy to me that we write-protect page tables through a procfs interface
> > like this. But I guess we have to live with it now.
> >
> > I suppose that answers my q about this on a previous commit...
> >
> >> but does nothing for a device-private THP. The PMD never gets the uffd
> >> bit.
> >
> > Sigh yeah. Device-private feels like another 'just have to happen to know to
> > update X million open-coded parts of the code'.
> >
> > We really need to find a way to abstract this stuff.
> >
> >>
> >> pagemap_thp_category() reports a non-present PMD without the uffd bit as
> >> written. A user tracking writes with async uffd-wp therefore sees every
> >> page of a device-private THP as written on every scan, whether it was
> >> written to or not. This requires a driver that migrates THPs to device
> >> memory.
> >>
> >> A device-private PMD must be write-protected like any other huge PMD. To
> >> fix it, pass it to set_uffd_wp_swp_pmd() as well, which downgrades a
> >> writable entry and sets the uffd bit. When the THP migrates back,
> >> set_pmd_migration_entry() carries the uffd bit over to the migration
> >> entry, so the write protection is kept.
> >>
> >> Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
> >> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> >> ---
> >>  fs/proc/task_mmu.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> >> index 53780a454432..752f1b13d47a 100644
> >> --- a/fs/proc/task_mmu.c
> >> +++ b/fs/proc/task_mmu.c
> >> @@ -2524,7 +2524,8 @@ static void make_uffd_wp_pmd(struct vm_area_struct *vma,
> >>  		old = pmdp_invalidate_ad(vma, addr, pmdp);
> >>  		pmd = pmd_mkuffd(old);
> >>  		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
> >> -	} else if (pmd_is_migration_entry(pmd)) {
> >> +	} else if (pmd_is_migration_entry(pmd) ||
> >> +		   pmd_is_device_private_entry(pmd)) {
> >
> > Could this not just be !pmd_none() + cover all softleaf entries? Or is that not
> > valid?
> >
> > It seems completely insane to have to specifically spell out all the
> > possibilities, open-coded, everywhere.
> >
>
> So we actually have a helper for exactly this that I didn't notice before...
> pmd_is_valid_softleaf() is equivalent. !pmd_none() should work but I think
> the existing helper is better.

Hmm yeah that could work actually!

>
> >>  		pmd = set_uffd_wp_swp_pmd(pmd);
> >>  		set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
> >>  	}
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
