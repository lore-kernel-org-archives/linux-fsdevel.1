Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89817238C16
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Feb 2026 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771481512; cv=none; b=F0QV5/pMv2bjSsIfredi6VNMXsGcM5fgxKg0G4B5B1V1asUdlXXF+7KSp3N7LNylFzK6eF9sAZMzW8H3MKl5G02VsE7Jdenn2/dA5VLRLSqTwFjfbWdTmp+mh6znA66KhaG0KKgZQFEO5kKhn9tf/625VsHsHK4a1fo2IuzRSUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771481512; c=relaxed/simple;
	bh=IbregffE1tO7GaKKVQH3gdCK7brdUY5iBn65E5i866E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUB3V01A5imOCeRCEgDPxbAK7fGSt4y365co3FYvr7MqsamUTYQpFtkMH+wpK23fKnvdRnRJcJQ/PCsIchrZLEPO9S+rEONv6DzdoWiiGxuD7qmySNAkclUEyF8syfkIbFM5Qka6fxhMCstEJWvG+wbW7vb6Uu65+e684rQJRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=swuyCfzo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="swuyCfzo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pn/5kuMbiMiJoVY3TwQnsbo3vyJ9HdzmvBaOYZtcDLk=; b=swuyCfzoKkYTDC7hRAYdXwgCpE
	MWkoaiot24PlEcRBKGQ+wN4p8SfRiTTyZr7sV8ZXUq4IwCtvmh0uiL+5FUeyiAe+GgpHAc+hd7BI/
	LS9FgnKnFlxxhV1tmGDT89HtMmNfJswyCQgoJMg+mGXnBZVKkVxpcJSuGZs/sUJYKcbvPVOAZiFm3
	4r2FxOcA+PAG0Zo9ejIdI1gpOfDCorAlZeuyTGQiR/ruCo50HOmiwYIV+nIpCMwQrdTrxNbKbkIH9
	iCSVEv49EWT1mZqC3CL2WlgiYBHhypBcN4gggJYIeLvxv9xlTbqjZyJKSj8u8Rjy9/99MuyJE6ekp
	CIug6xaw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vsxGQ-0000000AwgJ-1KVo;
	Thu, 19 Feb 2026 06:11:50 +0000
Date: Wed, 18 Feb 2026 22:11:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	wegao@suse.com, sashal@kernel.org, hch@infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] iomap: don't mark folio uptodate if read IO has
 bytes pending
Message-ID: <aZappsypneoLixu-@infradead.org>
References: <20260219003911.344478-1-joannelkoong@gmail.com>
 <20260219003911.344478-2-joannelkoong@gmail.com>
 <20260219024534.GN6467@frogsfrogsfrogs>
 <aZaQO0jQaZXakwOA@casper.infradead.org>
 <20260219061101.GO6467@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219061101.GO6467@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Feb 18, 2026 at 10:11:01PM -0800, Darrick J. Wong wrote:
> > This isn't "the xor thing has come back to bite us".  This is "the iomap
> > code is now too complicated and I cannot figure out how to explain to
> > Joanne that there's really a simple way to do this".
> > 
> > I'm going to have to set aside my current projects and redo the iomap
> > readahead/read_folio code myself, aren't I?
> 
> Well you could try explaining to me what that simpler way is?
> 
> /me gets the sense he's missing a discussion somewhere...

Same.

