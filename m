Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0008D33F5A7;
	Tue, 31 Mar 2026 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774970463; cv=none; b=a7AwtEOskDxD7K1omIyeqMSAAV7wS9JB3HTqqngvdqv2sGJyBFxLDb9wCyYkmSBUBSuwvUq+yGiKMEHP6jsu74M9npxJZ2ynx89weLt85RNnH7OQDeRhvj0FEy4uDtyw4C9RiN5WJt96mCEfTO3aII7v7hS5qlZSqWrVJa4fRM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774970463; c=relaxed/simple;
	bh=ZYCz0ilhyNLwMdvfOqy85mXytGoiT+XQ8ZV3IsSvqps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MizLukGnXfMa1JS5vqH52E5dxQ7oSIVvAcxT8Lp78noO6NBjlR6GoRKRT5pNZON4u9TqH0i0coVQQZd1iBW/jdqjD+oY/gRoPLvbyMU/UHZ1G7z+WhT+7b24e8Lp9Y36oP96tsmSyxgbDRX9wCZcpjKKjcf7/os0OQcsUs7/tVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q2m9wBuk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q2m9wBuk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H5FWo7lctBFIU9r+G4o3TFkcH9FJrQFXjZgc9gbZO4M=; b=Q2m9wBukFPi7irGT4Age/W/+zo
	ZiZ5t6kYy6XBWwAbCNYjiazv/tf42dkjPg2L61LNY5b7GBYW30rPOE7H5gdZ4sOFROv7fy+useyXB
	Lkpi4fySpDvOLMlrV5l/Cz2VfpahCCDVfNFuCmNU1yeZfP4Xf2Ncp6Nbm04WhSol5H5pKfW94Yqr2
	X/eA2LP6Gp1kFbvHuThpmrbjVzNWzzJ8aMSE4uvBROgD8odtTVQf/lCNQmu3yqBE5WKHDOsxFRy0b
	UdRZV6p3EMOe+NoFeAKloPr3VkXY88E9Fb1d9mFRRKwBATD+mLlW/pcJKt5cdJJoOrcHfgm95lLBr
	hsuHLBug==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7ato-0000000DAXt-1Z7x;
	Tue, 31 Mar 2026 15:21:00 +0000
Date: Tue, 31 Mar 2026 08:21:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Deepanshu Kartikey <kartikey406@gmail.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+d31a3b77e5cba96b9f69@syzkaller.appspotmail.com
Subject: Re: [PATCH] splice: prevent deadlock when splicing a file to itself
Message-ID: <acvmXDBm1xOak_Uq@infradead.org>
References: <20260320130615.1109449-1-kartikey406@gmail.com>
 <acvkAuq4_cWmegC7@infradead.org>
 <fa551c4c-7e9b-47b4-9011-92adc880ed1a@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa551c4c-7e9b-47b4-9011-92adc880ed1a@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Mar 31, 2026 at 09:15:07AM -0600, Jens Axboe wrote:
> On 3/31/26 9:10 AM, Christoph Hellwig wrote:
> > On Fri, Mar 20, 2026 at 06:36:15PM +0530, Deepanshu Kartikey wrote:
> >> Fix this by checking if the input and output files share the
> >> same inode before proceeding, returning -EINVAL if they do.
> >> This mirrors the existing check in do_splice() for the
> >> pipe-to-pipe case where ipipe == opipe.
> > 
> > While restricting splice to be between difference inodes sounds like a
> > nice simplification, I'm not sure we can add it 20 years after the
> > syscall was added.
> 
> Well if we could break splice all over with:
> 
> 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")

Well, that had an easy way out by converting instances people actually
used to the iter ops.  Which we ended up doing for a few.

> then surely this one would be OK too?

While this has no way out.  Not that I would complain if it worked,
but splicing into the same file doesn't seem like a too outlandish
idea.  OTOH it probably already didn't work for file systems that
take i_rwsem in the read path like XFS or these days the block
device node.

