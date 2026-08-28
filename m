Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587EA37F8B2;
	Fri, 28 Aug 2026 17:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937540; cv=none; b=O2adZnkog/78PNbXaXpTIHMVi2NM/N6OAppEA61qMwnzIPlUelwj0h1RbbI94xspfaO8c8394/Q8QrT9Lt9KqFkTZ2iC22CnZBFnvIZ9WQnffx0TU5XZyi2PJQnWDQLl0g0Z9RX5O4gt0cn8lT/ooxzgCa0nlfi9o5ifwdqLq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937540; c=relaxed/simple;
	bh=03E5g9MWx0/C1+xoYrjo+6mtD+xv5ZCu7LrgP9HZFew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uftqsEvoC8bfLVIKWKpkIdbrnMTc4nm5QbnedwE0fSM/17uOsvxpooOqfUfGJIIRErhKFtHhzdJvhcSmOvlcisoWK+TtaUZ9llUPq3wAOZKAzcn9+poXbHatZx0l4R7PbLmJHz0IwVHae4QYjz4PvWZWOtoxBiC+YE/QdXKFt2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aTjNCdw/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aTjNCdw/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7BqH+mJJNouchoXYZ3ssmFPqelP6Ak9OqMh5GOTj380=; b=aTjNCdw/YGw05Q/oUS1Im69fx2
	NCgNclO20G6mjnMW3wmg5sB6riqPdFzxFRvzeoG12sIVhotmWyZJ8+JSYKV2ePeuNkMT3Tg9ZRBtB
	b8RHKJTS6T+1sgDMJUYPiDRlHQ8pKUFAAWvLoakKiMkznOae/ZHmWRxtCIO6eVaRkksR+hGYAHecG
	J5iPZlgeWc8g8hmpKopRr2+FWActEqW+GPRGMu6lzO3oFewq3H8597bNdsqzvxuFnzDRmcfunbGzq
	EI4sd3bjiO/zRXFdIX9XozaySNA8ECCisZlpnO/1xdOw1BzW6nVhiUdAhFIIzvvvTIEDnh3GJz2BM
	nyFSajqg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x00EA-0000000FA0u-44QK;
	Fri, 28 Aug 2026 17:18:55 +0000
Date: Fri, 28 Aug 2026 18:18:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [GIT PULL] Remove dependencies on pagemap.h
Message-ID: <apHC_mHJ3wsJPEgy@casper.infradead.org>
References: <apG8g-5krNRUFUuD@casper.infradead.org>
 <CAHk-=wiY22BnQkAMMc8-h6xaRksvVAbASpg=pj+=kVaXXQYo6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiY22BnQkAMMc8-h6xaRksvVAbASpg=pj+=kVaXXQYo6w@mail.gmail.com>

On Fri, Aug 28, 2026 at 09:56:59AM -0700, Linus Torvalds wrote:
> On Fri, 28 Aug 2026 at 09:51, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > My apologies for not sending you a signed tag.
> 
> I'm not pulling non-signed stuff.
> 
> And it's way too late in the merge window to try to fix this. Make a
> new key, and we can do this next time around.

OK.  I thought you liked this kind of churn stuff at the end of the window,
rather than having it create random unnecesary conflicts throughout the
development cycle.  Have you changed your mind on that?

