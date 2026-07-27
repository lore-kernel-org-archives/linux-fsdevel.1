Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313DF3F86F2;
	Mon, 27 Jul 2026 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150392; cv=none; b=FDM4c+336oXSgVYHeBUiZ3itNmBmF7NnuTh1bQUzHlT6Hj0bO4UsOd7BacaCqBRFKMblOtpCW02gxxUBnuwIekArCHy2Gi3l3FCfNKcpldnBRSyepoog8+ZtTOABLBquRnCjMbtqtnfBZIRn6E7uqoUaq4Ow/s0cQE8j5Hj6dsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150392; c=relaxed/simple;
	bh=BuvNTJEAzRJjVzpBGBcs5YEdDfHG8Fz9tyGA4X/BxZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oalE6enLGcvaKSC4M0Qgz0S+7Y66O64d2YSb6lBlbpOMpjiH5CV/cdN0glNLf5ugNH2jlR3HKA8G91kXoiHwKSXo5+U2JmcAbBhwWloGtAvpBWL9nj8SOJjz9rjOPEmwMOGMAlHWPPuw+VnjxBTfIr9iCvEIsWHpUOavAg4X3sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=IaRL3lUG; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="IaRL3lUG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=chCId8DBjXZ2DbgcbMEVw5K5wgBXTC1JebbSZfh1+5s=; b=IaRL3lUGjgAudBSW0u1rpENIHd
	Y23fQmjV0RZjNdb2Luiu5qSiunDJArh1i9mYC45/kBApxb3hoyPoQHeBUKYaXgOqC54659DSC6uBm
	TwKtM1zjIJUDoafLcMQPSksYNRNaHY/1nbsfi9p+96XB+MGlhuIMiRR2Knv8ucRRVxdTnEMtIb63X
	m09QHc9AKEj7s09tPfSeCqpkEKnVz8cEqnAJhsZnH/jW4SCrum9f0U12b3HQk+5D1GmVFOz31KXUz
	GXz+/Ds/3vDSTATzlIrr9+FbNXuTAauaVE5CfU5FumevG91wWLtCg7lwTHlYyHOJRao4pdxPVJBRe
	UvHoBv1w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1woJA0-006qy5-1B;
	Mon, 27 Jul 2026 11:06:16 +0000
Date: Mon, 27 Jul 2026 04:06:11 -0700
From: Breno Leitao <leitao@debian.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Mateusz Guzik <mjguzik@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
Subject: Re: [PATCH 0/1] pipe: only enable the extra wake_up(rd_wait) when
 epoll is actually used
Message-ID: <amc4SXBOGmLbfmp3@gmail.com>
References: <amIqfCo25rLtM2U0@redhat.com>
 <amIu5WWgTNkdvqIz@redhat.com>
 <amNvebqiG2fH0W_L@redhat.com>
 <CAGudoHGiKYfF6L1yFy+QZgQaTt5ULnp6rgRaZE=6BANkpjrb7g@mail.gmail.com>
 <amN8ppPXRiUdiVKM@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amN8ppPXRiUdiVKM@redhat.com>
X-Debian-User: leitao

On Fri, Jul 24, 2026 at 04:54:30PM +0200, Oleg Nesterov wrote:
> On 07/24, Mateusz Guzik wrote:
> >
> > On Fri, Jul 24, 2026 at 3:58 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > This means that io_uring depends on the "nasty semantics" too, io_poll_wake()
> > > path should add the task work which calls io_req_post_cqe() every time the new
> > > data arrives, even if the pipe was not empty.
> > >
> >
> > well io_uring could set the flag as well in that case? it does not
> > inherently mean random select and poll consumers definitely need this.
> 
> How? I don't think io_uring can do this. It doesn't even know if the file
> is pipe or not. Only file_operations->poll() does know...
> 
> __Perhaps__ pipe_poll() could check something like wait->_key & EPOLLET to
> detect both epoll/io_uring... Not sure, probably not, I'll try to check later.

I got the impression that pipe_poll() sees EPOLLET in wait->_key for
io_uring the same as for EPOLLET epoll. Since d59bd748db0a
("io_uring/poll: disable level triggered poll").

io_poll_add_prep(), which is called before teh proper iouring command,
rejects IORING_POLL_ADD_LEVEL, so io_poll_parse_events() always ORs in
EPOLLET for IORING_OP_POLL_ADD.

The internal apoll path sets EPOLLET unconditionally too
(io_arm_apoll()), so every io_uring poll arming carries it.

Maybe this would work on the set side?

        if ((filp->f_mode & FMODE_READ) && wait &&
            (wait->_key & EPOLLET) &&
            unlikely(!READ_ONCE(pipe->poll_usage)))
                WRITE_ONCE(pipe->poll_usage, true);

--breno
