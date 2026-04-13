Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9D1CF8B;
	Mon, 13 Apr 2026 15:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092775; cv=none; b=XQYW+T9KXRvstW/uot29ktlcj9dCB4il1sMaakToUuXS/fbA19z/qbWFnxRxuBKJMK91+E5Zkt1yd8ZKDfQfYabxoGKnA6Id0A5436A6dCDhB7PwObb+h602f8DEnOAxznHstXcoYUMHDBA6W23M+Ijr4hnbBvbMFqidIjRaqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092775; c=relaxed/simple;
	bh=+g6LH2zhk/nYRTREJBiSimauDhpBSVZSIdQg4ygSs00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hm1JCnbCi0ioH4uvQ5Q9sCro6U8Sf7wSZqMij63GWLxVaE12mtmJRcwI5pHi5K2WuS4x8RUQHobD5ttenvfuT0cCCf3FIpjrkatrNtKtVeeel6J7liH3526ucfSfjVN7GH/5YYCe2t8cOHqs50G8lyeo1jQhuRlLzN1kA7FxTjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DEzP2hQt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DEzP2hQt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2owUYSzBAwJcZlAorCO0uN1WFwAEJ0DzTHeENfLCTSw=; b=DEzP2hQt4mG5E7xJ5+8knXvd0V
	5gnOVAbva0JZxGIcJ7rwbYnjBmpkzNtDvZXCe0QW3DETeE0stgLyj4Tz9FUeN34N+L0hr4Fprdm4Q
	Jfz4BOScIa5zhBy0rdyA7zw9y//DZe2KukwILwVLBWtnx1XMPi71u8DFiVzyRxjy66sWSn42eRrww
	TXj0lmnPHAbLegX1E29Mkg9DRXwg483v0vqoBuH2mdaw+IQElbl7rOki7OtC5UugyZU/te46oQblT
	VgD+qMaJxA3xb9Niti+ZMQcA1UkF3po0ze3t7JQWtFMDfWWjZFm9Y4Ay0dm9bcIREX3kOP6pzrPtY
	7zIGi2pQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCIrX-0000000E3Nl-415E;
	Mon, 13 Apr 2026 15:06:07 +0000
Date: Mon, 13 Apr 2026 16:06:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Aurelien DESBRIERES <aurelien@hackers.camp>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [RFC PATCH 0/10] ftrfs: Fault-Tolerant Radiation-Robust
 Filesystem
Message-ID: <ad0GX6gVgHxD9-ym@casper.infradead.org>
References: <20260413142357.515792-1-aurelien@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413142357.515792-1-aurelien@hackers.camp>

On Mon, Apr 13, 2026 at 04:23:46PM +0200, Aurelien DESBRIERES wrote:
> FTRFS was originally described in:
> 
>   Fuchs, C.M., Langer, M., Trinitis, C. (2015).
>   FTRFS: A Fault-Tolerant Radiation-Robust Filesystem for Space Use.
>   ARCS 2015, LNCS vol 9017, Springer.
>   https://doi.org/10.1007/978-3-319-16086-3_8

Might be nice to link to a non-paywalled copy of that paper, eg:

https://www.cfuchs.net/chris/publication-list/ARCS2015/FTRFS.pdf

> This implementation is an independent open-source realization of the
> concepts described in that paper, developed for the Linux kernel.

Can I ask why?  Is the original code not available or too ugly?

> On-disk layout:
> 
>   Block 0        : superblock (magic 0x46545246, CRC32-protected)
>   Block 1..N     : inode table (128 bytes/inode, CRC32 per inode)
>   Block N+1..end : data blocks (CRC32 + RS FEC per block)
> 
> Inodes use direct addressing (12 direct block pointers) plus single
> and double indirection. Directory entries are fixed-size (268 bytes)
> stored in direct blocks.

This is very old-school.  That may be appropriate for the intended
use-case, but it ignores about five decades of filesystem research.

