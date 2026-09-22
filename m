Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF4E539792;
	Tue, 22 Sep 2026 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075770; cv=none; b=tyfdQ6/vTs29J0m1rc//Ao0GdFLXb+9ZA9AhEWQTKOAEtTGyk9YOKJO8eIACRBmXzFOeaHaD++6YLkngrKXAisMFYfie7vQ6J1VPOAERFoHDZjivfwqK8T1s3SHjq6FXxRgBaRQE7NkTKIjxjmDM4ECFSBJB4afPtTVc2NcYp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075770; c=relaxed/simple;
	bh=+RaZuVIG1YaGZPcoIlVxgNfr0ImvMSgKIog+32TF/R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnDNPWVZAj+8XZit2IQSC18dq3CdUN91SrVwtaMzf+358k98GsJE49vVJmSPNBgorQHs2bTKY97BdnUzGeFYdT20fTu3xLX1ORQ6dZes5euHP2hn2Up57H1xRR2Ie+Y8biLQU8I5ZMGde5sT/MMQmUjuw32hoSMgZp1+aN6mf1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se83kj0b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se83kj0b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C8C1F000FF;
	Tue, 22 Sep 2026 11:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790075768;
	bh=EEvm8I6LeSgj4oQnMRC54w4ykScQkevg5Qz+kK3tQrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Se83kj0bce8Luv8VgaV4OXVt0BG57bNUiY6iy+ogW0PIEouzPLNRjQZWWIp7cIwY9
	 jgrirBqgUjQ9cLp6Ln5o+UhFIwWuktEINx0nxFeVeR1QknrurTWHdvwA41+qItcQ86
	 rtBwUmvga789F3rFSd+49CsMVAhC5i0oFhxMyc06Ar3RApP/2Iy/lu/giWDb327AfI
	 o2nFyWKbp2YxKIYiwvWVe/LzqOt2MyB9xmrtUSoTja/X81fc5HD08cHaG27Jf4v28c
	 rMNkuggNvTYEWxdyvHwkU9MGrhAT06rUkmygYJpNYE98EinXS9XGrP78/L2sC6ra+K
	 RtKeCsXOnsmBA==
Date: Tue, 22 Sep 2026 12:15:58 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Barry Song <baohua@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Alexandre Ghiti <alex@ghiti.fr>, akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz, 
	liam@infradead.org, vbabka@kernel.org, jannh@google.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	baoquan.he@linux.dev, youngjun.park@lge.com, qi.zheng@linux.dev, 
	shakeel.butt@linux.dev, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, yosry@kernel.org, chengming.zhou@linux.dev, 
	kunwu.chan@gmail.com, tz2294@columbia.edu, hch@lst.de, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: madvise: drop MADV_PAGEOUT folios at swap writeback
 completion
Message-ID: <arJi8RRxLM-1JiPV@gremlin>
References: <20260921152449.629486-1-alex@ghiti.fr>
 <70cae945-3a4a-40db-96ac-5ce66a3fa186@kernel.org>
 <CAGsJ_4y8-wD0yMV8GCtCz5MfNrOKqUaTd+UgH=8MoP_nuvPnGg@mail.gmail.com>
 <108487b7-0529-4282-b5f4-355804b4c0cf@kernel.org>
 <CAGsJ_4zGmGh70QtRBpnhueev3qt_bgB4ZiE9fkW-hgNjAVhv+w@mail.gmail.com>
 <arJcPIaqJOzLpkel@gremlin>
 <CAGsJ_4zLY6eZWUufuVqLgEVf93G1JoKtk9ObftkoTwbAimG8Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zLY6eZWUufuVqLgEVf93G1JoKtk9ObftkoTwbAimG8Yw@mail.gmail.com>

On Tue, Sep 22, 2026 at 07:10:34PM +0800, Barry Song wrote:
> On Tue, Sep 22, 2026 at 6:47 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >
> > On Tue, Sep 22, 2026 at 06:37:38PM +0800, Barry Song wrote:
> > > On Tue, Sep 22, 2026 at 6:20 PM David Hildenbrand (Arm)
> > > <david@kernel.org> wrote:
> > > >
> > > > On 9/21/26 23:56, Barry Song wrote:
> > > > > On Mon, Sep 21, 2026 at 11:37 PM David Hildenbrand (Arm)
> > > > > <david@kernel.org> wrote:
> > > > >>
> > > > >> On 9/21/26 17:24, Alexandre Ghiti wrote:
> > > > >>> On an asynchronous swap device MADV_PAGEOUT only marks the folio
> > > > >>> PG_reclaim and rotates it to the tail of the inactive list once its
> > > > >>> writeback completes, so the memory is not actually freed until a later
> > > > >>> reclaim scan removes the by then clean swap cache folio.
> > > > >> But we have the same behavior when just reclaiming memory ordinarily? It's added
> > > > >> to the swapcache and only the next scan actually frees up the memory.
> > > > >>
> > > > >> Wouldn't we memory we reclaim ... just gone, like in the sync case?
> > > > >
> > > > > For synchronous I/O, such as zswap and zram, the memory is released
> > > > > immediately after sync I/O is done.
> > > > >
> > > > > For asynchronous I/O, such as NVMe, the swapcache is currently
> > > > > expected to be rotated back to the tail of the LRU and wait for
> > > > > another scan. Alexandre once mentioned that when he tried handling
> > > > > async I/O the same way as sync I/O—releasing the memory once the I/O
> > > > > completed—he saw some regression. So, delaying the release until a
> > > > > later scan may allow swapcache hits before the folios are eventually
> > > > > reclaimed.
> > > >
> > > > "may", do we have any evidence that this actually is relevant in practice?
> > > >
> > > > We asked to reclaim memory. We wrote the memory out to disk. We unmapped it from
> > > > the page tables. We made the workload the could, access the page immediately
> > > > again suffer already.
> > > >
> > > > We should just evict them as soon as possible to free up memory.
> > >
> > > I suggested this to Alexandre, and he found that it could regress some
> > > workloads [1]. That is why Alexandre is only making the folios
> > > immediately reclaimable for `MADV_PAGEOUT`.
> > >
> > > See Alexandre's description:
> > >
> > > "Future work
> > > -----------
> > > Barry suggested extending this to MADV_PAGEOUT and general reclaim. I
> > > prototyped dropbehind for all reclaimed swap folios and it regressed
> > > sysbench OLTP throughput by ~15% on NVMe swap: dropping the swap cache
> > > immediately turns cheap in-cache refaults into disk reads and collapses
> > > swap readahead clustering. Neither blk-wbt, mq-deadline nor a PG_workingset
> > > gate recovered it. MADV_PAGEOUT alone may still be worth it, since there
> > > userspace has explicitly declared the range cold, but I have not measured
> > > that case in isolation yet."
> > >
> > > [1] https://lore.kernel.org/linux-mm/20260921151306.625134-1-alex@ghiti.fr/
> > >
> > > Best Regards
> > > Barry
> >
> > This patch as-is is just way way way WAY too complicated and fragile IMO.
> >
> > Whatever cases you have found, they need to be fixed somewhere
> > fundamental. All of this feels like a hack.
> >
> > If you're having to write a comment like:
> >
> > /*
> >  * If X is Y, but not if B, and if Z is J but not if the moon's bright at
> >  * night, then maybe we will foo the bar, but only if the baz is blarghed,
> >  * ...
> >  */
> >
> > That usually means you're doing something horribly wrong.
> >
> > And this patch has multiple comments like that.
>
> I'm not quite sure if you've read the context carefully :-) or why
> you're angry with me.
>
> I did suggest that we should reclaim memory immediately after
> writeback completes, both for general memory reclaim and for
> `MADV_PAGEOUT`, while Alexandre was working on zswap dropbehind.
>
> Alexandre then found that this might not be a good idea for generic
> reclaim, but thought it might still be worth trying for `MADV_PAGEOUT`.
> That's why this patch came about.
>
> The discussion between David and me is whether we should do this for
> `MADV_PAGEOUT` only, or also apply the same approach to generic
> reclaim. So far, we haven't even gotten into the code details.
>
> And this is also the first day I've seen the code. I agree that I can
> work with Alexandre to improve the code through review, but please
> keep in mind that this is literally my first day looking at it,
> my respected Lorenzo. :-)

I'm not angry with anybody, I'm saying the patch feels like a (fragile)
hack and the issue needs addressing more fundamentally, echoing David's
suggestion.

I also pointed out that when comments need to be extremely specific about
exactly why you're doing something, that usually means something is wrong.

To expand on that - the reason why is that clearly the logic you are
adjusting is assuming something.

You are violating that assumption, which is why the comment is there.

Generally that means the assumptions are wrong and something more
fundamental needs to be changed.

>
> Best Regards
> Barry

--
Cheers, Lorenzo
