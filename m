Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBB03E867F;
	Mon, 20 Jul 2026 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541926; cv=none; b=Q4PJ1T7oq0Js/5TdbLuAc7dk91PbOrIAmF4RZIqiWRQ9ROmhrzbfGZgvCmn0/LQ/Zht9eGXobUpnbVmQmDMQ7hJsYQAAzPub334GCw51BLUtpwbPVE7SRQ+d3CbuQnVw0cTLR1LlI4l5Zz05cW2kBpLTqfWXp6ZzOqQmTb2KFzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541926; c=relaxed/simple;
	bh=wD1Jx7pkUopUVo27Qt9g8r3fP0ONiFiVL7jT3VrkxyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WN2L/E2fd4tftPgJYI/DoLq5VZQNsnCepDJsKQS+QC6YZOmH8zFoqYpP/NcaMdxgfhkNy6GgfD2aTR/hpDzwUwFrNHpCXre2QDdflDu6cNthJ006fgao305C2EADaRLgRgst7FmeZotY5jRtKUb4AK0RIMKrReuZ3gE/j4KiY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=tc+So9vc; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="tc+So9vc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JaGO2OIoMNU7813yNKraQCSkiqSZV1dC/XAiltTJLrM=; b=tc+So9vchomCeXXpU/vuFYucmC
	gbaXPWqFav5J/GVuE363nhp6UulYrpGgOVdJbxVVti9/eFKuF04XMsscGWqmnULssri1uLHkFtaJV
	Zk6EW7jl61H/1OhcJbI9FYAVW0A3mP3zCSauqq4SkViBSVC1xicwc5nQPdaKpu3FPM7oVJdhRG+uR
	I/sIM+Yn6GFJyutgKt8+Y4RdfGlGPL4syINtVlDhBbciQbtIHOfpVnzj4rKaAsWHZLDYWyGD2hHPq
	gmgYcJn0O9xPBVPsP9cV0bOS1wkAbBT+wg6ou2SSwGEBMe91Gx4Hj6Vmn50bph2ghzWaR0mSCaMsF
	lV69nw4w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wlks0-001MQ6-1U;
	Mon, 20 Jul 2026 10:05:08 +0000
Date: Mon, 20 Jul 2026 03:05:03 -0700
From: Breno Leitao <leitao@debian.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, mjguzik@gmail.com, josh@joshtriplett.org, 
	Jan Kara <jack@suse.cz>, jlayton@kernel.org, axboe@kernel.dk, shakeel.butt@linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4] fs/pipe: unify the page pools into a single per-pipe
 pool
Message-ID: <al3w54SsdZEjKVj4@gmail.com>
References: <20260710-b4-pipe-unification-v4-1-ff31c39f1c16@debian.org>
 <alpWISUKMvqrp5ET@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpWISUKMvqrp5ET@redhat.com>
X-Debian-User: leitao

On Fri, Jul 17, 2026 at 06:19:45PM +0200, Oleg Nesterov wrote:
> I personally like this change. To me it really makes this logic more
> simple/clear.
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Thanks for the review.

> > +static void anon_pipe_prefill_and_lock(struct pipe_inode_info *pipe, size_t total_len)
> >  {
> > -	unsigned int want, i;
> > -	struct page *page;
> > -
> > -	prealloc->count = 0;
> > -	if (total_len <= PAGE_SIZE)
> > -		return;
> > +	struct page *pages[PIPE_PREALLOC_MAX];
> > +	unsigned int want, have, need, n = 0;
> >
> >  	want = min_t(unsigned int, DIV_ROUND_UP(total_len, PAGE_SIZE),
> >  		     PIPE_PREALLOC_MAX);
> > +	/* Unlocked read; the pool is refilled under the lock below. */
> > +	have = min_t(unsigned int, READ_ONCE(pipe->prealloc.count), want);
> 
> And READ_ONCE() is enough correctness wise.
> 
> But AFAIK it is not enough to make KCSAN happy. anon_pipe_prealloc_pop/push
> which modify ->count under pipe->mutex need WRITE_ONCE() to please KCSAN.
> 
> Or anon_pipe_prefill_and_lock() can use data_race(READ_ONCE()).

I am not sure that is correct. I got the impression if the reading side
has READ_ONCE or data_race(), that is enough to please KCSAN.

I've also run a test with this code, and KCSAN doesn't show any complain
here.

The only complain is coming from osq_lock(), but not from here. This is
the osq_lock complain:

 BUG: KCSAN: data-race in osq_lock / osq_unlock

 write (marked) to 0xff11000527a42f80 of 8 bytes by task 1366 on cpu 23:
  osq_lock+0xf4/0x270
  __mutex_lock+0x1ab/0xe70
  mutex_lock_nested+0x17/0x20
  anon_pipe_read+0x69/0x570
  vfs_read+0x3e3/0x4b0
  ksys_read+0x95/0x120
  __x64_sys_read+0x3c/0x50
  x64_sys_call+0x69a/0x8d0
  do_syscall_64+0xfd/0x4f0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

 read to 0xff11000527a42f80 of 8 bytes by task 1363 on cpu 20:
  osq_unlock+0x14c/0x1a0
  __mutex_lock+0x1dd/0xe70
  mutex_lock_nested+0x17/0x20
  anon_pipe_read+0x451/0x570
  vfs_read+0x3e3/0x4b0
  ksys_read+0x95/0x120
  __x64_sys_read+0x3c/0x50
  x64_sys_call+0x69a/0x8d0
  do_syscall_64+0xfd/0x4f0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

 value changed: 0x0000000000000000 -> 0xff11000527bc2f80

that said, I think it makes sense to mark count as racy, given it is
read without a lock.

I will respin with, an additional "__data_racy" attribute in `count`

  struct anon_pipe_prealloc {
    struct page *pages[PIPE_PREALLOC_MAX];
    unsigned int __data_racy count;
  };

Thanks for the review,
--breno
