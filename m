Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE463358AF
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 04:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786334755; cv=none; b=dmleOV8lYQZCWfJLszlSLmFGa3eDGE1cDByhR4J7MyWIZtfdcfuDFF94N/B/lLJVnThUJwB5R6DxEm0bLTGr622DQyM3hQIG6AW8oY5NTyQI5wZMeIqGey7eCIh1ET9VYVx9AY17EFqYPMph9t/gvEQWst5lbnLCWY3BMcLOEPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786334755; c=relaxed/simple;
	bh=VNNshdBiBfoddcokH/A/HxQN4EprZHJdc8cTudCnnAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngBzmY7Q8BFNLgbdcfDLPH7RzaUDA145CCc82r2ZCCBoK5B/XlLz6YlLY0rIPO7i+X1e9Yd8cdN/6VcXrSgOWHiVUaGlTdtZuhchjfOx26X8xnFzPeo+oqy2L5rGn/DBJxJhe52iAwtq4pNf5RBH6BXRFdA5Spl0J6l0jjPtsZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FaAWcN9M; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FaAWcN9M"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=w3mkdXzNugogzg/Uybf5Bwmxm4mLQcy7cnOBTawf1SE=; b=FaAWcN9Mdmiwj1QIxlrzffFtQb
	dxdYnXJR468/2SRKtk66MkzRgIuZiN8DlX0d7MF5X9XQ9W1RFTLfM9CDmmZZ2v5Xbi3fRVcdzqQvY
	yqWlkfDvlpi6KAIFJleElHHAZeucAqerL1cWx+5zDn6NbBx8PynqZm5raW7++SP0b8iax8M92eEqq
	Afom2j4BBpsEGs2ORReT3iVHh3w9HujLDz0zjlba4HjJKDKdkUv1xo33AVkEN+ZQ66UJMwL0v4N2O
	oIhrfJ+QzuvBdE0r4ugnmcxAGuECJ29KJIdp/y7yoD2JAAvtXvCaMgygnsKUUtp/lIQUIDbhm3IuC
	sO+0NKzA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtHGi-0000000AFF1-3vil;
	Mon, 10 Aug 2026 04:05:44 +0000
Date: Mon, 10 Aug 2026 05:05:44 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: vova tokarev <vladimirelitokarev@gmail.com>, akpm@linux-foundation.org,
	security@kernel.org, linux-mm@kvack.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Fwd: BadBunny: UFFDIO_COPY shmem killpriv bypass leading to
 local privilege escalation
Message-ID: <anlOGOmO1HWVCMdF@casper.infradead.org>
References: <CAGBKPgOm8q-8_rwyRPEmSj8JXdh_GaK1Q8vpJ=j-+yA0SgcNQw@mail.gmail.com>
 <CAGBKPgPPALX_5CQJAKUNjwi2fD28pBeS5pRuwQgePU93pOy8EA@mail.gmail.com>
 <anXnHMInq_JLYbWc@pedro-suse.lan>
 <CAGBKPgOfbMJruqcegJca6BBpEtpd91s5ASF_VU+gucWsjwp8WA@mail.gmail.com>
 <ancYCBUT8aB0qHwz@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ancYCBUT8aB0qHwz@pedro-suse.lan>

On Sat, Aug 08, 2026 at 01:17:09PM +0100, Pedro Falcato wrote:
> I'm adding a bunch of fs people that might have opinions about this. Please
> see the rest of the thread below.
> 
> On Sat, Aug 08, 2026 at 12:13:06PM +0300, vova tokarev wrote:
> > Pedro,
> > 
> > Thanks for the review. Let me address both points.
> > 
> > On the page fault comparison:
> > 
> > UFFDIO_COPY is not comparable to a page fault. Page faults serve
> > existing page cache content (read-like). UFFDIO_COPY adds new,
> 
> A page fault can also write to the page cache. On MAP_SHARED mappings.
> 
> > 
> > user-controlled content to the shmem page cache (write-like).
> > 
> > The correct comparison is to write(), which calls file_modified()
> > 
> > -> __remove_privs() to strip SUID/SGID.
> > 
> > 
> > This is exactly the reasoning used when fallocate() was fixed
> > 
> > across XFS (commit fbe7e5200365), ext4, and f2fs to call
> > 
> > file_modified(). The XFS commit message says:
> > 
> > "as various fallocate modes can change the file contents [...]
> > 
> > we should drop file privileges like suid just like we do for a
> > 
> > regular write()"
> 
> I can't speak for fallocate, or other system calls. As far as I'm aware,
> this is a best-effort kind of thing. As I said, writing to a MAP_SHARED
> mapping does not clear the setuid bit. It's a super trivial thing to do,
> too. But it's not a problem because setuid executables are not world-writable.

I mean, you're right.  But maybe we should make a bit more of an effort?
I wouldn't like to see this used as part of a chain of exploits, and I
can just about see a path where a confused actor manages to create an
04777 executable.

All the tmpfs on my system are mounted nosuid, and many of them noexec too:

willy@deadly:~$ mount |grep tmp |wc -l
8
willy@deadly:~$ mount |grep tmp |grep nosuid |wc -l
8
willy@deadly:~$ mount |grep tmp |grep noexec |wc -l
4

This certainly isn't a hair-on-fire situation, it's just a place we
could do slightly better.  Not so much BadBunny as MildlyMisbehavingMicrobe

