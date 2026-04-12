Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD588212FAD;
	Sun, 12 Apr 2026 06:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775974377; cv=none; b=Hr95es09yFNp2hULh3EoZCHXe3U1NfVjmTuwBvL22hCdPmTH7SnGjoh78u/WAlRSCbo87XICk6mDmCwEiz7iA7vOKyEqAJOVJy097ZlGaK8H+4FaLWGvMxArsJVVqfb8980tonUhRYIU8LRv2YLhaBJk0ctKrJNy1qptLkGGbkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775974377; c=relaxed/simple;
	bh=nOLM+PsoUT1yA6dMxwwfRsA4qMQaT1sCJP/CVAkEfCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIrSqvx/bl32uRWsnq0oTcR7c96OASmaVnJUABrJXHqZkYk8yQv9cHO+tddGdtU2BRc35nwkR+jFe+OaGACKGXipSXejKWglbCDbF3xO5CLK4Vms0BxgwmopbkKVVDhGWm/9W5kGg6kbs7mYnf5B+bcWL0hVZmOJlZy/c831ByE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FQGx+IPl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FQGx+IPl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=54X+pAIEIZJIuajdozx1cKC21ou+PfAOr8qApo+Znmc=; b=FQGx+IPl0FzCYpBAhf/YCT6/GX
	/f4MRuWnDAxT8pb6TCtNKcoQXCtI9WqCEk+5RkfI0dBxeS3odIkR1Sp7NA1WKspKcVqc7VXpiPxQ/
	QytTiGTVz6pgygoN+gAkjLRmFkX0sgGYA27KbcloFu9QgdKGVRCfqiXh0MnZviP4vFTK7PwmSwHvi
	KCXpfXtuLwIB6hczs8k+9c/O7dP8a+FIRX0LMHGYvSW1wVxezBKmOLbwSkWv/GJ0J6D3CDIYmnO5T
	3DBWV2chahuM02KkvnSLE3sdM2hUi7+sfCkzQRq1clxfIePwwEFeXrWDsEAogp0coLnhFIW16qmQm
	Fj3h3HDA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBo7h-0000000Agqe-09Dl;
	Sun, 12 Apr 2026 06:16:45 +0000
Date: Sun, 12 Apr 2026 07:16:44 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] fuse update for 6.19
Message-ID: <20260412061644.GA2485189@ZenIV>
References: <CAJfpegunwB28WKqxNWCQyd5zrMfSif_YmBFp+_m-ZsDap9+G7Q@mail.gmail.com>
 <CAHk-=wht097GMgEuH870PU4dMfBCinZ5_qvxpqK2Q9PP=QRdTA@mail.gmail.com>
 <20251206014242.GO1712166@ZenIV>
 <CAHk-=wg8KJbcPuoRBFmD9c42awaeb4anXsC4evEOj0_QVKg0QQ@mail.gmail.com>
 <20251206022826.GP1712166@ZenIV>
 <CAHk-=wgBU3MQniRBmbKi2yj0fRrWQjViViNvNJ6sqjEB-3r4XA@mail.gmail.com>
 <20251206035403.GR1712166@ZenIV>
 <20251206042242.GS1712166@ZenIV>
 <CAJfpegtsDZW7v=YDhs+gPq25G+QOh-5mjiaXT04DDW=iU+R75A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtsDZW7v=YDhs+gPq25G+QOh-5mjiaXT04DDW=iU+R75A@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jan 14, 2026 at 04:23:04PM +0100, Miklos Szeredi wrote:

> Posted a short patchset fixing this.
> 
> I really think there's no point in doing the get-ref, drop-ref dance.
>  Retrieving the dentry from any source will require locking and that
> needs to nest d_lock with or without the refcount manipulation.
> 
> So I kept the d_dispose_if_unused() API, but added a note to the
> function doc that additional locking is necessary to prevent eviction.

	Looking at that thing again, I really hate how subtle it is ;-/
Consider the lockless case in your ->d_release() and try to write down
the reasons why it's safe.  Among the other things, kfree_rcu() is there
to protect RCU callers of ->d_revalidate(); fair enough, but it quietly
doubles as delaying that freeing past the scope of dentry_hash[].lock in
which you'd done RB_CLEAR_NODE(&fd->node) that had pushed ->d_release()
to lockless path.  Another side of that fun is the proof that if
fuse_dentry_tree_work() sees a dentry, it won't get freed under us.
Locked case of ->d_release() is easy; proving that the lockless one
is OK without explict barriers is more interesting.  Basically, all
insertions are ordered wrt ->d_release() (on ->d_lock), so if the value
we are observing in RB_EMPTY_NODE() has come from those we will hit the
locked case.  If the value we observe has come from RB_CLEAR_NODE() in
earlier fuse_dentry_tree_work() (these are ordered on dentry_hash[].lock,
wrt each other and insertions), there mustn't have been any subsequent
insertions, or ->d_release() would've observed the effect of those.
If the value has come from the _same_ fuse_dentry_tree_work(), the
implicit barrier in spin_lock() would've ordered that store wrt beginning
of the scope, and since dentry_free() is ordered wrt ->d_release()
the callback of call_rcu() in there wouldn't run until the the end of
the scope in question.  So I think it's OK, but having it done without
a single comment either on barriers or on memory safety...  Ouch.

	Note that we *can* run into a dentry getting killed just after
RB_CLEAR_NODE() in there; it's just that store to ->d_flags of dying
or killed dentry is safe under ->d_lock and d_dispose_if_unused() is
a no-op for dying and killed ones - it's not just "If dentry has no
external references, move it to shrink list" as your comment in
fs/dcache.c says.  And in your case it very much does have an
external reference - it's just that it's an equivalent of RCU one,
with all the joy that inflicts upon the user.

	FWIW, right now I'm still looking for the source of the UAF
reported by jlayton; I think this stuff in fuse can be excluded as
a possible cause, but I'm not happy with that primitive at all... ;-/
