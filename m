Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19A653FD55;
	Tue,  8 Sep 2026 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872014; cv=none; b=qXYABVjgPWt8x3r5rrBdBMGMBmWJ3+WzWYH/uYeV9o69mFnKdw1aHdoGtK1Pl9p9Xgf36AkGHG5Zz0PQvjBxXKTFBguSG06FL1VQBzk98/RUCJKIrbjDcf2YuwC93lR99JeRSP+TVF3azXLhLqV1rrhULXIn4L4vCvpVin4VWQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872014; c=relaxed/simple;
	bh=y6FRcqlWaa9yc/JdjdqrPQleuc+AxyMLw9NjsPzEBDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fconaSU6iCrTp7z5ac4kQbbsdafcH+Hu+SWTlCLH2/ytgPDb0NHq7jGIBtYhNQiVW4grYqlJ7ZcVCZDdiKFzXuGPbJBid4icbAaP5eNvpWcxYtdSPXfpR3yqK27IoYQ6Z5LQ0tbnkYX0QnzRmE8KYu1qpLM+JMjSkOcjhHBTjF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A371F00A3A;
	Tue,  8 Sep 2026 12:53:26 +0000 (UTC)
Date: Tue, 8 Sep 2026 13:52:57 +0100
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
Subject: Re: [PATCH v2 3/6] mm/vma: only permit MAP_PRIVATE /dev/zero to be
 mapped anonymous
Message-ID: <aqAFBTyAqPTHlxkZ@gremlin>
References: <20260908-map-private-dev-zero-v2-0-acc7b5625305@kernel.org>
 <20260908-map-private-dev-zero-v2-3-acc7b5625305@kernel.org>
 <e743b598-9048-440f-9124-72071c696679@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e743b598-9048-440f-9124-72071c696679@kernel.org>

On Tue, Sep 08, 2026 at 02:49:33PM +0200, David Hildenbrand (Arm) wrote:
>
> > +	/* Temporary MAP_PRIVATE-/dev/zero workaround. */
> > +	if (is_anon && map->file)
> > +		vma_set_anonymous(vma);
> > +
> >  	if (error)
> >  		goto free_iter_vma;
> >
> > @@ -2777,6 +2793,10 @@ static int call_mmap_prepare(struct mmap_state *map,
> >  	if (err)
> >  		return err;
> >
> > +	/* Hooks cannot mark themselves anonymous. */
>
> Wasn't this supposed to be reworked? :)

It is, you yourself pointed out 4/6 makes this irrelevant, so I changed it
there :)

>
> In any case,
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>
> --
> Cheers,
>
> David

--
Cheers, Lorenzo
