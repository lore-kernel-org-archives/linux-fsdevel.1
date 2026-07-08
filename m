Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A974543933A;
	Wed,  8 Jul 2026 15:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783523491; cv=none; b=dDmywzyvgt54v6PUwV+UHIzY+5cBJlb5bGXAn2X5UjGaxcQeBrA7DR9mYN+FHLcU2Q0GBZEOsCgQOqpcEfO8PAWBsBf/dmrPbUU1qGcW/Q3UtXPJBgxOX6LNjp2dYGZV5c/dYggoUkAIZPd0nHvzJUBm/PL6p+25PmwCFavgtqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783523491; c=relaxed/simple;
	bh=e9Pwqi3HUHnU2PuAXg/qt6DJChuZLGaMD4MRDQMpSUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8T+lmne7uNwRQMjjZ/KID3vwkUrxuoYNmktVWoZyeSS1ovxcxp+to4j4rktS8mh83vgTvMghyjwT552TaXe/s2fD6U3VhEs4EPQdWEvW1XqHeH45S+iWyR6fkQYS2iRmbPp1rd20n4cQOrF+TjZB58vVFisX+KUCMIandtSQpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Qb/RHv7i; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Qb/RHv7i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=J/pxFY9i2H1uIH3qn2WpI5uESSkpNo34KEyz12tu0PU=; b=Qb/RHv7i1+F4sr7MQhDRn3uu+I
	8L+loRdJTb+yr7Y0MHO1DU23FhxCmJhKEtIcDAW0ukpfcVstplEJaZchJiJc6if1n+jApqVUsmtQT
	Sf/1O6FSem4VnEgSFarNmSGraxSvHmefjp1iQNF7zgbhWyTzpR0jh7F1euvF+Lv4/rffxHCrqjmLd
	5K+vl7GSG8uYR8jVsbOVdQSFlNtO2iZDdithih6+EJ5G4ZE4RpzdhYEhLMFLbZoF+pmTO6q9bVTpb
	fVNDerc41HdFxY/pqnY4+bs5lrNDB6XnHUONGr0i96fdk4ClPwdw3BpoqZ4dFtWJIzpbcm9kop/H5
	aLGfjczg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1whTvZ-0032EZ-0G;
	Wed, 08 Jul 2026 15:11:09 +0000
Date: Wed, 8 Jul 2026 08:11:03 -0700
From: Breno Leitao <leitao@debian.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, oleg@redhat.com, josh@joshtriplett.org, Jan Kara <jack@suse.cz>, 
	jlayton@kernel.org, axboe@kernel.dk, shakeel.butt@linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 0/4] fs/pipe: unify the page pools into a single
 per-pipe pool
Message-ID: <ak5nXRnSSXfA2B75@gmail.com>
References: <20260707-b4-pipe-unification-v2-0-eb52bddeeefd@debian.org>
 <CAGudoHFGFJZ_j-osEKnLvGYGai+SKVAJKy8B_PChWms7SN7xoA@mail.gmail.com>
 <ak4rSEAwV-RoG1MO@gmail.com>
 <rac56njg4yorvhc5oyrme6bt7ej2vs64umbqkz2np32wpjbcjj@wohli2ntub4s>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rac56njg4yorvhc5oyrme6bt7ej2vs64umbqkz2np32wpjbcjj@wohli2ntub4s>
X-Debian-User: leitao

On Wed, Jul 08, 2026 at 03:18:58PM +0200, Mateusz Guzik wrote:
> On Wed, Jul 08, 2026 at 05:09:19AM -0700, Breno Leitao wrote:
> > On Tue, Jul 07, 2026 at 05:29:20PM +0200, Mateusz Guzik wrote:
> > > On Tue, Jul 7, 2026 at 5:05 PM Breno Leitao <leitao@debian.org> wrote:
> > > >
> > > > TL;DR: This simplifies the pipe code, unify the page pools, reduce the
> > > > code by 9 lines (not counting comments), and no regressions are seen in
> > > > terms of performance.
> > > >
> > > 
> > > This adds an additional acquire + release cycle on the mutex for every
> > > write which preallocates, so I don't see how that's supposed to *not*
> > > slow things down in some capacity.
> > 
> > Thanks a lot for the benchmark and the numbers -- a write-heavy pipe
> > workload with the reader and writer on separate CPUs is exactly the case
> > I wanted to make sure doesn't regress.
> > 
> > I double-checked it again with your test on different setups and page sizes I
> > don't see the regression you are seeing: the bare-metal numbers are
> > flat-to-positive at your size.
> > 
> > I couldn't get my hands on a Sapphire Rapids box easily, so the bare-metal runs
> > are on a Cooper Lake Xeon (the same class I used for the cover letter) and
> > NVIDIA Grace (arm64). Both hosts are completely idle.
> > 
> > 1) X86 test
> > 
> > CPU:  Intel(R) Xeon(R) Platinum 8321HC @ 1.40GHz (Cooper Lake)
> >       1 socket / 26 cores / 2 threads = 52 CPUs
> >       L3 35.8 MiB (1 instance), single NUMA node (0-51)
> >       max freq == base 1.40GHz (no turbo), so the clock is steady
> > 
> > Bare metal, Intel(R) Xeon(R) Platinum 8321HC, your pipen.c
> >    (writer on CPU0, reader on CPU1 -- separate physical cores, same
> >    socket, shared L3), blocking pipe, 12 x 8s per point, median MB/s:
> > 
> >      PIPEN_SIZE   baseline   patched    delta
> >        4096         2658       2531      -4.8%   (noise?)
> >        32678        3517       3527      +0.3%   (your size -- flat)
> >        65536        3072       3358      +9.3%
> > 
> >    4096 is a single-page write that barely touches the pool; the swing
> >    there is inside the run-to-run variance (sd ~100 MB/s on a ~2600
> >    median), so I read it as neutral, not a regression. At 32678/65536
> >    the variance is small (sd 18-58 MB/s), so those deltas are real.
> > 
> > 
> >  
> > 2) Arm64 test:
> > 
> >  Machine / build:
> >     - NVIDIA Grace (Neoverse-V2), 72 cores, 1 socket, no SMT,
> >       single NUMA node, ~256 GB RAM
> >     - Kernel using 64k pages.
> > 
> > Results (baseline vs patched):
> > 
> >   PIPEN_SIZE   pages   baseline   patched   delta    regime
> >      65536       1       17759     17683    -0.4%    want=1 → pool covers it, NO extra lock (no-op)
> >     131072       2       17583     19734   +12.2%    prefill + extra lock taken
> >     262144       4       18781     21017   +11.9%    prefill + extra lock taken
> >     524288       8       19061     20886    +9.6%    = pool max; == Similar to Guzik's 32678 (8 pages)
> >    1048576      16       16842     17110    +1.6%    pool overflows; == Guzik's 65536 (16 pages)
> 
> I verified the extra lock acquires *do* show up on the profile for me
> (with bpftrace -e 'kprobe:osq_lock { @[kstack()] = count(); }'), so this
> has to be leaving perf on the table.
> 
> However, looking at the diff it seems the extra acquires can be
> trivially avoided? See below (untested, consider it an illustration of
> what I mean -- if it works as is I'm fine if it gets folded into your
> patchset without credit).

That is a very nice improvement, thanks for thinking about it and proposing the
patch.

In my quick check on arm64, I haven't seen a big improvement in my Grace arm64
host, These are the numbers I got now:

  3-way comparison — arm64 Grace, 64K pages

    SIZE     pg    base  mypatch  guzik    v2/base   guzik/base   guzik/mypatch
    65536     1   17759   17683   17598     -0.4%       -0.9%        -0.5%
   131072     2   17583   19734   19953    +12.2%      +13.5%        +1.1%
   262144     4   18781   21017   20998    +11.9%      +11.8%        -0.1%
   524288     8   19061   20886   20569     +9.6%       +7.9%        -1.5%
  1048576    16   16842   17110   16920     +1.6%       +0.5%        -1.1%

So, basically just noise compared to this patch in here for that given
CPU/platform.

That said, your approach is better than what I had, and I would like to
integrate it to this patch set. Os it OK if I give a Co-developed-with:
tag?

Thanks for your help here,
--breno
