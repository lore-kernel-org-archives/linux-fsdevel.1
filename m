Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E950437E310
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 12:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787746539; cv=none; b=HkkUX6ou1BFu516Al3PYrefEWFCh8WHN1RgzCRw5FYc+p+BXg+CqYRHIaOajJjPjZQvoV7mZoaoNqyb7fBIxX2kW7ipRg4fwKyDQwYMUWaCkBrQX36OO5+IlstrKdVmtDgnEICQBl2kz49hB5etNb/qtRUdR3GnAZJPO/38EOBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787746539; c=relaxed/simple;
	bh=03b17l40P19AmnkdlUjJg6hSeCyn7Vd0mcxsZEuKXYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFRnu14GxkngD+XHY0Cj22uFE9Mdw2z76D4MZt9FESAm7gFGKope83CQODByyuGZKbqpczApPZ2Et8n8mBMoPZ494TDTdzqSKDA7vRrsk9T7efqa761YGyAJNh4sk6EIhAj6yM+ZyPpxbrmvngjlQQ8Qt8q8kwwkSKnXfNOHwlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIPezDup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIPezDup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F3F1F000E9;
	Wed, 26 Aug 2026 12:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787746538;
	bh=Yfc0iMEJiP068bcbzwvZo4oznkgaHLsEMGiv3jUtZig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VIPezDupxCnTj45aGE/2o6ZosP3r4qYh8do24XzZJqAEnAFnkBooJPWVhViBPiwY6
	 QtfqdPv6NRhBEeCldKlwZhV1b8Ln9qXx5h1RPMALT6i4qzPnvOQyz+94S2jdoXP3+C
	 KdeaFRogglcICTHk0EpLiQ+7H7YNQhxEiKxnsKTmjZAsxblI35Gtu0bB0kuJy5uDGB
	 nTwBVGZEV5v81cpiLCKwhQM9cXopuiBYcDzLlzIHZURNbc4NrdY5yHaAnxGqR/yq7+
	 RtEGfTkRpMEuvVzEip73yk4v4b065HSTLFXI3mQBr9e9hViH1EgpTP8gAydxoEAVN7
	 nTm5iqwKRwt+A==
Date: Wed, 26 Aug 2026 14:15:33 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
	Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH RFC 0/7] coredump, files: exit files on request
Message-ID: <20260826-gastdirigent-nostalgie-matschen-af4915e3d9c9@brauner>
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

do_close_on_exec() runs under cred_guard_mutex and would introduce new
lock ordering. So dropping should move out from under that mutex which
introduces additional complexity.
