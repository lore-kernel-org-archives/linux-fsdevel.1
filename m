Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9147C3DA7C0
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 13:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787751079; cv=none; b=nxVgZmfJa7HubrjiZpLg358KSNlkh28+gY4QNmCpM/Qs7Z6Zpv029rrHWKZWcTlkEMwOKvwnZFwGzf+vWjET4ptPkYGu3mQuF37JaHl8rk8e/W1iZTxhgp8N2IpTQlGIYAcXk7r6TrPN0xJG4qm0TOzss4OCix1qZhwNdUjeX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787751079; c=relaxed/simple;
	bh=aqm1M2kYvrgIuqhR0eA5HyQOASVNYMflM0cQdXv71Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVzWL3lATDMOLOWPLSQ1wrAutD9uawZxg/F3PHC9AR3DrHzyT2mEQpF/i+vs9D/5yGM6jbrDWcDOR4wFGVHwq0pKc4z4v4f8VsTeDhop+rGifx38eZewrL8vfGphh1Q0hjbDoC46U0aJPaDiueAj6xVHesxeVFItwr0UcqUemkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2ayRFqI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2ayRFqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84801F000E9;
	Wed, 26 Aug 2026 13:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787751078;
	bh=Mzy9mxaMzdHKUBM06TNQfp1a7NxfWbbO0OIpAePxWsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T2ayRFqIF5Eqx5uyy8ku+UPz8V9uZdrmiY4cTCnlMWC5/pFbd/MzhPBRxCHPPte6r
	 dM30jS15+Rsg4gLunlkX7dRkIoKMB2FVxWsTVfgBYc8TC2RtF+t7VMgNEBJBaAWX0J
	 is3wUvf+zPe+GdiolvXO8vV9vdFH0Yd2xrW1jUnw7Z4zVepGdsYAVt7TOo8IWHwq5P
	 NfWyAALn6YUN/lwIhXeqTg5ztdRtlItXUrNY9SfDu++cXn93+tSmn7RvplctQdodM0
	 VduNX9qPwTGfykMOd8aZ+vuws0aWfEDLUh4zPDzpKvC8OFGMrTcwQNzF4S/BrQT0Dd
	 662lnb/P5TA0g==
Date: Wed, 26 Aug 2026 15:31:13 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC 0/7] coredump, files: exit files on request
Message-ID: <20260826-esszimmer-dokumentieren-umklammern-db0be2646f79@brauner>
References: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
 <CAGudoHEsGP1P+sAWaw_tbh1NesJhSeww8869uzmaqtgk8F43=Q@mail.gmail.com>
 <20260826-gastdirigent-nostalgie-matschen-af4915e3d9c9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260826-gastdirigent-nostalgie-matschen-af4915e3d9c9@brauner>

On Wed, Aug 26, 2026 at 02:15:33PM +0200, Christian Brauner wrote:
> On Tue, Aug 25, 2026 at 10:54:44PM +0200, Mateusz Guzik wrote:
> > On Mon, Aug 24, 2026 at 5:28 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > We've had quite a few proposal for exiting files before generating the
> > > coredump (see [1]-[8]). The various proposed solution were quite
> > > unacceptable. So I took some time to look what a _remotely_ acceptable
> > > version of this could look like. Here it is.
> > >
> > > The first patch is somewhat unrelated but without it the code would have
> > > to become so ugly to the point of being unacceptable so it's a stylistic
> > > prerequisite imho.
> > >
> > > In the first patch we make exit_files() synchronous and stop shunting
> > > all files onto task work only to run task work right after. For tasks
> > > exiting with a very large file descriptor table this means getting rid
> > > of _a lot_ of cmpxchg()s and hammering on task->pi_lock. The cost of
> > > this was mentioned in various threads over the years. I found at least
> > > recent comments by Oleg and Neil.
> > >
> > > So let close_files() close right away. No locks are held, the path
> > > already sleeps, close() does the same thing already. Kernel threads can
> > > just keep deferring. ->flush() and ->release() now run before exit_fs()
> > > and disassociate_ctty() which should be fine.
> > 
> > I think close on exec handling could use the same treatment.
> 
> do_close_on_exec() runs under cred_guard_mutex and would introduce new
> lock ordering. So dropping should move out from under that mutex which
> introduces additional complexity.

Which is a bug in my patch as well. Thanks for pointing me to this.

-- 
