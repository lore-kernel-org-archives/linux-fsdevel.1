Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC373C552E;
	Mon, 13 Apr 2026 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776103917; cv=none; b=prBQHHkpwVw7StD9yruryzomzPV0wjBhMi/4hesm14EeLpiZuJKSgxV1S7FVILZ4PQUujU+ivvDYSeaxH4nL8GjxVF3mRefX4CPQOVfXGXfzpbLl5hPoSEz1QMIG5u5agp6w47aT2ii26VVQfosPzZyhEylYFwjNZ0a9KEy8UFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776103917; c=relaxed/simple;
	bh=GqEblOIW2F5gQb9NP0lUn1DmJkawbMT18pwCaysfhBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QtpUYzGztCdFdnnKHGdfFzUXPQfG27esx2jSU+xMPNgO/EnZP0JIGp4yRaRFkrwMCZrlNbkq4BznQDKLZ0KCoUXVuIpN5d4lCqHQEb5wfFFlUeEwdOt1uyl2TNLh3MrDBTJygYBQUvQb+hPjo/A3kVoQn37Kupetv4YrpOxterc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGpujUap; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGpujUap"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64247C2BCAF;
	Mon, 13 Apr 2026 18:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776103917;
	bh=GqEblOIW2F5gQb9NP0lUn1DmJkawbMT18pwCaysfhBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGpujUapboi92ORM0AThJwTNTrTULuozrp5frl3kHF83gg2r7TyylitC/5RlaAuaz
	 vRh/iNR9D6KoDbfXOEGtpECQMu3qiksmOiLeQb5guOZLMzK0kpZg9mCnkq971JjHmS
	 M/BC2pH1UPWwU0GMtXRTyVXFbFsq+ckdeGqi571VnlaLlFq2Vsd/hE1d+L9QzcoLfH
	 Ai2Q980IZbc0YoCmqxwgEyZhI4A1Reed753PhfurpsE/mT9czGfNI6XMS6cZj82RRC
	 9s3SqXsLsk+oNDArILjlMgVfAu3v8gfVzy8OUG0EJpYqpt0wjS7G/8g42f2NsAWO/J
	 hWMzTgRh6Yb8g==
Date: Mon, 13 Apr 2026 11:11:56 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Aurelien DESBRIERES <aurelien@hackers.camp>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [RFC PATCH 0/10] ftrfs: Fault-Tolerant Radiation-Robust
 Filesystem
Message-ID: <20260413181156.GY6202@frogsfrogsfrogs>
References: <20260413142357.515792-1-aurelien@hackers.camp>
 <ad0GX6gVgHxD9-ym@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad0GX6gVgHxD9-ym@casper.infradead.org>

On Mon, Apr 13, 2026 at 04:06:07PM +0100, Matthew Wilcox wrote:
> On Mon, Apr 13, 2026 at 04:23:46PM +0200, Aurelien DESBRIERES wrote:
> > FTRFS was originally described in:
> > 
> >   Fuchs, C.M., Langer, M., Trinitis, C. (2015).
> >   FTRFS: A Fault-Tolerant Radiation-Robust Filesystem for Space Use.
> >   ARCS 2015, LNCS vol 9017, Springer.
> >   https://doi.org/10.1007/978-3-319-16086-3_8
> 
> Might be nice to link to a non-paywalled copy of that paper, eg:
> 
> https://www.cfuchs.net/chris/publication-list/ARCS2015/FTRFS.pdf
> 
> > This implementation is an independent open-source realization of the
> > concepts described in that paper, developed for the Linux kernel.
> 
> Can I ask why?  Is the original code not available or too ugly?
> 
> > On-disk layout:
> > 
> >   Block 0        : superblock (magic 0x46545246, CRC32-protected)
> >   Block 1..N     : inode table (128 bytes/inode, CRC32 per inode)
> >   Block N+1..end : data blocks (CRC32 + RS FEC per block)
> > 
> > Inodes use direct addressing (12 direct block pointers) plus single
> > and double indirection. Directory entries are fixed-size (268 bytes)
> > stored in direct blocks.
> 
> This is very old-school.  That may be appropriate for the intended
> use-case, but it ignores about five decades of filesystem research.

Why not add FEC to btrfs instead?  Then you can concentrate on getting
the IO paths correct, instead of burning time on ensuring that you've
implemented all the other posix filesystemisms correctly.

--D
