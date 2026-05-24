Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0568CE555;
	Sun, 24 May 2026 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779633061; cv=none; b=hDrGk4dge33fVzH7VS6ffC13E54pQVT2XwhLDWHRO9eL8TvYZzJlInEcXPZ7vNfTgUFhIBHSC6altOxD3mn7mkpXZKx0JzLUImPFmGOYxpeJyS/G6aKSUiIkP1E5MfJtfZsx9jYaSG0GohSgXOr2Dq+w8K8q2gfOv93zf2HhABM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779633061; c=relaxed/simple;
	bh=EqXX6HKjgXribic8+DPH33gfkjjjXRgcZRLxKC6BBdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuISnGBRh8Zw5Ef0uRfIQFFsKzd+0e6LitfTNAbRehXcXUDEHR3eRxW8ElFdfQcDJg0sDPM7i/VqHWhrTi1od12MDvUU6RSYMDfId48j2o6Vnn25Gqah9CjJaBzvdmckFb2SlKrLBdnd281OqIf/kw0zUXLN7un92cxyfgRCNLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=bAixKOj4; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="bAixKOj4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=82Ui9T3Tu+eCiHqcRTZrtWU/Y4rluFeKDUtaWUTxqiY=; b=bAixKOj45JvYK1x5g04wdWrqDu
	iSQi0Q30kHzVIP5t3mxEYtzKqFJZ1SFDlxw1wWTG2ARJpp1XvAgfu1S7NkS3kGKwIJxl0nTVJ6l6J
	qYGQkOfxpWM0G2p9KJyCn6fQZsWFGouYl+/tIg4lQaz8KeegKzvh7WDcVeCiahGPyUUJY5j3J4Fs3
	sxG+bGCvTUFSco2v0uj8l8pSLYi/+iIVCH2SZQ+pejISFP7SfMGI6IZg9YsTYUEgXEA8nyP7Kwpme
	00667vU2FjOGj8UzOvnw+AcxJm9q1bRNAqSUVITyTJmmuQq8upC3ukNmSlW4VbFjgUzXMyRUxzdAp
	UspK1O0Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wR9qp-000rb2-08;
	Sun, 24 May 2026 14:30:47 +0000
Date: Sun, 24 May 2026 07:30:41 -0700
From: Breno Leitao <leitao@debian.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev, jlayton@kernel.org, axboe@kernel.dk, 
	kernel-team@meta.com
Subject: Re: [PATCH v2 1/2] fs/pipe: pre-allocate pages outside pipe->mutex
 in anon_pipe_write
Message-ID: <ahMK_mWcooqrd9Hc@gmail.com>
References: <20260522-fix_pipe-v2-0-a8b35a78244e@debian.org>
 <20260522-fix_pipe-v2-1-a8b35a78244e@debian.org>
 <ahHVM9hCP65hH82S@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahHVM9hCP65hH82S@redhat.com>
X-Debian-User: leitao

On Sat, May 23, 2026 at 06:26:27PM +0200, Oleg Nesterov wrote:
> > @@ -566,7 +661,9 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *from)
> >  		 * after waiting we need to re-check whether the pipe
> >  		 * become empty while we dropped the lock.
> >  		 */
> > +		anon_pipe_refill_tmp_pages(pipe, &prealloc);
> >  		mutex_unlock(&pipe->mutex);
> > +		anon_pipe_free_pages(&prealloc);
> 
> Do we really want to call anon_pipe_free_pages() at this point?
> 
> The main loop will continue when pipe_writable() becomes true again...

I went back and forth on this. The argument for freeing was that
wait_event_interruptible_exclusive() can sleep arbitrarily long (slow or
stopped reader), and holding up the prealloc pages felt antisocial --
especially under the memory pressure this series targets, where those pages are
more useful on the freelists than parked on a sleeping task.

On the other side, on wakeup the loop is guaranteed to want pages again, and
re-entering the allocator under the mutex puts us back in the contended state
the patch removes. For any write() large enough to wait mid-syscall (which is
the workload patch 2/2 measures), keeping them strictly wins on throughput /
p99.

I think your read is the better one -- the throughput case is the whole point
of the series, and the memory-hoarding concern is bounded (8 pages per blocked
writer, freed in the out: path on syscall exit). Will drop the free_pages()
call from the wait branch in v3 and keep only the one after the out: label,
together with the nit from Mateusz.

Thanks for the review,
--breno
