Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF6F3FF1
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063023; cv=none; b=gjXHLwb3oGYsDXcEKshUL4JuSqW3jGtrs2fPvGktnbGUT0cB2VyD/gCv2sWolDDA2Cy/YPjbVmniQGn+l34NG/ENbO8ZFXBh9cdMmB7eAvwhCBadTcoNhSXlcrX7dsbVL2CdyV2oqmPplg9rv6twbdQUokHHJadZJDrkGcgUqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063023; c=relaxed/simple;
	bh=ZNTVFvLTXB9IKOsC/LWkbn0heigc7pEu5Cm3woHIFAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFNlSxWY97jN8GSJLCUq1QlahnM51LS8qVp4h1NIifupdp3a441MRc9JaLjlcGRrz4/BqRaH+ku6zxDZAr8+4Oz60/C3VNagkQ05qEpal1jiMOIqNSFm6h1r1f+o2G9ERQaNdL/N3NWreCLcgf8wNWeU6xSXThauLh+1EHUKxok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L/DdteCV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L/DdteCV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qH3z5iUzVvZ7eQ1LIS6ee4DByg6ePM6iQvvwhi7vu4E=; b=L/DdteCVl4rWYQrVaHS2qjpE1k
	DFAF9dV8BVN2p3EW53JLTvMFK1ylZHhMfFFukfhl2TDFQUluu+f+szrO3FjcdrBGZ5KtLddFCuIwj
	TsYTJAXr0gNSfcHUAkTDqMnxFNRoVmlorcaitF6bJl+vkgbqdjlQm+t4DAGCuq1heyDlx8nb3gJAL
	Zgcu4zoenvvJa9ZqpW8rhfA9CMd1J44Sgj48i2uKGkFOvk7iHVBG5gqOKaTq75XD9D9NzGjE1tMoQ
	mx8PAGgmOh4aEqMqVQ+nYlPOIyu2V7RBJIKr8ZmesGrI+avwBiBYpYkuDy/hR/ciM/yKoO8SWAJFp
	AjpM5+2A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSxhq-00000007Tnt-2eLz;
	Fri, 29 May 2026 13:56:58 +0000
Date: Fri, 29 May 2026 06:56:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: Re: Moving quota and ustat() to holder ops
Message-ID: <ahmbKhqEBX7ij1_G@infradead.org>
References: <fkr53hbpfdqvwkyrywcixxwgk5egbdb2jzgktraomq6gxpn476@a337awzsoroj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fkr53hbpfdqvwkyrywcixxwgk5egbdb2jzgktraomq6gxpn476@a337awzsoroj>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 29, 2026 at 09:32:39AM +0200, Christian Brauner wrote:
> (1) two new methods (stat(), quota())
> (2) a flag indicating that this block device is held by a filesystem/superblock
> (3) matching on bdev->bd_holder_ops == &fs_holder_ops
> (4) a single new method that returns the super_block with a passive reference count
> 
> All kinda work. (3) is the easiest one but if we have filesystems that
> want custom holder operations it breaks and invalidates (3). So I kinda
> don't want to do that.

2 and 3 are a bit too ugly.  For is nice an generic, but I worry a bit
that will lead people to do stupid things with it, leaving 1 by
exclusion.  Which doesn't make me too happy as both ustat and the old
by bdev quotactl are legacy APIs that we should not worry about.

So as far as I'm concerned all this seems like a lot of effort to
kill user_get_user for not a lot of benefit.  What about maybe
just using iterate_super to find the right sb in ustat and quotact
and call it a day?

