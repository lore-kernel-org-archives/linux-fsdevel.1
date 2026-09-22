Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B451AFC6;
	Tue, 22 Sep 2026 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790074035; cv=none; b=VGmKgpcg82n/pNKssPd1PoUWRXPAfXlB0z0OWTiXU91dnTHA8vkczjQboTmznT/XXsRR3pYWWkCvxl2mz1L3iupy62KibzhhlPoJ1kn6FH7geeoJrKJonmY2RFzcOyoXTOJ/Umcktz0nuAwG1+vPcE+jzQVmAuVR0XkgJfHdhBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790074035; c=relaxed/simple;
	bh=IawLj7aqwzQGc78V1Oo5gGQ67uJJH0blchz2xUDXHGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtMKbpeXwRf9l/d5Krx6Jzky5LBO2Y/kePkioT9shq5RCCA/a5S1+CKH3E8TLhtG9Q9bXZMrDi73d4lAWyZ32LiQKEHB9HWiansSDmFdm6ck9NGUKh8c5UxCpmuHr2N1v+Vn/F6rwxBIFcRCZBpkANwI/xp2tN2PitwjOQlJ2SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vs/PHQPu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vs/PHQPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96E61F000FF;
	Tue, 22 Sep 2026 10:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790074034;
	bh=IawLj7aqwzQGc78V1Oo5gGQ67uJJH0blchz2xUDXHGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vs/PHQPuN9SJlA/5opT2vG+BItdARiKWnhmDyAZoecXIcm5CJua1eS0xuvsUwHFTF
	 x9hHYldMcpXJ0QSU0Me0VRQqkyXjGEqqxU63D5/kKy7Jacd+mRaJRY3paMOxc/3Vi9
	 HVl4mpfFzOAAjaQX8sbjC6mkRBWIm/b1X2iSPNbNLhVNQ2E8VPAE8Dq4Hz4zXE2VXI
	 buRSl9jM0z39Rle0zZ0v771qFBajKvVuD/6ROjIhu+seL6iGJLoEjWO+ULiB3+K7xL
	 rACxLPzvK7iKVoGxfFS2KiZXzupDNAOJaVnuJ9mmNkryS+tPzh9DWcnO0gTGRHDsl1
	 p4+8QZt+EZYdg==
Date: Tue, 22 Sep 2026 11:47:03 +0100
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
Message-ID: <arJcPIaqJOzLpkel@gremlin>
References: <20260921152449.629486-1-alex@ghiti.fr>
 <70cae945-3a4a-40db-96ac-5ce66a3fa186@kernel.org>
 <CAGsJ_4y8-wD0yMV8GCtCz5MfNrOKqUaTd+UgH=8MoP_nuvPnGg@mail.gmail.com>
 <108487b7-0529-4282-b5f4-355804b4c0cf@kernel.org>
 <CAGsJ_4zGmGh70QtRBpnhueev3qt_bgB4ZiE9fkW-hgNjAVhv+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zGmGh70QtRBpnhueev3qt_bgB4ZiE9fkW-hgNjAVhv+w@mail.gmail.com>

On Tue, Sep 22, 2026 at 06:37:38PM +0800, Barry Song wrote:
> On Tue, Sep 22, 2026 at 6:20 PM David Hildenbrand (Arm)
> <david@kernel.org> wrote:
> >
> > On 9/21/26 23:56, Barry Song wrote:
> > > On Mon, Sep 21, 2026 at 11:37 PM David Hildenbrand (Arm)
> > > <david@kernel.org> wrote:
> > >>
> > >> On 9/21/26 17:24, Alexandre Ghiti wrote:
> > >>> On an asynchronous swap device MADV_PAGEOUT only marks the folio
> > >>> PG_reclaim and rotates it to the tail of the inactive list once its
> > >>> writeback completes, so the memory is not actually freed until a later
> > >>> reclaim scan removes the by then clean swap cache folio.
> > >> But we have the same behavior when just reclaiming memory ordinarily? It's added
> > >> to the swapcache and only the next scan actually frees up the memory.
> > >>
> > >> Wouldn't we memory we reclaim ... just gone, like in the sync case?
> > >
> > > For synchronous I/O, such as zswap and zram, the memory is released
> > > immediately after sync I/O is done.
> > >
> > > For asynchronous I/O, such as NVMe, the swapcache is currently
> > > expected to be rotated back to the tail of the LRU and wait for
> > > another scan. Alexandre once mentioned that when he tried handling
> > > async I/O the same way as sync I/O—releasing the memory once the I/O
> > > completed—he saw some regression. So, delaying the release until a
> > > later scan may allow swapcache hits before the folios are eventually
> > > reclaimed.
> >
> > "may", do we have any evidence that this actually is relevant in practice?
> >
> > We asked to reclaim memory. We wrote the memory out to disk. We unmapped it from
> > the page tables. We made the workload the could, access the page immediately
> > again suffer already.
> >
> > We should just evict them as soon as possible to free up memory.
>
> I suggested this to Alexandre, and he found that it could regress some
> workloads [1]. That is why Alexandre is only making the folios
> immediately reclaimable for `MADV_PAGEOUT`.
>
> See Alexandre's description:
>
> "Future work
> -----------
> Barry suggested extending this to MADV_PAGEOUT and general reclaim. I
> prototyped dropbehind for all reclaimed swap folios and it regressed
> sysbench OLTP throughput by ~15% on NVMe swap: dropping the swap cache
> immediately turns cheap in-cache refaults into disk reads and collapses
> swap readahead clustering. Neither blk-wbt, mq-deadline nor a PG_workingset
> gate recovered it. MADV_PAGEOUT alone may still be worth it, since there
> userspace has explicitly declared the range cold, but I have not measured
> that case in isolation yet."
>
> [1] https://lore.kernel.org/linux-mm/20260921151306.625134-1-alex@ghiti.fr/
>
> Best Regards
> Barry

This patch as-is is just way way way WAY too complicated and fragile IMO.

Whatever cases you have found, they need to be fixed somewhere
fundamental. All of this feels like a hack.

If you're having to write a comment like:

/*
 * If X is Y, but not if B, and if Z is J but not if the moon's bright at
 * night, then maybe we will foo the bar, but only if the baz is blarghed,
 * ...
 */

That usually means you're doing something horribly wrong.

And this patch has multiple comments like that.

--
Cheers, Lorenzo
