Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C103FDC03;
	Mon, 18 May 2026 12:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106836; cv=none; b=kssAH9jJzNHRmBI0I+rpyyvKvwuFIZThNWabEm6uUZyt/QAWozgZFkSApifuQfvIOL7f4B4M7mFnOiiHPsk6K1bwhA1ErnBCDNyAO0DQcX1/fWI57dQYqW2grjtipBA5wMv5JpzI5LFGnq/Pgxfk+QyjsJsvCoQHmz2BuHXB510=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106836; c=relaxed/simple;
	bh=POC8JGls3DaupySh0sWb7viRBrGG+Kdb6Eu3bd8CwkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2wDOx7qS9vxw3qqu7NJTGxuH00+uhEqQVXkGa9XiCsPaWIBCwjO+oF3RtcuSXX9bVSAevQ7i8vQg9NGGi4JquM5PzZ2DbVL8sZE4byeLBuC50nsX61OYIIdyYUfSL4AJEVyRp+SZPaRGG+/6FhNtowh9EFxWPjHTHwhreXTZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZgqvZVU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZgqvZVU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 728ABC2BCB7;
	Mon, 18 May 2026 12:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779106835;
	bh=POC8JGls3DaupySh0sWb7viRBrGG+Kdb6Eu3bd8CwkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LZgqvZVUn6NrJ4J9ZDuzva556yzBALb9cGtlBU+uk70dfyocLnbdjeAkH+hjxnPXh
	 CnAdTAf6sdIdOAm8XMfA7/3rgH2OOTIwSGKJEcrA9sjBVPZYkF/zXLWqHLwdSqeSfV
	 ClzTkB6+IZjpxJT4+NF+ppvWoJaSP1Y+KTw9F2XjW1+k10XiSeQuzpQBR3Rz8aGOYX
	 tJBLp13TW3Rr4XgXW2i95/ndbTXV+fjyY04QmCXVVihuST4JgRp2gJpRRo9fWZF/kg
	 +ZCZT8Mu+BU/uqD7IxJq5HX8WTkXHN5zS2yC+FhRizhrTbmvVDg2aVC9gMUNcafM5W
	 4pM+v1WRx/YBg==
Date: Mon, 18 May 2026 14:20:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [RFC PATCH] fs/splice: allow for a way to block splice() with
 read-only files
Message-ID: <20260518-starten-messdaten-3b8aa670ec85@brauner>
References: <20260516182126.530498-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260516182126.530498-1-pfalcato@suse.de>

On Sat, May 16, 2026 at 07:21:26PM +0100, Pedro Falcato wrote:
> Since the advent of vulns like Dirty Pipe, Dirty Frag, Copy Fail
> and Fragnasia, splicing a read-only file is fundamentally unsafe.
> 
> As such, as a mitigation, add a way for users to block splice() for
> files they cannot write to. This eliminates this whole class of exploits
> that use splice()+confusion in pipe/net/etc code to gain write-access to
> files they can only read.
> 
> Users can simply toggle fs.splice_needs_write=1 and suddenly splice() will
> refuse perfectly legal splices() from files it can only read, but not write.
> 
> For vmsplice(), make due with the address_space attached to the folio. Care
> is held to make sure the operation isn't too slowed down with locks. The check
> itself isn't entirely equivalent (the mapping's host can be the internal bdev
> inode, etc, and not the one in /dev against which permissions are checked),
> but doing it in a more correct way would require dropping from GUP-fast to
> GUP, and that would be too slow.
> 
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
> 
> Hello,
> 
> sending this out as an RFC so I can get better opinions from VFS & security
> folks upstream. I wrote this out as a way to harden against all the page
> cache attacks we've seen lately, that bottom out to splice() from a file
> they cannot write + confusion elsewhere on the net stack/pipes/etc.
> 
> This is _obviously_ not perfect and not complete. My first (unsent) version
> straight up returned -EPERM on splice() for these files. This one attempts
> to retain some compatibility by only blocking the page splicing operation,
> but still issuing the operation with normal copies (kindly suggested by Jan).
> vmsplice() is a complicated issue, because gup_fast does not allow us access
> to the VMA's vm_file. I tried hacking around it but it's not perfect (e.g you
> cannot grab the mnt_idmap for the file, since we only have access to the
> address_space + its host).
> I'm also not a fan of having somewhat hairy MM code in the middle of
> fs/splice.c but that's something we can simply hoist elsewhere as this gets
> un-RFC'd. It's also missing the external-facing docs for the sysctl.
> 
> My big questions are:
> 1) Is this a viable way forward?

I think that splice and vmsplice() are pretty wonky apis. Ignoring it's
recent prominent role in page cache attacks it suffers from weird issues
due to its interactions with pipe_lock().

Bug with splice to a pipe preventing a process exit
20250122020850.2175427-1-kolyshkin@gmail.com
Sendfile holding pipe->mutex blocks the peer's pipe_release() from do_exit().

Change in splice() behaviour after 5.10? (LTP splice07)
7F3B484F-9555-486A-B19A-5A8EB6442988@kernel.org

[PATCH v2 00/11] Avoid unprivileged splice(file->)/(->socket) pipe exclusion
cover.1703126594.git.nabijaczleweli@nabijaczleweli.xyz
Pending splice from tty/socket/FIFO holds pipe->mutex indefinitely, blocking all other FIFO ops incl. read(O_NONBLOCK)

splice: prevent deadlock when splicing a file to itself
20260320130615.1109449-1-kartikey406@gmail.com
do_splice_direct_actor() still lacks file_inode(in) == file_inode(out) guard

AF_UNIX/zerocopy/pipe/vmsplice/splice vs FOLL_PIN
2135907.1747061490@warthog.procyon.org.uk
vmsplice/splice into AF_UNIX/pipe doesn't FOLL_PIN the source memory

My main gripe with the patch as written is that I find it really hard to
figure out who would deploy this. It half-cripples splice() and
vmsplice() for some use-cases but leaves it intact for others.

At that point you can also just ENOSYS splice() and vmsplice() via
seccomp and force a fallback on non-splice codepaths that userspace has
to have anyway as splice() isn't supported unconditionally.

It feels like a knee-jerk reaction to an exploit class originating in
buggy modules that we have little control over and we would extend an
API to users that is really difficult to use.

What might make more sense is to add a splice specific security_*() hook
into the code so that an LSM can deny usage of splice in whatever way it
wants to - bpf lsm or in-tree lsm.

Then we don't have to have all this gunk in the VFS layer that will be
annoying to maintain with little value in the long-term. So I'm not very
likely to pick this up as is.
