Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F3E2882D7;
	Sun, 24 May 2026 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779641246; cv=none; b=iQgxbPkqZOJv965iYHXH7rOWd8RNU8GfBsstt9HiRm8pxDOe1sFqqZAcMvtN1mgeG9+j8aDVzPH4Yd1lZC07fTPVkvzoo4XXU98KXoSpZC98YoSCmVD6jwngkZyZHdNIvn4wBfxhjgjZRCDmZa5yv8olJ1OLBXAo6XLDcxbvqgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779641246; c=relaxed/simple;
	bh=mVW1kdZvbbN42NNHKFpXo+dTzlvPImvSOrD2DnXrZRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cny/PToHOT9pHFibxeq8KurSWl8mmq5LxJCnT4aSSZvq/6400fLMRaQenaB9O7f24ILQWBc7jUsEcox5JNMf74AJPoltXnLvAWcVXoswS6ZPgcTBywy2S9+EgwAzbMJeNc0Dhc8RUhGZRbM76ZNif/tFcrEAG1KfCz+BvvOlk/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=mjvyEJqN; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="mjvyEJqN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=+dqi8OMJkZSoqQVtGIdgyXjfbJbulgqS8GxVns0cVfI=; b=mjvyEJqNVRpl7TPRpUGrP6Q2t4
	Qj9Oo3s4C+lUDiXtifS/7DK/bZLf1iKqqNFRE+dblUOAufvNxcYcMuTqZehdHo/V7IAKJwBiyrmUf
	cNZZz/gxe/Gvo61S6NrbKj92qV8Di75TiiGc7YG4HdHJMEA7apa0bm3bg5vJ6otWAZrUJDP4G3Il1
	9cDb/hYg3MLGSmCoHFPCROaaUPWgTDmgGX+uelclG5rHFtCqCd3T+dnWqTpqLNsgMvSp/8w8vis9T
	jRx9WfIyFtEQ/uKGAUcw9D+LiKHp9wKnXWhRump5Xm6EIzWx/N0jTUUNtgqqz1rBBn79oRZgjmOE8
	c8MhreBg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wRByu-000wEz-0N;
	Sun, 24 May 2026 16:47:16 +0000
Date: Sun, 24 May 2026 09:47:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev, jlayton@kernel.org, axboe@kernel.dk, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] fs/pipe: pre-allocate pages outside pipe->mutex
 in anon_pipe_write
Message-ID: <ahMYl8ExhnSudJ33@gmail.com>
References: <20260522-fix_pipe-v2-0-a8b35a78244e@debian.org>
 <20260522-fix_pipe-v2-1-a8b35a78244e@debian.org>
 <ahHVM9hCP65hH82S@redhat.com>
 <ahMK_mWcooqrd9Hc@gmail.com>
 <CAGudoHEPj-aOxqBsh5y4JFfONLnZfzgw_UUs5hqK6BpBcgHO5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEPj-aOxqBsh5y4JFfONLnZfzgw_UUs5hqK6BpBcgHO5Q@mail.gmail.com>
X-Debian-User: leitao

Hello Mateusz,

On Sun, May 24, 2026 at 04:48:14PM +0200, Mateusz Guzik wrote:
> On Sun, May 24, 2026 at 4:30 PM Breno Leitao <leitao@debian.org> wrote:
> >
> > On Sat, May 23, 2026 at 06:26:27PM +0200, Oleg Nesterov wrote:
> > > > @@ -566,7 +661,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
> > > >              * after waiting we need to re-check whether the pipe
> > > >              * become empty while we dropped the lock.
> > > >              */
> > > > +           anon_pipe_refill_tmp_pages(pipe, &prealloc);
> > > >             mutex_unlock(&pipe->mutex);
> > > > +           anon_pipe_free_pages(&prealloc);
> > >
> > > Do we really want to call anon_pipe_free_pages() at this point?
> > >
> > > The main loop will continue when pipe_writable() becomes true again...
> >
> > I went back and forth on this. The argument for freeing was that
> > wait_event_interruptible_exclusive() can sleep arbitrarily long (slow or
> > stopped reader), and holding up the prealloc pages felt antisocial --
> > especially under the memory pressure this series targets, where those pages are
> > more useful on the freelists than parked on a sleeping task.
> >
> > On the other side, on wakeup the loop is guaranteed to want pages again, and
> > re-entering the allocator under the mutex puts us back in the contended state
> > the patch removes. For any write() large enough to wait mid-syscall (which is
> > the workload patch 2/2 measures), keeping them strictly wins on throughput /
> > p99.
> >
> 
> You can still prealloc after wakeup for whatever reminder you got
> though, but I can agree dropping these frees is a sensible way out and
> it is easier and I'm not going to insist on one way or the other.

Ack. I've sent a v3 with anon_pipe_free_pages() and
anon_pipe_refill_tmp_pages() dropped.

> However, I think it would be prudent to add a tracepoint to some
> machines on your fleet to find out how often they allocate pages under
> the mutex (and for what i/o size). Initial alloc for the first write <
> PAGE_SIZE definitely happens under the mutex which is probably not a
> problem, but for anything later? 

> The tracepoint can have a trivial
> indicator if this is the first write if that matters. One can

Isn't this what I've reported earlier?

https://lore.kernel.org/all/ag3Ty3T24wjn1aFw@gmail.com/

Adding a tracepoint is harder than usual, given kernel rollout takes ages.

But I hacked a bpftrace script and ran it on a random sample of fleet hosts (5
min each). 

As reported earlier, multi-page pipe writes are not uncommon: on one
host a single long-running process produced 196,476 under-mutex alloc_page()
calls in 5 minutes, with allocs-per-write distributions reaching 16+ -- exactly
the pattern this patch removes. 

Most hosts sit at the boring ~20-30 allocs/sec dominated by one-page
first-writes that the patch's `total_len <= PAGE_SIZE` early-return skips
anyway, so the win is concentrated on the workloads that actually need it.

None of the allocs hit reclaim during the trace I ran, but I would expect
direct reclaim to happen with the lock held.

Thanks for the review and direction,
--breno
