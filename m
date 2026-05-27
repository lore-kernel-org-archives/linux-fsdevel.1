Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964CC2C11F9
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 06:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779862012; cv=none; b=nxFqrllYzEjl0IRiZLppXQgAnjYlqfZX1XJPHMfViD0yYym6ESvraAZ03DiFNTSWgyMaV1yK0mgiQcu/B5odMG2sA40wOPrnd9hJJC7/Owovwmwb2k8YBmFpJt9fDGEHEC1gR9jfz58+6TyTAG9dsHQPld6WTip/FMlRFmo2gb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779862012; c=relaxed/simple;
	bh=Jl4GJKyXU3iued/rHMS44P984aP/6ruNF4aBpcLni2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRCZAlNvUoSsCk4ZiAJvmdyBFUZC0wNd1sOEeRvux6KZtvI6zmRwV3qGFs/7sfR5m/BE0ro5Is+bOqvJAMPJGRK6Rncx2dfsUWWOZB1ofF77C/HdMw+6irCBuBl3kAXYLmiOQcXa/r+IoxJq61YbikcQemxMKlziaopvwHmjqpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (065-142-067-156.ip-addr.inexio.net [156.67.142.65])
	by smtp03-ext2.udag.de (Postfix) with ESMTPA id E40D3E0305;
	Wed, 27 May 2026 07:57:53 +0200 (CEST)
Authentication-Results: smtp03-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 27 May 2026 07:57:52 +0200
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com, fuse-devel <fuse-devel@lists.linux.dev>, Jan Kara <jack@suse.cz>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: Re: [PATCH] fuse: disable default bdi strictlimiting
Message-ID: <ahaF7UaeQlgajYDi@fedora.fritz.box>
References: <20251008204133.2781356-1-joannelkoong@gmail.com>
 <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
 <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com>
 <CAJnrk1bx+32Tq5DOk6=C+_smV2HgP3+RT6gpYLSNMEirFs_EkQ@mail.gmail.com>
 <CAJfpegsy2XRR6g1J4Mg0MXPckx3NVprW56XvYhEko0=7PcHiQQ@mail.gmail.com>
 <CAJnrk1bZX44HaXmNMxEeEwhuFHgEjxXLnjKy8a-6T6LFuf+K2A@mail.gmail.com>
 <CAJnrk1aJwdY+fphnhHjAXFwjGqWQgVB+sn2Ce0gReein3H8EWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aJwdY+fphnhHjAXFwjGqWQgVB+sn2Ce0gReein3H8EWQ@mail.gmail.com>

On Tue, May 26, 2026 at 06:42:35PM -0700, Joanne Koong wrote:
> On Tue, May 12, 2026 at 1:56 PM Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > On Fri, May 8, 2026 at 2:42 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Mon, 27 Oct 2025 at 23:39, Joanne Koong <joannelkoong@gmail.com> wrote:
> > > > Miklos, could you share your thoughts on this? Are you in favor of
> > > > disabling default strictlimiting? Or do you prefer to have it kept
> > > > enabled by default, with some mount option or sysctl added for
> > > > privileged servers to be able to disable strictlimiting + enable large
> > > > folios if they use the writeback cache?
> > >
> > > So what I think we should do is implement some sort of slow writer
> > > test, and see what happens with and without strictlimit.
> > >
> > > Tried to ask claude to do this for me, but not getting very far.
> > >
> > > So if I take this maintainership role seriously and not let myself
> > > drown in the details, then the logical thing to do is to delegate ;)
> > > Which is hard (for me at least) but I'll give it a try...
> > >
> > > Could you please check how things change if there's limited writeback
> > > rate and we disable strictlimit?  And what happens if there are
> > > several such instances running in parallel?
> >
> > I think for unprivileged fuse servers, strictlimting will always need
> > to be enabled or else a malicious user can launch tons of unprivileged
> > servers and eat up the global dirty page budget / starve writeback for
> > the rest of the system. Similarly for privileged servers, it could be
> > unintentionally slow or buggy and eat up the dirty page budget. I'll
> > read through the writeback throttling code to verify this and run some
> > local tests.
> 
> I read through the writeback throttling code and re-read Jan's very
> helpful comments from this thread last year [1]. So for unprivileged
> servers, I think we definitely cannot remove strictlimiting. If the
> fuse server is slow or unresponsive with writing back the pages, it
> will take up too much of the global dirty budget which will degrade
> write throughput for other filesystems (their throttling will be
> computed against the global dirty page count, eg the freerunning check
> in balance_dirty_pages() and the pos_ratio calculation "pos_ratio =
> pos_ratio_polynom(setpoint, dtc->dirty, limit)" (dtc->dirty is the
> global dirty page count)) and any fuse stuck dirty pages are
> essentially unreclaimable. Without strictlimiting, there will be no
> hard cap on how many dirty pages a misbehaving server can accumulate.
> 
> With strictlimiting on and large folios enabled, the problem is that
> the large folio size can potentially dwarf the server's dirty budget,
> which can lead to excessive throttling. When I ran my benchmarks last
> year, I and independently Jingbo saw severe performance regressions
> for buffered writes with large folios (eg 2 GB/s BW w/o, and 200 MB/s
> BW w/) [2] but I think that might have been because the machines had
> limited RAM, resulting in a very small dirty budget. Fuse sets the max
> ratio of the bdi to 1% of the global dirty threshold, so running
> through some napkin math:
> 
> On a 64 GB machine:
>   - DirtyThresh = 20% of 64 GB = 12.8 GB
>   - BdiDirtyThresh = 12.8 GB / 100 = 128 MB
>   - 128 MB / 2 MB folio = 64 dirty folios
> 
> On a 32 GB machine:
>   - BdiDirtyThresh = 64 MB
>   - 32 dirty folios
> 
> On an 8 GB machine:
>   - BdiDirtyThresh = 16 MB
>   - 8 dirty folios
> 
> On a 8GB machine (with assuming vm.dirty_ratio=20% and
> vm.dirty_background_ratio=10%), we get 12 MB of freerun, 4 MB of
> proportional throttling, and then full throtttling starts at 16 MB.
> With 2MB folios, the 4MB zone between freerun and f ull throttling
> doesn't leave that much room for the balance_dirty_pages() logic to
> adjust the dirtier's speed, which I think causes the writes to
> oscillate between freerunning and then being fully (overly) throttled.
> 
> I think this is also going to be a problem for cgroups with large
> folios since they also, as I understand it, are constrained with a
> limited / tight dirty budget. I ran some initial benchmarks with
> cgroup memory constraints on NVMe and saw similar instability (a
> single writer in a 8 GB cgroup had max write latencies of 6 seconds vs
> 15 ms without the cgroup, with the balance_dirty_pages() throttling
> oscillating rather than settling near the set point).
> 
> I think this problem gets untenable for random writes with large
> folios, since dirtying just a few bytes will charge the whole folio
> size to the dirty budget. I have a patchset from last year for adding
> more granular dirty/writeback tracking [3], I'm going to pick this
> series back up. I think it will be useful generically, not just for
> fuse.
> 
> For getting this to work on fuse servers with strictlimiting, I think
> the next steps are to
> a) as Jan had suggested in [1], come up with some heuristic to
> constrain the max order supported for large folios for these fuse
> servers if they're running with the writeback cache enabled
> b) benchmark ^ and if there are still regressions, then we should
> probably just turn large folios off for these servers
> c) add the granular writeback/dirty accounting for large folios
> d) look into improving the balance_dirty_pages() throttling logic to
> handle narrow gaps between the freerun and full throttling zones
> better and reduce over-throttling
> 
> Does this sound like a reasonable way forward?

Sounds good to me, since we have seen pretty much the same when we enabled
large folios for testing.

> 
> For privileged servers, I still think it makes sense to remove the
> strictlimiting requirement or at the least, let admins opt out of that
> if they are confident their server is well-behaved.
> 

Here I'm not really sure what the most logical and sane way would be.
I really don't like limits for no reason but I understand the necessity
to have limits enabled for unpriviledged servers.

Do you think a module parameter is the right way to go here?
The connection parameter might be a problem since an admin would have
to set it for a large number of mounts.

Horst

> 
> Thanks,
> Joanne
> 
> [1] https://lore.kernel.org/linux-fsdevel/tglgxjxcs3wpm4msgxlvzk3hebzcguhuu752hs3eefku6wj4zv@2ixuho7rxbah/
> [2] https://lore.kernel.org/linux-fsdevel/f9b63a41-ced7-4176-8f40-6cba8fce7a4c@linux.alibaba.com/
> [3] https://lore.kernel.org/linux-fsdevel/20250829233942.3607248-1-joannelkoong@gmail.com/
> 
> >
> > I think the question is whether we want to let admins opt out of
> > strictlimit when they're confident their server is well-behaved eg
> > through a sysctl an admin can set to disable strictlimiting for all
> > servers. Otherwise, large folios will always have to be off for any
> > server that runs with writeback caching.
> >
> > Thanks,
> > Joanne
> > >
> > > Thanks,
> > > Miklos
> 
