Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BAA3491D0
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jun 2026 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782078264; cv=none; b=HJmMs/xZQjwflng2fHAjV0fqP28U3joYXZVGY/+w4dOqIgQVFiRMba2LI/5oUmPq92rUEWFioXyTs+3Kk83GLcgQdmUJ/FXYRUdx/6z+zylrDnDLrPCih4Q7Ea1dplpfkx8v13iCr61Al8YToHas4Z+KAEs8MGSXBhXLmuopLmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782078264; c=relaxed/simple;
	bh=a3Y9fGncPiH+11KQGUNiEU4fOR1zyfKZhNYrbxv7b6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+4krAhYHsG9Sr0sUdT2f41x1UTWNG0+KFlT6fi26AB65hvs3iG99fpt/rW/xBBA2eOOwOmTuBaIV5TjSYvw/eGCBCTZIgggLjzJMdcvtGyb2VH3w/3VwkATHNq+nkJJhvsmwEzW+ps2eviH38igwZHEIeqeeqmNyhOEBU7Ce14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nbJslNAQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nbJslNAQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SWo0RjmJDDbvJTRUukB3UUi5L/yCguEQGEs2iuo1NaE=; b=nbJslNAQcvU+pCzNHbifYCA0vt
	Bv6oifgBK8CF/MyEn4haJEVn3mBmskWhliRd1IJp11NHY49RVsNXLRW5yzjwfIR7pt9gKGWETm0Iv
	Ojn3/qv5bS/0yxrQ0RXh0N9pqJlqk8XnbRsV5cplnSPuEkWbXvfjDBLHgKr65OgMzfjkJ41/n5KjB
	AChWQbe/JaLMlm2eblscdR6E5BWdgMaCyC5UvP0PzmmzdOF+5ZD5InMpL2WGVCtgkEZSjdxIQDsj1
	LkywKOKb3XroFXjF0IOPhXdQ0mhiDZaWeloMfDOY1+THm0Ff0+Z+IyXntrc5pJ2R9UlA5V/B8F5VX
	v9R6uQoA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbPxk-000000032s1-13SF;
	Sun, 21 Jun 2026 21:44:20 +0000
Date: Sun, 21 Jun 2026 22:44:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Pedro Falcato <pfalcato@suse.de>,
	Christian Brauner <christian@brauner.io>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] efs: Remove EFS
Message-ID: <ajhbNJcT8qgqKD70@casper.infradead.org>
References: <20260618211822.3599089-1-willy@infradead.org>
 <ajUIMvi5Nyjp6t2v@lt-jori.localdomain>
 <ajUSQ30oi-fyh0NH@pedro-suse.lan>
 <2099505714.2289513.1781864378114@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2099505714.2289513.1781864378114@kpc.webmail.kpnmail.nl>

On Fri, Jun 19, 2026 at 12:19:38PM +0200, Jori Koolstra wrote:
> I wasn't around back then, but why was ReiserFS removed? I'm just curious about

You can read the discussion:
https://lore.kernel.org/linux-fsdevel/YhIwUEpymVzmytdp@casper.infradead.org/

> to what degree the arguments used back then apply to all kinda-maintained-but-not-really
> filesystems. jfs is totally unmaintained, despite its MAINTAINERS file entry. And

What?  Dave absolutely does maintain it.  Commit 1d51b370a0f8 for
example.

> David has said multiple times he would rather get rid of it.

Rather get rid of it ... than what?

> > We already have one - it's fs/ext2.
> > (modern API? maybe not so much. still has buffer heads, uses mpage, etc.
> > alas.)
> 
> When I wrote this I was also thinking about ext2, but it is significantly
> more code. Still, I think you're right. I have a special attachment to fs/minix
> because it was the first kernel code that I studied in detail :)

We've had extensive discussions before about converting, eg, ext2 to
iomap.  Maybe now ext4 has been started, there's finally enough examples
to get ext2 done.  If you're interested in contributing, that would be a
great project.
