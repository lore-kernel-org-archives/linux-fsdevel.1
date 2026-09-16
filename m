Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD004E66DA;
	Wed, 16 Sep 2026 11:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789558316; cv=none; b=JipExoyA2DMAyqigQO1TyGDnTHe5yK7rfk14xArOsj2Ojfi8aH1QuiB+ggAqqa+fhA1OgFclqmbkzA/HJjoI5GXF4z0xJcZK1lxBugI1ZQ27vU/bScnE7HJJdE0hP1k3LNhtMMv3MHA2tu5shDEyxqkfx170U6kmxEDn2AbiYtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789558316; c=relaxed/simple;
	bh=/7xUu+tQxvRYkB18Ci2jTevGk6dViy0TdeJvjYYUYQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vae1V0JvicjRw+6umucj3/ya8FCaHFKauuMJTu+M3e2Rrm7lVUAvOXpnpkyO+fviqvCspiBeoYXTs74Ann3ACcoCLkGRyiMQuW9IL1sra56SgGhauBLJUXbCjX0veHno/K3nKB0IK8/RRP/PKpOeBqgniLFIEaJekvcULAkvJgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vr6Gepak; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vr6Gepak"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/JOjSKLpdGlmtccb6dUYFdOouSYsesTs4yfuDEh7rgc=; b=vr6GepakwB6ZlK+gAXtx5UzAuD
	c3I3j3HoXXDJ3yC/M7DugkCtmCLpziz4IMnGYBq5uBy+x1Hovl3tvx4ttZinUT6uHjieT//cDbicR
	qgugZgvMtNHquoW19AEcmvVRDsiN8wWlVPHSywCLi0rpJA0EkXMdIkJpVBgz/bNSe7SCzEjWNmWzD
	3dbs6IEfLlZpeoXG/yDQsfDBrMFmtY/7YdCkiUuKsEeeQQmPAOGAKHuH8GT4TFNPUkRDXoQpZF3hn
	Pc5/lZUKNBNVr29Jwf+fzf6M8ajwP1qZj7WAHUkfHuIGvYOunY6CqN+XLRYi9OatWHwUrTvImdDRT
	Ii387DSQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x6nrS-0058Xn-04;
	Wed, 16 Sep 2026 11:31:34 +0000
Date: Wed, 16 Sep 2026 04:31:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, mjguzik@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] splice: pass a poll key when waking pipe readers and
 writers
Message-ID: <aqp9tGsFAFGJb8Pl@gmail.com>
References: <20260916-b4-splice-poll-key-v1-1-438a19351efb@debian.org>
 <aqp2CcOnuVEeRV8L@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqp2CcOnuVEeRV8L@redhat.com>
X-Debian-User: leitao

On Wed, Sep 16, 2026 at 12:57:13PM +0200, Oleg Nesterov wrote:
> While at it... I think they both should use wq_has_sleeper().

Good point, thanks!

> If you agree, feel free to send V2 with this additional change.

Sure, let's wait a bit more before I send v2, but I've got this fix updated
already to the following change:

	diff --git a/fs/splice.c b/fs/splice.c
	index 9d8f63e2fd1ab..65f9090c3438c 100644
	--- a/fs/splice.c
	+++ b/fs/splice.c
	@@ -177,9 +177,9 @@ static const struct pipe_buf_operations user_page_pipe_buf_ops = {

	static void wakeup_pipe_readers(struct pipe_inode_info *pipe)
	{
	-       smp_mb();
	-       if (waitqueue_active(&pipe->rd_wait))
	-               wake_up_interruptible(&pipe->rd_wait);
	+       if (wq_has_sleeper(&pipe->rd_wait))
	+               wake_up_interruptible_poll(&pipe->rd_wait,
	+                                          EPOLLIN | EPOLLRDNORM);
		kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
	}

	@@ -413,9 +413,9 @@ EXPORT_SYMBOL(nosteal_pipe_buf_ops);

	static void wakeup_pipe_writers(struct pipe_inode_info *pipe)
	{
	-       smp_mb();
	-       if (waitqueue_active(&pipe->wr_wait))
	-               wake_up_interruptible(&pipe->wr_wait);
	+       if (wq_has_sleeper(&pipe->wr_wait))
	+               wake_up_interruptible_poll(&pipe->wr_wait,
	+                                          EPOLLOUT | EPOLLWRNORM);
		kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
	}


Thanks for the quick review,
--breno
