Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9B14A35;
	Fri, 10 Apr 2026 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775843627; cv=none; b=mMDe3bIpnohP0E7q58kHPlz+GCwOpsJKqD/G4thR5Xy3TY4JaIcrmxBrv6PnRyvTMKTtSqAPoPEUhp3HYHU4pLh502BViK5Iy8aGvFo5HhjXaHHLDdXxDhe7yuYuls1A9IRS3z1GUyfq86QQSzn4EBpU9oRyaheDIuZ6pMpXfW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775843627; c=relaxed/simple;
	bh=wpADgFEtfukykq5IDAn1wD62A4OJcEFDIWQqT2yAoJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOBlii35IRbo64RjGX8Bqtf/93A9rTLJNdvbxUytx655hq3Vk4jJ/+6/sW03OzteXwpgjBH/RK+YFgr2T8oEQRNSQ36xjhf5mpdMnNLNBKDmQszi+QF0VfNPqxyV8VcfVIeIeUq7dEz9OzwsNc17pG27goAd4jRNqCgLup/pxx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tES21/T5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tES21/T5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dysKwEJHoQ1XKO0SAzHGAegMjYlcSt4YvbWwXpVpuKY=; b=tES21/T5XaSvkSELBwayZ2p4fu
	PqWt+W1K1w3jBY+1c1QaRC4PoOU8PAVcS2xd/5evnIlEVHjHz1fMfdL2BFwEGOjXmCdyxO57G3DkM
	ZfUtM2hKi4MKUb57Om/S2COmuhVCcowNiYST+cIriBzBrr+DPzLW8iLTSqH6uzf33A+U14rX4Uy43
	IAMwaek1fsH++aXuQyQe5CJW/gDMmrk+WDBtEVulb4CUetfTbqsKcJanSUNqJD5x71xcIFjRE18xS
	wENDZCvKeK35/553vdyYBECUfjejX3RttHPQD0OmmTSxeIENB2m8xh5thVf1tVYTUwu+Eq5fwPGfY
	XGpzHeQA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wBG31-00000009kE2-11vT;
	Fri, 10 Apr 2026 17:53:39 +0000
Date: Fri, 10 Apr 2026 18:53:39 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Adrian McMenamin <adrianmcmenamin@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] Add support for VMUFAT filesystem
Message-ID: <adk5I8RsBjJY3bRM@casper.infradead.org>
References: <20260410142403.308108-2-adrianmcmenamin@gmail.com>
 <adkLbCyI7ZnxkSAp@casper.infradead.org>
 <CACwZE5SctP1QAy_5_sBTC--O8ubGwFpFry0KF+CS72W=EXn7Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACwZE5SctP1QAy_5_sBTC--O8ubGwFpFry0KF+CS72W=EXn7Eg@mail.gmail.com>

On Fri, Apr 10, 2026 at 04:37:36PM +0100, Adrian McMenamin wrote:
> On Fri, 10 Apr 2026 at 15:38, Matthew Wilcox <willy@infradead.org> wrote:
> >
> 
> >
> > You should add an extry to Documentation/filesystems/index.rst too.
> >
> 
> That was sent but I had some trouble with it, but you should see it on
> the mailing list now.

I have to say this patch series is almost impossible to review.  I'm
not quite sure what you did, but it feels like you generated these
patches manually and then used git send-email to send them.

What I do is construct a git tree that contains all the patches I want
then generate a series like this:

git format-patch HEAD~4 -o pgtable-20251113 --to 'Andrew Morton <akpm@linux-foundation.org>' --cc 'David Hildenbrand <david@kernel.org>' --cc 'Vishal Moola <vishal.moola@gmail.com>' --cc linux-mm@kvack.org --cover-letter

Then I scp them over to the machine which handles my email and use git
send-email on that machine to send the pgtable-20251113 directory full
of patches. 

The other thing that I'd advise you to be careful to do is make sure the
patch series is properly bisectable -- for example, you're adding the
Kconfig options before the Makefile and the Makefile before the files
that it would make.  I'd invert that order; add all the code, then the
Makefile, then the documentation.

