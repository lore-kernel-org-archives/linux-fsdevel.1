Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486186;
	b=sWHpSi2LnwGlADtum/E1C+BJDrRX9iOgqF5msuiKlDcPZtWfqO9MM5vjEOY5aO8w9yJR
	 7Z1JQieMIH1Ya+nM3FbY4jjCyoRMbOXgpYv+WtRhlbJDZGfrKkpn9ObcEggkw7Z0cTXl2
	 19ilR+bT1ituyRY3u2UXsSgJVAIEDyv72Dn8HuhHPz43rICU8AEsrFvF428MVaguto7mN
	 JdZGnkXWNGYs82H/yanZunSfbHx/vVP3yGIw4mBVdfV5paFea1yHuIg3bjMqUXVv2z6gO
	 tvctr/N4mkUi4M4m4Zu2Yq4CKmIJJrbacWr0NE1ovtJmBgciqx7jo5EsGerxqKDLEyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486186;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lWlw4c7qfDg3OW28iHlk8qt/mvenvwkeKIlZQ1FC3mw=;
	b=ro8JeXxczWnk77UIlGa+qhWsMueB95FylGxeeYro3xEuE+jsncwomnneIlP3icdlwup3
	 60jWy+Xo8yRcuYmDAdjxTlQ9QfbUqMucyjmuNrcfRESxRHCDBqrYGTQvYSf4szpqmd2ZS
	 v8pb6fE4OtN+ChhunsXLnps65m21Ap8/erE1PFzTSsDAWYzbhIGaiQV7g2nyG9A3ycqyc
	 qb40Xl0SiDFhxp+cfSKK3CuUzsW6xZCeXqio2lClFp7YHT9YyFXgmA3unL0w/6IaWCOoE
	 Ai/2toPpSDmHp06rhRHowAoB+Q/TEweQ2VNFqH7DI+YyrtjdDSVxs0jJHOEWUWPxIEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xd6pqgjh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642FA606A330;
	Thu, 12 Nov 2026 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xd6pqgjh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 997111F00A05;
	Thu, 12 Nov 2026 12:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794486185;
	bh=lWlw4c7qfDg3OW28iHlk8qt/mvenvwkeKIlZQ1FC3mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Xd6pqgjhgMlhQ6hVKaJF/N4Xr+guaVNesjZMxo7k+RkYUnsVMo6cJ6/c0pqj++MDS
	 pVvLZn6pkeYtDjLQKco9aekFMAmLwm20qtCrLZ9kC/eRWl+eYHt1zRS7k3/RIXJ8kW
	 2AhCyeove+V3rQfwaTpi6OusY4wQ0uEm2t0GBfn5AnKyK6V3npnOBQt51dmbXUr3Iy
	 mtOwE1wCrPpQmzQbToI82zpMgHTTEOc61a7IXFohHd6biYeQQa5PXzx2W95jcw+b00
	 XU2cuBNNUi6df+ytz5N024IKdrObe2Ad0NsLLpypl+ozGtsFGvlk/9Q3jx7s+ozcbD
	 N6OzO+ESTJbQw==
Date: Thu, 12 Nov 2026 12:22:54 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Kairui Song <kasong@tencent.com>, 
	Balbir Singh <balbirs@nvidia.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: Re: [PATCH 03/13] mm: cachestat: restart the walk after each entry
Message-ID: <avWuxs25RmC6PvVZ@gremlin>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-3-3d2454362e8d@kernel.org>
 <9b795d3a-1818-4265-a364-58fba139c651@linux.dev>
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
In-Reply-To: <9b795d3a-1818-4265-a364-58fba139c651@linux.dev>

On Wed, Nov 11, 2026 at 11:38:39PM +0000, Usama Arif wrote:
>
>
> On 11/11/2026 18:13, Lorenzo Stoakes (ARM) wrote:
> > From: Chris Mason <mason@kernel.org>
> >
> > cachestat() can leave cached pages out of its counts. This happens if
> > the entry that the call has just counted is replaced by a larger folio
> > that starts in the same XArray slot.
> >
> > The issue is that filemap_cachestat() walks the page cache under the RCU
> > read lock, so racing concurrent collapse/split is possible.
> >
> > Thus, an entry can be replaced immediately after the walk has returned
> > it. When that happens, the next xas_find() skips the sibling entries that
> > point to the slot of that entry, since ordinarily they belong to that
> > entry.
> >
> > However a concurrent collapse_file() or __filemap_add_folio() (when
> > replacing a shadow entry) can store a larger folio in the slot, in which
> > case the sibling entries belong to the new folio and the walk still skips
> > them.
> >
> > Consider:
> >
> >     cachestat                         collapse
> >     =========                         ========
> >     count a 64-page folio in slot 8
> >                                       store a 512-page folio in slot 8,
> >                                       with sibling entries in slots 9-15
> >     xas_find() starts at slot 8
> >     and skips slots 9-15
> >       /* 448 pages are never counted */
> >
> > Also consider:
> >
> >     filemap_cachestat()                  __filemap_add_folio()
> >     ===================                  =====================
> >     counts the shadow entry in slot 0
> >                                          slot 0: a folio of 32 pages
> >                                          slots 1-31: siblings of slot 0
> >     xas_find() skips slots 1-31
> >       /* 31 pages are never counted */
> >
> > Essentially the fact that large folios might be present means we cannot
> > safely continue the XArray walk, and must reset the iterator each time.
> >
> > Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
> > Signed-off-by: Chris Mason <mason@kernel.org>
> > [ ljs: squashed 2 commits, fixed up comment in code, and commit message ]
> > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Oops I didn't even include a 'fix this by' even...

David/Andrew - as per Usama, could you add this to the end of the commit msg:

	Fix this by resetting the walk in each loop. This incurs a performance
	penalty, but given that only the RCU lock is held here, it can't be
	avoided.

> > ---
> >  mm/filemap.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 7c05e4fad081..c4e82891767b 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -4731,10 +4731,11 @@ static void filemap_cachestat(struct address_space *mapping,
> >  		if (folio_last_index >= last_index)
> >  			break;
> >
> > -		if (need_resched()) {
> > -			xas_set(&xas, curr_index);
> > +		/* Collapse or new folio spanning shadow entries needs reset. */
> > +		xas_set(&xas, curr_index);
> > +
>
> I imagine this will be a performance hit for the call, as each entry now
> needs a traversal from the xarray root. Might be good to callout in commit
> message. But is the right thing to do.

Yeah good point and I did try to find a way not to do that. But it's apparently
(says AI overlords) less bad than an xa_for_each() implementation :P

> Acked-by: Usama Arif <usama.arif@linux.dev>

Thanks!

--
Cheers, Lorenzo
