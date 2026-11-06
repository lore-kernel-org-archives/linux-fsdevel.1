Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963486;
	b=B0kXT4MlLvuBKsC39KKkvJ7hbsISkwLRtZ6eH/wO/p8btpKw9tYSlmNowtGD/OHf7oOl
	 zmjMsF3jix5bSB2J3VbtZ3AcsG9uaXtE5gsmMsJ2ZFxX+1h6ZB3uwU7oIPSjHeMkNGl8O
	 XFUk+oF9mylKYWGYHSyoR0lWtczjyVJiXzrXzS7vw1aJ8WNc9rYN7rEsSsUVgh+z9Jdss
	 KNtiKQeX6Zk3I+x5GBzuLso8bQVEkBq/p363Sgo9vmZOYiqwZM4QcH541f7xTkY982hz3
	 SRtJB7z/HDHkftQWfgD+9u/+twIxiRySdOdPjStmNUGuwoiy3Lx2f4xOhp61QDsyBUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963486;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Debian-User;
	bh=AuFxEXPAYsp+N5j29FDM6Sk7erK7vo72BA6vE8/tGgc=;
	b=JK74Ywub9rhIV7Uz+qplupVL2MHKe4YKT2BMRzPJKatzAN0KshyBXlA5Awx8F9qlx8oB
	 6dkGMZ/EqqE1VEpX0BEpdQFc/nL1d6ZDxDjMvYLjhiizPFpM/uobDfcvZRXWsnb5o4lTw
	 zU1ClbK5h1TzGqVdHbAcSrSPwrfKSrXy0vbyDhSsZpZgl4hcUejlbrY8iPPenOqagiVS6
	 BvfI6zBbwFt1t9j81T+lfq5x8h9RuezPOTprHzJSfgvbYs6oBHgUX2KbyI4rViRH1ADSl
	 F/ketbTv1r/hpfi/tjuq1DaOqOU0Y2pzpLe1QogsiFJv10PsfbTeE4uAJCqlVhlofqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=uMGAgYQA;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F23606A32F;
	Fri,  6 Nov 2026 11:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6F23606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=uMGAgYQA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=AuFxEXPAYsp+N5j29FDM6Sk7erK7vo72BA6vE8/tGgc=; b=uMGAgYQANtuQKhq195eAtXdwqQ
	3YbROkQxjTERFFXO7rspff9yZU3mHsw7eW121bQTjhNqux4UCXVWvCXrbYDA0RwP3u3WSJrvF/t3K
	iMzm2u4P68ELRHmJvXiYFCHbap0eYkRC/vo+VCXA+qt82El6n41KD2TA4zwNcFli+5xsAGUFWn/nc
	G+oYwIv2rHBswc9kgTx4Q+SjUjzYVHQ0k54tkF+2mBhUMFC36WEM1amm5d0VOgFn0uRodtF1PR8Cj
	7CQvW/3PvWTY/kse5UBImwwXfijLcyhGWCHRby5Tdepzzkxw81gdLkOMUvYNJXwfVZ04kRfDr/+3U
	BhkJOAdw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xPHqo-009F2k-2d;
	Fri, 06 Nov 2026 11:11:19 +0000
Date: Fri, 6 Nov 2026 03:11:14 -0800
From: Breno Leitao <leitao@debian.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	kernel test robot <yi1.lai@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [linus:master] [fs/pipe] f7f4665dc5:
 lmbench3.PIPE.bandwidth.MB/sec 18.5% regression
Message-ID: <au2vjpu_yqNa83pN@gmail.com>
References: <202611041404.befe64cd-lkp@intel.com>
 <20261105-trommeln-einspannen-radius-ccb4e174e407@brauner>
 <auygOHcuBba_o132@gmail.com>
 <CAGudoHFpNbxL13ZOWiyyLSPpmzXcB=e=RBZ8ZGk+Oc58Aad9pA@mail.gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFpNbxL13ZOWiyyLSPpmzXcB=e=RBZ8ZGk+Oc58Aad9pA@mail.gmail.com>
X-Debian-User: leitao

On Thu, Nov 05, 2026 at 04:57:33PM +0100, Mateusz Guzik wrote:
> On Thu, Nov 5, 2026 at 4:28 PM Breno Leitao <leitao@debian.org> wrote:
>
> The test at hand has multiple readers and writers using the same pipe,
> with 64KB i/os.
> 
> Prior to the patch each writer had its own private pool to draw from,
> guaranteeing no allocation will happen under the mutex.
> 
> With the patch the reader exit also drains the pool.
> 
> As a result tons of allocation ends up happening under the lock again:
> 
> -   94.88%    94.88%  bw_pipe          [kernel.kallsyms]     [k]
> __alloc_frozen_pages_noprof
>      94.88% __internal_syscall_cancel
>         entry_SYSCALL_64_after_hwframe
>         do_syscall_64
>         ksys_write
>         vfs_write
>       - anon_pipe_write
>          - 47.46% alloc_pages_noprof
>               alloc_pages_mpol
>               __alloc_frozen_pages_noprof
>          - 47.42% anon_pipe_prefill_and_lock
>               alloc_pages_noprof
>               alloc_pages_mpol
>               __alloc_frozen_pages_noprof

Ack, this matches what I found as well. Thanks for investigating it.

Because the preallocated pages are not private to the writer anymore,
the reader flushes them while the writer waits for room in the pipe,
and the writer then has to allocate them inside the lock.

This basically loses the wins[0] from commit 212ed884a1aeef ("fs/pipe:
pre-allocate pages outside pipe->mutex in anon_pipe_write") for this
specific scenario.

> I don't think multiple high-volume writers vs multiple high
> volume-readers is a realistic scenario and I would not bother fixing
> it.

Agree, but I would like to spend some cycles on it.

> However, should someone want to address it, I think the patch should
> be reverted and the resulting state tweaked. The patch at hand came
> after the mutex is released -- the kernel prior to any of this would
> still put_page on the reader side under the lock. This bit would have
> to get tweaked to recover the loss in that scenario (not to be
> confused with the loss reported here).

We can revert the patch, but that would bring back the two page pools
(the on-stack prealloc and tmp_page[]), which is probably worse than
this regression itself (IIRC it would also lose the gains for smaller
writes (about 20% for 8-16 KiB writes IIRC ))

That said, these are the items I am planning to spend some time one:

1) Reclaiming the pooled pages from a shrinker, as suggested in [1]

2) Trimming the pool gradually on the reader side, instead of cutting it
   down to two pages in one go. Or not trimming it while a writer is
   in the waiting room (!?)

3) Keeping the writer's preallocated pages private again, while keeping
   the unified pool (i.e. without bringing tmp_page[] back).

4) Freeing the pages the reader drops after releasing pipe->mutex,
   instead of under it, as you suggested. This is independent of the
   options above.

5) Longer term: copying the data into the preallocated pages before
   taking pipe->mutex, so the writer only links them into the pipe
   under the lock. This doesn't seem trivial, but it would make this
   whole pre-allocated buffers go away

6) Any other idea?

[0] https://lore.kernel.org/all/202607091015.c3936260-lkp@intel.com/
[1] https://lore.kernel.org/all/CAGudoHGKyN6k+eSAUm35_WDSZcxxtm4QL6fO+4rYJTvtObMqzA@mail.gmail.com/

Thanks for looking at it,
--breno

