Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF4F3783B5
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 07:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787727767; cv=none; b=njCE8LC0/p7JxSyZCbfk9Z7QLD7EIBEUtcolQcPxkFOAB31Bj8S7ybRhJIP5AtV+32m7RlUF8P1wiAY4nEFBebVxvjt7Mj8B4sh8dl6CYroW3yM7nOvt2j82teprZxg+KORrRh074VEuttrhBK/I4h622MCC+FRUH4pQXFMMZEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787727767; c=relaxed/simple;
	bh=0Tfg4sFTUO+lpjC84zmdj92j/sIno9gUBkKCgE111hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ny9uu8zLRdU9yfSNqu2StKzFYq9LhopNITXdocyZu33uJM5VCLYVKooe0/2dPpTqTvUhR5ymbMp5NHN5K3PmRvq2O3LflSDg94EqNPE2MADXSmLjQpjNJ42ibnSSBgk435vNGyh1vdbmQPqZ7Y4X5MOXNynysI98BcdrnzyOrp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uxgh9BI/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uxgh9BI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433C41F000E9;
	Wed, 26 Aug 2026 07:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787727765;
	bh=hzZTyB7yGKO/sWKlh7vz090KEZwWOL2eLxo2ZRvAPRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uxgh9BI/McP60AqYTwZ7q3jaZ7S/jIS+cUrTsWwN2XeY6maerFu6sdpFX+Aep+9Sj
	 5jwMT1KIikJml9KdKyACEXHmJ8ccx1DeAlOi8UIceeek8hNkTT7SpELNwVK//cIpXw
	 U0yl5i4+p0ZTymyH2M2LfZeE68ScHW4UyeXjUvUIdFgVvgIQ4iJ2EI3EhNhR/T8ZN0
	 qtIXaBl8p3Z9Hv/bpYlNz93/SiTwqfb5xyL5NLnH56JnYfdd4Vbt/vk+IABNJQj+5q
	 WLE8A4r++6ufx6Gxz4opQ2vhebiKuYFCGS8bojgfyIdTBR4Ge3mZnpxwkB9uEoI3lK
	 fqekOygyIVJww==
Date: Wed, 26 Aug 2026 09:02:40 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC 0/7] coredump, files: exit files on request
Message-ID: <20260826-stauen-liedtexte-gesell-b88d4d43f352@brauner>
References: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
 <CAGudoHEsGP1P+sAWaw_tbh1NesJhSeww8869uzmaqtgk8F43=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEsGP1P+sAWaw_tbh1NesJhSeww8869uzmaqtgk8F43=Q@mail.gmail.com>

On Tue, Aug 25, 2026 at 10:54:44PM +0200, Mateusz Guzik wrote:
> On Mon, Aug 24, 2026 at 5:28 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > We've had quite a few proposal for exiting files before generating the
> > coredump (see [1]-[8]). The various proposed solution were quite
> > unacceptable. So I took some time to look what a _remotely_ acceptable
> > version of this could look like. Here it is.
> >
> > The first patch is somewhat unrelated but without it the code would have
> > to become so ugly to the point of being unacceptable so it's a stylistic
> > prerequisite imho.
> >
> > In the first patch we make exit_files() synchronous and stop shunting
> > all files onto task work only to run task work right after. For tasks
> > exiting with a very large file descriptor table this means getting rid
> > of _a lot_ of cmpxchg()s and hammering on task->pi_lock. The cost of
> > this was mentioned in various threads over the years. I found at least
> > recent comments by Oleg and Neil.
> >
> > So let close_files() close right away. No locks are held, the path
> > already sleeps, close() does the same thing already. Kernel threads can
> > just keep deferring. ->flush() and ->release() now run before exit_fs()
> > and disassociate_ctty() which should be fine.
> 
> I think close on exec handling could use the same treatment.
> 
> >
> > The other half is adding support for coredumps to switch to an empty
> > file descriptor table before generating the coredump. That requires a
> > bit of synchronization but I think I got the basics down.
> >
> > A new COREDUMP_CLOSE_FILES extension that allows a coredump server to
> > request that the thread-group close all files before generating the
> > coredump.
> >
> > The coredumping thread allocates a new empty file descriptor table. It
> > then wakes all threads in the thread-group and tells them to switch to
> > the empty file descriptor table and get rid of the old one. They report
> > back once they're done.
> >
> > So that handles most cases where locks would be held for an unreasonable
> > time until the coredump is generated but since files can be shared
> > between completely unrelated processes that's not a guarantee and we
> > can't give one. But it solves the reported issue without resorting to
> > even grosser hacks.
> >
> 
> I find this rather unsatisfactory. What if a coredumper *wants* fd
> info and does not want to stall userspace on file locks? Sooner or
> later someone is going to show up complaining about it.
> 
> I proposed merely dropping all the locks early, which on its own
> should be easy to implement. I have not checked how fd reporting is
> implemented, it might be there is no way to convey what locks were
> held in a backwards-compatible manner in which case plain early unlock
> might be a no-go.

I don't understand how it would even remotely be safe to drop locks
before we've called into ->flush() and ->release(). The only locks that
satisfy this requirement right away are posix file locks. Not even all
of them, just a limited subset.

So then we introduce a concept of "drop some locks" which might grow
over time. I really fail to see how this is attractive at all.

For a bunch of locks they will only be dropable in ->release(). So then
we need to annotate locks that are droppable prior to exit_files() and
locks that are droppable after it. Why would we place that analytical
burden on anyone? Coredumps alone cannot justify it. They can hardly
justify what I'm doing. The only saving grace is that I think having
exit_files() run synchronously makes sense given how it hammers on task
work. And then the coredump thing can fall out of it as a side-effect.

So I don't understand what early lock release buys at all other than
complexity. Without clear proof that early-lock release is elegant and
non-invasive I don't see why we would do it.

Exiting files early can be done cooperatively on the other hand and
it'll satisfy most use-cases just fine.
