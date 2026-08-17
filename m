Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C56442FBB
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786979905; cv=none; b=jhszP9Z3MDY1n5/6vJizpK9HLyx6Df44PtuNkvtzpjLvaAkn+XQ2KjjSNviA9kPIbA7LEp7zTtMwsGf6UpDo4J9Gb9ZEu1oX33fQ7wgMoT4GmaO8OGTSlRPIMcvk9aKgEcA7AtAJYMzLYHHFsbh+iEg2M9gG9gP70gk5p0nK60A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786979905; c=relaxed/simple;
	bh=vzN3HYFB4UxBxtIrNloE+1oacJ9yle5i0EkA7mcS+Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttQmTlkCpxoGCd8lF6sawoRnwGKJLnG2HdRfgYYi4cABdgNT8ErbTLIeXQCmoiPiWU0Q4xebm2GB+DVvzh31xuNefFge5Avg+FR+oUYLyZQZpAv88S64HFyZ6L0QwFcvLtTbDAyE0A9MXlJAI7WdbY+TEXDbXgY57X++Y+YKxGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lAMVwdUD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lAMVwdUD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nlKiBmDFzuD5Cz1o0uCr0b99TcOu+kZtAzlsbE3jv7A=; b=lAMVwdUDSOhmDS6oBwpYR2AEgJ
	OoHsZ4rdgC6szU4s4HMFl91LROD0w5lzFlRQ9/R5j+fnr1YHUQsB2SZjWsspqjbQS468g9PBtXqfJ
	Qo2iZRSk+Gvyltdb7UmKvRkIXVIWsAafgROBx3Q2n0+64nAcSXljmiMOtU8i9trc7YcWvowE7YFmZ
	0mmQ5qLYDrOUxhkl//8kR41uxmD80/JxkFk/KHn7PUbk+WyIYSKVZcDsARl3xJ+kKpCyaKs5a98sk
	Qcr9MWSLqlZe4NwU3KFEhSQ9lnCoSCkqZQndOJxTtl5qvVP5v+HMlGb9Jb2b7vb6kCQxZQHdQvIfu
	wVzVNKBw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvz6O-0000000AIc4-2P0r;
	Mon, 17 Aug 2026 15:18:16 +0000
Date: Mon, 17 Aug 2026 16:18:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: vova tokarev <vladimirelitokarev@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>, akpm@linux-foundation.org,
	security@kernel.org, linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Fwd: BadBunny: UFFDIO_COPY shmem killpriv bypass leading to
 local privilege escalation
Message-ID: <aoMmOHjLMRyUXhys@casper.infradead.org>
References: <CAGBKPgOm8q-8_rwyRPEmSj8JXdh_GaK1Q8vpJ=j-+yA0SgcNQw@mail.gmail.com>
 <CAGBKPgPPALX_5CQJAKUNjwi2fD28pBeS5pRuwQgePU93pOy8EA@mail.gmail.com>
 <anXnHMInq_JLYbWc@pedro-suse.lan>
 <CAGBKPgOfbMJruqcegJca6BBpEtpd91s5ASF_VU+gucWsjwp8WA@mail.gmail.com>
 <ancYCBUT8aB0qHwz@pedro-suse.lan>
 <anlOGOmO1HWVCMdF@casper.infradead.org>
 <20260811-knieprobleme-holten-palmen-4d42742b1962@brauner>
 <CAGBKPgPanzn8WuHK1hm44FLCXwJcnk7W=J6b17D9UzScWW7SJQ@mail.gmail.com>
 <trv2wwdwprrebu4s6i2ufepk5a5ir4edz3tnttv7ivlkzihx3e@zq6lt67oplc5>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trv2wwdwprrebu4s6i2ufepk5a5ir4edz3tnttv7ivlkzihx3e@zq6lt67oplc5>

On Mon, Aug 17, 2026 at 04:53:08PM +0200, Jan Kara wrote:
> On Tue 11-08-26 14:16:31, vova tokarev wrote:
> > Matthew, Christian, Pedro,
> > 
> > Lol - fair point, I'll keep the reggaeton references out of future
> > commit messages.
> > 
> > Agreed on severity - but this is a
> > killpriv invariant violation, and the kernel has treated those as
> > security fixes worth backporting before.
> 
> I tend to agree this would be good to fix for consistency as much as I also
> don't think this is a particularly serious issue. Removing SUID bits on
> write is more of a hardening measure than serious security guarantee and is
> there mostly for historical reasons AFAIK from the old Unix days.  POSIX
> for write(2) mentions this as: "Upon successful completion, where nbyte is
> greater than 0, write() shall mark for update the st_ctime and st_mtime
> fields of the file, and if the file is a regular file, the S_ISUID and
> S_ISGID bits of the file mode may be cleared." truncate(), chmod(), chown()
> have similar notes. No mention of this when handling mmap BTW :).
> 
> Anyway, the problem with calling __file_remove_privs() when writing through
> mmap is with the implementation - in particular the locking. To be able to
> call __file_remove_privs() we need to hold i_rwsem and that ranks above VMA
> locks / mmap_lock we hold during the page fault. Now that I'm speaking
> about it I even have a vague recollection this has already come up in the
> past and we've just decided to leave it alone due to these technical
> difficulties.

Perhaps we could just do it at mmap() time rather than waiting for the
first fault?  Obviously only for MAP_SHARED / PROT_WRITE.  I could see
an unenlightened interpreter doing unnecessary MAP_SHARED / PROT_WRITE
mappings, so that might not fly.

We could also do it within filemap_fault() (and shmem_fault()).  If the
fault is a write and the suid bit is set, drop the locks, clear the suid
bit and return VM_FAULT_RETRY.  We already do that if we need to do
readahead, so it's a well-tested path.
