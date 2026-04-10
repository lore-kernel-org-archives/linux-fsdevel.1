Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264A937FF7A
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Apr 2026 11:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775819301; cv=none; b=bNJnO2RTld7xrUo/mSiapXO7k9VD9Tho3ZbhyzMwEbEwoJ+DKzKSQUs1UhEQCQfNM1OLkADqY9rMHuAceBx/HXDLcOOmFFQVnlh+I1bYW1dReLlWNI8otq8igvAt9kEmPW548D8/yRsDzGqJtM8rhFg8i50dyHz3qJDVqHpWsw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775819301; c=relaxed/simple;
	bh=Xfolxi+7/hMRQt796KFXCq5D6rc+fb5WDqG6Z/g/CCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAAl95uBynadi2PrtGBrwOCxkVWE7tCDvXj3dxE6yCQ5FqCek0SkIjqCUrvkoYZDYQGAWdxuWB3Tre7nYckHPn4kRBWW6MhuVNCdhVozG1l3IlIWzpoE9BT4q6YxPipEmg6EkBmCQC0zl+YTUL27gDvPVX/AABDooGt+fQsV/1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=knWOB3VA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="knWOB3VA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Xk3li1I24xXhjUCjfH0QaipKwS9GLoq65H2d0oESdI8=; b=knWOB3VAByYCcpkF0lENzRH+ip
	aVuP52BPDwBNuQU1+PdpEGH/ldK009CzPSvk4lJ56usBnn6Q0VM5vASn5ZD1XcsRCaViYFS0c8/Ha
	qbattmUm28AM+8E6/CqlHMZls9hRiZpCMyhvEpQKWvzSsZW3nF17zVYMn5oHrziyAzKbfmju37qZO
	O8MYZTwLVdLCIApCjzDAJ/eLj6Ri3D/BPckKbCuMQQ9GZPRDax9xQbAEDYRbQCeG0wBZ8v/vXFbhn
	Y/03kH+Ez0v5Ms4FAYkAhUGmZmCBNnR0nl4MUutiOf9IOAQHUK5cypEjM0/PGmxDRSovwOFFhhC+7
	ko9qzmoA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB9ig-0000000C3jL-3MIo;
	Fri, 10 Apr 2026 11:08:14 +0000
Date: Fri, 10 Apr 2026 04:08:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Boris Burkov <boris@bur.io>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Filesystem inode reclaim
Message-ID: <adjaHn7RnvaMp7mc@infradead.org>
References: <m5v2s4fc6od2y2en5m62sr6fx57fdkhtqrn2kv47ngpcb65ump@4cfu4os3x5yy>
 <CAOQ4uxgYYt8LQqR+feSwqGccqD7Ns3sNgiVHw76mYsbKSwq5ng@mail.gmail.com>
 <20260409164834.GA3472346@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409164834.GA3472346@zen.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Apr 09, 2026 at 09:48:34AM -0700, Boris Burkov wrote:
> > > This way, kswapd / direct reclaim doesn't wait for hard to reclaim inodes
> > > and they can work on freeing memory needed for freeing of hard to reclaim
> > > inodes. So warnings about GFP_NOFAIL allocations aren't only papered over,
> > > they should really be addressed.
> 
> One question that pops in my mind (which is similar to an issue you and
> Qu debugged with the btrfs metadata reclaim floor earlier this year) is:
> what if the hard to reclaim inodes are the *only* source of significant 
> reclaimable space?

(disk)space or memory?  If this about disk space, make sure your file
system ENOSPC handling triggers inode reclaim, XFS already does it.

If it is the only source of memory we just need to do the slow reclaim
to gain memory.  You better use mempools or similar to make it safe.

