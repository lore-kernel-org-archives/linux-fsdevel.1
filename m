Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AB13B3BEF;
	Sat, 12 Sep 2026 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789239347; cv=none; b=sXoMGYquMG/LZpgi3uUwLCAn/D9hHxc/OHlbT4t/Bb7QBCvMXGnO4OUwet0DmXSYv21fwlw1Koh/yMzDd5My83bExXES/AnaGyaTQaPDiSwiFnga49tlP6Zbl5rbmQ5AxemV/HeaBzsT4qgWTbM+nc0HomUud/w85bHb6Tg2bHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789239347; c=relaxed/simple;
	bh=iDOMkFUoAbYyhg1V4f/tvWiNXTiKVelkPuw/jlb/jjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nK9aK6GHu/qQjnUn1FEs+6g2Y+D3C2Xmy5P4BUR4L42I5iGfyysCv+QsF4lNi3CA6rR+Ot8ed9q4ASzp4wV3xoUFKw6YKIs6391JKeF54FPSNfCuuZK1YxGRDBxx9RomKIxrb2dvaM0DzhjGceGNrT3nmx1tIUqDYIONOrekX5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfjnJEkY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfjnJEkY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454D81F00893;
	Sat, 12 Sep 2026 18:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789239346;
	bh=HUcxlcbaDdo23591UngwmMxDtqKXJFAuV7We/f5fCME=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=LfjnJEkYMJQ+GyGUVqP7t/4fiTiSokO6rlR6GqlTrgouWVIhVVCJYmfFWs8q9BCj4
	 pOwnhu2fRfvFW7xvg4kONTzpZt8HLDKA7TNVEQQY3ecnvfFyXQyErBLfkkDd7GimVJ
	 NWnaXQvdcI/b2IzMl8GsRdgo6DQO8XSWyGqUwToVXHJgMoO+vwpZrOtjlnjEAYmeMP
	 Om639OoptgnZqn0J8RABvcWDK6xbG4ia24mWkA+r1QvgrbD+JhYM88PyCwMEY5+lqb
	 EEzOjeVZFLosIHUohT+hRFBlVm4ipXoWP3tsYzUKlj01bPCJgt2ts8YNSA4OQafiXs
	 +cpVIwR/6jYvg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0C807CE1578; Sat, 12 Sep 2026 11:55:46 -0700 (PDT)
Date: Sat, 12 Sep 2026 11:55:46 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, liam@infradead.org,
	ljs@kernel.org, vbabka@kernel.org, david@kernel.org,
	willy@infradead.org, jannh@google.com, pfalcato@suse.de,
	xueyuan.chen21@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] read proc/pid/smaps_rollup under per-vma lock
Message-ID: <ff6a7b3f-1624-4940-a4c5-3efd51a35eba@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260911194145.1781926-1-surenb@google.com>
 <20260912002436.0605a85b912eb8ae406cecf0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912002436.0605a85b912eb8ae406cecf0@linux-foundation.org>

On Sat, Sep 12, 2026 at 12:24:36AM -0700, Andrew Morton wrote:
> On Fri, 11 Sep 2026 12:41:38 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
> 
> > proc/pid/smaps_rollup can be read using the combination of RCU and
> > VMA read locks, similar to proc/pid/{maps|smaps|numa_maps}. RCU is
> > required to safely traverse the VMA tree and VMA lock stabilizes the
> > VMA being processed and the pagetable walk.
> > Note that we have to keep the logic to drop mmap_lock on contention
> > because even when using per-VMA locks we might have to fall back to
> > holding the mmap_lock.
> 
> Nice.  Queued, thanks.
> 
> The speedups described in [6/7] are significant, although I don't know
> how representative Paul's tests are.  Probably not very.
> 
> So I don't know how much improvement our users will be seeing from
> these changes?
> 
> And I don't know how much usage smaps_rollup gets in the real world?

It is used heavily in some applications for monitoring.  This should allow
us to more tightly fence our monitoring software, leaving more CPU for
the application.

So thank you all!!!

							Thanx, Paul

> As I've no doubt you know, Sashiko is saying things.  About these
> patches and about the current code.  Its pre-existing
> clear_soft_dirty_pmd() driveby find looks significant.
> 
> 	https://sashiko.dev/#/patchset/20260911194145.1781926-1-surenb@google.com
