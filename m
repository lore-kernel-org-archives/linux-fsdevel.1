Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0889C3C1D6D;
	Thu, 30 Jul 2026 14:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785421613; cv=none; b=DWceN1gaCd88jFNVmT0v8eV2GWAur8Qgas9LnxCa7HYJEVGumsZ6tVUlJ5E1qcf+uGRj+ngyXMr/MnacycvXc6Uj4LgTZAsvGIKQgg8neqFp83a9ncPCoZnJ9YjCqCsgKWYAnM+SHPB6tiZecJDG4eLFIDP/z6zfGYmKBRYP/vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785421613; c=relaxed/simple;
	bh=b5TiKsW5AkRlF6O/gznXQZh8OcATMzwvqBWvIAVhbRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAAM+M7WUf3r3a3TWdmbLw6GEtVy3m/nakXWgKReTN+jyF6Une8MqMS5oACzal0k3HzRmeCpNHbBK0KLP/4QYIFzGP4ugcupBszs0heiLmS9YYvlws/+asDhII/J+ZJFtgbJRAqwFBZQ2uw1Ggwgrt++AIH8Lg1yAl4HjzD9CCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ZOwxyEph; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ZOwxyEph"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TcS7pDE/0sndIAUGKG+bEp6lmmW1jQXuF06nynRMhFc=; b=ZOwxyEphIAjEV0Q7rXxfGYGZ4h
	6SyvCxqwUtGptFXHnggHHmYixGMPDM7i2I4ANHiDoRH6UFfUdQuuizvVfS4jRcqVE8cXcWwwRjx/k
	WeoD+MLmsubAL6PlKfAlSeaQkM2GyNuvrb1wlRKwlJTBfYqj6jAvt0K17jJ2UbreLSHalWPt0sv2Q
	fG2Er6EIfgrcMC6u9WElDDJKulwOfSyAluYvcdH8LEFMakd5WoIzHwavmdxNeCgSsQ25yWqpmQy0P
	CUE6u+YhBeekUBDacEEMZbE67pfOh2TiE6aSdNy2bvVw1NryJHQfNF5DgUX8iBsBg3AKwLJlRy4pm
	KLREnp/A==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wpRia-009Irb-0C;
	Thu, 30 Jul 2026 14:26:42 +0000
Date: Thu, 30 Jul 2026 07:26:35 -0700
From: Breno Leitao <leitao@debian.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Alexey Gladkov <legion@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org
Subject: Re: [PATCH v3 1/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
Message-ID: <amteY30qxRuPzFh3@gmail.com>
References: <amtbpwrhlNGJ9OK6@redhat.com>
 <amtbxpqJ3pZwyT8D@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amtbxpqJ3pZwyT8D@redhat.com>
X-Debian-User: leitao

On Thu, Jul 30, 2026 at 04:12:22PM +0200, Oleg Nesterov wrote:
> pipe_poll() unconditionally sets poll_usage on the first call, forcing
> anon_pipe_write() to wake up readers on every write even if the pipe was
> not empty. But this is only needed for edge-triggered consumers: epoll
> with EPOLLET and io_uring without (unsupported) IORING_POLL_ADD_LEVEL.
> poll() and select() users pay for it for no reason.
> 
> Rename ->poll_usage to ->poll_et to make the purpose clearer, update the
> comments to explain that io_uring depends on the "nasty semantics" too,
> and change pipe_poll() to set ->poll_et only if wait->_key & EPOLLET is
> true; this check should catch both users.

This look great at first sight, thanks!

> @@ -760,9 +759,11 @@ pipe_poll(struct file *filp, poll_table *wait)
>  	struct pipe_inode_info *pipe = filp->private_data;
>  	union pipe_index idx;
>  
> -	/* Epoll has some historical nasty semantics, this enables them */
> -	if (unlikely(!READ_ONCE(pipe->poll_usage)))
> -		WRITE_ONCE(pipe->poll_usage, true);
> +	/* Enable edge-triggered (epoll, io_uring) per-write wakeups */
> +	if ((filp->f_mode & FMODE_READ) &&
> +	    wait && (wait->_key & EPOLLET) &&
> +	    unlikely(!READ_ONCE(pipe->poll_et)))
> +		WRITE_ONCE(pipe->poll_et, true);

Can I ask you to factor this out set code, and comment this nasty
semantics in the function and why we need to do it?

Tha would help to make this corner case more visible for readers, other
than hidden on commit messages.

Thanks,
--breno
