Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58A83F54C5;
	Wed,  8 Jul 2026 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512577; cv=none; b=Z/GGlOfqAfmnjGeJ+J1co6VD8+WmeEl/QBhZxSGvTbm/bWxB9Jvc/44nI0BJLMM6KbjJi1uHENZ7dzBxkOLkk8CHIPjNJalGq/QG1ilMl4mCBdxOKvaAtvc6hkLQ8E1/QgGJAf392gHWUI2mgDfNiHhKxcgxa69oF1eHysCtZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512577; c=relaxed/simple;
	bh=MoF0dO+xRah/fHHgUfiA+cnXjPVc+PudrF2yQqofki4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sPEk36qOr+bcue6G1osXQbIariK6M7EbHUQFuxYSNsGb7cmKDtFjDO433OyFyK+9SufL4jnLsitRXGnMPrnbPiuvF9RT8qEWowH01Rp/lG4mZSAodk/s5CqIVvs9jMLIW/vNYWESJRoulVUIvmVPhz7aQ7iiLowqskFP0GF/qCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=My9vdSEO; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="My9vdSEO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=SCG0OBPfBkx+VYrWq9yUWPAUfgSSjUDg4+J4YdKrsrU=; b=My9vdSEO3e4k2wDAAGgkz0EO0p
	NVZUfmBvqxqoD9f2+L1dE9ajOiLT6CCjwTGm1vr8tbSp38Vk4RvYOUgo/t1OkSYiMB4TCDL1mmE3Q
	lkTcL2hykG8cZwXTNCQ9vDUAfSQqtP4wP08YC85BaFMueUHFRLo37vKZ8B43vM4Q9Pk6aL0HTFSBX
	Ri51aTsZJaIGipDi84JjyfKXmRF7oRiDOlgrT7rj/fviEhOugDvPwK+ZCaXD3foJybrGjs+4NKFez
	YSrjzTyocJKXhMbB+9SWzMUjUk2YGG5XAClglP19kjvBwWmq2NyjQwYIpRcp08NX5s6V4T20Jqenv
	UeGEv0gw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1whR5g-002wEf-2G;
	Wed, 08 Jul 2026 12:09:24 +0000
Date: Wed, 8 Jul 2026 05:09:19 -0700
From: Breno Leitao <leitao@debian.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, oleg@redhat.com, josh@joshtriplett.org, Jan Kara <jack@suse.cz>, 
	jlayton@kernel.org, axboe@kernel.dk, shakeel.butt@linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 0/4] fs/pipe: unify the page pools into a single
 per-pipe pool
Message-ID: <ak4rSEAwV-RoG1MO@gmail.com>
References: <20260707-b4-pipe-unification-v2-0-eb52bddeeefd@debian.org>
 <CAGudoHFGFJZ_j-osEKnLvGYGai+SKVAJKy8B_PChWms7SN7xoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFGFJZ_j-osEKnLvGYGai+SKVAJKy8B_PChWms7SN7xoA@mail.gmail.com>
X-Debian-User: leitao

On Tue, Jul 07, 2026 at 05:29:20PM +0200, Mateusz Guzik wrote:
> On Tue, Jul 7, 2026 at 5:05 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > TL;DR: This simplifies the pipe code, unify the page pools, reduce the
> > code by 9 lines (not counting comments), and no regressions are seen in
> > terms of performance.
> >
> 
> This adds an additional acquire + release cycle on the mutex for every
> write which preallocates, so I don't see how that's supposed to *not*
> slow things down in some capacity.

Thanks a lot for the benchmark and the numbers -- a write-heavy pipe
workload with the reader and writer on separate CPUs is exactly the case
I wanted to make sure doesn't regress.

I double-checked it again with your test on different setups and page sizes I
don't see the regression you are seeing: the bare-metal numbers are
flat-to-positive at your size.

I couldn't get my hands on a Sapphire Rapids box easily, so the bare-metal runs
are on a Cooper Lake Xeon (the same class I used for the cover letter) and
NVIDIA Grace (arm64). Both hosts are completely idle.

1) X86 test

CPU:  Intel(R) Xeon(R) Platinum 8321HC @ 1.40GHz (Cooper Lake)
      1 socket / 26 cores / 2 threads = 52 CPUs
      L3 35.8 MiB (1 instance), single NUMA node (0-51)
      max freq == base 1.40GHz (no turbo), so the clock is steady

Bare metal, Intel(R) Xeon(R) Platinum 8321HC, your pipen.c
   (writer on CPU0, reader on CPU1 -- separate physical cores, same
   socket, shared L3), blocking pipe, 12 x 8s per point, median MB/s:

     PIPEN_SIZE   baseline   patched    delta
       4096         2658       2531      -4.8%   (noise?)
       32678        3517       3527      +0.3%   (your size -- flat)
       65536        3072       3358      +9.3%

   4096 is a single-page write that barely touches the pool; the swing
   there is inside the run-to-run variance (sd ~100 MB/s on a ~2600
   median), so I read it as neutral, not a regression. At 32678/65536
   the variance is small (sd 18-58 MB/s), so those deltas are real.


 
2) Arm64 test:

 Machine / build:
    - NVIDIA Grace (Neoverse-V2), 72 cores, 1 socket, no SMT,
      single NUMA node, ~256 GB RAM
    - Kernel using 64k pages.

Results (baseline vs patched):

  PIPEN_SIZE   pages   baseline   patched   delta    regime
     65536       1       17759     17683    -0.4%    want=1 → pool covers it, NO extra lock (no-op)
    131072       2       17583     19734   +12.2%    prefill + extra lock taken
    262144       4       18781     21017   +11.9%    prefill + extra lock taken
    524288       8       19061     20886    +9.6%    = pool max; == Similar to Guzik's 32678 (8 pages)
   1048576      16       16842     17110    +1.6%    pool overflows; == Guzik's 65536 (16 pages)


Both tests with:
	Kernel: linux-next 20260623 base, production .config
		(no KASAN / LOCKDEP / DEBUG_* / nothing useless), baseline vs the
		full series, both built with clang, coexisting in grub
	Test:   your will-it-scale test (pipen.c), PIPEN_SIZE=32678, -t 2
		(1 writer + 1 reader on separate cores);
		performance governor, writer and reader pinned to two cores


You're right that there is an extra lock/unlock in the prefill path, so
I don't want to wave your result away -- may it be specific to SPR's
topology/cache? 

I'll also keep trying to grab a Sapphire Rapids machine so I can run your
will-it-scale case directly on the same uarch, and check if I can reproduce
it..

Thanks,
--breno
~

