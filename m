Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289941F349
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2026 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440095; cv=none; b=huGR+iWAm+Jgrj/C2wkxepUx0t+sGXR2ub2YlWelj//3oUvtHr7qfVb+b/gHHk+/H4oRP17Gk1kxDS5KujsZ/hj0YPFJ3cLbcAqNWz6CunDNZHitYIF/sUPSlX+QPybYdqCboIPSFN5xhi5kII5ohg38nBlZdbCVjhQbEkHcoyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440095; c=relaxed/simple;
	bh=/ZKDMCQ5EB7eTjSYaaF9qb8Dktwh1vw7ruel48S3MKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSC/BqaPt9XjvXVRYgbH/vUXl0H+TPxhoi+0RB17wf3UNRZS9nGs6TAuqpJ9wBYy+d9QnCCbckb4yinkEvEPmkhSbwtGqhSkyBx+kNRhJHj5ktuqLnmyzzD3EvSurZsCkMxWWG4yvL6O6SYpFqbK2o/e1Ded15Ol3DxoGVm5XGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi4IM3Zm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi4IM3Zm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D7F1F000E9;
	Tue, 11 Aug 2026 09:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440094;
	bh=PG40/i9jiQY5IRXEmIjhZ6VgH2PeUxz+CsRiWBpSJik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mi4IM3Zm1aUQHm/L3z82FoZcBlBiJKIUEdZEqXrTnt9We1xT+EENAL5sp88tEJnNG
	 EyRfyhbe2KrUB+juT3/8RZ6D2KPRZZJTt97aQf91ovs7ggMUGEeNOJINDfMU8t9Ybx
	 j+s1/Snpz1D4UodLuYAJWJLbSEGXsIIG7+5dV9GFr+B8s4y6kUgJctRB3Qgyx0Tqw7
	 rKRzSdkRButcubtIHmOhoJorAeLrZWgIZqxGt3zWoY2FZ6NTXJTrC+NBJYj/9ngvxU
	 dGwbo2QtLIDCRGheqZuY74iTzqGlc6jYp4Jw1CVPTGUK+F8onS5ohsbGw4qkOmFSEZ
	 N8ujtUPGwPYZw==
Date: Tue, 11 Aug 2026 11:21:29 +0200
From: Christian Brauner <brauner@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pfalcato@suse.de>, 
	vova tokarev <vladimirelitokarev@gmail.com>, akpm@linux-foundation.org, security@kernel.org, 
	linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Fwd: BadBunny: UFFDIO_COPY shmem killpriv bypass leading to
 local privilege escalation
Message-ID: <20260811-knieprobleme-holten-palmen-4d42742b1962@brauner>
References: <CAGBKPgOm8q-8_rwyRPEmSj8JXdh_GaK1Q8vpJ=j-+yA0SgcNQw@mail.gmail.com>
 <CAGBKPgPPALX_5CQJAKUNjwi2fD28pBeS5pRuwQgePU93pOy8EA@mail.gmail.com>
 <anXnHMInq_JLYbWc@pedro-suse.lan>
 <CAGBKPgOfbMJruqcegJca6BBpEtpd91s5ASF_VU+gucWsjwp8WA@mail.gmail.com>
 <ancYCBUT8aB0qHwz@pedro-suse.lan>
 <anlOGOmO1HWVCMdF@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <anlOGOmO1HWVCMdF@casper.infradead.org>

On Mon, Aug 10, 2026 at 05:05:44AM +0100, Matthew Wilcox wrote:
> On Sat, Aug 08, 2026 at 01:17:09PM +0100, Pedro Falcato wrote:
> > I'm adding a bunch of fs people that might have opinions about this. Please
> > see the rest of the thread below.
> > 
> > On Sat, Aug 08, 2026 at 12:13:06PM +0300, vova tokarev wrote:
> > > Pedro,
> > > 
> > > Thanks for the review. Let me address both points.
> > > 
> > > On the page fault comparison:
> > > 
> > > UFFDIO_COPY is not comparable to a page fault. Page faults serve
> > > existing page cache content (read-like). UFFDIO_COPY adds new,
> > 
> > A page fault can also write to the page cache. On MAP_SHARED mappings.
> > 
> > > 
> > > user-controlled content to the shmem page cache (write-like).
> > > 
> > > The correct comparison is to write(), which calls file_modified()
> > > 
> > > -> __remove_privs() to strip SUID/SGID.
> > > 
> > > 
> > > This is exactly the reasoning used when fallocate() was fixed
> > > 
> > > across XFS (commit fbe7e5200365), ext4, and f2fs to call
> > > 
> > > file_modified(). The XFS commit message says:
> > > 
> > > "as various fallocate modes can change the file contents [...]
> > > 
> > > we should drop file privileges like suid just like we do for a
> > > 
> > > regular write()"
> > 
> > I can't speak for fallocate, or other system calls. As far as I'm aware,
> > this is a best-effort kind of thing. As I said, writing to a MAP_SHARED
> > mapping does not clear the setuid bit. It's a super trivial thing to do,
> > too. But it's not a problem because setuid executables are not world-writable.
> 
> I mean, you're right.  But maybe we should make a bit more of an effort?
> I wouldn't like to see this used as part of a chain of exploits, and I
> can just about see a path where a confused actor manages to create an
> 04777 executable.
> 
> All the tmpfs on my system are mounted nosuid, and many of them noexec too:
> 
> willy@deadly:~$ mount |grep tmp |wc -l
> 8
> willy@deadly:~$ mount |grep tmp |grep nosuid |wc -l
> 8
> willy@deadly:~$ mount |grep tmp |grep noexec |wc -l
> 4
> 
> This certainly isn't a hair-on-fire situation, it's just a place we
> could do slightly better.  Not so much BadBunny as MildlyMisbehavingMicrobe

Let's not drag Bad Bunny's good name into kernel development. ;)
