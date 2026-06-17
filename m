Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EED3B95F8;
	Wed, 17 Jun 2026 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691860; cv=none; b=Fa0bgFbXUgUq6kmd67kvb+SpIkkyu81hDu1ZgEB3zTl7o1xrIWjPhz5JM6jakQHDn/A48DHZsw6QffvDfgPRTpwUiro8OG2P6aesWI3pK8PSfpfnyY/pygkB35u6B/MN3yuE0xiPWF8BCAVQkJEQW/MmI5n6gJAZLkjrAlmXe00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691860; c=relaxed/simple;
	bh=RBjZ+xKgnYCukmvql2bhRtb5M3XjwEAV+EY1WqzzMjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCd6gGLFgriKGDKePqUxc5nQP2/bRy5hiqT/rbqoPqolvuFpZlwKhlQ03+CHTub0t/nYvFXsaEy/M1cEQVzk3auKxbZZQJ77V9Hl2zg3lvWUZEg9fgqJOvZirHJPcl6rtYy2ARDwTLPohWO7ibChZl6+N/10zpY0JZ/hhZgtvBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NDWo+zYh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NDWo+zYh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QWmxyRB2DXwUpHN/BGvJF4UVPz/NFDw/d+t0YjnWzGg=; b=NDWo+zYhmh4Zu3urJKliPrU7iL
	rCbc7tMjsoEnWH1HZS38OLGVAxHUXY3sO6LHfmWgo0JEFZ6VQy1M1nOcZZ1PZp6p/QsWmao9aZmD+
	AQLSxXEACVIA9008HpO2J0KeIMiG1vemw05bI45+OJK9TZt9cQVtRbWLKyw6SXaH3MOSmRRj+KNUB
	yAYubcnwCe3Nj167GcWguKDYg8/8WyoJC154ItBmZEZ7bR5NLffhxC6vYf9ArrVcmogkSptC1kbHp
	KYDfcmztybYNy+ZwWf3oYV7GweujbLeoCvK6hcR7f1A1xyqPr9CPNh4Wx8JrCp21Ya5hZESeNSpXg
	YZoK7BvA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZnR9-00EYDO-0L;
	Wed, 17 Jun 2026 10:23:59 +0000
Date: Wed, 17 Jun 2026 03:23:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Josh Triplett <josh@joshtriplett.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev, 
	jlayton@kernel.org, axboe@kernel.dk, kernel-team@meta.com
Subject: Re: [PATCH v3 0/2] fs/pipe: reduce pipe->mutex contention by
 pre-allocating outside the lock
Message-ID: <ajJ1Xi1p9UhQvILi@gmail.com>
References: <20260524-fix_pipe-v3-0-bb4a75d23a90@debian.org>
 <ajG2bmhu6j9UWvh4@localhost>
 <ajJgWBCFYwz9OIo3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajJgWBCFYwz9OIo3@redhat.com>
X-Debian-User: leitao

On Wed, Jun 17, 2026 at 10:52:40AM +0200, Oleg Nesterov wrote:
> On 06/16, Josh Triplett wrote:
> >
> > On Sun, May 24, 2026 at 07:44:57AM -0700, Breno Leitao wrote:
> > > This series pre-allocates pages outside pipe->mutex in
> > > anon_pipe_write(): for writes that span more than one full page, up
> > > to PIPE_PREALLOC_MAX (8) pages are allocated via a per-page
> > > alloc_page() loop before the mutex is taken. anon_pipe_get_page()
> > > then drains the prealloc array first, falls back to the per-pipe
> > > tmp_page[] cache, and only enters the allocator under the mutex for
> > > the leftover pages (writes larger than PIPE_PREALLOC_MAX, single-page
> > > writes that skip prealloc, or shortfalls when the prealloc loop
> > > fails). Leftover prealloc pages are recycled into tmp_page[] before
> > > unlock and any remainder is put_page()'d after unlock, keeping the
> > > allocator out of the critical section on both sides.
> > [...]
> > > I also vibe-coded a microbenchmark to validate the change. It sweeps
> > > writers x readers over {1,2,5} x {1,5,10} with 64KB writes against a
> > > 1 MB pipe and prints throughput + latency percentiles per config.
> >
> > How do the numbers compare with 1-byte writes/reads? (It's fine if
> > they're not *faster*, just want to make sure they don't get any
> > *worse*. This case comes up a lot with pipes used for synchronization or
> > event reporting, such as with make.)
> 
> Note the "for writes that span more than one full page" above. Pre-allocate
> does nothing if total_len <= PAGE_SIZE.

Exactly.


The pre-allocation only triggers for multi-page writes:

anon_pipe_get_page_prealloc() returns immediately when total_len <= PAGE_SIZE,
so a 1-byte (or any sub-page) write never enters the new path.

anon_pipe_get_page() then falls through to the existing tmp_page/alloc_page
logic exactly as before; the only added cost is one length check and a NULL
prealloc pop, both trivially predicted.

Measured it to _just be sure_, 1-byte ping-pong (perf bench sched pipe -s 1):

    baseline:  2.674 usecs/op
    patched:   2.710 usecs/op   (+1.3%, within run-to-run noise)

--breno
