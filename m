Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F511DC198
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775169669; cv=none; b=uOeLLmhXswfIdsreIjyiqO0SdzeavUTIhotPOGT9CJXvP74U/9gEMc6CoBvMaBLznKCJ5zIHPpdcz3nVB7MnNAucYFsVaV8dm6jjd+2qzDA2qkeZW9qos+c45/9b482C/ejd9r0TFnmb2HJ5JxZlm0jboopp1erTY4BFnRju+Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775169669; c=relaxed/simple;
	bh=R3LCEkcKCbd1fD2E3wUt1eGEB2RdyG5tiVXEogeFsqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rc8l5tOTzkCsAPnIqozx8lxG3UiNJlkRX9MsZeEKOCx5S3TI2rvqiXcncLPTMGf+KA08/wzCHnbnSLsdSVR08Rjd31h6gWbWtAisevceQlDOK+M+MD8dWIb9ctsLPmbrC2WAg6JMKLffoV2Gm6/SmX87sXeE2Wu2gxLFUEvGPvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mrRD+d8J; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mrRD+d8J"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CbJcPnKPtiDDw/x0BnSWWMJa/1eCn/ehNyJL1zgfzV4=; b=mrRD+d8JiwaKoyK2LZvXAwgwDW
	L35HFOV8G0UuumFdGlNGkRzp33thy9WE6mz/UKnOD4XWegr52/hpgqTZMvxfjgYctnIDN13np/U1y
	lNKVQ9AJmzO5dNvc0ALGjKkgDfH4hUbkL1xpCPgKi6Siy88/tT+D9gWtNDIUDKGVHLtN0fQY2TcmY
	rHVbwiw+aBwWzPgSVajIGnfoss3OhZIFhXx7CB5dzmgv5HYLT0sPBE2tzHJbJk7XMPd5Xhl89X5N2
	LTK5zWlzi/pDFfHLrelNP4L+eM3DM7Mf0f6E1kQmJXDH0pZe+x8KSwfHmdo3uvPlM2cFYKUc2XKV8
	ktUG/nxw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w8QmF-00000007cBl-2ZQW;
	Thu, 02 Apr 2026 22:44:39 +0000
Date: Thu, 2 Apr 2026 23:44:39 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: Re: [RFC PATCH v2 4/4] get rid of busy-waiting in
 shrink_dcache_tree()
Message-ID: <20260402224439.GI3836593@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
 <20260402180850.3729310-1-viro@zeniv.linux.org.uk>
 <20260402180850.3729310-5-viro@zeniv.linux.org.uk>
 <CAHk-=wjR66-0qL08k9p10Lt9vuvmddFT5WvfnG+xXf4Xv3-VhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjR66-0qL08k9p10Lt9vuvmddFT5WvfnG+xXf4Xv3-VhA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 02, 2026 at 12:52:28PM -0700, Linus Torvalds wrote:
> There's also a 'hlist_del_init(&dentry->d_alias);' in nfs/getroot.c,
> and that one stays as such.
> 
> I thnk that's just because it can't actually be a real alias list at
> that point, and all that case does is to remove its own inode from the
> initial list to make it always be empty. And so it doesn't have any of
> this 'negative live under lookup' case. But I'd like to have some
> commentary about *this* particular one, because this is the subtle
> one.
> 
> In particular, I have paged out the history from the last iteration of
> this all, and the reason why you changed hlist_del_init() to that
> 'likely(!hlist_unhashed...' escapes me.
> 
> I'm sure I could look it up and remind myself, but honestly, I'd
> rather have it just all explained in the code.

No deep reasons, really - it can stay hlist_del_init() too; the only
reason why I went for __hlist_del_init() (and got immediately reminded
that the sucker needs hlist_unhashed() checked first) was that ->d_alias
ceases to exist at that point, so there's no real reason to zero it.
OTOH, these two stores (to ->next and ->pprev) are not going to cost much,
especially since one of them combines with zeroing ->waiters immediately
afterwards...  We'd just read both words, and they'd better be in the
same cacheline, so the extra store should be pretty much free...

Let's go with hlist_del_init() there, possibly with a comment that "init"
part is not really needed, but use of __hlist_del() is clumsier and it
wouldn't really win us anything.

Re nfs_superblock_set_dummy_root(): it's really ugly wart and I'm not
sure we still need it these days; it _is_ safe, even though it violates
all kind of rules for dentry state.  It's also a headache on every code
audit in the area ;-/  I suspect that we could get rid of the entire
dummy root thing and if sb->s_root is still NULL after d_obtain_root() in
nfs_get_root(), have root removed from sb->s_roots and stored in ->s_root.
Once upon a time we used to oops if shrink_dcache_for_umount() found
!IS_ROOT(sb->s_root) (i.e. if root got spliced on top of one of the
secondary trees at some point), but that's no longer true - not since
42c326082d8a "switch shrink_dcache_for_umount() to use of d_walk()".
Never got around to checking if anything in NFS might get unhappy with
such situation; VFS ought to be OK with it.

That's definitely a separate story, though; as far as this series is
concerned, dummy root is out of scope - it's still positive, even
though it's removed from alias list.  Which is yet another reason
why these weirdly spelled sanity checks were wrong - we never hit any
of those for the dummy root, but they would wrongly treat it as negative
if we ever did...
